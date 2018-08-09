# frozen_string_literal: true

class Want < Sequel::Model
  many_to_one :user

  plugin :validation_helpers
  def validate
    super
    validates_presence %i[name]
    validates_unique :name, scope: :user_id
    validates_integer :amount
    validates_operator(:>=, 0, :amount)
  end

  def by_card_name(name)
    all(card_name: name)
  end

  def card
    Card.by_name(card_name).first
  end

  def haves
    ['TODO']
    # @haves ||= Have.all(card_name: card_name)
  end

  def have_count
    haves.count
  end
end
