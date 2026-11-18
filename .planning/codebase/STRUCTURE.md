---
last_mapped_commit: c4cb26d754e9e666c957e31fa7e559f918b425bb
last_mapped_at: 2026-11-14
---
# Codebase Structure

**Analysis Date:** 2026-11-14

## Directory Layout

```
runningpencil.com/
├── index.html                 # 티저 랜딩 (622줄: front matter `layout: none` + include 네 줄 + 랜딩 전용 CSS + SVG defs + 마크업 + 인라인 JS)
├── privacy-policy/
│   └── index.html             # 개인정보처리방침 (front matter + 카드 본문, noindex)
├── terms/
│   └── index.html             # 서비스 이용약관 (front matter + 카드 본문, noindex)
├── data-deletion/
│   └── index.html             # 계정·데이터 삭제 안내 (front matter + 카드 본문, noindex)
├── _includes/                 # 공통 블록 한 벌 (Jekyll include)
│   ├── head-links.html        # Pretendard 글꼴·파비콘·매니페스트 링크
│   ├── header.html            # 헤더 마크업 (home=true면 랜딩 링크)
│   ├── footer.html            # 푸터 마크업
│   └── css/
│       ├── common.css         # 「공통」 CSS 묶음
│       └── legal.css          # 「법적 페이지 전용」 CSS (토큰·Preflight 대체·.rp-legal-*·.rp-doc)
├── _layouts/
│   └── legal.html             # 법적 3종 레이아웃 (head·「공통」+legal.css include·카드 틀)
├── favicon/                   # 파비콘·앱 아이콘·웹 매니페스트
├── images/
│   └── app/                   # 「실제 앱 화면」 캡처 WebP (564w·846w)
├── scripts/
│   └── check-site.sh          # 푸시 전 점검 (빌드·내부 파일·제목·Liquid 잔여·Tailwind 없음·랜딩 기능 이름)
├── .githooks/
│   └── pre-push               # main 푸시마다 check-site.sh 실행 (git config core.hooksPath .githooks)
├── Gemfile                    # 로컬 빌드용 gem (jekyll = 3.10.0 고정)
├── Gemfile.lock               # gem 잠금 (커밋함)
├── _config.yml                # Jekyll 설정 (url, exclude)
├── CNAME                      # 커스텀 도메인 runningpencil.com
├── CLAUDE.md                  # 저장소 가이드 (사이트 비공개)
├── README.md                  # 저장소 소개 (사이트 비공개)
├── .gitignore                 # prepare/, Jekyll 산출물, gem 위치 등 제외
├── vendor/                    # 로컬 전용, gitignored (bundle 설치 위치 vendor/bundle)
├── .bundle/                   # 로컬 전용, gitignored (bundle config --local 기록)
├── _site/                     # 로컬 전용, gitignored (jekyll build/serve 출력)
├── .jekyll-cache/             # 로컬 전용, gitignored (Jekyll 캐시)
└── prepare/                   # 로컬 전용, gitignored (이전 디자인 목업 등) — 분석 제외
```

## Directory Purposes

**루트:**
- Purpose: 랜딩 페이지와 배포 설정
- Key files: `index.html`, `CNAME`, `_config.yml`

**`privacy-policy/`, `terms/`, `data-deletion/`:**
- Purpose: 법적 페이지. 디렉터리 + `index.html`로 trailing-slash URL(`/terms/`) 제공
- Contains: front matter(`layout: legal`, `title`, `description`, `eyebrow`, `updated`, `noindex`)와 클래스 없는 본문 `<section>` 반복(작성 규칙은 `CONVENTIONS.md` 「법적 본문 작성 규칙」). 틀(`main.rp-grid` 모눈종이 + 흰 카드 + 본문 범위 `div.rp-doc`)은 `_layouts/legal.html`이 그린다
- Key files: `_layouts/legal.html` (`_includes/css/legal.css` include `:18`, 본문 자리 `:34`), `_includes/css/legal.css` (토큰 `:5`, `.rp-grid` `:9`, 768px 카드 여백 `:39`)

**`_includes/`, `_layouts/`:**
- Purpose: 공통 블록과 법적 레이아웃의 원본. 밑줄로 시작하므로 사이트에 출력되지 않는다
- Key files: `_includes/head-links.html`, `_includes/header.html`, `_includes/footer.html`, `_includes/css/common.css`, `_includes/css/legal.css`, `_layouts/legal.html`

**`favicon/`:**
- Purpose: 브라우저/홈 화면 아이콘
- Key files: `favicon.svg`, `favicon.ico`, `favicon-96x96.png`, `apple-touch-icon.png`, `web-app-manifest-192x192.png`, `web-app-manifest-512x512.png`, `site.webmanifest`

**`images/app/`:**
- Purpose: 랜딩 「실제 앱 화면」 구간(`#screens`)의 앱 화면 캡처 (iPhone 한 기기, 세 장)
- Key files: `screen-draw-*.webp`, `screen-run-*.webp`, `screen-badge-*.webp` (각각 564w·846w 두 파일, sRGB, 메타데이터 없음)
- 캡처 원본(PNG)은 저장소에 넣지 않는다. 사이트에 출력되어야 하므로 `_config.yml`의 `exclude`에 넣지 않는다

## Key File Locations

**Entry Points:**
- `index.html`: `/`
- `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`: 법적 페이지

