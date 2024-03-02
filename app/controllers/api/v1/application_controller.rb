# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      before_action :authenticate_doctor!

      def current_doctor
        token = fetch_token_from_headers
        return unless token.present?

        decoded_token = Authentication::Jwt::DecodeTokenService.call(token)
        return unless decoded_token

        doctor_id = decoded_token[0]['doctor_id']
        @doctor = Doctor.find_by(id: doctor_id)
      end

      def authenticate_doctor!
        return if current_doctor.present?

        render json: { message: 'unsuccessful' }, status: :unauthorized
      end

      private

      def fetch_token_from_headers
        request.headers['Authorization']&.split&.last
      end
    end
  end
end
