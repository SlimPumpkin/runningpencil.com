---
phase: 06-data-deletion-rewrite
plan: 05
subsystem: docs
tags: [operator-procedure, data-deletion, identity-verification, user-tasks, operator-delete-tool]
status: complete

# Dependency graph
requires:
  - phase: 06-data-deletion-rewrite
    provides: "06-04의 재기준 데이터 목록(REBASE_SHA=aeb6f4461157, 익명 행 정정 d7dd8609bcb9): 구간 G 「운영자 삭제 도구 (메일 요청)」 행, 「### prod 전제 (Phase 6 D-42)」, 구간 C·A의 메뉴 문구와 「내 계정」 화면 항목"
  - phase: 06-data-deletion-rewrite
    provides: "06-04의 앱 사실 기록(APP_HEAD=92e986c3bb29, 탈퇴 정리 실패 로그 이름 cleanup_user_data_failed)과 06-01의 공통 규칙·스크래치 lib.sh"
provides:
  - "운영자 삭제 요청 처리 절차: .planning/baseline/USER-TASKS.md 「## 작업 13 — 삭제 요청 처리 (운영자)」와 한눈에 보기 행 (문서 커밋 OPS_SHA=0cc0e1767353)"
  - "사이트 원고(06-07)가 맞출 운영 문장: 처리 상한 「요청을 받은 날부터 10일 안」(기산점은 받은 날), 첫 답장 영업일 기준 3일 안, 요청 이름 「뱃지와 기록 모두 삭제」(본인 확인 뒤 「지체 없이」), 제공자 연결 고정 구절 「안내에 따라 직접 해제해 주세요」"
  - "06-EVIDENCE.md 구간 `## 06-05 절차서` (OPS_FAILLOG=included, OPS_SHA, 깨끗함 기록 06-05-t1·t2)"
affects: [06-06, 06-13, 06-07, 06-11, phase-10]

# Actuals (#2632)
actuals:
  tokens: 2212     # chars/4 over 실현된 diff (USER-TASKS 커밋 5438자 + 06-EVIDENCE.md 06-05 구간 3413자 = 8851자. SUMMARY 제외)
  tasks: 2
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY를 쓸 때). 절차서 커밋 0cc0e17 하나. SUMMARY·EVIDENCE 커밋과 STATE·ROADMAP 커밋은 그 뒤
plan_head_before: b60d1324544fc49107bbd54b916bca69d64e3daa
plan_head_after: 0cc0e17673536c9aae3f753ae503fabd09255bc8

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "운영 절차서는 도구 실행을 앱 문서로 가리키고(명령 줄을 옮기지 않음) 그 앞뒤의 본인 확인, 범위 고르기, 답장만 다룬다"
    - "완료 판정을 종료 코드 하나에 걸지 않는다: 실제 삭제는 --apply 실행의 종료 코드로, 1시간 뒤 재확인은 dry-run의 개수로 본다"

key-files:
  created:
    - .planning/phases/06-data-deletion-rewrite/06-05-SUMMARY.md
  modified:
    - .planning/baseline/USER-TASKS.md
    - .planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md

key-decisions:
  - "06-05: 운영자 삭제 요청 처리 절차를 USER-TASKS 작업 13으로 남겼다(OPS_SHA 0cc0e1767353). 도구 실행은 앱 문서 docs/operator-delete-tool.md(기준 앱 커밋 92e986c3)를 가리키고 절차서는 본인 확인, 범위 고르기(account·records), 답장만 다룬다. 완료 답장은 --apply 실행의 종료 코드 0과 1시간 뒤 재확인(0이어야 하는 키가 모두 0) 뒤에만 보낸다"
  - "06-05: 탈퇴 정리 실패 로그(cleanup_user_data_failed)를 영업일마다 보고 범위 account로 다시 지우는 일을 절차서에 넣었다(OPS_FAILLOG=included). 탈퇴 정리는 실패하면 로그만 남고 다시 돌지 않는데, Auth가 없는 uid의 남은 데이터를 지울 수 있는 수단이 운영자 도구뿐이다"
  - "06-05: 절차서에 적지 않고 열어 둔 것: 이메일 없는 계정의 uid를 콘솔에서 찾는 방법, 본인 확인 답장이 10일 안에 오지 않을 때의 처리(법률 확인 범위), Meta 삭제 요청 목록의 식별자로 계정을 찾는 방법, 익명(둘러보기) 계정이 보낸 메일 요청"

