---
last_mapped_commit: c4cb26d754e9e666c957e31fa7e559f918b425bb
last_mapped_at: 2026-11-14
---
# Coding Conventions

**Analysis Date:** 2026-11-14

## Naming Patterns

### Files

- 페이지마다 디렉터리 하나에 `index.html` 하나를 둔다 (pretty URL): `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`. 디렉터리 이름은 kebab-case 영어로 쓴다.
- 에셋은 `favicon/` 아래에 kebab-case와 크기 접미사로 둔다: `favicon-96x96.png`, `web-app-manifest-192x192.png`, `web-app-manifest-512x512.png`.
- include는 `_includes/` 아래 kebab-case `.html`로 두고 (`head-links.html`, `header.html`, `footer.html`), CSS 조각은 `_includes/css/*.css`로 둔다 (`_includes/css/common.css`, `_includes/css/legal.css`). 레이아웃은 `_layouts/legal.html` 하나다. 레이아웃 이름에 `default`·`page`·`home`·`post`를 쓰지 않는다 (운영 테마의 레이아웃과 충돌한다).

### CSS classes

- 직접 만든 클래스에는 모두 `rp-` 접두사를 붙이고 kebab-case로 쓴다: `.rp-wrap`, `.rp-head-in`, `.rp-brand-tile`, `.rp-foot-legal`, `.rp-scrolly`, `.rp-phone`, `.rp-grid`.
- 랜딩 「실제 앱 화면」 구간(`#screens`)의 클래스는 `.rp-shots-sec`(구간)·`.rp-shots`(띠)·`.rp-shot`(한 장)·`.rp-shot-frame`(흑연 폰 테두리)·`.rp-shot-cap`(캡션)·`.rp-shots-credit`(지도 출처)이다. 스크립트가 쓰지 않는 이름이다. 이 구간의 폰 테두리는 `.rp-phone`을 다시 쓰지 않는다 (`.rp-phone`은 좁은 화면과 낮은 창 높이의 `zoom` 규칙에 묶여 있다).
- 부모-자식 관계는 접미사로 나타낸다 (BEM과 비슷하지만 `__`/`--`는 쓰지 않는다): `.rp-foot` → `.rp-foot-in` → `.rp-foot-top` / `.rp-foot-brand` / `.rp-foot-nav`.
- 상태 클래스는 `is-` 접두사를 쓰고 JS에서만 바꾼다: `is-on` (보임/켜짐), `is-s0`·`is-s1`·`is-s2` (세 가지 이유의 단계).
- 문서 전체 모드 클래스는 `<html>`에 `rp-` 접두사로 붙인다: `rp-pin` (스크롤 고정 모드, `<head>` 스크립트가 첫 그리기 전에 붙임), `rp-ready` (`load` 뒤 부드러운 스크롤 켜기).

### IDs and data attributes (JS 연결점)

- 스크립트가 찾는 요소의 id는 `rp-` + 영역 + 역할로 쓴다: `rp-run-dot`, `rp-run-pct`, `rp-demo-prog`, `rp-demo-done`, `rp-run-btn`, `rp-hero-art`, `rp-sketch`, `rp-c-dog`. 예외로 구간 앵커 id는 짧은 영어 단어로 쓴다: `story`, `demo`, `screens`, `get`, `top`. `screens`(「실제 앱 화면」)는 스크립트가 쓰지 않는다.
- SVG `<defs>` 심볼 id: 아이콘은 `rp-i-*` (`#rp-i-play`, `#rp-i-replay`), 코스 선은 `rp-c-*` (`#rp-c-dog`).
- 반복 요소에는 인덱스 data 속성을 쓴다: 내용은 `data-step="0..2"`, 버튼은 `data-go="0..2"`.
- id·class·data 속성 이름을 바꾸면 `index.html` 끝(약 428행)의 인라인 스크립트도 반드시 같이 고친다.

### JS functions / variables

