# frozen_string_literal: true

module Auth
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[create]

    def index
      keys = JWT::DB.user_keys(parsed_token['sub'])
      keys.map! do |key|
        value = JWT::DB.hgetall(key)
        value['jti'] = key.split(':').last
        value['ttl'] = JWT::DB.ttl(key)
        value['current'] = value['jti'] == parsed_token['jti']

        value
      end

      render json: keys
    end

    def create
      warden.authenticate!(:password, store: false)
      token = Auth::GenerateTokenService.new(warden.user, token_properties).call

      render json: { token: token }
    end

    def destroy
      JWT::DB.destroy(parsed_token['sub'], parsed_token['jti'])
    end

    def revoke
      if JWT::DB.exists?(parsed_token['sub'], params['jti'])
        JWT::DB.destroy(parsed_token['sub'], params['jti'])
      else
        head :not_found
      end
    end

    private

    def token_properties
      {
        user_agent: request.user_agent,
        time: Time.current,
        ip: request.remote_ip
      }.compact
    end

    def parsed_token
      JWT::Client.decode(request.headers['authorization'].split.last)
    end
  end
end