patterns-established:
  - "운영자가 지킬 수 없는 처리는 절차에 적지 않고 「미확인」이나 열린 항목으로 남긴다 (이메일 없는 계정 찾기, Meta 식별자 조회)"
  - "공개 저장소의 운영 문서에는 본인 확인 질문의 종류만 적고, 질문은 답을 본인만 알 수 있는 값으로 운영자가 고른다"

requirements-completed: []  # 계획 frontmatter는 [DEL-01, DEL-05, DEL-06]. 이 계획은 사이트가 약속할 처리를 받치는 운영 절차서를 쓸 뿐 삭제 안내 본문을 쓰지 않아 요구사항을 닫지 않는다. requirements.ready-ids도 세 ID를 모두 blocked로 돌려준다(뒤 계획이 같은 ID를 가짐). 06-01~06-04 SUMMARY와 같은 처리

coverage:
  - id: D1
    description: "USER-TASKS 작업 13 절과 한눈에 보기 행: 기본 경로 여덟 단계(접수, 요청 종류, 계정 이메일 확인 메일·답장, uid 찾기, dry-run, --apply와 종료 코드 0, 1시간 뒤 재확인, 완료 답장)와 10일 상한·3일 첫 답장·prod 전제 가리킴"
    requirement: "DEL-05"
    verification:
      - kind: other
        ref: "06-05-PLAN.md Task 1 <verify> <automated> (exit 0. tracer 관문에서 두 번, 커밋 뒤 다시 한 번)"
        status: pass
    human_judgment: true
    rationale: "verify는 고정 낱말과 구조만 본다. 절차가 앱 도구 문서와 맞는지(06-VALIDATION Manual 「운영자 절차가 앱 도구 문서와 맞음 (D-43)」), 운영자가 지킬 수 없는 처리를 적지 않았는지(계획 prohibitions의 judgment 항목)는 읽어서 판단해야 한다. 처리 기한 문구는 법률 확인 전 초안이다"
  - id: D2
    description: "작업 13의 보충 단계(대체 본인 확인, 「뱃지와 기록 모두 삭제」 요청, 일부 삭제의 앱 메뉴 안내, 탈퇴 정리 실패 재처리, 제공자 연결 답장 문장, Meta 삭제 요청 확인)와 양식 셋"
    requirement: "DEL-06"
    verification:
      - kind: other
        ref: "06-05-PLAN.md Task 2 <verify> <automated> (exit 0, 두 번. 고정 낱말 열하나, 옛 범위 이름·이메일 주소 꼴 0)"
        status: pass
    human_judgment: true
    rationale: "대체 본인 확인의 두 단계가 사칭을 막기에 충분한지, 답장 양식의 문장이 사이트 본문과 어긋나지 않는지, 절차서에 값(주소·uid·앱 프로젝트 ID·명령 줄)을 옮기지 않았는지(prohibition, judgment)는 사람이 읽어야 한다. 이메일 없는 계정을 찾는 방법과 10일 안에 본인 확인이 끝나지 않는 경우는 열려 있다"
  - id: D3
    description: "절차서 하나만 담은 문서 커밋 0cc0e1767353 (제목과 끝 줄 규칙, 다른 파일 없음, 재기준 커밋 뒤 사이트 파일 커밋 0건)"
    verification:
      - kind: other
        ref: "06-05-PLAN.md Task 2 <verify>의 커밋 범위·메시지 끝 줄 검사와 계획 <verification>의 git log 검사 (exit 0, 빈 출력)"
        status: pass
    human_judgment: false
  - id: D4
    description: "06-EVIDENCE.md 구간 「06-05 절차서」: OPS_FAILLOG=included와 이유, OPS_SHA, 깨끗함 기록 둘, 누출 꼴 0건"
    verification:
      - kind: other
        ref: "06-05-PLAN.md Task 1·2 <verify>의 기록 줄 검사와 계획 <verification>의 기록 누출 검사 (경로·토큰 꼴 0, 홈 경로 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 11min
completed: 2026-11-26
---

# Phase 6 Plan 05: 운영자 삭제 요청 처리 절차 Summary

