FROM php:7.2-apache
RUN apt-get update 
RUN apt-get -y install git
RUN git clone https://git.tt-rss.org/fox/tt-rss.git /var/www/html
RUN apt-get -y install libpq-dev
RUN apt-get -y install zlib1g-dev libicu-dev g++
RUN apt-get -y install vim cron
RUN docker-php-ext-configure intl
RUN docker-php-ext-install pdo pdo_pgsql pgsql intl
COPY init /init
RUN echo "*/5 *  *  *  *  www-data   /usr/local/bin/php /var/www/html/update.php --feeds --quiet" >> /etc/crontab
EXPOSE 80
ENTRYPOINT [ "/init" ]
