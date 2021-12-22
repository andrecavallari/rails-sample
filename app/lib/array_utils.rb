# frozen_string_literal: true

class ArrayUtils
  class << self
    def symetric_difference(array_a, array_b)
      (array_a - array_b) + (array_b - array_a)
    end
  end
end
