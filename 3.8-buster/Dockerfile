FROM python:3.8.12-slim-buster

ENV PYENV_ROOT /opt/pyenv
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN apt-get update \
    && apt-get install -y --allow-unauthenticated \
      gcc-7 g++-7 make build-essential zlib1g-dev libbz2-dev \
      libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
      xz-utils zlib1g-dbg unixodbc-dev tk-dev libffi-dev liblzma-dev python-openssl git gnupg \
      locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 10 \
        --slave /usr/bin/g++ g++ /usr/bin/g++-7

RUN echo "deb http://security.ubuntu.com/ubuntu bionic-security main" > /etc/apt/sources.list.d/bionic-security.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 \
    && apt-get update && apt-cache policy libssl1.0-dev && apt-get install -y libssl1.0-dev \
    && rm -f /etc/apt/sources.list.d/bionic-security.list

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV ROCRO_PYTHON_PIP_VERSION="20.3.4"
ENV ROCRO_POETRY_VERSION="1.1.5"

RUN PYENV_VERSION="v2.2.2" \
    && mkdir -p "$PYENV_ROOT" \
    && git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT" \
    && cd "$PYENV_ROOT" \
    && git checkout -q "$PYENV_VERSION" \
    && PYTHON_BUILD_VERSION="943c5f995d0ecdc957ca365aa79a9ce3294652bf" \
    && cd "$PYENV_ROOT/plugins" \
    && git checkout -q "$PYTHON_BUILD_VERSION" ./python-build \
    && PYENV_PIP_MIGRATE_VERSION="88f09de2a06f95bd1933b950ec2b66671ae36fbd" \
    && PYENV_PIP_MIGRATE_DIR="$PYENV_ROOT/plugins/pyenv-pip-migrate" \
    && git clone https://github.com/pyenv/pyenv-pip-migrate.git "$PYENV_PIP_MIGRATE_DIR" \
    && cd "$PYENV_PIP_MIGRATE_DIR" \
    && git checkout -q "$PYENV_PIP_MIGRATE_VERSION" \
    && rm -r "$PYENV_ROOT/.git" && rm -rf " $PYENV_PIP_MIGRATE_DIR/.git"


# NOTE: pyenv install does not include the system version 3.8.12.
# System version 3.8.12. uses a symbolic link in /usr/local/.
# Python 3.10.1 required OpenSSL 1.1.1
RUN for VER in "3.6.15" "3.7.12" "3.8.12" "3.9.9" "3.10.1"; \
    do \
      if [ "$VER" = "3.8.12" ] ; then \
        ln -sf "/usr/local/" "${PYENV_ROOT}/versions/${VER}"; \
      elif [ "$VER" = "3.10.1" ] ; then \
        apt-get update && apt-get install -y libssl-dev && pyenv install $VER; \
      else \
        pyenv install $VER ; \
      fi \
      && PYENV_VERSION="$VER" pip install --upgrade pip=="$ROCRO_PYTHON_PIP_VERSION" six  poetry=="$ROCRO_POETRY_VERSION" \
      && pyenv rehash ; \
    done \
    && pyenv global system $(pyenv versions --bare | sort -rV | xargs)

#RUN [ $(pyenv versions --bare | wc -l) -eq 4 ]
