#!/bin/sh

set -eux

mkdir -p /var/cache/apk && ln -s /var/cache/apk /etc/apk/cache

GLIBC_PKG_VERSION="${GLIBC_PKG_VERSION:-2.26-r0}"
GLIBC_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_PKG_VERSION"
GLIBC_SSH_KEY="/etc/apk/keys/sgerrand.rsa.pub"
GLIBC_PKG_FILE="glibc-$GLIBC_PKG_VERSION.apk"
GLIBC_BIN_PKG_FILE="glibc-bin-$GLIBC_PKG_VERSION.apk"
apk add --no-cache --virtual=.fetchdeps wget ca-certificates
wget -q -O "$GLIBC_SSH_KEY" "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub"
wget -q "$GLIBC_URL/$GLIBC_PKG_FILE" "$GLIBC_URL/$GLIBC_BIN_PKG_FILE"
apk add --no-cache "$GLIBC_PKG_FILE" "$GLIBC_BIN_PKG_FILE"
apk del .fetchdeps
rm "$GLIBC_SSH_KEY"
rm ~/.wget-hsts
rm "$GLIBC_PKG_FILE" "$GLIBC_BIN_PKG_FILE"

apk add --no-cache \
  bash="${BASH_PKG_VERSION:-4.3.48-r1}" \
  build-base="${BUILD_BASE_PKG_VERSION:-0.5-r0}" \
  bzip2-dev="${BZIP2_DEV_PKG_VERSION:-1.0.6-r5}" \
  bzip2="${BZIP2_PKG_VERSION:-1.0.6-r5}" \
  curl="${CURL_PKG_VERSION:-7.61.1-r0}" \
  git="${GIT_PKG_VERSION:-2.13.7-r1}" \
  libffi-dev="${LIBFFI_DEV_PKG_VERSION:-3.2.1-r3}" \
  linux-headers="${LINUX_HEADERS_PKG_VERSION:-4.4.6-r2}" \
  mercurial="${MERCURIAL_PKG_VERSION:-4.5.2-r0}" \
  ncurses-dev="${NCURSES_DEV_PKG_VERSION:-6.0_p20171125-r1}" \
  openssl-dev="${OPENSSL_DEV_PKG_VERSION:-1.0.2o-r1}" \
  openssl="${OPENSSL_PKG_VERSION:-1.0.2o-r1}" \
  patch="${PATCH_PKG_VERSION:-2.7.5-r3}" \
  python2="2.7.15-r0" \
  python2-dev="2.7.15-r0" \
  readline-dev="${READLINE_DEV_PKG_VERSION:-6.3.008-r5}" \
  sqlite-dev="${SQLITE_DEV_PKG_VERSION:-3.20.1-r2}" \
  xz-libs="${XZ_LIBS_PKG_VERSION:-5.2.3-r0}" \
  zlib-dev="${ZLIB_DEV_PKG_VERSION:-1.2.11-r0}"

rm /etc/apk/cache
