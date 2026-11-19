---
phase: 05-business-info-support-contact
plan: 01
subsystem: testing
tags: [baseline, playwright, footer, support, jekyll, negative-control]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "Phase 4 스크래치 rp-p4/pw의 package.json·pnpm-lock.yaml (playwright 1.59.1·pngjs 7.0.0 고정)"
provides:
  - "05-EVIDENCE.md 머리 규칙(D-02, 표식 줄·보류 규칙)과 `## 05-01 기준`: BASE_SHA=2db88d9a199f, BASE_LIVE=84a5d9114ef3, check-site 통과, OK HTTP 네 줄, OK base support=absent mailto=0 phone=0 supportlinks=0, OK site-clean 05-01-t1"
  - "05-EVIDENCE.md `## 05-01 도구`: 사용자 결정(install, 브라우저 포함), PW_VERSION=1.59.1, PW_BROWSERS, p5-foot.mjs 기준 16줄 PASS foot, p5-support.mjs 기준 /support/ 404 FAIL support, TOOLS_BASE=OK, OK site-clean 05-01-t3"
  - "스크래치 $W(저장소 옆, 커밋 안 함): lib.sh(함수 열 개), pw/(playwright 1.59.1, pngjs 7.0.0, p5-foot.mjs, p5-support.mjs), 기준 빌드 $W/base"
affects: [05-02, 05-03, 05-04, 05-05, 05-06, 05-07, 05-08, 05-09, 05-10, 05-11, 05-12, 05-13, 05-14, 05-15]

# Actuals (#2632)
actuals:
  tokens: 1141     # chars/4 over 05-EVIDENCE.md (이 계획이 만든 저장소 파일, 4565자. SUMMARY 제외)
  tasks: 3
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD. 기록 전용 계획이라 task 커밋이 없고, EVIDENCE와 이 SUMMARY는 뒤 docs 커밋 하나로 들어간다
plan_head_before: 2db88d9a199f9920851e4fc857788fbcb56b6c6e
plan_head_after: 2db88d9a199f9920851e4fc857788fbcb56b6c6e

# Tech tracking
tech-stack:
  added: ["playwright 1.59.1 (스크래치 전용, pnpm, Phase 4 lockfile로 --frozen-lockfile)", "pngjs 7.0.0 (같은 lockfile, 스크래치 전용)"]
  patterns:
    - "푸터 판정은 p5-foot.mjs 하나로: 두 엔진 × 375·1280 × 네 문서(+ 200이면 /support/), 문서마다 OK rows·spans·seps·links·sepLead 줄 또는 FAIL split·overflow·badLink·console·error 줄, 끝 줄 PASS foot / FAIL foot"
    - "지원 페이지 판정은 p5-support.mjs 하나로: /support/ 상태를 요청 API로 먼저 보고(404 내비게이션 콘솔 오류를 피함), 200이면 구조·mailto·dl·dt·hdr·ftr·anchor, 이어 네 문서 supportlinks 줄은 언제나 찍는다"
    - "스크래치 $W는 임시 폴더가 아니라 메인 체크아웃 옆 <저장소 폴더 이름>-p5-scratch"

key-files:
  created:
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md
    - .planning/phases/05-business-info-support-contact/05-01-SUMMARY.md
  modified: []

key-decisions:
  - "Task 2: 사용자가 install(브라우저 내려받기 포함)으로 승인. 범위는 playwright@1.59.1·pngjs@7.0.0 고정, pnpm, 스크래치 $W/pw에만, Phase 5 동안 같은 버전·같은 경로 재설치와 리비전이 없을 때의 브라우저 내려받기 포함"
  - "브라우저 리비전(chromium-1217, webkit-2272, chromium_headless_shell-1217)이 캐시에 있어 새로 받지 않았다"
  - "p5-foot.mjs의 split은 getClientRects 상자 수가 아니라 상자들이 놓인 줄 수로 판정한다 (Chromium의 상자 없는 inline span 오탐 때문)"
  - "요구사항 BIZ-02·SUP-01은 완료 처리하지 않았다. 이 계획은 기준과 판정 도구만 만들고, 사업자 행·지원 페이지는 뒤 계획 몫이다"

patterns-established:
  - "뒤 계획들은 후보 빌드마다 `node \"$W/pw/p5-foot.mjs\" http://127.0.0.1:<포트>`와 `node \"$W/pw/p5-support.mjs\" http://127.0.0.1:<포트>`를 돌려 PASS foot / PASS support를 본다. 라이브는 `https://runningpencil.com '?cb=<12자리>'`"

