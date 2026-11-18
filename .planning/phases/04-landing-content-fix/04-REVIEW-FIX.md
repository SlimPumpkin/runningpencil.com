---
phase: 04-landing-content-fix
fixed_at: 2026-11-18T13:51:59Z
review_path: .planning/phases/04-landing-content-fix/04-REVIEW.md
iteration: 1
findings_in_scope: 4
fixed: 4
skipped: 0
status: all_fixed
---

# Phase 4: Code Review Fix Report (세 번째 검토 수정)

**Fixed at:** 2026-11-18T13:51:59Z
**Source review:** .planning/phases/04-landing-content-fix/04-REVIEW.md (세 번째 검토, WR-02·WR-03·IN-09·IN-10)
**Iteration:** 1

**Summary:**
- Findings in scope: 4 (fix_scope: all, WR-02·WR-03·IN-09·IN-10)
- Fixed: 4 (WR-02, WR-03, IN-09, IN-10)
- Skipped: 0

이 파일은 재검토의 수정 보고서(IN-06~IN-08)를 덮어씁니다. 그 보고서는 `cd25998`에 커밋되어 있습니다.

**작업 위치:** `workflow.use_worktrees=false`라서 worktree를 만들지 않고 메인 체크아웃(`main`)에서 고치고 커밋했습니다. 아래 확인 명령(`scripts/check-site.sh`, grep, 일부러 깨뜨린 트리 시험)도 모두 메인 체크아웃에서 돌렸습니다. push는 하지 않았습니다. 커밋은 `gsd_run query commit`이 아니라 `git commit <경로>`로 했습니다. 오케스트레이터가 지정한 두 줄(Co-Authored-By, Claude-Session)을 메시지 끝에 붙이고, 그 finding의 파일만 커밋에 넣기 위해서입니다. 커밋은 finding마다 하나씩, 모두 4개입니다. IN-09는 문서만 바꾸므로 `fix(04)` 대신 `docs(04)` prefix를 썼습니다.

**적용 순서:** WR-02 → WR-03 → IN-09 → IN-10입니다. WR-02와 IN-10은 `index.html`의 이웃한 두 줄(`:287`, `:286`)을 고치지만 내용 변경 두 건이라 커밋을 나눴습니다. 두 커밋 모두 같은 줄 안의 값만 바꾸고 줄 수는 그대로라서 고정점과 줄 번호에 영향이 없습니다.

**최종 확인:** 모든 커밋 뒤 `scripts/check-site.sh HEAD` → `check-site: 통과 (커밋 3289fc3db4d8, jekyll 3.10.0)`. 커밋마다 그 전에 `scripts/check-site.sh`(작업 트리)를 돌렸고 모두 통과했습니다. 작업 트리에는 커밋하지 않은 이 보고서 파일 말고 변경이 없습니다.

## Fixed Issues

### WR-02: 「코스 그리기」 목업의 걷기·달리기·자전거 예상 시간이 옛 거리 8.3 km 기준으로 남음

**Files modified:** `index.html`
**Commit:** 215fa7e
**Status:** fixed: requires human verification (화면에 보이는 숫자 변경이라 눈으로 한 번 확인할 것)
**값의 출처:** 사용자가 2026-11-18에 보낸 앱 강아지런 **코스 상세** 화면 캡처의 값 `104분 · 67분 · 31분`(걷기 · 달리기 · 자전거)입니다. 캡처는 오케스트레이터가 전해 준 값이고 이 실행에서 직접 보지는 않았습니다. 앱 코드는 이 실행에서 직접 읽어 확인했습니다 (앱 저장소 `~/dv/woody/running_pencil`, HEAD `3afb2085`, 읽기만 하고 고치지 않음).
- 예상 시간: `lib/shared/format/course_display_format.dart:98`이 `packages/geo/lib/course_pace.dart:36`의 `estimateMinutes(원 거리 미터, 속도)`를 부릅니다. 계산은 `(m * 60 / (속도 * 1000)).round()`(half-up)이고, 속도는 `kWalkSpeedKmh = 4.5`, `kRunSpeedKmh = 7.0`, `kBikeSpeedKmh = 15.0`입니다.
- 「코스 그리기」 화면도 `lib/features/editor/presentation/_widgets/editor_info_strip.dart:95,98`에서 같은 `formatCourseDistance` + `CourseEstimateLine`을 씁니다 (D-16 「만들 때 본 숫자 = 목록 숫자」).

