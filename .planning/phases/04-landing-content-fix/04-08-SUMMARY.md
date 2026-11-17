---
phase: 04-landing-content-fix
plan: 08
subsystem: deploy
tags: [site-01, push, tracer, live-check, docs]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "04-05: 첫 사이트 푸시 PUSH1_SHA=073d33e0e50a와 LIVE_PUSH1=OK, 비교 기준 C2_SHA=f8d66a6469cf. 04-06: 점검 6번 항목 CHECK6_SHA=a02573fe173f. 04-07: 문서 커밋 DOCS_CLAUDE1_SHA=4b9288d285af, DOCS_README1_SHA=5b00b906d609"
provides:
  - "원격 main = 6e46bdcb24e0 (PUSH2_SHA). 점검 6번 항목, 두 CLAUDE.md, README·원본 맵, 단계 기록이 공개됨"
  - "pre-push 훅이 이 푸시부터 6항목 점검으로 푸시할 SHA를 점검함"
  - "04-EVIDENCE.md `## 04-08 문서 푸시 후보`(PUSH2_CANDIDATE, PUSH2_PREV, OK docs files 4, OK site output unchanged, 훅 통과)와 `## 04-08 문서 푸시 라이브 확인`(PUSH2_SHA, OK 빌드, OK HTTP 넷, OK live index bytes = c2, OK 404 셋, LIVE_PUSH2=OK)"
affects: [04-09]

# Actuals (#2632)
actuals:
  tokens: 1070     # chars/4 over 이 계획이 더한 줄 (04-EVIDENCE.md 두 구간, SUMMARY 제외)
  tasks: 3         # tracer 1, checkpoint:decision 1, auto 1
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점, Task 1 EVIDENCE 커밋). SUMMARY·EVIDENCE docs 커밋은 이 뒤
plan_head_before: 6e46bdcb24e0f6e347b9f5b5d43747d70e1df0fd
plan_head_after: 4a41ddc233acc41de4d2335ac6dd7d6ac0b7bbbb

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "문서 푸시도 사이트 푸시와 같은 꼴: 후보를 실제 훅 경로로 통과 → SHA 이름으로 승인 → 원격이 그대로인지 확인 → 그 SHA만 `<sha>:refs/heads/main` 푸시 → 배포 built 확인 → ?cb= 라이브 확인 (Phase 3 03-09 재사용)"

key-files:
  created:
    - .planning/phases/04-landing-content-fix/04-08-SUMMARY.md
  modified:
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md

key-decisions:
  - "04-08: 사용자가 Task 2에서 PUSH2_CANDIDATE=6e46bdcb24e0의 푸시를 승인(push). 원격 main이 PUSH2_PREV=073d33e0e50a 그대로인 것을 확인하고 그 SHA만 한 번 푸시했다(훅 통과). Pages 빌드 built 2026-11-17T07:27:26Z, 네 URL 200·기대 제목, 라이브 / = c2 빌드 바이트, 내부 파일 셋 404 → LIVE_PUSH2=OK. 되돌리기 없음"

patterns-established: []

requirements-completed: [SITE-01]

