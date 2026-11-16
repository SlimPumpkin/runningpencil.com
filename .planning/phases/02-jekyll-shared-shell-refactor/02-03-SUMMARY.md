---
phase: 02-jekyll-shared-shell-refactor
plan: 03
subsystem: infra
tags: [github-pages, jekyll, deploy, pre-push, live-check, exclude]

requires:
  - phase: 02-01
    provides: 빌드 설정 커밋 7773b163f3de, 점검 스크립트·훅 커밋 7f13a622878b, 스크래치 compare.sh
  - phase: 02-02
    provides: 스크래치 live-check.sh, HISTORY_DECISION=base-first, 원격 main db505d71d3d2(기준 커밋)
provides:
  - 원격 main이 d5a6679631d7까지 나아감 (빌드 설정·점검 스크립트·훅과 02-01·02-02 기록 커밋 공개)
  - 운영 빌드에서 보강한 exclude와 점·밑줄 규칙이 적용됨을 신선한 응답으로 확인한 기록
  - 표식 줄 PUSH1_CANDIDATE·PUSH1_PREV·PUSH1_SHA·LIVE_PUSH1
affects: [02-04, 02-05, 02-07, 02-10]

actuals:
  tokens: 4300
  tasks: 3
  commits: 0
plan_head_before: d5a6679631d7623fd171ed98bc450db695167df4
plan_head_after: d5a6679631d7623fd171ed98bc450db695167df4

tech-stack:
  added: []
  patterns:
    - "푸시는 승인받은 SHA를 <해시>:refs/heads/main으로만. 푸시 직전 git fetch로 원격 main이 기록한 PREV와 같은지 확인"
    - "푸시 뒤 live-check.sh post <SHA>를 한 번 돌려 출력 전체를 EVIDENCE에 붙이고, verify가 Pages 빌드 기록(같은 commit·created_at, built, 오류 없음)과 대조"

key-files:
  created:
    - .planning/phases/02-jekyll-shared-shell-refactor/02-03-SUMMARY.md
  modified:
    - .planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md

key-decisions:
  - "푸시 ① 승인 (사용자 결정, Task 2 blocking-human checkpoint): d5a6679631d7 하나만 원격 main에 푸시. 승인은 이 푸시 한 번에만 썼다"
  - "Last-Modified 기준 신선도 판정을 계속 쓴다. 바이트가 같은 문서도 새 배포 시각으로 last-modified가 올라감을 두 번째 배포에서도 관찰 (RESEARCH A2)"

patterns-established:
  - "빌드 출력이 바뀌지 않는 설정 커밋을 먼저 배포해 운영 빌드의 exclude를 확인한 뒤 전환 커밋을 올린다"

requirements-completed: [SHELL-02, SHELL-03]

coverage:
  - id: D1
    description: "푸시 ① 후보 d5a6679631d7이 실제 푸시 경로(pre-push 훅 → check-site → 기준 비교)를 통과하고 공개 범위·검토 항목이 기록됨"
    requirement: SHELL-02
    verification:
      - kind: other
        ref: "02-03-PLAN Task 1 verify (훅 check-site 통과, compare.sh OK 5줄)"
        status: pass
    human_judgment: false
  - id: D2
    description: "승인받은 d5a6679631d7만 원격 main에 푸시 (원격 main db505d71d3d2 → d5a6679631d7, 훅 통과, --no-verify·force 없음)"
    requirement: SHELL-03
    verification:
      - kind: other
        ref: "02-03-PLAN Task 3 verify 1 (PUSH1_SHA = PUSH1_CANDIDATE, merge-base --is-ancestor PUSH1_SHA origin/main)"
        status: pass
    human_judgment: false
  - id: D3
    description: "푸시 ① 배포 뒤 네 URL 200·제목·정규화 본문이 기준과 같고, /Gemfile 등 내부 파일 13개가 신선한 404, 테마 파일 200"
    requirement: SHELL-03
    verification:
      - kind: other
        ref: "live-check.sh post d5a6679631d7 (rc=0) + 02-03-PLAN Task 3 verify 2 (gh api pages/builds 대조, n=1)"
        status: pass
    human_judgment: false

duration: 21min
completed: 2026-11-16
status: complete
---

# Phase 2 Plan 03: 푸시 ① (빌드 설정) Summary

**사용자가 승인한 d5a6679631d7 하나만 원격 main에 푸시했다. 빌드 설정(Gemfile·Gemfile.lock·_config.yml·.gitignore)과 점검 스크립트·pre-push 훅이 이 푸시로 처음 운영에 들어갔다. 배포 뒤 네 URL은 기준 커밋과 같고, `/Gemfile`·`/Gemfile.lock`·`/scripts/check-site.sh`·`/.githooks/pre-push`를 포함한 내부 파일 13개가 운영에서 신선한 404임을 확인했다.**

## Performance

