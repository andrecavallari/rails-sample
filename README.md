# Sample rails app

This is a sample rails app for showing my skills with ruby on rails

## Requirements

* Docker
* docker-compose

## Get started

1. Run `docker-compose up` to get the server running
2. Run `docker-compose run app bundle exec rake db:migrate` to run migrations

## Tests

To run tests just execute `docker-compose run app bundle exec rspec`

## Rubocop

To execute rubocop: `docker-compose run app bundle exec rubocop`

## Contents

- [Authentication](docs/authentication.md)
- [Filesystem](docs/filesystem.md)
- [Simple Store](docs/store.md)
- [Weather Tweet](docs/weather_tweet.md)

