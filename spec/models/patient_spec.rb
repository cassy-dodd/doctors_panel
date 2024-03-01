# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'validations' do
    it 'validates presence of first name' do
      patient = Patient.new(first_name: nil)
      expect(patient).not_to be_valid
    end

    it 'validates presence of last name' do
      patient = Patient.new(last_name: nil)
      expect(patient).not_to be_valid
    end

    it 'validates presence of email' do
      patient = Patient.new(email: nil)
      expect(patient).not_to be_valid
    end

    it 'validates uniqueness of email' do
      existing_patient = create(:patient)
      new_patient = Patient.new(email: existing_patient.email)
      expect(new_patient).not_to be_valid
    end
  end
end
