# frozen_string_literal: true

module Filesystem
  class File < ApplicationRecord
    belongs_to :directory, class_name: 'Filesystem::Directory', optional: true
    has_one_attached :attachment
  end
end
