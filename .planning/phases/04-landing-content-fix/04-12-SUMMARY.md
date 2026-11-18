---
phase: 04-landing-content-fix
plan: 12
subsystem: docs
tags: [site-06, d-24, claude-md, codebase-map, webp, generate-claude-md, tracer]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "04-11: 라이브에 올라간 스크린샷 구간 커밋 C3=95062367dc69(index.html #screens + images/app/ WebP 여섯 개)와 LIVE_PUSH3=OK"
provides:
  - "원본 맵 CONVENTIONS·ARCHITECTURE·STACK이 「실제 앱 화면」 구간(#screens, rp-shots* 클래스), images/app/ WebP 예외와 이미지 규칙, 재생성 도구(sips·cwebp·webpinfo)를 적음 (DOCS_MAPS2_SHA=fa90e3cb8cd1)"
  - "STRUCTURE·INTEGRATIONS가 images/app/ 폴더와 캡처 속 NAVER 지도 출처(구간 아래, 공유 푸터 아님)를 적음 (DOCS_MAPS3_SHA=5c6451b2debf)"
  - "루트 CLAUDE.md의 Pages 표·SVG 예외·구간 설명·지도 출처·Assets images/app/, 다시 생성한 .claude/CLAUDE.md (DOCS_CLAUDE2_SHA=426174db1045)"
  - "04-EVIDENCE.md `## 04-12 문서 (D-24)` 구간 (DOCS_MAPS2_SHA, DOCS_MAPS3_SHA, DOCS_CLAUDE2_SHA, OK generator dry-run images/app in conventions, OK generator blocks only, OK regenerated, OK stale image=0 localpath=0, DOCS2_STALE=OK)"
affects: [04-13]

# Actuals (#2632)
actuals:
  tokens: 11719    # chars/4: 세 문서 커밋의 diff(39226자 → 9806) + 04-EVIDENCE.md 더한 줄(7652자 → 1913). SUMMARY 제외
  tasks: 3         # tracer 1, auto 2
  commits: 3       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). SUMMARY·EVIDENCE docs 커밋과 STATE·ROADMAP 커밋은 이 뒤
plan_head_before: 8b080e3ba2d6710b9764c5be654c321c669cadf5
plan_head_after: 426174db104524c1e3acd8cfd23dba0bc6a2fb1b

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "생성기 원본 맵에 새 규칙을 쓸 때는 최상위 목록 항목이나 표 행으로 쓴다. 들여쓴 하위 항목과 굵은 소제목 줄은 생성 구간에 들어가지 않는다"
    - "원본 맵을 고친 커밋 전에 생성기 사본 시험으로 새 줄이 생성 구간에 모두 들어가는지 보고, .claude/CLAUDE.md 재생성은 루트 CLAUDE.md와 같은 커밋에서 한다"

key-files:
  created:
    - .planning/phases/04-landing-content-fix/04-12-SUMMARY.md
  modified:
    - .planning/codebase/CONVENTIONS.md
    - .planning/codebase/ARCHITECTURE.md
    - .planning/codebase/STACK.md
    - .planning/codebase/STRUCTURE.md
    - .planning/codebase/INTEGRATIONS.md
    - CLAUDE.md
    - .claude/CLAUDE.md
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md

key-decisions:
  - "04-12: 「모두 인라인 SVG, 외부 이미지 없음」 규칙을 「그림(로고·아이콘·지도 그림·코스 선)은 인라인 SVG, 예외는 images/app/의 앱 화면 캡처 WebP뿐」으로 바꿔 원본 맵·두 CLAUDE.md에 적음 (D-24). 문서 커밋 fa90e3cb8cd1·5c6451b2debf·426174db1045, 푸시 안 함 (04-13)"
  - "04-12: CONVENTIONS 이미지 규칙의 NAVER 로고 문장은 04-09 사용자 예외(D-20 덧붙임)에 맞춰 「원본보다 더 자르거나 덮지 않는다」로 씀"
  - "04-12: 캡처 속 네이버 지도 출처는 구간 바로 아래 「지도 © NAVER Corp.」로만 적고 공유 푸터에는 넣지 않는다는 것을 루트 CLAUDE.md 푸터 문단과 INTEGRATIONS에 적어, 옛 「실제 지도를 쓰게 되면 출처를 더한다」 문장을 해소함"

