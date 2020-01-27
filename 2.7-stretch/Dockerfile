FROM python:2.7.17-slim-stretch

# The latest pip doesn't support legacy format
RUN pip install pip==9.0.3

ENV PYENV_ROOT /opt/pyenv
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

ENV CONCHOID_DOCKER_PYENV_HOME /conchoid/docker-pyenv

RUN apt-get update \
    && apt-get install -y \
        locales curl gcc git g++ libbz2-dev libsqlite3-dev libssl1.0-dev libreadline-dev make zlib1g-dev libffi-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN PYENV_VERSION="v1.2.16" \
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

RUN PYTHON2_VERSION="2.7.17" \
    && PYTHON34_VERSION="3.4.10" \
    && PYTHON35_VERSION="3.5.9" \
    && PYTHON36_VERSION="3.6.10" \
    && PYTHON37_VERSION="3.7.6" \
    && PYTHON38_VERSION="3.8.1" \
    && pyenv install "$PYTHON2_VERSION" \
    && pyenv install "$PYTHON34_VERSION" \
    && pyenv install "$PYTHON35_VERSION" \
    && pyenv install "$PYTHON36_VERSION" \
    && pyenv install "$PYTHON37_VERSION" \
    && pyenv install "$PYTHON38_VERSION" \
    && pyenv global system "$PYTHON2_VERSION" "$PYTHON38_VERSION" "$PYTHON37_VERSION" "$PYTHON36_VERSION" "$PYTHON35_VERSION" "$PYTHON34_VERSION"
