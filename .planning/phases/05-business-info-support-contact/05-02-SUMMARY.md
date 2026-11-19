---
phase: 05-business-info-support-contact
plan: 02
subsystem: testing
tags: [prototype, render-if-present, footer, support, jekyll, liquid, matrix]
status: complete

# Dependency graph
requires:
  - phase: 05-business-info-support-contact
    provides: "05-01의 BASE_SHA=2db88d9a199f, 스크래치 $W/lib.sh(build·variant·footblock·mkobj 등 함수 열 개), 기준 빌드 $W/base"
provides:
  - "원형 blob 세 개(05-EVIDENCE.md `## 05-02 원형`): PROTO_DATA_BLOB(빈 슬롯 _data/company.yml), PROTO_FOOTER_BLOB(_includes/footer.html 사업자·주소·이메일/전화 줄), PROTO_SUPPORT_BLOB(support/index.html 지원 페이지). 05-03(M1)·05-04(M3 음성 대조)·05-08(보류 커밋 H1)이 이 blob을 그대로 꺼내 쓴다"
  - "시험용 커밋 객체 PROTO_OBJ=68b96890f7f8 (BASE_SHA 위, ref 없음, 푸시 안 함)와 그 빌드 $W/proto"
  - "05-EVIDENCE.md `## 05-02 행렬`: 가짜 값 열한 경우 판정 줄 열한 개 + 순서 줄, PROTO_MATRIX=OK"
  - "스크래치(커밋 안 함): $W/proto-data.yml·proto-footer.html·proto-support.html, $W/yml/의 가짜 값 열 파일, $W/matrix.sh, 빌드 $W/v-<경우>/ 열한 개"
affects: [05-03, 05-04, 05-05, 05-08, 05-11]

# Actuals (#2632)
actuals:
  tokens: 1064     # chars/4 over 05-EVIDENCE.md 추가분(4258자). SUMMARY 제외. 원형 세 파일(7736자)은 스크래치와 ref 없는 blob에만 있고 저장소 파일이 아니다
  tasks: 2
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD. 기록 전용 계획이라 task 커밋이 없고, EVIDENCE와 이 SUMMARY는 뒤 docs 커밋 하나로 들어간다
plan_head_before: 3056bc8b20f1886bcfa501a829a6ddf99bf3a804
plan_head_after: 3056bc8b20f1886bcfa501a829a6ddf99bf3a804

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "설계 시험은 mkobj로 BASE_SHA 위에 ref 없는 커밋 객체를 만들어 build/variant로 빌드하고, 기록에는 blob 해시만 남긴다. 뒤 계획은 `git cat-file blob <PROTO_*_BLOB>`로 같은 바이트를 꺼낸다"
    - "render-if-present 행렬: `variant v-<경우> <PROTO_OBJ> $W/yml/<경우>.yml` 뒤 `$W/matrix.sh <경우>`가 개수만 찍는다(등장 수, 값 내용은 찍지 않음)"

key-files:
  created:
    - .planning/phases/05-business-info-support-contact/05-02-SUMMARY.md
  modified:
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md

key-decisions:
  - "푸터 구분 기호는 `&nbsp;· `(줄 끝 고정, RESEARCH Pattern 3 선택지 2)로 세 곳 모두 바꿨고, 사업자 줄 `<p>`의 클래스 속성은 쓰는 CSS가 없어 뺐다. 나머지는 RESEARCH Code Example 1과 글자까지 같다"
  - "지원 페이지 원형의 문장은 RESEARCH 「FAQ 문장안」이 아니라 PLAN Task 1 action 3의 문장을 그대로 썼다(운영 주체 답, 위치 답의 「화면에서도 … 읽지만」, `<strong>설정 → 내 계정 → 회원탈퇴</strong>` 꼴)"
  - "요구사항 BIZ-02·BIZ-03·SUP-01·SUP-03·SUP-04는 완료 처리하지 않았다. 이 계획은 설계를 스크래치에서 시험만 했고 사이트에 들어간 것이 없다. `requirements.ready-ids`도 다섯 개 모두 blocked(뒤 계획이 같은 ID를 선언)였다"

patterns-established:
  - "05-03 M1은 `git cat-file blob <PROTO_DATA_BLOB>`·`<PROTO_FOOTER_BLOB>`을 그대로 커밋하고, 05-08 H1은 `<PROTO_SUPPORT_BLOB>`을 그대로 커밋한다. 원형을 고쳐야 하면 05-02 Task 1부터 다시 해 blob을 바꾼다"

requirements-completed: []

