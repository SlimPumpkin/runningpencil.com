---
phase: 03-tailwind-cdn-removal
plan: 05
subsystem: ui
tags: [legal-pages, legal-css, table, sample-body, pixel-diff, user-approval]

# Dependency graph
requires:
  - phase: 03-tailwind-cdn-removal
    provides: "03-01: 판정 도구(lib.sh·judge.sh·pw의 sample.mjs), 기준 캡처 $W/cap/base1 / 03-02: legal.css(.rp-doc 범위 표·목록·주석 규칙) / 03-04: 커밋 ③ C3_SHA=c49e12a50394, 점검 커밋 CHECK5_SHA=69f46942bec6"
provides:
  - "성공 기준 4 판정: 클래스 없는 시험 본문(넓은·좁은 표 figure 감싸개, aside, h3, 중첩 ol·ul, dl, 끝 footer)이 두 엔진 × 375·768·1280에서 sample.mjs PASS (SAMPLE=OK), 사용자 캡처 승인 (SC4_DECISION=approved)"
  - "표 머리 행 줄바꿈 정책 TABLE_WRAP=nowrap — 사이트 푸시 후보(03-06)보다 먼저 확정"
  - "사이트 커밋 NOWRAP_SHA=fb6bdfa40b70: .rp-doc th에 white-space: nowrap 한 줄. 기준과 PNG 42장 픽셀 0(--no-cdn), 시험 본문 PASS (NOWRAP_PIXEL=OK)"
affects: [03-06, 03-07, 03-08, 03-09, 05, 07, 09]

# Actuals (#2632)
actuals:
  tokens: 3500     # chars/4: legal.css diff + 03-EVIDENCE.md 추가분(03-05 세 구간) (SUMMARY 제외)
  tasks: 3
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (nowrap 사이트 커밋). 기록은 아래 docs 커밋으로 들어간다
plan_head_before: 50bbda231725a1a04c915cedceb9c515566aaf8b
plan_head_after: fb6bdfa40b7005f152ed7a500deae427380788cf

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "법적 본문 표의 머리 행(th)은 줄바꿈하지 않는다. 좁은 화면에서 넘치는 폭은 figure 안 가로 스크롤과 가장자리 그림자로 보인다"
    - "새 요소 모양은 클래스 없는 스크래치 시험 본문으로 자동 확인(sample.mjs)과 사용자 캡처 승인을 받은 뒤 확정한다. 시험 본문은 저장소에 넣지 않는다"

key-files:
  created:
    - .planning/phases/03-tailwind-cdn-removal/03-05-SUMMARY.md
  modified:
    - _includes/css/legal.css
    - .planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md

key-decisions:
  - "사용자가 시험 본문 모양을 승인하고 표 머리 행 정책으로 nowrap을 골랐다 (D-19). 이 답은 사이트 푸시 승인이 아니다"
  - "nowrap은 legal.css 한 줄만 바꾼 별도 사이트 커밋(feat(03-05))으로 넣었다. 후보로 check-site·빌드·랜딩 동일·CSS 한 줄 diff·JUDGE nw OK·시험 본문 PASS를 모두 통과한 뒤 같은 인덱스를 커밋했다"
  - "후보 시험 본문 재빌드는 새 스크래치 이름 samplec(포트 4107)으로 했다. Task 1의 $W/sample을 덮어쓰면 Task 1 verify의 TREE 동일 확인이 깨지기 때문이다"

patterns-established:
  - "스크래치 정리 명령의 rm 대상은 \"${W:?}/${N:?}\" 꼴로 쓴다 (변수가 비면 셸이 멈춤)"

requirements-completed: [SHELL-04]

