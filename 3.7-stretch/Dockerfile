FROM python:3.7.7-slim-stretch

ENV PYENV_ROOT /opt/pyenv
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

ENV CONCHOID_DOCKER_PYENV_HOME /conchoid/docker-pyenv

# https://github.com/pyenv/pyenv/wiki/Common-build-problems
## libssl1.0-dev required to build Python3.4
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

RUN PYENV_VERSION="v1.2.17" \
    && mkdir -p "$PYENV_ROOT" \
    && git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT" \
    && cd "$PYENV_ROOT" \
    && git checkout -q ${PYENV_VERSION} \
    && PYENV_PIP_MIGRATE_VERSION="88f09de2a06f95bd1933b950ec2b66671ae36fbd" \
    && PYENV_PIP_MIGRATE_DIR="$PYENV_ROOT/plugins/pyenv-pip-migrate" \
    && git clone https://github.com/pyenv/pyenv-pip-migrate.git "$PYENV_PIP_MIGRATE_DIR" \
    && cd "$PYENV_PIP_MIGRATE_DIR" \
    && git checkout -q ${PYENV_PIP_MIGRATE_VERSION} \
    && rm -r "$PYENV_ROOT/.git" && rm -rf " $PYENV_PIP_MIGRATE_DIR/.git"

RUN for VER in "3.5.9" "3.6.10" "3.7.7" "3.8.2"; \
    do \
      pyenv install $VER ; \
      PYENV_VERSION="$VER" pip install --upgrade pip=="$PYTHON_PIP_VERSION" ; \
      pyenv rehash ; \
    done \
    && pyenv global system $(pyenv versions --bare | sort -rV | xargs)

RUN [ $(pyenv versions --bare | wc -l) -eq 4 ]
