# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < Api::V1::ApplicationController
      skip_before_action :authenticate_doctor!

      def create
        @doctor = Doctor.find_by(email: login_params[:email])
        if @doctor&.authenticate(login_params[:password])
          # TODO: add serializer and don't expose all model attrs to client
          @token = Authentication::Jwt::EncodeTokenService.call(doctor_id: @doctor.id)
          render json: {
            doctor: @doctor,
            token: @token
          }, status: :accepted
        else
          render json: { message: 'unsuccessful login' }, status: :unauthorized
        end
      end

      private

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end

# Assuming that we already have doctors in our db who want to log-in and access their exisiting/new patients
# TODO: Two step authentication
# ABAC authorisation in policies

# TODO: add appointments
