# frozen_string_literal: true

module Filesystem
  class DirectorySerializer
    include JSONAPI::Serializer

    attributes :id, :name, :created_at, :updated_at
    belongs_to :parent, record_type: :directory, serializer: Filesystem::DirectorySerializer
    has_many :children, record_type: :directory, serializer: Filesystem::DirectorySerializer
    has_many :files, record_type: :file, serializer: Filesystem::FileSerializer
  end
end
