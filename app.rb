require 'sinatra'
require 'sprockets'
require 'sass'
require 'hanami/helpers'
require 'hanami/assets'
require 'hanami/assets/helpers'
require 'rake'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
Dir[File.dirname(__FILE__)+'/app/**/*.rb'].each{|f|require f}
Dir[File.dirname(__FILE__)+'/config/*.rb'].each{|f|require f}

class Application < Sinatra::Base
    # Set views, templates and partials
    set :views, Proc.new {File.dirname(__FILE__)+'/app/views'}

    # Set database configuration file
    set :database, 'config/database.yml'

    # Include HTML/ERB helpers
    include Hanami::Helpers
    include Hanami::Assets::Helpers

    # Include partial and other helpers
    include Application::Helpers

    # Prepare YAML data accessors
    include ApplicationData::Helpers
    set :app_data, ApplicationData.new

    # Prepare asset pipeline
    set :environment, Sprockets::Environment.new
    Assets.set_paths environment
    get "/assets/*" do
        env["PATH_INFO"].sub!("/assets", "")
        settings.environment.call(env)
    end
end