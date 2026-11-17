---
phase: 04-landing-content-fix
plan: 03
subsystem: landing-content
tags: [site-01, meta, og, copy, tracer, jekyll, behave]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "04-02: BASE_SHA=0e75e8b88fd2, 기준 빌드 $W/base, $W/lib.sh(build·serve·stop), $W/pw/p4-behave.mjs, BEHAVE_BASE=OK"
provides:
  - "문구 커밋 C1_SHA=abdeb52284d6: index.html 13·18·234·245행(메타 설명, og:description, 「세 가지 이유」 3단계 글, 3단계 캡션)만 교체, 4/4 numstat"
  - "04-EVIDENCE.md `## 04-03 문구 커밋`: CAND1=109741862593, check-site 통과, HUNKS 10c10 15c15 278c278 289c289, OK words index=0, OK legal same 3, OK files same, 후보 PASS behave, C1_SHA, OK commit files=index.html numstat=4/4, C1_OK=OK"
  - "스크래치 $W/c1(커밋 안 함): 후보 빌드와 TREE"
affects: [04-04, 04-05]

# Actuals (#2632)
actuals:
  tokens: 834      # chars/4 over 이 계획이 바꾼 줄 (index.html 문구 커밋 diff + 04-EVIDENCE.md 더한 줄, SUMMARY 제외)
  tasks: 2
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점, 문구 커밋 하나). EVIDENCE·SUMMARY는 이 뒤 docs 커밋으로 들어간다
plan_head_before: 4a42d50cb37d9eef2cf40453fbea7934497807db
plan_head_after: abdeb52284d6c550faed7a9dfd05dee015252253

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "사이트 커밋 후보 절차(04-02 scratch_contract)의 첫 실제 사용: git add → commit-tree 후보 → check-site·빌드·판정 → 같은 인덱스로 git commit → HEAD 트리 = $W/c1/TREE 확인"

key-files:
  created:
    - .planning/phases/04-landing-content-fix/04-03-SUMMARY.md
  modified:
    - index.html
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md

key-decisions:
  - "문구 커밋은 index.html 네 줄만 담고 빈 뱃지 그림(t-empty)은 04-04 커밋으로 남겼다 (D-22). 푸시는 04-05에서 두 커밋을 함께 한다"
  - "법적 3종의 포인트·굿즈·코스북은 이 커밋에서 건드리지 않았다 (Phase 6~8 몫). SC1 판정 대상은 _site/index.html 하나"

patterns-established:
  - "후보 판정 기록은 CAND<n>=<12자리> → check-site 줄 → HUNKS·OK 줄 → p4-behave 출력 전체 → 커밋 뒤 <이름>_SHA·OK commit·<이름>_OK 순서로 남긴다"

requirements-completed: [SITE-01]

coverage:
  - id: D1
    description: "메타 설명·og:description에서 포인트·굿즈·코스북 부분만 지움 (D-02). <title>·og:title 그대로"
    requirement: "SITE-01"
    verification:
      - kind: command
        ref: "04-03-PLAN.md Task 1 <verify> 첫 명령 (출력에 D-02 두 문장과 제목, 세 낱말 0줄; exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "「세 가지 이유」 3단계 글·캡션에서 실루엣·「채울 뱃지」 표현을 지우고 D-04·D-05 문장으로 교체"
    requirement: "SITE-01"
    verification:
      - kind: command
        ref: "04-03-PLAN.md Task 1 <verify> 첫 명령 (D-04 글, D-05 캡션 존재, 실루엣·채울 뱃지 0줄; exit 0)"
        status: pass
    human_judgment: false
  - id: D3
    description: "의도한 네 줄만 바뀌고 법적 3종 출력·파일 목록 불변, 기존 동작이 두 엔진 × 세 문맥 그대로 (성공 기준 3)"
    requirement: "SITE-01"
    verification:
      - kind: command
        ref: "04-03-PLAN.md Task 1 <verify> 두 명령, Task 2 <verify> (exit 0); p4-behave.mjs PASS behave"
        status: pass
    human_judgment: false

duration: 3 min
completed: 2026-11-17
---

# Phase 4 Plan 03: 문구 커밋 Summary

**랜딩 메타 설명·OG 설명에서 포인트·굿즈·코스북을, 「세 가지 이유」 3단계 글·캡션에서 실루엣·「채울 뱃지」를 지운 `index.html` 네 줄 커밋(abdeb52284d6)을 후보 단계에서 check-site·빌드·SC1·의도한 줄 diff·두 엔진 동작 판정까지 통과시킨 뒤 남겼다.**

## Performance

