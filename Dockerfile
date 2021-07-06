FROM ubuntu:20.04

LABEL maintainer="Xantios Krugor"

# Set noninteractive flag for setups
ENV DEBIAN_FRONTEND noninteractive

# Set timezone
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt install -y vim gnupg curl ca-certificates zip unzip git sqlite3 software-properties-common inetutils-ping build-essential neofetch

# Install PHP 8
RUN add-apt-repository -y ppa:ondrej/php && add-apt-repository ppa:ondrej/nginx-mainline && apt-get update && apt-get -y install php8.0-cli php8.0-dev php8.0-pgsql php8.0-mbstring php8.0 php8.0-mysql php8.0-gd php8.0-xdebug php8.0-fpm

# Install nginx
RUN apt-get update && apt-get -y install -y nginx

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && chmod +x /usr/local/bin/composer

# Install maple 
RUN composer global require xantios/maple

# FPM Config:
# /etc/php8.0/fpm/php-fpm.conf
# /etc/php/8.0/fpm/conf.d/*
#
# Pool config is in:
# /etc/php/8.0/fpm/pool.d/www.conf

# Setup listen
RUN sed -i "s+listen = /run/php/php8.0-fpm.sock+listen = 9000+g" /etc/php/8.0/fpm/pool.d/www.conf

# Setup pid
RUN sed -i "s+pid = /run/php/php8.0-fpm.pid+pid = /var/run/php-fpm.pid+g" /etc/php/8.0/fpm/php-fpm.conf

# Copy Maple conf
COPY ./maple-config.php /maple-config.php

# Copy VHOST
COPY ./vhost.conf /etc/nginx/sites-available/default

# Tell nginx to not log output to a file
RUN sed -i "s+access_log /var/log/nginx/access.log;+access_log stdout;+g" /etc/nginx/nginx.conf && \
    sed -i "s+error_log /var/log/nginx/error.log;+error_log stderr;+g" /etc/nginx/nginx.conf

# Setup xDebug / step debugging
COPY xdebug.ini /etc/php/8.0/mods-available/xdebug.ini

# To run webpack and other utilitys NodeJS is rather usefull
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt-get -y install nodejs

# Just to have a bit of a nicer shell
COPY dot_bashrc /root/.bashrc

# Nginx
EXPOSE 80

# Maple
EXPOSE 8100

# FPM
EXPOSE 9000

ENTRYPOINT [ "/root/.config/composer/vendor/bin/maple" ];