---
phase: 02-jekyll-shared-shell-refactor
plan: 06
subsystem: infra
tags: [jekyll, liquid, include, refactor, github-pages]

requires:
  - phase: 02-jekyll-shared-shell-refactor (02-04)
    provides: "_includes/head-links.html, _includes/css/common.css, _includes/header.html(include.home 분기), _includes/footer.html"
  - phase: 02-jekyll-shared-shell-refactor (02-05)
    provides: "푸시 ② 라이브 확인 통과 (LIVE_PUSH2=OK)"
provides:
  - "랜딩 index.html이 layout: none + include 네 곳(head 링크, 「공통」 CSS, 헤더 home=true, 푸터)으로 전환됨"
  - "공통 블록 네 가지가 저장소에 한 벌만 있음 (성공 기준 2, SHELL-01)"
  - "D-15의 세 번째 푸시 후보 커밋 762734f26068 (푸시 안 함)"
  - "스크래치 probe.sh (include 4×4 프로브)와 inject.sh 경우 f (랜딩 front matter 삭제)"
affects: [02-07, 02-08, 02-09, 02-10, phase-03, phase-04]

actuals:
  tokens: 5800
  tasks: 2
  commits: 1

plan_head_before: 55b7f6ea6a071f83b4bb7424ab150008f59df232
plan_head_after: 762734f26068ddf66b5747cfd20a1e53417cbfe6

tech-stack:
  added: []
  patterns:
    - "레이아웃 없는 페이지는 front matter `layout: none`과 0열 include만 쓴다 (랜딩)"
    - "헤더 include는 `home=true` 매개변수로 랜딩 링크(#top·#story·#demo·#get)를 낸다"

key-files:
  created: []
  modified:
    - index.html
    - .planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md

key-decisions:
  - "02-06: 랜딩을 layout: none과 include 네 줄로 전환. 전환 커밋 762734f26068이 기준 db505d71d3d2와 네 문서 바이트 동일, _site 파일 목록 동일. 푸시 안 함 (D-15 세 번째 푸시 후보)"
  - "02-06: include 하나를 바꾸면 네 문서가 모두 바뀜을 시험용 worktree에서 확인 (4×4, 커밋 안 함). 레이아웃 변경은 법적 세 문서만 바꾸는 것이 의도한 동작 (D-03)"

patterns-established:
  - "랜딩 include 경계: 「공통」 CSS include 다음 빈 줄과 「랜딩 전용」 CSS가 같은 <style> 안에서 이어진다"

requirements-completed: [SHELL-01]

coverage:
  - id: D1
    description: "랜딩 index.html을 layout: none + include 네 곳으로 전환하고 네 문서 출력이 기준과 바이트 동일"
    requirement: SHELL-01
    verification:
      - kind: other
        ref: "$RP2/compare.sh db505d71d3d2 762734f26068 (OK 5줄, 네 문서 바이트 동일, _site 파일 목록 동일 11개)"
        status: pass
      - kind: other
        ref: "scripts/check-site.sh HEAD (check-site: 통과, 커밋 762734f26068)"
        status: pass
    human_judgment: false
  - id: D2
    description: "공통 블록 네 가지(푸터·헤더·head 링크·「공통」 CSS)가 각자의 include 파일에만 있음"
    requirement: SHELL-01
    verification:
      - kind: other
        ref: "git grep -lF (footer/header/manifest/공통 머리 주석) → 각 include 파일 하나씩"
        status: pass
    human_judgment: false
  - id: D3
    description: "include 하나를 바꾸면 네 문서가 모두 바뀜 (임시 시험, 커밋 안 함)"
    requirement: SHELL-01
    verification:
      - kind: other
        ref: "$RP2/probe.sh → include 네 개 모두 4/4, 메인 작업 트리 변경 없음, 시험용 worktree 남지 않음"
        status: pass
    human_judgment: false
  - id: D4
    description: "랜딩 front matter를 지우면 check-site가 처리되지 않은 Liquid로 막음"
    requirement: SHELL-01
    verification:
      - kind: other
        ref: "$RP2/inject.sh → PASS 주입-a~f 여섯 줄, 주입-f: Liquid가 처리되지 않은 출력: /index.html"
        status: pass
    human_judgment: false

duration: 4min
completed: 2026-11-16
status: complete
---

# Phase 2 Plan 06: 랜딩 include 전환 Summary

