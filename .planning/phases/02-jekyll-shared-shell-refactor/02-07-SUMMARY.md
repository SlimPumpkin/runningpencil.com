---
phase: 02-jekyll-shared-shell-refactor
plan: 07
subsystem: infra
tags: [github-pages, jekyll, deploy, pre-push, live-check, include, landing]

requires:
  - phase: 02-05
    provides: 원격 main 01f6bb8bbb13(PUSH2_SHA), 운영 빌드의 레이아웃·include 처리 확인, LIVE_PUSH2=OK
  - phase: 02-06
    provides: 랜딩 전환 커밋 762734f26068 (CMP_LANDING=OK, 바이트 동일, SC2_SINGLE=OK, SC2_PROBE=OK)
provides:
  - 원격 main이 e7e62f3f7990까지 나아감 (랜딩 include 전환과 02-05·02-06 기록 커밋 공개)
  - 운영 빌드(github-pages)가 랜딩 전체(인라인 스크립트·SVG 포함)를 Liquid로 처리한 출력이 기준 원본과 같다는 라이브 증거
  - 표식 줄 PUSH3_CANDIDATE·PUSH3_PREV·PUSH3_SHA·LIVE_PUSH3
affects: [02-08, 02-09, 02-10]

actuals:
  tokens: 4000
  tasks: 3
  commits: 0
plan_head_before: e7e62f3f7990a0b3a0f2425aa7f6b00bca0da583
plan_head_after: e7e62f3f7990a0b3a0f2425aa7f6b00bca0da583

tech-stack:
  added: []
  patterns:
    - "푸시는 승인받은 SHA를 <해시>:refs/heads/main으로만. 푸시 직전 git fetch로 원격 main이 기록한 PREV와 같은지 확인"
    - "푸시 뒤 live-check.sh post <SHA>를 한 번 돌려 출력 전체를 EVIDENCE에 붙이고, verify가 Pages 빌드 기록(같은 commit·created_at, built, 오류 없음)과 대조"

key-files:
  created:
    - .planning/phases/02-jekyll-shared-shell-refactor/02-07-SUMMARY.md
  modified:
    - .planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md

key-decisions:
  - "푸시 ③ 승인 (사용자 결정, Task 2 blocking-human checkpoint): e7e62f3f7990 하나만 원격 main에 푸시. 승인은 이 푸시 한 번에만 썼다"
  - "운영 빌드(github-pages)가 랜딩의 인라인 스크립트·SVG를 Liquid로 처리해도 출력이 기준 원본과 같았다. 네 페이지 모두 공통 블록 한 벌을 쓰는 상태가 라이브에 있다"

patterns-established:
  - "운영 Liquid를 처음 거치는 페이지는 라이브 정규화 본문 비교로 확인하고, 다르면 고치기 전에 revert부터 한다 (D-18)"

requirements-completed: [SHELL-01, SHELL-03]

coverage:
  - id: D1
    description: "푸시 ③ 후보 e7e62f3f7990이 실제 푸시 경로(pre-push 훅 → check-site → 기준 비교)를 통과하고 공개 범위·검토 항목이 기록됨"
    requirement: SHELL-01
    verification:
      - kind: other
        ref: "02-07-PLAN Task 1 verify (훅 check-site 통과, compare.sh OK 5줄)"
        status: pass
    human_judgment: false
  - id: D2
    description: "승인받은 e7e62f3f7990만 원격 main에 푸시 (원격 main 01f6bb8bbb13 → e7e62f3f7990, 훅 통과, --no-verify·force 없음)"
    requirement: SHELL-03
    verification:
      - kind: other
        ref: "02-07-PLAN Task 3 verify 1 (PUSH3_SHA = PUSH3_CANDIDATE, merge-base --is-ancestor PUSH3_SHA origin/main, live-check 기록 OK 문서 4·OK 404 13·OK 테마, FAIL 없음)"
        status: pass
    human_judgment: false
  - id: D3
    description: "푸시 ③ 배포 뒤 랜딩과 법적 3종이 200·같은 제목·같은 정규화 본문이고, 내부 파일 13개가 신선한 404, 운영 빌드 오류 없음"
    requirement: SHELL-03
    verification:
      - kind: other
        ref: "live-check.sh post e7e62f3f7990 (rc=0) + 02-07-PLAN Task 3 verify 2 (gh api pages/builds 대조)"
        status: pass
    human_judgment: false

duration: 10min
completed: 2026-11-16
status: complete
---

# Phase 2 Plan 07: 푸시 ③ (랜딩 전환) Summary

**사용자가 승인한 e7e62f3f7990 하나만 원격 main에 푸시했다. 이 배포에서 운영 빌드(github-pages)가 랜딩 전체(front matter `layout: none`, include 네 줄, 인라인 스크립트, 숨은 SVG `<defs>`)를 처음 Liquid로 처리했다. 라이브 홈페이지와 법적 세 문서는 기준 커밋 원본과 제목·정규화 본문이 같았고, 내부 파일 13개는 신선한 404였다.**

## Performance

