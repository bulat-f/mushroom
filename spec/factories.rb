FactoryGirl.define do
  factory :user do
    sequence(:surname) { |n| "FamalyName#{n}" }
    sequence(:name)    { |n| "Person#{n}" }
    sequence(:email)   { |n| "person_#{n}@example.com" }
    sequence(:phone)   { |n| "+7965592#{1000 + n}" }
    password "foobartoo"
    password_confirmation "foobartoo"

    factory :tutor do
      tutor true
    end

    factory :admin do
      admin true
    end
  end
end
