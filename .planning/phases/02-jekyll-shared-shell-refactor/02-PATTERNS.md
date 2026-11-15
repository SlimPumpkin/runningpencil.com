# Phase 2: Jekyll 공유 셸 도입 (Shared Shell Refactor) - Pattern Map

**Mapped:** 2026-11-15
**Files analyzed:** 20 (새로 만듦 10, 고침 10)
**Analogs found:** 16 / 20 (셸 스크립트 2개, Gemfile·lock은 저장소 안에 비슷한 파일이 없음 → RESEARCH.md Code Examples)

**행 번호 기준:** `git diff 1c4be1a -- '*.html'` 결과가 비어 있습니다. HTML 4개는 `1c4be1a` 이후 바뀌지 않았으므로 CONTEXT의 행 번호가 지금 HEAD에서도 맞습니다(2026-11-15 재확인). 파일 길이: `index.html` 653, `privacy-policy/index.html` 174, `terms/index.html` 200, `data-deletion/index.html` 151행.

이 단계는 「코드를 새로 짜는」 것이 아니라 「지금 있는 줄을 잘라 옮기는」 리팩터입니다. 그래서 아래의 analog는 대부분 **잘라 낼 원본 행 범위 그 자체**입니다. 옮길 때 들여쓰기를 바꾸지 않습니다.

## File Classification

| New/Modified File | Role | Data Flow | Closest Analog (원본) | Match Quality |
|---|---|---|---|---|
| `_includes/head-links.html` | include (partial) | transform (빌드 시 치환) | `index.html:18-25` = 법적 3종 `:13-20` | exact (그대로 잘라 옴) |
| `_includes/css/common.css` | include (CSS partial) | transform | `index.html:31-58` = 법적 3종 `:37-64` | exact |
| `_includes/header.html` | include (partial, 매개변수 1개) | transform | `terms/index.html:74-87` (+ `index.html:184-197` 링크 변형) | exact + 링크 4곳만 Liquid |
| `_includes/footer.html` | include (partial) | transform | `index.html:470-493` = `privacy-policy:148-171` = `terms:174-197` = `data-deletion:125-148` | exact |
| `_layouts/legal.html` | layout | transform | `terms/index.html:1-95` + `:169-200` | exact + front matter 값 7곳 |
| `privacy-policy/index.html` | page (content) | — | 자기 자신 `:96-142` 본문만 남김 | exact |
| `terms/index.html` | page (content) | — | 자기 자신 `:96-168` 본문만 남김 | exact |
| `data-deletion/index.html` | page (content) | — | 자기 자신 `:96-119` 본문만 남김 | exact |
| `index.html` | page (landing, include 4곳) | — | 자기 자신 | exact |
| `_config.yml` | config | — | 자기 자신 `:1-13` | exact (항목 추가) |
| `.gitignore` | config | — | 자기 자신 `:1-11` | exact (항목 추가) |
| `Gemfile` | config (Ruby deps) | — | 없음 | RESEARCH.md §Standard Stack 「Installation」 |
| `Gemfile.lock` | config (생성물) | — | 없음 | `bundle install` 생성물 |
| `scripts/check-site.sh` | utility (CLI 점검) | batch | 없음 (셸 analog 없음) | RESEARCH.md Code Examples (579행~) |
| `.githooks/pre-push` | utility (git hook) | event-driven | 없음 | RESEARCH.md Code Examples (684행~) |
| `CLAUDE.md` (루트) | doc | — | 자기 자신 (아래 행 목록) | 문장 교체 |
| `.claude/CLAUDE.md` | doc (방침 구간 손 편집 + 나머지 재생성) | — | 자기 자신 `:11` + 생성 구간 | 문장 교체 / 재생성 |
| `README.md` | doc | — | 자기 자신 `:6` | 문장 교체 |
| `.planning/codebase/{STACK,CONVENTIONS,ARCHITECTURE,STRUCTURE,TESTING,CONCERNS}.md` | doc (generate-claude-md 원본) | — | 자기 자신 (아래 행 목록) | 문장 교체 |
| (일회용, 커밋 안 함) 기준 비교 스크립트 | utility | batch | 없음 | RESEARCH.md Code Examples 「일회용 기준 비교」(711행~) — 스크래치에만 둠 |

