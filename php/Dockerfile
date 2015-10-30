FROM php:5.5-fpm

RUN apt-get update && apt-get install -y \
        zip \
        git \
        gcc \
        libmysqlclient-dev \
        libxml2-dev \
    && docker-php-ext-install pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

COPY run_app.sh /run_app.sh
CMD ["sh", "/run_app.sh"]
