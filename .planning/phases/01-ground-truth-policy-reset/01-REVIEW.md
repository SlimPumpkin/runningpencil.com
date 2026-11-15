---
phase: 01-ground-truth-policy-reset
reviewed: 2026-11-15T15:00:26Z
depth: standard
files_reviewed: 2
files_reviewed_list:
  - .claude/CLAUDE.md
  - CLAUDE.md
findings:
  critical: 0
  warning: 1
  info: 2
  total: 3
  necessity: 0
status: issues_found
---

# Phase 1: Code Review Report

**Reviewed:** 2026-11-15T15:00:26Z
**Depth:** standard
**Files Reviewed:** 2
**Status:** issues_found

## Summary

두 번째 수정(d127c7c~f4861dd) 뒤에 다시 검토했습니다. 대상은 프로젝트 안내 문서 두 개(`CLAUDE.md`, `.claude/CLAUDE.md`)입니다. `6c87286..HEAD` 사이에 HTML·CSS·JS는 바뀌지 않았습니다. 두 문서를 끝까지 다시 읽었고, 원본 문서(`.planning/PROJECT.md`, `.planning/codebase/*.md`)와 사이트 파일에 대조했습니다.

**고친 항목 확인 (WR-04·WR-05, IN-01~IN-06):** 여덟 항목이 모두 제대로 고쳐졌습니다. 처리 기록(`01-REVIEW-DISPOSITION.md`)에 `fixed`로 남아 있으므로 같은 ID로 다시 쓰지 않습니다. 새 항목은 쓰인 적 없는 ID(WR-06, IN-07, IN-08)로 적었습니다.

- **WR-04:** `TESTING.md`의 비교 명령을 bash로 돌렸습니다. 지금 파일에서는 출력 없이 `rc=0`이 나옵니다.
- **WR-05·IN-05:** 방침 구간 두 사본이 같습니다. 생성 구간을 원본에서 고친다는 문장이 `CLAUDE.md:30`과 `.claude/CLAUDE.md:26`에 똑같이 들어갔습니다. 문장의 정확성에 관한 작은 문제는 IN-07로 적었습니다.
- **생성 구간과 원본의 일치:** `git archive HEAD`로 만든 임시 복사본에서 `generate-claude-md`를 돌렸습니다. 결과 `.claude/CLAUDE.md`가 저장소의 파일과 한 글자도 다르지 않았습니다. 그래서 생성 구간을 손으로 고친 흔적은 없습니다.
- **IN-01·IN-03·IN-04:** `.gitignore` 네 항목, 루트와 같은 앱 설명, `favicon/web-app-manifest-512x512.png`(실제 있음)를 확인했습니다. 줄 번호도 다시 확인했습니다: `moveTo` 526행, `decodeURIComponent` 627행, IIFE 497행, `state` 513행, pre-paint 26~29행, 「공통」 31~58행, 「랜딩 전용」 60~146행, SVG 심볼 152~182행, 스크립트 495~650행, 로고 188행, `#story` 변수 249행, `rp-c-dog` 154행.
- **IN-02·IN-06:** 문장이 현재 상태와 맞습니다. 다만 IN-06에서 넣은 문장의 낱말 하나를 IN-08로 적었습니다.
- **사실값:** 다음 값이 실제 파일과 같습니다.
  - Tailwind 토큰 다섯 개, `theme-color`, `og:url`, `og:image`
  - 매니페스트 이름·색·아이콘
  - Pretendard `v1.3.9`(네 페이지)
  - `340vh`·`sticky`, 2400px 조건, 7000ms, `KM = 8.3`
  - 법적 페이지 세 곳의 `noindex`와 「임시 게시본」(각 1건)
- **이메일:** `.planning/` 밖의 추적 파일에는 이메일 형식 문자열이 없습니다 (`git grep -l` 0건).

**새로 찾은 문제:** 경고 하나와 정보 둘입니다.