## Pattern Assignments

### 공통 규칙: include 공백 (모든 include·레이아웃에 적용)

출처: RESEARCH.md Pattern 1 (322-343행, 스크래치에서 바이트 동일 확인)
1. include 태그는 **0열에 혼자** 둡니다: `{% include header.html %}`
2. include 파일에는 원본 줄을 **원래 들여쓰기째** 담습니다.
3. include 파일은 **끝 줄바꿈 없이** 저장합니다(있으면 빈 줄 1개 추가 — D-07은 흡수, `cmp`는 깨짐). Write 도구는 내용 끝에 줄바꿈을 붙이지 않으므로 마지막 줄 뒤에 `\n`을 넣지 않습니다. 확인: `tail -c1 file | od -c`.
4. `{%-`/`-%}`는 내용을 내보내지 않는 `if`/`endif`에만 씁니다. `{%- include`는 앞줄과 붙어 D-07에서도 차이가 납니다.
5. 레이아웃 본문 자리는 `{{ content | rstrip }}`.

---

### `_includes/head-links.html` (include, 8줄)

**Analog:** `index.html:18-25` (법적 3종 `:13-20`과 바이트 동일)
```html
    <link rel="preconnect" href="https://cdn.jsdelivr.net" crossorigin />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css" crossorigin />
    <link rel="icon" type="image/png" href="/favicon/favicon-96x96.png" sizes="96x96" />
    <link rel="icon" type="image/svg+xml" href="/favicon/favicon.svg" />
    <link rel="shortcut icon" href="/favicon/favicon.ico" />
    <link rel="apple-touch-icon" sizes="180x180" href="/favicon/apple-touch-icon.png" />
    <meta name="apple-mobile-web-app-title" content="러닝펜슬" />
    <link rel="manifest" href="/favicon/site.webmanifest" />
```
- 앞뒤 문맥이 다릅니다. 랜딩은 앞에 OG 메타(`:11-16`), 뒤에 pre-paint `<script>`(`:26-29`). 법적은 앞에 Tailwind `<script src>`(`:12`), 뒤에 `<script id="tailwind-config">`(`:21`). 그래서 `<head>` 전체를 include 하나로 합치지 않습니다(CONTEXT 제약).
- 절대 경로 `/favicon/...`를 `relative_url`로 바꾸지 않습니다.

---

### `_includes/css/common.css` (include, 28줄)

**Analog:** `index.html:31-58` = `terms/index.html:37-64` (privacy-policy·data-deletion도 `:37-64`)
- 첫 두 줄(머리 주석, 전환 커밋에서는 **그대로**, D-05):
```css
        /* ── 공통: 바탕 · 머리말 · 바닥글 ──
           네 페이지(index · privacy-policy · terms · data-deletion)가 이 묶음을 똑같이 복사해 쓴다. 고칠 때는 네 파일을 함께 고친다. */
```
- 마지막 줄: `        @media (max-width: 860px) { .rp-nav { display: none; } }` (`index.html:58`)
- 그 뒤 빈 줄 1개(`index.html:59` / 법적 `:65`)는 include에 넣지 **않고** 부르는 쪽에 둡니다. 다음 줄이 랜딩 `:60` `/* ── 랜딩 전용 ── */`, 법적 `:66` `/* ── 법적 페이지 전용 ── … */`입니다.
- 들여쓰기 8칸 유지. 부르는 쪽은 `    <style>` 다음 줄 0열에 `{% include css/common.css %}`.
- **D-06 별도 커밋:** 위 머리 주석 두 번째 줄만 「`_includes/css/common.css` 한 곳에서 고친다」 취지로 바꿉니다. 검증은 주석 제거 후 diff 0.
- 참고: `CONCERNS.md:14`는 「공통」을 `:31-59`(29줄, 빈 줄 포함)로 적고 있습니다. include 범위는 빈 줄을 뺀 `:31-58`입니다.

---

### `_includes/header.html` (include, 14줄, 매개변수 `home`)

**Analog:** `terms/index.html:74-87` (법적 변형), `index.html:184-197` (랜딩 변형)

네 사본의 차이는 정확히 4줄입니다.

