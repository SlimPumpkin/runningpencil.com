## 이번 마일스톤 방침 (2026-11 결정)

이번 마일스톤(티저 유지 + 심사 대응)에서 정한 방침입니다. 표의 방침은 「적용 단계」가 오기 전에는 사이트 코드에 반영하지 않습니다. 이 구간 아래의 설명은 지금 코드의 실제 모습입니다. 이 구간은 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`에 같은 내용으로 둡니다.

| 방침 | 적용 단계 | 현재 상태 (2026-11 기준) | 이유 | 출처 |
|---|---|---|---|---|
| 영문 서비스명 RunningPencil | Phase 9 영문판(`/en/`), 콘솔·스토어의 영어 표시명 | 결정됨. 현재 사이트 본문에는 한국어 이름만 있습니다 | 영문판과 콘솔·스토어에서 같은 이름을 써야 합니다. 이전 방침을 뒤집음 | `.planning/baseline/NAMES.md`, `.planning/PROJECT.md` Key Decisions |
| 지원 이메일 공개 | Phase 5 이메일 게이트(외부 4곳 수신 시험 통과) 뒤. 푸터, `/support/`, 법적 문서 | 결정됨. 주소의 정본은 이름 표(`.planning/baseline/NAMES.md`)입니다. 사이트(HTML·`_data`)에는 아직 없고 `.planning/` 문서에만 있습니다. 저장소가 공개라 `.planning/` 문서의 주소는 GitHub에서 누구나 볼 수 있습니다 | Google Play 웹 삭제 요청, App Store Support URL, 처리방침의 보호책임자 연락처에 연락 수단이 필요합니다. 이전 방침을 뒤집음 | `.planning/PROJECT.md` Key Decisions, `.planning/baseline/USER-TASKS.md` |
| 사업자 정보 표시 (상호·대표자·사업자등록번호·주소) | Phase 5 (푸터와 `_data` 슬롯), Phase 8·9 | 결정됨. 값은 사용자가 주기 전이라 어디에도 없습니다. 값이 없는 항목은 행을 숨깁니다 (render-if-present) | 카카오 비즈앱 심사가 사업자와 서비스의 관계를 확인합니다 | `.planning/PROJECT.md` Key Decisions, `.planning/baseline/NAMES.md` |
| 한국어 + 영어 제공 | Phase 9 (`/en/` 아래 영문판) | 결정됨. 현재 페이지는 모두 한국어(`lang="ko"`)입니다 | Google·Facebook·Apple·LINE 심사자가 읽을 수 있어야 합니다. 이전 방침을 뒤집음 | `.planning/PROJECT.md` Key Decisions, `.planning/baseline/URLS.md` |
| Jekyll 빌드 전환 | Phase 2 (공유 셸 `_layouts`·`_includes`), Phase 3 (Tailwind CDN을 정적 CSS로) | 결정됨. 현재는 빌드 없이 공통 블록을 네 파일에 복사하고 `python3 -m http.server`로 미리 봅니다 | 페이지가 늘수록 복사한 공통 블록이 어긋날 위험이 커집니다. 이전 방침을 뒤집음 | `.planning/PROJECT.md` Key Decisions, `.planning/ROADMAP.md` Phase 2·3 |
| 포인트·굿즈·코스북 제거 | Phase 4 (랜딩), Phase 6·7·8 (법적 문서) | 결정됨 (U10). 현재 랜딩과 법적 문서 본문에는 남아 있습니다 | 출시 시점 앱에 없는 기능입니다. 심사는 사이트와 앱이 일치하는지 봅니다 | `.planning/PROJECT.md` Key Decisions |
| 법적 페이지 `noindex` 해제와 「임시 게시본」 문구 삭제 | Phase 6 (삭제 안내), Phase 7 (처리방침), Phase 8 (이용약관). 각 문서를 다시 쓰는 커밋에서 | 결정됨 (U14). 현재 세 문서에 `noindex`와 「임시 게시본」 표시가 있습니다 | 미완성 사이트로 보이면 심사에서 반려될 수 있습니다 | `.planning/PROJECT.md` Key Decisions, `.planning/ROADMAP.md` Phase 6·7·8 Notes |

### 작업 규칙

모든 단계에 적용하는 규칙입니다. GSD 밖에서 연 세션과 다른 도구도 지킵니다.

- `main` 푸시가 곧 배포입니다 (CI 없음). 모든 단계는 그대로 라이브에 올라가도 되는 상태로 끝냅니다.
- 기존 URL `/privacy-policy/`, `/terms/`, `/data-deletion/`은 경로를 바꾸지 않고 리디렉션도 걸지 않습니다. 배포할 때마다 세 URL이 200과 같은 문서 제목을 돌려주는지 확인합니다.
- 리팩터, 시각 변경, 내용 변경을 한 단계나 한 커밋에 섞지 않습니다.
- Phase 2 이후에는 푸시 전에 로컬 Jekyll 3.10.0 빌드가 성공하는지 확인합니다.
- 사용자가 줄 사실값(사업자 정보, 지원 이메일, 보호책임자)은 추측해서 채우지 않습니다. 값이 없으면 행·문단을 숨깁니다 (render-if-present). 단, 빠지면 안 되는 조항이 있는 페이지는 값이 올 때까지 커밋을 보류합니다 (예: 처리방침의 보호책임자, 위치기반서비스 이용약관의 사업자 상호·주소·연락처).
- 「추후 기재」 같은 자리표시 값을 쓰지 않습니다.
- JS 언어 자동 리디렉션, `robots.txt` 차단, `.nojekyll`, Jekyll i18n 플러그인을 쓰지 않습니다.
- 방침이나 구조를 바꾸는 단계는 그 단계 안에서 `CLAUDE.md`도 함께 고칩니다. 이 방침 구간은 루트 `CLAUDE.md`와 `.claude/CLAUDE.md` 두 사본을 같은 커밋에서 똑같이 고칩니다. `.claude/CLAUDE.md`의 GSD 생성 구간 가운데 `project`·`stack`·`conventions`·`architecture` 구간은 직접 고치지 않고, 원본(`.planning/PROJECT.md`, `.planning/codebase/STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md`)을 고친 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 다시 만듭니다. `skills`·`workflow`·`profile` 구간은 도구가 관리하므로 고치지 않습니다.
- 법적 본문에는 데이터 목록(`.planning/baseline/DATA-INVENTORY.md`)에 있는 사실만 씁니다. 이 규칙의 출처는 `.planning/ROADMAP.md`의 Phase 6·7 성공 기준과 `.planning/PROJECT.md`의 Constraints(Legal drafts)입니다.

마지막 규칙(데이터 목록)을 뺀 나머지 규칙의 원본은 `.planning/ROADMAP.md`의 Ground Rules입니다. 기준 문서는 `.planning/baseline/`에 있습니다 (이름 표 `NAMES.md`, URL 대장 `URLS.md`, 데이터 목록 `DATA-INVENTORY.md`, 결정 목록 `DECISIONS.md`, 사용자 작업 절차서 `USER-TASKS.md`).

<!-- GSD:project-start source:PROJECT.md -->

## Project

**러닝펜슬 웹사이트 (runningpencil.com)**

모바일 앱 러닝펜슬(지도 위 GPS 아트 코스를 걷거나 달려 완주하면 코스 모양 뱃지를 모으고, 직접 그린 코스를 공개할 수 있는 앱)의 공식 웹사이트입니다. GitHub Pages 정적 사이트이고, 운영사는 슬림펌킨입니다. 서비스가 오픈할 때까지는 티저 랜딩을 유지하면서, 소셜 로그인 제공자 6곳(카카오·네이버·Google·Apple·Facebook·LINE)의 비즈앱 등록과 프로덕션 심사, 양 스토어 등록에 필요한 홈페이지·개인정보처리방침·이용약관·데이터 삭제 안내·지원 URL을 제공합니다. 오픈 후에는 앱스토어 뱃지, 평점, 인기 코스, 명예의 전당, 사용자 리뷰 같은 실데이터를 보여 주는 데스크톱용 웹사이트로 키울 예정입니다. 이 확장은 다음 마일스톤에서 합니다.

**Core Value:** 소셜 로그인 제공자와 스토어 심사자가 이 사이트만 보고 러닝펜슬이 어떤 서비스인지, 누가 운영하는지, 어떤 개인정보를 어떻게 처리하는지, 어떻게 연락하고 데이터를 지울 수 있는지 확인할 수 있어야 합니다. 그래서 심사가 웹사이트 때문에 반려되지 않아야 합니다.

### Constraints

- **Hosting**: GitHub Pages 정적 호스팅이고 `main` 푸시가 곧 배포입니다 — 서버 처리·폼·DB가 없으므로, 깨진 HTML이 바로 라이브에 올라가지 않게 푸시 전 로컬 확인이 필요합니다
- **Domain**: `/favicon/...`, `/terms/` 같은 절대 경로는 커스텀 도메인 연결이 전제입니다 — 프로젝트 사이트라 도메인이 풀리면 하위 경로로 서빙되어 깨집니다
- **Same-domain legal URLs**: 처리방침·약관·삭제 안내·지원 페이지는 모두 `runningpencil.com` 아래에 둡니다 — Google 검증이 홈페이지와 같은 도메인을 요구합니다
- **User-supplied facts**: 사업자 정보(대표자·사업자등록번호·주소), 지원 메일 주소, 메일 라우팅·DNS, Search Console 인증은 사용자가 주거나 직접 합니다 — 추측해서 채우지 않습니다
- **Legal drafts**: 법적 본문은 앱 코드에서 확인한 사실에만 근거해 씁니다 — 법률 검토 전 초안이며, 확인 안 된 항목은 표시해 둡니다
- **Language**: 한국어가 기본이고 영문판을 병행합니다 — 영문 서비스명은 스토어 등록명·동의 화면과 일치해야 합니다
- **Visual language**: 기존 디자인(연필 노랑 `#F2B134`, 흑연 `#2B2B2B`, Pretendard, 모눈종이 법적 페이지)을 유지합니다 — 이번 범위는 심사 대응이지 리디자인이 아닙니다

