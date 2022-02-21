db_init:
	docker-compose run web bin/rake db:create && docker-compose run web bin/rails db:migrate && docker-compose run web bin/rails db:seed

frontend:
	docker-compose run web bin/rails tailwindcss:watch

bash:
	docker-compose run web bash

rspec:
	docker-compose run web bundle exec rspec

guard:
	docker-compose run web bundle exec guard

db_reset:
	docker-compose run web bin/rails db:migrate:reset
