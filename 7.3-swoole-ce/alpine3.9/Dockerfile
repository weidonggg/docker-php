FROM cdce/php:7.3-ext as builder

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

FROM cdce/php:7.3-ext as prod

LABEL maintainer "ZhaoWeidong <zhaoweidong@gouuse.cn>"

COPY --from=0 /usr/local/lib/php/extensions/no-debug-non-zts-20180731/swoole.so /usr/local/lib/php/extensions/no-debug-non-zts-20180731/

RUN set -ex \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
##### Install bash.
    $$ apk add --no-cache bash \
    && docker-php-ext-enable swoole; \
    \
     \
      \
    cd /usr/local/etc/php \
    && curl -o php.ini https://raw.githubusercontent.com/1993Plus/docker-php/master/php.ini; \
    \
##### Modify docker-php-entrypoint,remove swoole server pid file.
    { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo '# first arg is `-f` or `--some-option`'; \
        echo 'if [ "${1#-}" != "$1" ]; then'; \
        echo '  rm -rf /var/tmp/*'; \
        echo '	set -- php "$@"'; \
        echo 'fi'; \
        echo 'rm -rf /var/tmp/*'; \
        echo 'exec "$@"'; \
    } > /usr/local/bin/docker-php-entrypoint; \
     \
    cd /usr/bin \
    && ln -snf ../local/bin/docker-php-entrypoint docker-php-entrypoint; \
    \ 
     \
      \
    addgroup -g 90 -S zceo \
    && adduser -S -H -k -D -s /sbin/nologin -G zceo -u 90 zceo \
    && wget -O /usr/bin/gosu https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64 \
    && chmod +x /usr/bin/gosu \
    && mkdir -p /apps \
    && wget -O /apps/run.sh https://raw.githubusercontent.com/1993Plus/docker-php/master/run.sh \
    && chmod +x /apps/run.sh

WORKDIR /apps/
