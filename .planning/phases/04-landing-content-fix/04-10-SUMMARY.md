---
phase: 04-landing-content-fix
plan: 10
subsystem: content
tags: [site-06, screenshots, webp, scroll-snap, candidate-object, tracer]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "04-09: 스크래치 $W/img/out/ WebP 여섯 개(sha256은 EVIDENCE IMG 줄), ALT·LOGO 줄, 사용자 예외 3(D-18·D-20). 04-02: 스크래치 계약(lib.sh, pw, p4-behave.mjs)"
provides:
  - "판정한 스크린샷 구간 후보 CAND3=56fd3bb79160 (부모 SHOTS_BASE=273022c3f176, index.html + images/app/ WebP 여섯 개, 어떤 ref에도 붙지 않은 커밋 객체)"
  - "04-EVIDENCE.md `## 04-10 스크린샷 구간`: SHOTS_BASE, CAND3, check-site 통과 줄, PASS shots(OK shots 4줄), PASS behave, 의도한 줄만 바뀜 6줄, REVIEW shots 4줄, 후보 확정 4줄, OK worktree restored, SHOTS_OK=OK"
  - "스크래치 $W/pw/p4-shots.mjs (CLI: node p4-shots.mjs <baseURL> <출력 폴더> [query] [--hash-only]), 빌드 $W/sbase·$W/c3, 구간 캡처 $W/cap/c3/ 10장, 후보 해시 $W/cand3.txt"
affects: [04-11]

# Actuals (#2632)
actuals:
  tokens: 2168     # chars/4 over 후보 index.html diff(3941자) + 04-EVIDENCE.md 더한 줄(4734자). SUMMARY 제외. 후보는 브랜치에 없고 작업 트리는 되돌림
  tasks: 2         # tracer 1, auto 1
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). 이 계획은 사이트 커밋이 없고, SUMMARY·EVIDENCE docs 커밋과 STATE 커밋은 이 뒤
plan_head_before: 273022c3f17608f270dd0e1758887e5358f75cbb
plan_head_after: 273022c3f17608f270dd0e1758887e5358f75cbb

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "CSS만으로 만든 가로 띠: 860px 이하에서 `display: flex; overflow-x: auto; scroll-snap-type: x mandatory`, `.rp-wrap` 좌우 여백과 같은 값의 음수 margin·padding·scroll-padding, `tabindex=\"0\"` + `role=\"list\"` + `aria-label`, 그림자용 padding-bottom 64px"
    - "앞 구간 맞물림 잇기: 새 구간에 `position: relative; z-index: 1`과 둥근 아래 모서리를 주어 `#get`의 음수 margin-top이 그 밑으로 들어가게 한다"

key-files:
  created:
    - .planning/phases/04-landing-content-fix/04-10-SUMMARY.md
  modified:
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md

key-decisions:
  - "04-10: 스크린샷 구간 후보 CAND3(56fd3bb79160)는 판정을 모두 통과했지만 커밋하지 않았다. 브랜치에 붙지 않은 객체로만 두고 작업 트리·인덱스를 SHOTS_BASE로 되돌렸다. main에는 04-11에서 사용자가 승인한 뒤에만 들어간다(D-19)"
  - "04-10: 첫 판정에서 두 엔진 × 두 폭 모두 통과해 CSS를 고치지 않았다. 375px 띠 끝 여백 20px(두 엔진 모두 끝 padding이 스크롤 범위에 들어감, A8 걱정 없음), 그림 반경 37px 그대로(NAVER 로고가 둥근 모서리에서 멀어 깎이지 않음)"
  - "04-10: img sizes는 `(max-width: 860px) 242px, 282px`. 1배 화면에서는 두 폭 모두 564w를 고른다"

patterns-established:
  - "캡처를 담은 사이트 변경은 `git commit-tree` 후보 객체로만 판정하고, 승인 전에는 어떤 ref에도 붙이지 않는다. 판정 기록은 EVIDENCE의 CAND 표식과 트리 해시로 남긴다"

requirements-completed: [SITE-06]  # PLAN requirements를 그대로 옮김. REQUIREMENTS.md 체크는 requirements.ready-ids가 SITE-06을 blocked로 내어(04-11~04-13도 선언) Pending으로 둠

