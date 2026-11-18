---
phase: 04-landing-content-fix
reviewed: 2026-11-18T13:24:24Z
depth: standard
files_reviewed: 3
files_reviewed_list:
  - .claude/CLAUDE.md
  - index.html
  - scripts/check-site.sh
findings:
  critical: 0
  warning: 2
  info: 2
  total: 4
  necessity: 0
status: issues_found
---

# Phase 4: Code Review Report (재검토 수정 뒤 세 번째 검토)

**Reviewed:** 2026-11-18T13:24:24Z
**Depth:** standard
**Files Reviewed:** 3
**Status:** issues_found

## Summary

이번 검토는 재검토 보고서 커밋 `87d431f` 뒤의 변경(`87d431f..HEAD`)을 봅니다. 코드에 닿는 커밋은 `db064f3`(IN-06, `index.html`), `9530f10`·`61391b3`·`dd0c710`(IN-06·IN-08 문서 재생성, `.claude/CLAUDE.md`), `8432d96`(IN-07, `scripts/check-site.sh`)입니다. 이 파일은 `87d431f`에 커밋된 재검토 보고서를 덮어씁니다. 그 보고서의 처리 결정은 `04-REVIEW-DISPOSITION.md`에 남아 있습니다. finding ID는 그 기록과 겹치지 않게 WR-02, IN-09부터 매깁니다.

대상 파일 세 개는 전체를 읽었습니다. 확인한 것은 아래와 같습니다.

