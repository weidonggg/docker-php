FROM php:7.4-fpm-alpine3.14

LABEL maintainer="Zhao Weidong<1993plus@gmail.com>"

ENV EXT_PATH /usr/src/php/ext
ENV EXT_DOWNLOAD_DIR /usr/src/ext
ENV PECL_URL http://pecl.php.net/get
ENV EXT_REDIS_VERSION 5.3.4

RUN set -ex -o pipefail; \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories; \
    apk add --no-cache --virtual .build-deps \
            libpng-dev \
            freetype-dev \
            libwebp-dev \
            libxpm-dev \
            libjpeg-turbo-dev \
            gettext-dev \
            imap-dev \
            icu-dev \
            zlib-dev \
            libxml2-dev \
            libzip-dev; \
        \
    docker-php-ext-configure gd --with-webp --with-jpeg --with-xpm --with-freetype; \
    docker-php-ext-install -j$(nproc) gd \
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
    ## Install redis extension.
    docker-php-source extract; \
    mkdir -p $EXT_DOWNLOAD_DIR \
    && cd $EXT_DOWNLOAD_DIR; \
    \
    wget $PECL_URL/redis-$EXT_REDIS_VERSION.tar \
    && tar xf redis-$EXT_REDIS_VERSION.tar \
    && mv redis-$EXT_REDIS_VERSION $EXT_PATH/redis \
    && docker-php-ext-install redis; \
    #apk del --no-network .build-deps; \
    rm -rf /tmp/pear ~/.pearrc; \
    docker-php-source delete; \
    rm -rf $EXT_DOWNLOAD_DIR; \
    php --version; \
    php -m