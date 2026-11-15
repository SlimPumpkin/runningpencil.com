---
phase: 01-ground-truth-policy-reset
plan: 08
subsystem: docs
tags: [data-inventory, gcloud, firebase-cli, dev-project, base-03]
status: complete

requires:
  - phase: 01-ground-truth-policy-reset
    provides: "01-03·01-05의 데이터 목록(DATA-INVENTORY.md) 구간 A~H와 「확인할 것」 표, 01-02의 사용자 작업 절차서 작업 11(CLI 재로그인)"
provides:
  - "DATA-INVENTORY.md의 「CLI 미확인」 칸 전부를 dev 프로젝트 읽기 전용 CLI 조회 값(「근거: dev CLI, 2026-11-15 조회」)으로 채움"
  - "DATA-INVENTORY.md의 새 구간 「CLI 조회 기록」 (조회 여덟 건의 결과와 반영한 칸)"
  - "구간 H의 근거 종류 「dev CLI」, 「Firestore PITR」·「Firestore 백업 일정」 두 행으로 나눔"
affects: [phase-06, phase-07]

actuals:
  tokens: 4300
  tasks: 2
  commits: 1
plan_head_before: 7754b089
plan_head_after: dee0d4bf

tech-stack:
  added: []
  patterns:
    - "CLI 조회 값은 데이터 목록에만 적고, 공개 커밋되는 SUMMARY에는 명령 이름과 결과만 적음"
    - "구간 H 근거 칸은 「dev CLI: 명령 이름 (YYYY-MM-DD)」를 백틱 없이 쓰고 기존 앱 저장소 경로 근거는 남김"

key-files:
  created: []
  modified:
    - .planning/baseline/DATA-INVENTORY.md

key-decisions:
  - "dev CLI 조회 여덟 건이 모두 조회함이라 데이터 목록의 「CLI 미확인」 칸을 dev CLI 근거로 채웠다. 값은 dev 값이고 prod 값이 아니므로 결정 목록 「prod 리전」(P1)은 열어 둔다"
  - "구간 H의 기존 앱 저장소 경로 근거(문서 기록)는 지우지 않고 dev CLI 근거를 앞에 더했다. 그 경로만 근거로 삼는 「근거로 삼은 경로」 항목이 고아가 되지 않게 하려는 것이다"

patterns-established:
  - "근거 표기 「근거: dev CLI, YYYY-MM-DD 조회」를 「읽는 법」의 근거 표기 목록에 정의함"

requirements-completed: [BASE-03]

coverage:
  - id: D1
    description: "데이터 목록의 「CLI 조회 기록」 구간(여덟 행, 조회일, 읽기 전용 문장)과 조회함 행이 가리키는 칸의 dev CLI 근거 반영"
    requirement: "BASE-03"
    verification:
      - kind: other
        ref: "01-08-PLAN.md Task 2 verify 1~4 (기록 표 형식, dev CLI 반영, Firestore 칸, 근거 칸·경로)"
        status: pass
    human_judgment: true
    rationale: "조회 값이 dev 프로젝트의 실제 설정과 같은지는 사용자의 콘솔로만 견줄 수 있다 (PLAN human-check, VALIDATION Manual-Only)"
  - id: D2
    description: "데이터 목록과 이 SUMMARY에 식별자(프로젝트 번호, 버킷·VM·함수 이름, IP, 계정 이메일)가 없고 라이브 사이트·앱 저장소가 바뀌지 않음"
    requirement: "BASE-03"
    verification:
      - kind: other
        ref: "01-08-PLAN.md Task 2 verify 5~7 (누출 정규식, 앱 저장소 기준 커밋·라이브 사이트 불변, SUMMARY 누출 검사)"
        status: pass
    human_judgment: false

duration: 9min
completed: 2026-11-15
---

# Phase 1 Plan 08: dev CLI 조회 반영 Summary

**사용자 재로그인 뒤 dev 프로젝트를 읽기 전용 list 명령 여덟 건으로 조회해, 데이터 목록의 「CLI 미확인」 칸(Firestore 위치·PITR·TTL·백업, Storage 버킷 위치·소프트 삭제, 라우터 VM zone, 함수 리전, Cloud Logging 보존, Trigger Email 확장)을 모두 「근거: dev CLI, 2026-11-15 조회」 값으로 채우고 「CLI 조회 기록」 구간을 더함**

## Performance

- **Duration:** 9 min
- **Started:** 2026-11-15T07:37:18Z
- **Completed:** 2026-11-15T07:46:17Z
- **Tasks:** 2 (Task 1 checkpoint 확인, Task 2 조회·반영)
- **Files modified:** 1

