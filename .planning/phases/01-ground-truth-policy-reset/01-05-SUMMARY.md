---
phase: 01-ground-truth-policy-reset
plan: 05
subsystem: planning-baseline
tags: [data-inventory, privacy, firebase-analytics, crashlytics, fcm, account-deletion, retention, base-03]

requires:
  - phase: 01-ground-truth-policy-reset
    provides: "01-03의 데이터 목록 1부(머리, 구간 A~D, 형식 계약과 값 어휘)"
  - phase: 01-ground-truth-policy-reset
    provides: "01-04의 결정 목록(U6, U8, N1~N6, P1)과 01-02의 사용자 작업 절차서(작업 11, 12)"
provides:
  - "데이터 목록 2부: 구간 E 기기·알림·분석·크래시 7행, 구간 F 서버 보조 컬렉션 2행"
  - "구간 G 탈퇴 때 지워지는 것과 남는 것 13행 (Phase 6 삭제 안내의 원본)"
  - "구간 H 리전·보존 기간 18행과 근거 종류, 「확인할 것」 12행"
  - "근거로 삼은 경로 31개에서 61개로 확장"
affects: [01-08, phase-6-deletion, phase-7-privacy, phase-8-terms]

actuals:
  tokens: 3891
  tasks: 2
  commits: 2
plan_head_before: 91b3c79
plan_head_after: 3122cc2

tech-stack:
  added: []
  patterns:
    - "보조 표 세 종류: 「데이터 | 탈퇴 시 처리 | 근거」, 「대상 | 값 | 근거 종류 | 근거」, 「미확인 칸 | 확인하는 사람 | 확인 방법 | 막는 단계」"
    - "Google SDK 다섯 서비스(Analytics, Crashlytics, FCM, Remote Config, App Check)는 「Google 시설 (위치 선택 불가, 공식 문서)」 어휘로 통일"

key-files:
  created: []
  modified:
    - .planning/baseline/DATA-INVENTORY.md

key-decisions:
  - "구간 G에 계획의 열한 행 말고 mail 문서와 Cloud Functions 로그의 uid 두 행을 더해 열세 행으로 씀. 탈퇴 뒤에도 남는 데이터를 빠짐없이 보이게 하려는 것"
  - "구간 H에 Firestore TTL 정책과 배포된 함수의 실제 리전 행을 더해 「확인할 것」의 CLI 행과 일대일로 맞춤 (18행)"
  - "기기 안 설정 행은 SharedPreferences 키를 기준 커밋에서 모두 찾아 적음. 익명 사용자의 약관 동의 사본(terms.accepted_value)이 기기 안에 있다는 사실을 포함"
  - "mail 행의 항목·출처에 비밀번호 재설정 메일(send_password_reset_mail.ts:310)도 같은 컬렉션에 쓴다는 사실을 더함"
  - "rate_limits는 firestore.rules에 허용 항목이 없어 클라이언트가 접근할 수 없다고 글로만 적고 특정 규칙 줄을 근거로 들지 않음 (해당 줄이 없음)"

patterns-established:
  - "탈퇴 처리 표의 「해당 단계 없음」 근거는 탈퇴 함수 두 파일을 행 번호 없이 적고 괄호로 「해당 호출 없음」을 덧붙임"

requirements-completed: [BASE-03]

