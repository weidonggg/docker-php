FROM cdce/php:7.4-cli-alpine3.11

LABEL MAINTAINER "Zhaoweidong<zhaoweidong@300.cn>"

ENV ENV /etc/profile 
ENV EXT_PDO_SQLSVR_VERSION 5.8.1
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
    # pdo_sqlsvr
    && wget $PECL_URL/pdo_sqlsvr-$EXT_PDO_SQLSVR_VERSION.tar \
    && tar xf pdo_sqlsvr-$EXT_PDO_SQLSVR_VERSION.tar \
    && mv imagick-$EXT_PDO_SQLSVR_VERSION $EXT_PATH/pdo_sqlsvr \
    && apk add --no-cache unixodbc-dev \
    && docker-php-ext-install pdo_sqlsrv \
    # Remove temporary files.
    && docker-php-source delete \
    && rm -rf $EXT_DOWNLOAD_DIR
