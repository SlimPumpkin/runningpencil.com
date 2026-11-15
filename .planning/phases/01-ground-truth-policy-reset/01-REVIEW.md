---
phase: 01-ground-truth-policy-reset
reviewed: 2026-11-15T18:41:23Z
depth: standard
files_reviewed: 2
files_reviewed_list:
  - .claude/CLAUDE.md
  - CLAUDE.md
findings:
  critical: 0
  warning: 2
  info: 3
  total: 5
  necessity: 0
status: issues_found
---

# Phase 1: Code Review Report

**Reviewed:** 2026-11-15T18:41:23Z
**Depth:** standard
**Files Reviewed:** 2
**Status:** issues_found

## Summary

세 번째 수정(`1dc2f1a` WR-06, `79fc9f7` IN-07, `ae4668b` IN-08) 뒤에 다시 검토했습니다. 대상은 프로젝트 안내 문서 두 개(`CLAUDE.md`, `.claude/CLAUDE.md`)입니다. `index.html`은 `c4cb26d` 뒤로 바뀌지 않았고, 이번 diff(`8647c8b..HEAD`)에도 HTML·CSS·JS 변경은 없습니다.

**고친 항목 확인 (WR-06, IN-07, IN-08):** 세 항목 모두 고쳐졌습니다. 처리 기록(`01-REVIEW-DISPOSITION.md`)에 `fixed`로 남아 있으므로 같은 ID를 다시 쓰지 않습니다. 새 항목은 쓰인 적 없는 ID(WR-07·WR-08, IN-09~IN-11)로 적었습니다.

- **방침 구간 두 사본:** `diff <(sed -n '5,33p' CLAUDE.md) <(sed -n '1,29p' .claude/CLAUDE.md)` 결과가 같습니다. IN-07 문장이 `CLAUDE.md:30`과 `.claude/CLAUDE.md:26`에 똑같이 들어갔고, 마커 문자열(`<!-- GSD:…-start`)은 들어 있지 않습니다.
- **생성 구간과 원본의 일치:** `git archive HEAD`로 만든 임시 복사본에서 `generate-claude-md`를 돌렸습니다. 출력의 `claude_md_path`가 임시 복사본을 가리키는 것을 확인했고, 결과 `.claude/CLAUDE.md`는 저장소 파일과 같았습니다. 그래서 생성 구간을 손으로 고친 흔적은 없습니다. 실제 저장소의 `git status`도 바뀌지 않았습니다.
- **WR-06:** `.claude/CLAUDE.md`의 conventions·architecture 구간(`:104-402`)에서 콜론으로 끝나는 줄을 직접 찾았고 0건입니다. 빈 머리줄도 남아 있지 않습니다 (생성기가 붙이는 `## Conventions`·`## Architecture` 감싸는 머리줄 제외). JSDoc 예외(`:228`)와 디버그 로그 규칙(`:218`)도 돌아왔습니다.
- **IN-08:** `CLAUDE.md:107`이 「`main` 푸시가 곧 배포」로 바뀌었습니다.
- **사실값:** 다음 값이 실제 파일과 같습니다.
  - Tailwind 토큰 다섯 개(`terms/index.html:21-35`), `.rp-grid`(`:69`)
  - 법적 페이지 세 곳의 `noindex`(`:10`)와 「임시 게시본」 문구(각 1건)
  - `340vh`·`sticky`(`index.html:98-99`), 2400px 조건(`:28`, `:547`), 7000ms(`:606`), `KM = 8.3`(`:510`)
  - `:focus-visible` 3px `#1E5AA8`(`:36`), `min-height: 44px`(`:40`, `:55`)
  - SVG 심볼 `rp-map-seoul`·`rp-logo`·`rp-t-*`(`:161-180`)
  - 푸터 운영 문장·저작권·OSM 표기(`:488-490`)
- **이메일:** `.planning/` 밖의 추적 파일에는 이메일 형식 문자열이 없습니다 (`git grep` 0건).

**새로 찾은 문제:** 경고 둘과 정보 셋입니다.

WR-06 수정으로, 생성기가 그동안 버리던 원본의 소제목·번호 목록·하위 목록 줄이 처음으로 `.claude/CLAUDE.md`에 실렸습니다. 이 줄들은 앞선 검토에서 사이트 파일에 대조된 적이 없습니다. 이번에 대조해 보니 다음이 나왔습니다.

