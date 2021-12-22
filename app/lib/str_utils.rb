# frozen_string_literal: true

class StrUtils
  class << self
    def find_repeated_letters(word)
      word.scan(/(\w)(\1+)?/).map(&:join).sort_by { |n| - n.length }.first
    end

    def last_word_length(phrase)
      phrase.gsub(/(\s)(\1+)/, ' ').strip.split.last.length
    end
  end
end
