---
phase: 04-landing-content-fix
fixed_at: 2026-11-18T09:30:31Z
review_path: .planning/phases/04-landing-content-fix/04-REVIEW.md
iteration: 1
findings_in_scope: 3
fixed: 3
skipped: 0
status: all_fixed
---

# Phase 4: Code Review Fix Report (재검토 수정)

**Fixed at:** 2026-11-18T09:30:31Z
**Source review:** .planning/phases/04-landing-content-fix/04-REVIEW.md (재검토, IN-06~IN-08)
**Iteration:** 1

**Summary:**
- Findings in scope: 3 (fix_scope: all, IN-06·IN-07·IN-08)
- Fixed: 3 (IN-06, IN-08, IN-07)
- Skipped: 0

이 파일은 첫 리뷰의 수정 보고서(WR-01, IN-01~IN-05)를 덮어씁니다. 그 보고서는 `8938727`에 커밋되어 있고, 처리 결정은 `04-REVIEW-DISPOSITION.md`에 남아 있습니다.

**작업 위치:** `workflow.use_worktrees=false`라서 worktree를 만들지 않고 메인 체크아웃(`main`)에서 고치고 커밋했습니다. 아래 확인 명령(`scripts/check-site.sh`, grep, node 계산)도 모두 메인 체크아웃에서 돌렸습니다. push는 하지 않았습니다. 커밋은 `gsd_run query commit`이 아니라 `git commit <경로>`로 했습니다. 오케스트레이터가 지정한 두 줄(Co-Authored-By, Claude-Session)을 메시지 끝에 붙이기 위해서입니다. 3건을 고쳤고 커밋은 5개입니다. IN-06은 내용 커밋과 문서 커밋으로 나눴고, IN-08은 고정점 일부를 grep으로 찾히게 다듬는 후속 커밋이 하나 더 있습니다. IN-07은 동작을 바꾸지 않는 정리라서 `fix(04)` 대신 `refactor(04)` prefix를 썼습니다. 에이전트 규칙의 `fix({phase}): {id}` 형식과 다릅니다.

**적용 순서:** IN-06 → IN-08 → IN-07입니다. IN-07은 necessity finding이라 마지막에 했습니다. IN-06은 같은 줄 안의 값만 바꾸고 줄 수(622)는 그대로이므로 IN-08의 고정점에 영향을 주지 않습니다.

**최종 확인:** 모든 커밋 뒤 `scripts/check-site.sh HEAD` → `check-site: 통과 (커밋 dd0c710d1597, jekyll 3.10.0)`. 작업 트리에는 커밋하지 않은 이 보고서 파일 말고 변경이 없습니다.

## Fixed Issues

### IN-06: 코스 이름을 「강아지런」으로 맞춘 뒤, 목업의 8.3 km가 같은 페이지 캡처의 숫자와 다름 (확인되지 않음)

**Files modified:** `index.html` (내용 커밋), `.planning/codebase/CONVENTIONS.md`·`ARCHITECTURE.md`·`TESTING.md`·`.claude/CLAUDE.md` (재생성) (문서 커밋)
**Commit:** db064f3 (index.html), 9530f10 (문서)
**Status:** fixed: requires human verification (화면에 보이는 숫자 변경이라 눈으로 한 번 확인할 것)
**값의 출처:** 강아지런의 거리 7.84 km는 사용자가 2026-11-18에 직접 확인한 값입니다. REVIEW.md에는 「확인되지 않음」으로 적혀 있지만, 이 확인으로 값이 정해졌습니다. 표기는 사용자가 준 그대로 `7.84 km`이고 `7.8`로 줄이지 않았습니다.
**Applied fix:** 거리와 거기서 나오는 시간을 함께 바꿨습니다.