- 함수와 변수는 camelCase로 쓰고 함수 이름은 동사로 시작한다: `setStep`, `goStep`, `paintStory`, `paintDemo`, `setRun`, `startRun`, `syncLive`, `moveTo`, `setText`, `settle`. 작은 순수 유틸은 명사형도 쓴다: `clamp01`, `twoDigits`, `clock`, `reduced`.
- 상수는 UPPER_CASE로 쓴다: `var KM = 8.3;`.
- DOM 참조 변수는 영역 + 역할 + `El`/`Btn`/`Dot`으로 쓴다: `runBtn`, `demoDot`, `stepEls`.
- 애니메이션 프레임 핸들은 `*Frame`으로 쓰고 0으로 초기화한다: `storyFrame`, `runFrame`.

## Code Style

### Formatting

- 포매터가 없다 (Prettier 설정 없음). 기존 코드의 모양을 그대로 따른다.
- HTML·CSS·JS 모두 공백 4칸 들여쓰기를 쓴다.
- CSS는 규칙 하나를 **한 줄**에 쓴다: `.rp-brand { display: flex; align-items: center; gap: 10px; ... }`. 미디어 쿼리 안에 규칙이 하나뿐이면 그것도 한 줄에 쓴다.
- JS 문자열은 작은따옴표, HTML 속성은 큰따옴표로 쓴다.

### Linting

- 린터 없음. 전역 규칙의 "커밋 전 린터 실행"은 이 저장소에서 `scripts/check-site.sh`로 갈음한다. 점검 항목은 여섯이다: 빌드 성공, `_site`에 내부 파일 없음, 기존 URL 문서 4개(`index.html`, `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`)의 `<title>`, 처리되지 않은 Liquid 없음, 출력 HTML에 Tailwind Play CDN 없음, 랜딩 출력(`index.html`)에 포인트·굿즈·코스북 없음(U10). `.githooks/pre-push` 훅이 `main` 푸시마다 자동으로 돌린다 (훅 켜기: `git config core.hooksPath .githooks`, 클론마다 한 번).

## CSS / Styling Patterns

### `<style>` 블록 구획 (주석 머리 `/* ── 이름 ── */`)

- 「공통」 — 네 페이지가 함께 쓰는 묶음 (`html`, `body`, `.rp-wrap`, `.rp-head*`, `.rp-brand*`, `.rp-nav`, `.rp-foot*`, `@media (max-width: 860px) { .rp-nav { display: none; } }`). 이 묶음은 `_includes/css/common.css` 한 곳에 있고, 랜딩(`index.html`)과 legal 레이아웃(`_layouts/legal.html`)의 `<style>` 안에서 `{% include css/common.css %}`로 인라인된다. 고칠 때는 그 파일만 고친다.
- 「랜딩 전용」 — `index.html`에만 있다. 새 랜딩 스타일은 여기에 넣는다.
- 「법적 페이지 전용」 — `_includes/css/legal.css` 한 곳에 있고, `_layouts/legal.html`의 `<style>` 안에서 「공통」 다음에 `{% include css/legal.css %}`로 인라인된다. 법적 페이지 3종이 함께 쓴다 (토큰, Preflight 대체, `.rp-grid` 모눈종이 바탕, `.rp-legal-*` 카드 껍데기, `.rp-doc` 본문 규칙).

### 반응형

