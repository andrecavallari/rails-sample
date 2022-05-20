# frozen_string_literal: true

class TwitterClient
  class << self
    def tweet(message)
      client.update(message)
    end

    private

    def client
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV.fetch('TWITTER_API_KEY', nil)
        config.consumer_secret     = ENV.fetch('TWITTER_API_SECRET', nil)
        config.access_token        = ENV.fetch('TWITTER_ACCESS_TOKEN', nil)
        config.access_token_secret = ENV.fetch('TWITTER_ACCESS_TOKEN_SECRET', nil)
      end
    end
  end
end
