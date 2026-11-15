---
phase: 01-ground-truth-policy-reset
plan: 09
subsystem: planning-docs
tags: [roadmap, state, external-gates, dkim, gap-closure]
gap_closure: true
gap_ids: [G-01-2]

requires:
  - phase: 01-ground-truth-policy-reset
    provides: "01-07이 U12 결정에 맞춰 적은 ROADMAP External Gates 가비아 행과 STATE Blockers 가비아 항목, 01-02가 쓴 절차서 작업 6(DKIM → Phase 10)"
provides:
  - "ROADMAP External Gates 표의 가비아 DNS 행을 1차 방문(→ Phase 5)과 2차 방문 DKIM(→ Phase 10 Apple 릴레이 답장, SUP-05) 두 행으로 나눔"
  - "ROADMAP Phase 5 가비아 항목에 「2차 방문(DKIM)은 Phase 5 완료를 막지 않습니다」 문장"
  - "ROADMAP Phase 10 External gates가 DKIM(절차서 작업 6)을 이 단계의 게이트로 적음"
  - "STATE Blockers의 가비아 항목을 1차(→ Phase 5)와 2차 DKIM(→ Phase 10) 두 줄로 나눔"
affects: [phase-05, phase-10]

actuals:
  tokens: 650    # 근사: chars/4, 두 task 커밋의 더한 줄(1557자)과 지운 줄을 합친 diff 기준
  tasks: 2
  commits: 2     # MEASURED: git rev-list --count 815d620..31f3b52 (SUMMARY 작성 시점)
plan_head_before: 815d620dc95b44a6dd9a112d67d2584eeeaf87eb
plan_head_after: 31f3b5228482a3f83d153b8135b0938684303c3e

tech-stack:
  added: []
  patterns:
    - "task 커밋에서 다른 쓰는 이의 커밋하지 않은 STATE 줄을 빼려고 HEAD 판 사본을 고쳐 git update-index --cacheinfo로 스테이징"

key-files:
  created:
    - .planning/phases/01-ground-truth-policy-reset/01-09-SUMMARY.md
  modified:
    - .planning/ROADMAP.md
    - .planning/STATE.md

key-decisions:
  - "G-01-2: 가비아 DNS 2차 방문(DKIM, 절차서 작업 6)은 Phase 10(Apple 릴레이 답장, SUP-05)만 막고, 작업 시점은 Phase 5 무렵으로 둠. 막는 단계의 정본인 ROADMAP External Gates 표를 절차서에 맞춤 (D-14)"

patterns-established:
  - "막는 단계가 다른 두 작업은 External Gates 표에서 행을 나눠 적는다 (한 행에 묶으면 앞 단계 완료 조건으로 읽힘)"

requirements-completed: [BASE-04]

coverage:
  - id: D1
    description: "ROADMAP External Gates 표의 가비아 행이 1차(Phase 5)·2차 DKIM(Phase 10) 두 행이고 표의 나머지는 기준 커밋과 같음"
    requirement: "BASE-04"
    verification:
      - kind: other
        ref: "01-09-PLAN.md Task 1 verify 1·4·5 (External Gates 행 수 14, 가비아 행 2, 절차서 작업 2·6과 막는 단계 일치, 진행 기록·범위 밖 줄 불변)"
        status: pass
    human_judgment: false
  - id: D2
    description: "ROADMAP Phase 5 가비아 항목과 Phase 10 External gates의 DKIM 문장이 DKIM을 Phase 10 게이트로 적음"
    requirement: "BASE-04"
    verification:
      - kind: other
        ref: "01-09-PLAN.md Task 1 verify 2·3·6 (넣은 문장 글자 비교, 기준 줄 복원 비교, 누출 정규식)"
        status: pass
    human_judgment: false
  - id: D3
    description: "STATE Blockers의 가비아 항목이 1차(→ Phase 5)·2차 DKIM(→ Phase 10) 두 줄이고 task 커밋에는 Blockers 안의 변경만 있음"
    requirement: "BASE-04"
    verification:
      - kind: other
        ref: "01-09-PLAN.md Task 2 verify 1·2·3 (줄 글자 비교, Blockers 밖 불변, state validate, SUMMARY 누출 검사)"
        status: pass
    human_judgment: false
  - id: D4
    description: "절차서 작업 0~12의 막는 단계가 ROADMAP 표, Phase 5·10 External gates, STATE Blockers와 어긋나지 않음 (UAT Test 2 재확인)"
    verification: []
    human_judgment: true
    rationale: "계획의 human-check 항목. 세 문서의 문장 뜻이 같은지는 사람이 읽고 판단해야 함"

duration: 5min
completed: 2026-11-15
status: complete
---

# Phase 1 Plan 09: 가비아 DNS 2차 방문(DKIM)의 막는 단계를 Phase 10으로 바로잡음 Summary

**ROADMAP External Gates 표의 가비아 행을 1차 방문(→ Phase 5)과 2차 방문 DKIM(→ Phase 10 Apple 릴레이 답장, SUP-05)으로 나누고, Phase 5·Phase 10 External gates와 STATE Blockers를 절차서 작업 6에 맞춤 (UAT gap G-01-2 닫음)**

## Performance

- **Duration:** 약 5분
- **Started:** 2026-11-15T18:15:04Z
- **Completed:** 2026-11-15T18:20Z
- **Tasks:** 2
- **Files modified:** 2 (`.planning/ROADMAP.md`, `.planning/STATE.md`)

## Accomplishments

