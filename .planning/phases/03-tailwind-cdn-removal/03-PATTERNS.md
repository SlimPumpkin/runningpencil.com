# Phase 3: 법적 페이지 정적 스타일 전환 (Tailwind CDN Removal) - Pattern Map

**Mapped:** 2026-11-16
**Files analyzed:** 18 (사이트 6 + 점검 2 + 문서 10)
**Analogs found:** 18 / 18 (모든 analog는 `git ls-files`로 추적 파일임을 확인)

## File Classification

| New/Modified File | Role | Data Flow | Closest Analog | Match Quality | 커밋 |
|---|---|---|---|---|---|
| `_includes/css/legal.css` (새 파일) | config (CSS 조각 include) | transform (빌드 시 인라인) | `_includes/css/common.css` | exact | ① |
| `_layouts/legal.html` | layout | transform | 자기 자신 (현재 14·16-30·31-38·45-53행) + `index.html`의 `<style>` include 방식 | exact | ①(껍데기·include), ③(Tailwind 제거) |
| `privacy-policy/index.html` | page body | static | `terms/index.html` (같은 치환 6종) | exact | ② |
| `terms/index.html` | page body | static | 동일 | exact | ② |
| `data-deletion/index.html` | page body | static | 동일 | exact | ② |
| `scripts/check-site.sh` | utility (pre-push 점검) | batch | 자기 자신 4번 항목(80-83행) | exact | ③ 이후 |
| `.githooks/pre-push` | utility (hook) | event-driven | 자기 자신 — 머리 주석에 항목 수 없음 → **변경 불필요**(RESEARCH 546행) | — | — |
| `CLAUDE.md` (루트) | doc | — | Phase 2가 고친 같은 파일의 방침 표·Architecture 절 | exact | 문서 커밋 |
| `.claude/CLAUDE.md` | doc (방침 구간 수동 + 나머지 재생성) | — | 루트 `CLAUDE.md` 방침 구간 사본 | exact | 문서 커밋 |
| `.planning/codebase/STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md`·`CONCERNS.md`·`STRUCTURE.md`·`TESTING.md`·`INTEGRATIONS.md` | doc (원본 맵) | — | 각 파일의 현재 Tailwind 언급 줄 (아래 표) | exact | 문서 커밋 |
| `README.md` | doc | — | `README.md:10` 점검 항목 나열 | exact | 문서 커밋 |

---

## Pattern Assignments

### `_includes/css/legal.css` (config, transform) — 새 파일

**Analog:** `_includes/css/common.css` (1-28행, 끝 줄바꿈 없음 — `od -c`로 마지막 바이트가 `}` 임을 확인)

**머리 주석 + 한 줄 규칙 + 8칸 들여쓰기 패턴** (common.css 1-6행):
```css
        /* ── 공통: 바탕 · 머리말 · 바닥글 ──
           모든 페이지가 이 묶음을 _includes/css/common.css 에서 불러 쓴다. 고칠 때는 그 파일 한 곳만 고친다. */
        html { background: #F2B134; -webkit-text-size-adjust: 100%; text-size-adjust: 100%; }
        body { margin: 0; overflow-x: clip; font-family: "Pretendard Variable", ...; }
        *, *::before, *::after { box-sizing: border-box; }
        :focus-visible { outline: 3px solid #1E5AA8; outline-offset: 3px; }
```
**끝 줄 패턴** (common.css 28행, 줄바꿈 없이 끝남):
```css
        @media (max-width: 860px) { .rp-nav { display: none; } }
```
- legal.css도 마지막 줄 `@media (min-width: 768px) { .rp-legal-card { padding: 48px; } }` 뒤에 줄바꿈 없이 저장한다 (`printf` 확인: `tail -c1 _includes/css/legal.css | od -c` → `}`).
- 내용 원문은 RESEARCH.md 「검증된 `_includes/css/legal.css` 원안」(438-479행)을 그대로 쓴다. 그 원안은 커밋 ①②③ 모두 0픽셀로 실측됨.
- 옮겨 올 기존 규칙(현재 `_layouts/legal.html` 34-37행):
```css
        /* ── 법적 페이지 전용 ── 모눈종이 바탕. 글이 짧아도 바닥글이 화면 아래에 붙는다 */
        body { min-height: 100vh; display: flex; flex-direction: column; }
        main { flex: 1 0 auto; }
        .rp-grid { background-color: #F5F9FC; background-image: linear-gradient(#D3E2EF 1px, transparent 1px), linear-gradient(90deg, #D3E2EF 1px, transparent 1px); background-size: 32px 32px; }
```
- 금지: 이중 중괄호·중괄호-퍼센트(주석 포함), 토큰·초기화를 `common.css`에 넣기(랜딩 출력 바뀜), 맨 요소 선택자(`footer {}`, `a {}`) — 반드시 `.rp-doc` 범위(`.rp-doc > footer`, `.rp-doc a`). 초기화는 `.rp-doc :where(...)`로 간격 규칙보다 앞에.
- `_includes/` 밑줄 폴더라 `_config.yml` `exclude` 수정 불필요. check-site `FORBIDDEN`에 `_includes`가 이미 있어 출력 누출도 잡힌다.

