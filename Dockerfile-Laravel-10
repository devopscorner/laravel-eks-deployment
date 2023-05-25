FROM devopscorner/phpfpm:latest

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCorner.id"
ENV AUTHOR="Dwi Fahni Denni <support@devopscorner.id>"
ENV IMG_NAME="laravel"
ENV IMG_VERSION="10.12.0"
ENV IMG_DESC="Docker Image Laravel 10.x"
ENV IMG_ARCH="amd64/x86_64"

ENV PHPFPM_VERSION=8.1-alpine3.17
ENV ALPINE_VERSION=3.17
ENV AWS_CLI_VERSION=2.9.1
ENV VERIFY_CHECKSUM=false

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

USER root
RUN apk add --no-cache \
    git \
    curl \
    zip \
    unzip \
    wget; sync

RUN apk add --no-cache \
    build-base \
    bash \
    jq \
    ca-certificates \
    openssl \
    openssh \
    openssh-server \
    vim \
    busybox-extras \
    nano \
    gcompat \
    groff \
    cmake \
    libffi-dev \
    bzip2-dev \
    python3 \
    python3-dev \
    py3-pip &&\
    set -ex; sync

# =================== #
#  Install AWSCli v2  #
# =================== #
# RUN curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip -o awscliv2.zip &&\
#       unzip awscliv2.zip; sync &&\
#       ./aws/install --bin-dir /usr/local/bin/; sync
COPY --from=devopscorner/aws-cli:latest /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=devopscorner/aws-cli:latest /usr/local/bin/ /usr/local/bin/

# ========================= #
# Install Python Libraries  #
# ========================= #
RUN python3 -m pip install pip &&\
    pip3 install --upgrade pip==22.3.1 cffi &&\
    pip3 install --no-cache-dir \
    PyYaml \
    Jinja2 \
    httplib2 \
    six \
    requests \
    boto3 &&\
    # setup root .ssh directory
    mkdir -p /root/.ssh &&\
    chmod 0700 /root/.ssh &&\
    chown -R root. /root/.ssh; sync

# Copy code and run composer
RUN mkdir -p /usr/share/nginx/laravel
COPY src /usr/share/nginx/laravel
RUN cd /usr/share/nginx/laravel && \
   rm -f composer.lock && \
   rm -rf vendor && \
   composer install --no-dev; sync

# ============= #
#  Cleanup All  #
# ============= #
RUN rm -rf /var/cache/apk/* /root/.cache /tmp/*

# Set a volume mount point for your code
VOLUME /usr/share/nginx/laravel
WORKDIR /usr/share/nginx/laravel

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9000
CMD ["php-fpm"]
