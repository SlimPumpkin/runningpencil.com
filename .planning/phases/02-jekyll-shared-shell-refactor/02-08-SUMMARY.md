---
phase: 02-jekyll-shared-shell-refactor
plan: 08
subsystem: infra
tags: [jekyll, include, css-comment, codebase-map, docs]

requires:
  - phase: 02-07
    provides: 푸시 ③(랜딩 전환) 라이브 확인 통과 (LIVE_PUSH3=OK), 네 페이지가 include 한 벌을 쓰는 상태
provides:
  - 「공통」 CSS 머리 주석을 include 구조에 맞게 고친 별도 커밋 (b11e43b49c0a, D-06)
  - 주석 제거 비교 diff 0, 주석 그대로 비교에서 머리 주석 한 줄만 다름 (EVIDENCE 표식 COMMENT_FIX_SHA, CMP_FINAL_NOCOMMENT=OK, CMP_COMMENT_ONLY=OK)
  - 지금 구조를 적는 원본 맵 STACK·CONVENTIONS·ARCHITECTURE (02-09의 generate-claude-md 재생성 원본)
affects: [02-09, 02-10, phase-03]

actuals:
  tokens: 6865
  tasks: 3
  commits: 3
plan_head_before: bfbe918d43970a41dde9d9e76e58a2d625c04332
plan_head_after: 8c75ca92f04efbefbe82043085018655b5e2fbcd

tech-stack:
  added: []
  patterns:
    - "「공통」 CSS는 _includes/css/common.css 한 곳에서 고친다 (출력 주석도 이렇게 안내)"
    - "원본 맵의 행 번호 참조는 grep -n으로 지금 파일에서 다시 찾아 적는다. 옮겨 간 블록은 include·레이아웃 경로를 가리킨다"

key-files:
  created: []
  modified:
    - _includes/css/common.css
    - .planning/codebase/STACK.md
    - .planning/codebase/CONVENTIONS.md
    - .planning/codebase/ARCHITECTURE.md
    - .planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md

key-decisions:
  - "02-08: 「공통」 머리 주석 수정 커밋 b11e43b49c0a. 주석 제거 비교에서 네 문서가 기준 db505d71d3d2와 같고, 주석 그대로 비교에서는 머리 주석 한 줄만 다르다 (사용자 승인 예외, ROADMAP 성공 기준 1 문구는 고치지 않음)"
  - "02-08: 원본 맵 세 개를 지금 구조(include 네 개, _layouts/legal.html, bundle exec jekyll serve --livereload, scripts/check-site.sh)로 고침. .claude/CLAUDE.md 재생성은 02-09에서 함"

patterns-established:
  - "include 공백 규칙과 raw 규칙이 CONVENTIONS(Module Design)와 ARCHITECTURE(Anti-Patterns, Constraints)에 적혀 generate-claude-md로 .claude/CLAUDE.md에 옮겨진다"

requirements-completed: [SHELL-01, SHELL-02]

coverage:
  - id: D1
    description: "「공통」 CSS 머리 주석을 별도 커밋으로 고치고, 주석 제거 비교에서 네 문서·파일 목록이 기준과 같음을 증명"
    requirement: SHELL-01
    verification:
      - kind: other
        ref: "compare.sh db505d71d3d2 b11e43b49c0a --no-comments (OK 5줄, exit 0)"
        status: pass
      - kind: other
        ref: "compare.sh db505d71d3d2 b11e43b49c0a (DIFF 4문서, diff 줄은 머리 주석뿐, 파일 목록 OK)"
        status: pass
      - kind: other
        ref: "scripts/check-site.sh HEAD (check-site: 통과)"
        status: pass
    human_judgment: false
  - id: D2
    description: "STACK·CONVENTIONS 원본 맵이 로컬 빌드·미리보기, Bundler·Gemfile.lock, check-site 린터 대체, include·레이아웃·공백·raw 규칙을 적는다"
    requirement: SHELL-02
    verification:
      - kind: other
        ref: "Task 2 verify 1~3 (금지 문구 없음, 필수 문구 있음, 커밋이 두 파일만 담음)"
        status: pass
    human_judgment: false
  - id: D3
    description: "ARCHITECTURE 원본 맵이 include·레이아웃 구조와 전환 뒤 행 번호를 적는다"
    requirement: SHELL-01
    verification:
      - kind: other
        ref: "Task 3 verify 1~3 (구조 경로, 행 번호 범위, 표본 세 줄 내용 대조)"
        status: pass
    human_judgment: true
    rationale: "verify는 표본 세 줄만 내용으로 대조한다. 나머지 참조는 실행 중 전부 sed로 대조했지만, 문장 서술의 정확성은 사람이 읽어 확인해야 한다"

