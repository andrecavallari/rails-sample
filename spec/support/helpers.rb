# frozen_string_literal: true

module Helpers
  def auth_header(user)
    {
      authorization: Auth::GenerateTokenService.new(user, { user_agent: 'Mozilla/5.0' }).call
    }
  end
end