<!-- GSD:project-end -->

<!-- GSD:stack-start source:codebase/STACK.md -->

## Technology Stack

## Languages

- HTML5 - 모든 페이지 (`index.html`, `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`), `<html lang="ko">`
- CSS - 각 HTML의 `<head>` 내 `<style>` 한 블록(「공통」 + 「랜딩 전용」/「법적 페이지 전용」) 및 인라인 `style`
- JavaScript (vanilla, 라이브러리 없음) - `index.html`의 `<head>` 짧은 스크립트(`rp-pin` 부여)와 `</body>` 앞 인라인 스크립트(스크롤 단계, 달려 보기 데모, `rp-ready`)
- SVG (인라인) - 로고·아이콘·지도 그림, `index.html` `<body>` 맨 위 숨은 `<svg><defs>` + `<use href="#…">`; `favicon/favicon.svg`
- YAML - `_config.yml` (Jekyll 설정)
- JSON - `favicon/site.webmanifest`

## Runtime

- 브라우저만 (서버 측 런타임 없음). GitHub Pages가 정적 파일을 그대로 서빙
- 로컬 미리보기: `python3 -m http.server 8000` (저장소 루트를 서버 루트로; `file://`는 절대 경로 때문에 깨짐)
- 없음 (`package.json`, lockfile 없음)
- Lockfile: missing (해당 없음)

