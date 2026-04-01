
https://devguide.python.org/#status-of-python-branches
https://devguide.python.org/devcycle/#end-of-life-branches

`By default, the end-of-life is scheduled 5 years after the first release, but can be adjusted by the release manager of each branch. All Python 2 versions have reached end-of-life.`

https://github.com/pyenv/pyenv/tree/master のcommit hash (4a3aaf4327f1ad1c88c2d42178fa3dbc9dddc6df)

#### バージョンとEOL
(updated on 2026/01/05)

|PRE-IN|ver|eol| |
|--|--|--|--|
|y| 3.9.25 |  2025-10| not-supported |
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

docker build -t conchoid/docker-pyenv:v2.6.17-1-3.12-bookworm -f 3.12-bookworm/Dockerfile .
docker build -t conchoid/docker-pyenv:v2.6.17-1-3.12-bullseye -f 3.12-bullseye/Dockerfile .
docker build -t conchoid/docker-pyenv:v2.6.17-1-3.12-trixie -f 3.12-trixie/Dockerfile .

docker build -t conchoid/docker-pyenv:v2.6.17-1-3.13-bookworm -f 3.13-bookworm/Dockerfile .
docker build -t conchoid/docker-pyenv:v2.6.17-1-3.13-bullseye -f 3.13-bullseye/Dockerfile .
docker build -t conchoid/docker-pyenv:v2.6.17-1-3.13-trixie -f 3.13-trixie/Dockerfile .

## OS更新手順（bookworm → trixie）

### 概要
docker-pyenv の Dockerfile のベースイメージを `python:X.X.X-slim-bookworm` (Debian 12) から `python:X.X.X-slim-trixie` (Debian 13) に更新する。

### 更新手順

#### 1. ベースイメージの更新
Dockerfile の 1 行目を以下のように変更する：

**変更前:**
```dockerfile
FROM python:3.12.12-slim-bookworm
```
または
```dockerfile
FROM python:3.13.11-bookworm
```

**変更後:**
```dockerfile
FROM python:3.12.12-slim-trixie
```
または
```dockerfile
FROM python:3.13.11-trixie
```

#### 2. 動作確認
以下のコマンドで Docker イメージをビルドし、正常に動作することを確認する：

```bash
cd docker-pyenv
docker build -t conchoid/docker-pyenv:v2.6.17-1-3.12-trixie -f 3.12-trixie/Dockerfile .
docker build -t conchoid/docker-pyenv:v2.6.17-1-3.13-trixie -f 3.13-trixie/Dockerfile .
```

#### 3. 互換性チェック
Debian 13 への更新により、以下の点を確認する：

- パッケージの互換性（apt-get でインストールしているパッケージが利用可能か）
- pyenv の動作確認
- Python 各バージョンのインストール確認
- pip と poetry のインストール確認
- ロケール設定の確認

#### 4. テスト実行
実際の Python プロジェクトでイメージを使用し、以下を確認する：

- ビルドが正常に完了するか
- 依存関係の解決が正常に行われるか
- 実行時エラーが発生しないか

### 注意事項
- Debian 13 (trixie) は比較的新しいリリースのため、一部のパッケージやツールのバージョンが変更されている可能性がある
- 問題が発生した場合は、パッケージのバージョン指定や代替パッケージの検討が必要になる場合がある
- **apt-get でインストールしているライブラリは必要なライブラリなので、trixie でもインストールを行う必要がある**
- ビルド後は、pyenv と各 Python バージョンが正常にインストールされていることを確認すること
