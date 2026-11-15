---
phase: 01-ground-truth-policy-reset
fixed_at: 2026-11-15T09:35:00Z
review_path: .planning/phases/01-ground-truth-policy-reset/01-REVIEW.md
iteration: 1
findings_in_scope: 3
fixed: 3
skipped: 0
status: all_fixed
---

# Phase 1: Code Review Fix Report

**Fixed at:** 2026-11-15T09:35:00Z
**Source review:** .planning/phases/01-ground-truth-policy-reset/01-REVIEW.md
**Iteration:** 1

**Summary:**
- Findings in scope: 3 (WR-01, WR-02, WR-03. 범위 `critical_warning`)
- Fixed: 3
- Skipped: 0

범위 밖인 IN-01~IN-05는 건드리지 않았고 REVIEW.md에 그대로 남아 있습니다.

## Fixed Issues

### WR-01: 「작업 규칙」에서 「빠지면 안 되는 조항은 값이 올 때까지 커밋 보류」 단서가 빠짐

**Files modified:** `CLAUDE.md`, `.claude/CLAUDE.md`
**Commit:** eb1e83d (WR-02와 같은 커밋)
**Applied fix:** render-if-present 규칙 끝에 「단, 빠지면 안 되는 조항이 있는 페이지는 값이 올 때까지 커밋을 보류합니다」를 더했습니다. 예시(처리방침의 보호책임자, 위치기반서비스 이용약관의 사업자 상호·주소·연락처)는 괄호로 문장 뒤에 붙였습니다. 그래서 Ground Rules와 같은 문장이 끊기지 않고 그대로 남습니다. 두 파일에서 이 문장은 한 번씩만 나옵니다 (`grep -c` 결과 각각 1).

### WR-02: 「원본은 Ground Rules」라고 밝혔지만 규칙 목록이 원본과 다름

**Files modified:** `CLAUDE.md`, `.claude/CLAUDE.md`
**Commit:** eb1e83d (WR-01과 같은 커밋)
**Applied fix:** 리뷰어가 권한 1번 방법을 따랐습니다. 「작업 규칙」을 `ROADMAP.md` Ground Rules(7~17행)의 순서와 내용에 맞췄습니다.
- 빠진 규칙 세 개를 더했습니다.
  - `main` 푸시가 곧 배포이므로, 모든 단계는 그대로 라이브에 올라가도 되는 상태로 끝냅니다.
  - Phase 2 이후에는 푸시 전에 로컬 Jekyll 3.10.0 빌드가 성공하는지 확인합니다.
  - 방침이나 구조를 바꾸는 단계는 그 단계 안에서 `CLAUDE.md`도 함께 고칩니다. 두 사본을 같은 커밋에서 똑같이 고친다는 문장도 함께 넣었습니다.
- 「배포할 때마다 세 법적 URL이 200과 같은 문서 제목을 돌려주는지 확인」은 기존 URL 규칙에 이어 붙였습니다.
- 데이터 목록 규칙은 그대로 두었습니다. 대신 실제 출처를 붙였습니다 (`ROADMAP.md` Phase 6·7 성공 기준, `PROJECT.md` Constraints의 Legal drafts).
- 끝 문장을 「마지막 규칙(데이터 목록)을 뺀 나머지 규칙의 원본은 `.planning/ROADMAP.md`의 Ground Rules입니다」로 고쳤습니다.

WR-01과 WR-02는 같은 목록을 고치므로 한 커밋으로 묶었습니다. 이 커밋 뒤 두 사본의 방침 구간은 30줄씩이고 diff 결과가 같습니다.

### WR-03: 두 파일에 복사한 방침 구간의 일치를 이번 단계에서 한 번만 확인했고 반복 확인 절차가 없음

**Files modified:** `.planning/codebase/TESTING.md`
**Commit:** 8a0c420
**Applied fix:** 「수동 점검 목록」에 9번 항목 「`CLAUDE.md` 두 사본의 방침 구간 일치」를 더했습니다. 방침 구간을 고친 단계는 이 확인을 통과해야 끝난다고 적었습니다. 「Common Patterns」에는 리뷰어가 준 diff 명령을 기존 「공유 블록 일치 확인」과 같은 형식으로 넣었습니다. 비교 범위와 `generate-claude-md`가 두 사본을 맞춰 주지 않는다는 설명도 함께 적었습니다. `.claude/CLAUDE.md`를 한 줄 안내로 줄이는 방법은 쓰지 않았습니다. 「같은 내용으로 둡니다」 규칙과 맞지 않기 때문입니다.

## Verification

- **실행 위치:** 고치기와 확인은 격리 작업 트리(`.claude/worktrees/rf-01-58123-1794734855`, 브랜치 `gsd-reviewfix/01-58123`)에서 했습니다. 정리 단계에서 `main`을 fast-forward한 뒤, 메인 체크아웃에서도 같은 diff 명령을 다시 돌렸습니다.
- **두 사본 일치:** 위 diff 명령을 bash와 zsh에서 돌렸고, 두 번 모두 출력 없이 종료 코드 0이 나왔습니다. 뽑은 구간이 비어 있어서 통과한 것이 아닌지도 확인했습니다 (두 파일 모두 30줄).
- **단서 문장:** 「빠지면 안 되는 조항이 있는 페이지는 값이 올 때까지 커밋을 보류합니다」가 두 파일에 한 번씩만 나옵니다.
- **고친 부분 다시 읽기:** 고친 부분을 다시 읽어 확인했습니다. `.claude/CLAUDE.md`의 `<!-- GSD:... -->` 생성 구간은 건드리지 않았고, `generate-claude-md`도 돌리지 않았습니다.
- **린터:** 이 저장소에는 린터가 없어 돌리지 않았습니다.
- **스테이징:** 파일 경로를 하나씩 지정해서만 스테이징했습니다. 작업 전부터 있던 `.planning/config.json`(수정됨)과 `.planning/state.json`(추적 안 됨)은 커밋하지 않았습니다. 푸시하지 않았습니다.

---

_Fixed: 2026-11-15T09:35:00Z_
_Fixer: Claude (gsd-code-fixer)_
_Iteration: 1_
