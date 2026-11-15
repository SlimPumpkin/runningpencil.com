---
phase: 01-ground-truth-policy-reset
plan: 01
subsystem: docs
tags: [baseline, claude-md, generate-claude-md, naming, url-ledger]

requires: []
provides:
  - ".planning/baseline/NAMES.md 이름 표 (BASE-01): 서비스명·운영사·도메인·지원 이메일 값, 사업자 값 7행 (빈칸)"
  - ".planning/baseline/URLS.md URL 대장 (BASE-02): 공개 URL 11개 + v2 예약 1개, 콘솔 필드 범주"
  - "「이번 마일스톤 방침 (2026-11 결정)」 구간 골격 (루트 CLAUDE.md, .claude/CLAUDE.md 첫 GSD 마커 위)"
  - "「원본 먼저, 생성본 나중」 재생성 절차 검증 (CONVENTIONS.md → generate-claude-md → .claude/CLAUDE.md)"
affects: [01-06, phase-05, phase-08, phase-09, phase-10]

actuals:
  tokens: 2309
  tasks: 2
  commits: 2
plan_head_before: 8b8c8ead
plan_head_after: e18de76b

tech-stack:
  added: []
  patterns:
    - ".planning/baseline/ 기준 문서 형식: 제목, 굵은 메타 줄(작성일·기준·읽는 곳), > 주의 문단, 표, 맺음 줄"
    - "방침 구간은 .claude/CLAUDE.md 첫 GSD 마커 위에 두어 재생성에도 남긴다"

key-files:
  created:
    - .planning/baseline/NAMES.md
    - .planning/baseline/URLS.md
  modified:
    - .planning/codebase/CONVENTIONS.md
    - .claude/CLAUDE.md
    - CLAUDE.md

key-decisions:
  - "방침 구간을 .claude/CLAUDE.md의 GSD:project-start 마커 위에 두었고, 재생성 시험에서 그 구간이 남고 바뀐 줄은 conventions 블록의 서비스 이름 줄 하나뿐임을 확인했다"
  - "URL 대장의 /location-terms/ 콘솔 칸은 「콘솔 등록 없음, 홈페이지 푸터 링크」로, /en/location-terms/ 콘솔 칸은 「이번 마일스톤에서는 등록할 곳 없음」으로 글로 적었다 (빈 칸 금지)"

patterns-established:
  - "기준 문서 머리: 굵은 메타 줄 3개 + > 주의 문단, 맺음 줄 *... for: ...* / *Written: ...*"
  - "생성본 수정은 원본(.planning/codebase/*.md) 수정 → 저장소 밖 사본으로 generate-claude-md --output 시험 → 저장소에서 재생성 순서"

requirements-completed: [BASE-01, BASE-02, BASE-05]

coverage:
  - id: D1
    description: "이름 표: 채운 값 5개(러닝펜슬, RunningPencil, 슬림펌킨, runningpencil.com, 지원 이메일)와 사업자 값 7행 (빈칸)"
    requirement: BASE-01
    verification:
      - kind: other
        ref: "01-01-PLAN.md Task 1 verify 1~3 (행 값 grep, (빈칸) 7행, 사업자등록번호 꼴 부재)"
        status: pass
    human_judgment: false
  - id: D2
    description: "영문 서비스명 방침 한 줄이 CONVENTIONS.md → .claude/CLAUDE.md(재생성) → 루트 CLAUDE.md에 반영되고 옛 문장 꼴이 다섯 파일에서 0줄"
    requirement: BASE-05
    verification:
      - kind: other
        ref: "01-01-PLAN.md Task 1 verify 4~8 (옛 문장 grep, 이름 표 경로, 방침 구간 동일, 재생성 cmp, 다른 블록 불변)"
        status: pass
    human_judgment: false
  - id: D3
    description: "공개 저장소 누출 검사와 라이브 사이트 불변 검사"
    verification:
      - kind: other
        ref: "01-01-PLAN.md Task 1 verify 9~11, Task 2 verify 6~7"
        status: pass
    human_judgment: false
  - id: D4
    description: "URL 대장 형식: 주소 행 12줄, apex·https·끝 슬래시, 기존 세 주소 경로 고정 표시, 범주·Phase 10 안내"
    requirement: BASE-02
    verification:
      - kind: other
        ref: "01-01-PLAN.md Task 2 verify 1~5"
        status: pass
    human_judgment: false
  - id: D5
    description: "URL 대장의 「등록할 콘솔 필드(범주)」 열이 제공자·스토어별로 맞는 범주인지"
    requirement: BASE-02
    verification: []
    human_judgment: true
    rationale: "콘솔 필드 범주의 적절성은 사람의 판단이 필요하다 (Task 2 human-check, VALIDATION Manual-Only)"

