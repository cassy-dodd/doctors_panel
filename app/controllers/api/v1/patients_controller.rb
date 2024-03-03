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

        @patient = Patient.find(params[:id])

        return render_untrained_doctor_error unless doctor_trained_for_indication?

        return render_patient_already_assigned_error if patient_already_assigned?

        assign_patient_to_current_doctor
      end

      private

      def doctor_trained_for_indication?
        current_doctor.indication.name == @patient.indication.name
      end

      def render_untrained_doctor_error
        render json: { error: "Doctor is not trained for this patient's indication" }, status: :unprocessable_entity
      end

      def patient_already_assigned?
        @patient.doctor.present?
      end

      def render_patient_already_assigned_error
        render json: { error: 'Patient already has a doctor assigned' }, status: :unprocessable_entity
      end

      def assign_patient_to_current_doctor
        @patient.update(doctor_id: current_doctor.id)
        render json: { message: 'Patient assigned successfully' }, status: :ok
      end
    end
  end
end
