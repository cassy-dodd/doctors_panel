# frozen_string_literal: true

module Authentication
  module Jwt
    class DecodeTokenService
      SECRET_KEY = Rails.application.credentials.jwt[:secret_key]

      def self.call(token)
        JWT.decode(token, SECRET_KEY, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
