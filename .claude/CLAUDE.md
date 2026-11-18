## 이번 마일스톤 방침 (2026-11 결정)

이번 마일스톤(티저 유지 + 심사 대응)에서 정한 방침입니다. 표의 방침은 「적용 단계」가 오기 전에는 사이트 코드에 반영하지 않습니다. 이 구간 아래의 설명은 지금 코드의 실제 모습입니다. 이 구간은 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`에 같은 내용으로 둡니다.

| 방침 | 적용 단계 | 현재 상태 (2026-11 기준) | 이유 | 출처 |
|---|---|---|---|---|
| 영문 서비스명 RunningPencil | Phase 9 영문판(`/en/`), 콘솔·스토어의 영어 표시명 | 결정됨. 현재 사이트 본문에는 한국어 이름만 있습니다 | 영문판과 콘솔·스토어에서 같은 이름을 써야 합니다. 이전 방침을 뒤집음 | `.planning/baseline/NAMES.md`, `.planning/PROJECT.md` Key Decisions |
| 지원 이메일 공개 | Phase 5 이메일 게이트(외부 4곳 수신 시험 통과) 뒤. 푸터, `/support/`, 법적 문서 | 결정됨. 주소의 정본은 이름 표(`.planning/baseline/NAMES.md`)입니다. 사이트(HTML·`_data`)에는 아직 없고 `.planning/` 문서에만 있습니다. 저장소가 공개라 `.planning/` 문서의 주소는 GitHub에서 누구나 볼 수 있습니다 | Google Play 웹 삭제 요청, App Store Support URL, 처리방침의 보호책임자 연락처에 연락 수단이 필요합니다. 이전 방침을 뒤집음 | `.planning/PROJECT.md` Key Decisions, `.planning/baseline/USER-TASKS.md` |
| 사업자 정보 표시 (상호·대표자·사업자등록번호·주소) | Phase 5 (푸터와 `_data` 슬롯), Phase 8·9 | 결정됨. 값은 사용자가 주기 전이라 어디에도 없습니다. 값이 없는 항목은 행을 숨깁니다 (render-if-present) | 카카오 비즈앱 심사가 사업자와 서비스의 관계를 확인합니다 | `.planning/PROJECT.md` Key Decisions, `.planning/baseline/NAMES.md` |
| 한국어 + 영어 제공 | Phase 9 (`/en/` 아래 영문판) | 결정됨. 현재 페이지는 모두 한국어(`lang="ko"`)입니다 | Google·Facebook·Apple·LINE 심사자가 읽을 수 있어야 합니다. 이전 방침을 뒤집음 | `.planning/PROJECT.md` Key Decisions, `.planning/baseline/URLS.md` |
| Jekyll 빌드 전환 | Phase 2 (공유 셸 `_layouts`·`_includes`), Phase 3 (Tailwind CDN을 정적 CSS로) | Phase 3까지 적용됨. 공통 블록(head 링크·「공통」 CSS·헤더·푸터)은 `_includes`와 `_layouts/legal.html`에 한 벌만 있고, 법적 페이지는 외부 스크립트 없이 정적 CSS(`_includes/css/legal.css`)로 그립니다. 로컬은 운영과 같은 Jekyll 3.10.0(`Gemfile`)으로 빌드합니다 | 페이지가 늘수록 복사한 공통 블록이 어긋날 위험이 커집니다. 이전 방침을 뒤집음 | `.planning/PROJECT.md` Key Decisions, `.planning/ROADMAP.md` Phase 2·3 |
| 포인트·굿즈·코스북 제거 | Phase 4 (랜딩), Phase 6·7·8 (법적 문서) | 결정됨 (U10). 랜딩은 Phase 4에서 제거됨, 법적 문서 본문에는 남아 있음 | 출시 시점 앱에 없는 기능입니다. 심사는 사이트와 앱이 일치하는지 봅니다 | `.planning/PROJECT.md` Key Decisions |
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
- CSS - 각 페이지 `<head>` 내 `<style>` 한 블록(「공통」 + 「랜딩 전용」/「법적 페이지 전용」) 및 인라인 `style`. 「공통」 묶음은 include(`_includes/css/common.css`)로 `<style>` 안에 인라인되고, 「법적 페이지 전용」은 `_includes/css/legal.css`에 있고 `_layouts/legal.html`의 `<style>` 안에 include로 인라인된다
- JavaScript (vanilla, 라이브러리 없음) - `index.html`의 `<head>` 짧은 스크립트(`rp-pin` 부여)와 `</body>` 앞 인라인 스크립트(스크롤 단계, 달려 보기 데모, `rp-ready`)
- SVG (인라인) - 로고·아이콘·지도 그림, `index.html` `<body>` 맨 위 숨은 `<svg><defs>` + `<use href="#…">`; `favicon/favicon.svg`
- WebP (래스터) - 랜딩 「실제 앱 화면」 캡처 `images/app/screen-{draw,run,badge}-{564,846}.webp` (sRGB, 메타데이터 없음, 564w·846w)
- YAML - `_config.yml` (Jekyll 설정)과 페이지 front matter (랜딩 `layout: none`, 법적 3종 `layout: legal` + 제목·설명 등)
- JSON - `favicon/site.webmanifest`

## Runtime
- 브라우저만 (서버 측 런타임 없음). GitHub Pages가 배포할 때 Jekyll로 한 번 빌드한 정적 파일을 서빙
- 로컬 빌드·미리보기: `bundle exec jekyll serve --livereload` (http://localhost:4000). 운영과 같은 Jekyll 3.10.0을 `Gemfile`로 고정하고, gem은 저장소 안 `vendor/bundle`에 둔다 (`bundle config set --local path vendor/bundle`, `.bundle/config`에 기록). `file://`로 직접 열면 절대 경로 때문에 깨진다
- 이 미리보기는 응답에 livereload 스크립트를 끼우므로 운영 출력과 같지 않다. 운영 출력과 비교하거나 푸시 전에 점검할 때는 `scripts/check-site.sh`(production·`--safe` 빌드)를 쓴다
- Bundler (로컬 빌드 전용 Ruby gem). `package.json`은 없다
- Lockfile: `Gemfile.lock` (커밋함, `CHECKSUMS` 포함). 운영(GitHub Pages)은 이 lock을 쓰지 않고 자체 github-pages gem 세트로 빌드한다
## Frameworks
- 없음 - 랜딩(`index.html`)과 법적 페이지 3종 모두 프레임워크 없이 직접 쓴 CSS다 (2026-11 기준)
- 직접 쓴 정적 CSS `_includes/css/legal.css` - 법적 페이지 3종. 레이아웃 `<style>`에 include로 인라인한다 (외부 `.css` 파일 없음). 토큰은 `:root`의 `--rp-ink #2B2B2B`·`--rp-accent #7C580D`·`--rp-muted #4A463F`·`--rp-muted-2 #57534C`·`--rp-line #E4E0D6`. Tailwind Play CDN은 Phase 3에서 제거했다
- Not detected
- Jekyll (GitHub Pages 내장, 운영 3.10.0, Liquid 4.0.4) - 배포할 때 `_layouts/legal.html`과 `_includes/`로 페이지를 조립한다. 로컬도 `Gemfile`로 같은 버전을 쓴다
- 린터·포매터·테스트 러너는 없다 (no linter, no formatter, no test runner)
- 푸시 전 점검: `scripts/check-site.sh`. `.githooks/pre-push`가 `main`으로 가는 푸시마다 부른다
## Key Dependencies

