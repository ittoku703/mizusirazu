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
>
> The website is published at this URL: https://mizusirazu.net

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

![Mizusirazu model](https://raw.githubusercontent.com/ittoku703/mizusirazu/7c11208a1ccc8d1da260544e0a4eee230a5b9247/doc/images/model-structure.drawio.svg)

**Routing**

![Mizusirazu routing](https://raw.githubusercontent.com/ittoku703/mizusirazu/87678002a1719c476ecd5545de600ca9519a7de4/doc/images/routing.drawio.svg)
