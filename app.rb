require 'bundler'
Bundler.require :default
require_relative 'config/root'

Dir["#{Simplatra::ROOT}/config/*.rb"].each{|file|require file}
Dir["#{Simplatra::ROOT}/config/initializers/*.rb"].each{|file|require file}
Dir["#{Simplatra::ROOT}/app/{helpers,models,controllers}/*.rb"].each{|file|require file}

class ApplicationController < Sinatra::Base
    # Set server
    set :server, 'thin'

    # Set views, templates and partials directory
    set :views, "#{Simplatra::ROOT}/app/views"

    # Set default ERB template
    set :erb, layout: :'templates/layout'

    # Set logger variables
    %i[test production development].each do |env|
        configure env do
            set :logger, Lumberjack::Logger.new("#{Simplatra::ROOT}/log/#{env}.log")
        end
    end

    # Prepare asset pipeline
    set :environment, Sprockets::Environment.new
    environment.append_path "#{Simplatra::ROOT}/app/assets/stylesheets"
    environment.append_path "#{Simplatra::ROOT}/app/assets/scripts"
    environment.append_path "#{Simplatra::ROOT}/app/assets/images"
    environment.append_path "#{Simplatra::ROOT}/app/assets/fonts"
    environment.css_compressor = :scss
    environment.js_compressor = :uglify
    get '/assets/*' do
        env["PATH_INFO"].sub!('/assets','')
        settings.environment.call(env)
    end
end