**104분인 이유 (105분이 아님):** REVIEW.md는 7.84 km로 계산해 걷기가 104.53분(반올림하면 105분)이라고 적었습니다. 그런데 7.84 km는 달리기 결과 화면의 측정 거리이고(IN-10), 예상 시간은 코스의 원 거리 미터로 계산합니다. 위 앱 공식으로 원 거리 7,700~7,900 m를 1 m씩 돌려 보면, 표시 `7.8 km`·걷기 104분·달리기 67분·자전거 31분이 함께 나오는 범위는 **7,763~7,837 m**(75개 값)입니다. 그래서 「7.84 km인데 105분이어야 한다」는 지적은 맞지 않고, 캡처의 104분은 앱 공식과 어긋나지 않습니다. 사이트 목업이 쓰는 `KM = 7.84`(달리기 거리)와 코스 표시 7.8 km·예상 시간은 서로 다른 거리에서 나온 값입니다.
**Applied fix:** `index.html:287`의 숫자 세 개만 `111분`→`104분`, `71분`→`67분`, `33분`→`31분`으로 바꿨습니다. 마크업은 그 밖에 바이트 단위로 같습니다 (`git diff --word-diff=porcelain`에서 바뀐 낱말은 숫자 세 개뿐).
**재발 방지 확인:** REVIEW.md가 짚은 대로 값 목록 정규식에 「분」을 더해 파일 전체를 다시 훑었습니다.
`grep -n -o -E '[0-9]+(\.[0-9]+)? ?km|[0-9]+:[0-9]{2}(:[0-9]{2})?|[0-9]+ ?%|[0-9]+ ?분' index.html` → 「코스 그리기」 목업 `:286` 7.8 km(IN-10 뒤), `:287` 104분·67분·31분, 「세 가지 이유」 진행 `:330` 62 %·`:333` 37:16·`:334` 4.86 km, 결과 화면 `:351` 1:02:40·`:352` 1:00:06·`:353` 7.84 km, 「달려 보기」 딱지 `:379` 7.84 km, 시작 전 값 `:402-404`, 실제 캡처 alt `:419` 6.5 km·`:423` 16:08·1.34 km. 거리에서 나오는 값 가운데 옛 거리 기준으로 남은 것은 없습니다.
REVIEW.md의 「검증 정규식에 `[0-9]+ ?분`을 더한다」는 추적되는 문서에 고칠 곳이 없었습니다. `grep -rn -E '111분|71분|33분|\?%|U10_ALLOW_PREFIX| \?분' .planning/codebase CLAUDE.md .claude/CLAUDE.md`는 아무것도 찾지 않았습니다. 그 정규식은 이전 수정 보고서(`cd25998`)에만 있었고, 이번 보고서는 위처럼 「분」을 더한 정규식을 씁니다.

### WR-03: `U10_ALLOW_PREFIX`를 비우거나 형식을 틀리면 점검 6번이 조용히 통과함 (fail-open)

**Files modified:** `scripts/check-site.sh`
**Commit:** 8cc86fd
**Status:** fixed
**Applied fix:** REVIEW.md의 수정안을 거의 그대로 넣었습니다 (`scripts/check-site.sh:96-107`).
- `case "|${U10_ALLOW_PREFIX}|" in *'||'*|*'('*|*')'*)`로 빈 값·빈 항목·괄호를 먼저 막고, 걸리면 `fail`로 메시지를 내고 멈춥니다.
- 첫 grep의 `2>/dev/null`을 지우고 종료 코드를 `u10_rc`로 따로 받습니다. 2 이상이면 `problem`으로 실패를 셉니다. 그래서 `case`가 못 막는 다른 정규식 오류(예: `[`)도 grep 오류 메시지와 함께 실패합니다. 메시지에는 종료 코드와 지금 값을 함께 적었습니다.
- 개수는 `wc -l | tr -d ' '` 대신 `grep -c .`로 셉니다. 찾은 것이 없으면 `printf '%s\n' ""`가 빈 줄 하나를 내고 `grep -c .`는 0을 냅니다 (종료 코드 1이지만 `set -e`가 없고 출력 `0`을 그대로 씁니다).
- 주석은 한국어로 두 줄 더했고(형식 제한, 종료 코드 의미), 4칸 들여쓰기와 bash 3.2 문법(`case`, `$?`)만 썼습니다. `/bin/bash -n scripts/check-site.sh` 통과.

