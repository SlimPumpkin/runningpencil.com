---
phase: 01-ground-truth-policy-reset
plan: 06
subsystem: docs
tags: [claude-md, policy, conventions, generate-claude-md]

requires:
  - phase: 01-ground-truth-policy-reset
    provides: "01-01이 넣은 「이번 마일스톤 방침」 구간 골격(제목, 머리 문단, 표 머리, 영문 서비스명 행)과 이름 표"
provides:
  - "두 CLAUDE.md의 방침 표 일곱 행(적용 단계, 현재 상태, 이유, 출처)"
  - "방침 구간 안의 「작업 규칙」 여섯 항목과 원본 경로(.planning/ROADMAP.md Ground Rules)"
  - "생성 원본 CONVENTIONS.md·TESTING.md·CONCERNS.md의 날짜 붙은 상태 문장"
  - "원본에서 다시 만든 .claude/CLAUDE.md conventions 블록"
affects: [phase-02, phase-03, phase-05, phase-06, phase-07, phase-08, phase-09]

actuals:
  tokens: 7500
  tasks: 3
  commits: 3
plan_head_before: bd7f24169270c2ad5b5d619c5e7bf56f0113a83c
plan_head_after: 96c600278118811211b13a2b4fc0d9dc9eae7bb3

tech-stack:
  added: []
  patterns:
    - "날짜 붙은 상태 문장: 「현재 X (2026-11 기준). Phase N에서 바뀜」"
    - "원본(CONVENTIONS.md) 먼저 고치고 생성본(.claude/CLAUDE.md)은 generate-claude-md로 맞춤"

key-files:
  created: []
  modified:
    - CLAUDE.md
    - .claude/CLAUDE.md
    - .planning/codebase/CONVENTIONS.md
    - .planning/codebase/TESTING.md
    - .planning/codebase/CONCERNS.md

key-decisions:
  - "CONVENTIONS.md의 이메일 항목은 폼 금지 규칙(유지)과 지원 이메일 상태 문장(이메일 게이트 Phase 5)으로 나눠 Content & Naming Rules를 일곱 항목으로 만듦"
  - "생성기 시험에서 바뀐 줄이 conventions 블록의 Content & Naming Rules 목록 줄(과 제목 아래 빈 줄 하나)뿐임을 확인한 뒤 저장소에서 --auto 없이 재생성함"

patterns-established:
  - "방침 표 행은 적용 단계에 Phase 번호, 현재 상태에 「결정됨」, 출처에 .planning/ 경로를 반드시 둔다"

requirements-completed: [BASE-05]

coverage:
  - id: D1
    description: "두 CLAUDE.md의 「이번 마일스톤 방침」 표가 일곱 행이고 행마다 적용 단계·현재 상태·이유·출처가 있으며, 두 파일의 구간 글자가 같다"
    requirement: "BASE-05"
    verification:
      - kind: other
        ref: "Task 2 verify 명령 1·2 (방침 표 행 검사, 작업 규칙·구간 일치 검사)"
        status: pass
      - kind: other
        ref: "Task 3 verify 명령 2 (성공 기준 5 새 방침 검사)"
        status: pass
    human_judgment: false
  - id: D2
    description: "다섯 방침 파일에 옛 규칙 문장 꼴 아홉 가지가 0줄 (수정 전 14줄)"
    requirement: "BASE-05"
    verification:
      - kind: other
        ref: "Task 3 verify 명령 1 (성공 기준 5 옛 문장 검사)"
        status: pass
    human_judgment: false
  - id: D3
    description: ".claude/CLAUDE.md가 재생성 결과와 바이트 단위로 같고 방침 구간이 첫 GSD 마커 위에 있다"
    requirement: "BASE-05"
    verification:
      - kind: other
        ref: "Task 2 verify 명령 3·4·5 (마커 순서, 재생성 cmp, 블록 밖 줄 불변)"
        status: pass
    human_judgment: false
  - id: D4
    description: "상태 문장이 아직 적용되지 않은 방침을 지금 해도 되는 일로 읽히지 않게 쓰였고, 옛 규칙을 인용하지 않았다 (D-01, D-02 판단 항목)"
    requirement: "BASE-05"
    verification: []
    human_judgment: true
    rationale: "prohibitions 세 항목이 verification: judgment로 표시됨. 문장이 어떻게 읽히는지는 정규식으로 판정할 수 없음"

duration: 4min
completed: 2026-11-15
status: complete
---

