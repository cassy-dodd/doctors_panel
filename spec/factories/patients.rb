# frozen_string_literal: true

FactoryBot.define do
  factory :patient do
    first_name { 'MyString' }
    last_name { 'MyString' }
    email { 'foobar2@bar.com' }
    doctor { nil }
    indication { association :indication }
  end
end
