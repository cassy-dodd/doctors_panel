# frozen_string_literal: true

class Patient < ApplicationRecord
  belongs_to :doctor, optional: true
  belongs_to :indication
  has_many :appointments

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  scope :awaiting_doctor, lambda { |indication_name|
    joins(:indication)
      .where(doctor_id: nil)
      .where(indications: { name: indication_name })
  }
end
