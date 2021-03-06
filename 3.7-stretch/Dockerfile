FROM python:3.7.10-slim-stretch

ENV PYENV_ROOT /opt/pyenv
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN apt-get update \
    && apt-get install -y \
      make build-essential libssl1.0-dev zlib1g-dev libbz2-dev \
      libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
      xz-utils tk-dev libffi-dev liblzma-dev python-openssl git \
      locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV ROCRO_PYTHON_PIP_VERSION="20.3.4"
ENV ROCRO_POETRY_VERSION="1.1.5"

RUN PYENV_VERSION="1.2.24.1" \
    && mkdir -p "$PYENV_ROOT" \
    && git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT" \
    && cd "$PYENV_ROOT" \
    && git checkout -q "$PYENV_VERSION" \
    && PYTHON_BUILD_VERSION="8ac91b4fd678a8c04356f5ec85cfcd565c265e9a" \
    && cd "$PYENV_ROOT/plugins" \
    && git checkout -q "$PYTHON_BUILD_VERSION" ./python-build \
    && PYENV_PIP_MIGRATE_VERSION="88f09de2a06f95bd1933b950ec2b66671ae36fbd" \
    && PYENV_PIP_MIGRATE_DIR="$PYENV_ROOT/plugins/pyenv-pip-migrate" \
    && git clone https://github.com/pyenv/pyenv-pip-migrate.git "$PYENV_PIP_MIGRATE_DIR" \
    && cd "$PYENV_PIP_MIGRATE_DIR" \
    && git checkout -q "$PYENV_PIP_MIGRATE_VERSION" \
    && rm -r "$PYENV_ROOT/.git" && rm -rf " $PYENV_PIP_MIGRATE_DIR/.git"

# NOTE: pyenv install does not include the system version 3.7.9.
# System version 3.7.9. uses a symbolic link in /usr/local/.
RUN for VER in "3.6.13" "3.7.10" "3.8.8" "3.9.2"; \
    do \
      if [ "$VER" = "3.7.10" ] ; then \
        ln -sf "/usr/local/" "${PYENV_ROOT}/versions/${VER}"; \
      else \
        pyenv install $VER ; \
      fi \
      && PYENV_VERSION="$VER" pip install --upgrade pip=="$ROCRO_PYTHON_PIP_VERSION" six poetry=="$ROCRO_POETRY_VERSION" \
      && pyenv rehash ; \
    done \
    && pyenv global system $(pyenv versions --bare | sort -rV | xargs)

RUN [ $(pyenv versions --bare | wc -l) -eq 4 ]
