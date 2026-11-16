# Phase 2 검증 기록 (Evidence)

이 문서는 `02-CONTEXT.md`의 D-06·D-09가 말하는 Phase 2 검증 문서입니다. 계획마다 구간을 하나씩 더합니다. 줄 맨 앞에 `KEY=value` 꼴로 쓴 표식 줄(예: `BASE_SHA=…`)은 다음 계획의 명령이 `sed`로 읽으므로, 표식 줄의 모양을 바꾸지 않습니다. 저장소가 공개라 커밋 해시는 12자리로만 적습니다.

## 기준 (D-09)

BASE_SHA=db505d71d3d2

- 기록 시각: 2026-11-16T01:41:51Z (Phase 2 첫 사이트 커밋 전)
- 기준 원본: 이 커밋의 `index.html`, `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`. 지금은 빌드 없이 그대로 서빙되므로 라이브와 같습니다.
- 기준 `_site` 파일 목록은 작업 트리가 아니라 이 커밋을 `git archive`로 내보낸 사본에서 `JEKYLL_ENV=production bundle exec jekyll build --safe`로 만듭니다. 기준 커밋에는 Gemfile이 없으므로 `BUNDLE_GEMFILE`로 작업 트리의 Gemfile을 씁니다.

## 02-01 빌드 설정 커밋 (D-15 ① 후보)

BUILD_CONFIG_SHA=7773b163f3de
CMP_BUILD=OK

- 커밋 파일 4개: `.gitignore`, `Gemfile`, `Gemfile.lock`, `_config.yml` (`*.html`, `favicon/`, `CNAME`은 바꾸지 않음)
- 로컬 빌드: `bundle exec jekyll -v` → `jekyll 3.10.0`, `Gemfile.lock`의 `liquid (4.0.4)`, `DEPENDENCIES` 7개(base64, bigdecimal, csv, jekyll (= 3.10.0), kramdown-parser-gfm, logger, webrick), `BUNDLED WITH 4.0.23`
- `_site` 파일 목록: 11개 (연구 시점 75adbb9의 11개와 같음). 운영에는 테마가 만드는 `/assets/css/style.css`가 하나 더 있으나 이 비교는 로컬 대 로컬입니다 (RESEARCH Pitfall 12)
- 비교 명령: `compare.sh <BASE_SHA> <BUILD_CONFIG_SHA>` (커밋 전에는 같은 네 파일을 스테이징한 `git write-tree`로도 같은 결과)

```
OK   index.html (바이트 동일)
OK   privacy-policy/index.html (바이트 동일)
OK   terms/index.html (바이트 동일)
OK   data-deletion/index.html (바이트 동일)
OK   _site 파일 목록 동일 (11개)
기준 db505d71d3d2 / 후보 7773b163f3de
```

## 02-01 점검 스크립트와 훅

HOOK_SHA=7f13a622878b
INJECT=OK

- 훅 커밋: `7f13a622878b` (`build(02-01): 푸시 전 점검 스크립트와 pre-push 훅 추가`). `scripts/check-site.sh`는 RESEARCH 583-669행 전문에 `.nojekyll` 검사 한 줄(2번 항목, `leaked` 검사 다음)만 더한 것이고, `.githooks/pre-push`는 RESEARCH 686-701행 그대로입니다.
- `git ls-files -s` 결과:

```
100755 f237241ac4876c211ad435f666b3fd119aabd5af 0	.githooks/pre-push
100755 fd631e9e53be879df6970f00f4b128b443997ab5 0	scripts/check-site.sh
```

- `git config core.hooksPath` → `.githooks` (로컬 설정, 커밋되지 않음)
- 정적 검사: `/bin/bash -n` 두 파일 통과, RESEARCH Pitfall 5의 `LC_ALL=C grep` 검사 0건
- `scripts/check-site.sh`(작업 트리) → `check-site: 통과 (작업 트리, jekyll 3.10.0)`, `scripts/check-site.sh HEAD` → `check-site: 통과 (커밋 7f13a622878b, jekyll 3.10.0)`
- 훅 실제 경로 시험 (원격으로 푸시하지 않고 표준 입력을 직접 넣음):
  - `refs/heads/main <HEAD> refs/heads/main <origin/main>` 줄 → rc=0, `check-site: 통과 (커밋 7f13a622878b, jekyll 3.10.0)`
  - `refs/heads/x …` 줄 → rc=0, 출력 없음 (main이 아니면 건너뜀)

### 실패 주입 (`inject.sh`, 시험용 linked worktree에서 실행)

시험용 worktree에는 `.bundle/config`가 없으므로 점검 스크립트가 메인 체크아웃의 gem을 썼습니다. 그래서 worktree 대체 경로도 함께 시험됐습니다. 실행 앞뒤로 메인 작업 트리의 `git status --porcelain`이 같았고, 끝난 뒤 시험용 worktree는 남지 않았습니다.

| 주입 | 무엇을 바꿨나 | 종료 코드 | 메시지 첫 줄 |
|---|---|---|---|
| 주입-a | `_config.yml` exclude에서 `  - Gemfile`, `  - Gemfile.lock` 두 줄 삭제 | rc=1 | `check-site: 내부 파일이 출력에 있습니다: /Gemfile` (이어서 `/Gemfile.lock`, `실패 — 2건`) |
| 주입-b | `terms/index.html`의 `<title>`을 `이용약관 - 러닝펜슬`로 (전환 전 분기) | rc=1 | `check-site: 제목이 다릅니다: /terms/index.html → '이용약관 - 러닝펜슬' (기대: '서비스 이용약관 - 러닝펜슬')` |
| 주입-c | 빈 front matter와 없는 파일을 부르는 include 한 줄을 가진 `zz-inject-build.html` 추가 | rc=1 | `check-site: 실패 — Jekyll 빌드 실패 (작업 트리)` (Liquid Exception: Could not locate the included file) |
| 주입-d | front matter 없이 Liquid 출력 태그 한 줄을 가진 `zz-inject-raw.html` 추가 | rc=1 | `check-site: Liquid가 처리되지 않은 출력: /zz-inject-raw.html` |
| 주입-e | 빈 `.nojekyll` 추가 | rc=1 | `check-site: .nojekyll이 있습니다: GitHub Pages가 Jekyll을 건너뛰어 include 원문과 내부 문서(CLAUDE.md 등)가 그대로 공개됩니다. …` |

### 훅 커밋과 기준 비교

`scripts/`·`.githooks/`가 출력에 새지 않아 파일 목록이 같습니다.

```
OK   index.html (바이트 동일)
OK   privacy-policy/index.html (바이트 동일)
OK   terms/index.html (바이트 동일)
OK   data-deletion/index.html (바이트 동일)
OK   _site 파일 목록 동일 (11개)
기준 db505d71d3d2 / 후보 7f13a622878b
```
