# frozen_string_literal: true

module Filesystem
  class File < Node
    has_one_attached :content

    belongs_to :directory, class_name: 'Filesystem::Directory', optional: true, inverse_of: :files,
      foreign_key: :parent_id

    validates :content, presence: true
    validates :name, presence: true, uniqueness: { scope: :parent_id }
    validates :directory, presence: true, if: -> { parent_id.present? }

    before_validation :set_name, on: :create

    private

    def set_name
      self.name = content.filename.to_s
    end
  end
end