---

### `_layouts/legal.html` (layout, transform)

**Analog:** 자기 자신. 현재 모습:

**제거 대상** (14행, 16-30행 — 커밋 ③):
```html
    <script src="https://cdn.tailwindcss.com"></script>
{% include head-links.html %}
    <script id="tailwind-config">
        tailwind.config = { theme: { extend: { colors: { "ink": "#2B2B2B", ... "line": "#E4E0D6", } } } }
    </script>
```

**include 인라인 패턴** (31-33행 — 같은 방식으로 legal.css를 0열에 추가, 커밋 ①):
```html
    <style>
{% include css/common.css %}

{% include css/legal.css %}
    </style>
```
(34-37행 「법적 페이지 전용」 묶음은 legal.css로 옮기고 레이아웃에서 지운다.)

**껍데기 클래스 교체** (45-53행 → RESEARCH 486-514행 모양, 커밋 ① 권장):
```html
        <div class="mx-auto max-w-[800px] px-6 py-[clamp(48px,6vw,80px)]">   → <div class="rp-legal-wrap">
            <article class="rounded-[28px] border-[1.5px] border-line bg-white p-7 md:p-12">  → <article class="rp-legal-card">
                <span class="text-sm font-bold tracking-[0.04em] text-accent">  → <span class="rp-legal-eyebrow">
                <h1 class="mt-3.5 text-[clamp(30px,6.5vw,42px)] font-black leading-[1.25] tracking-[-1px]">  → <h1 class="rp-legal-title">
                <p class="mt-3 text-[13px] text-muted-2">최종 업데이트: …  → <p class="rp-legal-updated">
                <div class="mt-10 space-y-8 leading-[1.7] text-muted">  → <div class="rp-doc">
```
- 유지: `{%- if page.noindex %}`·`{%- if page.updated %}`(`{%-`는 if/endif에만), `{{ content | rstrip }}` 0열, `{% include header.html %}`/`footer.html` 0열, front matter 키 불변.

---

### 본문 3종 `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html` (page body, static)

**Analog:** `terms/index.html` 9-24행, 79-81행 (세 문서 공통 구조)

**현재 마크업:**
```html
                    <section class="space-y-3">
                        <h2 class="text-xl font-bold text-ink">제2조 (정의)</h2>
                        <ul class="list-disc space-y-1 pl-5">
                            <li>…</li>
                        </ul>
                    </section>

                    <p class="border-t border-line pt-4 text-sm text-muted-2">
                        본 약관은 임시 게시본이며, 정식 서비스 출시 시 갱신될 수 있습니다.
                    </p>
```
**치환 6종** (RESEARCH 518-526행): `section`·`h2`·`ul`·`a`·`strong`의 class 제거, 끝 안내 `p` → `footer`(안쪽 글·줄바꿈·들여쓰기 그대로, `<p>` 중첩 없음).
- 끝 안내 위치: `privacy-policy/index.html:53`, `terms/index.html:79`, `data-deletion/index.html:31`.
- 현재 본문 `class=` 수: 16·27·9 → 변환 뒤 0·0·0. 확인 명령:
```bash
for pg in privacy-policy terms data-deletion; do printf '%s ' $pg; awk 'n>=2; /^---$/{n++}' "$pg/index.html" | grep -c 'class='; done
```
- 문장·`noindex`·「임시 게시본」·포인트 문구는 건드리지 않는다.

