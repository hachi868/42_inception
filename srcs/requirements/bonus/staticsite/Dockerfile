FROM debian:oldstable

RUN apt-get update && apt-get install -y apache2

COPY ./public /var/www/html

CMD ["apache2ctl", "-D", "FOREGROUND"]
