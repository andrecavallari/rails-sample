# frozen_string_literal: true

module Store
  class ApplicationController < ::ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render404

    private

    def render404
      head :not_found
    end
  end
end