## Frameworks

- 없음 - 랜딩(`index.html`)은 프레임워크·Tailwind 미사용, 순수 CSS
- Tailwind CSS (CDN 런타임/Play CDN, 버전 고정 없음) - 법적 페이지 3종 본문 스타일. `<script src="https://cdn.tailwindcss.com">` + 인라인 `<script id="tailwind-config">`의 `tailwind.config` 토큰(`ink`, `accent`, `muted`, `muted-2`, `line`)
- Not detected
- 빌드 도구 없음 (no bundler, no linter, no formatter)
- Jekyll (GitHub Pages 내장) - 배포 시 한 번 거침, `_config.yml`의 `exclude`만 사용

## Key Dependencies

- Pretendard Variable `v1.3.9` (dynamic subset) - 네 페이지 공통 글꼴
- Tailwind CSS Play CDN - `https://cdn.tailwindcss.com` (버전 미고정, 법적 페이지 3종만). 프로덕션 비권장 방식, `@apply` 불가
- GitHub Pages + 사용자 지정 도메인(`CNAME`: `runningpencil.com`)

## Configuration

- 환경변수·`.env` 없음 (서버 처리 없음)
- 메타: `theme-color #F2B134`, Open Graph(`og:url https://runningpencil.com/`, `og:image .../favicon/web-app-manifest-512x512.png`) - `index.html`; 법적 페이지는 `<meta name="robots" content="noindex">`
- `_config.yml` - `exclude: [CNAME, CLAUDE.md, README.md, .planning/]`. 새 마크다운 문서 추가 시 여기에도 등록
- `CNAME` - `runningpencil.com`
- `.gitignore` - `prepare/`, `.DS_Store`, `.playwright-mcp/`, `.planning/research/.cache/`(GSD 연구 캐시)
- `favicon/site.webmanifest` - name/short_name `러닝펜슬`, `display: standalone`, `theme_color`/`background_color` `#F2B134`, maskable 192/512 아이콘

