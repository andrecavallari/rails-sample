# frozen_string_literal: true

require 'json'

class ApplicationConsumer
  delegate :channel, to: :'Mq::Client'
  attr_reader :info, :properties, :body

  def initialize(info, properties, body)
    @info, @properties, @body = info, properties, body
  end

  protected
    class << self
      delegate :channel, to: :'Mq::Client'

      def start
        raise StandardError, 'Method self.start not defined'
      end

      def logger
        @logger ||= Logger.new(STDOUT).tap do |l|
          l.level = ENV.fetch('LOG_LEVEL', Logger::INFO)
        end
      end
    end

    def parsed_body
      @parsed_body ||= JSON.parse(body) rescue body
    end

    def reply(message)
      unless properties[:reply_to].present?
        raise StandardError, 'Property reply_to is not present'
      end

      Mq::Client.channel.default_exchange.publish(
        message,
        routing_key: properties[:reply_to]
      )
    end

    def ack
      channel.ack(info.delivery_tag)
    end
end
