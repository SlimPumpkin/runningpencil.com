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

## 02-02 라이브 확인 도구와 첫 공개 범위

HISTORY_PREV=c4cb26d754e9
PREPUSH_LIVE=OK

- 기록 시각: 2026-11-16T02:06Z (푸시 전, 원격 main은 `c4cb26d754e9`)
- 도구: 스크래치 `live-check.sh` (저장소 밖, 커밋 안 함). `/bin/bash -n` 통과, RESEARCH Pitfall 5의 `LC_ALL=C grep` 검사 0건. 안에 RESEARCH의 `fetch_fresh`를 그대로 옮겼습니다. pre 모드는 배포 대기를 하지 않고, 내부 파일 URL을 조회하지 않습니다 (Pitfall 2). post 모드는 이번 task에서 돌리지 않았습니다 (푸시가 없음).
- 요청한 URL: 네 문서의 맨 URL과 `/assets/css/style.css`뿐입니다. 문서마다 한 번의 요청으로 헤더와 본문을 함께 받았습니다.

### live-check 출력 (푸시 전 라이브)

종료 코드 0.

```
live-check.sh pre
OK 빌드 c4cb26d754e9 built 2026-11-14T16:40:54Z
OK 문서 https://runningpencil.com/ lm=2026-11-14T16:41:25Z age=0
OK 문서 https://runningpencil.com/privacy-policy/ lm=2026-11-14T16:41:25Z age=0
OK 문서 https://runningpencil.com/terms/ lm=2026-11-14T16:41:25Z age=0
OK 문서 https://runningpencil.com/data-deletion/ lm=2026-11-14T16:41:25Z age=0
OK 테마 /assets/css/style.css 200
live-check: 통과
```

- 빌드 기록 (`pages/builds/latest`): `commit` `c4cb26d754e9`, `created_at` 2026-11-14T16:40:54Z, `status` built, `error.message` null. 이 커밋은 `HISTORY_PREV`(원격 main)와 같습니다.
- 응답 헤더: 네 문서 모두 상태 200, `last-modified` 2026-11-14T16:41:25Z(UTC로 바꾼 값, `created_at` 이후), `age` 0. 테마 파일 상태 200.
- 네 문서의 제목과 D-07 정규화 본문이 기준 커밋(`BASE_SHA`) 원본과 같습니다.

### 첫 공개 범위 (원격 main `c4cb26d754e9` 기준)

- `git merge-base --is-ancestor <HISTORY_PREV> <BASE_SHA>` 참 (다른 곳의 푸시 없음). `HISTORY_PREV..BASE_SHA`의 병합 커밋 0개.
- 아직 공개되지 않은 커밋 수: `HISTORY_PREV..BASE_SHA` 109개, `HISTORY_PREV..HEAD` 112개 (HEAD `1eab7132d0aa`, 이 기록 시각 기준)
- 처음 공개되는 파일 수 (`--diff-filter=d`): `HISTORY_PREV..BASE_SHA` 74개 (참고: `HISTORY_PREV..HEAD` 80개)
- 기준 커밋까지 바뀌는 파일 가운데 `.planning/` 밖의 것 4개: `.claude/CLAUDE.md`, `.gitignore`, `CLAUDE.md`, `_config.yml`
- 참고: HEAD까지면 `.planning/` 밖이 8개입니다. 위 4개에 `.githooks/pre-push`, `Gemfile`, `Gemfile.lock`, `scripts/check-site.sh`가 더해집니다.

### 검토 항목 (막는 검사가 아님, 사람이 Task 2에서 봄)

정규식과 거르기는 이 계획의 scratch_contract 그대로입니다 (누출 `LEAK`·허용 `ALLOW`, 호스트 이름 허용 목록, 로컬 경로 검사에서 `~/.claude` 제외, 해시 꼴 거르기). 검사는 위치 머리를 뺀 줄 내용에 걸었습니다. 걸린 줄의 내용은 이 기록에 옮기지 않습니다.

끝 트리 (`BASE_SHA`에서 처음 공개되는 파일 74개):

| 검사 | 걸린 줄 수 | 위치 (`파일:행`) |
|---|---|---|
| 누출 | 1 | `.planning/research/PITFALLS.md:492` |
| 호스트 이름 | 0 | 없음 |
| 로컬 경로 | 27 | 아래 목록 |

로컬 경로 27줄:
- `.planning/PROJECT.md:73`
- `.planning/ROADMAP.md:73`
- `.planning/baseline/DECISIONS.md:11`
- `.planning/baseline/NAMES.md:35`
- `.planning/phases/01-ground-truth-policy-reset/01-01-PLAN.md:93`
- `.planning/phases/01-ground-truth-policy-reset/01-CONTEXT.md:18`, `:158`, `:160`, `:161`, `:162`, `:163`, `:164`, `:165`, `:166`, `:167`, `:168`
- `.planning/phases/01-ground-truth-policy-reset/01-PATTERNS.md:37`
- `.planning/phases/01-ground-truth-policy-reset/01-RESEARCH.md:7`, `:341`, `:1004`, `:1038`, `:1048`, `:1096`
- `.planning/phases/01-ground-truth-policy-reset/01-VALIDATION.md:53`
- `.planning/phases/01-ground-truth-policy-reset/01-VERIFICATION.md:161`
- `.planning/research/FEATURES.md:500`
- `.planning/research/PITFALLS.md:140`

