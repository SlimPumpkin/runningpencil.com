---
phase: 05-business-info-support-contact
plan: 09
subsystem: infra
tags: [dns, gabia, mx, spf, search-console, site-03, evidence]
status: complete

# Dependency graph
requires:
  - phase: 05-business-info-support-contact
    provides: "05-08의 HOLD_UI=OK(Task 1 precondition), CONTEXT D-01의 2026-11-19 아침 dig 관찰(변경 전 기록), 사용자 작업 0~3 완료(가비아 DNS의 MX·SPF·google-site-verification TXT)"
provides:
  - "05-EVIDENCE.md `## 05-09 DNS`: DNS_BEFORE 줄, 권한 있는 네임서버·공개 리졸버 판정 줄, HTTPS 200, site-clean 기록, DNS_AFTER=OK (개수와 종류만)"
  - "05-EVIDENCE.md `## 05-09 Search Console`: 사용자 보고 근거 줄, 날짜 메모, SC_VERIFIED=OK, SC_DATE=2026-11-19, site-clean 기록, SITE03=OK"
affects: [05-10, 05-14, 05-15]

# Actuals (#2632)
actuals:
  tokens: 385      # chars/4: 이 계획이 05-EVIDENCE.md에 더한 줄 1541자. SUMMARY 제외
  tasks: 3
  commits: 2       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). 이 SUMMARY와 STATE·ROADMAP 기록은 뒤 docs 커밋
plan_head_before: 73b5852fc23a632948c9ab36724419e391a39f54
plan_head_after: 15fad96ef4eebee4a3fc2b59cc36dcc620c1d349

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "DNS 증거: 권한 있는 네임서버와 공개 리졸버에 질의를 명령에 직접 써서 묻고(Pitfall 9·10), 기록에는 줄 수와 종류만 남긴다. 토큰·TXT 값·IP 주소·라우터 호스트 이름은 적지 않는다"
    - "Search Console 「확인됨」은 사용자 계정 안에서만 보이므로 사용자 보고 한 줄과 날짜로 판정하고, dig의 gsv 줄은 TXT가 있다는 근거로만 쓴다"

key-files:
  created:
    - .planning/phases/05-business-info-support-contact/05-09-SUMMARY.md
  modified:
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md

key-decisions:
  - "작업 7 보고가 「확인됨」이라 05-09에서 SITE03=OK를 세웠다. 05-14는 SC_PENDING 갈래 없이 SITE03=OK가 있는 쪽 precondition으로 간다"
  - "SC_DATE는 2026-11-19다. 사용자가 처음에 2026-11-18로 보고했으나 CONTEXT D-01의 2026-11-19 아침 관찰(TXT 0줄)보다 앞서 다시 확인을 받았고, 사용자가 2026-11-19로 정정했다. 정정 이력은 EVIDENCE 날짜 메모에 남겼다"

patterns-established:
  - "체크포인트 뒤 이어 실행할 때도 task 구간마다 `OK site-clean <계획>-t<n> <12자리>` 줄을 그 자리에서 찍어 적는다"

requirements-completed: [SITE-03]

coverage:
  - id: D1
    description: "DNS 변경 전후 기록: 권한 있는 네임서버 기준 A 4·MX Google 하나·SPF 한 줄·google-site-verification TXT 한 줄·www CNAME·GitHub Pages challenge 보존, 공개 리졸버도 같은 개수, DKIM 0줄(작업 6 전, 막지 않음), HTTPS 200. 기록에 토큰·SPF 본문·IP 꼴 0건"
    requirement: "SITE-03"
    verification:
      - kind: other
        ref: "05-09-PLAN.md Task 1 <verify> (65a997a7da5f 커밋 뒤, 그리고 Task 3 뒤 다시 실행 exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "Search Console이 runningpencil.com 도메인 속성을 「확인됨」으로 표시한다는 사용자 보고(작업 7, 2026-11-19)가 기록되고 SITE03=OK가 섰다"
    requirement: "SITE-03"
    verification:
      - kind: other
        ref: "05-09-PLAN.md Task 3 <verify> (exit 0)"
        status: pass
    human_judgment: true
    rationale: "Search Console의 「확인됨」 상태는 사용자 계정 안에서만 보이므로 기록은 사용자 보고에 기댄다. verify는 기록 꼴만 본다. 처음 보고 날짜(2026-11-18)가 D-01 아침 관찰보다 앞서 사용자가 다시 확인했고 2026-11-19로 정정했다"

# Metrics
duration: 1h 54m
completed: 2026-11-19
---

# Phase 5 Plan 09: DNS 증거와 Search Console 확인 Summary

**권한 있는 네임서버·공개 리졸버 dig로 MX(Google 하나)·SPF 한 줄·Search Console TXT·보존 레코드·HTTPS 200을 값 없이 기록하고, 작업 7 「확인됨」 사용자 보고(2026-11-19)로 SITE-03을 닫음**

## Performance

