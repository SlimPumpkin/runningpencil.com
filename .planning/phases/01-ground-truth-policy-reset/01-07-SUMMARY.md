---
phase: 01-ground-truth-policy-reset
plan: 07
subsystem: docs
tags: [roadmap, state, project, research, gitignore, u12, dns]
status: complete

requires:
  - phase: 01-ground-truth-policy-reset
    provides: "01-02의 사용자 작업 절차서(USER-TASKS.md), 01-04의 결정 목록 U12 기록(DECISIONS.md), 01-06의 .claude/CLAUDE.md 생성 기준"
provides:
  - "ROADMAP.md Phase 5·8·10 문장과 External Gates 표가 U12 결정(Google Workspace 사용자 별칭 도메인, 지원 주소에서 답장), 가비아 DNS 1차·2차 방문, /location-terms/ 확정을 말함"
  - "STATE.md Blockers/Concerns의 DNS·U12 문장과 Decisions의 U12 결정 한 줄"
  - "PROJECT.md Key Decisions의 지원 메일 행과 위치약관 경로 확정"
  - "research/STACK.md 네 구간, research/SUMMARY.md 일곱 구간 머리의 U12 결정 메모"
  - ".gitignore의 GSD 연구 캐시 구획"
affects: [phase-05, phase-08, phase-10]

actuals:
  tokens: 6700
  tasks: 3
  commits: 3
plan_head_before: 35db2a05
plan_head_after: 1b10f31e

tech-stack:
  added: []
  patterns:
    - "연구 문서는 본문을 고치지 않고 구간 머리에 날짜 붙은 결정 메모 한 줄만 더함"

key-files:
  created: []
  modified:
    - .planning/ROADMAP.md
    - .planning/STATE.md
    - .planning/PROJECT.md
    - .planning/research/STACK.md
    - .planning/research/SUMMARY.md
    - .gitignore

key-decisions:
  - "ROADMAP·STATE·PROJECT 본문 문장은 핸들러 없이 Edit로 고치고 roadmap validate·state validate로 구조를 확인함 (계획 assumptions대로)"
  - "STATE Decisions의 U12 줄도 state add-decision 대신 Edit로 더해 front matter를 건드리지 않음"

patterns-established:
  - "연구 문서 결정 메모: 「> **U12 결정 (2026-11-14):** …」를 구간 제목 아래 빈 줄 사이에 둔다"

requirements-completed: [BASE-04]

coverage:
  - id: D1
    description: "ROADMAP.md가 Workspace 결정, DNS 두 번 방문, /location-terms/ 확정을 말하고 채택하지 않은 메일 전달 서비스 이름이 0줄이며 External Gates 표가 13행이다"
    requirement: "BASE-04"
    verification:
      - kind: other
        ref: "Task 1 verify 명령 1~6 (커밋 전·후 모두 exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "STATE.md Blockers/Decisions와 PROJECT.md Key Decisions가 U12 결정을 반영하고 진행 기록 줄과 .claude/CLAUDE.md 재생성 결과는 그대로다"
    requirement: "BASE-04"
    verification:
      - kind: other
        ref: "Task 2 verify 명령 1~5 (state validate valid true, generate-claude-md 사본 cmp 일치)"
        status: pass
    human_judgment: false
  - id: D3
    description: "research/STACK.md 네 구간과 research/SUMMARY.md 일곱 구간에 같은 메모가 있고 본문 삭제 줄이 0이며, 연구 캐시가 .gitignore로 무시된다"
    requirement: "BASE-04"
    verification:
      - kind: other
        ref: "Task 3 verify 명령 1~7 (SUMMARY 구간 검사 「7 0 7」, 두 파일 삭제 줄 0)"
        status: pass
    human_judgment: false

duration: 3 min
completed: 2026-11-15
---

# Phase 1 Plan 07: 계획 문서의 U12·DNS·위치약관 정합 Summary

**ROADMAP·STATE·PROJECT를 Google Workspace 사용자 별칭 도메인, 가비아 DNS 1차·2차 방문, `/location-terms/` 확정에 맞게 고치고, 연구 문서 두 개의 해당 구간 머리에 U12 결정 메모를 단 뒤 연구 캐시를 `.gitignore`로 뺐다.**

## Performance

- **Duration:** 약 3분
- **Started:** 2026-11-15T07:11:43Z
- **Completed:** 2026-11-15T07:14:16Z
- **Tasks:** 3
- **Files modified:** 6

## Accomplishments