## Platform Requirements

- 텍스트 에디터 + 정적 서버(`python3 -m http.server`) + 인터넷(CDN 글꼴·Tailwind)
- 아이콘 재생성 시 `rsvg-convert` 등 (8배 렌더 후 8×8 평균 축소)
- GitHub Pages (조직 `SlimPumpkin` 프로젝트 사이트), `main` 푸시 = 배포. 절대 경로(`/favicon/...`, `/terms/`)는 커스텀 도메인 연결을 전제

<!-- GSD:stack-end -->

<!-- GSD:conventions-start source:CONVENTIONS.md -->

## Conventions

## Naming Patterns

### Files

- 페이지마다 디렉터리 하나에 `index.html` 하나를 둔다 (pretty URL): `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`. 디렉터리 이름은 kebab-case 영어로 쓴다.
- 에셋은 `favicon/` 아래에 kebab-case와 크기 접미사로 둔다: `favicon-96x96.png`, `web-app-manifest-192x192.png`, `web-app-manifest-512x512.png`.

### CSS classes

- 직접 만든 클래스에는 모두 `rp-` 접두사를 붙이고 kebab-case로 쓴다: `.rp-wrap`, `.rp-head-in`, `.rp-brand-tile`, `.rp-foot-legal`, `.rp-scrolly`, `.rp-phone`, `.rp-grid`.
- 부모-자식 관계는 접미사로 나타낸다 (BEM과 비슷하지만 `__`/`--`는 쓰지 않는다): `.rp-foot` → `.rp-foot-in` → `.rp-foot-top` / `.rp-foot-brand` / `.rp-foot-nav`.
- 상태 클래스는 `is-` 접두사를 쓰고 JS에서만 바꾼다: `is-on` (보임/켜짐), `is-s0`·`is-s1`·`is-s2` (세 가지 이유의 단계).
- 문서 전체 모드 클래스는 `<html>`에 `rp-` 접두사로 붙인다: `rp-pin` (스크롤 고정 모드, `<head>` 스크립트가 첫 그리기 전에 붙임), `rp-ready` (`load` 뒤 부드러운 스크롤 켜기).

### IDs and data attributes (JS 연결점)

- 스크립트가 찾는 요소의 id는 `rp-` + 영역 + 역할로 쓴다: `rp-run-dot`, `rp-run-pct`, `rp-demo-prog`, `rp-demo-done`, `rp-run-btn`, `rp-hero-art`, `rp-sketch`, `rp-c-dog`. 예외로 구간 앵커 id는 짧은 영어 단어로 쓴다: `story`, `demo`, `get`, `top`.
- SVG `<defs>` 심볼 id: 아이콘은 `rp-i-*` (`#rp-i-play`, `#rp-i-replay`), 코스 선은 `rp-c-*` (`#rp-c-dog`).
- 반복 요소에는 인덱스 data 속성을 쓴다: 내용은 `data-step="0..2"`, 버튼은 `data-go="0..2"`.
- id·class·data 속성 이름을 바꾸면 `index.html` 끝(약 495행)의 인라인 스크립트도 반드시 같이 고친다.

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

- 린터 없음. CLAUDE.md의 "커밋 전 린터 실행" 규칙은 이 저장소에는 적용할 도구가 없으므로, 대신 로컬 미리보기 확인으로 갈음한다 (`TESTING.md` 참고).

## CSS / Styling Patterns

### `<style>` 블록 구획 (주석 머리 `/* ── 이름 ── */`)

