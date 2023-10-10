COMPOSE_FILE := ./srcs/docker-compose.yml

setup:
	@make up
	@make ps

# コンテナを起動するターゲット
up:
	docker compose -f $(COMPOSE_FILE) up -d

# コンテナを停止するターゲット
down:
	docker compose -f $(COMPOSE_FILE) down

# コンテナのステータスを表示するターゲット
ps:
	docker compose -f $(COMPOSE_FILE) ps
#logs:
#	docker compose -f $(COMPOSE_FILE) logs
#build:
#	docker compose -f $(COMPOSE_FILE) build
rm:
	docker compose -f $(COMPOSE_FILE) rm

.PHONY: setup up down ps rm
