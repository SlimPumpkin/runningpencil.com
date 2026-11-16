---
phase: 03-tailwind-cdn-removal
plan: 04
subsystem: ui
tags: [legal-pages, tailwind-cdn, pixel-diff, check-site, pre-push]

# Dependency graph
requires:
  - phase: 03-tailwind-cdn-removal
    provides: "03-01: BASE_SHA=8b65fdb59232, 판정 도구(lib.sh·judge.sh·pw), 기준 캡처 $W/cap/base1 / 03-02: legal.css, 커밋 ① C1_SHA=7cd2b6128884, ③ 미리보기 C1_PREVIEW3=OK / 03-03: 커밋 ② C2_SHA=31327b684f43, C2_PIXEL=OK·C2_CONTRACT=OK"
provides:
  - "사이트 커밋 ③ C3_SHA=c49e12a50394: 법적 레이아웃에서 Tailwind Play CDN script와 tailwind-config 설정 블록 제거(16줄 삭제). 법적 페이지는 common.css + legal.css만으로 그려짐"
  - "커밋 ③ 빌드가 base1과 PNG 42장·txt 18건 차이 0, hover·focus 24장 유효, report 18행 모두 Tailwind 요청 0건·HTML에 CDN 없음 (C3_PIXEL=OK)"
  - "점검 커밋 CHECK5_SHA=69f46942bec6: scripts/check-site.sh 5번 항목 「Tailwind Play CDN 없음」. 커밋 ②로 실패하는 음성 대조 확인 (CHECK5=OK)"
affects: [03-05, 03-06, 03-07, 03-08, 03-09, 06, 07, 08, 09]

# Actuals (#2632)
actuals:
  tokens: 2100     # chars/4: 레이아웃·점검 스크립트 diff + 03-EVIDENCE.md 추가분 (SUMMARY 제외)
  tasks: 2
  commits: 2       # 측정값: git rev-list --count plan_head_before..HEAD (커밋 ③, 점검 커밋). 기록은 아래 docs 커밋 하나로 들어간다
plan_head_before: 095e682d5e8a08e8ac7ffa0d05dc2f93ffbabf58
plan_head_after: 69f46942bec62840894cf08d7619b24105a3b99c

# Tech tracking
tech-stack:
  added: []
  removed:
    - "Tailwind CSS Play CDN (cdn.tailwindcss.com, 버전 미고정 런타임 스크립트) — 법적 페이지 3종"
  patterns:
    - "법적 페이지 <head>: theme-color meta → 0열 head-links include → <style>(common.css + legal.css). 외부 실행 스크립트 없음"
    - "푸시 전 점검 5번 항목이 출력 HTML의 cdn.tailwindcss.com·tailwind.config를 막는다 (재유입 차단)"

key-files:
  created:
    - .planning/phases/03-tailwind-cdn-removal/03-04-SUMMARY.md
  modified:
    - _layouts/legal.html
    - scripts/check-site.sh
    - .planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md

key-decisions:
  - "커밋 ③ 판정이 처음 후보에서 통과해 legal.css 고침 커밋(CSS_FIX_SHA)이 없다. Preflight 없이도 정적 CSS만으로 기준과 픽셀 0"
  - "5번 항목은 ③ 뒤 별도 커밋(build)으로 넣었다. ①·② 시점 점검은 그 커밋 안의 스크립트로 돌린다 (RESEARCH Pitfall 4)"
  - "README·CLAUDE.md·.planning/codebase의 「네 가지」·Tailwind 설명은 이 계획에서 고치지 않았다. 03-07(코드베이스 맵)·03-08(CLAUDE.md·README) 몫이다"

patterns-established:
  - "verify의 git show <커밋>:scripts/check-site.sh 임시 파일은 mktemp+rm 대신 스크래치패드의 고정 경로에 덮어써서 돌린다 (rm 안전 검사 회피가 아니라 삭제 자체가 필요 없게 함)"

requirements-completed: [SHELL-04]

