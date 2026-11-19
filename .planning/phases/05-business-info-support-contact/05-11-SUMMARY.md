---
phase: 05-business-info-support-contact
plan: 11
subsystem: infra
tags: [email-gate, cherry-pick, support-page, support-email, sup-01, sup-02, sc1, sc3, sc4, sc5, evidence]
status: complete

# Dependency graph
requires:
  - phase: 05-business-info-support-contact
    provides: "05-08 보류 묶음 HOLD_BASE·H1~H3(HOLD_ONLY7·HOLD_UI), 05-10 GATE_PREFLIGHT=OK와 게이트 기록 커밋(GATE_OPEN=OK), 05-06 PUSH1_SHA, 05-01 스크래치 도구(lib.sh·p5-foot.mjs·p5-support.mjs)"
provides:
  - "main의 H1′ ebb6b1abc1ba·H2′ 00db937e5195·H3′ 070015974299(보류 묶음 cherry-pick), G0 3ee770068923(support/index.html updated 한 줄), G 4ea25de8d80e(_data/company.yml support_email 한 줄)"
  - "05-EVIDENCE.md `## 05-11 게이트 커밋`: OK cherry all-applied 3, OK pick same-as-h3, G0 7번만 실패, G 통과, OK origin unchanged = push1, site-clean 기록, PICK_SAME=OK, G0_SHA, G_SHA"
  - "05-EVIDENCE.md `## 05-11 게이트 판정`: 출력 수 다섯 줄, 주소 파일 5, 주소 이력 세 줄, 두 엔진 화면 출력(PASS support·PASS foot), ADDR_FIRST, GATE_CAND=OK"
  - "스크래치 빌드 $W/pick(= H3 출력), $W/g(G 트리, 05-12 라이브 비교 기준)"
affects: [05-12, 05-13, 05-14, 05-15]

# Actuals (#2632)
actuals:
  tokens: 3720     # chars/4: plan_head_before..HEAD diff + 작업 트리 .planning diff 14880자. SUMMARY 제외
  tasks: 2
  commits: 5       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). SUMMARY·EVIDENCE 문서 커밋, STATE·ROADMAP 기록 커밋은 뒤
plan_head_before: 69fa350cecda3658cfc80c51701dcc632baa475d
plan_head_after: 4ea25de8d80e1adf85b7dd9f337ded1e41af71df

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "보류 묶음은 rebase 대신 cherry-pick으로 main 끝에 더하고, cherry-pick 뒤 빌드 출력이 보류 브랜치 빌드와 diff -r 빈 출력인지로 보류 판정을 이어받는다"
    - "주소가 트리에 들어간 뒤에는 도구 출력을 스크래치 파일에 받아 주소 0건(grep -cF)을 확인한 뒤에만 보이거나 기록에 붙인다. company.yml은 --name-only·--numstat·grep -c로만 본다"

key-files:
  created:
    - .planning/phases/05-business-info-support-contact/05-11-SUMMARY.md
  modified:
    - support/index.html
    - scripts/check-site.sh
    - _includes/header.html
    - _includes/footer.html
    - _data/company.yml
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md

key-decisions:
  - "보류 묶음 H1~H3를 main 끝에 cherry-pick했고(충돌 없음), 그 출력이 보류 브랜치 H3 빌드와 바이트까지 같다(PICK_SAME=OK)"
  - "지원 페이지 updated는 게이트 날 2026년 11월 19일(G0). 05-12 푸시가 이 날을 넘기면 승인 checkpoint에서 사용자에게 보인다"
  - "지원 이메일 값은 게이트 기록 커밋의 자손인 G에서 처음 사이트 파일에 들어갔다(ADDR_FIRST=G, PUSH1 이력 0건). 이 계획은 푸시하지 않았고 원격 main은 PUSH1_SHA 그대로다"

patterns-established:
  - "커밋 메시지 끝 줄을 검사하는 verify가 있는 커밋은 Claude-Session 줄을 Co-Authored-By 위에 두어 두 attribution 줄을 모두 남기면서 끝 줄 조건을 지킨다"