- Pretendard Variable `v1.3.9` (dynamic subset) - 네 페이지 공통 글꼴
- `jekyll = 3.10.0` - 운영과 같은 버전 고정. github-pages gem은 로컬 Ruby 4.x에 설치되지 않아 쓰지 않는다
- `kramdown-parser-gfm`
- `webrick` - `jekyll serve`용 서버
- `csv`, `base64`, `bigdecimal`, `logger` - Ruby 4에서 기본 gem이 아니게 된 표준 라이브러리
- GitHub Pages + 사용자 지정 도메인(`CNAME`: `runningpencil.com`)

## Configuration

- 환경변수·`.env` 없음 (서버 처리 없음)
- 메타: `theme-color #F2B134`, Open Graph(`og:url https://runningpencil.com/`, `og:image .../favicon/web-app-manifest-512x512.png`) - `index.html`; 법적 페이지는 `<meta name="robots" content="noindex">`
- `_config.yml` - `url: "https://runningpencil.com"`과 열 항목 `exclude`(`CNAME`, `CLAUDE.md`, `README.md`, `.planning/`, `Gemfile`, `Gemfile.lock`, `vendor/`, `prepare/`, `scripts/`, `.githooks/`). 사용자 `exclude`는 Jekyll 기본 제외 목록을 덮어쓰므로, 사이트에 올리지 않을 새 마크다운 문서나 루트 파일·폴더는 여기에 모두 적는다
- `Gemfile` / `Gemfile.lock` - 로컬 빌드용 gem 고정 (위 「로컬 빌드 전용 gem」)
- `scripts/check-site.sh` - 푸시 전 점검 (빌드 성공, `_site`에 내부 파일 없음, 기존 URL 문서 4개의 제목, 처리되지 않은 Liquid 없음, 출력 HTML에 Tailwind Play CDN 없음, 랜딩 출력에 포인트·굿즈·코스북 없음)
- `.githooks/pre-push` - `main` 푸시마다 `scripts/check-site.sh`를 부른다. 켜기: `git config core.hooksPath .githooks` (클론마다 한 번)
- `CNAME` - `runningpencil.com`
- `.gitignore` - `prepare/`, `.DS_Store`, `.playwright-mcp/`, `.planning/research/.cache/`(GSD 연구 캐시), `.planning/state.json`·`.planning/ui-reviews/`(GSD 상태 요약·UI 감사 캡처), Jekyll 로컬 빌드 산출물과 gem 위치 `_site/`, `.jekyll-cache/`, `vendor/`, `.bundle/`
- `favicon/site.webmanifest` - name/short_name `러닝펜슬`, `display: standalone`, `theme_color`/`background_color` `#F2B134`, maskable 192/512 아이콘

