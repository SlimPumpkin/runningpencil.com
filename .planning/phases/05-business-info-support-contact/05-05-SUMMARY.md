---
phase: 05-business-info-support-contact
plan: 05
subsystem: content
tags: [business-info, footer, d10-approval, candidate-object, playwright, one-way]
status: complete

# Dependency graph
requires:
  - phase: 05-business-info-support-contact
    provides: "05-01의 BASE_SHA·$W/lib.sh(mkobj·build·footblock·vals)·p5-foot.mjs, 05-02의 $W/yml/all.yml, 05-03의 M1·M2(빈 슬롯과 &nbsp;· 푸터 템플릿, 줄바꿈 CSS), 05-04의 M3·GUARD7·HOOK7"
provides:
  - "승인 후보 C4_CAND=fef24cd83cfb (로컬 스크래치 ref refs/p5-scratch/c4-cand에만 붙음, 어떤 브랜치에도 없음, 푸시 안 함)"
  - "작업 트리 _data/company.yml의 사업자 값 네 개 (커밋 안 함, 스테이징 안 함. 05-06 Task 1이 M4로 커밋)"
  - "05-EVIDENCE.md 구간 `## 05-05 시험 실행`·`## 05-05 값 후보`·`## 05-05 승인`, 표식 DRY_OBJ·DRY_RUN=OK·VALUES_RECEIVED=OK·C4_CAND·D10_APPROVED=OK·SEPARATOR=opt2·USER_MATCH=OK·D10_DATE"
  - "스크래치 빌드 $W/c3·$W/c4·$W/d10o1~3(05-06이 M4 출력과 cmp하는 승인 선택지 빌드는 $W/d10o2), 캡처 $W/cap/d10o<n>/ 열두 장"
affects: [05-06, 05-07, 05-11, 05-15]

# Actuals (#2632)
actuals:
  tokens: 1840     # chars/4 over 시도 2가 바꾼 줄(05-EVIDENCE.md 세 구간, 작업 트리 _data/company.yml 네 줄). 이 SUMMARY 제외
  tasks: 4
  commits: 2       # 측정값: git rev-list --count plan_head_before..HEAD (Task 1·Task 3 EVIDENCE 커밋). 이 SUMMARY·EVIDENCE 문서 커밋과 STATE 커밋은 뒤에 더해진다
plan_head_before: 00e23904e0d288bc8739426e2a404a13527ab3cf
plan_head_after: 3048e980584062a03505e89585a52a5eda12d2df

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "되돌릴 수 없는 공개 값은 브랜치에 붙지 않는 후보 객체(commit-tree)로만 빌드·판정하고, 스테이징은 같은 명령 묶음 안에서 바로 비우며, gc를 막는 로컬 스크래치 ref에만 붙인다"
    - "사람이 승인한 대상이 앞 시도의 후보일 때는 새 후보가 그 후보와 blob·사이트 트리·측정 출력까지 같음을 확인한 뒤에만 그 승인을 적용한다"

key-files:
  created:
    - .planning/phases/05-business-info-support-contact/05-05-SUMMARY.md
  modified:
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md
    - _data/company.yml (작업 트리만, 커밋 안 함)

key-decisions:
  - "D-10 승인 approve-opt2: 사업자등록증 표기 전체 그대로, 구분 기호는 지금 템플릿의 `&nbsp;· `. 템플릿 토큰을 바꾸는 커밋이 없다"
  - "시도 1(보류 1, fix-values) 뒤 사용자가 주소를 줄이려다 「그냥 원래대로 해」로 되돌려, 시도 2의 값은 시도 1 후보와 blob이 같다. 승인은 시도 1 후보를 보고 준 것이고, 조건 (a) blob 같음 (b) 사이트 트리 같음 (c) Task 3 verify 0·p5-foot 출력 같음을 확인한 뒤에만 적용했다"
  - "BIZ-01·BIZ-02는 완료 처리하지 않았다. requirements.ready-ids가 둘 다 blocked(05-06 이후 계획이 같은 ID를 선언)였다"

patterns-established:
  - "보류 뒤 다시 실행할 때는 앞 시도의 측정 출력을 덮어쓰기 전에 스크래치 옆 폴더(`$W/h1keep/`)에 따로 두고 새 출력과 cmp한다"

requirements-completed: []

