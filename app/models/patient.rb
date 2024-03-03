# frozen_string_literal: true

class Patient < ApplicationRecord
  belongs_to :doctor, optional: true
  belongs_to :indication
  has_many :appointments

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
