---
phase: 02-jekyll-shared-shell-refactor
plan: 02
subsystem: infra
tags: [github-pages, live-check, deploy, cdn, fastly, gh-cli, first-publish]

requires:
  - phase: 02-01
    provides: BASE_SHA 기준 커밋, scripts/check-site.sh, .githooks/pre-push, 스크래치 compare.sh·norm_nocomment.py
provides:
  - 스크래치 라이브 확인 도구 $RP2/live-check.sh (pre / post <커밋> [--no-comments], 종료 코드 0·1·3)
  - 실제 배포 두 번(푸시 전 c4cb26d754e9, 푸시 뒤 db505d71d3d2)에서 끝까지 통과한 라이브 확인 기록
  - 첫 공개 범위와 검토 항목(누출·호스트 이름·로컬 경로, 끝 트리와 이력) 기록
  - 첫 공개 결정 HISTORY_DECISION=base-first와 기준 커밋 푸시 (원격 main c4cb26d754e9 → db505d71d3d2)
  - 표식 줄 HISTORY_PREV·PREPUSH_LIVE·HISTORY_DECISION·BASE_PUSH_SHA·LIVE_BASE_PUSH
affects: [02-03, 02-05, 02-07, 02-10]

actuals:
  tokens: 5900
  tasks: 3
  commits: 0
plan_head_before: 1eab7132d0aa487896a692d3f1b9367eef6c2358
plan_head_after: 1eab7132d0aa487896a692d3f1b9367eef6c2358

tech-stack:
  added: []
  patterns:
    - "라이브 신선도 판정: 맨 URL에 한 번 요청해 헤더와 본문을 함께 받고, Last-Modified >= Pages 빌드 created_at일 때만 본문을 비교에 씀"
    - "내부 파일 404는 age < (지금 - created_at)초일 때만 통과. 푸시 전에는 내부 파일 URL을 조회하지 않음"
    - "푸시는 <해시>:refs/heads/main 꼴로 승인된 커밋 하나만. 로컬 HEAD의 미승인 커밋은 함께 나가지 않음"
    - "기록에 붙인 live-check 출력은 GitHub Pages 빌드 기록(같은 commit·created_at, built, 오류 없음)으로 다시 확인"

key-files:
  created:
    - .planning/phases/02-jekyll-shared-shell-refactor/02-02-SUMMARY.md
  modified:
    - .planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md

key-decisions:
  - "첫 공개 방식 base-first (사용자 결정, Task 2 blocking-human checkpoint). 기준 커밋 db505d71d3d2만 원격 main에 푸시했고, 빌드 설정 커밋 7773b163f3de·7f13a622878b와 기록 커밋 1eab7132d0aa는 공개하지 않음. 푸시 ①은 02-03에서 따로 승인받음"
  - "새 배포가 바이트가 같은 파일의 Last-Modified도 올림을 이번 배포에서 관찰 (RESEARCH A2 성립, 1회 관찰). 그래서 Last-Modified 기준 판정을 그대로 씀"

patterns-established:
  - "푸시 직전 git fetch로 원격 main이 기록한 PREV와 같은지 확인하고, 다르면 푸시하지 않음"
  - "post 모드의 gh 쪽(배포 실행 찾기, gh run watch)은 이미 배포된 커밋으로 사이트 요청 없이 미리 시험할 수 있음"

requirements-completed: [SHELL-03]

coverage:
  - id: D1
    description: "라이브 확인 도구 live-check.sh가 현재 라이브(푸시 전)에서 통과: 빌드 기록 OK, 네 문서 OK(신선한 Last-Modified, 제목·정규화 본문 일치), 테마 파일 200"
    requirement: SHELL-03
    verification:
      - kind: other
        ref: "02-02-PLAN Task 1 verify 1·2·3 (기록 검사 + gh api pages/builds 대조)"
        status: pass
    human_judgment: false
  - id: D2
    description: "기준 커밋 db505d71d3d2만 원격 main에 푸시 (pre-push 훅 check-site 통과, 원격 main 전체 해시 = BASE_SHA, 빌드 설정 커밋 3개는 원격 main의 조상 아님)"
    requirement: SHELL-03
    verification:
      - kind: other
        ref: "02-02-PLAN Task 3 verify 1 (BASE_PUSH_SHA = BASE_SHA, merge-base --is-ancestor BASE_SHA origin/main)"
        status: pass
    human_judgment: false
  - id: D3
    description: "기준 커밋 배포 뒤 라이브 확인 통과: 네 URL 200·제목·본문 일치, 내부 파일 13개 신선한 404(/.planning/ROADMAP.md·/.claude/CLAUDE.md 포함), 테마 파일 200"
    requirement: SHELL-03
    verification:
      - kind: other
        ref: "live-check.sh post db505d71d3d2 (rc=0) + 02-02-PLAN Task 3 verify 2 (gh api pages/builds 대조)"
        status: pass
    human_judgment: false

