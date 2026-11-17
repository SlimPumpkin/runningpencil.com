---
phase: 04-landing-content-fix
plan: 02
subsystem: testing
tags: [baseline, playwright, behave, jekyll, sc3, negative-control]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "04-01: 04-EVIDENCE.md 머리·기록 규칙, DOCS_BASE_SHA=760d0e93e9ce"
provides:
  - "04-EVIDENCE.md `## 04-02 기준`: BASE_SHA=0e75e8b88fd2, BASE_LIVE=0bfe5b210c3c, check-site 통과, OK HTTP 네 줄, OK words index=2 privacy-policy=6 terms=6 data-deletion=3, OK base empty-badges=5, OK base index = 90d8046"
  - "04-EVIDENCE.md `## 04-02 도구와 기준 동작`: PW_VERSION=1.59.1, PW_BROWSERS, 기준 판정 PASS behave(두 엔진 × 세 문맥), 음성 대조 FAIL behave + pageerror, BEHAVE_BASE=OK, BEHAVE_NEG=OK"
  - "스크래치 $W(커밋 안 함): lib.sh(build·build_src·serve·stop), pw/(playwright 1.59.1, p4-behave.mjs), 기준 빌드 $W/base, 음성 대조 빌드 $W/neg"
affects: [04-03, 04-04, 04-05, 04-06, 04-07, 04-08, 04-09, 04-10, 04-11, 04-12, 04-13]

# Actuals (#2632)
actuals:
  tokens: 975      # chars/4 over 04-EVIDENCE.md에 더한 줄 (이 계획이 바꾼 저장소 파일. SUMMARY 제외)
  tasks: 3
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD. 사이트·코드 변경 없는 기록 전용 계획이라 task 커밋이 없고, 기록은 이 SUMMARY 뒤 docs 커밋 하나로 들어간다
plan_head_before: 0e75e8b88fd23d5fbc274b965639aef675379d7a
plan_head_after: 0e75e8b88fd23d5fbc274b965639aef675379d7a

# Tech tracking
tech-stack:
  added: ["playwright 1.59.1 (스크래치 전용, pnpm, Phase 3 lockfile로 --frozen-lockfile)", "pngjs 7.0.0 (같은 lockfile에 함께 있음, 스크래치 전용)"]
  patterns:
    - "SC3 판정은 p4-behave.mjs 하나로: 두 엔진 × (1280 기본, 375 기본, 1280 움직임 줄이기), 문맥마다 OK 줄, 끝 줄 PASS behave / FAIL behave, 종료 코드"
    - "판정 도구 민감도는 스크래치 사본에서만 스크립트 계약을 깨(rp-run-btn id) 실패를 확인해 보인다"

key-files:
  created:
    - .planning/phases/04-landing-content-fix/04-02-SUMMARY.md
  modified:
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md

key-decisions:
  - "Task 2: 사용자가 install(브라우저 내려받기 포함)으로 승인. 범위는 playwright@1.59.1 고정, pnpm, 스크래치 $W/pw에만, Phase 4 동안 같은 버전·같은 경로 재설치 포함"
  - "브라우저 리비전(chromium-1217, chromium_headless_shell-1217, webkit-2272)이 1.59.1 요구와 같아 캐시를 그대로 쓰고 새로 받지 않았다"
  - "p4-behave.mjs는 문맥마다 판정 전체를 try/catch로 감싸고, 클릭·스크롤 대기는 5초로 줄여 음성 대조가 오래 걸리지 않게 했다"

patterns-established:
  - "뒤 계획들은 사이트 커밋 후보마다 `node \"$W/pw/p4-behave.mjs\" http://127.0.0.1:<포트>`를 돌려 PASS behave와 OK 줄 6개를 본다"

requirements-completed: []

coverage:
  - id: D1
    description: "기준 커밋·원격 main 기록, 기준을 운영과 같은 빌드로 서빙해 네 URL 200·기대 제목, SC1 범위 낱말 수 기록"
    requirement: "SITE-01"
    verification:
      - kind: command
        ref: "04-02-PLAN.md Task 1 <verify> (Task 3 뒤 다시 실행, exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "Playwright 1.59.1 설치 승인(blocking-human)과 승인 범위 안 설치"
    requirement: "SITE-06"
    verification:
      - kind: other
        ref: "Task 2 사용자 응답 install(브라우저 포함), Task 3 <verify> 둘째 명령의 버전 확인"
        status: pass
    human_judgment: true
  - id: D3
    description: "p4-behave.mjs가 기준에서 두 엔진 × 세 문맥 PASS behave, 스크립트 계약을 깬 사본에서 FAIL behave + pageerror"
    requirement: "SITE-06"
    verification:
      - kind: command
        ref: "04-02-PLAN.md Task 3 <verify> 두 명령 (exit 0)"
        status: pass
    human_judgment: false

duration: 11 min
completed: 2026-11-17
---

# Phase 4 Plan 02: 기준과 판정 도구 Summary

**사이트 파일을 고치기 전 HEAD(0e75e8b88fd2)를 운영과 같은 빌드로 기준 삼고, Playwright 1.59.1 위의 `p4-behave.mjs`가 그 기준에서 Chromium·WebKit × 세 문맥 모두 통과하고 `rp-run-btn` id를 깬 사본에서는 `pageerror`와 함께 실패함을 기록했다.**