**메일 삭제 요청을 운영자가 본인 확인 → 앱 도구 dry-run → `--apply`(종료 코드 0) → 1시간 뒤 재확인 → 완료 답장 순서로 10일 안에 처리하는 절차를 USER-TASKS 작업 13으로 쓰고, 대체 본인 확인·「뱃지와 기록 모두 삭제」·탈퇴 정리 실패 재처리·Meta 삭제 요청 확인·답장 양식을 더해 문서 커밋 0cc0e1767353으로 남김**

## Performance

- **Duration:** 11 min
- **Started:** 2026-11-26T12:05:48Z
- **Completed:** 2026-11-26T12:17:40Z (두 task와 계획 끝 검증이 끝난 시각. SUMMARY 작성과 기록 커밋은 그 뒤)
- **Tasks:** 2
- **Files modified:** 2 (`USER-TASKS.md`, `06-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- **기본 경로 (Task 1, tracer):** 한눈에 보기 표에 작업 13 행을 더하고, 작업 12와 「변경 전후 dig 명령」 사이에 작업 13 절을 작업 9와 같은 구조로 썼다. 여덟 단계다: 접수(영업일 기준 3일 안 첫 답장) → 요청 종류(범위 `account`·`records`) → 계정 이메일 확인 메일·답장 → uid 찾기 → dry-run → `--apply`와 uid 재입력, 종료 코드 0 확인 → 1시간 뒤 같은 명령으로 재확인 → 완료 답장. 계정 삭제 상한은 「요청을 받은 날부터 10일 안」이고 본인 확인이 늦어도 기산점을 바꾸지 않는다.
- **보충 단계 (Task 2):**
  - 9번 대체 본인 확인: 이메일 없는 계정과 Apple 「이메일 가리기」 주소 계정은 「내 계정」 값(가입 수단·연결된 계정, 표시 이름, 가입일) 대조와 운영자 추가 질문 두 단계가 모두 맞을 때만 지운다.
  - 10번 「뱃지와 기록 모두 삭제」 요청: 같은 본인 확인 뒤 범위 `records`로 「지체 없이」 처리한다. 숫자 상한은 없다.
  - 11번 그 밖의 일부 삭제: 메일로 받지 않고 앱 메뉴(「코스 삭제」, 「뱃지 삭제」·「기록 삭제」, 「데이터 관리」 → 「뱃지와 기록 모두 삭제」, 「올린 사진 삭제」)를 안내한다.
  - 12번 탈퇴 정리 실패 재처리: 영업일마다 `cleanup_user_data_failed` 로그를 보고 그 uid를 범위 `account`로 다시 지운다 (`OPS_FAILLOG=included`).
  - 13번 제공자 쪽 연결 답장 문장, 14번 Meta 사용자 데이터 삭제 요청 확인(21일마다 알림, 파일 60일 보관).
  - 양식 셋: 확인 메일, 계정 삭제 완료 답장, 「뱃지와 기록 모두 삭제」 완료 답장. 실제 값 없이 칸 이름만 있다.
- **옮겨 적지 않은 것:** 지원 이메일 주소, 사업자 값, 개발자 이름, uid, 앱 프로젝트 ID, 앱 문서의 명령 줄. prod 전제는 데이터 목록 「### prod 전제 (Phase 6 D-42)」를 가리키는 한 줄만 두었다.

## Task Commits

1. **Task 1: 작업 13의 기본 경로와 한눈에 보기 행 (tracer)** — 커밋 없음. 계획이 절차서를 Task 2에서 「한 문서 커밋」으로 남기라고 정했고(objective, Task 2 8번), Task 2 verify가 그 커밋이 절차서 하나만 담는지 본다. `OK site-clean 06-05-t1 b60d1324544f`. verify exit 0을 두 번 확인한 뒤(tracer 관문) Task 2로 넘어갔다.
2. **Task 2: 보충 단계와 양식, 절차서 문서 커밋** — `0cc0e1767353` (docs. `.planning/baseline/USER-TASKS.md` 하나, 78줄 더함)

**Plan metadata:** SUMMARY와 `06-EVIDENCE.md`는 계획 끝 문서 커밋 하나로, STATE·ROADMAP 진행표는 그 뒤 커밋으로 들어간다 (06-01~06-04와 같은 순서). 푸시하지 않았다.

## Files Created/Modified

- `.planning/baseline/USER-TASKS.md` — 한눈에 보기 표의 작업 13 행, 새 절 「## 작업 13 — 삭제 요청 처리 (운영자)」(순서 열네 단계, 양식 셋)
- `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` — 구간 `## 06-05 절차서`
- `.planning/phases/06-data-deletion-rewrite/06-05-SUMMARY.md` — 이 문서

## Decisions Made

- 탈퇴 정리 실패 로그 재처리를 절차서에 넣었다(계획 context의 재량 결정을 그대로 따름). 이유는 `06-EVIDENCE.md`의 `OPS_FAILLOG=included` 아래에 있다.
- 완료 판정을 앱 문서의 종료 코드 표에 맞췄다. dry-run은 개수와 상관없이 0으로 끝나므로, 실제 삭제는 `--apply` 실행의 종료 코드로, 1시간 뒤 재확인은 「0이어야 하는 키」의 개수로 본다.
- 범위는 앱 문서 「범위 두 가지」 표의 범위 id로만 맞춘다. 그 표의 「사이트 이름」 칸은 옛 이름이라 절차서에 옮기지 않았고, 운영자에게도 쓰지 말라고 적었다(D-38).
- 절차서의 문체는 기존 문서에 맞춰 「합니다」체로 썼다(계획 action은 「한다」체).
- 이 계획에는 사용자 결정 자리가 없었고 실행자가 대신 고른 선택지도 없다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - 앱 문서와 맞춤] 종료 코드 판정을 `--apply` 실행과 dry-run 개수로 나눠 적음**
- **Found during:** Task 1
- **Issue:** 계획의 6·7번과 「끝났는지 확인」은 「종료 코드 0」을 완료의 기준으로 적는데, 앱 문서 「실행 방법」의 종료 코드 표는 dry-run이 끝난 때도 0이라고 적는다. 글자 그대로 쓰면 1시간 뒤 재확인(dry-run)의 종료 코드 0을 「모두 지워짐」으로 읽을 수 있다.
- **Fix:** 6번과 「끝났는지 확인」은 「`--apply` 실행의 종료 코드」로, 7번은 「종료 코드가 아니라 개수로 판정」으로 적었다. 종료 코드 1은 다시 실행, 그 밖의 코드는 앱 문서의 표를 따른다고 적었다.
- **Files modified:** `.planning/baseline/USER-TASKS.md`
- **Verification:** Task 1 verify exit 0. 앱 문서 `docs/operator-delete-tool.md`(기준 앱 커밋)의 종료 코드 표와 「1시간 뒤 다시 확인」 표를 대조
- **Committed in:** `0cc0e1767353`

