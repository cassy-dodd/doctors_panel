# frozen_string_literal: true

module Api
  module V1
    module Doctors
      class PatientsController < ApplicationController
        VALID_SORT_PARAMS = %w[last_name appointment].freeze

        def index
          # ### As a doctor get list of my patients
          # * Return assigned patients
          # * The list can be sorted by patient last name or by the closest appointment.
          authorize [:api, :v1, :doctors, Patient]
          @patients = policy_scope([:api, :v1, :doctors, Patient])
          if sort_param_valid?
            @patients = PatientFilter.new(current_doctor.patients, filter_params).call
            render json: Api::V1::PatientSerializer.new(@patients).serialized_json
          else
            render json: { error: 'Invalid parameter' }, status: :bad_request
          end
        end

        private

        def filter_params
          params.permit(:sort)
        end

        def sort_param_valid?
          VALID_SORT_PARAMS.include?(filter_params[:sort]) || filter_params[:sort].blank?
        end
      end
    end
  end
end
