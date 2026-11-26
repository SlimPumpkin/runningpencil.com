---
phase: 06-data-deletion-rewrite
plan: 13
subsystem: docs
tags: [data-deletion, retention-table, data-inventory, user-decision, prod-preconditions, legal-source]
status: complete

# Dependency graph
requires:
  - phase: 06-data-deletion-rewrite
    provides: "06-06의 대조표(TABLE_ROWS=33, 결정 필요 10행)와 사용자 답 표식(D33_C7=ga, D33_C8=proposal, PUBLIC_COURSE_PERIOD, D39_PATH=none, APPCHECK_ROW=out, AUTHLOG_ROW=phase7, DEVICE_SENTENCE=out, INSTALL_SENTENCE=out)"
  - phase: 06-data-deletion-rewrite
    provides: "06-04의 재기준 데이터 목록(REBASE_SHA=aeb6f4461157, 익명 행 정정 d7dd8609bcb9)과 「### prod 전제 (Phase 6 D-42)」 번호 다섯, COURSE_CREATOR=hidden"
  - phase: 06-data-deletion-rewrite
    provides: "06-05의 운영 절차서(OPS_SHA=0cc0e1767353): 계정 삭제 10일 상한, 「뱃지와 기록 모두 삭제」 지체 없이"
provides:
  - "06-EVIDENCE.md 구간 `## 06-13 대조표 확정`: 33행 확정본(지워짐 10·남음 7·표 밖 16), RETAINED_ROWS=7, DELETED_ITEMS=8, 고정 줄 아홉(PERIOD 7·REASON 1·INUSE 1), PERIOD_OK=9/9"
  - "데이터 목록 문서 커밋 INV_DEC_SHA=a789cf9679ba: 삭제 안내 기간 문구, D-33 ①②·D-39 결정, 표 범위 표시, 처리 기한 메모, prod 전제의 D-33 ② 추가 전제 다섯"
  - "06-EVIDENCE.md 구간 `## 06-13 목록 반영`: check-site 통과 줄, 값 누출 결과, 커밋 내용 재대조 줄"
affects: [06-07, 06-09, 06-11, phase-7, phase-10]

# Actuals (#2632)
actuals:
  tokens: 3691     # chars/4 over 실현된 diff (데이터 목록에 덧붙인 2499자 + 06-EVIDENCE.md에 더한 12266자. SUMMARY 제외)
  tasks: 2
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY를 쓸 때). 데이터 목록 문서 커밋 하나다. 이 SUMMARY와 06-EVIDENCE.md의 문서 커밋, STATE·ROADMAP 커밋은 그 뒤
plan_head_before: 5f4f8af3aed00794e6c224005b07a80700e89301
plan_head_after: a789cf9679ba33609de7d364c8b179a741c424c4

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "법적 본문이 쓸 문구는 원고보다 먼저 데이터 목록 행에 적고, 고정 줄(`PERIOD`·`REASON`·`INUSE <행 낱말>|<문구>`)과 목록의 같은 줄 대조로 확인한다. 작업 트리에서 한 번, 커밋 내용으로 한 번"
    - "결정을 목록에 옮길 때는 원래 글자를 지우지 않고 서술 칸 끝에 덧붙인다. 글자 단위 차이에서 지워진 덩어리가 0인지와 표 칸 수가 그대로인지를 커밋 전에 본다"
    - "prod에서 지켜야 참인 약속은 데이터 목록 「### prod 전제 (Phase 6 D-42)」 절 한곳에만 둔다(번호 다섯 + D-33 ② 추가 전제)"

key-files:
  created:
    - .planning/phases/06-data-deletion-rewrite/06-13-SUMMARY.md
  modified:
    - .planning/baseline/DATA-INVENTORY.md
    - .planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md

