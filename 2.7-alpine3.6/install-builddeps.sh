#!/bin/sh

set -eux

GLIBC_PKG_VERSION="2.26-r0"
GLIBC_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_PKG_VERSION"
GLIBC_SSH_KEY="/etc/apk/keys/sgerrand.rsa.pub"
GLIBC_PKG_FILE="glibc-$GLIBC_PKG_VERSION.apk"
GLIBC_BIN_PKG_FILE="glibc-bin-$GLIBC_PKG_VERSION.apk"
apk add --no-cache --virtual=.fetchdeps wget ca-certificates
wget -q -O "$GLIBC_SSH_KEY" "https://raw.githubusercontent.com/andyshinn/alpine-pkg-glibc/master/sgerrand.rsa.pub"
wget -q "$GLIBC_URL/$GLIBC_PKG_FILE" "$GLIBC_URL/$GLIBC_BIN_PKG_FILE"
apk add --no-cache "$GLIBC_PKG_FILE" "$GLIBC_BIN_PKG_FILE"
apk del .fetchdeps
rm "$GLIBC_SSH_KEY"
rm ~/.wget-hsts
rm "$GLIBC_PKG_FILE" "$GLIBC_BIN_PKG_FILE"

apk add --no-cache \
  bash="4.3.48-r1" \
  build-base="0.5-r0" \
  bzip2-dev="1.0.6-r5" \
  bzip2="1.0.6-r5" \
  curl="7.56.1-r0" \
  git="2.13.5-r0" \
  libffi-dev="3.2.1-r3" \
  linux-headers="4.4.6-r2" \
  mercurial="4.3.1-r0" \
  ncurses-dev="6.0_p20170930-r0" \
  openssl-dev="1.0.2m-r0" \
  openssl="1.0.2m-r0" \
  patch="2.7.5-r1" \
  readline-dev="6.3.008-r5" \
  sqlite-dev="3.20.1-r0" \
  xz-libs="5.2.3-r0" \
  zlib-dev="1.2.11-r0"
