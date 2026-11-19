---
phase: 05-business-info-support-contact
plan: 07
subsystem: docs
tags: [claude-md, codebase-map, names, fact-slot, check-site]

requires:
  - phase: 05-business-info-support-contact
    provides: "05-06 첫 푸시 라이브 확인(LIVE_PUSH1=OK, PUSH1_SHA=57e56b07f2ab) — 사업자 정보 푸터가 라이브에 있음"
provides:
  - "원본 맵 다섯 개(STACK·CONVENTIONS·ARCHITECTURE·TESTING·STRUCTURE)가 사실값 슬롯 _data/company.yml, 푸터 사업자 줄·주소 줄, .size > 0 판정, check-site 7번 항목(일곱 가지)을 지금 코드대로 설명"
  - "CONVENTIONS 「사실값 슬롯 (_data/company.yml)」 절 (판정·or만·escape·조사·따옴표·값 비공개 규칙)"
  - "NAMES.md 「들어갈 곳」이 확정 키 이름(trade_name·representative·biz_reg_no·address·support_email·phone)을 가리킴 (값 없음)"
  - "연구 문서 Pattern 1·2의 blank 비교를 .size > 0 판정으로 정정"
  - "두 CLAUDE.md 「사업자 정보 표시」 행 = Phase 5에서 적용됨, 루트 본문에 사실값 슬롯·푸터 사업자 줄·Deploy 7번 항목, .claude/CLAUDE.md 생성 구간 재생성"
  - "README 점검 주석 7번 항목, STATE Blockers 정리"
affects: [05-12 게이트 푸시 (이 문서 커밋을 함께 실음), 05-13 지원 쪽 문서 갱신, Phase 6~9 법적 본문의 _data 참조]

actuals:
  tokens: 4100
  tasks: 3
  commits: 3
plan_head_before: 9c1fccf9a67efc1d1585cf7304c9f734b216d6ba
plan_head_after: 6856f78d7f975947a4ebad9986d4afff12d88f21

tech-stack:
  added: []
  patterns:
    - "사실값 슬롯 문서 규칙: 문서는 _data/company.yml의 키 이름으로만 값을 가리키고 값 자체는 적지 않음"
    - "원본 맵 → generate-claude-md → .claude/CLAUDE.md 사슬을 커밋 전 임시 사본으로 먼저 시험"

key-files:
  created: []
  modified:
    - .planning/codebase/STACK.md
    - .planning/codebase/CONVENTIONS.md
    - .planning/codebase/ARCHITECTURE.md
    - .planning/codebase/TESTING.md
    - .planning/codebase/STRUCTURE.md
    - .planning/baseline/NAMES.md
    - .planning/research/ARCHITECTURE.md
    - CLAUDE.md
    - .claude/CLAUDE.md
    - README.md
    - .planning/STATE.md
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md

key-decisions:
  - "05-07: 사업자 정보 쪽 문서 커밋 셋(f39c726f6461 원본 맵·이름 표·연구, a37b1245702b 두 CLAUDE.md, 6856f78d7f97 README·STATE). 생성기 임시 사본 시험에서 stack·conventions·architecture만 바뀌어 출력 지정·자동 옵션 없이 재생성. 열두 개 문서 옛 문장·로컬 경로·사업자 값 0줄(DOCS1_STALE=OK). 푸시 안 함(05-12가 함께 실음)"
  - "05-07: 연구 문서 Pattern 2 본문 문장 규칙(157행)의 blank 비교도 .size > 0으로 고침. 계획은 Pattern 1만 적었지만 verify가 문서 전체 0건을 요구함"

patterns-established:
  - "CONVENTIONS 「사실값 슬롯 (_data/company.yml)」 절이 뒤 단계(지원 페이지·법적 본문·영문판)의 _data 참조 규칙 원본"

requirements-completed: []

