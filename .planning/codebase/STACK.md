---
last_mapped_commit: c4cb26d754e9e666c957e31fa7e559f918b425bb
last_mapped_at: 2026-11-14
---
# Technology Stack

**Analysis Date:** 2026-11-14

## Languages

**Primary:**
- HTML5 - 모든 페이지 (`index.html`, `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`), `<html lang="ko">`
- CSS - 각 페이지 `<head>` 내 `<style>` 한 블록(「공통」 + 「랜딩 전용」/「법적 페이지 전용」) 및 인라인 `style`. 「공통」 묶음은 include(`_includes/css/common.css`)로 `<style>` 안에 인라인되고, 「법적 페이지 전용」은 `_includes/css/legal.css`에 있고 `_layouts/legal.html`의 `<style>` 안에 include로 인라인된다

**Secondary:**
- JavaScript (vanilla, 라이브러리 없음) - `index.html`의 `<head>` 짧은 스크립트(`rp-pin` 부여)와 `</body>` 앞 인라인 스크립트(스크롤 단계, 달려 보기 데모, `rp-ready`)
- SVG (인라인) - 로고·아이콘·지도 그림, `index.html` `<body>` 맨 위 숨은 `<svg><defs>` + `<use href="#…">`; `favicon/favicon.svg`
- YAML - `_config.yml` (Jekyll 설정)과 페이지 front matter (랜딩 `layout: none`, 법적 3종 `layout: legal` + 제목·설명 등)
- JSON - `favicon/site.webmanifest`

## Runtime

**Environment:**
- 브라우저만 (서버 측 런타임 없음). GitHub Pages가 배포할 때 Jekyll로 한 번 빌드한 정적 파일을 서빙
- 로컬 빌드·미리보기: `bundle exec jekyll serve --livereload` (http://localhost:4000). 운영과 같은 Jekyll 3.10.0을 `Gemfile`로 고정하고, gem은 저장소 안 `vendor/bundle`에 둔다 (`bundle config set --local path vendor/bundle`, `.bundle/config`에 기록). `file://`로 직접 열면 절대 경로 때문에 깨진다
- 이 미리보기는 응답에 livereload 스크립트를 끼우므로 운영 출력과 같지 않다. 운영 출력과 비교하거나 푸시 전에 점검할 때는 `scripts/check-site.sh`(production·`--safe` 빌드)를 쓴다

**Package Manager:**
- Bundler (로컬 빌드 전용 Ruby gem). `package.json`은 없다
- Lockfile: `Gemfile.lock` (커밋함, `CHECKSUMS` 포함). 운영(GitHub Pages)은 이 lock을 쓰지 않고 자체 github-pages gem 세트로 빌드한다

## Frameworks

**Core:**
- 없음 - 랜딩(`index.html`)과 법적 페이지 3종 모두 프레임워크 없이 직접 쓴 CSS다 (2026-11 기준)
- 직접 쓴 정적 CSS `_includes/css/legal.css` - 법적 페이지 3종. 레이아웃 `<style>`에 include로 인라인한다 (외부 `.css` 파일 없음). 토큰은 `:root`의 `--rp-ink #2B2B2B`·`--rp-accent #7C580D`·`--rp-muted #4A463F`·`--rp-muted-2 #57534C`·`--rp-line #E4E0D6`. Tailwind Play CDN은 Phase 3에서 제거했다

**Testing:**
- Not detected

**Build/Dev:**
- Jekyll (GitHub Pages 내장, 운영 3.10.0, Liquid 4.0.4) - 배포할 때 `_layouts/legal.html`과 `_includes/`로 페이지를 조립한다. 로컬도 `Gemfile`로 같은 버전을 쓴다
- 린터·포매터·테스트 러너는 없다 (no linter, no formatter, no test runner)
- 푸시 전 점검: `scripts/check-site.sh`. `.githooks/pre-push`가 `main`으로 가는 푸시마다 부른다

## Key Dependencies

**Critical (외부 CDN):**
- Pretendard Variable `v1.3.9` (dynamic subset) - 네 페이지 공통 글꼴
  - `https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css`
  - `<link rel="preconnect" href="https://cdn.jsdelivr.net">` 동반

**로컬 빌드 전용 gem (`Gemfile`):**
- `jekyll = 3.10.0` - 운영과 같은 버전 고정. github-pages gem은 로컬 Ruby 4.x에 설치되지 않아 쓰지 않는다
- `kramdown-parser-gfm`
- `webrick` - `jekyll serve`용 서버
- `csv`, `base64`, `bigdecimal`, `logger` - Ruby 4에서 기본 gem이 아니게 된 표준 라이브러리

**Infrastructure:**
- GitHub Pages + 사용자 지정 도메인(`CNAME`: `runningpencil.com`)

## Configuration

**Environment:**
- 환경변수·`.env` 없음 (서버 처리 없음)
- 메타: `theme-color #F2B134`, Open Graph(`og:url https://runningpencil.com/`, `og:image .../favicon/web-app-manifest-512x512.png`) - `index.html`; 법적 페이지는 `<meta name="robots" content="noindex">`

**Build:**
- `_config.yml` - `url: "https://runningpencil.com"`과 열 항목 `exclude`(`CNAME`, `CLAUDE.md`, `README.md`, `.planning/`, `Gemfile`, `Gemfile.lock`, `vendor/`, `prepare/`, `scripts/`, `.githooks/`). 사용자 `exclude`는 Jekyll 기본 제외 목록을 덮어쓰므로, 사이트에 올리지 않을 새 마크다운 문서나 루트 파일·폴더는 여기에 모두 적는다
- `Gemfile` / `Gemfile.lock` - 로컬 빌드용 gem 고정 (위 「로컬 빌드 전용 gem」)
- `scripts/check-site.sh` - 푸시 전 점검 (빌드 성공, `_site`에 내부 파일 없음, 기존 URL 문서 4개의 제목, 처리되지 않은 Liquid 없음, 출력 HTML에 Tailwind Play CDN 없음)
- `.githooks/pre-push` - `main` 푸시마다 `scripts/check-site.sh`를 부른다. 켜기: `git config core.hooksPath .githooks` (클론마다 한 번)
- `CNAME` - `runningpencil.com`
- `.gitignore` - `prepare/`, `.DS_Store`, `.playwright-mcp/`, `.planning/research/.cache/`(GSD 연구 캐시), `.planning/state.json`·`.planning/ui-reviews/`(GSD 상태 요약·UI 감사 캡처), Jekyll 로컬 빌드 산출물과 gem 위치 `_site/`, `.jekyll-cache/`, `vendor/`, `.bundle/`
- `favicon/site.webmanifest` - name/short_name `러닝펜슬`, `display: standalone`, `theme_color`/`background_color` `#F2B134`, maskable 192/512 아이콘

## Platform Requirements

**Development:**
- Homebrew Ruby 4.x + Bundler (`bundle install`), 텍스트 에디터, 인터넷(CDN 글꼴). macOS 시스템 Ruby 2.6은 쓰지 않는다
- 아이콘 재생성 시 `rsvg-convert` 등 (8배 렌더 후 8×8 평균 축소)

**Production:**
- GitHub Pages (조직 `SlimPumpkin` 프로젝트 사이트), `main` 푸시 = 배포. 절대 경로(`/favicon/...`, `/terms/`)는 커스텀 도메인 연결을 전제

---

*Stack analysis: 2026-11-14*
