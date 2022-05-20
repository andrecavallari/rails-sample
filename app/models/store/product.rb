# frozen_string_literal: true

module Store
  class Product < ApplicationRecord
    belongs_to :segment, class_name: 'Store::Segment'

    validates :name, presence: true, uniqueness: true
    validates :price, presence: true, numericality: { greater_than: 0 }

    before_save :set_final_price

    private

    def set_final_price
      self.final_price = calculator.evaluate(segment.operation, price: price)
    end

    def calculator
      @calculator ||= ::Keisan::Calculator.new
    end
  end
end
