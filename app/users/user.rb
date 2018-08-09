# frozen_string_literal: true

class User < Sequel::Model
  # has n, :authorizations
  # has n, :wants
  # has n, :haves, 'Have'
  one_to_many :authentications, class: OAuthAuthentication

  def authenticated_with(provider_name)
    authentications.count(provider_name: provider_name.to_s) > 0
  end

  def to_s
    name
  end

  def want_card_names
    ['TODO']
    # wants.collect(&:card_name)
  end

  def have_card_names
    ['TODO']
    # haves.collect(&:card_name)
  end

  def wants_for(user)
    ['TODO']
    # user.wants.all(card_name: have_card_names)
  end
end
