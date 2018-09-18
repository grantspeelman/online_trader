# frozen_string_literal: true

class Want < Sequel::Model
  many_to_one :user

  plugin :defaults_setter
  default_values[:amount] = 1

  plugin :validation_helpers
  def validate
    super
    validates_presence %i[name]
    validates_unique([:name, :user_id])
    validates_integer :amount
    validates_operator(:>, 0, :amount)  if errors[:amount].empty?
  end

  def save_if_valid
    valid? && save
  end

  def haves
    Have.exclude(user_id: user_id).where(name: name)
  end

  def have_count
    haves.count
  end
end
