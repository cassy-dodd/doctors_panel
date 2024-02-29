# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  let!(:doctor) { create(:doctor, email: 'test@test.com', password: '1234') }

  describe 'POST /login' do
    context 'with invalid parameters' do
      it 'returns unauthorized' do
        post '/login'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid parameters' do
      context 'when passwords do not match' do
        it 'returns unauthorized' do
          post '/login', params: { email: 'test@test.com', password: '12' }
          expect(response).to have_http_status(:unauthorized)
          expect(response.body).to include('unsuccessful login')
        end
      end

      context 'when email does not match' do
        it 'returns unauthorized' do
          post '/login', params: { email: 'testing@test.com', password: '1234' }
          expect(response).to have_http_status(:unauthorized)
          expect(response.body).to include('unsuccessful login')
        end
      end

      context 'with matching email and password' do
        it 'returns success' do
          post '/login', params: { email: 'test@test.com', password: '1234' }
          expect(response).to have_http_status(:accepted)
          expect(response.body).to include(doctor.as_json.to_json)
        end
      end
    end
  end
end
