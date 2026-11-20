---
phase: 06-data-deletion-rewrite
plan: 02
subsystem: docs
tags: [data-inventory, decisions, roadmap, external-gates, disconnect, anonymous-account]
status: complete

# Dependency graph
requires:
  - phase: 06-data-deletion-rewrite
    provides: "06-01의 06-EVIDENCE.md(TOOLS_BASE=OK, BASE_SHA)와 스크래치 $W/lib.sh(vals, appcheck)"
provides:
  - "데이터 목록 정정 커밋 INV_FIX_SHA=ea0a0d7355d1: 구간 D·G 연결 해제 여섯 제공자(건너뛸 수 있음, Apple Android 미확인), 구간 C 기록 삭제 화면 없음, 구간 A·H 익명 계정은 확인한 경로 안에서 users/{uid} 쓰기를 찾지 못함, 근거 경로 아홉 줄 추가, 재확인 규칙 아래 정정 메모. 기준 앱 커밋 줄은 그대로"
  - "결정 목록·ROADMAP 커밋 DEC_SHA=ef3e0073b7b2: U6-가·U6-나·N3 결정됨, U2가 Phase 6 커밋도 막음(D-31), External Gates에 「Phase 6 앱 작업 묶음 (D-05 ①②③⑤⑥)」 행"
  - "06-EVIDENCE.md 구간 `## 06-02 사실 확인`(OK fact F1~F6, FACTS_BASE=OK), `## 06-02 목록 정정`, `## 06-02 결정 기록`"
affects: [06-04, 06-07, 06-13]

# Actuals (#2632)
actuals:
  tokens: 2484     # chars/4 over 더한 줄 (DATA-INVENTORY·DECISIONS·ROADMAP 커밋 두 개 + 06-EVIDENCE.md 06-02 구간, 9937자. SUMMARY 제외)
  tasks: 3
  commits: 2       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). EVIDENCE와 이 SUMMARY는 바로 뒤 docs 커밋, STATE·ROADMAP 진행표는 그 뒤 기록 커밋
plan_head_before: 20c3bf0363ea0445e67857a42a1a8d4eb2cbb2c7
plan_head_after: ef3e0073b7b2d37bad70c0adad37f0ba7014cea9

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "기준 시점 정정은 기준 앱 커밋 줄을 고치지 않고 「재확인 규칙」 아래 날짜 붙은 정정 메모로 남긴다. 재기준(D-06)은 앱 작업 뒤 06-04가 따로 한다"
    - "앱 사실은 기준 커밋에서 git -C \"$APP\" show/grep/ls-tree로만 다시 확인하고, 연구 인용 행 번호가 기준 커밋과 다르면 기준 커밋 행 번호로 적는다"

key-files:
  created:
    - .planning/phases/06-data-deletion-rewrite/06-02-SUMMARY.md
  modified:
    - .planning/baseline/DATA-INVENTORY.md
    - .planning/baseline/DECISIONS.md
    - .planning/ROADMAP.md
    - .planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md

key-decisions:
  - "데이터 목록 정정: 연결 해제는 여섯 제공자 모두 단계가 있고 건너뛸 수 있다. 카카오·Facebook은 서버 함수, 네이버·LINE은 앱에서 다시 로그인한 뒤 서버 함수, Google·Apple은 앱(기기)에서 해제하며 Apple Android 경로는 미확인으로 둔다"
  - "데이터 목록 정정: 기준 커밋의 앱에는 기록(runs)을 지우는 화면이 없다(규칙은 본인 삭제 허용). 익명 계정은 확인한 경로 안에서 users/{uid}를 쓰는 곳을 찾지 못했다고만 적는다"
  - "결정 목록·ROADMAP: U6-가(공개 코스 유지)·U6-나(앱에서 탈퇴 때 비공개 코스 삭제, 앱 반영 대기)·N3(prod에서 익명 자동 정리 켬) 결정됨. U2와 D-05 앱 작업 묶음이 Phase 6 커밋을 막는다"

