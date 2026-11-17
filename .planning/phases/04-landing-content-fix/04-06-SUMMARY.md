---
phase: 04-landing-content-fix
plan: 06
subsystem: tooling
tags: [site-01, check-site, pre-push, bash, tracer, docs]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "04-05: 첫 사이트 푸시 PUSH1_SHA=073d33e0e50a와 LIVE_PUSH1=OK. 04-03: 문구 커밋 C1_SHA=abdeb52284d6. 04-04: 후보 출력 $W/c2. 04-02: BASE_SHA=0e75e8b88fd2, $W/lib.sh"
provides:
  - "점검 커밋 CHECK6_SHA=a02573fe173f: scripts/check-site.sh 6번 항목 「랜딩에 출시 범위 밖 기능 이름 없음」(빌드 출력 index.html 한 파일에서 포인트·굿즈·코스북을 찾으면 실패), 머리 주석 「여섯 가지를 확인한다」와 6번 줄"
  - "문서 커밋 DOCS_CHECK6_SHA=f8fa9fb1d48c: 원본 맵 네 개(CONVENTIONS·TESTING·ARCHITECTURE·STACK)의 다섯 곳이 점검 항목 여섯을 적음"
  - "04-EVIDENCE.md `## 04-06 check-site 6번 항목`: CHECK6_CAND=bf010105a13b, CHECK6_SHA, 후보·C1 통과 줄, 기준 커밋 음성 대조 출력(/index.html 2줄, 종료 코드 1), OK site output unchanged by check6, 훅 경로 통과, OK pre-push unchanged, CHECK6=OK, DOCS_CHECK6_SHA"
  - "스크래치 $W/ck6 (후보 빌드와 TREE, 커밋 안 함)"
affects: [04-07, 04-08]

# Actuals (#2632)
actuals:
  tokens: 1210     # chars/4 over 이 계획이 더한 줄 (check-site.sh·원본 맵 네 개 diff + 04-EVIDENCE.md 더한 줄, SUMMARY 제외)
  tasks: 2
  commits: 2       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점, 점검 커밋과 문서 커밋). EVIDENCE·SUMMARY는 이 뒤 docs 커밋으로 들어간다
plan_head_before: 2d1fbda00fc35b06b133887abae6c8ab98fe65de
plan_head_after: f8fa9fb1d48cee792d1d50f4b6d0f5403c21ae3c

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "점검 항목 추가는 별도 build 커밋 하나(스크립트만) + 음성 대조(그 커밋의 스크립트로 문제 있는 옛 커밋을 점검해 실패 메시지 확인) + 출력 불변(diff -r 빈 출력) + 훅 경로 통과 (Phase 3 5번 항목 선례 재사용)"
    - "재유입 차단 점검은 첫 푸시 라이브 확인 뒤에 커밋해, 첫 푸시를 되돌리는 revert 푸시를 막지 않게 한다 (RESEARCH 위험 1 (a))"

key-files:
  created:
    - .planning/phases/04-landing-content-fix/04-06-SUMMARY.md
  modified:
    - scripts/check-site.sh
    - .planning/codebase/CONVENTIONS.md
    - .planning/codebase/TESTING.md
    - .planning/codebase/ARCHITECTURE.md
    - .planning/codebase/STACK.md
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md

key-decisions:
  - "6번 항목은 빌드 출력 index.html 한 파일만 본다. 법적 문서는 Phase 6~8 전까지 세 낱말이 남아 있어 보지 않는다. 다른 항목 번호는 그대로 둔다(문서가 인용하는 「4번 항목」 유지)"
  - "6번 항목 주석에 U10·SITE-01·「이번 마일스톤」과 「코스북이 앱에 들어오면 이 항목을 고친다」를 적어 오탐·Deferred 복귀 때 고칠 곳을 남겼다 (RESEARCH 위험 2)"

patterns-established:
  - "plan의 verify 명령에 \"$K:path\" 꼴 refspec이 있으면 zsh가 :s 등을 수식자로 읽으므로 bash로 돌린다 (실행 환경 메모와 같은 원인)"

requirements-completed: [SITE-01]

