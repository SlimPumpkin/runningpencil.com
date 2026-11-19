---
phase: 05-business-info-support-contact
plan: 04
subsystem: infra
tags: [check-site, pre-push, email-gate, support-page, guard, bash32]
status: complete

# Dependency graph
requires:
  - phase: 05-business-info-support-contact
    provides: "05-01의 BASE_SHA=2db88d9a199f·BASE_LIVE=84a5d9114ef3·$W/lib.sh mkobj, 05-02의 PROTO_SUPPORT_BLOB·$W/yml/email.yml, 05-03의 M2_SHA=b7e2dcd0de13·FOOT_LAYOUT=OK"
provides:
  - "M3 da940757106e: scripts/check-site.sh 7번 항목 (지원 페이지가 있으면 mailto 연락처, /support/ 링크가 있으면 그 페이지). grep 종료 코드 2 이상은 실패로 셈"
  - "05-EVIDENCE.md 표식 M3_SHA·NEG7_PAGE·NEG7_LINK·POS7·GUARD7=OK·HOOK7=OK, 구간 `## 05-04 가드`·`## 05-04 훅`"
  - "스크래치 $W/h3-header.html (헤더 끝 「고객 지원」 링크 한 줄을 더한 시험용 헤더, 끝 줄바꿈 없음)"
affects: [05-06, 05-07, 05-08, 05-10, 05-11, 05-12]

# Actuals (#2632)
actuals:
  tokens: 1645     # chars/4 over 계획 동안 바뀐 줄(check-site.sh diff, 05-EVIDENCE.md 두 구간). 이 SUMMARY 제외
  tasks: 2
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (M3). 이 SUMMARY·EVIDENCE 문서 커밋과 STATE 커밋은 뒤에 더해진다
plan_head_before: d706dfe0ddded3dad5f7aa791c82f3c57e805bbb
plan_head_after: da940757106ebfb87f5a0754d38e5f048d19d6c6

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "점검 항목은 후보(commit-tree)의 스크립트 사본으로 양성(기준·M2·후보)과 음성 시험 객체(mkobj, ref 없음)를 함께 판정한 뒤 같은 인덱스를 커밋한다"
    - "실제 pre-push 훅은 표준 입력(`refs/heads/main <SHA> refs/heads/main <원격>`)만 주어 시험하고, 직전에 작업 트리 스크립트·훅이 후보와 같음을 기록한다"

key-files:
  created:
    - .planning/phases/05-business-info-support-contact/05-04-SUMMARY.md
  modified:
    - scripts/check-site.sh
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md

key-decisions:
  - "7번 링크 문구의 경로 목록은 2번 항목처럼 `printf '%s '`로 한 줄에 잇는다 (기록에 한 줄로 붙도록)"
  - "EXPECTED_TITLES와 .githooks/pre-push는 고치지 않았다. 지원 페이지 기대 제목은 보류 묶음(05-08)과 게이트 뒤(05-11)에만 들어간다 (Pitfall 7)"
  - "SUP-01·SUP-02는 완료 처리하지 않았다. `requirements.ready-ids`가 둘 다 blocked(뒤 계획이 같은 ID를 선언)였다"
  - "CLAUDE.md 두 벌과 .planning/codebase 문서의 「여섯 가지」 항목 수는 이 계획 범위 밖이라 그대로 두었다. 05-07이 「점검 항목은 일곱이다」로 함께 고친다"

patterns-established:
  - "보류 묶음 중간 커밋을 check-site로 점검하면 7번 하나로 실패하는 것이 기대값이다 (RESEARCH Pitfall 8). 통과는 게이트 커밋에서만 기대한다"

requirements-completed: []

coverage:
  - id: D1
    description: "check-site 7번 항목이 기준·M2·M3와 양성 시험 객체(POS7)에서 통과하고, 연락처 없는 지원 페이지(NEG7_PAGE)와 페이지 없는 링크(NEG7_LINK)에서 각각 7번 하나로(실패 — 1건) 실패한다"
    requirement: "SUP-02"
    verification:
      - kind: integration
        ref: "05-04-PLAN.md Task 1 verify 두 명령 (bash·zsh 모두 exit 0)"
        status: pass
      - kind: integration
        ref: "$W/v504-t1.sh (OK neg7-page rc=1 count=1 mailto-msg=1, OK neg7-link rc=1 count=1 link-msg=1, OK pos7 pass)"
        status: pass
    human_judgment: false
  - id: D2
    description: "실제 pre-push 훅이 M3는 통과시키고 두 음성 시험 객체는 7번 문구로 거부한다. 원격 main은 이 계획 동안 BASE_LIVE 그대로였다"
    requirement: "SUP-01"
    verification:
      - kind: integration
        ref: "05-04-PLAN.md Task 2 verify (exit 0), $W/v504-t2.sh"
        status: pass
    human_judgment: false

