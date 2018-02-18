require 'erb'
require 'yaml'
require 'sinatra/base'
require 'sprockets'
require 'sass'
require 'uglifier'
require 'hanami/helpers'
require 'hanami/assets'
require 'hanami/assets/helpers'
require 'rake'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'active_support'
require 'active_support/core_ext'
require 'lumberjack'
Dir["#{File.dirname(__FILE__)}/app/helpers/*.rb"].each{|file|require file}
Dir["#{File.dirname(__FILE__)}/app/models/*.rb"].each{|file|require file}
Dir["#{File.dirname(__FILE__)}/app/controllers/*.rb"].each{|file|require file}
Dir["#{File.dirname(__FILE__)}/config/*.rb"].each{|file|require file}

class ApplicationController < Sinatra::Base
    # Set views, templates and partials
    set :views, ->{"#{File.dirname(__FILE__)}/app/views"}

    # Set default ERB template
    set :erb, layout: :'templates/layout'

    # Set logger variables
    %i[test production development].each do |env|
        configure env do
            set :logger, ->{Lumberjack::Logger.new("logs/#{env}.log")}
        end
    end

    # Prepare YAML data accessors
    class StaticData
        @all_files = Dir.entries('./app/yaml').select{|f|!File.directory?(f)}
        @yml_files = @all_files.select{|f|f.end_with?('.yml','.yaml')}
        @yml_files.map{|f|{name: File.basename(f,'.*'),ext: File.extname(f)}}.each do |f|
            if /[@$"]/ !~ f[:name].to_sym.inspect
                define_method(f[:name].to_sym){YAML.load_file "./app/yaml/#{f[:name]+f[:ext]}"}
            else
                raise NameError.new("YAML file name '#{f[:name]}' must be a valid Ruby method name.")
            end
        end
    end
    set :app_data, StaticData.new
    define_method(:data){settings.app_data}

    # Prepare asset pipeline
    set :environment, Sprockets::Environment.new
    environment.append_path './app/assets/stylesheets'
    environment.append_path './app/assets/scripts'
    environment.append_path './app/assets/images'
    environment.append_path './app/assets/fonts'
    environment.css_compressor = :scss
    environment.js_compressor = :uglify
    get '/assets/*' do
        env["PATH_INFO"].sub!('/assets','')
        settings.environment.call(env)
    end

    # Application manifest file accessor method
    def application(*args)
        html = String.new
        css_syms = %i[css stylesheet]
        js_syms = %i[js javascript]
        args.map(&:to_sym).each do |arg|
            html << stylesheet('application') if css_syms.include? arg
            html << javascript('application') if js_syms.include? arg
        end
        html
    rescue
        raise ArgumentError.new("Expected arguments to be any of: #{css_syms+js_syms}")
    end
end