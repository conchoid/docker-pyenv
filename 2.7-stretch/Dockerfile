FROM python:2.7-slim-stretch

ENV PYENV_ROOT /opt/pyenv
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

ENV CONCHOID_DOCKER_PYENV_HOME /conchoid/docker-pyenv

RUN apt-get update && \
    apt-get install -y curl gcc git libbz2-dev libsqlite3-dev libssl-dev libreadline-dev make zlib1g-dev

RUN mkdir -p "$PYENV_ROOT" && \
    git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT" && \
    cd "$PYENV_ROOT" && \
    git checkout -q v1.1.5

RUN set -x \
    && PYTHON2_VERSION="2.7.14" \
    && PYTHON34_VERSION="3.4.7" \
    && PYTHON35_VERSION="3.5.4" \
    && PYTHON36_VERSION="3.6.3" \
    && pyenv install "$PYTHON2_VERSION" \
    && pyenv install "$PYTHON34_VERSION" \
    && pyenv install "$PYTHON35_VERSION" \
    && pyenv install "$PYTHON36_VERSION" \
    && pyenv global system "$PYTHON2_VERSION" "$PYTHON36_VERSION" "$PYTHON35_VERSION" "$PYTHON34_VERSION"
