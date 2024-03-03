# frozen_string_literal: true

module Api
  module V1
    class PatientPolicy < ApplicationPolicy
      def index?
        @doctor.present?
      end

      def update?
        @doctor.present? && doctor_trained_for_indication? && patient_unassigned?
      end

      class Scope < Scope
        def resolve
          scope.joins(:indication)
               .where(doctor_id: nil)
               .where(indications: { name: @doctor.indication.name })
        end
      end

      private

      def doctor_trained_for_indication?
        @doctor.indication.name == @record.indication.name
      end

      def patient_unassigned?
        @record.doctor.nil?
      end
    end
  end
end