coverage:
  - id: D1
    description: "원형 세 파일을 기준에 얹은 빌드에서 `/`와 법적 3종이 기준과 바이트까지 같고, 출력 파일 차이는 support/index.html 하나이며, 지원 페이지는 빈 값에서 #faq와 dl 두 개만 그린다. check-site 통과"
    requirement: "BIZ-02"
    verification:
      - kind: command
        ref: "05-02-PLAN.md Task 1 <verify> (Task 2 뒤 다시 실행, exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "가짜 값 열한 경우(빈 문자열·null·키 없음·파일 없음·모두·대표자·상호+번호·전화·이메일·상호·이스케이프)에서 행·span·구분 기호·mailto·전화·구간·FAQ dl 수·footsame·이스케이프가 계획 때 정한 기대 줄과 모두 같다"
    requirement: "BIZ-03"
    verification:
      - kind: command
        ref: "05-02-PLAN.md Task 2 <verify> (exit 0)"
        status: pass
    human_judgment: false
  - id: D3
    description: "지원 페이지 원형 문장(문의 응답 안내, 신고 메일 항목 네 개, FAQ 위치·탈퇴·운영 주체·신고 답)이 DATA-INVENTORY·앱 코드 확인 범위 안이고 처리 결과 약속이 없다"
    requirement: "SUP-04"
    verification: []
    human_judgment: true
    rationale: "문장의 사실 범위와 표현 적절성은 grep으로 일부만 확인된다(필수 문장 존재, 금지 키 없음). 심사자 관점의 문구 판단은 사람 확인이 필요하다. 05-08 H1과 게이트 캡처에서 다시 본다"

# Metrics
duration: 8min
completed: 2026-11-19
---

# Phase 5 Plan 02: 원형 슬롯·푸터·지원 페이지 설계 시험 Summary

**기준 커밋 위 ref 없는 시험 객체로 빈 슬롯·`&nbsp;· ` 푸터·지원 페이지 원형을 빌드해 네 문서 바이트 동일을 확인하고, 가짜 값 열한 경우 행렬이 기대 줄과 모두 같음을 확인했다. 원형 blob 세 개를 05-03·05-04·05-08용으로 기록했다**

## Performance