patterns-established:
  - "Pattern: 사이트 구조가 바뀐 단계는 라이브 확인 뒤 원본 맵(생성기 원본 셋 → 나머지 둘) → 루트 CLAUDE.md + 재생성 .claude/CLAUDE.md 순서로 문서 커밋 셋을 남기고, 열 개 문서에서 옛 문장 0줄을 확인한다"

requirements-completed: [SITE-06]

coverage:
  - id: D1
    description: "생성기 원본 맵 세 개(CONVENTIONS·ARCHITECTURE·STACK)가 「실제 앱 화면」 구간과 images/app/ WebP 예외·이미지 규칙·재생성 도구를 적고, 생성기 사본 시험에서 새 줄이 생성 구간까지 들어감"
    requirement: SITE-06
    verification:
      - kind: other
        ref: "04-12-PLAN.md Task 1 <verify> 명령 (exit 0, 커밋 fa90e3cb8cd1)"
        status: pass
    human_judgment: false
  - id: D2
    description: "STRUCTURE·INTEGRATIONS가 images/app/ 폴더와 캡처 속 NAVER 지도 출처(구간 아래, 공유 푸터 아님)를 적음"
    requirement: SITE-06
    verification:
      - kind: other
        ref: "04-12-PLAN.md Task 2 <verify> 명령 (exit 0, 커밋 5c6451b2debf)"
        status: pass
    human_judgment: false
  - id: D3
    description: "루트 CLAUDE.md의 Pages 표·SVG 예외·구간 설명·지도 출처·Assets 갱신과 .claude/CLAUDE.md 재생성, 두 사본 방침 구간 동일, 열 개 문서에 옛 이미지·지도 문장과 로컬 경로 0줄"
    requirement: SITE-06
    verification:
      - kind: other
        ref: "04-12-PLAN.md Task 3 <verify> 첫 명령 (exit 0, 커밋 426174db1045)"
        status: pass
      - kind: other
        ref: "04-12-PLAN.md Task 3 <verify> 둘째 명령 (생성기 재생성 사본과 바이트 같음, exit 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 6min
completed: 2026-11-18
---

# Phase 4 Plan 12: D-24 문서 갱신 Summary

**「모두 인라인 SVG, 외부 이미지 없음」 규칙을 「그림은 인라인 SVG, 예외는 `images/app/` 앱 화면 캡처 WebP」로 바꿔 원본 맵 다섯 개와 두 CLAUDE.md에 적고, 캡처 속 네이버 지도 출처를 「구간 아래 표기, 공유 푸터 아님」으로 정리함 (문서 커밋 셋, 푸시 안 함)**

## Performance

- **Duration:** 6 min
- **Started:** 2026-11-18T07:07:48Z
- **Completed:** 2026-11-18T07:13:47Z
- **Tasks:** 3
- **Files modified:** 8 (문서 커밋 셋의 7개 + `04-EVIDENCE.md`)

## Accomplishments

- 생성기 원본 맵 CONVENTIONS·ARCHITECTURE·STACK에 「실제 앱 화면」 구간(`#screens`, `rp-shots*` 클래스, 좁은 화면 `scroll-snap` 띠), 이미지 규칙(sRGB WebP, 메타데이터 없음, 564w·846w `srcset`, `width`·`height`, `loading="lazy"`), 재생성 도구(`sips`·`cwebp`·`webpinfo`)를 적음. 생성기 사본 시험에서 새 줄이 모두 생성 구간에 들어감을 확인함 (tracer)
- STRUCTURE에 `images/app/` 폴더(디렉터리 그림과 Directory Purposes), INTEGRATIONS에 캡처 속 NAVER 지도 출처(「지도 © NAVER Corp.」, 구간 바로 아래, 공유 푸터에는 넣지 않음)를 적음
- 루트 `CLAUDE.md`의 Pages 표·SVG 문단·푸터 문단·Assets를 고치고 `.claude/CLAUDE.md`를 생성기로 다시 만듦. 두 사본의 방침 구간은 그대로 같고, 열 개 문서에 옛 이미지·지도 문장과 로컬 경로가 0줄임

