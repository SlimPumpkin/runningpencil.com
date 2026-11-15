---
phase: 01-ground-truth-policy-reset
fixed_at: 2026-11-15T10:35:37Z
review_path: .planning/phases/01-ground-truth-policy-reset/01-REVIEW.md
iteration: 1
findings_in_scope: 8
fixed: 8
skipped: 0
status: all_fixed
---

# Phase 1: Code Review Fix Report

**Fixed at:** 2026-11-15T10:35:37Z
**Source review:** .planning/phases/01-ground-truth-policy-reset/01-REVIEW.md
**Iteration:** 1

**Summary:**
- Findings in scope: 8 (WR-04, WR-05, IN-01~IN-06. 범위 `all`)
- Fixed: 8
- Skipped: 0

WR-01~WR-03은 앞선 처리(e8114d1 보고서)에서 이미 고쳤으므로 이번에는 건드리지 않았습니다. 이 보고서는 그 보고서를 덮어씁니다.

## Fixed Issues

### WR-04: 두 사본 비교 명령이 방침 구간을 찾지 못해도 「통과」로 끝남 (WR-03 수정의 빈틈)

**Files modified:** `.planning/codebase/TESTING.md`
**Commit:** d127c7c
**Applied fix:** 리뷰어가 준 서브셸 명령으로 바꿨습니다. 두 구간이 비어 있거나 「### 작업 규칙」이 없으면 `FAIL`을 찍고 종료 코드 1로 끝납니다. 명령 아래 설명도 고쳤습니다. 머리 문구, 「### 작업 규칙」 소제목, 마커를 바꾸면 명령도 함께 고친다고 적었습니다. 확인은 문서에서 명령을 그대로 뽑아 돌리는 방식으로 했습니다.
- 지금 파일에서는 bash와 zsh 모두 출력 없이 종료 코드 0이 나왔습니다.
- 머리 패턴을 없는 머리로 바꾸면 bash와 zsh 모두 `FAIL` 한 줄과 함께 종료 코드 1이 나왔습니다.
- 한 사본의 한 줄만 바꾼 복사본에서는 diff가 차이를 찍고 종료 코드 1이 나왔습니다.

### WR-05: 「`CLAUDE.md`도 함께 고친다」 규칙이 `.claude/CLAUDE.md` 생성 구간은 원본에서 고쳐야 한다는 점을 말하지 않음

**Files modified:** `CLAUDE.md`, `.claude/CLAUDE.md`
**Commit:** 141ec20
**Applied fix:** 두 사본의 같은 규칙 줄에 문장 하나를 같은 커밋에서 똑같이 더했습니다. 「`.claude/CLAUDE.md`의 `<!-- GSD:... -->` 구간은 직접 고치지 않고, 원본(`.planning/PROJECT.md`, `.planning/codebase/*.md`. 마커의 `source:`가 가리키는 파일)을 고친 뒤 `generate-claude-md`로 다시 만듭니다.」 문장 안에 마커 모양 글자가 들어가므로 두 가지를 확인했습니다. `generate-claude-md`를 다시 돌려도 이 줄과 생성 구간이 바뀌지 않았습니다. 이 줄은 `- `로 시작하므로 비교 명령의 `^<!-- GSD:` 끝 표지에 걸리지 않습니다.

### IN-01: `.claude/CLAUDE.md`의 `.gitignore` 요약이 이번 단계 변경을 반영하지 않음

**Files modified:** `.planning/codebase/STACK.md`, `.claude/CLAUDE.md` (다시 생성)
**Commit:** 24e31f2
**Applied fix:** `STACK.md`의 `.gitignore` 줄에 `.planning/research/.cache/`(GSD 연구 캐시)를 더한 뒤 `generate-claude-md`로 다시 만들었습니다. 다시 만든 결과에서 바뀐 줄은 그 한 줄뿐입니다.

### IN-02: 「연락은 공개 지원 이메일로만 받는다」가 현재 상태와 맞지 않음

