---
phase: 06-data-deletion-rewrite
plan: 03
subsystem: docs
tags: [app-work-gate, checkpoint, operator-delete-tool, location-use-records, rate-limits, u2]
status: complete

# Dependency graph
requires:
  - phase: 06-data-deletion-rewrite
    provides: "06-02의 DEC_SHA=ef3e0073b7b2(결정 목록·ROADMAP 게이트 기록)와 기준 시점 오류를 고친 데이터 목록"
provides:
  - "앱 작업 요청서: 06-EVIDENCE.md `## 06-03 앱 작업 요청`(APP_PRE=bfabc3a45d5d, 항목 ①②③⑤⑥과 조건부 ⑦의 참이어야 할 사실 표, U2 결론 요청)"
  - "installation ID 결정: INSTALL_ID=keep-out (조건부 ⑦은 요청에 들지 않음)"
  - "앱 작업 보고 표식: APP_WORK_HEAD=92e986c3bb29, APP_ITEM_1·2·3·5·6(파일 18개), U2_STATUS=draft와 U2_PROCEED=user-accepted-draft, DEL06_REPORT=conform, APP_WORK=reported"
  - "중간 보고 구간 다섯(⑤·②·①·⑥·③)과 `## 06-03 관문 조건`: 앱 쪽 보고와 읽기 전용 탐침, 뒤 계획(06-04~07)이 맞춰야 할 것 목록"
affects: [06-04, 06-05, 06-06, 06-07, 06-13]

# Actuals (#2632)
actuals:
  tokens: 8431     # chars/4 over 더한 줄 (06-EVIDENCE.md의 06-03 구간 전부, 33726자. SUMMARY 제외)
  tasks: 3
  commits: 15      # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). 이 가운데 06-03 커밋은 아홉(bb662e6, c381acb, 277c0d1, ed10d3a, 8c281b0, 695d043, c5f7a92, 0addc01, 45e9a6a)이고 나머지 여섯은 대기 중에 들어온 다른 문서 커밋. EVIDENCE Task 3 구간과 이 SUMMARY는 바로 뒤 docs 커밋
plan_head_before: 2bdedf391e750aa4049d13c79556c30a556b6acb
plan_head_after: 45e9a6add036aa20b276e7702e663575bc1d9f20

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "관문이 열리기 전에 들어온 앱 쪽 보고는 Task 3 표식 없이 별도 구간(`## 06-03 중간 보고 <항목>`, 표식 `MID<n>_SEEN`, 탐침 줄 머리 `mid<n>`)으로 적는다. 뒤 계획의 verify가 줄 머리 표식을 파일 전체에서 읽기 때문이다"
    - "보고받은 것과 이 세션이 읽기 전용으로 본 것을 나눠 적고, 판정은 06-04로 넘긴다"

key-files:
  created:
    - .planning/phases/06-data-deletion-rewrite/06-03-SUMMARY.md
  modified:
    - .planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md
    - .planning/notes/2026-11-21-admin-tool-design.md
    - .planning/STATE.md

key-decisions:
  - "Firebase installation ID는 남는 데이터 표에서 뺀다(INSTALL_ID=keep-out, 사용자, 2026-11-20). 조건부 항목 ⑦은 앱 작업 요청에 들지 않는다"
  - "06-03 Task 3의 보고 조건을 「①②③⑤⑥이 들어간 앱 커밋, ③은 서버 함수와 명령」으로 좁혔다(사용자, 2026-11-26). 관리 화면은 뺐다. 2026-11-21 결정(관리도구까지 다 만든 뒤 보고)을 대체한다"
  - "기준 앱 커밋은 92e986c3bb29다(사용자, 2026-11-26. 받은 때 앱 로컬 main의 끝)"
  - "U2(위치기반서비스사업, 제9조 신고 대상)는 법률 확인 전 초안이고, 사용자가 초안으로 Phase 6을 진행하기로 했다(draft-proceed, 2026-11-26)"
  - "⑥ 파기 답은 세 경로 모두 conform이다(사용자, 2026-11-26. 운영자 도구가 들어온 뒤 다시 받음)"

patterns-established:
  - "앱 작업 보고는 「받은 그대로」 적고, 항목이 참인지는 다음 계획이 보고된 커밋의 코드로 정한다"

