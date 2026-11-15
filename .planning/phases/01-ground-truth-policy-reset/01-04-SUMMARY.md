---
phase: 01-ground-truth-policy-reset
plan: 04
subsystem: planning-baseline
tags: [decisions, external-gates, legal-draft, base-04]

requires:
  - phase: 01-ground-truth-policy-reset
    provides: "01-01의 기준 문서 폴더와 이름 표(NAMES.md) 형식, 01-02의 사용자 작업 절차서(USER-TASKS.md) 작업 번호, 01-03의 데이터 목록 구간 A~D"
provides:
  - "결정 목록 .planning/baseline/DECISIONS.md: 「한눈에 보기」 열두 행(U2, U3, U5, U6-가, U6-나, U7, U8, U9, U11, U12, U13, P1)"
  - "U12 결정 기록(Google Workspace 사용자 별칭 도메인, support@runningpencil.com, 지원 주소로 답장)"
  - "열린 항목 열한 개의 일곱 칸 풀이(질문, 근거, 권장안, 기본 동작, 결정 주체, 막는 단계, 마감 단계)"
  - "「조사에서 새로 나온 항목」 N1~N7 (영향 받는 단계, 성격, 다루는 곳)"
affects: [01-05, 01-07, phase-5-business-support, phase-6-deletion, phase-7-privacy, phase-8-terms, phase-9-english, phase-10-submission]

actuals:
  tokens: 5036
  tasks: 2
  commits: 2
plan_head_before: 592567bab731400957dee9c2d6cbc7fbc78b4f68
plan_head_after: 5f78770c3ed35675b82aa70b872271a9c0a5168d

tech-stack:
  added: []
  patterns:
    - "요약 표 + 항목별 풀이: 「한눈에 보기」 표 아래에 `### 번호 — 이름` 소제목마다 굵은 머리 일곱 개"
    - "법률 판단 항목의 기본 동작 줄 끝에 「초안·법률 확인 필요」"

key-files:
  created:
    - .planning/baseline/DECISIONS.md
  modified: []

key-decisions:
  - "P1(prod 리전)은 ROADMAP External Gates 표에 행이 없어 막는 단계·마감 단계를 01-CONTEXT D-08에서 가져왔고, 문서 안에 그 사실을 적었다"
  - "N 표의 「다루는 곳」은 데이터 목록 구간 글자로 적었다. 구간 E·F·H는 01-05가 더하는 구간이라 문서에 그렇게 밝혔다"
  - "N7은 데이터 항목이 아니라 데이터 목록에 없다고 적고, Phase 5 지원 페이지(SUP-03)와 Phase 8 약관(TERM-01)에서 다룬다고 적었다"
  - "U12 기록에는 업무 메일 도메인 이름과 채택하지 않은 메일 전달 서비스 이름을 적지 않았다"

patterns-established:
  - "결정 상태 표기: 「열림」, 「결정됨 (날짜)」"
  - "U6처럼 사용자가 일부만 정할 수 있는 항목은 처음부터 하위 항목(U6-가, U6-나)으로 나눈다"

requirements-completed: [BASE-04]

coverage:
  - id: D1
    description: "「한눈에 보기」 표에 열두 항목이 결정 주체, 막는 단계, 마감 단계, 상태와 함께 있고 「결정됨」은 U12 하나다"
    requirement: BASE-04
    verification:
      - kind: other
        ref: "01-04-PLAN.md Task 1 verify 명령 1·2 (행 수 12, 막는 단계·마감 단계 Phase 번호, 결정됨 1행)"
        status: pass
    human_judgment: false
  - id: D2
    description: "열린 항목 열한 개마다 굵은 머리 일곱 개가 있고, U2·U3·U7에 「초안·법률 확인 필요」, U11에 기본값 없음과 render-if-present가 있다"
    requirement: BASE-04
    verification:
      - kind: other
        ref: "01-04-PLAN.md Task 1 verify 명령 3·4, Task 2 verify 명령 1·3"
        status: pass
    human_judgment: false
  - id: D3
    description: "문서 끝 구간이 「조사에서 새로 나온 항목」이고 N1~N7마다 영향 받는 단계가 있으며, 근거 경로 17개가 앱 기준 커밋 3afb2085에 있다"
    requirement: BASE-04
    verification:
      - kind: other
        ref: "01-04-PLAN.md Task 2 verify 명령 2·4"
        status: pass
    human_judgment: false
  - id: D4
    description: "공개 저장소 누출 검사와 라이브 사이트 불변 검사"
    verification:
      - kind: other
        ref: "01-04-PLAN.md Task 1 verify 명령 5, Task 2 verify 명령 5·6"
        status: pass
    human_judgment: false
  - id: D5
    description: "막는 단계가 ROADMAP 게이트와 어긋나지 않는지, U2·U3·U7의 기본 동작 문구가 결론이 아닌 임시 방침으로 읽히는지"
    requirement: BASE-04
    verification: []
    human_judgment: true
    rationale: "Task 2 human-check. 단계 의존 해석과 법률 판단 항목에서 무엇이 보수적인 쪽인지는 계획자의 해석이라 사용자가 문구를 읽고 받아들여야 한다"

duration: 8min
completed: 2026-11-15
status: complete
---

# Phase 1 Plan 04: 결정 목록 Summary

**사이트가 스스로 정할 수 없는 열한 개의 열린 결정(U2~U13, P1)을 일곱 칸으로 풀고 U12(Google Workspace 사용자 별칭 도메인, support 주소로 답장)를 「결정됨」으로 기록한 결정 목록과, 조사에서 새로 나온 사실 N1~N7 구간**

## Performance

