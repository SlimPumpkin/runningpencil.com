---
phase: 03-tailwind-cdn-removal
plan: 02
subsystem: ui
tags: [css, jekyll-include, tailwind-cdn, preflight, pixel-diff, legal-pages]

# Dependency graph
requires:
  - phase: 03-tailwind-cdn-removal
    provides: "03-01: BASE_SHA=8b65fdb59232, TW_CDN_VERSION=3.4.17, 스크래치 판정 도구(lib.sh·judge.sh·pw), 기준 캡처 $W/cap/base1"
provides:
  - "_includes/css/legal.css: 토큰 :root(--rp-ink·--rp-accent·--rp-muted·--rp-muted-2·--rp-line), Preflight 대체, rp-legal-* 껍데기, .rp-doc 본문 규칙, 본문 작성 규칙 머리 주석(D-25)"
  - "_layouts/legal.html: <style> 안 0열 include 한 줄로 legal.css 인라인, 카드 껍데기 클래스 rp-legal-wrap·rp-legal-card·rp-legal-eyebrow·rp-legal-title·rp-legal-updated·rp-doc (Tailwind script·설정은 아직 남음)"
  - "사이트 커밋 ① C1_SHA=7cd2b6128884: base1과 PNG 42장·txt 18건 차이 0, hover·focus 24장 유효 (C1_PIXEL=OK)"
  - "③ 미리보기(① 출력에서 Tailwind 두 블록 삭제 + 끝 안내 footer 치환)도 base1과 픽셀 0 (C1_PREVIEW3=OK). legal.css 고침 커밋 없음"
affects: [03-03, 03-04, 03-05, 03-06]

# Actuals (#2632)
actuals:
  tokens: 3037     # chars/4: legal.css 전체 + legal.html diff + 03-EVIDENCE.md 추가분 (SUMMARY 제외)
  tasks: 2
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (사이트 커밋 ①). 기록은 아래 docs 커밋 하나로 들어간다
plan_head_before: fc16e3d615b608f42ce9359637bba9c39eb809cd
plan_head_after: 7cd2b61288841eda710ac656c12175dd4ab23fc3

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "법적 페이지 CSS는 _includes/css/legal.css 한 곳. 레이아웃 <style>에서 common.css 다음에 0열 include, 끝 줄바꿈 없음"
    - "토큰은 :root CSS 변수로 한 번만 정의하고 본문 규칙은 모두 .rp-doc 아래 선택자로 쓴다 (맨 요소 선택자 금지)"
    - "사이트 커밋은 commit-tree 후보로 빌드·캡처·판정을 먼저 통과시킨 뒤 같은 인덱스를 커밋한다"

key-files:
  created:
    - _includes/css/legal.css
    - .planning/phases/03-tailwind-cdn-removal/03-02-SUMMARY.md
  modified:
    - _layouts/legal.html
    - .planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md

key-decisions:
  - "legal.css는 RESEARCH 원안(441-478행)을 줄 단위 그대로 옮기고, .rp-doc figure 규칙 위에 흰 덮개·그림자 색 주석 한 줄만 더했다"
  - "껍데기 클래스 교체는 커밋 ①에서 했다. ①은 Preflight가 있는 상태, ③ 미리보기는 Preflight가 없는 상태에서 각각 픽셀 0"
  - "③ 미리보기가 통과해 legal.css 고침 커밋(CSS_FIX_SHA)이 없다. 03-03의 미리보기 출처는 c1(C1_SHA)이다"

patterns-established:
  - "EVIDENCE의 check-site 줄은 최종 커밋으로 다시 돌린 결과를 붙이고, 후보 해시로 돌린 결과는 산문으로 함께 적는다"
  - "판정 출력은 파일로 받아 EVIDENCE에 붙이고, 붙인 블록이 원본과 바이트가 같은지 cmp로 확인한다"

requirements-completed: [SHELL-04]

