---
phase: 01-ground-truth-policy-reset
reviewed: 2026-11-15T08:10:27Z
depth: standard
files_reviewed: 3
files_reviewed_list:
  - .claude/CLAUDE.md
  - .gitignore
  - CLAUDE.md
findings:
  critical: 0
  warning: 3
  info: 5
  total: 8
  necessity: 0
status: issues_found
---

# Phase 1: Code Review Report

**Reviewed:** 2026-11-15T08:10:27Z
**Depth:** standard
**Files Reviewed:** 3
**Status:** issues_found

## Summary

이번 단계에서 바뀐 파일은 프로젝트 안내 문서 두 개(`CLAUDE.md`, `.claude/CLAUDE.md`)와 `.gitignore`입니다. HTML·CSS·JS는 바뀌지 않았습니다. 세 파일을 끝까지 읽고 아래 항목을 대조했습니다.

- **방침 구간 일치:** 두 문서의 「이번 마일스톤 방침」 구간(`CLAUDE.md:5-30`, `.claude/CLAUDE.md:1-26`)을 줄 단위 `diff`로 비교했습니다. 차이는 0입니다.
- **생성기 동작:** `generate-claude-md`의 `updateSection`은 GSD 마커 사이만 바꿉니다. 첫 마커 위에 손으로 쓴 방침 구간은 다시 생성해도 남습니다. 생성 원본 `.planning/codebase/CONVENTIONS.md:142-147`에도 새 규칙 문장이 들어 있습니다. 그래서 다시 생성해도 옛 방침(「RunningPencil 쓰지 않음」, 「연락처 이메일 넣지 않음」, 「noindex 유지」)으로 돌아가지 않습니다.
- **「현재 상태」 문장과 실제 사이트:**
  - `noindex`와 「임시 게시본」은 법적 페이지 3종에 있고 `index.html`에는 없습니다.
  - 「포인트」「굿즈」「코스북」은 랜딩과 법적 문서에 남아 있습니다.
  - 네 페이지 모두 `lang="ko"`입니다.
  - `_data/` 디렉터리는 없습니다.
  - `.planning/` 밖의 추적 파일 전체를 `git grep`으로 검사했습니다. 이메일 주소 형식의 문자열이 없습니다.
  - 사업자등록번호 형식은 저장소 전체에서 한 곳만 나옵니다. `.planning/research/ARCHITECTURE.md`가 피해야 할 자리표시 예시로 든 값입니다. 그래서 「값은 어디에도 없습니다」라는 문장과 맞습니다.
- **출처 인용:** 다음 인용이 실제 문서와 맞습니다.
  - `PROJECT.md` Key Decisions: 각 행의 결정
  - `REQUIREMENTS.md` Out of Scope: 이메일 수집 폼 제외
  - `ROADMAP.md`: Ground Rules, Phase 6·7·8 Notes, 「외부 4곳」(`ROADMAP.md:130`)
  - `DECISIONS.md`: U10·U14
  - `URLS.md`: `/support/`·`/en/`

  `.planning/baseline/` 다섯 문서는 모두 있습니다. 다만 `NAMES.md`·`USER-TASKS.md`·`DATA-INVENTORY.md`는 있는지만 확인했고, 본문은 열어 보지 않았습니다.
- **`.gitignore:11`:** `.planning/research/.cache/` 아래에 이미 추적되던 파일이 없습니다 (`git ls-files` 기준). 새 무시 규칙은 의도대로 동작합니다.

보안 문제와 잘못 적힌 사실값은 찾지 못했습니다. 주요 문제는 두 가지입니다.

- 「작업 규칙」이 원본이라고 밝힌 `ROADMAP.md` Ground Rules와 내용이 다릅니다. 특히 「값이 없으면 숨긴다」 규칙에 붙어 있던 단서(빠지면 안 되는 조항은 커밋 보류)가 빠졌습니다.
- 같은 구간을 두 파일에 복사해 두었는데, 어긋남은 이번 단계에서 한 번만 확인했고 반복해서 확인할 장치가 없습니다.

필요성(Necessity) 기준(`necessity-review.md`)도 검토했지만 해당 사항은 없습니다. 이번 변경은 문서뿐이라 실행되는 방어 코드가 없기 때문입니다.

## Narrative Findings (AI reviewer)

