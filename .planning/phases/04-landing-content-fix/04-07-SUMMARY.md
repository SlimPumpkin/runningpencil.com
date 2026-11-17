---
phase: 04-landing-content-fix
plan: 07
subsystem: docs
tags: [site-01, claude-md, generate-claude-md, readme, tracer, docs]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "04-05: 첫 사이트 푸시 PUSH1_SHA=073d33e0e50a와 LIVE_PUSH1=OK. 04-06: check-site 6번 항목(CHECK6_SHA=a02573fe173f)과 원본 맵 네 개를 여섯 항목으로 고친 DOCS_CHECK6_SHA=f8fa9fb1d48c"
provides:
  - "문서 커밋 DOCS_CLAUDE1_SHA=4b9288d285af: 두 CLAUDE.md 방침 표 「포인트·굿즈·코스북 제거」 현재 상태 칸이 「결정됨 (U10). 랜딩은 Phase 4에서 제거됨, 법적 문서 본문에는 남아 있음」, 루트 Deploy 문단에 점검 6번 항목, .claude/CLAUDE.md 생성 구간 재생성"
  - "문서 커밋 DOCS_README1_SHA=5b00b906d609: README·STRUCTURE의 check-site.sh 주석에 「·랜딩 기능 이름」"
  - "04-EVIDENCE.md `## 04-07 CLAUDE.md와 README`: DOCS_CLAUDE1_SHA, OK generator blocks only, OK regenerated, DOCS_README1_SHA, OK stale oldlist=0 oldpolicy=0 localpath=0, DOCS1_STALE=OK"
affects: [04-08]

# Actuals (#2632)
actuals:
  tokens: 840      # chars/4 over 이 계획이 더한 줄 (두 CLAUDE.md·README·STRUCTURE diff + 04-EVIDENCE.md 더한 줄, SUMMARY 제외)
  tasks: 2
  commits: 2       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점, 문서 커밋 둘). EVIDENCE·SUMMARY는 이 뒤 docs 커밋으로 들어간다
plan_head_before: 0cb5bbc55e9dc2e2362378809f3368e9bb5a597a
plan_head_after: 5b00b906d609532ba9e9b0d70fbbe4a962fe5491

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "방침 행 갱신은 두 사본을 한 커밋에서 고치고, .claude/CLAUDE.md 생성 구간은 생성기 사본 시험(바뀌는 블록 확인) 뒤 --output·--auto 없이 재생성한다 (Phase 1~3 선례 재사용)"

key-files:
  created:
    - .planning/phases/04-landing-content-fix/04-07-SUMMARY.md
  modified:
    - CLAUDE.md
    - .claude/CLAUDE.md
    - README.md
    - .planning/codebase/STRUCTURE.md
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md

key-decisions:
  - "04-07: 두 CLAUDE.md 문서 커밋 4b9288d285af(방침 행 「랜딩은 Phase 4에서 제거됨, 법적 문서 본문에는 남아 있음」, 생성기 사본 시험에서 stack·conventions·architecture 네 줄만 바뀌어 --auto 없이 재생성), README·STRUCTURE 커밋 5b00b906d609. 열 개 문서 옛 나열·옛 방침 칸·로컬 경로 0줄(DOCS1_STALE=OK). 푸시 안 함"

patterns-established: []

requirements-completed: [SITE-01]

