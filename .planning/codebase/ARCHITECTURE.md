---
last_mapped_commit: c4cb26d754e9e666c957e31fa7e559f918b425bb
last_mapped_at: 2026-11-14
---
<!-- refreshed: 2026-11-14 -->
# Architecture

**Analysis Date:** 2026-11-14

## System Overview

- 호스팅: GitHub Pages 내장 Jekyll(3.10.0)이 배포할 때 `_layouts`·`_includes`로 페이지를 조립해 정적 파일로 서빙한다. `_config.yml`은 `url`과 `exclude`를 둔다. 커스텀 도메인은 `CNAME` → runningpencil.com.
- 페이지 4개: 티저 랜딩 `index.html` (vanilla CSS + inline JS), 개인정보처리방침 `privacy-policy/index.html`, 이용약관 `terms/index.html`, 데이터 삭제 안내 `data-deletion/index.html`. 법적 페이지 3종은 정적 CSS(`_includes/css/legal.css`) + 「공통」 `.rp-*` CSS.
- include로 공유: 네 페이지가 `_includes/head-links.html`(글꼴·파비콘 링크), `_includes/css/common.css`(「공통」 CSS), `_includes/header.html`(랜딩은 `home=true`), `_includes/footer.html`을 부른다. 법적 3종은 `_layouts/legal.html` + front matter로 그려지고, 랜딩은 `layout: none`에 include 네 줄을 쓴다.
- 푸시 전 점검: `scripts/check-site.sh`(빌드·내부 파일·제목·Liquid 잔여·Tailwind 없음·랜딩 기능 이름·지원 페이지 연락처)를 `.githooks/pre-push`가 `main` 푸시마다 부른다.
- 외부 CDN: Pretendard (jsDelivr)만. 모든 페이지의 CSS는 Tailwind 없이 직접 쓴 CSS를 `<style>`에 인라인한다 (Tailwind Play CDN은 Phase 3에서 제거).
- 로컬 정적 자산: `favicon/` (svg/ico/png, `site.webmanifest`), `images/app/` (랜딩 「실제 앱 화면」 구간의 앱 화면 캡처 WebP).
- 위치 표기: `index.html` 안의 위치는 줄 번호 대신 고정점(그 파일에 한 번만 나오는 문자열: include 태그, 구획 머리 주석, 함수 이름 등)으로 적는다. 줄이 밀려도 `grep -n -F '고정점' index.html`로 찾는다. 다른 파일(`_layouts/legal.html`, `_includes/…`)의 줄 번호는 그대로 둔다.

## Component Responsibilities