coverage:
  - id: D1
    description: "구간 E 7행과 구간 F 2행이 열 열 개 형식, 값 어휘, 기준 커밋 근거를 갖춤"
    requirement: BASE-03
    verification:
      - kind: other
        ref: "01-05-PLAN.md Task 1 verify 1~5번 (E=7 F=2, miss 없음, 근거 칸·빈 칸 검사, paths=58, 누출 검사)"
        status: pass
    human_judgment: false
  - id: D2
    description: "구간 G 13행. 코스 행은 「삭제하지 않음 (공개·비공개 모두)」, 메뉴 이름 「회원탈퇴」, 백업 제거 상한 180일"
    requirement: BASE-03
    verification:
      - kind: other
        ref: "01-05-PLAN.md Task 2 verify 2번 (rowsG=13, courses 행 검사)"
        status: pass
    human_judgment: false
  - id: D3
    description: "구간 H 18행의 근거 종류, Firebase Authentication 미국 운영, prod·stg placeholder 문장"
    requirement: BASE-03
    verification:
      - kind: other
        ref: "01-05-PLAN.md Task 2 verify 3번 (hn=18, bad 없음)"
        status: pass
    human_judgment: false
  - id: D4
    description: "「확인할 것」 12행과 USER-TASKS 연결, 문서 전체 구간 제목·근거 경로·누출 검사"
    requirement: BASE-03
    verification:
      - kind: other
        ref: "01-05-PLAN.md Task 2 verify 1, 4~8번 (rows10=32, rows=12, CLI 미확인 34줄, paths=62, 누출·라이브 사이트 불변)"
        status: pass
    human_judgment: false
  - id: D5
    description: "칸 문구가 앱 동작과 맞는지, 탈퇴 표가 「모두 곧바로 지워진다」로 읽히지 않는지, 미확인 표기가 알맞은지"
    requirement: BASE-03
    verification: []
    human_judgment: true
    rationale: "검사 명령은 형식, 경로 존재, 핵심 낱말만 본다. 법적 문서의 원본으로 문구가 맞는지는 사람이 읽어야 한다"

duration: 10min
completed: 2026-11-15
status: complete
---

# Phase 1 Plan 05: 데이터 목록 2부 (구간 E~H, 확인할 것) Summary

**기준 앱 커밋 `3afb2085`의 근거로 SDK 수집 항목 7행, 서버 보조 컬렉션 2행, 탈퇴 처리 13행(코스는 공개·비공개 모두 남음), 리전·보존 기간 18행, 미확인 칸 12개의 확인 담당을 더해 BASE-03 데이터 목록을 완성**

## Performance

- **Duration:** 10 min
- **Started:** 2026-11-15T06:59:04Z
- **Completed:** 2026-11-15T07:09:00Z
- **Tasks:** 2
- **Files modified:** 1

## Accomplishments

- 구간 E: `fcmTokens`, Firebase Analytics(uid, `guest_mode`, `onboarding_completed`, 화면 조회, 보존 기간은 「미확인 (콘솔 설정값. 선택지는 2개월 또는 14개월)」), Crashlytics(90일), App Check, Remote Config, 기기 안 설정, Facebook SDK 자동 이벤트(「실제 전송 여부 미확인」) 7행과 설명 네 줄
- 구간 F: `rate_limits`(SHA-256 앞 32자, 탈퇴 시 삭제하지 않음), `mail`(「현재 미사용 (dev 기준). prod 설정에 따름」, 확장 TTL 1일) 2행과 dev `emailDelivery` 설명
- 구간 G: 탈퇴 때 지워지는 것 7행과 남는 것 6행. 코스 행은 공개 여부로 나누지 않고 「삭제하지 않음 (공개·비공개 모두)」. 메뉴 이름 「회원탈퇴」, 5분 재로그인, 서비스에서의 삭제와 백업에서의 제거(180일)를 나눠 써야 한다는 문장
- 구간 H: 18행 모두 근거 종류(코드, dev 설정 기록(문서), 공식 문서, 미확인) 기재. Firebase Authentication은 미국 데이터센터에서만 운영. 버킷 이름은 적지 않음. Analytics·Cloud Logging 기본값은 적지 않음
- 「확인할 것」: CLI 6행(Claude, 01-08 계획)과 사용자 6행에 확인 방법과 막는 단계를 짝지음. 작업 11·12(`.planning/baseline/USER-TASKS.md`)와 연결
- 문서 끝에 `NAMES.md`와 같은 꼴의 맺음 줄. 「읽는 법」의 본표 범위를 구간 A, C, D, E, F로 고침

## Task Commits

1. **Task 1: 구간 E, F** - `f84e917` (docs)
2. **Task 2: 구간 G, H, 확인할 것, 맺음 줄** - `3122cc2` (docs)

