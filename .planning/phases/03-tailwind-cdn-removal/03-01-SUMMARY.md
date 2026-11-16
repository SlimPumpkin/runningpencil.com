---
phase: 03-tailwind-cdn-removal
plan: 01
subsystem: testing
tags: [baseline, playwright, pngjs, pixel-diff, jekyll, tailwind-cdn]

# Dependency graph
requires:
  - phase: 02-jekyll-shared-shell-refactor
    provides: "_layouts/legal.html 한 곳에 모인 Tailwind script·설정, scripts/check-site.sh, 라이브와 같은 사이트 트리(9f715c795830)"
provides:
  - "03-EVIDENCE.md: BASE_SHA=8b65fdb59232, BASE_LIVE=9f715c795830, TW_CDN_VERSION=3.4.17, 도구 버전, BASE_SELFDIFF=OK, JUDGE_NEG=OK"
  - "스크래치 $W(커밋 안 함): lib.sh(build·serve·stop), judge.sh, pw/의 capture·diff·states·report·sample.mjs, 기준 빌드 $W/base, 기준 캡처 $W/cap/base1·base2"
affects: [03-02, 03-03, 03-04, 03-05, 03-06]

# Actuals (#2632)
actuals:
  tokens: 1312     # chars/4 over 03-EVIDENCE.md (이 계획이 바꾼 저장소 파일. SUMMARY 제외)
  tasks: 3
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD. 사이트·코드 변경 없는 기록 전용 계획이라 task 커밋이 없고, 기록은 아래 docs 커밋 하나로 들어간다
plan_head_before: 8b65fdb592325b149b3696dd1b28faa78524d772
plan_head_after: 8b65fdb592325b149b3696dd1b28faa78524d772

# Tech tracking
tech-stack:
  added: ["playwright 1.59.1 (스크래치 전용, pnpm)", "pngjs 7.0.0 (스크래치 전용, pnpm)"]
  patterns:
    - "기준 출력은 git archive + production·--safe Jekyll 빌드를 python3 http.server로 띄워 찍는다 (livereload 없음)"
    - "판정은 judge.sh 하나로: 개수 → 픽셀·텍스트 diff(허용 오차 0) → hover·focus 유효성 → 링크 계산값 report"

key-files:
  created:
    - .planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md
    - .planning/phases/03-tailwind-cdn-removal/03-01-SUMMARY.md
  modified: []

key-decisions:
  - "검증 도구 설치는 npm 대신 pnpm 10.33.2로 했다 (사용자 지시). 버전·경로는 계획 그대로(playwright 1.59.1, pngjs 7.0.0, $W/pw)"
  - "브라우저는 dry-run 리비전(chromium-1217, chromium_headless_shell-1217, webkit-2272, ffmpeg-1011)이 캐시에 모두 있어 내려받지 않았다"
  - "judge.sh의 COUNT 줄은 실제 경로 대신 폴더 이름(base1, <이름>)을 찍는다. 출력을 공개 기록에 그대로 붙이기 때문"
  - "기준 자기 차이는 0이었다 (BASE_SELFDIFF=OK). 이후 모든 사이트 커밋은 $W/cap/base1과 비교한다"

patterns-established:
  - "검증 출력은 판정 도구 출력을 파일로 받아 EVIDENCE에 붙이고, 붙인 블록이 원본 출력과 바이트가 같은지 cmp로 확인한다"

requirements-completed: [SHELL-04]

