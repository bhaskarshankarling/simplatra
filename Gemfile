# Gemset directive
source 'https://rubygems.org'

# Ruby version
ruby '2.5.0'

# Rake for application setup, file generation tasks and migrations
gem 'rake'

# Sinatra
gem 'sinatra'

# Asset pipeline and preprocessors
gem 'sprockets'
gem 'sass'

# Hanami HTML/asset helpers
gem 'hanami-helpers'
gem 'hanami-assets'

# ActiveRecord for models and records
gem 'activerecord'
gem 'sinatra-activerecord'

group :development, :test do
    gem 'sqlite3'
    gem 'rack-test'
    gem 'rspec'
    gem 'rspec-core'
    gem 'shoulda-matchers'
end

group :production do
    gem 'pg', '~> 0.20'
    gem 'newrelic_rpm'
end