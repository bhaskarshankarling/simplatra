require 'rack/test'
require 'rspec'
require 'shoulda-matchers'
require './app'
ENV['RACK_ENV'] = 'test'
Shoulda::Matchers.configure do |config|
    config.integrate do |with|
        with.test_framework :rspec
        with.library :active_record
        with.library :active_model
    end
end
RSpec.configure do |c|
    c.include Rack::Test::Methods
    c.include(Shoulda::Matchers::ActiveModel, type: :model)
    c.include(Shoulda::Matchers::ActiveRecord, type: :model)
end