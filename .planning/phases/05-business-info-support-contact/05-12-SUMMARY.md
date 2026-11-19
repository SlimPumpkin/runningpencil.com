---
phase: 05-business-info-support-contact
plan: 12
subsystem: infra
tags: [gate-push, deploy, support-page, support-email, live-check, sup-01, sup-02, sup-03, sup-04, sc1, sc3, sc5, evidence]
status: complete

# Dependency graph
requires:
  - phase: 05-business-info-support-contact
    provides: "05-11 G_SHA·G0_SHA·ADDR_FIRST·GATE_CAND=OK와 스크래치 G 빌드($W/g), 05-06 PUSH1_SHA, 05-01 스크래치 도구(lib.sh의 pages_wait·live·footblock, p5-support.mjs·p5-foot.mjs)"
provides:
  - "원격 main = 2bd47891b837 (H1′·H2′·H3′·G0·G와 05-06~05-12 시작까지의 문서 커밋). /support/와 지원 이메일이 라이브"
  - "05-EVIDENCE.md `## 05-12 게이트 푸시 후보`: PUSH2_CANDIDATE, PUSH2_PREV, 범위·출력·주소 이력·값 누출·훅 판정 줄"
  - "05-EVIDENCE.md `## 05-12 게이트 푸시 라이브 확인`: PUSH2_SHA, OK 빌드, OK HTTP 다섯 줄, OK live footer email=1 docs=5, PASS support, PASS foot, OK live addr first=G, LIVE_PUSH2=OK"
  - "스크래치 라이브 사본 $W/live2 (다섯 문서, G 빌드와 바이트 동일)"
affects: [05-13, 05-14, 05-15, 10]

# Actuals (#2632)
actuals:
  tokens: 1605     # chars/4: 작업 트리 05-EVIDENCE.md diff 6421자 (Task 1·3 구간). SUMMARY 제외. 사이트 파일 변경 없음
  tasks: 3
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). 이 계획은 사이트 커밋이 없고, SUMMARY·EVIDENCE 문서 커밋과 STATE·ROADMAP 기록 커밋은 이 뒤
plan_head_before: 2bd47891b837115b83d73c4ab45797057f4cdc93
plan_head_after: 2bd47891b837115b83d73c4ab45797057f4cdc93

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "푸시 직전 git fetch로 원격이 기록한 PREV 그대로인지 다시 보고, 승인받은 전체 해시 하나만 \"${FULL}:refs/heads/main\"으로 내보낸다 (훅 통과, --no-verify·force 없음)"
    - "라이브 판정은 Pages 빌드 완료(builds/latest = 그 커밋·built·오류 없음) 뒤 ?cb=<푸시 12자리>로 받아 로컬 빌드와 cmp로 바이트 비교"

key-files:
  created:
    - .planning/phases/05-business-info-support-contact/05-12-SUMMARY.md
  modified:
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md

key-decisions:
  - "사용자가 Task 2에서 push로 답해 승인 SHA 2bd47891b837(= PUSH2_CANDIDATE) 하나만 원격 main에 푸시했다. 이 승인은 이 푸시 한 번에만 썼고, 이 계획의 SUMMARY·EVIDENCE 문서 커밋은 05-15 문서 푸시 때 나간다"
  - "라이브 다섯 URL이 200·기대 제목·G 빌드와 바이트 동일이고 두 엔진 화면이 통과해 되돌리기는 필요 없었다. 원격 이력에서 지원 주소를 처음 더한 사이트 커밋은 G다 (SC1)"

patterns-established: []

requirements-completed: []  # 계획 requirements는 [SUP-01, SUP-02, SUP-03, SUP-04, BIZ-01]. 05-11과 같은 이 단계 관례대로 단계 검증(05-15) 전에는 비워 둠

