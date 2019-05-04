FROM weidong93/php:latest

LABEL maintainer "ZhaoWeidong <zhaoweidong@gouuse.cn>"

ENV EXT_IGBINARY_VERSION 3.0.1
ENV EXT_IMAGICK_VERSION 3.4.4
ENV EXT_MAILPARSE_VERSION 3.0.3
ENV EXT_MCRYPT_VERSION 1.0.2
ENV EXT_MONGODB_VERSION 1.5.3
ENV EXT_MSGPACK_VERSION 2.0.3
ENV EXT_REDIS_VERSION 4.3.0
ENV EXT_YAML_VERSION 2.0.4
ENV EXT_PATH /usr/src/php/ext
ENV EXT_DOWNLOAD_DIR /usr/src/ext
ENV PECL_URL http://pecl.php.net/get

RUN set -ex \
    && docker-php-source extract \
    && mkdir -p $EXT_DOWNLOAD_DIR \
    && cd $EXT_DOWNLOAD_DIR \
    && wget $PECL_URL/igbinary-$EXT_IGBINARY_VERSION.tar \
    && tar xf igbinary-$EXT_IGBINARY_VERSION.tar \
    && mv igbinary-$EXT_IGBINARY_VERSION $EXT_PATH/igbinary \
    && docker-php-ext-install igbinary \
    && wget $PECL_URL/imagick-$EXT_IMAGICK_VERSION.tar \
    && tar xf imagick-$EXT_IMAGICK_VERSION.tar \
    && mv imagick-$EXT_IMAGICK_VERSION $EXT_PATH/imagick \
    && apk add --no-cache imagemagick-dev \
    && docker-php-ext-install imagick \
    && wget $PECL_URL/mailparse-$EXT_MAILPARSE_VERSION.tar \
    && tar xf mailparse-$EXT_MAILPARSE_VERSION.tar \
    && mv mailparse-$EXT_MAILPARSE_VERSION $EXT_PATH/mailparse \
    && docker-php-ext-install mailparse \
    && wget $PECL_URL/mcrypt-$EXT_MCRYPT_VERSION.tar \
    && tar xf mcrypt-$EXT_MCRYPT_VERSION.tar \
    && mv mcrypt-$EXT_MCRYPT_VERSION $EXT_PATH/mcrypt \
    && apk add --no-cache libmcrypt-dev \
    && docker-php-ext-install mcrypt \
    && wget $PECL_URL/mongodb-$EXT_MONGODB_VERSION.tar \
    && tar xf mongodb-$EXT_MONGODB_VERSION.tar \
    && mv mongodb-$EXT_MONGODB_VERSION $EXT_PATH/mongodb \
    && docker-php-ext-install mongodb \
    && wget $PECL_URL/msgpack-$EXT_MSGPACK_VERSION.tar \
    && tar xf msgpack-$EXT_MSGPACK_VERSION.tar \
    && mv msgpack-$EXT_MSGPACK_VERSION $EXT_PATH/msgpack \
    && docker-php-ext-install msgpack \
    && wget $PECL_URL/redis-$EXT_REDIS_VERSION.tar \
    && tar xf redis-$EXT_REDIS_VERSION.tar \
    && mv redis-$EXT_REDIS_VERSION $EXT_PATH/redis \
    && docker-php-ext-install redis \
    && apk add --no-cache yaml-dev \
    && wget $PECL_URL/yaml-$EXT_YAML_VERSION.tar \
    && tar xf yaml-$EXT_YAML_VERSION.tar \
    && mv yaml-$EXT_YAML_VERSION $EXT_PATH/yaml \
    && docker-php-ext-install yaml \
    && docker-php-source delete \
    && rm -rf $EXT_DOWNLOAD_DIR
