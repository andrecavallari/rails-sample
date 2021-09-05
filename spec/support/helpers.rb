# frozen_string_literal: true

module Helpers
  def auth_header(user)
    {
      authorization: Auth::BearerTokenGenerator.call(user.id)
    }
  end
end