key-decisions:
  - "06-13: 06-06 대조표의 「결정 필요」 10행을 사용자 답대로 확정했다. 지워짐 10·남음 7·표 밖 16이고 행 수는 33 그대로다(RETAINED_ROWS=7, DELETED_ITEMS=8). 새 「남음」은 Cloud Functions 로그(「최대 30일」)와 지운 프로필 사진의 소프트 삭제 사본(「삭제 뒤 최대 7일」)이고 둘 다 D33_C8=proposal의 상한 약속이다. 이 계획은 새로 정한 것이 없다"
  - "06-13: 삭제 안내가 쓸 기간 문구 일곱(서비스를 운영하는 동안, 7일 안, 최대 14개월, 90일이 지나면 지우기 시작, 삭제 뒤 180일 안, 삭제 뒤 최대 7일, 최대 30일)과 공개 코스의 남는 이유, 확인자료 「6개월」을 고정 줄 아홉으로 남겼고, 데이터 목록 문서 커밋 a789cf9679ba(INV_DEC_SHA)에서 모두 행 낱말과 같은 줄에 있다. 푸시하지 않았다"
  - "06-13: prod에서 지켜야 하는 D-33 ② 약속 다섯을 데이터 목록 「prod 전제 (Phase 6 D-42)」 번호 다섯 아래에 덧붙였다: Storage 소프트 삭제 기본값 7일, 기본 로그 버킷 보존 30일 이하, fcmTokens expireAt TTL 켜기, Firestore PITR·예약 백업 없음, mail 대기열 발송 없음. prod에서 메일을 mail 대기열로 보낼지는 여전히 정해지지 않았다"
  - "06-13: 표 범위 표시는 App Check 두 행(표에서 뺌)과 Firebase Authentication 보존 행(로그의 IP는 Phase 7 처리방침)에 적었다. 기기 안 설정 행과 Remote Config 행에는 표시가 없다(DEVICE_SENTENCE=out, INSTALL_SENTENCE=out). 둘러보기 문장의 근거 표시는 구간 A 익명 행에 있다(D33_C7=ga)"

patterns-established:
  - "계획이 「행 끝」이라고만 적은 덧붙임은 근거(인용) 칸이 아니라 그 행의 마지막 서술 칸 끝에 둔다(H 표는 값 칸, G 표는 처리 칸, 열 칸짜리 표는 보유 기간이나 삭제 방식 칸)"
  - "고정 줄의 행 낱말은 대조표의 「남음」 행과 같은 목록 행의 첫 칸 글자로 고른다(행 낱말에 백틱이 들어갈 수 있다)"

requirements-completed: []  # 계획 frontmatter는 [DEL-03, DEL-05, DEL-06]. 이 계획은 삭제 안내 본문을 쓰지 않고 본문이 쓸 사실을 데이터 목록에 먼저 넣을 뿐이라 요구사항을 닫지 않는다. requirements.ready-ids도 셋 모두 blocked로 돌려준다(뒤 계획이 같은 ID를 가짐). 06-01~06-06 SUMMARY와 같은 처리

