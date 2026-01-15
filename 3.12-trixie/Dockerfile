FROM python:3.12.12-slim-trixie

ENV PYENV_ROOT=/opt/pyenv
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN apt-get update \
    && apt-get install -y --allow-unauthenticated \
      gcc g++ make build-essential zlib1g-dev libbz2-dev \
      libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
      xz-utils unixodbc-dev tk-dev libffi-dev liblzma-dev python3-openssl git git-lfs gnupg \
      locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN echo "deb http://security.ubuntu.com/ubuntu bionic-security main" > /etc/apt/sources.list.d/bionic-security.list \
    && curl -fsSL http://keyserver.ubuntu.com/pks/lookup?op=get\&search=0x3B4FE6ACC0B21F32 | gpg --dearmor -o /etc/apt/trusted.gpg.d/ubuntu-bionic.gpg \
    && apt-get update && apt-cache policy libssl1.0-dev && apt-get install -y libssl1.0-dev \
    && rm -f /etc/apt/sources.list.d/bionic-security.list /etc/apt/trusted.gpg.d/ubuntu-bionic.gpg

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV ROCRO_PYTHON_PIP_VERSION="25.0.1"
ENV ROCRO_POETRY_VERSION="1.8.5"

RUN PYENV_VERSION="v2.6.17" \
    && mkdir -p "$PYENV_ROOT" \
    && git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT" \
    && cd "$PYENV_ROOT" \
    && git checkout -q "$PYENV_VERSION" \
    && PYTHON_BUILD_VERSION="4a3aaf4327f1ad1c88c2d42178fa3dbc9dddc6df" \
    && cd "$PYENV_ROOT/plugins" \
    && git checkout -q "$PYTHON_BUILD_VERSION" ./python-build \
    && PYENV_PIP_MIGRATE_VERSION="1ddc347b5db9895927ea09bbe9d0e2de8ebf902b" \
    && PYENV_PIP_MIGRATE_DIR="$PYENV_ROOT/plugins/pyenv-pip-migrate" \
    && git clone https://github.com/pyenv/pyenv-pip-migrate.git "$PYENV_PIP_MIGRATE_DIR" \
    && cd "$PYENV_PIP_MIGRATE_DIR" \
    && git checkout -q "$PYENV_PIP_MIGRATE_VERSION"

# NOTE: pyenv install does not include the system version 3.12.12.
# System version 3.12.12. uses a symbolic link in /usr/local/.
RUN for VER in "3.9.25" "3.10.19" "3.11.14" "3.12.12" "3.13.11" "3.14.2"; \
    do \
      if [ "$VER" = "3.12.12" ] ; then \
        ln -sf "/usr/local/" "${PYENV_ROOT}/versions/${VER}" \
        && apt-get update && apt-get install -y libssl-dev \
        && PYENV_VERSION="$VER" pip install --upgrade pip=="$ROCRO_PYTHON_PIP_VERSION" six poetry=="$ROCRO_POETRY_VERSION"; \
      elif [ "$VER" = "3.10.19" ] || [ "$VER" = "3.11.14" ] || [ "$VER" = "3.13.11" ] || [ "$VER" = "3.14.2" ]; then \
        apt-get update && apt-get install -y libssl-dev \
        && pyenv install $VER \
        && PYENV_VERSION="$VER" pip install --upgrade pip=="$ROCRO_PYTHON_PIP_VERSION" six poetry=="$ROCRO_POETRY_VERSION"; \
      else \
        pyenv install $VER \
        && PYENV_VERSION="$VER" pip install --upgrade pip=="$ROCRO_PYTHON_PIP_VERSION" six poetry=="$ROCRO_POETRY_VERSION"; \
      fi \
      && pyenv rehash ; \
    done \
    && pyenv global system $(pyenv versions --bare | sort -rV | xargs)

