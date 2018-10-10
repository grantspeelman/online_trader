# frozen_string_literal: true

ruby '2.5.1'

require 'rbconfig'
source 'http://rubygems.org'
gem 'pundit'
gem 'jquery-rails'
gem 'omniauth', '~> 1.0'
gem 'pg'
gem 'puma'
gem 'rails', '~> 5.2.0'
gem 'rake'
gem 'sequel-rails', require: ENV['NO_DB_CONNECT'] != '1'
gem 'sequel_postgresql_triggers', require: ENV['NO_DB_CONNECT'] != '1'
gem 'sequel_pg', require: false
gem 'simple_form'

gem 'uglifier', '>= 1.0.3', require: false

group :development, :test do
  gem 'byebug'
  gem 'factory_bot'
  gem 'rspec-rails'
  gem 'listen'
end

group :test do
  gem 'cypress-on-rails', '~> 1.0'
  gem 'database_cleaner', '~> 1.0'
  gem 'simplecov', require: false
end
