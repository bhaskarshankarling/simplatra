$dir = File.dirname(__FILE__)

require 'bundler'
Bundler.require :default

Dir["#$dir/config/*.rb"].each{|file|require file}
Dir["#$dir/app/{helpers,models,controllers}/*.rb"].each{|file|require file}

class ApplicationController < Sinatra::Base
    # Set views, templates and partials
    set :views, "#$dir/app/views"

    # Set default ERB template
    set :erb, layout: :'templates/layout'

    # Set logger variables
    %i[test production development].each do |env|
        configure env do
            set :logger, Lumberjack::Logger.new("#$dir/log/#{env}.log")
        end
    end

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
end