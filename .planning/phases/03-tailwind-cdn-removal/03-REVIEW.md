---
phase: 03-tailwind-cdn-removal
reviewed: 2026-11-16T18:47:14Z
depth: standard
files_reviewed: 9
files_reviewed_list:
  - _includes/css/legal.css
  - _layouts/legal.html
  - .claude/CLAUDE.md
  - CLAUDE.md
  - data-deletion/index.html
  - privacy-policy/index.html
  - README.md
  - scripts/check-site.sh
  - terms/index.html
findings:
  critical: 0
  warning: 2
  info: 6
  total: 8
  necessity: 1
status: issues_found
---

# Phase 3: Code Review Report

**Reviewed:** 2026-11-16T18:47:14Z
**Depth:** standard
**Files Reviewed:** 9
**Status:** issues_found

## Summary

Phase 3 변경분(`git diff 3d018cae3e39 HEAD`)을 standard 깊이로 검토했습니다. 대상은 법적 페이지 정적 CSS(`_includes/css/legal.css`), 레이아웃(`_layouts/legal.html`), 법적 본문 3종, 푸시 전 점검 스크립트(`scripts/check-site.sh`), 문서 3종(`CLAUDE.md`, `.claude/CLAUDE.md`, `README.md`)입니다.

확인한 것:

- 작업 트리에서 `scripts/check-site.sh`를 돌렸고 통과했습니다 (Jekyll 3.10.0).
- 법적 본문 3종에는 `class=`·`style=`이 하나도 없습니다. 쓰인 태그는 `section` `h2` `p` `ul` `li` `strong` `a` `footer`뿐이고 모두 허용 목록(D-04) 안에 있습니다.
- `_includes/css/legal.css`는 끝 줄바꿈이 없어 include 공백 규칙을 지킵니다.
- 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`의 「이번 마일스톤 방침」 구간은 글자 하나까지 같습니다.
- `.claude/CLAUDE.md`가 적은 줄 번호(`_layouts/legal.html:14/16/18/23/40`, `_includes/css/legal.css:5/9`, `index.html:21/27/153/426`)는 실제 파일과 맞습니다.
- 지운 Tailwind 유틸리티와 새 `legal.css` 규칙을 하나씩 대조했습니다 (`.planning/phases/03-tailwind-cdn-removal/03-RESEARCH.md:350-362`의 기준 CSS). 기본 글꼴 크기 16px에서는 값이 같습니다. 셀렉터 특이도와 선언 순서도 의도대로 이깁니다.

차단(Critical) 수준의 결함은 없습니다. 주요 우려는 두 가지입니다.

1. **rem이 px로 바뀌었습니다.** 기준은 rem 단위 유틸리티(`text-xl`, `text-sm`, `space-y-*`, `pl-5`, `p-7` 등)였는데 `legal.css`는 모두 px로 옮겼습니다. 사용자가 브라우저 기본 글꼴 크기를 바꾸면 본문 글자만 커지고 제목·간격·끝 안내는 그대로라서 위계가 무너집니다. 픽셀 비교는 기본값 16px에서만 했으므로 이 차이를 잡을 수 없었습니다 (WR-01).
2. **5번 점검 항목이 다른 형태의 런타임 Tailwind를 놓칩니다.** `@tailwindcss/browser` 스크립트와 `<style type="text/tailwindcss">`는 검사하는 두 문자열 어느 쪽과도 맞지 않습니다. 재현으로 확인했습니다 (WR-02).

나머지는 아직 실제 본문에 쓰이지 않은 규칙(표·`ol`·`:lang(en)`)의 잠재 결함, 점검 스크립트의 fail-open, 주석·문서 불일치이고 Info로 분류했습니다. 아직 실제 본문에 없는 요소(`h3`, `ol`, 중첩 목록, `dl`, `table`/`figure`, `aside`)는 라이브 페이지 픽셀 비교에 들어가지 않았습니다. 이 요소들은 `03-EVIDENCE.md`의 계산 스타일 기록(`olol: hangul`, `ulul: circle` 등)으로만 확인된 상태입니다.

## Narrative Findings (AI reviewer)

## Warnings

### WR-01: rem 기반 유틸리티를 px로 옮겨, 브라우저 기본 글꼴 크기를 바꾼 사용자에게서 제목·간격 위계가 무너짐

**File:** `_includes/css/legal.css:10-15, 17-19, 21, 24, 33, 39` (아직 실제 본문에 없는 새 규칙 `:20`, `:32`, `:36`도 같은 문제)
**Issue:**
기준 CSS(`03-RESEARCH.md:350-362`)는 rem 단위였습니다.

| 기준 클래스 | 기준 값 | 새 값 |
|---|---|---|
| `.text-xl` | `font-size: 1.25rem; line-height: 1.75rem` | `.rp-doc h2 { font-size: 20px; line-height: 28px }` |
| `.text-sm` | `0.875rem / 1.25rem` | `14px / 20px` (eyebrow, footer) |
| `.space-y-8` | `2rem` | `32px` |
| `.space-y-3` | `0.75rem` | `12px` |
| `.space-y-1` | `0.25rem` | `4px` |
| `.pl-5` | `1.25rem` | `20px` |
| `.mt-10` | `2.5rem` | `40px` |
| `.mt-3.5` | `0.875rem` | `14px` |
| `.p-7` / `md:p-12` | `1.75rem` / `3rem` | `28px` / `48px` |
| `.px-6` | `1.5rem` | `24px` |

`.rp-doc`의 본문 글자(`p`, `li`)에는 `font-size`가 없습니다. `body`·`html`(`_includes/css/common.css:3-4`, `legal.css:6`)에도 없으므로 본문 글자는 여전히 사용자 기본 글꼴 크기를 따릅니다.

사용자가 브라우저 설정에서 기본 글꼴 크기를 20px로 올리면 이렇게 됩니다.

- 기준: 본문 20px, `h2` 25px
- 지금: 본문 20px, `h2` 20px

`h2`가 본문과 같은 크기가 됩니다. 기본값을 24px로 올리면 `h2`(20px)가 본문(24px)보다 작아집니다. 끝 안내 `footer`(14px)와 목록 들여쓰기(20px)도 따라 커지지 않습니다.

브라우저 확대(Ctrl/Cmd +)는 px도 함께 키우므로 문제가 없습니다. 영향을 받는 것은 「기본 글꼴 크기」 설정을 쓰는 저시력 사용자입니다. Phase 3의 목표는 기준과 픽셀이 같은 것이었지만 비교는 기본값 16px에서만 했으므로 이 회귀를 잡을 수 없었습니다. `03-CONTEXT.md`, `03-DISCUSSION-LOG.md`, `03-02-PLAN.md`, `03-RESEARCH.md:340-372`를 찾아봤습니다. D-02·D-03·D-06·D-09·D-11과 표 글씨 결정(「14px로 작게」, `03-DISCUSSION-LOG.md:101`)이 크기를 px로 적고 있습니다. 하지만 rem을 px로 바꿀 때 사용자 글꼴 크기 설정에 생기는 영향을 검토한 기록은 찾지 못했습니다.

**Fix:** 기준 유틸리티와 같은 rem 값으로 되돌립니다. 기본값 16px에서는 픽셀이 같으므로 기존 비교 결과도 그대로 유지됩니다.

```css
        .rp-legal-wrap { max-width: 800px; margin-left: auto; margin-right: auto; padding: clamp(48px, 6vw, 80px) 1.5rem; }
        .rp-legal-card { border: 1.5px solid var(--rp-line); border-radius: 28px; background: #fff; padding: 1.75rem; }
        .rp-legal-eyebrow { font-size: 0.875rem; line-height: 1.25rem; font-weight: 700; letter-spacing: 0.04em; color: var(--rp-accent); }
        .rp-legal-title { margin: 0.875rem 0 0; /* 나머지 그대로 (clamp px는 기준과 같음) */ }
        .rp-legal-updated { margin: 0.75rem 0 0; font-size: 13px; color: var(--rp-muted-2); } /* 13px는 기준(text-[13px])도 px */
        .rp-doc { margin-top: 2.5rem; line-height: 1.7; color: var(--rp-muted); }
        .rp-doc > * + * { margin-top: 2rem; }
        .rp-doc section > * + * { margin-top: 0.75rem; }
        .rp-doc h2 { font-size: 1.25rem; line-height: 1.75rem; font-weight: 700; color: var(--rp-ink); }
        .rp-doc h3 { font-size: 1.0625rem; line-height: 1.5rem; font-weight: 700; color: var(--rp-ink); }
        .rp-doc :where(ul, ol) { padding-left: 1.25rem; }
        .rp-doc li + li, .rp-doc li > :where(ul, ol) { margin-top: 0.25rem; }
        .rp-doc aside { font-size: 0.875rem; line-height: 1.25rem; color: var(--rp-muted-2); }
        .rp-doc > footer { padding-top: 1rem; border-top: 1px solid var(--rp-line); font-size: 0.875rem; line-height: 1.25rem; color: var(--rp-muted-2); }
        .rp-doc table { /* … */ font-size: 0.875rem; line-height: 1.25rem; }
        @media (min-width: 768px) { .rp-legal-card { padding: 3rem; } }
```

고친 뒤에는 기본 글꼴 크기 16px에서 기존 판정 도구로 픽셀 0을 다시 확인합니다. 20px에서는 `h2`가 본문보다 큰지 눈으로 확인합니다. 단위 방침(rem)은 `.planning/codebase/CONVENTIONS.md`에도 한 줄 적어 둡니다. 그곳의 D-02·D-03·D-06·D-09·D-11은 px로 적혀 있으니, 「px는 기본 글꼴 16px 기준 표기이고 CSS는 rem으로 쓴다」는 주석을 함께 남깁니다. 그런 다음 `.claude/CLAUDE.md`를 다시 만듭니다.

### WR-02: 5번 점검 항목이 `@tailwindcss/browser` 스크립트와 `text/tailwindcss` 스타일을 잡지 못함

**File:** `scripts/check-site.sh:88`
**Issue:**
5번 항목은 두 문자열 `cdn.tailwindcss.com`과 `tailwind.config`만 찾습니다. 주석(`:87`)은 이 항목의 목적을 「런타임 스크립트가 다시 들어오면 막는다」로 적고 있습니다. 그런데 런타임 Tailwind를 다른 모양으로 들여올 수도 있습니다. jsDelivr의 `@tailwindcss/browser` 스크립트, `<style type="text/tailwindcss">` 안의 `@theme` 설정 같은 경우입니다. 이런 것은 두 문자열 어느 쪽에도 걸리지 않습니다. (이것이 Tailwind v4의 공식 Play CDN 형태인지는 이번 검토에서 공식 문서로 다시 확인하지 않았습니다. 아래 재현은 두 문자열이 무엇을 놓치는지만 보여 줍니다.)

`:88`의 grep을 그대로 임시 폴더에 돌려 재현했습니다. 아래 HTML은 아무것도 출력하지 않고 종료 코드 1(일치 없음)로 끝나서 점검을 통과합니다.

```html
<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
<style type="text/tailwindcss">@theme { --color-ink: #2B2B2B; }</style>
```

사이트가 이미 `cdn.jsdelivr.net`에 preconnect하고 있으므로(`_includes/head-links.html`), 누군가 이 방식으로 Tailwind를 다시 들여도 어색해 보이지 않습니다. 이 경우 점검은 아무 경고 없이 통과합니다.

**Fix:** 지금 출력 HTML에는 `tailwind`라는 글자가 전혀 없습니다. 그러니 대소문자 구분 없이 `tailwind` 전체를 막는 것이 가장 단순하고 빈틈이 적습니다.

```bash
tw=$(grep -rliF -e 'tailwind' --include='*.html' "$DEST" 2>/dev/null)
[ -n "$tw" ] && problem "Tailwind가 출력에 남아 있습니다: ${tw//$DEST/}"
```

나중에 본문에 이 단어가 정당하게 들어갈 수 있다면 대상 문자열을 늘리는 방법도 있습니다: `-e 'cdn.tailwindcss.com' -e 'tailwind.config' -e '@tailwindcss/' -e 'text/tailwindcss'`. 어느 쪽이든 머리 주석(`:7`), `CLAUDE.md`의 Deploy 절, `CONVENTIONS.md`의 점검 항목 설명도 함께 고칩니다.

## Info

### IN-01: `th { white-space: nowrap }`가 머리 행뿐 아니라 `tbody`의 행 머리(`th scope="row"`)에도 걸림

**File:** `_includes/css/legal.css:38`
**Issue:** 문서(`CLAUDE.md`, CONVENTIONS D-06)는 「표 머리 행은 줄바꿈하지 않고 한 줄로 둔다」라고 정했습니다. 그런데 셀렉터 `.rp-doc th`는 모든 `th`에 걸립니다. Phase 7 처리 위탁 표에서 접근성을 위해 첫 열을 `<th scope="row">`로 쓰면, 긴 한국어 행 머리(예: 위탁 업무 설명)도 한 줄로 강제됩니다. 그러면 좁은 화면에서 표가 지나치게 넓어집니다. 아직 표가 있는 본문이 없어 잠재 결함입니다.
**Fix:** 의도대로 머리 행만 고릅니다: `.rp-doc thead th { white-space: nowrap; }`. 글꼴 굵기·색 규칙은 모든 `th`에 남깁니다.

### IN-02: `ol:lang(en)` 규칙은 레이아웃이 `lang="ko"`로 고정되어 있어 지금 구조로는 걸릴 수 없음

**File:** `_includes/css/legal.css:27`, `_layouts/legal.html:3`
**Issue:** 영문판 안쪽 `ol`을 a. b. c.로 바꾸는 규칙(D-10)은 요소의 언어가 `en`일 때만 걸립니다. 하지만 `_layouts/legal.html:3`이 `<html lang="ko">`로 고정되어 있습니다. 게다가 본문 허용 요소에 `lang` 속성을 붙이는 규칙도 없습니다. 그래서 Phase 9에서 같은 레이아웃을 쓰면 이 규칙은 효과가 없고, 영문 페이지가 `lang="ko"`로 나갑니다.
**Fix:** Phase 9 계획에 레이아웃의 `lang`을 front matter로 받는 작업을 넣습니다 (`<html lang="{{ page.lang | default: 'ko' }}">`). 지금은 `legal.css:27` 옆에 「레이아웃 lang이 en일 때만 동작」 같은 주석을 남겨 둡니다.

### IN-03: `:where()`를 쓴 셀렉터 목록은, `:where`를 모르는 브라우저에서 같은 규칙의 다른 셀렉터까지 함께 버려짐

**File:** `_includes/css/legal.css:24` (`:16`, `:21`, `:25-27`, `:37`도 `:where` 의존)
**Issue:** `.rp-doc li + li, .rp-doc li > :where(ul, ol) { margin-top: 4px; }`는 셀렉터 목록입니다. `:where`를 모르는 브라우저(Safari 14 미만, Chrome 88 미만)는 목록 전체를 무효로 처리합니다. 그러면 `:where`와 상관없는 `li + li` 간격도 사라집니다. 같은 브라우저에서는 `:16`(UA 여백 초기화)과 `:37`(표 칸 여백·선)도 사라집니다. 심사자가 쓰는 최신 브라우저에는 영향이 없어 Info로 둡니다.
**Fix:** 적어도 `:where`가 필요 없는 셀렉터는 따로 둡니다: `.rp-doc li + li { margin-top: 4px; }`와 `.rp-doc li > ul, .rp-doc li > ol { margin-top: 4px; }`. 두 셀렉터의 특이도는 (0,1,2)로, 원래보다 높아져도 다른 규칙과 충돌하지 않습니다.

### IN-04: 4·5번 점검의 grep 오류가 「일치 없음」과 구분되지 않아 통과로 처리됨 (fail-open)

**File:** `scripts/check-site.sh:83-84`, `scripts/check-site.sh:88-89`
**Issue:** `grep ... 2>/dev/null`의 결과를 출력이 비었는지로만 판단합니다. 그래서 grep이 오류로 끝나도(종료 코드 2: 읽기 권한 오류, 잘못된 옵션 등) 출력이 비어 점검이 통과합니다. 지금은 방금 만든 임시 폴더라 일어나기 어렵지만, 이것은 푸시를 막는 마지막 관문입니다.
**Fix:** 종료 코드를 구분합니다.

```bash
tw=$(grep -rlF -e 'cdn.tailwindcss.com' -e 'tailwind.config' --include='*.html' "$DEST"); rc=$?
[ "$rc" -le 1 ] || problem "Tailwind 검사 grep 실패 (종료 코드 $rc)"
[ -n "$tw" ] && problem "..."
```

### IN-05: Cargo-culted pattern — Tailwind Preflight·`transition-colors`에서 옮긴, 효과 없는 선언

**File:** `_includes/css/legal.css:6`, `_includes/css/legal.css:30`
**Category:** necessity
**Issue:**
- `-moz-tab-size: 4; tab-size: 4`는 탭 문자가 보존되는 텍스트(`pre`, `white-space: pre*`)에서만 효과가 있습니다. 그런데 본문 허용 요소(D-04, `legal.css:3`)에는 `pre`·`code`가 없습니다. `legal.css`와 `common.css` 어디에도 `white-space: pre*`가 없습니다. 법적 본문 3종에도 탭 문자가 없습니다 (`grep -c $'\t'` 결과 0).
- `.rp-doc a`의 `transition-property`에 들어 있는 `background-color, border-color, fill, stroke, -webkit-text-decoration-color, text-decoration-color`도 같습니다. hover 때 바뀌는 속성은 `color` 하나(`:31`)뿐이라 이 항목들은 하는 일이 없습니다.

픽셀 동등성을 위해 기준을 그대로 옮긴 것으로 보이고, 지워도 화면은 같다고 판단합니다 (판단에 근거하므로 Info).
**Fix:** `tab-size` 두 선언을 지우고 `transition: color 150ms cubic-bezier(0.4, 0, 0.2, 1);`로 줄입니다. 아니면 지금처럼 두되, 「기준 Preflight 원문 유지」라는 이유를 주석으로 남깁니다. CLAUDE.md의 「Preflight 대체는 `html`(line-height 1.5, tab-size 4, …)」 문구도 함께 맞춥니다.

### IN-06: `legal.css` 머리 주석의 「함께 고칠 곳」이 CLAUDE.md 규칙보다 좁음

**File:** `_includes/css/legal.css:4`
**Issue:** 주석은 「목록에 없는 요소가 필요하면 여기 CSS와 CLAUDE.md 규칙을 함께 고친다」라고 적습니다. 그러나 루트 `CLAUDE.md`의 법적 본문 작성 규칙은 세 곳을 같은 단계에서 고치라고 합니다: `legal.css`, 이 규칙, 원본 맵 `.planning/codebase/CONVENTIONS.md`. 또 `.claude/CLAUDE.md`의 conventions 구간은 직접 고치지 않고 `CONVENTIONS.md`를 고친 뒤 다시 만들어야 합니다. 주석만 보고 따르는 사람은 `CONVENTIONS.md`를 빠뜨리거나, 생성 구간을 손으로 고치게 됩니다.
**Fix:** 주석을 「…여기 CSS, 루트 CLAUDE.md 규칙, .planning/codebase/CONVENTIONS.md를 함께 고친다 (.claude/CLAUDE.md는 generate-claude-md로 다시 만든다).」로 바꿉니다.

---

_Reviewed: 2026-11-16T18:47:14Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
