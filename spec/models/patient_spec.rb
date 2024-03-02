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

  describe 'scopes' do
    let!(:indication_rash) { create(:indication, name: 'rash') }
    let!(:indication_diabetes) { create(:indication, name: 'diabetes') }
    let!(:indication_cough) { create(:indication, name: 'cough') }

    let!(:doctor) { create(:doctor) }

    let!(:patient1) { create(:patient, doctor: nil, indication: indication_rash) }
    let!(:patient2) { create(:patient, doctor: doctor, indication: indication_rash) }
    let!(:patient2) { create(:patient, doctor: doctor, indication: indication_cough) }
    let!(:patient3) { create(:patient, doctor: nil, indication: indication_diabetes) }

    context 'when patients are awaiting doctor with a specific indication' do
      it 'returns unassigned patients with the specified indication' do
        indication_name = 'rash'
        patients = described_class.awaiting_doctor(indication_name)

        expect(patients).to include(patient1)
        expect(patients).not_to include(patient2)
        expect(patients).not_to include(patient3)
      end
    end

    context 'when there are no unassigned patients with a specified indication' do
      it 'returns an empty array' do
        indication_name = 'cough'
        patients = described_class.awaiting_doctor(indication_name)

        expect(patients).to be_empty
      end
    end
  end
end