| 위치 | 바꾸기 전 | 바꾼 뒤 | 근거 |
|---|---|---|---|
| `:286` 목업 「코스 그리기」 | `8.3 km` | `7.84 km` | 사용자 확인값 |
| `:353` 목업 결과 거리 | `8.30 km` | `7.84 km` | 사용자 확인값 |
| `:379` 「달려 보기」 강아지런 딱지 | `8.3 km` | `7.84 km` | 사용자 확인값 |
| `:479` `var KM` | `8.3` | `7.84` | 사용자 확인값 (주석 열 위치는 그대로) |
| `:334` `#rp-run-dist` 정적 초기값 | `5.15 km` | `4.86 km` | `(7.84 × 0.62).toFixed(2)` |
| `:333` `#rp-run-time` 정적 초기값 | `39:27` | `37:16` | `clock(4.8608 × 460)` |
| `:352` 결과 「움직인 시간」 | `1:03:38` | `1:00:06` | `clock(7.84 × 460)` |
| `:351` 결과 「총 시간」 | `1:06:12` | `1:02:40` | 목업 값 (아래 참고) |

- 「총 시간」 `1:02:40`은 계산식이 없는 목업 값입니다. 기존 「총 시간 − 움직인 시간」 차이 154초를 그대로 두고 임의로 맞췄습니다 (3606초 + 154초).
- 그대로 둔 것: 평균 페이스 `7'40"/km`(`:335`, `:354`), `62 %`, 「달려 보기」 정적 표시 `00:00`·`0.00 km`(끝 시간은 JS가 `KM × 390`으로 계산해 `50:58`), 「실제 앱 화면」 캡처와 alt 문구(`:419`의 6.5 km, `:423`의 16%·1.34 km).
- 문서 커밋: 원본 `CONVENTIONS.md:35`, `ARCHITECTURE.md:88`, `TESTING.md:91`의 `KM = 8.3`을 `7.84`로 고치고 `generate-claude-md`로 `.claude/CLAUDE.md`를 다시 만들었습니다. 루트 `CLAUDE.md`에는 8.3이 없었습니다. `.planning/phases/` 아래 지난 기록은 고치지 않았습니다.
**확인:**
- 편집 전에 `index.html`의 거리·시간·퍼센트 리터럴을 모두 뽑아 분류했습니다 (`grep -n -o -E '[0-9]+(\.[0-9]+)? ?km|[0-9]+:[0-9]{2}(:[0-9]{2})?|[0-9]+ ?%'`). 위 표 말고 거리에서 나오는 정적 값은 없었습니다 (예: `53:57` 같은 값은 없음).
- 같은 계산을 바꾸기 전 값에 돌리면 원래 값(`5.15`, `39:27`, `1:03:38`)이 그대로 나와서 계산 방법이 맞다는 것을 확인했습니다.
- 편집한 `index.html`에서 `KM`, `clock()`, `--q1`을 직접 뽑아 node로 다시 계산했습니다. `runDist 4.86 km`, `runTime 37:16`, `62 %`, 움직인 시간 `1:00:06`, demo 끝 `50:58`이 나왔고, 정적 초기값 `#rp-run-dist`·`#rp-run-time`·`#rp-run-pct`와 같았습니다.
- `grep -n -E '(^|[^0-9.])8\.3([^0-9]|$)|8\.30|5\.15|39:27|1:03:38|1:06:12' index.html` → 0건 (exit 1). 모든 커밋 뒤 `git grep -n -E '(^|[^0-9.])8\.3([^0-9]|$)|5\.15|39:27|1:03:38|1:06:12' -- ':!.planning/phases'` → 0건 (exit 1). 옛 거리와 거기서 나온 값이 `.planning/phases` 밖 어디에도 남지 않았습니다.
- 커밋 전 `scripts/check-site.sh` → 통과. 줄 수 622 그대로.
- 생성기 멱등성: 고치기 전 깨끗한 트리에서 `generate-claude-md`를 돌려 diff가 비는 것을 확인했고, 고친 뒤 `.claude/CLAUDE.md` 변경은 KM 두 줄뿐이었습니다.

### IN-08: 줄 번호를 절대값으로 적는 방식이 남아 있어 다음 `index.html` 수정 때 다시 어긋남

