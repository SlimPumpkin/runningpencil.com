---
last_mapped_commit: c4cb26d754e9e666c957e31fa7e559f918b425bb
last_mapped_at: 2026-11-14
---
# Codebase Structure

**Analysis Date:** 2026-11-14

## Directory Layout

```
runningpencil.com/
├── index.html                 # 티저 랜딩 (653줄: CSS + SVG defs + 마크업 + 인라인 JS)
├── privacy-policy/
│   └── index.html             # 개인정보처리방침 (noindex, Tailwind CDN)
├── terms/
│   └── index.html             # 서비스 이용약관 (noindex, Tailwind CDN)
├── data-deletion/
│   └── index.html             # 계정·데이터 삭제 안내 (noindex, Tailwind CDN)
├── favicon/                   # 파비콘·앱 아이콘·웹 매니페스트
├── _config.yml                # Jekyll exclude (CNAME, CLAUDE.md, README.md, .planning/)
├── CNAME                      # 커스텀 도메인 runningpencil.com
├── CLAUDE.md                  # 저장소 가이드 (사이트 비공개)
├── README.md                  # 저장소 소개 (사이트 비공개)
├── .gitignore                 # prepare/ 등 제외
└── prepare/                   # 로컬 전용, gitignored (이전 디자인 목업 등) — 분석 제외
```

## Directory Purposes

**루트:**
- Purpose: 랜딩 페이지와 배포 설정
- Key files: `index.html`, `CNAME`, `_config.yml`

**`privacy-policy/`, `terms/`, `data-deletion/`:**
- Purpose: 법적 페이지. 디렉터리 + `index.html`로 trailing-slash URL(`/terms/`) 제공
- Contains: 같은 레이아웃(`main.rp-grid` 모눈종이 + 흰 카드), 본문 `<section class="space-y-3">` 반복
- Key files: `terms/index.html` (Tailwind config `:21-34`, 「법적 페이지 전용」 `.rp-grid` `:69`)

**`favicon/`:**
- Purpose: 브라우저/홈 화면 아이콘
- Key files: `favicon.svg`, `favicon.ico`, `favicon-96x96.png`, `apple-touch-icon.png`, `web-app-manifest-192x192.png`, `web-app-manifest-512x512.png`, `site.webmanifest`
- 미추적 파일 존재: `app-icon-{128,140,512,1024}` PNG (git untracked)

## Key File Locations

**Entry Points:**
- `index.html`: `/`
- `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`: 법적 페이지

**Configuration:**
- `_config.yml`: Jekyll 제외 목록 — 새 마크다운 문서 추가 시 등록 필수
- `CNAME`: 도메인 매핑
- `favicon/site.webmanifest`: 매니페스트 (`theme_color`/`background_color` `#F2B134`)
- 법적 페이지 `<script id="tailwind-config">`: 색 토큰

**Core Logic (`index.html` 내부 구획):**
- `:26-29`: pre-paint `rp-pin` 스크립트
- `:31-58`: 「공통」 CSS (4페이지 복사본)
- `:60-146`: 「랜딩 전용」 CSS, `:131` 좁은 화면 `@media`
- `:152-182`: 숨은 `<svg><defs>` 심볼
- `:185-197`: 헤더 / `:201` 히어로 / `:249` `#story` / `:406` `#demo` / `:444` `#get` / `:471` 푸터
- `:495-650`: 동작 스크립트 (IIFE)

**Testing:**
- 없음. `python3 -m http.server 8000`으로 루트를 서빙해 수동 확인.

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
- 섹션 앵커 id는 접두사 없음: `top`, `story`, `demo`, `get` (URL 해시로 노출)

**Directories:**
- URL 경로 = 디렉터리명, kebab-case

## Where to Add New Code

**새 법적/정적 페이지:**
- `<slug>/index.html` 생성, 기존 법적 페이지(예: `terms/index.html`)를 통째로 복사해 본문 `<section>`만 교체
- 헤더·푸터 링크는 절대 경로(`/`, `/#story`)
- 푸터에 링크를 추가하면 4개 파일 모두 갱신

**랜딩 새 구간:**
- 마크업: `index.html` `<main>` 안, `#get`(`:444`) 앞 등 적절한 위치에 `<section id="…" aria-labelledby="rp-h-…">`
- 스타일: 「랜딩 전용」 블록, 반응형은 `clamp(...vw...)` + `:131`의 `@media (max-width: 860px)`
- 헤더 내비 추가 시 4페이지 헤더 모두 수정

**새 반복 도형/아이콘:**
- `index.html:152-182` `<defs>`에 `<symbol id="rp-i-…">` 또는 `<path id="rp-c-…" pathLength="1000">` 추가 후 `<use href="#…">`
- 법적 페이지에는 `<defs>`가 없으므로 인라인 SVG로 직접 삽입

**동작 추가:**
- `index.html:495` 이후 IIFE 안에 추가, `byId()`로 요소 획득, 상태는 클래스/CSS 변수로 반영. id 이름 변경 시 스크립트 동시 수정.

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
