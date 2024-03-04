# frozen_string_literal: true

module Api
  module V1
    class PatientSerializer
      include FastJsonapi::ObjectSerializer

      attributes :first_name, :last_name, :email

      attribute :indication do |object|
        {
          name: object.indication.name
        }
      end
    end
  end
end
