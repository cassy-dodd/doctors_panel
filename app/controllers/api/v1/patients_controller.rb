# frozen_string_literal: true

module Api
  module V1
    class PatientsController < ApplicationController
      def index
        # TODO: step 2 of token authorisation
        # TODO: start to think about authorisation abstraction layer (ABAC -> as we have no specific doc role)
        @patients = Patient.all
        render json: @patients
      end

      def update; end
    end
  end
end
