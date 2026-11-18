---
phase: 04-landing-content-fix
reviewed: 2026-11-18T08:19:19Z
depth: standard
files_reviewed: 11
files_reviewed_list:
  - .claude/CLAUDE.md
  - CLAUDE.md
  - README.md
  - images/app/screen-badge-564.webp
  - images/app/screen-badge-846.webp
  - images/app/screen-draw-564.webp
  - images/app/screen-draw-846.webp
  - images/app/screen-run-564.webp
  - images/app/screen-run-846.webp
  - index.html
  - scripts/check-site.sh
findings:
  critical: 0
  warning: 1
  info: 5
  total: 6
  necessity: 0
status: issues_found
---

# Phase 4: Code Review Report

**Reviewed:** 2026-11-18T08:19:19Z
**Depth:** standard
**Files Reviewed:** 11
**Status:** issues_found

## Summary

Phase 4 변경분(`git diff 0bfe5b210c3c HEAD`)을 standard 깊이로 검토했습니다. 대상은 랜딩(`index.html`)의 메타·OG 문구 정정, 「세 가지 이유」 3단계의 빈 뱃지 제거, 새 「실제 앱 화면」 구간(`#screens`)과 캡처 WebP 6개, 푸시 전 점검 6번 항목(`scripts/check-site.sh`), 문서 3종(`CLAUDE.md`, `.claude/CLAUDE.md`, `README.md`)입니다.

확인한 것:

