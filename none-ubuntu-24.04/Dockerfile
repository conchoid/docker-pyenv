FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
RUN apt-get update && apt-get install -y git \
        make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

RUN git clone --depth=1 https://github.com/pyenv/pyenv.git ~/.pyenv -b v2.6.3
ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc

ENV PYTHON39 3.9.13
ENV PYTHON310 3.10.4
ENV PYTHON311 3.11.4
ENV PYTHON312 3.12.1
ENV PYTHON313 3.13.5
ENV PYTHON_VERSIONS $PYTHON39 $PYTHON310 $PYTHON311 $PYTHON312 $PYTHON313

RUN for v in $PYTHON_VERSIONS ; do ( \
        CONFIGURE_OPTS="--enable-shared" pyenv install $v \
        ) done

RUN eval "$(pyenv init -)" && for v in $PYTHON_VERSIONS ; do ( \
        pyenv shell $v \
        && pip install --upgrade pip \
        && pip install wheel \
        ) done

RUN pyenv global $PYTHON_VERSIONS