- 작업 트리에서 `scripts/check-site.sh`를 돌렸고 통과했습니다 (`check-site: 통과 (작업 트리, jekyll 3.10.0)`).
- **IN-06 (거리 7.84 km):** `KM = 7.84`에서 나오는 값을 다시 계산했습니다. `#rp-run-dist` 4.86 km(7.84 × 0.62), `#rp-run-time` 37:16(4.8608 × 460초), 결과 「움직인 시간」 1:00:06(7.84 × 460초)은 스크립트의 `paintStory()`와 `clock()`이 내는 값과 같습니다. 거리 값 자체는 수정 보고서에 사용자가 확인한 값으로 적혀 있으므로 다시 따지지 않습니다. 다만 수정 보고서가 쓴 값 목록 정규식(`km`, `h:mm:ss`, `%`만 봄)은 「분」 단위를 보지 않았습니다. 그래서 `index.html:287`의 예상 시간 세 개가 옛 거리 그대로 남았습니다 (WR-02). `분`·`시간`·`초`·`킬로` 단위로 파일 전체를 다시 훑었고, 거리에서 나오는 값으로 남은 것은 이 세 개뿐입니다. `10초`(`:178`, `:377`, `:442`)와 `7초`(`:553` 주석)는 체험 길이라 거리와 관계가 없습니다.
- 결과 「총 시간」 1:02:40은 수정 보고서에 적힌 대로 계산식이 없는 목업 값입니다 (움직인 시간 + 154초). 결함으로 올리지 않습니다.
- **IN-08 (고정점):** `.claude/CLAUDE.md`가 새로 적은 고정점을 `grep -n -F`로 `index.html`에서 찾았습니다. `<!-- Shapes: … -->`(131), `<body id="top">`(130), `<section id="story"`(216), `/* ── 랜딩 전용 ── */`(29), `html.rp-ready { scroll-behavior: smooth; }`(31), `@media (max-width: 860px)`(109, `</style>` 바로 앞의 마지막 블록), `{% include head-links.html %}`(21), `{% include css/common.css %}`(27), `{% include header.html home=true %}`(164), `{% include footer.html %}`(462), `var state =`(482), `// ── 연결 ──`(582), `window.addEventListener('scroll'`(587), `window.addEventListener('load'`(605), `// 움직임 줄이기 설정이면`(612)이 모두 한 곳에서만 나옵니다. `href="#rp-c-dog"`는 18곳입니다. 다만 고정점 표와 「Order (`<head>`)」 절이 서로 반대 순서를 말합니다 (IN-09, 이번 범위 전부터 있던 것).
- **IN-07 (`U10_ALLOW_PREFIX`):** 지금 값 `체크|엔드`에서는 macOS `/usr/bin/grep`(BSD grep 2.6.0)으로 `LC_ALL=C`와 `ko_KR.UTF-8` 모두 고치기 전과 같은 결과를 냅니다. 그런데 이 값을 비우거나 형식을 틀리면 점검이 조용히 통과합니다 (WR-03). 고치기 전의 리터럴 패턴에는 없던 위험입니다.
- 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`의 「이번 마일스톤 방침」 구간(29줄)은 `diff`로 비교했고 같습니다.
- 커밋 구분: `db064f3`는 `index.html` 내용 변경만, `8432d96`은 `scripts/check-site.sh` 정리만 담고 있어 「리팩터·시각·내용 변경을 섞지 않는다」 규칙을 지킵니다.

Critical은 없습니다. Warning 2건과 Info 2건이 있습니다. 새 necessity finding은 없습니다. IN-07은 이미 (나) 방법으로 처리되었고, WR-03은 necessity 지적이 아니라 그 처리로 생긴 견고성 문제입니다.

## Narrative Findings (AI reviewer)

## Warnings

### WR-02: 「코스 그리기」 목업의 걷기·달리기·자전거 예상 시간이 옛 거리 8.3 km 기준으로 남음

**File:** `index.html:287` (같은 화면의 거리 `index.html:286`)
**Issue:** IN-06 수정으로 `:286`의 거리는 `7.84 km`로 바뀌었습니다. 그런데 바로 옆 `:287`의 예상 시간 `111분 · 71분 · 33분`은 그대로입니다. 이 세 값은 옛 거리에서 나온 값입니다. 8.3 km를 시속 4.5 / 7 / 15 km로 나누면 110.67 / 71.14 / 33.2분이 되고, 반올림하면 정확히 111 / 71 / 33입니다. 같은 페이지의 실제 캡처 `screen-draw-*.webp`(alt `:419`)도 같은 속도와 맞습니다. 그 화면은 `6.5 km`에 `86분 · 55분 · 26분`을 보여 줍니다. 그래서 지금 목업은 7.84 km 코스에 8.3 km의 시간을 붙여 보여 줍니다. 이 사이트는 심사자가 사이트와 앱이 같은지 확인하는 곳이고, IN-04·IN-06도 그 이유로 고쳤습니다.

원인은 수정 보고서의 값 목록 정규식입니다. `[0-9]+(\.[0-9]+)? ?km|[0-9]+:[0-9]{2}(:[0-9]{2})?|[0-9]+ ?%`는 「분」 단위를 잡지 않습니다. 보고서는 「위 표 말고 거리에서 나오는 정적 값은 없었습니다」라고 적었지만, 이 줄은 그 검색에 들어가지 않았습니다.

7.84 km를 같은 속도로 계산하면 104.53 / 67.2 / 31.36분입니다. 달리기 67분과 자전거 31분은 어떻게 반올림해도 같습니다. 걷기는 104분인지 105분인지 정할 수 없습니다. 실제 캡처의 6.5 km 표시가 86분(6.5 km로 정확히 계산해 반올림하면 87분)이라서, 앱이 버림을 쓰는지, 아니면 표시보다 짧은 실제 길이로 계산하는지 저장소만으로는 알 수 없습니다.
**Fix:** 앱의 강아지런 「코스 그리기」 화면에서 걷기 값을 확인한 뒤 `:287`의 세 값을 함께 고칩니다. 내용 변경이므로 다른 변경과 섞지 않고 따로 커밋합니다.
```html
<!-- index.html:287 — 걷기 값(104 또는 105)은 앱 화면에서 확인한 값으로 쓴다 -->
...<use href="#rp-i-walk" /></svg>105분 ·<svg ...><use href="#rp-i-run" /></svg>67분 ·<svg ...><use href="#rp-i-bike" /></svg>31분</span>
```
다음에 거리를 바꿀 때 같은 일이 생기지 않도록, 검증 정규식에 `[0-9]+ ?분`을 더합니다.

### WR-03: `U10_ALLOW_PREFIX`를 비우거나 형식을 틀리면 점검 6번이 조용히 통과함 (fail-open)

**File:** `scripts/check-site.sh:96-100`
**Issue:** IN-07 수정(`8432d96`)은 허용 접두어를 변수 하나에 모으고, 주석(`:96`)에서 「앞부분은 U10_ALLOW_PREFIX 한 곳에만 둔다」고 안내합니다. 지금 값 `체크|엔드`에서는 결과가 맞습니다. 하지만 이 변수를 고치는 사람이 흔히 넣을 값 두 가지에서 점검이 막아야 할 것을 놓칩니다. 시험은 `bash`와 `/usr/bin/grep`(BSD grep 2.6.0)으로 했고, 시험 줄은 `<p>포인트 굿즈 코스북 체크포인트</p>`(기대값 3곳)입니다. `LC_ALL=C`와 `ko_KR.UTF-8`의 결과가 같았습니다.

| `U10_ALLOW_PREFIX` | 결과 | 왜 |
|---|---|---|
| `'체크\|엔드'` (지금 값) | 3곳 | 정상 |
| `''` (예외를 모두 없애려고 비움) | 2곳, 맨 「포인트」를 하나도 세지 않음 | 빼는 쪽 패턴이 `()포인트`가 되어 맨 「포인트」를 모두 허용 낱말로 뺌 |
| `'체크\|'` (마지막 항목을 지우다 `\|`가 남음) | **0곳, 통과** | `grep: empty (sub)expression`, 종료 코드 2. `:98`의 `2>/dev/null`이 오류를 숨기고 `pipefail`이 없어 `wc -l`이 0을 냄 |
| `'체크('` (괄호 오타) | **0곳, 통과** | `grep: parentheses not balanced`, 종료 코드 2. 위와 같음 |

예전 IN-07이 짚은 위험(두 목록 가운데 한쪽만 고침)은 막는 쪽(fail-closed)이었습니다. 이번 것은 반대로 통과시키는 쪽(fail-open)입니다. pre-push 훅이 U10(포인트·굿즈·코스북 제거)을 지키는 장치는 이것 하나뿐이고, 고장 나도 아무 메시지가 없습니다. 고치기 전의 리터럴 패턴은 형식이 틀릴 수 없어서 이 위험이 없었습니다. `index.html`이 없을 때도 종료 코드 2가 나지만, 그 경우는 3번 항목이 「문서가 없습니다」로 막으므로 여기서 다루지 않습니다.
**Fix:** 변수 형식을 먼저 확인하고, grep의 종료 코드 2(오류)를 실패로 다룹니다. 아래 코드는 위 네 값으로 `bash`에서 시험했습니다. 지금 값에서는 3곳을 세고, 나머지 세 값은 실패로 멈춥니다.
```bash
# 허용 낱말(「○○포인트」)의 앞부분은 U10_ALLOW_PREFIX 한 곳에만 둔다. 잡는 쪽과 빼는 쪽이 이 값을 함께 쓴다.
# 비우거나 빈 항목(||, 끝의 |)·괄호를 넣으면 점검이 무력해지므로 막는다. 예외를 모두 없애려면 이 항목의 grep 두 줄을 단순한 형태로 바꾼다.
U10_ALLOW_PREFIX='체크|엔드'
case "|${U10_ALLOW_PREFIX}|" in *'||'*|*'('*|*')'*) fail "U10_ALLOW_PREFIX 형식이 잘못되었습니다: '${U10_ALLOW_PREFIX}'" ;; esac
u10_hits=$(grep -o -E "(${U10_ALLOW_PREFIX})?포인트|굿즈|코스북" "$DEST/index.html"); u10_rc=$?
if [ "$u10_rc" -gt 1 ]; then
    problem "점검 6번 grep이 실패했습니다 (종료 코드 ${u10_rc})"
