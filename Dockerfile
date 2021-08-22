FROM ruby:3.0.1

WORKDIR /app
COPY Gemfile Gemfile.lock /app/

RUN gem install bundler \
  && bundle install --no-cache --jobs=4 --retry=3

COPY . .

ENTRYPOINT ["bundle", "exec"]
CMD ["puma", "-C", "config/puma.rb"]