| 줄 | 랜딩 (`index.html`) | 법적 3종 (`:77`, `:82-84`) |
|---|---|---|
| brand | `:187` `href="#top"` | `:77` `href="/"` |
| nav 1 | `:192` `href="#story"` | `:82` `href="/#story"` |
| nav 2 | `:193` `href="#demo"` | `:83` `href="/#demo"` |
| nav 3 | `:194` `href="#get"` | `:84` `href="/#get"` |

나머지 10줄(`<!-- Header -->`, `<header class="rp-head">`, 로고 `<svg>` 한 줄, `rp-brand-name`, `<nav class="rp-nav" aria-label="주요 메뉴">`, 닫는 태그들)은 같습니다. 로고 `<svg>` 줄(`terms:78`)은 `fill="#F2B134"` 판입니다(푸터 로고는 `#FFF3C4` — 섞지 않음).

**변형 방식 (RESEARCH.md Pattern 4, 권장):**
```liquid
            <a class="rp-brand" href="{% if include.home %}#top{% else %}/{% endif %}" aria-label="러닝펜슬 홈">
…
                <a href="{% unless include.home %}/{% endunless %}#story">즐기는 법</a>
                <a href="{% unless include.home %}/{% endunless %}#demo">달려 보기</a>
                <a href="{% unless include.home %}/{% endunless %}#get">출시 안내</a>
```
- 랜딩: `{% include header.html home=true %}`, 레이아웃: `{% include header.html %}`.
- `page.url` 판정 대신 매개변수를 쓰는 이유: Phase 9 `/en/` 랜딩도 호출부 한 줄로 끝남.

---

### `_includes/footer.html` (include, 24줄, 변형 없음)

**Analog:** `index.html:470-493` (`    <!-- Footer -->` ~ `    </footer>`). 다른 세 사본: `privacy-policy/index.html:148-171`, `terms/index.html:174-197`, `data-deletion/index.html:125-148`. 스크래치에서 이 24줄 하나로 네 문서 바이트 동일 확인(RESEARCH 320행).
- 핵심 줄(사업자 문구는 바꾸지 않음 — 내용 변경은 Phase 5):
```html
            <div class="rp-foot-legal">
                <p>러닝펜슬은 슬림펌킨이 운영하는 서비스입니다.</p>
                <p>© 2026 슬림펌킨. All rights reserved.</p>
                <p>경로 데이터 © OpenStreetMap contributors</p>
            </div>
```
- 푸터 앞의 빈 줄(랜딩 `:469`, terms `:173`)과 뒤 문맥(랜딩 `:494` 빈 줄 + `:495` 끝 `<script>`, 법적 `</body>`)은 부르는 쪽에 둡니다.

---

### `_layouts/legal.html` (layout)

**Analog:** `terms/index.html:1-95` (머리~카드 머리) + `:169-200` (닫는 태그·푸터·`</html>`). 세 법적 파일의 `:1-95`는 `:8` `<title>`, `:9` `description`, `:92` eyebrow, `:93` h1 네 줄만 다릅니다(`:94` 날짜는 셋 다 「2026년 10월 31일」).

**원본 구조와 Liquid 치환 지점:**