else
    u10=$(printf '%s\n' "$u10_hits" | grep -v -x -E "(${U10_ALLOW_PREFIX})포인트" | grep -c .)
    [ "${u10:-0}" -eq 0 ] || problem "랜딩에 출시 범위 밖 기능 이름이 있습니다: /index.html ${u10}곳 (포인트·굿즈·코스북, U10)"
fi
```
고친 뒤에는 수정 보고서의 「일부러 깨뜨린 트리」 시험을 다시 하고, `U10_ALLOW_PREFIX='체크|'`로 바꾼 상태에서도 `scripts/check-site.sh`가 실패하는지 확인합니다.

## Info

### IN-09: `.claude/CLAUDE.md`의 `<head>` 순서 설명이 같은 파일의 고정점 표, 그리고 실제 `index.html`과 반대임 (이번 범위 전부터 있던 것)

**File:** `.claude/CLAUDE.md:213-217` (원본 `.planning/codebase/CONVENTIONS.md:118-122`), 비교 대상 `.claude/CLAUDE.md:296`, `index.html:21-25`
**Issue:** 「Order (`<head>`)」 절은 meta → 첫 그리기 전 실행 스크립트(`rp-pin` 판정) → `{% include head-links.html %}` → `<style>` 순서라고 적습니다. 실제 `index.html`은 `:21`에 `{% include head-links.html %}`, `:22-25`에 `rp-pin` 스크립트가 있습니다. include가 먼저입니다. 이번 범위에서 IN-08로 고친 고정점 표(`:296`)는 「`{% include head-links.html %}` 다음」이라고 맞게 적었습니다. 그래서 한 파일 안에서 두 설명이 서로 어긋납니다. 이 절은 `7e0c426`(코드베이스 분석 문서를 처음 넣은 커밋)부터 있었고, 이번 범위에서 생긴 것은 아닙니다. 동작에는 영향이 없습니다. 다만 다음 단계가 이 절을 보고 `<head>`를 고치면 include와 스크립트의 순서가 바뀔 수 있습니다.
**Fix:** `.claude/CLAUDE.md`의 이 구간은 생성 구간이라 직접 고치지 않습니다. 원본 `.planning/codebase/CONVENTIONS.md:121-122`의 두 줄 순서를 바꿉니다 (`{% include head-links.html %}` → 첫 그리기 전 실행 스크립트). 그 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 다시 만듭니다.

### IN-10: 「코스 그리기」 목업의 거리 표기 `7.84 km`가 앱 「코스 그리기」 화면의 소수 한 자리 표기와 다를 수 있음 (확인되지 않음)

**File:** `index.html:286`
**Issue:** 목업은 앱 화면을 흉내 냅니다. 바꾸기 전에는 「코스 그리기」 화면이 `8.3 km`(소수 한 자리), 결과 화면이 `8.30 km`(소수 두 자리)였습니다. 같은 페이지의 실제 캡처도 「코스 그리기」 화면을 `6.5 km`로, 소수 한 자리로 보여 줍니다. IN-06 수정은 세 곳을 모두 `7.84 km`로 바꿨습니다. 그래서 「코스 그리기」 목업만 앱의 표기 방식과 달라졌을 수 있습니다. 수정 보고서는 「사용자가 준 그대로 `7.84 km`이고 `7.8`로 줄이지 않았습니다」라고 적었습니다. 이것이 사용자가 표기까지 정한 것인지, 수정한 쪽의 판단인지는 기록만으로 알 수 없습니다. 근거가 캡처 한 장뿐이라 Info로 둡니다.
**Fix:** WR-02에서 앱 화면을 확인할 때 강아지런 「코스 그리기」 화면의 거리 표기도 함께 봅니다. 앱이 `7.8 km`로 보여 주면 `:286`만 `7.8 km`로 바꿉니다. `:353`(결과 화면)과 `:379`(「달려 보기」 딱지), `KM` 상수는 그대로 둡니다.

---

_Reviewed: 2026-11-18T13:24:24Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
