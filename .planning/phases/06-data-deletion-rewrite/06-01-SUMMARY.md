---
phase: 06-data-deletion-rewrite
plan: 01
subsystem: testing
tags: [baseline, playwright, data-deletion, anchors, negative-control, positive-control]
status: complete

# Dependency graph
requires:
  - phase: 05-business-info-support-contact
    provides: "Phase 5 스크래치의 lib.sh(복사해 고침)와 pw/package.json·pnpm-lock.yaml (playwright 1.59.1·pngjs 7.0.0 고정)"
provides:
  - "06-EVIDENCE.md 머리 규칙(공개 저장소 규칙, 표식 줄·보류 규칙)과 `## 06-01 기준`: BASE_SHA=89f659a5fdca, BASE_LIVE=e0f233169329, APP_BASE=a5db31953e1e, check-site 통과, OK HTTP 다섯 줄, OK base deletion robots=1 temp=1 u10=7 docmailto=0 filemailto=1 ids=0, appcheck 줄, OK site-clean 06-01-t1"
  - "06-EVIDENCE.md `## 06-01 도구`: Task 2 답(install, 브라우저 포함), PW_VERSION=1.59.1, PW_BROWSERS, 음성 대조(기준) FAIL deletion, 양성 대조(시험 객체) OK deletion 네 줄·앵커 서른두 줄·PASS deletion, TOOLS_BASE=OK, OK site-clean 06-01-t3"
  - "스크래치 $W(저장소 옆, 커밋 안 함): lib.sh(함수 열둘), pw/(playwright 1.59.1, pngjs 7.0.0, p6-deletion.mjs), fix/data-deletion.html(양성 시험 원고)과 사본 fixture-data-deletion.html, 기준 빌드 $W/base, 캡처 $W/cap/fix"
affects: [06-02, 06-03, 06-04, 06-05, 06-06, 06-07, 06-08, 06-09, 06-10, 06-11, 06-12, 06-13]

# Actuals (#2632)
actuals:
  tokens: 1687     # chars/4 over 06-EVIDENCE.md (이 계획이 만든 저장소 파일, 6747자. SUMMARY 제외)
  tasks: 3
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD. 기록 전용 계획이라 task 커밋이 없고, EVIDENCE와 이 SUMMARY는 바로 뒤 docs 커밋 하나로, STATE·ROADMAP은 그 뒤 기록 커밋으로 들어간다
plan_head_before: 89f659a5fdca9d13b7aa1483b38681331af2f559
plan_head_after: 89f659a5fdca9d13b7aa1483b38681331af2f559

# Tech tracking
tech-stack:
  added: ["playwright 1.59.1 (스크래치 전용, pnpm, Phase 5 lockfile로 --frozen-lockfile)", "pngjs 7.0.0 (같은 lockfile, 스크래치 전용)"]
  patterns:
    - "삭제 안내 판정은 p6-deletion.mjs 하나로: 두 엔진 × 375·1280에서 문서 한 줄(title·h1·robots·ids·reqmailto·mailto·first·mailfirst·figures, 가로 넘침·표 블록 상자·콘솔 오류는 FAIL 사유)과 앵커 여덟 줄(ok/ok-end), 끝 줄 PASS deletion / FAIL deletion, 종료 코드 0/1"
    - "mailto는 본문 블록(.rp-doc) 안과 #request 안만 센다. 공유 푸터의 mailto는 세지 않는다 (RESEARCH Pitfall 1)"
    - "양성 대조는 mkobj로 만든 ref 없는 시험 객체를 check-site → build → serve → 판정 순으로 돌린다"

key-files:
  created:
    - .planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md
    - .planning/phases/06-data-deletion-rewrite/06-01-SUMMARY.md
  modified: []

