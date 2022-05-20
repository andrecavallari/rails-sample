# frozen_string_literal: true

# :nocov:

require 'json'

class ApplicationConsumer
  delegate :channel, to: :'Mq::Client'
  attr_reader :info, :properties, :body

  def initialize(info, properties, body)
    @info = info
    @properties = properties
    @body = body
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
    @parsed_body ||= begin
      JSON.parse(body)
    rescue StandardError
      body
    end
  end

  def reply(message)
    raise StandardError, 'Property reply_to is not present' unless properties[:reply_to].present?

    Mq::Client.channel.default_exchange.publish(
      message,
      routing_key: properties[:reply_to]
    )
  end

  def ack
    channel.ack(info.delivery_tag)
  end
end