- WR-08과 IN-09는 그 줄들의 사실 오류입니다. WR-08은 `<head>` 순서이고, IN-09는 Data Flow의 줄 번호입니다.
- WR-07은 WR-06과 같은 결함이 `STACK.md`에 남은 것입니다. fixer가 범위 밖으로 남겼다고 스스로 적었습니다.
- IN-10은 fixer가 적용하다가 겪은 생성기 위험인데, 아직 어느 문서에도 적혀 있지 않습니다.
- IN-11은 conventions 구간 안의 모호한 참조입니다.

보안 문제는 찾지 못했습니다.

필요성(Necessity) 기준(`necessity-review.md`)을 읽고 검토했지만 해당 사항은 없습니다. 바뀐 것은 문서뿐이라 실행되는 방어 코드가 없습니다.

모든 수정은 `.claude/CLAUDE.md`를 손으로 고치지 않고, 원본(`.planning/codebase/*.md`)을 고친 뒤 다시 생성하는 방식으로 적었습니다. 방침 구간 규칙(`CLAUDE.md:30`)이 그렇게 정하고 있습니다.

## Narrative Findings (AI reviewer)

아래는 두 문서를 직접 읽고 원본 문서·사이트 파일과 대조해서 찾은 문제입니다. 구조 분석(fallow) 결과는 받지 않았으므로 해당 구간은 없습니다.

## Warnings

### WR-07: `STACK.md`의 굵은 소제목과 하위 목록이 버려져 Technology Stack 구간에 주어 없는 줄이 남음

**File:** `.claude/CLAUDE.md:66-71`, `:73-79`, `:81-85`, `:87-94`, `:96-100` (생성 원본 `.planning/codebase/STACK.md:11`, `:15`, `:23`, `:27`, `:33`, `:37`, `:40`, `:46-49`, `:52`, `:57`, `:61`, `:69`, `:73`)

**Issue:** WR-06의 남은 부분입니다. WR-06은 생성기가 굵은 소제목 줄(`**…:**`)과 들여 쓴 하위 목록을 버리는 문제였습니다. 수정은 `CONVENTIONS.md`·`ARCHITECTURE.md`만 고쳤습니다. fixer도 `01-REVIEW-FIX.md` 「범위 밖으로 남긴 것」에서 `STACK.md`에 같은 결함이 있다고 적었습니다. 지금 `.claude/CLAUDE.md`의 Technology Stack 구간은 다음과 같습니다.

| `.claude/CLAUDE.md` | 원본 | 잃은 것 |
|---|---|---|
| `:70-71` | `STACK.md:27-29` | 「Package Manager:」가 빠졌습니다. 그래서 `## Runtime` 아래에 「- 없음 (`package.json`, lockfile 없음)」이 남습니다. 바로 위 `:68` 「브라우저만」과 맞붙어 「런타임 없음」으로 읽힙니다 |
| `:77` | `STACK.md:37-38` | 「Testing:」이 빠져 `## Frameworks` 아래에 무엇을 가리키는지 모르는 「- Not detected」만 남습니다 |
| `:75`, `:78` | `STACK.md:33`, `:40` | 「Core:」「Build/Dev:」가 빠져 「없음」 줄과 빌드 도구 줄이 한 목록에 섞입니다 |
| `:83` | `STACK.md:47-49` | 하위 목록이 빠졌습니다. 그래서 Pretendard CSS의 전체 URL과 `preconnect` 동반 사실이 사라집니다. Phase 2에서 공유 `<head>`를 만들 때 필요한 값입니다 |
| `:57-100` 전체 | `STACK.md:11`, `:15`, `:23`, `:52`, `:57`, `:61`, `:69`, `:73` | Primary/Secondary, Environment/Build, Development/Production 구분이 모두 빠집니다 |

이것은 문서 사이의 모순이기도 합니다. `TESTING.md:136`은 「`STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md`를 고치거나 다시 만든 뒤에는 소제목을 `### ` 머리줄이나 줄 안에 넣는다」고 정해 두었습니다. 그런데 지금 `STACK.md`는 그 규칙을 따르지 않습니다.