key-decisions:
  - "Task 2: 사용자가 install(브라우저 내려받기 포함)으로 승인(2026-11-20). 범위는 playwright@1.59.1·pngjs@7.0.0 고정, pnpm --frozen-lockfile, 스크래치 $W/pw에만, Phase 6 동안 같은 버전·같은 경로 재설치 포함"
  - "브라우저 리비전(chromium-1217, chromium_headless_shell-1217, webkit-2272)이 캐시에 있어 새로 받지 않았다"
  - "p6-deletion.mjs는 figures가 <figure 수>/<감싸개 속성을 갖춘 수>이고, 둘이 다르면 그 문맥을 FAIL로 본다 (D-07)"
  - "요구사항 DEL-01·DEL-07·BIZ-05는 완료 처리하지 않았다. 이 계획은 기준과 판정 도구만 만들고, 삭제 안내 재작성은 뒤 계획 몫이다"

patterns-established:
  - "뒤 계획들은 후보 빌드마다 `node \"$W/pw/p6-deletion.mjs\" http://127.0.0.1:<포트> [query] [--shot <폴더>]`를 돌려 PASS deletion을 본다. 라이브는 `https://runningpencil.com 'cb=<12자리>'`"

requirements-completed: []

coverage:
  - id: D1
    description: "기준 커밋·원격 main·앱 HEAD 기록, 기준을 운영과 같은 빌드로 서빙해 다섯 URL 200·기대 제목, 기준 삭제 안내 robots=1 temp=1 u10=7 docmailto=0 filemailto=1 ids=0"
    requirement: "DEL-01"
    verification:
      - kind: command
        ref: "06-01-PLAN.md Task 1 <verify> (Task 3 뒤 다시 실행, exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "Playwright 1.59.1 설치 승인(blocking-human)과 승인 범위 안 설치"
    verification:
      - kind: other
        ref: "Task 2 사용자 응답 install(브라우저 포함), Task 3 <verify> 둘째 명령의 버전 확인"
        status: pass
    human_judgment: true
    rationale: "외부 패키지 설치는 사람의 승인이 필요하다 (T-06-SC). 승인은 받았다"
  - id: D3
    description: "p6-deletion.mjs가 기준에서 FAIL deletion(종료 코드 1), 양성 시험 객체에서 두 엔진 × 두 폭 OK deletion(1280 mailfirst=ok, 375 mailfirst=na)과 앵커 서른두 줄 ok, PASS deletion(종료 코드 0)"
    requirement: "DEL-07"
    verification:
      - kind: command
        ref: "06-01-PLAN.md Task 3 <verify> 두 명령 (exit 0)"
        status: pass
    human_judgment: false

duration: 약 32분
completed: 2026-11-20
---

# Phase 6 Plan 01: 삭제 안내 기준과 판정 도구 Summary

**사이트 파일을 고치기 전 HEAD(89f659a5fdca)를 운영과 같은 빌드로 기준 삼고, Playwright 1.59.1 위의 `p6-deletion.mjs`가 그 기준 삭제 안내에서는 실패하고(검색 제외 meta, h1, 앵커 여덟 없음) 기대 구조를 갖춘 스크래치 시험 객체에서는 두 엔진 × 375·1280 모두 통과함(앵커 서른두 줄 `ok`)을 기록했다.**

## Performance

- **Duration:** 약 32분 (Task 2 승인 대기와 Task 3 이어 하기 포함)
- **Completed:** 2026-11-20
- **Tasks:** 3 (Task 1 tracer, Task 2 결정, Task 3 auto)
- **Files modified:** 1 (`06-EVIDENCE.md`, 새 파일) + 이 SUMMARY

## Accomplishments

