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
               Garcia David Bertrand Roux Vincent Fournier Speelman Petersen Petersen-Speelman]
    n < names.size ? names[n] : names.sample
  end

  factory :user, class: User do
    name { "#{FactoryBot.generate(:firstname)} #{FactoryBot.generate(:lastname)}" }
    factory :user_billy do
      name 'Billy Bob'
      after(:create) do |user, _evaluator|
        OAuthAuthentication.create_from_hash({ uid: 'billy@email.com', provider: 'developer' },
                                             user)
      end
    end
    factory :user_kim do
      name 'Kim Petersen'
      after(:create) do |user, _evaluator|
        OAuthAuthentication.create_from_hash({ uid: 'kim@email.com', provider: 'developer' },
                                             user)
      end
    end
    factory :admin_grant do |u|
      u.name 'Grant Speelman'
      after(:create) do |user, _evaluator|
        OAuthAuthentication.create_from_hash({ uid: 'grant@email.com', provider: 'developer' },
                                             user)
      end
    end
  end

  factory :auth, class: OAuthAuthentication do
    sequence(:provider_uid) { |n| "uid#{n}" }
    provider_name 'developer'

    association :user, factory: :user
  end

  factory :have do
    sequence(:name) { |n| "Card #{n}" }
    amount { rand(1..10) }

    transient do
      user_id { nil }
      user_uid { nil }
    end

    before(:create) do |have, evaluator|
      have.user = User[evaluator.user_id] if evaluator.user_id
      have.user = OAuthAuthentication.first(provider_uid: evaluator.user_uid).user if evaluator.user_uid
      have.user = create(:auth).user unless have.user
    end
  end

  factory :want do
    sequence(:name) { |n| "Card #{n}" }
    amount { rand(1..10) }

    transient do
      user_id { nil }
      user_uid { nil }
    end

    before(:create) do |want, evaluator|
      want.user = User[evaluator.user_id] if evaluator.user_id
      want.user = OAuthAuthentication.first(provider_uid: evaluator.user_uid).user if evaluator.user_uid
      want.user = create(:auth).user unless want.user
    end
  end
end