**랜딩 `index.html`을 front matter `layout: none`과 0열 include 네 줄(head 링크, 「공통」 CSS, 헤더 `home=true`, 푸터)로 전환. 전환 커밋 `762734f26068`이 기준 `db505d71d3d2`와 네 문서 바이트 동일이고, 공통 블록이 저장소에 한 벌만 남아 include 하나를 고치면 네 문서가 모두 바뀜(4×4)을 확인**

## Performance

- **Duration:** 4 min (계획 시작 시각 기록 뒤 측정. 시작 전 읽기 시간은 빠짐)
- **Started:** 2026-11-16T05:01:42Z
- **Completed:** 2026-11-16T05:06Z
- **Tasks:** 2
- **Files modified:** 2 (`index.html`, `02-EVIDENCE.md`)

## Accomplishments

- 랜딩 전환: `index.html` 653행 → 586행. 바꾼 곳은 맨 위 front matter 세 줄과 include 네 줄뿐이고, OG 메타·pre-paint 스크립트·「랜딩 전용」 CSS·숨은 SVG `<defs>`·끝 인라인 스크립트는 그대로입니다.
- 성공 기준 1 (전환 커밋 시점): `compare.sh <BASE_SHA> <LANDING_CONV_SHA>` rc=0, OK 5줄. 네 문서 모두 **바이트 동일**(출력 주석 포함, D-05), `_site` 파일 목록 동일(11개). `scripts/check-site.sh HEAD` 통과.
- 성공 기준 2: 푸터·헤더·head 링크·「공통」 머리 주석이 각각 `_includes/footer.html`, `_includes/header.html`, `_includes/head-links.html`, `_includes/css/common.css`에만 있습니다. `probe.sh` 결과 include 네 개 모두 `4/4`.
- 실패 주입: `inject.sh`에 경우 f(랜딩 front matter 삭제)를 더해 여섯 경우 모두 PASS. 경우 f는 `check-site: Liquid가 처리되지 않은 출력: /index.html`로 막힙니다.

## Task Commits

1. **Task 1: 랜딩을 include 네 곳으로 전환 (tracer)** - `762734f26068` (refactor)
2. **Task 2: include 4×4 프로브와 경우 f 주입** - 커밋 없음. 이 task가 바꾼 파일은 `02-EVIDENCE.md`뿐이고, 계획대로 SUMMARY와 같은 docs 커밋에 넣습니다. 프로브·주입 도구는 저장소 밖 스크래치(`$RP2`)에 있고 커밋하지 않습니다 (D-10, D-13).

**Plan metadata:** SUMMARY·EVIDENCE docs 커밋, STATE·ROADMAP docs 커밋 (이 문서를 쓴 뒤)

## Verification Results

| 확인 | 결과 |
|---|---|
| `compare.sh <BASE_SHA> <write-tree>` (커밋 전) | rc=0, OK 5줄, 네 문서 바이트 동일 |
| `compare.sh <BASE_SHA> 762734f26068` (커밋 뒤) | rc=0, OK 5줄, 네 문서 바이트 동일, 파일 목록 동일 11개 |
| front matter 세 줄 + 0열 include 네 줄 | exit 0 |
| 한 벌 확인 (`git grep -lF` 네 가지) | exit 0, 각 include 파일 하나씩 |
| `scripts/check-site.sh HEAD` | `check-site: 통과 (커밋 762734f26068, jekyll 3.10.0)` |
| `probe.sh` | `include head-links.html: 4/4`, `include css/common.css: 4/4`, `include header.html: 4/4`, `include footer.html: 4/4`. 메인 작업 트리 `_includes`·`index.html` 변경 없음, 시험용 worktree 없음 |
| `inject.sh` | `PASS 주입-a`~`PASS 주입-f` 여섯 줄, rc 모두 1 |
| 사이트 커밋이 바꾼 파일 | `git show --name-only --format= 762734f26068` → `index.html` 한 줄 |
| 푸시 | 하지 않음. 원격 main은 `01f6bb8bbb13` 그대로 |

Tracer feedback gate: 대화형·`end-of-phase`·`<automated>`만 있는 verify라 Task 1 verify 네 명령을 커밋 뒤 다시 돌렸고 모두 exit 0이어서 Task 2로 넘어갔습니다 (checkpoint 없음).

## Files Created/Modified

