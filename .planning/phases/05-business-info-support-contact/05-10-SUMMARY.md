---
phase: 05-business-info-support-contact
plan: 10
subsystem: infra
tags: [email-gate, sup-02, receive-test, preflight, cherry-pick-dry-run, evidence]
status: complete

# Dependency graph
requires:
  - phase: 05-business-info-support-contact
    provides: "05-06 PUSH1_SHA(첫 사이트 푸시), 05-08 보류 묶음 HOLD_BASE·H1~H3와 HOLD_ONLY7·HOLD_UI, 05-09 DNS_AFTER=OK, 사용자 작업 4 수신 시험 기록 표"
provides:
  - "05-EVIDENCE.md `## 05-10 게이트 사전 점검`: 원격·로컬 main·보류 브랜치·시험 cherry-pick·빌드 비교 여섯 줄, site-clean 기록, GATE_PREFLIGHT=OK"
  - "05-EVIDENCE.md `## 05-10 이메일 게이트`: 4/4 근거 줄, 1차 시험 이력 줄, OK origin at gate = push1, OK addr push1=0, site-clean 기록, GATE_HEAD, RECEIVE_TEST=4/4, GATE_DATE, GATE_OPEN=OK"
  - "게이트 기록 커밋(이 SUMMARY와 EVIDENCE를 담은 문서 커밋). 05-11의 이메일 값 커밋은 이 커밋의 자손에서만 만든다"
affects: [05-11, 05-12, 05-13, 05-14, 05-15]

# Actuals (#2632)
actuals:
  tokens: 582      # chars/4: 이 계획이 05-EVIDENCE.md에 더한 줄 2329자. SUMMARY 제외
  tasks: 3
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). 이 SUMMARY와 EVIDENCE를 담은 게이트 기록 커밋, STATE·ROADMAP 기록 커밋은 뒤
plan_head_before: 6c88ed81b8ca69e1e49c36dbf7a2aa19736ef0ae
plan_head_after: e378e6854388eb0b91df3f8318d4a4a9ad0aa737

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "게이트 판정은 움직이는 origin/main 끝과 작업 트리가 아니라 기록한 PUSH1_SHA·GATE_HEAD에 고정한다. 네트워크 확인(git fetch)은 action에서 하고 결과 줄을 남긴다"
    - "수신 시험 표는 대화에서만 보고, 기록에는 4/4 같은 건수와 서비스 이름만 남긴다. 보낸 사람 주소·본문·시각은 옮기지 않는다"

key-files:
  created:
    - .planning/phases/05-business-info-support-contact/05-10-SUMMARY.md
  modified:
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md

key-decisions:
  - "이메일 게이트를 2026-11-19에 열었다(GATE_OPEN=OK). 근거는 사용자가 넘긴 작업 4 재시험 표 4/4(Gmail·네이버·iCloud·Outlook 모두 받은편지함)이고, 게이트 시점 원격 main은 PUSH1_SHA 그대로, PUSH1 사이트 이력과 GATE_HEAD 사이트 파일에 지원 주소 0건"
  - "1차 수신 시험은 2/4(iCloud·Outlook 스팸함, 두 통 모두 보낸 쪽 SPF·DKIM·DMARC PASS)였다. 사용자가 운영자 Gmail에 지원 주소 수신 메일을 스팸함으로 보내지 않는 필터를 만든 뒤 재시험해 4/4가 됐다. 저장소 밖 운영 설정이고, 지원 주소로 오는 실제 스팸도 받은편지함에 들어오는 대가가 있다"

patterns-established:
  - "체크포인트 뒤 이어 실행한 task도 그 자리에서 `OK site-clean <계획>-t<n> <12자리>` 줄을 찍어 적는다(05-09와 같음)"

requirements-completed: []  # 계획 requirements는 [SUP-02]. requirements.ready-ids가 SUP-02를 blocked로 냄(05-11 등 뒤 계획도 선언). 이 단계 관례대로 비워 둠

