FROM php:latest
FROM composer:latest AS composer
FROM node:latest AS node

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

#COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
#COPY --from=node /usr/local/bin/node /usr/local/bin/node
#RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm

WORKDIR /var/www
RUN mkdir app 

WORKDIR /var/www/app

EXPOSE 8000
COPY . .
RUN "composer install"