- **Duration:** 1h 54m (Task 2 사용자 보고 대기 포함)
- **Started:** 2026-11-19T05:25:59Z
- **Completed:** 2026-11-19T07:20:03Z
- **Tasks:** 3 (Task 1 tracer, Task 2 checkpoint:human-action, Task 3 auto)
- **Files modified:** 1 (`05-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- `## 05-09 DNS`: 변경 전 줄(CONTEXT D-01 아침 관찰)과 변경 후 판정 줄을 남겼습니다. 권한 있는 네임서버에서 A 4, MX 1(Google), TXT 2(SPF 1, gsv 1), `www`는 GitHub Pages, challenge 1, DKIM 0이고, 공개 리졸버도 MX 1·SPF 1·gsv 1입니다. HTTPS는 `HTTP/2 200`입니다. `DNS_AFTER=OK`.
- `## 05-09 Search Console`: 사용자 보고 「작업 7 끝남, 도메인 속성 확인됨」을 근거 줄로 적고 `SC_VERIFIED=OK`, `SC_DATE=2026-11-19`, `SITE03=OK`를 세웠습니다. 처음 보고 날짜(2026-11-18)를 사용자가 2026-11-19로 정정한 이력을 같은 구간 날짜 메모에 적었습니다.
- 작업 7이 이 계획에서 닫혔으므로 05-14는 Search Console 보고를 다시 받지 않아도 됩니다.

## Task Commits

1. **Task 1: DNS 변경 후 기록과 HTTPS 확인 (tracer)** - `65a997a7da5f` (docs)
2. **Task 2: 작업 7 결과 받기 (checkpoint:human-action, blocking-human)** - 커밋 없음. 사용자 답 「작업 7 끝남, 도메인 속성 확인됨. 2026-11-18」, 뒤에 날짜를 「19일로 바꿔」로 정정
3. **Task 3: 작업 7 보고 기록, SITE-03 닫음** - `15fad96ef4ee` (docs)

**Plan metadata:** 이 SUMMARY 커밋과 STATE·ROADMAP·REQUIREMENTS 기록 커밋

## Files Created/Modified

- `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` - 구간 `## 05-09 DNS`, `## 05-09 Search Console`
- `.planning/phases/05-business-info-support-contact/05-09-SUMMARY.md` - 이 문서

## Verification

- Task 1 `<verify>`: exit 0 (Task 3 뒤 다시 실행해도 exit 0)
- Task 3 `<verify>`: exit 0 (「확인됨」 갈래)
- 계획 `<verification>`: Task 1·3 verify가 exit 0이고, 이 계획이 고친 저장소 파일은 `05-EVIDENCE.md` 하나입니다(SUMMARY 제외). 사이트 파일과 보류 브랜치는 그대로이고 두 task 모두 `OK site-clean` 줄이 있습니다.
- 커밋 전 점검: 작업 트리 `scripts/check-site.sh` 통과. 값 누출 점검 `vals filled=4 emitted=3 excluded=1`, (a) `.planning` 0건, (b) 커밋 메시지 0건, (c) 스테이징 diff 0건.

## Decisions Made

- 작업 7 「확인됨」 갈래로 Task 3의 1~2번을 실행했습니다. `SC_PENDING=OK`는 적지 않았습니다.
- `SC_DATE`는 2026-11-19입니다. 처음 보고는 2026-11-18이었으나 CONTEXT D-01의 2026-11-19 아침 관찰(TXT 0줄)보다 앞서 사용자에게 다시 확인을 받았고, 사용자가 2026-11-19로 정정했습니다.

## Deviations from Plan

**1. [커밋 형식] 커밋 메시지 끝 attribution 줄 두 개**
- **Found during:** Task 3 커밋
- **Issue:** 05-01 「모든 task에 적용하는 규칙」은 메시지 마지막 줄을 `Co-Authored-By` 한 줄로 정했고, 이 이어 실행의 오케스트레이터 지시는 `Co-Authored-By`와 `Claude-Session` 두 줄을 정했습니다.
- **Fix:** 더 새롭고 명시적인 오케스트레이터 지시대로 두 줄을 붙였습니다. 05-10~05-15 계획의 verify 가운데 커밋 메시지 마지막 줄을 검사하는 것은 없습니다(grep 확인).
- **Committed in:** `15fad96ef4ee`, 이 SUMMARY 커밋, 기록 커밋

**2. [커밋 묶음] EVIDENCE와 SUMMARY를 따로 커밋**
- **Issue:** 계획 `<output>`은 SUMMARY와 `05-EVIDENCE.md`를 같은 문서 커밋으로 하라고 적었지만, Task 1이 체크포인트 전에 이미 따로 커밋됐고 오케스트레이터가 Task 3 커밋과 SUMMARY 커밋을 따로 요구했습니다.
- **Fix:** Task 3(EVIDENCE) → SUMMARY → STATE·ROADMAP·REQUIREMENTS 순서로 세 커밋을 했습니다. 모두 `main`의 문서 커밋이고 사이트 파일은 섞이지 않았습니다.

---

**Total deviations:** 2 (모두 커밋 형식·묶음, 기록 내용에는 영향 없음)
**Impact on plan:** 없음. 표식과 판정은 계획 그대로입니다.

## Issues Encountered

None

## User Setup Required

None - 작업 7은 이 계획에서 끝났습니다. 남은 사용자 작업(작업 4 수신 시험, 작업 5 보내기 설정, 작업 6 DKIM)은 05-10·05-14에서 받습니다.

## Next Phase Readiness

- 05-10(이메일 게이트 준비)의 precondition 가운데 `DNS_AFTER=OK`가 섰습니다.
- 05-14 Task 1 precondition의 `SITE03=OK`(05-09에서 닫힘) 갈래가 섰습니다. 05-14 Task 2는 작업 5 보고만 받으면 됩니다.
- 아무것도 원격에 푸시하지 않았습니다.

## Self-Check: PASSED

- FOUND: `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md`
- FOUND: `65a997a7da5f` (HEAD의 조상)
- FOUND: `15fad96ef4ee` (HEAD의 조상)
- Task 1·3 `<verify>` 다시 실행 exit 0

---
*Phase: 05-business-info-support-contact*
*Completed: 2026-11-19*