requirements-completed: []  # 계획 frontmatter는 [DEL-03, DEL-05, DEL-06]. 이 계획은 관문이고 성공 기준을 닫지 않는다. requirements.ready-ids도 세 ID를 blocked로 돌려준다(뒤 계획이 같은 ID를 가짐). 06-01·06-02 SUMMARY와 같은 처리

coverage:
  - id: D1
    description: "앱 작업 요청서(항목 ①②③⑤⑥과 조건부 ⑦의 참이어야 할 사실, U2 결론 요청)와 앱 작업 전 탐침 APP_PRE를 06-EVIDENCE.md에 기록"
    requirement: "DEL-03"
    verification:
      - kind: command
        ref: "06-03-PLAN.md Task 1 <verify> (exit 0, 계획 끝에 다시 실행해도 exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "installation ID 처리를 앱 작업 전에 사용자가 골라 INSTALL_ID=keep-out으로 기록"
    requirement: "DEL-03"
    verification:
      - kind: command
        ref: "grep -c -E '^INSTALL_ID=(keep-out|app-delete)$' 06-EVIDENCE.md (1)"
        status: pass
    human_judgment: false
  - id: D3
    description: "앱 작업 보고(기준 앱 커밋, 항목별 경로, ③ 실행 방법이 적힌 곳, U2 결론과 초안 진행 답, ⑥ 파기 답)를 `## 06-03 앱 작업 보고`에 표식으로 기록"
    requirement: "DEL-06"
    verification:
      - kind: command
        ref: "표식 열한 개가 각각 한 줄(grep -c '^이름='), 06-04 Task 1이 쓰는 식(sed·grep -qx)으로 읽힘, 경로 18개가 92e986c3bb29에 있고 3afb2085 이후 차이에 있음"
        status: pass
    human_judgment: false
  - id: D4
    description: "보고된 앱 작업이 요청서의 사실을 실제로 참으로 만드는지(특히 세 경로의 지체 없는 파기)"
    requirement: "DEL-06"
    human_judgment: true
    rationale: "이 계획은 받은 답을 기록할 뿐이다. 참인지는 06-04 Task 1이 앱 코드에서 읽어 판정한다(계획 prohibition: 「끝났다」는 말만으로 끝난 것으로 기록하지 않는다)"
---

# Phase 6 Plan 03: 앱 작업 게이트 — 요청서, installation ID 결정, 앱 작업 보고 Summary

**앱 작업 ①②③⑤⑥이 앱 커밋 92e986c3bb29에 들어왔다는 보고와 U2 초안 진행·⑥ conform 답을 받아 06-03 관문을 닫았다. 사이트 파일은 바꾸지 않았다.**

## Performance

- **Duration:** 6일 (앱 작업 대기 포함. Task 1·2는 2026-11-20에 약 20분, Task 3은 2026-11-26에 중간 보고 다섯 번과 마감)
- **Started:** 2026-11-20T02:25Z
- **Completed:** 2026-11-26T08:40Z
- **Tasks:** 3
- **Files modified:** 3 (06-EVIDENCE.md, 안내 메모, STATE.md) + 이 SUMMARY

## Accomplishments

- 앱 작업 전 상태(`APP_PRE=bfabc3a45d5d`)와 요청서를 기록했다. 요청서는 항목마다 06-04가 앱 코드에서 확인할 「참이어야 할 사실」을 적었다.
- Firebase installation ID 처리를 앱 작업 전에 사용자가 골랐다(`INSTALL_ID=keep-out`).
- 대기 중에 들어온 앱 쪽 보고 다섯 건(⑤ 기록 삭제 화면, ② uid `rate_limits` 삭제와 만료 시각, ① 공개하지 않은 코스 삭제, ⑥ 위치정보 확인자료, ③ 운영자 삭제 도구)을 앱 저장소에서 읽기 전용으로 대조해 중간 보고 구간으로 남겼다.
- 관문 조건을 사용자 결정으로 좁혔다(관리 화면 제외).
- 사용자 답 셋(기준 앱 커밋, U2 초안 진행, 세 경로의 ⑥ 파기 답)을 받아 `## 06-03 앱 작업 보고`에 표식 열한 개로 적었다.

## Task Commits

이 계획은 `.planning` 문서만 고쳤다. 대기 중 커밋은 계획 범위 표기 없이 `docs(06):`로 남겼다(계획 `<output>`).

