# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PatientSerializer do
  describe 'serialization' do
    let(:indication) { create(:indication) }
    let(:patient) do
      create(:patient, first_name: 'John', last_name: 'Doe', email: 'john@example.com', indication: indication)
    end

    subject { described_class.new(patient).serialized_json }

    it 'serializes the patient object with correct attributes' do
      expect(parsed_data['data']['attributes']['first_name']).to eq('John')
      expect(parsed_data['data']['attributes']['last_name']).to eq('Doe')
      expect(parsed_data['data']['attributes']['email']).to eq('john@example.com')
    end

    it 'serializes the indication attribute correctly' do
      expect(parsed_data['data']['attributes']['indication']['name']).to eq('hair_loss')
    end
  end

  def parsed_data
    JSON.parse(subject)
  end
end
