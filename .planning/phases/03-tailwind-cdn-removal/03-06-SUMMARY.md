---
phase: 03-tailwind-cdn-removal
plan: 06
subsystem: infra
tags: [deploy, github-pages, pre-push, live-check, pixel-diff, user-approval]

# Dependency graph
requires:
  - phase: 03-tailwind-cdn-removal
    provides: "03-01: 판정 도구(judge.sh·capture.mjs), 기준 캡처 $W/cap/base1, BASE_LIVE=9f715c795830 / 03-02~03-05: 사이트 커밋 C1·C2·C3·CHECK5·NOWRAP과 커밋별 픽셀 0 판정"
provides:
  - "사이트 푸시(D-21 ①): 사용자가 승인한 SITE_PUSH_CANDIDATE=2ebeca06ca51 하나를 pre-push 훅(check-site 5항목) 통과 뒤 원격 main에 푸시. 원격 main 9f715c795830 → 2ebeca06ca51"
  - "라이브 확인(D-22): Pages 빌드 built·오류 없음, 세 법적 URL과 / 가 200·기대 제목, 법적 라이브 HTML에 Tailwind 0건·rp-legal-card 있음"
  - "라이브 화면 판정: Chromium·WebKit × 375·768·1280px 라이브 캡처가 base1과 PNG 42장 픽셀 0, txt 18건 동일, 네트워크·HTML에 Tailwind 0 (JUDGE live OK). 운영 빌드와 로컬 빌드 차이 없음(RESEARCH A4 확인)"
  - "EVIDENCE 표식 SITE_PUSH_SHA=2ebeca06ca51, LIVE_SITE=OK"
affects: [03-07, 03-08, 03-09, 05, 07, 09]

# Actuals (#2632)
actuals:
  tokens: 1700     # chars/4: 03-EVIDENCE.md 추가분(03-06 두 구간) (SUMMARY 제외)
  tasks: 3
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD. 사이트 코드 변경 없음(앞 계획 커밋을 푸시만 함). 기록은 아래 docs 커밋으로 들어간다
plan_head_before: 2ebeca06ca51e4c19be3173931d8eac4af74144c
plan_head_after: 2ebeca06ca51e4c19be3173931d8eac4af74144c

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "사이트 푸시는 승인받은 SHA 하나를 `<해시>:refs/heads/main`으로만 하고, 푸시 직전에 원격 main이 기록한 이전 값 그대로인지 fetch로 확인한다"
    - "배포 완료는 `pages/builds/latest`의 commit이 푸시한 전체 해시이고 status=built·오류 없음일 때로 판정한다(직후에는 이전 빌드가 built로 보이므로 commit 일치를 함께 본다)"
    - "라이브 확인은 `?cb=<커밋 12자리>` 쿼리로 캐시를 우회하고, 새 껍데기 클래스(rp-legal-card)로 새 배포 반영을 확인한다"

key-files:
  created:
    - .planning/phases/03-tailwind-cdn-removal/03-06-SUMMARY.md
  modified:
    - .planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md

key-decisions:
  - "사용자가 Task 2에서 「push」로 답해 SITE_PUSH_CANDIDATE=2ebeca06ca51 한 번의 사이트 푸시를 승인했다. 검토 항목(02-UI-REVIEW.md 76-84행의 로컬 절대 경로 9줄)을 그대로 본 뒤의 결정이고, 그 파일은 고치지 않았다"
  - "라이브 확인(빌드·HTTP·화면)이 모두 OK라 되돌리기(D-23)는 하지 않았다. 이 계획의 docs·추적 커밋은 푸시하지 않고 문서 푸시(D-21 ②) 때 함께 나간다"

patterns-established:
  - "Pages 빌드 대기는 20초 간격 폴링 스크립트를 스크래치에 두고 백그라운드로 돌린다(이번에는 세 번째 읽기에서 built)"

requirements-completed: [SHELL-04]

