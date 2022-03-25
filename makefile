db_init:
	docker-compose run web bin/rake db:create && docker-compose run web bin/rails db:migrate && docker-compose run web bin/rails db:seed

debug:
	docker-compose up -d && docker attach mizusirazu_web_1

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

rails_c:
	docker-compose run web bin/rails console