coverage:
  - id: D1
    description: "사람을 기다리기 전 읽기 전용 사전 점검: 원격 main = PUSH1, 로컬 main 사이트 출력 = M4 빌드, 보류 브랜치가 H1·H2·H3 그대로·조상 아님·원격/upstream 없음, H3는 7번 하나로 실패, 임시 worktree 시험 cherry-pick이 충돌 없이 H3 빌드와 같은 출력. 시험 worktree는 지워져 없음"
    requirement: "SUP-02"
    verification:
      - kind: other
        ref: "05-10-PLAN.md Task 1 <verify> (e378e68 커밋 뒤, 그리고 Task 3 뒤 다시 실행 exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "Gmail·네이버·iCloud·Outlook 네 곳에서 지원 주소로 보낸 시험 메일이 모두 운영자 받은편지함에 도착(재시험 4/4). 기록은 4/4와 1차 시험 이력만, 주소·시각 없음"
    requirement: "SUP-02"
    verification:
      - kind: other
        ref: "05-10-PLAN.md Task 3 <verify> (bash·zsh 모두 exit 0)"
        status: pass
    human_judgment: true
    rationale: "외부 메일 도착은 사용자 계정 안에서만 보이므로 사용자가 넘긴 기록 표(오케스트레이터가 4/4 받은편지함을 확인)에 기댄다. verify는 기록 꼴과 주소·시각 없음만 본다. 재시험은 운영자 Gmail 필터를 만든 뒤라 받는 쪽 스팸 분류를 우회한 결과다"
  - id: D3
    description: "게이트 시점 원격 main이 PUSH1_SHA 그대로이고, PUSH1 사이트 이력(git log -S)과 GATE_HEAD 사이트 파일(git grep)에 지원 주소 0건. 게이트 기록은 이 계획의 문서 커밋으로 main에 들어가고, 이메일 값 커밋(05-11)보다 앞선다"
    requirement: "SUP-02"
    verification:
      - kind: other
        ref: "05-10-PLAN.md Task 3 <verify> (exit 0). 이메일 커밋이 이 커밋의 자손인지는 05-11 verify가 본다"
        status: pass
    human_judgment: false

# Metrics
duration: 1h 43m
completed: 2026-11-19
---

# Phase 5 Plan 10: 이메일 게이트 Summary

**읽기 전용 사전 점검(원격·main·보류 브랜치·시험 cherry-pick이 H3 빌드와 같음)을 통과한 뒤, 작업 4 재시험 4/4(Gmail·네이버·iCloud·Outlook 모두 받은편지함)와 게이트 시점 원격·주소 0건을 기록해 이메일 게이트를 열었다(GATE_OPEN=OK). 1차 2/4 뒤 운영자 Gmail 필터를 만든 이력도 함께 적음**

## Performance

