---
phase: 02-jekyll-shared-shell-refactor
plan: 04
subsystem: infra
tags: [jekyll, liquid, layout, include, github-pages, legal-pages, refactor]

requires:
  - phase: 02-01
    provides: 로컬 Jekyll 3.10.0 빌드, scripts/check-site.sh, pre-push 훅, 스크래치 compare.sh, BASE_SHA=db505d71d3d2
  - phase: 02-03
    provides: 푸시 ① 라이브 확인(LIVE_PUSH1=OK). 운영 빌드가 _includes·_layouts를 출력하지 않음을 확인
provides:
  - _layouts/legal.html (법적 페이지 전체 틀, page.title·description·noindex·eyebrow·heading·updated를 읽음)
  - _includes/header.html (헤더 한 벌, include.home 매개변수로 href 네 곳 분기)
  - _includes/footer.html (푸터 한 벌)
  - _includes/head-links.html (head 링크 8줄 한 벌)
  - _includes/css/common.css (「공통」 CSS 28줄 한 벌)
  - 법적 3종이 front matter + 카드 본문만 담는 꼴로 전환됨 (출력은 기준과 바이트 동일)
  - 검증 기록 표식 줄 LEGAL_CONV_SHA_1·_2·_3, FALSY_LAYOUT=OK, CMP_LEGAL=OK
affects: [02-05, 02-06, 02-07, 02-08, 02-09, 02-10, phase-03, phase-05, phase-06, phase-07, phase-08, phase-09]

actuals:
  tokens: 11700
  tasks: 3
  commits: 3
plan_head_before: ecda8408ad0a20635f37c2c04a9da0ac4ec268bb
plan_head_after: 8cf18dd406734fc3c75c17d47242d31541eb4bdf

tech-stack:
  added: []
  patterns:
    - "include 파일은 원본 줄을 원래 들여쓰기째 담고 끝 줄바꿈 없이 저장한다. include 태그는 0열에 혼자 둔다"
    - "{%- 공백 제어는 아무것도 내보내지 않는 if/endif에만 쓴다 (render-if-present 줄)"
    - "레이아웃 본문 자리는 0열 {{ content | rstrip }}"
    - "원본 줄은 다시 치지 않고 기준 커밋 사본에서 스크립트로 잘라 옮긴다 (행 수·글자를 assert로 확인)"
    - "커밋 전에는 지정 파일만 스테이징한 git write-tree로, 커밋 뒤에는 커밋으로 compare.sh를 돌린다"

key-files:
  created:
    - _layouts/legal.html
    - _includes/header.html
    - _includes/footer.html
    - _includes/head-links.html
    - _includes/css/common.css
  modified:
    - terms/index.html
    - privacy-policy/index.html
    - data-deletion/index.html
    - .planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md

key-decisions:
  - "법적 3종 전환을 커밋 세 개로 남김 (tracer 이용약관, 나머지 두 문서, head 링크·「공통」 CSS include). 세 커밋 모두 기준 db505d71d3d2와 네 문서 바이트 동일, _site 파일 목록 동일(11개)"
  - "사이트 커밋 제목에 오케스트레이터 요청대로 (02-04) 범위를 붙임: refactor(02-04): … (계획 verification 문구는 refactor:)"
  - "description·eyebrow는 render-if-present 대상이 아님. 값이 없으면 빈 문자열로 나오므로 legal 레이아웃을 쓰는 새 페이지는 두 값을 채워야 함 (falsy 시험에서 관찰)"

patterns-established:
  - "법적 페이지 = front matter(layout·title·description·eyebrow·[heading]·updated·noindex) + 카드 본문. noindex와 「임시 게시본」 문단은 페이지 파일에 둬서 Phase 6·7·8이 한 줄·한 문단만 지우면 되게 함"
  - "헤더 변형은 include 매개변수: 레이아웃은 {% include header.html %}, 랜딩(02-06)은 home=true"

requirements-completed: [SHELL-01]

