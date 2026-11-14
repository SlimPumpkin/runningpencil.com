# Architecture Research

**Domain:** 빌드 없는 GitHub Pages 정적 사이트를 모바일 앱(러닝펜슬)의 심사 대응용 공식 웹사이트로 확장 (한국어 기본 + 영문판, 법적 문서, 지원 페이지, 사업자 표시)
**Researched:** 2026-11-14
**Confidence:** MEDIUM

저장소 근거 주장은 HIGH, 외부 플랫폼 주장은 LOW(공식 1차 출처 단일 확인 포함)입니다. 출처별 표시는 아래 「신뢰도 구분」 참고.

## 신뢰도 구분

이 문서의 주장은 근거에 따라 둘로 나뉩니다. 섞어 읽지 않도록 각 절에 표시했습니다.

| 근거 | 예 | 신뢰도 |
|------|----|--------|
| 저장소 직접 확인 (first-hand) | 현재 URL·파일 구조, `_config.yml`의 `exclude`, HTML에 Liquid 문법(`{{`, `{%`) 없음(grep 확인), 공통 블록 복사 현황 | HIGH |
| 공식 문서 1회 확인 (GSD seam 분류: `webfetch` = LOW, `--verified`도 LOW) | GitHub Pages 기본 플러그인 목록·`.`/`_` 시작 파일 제외, `jekyll-default-layout`은 Markdown에만 적용, Google OAuth 홈페이지·처리방침 요건, Cloudflare Email Routing은 Cloudflare DNS 필요 | LOW (공식 1차 출처, 단일 확인). 단 `jekyll-default-layout`이 Markdown에만 적용된다는 점은 GitHub Docs(기본 활성)와 플러그인 README 두 출처가 맞물림 |
| 확인 못함 / 추론 | 빌드 실패 시 이전 배포 유지 여부, 메일 라우팅 MX와 Pages A 레코드 공존, Search Console 속성 유형, 카카오·네이버·LINE·Apple·App Store 콘솔 필드명 | LOW — 근거로 삼지 않음 |

## Standard Architecture

### System Overview

이번 마일스톤이 끝난 뒤의 목표 구조입니다. 공통 블록을 한 곳에서 관리하는 방식(Jekyll include 또는 plain HTML + 동기화 스크립트)은 Stack 연구가 정합니다. 아래 경계·URL·사실값 소유 구조는 **두 방식 모두에서 그대로 성립**하도록 짰습니다.

```
┌──────────────────────────────────────────────────────────────────────────┐
│ 사실값 계층 (Single Source of Truth) — 사용자가 주는 값                       │
│  회사 사실값(상호·대표자·사업자번호·주소·지원 이메일·보호책임자·영문 서비스명)    │
│  문서 메타(문서별·언어별 시행일/최종 업데이트), 내비게이션 링크 목록, UI 문구     │
└───────────────┬──────────────────────────────────────────────────────────┘
                │ (Jekyll: 빌드 때 Liquid로 주입 / plain: 스크립트가 찍어 넣고 커밋)
┌───────────────▼──────────────────────────────────────────────────────────┐
│ 공유 셸 계층 (Shared Shell)                                                 │
│  head-common(글꼴·파비콘·매니페스트) · common.css · header(언어 전환 포함)     │
│  · footer(약관 링크 + 사업자 정보 슬롯 + 운영 안내 + 저작권 + OSM 표기)          │
├────────────────────────┬─────────────────────────────────────────────────┤
│ 랜딩 셸                 │ 문서 셸 (legal 레이아웃)                           │
│ 「랜딩 전용」 CSS·JS     │ 모눈종이 바탕 + 흰 카드 + legal.css(정적)          │
│ pre-paint 스크립트       │ 제목·시행일/최종 업데이트·언어 전환·본문 슬롯         │
├────────────────────────┼─────────────────────────────────────────────────┤
│ 페이지 계층             │                                                  │
│  /  (KO 랜딩)           │ KO: /privacy-policy/ /terms/ /data-deletion/      │
│                        │     /support/ (신규) [/location-terms/ 조건부]     │
│                        │ EN: /en/privacy-policy/ /en/terms/                │
│                        │     /en/data-deletion/ /en/support/               │
└────────────────────────┴─────────────────────────────────────────────────┘
                │
┌───────────────▼──────────────────────────────────────────────────────────┐
│ 외부 (사이트 밖, 사용자가 설정)                                               │
│  DNS: Pages A/AAAA(기존) · 메일 라우팅 MX/SPF/DKIM · Search Console TXT(택1)  │
│  메일 포워더 → 슬림펌킨 업무 메일 · 제공자 6곳/스토어 2곳 콘솔에 URL 등록         │
└──────────────────────────────────────────────────────────────────────────┘
```

### Component Responsibilities

| Component | Responsibility (소유하는 것) | Typical Implementation |
|-----------|-----------------------------|------------------------|
| 회사 사실값 (company facts) | 상호(KO/EN), 대표자, 사업자등록번호, 주소(KO/EN), 지원 이메일, 개인정보 보호책임자, 영문 서비스명 | Jekyll: `_data/company.yml` / plain: `shared/facts` 조각 한 벌. **본문·푸터 어디에도 이 값을 손으로 다시 쓰지 않음** |
| 문서 메타 (document meta) | 문서 키(`privacy`·`terms`·`deletion`·`support`·`location`)별, 언어별 시행일·최종 업데이트, 영문판이 번역한 한국어판 날짜 | Jekyll: `_data/legal.yml` / plain: 각 페이지의 표시 지점 + 검사 스크립트 |
| 내비·UI 문구 | 헤더 메뉴, 푸터 약관 링크 목록(언어별), "최종 업데이트"/"Last updated" 같은 고정 문구 | Jekyll: `_data/nav.yml`, `_data/i18n.yml` |
| head-common | 글꼴 `<link>`, 파비콘 4종, 매니페스트, `theme-color` | include 1개 |
| common.css | 지금의 「공통」 묶음 그대로 (`.rp-wrap`, `.rp-head`, `.rp-foot-*` …) | include해서 `<style>`에 인라인 (현재 전달 방식 유지, 요청 수 증가 없음) |
| header | 로고·브랜드·앵커 메뉴·언어 전환 링크 | include + 매개변수 `anchor_prefix`(랜딩 `""`, 그 외 `"/"`) |
| footer | 약관 링크, 사업자 정보 행(값이 있을 때만 렌더), 운영 안내, 저작권, OSM 출처 | include + `lang` |
| lang-switch | 같은 문서 키의 다른 언어 페이지가 **있을 때만** 링크 표시 | include, 짝을 못 찾으면 아무것도 그리지 않음 |
| legal 레이아웃 | 모눈종이·흰 카드, 제목, 날짜(문서 메타에서), 영문판의 "한국어판 우선" 문구, 본문 슬롯 | `_layouts/legal.html` (+ `_layouts/base.html`) |
| legal.css | Tailwind 런타임을 대체하는 정적 CSS. 본문은 클래스 없는 시맨틱 마크업(`h2`·`p`·`ul`·`table`)을 `.rp-doc` 아래에서 꾸밈 | 「법적 페이지 전용」 묶음을 확장, 또는 `/assets/css/legal.css` |
| 랜딩 | 히어로·`#story`·`#demo`·`#get` + 그 스크립트 | 기존 `index.html` 유지, 공통 부분만 include로 교체 |
| 문서 본문 | 각 문서의 실제 조항 텍스트 | 페이지 파일 안의 본문 HTML. 회사 사실값은 참조로만 |