| Component | Responsibility | File |
|-----------|----------------|------|
| 랜딩 페이지 | 히어로·세 가지 이유(`#story`)·달려 보기(`#demo`)·실제 앱 화면(`#screens`)·출시 안내(`#get`). 구간 순서는 `#demo` → `#screens` → `#get`이고, `.rp-get`의 음수 위 margin이 `#screens`(`z-index: 1`)의 둥근 아래 모서리 밑으로 들어간다 | `index.html` |
| Pre-paint 스크립트 | 첫 그리기 전에 `<html>`에 `rp-pin` 부여 | `index.html` `<head>`의 `<script>` (`{% include head-links.html %}` 다음) |
| head 링크 | Pretendard 글꼴 `<link>`, 파비콘·매니페스트 링크 (네 페이지 공통) | `_includes/head-links.html` (`index.html`의 `{% include head-links.html %}`, `_layouts/legal.html:14`에서 include) |
| 「공통」 CSS 묶음 | 바탕·글꼴·`.rp-wrap`·헤더(`.rp-head`,`.rp-brand`,`.rp-nav`)·푸터(`.rp-foot-*`) | `_includes/css/common.css` (`index.html`의 `{% include css/common.css %}`, `_layouts/legal.html:16`의 `<style>` 안에서 include) |
| 헤더 | 로고·워드마크·주요 메뉴. `include.home`이 참이면 랜딩 링크(`#top`·`#story`·`#demo`·`#get`), 아니면 법적 페이지 링크(`/`·`/#story`·`/#demo`·`/#get`) | `_includes/header.html` (`index.html`의 `{% include header.html home=true %}`, `_layouts/legal.html:23`) |
| 푸터 | 약관 링크 3개, 운영 안내, 사업자 정보 줄(상호·대표자·사업자등록번호)·주소 줄(`_data/company.yml`), 저작권, 경로 데이터 출처 | `_includes/footer.html` (`index.html`의 `{% include footer.html %}`, `_layouts/legal.html:40`) |
| 법적 레이아웃 | 법적 3종의 `<head>`·카드 머리(eyebrow·제목)·본문 틀(`.rp-doc`). `<style>`에 「공통」과 법적 페이지 CSS를 include. `noindex`·`updated`는 값이 있을 때만 출력, 제목은 `heading`이 없으면 `title` | `_layouts/legal.html` (`:18`에서 `_includes/css/legal.css` include) |
| 「랜딩 전용」 CSS | 스크롤리(scrollytelling), 폰 목업, 뱃지, 앱 화면 띠, 반응형 | `index.html` `<style>`의 `/* ── 랜딩 전용 ── */`부터 `</style>`까지 |
| 실제 앱 화면 구간 | 제목·「출시 준비 중」 딱지·캡처 세 장(흑연 폰 테두리 `.rp-shot-frame`)·캡션·지도 출처(「지도 © NAVER Corp.」), 좁은 화면 가로 밀기(`scroll-snap`, 스크립트 없음) | `index.html` `#screens`, `images/app/*.webp` |
| SVG 심볼 라이브러리 | 코스 path(`rp-c-*`), 지도(`rp-map-seoul`), 로고(`rp-logo`), 아이콘(`rp-i-*`), 히어로 캐릭터(`rp-t-*`) | `index.html` `<!-- Shapes: courses, map, logo, icons, hero characters -->` 아래 숨은 `<svg><defs>` |
| 랜딩 동작 스크립트 | story 단계/진행도, demo 런 애니메이션, 해시 정착, `rp-ready` | `index.html` `</body>` 앞 `<script>` (`'use strict'` IIFE) |
| 법적 페이지 토큰 | `--rp-ink`/`--rp-accent`/`--rp-muted`/`--rp-muted-2`/`--rp-line` | `_includes/css/legal.css:5` (`:root`, 3개 법적 페이지 공통) |
| 법적 페이지 CSS | Preflight 대체(`html`)·레이아웃(`body`·`main`)·`.rp-legal-*` 카드 껍데기·`.rp-doc` 본문 규칙(클래스 없는 요소)·표 감싸개 스크롤 그림자, 768px(`min-width`) 카드 안쪽 여백 | `_includes/css/legal.css` (「법적 페이지 전용」) |
| 모눈종이 바탕 | `.rp-grid` 32px 그리드 | `_includes/css/legal.css:9` |
| Jekyll 설정 | 사이트 정식 주소 `url`, 저장소 문서·빌드 파일이 사이트에 공개되지 않게 하는 열 항목 `exclude` | `_config.yml` |
| 사실값 슬롯 | 사업자 정보·연락처 값 한 곳. 값이 없는 키는 그리지 않음 (`.size > 0`) | `_data/company.yml` |
| 푸시 전 점검 | 빌드 성공, `_site`에 내부 파일 없음, 기존 URL 문서 4개의 제목, 처리되지 않은 Liquid 없음, 출력 HTML에 Tailwind Play CDN 없음, 랜딩 출력에 포인트·굿즈·코스북 없음, 지원 페이지가 있으면 연락처(mailto)가 있고 `/support/` 링크가 있으면 그 페이지가 있음 | `scripts/check-site.sh` + `.githooks/pre-push` |

## Pattern Overview

- **Overall:** 빌드 시점 조립(Jekyll include·레이아웃) 정적 멀티 페이지 사이트. 런타임 서버 없음. 페이지별 스크립트·스타일은 여전히 그 HTML 안에 인라인이다

### Key Characteristics

- 공통 블록(head 링크, 「공통」 CSS, 헤더, 푸터)은 include 네 개에 한 벌씩 있고, 법적 3종의 틀은 `_layouts/legal.html` 하나에 있다. 페이지 파일에는 그 페이지만의 내용(랜딩 마크업·CSS·JS, 법적 문서 본문과 front matter)만 있다.
- 랜딩은 라이브러리 없는 vanilla JS IIFE 하나, 상태는 클래스 토글과 CSS custom property로 DOM에 반영.
- 로고·아이콘·지도 그림·코스 선은 인라인 SVG. 반복 도형은 숨은 `<svg><defs>` + `<use href="#…">`. 예외: 「실제 앱 화면」 구간의 캡처 WebP(`images/app/`).
- 진행형 애니메이션은 JS가 CSS 변수(`--q0..2`)만 쓰고, 그림은 `calc()`/`clamp()`로 스스로 반응(선언적 렌더링).

