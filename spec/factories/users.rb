require 'faker'
FactoryGirl.define do
  factory :user do
    name  Faker::Name.name
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    password 'password'
    phone_number Faker::Number.number(10)
    status 0
    password_confirmation 'password'
  end
end
