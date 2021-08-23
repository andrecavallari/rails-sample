# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'bcrypt', '~> 3.1.16'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'httparty', '~> 0.18.1'
gem 'jsonapi.rb', '~> 1.7.0'
gem 'jwt', '~> 2.2.3'
gem 'keisan', '~> 0.9.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4'
gem 'rails_warden', '~> 0.6.0'
gem 'redis', '~> 4.4.0'
gem 'sidekiq', '~> 6.2.1'
gem 'twitter', '~> 7.0.0'

# gem 'jbuilder', '~> 2.7'
# gem 'redis', '~> 4.0'
# gem 'image_processing', '~> 1.2'
# gem 'rack-cors'

group :development do
  gem 'better_errors', '~> 2.9.1'
  gem 'foreman', '~> 0.87.2'
  gem 'listen', '~> 3.3'
  gem 'rubocop', '~> 1.19.0'
  gem 'rubocop-rails', '~> 2.11.3'
  gem 'rubocop-rspec', '~> 2.4.0'
  gem 'spring', '~> 2.1.1'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '~> 2.7.6'
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 5.0.2'
end

group :test do
  gem 'shoulda-matchers', '~> 5.0.0'
  gem 'simplecov', '~> 0.21.2'
  gem 'simplecov-lcov', '~> 0.8.0'
  gem 'super_diff', '~> 0.8.0'
  gem 'undercover', '~> 0.4.3'
  gem 'vcr', '~> 6.0.0'
  gem 'webmock', '~> 3.14.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
