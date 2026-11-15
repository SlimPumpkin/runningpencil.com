---
phase: 01-ground-truth-policy-reset
plan: 02
subsystem: docs
tags: [baseline, user-tasks, dns, gabia, google-workspace, dkim, search-console]

requires:
  - phase: 01-ground-truth-policy-reset (01-01)
    provides: ".planning/baseline/NAMES.md 이름 표 (지원 주소 표기, 사업자 값 일곱 항목 이름, 기준 문서 머리·맺음 줄 형식)"
provides:
  - ".planning/baseline/USER-TASKS.md 사용자 작업 절차서 (BASE-04, D-13): 작업 0~12, 한눈에 보기 표, 보존할 기존 레코드 표, 변경 전후 dig 명령, 수신 시험 기록 양식"
  - "가비아 DNS 1차 방문(Workspace 인증 TXT·MX·SPF·Search Console TXT)과 2차 방문(DKIM) 레코드 표"
  - "Workspace 사용자 별칭 도메인 경로와 support 1순위(사용자 별칭)·2순위(Google 그룹) 분기"
affects: [01-04, phase-04, phase-05, phase-06, phase-07, phase-10]

actuals:
  tokens: 4353
  tasks: 2
  commits: 2
plan_head_before: fdf0d085
plan_head_after: 9fdd63da

tech-stack:
  added: []
  patterns:
    - "사용자 작업 구간 형식: ## 작업 N — 제목 + 굵은 머리 여섯 개(막는 단계, 순서, 레코드 표, 변경 전후 dig, 끝났는지 확인, Claude에게 넘길 것), 해당 없으면 「해당 없음」"
    - "서비스 발급 값은 「콘솔에서 복사」, 고정값은 「콘솔 안내값과 대조」 후 콘솔 값을 따름"

key-files:
  created:
    - .planning/baseline/USER-TASKS.md
  modified: []

key-decisions:
  - "절차서의 지원 주소 1순위는 운영자 계정의 사용자 이메일 별칭 support이고, 외부 4곳 수신 시험이 실패하면 별칭을 지운 뒤 Google 그룹(조직 밖 게시 허용)으로 넘어간다"
  - "DMARC(_dmarc TXT)는 작업 6의 선택 항목으로만 두고 정책 값은 적지 않았다 (필요성 미확인)"
  - "라우터용 A 레코드는 호스트 이름 없이 적고, dig 확인은 사용자가 가비아 화면의 호스트 이름을 직접 넣는 별도 명령으로 분리했다"

patterns-established:
  - "사용자 작업 절차서: 한눈에 보기 표(작업·누가·막는 단계·언제 시작·대기 시간) → 보존할 기존 레코드 → 작업 구간 → 공용 명령 → 기록 양식 → 맺음 줄"

requirements-completed: [BASE-04]

coverage:
  - id: D1
    description: "작업 0~12 열세 구간이 형식 계약(구간 제목, 굵은 머리 여섯 개)을 지키고 한눈에 보기 표에 열세 행이 있다"
    requirement: BASE-04
    verification:
      - kind: other
        ref: "01-02-PLAN.md Task 1 verify 3, Task 2 verify 2~3 (bash로 실행)"
        status: pass
    human_judgment: false
  - id: D2
    description: "가비아 DNS 1차·2차 방문의 레코드 표와 고정값(smtp.google.com, v=spf1 include:_spf.google.com ~all, google._domainkey, 24~72시간, 1024 분기)과 「콘솔 안내값과 대조」 문구"
    requirement: BASE-04
    verification:
      - kind: other
        ref: "01-02-PLAN.md Task 1 verify 1 (스무 낱말 grep)"
        status: pass
    human_judgment: false
  - id: D3
    description: "보존할 기존 레코드 표(A 4개, www CNAME, 앱 경로 라우터용 A, _github-pages-challenge-SlimPumpkin TXT)와 「지우는 레코드는 없습니다」"
    requirement: BASE-04
    verification:
      - kind: other
        ref: "01-02-PLAN.md Task 1 verify 2"
        status: pass
    human_judgment: false
  - id: D4
    description: "작업 9~12 (사업자 값 일곱 항목, 앱 화면 캡처, CLI 재로그인, 콘솔에서만 보이는 값)"
    requirement: BASE-04
    verification:
      - kind: other
        ref: "01-02-PLAN.md Task 2 verify 1 (여덟 낱말 grep)"
        status: pass
    human_judgment: false
  - id: D5
    description: "공개 저장소 누출 검사(IP·계정 주소·토큰·DKIM 키 꼴, 하위 도메인 허용 목록)와 라이브 사이트 불변 검사"
    verification:
      - kind: other
        ref: "01-02-PLAN.md Task 1 verify 4~5, Task 2 verify 4~6"
        status: pass
    human_judgment: false
  - id: D6
    description: "작업마다 적은 「막는 단계」가 ROADMAP External Gates 표와 어긋나지 않는다"
    requirement: BASE-04
    verification: []
    human_judgment: true
    rationale: "계획의 human-check. 단계 의존 관계는 ROADMAP 해석이 필요하다 (VALIDATION Manual-Only)"
  - id: D7
    description: "절차서를 실제 가비아·Workspace 화면 옆에 띄워 놓고 따라 할 수 있는지 (메뉴 경로와 화면 표기 일치)"
    requirement: BASE-04
    verification: []
    human_judgment: true
    rationale: "가비아 루트 호스트 표기, 별칭 도메인의 DKIM 목록 노출 등은 화면에서만 확인된다 (RESEARCH A4·A11·A12 ASSUMED)"

