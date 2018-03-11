# Gemset directive
source 'https://rubygems.org'

# Ruby version
ruby '2.5.0'

# Rake for application setup, file generation tasks and migrations
gem 'rake'

# Sinatra
gem 'sinatra'

# Asset pipeline and preprocessors/compressors
gem 'sprockets'
gem 'sass'
gem 'uglifier'

# Hanami HTML/asset helpers
gem 'hanami-helpers'
gem 'hanami-assets'

# ActiveRecord for models and records
gem 'activerecord'
gem 'sinatra-activerecord'

# Logging
gem 'lumberjack'

group :development, :test do
    gem 'sqlite3'
    gem 'rack-test'
    gem 'rspec'
    gem 'shoulda-matchers'
end

group :production do
    gem 'pg'
end