## Recommended Project Structure

Jekyll 방식을 기준으로 적었습니다(근거: GitHub Pages가 이미 이 저장소를 Jekyll로 한 번 거침 — `_config.yml` 존재로 확인. 새 도구 체인 없이 `_layouts`/`_includes`/`_data`를 바로 쓸 수 있음). plain HTML 방식의 대응 위치는 다음 절의 비교표에 있습니다.

```
runningpencil.com/
├── _config.yml               # exclude 갱신 (Gemfile, scripts/ 등), permalink 전역 설정 금지
├── _data/
│   ├── company.yml           # 회사 사실값 — 유일한 출처. 모르는 값은 비워 둠 (빈 값 = 렌더 안 함)
│   ├── legal.yml             # 문서 키 × 언어별 시행일·최종 업데이트·source_updated
│   ├── nav.yml               # 헤더/푸터 링크 (ko/en)
│   └── i18n.yml              # 고정 UI 문구 (ko/en)
├── _includes/
│   ├── head-common.html      # 글꼴·파비콘·매니페스트
│   ├── common.css            # 지금의 「공통」 묶음 (layout이 <style> 안에 include)
│   ├── header.html           # anchor_prefix, lang 매개변수
│   ├── footer.html           # 사업자 정보 슬롯 포함
│   ├── lang-switch.html      # 짝 문서가 있을 때만 링크
│   └── legal.css             # Tailwind 대체 정적 CSS
├── _layouts/
│   ├── base.html             # <html lang>, head-common, common.css, header, footer, {{ content }}
│   └── legal.html            # layout: base. 모눈종이 카드, 제목·날짜·본문 슬롯
├── index.html                # 랜딩. front matter(layout: null) + include 3~4개, 나머지는 그대로
├── privacy-policy/index.html # layout: legal, lang: ko, doc_key: privacy  ← 기존 URL 유지
├── terms/index.html          # layout: legal, lang: ko, doc_key: terms     ← 기존 URL 유지
├── data-deletion/index.html  # layout: legal, lang: ko, doc_key: deletion  ← 기존 URL 유지
├── support/index.html        # 신규. layout: legal(또는 support 변형), doc_key: support
├── location-terms/index.html # 조건부 (위치기반서비스 이용약관 의무가 확인될 때만)
├── en/
│   ├── privacy-policy/index.html
│   ├── terms/index.html
│   ├── data-deletion/index.html
│   └── support/index.html
├── 404.html                  # 선택. 공유 셸을 쓰는 간단한 안내
├── favicon/                  # 변경 없음
└── CNAME                     # 변경 없음
```

### Structure Rationale

- **`_data/`가 사실값의 유일한 출처:** 푸터(전 페이지), 처리방침의 보호책임자·연락처, 삭제 안내의 웹 요청 경로, 지원 페이지의 이메일이 모두 같은 지원 이메일을 씁니다. 한 곳만 바꾸면 전부 바뀌어야 드리프트가 없습니다. `_`로 시작하는 폴더는 사이트에 그대로 공개되지 않습니다(GitHub Docs: `_`·`.`·`#`로 시작하는 파일은 Jekyll이 건너뜀 — LOW, 공식 1차 출처 단일 확인).
- **레이아웃 이름을 `default`·`page`·`home`으로 짓지 않음:** GitHub Pages는 `jekyll-default-layout`을 끌 수 없게 켜 둡니다. 이 플러그인은 레이아웃이 없는 Markdown 파일에 `home`→`page`→`default` 순으로 레이아웃을 자동 적용합니다(HTML은 `html_pages: true`일 때만 — LOW, GitHub Docs + README 두 출처). 저장소의 Markdown 문서는 `exclude`로 빠져 있지만, 실수로 하나가 빠져나가면 사이트 셸을 두른 페이지로 공개됩니다. `base`·`legal`로 이름 지으면 이 경로가 아예 없습니다.
- **디렉터리 + `index.html` 규칙 유지:** 기존 URL `/privacy-policy/` 등은 이 규칙에서 나옵니다. 새 페이지도 같은 규칙(`support/index.html`)을 쓰고, 전역 `permalink` 설정이나 페이지별 `permalink`로 경로를 바꾸지 않습니다.
- **영문판은 `/en/` 접두사:** 한국어 URL은 그대로 두고 영어를 하위 경로로 병렬 배치합니다. `/privacy-policy/en/`나 `?lang=en`보다 경로 규칙이 단순하고, 다음 마일스톤에서 영문 랜딩(`/en/`)을 더해도 규칙이 깨지지 않습니다.
- **법적 본문은 HTML로 유지 (Markdown 아님):** 지금 규칙은 「마크다운 = 저장소 문서 = `exclude`」입니다. 법적 본문을 `.md`로 쓰면 이 규칙과 충돌하고, 처리 위탁 표처럼 구조가 있는 내용은 kramdown 표기보다 HTML이 통제하기 쉽습니다.

### 공통 블록 방식별 차이 (Stack 연구가 고른 쪽을 따름)