duration: 6min
completed: 2026-11-15
status: complete
---

# Phase 1 Plan 02: 사용자 작업 절차서 Summary

**가비아 DNS 2회 방문(1차 인증 TXT·MX `smtp.google.com.`·SPF 1개·Search Console TXT, 2차 DKIM `google._domainkey`)과 Workspace 사용자 별칭 도메인으로 `support@runningpencil.com`을 받는 경로, 외부 4곳 수신 시험, 사업자 값·화면 캡처·CLI 재로그인·콘솔 값 확인까지 작업 0~12를 막는 단계와 함께 적은 절차서**

## Performance

- **Duration:** 6 min
- **Started:** 2026-11-15T05:43:02Z
- **Completed:** 2026-11-15T05:49:30Z
- **Tasks:** 2
- **Files modified:** 1

## Accomplishments

- `.planning/baseline/USER-TASKS.md`를 새로 썼습니다. 한눈에 보기 표(작업 0~12), 보존할 기존 레코드 표, 작업 0~12 구간, 변경 전후 dig 명령, 수신 시험 기록 양식이 들어 있습니다.
- DNS 방문을 1차(작업 2)와 2차(작업 6)로 나누고 방문마다 레코드 표를 따로 두었습니다. 서비스가 발급하는 값은 모두 「콘솔에서 복사」로 적었습니다.
- 지원 주소는 1순위로 사용자 이메일 별칭을 쓰고, 수신 시험이 실패하면 2순위 Google 그룹으로 넘어가는 분기를 넣었습니다. 별칭 도메인이 DKIM 도메인 목록에 없으면 멈추고 알리는 단계도 넣었습니다.
- 작업 9~12에 사업자 값 일곱 항목(이름 표와 같은 이름, 값 없음), 앱 화면 캡처 기준, CLI 재로그인(하지 않으면 「CLI 미확인」으로 남음), 콘솔에서만 보이는 값 다섯 가지를 적었습니다.

## Task Commits

1. **Task 1: 절차서의 골격과 DNS·Workspace·메일 작업(작업 0~8)을 쓴다** - `388eb9f6` (docs)
2. **Task 2: 나머지 사용자 작업(작업 9~12)을 쓰고 절차서 전체를 검사한다** - `9fdd63da` (docs)

## Files Created/Modified

- `.planning/baseline/USER-TASKS.md` - 사용자 작업 절차서 (BASE-04, D-13)

## Decisions Made

- 지원 주소 1순위는 사용자 이메일 별칭이고, 2순위로 넘어갈 때는 같은 이름의 별칭을 먼저 지웁니다 (주소 하나는 한 곳에서만 쓸 수 있음).
- DMARC는 선택 항목으로만 적고 정책 값은 Claude와 정한 뒤 넣으라고 했습니다. 필요한지는 확인하지 않았습니다.
- 라우터용 A 레코드의 `dig`는 공용 명령 블록에 넣지 않았습니다. 사용자가 가비아 화면에서 본 호스트 이름을 직접 넣어 따로 돌립니다.

## Deviations from Plan

None - plan executed exactly as written.

계획의 verify 명령은 macOS 기본 셸인 zsh의 차이를 피하려고 저장소 밖 임시 스크립트에 글자 그대로 옮겨 `bash`로 돌렸습니다. 명령 내용은 바꾸지 않았습니다.

## Issues Encountered

None.

## User Setup Required

이 계획이 만든 절차서가 사용자 작업 목록입니다. `.planning/baseline/USER-TASKS.md`의 작업 0~12를 Phase 2~4와 병행해 진행하면 됩니다. 이메일 게이트(작업 4)가 열려야 Phase 5가 끝납니다.

## Next Phase Readiness

- 사용자는 지금 작업 0~3, 9~12를 시작할 수 있습니다. 작업 6(DKIM)은 Gmail을 켠 뒤 24~72시간이 지나야 합니다.
- `.planning/ROADMAP.md` External Gates 표와 `.planning/STATE.md` Blockers는 아직 ImprovMX 기준 문장을 담고 있습니다. D-21에 따라 이 단계의 다른 계획에서 고칩니다 (이 계획의 범위는 절차서 한 파일).
- 화면에서만 확인되는 가정(가비아 루트 호스트 표기, DKIM 2048비트 저장 가능 여부, 별칭 도메인의 DKIM 목록 노출, 별칭의 외부 수신)은 절차서에 「화면에서 확인」 단계로 풀어 두었습니다.

---
*Phase: 01-ground-truth-policy-reset*
*Completed: 2026-11-15*

## Self-Check: PASSED

- FOUND: .planning/baseline/USER-TASKS.md
- FOUND: 388eb9f6, 9fdd63da
- Task 1 verify 5개, Task 2 verify 6개 모두 exit 0 (SUMMARY 누출 검사 포함)
