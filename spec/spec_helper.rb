# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.fixture_path                               = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures                 = false # If set to true it makes selenium + sqlite sad :(
  config.infer_base_class_for_anonymous_controllers = false

  config.before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    # Selenium hates http basic auth so this bit of horrible code
    # is my attempt to work around that.
    # I only do this for request specs
    if example.metadata[:type] == :request
      ApplicationController.class_eval do
        def authenticate_or_request_with_http_basic(realm = "Application", &login_procedure)
          user, pass = 'test', 'test'
          login_procedure.call([user, pass])
        end
      end
    end
  end

  config.after :each do
    DatabaseCleaner.clean
    Rails.cache.clear
  end

end