- **Duration:** 약 8분 (기록 시작부터. 앞선 문서 읽기 제외)
- **Started:** 2026-11-19T02:21:22Z
- **Completed:** 2026-11-19T02:29:00Z
- **Tasks:** 2 / 2
- **Files modified:** 1 (`05-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- 원형 세 파일(`_data/company.yml` 빈 슬롯, `_includes/footer.html` 사업자·주소·이메일/전화 줄, `support/index.html`)을 `mkobj`로 `BASE_SHA` 위에 얹은 시험 객체 `PROTO_OBJ=68b96890f7f8`을 만들었다. `scripts/check-site.sh`는 통과했다. 빌드한 네 문서는 기준과 `cmp`로 같았고, 출력 파일 목록 차이는 `support/index.html` 하나였다(tracer 통과).
- 지원 페이지는 빈 값에서 `<title>고객 지원 - 러닝펜슬</title>`, h1 「러닝펜슬 고객 지원」, `#faq` 하나, `dl` 두 개, robots 메타 0, 「최종 업데이트」 0으로 빌드됐다. 원형 본문의 요소는 `a dd dl dt h2 li p section strong ul`, 속성은 `<a href=`·`<section id=`뿐이다.
- 열한 경우 행렬이 기대 줄과 모두 같았다.
  - 값이 없는 네 경우는 `same=4`다.
  - 구분 기호 수는 「있는 항목 수 − 1」이다(`trade-bizno` 1, `all` 3, 나머지 0).
  - 「전화」는 `all`·`phone`에서만 생긴다.
  - `#contact`·`#report`는 이메일 값이 있을 때만 contact → report → faq 순서로 생긴다.
  - FAQ `dl` 수는 2 + 상호 + 이메일이다.
  - `A&B <x>`는 여섯 곳 모두 이스케이프됐고 날 글자는 0곳이다.
  - 다섯 문서 푸터는 모두 같다.

## Task Commits

이 계획은 기록 전용이다. 05-01과 같이 task 커밋은 없고, `05-EVIDENCE.md`와 이 SUMMARY를 docs 커밋 하나로 넣는다(PLAN `<output>`, 05-01 「모든 task에 적용하는 규칙」의 커밋 분리).

1. **Task 1: 원형 시험 객체 빌드 (tracer)** — 커밋 없음, 기록은 `## 05-02 원형`, 깨끗함 기록 `OK site-clean 05-02-t1 3056bc8b20f1`
2. **Task 2: 가짜 값 열한 경우 행렬** — 커밋 없음, 기록은 `## 05-02 행렬`, 깨끗함 기록 `OK site-clean 05-02-t2 3056bc8b20f1`

## Files Created/Modified

- `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` — `## 05-02 원형`(PROTO_OBJ, blob 해시 세 개, check-site 통과 줄, 판정 줄 세 개, PROTO_EMPTY=OK)과 `## 05-02 행렬`(판정 줄 열두 개, PROTO_MATRIX=OK)을 더했다
- `.planning/phases/05-business-info-support-contact/05-02-SUMMARY.md` — 이 문서
- 스크래치 `$W/`(저장소 밖, 커밋 안 함): `proto-data.yml`, `proto-footer.html`, `proto-support.html`, `proto-obj`(PROTO_OBJ 전체 해시), `yml/`의 열 파일, `matrix.sh`, 빌드 `proto/`, `v-{empty,null,nokeys,nofile,all,rep,trade-bizno,phone,email,trade,escape}/`

## Decisions Made

- 구분 기호는 계획대로 `&nbsp;· `(constraint 10 기본값)로 했다. 375px 화면 확인은 뒤 계획(05-03·05-05 캡처)의 몫이다.
- 시험 값은 가짜 값뿐이다. 지원 주소 자리에는 `test@example.invalid`를 썼다. `all.yml`의 긴 상호(46자)·긴 주소(64자)에는 `·`·「전화」·`mailto`를 넣지 않아 개수 판정이 흐려지지 않게 했다.
- `matrix.sh`는 줄 수가 아니라 등장 수를 센다. 사업자 줄 한 줄에 span 세 개와 구분 기호 두 개가 들어가기 때문이다. 스크래치 경로는 scratch_contract의 식을 그대로 쓰고, `footblock`은 `lib.sh`를 불러 쓴다.

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- (관찰, 막는 문제 아님) 지원 페이지 출력에서 `<div class="rp-doc">` 바로 뒤에 빈 줄이 생긴다. 이메일 값이 없으면 두 줄, 있으면 한 줄이다. 레이아웃은 `{{ content | rstrip }}`로 오른쪽만 지우는데, 본문 첫 줄이 0열 `{%- if … %}`이고 조건 뒤 줄바꿈이 남기 때문이다. HTML 렌더링에는 영향이 없다. 계획이 고정한 0열 조건 줄 모양(include 공백 규칙)을 바꾸지 않으려고 그대로 두었다. 05-08 H1이 같은 blob을 쓰므로 출력도 같다.
- `nokeys`(주석 한 줄뿐인 YAML)는 RESEARCH가 미리 시험하지 않은 경우였다. Jekyll이 `site.data.company`를 빈 값으로 읽어 `same=4`로 기대대로 나왔다.

## 점검

- 문서 커밋 전 작업 트리 `scripts/check-site.sh`: `check-site: 통과 (작업 트리, jekyll 3.10.0)`
- 값 누출 점검: `vals filled=0 emitted=0 excluded=0` → `leak=skip(no new values)`. 작업 트리에 `_data/company.yml`이 아직 없다
- 기록 누출 검사: `05-EVIDENCE.md`와 이 SUMMARY에 로컬 홈 경로, 임시 폴더 실제 경로, 홈 변수 문자열이 없다(`<verification>`의 세 패턴으로 grep, 0건)
- 이 계획이 고친 저장소 파일은 `05-EVIDENCE.md` 하나와 이 SUMMARY다. 사이트 파일은 그대로다(깨끗함 기록 두 줄)

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 05-03(M1)이 쓸 것: `PROTO_DATA_BLOB`·`PROTO_FOOTER_BLOB`. 빈 슬롯 바이트 동일은 이미 `OK proto same=4`로 확인했다.
- 05-04(M3)·05-08(H1)이 쓸 것: `PROTO_SUPPORT_BLOB`.
- 스크래치 재확인 (마) 항목(`$W/yml/` 열 파일, `$W/proto-support.html`)이 지금 있다.
- Ready for 05-03.

## Self-Check: PASSED

- FOUND: `05-EVIDENCE.md`의 `PROTO_EMPTY=OK`, `PROTO_MATRIX=OK`, `PROTO_SUPPORT_BLOB=3c561223f005c7ccb3d2d742c66e8398162884f5`(`git cat-file -t` blob)
- FOUND: `$W/proto/site/support/index.html`, `$W/v-all/site/support/index.html`, `$W/yml/` 열 파일, `$W/matrix.sh`
- Task 1·Task 2 `<verify>` 모두 exit 0 (Task 1은 Task 2 뒤에 다시 돌렸다)
