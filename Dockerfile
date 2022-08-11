FROM composer:latest AS composer
FROM node:latest AS node
FROM php:latest

RUN apt-get update && apt-get upgrade -y
RUN apt install git -y

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
RUN npm install -g npm@8.17.0

WORKDIR /var/www/html

RUN php --version
RUN composer --version
RUN node --version

#RUN composer install \
#    --no-interaction \
#    --prefer-source

#RUN npm install

EXPOSE 8000
CMD ["php", "artisan", "serve"]

