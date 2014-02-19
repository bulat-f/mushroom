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

  factory :course do
    sequence(:title) { |n| "Course number #{n}" }
    subject "programming"
    hours 10
    description "Hello World!!! bla-bla-bla"
    price 800
    tutor_id 1  
  end
end
