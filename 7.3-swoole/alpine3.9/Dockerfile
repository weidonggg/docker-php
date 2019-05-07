FROM weidong93/php:7.3-ext as builder

LABEL maintainer "ZhaoWeidong <zhaoweidong@gouuse.cn>"

ENV EXT_SWOOLE_VERSION 4.3.3
ENV EXT_DOWNLOAD_DIR /usr/src/ext

RUN set -ex \
    && docker-php-source extract \
    && mkdir -p $EXT_DOWNLOAD_DIR \
    && cd $EXT_DOWNLOAD_DIR \
    && wget -O swoole-src-$EXT_SWOOLE_VERSION.tar.gz https://github.com/swoole/swoole-src/archive/v$EXT_SWOOLE_VERSION.tar.gz \
    && tar xf swoole-src-$EXT_SWOOLE_VERSION.tar.gz \
    && mv swoole-src-$EXT_SWOOLE_VERSION /usr/src/php/ext/swoole \
    && apk add --no-cache openssl-dev \
    && docker-php-ext-configure swoole --enable-openssl \
    && docker-php-ext-install swoole 

FROM weidong93/php:7.3-ext as prod

LABEL maintainer "ZhaoWeidong <zhaoweidong@gouuse.cn>"

COPY --from=0 /usr/local/lib/php/extensions/no-debug-non-zts-20180731/swoole.so /usr/local/lib/php/extensions/no-debug-non-zts-20180731/

RUN set -ex \
    && docker-php-ext-enable swoole; \
    \
     \
      \
    cd /usr/local/etc/php \
    && cp php.ini-production php.ini; \
    \
    cd /usr/bin \
    && ln -snf ../local/bin/docker-php-entrypoint docker-php-entrypoint

WORKDIR /opt/nginx/html
