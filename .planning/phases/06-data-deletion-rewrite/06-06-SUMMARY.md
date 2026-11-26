---
phase: 06-data-deletion-rewrite
plan: 06
subsystem: docs
tags: [data-deletion, retention-table, data-inventory, user-decision, anonymous-account, public-course]
status: complete

# Dependency graph
requires:
  - phase: 06-data-deletion-rewrite
    provides: "06-04의 재기준 데이터 목록(REBASE_SHA=aeb6f4461157)과 익명 행 정정(ANON_ROW_FIX_SHA=d7dd8609bcb9): 구간 C·E·F·G·H와 「### prod 전제 (Phase 6 D-42)」"
  - phase: 06-data-deletion-rewrite
    provides: "06-03·06-04의 결정 표식(INSTALL_ID=keep-out, COURSE_CREATOR=hidden)과 06-05의 운영 절차서(OPS_SHA=0cc0e1767353)"
provides:
  - "06-EVIDENCE.md 구간 `## 06-06 대조표`: 재기준 목록 대상 33행을 지워짐 10·남음 5·결정 필요 10·표 밖 8로 나눈 표 (TABLE_SOURCE_ROWS=33, TABLE_ROWS=33)"
  - "06-EVIDENCE.md 구간 `## 06-06 결정`: D33_C7=ga, D33_C8=proposal, PUBLIC_COURSE_PERIOD=서비스를 운영하는 동안, D39_PATH=none, APPCHECK_ROW=out, AUTHLOG_ROW=phase7, DEVICE_SENTENCE=out, INSTALL_SENTENCE=out"
  - "06-13이 대조표를 확정하고 데이터 목록에 옮길 때 읽는 표식 전부와 답이 나온 과정의 기록"
affects: [06-13, 06-07, 06-11, phase-7, phase-8, phase-10]

# Actuals (#2632)
actuals:
  tokens: 3307     # chars/4 over 실현된 diff (06-EVIDENCE.md에 더한 130줄 13229자. SUMMARY 제외)
  tasks: 3
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY를 쓸 때). 문서만 고치는 계획이고 계획이 커밋을 「계획 끝 문서 커밋 하나」로 정해, 이 SUMMARY와 06-EVIDENCE.md가 그 첫 커밋이다. STATE·ROADMAP 커밋은 그 뒤
plan_head_before: 3c5456a72d2a0e1a857de3892c426aeec2e565c8
plan_head_after: 3c5456a72d2a0e1a857de3892c426aeec2e565c8

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "같은 데이터가 데이터 행(구간 G·E)과 보존 값 행(구간 H)에 함께 있으면 사이트 표의 한 행이 될 쪽만 「남음」·「결정 필요」로 두고 다른 쪽은 「표 밖」으로 두어 짝 행을 적는다"
    - "사용자 결정 기록에는 답 표식과 함께 답이 나온 과정(누가 무엇을 보였고 누가 권했고 누가 골랐는지)을 적는다"

key-files:
  created:
    - .planning/phases/06-data-deletion-rewrite/06-06-SUMMARY.md
  modified:
    - .planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md

key-decisions:
  - "06-06: 삭제 안내의 지워짐·남음을 재기준 데이터 목록(익명 행 정정 d7dd8609bcb9) 행 단위로 고정했다. 대상 33행을 지워짐 10·남음 5·결정 필요 10·표 밖 8로 나눈 대조표가 06-EVIDENCE 「06-06 대조표」에 있고, 「결정 필요」 10행은 06-13이 아래 답대로 분류만 바꾼다"
  - "06-06: 익명(둘러보기) 계정 문장은 ga(사용자, 2026-11-26). 자동 삭제 문장은 넣지 않고 「둘러보기에서는 기록·코스·뱃지를 서버에 저장하지 않는다」만 쓴다. 「서버에 아무것도 저장하지 않는다」로 넓혀 쓰지 않는다(익명 호출이 만든 uid rate_limits 기록과 Analytics·Crashlytics·로그의 uid가 있음). 사이트 D-26(prod에서 켬)과 앱 문서(MVP 동안 끔)의 어긋남과 prod 전제 1번은 열린 채다"
  - "06-06: D-33 ②·D-39 답(사용자, 2026-11-27 한국 시각): a=proposal(연구의 상한 약속 방식 그대로) / 공개 코스 기간 문구 「서비스를 운영하는 동안」, 탈퇴한 사람의 공개 코스를 요청으로 지우는 경로·기간은 약속하지 않음(D39_PATH=none) / App Check 행 뺌 / Firebase Authentication 로그 IP는 Phase 7 처리방침으로 / 기기 안 설정 문장·installation ID 설명 문장 넣지 않음. 사용자가 checkpoint 전체를 본 뒤 오케스트레이터에 권고를 물었고, 그 권고 문자열을 「권고안대로」라고 받아들인 답이다. 실행자는 고르거나 권하지 않았다"
  - "06-06: a=proposal의 전제는 prod에서 지켜야 참이다. prod에서 Firestore PITR·예약 백업·mail 대기열 발송을 켜려면 먼저 남는 데이터 표에 행을 더하고, PITR·예약 백업은 #location 「지체 없이 파기」 문장도 함께 다시 정한다. prod에서 메일을 mail 대기열로 보낼지는 정해지지 않았다(사용자가 그 물음에 따로 답하지 않음). c·e·f를 Phase 7 처리방침에서 다룰지도 정해지지 않았다"