coverage:
  - id: D1
    description: "06-06 대조표 33행의 확정본: 「결정 필요」 10행을 사용자 답 표식대로 「남음」 2·「표 밖」 8로 바꾸고 행은 그대로 둠. RETAINED_ROWS=7, DELETED_ITEMS=8"
    requirement: "DEL-03"
    verification:
      - kind: other
        ref: "06-13-PLAN.md Task 1 <verify> <automated> (bash 임시 파일, exit 0. tracer 관문에서 두 번, Task 2 뒤 한 번)"
        status: pass
      - kind: other
        ref: "두 표의 첫 칸 33줄이 순서까지 같고 분류가 바뀐 행이 정확히 10줄임을 awk로 비교 (OK table13 ids same-as-06-06 33/33, classes deleted=10 retained=7 out=16 undecided=0)"
        status: pass
    human_judgment: true
    rationale: "verify는 행 수와 고정 낱말만 본다. 각 행의 새 분류가 사용자 답(특히 proposal의 행별 문구)을 옳게 옮긴 것인지, 남는 데이터 표가 5행에서 7행으로 늘어난 것을 그대로 둘지는 사람이 읽어야 한다(06-VALIDATION Manual 「남는 데이터 표가 재기준 데이터 목록과 일치」). 06-07 원고 승인에서 표와 함께 다시 보게 된다"
  - id: D2
    description: "원고가 쓸 문구의 고정 줄 아홉(PERIOD 7, REASON 1, INUSE 1)과 데이터 목록의 같은 줄 대조"
    requirement: "DEL-03"
    verification:
      - kind: other
        ref: "작업 트리 대조 PERIOD_OK=9/9, 커밋 내용 대조 OK commit periods 9/9 a789cf9679ba (Task 2 <verify>의 같은 줄 반복문이 exit 0)"
        status: pass
    human_judgment: true
    rationale: "같은 줄에 글자가 있는지는 자동으로 봤다. 문구가 결정과 공식 문서 표현 그대로인지, 「남는 이유」 칸이 목록과 맞는지는 계획이 06-07 Task 3의 사람 대조로 넘겼다(계획 assumptions)"
  - id: D3
    description: "데이터 목록 하나만 담은 문서 커밋 a789cf9679ba: 기간 문구, D-33 ② 행별 상한·전제, 표 범위 표시, 둘러보기 문장의 근거 표시, 처리 기한 메모, prod 전제 덧붙임, 반영 메모"
    requirement: "DEL-05"
    verification:
      - kind: other
        ref: "06-13-PLAN.md Task 2 <verify> <automated> (bash 임시 파일, exit 0): 커밋 파일 하나, 기준 앱 커밋 줄과 prod 전제 번호 다섯 줄이 REBASE_SHA와 같음, 처리 기한 한 줄, 추가 전제 문단, 트레일러"
        status: pass
      - kind: other
        ref: "덧붙이기만 했는지: git diff --word-diff=porcelain --word-diff-regex=. 의 지워진 덩어리 0, 표 행 칸 수 분포가 HEAD와 같음"
        status: pass
    human_judgment: true
    rationale: "계획 prohibition 셋(결정에 없는 값을 적지 않음, 06-04 문장과 번호 목록을 바꾸지 않음, 사업자 값을 적지 않음)의 판정 방식이 judgment다. 계획에 고정 문장이 없던 `fcmTokens` 갈래의 문장과 prod 추가 전제 다섯의 글이 결정 범위 안인지는 사용자가 읽어야 한다. 보존 고지는 심사 제출물이다(06-06 Task 3 reversibility costly)"
  - id: D4
    description: "사이트 파일을 고친 커밋 없음, 기록에 경로·토큰 꼴과 홈 경로 0건, 값 누출 점검 건너뜀(새 값 없음)"
    verification:
      - kind: other
        ref: "계획 <verification>: `git log aeb6f4461157..a789cf9679ba -- . ':(exclude).planning'` 빈 출력, `OK site-clean 06-13-t1`·`06-13-t2` 줄, 06-EVIDENCE.md의 LPX grep 0건(종료 코드 1)·홈 경로 0건, check-site 통과(작업 트리), vals filled=0 emitted=0"
        status: pass
    human_judgment: false

# Metrics
duration: 15min
completed: 2026-11-26
---

# Phase 6 Plan 13: 대조표 확정과 남는 데이터 결정의 데이터 목록 반영 Summary

**06-06 대조표의 「결정 필요」 10행을 사용자 답대로 확정하고(지워짐 10·남음 7·표 밖 16), 삭제 안내가 쓸 기간 문구 아홉 줄과 D-33 ①②·D-39 결정, prod 추가 전제 다섯을 원고보다 먼저 데이터 목록 문서 커밋 `a789cf9679ba`에 넣었다**

## Performance

- **Duration:** 15 min
- **Started:** 2026-11-26T21:08:24Z
- **Completed:** 2026-11-26T21:23Z (한국 시각 2026-11-27 06:23. 계획 끝 검증이 끝난 시각. SUMMARY 작성과 커밋은 그 뒤)
- **Tasks:** 2 (tracer 하나, auto 하나. checkpoint 없음)
- **Files modified:** 2 (`DATA-INVENTORY.md` 33줄 더함·20줄 지움, `06-EVIDENCE.md` 132줄 더함) + 이 SUMMARY

## Accomplishments

