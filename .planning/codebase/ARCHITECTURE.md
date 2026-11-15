---
last_mapped_commit: c4cb26d754e9e666c957e31fa7e559f918b425bb
last_mapped_at: 2026-11-14
---
<!-- refreshed: 2026-11-14 -->
# Architecture

**Analysis Date:** 2026-11-14

## System Overview

```text
┌──────────────────────────────────────────────────────────────────────┐
│              GitHub Pages (Jekyll 통과, `_config.yml` exclude)         │
│              커스텀 도메인 `CNAME` → runningpencil.com                 │
├───────────────┬──────────────────┬──────────────┬───────────────────┤
│ 티저 랜딩      │ 개인정보처리방침   │ 이용약관      │ 데이터 삭제 안내   │
│ `index.html`  │ `privacy-policy/ │ `terms/      │ `data-deletion/   │
│ (vanilla CSS  │  index.html`     │  index.html` │  index.html`      │
│  + inline JS) │  (Tailwind CDN runtime + 공통 .rp-* CSS)              │
└───────┬───────┴────────┬─────────┴──────┬───────┴─────────┬─────────┘
        │  복사로 공유: <head> 글꼴/파비콘 링크, 「공통」 CSS, 헤더·푸터 마크업
        ▼
┌──────────────────────────────────────────────────────────────────────┐
│ 외부 CDN: Pretendard (jsDelivr) · Tailwind (`cdn.tailwindcss.com`, 법적 페이지만) │
│ 로컬 정적 자산: `favicon/` (svg/ico/png, `site.webmanifest`)            │
└──────────────────────────────────────────────────────────────────────┘
```

## Component Responsibilities

| Component | Responsibility | File |
|-----------|----------------|------|
| 랜딩 페이지 | 히어로·세 가지 이유(`#story`)·달려 보기(`#demo`)·출시 안내(`#get`) | `index.html` |
| Pre-paint 스크립트 | 첫 그리기 전에 `<html>`에 `rp-pin` 부여 | `index.html:26-29` |
| 「공통」 CSS 묶음 | 바탕·글꼴·`.rp-wrap`·헤더(`.rp-head`,`.rp-brand`,`.rp-nav`)·푸터(`.rp-foot-*`) | `index.html:31-58` (법적 페이지 각 `<style>` 상단에 동일 복사) |
| 「랜딩 전용」 CSS | 스크롤리(scrollytelling), 폰 목업, 뱃지, 반응형 | `index.html:60-146` |
| SVG 심볼 라이브러리 | 코스 path(`rp-c-*`), 지도(`rp-map-seoul`), 로고(`rp-logo`), 아이콘(`rp-i-*`), 히어로 캐릭터(`rp-t-*`) | `index.html:152-182` |
| 랜딩 동작 스크립트 | story 단계/진행도, demo 런 애니메이션, 해시 정착, `rp-ready` | `index.html:495-650` |
| Tailwind 토큰 | `ink`/`accent`/`muted`/`muted-2`/`line` | `terms/index.html:21-34` (`<script id="tailwind-config">`, 3개 법적 페이지 공통) |
| 모눈종이 바탕 | `.rp-grid` 32px 그리드 | `terms/index.html:69` (「법적 페이지 전용」) |
| Jekyll 제외 설정 | 저장소 문서가 사이트에 공개되지 않게 함 | `_config.yml` |

## Pattern Overview

**Overall:** Build-less 정적 멀티 페이지 사이트 (self-contained HTML per page)

**Key Characteristics:**
- 페이지마다 HTML·CSS·JS가 한 파일 안에 완결됨. 공통 템플릿·include 없음 → 공유 부분은 수동 복사.
- 랜딩은 라이브러리 없는 vanilla JS IIFE 하나, 상태는 클래스 토글과 CSS custom property로 DOM에 반영.
- 시각 자산은 전부 인라인 SVG. 반복 도형은 숨은 `<svg><defs>` + `<use href="#…">`.
- 진행형 애니메이션은 JS가 CSS 변수(`--q0..2`)만 쓰고, 그림은 `calc()`/`clamp()`로 스스로 반응(선언적 렌더링).

## Layers

**Markup (구조):**
- Purpose: 섹션·폰 목업·SVG 그림
- Location: `index.html:150-494`, 각 법적 페이지 `<body>`
- Depends on: `<defs>` 심볼, CSS 클래스
- Used by: 스크립트(id/data 속성 계약)

**Style (표현):**
- Purpose: 「공통」 → 「랜딩 전용」 또는 「법적 페이지 전용」 + 인라인 `style`
- Location: 각 파일 `<head>`의 `<style>`; 법적 페이지 본문은 Tailwind 유틸리티 클래스
- Depends on: `<html>` 상태 클래스(`rp-pin`, `rp-ready`), `#story`의 `--q*` 변수, `is-on`/`is-s*`

**Behavior (동작, 랜딩만):**
- Purpose: 스크롤 → 단계/진행도, demo 버튼 → 7초 rAF 애니메이션
- Location: `index.html:495-650`
- Depends on: id·속성 계약 (아래 참고)

## Data Flow

### Story 스크롤 고정 (`#story`)

1. `<head>` 스크립트가 reduced-motion 아님 && `innerHeight <= 2400`이면 `rp-pin` 추가 (`index.html:28`) → CSS가 `.rp-scrolly`를 340vh, `.rp-stage`를 `position: sticky`로 바꿈 (`index.html:97-115`)
2. `scroll` 이벤트(passive) → rAF 스로틀 → `paintStory()` (`index.html:621-624`)
3. `paintStory()`가 `#story`의 `getBoundingClientRect()`로 f∈[0,3) 계산, `step = floor(f)`, 단계별 진행도 q 산출 (`index.html:552-571`)
4. `story.style.setProperty('--q0'|'--q1'|'--q2')` (`index.html:563-565`) → `stroke-dashoffset: calc(1000px * (1 - var(--q0)))`, 번호 점 `opacity: clamp(...)`, 진행 바 `width: calc(var(--q1) * 100%)` 등이 반응 (`index.html:325-391`)
5. `--q1`로 `#rp-run-dot`을 `getPointAtLength`로 이동, `#rp-run-pct/-dist/-time` 텍스트 갱신
6. 단계 변경 시 `setStep(i)` → `[data-step]`에 `is-on`, `[data-go]`에 `is-on`+`aria-pressed`, `#rp-panel.className = 'rp-panel is-s' + i` (`index.html:535-544`)
7. 단계 버튼 클릭 → `goStep(i)`: pin 상태면 해당 위치로 smooth scroll, 아니면 바로 `setStep` (`index.html:574-582`)
8. `resize` → `syncLive()`가 `rp-pin`을 재판정·토글 (`index.html:547-549`)

### Demo 런 (`#demo`)

1. `#rp-run-btn` 클릭 → `startRun()` (`index.html:604-614`)
2. 7000ms rAF 루프에서 `paintDemo(t)`: `#rp-demo-prog`의 `stroke-dashoffset`, `#rp-demo-dot` 위치, 퍼센트/거리(KM=8.3)/시간 텍스트
3. 상태 `idle → running → done`; `setRun()`이 `#rp-run-label` 문구, `#rp-run-icon`의 `href`(`#rp-i-play`↔`#rp-i-replay`), `#rp-demo-done`의 `is-on` 토글 (`index.html:597-602`)

### 초기 정착 & `rp-ready`

1. 첫 navigate이고 `location.hash`가 있으면 대상 요소를 기억 (`index.html:625-627`)
2. `load`와 `document.fonts.ready`에서 `settle()` → 사용자 입력(wheel/touch/key/mouse) 전까지 대상으로 `scrollIntoView({behavior:'instant'})` (`index.html:630-637`)
3. `load` 후 `<html>`에 `rp-ready` → `scroll-behavior: smooth` 활성 (`index.html:62`, `:636`)
4. reduced-motion이면 `#rp-hero-art` SMIL 정지, `#rp-sketch`는 6.6s 지점에서 정지 (`index.html:643-647`)

**State Management:**
- JS 내부 `state = { step, live, run }` (`index.html:513`) 하나. DOM 측 상태는 클래스(`rp-pin`, `rp-ready`, `is-on`, `is-s0..2`)와 CSS 변수(`--q0..2`). 영속 저장 없음.

## Key Abstractions

**SVG 심볼 + `<use>`:**
- Purpose: 코스 선·아이콘·지도를 한 번 정의, 여러 곳에서 다른 stroke로 재사용
- Examples: `index.html:154` `<path id="rp-c-dog" pathLength="1000">`, 사용처 `index.html:325,326,340,356,391`
- Pattern: 코스 path는 `pathLength="1000"`으로 정규화 → `stroke-dasharray: 1000px`로 진행도 표현. `#rp-c-dog`는 JS의 `getPointAtLength` 기준 경로이기도 함.

**진행도 CSS 변수:**
- Purpose: JS→그림 단방향 데이터 전달
- Examples: `#story` 초기값 `style="--q0: 1; --q1: 0.62; --q2: 1"` (`index.html:249`) — JS 비활성 시 정지 장면

**공유 헤더/푸터:**
- Purpose: 4페이지 동일 브랜딩. 로고는 법적 페이지에 `<defs>`가 없어 인라인 path로 직접 삽입 (`index.html:188`)

## Entry Points

**`index.html`:** 루트 `/`. 티저 랜딩. `<body id="top">`.
**`privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`:** `/privacy-policy/` 등 디렉터리 인덱스 URL. `noindex`. 앱 스토어 심사용.
**`favicon/site.webmanifest`:** PWA 매니페스트 (theme `#F2B134`).

## Architectural Constraints

- **Threading:** 브라우저 메인 스레드 단일. 스크롤 핸들러는 rAF 1프레임 1회로 스로틀.
- **Global state:** 전역 오염 없음 — 스크립트 전체가 `'use strict'` IIFE (`index.html:497`). Tailwind만 `window.tailwind.config` 사용.
- **Circular imports:** 해당 없음 (모듈 시스템 없음).
- **절대 경로 의존:** `/favicon/...`, `/terms/`, `/#story`는 커스텀 도메인 루트 전제. `file://` 또는 `slimpumpkin.github.io/<repo>/` 하위 경로에서는 깨짐.
- **Markup–Script 계약:** 스크립트는 id `story`, `rp-panel`, `rp-run-dot|pct|time|dist|btn|icon|label`, `rp-demo-prog|dot|pct|dist|time|done`, `rp-c-dog`, `rp-hero-art`, `rp-sketch`와 속성 `data-step`(0~2, 글 3 + 폰 화면 3), `data-go`(버튼 3)에 의존. null 체크 없음(`rp-hero-art`/`rp-sketch` 제외) → 하나라도 빠지면 스크립트 전체가 예외로 중단.
- **CDN 의존:** 글꼴·Tailwind가 런타임 로드. 오프라인 시 법적 페이지 스타일 붕괴.

## Anti-Patterns

### 공통 부분을 한 파일만 수정

**What happens:** 「공통」 CSS/헤더/푸터/`<head>` 링크를 `index.html`에서만 바꿈
**Why it's wrong:** 템플릿이 없어 4페이지 간 드리프트 발생
**Do this instead:** `index.html`, `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html` 네 파일을 함께 수정. 링크만 다름(랜딩 `#story`, 법적 `/#story`).

### 랜딩에 Tailwind 클래스 추가

**What happens:** `index.html`에 유틸리티 클래스 사용
**Why it's wrong:** 랜딩은 Tailwind CDN을 로드하지 않음 → 무효
**Do this instead:** 「랜딩 전용」 블록(`index.html:60` 이후)에 `.rp-*` 클래스 추가, 좁은 화면 규칙은 `@media (max-width: 860px)` (`index.html:131`)에.

### JS에서 그림 속성 직접 조작

**What happens:** story 그림 요소의 style을 스크립트가 개별 설정
**Why it's wrong:** 기존 패턴은 `--q*` 변수만 쓰고 CSS가 반응; 분산되면 무-JS 기본 장면도 깨짐
**Do this instead:** 새 진행형 효과는 `var(--q0..2)` 기반 `calc()`로 인라인 style에 선언.

## Error Handling

**Strategy:** 방어적 try/catch로 조용히 폴백 (기능 저하 허용)

**Patterns:**
- `moveTo()`의 `getPointAtLength` 실패 시 점을 출발점에 둠 (`index.html:526-531`)
- 깨진 해시 `decodeURIComponent` 실패 무시 (`index.html:627`)
- `scrollIntoView({behavior:'instant'})` 미지원 시 `scrollIntoView(true)` 폴백
- `window.matchMedia`, `document.fonts`, `performance.getEntriesByType`, `pauseAnimations` 존재 여부 확인 후 사용

## Cross-Cutting Concerns

**Logging:** 없음 (console 사용 없음)
**Validation:** 해당 없음 (폼·입력 없음; 이메일 수집 폼 의도적으로 없음)
**Authentication:** 해당 없음
**Accessibility:** `prefers-reduced-motion` 존중(pin 비활성, SMIL 정지, smooth scroll 끔), `aria-pressed` 동기화, `aria-labelledby` 섹션, `:focus-visible` 아웃라인, 장식 SVG `aria-hidden`.

---

*Architecture analysis: 2026-11-14*
