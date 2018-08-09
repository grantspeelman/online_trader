# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  to_create(&:save)

  sequence :firstname do |n|
    names = %w[Jacob Sophia Mason Isabella William Emma Jayden Olivia Noah Ava Michael Emily Ethan Abigail
               Alexander Madison Aiden Mia Daniel Chloe Grant Kim Adam Leah]
    n < names.size ? names[n] : names.sample
  end

  sequence :lastname do |n|
    names = %w[Martin Bernard Dubois Thomas Robert Richard Petit Durand Leroy Moreau Simon Laurent Lefebvre Michel
               Garcia David Bertrand Roux VincentFournier Speelman Petersen Petersen-Speelman]
    n < names.size ? names[n] : names.sample
  end

  factory :user, class: User do
    name {  "#{FactoryBot.generate(:firstname)} #{FactoryBot.generate(:lastname)}" }
    factory :user_billy do
      name 'Billy Bob'
    end
    factory :user_kim do
      name 'Kim Petersen'
    end
    factory :admin_grant do |u|
      u.name 'Grant Speelman'
    end
  end

  factory :auth, class: OAuthAuthentication do
    sequence(:provider_uid) { |n| "uid#{n}" }
    provider_name 'developer'

    association :user, factory: :user

    factory :auth_billy, class: OAuthAuthentication do
      provider_uid 'billy@email.com'

      association :user, factory: :user_billy
    end

    factory :auth_grant, class: OAuthAuthentication do
      provider_uid 'grant@email.com'

      association :user, factory: :admin_grant
    end
  end

  # factory :have do
  #   sequence(:card_name) { |n| "Card #{n}" }
  #
  #   transient do
  #     user_uid { create(:auth).uid }
  #   end
  #
  #   before(:create) do |have, evaluator|
  #     have.user = Authorization.first(uid: evaluator.user_uid).user
  #   end
  # end
  #
  # factory :want do
  #   sequence(:card_name) { |n| "Card #{n}" }
  #
  #   transient do
  #     user_uid { create(:auth).uid }
  #   end
  #
  #   before(:create) do |have, evaluator|
  #     have.user = Authorization.first(uid: evaluator.user_uid).user
  #   end
  # end
end
