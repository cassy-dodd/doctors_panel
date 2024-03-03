# frozen_string_literal: true

FactoryBot.define do
  factory :doctor do
    name { 'Test' }
    sequence(:email) { |n| "foo#{n}@bar.com" }
    indication { association :indication }
    password { 'password1234' }
  end
end