**2. [Rule 2 - 운영 안전] 계획 글자에 문장 넷을 더함**
- **Found during:** Task 2
- **Issue:** 위협 표의 mitigate 항목(T-06-13 사칭, T-06-44 부분 실패, T-06-45 탈퇴 정리 실패)을 절차가 실제로 받치려면 운영자가 멈춰야 할 곳이 적혀 있어야 한다.
- **Fix:** (가) 6번: 권한 문제로 실패하면 다시 돌려도 낫지 않으니 「준비」 줄이 가리키는 목록을 확인한다(앱 문서의 권한 계열 안내). (나) 9번: 이 저장소는 공개이므로 질문 종류는 알려져 있다고 보고 답을 본인만 알 수 있는 값으로 고른다. 계정이 하나로 좁혀지지 않으면 지우지 않고 더 묻는다. (다) 12번: 같은 실패가 탈퇴마다 이어지면 같은 목록의 3번을 확인한다. (라) 14번: Meta 목록의 식별자만 보고 지우지 않는다.
- **Files modified:** `.planning/baseline/USER-TASKS.md`
- **Verification:** Task 2 verify exit 0. prod 전제 목록은 여전히 데이터 목록 한곳에만 있고(절차서는 번호로만 가리킴) 다섯 줄을 옮기지 않았다
- **Committed in:** `0cc0e1767353`

**3. [Rule 3 - 문서 구조] 상한 문장을 8번 안으로 옮김**
- **Found during:** Task 2
- **Issue:** Task 1에서는 상한 문장을 번호 목록 아래 따로 둔 문단으로 썼는데, 그대로 두면 9~14번이 새 목록으로 끊긴다.
- **Fix:** 「요청을 받은 날부터 10일 안」 문장과 기산점 문장을 8번 항목 안으로 옮겼다. 글자는 같다.
- **Files modified:** `.planning/baseline/USER-TASKS.md`
- **Committed in:** `0cc0e1767353`

