# frozen_string_literal: true

module Filesystem
  class ApplicationController < ::ApplicationController
    include JSONAPI::Deserialization
    include JSONAPI::Fetching
    include JSONAPI::Errors

    rescue_from ActiveRecord::RecordNotFound, with: :render404

    private

    def render404
      head :not_found
    end
  end
end