patterns-established:
  - "결정 checkpoint의 답은 표식 줄(줄 머리 `이름=값`)과 「답이 나온 과정」 글머리로 함께 남긴다. 권고가 있었으면 누가 권했는지 적는다"
  - "연구 제안을 그대로 고른 답(proposal)은 행별 문구를 기록에 다시 옮기지 않고 계획의 한 줄을 유일한 출처로 둔다"

requirements-completed: []  # 계획 frontmatter는 [DEL-03]. 이 계획은 삭제 안내 본문을 쓰지 않고 본문이 쓸 지워짐·남음과 결정을 고정할 뿐이라 요구사항을 닫지 않는다. requirements.ready-ids도 DEL-03을 blocked로 돌려준다(뒤 계획이 같은 ID를 가짐). 06-01~06-05 SUMMARY와 같은 처리

coverage:
  - id: D1
    description: "재기준 목록 G·E·H(와 구간 C 기기 안 원시 GPS 로그 1행) 대상 33행을 한 번씩 나눈 대조표와 행 수 표식 둘, 결정이 필요한 행을 Task 2·3 물음에 묶은 목록"
    requirement: "DEL-03"
    verification:
      - kind: other
        ref: "06-06-PLAN.md Task 1 <verify> <automated> (exit 0. tracer 관문에서 두 번, 이어 하기 실행에서 두 번)"
        status: pass
    human_judgment: true
    rationale: "verify는 행 수 표식과 고정 낱말만 본다. 각 행의 분류·남는 이유·기간이 재기준 데이터 목록의 해당 행과 맞는지(06-VALIDATION Manual 「남는 데이터 표가 재기준 데이터 목록과 일치」)와, 계획 셈 규칙과 다른 두 처리(33행 셈, H12·H13·H14·H18을 「표 밖」으로 둠)가 받아들일 만한지는 사람이 읽어야 한다"
  - id: D2
    description: "익명(둘러보기) 계정 문장 결정 기록: 묻기 전 목록 사실 확인 줄(OK anon facts in inventory d7dd8609bcb9)과 D33_C7=ga, 닫히지 않은 어긋남"
    requirement: "DEL-03"
    verification:
      - kind: other
        ref: "Task 2 acceptance: 구간 `## 06-06 결정`에 `^OK anon facts in inventory [0-9a-f]{12}$` 1줄, `^D33_C7=ga$` 1줄, `^D33_C7_SENTENCE=` 0줄 (grep)"
        status: pass
    human_judgment: true
    rationale: "기록이 사용자의 실제 답과 같은지는 사용자만 확인할 수 있다. 계획 prohibition(실행자가 열린 선택지를 대신 고르지 않음)의 판정 방식이 judgment다"
  - id: D3
    description: "D-33 ②·D-39·표 범위 결정 기록: 표식 일곱(D33_C8, PUBLIC_COURSE_PERIOD, D39_PATH, APPCHECK_ROW, AUTHLOG_ROW, DEVICE_SENTENCE, INSTALL_SENTENCE)과 답이 나온 과정 네 단계, `#report` 읽기 결과, 닫히지 않은 항목"
    requirement: "DEL-03"
    verification:
      - kind: other
        ref: "Task 3 acceptance: 표식 일곱이 파일 전체에서 줄 머리부터 각 한 번, 끝 공백 0 (grep -x -F). 06-13 verify의 D33_C8 읽기 식이 proposal을 돌려줌"
        status: pass
    human_judgment: true
    rationale: "이 답은 사용자가 오케스트레이터의 권고를 듣고 받아들인 것이고, 실행자는 오케스트레이터가 전한 글로 받았다. 기록이 사용자의 뜻과 같은지, 특히 costly로 표시된 보존 고지(공개 코스 기간, prod 상한 약속)를 그대로 둘지는 사용자가 확인해야 한다. 06-07 원고 승인에서 표와 함께 다시 보게 된다"
  - id: D4
    description: "이 계획 동안 사이트 파일을 고친 커밋 없음, 저장소 파일 가운데 06-EVIDENCE.md만 고침, 기록에 경로·토큰 꼴과 홈 경로 0건"
    verification:
      - kind: other
        ref: "계획 <verification> 3번: `git log 3c5456a72d2a..HEAD -- . ':(exclude).planning'` 빈 출력, `OK site-clean 06-06-t1`·`06-06-t3` 줄, 누출 꼴 grep 0건, check-site 통과"
        status: pass
    human_judgment: false

