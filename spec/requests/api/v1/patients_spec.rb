# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Patients', type: :request do
  describe 'GET /index' do
    let(:doctor) { create(:doctor) }
    let(:indication) { create(:indication) }
    let(:token) { Authentication::Jwt::EncodeTokenService.call(doctor_id: doctor.id) }

    context 'when authenticated' do
      before do
        allow(Authentication::Jwt::DecodeTokenService).to receive(:call).and_return([{ 'doctor_id' => doctor.id }])
      end

      it 'returns a list of patients that could be assigned to the doctor' do
        create_list(:patient, 3, indication: indication, doctor: nil)
        create(:patient, indication: create(:indication), doctor: doctor)

        get '/api/v1/patients', headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:success)
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
end