## Platform Requirements
- Homebrew Ruby 4.x + Bundler (`bundle install`), 텍스트 에디터, 인터넷(CDN 글꼴). macOS 시스템 Ruby 2.6은 쓰지 않는다
- 아이콘 재생성 시 `rsvg-convert` 등 (8배 렌더 후 8×8 평균 축소)
- 앱 화면 캡처 재생성 시 macOS `sips`(sRGB 변환·축소)와 Homebrew `cwebp`·`webpinfo`(libwebp)
- GitHub Pages (조직 `SlimPumpkin` 프로젝트 사이트), `main` 푸시 = 배포. 절대 경로(`/favicon/...`, `/terms/`)는 커스텀 도메인 연결을 전제

<!-- GSD:stack-end -->

<!-- GSD:conventions-start source:CONVENTIONS.md -->

## Conventions

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
- id·class·data 속성 이름을 바꾸면 `index.html` 끝(`</body>` 앞 `<script>`)의 인라인 스크립트도 반드시 같이 고친다.
### JS functions / variables

- 함수와 변수는 camelCase로 쓰고 함수 이름은 동사로 시작한다: `setStep`, `goStep`, `paintStory`, `paintDemo`, `setRun`, `startRun`, `syncLive`, `moveTo`, `setText`, `settle`. 작은 순수 유틸은 명사형도 쓴다: `clamp01`, `twoDigits`, `clock`, `reduced`.
- 상수는 UPPER_CASE로 쓴다: `var KM = 7.84;`.
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
- `{% include head-links.html %}` (Pretendard 글꼴 `<link>`와 파비콘·매니페스트 링크 8줄. jsDelivr `orioncactus/pretendard@v1.3.9`, `/favicon/...`)
- 첫 그리기 전 실행 스크립트 (`index.html`만: `rp-pin` 판정)
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
<!-- GSD:conventions-end -->

<!-- GSD:architecture-start source:ARCHITECTURE.md -->

## Architecture

