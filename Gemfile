require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://rubygems.org'
gem 'rails', '3.1.3'
gem 'omniauth'
gem 'oa-openid'
gem 'bson_ext'
gem 'mongoid'
gem 'twitter_bootstrap_form_for'
gem 'jquery-rails'
gem 'cancan'
gem 'kaminari'
# gem 'thin'

group :assets do
  gem 'uglifier'
  gem 'coffee-rails'
  gem 'sass-rails'
end
group :development, :test do
  gem 'capybara'
  gem 'rspec-rails'
end
group  :test do
  gem 'database_cleaner'
  gem 'mongoid-rspec'
  gem 'factory_girl_rails'
end

if HOST_OS =~ /linux/i
  gem 'therubyracer', '>= 0.9.8'
end

