# frozen_string_literal: true

class Have < Sequel::Model
  many_to_one :user

  plugin :validation_helpers
  def validate
    super
    validates_presence %i[name]
    validates_unique :name, scope: :user_id
    validates_integer :amount
    validates_operator(:>, 0, :amount) if errors[:amount].empty?
  end

  def save_if_valid
    valid? && save
  end

  def by_card_name(name)
    all(card_name: name)
  end

  def card
    Card.by_name(card_name).first
  end

  def wants
    ['TODO']
    # @wants ||= Want.all(card_name: card_name)
  end

  def want_count
    wants.count
  end
end
