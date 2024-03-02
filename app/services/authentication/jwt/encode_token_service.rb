# frozen_string_literal: true

module Authentication
  module Jwt
    class EncodeTokenService
      SECRET_KEY = Rails.application.credentials.jwt[:secret_key]

      def self.call(payload, exp: 1.day.from_now)
        exp_payload = payload.merge({ exp: exp.to_i })
        JWT.encode(exp_payload, SECRET_KEY)
      end
    end
  end
end
