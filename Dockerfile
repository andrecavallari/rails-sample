FROM ruby:3.0.2

WORKDIR /app
COPY Gemfile Gemfile.lock /app/

RUN apt-get update && apt-get install -y cmake
RUN gem install bundler \
  && bundle install --no-cache --jobs=4 --retry=3

COPY . .

ENTRYPOINT ["bundle", "exec"]
CMD ["puma", "-C", "config/puma.rb"]