coverage:
  - id: D1
    description: "이용약관이 legal 레이아웃과 헤더·푸터 include로 그려지고 출력이 기준과 바이트 동일 (tracer, LEGAL_CONV_SHA_1=6994b6f27976)"
    requirement: SHELL-01
    verification:
      - kind: other
        ref: "02-04-PLAN Task 1 verify 1~3 (compare.sh db505d71d3d2 6994b6f27976 OK 5줄, front matter·include.home·끝 줄바꿈 검사, check-site HEAD 통과)"
        status: pass
    human_judgment: false
  - id: D2
    description: "개인정보처리방침·데이터 삭제 안내도 같은 레이아웃으로 전환, 출력 바이트 동일 (LEGAL_CONV_SHA_2=c13cf8a17b84)"
    requirement: SHELL-01
    verification:
      - kind: other
        ref: "02-04-PLAN Task 2 verify 1·3 (compare.sh OK 5줄, 푸터 마크업이 footer include와 index.html에만 있음, 세 페이지 front matter·noindex·임시 게시본·heading 검사)"
        status: pass
    human_judgment: false
  - id: D3
    description: "레이아웃이 값 생략을 견딤: title만 있는 시험 페이지에서 robots 줄·날짜 줄이 빠지고 h1이 title (FALSY_LAYOUT=OK)"
    requirement: SHELL-01
    verification:
      - kind: other
        ref: "02-04-PLAN Task 2 verify 2 (git archive HEAD + zz-falsy 시험 페이지 --safe 빌드)"
        status: pass
    human_judgment: false
  - id: D4
    description: "head 링크와 「공통」 CSS도 include 한 벌로 분리, Tailwind 두 블록은 레이아웃에만 남음, 출력 바이트 동일 (LEGAL_CONV_SHA_3=8cf18dd40673)"
    requirement: SHELL-01
    verification:
      - kind: other
        ref: "02-04-PLAN Task 3 verify 1~3 (compare.sh OK 5줄, git grep으로 Tailwind·manifest·「공통」 위치 검사, include 끝 줄바꿈 없음, check-site 통과, _layouts=legal.html, .editorconfig·.nojekyll 없음)"
        status: pass
    human_judgment: false

duration: 7min
completed: 2026-11-16
status: complete
---

# Phase 2 Plan 04: 법적 3종 legal 레이아웃·include 전환 Summary

**법적 문서 3종을 `_layouts/legal.html`과 include 네 개(header·footer·head-links·css/common.css)로 전환했다. 세 페이지 파일에는 front matter와 카드 본문만 남았고, 세 전환 커밋 모두 기준 커밋과 네 문서 바이트 동일, `_site` 파일 목록 동일(11개)이다**

## Performance

- **Duration:** 약 7분
- **Started:** 2026-11-16T03:28:59Z
- **Completed:** 2026-11-16T03:36:00Z
- **Tasks:** 3
- **Files modified:** 9 (사이트 8 + 검증 기록 1)

## Accomplishments

- `_layouts/legal.html`이 `<!DOCTYPE html>`부터 `</html>`까지 그린다. 기준 원본에서 바뀐 곳은 line_map의 9곳뿐이다 (title, description, noindex 감쌈, header, eyebrow, h1, updated 감쌈, content, footer). Task 3에서 head 링크와 「공통」 CSS 자리도 include가 됐다.
- 헤더는 `_includes/header.html` 한 벌이고 `include.home`이 참일 때만 랜딩 링크(`#top`·`#story`·`#demo`·`#get`)를 낸다. 레이아웃은 매개변수 없이 불러 `/`·`/#story`·`/#demo`·`/#get`을 낸다.
- 세 법적 페이지는 front matter(`layout: legal`, `title`, `description`, `eyebrow`, `updated`, `noindex: true`, 삭제 안내만 `heading`)와 원본 본문(「임시 게시본」 문단 포함)만 담는다. 글자와 경로는 바뀌지 않았다.
- 세 커밋 모두 `compare.sh <BASE_SHA> <커밋>` rc=0, 네 문서 「바이트 동일」, 파일 목록 동일(11개). 커밋 전 `git write-tree` 비교와 `scripts/check-site.sh <커밋>`도 모두 통과했다.
- title만 있는 시험 페이지로 render-if-present 분기를 확인했다. robots 줄과 날짜 줄이 빠지고 h1이 title이며, 빠진 자리에 빈 줄이 생기지 않는다.
- Tailwind `<script src>`와 `tailwind-config`는 HTML 가운데 `_layouts/legal.html`에만 있다 (옮기기만 함, 제거는 Phase 3). 레이아웃 폴더에는 `legal.html`만 있고 CSS는 `<style>` 안 include로 인라인된다.

## Task Commits

1. **Task 1: 이용약관 tracer 전환 (레이아웃·헤더·푸터 include)** - `6994b6f27976` (refactor) — 기준 대비 바이트 동일
2. **Task 2: 개인정보처리방침·데이터 삭제 안내 전환 + 값 생략 분기 시험** - `c13cf8a17b84` (refactor) — 기준 대비 바이트 동일, `FALSY_LAYOUT=OK`
3. **Task 3: head 링크·「공통」 CSS include 분리** - `8cf18dd40673` (refactor) — 기준 대비 바이트 동일, `CMP_LEGAL=OK`

**Plan metadata:** 이 SUMMARY와 `02-EVIDENCE.md`를 넣는 docs 커밋, 이어서 STATE·ROADMAP 진행 갱신 docs 커밋