- **Duration:** 약 8분
- **Started:** 2026-11-15T06:16:55Z
- **Completed:** 2026-11-15T06:25Z
- **Tasks:** 2
- **Files modified:** 1 (새 파일)

## Accomplishments

- `.planning/baseline/DECISIONS.md` 작성: 머리(임시 방침·법률 초안·ROADMAP 정본·PUBLIC 주의), 「한눈에 보기」 열두 행, 「결정된 항목」(U12와 참고 줄 U1·U4·U10·U14), 「항목별 풀이」 열한 소제목, 「조사에서 새로 나온 항목」 N1~N7
- U6을 공개 코스(U6-가)와 비공개 코스(U6-나)로 나누고, 코드대로면 탈퇴 뒤 공개·비공개 코스가 모두 남는다고 적음
- 근거 경로 17개를 앱 저장소 기준 커밋에서 행 내용까지 확인

## Task Commits

1. **Task 1: 머리, 「한눈에 보기」, 「결정된 항목」과 U2~U7 풀이** - `dcddd4c` (docs)
2. **Task 2: U8~P1 풀이와 「조사에서 새로 나온 항목」** - `5f78770` (docs)

## Files Created/Modified

- `.planning/baseline/DECISIONS.md` - 결정 목록 (BASE-04, D-12, D-14)

## ROADMAP External Gates 대조 결과

「한눈에 보기」의 막는 단계 칸을 `.planning/ROADMAP.md` External Gates 표와 한 행씩 대조했습니다.

| 항목 | 결정 목록 | ROADMAP External Gates | 결과 |
|---|---|---|---|
| U2 | Phase 8 위치약관 범위, ACPT-02 | Phase 8 위치약관 범위, ACPT-02 | 같음 |
| U3 | Phase 7 보호책임자 | Phase 7 보호책임자 | 같음 |
| U5 | Phase 7 | Phase 7 | 같음 |
| U6-가 | Phase 6, Phase 8 | U6 행: Phase 6, 8 | 같음 (U6을 둘로 나눔, 표기만 「Phase 8」로 풀어 씀) |
| U6-나 | Phase 6, Phase 8 | U6 행: Phase 6, 8 | 같음 (위와 같음) |
| U7 | Phase 7, Phase 8 | Phase 7, 8 | 같음 |
| U8 | Phase 8 | Phase 8 | 같음 |
| U9 | Phase 10 | Phase 10 | 같음 |
| U11 | Phase 5, Phase 8, Phase 9 | Phase 5, 8, 9 | 같음 |
| U12 | Phase 5 | Phase 5 | 같음 |
| U13 | Phase 10 | Phase 10 | 같음 |
| P1 | Phase 7 | 행 없음 | ROADMAP에 행이 없음. 01-CONTEXT D-08(Phase 7 처리방침 커밋 전)을 따름 |

어긋나는 행은 없습니다. P1만 ROADMAP 표에 없고, 그 사실을 결정 목록 안에도 적었습니다.

## Decisions Made

- P1의 막는 단계·마감 단계는 D-08을 근거로 적었습니다 (ROADMAP 표에 행 없음).
- N 표의 「다루는 곳」은 데이터 목록 구간 글자로 적었습니다. N1·N5는 구간 E, N6은 구간 F와 P1, N2는 구간 H와 A, N3·N4는 구간 A입니다. 구간 E·F·H는 01-05가 더할 예정이라 문서에 그렇게 밝혔습니다.
- N7은 데이터 항목이 아니라 데이터 목록에 없다고 적고, 지원 페이지(SUP-03)와 약관(TERM-01)에서 다룬다고 적었습니다.
- U12 기록에는 업무 메일 도메인 이름과 채택하지 않은 메일 전달 서비스 이름을 적지 않았습니다 (계획의 수락 기준).

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] 「한눈에 보기」 P1 행의 질문 칸에 「prod 리전」 낱말 추가**
- **Found during:** Task 1 (verify 명령 1)
- **Issue:** Task 1 verify가 문서에서 `prod 리전`을 찾는데, Task 1 범위의 P1 질문 칸에는 그 낱말이 없어 검사가 실패했습니다 (P1 소제목은 Task 2에서 생김)
- **Fix:** P1 질문 칸을 「prod 리전 (신규): prod(그리고 stg) Firebase 프로젝트를 dev와 같은 리전으로 만드는가?」로 고침
- **Files modified:** `.planning/baseline/DECISIONS.md`
- **Verification:** Task 1 verify 다섯 명령 exit 0
- **Committed in:** `dcddd4c` (Task 1 커밋)

---

**Total deviations:** 1 auto-fixed (1 bug)
**Impact on plan:** 문구 한 칸 수정. 범위 변화 없음.

## Issues Encountered

None

## User Setup Required

None - 이 계획은 외부 서비스 설정이 없습니다. 결정이 필요한 항목은 결정 목록 자체에 있습니다.

## Next Phase Readiness

- 01-05는 데이터 목록 구간 E·F·H를 더할 때 결정 목록의 N1·N2·N5·N6 번호를 가리키면 됩니다.
- 사람 확인 남음 (end-of-phase): 「한눈에 보기」의 막는 단계와 ROADMAP 게이트의 대조, U2·U3·U7의 기본 동작 문구를 사용자가 읽고 받아들일 수 있는지.

---
*Phase: 01-ground-truth-policy-reset*
*Completed: 2026-11-15*

## Self-Check: PASSED

- FOUND: `.planning/baseline/DECISIONS.md`
- FOUND: `dcddd4c`, `5f78770` (HEAD의 조상)
- Task 1 verify 5개, Task 2 verify 6개 exit 0. SUMMARY 누출 검사는 커밋 직전에 다시 돌림
