---
phase: 01-ground-truth-policy-reset
fixed_at: 2026-11-15T15:18:59Z
review_path: .planning/phases/01-ground-truth-policy-reset/01-REVIEW.md
iteration: 1
findings_in_scope: 3
fixed: 3
skipped: 0
status: all_fixed
---

# Phase 1: Code Review Fix Report

**Fixed at:** 2026-11-15T15:18:59Z
**Source review:** .planning/phases/01-ground-truth-policy-reset/01-REVIEW.md
**Iteration:** 1

**Summary:**
- Findings in scope: 3 (WR-06, IN-07, IN-08. 범위 `all`. 필요성(necessity) 항목 없음)
- Fixed: 3
- Skipped: 0

모든 수정은 문서 변경입니다. 커밋은 하나에 항목 하나만 담았습니다. 커밋 형식은 fixer 기본값인 `fix(01): ID …`(`gsd_run query commit`)가 아닙니다. 앞선 리뷰 수정 커밋(`d127c7c`..`f4861dd`)과 같은 `docs(01): … (ID)` 형식을 썼고, 일반 `git commit`으로 본문과 trailer를 붙였습니다. 항목과 커밋의 짝은 아래 해시로 확인합니다 (`fix(01)`로 찾으면 나오지 않습니다).

## Fixed Issues

### WR-06: 생성기가 원본의 소제목 줄·코드 블록·번호 목록·하위 목록을 버려서 `.claude/CLAUDE.md`의 여러 구간이 뜻을 잃음

**Files modified:** `.planning/codebase/CONVENTIONS.md`, `.planning/codebase/ARCHITECTURE.md`, `.planning/codebase/TESTING.md`, `.claude/CLAUDE.md` (다시 생성함)
**Commit:** 1dc2f1a
**Applied fix:**
- 생성기 코드(`gsd-core/bin/lib/profile-output.cjs`의 `generateConventionsSection`·`generateArchitectureSection`)를 읽고 규칙을 확인했습니다. 생성기는 `#`로 시작하는 줄(`# `는 빼고), `- `·`* `·`|`로 시작하는 줄만 남깁니다. ARCHITECTURE는 여기에 `` ``` `` 울타리 줄을 더 남기는데, 울타리 안의 내용은 버립니다.
- 이 규칙에 맞게 원본의 모양만 바꿨습니다. 사실과 `index.html:NNN` 줄 번호, frontmatter는 그대로 두었습니다.
  - 아래에 목록이 딸린 굵은 소제목은 `### ` 머리줄로 바꿨습니다 (Files, CSS classes, 법적 페이지 (Tailwind CDN), 색 토큰, Markup/Style/Behavior, State Management, SVG 심볼 + `<use>` 등).
  - 값이 같은 줄에 있는 굵은 소제목은 `- **이름:** …` 목록으로 바꿨습니다 (Exports/Shared code/SVG, Entry Points, Overall, Strategy, Anti-Patterns의 What happens/Why/Do this instead, Cross-Cutting 네 줄).
  - 번호 목록과 하위 목록은 맨 위 `- ` 목록으로 바꿨습니다 (`<style>` 구획, `<head>` 순서, Data Flow 15단계, 커밋 예시).
  - 코드 블록은 줄 안 코드로 옮겼습니다 (Error Handling 예시). System Overview의 상자 그림은 같은 사실을 담은 목록 다섯 줄로 바꿨습니다.
  - JSDoc 줄과 Logging 줄은 리뷰가 제시한 문장 그대로 넣었습니다.
- 리뷰 표에 없던 곳도 같은 규칙으로 함께 바꿨습니다: ARCHITECTURE의 Cross-Cutting·Overall·Strategy, CONVENTIONS의 `<style>` 구획 번호 목록, 접근성 기본값, `<head>` 순서 목록.
- 그 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 생성 구간을 다시 만들었습니다. `.claude/CLAUDE.md`의 diff는 `conventions-start`부터 `architecture-end` 마커 사이에만 있습니다.
- `TESTING.md` 점검 목록 9의 설명에 한 줄을 더했습니다. 생성기가 어떤 줄을 버리는지, 원본을 다시 만든 뒤 무엇을 확인하는지 적었습니다. `TESTING.md`는 생성 원본이 아니라서 이 줄이 생성 결과로 새어 나가지 않습니다.

**확인한 것:**
- 원본 두 파일에서 생성기가 버리는 줄을 기계적으로 찾았습니다. 남은 것은 메타 줄(`**Analysis Date:**`, `<!-- refreshed -->`, 맨 끝의 `---`와 `*… analysis*`)뿐입니다.
- 생성 구간(`conventions`~`architecture`)에서 빈 머리줄을 머리줄 단계를 따져 찾았습니다. 빈 머리줄은 다음 내용 줄이 마커이거나 같은 단계 이하의 머리줄인 머리줄입니다.
  - 수정 전(`dd2c568`): 11건. `## Logging`, `## Module Design`, `### Story 스크롤 고정`, `### Demo 런`, `## Entry Points`, Anti-Patterns 머리줄 셋, `## Cross-Cutting Concerns`가 여기에 들고, 나머지 둘은 아래의 감싸는 머리줄입니다.
  - 수정 후(`ae4668b`): 2건. `## Conventions`와 `## Architecture`뿐입니다. 이 둘은 생성기가 구간마다 붙이는 감싸는 머리줄이고, 수정 전에도 있었습니다.
- 콜론으로 끝나는 줄과 코드 블록 울타리도 찾았습니다. 둘 다 0건입니다.
- 원본 파일(`CONVENTIONS.md`, `ARCHITECTURE.md`, `TESTING.md`)의 diff(`dd2c568..ae4668b`)를 자르지 않고 처음부터 끝까지 다시 읽었습니다. 모양만 바뀌었고 사실·줄 번호가 빠지거나 바뀐 곳은 없습니다.
- 생성기를 다시 돌려도 결과가 바뀌지 않습니다.

