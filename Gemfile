# Gemset directive
source 'https://rubygems.org'

# Ruby version
ruby '2.5.0'

# Sinatra
gem 'sinatra', '~> 2.0'

# Asset pipeline and preprocessors
gem 'sprockets', '~> 3.7'
gem 'sass', '~> 3.5'

# Hanami HTML/asset helpers
gem 'hanami-helpers', '~> 1.1.1'
gem 'hanami-assets', '~> 1.1.0'

# Development database adapter
group :development do
    gem 'sqlite3', '~> 1.3.13'
end
# Production database adapter
group :production do
    gem 'pg', '~> 0.21.0'
end

# Rake for database migrations
gem 'rake', '~> 12.3.0'

# ActiveRecord for models and databases
gem 'activerecord', '~> 5.1.4'
gem 'sinatra-activerecord', '~> 2.0.13'
