FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y nodejs default-mysql-client
WORKDIR /backend
COPY Gemfile /backend/Gemfile
COPY Gemfile.lock /backend/Gemfile.lock
RUN bundle install

# Configure the main process to run when running the image
CMD [ "rails", "server", "-b", "0.0.0.0" ]
