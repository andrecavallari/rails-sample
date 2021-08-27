# frozen_string_literal: true

module Auth
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!

    def authenticate_user!
      warden.authenticate!(:bearer_token, store: false)
    end
  end
end