duration: 8min
completed: 2026-11-16
status: complete
---

# Phase 02 Plan 08: 「공통」 주석 수정과 원본 맵 갱신 Summary

**「공통」 CSS 머리 주석을 `_includes/css/common.css` 한 곳 안내로 고친 별도 커밋(주석 제거 비교 diff 0), 원본 맵 STACK·CONVENTIONS·ARCHITECTURE를 Jekyll include·레이아웃과 로컬 빌드·check-site 기준으로 갱신**

## Performance

- **Duration:** 8 min
- **Started:** 2026-11-16T05:32:52Z
- **Completed:** 2026-11-16T05:40:15Z
- **Tasks:** 3
- **Files modified:** 5 (사이트 1, 원본 맵 3, 검증 기록 1)

## Accomplishments

- 주석 수정 커밋 `b11e43b49c0a`: `_includes/css/common.css` 둘째 줄만 `모든 페이지가 이 묶음을 _includes/css/common.css 에서 불러 쓴다. 고칠 때는 그 파일 한 곳만 고친다. */`로 바뀌었다. 파일 끝 줄바꿈 없음은 그대로다.
- 비교 두 개 (기준 `db505d71d3d2`, 후보 `b11e43b49c0a`):
  - 주석 제거(`--no-comments`): 네 문서 OK(정규화 동일), `_site` 파일 목록 11개 동일, exit 0 → `CMP_FINAL_NOCOMMENT=OK`
  - 주석 그대로: 네 문서 DIFF, 문서마다 diff는 옛 머리 주석과 새 머리 주석 두 줄뿐, 파일 목록 OK → `CMP_COMMENT_ONLY=OK`
  - 커밋 전에도 스테이징 트리(`git write-tree`)로 같은 결과를 확인했다.
- 원본 맵 세 개가 지금 구조를 적는다. `.claude/CLAUDE.md` 재생성은 02-09에서 한다 (이 계획에서 `CLAUDE.md`·`.claude/CLAUDE.md`는 바뀌지 않음: `git diff --quiet HEAD~3 HEAD -- CLAUDE.md .claude/CLAUDE.md` 통과).

## Task Commits

1. **Task 1: 「공통」 CSS 머리 주석 수정 (tracer)** - `b11e43b49c0a` (refactor)
2. **Task 2: STACK·CONVENTIONS 원본 맵 갱신** - `f17a20e191f2` (docs)
3. **Task 3: ARCHITECTURE 원본 맵 갱신과 행 번호 재조정** - `8c75ca92f04e` (docs)

**Plan metadata:** SUMMARY·EVIDENCE·STATE·ROADMAP docs 커밋 (이 SUMMARY 커밋)

## Files Created/Modified

- `_includes/css/common.css` - 「공통」 머리 주석 둘째 줄
- `.planning/codebase/STACK.md` - 바뀐 구간: Languages(CSS·YAML 줄), Runtime/Environment(로컬 빌드·미리보기 `bundle exec jekyll serve --livereload`, `vendor/bundle`, livereload 주의와 check-site), Package Manager(Bundler, `Gemfile.lock`·CHECKSUMS, 운영은 lock 미사용), Build/Dev(Jekyll 3.10.0·Liquid 4.0.4 조립, 린터·포매터·테스트 러너 없음, check-site·pre-push), Key Dependencies(로컬 빌드 전용 gem 7개 묶음 추가), Configuration/Build(`_config.yml` url·열 항목 exclude와 덮어쓰기 설명, Gemfile/lock, check-site, pre-push와 `core.hooksPath`, `.gitignore` 추가 네 줄), Platform Requirements/Development(Homebrew Ruby 4.x + Bundler, 시스템 Ruby 2.6 미사용)
- `.planning/codebase/CONVENTIONS.md` - 바뀐 구간: Naming/Files(include·CSS 조각·레이아웃 이름 규칙, 금지 레이아웃 이름), IDs(인라인 스크립트 위치 약 428행), Linting(check-site로 갈음, 점검 넷, 훅 자동 실행), 「공통」 구획(`_includes/css/common.css` 한 곳), 「법적 페이지 전용」 위치(`_layouts/legal.html`), Import Organization(`{% include head-links.html %}` 한 항목, Tailwind 두 블록은 레이아웃), Module Design/Shared code(include 네 개·레이아웃·front matter 키, `home=true`, include 공백 규칙, raw 규칙), Content & Naming Rules(exclude 덮어쓰기), Commit Messages(푸시 전 check-site)
- `.planning/codebase/ARCHITECTURE.md` - 바뀐 구간: System Overview(Jekyll 조립, include 공유, 푸시 전 점검), Component 표(「공통」 CSS → include, head 링크·헤더·푸터·법적 레이아웃·푸시 전 점검 행 추가, Tailwind 토큰·모눈종이 → `_layouts/legal.html:16-30`·`:37`, Jekyll 설정 행), Pattern Overview·Key Characteristics, Layers(Markup·Style·Behavior 위치), Data Flow·State·Key Abstractions·Error Handling의 `index.html` 행 번호 전부, 공유 헤더/푸터(include와 로고 위치), Entry Points(front matter), Architectural Constraints(IIFE 행, Liquid 처리 줄 추가), Anti-Patterns(「공통 블록을 페이지 파일에 다시 써 넣음」, 「include 공백 규칙 어김」 추가, 랜딩 전용·860px 행 번호)
- `.planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md` - `## 02-08 「공통」 주석 수정 (D-06)` 구간 (표식 세 줄, 두 비교 출력, 예외와 ROADMAP 문구 미수정 기록)

