---
phase: 03-tailwind-cdn-removal
plan: 07
subsystem: docs
tags: [codebase-map, conventions, legal-css, generate-claude-md, tracer]

# Dependency graph
requires:
  - phase: 03-tailwind-cdn-removal
    provides: "03-01~03-05: _includes/css/legal.css 정적 CSS(토큰 --rp-*, Preflight 대체, .rp-legal-*, .rp-doc), check-site 5번 항목, TABLE_WRAP=nowrap / 03-06: 사이트 푸시와 LIVE_SITE=OK"
provides:
  - "원본 맵 일곱 개(STACK·CONVENTIONS·ARCHITECTURE·CONCERNS·STRUCTURE·TESTING·INTEGRATIONS)가 정적 CSS 구조를 적고 Tailwind 흔적(script 주소·설정 이름) 0줄 (D-24)"
  - "CONVENTIONS.md 「### 법적 페이지 (정적 CSS `_includes/css/legal.css`)」 절과 「### 법적 본문 작성 규칙 (Phase 6~9가 따름)」 절 (D-01~D-12, figure 감싸개, nowrap 머리 행, grep 검증 문장) (D-25)"
  - "생성기 사본 시험 통과: stack·conventions·architecture 블록 밖 불변, 생성 결과에 legal.css·figure 감싸개 규칙 반영"
  - "EVIDENCE 표식 DOCS_MAPS_SHA=c7b3b3471f30, DOCS_MAPS2_SHA=ec66a3ee9ac5, 결과 줄 OK generator blocks only"
affects: [03-08, 03-09, 06, 07, 08, 09]

# Actuals (#2632)
actuals:
  tokens: 7600     # chars/4: 일곱 맵 diff(+/- 줄)와 03-EVIDENCE.md 추가분 (SUMMARY 제외)
  tasks: 2
  commits: 2       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 커밋 전)
plan_head_before: f78905da344e5e4bb297acc1ce976806ca53f2e0
plan_head_after: ec66a3ee9ac5

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "원본 맵을 고친 뒤 .claude/CLAUDE.md 사본에 generate-claude-md를 돌려 블록 밖 불변·새 규칙 반영을 확인하고, 실제 재생성은 다음 계획(03-08)에서 한다"
    - "생성기는 목록이 아닌 일반 문단을 버리므로, 생성 블록에 꼭 들어가야 할 문장은 목록 항목으로 쓴다"

key-files:
  created: []
  modified:
    - .planning/codebase/STACK.md
    - .planning/codebase/CONVENTIONS.md
    - .planning/codebase/ARCHITECTURE.md
    - .planning/codebase/CONCERNS.md
    - .planning/codebase/STRUCTURE.md
    - .planning/codebase/TESTING.md
    - .planning/codebase/INTEGRATIONS.md
    - .planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md

key-decisions:
  - "법적 본문 작성 규칙은 CONVENTIONS.md 한 절에 모으고, 생성기가 일반 문단을 버리므로 첫 안내 문장도 목록 항목으로 썼다"
  - "범위 없는 선택자 금지는 본문 요소(h2·p·ul·table 등) 규칙에만 건다. legal.css의 body·main·.rp-grid 레이아웃 규칙은 법적 페이지에서만 불리므로 그대로 둔다고 적었다"
  - "토큰 다섯 색은 var(--rp-…)로만 쓰고 새 hex를 늘리지 않는다고 적었다. 원래 있던 #fff·#F5F9FC·#D3E2EF는 hex 그대로라는 사실도 함께 적었다"
  - "중첩 목록 모양은 CSS 그대로 바깥 목록 종류와 상관없이 안쪽 ul은 ○, 안쪽 ol은 가. 나. 다.(영문판 a. b. c.)로 적었다"

