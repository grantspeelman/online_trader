require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://rubygems.org'
gem 'rails', '3.1.3'
gem 'devise'
# gem 'bson_ext'
gem 'mongoid'
gem 'simple_form'

group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end
group :development do
  gem 'rails-footnotes'
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

