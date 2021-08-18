# frozen_string_literal: true

module Filesystem
  class Directory < ApplicationRecord
    belongs_to :parent, class_name: 'Filesystem::Directory', optional: true, inverse_of: :children
    has_many :children, class_name: 'Filesystem::Directory', foreign_key: 'parent_id', dependent: :destroy,
      inverse_of: :parent
    has_many :files, class_name: 'Filesystem::File', dependent: :destroy

    validates :name, presence: true, uniqueness: { scope: :parent_id }
  end
end
