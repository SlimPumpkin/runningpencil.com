---
phase: 01-ground-truth-policy-reset
reviewed: 2026-11-15T10:25:10Z
depth: standard
files_reviewed: 2
files_reviewed_list:
  - .claude/CLAUDE.md
  - CLAUDE.md
findings:
  critical: 0
  warning: 2
  info: 6
  total: 8
  necessity: 0
status: issues_found
---

# Phase 1: Code Review Report

**Reviewed:** 2026-11-15T10:25:10Z
**Depth:** standard
**Files Reviewed:** 2
**Status:** issues_found

## Summary

첫 리뷰(7c5ae05) 뒤에 고친 내용을 다시 검토했습니다. 대상은 프로젝트 안내 문서 두 개(`CLAUDE.md`, `.claude/CLAUDE.md`)입니다. WR-03을 고치면서 바뀐 `.planning/codebase/TESTING.md`도 함께 확인했습니다. `7c5ae05..HEAD` 사이에 HTML·CSS·JS는 바뀌지 않았습니다. 두 문서를 끝까지 다시 읽었습니다. 「작업 규칙」 아래 줄이 세 줄 늘어서, 그 뒤의 줄 번호는 모두 첫 리뷰보다 3씩 큽니다.

**고친 항목 확인 (WR-01·WR-02·WR-03):** 세 항목 모두 제대로 고쳐졌습니다. 이 ID는 처리 기록(`01-REVIEW-DISPOSITION.md`)에 `fixed`로 남아 있으므로 아래 본문에 다시 쓰지 않습니다.

- **WR-01:** 단서 문장이 두 사본에 한 번씩 들어갔습니다 (`CLAUDE.md:27`, `.claude/CLAUDE.md:23`). 「빠지면 안 되는 조항이 있는 페이지는 값이 올 때까지 커밋을 보류합니다」라는 문장이 `ROADMAP.md:15`와 같습니다.
- **WR-02:** `ROADMAP.md:11-17`의 Ground Rules를 한 줄씩 대조했습니다. 일곱 규칙이 모두 「작업 규칙」에 있습니다. 순서도 같습니다. `ROADMAP.md:16`의 묶음 규칙은 두 줄로 나뉘었는데, 뜻은 같습니다. 원본과 다른 곳은 세 군데이고, 셋 다 결함으로 보지 않았습니다.
  - `ROADMAP.md:12` 끝 문장 「마일스톤 전체 URL 확인은 Phase 10에서 합니다」가 빠졌습니다. Phase 10 계획에 이미 있는 일정 안내라서, 여기 없어도 세션의 행동이 달라지지 않습니다.
  - `CLAUDE.md:30`에 「두 사본을 같은 커밋에서 똑같이 고칩니다」라는 문장이 더해졌습니다. Ground Rules에는 없는 문장인데, `CLAUDE.md:33`은 마지막 규칙만 출처가 다르다고 적습니다. 다만 같은 구간 머리(`CLAUDE.md:7`)의 약속을 되풀이한 문장이라서, 따로 출처가 필요하지 않습니다.
  - 데이터 목록 규칙에 붙은 출처(`CLAUDE.md:31`)를 확인했습니다. `ROADMAP.md:143`(Phase 6 기준 2)과 `ROADMAP.md:157`(Phase 7 기준 1)이 실제로 「데이터 목록과 일치」를 요구합니다. `PROJECT.md:92`(Legal drafts)는 「앱 코드에서 확인한 사실」이라고 쓰는데, 데이터 목록이 앱 코드를 근거로 만든 표이므로 출처로 맞습니다.
- **WR-03:** `TESTING.md:67-68`(점검 목록 9)과 `TESTING.md:121-128`(비교 명령)가 들어갔습니다. 그 명령을 bash로 돌리면 출력 없이 종료 코드 0이 나옵니다. 두 사본은 지금 같습니다. 다만 이 명령에는 구멍이 하나 있어서 WR-04로 새로 적었습니다.