## Accomplishments

- Task 1 확인 명령(`gcloud firestore databases list`, 값 출력 꼴)이 재인증 오류 없이 끝났다. 사용자의 재로그인(「done」)이 통했다.
- 허용 조회 여덟 건을 모두 실행했고 결과는 모두 「조회함」이다.
- 데이터 목록의 구간 A~H에서 「CLI 미확인」이 0줄이 됐다. 「확인할 것」 표의 CLI 행 여섯 개에 「확인함 (2026-11-15).」을 붙였다.
- 계획의 「조회한 리전이 다르면 SUMMARY에 눈에 띄게 적는다」 조건에는 해당하지 않는다.

## 실행한 명령과 결과

모두 context의 허용 조회 여덟 건에 속하고 `--project`를 붙였다. `gcloud config set`, 설정 변경·생성·삭제·배포 명령, Firestore 문서·Storage 객체 내용을 읽는 명령은 쓰지 않았다. 다른 자격 증명을 찾지 않았다.

| # | 명령 | 결과 |
|---|---|---|
| 1 | `gcloud firestore databases list` | 조회함 (Task 1 확인 때 한 번, 조회 때 한 번) |
| 2 | `gcloud firestore fields ttls list` | 조회함 (세 번 실행. 아래 이슈 참고) |
| 3 | `gcloud firestore backups schedules list` | 조회함 |
| 4 | `gcloud storage buckets list` | 조회함 |
| 5 | `gcloud compute instances list` | 조회함 (table 출력. json으로 돌리지 않음) |
| 6 | `gcloud functions list` | 조회함 (두 번 실행. 두 번째는 리전 열만 뽑음) |
| 7 | `gcloud logging buckets list` | 조회함 |
| 8 | `firebase ext:list` | 조회함 |

조회한 값은 데이터 목록(`.planning/baseline/DATA-INVENTORY.md`)의 각 칸과 「CLI 조회 기록」 구간에만 있다.

## Task Commits

1. **Task 1: 사용자가 gcloud·firebase CLI에 다시 로그인하거나 건너뛰기를 고른다** — 커밋 없음 (checkpoint:human-action. 파일 변경 없음, 확인 명령만 실행)
2. **Task 2: dev 프로젝트를 읽기 전용으로 조회해 「CLI 미확인」 칸을 채우고 「CLI 조회 기록」을 쓴다** — `dee0d4bf` (docs)

**Plan metadata:** SUMMARY 커밋과 STATE·ROADMAP 반영 커밋은 이 파일 다음에 이어진다.

## Files Created/Modified

- `.planning/baseline/DATA-INVENTORY.md` — 구간 A·C·E·F 본표의 Firestore 저장 위치 열여섯 칸, 구간 A Storage 행, 구간 D `snapRoute`·Cloud Logging 행, 구간 E `fcmTokens` 행, 구간 F `rate_limits`·`mail` 행, 구간 G 여섯 행과 맺음 문장, 구간 H 열한 행(PITR·백업 행 분리 포함)과 맺음 문장, 「읽는 법」의 근거 표기, 「확인할 것」 CLI 행 여섯 개를 고치고 「CLI 조회 기록」 구간을 더함

## Decisions Made

- 구간 H의 「Firestore 백업·PITR」 한 행을 「Firestore PITR」과 「Firestore 백업 일정」 두 행으로 나눴다. 계획이 PITR(조회 1)과 백업(조회 3)을 다른 명령으로 채우게 해서, 행마다 근거 명령이 하나가 되게 했다.
- 구간 H의 Firestore 위치·라우터 VM zone·Trigger Email 행은 기존 앱 저장소 경로 근거를 남기고 dev CLI 근거를 앞에 더했다 (함수 리전 행에 대한 계획 지시와 같은 방식).
- 계획이 이름을 들지 않았지만 같은 사실을 담고 있던 칸(Storage·Cloud Logging 행의 국외 이전, 구간 G의 `fcmTokens`·`mail`·로그 행과 맺음 문장, 구간 H 맺음 문장)도 함께 고쳤다. 고치지 않으면 같은 문서 안에서 「미확인」과 조회 값이 엇갈린다.
- 코드 동작을 적은 문구(「실패하면 TTL에 맡김」 등)는 그대로 두고 옆에 조회 상태를 붙였다. 코드의 의도와 dev 설정의 사실을 섞지 않으려는 것이다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - Blocking] TTL 조회의 출력 형식 재시도 한 번 초과**
- **Found during:** Task 2 (조회 2)
- **Issue:** RESEARCH의 `--format`으로 돌린 `gcloud firestore fields ttls list`가 아무 줄도 내지 않았다. 계획은 필드 이름을 한 번 고쳐 다시 조회하라고 했는데, 고친 형식도 빈 출력이었다. table 형식은 결과가 0건이면 머리글도 찍지 않으므로, 필드 이름 문제인지 0건인지 구분할 수 없었다.
- **Fix:** 같은 허용 명령을 `--format` 없이 한 번 더 돌려 기본 출력의 「0건」 줄을 확인했다. 그래서 「실패 (출력 필드 확인 못 함)」이 아니라 「조회함」(TTL 정책 없음)으로 적었다. 데이터 목록의 「CLI 조회 기록」 아래 메모에도 적었다.
- **Files modified:** `.planning/baseline/DATA-INVENTORY.md`
- **Verification:** 같은 명령의 기본 출력. 허용 목록 밖의 명령은 쓰지 않았다.
- **Committed in:** `dee0d4bf`

