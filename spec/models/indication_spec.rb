# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Indication, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      indication = Indication.new(name: nil)
      expect(indication).not_to be_valid
    end
  end
end
