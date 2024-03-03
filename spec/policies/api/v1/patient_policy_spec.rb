# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PatientPolicy, type: :policy do
  let(:doctor) { create(:doctor) }
  let(:patient) { create(:patient) }
  subject { described_class }

  permissions :index? do
    it 'grants access if the doctor is present' do
      expect(subject).to permit(doctor)
    end

    it 'denies access if the doctor is not present' do
      expect(subject).not_to permit(nil)
    end
  end

  permissions :update? do
    context 'with a doctor trained for the indication' do
      context 'with an unassigned patient' do
        it 'grants access' do
          expect(subject).to permit(doctor, patient)
        end
      end

      context 'with an assigned patient' do
        let(:patient) { create(:patient, doctor: doctor) }

        it 'denies access' do
          expect(subject).not_to permit(doctor, patient)
        end
      end
    end

    context 'when the doctor is not trained for the indication' do
      let(:doctor) { create(:doctor, indication: create(:indication, name: 'flu')) }
      context 'with an unassigned patient' do
        it 'denies access' do
          expect(subject).not_to permit(doctor, patient)
        end
      end

      context 'with an assigned patient' do
        it 'denies access' do
          expect(subject).not_to permit(doctor, patient)
        end
      end
    end

    it 'denies access if the doctor is not present' do
      expect(subject).not_to permit(nil, patient)
    end
  end

  describe described_class::Scope do
    let(:scope) { described_class.new(doctor, Patient) }

    it 'returns patients with the same indication as the doctor and unassigned' do
      assigned_patient = create(:patient, doctor: doctor)

      resolved_patients = scope.resolve
      expect(resolved_patients).to contain_exactly(patient)
      expect(resolved_patients).not_to include(assigned_patient)
    end
  end
end
