require 'bundler'
Bundler.require :default

$DIR = File.dirname(__FILE__)
Dir["#$DIR/config/*.rb"].each{|file|require file}
Dir["#$DIR/app/helpers/*.rb"].each{|file|require file}
Dir["#$DIR/app/models/*.rb"].each{|file|require file}
Dir["#$DIR/app/controllers/*.rb"].each{|file|require file}

class ApplicationController < Sinatra::Base
    # Set views, templates and partials
    set :views, ->{"#$DIR/app/views"}

    # Set default ERB template
    set :erb, layout: :'templates/layout'

    # Set logger variables
    %i[test production development].each do |env|
        configure env do
            set :logger, ->{Lumberjack::Logger.new("log/#{env}.log")}
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
    set :static, StaticData.new
    define_method(:data){settings.static}

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