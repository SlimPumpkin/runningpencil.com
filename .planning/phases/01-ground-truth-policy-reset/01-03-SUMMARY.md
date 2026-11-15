---
phase: 01-ground-truth-policy-reset
plan: 03
subsystem: planning-baseline
tags: [data-inventory, privacy, firestore, firebase-auth, location, base-03]

requires:
  - phase: 01-ground-truth-policy-reset
    provides: "01-01의 기준 문서 폴더(.planning/baseline/)와 이름 표 형식"
provides:
  - "데이터 목록 1부: 머리(기준 앱 커밋 3afb2085, 재확인 규칙, 근거로 삼은 경로 31개, 읽는 법)"
  - "구간 A 계정·프로필 11행, B 로그인 제공자 8행, C 위치·기록·코스·뱃지 6행과 위치를 읽는 세 시점, D 외부로 나가는 요청 6행"
affects: [01-05, 01-08, phase-6-deletion, phase-7-privacy, phase-8-terms]

actuals:
  tokens: 7391
  tasks: 2
  commits: 2
plan_head_before: 6a2639c26139bdf3d08faecb4c7b548d37ec67b8
plan_head_after: faa09f3f432bd8ab180994ce6500b9480a438b68

tech-stack:
  added: []
  patterns:
    - "데이터 목록 본표 열 10개(항목~근거), 근거는 백틱 경로:행"
    - "값 어휘로 같은 사실을 같은 문구로 적음 (리전 칸에 근거 종류 필수)"

key-files:
  created:
    - .planning/baseline/DATA-INVENTORY.md
  modified: []

key-decisions:
  - "Storage 행의 국외 이전 칸은 값 어휘의 「dev는 서울 리전」 대신 「dev 버킷 위치도 미확인, CLI 미확인」으로 적음 (Storage 버킷 위치는 확인되지 않음)"
  - "익명 계정 행의 삭제 방식은 「미확인」 (익명 사용자에게 탈퇴 메뉴가 보이는지 확인하지 못함, 결정 목록 N3)"
  - "users/{uid} 문서 필드의 보유 기간은 「탈퇴까지」 (클라이언트 삭제 금지, firestore.rules:395), 사진 URL·Storage 사진만 「탈퇴 또는 본인 삭제까지」"
  - "네이버 프로필 근거는 RESEARCH의 249-264행 대신 기준 커밋에서 다시 찾은 37행(API 주소)과 260-265행(반환 필드)"

patterns-established:
  - "근거 경로는 모두 「근거로 삼은 경로」 목록에 있고 기준 커밋에 실제로 있어야 함 (verify 4번이 확인)"

requirements-completed: [BASE-03]

coverage:
  - id: D1
    description: "데이터 목록 머리: 기준 앱 커밋 3afb2085, git diff 재확인 규칙, 근거로 삼은 경로 31개, 읽는 법"
    requirement: BASE-03
    verification:
      - kind: other
        ref: "01-03-PLAN.md Task 1 verify 1번 (grep 3afb2085, git diff, 구간 제목, config/dev.json)"
        status: pass
      - kind: other
        ref: "01-03-PLAN.md Task 2 verify 5번 (paths=31, 기준 커밋 존재와 목록 포함)"
        status: pass
    human_judgment: false
  - id: D2
    description: "구간 A 계정·프로필 11행과 구간 B 로그인 제공자 8행이 열 형식과 근거를 갖춤"
    requirement: BASE-03
    verification:
      - kind: other
        ref: "01-03-PLAN.md Task 1 verify 2번 (rowsA=11, 제공자 8곳)"
        status: pass
      - kind: other
        ref: "01-03-PLAN.md Task 1 verify 3번 (근거 칸, 빈 칸, 미확인 표기)"
        status: pass
    human_judgment: false
  - id: D3
    description: "구간 C 6행과 위치를 읽는 세 시점, 구간 D 6행"
    requirement: BASE-03
    verification:
      - kind: other
        ref: "01-03-PLAN.md Task 2 verify 1~4번"
        status: pass
    human_judgment: false
  - id: D4
    description: "칸 내용이 앱 동작과 맞는지(목적·출처 문구의 정확성), 미확인 표기가 지나치거나 모자라지 않은지"
    requirement: BASE-03
    verification: []
    human_judgment: true
    rationale: "검사 명령은 형식과 경로 존재만 본다. 문구가 법적 문서의 원본으로 맞는지는 사람이 읽어야 한다"
  - id: D5
    description: "공개 저장소 누출 검사 (식별자·비밀·하위 도메인)"
    verification:
      - kind: other
        ref: "01-03-PLAN.md Task 2 verify 6번(문서)과 8번(SUMMARY)"
        status: pass
    human_judgment: false

duration: 7min
completed: 2026-11-15
status: complete
---

# Phase 1 Plan 03: 데이터 목록 1부 (머리, 구간 A~D) Summary

**기준 앱 커밋 `3afb2085`의 파일 근거 31개로 계정·프로필 11행, 로그인 제공자 8행, 위치·기록·코스·뱃지 6행(위치를 읽는 세 시점 포함), 외부 요청 6행을 필드 단위로 적은 데이터 목록 1부**

