# frozen_string_literal: true
Sequel::Model.db.extension(:pagination)

require 'sequel/plugins/active_model'
class Sequel::Plugins::ActiveModel::Errors
  alias :full_messages_for :[]
end