| 항목 | Jekyll layouts/includes/data | plain HTML + 동기화·검사 스크립트 |
|------|------------------------------|----------------------------------|
| 사실값 위치 | `_data/company.yml` | `shared/` 조각(예: `shared/footer.ko.html`)이 원본, 스크립트가 각 페이지의 표시 구간(`<!-- rp:shared:footer -->` … `<!-- /rp:shared:footer -->`)에 찍어 넣고 결과를 커밋 |
| 푸시 전 미리보기 | 로컬 Jekyll(`github-pages` gem 또는 Docker) 필요. `python3 -m http.server`로는 include가 렌더되지 않음 | 지금처럼 `python3 -m http.server` |
| 푸시 전 검증 | 로컬 빌드 성공 + `_site/` 산출물 확인. 리팩터 단계는 기존 HTML과 산출물 diff | `scripts/sync-shared --check`가 모든 페이지의 공유 구간이 원본과 같은지 확인 (pre-commit 권장) |
| 실수로 공개되는 것 | `Gemfile`·`Gemfile.lock`·`vendor/`·`scripts/` 등은 `exclude`에 직접 적어야 함(이 저장소의 `_config.yml` 주석대로 `exclude`를 적으면 기본값에 기대지 않음). Markdown 파일은 페이지로 변환되어 공개 | `shared/`·`scripts/`가 `exclude`에 없으면 그대로 공개됨 (Jekyll 통과는 계속되므로) |
| `.`으로 시작하는 폴더 (`.well-known/`) | `include:`에 적지 않으면 건너뜀 | 동일 (Jekyll 통과) |
| 빌드 실패 시 | Liquid·YAML 오류는 배포를 막음. 이전 배포가 남는지는 확인하지 못함 → 안전망으로 가정하지 말 것 | 빌드 실패 가능성은 낮지만, 검사를 건너뛰면 어긋난 HTML이 그대로 배포됨 |
| 페이지 수 증가 비용 | 새 파일은 front matter + 본문만 | 새 파일마다 표시 구간을 넣고 스크립트 대상에 추가 |

**권고:** Jekyll. 페이지가 4개에서 약 10개(KO 5~6 + EN 4 + 404)로 늘고, 사업자 정보가 전 페이지 푸터에 들어가므로 복사 방식의 드리프트 위험이 이번 마일스톤에서 가장 커집니다. GitHub Pages가 이미 Jekyll을 거치므로 배포 방식(`main` 푸시 = 배포)이 바뀌지 않습니다. 대가는 로컬 미리보기에 Ruby/Docker가 필요하다는 점입니다. 이 결정은 Stack 연구 소관이므로, 아래 빌드 순서는 어느 쪽이든 그대로 쓸 수 있게 짰습니다.

## Architectural Patterns

### Pattern 1: 사실값 슬롯 (Fact Slot, render-if-present)

**What:** 사용자가 줄 값(대표자, 사업자등록번호, 주소, 지원 이메일, 보호책임자)은 데이터 파일 한 곳에만 두고, 화면에서는 **값이 있을 때만** 해당 행을 그립니다. 값이 없으면 빈칸·"TBD"·가짜 번호를 그리지 않습니다.
**When to use:** 사실값이 늦게 도착하는 모든 곳 (푸터, 처리방침 보호책임자, 지원 페이지 연락처, 삭제 안내의 웹 요청 경로).
**Trade-offs:** 구조 작업과 값 수집을 분리해 각자 배포할 수 있습니다. 대신 "값이 다 들어왔는가"를 사람이 확인해야 합니다. 콘솔 제출 체크리스트에 "필수 슬롯이 모두 채워졌는지"를 넣습니다.

**Example (실행해 보지 않은 스케치):** Liquid에서는 `nil`·`false`만 거짓이고 빈 문자열 `""`은 참입니다. 그래서 `{% if c.biz_no %}`로 쓰면 `biz_no: ""`일 때 빈 행이 그려집니다. `!= blank`로 비교하거나, 모르는 값은 키를 null로 둡니다.
```liquid
{%- comment -%} _includes/footer.html — 값이 있는 행만 그린다 {%- endcomment -%}
{%- assign c = site.data.company -%}
<div class="rp-foot-legal">
  {%- if c.biz_name_ko != blank and c.ceo_ko != blank %}<p>상호 {{ c.biz_name_ko }} · 대표 {{ c.ceo_ko }}</p>{% endif -%}
  {%- if c.biz_no != blank %}<p>사업자등록번호 {{ c.biz_no }}</p>{% endif -%}
  {%- if c.address_ko != blank %}<p>{{ c.address_ko }}</p>{% endif -%}
  {%- if c.support_email != blank %}<p>문의 <a href="mailto:{{ c.support_email }}">{{ c.support_email }}</a></p>{% endif -%}
  <p>© 슬림펌킨 · 경로 데이터 © OpenStreetMap contributors</p>
</div>
```

### Pattern 2: 이메일 게이트 (Email Gate)

**What:** 지원 이메일은 **사용자가 메일 라우팅으로 실제 수신을 확인한 뒤에만** `company.yml`에 넣습니다. 이 값 하나가 네 곳(푸터, `/support/` 연락처, `/data-deletion/`의 웹 삭제 요청 경로, 처리방침 보호책임자 연락처)을 동시에 엽니다.
**When to use:** 이메일 공개 시점. 콘솔에 Support URL·삭제 URL을 등록하는 것도 이 게이트 뒤입니다.
**본문 문장 규칙:** render-if-present는 푸터 행뿐 아니라 본문 문장에도 적용해야 합니다. "아래 이메일로 삭제를 요청할 수 있습니다: ___"처럼 이메일을 참조하는 문장은 게이트가 닫힌 동안 구멍 난 채 렌더됩니다. 둘 중 하나를 지킵니다. (a) 이메일을 참조하는 **조항·문단 전체**를 `{% if site.data.company.support_email != blank %}`로 감쌉니다. (b) 그 페이지의 커밋을 게이트가 열릴 때까지 보류합니다. 처리방침의 보호책임자 연락처처럼 법적으로 빠지면 안 되는 조항은 (b)를 권장합니다. 조항이 통째로 빠진 처리방침이 라이브에 오르는 것도 피해야 하기 때문입니다.
**Trade-offs:** 메일이 안 오는 주소가 심사자에게 노출되는 일을 막습니다. `/support/`와 삭제 안내의 웹 경로는 게이트가 열리기 전까지 "구조만 배포된" 상태이므로 콘솔에 등록하지 않습니다.

### Pattern 3: 문서 키로 언어판 짝짓기 (Translation Pairing by doc_key)

**What:** 각 문서 페이지는 front matter에 `lang`과 `doc_key`를 가집니다. 언어 전환 링크는 같은 `doc_key`의 다른 `lang` 페이지를 찾아 **있을 때만** 그립니다. 영문판은 `source_updated`(번역한 한국어판의 최종 업데이트 날짜)를 가지고, 한국어판 날짜가 더 새로우면 "번역이 뒤처짐"을 검사로 잡을 수 있습니다. 영문판 본문 머리에는 "한국어판과 다를 경우 한국어판이 우선합니다" 문구를 레이아웃이 자동으로 넣습니다.
**When to use:** 영문판 추가 단계. 짝이 없는 동안에도 링크가 깨지지 않으므로 영문판을 한 페이지씩 배포할 수 있습니다.
**Trade-offs:** 플러그인 없이(GitHub Pages는 jekyll-polyglot 같은 i18n 플러그인을 지원 목록에 두지 않음 — 미확인, 쓰지 않는 쪽이 안전) 동작합니다. 페이지 수가 적어 `site.pages` 순회 비용은 무시할 만합니다.

