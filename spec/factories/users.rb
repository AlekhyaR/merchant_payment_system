require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    association :merchant
  end
end