requirements-completed: []

coverage:
  - id: D1
    description: "기준 커밋·원격 main 기록, 기준을 운영과 같은 빌드로 서빙해 네 URL 200·기대 제목, 기준에 지원 페이지·mailto·전화·지원 링크 없음"
    requirement: "BIZ-02"
    verification:
      - kind: command
        ref: "05-01-PLAN.md Task 1 <verify> (Task 3 뒤 다시 실행, exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "Playwright 1.59.1 설치 승인(blocking-human)과 승인 범위 안 설치"
    verification:
      - kind: other
        ref: "Task 2 사용자 응답 install(브라우저 포함), Task 3 <verify> 둘째 명령의 버전 확인"
        status: pass
    human_judgment: true
    rationale: "외부 패키지 설치는 사람의 승인이 필요하다 (T-05-SC). 승인은 받았다"
  - id: D3
    description: "p5-foot.mjs가 기준에서 두 엔진 × 두 폭 × 네 문서 16줄 rows=3 spans=0 seps=0 links=0 sepLead=0과 PASS foot, p5-support.mjs가 기준에서 /support/ 404 FAIL과 FAIL support(음성 대조), supportlinks=0 16줄"
    requirement: "SUP-01"
    verification:
      - kind: command
        ref: "05-01-PLAN.md Task 3 <verify> 두 명령 (exit 0)"
        status: pass
    human_judgment: false

duration: 18 min
completed: 2026-11-19
---

# Phase 5 Plan 01: 기준과 판정 도구 Summary

**사이트 파일을 고치기 전 HEAD(2db88d9a199f)를 운영과 같은 빌드로 기준 삼고, Playwright 1.59.1 위의 `p5-foot.mjs`가 그 기준에서 두 엔진 × 두 폭 × 네 문서 16줄 모두 통과하고 `p5-support.mjs`는 지원 페이지가 없는 기준에서 `/support/` 404로 실패함(음성 대조)을 기록했다.**

## Performance

- **Duration:** 약 18분 (Task 2 승인 대기와 Task 3 이어 하기 포함)
- **Completed:** 2026-11-19
- **Tasks:** 3 (Task 1 tracer, Task 2 결정, Task 3 auto)
- **Files modified:** 1 (`05-EVIDENCE.md`, 새 파일) + 이 SUMMARY

## Accomplishments

- 기준 `BASE_SHA=2db88d9a199f`와 원격 main `BASE_LIVE=84a5d9114ef3`를 기록했고, 두 커밋의 `.planning/` 밖 트리가 같다(기준 = 지금 라이브 사이트).
- 기준 출력을 production·`--safe`로 `$W/base`에 빌드해 띄워 `/`와 법적 세 URL이 200·기대 제목임을 확인했다. 기준에는 `/support/`, `mailto:`, 「전화」, `/support/` 링크가 하나도 없다.
- Task 2 승인 범위 안에서 Phase 4 lockfile로 `playwright@1.59.1`·`pngjs@7.0.0`을 `$W/pw`에 `--frozen-lockfile` 설치했다(브라우저는 캐시 그대로).
- `p5-foot.mjs`가 기준에서 16줄 모두 `rows=3 spans=0 seps=0 links=0 sepLead=0`과 `PASS foot`(종료 코드 0)을 냈다.
- `p5-support.mjs`가 기준에서 네 문맥 모두 `/support/ 404` FAIL과 끝 줄 `FAIL support`(종료 코드 4)를 냈고, 네 문서 `supportlinks=0` 16줄을 냈다.

## Task Commits

이 계획은 사이트·코드를 바꾸지 않는 기록 전용 계획이라 task 커밋이 없다. `05-EVIDENCE.md`와 이 SUMMARY는 계획 `<output>`대로 하나의 docs 커밋으로 들어간다.

1. **Task 1: 기준 기록·빌드·서빙·HTTP·기준 개수 (tracer)** — 커밋 없음 (EVIDENCE `## 05-01 기준`)
2. **Task 2: Playwright 1.59.1 재설치 승인 (checkpoint:decision, blocking-human)** — 커밋 없음, 응답 install(브라우저 내려받기 포함)
3. **Task 3: p5-foot.mjs 기준 통과·p5-support.mjs 음성 대조 실패** — 커밋 없음 (EVIDENCE `## 05-01 도구`)

## Files Created/Modified