- 「공통」 — 네 페이지가 **똑같이 복사**하는 묶음 (`html`, `body`, `.rp-wrap`, `.rp-head*`, `.rp-brand*`, `.rp-nav`, `.rp-foot*`, `@media (max-width: 860px) { .rp-nav { display: none; } }`). 고칠 때는 `index.html`, `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html` 네 파일을 함께 고친다.
- 「랜딩 전용」 — `index.html`에만 있다. 새 랜딩 스타일은 여기에 넣는다.
- 「법적 페이지 전용」 — 법적 페이지 3종에 있다 (`.rp-grid` 모눈종이 바탕 등).

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
- Pretendard 글꼴 `<link>` (jsDelivr `orioncactus/pretendard@v1.3.9`, 네 페이지 같은 줄)
- 파비콘·매니페스트 `<link>` (`/favicon/...`)
- (법적 페이지) Tailwind CDN + `<script id="tailwind-config">`
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
- **Shared code:** 현재는 빌드가 없어 공통 템플릿을 쓸 수 없다 (2026-11 기준, Phase 2까지 유효). Phase 2에서 Jekyll 공유 셸(`_includes`·`_layouts`)로 한 곳에 모은다. 공통 `<head>` 링크, 「공통」 CSS, 헤더·푸터 마크업은 네 파일에 **복사**한다. 다른 점은 링크 주소뿐이다 (랜딩 `#top`·`#story`·`#demo`·`#get`, 법적 페이지 `/`·`/#story`·`/#demo`·`/#get`).
- **SVG:** 모든 그림은 인라인 SVG다. 랜딩에서 두 번 이상 쓰는 도형은 `<body>` 맨 위 숨은 `<svg><defs>`에 두고 `<use href="#rp-...">`로 쓴다. 법적 페이지에는 `<defs>`가 없으므로 로고를 그 자리에 그대로 넣는다. 외부 이미지 파일을 쓰지 않는다.
## Content & Naming Rules
- 현재 페이지는 모두 `<html lang="ko">`이고 본문은 한국어다 (2026-11 기준). Phase 9에서 `/en/` 아래에 영문판(`lang="en"`)이 생기고, 그 뒤로는 한국어와 영어를 함께 제공한다.
- 서비스 이름은 한국어 **러닝펜슬**, 영어 `RunningPencil`이다. 정본은 이름 표(`.planning/baseline/NAMES.md`)이고 사이트·콘솔·스토어에서 같은 값을 쓴다. 현재 사이트(제목, meta, 매니페스트, 워드마크, 본문)에는 한국어 이름만 있다 (2026-11 기준). 영문 이름은 Phase 9 영문판(`/en/`)부터 쓴다. `runningpencil.com`은 도메인 표기다.
- 운영 회사는 **슬림펌킨**: 저작권 표기, 푸터 운영 안내 문장, 법적 페이지의 `(이하 "회사")` 주체.
- 이메일 수집 폼과 서버 처리는 만들지 않는다 (정적 호스팅, `.planning/REQUIREMENTS.md` Out of Scope). 연락 수단은 이메일 게이트(Phase 5) 뒤 공개하는 지원 이메일 하나로 한다. 현재는 문의 채널이 없다 (2026-11 기준).
- 현재 사이트에는 지원 이메일이 없다 (2026-11 기준). 이메일 게이트(Phase 5: 외부 4곳 수신 시험 통과)가 열리면 지원 이메일을 푸터, 지원 페이지, 법적 문서에 넣는다. 그전에는 주소를 HTML·`_data`에 넣지 않는다. 주소의 정본은 이름 표(`.planning/baseline/NAMES.md`)이고, 사이트(HTML·`_data`)에는 없고 `.planning/` 문서에만 있다. 저장소가 공개라 `.planning/` 문서의 주소는 GitHub에서 누구나 볼 수 있다. HTML·`_data`에 넣지 않는 규칙은 사이트 노출만 막는다.
- 현재 법적 페이지 3종에는 `<meta name="robots" content="noindex">`와 「임시 게시본」 표시가 있다 (2026-11 기준). 문서를 다시 쓰는 커밋(Phase 6 삭제 안내, Phase 7 처리방침, Phase 8 이용약관)에서 둘 다 지운다 (U14).
- 새 마크다운 문서를 추가하면 `_config.yml`의 `exclude`에 적는다.

