FROM conchoid/debian:buster-python-3.12.11

ENV PYENV_ROOT=/opt/pyenv
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN echo "deb http://security.ubuntu.com/ubuntu bionic-security main" > /etc/apt/sources.list.d/bionic-security.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 \
    && apt-get update && apt-cache policy libssl1.0-dev && apt-get install -y libssl1.0-dev \
    && rm -f /etc/apt/sources.list.d/bionic-security.list

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV ROCRO_PYTHON_PIP_VERSION="24.3.1"
ENV ROCRO_POETRY_VERSION="1.8.5"

RUN PYENV_VERSION="v2.6.3" \
    && mkdir -p "$PYENV_ROOT" \
    && git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT" \
    && cd "$PYENV_ROOT" \
    && git checkout -q "$PYENV_VERSION" \
    && PYTHON_BUILD_VERSION="95917cb753638cd1b9acc1d2b2c4686d8a934d10" \
    && cd "$PYENV_ROOT/plugins" \
    && git checkout -q "$PYTHON_BUILD_VERSION" ./python-build \
    && PYENV_PIP_MIGRATE_VERSION="1ddc347b5db9895927ea09bbe9d0e2de8ebf902b" \
    && PYENV_PIP_MIGRATE_DIR="$PYENV_ROOT/plugins/pyenv-pip-migrate" \
    && git clone https://github.com/pyenv/pyenv-pip-migrate.git "$PYENV_PIP_MIGRATE_DIR" \
    && cd "$PYENV_PIP_MIGRATE_DIR" \
    && git checkout -q "$PYENV_PIP_MIGRATE_VERSION"

# NOTE: pyenv install does not include the system version 3.12.11.
# System version 3.12.11. uses a symbolic link in /usr/local/.
RUN for VER in "3.8.20" "3.9.23" "3.10.18" "3.11.13" "3.12.11" "3.13.5"; \
    do \
      if [ "$VER" = "3.12.11" ] ; then \
        ln -sf "/usr/local/" "${PYENV_ROOT}/versions/${VER}" \
        && apt-get update && apt-get install -y libssl-dev \
        && PYENV_VERSION="$VER" pip install --upgrade pip=="$ROCRO_PYTHON_PIP_VERSION" six poetry=="$ROCRO_POETRY_VERSION"; \
      elif [ "$VER" = "3.10.18" ] || [ "$VER" = "3.11.13" ] || [ "$VER" = "3.13.5" ]; then \
        apt-get update && apt-get install -y libssl-dev \
        && pyenv install $VER \
        && PYENV_VERSION="$VER" pip install --upgrade pip=="$ROCRO_PYTHON_PIP_VERSION" six poetry=="$ROCRO_POETRY_VERSION"; \
      else \
        pyenv install $VER \
        && PYENV_VERSION="$VER" pip install --upgrade pip=="$ROCRO_PYTHON_PIP_VERSION" six poetry=="$ROCRO_POETRY_VERSION"; \
      fi \
      && pyenv rehash ; \
    done \
    && pyenv global system
