# frozen_string_literal: true

module Auth
  class GenerateTokenService
    def initialize(user, token_properties)
      @user = user
      @token_properties = token_properties
    end

    def call
      JWT::Client.encode(
        sub: @user.id,
        iat: Time.current.to_i,
        jti: jwt_id
      )
    end

    private

    def jwt_id
      @jwt_id ||= JWT::DB.create(@user.id, @token_properties)
    end
  end
end
