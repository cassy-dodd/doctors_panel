# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      SECRET_KEY = Rails.application.credentials.jwt[:secret_key]

      def encode_token(payload, exp: 1.day.from_now)
        exp_payload = payload.merge({ exp: exp.to_i })
        JWT.encode(exp_payload, SECRET_KEY)
      end
    end
  end
end
