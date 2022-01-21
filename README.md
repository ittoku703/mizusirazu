# Mizusirazu.net

> This repository holds the code using the Ruby on Rails full-stack framework for building a website called **mizusirazu.net**.
>
> This website has the following features
>
> - user create, update, delete
> - user profile edit
> - user login, logout
>
> The website is published at this URL: https://mizusirazu.net

* Ruby version:
  *  `ruby 3.0.2p107`
* Rails version:
  *  `Rails 7.0.0`
* System dependencies
  * `Ruby on rails`
* Configuration
* Database creation:
  * users
  * profiles
* Database initialization
  * development: `rails db:migrate:reset`
  * production: `heroku pg:reset --confirm mizusirazu && heroku run rails db:migrate:reset`
* How to run the test suite
  * `bundle exec rspec`
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
  * `git push heroku`

**Model structure**

![Mizusirazu model](https://raw.githubusercontent.com/shinzanmono/mizusirazu.net/f7c21e15e0caaa0f371413dc1c84b73604f92006/doc/images/model-structure.drawio.svg)