coverage:
  - id: D1
    description: "「실제 앱 화면」 구간 후보(제목 옆 「출시 준비 중」 딱지, 폰 테두리 속 캡처 세 장과 캡션, 「지도 © NAVER Corp.」, #get 맞물림, 1280 한 줄·375 가로 밀기, 페이지 가로 밀림 없음)가 Chromium·WebKit × 1280·375 판정 (a)~(l)을 통과"
    requirement: "SITE-06"
    verification:
      - kind: automated_ui
        ref: "04-10-PLAN.md Task 1 <automated> (exit 0, PASS shots, OK shots 4줄, check-site 통과 56fd3bb79160)"
        status: pass
    human_judgment: false
  - id: D2
    description: "기존 동작(성공 기준 3)이 후보에서 그대로이고, 후보는 SHOTS_BASE 대비 index.html(지운 줄 1)과 WebP 여섯 개만 바꾸며 스크립트 블록·include·법적 3종이 그대로"
    requirement: "SITE-06"
    verification:
      - kind: automated_ui
        ref: "04-10-PLAN.md Task 2 <automated> (exit 0, PASS behave 6문맥, OK index deleted=1, OK script blocks same)"
        status: pass
    human_judgment: false
  - id: D3
    description: "구간 화면 검토: 캡처가 테두리 안에 잘림 없이 보이고 NAVER 로고가 둥근 모서리에 깎이지 않으며(badge는 원본 예외보다 더 깎이지 않음), 딱지·캡션이 캡처를 덮지 않고, 노랑 맞물림이 자연스러움"
    requirement: "SITE-06"
    verification:
      - kind: other
        ref: "04-EVIDENCE.md REVIEW shots 4줄 (Claude가 $W/cap/c3/ 10장을 직접 봄)"
        status: pass
    human_judgment: true
    rationale: "로고가 온전한지, 맞물림 모양이 자연스러운지는 이미지 내용과 디자인 판단이다. 04-11 푸시 승인 때 사용자가 구간 화면을 직접 본다(Task 2 human-check)"
  - id: D4
    description: "후보 CAND3가 어떤 브랜치·태그·원격 추적 ref에도 없고, 작업 트리·인덱스가 SHOTS_BASE로 돌아가 images/가 없음"
    verification:
      - kind: other
        ref: "git for-each-ref --contains 56fd3bb79160 빈 출력, git ls-files -- images 빈 출력, git diff --quiet 273022c3f176 HEAD -- . ':(exclude).planning'"
        status: pass
    human_judgment: false

# Metrics
duration: 10min
completed: 2026-11-18
---

# Phase 4 Plan 10: 스크린샷 구간 후보 판정 Summary

**스크린샷 구간은 아직 커밋도 푸시도 하지 않았다. 판정한 후보 `CAND3`는 브랜치에 붙지 않은 객체로만 있고, 04-11에서 사용자가 승인한 뒤에만 main에 들어간다.**

`#demo`와 `#get` 사이에 「실제 앱 화면」 구간(제목 옆 「출시 준비 중」 딱지, `#1F1B13` 폰 테두리 속 WebP 캡처 세 장과 캡션, 「지도 © NAVER Corp.」)을 넣은 후보 `CAND3=56fd3bb79160`을 만들었다. 1280px은 한 줄 세 장, 375px은 CSS `scroll-snap` 가로 띠로, Chromium·WebKit 두 엔진에서 구간 판정과 기존 동작 판정을 모두 통과했다.

## Performance

- **Duration:** 약 10분 (계획·참고 문서 읽기 포함)
- **Started:** 2026-11-18T05:57Z (첫 사이트 작업 기록 06:01:52Z)
- **Completed:** 2026-11-18T06:08Z
- **Tasks:** 2 (tracer 1, auto 1)
- **Files modified:** 저장소 커밋 기준 2 (`04-EVIDENCE.md`, 이 SUMMARY). 후보 객체 안에서는 `index.html`과 `images/app/` WebP 여섯 개

## Accomplishments

- 새 기준 `SHOTS_BASE=273022c3f176`에서 기존 동작 `PASS behave`, 해시 정착 기준값 chromium -0.3px·webkit -0.4px을 쟀다
- 판정 스크립트 `$W/pw/p4-shots.mjs`(판정 (a)~(l), `--hash-only`)를 쓰고, 후보에서 `PASS shots`를 받았다. 출처 줄과 `#get` 위 끝 사이 거리는 1280에서 38.4px, 375에서 28px. 375 띠는 → 키로 276px 밀리고 끝 여백 20px
- 후보에서 `p4-behave.mjs` `PASS behave`(6문맥 모두 `badges=7 stickers=6 empty=0`)
- 의도한 줄만 바뀜: `index.html` 38줄 더함·1줄 지움(`.rp-get` 주석), 스크립트 블록 바이트 같음, 새 hex 없음, 법적 3종 출력 같음, 출력 목록은 기준 + WebP 여섯 개, include·레이아웃·점검 스크립트 그대로
- 구간 캡처 10장(`*-screens` 4, `*-seam` 4, `*-375-end` 2)을 직접 보고 `REVIEW shots` 4줄 OK
- 후보는 어떤 ref에도 없고(`OK candidate on no ref`), 작업 트리·인덱스를 되돌렸다(`OK worktree restored`). `SHOTS_OK=OK`

## Task Commits

이 계획은 task별 커밋을 만들지 않는다(계획 context: 캡처를 담은 커밋은 승인 전 어떤 브랜치에도 두지 않음, D-19).

1. **Task 1: 후보 구간 판정 (tracer)** - 커밋 없음. 판정 후보 객체 `56fd3bb79160`
2. **Task 2: 기존 동작·의도한 줄만·화면 검토, 후보 확정과 되돌림** - 커밋 없음