**Example (실행해 보지 않은 스케치):** 랜딩처럼 `doc_key`가 없는 페이지에서는 아무것도 하지 않도록 먼저 막습니다.
```liquid
{%- comment -%} _includes/lang-switch.html — 짝 문서가 있을 때만 링크 {%- endcomment -%}
{%- if page.doc_key -%}
{%- assign alt = site.pages | where: "doc_key", page.doc_key | where_exp: "p", "p.lang != page.lang" | first -%}
{%- if alt -%}
  <a class="rp-lang" href="{{ alt.url }}" hreflang="{{ alt.lang }}" lang="{{ alt.lang }}">
    {%- if alt.lang == "en" -%}English{%- else -%}한국어{%- endif -%}
  </a>
{%- endif -%}
{%- endif -%}
```

### Pattern 4: 출력 보존 리팩터 (Output-Preserving Refactor)

**What:** 공통 블록을 include로 옮기는 단계는 **사이트 산출물이 바뀌지 않아야** 합니다. 로컬 빌드 산출물(`_site/terms/index.html` 등)을 현재 커밋의 원본 HTML과 공백을 정규화해 diff하고, 차이가 없을 때만 푸시합니다.
**When to use:** 공유 셸 도입 단계, 랜딩 전환 단계.
**Trade-offs:** 동작·시각 변경과 구조 변경이 같은 커밋에 섞이지 않아, 회귀가 생기면 원인이 바로 좁혀집니다.

### Pattern 5: 시맨틱 본문 + 정적 CSS (Semantic Body)

**What:** Tailwind 유틸리티 클래스를 걷어 내면서 본문 마크업 규칙을 "클래스 없는 `h2`·`p`·`ul`·`table`을 `<article class="rp-doc">` 안에" 하나로 고정합니다. 스타일은 `legal.css`의 `.rp-doc h2 { … }` 같은 하위 선택자가 맡습니다. 토큰(`ink #2B2B2B`, `accent #7C580D`, `muted #4A463F`, `muted-2 #57534C`, `line #E4E0D6`)은 CSS 사용자 정의 속성으로 한 번만 정의합니다.
**When to use:** Tailwind 제거 단계에서 규칙을 정하고, 이후 본문 재작성·영문판·지원 페이지는 모두 이 규칙으로만 씁니다.
**Trade-offs:** 본문 작성자가 스타일을 신경 쓰지 않아도 되고, 영문판은 한국어판과 같은 마크업 골격을 그대로 따라갑니다. 문서마다 특수한 표현(예: 처리 위탁 표)은 `.rp-doc table` 하나로 해결해야 하므로 처음에 표·목록·주석 스타일을 함께 정의해 둡니다.

## Data Flow

### 사실값 흐름 (단방향)

```
사용자 제공 값 ──► _data/company.yml ──┬─► footer (전 페이지, KO/EN)
(대표자·사업자번호·주소·                 ├─► /support/, /en/support/ 연락처
 지원 이메일·보호책임자·                 ├─► /data-deletion/, /en/data-deletion/ 웹 삭제 요청 경로
 영문 서비스명)                         ├─► /privacy-policy/ 보호책임자·연락처 조항 (+ EN)
                                       └─► /terms/ 사업자 표시 조항 (+ EN)

문서 수정 ──► _data/legal.yml (문서 키 × 언어 날짜) ──► legal 레이아웃의 "최종 업데이트"
                                                  └─► 영문판 source_updated 비교 (번역 뒤처짐 검사)

외부 설정(사용자) ──► DNS: 메일 라우팅 레코드 ──► 수신 확인 ──► (이메일 게이트 개방) ──► company.yml에 이메일 기입
                  └─► DNS TXT 또는 루트 HTML 파일 ──► Search Console 소유권 확인
```

**규칙:** 본문·푸터·지원 페이지 어디에서도 회사 사실값을 문자열로 다시 쓰지 않습니다. 본문 문장 안에서도 `{{ site.data.company.support_email }}`처럼 참조합니다. plain HTML 방식이면 같은 규칙을 "원본 조각 한 벌 + 동기화 스크립트 + `--check`"로 지킵니다.

### 사용자(심사자) 흐름

1. **Google OAuth 심사자:** 동의 화면의 홈페이지 링크 → `/` (앱 설명이 있는 랜딩) → 푸터의 `/privacy-policy/` → 상단 언어 전환으로 `/en/privacy-policy/`.
   - Google 요건: 홈페이지의 처리방침 링크와 동의 화면의 처리방침 링크가 같아야 함 (LOW, 공식 1차 출처 단일 확인). 홈페이지 푸터는 한국어 URL을 가리키므로 **동의 화면에도 한국어 URL `https://runningpencil.com/privacy-policy/`를 등록**하고, 영어 독자는 문서 상단의 보이는 언어 전환 링크로 이동시킵니다.
2. **Google Play 심사자:** 스토어 등록정보의 계정 삭제 URL → `/data-deletion/` → 앱 재설치 없이 지원 이메일로 삭제 요청 (이메일 게이트 이후).
3. **App Store 심사자:** Support URL → `/support/` → 맨 위의 앱 이름, FAQ, 연락 수단.
4. **Facebook 등:** 데이터 삭제 안내 URL → `/data-deletion/` (또는 `/en/data-deletion/`, 아래 콘솔 표 참고).

### Key Data Flows

1. **사실값 주입:** `company.yml` 한 곳 → 모든 페이지의 슬롯. 빈 값은 렌더되지 않음.
2. **날짜:** `legal.yml` → 문서 머리의 날짜. 본문을 고치는 커밋에서 같은 문서 키의 날짜를 함께 고침 (지금은 세 파일에 "2026년 10월 31일"이 하드코딩되어 있어 갱신을 잊기 쉬움 — 저장소 확인).
3. **언어 짝:** 페이지 front matter(`lang`, `doc_key`) → 언어 전환 링크. 짝이 없으면 링크 없음.

## URL Map

### 이번 마일스톤 후 URL

| URL | 상태 | 언어 | 문서 키 | 비고 |
|-----|------|------|---------|------|
| `/` | 기존 유지 | ko | — | 랜딩. 푸터에서 `/privacy-policy/`로 링크 유지 (Google 요건) |
| `/privacy-policy/` | **기존 유지 (콘솔 등록 가능성)** | ko | privacy | 본문 재작성, URL 불변 |
| `/terms/` | **기존 유지 (콘솔 등록 가능성)** | ko | terms | 본문 재작성, URL 불변 |
| `/data-deletion/` | **기존 유지 (콘솔 등록 가능성)** | ko | deletion | 웹 삭제 요청 경로 추가, URL 불변 |
| `/support/` | 신규 | ko | support | 앱 이름 맨 위, FAQ, 지원 이메일 |
| `/location-terms/` | 조건부 신규 | ko | location | 위치기반서비스 이용약관 의무가 확인될 때만. 영문판은 필요성 확인 후 |
| `/en/privacy-policy/` | 신규 | en | privacy | |
| `/en/terms/` | 신규 | en | terms | |
| `/en/data-deletion/` | 신규 | en | deletion | |
| `/en/support/` | 신규 | en | support | |
| `/en/` | **열린 질문** | en | — | 범위 목록에 없음. 영문 앱 설명 페이지가 필요한지는 요구사항 단계에서 결정 (아래 Gaps) |
| `/404.html` | 선택 | ko(+en 안내 한 줄) | — | 공유 셸 사용 |

