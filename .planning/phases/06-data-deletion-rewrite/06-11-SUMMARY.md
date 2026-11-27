---
phase: 06-data-deletion-rewrite
plan: 11
subsystem: docs
tags: [claude-md, codebase-map, generate-claude-md, names, data-inventory, readme, tracer]
status: complete

# Dependency graph
requires:
  - phase: 06-data-deletion-rewrite
    provides: "06-10의 build 커밋 B1 `45f1958c1b5f`(점검 6번 범위 확대와 8번 항목, HOOK8=OK)"
  - phase: 06-data-deletion-rewrite
    provides: "06-09의 라이브 삭제 안내(앵커 여덟, 소개 문단, 검색 제외·임시 표시 없음)와 `_data/company.yml`의 `store_developer_name` 키"
  - phase: 06-data-deletion-rewrite
    provides: "06-04·06-13이 만든 데이터 목록 「### prod 전제 (Phase 6 D-42)」 절"
provides:
  - "원본 맵 커밋 DOCS_MAPS_SHA `c54e3c6258c9`: CONVENTIONS(점검 여덟, 검색 제외는 처리방침·약관에만, 키 `store_developer_name`, 맨 앞 소개 문단 규칙과 `legal.css` 머리 주석 후속 글머리), ARCHITECTURE(System Overview 점검 나열, 점검 행, 삭제 안내 페이지 컴포넌트 행, Entry Point), STACK(메타·점검·키 목록)"
  - "두 CLAUDE.md 커밋 DOCS_CLAUDE_SHA `f58fb62ed52b`: 방침 구간 세 행의 현재 상태(두 사본 글자까지 같음), 루트 본문(_data 키, Pages 표 삭제 안내 행, 법적 레이아웃 문단, 소개 문단 규칙, 이메일 글머리, Deploy 점검), `.claude/CLAUDE.md` 생성 구간 재생성"
  - "기준 문서 커밋 DOCS_BASE_SHA `fb7733412e28`: 이름 표 「스토어 개발자 이름」 들어갈 곳, 데이터 목록 「확인할 것」 prod 추적 행과 Analytics 전제 행, README 점검 주석"
  - "06-EVIDENCE.md 구간 `## 06-11 원본 맵`, `## 06-11 CLAUDE`, `## 06-11 기준 문서`"
affects: [06-12, phase-7, phase-8, phase-9, phase-10]

# Actuals (#2632)
actuals:
  tokens: 2656     # chars/4 over 실현된 diff (세 문서 커밋의 바뀐 줄 8665자 + 06-EVIDENCE.md에 더한 줄 1962자. SUMMARY 제외)
  tasks: 3
  commits: 3       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY를 쓸 때). 이 SUMMARY와 06-EVIDENCE.md의 문서 커밋, STATE·ROADMAP 커밋은 그 뒤
plan_head_before: 9615156a5624e58f189cbe6ca6c2df915e7ae98e
plan_head_after: fb7733412e2860f90299284d693b222d9376c314

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "`.claude/CLAUDE.md` 재생성 전 생성기 사본 시험을 기계적으로 판정한다: `<!-- GSD:project-start` 앞(방침 구간)이 바이트 같고, 바뀐 줄이 모두 stack·conventions·architecture 구간 안에 있을 때만 저장소에서 돌린다"
    - "데이터 목록 「확인할 것」 표는 prod 전제를 옮겨 적지 않고 「### prod 전제 (Phase 6 D-42)」 절을 가리키는 추적 행 하나만 둔다"

key-files:
  created:
    - .planning/phases/06-data-deletion-rewrite/06-11-SUMMARY.md
  modified:
    - .planning/codebase/CONVENTIONS.md
    - .planning/codebase/ARCHITECTURE.md
    - .planning/codebase/STACK.md
    - CLAUDE.md
    - .claude/CLAUDE.md
    - .planning/baseline/NAMES.md
    - .planning/baseline/DATA-INVENTORY.md
    - README.md
    - .planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md

key-decisions:
  - "App Store 개발자 표기 차이 행((다))은 06-08 기록이 `APPSTORE_NAME=same`이라 「확인할 것」 표에 더하지 않았다 (계획이 `different`일 때만 더하라고 정함)"
  - "루트 `CLAUDE.md`의 법적 본문 규칙에는 소개 문단 글머리와 `legal.css` 머리 주석 후속을 한 글머리로 합쳐 넣었다. 원본 맵(CONVENTIONS)에는 계획대로 두 글머리로 나눴다"

patterns-established:
  - "문서 커밋마다 작업 트리 check-site 통과, 스테이징 뒤 값 누출 점검(인덱스 전체), 커밋 뒤 site-clean 줄을 그 커밋 해시로 적는다"