## Layers

### Markup (구조)

- Purpose: 섹션·폰 목업·SVG 그림
- Location: `index.html`의 `<body id="top">`부터 `{% include footer.html %}`까지, 각 법적 페이지 본문(`_layouts/legal.html`의 `content` 자리). 헤더·푸터 마크업과 그 안의 로고는 `_includes/header.html`·`_includes/footer.html`
- Depends on: `<defs>` 심볼, CSS 클래스
- Used by: 스크립트(id/data 속성 계약)

### Style (표현)

- Purpose: 「공통」 → 「랜딩 전용」 또는 「법적 페이지 전용」 + 인라인 `style`
- Location: 「공통」은 `_includes/css/common.css`, 「랜딩 전용」은 `index.html`의 `<style>`, 「법적 페이지 전용」은 `_includes/css/legal.css`(레이아웃 `<style>`에 include). 법적 본문은 클래스 없는 요소에 `.rp-doc` 범위 규칙
- Depends on: `<html>` 상태 클래스(`rp-pin`, `rp-ready`), `#story`의 `--q*` 변수, `is-on`/`is-s*`

### Behavior (동작, 랜딩만)

- Purpose: 스크롤 → 단계/진행도, demo 버튼 → 7초 rAF 애니메이션
- Location: `index.html` `</body>` 앞 `<script>` (`'use strict'` IIFE)
- Depends on: id·속성 계약 (아래 참고)

## Data Flow

### Story 스크롤 고정 (`#story`)

- `<head>` 스크립트가 reduced-motion 아님 && `innerHeight <= 2400`이면 `rp-pin` 추가 (`<head>`의 `<script>`) → CSS가 `.rp-scrolly`를 340vh, `.rp-stage`를 `position: sticky`로 바꿈 (「랜딩 전용」의 `.rp-pin .rp-scrolly` 규칙)
- `scroll` 이벤트(passive) → rAF 스로틀 → `paintStory()` (`// ── 연결 ──` 아래 `window.addEventListener('scroll'`)
- `paintStory()`가 `#story`의 `getBoundingClientRect()`로 f∈[0,3) 계산, `step = floor(f)`, 단계별 진행도 q 산출 (`function paintStory()`)
- `story.style.setProperty('--q0'|'--q1'|'--q2')` (`paintStory()` 안) → `stroke-dashoffset: calc(1000px * (1 - var(--q0)))`, 번호 점 `opacity: clamp(...)`, 진행 바 `width: calc(var(--q1) * 100%)` 등이 반응 (`<section id="story"` 폰 목업의 인라인 `style`)
- `--q1`로 `#rp-run-dot`을 `getPointAtLength`로 이동, `#rp-run-pct/-dist/-time` 텍스트 갱신
- 단계 변경 시 `setStep(i)` → `[data-step]`에 `is-on`, `[data-go]`에 `is-on`+`aria-pressed`, `#rp-panel.className = 'rp-panel is-s' + i` (`function setStep(i)`)
- 단계 버튼 클릭 → `goStep(i)`: pin 상태면 해당 위치로 smooth scroll, 아니면 바로 `setStep` (`function goStep(i)`)
- `resize` → `syncLive()`가 `rp-pin`을 재판정·토글 (`function syncLive()`)

### Demo 런 (`#demo`)

- `#rp-run-btn` 클릭 → `startRun()` (`function startRun()`)
- 7000ms rAF 루프에서 `paintDemo(t)`: `#rp-demo-prog`의 `stroke-dashoffset`, `#rp-demo-dot` 위치, 퍼센트/거리(KM=7.84)/시간 텍스트
- 상태 `idle → running → done`; `setRun()`이 `#rp-run-label` 문구, `#rp-run-icon`의 `href`(`#rp-i-play`↔`#rp-i-replay`), `#rp-demo-done`의 `is-on` 토글 (`function setRun(run)`)

### 초기 정착 & `rp-ready`