coverage:
  - id: D1
    description: "클래스 없는 시험 본문의 계산된 스타일 자동 확인: 기본·줄바꿈 금지 두 변형 × 두 엔진 × 세 폭 모두 sample.mjs PASS, 캡처 12장, 시험 본문은 저장소에 없음"
    requirement: "SHELL-04"
    verification:
      - kind: automated_ui
        ref: "cd \"$W/pw\" && node sample.mjs http://127.0.0.1:4107/sample/ \"$W/cap/sample\" (및 4108 samplenw) → PASS, exit 0"
        status: pass
      - kind: other
        ref: "03-05-PLAN.md Task 1 <verify> 두 명령 (bash, exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "시험 본문 모양(표·목록·주석·제목)이 카드 디자인에 맞게 보인다는 사용자 승인과 표 머리 행 정책 선택"
    requirement: "SHELL-04"
    verification:
      - kind: manual_procedural
        ref: "03-05 Task 2 checkpoint:decision (gate=blocking-human) → 사용자 답 nowrap, EVIDENCE SC4_DECISION=approved·TABLE_WRAP=nowrap"
        status: pass
    human_judgment: true
    rationale: "새 요소의 시각적 적합성은 사용자 눈으로 판정하는 성공 기준(D-19)이다. 승인은 이미 받았고 기록에 있다"
  - id: D3
    description: "nowrap 사이트 커밋 fb6bdfa40b70: legal.css 한 줄만 바꿈, 트리 = $W/nw/TREE, check-site 통과, 랜딩·파일 목록 동일, base1과 픽셀 0(--no-cdn), 후보 빌드 시험 본문 PASS"
    requirement: "SHELL-04"
    verification:
      - kind: automated_ui
        ref: "\"$W/judge.sh\" nw --no-cdn → JUDGE nw OK (PASS 0 diffs, STATES nw ok=24 vacuous=0, PASS 18 rows)"
        status: pass
      - kind: automated_ui
        ref: "cd \"$W/pw\" && node sample.mjs http://127.0.0.1:4107/sample/ \"$W/cap/samplec\" → PASS, exit 0"
        status: pass
      - kind: other
        ref: "scripts/check-site.sh fb6bdfa40b70 → check-site: 통과"
        status: pass
      - kind: other
        ref: "03-05-PLAN.md Task 3 <verify> (bash, exit 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 4min (Task 3 이어받기 구간)
completed: 2026-11-16
status: complete
---

# Phase 3 Plan 05: 시험 본문 승인과 표 머리 행 줄바꿈 금지 Summary

**클래스 없는 시험 본문(표·aside·중첩 목록·dl·footer)이 두 엔진 × 세 폭에서 계산된 스타일 확인을 통과했고 사용자가 캡처를 승인하며 표 머리 행 nowrap을 골랐다. 그 한 줄(`.rp-doc th { … white-space: nowrap; }`)을 별도 사이트 커밋 `fb6bdfa40b70`으로 넣었고, 기준과 PNG 42장 픽셀 0, 시험 본문 PASS를 확인했다**

## Performance

- **Duration:** Task 3 이어받기 구간 약 4분 (Task 1·2는 앞 실행자와 사용자 결정 대기)
- **Started:** 2026-11-16T16:51:03Z (이어받기 시작)
- **Completed:** 2026-11-16T16:54:20Z
- **Tasks:** 3 (Task 1 tracer, Task 2 checkpoint:decision, Task 3 auto)
- **Files modified:** 사이트 쪽 1개 (`_includes/css/legal.css`) + 기록 `03-EVIDENCE.md`

## Accomplishments

- (Task 1, 앞 실행자) 시험 본문 `$W/fixtures/sample.html`을 HEAD `50bbda231725` 트리에 스크래치로만 넣어 기본(`sample`)·줄바꿈 금지(`samplenw`) 두 변형을 빌드했고, 둘 다 `sample.mjs`가 여섯 조합 PASS였다. 캡처 12장. 저장소에는 `sample/`이 없다 (`SAMPLE=OK`)
- (Task 2) 사용자가 캡처를 보고 「nowrap — 승인, 머리 행은 한 줄」을 골랐다 (`SC4_DECISION=approved`, `TABLE_WRAP=nowrap`)
- (Task 3) `legal.css` 38행만 바꿨다. 후보(`d51648b1fff0`)로 (a) check-site 5항목 판 통과, (b) `build nw`, (c) 랜딩 `index.html` 기준과 바이트 동일·파일 목록 동일·`terms` diff가 그 CSS 한 줄뿐, (d) 캡처(4106) 뒤 `judge.sh nw --no-cdn` → `JUDGE nw OK`, (e) 후보로 시험 본문 재빌드(`samplec`) → `sample.mjs` PASS, 캡처 6장이 승인한 `samplenw` 캡처와 바이트 동일을 확인한 뒤 같은 인덱스를 커밋했다. 트리 = `$W/nw/TREE` (`NOWRAP_PIXEL=OK`)

