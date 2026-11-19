---
phase: 05-business-info-support-contact
plan: 13
subsystem: docs
tags: [docs, claude-md, codebase-map, names, support-page, support-email, anchor-rule, hold-worktree, d-21, d-13, sup-01, sup-02, evidence]
status: complete

# Dependency graph
requires:
  - phase: 05-business-info-support-contact
    provides: "05-12 LIVE_PUSH2=OK·PUSH2_SHA(게이트 푸시 라이브 확인), 05-10 GATE_DATE, 05-09 SC_VERIFIED·SC_DATE, 05-11 보류 묶음 cherry-pick(H1′·H2′·H3′), 05-08 보류 worktree $HOLD_WT와 브랜치 p5-support-hold, 05-01 스크래치 lib.sh의 vals"
provides:
  - "원본 맵 여섯 개(STACK·CONVENTIONS·ARCHITECTURE·TESTING·STRUCTURE·CONCERNS)와 이름 표가 지원 페이지·헤더·푸터 「고객 지원」 링크·푸터 이메일 행·점검 3번 다섯 문서·지원 이메일 공개 상태를 지금 코드대로 설명 (DOCS_MAPS2_SHA=7d227dfa66c3)"
  - "CONVENTIONS 「법적 본문 작성 규칙」의 앵커 규칙 「앵커 `id`는 `section`에 둔다」 (D-13). 생성기가 .claude/CLAUDE.md conventions 블록으로 옮김"
  - "두 CLAUDE.md의 「지원 이메일 공개」 행 「Phase 5에서 적용됨 (이메일 게이트 2026-11-19 통과)」, 루트 Pages 표의 support/index.html 행, 푸터 글머리의 「고객 지원」 링크·이메일 행. .claude/CLAUDE.md 생성 구간 재생성 (DOCS_CLAUDE2_SHA=e994aecf8117)"
  - "STATE Blockers의 DNS·Workspace 줄을 게이트 뒤 상태로 (DOCS_MISC2_SHA=2c9f8230217f)"
  - "보류 worktree $HOLD_WT 삭제 (브랜치 ref p5-support-hold는 로컬에만 남김), HOLD_WT_REMOVED=OK, DOCS2_STALE=OK, OK site-clean 05-13-t3 2c9f8230217f"
affects: [05-14, 05-15, 06, 07, 08, 09]

# Actuals (#2632)
actuals:
  tokens: 19479    # chars/4: git diff plan_head_before..plan_head_after 74509자(문맥 줄 포함, .claude/CLAUDE.md 긴 줄 다수) + 작업 트리 05-EVIDENCE.md diff 3408자. SUMMARY 제외
  tasks: 3
  commits: 3       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). SUMMARY·EVIDENCE 문서 커밋과 STATE·ROADMAP 기록 커밋은 이 뒤
plan_head_before: 9e5e17e184b2b0533ad6913d44b7e7cf682d864e
plan_head_after: 2c9f8230217f3c27f796392017e061a1671939ba

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "원본 맵을 고친 뒤 커밋 전에 저장소 밖 임시 사본으로 generate-claude-md를 돌려, 새 문장이 생성 구간에 옮겨지는지와 바뀐 줄이 stack·conventions·architecture 블록뿐인지 먼저 본다 (tracer)"
    - "정확히 한 번 나오는 문자열만 바꾸는 교체 목록으로 문서를 고쳐, 옛 문장이 다른 곳에 남거나 엉뚱한 곳이 바뀌지 않게 한다"

key-files:
  created:
    - .planning/phases/05-business-info-support-contact/05-13-SUMMARY.md
  modified:
    - .planning/codebase/STACK.md
    - .planning/codebase/CONVENTIONS.md
    - .planning/codebase/ARCHITECTURE.md
    - .planning/codebase/TESTING.md
    - .planning/codebase/STRUCTURE.md
    - .planning/codebase/CONCERNS.md
    - .planning/baseline/NAMES.md
    - CLAUDE.md
    - .claude/CLAUDE.md
    - .planning/STATE.md
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md

