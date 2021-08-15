# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4'

# gem 'jbuilder', '~> 2.7'
# gem 'redis', '~> 4.0'
# gem 'bcrypt', '~> 3.1.7'
# gem 'image_processing', '~> 1.2'
# gem 'rack-cors'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'httparty', '~> 0.18.1'
gem 'twitter', '~> 7.0.0'

group :development do
  gem 'listen', '~> 3.3'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'spring'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '~> 2.7.6'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 5.0.2'
end

group :test do
  gem 'vcr', '~> 6.0.0'
  gem 'webmock', '~> 3.14.0'
  gem 'super_diff', '~> 0.8.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
