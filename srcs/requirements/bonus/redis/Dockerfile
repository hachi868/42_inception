FROM debian:oldstable

RUN apt-get update && apt-get install -y redis-server

CMD ["/usr/bin/redis-server", "/etc/redis/redis.conf"]