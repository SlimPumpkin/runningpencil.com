---
phase: 02-jekyll-shared-shell-refactor
plan: 09
subsystem: docs
tags: [jekyll, claude-md, codebase-map, readme, check-site]

requires:
  - phase: 02-jekyll-shared-shell-refactor
    provides: "02-08의 원본 맵(STACK·CONVENTIONS·ARCHITECTURE) 갱신, 02-01의 scripts/check-site.sh·.githooks/pre-push·Gemfile, 02-04·02-06의 include·legal 레이아웃 전환"
provides:
  - "루트 CLAUDE.md의 로컬 빌드·미리보기·훅·점검 명령, include·레이아웃 설명, raw·include 공백 규칙, pre-push 점검 설명"
  - "두 CLAUDE.md 방침 구간의 「Jekyll 빌드 전환」 행 = Phase 2 적용됨, Phase 3 남음"
  - "원본 맵에서 다시 생성한 .claude/CLAUDE.md (stack·conventions·architecture 블록)"
  - "README의 명령 다섯 줄, TESTING·STRUCTURE·CONCERNS 맵의 지금 구조 서술과 행 참조"
affects: [02-10, phase-03-tailwind, phase-05, phase-09]

actuals:
  tokens: 10541
  tasks: 3
  commits: 3
plan_head_before: 781e9c4a0436e446e33535cbd2baf6e26dca689b
plan_head_after: 2079ea4e0b25b5e2a8b61da61c4a90cdf54ff23f

tech-stack:
  added: []
  patterns:
    - "공통 블록 한 벌 확인: git grep -lF <표식> -- '*.html' ('*.css') 출력이 include 파일 하나여야 한다"
    - "방침 구간은 두 사본에 같은 스크립트 치환으로 고치고, 생성 구간은 사본 시험 뒤 generate-claude-md로만 다시 만든다"

key-files:
  created:
    - .planning/phases/02-jekyll-shared-shell-refactor/02-09-SUMMARY.md
  modified:
    - CLAUDE.md
    - .claude/CLAUDE.md
    - README.md
    - .planning/codebase/TESTING.md
    - .planning/codebase/STRUCTURE.md
    - .planning/codebase/CONCERNS.md
    - .planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md

key-decisions:
  - "02-09: 두 CLAUDE.md 문서 커밋 8fd222b50994. 생성기 사본 시험에서 바뀐 블록은 stack·conventions·architecture뿐이고 방침 구간·project·workflow는 그대로여서 저장소에서 --auto 없이 재생성함"
  - "02-09: TESTING의 한 벌 확인 git grep은 경로를 '*.html'·'*.css'로 좁힘. 문자열을 인용한 .planning 문서가 걸리지 않게 하기 위해서"

patterns-established:
  - "새 문장에서 Phase 2를 가리킬 때는 「Phase 2 적용됨」「해결: Phase 2」처럼 쓰고 조사 「에서」를 붙이지 않는다"

requirements-completed: [SHELL-02]

coverage:
  - id: D1
    description: "루트 CLAUDE.md에 운영과 같은 Jekyll 3.10.0 빌드의 미리보기·훅·점검 명령과 include·레이아웃·raw 규칙이 있고, 문서의 명령이 실제로 돈다"
    requirement: SHELL-02
    verification:
      - kind: other
        ref: "02-09-PLAN Task 1 verify 4 (명령 문자열 grep + bundle check + scripts/check-site.sh 통과)"
        status: pass
    human_judgment: false
  - id: D2
    description: "두 CLAUDE.md의 방침 구간이 글자까지 같고 「Jekyll 빌드 전환」 행이 Phase 2 적용됨·Phase 3 남음이며, .claude/CLAUDE.md가 재생성 결과와 바이트가 같다"
    requirement: SHELL-02
    verification:
      - kind: other
        ref: "02-09-PLAN Task 1 verify 1·2·5 (구간 비교, 재생성 cmp, 한 커밋 두 파일 + 누출 검사)"
        status: pass
    human_judgment: false
  - id: D3
    description: "CLAUDE.md 두 사본, README, .planning/codebase/*.md 어디에도 정적 서버 안내와 Phase 2 시한·예고 문장이 없다 (성공 기준 3)"
    requirement: SHELL-02
    verification:
      - kind: other
        ref: "02-09-PLAN Task 3 verify 2 (SC3 전체 grep 0건)"
        status: pass
    human_judgment: false
  - id: D4
    description: "README·TESTING·STRUCTURE·CONCERNS가 로컬 빌드·점검 스크립트·include 구조를 적고 행 참조가 지금 파일과 맞는다"
    requirement: SHELL-02
    verification:
      - kind: other
        ref: "02-09-PLAN Task 2 verify 1~4, Task 3 verify 1·3·4"
        status: pass
    human_judgment: false
  - id: D5
    description: "운영자가 문서의 명령으로 bundle exec jekyll serve --livereload를 띄워 네 페이지가 전환 전과 같은 모양으로 열리고 링크가 동작하며 콘솔 오류가 없다"
    requirement: SHELL-02
    verification: []
    human_judgment: true
    rationale: "Task 2 human-check. 서버를 띄워 브라우저로 모양·링크·콘솔을 보는 일은 grep으로 확인할 수 없다 (end-of-phase 수집 대상)"