아래는 세 파일을 직접 읽고 원본 문서·사이트 파일과 대조해서 찾은 문제입니다. 구조 분석(fallow) 결과는 받지 않았으므로 해당 구간은 없습니다.

## Warnings

### WR-01: 「작업 규칙」에서 「빠지면 안 되는 조항은 값이 올 때까지 커밋 보류」 단서가 빠짐

**File:** `CLAUDE.md:23` (같은 문장 `.claude/CLAUDE.md:19`)
**Issue:** 두 문서의 「작업 규칙」은 사용자가 줄 사실값이 없으면 「행·문단을 숨깁니다 (render-if-present)」라고만 씁니다. 그런데 이 구간이 원본이라고 밝힌 `ROADMAP.md:15`의 Ground Rules에는 단서가 하나 더 붙어 있습니다. 「빠지면 안 되는 조항이 있는 페이지는 값이 올 때까지 커밋을 보류합니다.」 이 단서가 문서에 없습니다.

「작업 규칙」은 「GSD 밖에서 연 세션과 다른 도구도 지킵니다」(`CLAUDE.md:21`)라고 적혀 있습니다. 그래서 `ROADMAP.md`를 읽지 않는 세션은 이 문서만 근거로 삼습니다. 그런 세션에서는 법정 필수 항목의 값이 없을 때, 문단을 숨긴 채 커밋하는 것이 규칙에 맞는 행동이 됩니다. 법정 필수 항목의 예는 개인정보처리방침의 보호책임자 연락처, 위치기반서비스 이용약관의 사업자 상호·주소·연락처(`ROADMAP.md` Phase 8 성공 기준 2, 위치정보법 제19조①)입니다. 이 저장소는 `main` 푸시가 곧 배포이므로, 필수 조항이 빠진 법적 문서가 그대로 공개되어 심사 반려 사유가 될 수 있습니다.

계획 단계에서 생긴 누락입니다. `01-06-PLAN.md:25`가 Ground Rules에서 여섯 규칙을 골라 옮기면서 이 단서를 넣지 않았습니다.
**Fix:** 두 파일의 해당 줄을 Ground Rules와 같은 뜻으로 맞춥니다.
```markdown
- 사용자가 줄 사실값(사업자 정보, 지원 이메일, 보호책임자)은 추측해서 채우지 않습니다. 값이 없으면 행·문단을 숨깁니다 (render-if-present). 단, 빠지면 안 되는 조항(처리방침의 보호책임자, 위치약관의 사업자 상호·주소·연락처 등)이 있는 페이지는 값이 올 때까지 커밋을 보류합니다.
```

### WR-02: 「원본은 Ground Rules」라고 밝혔지만 규칙 목록이 원본과 다름

**File:** `CLAUDE.md:19-30` (같은 내용 `.claude/CLAUDE.md:15-26`)
**Issue:** `CLAUDE.md:30`은 「원본은 `.planning/ROADMAP.md`의 Ground Rules입니다」라고 적습니다. 그런데 `ROADMAP.md:7-17`과 비교하면 WR-01 말고도 다음 차이가 있습니다.
- **빠진 규칙 (`ROADMAP.md:11-12`):** 모든 단계는 그대로 라이브에 올라가도 되는 상태로 끝냅니다. 배포할 때마다 세 법적 URL이 200과 같은 문서 제목을 돌려주는지 확인합니다. (「`main` 푸시가 곧 배포」라는 사실 자체는 `CLAUDE.md:104`에 있습니다.)
- **빠진 규칙 (`ROADMAP.md:14`):** Phase 2 이후에는 푸시 전에 **로컬 Jekyll 3.10.0** 빌드가 성공하는지 확인합니다. `CLAUDE.md:36`과 `CLAUDE.md:68`은 「로컬 Jekyll 빌드」라고만 쓰고 버전 고정은 적지 않습니다.
- **빠진 규칙 (`ROADMAP.md:17`):** 방침이나 구조를 바꾸는 단계는 그 단계 안에서 `CLAUDE.md`도 함께 고칩니다. Phase 2·3·5·9가 이 문서의 「현재 상태」 문장을 바꿔야 합니다. 이 규칙이 빠지면 날짜 붙은 상태 문장이 그대로 낡아 갈 위험이 큽니다.
- **원본에 없는 규칙 (`CLAUDE.md:27`):** 「법적 본문에는 데이터 목록에 있는 사실만 씁니다」는 Ground Rules에 없습니다. 이 규칙의 근거는 `ROADMAP.md`의 Phase 6·7 성공 기준과 PROJECT Constraints입니다.

