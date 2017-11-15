FROM python:2.7-alpine3.6

ENV PYENV_ROOT /opt/pyenv
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN set -x \
    && GLIBC_PACKAGE_VERSION="2.26-r0" \
    && GLIBC_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_PACKAGE_VERSION" \
    && GLIBC_SSH_KEY="/etc/apk/keys/sgerrand.rsa.pub" \
    && GLIBC_PACKAGE_FILE="glibc-$GLIBC_PACKAGE_VERSION.apk" \
    && GLIBC_BIN_PACKAGE_FILE="glibc-bin-$GLIBC_PACKAGE_VERSION.apk" \
    && apk add --no-cache --virtual=.fetchdeps wget ca-certificates \
    && wget -q -O "$GLIBC_SSH_KEY" "https://raw.githubusercontent.com/andyshinn/alpine-pkg-glibc/master/sgerrand.rsa.pub" \
    && wget -q \
       "$GLIBC_URL/$GLIBC_PACKAGE_FILE" \
       "$GLIBC_URL/$GLIBC_BIN_PACKAGE_FILE" \
    && apk add --no-cache \
       "$GLIBC_PACKAGE_FILE" \
       "$GLIBC_BIN_PACKAGE_FILE" \
    && apk del .fetchdeps \
    && rm "$GLIBC_SSH_KEY" \
    && rm ~/.wget-hsts \
    && rm \
       "$GLIBC_PACKAGE_FILE" \
       "$GLIBC_BIN_PACKAGE_FILE"

RUN set -x \
    && apk add --no-cache \
       bash="4.3.48-r1" \
       build-base="0.5-r0" \
       bzip2-dev="1.0.6-r5" \
       bzip2="1.0.6-r5" \
       curl="7.56.1-r0" \
       git="2.13.5-r0" \
       linux-headers="4.4.6-r2" \
       ncurses-dev="6.0_p20170930-r0" \
       openssl-dev="1.0.2m-r0" \
       openssl="1.0.2m-r0" \
       patch="2.7.5-r1" \
       readline-dev="6.3.008-r5" \
       sqlite-dev="3.20.1-r0" \
       xz-libs="5.2.3-r0" \
       zlib-dev="1.2.11-r0" \
    && mkdir -p "$PYENV_ROOT" \
    && git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT" \
    && ( cd "$PYENV_ROOT" && git checkout -q "v1.1.4" ) \
    && rm -r "$PYENV_ROOT/.git"