## Task Commits

1. **Task 1: 생성기 원본 맵 세 개에 실제 앱 화면 구간과 WebP 자산 반영 (tracer)** - `fa90e3cb8cd1` (docs)
2. **Task 2: STRUCTURE·INTEGRATIONS에 images/app/과 캡처 속 지도 출처 반영** - `5c6451b2debf` (docs)
3. **Task 3: 루트 CLAUDE.md 갱신과 .claude/CLAUDE.md 재생성** - `426174db1045` (docs)

**Plan metadata:** SUMMARY·EVIDENCE docs 커밋과 STATE·ROADMAP 커밋은 이 SUMMARY 뒤에 남김

## Files Created/Modified

- `.planning/codebase/CONVENTIONS.md` - SVG 항목 예외, 이미지 규칙 항목, `rp-shots*` 클래스, `screens` 앵커, 띠 반응형
- `.planning/codebase/ARCHITECTURE.md` - 「실제 앱 화면 구간」 Component 행, 랜딩 구간 순서, 「랜딩 전용」 CSS 행의 「앱 화면 띠」, 로컬 정적 자산, Key Characteristics 예외
- `.planning/codebase/STACK.md` - WebP 줄, 캡처 재생성 도구 줄
- `.planning/codebase/STRUCTURE.md` - `images/app/` 디렉터리 그림과 절, `screens` 앵커, 랜딩 줄 수(622줄)와 `index.html` 구획 행 번호
- `.planning/codebase/INTEGRATIONS.md` - NAVER 지도 데이터 출처 항목, File Storage의 `images/app/`
- `CLAUDE.md` - Pages 표, SVG 예외, 「실제 앱 화면」 구간 항목, 푸터 문단의 지도 출처, Assets `images/app/` 항목과 재생성 방법
- `.claude/CLAUDE.md` - 생성기로 다시 만듦 (stack·conventions·architecture 블록만 바뀜)
- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` - `## 04-12 문서 (D-24)` 구간

## Decisions Made

- CONVENTIONS SVG 항목은 계획이 바꾸라고 한 마지막 문장 말고 첫 문장(「모든 그림은 인라인 SVG다」)도 「그림(로고·아이콘·지도 그림·코스 선)은 모두 인라인 SVG다」로 좁힘. 첫 문장을 두면 예외 문장과 서로 어긋나기 때문
- CONVENTIONS 이미지 규칙의 NAVER 로고 문장은 「자르지 않는다」가 아니라 04-09 사용자 예외(CONTEXT D-20 덧붙임)대로 「원본보다 더 자르거나 덮지 않는다」로 씀. ③ 완주 결과 캡처는 원본에서 앱의 뱃지 창이 로고를 덮고 있기 때문
- 루트 `CLAUDE.md`의 새 구간 항목에는 「실제 앱 화면(`#screens`)」 꼴을 쓰지 않고 「「실제 앱 화면」 구간(id `screens`)」으로 써서, Pages 표 행이 그 문자열의 유일한 줄로 남게 함 (Task 3 acceptance가 1줄을 셈)

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] STRUCTURE의 `index.html` 구획 행 번호를 지금 값으로 맞춤**
- **Found during:** Task 2
- **Issue:** 계획은 랜딩 줄 수(586줄)만 지금 값으로 맞추라고 했지만, 같은 파일의 「Core Logic (`index.html` 내부 구획)」과 「Where to Add New Code」 행 번호(`:29-115`, `:100`, `:121-151`, `:153`~`:426`, `:428-583`)도 04-11 구간 추가(36줄) 전 값이었음. 줄 수만 고치면 같은 절의 숫자끼리 어긋남
- **Fix:** 지금 `index.html`에서 grep으로 다시 재어 `:29-126`, `:109`, `:132-162`, `:164`·`:168`·`:216`·`:373`·`:436`·`:462`, `:464-619`로 맞추고 `:411` `#screens`를 더함
- **Files modified:** `.planning/codebase/STRUCTURE.md`
- **Verification:** Task 2 verify exit 0, 커밋은 두 맵만 담음
- **Committed in:** `5c6451b2debf` (Task 2 커밋)