**열려 있던 항목 다시 확인 (IN-01~IN-05):** 다섯 항목 모두 아직 유효해서 같은 ID로 남겼습니다. 줄 번호와 내용은 지금 파일에 맞게 고쳤습니다.

- **IN-04:** 반쯤 풀렸습니다. 사용자가 `favicon/app-icon-*.png` 네 개를 무시 대상인 `prepare/old-app-icons/`로 옮겼습니다. 그래서 「이대로 `git add -A`를 하면 사이트에 공개된다」는 위험은 없어졌습니다. 지금 `git status`에서 `favicon/` 아래에 추적되지 않은 파일은 없습니다. 하지만 문서는 여전히 그 파일을 예로 듭니다. 첫 리뷰가 놓친 줄 번호 하나도 더 찾았습니다. 그래서 IN-04는 남겨 두고 본문만 바꿨습니다.
- **IN-05:** `gh repo view`로 저장소가 `PUBLIC`인 것을 확인했습니다. `NAMES.md`가 추적 중인 파일이라는 것도 확인했습니다 (`git ls-files`). `NAMES.md`에 이메일 형식 문자열이 1건 있다는 것은 개수만 세어 확인했고, 주소 자체는 출력하지 않았습니다. 그래서 첫 리뷰에서 확인하지 못한 부분이 이제 확인되었습니다.

**새로 찾은 문제:** 두 가지를 경고로 올렸습니다.

- WR-04: 두 사본 비교 명령이 아무것도 비교하지 않고도 통과할 수 있습니다.
- WR-05: 「`CLAUDE.md`도 함께 고친다」는 규칙에 생성 구간을 어디서 고칠지가 빠져 있습니다.

정보 항목(IN-06)도 하나 더했습니다.

보안 문제와 잘못 적힌 사실값은 찾지 못했습니다. `.planning/` 밖의 추적 파일에는 이메일 형식 문자열이 없습니다 (`git grep -l` 0건).

필요성(Necessity) 기준(`necessity-review.md`)도 검토했지만 해당 사항은 없습니다. 바뀐 것은 문서뿐이라 실행되는 방어 코드가 없기 때문입니다.

## Narrative Findings (AI reviewer)

아래는 두 문서를 직접 읽고 원본 문서·사이트 파일과 대조해서 찾은 문제입니다. 구조 분석(fallow) 결과는 받지 않았으므로 해당 구간은 없습니다. 생성 구간(`<!-- GSD:... -->` 안)의 문제는 고칠 곳으로 생성 원본의 파일과 줄을 적었습니다.

## Warnings

### WR-04: 두 사본 비교 명령이 방침 구간을 찾지 못해도 「통과」로 끝남 (WR-03 수정의 빈틈)

**File:** `.planning/codebase/TESTING.md:121-128` (관련 규칙 `CLAUDE.md:30`, `.claude/CLAUDE.md:26`)
**Issue:** WR-03을 고치면서 넣은 명령은 두 파일에서 각각 `sed -n '/^## 이번 마일스톤 방침/,…/p'`로 구간을 뽑은 뒤 `diff`합니다. 그런데 두 파일 모두 머리 문구가 맞지 않으면 두 출력이 모두 빈 문자열이 됩니다. 그러면 `diff`는 아무 출력 없이 종료 코드 0으로 끝납니다. 직접 돌려 보니, 없는 머리(`## 없는머리`)를 넣어도 `rc=0`이 나왔습니다. 「출력이 없으면 통과」(`TESTING.md:123`)라는 기준으로는 실패를 알 수 없습니다.

