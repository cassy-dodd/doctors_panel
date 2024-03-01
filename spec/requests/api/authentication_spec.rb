# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Authentications', type: :request do
  let!(:doctor) { create(:doctor, email: 'test@test.com', password: '1234') }

  describe 'POST /login' do
    context 'with invalid parameters' do
      it 'returns unauthorized' do
        post '/api/v1/login'

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with valid parameters' do
      before do
        post '/api/v1/login', params: test_params
      end

      context 'when passwords do not match' do
        let(:test_params) { { email: 'test@test.com', password: '12' } }

        it 'returns unauthorized' do
          expect(response).to have_http_status(:unauthorized)
          expect(response.body).to include('unsuccessful login')
        end
      end

      context 'when email does not match' do
        let(:test_params) { { email: 'testing@test.com', password: '1234' } }

        it 'returns unauthorized' do
          expect(response).to have_http_status(:unauthorized)
          expect(response.body).to include('unsuccessful login')
        end
      end

      context 'with matching email and password' do
        let(:test_params) { { email: 'test@test.com', password: '1234' } }

        it 'returns success' do
          expect(response).to have_http_status(:accepted)
        end

        it 'returns a token' do
          expect(response.body).to include('token')
        end
      end
    end
  end
end
