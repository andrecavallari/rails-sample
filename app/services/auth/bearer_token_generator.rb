# frozen_string_literal: true

module Auth
  class BearerTokenGenerator < ApplicationService
    def initialize(user_id)
      @user_id = user_id
    end

    def call
      JWT.encode(payload, Config.jwt_secret)
    end

    private

    def payload
      {
        iat: Time.current.to_i,
        exp: Config.expires_at,
        iss: Config.issuer,
        jti: Auth::Database.jti(@user_id)
      }
    end
  end
end