# Metrics
duration: 7h 33m (사용자 대기 포함)
completed: 2026-11-26
---

# Phase 6 Plan 06: 지워짐·남음 대조표와 남은 사용자 결정 Summary

**재기준 데이터 목록의 대상 33행을 지워짐 10·남음 5·결정 필요 10·표 밖 8로 나눈 대조표를 고정하고, 익명 계정 문장(ga), prod 값 없는 기간(연구의 상한 약속 방식 그대로), 공개 코스 기간 「서비스를 운영하는 동안」과 삭제 경로 약속 없음, 표 범위 넷(모두 표·문장에서 뺌, 로그 IP는 Phase 7)을 사용자 답으로 닫음**

## Performance

- **Duration:** 7h 33m (사용자 대기 포함. 두 blocking checkpoint의 답을 기다린 시간이 대부분이다)
- **Started:** 2026-11-26T12:46Z 무렵 (시작 시각 파일의 값은 2026-11-26T12:53:43Z이고, 앞 실행자 메모에 따르면 실제 시작보다 7분쯤 늦게 적혔다)
- **Completed:** 2026-11-26T20:19Z (한국 시각 2026-11-27 05:19. Task 3 답 기록과 계획 끝 검증이 끝난 시각. SUMMARY 작성과 커밋은 그 뒤)
- **Tasks:** 3 (tracer 하나, blocking-human 결정 checkpoint 둘)
- **Files modified:** 1 (`06-EVIDENCE.md`, 130줄 더함) + 이 SUMMARY
- **실행자 세션:** 셋. 첫 세션이 Task 1과 Task 2 질문, 둘째 세션이 Task 2 답 기록과 Task 3 질문, 셋째 세션(이 SUMMARY를 쓴 세션)이 Task 3 답 기록과 마무리를 했다. checkpoint마다 새 실행자가 이어 받았다

## Accomplishments

- **대조표 (Task 1, tracer):** `ANON_ROW_FIX_SHA`(`d7dd8609bcb9`)의 데이터 목록에서 구간 G 17행, 구간 E 가운데 G에 없는 4행, 구간 H의 보존 기간 11행, 구간 C의 기기 안 원시 GPS 로그 1행을 한 줄씩 나눴다. `TABLE_SOURCE_ROWS=33`, `TABLE_ROWS=33`.
  - 지워짐 10행은 범주 여덟이다: 계정 정보, 직접 올린 프로필 사진, 기록과 GPS 경로, 뱃지, 공개하지 않은 코스, 알림 토큰, uid가 든 호출 횟수 제한 기록, 위치정보 확인자료.
  - 남음 5행은 사이트 표의 다섯 행과 하나씩 맞는다: 공개 코스, 해시 호출 횟수 제한 기록(「7일 안」), Analytics(「최대 14개월」), Crashlytics(「90일이 지나면 지우기 시작」), Firebase Authentication 백업(「삭제 뒤 180일 안」).
  - 결정 필요 10행은 Task 2(1행)와 Task 3 (a)·(c)·(e)·(f)(9행) 물음에 묶었다. 공개 코스 행의 기간과 Firebase Authentication 로그 IP는 「남음」 행의 의존 칸에서 Task 3 (b)·(d)로 넘겼다.