**Plan metadata:** `e1716ea` (SUMMARY·EVIDENCE docs 커밋), `a96f0f9` (STATE·ROADMAP), 그 뒤 해시 정착 (k) 다시 재기와 이 SUMMARY 고침을 담은 docs 커밋 하나. 사이트 커밋은 없다

## Files Created/Modified

- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` - `## 04-10 스크린샷 구간` 판정 기록 추가
- `.planning/phases/04-landing-content-fix/04-10-SUMMARY.md` - 이 요약

후보 객체 `CAND3` 안의 사이트 변경(작업 트리에는 없음): `index.html`(「랜딩 전용」 CSS 8규칙 + 860px 블록 2규칙, `<!-- App screens -->` 구간 마크업, `.rp-get` 주석 글 수정), `images/app/screen-{draw,run,badge}-{564,846}.webp`.

## Decisions Made

- 첫 판정이 모두 통과해 계획의 CSS 값을 그대로 썼다. D-12 테두리 값과 그림 반경 37px 모두 바꾸지 않았다
- `sizes`는 계획대로 `(max-width: 860px) 242px, 282px`로 두었다
- 판정 스크립트에 `OK hash`·`OK strip` 정보 줄을 더해 해시 정착 값과 띠 밀림·끝 여백을 기록에 남겼다(판정 항목은 계획과 같음)

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] 해시 정착 (k)를 새로 연 문서에서 다시 잼**
- **Found during:** 계획 마무리 검토 (Task 1 판정 스크립트)
- **Issue:** `p4-shots.mjs` 기본 모드의 (k)는 `/`를 판정한 같은 페이지에서 `/#get`으로 옮겨 재므로 문서를 새로 열지 않는다(조각만 다른 같은 문서 이동, 이미지는 이미 받아진 상태). 계획의 「`/#get`으로 열어 load 뒤」 조건과 다르다
- **Fix:** 스크립트는 그대로 두고, 같은 c3 빌드에서 새 문맥을 여는 `--hash-only` 모드로 다시 쟀다. chromium -0.4px, webkit 0.5px로 ±2px 안, 기준과 같은 수준이라 판정은 바뀌지 않음
- **Files modified:** `04-EVIDENCE.md` (04-10 구간 끝에 다시 잰 출력 추가), 이 SUMMARY
- **Verification:** `PASS shots` (hash-only, 두 엔진). Task 1·2 verify 다시 실행 exit 0
- **Committed in:** 마지막 docs 커밋 (`--amend` 없이 새 커밋)

**2. [Rule 1 - Bug] `requirements-completed`를 PLAN 값 그대로 `[SITE-06]`으로 고침**
- **Found during:** 계획 마무리 검토
- **Issue:** 처음 SUMMARY에 `[]`로 적었으나 execute-plan 규칙은 PLAN `requirements`를 그대로 옮기라고 한다(04-09도 `[SITE-06]`)
- **Fix:** `[SITE-06]`으로 고침. REQUIREMENTS.md 체크는 그대로 Pending(`requirements.ready-ids`가 blocked)
- **Committed in:** 마지막 docs 커밋

---

**Total deviations:** 2 auto-fixed (Rule 1 둘). **Impact on plan:** 판정 결과와 사이트 후보는 바뀌지 않았다. 기록만 보강했다.

## Issues Encountered

None. 04-EVIDENCE.md의 04-09 구간(앞 계획)에는 루프백 주소가 두 줄 있다. 이 계획 구간에는 없고, 계획 verification의 누출 검사 대상(`$HOME`, `/private/var`, `/Users/`)도 파일 전체에 없다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 04-11은 `CAND3=56fd3bb79160`의 사이트 트리(`index.html`, `images/app/`)를 그때의 HEAD 위에 스크린샷 구간 커밋으로 세우고, 사용자 승인 뒤 푸시한다
- `CAND3`는 어떤 ref에도 닿지 않아 오래 지나면 git gc로 사라질 수 있다. 그 전에 04-11을 진행하는 것이 좋다. 사라지면 04-10 다시 하기(`<redo_shots_procedure>`)를 따른다
- 스크래치 `$W/cap/c3/`의 `chromium-1280-screens.png`, `webkit-375-screens.png`, `webkit-375-end.png`, `chromium-1280-seam.png`가 단계 끝 사람 확인 대상이다

---
*Phase: 04-landing-content-fix*
*Completed: 2026-11-18*

## Self-Check: PASSED

- FOUND: `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` (SHOTS_BASE, CAND3, SHOTS_OK=OK)
- FOUND: 후보 객체 `56fd3bb79160` (`git cat-file -t` = commit, 어떤 ref에도 없음)
- Task 1·Task 2 verify 명령 재실행 exit 0 (마지막 docs 커밋 뒤에도 다시 실행)
- 해시 정착 (k) 새 문맥 재측정 `PASS shots`