---

**Total deviations:** 3 auto-fixed (Rule 1 하나, Rule 2 하나, Rule 3 하나)
**Impact on plan:** 범위는 그대로다. 사이트 파일을 고치지 않았고 사용자 결정을 대신하지 않았다. 더한 문장은 모두 운영자가 멈추거나 확인할 곳을 적은 것이고 공개 사이트의 약속을 늘리지 않는다.

## Issues Encountered

- 커밋 명령 하나가 임시 메시지 파일을 지우는 줄 때문에 실행 환경의 안전 점검에 막혀 돌지 않았다(아무것도 실행되지 않음). 메시지 파일을 시스템 임시 폴더의 고정 이름으로 쓰고 지우는 줄을 빼서 다시 돌렸다. 그 임시 파일들(verify 사본, 메시지 파일)은 저장소 밖에 남아 있고 값이 들어 있지 않다.
- 오케스트레이터 지시의 「task마다 커밋」과 계획의 「한 문서 커밋」이 달랐다. 계획을 따랐다(Task 1 커밋 없음, 위 Task Commits). 06-04도 같은 방식이었다.

## Threat Flags

| Flag | File | Description |
|------|------|-------------|
| threat_flag: information-disclosure | `.planning/baseline/USER-TASKS.md` | 대체 본인 확인의 추가 질문 예시(최근 기록 날짜, 마지막으로 만든 코스 이름)가 공개 저장소에 있다. D-30은 「운영 문서에만 둔다」고 정했지만 그 운영 문서가 공개 저장소다. 사이트에는 나가지 않는다(`.planning/`은 빌드에서 빠짐). 절차서는 질문 종류가 알려져 있다고 보고 답을 본인만 알 수 있는 값으로 고르라고 적었다. 질문 내용을 저장소 밖으로 옮길지는 사용자가 정할 일이다 |

## 열린 항목 (절차서에 적지 않은 것)

- **이메일 없는 계정의 uid 찾기:** 9번은 「내 계정」 값을 서버 기록과 대조한다고만 적는다. 표시 이름·가입일·가입 수단만으로 콘솔에서 계정을 찾는 구체적인 방법은 계획, D-30, 연구 C-4, 앱 문서 어디에도 없어 적지 않았다. 계정이 하나로 좁혀지지 않으면 지우지 않는다는 규칙만 두었다. 운영을 시작하기 전에 dev에서 한 번 해 보고 절차서에 더하는 것이 좋다.
- **본인 확인이 10일 안에 끝나지 않는 경우:** D-29는 기산점을 「요청을 받은 날」로만 정했고 이 경우를 약속하지 않는다. 절차서도 「답장을 받기 전에는 지우지 않는다」와 「기산점은 바꾸지 않는다」만 적는다. 이때 요청자에게 무엇을 알려야 하는지와 결과 통지 서식은 법률 확인 범위다(RESEARCH A2). 06-07 원고는 이 경우를 약속하는 문장을 쓰지 않는다.
- **Meta 삭제 요청 목록:** 앱 범위 사용자 ID로 uid를 찾는 방법이 앱 도구에 없다(RESEARCH A12, 「미확인」). 절차서는 목록을 확인하되 식별자만으로 지우지 않고 메일과 같은 본인 확인을 거친다고 적었다. 목록의 요청을 그 자체로 처리할 방법은 없다.
- **익명(둘러보기) 계정의 메일 요청:** 절차서에 단계가 없다. 익명 사용자는 「내 계정」 화면에 갈 수 없어 본인 확인에 쓸 값이 없다. 익명 계정 문장(D-33 ①)이 06-06에서 정해지면 다시 본다.
- **추가 질문 「최근 기록 날짜」의 확인 방법:** 운영자 도구는 일부러 경로를 읽지 않지만, 기록 날짜를 보려면 운영자가 기록 문서를 따로 열어야 하고 그 문서에는 GPS 궤적 필드도 있다. 앱 문서는 운영자 경로 열람 기록을 범위 밖 todo로 둔다. 법률 확인 때 함께 볼 항목이다.

## User Setup Required