- WR-06은 이번 diff 밖에 원래 있던 문제입니다. 생성기가 원본의 일부 줄을 버려서 `.claude/CLAUDE.md`의 몇 구간이 뜻을 잃습니다. WR-05 규칙 때문에 이 파일을 손으로 고칠 수 없으므로, 원본의 모양을 바꾸는 방법을 임시 복사본에서 시험해 적었습니다.
- IN-07과 IN-08은 이번 수정에서 들어간 문장의 정확성 문제입니다.

보안 문제는 찾지 못했습니다.

필요성(Necessity) 기준(`necessity-review.md`)을 읽고 검토했지만 해당 사항은 없습니다. 바뀐 것은 문서뿐이라 실행되는 방어 코드가 없습니다.

## Narrative Findings (AI reviewer)

아래는 두 문서를 직접 읽고 원본 문서·사이트 파일과 대조해서 찾은 문제입니다. 구조 분석(fallow) 결과는 받지 않았으므로 해당 구간은 없습니다.

## Warnings

### WR-06: 생성기가 원본의 소제목 줄·코드 블록·번호 목록·하위 목록을 버려서 `.claude/CLAUDE.md`의 여러 구간이 뜻을 잃음 (이번 diff 밖, 원래 있던 문제)

**File:** `.claude/CLAUDE.md:165`, `:169`, `:178`, `:190`, `:203`, `:214-216`, `:241-250`, `:254-260`, `:264-269`, `:271`, `:284-288` (생성 원본 `.planning/codebase/CONVENTIONS.md`, `.planning/codebase/ARCHITECTURE.md`)

**Issue:** `generate-claude-md`는 원본에서 `## `/`### ` 머리줄, 맨 위 단계의 `- ` 목록, 표만 옮깁니다. 다음 줄은 버립니다.
- `**…:**` 꼴의 굵은 소제목 줄
- 들여 쓴 하위 목록
- 번호 목록
- 코드 블록 안의 내용

임시 복사본에서 다시 생성한 결과가 저장소의 파일과 같았으므로, 이것은 손으로 고친 흔적이 아니라 생성기의 동작입니다. 그 결과 아래 구간이 뜻을 잃습니다.

| `.claude/CLAUDE.md` | 원본 | 잃은 것 |
|---|---|---|
| `:178` | `CONVENTIONS.md:117-118` | 「JSDoc/TSDoc:」 소제목이 빠져 「## Comments」 아래에 「- 쓰지 않는다. 함수 위에 한 줄 한국어 주석이면 충분하다」만 남음. 무엇을 쓰지 않는지가 사라짐 |
| `:165` | `CONVENTIONS.md:97-101` | 「…조용히 대체 동작을 한다:」 뒤의 예시 코드가 빠져 콜론으로 끝남 |
| `:169` | `CONVENTIONS.md:107` | 「## Logging」이 비어 「디버깅용 로그를 남긴 채 커밋하지 않는다」 규칙이 사라짐 |
| `:190` | `CONVENTIONS.md:134-138` | 「## Module Design」이 비어 Exports·Shared code·SVG 설명이 사라짐 |
| `:203` | `CONVENTIONS.md:152-154` | 「(`git log`):」 뒤의 커밋 예시가 빠져 콜론으로 끝남 |
| `:214-216` | `ARCHITECTURE.md:11-27` | 「System Overview」가 빈 코드 블록 |
| `:241-250` | `ARCHITECTURE.md:56-70` | 「Markup / Style / Behavior」 이름이 빠져 이름 없는 「Purpose:」 묶음 셋이 나란히 남음 |
| `:254-258` | `ARCHITECTURE.md:74-96` | 「Data Flow」의 세 소제목 아래 단계가 모두 빠짐 |
| `:260` | `ARCHITECTURE.md:98-99` | 「State Management:」 소제목이 빠져, 상태 설명이 「### 초기 정착 & `rp-ready`」 아래에 붙음 (다른 주제로 읽힘) |
| `:264-269` | `ARCHITECTURE.md:103-114` | 「SVG 심볼 + `<use>`」「진행도 CSS 변수」「공유 헤더/푸터」 이름이 빠짐 |
| `:271` | `ARCHITECTURE.md:115-119` | 「## Entry Points」가 비어 있음 |
| `:284-288` | `ARCHITECTURE.md:132-148` | Anti-Patterns 세 머리줄 아래의 「What happens / Why / Do this instead」가 모두 빠짐 |

