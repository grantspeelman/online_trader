# frozen_string_literal: true

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

if ENV['RAILS_ENV'] == 'test' && %w(1 yes on enabled).include?(ENV['COVERAGE'])
  require 'simplecov'
  SimpleCov.start 'cypress'
end