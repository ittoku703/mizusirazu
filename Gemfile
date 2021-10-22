source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'
gem 'rails', '~> 6.1.0'

gem 'bootsnap', require: false
gem 'jbuilder'
gem 'jquery-rails'
gem 'puma'
gem 'sass-rails'
gem 'sorcery'
gem 'turbolinks'

group :development, :test do
  gem 'byebug'
  gem 'sqlite3'
end

group :development do
  gem 'letter_opener'
  gem 'listen'
  gem 'rack-mini-profiler'
  gem 'spring'
  gem 'web-console'

  gem 'rubocop', '~> 1.22', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard-rspec', require: false
  gem 'rails-controller-testing'
  gem 'rspec-rails'

  # only macOS
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'
end

group :production do
  gem 'pg'
end
