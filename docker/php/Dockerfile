ARG PHP_VERSION=8.3

FROM php:${PHP_VERSION}-fpm-alpine

ARG APP_DEV_DOMAIN

RUN apk add --no-cache \
    $PHPIZE_DEPS \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    msmtp \
    supercronic

RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg

RUN docker-php-ext-install gd pdo_mysql mysqli

RUN pecl install redis \
    && docker-php-ext-enable redis

RUN apk del $PHPIZE_DEPS
RUN rm -rf /var/cache/apk/*

# Generate SSL certificates for development
RUN mkdir -p /opt/certs

COPY ./docker/php/openssl.cnf /opt/certs/openssl.cnf

RUN sed -i "s/APP_DEV_DOMAIN/${APP_DEV_DOMAIN}/g" /opt/certs/openssl.cnf

RUN openssl genrsa -out /opt/certs/server.key 2048 && \
    openssl req \
        -x509 \
        -nodes \
        -days 3650 \
        -newkey rsa:2048 \
        -keyout /opt/certs/server.key \
        -out /opt/certs/server.crt \
        -config /opt/certs/openssl.cnf

RUN cp /opt/certs/server.crt /usr/local/share/ca-certificates/server.crt && \
    update-ca-certificates

RUN chown -R www-data:www-data /opt/certs

COPY ./docker/php/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh
