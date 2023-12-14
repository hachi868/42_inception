FROM debian:oldstable

RUN apt-get update && apt-get install -y apache2

#todo: compose.ymlで
#COPY httpd.conf /etc/apache2/httpd.conf

CMD ["apache2ctl", "-D", "FOREGROUND"]