# Phase 1 Plan 06: CLAUDE.md 방침 표 일곱 행과 작업 규칙, 옛 규칙 문장 정리 Summary

**두 CLAUDE.md에 방침 일곱 행(적용 단계·현재 상태·이유·출처)과 ROADMAP Ground Rules를 줄인 작업 규칙을 넣고, 다섯 방침 파일의 옛 규칙 문장 14줄을 「현재 X (2026-11 기준). Phase N에서 바뀜」 꼴로 바꿨다. .claude/CLAUDE.md는 generate-claude-md로 원본에서 다시 만들었다.**

## Performance

- **Duration:** 4 min
- **Started:** 2026-11-15T06:30:25Z
- **Completed:** 2026-11-15T06:34:43Z
- **Tasks:** 3
- **Files modified:** 5

## Accomplishments

- 방침 표에 지원 이메일 공개, 사업자 정보 표시, 한국어 + 영어 제공, Jekyll 빌드 전환, 포인트·굿즈·코스북 제거, 법적 페이지 `noindex` 해제 여섯 행을 더해 일곱 행으로 만들었다. 지원 이메일 주소 문자열은 적지 않고 이름 표 경로만 가리킨다.
- 방침 구간 안에 `### 작업 규칙`(여섯 항목)과 출처 줄(`.planning/ROADMAP.md` Ground Rules, `.planning/baseline/` 다섯 문서)을 넣었다. 두 파일의 구간 글자가 같다.
- `CONVENTIONS.md` Content & Naming Rules를 목록 일곱 줄(날짜 붙은 줄 넷)로 고치고 `generate-claude-md`로 `.claude/CLAUDE.md`에 옮겼다.
- 루트 `CLAUDE.md` 아홉 곳(앱 설명, 빌드 없음, Pages 세 행, 복사 공유 문단, Local preview, Tailwind CDN, 이메일 항목, Content language, Deploy)을 상태 문장으로 바꿨다. 코드 설명(미리보기 명령, Tailwind CDN 주소, 공통 블록 복사)은 그대로 두고 유효 기간만 붙였다.

## Task Commits

1. **Task 1: 생성 원본 세 파일의 옛 규칙 문장을 상태 문장으로 교체** - `54fcf1a` (docs)
2. **Task 2: 방침 표 나머지 여섯 행과 작업 규칙 추가, .claude/CLAUDE.md 재생성** - `06a58c8` (docs)
3. **Task 3: 루트 CLAUDE.md의 남은 옛 문장을 상태 문장으로 교체** - `96c6002` (docs)

## Files Created/Modified

- `CLAUDE.md` - 방침 표 여섯 행과 작업 규칙 추가, 방침 구간 아래 아홉 곳을 날짜 붙은 상태 문장으로
- `.claude/CLAUDE.md` - 마커 위 방침 구간에 같은 여섯 행과 작업 규칙, conventions 블록은 재생성
- `.planning/codebase/CONVENTIONS.md` - Content & Naming Rules 일곱 항목, Shared code 문단에 Phase 2 유효 표시
- `.planning/codebase/TESTING.md` - 콘텐츠 규칙 점검 항목, 「이메일 주소 미노출 확인」 명령 블록, E2E 문단
- `.planning/codebase/CONCERNS.md` - 개인정보처리방침 Risk 줄의 한 문장, 문의 채널 Problem 줄

## 옛 문장 검사: 수정 전과 수정 뒤 (성공 기준 5)

수정 전 (Task 1 시작 전, 다섯 파일, 14줄):

```
.planning/codebase/CONVENTIONS.md:142:- `<html lang="ko">`, 본문은 한국어.
.planning/codebase/CONVENTIONS.md:145:- 연락처 이메일·이메일 수집 폼을 넣지 않는다.
.planning/codebase/CONVENTIONS.md:146:- 법적 페이지 3종은 `<meta name="robots" content="noindex">`를 유지한다.
CLAUDE.md:15:(앱 설명 문단 — 포인트·코스북·굿즈가 든 옛 괄호 설명)
CLAUDE.md:66:(이메일 수집 폼 항목 — 연락처 이메일 미표시 문장)
CLAUDE.md:77:(Content language 첫 문단 — 본문·lang 한 줄)
.planning/codebase/TESTING.md:65:(콘텐츠 규칙 점검 항목)
.planning/codebase/TESTING.md:119:(옛 명령 블록 제목)
.planning/codebase/TESTING.md:121:(옛 grep 명령 줄)
.claude/CLAUDE.md:172:- `<html lang="ko">`, 본문은 한국어.
.claude/CLAUDE.md:175:(CONVENTIONS.md:145의 사본)
.claude/CLAUDE.md:176:(CONVENTIONS.md:146의 사본)
.planning/codebase/CONCERNS.md:56:(개인정보처리방침 Risk 줄 — 연락처 이메일 방침 문장)
.planning/codebase/CONCERNS.md:123:(문의 채널 Problem 줄)
```

