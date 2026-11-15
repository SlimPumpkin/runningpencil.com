# Stack Research

**Domain:** 빌드 없는 GitHub Pages 정적 사이트를 소셜 로그인 제공자와 앱 스토어 심사용 공식 웹사이트로 정비 (한국어 기본 + 영문판)
**Researched:** 2026-11-14
**Confidence:** MEDIUM (로컬 실험으로 확인한 항목은 HIGH, 공식 문서를 직접 읽은 항목은 MEDIUM, 검색 요약만 있는 항목은 LOW로 표시)

> 이 문서는 기존 스택(`.planning/codebase/STACK.md`)을 다시 조사하지 않습니다. 이번 마일스톤에서 **더하거나 바꿀 것**만 다룹니다.
>
> **신뢰도 표기 규칙:** GSD `classify-confidence` seam은 `webfetch` 출처를 `--verified`여도 LOW로, `websearch`는 `--verified`일 때 MEDIUM으로 돌려줍니다. 이 문서는 여기에 두 가지 판단을 더했습니다. (1) 제공자 **자신의 공식 문서**(Google·GitHub·Cloudflare·ImprovMX·Tailwind 등)를 WebFetch로 직접 읽어 인용한 항목은 **필자 판단으로 MEDIUM**으로 올렸습니다. (2) 이 환경에서 직접 실행해 재현한 결과는 HIGH입니다 (명령과 결과를 함께 적음). 검색 요약이나 일반 지식에만 기댄 항목은 LOW 또는 unverified로 둡니다.

## 한눈에 보는 결정

> **U12 결정 (2026-11-14):** 슬림펌킨 업무 메일은 Google Workspace로 확정됐고, 이 구간의 ImprovMX 기본안은 채택하지 않았습니다. 현재 절차는 `.planning/baseline/USER-TASKS.md`를 따릅니다. 아래 본문은 조사 당시의 기록입니다.