`TESTING.md:136`의 사후 점검(「빈 머리줄이나 콜론으로 끝나는 줄이 없는지」)도 이 결함을 잡지 못합니다. 소제목이 통째로 빠지면 머리줄 자체가 없어서 빈 머리줄이 생기지 않습니다. 남는 「- Not detected」 같은 줄은 콜론으로 끝나지도 않습니다. 그래서 점검을 통과한 지금 상태에서도 주어 없는 줄이 남아 있습니다.

`.claude/CLAUDE.md:3`은 「이 구간 아래의 설명은 지금 코드의 실제 모습」이라고 약속합니다. 이 파일만 읽는 세션은 Package Manager가 없다는 사실을 런타임이 없다는 뜻으로 잘못 읽을 수 있습니다.

**Fix:** `STACK.md`의 모양만 바꾸고 다시 생성합니다. 사실은 그대로 둡니다.
- 굵은 소제목 줄(`**Primary:**` 등)을 `### ` 머리줄로 바꿉니다.
- 들여 쓴 하위 목록(`STACK.md:48-49`)을 맨 위 `- ` 목록으로 올립니다.
- `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`를 돌립니다.

임시 복사본에서 이렇게 바꾸고 다시 생성해 보았습니다. `### Package Manager`, `### Testing`, `### Critical (외부 CDN)`, `preconnect` 줄이 모두 `.claude/CLAUDE.md`에 남았습니다. `git diff -U0`의 hunk는 모두 `.claude/CLAUDE.md:58-136` 안에 있었습니다. 이 범위는 stack 마커(`:53`의 start, 다시 생성한 파일의 `:137` end) 사이입니다. 그 밖에 바뀐 파일은 `STACK.md`뿐이었습니다.
```python
# 임시 복사본에서 쓴 변환 (모양만 바꿈)
s = re.sub(r'^\*\*(.+?):\*\*\s*$', r'### \1', s, flags=re.M)   # 굵은 소제목 → ### 머리줄
s = re.sub(r'^  - ', r'- ', s, flags=re.M)                      # 하위 목록 → 맨 위 목록
```
`**Analysis Date:** 2026-11-14` 줄(`STACK.md:7`)은 메타 줄이라 그대로 둡니다. 값이 같은 줄에 있어서 위 변환식에도 걸리지 않습니다.

`TESTING.md:136`의 사후 점검에 아래 점검을 하나 더하면 같은 일이 되풀이되지 않습니다. 이 명령을 macOS에서 지금 돌리면 `STACK.md:13`, `CONVENTIONS.md:0`, `ARCHITECTURE.md:0`이 나옵니다. 13은 위 표의 소제목 13줄이고, 고친 뒤에는 세 파일 모두 0이어야 합니다.
```bash
grep -c '^\*\*[^*]*:\*\*$' .planning/codebase/STACK.md .planning/codebase/CONVENTIONS.md .planning/codebase/ARCHITECTURE.md
```

### WR-08: Conventions의 `<head>` 순서가 실제 네 페이지와 다름

**File:** `.claude/CLAUDE.md:193-200` (생성 원본 `.planning/codebase/CONVENTIONS.md:95-101`)

**Issue:** 문서가 적은 `<head>` 순서는 다음과 같습니다.
1. meta
2. 첫 그리기 전 실행 스크립트 (`index.html`만)
3. Pretendard `<link>`
4. 파비콘·매니페스트 `<link>`
5. (법적 페이지) Tailwind CDN + `<script id="tailwind-config">`
6. `<style>`

실제 파일의 순서는 다릅니다.
- **`index.html`:** meta(`:6-17`) → Pretendard(`:18-19`) → 파비콘·매니페스트(`:20-25`) → pre-paint 스크립트(`:26-29`) → `<style>`(`:30`). pre-paint 스크립트는 글꼴 앞이 아니라 매니페스트 뒤에 있습니다.
- **법적 페이지 3종 (`terms`·`privacy-policy`·`data-deletion` 모두 같음):** meta(`:6-11`) → **Tailwind CDN `<script>`(`:12`)** → Pretendard(`:13-14`) → 파비콘·매니페스트(`:15-20`) → `tailwind-config`(`:21`) → `<style>`(`:36`). Tailwind CDN은 파비콘 뒤가 아니라 meta 바로 뒤에 있습니다. 파비콘 뒤에 오는 것은 `tailwind-config` 하나뿐입니다.