key-decisions:
  - "지원 쪽 문서(D-21)는 게이트 푸시 라이브 확인 뒤에만 고쳤고, 주소는 어느 문서에도 글자로 적지 않고 `_data/company.yml`의 `support_email` 키와 이름 표로만 가리킨다"
  - "보류 worktree는 git cherry 세 줄이 모두 `-`이고 worktree가 깨끗할 때만 강제 옵션 없이 지웠다. 브랜치 ref p5-support-hold는 앞 계획 verify 재실행과 원본 커밋 보존을 위해 로컬에만 남기고, 지우는 일은 단계 검증 뒤 사용자 몫으로 둔다"

patterns-established:
  - "앵커 `id`는 `section`에 둔다. 앱과 콘솔이 여는 앵커(`/support/`의 `#contact`·`#report`·`#faq`, Phase 6의 `#facebook`)는 이름을 바꾸지 않는다 (D-13)"

requirements-completed: []  # 계획 requirements는 [SUP-01, SUP-02]. 05-11·05-12와 같은 이 단계 관례대로 단계 검증(05-15) 전에는 비워 둠

coverage:
  - id: D1
    description: "원본 맵 일곱 개에 페이지 수 넷 문장·지원 이메일 부재 문장·문의 채널 부재 문장이 없고, 기록한 커밋의 CONVENTIONS에 앵커 규칙과 `support_email`, ARCHITECTURE·STRUCTURE에 support/index.html이 있으며, 그 커밋은 게이트 푸시 뒤이고 일곱 파일만 담고 legal.css를 바꾸지 않았다"
    requirement: "SUP-01"
    verification:
      - kind: other
        ref: "05-13-PLAN.md Task 1 <verify> (Task 3 뒤 다시 실행해도 exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "두 CLAUDE.md의 방침 구간이 글자까지 같고 「지원 이메일 공개」 행이 Phase 5 적용을 적으며, 루트 Pages 표에 지원 페이지 행, 푸터 글머리에 「고객 지원」 링크·이메일 행이 있고, 두 CLAUDE.md·README에 지원 주소가 없으며, .claude/CLAUDE.md가 재생성 사본과 바이트가 같다"
    requirement: "SUP-02"
    verification:
      - kind: other
        ref: "05-13-PLAN.md Task 2 <verify>와 acceptance 네 명령 (0·0·1·1)"
        status: pass
    human_judgment: false
  - id: D3
    description: "보류 worktree가 지워졌고 브랜치 ref는 로컬에만 있으며(원격·upstream 없음, origin/main의 조상 아님), STATE 커밋이 STATE 하나만 담고, 열 개 문서의 옛 문장·로컬 경로·사업자 값·주소가 0줄이며, 게이트 푸시와 계획 끝 HEAD 사이에 사이트 파일이 바뀌지 않았다"
    requirement: "SUP-02"
    verification:
      - kind: other
        ref: "05-13-PLAN.md Task 3 <verify>와 acceptance (worktree 목록 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 13min
completed: 2026-11-19
---

# Phase 5 Plan 13: 지원 쪽 문서와 보류 정리 Summary

**원본 맵·이름 표·두 CLAUDE.md를 게이트 뒤 상태(지원 페이지 `support/index.html`, 헤더·푸터 「고객 지원」 링크, 푸터 이메일 행, 점검 3번 다섯 문서, 앵커 규칙)로 고쳐 생성기까지 이었고, 보류 worktree를 cherry 확인 뒤 지웠다(브랜치 ref는 로컬에 남김)**

## Performance

- **Duration:** 약 13분 (첫 커밋 기준, 읽기 포함 전체는 더 김)
- **Started:** 2026-11-19T10:08:28Z (Wave 13 시작 커밋 9e5e17e 시각)
- **Completed:** 2026-11-19T10:21:05Z
- **Tasks:** 3
- **Files modified:** 11 (문서만. 사이트 파일 0)

## Accomplishments

