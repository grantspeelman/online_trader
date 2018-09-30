# frozen_string_literal: true

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

if ENV['RAILS_ENV'] == 'test' && %w[1 yes on enabled].include?(ENV['COVERAGE'])
  require 'simplecov'
  SimpleCov.start 'rails'
  SimpleCov.command_name 'cypress'
end