이대로 두면 두 목록이 다를 때 어느 쪽을 따를지 정할 수 없습니다. 이 문서가 스스로 「원본」은 Ground Rules라고 밝혀 두었기 때문입니다.
**Fix:** 둘 중 하나를 고릅니다.
1. 빠진 세 규칙을 「작업 규칙」에 더하고, 데이터 목록 규칙에는 실제 출처를 붙입니다.
2. `CLAUDE.md:30`을 「원본(전체 목록)은 `.planning/ROADMAP.md`의 Ground Rules이고, 여기에는 사이트 편집에 바로 쓰는 규칙만 옮겼습니다」처럼 발췌본이라고 밝힙니다.

사이트 바깥 세션도 이 규칙을 지켜야 하므로 1번을 권합니다.

### WR-03: 두 파일에 복사한 방침 구간의 일치를 이번 단계에서 한 번만 확인했고 반복 확인 절차가 없음

**File:** `CLAUDE.md:7` / `.claude/CLAUDE.md:3`
**Issue:** 「이 구간은 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`에 같은 내용으로 둡니다」라는 약속은 이번 단계에서 한 번 확인했습니다 (`01-06-PLAN.md:28`, `01-06-SUMMARY.md:50`). 하지만 이 확인은 단계 계획 안의 일회성 검사입니다. 앞으로 계속 쓰는 확인 절차(`.planning/codebase/TESTING.md`)에는 두 사본을 비교하는 항목이 없습니다 (`CLAUDE.md` 검색 결과 0건). `01-VALIDATION.md:58`의 검사는 생성기를 다시 돌려도 결과가 같은지만 보고, 두 파일을 서로 비교하지 않습니다.

Ground Rules(`ROADMAP.md:17`)에 따라 Phase 2·3·5·9가 이 구간의 「현재 상태」 열을 계속 고쳐야 합니다. `generate-claude-md`는 마커 밖을 건드리지 않으므로 생성기가 동기화해 주지도 않습니다. 이 프로젝트가 Jekyll 전환으로 줄이려는 것이 바로 「복사한 공통 블록이 어긋날 위험」(`CLAUDE.md:15`)입니다. 같은 위험을 안내 문서에 새로 만든 셈입니다. Claude Code는 두 파일을 모두 읽으므로, 사본이 어긋나면 한 세션 안에 서로 다른 방침 두 개가 들어갑니다.
**Fix:** `TESTING.md`의 푸시 전 확인에 비교 명령 하나를 넣고, 방침을 고치는 단계의 완료 기준으로 삼습니다.
```bash
# 두 사본의 「이번 마일스톤 방침」 구간이 같은지 확인. 출력이 없으면 통과
diff <(sed -n '/^## 이번 마일스톤 방침/,/^## Repository purpose/p' CLAUDE.md | sed '$d') \
     <(sed -n '/^## 이번 마일스톤 방침/,/^<!-- GSD:/p' .claude/CLAUDE.md | sed '$d')