- 원본 맵 여섯 개와 이름 표를 지금 코드대로 고쳤다: 페이지 다섯, `support/index.html`(법적 레이아웃, 앵커 `#contact`·`#report`·`#faq`, 검색 제외·임시 표시 없음), 헤더 메뉴 끝과 푸터 nav(「약관 및 지원」)의 「고객 지원」 링크, 푸터 이메일 행, 점검 3번 다섯 문서. 지원 이메일·문의 채널 부재 문장은 「연락 수단은 지원 이메일 하나, 주소는 `support_email` 한 곳, 정본은 이름 표, 주소를 바꾸면 게이트 재시험」으로 바꿨다.
- CONVENTIONS 「법적 본문 작성 규칙」에 앵커 규칙을 맨 위 단계 글머리로 더했다. `_includes/css/legal.css`는 건드리지 않았다(법적 3종 출력 그대로).
- 커밋 전에 생성기를 임시 사본으로 돌려 새 문장(앵커 규칙, 「고객 지원」, 「약관 및 지원」)이 `.claude/CLAUDE.md` 생성 구간에 옮겨지고 다른 블록과 방침 구간이 그대로임을 확인했다(tracer). 다시 돌려도 같은 결과(멱등).
- 두 CLAUDE.md 방침 행을 같은 글자로 「Phase 5에서 적용됨 (이메일 게이트 2026-11-19 통과) …」로 고치고, 루트 본문(Pages 표, include 줄, 푸터 글머리, 이메일 단락, 페이지 수, Deploy)을 맞춘 뒤 `.claude/CLAUDE.md`를 재생성했다.
- 보류 worktree를 `git cherry` 세 줄 `-` 확인 뒤 강제 옵션 없이 지웠고, 브랜치 ref는 남겼다. STATE Blockers의 DNS·Workspace 줄을 게이트 뒤 상태로 고쳤다.

## Task Commits

1. **Task 1: 원본 맵과 이름 표 (tracer)** - `7d227dfa66c3` (docs)
2. **Task 2: 두 CLAUDE.md와 생성 구간 재생성** - `e994aecf8117` (docs)
3. **Task 3: STATE 막는 항목** - `2c9f8230217f` (docs). 보류 worktree 삭제와 훑기는 커밋 없음

**Plan metadata:** SUMMARY·EVIDENCE 문서 커밋 (이 파일과 함께)

## Files Created/Modified

- `.planning/codebase/STACK.md` - HTML 페이지 다섯, 지원 페이지 legal 레이아웃, 「모든 페이지」 글꼴, 지원 페이지 noindex 없음, 게이트 통과 뒤 채운 `support_email`, 점검 3번 다섯 문서
- `.planning/codebase/CONVENTIONS.md` - Files·Linting·「공통」 머리줄·헤더·푸터 글머리·앵커 규칙·Shared code·Content & Naming Rules(이메일 한 글머리, 푸터 줄)
- `.planning/codebase/ARCHITECTURE.md` - System Overview 페이지 5개, 헤더·푸터·법적 레이아웃·점검 행, 지원 페이지 행, Entry Points
- `.planning/codebase/TESTING.md` - 점검 3번, 콘텐츠 규칙의 게이트 뒤 기준, 「이메일 주소 확인」 절(원본에는 0, 빌드 출력에는 지원 주소 하나), 링크 점검에 `/support/`
- `.planning/codebase/STRUCTURE.md` - 디렉터리 그림·Directory Purposes·Key File Locations·기대 제목 목록 다섯 문서·지원 페이지 앵커
- `.planning/codebase/CONCERNS.md` - 처리방침 항목의 지원 이메일 「해소」, 점검 항목, 페이지 수 5, 문의 채널 「해소」(법적 본문 연락처는 Phase 6~8)
- `.planning/baseline/NAMES.md` - 지원 이메일 행 「예 (게이트 2026-11-19 뒤 사이트에 공개)」, 표 아래 글머리 (주소 칸 그대로)
- `CLAUDE.md`, `.claude/CLAUDE.md` - 방침 행(두 사본 같게), 루트 본문, 생성 구간 재생성
- `.planning/STATE.md` - Blockers DNS·Workspace 줄
- `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` - 구간 `## 05-13 지원 쪽 문서와 정리`

