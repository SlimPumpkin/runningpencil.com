---
phase: 02-jekyll-shared-shell-refactor
plan: 05
subsystem: infra
tags: [github-pages, jekyll, deploy, pre-push, live-check, layout, include]

requires:
  - phase: 02-03
    provides: 원격 main d5a6679631d7(PUSH1_SHA), 운영 빌드의 exclude·점·밑줄 규칙 확인, LIVE_PUSH1=OK
  - phase: 02-04
    provides: 법적 3종 전환 커밋 6994b6f27976·c13cf8a17b84·8cf18dd40673 (CMP_LEGAL=OK, 바이트 동일)
provides:
  - 원격 main이 01f6bb8bbb13까지 나아감 (법적 3종 legal 레이아웃·include 전환과 02-03·02-04 기록 커밋 공개)
  - 운영 빌드(github-pages)가 front matter·레이아웃·include를 처리한 출력이 기준 원본과 같다는 첫 라이브 증거
  - 표식 줄 PUSH2_CANDIDATE·PUSH2_PREV·PUSH2_SHA·LIVE_PUSH2
affects: [02-06, 02-07, 02-10]

actuals:
  tokens: 3000
  tasks: 3
  commits: 0
plan_head_before: 01f6bb8bbb136af83f43541a014f3864aec9d244
plan_head_after: 01f6bb8bbb136af83f43541a014f3864aec9d244

tech-stack:
  added: []
  patterns:
    - "푸시는 승인받은 SHA를 <해시>:refs/heads/main으로만. 푸시 직전 git fetch로 원격 main이 기록한 PREV와 같은지 확인"
    - "푸시 뒤 live-check.sh post <SHA>를 한 번 돌려 출력 전체를 EVIDENCE에 붙이고, verify가 Pages 빌드 기록(같은 commit·created_at, built, 오류 없음)과 대조"

key-files:
  created:
    - .planning/phases/02-jekyll-shared-shell-refactor/02-05-SUMMARY.md
  modified:
    - .planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md

key-decisions:
  - "푸시 ② 승인 (사용자 결정, Task 2 blocking-human checkpoint): 01f6bb8bbb13 하나만 원격 main에 푸시. 승인은 이 푸시 한 번에만 썼다"
  - "운영 빌드(github-pages)와 로컬 Jekyll 3.10.0의 레이아웃·include 처리 차이는 이 배포에서 드러나지 않았다. 랜딩 전환(02-06)도 같은 방식(로컬 compare.sh → 승인 → 라이브 확인)으로 진행한다"

patterns-established:
  - "레이아웃·include를 처음 운영에 올리는 푸시는 라이브 문서 비교와 /_includes/·/_layouts/ 신선한 404로 확인한다"

requirements-completed: [SHELL-01, SHELL-03]

coverage:
  - id: D1
    description: "푸시 ② 후보 01f6bb8bbb13이 실제 푸시 경로(pre-push 훅 → check-site → 기준 비교)를 통과하고 공개 범위·검토 항목이 기록됨"
    requirement: SHELL-01
    verification:
      - kind: other
        ref: "02-05-PLAN Task 1 verify (훅 check-site 통과, compare.sh OK 5줄)"
        status: pass
    human_judgment: false
  - id: D2
    description: "승인받은 01f6bb8bbb13만 원격 main에 푸시 (원격 main d5a6679631d7 → 01f6bb8bbb13, 훅 통과, --no-verify·force 없음)"
    requirement: SHELL-03
    verification:
      - kind: other
        ref: "02-05-PLAN Task 3 verify 1 (PUSH2_SHA = PUSH2_CANDIDATE, merge-base --is-ancestor PUSH2_SHA origin/main, live-check 기록 OK 문서 4·OK 404 13·OK 테마, FAIL 없음)"
        status: pass
    human_judgment: false
  - id: D3
    description: "푸시 ② 배포 뒤 법적 3종과 랜딩이 200·같은 제목·같은 정규화 본문이고, /_includes/footer.html·/_layouts/legal.html을 포함한 내부 파일 13개가 신선한 404, 운영 빌드 오류 없음"
    requirement: SHELL-03
    verification:
      - kind: other
        ref: "live-check.sh post 01f6bb8bbb13 (rc=0) + 02-05-PLAN Task 3 verify 2 (gh api pages/builds 대조)"
        status: pass
    human_judgment: false

duration: 15min
completed: 2026-11-16
status: complete
---

# Phase 2 Plan 05: 푸시 ② (법적 3종 전환) Summary

**사용자가 승인한 01f6bb8bbb13 하나만 원격 main에 푸시했다. 이 배포에서 운영 빌드(github-pages)가 front matter `layout: legal`과 include 네 개를 처음 처리했다. 법적 세 문서와 랜딩의 라이브 응답은 기준 커밋 원본과 제목·정규화 본문이 같았고, `/_includes/footer.html`·`/_layouts/legal.html`을 포함한 내부 파일 13개는 운영에서 신선한 404였다.**

## Performance