requirements-completed: []  # 계획 requirements는 [SUP-01, SUP-02, SUP-03, SUP-04, BIZ-01, BIZ-02, BIZ-03]. requirements.ready-ids가 일곱 모두 blocked로 냄(05-12~05-15도 선언). 이 단계 관례대로 비워 둠

coverage:
  - id: D1
    description: "보류 묶음 H1·H2·H3가 main 끝에 cherry-pick됐고(git cherry 세 줄 모두 -), cherry-pick 뒤 출력이 보류 브랜치 H3 빌드와 같다"
    requirement: "SUP-01"
    verification:
      - kind: other
        ref: "05-11-PLAN.md Task 1 <verify> (bash·zsh exit 0, Task 2 뒤 다시 실행해도 exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "G0(support/index.html에 updated 한 줄, 7번만 실패)와 G(_data/company.yml support_email 한 줄, check-site 일곱 항목 통과)가 차례로 main에 있고 G0가 G의 부모다. G 메시지에 주소 없음"
    requirement: "SUP-02"
    verification:
      - kind: other
        ref: "05-11-PLAN.md Task 1 <verify> (exit 0)"
        status: pass
    human_judgment: false
  - id: D3
    description: "G 빌드: 다섯 문서 푸터 이메일 행 1개씩, 「전화」 0, 지원 페이지 contact → report → faq·dl 4·#contact mailto 1·최종 업데이트 1·robots 0, 다섯 문서 /support/ 링크 2개씩, 주소 든 출력 파일 5"
    requirement: "SUP-03"
    verification:
      - kind: other
        ref: "05-11-PLAN.md Task 2 <verify> (bash·zsh exit 0)"
        status: pass
    human_judgment: false
  - id: D4
    description: "두 엔진 × 375·1280에서 지원 페이지 구조·링크·#report 앵커(PASS support)와 다섯 문서 푸터 줄 나뉨·링크 색(PASS foot)이 통과"
    requirement: "SUP-04"
    verification:
      - kind: automated_ui
        ref: "node $W/pw/p5-support.mjs http://127.0.0.1:4511; node $W/pw/p5-foot.mjs http://127.0.0.1:4511 (둘 다 exit 0, 05-EVIDENCE `## 05-11 게이트 판정`)"
        status: pass
    human_judgment: false
  - id: D5
    description: "지원 주소가 게이트 전 원격(PUSH1_SHA) 사이트 이력에 없고, 처음 더한 사이트 커밋이 G이며, 게이트 기록 커밋이 G의 조상이다 (SC1)"
    requirement: "SUP-02"
    verification:
      - kind: other
        ref: "05-11-PLAN.md Task 2 <verify> (exit 0, PUSH1_SHA·G_SHA에 고정)"
        status: pass
    human_judgment: false

# Metrics
duration: 3min
completed: 2026-11-19
---

# Phase 5 Plan 11: 게이트 커밋 (보류 묶음 cherry-pick + 날짜 + 지원 이메일) Summary

**보류 묶음 H1~H3를 main 끝에 cherry-pick(출력이 H3 빌드와 동일)하고, 지원 페이지 게이트 날짜 커밋 G0와 지원 이메일 값 커밋 G를 이어 만들어 check-site 일곱 항목·두 엔진 화면·주소 이력(처음 = G, 게이트 기록 뒤)을 모두 통과시켰습니다. 푸시는 하지 않았습니다(05-12).**

## Performance

- **Duration:** 3 min
- **Started:** 2026-11-19T09:33:57Z
- **Completed:** 2026-11-19T09:36:54Z
- **Tasks:** 2
- **Files modified:** 6 (사이트 5, EVIDENCE 1. SUMMARY 제외)

## Accomplishments

