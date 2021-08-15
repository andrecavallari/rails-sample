# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.hook_into :webmock
  config.ignore_localhost = true
  config.configure_rspec_metadata!
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.default_cassette_options = { record: :none }

  # To prevent sensitive data to be commited, use code below:
  # config.filter_sensitive_data('<MASKED_DATA>') { 'REAL_VALUE' }
end