coverage:
  - id: D1
    description: "원본 맵 다섯 개·이름 표·연구 문서가 사실값 슬롯·푸터 사업자 줄·.size > 0·점검 7번 항목을 지금 코드대로 설명 (DOCS_MAPS1_SHA 커밋 내용 기준)"
    requirement: "BIZ-02"
    verification:
      - kind: other
        ref: "05-07-PLAN.md Task 1 <verify> <automated> (DOCS_MAPS1_SHA 커밋의 일곱 파일 목록·문장·키 이름·blank 0건)"
        status: pass
    human_judgment: false
  - id: D2
    description: "두 CLAUDE.md 방침 구간이 같고 「사업자 정보 표시」 행이 Phase 5 적용 상태, .claude/CLAUDE.md 생성 구간이 재생성 사본과 바이트가 같음"
    requirement: "BIZ-02"
    verification:
      - kind: other
        ref: "05-07-PLAN.md Task 2 <verify> <automated> 두 명령 (방침 구간 비교, 생성기 사본 cmp)"
        status: pass
    human_judgment: false
  - id: D3
    description: "README·STATE 정리와 열두 개 문서의 옛 문장·로컬 경로·사업자 값 0줄"
    verification:
      - kind: other
        ref: "05-07-PLAN.md Task 3 <verify> <automated> (vals emitted=3, 열두 개 문서 훑기, DOCS_MISC1_SHA·site-clean 기록)"
        status: pass
    human_judgment: false

duration: 15min
completed: 2026-11-19
status: complete
---

# Phase 5 Plan 07: 사업자 정보 문서 갱신 Summary

**원본 맵·이름 표·연구 문서·두 CLAUDE.md·README·STATE를 라이브 사업자 정보 푸터(`_data/company.yml` 사실값 슬롯, `.size > 0` 판정, check-site 7번 항목)에 맞춰 고친 문서 커밋 셋. 사업자 값은 어디에도 적지 않고 키 이름으로만 가리킴**

## Performance

- **Duration:** 약 15분
- **Started:** 2026-11-19T04:49:32Z
- **Completed:** 2026-11-19T05:04:01Z
- **Tasks:** 3
- **Files modified:** 11 (+ `05-EVIDENCE.md`)

## Accomplishments

- 원본 맵 다섯 개가 사실값 슬롯(`_data/company.yml`), 푸터 사업자 정보 줄·주소 줄, `.rp-foot-legal span`·`a` 규칙, 「점검 항목은 일곱이다」를 지금 코드대로 적습니다. CONVENTIONS에 `### 사실값 슬롯 (_data/company.yml)` 절(판정은 `.size > 0`만, `or`로만 잇기, `| escape`, 조사 금지, 큰따옴표, 값 비공개)을 새로 두었습니다.
- tracer: 커밋 전에 `.claude/CLAUDE.md`를 임시 사본으로 생성기에 돌려 새 문장이 모두 생성 구간에 옮겨지는 것을 확인했습니다(원본 맵 → 생성기 → `.claude/CLAUDE.md`).
- 이름 표 「들어갈 곳」이 확정 키(`trade_name`·`representative`·`biz_reg_no`·`address`·`support_email`·`phone`)를 가리키고, 「값」 칸은 그대로 빈칸입니다.
- 연구 문서 Pattern 1 예시와 Pattern 2 본문 규칙의 blank 비교를 `.size > 0` 판정으로 고쳤습니다(CONTEXT D-08 정정).
- 두 CLAUDE.md 「사업자 정보 표시」 행이 「Phase 5에서 적용됨 …」이고, 방침 구간 두 사본이 글자까지 같습니다. 「지원 이메일 공개」 행은 그대로입니다(05-13 몫).
- README 점검 주석에 7번 항목을 더하고, STATE Blockers의 가비아 DNS 줄을 작업 0~3 완료·남은 작업(4·5·7)으로 고치고 해소된 Phase 4 줄을 지웠습니다.

## Task Commits

1. **Task 1 (tracer): 원본 맵·이름 표·연구 문서** - `f39c726f6461` (docs)
2. **Task 2: 두 CLAUDE.md와 생성 구간 재생성** - `a37b1245702b` (docs)
3. **Task 3: README·STATE 정리** - `6856f78d7f97` (docs)

**Plan metadata:** SUMMARY·EVIDENCE 문서 커밋, STATE·ROADMAP 문서 커밋 (이 문서 뒤)

## Files Created/Modified

