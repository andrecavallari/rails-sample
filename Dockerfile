FROM ruby:3.1.2

WORKDIR /app
COPY . .

RUN apt-get update \
  && apt-get install -y cmake \
  && apt-get install -y g++ \
  && apt-get install -y libpq-dev \
  && apt-get install -y pkg-config

RUN gem install bundler \
  && bundle install --no-cache --jobs=4 --retry=3
