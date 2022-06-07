# frozen_string_literal: true

module Mq
  class Publisher
    class << self
      def tweet_weather(city, state)
        payload = { city: city, state: state }.to_json

        Client.channel.exchange('weather.out', type: :fanout).publish(payload)
      end
    end
  end
end