**URL 안정성 규칙**
- 기존 세 URL에는 리디렉션을 걸지 않습니다. `Accept-Language`나 JS 기반 자동 언어 리디렉션도 넣지 않습니다(정적 호스팅이라 서버 리디렉션도 없고, 심사 봇이 다른 문서를 받게 될 수 있음).
- 모든 콘솔 URL은 `https://runningpencil.com/…/` (apex, 끝 슬래시 포함) 형식으로 통일합니다.
- 리팩터 이후에도 `/privacy-policy/`, `/terms/`, `/data-deletion/`이 **같은 문서**(같은 `<title>`, 같은 종류의 본문)를 돌려주는지 매 단계 배포 후 확인합니다.

### 콘솔 필드 범주 → 사이트 URL

필드 **이름**은 콘솔마다 다르고 대부분 이번 조사에서 확인하지 못했으므로, 범주 단위로 매핑합니다. "출처" 열이 비어 있는 행은 FEATURES/PITFALLS 연구나 단계별 조사에서 공식 문서로 다시 확인해야 합니다.

| 필드 범주 | 사이트 URL | 해당 콘솔 | 출처 |
|-----------|-----------|-----------|------|
| 홈페이지 / 앱 웹사이트 | `https://runningpencil.com/` | Google OAuth 브랜딩, Google Play(웹사이트), App Store(Marketing URL, 선택), 카카오·네이버 사이트 도메인/서비스 URL | Google OAuth: 공식 문서(LOW, 단일 확인). 나머지 미확인 |
| 개인정보처리방침 URL | `https://runningpencil.com/privacy-policy/` (KO, 홈페이지 링크와 동일해야 함) | Google OAuth, Google Play, App Store, Facebook, LINE, 카카오·네이버(요구 시) | Google OAuth·Play: 공식 문서/PROJECT.md 기록. 나머지 미확인 |
| 이용약관 URL | `https://runningpencil.com/terms/` | Google OAuth(선택 필드로 알려짐), Facebook, LINE, 카카오(요구 시) | 미확인 — Google 공식 페이지에도 약관 요건 언급 없음 |
| 데이터 삭제 안내 URL | `https://runningpencil.com/data-deletion/` | Google Play(계정 삭제 URL), Facebook(Data Deletion Instructions URL) | Play: PROJECT.md 기록(공식). Facebook: 미확인 |
| 지원 URL | `https://runningpencil.com/support/` | App Store(Support URL) | 2차 출처만 (PROJECT.md) |
| 승인된 도메인 / 앱 도메인 | `runningpencil.com` | Google OAuth Authorized domains, Facebook App Domains, 카카오 Web 플랫폼 사이트 도메인 | Google OAuth: 공식(Search Console 소유권 확인 필요). 나머지 미확인 |

**언어 선택 원칙:** 기본은 한국어 URL을 등록하고 영어 독자는 상단 언어 전환으로 보냅니다. 단, 영어 전용 심사(예: Facebook·LINE)에서 영문 URL을 직접 요구하거나 등록 칸이 언어별로 따로 있으면 `/en/…`을 등록합니다. 이 판단은 콘솔별 공식 문서를 확인한 뒤 제출 체크리스트에서 확정합니다. Google OAuth는 "홈페이지 링크 = 동의 화면 링크" 요건 때문에 한국어 URL로 고정합니다.

## Build Order (단계마다 독립 배포 가능)

`main` 푸시 = 배포이므로, 각 단계는 그 자체로 라이브에 올라가도 되는 상태에서 끝나야 합니다. 모든 단계의 공통 푸시 전 확인: 로컬 미리보기 → 기존 세 URL이 같은 문서를 렌더 → 내부 링크 확인. 배포 후 `https://runningpencil.com/privacy-policy/` 등 세 URL이 200과 같은 제목을 돌려주는지 확인합니다.

### 0단계 — 외부 준비 (사용자, 사이트 작업과 병렬)

사이트 커밋 없이 진행되며, 아래 단계들의 **값**만 막습니다(구조는 막지 않음).

| 항목 | 막는 것 | 비고 |
|------|---------|------|
| 사업자 사실값(대표자·사업자번호·주소, 영문 표기 포함) | 3단계의 슬롯 채우기, 5단계 약관·처리방침 | 추측해서 채우지 않음 |
| 지원 이메일 주소 결정 + 메일 라우팅 + **실제 수신 확인** | 이메일 게이트 → 3·4·5단계의 연락처 | 공급자 미정. Cloudflare Email Routing을 고르면 Cloudflare DNS 사용이 전제(LOW, 공식 1차 출처). MX·SPF(·DKIM) TXT가 apex에 추가되며, 기존 Pages A/AAAA 레코드와의 공존은 이번 조사로 확인하지 못함 → 설정 후 사이트 접속을 다시 확인 |
| Search Console 소유권 확인 | Google OAuth 브랜드 검증 | 방법 둘 중 하나. (a) DNS TXT(Domain 속성) — 저장소에 아무것도 남지 않음, 메일 라우팅과 같은 DNS 작업이라 권장. (b) 루트 HTML 파일(URL-prefix 속성) — `googleXXXX.html`을 front matter 없이 루트에 커밋, **영구 보존 필요**(지우면 확인이 풀림). Google 문서는 속성 유형을 지정하지 않음. 확인하는 계정은 GCP 프로젝트의 owner/editor여야 함(LOW, 공식 1차 출처) |
| 영문 서비스명 확정 | 7단계 영문판 | 스토어 등록명·동의 화면 표기와 일치해야 함 |
| 위치기반서비스 이용약관 의무 확인 | 6단계 | 법적 확인 결과가 나올 때까지 6단계는 보류 |

### 1단계 — 공유 셸 도입 (출력 보존 리팩터)

