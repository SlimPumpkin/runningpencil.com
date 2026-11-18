---
phase: 04-landing-content-fix
fixed_at: 2026-11-18T14:39:40Z
review_path: .planning/phases/04-landing-content-fix/04-REVIEW.md
iteration: 1
findings_in_scope: 3
fixed: 3
skipped: 0
status: all_fixed
---

# Phase 4: Code Review Fix Report (네 번째 검토 수정)

**Fixed at:** 2026-11-18T14:39:40Z
**Source review:** .planning/phases/04-landing-content-fix/04-REVIEW.md (네 번째 검토, WR-04·IN-11·IN-12)
**Iteration:** 1

**Summary:**
- Findings in scope: 3 (fix_scope: all, WR-04·IN-11·IN-12)
- Fixed: 3 (WR-04, IN-11, IN-12)
- Skipped: 0

이 파일은 세 번째 검토의 수정 보고서(WR-02·WR-03·IN-09·IN-10)를 덮어씁니다. 그 보고서는 `450ccb9`에 커밋되어 있습니다.

**작업 위치:** `workflow.use_worktrees=false`라서 worktree를 만들지 않고 메인 체크아웃(`main`)에서 고치고 커밋했습니다. 아래 확인 명령(`scripts/check-site.sh`, grep, 임시 사본 시험)도 모두 메인 체크아웃에서 돌렸습니다. push는 하지 않았습니다. 커밋은 `gsd_run query commit`이 아니라 `git commit -F <메시지 파일> -- <경로>`로 했습니다. 한국어 본문과 지정된 두 줄(Co-Authored-By, Claude-Session)을 메시지 끝에 붙이고, 그 커밋의 파일만 넣기 위해서입니다.

**커밋 수:** finding 3건에 커밋 4개입니다. 사용자 결정(WR-04는 `:379` 내용 변경 커밋 하나로 하고, `KM` 주석 정리는 코드 정리라 따로 커밋)에 따라 WR-04를 두 커밋으로 나눴습니다. 주석 커밋은 내용·시각 변경이 아니므로 `refactor(04)` prefix를 썼습니다. 같은 파일을 고치는 두 쌍(WR-04의 두 커밋은 `index.html`, IN-11·IN-12는 `scripts/check-site.sh`)은 하나를 고치고 점검하고 커밋한 뒤 다음 것을 고쳤으므로 서로 섞이지 않았습니다. 커밋마다 `git show --stat`으로 파일 하나·바뀐 줄 수를 확인했습니다.

**최종 확인:** 커밋마다 그 전에 `scripts/check-site.sh`(작업 트리)를 돌렸고 모두 통과했습니다. 네 커밋 뒤 `scripts/check-site.sh HEAD` → `check-site: 통과 (커밋 0cb4d4ed0d4c, jekyll 3.10.0)`. 작업 트리에는 커밋하지 않은 이 보고서 파일 말고 변경이 없습니다.

## Fixed Issues

### WR-04: 「달려 보기」 코스 딱지가 같은 강아지런 코스를 `7.84 km`로 표기해, `7.8 km`로 고친 「코스 그리기」 목업과 같은 페이지 안에서 다름

**Files modified:** `index.html`
**Commit:** 66a1b64 (`:379` 딱지 거리, 내용 변경), 42bed15 (`:479` `KM` 주석, 코드 정리)
**Status:** fixed: requires human verification (화면에 보이는 숫자 변경이라 눈으로 한 번 확인할 것)
**결정:** 사용자가 이번 실행에서 「"7.8km" 로 고쳐」라고 정했습니다. 표기는 같은 페이지 `:286`과 똑같이 숫자와 km 사이에 공백 한 칸(`7.8 km`)을 둡니다.
**Applied fix:**
- `66a1b64`: `index.html:379` 「달려 보기」 강아지런 딱지의 `<span style="font-weight: 500">7.84 km</span>`만 `7.8 km`로 바꿨습니다. 1줄 변경입니다. REVIEW.md 예시의 `<!-- … -->` HTML 주석은 넣지 않았습니다.
- `42bed15`: `index.html:479`의 주석만 `// 강아지런 거리` → `// 강아지런을 한 번 달린 측정 거리 (앱의 코스 표기는 7.8 km)`로 바꿨습니다. 값 `7.84`와 주석 시작 열은 그대로입니다.

**그대로 둔 것:** `var KM = 7.84;`의 값, `:353` 결과 화면의 `7.84 km`, `#rp-demo-dist`·`#rp-run-dist` 애니메이션은 달리기 측정 거리라 바꾸지 않았습니다. `grep -n -F '7.84' index.html` → `:353`, `:479`만 남습니다. `:286`과 `:379`는 둘 다 `7.8 km`입니다. `.claude/CLAUDE.md`·`.planning/codebase/*.md`의 `KM = 7.84` 언급은 값이 그대로라 고치지 않았습니다. `grep -rn '강아지런 거리' CLAUDE.md .claude/CLAUDE.md .planning/codebase/`로 옛 주석을 인용한 문서가 없는 것도 확인했습니다.

### IN-11: `U10_ALLOW_PREFIX` 형식 확인이 막을 값을 나열하는 방식이라, `.`·`.*`·`^`·`$` 같은 메타문자는 오류 없이 점검 6번을 무력화함