**시험 (모두 메인 체크아웃, `/bin/bash` 3.2.57, macOS `/usr/bin/grep`).** `#!/usr/bin/env bash`가 이 환경에서 `/bin/bash`를 찾으므로 1번은 두 가지로 돌렸습니다. 3~6번은 작업 트리의 스크립트를 고치지 않고, 임시 폴더(`mktemp -d`)에 `U10_ALLOW_PREFIX=` 줄만 바꾼 사본을 만들어 저장소 안에서 `/bin/bash <사본>`으로 돌렸습니다 (사본은 `git rev-parse --show-toplevel`로 이 저장소의 작업 트리를 빌드합니다). 시험 뒤 임시 폴더를 지웠습니다.

| # | 상태 | 명령 | 결과 |
|---|---|---|---|
| 1 | 깨끗한 작업 트리, 지금 값 `'체크\|엔드'`. 랜딩 출력에 해당 낱말이 0곳이라 첫 grep 종료 코드 1, `grep -c .` 종료 코드 1·출력 0인 경로 | `scripts/check-site.sh`, `/bin/bash scripts/check-site.sh` | 둘 다 `check-site: 통과 (작업 트리, jekyll 3.10.0)`, exit 0 |
| 2 | 일부러 깨뜨린 트리: `index.html`의 `<body id="top">` 다음에 `<p>포인트 체크포인트</p>`를 임시로 넣음, 지금 값 `'체크\|엔드'` | `scripts/check-site.sh` | `check-site: 랜딩에 출시 범위 밖 기능 이름이 있습니다: /index.html 1곳 (포인트·굿즈·코스북, U10)` → `check-site: 실패 — 1건 (작업 트리)`, exit 1. 맨 「포인트」 1곳만 세고 「체크포인트」는 뺐습니다. 시험 뒤 `git checkout -- index.html`, `git diff --quiet index.html` 확인 |
| 3 | `U10_ALLOW_PREFIX=''` | `/bin/bash <사본>` | `check-site: 실패 — U10_ALLOW_PREFIX 형식이 잘못되었습니다: ''`, exit 1 |
| 4 | `U10_ALLOW_PREFIX='체크\|'` | `/bin/bash <사본>` | `check-site: 실패 — U10_ALLOW_PREFIX 형식이 잘못되었습니다: '체크\|'`, exit 1 |
| 5 | `U10_ALLOW_PREFIX='체크('` | `/bin/bash <사본>` | `check-site: 실패 — U10_ALLOW_PREFIX 형식이 잘못되었습니다: '체크('`, exit 1 |
| 6 (추가) | `U10_ALLOW_PREFIX='체크['` (`case`가 막지 않는 정규식 오류, 종료 코드 2 경로) | `/bin/bash <사본>` | `grep: brackets ([ ]) not balanced` → `check-site: 점검 6번 grep이 실패했습니다 (종료 코드 2, U10_ALLOW_PREFIX='체크[')` → `check-site: 실패 — 1건 (작업 트리)`, exit 1 |

어느 경우도 조용히 통과하지 않습니다. 커밋 전 `git status --short`는 `scripts/check-site.sh` 하나만 바뀐 상태였고, 임시 변경은 커밋에 들어가지 않았습니다.

### IN-09: `.claude/CLAUDE.md`의 `<head>` 순서 설명이 같은 파일의 고정점 표, 그리고 실제 `index.html`과 반대임 (이번 범위 전부터 있던 것)