이력 (`HISTORY_PREV..BASE_SHA` 109개 커밋이 더한 줄):

| 검사 | 걸린 줄 수 | 위치 (`커밋:파일`, 줄 수) |
|---|---|---|
| 누출 | 1 | `07795f4b8dc7:.planning/research/PITFALLS.md` (1) |
| 호스트 이름 | 0 | 없음 |
| 로컬 경로 | 33 | 아래 목록 |

로컬 경로 33줄:
- `07795f4b8dc7:.planning/research/FEATURES.md` (1)
- `07795f4b8dc7:.planning/research/PITFALLS.md` (1)
- `3530c42e0e97:.planning/PROJECT.md` (1)
- `455f53575e65:.planning/phases/01-ground-truth-policy-reset/01-VALIDATION.md` (2)
- `4ccd4c1070d0:.planning/phases/01-ground-truth-policy-reset/01-VERIFICATION.md` (1)
- `6dabe9be7168:.planning/phases/01-ground-truth-policy-reset/01-RESEARCH.md` (6)
- `7ace1f92d6ac:.planning/phases/01-ground-truth-policy-reset/01-VERIFICATION.md` (1)
- `8b8c8ead1265:.planning/phases/01-ground-truth-policy-reset/01-01-PLAN.md` (1)
- `955d6670f60e:.planning/phases/01-ground-truth-policy-reset/01-VERIFICATION.md` (1)
- `c25c8ab5ac30:.planning/phases/01-ground-truth-policy-reset/01-CONTEXT.md` (10)
- `ce09726a24a9:.planning/phases/01-ground-truth-policy-reset/01-CONTEXT.md` (3)
- `dcc200243196:.planning/phases/01-ground-truth-policy-reset/01-PATTERNS.md` (1)
- `dcddd4c4a62c:.planning/baseline/DECISIONS.md` (1)
- `ee6acbc54723:.planning/ROADMAP.md` (1)
- `f07d7037f23f:.planning/baseline/NAMES.md` (1)
- `f41e0c523a6b:.planning/phases/01-ground-truth-policy-reset/01-VALIDATION.md` (1)

- 끝 트리 누출 1줄과 이력 누출 1줄은 같은 줄입니다 (공개 커뮤니티 URL 안의 숫자 ID). 이력 검사에서 해시 꼴 거르기 뒤 따로 남은 누출 줄은 없습니다.
- 이력의 로컬 경로 33줄 가운데 끝 트리에 없는 줄(나중 커밋에서 바뀌거나 지워진 줄)도 공개 이력에 남습니다. 끝 트리와 겹치는 줄도 따로 셌습니다.

### 훅 실제 경로 시험 (원격으로 푸시하지 않음)

- 표준 입력 `refs/heads/main <BASE_SHA 전체> refs/heads/main <HISTORY_PREV 전체>` 한 줄을 `.githooks/pre-push`에 넣음 → rc=0, `check-site: 통과 (커밋 db505d71d3d2, jekyll 3.10.0)`

## 02-02 첫 공개 결정

HISTORY_DECISION=base-first
BASE_PUSH_SHA=db505d71d3d2
LIVE_BASE_PUSH=OK

- 결정: 사용자가 Task 2 checkpoint(`gate="blocking-human"`)에서 `base-first`를 골랐습니다. 고르기 전에 공개되지 않은 커밋 수(`HISTORY_PREV..BASE_SHA` 109개, `HISTORY_PREV..HEAD` 112개), 처음 공개되는 파일 74개 목록, 검토 항목의 걸린 줄 전체(누출 1줄, 호스트 이름 0줄, 로컬 경로 끝 트리 27줄·이력 33줄)를 보았습니다.
- 승인 범위: 기준 커밋(`BASE_SHA`)을 `refs/heads/main`으로 푸시하는 한 번뿐입니다. 빌드 설정 커밋(`7773b163f3de`, `7f13a622878b`)과 02-01 기록 커밋(`1eab7132d0aa`)은 이 승인에 들지 않으며, 푸시 ①은 02-03에서 따로 승인받습니다.
- 푸시 직전 확인: `git fetch -q origin main` 뒤 원격 main 전체 해시가 `HISTORY_PREV`와 같았습니다. post 모드의 `gh` 쪽(배포 실행 찾기와 `gh run watch`)은 이미 배포된 `HISTORY_PREV` 커밋으로 미리 시험했습니다 (실행을 찾음, watch rc=0). 이 시험에서 사이트 URL은 요청하지 않았습니다.
- 푸시 (2026-11-16T02:34Z 무렵): `git push origin <BASE_SHA 전체>:refs/heads/main` → rc=0. pre-push 훅 출력 `check-site: 통과 (커밋 db505d71d3d2, jekyll 3.10.0)`. 원격 main `c4cb26d754e9` → `db505d71d3d2` (fast-forward). `--no-verify`·force는 쓰지 않았습니다.
- 푸시 뒤 확인: `git fetch -q origin main` 뒤 원격 main 전체 해시가 `BASE_SHA` 전체 해시와 같습니다. `7773b163f3de`, `7f13a622878b`, `1eab7132d0aa`는 원격 main의 조상이 아닙니다 (공개되지 않음).

