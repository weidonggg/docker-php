FROM cdce/php:7.1-ext as builder

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

FROM cdce/php:7.1-ext as prod

LABEL maintainer "ZhaoWeidong <zhaoweidong@gouuse.cn>"

COPY --from=0 /usr/local/lib/php/extensions/no-debug-non-zts-20180731/swoole.so /usr/local/lib/php/extensions/no-debug-non-zts-20180731/

RUN set -ex \
    && docker-php-ext-enable swoole; \
    \
     \
      \
    cd /usr/local/etc/php \
    && curl -o php.ini https://raw.githubusercontent.com/1993Plus/docker-php/master/php.ini; \
     \
##### add system crontab task.
    { \
        echo "# min	hour	day	month	weekday	command"; \
        echo "*       *       *       *       *       /usr/bin/flock -xn /var/run/test.lock -c '/usr/local/bin/php /opt/nginx/html/artisan schedule:run  1>>/opt/nginx/html/storage/logs/cron.log 2>&1'"; \
    } > /var/spool/cron/crontabs/root; \
    \
     \
      \
##### Modify docker-php-entrypoint, add crond.
    { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo '# first arg is `-f` or `--some-option`'; \
        echo 'if [ "${1#-}" != "$1" ]; then'; \
        echo '	crond -b -d 8'; \
        echo '  rm -rf /var/tmp/*'; \
        echo '	set -- php "$@"'; \
        echo 'fi'; \
        echo 'crond -b -d 8'; \
        echo 'rm -rf /var/tmp/*'; \
        echo 'exec "$@"'; \
    } > /usr/local/bin/docker-php-entrypoint; \
    \
    cd /usr/bin \
    && ln -snf ../local/bin/docker-php-entrypoint docker-php-entrypoint

WORKDIR /opt/nginx/html