## Decisions Made

- 계획이 이름으로 짚지 않았지만 같은 규칙에 걸리는 줄도 고쳤다: CONVENTIONS의 「이후 지원 페이지」 두 곳(지원 페이지는 이제 있음), STACK의 noindex 줄(지원 페이지는 없음), TESTING 링크 점검 목록의 `/support/`, CONCERNS 88행 점검 항목(넷만 적혀 있던 것을 일곱으로), 루트 CLAUDE.md의 사이트 구성 문장·`_data` 글머리·법적 레이아웃 단락의 noindex 문장.
- 생성기는 들여 쓴 하위 목록을 버리므로, 헤더·푸터 「고객 지원」 설명은 CONVENTIONS의 맨 위 단계 글머리(「헤더·푸터는 「공통」 `.rp-*` 클래스로 그린다」 줄, 푸터 줄)에 넣었다. 하위 목록(헤더 링크 변형)에도 같은 문장을 더했다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 3 - Blocking] 커밋 메시지 끝 줄 규칙 충돌**
- **Found during:** Task 1 커밋
- **Issue:** 05-01 「모든 task에 적용하는 규칙」은 메시지 마지막 줄을 `Co-Authored-By` 한 줄로만 두라고 하고, 오케스트레이터는 `Co-Authored-By`와 `Claude-Session` 두 줄을 붙이라고 했다.
- **Fix:** 05-12처럼 `Claude-Session` 줄 다음 마지막 줄에 `Co-Authored-By`를 두었다(마지막 줄은 정확히 `Co-Authored-By` 한 줄). 05-13 verify는 trailer를 보지 않는다.
- **Files modified:** 없음 (커밋 메시지)
- **Committed in:** 7d227dfa66c3, e994aecf8117, 2c9f8230217f, 그리고 SUMMARY 커밋

---

**Total deviations:** 1 (Rule 3, 커밋 메시지 형식)
**Impact on plan:** 내용 영향 없음.

## Issues Encountered

- 재생성한 `.claude/CLAUDE.md`에서 `## Languages` 같은 머리줄 바로 뒤의 빈 줄 몇 개가 빠졌다. 생성기 출력 그대로이고(손으로 고치지 않음), 내용 줄은 빠지지 않았으며, 다시 돌려도 바이트가 같다.

## User Setup Required

None - 외부 작업 없음.

## Next Phase Readiness

- 05-14(작업 5 보내기 설정·STATE 정리)로 넘어갈 수 있다. 이 계획의 문서 커밋은 05-15 마지막 문서 푸시 때 나간다. 사이트 출력은 바뀌지 않았다.
- **후속 (사용자 몫):** 단계 검증(05-15) 뒤 로컬 브랜치 `p5-support-hold`를 `git branch -D p5-support-hold`로 지울 수 있다. 그전에는 05-08·05-10·05-11 verify가 이 ref를 읽으므로 남겨 둔다. 원격에는 올라간 적이 없다.
- PROJECT.md Key Decisions의 결과 칸(지원 이메일 공개·`/support/` 신설)은 단계 전환에서 고친다(계획 가정대로 범위 밖).

## Self-Check: PASSED

- 파일: 수정한 열한 파일과 이 SUMMARY가 있다.
- 커밋: `7d227dfa66c3`, `e994aecf8117`, `2c9f8230217f`가 HEAD의 조상이다.
- Task 1·2·3 `<verify>`와 acceptance 명령을 Task 3 뒤 다시 돌려 모두 통과(exit 0, 0·0·1·1, worktree 목록 0). 계획 `<verification>`의 사이트 출력 불변(`git diff --quiet PUSH2_SHA HC -- …`)도 Task 3 verify 안에서 통과.

---
*Phase: 05-business-info-support-contact*
*Completed: 2026-11-19*