duration: 46min
completed: 2026-11-16
status: complete
---

# Phase 2 Plan 02: 라이브 확인 도구와 첫 공개 결정 Summary

HISTORY_DECISION=base-first

**GitHub Pages 빌드 기록과 Last-Modified·age로 옛 CDN 캐시를 걸러 내는 라이브 확인 도구를 만들어 실제 배포 두 번에서 통과시켰다. 사용자가 고른 base-first대로 기준 커밋 db505d71d3d2 하나만 원격 main에 푸시했고, 배포 뒤 네 URL이 기준과 같고 처음 원격에 들어간 `.planning/`·`.claude/` 파일이 운영에서 404임을 확인했다.**

## Performance

- **Duration:** 약 46분 (Task 2에서 사람의 결정을 기다린 시간 포함)
- **Started:** 2026-11-16T01:50:50Z (02-01 기록 커밋 직후)
- **Completed:** 2026-11-16T02:37Z
- **Tasks:** 3/3 (Task 1 tracer, Task 2 checkpoint:decision, Task 3 auto)
- **Files modified:** 저장소 파일 1개(`02-EVIDENCE.md`) + 이 SUMMARY. 스크래치 `$RP2/live-check.sh`는 커밋하지 않음

## Accomplishments

- `$RP2/live-check.sh`(스크래치, 저장소 밖)를 RESEARCH 783-821행 조각대로 만들었다. pre 모드는 배포 대기 없이 현재 라이브를 보고 내부 파일 URL을 조회하지 않는다. post 모드는 `pages-build-deployment` 실행을 기다리고, 빌드 기록의 커밋·status·오류를 확인한 뒤 60초 간격 최대 12회로 문서 넷과 내부 파일 13개를 확인한다.
- 푸시 전 라이브(`c4cb26d754e9` 빌드)에서 `live-check.sh pre`가 통과했다 (`PREPUSH_LIVE=OK`).
- 첫 공개 범위(커밋 109개, 처음 공개되는 파일 74개)와 검토 항목(누출 1줄, 호스트 이름 0줄, 로컬 경로 끝 트리 27줄·이력 33줄)을 계산해 줄 수와 위치만 기록했다. 걸린 줄의 내용은 Task 2 checkpoint에서 사용자에게만 보였다.
- 사용자가 `base-first`를 골랐다. 푸시 직전 원격 main이 `HISTORY_PREV`와 같음을 확인하고 `git push origin <BASE_SHA>:refs/heads/main`으로 기준 커밋만 푸시했다. pre-push 훅이 `check-site: 통과 (커밋 db505d71d3d2, jekyll 3.10.0)`를 냈다.
- `live-check.sh post db505d71d3d2`가 첫 실행에서 rc=0으로 통과했다. `OK 빌드` 1줄, `OK 문서` 4줄, `OK 404` 13줄, `OK 테마` 1줄이고 FAIL과 STALE은 없다 (`LIVE_BASE_PUSH=OK`). 원격에 처음 들어간 내부 파일(`/.planning/ROADMAP.md`, `/.claude/CLAUDE.md`)이 운영에서 실제로 막힌다는 것을 처음 확인했다.

## Task Commits

이 계획은 task별 코드 커밋이 없다. 계획대로 저장소 파일은 `02-EVIDENCE.md` 하나만 고쳤고, 그 파일은 이 SUMMARY와 함께 docs 커밋 하나로 들어간다.

