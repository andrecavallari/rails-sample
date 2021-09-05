# frozen_string_literal: true

Rails.application.config.middleware.use Warden::Manager do |config|
  config.default_strategies :bearer_token
  config.failure_app = ->(_) { [401, { 'Content-Type' => 'text/plain' }, ['Not authorized']] }
end

Warden::Manager.serialize_into_session(&:id)
Warden::Manager.serialize_from_session { |id| User.find(id) }

Warden::Strategies.add(:password) do
  def valid?
    params['email'] && params['password']
  end

  def authenticate!
    user = User.find_by(email: params['email'])

    user&.authenticate(params['password']) ? success!(user) : fail!
  end
end

Warden::Strategies.add(:bearer_token) do
  def valid?
    env['HTTP_AUTHORIZATION'].present?
  end

  def authenticate!
    user = Auth::BearerTokenLogin.call(env['HTTP_AUTHORIZATION'])

    user.present? ? success!(user) : fail!
  end
end
