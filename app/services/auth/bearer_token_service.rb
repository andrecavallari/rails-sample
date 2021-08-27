# frozen_string_literal: true

module Auth
  class BearerTokenService
    def initialize(token)
      @token = token
    end

    def call
      return false if parsed_token.blank? || !JWT::DB.exists?(sub, jti)

      JWT::DB.reset_ttl(sub, jti)
      User.find(sub)
    end

    private

    def parsed_token
      @parsed_token ||= JWT::Client.decode(@token)
    rescue JWT::VerificationError, JWT::DecodeError
      nil
    end

    def sub
      @sub ||= parsed_token['sub']
    end

    def jti
      @jti ||= parsed_token['jti']
    end
  end
end