- External Gates 표: 가비아 DNS 행 하나를 같은 자리의 두 행으로 나눔. 1차 방문 행(도메인 인증 TXT·MX·SPF, Search Console TXT) → Phase 5, 2차 방문 행(DKIM, 절차서 작업 6, 작업 시점 Phase 5 무렵) → Phase 10 (Apple 릴레이 답장, SUP-05). 표 행은 13줄에서 14줄이 됨
- Phase 5 External gates의 「사용자 DNS 작업(가비아)」 항목: 「2차 방문(DKIM)은 Phase 5 완료를 막지 않습니다. 이메일 게이트는 DKIM을 기다리지 않고, DKIM은 Phase 10 Apple 릴레이 답장(SUP-05)의 전제입니다. 작업 시점은 그대로 Phase 5 무렵입니다.」 세 문장을 더함. 기존 문장은 그대로 둠
- Phase 10 External gates: 「DKIM은 Phase 5의 가비아 DNS 2차 방문에서 이미 추가합니다」를 「DKIM(절차서 작업 6, 가비아 DNS 2차 방문)도 이 단계의 게이트입니다. 작업 시점은 Phase 5 무렵이지만, 릴레이 답장 시험 전에는 끝나 있어야 합니다」로 바꿈
- STATE Blockers: 가비아 항목을 1차 방문과 메일 수신 시험(→ Phase 5), 2차 방문 DKIM(작업 6, → Phase 10) 두 줄로 나눔

## Task Commits

1. **Task 1: ROADMAP External Gates 가비아 행 분리, Phase 5·Phase 10 DKIM 문장 수정** - `0232a75` (docs)
2. **Task 2: STATE Blockers 가비아 항목 분리** - `31f3b52` (docs)

**Plan metadata:** 이 SUMMARY 커밋과 뒤따르는 「계획 09 완료 상태 반영」 추적 커밋

## Files Created/Modified

- `.planning/ROADMAP.md` - External Gates 표 가비아 행 두 줄, Phase 5 가비아 항목 세 문장 추가, Phase 10 External gates DKIM 문장 교체 (+4/-3)
- `.planning/STATE.md` - Blockers/Concerns 가비아 항목 두 줄 (+2/-1)
- `.planning/phases/01-ground-truth-policy-reset/01-09-SUMMARY.md` - 이 문서

## 실행 방식과 스테이징

- **실행 방식:** 주 작업 트리에서 순차 실행 (`.git`이 디렉터리). worktree가 아니므로 병합 없음
- **precondition 결과:** Task 1의 ROADMAP.md는 HEAD·인덱스 모두 깨끗해 통과. Task 2는 순차 실행이라 확인할 것이 없음. 멈춘 곳 없음
- **Task 2 스테이징:** 작업 트리의 STATE.md에는 단계 시작 처리(`state.begin-phase`)가 남긴 커밋하지 않은 줄(front matter의 status·last_updated·last_activity·state_head·total_plans, Current Position의 Plan·Status·Last activity)이 있었음. 그래서 `git show HEAD:.planning/STATE.md`로 만든 사본에 같은 치환을 넣고 `git hash-object -w`와 `git update-index --cacheinfo 100644,<blob>,.planning/STATE.md`로 인덱스에 올림. task 커밋 `31f3b52`는 STATE.md +2/-1만 담았고, 단계 시작 줄은 작업 트리에 그대로 남아 추적 커밋이 가져감. stash·되돌리기 없음
- `.planning/config.json`(수정됨)과 `.planning/state.json`(추적 안 됨)은 이 계획 밖의 변경이라 스테이징하지 않음

## 대체된 검사

01-07 Task 1 verify의 External Gates 표 행 수 검사(`rows=13`)는 이 계획으로 표가 14줄이 되어 exit 1을 냄. 사용자 결정(2026-11-15 「Phase 10만 막음」)에 따른 의도한 대체이며 회귀가 아님. 01-07의 다른 검사(STATE Blockers에 「가비아 DNS」·「2차 방문」·`USER-TASKS`가 함께 있는 줄, Phase 10 External gates와 「가비아 DNS」로 시작하는 표 행에 「2차 방문」, Phase 5 구간에 DKIM·「2차 방문」·「24~72시간」)는 이 계획 뒤에도 통과하도록 문장을 정함.

## Verification

- Task 1 verify 여섯 명령: 스테이징 뒤와 커밋 뒤 모두 exit 0 (`rows=14 gabia=2`, 절차서 작업 6 「Phase 10 Apple 릴레이, D-11」 = 표 2차 행 「Phase 10 (Apple 릴레이 답장, SUP-05)」, 작업 2 = 1차 행 = Phase 5)
- Task 2 verify 세 명령: 인덱스 기준(`measured=index`)과 커밋 기준(`measured=31f3b52…`) 모두 exit 0, `state validate` valid true
- 라이브 사이트 파일, 절차서, 결정 목록, REQUIREMENTS는 기준 커밋 `251ed7b`와 같음 (Task 1 verify 6)
- 푸시하지 않음

## Decisions Made

- 계획대로 진행. 막는 단계의 정본(ROADMAP External Gates 표, D-14)을 절차서 작업 6에 맞춤

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None

## User Setup Required

None - 이 계획은 문서만 고침. 가비아 DNS 작업 자체는 절차서(`.planning/baseline/USER-TASKS.md`)대로 사용자가 함

## Next Phase Readiness

- G-01-2 닫힘. 남은 gap 계획은 01-10 (G-01-8)
- UAT Test 2 재확인(절차서 작업 0~12와 ROADMAP·STATE의 막는 단계 대조)은 사람이 확인할 항목으로 남음 (coverage D4)

---
*Phase: 01-ground-truth-policy-reset*
*Completed: 2026-11-15*

## Self-Check: PASSED

- 파일: `.planning/ROADMAP.md`, `.planning/STATE.md`, 이 SUMMARY 모두 있음
- 커밋: `0232a75`, `31f3b52` 모두 HEAD의 조상
- SUMMARY 누출 검사(Task 2 verify 3): exit 0