coverage:
  - id: D1
    description: "사이트 커밋 ③: 레이아웃에서 Tailwind script·설정 제거, 커밋은 레이아웃만 바꿈, head-links·legal.css include 줄 유지, 트리 = $W/c3/TREE"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-04-PLAN.md Task 1 <verify> 첫 명령 (bash, exit 0)"
        status: pass
      - kind: other
        ref: "커밋 ③ 시점 scripts/check-site.sh c49e12a50394 → check-site: 통과"
        status: pass
    human_judgment: false
  - id: D2
    description: "커밋 ③ 빌드 출력 HTML에 Tailwind 0건(기준은 3건), 브라우저 요청 Tailwind 0건, base1과 PNG 42장·txt 18건 차이 0, hover·focus 24장 유효, 랜딩 바이트 동일, _site 파일 목록 동일"
    requirement: "SHELL-04"
    verification:
      - kind: automated_ui
        ref: "\"$W/judge.sh\" c3 --no-cdn → JUDGE c3 OK (PASS 0 diffs, STATES c3 ok=24 vacuous=0, PASS 18 rows)"
        status: pass
      - kind: other
        ref: "03-04-PLAN.md Task 1 <verify> 두 번째 명령 (bash, exit 0)"
        status: pass
    human_judgment: false
  - id: D3
    description: "check-site 5번 항목: 새 스크립트가 커밋 ③·점검 커밋을 통과시키고 커밋 ②를 Tailwind 메시지와 세 문서 경로로 실패시킴. 사이트 출력 불변, pre-push 훅 그대로, 훅 경로로 통과, bash 3.2 문법"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-04-PLAN.md Task 2 <verify> 두 명령 (bash, exit 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 4min
completed: 2026-11-16
status: complete
---

# Phase 3 Plan 04: Tailwind Play CDN 제거(커밋 ③)와 재유입 점검 Summary

**법적 레이아웃에서 Tailwind Play CDN script와 설정 블록을 지운 사이트 커밋 ③ `c49e12a50394`가 정적 CSS(legal.css)만으로 기준과 PNG 42장 픽셀 0, HTML·네트워크 Tailwind 0건이었고, 이어 별도 커밋 `69f46942bec6`으로 check-site에 「Tailwind Play CDN 없음」 5번 항목을 더해 커밋 ②로 실제로 실패하는 것을 확인했다**

## Performance

- **Duration:** 4 min
- **Started:** 2026-11-16T16:18:54Z
- **Completed:** 2026-11-16T16:22:41Z
- **Tasks:** 2 (Task 1 tracer, Task 2 auto)
- **Files modified:** 사이트 쪽 2개 (`_layouts/legal.html`, `scripts/check-site.sh`) + 기록 `03-EVIDENCE.md`

## Accomplishments

- `_layouts/legal.html`의 14행 `<script src="https://cdn.tailwindcss.com">`와 16-30행 `<script id="tailwind-config">` 블록만 지웠다(16줄 삭제, 더한 줄 0). 결과 모양이 RESEARCH 488-494행과 같다
- 후보 커밋(`4cd7d8955092`)으로 check-site 통과, `$W/c3` 빌드, 출력 HTML Tailwind 0개 파일(기준 3개 파일), 랜딩 `index.html` 바이트 동일, `_site` 파일 목록 동일, `diff -r c2 c3`이 삭제 16줄×3만, 캡처(4105)와 `judge.sh c3 --no-cdn` → `JUDGE c3 OK`를 모두 확인한 뒤 같은 인덱스를 커밋 ③으로 남겼다. 트리 = `$W/c3/TREE`
- 트레이서 게이트: 커밋 ③과 기록 뒤 Task 1 verify 두 명령을 다시 돌려 exit 0을 확인하고 나서 점검 스크립트를 고쳤다
- `scripts/check-site.sh`에 5번 항목(RESEARCH 533-538행 원안)과 머리 주석 「다섯 가지」를 더했다. 후보(`96b8e62a651b`)로 (a) 새 스크립트 통과, (b) 커밋 ② 음성 대조 실패(Tailwind 메시지 + 세 문서 경로, exit 1), (c) 사이트 출력 불변(`diff -r c3 ck5` 빈 출력), (d) pre-push 훅 경로 통과, (e) 훅 파일 그대로를 확인한 뒤 커밋했다. 트리 = `$W/ck5/TREE`

## Task Commits

1. **Task 1: 레이아웃에서 Tailwind script·설정 제거, 후보 판정 뒤 커밋 ③ (tracer)** - `c49e12a` (refactor)
2. **Task 2: check-site 5번 항목 「Tailwind Play CDN 없음」 별도 커밋, 커밋 ② 음성 대조** - `69f4694` (build)

**Plan metadata:** docs 커밋 하나 (SUMMARY + EVIDENCE + STATE + ROADMAP)

## Files Created/Modified

- `_layouts/legal.html` - Tailwind Play CDN script 한 줄과 `tailwind-config` 설정 블록 삭제
- `scripts/check-site.sh` - 머리 주석 「다섯 가지」와 5번 줄, `# ── 5. Tailwind Play CDN 없음 ──` 구획(grep 한 줄 + problem 한 줄)
- `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md` - `## 03-04 커밋 ③`(`C3_SHA`, `OK site tailwind=0`, `judge.sh c3 --no-cdn` 전체, `C3_PIXEL=OK`), `## 03-04 check-site 5번 항목`(`CHECK5_SHA`, 통과 줄, 음성 대조 출력, 훅 경로, `CHECK5=OK`)
- 저장소 밖 `$W`(커밋 안 함): `c3/`, `ck5/`, `cap/c3`, `judge-c3.out`, `ck5-*.out`

## Decisions Made

- 커밋 메시지는 계획이 정한 제목 그대로 썼다(③ `refactor(03-04)`, 점검 `build(03-04)`)
- check-site 기록은 03-02·03-03과 같은 방식: 코드 블록에는 커밋 뒤 그 커밋 시점 스크립트로 다시 돌린 줄, 후보 결과는 산문으로 적었다
- 「네 가지」를 적은 문서들(README, CLAUDE.md, `.planning/codebase/CONVENTIONS.md`·`TESTING.md`)은 계획 범위 밖이라 그대로 두었다. 03-07·03-08이 고친다

## Deviations from Plan

None - plan executed exactly as written.

(실행 방식 메모: verify 두 번째 명령의 `mktemp` + `rm -f "$T"`를 Bash 도구의 rm 안전 검사가 막아, 같은 논리를 스크래치패드의 고정 경로 임시 파일로 돌렸다. 판정 내용은 같다.)

## Issues Encountered

- 정적 확인 묶음의 마지막 `grep -c`가 0을 세어 셸이 1로 끝났다. 확인 결과 자체는 모두 기대대로였다(판정 영향 없음)
- 판정은 처음 후보에서 바로 통과해 legal.css 고침 절차와 checkpoint가 필요 없었다

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 03-05로 넘어갈 수 있다. 로컬 `main`은 ①·②·③·점검 커밋이 원격보다 앞서 있다. 푸시하지 않았다(푸시는 03-06에서 사람 승인 뒤)
- pre-push 훅은 작업 트리의 새 스크립트로 끝 커밋만 점검하므로 ①~③과 점검 커밋을 한 번에 푸시해도 통과한다. 03-06의 되돌림 경로는 점검 커밋도 함께 되돌려야 한다(03-06 계획에 이미 적혀 있음)

## Self-Check: PASSED

- FOUND: `_layouts/legal.html`, `scripts/check-site.sh`, `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md`
- FOUND: `c49e12a50394` (HEAD의 조상, 트리 = `$W/c3/TREE`), `69f46942bec6` (HEAD, 트리 = `$W/ck5/TREE`)
- Task 1 verify 2/2, Task 2 verify 2/2 exit 0 (bash). acceptance: 레이아웃 Tailwind 문자열 0, 5번 구획 1, 「네 가지」 0
- 기록 누출 검사: EVIDENCE·SUMMARY에 홈 경로와 임시 폴더 실제 경로 없음 (docs 커밋 직전 grep으로 확인)
- verify 네 명령은 최종 HEAD에서 다시 돌려 모두 exit 0
- 요구사항: SHELL-04는 03-05~03-09도 선언하므로 공유 ID 규칙(#2388)에 따라 `REQUIREMENTS.md`에서 아직 체크하지 않았다. 마지막 선언 계획이 끝날 때 체크한다

---
*Phase: 03-tailwind-cdn-removal*
*Completed: 2026-11-16*
