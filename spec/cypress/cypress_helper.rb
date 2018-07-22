# frozen_string_literal: true

# This is loaded once before the first command is executed
require 'database_cleaner'
require 'factory_girl'

require 'cypress_dev/smart_factory_wrapper'

CypressDev::SmartFactoryWrapper.configure(
  always_reload: !Rails.configuration.cache_classes,
  factory: FactoryGirl,
  files: Dir['./spec/factories.rb']
)