**Configuration:**
- `_config.yml`: Jekyll `url`과 `exclude`. 사용자 `exclude`가 기본 제외 목록을 덮어쓰므로 새 마크다운 문서나 루트 파일·폴더를 추가하면 등록 필수
- `Gemfile`, `Gemfile.lock`: 로컬 Jekyll 3.10.0 고정
- `CNAME`: 도메인 매핑
- `favicon/site.webmanifest`: 매니페스트 (`theme_color`/`background_color` `#F2B134`)
- `_includes/css/legal.css` `:root`(`:5`): 법적 페이지 색 토큰 `--rp-ink`·`--rp-accent`·`--rp-muted`·`--rp-muted-2`·`--rp-line`

**Core Logic (`index.html` 내부 구획):**
- `:21`: `{% include head-links.html %}`
- `:22-25`: pre-paint `rp-pin` 스크립트
- `:27`: 「공통」 CSS include 한 줄 (내용은 `_includes/css/common.css`)
- `:29-126`: 「랜딩 전용」 CSS, `:109` 좁은 화면 `@media`
- `:132-162`: 숨은 `<svg><defs>` 심볼
- `:164` 헤더 include(`home=true`) / `:168` 히어로 / `:216` `#story` / `:373` `#demo` / `:411` `#screens` / `:436` `#get` / `:462` 푸터 include
- `:464-619`: 동작 스크립트 (IIFE)

**Testing:**
- 자동 점검은 `scripts/check-site.sh` 하나 (pre-push 훅이 `main` 푸시마다 실행). 화면 확인은 `bundle exec jekyll serve --livereload`(http://localhost:4000)로 띄워 수동으로 한다.

## Naming Conventions

**Files:**
- 페이지는 `kebab-case/index.html` (예: `privacy-policy/index.html`)
- 파비콘은 `kebab-case` + 크기 접미사 (예: `web-app-manifest-192x192.png`)

**CSS 클래스 / id:**
- 모든 프로젝트 클래스·id는 `rp-` 접두사: 레이아웃 `.rp-wrap`, 헤더 `.rp-head`/`.rp-brand`/`.rp-nav`, 푸터 `.rp-foot-*`
- 상태 클래스는 접두사 없이 `is-*`: `is-on`, `is-s0`~`is-s2`; `<html>` 상태는 `rp-pin`, `rp-ready`
- SVG 심볼 id: 코스 `rp-c-<shape>`(`rp-c-dog`, `rp-c-heart`…), 아이콘 `rp-i-<name>`, 지도 `rp-map-<region>`, 캐릭터/소품 `rp-t-<name>`, 로고 `rp-logo`
- 스크립트용 id: `rp-run-*`(story 폰 화면의 달리기 단계), `rp-demo-*`(달려 보기 구간)
- 헤딩 id: `rp-h-<section>` (`aria-labelledby`용)
- 섹션 앵커 id는 접두사 없음: `top`, `story`, `demo`, `screens`, `get` (URL 해시로 노출)

**Directories:**
- URL 경로 = 디렉터리명, kebab-case

## Where to Add New Code

**새 법적/정적 페이지:**
- `<slug>/index.html`에 front matter(`layout: legal`, `title`, `description`, `eyebrow`, 필요하면 `heading`·`updated`·`noindex`)와 본문 `<section>`만 쓴다. head·헤더·푸터·카드 틀은 `_layouts/legal.html`이 그린다. 본문은 `CONVENTIONS.md` 「법적 본문 작성 규칙」의 클래스 없는 허용 요소로만 쓴다
- 마크다운 문서나 새 루트 파일을 더하면 `_config.yml`의 `exclude`를 확인한다
- `scripts/check-site.sh`의 기대 제목 목록은 기존 URL 넷(`/`, `/privacy-policy/`, `/terms/`, `/data-deletion/`)만 다룬다. 새 페이지는 그 목록에 자동으로 들어가지 않는다
- 푸터에 링크를 추가하면 `_includes/footer.html` 한 곳만 고친다

**랜딩 새 구간:**
- 마크업: `index.html` `<main>` 안, `#get`(`:436`) 앞 등 적절한 위치에 `<section id="…" aria-labelledby="rp-h-…">`
- 스타일: 「랜딩 전용」 블록, 반응형은 `clamp(...vw...)` + `:109`의 `@media (max-width: 860px)`
- 헤더 내비 추가 시 `_includes/header.html` 한 곳만 수정 (랜딩 링크와 법적 페이지 링크 두 갈래)

**새 반복 도형/아이콘:**
- `index.html:132-162` `<defs>`에 `<symbol id="rp-i-…">` 또는 `<path id="rp-c-…" pathLength="1000">` 추가 후 `<use href="#…">`
- 법적 페이지에는 `<defs>`가 없으므로 인라인 SVG로 직접 삽입

**동작 추가:**
- `index.html:464` 이후 IIFE 안에 추가, `byId()`로 요소 획득, 상태는 클래스/CSS 변수로 반영. id 이름 변경 시 스크립트 동시 수정.

**Utilities:**
- 공유 헬퍼는 IIFE 내부 함수(`clamp01`, `clock`, `setText`, `moveTo`, `reduced`) 재사용. 별도 JS 파일 없음.

## Special Directories

**`prepare/`:**
- Purpose: 이전 디자인 목업, 옛 아이콘 원본
- Generated: No
- Committed: No (`.gitignore`)

**`.planning/`:**
- Purpose: GSD 계획 문서
- Generated: Yes (도구 산출)
- Committed: Yes (오케스트레이터가 관리). `_config.yml`의 `exclude`에 `.planning/`을 등록해 사이트에 공개되지 않게 함 (프로젝트 규칙: 마크다운 문서를 추가하면 `exclude`에 적는다). 저장소 루트에 `.nojekyll`을 추가해 Jekyll을 끄면 `exclude`가 무시되므로 그때는 별도 조치 필요

---

*Structure analysis: 2026-11-14*