### IN-07: 생성 구간 규칙의 「마커의 `source:`가 가리키는 파일」과 「`generate-claude-md`로 다시 만듭니다」가 일부 구간에 맞지 않음

**Files modified:** `CLAUDE.md`, `.claude/CLAUDE.md`
**Commit:** 79fc9f7
**Applied fix:** 두 사본의 같은 문장을 같은 커밋에서 바꿨습니다. 바뀐 문장은 이렇습니다.
- `project`·`stack`·`conventions`·`architecture` 구간은 원본 네 파일(`.planning/PROJECT.md`, `.planning/codebase/STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md`)을 고친 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 다시 만듭니다.
- `skills`·`workflow`·`profile` 구간은 도구가 관리하므로 고치지 않습니다.

`TESTING.md` 점검 목록 9의 비교 명령은 출력 없이 통과합니다. `git grep`으로 찾아보니 `ROADMAP.md` Ground Rules에는 이 문장이 없어서 고칠 사본이 더 없습니다.

최종 문장은 리뷰가 제시한 문장과 두 군데가 다릅니다. 마커 줄임 표기(`<!-- GSD:project/stack/conventions/architecture -->`)를 넣지 않고 구간 이름만 적었습니다. 실행 명령도 `gsd-tools.cjs generate-claude-md` 대신 경로를 다 쓴 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 적었습니다.

**적용 중 생긴 일:** 처음 쓴 문장에 제가 마커 문자열 `<!-- GSD:project-start … -->`를 예시로 넣었습니다. 리뷰의 줄임 표기는 생성기가 찾는 문자열과 맞지 않아 해가 없었고, 이 문자열은 리뷰가 아니라 제가 고른 표기입니다. 생성기를 돌리자 `.claude/CLAUDE.md`가 깨졌습니다.
- 생성기는 `indexOf('<!-- GSD:project-start')`로 구간을 찾습니다. 그래서 방침 구간 안의 문장을 project 구간의 시작으로 잘못 알았습니다.
- 그 결과 방침 구간 끝부분(데이터 목록 규칙, 끝맺는 문단)과 진짜 마커가 지워졌습니다.
- 커밋 전에 `git checkout --`으로 되돌렸습니다. 마커 문자열을 뺀 문장으로 다시 적용했고, 생성기를 돌려도 결과가 바뀌지 않는 것을 확인했습니다.

이 위험(본문에 `<!-- GSD:이름-start` 꼴의 문자열을 쓰면 생성기가 그 자리를 구간의 시작으로 안다)은 아직 어느 문서에도 적혀 있지 않습니다. 이번 항목의 범위 밖이라 문서에는 넣지 않았습니다.

### IN-08: Deploy 문단이 한 문단 안에서 「푸시」와 「커밋」을 배포 시점으로 번갈아 씀

**Files modified:** `CLAUDE.md`
**Commit:** ae4668b
**Applied fix:** `CLAUDE.md:107`의 「CI가 없으므로 커밋이 곧 배포입니다.」를 「CI가 없으므로 `main` 푸시가 곧 배포입니다.」로 바꿨습니다. 루트 문서에만 있는 구간이라 `.claude/CLAUDE.md`는 바꾸지 않았습니다.

## 검증 환경

- 수정, 생성기 실행, 점검은 모두 격리 worktree(`.claude/worktrees/rf-01-17945-…`, 브랜치 `gsd-reviewfix/01-17945`)에서 했습니다. 생성기가 쓴 경로가 worktree 안의 `.claude/CLAUDE.md`인 것을 출력(`claude_md_path`)으로 확인했습니다. main checkout은 건드리지 않았습니다.
- 바뀐 파일이 모두 마크다운이라 구문 검사 도구가 없습니다. 그래서 Tier 1(수정한 줄 다시 읽기)로 확인했고, 위의 기계 점검을 더했습니다.
- 마지막 커밋 뒤 worktree에서 생성기를 다시 돌렸습니다. `git status`가 깨끗했습니다. 같은 커밋에서 다시 생성하면 같은 결과가 나옵니다.
- main은 `dd2c568`에서 `ae4668b`로 fast-forward했습니다. 그 뒤 worktree, 임시 브랜치, 복구 표지 파일을 지웠습니다. main checkout에서 커밋 전부터 있던 변경(`.planning/config.json`, `.planning/state.json`)은 손대지 않았습니다.

## 범위 밖으로 남긴 것

- `.planning/codebase/STACK.md`에도 같은 결함이 있습니다. 굵은 소제목 줄이 빠져서 `.claude/CLAUDE.md`의 Technology Stack 구간에 `- Not detected`처럼 무엇을 가리키는지 모르는 줄이 남습니다. WR-06이 STACK.md를 짚지 않았으므로 고치지 않았습니다. `TESTING.md`에 새로 넣은 줄은 STACK.md도 함께 다룹니다.
- 생성 구간의 빈 줄 배치가 일정하지 않습니다 (`## Logging` 바로 아래 목록, 목록 바로 뒤의 `## Function Design` 등). 생성기의 마크다운 정규화(`_normalizeMd`)는 이전 파일에서 바뀐 경계만 손봅니다. 그래서 생긴 모양이고 렌더링에는 영향이 없습니다. 생성 구간을 손으로 고치지 않는다는 규칙 때문에 그대로 두었습니다.

---

_Fixed: 2026-11-15T15:18:59Z_
_Fixer: Claude (gsd-code-fixer)_
_Iteration: 1_
