require 'erb'
require 'yaml'
require 'sinatra/base'
require 'sprockets'
require 'sass'
require 'hanami/helpers'
require 'hanami/assets'
require 'hanami/assets/helpers'
require 'rake'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require 'active_support'
require 'active_support/core_ext'
require 'newrelic_rpm'
Dir["#{File.dirname(__FILE__)}/app/helpers/*.rb"].each{|file|require file}
Dir["#{File.dirname(__FILE__)}/app/models/*.rb"].each{|file|require file}
Dir["#{File.dirname(__FILE__)}/app/controllers/*.rb"].each{|file|require file}
Dir["#{File.dirname(__FILE__)}/config/*.rb"].each{|file|require file}

class ApplicationController < Sinatra::Base
    # Set views, templates and partials
    set :views, ->{"#{File.dirname(__FILE__)}/app/views"}

    # Prepare YAML data accessors
    class StaticData
        FILES = Dir.entries('./app/yaml').select{|f|!File.directory?(f)}
        YML_FILES = FILES.select{|f|f.end_with?('.yml','.yaml')}
        YML_FILES.map{|f|{name: File.basename(f,'.*'),ext: File.extname(f)}}.each do |f|
            if /[@$"]/ !~ f[:name].to_sym.inspect
                define_method f[:name].to_sym do YAML.load_file "./app/yaml/#{f[:name]+f[:ext]}" end
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
    get '/assets/*' do
        env["PATH_INFO"].sub!('/assets','')
        settings.environment.call(env)
    end
end