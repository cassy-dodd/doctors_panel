# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Appointment, type: :model do
  describe 'validations' do
    it 'validates presence of scheduled_at' do
      appointment = Appointment.new(scheduled_at: nil)
      expect(appointment).not_to be_valid
    end
  end
end
