FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y default-libmysqlclient-dev
WORKDIR /mizusirazu
COPY Gemfile /mizusirazu/Gemfile
COPY Gemfile.lock /mizusirazu/Gemfile.lock
RUN gem update bundler && bundle install

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
EXPOSE 3000

# Configure the main process to run when running the image
CMD [ "rails", "server", "-b", "0.0.0.0" ]