- `.planning/codebase/STACK.md` - YAML 항목·Build 목록의 `_data/company.yml` 줄, check-site 7번 항목
- `.planning/codebase/CONVENTIONS.md` - Files의 슬롯 줄, CSS classes의 푸터 사업자 줄 규칙, Linting 일곱 항목, Content & Naming Rules의 푸터 사업자 줄, 「사실값 슬롯」 절
- `.planning/codebase/ARCHITECTURE.md` - 점검 나열, 푸터 행, 사실값 슬롯 행, 점검 행
- `.planning/codebase/TESTING.md` - 「일곱 가지를 본다」와 7번 항목
- `.planning/codebase/STRUCTURE.md` - 디렉터리 그림의 `_data/company.yml`, 점검 주석
- `.planning/baseline/NAMES.md` - 「들어갈 곳」 키 이름, 표 아래 첫 글머리
- `.planning/research/ARCHITECTURE.md` - Pattern 1·2 판정식과 2026-11-19 정정 메모
- `CLAUDE.md`, `.claude/CLAUDE.md` - 방침 행, 루트 본문 네 곳, 생성 구간 재생성
- `README.md` - 점검 주석
- `.planning/STATE.md` - Blockers 두 줄
- `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` - 구간 `## 05-07 사업자 정보 문서`

## Decisions Made

- CONVENTIONS의 새 `### 사실값 슬롯` 절은 `## Content & Naming Rules` 끝에 두었습니다. 생성기가 옮기도록 모두 맨 위 단계 `- ` 목록으로 썼습니다.
- 연구 문서 예시의 첫 줄(상호·대표자 두 조건)은 and·or를 섞지 않게 `if`를 둘로 겹쳐 썼습니다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - Blocking] 연구 문서 Pattern 2의 blank 비교도 고침**
- **Found during:** Task 1
- **Issue:** 계획 action 6번은 Pattern 1(140·145-148행)만 적었지만, Pattern 2 본문 문장 규칙(157행)에도 `!= blank`가 있어 Task 1 verify(문서 전체 0건)가 실패할 상황이었습니다.
- **Fix:** 157행의 판정식을 `.size > 0`으로 바꾸고 「Pattern 1과 같은 판정, 2026-11-19 고침」을 덧붙였습니다.
- **Files modified:** `.planning/research/ARCHITECTURE.md`
- **Verification:** Task 1 verify exit 0, `!= blank` 0건
- **Committed in:** `f39c726f6461`

---

**Total deviations:** 1 auto-fixed (Rule 3 blocking 1)
**Impact on plan:** 같은 정정(CONTEXT D-08)을 같은 문서의 남은 한 곳에 적용한 것이라 범위가 넓어지지 않았습니다.

## Issues Encountered

None. 생성기 출력의 「Generated 5/6 sections. Fallback: skills.」는 프로젝트 스킬이 없어서 나오는 기존 동작이고, skills 블록은 바뀌지 않았습니다.

## Notes

- 지운 STATE 줄(Phase 4 리뷰 수정 해소)에는 「코스 그리기」 목업과 「달려 보기」 칩을 눈으로 한 번 보는 일은 기록이 없다는 끝말이 붙어 있었습니다. 계획(D-21)대로 줄째 지웠으므로 이 눈 확인 기록은 STATE에서 사라졌습니다. 필요하면 단계 검증 때 다시 봅니다.
- BIZ-02는 다른 계획도 선언해 `requirements.ready-ids`가 blocked라 이 계획에서 완료 처리하지 않았습니다.
- 이 계획의 문서 커밋은 푸시하지 않았습니다. 게이트 푸시(05-12)가 함께 싣습니다.

## User Setup Required

None - 외부 서비스 설정이 필요 없습니다.

## Next Phase Readiness

- 05-08(보류 브랜치의 지원 페이지 묶음)로 넘어갈 수 있습니다. 지원 이메일·`/support/` 쪽 문서(두 CLAUDE.md 「지원 이메일 공개」 행, Pages 표, 「현재 사이트에는 지원 이메일이 없습니다」 문장)는 05-13이 게이트 푸시 라이브 확인 뒤 고칩니다.

## Self-Check: PASSED

- 수정 파일 11개와 `05-EVIDENCE.md`가 모두 있습니다.
- 커밋 `f39c726f6461`, `a37b1245702b`, `6856f78d7f97`이 `HEAD`의 조상입니다.
- Task 1·2·3 verify(4개 명령)와 acceptance가 모두 통과했습니다. 계획 `<verification>`: 문서 밖 커밋 0개, EVIDENCE의 홈 경로·임시 폴더 경로 0건.

---
*Phase: 05-business-info-support-contact*
*Completed: 2026-11-19*
