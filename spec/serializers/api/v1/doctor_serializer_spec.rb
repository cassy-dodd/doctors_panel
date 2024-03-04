# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DoctorSerializer do
  subject { described_class.new(doctor).serialized_json }

  let(:doctor) { create(:doctor, name: 'John Doe', email: 'john@example.com', indication: create(:indication)) }

  context 'serialization' do
    it 'serializes the doctor object with correct attributes' do
      expect(parsed_data['data']['id']).to eq(doctor.id.to_s)
      expect(parsed_data['data']['type']).to eq('doctor')
      expect(parsed_data['data']['attributes']['name']).to eq(doctor.name)
      expect(parsed_data['data']['attributes']['email']).to eq(doctor.email)
    end

    it 'does not include sensitive attributes' do
      expect(parsed_data['data']['attributes']).not_to have_key('password_digest')
    end
  end

  def parsed_data
    JSON.parse(subject)
  end
end
