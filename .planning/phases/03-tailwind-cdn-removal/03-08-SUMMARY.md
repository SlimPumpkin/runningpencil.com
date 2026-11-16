---
phase: 03-tailwind-cdn-removal
plan: 08
subsystem: docs
tags: [claude-md, readme, generate-claude-md, legal-css, tailwind-removal]

requires:
  - phase: 03-tailwind-cdn-removal
    provides: "03-07에서 고친 원본 맵(STACK·CONVENTIONS·ARCHITECTURE 등)과 라이브 확인(LIVE_SITE=OK)"
provides:
  - "두 CLAUDE.md 방침 행 「Phase 3까지 적용됨」 (같은 커밋, 같은 글자)"
  - "루트 CLAUDE.md의 정적 CSS 설명과 「법적 본문 작성 규칙」 (D-24, D-25)"
  - "원본 맵에서 다시 생성한 .claude/CLAUDE.md (stack·conventions·architecture 블록)"
  - "README 푸시 전 점검 주석에 Tailwind 없음"
  - "EVIDENCE 표식 DOCS_CLAUDE_SHA·DOCS_README_SHA·DOCS_STALE=OK"
affects: [03-09, phase-06, phase-07, phase-08, phase-09]

actuals:
  tokens: 12956
  tasks: 2
  commits: 2
plan_head_before: a6808b6f4f4331803971396e2aac632999ca6d4b
plan_head_after: 629c2dfad614f4f4f0d92d0cf2b08b4cf8b64649

tech-stack:
  added: []
  patterns:
    - "방침 행은 두 사본에 같은 문자열 치환으로 고치고 awk 구간 비교로 동일을 확인"
    - "생성 구간은 임시 사본 시험(블록별 비교) 뒤에만 저장소에서 generate-claude-md 실행"

key-files:
  created:
    - .planning/phases/03-tailwind-cdn-removal/03-08-SUMMARY.md
  modified:
    - CLAUDE.md
    - .claude/CLAUDE.md
    - README.md
    - .planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md

key-decisions:
  - "03-08: 루트 CLAUDE.md의 법적 본문 작성 규칙은 D-01~D-04·D-07과 「목록 밖 요소는 legal.css·이 규칙·CONVENTIONS를 같은 단계에서 고침」만 적고, 요소별 모양(D-05~D-12)은 CONVENTIONS 「법적 본문 작성 규칙」 절을 가리킨다"
  - "03-08: 방침 표 「Jekyll 빌드 전환」 행의 적용 단계 칸 「Phase 3 (Tailwind CDN을 정적 CSS로)」는 지난 단계 이름이라 그대로 두었다 (현재 상태 칸만 변경)"

patterns-established:
  - "생성기 시험 판정: 방침 구간·project·skills·workflow·profile 동일, 바뀐 블록이 원본을 고친 블록뿐일 때만 저장소 재생성"

requirements-completed: [SHELL-04]

coverage:
  - id: D1
    description: "두 CLAUDE.md 방침 구간이 글자까지 같고 「Jekyll 빌드 전환」 현재 상태가 「Phase 3까지 적용됨」 (한 커밋 19dbbe78627c)"
    requirement: SHELL-04
    verification:
      - kind: other
        ref: "03-08-PLAN.md Task 1 verify 첫 명령 (awk 구간 비교, grep, git show --name-only)"
        status: pass
    human_judgment: false
  - id: D2
    description: "루트 CLAUDE.md가 법적 페이지를 정적 CSS(legal.css, --rp-* 토큰, Preflight 대체, .rp-legal-*·.rp-doc, 768px 예외)로 설명하고 법적 본문 작성 규칙(section·h2, footer·aside, 허용 요소, figure 감싸개)을 담음. Tailwind script 주소·설정 이름 0줄"
    requirement: SHELL-04
    verification:
      - kind: other
        ref: "03-08-PLAN.md Task 1 verify 첫 명령 (grep legal.css·--rp-ink·figure tabindex·768px·Tailwind Play CDN이 없음)"
        status: pass
    human_judgment: true
    rationale: "문장이 사실과 맞고 읽기 쉬운지는 grep이 판정하지 못함. 규칙 글이 이후 단계 본문 작성을 이끌므로 사람이 한 번 읽어야 함"
  - id: D3
    description: ".claude/CLAUDE.md가 원본에서 다시 생성한 사본과 바이트가 같음 (생성 구간 손 편집 없음)"
    requirement: SHELL-04
    verification:
      - kind: other
        ref: "03-08-PLAN.md Task 1 verify 둘째 명령 (generate-claude-md --output 임시 사본, cmp)"
        status: pass
    human_judgment: false
  - id: D4
    description: "README 점검 주석에 Tailwind 없음, 열 개 문서에 Tailwind 흔적·옛 점검 항목 수·로컬 경로 0줄 (README 커밋 629c2dfad614)"
    requirement: SHELL-04
    verification:
      - kind: other
        ref: "03-08-PLAN.md Task 2 verify 명령"
        status: pass
    human_judgment: false