- `git cherry-pick <HOLD_BASE>..p5-support-hold`가 충돌 없이 H1′·H2′·H3′를 `main`에 더했고, `build pick HEAD` 출력이 `$W/h3/site`와 `diff -r` 빈 출력입니다.
- G0: `support/index.html` front matter `heading:` 다음에 `updated: "2026년 11월 19일"` 한 줄. 그 커밋의 스크립트로 점검하면 7번 연락처 문구 하나만 실패합니다(설계대로).
- G: `_data/company.yml`의 `support_email` 한 줄(`--numstat` `1 1`). 값은 이름 표에서 변수로만 읽어 `sed`로 썼고, 화면·기록·커밋 메시지에 적지 않았습니다. 후보와 G 모두 check-site 일곱 항목 통과.
- G 빌드(`$W/g`): 다섯 문서 푸터 이메일 행 1개씩, 「전화」 0, 지원 페이지 `contact,report,faq`·`dl` 4·`#contact` `mailto:` 1·최종 업데이트 1·`robots` 0·「영업일 기준 3일 안에 답장합니다」 있음, `/support/` 링크 다섯 문서 2개씩.
- 두 엔진 × 375·1280: `PASS support`(1280 `hdr=1 ftr=1`, 375 `hdr=0 ftr=1`, 네 줄 모두 `anchor=ok`), `PASS foot`(다섯 문서 `rows=6 spans=4 seps=2 links=1 sepLead=0`).
- 이력: `PUSH1_SHA` 사이트 이력에 주소 0건, 주소를 처음 더한 사이트 커밋이 G, 게이트 기록 커밋 `9e3b9be2d0cc`가 G의 조상. 원격 main은 `PUSH1_SHA` 그대로.

## Task Commits

1. **Task 1: 보류 묶음 cherry-pick, G0·G 커밋 (tracer)**
   - `ebb6b1abc1ba` feat: 고객 지원 페이지 /support/ 추가 (H1′)
   - `00db937e5195` build: 점검 3번 기대 제목에 /support/ 추가 (H2′)
   - `070015974299` feat: 헤더와 푸터에 고객 지원 링크 추가 (H3′)
   - `3ee770068923` feat: 고객 지원 페이지에 최종 업데이트 날짜 표시 (게이트 날) (G0)
   - `4ea25de8d80e` feat: 지원 이메일 공개 (이메일 게이트 통과) (G)
2. **Task 2: G 빌드 판정** - 사이트 커밋 없음. 기록은 아래 문서 커밋에 들어갑니다.

**Plan metadata:** SUMMARY·EVIDENCE 문서 커밋, 그 뒤 STATE·ROADMAP 기록 커밋.

## Files Created/Modified

- `support/index.html` - 지원 페이지(H1′), front matter `updated`(G0)
- `scripts/check-site.sh` - 3번 기대 제목에 지원 페이지(H2′)
- `_includes/header.html`, `_includes/footer.html` - 고객 지원 링크, 푸터 nav 이름(H3′)
- `_data/company.yml` - `support_email` 값(G)
- `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` - `## 05-11 게이트 커밋`, `## 05-11 게이트 판정`
- `.planning/phases/05-business-info-support-contact/05-11-SUMMARY.md` - 이 문서

## Verification

- Task 1 `<verify>`: bash·zsh exit 0 (Task 2 뒤 다시 실행해도 exit 0).
- Task 2 `<verify>`: bash·zsh exit 0.
- 계획 `<verification>`: `git log --format=%h <PUSH1_SHA>..<G_SHA> -- . ':(exclude).planning' ':(exclude)CLAUDE.md' ':(exclude).claude' ':(exclude)README.md'`가 G·G0·H3′·H2′·H1′ 다섯 줄. EVIDENCE에 지원 주소·`$HOME`·`/Users/` 0건.
- acceptance: 보류 브랜치 ref `p5-support-hold`가 남아 있음(`git show-ref --verify` 성공), `OK origin unchanged = push1`이 구간에 있음.
- 값 누출 점검: `vals filled=4 emitted=3 excluded=1`, (a) `.planning` 0건, (b) `BASE_SHA..HEAD` 커밋 메시지 0건, (c) 작업 트리 `.planning` diff 0건. 문서 커밋 직전 staged diff로 (c)를 다시 봅니다.
- 작업 위치: 메인 체크아웃 `main`. 오케스트레이터 `<project_root_pin>` 가드를 첫 커밋(cherry-pick) 전과 커밋마다 돌렸습니다(PIN OK). 보류 worktree에서는 아무것도 고치거나 커밋하지 않았습니다.

