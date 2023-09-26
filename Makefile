COMPOSE_YAML := docker-compose.yml

setup:
	@make up
	@make ps
up:
	docker compose up -d
down:
	docker compose down
rm:
	docker compose rm
ps:
	docker compose ps

.PHONY: setup up d b ps