# frozen_string_literal: true

class StrUtils
  class << self
    def find_repeated_letters(word)
      word.scan(/(.)(\1+)?/).map(&:join).max_by(&:length)
    end

    def last_word_length(phrase)
      phrase.gsub(/(\s)(\1+)/, ' ').strip.split.last.length
    end
  end
end