## System Overview
- 호스팅: GitHub Pages 내장 Jekyll(3.10.0)이 배포할 때 `_layouts`·`_includes`로 페이지를 조립해 정적 파일로 서빙한다. `_config.yml`은 `url`과 `exclude`를 둔다. 커스텀 도메인은 `CNAME` → runningpencil.com.
- 페이지 4개: 티저 랜딩 `index.html` (vanilla CSS + inline JS), 개인정보처리방침 `privacy-policy/index.html`, 이용약관 `terms/index.html`, 데이터 삭제 안내 `data-deletion/index.html`. 법적 페이지 3종은 정적 CSS(`_includes/css/legal.css`) + 「공통」 `.rp-*` CSS.
- include로 공유: 네 페이지가 `_includes/head-links.html`(글꼴·파비콘 링크), `_includes/css/common.css`(「공통」 CSS), `_includes/header.html`(랜딩은 `home=true`), `_includes/footer.html`을 부른다. 법적 3종은 `_layouts/legal.html` + front matter로 그려지고, 랜딩은 `layout: none`에 include 네 줄을 쓴다.
- 푸시 전 점검: `scripts/check-site.sh`(빌드·내부 파일·제목·Liquid 잔여·Tailwind 없음·랜딩 기능 이름)를 `.githooks/pre-push`가 `main` 푸시마다 부른다.
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
| 푸터 | 약관 링크 3개, 운영 안내, 저작권, 경로 데이터 출처 | `_includes/footer.html` (`index.html`의 `{% include footer.html %}`, `_layouts/legal.html:40`) |
| 법적 레이아웃 | 법적 3종의 `<head>`·카드 머리(eyebrow·제목)·본문 틀(`.rp-doc`). `<style>`에 「공통」과 법적 페이지 CSS를 include. `noindex`·`updated`는 값이 있을 때만 출력, 제목은 `heading`이 없으면 `title` | `_layouts/legal.html` (`:18`에서 `_includes/css/legal.css` include) |
| 「랜딩 전용」 CSS | 스크롤리(scrollytelling), 폰 목업, 뱃지, 앱 화면 띠, 반응형 | `index.html` `<style>`의 `/* ── 랜딩 전용 ── */`부터 `</style>`까지 |
| 실제 앱 화면 구간 | 제목·「출시 준비 중」 딱지·캡처 세 장(흑연 폰 테두리 `.rp-shot-frame`)·캡션·지도 출처(「지도 © NAVER Corp.」), 좁은 화면 가로 밀기(`scroll-snap`, 스크립트 없음) | `index.html` `#screens`, `images/app/*.webp` |
| SVG 심볼 라이브러리 | 코스 path(`rp-c-*`), 지도(`rp-map-seoul`), 로고(`rp-logo`), 아이콘(`rp-i-*`), 히어로 캐릭터(`rp-t-*`) | `index.html` `<!-- Shapes: courses, map, logo, icons, hero characters -->` 아래 숨은 `<svg><defs>` |
| 랜딩 동작 스크립트 | story 단계/진행도, demo 런 애니메이션, 해시 정착, `rp-ready` | `index.html` `</body>` 앞 `<script>` (`'use strict'` IIFE) |
| 법적 페이지 토큰 | `--rp-ink`/`--rp-accent`/`--rp-muted`/`--rp-muted-2`/`--rp-line` | `_includes/css/legal.css:5` (`:root`, 3개 법적 페이지 공통) |
| 법적 페이지 CSS | Preflight 대체(`html`)·레이아웃(`body`·`main`)·`.rp-legal-*` 카드 껍데기·`.rp-doc` 본문 규칙(클래스 없는 요소)·표 감싸개 스크롤 그림자, 768px(`min-width`) 카드 안쪽 여백 | `_includes/css/legal.css` (「법적 페이지 전용」) |
| 모눈종이 바탕 | `.rp-grid` 32px 그리드 | `_includes/css/legal.css:9` |
| Jekyll 설정 | 사이트 정식 주소 `url`, 저장소 문서·빌드 파일이 사이트에 공개되지 않게 하는 열 항목 `exclude` | `_config.yml` |
| 푸시 전 점검 | 빌드 성공, `_site`에 내부 파일 없음, 기존 URL 문서 4개의 제목, 처리되지 않은 Liquid 없음, 출력 HTML에 Tailwind Play CDN 없음, 랜딩 출력에 포인트·굿즈·코스북 없음 | `scripts/check-site.sh` + `.githooks/pre-push` |
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