## Performance

- **Duration:** 7 min
- **Started:** 2026-11-15T05:55:20Z
- **Completed:** 2026-11-15T06:02:34Z
- **Tasks:** 2
- **Files modified:** 1

## Accomplishments

- `.planning/baseline/DATA-INVENTORY.md` 머리: 기준 앱 커밋 `3afb2085`, 재확인 명령(`git diff 3afb2085..HEAD -- <근거로 삼은 경로>`), 추적되지 않는 `config/dev.json`은 직접 다시 연다는 안내, 근거로 삼은 경로 31개, 열·범주 태그·근거 표기·「미확인」「CLI 미확인」의 뜻
- 구간 A: Firebase Auth 레코드, `users/{uid}`의 동의·가입 수단·사진 URL·제공자 연결·이메일 사본, `identity_index`, Storage 프로필 사진, Email/Password, 익명 계정까지 11행
- 구간 B: 카카오, 네이버, LINE, Facebook, Apple, Google, 익명, Email/Password 8행. 소셜 6행의 필수/선택은 「미확인 (제공자 콘솔의 동의항목 설정)」, Google 범위는 「범위 인자 없음. 기본 범위 미확인」
- 구간 C: `runs.path`, `runs` 나머지 필드, `courses`(공개·비공개 모두 탈퇴 뒤 남음, U6), 뱃지, `region`, 기기 안 `active_run.jsonl` 6행과 「위치를 읽는 세 시점」 표. 서버에 저장되는 위치는 기록 중의 궤적뿐이라고 명시
- 구간 D: `snapRoute`, `searchPlaces`, `resolveRegion`, 네이버 지도 SDK, 소셜 연결 끊기, Cloud Logging 6행. 라우터 가림 처리는 글로만 적고 호스트 이름·IP는 적지 않음

## Task Commits

1. **Task 1: 머리와 구간 A, B** - `be4ef0c` (docs)
2. **Task 2: 구간 C, D** - `faa09f3` (docs)

**Plan metadata:** 이 SUMMARY 커밋 (docs: complete plan)

## Files Created/Modified

- `.planning/baseline/DATA-INVENTORY.md` - 데이터 목록 1부 (머리, 재확인 규칙, 근거로 삼은 경로, 읽는 법, 구간 A~D). 01-05가 E~H와 「확인할 것」을 잇는다

## 앱 저장소 상태 (읽기 전용 확인)

| 시점 | HEAD (짧은 해시) | `status --short` 줄 수 |
|---|---|---|
| Task 1 시작 | `3afb2085` | 9 |
| Task 2 끝 | `3afb2085` | 9 |

HEAD가 바뀌지 않았으므로 기준 커밋과 실행 시점 HEAD가 같다. 이 계획은 앱 저장소에 읽기 명령(`git show`, `cat-file`, `rev-parse`, `status`, 설정 파일 두 키 읽기)만 실행했다.

## 근거 행 번호 재확인 (기준 커밋에서 다시 연 결과)

- 구간 A, B: `firestore.rules`(41-50, 54-64, 82-90, 104-110, 290-292, 322, 351, 395, 428), `storage.rules:12-19`, `functions/src/auth/identity_index.ts`(64-92, 1095-1101, 1106-1124), `functions/src/auth/mirror_account_email.ts:71-75`, `functions/src/auth/delete_user_account.ts`(134-141, 211-215, 279, 313-334), 제공자 SDK·토큰 파일, `auth_repository.dart`(305, 368, 477, 658-660, 3954), `docs/kit-fork.md`(411, 445), `config/dev.json:18`을 열어 내용이 맞음을 확인
- 어긋난 것 한 건: RESEARCH의 `functions/src/auth/naver_profile_to_custom_token.ts:249-264`는 기준 커밋에서 248-259행이 id 누락 오류 로그이고 반환 필드는 260-265행, API 주소는 37행이었다. 계획의 규칙대로 구간 A, B의 근거를 모두 다시 열어 확인했고 그 밖에 어긋난 것은 없었다. 네이버 행은 37행과 260-265행으로 적었다
- 익명 행의 「뱃지 쓰기 막힘」 근거로 RESEARCH에 없던 `firestore.rules:428`을 찾아 더했다
- 구간 C, D: `firestore.rules`(138-152, 192-200, 231-257, 269-281, 319-333, 347-353, 426-434), `lib/core/location/location_platform.dart:107-190`(editor 10m 간격, recording만 포그라운드 서비스와 iOS 백그라운드 수신), `android/app/src/main/AndroidManifest.xml:4-8`, `ios/Runner/Info.plist`(104-105, 137-142), `run_log_store.dart`(20, 56-57), `snap_route.ts`(1-22, 535-542), `search_places.ts`(1-33, 790-798), `infra/router/Caddyfile:24-41`, `infra/router/deploy.sh:43`, `pubspec.yaml:78-79`, `lib/l10n/app_ko.arb`(197, 364, 377), `functions/src/index.ts:67-76`을 열어 확인. RESEARCH의 `snap_route.ts:516-542`는 입력 위반 분기와 정상 분기의 로그 두 곳이라 정상 분기 535-542행만 적었고, `search_places.ts:722-796`은 로그 끝이 798행이라 790-798행으로 적었다

