---
phase: 05-business-info-support-contact
plan: 06
subsystem: content
tags: [business-info, footer, first-push, live-verify, github-pages, one-way]
status: complete

# Dependency graph
requires:
  - phase: 05-business-info-support-contact
    provides: "05-01의 $W/lib.sh(build·footblock·pages_wait·live·vals)·p5-foot.mjs, 05-03의 M1·M2, 05-04의 M3(점검 7번 가드), 05-05의 C4_CAND·SEPARATOR=opt2·D10_APPROVED=OK와 작업 트리 사업자 값"
provides:
  - "값 커밋 M4=57e56b07f2ab (`_data/company.yml` 한 파일, 사업자 값 네 개, 지원 이메일·전화는 빈 값). 구분 기호 선택지 2라 토큰 커밋 S는 없음(S_SHA=none)"
  - "원격 main = PUSH1_SHA=57e56b07f2ab (M1·M2·M3·M4와 05-01~05-05 기록 문서). 사업자 정보가 네 문서 푸터에 라이브"
  - "05-EVIDENCE.md 구간 `## 05-06 값 커밋과 푸시 후보`·`## 05-06 첫 푸시 라이브 확인`, 표식 S_SHA·M4_SHA·PUSH1_CANDIDATE·PUSH1_PREV·PUSH1_SHA·LIVE_PUSH1=OK"
  - "스크래치 $W/m4/(M4 빌드, TREE = PUSH1_SHA 트리), 라이브 사본 $W/live1/ (05-12 되돌리기 비교 기준이 $W/m4/site)"
affects: [05-07, 05-08, 05-12, 05-15]

# Actuals (#2632)
actuals:
  tokens: 1587     # chars/4 over 이 계획이 더한 줄(05-EVIDENCE.md 두 구간, _data/company.yml 값 네 줄). 이 SUMMARY 제외
  tasks: 3
  commits: 2       # 측정값: git rev-list --count plan_head_before..HEAD (M4 57e56b0, Task 1 EVIDENCE 0563570). 이 SUMMARY·EVIDENCE 문서 커밋과 STATE 커밋은 뒤에 더해진다
plan_head_before: ec73a7af95550c3c030c795fb3a1b9caaf95f191
plan_head_after: 0563570836e82954b473540657c2a5413be42c33

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "푸시는 승인받은 SHA를 전체 해시 refspec(`\"${FULL}:refs/heads/main\"`)으로 한 번만 보내고, 직전에 원격이 PUSH1_PREV 그대로인지와 훅이 부를 작업 트리 스크립트·훅이 후보와 같은지를 같은 명령 묶음에서 다시 본다"
    - "라이브 판정은 Pages 빌드 기록(builds/latest의 커밋·built·오류 없음) 뒤 `?cb=<커밋>`으로 받은 응답을 로컬 후보 빌드와 cmp하고, 푸터는 라벨 수만 센다"

key-files:
  created:
    - .planning/phases/05-business-info-support-contact/05-06-SUMMARY.md
  modified:
    - _data/company.yml (M4, 05-06 Task 1)
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md

key-decisions:
  - "Task 2 답 `push 57e56b07f2ab`를 그 SHA 한 번의 푸시에만 썼다. 되돌리기 푸시는 필요 없었다"
  - "BIZ-01·BIZ-02·BIZ-03은 완료 처리하지 않는다. BIZ-01은 지원 이메일(게이트 뒤)까지 포함하고, 세 ID 모두 05-07·05-11·05-12·05-15가 함께 선언한다"

patterns-established:
  - "pages_wait처럼 10분까지 기다리는 함수는 배경 실행으로 돌리고 출력을 $W 아래 파일에 남긴 뒤 그 줄을 기록에 그대로 붙인다(verify가 created_at을 Pages 빌드 기록과 대조)"

requirements-completed: []

coverage:
  - id: D1
    description: "값 커밋 M4가 `_data/company.yml` 하나만 바꾸고, M4 빌드 네 문서가 승인한 선택지 빌드($W/d10o2)와 바이트가 같으며, 첫 푸시 범위의 사이트 파일이 네 개·사이트 커밋이 M1~M4·보류 묶음 없음·지원 페이지/링크/이메일 없음·값 누출 0건·실제 pre-push 훅 통과"
    requirement: "BIZ-02"
    verification:
      - kind: integration
        ref: "05-06-PLAN.md Task 1 verify ($W/v506-t1.sh, bash·zsh exit 0)"
        status: pass
      - kind: other
        ref: "git log --format=%h 84a5d9114ef3..57e56b07f2ab -- . ':(exclude).planning' = 57e56b0 da94075 b7e2dcd bc934fb"
        status: pass
    human_judgment: false
  - id: D2
    description: "승인한 SHA만 원격 main에 나갔고, Pages가 그 커밋으로 built·오류 없음이 된 뒤 라이브 네 문서가 200·기대 제목·로컬 M4 빌드와 바이트 같음, 네 문서 푸터에 상호·대표자·사업자등록번호·주소 행 1개씩, 이메일·전화 행 0개"
    requirement: "BIZ-01"
    verification:
      - kind: e2e
        ref: "05-06-PLAN.md Task 3 verify 1·2 ($W/v506-t3a.sh, $W/v506-t3b.sh, bash·zsh exit 0; 2번은 gh api Pages 빌드 기록 대조)"
        status: pass
    human_judgment: false
  - id: D3
    description: "라이브에서 두 엔진(Chromium·WebKit) × 375·1280 × 네 문서 푸터가 split·overflow·badLink·콘솔 오류 없이 PASS foot"
    requirement: "BIZ-03"
    verification:
      - kind: automated_ui
        ref: "node $W/pw/p5-foot.mjs https://runningpencil.com '?cb=57e56b07f2ab' (exit 0, PASS foot)"
        status: pass
    human_judgment: false