## Decisions Made

- 행 번호는 옛 번호를 기계적으로 옮기지 않고, 참조가 가리키던 내용(함수 이름, id, 구획 주석)을 지금 `index.html`에서 찾아 적었다. 범위 참조는 함수 시작부터 닫는 줄까지로 맞췄다 (예: `paintStory` 485-505, `setStep` 467-476).
- 옮겨 간 블록은 include 쪽을 가리키게 했다: 「공통」 CSS → `_includes/css/common.css`(include 자리 `index.html:27`, `_layouts/legal.html:32`), 로고 → `_includes/header.html:5`·`_includes/footer.html:7`.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] CONVENTIONS.md의 다른 낡은 서술 두 줄도 고침**
- **Found during:** Task 2
- **Issue:** action 목록에 없지만 전환 뒤 사실과 어긋난 줄이 둘 있었다. IDs 구획의 「`index.html` 끝(약 495행)의 인라인 스크립트」(지금 428행)와 「법적 페이지 전용 — 법적 페이지 3종에 있다」(지금 `_layouts/legal.html`). 이 맵은 `.claude/CLAUDE.md`로 옮겨져 다음 에이전트의 지시가 된다.
- **Fix:** 「약 428행」, 「`_layouts/legal.html`의 `<style>`에 있고 법적 페이지 3종이 함께 쓴다」로 고쳤다.
- **Files modified:** `.planning/codebase/CONVENTIONS.md`
- **Verification:** `sed -n 428p index.html` → `<script>`, `_layouts/legal.html:34`에 「법적 페이지 전용」 머리 주석
- **Committed in:** `f17a20e191f2` (Task 2 커밋)

---

**Total deviations:** 1 auto-fixed (Rule 1). **Impact on plan:** 같은 원본 맵 안의 사실 정정이다. 범위가 늘지 않았고 커밋 구성(두 파일)도 그대로다.

## Issues Encountered

- ARCHITECTURE.md를 고치는 첫 시도(heredoc으로 Python 스크립트를 넘김)가 stdin 인코딩 오류로 파일을 바꾸기 전에 끝났다. Write 도구로 파일 전체를 다시 써서 해결했다 (파일은 첫 시도에서 바뀌지 않음을 `git status`로 확인).
- 남은 낡은 서술: `STRUCTURE.md`·`TESTING.md`·`CONCERNS.md`에도 정적 서버 미리보기와 복사 공유 서술이 있다(D-19 대상). 이 계획의 `files_modified`에는 없어서 고치지 않았다. 02-09 또는 그 뒤 계획이 다룬다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 02-09: 원본 맵 세 개가 준비됐다. 02-09가 루트 `CLAUDE.md`·방침 구간과 함께 `generate-claude-md`로 `.claude/CLAUDE.md`를 다시 만든다.
- 푸시하지 않았다. 원격 main은 `e7e62f3f7990` 그대로다. 주석 수정 커밋과 docs 커밋들은 D-15 네 번째 푸시(02-10, 별도 승인)에 실린다.

---
*Phase: 02-jekyll-shared-shell-refactor*
*Completed: 2026-11-16*