이 순서는 원래 번호 목록이었습니다(`dd2c568:.planning/codebase/CONVENTIONS.md:82-88`). 그래서 생성기가 버렸고, 그동안 `.claude/CLAUDE.md`에 나오지 않았습니다. WR-06 수정이 이를 `- ` 목록으로 바꾸면서 처음으로 모든 세션의 맥락에 실렸습니다. `git show 8647c8b:.claude/CLAUDE.md`와 `git show dd2c568:.claude/CLAUDE.md`에서 「첫 그리기 전 실행 스크립트」를 찾으면 둘 다 0건입니다.

바로 다음 단계가 이 순서를 씁니다. Phase 2는 head 링크를 `_includes`/`_layouts` 한 곳으로 모으는 단계입니다. 성공 기준 1(`.planning/ROADMAP.md` Phase 2)은 `_site/` 출력이 전환 전 HTML과 공백 정규화 diff로 차이 0이어야 한다는 것입니다. 이 문서의 순서대로 공유 `<head>`를 만들면 네 문서 모두 diff가 생겨 성공 기준을 통과하지 못합니다. 원인을 찾느라 시간을 쓰거나, 「같은 출력」 대신 「문서대로의 순서」를 맞추려고 페이지를 바꾸는 쪽으로 갈 수 있습니다.

**Fix:** `CONVENTIONS.md:95-101`을 실제 순서로 고치고 다시 생성합니다. 페이지 종류에 따라 순서가 다르므로 두 줄로 나눕니다.
```markdown
### Order (`<head>`)

- 랜딩(`index.html`): meta(charset, viewport, title, description, `theme-color`, Open Graph) → Pretendard `preconnect`·`<link>` → 파비콘·매니페스트 `<link>` (`/favicon/...`) → 첫 그리기 전 실행 스크립트(`rp-pin` 판정) → `<style>`
- 법적 페이지 3종: meta(charset, viewport, title, description, `robots noindex`, `theme-color`) → Tailwind CDN `<script src>` → Pretendard `preconnect`·`<link>` → 파비콘·매니페스트 `<link>` → `<script id="tailwind-config">` → `<style>`
```
이 문장은 `<!-- GSD:…-start` 꼴의 문자열을 쓰지 않으므로 IN-10의 위험에 걸리지 않습니다.

## Info

### IN-09: Data Flow의 `index.html` 줄 번호 다섯 개가 실제와 1~4줄 어긋남

**File:** `.claude/CLAUDE.md:321`, `:325`, `:327`, `:329`, `:331` (생성 원본 `.planning/codebase/ARCHITECTURE.md:69`, `:73`, `:75`, `:79`, `:81`)

**Issue:** 매핑 때부터 틀린 값입니다. `index.html`은 매핑 커밋(`c4cb26d`, `last_mapped_commit`) 뒤로 바뀌지 않았으므로 아래 줄 번호는 처음부터 틀렸습니다. 앞선 검토는 다른 줄 번호(`moveTo` 526, IIFE 497 등)만 확인했습니다. 이 줄들은 WR-06 수정 전에는 번호 목록이라 생성 결과에 없어서 확인 범위 밖이었습니다.

| 대상 | 적힌 값 | 실제 (`grep -n`) |
|---|---|---|
| scroll 핸들러 | `621-624` | `618-621` (`window.addEventListener('scroll'`은 `:618`) |
| `setStep` | `535-544` | `534-543` (`function setStep`은 `:534`) |
| `syncLive` | `547-549` | `546-549` |
| `#rp-run-btn` 클릭 → `startRun` | `604-614` | `startRun`은 `600-611`, 클릭 연결은 `:617` |
| `setRun` | `597-602` | `593-598` |

`:334`의 `settle` 범위 `630-637`은 함수(`628-632`)의 앞 두 줄(`628-629`)을 빠뜨립니다. 다만 범위가 입력 리스너·`load`·`fonts.ready` 연결(`633-637`)을 덮으므로 「load와 fonts.ready에서 settle()」이라는 설명과는 맞습니다. 그래서 표에 넣지 않았습니다.

**Fix:** `ARCHITECTURE.md:69`, `:73`, `:75`, `:79`, `:81`의 줄 번호를 위 표의 실제 값으로 고치고 다시 생성합니다. Phase 2·4에서 `index.html`이 바뀌면 이 줄 번호도 다시 틀어집니다. 그래서 줄 번호 대신 함수 이름(`setRun`, `startRun`)을 기준으로 적는 편이 오래 갑니다.