- 첫 navigate이고 `location.hash`가 있으면 대상 요소를 기억 (`// ── 연결 ──` 아래 `var target`와 `decodeURIComponent` 줄)
- `load`와 `document.fonts.ready`에서 `settle()` → 사용자 입력(wheel/touch/key/mouse) 전까지 대상으로 `scrollIntoView({behavior:'instant'})` (`function settle()`)
- `load` 후 `<html>`에 `rp-ready` → `scroll-behavior: smooth` 활성 (「랜딩 전용」의 `html.rp-ready { scroll-behavior: smooth; }`, `window.addEventListener('load'`)
- reduced-motion이면 `#rp-hero-art` SMIL 정지, `#rp-sketch`는 6.6s 지점에서 정지 (스크립트 끝 `// 움직임 줄이기 설정이면` 주석 아래 `pauseAnimations()`)

### State Management

- JS 내부 `state = { step, live, run }` (`var state =`) 하나. DOM 측 상태는 클래스(`rp-pin`, `rp-ready`, `is-on`, `is-s0..2`)와 CSS 변수(`--q0..2`). 영속 저장 없음.

## Key Abstractions

### SVG 심볼 + `<use>`

- Purpose: 코스 선·아이콘·지도를 한 번 정의, 여러 곳에서 다른 stroke로 재사용
- Examples: `<defs>` 안의 `<path id="rp-c-dog" pathLength="1000"`, 사용처는 `<use href="#rp-c-dog">` (`grep -n -F 'href="#rp-c-dog"' index.html`)
- Pattern: 코스 path는 `pathLength="1000"`으로 정규화 → `stroke-dasharray: 1000px`로 진행도 표현. `#rp-c-dog`는 JS의 `getPointAtLength` 기준 경로이기도 함.

### 진행도 CSS 변수

- Purpose: JS→그림 단방향 데이터 전달
- Examples: `#story` 초기값 `style="--q0: 1; --q1: 0.62; --q2: 1"` (`<section id="story"`) — JS 비활성 시 정지 장면

### 공유 헤더/푸터

- Purpose: 4페이지 동일 브랜딩. 헤더는 `_includes/header.html`, 푸터는 `_includes/footer.html` 한 벌을 네 페이지가 부른다. 헤더 링크 변형은 include 매개변수(`{% include header.html home=true %}`)로 한다
- 로고는 법적 페이지에 `<defs>`가 없어 `<use>` 없이 인라인 path로 직접 넣는다 (`_includes/header.html:5`, `_includes/footer.html:7`)

## Entry Points

- **`index.html`:** 루트 `/`. 티저 랜딩. `<body id="top">`. front matter `layout: none`.
- **`privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`:** `/privacy-policy/` 등 디렉터리 인덱스 URL. front matter `layout: legal`, `noindex`. 앱 스토어 심사용.
- **`favicon/site.webmanifest`:** PWA 매니페스트 (theme `#F2B134`).

## Architectural Constraints

- **Threading:** 브라우저 메인 스레드 단일. 스크롤 핸들러는 rAF 1프레임 1회로 스로틀.
- **Global state:** 전역 오염 없음 — 스크립트 전체가 `'use strict'` IIFE (`</body>` 앞 `<script>`). 법적 페이지에는 스크립트가 없다.
- **Circular imports:** 해당 없음 (모듈 시스템 없음).
- **절대 경로 의존:** `/favicon/...`, `/terms/`, `/#story`는 커스텀 도메인 루트 전제. `file://` 또는 `slimpumpkin.github.io/<repo>/` 하위 경로에서는 깨짐.
- **Markup–Script 계약:** 스크립트는 id `story`, `rp-panel`, `rp-run-dot|pct|time|dist|btn|icon|label`, `rp-demo-prog|dot|pct|dist|time|done`, `rp-c-dog`, `rp-hero-art`, `rp-sketch`와 속성 `data-step`(0~2, 글 3 + 폰 화면 3), `data-go`(버튼 3)에 의존. null 체크 없음(`rp-hero-art`/`rp-sketch` 제외) → 하나라도 빠지면 스크립트 전체가 예외로 중단.
- **Liquid 처리:** front matter가 붙은 페이지는 전체가 Liquid를 거친다. 인라인 JS·CSS에 이중 중괄호나 중괄호-퍼센트가 생기면 `{% raw %}`로 감싼다 (`scripts/check-site.sh` 4번 항목이 출력에 남은 것을 잡는다).
- **CDN 의존:** 글꼴(Pretendard)만 런타임 로드. 오프라인이면 「공통」 `font-family`의 대체 글꼴(시스템 글꼴)로 보이고 레이아웃은 그대로다.

