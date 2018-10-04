# frozen_string_literal: true
if defined?(Sequel)
  Rails.application.configure do
    config.sequel.schema_format = :sql
    config.sequel.schema_dump = Rails.env.development?
    config.sequel.max_connections = ENV.fetch('RAILS_MAX_THREADS') { 5 }.to_i + 1
  end

  Sequel::Model.db.extension(:pagination)

  require 'sequel/plugins/active_model'
  class Sequel::Plugins::ActiveModel::Errors
    alias :full_messages_for :[]
  end
end