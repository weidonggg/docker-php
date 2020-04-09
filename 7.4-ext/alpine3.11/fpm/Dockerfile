FROM cdce/php:7.4-fpm-alpine3.11

LABEL MAINTAINER "Zhaoweidong<zhaoweidong@300.cn>"

ENV ENV /etc/profile 
#ENV EXT_IGBINARY_VERSION 3.0.1
#ENV EXT_IMAGICK_VERSION 3.4.4
#ENV EXT_MAILPARSE_VERSION 3.0.3
#ENV EXT_MCRYPT_VERSION 1.0.2
#ENV EXT_MONGODB_VERSION 1.5.3
#ENV EXT_MSGPACK_VERSION 2.0.3
ENV EXT_REDIS_VERSION 5.2.1
#ENV EXT_YAML_VERSION 2.0.4
ENV EXT_PATH /usr/src/php/ext
ENV EXT_DOWNLOAD_DIR /usr/src/ext
ENV PECL_URL http://pecl.php.net/get
ENV TIMEZONE Asia/Shanghai

RUN set -ex \
##### Setting Timezone to Asia/Shanghai.
    && apk add --no-cache tzdata \
    && ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo $TIMEZONE > /etc/timezone; \
     \
      \
       \
##### Setting shell profile.
    # add command alias.
    { \
    echo "export LS_OPTIONS='--color=auto'"; \
    echo "alias ll='ls $LS_OPTIONS -l'"; \
    } >> ~/.ash_profile; \
    { \
    echo "if [ -f ~/.ash_profile ]; then"; \
    echo "    . ~/.ash_profile"; \
    echo "fi"; \
    } >> /etc/profile; \
     \
      \
       \
##### Install php expansions.
    docker-php-source extract \
    && mkdir -p $EXT_DOWNLOAD_DIR \
    && cd $EXT_DOWNLOAD_DIR \
    # redis
    && wget $PECL_URL/redis-$EXT_REDIS_VERSION.tar \
    && tar xf redis-$EXT_REDIS_VERSION.tar \
    && mv redis-$EXT_REDIS_VERSION $EXT_PATH/redis \
    && docker-php-ext-install redis \
    # Remove temporary files.
    && docker-php-source delete \
    && rm -rf $EXT_DOWNLOAD_DIR
