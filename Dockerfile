ARG PHP_IMAGE=php:5.5.38-fpm

FROM ${PHP_IMAGE} as php

# Maj list paquet
RUN set -xe && \
        echo "deb http://archive.debian.org/debian/ jessie main" > /etc/apt/sources.list && \
        echo "deb-src http://archive.debian.org/debian/ jessie main" >> /etc/apt/sources.list && \
        apt-get update && \
        docker-php-source extract && \
        pecl install xdebug-2.5.5 && \
        docker-php-ext-enable xdebug && \
        apt-get install -y --force-yes zlib1g-dev libzip-dev && \
        apt-get install -y --force-yes unzip && \
        apt-get install -y --force-yes git && \
        docker-php-ext-install zip && \
        docker-php-source delete && \
        php -v && \
        php -m

COPY ./ /var/www/html/

# Composer
COPY --from=composer:2.2 /usr/bin/composer /usr/local/bin/composer

RUN apt-get install -y --force-yes --no-install-recommends ca-certificates
ENV COMPOSER_CAFILE=/etc/ssl/certs/ca-certificates.crt

RUN composer install

# clean
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get clean

ENV PATH "$PATH:/var/www/html/"

USER ${USER_ID}
