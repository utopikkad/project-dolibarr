FROM php:7.2-apache
MAINTAINER HH

RUN apt-get update \
	&& apt-get install -y \
		wget unzip systemd

RUN wget \
  -O /tmp/dolibarr-10-0 \
  https://codeload.github.com/Dolibarr/dolibarr/zip/10.0

RUN unzip -d /usr/src /tmp/dolibarr-10-0 \
	&& chown -R www-data:www-data /usr/src/dolibarr-10.0 \
	&& rm -fr /var/www/html \
	&& cp -a /usr/src/dolibarr-10.0 /var/www/html

RUN touch htdocs/conf/conf.php \
    && chown www-data htdocs/conf/conf.php


RUN sed -i -e  "s/\/var\/www\/html/\/var\/www\/html\/htdocs/g" \
    /etc/apache2/sites-enabled/000-default.conf


CMD /usr/sbin/apache2ctl -D FOREGROUND