- **Duration:** 약 10분 (Task 1 기록 05:15Z부터. Task 2에서 사람의 승인을 기다린 시간 포함)
- **Started:** 2026-11-16T05:15Z (Task 1 기록 시각), 이어받은 실행은 2026-11-16T05:20Z
- **Completed:** 2026-11-16T05:25Z
- **Tasks:** 3/3 (Task 1 tracer, Task 2 checkpoint:decision, Task 3 auto)
- **Files modified:** 저장소 파일 1개(`02-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- Task 1(이전 실행자): 후보 `e7e62f3f7990`을 pre-push 훅 실제 경로로 통과시켰다 (`check-site: 통과`, compare.sh OK 5줄, 네 문서 바이트 동일). 공개 범위는 커밋 5개, `.planning/` 밖 파일은 `index.html` 하나다. 검토 항목은 누출 0, 호스트 이름 0, 로컬 경로 끝 트리 1줄(이미 공개된 줄)·이력 0줄이다.
- Task 2: 사용자가 `push`로 답했다. 승인은 이 SHA의 푸시 한 번에만 쓴다.
- Task 3: 푸시 직전 원격 main이 `01f6bb8bbb13`(`PUSH3_PREV`)임을 다시 확인하고 `git push origin <e7e62f3f7990 전체>:refs/heads/main`으로 푸시했다. 훅이 `check-site: 통과 (커밋 e7e62f3f7990, jekyll 3.10.0)`를 냈고, 원격 main은 fast-forward로 `e7e62f3f7990`이 됐다.
- `live-check.sh post e7e62f3f7990`이 첫 실행에서 rc=0으로 통과했다. `OK 빌드` 1줄(created_at 2026-11-16T05:20:08Z), `OK 문서` 4줄(lm 05:20:41Z, age 0), `OK 404` 13줄(모두 age 0), `OK 테마` 1줄이다. FAIL·STALE은 없다 (`LIVE_PUSH3=OK`).
- 운영 빌드 오류 확인: `pages/builds/latest`가 commit `e7e62f3f7990`, status built, `error.message` null이다.
- 랜딩의 인라인 스크립트와 SVG가 운영 Liquid를 거쳐도 바뀌지 않았고, `{% include header.html home=true %}`가 랜딩 링크 변형을 냈다 (T-02-23, 성공 기준 4).

## Task Commits

이 계획은 task별 코드 커밋이 없다. 계획대로 저장소 파일은 `02-EVIDENCE.md` 하나만 고쳤고, 그 파일은 이 SUMMARY와 함께 docs 커밋 하나로 들어간다.

1. **Task 1: 푸시 ③ 후보를 실제 푸시 경로로 통과시키고 공개 범위 계산 (tracer)** - 커밋 없음 (EVIDENCE는 docs 커밋에 포함)
2. **Task 2: 푸시 ③ 승인 (checkpoint:decision, blocking-human)** - 사용자 답 `push`
3. **Task 3: 승인받은 SHA만 푸시하고 라이브 확인** - 커밋 없음. 원격 푸시 1회: `01f6bb8bbb13` → `e7e62f3f7990`

**Plan metadata:** docs 커밋 (`docs(02-07): …`, SUMMARY + EVIDENCE). 로컬에만 있고 다음 승인된 푸시(D-15 ④, 02-10) 때 함께 나간다.

## Files Created/Modified

- `.planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md` - 구간 `## 02-07 푸시 ③ 후보`(Task 1)와 `## 02-07 푸시 ③ 라이브 확인`(승인, 푸시 전후 확인, live-check 출력 전체, 빌드 기록, 판정) 추가
- `.planning/phases/02-jekyll-shared-shell-refactor/02-07-SUMMARY.md` - 이 문서

## Decisions Made

- **푸시 ③ 승인** (사용자 결정). `PUSH3_SHA` = `PUSH3_CANDIDATE` = `e7e62f3f7990`. 이 승인은 다음 푸시(④)로 이어지지 않는다.
- **운영과 로컬의 랜딩 Liquid 처리 차이 없음.** 운영 빌드가 만든 홈페이지가 기준 원본과 정규화 본문이 같았다.
- **Last-Modified 기준 신선도 판정 유지.** 네 문서 모두 `last-modified`가 새 배포 시각(빌드 `created_at` 이후)이었다. RESEARCH A2가 네 번째 배포에서도 성립했다.

## Deviations from Plan

None - plan executed exactly as written.

참고: 되돌리기 절차(`<rollback_procedure>`)는 쓰지 않았다 (FAIL 없음). live-check는 한 번만 돌렸고 스크립트는 고치지 않았다.

## Issues Encountered

None

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 원격 main은 이제 `e7e62f3f7990`이다. 네 페이지 모두 공통 블록 한 벌(`_includes/`)을 쓰는 상태가 라이브에 있다. 법적 URL 세 개(`/privacy-policy/`, `/terms/`, `/data-deletion/`)는 경로가 그대로이고 200·같은 제목을 돌려준다.
- 다음 푸시(④)는 02-10에서 새로 승인받는다.
- 이 계획의 docs 커밋과 상태 기록 커밋은 로컬에만 있다. 다음 승인된 푸시 때 함께 나간다.