coverage:
  - id: D1
    description: "가짜 사업자 값으로 후보 객체 → check-site → 빌드 → 푸터 범위·라벨 수 → 구분 기호 선택지 셋 캡처까지 같은 파이프라인이 끝까지 통과한다 (DRY_RUN=OK)"
    requirement: "BIZ-02"
    verification:
      - kind: integration
        ref: "05-05-PLAN.md Task 1 verify ($W/v505-t1.sh, bash·zsh exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "사업자 값 네 개가 작업 트리 _data/company.yml에만 있고(스테이징 없음), 후보 C4_CAND가 check-site 통과·출력 차이는 푸터 블록뿐·네 문서 라벨 trade/rep/bizno/addr 1·email/phone 0·선택지 셋 두 엔진×두 폭 PASS·캡처 12장·값 누출 0건"
    requirement: "BIZ-01"
    verification:
      - kind: integration
        ref: "05-05-PLAN.md Task 3 verify ($W/v505-t3.sh, bash·zsh exit 0)"
        status: pass
      - kind: other
        ref: "git log --format=%h BASE_SHA..C4_CAND^ -- _data/company.yml = M1 한 줄; ls $W/cap/d10o*/*.png = 12"
        status: pass
    human_judgment: false
  - id: D3
    description: "푸터의 사업자 값 표기가 사업자등록증과 글자까지 같다 (USER_MATCH=OK, 값은 기록하지 않음)"
    requirement: "BIZ-01"
    verification: []
    human_judgment: true
    rationale: "원본(사업자등록증)이 사용자에게만 있고 값을 기록할 수 없어, 대조는 사용자 판단으로만 한다(D-10 one-way). 승인은 시도 1 후보에서 받았고 시도 2 후보가 그와 바이트가 같음만 자동으로 확인했다"

# Metrics
duration: 9min
completed: 2026-11-19
---

# Phase 5 Plan 05: 사업자 값 후보와 D-10 승인 Summary

**사업자 값 네 개를 작업 트리 `_data/company.yml`에만 넣고 브랜치에 붙지 않는 후보 `C4_CAND=fef24cd83cfb`로 빌드해 check-site·푸터 범위·라벨·값 누출·구분 기호 선택지 셋 캡처를 통과시켰고, 시도 1 후보와 바이트가 같음을 확인한 뒤 사용자 승인 approve-opt2(등록증 표기 전체, `&nbsp;· `)를 기록했다**

## Performance

- **Duration:** 9 min (시도 2만. 시도 1은 보류 커밋 00e2390으로 끝남)
- **Started:** 2026-11-19T04:07:30Z
- **Completed:** 2026-11-19T04:17:00Z
- **Tasks:** 4 (Task 1·3 실행, Task 2·4는 사용자가 대화로 준 답을 오케스트레이터가 전달)
- **Files modified:** 2 (05-EVIDENCE.md 커밋, `_data/company.yml` 작업 트리만)

## Accomplishments

- 보류 1(시도 1, Task 4 fix-values) 뒤 05-01 「보류·중단과 다시 실행」대로 Task 1부터 다시 실행했다. 시도 1의 구간(`## (보류 1) 05-05 …`, `HOLD1_` 표식)은 그대로 두고, 새 구간을 머리 없는 이름으로 더했다. verify의 구간 읽기(`index($0,h)==1`)와 표식 읽기(`^C4_CAND=`, `-x 'DRY_RUN=OK'`)는 보류 구간·`HOLD1_` 표식에 걸리지 않는다.
- Task 1: 가짜 값 시험 객체 `DRY_OBJ=24ef2f9f92d9`(ref 없음)로 파이프라인 전체가 통과했다. 깨끗함 기록 `OK site-clean 05-05-t1 00e23904e0d2`.
- Task 3: 전달받은 값을 Edit로 네 칸의 따옴표 안에만 넣었고, 파일 blob이 시도 1 후보의 blob과 같았다. 값 누출 점검은 `vals filled=4 emitted=3 excluded=1`(상호는 Phase 5 전부터 공개된 운영사 표기라 제외), `.planning/`·커밋 메시지 0건. 후보 `C4_CAND=fef24cd83cfb`는 로컬 스크래치 ref `refs/p5-scratch/c4-cand`에만 있다.
- 실제 값에서는 375px에서도 첫 줄 세 항목이 한 줄에 들어가 두 엔진·두 폭 모두 sepLead=0이라, 세 구분 기호 선택지의 p5-foot 출력이 줄마다 같다(시도 1 출력과도 바이트가 같음). 선택지는 첫 줄이 바뀌는 더 좁은 화면이나 값이 바뀔 때만 모양이 갈린다.
- Task 4: 조건 (a) blob 같음, (b) 두 후보의 사이트 트리 같음, (c) Task 3 verify 종료 코드 0·세 선택지 PASS foot·sepLead 0·출력이 시도 1과 같음을 모두 확인한 뒤 `## 05-05 승인`에 `D10_APPROVED=OK`, `SEPARATOR=opt2`, `USER_MATCH=OK`, `D10_DATE=2026-11-19`를 적었다.

