FROM ruby:3.3.0

RUN apt-get update -qq && apt-get install -y postgresql-client

RUN addgroup --gid 1000 rails
RUN adduser --system --gid 1000 --uid 1000 rails

USER rails

WORKDIR /hrlabs
COPY --chown=rails Gemfile Gemfile.lock ./

RUN gem install bundler
RUN bundle install

COPY --chown=rails . .

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]
CMD [ "rails", "server", "-b", "0.0.0.0" ]
