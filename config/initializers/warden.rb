# frozen_string_literal: true

Rails.application.config.middleware.use Warden::Manager do |config|
  config.default_strategies :bearer_token, store: false
  config.failure_app = ->(_) { [401, { 'Content-Type' => 'text/plain' }, ['Not authorized']] }
end

Warden::Manager.serialize_into_session(&:id)
Warden::Manager.serialize_from_session { |id| User.find(id) }

Warden::Strategies.add(:password) do
  def valid?
    params['email'] && params['password']
  end

  def authenticate!
    user = Auth::PasswordService.new(params['email'], params['password']).call
    return fail!('Username invalid') if user.blank?

    success!(user)
  end
end

Warden::Strategies.add(:bearer_token) do
  def authenticate!
    access_token = request.headers['authorization']&.split&.last
    user = Auth::BearerTokenService.new(access_token).call
    return fail!('Unauthorized') if user.blank?

    success!(user)
  end
end
