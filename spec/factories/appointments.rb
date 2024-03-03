# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    doctor { association :doctor }
    patient { association :patient }
    scheduled_at { '2024-03-03 11:28:26' }
  end
end