- **대조표 확정 (Task 1, tracer):** 06-06 대조표 33행에서 「결정 필요」 10행의 분류만 바꿨다. 행을 빼거나 더하지 않았고 첫 칸 33줄이 06-06과 순서까지 같다. `OK table rows = 33`, `RETAINED_ROWS=7`, `DELETED_ITEMS=8`.

| 행 | 06-06 | 확정 | 근거 표식 |
|---|---|---|---|
| G15 Cloud Functions 로그의 uid | 결정 필요 | 남음 (「최대 30일」) | `D33_C8=proposal` 상한 약속 |
| H17 Storage 소프트 삭제 기간 | 결정 필요 | 남음 (「삭제 뒤 최대 7일」) | `D33_C8=proposal` 상한 약속 |
| G13 `mail` 문서 | 결정 필요 | 표 밖 | `D33_C8=proposal` 「켜지 않음」 전제 |
| H15 Firestore PITR, H16 백업 일정 | 결정 필요 | 표 밖 | `D33_C8=proposal` 「켜지 않음」 전제 |
| H4 Firestore TTL 정책 | 결정 필요 | 표 밖 | `D33_C8=proposal` (`fcmTokens`는 「지워짐」, prod에서 TTL 켬) |
| E4 App Check 토큰 | 결정 필요 | 표 밖 | `APPCHECK_ROW=out` |
| E5 Remote Config (installation ID) | 결정 필요 | 표 밖 | `INSTALL_ID=keep-out`, `INSTALL_SENTENCE=out` |
| E6 기기 안 설정 | 결정 필요 | 표 밖 | `DEVICE_SENTENCE=out` |
| H19 익명 계정 자동 정리 | 결정 필요 | 표 밖 (표 밖 문장) | `D33_C7=ga` |

  - 「남음」 7행은 사이트 남는 데이터 표의 7행과 하나씩 맞는다: 공개 코스, 해시 호출 횟수 제한 기록, Analytics, Cloud Functions 로그, Firebase Authentication 백업, Crashlytics, 지운 프로필 사진의 소프트 삭제 사본.
  - 지워지는 데이터 범주는 06-06과 같은 여덟이다. 공개하지 않은 코스와 위치정보 확인자료는 「지워짐」이다.
- **고정 줄 아홉:** `PERIOD` 일곱(공개 코스 「서비스를 운영하는 동안」, 해시 문서 「7일 안」, Analytics 「최대 14개월」, Crashlytics 「90일이 지나면 지우기 시작」, Firebase Authentication 백업 「삭제 뒤 180일 안」, 소프트 삭제 사본 「삭제 뒤 최대 7일」, 로그 「최대 30일」), `REASON` 하나(「만든 사람의 이름·사진을 표시하지 않음」), `INUSE` 하나(확인자료 「6개월」). `D33_C7=ga`라 익명 계정의 `PERIOD` 줄은 없다.
- **목록 반영과 같은 줄 대조:** 고정 줄 아홉 가운데 다섯은 06-04 재기준에 이미 같은 줄로 있었고, 넷(공개 코스, Crashlytics, 소프트 삭제, 로그)은 목록에 덧붙인 뒤 맞았다. 작업 트리에서 `PERIOD_OK=9/9`, 커밋 내용에서 다시 9/9.
- **데이터 목록 문서 커밋 (Task 2):** `a789cf9679ba`가 `.planning/baseline/DATA-INVENTORY.md` 하나만 담는다. 원래 글자는 지우지 않았다(글자 단위 차이에서 지워진 덩어리 0, 표 칸 수 그대로).
  - D-33 ② 행별: 상한 약속 다섯 곳(구간 H Storage 소프트 삭제·Cloud Logging, 구간 G Storage 객체·로그, 구간 D 로그), 「켜지 않음」 전제 다섯 곳(구간 H PITR·백업 일정·TTL 정책의 `mail` 몫, 구간 G·F `mail`), `fcmTokens` 세 곳(구간 G·E `fcmTokens`, 구간 H TTL 정책).
  - 표 범위 표시: 구간 E·H App Check 행(표에서 뺌), 구간 H 「Firebase Authentication 보존」 행(로그의 IP는 Phase 7 처리방침).
  - 둘러보기 문장의 근거 표시: 구간 A 익명 행(확인한 구절 둘이 그대로 있음).
  - 처리 기한 메모: 구간 G 표 아래 한 글머리(계정 삭제 「요청을 받은 날부터 10일 안」, 「뱃지와 기록 모두 삭제」 「지체 없이」).
  - prod 전제 덧붙임: 번호 다섯 줄은 그대로 두고 그 아래 「D-33 ② 결정에 따른 추가 전제 (Phase 6 D-33 ②):」와 글머리 다섯.
  - 반영 메모: 「재확인 규칙」 절에 한 줄.

