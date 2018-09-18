# frozen_string_literal: true

Sequel::Model.db.extension(:pagination)

class Sequel::Plugins::ActiveModel::Errors
  alias :full_messages_for :[]
end