coverage:
  - id: D1
    description: "기준 커밋·원격 main·CDN 버전 기록과, 기준을 운영과 같은 빌드로 서빙해 네 URL 200·기대 제목·법적 3종 Tailwind 1건 확인"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-01-PLAN.md Task 1 <verify> 두 명령 (bash, exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "판정 도구(judge.sh, capture·diff·states·report·sample.mjs)와 기준 캡처 base1·base2(각 PNG 42·txt 18)의 자기 차이 0, hover·focus 24장 유효"
    requirement: "SHELL-04"
    verification:
      - kind: automated_ui
        ref: "\"$W/judge.sh\" base2 → JUDGE base2 OK (PASS 0 diffs, STATES base2 ok=24 vacuous=0, PASS 18 rows)"
        status: pass
      - kind: other
        ref: "03-01-PLAN.md Task 3 <verify> 두 명령 (bash, exit 0)"
        status: pass
    human_judgment: false
  - id: D3
    description: "음성 대조: 한 픽셀(빨강 채널 +1)을 바꾼 사본을 judge.sh가 실패로 잡음"
    verification:
      - kind: automated_ui
        ref: "\"$W/judge.sh\" neg → DIFF chromium-375-terms.png 1 px, max 1 / JUDGE neg FAIL (exit 1)"
        status: pass
    human_judgment: false

# Metrics
duration: 19min
completed: 2026-11-16
status: complete
---

# Phase 3 Plan 01: 기준 기록과 판정 도구 Summary

**기준 커밋 8b65fdb59232(라이브 9f715c795830과 같은 사이트)와 Tailwind CDN 3.4.17을 기록하고, Playwright 1.59.1·pngjs 7.0.0 판정 도구로 기준을 두 엔진 × 세 폭 × 세 문서로 두 번 찍어 자기 차이 0, 한 픽셀 음성 대조 FAIL을 확인했다**

## Performance

- **Duration:** 19 min
- **Started:** 2026-11-16T14:52:39Z
- **Completed:** 2026-11-16T15:11:30Z
- **Tasks:** 3 (Task 1 tracer, Task 2 decision checkpoint, Task 3 auto)
- **Files modified:** 1 (저장소: `03-EVIDENCE.md`. SUMMARY 별도)

## Accomplishments

- `03-EVIDENCE.md`의 `## 03-01 기준`: `BASE_SHA=8b65fdb59232`, `BASE_LIVE=9f715c795830`, `TW_CDN_VERSION=3.4.17`, check-site 통과, `OK HTTP` 네 줄(법적 3종 `tailwind=1`). 어떤 사이트 파일 변경보다 먼저 기록함 (D-16)
- 스크래치 `$W/pw`에 고정 버전 도구를 설치하고 RESEARCH 원문 스크립트 다섯 개와 `$W/judge.sh`를 만듦. `sample.mjs`는 계획대로 다섯 가지를 더함
- 기준 캡처 `base1`·`base2`(각 PNG 42장·txt 18건·`report.json`)가 `JUDGE base2 OK`: `PASS 0 diffs`, `STATES base2 ok=24 vacuous=0`, `PASS 18 rows` (D-13, D-14, D-15)
- 음성 대조 `judge.sh neg`가 `DIFF chromium-375-terms.png 1 px, max 1`과 `JUDGE neg FAIL`을 냄. 비교가 둔감해서 0이 나오는 것이 아님을 보임

## Task Commits

이 계획은 사이트·코드를 바꾸지 않는 기록 전용 계획이라 task 커밋이 없다 (ledger 측정값 0).

1. **Task 1: 기준 커밋·CDN 버전 기록, 기준 빌드·서빙·HTTP 확인 (tracer)** - 커밋 없음 (계획대로 `03-EVIDENCE.md`는 마지막 docs 커밋에 넣음)
2. **Task 2: 검증 도구 설치 승인 (checkpoint:decision, blocking-human)** - 사용자 답 install. 커밋 없음
3. **Task 3: 판정 도구, 기준 캡처 두 벌, 음성 대조** - 커밋 없음 (스크래치는 커밋하지 않음, EVIDENCE는 docs 커밋)

**Plan metadata:** docs 커밋 하나 (SUMMARY + EVIDENCE + STATE + ROADMAP)

## Files Created/Modified

- `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md` - Phase 3 판정 기록. `## 03-01 기준`, `## 03-01 도구와 기준 캡처` 구간과 표식 줄
- `.planning/phases/03-tailwind-cdn-removal/03-01-SUMMARY.md` - 이 문서
- 저장소 밖 `$W`(커밋 안 함): `lib.sh`, `judge.sh`, `pw/`(package.json, node_modules, 스크립트 다섯 개), `base/`, `cap/base1`, `cap/base2`

## Decisions Made

- 설치는 pnpm으로 했다 (사용자 지시). `pnpm --dir "$W/pw" init` → `add --save-exact playwright@1.59.1 pngjs@7.0.0`. pnpm은 직접 의존성을 `node_modules/<이름>` symlink로 두므로 계획의 verify(`require('$W/pw/node_modules/playwright/package.json')`)와 스크립트의 `import`가 그대로 동작함을 확인했다
- 브라우저 내려받기는 하지 않았다. dry-run이 가리킨 네 리비전이 캐시에 모두 있었다
- `judge.sh`는 `set -e` 없이 네 단계를 모두 돌린다. 하나가 실패해도 나머지 출력을 남겨 음성 대조와 이후 실패 진단에 쓰기 위해서다
- hover·focus 24장은 처리방침·이용약관 두 문서에서 나온다(삭제 안내 본문에는 링크가 없음). 계획의 24장 기대값과 같다

## Deviations from Plan

### 사용자 지시에 따른 변경

**1. [사용자 지시] npm 대신 pnpm으로 설치**
- **Found during:** Task 3 action 1
- **Issue:** 계획은 `npm --prefix … init/install`, `npx playwright install`을 적었으나 사용자가 Task 2 답에서 pnpm(10.33.2)을 지시함
- **Fix:** `pnpm --dir "$W/pw" init`, `pnpm --dir "$W/pw" add --save-exact playwright@1.59.1 pngjs@7.0.0`, `pnpm --dir "$W/pw" exec playwright install --dry-run`. 버전·경로·재사용 판정은 계획 그대로. 계획 문서는 고치지 않음
- **Files modified:** 없음 (스크래치 `$W/pw`만)
- **Verification:** Task 3 verify 2번 명령이 playwright 1.59.1, pngjs 7.0.0을 읽음 (exit 0), ESM import 확인
- **Committed in:** 해당 없음 (스크래치)

---

**Total deviations:** 1 (사용자 지시 1, 자동 고침 0)
**Impact on plan:** 패키지 관리자만 바뀌었고 설치 버전·위치·판정 방법은 계획과 같다.

## Issues Encountered

- 계획 Task 2의 `npm view playwright@1.59.1 version time.1.59.1 scripts --json`은 버전 키 안의 점 때문에 일부 필드를 내지 않았다. 이전 에이전트가 필드를 따로 조회해 결과를 확인했다.
- 기준 캡처 두 벌은 약 191초 걸려 도구 셸 제한 시간을 넘겼고 백그라운드로 넘어가 끝까지 돌았다(종료 코드 0, 서버는 trap으로 끝냄, 포트 4101 비움). 결과에는 영향 없음.

## Known Stubs

없음 (사이트 파일을 바꾸지 않음).

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 03-02(사이트 커밋 ① `legal.css`와 `rp-legal-*` 껍데기)가 쓸 기준 `$W/cap/base1`, `judge.sh`, `lib.sh`가 준비됐다. 스크래치가 사라지면 scratch_contract의 「스크래치가 사라졌을 때」 절차로 같은 고정 버전·같은 경로에 다시 만든다 (Task 2 승인 범위).
- CDN이 남은 캡처는 찍기 직전에 리디렉션이 `/3.4.17`인지 다시 봐야 한다.
- 막는 것 없음.

## Self-Check: PASSED

- FOUND: `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md`, `$W/judge.sh`(실행 가능), `$W/pw/*.mjs` 다섯 개, `$W/cap/base1`·`base2`(각 PNG 42·txt 18·report.json), `$W/cap/neg` 없음
- Task 1 verify 두 명령, Task 3 verify 두 명령 exit 0 (bash)
- 계획 `<verification>`: `git diff --name-only 8b65fdb59232 HEAD -- . ':(exclude).planning'` 빈 출력. EVIDENCE에 `$HOME`·`/private/var`·`/Users/`·실제 스크래치 경로 0건
- 저장소에 추적되는 도구 파일(`*.mjs`, `node_modules`, `package.json`) 없음
- task 커밋 없음 (계획 시작 HEAD 8b65fdb59232 = 현재 HEAD)

---
*Phase: 03-tailwind-cdn-removal*
*Completed: 2026-11-16*