# Metrics
duration: 8min
completed: 2026-11-19
---

# Phase 5 Plan 06: 값 커밋과 첫 사이트 푸시 Summary

**사업자 값 커밋 M4(`_data/company.yml` 한 파일)를 승인한 캡처와 바이트가 같게 만들고, 사용자가 승인한 `57e56b07f2ab` 하나만 원격 main에 푸시했으며, Pages 배포 완료 뒤 라이브 네 문서가 로컬 M4 빌드와 바이트가 같고 푸터 라벨 수·두 엔진 화면이 모두 통과했다**

## Performance

- **Duration:** 8 min (이어받은 Task 3만. Task 1은 앞 실행에서 끝남)
- **Started:** 2026-11-19T04:38:01Z
- **Completed:** 2026-11-19T04:46:00Z
- **Tasks:** 3 (Task 1 앞 실행, Task 2 사용자 답, Task 3 이번 실행)
- **Files modified:** 2 (`_data/company.yml` M4, `05-EVIDENCE.md`)

## Accomplishments

- Task 1(앞 실행): 선택지 2라 토큰 커밋 S 없이 M4=`57e56b07f2ab`를 후보 절차로 만들고, 범위·보류 묶음 조상·값 누출·실제 pre-push 훅까지 점검해 `PUSH1_CANDIDATE=57e56b07f2ab`, `PUSH1_PREV=84a5d9114ef3`을 기록했다.
- Task 2: 사용자가 `push 57e56b07f2ab`로 답했다.
- Task 3: 푸시 전 스크래치 재확인(다시 만든 것 없음, `$W/m4/TREE` = 후보 트리). 원격이 `PUSH1_PREV` 그대로이고 훅 파일이 후보와 같음을 같은 명령 묶음에서 확인한 뒤 `git push origin "${FULL}:refs/heads/main"` 한 번. 훅 `check-site: 통과 (커밋 57e56b07f2ab …)`.
- Pages 빌드 `OK 빌드 57e56b07f2ab built 2026-11-19T04:38:08Z`. 라이브 `/`·`/privacy-policy/`·`/terms/`·`/data-deletion/` 모두 200·기대 제목·`bytes=same`. 라벨 `trade=1 rep=1 bizno=1 addr=1 email=0 phone=0 docs=4`. `p5-foot.mjs` 16줄 모두 OK(rows=5 spans=3 seps=2 sepLead=0), `PASS foot`. `LIVE_PUSH1=OK`.
- 세 기존 URL은 경로·제목이 그대로다(Ground Rule). 랜딩 출력도 공유 푸터라 바뀌었고(D-11) 제목은 그대로다.

## Task Commits

1. **Task 1: 값 커밋과 첫 푸시 후보 점검 (tracer)** - `57e56b0` (feat, M4 사이트 커밋), `0563570` (docs, EVIDENCE)
2. **Task 2: 첫 사이트 푸시 SHA 승인** - 커밋 없음 (사용자 답 `push 57e56b07f2ab`)
3. **Task 3: 푸시와 라이브 확인** - 원격 main `84a5d91..57e56b0`. 기록은 이 계획의 문서 커밋(SUMMARY와 함께)에 들어감

## Files Created/Modified

- `_data/company.yml` - M4에서 사업자 값 네 칸(지원 이메일·전화는 빈 값)
- `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` - 구간 `## 05-06 값 커밋과 푸시 후보`, `## 05-06 첫 푸시 라이브 확인`과 표식
- `.planning/phases/05-business-info-support-contact/05-06-SUMMARY.md` - 이 문서

## Decisions Made

- 승인은 `57e56b07f2ab` 한 번의 푸시에만 썼다. Task 1 기록 커밋 `0563570`과 이 문서 커밋은 로컬에만 두고 05-12 게이트 푸시 때 함께 나간다.
- BIZ-01~03은 완료 처리하지 않는다(지원 이메일·게이트 뒤 계획들이 같은 ID를 선언).

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None. 라이브 확인에 FAIL이 없어 `<rollback_procedure>`를 쓰지 않았다. 공개된 사업자 값은 되돌려도 검색 캐시·아카이브에 남는다는 점(D-10 one-way)은 기록에 적었다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 05-07(사업자 정보 쪽 문서 갱신, D-21 「첫 푸시의 라이브 확인 뒤」)을 시작할 수 있다.
- 로컬 main이 원격보다 문서 커밋만큼 앞선다(`0563570`, 이 문서 커밋, STATE 커밋). 사이트 파일 차이는 없다.
- 05-12의 되돌리기 비교 기준 `$W/m4/site`가 PUSH1_SHA 트리로 남아 있다.

---
*Phase: 05-business-info-support-contact*
*Completed: 2026-11-19*

## Self-Check: PASSED

- SUMMARY·EVIDENCE 파일 있음, 커밋 57e56b0·0563570·d9d508d·723304b가 HEAD의 조상, PUSH1_SHA가 origin/main의 조상, Task 1·Task 3 verify 세 개(bash·zsh) exit 0, 범위 사이트 커밋 M4·M3·M2·M1뿐, 값 누출 (a)(b)(c) 0건, 기록에 로컬 경로 없음
