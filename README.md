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
> - user multi-provider authentication
> - user micropost create edit

- Server start up:
  1. `docker-compose build`
  2. `docker-compose up`
  - or debug: `make debug`
  3. `make db_init`
  -  frontend development: `make frontend`

- Ruby version:
  -  `ruby 3.1.1`

- Rails version:
  -  `Rails 7.0.2`

- System dependencies
  - `Ruby on rails`
  - `mariaDB`

- Configuration

- Database creation:
  - users
  - profiles
  - providers
  - microposts

- Database initialization
  - development: `make db_reset`

  - production: `not yet ...`

- How to run the test suite
  - `make rspec`
  - `make guard`

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions
  - `git push heroku`

**Model structure**

![Mizusirazu model](https://raw.githubusercontent.com/ittoku703/mizusirazu/6f19e11be67bab50f41e489c5ff95a785ebbafd6/doc/images/model-structure.drawio.svg)

**Routing**

![Mizusirazu routing](https://raw.githubusercontent.com/ittoku703/mizusirazu/777993b8c84852f0421ed6dff58fa91c4f26ab0c/doc/images/routing.drawio.svg)
