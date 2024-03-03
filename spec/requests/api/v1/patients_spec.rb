# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Patients', type: :request do
  let(:doctor) { create(:doctor, indication: indication_hair_loss) }
  let(:indication_hair_loss) { create(:indication) }
  let(:token) { Authentication::Jwt::EncodeTokenService.call(doctor_id: doctor.id) }

  describe 'GET /index' do
    context 'when authenticated' do
      before do
        allow(Authentication::Jwt::DecodeTokenService).to receive(:call).and_return([{ 'doctor_id' => doctor.id }])
      end

      it 'returns a list of patients that could be assigned to the doctor' do
        create_list(:patient, 3, indication: indication_hair_loss, doctor: nil)
        create(:patient, indication: indication_hair_loss, doctor: doctor)

        get '/api/v1/patients', headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized' do
        get '/api/v1/patients'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /api/v1/patients/:id' do
    let(:patient) { create(:patient, indication: doctor.indication) }
    let(:pundit_error_msg) { { 'error' => 'You are not authorized to perform this action.' } }

    context 'when authenticated' do
      before do
        allow(Authentication::Jwt::DecodeTokenService).to receive(:call).and_return([{ 'doctor_id' => doctor.id }])
      end

      context 'with an unassigned patient' do
        context "when the doctor is trained for the patient's indication" do
          it 'assigns the patient to the doctor' do
            put "/api/v1/patients/#{patient.id}", headers: { Authorization: "Bearer #{token}" }

            expect(response).to have_http_status(:ok)
            expect(patient.reload.doctor).to eq(doctor)
            expect(json['message']).to eq('Patient assigned successfully')
          end
        end

        context "when the doctor is not trained for the patient's indication" do
          let(:doctor) { create(:doctor, indication: create(:indication, name: 'flu')) }
          let(:patient) { create(:patient, indication: indication_hair_loss) }

          it 'returns an error message' do
            put "/api/v1/patients/#{patient.id}", headers: { Authorization: "Bearer #{token}" }

            expect(json).to eq(pundit_error_msg)
          end
        end
      end

      context 'with an already assigned patient' do
        before { patient.update(doctor: doctor) }

        it 'returns an error message' do
          put "/api/v1/patients/#{patient.id}", headers: { Authorization: "Bearer #{token}" }

          expect(json).to eq(pundit_error_msg)
        end
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized' do
        put "/api/v1/patients/#{patient.id}"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  def json
    JSON.parse(response.body)
  end
end
