source 'https://rubygems.org'
ruby '2.5.0'

gem 'sinatra', require: 'sinatra/base'
gem 'bundler'
gem 'thin'
gem 'rake'

# CLI and rake replacement
group :thor do
    gem 'thor', require: ['thor','thor/group']
end

# Database adapters
gem 'sqlite3', group: [:development, :test]
gem 'pg', group: :production

# ActiveRecord for models and records
gem 'activerecord', require: ['active_support','active_support/core_ext']
gem 'sinatra-activerecord', require: ['sinatra/activerecord','sinatra/activerecord/rake']

# Test environment
group :test do
    gem 'rack-test', require: 'rack/test'
    gem 'rspec'
    gem 'shoulda-matchers'
end

# Logging
gem 'lumberjack'

# Asset pipeline and preprocessors/compressors
gem 'sprockets'
gem 'sass'
gem 'uglifier'

# Hanami HTML/asset helpers
group :hanami do
    gem 'hanami-helpers', require: 'hanami/helpers'
    gem 'hanami-assets', require: ['hanami/assets','hanami/assets/helpers']
end

# Blogging environment
group :blog do
    gem 'front_matter_parser'
    gem 'rdiscount'
end

# For colorized rake messages
gem 'colorize'

# For constructing strings
gem 'string-builder', require: 'string/builder'