**Plan metadata:** 이 SUMMARY 커밋 (docs: complete plan)

## Files Created/Modified

- `.planning/baseline/DATA-INVENTORY.md` - 구간 E~H와 「확인할 것」, 맺음 줄을 더해 데이터 목록 완성. 근거로 삼은 경로 61개

## 앱 저장소 상태 (읽기 전용 확인)

| 시점 | HEAD (짧은 해시) | `status --short` 줄 수 |
|---|---|---|
| Task 1 시작 | `3afb2085` | 9 |
| Task 2 끝 | `3afb2085` | 9 |

HEAD가 바뀌지 않았다 (`3afb2085..HEAD` 사이 커밋 0개). 이 계획은 앱 저장소에 읽기 명령(`git show`, `git grep`, `cat-file`, `rev-parse`, `rev-list`, `status`, `merge-base`, `config/dev.json`의 `emailDelivery` 한 키 읽기)만 실행했다.

## 근거 행 번호 재확인 (기준 커밋에서 다시 연 결과)

모든 새 근거를 `git show 3afb2085:<경로>`로 열어 확인했다. RESEARCH 값과 달라 고친 것:

- `firestore.rules:405-417` → `405-416` (417행은 닫는 괄호)
- Analytics의 uid: RESEARCH `auth_guard.dart:593`은 Analytics `setUserId`가 맞고, `guest_mode` 설정이 592행이라 `592-593`으로 적음. Crashlytics `setUserId`는 594행
- `analytics_service.dart:53-57` → `53-56` (`guest_mode` 설정 호출)
- App Check: RESEARCH의 「`bootstrap.dart:120` 부근」 → `lib/core/bootstrap.dart:109-120` (activate 호출). 서버 쪽은 `functions/src/index.ts:36` 말고 실제 탈퇴 함수 `functions/src/auth/delete_user_account.ts:159`도 더함
- Crashlytics: `bootstrap.dart:134-155`는 그대로 맞음 (오류 수집 연결 134-148, `flavor` 키 152-155)
- 기기 안 설정: 행 번호가 없던 `locale_provider.dart` → `:33`, 그 밖의 SharedPreferences 키를 `git grep`으로 찾아 `theme_provider.dart:22`, `onboarding_notifier.dart:45`, `notification_settings_notifier.dart:27`, `:29-37`, `terms_notifier.dart:19-27`, `:39`, 위치·러닝 알림 권한, 따라가기 모드, 길찾기 앱, 공지 키 행 번호를 붙임
- `fcmTokens` 탈퇴 삭제: RESEARCH `delete_user_account.ts:361-380` → 실제 삭제 호출과 실패 처리 `369-380`
- `rate_limits` 사용처로 `functions/src/auth/lookup_sign_in_methods.ts:117-127`을 더함
- 그대로 맞은 것: `fcm_token.dart:17`, `onboarding_screen.dart:166`, `analytics_observer.dart:56-60`, `provider_id.dart:64-65`, `AndroidManifest.xml:50-57`, `Info.plist:79-84`, `rate_limit.ts:4-6`, `client_ip_hash.ts:11-28`, `email_hash.ts:22-27`, `send_verification_mail.ts:190`, `firestore-send-email.env:6-8`, `app_config.dart:232-239`, `config/dev.json:19`, `delete_user_account.ts:171-191`, `cleanup_user_data.ts:17-21`·`42-56`·`64-69`, `app_ko.arb:349`·`364`·`377`, `kit-fork.md:411`·`445`·`460`, `on_course_written.ts:23`, `deploy.sh:43`, `RUNBOOK.md:68`, `guide.md:2188`, `firebase_options_prod.dart:2`, `firebase_options_stg.dart:2`

## Decisions Made

