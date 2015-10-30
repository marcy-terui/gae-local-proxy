#!/bin/sh

composer install
chmod -R 777 $APP_DIR

php-fpm
