# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/poltergeist'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  case ENV["CAPYBARA_DRIVER"]
    when 'poltergeist'
      Capybara.default_driver = :poltergeist
    when 'selenium'
      Capybara.default_driver = :selenium
  end

  config.include FactoryGirl::Syntax::Methods

  # Clean up the database
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "datamapper"
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

end
