# Gemset directive
source 'https://rubygems.org'

# Ruby version
ruby '2.5.0'

# Bundler
gem 'bundler'

# Rake for application setup, file generation tasks and migrations
gem 'rake'

# Sinatra
gem 'sinatra', require: 'sinatra/base'

# Asset pipeline and preprocessors/compressors
gem 'sprockets'
gem 'sass'
gem 'uglifier'

# Hanami HTML/asset helpers
gem 'hanami-helpers', require: 'hanami/helpers'
gem 'hanami-assets', require: ['hanami/assets','hanami/assets/helpers']

# ActiveRecord for models and records
gem 'activerecord', require: ['active_support','active_support/core_ext']
gem 'sinatra-activerecord', require: ['sinatra/activerecord','sinatra/activerecord/rake']

# Logging
gem 'lumberjack'

group :development, :test do
    gem 'sqlite3'
    gem 'rack-test', require: 'rack/test'
    gem 'rspec'
    gem 'shoulda-matchers'
end

group :production do
    gem 'pg'
end