- **익명 계정 문장 (Task 2):** 묻기 전에 목록의 여섯 고정 문구를 확인했다(`OK anon facts in inventory d7dd8609bcb9`). 사이트 D-26(prod에서 켬)과 앱 문서(MVP 동안 끔)의 어긋남을 선택지와 함께 보였고, 사용자가 `ga`로 답했다. `D33_C7=ga`.
- **prod 값 없는 기간·공개 코스·표 범위 (Task 3):** 묻기 전에 `support/index.html` `#report` 구간이 신고만 받고 삭제를 약속하지 않음을 읽어 함께 보였다. 사용자가 선택지 `answer`로 여섯 물음에 답했고 표식 일곱을 적었다.

| 물음 | 답 | 표식 |
|---|---|---|
| (a) prod 값이 없는 행의 표기 | 연구 제안(상한 약속 방식) 그대로 | `D33_C8=proposal` |
| (b) 공개 코스 행의 기간 문구 | 「서비스를 운영하는 동안」 | `PUBLIC_COURSE_PERIOD=서비스를 운영하는 동안` |
| (b) 탈퇴한 사람의 공개 코스 삭제 경로·기간 약속 | 약속하지 않음 | `D39_PATH=none` |
| (c) App Check 토큰 행 | 표에 넣지 않음 | `APPCHECK_ROW=out` |
| (d) Firebase Authentication 로그의 IP | 표에 넣지 않고 Phase 7 처리방침으로 | `AUTHLOG_ROW=phase7` |
| (e) 기기 안 설정 문장 | 넣지 않음 | `DEVICE_SENTENCE=out` |
| (f) installation ID 설명 문장 | 넣지 않음 | `INSTALL_SENTENCE=out` |

## Task Commits

1. **Task 1: 대조표 (tracer)** — 커밋 없음. 작업 트리의 `06-EVIDENCE.md`에만 있다가 계획 끝 문서 커밋에 들어간다. `OK site-clean 06-06-t1 3c5456a72d2a`. verify exit 0을 두 번 확인한 뒤(tracer 관문) Task 2로 넘어갔다.
2. **Task 2: 익명 계정 문장 (checkpoint:decision, blocking-human)** — 커밋 없음. 답 `ga`.
3. **Task 3: prod 값 없는 기간·공개 코스·표 범위 (checkpoint:decision, blocking-human)** — 커밋 없음. 답 `answer`(여섯 물음).

**Plan metadata:** 계획이 「커밋은 계획 끝 문서 커밋 하나」로 정했다(계획 context와 output). 이 SUMMARY와 `06-EVIDENCE.md`가 그 문서 커밋이고, STATE·ROADMAP 진행표는 그 뒤 docs 커밋으로 들어간다(06-01~06-05와 같은 순서). 푸시하지 않는다.

## Files Created/Modified

- `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` — 구간 `## 06-06 대조표`(표 33행, 표식 둘, 셈 규칙과 묶음 메모), `## 06-06 결정`(익명 사실 확인 줄, Task 2 답, Task 3 질문 기록, Task 3 답과 과정)
- `.planning/phases/06-data-deletion-rewrite/06-06-SUMMARY.md` — 이 문서

저장소의 다른 파일(사이트 파일, 데이터 목록, 계획 파일, 설정)은 고치지 않았다. 대조표 확정과 데이터 목록 반영은 06-13이 한다.

## Decisions Made

실행자가 고른 선택지는 없다. 아래는 모두 사용자 답이고, 답이 나온 과정을 함께 적는다.