duration: 8min
completed: 2026-11-16
status: complete
---

# Phase 2 Plan 09: 문서 갱신 (CLAUDE.md·README·원본 맵) Summary

**두 CLAUDE.md를 한 커밋으로 Jekyll 공유 셸·로컬 빌드(bundle·jekyll serve·pre-push check-site) 안내로 바꾸고 .claude/CLAUDE.md를 원본에서 재생성했으며, README·TESTING·STRUCTURE·CONCERNS에서 정적 서버 안내를 걷어내고 행 참조를 지금 파일에 맞춤**

## Performance

- **Duration:** 8 min
- **Started:** 2026-11-16T05:54:12Z
- **Completed:** 2026-11-16T06:02:35Z
- **Tasks:** 3
- **Files modified:** 7 (문서 6 + 검증 기록 1)

## Accomplishments

- 루트 `CLAUDE.md`: Local preview를 명령 다섯 줄(`bundle config set --local path vendor/bundle`, `bundle install`, `bundle exec jekyll serve --livereload`, `git config core.hooksPath .githooks`, `scripts/check-site.sh`)과 Homebrew Ruby·livereload·CDN 주의로 바꿈. Pages 구간의 복사 공유 문단을 include 네 개·`layout: none`·`_layouts/legal.html`·front matter 키·`{% raw %}` 규칙·include 공백 규칙으로 바꿈. Deploy 구간에 pre-push 점검과 `--no-verify`를 적음
- 방침 구간 두 사본의 「Jekyll 빌드 전환」 현재 상태를 같은 글자로 고침(「작업 규칙」은 그대로). `.claude/CLAUDE.md` 생성 구간은 사본 시험 뒤 `generate-claude-md`로 재생성함
- `README.md`·`TESTING.md`·`STRUCTURE.md`·`CONCERNS.md`를 지금 구조로 고침. TESTING에 check-site(린터 대체)와 한 벌 확인 `git grep` 네 줄을 넣었고, STRUCTURE·CONCERNS의 전환 전 행 번호는 `grep -n`으로 다시 찾아 고쳤으며, CONCERNS의 공유 블록 복제 우려를 「해결: Phase 2」로 정리함
- 성공 기준 3 전체 grep 0건 (`SC3_GREP=OK`)

## Task Commits

1. **Task 1: 두 CLAUDE.md 갱신 + 재생성 + 명령 실행 확인 (tracer)** - `8fd222b50994` (docs)
2. **Task 2: README·TESTING·STRUCTURE 갱신** - `4da23cee314e` (docs)
3. **Task 3: CONCERNS 정리·행 참조 갱신, SC3 grep** - `2079ea4e0b25` (docs)

**Plan metadata:** SUMMARY·EVIDENCE·STATE·ROADMAP 커밋 (이 문서 다음 커밋)

## 생성기 시험 결과 (Task 1)

- 방침 구간을 고친 `.claude/CLAUDE.md`를 저장소 밖 사본으로 `generate-claude-md --output`에 돌림. diff 묶음은 원본 60~393행 안에만 있었음: **stack**(53~102행), **conventions**(104~260행), **architecture**(262~402행) 블록
- 바뀌지 않은 곳: 마커 위 방침 구간(1~30행), project·skills·workflow·profile 블록
- 저장소에서 `--output`·`--auto` 없이 돌린 결과가 사본과 바이트가 같음(`cmp`). verify 2(재생성 cmp)도 통과

## 성공 기준 3 grep 결과

대상 `CLAUDE.md`, `.claude/CLAUDE.md`, `README.md`, `.planning/codebase/*.md`:
- `python3 -m http.server` 0건, `Phase 2까지` 0건, `Phase 2에서` 0건, `복사해서 공유` 0건

## Files Created/Modified