## Commit Messages
- Conventional Commits, prefix는 영어, 제목은 한국어 (`git log`). 예는 아래 두 줄이다.
- 예: `feat: 티저 랜딩 새 디자인 적용, 법적 페이지·파비콘 개편`
- 예: `feat: RunningPencil 티저 사이트 초기 구성`
- `main` 푸시가 곧 배포이므로 커밋 전에 로컬 미리보기로 확인한다.

<!-- GSD:conventions-end -->

<!-- GSD:architecture-start source:ARCHITECTURE.md -->

## Architecture

## System Overview
- 호스팅: GitHub Pages가 Jekyll을 한 번 거쳐 정적 파일을 그대로 서빙한다 (`_config.yml`의 `exclude`만 씀). 커스텀 도메인은 `CNAME` → runningpencil.com.
- 페이지 4개: 티저 랜딩 `index.html` (vanilla CSS + inline JS), 개인정보처리방침 `privacy-policy/index.html`, 이용약관 `terms/index.html`, 데이터 삭제 안내 `data-deletion/index.html`. 법적 페이지 3종은 Tailwind CDN runtime + 공통 `.rp-*` CSS.
- 복사로 공유: 네 페이지가 `<head>` 글꼴/파비콘 링크, 「공통」 CSS, 헤더·푸터 마크업을 복사해서 같이 쓴다.
- 외부 CDN: Pretendard (jsDelivr) · Tailwind (`cdn.tailwindcss.com`, 법적 페이지만).
- 로컬 정적 자산: `favicon/` (svg/ico/png, `site.webmanifest`).
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
- **Overall:** Build-less 정적 멀티 페이지 사이트 (self-contained HTML per page)

### Key Characteristics

- 페이지마다 HTML·CSS·JS가 한 파일 안에 완결됨. 공통 템플릿·include 없음 → 공유 부분은 수동 복사.
- 랜딩은 라이브러리 없는 vanilla JS IIFE 하나, 상태는 클래스 토글과 CSS custom property로 DOM에 반영.
- 시각 자산은 전부 인라인 SVG. 반복 도형은 숨은 `<svg><defs>` + `<use href="#…">`.
- 진행형 애니메이션은 JS가 CSS 변수(`--q0..2`)만 쓰고, 그림은 `calc()`/`clamp()`로 스스로 반응(선언적 렌더링).

## Layers

### Markup (구조)

- Purpose: 섹션·폰 목업·SVG 그림
- Location: `index.html:150-494`, 각 법적 페이지 `<body>`
- Depends on: `<defs>` 심볼, CSS 클래스
- Used by: 스크립트(id/data 속성 계약)

### Style (표현)

- Purpose: 「공통」 → 「랜딩 전용」 또는 「법적 페이지 전용」 + 인라인 `style`
- Location: 각 파일 `<head>`의 `<style>`; 법적 페이지 본문은 Tailwind 유틸리티 클래스
- Depends on: `<html>` 상태 클래스(`rp-pin`, `rp-ready`), `#story`의 `--q*` 변수, `is-on`/`is-s*`

### Behavior (동작, 랜딩만)

- Purpose: 스크롤 → 단계/진행도, demo 버튼 → 7초 rAF 애니메이션
- Location: `index.html:495-650`
- Depends on: id·속성 계약 (아래 참고)

## Data Flow

