---
last_mapped_commit: c4cb26d754e9e666c957e31fa7e559f918b425bb
last_mapped_at: 2026-11-14
---
# Technology Stack

**Analysis Date:** 2026-11-14

## Languages

**Primary:**
- HTML5 - 모든 페이지 (`index.html`, `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`), `<html lang="ko">`
- CSS - 각 HTML의 `<head>` 내 `<style>` 한 블록(「공통」 + 「랜딩 전용」/「법적 페이지 전용」) 및 인라인 `style`

**Secondary:**
- JavaScript (vanilla, 라이브러리 없음) - `index.html`의 `<head>` 짧은 스크립트(`rp-pin` 부여)와 `</body>` 앞 인라인 스크립트(스크롤 단계, 달려 보기 데모, `rp-ready`)
- SVG (인라인) - 로고·아이콘·지도 그림, `index.html` `<body>` 맨 위 숨은 `<svg><defs>` + `<use href="#…">`; `favicon/favicon.svg`
- YAML - `_config.yml` (Jekyll 설정)
- JSON - `favicon/site.webmanifest`

## Runtime

**Environment:**
- 브라우저만 (서버 측 런타임 없음). GitHub Pages가 정적 파일을 그대로 서빙
- 로컬 미리보기: `python3 -m http.server 8000` (저장소 루트를 서버 루트로; `file://`는 절대 경로 때문에 깨짐)

**Package Manager:**
- 없음 (`package.json`, lockfile 없음)
- Lockfile: missing (해당 없음)

## Frameworks

**Core:**
- 없음 - 랜딩(`index.html`)은 프레임워크·Tailwind 미사용, 순수 CSS
- Tailwind CSS (CDN 런타임/Play CDN, 버전 고정 없음) - 법적 페이지 3종 본문 스타일. `<script src="https://cdn.tailwindcss.com">` + 인라인 `<script id="tailwind-config">`의 `tailwind.config` 토큰(`ink`, `accent`, `muted`, `muted-2`, `line`)

**Testing:**
- Not detected

**Build/Dev:**
- 빌드 도구 없음 (no bundler, no linter, no formatter)
- Jekyll (GitHub Pages 내장) - 배포 시 한 번 거침, `_config.yml`의 `exclude`만 사용

## Key Dependencies

**Critical (외부 CDN):**
- Pretendard Variable `v1.3.9` (dynamic subset) - 네 페이지 공통 글꼴
  - `https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css`
  - `<link rel="preconnect" href="https://cdn.jsdelivr.net">` 동반
- Tailwind CSS Play CDN - `https://cdn.tailwindcss.com` (버전 미고정, 법적 페이지 3종만). 프로덕션 비권장 방식, `@apply` 불가

**Infrastructure:**
- GitHub Pages + 사용자 지정 도메인(`CNAME`: `runningpencil.com`)

## Configuration

**Environment:**
- 환경변수·`.env` 없음 (서버 처리 없음)
- 메타: `theme-color #F2B134`, Open Graph(`og:url https://runningpencil.com/`, `og:image .../favicon/web-app-manifest-512x512.png`) - `index.html`; 법적 페이지는 `<meta name="robots" content="noindex">`

**Build:**
- `_config.yml` - `exclude: [CNAME, CLAUDE.md, README.md, .planning/]`. 새 마크다운 문서 추가 시 여기에도 등록
- `CNAME` - `runningpencil.com`
- `.gitignore` - `prepare/`, `.DS_Store`, `.playwright-mcp/`, `.planning/research/.cache/`(GSD 연구 캐시)
- `favicon/site.webmanifest` - name/short_name `러닝펜슬`, `display: standalone`, `theme_color`/`background_color` `#F2B134`, maskable 192/512 아이콘

## Platform Requirements

**Development:**
- 텍스트 에디터 + 정적 서버(`python3 -m http.server`) + 인터넷(CDN 글꼴·Tailwind)
- 아이콘 재생성 시 `rsvg-convert` 등 (8배 렌더 후 8×8 평균 축소)

**Production:**
- GitHub Pages (조직 `SlimPumpkin` 프로젝트 사이트), `main` 푸시 = 배포. 절대 경로(`/favicon/...`, `/terms/`)는 커스텀 도메인 연결을 전제

---

*Stack analysis: 2026-11-14*
