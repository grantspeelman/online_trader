# frozen_string_literal: true

class Have < Sequel::Model
  many_to_one :user

  plugin :active_model

  plugin :attribute_type_cast
  attribute_type_cast :name, TradableName
  attribute_type_cast :amount, TradableAmount

  plugin :defaults_setter
  default_values[:amount] = 1

  include ValidatesNonExceptional
  plugin :validation_helpers
  def validate
    super
    validates_presence %i[name amount]
    validates_non_exceptional %i[name amount]
    validates_unique(%i[name user_id])
  end

  def save_if_valid
    valid? && save
  end

  def wants
    Want.exclude(user_id: user_id).where(name: name)
  end

  def want_count
    wants.count
  end
end