### Story 스크롤 고정 (`#story`)
- `<head>` 스크립트가 reduced-motion 아님 && `innerHeight <= 2400`이면 `rp-pin` 추가 (`index.html:28`) → CSS가 `.rp-scrolly`를 340vh, `.rp-stage`를 `position: sticky`로 바꿈 (`index.html:97-115`)
- `scroll` 이벤트(passive) → rAF 스로틀 → `paintStory()` (`index.html:621-624`)
- `paintStory()`가 `#story`의 `getBoundingClientRect()`로 f∈[0,3) 계산, `step = floor(f)`, 단계별 진행도 q 산출 (`index.html:552-571`)
- `story.style.setProperty('--q0'|'--q1'|'--q2')` (`index.html:563-565`) → `stroke-dashoffset: calc(1000px * (1 - var(--q0)))`, 번호 점 `opacity: clamp(...)`, 진행 바 `width: calc(var(--q1) * 100%)` 등이 반응 (`index.html:325-391`)
- `--q1`로 `#rp-run-dot`을 `getPointAtLength`로 이동, `#rp-run-pct/-dist/-time` 텍스트 갱신
- 단계 변경 시 `setStep(i)` → `[data-step]`에 `is-on`, `[data-go]`에 `is-on`+`aria-pressed`, `#rp-panel.className = 'rp-panel is-s' + i` (`index.html:535-544`)
- 단계 버튼 클릭 → `goStep(i)`: pin 상태면 해당 위치로 smooth scroll, 아니면 바로 `setStep` (`index.html:574-582`)
- `resize` → `syncLive()`가 `rp-pin`을 재판정·토글 (`index.html:547-549`)
### Demo 런 (`#demo`)
- `#rp-run-btn` 클릭 → `startRun()` (`index.html:604-614`)
- 7000ms rAF 루프에서 `paintDemo(t)`: `#rp-demo-prog`의 `stroke-dashoffset`, `#rp-demo-dot` 위치, 퍼센트/거리(KM=8.3)/시간 텍스트
- 상태 `idle → running → done`; `setRun()`이 `#rp-run-label` 문구, `#rp-run-icon`의 `href`(`#rp-i-play`↔`#rp-i-replay`), `#rp-demo-done`의 `is-on` 토글 (`index.html:597-602`)
### 초기 정착 & `rp-ready`
- 첫 navigate이고 `location.hash`가 있으면 대상 요소를 기억 (`index.html:625-627`)
- `load`와 `document.fonts.ready`에서 `settle()` → 사용자 입력(wheel/touch/key/mouse) 전까지 대상으로 `scrollIntoView({behavior:'instant'})` (`index.html:630-637`)
- `load` 후 `<html>`에 `rp-ready` → `scroll-behavior: smooth` 활성 (`index.html:62`, `:636`)
- reduced-motion이면 `#rp-hero-art` SMIL 정지, `#rp-sketch`는 6.6s 지점에서 정지 (`index.html:643-647`)

### State Management

- JS 내부 `state = { step, live, run }` (`index.html:513`) 하나. DOM 측 상태는 클래스(`rp-pin`, `rp-ready`, `is-on`, `is-s0..2`)와 CSS 변수(`--q0..2`). 영속 저장 없음.

## Key Abstractions

### SVG 심볼 + `<use>`

- Purpose: 코스 선·아이콘·지도를 한 번 정의, 여러 곳에서 다른 stroke로 재사용
- Examples: `index.html:154` `<path id="rp-c-dog" pathLength="1000">`, 사용처 `index.html:325,326,340,356,391`
- Pattern: 코스 path는 `pathLength="1000"`으로 정규화 → `stroke-dasharray: 1000px`로 진행도 표현. `#rp-c-dog`는 JS의 `getPointAtLength` 기준 경로이기도 함.

### 진행도 CSS 변수

- Purpose: JS→그림 단방향 데이터 전달
- Examples: `#story` 초기값 `style="--q0: 1; --q1: 0.62; --q2: 1"` (`index.html:249`) — JS 비활성 시 정지 장면

### 공유 헤더/푸터

- Purpose: 4페이지 동일 브랜딩. 로고는 법적 페이지에 `<defs>`가 없어 인라인 path로 직접 삽입 (`index.html:188`)

## Entry Points
- **`index.html`:** 루트 `/`. 티저 랜딩. `<body id="top">`.
- **`privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`:** `/privacy-policy/` 등 디렉터리 인덱스 URL. `noindex`. 앱 스토어 심사용.
- **`favicon/site.webmanifest`:** PWA 매니페스트 (theme `#F2B134`).
## Architectural Constraints