coverage:
  - id: D1
    description: "문서 푸시 후보 범위의 .planning/ 밖 파일이 정확히 넷(.claude/CLAUDE.md, CLAUDE.md, README.md, scripts/check-site.sh)이고, 문서·점검 커밋이 모두 첫 푸시 뒤에 있으며, 후보 빌드가 빈 뱃지 커밋 빌드와 같고 실제 훅 경로를 통과함"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-08-PLAN.md Task 1 <verify> (exit 0, Task 3 뒤 다시 돌려도 exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "사람이 SHA를 보고 승인한 뒤에만 그 SHA를 푸시함"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-08-PLAN.md Task 2 checkpoint:decision (사용자 답 push)"
        status: pass
    human_judgment: true
  - id: D3
    description: "PUSH2_SHA = PUSH2_CANDIDATE이고 원격 main의 조상, 네 URL 200·기대 제목, 라이브 / = c2 빌드, 내부 파일 셋 404, FAIL 줄 없음"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-08-PLAN.md Task 3 <verify> 첫 명령 (exit 0)"
        status: pass
    human_judgment: false
  - id: D4
    description: "Pages 빌드 기록에 PUSH2_SHA·같은 created_at·built·오류 없음인 빌드가 있음"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-08-PLAN.md Task 3 <verify> 둘째 명령 (exit 0, 일치 1건)"
        status: pass
    human_judgment: false

# Metrics
duration: 15min
completed: 2026-11-17
---

# Phase 4 Plan 08: 문서 푸시 Summary

**SITE-01 갈래의 점검 6번 항목·두 CLAUDE.md·README·기록 문서를 사용자가 승인한 SHA `6e46bdcb24e0` 하나로 원격 main에 푸시했고, 배포 built 뒤 네 URL 200·제목, 라이브 `/`가 빈 뱃지 커밋 빌드와 바이트 같음, 내부 파일 셋 404를 확인했다 (`LIVE_PUSH2=OK`)**

SITE-01 갈래 완료, 단계는 앱 화면 캡처(작업 10)를 기다림.

## Performance

- **Duration:** 15 min (Task 2 승인 대기 포함)
- **Started:** 2026-11-17T07:17:01Z (04-07 마지막 커밋 시각, 이 계획 원장 기준)
- **Completed:** 2026-11-17T07:31:38Z (SUMMARY 작성 직전 측정 시각. SUMMARY docs 커밋은 이 뒤)
- **Tasks:** 3
- **Files modified:** 1 (검증 기록) + 이 SUMMARY

## Accomplishments

- 공개 저장소의 CLAUDE.md 두 사본과 점검 스크립트가 라이브 사이트와 맞춰졌다. 문서 커밋은 모두 첫 푸시(`073d33e0e50a`)의 라이브 확인 뒤에 나갔다 (Phase 3 D-21 원칙).
- 이 푸시부터 pre-push 훅이 6항목 점검(랜딩 출력의 포인트·굿즈·코스북 검사 포함)으로 푸시할 SHA를 점검한다. 이번 푸시에서 `check-site: 통과 (커밋 6e46bdcb24e0, jekyll 3.10.0)`.
- 푸시는 사이트 출력을 바꾸지 않았다: 후보 빌드가 빈 뱃지 커밋(`f8d66a6469cf`) 빌드와 `diff -r` 빈 출력이고, 라이브 `/`와 법적 세 문서가 그 빌드와 바이트가 같다.
- `/CLAUDE.md`, `/README.md`, `/scripts/check-site.sh`가 라이브에서 404다 (SHELL-03 유지).

## Task Commits

1. **Task 1: 문서 푸시 후보 검증 (tracer)** - `4a41ddc233ac` (docs, EVIDENCE `## 04-08 문서 푸시 후보`)
2. **Task 2: 문서 푸시 승인 (checkpoint:decision, blocking-human)** - 커밋 없음. 사용자 답 push
3. **Task 3: 승인 SHA 푸시와 라이브 확인** - 푸시 `073d33e..6e46bdc -> main`. 기록은 아래 SUMMARY·EVIDENCE docs 커밋에 들어감

**Plan metadata:** SUMMARY·EVIDENCE docs 커밋 (이 SUMMARY 뒤, 푸시하지 않음. 다음 푸시 때 함께 나감)

## Files Created/Modified

- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` - `## 04-08 문서 푸시 후보`(Task 1), `## 04-08 문서 푸시 라이브 확인`(Task 3)
- `.planning/phases/04-landing-content-fix/04-08-SUMMARY.md` - 이 문서

## Live Check Results

```
check-site: 통과 (커밋 6e46bdcb24e0, jekyll 3.10.0)
OK 빌드 6e46bdcb24e0 built 2026-11-17T07:27:26Z
OK HTTP / 200 title=러닝펜슬 - 달리고 걷는 길이 아트가 됩니다
OK HTTP /privacy-policy/ 200 title=개인정보처리방침 - 러닝펜슬
OK HTTP /terms/ 200 title=서비스 이용약관 - 러닝펜슬
OK HTTP /data-deletion/ 200 title=데이터 삭제 안내 - 러닝펜슬
OK live index bytes = c2
OK 404 /CLAUDE.md
OK 404 /README.md
OK 404 /scripts/check-site.sh
LIVE_PUSH2=OK
```

## Decisions Made

- 푸시 전 스크래치 확인(`04-05-PLAN.md` `<scratch_regen>` (가)·(나))에서 모두 있고 트리가 맞아 다시 만든 것이 없었다. 그래서 `REGEN`·`regen ` 줄을 적지 않았다(절차대로).
- 승인은 이 SHA의 푸시 한 번에만 썼다. 되돌리기는 필요 없었다.

## Deviations from Plan

None - plan executed exactly as written.

참고(실행 도구, 계획 변경 아님): 배포 완료를 20초 간격으로 읽는 스크래치 스크립트가 탭으로 나눈 필드에서 빈 오류 칸을 건너뛰어 built를 알아보지 못했다. 같은 `gh api .../pages/builds/latest`를 JSON으로 직접 읽어 `commit`이 푸시한 전체 해시, `status: built`, `error.message: null`, `created_at 2026-11-17T07:27:26Z`임을 확인했고, verify 둘째 명령이 빌드 목록에서 같은 빌드 1건을 대조했다.

## Issues Encountered

None

## Known Stubs

None

## Threat Flags

None. 새 네트워크 경로·인증·파일 접근은 없다. T-04-18(승인과 다른 커밋 배포)은 원격 확인 뒤 승인 SHA만 푸시하고 verify가 `PUSH2_SHA == PUSH2_CANDIDATE`로 막았고, T-04-19(내부 문서 공개)는 세 경로 404로 확인했다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 04-09: 앱 화면 캡처(작업 10, 사용자 제공)를 기다린다. 그동안 Phase 5를 먼저 진행해도 된다(ROADMAP Progress).
- 로컬 main에는 이 계획의 SUMMARY·EVIDENCE docs 커밋과 STATE·ROADMAP 커밋이 원격보다 앞서 있다. 다음 푸시 때 함께 나간다.

---
*Phase: 04-landing-content-fix*
*Completed: 2026-11-17*

## Self-Check: PASSED

- `04-08-SUMMARY.md`와 `04-EVIDENCE.md`가 디스크에 있다.
- Task 1 커밋 `4a41ddc233ac`가 HEAD의 조상이고, 푸시한 `6e46bdcb24e0`이 원격 main의 조상이다. 계획 원장 기준 커밋 수 1(SUMMARY 작성 시점).
- Task 1 verify 한 명령, Task 3 verify 두 명령이 모두 exit 0이다.
- 기록 누출 검사(홈 경로 변수 문자열, 사용자 홈 폴더 꼴, macOS 임시 폴더 꼴)가 두 문서에서 0줄이다.
