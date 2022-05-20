# frozen_string_literal: true

module Rpc
  class CurrencyConsumer < ApplicationConsumer

    # :nocov:
    def self.start
      channel.queue('rpc.currency').subscribe do |info, properties, body|
        logger.info "Received #{body} in rpc.currency"

        new(info, properties, body).call
      end
    end
    # :nocov:

    def call
      reply apilayer_response['result'].to_s
    end

    private
      def apilayer_response
        @apilayer_response ||= Apilayer::Exchanges.convert(amount, currency_from, currency_to)
      end

      def amount
        @amount ||= parsed_body['amount'] || 1.0
      end

      def currency_from
        @currency_from ||= parsed_body['from'] || 'USD'
      end

      def currency_to
        @currency_to ||= parsed_body['to'] || 'BRL'
      end
  end
end