patterns-established:
  - "06-02 정정 범위는 기준 시점 오류만이다. D-05 뒤에만 참이 되는 사실(비공개 코스 삭제, uid rate_limits 삭제, 기록 삭제 화면)은 06-04 재기준 몫이다"

requirements-completed: []  # 계획 frontmatter는 [DEL-03, DEL-07]. 이 계획은 근거 정정만 하고 성공 기준 2를 닫지 않는다(계획 assumptions). requirements.ready-ids도 두 ID를 blocked로 돌려준다(뒤 계획이 같은 ID를 가짐). 06-01 SUMMARY와 같은 처리

coverage:
  - id: D1
    description: "기준 시점 오류 여섯 사실(F1~F6)을 앱 기준 커밋 3afb2085에서 읽기 전용 명령으로 다시 확인해 06-EVIDENCE.md에 OK fact 여섯 줄과 FACTS_BASE=OK로 기록"
    requirement: "DEL-03"
    verification:
      - kind: command
        ref: "06-02-PLAN.md Task 1 <verify> (exit 0, 계획 끝에 다시 실행해도 exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "데이터 목록 구간 D·G·C·A·H·확인할 것의 정정과 근거 경로 추가를 DATA-INVENTORY.md 하나만 담은 커밋 ea0a0d7355d1로 남기고 기준 앱 커밋 줄은 그대로 둠"
    requirement: "DEL-07"
    verification:
      - kind: command
        ref: "06-02-PLAN.md Task 2 <verify> (exit 0) + acceptance 세 줄(옛 문장 0건)"
        status: pass
    human_judgment: false
  - id: D3
    description: "결정 목록 U6-가·U6-나·N3 결정됨, U2의 Phase 6 차단, ROADMAP External Gates U2 행·앱 작업 묶음 행·Phase 6 External gates 줄을 DECISIONS.md·ROADMAP.md 두 파일만 담은 커밋 ef3e0073b7b2로 남김"
    requirement: "DEL-03"
    verification:
      - kind: command
        ref: "06-02-PLAN.md Task 3 <verify> (exit 0) + acceptance 세 줄"
        status: pass
    human_judgment: false

duration: 약 25분 (계획·참조 문서 읽기 포함, 기록 시작 뒤 7분)
completed: 2026-11-20
---

# Phase 6 Plan 02: 데이터 목록 기준 시점 오류 정정과 결정·게이트 기록 Summary

**앱 기준 커밋 `3afb2085`에서 여섯 사실을 다시 확인한 뒤 데이터 목록의 연결 해제 대상(네 제공자 → 여섯 제공자, 건너뛸 수 있음, Apple Android 미확인), 기록 삭제(규칙은 허용하나 앱 화면 없음), 익명 계정(확인한 경로 안에서 `users/{uid}` 쓰기를 찾지 못함)을 고쳤고, U6-가·U6-나·N3 결정과 U2·D-05 앱 작업 묶음의 Phase 6 커밋 차단을 결정 목록과 ROADMAP External Gates에 적었다.**

## Performance