- 고정 breakpoint 대신 유동 수치를 먼저 쓴다: `padding-left: clamp(20px, 5vw, 64px)`, `padding: clamp(40px, 5vw, 64px) 0`.
- 좁은 화면 규칙은 `index.html` `<style>` 끝의 `@media (max-width: 860px) { ... }` 블록 하나에 모은다. 랜딩의 폭 breakpoint는 860px(`max-width`) 하나다. 법적 카드는 768px(`min-width`)에서 안쪽 여백만 28px에서 48px로 바뀐다 (`_includes/css/legal.css`). 둘은 별개다.
- 「실제 앱 화면」 띠(`.rp-shots`)는 넓은 화면에서 한 줄 세 장(grid)이고, 860px 이하에서는 `.rp-wrap` 좌우 여백과 같은 음수 margin(`calc(-1 * clamp(20px, 5vw, 64px))`)으로 화면 끝까지 닿는 가로 띠가 되어 CSS `scroll-snap`으로 밀린다 (스크립트 없음). 띠 `<ul>`에는 키보드로 밀 수 있게 `tabindex="0"`, 목록으로 읽히게 `role="list"`, 이름으로 `aria-label`을 준다. 넓은 화면(860px 초과)에서는 밀 것이 없어도 띠가 탭 멈춤 자리로 하나 남는다. 「실제 앱 화면」 구간은 스크립트를 쓰지 않는 방침이라 그대로 둔다.
- 창 높이에 따른 축소는 `@media (max-height: ...)`에서 `zoom`으로 한다 (`.rp-pin .rp-scrolly .rp-phone { zoom: .84; }`).
- 움직임은 `@media (prefers-reduced-motion: reduce)` 블록과 JS의 `reduced()` 확인 둘 다로 막는다.

### 법적 페이지 (정적 CSS `_includes/css/legal.css`)

- 법적 페이지 CSS는 `_includes/css/legal.css` 한 곳에 있다 (2026-11 기준). `_layouts/legal.html`의 `<style>` 안에서 「공통」(`common.css`) 다음에 include한다. 외부 `.css` 파일이나 런타임 스크립트는 없다. Tailwind Play CDN은 Phase 3에서 제거했다.
- 토큰은 `:root`의 CSS 변수 다섯 개다: `--rp-ink #2B2B2B`, `--rp-accent #7C580D`, `--rp-muted #4A463F`, `--rp-muted-2 #57534C`, `--rp-line #E4E0D6`. 이 다섯 색은 `var(--rp-…)`로만 쓰고, 새 hex를 늘리지 않는다. 카드 바탕 `#fff`와 모눈종이 `#F5F9FC`·`#D3E2EF`는 원래 있던 값이라 hex 그대로 있다.
- 카드 껍데기는 레이아웃이 그리는 클래스 `.rp-legal-wrap`·`.rp-legal-card`·`.rp-legal-eyebrow`·`.rp-legal-title`·`.rp-legal-updated`로 쓴다. 본문은 `<div class="rp-doc">` 안에 들어가고, 본문 규칙은 모두 `.rp-doc` 범위로 쓴다.
- Preflight 대체는 `html`(line-height 1.5, tab-size 4, `-webkit-tap-highlight-color: transparent`)과 `.rp-doc` 범위 규칙만 쓴다. 레이아웃 규칙(`body` 세로 flex, `main` 늘리기, `.rp-grid`)은 법적 페이지에서만 불리므로 그대로 둔다. 본문 요소(h2·p·ul·table 등)의 규칙은 범위 없는 요소 선택자로 쓰지 않는다. 사이트 머리말·바닥글로 샌다.
- 토큰과 초기화 규칙을 「공통」(`common.css`)에 넣지 않는다. 넣으면 랜딩 출력이 바뀐다.
- 헤더·푸터는 「공통」 `.rp-*` 클래스로 그린다.

### 법적 본문 작성 규칙 (Phase 6~9가 따름)

