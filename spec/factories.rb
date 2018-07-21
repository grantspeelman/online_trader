require 'factory_girl'

FactoryGirl.define do
  to_create do |instance|
    if !instance.save
      raise "Save failed for #{instance.class}: #{instance.errors.full_messages.inspect}"
    end
  end

  sequence :firstname do |n|
    names = %W(Jacob Sophia Mason Isabella William Emma Jayden Olivia Noah Ava Michael Emily Ethan Abigail
               Alexander Madison Aiden Mia Daniel Chloe Grant Kim Adam Leah)
    n < names.size ? names[n] : names.sample
  end

  sequence :lastname do |n|
    names = %W(Martin Bernard Dubois Thomas Robert Richard Petit Durand Leroy Moreau Simon Laurent Lefebvre Michel
              Garcia David Bertrand Roux VincentFournier Speelman Petersen Petersen-Speelman)
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

  factory :auth_billy, :class => Authorization do |a|
    a.uid 'billy@email.com'
    a.provider 'developer'
    association :user, :factory => :user_billy
  end

  factory :auth_grant, :class => Authorization do |a|
    a.uid 'grant@email.com'
    a.provider 'developer'
    association :user, :factory => :admin_grant
  end

  factory :auth, :class => Authorization do |a|
    sequence(:uid){ |n| "uid#{n}" }
    a.provider 'developer'
    user
  end

  factory :have do
    sequence(:card_name){ |n| "Card #{n}" }

    transient do
      user_uid { create(:auth).uid }
    end

    before(:create) do |have, evaluator|
      have.user = Authorization.first(uid: evaluator.user_uid).user
    end
  end
end