requirements-completed: [BIZ-05, DEL-02, DEL-03]  # 계획 frontmatter 그대로. 06-12도 같은 ID를 가지므로 REQUIREMENTS.md 완료 표시는 공유 ID 관문(requirements.ready-ids)대로 한다

coverage:
  - id: D1
    description: "원본 맵 셋이 삭제 안내의 현재 모습(점검 여덟, 검색 제외 범위, 새 키, 소개 문단 규칙과 후속, 삭제 안내 Entry Point와 앵커)을 적고 생성기로 생성 구간까지 이어진다"
    requirement: "DEL-02"
    verification:
      - kind: other
        ref: "06-11-PLAN.md Task 1 <verify><automated> (DOCS_MAPS_SHA c54e3c6258c9)"
        status: pass
      - kind: other
        ref: "acceptance: grep -c '점검 항목은 일곱이다' CONVENTIONS.md = 0, grep -c store_developer_name CONVENTIONS.md = 1"
        status: pass
    human_judgment: false
  - id: D2
    description: "두 CLAUDE.md 방침 구간이 같은 커밋에서 글자까지 같게 고쳐졌고 `.claude/CLAUDE.md` 생성 구간은 원본 맵에서 다시 만들어져 재생성 사본과 바이트가 같다"
    requirement: "DEL-03"
    verification:
      - kind: other
        ref: "06-11-PLAN.md Task 2 <verify> 첫 <automated> (DOCS_CLAUDE_SHA f58fb62ed52b)"
        status: pass
      - kind: other
        ref: "06-11-PLAN.md Task 2 <verify> 둘째 <automated> (재생성 사본 cmp)"
        status: pass
    human_judgment: false
  - id: D3
    description: "이름 표 「스토어 개발자 이름」 들어갈 곳이 `store_developer_name`이고 값 칸은 빈칸, 데이터 목록에 prod 추적 행, 문서에 옛 문장·값·홈 경로가 없다"
    requirement: "BIZ-05"
    verification:
      - kind: other
        ref: "06-11-PLAN.md Task 3 <verify><automated> (DOCS_BASE_SHA fb7733412e28)"
        status: pass
      - kind: other
        ref: "plan <verification>: git log B1_SHA..DOCS_BASE_SHA 사이트 파일 커밋 빈 출력"
        status: pass
    human_judgment: false

# Metrics
duration: 8min
completed: 2026-11-27
---

# Phase 6 Plan 11: 문서 갱신 (원본 맵·두 CLAUDE.md·기준 문서) Summary

**원본 맵 셋과 두 CLAUDE.md, 이름 표·데이터 목록·README가 삭제 안내 재작성(앵커 여덟, 검색 제외 해제), 새 키 `store_developer_name`, 점검 8번을 적고, `.claude/CLAUDE.md` 생성 구간은 생성기 사본 시험을 거쳐 원본 맵에서 다시 만들었다**

## Performance

- **Duration:** 약 8분
- **Started:** 2026-11-27T03:38:46Z
- **Completed:** 2026-11-27T03:47Z
- **Tasks:** 3
- **Files modified:** 9 (문서 8, 검증 기록 1)

## Accomplishments

- 원본 맵(CONVENTIONS·ARCHITECTURE·STACK)이 점검 항목 여덟(6번 범위를 삭제 안내까지, 8번 삭제 안내 본문), 검색 제외가 처리방침·약관에만 남았다는 것, 사실값 키 `store_developer_name`, 맨 앞 소개 문단 규칙과 `legal.css` 머리 주석 후속, 삭제 안내 컴포넌트 행·Entry Point(앵커 여덟)를 적는다
- 두 CLAUDE.md 방침 구간 세 행(지원 이메일 공개, 포인트·굿즈·코스북 제거, noindex 해제)의 현재 상태가 삭제 안내 반영을 적고 두 사본이 글자까지 같다. 루트 본문(_data 키, Pages 표, 법적 레이아웃 문단, 소개 문단 규칙, 이메일 글머리, Deploy)도 고쳤다
- `.claude/CLAUDE.md` 생성 구간은 손으로 고치지 않고 생성기로 다시 만들었다. 사본 시험에서 바뀐 구간은 stack·conventions·architecture뿐이었고 skills·workflow·profile은 그대로다
- 이름 표 「스토어 개발자 이름」의 들어갈 곳이 `store_developer_name`이고 값 칸은 빈칸이다. 데이터 목록 「확인할 것」에 prod 전제 절을 가리키는 추적 행(prod 생성 때, Phase 10)과 Analytics 360·BigQuery 전제 행(Phase 7)을 더했다
- 옛 문장 넷 0건, 홈 경로 0건, 값 누출 점검은 세 커밋 모두 `leak=skip(no new values)`(개발자 이름 값이 기준 커밋에 이미 있어 새 값 없음)