None - 이 계획이 요구하는 외부 서비스 설정은 없다. prod에서 이 절차를 쓰려면 필요한 준비는 데이터 목록 「prod 전제 (Phase 6 D-42)」의 5번이다(prod 프로젝트를 만들 때의 일).

## 뒤 계획이 알아야 할 것

- **06-07 (원고):** 사이트 문장은 이 절차와 같은 값만 쓴다. 처리 상한 「요청을 받은 날부터 10일 안」, 첫 답장 「영업일 기준 3일 안」, 요청 이름 「뱃지와 기록 모두 삭제」(본인 확인 뒤 「지체 없이」, 계정은 유지), 제공자 연결 고정 구절 「안내에 따라 직접 해제해 주세요」. 메일에 적을 내용은 로그인 방식과 계정 이메일이고, 이메일이 없거나 Apple 「이메일 가리기」 주소인 계정은 「내 계정」 화면 값(가입 수단·연결된 계정, 표시 이름, 가입일)이다. 운영자의 추가 질문 내용은 본문에 쓰지 않는다. 계정 삭제 완료 답장 양식은 「지워진 것과 남는 것은 삭제 안내의 표를 따른다」고 적으므로 본문에 그 표가 있어야 한다.
- **06-06·06-13:** 절차서는 익명(둘러보기) 계정이 보낸 메일 요청을 다루지 않는다. 익명 사용자는 「내 계정」 화면에 갈 수 없어 3번·9번이 쓰는 확인 값이 없다(데이터 목록 구간 A 익명 행). 익명 계정 문장은 D-33 ①(06-06)에서 사용자가 정하고, 그 답에 따라 절차서에 한 줄이 필요한지 본다.
- **Phase 10 (SUP-05):** Apple 발신 도메인을 등록한 뒤 Apple 「이메일 가리기」 주소 계정을 확인 메일 방식으로 돌릴지 정하고, 돌리면 작업 13의 9번을 고친다.
- **앱 문서와의 차이:** 기준 앱 커밋의 `docs/operator-delete-tool.md` 「범위 두 가지」 표는 `records`의 사이트 이름을 옛 이름으로 적는다. 사이트 쪽 이름은 「뱃지와 기록 모두 삭제」다(D-38). 앱 문서를 고치는 것은 앱 저장소의 일이다.

## Next Phase Readiness

- 06-06을 시작할 수 있다. 06-05가 맡은 것(사이트가 약속할 처리 기한·확인 방법·요청 이름을 받치는 운영 절차)은 문서로 남았다.
- 사이트 커밋을 막는 것은 그대로다: D-33의 미결 항목(①②④)과 D-39의 공개 코스 문장은 06-06·06-08의 checkpoint에서 사용자가 정한다.
- 로컬 `main`은 `origin/main`보다 앞서 있고 푸시하지 않았다.

## Self-Check: PASSED

SUMMARY를 쓰기 직전에 돌린 결과다 (2026-11-26T12:17Z).

- 파일: `.planning/baseline/USER-TASKS.md`, `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` 모두 `FOUND`. 이 SUMMARY는 이 Write로 생긴다
- 커밋: `0cc0e1767353`이 HEAD의 조상이고(`git merge-base --is-ancestor`) `.planning/baseline/USER-TASKS.md` 하나만 담는다. 메시지 끝 줄은 `Co-Authored-By: Claude … <noreply@anthropic.com>` 꼴이다
- Task 1 `<verify>` exit 0 (tracer 관문 두 번, 커밋 뒤 한 번), Task 2 `<verify>` exit 0 (두 번)
- acceptance: `grep -c '^## 작업 13 — 삭제 요청 처리 (운영자)'`가 1, 절차서 커밋의 파일 하나, 작업 13에 이메일 주소 꼴 0·옛 범위 이름 0
- 계획 `<verification>`: `REBASE_SHA..OPS_SHA` 사이 사이트 파일 커밋 0건(빈 출력), `06-EVIDENCE.md`에 홈 경로 0건·경로·토큰 꼴 0건
- 누출 점검: 절차서 커밋의 더해진 줄에 경로·토큰 꼴 0건, 홈 경로 0건. `vals filled=0 emitted=0 excluded=0`(새 값 없음, 점검 건너뜀)
- check-site: 통과 (작업 트리, jekyll 3.10.0. 절차서 커밋 직전)

---
*Phase: 06-data-deletion-rewrite*
*Completed: 2026-11-26*