**Files modified:** `.planning/codebase/ARCHITECTURE.md`, `.planning/codebase/CONVENTIONS.md`, `.claude/CLAUDE.md` (재생성)
**Commit:** 61391b3 (고정점으로 바꿈), dd0c710 (후속: grep -F로 찾히지 않던 고정점 4개 정리)
**Applied fix:** 원본 `ARCHITECTURE.md`에 있던 `index.html` 줄 번호를 모두(약 40개) 고정점으로 바꿨습니다. 고정점은 include 태그(`{% include footer.html %}` 등), 구획 머리 주석(`/* ── 랜딩 전용 ── */`, `// ── 연결 ──`), 함수 이름(`function paintStory()` 등), 요소 시작 태그(`<section id="story">`, `<body id="top">`)입니다. `CONVENTIONS.md:30`의 「약 464행」은 「`</body>` 앞 `<script>`」로 바꿨습니다. `ARCHITECTURE.md`의 System Overview 목록 끝에 위치 표기 규칙을 한 줄 더했습니다 (「`index.html` 안의 위치는 줄 번호 대신 고정점으로 적고 `grep -n -F`로 찾는다」). 처음에는 이 규칙을 표 앞 문단으로 넣었는데, 생성기가 일반 문단을 빼서 `.claude/CLAUDE.md`에 들어가지 않았습니다. 그래서 목록 항목으로 옮겼습니다. 그 뒤 `generate-claude-md`로 다시 만들었습니다.
- 「`rp-c-dog` 사용처」는 원래 번호 목록(`292,293,307,323,358`)이 실제 18곳 가운데 일부만 적고 있었습니다. 그래서 `grep -n -F 'href="#rp-c-dog"' index.html` 명령으로 바꿨습니다.
- 다른 파일을 가리키는 줄 번호(`_layouts/legal.html:14/16/18/23/40`, `_includes/css/legal.css:5/9`, `_includes/header.html:5`, `_includes/footer.html:7`)는 이 finding의 대상이 아니라서 그대로 두었습니다. 위치 표기 규칙 문장에도 그렇게 적었습니다.
- **남겨 둔 것:** `.planning/codebase/STRUCTURE.md`(`:21`~`:464` 등)와 `CONCERNS.md`(`index.html:428-573` 등, 일부는 이미 낡음)에도 `index.html` 줄 번호가 있습니다. 이 둘은 `.claude/CLAUDE.md`를 만드는 원본이 아니고 이 finding에 들어 있지 않습니다. 첫 수정 때처럼 deferred로 두었습니다. `deferred-items.md`에서 지금 open인 CONCERNS 항목은 줄 번호가 아니라 랜딩 크기·줄 수(「72KB, 586줄」)에 관한 것이라, 이 줄 번호들은 따로 기록되어 있지 않습니다.
**확인:**
- 커밋된 원본에서 더한 줄의 백틱 문자열을 모두 뽑아 `grep -c -F`로 `index.html`에서 셌습니다. 처음 커밋(61391b3)에는 실제 줄과 글자가 달라 0건이 나오는 고정점이 4개 있었습니다: `<section id="story">`(2곳), `<path id="rp-c-dog" pathLength="1000">`, `window.addEventListener('scroll', …)`, `window.addEventListener('load', …)`. 후속 커밋(dd0c710)에서 실제 줄 앞부분(`<section id="story"`, `window.addEventListener('scroll'` 등)으로 바꿨고, 지금은 각각 1건입니다. 위치를 가리키는 다른 고정점도 모두 1건입니다. 여러 번 나오는 것은 묶음으로 가리킨다고 문장에 적었습니다: `.rp-pin .rp-scrolly` 규칙들, `story.style.setProperty` 세 줄, `pauseAnimations()` 두 줄. `html.rp-ready`는 두 규칙(smooth, reduced-motion의 auto)이 있어서 `html.rp-ready { scroll-behavior: smooth; }` 전체를 적었습니다.
- `grep -n -E 'index\.html:[0-9]|약 [0-9]+행'` → `ARCHITECTURE.md`, `CONVENTIONS.md`, `.claude/CLAUDE.md`, 루트 `CLAUDE.md`에서 0건.
- `.claude/CLAUDE.md`의 변경 hunk는 모두 132~419행에 있습니다. 이 범위는 conventions·architecture 생성 구간(109~427행)이고, skills·workflow·profile 구간에는 변경이 없습니다.
- 「이번 마일스톤 방침」 구간(제목부터 「마지막 규칙(데이터 목록)…」 문단까지 29줄)을 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`에서 뽑아 `diff`했습니다. 두 커밋 뒤 모두 차이가 없습니다.

### IN-07: Generality without instantiation — 점검 6번 항목의 허용 목록 `체크포인트|엔드포인트`가 지금 랜딩에 없는 낱말만 거름

**Files modified:** `scripts/check-site.sh`
**Commit:** 8432d96
**Status:** fixed: requires human verification (necessity finding. 고른 방법을 사람이 확인할 것)
**Applied fix:** REVIEW.md의 두 방법 가운데 (나)를 골랐습니다. 허용 접두어를 변수 `U10_ALLOW_PREFIX='체크|엔드'` 하나에 두고, 잡는 grep(`"(${U10_ALLOW_PREFIX})?포인트|굿즈|코스북"`)과 빼는 grep(`"(${U10_ALLOW_PREFIX})포인트"`)이 함께 씁니다. 두 목록이 어긋나는 문제를 이렇게 없앴습니다. 주석도 「두 곳에 함께 더한다」에서 「`U10_ALLOW_PREFIX` 한 곳에만 둔다」로 바꿨습니다.
**(나)를 고른 이유:** (가)는 허용 목록을 빼서 단순한 형태로 되돌리는 방법입니다. 그러면 「체크포인트」가 다시 걸립니다. 첫 리뷰의 IN-01은 바로 그 오탐을 고친 것이고 `04-REVIEW-DISPOSITION.md`에 `fixed`로 기록되어 있습니다. 재검토도 그 결정을 뒤집으려는 것이 아니라고 적었습니다. (나)는 동작을 바꾸지 않고, 이 finding이 짚은 실제 위험(두 목록 중 한쪽만 고침)만 없앱니다. 동작이 같으므로 CLAUDE.md와 원본 문서의 점검 설명(「랜딩 출력에 포인트·굿즈·코스북 없음」)은 고칠 것이 없습니다.
**확인 (양쪽):**
- `bash -n scripts/check-site.sh` 통과.
- 동작이 같은지: 재검토가 쓴 시험 줄 7개(`체크포인트 와 포인트`, `엔드포인트`, `굿즈 코스북`, `포인트포인트`, `체크포인트체크포인트`, `API 엔드 포인트`, `체크포인트`)와 허용 낱말만 있는 파일, 빈 파일로 시험했습니다. `/usr/bin/grep`(BSD)으로 고치기 전과 뒤 파이프라인을 `LC_ALL=C`, `en_US.UTF-8`, `ko_KR.UTF-8`에서 돌렸고 결과가 모두 같았습니다 (6 / 0 / 0).
- 정상 트리: `scripts/check-site.sh` → `check-site: 통과 (작업 트리, jekyll 3.10.0)`.
- 일부러 깨뜨린 트리: 랜딩 `<main>` 바로 뒤에 `<p>포인트 굿즈 코스북 체크포인트</p>`를 임시로 넣고 `LC_ALL=C scripts/check-site.sh`를 돌렸습니다. 결과는 `랜딩에 출시 범위 밖 기능 이름이 있습니다: /index.html 3곳 (포인트·굿즈·코스북, U10)`, `실패 — 1건`, exit 1입니다. 6번 항목에서 실패했고 빌드 실패는 아닙니다. 「체크포인트」는 세지 않았습니다. 이 시험은 IN-06 커밋 뒤에 했고, 끝난 뒤 `git checkout -- index.html`로 되돌렸습니다. `git diff --quiet index.html`로 되돌린 것을 확인했습니다.
- 커밋 뒤 `scripts/check-site.sh HEAD` → 통과.

---

_Fixed: 2026-11-18T09:30:31Z_
_Fixer: Claude (gsd-code-fixer)_
_Iteration: 1_
