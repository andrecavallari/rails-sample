# frozen_string_literal: true

module Mq
  class Client
    class << self
      def connection
        @connection ||= Bunny.new(connection_string).tap { |s| s.start }
      end

      def channel
        @channel ||= connection.create_channel
      end

      private
        def connection_string
          @connection_string ||= ENV.fetch('CLOUDAMQP_URL', 'amqp://localhost:5672')
        end
    end
  end
end
