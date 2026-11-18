# Phase 5: 사업자 정보와 지원 연락 경로 - Pattern Map

**Mapped:** 2026-11-19
**Files analyzed:** 11
**Analogs found:** 10 / 11

> D-02: 이 문서에는 사업자 값과 지원 주소를 적지 않습니다. 지원 주소는 「`.planning/baseline/NAMES.md`의 주소」로만 가리킵니다.
> 모든 render-if-present 판정은 `site.data.company.<키>.size > 0` 입니다 (`!= blank`는 Jekyll 3.10.0/Liquid 4.0.4에서 항상 참, 05-RESEARCH Pattern 1·Pitfall 1).

## File Classification

| New/Modified File | Role | Data Flow | Closest Analog | Match Quality | 커밋 묶음 |
|---|---|---|---|---|---|
| `_data/company.yml` (new) | config (사실값 슬롯) | build-time data | 없음 (`_data/` 첫 파일). 형식은 05-RESEARCH Code Example 2 | no analog | M1 (빈 값), M4 (값), G (이메일) |
| `_includes/footer.html` | include (component) | transform (Liquid 조건 렌더) | 자기 자신 + `_layouts/legal.html:10-12, 30-32` (`{%- if %}` 조건 줄) | exact | M1 (사업자·주소·이메일/전화 줄), H3 (nav 링크·aria-label) |
| `_includes/header.html` | include (component) | request-response (정적 링크) | 자기 자신 `:8-12` | exact | H3 |
| `_includes/css/common.css` | config (공통 CSS) | — | 자기 자신 `:24-27` (`.rp-foot-nav a`, `.rp-foot-legal`) | exact | M2 |
| `_includes/css/legal.css` (선택) | config (법적 CSS) | — | 자기 자신 `:16-18, 28` | exact | 별도 시각 커밋 (`dd + dt` 간격) |
| `support/index.html` (new) | page (legal layout) | build-time render | `data-deletion/index.html` (front matter `heading`), `privacy-policy/index.html` (본문 들여쓰기) | exact | H1 (보류 브랜치) |
| `scripts/check-site.sh` | utility (pre-push 점검) | batch | 자기 자신 `:72-80` (3번), `:87-90` (5번) | exact | M3 (7번 가드), H2 (`EXPECTED_TITLES`) |
| `CLAUDE.md`, `.claude/CLAUDE.md` | docs | — | 자기 자신 (방침 표, Pages 표, 푸터 설명) | exact | 라이브 확인 뒤 문서 커밋 |
| `.planning/codebase/{STACK,CONVENTIONS,ARCHITECTURE}.md`, `.planning/PROJECT.md` | docs (GSD 원본 맵) | — | 자기 자신 | exact | 위와 같음, 뒤에 `generate-claude-md` |
| `.planning/baseline/NAMES.md` | docs | — | 자기 자신 「들어갈 곳」 칸 | exact | 키 이름만, 값 없음 |
| `.planning/research/ARCHITECTURE.md` (권장) | docs | — | Pattern 1의 `!= blank` 예시 | exact | `.size > 0`로 정정 |
| 스크래치 검증 (커밋 안 함) | test | batch | `$TMPDIR/rp-p4/lib.sh` (Phase 4, 비추적 스크래치) — 정의는 `04-02-PLAN.md`·`04-03-PLAN.md`·`04-04-PLAN.md` | role-match | 모든 단계 |

## Pattern Assignments

### `_data/company.yml` (config, build-time data) — no analog

저장소에 `_data/`가 없습니다 (`git ls-files _data` 빈 출력). 05-RESEARCH Code Example 2를 그대로 씁니다. 핵심:
- 머리 주석: render-if-present, 모든 값 큰따옴표, 공백만 넣지 않음, `.size > 0` 판정, `support_email`은 게이트 확인 뒤, 값은 `.planning/`·커밋 메시지에 쓰지 않음.
- 키: `trade_name`, `representative`, `biz_reg_no`, `address`, `support_email`, `phone`. M1에서는 모두 `""`.
- `_`로 시작하므로 `_config.yml` `exclude` 수정 불필요. check-site 2번(`leaked` find `-name '_*'`, `scripts/check-site.sh:68`)이 출력 누출을 잡습니다.

---

### `_includes/footer.html` (include, Liquid 조건 렌더)

**Analog:** 자기 자신 + `_layouts/legal.html`의 조건 줄.

