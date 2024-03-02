# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authentication::Jwt::EncodeTokenService do
  let(:payload) { { doctor_id: 1 } }
  let(:expiration_time) { 1.hour.from_now }

  describe '.call' do
    subject(:encoded_token) { described_class.call(payload, exp: expiration_time) }

    it 'encodes a payload into a JWT token' do
      decoded_token = decode_token(encoded_token)

      expect(decoded_token['doctor_id']).to eq(payload[:doctor_id])
    end

    it 'encodes a payload with expiration time' do
      decoded_token = decode_token(encoded_token)

      expect(decoded_token['exp']).to eq(expiration_time.to_i)
    end
  end

  def decode_token(token)
    JWT.decode(token, described_class::SECRET_KEY, true, algorithm: 'HS256').first
  end
end