duration: 5min
completed: 2026-11-15
status: complete
---

# Phase 1 Plan 01: 이름 표·URL 대장과 영문 서비스명 방침 tracer Summary

**`.planning/baseline/`에 이름 표(사업자 값은 (빈칸))와 URL 대장(12행, 콘솔 필드 범주)을 만들고, 「영문 서비스명 RunningPencil」 방침을 CONVENTIONS.md → 재생성한 .claude/CLAUDE.md → 루트 CLAUDE.md까지 통과시켰다. 방침 구간은 GSD 마커 위에 두어 재생성 뒤에도 남는다.**

## Performance

- **Duration:** 5 min
- **Started:** 2026-11-15T05:07:34Z
- **Completed:** 2026-11-15T05:12:53Z
- **Tasks:** 2
- **Files modified:** 5 (생성 2, 수정 3)

## Accomplishments

- 이름 표(`.planning/baseline/NAMES.md`): 12행. 채운 값은 러닝펜슬, RunningPencil, 슬림펌킨, `runningpencil.com`, `support@runningpencil.com`(`.planning/` 문서에만) 다섯 개이고, 사업자 값 7행은 `(빈칸)`이다. 「표시명 규칙」(D-20)과 「앱 쪽 표시명과 일치 확인」 표도 넣었다.
- URL 대장(`.planning/baseline/URLS.md`): KO 6, EN 5, v2 예약 1로 주소 행이 12줄이다. 기존 세 주소에는 「경로 고정(리디렉션 금지)」을 표시했고, `/location-terms/`는 확정값이다. 「도메인만 등록하는 칸」 표를 따로 두었다.
- 「이번 마일스톤 방침 (2026-11 결정)」 구간 골격(제목, 머리 문단, 표 머리, 영문 서비스명 행)을 두 CLAUDE.md에 글자까지 같게 넣었다. 나머지 행은 01-06이 채운다.
- 「원본 먼저, 생성본 나중」 재생성 절차를 실제 저장소에서 검증했다. 바뀐 줄은 conventions 블록의 한 줄뿐이었고 마커 위 구간은 남았다.

## 실행 기록 (acceptance 요구 항목)

**시작 전 옛 문장 검사** (Task 1 verify 4번 명령을 느낌표 없이 실행). 예상한 세 줄이 걸렸다.

```
CLAUDE.md:71:서비스(앱) 이름은 한글 "러닝펜슬"로 표기합니다 (…). 영문 `RunningPencil`은 쓰지 않고, …
.planning/codebase/CONVENTIONS.md:143:- 서비스 이름은 한글 **러닝펜슬**만 쓴다 (…). 영문 `RunningPencil`은 쓰지 않는다. …
.claude/CLAUDE.md:165:- 서비스 이름은 한글 **러닝펜슬**만 쓴다 (…). 영문 `RunningPencil`은 쓰지 않는다. …
```

수정 후 같은 검사의 출력은 0줄이다.