- `.planning/ROADMAP.md`: Phase 5 External gates 세 줄(DNS 두 번 방문과 보존할 기존 레코드, 사용자 작업, U12는 결정됨)과 Research flag, Phase 8 Notes 첫 문장(위치약관 경로 확정), Phase 10의 DKIM 문장(2차 방문에서 이미 추가), External Gates 표의 가비아 DNS 행을 고쳤고, U12 행을 지워 「이미 결정된 항목」 줄로 옮겼다. 표는 13행이 됐다.
- `.planning/STATE.md`: Blockers/Concerns의 가비아 DNS 항목과 U11·U12 줄을 고치고 Decisions 목록 끝에 `[Phase 1]` U12 결정 한 줄을 더했다. front matter, Current Position, Session Continuity는 이 task에서 건드리지 않았다.
- `.planning/PROJECT.md`: Key Decisions의 지원 메일 행을 Workspace 결정으로 바꾸고, 위치약관 행에 경로 확정을 더하고, 맺음 줄을 갱신했다. 표는 17행 그대로이고 `.claude/CLAUDE.md` 재생성 결과가 저장소 파일과 같다.
- `.planning/research/STACK.md` 네 구간과 `.planning/research/SUMMARY.md` 일곱 구간 제목 아래에 같은 메모 줄을 넣었다. 두 파일 모두 단계 시작 커밋 대비 삭제 줄이 0이다 (추가 8줄, 16줄).
- `.gitignore`에 `# GSD 연구 캐시 (도구가 만드는 로컬 산출물)` 구획과 `.planning/research/.cache/`를 더했다. 캐시 안 파일은 하나도 추적되지 않는다.

## Task Commits

1. **Task 1: ROADMAP.md의 메일·DNS·위치약관 문장 수정** - `8aef43c` (docs)
2. **Task 2: STATE.md Blockers와 PROJECT.md Key Decisions 수정** - `96b1d44` (docs)
3. **Task 3: 연구 문서 메모와 .gitignore 연구 캐시 구획** - `1b10f31` (docs)

## Files Created/Modified

- `.planning/ROADMAP.md` - Phase 5·8·10 문장과 External Gates 표 (추가 8줄, 삭제 9줄)
- `.planning/STATE.md` - Blockers/Concerns 두 줄 수정, Decisions 한 줄 추가
- `.planning/PROJECT.md` - Key Decisions 두 행과 맺음 줄
- `.planning/research/STACK.md` - 네 구간 머리 메모
- `.planning/research/SUMMARY.md` - 일곱 구간 머리 메모
- `.gitignore` - 연구 캐시 구획

## Decisions Made

- 본문 문장 수정은 모두 범위를 정한 `Edit`로 했고 roadmap·state 진행 기록 핸들러는 task 중에 부르지 않았다. 구조 확인은 `roadmap validate`(warnings 없음)와 `state validate`(valid true, warnings 없음)로 했다.
- 연구 문서 메모는 파이썬 스크립트로 구간 제목 접두어를 찾아 넣었다. 제목 아래에 이미 빈 줄이 있으면 그 빈 줄을 쓰고 메모와 빈 줄만 더했다. SUMMARY.md의 `### Phase 4: 사실값 슬롯` 구간만 제목 아래 빈 줄이 없어 빈 줄·메모·빈 줄 세 줄을 더했다 (그래서 추가 줄이 14가 아니라 16).

## Deviations from Plan

None - plan executed exactly as written.

실행 경로 참고: 계획은 worktree 실행을 전제로 썼지만 이번에는 orchestrator 지시대로 main 작업 트리에서 순차 실행했다. 진행 기록(STATE의 front matter·Current Position·Session Continuity, ROADMAP의 Progress 표)은 task 커밋과 분리해 계획 끝의 완료 상태 커밋에서 핸들러로 갱신한다.

## Issues Encountered

None. 작업 트리에 있던 사용자 변경(`.planning/config.json`, `.planning/state.json`, `favicon/app-icon-*.png`)은 스테이징하지 않았다.

## User Setup Required

None - 이 계획은 외부 서비스 설정을 요구하지 않는다. DNS·Workspace 작업은 기존 절차서(`.planning/baseline/USER-TASKS.md`)를 따른다.

## Next Phase Readiness

- Phase 5 discuss가 읽는 ROADMAP·STATE가 Workspace 경로와 DNS 두 번 방문을 말하므로 U12 결정이 다음 단계에서 뒤집히지 않는다.
- 남은 계획: 01-08.

## Self-Check: PASSED

- 수정 파일 여섯 개 모두 존재, 커밋 `8aef43c`·`96b1d44`·`1b10f31` 모두 HEAD의 조상.
- Task 1 verify 6개, Task 2 verify 5개, Task 3 verify 7개가 커밋 뒤 다시 돌려도 모두 exit 0.
- SUMMARY 누출 검사(Task 3 verify 마지막 명령)를 이 파일을 쓴 뒤 커밋 전에 다시 돌린다.