- `index.html` - front matter `layout: none`, include 네 줄(`head-links.html`, `css/common.css`, `header.html home=true`, `footer.html`)
- `.planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md` - 구간 `## 02-06 랜딩 전환`. 표식 `LANDING_CONV_SHA=762734f26068`, `CMP_LANDING=OK`, `SC2_SINGLE=OK`, `SC2_PROBE=OK`, `INJECT_F=OK`, 성공 기준 1·2 판정 줄
- 스크래치(커밋 안 함): `$RP2/probe.sh` 새로 만듦, `$RP2/inject.sh`에 경우 f 추가

## Decisions Made

- 경우 f는 시험용 worktree의 `index.html` 첫 줄이 `---`일 때만 front matter 세 줄을 지웁니다. front matter가 없으면 파일이 바뀌지 않아 경우 f가 FAIL로 끝나므로 거짓 PASS가 나오지 않습니다.
- 프로브는 include 끝에 줄 하나를 덧붙입니다 (include 파일에 끝 줄바꿈이 없으므로 줄바꿈을 먼저 넣음). HTML 조각에는 HTML 주석, CSS 조각에는 CSS 주석을 씁니다.

## Deviations from Plan

### 계획과 다르게 한 점 (규칙 1~3 해당 없음)

**1. 커밋 제목에 범위 표기 `(02-06)`를 붙임**
- 계획에는 `refactor: 랜딩을 공통 include로 전환`이라고 적혀 있습니다. orchestrator 지시와 이전 계획 커밋(`refactor(02-04): ...`)에 맞춰 `refactor(02-06): 랜딩을 공통 include로 전환`으로 썼습니다. 내용은 같습니다.

**2. Task 2는 따로 커밋하지 않음**
- Task 2가 바꾼 저장소 파일은 `02-EVIDENCE.md` 하나이고, 계획이 EVIDENCE를 계획 끝 SUMMARY 커밋에 넣으라고 정했습니다.

**3. `workflow.use_worktrees=true`인 채로 실행**
- 계획은 `use_worktrees=false` 실행을 요구하지만, 두 task의 precondition(메인 체크아웃: `git-dir`와 `git-common-dir`가 같음)이 충족되어 진행했습니다. 설정 파일은 고치지 않았습니다 (02-01과 같은 처리).

---

**Total deviations:** 0 auto-fixed. 표기·커밋 구성 차이 3건
**Impact on plan:** 산출물과 판정에는 영향 없음.

## Issues Encountered

None

## User Setup Required

None - 외부 서비스 설정 없음.

## Next Phase Readiness

- 02-07: 푸시 ③ 후보는 `762734f26068`과 그 뒤 docs 커밋입니다. 운영 빌드(github-pages)가 `layout: none`과 랜딩 include를 처음 처리하는 배포이므로 라이브 확인에서 랜딩 출력을 기준과 비교해야 합니다.
- 랜딩 전환으로 아래 문구가 사실과 맞지 않게 됐습니다. D-05(전환 커밋은 주석까지 그대로)와 계획 범위에 따라 이 계획에서는 고치지 않았고, 맡은 계획이 정해져 있습니다.
  - `_includes/css/common.css` 머리 주석 「네 페이지가 이 묶음을 똑같이 복사해 쓴다. 고칠 때는 네 파일을 함께 고친다」와 `.planning/codebase/` STACK·CONVENTIONS·ARCHITECTURE → 02-08
  - `CLAUDE.md`, `.claude/CLAUDE.md`, `README.md`, `.planning/codebase/` TESTING·STRUCTURE·CONCERNS → 02-09
- SHELL-01은 02-07·02-08·02-10도 선언하므로 REQUIREMENTS.md의 완료 표시는 마지막 선언 계획이 끝날 때까지 미룹니다 (shared-ID gate).

## Self-Check: PASSED

- FOUND: `index.html` (front matter `layout: none`, include 네 줄)
- FOUND: `.planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md` (`LANDING_CONV_SHA`·`CMP_LANDING`·`SC2_SINGLE`·`SC2_PROBE`·`INJECT_F` 표식)
- FOUND: 커밋 `762734f26068` (HEAD의 조상)
- 측정한 커밋 수: `git rev-list --count 55b7f6ea6a07..HEAD` = 1

---
*Phase: 02-jekyll-shared-shell-refactor*
*Completed: 2026-11-16*
