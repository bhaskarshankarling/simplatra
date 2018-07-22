require 'bundler'
Bundler.require :default
require_relative 'config/root'

Dir[Simplatra.path('config', '*.rb')].each{|file|require file}
Dir[Simplatra.path('config', 'initializers', '*.rb')].each{|file|require file}
Dir[Simplatra.path('app', '{helpers,models,controllers}', '*.rb')].each{|file|require file}

class ApplicationController < Sinatra::Base
  # Set server
  set :server, %w[thin webrick]

  # Set core application file
  set :app_file, __FILE__

  # Set application root directory
  set :root, Simplatra::ROOT

  # Set views directory
  set :views, Simplatra.path('app', 'views')

  # Set default ERB template
  set :erb, layout: :'layouts/main'

  # Set logger variables
  %i[test production development].each do |env|
    configure env do
      set :logger, Lumberjack::Logger.new(Simplatra.path('log', "#{env}.log"))
    end
  end

  # Prepare asset pipeline
  set :environment, Sprockets::Environment.new
  environment.append_path Simplatra.path('app', 'assets', 'stylesheets')
  environment.append_path Simplatra.path('app', 'assets', 'scripts')
  environment.append_path Simplatra.path('app', 'assets', 'images')
  environment.append_path Simplatra.path('app', 'assets', 'fonts')
  environment.css_compressor = :scss
  environment.js_compressor = :uglify
  get '/assets/*' do
    env["PATH_INFO"].sub!('/assets','')
    settings.environment.call(env)
  end
end