coverage:
  - id: D1
    description: "_includes/css/legal.css(토큰 :root 한 번, Preflight 대체, rp-legal-* 껍데기, .rp-doc 본문 규칙, 머리 주석)와 레이아웃 include·껍데기 교체가 든 사이트 커밋 ①. 랜딩 index.html·common.css 불변"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-02-PLAN.md Task 1 <verify> 세 명령 (bash, exit 0)"
        status: pass
      - kind: other
        ref: "scripts/check-site.sh 7cd2b6128884 → check-site: 통과"
        status: pass
    human_judgment: false
  - id: D2
    description: "커밋 ① 빌드가 base1과 PNG 42장·txt 18건 픽셀·텍스트 차이 0, hover·focus 24장 유효, 링크 계산값·높이 18행 일치"
    requirement: "SHELL-04"
    verification:
      - kind: automated_ui
        ref: "\"$W/judge.sh\" c1 → JUDGE c1 OK (PASS 0 diffs, STATES c1 ok=24 vacuous=0, PASS 18 rows)"
        status: pass
    human_judgment: false
  - id: D3
    description: "③ 미리보기(① 출력에서 Tailwind script·설정 삭제 + 끝 안내 footer 치환)가 Tailwind 없이 base1과 픽셀 0. Preflight 대체 규칙 확인"
    requirement: "SHELL-04"
    verification:
      - kind: automated_ui
        ref: "\"$W/judge.sh\" c1p --no-cdn → JUDGE c1p OK (PASS 0 diffs, STATES c1p ok=24 vacuous=0, PASS 18 rows)"
        status: pass
      - kind: other
        ref: "03-02-PLAN.md Task 2 <verify> 두 명령 (bash, exit 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 11min
completed: 2026-11-16
status: complete
---

# Phase 3 Plan 02: 정적 CSS legal.css와 커밋 ① Summary

**`_includes/css/legal.css`(토큰 CSS 변수 5개, Preflight 대체, `rp-legal-*` 껍데기, `.rp-doc` 본문 규칙)를 레이아웃 `<style>`에 include한 사이트 커밋 ① `7cd2b6128884`가 Tailwind가 있는 상태에서 base1과 픽셀 0이었고, Tailwind를 뺀 ③ 미리보기도 픽셀 0이었다**

## Performance

- **Duration:** 11 min
- **Started:** 2026-11-16T15:27:25Z
- **Completed:** 2026-11-16T15:38:30Z
- **Tasks:** 2 (Task 1 tracer, Task 2 auto)
- **Files modified:** 2 사이트 파일 (`_includes/css/legal.css` 새로 만듦, `_layouts/legal.html`) + 기록 `03-EVIDENCE.md`

## Accomplishments

- `_includes/css/legal.css` 새 파일 (39줄, 끝 줄바꿈 없음, Liquid 구분자 없음). 머리 주석에 본문 허용 요소 목록과 「표는 모두 `figure tabindex="0" aria-label`로 감쌈」 규칙(D-25, D-04, D-07). 토큰 다섯 개는 `:root` 한 곳. 본문 규칙은 모두 `.rp-doc` 범위(D-02~D-12)
- `_layouts/legal.html`: 「법적 페이지 전용」 묶음(`body`·`main`·`.rp-grid`)을 legal.css로 옮기고 `{% include css/legal.css %}` 한 줄로 인라인. 카드 껍데기 클래스를 `rp-legal-*`·`rp-doc`으로 교체. Tailwind script·설정·`{%- if %}` 줄·`{{ content | rstrip }}`·include는 바이트 그대로
- 후보 커밋으로 check-site 통과, CDN `/3.4.17`, 출력 표식(rp-legal-card, `--rp-ink: #2B2B2B`, Tailwind script), 랜딩 `index.html` 바이트 동일, `_site` 파일 목록 동일, `JUDGE c1 OK`를 모두 확인한 뒤 같은 인덱스를 커밋. 커밋 ①의 트리는 `$W/c1/TREE`와 같다
- ③ 미리보기 `$W/c1p`: 세 문서에서 Tailwind 두 블록을 지우고 끝 안내를 `<footer>`로 바꾼 사본(`tailwind=0 footer-swap=3 other-added=0`, `<style>` 출처와 동일)이 `JUDGE c1p OK`(`--no-cdn`, Tailwind 요청 0). Preflight 대체 규칙이 맞음

