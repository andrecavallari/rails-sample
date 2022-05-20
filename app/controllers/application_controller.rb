# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate!

  protected

  def authenticate!
    warden.authenticate!(:bearer_token, store: false)
  end

  # :nocov:
  def warden
    request.env['warden']
  end

  def current_user
    warden.user
  end

  def parsed_jwt_token
    @parsed_jwt_token ||= JWT.decode(
      request.env['HTTP_AUTHORIZATION'].split.last,
      ENV.fetch('JWT_SECRET', nil)
    ).first
  end
  # :nocov:
end
