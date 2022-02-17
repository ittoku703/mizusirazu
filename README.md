# Mizusirazu.net

> This repository holds the code using the Ruby on Rails full-stack framework for building a website called **mizusirazu.net**.
>
> This website has the following features
>
> - user create, update, delete
> - user profile edit
> - user login, logout
> - user activation
> - user reset password
>
> The website is published at this URL: https://mizusirazu.net

- Server start up:
  1. `docker-compose build`
  2. `docker-compose up`
  3. `make db_init`
  -  frontend development:
      `docker-compose run web bin/rails tailwindcss:watch`
  
- Ruby version:
  -  `ruby 3.0.2p107`
  
- Rails version:
  -  `Rails 7.0.0`
  
- System dependencies
  - `Ruby on rails`
  - `mariaDB`
  
- Configuration

- Database creation:
  - users
  - profiles
  
- Database initialization
  - development: `docker-compose run web bin/rails db:migrate:reset`

  - production: `heroku pg:reset --confirm mizusirazu && heroku run rails db:migrate:reset`
  
- How to run the test suite
  - `docker-compose run web bin/bundle exec guard`
  
- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions
  - `git push heroku`

**Model structure**

![Mizusirazu model](https://raw.githubusercontent.com/shinzanmono/mizusirazu.net/f7c21e15e0caaa0f371413dc1c84b73604f92006/doc/images/model-structure.drawio.svg)
