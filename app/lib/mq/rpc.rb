# frozen_string_literal: true

module Mq
  class Rpc
    def initialize(target, timeout = 180)
      @target, @timeout = target, timeout
    end

    def call(payload)
      @payload = payload
      @locker = Mutex.new
      @condition = ConditionVariable.new
      subscribe!
      publish!
      @locker.synchronize { @condition.wait(@locker, @timeout) }

      @response
    ensure
      queue.delete
    end

    private
      def queue
        @queue ||= Client.channel.queue('', exclusive: true)
      end

      def exchange
        @exchange ||= Client.channel.default_exchange
      end

      def subscribe!
        queue.subscribe do |info, properties, body|
          @response = body
          @locker.synchronize { @condition.signal }
        end
      end

      def publish!
        exchange.publish(@payload.to_s, routing_key: @target, reply_to: queue.name)
      end
  end
end