- 구간 G를 열세 행으로 씀 (`mail`, Cloud Functions 로그 행 추가). 금지 사항 「탈퇴하면 모든 데이터가 곧바로 지워진다고 읽히게 적지 않는다」를 지키려고 남는 데이터를 모두 보이게 했다
- 구간 H를 열여덟 행으로 씀 (Firestore TTL, 배포된 함수 리전 행 추가). 「확인할 것」의 CLI 행마다 H에 대응하는 미확인 칸이 있게 했다
- 기기 안 설정 행에 SharedPreferences 키를 모두 적음. 익명 사용자의 약관 동의 사본이 기기 안에 있다는 사실이 처리방침에 필요하다

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 2 - Missing Critical] `mail` 행에 비밀번호 재설정 메일 추가**
- **Found during:** Task 1
- **Issue:** RESEARCH는 `mail` 컬렉션을 인증 메일만으로 적었지만 기준 커밋의 `functions/src/email/send_password_reset_mail.ts:310`도 같은 컬렉션에 쓴다
- **Fix:** 항목·출처 칸과 근거에 비밀번호 재설정 메일을 더함
- **Files modified:** `.planning/baseline/DATA-INVENTORY.md`
- **Verification:** Task 1 verify 4번 (경로가 기준 커밋과 목록에 있음)
- **Committed in:** `f84e917`

**2. [Rule 2 - Missing Critical] 구간 G에 남는 데이터 두 행, 구간 H에 미확인 두 행 추가**
- **Found during:** Task 2
- **Issue:** RESEARCH 근거표 G에는 `mail` 문서와 Cloud Functions 로그의 uid가 없어 탈퇴 뒤에도 남는 데이터가 빠졌고, 근거표 H에는 「확인할 것」의 TTL·함수 리전 행에 대응하는 칸이 없었다
- **Fix:** G에 두 행(13행), H에 두 행(18행)을 더함. 모두 「미확인」 또는 「CLI 미확인」으로 표시
- **Files modified:** `.planning/baseline/DATA-INVENTORY.md`
- **Verification:** Task 2 verify 2, 3번 (rowsG=13, hn=18, 근거 종류 검사 통과)
- **Committed in:** `3122cc2`

**3. [Rule 1 - Bug] RESEARCH 근거 행 번호 바로잡기**
- **Found during:** Task 1, Task 2
- **Issue:** RESEARCH의 「부근」 표기와 범위가 기준 커밋과 어긋난 곳이 있었다 (위 「근거 행 번호 재확인」)
- **Fix:** 기준 커밋에서 연 행 번호로 적음
- **Committed in:** `f84e917`, `3122cc2`

---

**Total deviations:** 3 auto-fixed (Rule 2 두 건, Rule 1 한 건)
**Impact on plan:** 모두 사실 정확성을 위한 것이다. 범위 밖 변경 없음

## Issues Encountered

None

## Known Stubs

없음. 「미확인」·「CLI 미확인」 칸은 자리표시가 아니라 확인하지 못했다는 사실 표기이고, 모두 「확인할 것」 표에 확인 담당이 있다.

## User Setup Required

None - 이 계획에서 새로 생긴 사용자 작업은 없다. 「확인할 것」의 사용자 몫은 기존 절차서 작업 11, 12에 있다.

## Next Phase Readiness

- 데이터 목록(BASE-03)이 완성됐다. Phase 6은 구간 G, Phase 7은 구간 A~F와 H, Phase 8은 구간 C와 D를 원본으로 쓴다
- 01-08 계획: 사용자가 작업 11(CLI 재로그인)을 마치면 「확인할 것」의 CLI 6행을 채우고 구간 H의 근거 종류에 「dev CLI」를 더한다. 하지 않으면 「CLI 미확인」으로 남는다
- 01-07 계획이 이 뒤에 같은 작업 트리에서 이어진다

---
*Phase: 01-ground-truth-policy-reset*
*Completed: 2026-11-15*

## Self-Check: PASSED

- `.planning/baseline/DATA-INVENTORY.md` 있음, 커밋 `f84e917`, `3122cc2` 모두 HEAD의 조상
- Task 1 verify 5개, Task 2 verify 8개 모두 exit 0, SUMMARY 누출 검사 exit 0