patterns-established:
  - "법적 본문 작성 규칙의 기록 위치: CONVENTIONS.md 「법적 본문 작성 규칙」 + legal.css 맨 위 주석 (D-25)"
  - "지난 일은 「Tailwind Play CDN(Phase 3에서 제거)」처럼 쓰고 script 주소·설정 이름은 문서에 남기지 않는다 (흔적 grep 0 유지)"

requirements-completed: [SHELL-04]

coverage:
  - id: D1
    description: "생성 원본 STACK·CONVENTIONS·ARCHITECTURE가 정적 CSS(legal.css, --rp-* 토큰)와 법적 본문 작성 규칙을 적고 Tailwind 흔적이 0이다"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-07-PLAN.md Task 1 verify 첫 명령 (흔적 grep 0, legal.css·--rp-ink·figure 감싸개·768px·「점검 항목은 다섯」·「### 법적 본문 작성 규칙」)"
        status: pass
    human_judgment: false
  - id: D2
    description: "생성기 사본 시험에서 세 블록 밖이 바뀌지 않고 생성 결과에 legal.css와 figure 감싸개 규칙이 들어간다"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-07-PLAN.md Task 1 verify 둘째 명령 (generate-claude-md --output <사본>, awk 블록 밖 비교)"
        status: pass
    human_judgment: false
  - id: D3
    description: "CONCERNS·STRUCTURE·TESTING·INTEGRATIONS가 Tailwind 없는 지금 구조를 적고, 두 문서 커밋이 정해진 맵 파일만 담는다"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-07-PLAN.md Task 2 verify (흔적 grep 0, TESTING 「Tailwind CDN」 0, 다섯 가지, CONCERNS 03-EVIDENCE.md·integrity, DOCS_MAPS_SHA·DOCS_MAPS2_SHA 커밋 파일 목록)"
        status: pass
    human_judgment: false
  - id: D4
    description: "문서 내용이 실제 사이트와 맞다 (D-21 ② 금지: 실제와 다른 구조나 아직 하지 않은 일을 적지 않음)"
    verification: []
    human_judgment: true
    rationale: "문장이 legal.css·legal.html의 실제 내용과 맞는지는 grep이 아니라 읽어서 판정해야 한다. 실행 중 줄 번호와 규칙을 파일과 대조했지만 검증자 확인이 필요하다"

# Metrics
duration: 6min
completed: 2026-11-16
status: complete
---

# Phase 3 Plan 07: 원본 맵 정적 CSS 갱신 Summary

**`.planning/codebase/` 원본 맵 일곱 개에서 Tailwind 설명을 걷어내 정적 CSS `_includes/css/legal.css`(토큰 `--rp-*`, Preflight 대체, `.rp-legal-*`, `.rp-doc`) 구조로 고쳤다. `CONVENTIONS.md`에는 Phase 6~9가 따를 「법적 본문 작성 규칙」(D-01~D-12, `<figure tabindex="0" aria-label="표 이름">`)을 새로 적었다. 생성기 사본 시험으로 이 내용이 `.claude/CLAUDE.md` 생성 블록에 그대로 들어간다는 것도 확인했다.**

## Performance

- **Duration:** 약 6분
- **Started:** 2026-11-16T17:36:49Z
- **Completed:** 2026-11-16T17:42:30Z
- **Tasks:** 2
- **Files modified:** 8 (맵 7 + EVIDENCE)

## Accomplishments

- `STACK.md`: 랜딩과 법적 페이지 모두 프레임워크 없이 직접 쓴 CSS라고 적었다. 법적 페이지 CSS 항목은 legal.css와 토큰 다섯 개로 바꿨고, Tailwind 의존성 항목은 지웠다. check-site 설명을 다섯 항목으로 고치고, 인터넷이 필요한 이유는 글꼴만 남겼다.
- `CONVENTIONS.md`: 점검 항목을 「다섯」으로 고쳤다. 860px(랜딩, `max-width`)와 768px(법적 카드 안쪽 여백, `min-width`) breakpoint를 나눠 적었다. 「법적 페이지 (정적 CSS)」 절과 「법적 본문 작성 규칙」 절을 새로 썼고, 토큰 표는 `--rp-*` 이름으로 바꿨다. head 순서와 Module Design에도 legal.css include를 반영했다.
- `ARCHITECTURE.md`: 토큰(`legal.css:5`), 모눈종이(`:9`), 법적 페이지 CSS 행을 바꾸거나 더했다. 레이아웃 include 줄 번호는 지금 파일 기준(`:14`·`:16`·`:18`·`:23`·`:40`)으로 고쳤다. CDN 의존은 글꼴만 남겼고, 안티패턴은 「법적 본문에 클래스나 범위 없는 선택자 추가」로 바꿨다.
- `CONCERNS.md`: Tailwind 런타임 부채와 렌더 차단 항목을 해소 표시로 바꾸고 근거로 `03-EVIDENCE.md`를 걸었다. SRI 항목에는 Pretendard만 남겼다(`integrity`·CSP 권고 유지). Play CDN 의존성 항목은 지웠다.
- `STRUCTURE.md`·`TESTING.md`·`INTEGRATIONS.md`: 트리와 Key files에 legal.css를 넣고, check-site를 「다섯 가지」로 고쳤다. 외부 의존은 Pretendard만 남겼다.
- 생성기 사본 시험: 수정 전 사본을 생성기에 돌리면 저장소 파일과 바이트가 같았다(기준). 수정 후에는 세 블록 밖이 바뀌지 않았고, 블록 안에 새 규칙이 들어갔다.

## Task Commits

1. **Task 1: 생성 원본 STACK·CONVENTIONS·ARCHITECTURE 갱신 + 생성기 사본 시험 (tracer)** - `c7b3b3471f30` (docs)
2. **Task 2: CONCERNS·STRUCTURE·TESTING·INTEGRATIONS 갱신** - `ec66a3ee9ac5` (docs)

**Plan metadata:** SUMMARY·EVIDENCE docs 커밋, 이어서 STATE·ROADMAP 커밋 (03-06과 같은 순서)

## Files Created/Modified

- `.planning/codebase/STACK.md` - 법적 페이지 CSS를 legal.css로, Tailwind 의존성 삭제, check-site 다섯 항목
- `.planning/codebase/CONVENTIONS.md` - 정적 CSS 절, 법적 본문 작성 규칙 절(D-25), 점검 다섯, breakpoint 구분, 토큰 이름
- `.planning/codebase/ARCHITECTURE.md` - 구성 요소 표, Style 위치, 제약, 안티패턴
- `.planning/codebase/CONCERNS.md` - 해소 표시 두 건, SRI 항목 정리, Play CDN 의존성 삭제
- `.planning/codebase/STRUCTURE.md` - 트리·Key files·토큰 위치
- `.planning/codebase/TESTING.md` - 다섯 가지, 글꼴만 외부 의존
- `.planning/codebase/INTEGRATIONS.md` - Play CDN 항목 삭제
- `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md` - `## 03-07 원본 맵` 구간 (DOCS_MAPS_SHA, DOCS_MAPS2_SHA, OK generator blocks only)

## Decisions Made

- 생성기는 목록이 아닌 일반 문단을 생성 블록에 옮기지 않는다. 그래서 「법적 본문 작성 규칙」 절의 첫 안내 문장을 목록 항목으로 썼다(첫 시험에서 그 문단이 빠지는 것을 보고 고침).
- 범위 없는 선택자 금지는 본문 요소 규칙에만 걸었다. legal.css에는 범위 없는 `body`·`main` 규칙이 실제로 있고, 이 규칙들은 법적 페이지에서만 불리는 레이아웃 규칙이다. 「요소 선택자 일체 금지」로 쓰면 지금 파일과 맞지 않는다.
- 「색은 var()로만」이라고만 쓰지 않았다. legal.css에 원래 있던 hex(`#fff`·`#F5F9FC`·`#D3E2EF`)가 실제로 있으므로, 「토큰 다섯 색은 var()로, 새 hex를 늘리지 않음」으로 썼다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] 계획의 줄 목록에 없던 낡은 문장도 고침**
- **Found during:** Task 1, Task 2
- **Issue:** 계획에 적힌 줄 말고도 지금 사실과 어긋난 문장이 있었다. `STACK.md:13`·`CONVENTIONS.md:57`은 「법적 페이지 전용」이 `_layouts/legal.html`의 `<style>`에 있다고 적고 있었다. `CONVENTIONS.md:15`의 CSS 조각 예는 common.css 하나뿐이었다. `STACK.md`·`ARCHITECTURE.md`(System Overview·구성 요소 표)·`STRUCTURE.md`(트리 주석)의 check-site 항목 나열은 넷이었다. `ARCHITECTURE.md`의 include 줄 번호(`:15`·`:32`·`:42`·`:59`)와 `CONCERNS.md`의 `legal.html:50`·`:15`는 옛 번호였다. `STRUCTURE.md`의 본문 설명은 `<section class="space-y-3">`이었다(지금은 클래스 없음). grep 검증으로는 잡히지 않는 문장들이다.
- **Fix:** 모두 지금 파일 기준으로 고쳤다. legal.css 위치, 다섯째 점검 항목, 줄 번호(`legal.html` `:14`·`:16`·`:18`·`:23`·`:31`·`:34`·`:40`, `legal.css` `:5`·`:9`·`:39`), 클래스 없는 `<section>`을 반영했다.
- **Files modified:** STACK.md, CONVENTIONS.md, ARCHITECTURE.md, CONCERNS.md, STRUCTURE.md
- **Verification:** 각 줄 번호를 `cat -n _layouts/legal.html`, `cat -n _includes/css/legal.css`와 대조했다. 세 법적 문서의 `class=` 개수가 0인지 grep으로 확인했다.
- **Committed in:** `c7b3b3471f30`, `ec66a3ee9ac5` (각 task 커밋)