- **Duration:** 1h 43m (Task 1 커밋부터 이 SUMMARY까지. Task 2 사용자 수신 시험·재시험 대기 포함. 시작 시각은 따로 재지 않아 Task 1 커밋 시점에서 셈)
- **Started:** 2026-11-19 (Task 1 커밋 `e378e6854388`)
- **Completed:** 2026-11-19
- **Tasks:** 3 (Task 1 tracer, Task 2 checkpoint:human-action blocking-human, Task 3 auto)
- **Files modified:** 1 (`05-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- `## 05-10 게이트 사전 점검`: 사람을 기다리기 전에 게이트 뒤 작업(cherry-pick과 이메일 커밋)이 바로 진행될 수 있음을 확인했습니다. 여섯 판정 줄이 모두 OK이고 `GATE_PREFLIGHT=OK`입니다. 시험 cherry-pick은 임시 worktree에서만 했고 지웠습니다.
- `## 05-10 이메일 게이트`: 사용자가 넘긴 작업 4 재시험 표를 오케스트레이터가 확인한 사실(네 행 모두 도착 시각 있음, 스팸함 여부 「X」)로 `RECEIVE_TEST=4/4`를 적었습니다. 게이트 시점에 `git fetch` 뒤 원격 main이 `PUSH1_SHA` 그대로(`OK origin at gate = push1`)이고, `PUSH1_SHA`의 사이트 파일 이력에 지원 주소가 0건(`OK addr push1=0`), `GATE_HEAD=e378e6854388`의 사이트 파일에도 0건입니다. `GATE_DATE=2026-11-19`, `GATE_OPEN=OK`.
- 1차 시험(2/4) 이력을 한 줄로 숨기지 않고 적었습니다. 주소·시각·본문은 기록 어디에도 없습니다.
- 이 SUMMARY와 `05-EVIDENCE.md`를 담은 문서 커밋이 게이트 기록 커밋입니다. 05-11은 이 커밋의 자손에서만 `support_email`을 채웁니다.

## Task Commits

1. **Task 1: 게이트 사전 점검 (tracer)** - `e378e6854388` (docs)
2. **Task 2: 작업 4 외부 4곳 수신 시험 기록 표 받기 (checkpoint:human-action, blocking-human)** - 커밋 없음. 1차 2/4, 운영자 Gmail 필터 추가 뒤 재시험 4/4
3. **Task 3: 4/4 확인과 게이트 열기** - 이 SUMMARY와 함께 한 게이트 기록 커밋(계획 `<output>`대로 SUMMARY와 EVIDENCE를 한 문서 커밋에 담음)

**Plan metadata:** 게이트 기록 커밋 뒤 STATE·ROADMAP 기록 커밋

## Files Created/Modified

- `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` - 구간 `## 05-10 게이트 사전 점검`(Task 1), `## 05-10 이메일 게이트`(Task 3)
- `.planning/phases/05-business-info-support-contact/05-10-SUMMARY.md` - 이 문서

## Verification

- Task 1 `<verify>`: exit 0 (Task 3 뒤 다시 실행해도 exit 0)
- Task 3 `<verify>`: 원문 그대로 bash와 zsh에서 exit 0
- 계획 `<verification>`: Task 1·3 verify가 exit 0이고, 이 계획이 고친 저장소 파일은 `05-EVIDENCE.md` 하나입니다(SUMMARY 제외). 사이트 파일과 보류 브랜치는 그대로이고(Task 1 verify가 보류 브랜치 세 커밋·끝 H3·조상 아님을, 두 task의 `OK site-clean` 줄이 사이트 파일·인덱스 그대로를 보임) 시험 worktree `wt-pickdry`는 없습니다.
- 커밋 전 점검: 작업 트리 `scripts/check-site.sh` 통과. 값 누출 점검 `vals filled=4 emitted=3 excluded=1`, (a) `.planning` 0건, (b) 커밋 메시지 0건, (c) 작업 트리 diff 0건. EVIDENCE 전체에서 지원 주소 0건, 로컬 홈 경로 0건, 게이트 구간의 메일 주소·시각 꼴 0건.
- 작업 위치: 메인 체크아웃 `main`. 이 이어 실행은 오케스트레이터가 준 `<project_root_pin>` 가드를 원문 그대로 첫 Edit 전과 커밋 전에 돌렸습니다(PIN OK).

## Decisions Made

- 재시험 표(4/4)를 게이트 근거로 썼습니다. 1차 2/4는 실패 이력으로 같은 구간에 적었고, 계획 Task 3 1번의 실패 갈래(`RECEIVE_TEST=FAIL`)는 재시험 뒤 표가 4/4라 적지 않았습니다.
- 사용자 표의 스팸함 여부 칸은 「아니요」 대신 「X」로 적혀 있었습니다. 오케스트레이터가 「X」를 스팸함 아님(받은편지함 도착)으로 확인해 넘겼고, 그대로 받았습니다.

## Deviations from Plan

**1. [운영 설정] 1차 수신 시험 2/4 뒤 운영자 Gmail 필터를 만들고 재시험**
- **Found during:** Task 2 (사용자 작업 4)
- **Issue:** 1차 시험에서 iCloud·Outlook에서 보낸 두 통이 운영자 받은편지함이 아니라 스팸함에 들어갔습니다(2/4). 사용자가 Gmail 「원본 보기」로 확인한 두 통의 SPF·DKIM·DMARC는 모두 PASS(보낸 서비스 쪽 도메인)라, 라우팅·인증 문제가 아니라 Gmail 받는 쪽 스팸 분류였습니다.
- **Fix:** 사용자가 운영자 Gmail 계정에 필터(조건: 받는 사람이 지원 주소, 동작: 「스팸함으로 보내지 않음」)를 만들고 네 서비스에서 다시 보내 4/4를 얻었습니다. 계획이 정한 MX·별칭 점검 갈래가 아니라 받는 쪽 분류를 고친 것입니다.
- **Consequence:** 지원 주소로 오는 실제 스팸도 받은편지함에 들어옵니다. 저장소 밖 운영 설정이고 사이트 파일 변경은 없습니다. 이력은 EVIDENCE 게이트 구간에 적었습니다.
- **Files modified:** `05-EVIDENCE.md`(기록만)

**2. [커밋 형식] 커밋 메시지 끝 attribution 줄 두 개**
- **Issue:** 05-01 「모든 task에 적용하는 규칙」은 메시지 마지막 줄을 `Co-Authored-By` 한 줄로 정했고, 이 실행의 시스템 지시는 `Co-Authored-By`와 `Claude-Session` 두 줄을 정했습니다.
- **Fix:** 05-09와 같이 두 줄을 붙였습니다. 05-11~05-15 verify 가운데 커밋 메시지 마지막 줄을 검사하는 것은 없습니다.
- **Committed in:** `e378e6854388`, 게이트 기록 커밋, STATE·ROADMAP 기록 커밋

**3. [스크래치] 사전 점검 빌드 `$W/pre`·`$W/pickdry`를 Task 3 이어 실행에서 지움**
- **Issue:** 계획 「Artifacts」는 두 빌드를 지운다고 적었지만 Task 1 action은 worktree만 지우라고 적어, Task 1 실행이 두 빌드를 남겼습니다.
- **Fix:** 뒤 계획(05-11~05-15)과 05-VALIDATION이 두 이름을 읽지 않음을 grep으로 확인한 뒤 두 폴더만 지웠습니다. `$W`의 다른 산출물(`m4`, `h3` 등 뒤 verify가 읽는 것)은 건드리지 않았습니다.

**4. [기록] Task 3 구간에 깨끗함 기록 줄 추가**
- 계획 Task 3 action에는 없지만 05-09에서 굳힌 관례대로 `OK site-clean 05-10-t3 e378e6854388`을 게이트 구간에 적었습니다. verify 판정에는 영향이 없습니다(주소·시각 꼴 아님).

**5. [절차] Task 1 실행이 pin 가드와 execution_context를 건너뜀**
- Task 1을 실행한 앞 executor는 `<project_root_pin>` 가드를 원문 그대로 돌리지 않았고 execution_context 파일을 읽지 않았습니다(오케스트레이터 전달). Task 1 결과는 오케스트레이터가 verify를 다시 돌려 exit 0을 확인했고, 이 이어 실행은 가드와 execution_context를 모두 지켰습니다.

---

**Total deviations:** 5 (운영 설정 1, 커밋 형식 1, 스크래치 정리 1, 기록 1, 절차 1)
**Impact on plan:** 표식과 판정은 계획 그대로입니다. 필터는 게이트 근거(받은편지함 도착)에 영향을 주는 운영 설정이라 기록에 이력을 남겼습니다.

## Issues Encountered

- 1차 수신 시험 2/4(위 편차 1). 재시험으로 해결했습니다.

## User Setup Required

None - 작업 4는 끝났습니다. 남은 사용자 작업(작업 5 보내기 설정, 작업 6 DKIM)은 05-14와 Phase 10에서 받습니다.

## Next Phase Readiness

- 05-11(게이트 커밋)이 이 게이트 기록 커밋 위에서 보류 묶음을 cherry-pick하고 `support_email`을 채울 수 있습니다. 05-11 첫 task가 스크래치(`m4`, `h3` 등)를 다시 확인합니다.
- 운영자 Gmail 필터 때문에 지원 주소로 들어오는 스팸이 받은편지함에 쌓일 수 있습니다. 공개 뒤 스팸이 많아지면 필터 조건을 좁히는 것을 사용자가 정합니다(사이트 작업 아님).
- 아무것도 원격에 푸시하지 않았습니다. 게이트 기록 커밋은 05-12가 함께 푸시합니다.

## Self-Check: PASSED

- FOUND: `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md`
- FOUND: `e378e6854388` (HEAD의 조상)
- Task 1·3 `<verify>` 다시 실행 exit 0

---
*Phase: 05-business-info-support-contact*
*Completed: 2026-11-19*