```
사본을 아예 하나로 줄이는 방법도 있습니다. 그때는 `.claude/CLAUDE.md`에 「루트 `CLAUDE.md`의 방침 구간을 따른다」는 한 줄만 둡니다.

## Info

### IN-01: `.claude/CLAUDE.md`의 `.gitignore` 요약이 이번 단계 변경을 반영하지 않음

**File:** `.claude/CLAUDE.md:90` (생성 원본 `.planning/codebase/STACK.md:64`)
**Issue:** 요약에는 `prepare/`, `.DS_Store`, `.playwright-mcp/` 세 항목만 있습니다. 같은 단계에서 `.gitignore:10-11`에 `.planning/research/.cache/`가 더해졌습니다. 원본 `STACK.md`가 고쳐지지 않았으므로 다시 생성해도 낡은 요약이 그대로 나옵니다.
**Fix:** `STACK.md:64`에 `.planning/research/.cache/`(GSD 연구 캐시)를 더한 뒤 `generate-claude-md`로 다시 생성합니다.

### IN-02: 「연락은 공개 지원 이메일로만 받는다」가 현재 상태와 맞지 않음

**File:** `.claude/CLAUDE.md:193` (생성 원본 `.planning/codebase/CONVENTIONS.md:145`)
**Issue:** 이 문장은 현재형인데, 바로 다음 줄(`:194`)은 「현재 사이트에는 지원 이메일이 없다」입니다. `CONCERNS.md:123`도 「현재 문의 채널이 없음」이라고 적습니다. 방침 구간은 「이 구간 아래의 설명은 지금 코드의 실제 모습」(`CLAUDE.md:7`)이라고 약속하므로, 이 문장은 그 약속과 어긋납니다.
**Fix:** 「연락 수단은 이메일 게이트(Phase 5) 뒤 공개하는 지원 이메일 하나로 한다. 현재는 문의 채널이 없다 (2026-11 기준).」처럼 적용 시점을 밝힙니다. `CONVENTIONS.md`를 고친 뒤 다시 생성합니다.

### IN-03: 두 문서의 앱 설명이 서로 다름

**File:** `CLAUDE.md:34` / `.claude/CLAUDE.md:34`
**Issue:** 두 문서가 앱을 다르게 설명합니다.
- 루트 `CLAUDE.md`: 「코스 모양 뱃지를 모으고, 직접 그린 코스를 공개할 수 있는 앱」
- `.claude/CLAUDE.md`(`PROJECT.md`에서 생성): 「코스 모양 뱃지를 모으는 앱」

심사에서는 사이트와 앱이 일치하는지 봅니다. Phase 4에서 소개 문구를 고칠 때 어느 쪽을 기준으로 삼을지 헷갈릴 수 있습니다.
**Fix:** 기준 설명 하나를 정해 `PROJECT.md`와 루트 `CLAUDE.md`를 같은 문장으로 맞춥니다. 코스 공개 기능은 `ROADMAP.md` Phase 6·8 기준에 있습니다.

### IN-04: 생성 구간의 줄 번호 하나와 명명 예시 파일이 실제와 다름 (이번 diff 밖, 원래 있던 문제)

**File:** `.claude/CLAUDE.md:290`, `.claude/CLAUDE.md:108`
**Issue:**
- `:290`은 `decodeURIComponent` 실패 무시를 `index.html:629`라고 적었지만, 실제로는 627행입니다. 다른 줄 번호는 맞습니다. IIFE 시작은 497행이고, `moveTo`의 `catch`는 530행입니다.
- `:108`의 명명 예시 `app-icon-512x512.png`는 커밋되지 않은 파일입니다. `favicon/app-icon-*.png` 네 개가 작업 트리에 추적되지 않은 채로 있고, `.gitignore`에도 없습니다. 이대로 `git add -A`를 하면 사이트(`/favicon/`)에 함께 공개됩니다.

이번 단계에서 바뀐 줄은 아니지만, 이번에 다시 생성한 파일에 남아 있습니다.
**Fix:** `ARCHITECTURE.md`의 해당 줄 번호를 627로 고치거나, 줄 번호 대신 식별자(`settle` 등)로 가리킵니다. app-icon 파일은 커밋할지 `prepare/`로 옮길지 정합니다.

### IN-05: 「주소는 `.planning/` 문서에만 있다」 문장은 사이트 기준으로만 맞음

**File:** `CLAUDE.md:12` (같은 내용 `.claude/CLAUDE.md:8`, `.claude/CLAUDE.md:194`)
**Issue:** `.planning/baseline/NAMES.md`는 커밋된 파일이고 저장소는 공개입니다. 그래서 지원 주소는 이메일 게이트 전에도 GitHub에서 누구나 볼 수 있습니다. `_config.yml:13`은 `.planning/`을 사이트 빌드에서만 뺍니다.

게이트의 목적은 수신 시험이지 비공개 유지가 아니므로 결함은 아닙니다. 다만 「HTML·`_data`에 넣지 않는다」는 규칙이 주소 공개를 막아 준다고 오해할 수 있습니다.
**Fix:** 「사이트(HTML·`_data`)에는 아직 없습니다. 저장소가 공개라 `.planning/` 문서의 주소는 GitHub에서 보입니다.」처럼 범위를 밝힙니다. 주소를 공개하기 전에 스팸 노출을 줄여야 한다면, `NAMES.md`의 주소 표기 방식을 바꾸는 것도 검토합니다.

---

_Reviewed: 2026-11-15T08:10:27Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