## Task Commits

1. **Task 1: 대조표 확정과 고정 줄, 목록 덧붙임, 같은 줄 대조 (tracer)** — 커밋 없음. 데이터 목록의 덧붙임은 작업 트리에 두었다가 Task 2 커밋에 들어갔고, 기록은 계획 끝 문서 커밋에 들어간다. `OK site-clean 06-13-t1 5f4f8af3aed0`. verify exit 0을 두 번 확인한 뒤(tracer 관문) Task 2로 넘어갔다.
2. **Task 2: 표 범위 표시·근거 표시·처리 기한·prod 전제 덧붙임과 문서 커밋** — `a789cf9679ba` (docs. 데이터 목록 하나). `OK site-clean 06-13-t2 a789cf9679ba`.

**Plan metadata:** 계획 output이 「SUMMARY와 `06-EVIDENCE.md`는 같은 문서 커밋」으로 정했다. 그 문서 커밋은 `d7450b1f6925`이고, 이 줄의 해시와 Self-Check, STATE·ROADMAP 진행표는 그 뒤 docs 커밋으로 들어간다(06-01~06-06과 같은 순서). 푸시하지 않는다. 이 문서 커밋들은 06-09의 첫 푸시에 함께 나간다.

## Files Created/Modified

- `.planning/baseline/DATA-INVENTORY.md` - 삭제 안내가 쓸 기간 문구와 D-33 ①②·D-39 결정, 표 범위, 처리 기한 메모, prod 추가 전제 다섯, 반영 메모 (커밋 `a789cf9679ba`)
- `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` - 구간 `## 06-13 대조표 확정`(확정본 33행, 표식 둘, 고정 줄 아홉, 대조 줄)과 `## 06-13 목록 반영`(`INV_DEC_SHA`, check-site·누출·재대조 줄)
- `.planning/phases/06-data-deletion-rewrite/06-13-SUMMARY.md` - 이 문서

## Decisions Made

이 계획은 새 결정을 만들지 않는다(계획 truth 4). 아래는 결정을 옮기면서 실행자가 고른 표기 방식이다.