- Jekyll: `_layouts/base.html`, `_layouts/legal.html`, `_includes/head-common.html`·`common.css`·`header.html`·`footer.html` 생성. 법적 페이지 3종을 front matter + 본문으로 바꿈. **Tailwind `<script>`와 config는 이 단계에서 legal 레이아웃의 `<head>` 한 곳으로 옮기기만 함**(제거는 2단계).
- 랜딩 `index.html`: front matter(`layout: null`)를 붙이고 head 링크·「공통」 CSS·헤더·푸터만 include로 교체. pre-paint 스크립트, 「랜딩 전용」 CSS, 본문, 동작 스크립트는 그대로. 현재 HTML에 `{{`·`{%`가 없어 Liquid 충돌은 없음(grep 확인). 이후 JS에 이런 문자열을 넣으면 `{% raw %}`로 감싸야 함.
- `_config.yml`: `Gemfile`, `Gemfile.lock`, `vendor/`(로컬 Jekyll용), 기타 새 비공개 폴더를 `exclude`에 추가.
- `CLAUDE.md`의 「네 파일을 모두 똑같이 수정」 규칙을 이 단계에서 바로 고침 (구조 설명이 실제와 어긋난 채 배포되지 않도록).
- **푸시 전 검증:** 로컬 빌드 산출물과 현재 HTML 4개를 공백 정규화 diff → 차이 0 (헤더 링크 접두사 차이 포함 동일해야 함).
- **랜딩은 별도 커밋으로 분리 가능:** 법적 페이지 3종 → 랜딩 순서. 랜딩에는 스크립트-마크업 id 계약이 있으므로 diff 0 확인 후 콘솔 오류도 확인.

### 2단계 — Tailwind Play CDN 제거, 본문 마크업 규칙 고정

- `legal.css`(정적) 작성: `.rp-doc` 아래 시맨틱 요소 스타일 + 토큰 CSS 변수 + 표·목록 스타일까지 처음에 정의.
- 기존 3개 본문에서 유틸리티 클래스를 걷어 내고 시맨틱 마크업으로 **기계적으로** 변환 (문장은 바꾸지 않음). legal 레이아웃에서 Tailwind `<script>`·config 삭제.
- **마크업은 여기서 한 번만 바꿈:** 이후 5단계(본문 재작성)와 7단계(영문판)는 이 규칙 안에서 텍스트만 씁니다. 만약 0단계 사실값이 이미 다 모여 본문 재작성을 곧바로 할 수 있다면, 2단계를 문서별로 5단계와 합쳐 한 커밋에서 처리해도 됩니다.
- **푸시 전 검증:** 세 페이지를 변경 전·후 스크린샷으로 비교(데스크톱/모바일 폭). 네트워크 탭에 `cdn.tailwindcss.com` 요청이 없어야 함.

### 3단계 — 사실값 슬롯과 푸터 사업자 정보

- `company.yml`(빈 값 허용), `legal.yml`(현재 날짜 2026-10-31 이관), 푸터의 render-if-present 행.
- 값이 하나도 없으면 푸터 산출물은 2단계와 같음 → 값이 없어도 배포 가능. 값이 도착하면 데이터 파일만 고치는 작은 커밋.
- 지원 이메일은 **이메일 게이트** 이후에만 기입.

### 4단계 — `/support/` (KO)

- legal 레이아웃(또는 같은 셸의 support 변형) 위에 앱 이름 → FAQ → 연락처(이메일 슬롯) 순서.
- 헤더/푸터 내비에 지원 링크 추가 (공유 include 한 곳 수정 → 전 페이지 반영).
- 이메일 게이트 전에 배포한다면 연락처 구간 전체를 조건부로 감쌉니다(빈 "문의: " 문장 금지). **App Store Support URL 등록은 게이트 이후**.

### 5단계 — 한국어 법적 본문 재작성 (문서별 독립 커밋)

- 순서 권장: 데이터 삭제 안내(웹 삭제 요청 경로 = 이메일 게이트 의존, Play 정책 직결) → 개인정보처리방침(보호책임자·연락처·처리 위탁·국외 이전 — 사실값 의존) → 이용약관(사업자 정보 의존).
- 데이터 삭제 안내와 처리방침은 이메일·보호책임자를 본문에서 참조하므로 **이메일 게이트와 해당 사실값이 들어온 뒤에 커밋**합니다(Email Gate의 본문 문장 규칙 (b)). 이용약관은 사업자 정보가 들어온 뒤에 커밋합니다.
- 각 커밋에서 `legal.yml`의 해당 문서 날짜를 함께 갱신. "임시 게시본" 표시는 해당 문서가 재작성될 때 제거.
- `noindex` 유지 여부는 콘텐츠 결정(심사에는 영향 없음으로 보임 — 미확인). 어느 경우든 `robots.txt`로 크롤러를 막지는 않음.

### 6단계 — 위치기반서비스 이용약관 (조건부)

- 0단계 법적 확인에서 필요하다고 나온 경우에만. `/location-terms/` 추가, 푸터 약관 링크와 이용약관 본문의 참조 추가. 필요 없으면 단계를 건너뜀(다른 단계에 영향 없음).

### 7단계 — 영문판

- 먼저 lang-switch include와 영문용 UI 문구·푸터(영문 사업자 표기)를 넣음 → 짝이 없으면 아무것도 안 보이므로 단독 배포 가능.
- 이어서 `/en/…` 페이지를 한 장씩: 데이터 삭제 안내 → 처리방침 → 약관 → 지원. 각 영문 페이지는 `source_updated`로 번역 기준 한국어판 날짜를 기록.
- 한국어판이 확정된 뒤에 번역해야 두 번 번역하지 않음. 영문 서비스명이 0단계에서 확정되어야 시작 가능.
- `<html lang="en">`. `hreflang` 대체 링크는 법적 페이지가 `noindex`인 동안에는 효과가 작음 — 심사자에게 필요한 것은 **보이는** 언어 전환 링크.

### 8단계 — 제출 체크리스트·문서 정리

- 위 「콘솔 필드 범주 → 사이트 URL」 표를 콘솔별 공식 필드명으로 확정한 제출 체크리스트 작성 (필수 슬롯이 다 채워졌는지, 이메일 게이트가 열렸는지 포함).
- `CLAUDE.md` 최종 갱신: 연락처 공개 방침, 사업자 정보, 영문판 규칙(`/en/`, `doc_key`, "한국어판 우선"), 공통 블록 방식, 로컬 미리보기 방법.

### 의존 관계 요약

```
0(외부: 사실값·메일·Search Console·영문명·위치법 확인) ──값──┐
1 공유 셸 ─► 2 정적 CSS·마크업 규칙 ─► 3 사실값 슬롯 ─► 4 /support/ ─► 5 KO 본문 ─► 7 영문판 ─► 8 체크리스트
                                                          └─► 6 위치약관(조건부)
이메일 게이트(0의 수신 확인) ─► 3의 이메일 값 ─► 4·5의 연락처 ─► 콘솔 등록
Search Console(0) ─► Google OAuth 브랜드 검증 (사이트 단계와 독립)
```

## Scaling Considerations