- 기준 `BASE_SHA=89f659a5fdca`, 원격 main `BASE_LIVE=e0f233169329`, 앱 HEAD `APP_BASE=a5db31953e1e`를 기록했다. 기준과 원격 main의 `.planning/` 밖 트리가 같다(기준 = 지금 라이브 사이트).
- 기준 출력을 production·`--safe`로 `$W/base`에 빌드해 띄우고 다섯 URL이 200·기대 제목임을 확인했다. 기준 삭제 안내는 검색 제외 1, 임시 표시 1, U10 낱말 7, 본문 블록 mailto 0, 파일 전체 mailto 1(푸터), 본문 앵커 0이다.
- `appcheck a5db31953e1e`: `runs-delete-callers=0`(D-25 차단 상태의 기준), `deletion-files-changed=13`, `rate-limits-in-deletion=0`, `visibility-in-deletion=0`.
- Task 2 승인 범위 안에서 Phase 5 lockfile로 `playwright@1.59.1`·`pngjs@7.0.0`을 `$W/pw`에 `--frozen-lockfile` 설치했다(브라우저는 캐시 그대로).
- `p6-deletion.mjs` 음성 대조: 기준에서 네 문맥 모두 `h1 mismatch`·`robots=1`·`ids=none`·`first=missing`(1280은 `mailfirst=missing`도), 앵커 서른두 줄 `missing`, 끝 줄 `FAIL deletion`, 종료 코드 1.
- 양성 대조: `mkobj`로 만든 ref 없는 시험 객체가 check-site를 통과했고, 네 문맥 모두 `OK … deletion title=ok h1=ok robots=0 ids=request,location,google,apple,facebook,kakao,naver,line reqmailto=1 mailto=1 first=ok mailfirst=<1280 ok, 375 na> figures=1/1`, 앵커 서른두 줄 `ok`, `PASS deletion`, 종료 코드 0.
- 선택 인자 `[query]`와 `--shot <폴더>`도 시험 빌드에서 확인했다(`cb=test`, `PASS deletion`, 캡처 네 장).

## Task Commits

이 계획은 사이트·코드를 바꾸지 않는 기록 전용 계획이라 task 커밋이 없다. `06-EVIDENCE.md`와 이 SUMMARY는 계획 `<output>`대로 하나의 docs 커밋으로 들어가고, STATE·ROADMAP은 그 뒤 따로 기록 커밋으로 들어간다.

1. **Task 1: 기준 기록·빌드·서빙·HTTP·기준 개수·appcheck (tracer)**: 커밋 없음 (EVIDENCE `## 06-01 기준`, 앞 실행자가 함)
2. **Task 2: Playwright 1.59.1 설치 승인 (checkpoint:decision, blocking-human)**: 커밋 없음, 응답 install(브라우저 내려받기 포함)
3. **Task 3: 설치·p6-deletion.mjs·양성 시험 원고·음성/양성 대조**: 커밋 없음 (EVIDENCE `## 06-01 도구`)

## Files Created/Modified

- `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md`: 머리 규칙, `## 06-01 기준`, `## 06-01 도구` 구간과 표식 줄
- `.planning/phases/06-data-deletion-rewrite/06-01-SUMMARY.md`: 이 문서
- 저장소 밖 스크래치(커밋 안 함): `$W/lib.sh`, `$W/v1.sh`·`$W/v3a.sh`·`$W/v3b.sh`(verify 사본), `$W/pw/{package.json,pnpm-lock.yaml,node_modules,p6-deletion.mjs}`, `$W/fix/data-deletion.html`, `$W/fixture-data-deletion.html`, `$W/base`, `$W/fix`, `$W/cap/fix`, `$W/neg.txt`·`$W/pos.txt`·`$W/pos-shot.txt`

## Decisions Made

- 설치는 사용자 승인(install, 브라우저 포함) 뒤 pnpm `--frozen-lockfile`로만 했다. 기록에는 버전과 리비전 이름만 적었다.
- `p6-deletion.mjs`는 사양에 더해 표 감싸개 속성이 빠진 figure(`figures=<n>/<m>`, n≠m)와 `display: block`인 table을 그 문맥의 FAIL 사유로 본다. 이름이 다르거나 앵커 h2가 아닌 경우의 사유에는 본문 글을 찍지 않는다(`h2-name mismatch`).
- 요구사항 DEL-01·DEL-07·BIZ-05는 완료 처리하지 않았다. 이 계획은 기준과 판정 도구만 만들었다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - Blocking] `build fix`가 양성 시험 원고를 지움**
- **Found during:** Task 3 verify 둘째 명령 (첫 실행 exit 2)
- **Issue:** 계획은 원고를 `$W/fix/data-deletion.html`에 두고 같은 이름 `fix`로 빌드하게 했는데, `lib.sh`의 `build`는 `$W/<이름>`을 통째로 지우고 다시 만든다. 빌드 뒤 원고가 사라졌다.
- **Fix:** 빌드한 시험 객체의 `data-deletion/index.html` blob에서 같은 바이트로 되살렸다(blob 해시 같음, 빌드 원본 `$W/fix/src/data-deletion/index.html`과도 같음). 사본을 `$W/fixture-data-deletion.html`에 두고 EVIDENCE `## 06-01 도구`에 한 줄로 적었다. 뒤 계획이 `fix`로 다시 빌드하면 사본에서 되살린다.
- **Files modified:** 스크래치만 (커밋 안 함)
- **Commit:** 없음