### IN-10: 생성기는 본문에 들어간 마커 문자열도 구간의 시작으로 아는데, 이 위험이 어느 문서에도 없음

**File:** `CLAUDE.md:30` (같은 문장 `.claude/CLAUDE.md:26`), 관련 `.planning/codebase/TESTING.md:135-136`

**Issue:** 방침 구간의 규칙(`CLAUDE.md:30`)은 세션에게 두 가지를 시킵니다. 방침 구간을 손으로 고치고, `generate-claude-md`를 돌리라는 것입니다. 생성기(`~/.claude/gsd-core/bin/lib/profile-output.cjs:245-247`, `:264-266`)는 다음 코드로 구간을 찾습니다.

```js
fileContent.indexOf(`<!-- GSD:${sectionName}-start`)
```

이 코드는 줄 처음인지, 코드 span 안인지를 따지지 않습니다. 그래서 방침 구간 본문에 `<!-- GSD:project-start` 같은 문자열이 들어가면 생성기는 그 자리를 project 구간의 시작으로 압니다. 그러면 거기서부터 진짜 `project-end`까지를 생성 결과로 덮어씁니다. 방침 구간의 뒷부분과 진짜 마커가 지워집니다.

이번 IN-07 수정 중에 실제로 이 일이 일어났습니다 (`01-REVIEW-FIX.md` 「적용 중 생긴 일」). 커밋 전에 되돌렸지만, fixer가 적었듯 이 위험은 아직 문서에 없습니다(`grep` 0건). 생성 구간 규칙을 설명하는 문장은 마커를 예로 들기 쉬워서 같은 실수가 또 나기 쉽습니다.

점검 목록 9(`TESTING.md`의 비교 명령)를 돌리면 방침 구간 두 사본이 달라져 잡힙니다. 그래서 커밋까지 가지는 않습니다. 그 점을 감안해 Info로 둡니다.

**Fix:** `TESTING.md:135-136` 옆에 한 줄을 더합니다. 이 줄에도 마커 문자열을 그대로 쓰지 않습니다.
```markdown
- 생성기는 `.claude/CLAUDE.md` 어디에 있든 「`<!--` + ` GSD:` + 구간 이름 + `-start`」 문자열을 처음 만나는 자리를 구간의 시작으로 안다. 그래서 방침 구간이나 다른 손으로 쓴 글에 이 문자열을 그대로 적지 않는다 (코드 span 안도 마찬가지). 생성기를 돌린 뒤에는 점검 목록 9를 다시 돌린다.
```
`TESTING.md`는 생성 원본이 아닙니다. 그래서 이 줄이 생성 결과로 새어 나가지 않고, 이 줄 때문에 생성기가 잘못 동작할 일도 없습니다.

### IN-11: Linting 줄의 「CLAUDE.md의 "커밋 전 린터 실행" 규칙」과 「`TESTING.md` 참고」가 저장소 안에서 찾을 수 없는 곳을 가리킴

**File:** `.claude/CLAUDE.md:147` (생성 원본 `.planning/codebase/CONVENTIONS.md:48`)

**Issue:** 이 줄이 가리키는 두 곳은 저장소 안에서 찾을 수 없습니다.
- 「CLAUDE.md의 "커밋 전 린터 실행" 규칙」은 사용자의 전역 지침(`~/.claude/CLAUDE.md` 「Git Workflow」)에 있습니다. 저장소의 `CLAUDE.md`와 `.claude/CLAUDE.md`에는 없습니다 (`grep '린터'` 결과 이 줄뿐).
- `TESTING.md`도 경로 없이 적혀 있습니다. 저장소 루트에는 이 파일이 없고, 실제 위치는 `.planning/codebase/TESTING.md`입니다.

`.claude/CLAUDE.md`만 읽는 세션이나 다른 도구는 이 예외가 어느 규칙을 덮는지, 무엇을 참고하라는지 찾지 못합니다.

**Fix:** `CONVENTIONS.md:48`을 아래처럼 고치고 다시 생성합니다.
```markdown
- 린터 없음. 사용자 전역 지침(`~/.claude/CLAUDE.md`)의 「커밋 전 린터 실행」 규칙은 이 저장소에 쓸 도구가 없으므로, 로컬 미리보기 확인으로 갈음한다 (`.planning/codebase/TESTING.md`의 점검 목록 참고).
```

---

_Reviewed: 2026-11-15T18:41:23Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