- **Duration:** 약 25분 (참조 문서 읽기 포함. 시작 기록 뒤 7분)
- **Started:** 2026-11-20 (Wave 2 시작 커밋 20c3bf0 뒤)
- **Completed:** 2026-11-20T02:24Z
- **Tasks:** 3 (Task 1 tracer, Task 2·3 auto)
- **Files modified:** 4 (`DATA-INVENTORY.md`, `DECISIONS.md`, `ROADMAP.md`, `06-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- F1~F6을 `git -C "$APP"`의 `show`·`grep`·`ls-tree`로 기준 커밋에서 다시 확인했다. 사실은 모두 연구와 같고 행 번호 두 곳만 한 줄씩 다르다(`kDisconnectSteps` 35-48행, `users/{userId}` create 허용 377-381행).
- 데이터 목록 구간 D 「소셜 연결 끊기 (여섯 제공자)」: 제공자별 해제 방식과 처리 위치, Apple Android 경로 미확인, 근거 열세 개. 구간 G 「제공자 쪽 앱 연결 (여섯 제공자)」: 건너뛰면 제공자 설정에서 직접 해제(`app_ko.arb:372`).
- 구간 C 기록 두 행: 「규칙은 본인 삭제를 허용함 … 기준 커밋의 앱에는 기록을 지우는 화면이 없음」, 보유 기간 「탈퇴까지 (앱 화면으로 본인이 지울 수 없음, 기준 커밋)」.
- 구간 A 익명 행 「익명 계정 (uid)」과 그 아래 메모, 구간 H 익명 메모, 「확인할 것」 익명 탈퇴 경로 행(확인함)을 고쳤다. 「쓸 수 있다」(규칙)와 「앱이 쓴다」를 나눠 적었다.
- 결정 목록: U6-가·U6-나 결정됨(D-01, D-02), N3 결정됨(D-26), U2의 막는 단계에 Phase 6 커밋(D-31), 마감 단계 「Phase 6 커밋 전」. ROADMAP: U2 행, 새 행 「Phase 6 앱 작업 묶음 (D-05 ①②③⑤⑥ …)」, Phase 6 External gates 줄.
- 사이트 파일을 고친 커밋은 없다(`git log 89f659a5fdca..ef3e0073b7b2 -- . ':(exclude).planning'` 빈 출력).

## Task Commits

1. **Task 1: 여섯 사실 확인과 구간 D·G·근거 경로 첫 정정 (tracer)** — 커밋 없음. 계획대로 Task 2 커밋에 함께 들어감. `OK site-clean 06-02-t1 20c3bf0363ea`
2. **Task 2: 구간 C·A·H·확인할 것 정정, 데이터 목록 커밋** — `ea0a0d7355d1` (docs)
3. **Task 3: 결정 목록·ROADMAP External Gates 커밋** — `ef3e0073b7b2` (docs)

**Plan metadata:** 이 SUMMARY와 `06-EVIDENCE.md`는 바로 뒤 docs 커밋 하나, STATE·ROADMAP 진행표는 그 뒤 기록 커밋으로 들어간다 (06-01과 같은 순서).

## Files Created/Modified

- `.planning/baseline/DATA-INVENTORY.md` — 기준 시점 오류 정정 (기준 앱 커밋 줄 그대로)
- `.planning/baseline/DECISIONS.md` — U6-가·U6-나·N3 결정, U2 막는 단계
- `.planning/ROADMAP.md` — External Gates U2 행·앱 작업 묶음 행, Phase 6 External gates 줄
- `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` — `## 06-02 사실 확인`, `## 06-02 목록 정정`, `## 06-02 결정 기록`
- `.planning/phases/06-data-deletion-rewrite/06-02-SUMMARY.md` — 이 문서

## Decisions Made

- 행 번호는 기준 커밋 실제 값으로 적었다: `disconnect_steps.dart:35-48`(계획·연구 36-49), `firestore.rules:377-381`(계획·연구 376-381, 376행은 빈 줄). 데이터 목록의 행 번호가 기준 커밋 기준이라는 「재확인 규칙」을 따랐다. 뒤 계획의 verify는 이 두 문자열을 찾지 않는다(grep 확인).
- 재확인 규칙 아래 정정 메모는 계획이 준 한다체 문장 그대로 넣었다(목록 본문은 합니다체).
- 값 누출 점검: `vals filled=0 emitted=0 excluded=0`, 새 값이 없어 `leak=skip(no new values)`.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] 네이버·LINE 처리 위치**
- **Found during:** Task 1
- **Issue:** 계획 2번은 「서버 함수 행만 Cloud Functions 리전, 나머지는 앱(기기)에서 제공자 API 호출」이라 했지만, 단계 파일을 읽으니 네이버·LINE도 다시 로그인한 뒤 서버 함수(`disconnectNaverProvider`·`disconnectLineProvider`)가 해제한다.
- **Fix:** 처리 위치를 「카카오·Facebook·네이버·LINE은 Cloud Functions `asia-northeast3`, Google·Apple은 앱(기기)」로 적었다. Apple은 Firebase Auth 폐기 API를 거친다고만 적고 그 뒤 처리 위치는 미확인으로 두었다.
- **Files modified:** `.planning/baseline/DATA-INVENTORY.md`
- **Committed in:** `ea0a0d7355d1`