1. **Task 1: 라이브 확인 도구와 첫 공개 범위 기록** - 커밋 없음 (EVIDENCE는 docs 커밋에 포함)
2. **Task 2: 첫 공개 방식 결정 (checkpoint:decision, blocking-human)** - 사용자 답 `base-first`
3. **Task 3: 기준 커밋 푸시와 라이브 확인** - 커밋 없음. 원격 푸시 1회: `c4cb26d754e9` → `db505d71d3d2`

**Plan metadata:** docs 커밋 (`docs(02-02): …`, SUMMARY + EVIDENCE). 로컬에만 있고 푸시하지 않는다.

## Files Created/Modified

- `.planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md` - 구간 `## 02-02 라이브 확인 도구와 첫 공개 범위`(pre 출력, 빌드 기록, 첫 공개 범위, 검토 항목 위치, 훅 시험)와 `## 02-02 첫 공개 결정`(결정, 승인 범위, 푸시 전후 확인, post 출력) 추가
- `.planning/phases/02-jekyll-shared-shell-refactor/02-02-SUMMARY.md` - 이 문서
- 스크래치(커밋 안 함): `$RP2/live-check.sh`

## Decisions Made

- **첫 공개 방식 base-first** (사용자 결정). 승인은 기준 커밋 푸시 한 번에만 썼다. 빌드 설정 커밋(`7773b163f3de`, `7f13a622878b`)과 02-01 기록 커밋(`1eab7132d0aa`)은 원격 main의 조상이 아니다. 푸시 ①은 02-03에서 새로 승인받아야 한다.
- **Last-Modified 기준 신선도 판정을 그대로 쓴다.** 이 푸시는 네 문서의 바이트를 바꾸지 않았는데도 `last-modified`가 새 배포 시각(02:35:01Z, 빌드 `created_at` 02:34:28Z 이후)으로 올라갔다. RESEARCH A2가 이번 배포 한 번에서 성립했다. ETag로 판정을 바꿀 필요는 아직 없다.

## Deviations from Plan

None - plan executed exactly as written.

참고: post 모드 실행 전에, 이미 배포된 `HISTORY_PREV` 커밋으로 `gh run list --workflow pages-build-deployment -c <커밋>`과 `gh run watch`를 미리 시험했다 (읽기 전용, 사이트 URL 요청 없음). 계획에 없는 사전 확인이지만 아무것도 바꾸지 않았다. live-check.sh는 고치지 않았고 post는 한 번만 돌렸다.

## Issues Encountered

None

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- `HISTORY_DECISION=base-first`이므로 다음 계획 02-03(푸시 ①, 빌드 설정)으로 간다. 02-03의 푸시는 이 계획의 승인과 별개로 새 승인이 필요하다.
- 원격 main은 이제 `db505d71d3d2`이다. 02-03은 이 값을 `PUSH1_PREV`로 기록하고, 공개 범위는 `db505d71d3d2..<푸시 후보>`(빌드 설정·훅·기록 커밋)로 다시 계산한다.
- 라이브 확인 도구는 실제 배포에서 post 모드까지 증명됐다. 남은 푸시(①~④)에 그대로 쓴다.
- 이 계획의 docs 커밋과 상태 기록 커밋은 로컬에만 있다. 다음 승인된 푸시 때 함께 나간다.

## Self-Check: PASSED

- `02-EVIDENCE.md`에 `HISTORY_DECISION=base-first` 1줄, `BASE_PUSH_SHA=db505d71d3d2`, `LIVE_BASE_PUSH=OK`, 두 02-02 구간이 있다
- Task 1 verify 3개, Task 3 verify 2개 모두 exit 0 (Pages 빌드 기록 대조 포함)
- `git fetch` 뒤 원격 main 전체 해시 = `BASE_SHA` 전체 해시, 빌드 설정 커밋 3개는 원격 main의 조상이 아님
- 이 계획이 고친 저장소 파일은 `02-EVIDENCE.md`와 이 SUMMARY뿐 (`git status --porcelain`의 나머지는 실행 전부터 있던 변경)

---
*Phase: 02-jekyll-shared-shell-refactor*
*Completed: 2026-11-16*
