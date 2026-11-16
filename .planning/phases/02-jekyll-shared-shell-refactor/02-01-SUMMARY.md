---
phase: 02-jekyll-shared-shell-refactor
plan: 01
subsystem: infra
tags: [jekyll, bundler, github-pages, git-hooks, pre-push, bash]

requires:
  - phase: 01
    provides: 기준 문서(.planning/baseline/)와 Ground Rules. Phase 2 시작 커밋을 비교 기준으로 씀
provides:
  - 로컬 Jekyll 3.10.0 빌드 (Gemfile·Gemfile.lock, gem은 vendor/bundle)
  - _config.yml url과 exclude 열 항목
  - 푸시 전 점검 scripts/check-site.sh (빌드·내부 파일·.nojekyll·제목·Liquid 원문)
  - main 푸시 때 점검을 돌리는 .githooks/pre-push (core.hooksPath=.githooks)
  - 검증 기록 02-EVIDENCE.md와 표식 줄 BASE_SHA·BUILD_CONFIG_SHA·HOOK_SHA·CMP_BUILD·INJECT
  - 스크래치 도구 compare.sh·norm_nocomment.py·inject.sh (저장소 밖, 커밋 안 함)
affects: [02-02, 02-03, 02-04, 02-05, 02-06, 02-07, 02-08, 02-09, 02-10]

actuals:
  tokens: 3949
  tasks: 2
  commits: 2
plan_head_before: db505d71d3d2410643a3ffed06cd8d7ee377c7e9
plan_head_after: 7f13a622878bf29aae057a3c8baa0773364a919f

tech-stack:
  added: [jekyll 3.10.0, liquid 4.0.4, kramdown-parser-gfm 1.1.0, webrick 1.9.2, csv, base64, bigdecimal, logger, Bundler 4.0.23]
  patterns:
    - "git archive 사본을 JEKYLL_ENV=production jekyll build --safe로 빌드해 점검·비교 (작업 트리의 gitignore 파일이 섞이지 않음)"
    - "임시 폴더는 pwd -P로 실제 경로로 바꾼 뒤 빌드 (macOS /var 심볼릭 링크와 --safe include 검사)"
    - "변수 경로 삭제는 rm -rf \"${WORK:?}\" 꼴로만"
    - "새 worktree에 .bundle/config가 없으면 메인 체크아웃의 Gemfile·gem을 BUNDLE_GEMFILE로 씀"

key-files:
  created:
    - Gemfile
    - Gemfile.lock
    - scripts/check-site.sh
    - .githooks/pre-push
    - .planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md
  modified:
    - _config.yml
    - .gitignore

key-decisions:
  - "기준 커밋 BASE_SHA=db505d71d3d2 (Phase 2 첫 사이트 커밋 전 HEAD)"
  - "check-site.sh 2번 항목에 빌드 원본의 .nojekyll 검사를 더함 (운영만 Jekyll을 건너뛰어 include 원문·내부 문서가 공개되는 경우, 로컬 빌드로는 못 잡음)"
  - "use_worktrees가 true인 채로 실행했지만 precondition(메인 체크아웃)이 충족되어 진행. 설정 파일은 고치지 않음"

patterns-established:
  - "푸시 전 점검: scripts/check-site.sh <커밋> — 빌드 성공, 내부 파일·.nojekyll 부재, 기존 URL 문서 4개와 제목, Liquid 원문 부재"
  - "훅 시험은 원격 푸시 없이 표준 입력 줄을 .githooks/pre-push에 직접 넣어 한다"

requirements-completed: [SHELL-02, SHELL-03]

coverage:
  - id: D1
    description: "로컬 Jekyll 3.10.0 빌드 고정 (Gemfile·Gemfile.lock, 직접 의존성 7개, liquid 4.0.4)"
    requirement: SHELL-02
    verification:
      - kind: other
        ref: "test \"$(bundle exec jekyll -v)\" = 'jekyll 3.10.0' && DEPENDENCIES 7개 일치 (Task 1 verify 2)"
        status: pass
    human_judgment: false
  - id: D2
    description: "보강한 exclude로 빌드해도 기준 커밋과 네 문서 바이트 동일, _site 파일 목록 동일(11개)"
    requirement: SHELL-03
    verification:
      - kind: other
        ref: "compare.sh db505d71d3d2 7773b163f3de / compare.sh db505d71d3d2 7f13a622878b (OK 5줄)"
        status: pass
    human_judgment: false
  - id: D3
    description: "푸시 전 점검 스크립트와 pre-push 훅이 켜지고 다섯 가지 실패를 잡음"
    requirement: SHELL-03
    verification:
      - kind: other
        ref: "inject.sh (PASS 주입-a~e), pre-push 표준 입력 시험 (main 통과, 다른 ref 출력 없음)"
        status: pass
    human_judgment: false

duration: 8min
completed: 2026-11-16
status: complete
---

# Phase 2 Plan 01: Jekyll 3.10.0 로컬 빌드 설정과 푸시 전 점검 Summary

**운영과 같은 Jekyll 3.10.0을 vendor/bundle에 고정하고, exclude를 열 항목으로 보강해도 출력이 기준 커밋과 바이트 단위로 같음을 증명한 뒤, main 푸시마다 빌드·내부 파일·.nojekyll·제목·Liquid 원문을 점검하는 pre-push 훅을 켰다**

## Performance

- **Duration:** 약 8분
- **Started:** 2026-11-16T01:41:51Z
- **Completed:** 2026-11-16T01:50Z
- **Tasks:** 2
- **Files modified:** 7 (사이트 커밋 6 + 검증 기록 1)

