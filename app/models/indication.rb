# frozen_string_literal: true

class Indication < ApplicationRecord
  has_many :doctors
  has_many :patients

  validates :name, presence: true
end
