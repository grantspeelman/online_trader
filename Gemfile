require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://rubygems.org'
gem 'rails', '3.2.0'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google'
gem 'oa-openid'
gem 'bson_ext'
gem 'mongoid'
gem 'twitter_bootstrap_form_for'
gem 'jquery-rails'
gem 'cancan'
gem 'kaminari'
# gem 'thin'

group :assets do
  gem 'uglifier', '>= 1.0.3'
  gem 'sass-rails', '~> 3.2.3'
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