1. **Task 1: 앱 탐침과 요청서** - `c381acb` (docs. 시작 기록은 `bb662e6`)
2. **Task 2: installation ID 결정** - `c381acb` (같은 커밋), 대기 지점 `277c0d1`
3. **Task 3: 앱 작업 보고** - 중간 보고 `ed10d3a`(⑤), `8c281b0`(②), `695d043`(①), `c5f7a92`(⑥), `0addc01`(관문 조건), `45e9a6a`(③). 보고 표식과 이 SUMMARY는 바로 뒤 docs 커밋

## Files Created/Modified

- `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` - `## 06-03 앱 작업 요청`, `## 06-03 결정`, 중간 보고 구간 다섯, `## 06-03 관문 조건`, `## 06-03 앱 작업 보고`
- `.planning/notes/2026-11-21-admin-tool-design.md` - 06-03 보고 조건을 2026-11-26 결정으로 대체
- `.planning/STATE.md` - 대기 문구와 진행 기록
- `.planning/phases/06-data-deletion-rewrite/06-03-SUMMARY.md` - 이 문서

## Decisions Made

- `INSTALL_ID=keep-out` (사용자, 2026-11-20): installation ID를 기기 단위 식별자로 보고 남는 데이터 표에서 뺀다.
- 관문 조건 (사용자, 2026-11-26): ①②③⑤⑥이 들어간 앱 커밋으로 보고하고, ③은 서버 함수와 명령까지다. 관리 화면이 만드는 데이터는 이번 재기준에 넣지 않는다.
- 기준 앱 커밋 `92e986c3bb29` (사용자, 2026-11-26).
- U2 초안 진행 (사용자, 2026-11-26): `U2_STATUS=draft`, `U2_PROCEED=user-accepted-draft`.
- ⑥ 파기 답 conform (사용자, 2026-11-26): 세 경로 모두.

실행자가 대신 고른 것은 없다. 세 답은 선택지 물음에 사용자가 직접 답한 것이다.

## Deviations from Plan

### 계획에 없던 것

**1. 중간 보고 구간**
- 계획은 Task 3에서 한 번에 보고받는 것만 적었다. 앱 작업이 항목별로 끝나 보고가 다섯 번 왔다.
- 관문이 열리기 전이라 Task 3 표식을 쓰지 않고 `## 06-03 중간 보고 <항목>` 구간과 `MID<n>_SEEN` 표식으로 적었다. 새 구간이 줄 머리 예약 표식과 겹치지 않는지 커밋마다 검사했다.

**2. 관문 조건 변경**
- 2026-11-21 결정은 「①②③⑤⑥과 관리도구를 다 만든 뒤 보고」였다. 앱 쪽이 운영 본부 웹을 지인 배포 뒤로 미뤄, 사용자가 2026-11-26에 관리 화면을 조건에서 뺐다.
- 요청서 ③의 문장은 그대로다.

**3. 실행 방식과 재개**
- Task 3 마감은 `/gsd-execute-phase 6 --wave 3 --interactive`로 이 세션에서 직접 했다(서브에이전트 없음). Task 1·2는 다시 돌리지 않았다. 다시 돌리면 `APP_PRE`가 앱 작업 뒤 커밋으로 덮인다.
- 중간 보고 커밋 여섯은 그 전에 `/gsd-fast`로 남겼다.

**4. 커밋 메시지 끝 줄**
- 06-01 규칙은 끝 두 줄을 `Co-Authored-By: Claude Opus 5.5 …`와 `Claude-Session: …`으로 정했다. 2026-11-26 커밋은 실행 세션의 attribution 지시대로 `Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>` 한 줄로 끝난다.
- 뒤 계획의 verify는 각자 만든 커밋(표식의 해시)만 판정하고 06-03 커밋의 끝 줄은 보지 않는다.

**5. 읽은 범위**
- 앱 저장소 말고 kit 저장소도 읽었다(②가 kit 구현이라는 사용자 안내). dev 프로젝트의 Firestore TTL 정책 목록을 `gcloud`로 두 번 조회했다(조회만).
- `APP_ITEM_2`의 경로는 사용자가 준 것이 아니라 그 안내에 따라 이 세션이 앱 커밋에서 찾은 것이다. 보고 구간에 출처를 적었다.

---

**Total deviations:** 5 (계획에 없던 기록 방식과 실행 방식. 고친 버그 없음)
**Impact on plan:** must_haves의 사실 넷은 그대로 충족했다. 사이트 파일과 앱 저장소는 고치지 않았다.