| 원본 행 (terms) | 내용 | 레이아웃에서 |
|---|---|---|
| `:1-7` | `<!DOCTYPE html>`, 빈 줄, `<html lang="ko">`, 빈 줄, `<head>`, charset, viewport | 그대로 |
| `:8` | `<title>서비스 이용약관 - 러닝펜슬</title>` | `    <title>{{ page.title }} - 러닝펜슬</title>` |
| `:9` | `<meta name="description" content="…" />` (한 줄) | `content="{{ page.description }}"` |
| `:10` | `<meta name="robots" content="noindex" />` | `{%- if page.noindex %}` … `{%- endif %}`로 감쌈 |
| `:11-12` | theme-color, `<script src="https://cdn.tailwindcss.com"></script>` | 그대로 (Tailwind 제거는 Phase 3) |
| `:13-20` | head 링크 | 0열 `{% include head-links.html %}` |
| `:21-35` | `<script id="tailwind-config">` … `</script>` | **레이아웃에 직접** 그대로 (include로 빼지 않음, RESEARCH 218행) |
| `:36` | `    <style>` | 그대로 |
| `:37-64` | 「공통」 CSS | 0열 `{% include css/common.css %}` |
| `:65-70` | 빈 줄, 「법적 페이지 전용」 4줄, `    </style>` | 그대로 (레이아웃에 직접) |
| `:71-73` | `</head>`, 빈 줄, `<body>` | 그대로 (랜딩은 `<body id="top">`이라 다름) |
| `:74-87` | 헤더 | 0열 `{% include header.html %}` |
| `:88-91` | 빈 줄, `<main class="rp-grid">`, 컨테이너 `<div>`, `<article>` | 그대로 |
| `:92` | eyebrow `<span>` | `{{ page.eyebrow }}` |
| `:93` | h1 | `{{ page.heading \| default: page.title }}` |
| `:94` | 「최종 업데이트」 `<p>` | `{%- if page.updated %}` … `{{ page.updated }}` … `{%- endif %}` |
| `:95` | `<div class="mt-10 space-y-8 leading-[1.7] text-muted">` | 그대로 |
| `:96-168` | 본문 | 0열 `{{ content \| rstrip }}` |
| `:169-172` | `</div>`, `</article>`, `</div>`, `</main>` | 그대로 |
| `:173` | 빈 줄 | 그대로 |
| `:174-197` | 푸터 | 0열 `{% include footer.html %}` |
| `:198-200` | `</body>`, 빈 줄, `</html>` | 그대로 |

**레이아웃 완성 초안:** RESEARCH.md Pattern 2 (349-400행). 그 초안의 `… (terms/index.html:22-34 그대로) …`, `… (terms/index.html:69 그대로) …` 자리는 원본 줄을 복사해 채웁니다.

**조건문 패턴 (제어 태그에만 `{%-`):**
```liquid
    <meta name="description" content="{{ page.description }}" />
    {%- if page.noindex %}
    <meta name="robots" content="noindex" />
    {%- endif %}
    <meta name="theme-color" content="#F2B134" />
```
- 이름 금지: `default`·`page`·`home`·`post` (운영 테마 primer와 충돌). `legal`은 안전.
- `strict_variables` 켜지 않음(`heading`·`updated` 생략이 오류가 됨).

---

### 법적 페이지 3종 (front matter + 본문)

**Analog:** 각 파일 자신. 본문 범위(들여쓰기 20칸 그대로, `<section class="space-y-3">`부터 「임시 게시본」 `</p>`까지):

| 파일 | 본문 행 | 「임시 게시본」 문단 | 레이아웃 몫 시작 |
|---|---|---|---|
| `privacy-policy/index.html` | `:96-142` | `:140-142` (「본 방침은 …」) | `:143` `</div>` |
| `terms/index.html` | `:96-168` | `:166-168` (「본 약관은 …」) | `:169` `</div>` |
| `data-deletion/index.html` | `:96-119` | `:117-119` (「본 안내는 …」) | `:120` `</div>` |

**front matter 값 (원본 `:8`·`:9`·`:92`·`:93`·`:94`에서 글자 그대로):**

| 키 | privacy-policy | terms | data-deletion |
|---|---|---|---|
| `title` | `개인정보처리방침` | `서비스 이용약관` | `데이터 삭제 안내` |
| `description` | `러닝펜슬 개인정보처리방침. 수집 항목, 이용 목적, 위치정보 처리, 보유 기간, 사용자 권리를 안내합니다.` | `러닝펜슬 서비스 이용약관. 서비스 이용 조건, 코스·뱃지·포인트에 관한 규정, 이용자의 의무와 안전 책임을 안내합니다.` | `러닝펜슬 계정 및 사용자 데이터 삭제 방법과 삭제되는 데이터 항목을 안내합니다.` |
| `eyebrow` | `PRIVACY POLICY` | `TERMS OF SERVICE` | `DATA DELETION` |
| `heading` | (생략) | (생략) | `사용자 데이터 삭제 안내` |
| `updated` | `2026년 10월 31일` | `2026년 10월 31일` | `2026년 10월 31일` |
| `noindex` | `true` | `true` | `true` |