---

**Total deviations:** 1 auto-fixed (Rule 1)
**Impact on plan:** 계획 범위(일곱 맵) 안의 정확성 보정이다. 커밋이 담는 파일 집합은 계획 그대로이고, 범위가 늘지 않았다.

## Issues Encountered

- 첫 생성기 시험에서 CONVENTIONS의 「법적 본문 작성 규칙」 절 첫 안내 문단(목록이 아닌 문단)이 생성 블록에 들어가지 않았다. 그 문장을 목록 항목으로 바꾼 뒤 다시 시험해 들어가는 것을 확인했다. verify 자체는 두 번 모두 통과했다.

## User Setup Required

None - 외부 서비스 설정 없음.

## Next Phase Readiness

- 03-08: 원본 맵이 준비됐다. 다음 계획은 저장소의 `.claude/CLAUDE.md`를 `generate-claude-md`로 다시 만들고, 루트 `CLAUDE.md`·`README.md`와 두 사본의 방침 구간을 고친다. 사본 시험에서 세 블록 밖이 바뀌지 않는 것을 이미 확인했다.
- 03-09: 문서 푸시(D-21 ②)는 사용자 승인 뒤에 한다. 이 계획은 푸시하지 않았다.
- `.planning/PROJECT.md`는 바꾸지 않았다(단계 전환 갱신 몫).

---
*Phase: 03-tailwind-cdn-removal*
*Completed: 2026-11-16*

## Self-Check: PASSED

- 맵 일곱 개와 `03-EVIDENCE.md` 존재, 커밋 `c7b3b3471f30`·`ec66a3ee9ac5`가 HEAD의 조상
- Task 1 verify 두 명령, Task 2 verify 한 명령 exit 0. 일곱 맵 Tailwind 흔적 0줄
- 두 task 커밋은 `.planning/codebase/` 맵만 담음. `.planning/PROJECT.md`·`CLAUDE.md`·`.claude/CLAUDE.md`·`README.md` 변경 없음