---

### `scripts/check-site.sh` (utility, batch)

**Analog:** 같은 파일 4번 항목 (80-83행):
```bash
# ── 4. 처리되지 않은 Liquid ──
# {% raw %}로 일부러 내보내는 {{ 가 생기면 이 검사가 걸린다. 그때는 예외 규칙을 여기에 더한다.
raw=$(grep -rlF -e '{%' -e '{{' --include='*.html' "$DEST" 2>/dev/null)
[ -n "$raw" ] && problem "Liquid가 처리되지 않은 출력: ${raw//$DEST/}"
```
**머리 주석 패턴** (2-6행): 「네 가지를 확인한다」 → 「다섯 가지」, 목록에 `#   5. 출력 HTML에 Tailwind Play CDN(cdn.tailwindcss.com, tailwind.config)이 없다` 추가.
**새 5번 항목** (4번 바로 뒤, 85행 `[ "$errors" -eq 0 ]` 앞, RESEARCH 532-538행):
```bash
# ── 5. Tailwind Play CDN 없음 ──
# 법적 페이지는 정적 CSS(_includes/css/legal.css)로 그린다. 런타임 스크립트가 다시 들어오면 막는다.
tw=$(grep -rlF -e 'cdn.tailwindcss.com' -e 'tailwind.config' --include='*.html' "$DEST" 2>/dev/null)
[ -n "$tw" ] && problem "Tailwind Play CDN이 출력에 남아 있습니다: ${tw//$DEST/}"
```
- 규약: `problem()`으로 누적, bash 3.2 호환(연관 배열·mapfile 금지), 구획 머리 `# ── N. 이름 ──`.
- 순서 주의(Pitfall 4): 커밋 ③과 같거나 그 뒤 커밋에 넣는다. ①②를 손으로 점검할 때는 그 시점 스크립트로.

### `.githooks/pre-push` — 변경 없음
1-3행 주석에 항목 수가 없고 `"$TOP/scripts/check-site.sh" "$local_sha"`(12행)로 부르기만 하므로 고칠 곳이 없다. 계획에서 제외하거나 「확인만」 태스크로 둔다.

---

### 문서 (doc) — 문서 커밋, 두 번째 푸시

