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
  config.use_transactional_fixtures                 = true
  config.infer_base_class_for_anonymous_controllers = false

  config.before :each do
    port = page.driver.rack_server.port
    Capybara.app_host = "http://test:test@127.0.0.1:#{ port }"
  end

end
