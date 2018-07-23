# frozen_string_literal: true

require 'factory_girl'

FactoryGirl.define do
  to_create do |instance|
    raise "Save failed for #{instance.class}: #{instance.errors.full_messages.inspect}" unless instance.save
  end

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

  factory :user do
    name {  "#{FactoryGirl.generate(:firstname)} #{FactoryGirl.generate(:lastname)}" }
    factory :user_billy do
      name 'Billy Bob'
    end
    factory :user_kim do
      name 'Kim Petersen'
    end
    factory :admin_grant do |u|
      u.name 'Grant Speelman'
      u.role 'admin'
    end
  end

  factory :auth, class: Authorization do
    sequence(:uid) { |n| "uid#{n}" }
    provider 'developer'

    factory :auth_billy, class: Authorization do
      uid 'billy@email.com'

      association :user, factory: :user_billy
    end

    factory :auth_grant, class: Authorization do
      uid 'grant@email.com'

      association :user, factory: :admin_grant
    end
  end

  factory :have do
    sequence(:card_name) { |n| "Card #{n}" }

    transient do
      user_uid ''
    end

    before(:create) do |have, evaluator|
      have.user = Authorization.first(uid: evaluator.user_uid).user
    end
  end

  factory :want do
    sequence(:card_name) { |n| "Card #{n}" }

    transient do
      user_uid ''
    end

    before(:create) do |have, evaluator|
      have.user = Authorization.first(uid: evaluator.user_uid).user
    end
  end
end
