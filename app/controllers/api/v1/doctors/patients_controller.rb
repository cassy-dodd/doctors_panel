# frozen_string_literal: true

module Api
  module V1
    module Doctors
      class PatientsController < ApplicationController
        def index
          # ### As a doctor get list of my patients
          # * Return assigned patients
          # * The list can be sorted by patient last name or by the closest appointment.
          
          @patients = PatientFilter.new(current_doctor.patients, filter_params).call
          render json: @patients
        end

        private

        def filter_params
          params.permit(:sort)
        end
      end
    end
  end
end