## Decisions Made

- `updated` 날짜는 G0를 만든 날(게이트 날) `2026년 11월 19일`입니다(계획 assumptions, D-12 보충).
- G0도 사이트 커밋 후보 절차(후보 `commit-tree` → 점검 → 같은 인덱스 커밋 → 트리 일치)로 만들었습니다. G0 후보 점검 결과는 7번 하나만 실패였습니다.

## Deviations from Plan

**1. [커밋 형식] G0·G 메시지의 attribution 두 줄 순서**
- **Found during:** Task 1 (G 커밋 전)
- **Issue:** 05-11 Task 1 verify는 G 메시지의 마지막 비지 않은 줄이 정확히 `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`인지 봅니다. 이 실행의 지시는 `Co-Authored-By` 다음에 `Claude-Session` 줄을 두라고 했습니다. 그 순서면 verify가 실패하고, amend가 금지라 커밋 뒤에는 고칠 수 없습니다. 05-10 SUMMARY의 「05-11~05-15 verify 가운데 커밋 메시지 마지막 줄을 검사하는 것은 없습니다」는 이 verify에는 맞지 않았습니다.
- **Fix:** G0·G 메시지에 두 줄을 모두 넣되 `Claude-Session:` 줄을 `Co-Authored-By:` 줄 위에 두었습니다. 커밋 전에 메시지 파일로 verify의 끝 줄 조건과 주소 0건을 먼저 확인했습니다. cherry-pick한 H1′~H3′는 원래 메시지(`Co-Authored-By` 한 줄)를 그대로 가져왔습니다.
- **Verification:** Task 1 verify exit 0.
- **Committed in:** `3ee770068923`, `4ea25de8d80e`

**2. [기록] Task 1·2 구간에 계획 밖 줄 추가**
- Task 1 구간에 05-09에서 굳힌 관례대로 깨끗함 기록 `OK site-clean 05-11-t1 4ea25de8d80e`를, Task 2 구간에 「영업일 기준 3일 안에 답장합니다」 확인 줄 `OK g support reply-3days`와 값 누출 점검 결과 두 줄을 더 적었습니다. verify 판정 줄과 겹치지 않습니다.

---

**Total deviations:** 2 (커밋 형식 1, 기록 1)
**Impact on plan:** 사이트 내용과 판정에는 영향이 없습니다. 범위 확장 없음.

## Issues Encountered

None

## Known Stubs

None. 「전화」는 `phone` 값이 비어 있어 의도대로 그리지 않습니다(render-if-present, BIZ-03).

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 05-12: 로컬 `main` 끝 사이트 커밋은 G `4ea25de8d80e`이고, 그 뒤에는 이 계획의 문서 커밋들이 있습니다. 원격 main은 아직 `PUSH1_SHA`입니다. 05-12가 푸시 SHA 승인(blocking-human)을 받은 뒤 푸시하고 라이브를 `$W/g` 빌드와 비교합니다.
- 푸시가 2026-11-19를 넘기면 지원 페이지 `updated`(게이트 날)와 푸시 날이 달라지므로 05-12 승인 checkpoint에서 사용자에게 보입니다.
- 보류 worktree `$HOLD_WT`와 브랜치 ref는 그대로입니다(05-13이 worktree만 지움).

---
*Phase: 05-business-info-support-contact*
*Completed: 2026-11-19*

## Self-Check: PASSED

- 파일: `05-11-SUMMARY.md`, `05-EVIDENCE.md`, `support/index.html`, `_data/company.yml` 있음
- 커밋: `ebb6b1abc1ba`, `00db937e5195`, `070015974299`, `3ee770068923`, `4ea25de8d80e` 모두 HEAD의 조상
- SUMMARY·EVIDENCE에 지원 주소 0건, 로컬 홈 경로 0건. 작업 트리 check-site 통과
