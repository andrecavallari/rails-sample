# frozen_string_literal: true

module Products
  class Segment < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :operation, presence: true
  end
end