## Task Commits

1. **Task 1: 시험 본문 스크래치 빌드·두 변형 sample.mjs PASS·캡처 12장 (tracer)** - 사이트 커밋 없음 (기록은 docs 커밋)
2. **Task 2: 시험 본문 승인과 표 머리 행 정책 (checkpoint:decision)** - 커밋 없음
3. **Task 3: nowrap 적용** - `fb6bdfa` (feat)

**Plan metadata:** docs 커밋 (SUMMARY + EVIDENCE), 이어서 STATE·ROADMAP 추적 커밋

## Files Created/Modified

- `_includes/css/legal.css` - `.rp-doc th`에 `white-space: nowrap;` (한 줄, 파일 끝 줄바꿈 없음 유지)
- `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md` - `## 03-05 시험 본문`(`SAMPLE=OK`), `## 03-05 시험 본문 승인`(`SC4_DECISION=approved`, `TABLE_WRAP=nowrap`, 사용자 답), `## 03-05 표 머리 행 줄바꿈`(`NOWRAP_SHA`, check-site 줄, 랜딩 동일, CSS diff, `judge.sh nw --no-cdn` 전체, 시험 본문 PASS, `NOWRAP_PIXEL=OK`)
- 저장소 밖 `$W`(커밋 안 함): `fixtures/sample.html`, `sample/`, `samplenw/`, `samplec/`, `nw/`, `cap/sample`·`cap/samplenw`·`cap/samplec`·`cap/nw`, `nw-check.out`, `capture-nw.out`, `judge-nw.out`, `samplec.out`

## Decisions Made

- 커밋 메시지는 계획이 정한 제목 그대로 썼다 (`feat(03-05): 법적 본문 표의 머리 행을 한 줄로 유지 (D-19 선택)`)
- 후보 시험 본문 빌드는 새 이름 `samplec`로 했다. `sample`을 덮어쓰면 Task 1 verify의 `sample/TREE` = `samplenw/TREE` 확인이 깨진다. 포트는 비어 있던 4107을 썼다
- check-site 기록은 03-02~03-04와 같은 방식: 후보 줄과 커밋 뒤 다시 돌린 줄을 함께 적었다

## Deviations from Plan

None - plan executed exactly as written.

(실행 방식 메모: 시험 본문 재빌드 명령의 `rm -rf "$W/$N"`을 Bash 도구의 rm 안전 검사가 막아 `"${W:?}/${N:?}"` 꼴로 다시 썼다. 판정 내용은 같다.)

## Issues Encountered

None - 후보가 처음에 모든 점검을 통과해 고침 절차가 필요 없었다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 03-06(사이트 푸시 후보와 사람 승인)으로 넘어갈 수 있다. 로컬 `main`은 ①·②·③·점검 커밋·nowrap 커밋이 원격보다 앞서 있다. 푸시하지 않았다
- 푸시 후보 끝 커밋은 nowrap 커밋 뒤의 docs 커밋들이다. 사이트 트리는 `fb6bdfa40b70`과 같다 (docs 커밋은 `.planning/`만 바꿈)
- 03-06의 되돌림 경로에는 nowrap 커밋도 들어가야 한다

## Self-Check: PASSED

- FOUND: `_includes/css/legal.css`(th 줄에 nowrap), `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md`, `.planning/phases/03-tailwind-cdn-removal/03-05-SUMMARY.md`
- FOUND: `fb6bdfa40b70` (HEAD, 부모 `50bbda231725`, 트리 = `$W/nw/TREE`, 바뀐 파일은 `_includes/css/legal.css` 하나)
- Task 1 verify 2/2, Task 3 verify 1/1 exit 0 (bash)
- 시험 본문이 저장소에 없음: `git ls-files -- sample`, `git status --porcelain -- sample` 모두 빈 출력
- 기록 누출 검사: EVIDENCE·SUMMARY에 로컬 홈 경로와 임시 폴더 실제 경로 없음 (docs 커밋 직전 grep으로 확인)
- 요구사항: SHELL-04는 03-06~03-09도 선언하므로 공유 ID 규칙(#2388)에 따라 `REQUIREMENTS.md`에서 아직 체크하지 않는다. 마지막 선언 계획이 끝날 때 체크한다

---
*Phase: 03-tailwind-cdn-removal*
*Completed: 2026-11-16*
