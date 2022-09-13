# frozen_string_literal: true

class TweetWeatherConsumer < ApplicationConsumer
  # :nocov:
  def self.start
    exchange = channel.exchange('weather.out', type: :fanout)
    channel.queue('sample.in')
           .bind(exchange)
           .subscribe(manual_ack: true) do |info, properties, body|
      logger.info "Received #{body} in sample.in from weather.out"

      new(info, properties, body).call
    end
  end
  # :nocov:

  def call
    TweetWeatherJob.perform_now(city, state)

    ack
  end

  private

  def city
    @city ||= parsed_body[:city] or raise StandardError, 'City is not present'
  end

  def state
    @state ||= parsed_body[:state] or raise StandardError, 'State is not present'
  end
end
