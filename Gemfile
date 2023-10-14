# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bcrypt'
gem 'bootsnap', require: false
gem 'bunny'
gem 'httparty'
gem 'jsonapi.rb'
gem 'jwt'
gem 'keisan'
gem 'net-smtp'
gem 'nokogiri'
gem 'pg'
gem 'puma'
gem 'rack'
gem 'rails', '~> 6.1.6'
gem 'rails_warden'
gem 'ransack'
gem 'redis'
gem 'sidekiq'
gem 'twitter'

group :development do
  gem 'better_errors'
  gem 'foreman'
  gem 'listen'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'spring'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'simplecov-lcov'
  gem 'super_diff'
  gem 'undercover'
  gem 'vcr'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
