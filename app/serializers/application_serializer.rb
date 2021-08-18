# frozen_string_literal: true

class ApplicationSerializer
  include JSONAPI::Serializer
  # include Rails.application.routes.url_helpers

  class << self
    def rails_blob_path(object, options)
      Rails.application.routes.url_helpers.rails_blob_path(object, options)
    end
  end
end
