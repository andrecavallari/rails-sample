# frozen_string_literal: true

module Helpers
  def auth_header(user)
    {
      authorization: Bearer::TokenGenerator.call(user.id)
    }
  end
end
