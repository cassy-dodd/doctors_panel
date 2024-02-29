# frozen_string_literal: true

FactoryBot.define do
  factory :doctor do
    name { 'Test' }
    email { 'foo@bar.com' }
    speciality { 'hair' }
    password { 'password1234' }
  end
end