- 법적 문서(처리방침·약관·삭제 안내, 이후 지원 페이지와 영문판)의 본문을 쓸 때 지킨다. `_includes/css/legal.css` 맨 위 주석에도 허용 요소 목록이 짧게 있다.
- 원본은 HTML이다 (`privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`). Markdown(kramdown)으로 바꾸지 않는다. kramdown은 곧은 따옴표를 굽은 따옴표로 바꾸고 제목에 자동 `id`를 붙인다 (D-01).
- 조항마다 `<section>` 하나를 두고 첫 자식은 `<h2>`다. 간격은 본문 최상위 자식 사이 32px(`section`끼리, 마지막 `footer` 앞), `section` 안 자식 사이 12px, 목록 항목(`li`) 사이 4px다 (D-02).
- 문서 끝 안내는 `<footer>`(위 1px `line` 선, 위 여백 16px, 14px, `muted-2`), 조항 안 보충 설명(예: 표 아래 「※ …」)은 `<aside>`(14px, `muted-2`, 구분선 없음)로 쓴다. 둘 다 클래스가 없다 (D-03).
- 본문에 쓸 수 있는 요소는 `section` `h2` `h3` `p` `ul` `ol` `li` `dl` `dt` `dd` `table` `thead` `tbody` `tr` `th` `td` `figure` `strong` `a` `aside` `footer`가 전부이고, 모두 클래스 없이 쓴다 (D-04).
- `strong`과 `a`는 클래스 없이 기본 모양을 받는다. `strong`은 600·`ink`, `a`는 600·`ink`에 2px `accent` 밑줄(offset 4px), hover 때 글자색 `accent` (D-05).
- 표는 가로줄만 쓴다. 바깥 테두리와 바탕색이 없고 행 사이를 1px `line` 선으로 나눈다. 머리 행(`th`)은 굵은 `ink`, 표 안 글씨는 14px, 정렬은 왼쪽·위다 (D-06). 표 머리 행은 줄바꿈하지 않고 한 줄로 둔다 (`th`에 `white-space: nowrap`, Phase 3에서 사용자가 고름).
- 표는 모두 `<figure tabindex="0" aria-label="표 이름">`으로 감싼다. 표가 본문 폭보다 넓으면 figure 안에서만 가로로 스크롤하고 페이지는 밀리지 않는다. `tabindex="0"`은 키보드 스크롤, `aria-label`은 화면 낭독기가 읽을 이름이다. 표 자체를 블록 상자로 바꾸지 않는다 (`<table>`에 `display: block` 금지, 일부 화면 낭독기가 표로 읽지 못함) (D-07).
- 표가 넘칠 때만 더 밀 수 있는 쪽 가장자리에 옅은 그림자가 보인다. CSS만으로 만들고(JS 없음) 그림자는 figure의 배경이라, 표 칸에 바탕색을 주지 않는다 (D-08).
- `<ol>`은 1. 2. 3.(decimal)이고 들여쓰기 20px·항목 간격 4px는 `ul`과 같다. 약관의 항 번호(①)가 필요하면 본문 글에 직접 쓴다 (D-09).
- 중첩 목록은 바깥 목록 안에서 20px을 한 번 더 들여쓴다. 바깥이 `ul`이든 `ol`이든 안쪽 `ul`은 ○(circle), 안쪽 `ol`은 가. 나. 다.(`hangul`)이고, 영문판(`lang="en"`)의 안쪽 `ol`은 a. b. c.(`lower-alpha`)다 (D-10).
- `<h3>`는 17px·700·`ink`다. h2(20px·700·`ink`)에서 크기만 한 단계 줄인 모양이다 (D-11).
- `<dl>`은 `dt`를 굵은 `ink`로 한 줄에 두고 `dd`를 그 아래 본문 글씨로 쓴다. `dd`는 들여쓰지 않는다 (D-12).
- 목록에 없는 요소가 필요하면 `_includes/css/legal.css`(규칙과 맨 위 주석)와 이 목록을 같은 단계에서 함께 고친다.
- 표가 처음 들어가는 단계(예: Phase 7 처리 위탁 표)는 검증에서 본문의 모든 `<figure`에 `tabindex="0"`과 `aria-label`이 있는지 grep으로 확인한다. CSS는 속성이 없어도 스크롤을 주므로, 두 속성은 검증으로만 지켜진다.

### 색 토큰 (랜딩은 hex를 바로 씀)

