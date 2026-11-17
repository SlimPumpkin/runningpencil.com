---
phase: 04-landing-content-fix
plan: 05
subsystem: landing-content
tags: [site-01, push, deploy, github-pages, tracer, behave, playwright]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "04-03: 문구 커밋 C1_SHA=abdeb52284d6. 04-04: 빈 뱃지 커밋 C2_SHA=f8d66a6469cf, 비교 기준 $W/c2. 04-02: $W/lib.sh, $W/pw/p4-behave.mjs, $W/base, BASE_LIVE=0bfe5b210c3c"
provides:
  - "원격 main = 073d33e0e50a (문구 커밋 + 빈 뱃지 커밋 + 그 사이 .planning/ 문서 커밋 18개). 라이브 runningpencil.com이 빈 뱃지 커밋 출력과 바이트가 같다"
  - "04-EVIDENCE.md `## 04-05 첫 푸시 후보`: PUSH1_CANDIDATE=073d33e0e50a, PUSH1_PREV=0bfe5b210c3c, 푸시 범위(사이트 파일 index.html 하나, 사이트 커밋 C2·C1), 검토 항목 23줄, 훅 통과 줄"
  - "04-EVIDENCE.md `## 04-05 첫 푸시 라이브 확인`: 승인 기록, PUSH1_SHA=073d33e0e50a, OK 빌드 073d33e0e50a built 2026-11-17T05:43:06Z, 네 URL OK HTTP, OK live index bytes = c2, 라이브 PASS behave, LIVE_PUSH1=OK"
  - "스크래치 $W/live1/ (라이브 네 문서 사본, behave.txt, 커밋 안 함)"
affects: [04-06, 04-07, 04-08]

# Actuals (#2632)
actuals:
  tokens: 843      # chars/4 over 04-EVIDENCE.md에 더한 줄(3371자, 두 구간). SUMMARY 제외. 사이트 코드 변경 없음
  tasks: 3
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). 이 계획은 코드 커밋이 없고 EVIDENCE·SUMMARY는 이 뒤 docs 커밋으로 들어간다
plan_head_before: 073d33e0e50a0efea9e066d275771fb464baa488
plan_head_after: 073d33e0e50a0efea9e066d275771fb464baa488

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "승인한 SHA만 `<전체 해시>:refs/heads/main`으로 훅을 켠 채 푸시 → Pages 빌드 latest를 20초 간격으로 읽어 그 커밋 built 확인 → `?cb=<12자리>`로 라이브를 받아 로컬 빌드와 cmp → 라이브 p4-behave.mjs"
    - "zsh에서 refspec을 만들 때는 `${VAR}:refs/...`처럼 중괄호를 쓴다 (`$VAR:r`은 zsh 수식자)"

key-files:
  created:
    - .planning/phases/04-landing-content-fix/04-05-SUMMARY.md
  modified:
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md

key-decisions:
  - "사용자가 Task 2에서 PUSH1_CANDIDATE=073d33e0e50a를 이름으로 적은 질문에 push로 답했고, 그 SHA 하나만 푸시했다. 푸시 직전 origin/main=PUSH1_PREV, HEAD=PUSH1_CANDIDATE를 다시 확인했다"
  - "라이브 확인이 모두 OK라 되돌림 절차는 쓰지 않았다. 원격 main이 빈 뱃지 커밋까지 나아갔고 04-06(점검 스크립트 6번)·04-07(D-23 문서)로 넘어간다"

patterns-established:
  - "푸시 첫 시도가 원격에 닿기 전에 로컬에서 거부되면(refspec 오류) 원격이 그대로인지 fetch로 확인한 뒤 같은 승인 SHA로 다시 푸시하고, 그 사실을 EVIDENCE 본문에 적는다"

requirements-completed: [SITE-01]

coverage:
  - id: D1
    description: "첫 사이트 푸시는 사람이 SHA(073d33e0e50a)를 보고 승인한 뒤에만 나갔고, 푸시 범위의 사이트 파일은 index.html 하나, 사이트 커밋은 C1·C2 둘뿐이다 (D-21, D-22)"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-05-PLAN.md Task 1 <verify> (exit 0), Task 3 <verify> 첫 명령의 PUSH1_SHA = PUSH1_CANDIDATE·원격 조상 확인 (exit 0)"
        status: pass
    human_judgment: true
    rationale: "푸시 승인은 Task 2 blocking-human decision에서 사람이 했다"
  - id: D2
    description: "Pages 빌드가 073d33e0e50a로 built·오류 없음으로 끝난 뒤 라이브를 봤고, 네 URL 200·기대 제목, 라이브 /가 로컬 C2 빌드와 바이트 같음, 세 낱말 0·「보관함 · 받은 뱃지 7」·빈 뱃지 0, 법적 세 문서 낱말 수 불변 (성공 기준 1)"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-05-PLAN.md Task 3 <verify> 두 명령 (exit 0, 둘째 명령은 gh api pages/builds 대조와 $W/live1/index.html cmp)"
        status: pass
    human_judgment: false
  - id: D3
    description: "라이브에서 p4-behave.mjs가 Chromium·WebKit × 세 문맥 PASS behave (성공 기준 3)"
    requirement: "SITE-01"
    verification:
      - kind: automated_ui
        ref: "node $W/pw/p4-behave.mjs https://runningpencil.com '?cb=073d33e0e50a' → PASS behave"
        status: pass
    human_judgment: false

# Metrics
duration: 3 min (이어 받은 Task 3 구간)
completed: 2026-11-17
---