- **Threading:** 브라우저 메인 스레드 단일. 스크롤 핸들러는 rAF 1프레임 1회로 스로틀.
- **Global state:** 전역 오염 없음 — 스크립트 전체가 `'use strict'` IIFE (`index.html:497`). Tailwind만 `window.tailwind.config` 사용.
- **Circular imports:** 해당 없음 (모듈 시스템 없음).
- **절대 경로 의존:** `/favicon/...`, `/terms/`, `/#story`는 커스텀 도메인 루트 전제. `file://` 또는 `slimpumpkin.github.io/<repo>/` 하위 경로에서는 깨짐.
- **Markup–Script 계약:** 스크립트는 id `story`, `rp-panel`, `rp-run-dot|pct|time|dist|btn|icon|label`, `rp-demo-prog|dot|pct|dist|time|done`, `rp-c-dog`, `rp-hero-art`, `rp-sketch`와 속성 `data-step`(0~2, 글 3 + 폰 화면 3), `data-go`(버튼 3)에 의존. null 체크 없음(`rp-hero-art`/`rp-sketch` 제외) → 하나라도 빠지면 스크립트 전체가 예외로 중단.
- **CDN 의존:** 글꼴·Tailwind가 런타임 로드. 오프라인 시 법적 페이지 스타일 붕괴.

## Anti-Patterns

### 공통 부분을 한 파일만 수정
- **What happens:** 「공통」 CSS/헤더/푸터/`<head>` 링크를 `index.html`에서만 바꿈
- **Why it's wrong:** 템플릿이 없어 4페이지 간 드리프트 발생
- **Do this instead:** `index.html`, `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html` 네 파일을 함께 수정. 링크만 다름(랜딩 `#story`, 법적 `/#story`).
### 랜딩에 Tailwind 클래스 추가
- **What happens:** `index.html`에 유틸리티 클래스 사용
- **Why it's wrong:** 랜딩은 Tailwind CDN을 로드하지 않음 → 무효
- **Do this instead:** 「랜딩 전용」 블록(`index.html:60` 이후)에 `.rp-*` 클래스 추가, 좁은 화면 규칙은 `@media (max-width: 860px)` (`index.html:131`)에.
### JS에서 그림 속성 직접 조작
- **What happens:** story 그림 요소의 style을 스크립트가 개별 설정
- **Why it's wrong:** 기존 패턴은 `--q*` 변수만 쓰고 CSS가 반응; 분산되면 무-JS 기본 장면도 깨짐
- **Do this instead:** 새 진행형 효과는 `var(--q0..2)` 기반 `calc()`로 인라인 style에 선언.
## Error Handling

- **Strategy:** 방어적 try/catch로 조용히 폴백 (기능 저하 허용)

### Patterns

- `moveTo()`의 `getPointAtLength` 실패 시 점을 출발점에 둠 (`index.html:526-531`)
- 깨진 해시 `decodeURIComponent` 실패 무시 (`index.html:627`)
- `scrollIntoView({behavior:'instant'})` 미지원 시 `scrollIntoView(true)` 폴백
- `window.matchMedia`, `document.fonts`, `performance.getEntriesByType`, `pauseAnimations` 존재 여부 확인 후 사용

## Cross-Cutting Concerns
- **Logging:** 없음 (console 사용 없음)
- **Validation:** 해당 없음 (폼·입력 없음; 이메일 수집 폼 의도적으로 없음)
- **Authentication:** 해당 없음
- **Accessibility:** `prefers-reduced-motion` 존중(pin 비활성, SMIL 정지, smooth scroll 끔), `aria-pressed` 동기화, `aria-labelledby` 섹션, `:focus-visible` 아웃라인, 장식 SVG `aria-hidden`.
<!-- GSD:architecture-end -->

<!-- GSD:skills-start source:skills/ -->

## Project Skills

No project skills found. Add skills to any of: `.claude/skills/`, `.agents/skills/`, `.cursor/skills/`, `.github/skills/`, or `.codex/skills/` with a `SKILL.md` index file.
<!-- GSD:skills-end -->

<!-- GSD:workflow-start source:GSD defaults -->

## GSD Workflow Enforcement

Before using Edit, Write, or other file-changing tools, start work through a GSD command so planning artifacts and execution context stay in sync.

Use these entry points:
- `/gsd-fast` for a trivial task inline, with no subagents and no PLAN.md
- `/gsd-quick` for small fixes, doc updates, and ad-hoc tasks
- `/gsd-debug` for investigation and bug fixing
- `/gsd-execute-phase` for planned phase work

Do not make direct repo edits outside a GSD workflow unless the user explicitly asks to bypass it.
<!-- GSD:workflow-end -->

<!-- GSD:profile-start -->

## Developer Profile

> Profile not yet configured. Run `/gsd-profile-user` to generate your developer profile.
> This section is managed by `generate-claude-profile` -- do not edit manually.
<!-- GSD:profile-end -->
