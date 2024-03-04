# frozen_string_literal: true

module Api
  module V1
    class DoctorSerializer
      include FastJsonapi::ObjectSerializer

      attributes :name, :email
    end
  end
end