coverage:
  - id: D1
    description: "scripts/check-site.sh 6번 항목: 랜딩 출력 index.html에 포인트·굿즈·코스북이 있으면 실패. 점검 커밋·문구 커밋은 통과, 기준 커밋은 「/index.html 2줄」로 실패(음성 대조)"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-06-PLAN.md Task 1 <verify> 첫 명령 (bash로 실행, exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "점검 커밋은 scripts/check-site.sh 하나만 담고 사이트 출력을 바꾸지 않으며(diff -r $W/c2/site $W/ck6/site 빈 출력), pre-push 훅은 그대로이고 훅 경로로 후보가 통과. bash 3.2 문법·법적 문서 미검색"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-06-PLAN.md Task 1 <verify> 두 명령 (exit 0); EVIDENCE OK site output unchanged by check6, OK pre-push unchanged"
        status: pass
    human_judgment: false
  - id: D3
    description: "원본 맵 네 개의 다섯 곳이 점검 항목 여섯을 적고, 문서 커밋은 네 맵만 담음"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-06-PLAN.md Task 2 <verify> (bash로 실행, exit 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 3min
completed: 2026-11-17
---

# Phase 4 Plan 06: check-site 6번 항목 Summary

**푸시 전 점검 `scripts/check-site.sh`에 빌드 출력 `index.html`의 포인트·굿즈·코스북을 막는 6번 항목을 별도 build 커밋으로 더하고(기준 커밋으로 「/index.html 2줄」 실패를 음성 대조), 원본 맵 네 개를 점검 항목 여섯으로 고쳤다**

## Performance

- **Duration:** 3 min
- **Started:** 2026-11-17T05:56:21Z
- **Completed:** 2026-11-17T05:59:28Z (SUMMARY docs 커밋 시각, 측정값. 시작부터 3분 7초)
- **Tasks:** 2
- **Files modified:** 6 (점검 스크립트 1, 원본 맵 4, 검증 기록 1)

## Accomplishments

- 랜딩에 출시 범위 밖 기능 이름이 다시 들어오면 `main` 푸시마다 도는 pre-push 점검이 푸시를 막는다 (SITE-01 재유입 차단, T-04-14).
- 새 스크립트가 후보(`bf010105a13b`)와 문구 커밋(`abdeb52284d6`)을 통과시키고, 문구 정정 전 기준 커밋(`0e75e8b88fd2`)을 종료 코드 1, 메시지 `랜딩에 출시 범위 밖 기능 이름이 있습니다: /index.html 2줄 (포인트·굿즈·코스북, U10)`로 실패시킨다.
- 점검 커밋은 사이트 출력을 바꾸지 않는다(`$W/c2/site`와 `$W/ck6/site`의 `diff -r` 빈 출력). 훅 경로(`.githooks/pre-push`에 refs 한 줄을 넣어 실행)도 통과했다. 훅 파일은 그대로다.
- 점검 커밋은 첫 푸시(`073d33e0e50a`)의 라이브 확인 뒤에 만들었으므로, 첫 푸시를 되돌리는 revert 푸시를 막지 않는다.
- 원본 맵 네 개(`CONVENTIONS.md`·`TESTING.md`·`ARCHITECTURE.md`·`STACK.md`)가 점검 항목 여섯을 적는다.

## Task Commits

1. **Task 1: 점검 스크립트 6번 항목 (tracer)** - `a02573fe173f` (build)
2. **Task 2: 원본 맵 네 개에 6번 항목 반영** - `f8fa9fb1d48c` (docs)

**Plan metadata:** SUMMARY·EVIDENCE docs 커밋 (이 SUMMARY 뒤)

## Files Created/Modified

- `scripts/check-site.sh` - 머리 주석 「여섯 가지」와 6번 줄, 5번 항목 뒤 6번 구획(`u10` 줄 수 검사)
- `.planning/codebase/CONVENTIONS.md` - Linting 항목: 「점검 항목은 여섯이다」, 목록 끝에 6번
- `.planning/codebase/TESTING.md` - Runner 항목: 「여섯 가지를 본다」, 목록 끝에 6번
- `.planning/codebase/ARCHITECTURE.md` - System Overview 괄호 나열과 Component 표의 푸시 전 점검 행
- `.planning/codebase/STACK.md` - Configuration의 `scripts/check-site.sh` 괄호 나열
- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` - `## 04-06 check-site 6번 항목` 구간

## Decisions Made

- 6번 항목의 범위는 빌드 출력 `index.html` 한 파일이다. 법적 문서와 사이트 전체는 검색하지 않는다(Phase 6~8 전에는 늘 실패하므로).
- 주석에 U10·SITE-01·「이번 마일스톤」과, 코스북이 앱에 들어오면 이 항목을 고친다는 문장을 적었다 (RESEARCH 위험 2).

## Deviations from Plan

None - plan executed exactly as written.

참고(실행 환경, 계획 변경 아님): plan의 verify 첫 명령은 bash 문법이다. zsh 셸에서 바로 돌리면 `"$K:scripts/…"`의 `:s`를 변수 수식자로 읽어 `git show`가 실패한다. 같은 명령을 스크래치 파일에 그대로 옮겨 `bash`로 돌렸고 exit 0이었다. 계획 문구나 커밋 내용은 바꾸지 않았다.

## Issues Encountered

None

## Known Stubs

None

## Threat Flags

None. 새 네트워크 경로·인증·파일 접근은 없다. 6번 항목은 로컬 빌드 출력 한 파일만 읽는다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 04-07: 루트 `CLAUDE.md`(Deploy 문단의 점검 나열)·README·STRUCTURE를 고치고 `.claude/CLAUDE.md`를 원본 맵에서 다시 생성한다. 원본 맵은 이 계획에서 여섯 항목으로 고쳐 두었다.
- 04-08: 문서 푸시가 점검 커밋(`a02573fe173f`)을 문서 커밋들과 함께 낸다. 푸시는 그 계획의 승인 checkpoint를 거친다. 이 계획은 아무것도 푸시하지 않았다.

---
*Phase: 04-landing-content-fix*
*Completed: 2026-11-17*

## Self-Check: PASSED

- 파일 여섯 개(점검 스크립트, 원본 맵 넷, 검증 기록)가 디스크에 있다.
- 커밋 `a02573fe173f`(build), `f8fa9fb1d48c`(docs)가 HEAD의 조상이다.
- Task 1 verify 두 명령, Task 2 verify 한 명령이 모두 exit 0이다.
- 검증 기록 누출 검사(홈 변수 값, 임시 폴더 실제 경로, 사용자 폴더 꼴)가 0줄이다.