| 용도 | 값 |
|---|---|
| 연필 노랑 (헤더·히어로·출시 안내 바탕, `theme-color`) | `#F2B134` |
| 흑연 (글자, 푸터 바탕) / 법적 페이지 `--rp-ink` | `#2B2B2B` |
| 페이지 바탕 | `#FAFAF7` |
| 진한 금색 (작은 제목·링크 밑줄) / `--rp-accent` | `#7C580D` |
| 보조 글자 `--rp-muted` / `--rp-muted-2` | `#4A463F` / `#57534C` |
| 테두리·구분선 `--rp-line` | `#E4E0D6` |
| 칠판 초록 (달려 보기) | `#2E4A3B` |
| 모눈종이 바탕 / 선 | `#F5F9FC` / `#D3E2EF` |
| 포커스 테두리 | `#1E5AA8` |
- 노랑 `#F2B134`는 밝은 바탕 위 글자·밑줄에 쓰지 않는다 (대비 부족). 대신 `#7C580D`를 쓴다.
- 다크 모드 규칙을 추가하지 않는다.

### 접근성 기본값

- 클릭 대상은 `min-height: 44px` 이상으로 둔다 (`.rp-brand`, `.rp-foot-nav a`).
- 포커스는 `:focus-visible { outline: 3px solid #1E5AA8; }`로 보여 준다.

## Import Organization

### Order (`<head>`)

- meta (charset, viewport, title, description, `theme-color`, 법적 페이지는 `robots noindex`)
- 첫 그리기 전 실행 스크립트 (`index.html`만: `rp-pin` 판정)
- `{% include head-links.html %}` (Pretendard 글꼴 `<link>`와 파비콘·매니페스트 링크 8줄. jsDelivr `orioncactus/pretendard@v1.3.9`, `/favicon/...`)
- `<style>` — 맨 위에 「공통」(`{% include css/common.css %}`)이 들어오고, 법적 페이지는 그 다음에 `{% include css/legal.css %}`가 들어온다 (`_layouts/legal.html`). 랜딩은 「공통」 다음에 「랜딩 전용」을 바로 쓴다

### Path Aliases

- 없음. 모든 내부 경로는 루트 기준 절대 경로로 쓴다: `/favicon/favicon.svg`, `/terms/`, `/#story`. 커스텀 도메인 연결을 전제로 한다.

## Error Handling

### Patterns

- 브라우저 기능은 존재 여부를 먼저 확인한다: `window.matchMedia && ...`, `document.fonts && document.fonts.ready`, `performance.getEntriesByType ? ... : null`, `hero.pauseAnimations && ...`.
- 실패할 수 있는 DOM/SVG API는 `try { } catch (e) { /* 이유 주석 */ }`로 감싸고 조용히 대체 동작을 한다. 예는 아래 두 줄이다.
- 예: `try { if (location.hash.length > 1 && ...) target = byId(decodeURIComponent(location.hash.slice(1))); } catch (e) { /* 깨진 주소는 무시 */ }`
- 예: `try { target.scrollIntoView({ behavior: 'instant', block: 'start' }); } catch (e) { target.scrollIntoView(true); }`
- 빈 `catch`에도 왜 무시하는지 한국어 주석을 남긴다.
- 사용자에게 오류를 보여 주거나 `console`에 찍지 않는다.

## Logging

- 로깅 프레임워크 없음 (`console` 호출 없음). 디버깅용 로그를 남긴 채 커밋하지 않는다.

## Comments

### When to Comment

- 주석은 한국어 평서문으로, 구어체에 가깝게 쓴다 ("…맞춰 선다", "…세워 둔다").
- 스크립트 맨 위에 하는 일을 한 줄로 적는다: `// 「세 가지 이유」의 스크롤 연동과 「달려 보기」 체험. 라이브러리 없이 이 파일 안에서만 돈다.`
- 구획 머리 주석: JS `// ── 연결 ──`, CSS `/* ── 랜딩 전용 ── */`.
- 변수 옆에 의미와 범위를 적는다: `var stepEls = ...;   // 단계 글 3개 + 폰 화면 3개`, 상태 객체의 각 필드 설명.
- 화면 구간 이름은 「」로 감싸 쓴다: 「세 가지 이유」, 「달려 보기」, 「공통」.

- JSDoc/TSDoc은 쓰지 않는다. 함수 위에 한 줄 한국어 주석이면 충분하다 (`// 코스 선의 q(0~1) 지점으로 점을 옮긴다`).

