# https://www.digitalocean.com/community/tutorials/how-to-set-up-laravel-nginx-and-mysql-with-docker-compose#step-4-creating-the-dockerfile
FROM php:8.1.24-fpm

ARG APP_PATH=/var/www/app
ARG APP_USER
ARG APP_GROUP
ARG APP_GROUP_GID
ARG APP_USER_UID

RUN apt-get update &&  \
    apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    libpq-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    unzip \
    git \
    curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-install pdo pdo_pgsql pgsql mbstring zip exif pcntl

RUN docker-php-ext-configure gd

RUN groupmod -g $APP_GROUP_GID $APP_GROUP && \
    usermod -u $APP_USER_UID $APP_USER && \
    #groupadd -g $APP_GROUP_GID $APP_GROUP && \
    #useradd -u $APP_USER_UID -ms /bin/bash -g $APP_GROUP $APP_USER && \
    mkdir $APP_PATH && \
    chown $APP_USER:$APP_GROUP $APP_PATH && \
    chown $APP_USER:$APP_GROUP $APP_PATH/../

# https://getcomposer.org/doc/00-intro.md#docker-image
COPY --from=composer/composer:2.6.4-bin /composer /usr/local/bin

COPY ./php.ini /etc/php/8.1/fpm/php.ini
COPY ./php.ini /etc/php/8.1/cli/php.ini

USER $APP_USER

EXPOSE 9000
CMD ["php-fpm"]