- **고정 줄의 행 낱말:** 대조표의 「남음」 행과 같은 목록 행의 첫 칸 글자로 골랐다(G10·G12·G14·G15·H9·H11·H17). 계획의 예시 `Firebase Crashlytics`(구간 E 행) 대신 대조표 행 H11의 `Crashlytics 보존 기간`을 썼다. 계획이 구간 E와 H 두 행 모두에 문구를 더하게 했으므로 어느 쪽이든 대조는 맞는다. 공개 코스 행 낱말에는 백틱이 들어 있다.
- **「행 끝」의 자리:** 근거(인용) 칸이 아니라 그 행의 서술 칸 끝에 덧붙였다. 인용 목록 뒤에 결정 문장이 붙으면 근거 칸의 뜻이 흐려지기 때문이다. verify는 같은 줄인지만 본다.
- **주어를 붙인 곳:** 공개 코스 기간 문구 앞에 「삭제 안내에 적는」(구간 C는 「삭제 안내에 적는 공개한 코스의」)을 붙여 같은 칸의 dev 사실 문장 「기한 없음」과 구별했다. `mail` 쪽 「켜지 않음」 문장 앞에는 「`mail` 대기열 발송은」을 붙였다. 계획의 고정 구절은 글자 그대로 들어 있다.
- **대조표의 의존 칸:** 06-06에서 이미 나뉘어 있던 23행은 분류를 그대로 두고, 「Task 3에서 정한다」고 적혀 있던 칸(G1·G5·G10·H9·H12·H13·H18)만 답으로 바꿔 적었다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - 계획에 문장이 없는 갈래] `fcmTokens` 행의 덧붙임 문장을 proposal 글자대로 씀**
- **Found during:** Task 1 (목록 반영 3번)
- **Issue:** 계획은 D-33 ② (a)의 대상 행에 `fcmTokens` 행 셋(구간 G·E, 구간 H 「Firestore TTL 정책」)을 들었지만, 고정 문장은 「상한 약속」과 「켜지 않음」 두 가지뿐이다. proposal의 `fcmTokens` 갈래(「지워짐」으로 쓰고 prod에서 `expireAt` TTL을 켬)는 어느 쪽도 아니다.
- **Fix:** `06-06-PLAN.md` Task 3 `<context>` (a) 줄의 글자대로 「삭제 안내에는 「지워짐」으로 씀. prod에서 `fcmTokens.expireAt` TTL 정책을 켬을 전제로 함 (Phase 6 D-33 ②, 사용자 결정)」을 세 행에 적었다. 구간 H 「Firestore TTL 정책」 행은 `fcmTokens`와 `mail`이 함께 있는 행이라 이 문장과 `mail`의 「켜지 않음」 문장을 둘 다 적었다.
- **Files modified:** `.planning/baseline/DATA-INVENTORY.md`
- **Verification:** 세 행 모두 출처 「Phase 6 D-33 ②」가 같은 줄에 있다. 새 값은 없다(문장의 내용은 proposal에 있는 것).
- **Committed in:** `a789cf9679ba`

**2. [Rule 2 - 전제의 조건을 빠뜨리지 않음] prod 추가 전제 글머리에 06-06 기록의 문장 둘을 함께 적음**
- **Found during:** Task 2 (prod 전제 덧붙임 4번)
- **Issue:** 계획은 prod 설정으로 지켜야 하는 것을 글머리로 덧붙이라고만 한다. 06-06 결정 기록에는 그 전제에 딸린 조건 둘이 있다: PITR이나 예약 백업을 켜려면 `#location`의 「지체 없이 파기」 문장(DEL-06)도 함께 다시 정해야 한다는 것, prod에서 메일을 `mail` 대기열로 보낼지는 정해지지 않았다는 것. 이 절은 prod 약속의 유일한 자리라 여기에 없으면 prod를 만들 때 보이지 않는다.
- **Fix:** 해당 글머리 둘에 출처 「06-EVIDENCE 「06-06 결정」」과 함께 적고, 글머리 아래에 이 항목이 어디서 왔고 언제 확인하는지 한 문장을 두었다. 번호 다섯 줄과 절 머리 문장은 바꾸지 않았다.
- **Files modified:** `.planning/baseline/DATA-INVENTORY.md`
- **Verification:** verify의 번호 다섯 줄 비교가 `REBASE_SHA`와 같다. 더한 줄은 `- `나 일반 문장으로 시작한다.
- **Committed in:** `a789cf9679ba`

**3. [계획 우선] 실행자 규약의 task별 커밋 대신 계획의 커밋 구조를 따름**
- **Found during:** Task 1
- **Issue:** 실행자 규약은 task마다 커밋하게 하지만, 계획은 데이터 목록을 「하나만 담은 문서 커밋」 하나로 남기고(Task 2 verify가 그 커밋의 파일이 하나인지 본다) SUMMARY와 `06-EVIDENCE.md`를 계획 끝 문서 커밋에 넣게 한다. 06-01 규칙은 `gsd-tools query commit`도 쓰지 않게 한다.
- **Fix:** Task 1은 커밋하지 않았고 Task 2에서 목록만 커밋했다. 모든 커밋은 메시지 파일로 `git commit -F`했다. 06-05·06-06과 같은 처리다.
- **Verification:** `git diff --name-only a789cf9679ba^ a789cf9679ba`가 한 줄.