**2. [Rule 2 - Missing Critical] 같은 사실을 담은 칸과 「읽는 법」 정의를 함께 고침**
- **Found during:** Task 2
- **Issue:** 계획의 칸 목록 밖에도 「CLI 미확인」, 「TTL 정책 미확인」, 「아직 미확인」 문구가 있었다. 그대로 두면 같은 사실이 한 문서 안에서 엇갈린다. 새 근거 표기 「근거: dev CLI」의 정의도 「읽는 법」에 없었다.
- **Fix:** 해당 칸을 같은 조회 값과 근거 표기로 맞췄다. 「읽는 법」의 근거 표기 목록에 「근거: dev CLI, YYYY-MM-DD 조회」의 뜻을 더했다.
- **Files modified:** `.planning/baseline/DATA-INVENTORY.md`
- **Verification:** 구간 A~H에서 `CLI 미확인` 0줄 (verify 2의 unresolved=0). verify 1~7 exit 0
- **Committed in:** `dee0d4bf`

---

**Total deviations:** 2 auto-fixed (1 blocking, 1 missing critical)
**Impact on plan:** 둘 다 같은 허용 명령과 같은 파일 안에서 끝났다. 범위가 늘지 않았다.

## Issues Encountered

- `firebase ext:list`는 실행할 때 확장 API가 켜져 있는지 확인하는 단계를 거친다 (출력 첫 줄). 출력에 API를 새로 켰다는 줄은 없었다. 확인하려고 다른 명령을 돌리지는 않았다.
- `gcloud storage buckets list`와 `gcloud compute instances list`는 계획의 `--format`대로 이름 열을 뽑았다. 기본 버킷을 가려내려면 이름이 필요했기 때문이다. 이름은 세션 출력에만 있었고 문서·커밋 메시지·이 SUMMARY에는 옮기지 않았다. 문서에는 「기본 버킷」, 「라우터 VM」으로만 썼다.

## Verification

- Task 2 verify 1~7: 모두 exit 0 (rows=8, queried=8, unresolved=0, paths=62 miss 없음).
- 추가 누출 검사: 데이터 목록에서 dev 프로젝트 ID, VM 이름, 프로젝트 번호 일부, 버킷 이름 조각을 grep해 0줄.
- 앱 저장소와 라이브 사이트 파일을 바꾸지 않았다 (verify 6). 푸시하지 않았다.
- SUMMARY 누출 검사(verify 7)는 이 파일을 쓴 뒤 커밋 전에 다시 돌린다.

## User Setup Required

None - 외부 서비스 설정이 더 필요하지 않다. 데이터 목록의 조회 값을 콘솔에서 아는 값과 견주어 보는 일은 PLAN의 human-check로 남는다.

## Next Phase Readiness

- 데이터 목록의 리전·보존 칸에 「CLI 미확인」이 남지 않았다. Phase 6 삭제 안내와 Phase 7 처리방침이 구간 G·H의 dev CLI 값을 읽을 수 있다.
- 값은 모두 dev 값이다. prod 프로젝트를 만든 뒤 같은 조회를 prod에 다시 해야 하며, 결정 목록 「prod 리전」(P1)은 열려 있다.
- 콘솔에서만 보이는 값(Analytics 보관, 동의항목 등)은 여전히 절차서 작업 12에 남아 있다.

## Self-Check: PASSED

- FOUND: `.planning/baseline/DATA-INVENTORY.md` (`## CLI 조회 기록` 있음)
- FOUND: `dee0d4bf` (HEAD의 조상)

---
*Phase: 01-ground-truth-policy-reset*
*Completed: 2026-11-15*
