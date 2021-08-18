# frozen_string_literal: true

module Filesystem
  class FileSerializer < ApplicationSerializer
    attributes :id

    attribute :filename do |record|
      record.attachment.filename
    end

    attribute :url do |record|
      rails_blob_path(record.attachment, disposition: :attachment, only_path: true)
    end

    belongs_to :directory, record_type: :directory, serializer: Filesystem::DirectorySerializer
  end
end
