RAILS_ENV := development
DC_SERVICE := web

default: up

bash:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bash -i -l

build:
	@docker compose build

dbmigrate:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bundle exec rails db:migrate

dbrollback:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bundle exec rails db:rollback

dbsetup:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bundle exec rails db:setup

down:
	@docker compose down

railsc:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bundle exec rails c

rspec:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bundle exec rspec

seed:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bundle exec rake db:seed

test:
	@docker compose exec -e RAILS_ENV=$(RAILS_ENV) $(DC_SERVICE) bundle exec rails test

up:
	@docker compose up

upd:
	@docker compose up -d

.PHONY: default bash dbmigrate dbrollback down railsc test up upd