coverage:
  - id: D1
    description: "승인받은 SHA 하나만 pre-push 훅(check-site 5항목)을 거쳐 원격 main에 푸시됨. 푸시 범위의 .planning/ 밖 파일은 정해진 여섯, 후보 사이트 트리 = 마지막 판정 커밋"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-06-PLAN.md Task 1 <verify> (bash, exit 0: 범위 여섯 파일, 사이트 트리 = NOWRAP_SHA, pre-push 훅 check-site 통과)"
        status: pass
      - kind: other
        ref: "git push origin 2ebeca06…:refs/heads/main → 훅 줄 check-site: 통과 (커밋 2ebeca06ca51, jekyll 3.10.0), 원격 main 9f715c7..2ebeca0"
        status: pass
    human_judgment: false
  - id: D2
    description: "Pages 빌드가 푸시 커밋으로 built·오류 없음, 라이브 세 법적 URL과 / 가 200·기대 제목, 법적 HTML에 Tailwind 0건·rp-legal-card 있음"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-06-PLAN.md Task 3 <verify> 1번 (bash, exit 0: SITE_PUSH_SHA = 후보, origin/main 조상, LIVE_SITE=OK, OK HTTP 네 줄, FAIL 없음)"
        status: pass
      - kind: other
        ref: "03-06-PLAN.md Task 3 <verify> 2번 (gh api pages/builds 대조: commit·created_at 2026-11-16T17:21:05Z·built·오류 없음 1건)"
        status: pass
    human_judgment: false
  - id: D3
    description: "라이브 화면이 전환 전 기준과 두 엔진 × 세 폭에서 픽셀 0, 텍스트 동일, 네트워크·HTML에 Tailwind 0"
    requirement: "SHELL-04"
    verification:
      - kind: automated_ui
        ref: "cd \"$W/pw\" && node capture.mjs https://runningpencil.com \"$W/cap/live\" \"?cb=2ebeca06ca51\"; \"$W/judge.sh\" live --no-cdn → PASS 0 diffs, STATES live ok=24 vacuous=0, PASS 18 rows, JUDGE live OK"
        status: pass
    human_judgment: false
  - id: D4
    description: "사이트 푸시 승인(사람이 SHA를 보고 승인)"
    requirement: "SHELL-04"
    verification:
      - kind: manual_procedural
        ref: "03-06 Task 2 checkpoint:decision (gate=blocking-human) → 사용자 답 push (SHA 2ebeca06ca51)"
        status: pass
    human_judgment: true
    rationale: "라이브 배포 승인은 사람이 하는 결정이다(D-21). 승인은 이미 받았고 기록에 있다"

# Metrics
duration: 6min
completed: 2026-11-16
status: complete
---

# Phase 3 Plan 06: 사이트 푸시와 라이브 확인 Summary

**승인받은 사이트 커밋 2ebeca06ca51을 pre-push 훅을 거쳐 원격 main에 푸시했고, GitHub Pages 빌드 완료 뒤 라이브 세 법적 페이지가 Tailwind 없이 200·같은 제목으로 열리며 두 엔진 × 세 폭에서 전환 전 기준과 픽셀 0으로 보이는 것을 확인했다**

## Performance

