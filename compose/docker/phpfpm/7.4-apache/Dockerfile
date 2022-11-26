FROM php:7.4-apache

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCorner.id"
ENV AUTHOR="Dwi Fahni Denni <support@devopscorner.id>"
ENV IMG_NAME="phpfpm"
ENV IMG_VERSION="7.4"
ENV IMG_DESC="Docker Image PHP-Fpm 7.4"
ENV IMG_ARCH="amd64/x86_64"

ENV PHP_VERSION="7.4"

LABEL maintainer="$AUTHOR" \
    architecture="$IMG_ARCH" \
    php-version="$PHP_VERSION" \
    org.label-schema.build-date="$BUILD_DATE" \
    org.label-schema.name="$IMG_NAME" \
    org.label-schema.description="$IMG_DESC" \
    org.label-schema.vcs-ref="$GIT_COMMIT" \
    org.label-schema.vcs-url="$GIT_URL" \
    org.label-schema.vendor="$VENDOR" \
    org.label-schema.version="$BUILD_VERSION" \
    org.label-schema.schema-version="$IMG_VERSION" \
    org.opencontainers.image.authors="$AUTHOR" \
    org.opencontainers.image.description="$IMG_DESC" \
    org.opencontainers.image.vendor="$VENDOR" \
    org.opencontainers.image.version="$IMG_VERSION" \
    org.opencontainers.image.revision="$GIT_COMMIT" \
    org.opencontainers.image.created="$BUILD_DATE" \
    fr.hbis.docker.base.build-date="$BUILD_DATE" \
    fr.hbis.docker.base.name="$IMG_NAME" \
    fr.hbis.docker.base.vendor="$VENDOR" \
    fr.hbis.docker.base.version="$BUILD_VERSION"

# Install packages
RUN apt-get update && apt-get install -y \
    git \
    zip \
    curl \
    sudo \
    unzip \
    libicu-dev \
    libbz2-dev \
    libpng-dev \
    libjpeg-dev \
    libmcrypt-dev \
    libreadline-dev \
    libfreetype6-dev \
    g++

# Apache configuration
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN a2enmod rewrite headers

# Common PHP Extensions
RUN docker-php-ext-install \
    bz2 \
    intl \
    iconv \
    bcmath \
    opcache \
    calendar \
    pdo_mysql

# Ensure PHP logs are captured by the container
ENV LOG_CHANNEL=stderr

# Set a volume mount point for your code
VOLUME /var/www/html

# Copy code and run composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY src /var/www/tmp
COPY docker-entrypoint.sh /var/www/tmp
RUN cd /var/www/tmp && composer install --no-dev

# Ensure the entrypoint file can be run
RUN chmod +x /var/www/tmp/docker-entrypoint.sh
ENTRYPOINT ["/var/www/tmp/docker-entrypoint.sh"]

# The default apache run command
CMD ["apache2-foreground"]