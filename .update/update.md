
https://devguide.python.org/#status-of-python-branches
https://devguide.python.org/devcycle/#end-of-life-branches

`By default, the end-of-life is scheduled 5 years after the first release, but can be adjusted by the release manager of each branch. All Python 2 versions have reached end-of-life.`

https://github.com/pyenv/pyenv/tree/master のcommit hash (4a3aaf4327f1ad1c88c2d42178fa3dbc9dddc6df)

#### バージョンとEOL
(updated on 2026/01/05)

|PRE-IN|ver|eol| |
|--|--|--|--|
|y| 3.9.20 |  2025-10| not-supported |
|y| 3.10.19 | 2026-10| security |
|y| 3.11.14 | 2027-10| security |
|y| 3.12.12 | 2028-10| pyenv/system |
|y| 3.13.11 | 2029-10| bug-fix |
|y| 3.14.2 | 2030-10| bug-fix |

https://www.python.org/dev/peps/pep-0596/

システムバージョン（pyenv/system）は、[ブランチのステータスがSecurityのバージョン](https://devguide.python.org/#status-of-python-branches)の最新を採用している。

対象のdocker fileを更新後 以下のdocker buildを実行
命名規約
[conchoid/docker-pyenv]:v[pyenv version]-[1 連番[-[dockerのベースイメージのpython version]-[OSコードネーム]
conchoid/docker-pyenv:v2.6.17-1-3.12-bookworm

docker-pyenv % docker build -t conchoid/docker-pyenv:v2.6.17-1-3.12-bookworm -f 3.12-bookworm/Dockerfile .
docker-pyenv % docker build -t conchoid/docker-pyenv:v2.6.17-1-3.12-bullseye -f 3.12-bullseye/Dockerfile .

docker-pyenv % docker build -t conchoid/docker-pyenv:v2.6.17-1-3.13-bookworm -f 3.13-bookworm/Dockerfile .
docker-pyenv % docker build -t conchoid/docker-pyenv:v2.6.17-1-3.13-bullseye -f 3.13-bullseye/Dockerfile .