| # | 질문 | 결정 | 신뢰도 |
|---|------|------|--------|
| (a) | Tailwind Play CDN 대체 | **손으로 쓴 일반 CSS**로 옮긴다 (Tailwind CLI 쓰지 않음) | HIGH |
| (b) | 공통 블록 단일화 | **GitHub Pages에 내장된 Jekyll의 `_layouts`/`_includes`/`_data`** (Actions 없이 브랜치 배포 그대로) | HIGH |
| (b') | 로컬 미리보기 | `python3 -m http.server`를 **`bundle exec jekyll serve --livereload`**로 바꾼다. 로컬 Ruby 4.0.9에서는 `github-pages` gem이 아니라 **`jekyll = 3.10.0` 직접 고정 + 표준 라이브러리 gem 5개** 조합으로 돌린다 | HIGH (`build`·`serve --livereload` 모두 직접 실행) |
| (c) | 2개 언어 구조 | 한국어는 지금 경로 그대로, 영어는 **`/en/` 하위 디렉터리**. front matter의 `lang`·`ref`로 짝을 묶고 레이아웃이 `lang` 속성·전환 링크·`hreflang`을 만든다. 플러그인 쓰지 않음 | MEDIUM |
| (d) | Search Console 인증 | **도메인 속성(Domain property) + DNS TXT 레코드**(가비아 DNS) | MEDIUM |
| (e) | 도메인 메일 전달 | 기본은 **ImprovMX 무료**(가비아 DNS에 MX 2개와 SPF 1개만 추가, 네임서버 그대로). 슬림펌킨 업무 메일이 Google Workspace로 확인되면 Workspace 보조 도메인도 검토(unverified). Cloudflare Email Routing은 네임서버를 옮겨야 해서 이번에는 쓰지 않음 | MEDIUM |

---

## Recommended Stack

### Core Technologies

| Technology | Version | Purpose | Why Recommended |
|------------|---------|---------|-----------------|
| GitHub Pages 내장 Jekyll (브랜치 배포, "Deploy from a branch") | Jekyll **3.10.0**, Liquid **4.0.4**, Ruby **3.3.4**, `github-pages` **232** (`pages.github.com/versions.json` 기준) | `_layouts`·`_includes`·`_data`로 head 링크, 「공통」 CSS, 헤더·푸터, 사업자 정보, 언어 전환을 한 곳에서 관리 | 저장소는 **이미** 배포 때 Jekyll을 거칩니다(`_config.yml`). 그래서 `main` 푸시 = 배포, CI 없음, 빌드 결과물 커밋 없음이라는 세 조건을 모두 지키면서 템플릿을 쓸 수 있는 유일한 길입니다. 레이아웃과 include는 Jekyll 코어 기능이라 플러그인 허용 목록과 상관없습니다 |
| 일반 CSS (손으로 작성) | — | 법적 페이지 본문 스타일 (Tailwind 유틸리티 대체) | 법적 페이지 3종이 쓰는 Tailwind 클래스는 **약 45개**뿐입니다 (`grep`으로 셈: `mt-*`, `space-y-*`, `text-*`, `rounded-[28px]`, `md:p-12` 등). 랜딩이 이미 일반 CSS를 쓰므로 방식도 하나로 맞춰집니다. 빌드 도구·바이너리·재생성 단계가 생기지 않습니다 |
| 가비아(Gabia) DNS | — (현재 권한 있는 네임서버) | Search Console TXT, GitHub Pages 도메인 인증 TXT, 메일 MX/SPF | `dig` 결과 NS가 `ns.gabia.net`·`ns.gabia.co.kr`·`ns1.gabia.co.kr`이고, 등록 대행자도 Gabia입니다. 네임서버를 옮기지 않고 레코드만 더하는 쪽이 심사 기간 중 라이브 사이트를 위험에 빠뜨리지 않습니다 |

### Supporting Libraries

| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| `jekyll` (로컬 전용 Gemfile) | `= 3.10.0` | 로컬에서 운영과 같은 Jekyll 버전으로 미리보기 | 항상 (로컬 미리보기). 운영은 GitHub가 자체 gem 세트로 빌드하므로 Gemfile은 배포에 영향이 없습니다 |
| `webrick` | 최신 | `jekyll serve`의 HTTP 서버 | Ruby 3.0 이후 표준에서 빠짐. 없으면 `jekyll serve`가 실패합니다 |
| `csv`, `base64`, `bigdecimal`, `logger` | 최신 | Jekyll 3.x가 `require`하는 옛 표준 라이브러리 | Ruby 3.4+/4.0에서 기본 gem이 아니게 됨. 실제로 `csv` 없이 돌리면 `cannot load such file -- csv (LoadError)`로 멈추는 것을 확인했습니다 |
| `kramdown-parser-gfm` | 최신 | Jekyll 3.10의 마크다운 의존성 | Jekyll 3.10이 요구합니다. 사이트는 마크다운 페이지를 쓰지 않습니다 |
| `jekyll-sitemap` / `jekyll-seo-tag` | 1.4.0 / 2.8.0 (GitHub Pages 허용 목록) | — | **이번 마일스톤에는 쓰지 않음.** 법적 페이지가 `noindex`이고 랜딩 메타는 이미 손으로 썼습니다. 다음 마일스톤에서 색인 대상 페이지가 늘면 검토합니다 |

### Development Tools

| Tool | Purpose | Notes |
|------|---------|-------|
| `bundle exec jekyll serve --livereload` | 로컬 미리보기 (`http://localhost:4000`) | 저장소 루트에서 실행합니다. 절대 경로(`/favicon/...`)가 그대로 동작합니다 |
| `bundle exec jekyll build` → `python3 -m http.server -d _site` | Ruby 서버 없이 결과물만 보고 싶을 때 | 빌드한 `_site/`를 정적으로 띄웁니다. `_site/`는 `.gitignore`에 넣습니다 |
| `dig` | DNS 반영 확인 | `dig +short runningpencil.com TXT`, `dig +short runningpencil.com MX`, `dig _github-pages-challenge-SlimPumpkin.runningpencil.com TXT` |
| (선택) 공통 블록·`lang`·`hreflang` 점검 스크립트 | `_site/`를 훑어 모든 페이지에 푸터 사업자 정보·지원 이메일·언어 전환 링크가 있는지 검사 | Jekyll로 단일화하면 복사 드리프트 자체가 사라지므로 **필수 아님**. 넣는다면 Python 표준 라이브러리만으로 쓰고 `_config.yml`의 `exclude`에 등록합니다 |

## Installation

```bash
# 로컬 미리보기용 (운영 배포와 무관 — GitHub Pages는 자체 gem 세트로 빌드)
cat > Gemfile <<'EOF'
source "https://rubygems.org"

# 운영(GitHub Pages)과 같은 Jekyll 버전을 직접 고정한다.
# github-pages gem은 로컬 Ruby 4.x에 설치되지 않는다 (아래 Version Compatibility 참고).
gem "jekyll", "= 3.10.0"
gem "kramdown-parser-gfm"

# Ruby 3.4+/4.0에서 기본 gem이 아니게 된 표준 라이브러리 + jekyll serve용 서버
gem "webrick"
gem "csv"
gem "base64"
gem "bigdecimal"
gem "logger"
EOF

bundle config set --local path vendor/bundle
bundle install
bundle exec jekyll serve --livereload
```

`_config.yml`에 반드시 더할 것 (아래 「What NOT to Use」의 `exclude` 항목 참고):

```yaml
exclude:
  - CNAME
  - CLAUDE.md
  - README.md
  - .planning/
  - Gemfile
  - Gemfile.lock
  - vendor/
  - prepare/      # gitignore 대상이라 운영에는 없지만, 로컬 jekyll serve가 _site/로 복사하지 않게
  # 점검 스크립트를 넣으면 그 경로도
```

`_config.yml`에 `url`도 명시합니다. `hreflang`은 `https://`를 포함한 전체 URL이어야 하는데, `url`이 없으면 `absolute_url` 필터가 `/en/privacy-policy/`처럼 루트 상대 경로만 내놓는 것을 확인했습니다. `url`을 두면 `https://runningpencil.com/en/privacy-policy/`가 나오고, 로컬 `jekyll serve`에서는 자동으로 `http://localhost:4000/…`로 바뀝니다 (HIGH, 직접 실행).

```yaml
url: "https://runningpencil.com"
```

`.gitignore`에 더할 것: `_site/`, `.jekyll-cache/`, `vendor/`, `.bundle/`. `Gemfile`과 `Gemfile.lock`은 커밋해 로컬 환경을 재현할 수 있게 합니다.

---

## (a) Tailwind Play CDN → 정적 CSS

**결정: 손으로 쓴 일반 CSS.** 「공통」 묶음 바로 아래 「법적 페이지 전용」에 본문 규칙을 더하고, `<script src="https://cdn.tailwindcss.com">`와 `<script id="tailwind-config">`를 지웁니다. (HIGH — 클래스 목록은 저장소에서 직접 셈)

- 현재 Play CDN은 `https://cdn.tailwindcss.com` → `302 /3.4.17`로 **Tailwind v3.4.17**을 내려줍니다 (`curl -sI`로 확인). 설정도 v3 방식(`tailwind.config = {...}`)입니다.
- 법적 페이지가 쓰는 유틸리티는 다음이 전부입니다: `bg-white border-[1.5px] border-line border-t decoration-2 decoration-accent font-black font-bold font-semibold hover:text-accent leading-[1.25] leading-[1.7] list-disc max-w-[800px] md:p-12 mt-10 mt-3 mt-3.5 mx-auto p-7 pl-5 pt-4 px-6 py-[clamp(48px,6vw,80px)] rounded-[28px] space-y-1 space-y-3 space-y-8 text-[13px] text-[clamp(30px,6.5vw,42px)] text-accent text-ink text-muted text-muted-2 text-sm text-xl tracking-[-1px] tracking-[0.04em] transition-colors underline underline-offset-4`.
- 이를 의미 있는 클래스 몇 개(`.rp-legal-card`, `.rp-legal-eyebrow`, `.rp-legal-title`, `.rp-legal-body` 등)로 묶어 옮기면 영문판·지원 페이지가 같은 클래스를 재사용합니다. 토큰(`ink #2B2B2B`, `accent #7C580D`, `muted #4A463F`, `muted-2 #57534C`, `line #E4E0D6`)은 CSS 사용자 정의 속성(`--rp-ink` 등)으로 한 번만 정의합니다.

**꼭 챙길 함정 — Preflight:** Play CDN을 걷어 내면 Tailwind의 기본 초기화(Preflight)도 같이 사라집니다. 지금 화면은 이 초기화에 기대고 있습니다. 아래는 `tailwindcss@3.4.17/src/css/preflight.css` 원문에서 확인한 것 중 법적 페이지에 영향이 있는 규칙입니다 (MEDIUM, unpkg에서 원문 확인).
- `html { line-height: 1.5 }`와 `body { line-height: inherit }`. 헤더·푸터는 「공통」 묶음이 `line-height: normal`로 덮어써서 영향이 없지만, 본문 중 `leading-*`가 없는 부분은 1.5에 기대고 있습니다.
- `*, ::before, ::after { border-width: 0; border-style: solid; border-color: <기본 회색> }`. `border-t border-line`(약관 하단 구분선)과 `border-[1.5px] border-line`(카드)은 이 초기화 덕에 너비만 주면 실선이 됩니다. 옮길 때는 `border-top: 1px solid var(--rp-line)`처럼 세 값을 모두 씁니다.
- `h1`~`h6 { font-size: inherit; font-weight: inherit }`, `blockquote, dl, dd, h1~h6, hr, figure, p, pre { margin: 0 }`, `ol, ul, menu { list-style: none; margin: 0; padding: 0 }` (그래서 `list-disc pl-5`를 명시해 둔 것), `a { color: inherit; text-decoration: inherit }`.
- `text-sm`은 글자 크기만이 아니라 `line-height`도 함께 줍니다 (0.875rem/1.25rem). `text-xl`도 마찬가지입니다 (1.25rem/1.75rem). 크기만 옮기면 줄 간격이 바뀝니다. (MEDIUM, Tailwind v3 기본 테마 일반 지식)
- `img, svg { display: block }`. 헤더 로고 SVG는 grid 항목이라 어차피 block으로 처리되어 영향이 없습니다 (랜딩이 Preflight 없이 같은 헤더를 그리고 있음).
- `space-y-*`는 `.x > * + * { margin-top: … }`로, `md:p-12`는 `@media (min-width: 768px)`로 옮깁니다.
- 이 초기화 규칙을 「법적 페이지 전용」 범위(예: `.rp-legal` 아래)에만 걸어 랜딩에 영향이 없게 합니다.
- 검증 방법: 옮기기 전 각 법적 페이지를 375px·768px·1280px에서 캡처해 두고 옮긴 뒤 비교합니다.

**CSS를 어디에 둘지:** `_includes/css/common.css`, `_includes/css/legal.css`로 나누고 각 페이지 `<style>` 안에서 `{% include css/common.css %}`로 **인라인**합니다. 외부 `.css` 파일로 빼면 요청이 하나 늘고, GitHub Pages의 짧은 캐시(약 10분) 동안 HTML과 CSS 버전이 어긋날 수 있습니다. 지금처럼 페이지마다 완결되는 렌더링을 유지하는 쪽이 이 규모(공통 CSS 약 3KB)에서는 단순합니다. (판단은 MEDIUM. 캐시 10분 수치는 확인하지 않은 일반 지식이라 LOW)

## (b) 공통 블록 단일화

**결정: GitHub Pages 내장 Jekyll의 `_layouts`/`_includes`/`_data`.** (HIGH)

세 가지 선택지를 프로젝트의 핵심 제약 「`main` 푸시 = 배포, CI 없음, 단순함」에 대어 보면 다음과 같습니다.

| 기준 | **Jekyll include (권장)** | 로컬 빌드 스크립트 (마커 사이를 찍어 넣고 결과 HTML 커밋) | 일반 HTML 유지 + 드리프트 검사 스크립트 |
|------|------|------|------|
| `main` 푸시 = 배포 | 그대로 (GitHub가 빌드) | 그대로. 단, 스크립트를 **안 돌리고 푸시하면** 어긋난 HTML이 배포됨 | 그대로. 검사를 안 돌리면 드리프트가 배포됨 |
| CI 필요 | 없음 | 안전하게 쓰려면 검사용 Actions나 pre-commit hook 필요 | 같음 |
| 빌드 결과물 커밋 | 없음 | 있음 (생성된 HTML = 원본. 편집 위치가 헷갈림) | 없음 |
| 페이지별 변수 (언어·짝 페이지 URL·현재 메뉴·갱신일) | Liquid로 자연스럽게 (`page.lang`, `site.data.i18n[page.lang]`) | 스크립트에 템플릿 엔진을 직접 만들어야 함 | 불가. 영문판이 생기면 블록이 ko/en 두 벌로 갈라져 검사 규칙도 두 벌 |
| 페이지 증가(지원·영문 4종·위치 약관 → 9~10쪽) | 페이지마다 front matter 몇 줄 | 마커 수만큼 늘어남 | 복사본 수만큼 위험 증가 |
| 로컬 미리보기 | Ruby/Bundler 필요 (아래 레시피로 해결, 직접 확인) | `python3 -m http.server` 그대로 | 그대로 |
| 사업자 정보·지원 이메일 단일 출처 | `_data/company.yml` 한 파일 | 스크립트 상수 | 불가 |

드리프트 검사 방식은 「복사는 그대로 두고 어긋남만 잡는」 방식이라 영문판이 생기는 순간 「같아야 할 블록」의 정의부터 복잡해집니다. 빌드 스크립트 방식은 미리보기가 편하지만 「생성물이 곧 원본」이라 결국 실행을 잊는 순간 깨지고, 이를 막으려면 CI가 필요해져 단순함의 이점이 사라집니다. Jekyll은 이미 배포 경로에 있으므로 **새 의존성이 운영에는 0개**이고, 대가는 로컬 미리보기 명령이 바뀌는 것 하나입니다.

**구성 (권장 파일 배치):**

```
_config.yml           # exclude 보강, (선택) defaults로 lang 기본값
_data/
  company.yml         # 상호·대표자·사업자등록번호·주소·지원 이메일 — 사용자가 값을 줌
  i18n.yml            # ko/en 헤더·푸터·전환 링크 문구
_includes/
  head.html           # 글꼴·파비콘·매니페스트 링크, theme-color, hreflang
  header.html         # 로고(인라인 SVG), 메뉴 — 링크는 랜딩/하위 페이지에 따라 include 변수로
  footer.html         # 약관 링크, 사업자 정보, 저작권, OSM 출처
  lang-switch.html
  css/common.css
  css/legal.css
_layouts/
  base.html           # <html lang="{{ page.lang }}"> + head + header + {{ content }} + footer
  legal.html          # layout: base 위에 모눈종이 + 흰 카드
index.html            # layout: base (랜딩 전용 CSS·SVG defs·스크립트는 본문에 그대로)
privacy-policy/index.html, terms/…, data-deletion/…, support/…   # layout: legal, lang: ko
en/privacy-policy/index.html, en/terms/…, en/data-deletion/…, en/support/…  # layout: legal, lang: en
```

**확인한 사실과 주의점:**
- 이 저장소의 HTML 4개에는 Liquid와 충돌할 `{{`, `{%`, `{#`가 **하나도 없습니다** (`grep`으로 확인). 실제로 `index.html`과 `terms/index.html` 사본 앞에 빈 front matter(`---`/`---`)만 붙여 Jekyll 3.10으로 빌드하니 결과가 원본과 **바이트 단위로 같았습니다**(`cmp`). front matter를 붙이면 그 파일 전체가 Liquid로 처리되므로, 앞으로 인라인 JS·CSS에 `{{`나 `{%`가 필요하면 `{% raw %}…{% endraw %}`로 감싸야 합니다. 이 규칙을 `CLAUDE.md`에 적습니다. (HIGH)
- front matter가 **없는** HTML은 Jekyll이 그대로 복사합니다. 그래서 페이지를 하나씩 옮겨도 사이트가 깨지지 않습니다. (HIGH, Jekyll 기본 동작)
- 레이아웃 이름을 `default`나 `page`로 짓지 않습니다. GitHub Pages는 `jekyll-default-layout`, `jekyll-optional-front-matter` 같은 플러그인을 기본으로 켜는데, 이들은 그 이름의 레이아웃을 자동으로 적용합니다. `base`·`legal`처럼 다른 이름을 쓰면 이 문제를 피할 수 있습니다. (LOW, 예방 조치. 공식 문서로 동작 범위를 확인하지 않음)
- GitHub Pages는 `safe` 모드라 허용 목록 밖의 플러그인과 `_plugins/`를 실행하지 않습니다. 이 설계는 플러그인을 쓰지 않습니다.

## (c) 2개 언어 정적 구조

**결정: 한국어는 지금 URL 그대로, 영어는 `/en/` 하위 디렉터리.** (MEDIUM)

| 한국어 (기본) | 영어 |
|---------------|------|
| `/privacy-policy/` | `/en/privacy-policy/` |
| `/terms/` | `/en/terms/` |
| `/data-deletion/` | `/en/data-deletion/` |
| `/support/` (신설) | `/en/support/` |
| `/` (랜딩) | 이번 범위에는 영문 랜딩 없음. 영문 페이지의 로고·메뉴는 `/`로 연결 |

- 이미 제출했거나 제출할 한국어 URL을 바꾸지 않습니다. 콘솔에 넣은 URL이 바뀌면 심사를 다시 받아야 할 수 있습니다.
- **짝 묶기:** 각 페이지 front matter에 `lang: ko|en`과 `ref: privacy`처럼 같은 키를 둡니다. 레이아웃이 `{% assign alts = site.pages | where: "ref", page.ref %}`로 짝을 찾아 (1) 언어 전환 링크, (2) `<link rel="alternate" hreflang="{{ p.lang }}" href="{{ p.url | absolute_url }}">`을 만듭니다. Jekyll 3.10 코어의 `where` 필터만 쓰므로 플러그인이 필요 없습니다. 스크래치 사이트에서 `/privacy-policy/`(ko)와 `/en/privacy-policy/`(en) 두 쪽으로 빌드해, 양쪽 모두 자기 자신을 포함한 두 개의 전체 URL `hreflang`이 나오는 것을 확인했습니다 (HIGH, 직접 실행). `jekyll-polyglot` 같은 i18n 플러그인은 GitHub Pages 허용 목록에 없습니다. (HIGH, `versions.json` 목록 확인)
- **`<html lang>`**: `ko` / `en`. 영문 페이지에는 영문 `<title>`·`description`을 둡니다. (HIGH)
- **`hreflang`의 실제 효용:** Google 규칙은 각 버전이 자기 자신을 포함한 같은 목록을 서로 가리켜야 하고(상호 링크가 없으면 무시), URL은 `https://`를 포함한 전체 주소여야 한다는 것입니다 ([Google 공식](https://developers.google.com/search/docs/specialty/international/localized-versions)). 그런데 지금 법적 페이지는 `noindex`라 색인되지 않으므로 이번 마일스톤에서는 검색 효과가 거의 없습니다. 레이아웃이 자동으로 만드니 비용은 0이라 **넣되**, 심사자에게 실제로 의미 있는 것은 **눈에 보이는 언어 전환 링크와 `lang` 속성**입니다. `noindex`를 정식 게시본에서 뗄지는 별도 결정이며, 로드맵에서 열린 질문으로 다뤄야 합니다. (MEDIUM)
- **자동 언어 리디렉션(JS로 `navigator.language` 보고 이동)은 하지 않습니다.** 정적 호스팅에는 서버 측 `Accept-Language` 처리가 없고, JS 리디렉션은 심사자가 콘솔에 등록된 바로 그 URL을 보지 못하게 만듭니다. (MEDIUM)

## (d) Google Search Console 소유권 인증

**결정: 도메인 속성(`runningpencil.com`) + 가비아 DNS의 `@` 호스트에 `google-site-verification=…` TXT 레코드.** (MEDIUM)

- Search Console 공식 도움말: 도메인 속성은 **DNS 레코드로만** 인증할 수 있고, HTML 파일과 메타 태그는 URL 접두어 속성에만 쓸 수 있습니다. 인증 상태는 증거가 남아 있을 때만 유지되며, DNS 레코드는 인증 뒤에도 지우면 안 되고, HTML 파일을 지우면 인증을 잃습니다 ([support.google.com/webmasters/answer/9008080](https://support.google.com/webmasters/answer/9008080)).
- Google OAuth 브랜드 검증 공식 문서: 승인된 도메인(Authorized domains)에는 홈페이지·처리방침·약관 URL의 **최상위 비공개 도메인(top private domain)**이 들어가야 하고, 그 소유권을 Search Console로 확인해야 하며, 확인한 Google 계정은 API Console 프로젝트의 Owner 또는 Editor여야 합니다 ([developers.google.com/…/brand-verification](https://developers.google.com/identity/protocols/oauth2/production-readiness/brand-verification), [support.google.com/cloud/answer/13464321](https://support.google.com/cloud/answer/13464321)).
- **두 Google 문서 모두 도메인 속성과 URL 접두어 속성 중 어느 쪽이어야 하는지는 밝히지 않습니다.** 「URL 접두어 속성(`https://runningpencil.com/`)을 메타 태그로 인증해도 통과한다」는 말은 **확인되지 않았습니다(unverified)**. 도메인 속성은 `http`/`https`/`www`/하위 도메인을 모두 포함하는 상위 집합이라 어느 해석에도 맞습니다.
- 이 프로젝트에 특히 맞는 이유: 이번 마일스톤에서 `<head>`를 include로 다시 짜므로, 메타 태그나 인증 HTML 파일은 리팩터링 중에 빠질 수 있고 그러면 인증이 조용히 풀립니다. DNS TXT는 사이트 코드와 분리되어 있습니다.
- 인증은 Google Cloud 프로젝트의 Owner/Editor 계정으로 합니다 (사용자 작업).

## (e) 도메인 메일 전달 (`support@runningpencil.com` → 슬림펌킨 업무 메일)

> **U12 결정 (2026-11-14):** 슬림펌킨 업무 메일은 Google Workspace로 확정됐고, 이 구간의 ImprovMX 기본안은 채택하지 않았습니다. 현재 절차는 `.planning/baseline/USER-TASKS.md`를 따릅니다. 아래 본문은 조사 당시의 기록입니다.

**현재 DNS (2026-11-14 `dig` 결과, HIGH):** NS = 가비아. 루트 A = GitHub Pages 4개(`185.199.108–111.153`). AAAA 없음. **MX 없음. TXT 없음.** CAA 없음. `www` CNAME = `slimpumpkin.github.io`. 즉 메일·인증 레코드와 부딪칠 기존 값이 하나도 없습니다.

**결정 트리:**

1. **기본 → ImprovMX 무료.** 업무 메일이 어떤 서비스든(네이버 웍스·다우오피스·Gmail 등) 받는 주소만 있으면 됩니다. 가비아 DNS에 레코드 3개만 더하고 네임서버는 그대로 둡니다.
   - MX `@` → `mx1.improvmx.com` (우선순위 10), `mx2.improvmx.com` (우선순위 20)
   - TXT `@` → `v=spf1 include:spf.improvmx.com ~all`
   - 출처: [improvmx.com/guides/generic-dns-configuration](https://improvmx.com/guides/generic-dns-configuration). 실제 입력 직전에는 ImprovMX 대시보드의 「Recommended Value」를 그대로 복사합니다. (MEDIUM)
   - 무료 플랜: 도메인 1개, 별칭 25개, 하루 전달 500통, **SMTP 발송 0** ([improvmx.com/pricing](https://improvmx.com/pricing/)). 지원 문의량으로는 충분합니다. (MEDIUM)
2. **조건부 → 슬림펌킨 업무 메일이 Google Workspace로 확인되면 Workspace 보조 도메인(secondary domain)을 검토.** `runningpencil.com`을 추가하고 `support@`를 그룹이나 별칭으로 만들면 제3자 전달 서비스가 없고 `support@`로 **답장도 보낼** 수 있습니다. 다만 비용·절차를 공식 문서로 확인하지 않았으므로(unverified) 기본안으로 두지 않습니다. 업무 메일 서비스는 사용자에게 확인해야 합니다.
3. **Cloudflare Email Routing은 이번에는 쓰지 않습니다.** 무료이고 견고하지만 공식 문서가 「Cloudflare를 권한 있는 네임서버로 쓰는 고객에게 제공된다」고 적고 있습니다 ([developers.cloudflare.com/email-routing](https://developers.cloudflare.com/email-routing/llms-full.txt)). 그러려면 네임서버를 가비아에서 Cloudflare로 옮기고 A 4개·`www` CNAME·TXT를 다시 만들어야 합니다. 심사 기간에 라이브 사이트의 DNS 전체를 옮기는 위험이 이점보다 큽니다. 나중에 DNS를 Cloudflare로 옮길 계획이 따로 생기면 그때 고릅니다. (MEDIUM)

**전달 전용 방식의 한계:** ImprovMX 무료·Cloudflare Email Routing·Forward Email 무료는 모두 **받기만** 합니다. 답장은 슬림펌킨 업무 메일 주소에서 나갑니다. 심사 요건은 「연락 수단이 있을 것」이라 이것으로 충분하지만, `support@`로 답장해야 한다면 Workspace 보조 도메인이나 유료 SMTP가 필요합니다.

**DNS 레코드 공존 (최종 목표 상태):**

| 호스트 | 유형 | 값 | 목적 | 비고 |
|--------|------|----|------|------|
| `@` | A ×4 | `185.199.108.153` ~ `185.199.111.153` | GitHub Pages | 이미 있음 |
| `@` | AAAA ×4 (선택) | `2606:50c0:8000::153` ~ `2606:50c0:8003::153` | GitHub Pages IPv6 | GitHub 문서상 선택. A와 함께 둠 ([GitHub Docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)) |
| `www` | CNAME | `slimpumpkin.github.io` | `www` → 루트 자동 리디렉션 | 이미 있음 |
| `@` | MX ×2 | 메일 서비스 값 | 메일 수신 | 루트에 CNAME이 없으므로 A·MX·TXT가 함께 있어도 충돌 없음 |
| `@` | TXT | `v=spf1 include:… ~all` | SPF | **`v=spf1` 레코드는 하나만.** 서비스가 둘 이상이면 `include:`를 한 레코드에 합칩니다 |
| `@` | TXT | `google-site-verification=…` | Search Console 도메인 속성 | 인증 뒤에도 지우지 않음. SPF와 별개의 TXT로 공존 가능 |
| `_github-pages-challenge-SlimPumpkin` | TXT | GitHub가 준 값 | GitHub Pages 도메인 인증 (도메인 탈취 방지) | 조직 설정 > Pages > Add a domain ([GitHub Docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/verifying-your-custom-domain-for-github-pages)). **권장**: 프로젝트 사이트라 저장소 삭제·설정 실수 시 남이 도메인을 가져갈 수 있음 |
| `_dmarc` (선택) | TXT | `v=DMARC1; p=none` | DMARC 보고 | 이 도메인에서 메일을 보내지 않으면 선택 사항 |

- 와일드카드 레코드(`*.runningpencil.com`)는 만들지 않습니다. GitHub는 인증한 도메인이라도 탈취 위험이 있다고 경고합니다. (MEDIUM, GitHub Docs)
- 나중에 CAA 레코드를 넣는다면 GitHub Pages HTTPS 인증서 발급 기관(Let's Encrypt)을 허용해야 합니다. (LOW, 확인하지 않은 일반 지식)

---

## Alternatives Considered

> **U12 결정 (2026-11-14):** 슬림펌킨 업무 메일은 Google Workspace로 확정됐고, 이 구간의 ImprovMX 기본안은 채택하지 않았습니다. 현재 절차는 `.planning/baseline/USER-TASKS.md`를 따릅니다. 아래 본문은 조사 당시의 기록입니다.

| Recommended | Alternative | When to Use Alternative |
|-------------|-------------|-------------------------|
| 손으로 쓴 CSS | Tailwind CLI 독립 실행 바이너리 **v4.3.5** (GitHub 최신 릴리스) | 법적 페이지 디자인을 자주 바꾸고 유틸리티 클래스가 수백 개로 늘 때. 단, 현재 마크업은 v3 설정 형식이라 v4로는 **똑같이 재현되지 않으며**(설정이 CSS `@theme`으로 바뀜), 생성 CSS를 커밋하고 다시 돌리는 단계가 생깁니다 |
| GitHub Pages 브랜치 배포 + 내장 Jekyll 3.10 | GitHub Actions 사용자 워크플로 + Jekyll 4.4 (또는 Eleventy 등) | 허용 목록 밖 플러그인(`jekyll-polyglot` 등)이나 Jekyll 4 기능이 꼭 필요할 때. 배포가 Actions에 묶이고 실패 지점이 하나 늘어나므로 이번 범위에는 과합니다 |
| 로컬 `jekyll = 3.10.0` 직접 고정 | `github-pages` gem (운영과 완전히 같은 gem 세트) | 로컬 Ruby를 **3.3.x**(운영은 3.3.4)로 맞출 수 있을 때 (`mise`/`rbenv`). 이 사이트는 마크다운·플러그인을 쓰지 않으므로 Jekyll 3.10 + Liquid 4.0.4만 같으면 결과가 같습니다 |
| Jekyll include | 로컬 빌드 스크립트 / 드리프트 검사 | 「Ruby를 절대 설치하지 않는다」가 강한 제약일 때만. 그 경우 드리프트 검사보다 빌드 스크립트 + pre-commit hook이 낫습니다 |
| ImprovMX 무료 | Forward Email 무료 | 오픈 소스 서비스를 선호할 때. 무료 플랜은 전달만 됩니다 ([pricing](https://forwardemail.net/en/pricing)). 무료 플랜의 전달 설정이 공개 DNS TXT에 드러나 받는 주소가 노출된다는 점은 확인하지 않았습니다(unverified) |
| ImprovMX 무료 | 가비아 자체 메일 포워딩 | 가비아에 무료 메일 전달 기능이 있다면 서비스 하나를 줄일 수 있음. **가비아 공식 문서로 확인하지 못했습니다(unverified)** — 사용자가 가비아 관리 화면에서 확인 |
| 도메인 속성 + DNS TXT | URL 접두어 속성 + 메타 태그/HTML 파일 | DNS를 만질 수 없을 때만. OAuth 브랜드 검증에 충분한지 확인되지 않았고, 사이트 리팩터링 중 빠질 위험이 있습니다 |

## What NOT to Use

| Avoid | Why | Use Instead |
|-------|-----|-------------|
| `cdn.tailwindcss.com` (Play CDN) | Tailwind 공식이 개발용으로 안내하는 런타임 컴파일. 렌더 차단, 버전 미고정 실행 스크립트, CDN 장애 시 심사 대상 페이지 스타일이 통째로 사라짐 | 손으로 쓴 CSS (위 (a)) |
| 로컬 Ruby 4.x에 `github-pages` gem | **설치가 안 됩니다.** `github-pages 232` → `jekyll-commonmark-ghpages 0.5.1` → `commonmarker ~> 0.22`인데 `commonmarker 0.23.12`가 `ruby < 4.0`을 요구합니다. 버전을 고정하지 않으면 Bundler가 조용히 **`github-pages 223` / Jekyll 3.9.0**으로 내려가 운영과 다른 버전이 깔리고, 그마저 `csv` LoadError로 멈춥니다 (직접 실행해 확인) | `jekyll = 3.10.0` 직접 고정 + `csv`·`base64`·`bigdecimal`·`logger`·`webrick` |
| `exclude`에 Gemfile 등을 빼먹기 | `_config.yml`이 `exclude`를 직접 지정하므로 Jekyll 3.10의 기본 제외 목록(Gemfile·vendor 등)이 **덮어써집니다.** 실험해 보니 `exclude: [CNAME]`만 두면 `Gemfile`, `Gemfile.lock`, `vendor/bundle/…`, 스크립트 파일이 모두 `_site/`에 공개됐습니다 | `exclude`에 `Gemfile`, `Gemfile.lock`, `vendor/`, 스크립트 경로를 명시 |
| front matter를 붙인 페이지를 `python3 -m http.server`로 미리보기 | Liquid가 처리되지 않은 원본(`{% include %}`, front matter)이 그대로 보여 「깨졌다」고 오판합니다 | `bundle exec jekyll serve` 또는 `jekyll build` 뒤 `_site/` 서빙 |
| `jekyll-polyglot` 등 i18n 플러그인 | GitHub Pages 허용 목록에 없어 브랜치 배포에서는 무시되거나 빌드가 실패합니다 | 디렉터리(`/en/`) + front matter(`lang`, `ref`) + `_data/i18n.yml` |
| JS 자동 언어 리디렉션 | 심사자가 등록된 URL을 그대로 볼 수 없게 되고, 정적 호스팅에는 서버 측 언어 협상이 없습니다 | 눈에 보이는 언어 전환 링크 |
| 레이아웃 이름 `default`/`page` | GitHub Pages가 기본으로 켜는 플러그인이 이 이름을 자동 적용할 수 있습니다 (LOW, 예방 조치) | `base`, `legal` |
| 이번 마일스톤에 Cloudflare로 네임서버 이전 | 메일 하나 때문에 라이브 사이트 DNS 전체를 옮기게 됨 | 가비아 DNS에 MX/TXT 추가 |
| SPF TXT를 두 개 이상 | `v=spf1` 레코드가 여러 개면 SPF 검사가 실패합니다 (RFC 7208 일반 규칙. 이 조사에서 원문을 따로 읽지는 않음) | `include:`를 한 레코드에 합침 |
| 와일드카드 DNS (`*.runningpencil.com`) | GitHub Pages 하위 도메인 탈취 위험 (GitHub Docs 경고) | 필요한 호스트만 명시 |

## Stack Patterns by Variant

> **U12 결정 (2026-11-14):** 슬림펌킨 업무 메일은 Google Workspace로 확정됐고, 이 구간의 ImprovMX 기본안은 채택하지 않았습니다. 현재 절차는 `.planning/baseline/USER-TASKS.md`를 따릅니다. 아래 본문은 조사 당시의 기록입니다.

**기본 (업무 메일 서비스와 무관):**
- ImprovMX 무료 + 가비아 DNS
- 답장은 업무 주소에서 나간다는 점을 지원 페이지 문구에 반영할 필요는 없음 (심사 요건은 연락 수단 존재)

**슬림펌킨이 Google Workspace를 쓰는 것으로 확인되면 (unverified 경로):**
- Workspace 보조 도메인으로 MX를 Google 값으로
- 받기와 답장을 `support@`로 일원화할 수 있고, 제3자 전달 서비스가 필요 없음

**개발자가 Ruby를 쓰지 않기로 하면:**
- Jekyll 페이지는 로컬에서 볼 방법이 없어 `main` 푸시 후 라이브에서 확인하게 됨 → **권장하지 않음.** 이 기기에는 Homebrew Ruby 4.0.9가 이미 있고 위 Gemfile로 바로 돌아감

**위치기반서비스 이용약관 페이지가 추가되면:**
- `layout: legal`, `ref: location-terms`로 한국어 1쪽(+필요 시 `/en/`) 추가. 구조 변경 없음

## Version Compatibility

| Package A | Compatible With | Notes |
|-----------|-----------------|-------|
| GitHub Pages 운영 빌드 | Jekyll 3.10.0, Liquid 4.0.4, Ruby 3.3.4, `github-pages` 232 | [pages.github.com/versions.json](https://pages.github.com/versions.json) 기준 (MEDIUM). rubygems 최신 `github-pages`는 233이지만 운영 목록은 232 |
| `jekyll 3.10.0` | Ruby **4.0.9** (로컬 Homebrew) | `csv`·`base64`·`bigdecimal`·`logger`·`webrick`를 Gemfile에 더하면 레이아웃·include·`page.lang`·`where` 필터·`absolute_url` 렌더링까지 정상 동작. 2026-11-14 스크래치 디렉터리에서 `bundle exec jekyll build`와 `bundle exec jekyll serve --livereload`(HTTP 200, LiveReload 35729 포트) 모두 확인 (HIGH) |
| `github-pages 232` | Ruby **< 4.0** 만 | `commonmarker 0.23.12`의 `required_ruby_version`이 `>= 2.6, < 4.0`. Ruby 4에서는 Bundler가 `github-pages 223`/Jekyll 3.9.0으로 후퇴 (HIGH, 직접 재현) |
| Tailwind Play CDN | Tailwind **v3.4.17** | `cdn.tailwindcss.com` → `302 /3.4.17`. 현재 마크업·설정은 v3 문법 (HIGH) |
| Tailwind CLI 독립 실행 바이너리 | **v4.3.5** | GitHub 최신 릴리스. v3 설정(`tailwind.config`)과 호환되지 않으므로 대안으로만 기록 (MEDIUM) |
| Pretendard | v1.3.9 (jsDelivr) | 변경 없음. `head.html` include로 옮기기만 함 |

## Sources

- [pages.github.com/versions.json](https://pages.github.com/versions.json) — GitHub Pages의 Jekyll·Liquid·Ruby·`github-pages` 버전과 허용 플러그인 목록 (MEDIUM)
- 로컬 실험 (2026-11-14, Ruby 4.0.9 / Bundler 4.0.23, 저장소 밖 스크래치 디렉터리) — `github-pages` 고정 시 의존성 충돌, `jekyll = 3.10.0` + 표준 라이브러리 gem 조합의 `build`·`serve --livereload` 성공, `ref`/`lang` 짝 `hreflang` 생성, `url` 유무에 따른 `absolute_url` 결과, 실제 `index.html`·`terms/index.html`에 빈 front matter를 붙였을 때 바이트 단위 동일 출력, 사용자 지정 `exclude`가 기본 제외 목록을 덮어써 Gemfile·vendor가 공개되는 현상 (HIGH)
- [unpkg.com/tailwindcss@3.4.17/src/css/preflight.css](https://unpkg.com/tailwindcss@3.4.17/src/css/preflight.css) — Preflight 원문 (MEDIUM)
- rubygems.org API — `commonmarker 0.23.12`의 `ruby_version >= 2.6, < 4.0`, `github-pages` 최신 233 (MEDIUM)
- `curl -sI https://cdn.tailwindcss.com` — Play CDN이 v3.4.17로 리디렉션 (HIGH)
- [github.com/tailwindlabs/tailwindcss/releases/latest](https://github.com/tailwindlabs/tailwindcss/releases/latest) — v4.3.5 (MEDIUM)
- [support.google.com/webmasters/answer/9008080](https://support.google.com/webmasters/answer/9008080) — 도메인 속성은 DNS로만 인증, 인증 증거를 지우면 인증을 잃음 (MEDIUM)
- [developers.google.com/identity/protocols/oauth2/production-readiness/brand-verification](https://developers.google.com/identity/protocols/oauth2/production-readiness/brand-verification) — 최상위 비공개 도메인 인증, Owner/Editor 계정, 홈페이지·처리방침 같은 도메인 (MEDIUM). 도메인 속성/URL 접두어 구분은 문서에 없음
- [support.google.com/cloud/answer/13464321](https://support.google.com/cloud/answer/13464321) — 승인된 도메인을 Search Console로 인증 (MEDIUM)
- [developers.google.com/search/docs/specialty/international/localized-versions](https://developers.google.com/search/docs/specialty/international/localized-versions) — `hreflang` 상호 링크·자기 참조·전체 URL·`x-default` (MEDIUM)
- [docs.github.com — managing a custom domain](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site) — A/AAAA 값, 와일드카드 경고 (MEDIUM)
- [docs.github.com — verifying your custom domain](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/verifying-your-custom-domain-for-github-pages) — `_github-pages-challenge-ORGANIZATION` TXT, 탈취 방지 (MEDIUM)
- [developers.cloudflare.com/email-routing](https://developers.cloudflare.com/email-routing/llms-full.txt) — 「Cloudflare를 권한 있는 네임서버로 쓰는 고객」 대상, SPF `include:_spf.mx.cloudflare.net` (MEDIUM). [limits](https://developers.cloudflare.com/email-routing/limits/) — 규칙 200, 목적지 200, 25 MiB
- [improvmx.com/guides/generic-dns-configuration](https://improvmx.com/guides/generic-dns-configuration) — MX `mx1/mx2.improvmx.com` 10/20, SPF `include:spf.improvmx.com` (MEDIUM). [improvmx.com/pricing](https://improvmx.com/pricing/) — 무료 1 도메인·25 별칭·하루 500통·SMTP 0 (MEDIUM)
- [forwardemail.net/en/pricing](https://forwardemail.net/en/pricing) — 무료는 전달만, 유료 $3/월부터 (MEDIUM)
- `dig`/`whois` (2026-11-14) — 현재 NS 가비아, A 4개, MX·TXT·AAAA·CAA 없음, `www` CNAME (HIGH)
- 확인 못 함 (unverified): 가비아 자체 무료 메일 포워딩 여부, Google Workspace 보조 도메인 비용·절차, Forward Email 무료 플랜의 DNS 공개 범위, URL 접두어 속성으로 OAuth 브랜드 검증이 통과하는지

---
*Stack research for: GitHub Pages 정적 사이트의 심사 대응 정비 (러닝펜슬)*
*Researched: 2026-11-14*