coverage:
  - id: D1
    description: "게이트 푸시 후보의 범위가 사이트 커밋 다섯(H1′·H2′·H3′·G0·G)과 여덟 파일이고, 후보 사이트가 G와 같고, 원격 이력에 주소가 없고 범위에서 처음 더한 커밋이 G이며, 실제 훅이 후보를 통과시켰다"
    requirement: "SUP-02"
    verification:
      - kind: other
        ref: "05-12-PLAN.md Task 1 <verify> (Task 3 뒤 다시 실행해도 exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "사람이 SHA 2bd47891b837을 보고 push로 승인한 뒤에만 그 SHA 하나가 원격 main에 나갔다 (PUSH2_SHA = PUSH2_CANDIDATE, 원격 main의 조상)"
    requirement: "SUP-01"
    verification:
      - kind: other
        ref: "05-12-PLAN.md Task 3 <verify> 1 (exit 0)"
        status: pass
    human_judgment: true
  - id: D3
    description: "Pages 배포 완료 뒤 라이브 /·세 법적 URL·/support/가 200·기대 제목이고 로컬 G 빌드와 바이트가 같으며, 다섯 문서 푸터에 이메일 행이 하나씩 있다"
    requirement: "SUP-03"
    verification:
      - kind: other
        ref: "05-12-PLAN.md Task 3 <verify> 1·2 (exit 0, Pages 빌드 기록 대조 포함)"
        status: pass
    human_judgment: false
  - id: D4
    description: "라이브에서 두 엔진 × 375·1280으로 /support/ 구조(contact → report → faq, mailto 1, dl 4)·헤더(1280)·푸터 링크·#report 앵커(PASS support)와 다섯 문서 푸터 줄 나뉨·링크 색(PASS foot)이 통과"
    requirement: "SUP-04"
    verification:
      - kind: automated_ui
        ref: "node $W/pw/p5-support.mjs https://runningpencil.com '?cb=2bd47891b837'; node $W/pw/p5-foot.mjs https://runningpencil.com '?cb=2bd47891b837' (둘 다 exit 0)"
        status: pass
    human_judgment: false
  - id: D5
    description: "푸시 뒤 원격 main(푸시한 해시에 고정) 사이트 이력에서 지원 주소를 처음 더한 커밋이 G다 (SC1)"
    requirement: "BIZ-01"
    verification:
      - kind: other
        ref: "05-12-PLAN.md Task 3 <verify> 2 (exit 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 16min
completed: 2026-11-19
---

# Phase 5 Plan 12: 게이트 푸시 (지원 페이지·링크·지원 이메일) Summary

**사용자가 승인한 SHA `2bd47891b837` 하나를 원격 main에 푸시했고, Pages 배포 완료 뒤 다섯 URL(200·제목·G 빌드와 바이트 동일), 다섯 문서 푸터 이메일 행, 두 엔진 화면(`PASS support`·`PASS foot`), 원격 이력의 주소 첫 커밋(= G)까지 라이브에서 확인했습니다(`LIVE_PUSH2=OK`).**

## Performance

- **Duration:** 16 min
- **Started:** 2026-11-19T09:46:23Z (Wave 12 시작 기록 커밋 시각)
- **Completed:** 2026-11-19T10:02Z
- **Tasks:** 3 (Task 1 tracer, Task 2 사람 승인, Task 3 푸시·라이브 확인)
- **Files modified:** 1 (EVIDENCE. SUMMARY 제외. 사이트 파일 변경 없음)

## Accomplishments

- Task 1(앞 실행자): 후보 `2bd47891b837`의 범위가 여덟 파일·사이트 커밋 다섯이고, 사이트 출력이 G와 같고, 원격 이력에 주소가 없고 범위에서 처음 더한 커밋이 G이며, 값 누출 0건, 실제 훅 통과를 기록했습니다.
- Task 2: 사용자가 `push`로 답했습니다(승인 SHA = `PUSH2_CANDIDATE`).
- Task 3: 푸시 전에 `$W/g/TREE`가 G 트리와 같고 두 점검 도구가 있는 것, `git fetch` 뒤 원격 main이 `PUSH2_PREV`(`57e56b07f2ab`) 그대로인 것, 작업 트리 훅·스크립트가 후보와 같은 것을 확인했습니다. `git push origin "${FULL}:refs/heads/main"` 한 번에 훅(check-site) 통과, `57e56b0..2bd4789`.
- 배포 완료: `OK 빌드 2bd47891b837 built 2026-11-19T09:58:19Z`.
- 라이브 다섯 문서 `OK HTTP … 200 … bytes=same`(지원 페이지 제목 「고객 지원 - 러닝펜슬」 포함), `OK live footer email=1 docs=5`.
- 두 엔진 × 375·1280: `/support/` `ids=contact,report,faq mailto=1 dl=4 dt=4`, 1280 `hdr=1`·375 `hdr=0`(860px 이하 nav 숨김, 05-11 로컬과 같음), `ftr=1`, `anchor=ok`, 네 문서 `supportlinks=2` → `PASS support`. 다섯 문서 `rows=6 spans=4 seps=2 links=1 sepLead=0` → `PASS foot`.
- 원격 이력: `OK live addr first=G`(`4ea25de8d80e`). 되돌리기는 필요 없었습니다.