- YAML 값은 큰따옴표로 감쌉니다(RESEARCH 408-416행 예시). `description`에 `·`, `,`가 들어 있어 따옴표가 안전합니다.
- 「포인트」 같은 문구가 description에 있어도 이 단계에서는 바꾸지 않습니다(내용 변경은 Phase 6·7·8).

---

### `index.html` (랜딩, include 4곳)

**Analog:** 자기 자신. 바꾸는 곳은 넷뿐(D-03):

| 원본 행 | 내용 | 바꾼 뒤 |
|---|---|---|
| (맨 위) | — | front matter `---` / `layout: none` / `---` (RESEARCH Pattern 3, 권장) |
| `:18-25` | head 링크 | 0열 `{% include head-links.html %}` |
| `:31-58` | 「공통」 CSS | 0열 `{% include css/common.css %}` (`:30` `<style>` 다음, `:59` 빈 줄과 `:60` 「랜딩 전용」은 그대로 이어짐) |
| `:184-197` | 헤더 | 0열 `{% include header.html home=true %}` |
| `:470-493` | 푸터 | 0열 `{% include footer.html %}` |

그대로 두는 것: `:1-17`(OG 메타 포함), `:26-29` pre-paint 스크립트, `:60-`「랜딩 전용」 CSS, `:150` `<body id="top">`, `:152-182` 숨은 SVG `<defs>`, `:495-650` 끝 인라인 스크립트. 현재 `{{`·`{%` 0건 → `{% raw %}` 불필요.

---

### `_config.yml` (config)

**Analog:** 현재 파일 전체 (`:1-13`)
```yaml
# CNAME 은 GitHub Pages 가 원래부터 사이트에 올리지 않던 파일이다. exclude 를 직접 적으면 그 기본값이
# 사라지므로 함께 적어 둔다. 도메인 연결은 저장소의 CNAME 파일이 맡으며, 이 목록과는 상관없다.
exclude:
  - CNAME
  - CLAUDE.md
  - README.md
  - .planning/
```
- 주석 스타일: `#` 한국어, 「왜 넣었는지」를 문장으로. `:1-8` 머리 주석은 남기고, `:3` 「이 저장소에는 빌드가 없지만」은 사실과 어긋나게 되므로 고칩니다. Gemfile·vendor 기본 제외가 덮어써진다는 설명을 한 줄 더합니다.
- 최종 목록: RESEARCH.md Pattern 5 (444-476행) — `url: "https://runningpencil.com"` + `exclude`에 `Gemfile`, `Gemfile.lock`, `vendor/`, `prepare/`, `scripts/`, `.githooks/` 추가.

### `.gitignore` (config)

**Analog:** 현재 파일 (`:1-11`). 패턴: `# 한국어 설명` 한 줄 + 경로, 묶음 사이 빈 줄.
```gitignore
# 로컬 브라우저 검증 산출물
.playwright-mcp/
```
- 같은 모양으로 `# Jekyll 로컬 빌드 산출물·gem 설치 위치` 아래 `_site/`, `.jekyll-cache/`, `vendor/`, `.bundle/` 추가 (D-11).

### `Gemfile` / `Gemfile.lock`

**No analog.** RESEARCH.md §Standard Stack 「Installation」(221-242행)의 Gemfile을 그대로 씁니다. 주석은 `#` 한국어. lock은 `bundle install` 생성물(Bundler 4.0.23, `CHECKSUMS` 포함)을 그대로 커밋.

### `scripts/check-site.sh` (utility, batch)

**No repo analog** (저장소에 셸 스크립트 없음). 출처: RESEARCH.md Code Examples 「`scripts/check-site.sh`」(581행~, 스크래치에서 성공·실패 4종·짧은 PATH·worktree 시험 완료). 그대로 씁니다.
- 컨벤션(`.planning/codebase/CONVENTIONS.md`) 적용: 공백 4칸, 한국어 주석, 머리에 하는 일·사용법 주석(전역 규칙의 문서 주석), 실패를 조용히 삼키지 말고 이유를 출력.
- 반드시 지킬 함정: bash 3.2에서 `"${errors}건"`처럼 중괄호(Pitfall 5), 임시 폴더는 `pwd -P`(Pitfall 4), `rm -rf`에 변수 경로 보호(Pitfall 11), 시스템 Ruby 2.6 회피(Pitfall 7), 기대 제목은 스크립트 맨 위 한 곳(D-13 3번)과 「랜딩 제목은 Phase 4가 고친다」 주석.
- 기대 `<title>` 값(현재 원본):
  - `index.html:8` `러닝펜슬 - 달리고 걷는 길이 아트가 됩니다`
  - `privacy-policy/index.html:8` `개인정보처리방침 - 러닝펜슬`
  - `terms/index.html:8` `서비스 이용약관 - 러닝펜슬`
  - `data-deletion/index.html:8` `데이터 삭제 안내 - 러닝펜슬`
