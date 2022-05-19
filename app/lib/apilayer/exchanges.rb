# frozen_string_literal: true

module Apilayer
  class Exchanges
    include HTTParty

    base_uri 'https://api.apilayer.com/exchangerates_data'
    headers apikey: Rails.application.credentials.apilayer[:key]

    class << self
      def convert(amount, from, to)
        get '/convert', query: { amount: amount, from: from, to: to }
      end
    end
  end
end
