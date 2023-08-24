#
# version: 0.1.0
# このファイルが変更されていたらcodeBuildで新しくイメージが作られる
#
FROM public.ecr.aws/docker/library/php:8.1.2-fpm-buster as base

RUN apt-get update && apt-get install -y \
        git \
        curl \
        zip \
        unzip \
        libxml2-dev \
        cron \
        supervisor \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
        tzdata \
        libonig-dev \
        libcurl4-openssl-dev \
        imagemagick libmagickwand-dev \
#        ffmpeg mediainfo \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& docker-php-ext-configure gd --with-freetype --with-jpeg \
&& docker-php-ext-install -j$(nproc) \
        opcache \
        pdo_mysql \
        mbstring \
        xml \
        curl \
        session \
        iconv \
        gd \
        exif \
        zip \
		    bcmath \
#        sockets \
#&& pecl install redis-5.3.3 \
#&& docker-php-ext-enable redis \
&& pecl install imagick \
&& docker-php-ext-enable imagick \
&& docker-php-source delete

#ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

# install composer
ENV COMPOSER_ALLOW_SUPERUSER 1
COPY --from=composer:2.4.3 /usr/bin/composer /usr/local/bin/composer

COPY ./conf/supervisord.conf /etc/supervisord.conf
COPY conf/php.ini /usr/local/etc/php/php.ini
COPY conf/php-fpm.d/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY conf/php-fpm.d/docker.conf /usr/local/etc/php-fpm.d/docker.conf
ADD conf/crontabs/www-data /var/spool/cron/crontabs/www-data
RUN chmod 600 /var/spool/cron/crontabs/www-data && chown www-data:www-data /var/spool/cron/crontabs/www-data

RUN rm /etc/localtime \
&& cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

WORKDIR /var/www/

CMD sh -c 'supervisord -c /etc/supervisord.conf'

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# install nodejs
#COPY --from=node:16.14 /usr/local/bin /usr/local/bin
#COPY --from=node:16.14 /usr/local/lib /usr/local/lib


FROM base as production

COPY ./docker-entrypoint.prod.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

FROM base as dev
RUN apt-get update && apt-get install -y vim procps mariadb-client \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

FROM dev as local

