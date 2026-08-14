kill: stop
	docker system prune
	docker network prune
	docker volume prune

init:
	docker network create proxy-net

stop:
	docker stop $$(docker ps -aq)

## daily commands ##
start-traefik:
	docker compose -f ./infra/traefik.yaml up -d