- **Task 2 (D-33 ①):** `ga`. 사용자가 2026-11-26에 선택지 넷(ga, na, da, hold)을 본 뒤 답했다. 검증 기록에는 「실행자는 어느 것도 권하지 않았다」고 적혀 있다. 삭제 안내에는 「둘러보기에서는 기록·코스·뱃지를 서버에 저장하지 않는다」만 쓴다.
- **Task 3 (D-33 ②, D-39, 표 범위):** `a=proposal / b=서비스를 운영하는 동안 / c=out / d=phase7 / e=out / f=out`. 과정은 네 단계다.
  1. 사용자가 Task 3 checkpoint 전체를 보았다(여섯 물음의 사실, (a)의 행별 연구 제안, (b)의 `#report` 읽기 결과와 앱 HEAD 이동 메모, (d)를 `official`로 정할 때의 열린 항목, 답하는 세 가지 방법).
  2. 사용자가 오케스트레이터에 권고안을 물었다(「권고안은?」).
  3. 오케스트레이터가 연구 제안과 구별되는 자기 의견이라고 밝히고 위 문자열을 권했다. 물음마다 이유 한 줄과 답이 뒤집힐 조건을 댔고, (d)가 가장 팽팽하고 (e)·(f)는 판단에 달렸다고 했다. prod에서 인증 메일·비밀번호 재설정 메일을 `mail` 대기열로 보낼지 물었고, 보내지 않거나 정하지 않았으면 `proposal`이 그대로 선다고 했다. Phase 7로 넘기는 기록이 확인된 것은 (d)뿐이라는 것도 말했다.
  4. 사용자가 「권고안대로」라고 답해 그 문자열을 자기 답으로 삼았다.
- 이 답은 사용자가 권고 없이 낸 답이 아니고, 오케스트레이터나 실행자가 고른 것도 아니다. 사용자가 권고를 듣고 받아들인 답이다. 이 SUMMARY를 쓴 실행자는 답과 과정을 오케스트레이터가 전한 글로 받았고 사용자와 직접 주고받지 않았다.
- 사용자는 `mail` 물음에 따로 답하지 않았다. 그래서 (a)는 고친 데 없는 `proposal`이다.
- **계획 prohibition 판정에 쓸 사실 (judgment 항목):** 계획은 계획자·실행자가 열린 선택지를 고르지 않는다고 정했고 Task 3 action은 「어느 것도 대신 고르지 않는다」고 적는다. 실행자는 고르거나 권하지 않았다. 권고는 사용자가 물어서 오케스트레이터가 한 것이다. 구간 `## 06-03 결정`의 `INSTALL_ID=keep-out`도 같은 과정이었다. 이 과정이 prohibition에 맞는지는 검증자와 사용자가 판단한다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - 계획 안 셈 규칙 불일치] 대상 행 수를 32가 아니라 33으로 셈**
- **Found during:** Task 1 (첫 실행자 세션)
- **Issue:** Task 1 action 1번의 셈 규칙(구간 G 전체, 구간 E 가운데 G에 없는 행, 구간 H의 보존 기간 행)만 따르면 32행이다. 같은 action 2번의 「표 밖」 목록은 구간 C의 기기 안 원시 GPS 로그도 대조표에 두라고 짚는다. 그 행을 표에만 넣으면 `TABLE_SOURCE_ROWS`와 `TABLE_ROWS`가 달라진다.
- **Fix:** 그 한 행(C7)을 목록 쪽 셈과 대조표 양쪽에 함께 셌다. 셈 규칙을 대조표 구간 아래에 적었다(「G·E·H만 세면 32」).
- **Files modified:** `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md`
- **Verification:** Task 1 verify exit 0(두 표식이 같고 18 이상). `OK table06 source G=17 E=4 H=11 C=1 total=33`
- **Committed in:** 계획 끝 문서 커밋

**2. [Rule 1 - 같은 데이터의 두 번 셈] 구간 H의 보존 값 행 넷(H12·H13·H14·H18)을 「표 밖」으로 둠**
- **Found during:** Task 1 (첫 실행자 세션)
- **Issue:** 계획은 「아래에 없는 행은 결정 필요로 둔다」고 적는다. 그런데 installation ID, App Check 토큰, Google Analytics 보존, Cloud Logging 보존은 구간 G·E의 데이터 행과 구간 H의 보존 값 행에 같은 데이터로 두 번 나온다. 둘 다 「남음」이나 「결정 필요」로 두면 「남음」 행 수가 사이트 표 행 수보다 많아지고, 06-13의 `RETAINED_ROWS`와 06-07의 표 본문 행 수가 어긋난다.
- **Fix:** 사이트 표의 한 행이 될 쪽 하나만 「남음」·「결정 필요」로 두고 짝 행은 「표 밖」으로 두어 어느 행과 같은 데이터인지 적었다. 사용자 결정은 데이터 행 쪽에 걸었다(E4 ← Task 3 (c), E5 ← (f), G15 ← (a)). G14는 Analytics 몫을, H11은 Crashlytics 몫을 나른다.
- **Files modified:** `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md`
- **Verification:** 분류 수 10·5·10·8, 행 id 33개가 모두 다름. 06-13 계획이 「남음」 행 수와 `PERIOD` 줄 수를 다시 센다
- **Committed in:** 계획 끝 문서 커밋

