#!/bin/sh

set -eux

REVISION="${1:-v1.1.5}"
DEST_DIR="${2:-${PYENV_ROOT:-$HOME/.pyenv}}"

rm -rf "$DEST_DIR"
mkdir -p "$DEST_DIR"
git clone https://github.com/pyenv/pyenv.git "$DEST_DIR"
cd "$DEST_DIR"
git checkout -q "$REVISION"