## Performance

- **Duration:** 약 11분 (Task 3 이어 하기 포함, 2026-11-17T04:27:13Z 시작)
- **Completed:** 2026-11-17
- **Tasks:** 3 (Task 1 tracer, Task 2 결정, Task 3 auto)
- **Files modified:** 1 (`04-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- 기준 `BASE_SHA=0e75e8b88fd2`와 원격 main `BASE_LIVE=0bfe5b210c3c`를 기록했고, 두 커밋의 `.planning/` 밖 트리가 같다(기준 = 지금 라이브 사이트).
- 기준 출력을 production·`--safe`로 빌드해 `python3 -m http.server`로 띄워 `/`와 법적 세 URL이 200·기대 제목임을 확인했다. 낱말 수는 index 2, privacy-policy 6, terms 6, data-deletion 3, 빈 뱃지 5.
- Task 2 승인 범위 안에서 Phase 3 lockfile로 `playwright@1.59.1`을 `$W/pw`에 설치했다(브라우저는 캐시 그대로).
- `p4-behave.mjs`가 기준에서 OK 줄 6개와 `PASS behave`를 냈고(첫 시도 통과, 스크립트 수정 없음), 음성 대조 사본에서는 여섯 문맥 모두 `pageerror`와 끝 줄 `FAIL behave`, 종료 코드 1을 냈다.

## Task Commits

이 계획은 사이트·코드를 바꾸지 않는 기록 전용 계획이라 task 커밋이 없다. `04-EVIDENCE.md`와 이 SUMMARY는 계획 `<output>`대로 하나의 docs 커밋으로 들어간다.

1. **Task 1: 기준 기록·빌드·서빙·HTTP·낱말 수 (tracer)** — 커밋 없음 (EVIDENCE `## 04-02 기준`)
2. **Task 2: Playwright 1.59.1 설치 승인 (checkpoint:decision, blocking-human)** — 커밋 없음, 응답 install(브라우저 포함)
3. **Task 3: p4-behave.mjs 기준 통과·음성 대조 실패** — 커밋 없음 (EVIDENCE `## 04-02 도구와 기준 동작`)

## Files Created/Modified

- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` — `## 04-02 기준`, `## 04-02 도구와 기준 동작` 구간과 표식 줄
- `.planning/phases/04-landing-content-fix/04-02-SUMMARY.md` — 이 문서
- 저장소 밖 스크래치(커밋 안 함): `$W/lib.sh`, `$W/pw/{package.json,pnpm-lock.yaml,node_modules,p4-behave.mjs}`, `$W/base`, `$W/neg`, `$W/behave-base.txt`, `$W/behave-neg.txt`

## Decisions Made

- 설치는 사용자 승인(install, 브라우저 포함) 뒤 pnpm `--frozen-lockfile`로만 했다. lockfile에 함께 있는 `pngjs@7.0.0`(RESEARCH 감사 [OK])도 같이 설치됐다.
- 브라우저 리비전이 1.59.1 요구와 같아 Microsoft CDN에서 받지 않았다.
- 요구사항 SITE-01·SITE-06은 이 계획에서 완료 처리하지 않았다. 이 계획은 기준과 판정 도구만 만들고, 실제 문구·뱃지·스크린샷 변경은 04-03 이후 계획 몫이다.

## Deviations from Plan

None - plan executed exactly as written. (`p4-behave.mjs`는 RESEARCH 골격의 판정 값을 그대로 쓰고, 계획 action 2의 (a)~(f)를 더했다. 클릭·스크롤 대기 5초는 골격에 없는 세부지만 판정 기준을 바꾸지 않는다.)

## Issues Encountered

None. 음성 대조에서 움직임 줄이기 문맥의 단계 버튼은 여전히 동작했는데, 스크립트가 단계 버튼을 연결한 뒤 `runBtn.addEventListener`에서 멈추기 때문이다. 대신 `pageerror`와 히어로 정지 실패(`animationsPaused=false`)로 잡혔다.

## User Setup Required

None.

## Next Phase Readiness

- 04-03(문구 커밋)부터 `BASE_SHA`, `$W/lib.sh`, `$W/pw/p4-behave.mjs`, `$W/base/site`를 그대로 쓴다.
- 스크래치는 macOS 임시 폴더 정리로 사라질 수 있다. 뒤 계획 첫 task가 scratch_contract의 「스크래치가 사라졌을 때」 절차로 같은 고정 버전·같은 경로에 다시 만든다(이번 승인 범위 안).

## Self-Check: PASSED

- FOUND: `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` (BASE_SHA·PW_VERSION·BEHAVE_BASE·BEHAVE_NEG 표식)
- FOUND: `$W/pw/p4-behave.mjs`, `$W/pw/node_modules/playwright` 1.59.1, `$W/neg/src/index.html`의 `rp-run-btn-x`
- Task 1 verify, Task 3 verify 두 명령 exit 0. `git diff --name-only 0e75e8b88fd2 HEAD -- . ':(exclude).planning'` 빈 출력. EVIDENCE에 홈 경로·`/private/var`·`/Users/` 없음.