**3. [절차 이탈 - 읽기 범위] 앱 HEAD 이동을 파일 이름으로 다시 잼**
- **Found during:** Task 1 (첫 실행자 세션)
- **Issue:** 06-04 「재계획 보충 규칙」 2번은 앱 HEAD를 읽는 예외를 둘(06-04 Task 1 2번, Task 2 8번)로 한정한다. 첫 실행자가 이 계획에서도 앱 HEAD 해시와 `AW..HEAD`의 파일 이름을 읽었다(앱 로컬 `main` 끝 `a298289b50fa`, `AW` 뒤 26커밋, 삭제 관련 경로 변경 0. 바뀐 파일 이름에 `tools/course-editor/` 아래 12개와 `config/course-editor.*.example.json` 둘이 있음).
- **Fix:** 고치지 않았다. 이미 읽은 것이라 기록에서 지우지 않고 「파일 이름만 읽음, 사실의 근거로 쓰지 않음」이라고 밝혀 두었다. 이 계획의 앱 사실은 모두 `AW`(`92e986c3bb29`) 기준 그대로다. 둘째·셋째 세션은 앱 저장소를 읽지 않았다.
- **Files modified:** `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` (기록 한 줄과 `OK app drift …` 줄)
- **Committed in:** 계획 끝 문서 커밋

---

**Total deviations:** 3 (Rule 3 하나, Rule 1 하나, 절차 이탈 하나)
**Impact on plan:** 범위는 그대로다. 사이트 파일과 데이터 목록을 고치지 않았고 사용자 결정을 대신하지 않았다. 1·2번은 대조표의 셈 방식이라 06-13과 06-07 원고 승인에서 사람이 행을 대조할 때 함께 본다. 3번은 판정에 쓰이지 않았다.

## Issues Encountered

- 오케스트레이터 지시의 「task마다 커밋」과 계획의 「계획 끝 문서 커밋 하나」가 달랐다. 계획을 따랐다(06-04·06-05와 같다). 그래서 두 checkpoint 사이에 Task 1·2의 기록은 커밋되지 않은 채 작업 트리에 있었고, 이어 받은 실행자는 커밋 대신 작업 트리에서 verify를 다시 돌려 확인했다(Task 1 verify exit 0, 표 33행, 분류 수 10·5·10·8, `D33_C7=ga` 1줄).
- 시작 시각 파일이 실제 시작보다 늦게 적혀 있어 Duration은 근삿값이다.
- 답을 받은 날짜는 한국 시각으로 적었다(Task 3 답 2026-11-27). 같은 시각이 UTC로는 2026-11-26이라 frontmatter `completed`는 UTC 날짜다.

## 위협 표 대응

- **T-06-16 (남는 데이터를 빠뜨리거나 기간을 짧게 적음):** 목록 대상 행 수와 대조표 행 수가 같음을 verify가 본다(33 = 33). prod 값이 없는 행은 사용자가 상한 약속 방식으로 정했고, dev 값(7일, 30일)을 prod 사실로 적지 않았다. 06-13이 prod 전제 절에 덧붙인다.
- **T-06-17 (계획자·실행자가 열린 선택지를 고름):** 두 물음 모두 blocking-human checkpoint로 멈췄고 실행자는 고르지 않았다. Task 3에는 오케스트레이터의 권고가 있었다(위 Decisions Made).
- **T-06-46 (지킬 수 없는 공개 코스 삭제 약속):** `D39_PATH=none`. 지원 페이지 `#report`와 FAQ 신고 쌍도 삭제를 약속하지 않음을 읽어 기록했다.
- **T-06-47 (익명 자동 정리 문장이 앱 문서와 어긋난 채 공개됨):** `ga`라 자동 정리 문장이 사이트에 나가지 않는다. 어긋남 자체는 열려 있다.
- **T-06-SC:** 패키지를 설치하지 않았다.

새로 생긴 보안 관련 표면은 없다(문서 기록만 고침).

## 열린 항목 (이 계획을 막지 않음)

