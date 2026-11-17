---
phase: 04-landing-content-fix
plan: 04
subsystem: landing-content
tags: [site-01, badge, css, tracer, jekyll, behave, playwright]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "04-03: 문구 커밋 C1_SHA=abdeb52284d6(캡션 「보관함 · 받은 뱃지 7」), 후보 출력 $W/c1. 04-02: $W/lib.sh, $W/pw/p4-behave.mjs, playwright 1.59.1"
provides:
  - "빈 뱃지 커밋 C2_SHA=f8d66a6469cf: index.html 51행(.rp-badge.t-empty 규칙) 삭제, 241~243행(뱃지 줄 고양이 t-graphite·번개 t-yellow·왕관 t-red)과 260·262행(스티커 고양이 t-yellow·왕관 t-red)의 색 토큰 교체, 5/6 numstat"
  - "04-EVIDENCE.md `## 04-04 빈 뱃지 커밋`: CAND2=21274178093f, check-site 통과, HUNKS 82d81 285,287c284,286 304c303 306c305, OK empty=0, OK hex no-new, OK legal same 3, OK files same, 후보 PASS behave(여섯 문맥 empty=0), OK step3 4, REVIEW step3 네 줄 OK, C2_SHA, OK commit files=index.html numstat=5/6, C2_OK=OK"
  - "스크래치 $W/c2(후보 빌드와 TREE), $W/pw/p4-step3.mjs, $W/cap/c2/<엔진>-<폭>-step3.png 네 장 (커밋 안 함)"
affects: [04-05]

# Actuals (#2632)
actuals:
  tokens: 1639     # chars/4 over 이 계획이 바꾼 줄 (index.html 빈 뱃지 커밋 diff + 04-EVIDENCE.md 더한 줄, SUMMARY 제외)
  tasks: 2
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점, 빈 뱃지 커밋 하나). EVIDENCE·SUMMARY는 이 뒤 docs 커밋으로 들어간다
plan_head_before: 7e764cefa72f7feab6c6ec4a986324278622133e
plan_head_after: f8d66a6469cfa9a0cd69ee3ba46aadd8ee14a3f1

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "사이트 커밋 후보 절차(04-02 scratch_contract)의 두 번째 사용: git add → commit-tree 후보 → check-site·빌드·의도한 줄 diff·브라우저 판정 → 같은 인덱스로 git commit → HEAD 트리 = $W/c2/TREE 확인"
    - "그림 변경 커밋은 요소 캡처(p4-step3.mjs)를 직접 열어 보고 REVIEW 줄로 남긴 뒤에만 커밋"

key-files:
  created:
    - .planning/phases/04-landing-content-fix/04-04-SUMMARY.md
  modified:
    - index.html
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md

key-decisions:
  - "빈 뱃지 다섯 개의 색은 계획(D-06, RESEARCH 예시)대로 뱃지 줄 흑연·노랑·빨강, 스티커 고양이 노랑·왕관 빨강으로 정했다. 다섯 색에 여섯 장이라 스티커 빨강 두 장(1번째 하트, 6번째 왕관)은 피할 수 없고 대각선으로 떨어져 있다"
  - "쓰는 곳이 없어진 .rp-badge.t-empty 규칙을 같은 커밋에서 지웠다 (RESEARCH Open Q1). 코스북 실루엣은 Deferred라 필요하면 그때 다시 만든다"
  - "후보 동작 판정 첫 실행이 jsDelivr 글꼴 CORS 콘솔 오류(chromium 375 한 문맥)로 실패해 같은 후보로 다시 실행했다. 첫 실행 출력은 스크래치에 남기고 EVIDENCE에 사실을 적었다"

patterns-established:
  - "외부 CDN 응답 때문에 판정이 한 번 흔들리면 같은 후보·같은 서버로 다시 실행하고, 첫 실행 사실과 스크래치 위치를 EVIDENCE 본문에 적는다 (FAIL 줄을 표식 구간에 남기지 않음)"

requirements-completed: [SITE-01]