- **Duration:** 약 15분 (Task 1 기록 04:26Z부터. Task 2에서 사람의 승인을 기다린 시간 포함)
- **Started:** 2026-11-16T04:26Z (Task 1 기록 시각), 이어받은 실행은 2026-11-16T04:37:07Z
- **Completed:** 2026-11-16T04:40Z
- **Tasks:** 3/3 (Task 1 tracer, Task 2 checkpoint:decision, Task 3 auto)
- **Files modified:** 저장소 파일 1개(`02-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- Task 1(이전 실행자): 후보 `01f6bb8bbb13`을 pre-push 훅 실제 경로로 통과시켰다 (`check-site: 통과`, compare.sh OK 5줄, 네 문서 바이트 동일). 공개 범위는 커밋 7개, `.planning/` 밖 파일 8개(`_layouts/legal.html`, `_includes/` 넷, 법적 페이지 셋)이고, `index.html`은 바뀌지 않는다. 검토 항목은 누출 0, 호스트 이름 0, 로컬 경로 끝 트리 1줄(이미 공개된 줄)·이력 0줄이다.
- Task 2: 사용자가 `push`로 답했다. 승인은 이 SHA의 푸시 한 번에만 쓴다.
- Task 3: 푸시 직전 원격 main이 `d5a6679631d7`(`PUSH2_PREV`)임을 다시 확인하고 `git push origin <01f6bb8bbb13 전체>:refs/heads/main`으로 푸시했다. 훅이 `check-site: 통과 (커밋 01f6bb8bbb13, jekyll 3.10.0)`를 냈고, 원격 main은 fast-forward로 `01f6bb8bbb13`이 됐다.
- `live-check.sh post 01f6bb8bbb13`이 첫 실행에서 rc=0으로 통과했다. `OK 빌드` 1줄(created_at 2026-11-16T04:37:19Z), `OK 문서` 4줄(lm 04:37:49Z, age 0), `OK 404` 13줄(모두 age 0), `OK 테마` 1줄이다. FAIL·STALE은 없다 (`LIVE_PUSH2=OK`).
- 운영 빌드 오류 확인: `pages/builds/latest`가 commit `01f6bb8bbb13`, status built, `error.message` null이다.
- 로컬 Jekyll(Ruby 4.0.9)과 운영(github-pages)의 Liquid 처리 차이가 이 배포에서 드러나지 않았다는 첫 증거다 (RESEARCH A4, 성공 기준 4).

## Task Commits

이 계획은 task별 코드 커밋이 없다. 계획대로 저장소 파일은 `02-EVIDENCE.md` 하나만 고쳤고, 그 파일은 이 SUMMARY와 함께 docs 커밋 하나로 들어간다.

1. **Task 1: 푸시 ② 후보를 실제 푸시 경로로 통과시키고 공개 범위 계산 (tracer)** - 커밋 없음 (EVIDENCE는 docs 커밋에 포함)
2. **Task 2: 푸시 ② 승인 (checkpoint:decision, blocking-human)** - 사용자 답 `push`
3. **Task 3: 승인받은 SHA만 푸시하고 라이브 확인** - 커밋 없음. 원격 푸시 1회: `d5a6679631d7` → `01f6bb8bbb13`

**Plan metadata:** docs 커밋 (`docs(02-05): …`, SUMMARY + EVIDENCE). 로컬에만 있고 다음 승인된 푸시(D-15 ③, 02-07) 때 함께 나간다.

## Files Created/Modified

- `.planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md` - 구간 `## 02-05 푸시 ② 후보`(Task 1)와 `## 02-05 푸시 ② 라이브 확인`(승인, 푸시 전후 확인, live-check 출력 전체, 빌드 기록, 판정) 추가
- `.planning/phases/02-jekyll-shared-shell-refactor/02-05-SUMMARY.md` - 이 문서

## Decisions Made

- **푸시 ② 승인** (사용자 결정). `PUSH2_SHA` = `PUSH2_CANDIDATE` = `01f6bb8bbb13`. 이 승인은 다음 푸시(③, 랜딩 전환)로 이어지지 않는다.
- **운영과 로컬의 레이아웃 처리 차이 없음.** 운영 빌드가 만든 법적 세 문서가 기준 원본과 정규화 본문이 같았다. 랜딩 전환도 같은 절차로 진행한다.
- **Last-Modified 기준 신선도 판정 유지.** 바뀌지 않은 랜딩도 `last-modified`가 새 배포 시각으로 올라갔다. RESEARCH A2가 세 번째 배포에서도 성립했다.

## Deviations from Plan

None - plan executed exactly as written.

참고: 되돌리기 절차(`<rollback_procedure>`)는 쓰지 않았다 (FAIL 없음). live-check는 한 번만 돌렸고 스크립트는 고치지 않았다.

## Issues Encountered

None

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 원격 main은 이제 `01f6bb8bbb13`이다. 법적 URL 세 개(`/privacy-policy/`, `/terms/`, `/data-deletion/`)는 경로가 그대로이고 200·같은 제목을 돌려준다.
- 다음 계획 02-06(랜딩 전환)은 이 값을 기준으로 진행하고, 그 결과의 푸시(③)는 02-07에서 새로 승인받는다.
- 이 계획의 docs 커밋과 상태 기록 커밋은 로컬에만 있다. 다음 승인된 푸시 때 함께 나간다.

## Self-Check: PASSED

- `02-EVIDENCE.md`에 `PUSH2_CANDIDATE=01f6bb8bbb13`, `PUSH2_PREV=d5a6679631d7`, `PUSH2_SHA=01f6bb8bbb13`, `LIVE_PUSH2=OK`와 두 02-05 구간이 있다
- Task 1 verify 1개, Task 3 verify 2개 모두 exit 0 (PLAN의 `<automated>` 텍스트를 그대로 뽑아 실행. Pages 빌드 기록 대조 포함)
- `git fetch` 뒤 원격 main = `01f6bb8bbb13`, `merge-base --is-ancestor 01f6bb8bbb13 origin/main` 참
- 이 계획이 고친 저장소 파일은 `02-EVIDENCE.md`와 이 SUMMARY뿐 (`.planning/config.json`, `.planning/state.json`, `.planning/STATE.md`의 기존 변경은 실행 전부터 있던 것)

---
*Phase: 02-jekyll-shared-shell-refactor*
*Completed: 2026-11-16*
