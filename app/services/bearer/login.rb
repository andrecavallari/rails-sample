# frozen_string_literal: true

module Bearer
  class Login < ApplicationService
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
      @user_id ||= Bearer::Database.user_id(parsed_token['jti'])
    end

    def parsed_token
      @parsed_token ||= JWT.decode(@token, Config::SECRET).first
    rescue StandardError
      {}
    end
  end
end