### live-check 출력 (기준 커밋 푸시 뒤)

종료 코드 0. 처음 한 번 돌린 결과이고, 다시 돌리거나 스크립트를 고치지 않았습니다. 배포 실행을 기다린 뒤 첫 회차에서 모든 확인이 끝났습니다.

```
live-check.sh post db505d71d3d2
OK 빌드 db505d71d3d2 built 2026-11-16T02:34:28Z
OK 문서 https://runningpencil.com/ lm=2026-11-16T02:35:01Z age=0
OK 문서 https://runningpencil.com/privacy-policy/ lm=2026-11-16T02:35:01Z age=0
OK 문서 https://runningpencil.com/terms/ lm=2026-11-16T02:35:01Z age=0
OK 문서 https://runningpencil.com/data-deletion/ lm=2026-11-16T02:35:01Z age=0
OK 404 /CLAUDE.md age=0
OK 404 /README.md age=0
OK 404 /Gemfile age=0
OK 404 /Gemfile.lock age=0
OK 404 /_config.yml age=0
OK 404 /.planning/ROADMAP.md age=0
OK 404 /.claude/CLAUDE.md age=0
OK 404 /scripts/check-site.sh age=0
OK 404 /.githooks/pre-push age=0
OK 404 /_includes/footer.html age=0
OK 404 /_layouts/legal.html age=0
OK 404 /prepare/ age=0
OK 404 /vendor/ age=0
OK 테마 /assets/css/style.css 200
live-check: 통과
```

- 빌드 기록 (`pages/builds/latest`): `commit` `db505d71d3d2`(푸시한 커밋), `created_at` 2026-11-16T02:34:28Z, `status` built, `error.message` null.
- 네 문서: 상태 200, `last-modified` 2026-11-16T02:35:01Z(UTC로 바꾼 값, `created_at` 이후), `age` 0. 제목과 D-07 정규화 본문이 기준 커밋 원본과 같습니다.
- 내부 파일 13개: 모두 404이고 `age` 0(배포 뒤 지난 초보다 작음, 신선한 404). 이번 푸시로 처음 원격에 들어간 `/.planning/ROADMAP.md`와 `/.claude/CLAUDE.md`가 운영에서 실제로 막히는 것을 처음 확인했습니다 (RESEARCH Pitfall 3). `/prepare/`·`/vendor/`는 gitignore 대상이라 원격에 없으므로 404가 당연하고, 의미 있는 확인은 로컬 check-site 2번입니다.
- 테마 파일 `/assets/css/style.css` 200.
- 관찰: 이 푸시는 네 문서의 바이트를 바꾸지 않았는데도 `last-modified`가 새 배포 시각으로 올라갔습니다. RESEARCH A2(새 배포가 바뀌지 않은 파일의 `Last-Modified`도 올린다)가 이번 배포 한 번에서 성립했습니다.

## 02-03 푸시 ① 후보

PUSH1_CANDIDATE=d5a6679631d7
PUSH1_PREV=db505d71d3d2

- 기록 시각: 2026-11-16T02:54Z (푸시 전). 메인 체크아웃에서 실행했습니다.
- `git fetch -q origin main` 뒤 원격 main은 `db505d71d3d2`(02-02에서 라이브 확인을 통과한 기준 커밋)이고, 후보는 로컬 HEAD `d5a6679631d7`입니다. `git merge-base --is-ancestor <PUSH1_PREV> <후보>` 참 (다른 곳의 푸시 없음). 범위의 병합 커밋 0개.
- `git log "$PREV..$CAND" -- Gemfile.lock .githooks/pre-push`에 02-01의 두 커밋이 보입니다: `7f13a622878b`(훅, `HOOK_SHA`)와 `7773b163f3de`(빌드 설정, `BUILD_CONFIG_SHA`).
- `HISTORY_DECISION=base-first`이므로 Phase 1 이력은 이미 기준 커밋 푸시로 공개됐습니다. 이 푸시가 처음 공개하는 이력은 아래 다섯 커밋뿐입니다.

### 공개 범위 (`PUSH1_PREV..PUSH1_CANDIDATE`)

- 아직 공개되지 않은 커밋 수: 5개 (`7773b163f3de`, `7f13a622878b`, `1eab7132d0aa`, `02d8866a2525`, `d5a6679631d7`)
- `.planning/` 밖에서 바뀌는 파일 6개: `.githooks/pre-push`, `.gitignore`, `Gemfile`, `Gemfile.lock`, `_config.yml`, `scripts/check-site.sh`
- `--diff-filter=d`로 센 파일 수: 11개. 이 가운데 새로 더해지는 파일은 7개(`.githooks/pre-push`, `Gemfile`, `Gemfile.lock`, `scripts/check-site.sh`, `02-01-SUMMARY.md`, `02-02-SUMMARY.md`, `02-EVIDENCE.md`)이고, 나머지 4개(`.gitignore`, `_config.yml`, `.planning/ROADMAP.md`, `.planning/STATE.md`)는 이미 공개된 파일의 수정입니다.

