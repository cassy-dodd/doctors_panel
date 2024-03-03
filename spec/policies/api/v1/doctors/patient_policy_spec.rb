# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Doctors::PatientPolicy, type: :policy do
  let(:doctor) { create(:doctor) }
  subject { described_class }

  permissions :index? do
    it 'grants access if the doctor is present' do
      expect(subject).to permit(doctor)
    end

    it 'denies access if the doctor is nil' do
      expect(subject).not_to permit(nil)
    end
  end

  describe described_class::Scope do
    let(:scope) { described_class.new(doctor, Patient) }

    describe '#resolve' do
      it 'returns patients belonging to the doctor' do
        doctor_patients = create_list(:patient, 3, doctor: doctor)
        create_list(:patient, 2)

        resolved_patients = scope.resolve
        expect(resolved_patients).to match_array(doctor_patients)
      end
    end
  end
end
