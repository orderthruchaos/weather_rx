RAILS_ENV := development
DC_SERVICE := web

up:
	@docker compose up 

upd:
	@docker compose up -d

down:
	@docker compose down

bash:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bash -i -l

dbmigrate:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bundle exec rails db:migrate

dbrollback:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bundle exec rails db:rollback

railsc:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bundle exec rails c

test:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bundle exec rails test

.PHONY: up upd down bash dbmigrate dbrollback railsc test