- **(가) (d)의 행 수 물음은 닫혔다.** 대조표 구간의 「06-13이 볼 것」(로그의 IP를 표에 넣으면 「남음」 행 수와 사이트 표 행 수가 하나 어긋남)은 답이 `phase7`이라 생기지 않는다.
- **(나) 앱 문서 문장 하나가 데이터 목록에 없다.** 앱 문서 `docs/kit-fork.md` 「익명 자동 정리」 절의 「stg·prod 프로젝트를 만들 때 자동 정리가 꺼져 있는지 보고 켜져 있으면 끈다」는 문장이다. 목록에는 「MVP 동안 자동 정리를 끈 채 둔다고 적음」까지만 있다. 06-13은 새 사실을 더하지 않으므로 이 문장을 목록에 넣을지는 정해지지 않았다.
- **(다) D-26과 앱 문서의 어긋남이 그대로다.** `ga`로 닫은 것은 삭제 안내 문장뿐이다. 사이트 D-26(prod에서 익명 자동 정리를 켬)과 앱 문서(MVP 동안 끔), 데이터 목록 prod 전제 1번은 사용자가 따로 정해야 한다. 둘러보기 계정 자체(Auth 레코드)의 보유 기간은 삭제 안내에 없다.
- **(라) (c)·(e)·(f)의 Phase 7 인계가 없다.** 06-13 계획이 데이터 목록에 「Phase 7 처리방침에서 다룸」을 적는 것은 (d) `phase7` 하나다. (c) `out`은 「표에서 뺌」만 적히고 (e)·(f) `out`은 표시가 붙지 않는다. App Check 토큰, 기기 안 설정, installation ID를 Phase 7 처리방침에서 다루려면 따로 추적해야 하고, 다룰지는 사용자가 정하지 않았다.
- **(마) `proposal`의 전제는 prod에서 지켜야 한다.** prod에서 Firestore PITR, 예약 백업, `mail` 대기열 발송을 켜려면 먼저 남는 데이터 표에 행을 더한다. PITR이나 예약 백업을 켜면 `#location`의 「지체 없이 파기」 문장(DEL-06)도 함께 다시 정한다. prod에서 메일을 `mail` 대기열로 보낼지는 정해지지 않았다. 앱은 인증 메일과 비밀번호 재설정 메일을 `mail` 컬렉션에 쓰므로(Phase 1 결정 기록), prod를 만들 때 이 전제를 먼저 확인해야 한다.

## User Setup Required

None - 이 계획이 요구하는 외부 서비스 설정은 없다. `proposal`이 prod에 요구하는 설정(상한 이하 값, 「켜지 않음」 전제)은 06-13이 데이터 목록 「### prod 전제 (Phase 6 D-42)」 아래에 덧붙이고, 확인은 prod 프로젝트를 만들 때 한다.

## 뒤 계획이 알아야 할 것

- **06-13 (다음 실행 계획. 번호와 실행 순서가 다르다):**
  - precondition의 표식이 모두 있다: `TABLE_ROWS=33`, `D33_C7=ga`, `D33_C8=proposal`, `PUBLIC_COURSE_PERIOD`, `D39_PATH=none`, `APPCHECK_ROW=out`, `AUTHLOG_ROW=phase7`, `DEVICE_SENTENCE=out`, `INSTALL_SENTENCE=out`, `OK anon facts in inventory d7dd8609bcb9`. `D33_C7_SENTENCE` 줄은 없다(`ga`).
  - `proposal`의 행별 문구는 검증 기록에 없다. 유일한 출처는 `06-06-PLAN.md` Task 3 `<context>`의 「- (a) 연구 제안」 줄이다.
  - 대조표는 33행이고 구간 C의 기기 안 원시 GPS 로그 행(C7)이 들어 있다. 확정본도 33행이어야 한다.
  - 지금 「남음」 5행은 Task 3 전에 정해져 있던 행이다. (a)의 상한 약속이 붙는 「결정 필요」 행을 「남음」으로 바꿀지와 그에 따른 `RETAINED_ROWS`는 06-13이 계획대로 정한다. 보존 값 짝 행(H12·H13·H14·H18)은 「표 밖」이므로 같은 데이터를 두 번 세지 않는다.
  - Crashlytics 표기 「90일이 지나면 지우기 시작」을 목록 구간 E·H에 옮기는 일이 남아 있다(지금 목록은 「90일 (공식 문서)」).