coverage:
  - id: D1
    description: "「세 가지 이유」 3단계 뱃지 줄의 빈 뱃지 세 개(고양이·번개·왕관)를 t-graphite·t-yellow·t-red로 바꿈. 줄 전체 이웃끼리 같은 색 없음 (D-06)"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-04-PLAN.md Task 1 <verify> 첫 명령 (다섯 뱃지 색·위치·코스 조합 grep, exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "패널 장식 스티커의 빈 뱃지 두 개를 고양이 t-yellow, 왕관 t-red로 바꿈. 375px에서 보이는 스티커 넷이 서로 다른 색 (D-06)"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-04-PLAN.md Task 1 <verify> 첫 명령 (exit 0)"
        status: pass
    human_judgment: false
  - id: D3
    description: "빈 뱃지 규칙 삭제로 원본·출력에 t-empty와 회색 실루엣 색 0줄, 새 hex 없음, 의도한 줄만 바뀜(82d81 285,287c284,286 304c303 306c305), 법적 3종·파일 목록 불변, 두 엔진 × 세 문맥 PASS behave (성공 기준 3)"
    requirement: "SITE-01"
    verification:
      - kind: other
        ref: "04-04-PLAN.md Task 1 <verify> 두 명령, Task 2 <verify> (exit 0); p4-behave.mjs PASS behave"
        status: pass
    human_judgment: false
  - id: D4
    description: "3단계 화면의 색 배치가 보기에 어색하지 않음 (캡처 네 장: $W/cap/c2/chromium-1280·chromium-375·webkit-1280·webkit-375-step3.png)"
    requirement: "SITE-01"
    verification:
      - kind: automated_ui
        ref: "p4-step3.mjs → $W/cap/c2/*-step3.png, EVIDENCE REVIEW step3 네 줄 OK (Claude 검토)"
        status: pass
    human_judgment: true
    rationale: "색 배치가 보기 좋은지는 grep이나 DOM 개수로 판정할 수 없다. 계획 Task 2 <human-check>대로 단계 끝 UAT에서 사람이 확인한다"

# Metrics
duration: 7 min
completed: 2026-11-17
---

# Phase 4 Plan 04: 빈 뱃지 컬러 커밋 Summary

**「세 가지 이유」 3단계의 회색 빈 뱃지 다섯 개(뱃지 줄 3, 패널 스티커 2)를 기존 받은 뱃지 색 클래스로 바꾸고 쓰지 않게 된 `.rp-badge.t-empty` 규칙을 지운 `index.html` 커밋(f8d66a6469cf, 5/6)을 후보 단계에서 check-site·의도한 줄 diff·법적 3종 불변·두 엔진 동작 판정·3단계 캡처 검토까지 통과시킨 뒤 남겼다.**

## Performance

- **Duration:** 약 7분 (2026-11-17T05:13:17Z 시작, STATE 갱신 05:20:09Z)
- **Completed:** 2026-11-17
- **Tasks:** 2 (Task 1 tracer, Task 2 auto)
- **Files modified:** 2 (`index.html`, `04-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- 3단계 뱃지 줄: 고양이 `t-graphite`, 번개 `t-yellow`, 왕관 `t-red`. 줄 전체가 노랑·빨강·크라프트·모눈·흑연·노랑·빨강이라 이웃끼리 같은 색이 없다.
- 패널 스티커: 4번째 고양이 `t-yellow`, 6번째 왕관 `t-red`. 375px에서 보이는 1~4번째는 빨강·크라프트·모눈·노랑으로 모두 다르다.
- `.rp-badge.t-empty { … #EEEEEE … #DCDCDC … #BDBDBD }` 한 줄 삭제. 원본과 출력에 빈 뱃지 클래스와 회색 실루엣 색이 0줄이고, 새 hex는 없다.
- 후보(21274178093f) 판정: check-site 통과, c1→c2 출력 diff 행 머리 `82d81 285,287c284,286 304c303 306c305`, 법적 3종 바이트 동일, 출력 파일 목록 동일, `p4-behave.mjs` Chromium·WebKit × 세 문맥 `PASS behave`(모두 `badges=7 stickers=6 empty=0`).
- 3단계 요소 캡처 네 장(두 엔진 × 1280·375)을 직접 보고 모두 OK로 기록했다. 캡션 「보관함 · 받은 뱃지 7」과 컬러 뱃지 일곱 개가 같은 화면에서 맞는다.
- 커밋 트리가 후보 트리(`$W/c2/TREE`)와 같고, 커밋은 `index.html` 하나·5줄 더함·6줄 지움이다. 문구 커밋과 이 커밋 사이에는 `.planning/`만 바꾼 docs 커밋만 있다.

## Task Commits

1. **Task 1: 후보를 끝까지 판정 (tracer)** — 후보 객체 `21274178093f`(브랜치에 붙지 않음). 커밋은 Task 2에서 같은 인덱스로
2. **Task 2: 3단계 캡처 검토와 빈 뱃지 커밋** — `f8d66a6469cf` (fix)

EVIDENCE와 이 SUMMARY는 계획 `<output>`대로 하나의 docs 커밋으로 들어간다.

## Files Created/Modified

- `index.html` — 51행 삭제, 241~243·260·262행의 `class` 색 토큰만 교체 (`style`·`viewBox`·`stroke-width`·`<use href>`·순서 그대로)
- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` — `## 04-04 빈 뱃지 커밋` 구간과 표식 줄(CAND2, C2_SHA, C2_OK)
- `.planning/phases/04-landing-content-fix/04-04-SUMMARY.md` — 이 문서
- 저장소 밖 스크래치(커밋 안 함): `$W/c2`(src, site, TREE, build.log), `$W/behave-c2.txt`, `$W/behave-c2-try1.txt`, `$W/pw/p4-step3.mjs`, `$W/cap/c2/*-step3.png`

## Decisions Made

- 색 배치는 계획 Task 1 action 1번 그대로 따랐다. 계획 verify가 다섯 색·위치 조합을 고정하므로 다른 배치는 고르지 않았다.
- 빈 뱃지 규칙은 지웠다 (RESEARCH Open Q1). 실루엣 개념을 다른 모양으로 되살리지 않았다 (D-03).
- 푸시하지 않았다. 문구 커밋과 빈 뱃지 커밋은 04-05에서 승인을 받아 함께 푸시한다 (D-22).

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- 후보 동작 판정 첫 실행에서 chromium 375 기본 문맥 하나가 jsDelivr Pretendard 글꼴 파일 요청이 CORS 헤더 없이 막힌 콘솔 오류 2줄로 `FAIL behave`가 났다. 바뀐 줄(색 토큰·CSS 한 줄)과 무관한 외부 CDN 응답이라 같은 후보·같은 서버로 다시 실행했고 여섯 문맥 모두 통과했다. 첫 실행 출력은 `$W/behave-c2-try1.txt`에 남겼고, EVIDENCE 본문에 그 사실을 적었다. 04-05의 라이브 판정에서도 같은 일시적 CDN 오류가 나올 수 있다.

## Threat Flags

None. 바뀐 것은 기존 색 클래스 토큰과 쓰지 않는 CSS 한 줄뿐이고 새 네트워크·스크립트·입력 경로가 없다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 04-05는 문구 커밋(`abdeb52284d6`)과 빈 뱃지 커밋(`f8d66a6469cf`)을 함께 승인받아 푸시한다.
- 단계 끝 UAT: 스크래치 `$W/cap/c2/`의 3단계 캡처 네 장에서 색 배치가 어색하지 않은지 사람이 확인한다 (Task 2 `<human-check>`).

## Self-Check: PASSED

- FOUND: `index.html`(t-empty 0줄, 회색 실루엣 색 0줄, 46px 흑연 뱃지 1줄), `04-EVIDENCE.md`(CAND2·C2_SHA·C2_OK 표식), `$W/c2/TREE`, `$W/cap/c2/*-step3.png` 네 장
- FOUND: 커밋 `f8d66a6469cf`이 HEAD의 조상이고 `abdeb52284d6`의 후손, 트리 = 후보 트리, 파일 `index.html` 하나, numstat 5/6
- Task 1 verify 두 명령, Task 2 verify 한 명령 exit 0. 작업 트리 `scripts/check-site.sh` 통과. EVIDENCE에 `/Users/`·`/private/var`·`$HOME` 문자열 없음.
