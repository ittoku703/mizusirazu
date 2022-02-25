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
>
> The website is published at this URL: https://mizusirazu.net

- Server start up:
  1. `docker-compose build`
  2. `docker-compose up`
  3. `make db_init`
  -  frontend development: `make frontend`

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
  - providers

- Database initialization
  - development: `make db_reset`

  - production: `comming soon ...`

- How to run the test suite
  - `make rspec`
  - `make guard`

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions
  - `git push heroku`

**Model structure**

![Mizusirazu model](https://raw.githubusercontent.com/ittoku777/mizusirazu/6c8125db34795b3cf17bbb10e8ec54a7d1435802/doc/images/model-structure.drawio.svg)

**Routing**

![Mizusirazu routing](https://raw.githubusercontent.com/ittoku777/mizusirazu/ea38a75fe90b230b8a113c4ccea5a37057ed521a/doc/images/routing.drawio.svg)