**2. [Rule 1 - Bug] 기준 커밋 행 번호 두 곳**
- **Found during:** Task 1 (F1, F6)
- **Issue:** 연구·계획의 인용 행 번호가 기준 커밋과 한 줄씩 다르다.
- **Fix:** 데이터 목록에는 기준 커밋 행 번호(35-48, 377-381)를 적고, EVIDENCE 사실 확인 메모에 차이를 남겼다. `OK fact` 줄은 계획 문자열 그대로다.
- **Committed in:** `ea0a0d7355d1`

**3. [Rule 1 - Bug] 같은 사실에 묶인 칸 정합**
- **Found during:** Task 1·2
- **Issue:** 계획이 짚은 칸만 고치면 같은 행·같은 구간의 다른 칸이 옛 사실을 말한다.
- **Fix:** 구간 D 수탁자 칸(여섯 제공자)과 표 아래 메모(「Google이 아니라」 → Firebase에 저장하지 않고 각 제공자 API로, Google 행도 앱 승인 취소), 구간 A 익명 행의 국외 이전 칸(`termsAccepted` 부분 삭제), 구간 C `region` 행 보유 기간 괄호(기록은 탈퇴까지), 구간 G 연결 행에 「Apple Android 경로의 해제 여부는 미확인 (구간 D)」.
- **Committed in:** `ea0a0d7355d1`

**4. [Rule 2 - Missing Critical] 근거 경로 목록**
- **Found during:** Task 1·2
- **Issue:** 목록 머리 규칙은 근거로 쓴 경로를 모두 「근거로 삼은 경로」에 적으라고 한다. 새로 인용한 `withdrawal_disconnect_notifier.dart`(F2)와 `run_repository.dart`(F4)가 목록에 없었다.
- **Fix:** 연결 해제 일곱 파일과 함께 두 경로를 더했다 (모두 아홉 줄).
- **Committed in:** `ea0a0d7355d1`

---

**Total deviations:** 4 auto-fixed (Rule 1 셋, Rule 2 하나)
**Impact on plan:** 모두 같은 사실을 목록 안에서 어긋나지 않게 적기 위한 것이다. 기준 앱 커밋 줄, 커밋 분리(INV_FIX_SHA는 데이터 목록 하나, DEC_SHA는 결정 목록·ROADMAP 둘), D-05 뒤에만 참이 되는 사실을 적지 않는 금지는 지켰다.

## Issues Encountered

- 뱃지 행(구간 C)은 「탈퇴 또는 본인 삭제까지 / 규칙상 본인 삭제 허용 (앱 화면의 삭제 메뉴는 미확인)」으로 그대로 두었다. 연구는 뱃지 삭제 화면도 없다고 보지만 이 계획의 정정 범위(F1~F6)에 없어 06-04 재기준에서 함께 본다.

## User Setup Required

None - 외부 서비스 설정 없음.

## Next Phase Readiness

- 06-03부터 이 정정 목록을 기준 시점 사실로 쓴다. 06-04 재기준의 차이는 D-05 앱 작업의 효과만 보여 준다.
- 사이트 커밋은 여전히 막혀 있다: D-05 앱 작업 묶음 ①②③⑤⑥, U2 결론(D-31), D-06 재기준.

## Self-Check: PASSED

- FOUND: `.planning/baseline/DATA-INVENTORY.md`, `.planning/baseline/DECISIONS.md`, `.planning/ROADMAP.md`, `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md`
- FOUND: `ea0a0d7355d1`, `ef3e0073b7b2` (모두 HEAD의 조상)
- Task 1~3 `<verify>` 계획 끝 재실행 모두 exit 0. acceptance 아홉 줄 통과. 사이트 파일 커밋 0건. EVIDENCE에 `$HOME` 0건, LPX 모양 0건(grep 종료 코드 1). 기준 앱 커밋 줄 1건 그대로.

---
*Phase: 06-data-deletion-rewrite*
*Completed: 2026-11-20*