# Metrics
duration: 13min
completed: 2026-11-19
---

# Phase 5 Plan 04: 점검 7번 항목 (이메일 게이트 가드) Summary

**`scripts/check-site.sh`에 「지원 페이지가 있으면 mailto 연락처, /support/ 링크가 있으면 그 페이지」 7번 항목을 build 커밋 M3(da940757106e)로 더하고, 음성 시험 객체 둘을 실제 pre-push 훅이 거부함을 확인했다**

## Performance

- **Duration:** 약 13분
- **Started:** 2026-11-19T02:57Z 무렵 (계획 읽기 포함)
- **Completed:** 2026-11-19T03:10Z
- **Tasks:** 2
- **Files modified:** 2 (`scripts/check-site.sh`, `05-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- 7번 항목: `$DEST/support/index.html`이 있으면 `href="mailto:`가 있어야 하고, 출력 HTML 어디든 `href="/support/`가 있으면 그 문서가 있어야 한다. 링크 검색 grep의 종료 코드를 `sup_rc`로 받아 2 이상이면 「점검 7번 grep이 실패했습니다」로 센다(T-05-09). bash 3.2 호환
- 양성·음성 대조(후보 스크립트 사본): 기준·M2·후보 통과, `NEG7_PAGE`·`NEG7_LINK`가 각각 종료 코드 1·「실패 — 1건」·해당 문구만, `POS7`(원형 지원 페이지 + 이메일 가짜 값 + 헤더 링크) 통과
- 실제 훅: `OK origin = base-live`, `OK hook files = m3`, M3 통과, 두 음성 시험 객체 거부(T-05-08). 아무것도 푸시하지 않음
- 시험 객체 셋은 어떤 ref에도 없다(`git branch -a --contains`, `git for-each-ref --contains` 모두 빈 출력)

## Task Commits

1. **Task 1: 7번 항목 후보 판정 후 M3 커밋** - `da94075` (build)
2. **Task 2: pre-push 훅 판정** - 사이트 커밋 없음 (기록은 문서 커밋)

**Plan metadata:** 이 SUMMARY와 `05-EVIDENCE.md`의 문서 커밋 (docs)

## Files Created/Modified

- `scripts/check-site.sh` - 머리 주석 「일곱 가지」와 7번 줄, 6번 블록 뒤 7번 구획(두 판정과 grep 오류 처리)
- `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` - 구간 `## 05-04 가드`(판정 줄, 음성 출력 전체, 표식, 깨끗함 기록 `OK site-clean 05-04-t1 da940757106e`), `## 05-04 훅`(원격·훅 판정 줄, 훅 출력, `HOOK7=OK`)

## Decisions Made

- 링크 문구의 경로 목록은 2번 항목과 같은 `printf '%s '` 꼴로 한 줄에 잇는다
- `EXPECTED_TITLES`와 훅은 그대로 둔다(Pitfall 7). 7번은 조건부라 게이트 전 `main`에 있어도 모든 푸시가 지나간다
- 문서의 항목 수(「여섯 가지」)는 05-07이 고친다. 이 계획 파일 범위가 `scripts/check-site.sh`와 EVIDENCE 둘뿐이다

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None. 판정 하네스는 zsh 특수 변수 문제를 피하려고 `/bin/bash` 스크립트(`$W/v504-t1.sh`, `$W/v504-t2.sh`)로 돌렸고, verify 명령은 bash와 zsh 양쪽에서 exit 0을 확인했다.

## Verification

- Task 1 verify 두 명령: exit 0 (bash, zsh)
- Task 1 acceptance: 7번 구획 수 1, 「여섯 가지를 확인한다」 수 0
- Task 2 verify: exit 0, `OK origin = base-live` 1줄
- `git log --format=%h b7e2dcd0de13..da940757106e -- . ':(exclude).planning'` = `da94075` 한 줄
- 시험 객체 `NEG7_PAGE`·`NEG7_LINK`·`POS7`을 담은 ref 없음
- 기록 누출 점검: EVIDENCE에 홈·임시 경로, 메일 주소 없음

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 05-05(사업자 값 받기)로 진행할 수 있다. 7번 가드는 05-08 보류 묶음 중간 커밋에서 「7번 하나로 실패」를 기대값으로 쓴다
- 05-07이 CLAUDE.md 두 벌과 codebase 문서의 점검 항목 수를 일곱으로 고친다

## Self-Check: PASSED

- FOUND: scripts/check-site.sh (M3에 7번 구획)
- FOUND: da940757106e (HEAD의 조상)
- FOUND: 05-EVIDENCE.md 표식 M3_SHA·GUARD7=OK·HOOK7=OK

---
*Phase: 05-business-info-support-contact*
*Completed: 2026-11-19*
