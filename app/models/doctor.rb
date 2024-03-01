# frozen_string_literal: true

class Doctor < ApplicationRecord
  belongs_to :indication
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
