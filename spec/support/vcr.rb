# frozen_string_literal: true

require 'vcr'

SENSITIVE_ENV_VARIABLES = %w[
  OPEN_WEATHER_API_KEY
  TWITTER_API_KEY
  TWITTER_API_SECRET
  TWITTER_ACCESS_TOKEN
  TWITTER_ACCESS_TOKEN_SECRET
].freeze

def filter_hash(value, key = nil)
  if value.instance_of?(Hash)
    value.map { |k, v| filter_hash(v, [key, k].compact.join('.')) }
  else
    { key => value }
  end
end

VCR.configure do |config|
  config.hook_into :webmock
  config.ignore_localhost = true
  config.configure_rspec_metadata!
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.default_cassette_options = { record: :none }

  credentials = filter_hash(Rails.application.credentials.config).flatten.reduce(:merge)

  credentials.each do |key, value|
    config.filter_sensitive_data("<#{key}>") { value }
  end

  SENSITIVE_ENV_VARIABLES.each do |key|
    config.filter_sensitive_data("<#{key}>") { ENV.fetch(key, nil) }
  end
end
