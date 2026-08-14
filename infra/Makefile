kill: stop
	docker system prune
	docker network prune
	docker volume prune

init:
	docker network create proxy-net

start-services:
	docker compose -f group1/compose.yaml up -d --build --force-recreate
	#docker compose -f group2/compose.yaml up -d --build	--force-recreate

stop:
	docker stop $$(docker ps -aq)

## daily commands ##
start-proxy:
	docker compose -f compose.yaml up -d
start-components:
	docker compose -f group1/compose.yaml up -d
	#docker compose -f group2/compose.yaml up -d
boot: start-proxy start-components