- `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` — 머리 규칙, `## 05-01 기준`, `## 05-01 도구` 구간과 표식 줄
- `.planning/phases/05-business-info-support-contact/05-01-SUMMARY.md` — 이 문서
- 저장소 밖 스크래치(커밋 안 함): `$W/lib.sh`, `$W/pw/{package.json,pnpm-lock.yaml,node_modules,p5-foot.mjs,p5-support.mjs}`, `$W/base`, `$W/tools-foot.txt`, `$W/tools-support.txt`

## Decisions Made

- 설치는 사용자 승인(install, 브라우저 포함) 뒤 pnpm `--frozen-lockfile`로만 했다. 기록에는 버전과 리비전 이름만 적었다.
- 브라우저 리비전이 캐시에 있어 Microsoft CDN에서 받지 않았다.
- 요구사항 BIZ-02·SUP-01은 완료 처리하지 않았다. 이 계획은 기준과 판정 도구만 만들었고, 기준 출력의 `/support/`는 404다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] p5-foot.mjs split 판정의 Chromium 오탐**
- **Found during:** Task 3 (기준 판정 전 스크래치 시험 페이지 자가 시험)
- **Issue:** 사양 그대로 `getClientRects().length > 1`을 split으로 보면, Chromium은 상자 없는 inline `span` 안에 링크가 있을 때 같은 줄에서도 상자를 조각마다 따로 낸다(같은 top, 상자 2개). 끊기지 않은 항목이 split으로 잡혔다. WebKit은 상자 1개였다.
- **Fix:** 상자 수 대신 상자들이 놓인 줄 수(위 끝이 반 줄 넘게 다르면 다른 줄)를 세고, 높이 1.5배 기준은 그대로 둔다. `getClientRects`는 그대로 쓴다. 기준 판정 결과는 바뀌지 않는다(기준 푸터에는 `span`이 없다).
- **Files modified:** `$W/pw/p5-foot.mjs` (스크래치, 커밋 안 함). EVIDENCE `## 05-01 도구`에 한 문단으로 적었다.
- **Commit:** 없음

그 밖에 사양에 없는 세부: `p5-support.mjs`의 `/support/` 상태와 `p5-foot.mjs`의 `/support/` 포함 여부는 페이지 내비게이션이 아닌 요청 API로 본다(404 내비게이션이 콘솔 오류를 만들지 않게). 두 스크립트 모두 측정 전에 `document.fonts.ready`를 기다린다. `p5-support.mjs`의 종료 코드는 `Math.min(실패 수, 255)`다.

## Issues Encountered

None. 스크래치 시험 페이지(`$W/selftest`, 시험 뒤 지움)로 기준에서 돌지 않는 경로도 확인했다: split·badLink(링크 색 `rgb(0, 0, 238)`로 FAIL), sepLead(줄 앞 `·`이면 1), `p5-support.mjs` 200 경로(`ids=contact,report,faq mailto=1 dl=1 dt=1`, 375 `hdr=0 ftr=1`, 1280 `hdr=1 ftr=1`, `anchor=ok`, `?cb=` 쿼리, `PASS support`).

## User Setup Required

None.

## Next Phase Readiness

- 05-02부터 `BASE_SHA`, `$W/lib.sh`, `$W/pw/p5-foot.mjs`·`p5-support.mjs`, `$W/base/site`를 그대로 쓴다.
- `$W`는 저장소 옆이라 임시 폴더 정리로 지워지지 않는다. 사람이 지웠을 때는 scratch_contract 「스크래치 재확인」 절차로 같은 고정 버전·같은 경로에 다시 만든다(이번 승인 범위 안).

## Self-Check: PASSED

- FOUND: `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` (BASE_SHA·BASE_LIVE·PW_VERSION·PW_BROWSERS·TOOLS_BASE 표식, `OK site-clean 05-01-t1/t3 2db88d9a199f`)
- FOUND: `$W/lib.sh`(함수 열 개), `$W/pw/p5-foot.mjs`, `$W/pw/p5-support.mjs`, `$W/pw/node_modules/playwright` 1.59.1, `$W/base/TREE` = BASE_SHA 트리
- Task 1 verify, Task 3 verify 두 명령 exit 0. 작업 트리 `scripts/check-site.sh` 통과. EVIDENCE에 홈 경로·`/private/var`·`/Users/`·지원 주소 없음. 저장소에 `*.mjs`·`node_modules`·`package.json`·`pnpm-lock.yaml` 추적 없음.
