# Docker Images for pyenv

This repository contains Dockerfiles to install [pyenv](https://github.com/pyenv/pyenv) within docker containers. Pre-build images are available at [Docker Hub](https://hub.docker.com/r/conchoid/docker-pyenv/).

## Build a multi-architecture OCI image

The Dockerfiles in the `3.13-trixie` and `3.13-bookworm` directories target both `linux/amd64` and `linux/arm64`. The `git-lfs` binary is taken from the matching `conchoid/debian` tag via `TARGETARCH`. The example below builds `3.13-trixie/Dockerfile`; replace the directory, file and tag for other images.

```sh
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --output type=oci,dest=pyenv-oci.tar,name=conchoid/docker-pyenv:v2.8.7-3-3.13.16-trixie \
  -f 3.13-trixie/Dockerfile 3.13-trixie
```

The result is an OCI image archive containing a multi-platform index. To push it to a registry instead, replace `--output` with `--push` and use `-t conchoid/docker-pyenv:v2.8.7-3-3.13.16-trixie`.