**Files modified:** `.planning/codebase/CONVENTIONS.md` (원본), `.claude/CLAUDE.md` (재생성)
**Commit:** a6a8aa5
**Status:** fixed
**Applied fix:** `.claude/CLAUDE.md`는 직접 고치지 않았습니다. 원본 `.planning/codebase/CONVENTIONS.md`의 「Order (`<head>`)」 절에서 두 줄 순서를 바꿔 meta → `{% include head-links.html %}` → 첫 그리기 전 실행 스크립트(`rp-pin` 판정) → `<style>`로 적었습니다. 실제 `index.html:21`(include) → `:22-25`(`rp-pin` 스크립트)와 같습니다. 그 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 다시 만들었습니다 (`Generated 5/6 sections. Fallback: skills.`).
**확인:**
- 재생성 뒤 `git diff .claude/CLAUDE.md`는 `:216-217`의 두 줄이 자리를 바꾼 것뿐입니다 (1 insertion, 1 deletion). 다른 구간은 바뀌지 않았습니다.
- 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`의 「이번 마일스톤 방침」 구간(제목부터 다음 `## ` 제목이나 `<!-- GSD:` 표지 앞까지, 30줄)을 `diff`로 비교했고 같습니다. 루트 `CLAUDE.md`는 바뀌지 않았습니다.

### IN-10: 「코스 그리기」 목업의 거리 표기 `7.84 km`가 앱 「코스 그리기」 화면의 소수 한 자리 표기와 다를 수 있음 (확인되지 않음)

**Files modified:** `index.html`
**Commit:** 3289fc3
**Status:** fixed: requires human verification (화면에 보이는 숫자 변경이라 눈으로 한 번 확인할 것)
**값의 출처:** 더는 「확인되지 않음」이 아닙니다. 사용자가 2026-11-18에 보낸 앱 캡처 두 장으로 정해졌습니다. 강아지런 **코스 상세** 화면은 `7.8 km`, **달리기 결과** 화면은 `7.84 km`(총 시간 1:39:28, 움직인 시간 1:39:12, 평균 페이스 12'40"/km)를 보여 줍니다. 캡처는 오케스트레이터가 전해 준 값이고, 앱 코드(HEAD `3afb2085`)는 이 실행에서 직접 읽어 확인했습니다. 코스 화면은 `lib/shared/format/course_display_format.dart`의 `formatCourseDistance`(10 m 단위로 반올림한 뒤 km 소수 한 자리)를 쓰고, 「코스 그리기」 화면도 `editor_info_strip.dart:95`에서 같은 함수를 씁니다. 결과 화면은 `lib/shared/format/run_display_format.dart`의 `formatRunDistance`(소수 두 자리)로 그 달리기의 측정 거리를 보여 줍니다. 그래서 `7.84 km`는 달리기 거리이고, 코스 자체는 `7.8 km`로 보입니다.
**Applied fix:** `index.html:286`(「코스 그리기」 목업)만 `7.84 km`→`7.8 km`로 바꿨습니다. `:353`(결과 화면 목업, 앱 결과 화면이 실제로 `7.84 km`), `:379`(「달려 보기」 딱지), `:479` `var KM = 7.84;`는 그대로 두었습니다 (`grep -n -F '7.84' index.html` → 353, 379, 479).
**참고:** 결과 화면 목업의 시간(`:351` 1:02:40, `:352` 1:00:06)은 이번 범위가 아니라서 그대로 두었습니다. 사용자 캡처의 실제 기록(1:39:28, 1:39:12)과는 다릅니다. 「움직인 시간」 1:00:06은 `KM` 상수 × 460초/km에서 나오는 값이고, 「총 시간」 1:02:40은 계산식이 없는 목업 값입니다 (움직인 시간 + 154초). REVIEW.md는 둘 다 결함으로 올리지 않았습니다.

---

_Fixed: 2026-11-18T13:51:59Z_
_Fixer: Claude (gsd-code-fixer)_
_Iteration: 1_
