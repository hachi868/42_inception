COMPOSE_FILE := ./srcs/docker-compose.yml

# デフォルトはsetup
setup:
	@make up
	@make ps

# コンテナを起動するターゲット -f ファイル指定 -d デタッチモード(バックグラウンドで起動)
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

# キャッシュなしでbuild
build:
	docker compose -f $(COMPOSE_FILE) build --no-cache
#	docker compose -f $(COMPOSE_FILE) build --no-cache --progress=plain

rm:
	docker compose -f $(COMPOSE_FILE) rm

.PHONY: setup up down ps build rm
