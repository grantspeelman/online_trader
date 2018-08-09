# frozen_string_literal: true

require 'rbconfig'
source 'http://rubygems.org'
gem 'pundit'
gem 'jquery-rails', '~> 2.0'
gem 'omniauth', '~> 1.0'
gem 'pg'
gem 'puma'
gem 'rails', '~> 3.2.0'
gem 'rake', '~> 11.0'
gem 'sequel-rails'
gem 'sequel_pg', require: 'sequel'
gem 'sequel_postgresql_triggers'
gem 'simple_form', '~> 2.0' # limit by rails 3.2 version

group :assets do
  gem 'uglifier', '>= 1.0.3'
end
group :development, :test do
  gem 'byebug', '~> 8.2'
  gem 'factory_bot'
  gem 'rspec-rails'
  gem 'test-unit' # can maybe remove on later rails and rspec-rails versions
end
group :test do
  gem 'cypress-on-rails', '~> 1.0'
  gem 'database_cleaner', '~> 1.0'
  gem 'simplecov', require: false
end

gem 'therubyracer', '>= 0.9.8' # can maybe remove on later rails version