- 파일 모드 100755로 커밋(`git update-index --chmod=+x` 또는 `chmod +x` 후 add).

### `.githooks/pre-push` (utility, event-driven)

**No repo analog.** 출처: RESEARCH.md Code Examples 「`.githooks/pre-push`」(684행~). 표준 입력에서 `refs/heads/main` 줄만 골라 `scripts/check-site.sh <sha>` 호출. 하위 명령이 표준 입력을 먹지 않게(Pitfall 9) `< /dev/null`. 모드 100755. 켜기: `git config core.hooksPath .githooks`(클론마다 한 번, `CLAUDE.md`에 적음).

---

### 문서 고칠 곳 (D-12, D-19 — 네 번째 푸시의 문서 커밋)

**루트 `CLAUDE.md`**

| 행 | 지금 문장 (요약) | 고칠 방향 |
|---|---|---|
| `:15` | 방침 표 「Jekyll 빌드 전환」 현재 상태: 「현재는 빌드 없이 공통 블록을 네 파일에 복사하고 `python3 -m http.server`로 미리 봅니다」 | 「Phase 2 적용됨(`_layouts`·`_includes`, 로컬 Jekyll 3.10.0). Phase 3(Tailwind) 남음」 |
| `:39` | 「현재는 빌드 시스템이 없습니다 (… Phase 2까지 유효)」 | Gemfile·Jekyll 빌드·점검 스크립트 설명 |
| `:54` | 「네 페이지는 아래 세 가지를 **복사해서 공유**합니다 … (Phase 2까지 유효) … 네 파일을 모두 똑같이 수정」 | include 4개·`legal` 레이아웃 위치 설명, `{% raw %}` 규칙 |
| `:64-68` | Local preview 구간 「아래는 Phase 2까지 유효한 방법입니다」 + `python3 -m http.server 8000` | `bundle config set --local path vendor/bundle` / `bundle install` / `bundle exec jekyll serve --livereload` (http://localhost:4000), `git config core.hooksPath .githooks` |
| `:107` | Deploy 「현재는 로컬 빌드 스텝도 없습니다 (Phase 2까지 유효)」 | 푸시 전 `scripts/check-site.sh`(pre-push 훅이 자동 실행) |
| (Architecture·Assets 등) | 「Tailwind CDN … Phase 3에서」 문장은 유지 (Phase 3 몫) | 손대지 않음 |

`grep -n 'http\.server\|복사해서 공유\|네 파일\|Phase 2까지' CLAUDE.md`가 0건이 되어야 합니다(성공 기준 3).

**`.claude/CLAUDE.md`**
- `:11` 방침 표 「Jekyll 빌드 전환」 행 — 루트 `:15`와 **같은 커밋에서 똑같이** 손으로 고침.
- `:69`, `:98` (stack 구간, `http.server`), `:153`, `:243` (conventions 구간), `:269`, `:278`, `:291` (architecture 구간) — **직접 고치지 않음.** 아래 원본을 고친 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 재생성.

**`README.md`**
- `:6` `python3 -m http.server 8000   # http://localhost:8000` → `bundle exec jekyll serve --livereload` 등.

**`.planning/codebase/` 원본**

| 파일:행 | 지금 | 고칠 방향 |
|---|---|---|
| `STACK.md:25` | 로컬 미리보기 `python3 -m http.server 8000` | `bundle exec jekyll serve --livereload` |
| `STACK.md:70` | 정적 서버(`python3 -m http.server`) | Ruby 4.0.9 + Bundler |
| `CONVENTIONS.md:54` | 「공통」 — 네 페이지가 **똑같이 복사** … 네 파일을 함께 고친다 | `_includes/css/common.css` 한 곳 |
| `CONVENTIONS.md:151` | Shared code: 빌드가 없어 … (Phase 2까지 유효) … 네 파일에 **복사** | include·레이아웃 설명, `{% raw %}` 규칙, include 공백 규칙 |
| `CONVENTIONS.md` Linting 구간 | 「린터 없음 … 로컬 미리보기 확인으로 갈음」 | `scripts/check-site.sh`로 갈음 (D-14) |
| `ARCHITECTURE.md:132` | Anti-Pattern 「네 파일을 함께 수정」 | include 한 곳 수정 |
| `ARCHITECTURE.md` System Overview·Component 표·Key Characteristics (`.claude/CLAUDE.md:269,278,291`에 대응) | 복사로 공유, 템플릿·include 없음 | `_includes/*`, `_layouts/legal.html` 행 추가 |
| `STRUCTURE.md:65` | `python3 -m http.server 8000`으로 루트를 서빙 | Jekyll 빌드 |
| `TESTING.md:20` | `python3 -m http.server 8000` | `bundle exec jekyll serve --livereload`, `scripts/check-site.sh` |
| `TESTING.md:63`, `:111` | 네 파일의 공통 블록 일치 diff 확인 절차 | include로 단일화되어 불필요 → 점검 스크립트 설명으로 교체 |
| `CONCERNS.md:14` | 공통 블록 네 파일 복사 우려 | 해소됨으로 갱신 |
| `CONCERNS.md:73` | 로컬 서버(`python3 -m http.server`)에서 콘솔 확인 | `jekyll serve` |

## Shared Patterns

### 원본 줄 그대로 옮기기 (바이트 동일)
**Apply to:** include 4개, `legal.html`, 페이지 3종 본문
- 줄을 다시 치지 말고 `sed -n 'A,Bp' 원본 > 대상`처럼 잘라 옮긴 뒤 끝 줄바꿈만 제거하는 방식을 권장(손 복사는 긴 SVG `path` 줄에서 틀리기 쉬움). 그 뒤 RESEARCH Code Examples 「일회용 기준 비교」로 `cmp`/D-07 diff.

### 주석 스타일
**Source:** `_config.yml:1-8`, `index.html:27` (`// 「세 가지 이유」 구간을 … 정한다(…).`), `.gitignore`
**Apply to:** `_config.yml`, `.gitignore`, `Gemfile`, 셸 스크립트 2개 — 한국어 평서문, 「왜」를 적음, 구간 이름은 「」.

### 오류 처리
**Source:** `.planning/codebase/CONVENTIONS.md` Error Handling (빈 `catch`에도 이유 주석)
**Apply to:** 셸 스크립트 — 실패 시 무엇이 왜 실패했는지 한국어로 출력하고 비 0으로 종료. Ruby·bundle 부재도 이유를 출력(D-14).

### Liquid 안전
**Apply to:** front matter를 가진 모든 파일 — `{{`·`{%`가 인라인 JS·CSS에 생기면 `{% raw %}`(Pitfall 10: check-site 4번은 출력만 검사하므로 원본의 `{% raw %}`와 충돌하지 않음).

## No Analog Found

| File | Role | Data Flow | Reason |
|---|---|---|---|
| `scripts/check-site.sh` | utility | batch | 저장소에 셸 스크립트가 없음 → RESEARCH.md Code Examples(581행~) |
| `.githooks/pre-push` | git hook | event-driven | 훅 없음 → RESEARCH.md Code Examples(684행~) |
| `Gemfile` | config | — | Ruby 의존성 파일 없음 → RESEARCH.md §Standard Stack(221-236행) |
| `Gemfile.lock` | config | — | 생성물 |

## Metadata

**Analog search scope:** git 추적 파일 전체(`git ls-files` — HTML 4, `_config.yml`, `.gitignore`, `CLAUDE.md`, `.claude/CLAUDE.md`, `README.md`, `.planning/codebase/*.md`). 모든 경로가 추적 파일임을 확인했고, 미러 경로는 없음.
**Files scanned:** 15
**Pattern extraction date:** 2026-11-15