- **Duration:** 6 min (이어받은 Task 3부터. Task 1·2는 앞선 실행자와 사용자 승인 단계)
- **Started:** 2026-11-16T17:20:50Z
- **Completed:** 2026-11-16T17:26:27Z
- **Tasks:** 3 (Task 1 tracer, Task 2 승인, Task 3 푸시·라이브 확인)
- **Files modified:** 1 (`03-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- 푸시 직전 `git fetch` 뒤 원격 main이 `SITE_PUSH_PREV`(`9f715c795830`) 그대로임을 확인하고, `2ebeca06ca51` 하나만 `refs/heads/main`으로 푸시했다. pre-push 훅이 `check-site: 통과 (커밋 2ebeca06ca51, jekyll 3.10.0)`로 통과했다. `--no-verify`·force push는 쓰지 않았다.
- `pages/builds/latest`를 20초 간격으로 읽어 세 번째에 `OK 빌드 2ebeca06ca51 built 2026-11-16T17:21:05Z`를 얻었다. 이 줄은 Pages 빌드 기록과 대조해도 맞는다(Task 3 verify 2).
- HTTP 확인: `/privacy-policy/`, `/terms/`, `/data-deletion/`, `/` 모두 200·기대 제목. 법적 세 문서 라이브 HTML에 Tailwind CDN·설정이 0건이고 `rp-legal-card`가 있다(새 배포 반영).
- 화면 확인: 라이브 캡처 `$W/cap/live`가 base1과 PNG 42장 픽셀 0, hover·focus 24장 유효, txt 18건 동일, 네트워크·HTML에 Tailwind 0 → `JUDGE live OK`. 성공 기준 1·2·3이 라이브에서 확정됐고, 새 include 파일이 생긴 뒤의 운영 빌드가 로컬과 같은 출력을 낸다는 가정(RESEARCH A4)도 확인됐다.

## Task Commits

1. **Task 1: 사이트 푸시 후보 검증** - 커밋 없음 (기록은 EVIDENCE `## 03-06 사이트 푸시 후보`, 아래 docs 커밋에 포함)
2. **Task 2: 사이트 푸시 승인** - 커밋 없음 (사용자 답 push)
3. **Task 3: 푸시와 라이브 확인** - 커밋 없음 (원격 main을 `2ebeca06ca51`로 푸시. 기록은 EVIDENCE `## 03-06 사이트 푸시 라이브 확인`, 아래 docs 커밋에 포함)

**Plan metadata:** docs 커밋 (SUMMARY + `03-EVIDENCE.md`). 이 커밋과 STATE·ROADMAP 추적 커밋은 푸시하지 않았다(문서 푸시 D-21 ②에서 함께 나감).

## Files Created/Modified

- `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md` - `## 03-06 사이트 푸시 후보`(Task 1), `## 03-06 사이트 푸시 라이브 확인`(푸시 훅 줄, `OK 빌드` 줄, `OK HTTP` 네 줄, `judge.sh live --no-cdn` 출력 전체, `SITE_PUSH_SHA=2ebeca06ca51`, `LIVE_SITE=OK`)
- `.planning/phases/03-tailwind-cdn-removal/03-06-SUMMARY.md` - 이 문서

## Decisions Made

- 사용자가 사이트 푸시를 승인했다(「push」, SHA `2ebeca06ca51`). 승인은 그 푸시 한 번에만 썼다.
- 라이브 확인이 모두 OK라 되돌리기 절차(D-23)는 쓰지 않았다.

## Deviations from Plan

None - plan executed exactly as written.

배포 완료 대기는 계획의 방식(20초 간격, 최대 10분) 그대로이고, 실행 환경 때문에 폴링 루프를 스크래치의 작은 스크립트로 두고 백그라운드로 돌렸을 뿐이다. 판정 방식은 같다.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 원격 main이 사이트 커밋 끝(`2ebeca06ca51`)까지 나아갔고 라이브가 확인됐다. 다음은 문서 갱신 계획(03-07~03-09)과 문서 푸시(D-21 ②)다.
- 로컬 main에는 이 계획의 docs 커밋과 추적 커밋이 푸시되지 않은 채 남는다. 문서 푸시 때 함께 나간다.
- 첫 공개된 `02-UI-REVIEW.md` 76-84행의 로컬 경로 9줄은 사용자가 보고 그대로 푸시하기로 했다. 지우려면 별도 결정이 필요하다(공개된 이력은 revert로 지워지지 않는다).

## 기록 누출 검사

`03-06-SUMMARY.md`와 `03-EVIDENCE.md`에서 계획 `<verification>`의 세 패턴(홈 변수 문자열, macOS 임시 폴더의 실제 경로 머리, 사용자 홈 아래 절대 경로 머리)을 찾아 모두 0건임을 확인했다.

## Self-Check: PASSED

- 파일: `03-06-SUMMARY.md`, `03-EVIDENCE.md` 있음
- 원격: `git merge-base --is-ancestor 2ebeca06ca51 origin/main` 참
- verify: Task 1 verify, Task 3 verify 1·2 모두 exit 0

---
*Phase: 03-tailwind-cdn-removal*
*Completed: 2026-11-16*
