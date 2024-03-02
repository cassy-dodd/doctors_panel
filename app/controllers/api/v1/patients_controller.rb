# frozen_string_literal: true

module Api
  module V1
    class PatientsController < ApplicationController
      def index
        # 1. Get a list of patients that could be assigned to doctor
        # patients without a doctor_id
        ### List of patients that could be assigned to doctor
        # * Get all patients without a doctor and have the same indication the current doctor can treat.

        @patients = Patient.awaiting_doctor(current_doctor.indication.name)
        render json: @patients
      end

      def update
        # 3. As a doctor they can assign themselves to patients.
        #   This will be understood as the patient is being treated by the doctor.
        ### Doctor assignment

        # * Doctors can only treat patients with the indication they are trained for.
        # * No two doctors can treat the same patient.
      end
    end
  end
end