(D-02에 따라 옛 규칙 문장 일부는 위치와 성격만 적고 원문을 다시 옮기지 않았다. 원래 출력은 행 번호와 함께 14줄이었다.)

수정 뒤 (Task 3 verify 명령 1, 다섯 파일): **0줄** (grep exit 1, `!`로 감싼 verify는 exit 0).

계획이 예상한 수(열네 줄 안팎)와 맞는다. 조사 때의 17줄에서 01-01이 서비스 이름 줄 세 곳을 먼저 고쳐 14줄이 됐다.

## 생성기 시험 결과 (Task 2)

저장소 밖 사본에 `generate-claude-md --output <사본>`을 돌린 diff:

```
190,191c190
< (빈 줄)
< - (옛 페이지 언어 줄)
---
> - 현재 페이지는 모두 `<html lang="ko">`이고 본문은 한국어다 (2026-11 기준). Phase 9에서 ... 함께 제공한다.
194,195c193,195
< - (옛 이메일 줄)
< - (옛 noindex 줄)
---
> - 이메일 수집 폼과 서버 처리는 만들지 않는다 (...). 연락은 공개 지원 이메일로만 받는다.
> - 현재 사이트에는 지원 이메일이 없다 (2026-11 기준). 이메일 게이트(Phase 5: ...) ...
> - 현재 법적 페이지 3종에는 ... 「임시 게시본」 표시가 있다 (2026-11 기준). ... (U14).
```

바뀐 줄은 conventions 블록 Content & Naming Rules의 목록 줄과 제목 아래 빈 줄 하나뿐이었고(계획이 예상한 변경), 마커 위 방침 구간은 그대로 남았다. 그래서 저장소에서 `--output`·`--auto` 없이 돌렸다. 재생성 전후로 `.planning/config.json`과 `.planning/state.json`의 해시가 같음을 확인했다.

## 새 방침 검사의 일부러 실패시키기 (Task 2)

루트 `CLAUDE.md`에서 「Jekyll 빌드 전환」 행을 잠시 지우고 Task 2 verify를 돌렸다.

- 명령 1: `miss= CLAUDE.md:[Jekyll] CLAUDE.md:rows=6`, exit 1
- 명령 2: 두 파일의 구간 글자가 달라 exit 1

파일을 되돌린 뒤(`cmp`로 백업과 같음 확인) 여섯 명령이 모두 exit 0이었다.

## Verify 결과

- Task 1: 다섯 명령 모두 exit 0 (`dated=4 nonlist=[] miss=`)
- Task 2: 여섯 명령 모두 exit 0 (`heading=1 rules=15 marker=28`, `lines=7 bad=`)
- Task 3: 일곱 명령 모두 exit 0 (`dated=11 miss=`). 마지막 명령(SUMMARY 누출 검사)은 이 파일을 쓴 뒤 커밋 전에 다시 돌렸다.

## Decisions Made

- CONVENTIONS.md의 이메일 항목을 둘로 나눴다. 폼 금지 규칙은 그대로 가는 규칙이고, 지원 이메일은 이메일 게이트(Phase 5) 전까지의 상태 문장이다.
- 생성기는 시험 diff가 예상한 줄만 바꾼 것을 확인한 뒤에 저장소에서 돌렸다. 블록 안을 손으로 고친 곳은 없다.

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 방침과 작업 규칙이 두 CLAUDE.md에 같은 글자로 있어 다음 세션이 이번 결정을 되돌리지 않는다.
- Phase 2(Jekyll 공유 셸)가 끝나면 「Phase 2까지 유효」로 표시한 문장(빌드 없음, 복사 공유, Local preview, Deploy, CONVENTIONS Shared code, TESTING E2E)을 고쳐야 한다. Phase 3, 5, 6~9도 각자 표시한 문장을 고친다.

---
*Phase: 01-ground-truth-policy-reset*
*Completed: 2026-11-15*

## Self-Check: PASSED