사용자 수가 아니라 **페이지 수**가 이 사이트의 규모입니다.

| 규모 | Architecture Adjustments |
|------|--------------------------|
| 4페이지 (현재) | 복사 + 사람 확인으로 버팀. 이미 「네 파일 동시 수정」 규칙이 필요한 상태 |
| ~10~12페이지 (이번 마일스톤 후: KO 5~6, EN 4, 404) | 공유 셸 + 사실값 단일 출처가 필수. 푸터 사업자 정보 한 줄 수정이 10곳 수정이 되면 안 됨 |
| 다음 마일스톤 (랜딩에 실데이터 구간 추가, 영문 랜딩 가능성) | 랜딩 구간을 include로 쪼갤 수 있게 base 레이아웃을 범용 셸로 유지. 실데이터 공급 방식(브라우저 fetch vs 빌드 때 가져오기)은 그 마일스톤에서 결정 |

### Scaling Priorities

1. **먼저 깨지는 것:** 공통 블록 드리프트 — 영문판·지원 페이지가 더해지는 순간. 1단계를 먼저 하는 이유.
2. **다음으로 깨지는 것:** 번역 뒤처짐 — 한국어판만 고치고 영문판 날짜·내용이 남는 문제. `source_updated` 비교로 잡음.

## Anti-Patterns

### Anti-Pattern 1: 기존 URL 이동 또는 리디렉션

**What people do:** 영문판을 넣으면서 `/privacy-policy/`를 `/ko/privacy-policy/`로 옮기거나 언어 감지 리디렉션을 넣음.
**Why it's wrong:** 기존 URL이 dev 콘솔에 등록되어 있을 수 있고, Google은 홈페이지 링크와 동의 화면 링크의 일치를 요구함. 정적 호스팅은 서버 301을 못 하므로 리디렉션은 meta refresh/JS뿐이고, 심사 봇이 다른 문서를 받을 수 있음.
**Do this instead:** 한국어는 지금 URL 그대로, 영어만 `/en/` 아래에 추가.

### Anti-Pattern 2: 자리표시 사실값 공개

**What people do:** "대표자: 추후 기재", "사업자등록번호: 000-00-00000", 가짜 이메일을 넣고 배포.
**Why it's wrong:** 커밋 = 배포라 바로 라이브에 노출되고, 카카오 비즈앱처럼 사업자-서비스 관계를 보는 심사에서 오히려 감점 요인이 됨.
**Do this instead:** 사실값 슬롯(render-if-present). 값이 없으면 그 행이 없음.

### Anti-Pattern 3: 수신 확인 전 이메일 공개

**What people do:** 메일 라우팅을 설정만 하고 주소를 사이트·콘솔에 등록.
**Why it's wrong:** 삭제 요청·심사자 문의가 유실되면 Play 계정 삭제 정책과 App Store 연락 수단 요건을 실제로는 못 지킨 것.
**Do this instead:** 이메일 게이트 — 외부 주소에서 보낸 테스트 메일이 업무 메일에 도착한 뒤에 `company.yml`에 기입.

### Anti-Pattern 4: JS로 푸터·이메일 주입 또는 난독화

**What people do:** 스팸을 피하려고 이메일을 JS로 조립하거나, 공통 푸터를 `fetch()`로 불러와 끼움.
**Why it's wrong:** 심사 봇·JS 미실행 환경에서 연락처·사업자 정보가 안 보임. 법적 페이지가 JS에 의존하게 됨.
**Do this instead:** 빌드 때(또는 동기화 스크립트로) 정적 HTML에 박아 넣음. 평문 `mailto:` 링크.

### Anti-Pattern 5: 사실값을 본문에 문자열로 재기입

**What people do:** 처리방침의 보호책임자 조항에 이메일·주소를 직접 타이핑.
**Why it's wrong:** 값이 바뀌면 푸터만 바뀌고 본문은 옛 값이 남음. 영문판까지 생기면 4곳 이상이 어긋남.
**Do this instead:** 본문에서도 데이터 참조. plain HTML 방식이면 검사 스크립트가 사실값 문자열을 전 페이지에서 대조.

### Anti-Pattern 6: 레이아웃을 `default`/`page`로 명명, 전역 `permalink` 설정

**What people do:** Jekyll 관례대로 `_layouts/default.html`을 만들거나 `_config.yml`에 `permalink: pretty` 등을 넣음.
**Why it's wrong:** `jekyll-default-layout`(끌 수 없음)이 레이아웃 없는 Markdown에 자동 적용해 저장소 문서가 셸을 두른 페이지로 공개될 수 있음. 전역 permalink는 기존 URL을 바꿀 위험.
**Do this instead:** `base`·`legal` 이름, permalink 설정 없음, 디렉터리 + `index.html` 규칙.

### Anti-Pattern 7: 리팩터와 내용 변경을 한 커밋에

**What people do:** include 도입과 본문 재작성·Tailwind 제거를 한 번에 푸시.
**Why it's wrong:** 심사 대상 페이지가 깨졌을 때 원인을 못 좁히고, 되돌리면 정당한 변경까지 사라짐.
**Do this instead:** 1단계(출력 보존) → 2단계(시각 동일) → 이후 내용 단계.

## Integration Points

### External Services

| Service | Integration Pattern | Notes |
|---------|---------------------|-------|
| GitHub Pages (Jekyll 통과) | `main` 푸시 → 자동 빌드·배포 | 기본 플러그인 일부는 끌 수 없음(LOW, 공식 1차 출처). `.`으로 시작하는 폴더는 `include:`에 적어야 배포됨. 빌드 실패 시 이전 배포 유지 여부는 미확인 → 로컬 빌드로 대신 막음 |
| DNS (도메인 등록처 또는 Cloudflare) | 사용자가 직접 설정 | 기존 Pages 레코드(A/AAAA, GitHub 도메인 확인 TXT가 있다면 그것도)를 건드리지 않게 주의. 메일 라우팅 MX/SPF/DKIM, Search Console TXT가 추가됨 |
| 메일 포워더 (공급자 미정) | 도메인 주소 → 슬림펌킨 업무 메일 | Cloudflare Email Routing은 Cloudflare DNS 필요(LOW, 공식 1차 출처). 사이트 쪽 통합 지점은 `company.yml`의 이메일 한 줄뿐 |
| Google Search Console | DNS TXT(권장) 또는 루트 HTML 파일 | HTML 파일을 쓰면 front matter 없이 커밋하고 영구 보존. GCP owner/editor 계정으로 확인 |
| 소셜 로그인 6곳 + 스토어 2곳 콘솔 | 사이트 URL을 붙여 넣는 단방향 | 위 콘솔 표. 사이트는 URL 안정성과 내용 요건만 책임짐 |
| Pretendard (jsDelivr) | head-common의 `<link>` | 변경 없음. 한 곳(include)으로 모일 뿐 |

