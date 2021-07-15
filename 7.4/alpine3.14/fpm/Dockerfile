FROM php:7.4-fpm-alpine3.14

LABEL maintainer="Zhao Weidong<1993plus@gmail.com>"


RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
        libpng-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        gettext-dev \
        imap-dev \
        icu-dev \
        zlib-dev \
        libzip-dev \
    && docker-php-ext-configure gd --with-webp --with-jpeg --with-xpm --with-freetype \
    && docker-php-ext-install -j$(nproc) gd \
           bcmath \
           intl \
           mysqli \
           pcntl \
           pdo_mysql \
           shmop \
           soap \
           sockets \
           xmlrpc \
           zip \
           gettext;\
     \
    apk del --no-network .build-deps; \
    rm -rf /tmp/pear ~/.pearrc; \
    php --version; \
    php -m