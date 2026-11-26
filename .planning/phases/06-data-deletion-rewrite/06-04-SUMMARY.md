---
phase: 06-data-deletion-rewrite
plan: 04
subsystem: docs
tags: [data-inventory, decisions, app-facts, rebase, location-use-records, operator-delete-tool, prod-preconditions]
status: complete

# Dependency graph
requires:
  - phase: 06-data-deletion-rewrite
    provides: "06-03의 앱 작업 보고 표식(APP_WORK_HEAD=92e986c3bb29, APP_ITEM_1·2·3·5·6, DEL06_REPORT=conform, U2_PROCEED=user-accepted-draft, INSTALL_ID=keep-out)과 중간 보고 ②·⑥의 dev TTL 조회 줄"
  - phase: 06-data-deletion-rewrite
    provides: "06-01의 스크래치 $W/lib.sh와 공통 규칙, 06-02의 기준 시점 정정(INV_FIX_SHA)·결정 기록(DEC_SHA)"
provides:
  - "데이터 목록 재기준 커밋 REBASE_SHA=aeb6f4461157: 기준 앱 커밋 92e986c3 (2026-11-26), 바뀐 파일의 인용 56개 재확인(27개 고침), 구간 A·C·D·E·F·G·H의 앱 작업 뒤 사실, 새 행 넷(확인자료 C·G, 해시 rate_limits G, 운영자 삭제 도구 G), 새 절 「### prod 전제 (Phase 6 D-42)」(다섯 가지의 유일한 목록)"
  - "결정 목록: U2 「초안으로 진행」, U6-나 「앱 반영됨」 (같은 커밋)"
  - "06-EVIDENCE.md 구간 `## 06-04 앱 사실`(APP_HEAD, APP_FACTS=OK, RATE_EXPIRY, RECDEL_UNIT, RECDEL_BADGES), `## 06-04 화면 사실`(SCREEN_FACTS=OK, LOC_CONSENT_CONTROL=none-found, ANON_WRITE=none-found, COURSE_CREATOR=hidden), `## 06-04 재기준`(REBASE_SHA, REBASE_CITES)"
  - "스크래치 $W/app-diff.txt (근거 경로 83개의 3afb2085..92e986c3 차이, 6058줄)"
affects: [06-05, 06-06, 06-13, 06-07, 06-11, phase-07, phase-08]

# Actuals (#2632)
actuals:
  tokens: 19721    # chars/4 over 실현된 diff (DATA-INVENTORY·DECISIONS 커밋 + 06-EVIDENCE.md 06-04 세 구간, 78885자. SUMMARY 제외)
  tasks: 3
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). EVIDENCE와 이 SUMMARY는 바로 뒤 docs 커밋, STATE·ROADMAP 진행표는 그 뒤 기록 커밋
plan_head_before: 1bc5e4a043158ff49a98f1b789e81a28bf80c260
plan_head_after: aeb6f4461157f5f2cefa1197c3481e3a8d54075c

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "재기준은 사용자가 고른 앱 작업 커밋에 고정한다. 앱 HEAD가 그 뒤로 움직였으면 해시와 차이의 파일 이름만 읽어 근거 경로 변경이 0인지 재고, 사실은 고정 커밋에서만 읽는다"
    - "행 번호 재확인은 옛 커밋의 인용 행 글자를 새 커밋에서 그대로 찾는 스크립트로 하고, 글자가 달라졌거나 여러 곳에 있는 것만 손으로 다시 읽는다"
    - "큰 표 문서의 편집은 「옛 글자가 정확히 n번 나올 때만 바꾼다」는 단언을 단 스크립트로 하고, 하나라도 어긋나면 파일을 쓰지 않는다"

key-files:
  created:
    - .planning/phases/06-data-deletion-rewrite/06-04-SUMMARY.md
  modified:
    - .planning/baseline/DATA-INVENTORY.md
    - .planning/baseline/DECISIONS.md
    - .planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md

