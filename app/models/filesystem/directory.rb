# frozen_string_literal: true

module Filesystem
  class Directory < Node
    with_options foreign_key: :parent_id do
      has_many :children, class_name: 'Filesystem::Directory', dependent: :destroy, inverse_of: :parent
      belongs_to :parent, class_name: 'Filesystem::Directory', optional: true, inverse_of: :children
      has_many :files, class_name: 'Filesystem::File', dependent: :destroy, inverse_of: :directory
    end

    validates :name, presence: true, uniqueness: { scope: :parent_id }
  end
end