### 검토 항목 (막는 검사가 아님, 사람이 Task 2에서 봄)

정규식과 거르기는 02-02 scratch_contract 그대로입니다. 같은 검사 도구를 02-02 범위(`HISTORY_PREV..BASE_SHA`)에 다시 돌려 02-02 기록과 같은 수(끝 트리 1·0·27, 이력 1·0·33)가 나오는 것을 먼저 확인했습니다. 호스트 이름 검사는 허용 목록 밖의 하위 도메인이 걸리는지 합성한 줄로 따로 시험했습니다. 걸린 줄의 내용은 이 기록에 옮기지 않습니다.

| 검사 | 끝 트리 (걸린 줄 수, `파일:행`) | 이력 (이 범위 5개 커밋이 더한 줄) |
|---|---|---|
| 누출 | 0 | 0 |
| 호스트 이름 | 0 | 0 |
| 로컬 경로 | 1 (`.planning/ROADMAP.md:73`) | 0 |

- 끝 트리의 로컬 경로 1줄은 기준 커밋(`BASE_SHA`)에 이미 있던 같은 줄입니다 (02-02 끝 트리 목록의 `.planning/ROADMAP.md:73`). `ROADMAP.md`가 수정 파일이라 다시 잡혔을 뿐, 이 푸시로 처음 공개되는 줄이 아닙니다.

### 훅 실제 경로 시험과 기준 비교 (원격으로 푸시하지 않음)

- 표준 입력 `refs/heads/main <후보 전체> refs/heads/main <PUSH1_PREV 전체>` 한 줄을 `.githooks/pre-push`에 넣음 → rc=0, `check-site: 통과 (커밋 d5a6679631d7, jekyll 3.10.0)`
- `compare.sh <BASE_SHA> <후보>` → rc=0

```
OK   index.html (바이트 동일)
OK   privacy-policy/index.html (바이트 동일)
OK   terms/index.html (바이트 동일)
OK   data-deletion/index.html (바이트 동일)
OK   _site 파일 목록 동일 (11개)
기준 db505d71d3d2 / 후보 d5a6679631d7
```

## 02-03 푸시 ① 라이브 확인

PUSH1_SHA=d5a6679631d7
LIVE_PUSH1=OK

- 승인: 사용자가 Task 2 checkpoint(`gate="blocking-human"`)에서 `push`로 답했습니다. 승인 범위는 `PUSH1_CANDIDATE`(`d5a6679631d7`)를 `refs/heads/main`으로 푸시하는 한 번뿐입니다.
- 푸시 직전 확인 (2026-11-16T03:08Z): `git fetch -q origin main` 뒤 `git rev-parse --short=12 origin/main` → `db505d71d3d2` (`PUSH1_PREV`와 같음).
- 푸시: `git push origin <PUSH1_CANDIDATE 전체>:refs/heads/main` → 성공. pre-push 훅 출력 `check-site: 통과 (커밋 d5a6679631d7, jekyll 3.10.0)`. 원격 main `db505d71d3d2` → `d5a6679631d7` (fast-forward). `--no-verify`·force는 쓰지 않았습니다.
- 푸시 뒤 확인: `git fetch -q origin main` 뒤 원격 main은 `d5a6679631d7`이고, `git merge-base --is-ancestor <PUSH1_SHA> origin/main` 참.

### live-check 출력 (푸시 ① 뒤)

종료 코드 0. 처음 한 번 돌린 결과이고, 다시 돌리거나 스크립트를 고치지 않았습니다.

```
live-check.sh post d5a6679631d7
OK 빌드 d5a6679631d7 built 2026-11-16T03:08:27Z
OK 문서 https://runningpencil.com/ lm=2026-11-16T03:09:04Z age=0
OK 문서 https://runningpencil.com/privacy-policy/ lm=2026-11-16T03:09:04Z age=0
OK 문서 https://runningpencil.com/terms/ lm=2026-11-16T03:09:04Z age=0
OK 문서 https://runningpencil.com/data-deletion/ lm=2026-11-16T03:09:04Z age=0
OK 404 /CLAUDE.md age=0
OK 404 /README.md age=0
OK 404 /Gemfile age=0
OK 404 /Gemfile.lock age=0
OK 404 /scripts/check-site.sh age=0
OK 404 /.githooks/pre-push age=0
OK 404 /_layouts/legal.html age=0
OK 404 /.planning/ROADMAP.md age=0
OK 404 /_includes/footer.html age=0
OK 404 /prepare/ age=0
OK 404 /vendor/ age=0
OK 404 /.claude/CLAUDE.md age=0
OK 404 /_config.yml age=0
OK 테마 /assets/css/style.css 200
live-check: 통과
```