Tracer feedback gate: 대화형(`auto_advance=false`)·`human_verify_mode=end-of-phase`·`<automated>`만 있는 verify라 Task 1 verify 세 명령을 커밋 뒤 다시 돌렸고 모두 exit 0이어서 Task 2로 넘어갔다 (checkpoint 없음).

## Files Created/Modified

- `_layouts/legal.html` - 법적 페이지 전체 틀. noindex·updated는 값이 있을 때만, h1은 `heading | default: title`
- `_includes/header.html` - 헤더 14줄, href 네 곳만 `include.home` 분기 (끝 줄바꿈 없음)
- `_includes/footer.html` - 푸터 24줄 (끝 줄바꿈 없음)
- `_includes/head-links.html` - preconnect부터 manifest까지 8줄 (끝 줄바꿈 없음)
- `_includes/css/common.css` - 「공통」 CSS 28줄, 머리 주석 원본 그대로 (끝 줄바꿈 없음, 주석 갱신은 02-08)
- `terms/index.html`, `privacy-policy/index.html`, `data-deletion/index.html` - front matter + 카드 본문
- `.planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md` - `## 02-04 법적 3종 전환` 구간과 표식 줄 다섯 개

## Decisions Made

- 원본 줄은 기준 커밋(`BASE_SHA`)의 `git show` 사본에서 Python 스크립트로 잘라 옮겼다. 행 수(200·174·151), title·description·eyebrow·h1·날짜 줄, 본문 첫·끝 줄을 assert로 확인한 뒤 썼다. Task 3도 레이아웃의 행 번호가 아니라 기준 원본과 글자가 같은 블록을 한 번씩만 찾아 바꿨다 (조건문 감쌈으로 행 번호가 밀렸기 때문).
- 사이트 커밋 제목은 오케스트레이터 요청대로 `refactor(02-04): …` 꼴로 썼다. 한국어 제목 글자는 계획 그대로다.
- description·eyebrow는 값이 없으면 빈 문자열로 나온다. 이번 범위의 render-if-present 대상(noindex·updated·heading)이 아니므로 레이아웃은 바꾸지 않고 기록에만 남겼다.

## Deviations from Plan

### 계획과 다른 점

**1. [오케스트레이터 지시] 커밋 제목에 `(02-04)` 범위 추가**
- **Found during:** Task 1 커밋
- **Issue:** 계획 verification은 「세 커밋 모두 `refactor:`로 시작」이라고 적었지만, 오케스트레이터는 계획의 커밋을 제목으로 찾을 수 있게 `(02-04)` 범위를 붙이라고 요청했다
- **Fix:** `refactor(02-04): <계획의 한국어 제목>` 꼴로 커밋. prefix 종류(`refactor`)와 제목 글자는 계획과 같다
- **Files modified:** 없음 (커밋 메시지만)
- **Verification:** `git log --oneline -3 -- _layouts _includes terms privacy-policy data-deletion`에 세 커밋이 모두 `refactor(02-04):`로 보인다
- **Committed in:** 6994b6f27976, c13cf8a17b84, 8cf18dd40673

---

**Total deviations:** 1 (자동 수정 0, 오케스트레이터 지시에 따른 메시지 형식 1)
**Impact on plan:** 출력·파일 내용에는 영향이 없다.

## Issues Encountered

- Task 2 값 생략 시험에서 임시 폴더를 지우는 `rm -rf`가 안전 검사로 막혔다. 시험은 지우는 단계 없이 다시 돌려 통과했다. 시험용 임시 폴더 하나(`$TMPDIR` 아래 `rp-falsy.*`)가 저장소 밖에 남아 있다. 저장소와 출력에는 영향이 없다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 02-05: 세 전환 커밋(`LEGAL_CONV_SHA_1`·`_2`·`_3`)이 푸시 ② 후보다. 원격 main은 여전히 `PUSH1_SHA`(`d5a6679631d7`)이고 이 계획은 푸시하지 않았다 (D-15, D-16).
- 02-06: 랜딩은 이번에 만든 include 네 개를 그대로 쓴다 (`{% include header.html home=true %}`). `index.html`은 이 계획에서 바뀌지 않았다.
- 02-08: `_includes/css/common.css` 머리 주석 두 번째 줄 갱신은 별도 커밋으로 남아 있다 (D-06).

---
*Phase: 02-jekyll-shared-shell-refactor*
*Completed: 2026-11-16*

## Self-Check: PASSED

- 만든 파일 5개와 SUMMARY가 있다. 세 전환 커밋(6994b6f27976, c13cf8a17b84, 8cf18dd40673)이 HEAD의 조상이다.
- 세 task의 verify 9개 명령이 모두 exit 0. 계획 verification: index.html 미변경(기준 대비), 원격 main은 d5a6679631d7 그대로(푸시 안 함), SUMMARY·EVIDENCE 누출 검사와 로컬 경로 검사 걸린 줄 없음.