### Internal Boundaries

| Boundary | Communication | Notes |
|----------|---------------|-------|
| 사실값 ↔ 페이지 | 빌드 때 단방향 주입 | 페이지는 사실값을 읽기만 함 |
| 공유 셸 ↔ 랜딩 | include 매개변수(`anchor_prefix`) | 랜딩의 스크립트-마크업 id 계약은 셸 밖(랜딩 본문)에 있음 — 셸 변경이 계약을 건드리지 않게 |
| legal 레이아웃 ↔ 문서 본문 | `{{ content }}` + front matter(`title`, `lang`, `doc_key`) | 본문은 시맨틱 마크업만, 스타일·날짜·언어 전환은 레이아웃 책임 |
| KO 문서 ↔ EN 문서 | `doc_key` 짝, `source_updated` | 한국어판이 원본. 영문판에 "한국어판 우선" 문구 |

## 다음 마일스톤을 위해 잠그지 말 것 (Forward-Compatibility)

다음 마일스톤은 로그인 없는 공개 실데이터(스토어 뱃지, 평점, 인기 코스, 명예의 전당, 리뷰)를 더합니다. 설계는 하지 않고, 이번에 막지 말아야 할 것만 적습니다.

- **base 레이아웃은 범용 셸로:** 법적 페이지 전용 요소(모눈종이, 카드)는 `legal` 레이아웃에만. 랜딩이 나중에 구간을 include로 쪼갤 수 있게 base는 head/header/footer/`{{ content }}`만 가짐.
- **배포 방식을 바꾸지 않음:** 이번에 굳이 커스텀 GitHub Actions 빌드를 들이지 않음(Stack이 요구하지 않는 한). 실데이터를 빌드 때 가져와야 한다면 그때 Actions로 옮겨도 Jekyll 소스는 그대로 호환됨.
- **CSP·서비스 워커를 성급히 넣지 않음:** 넣는다면 나중의 데이터 fetch 출처(예: Firebase)를 막지 않게 범위를 기록해 둠.
- **`.well-known/` 자리 비워 두기:** Android App Links·iOS Universal Links 같은 파일이 나중에 필요할 수 있음. Jekyll에서는 `include:`에 적어야 배포됨 — 지금 만들 필요는 없고, 이 제약만 `CLAUDE.md`에 적어 둠.
- **"출시 예정" 문구를 공유 셸에 넣지 않음:** 티저 상태 문구는 랜딩 `#get`에만. 헤더·푸터에 들어가면 출시 때 전 페이지를 고쳐야 함.
- **`_data/` 이름 공간 분리:** 정적 회사 사실값(`company.yml`)과 나중의 실데이터를 같은 파일에 섞지 않음.
- **`/en/` 규칙 유지:** 나중에 영문 랜딩을 `/en/`에 둘 수 있게, `/en/` 아래를 법적 문서 전용으로 가정한 구조(예: `/en/`을 404로 고정하는 처리)를 만들지 않음.

## Gaps (이번 조사로 닫지 못한 것)

- **영문 홈페이지(`/en/`) 필요 여부:** Google OAuth는 홈페이지가 앱 기능을 설명해야 한다고 요구함(LOW, 공식 1차 출처). 한국어 랜딩으로 충분한지, 짧은 영문 앱 설명 페이지가 필요한지는 요구사항 단계 결정 사항.
- **카카오·네이버·LINE·Apple·Facebook·App Store 콘솔 필드명과 언어 요건:** 범주 매핑만 함. 공식 문서 확인 필요.
- **Search Console 속성 유형:** Google 문서가 Domain/URL-prefix를 지정하지 않음. 두 방법 다 가능하다고 보고 DNS TXT를 권장했지만 확인되지 않음.
- **메일 라우팅 레코드와 Pages 레코드 공존:** 원리상 MX/TXT와 A/AAAA는 다른 레코드 유형이라 충돌하지 않을 것으로 보이나, 이번에 출처로 확인하지 못함.
- **빌드 실패 시 동작:** GitHub Pages에서 Jekyll 빌드가 실패하면 이전 배포가 남는지 공식 출처를 찾지 못함. 로컬 빌드 확인을 필수로 둠.
- **위치기반서비스 이용약관 의무:** 6단계의 실행 여부를 결정함. 법적 확인 필요.

## Sources

- 저장소 직접 확인 (HIGH): `.planning/PROJECT.md`, `.planning/codebase/ARCHITECTURE.md`, `.planning/codebase/STRUCTURE.md`, `.planning/codebase/CONCERNS.md`, `_config.yml`, `terms/index.html`, `index.html`(Liquid 문법 부재 grep)
- [About GitHub Pages and Jekyll — GitHub Docs](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/about-github-pages-and-jekyll) — 끌 수 없는 기본 플러그인 목록, `_`·`.`·`#` 시작 파일 제외와 `include` 재정의 (seam: LOW, 공식 1차 출처)
- [benbalter/jekyll-default-layout README](https://github.com/benbalter/jekyll-default-layout) — Markdown에만 적용(`html_pages` 옵션), `home`→`page`→`default` 순서 (seam: LOW, 1차 출처)
- [Google Cloud: OAuth app branding/verification requirements](https://support.google.com/cloud/answer/13464321) — 홈페이지·처리방침 동일 도메인, 홈페이지 링크 = 동의 화면 링크, Search Console 소유권 확인(owner/editor) (seam: LOW, 공식 1차 출처)
- [Cloudflare Email Routing — Enable](https://developers.cloudflare.com/email-routing/get-started/enable-email-routing/) — Cloudflare DNS 필요, MX·SPF·DKIM 레코드 (seam: LOW, 공식 1차 출처)
- [Jekyll Docs — Front Matter](https://jekyllrb.com/docs/front-matter/), [Static Files](https://jekyllrb.com/docs/static-files/) — front matter가 있는 파일만 특수 처리, front matter 없는 파일 = static file (seam: LOW, 공식). 이 저장소의 현재 HTML이 front matter 없이 그대로 서빙된다는 점은 `CLAUDE.md`의 서술(「HTML은 그대로 복사됩니다」)에 근거함 — 라이브 페이지와 파일을 diff하지는 않음
- [GitHub Docs — About Jekyll build errors](https://docs.github.com/en/enterprise-server@3.16/pages/setting-up-a-github-pages-site-with-jekyll/about-jekyll-build-errors-for-github-pages-sites) — 빌드 실패 시 로컬 재현 권장. 이전 배포 유지 여부는 언급 없음 (LOW)

---
*Architecture research for: 빌드 없는 GitHub Pages 사이트의 심사 대응용 공식 웹사이트 확장 (러닝펜슬)*
*Researched: 2026-11-14*
