---
name: docker-pyenv-base-image-update
description: Updates Dockerfiles in the docker-pyenv repository for a new Debian base image release by switching python:<version>-slim-<suite> images, preserving required apt packages, selecting the system Python line based on currently supported branches, and validating pyenv/pip/poetry behavior. Use when asked to move docker-pyenv to a new Debian release such as trixie.
---

# docker-pyenv-base-image-update

Use this skill when updating `docker-pyenv` to a new Debian release.

## Workflow

1. Identify the target Dockerfiles and target version directories.
   Example: `3.12-bookworm/Dockerfile` -> `3.12-trixie/Dockerfile`.
2. If the target directory does not exist, create it and copy the previous Dockerfile into it.
3. Update the first `FROM` image from `python:<version>-slim-<old-suite>` to `python:<version>-slim-<new-suite>`.
4. Keep the installed `apt-get` packages unless a compatibility issue is confirmed. Do not silently remove required libraries.
5. Determine which Python line should be used as `pyenv/system` from the currently supported branches at the time of the change.
   - Verify the branch support status from official Python sources.
   - Prefer the policy already used by the repository when choosing the system line.
6. Build each target image locally from the repository root.
   ```bash
   cd docker-pyenv
   docker build -t conchoid/docker-pyenv:<target-tag> -f <target-dir>/Dockerfile .
   ```
7. Validate compatibility:
   - confirm all `apt-get` packages still resolve
   - confirm `pyenv` works
   - confirm each intended Python version installs correctly
   - confirm `pip` and `poetry` are available
   - confirm locale settings still work
8. If the repository has project-level or sample builds, run them with the new image and verify dependency installation, build success, and runtime behavior.

## Notes

- Python support windows are time-sensitive. Always verify support status from official Python sources when deciding preinstalled or system versions.
- Prefer changing only the Debian suite first. Change Python version pins only when required by support policy or the user request.
- Read [references/debian-release-update.md](references/debian-release-update.md) for the repo-specific checklist, naming pattern, and example commands.
