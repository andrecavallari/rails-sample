# frozen_string_literal: true

class ApplicationController < ActionController::API
  protected

  def warden
    request.env['warden']
  end

  def current_user
    warden.user
  end
end