coverage:
  - id: D1
    description: "두 CLAUDE.md 방침 구간이 글자까지 같고 「포인트·굿즈·코스북 제거」 행 현재 상태가 「결정됨 (U10). 랜딩은 Phase 4에서 제거됨, 법적 문서 본문에는 남아 있음」. 루트 Deploy 문단에 「랜딩 출력에 포인트·굿즈·코스북이 없음」. 커밋은 첫 푸시 뒤이고 두 CLAUDE.md만 담음"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-07-PLAN.md Task 1 <verify> 첫 명령 (exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: ".claude/CLAUDE.md가 원본 맵에서 다시 생성한 사본과 바이트가 같고 「점검 항목은 여섯이다」를 적음"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-07-PLAN.md Task 1 <verify> 둘째 명령 (exit 0)"
        status: pass
    human_judgment: false
  - id: D3
    description: "README·STRUCTURE 점검 주석에 6번 항목, 열 개 문서에 옛 나열·옛 방침 칸·로컬 경로 0줄, README·STRUCTURE 커밋은 두 파일만 담음"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-07-PLAN.md Task 2 <verify> (exit 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 3min
completed: 2026-11-17
---

# Phase 4 Plan 07: CLAUDE.md와 README Summary

**두 CLAUDE.md 방침 표의 「포인트·굿즈·코스북 제거」 행을 「랜딩은 Phase 4에서 제거됨, 법적 문서 본문에는 남아 있음」으로 같은 커밋에서 고치고 루트 Deploy 문단에 점검 6번 항목을 더했으며, `.claude/CLAUDE.md` 생성 구간을 사본 시험 뒤 재생성하고 README·STRUCTURE 점검 주석까지 여섯 항목으로 맞췄다**

## Performance

- **Duration:** 3 min
- **Started:** 2026-11-17T07:13:16Z
- **Completed:** 2026-11-17T07:16:00Z (SUMMARY 작성 직전 측정 시각. SUMMARY docs 커밋은 이 뒤)
- **Tasks:** 2
- **Files modified:** 5 (CLAUDE.md 두 사본, README, STRUCTURE, 검증 기록)

## Accomplishments

- 다음 작업 세션이 「랜딩에 아직 남아 있다」는 옛 설명을 보고 결정을 되돌리지 않도록, 두 CLAUDE.md 방침 행이 지금 상태를 적는다 (D-23). 두 사본의 방침 구간은 글자까지 같고, 커밋은 첫 푸시(`073d33e0e50a`)의 라이브 확인 뒤에 만들었다.
- 루트 `CLAUDE.md` Deploy 문단이 pre-push 점검 항목 여섯(마지막 「랜딩 출력에 포인트·굿즈·코스북이 없음」)을 적는다.
- `.claude/CLAUDE.md` 생성 구간은 손 편집 없이 원본 맵(04-06)에서 다시 만들었다. 사본 시험에서 바뀐 블록은 stack·conventions·architecture뿐(네 줄)이고, 방침 구간·project·skills·workflow·profile은 그대로였다. 저장소 재생성 결과는 시험 사본과 바이트가 같다.
- README·STRUCTURE의 `check-site.sh` 주석이 6번 항목(「랜딩 기능 이름」)을 적고, 문서 열 개 어디에도 다섯 항목짜리 옛 나열·옛 방침 칸·로컬 경로가 없다.

## Task Commits

1. **Task 1: 두 CLAUDE.md 방침 행·Deploy 문단, 생성 구간 재생성 (tracer)** - `4b9288d285af` (docs)
2. **Task 2: README·STRUCTURE 점검 주석, 문서 열 개 훑기** - `5b00b906d609` (docs)

**Plan metadata:** SUMMARY·EVIDENCE docs 커밋 (이 SUMMARY 뒤)

## Files Created/Modified

- `CLAUDE.md` - 방침 표 「포인트·굿즈·코스북 제거」 현재 상태 칸, Deploy 문단 점검 나열 끝
- `.claude/CLAUDE.md` - 같은 방침 행, 생성기로 다시 만든 stack·conventions·architecture 블록(점검 6번 항목)
- `README.md` - 코드 블록 `scripts/check-site.sh` 주석
- `.planning/codebase/STRUCTURE.md` - 디렉터리 그림 `check-site.sh` 주석
- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` - `## 04-07 CLAUDE.md와 README` 구간

## Decisions Made

- 계획대로 진행했다. 생성기 사본 시험 결과가 계획의 기대(stack·conventions·architecture 블록만 바뀜, 방침 구간 유지)와 같아 저장소에서 재생성했다.

## Deviations from Plan

None - plan executed exactly as written.

참고(계획 문구, 실행 변경 아님): Task 2 action 3번은 `.planning/codebase/*.md`를 「여덟 개」로 적었으나 실제 파일은 일곱 개(ARCHITECTURE·CONCERNS·CONVENTIONS·INTEGRATIONS·STACK·STRUCTURE·TESTING)이고, 합계 「열 개」는 맞다. verify는 glob으로 일곱 개를 모두 훑었다. EVIDENCE에도 같은 내용을 적었다.

## Issues Encountered

None

## Known Stubs

None

## Threat Flags

None. 문서만 바꿨고 사이트 파일·네트워크 경로·인증은 건드리지 않았다. `.planning/PROJECT.md`는 바뀌지 않았다(D-24 마지막 항목).

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 04-08: 문서 푸시가 점검 커밋(`a02573fe173f`)과 문서 커밋들(`f8fa9fb1d48c`, `4b9288d285af`, `5b00b906d609`, 그리고 SUMMARY·EVIDENCE docs 커밋)을 함께 낸다. 푸시는 그 계획의 승인 checkpoint를 거친다. 이 계획은 아무것도 푸시하지 않았다.

---
*Phase: 04-landing-content-fix*
*Completed: 2026-11-17*

## Self-Check: PASSED

- 수정 파일 다섯 개(두 CLAUDE.md, README, STRUCTURE, 검증 기록)가 디스크에 있다.
- 커밋 `4b9288d285af`, `5b00b906d609`가 HEAD의 조상이다. 계획 원장 기준 커밋 수 2.
- Task 1 verify 두 명령, Task 2 verify 한 명령이 모두 exit 0이다.
- 검증 기록 누출 검사(사용자 홈 폴더 꼴, macOS 임시 폴더 꼴)가 0줄이다. `.planning/PROJECT.md`는 계획 시작 커밋과 같다.
