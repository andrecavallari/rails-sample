# frozen_string_literal: true

module Bearer
  class Config
    SECRET = ENV['JWT_SECRET']
    EXPIRATION_TIME = ENV.fetch('JWT_EXPIRATION_TIME', 21_600).to_i
    ISSUER = ENV.fetch('JWT_ISSUER', 'https://andre.srv.br')
    REDIS_URL = ENV.fetch('JWT_REDIS_URL', 'redis://localhost:6379')

    class << self
      def expires_at
        Time.current.to_i + EXPIRATION_TIME
      end
    end
  end
end