- 빌드 기록 (`pages/builds/latest`): `commit` `d5a6679631d7`(푸시한 커밋), `created_at` 2026-11-16T03:08:27Z, `status` built, `error.message` null.
- 네 문서: 상태 200, `last-modified` 2026-11-16T03:09:04Z(UTC로 바꾼 값, `created_at` 이후), `age` 0. 제목과 D-07 정규화 본문이 기준 커밋(`BASE_SHA`) 원본과 같습니다.
- 이 푸시로 원격에 처음 들어간 파일 넷: `/Gemfile`, `/Gemfile.lock`, `/scripts/check-site.sh`, `/.githooks/pre-push` 모두 404이고 `age` 0(배포 뒤 지난 초보다 작음, 신선한 404). 보강한 `exclude`와 점·밑줄 규칙이 운영 빌드에서도 적용됨을 처음 확인했습니다.
- 나머지 내부 파일 9개(`/CLAUDE.md`, `/README.md`, `/_config.yml`, `/.planning/ROADMAP.md`, `/.claude/CLAUDE.md`, `/_includes/footer.html`, `/_layouts/legal.html`, `/prepare/`, `/vendor/`)도 신선한 404입니다. 모두 13개.
- 테마 파일 `/assets/css/style.css` 200.
- 관찰: 이번에도 네 문서의 바이트가 바뀌지 않았는데 `last-modified`가 새 배포 시각으로 올라갔습니다. RESEARCH A2가 두 번째 배포에서도 성립했습니다.
- 출력의 `OK 404` 줄 순서가 02-02 기록과 다른 것은, live-check가 첫 회차에서 판정하지 못한 경로를 다음 회차에서 다시 확인해 그 순서로 출력하기 때문입니다. 판정에는 영향이 없습니다.

## 02-04 법적 3종 전환

메인 체크아웃에서 실행했습니다 (`git-dir`와 `git-common-dir`가 같음, `LIVE_PUSH1=OK` 확인). 전환 커밋은 세 개이고 모두 리팩터만 담습니다. 원격으로 푸시하지 않았습니다 (푸시 ②는 02-05). 비교는 스크래치 `compare.sh <BASE_SHA> <커밋>`이고, 커밋 전에는 지정 파일만 스테이징한 `git write-tree`로 같은 비교를 먼저 돌렸습니다.

### 전환 1: 이용약관 (tracer)

LEGAL_CONV_SHA_1=6994b6f27976

- 커밋: `refactor(02-04): 이용약관을 legal 레이아웃과 헤더·푸터 include로 전환`. 파일 4개: `_layouts/legal.html`, `_includes/header.html`, `_includes/footer.html`, `terms/index.html`
- 레이아웃은 기준 커밋의 `terms/index.html` 줄을 스크립트로 잘라 옮겨 만들었습니다. 기준 원본과 diff를 보면 바뀐 곳은 계획 line_map의 9곳뿐입니다 (title, description, noindex 감쌈, header include, eyebrow, h1, updated 감쌈, content, footer include).
- 헤더 include는 원본 `:74-87`과 href 네 곳만 다르고, 푸터 include는 원본 `:174-197`과 같습니다. 두 파일 모두 끝 줄바꿈이 없습니다 (`tail -c 1 | wc -l` = 0).
- 커밋 전 `compare.sh <BASE_SHA> <write-tree>` rc=0 (OK 5줄, 네 문서 바이트 동일), `scripts/check-site.sh`(작업 트리) 통과
- 커밋 뒤 `compare.sh <BASE_SHA> <LEGAL_CONV_SHA_1>` rc=0:

```
OK   index.html (바이트 동일)
OK   privacy-policy/index.html (바이트 동일)
OK   terms/index.html (바이트 동일)
OK   data-deletion/index.html (바이트 동일)
OK   _site 파일 목록 동일 (11개)
기준 db505d71d3d2 / 후보 6994b6f27976
```

- `scripts/check-site.sh <LEGAL_CONV_SHA_1>` → `check-site: 통과 (커밋 6994b6f27976, jekyll 3.10.0)`
- Tracer feedback gate: 대화형·`end-of-phase`·`<automated>`만 있는 verify라 Task 1 verify 세 명령을 커밋 뒤 다시 돌렸고 모두 exit 0이어서 Task 2로 넘어갔습니다 (checkpoint 없음).

### 전환 2: 개인정보처리방침과 데이터 삭제 안내

LEGAL_CONV_SHA_2=c13cf8a17b84
FALSY_LAYOUT=OK

- 전환 전 확인: 두 파일의 `:1-95`를 기준 커밋의 `terms/index.html`과 diff하면 `:8` title, `:9` description, `:92` eyebrow, `:93` h1 네 줄만 다릅니다. 닫는 구간(privacy-policy `:143-174`, data-deletion `:120-151`)은 terms `:169-200`과 같습니다. 레이아웃 하나로 세 문서를 그릴 수 있습니다.
- 커밋: `refactor(02-04): 개인정보처리방침과 데이터 삭제 안내를 legal 레이아웃으로 전환`. 파일 2개: `privacy-policy/index.html`(본문 원본 `:96-142`), `data-deletion/index.html`(본문 원본 `:96-119`, `heading` 키 있음). 두 페이지 모두 `noindex: true`와 「임시 게시본」 문단을 페이지 파일에 둡니다.
- 커밋 전 `compare.sh <BASE_SHA> <write-tree>` rc=0 (OK 5줄, 네 문서 바이트 동일)
- 커밋 뒤 `compare.sh <BASE_SHA> <LEGAL_CONV_SHA_2>` rc=0:

```
OK   index.html (바이트 동일)
OK   privacy-policy/index.html (바이트 동일)
OK   terms/index.html (바이트 동일)
OK   data-deletion/index.html (바이트 동일)
OK   _site 파일 목록 동일 (11개)
기준 db505d71d3d2 / 후보 c13cf8a17b84
```

- `scripts/check-site.sh <LEGAL_CONV_SHA_2>` → `check-site: 통과 (커밋 c13cf8a17b84, jekyll 3.10.0)`
- 이 커밋에서 푸터 마크업(`<footer class="rp-foot">`)이 있는 HTML은 `_includes/footer.html`과 아직 전환하지 않은 `index.html` 두 개뿐입니다.

#### 값이 없을 때의 분기 (D-02 render-if-present)

- 방법: `git archive`로 HEAD(`LEGAL_CONV_SHA_2`)를 저장소 밖 임시 폴더에 풀고, front matter가 `layout: legal`과 `title: "시험 페이지"`뿐인 `zz-falsy/index.html`(본문 한 줄)을 더한 뒤 메인 체크아웃 Gemfile로 `JEKYLL_ENV=production jekyll build --safe`. 저장소에는 아무것도 더하지 않았습니다.
- 결과: 빌드 성공. 시험 페이지 출력에 robots 메타 줄이 없고, 「최종 업데이트」 줄이 없고, h1이 「시험 페이지」입니다. 빠진 자리에 빈 줄이나 붙은 줄이 생기지 않았습니다 (description 다음 줄이 바로 theme-color, h1 다음 줄이 바로 본문 컨테이너).
- 출력 발췌 (`grep -n`, 행 번호는 시험 페이지 출력의 것):

```
8:    <title>시험 페이지 - 러닝펜슬</title>
9:    <meta name="description" content="" />
10:    <meta name="theme-color" content="#F2B134" />
91:                <span class="text-sm font-bold tracking-[0.04em] text-accent"></span>
92:                <h1 class="mt-3.5 text-[clamp(30px,6.5vw,42px)] font-black leading-[1.25] tracking-[-1px]">시험 페이지</h1>
93:                <div class="mt-10 space-y-8 leading-[1.7] text-muted">
94:<p>시험</p>
```

- description과 eyebrow는 값이 없으면 빈 문자열로 나옵니다 (`content=""`, 빈 `<span>`). 이 둘은 render-if-present 대상이 아니고, 레이아웃을 쓰는 새 페이지는 두 값을 채워야 합니다.

### 전환 3: head 링크와 「공통」 CSS include

LEGAL_CONV_SHA_3=8cf18dd40673
CMP_LEGAL=OK

- 커밋: `refactor(02-04): 법적 레이아웃의 head 링크와 「공통」 CSS를 include로 분리`. 파일 3개: `_includes/head-links.html`(기준 terms `:13-20`, 8줄), `_includes/css/common.css`(기준 terms `:37-64`, 28줄, 머리 주석 원본 그대로), `_layouts/legal.html`. 두 include 모두 끝 줄바꿈이 없습니다.
- 레이아웃에서 두 블록은 기준 원본과 글자가 같은 블록을 한 번씩만 찾아 0열 include 태그로 바꿨습니다. 「공통」 CSS 뒤의 빈 줄은 레이아웃에 남아 「법적 페이지 전용」 CSS와 같은 `<style>` 안에서 이어집니다. 레이아웃은 include 네 개(head-links, css/common.css, header, footer)와 `{{ content | rstrip }}`를 모두 0열에서 부릅니다.
- 이 커밋에서 HTML 가운데 Tailwind CDN 줄은 `_layouts/legal.html`에만 있고(옮기기만 함, 제거는 Phase 3), head 링크(`rel="manifest"`)와 「공통」 머리 주석은 include와 아직 전환하지 않은 `index.html`에만 있습니다. `_layouts`에는 `legal.html`만 있고 `.editorconfig`·`.nojekyll`은 없습니다.
- 커밋 전 `compare.sh <BASE_SHA> <write-tree>` rc=0 (OK 5줄, 네 문서 바이트 동일)
- 커밋 뒤 `compare.sh <BASE_SHA> <LEGAL_CONV_SHA_3>` rc=0:

```
OK   index.html (바이트 동일)
OK   privacy-policy/index.html (바이트 동일)
OK   terms/index.html (바이트 동일)
OK   data-deletion/index.html (바이트 동일)
OK   _site 파일 목록 동일 (11개)
기준 db505d71d3d2 / 후보 8cf18dd40673
```

- `scripts/check-site.sh <LEGAL_CONV_SHA_3>` → `check-site: 통과 (커밋 8cf18dd40673, jekyll 3.10.0)`
- 이 계획의 커밋은 `index.html`을 바꾸지 않았습니다 (`git diff --quiet <BASE_SHA> HEAD -- index.html` 참). 원격 main은 `PUSH1_SHA`(`d5a6679631d7`) 그대로입니다 (푸시하지 않음).

