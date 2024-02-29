# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'faker'

INDICATIONS = %w[hair diabetes flu].freeze

10.times do
  Doctor.create(name: Faker::Name.unique.first_name, email: Faker::Internet.unique.email,
                speciality: INDICATIONS.sample, password: 'password1234', password_confirmation: 'password1234')
end
