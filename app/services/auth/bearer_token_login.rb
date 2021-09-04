# frozen_string_literal: true

module Auth
  class BearerTokenLogin < ApplicationService
    def initialize(token)
      @token = token.split.last
    end

    def call
      user.presence
    end

    private

    def user
      User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def user_id
      @user_id ||= Auth::Database.user_id(parsed_token['jti'])
    end

    def parsed_token
      @parsed_token ||= JWT.decode(@token, Config.jwt_secret)&.first
    rescue JWT::VerificationError, JWT::DecodeError, JWT::ExpiredSignature
      {}
    end
  end
end