# Phase 4 Plan 05: 첫 사이트 푸시(문구 + 빈 뱃지) Summary

**사람이 승인한 후보 073d33e0e50a 하나를 pre-push 훅을 거쳐 원격 main에 푸시했고, Pages 빌드가 그 커밋으로 built된 뒤 라이브 `/`가 로컬 빈 뱃지 커밋 빌드와 바이트가 같고(포인트·굿즈·코스북 0줄, 「보관함 · 받은 뱃지 7」, 빈 뱃지 0) 두 엔진 동작 판정이 `PASS behave`임을 확인했다.**

## Performance

- **Duration:** Task 3 구간 약 3분 (푸시 직후 05:43:06Z 빌드 생성, 라이브 확인 05:45Z). Task 1·2는 이전 실행에서 했고 Task 2는 사람의 답을 기다렸다
- **Completed:** 2026-11-17
- **Tasks:** 3 (Task 1 tracer, Task 2 checkpoint:decision, Task 3 auto)
- **Files modified:** 1 (`04-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- 푸시 전: 스크래치(`$W/lib.sh`, playwright, `p4-behave.mjs`, `$W/base`, `$W/c2`)가 모두 있고 TREE가 맞아 다시 만든 것이 없다. `origin/main`=`0bfe5b210c3c`(PUSH1_PREV), HEAD=`073d33e0e50a`(PUSH1_CANDIDATE) 그대로였다.
- 푸시: `git push origin 073d33e0…:refs/heads/main`, 훅 출력 `check-site: 통과 (커밋 073d33e0e50a, jekyll 3.10.0)`, `0bfe5b2..073d33e -> main`.
- 배포: `OK 빌드 073d33e0e50a built 2026-11-17T05:43:06Z` (세 번째 조회에서 built).
- 라이브 HTTP: `/` 200·제목 「러닝펜슬 - 달리고 걷는 길이 아트가 됩니다」·words=0·badge7=1·empty=0, 법적 세 URL 200·기대 제목·낱말 수 6/6/3(로컬과 같음). 라이브 네 문서 모두 로컬 C2 빌드와 바이트가 같다.
- 라이브 동작: `p4-behave.mjs` Chromium·WebKit × (1280, 375, 1280 움직임 줄이기) 모두 OK, `PASS behave`, `empty=0`.
- `LIVE_PUSH1=OK`.

## Task Commits

1. **Task 1: 첫 푸시 후보 검증 (tracer)** — 커밋 없음 (EVIDENCE는 계획 끝 docs 커밋)
2. **Task 2: 푸시 승인 (checkpoint:decision, blocking-human)** — 사용자 답 `push`, 커밋 없음
3. **Task 3: 승인 SHA 푸시와 라이브 확인** — 커밋 없음 (원격 main을 `073d33e0e50a`로 푸시)

EVIDENCE와 이 SUMMARY는 계획 `<output>`대로 하나의 docs 커밋으로 들어가고, 그 커밋은 04-08 문서 푸시 때 함께 나간다.

## Files Created/Modified

- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` — `## 04-05 첫 푸시 후보`(Task 1), `## 04-05 첫 푸시 라이브 확인`(Task 3)과 표식 줄 PUSH1_CANDIDATE·PUSH1_PREV·PUSH1_SHA·LIVE_PUSH1
- `.planning/phases/04-landing-content-fix/04-05-SUMMARY.md` — 이 문서
- 저장소 밖 스크래치(커밋 안 함): `$W/live1/`(라이브 네 문서 사본, `behave.txt`)

## Decisions Made

- 승인받은 SHA 하나만 푸시했다. 되돌림이 필요 없어 되돌리기 승인은 띄우지 않았다.

## Deviations from Plan

None - plan executed as written. 아래 「Issues Encountered」의 푸시 첫 시도 실패는 원격에 닿기 전 로컬 셸 문법 문제였고, 같은 승인 SHA로 다시 푸시했다 (다른 SHA·force·`--no-verify` 없음).

## Issues Encountered

- 푸시 첫 시도에서 zsh가 `"$SHA:refs/heads/main"`의 `:r`을 변수 수식자로 읽어 refspec이 `…efs/heads/main`으로 깨졌고, git이 `src refspec … does not match any`로 거부했다. 훅도 돌지 않았고 원격은 `0bfe5b210c3c` 그대로였다. 원격이 그대로인지 다시 확인한 뒤 `"${SHA}:refs/heads/main"`으로 같은 SHA를 푸시했다. 04-08·04-11·04-13의 푸시도 zsh에서는 중괄호를 써야 한다.

## Threat Flags

None. 새 코드나 파일이 없고, 원격 main이 이미 판정한 커밋까지 나아갔을 뿐이다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 04-06: 점검 스크립트 6번 항목(라이브 확인 뒤 D-23 몫). 04-07: 사이트 상태를 설명하는 D-23 문서(방침 표 갱신).
- 공유 미리보기 서비스의 옛 OG 캐시(A12)는 이 푸시로 바로 바뀌지 않을 수 있다 (막는 항목 아님).

## Self-Check: PASSED

- FOUND: `04-EVIDENCE.md`의 PUSH1_CANDIDATE·PUSH1_PREV·PUSH1_SHA=073d33e0e50a·LIVE_PUSH1=OK, `$W/live1/index.html`, `$W/c2/TREE`
- FOUND: `073d33e0e50a`이 `origin/main`(fetch 뒤) 그 자체이고 C1·C2의 후손
- Task 1 verify, Task 3 verify 두 명령 exit 0. EVIDENCE에 `/Users/`·`/private/var`·`$HOME` 문자열 없음.