- **Duration:** 약 3분 (2026-11-17T04:59:52Z 시작, STATE 갱신 05:02:56Z)
- **Completed:** 2026-11-17
- **Tasks:** 2 (Task 1 tracer, Task 2 auto)
- **Files modified:** 2 (`index.html`, `04-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- `<meta name="description">`: 「지도 위에 그려진 GPS 아트 코스를 따라 걷거나 뛰어 보세요. 완주하면 그 모양 그대로 뱃지가 돼요. iOS · Android 앱 출시 준비 중.」 (D-02)
- `og:description`: 「GPS 아트 코스를 완주하고 코스 모양의 뱃지를 모으세요. 나만의 코스를 그려 올릴 수도 있어요.」 (D-02)
- 3단계 설명 글: 「끝까지 달리면 그 코스의 모양이 뱃지로 남아요. 받은 뱃지는 보관함에 모여요. 코스를 하나씩 완주해 보관함을 채워 보세요.」 (D-04)
- 3단계 캡션: 「보관함 · 받은 뱃지 7」 (D-05)
- 후보(109741862593) 판정: check-site 통과, 출력 `_site/index.html`의 세 낱말·실루엣·「채울 뱃지」 0줄, 새 문장 네 개 각 1줄, 기준과의 diff 행 머리 `10c10 15c15 278c278 289c289`, 법적 3종 바이트 동일, 출력 파일 목록 동일, `p4-behave.mjs` Chromium·WebKit × 세 문맥 `PASS behave`.
- 커밋 트리가 후보 트리(`$W/c1/TREE`)와 같고, 커밋은 `index.html` 하나·4줄 더함·4줄 지움이며 include·레이아웃·법적 3종·점검 스크립트는 그대로다 (D-15).

## Task Commits

1. **Task 1: 네 줄 후보를 끝까지 판정 (tracer)** — 후보 객체 `109741862593`(브랜치에 붙지 않음). 커밋은 Task 2에서 같은 인덱스로
2. **Task 2: 문구 커밋과 내용 확인** — `abdeb52284d6` (fix)

EVIDENCE와 이 SUMMARY는 계획 `<output>`대로 하나의 docs 커밋으로 들어간다.

## Files Created/Modified

- `index.html` — 13·18·234·245행의 값·글만 교체 (줄 구조·들여쓰기·인라인 style 그대로)
- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` — `## 04-03 문구 커밋` 구간과 표식 줄(CAND1, C1_SHA, C1_OK)
- `.planning/phases/04-landing-content-fix/04-03-SUMMARY.md` — 이 문서
- 저장소 밖 스크래치(커밋 안 함): `$W/c1`(src, site, TREE, build.log), `$W/behave-c1.txt`

## Decisions Made

- 빈 뱃지 그림(241~243·260·262행 `t-empty`)은 이 커밋에서 바꾸지 않았다. 04-04의 별도 커밋이다 (D-22). 그래서 후보 판정의 `empty=5`는 기준과 같다.
- 지운 문구 자리에 새 홍보 문장을 더하지 않았고 출시 시기도 적지 않았다 (D-01, D-09).
- 푸시하지 않았다. 문구 커밋과 빈 뱃지 커밋은 04-05에서 승인을 받아 함께 푸시한다.

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None. 후보 판정은 첫 시도에 모두 통과했다. 스크래치는 04-02가 만든 것을 그대로 썼다(다시 만들지 않음, 패키지 설치 없음).

## Threat Flags

None. 바뀐 것은 정적 글과 메타 속성 값뿐이고 새 네트워크·스크립트·입력 경로가 없다.

## User Setup Required

None. 공유 미리보기 서비스가 옛 OG 설명을 캐시하고 있으면, 배포(04-05) 뒤 필요할 때 각 서비스의 디버거로 다시 긁으면 된다 (RESEARCH A12).

## Next Phase Readiness

- 04-04(빈 뱃지 컬러 커밋)는 같은 후보 절차로 `$W/c2`(포트 4204)를 쓴다. 기준은 계속 `$W/base`이고, 문구 커밋 뒤 HEAD 위에 후보를 만든다.
- 04-05가 두 사이트 커밋을 승인받아 푸시한다.

## Self-Check: PASSED

- FOUND: `index.html`(새 캡션 1줄, 세 낱말 0줄), `04-EVIDENCE.md`(CAND1·C1_SHA·C1_OK 표식), `$W/c1/TREE`
- FOUND: 커밋 `abdeb52284d6`이 HEAD의 조상, 트리 = 후보 트리
- Task 1 verify 두 명령, Task 2 verify 한 명령 exit 0. EVIDENCE에 홈 경로·`/private/var`·`/Users/`·`$HOME` 문자열 없음.