### 앞 실행자 구간(Task 1)과 실행 환경의 차이 (오케스트레이터 지시로 적음)

- **앱 HEAD가 계획 때와 다르다.** 계획 때 `21d5c86c1d65`, 기록은 `APP_BASE=a5db31953e1e`. `deletion-files-changed=13`이고 모두 `lib/features/settings/presentation/` 아래다. 두 삭제 함수 파일·규칙 파일·`functions/src/index.ts`·`lib/features/runs`는 바뀌지 않았다. 판정은 06-04가 코드를 읽어 정한다.
- **앞 실행자가 앱 저장소에서 `git status --short`를 한 번 실행했다.** D-05가 허용한 명령(`rev-parse`·`log`·`diff`·`show`·`grep`·`cat-file`·`merge-base`·`ls-tree`) 밖이다. 읽기 전용 명령이라 앱 저장소는 바뀌지 않았다. 이 실행에서는 앱 저장소를 쓰지 않았다.
- **`lib.sh`의 `APP`은 메인 체크아웃 부모 폴더에서 정한다.** 계획 context는 `APP="$HOME/dv/woody/running_pencil"`이지만 `lib.sh`는 홈 경로를 적지 않는 규칙(T-06-02) 때문에 `git rev-parse --git-common-dir`의 두 단계 위 폴더 아래 `running_pencil`로 정한다(환경에 `APP`이 있으면 그것). 가리키는 곳은 같다.
- **BASE_SHA는 오케스트레이터의 wave 시작 STATE 커밋이다.** 오케스트레이터가 Task 1 전에 `89f659a`(docs(06-01): Wave 1 실행 시작을 STATE에 기록)를 커밋했으므로 기준은 그 커밋이다. 그 커밋은 `.planning/`만 바꿨고, 기준과 원격 main의 `.planning/` 밖 트리는 같다.

## Issues Encountered

- `ok-end` 경로는 실행되지 않았다. 양성 원고에서는 마지막 앵커(`#line`) 뒤에 조항 둘과 푸터가 있어 서른두 줄 모두 `ok`였다. 실제 원고(06-07)에서 `#line`이 문서 끝에 오면 그때 처음 실행된다.

## User Setup Required

None.

## Next Phase Readiness

- 06-02부터 `BASE_SHA`, `$W/lib.sh`, `$W/pw/p6-deletion.mjs`, `$W/base/site`를 그대로 쓴다. 스크래치 재확인 (가)~(라)는 지금 모두 성립한다.
- 사이트 커밋은 D-25가 막고 있다(`runs-delete-callers=0`). 앱 작업 D-05가 들어올 때까지 같은 기준으로 판정한다.
- `$W`는 저장소 옆이라 임시 폴더 정리로 지워지지 않는다.

## Self-Check: PASSED

- FOUND: `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` (BASE_SHA·BASE_LIVE·APP_BASE·PW_VERSION·PW_BROWSERS·TOOLS_BASE 표식, `OK site-clean 06-01-t1/t3 89f659a5fdca`)
- FOUND: `$W/lib.sh`(함수 열둘), `$W/pw/p6-deletion.mjs`, `$W/pw/node_modules/playwright` 1.59.1, `$W/fix/data-deletion.html`, `$W/base/TREE` = BASE_SHA 트리
- Task 1 verify, Task 3 verify 두 명령 exit 0. 작업 트리 `scripts/check-site.sh` 통과. EVIDENCE에 `$HOME` 문자열과 LPX 모양 0건(grep 종료 코드 1). 저장소에 `*.mjs`·`node_modules`·`package.json`·`pnpm-lock.yaml` 추적 없음. HEAD = BASE_SHA.