**Files modified:** `.planning/codebase/CONVENTIONS.md`, `.claude/CLAUDE.md` (다시 생성)
**Commit:** 68e09f4
**Applied fix:** 문장을 「연락 수단은 이메일 게이트(Phase 5) 뒤 공개하는 지원 이메일 하나로 한다. 현재는 문의 채널이 없다 (2026-11 기준).」로 바꾸고 다시 만들었습니다. 같은 뜻의 `PROJECT.md:66`(Out of Scope 목록의 결정 문장)은 이 항목의 범위 밖이라 그대로 두었습니다.

### IN-03: 두 문서의 앱 설명이 서로 다름

**Files modified:** `.planning/PROJECT.md`, `.claude/CLAUDE.md` (다시 생성)
**Commit:** fd6504f
**Applied fix:** 루트 `CLAUDE.md`의 문장 「코스 모양 뱃지를 모으고, 직접 그린 코스를 공개할 수 있는 앱」을 기준으로 삼았습니다. `PROJECT.md:5`의 괄호 안을 이 문장으로 바꾸고 다시 만들었습니다. 근거는 기획 문서에 있습니다.
- `.planning/baseline/DATA-INVENTORY.md:181`: `courses` 행에 「사용자가 지도에 그린 코스」와 「공개로 바꾸면 다른 사용자에게 보임」이 있습니다.
- `.planning/ROADMAP.md:143`: Phase 6 기준 2에 「공개 코스」가 있습니다.
- `.planning/ROADMAP.md:173`: Phase 8 기준 1에 「코스 공개와 공개 후 수정 불가」가 있습니다.

새 기능을 지어내지 않았습니다. 이제 세 문서(`CLAUDE.md`, `.claude/CLAUDE.md`, `PROJECT.md`)의 설명이 같습니다.

### IN-04: 생성 구간의 줄 번호 하나와 명명 예시 파일이 실제와 다름 (이번 diff 밖, 원래 있던 문제)

**Files modified:** `.planning/codebase/CONVENTIONS.md`, `.planning/codebase/STRUCTURE.md`, `.planning/codebase/CONCERNS.md`, `.planning/codebase/ARCHITECTURE.md`, `.claude/CLAUDE.md` (다시 생성)
**Commit:** 270dcb6
**Applied fix:**
- **명명 예시:** `CONVENTIONS.md:13`의 `app-icon-512x512.png`를 실제 파일 `web-app-manifest-512x512.png`로 바꿨습니다. 「크기 접미사」 규칙에 맞는 파일을 골랐습니다. `apple-touch-icon.png`에는 크기 접미사가 없어서 고르지 않았습니다.
- **옛 아이콘 언급:** `STRUCTURE.md:43`의 「미추적 파일 존재」 줄을 지웠습니다. `CONCERNS.md`의 「미추적·미참조 아이콘 파일」 항목(31~35행)도 지웠습니다. `CONCERNS.md`에는 「해결」 표시를 남기는 형식이 없어서, 지금 남은 우려만 적는 문서 형식에 맞게 지웠습니다. 파일이 `prepare/old-app-icons/`로 옮겨진 것은 메인 체크아웃에서 확인했습니다. `prepare/`는 건드리지 않았습니다.
- **줄 번호:** `index.html`에서 `grep -n`으로 확인한 뒤 고쳤습니다.
  - `ARCHITECTURE.md:155` `moveTo`: `530-535`를 `526-531`로 고쳤습니다.
  - `ARCHITECTURE.md:156` `decodeURIComponent`: `629`를 `627`로 고쳤습니다.
  - `ARCHITECTURE.md:93` 해시 대상 기억: `628-629`를 `625-627`로 고쳤습니다.
- **다시 생성:** 생성기가 고친 구간(「Error Handling」)을 지금 버전의 형식으로 다시 쓰면서, `## Error Handling` 아래의 빈 줄 하나를 지웠습니다. 생성기는 머리줄과 목록 줄만 남기고 빈 줄은 넣지 않습니다. 원래 파일에 있던 빈 줄은 예전 생성 결과로 보입니다. 내용과 상관없는 변화라서, 마커 안을 손으로 고치지 않고 생성 결과 그대로 커밋했습니다.

### IN-05: 「주소는 `.planning/` 문서에만 있다」 문장은 사이트 기준으로만 맞음

