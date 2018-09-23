# frozen_string_literal: true

require 'rbconfig'
source 'http://rubygems.org'
gem 'pundit'
gem 'jquery-rails'
gem 'omniauth', '~> 1.0'
gem 'pg_jruby'
gem 'jdbc-postgres'
gem 'puma'
gem 'rails', '~> 4.1.0'
gem 'rake', '~> 11.0'
gem 'sequel-rails'
gem 'sequel_postgresql_triggers'
gem 'simple_form'

group :assets do
  gem 'uglifier', '>= 1.0.3'
end
group :development, :test do
  gem 'factory_bot'
  gem 'rspec-rails'
  gem 'test-unit' # can maybe remove on later rails and rspec-rails versions
end
group :test do
  gem 'cypress-on-rails', '~> 1.0'
  gem 'database_cleaner', '~> 1.0'
  gem 'simplecov', require: false
end