## Function Design

### JS 구조 (`index.html` 끝 인라인 스크립트)

- 전체를 IIFE + `'use strict'`로 감싼다. 전역에 아무것도 내놓지 않는다.
- ES5 문법을 쓴다: `var`, `function`, 클로저 루프 `(function (n) { ... })(i)`. `let`/`const`/화살표 함수/모듈/라이브러리를 들이지 않는다 (`forEach`, `requestAnimationFrame`, `performance.now()`는 쓴다).
- 상태는 객체 하나에 모은다: `var state = { step: 0, live: ..., run: 'idle' };`, 상태 바꾸기는 `setStep`/`setRun` 같은 setter에서만 하고 DOM 클래스(`classList.toggle('is-on', ...)`)로 반영한다.
- 그리기 함수는 진행도 `q`(0~1)를 받는다: `paintDemo(q)`, `moveTo(el, q)`. CSS 쪽에는 `#story`의 변수 `--q0`·`--q1`·`--q2`로 넘긴다.
- 쓸데없는 DOM 쓰기를 피한다: `setText`는 값이 다를 때만 `textContent`를 바꾼다.
- scroll 처리는 `{ passive: true }` + `requestAnimationFrame` 하나로 묶는다.
- 함수는 짧게 (대부분 10줄 안팎), 한 줄 함수는 한 줄로 쓴다.

## Module Design

- **Exports:** 없음. 페이지마다 스크립트·스타일은 그 HTML 안에만 있다 (외부 `.js`/`.css` 파일 없음).

- **Shared code:** Jekyll 공유 셸(Phase 2 적용됨). 공통 블록은 include 네 개(`_includes/head-links.html`, `_includes/css/common.css`, `_includes/header.html`, `_includes/footer.html`)와 레이아웃 `_layouts/legal.html`에 한 벌씩 있다. 랜딩은 front matter `layout: none`에 include 네 줄을 쓰고, 법적 3종은 `layout: legal`과 front matter로 그려진다. 법적 페이지 전용 CSS는 include 하나(`_includes/css/legal.css`)에 있고 레이아웃만 부른다. 법적 페이지 front matter 키는 `layout`·`title`·`description`·`eyebrow`·`heading`·`updated`·`noindex`다 (`heading`이 없으면 `title`을 쓰고, `updated`·`noindex`는 값이 있을 때만 출력한다).
  - 헤더 링크 변형은 include 매개변수로 한다. 랜딩은 `{% include header.html home=true %}`(링크 `#top`·`#story`·`#demo`·`#get`), 법적 페이지는 `{% include header.html %}`(링크 `/`·`/#story`·`/#demo`·`/#get`)다.
  - include 공백 규칙: include 태그는 0열에 혼자 두고, include 파일은 원본 들여쓰기 그대로, 끝 줄바꿈 없이 쓴다. `{%-`는 `if`/`endif`에만 쓰고 내용을 내보내는 태그에는 쓰지 않는다.
  - raw 규칙: front matter가 붙은 파일은 전체가 Liquid를 거친다. 인라인 JS·CSS에 이중 중괄호나 중괄호-퍼센트가 생기면 그 부분을 `{% raw %}`…`{% endraw %}`로 감싼다. `scripts/check-site.sh`의 4번 항목은 출력에 남은 이런 문자열을 잡으므로, raw로 일부러 내보내는 경우가 생기면 그 항목에 예외 규칙을 더한다.

- **SVG:** 그림(로고·아이콘·지도 그림·코스 선)은 모두 인라인 SVG다. 랜딩에서 두 번 이상 쓰는 도형은 `<body>` 맨 위 숨은 `<svg><defs>`에 두고 `<use href="#rp-...">`로 쓴다. 법적 페이지에는 `<defs>`가 없으므로 로고를 그 자리에 그대로 넣는다. 예외는 랜딩 「실제 앱 화면」 구간의 앱 화면 캡처뿐이고, 이 캡처는 `images/app/screen-{draw,run,badge}-{564,846}.webp`에 둔다.

