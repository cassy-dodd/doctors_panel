# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PatientFilter do
  let!(:doctor) { create(:doctor) }

  describe '#call' do
    context 'with matching patients' do
      let(:datetime) { DateTime.current }
      let!(:patient1) { create(:patient, doctor: doctor, last_name: 'Doe') }
      let!(:patient2) { create(:patient, doctor: doctor, last_name: 'Smith') }
      let!(:appointment1) { create(:appointment, doctor: doctor, patient: patient1, scheduled_at: datetime) }
      let!(:appointment2) do
        create(:appointment, doctor: doctor, patient: patient2, scheduled_at: datetime - 1.year)
      end

      context 'when sorting by last name' do
        it 'returns patients sorted by last name' do
          patients = described_class.new(doctor.reload.patients, { sort: 'last_name' }).call

          expect(patients).to eq([patient1, patient2])
        end
      end

      context 'when sorting by closest appointment' do
        it 'returns patients sorted by closest appointment' do
          patients = described_class.new(doctor.reload.patients, { sort: 'appointment' }).call

          expect(patients).to eq([patient2, patient1])
        end
      end
    end

    context 'with no matching patients' do
      context 'when sorting by last name' do
        it 'returns an empty array' do
          patients = described_class.new(doctor.reload.patients, { sort: 'last_name' }).call

          expect(patients).to eq([])
        end
      end

      context 'when sorting by closest appointment' do
        it 'returns an empty array' do
          patients = described_class.new(doctor.reload.patients, { sort: 'appointment' }).call

          expect(patients).to eq([])
        end
      end
    end
  end
end