**Files modified:** `CLAUDE.md`, `.claude/CLAUDE.md`, `.planning/codebase/CONVENTIONS.md`
**Commit:** 93cf876
**Applied fix:** 범위를 밝히는 문장만 바꿨습니다.
- 방침 표의 「지원 이메일 공개」 행 「현재 상태」 칸을 두 사본에서 같은 커밋으로 똑같이 고쳤습니다. 새 문장은 「사이트(HTML·`_data`)에는 아직 없고 `.planning/` 문서에만 있습니다. 저장소가 공개라 `.planning/` 문서의 주소는 GitHub에서 누구나 볼 수 있습니다」입니다. 표의 열 수가 그대로인 것을 확인했습니다.
- 생성 구간은 `CONVENTIONS.md:146`을 같은 뜻으로 고친 뒤 다시 만들었습니다. 「HTML·`_data`에 넣지 않는 규칙은 사이트 노출만 막는다」는 문장도 더했습니다.
- 주소 자체는 어디에도 쓰지 않았습니다. `.planning/baseline/NAMES.md`는 건드리지 않았습니다.

### IN-06: 「Deploy」 구간의 「Phase 2까지 유효」가 새 작업 규칙 「`main` 푸시가 곧 배포」와 다르게 읽힘

**Files modified:** `CLAUDE.md`
**Commit:** f4861dd
**Applied fix:** 루트 `CLAUDE.md` Deploy 문단을 리뷰어가 제안한 문장대로 고쳤습니다. 「CI가 없으므로 커밋이 곧 배포입니다. 현재는 로컬 빌드 스텝도 없습니다 (2026-11 기준, Phase 2까지 유효).」 이제 괄호는 로컬 빌드 스텝 문장에만 걸립니다. Deploy 구간은 루트 `CLAUDE.md`에만 있어서 `.claude/CLAUDE.md`는 바꾸지 않았습니다.

## 남은 참고 사항 (이번 범위 밖)

- `ARCHITECTURE.md:94`의 `settle()` 인용 `index.html:630-637`은 범위가 조금 어긋납니다. 실제 `settle` 정의는 628~632행이고, `load`·`document.fonts.ready` 연결은 636~637행입니다. 리뷰가 지목한 줄이 아니어서 고치지 않았습니다. 생성된 `.claude/CLAUDE.md`에는 나오지 않습니다.

## Verification

- **실행 위치:** 고치기, 다시 생성하기, 확인은 모두 격리 작업 트리(`.claude/worktrees/rf-01-91662-1794738573`, 브랜치 `gsd-reviewfix/01-91662`)에서 했습니다. 정리 단계에서 `main`을 fast-forward한 뒤 메인 체크아웃에서 두 사본 비교와 이메일 grep을 다시 돌렸습니다.
- **생성기 기준선:** 고치기 전에 작업 트리에서 `generate-claude-md`를 돌렸을 때 `.claude/CLAUDE.md`는 바뀌지 않았습니다. 원본을 고칠 때마다 다시 만든 결과에는 고친 줄만 바뀌었습니다 (IN-04의 빈 줄 하나는 위에 적었습니다). 마지막 커밋 뒤에 한 번 더 돌렸을 때도 바뀐 파일이 없었습니다.
- **두 사본 일치:** 커밋할 때마다 WR-04에서 고친 비교 명령을 돌렸습니다. 매번 출력 없이 종료 코드 0이 나왔습니다.
- **이메일 미노출:** 커밋할 때마다 `grep -nE '@[a-z0-9.-]+\.(com|kr)' CLAUDE.md .claude/CLAUDE.md`를 돌렸습니다. 매번 결과가 없었습니다.
- **다시 읽기:** 고친 줄은 모두 다시 읽어 확인했습니다. 마커 안을 손으로 고치지 않았습니다.
- **린터:** 이 저장소에는 린터가 없어 돌리지 않았습니다.
- **스테이징:** 파일 경로를 하나씩 지정해서만 스테이징했습니다. 작업 전부터 있던 `.planning/config.json`(수정됨)과 `.planning/state.json`(추적 안 됨)은 커밋하지 않았습니다. `prepare/`는 건드리지 않았습니다. 푸시하지 않았습니다.

---

_Fixed: 2026-11-15T10:35:37Z_
_Fixer: Claude (gsd-code-fixer)_
_Iteration: 1_
