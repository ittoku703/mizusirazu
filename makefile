db_init:
	docker-compose run web bin/rake db:create && docker-compose run web bin/rails db:migrate && docker-compose run web bin/rails db:seed
