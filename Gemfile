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

# Development database adapter
group :development do
    gem 'sqlite3'
end
# Production database adapter
group :production do
    gem 'pg'
end

# ActiveRecord for models and databases
gem 'activerecord'
gem 'sinatra-activerecord'

# NewRelic RPM for monitoring
gem 'newrelic_rpm'