## Task Commits

1. **Task 1: legal.css와 레이아웃 껍데기, 후보 판정 뒤 커밋 ① (tracer)** - `7cd2b61` (refactor)
2. **Task 2: ③ 미리보기로 Preflight 대체 규칙 확인** - 커밋 없음 (사이트 파일을 고치지 않음. 결과는 `03-EVIDENCE.md`에 기록해 docs 커밋에 넣음)

**Plan metadata:** docs 커밋 하나 (SUMMARY + EVIDENCE + STATE + ROADMAP)

## Files Created/Modified

- `_includes/css/legal.css` - 법적 페이지 전용 CSS (토큰, Preflight 대체, 껍데기, 본문 규칙, 작성 규칙 주석)
- `_layouts/legal.html` - legal.css include, `rp-legal-*`·`rp-doc` 껍데기 클래스 (Tailwind는 아직 남음)
- `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md` - `## 03-02 커밋 ①`(`C1_SHA`, `C1_PIXEL=OK`), `## 03-02 ③ 미리보기`(`C1_PREVIEW3=OK`) 구간
- 저장소 밖 `$W`(커밋 안 함): `c1/`, `c1p/`, `cap/c1`, `cap/c1p`

## Decisions Made

- legal.css에 원안 밖으로 더한 것은 계획이 지시한 주석 한 줄뿐이다: 흰 덮개 `#fff`는 카드 바탕과 같아야 하고, 그림자 색 `rgb(43 43 43 / 0.16)`은 `ink`에 투명도만 준 값이며, 표 칸에 바탕색을 주면 그림자가 가려진다
- check-site 기록: 후보(`51be8d327393`)와 커밋 ① 둘 다 통과했다. EVIDENCE 코드 블록 첫 줄은 커밋 ①로 다시 돌린 결과이고, 후보 결과는 산문으로 적었다(verify 3번이 커밋 ① 해시가 든 통과 줄을 다시 확인함)
- ③ 미리보기 치환은 perl 한 번에 세 패턴(script 줄, 설정 블록 최소 일치, 끝 안내 `p`→`footer`)으로 했다. 세 문서 모두 여는 태그·글·닫는 태그가 다른 줄이라 더해진 줄은 `<footer>`·`</footer>`뿐이다

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None. 판정은 처음 후보에서 바로 통과해 legal.css 고침 절차와 checkpoint가 필요 없었다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 03-03(커밋 ②: 본문 3종 클래스 제거와 끝 안내 `footer` 치환)을 바로 시작할 수 있다. ③ 미리보기 출처 규칙상 `CSS_FIX_SHA`가 없으므로 출처는 `c1`이다
- 푸시하지 않았다. 로컬 `main`은 원격보다 앞서 있고, 푸시는 03-06에서 사람 승인 뒤에 한다

## Self-Check: PASSED

- FOUND: `_includes/css/legal.css`, `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md`
- FOUND: `7cd2b61` (HEAD의 조상)
- Task 1 verify 3/3, Task 2 verify 2/2 exit 0. acceptance: include 0열 1줄, `rp-legal-card` 1, ①의 Tailwind script 1줄
- 기록 누출 검사: EVIDENCE·SUMMARY에 홈 경로와 임시 폴더 실제 경로 없음 (docs 커밋 직전 grep으로 다시 확인)

---
*Phase: 03-tailwind-cdn-removal*
*Completed: 2026-11-16*
