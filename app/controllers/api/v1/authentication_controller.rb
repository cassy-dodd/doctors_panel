# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authenticate_doctor!

      def create
        @doctor = Doctor.find_by(email: login_params[:email])
        if @doctor&.authenticate(login_params[:password])
          @token = Authentication::Jwt::EncodeTokenService.call(doctor_id: @doctor.id)
          render json: {
            doctor: Api::V1::DoctorSerializer.new(@doctor).serialized_json,
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
