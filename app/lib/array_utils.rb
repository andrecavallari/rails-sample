# frozen_string_literal: true

class ArrayUtils
  class << self
    def symetric_difference(a, b)
      (a - b) + (b - a)
    end
  end
end