## Task Commits

1. **Task 1: 가짜 값 파이프라인 시험 (tracer)** - `10331e4` (docs)
2. **Task 2: 사업자 값 받기** - 커밋 없음 (사용자 답을 오케스트레이터가 전달, 값은 기록하지 않음)
3. **Task 3: 값 후보 판정과 선택지 캡처** - `3048e98` (docs, EVIDENCE만. `_data/company.yml`은 설계상 커밋 안 함)
4. **Task 4: D-10 승인 기록** - 이 계획의 문서 커밋에 포함 (SUMMARY와 함께)

시도 1의 `docs(05-05):` 커밋 3ffe217·63ae585는 보류 커밋 00e2390이 대신한다(revert 안 함).

## Files Created/Modified

- `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` - 구간 `## 05-05 시험 실행`·`## 05-05 값 후보`·`## 05-05 승인`과 표식
- `.planning/phases/05-business-info-support-contact/05-05-SUMMARY.md` - 이 문서
- `_data/company.yml` - 작업 트리에서만 사업자 값 네 칸을 채움. 스테이징·커밋하지 않았고 05-06 Task 1이 M4로 커밋한다. `support_email`·`phone`은 빈 값 그대로

## Decisions Made

- 구분 기호는 선택지 2(`&nbsp;· `, 지금 템플릿)로 정해져 05-06에 토큰 바꾸기 커밋이 없다.
- Task 4에서 로컬 빌드 푸터 글을 대화에 다시 보여 주는 단계는 이번 시도에서 하지 않았다. 사용자가 시도 1 후보(바이트가 같은 빌드)의 푸터 글과 캡처로 이미 대조·결정했고, 오케스트레이터 지시가 그 답을 조건 (a)(b)(c) 확인 뒤에만 쓰라는 것이었다.

## Deviations from Plan

### Auto-fixed Issues

None - plan executed as written. 아래 두 가지는 계획 동작을 바꾸지 않은 기록이다.

- **기록만: webkit 375 캡처 한 장의 흔들림.** 선택지 2의 webkit 375 첫 캡처가 선택지 1·3과 56줄(4171픽셀) 달랐다. 선택지 1·2를 다시 찍은 캡처(`$W/capchk/`)에서 선택지 2가 선택지 1·3과 픽셀까지 같고 자기 첫 캡처와 달라, 선택지 차이가 아니라 캡처가 한 번 흔들린 것으로 판단했다. p5-foot 측정은 세 선택지가 같고, 05-06은 캡처가 아니라 `$W/d10o2/site` 출력과 M4 출력을 cmp한다. 원래 캡처는 그대로 두었다.
- **기록만: 계획 commit 원장.** 시도 1이 남긴 `gsd-plan-head-before-05-05`(bf00e3e)를 시도 2 시작 HEAD 00e2390으로 바꿔, `actuals.commits`가 시도 1의 대체된 커밋을 세지 않게 했다.

---

**Total deviations:** 0 auto-fixed
**Impact on plan:** 없음

## Issues Encountered

None

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 05-06 Task 1 precondition(`D10_APPROVED=OK`, `USER_MATCH=OK`, `SEPARATOR=opt2`, `C4_CAND`, 스테이징 없음, 작업 트리에서 `_data/company.yml`만 고침)이 갖춰졌다. 05-06은 값 커밋 M4를 HEAD 위에 따로 만들고 네 문서가 `$W/d10o2/site`와 같은지 본 뒤, 푸시 SHA를 따로 승인받는다. 이 승인은 푸시 승인을 대신하지 않는다.
- 로컬 `main`은 원격보다 앞서 있고 아무것도 푸시하지 않았다(첫 푸시는 05-06).
- 스크래치 ref `refs/p5-scratch/c4-cand`와 `$W/h1keep/`·`$W/capchk/`는 단계 검증 뒤 사용자가 지운다.

---
*Phase: 05-business-info-support-contact*
*Completed: 2026-11-19*

## Self-Check: PASSED

- SUMMARY·EVIDENCE 파일 있음, 커밋 10331e4·3048e98이 HEAD의 조상, 스크래치 ref 있음, Task 1·3 verify(bash·zsh) exit 0, 값 누출 (a)(b)(c) 0건