key-decisions:
  - "06-04: 앱 작업 ①②③⑤⑥의 요청 사실이 기준 앱 커밋 92e986c3bb29의 코드에서 모두 참으로 확인됐다. ⑥ 확인자료는 세 경로(앱 기록 삭제, 탈퇴와 운영자 계정 전체 삭제, 운영자 records) 모두에서 파기된다. 앱 HEAD는 d52d13a74f9b로 10커밋 앞서 있지만 바뀐 것은 앱의 계획 문서뿐이라 기준을 옮기지 않았다"
  - "06-04: 데이터 목록을 92e986c3으로 재기준했다(REBASE_SHA aeb6f4461157). 탈퇴 정리의 근거는 공유 helper user_data_cleanup.ts로 옮기고, prod 전제 다섯 가지는 구간 H 아래 「prod 전제 (Phase 6 D-42)」 한곳에만 둔다"
  - "06-04: 결정 목록 U2는 「결정됨」이 아니라 「초안으로 진행」으로 적었다(법률 확인 전). U6-나는 「앱 반영됨」이고 낱말은 「공개하지 않은 코스」다"

patterns-established:
  - "삭제·보존 사실의 근거는 트리거 파일이 아니라 실제 삭제 코드가 있는 helper(deleteRunningPencilUserData)를 가리키고, 트리거와 운영자 함수는 호출 근거로만 적는다"
  - "사용자가 아직 정하지 않은 것(D-33 ①②④, D-39의 기간·삭제 경로)은 재기준 문서에 값으로 쓰지 않고 결정 번호로만 가리킨다"

requirements-completed: []  # 계획 frontmatter는 [DEL-03, DEL-04, DEL-06]. 이 계획은 본문의 근거(데이터 목록)를 재기준할 뿐 삭제 안내 본문을 쓰지 않아 요구사항을 닫지 않는다. requirements.ready-ids도 세 ID를 blocked로 돌려준다(뒤 계획이 같은 ID를 가짐). 06-01~06-03 SUMMARY와 같은 처리

coverage:
  - id: D1
    description: "앱 작업 ①②③⑤⑥의 요청 사실을 기준 앱 커밋 92e986c3bb29의 코드에서 읽어 06-EVIDENCE.md에 경로 다섯 줄, 사실 여섯 줄(③ 로그 포함), SRC 근거 줄, 앱 HEAD 이동 줄, APP_FACTS=OK로 기록"
    requirement: "DEL-06"
    verification:
      - kind: other
        ref: "06-04-PLAN.md Task 1 <verify> <automated> (exit 0, 계획 끝에 다시 실행해도 exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "삭제 안내 원고가 쓸 앱 화면 사실(회원탈퇴 라벨, 「내 계정」 화면 항목, 일부 삭제 메뉴 문구 일곱, 위치정보 동의 설정 없음, 익명 쓰기 없음, 만든 사람 표시 없음)을 같은 커밋에서 다시 읽어 SCREEN_FACTS=OK로 기록"
    requirement: "DEL-04"
    verification:
      - kind: other
        ref: "06-04-PLAN.md Task 2 <verify> <automated> (exit 0, 계획 끝에 다시 실행해도 exit 0)"
        status: pass
    human_judgment: false
  - id: D3
    description: "데이터 목록을 앱 커밋 92e986c3으로 재기준한 문서 커밋 aeb6f4461157 (구간 A·C·D·E·F·G·H, 새 행 넷, prod 전제 다섯 절)"
    requirement: "DEL-03"
    verification:
      - kind: other
        ref: "06-04-PLAN.md Task 3 <verify> <automated> (exit 0. 고정 문구, 커밋 범위, prod 전제 번호 다섯, 메시지 끝 줄)"
        status: pass
    human_judgment: true
    rationale: "verify는 고정 문구와 구조만 본다. 재기준한 칸의 문장이 앱 코드 사실과 맞는지, 「미확인」으로 둬야 할 것을 사실로 적지 않았는지(계획 prohibitions의 judgment 항목)는 검증자가 읽어서 판단해야 한다. 법적 문구는 법률 확인 전 초안이다"
  - id: D4
    description: "결정 목록 U2 상태 「초안으로 진행」, U6-나 상태 「앱 반영됨」 (한눈에 보기 표와 풀이 절)"
    verification:
      - kind: other
        ref: "06-04-PLAN.md Task 3 <verify> <automated>의 결정 목록 두 행 검사 (exit 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 16min
