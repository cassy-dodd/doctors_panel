# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authentication::Jwt::DecodeTokenService do
  describe '.call' do
    let(:valid_token) { Authentication::Jwt::EncodeTokenService.call({ doctor_id: 1 }) }

    it 'decodes a valid JWT token' do
      decoded_token = described_class.call(valid_token)

      expect(decoded_token.first).to include('doctor_id' => 1)
    end

    it 'returns nil for an invalid JWT token' do
      decoded_token = described_class.call('invalid_token')

      expect(decoded_token).to be_nil
    end
  end
end
