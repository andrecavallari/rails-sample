# frozen_string_literal: true

module Mq
  class Client
    CLOUDAMQP_URL = ENV.fetch('CLOUDAMQP_URL', 'amqp://localhost:5672')

    class << self
      def connection
        @connection ||= Bunny.new(CLOUDAMQP_URL).tap(&:start)
      end

      def channel
        @channel ||= connection.create_channel
      end
    end
  end
end
