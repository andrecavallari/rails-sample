# frozen_string_literal: true

module JWT
  class Client
    class << self
      def encode(payload)
        JWT.encode(payload, secret)
      end

      def decode(token)
        JWT.decode(token, secret).first
      end

      private

      def secret
        @secret ||= ENV['JWT_SECRET'] or raise 'JWT_SECRET is not set in environment variables'
      end
    end
  end
end
