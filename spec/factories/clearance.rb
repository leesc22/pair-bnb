FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
  	name "example"
    email
    password "password"
  end

  factory :user1, class:User do
  	name "David Lim"
  	email "david@example.com"
  	password "david1"
  end
end