## Issues Encountered

06-04는 지금 계획 그대로 실행하면 Task 1 verify에서 멈춘다. 먼저 고칠 것은 06-EVIDENCE.md 중간 보고 구간들의 「뒤 계획이 맞춰야 할 것」에 있다. 요약하면 다음과 같다.

- `RUN_DELETE_MENU`는 키 하나를 가정하지만 메뉴 문구는 셋이고(「뱃지 삭제」/「기록 삭제」/「뱃지와 기록 모두 삭제」), 삭제 단위는 기록이 아니라 코스다.
- `RATE_HASH_APP`은 일수를 가정하지만 앱이 정한 것은 「창 끝에 만료, TTL 정책이 삭제」다.
- 06-01 사양 `appcheck`의 두 값(`rate-limits-in-deletion`, `visibility-in-deletion`)은 삭제 코드가 helper 파일로 옮겨 가 삭제 사실을 대표하지 않는다.
- 요청서 ①의 낱말 「비공개 코스」는 앱 문구 「공개하지 않은 코스」(비공개·검수 대기·`visibility` 없음)로 읽어야 한다.
- 운영자 도구의 범위는 id `account`·`records`다. 「위치 기록만」은 뱃지도 지우므로 공개 이름과 안내 문장을 사용자가 정해야 한다.
- CONTEXT D-10·D-11·D-14의 문장이 바뀐 사실(메뉴 이름, 뱃지 동반 삭제, 코스 단위)을 담아야 한다.
- 사용자 결정이 남았다: 「위치 기록만」의 공개 이름, 해시 `rate_limits`의 표기 일수, 확인자료 보존 기간을 184일과 6개월 가운데 어느 쪽으로 적을지.
- prod 전제가 다섯이다: 익명 계정 자동 정리, `rate_limits` TTL 정책, App Engine 기본 서비스 계정의 Firestore 권한, `location_use_records` TTL 정책, 운영자 계정·admin claim·App Check 디버그 토큰.
- 기준 앱 커밋 `92e986c3bb29`는 받은 때 앱 로컬에만 있었다(앱 원격 추적 가지는 `e54b8bdd1a83`).

## User Setup Required

None - 외부 서비스 설정 없음.

## Next Phase Readiness

- 06-03 관문은 닫혔다. 06-04의 precondition(`APP_WORK=reported`, `APP_WORK_HEAD`, `INSTALL_ID`, `DEL06_REPORT=conform`, 항목별 `APP_ITEM_<n>`)이 모두 있다.
- 06-04를 실행하기 전에 06-04~06-07 계획과 CONTEXT D-10·D-11·D-14를 위 목록에 맞춰 고쳐야 한다(계획 수정).
- 사이트 커밋은 여전히 막혀 있다: D-06 재기준(06-04)과 그 뒤 원고 승인까지.

## Self-Check: PASSED

- FOUND: `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md`(`## 06-03 앱 작업 요청`, `## 06-03 결정`, `## 06-03 앱 작업 보고`), `.planning/notes/2026-11-21-admin-tool-design.md`
- FOUND: `bb662e6`, `c381acb`, `277c0d1`, `ed10d3a`, `8c281b0`, `695d043`, `c5f7a92`, `0addc01`, `45e9a6a` (모두 HEAD의 조상)
- Task 1 `<verify>` 계획 끝 재실행 exit 0. 계획 `<verification>` 세 줄 통과: `INSTALL_ID=`·`DEL06_REPORT=conform`·`APP_WORK=reported` 각 1줄, Task 1 깨끗함 기록 `bb662e651d2e`가 `DEC_SHA`의 자손이고 그 사이와 HEAD까지 `.planning` 밖 변경 0건.
- Task 3 acceptance: 사용자가 해시·경로·U2 결론과 법률 확인 여부를 넘겼고, 초안 진행과 conform이 사용자 답으로 적혔다. 답을 받기 전에 사이트 파일과 앱 저장소를 고치지 않았다.
- prohibition 둘: 「끝났다」는 말만으로 끝난 것으로 적지 않았다(해시와 경로를 받았고 판정은 06-04). 열린 선택지를 실행자가 대신 고르지 않았다.
- EVIDENCE에 로컬 홈 경로, 계정 이메일, 프로젝트 ID 0건.

---
*Phase: 06-data-deletion-rewrite*
*Completed: 2026-11-26*