**4. [계획 가정과 다른 도구 읽기] 값 누출 점검에 스크래치의 `lib.sh`를 읽음**
- **Found during:** Task 2 (6번)
- **Issue:** 계획 assumptions는 이 계획이 스크래치를 쓰지 않는다고 적지만, 6번의 「값 누출 점검」은 `$W/lib.sh`의 `vals` 함수로 정의돼 있다.
- **Fix:** `lib.sh`를 불러 `vals`만 돌렸다(`filled=0 emitted=0`이라 건너뜀). 스크래치에 산출물을 만들지 않았고 스크래치 재확인도 하지 않았다. verify를 돌린 임시 파일은 `mktemp`로 만들고 지웠다.

---

**Total deviations:** 4 (Rule 3 하나, Rule 2 하나, 계획 우선 하나, 도구 읽기 하나)
**Impact on plan:** 범위는 늘지 않았다. 1·2는 사용자 결정과 06-06 기록에 있는 글자만 옮겼다. 다만 1·2의 문장은 계획이 글자로 준 것이 아니므로 사용자가 한 번 읽어 볼 만하다(아래 「사용자가 읽어 볼 것」).

## Issues Encountered

- 커밋 전 사전 판정 스크립트의 표 칸 수 점검 한 줄이 따옴표 실수로 깨져 `BAD`를 냈다. 내용 문제가 아니라 점검 식의 문제였고, HEAD와 작업 트리의 표 행 칸 수 분포를 직접 비교하는 식으로 다시 돌려 같음을 확인했다. 기록에는 다시 돌린 결과만 적었다.

## 위협 표 대응

| Threat | 처분 | 한 일 |
|---|---|---|
| T-06-36 (목록에 없는 보존 기간을 약속) | mitigate | 고정 줄 아홉을 남기고 `INV_DEC_SHA` 목록에서 줄마다 같은 행에 있음을 Task 2 verify로 다시 봤다. 06-07은 `INV_DEC_SHA`가 있어야 시작한다 |
| T-06-37 (결정에 없는 값, prod 전제 다섯 줄 수정) | mitigate | 값은 06-04·06-06 표식과 `06-06-PLAN.md` (a) 줄에서만 가져왔다. 기준 앱 커밋 줄과 번호 다섯 줄이 재기준과 같음을 verify가 봤고, 덧붙이기만 했음을 글자 단위 차이로 봤다 |
| T-06-38 (사업자 값·지원 주소 누출) | mitigate | 문서 커밋 직전 `vals`(새 값 없음), 더한 줄의 주소 꼴 글자 0. 목록에는 키 이름과 결정 문구만 있다 |
| T-06-SC (패키지 설치) | mitigate | 아무것도 설치하지 않았다 |

새 위협 표면은 없다(사이트 파일과 설정을 고치지 않았다).

## 사용자가 읽어 볼 것 (이 계획을 막지 않음)

- **남는 데이터 표가 다섯 행에서 일곱 행이 됐다.** 더해진 두 행의 기간(로그 「최대 30일」, 소프트 삭제 사본 「삭제 뒤 최대 7일」)은 prod 사실이 아니라 prod가 넘지 않겠다는 약속이다. 심사에 제출되는 보존 고지라 06-07 원고 승인에서 표와 함께 다시 보게 된다.
- **계획이 글자로 주지 않은 문장 둘:** `fcmTokens` 행의 문장(Deviation 1)과 prod 추가 전제 글머리 다섯의 글(Deviation 2). 내용은 `D33_C8=proposal`과 06-06 기록에 있는 것이다.
- **06-06이 열어 둔 채인 것 (이 계획은 닫지 않았다):** prod에서 메일을 `mail` 대기열로 보낼지, App Check 토큰·기기 안 설정·installation ID를 Phase 7 처리방침에서 다룰지(목록에 Phase 7 인계가 적힌 것은 Firebase Authentication 로그 IP 하나), 사이트 D-26과 앱 문서의 익명 자동 정리 어긋남과 prod 전제 1번.
- **덧붙이지 않고 둔 곳:** 계획이 대상으로 들지 않은 줄은 고치지 않았다. 구간 A의 Storage 프로필 사진 행(「소프트 삭제로 7일 보관」), 구간 G 「Analytics·Crashlytics에 붙은 uid」 행과 구간 E 표 아래 메모의 「Crashlytics 90일」, 구간 G 표 아래 메모의 dev 값 문장은 06-04 글자 그대로다. 삭제 안내 표기는 고정 줄의 행에 있다.

