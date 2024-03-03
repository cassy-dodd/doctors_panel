# frozen_string_literal: true

module Api
  module V1
    class PatientsController < ApplicationController
      def index
        # 1. Get a list of patients that could be assigned to doctor
        # patients without a doctor_id
        ### List of patients that could be assigned to doctor
        # * Get all patients without a doctor and have the same indication the current doctor can treat.
        authorize [:api, :v1, Patient]
        @patients = policy_scope([:api, :v1, Patient])
        render json: @patients
      end

      def update
        # 3. As a doctor they can assign themselves to patients.
        #   This will be understood as the patient is being treated by the doctor.
        ### Doctor assignment
        # * Doctors can only treat patients with the indication they are trained for.
        # * No two doctors can treat the same patient.

        @patient = Patient.find(params[:id])
        authorize [:api, :v1, @patient]

        if @patient.update(doctor_id: current_doctor.id)
          render json: { message: 'Patient assigned successfully' }, status: :ok
        else
          render json: @patient.errors, status: :unprocessable_entity
        end
      end
    end
  end
end