## Anti-Patterns

### 공통 블록을 페이지 파일에 다시 써 넣음

- **What happens:** 「공통」 CSS/헤더/푸터/`<head>` 링크를 include로 부르지 않고 `index.html`이나 법적 페이지 파일에 마크업째 복사함
- **Why it's wrong:** 사본이 생겨 include와 페이지 사이에 드리프트 발생
- **Do this instead:** 해당 include(`_includes/head-links.html`, `_includes/css/common.css`, `_includes/header.html`, `_includes/footer.html`) 한 곳을 고침. 법적 3종의 틀은 `_layouts/legal.html` 한 곳을 고침. 헤더 링크 차이는 `home=true` 매개변수로 냄.

### include 공백 규칙 어김

- **What happens:** include 태그를 들여쓴 자리에 두거나, include 파일 끝에 줄바꿈을 남기거나, 내용을 내보내는 태그에 `{%-`를 씀
- **Why it's wrong:** 출력의 들여쓰기·줄바꿈이 원본과 달라짐
- **Do this instead:** include 태그는 0열에 혼자 두고, include 파일은 원본 들여쓰기 그대로 끝 줄바꿈 없이 씀. `{%-`는 `if`/`endif`에만 씀.

### 법적 본문에 클래스나 범위 없는 선택자 추가

- **What happens:** 법적 본문 요소에 `class`를 붙이거나, `_includes/css/legal.css`에 `.rp-doc` 없이 본문 요소 선택자(`h2`, `p`, `ul`, `table` 등)를 씀. 또는 유틸리티 클래스를 씀
- **Why it's wrong:** 법적 본문 작성 규칙(`CONVENTIONS.md` 「법적 본문 작성 규칙」) 위반. 범위 없는 요소 규칙은 사이트 머리말·바닥글로 새고, `common.css`에 넣으면 랜딩까지 바뀜. 모든 페이지가 Tailwind 없이 직접 쓴 CSS라 유틸리티 클래스는 효과가 없음
- **Do this instead:** 본문은 클래스 없는 허용 요소만 씀. 새 모양은 `_includes/css/legal.css`에 `.rp-doc` 아래 규칙으로 더하고, 허용 요소 목록(legal.css 맨 위 주석, `CONVENTIONS.md`)도 함께 고침. 랜딩 스타일은 「랜딩 전용」 블록(`/* ── 랜딩 전용 ── */` 이후)에 `.rp-*` 클래스로, 좁은 화면 규칙은 `@media (max-width: 860px)` (「랜딩 전용」 끝)에.

### JS에서 그림 속성 직접 조작

- **What happens:** story 그림 요소의 style을 스크립트가 개별 설정
- **Why it's wrong:** 기존 패턴은 `--q*` 변수만 쓰고 CSS가 반응; 분산되면 무-JS 기본 장면도 깨짐
- **Do this instead:** 새 진행형 효과는 `var(--q0..2)` 기반 `calc()`로 인라인 style에 선언.

## Error Handling

- **Strategy:** 방어적 try/catch로 조용히 폴백 (기능 저하 허용)

### Patterns

- `moveTo()`의 `getPointAtLength` 실패 시 점을 출발점에 둠 (`function moveTo(el, q)`)
- 깨진 해시 `decodeURIComponent` 실패 무시 (`// ── 연결 ──` 아래 `var target` 다음 `try` 줄)
- `scrollIntoView({behavior:'instant'})` 미지원 시 `scrollIntoView(true)` 폴백
- `window.matchMedia`, `document.fonts`, `performance.getEntriesByType`, `pauseAnimations` 존재 여부 확인 후 사용

## Cross-Cutting Concerns

- **Logging:** 없음 (console 사용 없음)
- **Validation:** 해당 없음 (폼·입력 없음; 이메일 수집 폼 의도적으로 없음)
- **Authentication:** 해당 없음
- **Accessibility:** `prefers-reduced-motion` 존중(pin 비활성, SMIL 정지, smooth scroll 끔), `aria-pressed` 동기화, `aria-labelledby` 섹션, `:focus-visible` 아웃라인, 장식 SVG `aria-hidden`.

---

*Architecture analysis: 2026-11-14*