## Task Commits

1. **Task 1: 게이트 푸시 후보 점검 (tracer)** - 사이트 커밋 없음. 기록은 아래 문서 커밋에 들어갑니다.
2. **Task 2: 게이트 푸시 SHA 승인 (checkpoint:decision, blocking-human)** - 사용자 답 `push`.
3. **Task 3: 승인 SHA 푸시와 라이브 확인** - 사이트 커밋 없음. 원격 main을 `2bd47891b837`로 옮겼습니다.

**Plan metadata:** SUMMARY·EVIDENCE 문서 커밋(로컬, 05-15 문서 푸시 때 나감), 그 뒤 STATE·ROADMAP 기록 커밋.

## Files Created/Modified

- `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` - `## 05-12 게이트 푸시 후보`, `## 05-12 게이트 푸시 라이브 확인`
- `.planning/phases/05-business-info-support-contact/05-12-SUMMARY.md` - 이 문서

## Verification

- Task 1 `<verify>`: exit 0 (푸시 뒤 다시 실행).
- Task 3 `<verify>` 두 명령: 모두 exit 0 (Pages 빌드 기록 `gh api` 대조 포함).
- 계획 `<verification>` 기록 누출 검사: `05-EVIDENCE.md`에 지원 주소·홈 경로·로컬 사용자 경로 모두 0건.
- 작업 위치: 메인 체크아웃 `main`. 오케스트레이터 `<project_root_pin>` 가드를 첫 기록 전과 커밋 전에 돌렸습니다(PIN OK).

## Decisions Made

- 승인은 이 푸시 하나에만 썼습니다. 이 계획의 문서 커밋은 푸시하지 않습니다(05-15 문서 푸시 때 나감).

## Deviations from Plan

**1. [기록] 라이브 구간에 계획 밖 줄 추가**
- 05-06 라이브 구간과 같은 관례로 `OK origin unchanged = push2-prev`, `OK hook files = push2-cand`, 훅 출력, 푸시 결과 줄을 적었습니다. verify 판정 줄과 겹치지 않고 `FAIL` 줄은 없습니다.

---

**Total deviations:** 1 (기록 1)
**Impact on plan:** 판정과 사이트 내용에는 영향이 없습니다. 범위 확장 없음.

## Issues Encountered

None

## Known Stubs

None. 「전화」는 `phone` 값이 비어 있어 의도대로 그리지 않습니다(render-if-present, BIZ-03).

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 05-13~05-15: 원격 main = `2bd47891b837`. 로컬 main에는 이 계획의 문서 커밋과 기록 커밋이 원격보다 앞서 있고, 05-15 문서 푸시 때 나갑니다.
- `/support/`가 라이브라 App Store Support URL 등록(Phase 10)과 앱의 지원 링크(Deferred)를 할 수 있습니다.
- 이미 공개된 지원 주소는 되돌려도 검색 캐시와 아카이브에 남습니다(D-04 costly).
- 보류 worktree `$HOLD_WT`와 브랜치 ref `p5-support-hold`는 그대로입니다(05-13이 worktree만 지움).

---
*Phase: 05-business-info-support-contact*
*Completed: 2026-11-19*

## Self-Check: PASSED

- 파일: `05-12-SUMMARY.md`, `05-EVIDENCE.md` 있음
- 커밋: `2bd47891b837`(PUSH2_SHA)과 G `4ea25de8d80e`가 원격 main의 조상
- SUMMARY·EVIDENCE에 지원 주소 0건, 로컬 홈 경로 0건. 작업 트리 check-site 통과