이 가운데 세션의 행동을 바꾸는 것은 `:178`입니다. 이 줄의 뜻은 「이 저장소는 JSDoc을 쓰지 않는다」인데, 소제목이 빠지면서 그 예외가 사라졌습니다. 사용자의 전역 지침(`~/.claude/CLAUDE.md` 「코딩 스타일」)은 「공개 함수·클래스·모듈에는 반드시 Docstring/문서 주석을 작성할 것」을 요구합니다. 그래서 `.claude/CLAUDE.md`만 읽은 세션은 전역 규칙을 따라 `index.html` 스크립트에 JSDoc 블록을 넣을 수 있습니다. 루트 `CLAUDE.md`에도 JSDoc 예외가 없어서 다른 문서가 이를 막아 주지 않습니다.

`:169`의 디버그 로그 규칙과 `:284-288`의 「Do this instead」도 루트 `CLAUDE.md`에는 없습니다. 나머지는 루트 문서가 일부 덮지만, 빈 머리줄과 콜론으로 끝나는 줄은 「이 구간 아래의 설명은 지금 코드의 실제 모습」(`.claude/CLAUDE.md:3`)이라는 약속과 맞지 않습니다.

WR-05 규칙(`.claude/CLAUDE.md:26`)은 생성 구간을 손으로 고치지 못하게 합니다. 그래서 이 문제를 고치는 길은 원본의 모양을 생성기가 남기는 형태로 바꾸는 것뿐입니다.

**Fix:** 원본의 굵은 소제목, 하위 목록, 번호 목록을 맨 위 단계의 `- ` 목록으로 바꾸고, 소제목은 그 줄 안에 넣습니다. 코드 블록의 예시는 줄 안 코드로 옮깁니다. 그 뒤 `generate-claude-md`로 다시 만듭니다.

임시 복사본에서 아래 세 곳을 이렇게 바꾸고 다시 생성해 보았습니다. 세 줄 모두 `.claude/CLAUDE.md`에 남았고, 다른 줄은 바뀌지 않았습니다.
```markdown
<!-- CONVENTIONS.md:117-118 (전) -->
**JSDoc/TSDoc:**
- 쓰지 않는다. 함수 위에 한 줄 한국어 주석이면 충분하다 (...).
<!-- (후) → .claude/CLAUDE.md에 그대로 남음 -->
- JSDoc/TSDoc은 쓰지 않는다. 함수 위에 한 줄 한국어 주석이면 충분하다 (...).

<!-- CONVENTIONS.md:107 (후) -->
- 로깅 프레임워크 없음 (`console` 호출 없음). 디버깅용 로그를 남긴 채 커밋하지 않는다.

<!-- CONVENTIONS.md:153 (하위 목록 → 맨 위 목록) -->
- 예: `feat: 티저 랜딩 새 디자인 적용, 법적 페이지·파비콘 개편`
```
나머지 구간도 같은 방식으로 바꿉니다.
- `ARCHITECTURE.md`의 Layers·Key Abstractions·Anti-Patterns: `- Markup (구조) — Purpose: …`, `- 하지 말 것: … / 대신: …`처럼 이름을 줄 안에 넣습니다.
- Data Flow: 번호 목록을 `- ` 목록으로 바꿉니다.
- State Management: `### 상태` 같은 자기 머리줄을 줍니다.
- System Overview: 그림 대신 한두 줄 설명을 씁니다.

`.planning/codebase/*.md`는 `gsd-map-codebase`가 다시 쓸 수 있는 문서입니다. 그래서 생성기가 이런 줄을 버린다는 사실을 `TESTING.md`의 점검 목록 9 옆이나 `CONVENTIONS.md` 머리에 한 줄 적어 두면 다음 갱신에서 같은 일이 되풀이되지 않습니다. 생성기 자체의 동작은 이 저장소 밖(gsd-core)의 일입니다.

## Info

