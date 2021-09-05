# frozen_string_literal: true

module Auth
  class SessionsController < ApplicationController
    skip_before_action :authenticate!, only: %i[create]

    def create
      warden.authenticate!(:password, store: false)
      token = Auth::BearerTokenGenerator.call(warden.user.id)

      render json: { token: token }
    end

    def destroy
      Auth::Database.revoke(parsed_jwt_token['jti'])
      head :no_content
    end
  end
end