| 파일 | 고칠 줄 (현재 grep 결과) | 바꿀 내용 |
|---|---|---|
| `CLAUDE.md` | 15 (방침 표 「Jekyll 빌드 전환」 행) | 「Phase 3까지 적용됨」. `.claude/CLAUDE.md` 같은 행도 같은 커밋에서 똑같이 |
| `CLAUDE.md` | 82 (Local preview) | 「법적 페이지의 Tailwind는 CDN에서 받으므로」 삭제 — 글꼴만 CDN |
| `CLAUDE.md` | 87-89 (Tailwind CDN 런타임 모드, 토큰) | 정적 CSS 설명: `_includes/css/legal.css`, `:root --rp-*` 토큰, Preflight 대체, `.rp-legal-*` 껍데기, `.rp-doc` 본문 범위 + 본문 작성 규칙(D-02~D-04, `figure tabindex="0" aria-label`) |
| `CLAUDE.md` | 공통 블록 목록·860px breakpoint 설명·Deploy 점검 항목(약 118행 「…Liquid가 없음」) | `legal.css` include 추가, 768px `min-width` 예외, Tailwind 없음 항목 |
| `.planning/codebase/STACK.md` | 35, 36, 52, 81 | Tailwind 항목 제거, 인터넷 필요 이유에서 Tailwind 삭제 |
| `.planning/codebase/CONVENTIONS.md` | 49(「점검 항목은 넷」), 66-71(법적 페이지 절), 78(`Tailwind ink`), 101(head 순서) | 「다섯」, 정적 CSS 규칙 + 본문 작성 규칙(D-25), 토큰 변수명 |
| `.planning/codebase/ARCHITECTURE.md` | 13, 16, 33, 61, 127, 132, 148-151 | 토큰 위치 `_includes/css/legal.css`, CDN 의존에서 Tailwind 삭제, 「랜딩에 Tailwind 클래스 추가」 안티패턴은 「본문에 클래스/맨 요소 선택자」로 대체 검토 |
| `.planning/codebase/CONCERNS.md` | 19-23, 44-47, 64, 100-101 | Tech debt 해소 표시 또는 삭제 (Pretendard `integrity` 부분은 유지) |
| `.planning/codebase/STRUCTURE.md` | 27, 56, 77 | `legal.css` 트리 항목 추가, 레이아웃 설명 갱신 |
| `.planning/codebase/TESTING.md` | 12(「네 가지」), 29, 41, 83 | 「다섯 가지」, Tailwind 언급 삭제 |
| `.planning/codebase/INTEGRATIONS.md` | 15-16 | Tailwind Play CDN 항목 삭제 |
| `README.md` | 10 (`# 푸시 전 점검 (빌드·내부 파일·제목·Liquid 잔여)`) | `·Tailwind 없음` 덧붙임 |
| `.claude/CLAUDE.md` | 방침 구간만 손으로, 나머지 | 원본 맵 수정 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md` |

- 「4번 항목」(Liquid)을 번호로 인용하는 곳(`CLAUDE.md:65`, `CONVENTIONS.md:154`, `ARCHITECTURE.md:131`)은 새 항목을 5번으로 붙이므로 고칠 필요 없음. `CONCERNS.md:95`, `STRUCTURE.md:113`의 「넷」은 URL 수라 무관.
- 「현재 상태 (2026-11 기준)」 같은 날짜 병기 문체를 유지.

---

## Shared Patterns

### include 공백 규칙
**Source:** `_layouts/legal.html` 15·32·42·59행, `_includes/css/common.css` 끝
**Apply to:** `legal.css`, `_layouts/legal.html`
- include 태그는 0열에 혼자. include 파일은 원본 들여쓰기(8칸) 그대로, 끝 줄바꿈 없음. `{%-`는 if/endif에만.

### `.rp-` 범위 선택자 (과도기 캐스케이드)
**Source:** RESEARCH Pattern 1·2
**Apply to:** legal.css 전체
- CDN `<style>`이 `<head>` 마지막에 붙어 같은 명시도면 Tailwind가 이긴다 → 본문 규칙은 `.rp-doc …`(0,1,1 이상), 초기화는 `.rp-doc :where(...)`(0,1,0)로 간격 규칙 앞.

### 점검 항목 추가 형태
**Source:** `scripts/check-site.sh` 62-83행
**Apply to:** 5번 항목
- `# ── N. 이름 ──` 머리, 한 줄 이유 주석, `grep -rlF … --include='*.html' "$DEST"`, `problem "…: ${var//$DEST/}"`.

### 커밋/문서 동시 갱신
**Source:** CLAUDE.md 작업 규칙
- 방침 구간 두 사본 같은 커밋. GSD 생성 구간은 원본 맵 → `generate-claude-md`. Conventional Commits(영어 prefix, 한국어 제목).

## No Analog Found

없음. 표·`figure` 스크롤 그림자·중첩 목록 규칙은 코드베이스에 선례가 없지만, RESEARCH.md 원안(Pattern 3·4·5, 474-477행)이 실측 검증된 정본이므로 그것을 쓴다.

## Metadata

**Analog search scope:** `_includes/`, `_layouts/`, 법적 3종 페이지, `scripts/`, `.githooks/`, `README.md`, `CLAUDE.md`, `.planning/codebase/`
**Files scanned:** 16
**Pattern extraction date:** 2026-11-16