### IN-07: 생성 구간 규칙의 「마커의 `source:`가 가리키는 파일」과 「`generate-claude-md`로 다시 만듭니다」가 일부 구간에 맞지 않음

**File:** `CLAUDE.md:30` (같은 문장 `.claude/CLAUDE.md:26`)

**Issue:** WR-05를 고치면서 넣은 문장은 「`.claude/CLAUDE.md`의 `<!-- GSD:... -->` 구간」을 모두 같은 방법으로 다룹니다. 실제 마커(`.claude/CLAUDE.md:31-322`)는 다음과 같습니다.
- `source:` 값의 모양이 서로 다릅니다. `source:codebase/STACK.md`에는 폴더가 있는데, `source:CONVENTIONS.md`와 `source:ARCHITECTURE.md`에는 `codebase/`가 없습니다. 마커를 글자 그대로 따라가면 없는 파일(`.planning/CONVENTIONS.md`)을 찾게 됩니다. 괄호 안의 `.planning/codebase/*.md`가 이를 메워 주기는 합니다.
- 일곱 구간 중 세 구간은 문장이 말하는 원본에서 만들지 않습니다.
  - `skills`(`source:skills/`): 스킬 폴더에서 만듭니다.
  - `workflow`(`source:GSD defaults`): 고칠 원본이 없습니다.
  - `profile`: `source:`가 없고, `:327`이 밝히듯 `generate-claude-profile`이 관리합니다. `generate-claude-md`를 돌려도 이 구간은 다시 만들어지지 않습니다 (실행 결과 `Generated 5/6 sections`).
- 이 규칙은 「GSD 밖에서 연 세션과 다른 도구도 지킵니다」(`CLAUDE.md:21`)에 걸립니다. 그런데 `generate-claude-md`를 어떻게 실행하는지는 어디에도 없습니다. 이번 검토에서는 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 돌렸습니다.

지금 고칠 일이 생기는 곳은 앞의 네 구간뿐이라 당장 문제가 되지는 않습니다. 다만 GSD 밖의 도구에게는 실행할 수 없는 지시가 됩니다.

**Fix:** 두 사본의 같은 문장을 같은 커밋에서 이렇게 좁힙니다. 「`.claude/CLAUDE.md`의 `<!-- GSD:project/stack/conventions/architecture -->` 구간은 직접 고치지 않고, 원본(`.planning/PROJECT.md`, `.planning/codebase/STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md`)을 고친 뒤 `gsd-tools.cjs generate-claude-md`로 다시 만듭니다. `skills`·`workflow`·`profile` 구간은 도구가 관리하므로 고치지 않습니다.」

### IN-08: Deploy 문단이 한 문단 안에서 「푸시」와 「커밋」을 배포 시점으로 번갈아 씀

**File:** `CLAUDE.md:107` (관련 `CLAUDE.md:23`, `.claude/CLAUDE.md:19`, `:43`, `:100`, `:204`)

**Issue:** 문단 첫 문장은 「`main` 브랜치에 푸시하면 GitHub Pages가 자동 배포합니다」입니다. 그런데 바로 다음 문장은 「CI가 없으므로 커밋이 곧 배포입니다」입니다. 작업 규칙(`CLAUDE.md:23`)과 다른 다섯 곳은 모두 「`main` 푸시가 곧 배포」라고 씁니다. 로컬 커밋은 푸시 전까지 배포되지 않으므로 이 문장만 사실과 다릅니다.

이 문장은 지난 리뷰가 IN-06의 수정안으로 제시한 문장 그대로입니다. 고치기 전 문단에도 「커밋이 곧 배포」가 있었습니다. 그래서 이번 수정이 새로 만든 문제는 아닙니다. 「배포됐다고 착각한다」 쪽보다 「커밋을 조심한다」 쪽으로 읽히므로 해도 거의 없습니다.

**Fix:** 「CI가 없으므로 `main` 푸시가 곧 배포입니다.」로 바꿉니다. 루트 `CLAUDE.md`에만 있는 구간이라 `.claude/CLAUDE.md`는 바꾸지 않습니다.

---

_Reviewed: 2026-11-15T15:00:26Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