이 상황은 실제로 일어나기 쉽습니다. `CLAUDE.md:30`은 방침 구간을 「두 사본을 같은 커밋에서 똑같이 고칩니다」라고 정합니다. 그래서 머리 문구를 바꾸는 커밋은 규칙대로 두 파일을 함께 바꾸게 됩니다. 마일스톤이 바뀌어 `## 이번 마일스톤 방침 (2026-11 결정)`을 다른 이름으로 바꾸는 경우가 그렇습니다. 그 순간부터 이 점검은 항상 통과합니다. `TESTING.md:127`의 「머리 문구나 마커가 바뀌면 이 명령도 고친다」는 사람이 기억해야 하는 메모일 뿐이고, 명령이 스스로 막아 주지 않습니다. 고친 사람도 이 위험을 알았습니다. 그래서 「두 파일 모두 30줄」인지 손으로 확인했지만(`01-REVIEW-FIX.md:57`), 그 확인을 명령에는 넣지 않았습니다.

(끝 표지가 바뀌는 경우는 문제가 없습니다. 예를 들어 루트의 `## Repository purpose`가 바뀌면 루트 쪽 구간이 파일 끝까지 늘어나므로, `diff`가 차이를 출력하고 실패합니다.)
**Fix:** 두 구간이 비어 있지 않고 「작업 규칙」을 포함하는지 먼저 확인한 뒤 비교합니다. 아래 명령을 이 문서에서 그대로 뽑아 bash와 zsh에서 돌려 확인했습니다. 지금 파일에서는 출력 없이 종료 코드 0이 나옵니다. 두 머리 패턴을 없는 머리로 바꾸면 `FAIL` 한 줄과 함께 종료 코드 1이 나옵니다.
```bash
# 두 사본의 「이번 마일스톤 방침」 구간이 같은지 확인. 출력이 없으면 통과, FAIL이 나오면 머리 문구·마커부터 확인
# 서브셸 ( ) 안에서 돌리므로 터미널에 붙여 넣어도 exit가 창을 닫지 않는다
(
  a=$(sed -n '/^## 이번 마일스톤 방침/,/^## Repository purpose/p' CLAUDE.md | sed '$d')
  b=$(sed -n '/^## 이번 마일스톤 방침/,/^<!-- GSD:/p' .claude/CLAUDE.md | sed '$d')
  case "$a" in *'### 작업 규칙'*) ;; *) echo 'FAIL: 루트 CLAUDE.md에서 방침 구간을 찾지 못함'; exit 1 ;; esac
  case "$b" in *'### 작업 규칙'*) ;; *) echo 'FAIL: .claude/CLAUDE.md에서 방침 구간을 찾지 못함'; exit 1 ;; esac
  diff <(printf '%s\n' "$a") <(printf '%s\n' "$b")
)
```

### WR-05: 「`CLAUDE.md`도 함께 고친다」 규칙이 `.claude/CLAUDE.md` 생성 구간은 원본에서 고쳐야 한다는 점을 말하지 않음

**File:** `CLAUDE.md:30` (같은 문장 `.claude/CLAUDE.md:26`)
**Issue:** WR-02를 고치면서 「방침이나 구조를 바꾸는 단계는 그 단계 안에서 `CLAUDE.md`도 함께 고칩니다」가 들어갔습니다. 덧붙인 문장(「두 사본을 같은 커밋에서 똑같이 고칩니다」)은 맨 위 방침 구간만 다룹니다. 그런데 `.claude/CLAUDE.md`는 31행부터 끝(329행)까지가 `<!-- GSD:... -->` 생성 구간입니다. 이 구간은 `.planning/PROJECT.md`와 `.planning/codebase/*.md`에서 `generate-claude-md`로 만듭니다. 규칙을 문장 그대로 따르는 세션은 두 가지 중 하나를 하게 됩니다.
1. `.claude/CLAUDE.md`의 생성 구간을 직접 고칩니다. 이 수정은 다음에 다시 생성할 때 사라집니다.
2. 루트 `CLAUDE.md`만 고칩니다. 그러면 생성 구간이 낡은 채로 남습니다.

생성 마커에 `source:` 표시(`.claude/CLAUDE.md:31`, `:53`, `:104`, `:208`)가 있기는 합니다. 하지만 그 표시는 원본 파일 이름만 알려 줄 뿐, 「여기를 직접 고치지 말라」고 하지 않습니다. `ROADMAP.md`의 Phase 2·3·5·9 기준과 `TESTING.md`에도 원본을 고치고 다시 생성하라는 요구가 없습니다 (`generate-claude-md`는 `TESTING.md:128`에 한 번 나오는데, 두 사본을 맞춰 주지 않는다는 설명입니다).

