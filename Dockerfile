FROM ruby:3.0.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /work
WORKDIR /work
ADD Gemfile /work/Gemfile
ADD Gemfile.lock /work/Gemfile.lock
RUN bundle install
ADD . /work
