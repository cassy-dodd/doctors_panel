# frozen_string_literal: true

class Doctor < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :speciality, presence: true
end
