DOCKER_COMPOSE_PHP=docker compose exec php

enter:
	$(DOCKER_COMPOSE_PHP) bash

start:
	docker compose up -d --no-recreate --remove-orphans

down:
	docker compose down --remove-orphans

build: 
	docker compose build --no-cache --force-rm

install:
	$(DOCKER_COMPOSE_PHP) composer install --no-cache --no-interaction --optimize-autoloader

stop:
	docker compose stop

info:
	$(DOCKER_COMPOSE_PHP) php -v
	
list:
	docker compose ps

restart:
	docker compose restart

build:
	docker compose build
