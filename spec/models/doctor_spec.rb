# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Doctor, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      doctor = Doctor.new(name: nil)
      expect(doctor).not_to be_valid
    end

    it 'validates presence of email' do
      doctor = Doctor.new(email: nil)
      expect(doctor).not_to be_valid
    end

    it 'validates uniqueness of email' do
      existing_doctor = create(:doctor)
      new_doctor = Doctor.new(email: existing_doctor.email)
      expect(new_doctor).not_to be_valid
    end

    it 'validates presence of password_digest' do
      doctor = Doctor.new(password_digest: nil)
      expect(doctor).not_to be_valid
    end
  end
end