completed: 2026-11-26
---

# Phase 6 Plan 04: 앱 사실 확인과 데이터 목록 재기준 Summary

**앱 작업 ①②③⑤⑥이 앱 커밋 92e986c3bb29의 코드에서 참임을 항목별로 확인하고, 데이터 목록을 그 커밋으로 재기준해(확인자료·운영자 삭제 도구·코스 단위 기록 삭제·prod 전제 다섯) 결정 목록 U2 「초안으로 진행」·U6-나 「앱 반영됨」과 함께 문서 커밋 aeb6f4461157로 남김**

## Performance

- **Duration:** 16 min
- **Started:** 2026-11-26T10:26:00Z
- **Completed:** 2026-11-26T10:42:01Z (세 task와 계획 끝 검증이 끝난 시각. SUMMARY 작성과 기록 커밋은 그 뒤)
- **Tasks:** 3
- **Files modified:** 3 (`DATA-INVENTORY.md`, `DECISIONS.md`, `06-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- **앱 사실 (Task 1, tracer):** 기준 앱 커밋 `92e986c3bb29`가 `3afb2085`의 자손이고, 06-03이 받은 항목별 경로 열여덟 개가 모두 그 커밋에 있으며 앱 작업 차이에 들어 있다. 항목별 사실 여섯 줄을 코드에서 읽어 기록했다.
  - ① 탈퇴 정리 트리거와 운영자 `account`가 공개하지 않은 코스(`visibility !== "public"`)를 지우고 공개한 코스를 남긴다. 운영자 `records`는 코스를 남긴다.
  - ② uid가 든 `rate_limits` 문서 넷을 탈퇴 함수와 운영자 `account`가 지운다. 모든 기록이 제한 창(60초나 600초) 끝을 만료 시각으로 쓰고 TTL 정책이 지운다. 코드에 일수는 없다.
  - ③ 운영자 함수는 App Check 강제와 관리자 claim을 요구하고 범위는 `account`·`records`다. 명령은 기본이 dry-run이고 `--apply` 때 uid를 다시 받는다. 제공자 연결은 끊지 않고, 실행 흔적은 Cloud Logging 로그 네 종류뿐이다.
  - ⑤ 앱 기록 삭제는 코스 단위이고 그 코스의 기록 전부와 뱃지를 함께 지우며, 같은 기록의 기기 안 원시 로그도 지운다.
  - ⑥ 확인자료는 기록 1건마다 1건, 필드 여덟 개, 경로·좌표 없음, 184일. 세 경로 (a)(b)(c) 모두에서 파기된다.
- **앱 HEAD 이동:** 앱 로컬 `main`은 `d52d13a74f9b`로 기준보다 10커밋 앞서 있다. 바뀐 14개 파일은 모두 앱의 `.planning/`·`.claude/` 문서이고 삭제 관련 경로는 0개다. 계획의 멈춤 조건에 걸리지 않아 기준을 그대로 두고 진행했다.
- **화면 사실 (Task 2):** 「회원탈퇴」 라벨, 「내 계정」 화면의 항목 여섯과 이메일 없음 「-」·회원탈퇴 맨 아래, 메뉴 문구 일곱이 모두 기대 글자와 같다. 위치정보 동의만 끄는 설정은 없고(`LOC_CONSENT_CONTROL=none-found`), 익명에게 열린 새 `users` 쓰기도 없으며(`ANON_WRITE=none-found`), 코스 화면은 만든 사람을 표시하지 않는다(`COURSE_CREATOR=hidden`).
- **재기준 (Task 3):** 데이터 목록의 머리·재확인 규칙·근거 경로·구간 A·C·D·E·F·G·H를 계획의 고정 문구대로 고치고, 구간 H 아래에 prod 전제 다섯 가지의 유일한 목록을 만들었다. 결정 목록 U2·U6-나 상태를 고쳤다.

## Task Commits

1. **Task 1: 기준 앱 커밋·경로·항목 사실 확인 (tracer)** — 커밋 없음. 고친 파일이 `06-EVIDENCE.md`뿐이고, 06-01 「커밋 분리」 규칙대로 계획 끝 문서 커밋에 들어간다. `OK site-clean 06-04-t1 1bc5e4a04315`. verify exit 0을 두 번 확인한 뒤(tracer 관문) Task 2로 넘어갔다.
2. **Task 2: 앱 화면 사실 재확인** — 커밋 없음(같은 이유). `OK site-clean 06-04-t2 1bc5e4a04315`
3. **Task 3: 데이터 목록 재기준과 결정 목록 U2·U6-나** — `aeb6f4461157` (docs. `DATA-INVENTORY.md`·`DECISIONS.md` 둘만)

**Plan metadata:** 이 SUMMARY와 `06-EVIDENCE.md`는 바로 뒤 docs 커밋 하나, STATE·ROADMAP 진행표는 그 뒤 기록 커밋으로 들어간다 (06-01~06-03과 같은 순서). 푸시하지 않았다.

## Files Created/Modified

- `.planning/baseline/DATA-INVENTORY.md` — 기준 앱 커밋 `92e986c3`으로 재기준. 인용 27개 행 번호 수정, 근거 경로 19개 추가, 새 행 넷, 새 절 「### prod 전제 (Phase 6 D-42)」
- `.planning/baseline/DECISIONS.md` — U2 「초안으로 진행」, U6-나 「앱 반영됨」 (표와 풀이 절)
- `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` — `## 06-04 앱 사실`, `## 06-04 화면 사실`, `## 06-04 재기준` 세 구간
- `.planning/phases/06-data-deletion-rewrite/06-04-SUMMARY.md` — 이 문서

## Decisions Made

- 앱 사실은 `92e986c3bb29` 한 커밋에서만 읽었다. 앱 HEAD는 해시와 차이의 파일 이름만 읽어 이동을 쟀다. 기준을 앱 HEAD로 옮기지 않았다(D-36).
- 탈퇴 정리 사실의 근거를 `cleanup_user_data.ts`에서 공유 helper `user_data_cleanup.ts`로 옮기고 트리거는 호출 근거(60-64행)로만 두었다(D-44).
- U2는 「결정됨」으로 적지 않았다. 법률 확인 전 초안이라는 사실을 표 상태 칸과 풀이 절에 적었다(D-36).
- 사용자가 정하지 않은 것은 쓰지 않았다: 익명 계정 문장을 삭제 안내에 쓸지(D-33 ①), prod 값이 없는 기간의 표기(D-33 ②), 개발자 이름(D-33 ④), 공개 코스의 기간·삭제 경로 약속(D-39).
- 이 계획에는 사용자 결정 자리가 없었고 실행자가 대신 고른 선택지도 없다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - 같은 사실의 다른 칸] 계획이 짚지 않은 칸 셋을 재기준 사실에 맞춤**
- **Found during:** Task 3
- **Issue:** 계획은 구간 C `region` 행의 보유 기간 괄호만 고치라고 적었는데, 같은 행 삭제 방식 괄호가 「코스의 `region`은 탈퇴 시 삭제하지 않음」으로 남으면 공개하지 않은 코스를 지운다는 새 사실과 어긋난다. 구간 E 표 아래 Analytics 문장과 구간 H 표 아래 Analytics 메모도 「미확인」·「기본값을 적지 않았습니다」로 남아 표의 「최대 14개월 (설정 미확인」과 어긋난다.
- **Fix:** 세 곳을 표의 새 값과 같은 사실로 고쳤다.
- **Files modified:** `.planning/baseline/DATA-INVENTORY.md`
- **Verification:** Task 3 verify exit 0, 표 열 수 검사(구간별 세로줄 수) 통과
- **Committed in:** `aeb6f4461157`

**2. [Rule 2 - 근거 보충] 재기준 메모 아래 글머리 둘과 근거 칸 인용을 더함**
- **Found during:** Task 3
- **Issue:** 계획의 재기준 메모는 한 줄인데, 「재확인 규칙」 3번은 기준을 「그때의 앱 HEAD」로 올린다고 적어 이번 기준(사용자가 고른 앱 작업 커밋)과 다르게 읽힌다. 새로 쓴 칸에는 근거 인용이 필요하다.
- **Fix:** 고정 문구 한 줄은 글자 그대로 두고, 그 아래에 「기준은 앱 작업 커밋이고 그 뒤 앱 HEAD는 계획 문서만 바뀜」과 「바뀐 파일의 인용만 다시 찾음」 두 줄을 더했다. 새로 쓴 칸마다 `AW` 기준 `경로:행` 인용을 붙였다.
- **Files modified:** `.planning/baseline/DATA-INVENTORY.md`
- **Committed in:** `aeb6f4461157`

**3. [Rule 3 - 도구] verify 명령을 꺼내는 식을 줄 머리 태그로 좁힘**
- **Found during:** Task 1
- **Issue:** 계획 파일에서 `<automated>`가 든 줄을 세어 꺼냈더니 context의 설명 문장(재계획 보충 규칙 6번)이 첫 줄로 잡혀 bash 구문 오류가 났다.
- **Fix:** 줄 머리(공백 뒤)가 `<automated>`인 줄만 꺼내도록 고쳤다. 계획의 명령 글자는 고치지 않았고, 꺼낸 글자를 첫 줄이 `#!/usr/bin/env bash`인 임시 파일에 그대로 적어 돌렸다.
- **Files modified:** 없음 (저장소 밖 임시 스크립트)

---

**Total deviations:** 3 auto-fixed (Rule 1 하나, Rule 2 하나, Rule 3 하나)
**Impact on plan:** 범위는 그대로다. 사이트 파일을 고치지 않았고 사용자 결정을 대신하지 않았다.

## Issues Encountered

- 앱 저장소에 `git status --short`를 한 번 불렀다(계획 끝 확인). 06-01이 허용한 명령 목록(`rev-parse`·`log`·`diff`·`show`·`grep`·`cat-file`·`merge-base`·`ls-tree`) 밖이고 `rev-list --count`는 계획 Task 1 2번이 쓴 것이다. 둘 다 읽기 전용이고 앱 저장소의 커밋·작업 트리·ref는 바뀌지 않았다(fetch 없음).
- 인용 재확인 스크립트를 재기준 뒤 한 번 더 돌린 출력은 옛 커밋 기준 비교라 뜻이 없어 쓰지 않았다(파일 변경 없음). 재확인 수치는 편집 전 실행의 값이다.

## User Setup Required

None - 외부 서비스 설정이 필요하지 않다. prod 전제 다섯 가지는 prod 프로젝트를 만들 때의 일이고 데이터 목록 「prod 전제 (Phase 6 D-42)」에 있다.

## 뒤 계획이 알아야 할 것

- **06-05 (운영 절차서):** 도구 실행은 앱 문서 `docs/operator-delete-tool.md`를 가리킨다. 탈퇴 정리 실패 로그 이름은 `cleanup_user_data_failed`(단계 `runs`·`courses`·`location_use_records`·`badges`), 탈퇴 함수의 uid `rate_limits` 정리 실패 로그는 `delete_user_rate_limits_orphan`이다. 운영자 도구는 두 범위 모두 1시간 뒤 같은 명령(dry-run)으로 다시 확인한다. 대체 본인 확인이 쓸 「내 계정」 화면 항목은 데이터 목록 구간 A 표 아래 글머리에 있다.
- **06-06 Task 2 (D-33 ① 물음):** 앱 문서 `docs/kit-fork.md` 「익명 자동 정리」 절은 MVP 동안 끈다고 적고, 켜 두면 익명 계정의 뱃지도 잃는다고 적는다. 그런데 `AW`의 규칙은 익명 사용자의 뱃지 쓰기를 막는다(`firestore.rules:441`의 `isRegular()`). 같은 절은 dev에서 자동 정리가 켜져 있던 것을 2026-10-27에 껐다고 적는다. 사이트 D-26(prod에서 켬)과 어긋나는 곳이다.
- **06-06·06-07:** 메뉴 문구와 경로는 데이터 목록 구간 C `runs` 행의 글자를 쓴다. 코스 상세 ⋮의 기록 삭제 항목은 한 번에 하나만 보인다(그 코스 뱃지가 있으면 「뱃지 삭제」, 없으면 「기록 삭제」). 설정의 「데이터 관리」 묶음은 게스트에게 숨긴다.
- **06-11:** 데이터 목록 「확인할 것」 표의 「Firestore TTL 정책 … 확인함 (2026-11-15)」 행은 고치지 않았다. 구간 H는 2026-11-26 조회 값이다. 구간 E 삭제 방식 칸과 구간 G의 `fcmTokens` 행도 2026-11-15 조회 표기 그대로다(사실은 같다: `fcmTokens` TTL 정책 없음).
- **STATE의 계획 검사 info 「화면 라벨 둘의 근거 줄 미기록」:** 「프로필 사진」은 `SRC account-photo`, 「Danger zone」은 `lib/l10n/app_ko.arb:347`로 `## 06-04 화면 사실`에 적었다.
- **Phase 7·8:** 확인자료 행(구간 C)과 Functions 로그 행(구간 D)이 처리방침의 개인위치정보 항목과 위치약관의 확인자료 조항의 근거다. 법적 문구는 U2 초안 범위다.

## Next Phase Readiness

- 06-05(운영 절차서)를 시작할 수 있다. 06-04가 막던 것(앱 사실의 코드 확인, D-06 재기준 문서 커밋)은 닫혔다.
- 사이트 커밋을 막는 것은 그대로 남아 있다: D-33의 미결 항목(①②④)과 D-39의 공개 코스 문장은 06-06·06-08의 checkpoint에서 사용자가 정한다.
- 로컬 `main`은 `origin/main`보다 앞서 있고 푸시하지 않았다.

## Self-Check: PASSED

- 파일: `.planning/baseline/DATA-INVENTORY.md`, `.planning/baseline/DECISIONS.md`, `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md`, 이 SUMMARY 모두 있음
- 커밋: `aeb6f4461157`이 HEAD의 조상이고 두 baseline 파일만 담음
- Task 1·2·3 `<verify>`를 계획 끝에 다시 돌려 모두 exit 0
- 계획 `<verification>`: `DEC_SHA..REBASE_SHA` 사이 사이트 파일 커밋 0건, `06-EVIDENCE.md`에 홈 경로·경로 꼴 0건, `.planning/baseline`에 앱 프로젝트 ID 0건
- acceptance: 옛 기준 커밋 머리 줄 0, prod 전제 절 1, 확인자료 낱말 1 이상, 「공개하지 않은 코스」 6

---
*Phase: 06-data-deletion-rewrite*
*Completed: 2026-11-26*