- **Duration:** 약 21분 (Task 2에서 사람의 승인을 기다린 시간 포함)
- **Started:** 2026-11-16T02:54:04Z
- **Completed:** 2026-11-16T03:15Z
- **Tasks:** 3/3 (Task 1 tracer, Task 2 checkpoint:decision, Task 3 auto)
- **Files modified:** 저장소 파일 1개(`02-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- Task 1(이전 실행자): 후보 `d5a6679631d7`을 pre-push 훅 실제 경로로 통과시켰다 (`check-site: 통과`, compare.sh OK 5줄). 공개 범위는 커밋 5개, `.planning/` 밖 파일 6개이고, 검토 항목은 누출 0, 호스트 이름 0, 로컬 경로 끝 트리 1줄(기준 커밋에 이미 있던 줄)·이력 0줄이다.
- Task 2: 사용자가 `push`로 답했다. 승인은 이 SHA의 푸시 한 번에만 쓴다.
- Task 3: 푸시 직전 원격 main이 `db505d71d3d2`(`PUSH1_PREV`)임을 다시 확인하고 `git push origin <d5a6679631d7 전체>:refs/heads/main`으로 푸시했다. 훅이 `check-site: 통과 (커밋 d5a6679631d7, jekyll 3.10.0)`를 냈고, 원격 main은 fast-forward로 `d5a6679631d7`이 됐다.
- `live-check.sh post d5a6679631d7`이 첫 실행에서 rc=0으로 통과했다. `OK 빌드` 1줄(created_at 2026-11-16T03:08:27Z), `OK 문서` 4줄(lm 03:09:04Z, age 0), `OK 404` 13줄(모두 age 0), `OK 테마` 1줄이다. FAIL·STALE은 없다 (`LIVE_PUSH1=OK`).
- 이 푸시로 원격에 처음 들어간 네 파일(`/Gemfile`, `/Gemfile.lock`, `/scripts/check-site.sh`, `/.githooks/pre-push`)이 운영에서 신선한 404다. 운영 빌드(github-pages)가 보강한 `exclude`와 점·밑줄 규칙을 적용함을 처음 확인했다 (SHELL-03, 성공 기준 4).

## Task Commits

이 계획은 task별 코드 커밋이 없다. 계획대로 저장소 파일은 `02-EVIDENCE.md` 하나만 고쳤고, 그 파일은 이 SUMMARY와 함께 docs 커밋 하나로 들어간다.

1. **Task 1: 푸시 ① 후보를 실제 푸시 경로로 통과시키고 공개 범위 계산 (tracer)** - 커밋 없음 (EVIDENCE는 docs 커밋에 포함)
2. **Task 2: 푸시 ① 승인 (checkpoint:decision, blocking-human)** - 사용자 답 `push`
3. **Task 3: 승인받은 SHA만 푸시하고 라이브 확인** - 커밋 없음. 원격 푸시 1회: `db505d71d3d2` → `d5a6679631d7`

**Plan metadata:** docs 커밋 (`docs(02-03): …`, SUMMARY + EVIDENCE). 로컬에만 있고 다음 승인된 푸시 때 함께 나간다.

## Files Created/Modified

- `.planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md` - 구간 `## 02-03 푸시 ① 후보`(Task 1)와 `## 02-03 푸시 ① 라이브 확인`(승인, 푸시 전후 확인, live-check 출력 전체, 빌드 기록, 판정) 추가
- `.planning/phases/02-jekyll-shared-shell-refactor/02-03-SUMMARY.md` - 이 문서

## Decisions Made

- **푸시 ① 승인** (사용자 결정). `PUSH1_SHA` = `PUSH1_CANDIDATE` = `d5a6679631d7`. 이 승인은 다음 푸시(②, 법적 3종 전환)로 이어지지 않는다.
- **Last-Modified 기준 신선도 판정 유지.** 네 문서의 바이트가 바뀌지 않았는데도 `last-modified`가 새 배포 시각으로 올라갔다. RESEARCH A2가 두 번째 배포에서도 성립했으므로 ETag로 판정을 바꿀 필요가 없다.

## Deviations from Plan

None - plan executed exactly as written.

참고: live-check 출력의 `OK 404` 줄 순서가 02-02 기록과 다르다. live-check가 첫 회차에서 신선하다고 판정하지 못한 경로를 다음 회차(60초 뒤)에 다시 확인해 그 순서로 출력했기 때문이다. 13개 모두 최종 판정이 OK이고 스크립트는 고치지 않았다. 되돌리기 절차는 쓰지 않았다 (FAIL 없음).

## Issues Encountered

None

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 원격 main은 이제 `d5a6679631d7`이다. 다음 계획 02-04(법적 3종 전환)는 이 값을 기준으로 진행하고, 그 결과의 푸시(②)는 02-05에서 새로 승인받는다.
- 운영 빌드의 `exclude`가 확인됐으므로 `_includes/`·`_layouts/`를 더하는 전환 커밋을 올릴 수 있다. `/_includes/footer.html`·`/_layouts/legal.html`의 404는 해당 파일이 원격에 들어가는 푸시에서 다시 의미 있게 확인된다.
- 이 계획의 docs 커밋과 상태 기록 커밋은 로컬에만 있다. 다음 승인된 푸시 때 함께 나간다.

## Self-Check: PASSED

- `02-EVIDENCE.md`에 `PUSH1_CANDIDATE=d5a6679631d7`, `PUSH1_PREV=db505d71d3d2`, `PUSH1_SHA=d5a6679631d7`, `LIVE_PUSH1=OK`와 두 02-03 구간이 있다
- Task 1 verify 1개, Task 3 verify 2개 모두 exit 0 (Pages 빌드 기록 대조 n=1 포함)
- `git fetch` 뒤 원격 main = `d5a6679631d7`, `merge-base --is-ancestor d5a6679631d7 origin/main` 참
- 이 계획이 고친 저장소 파일은 `02-EVIDENCE.md`와 이 SUMMARY뿐 (`.planning/config.json`, `.planning/state.json`, `.planning/STATE.md`의 나머지 변경은 실행 전부터 있던 것)

---
*Phase: 02-jekyll-shared-shell-refactor*
*Completed: 2026-11-16*