**삽입 위치** (`_includes/footer.html:18-22`) — 운영 안내 `<p>`(19행) 다음, 저작권 `<p>`(20행) 앞. 19·20행 문장은 고치지 않음 (D-09):
```html
            <div class="rp-foot-legal">
                <p>러닝펜슬은 슬림펌킨이 운영하는 서비스입니다.</p>
                <p>© 2026 슬림펌킨. All rights reserved.</p>
                <p>경로 데이터 © OpenStreetMap contributors</p>
            </div>
```

**조건 줄 공백 패턴** (`_layouts/legal.html:10-12, 30-32`) — `{%-`는 `if`/`endif`에만, 들여쓴 자리에 둠:
```liquid
    {%- if page.noindex %}
    <meta name="robots" content="noindex" />
    {%- endif %}
```

**적용할 템플릿:** 05-RESEARCH Code Example 1 (스크래치 빌드 확인됨). 요약:
- 사업자 줄: 세 항목 판정을 `or`로만 잇고 (`and`/`or` 섞지 않음, Pitfall 2), 항목마다 `<span>`. 구분 기호는 앞 항목 존재 조건으로만 붙임 (D-08). 구분 기호 모양(` · ` vs `&nbsp;· `)은 사용자 확인 사항 (RESEARCH Pattern 3).
- 주소 줄: `<p>주소 {{ site.data.company.address | escape }}</p>` (span 없음, 자연 줄바꿈).
- 이메일/전화 줄: `mailto:` 링크, 모든 출력에 `| escape`.
- 값 뒤에 조사를 붙이지 않음 (Pitfall 11).
- M1 판정: 빈 슬롯 빌드가 기준 커밋과 네 문서 `diff -r` 빈 출력.

**nav 패턴** (`_includes/footer.html:12-16`) — H3에서 끝에 링크 추가, `aria-label` 「약관 및 지원」 (D-19):
```html
                <nav class="rp-foot-nav" aria-label="약관 및 정책">
                    <a href="/privacy-policy/">개인정보처리방침</a>
                    <a href="/terms/">이용약관</a>
                    <a href="/data-deletion/">데이터 삭제 안내</a>
                </nav>
```
→ 마지막에 `<a href="/support/">고객 지원</a>` (20칸 들여쓰기). 끝 줄바꿈 없이 저장 (include 공백 규칙, 현 파일 24행 `</footer>`로 끝남).

---

### `_includes/header.html` (include, 정적 링크) — H3

**Analog:** 자기 자신 `:8-12`:
```html
            <nav class="rp-nav" aria-label="주요 메뉴">
                <a href="{% unless include.home %}/{% endunless %}#story">즐기는 법</a>
                <a href="{% unless include.home %}/{% endunless %}#demo">달려 보기</a>
                <a href="{% unless include.home %}/{% endunless %}#get">출시 안내</a>
            </nav>
```
→ 끝에 `<a href="/support/">고객 지원</a>`. `home` 분기 없이 항상 절대 경로 (D-18). 860px 이하 숨김 규칙(`common.css:28`)은 그대로.

---

### `_includes/css/common.css` (공통 CSS) — M2 (시각 커밋, M1과 분리)

**Analog:** `common.css:24-27`:
```css
        .rp-foot-nav { display: flex; flex-wrap: wrap; gap: 4px 24px; font-size: 15px; font-weight: 600; }
        .rp-foot-nav a { display: inline-flex; align-items: center; min-height: 44px; color: #FAFAF7; text-decoration: none; }
        .rp-foot-nav a:hover { text-decoration: underline; }
        .rp-foot-legal { display: flex; flex-direction: column; gap: 6px; padding-top: 20px; border-top: 1px solid #4A4844; font-size: 13px; line-height: 1.6; color: #B5B0A7; }
        @media (max-width: 860px) { .rp-nav { display: none; } }
```
**추가 두 줄** (27행 다음, 28행 `@media` 앞, 8칸 들여쓰기, 한 줄 규칙, 새 hex 없음 — `#FAFAF7`은 25행에 이미 있음):
```css
        .rp-foot-legal span { display: inline-block; }
        .rp-foot-legal a { color: #FAFAF7; text-decoration: underline; }
```
판정: 네 문서 diff가 `<style>` 안 두 줄 추가뿐 (`index.html` `57a58,59`, 법적 3종 `47a48,49`). 링크 기본 파란색 결함 방지 (Pitfall 4).

---

### `_includes/css/legal.css` (선택, 별도 시각 커밋)