**Files modified:** `scripts/check-site.sh`
**Commit:** 301f862
**Status:** fixed
**Applied fix:** REVIEW.md의 수정안대로, 막을 값을 나열하지 않고 허용할 모양만 받습니다 (`scripts/check-site.sh:97-101`).
- `case "|${U10_ALLOW_PREFIX}|" in *'||'*)` — 빈 값과 빈 항목(`||`, 앞뒤의 `|`)을 막습니다. 괄호 패턴은 다음 줄이 덮으므로 뺐습니다.
- `case "${U10_ALLOW_PREFIX//|/}" in *[[:punct:][:space:]]*)` — `|`를 뺀 나머지에 구두점이나 공백이 하나라도 있으면 막습니다.
- `:97` 주석을 두 줄로 고쳐 새 규칙(구두점·공백 없는 낱말을 `|`로 이은 모양만 받는다, 그 밖의 값은 정규식 뜻이 바뀌어 점검이 무력해진다)을 적었습니다. 종료 코드 2 처리는 그대로 두었습니다.

**시험 (메인 체크아웃, `/bin/bash` 3.2.57, macOS `/usr/bin/grep`):**

| # | 상태 | 결과 |
|---|---|---|
| 1 | 두 `case` 줄만 떼어 낸 시험 스크립트를 `LC_ALL=C`, `ko_KR.UTF-8`, `en_US.UTF-8`로 돌림. `env -i`(로캘 없음)로도 돌렸지만 출력 앞 세 줄(통과 값 세 개)만 확인함 | 세 로캘 모두 결과가 같았고, `env -i`에서도 통과 값 세 개는 통과했습니다. 통과: `체크\|엔드`(지금 값), `체크`, `체크\|엔드\|키`. 막힘: `''`·`'체크\|'`·`'\|체크'`·`'체크\|\|엔드'`·`'체크('`·`'체크)'`·`.`·`.*`·`^`·`$`·`'체크\|[^가]'`·`'체크\'`·`'체크{'`·`?`·`'체크 '`·`'체크-'`·`'체크+'`·`*`·`'체크<탭>'`·`'체크]'`·`'체크\|.'`·`"체크'"`·`'체크"'`. 리뷰가 나열한 14개 값을 모두 포함합니다 |
| 2 | 실제 스크립트, 지금 값 | `/bin/bash -n scripts/check-site.sh` 통과. `/bin/bash scripts/check-site.sh` → `check-site: 통과 (작업 트리, jekyll 3.10.0)`, exit 0 |
| 3 | 저장소 밖 임시 사본(`/tmp/rp-in11/cs.sh`)에서 `U10_ALLOW_PREFIX=` 줄만 바꾸고 저장소 안에서 `/bin/bash <사본>`으로 돌림. 값: `.*`·`.`·`^`·`$`·`'체크\|[^가]'`·`'체크\|'`·`''`·`'체크('`·`'체크 '` | 모두 `check-site: 실패 — U10_ALLOW_PREFIX 형식이 잘못되었습니다: '<값>'`, exit 1. 고치기 전에 0곳으로 조용히 통과하던 `.*`도 막힙니다 |

### IN-12: 랜딩 출력이 없을 때 점검 6번이 `U10_ALLOW_PREFIX`를 원인처럼 보이는 메시지로 실패를 한 번 더 셈

**Files modified:** `scripts/check-site.sh`
**Commit:** 0cb4d4e
**Status:** fixed
**Applied fix:** 6번 항목의 grep과 그 아래 `if/else`를 `if [ -f "$DEST/index.html" ]; then … fi`로 감쌌습니다. 파일이 없으면 6번을 건너뛰고 3번의 「문서가 없습니다」에 맡깁니다. 감싼 안쪽은 들여쓰기 4칸만 더했고 내용은 같습니다. 형식 확인 `case` 두 줄은 `if` 밖에 그대로 두어, 값이 틀리면 출력 유무와 상관없이 멈춥니다. 이 변경으로 `scripts/check-site.sh`의 6번 항목 grep부터 끝까지 줄이 3줄(주석, `if`, `fi`) 밀렸습니다. `grep -rn 'check-site.sh:[0-9]' CLAUDE.md .claude/CLAUDE.md .planning/codebase/`는 아무것도 찾지 않아, 줄 번호를 인용한 문서는 없습니다.

**시험 (메인 체크아웃, `/bin/bash` 3.2.57):**

| # | 상태 | 결과 |
|---|---|---|
| 1 | 실제 스크립트 | `/bin/bash -n` 통과, `/bin/bash scripts/check-site.sh` → `check-site: 통과 (작업 트리, jekyll 3.10.0)`, exit 0 |
| 2 | 저장소 밖 임시 사본에서 3번 항목 바로 앞에 `rm -f "$DEST/index.html"`을 넣음 | `check-site: 문서가 없습니다: /index.html` → `check-site: 실패 — 1건 (작업 트리)`, exit 1. 「점검 6번 grep이 실패했습니다」 줄은 나오지 않습니다 |
| 3 | 저장소 밖 임시 사본에서 6번 항목 바로 앞에 `$DEST/index.html` 끝에 `<p>포인트 체크포인트</p>`를 덧붙임 | `check-site: 랜딩에 출시 범위 밖 기능 이름이 있습니다: /index.html 1곳 (포인트·굿즈·코스북, U10)` → `check-site: 실패 — 1건 (작업 트리)`, exit 1. 파일이 있으면 그대로 잡고, 「체크포인트」는 뺍니다 |

---

_Fixed: 2026-11-18T14:39:40Z_
_Fixer: Claude (gsd-code-fixer)_
_Iteration: 1_