- 작업 트리에서 `scripts/check-site.sh`를 돌렸고 통과했습니다 (Jekyll 3.10.0).
- WebP 6개는 모두 `VP8` 청크 하나뿐입니다 (`webpinfo`). EXIF·XMP·ICCP 청크가 없습니다. 크기는 564×1224, 846×1837이고, `width="846" height="1837"`과 564w 파일의 비율 차이는 0.1% 미만입니다.
- `sizes="(max-width: 860px) 242px, 282px"`는 실제 표시 폭보다 작게 잡히는 경우가 없습니다. 넓은 화면은 `.rp-shot-frame` `max-width: 300px` − 안쪽 여백 9px×2 = 282px이고, 좁은 화면은 `min(72vw, 260px)` − 18px ≤ 242px입니다.
- 지운 `.t-empty` 규칙을 쓰는 곳이 남아 있지 않습니다. 새로 쓴 `.t-graphite`는 `index.html:47`에 정의되어 있습니다. 「보관함 · 받은 뱃지 7」은 표시한 뱃지 7개와 수가 맞습니다.
- 랜딩 출력에 포인트·굿즈·코스북이 없습니다. 인라인 스크립트(`index.html:464` 이후)는 `screens`·`rp-shot*` 이름을 쓰지 않습니다. 문서의 설명과 같습니다.
- 캡처 세 장의 `alt`는 화면 내용(6.5 km와 걷기·달리기·자전거 예상 시간, 16%·16:08·1.34 km·12'00"/km, 강아지 모양 뱃지 창)과 맞습니다. 하단 탭은 보이지 않습니다.
- 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`의 「이번 마일스톤 방침」 구간은 같습니다 (GSD 생성 표시 주석만 다름). `.claude/CLAUDE.md`의 새 생성 구간 문장은 원본(`.planning/codebase/STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md`)에도 있습니다.

Critical 수준의 결함은 없습니다. 주된 문제는 문서입니다. 이번 단계에서 `index.html` 중간에 CSS 11줄과 마크업 25줄이 늘었는데, `.claude/CLAUDE.md`가 적은 `index.html` 줄 번호는 그대로 남았습니다. 이 단계가 직접 고친 표의 행도 마찬가지입니다 (WR-01). 나머지는 점검 6번 항목의 오탐 가능성, 점검 스크립트의 낡은 주석, 넓은 화면에서 기능이 없는 탭 멈춤 자리, 페이지 안의 코스 이름 불일치, 캡처 속 NAVER 로고 가림이고 Info로 분류했습니다.

## Narrative Findings (AI reviewer)

## Warnings

### WR-01: `.claude/CLAUDE.md`의 `index.html` 줄 번호가 이번 단계의 줄 이동을 반영하지 않음

**File:** `.claude/CLAUDE.md:132, 297, 298, 300, 302, 303, 322, 335, 341-359, 365, 371, 382, 405, 415, 416`
**Issue:**
Phase 4는 `index.html`의 「랜딩 전용」 CSS에 11줄(`.rp-shots*` 규칙)을 넣고, `#demo`와 `#get` 사이에 `#screens` 마크업 25줄을 넣었습니다. 기준 커밋(`0bfe5b2`)과 HEAD를 비교하면 줄 번호가 이렇게 바뀌었습니다.

| 문서가 적은 위치 | 기준 커밋 | HEAD |
|---|---|---|
| 헤더 include (`:297`) | `index.html:153` | `index.html:164` |
| 푸터 include (`:298`) | `index.html:426` | `index.html:462` |
| 「랜딩 전용」 CSS (`:300`) | `index.html:29-115` | `index.html:29-126` (`</style>`이 116 → 127) |
| SVG 심볼 `<defs>` (`:302`) | `index.html:121-151` | `index.html:133-161` 부근 |
| 랜딩 동작 스크립트 (`:303`, `:335`) | `index.html:428-583` | `index.html:464-619` |
| `var state` (`:359`) | `index.html:446` | `index.html:482` |
| `'use strict'` (`:382`) | `index.html:430-431` | `index.html:467` 부근 |
| `rp-c-dog` path (`:365`) | `index.html:123` | `index.html:134` |
| `@media (max-width: 860px)` (`:405`) | `index.html:100` | `index.html:109` |
| 「약 428행」 스크립트 (`:132`) | 스크립트 시작 | `#screens`의 두 번째 캡처 `<li>` 안 |

기준 커밋에서는 이 번호들이 맞았습니다 (Phase 3 리뷰가 `index.html:153/426`을 맞다고 확인함). 그러니 이번 단계가 어긋나게 만든 것입니다. 특히 `:300` 행(「랜딩 전용」 CSS)은 이 단계가 「앱 화면 띠」를 더하면서 직접 고친 행인데, 범위 `29-115`는 그대로 두었습니다. 줄 이동 폭이 위치마다 다릅니다 (CSS 뒤 +11, `#screens` 뒤 +36). 그래서 독자가 일정한 값을 더해 보정할 수도 없습니다. CONVENTIONS 구간의 「id·class·data 속성 이름을 바꾸면 `index.html` 끝(약 428행)의 인라인 스크립트도 반드시 같이 고친다」는 지금 캡처 마크업을 가리킵니다. 그래서 스크립트 연결점을 찾는 다음 작업자(사람이나 에이전트)를 엉뚱한 곳으로 보냅니다. Data Flow 구간의 세부 번호(`:341-357`의 `485-505`, `496-498`, `551-554`, `558-570`, `576-581` 등)도 모두 스크립트 안의 위치라서 같이 +36 밀렸습니다.

**Fix:**
`.claude/CLAUDE.md`의 생성 구간은 직접 고치지 않습니다 (작업 규칙). 원본을 고치고 다시 생성합니다.

```bash
# 1) 원본의 index.html 줄 번호를 HEAD 기준으로 고친다
#    .planning/codebase/ARCHITECTURE.md:24-33, 56, 69, 76-96, 100, 107, 113, 129, 154, 168-169
#    .planning/codebase/CONVENTIONS.md:30  (「약 428행」 → 「약 464행」)
grep -n -E '^    <script>|</style>|include (header|footer)|<defs>|</defs>|var state|use strict|max-width: 860px' index.html
# 2) 생성 구간을 다시 만든다
node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md
```

줄 번호가 앞으로도 계속 밀릴 것이 분명하면, 번호 대신 고정점(`<script>` 블록, `/* ── 랜딩 전용 ── */` 머리 주석, `{% include footer.html %}`)으로 위치를 적는 편이 낫습니다.

## Info

### IN-01: 점검 6번 항목의 `포인트`가 「체크포인트」 같은 다른 낱말에도 걸림 (오탐)

**File:** `scripts/check-site.sh:95-96`
**Issue:** `grep -c -E '포인트|굿즈|코스북'`은 부분 문자열로 맞춥니다. 시험 파일로 확인했더니 `체크포인트` 한 줄이 일치로 셌습니다 (`LC_ALL=C`에서도 같음). 러닝 앱 랜딩에서는 「체크포인트」, 「경유 포인트」, 「포인트 컬러」가 자연스럽게 나올 수 있는 낱말입니다. 그런 문구를 넣으면 점검이 푸시를 막고, 남는 우회로는 여섯 항목을 모두 건너뛰는 `git push --no-verify`뿐입니다. 막는 쪽(fail-closed)으로 틀리므로 라이브 사고로 이어지지는 않습니다.
**Fix:** 기능 이름으로 쓰인 경우만 잡도록 앞뒤를 좁히거나 허용 목록을 둡니다. 예:
```bash
u10=$(grep -E '포인트|굿즈|코스북' "$DEST/index.html" 2>/dev/null | grep -v -E '체크포인트|엔드포인트' | wc -l | tr -d ' ')
```
또는 허용 낱말이 생길 때 이 항목에 예외를 더한다고 주석에 적어 둡니다 (4번 항목의 raw 예외 주석과 같은 방식).

### IN-02: 점검 스크립트의 랜딩 제목 주석이 Phase 4 완료 뒤에도 「Phase 4에서 바뀔 수 있다」고 함

**File:** `scripts/check-site.sh:16`
**Issue:** 「랜딩 제목은 Phase 4에서 바뀔 수 있고, 바꾸는 단계가 이 값도 고친다.」는 Phase 4 전에 쓴 주석입니다. Phase 4는 끝났고 제목(`러닝펜슬 - 달리고 걷는 길이 아트가 됩니다`)은 바뀌지 않았습니다. 이번 단계가 같은 파일의 머리 주석(「다섯 가지」 → 「여섯 가지」)은 고치면서 이 줄은 두었습니다.
**Fix:** 「랜딩 제목을 바꾸는 단계가 이 값도 고친다.」처럼 단계 번호를 빼고 적습니다.

### IN-03: 넓은 화면에서 `.rp-shots`의 `tabindex="0"`이 기능 없는 탭 멈춤 자리가 됨

**File:** `index.html:417` (규칙 `index.html:94-95`, `:115`)
**Issue:** `tabindex="0"`은 좁은 화면(860px 이하)의 가로 스크롤 띠를 키보드로 밀기 위한 것입니다. 하지만 860px보다 넓으면 `.rp-shots`는 세 칸 grid라서 스크롤할 것이 없습니다. 그래도 탭 순서에 들어가 포커스 링만 그립니다. 키보드 사용자가 탭을 한 번 더 눌러야 하는 자리가 생깁니다. 법적 표의 `<figure tabindex="0">` 선례는 내용이 넘칠 수 있는 자리라서 경우가 다릅니다.
**Fix:** 이번 단계 방침이 「스크립트 없음」이면 지금처럼 두고 문서(`CONVENTIONS.md`의 해당 줄)에 넓은 화면에서도 탭 멈춤이 있다는 것을 적어 둡니다. 없애려면 스크립트가 아닌 방법이 없으므로(CSS로 `tabindex`를 바꿀 수 없음), 랜딩 인라인 스크립트에서 `matchMedia('(max-width: 860px)')`에 맞춰 `tabindex`를 붙였다 뗍니다.

### IN-04: 같은 강아지 모양 코스가 랜딩 목업에서는 「댕댕런」, 실제 캡처에서는 「강아지런」

**File:** `index.html:427` (뱃지 캡처), 목업·데모의 「댕댕런」 9곳 (예: `index.html:342`, `:359`, `:379`)
**Issue:** 「세 가지 이유」 폰 목업과 「달려 보기」는 같은 강아지 모양 코스를 「댕댕런」이라고 부르고 「댕댕런 뱃지를 받았어요!」를 보여 줍니다. 새로 넣은 `screen-badge-*.webp`에는 「강아지런 뱃지를 받았어요!」가 보입니다. 한 페이지 안에서 몇 화면 간격으로 이름이 달라집니다. 이 사이트의 핵심 목표는 심사자가 사이트와 앱이 같다고 확인하는 것이므로, 사소하지만 이름이 하나로 맞는 편이 낫습니다. 목업 이름이 의도된 가상 예시라면 결함은 아닙니다.
**Fix:** 다음 내용 변경 단계에서 목업·데모의 코스 이름을 앱과 같은 「강아지런」으로 맞추거나, 「댕댕런」 코스가 들어간 캡처로 바꿉니다. 내용 변경이므로 시각·리팩터 커밋과 섞지 않습니다.

### IN-05: `screen-badge-*.webp` 캡처에서 NAVER 로고가 앱의 뱃지 창에 일부 가려짐

**File:** `images/app/screen-badge-564.webp`, `images/app/screen-badge-846.webp` (사용처 `index.html:427`)
**Issue:** 뱃지 캡처의 지도 왼쪽 아래 NAVER 로고가 반투명 덮개와 뱃지 창에 걸려 「NAV」까지만 보입니다. 웹페이지가 자르거나 덮은 것은 아니고 앱 화면이 원래 그렇습니다. 그래서 「캡처 속 NAVER 로고를 원본보다 더 자르거나 덮지 않는다」는 규칙은 지켰습니다. 구간 아래 「지도 © NAVER Corp.」 표기도 있습니다. 다만 지도 SDK 이용 조건이 로고가 온전히 보이기를 요구한다면 이 캡처가 그 기준에 못 미칠 수 있습니다. 앱의 뱃지 창 배치 문제일 수도 있습니다. 확인되지 않은 판단입니다.
**Fix:** NAVER 지도 표기 정책을 확인합니다. 로고가 온전히 보여야 하면 로고가 가리지 않는 캡처로 바꾸거나 앱의 뱃지 창 위치를 조정합니다 (`.planning/baseline/USER-TASKS.md` 작업 10의 캡처 조건에 더함).

---

_Reviewed: 2026-11-18T08:19:19Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
