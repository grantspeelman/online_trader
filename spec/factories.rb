require 'factory_girl'

FactoryGirl.define do

  factory :user_billy, :class => User do |u|
      u.name 'Billy Bob'
  end

  factory :auth_billy, :class => Authorization do |a|
    a.uid '11111'
    a.provider 'twitter'
    association :user, :factory => :user_billy
  end

  factory :user_kim, :class => User do |u|
      u.name 'Kim Petersen'
  end

  factory :admin_grant, :class => User do |u|
      u.name 'Admin Grant'
      u.role 'admin'
  end

  factory :auth_grant, :class => Authorization do |a|
    a.uid '22222'
    a.provider 'facebook'
    association :user, :factory => :admin_grant
  end



end