## Task Commits

1. **Task 1 (tracer): 원본 맵 셋 갱신과 생성기 사본 시험** - `c54e3c6258c9` (docs)
2. **Task 2: 두 CLAUDE.md 방침 구간·루트 본문 갱신, 생성 구간 재생성** - `f58fb62ed52b` (docs)
3. **Task 3: 이름 표·데이터 목록·README 갱신과 훑기** - `fb7733412e28` (docs)

**Plan metadata:** SUMMARY·06-EVIDENCE.md 문서 커밋, 이어서 STATE·ROADMAP 커밋

Tracer 피드백 관문: `human_verify_mode=end-of-phase`이고 Task 1 `<verify>`가 `<automated>`뿐이라 verify를 다시 돌려 통과(rc=0)를 확인하고 Task 2로 넘어갔다.

## Files Created/Modified

- `.planning/codebase/CONVENTIONS.md` - 점검 여덟, `<head>` 순서의 검색 제외 범위, 지원 이메일·검색 제외 문장, 사실값 키, 소개 문단 규칙과 후속 글머리
- `.planning/codebase/ARCHITECTURE.md` - System Overview 점검 나열, 점검 행, 삭제 안내 페이지 행, Entry Points 분리
- `.planning/codebase/STACK.md` - 메타 검색 제외 범위, 점검 여덟 설명, `_data/company.yml` 키 목록
- `CLAUDE.md` - 방침 구간 세 행, 루트 본문 여섯 곳
- `.claude/CLAUDE.md` - 방침 구간 세 행(루트와 같게), 생성 구간 재생성
- `.planning/baseline/NAMES.md` - 「스토어 개발자 이름」 들어갈 곳
- `.planning/baseline/DATA-INVENTORY.md` - 「확인할 것」 새 행 둘
- `README.md` - 10행 점검 주석
- `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` - 06-11 구간 셋

## Decisions Made

- (다) App Store 표기 차이 행은 `APPSTORE_NAME=same`이라 더하지 않았다.
- 루트 CLAUDE.md의 소개 문단 글머리는 후속(`legal.css` 머리 주석) 설명까지 한 글머리로 넣었다. 원본 맵에는 계획대로 두 글머리다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] README 점검 주석의 「랜딩 기능 이름」을 「랜딩·삭제 안내 기능 이름」으로 함께 고침**
- **Found during:** Task 3
- **Issue:** 계획은 괄호 끝에 「·삭제 안내 본문(요청 경로·검색 제외 없음)」만 더하라고 했지만, 점검 6번이 삭제 안내 출력까지 넓어져 「랜딩 기능 이름」이 사실과 달라진다
- **Fix:** ARCHITECTURE System Overview 나열과 같은 낱말 「랜딩·삭제 안내 기능 이름」으로 바꿈
- **Files modified:** README.md
- **Verification:** Task 3 verify rc=0
- **Committed in:** `fb7733412e28`

---

**Total deviations:** 1 auto-fixed (Rule 1 하나)
**Impact on plan:** 같은 줄 안의 낱말 하나로 README가 실제 점검 범위와 맞게 됐다. 범위 밖 변경은 없다.

## Issues Encountered

None

## User Setup Required

None - 외부 서비스 설정 없음.

## Next Phase Readiness

- 06-12(푸시)가 쓸 문서 커밋 셋이 `main` 로컬에 있다. 이 계획은 아무것도 푸시하지 않았다.
- 사이트 파일을 고친 커밋은 없다 (`B1_SHA..DOCS_BASE_SHA` 사이트 경로 커밋 빈 출력).
- 처리방침·이용약관의 검색 제외·임시 표시는 문서에 「아직 남아 있음」으로 적혀 있고 Phase 7·8이 지운다. `legal.css` 머리 주석의 소개 문단 줄은 다음에 그 출력을 바꾸는 단계가 더한다.

## Self-Check: PASSED

- 파일: 수정한 아홉 파일과 이 SUMMARY가 있다
- 커밋: `c54e3c6258c9`, `f58fb62ed52b`, `fb7733412e28` 모두 HEAD의 조상
- Task 1·3 verify, Task 2 verify 두 명령, 계획 `<verification>` 모두 exit 0 (SUMMARY 쓰기 직전 다시 돌림)

---
*Phase: 06-data-deletion-rewrite*
*Completed: 2026-11-27*
