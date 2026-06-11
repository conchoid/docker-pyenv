# Dockerfile base image update reference

Repository: `docker-pyenv`

## Standard pattern

- Update Dockerfiles from `python:<version>-slim-bookworm` to `python:<version>-slim-trixie`
- Apply the same process to each supported Python line that needs the new Debian suite
- Build from the repository root with the target Dockerfile

## Image tag naming pattern from the original procedure

```text
conchoid/docker-pyenv:v<pyenv version>-<sequence>-<python version>-<os codename>
```

Example:

```text
conchoid/docker-pyenv:v2.6.17-1-3.12-trixie
```

## Example commands from the original procedure

```bash
cd docker-pyenv
docker build -t conchoid/docker-pyenv:v2.6.17-1-3.12-trixie -f 3.12-trixie/Dockerfile .
docker build -t conchoid/docker-pyenv:v2.6.17-1-3.13-trixie -f 3.13-trixie/Dockerfile .
```

## Checklist

- Update the base image to the new Debian suite for each target Python line.
- Preserve required `apt-get` libraries unless incompatibility is confirmed.
- Verify which Python branches are still supported.
- Verify the repository rule for the system Python line and apply it consistently.
- Verify `pyenv` still works.
- Verify each intended Python version installs correctly.
- Verify `pip` and `poetry` are available.
- Verify locale-related behavior.
- Verify a real Python project can install dependencies, build, and run.

## Cautions

- Debian release changes can affect package names and versions.
- Python branch support changes over time, so support decisions must be rechecked at the time of the update.
- If a Python line becomes unsupported, document the removal or retention decision explicitly.