- `CLAUDE.md` - 방침 행, Repository purpose, Pages(include·레이아웃·raw·공백 규칙), Local preview, Architecture 노트(토큰·`.rp-grid`·글꼴·로고 위치), Deploy
- `.claude/CLAUDE.md` - 방침 행(손 편집), stack·conventions·architecture 블록(재생성)
- `README.md` - Jekyll 조립 설명과 명령 다섯 줄
- `.planning/codebase/TESTING.md` - Runner(check-site), Run Commands, 점검 목록 6, 한 벌 확인 `git grep`, E2E 문단, 내부 링크 점검 포트 4000
- `.planning/codebase/STRUCTURE.md` - 디렉터리 배치(새 파일·로컬 전용 폴더), 행 지도, Testing, 새 페이지 추가 방법
- `.planning/codebase/CONCERNS.md` - 범위 문단, 공유 블록 우려 해소, 행 참조 전부 갱신
- `.planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md` - `## 02-09 문서` 구간 (`DOCS_CLAUDE_SHA=8fd222b50994`, `SC3_GREP=OK`)

## Decisions Made

- 한 벌 확인 `git grep`은 경로를 `'*.html'`(「공통」 머리 주석은 `'*.css'`도)로 좁혔다. 좁히지 않으면 같은 문자열을 인용한 `.planning/` 문서(TESTING.md 자신 포함)가 걸려 「한 파일」 판정이 깨진다
- EVIDENCE는 Task 1의 `<files>`에 있지만, verify 5(커밋이 두 CLAUDE.md만 담음)와 context 규칙(EVIDENCE는 SUMMARY 커밋에)에 따라 Task 1 커밋에서 빼고 SUMMARY 커밋에 넣었다

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] TESTING의 내부 링크 점검 명령이 사라진 정적 서버 포트를 가리킴**
- **Found during:** Task 2
- **Issue:** 「내부 링크 점검 (서버 실행 중)」 명령이 `http://localhost:8000`을 써서, 정적 서버 안내를 지운 뒤에는 문서대로 돌리면 실패함
- **Fix:** 머리를 `bundle exec jekyll serve` 실행 중으로, 주소를 `http://localhost:4000`으로 바꿈. 명령 확인 날짜 문장에 새 한 벌 확인 명령의 확인일(2026-11-15)을 더함
- **Files modified:** `.planning/codebase/TESTING.md`
- **Committed in:** `4da23cee314e`

**2. [Rule 1 - Bug] 지금 구조와 어긋난 문장을 같은 파일 안에서 함께 고침**
- **Found during:** Task 1·3
- **Issue:** 계획이 짚은 곳 밖에도 지금과 다른 서술이 남아 있었음. 루트 CLAUDE.md의 Pretendard `<link>` 위치와 헤더·푸터 로고 위치, CONCERNS의 「토큰 정의 3개 파일 복제」「CI·검사 없음」「단일 대형 index.html 653줄·빌드 없음」이 그런 예
- **Fix:** 각각 `_includes/head-links.html`, `_includes/header.html`·`footer.html`, 레이아웃 한 곳, pre-push check-site 범위, 586줄·72KB로 고침. 대상 파일은 계획의 `files_modified` 안에 있음
- **Committed in:** `8fd222b50994`, `2079ea4e0b25`

---

**Total deviations:** 2 auto-fixed (2 Rule 1)
**Impact on plan:** 고친 곳은 모두 문서 사실 정정이고 계획 대상 파일 안에 있음. 사이트 파일은 바꾸지 않음

## Issues Encountered

None

## User Setup Required

None - 외부 서비스 설정 없음.

## Next Phase Readiness

- D-15 네 번째 푸시(02-10)에 실을 문서 커밋 세 개가 준비됨. 그 앞에는 02-08의 「공통」 주석 커밋과 원본 맵 커밋이 있음. 이 계획에서는 푸시하지 않음
- end-of-phase human-check: `bundle exec jekyll serve --livereload`로 네 페이지 모양·링크·콘솔 확인 (D5)

## Self-Check: PASSED

- 파일: `CLAUDE.md`, `.claude/CLAUDE.md`, `README.md`, `.planning/codebase/TESTING.md`·`STRUCTURE.md`·`CONCERNS.md`, `02-EVIDENCE.md`, 이 SUMMARY 모두 있음
- 커밋: `8fd222b50994`, `4da23cee314e`, `2079ea4e0b25` 모두 HEAD의 조상
- verify: Task 1의 다섯 명령, Task 2·3의 네 명령씩 모두 종료 코드 0. plan verification의 사이트 파일 무변경(`git diff --quiet HEAD~3 HEAD -- '*.html' _includes _layouts _config.yml`)도 0
- 푸시하지 않음

---
*Phase: 02-jekyll-shared-shell-refactor*
*Completed: 2026-11-16*
