ARG TAG

FROM mariadb:${MARIADB_VERSION:-10.5.12}

ARG BUILD_DATE
ARG BUILD_VERSION
ARG GIT_COMMIT
ARG GIT_URL

ENV VENDOR="DevOpsCorner.id"
ENV AUTHOR="Dwi Fahni Denni <dfdenni@devopscorner.id>"
ENV IMG_NAME="mariadb"
ENV IMG_VERSION="10.5.12"
ENV IMG_DESC="Docker Image MariaDB 10.5.12"
ENV IMG_ARCH="amd64/x86_64"

ENV MARIADB_VERSION="10.5.12"

LABEL maintainer="$AUTHOR" \
    architecture="$IMG_ARCH" \
    mariadb-version="$MARIADB_VERSION" \
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

COPY rootfs /

RUN mkdir -p /docker-entrypoint-initdb.d && \
    mkdir -p /scripts/pre-exec.d && \
    mkdir -p /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]