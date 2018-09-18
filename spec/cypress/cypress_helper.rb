# frozen_string_literal: true

# This is loaded once before the first command is executed
require 'database_cleaner'
require 'factory_bot'

require 'cypress_dev/smart_factory_wrapper'

CypressDev::SmartFactoryWrapper.configure(
  always_reload: !Rails.configuration.cache_classes,
  factory: FactoryBot,
  files: Dir['./spec/factories.rb']
)
