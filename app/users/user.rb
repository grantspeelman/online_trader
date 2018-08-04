# frozen_string_literal: true

class User < Sequel::Model
  # has n, :authorizations
  # has n, :wants
  # has n, :haves, 'Have'

  def authorized_with(provider)
    authorizations.all(provider: provider.to_s).count > 0
  end

  def to_s
    name
  end

  def want_card_names
    wants.collect(&:card_name)
  end

  def have_card_names
    haves.collect(&:card_name)
  end

  def wants_for(user)
    user.wants.all(card_name: have_card_names)
  end
end