### 성공 기준 1 (법적 쪽) 판정

- 세 전환 커밋(`LEGAL_CONV_SHA_1`·`_2`·`_3`) 모두 기준과 네 문서 D-07 diff 0, `_site` 파일 목록 동일(11개). 세 커밋 모두 정규화 동일을 넘어 **바이트 동일**입니다 (출력 주석 포함, D-05).

## 02-05 푸시 ② 후보

PUSH2_CANDIDATE=01f6bb8bbb13
PUSH2_PREV=d5a6679631d7

- 기록 시각: 2026-11-16T04:26Z (푸시 전). 메인 체크아웃에서 실행했습니다 (`git-dir`와 `git-common-dir`가 같음, `CMP_LEGAL=OK`·`LIVE_PUSH1=OK` 확인).
- `git fetch -q origin main` 뒤 원격 main은 `d5a6679631d7`(02-03에서 라이브 확인을 통과한 `PUSH1_SHA`)이고, 후보는 로컬 HEAD `01f6bb8bbb13`입니다. `git merge-base --is-ancestor <PUSH2_PREV> <후보>` 참 (다른 곳의 푸시 없음). 범위의 병합 커밋 0개.
- 법적 3종 전환 커밋 세 개(`LEGAL_CONV_SHA_1` `6994b6f27976`, `LEGAL_CONV_SHA_2` `c13cf8a17b84`, `LEGAL_CONV_SHA_3` `8cf18dd40673`)가 모두 후보의 조상이고, 셋 모두 `PUSH2_PREV`의 조상이 아닙니다 (이 푸시로 처음 공개됨).

### 공개 범위 (`PUSH2_PREV..PUSH2_CANDIDATE`)

- 아직 공개되지 않은 커밋 수: 7개 (02-03 기록 `a1eba1c0d408`·`ecda8408ad0a`, 전환 세 개 `6994b6f27976`·`c13cf8a17b84`·`8cf18dd40673`, 02-04 기록 `2c8a01a1c0a4`·`01f6bb8bbb13`)
- `.planning/` 밖에서 바뀌는 파일 8개: `_includes/css/common.css`, `_includes/footer.html`, `_includes/head-links.html`, `_includes/header.html`, `_layouts/legal.html`, `data-deletion/index.html`, `privacy-policy/index.html`, `terms/index.html`. 계획이 기대한 목록(레이아웃 하나, include 넷, 법적 페이지 셋)과 같습니다. `index.html`은 바뀌지 않습니다 (`git diff --quiet <PUSH2_PREV> <후보> -- index.html` 참).
- `--diff-filter=d`로 센 파일 수: 13개. 이 가운데 새로 더해지는 파일은 7개(include 넷, `_layouts/legal.html`, `02-03-SUMMARY.md`, `02-04-SUMMARY.md`)이고, 나머지 6개(법적 페이지 셋, `.planning/ROADMAP.md`, `.planning/STATE.md`, `02-EVIDENCE.md`)는 이미 공개된 파일의 수정입니다.

### 검토 항목 (막는 검사가 아님, 사람이 Task 2에서 봄)

정규식과 거르기는 02-02 scratch_contract 그대로이고, 검사 도구는 이번 실행에서 scratch_contract대로 다시 만들었습니다. 같은 도구를 02-02 범위(`HISTORY_PREV..BASE_SHA`)와 02-03 범위(`PUSH1_PREV..PUSH1_CANDIDATE`)에 다시 돌려 두 기록과 같은 수(02-02 끝 트리 1·0·27, 이력 1·0·33 / 02-03 끝 트리 0·0·1, 이력 0·0·0)가 나오는 것을 먼저 확인했습니다. 호스트 이름 검사(허용 목록 밖 하위 도메인만 걸림)와 누출 검사(허용 목록·이 저장소 커밋 해시는 빠지고 커밋이 아닌 12자리 숫자는 걸림)는 합성한 줄로 따로 시험했습니다. 걸린 줄의 내용은 이 기록에 옮기지 않습니다.

| 검사 | 끝 트리 (걸린 줄 수, `파일:행`) | 이력 (이 범위 7개 커밋이 더한 줄) |
|---|---|---|
| 누출 | 0 | 0 |
| 호스트 이름 | 0 | 0 |
| 로컬 경로 | 1 (`.planning/ROADMAP.md:73`) | 0 |

- 끝 트리의 로컬 경로 1줄은 `PUSH2_PREV`의 같은 파일 같은 행과 글자가 같습니다 (02-02·02-03 기록의 `.planning/ROADMAP.md:73`). `ROADMAP.md`가 수정 파일이라 다시 잡혔을 뿐, 이 푸시로 처음 공개되는 줄이 아닙니다.

### 훅 실제 경로 시험과 기준 비교 (원격으로 푸시하지 않음)

- 표준 입력 `refs/heads/main <후보 전체> refs/heads/main <PUSH2_PREV 전체>` 한 줄을 `.githooks/pre-push`에 넣음 → rc=0, `check-site: 통과 (커밋 01f6bb8bbb13, jekyll 3.10.0)`
- `compare.sh <BASE_SHA> <후보>` → rc=0

