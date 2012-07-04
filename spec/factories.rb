require 'factory_girl'

FactoryGirl.define do

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
    a.uid '11111'
    a.provider 'twitter'
    association :user, :factory => :user_billy
  end

  factory :auth_grant, :class => Authorization do |a|
    a.uid '22222'
    a.provider 'facebook'
    association :user, :factory => :admin_grant
  end

end