- **이미지 (앱 화면 캡처, `images/app/`):** 캡처는 sRGB로 바꿔 WebP로 인코딩하고 메타데이터(EXIF·XMP·ICC)를 넣지 않는다. 한 장마다 564w·846w 두 파일을 `srcset`·`sizes`로 쓰고, `src`는 564w, `width`·`height`는 846w 파일의 실제 크기(846×1837)로 적는다. `loading="lazy"`·`decoding="async"`를 준다. `alt`에는 화면에 보이는 것만 쓴다. 캡처 원본(PNG)은 저장소에 넣지 않는다. 캡처 위에 웹페이지 요소를 겹치지 않고, 캡처 속 NAVER 로고를 원본보다 더 자르거나 덮지 않는다.

## Content & Naming Rules

- 현재 페이지는 모두 `<html lang="ko">`이고 본문은 한국어다 (2026-11 기준). Phase 9에서 `/en/` 아래에 영문판(`lang="en"`)이 생기고, 그 뒤로는 한국어와 영어를 함께 제공한다.
- 서비스 이름은 한국어 **러닝펜슬**, 영어 `RunningPencil`이다. 정본은 이름 표(`.planning/baseline/NAMES.md`)이고 사이트·콘솔·스토어에서 같은 값을 쓴다. 현재 사이트(제목, meta, 매니페스트, 워드마크, 본문)에는 한국어 이름만 있다 (2026-11 기준). 영문 이름은 Phase 9 영문판(`/en/`)부터 쓴다. `runningpencil.com`은 도메인 표기다.
- 운영 회사는 **슬림펌킨**: 저작권 표기, 푸터 운영 안내 문장, 법적 페이지의 `(이하 "회사")` 주체.
- 이메일 수집 폼과 서버 처리는 만들지 않는다 (정적 호스팅, `.planning/REQUIREMENTS.md` Out of Scope). 연락 수단은 이메일 게이트(Phase 5) 뒤 공개하는 지원 이메일 하나로 한다. 현재는 문의 채널이 없다 (2026-11 기준).
- 현재 사이트에는 지원 이메일이 없다 (2026-11 기준). 이메일 게이트(Phase 5: 외부 4곳 수신 시험 통과)가 열리면 지원 이메일을 푸터, 지원 페이지, 법적 문서에 넣는다. 그전에는 주소를 HTML·`_data`에 넣지 않는다. 주소의 정본은 이름 표(`.planning/baseline/NAMES.md`)이고, 사이트(HTML·`_data`)에는 없고 `.planning/` 문서에만 있다. 저장소가 공개라 `.planning/` 문서의 주소는 GitHub에서 누구나 볼 수 있다. HTML·`_data`에 넣지 않는 규칙은 사이트 노출만 막는다.
- 현재 법적 페이지 3종에는 `<meta name="robots" content="noindex">`와 「임시 게시본」 표시가 있다 (2026-11 기준). 문서를 다시 쓰는 커밋(Phase 6 삭제 안내, Phase 7 처리방침, Phase 8 이용약관)에서 둘 다 지운다 (U14).
- 새 마크다운 문서를 추가하면 `_config.yml`의 `exclude`에 적는다. 마크다운 문서뿐 아니라 사이트에 올리지 않을 새 루트 파일·폴더도 `exclude`에 적는다. 사용자 `exclude`가 Jekyll 기본 제외 목록을 덮어쓰기 때문이다.

## Commit Messages

- Conventional Commits, prefix는 영어, 제목은 한국어 (`git log`). 예는 아래 두 줄이다.
- 예: `feat: 티저 랜딩 새 디자인 적용, 법적 페이지·파비콘 개편`
- 예: `feat: RunningPencil 티저 사이트 초기 구성`
- `main` 푸시가 곧 배포이므로 푸시 전에 `scripts/check-site.sh`가 통과해야 한다 (pre-push 훅이 자동 실행).

---

*Convention analysis: 2026-11-14*
