ARG PHP_VERSION=8.3

FROM php:${PHP_VERSION}-fpm-alpine

RUN apk add --no-cache \
    $PHPIZE_DEPS \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    msmtp

RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg

RUN docker-php-ext-install gd pdo_mysql mysqli

RUN pecl install redis \
    && docker-php-ext-enable redis

RUN apk del $PHPIZE_DEPS
RUN rm -rf /var/cache/apk/*
