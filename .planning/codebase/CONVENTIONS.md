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
- include는 `_includes/` 아래 kebab-case `.html`로 두고 (`head-links.html`, `header.html`, `footer.html`), CSS 조각은 `_includes/css/*.css`로 둔다 (`_includes/css/common.css`). 레이아웃은 `_layouts/legal.html` 하나다. 레이아웃 이름에 `default`·`page`·`home`·`post`를 쓰지 않는다 (운영 테마의 레이아웃과 충돌한다).

### CSS classes

- 직접 만든 클래스에는 모두 `rp-` 접두사를 붙이고 kebab-case로 쓴다: `.rp-wrap`, `.rp-head-in`, `.rp-brand-tile`, `.rp-foot-legal`, `.rp-scrolly`, `.rp-phone`, `.rp-grid`.
- 부모-자식 관계는 접미사로 나타낸다 (BEM과 비슷하지만 `__`/`--`는 쓰지 않는다): `.rp-foot` → `.rp-foot-in` → `.rp-foot-top` / `.rp-foot-brand` / `.rp-foot-nav`.
- 상태 클래스는 `is-` 접두사를 쓰고 JS에서만 바꾼다: `is-on` (보임/켜짐), `is-s0`·`is-s1`·`is-s2` (세 가지 이유의 단계).
- 문서 전체 모드 클래스는 `<html>`에 `rp-` 접두사로 붙인다: `rp-pin` (스크롤 고정 모드, `<head>` 스크립트가 첫 그리기 전에 붙임), `rp-ready` (`load` 뒤 부드러운 스크롤 켜기).

### IDs and data attributes (JS 연결점)

- 스크립트가 찾는 요소의 id는 `rp-` + 영역 + 역할로 쓴다: `rp-run-dot`, `rp-run-pct`, `rp-demo-prog`, `rp-demo-done`, `rp-run-btn`, `rp-hero-art`, `rp-sketch`, `rp-c-dog`. 예외로 구간 앵커 id는 짧은 영어 단어로 쓴다: `story`, `demo`, `get`, `top`.
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

- 린터 없음. 전역 규칙의 "커밋 전 린터 실행"은 이 저장소에서 `scripts/check-site.sh`로 갈음한다. 점검 항목은 넷이다: 빌드 성공, `_site`에 내부 파일 없음, 기존 URL 문서 4개(`index.html`, `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`)의 `<title>`, 처리되지 않은 Liquid 없음. `.githooks/pre-push` 훅이 `main` 푸시마다 자동으로 돌린다 (훅 켜기: `git config core.hooksPath .githooks`, 클론마다 한 번).

## CSS / Styling Patterns

### `<style>` 블록 구획 (주석 머리 `/* ── 이름 ── */`)

- 「공통」 — 네 페이지가 함께 쓰는 묶음 (`html`, `body`, `.rp-wrap`, `.rp-head*`, `.rp-brand*`, `.rp-nav`, `.rp-foot*`, `@media (max-width: 860px) { .rp-nav { display: none; } }`). 이 묶음은 `_includes/css/common.css` 한 곳에 있고, 랜딩(`index.html`)과 legal 레이아웃(`_layouts/legal.html`)의 `<style>` 안에서 `{% include css/common.css %}`로 인라인된다. 고칠 때는 그 파일만 고친다.
- 「랜딩 전용」 — `index.html`에만 있다. 새 랜딩 스타일은 여기에 넣는다.
- 「법적 페이지 전용」 — `_layouts/legal.html`의 `<style>`에 있고 법적 페이지 3종이 함께 쓴다 (`.rp-grid` 모눈종이 바탕 등).

### 반응형

- 고정 breakpoint 대신 유동 수치를 먼저 쓴다: `padding-left: clamp(20px, 5vw, 64px)`, `padding: clamp(40px, 5vw, 64px) 0`.
- 좁은 화면 규칙은 `index.html` `<style>` 끝의 `@media (max-width: 860px) { ... }` 블록 하나에 모은다. 860px가 사이트의 유일한 폭 breakpoint다.
- 창 높이에 따른 축소는 `@media (max-height: ...)`에서 `zoom`으로 한다 (`.rp-pin .rp-scrolly .rp-phone { zoom: .84; }`).
- 움직임은 `@media (prefers-reduced-motion: reduce)` 블록과 JS의 `reduced()` 확인 둘 다로 막는다.