## Accomplishments

- 기준 커밋 `BASE_SHA=db505d71d3d2`를 기록했다 (Gemfile 없음, HEAD의 조상).
- `bundle exec jekyll -v` → `jekyll 3.10.0`. `Gemfile.lock`은 `liquid (4.0.4)`, 직접 의존성 7개, `CHECKSUMS` 포함, `BUNDLED WITH 4.0.23`.
- `compare.sh <기준> <빌드 설정 커밋 7773b163f3de>`와 `compare.sh <기준> <훅 커밋 7f13a622878b>` 모두 네 문서 「바이트 동일」, `_site` 파일 목록 동일(11개). Gemfile·`scripts/`·`.githooks/`가 출력에 새지 않는다.
- `scripts/check-site.sh`가 작업 트리와 `HEAD` 모두 `check-site: 통과`. `inject.sh`의 다섯 실패 주입(Gemfile 노출, 제목 변경, 빌드 실패, Liquid 원문, `.nojekyll`)이 모두 rc=1과 기대 문구로 잡혔다.
- `.githooks/pre-push`에 표준 입력 줄을 직접 넣어 시험: main 줄은 점검 통과, 다른 ref는 출력 없이 0. 원격으로는 푸시하지 않았다 (`origin/main`은 시작 때와 같은 `c4cb26d754e9`).

## Task Commits

1. **Task 1: 기준 커밋 기록과 Jekyll 3.10.0 로컬 빌드 설정 (tracer)** - `7773b163f3de` (build)
2. **Task 2: 푸시 전 점검 스크립트와 pre-push 훅** - `7f13a622878b` (build)

**Plan metadata:** 이 SUMMARY와 `02-EVIDENCE.md`를 넣는 docs 커밋

Tracer feedback gate: 대화형·`end-of-phase`·`<automated>`만 있는 verify라 Task 1 verify 일곱 명령을 커밋 뒤 다시 돌렸고 모두 exit 0이어서 Task 2로 넘어갔다 (checkpoint 없음).

## Files Created/Modified

- `Gemfile` - jekyll 3.10.0 고정과 Ruby 4에서 빠진 표준 라이브러리 gem
- `Gemfile.lock` - Bundler 생성물 (liquid 4.0.4, sha256 CHECKSUMS)
- `_config.yml` - 3행 빌드 서술을 사실대로 고침, 기본 제외 목록이 덮어써진다는 주석, `url`, exclude 열 항목
- `.gitignore` - `_site/`, `.jekyll-cache/`, `vendor/`, `.bundle/`
- `scripts/check-site.sh` - 푸시 전 점검 네 가지 (+ `.nojekyll` 검사 한 줄), 모드 100755
- `.githooks/pre-push` - main 푸시 줄마다 check-site.sh 호출, 모드 100755
- `.planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md` - 기준·비교·주입 결과와 표식 줄

로컬 설정(커밋 안 함): `.bundle/config`의 `BUNDLE_PATH: "vendor/bundle"`, `.git/config`의 `core.hooksPath = .githooks`.
스크래치(저장소 밖 `$TMPDIR/rp-phase2`, 커밋 안 함): `compare.sh`, `norm_nocomment.py`, `inject.sh`.

## Decisions Made

- `check-site.sh`는 RESEARCH 583-669행 전문에서 `.nojekyll` 검사 한 줄만 더했다 (계획 지시, T-02-05). `diff`로 다른 곳이 그 한 줄뿐임을 확인했다.
- `inject.sh`는 시험용 worktree를 메인 체크아웃과 다른지 먼저 확인하고, 모든 경로를 `${WT:?}` 꼴로 쓰며, 실행 앞뒤의 메인 `git status --porcelain`을 비교한다. 출력 문구의 로컬 경로는 `<WT>`·`<MAIN>`으로 바꾼다.
- 커밋 제목은 계획의 한국어 제목에 실행 범위 `build(02-01):`를 붙였다.

## Deviations from Plan

None - plan executed exactly as written.

참고: 계획 objective는 `workflow.use_worktrees`를 `false`로 바꾼 뒤 실행하라고 하지만 설정은 `true`였다. Task 1 precondition(메인 체크아웃: `--git-dir`과 `--git-common-dir`이 같음, Ruby 4.0.9, bundle 존재)이 충족되어 그대로 진행했고, 설정 파일은 고치지 않았다 (사용자 결정 사항).

## Issues Encountered

None

## User Setup Required

None - 외부 서비스 설정 없음. 다른 컴퓨터나 새 클론에서는 `bundle config set --local path vendor/bundle`, `bundle install`, `git config core.hooksPath .githooks`를 한 번 해야 한다 (CLAUDE.md 반영은 이후 계획의 문서 단계).

## Next Phase Readiness

- 02-02(D-15 ① 빌드 설정 푸시)가 쓸 `BASE_SHA`, `BUILD_CONFIG_SHA`, `HOOK_SHA`, 비교 도구, 훅이 준비됐다.
- 푸시는 하지 않았다. 첫 공개 푸시는 02-02의 사람 결정이다.

---
*Phase: 02-jekyll-shared-shell-refactor*
*Completed: 2026-11-16*

## Self-Check: PASSED

- 파일 5개 존재, 커밋 `7773b163f3de`·`7f13a622878b`가 HEAD의 조상, Task 1 verify 7개·Task 2 verify 6개 exit 0, 누출 정규식 검사와 로컬 경로 검사 0건, `origin/main` 변화 없음
