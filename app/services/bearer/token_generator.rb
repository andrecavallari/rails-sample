# frozen_string_literal: true

module Bearer
  class TokenGenerator < ApplicationService
    def initialize(user_id)
      @user_id = user_id
    end

    def call
      JWT.encode(payload, Config::SECRET)
    end

    private

    def payload
      {
        iat: Time.current.to_i,
        exp: Config.expires_at,
        iss: Config::ISSUER,
        jti: Bearer::Database.jti(@user_id)
      }
    end
  end
end