### 법적 페이지 (Tailwind CDN)

- `https://cdn.tailwindcss.com` 런타임 JIT를 쓴다. `@apply`는 쓸 수 없다.
- 유동 수치는 arbitrary value로 쓴다: `py-[clamp(48px,6vw,80px)]`, `text-[clamp(30px,6.5vw,42px)]`, `rounded-[28px]`, `border-[1.5px]`, `tracking-[0.04em]`, `leading-[1.7]`.
- 색은 `<script id="tailwind-config">`의 토큰 이름으로만 쓴다: `text-ink`, `text-accent`, `text-muted`, `text-muted-2`, `border-line`. hex를 클래스에 직접 쓰지 않는다.
- 헤더·푸터는 Tailwind가 아니라 「공통」 `.rp-*` 클래스로 그린다.

### 색 토큰 (랜딩은 hex를 바로 씀)

| 용도 | 값 |
|---|---|
| 연필 노랑 (헤더·히어로·출시 안내 바탕, `theme-color`) | `#F2B134` |
| 흑연 (글자, 푸터 바탕) / Tailwind `ink` | `#2B2B2B` |
| 페이지 바탕 | `#FAFAF7` |
| 진한 금색 (작은 제목·링크 밑줄) / `accent` | `#7C580D` |
| 보조 글자 `muted` / `muted-2` | `#4A463F` / `#57534C` |
| 테두리·구분선 `line` | `#E4E0D6` |
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
- (법적 페이지) Tailwind CDN + `<script id="tailwind-config">` — 두 블록 모두 `_layouts/legal.html`에 있다
- `<style>`

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

- **Shared code:** Jekyll 공유 셸(Phase 2 적용됨). 공통 블록은 include 네 개(`_includes/head-links.html`, `_includes/css/common.css`, `_includes/header.html`, `_includes/footer.html`)와 레이아웃 `_layouts/legal.html`에 한 벌씩 있다. 랜딩은 front matter `layout: none`에 include 네 줄을 쓰고, 법적 3종은 `layout: legal`과 front matter로 그려진다. 법적 페이지 front matter 키는 `layout`·`title`·`description`·`eyebrow`·`heading`·`updated`·`noindex`다 (`heading`이 없으면 `title`을 쓰고, `updated`·`noindex`는 값이 있을 때만 출력한다).
  - 헤더 링크 변형은 include 매개변수로 한다. 랜딩은 `{% include header.html home=true %}`(링크 `#top`·`#story`·`#demo`·`#get`), 법적 페이지는 `{% include header.html %}`(링크 `/`·`/#story`·`/#demo`·`/#get`)다.
  - include 공백 규칙: include 태그는 0열에 혼자 두고, include 파일은 원본 들여쓰기 그대로, 끝 줄바꿈 없이 쓴다. `{%-`는 `if`/`endif`에만 쓰고 내용을 내보내는 태그에는 쓰지 않는다.
  - raw 규칙: front matter가 붙은 파일은 전체가 Liquid를 거친다. 인라인 JS·CSS에 이중 중괄호나 중괄호-퍼센트가 생기면 그 부분을 `{% raw %}`…`{% endraw %}`로 감싼다. `scripts/check-site.sh`의 4번 항목은 출력에 남은 이런 문자열을 잡으므로, raw로 일부러 내보내는 경우가 생기면 그 항목에 예외 규칙을 더한다.

- **SVG:** 모든 그림은 인라인 SVG다. 랜딩에서 두 번 이상 쓰는 도형은 `<body>` 맨 위 숨은 `<svg><defs>`에 두고 `<use href="#rp-...">`로 쓴다. 법적 페이지에는 `<defs>`가 없으므로 로고를 그 자리에 그대로 넣는다. 외부 이미지 파일을 쓰지 않는다.

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