**2. [Rule 2 - Missing Critical] ARCHITECTURE System Overview와 INTEGRATIONS File Storage에 `images/app/` 추가**
- **Found during:** Task 1, Task 2
- **Issue:** 두 곳이 로컬 정적 자산을 `favicon/` 하나로 적고 있어, 계획 항목만 고치면 같은 맵 안에 「정적 자산은 favicon/뿐」이라는 옛 상태가 남음
- **Fix:** ARCHITECTURE 「로컬 정적 자산」 줄과 INTEGRATIONS 「File Storage」 줄에 `images/app/`을 더함
- **Files modified:** `.planning/codebase/ARCHITECTURE.md`, `.planning/codebase/INTEGRATIONS.md`
- **Verification:** 생성기 사본 시험에서 ARCHITECTURE 줄이 architecture 블록에 들어감, Task 1·2 verify exit 0
- **Committed in:** `fa90e3cb8cd1`, `5c6451b2debf`

---

**Total deviations:** 2 auto-fixed (1 bug, 1 missing critical)
**Impact on plan:** 둘 다 같은 커밋 범위(그 task의 파일) 안에서 옛 상태가 남지 않게 한 것이고, 커밋 파일 목록은 계획과 같음. 범위 넘침 없음.

## Issues Encountered

- 생성기가 conventions 블록의 「IDs and data attributes (JS 연결점)」 머리 뒤 빈 줄 하나를 지움. 두 번의 사본 시험과 재생성 결과가 같았고, 생성 구간을 손으로 맞추지 않는 규칙대로 그대로 둠 (EVIDENCE에 기록)

## Deferred Issues (범위 밖, 고치지 않음)

- `.planning/codebase/ARCHITECTURE.md`의 `index.html:NNN` 행 번호(Component 표, Layers, Data Flow)는 04-11 구간 추가 전 값임. 이 계획의 파일이지만 계획이 요구하지 않았고 고칠 곳이 많아 남김. 다음 원본 맵 갱신(또는 `/gsd-map-codebase`)에서 맞춤
- `.planning/codebase/CONCERNS.md`의 「원본 72KB, 586줄」 숫자는 04-11 뒤 값과 다름. 같은 절의 「외부 이미지 대신 인라인 SVG 사용」은 파일 크기의 원인을 적은 문장이라 옛 규칙 문장이 아니어서 그대로 둠. CONCERNS는 이 계획의 파일이 아님

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 04-13(문서 푸시)이 푸시할 문서 커밋 셋: `fa90e3cb8cd1` → `5c6451b2debf` → `426174db1045`와 그 뒤 이 계획의 docs 커밋. 아무것도 푸시하지 않았음 (`main`은 원격보다 앞섬)
- SITE-06은 04-13도 선언하므로 `requirements.ready-ids`가 막아 이 계획에서는 완료 표시를 하지 않음 (04-13 SUMMARY 뒤에 표시됨)
- `.planning/PROJECT.md`는 고치지 않음 (Active 체크와 「현재 사이트」 설명은 단계 전환 갱신에서)

---
*Phase: 04-landing-content-fix*
*Completed: 2026-11-18*

## Self-Check: PASSED

- 파일: `04-12-SUMMARY.md`, 고친 문서 여덟 개 모두 있음
- 커밋: `fa90e3cb8cd1`, `5c6451b2debf`, `426174db1045` 모두 HEAD의 조상
- Task 1·2 verify 각 한 명령, Task 3 verify 두 명령 exit 0. 세 커밋에 사이트 파일 없음, `.planning/PROJECT.md` 변경 없음