```
OK   index.html (바이트 동일)
OK   privacy-policy/index.html (바이트 동일)
OK   terms/index.html (바이트 동일)
OK   data-deletion/index.html (바이트 동일)
OK   _site 파일 목록 동일 (11개)
기준 db505d71d3d2 / 후보 01f6bb8bbb13
```

## 02-05 푸시 ② 라이브 확인

PUSH2_SHA=01f6bb8bbb13
LIVE_PUSH2=OK

- 승인: 사용자가 Task 2 checkpoint(`gate="blocking-human"`)에서 `push`로 답했습니다. 승인 범위는 `PUSH2_CANDIDATE`(`01f6bb8bbb13`)를 `refs/heads/main`으로 푸시하는 한 번뿐입니다.
- 푸시 직전 확인 (2026-11-16T04:37Z): `git fetch -q origin main` 뒤 `git rev-parse --short=12 origin/main` → `d5a6679631d7` (`PUSH2_PREV`와 같음). 메인 체크아웃(`git-dir`와 `git-common-dir`가 같음), `gh auth status` 0.
- 푸시: `git push origin <PUSH2_CANDIDATE 전체>:refs/heads/main` → 성공. pre-push 훅 출력 `check-site: 통과 (커밋 01f6bb8bbb13, jekyll 3.10.0)`. 원격 main `d5a6679631d7` → `01f6bb8bbb13` (fast-forward). `--no-verify`·force는 쓰지 않았습니다.
- 푸시 뒤 확인: `git fetch -q origin main` 뒤 원격 main은 `01f6bb8bbb13`이고, `git merge-base --is-ancestor <PUSH2_SHA> origin/main` 참.

### live-check 출력 (푸시 ② 뒤)

종료 코드 0. 처음 한 번 돌린 결과이고, 다시 돌리거나 스크립트를 고치지 않았습니다.

```
live-check.sh post 01f6bb8bbb13
OK 빌드 01f6bb8bbb13 built 2026-11-16T04:37:19Z
OK 문서 https://runningpencil.com/ lm=2026-11-16T04:37:49Z age=0
OK 문서 https://runningpencil.com/privacy-policy/ lm=2026-11-16T04:37:49Z age=0
OK 문서 https://runningpencil.com/terms/ lm=2026-11-16T04:37:49Z age=0
OK 문서 https://runningpencil.com/data-deletion/ lm=2026-11-16T04:37:49Z age=0
OK 404 /CLAUDE.md age=0
OK 404 /README.md age=0
OK 404 /Gemfile age=0
OK 404 /Gemfile.lock age=0
OK 404 /_config.yml age=0
OK 404 /.planning/ROADMAP.md age=0
OK 404 /.claude/CLAUDE.md age=0
OK 404 /scripts/check-site.sh age=0
OK 404 /.githooks/pre-push age=0
OK 404 /_includes/footer.html age=0
OK 404 /_layouts/legal.html age=0
OK 404 /prepare/ age=0
OK 404 /vendor/ age=0
OK 테마 /assets/css/style.css 200
live-check: 통과
```

- 빌드 기록 (`pages/builds/latest`, 출력 뒤 한 번 더 조회): `commit` `01f6bb8bbb13`(푸시한 커밋), `created_at` 2026-11-16T04:37:19Z, `status` built, `error.message` null. 운영 빌드 오류 없음.
- 네 문서: 상태 200, `last-modified` 2026-11-16T04:37:49Z(UTC로 바꾼 값, `created_at` 이후), `age` 0. 제목과 D-07 정규화 본문이 기준 커밋(`BASE_SHA`) 원본과 같습니다. 운영 빌드(github-pages)가 front matter `layout: legal`과 include 네 개를 처음 처리한 배포이고, 법적 세 문서의 출력이 로컬 Jekyll 3.10.0 빌드·기준 원본과 같았습니다. 로컬과 운영의 Liquid 처리 차이는 이 배포에서 드러나지 않았습니다 (RESEARCH A4, 성공 기준 4).
- 이 푸시로 원격에 처음 들어간 `_includes/`·`_layouts/` 파일 가운데 점검 대상 `/_includes/footer.html`, `/_layouts/legal.html`이 신선한 404(`age` 0)입니다. 밑줄 규칙이 운영 빌드에서도 적용됨을 확인했습니다 (SHELL-03, T-02-18).
- 나머지 내부 파일 11개(`/CLAUDE.md`, `/README.md`, `/Gemfile`, `/Gemfile.lock`, `/_config.yml`, `/.planning/ROADMAP.md`, `/.claude/CLAUDE.md`, `/scripts/check-site.sh`, `/.githooks/pre-push`, `/prepare/`, `/vendor/`)도 신선한 404입니다. 모두 13개.
- 테마 파일 `/assets/css/style.css` 200.
- 관찰: 랜딩(`index.html`)은 이번 푸시에서 바뀌지 않았는데 `last-modified`가 새 배포 시각으로 올라갔습니다. RESEARCH A2가 세 번째 배포에서도 성립했습니다.
- 되돌리기 절차(`<rollback_procedure>`)는 쓰지 않았습니다 (FAIL·STALE 없음).
