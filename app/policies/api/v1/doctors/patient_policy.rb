# frozen_string_literal: true

module Api
  module V1
    module Doctors
      class PatientPolicy < ::Api::V1::ApplicationPolicy
        def index?
          @doctor.present?
        end

        class Scope < Scope
          def resolve
            scope.where(doctor_id: @doctor.id)
          end
        end
      end
    end
  end
end