**Analog:** `legal.css:16-18, 28`:
```css
        .rp-doc :where(h2, h3, p, ul, ol, dl, dd, figure) { margin: 0; }
        .rp-doc > * + * { margin-top: 32px; }
        .rp-doc section > * + * { margin-top: 12px; }
        .rp-doc dt { font-weight: 700; color: var(--rp-ink); }
```
FAQ `dl` 한 개에 네 쌍을 두면 쌍 사이 간격 0 (Pitfall 5). 선택지: (a) 28행 다음에 `.rp-doc dd + dt { margin-top: 12px; }` 한 줄 (`.rp-doc` 범위 필수, 법적 3종 화면 불변·바이트만 변경), (b) FAQ 항목마다 `<dl>` 하나 (CSS 변경 없음). 머리 주석(`:1-4`)에 「앵커 `id`는 `section`에 둔다」를 넣으면 법적 3종 바이트가 바뀌므로 M1과 섞지 않음 (Pitfall 6).

---

### `support/index.html` (page, `layout: legal`) — H1, 보류 브랜치

**Analog front matter:** `data-deletion/index.html:1-9` (`heading`을 쓰는 유일한 예):
```yaml
---
layout: legal
title: "데이터 삭제 안내"
description: "러닝펜슬 계정 및 사용자 데이터 삭제 방법과 삭제되는 데이터 항목을 안내합니다."
eyebrow: "DATA DELETION"
heading: "사용자 데이터 삭제 안내"
updated: "2026년 10월 31일"
noindex: true
---
```
→ `title: "고객 지원"`, `heading: "러닝펜슬 고객 지원"`, `eyebrow: "SUPPORT"`, `description` 필수, `updated`는 게이트 커밋 G 날짜. **`noindex` 줄과 끝 `<footer>` 「임시 게시본」은 두지 않음** (D-12). front matter에 Liquid 쓰지 않음.

**Analog 본문:** `data-deletion/index.html:10-13` (20칸 들여쓰기, `section` 첫 자식 `h2`, 구간 사이 빈 줄):
```html
                    <section>
                        <h2>삭제 방법</h2>
                        <p>러닝펜슬 앱 내 <strong>설정 → 계정 삭제</strong> 메뉴에서 …</p>
                    </section>
```
→ `<section id="contact">`, `<section id="report">`, `<section id="faq">` 순서 고정 (D-13). `#contact`·`#report`는 `{%- if site.data.company.support_email.size > 0 %}` … `{%- endif %}`로 감쌈 (0열). FAQ는 `dl`/`dt`/`dd`, 운영 주체 쌍은 `trade_name.size > 0` 조건, 값은 `{{ site.data.company.trade_name | escape }}`로만 참조 (D-17). 골격·FAQ 문장안은 05-RESEARCH Code Example 3과 「FAQ 문장안」 절. 허용 요소 밖(클래스, `style`) 금지.

레이아웃 `_layouts/legal.html:28-35`가 eyebrow·h1·updated·`.rp-doc` 래퍼를 그리므로 페이지에는 본문만:
```liquid
                <span class="rp-legal-eyebrow">{{ page.eyebrow }}</span>
                <h1 class="rp-legal-title">{{ page.heading | default: page.title }}</h1>
                {%- if page.updated %}
                <p class="rp-legal-updated">최종 업데이트: {{ page.updated }}</p>
                {%- endif %}
                <div class="rp-doc">
{{ content | rstrip }}
```

---

### `scripts/check-site.sh` (utility, batch)

**Analog — 3번 제목 표** (`:14-20`, `:72-80`). H2에서만 `EXPECTED_TITLES`에 한 줄 추가 (먼저 `main`에 넣으면 모든 푸시가 막힘, Pitfall 7):
```bash
EXPECTED_TITLES='index.html|러닝펜슬 - 달리고 걷는 길이 아트가 됩니다
privacy-policy/index.html|개인정보처리방침 - 러닝펜슬
terms/index.html|서비스 이용약관 - 러닝펜슬
data-deletion/index.html|데이터 삭제 안내 - 러닝펜슬'
```
→ 끝에 `support/index.html|고객 지원 - 러닝펜슬`.

**Analog — 항목 구조** (`:87-90`, 5번): 구획 머리 주석 `# ── N. 이름 ──` + 이유 주석 + `grep -rlF … --include='*.html' "$DEST"` + `problem "…: ${var//$DEST/}"`:
```bash
# ── 5. Tailwind Play CDN 없음 ──
# 법적 페이지는 정적 CSS(_includes/css/legal.css)로 그린다. 런타임 스크립트가 다시 들어오면 막는다.
tw=$(grep -rlF -e 'cdn.tailwindcss.com' -e 'tailwind.config' --include='*.html' "$DEST" 2>/dev/null)
[ -n "$tw" ] && problem "Tailwind Play CDN이 출력에 남아 있습니다: ${tw//$DEST/}"
```
→ M3: 7번 가드를 6번 블록(`:112`) 뒤, 114행 `[ "$errors" -eq 0 ]` 앞에 추가 (05-RESEARCH Code Example 6). 머리 주석 `:2-8`의 「여섯 가지」→「일곱 가지」와 7번 줄도 함께. bash 3.2 호환(연관 배열 없음, `:11`). 보류 묶음 중간 커밋이 7번에서 실패하는 것은 음성 대조로 기대값 (Pitfall 8).