- **06-07 (원고):** 공개 코스 행의 기간 칸은 「서비스를 운영하는 동안」 글자 그대로다. 탈퇴한 사람의 공개 코스를 요청으로 지운다는 문장이나 기간을 쓰지 않는다. 표 밖 문장은 둘러보기 문장(`ga`) 하나이고, 기기 안 설정 문장과 installation ID 설명 문장은 넣지 않는다. 둘러보기 문장을 「서버에 아무것도 저장하지 않는다」로 넓혀 쓰지 않는다. App Check 행과 Firebase Authentication 로그 IP 행은 표에 없다.
- **06-11 (확인할 것):** Analytics 「최대 14개월」의 전제(GA4 속성이 360이 아니고 BigQuery 내보내기를 켜지 않음, RESEARCH A7)는 확인되지 않았다. 대조표 G14 행 의존 칸에 적혀 있다.
- **Phase 7 (처리방침):** Firebase Authentication 로그의 IP(공식 문서 「몇 주」)를 다룬다. (c)·(e)·(f)는 위 열린 항목 (라).
- **Phase 8 (약관):** 공개 코스가 탈퇴 뒤에도 「서비스를 운영하는 동안」 남고 지금은 요청으로 지우는 경로가 없다는 사실을 같은 글자로 따른다(D-01).
- **prod 생성·Phase 10:** 위 열린 항목 (다)·(마).

## Next Phase Readiness

- 06-13을 시작할 수 있다. 06-13이 읽는 표식이 모두 검증 기록에 있다.
- 사이트 커밋을 막는 것 가운데 D-33 ①②와 D-39가 사용자 답으로 닫혔다. 남은 것은 그 답을 데이터 목록에 옮기는 06-13과 D-33 ④(스토어 개발자 이름 값, 06-08 Task 2)다.
- 로컬 `main`은 `origin/main`보다 앞서 있고 푸시하지 않았다.

## Self-Check: PASSED

SUMMARY를 쓰기 직전에 돌린 결과다 (2026-11-26T20:19Z). 이 계획의 커밋은 아직 없다(`git rev-list --count 3c5456a72d2a..HEAD`가 0). 이 SUMMARY와 `06-EVIDENCE.md`가 첫 커밋이 된다.

- 파일: `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` `FOUND`(구간 `## 06-06 대조표`, `## 06-06 결정` 각 1개). 이 SUMMARY는 이 Write로 생긴다
- 커밋: 확인할 커밋 해시가 아직 없다. 문서 커밋의 해시는 커밋 뒤 이 구간 아래에 덧붙인다
- Task 1 `<verify>` exit 0 (이어 하기 실행에서 Task 3 답을 적기 전과 뒤에 한 번씩). acceptance: 표 행 33 = `TABLE_SOURCE_ROWS` 33, Crashlytics를 완료 시점 표현으로 적은 줄 0
- Task 2 acceptance: `OK anon facts in inventory d7dd8609bcb9` 1줄, `D33_C7=ga` 1줄, `D33_C7_SENTENCE=` 0줄
- Task 3 acceptance: 표식 일곱이 파일 전체에서 줄 머리부터 각 한 번(정확히 그 값, 끝 공백 0). 06-13 verify의 읽기 식 `s/^D33_C8=(proposal|custom).*$/\1/p`이 `proposal`을 돌려준다
- 계획 `<verification>`: (1) Task 1 verify exit 0, (2) 여덟 표식 줄이 모두 있고 `D33_C7`이 `na`가 아니라 문장 대조는 해당 없음, (3) `git log 3c5456a72d2a..HEAD -- . ':(exclude).planning'` 빈 출력, 작업 트리 사이트 파일이 HEAD와 같음(`OK site-clean 06-06-t3 3c5456a72d2a`), `_data/company.yml`도 HEAD와 같음
- 누출 점검: `06-EVIDENCE.md`에 경로·토큰 꼴 0건, 홈 경로 0건, 임시 폴더 경로 0건, 더한 줄에 이메일 주소 꼴 0건. `vals filled=0 emitted=0 excluded=0`(새 값 없음, 점검 건너뜀)
- check-site: 통과 (작업 트리, jekyll 3.10.0)
- 스텁: 없다(문서 기록만 고침)

---
*Phase: 06-data-deletion-rewrite*
*Completed: 2026-11-26*