**생성기 시험 결과**
- 수정 전 기준선: 저장소 밖 임시 사본에 `generate-claude-md --output`을 돌린 결과가 현재 `.claude/CLAUDE.md`와 `cmp`로 같았다.
- 방침 구간을 넣고 CONVENTIONS.md를 고친 뒤의 사본 시험: `diff`에서 바뀐 줄은 **1줄**(conventions 블록의 서비스 이름 줄, 사본 기준 173행)이었다. 맨 위 방침 구간은 그대로 남았다.
- 저장소 재생성(`--output`·`--auto` 없이): `sections_generated`는 project, stack, conventions, architecture, workflow이고 fallback은 skills였다. 재생성 뒤 `.claude/CLAUDE.md`는 9줄 추가, 1줄 삭제다(방침 구간 8줄과 빈 줄 1줄, 서비스 이름 줄 교체).

**verify 결과:** Task 1 열한 명령, Task 2 일곱 명령이 모두 exit 0이다. Task 1 커밋 뒤 tracer 게이트에서 Task 1 verify를 다시 돌려 11/11을 확인한 뒤 Task 2로 넘어갔다.

## Task Commits

1. **Task 1: 영문 서비스명 방침 한 줄을 이름 표에서 두 CLAUDE.md까지 통과 (tracer)** - `f07d703` (docs)
2. **Task 2: URL 대장 작성** - `e18de76` (docs)

**Plan metadata:** 이 SUMMARY 커밋 (docs)

## Files Created/Modified

- `.planning/baseline/NAMES.md` - 이름 표 (BASE-01)
- `.planning/baseline/URLS.md` - URL 대장 (BASE-02)
- `.planning/codebase/CONVENTIONS.md` - 143행 서비스 이름 목록 항목을 새 방침으로 교체 (생성 원본)
- `.claude/CLAUDE.md` - 첫 GSD 마커 위에 방침 구간 골격, generate-claude-md로 conventions 블록 재생성
- `CLAUDE.md` - 3행 다음에 방침 구간 골격, 서비스 이름 문단(옛 71행) 교체

## Decisions Made

- 이름 표의 「들어갈 곳」은 `_data/company.yml (Phase 5에서 확정)`으로 적고 키 이름은 고정하지 않았다. 스토어 개발자 이름은 연구 표대로 「Phase 6 삭제 안내 (DEL-02)」로 적었다.
- URL 대장에서 콘솔 등록이 없는 두 행(`/location-terms/`, `/en/location-terms/`)도 콘솔 칸을 비우지 않고 그 사실을 글로 적었다.
- Facebook 삭제 안내의 앵커는 주소에 붙이지 않고 「앵커 `#facebook`」으로 글로 적었다.

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- **보호 브랜치 확인:** 커밋 전 Step 0 검사에서 `gsd-tools query git.base-branch --is-protected main`이 `true`를 돌려주었다. 이 검사를 통과로 기록하지 않는다. 디스패치의 sequential 지시(`branching_strategy: none`, `main`에서 계속, 브랜치를 만들지 않음)에 따라 `main`에 커밋했다. `config.json`은 고치지 않았고 푸시하지 않았다.
- BASE-05는 이 계획에서 일부만 끝난다(영문 서비스명 줄). 나머지 옛 문장은 01-06이 고치므로 `requirements.ready-ids` 게이트가 BASE-05를 막는다. BASE-01, BASE-02만 완료로 표시한다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 01-06이 방침 표의 나머지 여섯 행, 작업 규칙, 남은 옛 문장(루트 `CLAUDE.md` 7, 9, 20-22, 24, 34-38, 44, 58, 69행과 CONVENTIONS.md 142, 145, 146행 등)을 이 골격 위에서 채운다. 생성본은 원본을 고친 뒤 재생성하는 절차를 그대로 쓴다.
- Phase 5, 8, 9, 10은 `.planning/baseline/NAMES.md`와 `URLS.md`를 입력으로 쓴다.
- 사람 확인 대기: URL 대장 콘솔 필드 범주(D5)는 단계 끝 UAT에서 본다.

---
*Phase: 01-ground-truth-policy-reset*
*Completed: 2026-11-15*

## Self-Check: PASSED

- FOUND: `.planning/baseline/NAMES.md`, `.planning/baseline/URLS.md`
- FOUND: `f07d703`, `e18de76` (HEAD의 조상)
