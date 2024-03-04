# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Doctors::Patients', type: :request do
  let!(:doctor) { create(:doctor) }
  let!(:patient1) { create(:patient, doctor: doctor, last_name: 'Doe') }
  let!(:patient2) { create(:patient, doctor: doctor, last_name: 'Smith') }
  let(:token) { Authentication::Jwt::EncodeTokenService.call(doctor_id: doctor.id) }

  describe 'GET #index' do
    context 'when authenticated' do
      before do
        allow(Authentication::Jwt::DecodeTokenService).to receive(:call).and_return([{ 'doctor_id' => doctor.id }])
      end

      context 'when sorting by last name' do
        it 'returns patients sorted by last name' do
          get '/api/v1/doctors/patients', headers: { Authorization: "Bearer #{token}" }, params: { sort: 'last_name' }

          expect(response).to have_http_status(:ok)

          expect(json['data'].length).to eq(2)
        end
      end

      context 'when sorting by appointment' do
        it 'returns patients sorted by appointment' do
          create_list(:appointment, 3, doctor: doctor, patient: patient1, scheduled_at: DateTime.current)

          get '/api/v1/doctors/patients', headers: { Authorization: "Bearer #{token}" }, params: { sort: 'appointment' }

          expect(response).to have_http_status(:ok)
          expect(json['data'].length).to eq(3)
        end
      end

      context 'with invalid params' do
        it 'returns an error message' do
          get '/api/v1/doctors/patients', headers: { Authorization: "Bearer #{token}" }, params: { sort: 'foobar' }

          expect(response).to have_http_status(:bad_request)
          expect(json['error']).to eq('Invalid parameter')
        end
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized' do
        get '/api/v1/doctors/patients'

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  def json
    JSON.parse(response.body)
  end
end
