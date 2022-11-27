FROM devopscorner/phpfpm:latest

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCorner.id"
ENV AUTHOR="Dwi Fahni Denni <support@devopscorner.id>"
ENV IMG_NAME="laravel"
ENV IMG_VERSION="9.41"
ENV IMG_DESC="Docker Image Laravel 9.x"
ENV IMG_ARCH="amd64/x86_64"

ENV PHPFPM_VERSION=8.1-alpine3.16
ENV ALPINE_VERSION=3.16

LABEL maintainer="$AUTHOR" \
    architecture="$IMG_ARCH" \
    laravel-version="$IMG_DESC" \
    phpfpm-version="$PHPFPM_VERSION" \
    alpine-version="$ALPINE_VERSION" \
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

# Ensure PHP logs are captured by the container
ENV LOG_CHANNEL=stderr

# Copy code and run composer
RUN mkdir -p /usr/share/nginx/laravel
COPY src /usr/share/nginx/laravel
RUN cd /usr/share/nginx/laravel && \
   rm -f composer.lock && \
   rm -rf vendor && \
   composer install --no-dev; sync

# Set a volume mount point for your code
VOLUME /usr/share/nginx/laravel
WORKDIR /usr/share/nginx/laravel

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9000
CMD ["php-fpm"]
