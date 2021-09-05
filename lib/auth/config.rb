# frozen_string_literal: true

module Auth
  class Config
    JWT_SECRET = ENV['JWT_SECRET']
    JWT_EXPIRATION_TIME = ENV.fetch('JWT_EXPIRATION_TIME', 21_600).to_i
    JWT_ISSUER = ENV.fetch('JWT_ISSUER', 'https://andre.srv.br')

    class << self
      def expires_at
        expiration_time.seconds.from_now.to_i
      end

      def expiration_time
        JWT_EXPIRATION_TIME
      end

      def issuer
        JWT_ISSUER
      end

      def jwt_secret
        JWT_SECRET
      end
    end
  end
end