---

### 두 `CLAUDE.md`, `.planning/codebase/*`, `PROJECT.md`, `NAMES.md` (docs)

- 방침 구간(「지원 이메일 공개」·「사업자 정보 표시」 현재 상태)은 두 사본을 같은 커밋에서 똑같이 고침.
- 루트 `CLAUDE.md`: Pages 표에 `support/index.html` 행, 공통 블록 설명의 헤더·푸터 링크, 「이메일 수집 폼 없음」 단락의 「현재 사이트에는 지원 이메일이 없습니다」, 푸터 설명에 사업자 줄.
- `.claude/CLAUDE.md` GSD 구간은 직접 고치지 않음 → 원본 맵 수정 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`.
- `check-site.sh` 항목 수(여섯→일곱)를 언급하는 모든 문장(CLAUDE.md Deploy·Repository purpose, STACK.md, CONVENTIONS.md Linting, ARCHITECTURE.md 표) 갱신.
- `NAMES.md`: 키 이름만 (`site.data.company.trade_name` 등). 값 금지.
- 시점: 사업자 쪽은 첫 푸시 라이브 확인 뒤, 지원 쪽은 게이트 푸시 라이브 확인 뒤 (D-21).

## Shared Patterns

### render-if-present
**Source:** `_layouts/legal.html:10-12` (공백 제어 모양) + 05-RESEARCH Pattern 1 (판정식)
**Apply to:** `footer.html`, `support/index.html`
- 판정은 `x.size > 0`, 여러 값은 `or`로만.
- `{%- if … %}` / `{%- endif %}`만 대시 사용. 출력 태그에는 대시 없음.
- 모든 값 출력에 `| escape`.

### include 공백 규칙
**Source:** `_layouts/legal.html:14, 16, 18, 23, 40` (include 태그 0열), `_includes/footer.html` (원본 들여쓰기, 끝 줄바꿈 없음)
**Apply to:** `footer.html`, `header.html` 수정 시 끝 줄바꿈을 더하지 않음.

### 커밋 분리와 출력 판정
**Source:** Phase 4 스크래치 `$TMPDIR/rp-p4/lib.sh` (비추적, 커밋 안 함; 새 단계는 `rp-p5` 등 새 스크래치에 같은 함수 `build <이름> <커밋>`·`build_src`·`serve`·`stop`를 다시 만들어 씀)
**Apply to:** M1 (바이트 동일 `diff -r` 빈 출력), M2 (`<style>` 두 줄만), cherry-pick 뒤 보류 출력 동일
```bash
build() {
    ...
    git -C "$REPO" archive --format=tar "$2" | tar -x -C "$W/$1/src" || { echo 'build: git archive 실패' >&2; return 1; }
    build_src "$1" || return 1
    printf '%s\n' "$tree" > "$W/$1/TREE"
}
# build_src: BUNDLE_GEMFILE="$REPO/Gemfile" JEKYLL_ENV=production bundle exec jekyll build --safe -s … -d …
```
화면 확인은 같은 스크래치의 Playwright 1.59.1 고정본(`$TMPDIR/rp-p4/pw`, pnpm), Chromium·WebKit, 375px·넓은 폭. 검증 기록에는 값을 쓰지 않고 행 유무·개수만 (D-02).

### 법적 본문 규칙
**Source:** `_includes/css/legal.css:1-4` 머리 주석, CONVENTIONS D-01~D-12
**Apply to:** `support/index.html` — 클래스 없는 허용 요소만, `section` 첫 자식 `h2`, `id`는 `section`에만.

## No Analog Found

| File | Role | Data Flow | Reason |
|---|---|---|---|
| `_data/company.yml` | config | build-time data | 저장소 첫 `_data` 파일. 05-RESEARCH Code Example 2 사용 |

## Metadata

**Analog search scope:** `_includes/`, `_layouts/`, `privacy-policy/`, `data-deletion/`, `scripts/`, `.planning/phases/04-landing-content-fix/`, `$TMPDIR/rp-p4/` (스크래치, 비추적 — 경로를 계획에 analog로 적지 말고 함수 정의만 재현)
**Files scanned:** 10
**Pattern extraction date:** 2026-11-19