duration: 4min
completed: 2026-11-16
status: complete
---

# Phase 3 Plan 08: CLAUDE.md와 README Summary

**두 CLAUDE.md 방침 행을 「Phase 3까지 적용됨」으로 같은 커밋에서 맞추고, 루트에 legal.css 정적 CSS 설명과 법적 본문 작성 규칙(section·h2, footer·aside, 허용 요소 21개, figure tabindex 감싸개)을 더했으며, .claude/CLAUDE.md 생성 구간을 원본 맵에서 다시 만들고 README 점검 주석에 Tailwind 없음을 더했다**

## Performance

- **Duration:** 약 4분
- **Started:** 2026-11-16T17:52:08Z
- **Completed:** 2026-11-16T17:56Z
- **Tasks:** 2 (Task 1 tracer, Task 2 auto)
- **Files modified:** 4 (CLAUDE.md, .claude/CLAUDE.md, README.md, 03-EVIDENCE.md)

## Accomplishments

- 방침 구간: 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`의 「Jekyll 빌드 전환」 행 현재 상태 칸만 같은 문자열로 바꿈. 두 구간이 글자까지 같음(awk 비교)
- 루트 `CLAUDE.md` 코드 설명: 법적 페이지 문단(legal.css include, 끝 안내 `<footer>`), 「법적 본문 작성 규칙」 묶음, Local preview(글꼴만 CDN), styling notes(정적 CSS, `--rp-*` 토큰, Preflight 대체, `.rp-legal-*`·`.rp-doc`, 768px `min-width` 예외), Deploy(Tailwind Play CDN 없음)
- `.claude/CLAUDE.md`: 임시 사본 시험에서 바뀐 블록이 stack·conventions·architecture뿐임을 확인한 뒤 저장소에서 `--output`·`--auto` 없이 재생성. 결과가 시험 사본과 바이트 같음
- README 점검 주석을 check-site.sh 다섯 항목과 맞춤. 열 개 문서 훑기 결과 Tailwind 흔적·옛 점검 항목 수·로컬 경로 모두 0줄
- tracer 게이트: 대화형·end-of-phase·automated-only라 Task 1 verify 두 명령을 다시 돌려 exit 0 확인 뒤 Task 2로 진행(체크포인트 없음)

## Task Commits

1. **Task 1: 두 CLAUDE.md 방침 행·루트 코드 설명·본문 작성 규칙, .claude/CLAUDE.md 재생성** - `19dbbe78627c` (docs)
2. **Task 2: README 점검 주석에 Tailwind 없음** - `629c2dfad614` (docs)

**Plan metadata:** SUMMARY·EVIDENCE docs 커밋, 이어서 STATE·ROADMAP 추적 커밋

## Files Created/Modified

- `CLAUDE.md` - 방침 행, 법적 페이지 정적 CSS 설명, 법적 본문 작성 규칙, Local preview·Deploy 문구
- `.claude/CLAUDE.md` - 방침 행(손 편집, 루트와 같은 글자), stack·conventions·architecture 생성 블록 재생성
- `README.md` - 푸시 전 점검 주석에 「Tailwind 없음」
- `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md` - `## 03-08 CLAUDE.md와 README` 구간, `DOCS_CLAUDE_SHA=19dbbe78627c`, `DOCS_README_SHA=629c2dfad614`, `DOCS_STALE=OK`

## Decisions Made

- 루트의 본문 작성 규칙은 D-01~D-04·D-07과 「목록 밖 요소가 필요하면 세 곳을 함께 고침」만 적고, 요소별 모양(D-05~D-12)은 원본 맵 CONVENTIONS의 같은 절을 가리켰다. 두 곳에 같은 세부를 복사하면 어긋날 위험이 커지기 때문이다(`.claude/CLAUDE.md`에는 생성기가 CONVENTIONS 전체를 넣음)
- 방침 표의 적용 단계 칸 「Phase 3 (Tailwind CDN을 정적 CSS로)」는 단계 이름이라 고치지 않았다. 바뀐 사실은 현재 상태 칸 하나다(prohibition 준수)

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 03-09(문서 푸시와 단계 마무리)로 넘어갈 준비가 됨. 이 계획의 커밋 두 개(`19dbbe78627c`, `629c2dfad614`)와 docs 커밋은 푸시하지 않았다. origin/main은 그대로 `2ebeca06ca51`이다
- `.planning/PROJECT.md`(Active 체크, 현재 사이트 설명, Key Decisions 행)는 D-24대로 단계 전환 갱신에서 고친다. 이 계획에서는 바꾸지 않았다

---
*Phase: 03-tailwind-cdn-removal*
*Completed: 2026-11-16*

## Self-Check: PASSED