이번 단계에서 이미 2번이 일어났습니다. `.gitignore`를 바꿨지만 `STACK.md`는 고치지 않았습니다 (IN-01). 앞으로는 더 커집니다. Phase 2(Jekyll 공유 셸)를 마치면 다음 생성 문장들이 틀린 설명이 됩니다.
- `.claude/CLAUDE.md:69`: 로컬 미리보기는 `python3 -m http.server`
- `.claude/CLAUDE.md:78`: 빌드 도구 없음
- `.claude/CLAUDE.md:234`: 공통 템플릿·include 없음 → 공유 부분은 수동 복사

같은 시점에 루트 `CLAUDE.md:54`·`:64`는 고쳐져 있을 것입니다. Claude Code는 두 파일을 한 세션에 함께 읽습니다. 그래서 「공통 블록을 네 파일에 복사해 고쳐라」와 「`_includes` 한 곳만 고쳐라」가 동시에 들어갑니다. WR-03에서 짚은 위험(두 문서가 서로 다른 지시를 하는 것)이 생성 구간 쪽에서 다시 열려 있는 셈입니다.
**Fix:** 두 사본의 같은 줄에 생성 구간을 고치는 방법을 더합니다. 방침 구간 안의 문장이므로 두 파일을 같은 커밋에서 고칩니다.
```markdown
- 방침이나 구조를 바꾸는 단계는 그 단계 안에서 `CLAUDE.md`도 함께 고칩니다. 이 방침 구간은 루트 `CLAUDE.md`와 `.claude/CLAUDE.md` 두 사본을 같은 커밋에서 똑같이 고칩니다. `.claude/CLAUDE.md`의 `<!-- GSD:... -->` 구간은 직접 고치지 않고, 원본(`.planning/PROJECT.md`, `.planning/codebase/*.md`)을 고친 뒤 `generate-claude-md`로 다시 만듭니다.
```

## Info

### IN-01: `.claude/CLAUDE.md`의 `.gitignore` 요약이 이번 단계 변경을 반영하지 않음

**File:** `.claude/CLAUDE.md:93` (생성 원본 `.planning/codebase/STACK.md:64`)
**Issue:** 아직 유효합니다. 요약에는 `prepare/`, `.DS_Store`, `.playwright-mcp/` 세 항목만 있습니다. 실제 `.gitignore:10-11`에는 `.planning/research/.cache/`도 있습니다. 원본 `STACK.md:64`가 그대로라서, 다시 생성해도 낡은 요약이 나옵니다. WR-05가 고쳐지지 않으면 이런 어긋남이 계속 생깁니다. 이 항목이 그 실제 예입니다.
**Fix:** `STACK.md:64`에 `.planning/research/.cache/`(GSD 연구 캐시)를 더한 뒤 `generate-claude-md`로 다시 생성합니다.

### IN-02: 「연락은 공개 지원 이메일로만 받는다」가 현재 상태와 맞지 않음

**File:** `.claude/CLAUDE.md:196` (생성 원본 `.planning/codebase/CONVENTIONS.md:145`)
**Issue:** 아직 유효합니다. 이 문장은 현재형입니다. 그런데 바로 다음 줄(`:197`)은 「현재 사이트에는 지원 이메일이 없다」라고 쓰고, `CONCERNS.md:123`도 「현재 문의 채널이 없음」이라고 적습니다. 방침 구간은 「이 구간 아래의 설명은 지금 코드의 실제 모습」(`.claude/CLAUDE.md:3`)이라고 약속합니다. 이 문장은 그 약속과 어긋납니다.
**Fix:** 「연락 수단은 이메일 게이트(Phase 5) 뒤 공개하는 지원 이메일 하나로 한다. 현재는 문의 채널이 없다 (2026-11 기준).」처럼 적용 시점을 밝힙니다. `CONVENTIONS.md:145`를 고친 뒤 다시 생성합니다.

### IN-03: 두 문서의 앱 설명이 서로 다름

**File:** `CLAUDE.md:37` / `.claude/CLAUDE.md:37` (생성 원본 `.planning/PROJECT.md:5`)
**Issue:** 아직 유효합니다. 두 문서가 앱을 다르게 설명합니다.
- 루트 `CLAUDE.md`: 「코스 모양 뱃지를 모으고, 직접 그린 코스를 공개할 수 있는 앱」
- `.claude/CLAUDE.md`(`PROJECT.md:5`에서 생성): 「코스 모양 뱃지를 모으는 앱」

심사에서는 사이트와 앱이 일치하는지 봅니다. Phase 4에서 소개 문구를 고칠 때 어느 쪽을 기준으로 삼을지 헷갈릴 수 있습니다.
**Fix:** 기준 설명 하나를 정해 `PROJECT.md:5`와 루트 `CLAUDE.md:37`을 같은 문장으로 맞춘 뒤 다시 생성합니다. 코스 공개 기능은 `ROADMAP.md:143`(Phase 6 기준 2)과 `ROADMAP.md:173`(Phase 8 기준 1)에 있습니다.

### IN-04: 생성 구간의 줄 번호 하나와 명명 예시 파일이 실제와 다름 (이번 diff 밖, 원래 있던 문제)

**File:** `.claude/CLAUDE.md:292-293`, `.claude/CLAUDE.md:111` (생성 원본 `.planning/codebase/ARCHITECTURE.md:155-156`, `.planning/codebase/CONVENTIONS.md:13`)
**Issue:** 반은 풀렸고 반은 남아 있습니다.
- **줄 번호 (남음, 하나 더 찾음):**
  - `:293`은 `decodeURIComponent` 실패 무시를 `index.html:629`라고 적었지만, 실제로는 627행입니다.
  - 이번에 하나를 더 찾았습니다. `:292`는 `moveTo()`의 `getPointAtLength` 실패 처리를 `index.html:530-535`라고 적었습니다. 하지만 `moveTo`는 526~531행입니다. 530~535행은 `catch` 줄부터 다음 함수 `setStep`의 앞부분까지입니다. 첫 리뷰는 `catch`가 530행에 있는 것만 보고 이 범위를 맞다고 했는데, 범위 전체를 보면 틀렸습니다.
  - 생성 출력에는 나오지 않지만 원본 `ARCHITECTURE.md:93`의 `index.html:628-629`도 실제(625~627행)와 다릅니다.
  - 이번에 확인한 다른 인용은 맞습니다. IIFE 497행, `state` 513행, pre-paint 스크립트 26~29행, 「공통」 CSS 31~58행, 「랜딩 전용」 60~146행, SVG 심볼 152~182행, 스크립트 495~650행, `terms/index.html`의 토큰 21~34행과 `.rp-grid` 69행입니다. 다른 줄 번호는 확인하지 않았습니다.
- **명명 예시 (공개 위험은 풀렸고, 문서는 남음):**
  - 공개 위험은 풀렸습니다. `favicon/app-icon-*.png` 네 개는 무시 대상인 `prepare/old-app-icons/`로 옮겨졌습니다. `favicon/` 아래에는 추적 중인 일곱 파일만 남아 있습니다.
  - 하지만 `:111`은 여전히 `favicon/` 아래 에셋 이름의 예로 `app-icon-512x512.png`를 듭니다. 이제 `favicon/`에 없는 파일입니다.
  - 생성 출력에는 나오지 않는 원본 문서도 낡았습니다. `STRUCTURE.md:43`(「미추적 파일 존재」)과 `CONCERNS.md:32-33`(「`favicon/app-icon-*.png`가 git 미추적」)은 이제 사실이 아닙니다.
**Fix:**
- 줄 번호: `ARCHITECTURE.md:155`를 `index.html:526-531`로, `:156`을 `index.html:627`로, `:93`을 `index.html:625-627`로 고칩니다. 줄 번호 대신 식별자(`moveTo`, `settle`)로 가리키는 방법도 있습니다.
- 명명 예시: `CONVENTIONS.md:13`의 세 번째 예시를 실제 파일(`apple-touch-icon.png` 등)로 바꿉니다.
- 원본 문서: `STRUCTURE.md:43`과 `CONCERNS.md:32-33`은 「`prepare/old-app-icons/`로 옮김(해결)」으로 고칩니다.
- 그 뒤 `generate-claude-md`로 다시 생성합니다.

### IN-05: 「주소는 `.planning/` 문서에만 있다」 문장은 사이트 기준으로만 맞음

**File:** `CLAUDE.md:12` (같은 내용 `.claude/CLAUDE.md:8`, `.claude/CLAUDE.md:197` ← 생성 원본 `.planning/codebase/CONVENTIONS.md:146`)
**Issue:** 아직 유효합니다. 이번에는 근거를 직접 확인했습니다.
- `.planning/baseline/NAMES.md`는 추적 중인 파일입니다.
- 저장소는 공개(`PUBLIC`)입니다.
- `NAMES.md`에 이메일 형식 문자열이 1건 있습니다.

그래서 지원 주소는 이메일 게이트 전에도 GitHub에서 누구나 볼 수 있습니다. `_config.yml:13`은 `.planning/`을 사이트 빌드에서만 뺍니다.

게이트의 목적은 수신 시험이지 비공개 유지가 아니므로 결함은 아닙니다. 다만 「HTML·`_data`에 넣지 않는다」는 규칙이 주소 공개를 막아 준다고 오해할 수 있습니다.
**Fix:** 「사이트(HTML·`_data`)에는 아직 없습니다. 저장소가 공개라 `.planning/` 문서의 주소는 GitHub에서 보입니다.」처럼 범위를 밝힙니다. 방침 구간(`CLAUDE.md:12`, `.claude/CLAUDE.md:8`)은 두 사본을 같은 커밋에서 고칩니다. `:197`은 `CONVENTIONS.md:146`을 고친 뒤 다시 생성합니다.

### IN-06: 「Deploy」 구간의 「Phase 2까지 유효」가 새 작업 규칙 「`main` 푸시가 곧 배포」와 다르게 읽힘

**File:** `CLAUDE.md:107` (관련 규칙 `CLAUDE.md:23`, `.claude/CLAUDE.md:19`)
**Issue:** WR-02를 고치면서 「`main` 푸시가 곧 배포입니다 (CI 없음)」가 조건 없는 규칙으로 들어갔습니다 (`CLAUDE.md:23`, `ROADMAP.md:11`). 그런데 `CLAUDE.md:107`은 「현재는 별도 CI/CD나 빌드 스텝이 없으므로 (2026-11 기준, Phase 2까지 유효) 커밋이 곧 배포입니다」라고 씁니다.

이 문장은 「커밋이 곧 배포」라는 사실이 Phase 2까지만 맞는다고 읽힐 수 있습니다. 하지만 Phase 2 뒤에도 GitHub Pages가 푸시마다 Jekyll을 돌려 바로 배포하므로, 푸시가 곧 배포라는 사실은 바뀌지 않습니다. 바뀌는 것은 「로컬 빌드 단계가 없다」는 부분뿐입니다. Phase 2 뒤에 이 괄호를 보고 「이제 푸시해도 바로 배포되지 않는다」고 여기는 세션이 나올 수 있습니다.
**Fix:** 괄호가 무엇에 걸리는지 밝힙니다. 예: 「`main` 브랜치에 푸시하면 GitHub Pages가 자동 배포합니다. CI가 없으므로 커밋이 곧 배포입니다. 현재는 로컬 빌드 스텝도 없습니다 (2026-11 기준, Phase 2까지 유효). …」

---

_Reviewed: 2026-11-15T10:25:10Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
