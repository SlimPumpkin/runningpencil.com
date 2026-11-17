---
phase: 04-landing-content-fix
plan: 01
subsystem: planning-docs
tags: [roadmap, requirements, user-tasks, site-06, capture]
status: complete
requires: []
provides:
  - "출시 전 표시 기준 문장 (ROADMAP Phase 4 Goal·성공 기준 2, REQUIREMENTS SITE-06)"
  - "앱 화면 캡처 절차서 작업 10 (D-16~D-20)"
  - "Phase 4 판정 기록 04-EVIDENCE.md, 표식 DOCS_BASE_SHA"
affects: [04-02, 04-09, 04-10, 04-11]
tech-stack:
  added: []
  patterns: ["판정 기록 표식 줄 `이름=값` (줄 머리부터)"]
key-files:
  created:
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md
  modified:
    - .planning/ROADMAP.md
    - .planning/REQUIREMENTS.md
    - .planning/baseline/USER-TASKS.md
key-decisions:
  - "기준 문장 세 곳의 출시 전 표시를 「출시 전임을 알리는 표시(현재 「출시 준비 중」)」로 고침. Phase 9 성공 기준 2 문구는 그대로 둠 (D-08)"
  - "작업 10을 iPhone 한 기기·화면 세 장·하단 탭 없음·NAVER 로고 유지·검색 결과 목록 없음 조건으로 고침 (D-16~D-20, D-19)"
requirements-completed: [SITE-06]
duration: 1 min
completed: 2026-11-17
commits: 1
plan_head_before: 2d17783e3f2768a297adf6edd9921b6e9bf8d0ce
plan_head_after: 760d0e93e9ce3f983c5905259d935be7cdd1c9e9
actuals:
  tokens: 2100
  tasks: 2
  commits: 1
coverage:
  - deliverable: "기준 문장 세 곳이 「출시 준비 중」 기준으로 바뀌고 Phase 9 문구는 그대로"
    human_judgment: false
    verification:
      - kind: command
        ref: "04-01-PLAN Task 1 <verify> (roadmap validate 포함)"
        status: pass
  - deliverable: "작업 10이 D-16~D-20 조건을 안내하고 첫 문서 커밋이 세 파일만 담음"
    human_judgment: false
    verification:
      - kind: command
        ref: "04-01-PLAN Task 2 <verify>"
        status: pass
---

# Phase 4 Plan 01: 기준 문장과 캡처 절차서 갱신 Summary

ROADMAP Phase 4 Goal·성공 기준 2와 REQUIREMENTS SITE-06의 출시 전 표시를 화면 문구 「출시 준비 중」 기준으로 맞추고, USER-TASKS 작업 10을 iPhone 한 기기·세 화면·하단 탭 없음·NAVER 로고 유지·검색 결과 목록 없음 조건의 캡처 절차로 고친 첫 문서 커밋.

**작업 10이 갱신되어 사용자가 지금 캡처를 시작할 수 있다.**

## Performance

- 시작: 2026-11-17T04:11:18Z
- 끝: 2026-11-17T04:12:29Z
- 소요: 약 1분
- Task: 2개, 바꾼 파일: 4개 (문서 3 + 새 판정 기록 1)

## Accomplishments

- 기준 문장 세 곳(ROADMAP Phase 4 Goal, 성공 기준 2, REQUIREMENTS SITE-06)이 「출시 전임을 알리는 표시(현재 「출시 준비 중」)」를 쓴다. 세 줄에 옛 표시 문구가 없고, Phase 9 성공 기준 2의 문구는 그대로다. `roadmap validate`가 `"warnings": []`.
- USER-TASKS 작업 10의 「순서」·「끝났는지 확인」·「Claude에게 넘길 것」을 이 단계 결정대로 고쳤다. 옛 둘러보기 예시는 지웠다. 절 머리, 「막는 단계」, 「레코드 표」·「변경 전후 dig」 줄과 다른 절은 그대로다.
- 첫 문서 커밋은 세 파일(ROADMAP·REQUIREMENTS·USER-TASKS)만 담는다.
- `04-EVIDENCE.md`를 새로 만들고 기록 규칙, 구간 `## 04-01 첫 문서 커밋`, 표식 `DOCS_BASE_SHA=760d0e93e9ce`, `OK roadmap validate warnings=0`을 적었다.

## Task Commits

1. **Task 1: 기준 문장 세 곳 수정** — Task 2 커밋에 함께 들어감 (계획이 정한 대로 한 커밋)
2. **Task 2: 작업 10 수정과 첫 문서 커밋** — `760d0e93e9ce` (docs)

판정 기록과 이 SUMMARY는 뒤의 docs 커밋에 들어간다.

## Files Created/Modified

- `.planning/ROADMAP.md` — Phase 4 Goal 줄, 성공 기준 2 줄
- `.planning/REQUIREMENTS.md` — SITE-06 줄
- `.planning/baseline/USER-TASKS.md` — 작업 10 절
- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` — 새 Phase 4 판정 기록

## Decisions Made

계획대로 따름 (D-08, D-16~D-20, D-19). 새로 정한 것은 없다.

## Deviations from Plan

None - plan executed exactly as written.

## Verification

- Task 1 verify: exit 0. 새 표현 줄 수 ROADMAP 2, REQUIREMENTS 1.
- Task 2 verify: exit 0.
- `git diff --name-only 2d17783e3f27 HEAD -- . ':(exclude).planning'`: 빈 출력 (사이트 파일 변경 없음).
- `04-EVIDENCE.md` 누출 검사(`$HOME`, `/private/var`, `/Users/`): 0건.
- `scripts/check-site.sh`(작업 트리): 통과.

## Issues Encountered

None.

## Next Phase Readiness

04-02 준비됨. 사용자는 지금 작업 10(앱 화면 캡처)을 시작할 수 있다.

## Self-Check: PASSED

- FOUND: `.planning/phases/04-landing-content-fix/04-EVIDENCE.md`
- FOUND: `760d0e93e9ce` (HEAD의 조상)