## User Setup Required

None - 외부 서비스 설정이 필요하지 않다. prod 프로젝트를 만들 때 볼 것은 데이터 목록 「### prod 전제 (Phase 6 D-42)」 절(번호 다섯과 D-33 ② 추가 전제 다섯)에 있다.

## 뒤 계획이 알아야 할 것

- **06-07 (원고):** 남는 데이터 표 본문은 `RETAINED_ROWS=7`행, 지워지는 데이터 목록은 `DELETED_ITEMS=8`항목이다. 기간 칸은 `## 06-13 대조표 확정`의 `PERIOD` 줄 문구를 글자 그대로 쓴다. 표 행의 이름은 원고가 정한다(확정본의 「사이트 쪽 자리」 칸 이름은 임시다). 표 밖 문장은 `D33_C7=ga`의 한 문장뿐이고(`DEVICE_SENTENCE=out`, `INSTALL_SENTENCE=out`), 「서버에 아무것도 저장하지 않는다」로 넓혀 쓰지 않는다. 고정 줄 수는 9라 `OK draft periods 9/9`가 기대값이다.
- **06-07 verify가 읽는 것:** `INV_DEC_SHA=a789cf9679ba`가 HEAD의 조상이고, 그 목록에 구간 C의 「앱에는 위치정보 동의만 따로 끄는 설정이 없음」 줄이 그대로 있다.
- **06-11 (기준 문서):** 「확인할 것」 표의 추적 행이 가리킬 「### prod 전제 (Phase 6 D-42)」 절에는 이제 번호 다섯과 D-33 ② 추가 전제 다섯이 있다. 다섯 줄을 그 표에 옮겨 적지 않는다.
- **06-09 (첫 푸시):** 이 계획의 문서 커밋들은 푸시하지 않았고 그 푸시에 함께 나간다.
- **Phase 7:** Firebase Authentication 로그의 IP는 구간 H 「Firebase Authentication 보존」 행에 「Phase 7 처리방침에서 다룸」으로 인계돼 있다.

## Next Phase Readiness

- 06-07의 precondition 가운데 이 계획이 만드는 표식(`RETAINED_ROWS`, `DELETED_ITEMS`, `PERIOD_OK`, `INV_DEC_SHA`)이 모두 있고 `INV_DEC_SHA`는 HEAD의 조상이다. 다음 실행 계획은 06-07이다.
- 막는 것은 없다. 열린 항목은 위 「사용자가 읽어 볼 것」에 있다.

## Self-Check: PASSED

문서 커밋 `d7450b1f6925` 뒤에 확인했다.

- FOUND: `.planning/phases/06-data-deletion-rewrite/06-13-SUMMARY.md`
- FOUND: `.planning/baseline/DATA-INVENTORY.md`
- FOUND: `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md`
- FOUND: `a789cf9679ba` (데이터 목록 문서 커밋, HEAD의 조상)
- FOUND: `d7450b1f6925` (기록과 SUMMARY 문서 커밋, HEAD의 조상)
- 커밋된 `06-EVIDENCE.md`에 표식 넷(`RETAINED_ROWS=7`, `DELETED_ITEMS=8`, `PERIOD_OK=9/9`, `INV_DEC_SHA=a789cf9679ba`)이 줄 머리부터 각 한 번 있다.
- Task 1·2 verify를 문서 커밋 전에 다시 돌려 둘 다 exit 0이었다. 계획 `<verification>` 세 항목도 통과했다(재기준 커밋부터 `INV_DEC_SHA`까지 사이트 파일 커밋 0, 기록의 경로·토큰 꼴 0).
- `check evaluation-scope --plan 06-13 --commits-only`가 이 브랜치의 커밋 한 개를 돌려줬다(종료 코드 0).
- 푸시하지 않았다.

---
*Phase: 06-data-deletion-rewrite*
*Completed: 2026-11-26*