## 검사 명령 실행 결과

- Task 1 verify 일곱 명령: 모두 exit 0 (`rowsA=11`, `paths=16`)
- 검사 명령 자체 시험 (RESEARCH A10): `users/{uid}.providerLinkedAt` 행의 근거 칸을 「위와 같음」으로 바꾸자 세 번째 명령이 exit 1로 실패했다. Edit로 되돌린 뒤 일곱 명령을 다시 돌려 모두 exit 0을 확인하고 커밋했다
- Task 2 verify 여덟 명령: 모두 exit 0 (`paths=31`). Task 1 verify 일곱 명령도 Task 2 뒤에 다시 돌려 모두 exit 0
- SUMMARY 누출 검사(Task 2 verify 8번): 이 파일을 쓴 뒤 커밋 전에 다시 돌림

## Decisions Made

- `users/{uid}` 문서의 필드는 클라이언트가 문서를 지울 수 없으므로(`firestore.rules:395`) 보유 기간을 「탈퇴까지」로 적고, 사용자가 null로 지울 수 있는 사진 URL과 Storage 사진만 「탈퇴 또는 본인 삭제까지」로 적었다
- 뱃지는 규칙상 본인 삭제가 허용되지만(`firestore.rules:427`) 앱 화면에 삭제 메뉴가 있는지는 확인하지 않아 「앱 화면의 삭제 메뉴는 미확인」으로 적었다
- 기기 안 `active_run.jsonl`이 비정상 종료 때 얼마나 남는지는 확인하지 않아 「미확인」으로 적었다
- Cloud Logging 행은 확인한 네 함수의 로그 항목만 적고 그 밖의 함수 로그 항목은 「미확인」으로 적었다

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Storage 행 국외 이전 문구를 값 어휘에서 바꿈**
- **Found during:** Task 1
- **Issue:** 값 어휘의 Firestore·Storage·Functions 국외 이전 문구는 「dev는 서울 리전」이라고 적지만, RESEARCH 근거표 H에서 Storage 기본 버킷 위치는 「미확인」이다. 그대로 쓰면 확인하지 않은 값을 확인된 것처럼 적게 된다 (금지 사항 1)
- **Fix:** Storage 프로필 사진 행은 「미확인 (prod 리전에 따름. dev 버킷 위치도 미확인, CLI 미확인. 결정 목록 「prod 리전」)」으로 적었다. 「prod 리전」 문구는 남겨 결정 목록과의 연결은 유지했다
- **Files modified:** `.planning/baseline/DATA-INVENTORY.md`
- **Verification:** Task 1 verify 일곱 명령 exit 0
- **Committed in:** `be4ef0c`

**2. [Rule 1 - Bug] RESEARCH의 어긋난 행 번호를 기준 커밋 기준으로 고침**
- **Found during:** Task 1, Task 2
- **Issue:** 네이버 근거 249-264행이 반환 필드가 아니라 오류 로그를 가리켰다. `snap_route.ts`, `search_places.ts`의 범위도 실제 로그 위치와 조금 달랐다
- **Fix:** 기준 커밋에서 다시 찾은 행(위 「근거 행 번호 재확인」)으로 적었다
- **Files modified:** `.planning/baseline/DATA-INVENTORY.md`
- **Verification:** verify 4번(Task 1), 5번(Task 2) exit 0, 각 행을 `git show 3afb2085:<경로>`로 열어 확인
- **Committed in:** `be4ef0c`, `faa09f3`

---

**Total deviations:** 2 auto-fixed (2 Rule 1)
**Impact on plan:** 둘 다 금지 사항 1(확인하지 않은 값을 확인된 것처럼 적지 않음)과 근거 정확성을 지키기 위한 것. 범위 확장 없음.

## Issues Encountered

- 셸이 zsh라 `set -- $spec` 꼴의 단어 분리가 동작하지 않았다. 행 확인과 검사 명령은 scratchpad의 bash 스크립트로 돌렸다 (계획 산출물과 무관)

## Known Stubs

없음. 「미확인」과 「CLI 미확인」 칸은 의도된 표기이고 01-05의 「확인할 것」 표와 01-08 계획이 이어받는다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 01-05가 같은 파일에 E~H, 「확인할 것」, 문서 전체 검사를 잇는다. 근거로 삼은 경로 목록에 경로를 더하는 형식은 이 계획과 같다
- 01-08이 「CLI 미확인」 칸(Firestore·Storage 위치, 라우터 VM zone, Cloud Logging 보존)을 dev CLI 조회로 채운다
- 결정 목록(01-04)의 「prod 리전」, U5, U6, U8, N3, N4 항목을 이 목록이 가리킨다

---
*Phase: 01-ground-truth-policy-reset*
*Completed: 2026-11-15*

## Self-Check: PASSED

- FOUND: `.planning/baseline/DATA-INVENTORY.md`
- FOUND: `be4ef0c`, `faa09f3` (HEAD의 조상)
- SUMMARY 누출 검사 exit 0
