FROM ruby:3.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client libpq-dev
WORKDIR /shop_stripe
COPY Gemfile /shop_stripe/Gemfile
COPY Gemfile.lock /shop_stripe/Gemfile.lock
RUN bundle install
COPY . /shop_stripe

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port 3000 to the Docker host
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]