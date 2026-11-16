---
phase: 02-jekyll-shared-shell-refactor
verified: 2026-11-16T07:13:37Z
status: passed
score: 14/14 must-haves verified
covered_files: [".claude/CLAUDE.md", ".githooks/pre-push", ".gitignore", ".planning/codebase/ARCHITECTURE.md", ".planning/codebase/CONCERNS.md", ".planning/codebase/CONVENTIONS.md", ".planning/codebase/STACK.md", ".planning/codebase/STRUCTURE.md", ".planning/codebase/TESTING.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-01-PLAN.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-01-SUMMARY.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-02-PLAN.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-02-SUMMARY.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-03-PLAN.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-03-SUMMARY.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-04-PLAN.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-04-SUMMARY.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-05-PLAN.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-05-SUMMARY.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-06-PLAN.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-06-SUMMARY.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-07-PLAN.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-07-SUMMARY.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-08-PLAN.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-08-SUMMARY.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-09-PLAN.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-09-SUMMARY.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-10-PLAN.md", ".planning/phases/02-jekyll-shared-shell-refactor/02-10-SUMMARY.md", "CLAUDE.md", "Gemfile", "Gemfile.lock", "README.md", "_config.yml", "_includes/css/common.css", "_includes/footer.html", "_includes/head-links.html", "_includes/header.html", "_layouts/legal.html", "data-deletion/index.html", "index.html", "privacy-policy/index.html", "scripts/check-site.sh", "terms/index.html"]
covered_digest: "v4:sha256:eff4dffa1db1dc6e96b0133eea61dbc86fdc23f4665976015eb4bbd80ab54626"
behavior_unverified: 0
overrides_applied: 0
human_verification:
  - test: "루트 CLAUDE.md의 Local preview 명령대로 `bundle exec jekyll serve --livereload`를 띄우고 http://localhost:4000 의 네 페이지(`/`, `/privacy-policy/`, `/terms/`, `/data-deletion/`)를 연다 (02-09 Task 2 human-check에서 가져옴)"
    expected: "네 페이지가 전환 전과 같은 모양으로 열린다. 헤더 메뉴(랜딩은 같은 페이지 안 이동, 법적 페이지는 `/#story` 등)와 푸터 링크가 동작하고, 브라우저 콘솔에 오류가 없다"
    why_human: "성공 기준 3은 운영자가 문서의 명령으로 미리보기를 「띄운다」는 경험이다. 서버를 띄워 브라우저로 보는 일은 grep으로 확인할 수 없다 (검증자는 서버를 띄우지 않음)"
  - test: "ROADMAP §Phase 2 성공 기준 1의 문구(「차이가 0」)를 D-06 예외(「공통」 CSS 머리 주석 한 줄 × 4문서)에 맞게 고칠지, 아니면 아래 override를 받아들일지 정한다"
    expected: "문구를 고치거나 override를 VERIFICATION.md frontmatter에 사람이 적는다. 어느 쪽이든 판정 문구와 실제 최종 출력이 어긋나지 않게 된다"
    why_human: "D-06(2026-11-15 논의)에서 문구 결정은 사용자 몫으로 남겼다. 검증자는 D-06 기준으로 충족 판정했지만 문구 그대로 읽으면 최종 상태 strict diff는 0이 아니다"
  - test: "unverified-prohibition — human review recommended: 푸시 ①~④와 기준 커밋 푸시가 각각 사람이 그 SHA를 보고 명시적으로 승인한 뒤에만 일어났는지, 그리고 실행자가 `git push --no-verify`를 쓰지 않았는지 확인한다"
    expected: "다섯 번의 푸시 모두 승인 단계에서 보여 준 SHA와 실제 푸시 SHA가 같고(`02-EVIDENCE.md`의 PUSH1~4_SHA, BASE_PUSH_SHA), `--no-verify`는 쓰이지 않았다"
    why_human: "judgment-tier 금지 사항이다. 승인 여부와 `--no-verify` 사용 여부는 git 이력·Pages 빌드 기록에 흔적이 남지 않는다. 검증자가 볼 수 있는 것은 푸시가 모두 fast-forward였다는 것과 각 푸시 SHA가 Pages 빌드 기록에 built·오류 없음으로 있다는 것뿐이다 (비권위 판정: 위반 흔적 없음)"
---

# Phase 2: Jekyll 공유 셸 도입 (Shared Shell Refactor) 검증 보고서

**Phase Goal:** 운영자가 head 링크·「공통」 CSS·헤더·푸터를 한 곳에서 고치면 모든 페이지에 반영되고, 이 전환으로 방문자가 보는 사이트 출력은 바뀌지 않는다
**Verified:** 2026-11-16T07:13:37Z
**Status:** human_needed
**Re-verification:** 아니요 — 첫 검증

SUMMARY와 `02-EVIDENCE.md`의 표식은 근거로 쓰지 않았습니다. 아래 판정은 검증자가 이번에 직접 돌린 명령의 결과입니다. 빌드는 운영과 같은 Jekyll 3.10.0(`bundle exec jekyll -v` → `jekyll 3.10.0`)으로 했습니다. 비교 도구 `$TMPDIR/rp-phase2/compare.sh`·`norm_nocomment.py`는 실행자가 만든 것이라 소스를 먼저 읽고 D-07 정규화(줄 앞뒤 공백·빈 줄만 지움)를 그대로 하는지 확인한 뒤 썼습니다. 성공 기준 2의 시험과 실패 주입은 실행자 도구를 쓰지 않고 저장소 밖 사본에서 따로 했습니다.

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | (ROADMAP SC1) 로컬 Jekyll 3.10.0 빌드가 성공하고, 네 문서를 전환 전 HTML과 공백 정규화 diff로 비교하면 차이가 0이다 | ✓ VERIFIED (D-06 기준) | 기준 `db505d71d3d2`(HTML은 직전 라이브 `c4cb26d754e9`와 같음) 대비 전환 커밋 4개 `6994b6f27976`·`c13cf8a17b84`·`8cf18dd40673`·`762734f26068` 모두 네 문서 **바이트 동일**, `_site` 파일 목록 11개 동일. HEAD 엄격 비교는 문서마다 「공통」 머리 주석 한 줄만 다름(exit 1), 주석 제거 비교는 네 문서 모두 동일(exit 0). 이 한 줄은 D-06에서 승인된 예외. ROADMAP 문구는 예외 없이 「차이가 0」이라 사람 확인 항목으로 올림 |
| 2 | (ROADMAP SC2) 공통 블록 네 가지가 `_includes`/`_layouts`에 한 벌만 있고, 하나를 바꾸면 네 문서의 빌드 결과가 모두 바뀐다 | ✓ VERIFIED | `git grep -lF`(문서 제외): `<footer class="rp-foot">`→`_includes/footer.html`, `<header class="rp-head">`→`_includes/header.html`, `rel="manifest"`·Pretendard 링크→`_includes/head-links.html`, 「공통」 머리 주석·`.rp-foot-legal {`→`_includes/css/common.css`, Tailwind 두 블록→`_layouts/legal.html`. 검증자가 HEAD 사본에서 include 넷을 하나씩 바꿔 빌드: head-links 4/4, common.css 4/4, header 4/4, footer 4/4 |
| 3 | (ROADMAP SC3) 운영자는 `CLAUDE.md`의 명령(Jekyll 3.10.0 고정 Gemfile)으로 운영과 같은 빌드의 미리보기를 띄우고 푸시 전 빌드 성공을 확인한다. `python3 -m http.server` 안내는 없다 | ✓ VERIFIED (브라우저 확인은 사람 항목) | `CLAUDE.md:70-78`에 `bundle config set --local path vendor/bundle`·`bundle install`·`bundle exec jekyll serve --livereload`·`git config core.hooksPath .githooks`·`scripts/check-site.sh`. `scripts/check-site.sh HEAD` → 통과. pre-push 훅을 main 대상 입력으로 직접 돌려 통과(exit 0), main 아닌 ref는 건너뜀. 푸시 ④ SHA `9f715c795830`를 로컬에서 빌드한 네 문서가 라이브 응답과 **바이트 동일** → 지금 네 문서에 대해서는 로컬 빌드 = 운영 빌드. `python3 -m http.server`는 `CLAUDE.md`·`.claude/CLAUDE.md`·`README.md`·`.planning/codebase/*.md`에 0건 |
| 4 | (ROADMAP SC4) 라이브에서 내부 파일이 404이고, 기존 네 URL은 200과 전환 전과 같은 `<title>`을 돌려준다 | ✓ VERIFIED | 검증자가 https://runningpencil.com 을 직접 요청(쿼리 문자열 없음): 네 URL 200, 제목이 `db505d71d3d2` 원본 제목과 같음. 13경로(`/CLAUDE.md` `/README.md` `/Gemfile` `/Gemfile.lock` `/_config.yml` `/.planning/ROADMAP.md` `/.claude/CLAUDE.md` `/scripts/check-site.sh` `/.githooks/pre-push` `/_includes/footer.html` `/_layouts/legal.html` `/prepare/` `/vendor/`) 모두 404. 추가로 `/CLAUDE.html` `/README.html` `/.planning/REQUIREMENTS.md` `/.gitignore` `/.bundle/config` 등도 404. 라이브 본문은 기준 대비 주석 제거 정규화로 동일, 엄격 정규화로는 문서마다 주석 한 줄만 다름 |
| 5 | (02-01) `Gemfile`이 jekyll `= 3.10.0`을 고정하고 `Gemfile.lock` 직접 의존성은 일곱 개뿐이다 | ✓ VERIFIED | `Gemfile.lock` DEPENDENCIES: base64, bigdecimal, csv, jekyll (= 3.10.0), kramdown-parser-gfm, logger, webrick |
| 6 | (02-01) `_config.yml` 최상위 키는 `url`·`exclude`뿐이고 exclude 열 항목이 있다. `vendor/`·`.bundle/`·`_site/`·`.jekyll-cache/`는 무시되고 추적되지 않는다 | ✓ VERIFIED | `_config.yml` 확인. `.gitignore` 네 항목 있음, `git ls-files`에 해당 경로 0건 |
| 7 | (02-01·02-06) `check-site.sh`가 네 가지를 점검하고 실패 주입에서 0이 아닌 값으로 끝난다 | ✓ VERIFIED (WR-01 한계 있음) | 저장소 밖 클론에서 검증자가 주입: `.nojekyll` exit 1, 랜딩 제목 변경 exit 1, 랜딩 front matter 삭제 exit 1(Liquid 잔여), 새 `NOTES.md` exit 1, exclude에서 `CLAUDE.md` 삭제 exit 1. 단, raw로 감싸지 않은 `{{ oops }}`는 빈 문자열로 렌더되어 exit 0 (WR-01 재현) |
| 8 | (02-01) 훅·스크립트가 모드 100755로 추적되고 `core.hooksPath`가 `.githooks`이며 main 푸시마다 그 SHA를 점검한다 | ✓ VERIFIED | `git ls-files -s`: 둘 다 100755. `git config core.hooksPath` → `.githooks`. 훅 시뮬레이션 결과는 3번 행 |
| 9 | (02-04) 법적 3종 파일은 front matter + 본문만 담고 `_layouts/legal.html`이 render-if-present로 그린다 | ✓ VERIFIED | 세 파일 2행 `layout: legal`. 검증자가 title만 있는 시험 페이지를 빌드: noindex 줄 0, 「최종 업데이트」 줄 0, h1=title. 삭제 안내 h1=`heading`(「사용자 데이터 삭제 안내」) |
| 10 | (02-04) Tailwind는 `_layouts/legal.html` 한 곳에만 있고(옮기기만 함), 레이아웃은 `legal.html` 하나, 외부 CSS 파일 없음 | ✓ VERIFIED | `_layouts/` = `legal.html` 하나. `cdn.tailwindcss.com`·`tailwind-config`는 그 파일에만. `_site` 파일 목록이 기준과 같아 새 CSS 파일 없음 |
| 11 | (02-03·05·07·10) 각 푸시의 커밋이 원격 main의 조상이고 GitHub Pages가 오류 없이 빌드했다 | ✓ VERIFIED (승인 절반은 사람 항목) | `db505d71d3d2→d5a6679631d7→01f6bb8bbb13→e7e62f3f7990→9f715c795830` 모두 fast-forward, origin/main = `9f715c795830`. `gh api .../pages/builds`(읽기 전용): 다섯 커밋 모두 `built`, `error.message` null. 원격 추적 reflog도 다섯 번 모두 `update by push`. 「사람이 그 SHA를 승인한 뒤에만」은 흔적이 없어 사람 확인 항목 3 |
| 12 | (02-08·02-09) 문서가 지금 구조를 적는다: 두 `CLAUDE.md` 방침 구간이 같고, `.claude/CLAUDE.md`는 원본에서 재생성한 결과와 바이트가 같으며, 맵의 행 번호가 맞다 | ✓ VERIFIED | 방침 구간 diff 0. 저장소 밖 클론에서 `generate-claude-md` 실행 → `"action": "updated"`인데 diff 0(실제로 다시 써서 같음). 생성 구간 한 줄을 일부러 깨뜨린 뒤 재생성하면 그 줄이 복원됨(도구가 실제로 구간을 다시 씀). 단, 생성기에 빈 줄 흔들림이 있음: 깨뜨린 파일이나 stack 구간을 비운 파일에서 재생성하면 커밋본과 빈 줄 1~4개가 다름(`git diff --ignore-blank-lines`로는 0줄). 커밋본에서의 재생성은 바이트 동일하므로 계획의 기준(「재생성한 결과와 바이트가 같다」)은 충족 `ARCHITECTURE.md`의 `index.html:22-25`·`29-115`·`121-151`·`205`·`428-583`·`430-431`·`446`, `_layouts/legal.html:15`·`16-30`·`32`·`34-37`·`42`·`59` 표본이 지금 내용과 맞음 |
| 13 | (Ground Rule·02-04·02-06·02-08) 리팩터·주석·문서 변경이 커밋 단위로 나뉘고, 전환 커밋은 글자를 바꾸지 않았다 | ✓ VERIFIED | 커밋별 파일: 빌드 설정 `7773b163f3de`·`7f13a622878b`(html 없음), 전환 `6994b6f27976`·`c13cf8a17b84`·`8cf18dd40673`·`762734f26068`(html·include·layout만, 빌드 바이트 동일), 주석 `b11e43b49c0a`(`common.css` 한 줄만), 문서 `8fd222b50994`(두 CLAUDE.md만). ROADMAP diff는 체크박스·진행도 줄뿐이고 성공 기준 문구는 그대로 |
| 14 | (02-02·03·05·07·10) 각 푸시 직후 라이브 확인이 신선한 응답으로 통과했다: 네 URL 200·제목·정규화 본문 일치, 내부 파일 13경로 404, 응답 `Last-Modified` ≥ 그 푸시의 Pages 빌드 `created_at` | ✓ VERIFIED (외부 기록 대조) | 검증자가 `02-EVIDENCE.md`의 다섯 라이브 확인 구간(기준 커밋 푸시, 푸시 ①~④)을 GitHub Pages 빌드 기록과 대조: 다섯 구간 모두 `OK 빌드 <SHA> built <created_at>` 줄이 기록의 같은 커밋·같은 `created_at`·built·오류 없음 빌드와 일치(각 1건), `OK 문서` lm 4줄 중 `created_at`보다 이른 것 0, `OK 404` 13줄, `FAIL` 0, `live-check: 통과` 1줄. 02-10 Task 3 verify 4(표식 19개 + 모든 푸시의 Pages 빌드)도 `bash`로 돌려 exit 0. 중간 상태의 라이브를 지금 다시 볼 수는 없으므로 이 행의 근거는 「실행자 기록 + 실행자가 고칠 수 없는 외부 기록의 일치」이고, 최종 상태는 진실 4에서 검증자가 직접 확인 |

**Score:** 14/14 truths verified (0 present, behavior-unverified)

동작에 기대는 진실(1·2·3·7·8·9·12)은 모두 검증자가 직접 돌린 빌드·주입·시뮬레이션으로 확인했으므로 PRESENT_BEHAVIOR_UNVERIFIED로 남은 것은 없습니다.

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `Gemfile` / `Gemfile.lock` | Jekyll 3.10.0 고정 | ✓ VERIFIED | `verify.artifacts` 통과, 직접 의존성 7개 |
| `_config.yml` | url + exclude 10항목 | ✓ VERIFIED | 통과 |
| `scripts/check-site.sh` | 점검 네 가지 | ✓ VERIFIED | 통과, `EXPECTED_TITLES` 있음, 실행 통과 |
| `.githooks/pre-push` | main 푸시 점검 | ✓ VERIFIED | 통과, 시뮬레이션 통과 |
| `_layouts/legal.html` | 법적 페이지 틀 | ✓ VERIFIED | `{{ content \| rstrip }}`, 세 페이지가 사용 |
| `_includes/header.html` | 헤더 한 벌, `include.home` | ✓ VERIFIED | 네 문서가 사용 |
| `_includes/footer.html` | 푸터 한 벌 | ✓ VERIFIED | 네 문서가 사용 |
| `_includes/head-links.html` | head 링크 8줄 | ✓ VERIFIED | 네 문서가 사용 |
| `_includes/css/common.css` | 「공통」 CSS, 고친 머리 주석 | ✓ VERIFIED | 끝 줄바꿈 없음(include 공백 규칙), 머리 주석 「_includes/css/common.css 에서 불러 쓴다」 |
| `index.html` | include 네 곳 | ✓ VERIFIED | 21·27·153·426행, `layout: none`, `{{` 0건 |
| `CLAUDE.md`·`.claude/CLAUDE.md`·`README.md`·`.planning/codebase/*.md` | 새 빌드·점검 안내 | ✓ VERIFIED | `verify.artifacts`(02-08·02-09) 통과 |
| `02-EVIDENCE.md` | 기록과 판정표 | ✓ VERIFIED | 표식 있음. 단, 근거로는 쓰지 않고 검증자가 다시 확인함 |

10개 계획 `verify.artifacts`: 모두 exit 0 (25/25).

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `.githooks/pre-push` | `scripts/check-site.sh` | main ref마다 SHA 인자, stdin `/dev/null` | ✓ WIRED | 시뮬레이션 통과 |
| `scripts/check-site.sh` | `Gemfile` | `BUNDLE_GEMFILE=` | ✓ WIRED | |
| `terms/`·`privacy-policy/`·`data-deletion/index.html` | `_layouts/legal.html` | `^layout: legal$` | ✓ WIRED | 세 파일 2행 |
| `_layouts/legal.html` | head-links·common.css·header·footer | 0열 include | ✓ WIRED | 15·32·42·59행 |
| `index.html` | 네 include | 0열 include, header는 `home=true` | ✓ WIRED | 21·27·153·426행 |
| `.planning/codebase/*` | `.claude/CLAUDE.md` | `generate-claude-md` | ✓ WIRED | 재생성 바이트 동일 |

참고: `gsd-tools verify.key-links`는 02-04·05·06·07·10에서 `^…$` 패턴을 「not found」로 냈습니다(exit 1). 도구가 정규식에 multiline 플래그 없이 파일 전체에 맞추기 때문입니다(`/^layout: legal$/`는 여러 줄 문자열에서 false, `m` 플래그로는 true). 줄 단위 `grep -nE`로 같은 패턴이 모두 맞는 것을 확인했고, 성공 기준 2의 변경 시험(4/4 × 4)이 연결을 동작으로 증명하므로 도구의 거짓 음성으로 판정합니다.

### Data-Flow Trace (Level 4)

| Artifact | Data Variable | Source | Produces Real Data | Status |
|----------|---------------|--------|--------------------|--------|
| `_layouts/legal.html` | `page.title`·`description`·`eyebrow`·`heading`·`updated`·`noindex` | 법적 3종 front matter | 예 — 빌드 결과가 기준 원본과 바이트 동일 | ✓ FLOWING |
| `_includes/header.html` | `include.home` | `index.html:153` `home=true` / 레이아웃은 매개변수 없음 | 예 — 랜딩은 `#top`·`#story`, 법적은 `/`·`/#story` (바이트 동일 비교로 확인) | ✓ FLOWING |

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| 푸시 전 점검 | `scripts/check-site.sh HEAD` | `통과 (커밋 da31b74f5acc, jekyll 3.10.0)` | ✓ PASS |
| 전환 커밋 diff 0 | `compare.sh db505d71d3d2 <전환 커밋 4개>` | 네 문서 바이트 동일 ×4, 파일 목록 11개 동일 | ✓ PASS |
| 최종 상태 주석 제거 diff 0 | `compare.sh db505d71d3d2 HEAD --no-comments` | OK 5줄, exit 0 | ✓ PASS |
| 최종 상태 엄격 비교 | `compare.sh db505d71d3d2 HEAD` | 문서마다 「공통」 머리 주석 한 줄 차이, exit 1 | ✓ PASS (D-06 예외와 정확히 일치) |
| include 변경 전파 | 검증자 사본에서 include 넷 각각 변경 후 빌드 | 4/4 ×4 | ✓ PASS |
| 레이아웃 render-if-present | title만 있는 시험 페이지 빌드 | noindex 0, 날짜 0, h1=title | ✓ PASS |
| pre-push 훅 | main 대상 입력을 훅에 넣어 실행 | exit 0, 비 main ref 건너뜀 | ✓ PASS |
| 실패 주입 | `.nojekyll`·제목·front matter·새 md·exclude 삭제 | 다섯 모두 exit 1 | ✓ PASS |
| 로컬 빌드 = 운영 | `9f715c795830` 로컬 빌드 vs 라이브 네 문서 | 바이트 동일 | ✓ PASS |
| 라이브 URL·내부 파일 | `curl`로 네 URL + 13경로 | 200 ×4(제목 일치), 404 ×13 | ✓ PASS |
| Pages 빌드 기록 | `gh api repos/<slug>/pages/builds` | 다섯 푸시 모두 built, 오류 없음 | ✓ PASS |

### Probe Execution

| Probe | Command | Result | Status |
|-------|---------|--------|--------|
| (없음) | `find scripts -path '*/tests/probe-*.sh'`, PLAN·SUMMARY의 probe 선언 grep | 둘 다 0건 | 해당 없음 — 프로젝트 probe가 선언되지 않음. 실행자의 일회용 `$TMPDIR/rp-phase2/probe.sh` 결과(`SC2_PROBE`) 대신 검증자가 같은 시험을 따로 돌림(위 「include 변경 전파」) |

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| SHELL-01 | 02-04, 02-05, 02-06, 02-07, 02-08, 02-10 | head 링크·「공통」 CSS·헤더·푸터를 한 곳에서 고치면 모든 페이지에 반영, 전환 직후 출력 불변 | ✓ SATISFIED | 진실 1·2·9·10·13. 요구사항 괄호의 `_data`는 아직 없음 — 쓰는 곳이 없고 Phase 5(`_data` 슬롯)에서 생길 예정이라 결함으로 보지 않음 |
| SHELL-02 | 02-01, 02-03, 02-08, 02-09, 02-10 | 로컬에서 운영과 같은 Jekyll 3.10.0 빌드로 미리 보고 푸시 전 빌드 성공 확인 | ✓ SATISFIED (브라우저 미리보기는 사람 확인) | 진실 3·5·7·8·12 |
| SHELL-03 | 02-01, 02-02, 02-03, 02-05, 02-07, 02-10 | 라이브에서 내부 파일 404 | ✓ SATISFIED | 진실 4·6·7 |

REQUIREMENTS.md가 Phase 2에 매핑한 ID는 SHELL-01·02·03 셋이고 모두 계획 frontmatter에 있습니다. 고아(ORPHANED) 요구사항은 없습니다. SHELL-04는 Phase 3입니다.

### Prohibitions (judgment-tier, 비권위 판정)

| 금지 사항 (묶음) | 판정 | 근거 |
|---|---|---|
| 전환 커밋에서 법적·랜딩 글자·경로·스크립트·속성을 바꾸지 않는다 (02-04, 02-06) | 위반 없음 (결정적 근거) | 전환 커밋 빌드가 기준과 바이트 동일 |
| 주석 수정 커밋에서 다른 출력을 바꾸지 않는다 (02-08) | 위반 없음 (결정적 근거) | `b11e43b49c0a` diff는 한 줄, 엄격 비교 차이도 그 한 줄뿐 |
| 성공 기준 2 임시 시험을 커밋하거나 남기지 않는다 (02-06) | 위반 없음 | 이력에 시험 커밋 없음, 작업 트리에 사이트 파일 변경 없음 |
| `.claude/CLAUDE.md` 생성 구간을 손으로 고치지 않는다, 방침 구간 두 사본을 같은 커밋에서 고친다 (02-08, 02-09) | 위반 없음 (비권위 판정) | 커밋본에서 재생성하면 바이트 동일, 방침 구간 diff 0, `8fd222b50994`가 두 파일을 함께 바꿈. 다만 생성기가 입력에 따라 빈 줄을 다르게 내므로(진실 12) 「빈 줄만 손으로 맞췄을」 가능성까지 배제하는 결정적 근거는 아님 |
| 문서에 지원 이메일·사업자 값을 새로 적지 않는다 (02-09) | 위반 없음 | `git diff db505d71d3d2 HEAD -- CLAUDE.md .claude/CLAUDE.md README.md .planning/codebase`의 추가 줄에 이메일 형식·사업자등록번호 값 0건. 사이트 파일(html·include·layout)에도 이메일 형식 0건 |
| ROADMAP 성공 기준 문구를 실행자가 고치지 않는다, 판정표에서 주석 예외를 숨기지 않는다 (02-08, 02-10) | 위반 없음 | ROADMAP diff는 체크박스·진행도뿐. `02-EVIDENCE.md` 판정표가 예외와 문구 미수정을 적음 |
| force push·원격 이력 수정 금지 (02-02·03·05·07·10) | 위반 없음 (결정적 근거) | 다섯 푸시 모두 fast-forward, reflog `update by push` |
| 사람의 명시적 승인 없이, 또는 승인한 것과 다른 SHA를 푸시하지 않는다 / 첫 공개 범위를 보여 준다 (02-01~03·05·07·10) | **flagged — 흔적 없음** | 사람 확인 항목 3 |
| 실행자가 `--no-verify`를 쓰지 않는다 (02-01·02·03·05·07·10) | **flagged — 흔적 없음** | 사람 확인 항목 3 |

### Decision Coverage

`check.decision-coverage-verify`: CONTEXT.md 결정 19건 중 19건이 산출물에 반영됨 (`not_honored: []`). 상태 판정에는 영향 없음.

### Test Quality Audit

이 저장소에는 테스트 러너가 없고, 요구사항을 증명하는 장치는 점검 스크립트와 비교 도구입니다.

| Test File | Linked Req | Active | Skipped | Circular | Assertion Level | Verdict |
|-----------|-----------|--------|---------|----------|-----------------|---------|
| `scripts/check-site.sh` | SHELL-02, SHELL-03 | 4 항목 | 0 | 아니요 | Value (제목 문자열, 금지 경로 존재) | 유효. 단 4번 항목은 WR-01 한계 |
| `$TMPDIR/rp-phase2/compare.sh` (일회용) | SHELL-01 | 4문서 + 파일 목록 | 0 | 아니요 — 기대값은 기준 커밋 `db505d71d3d2`의 원본 HTML(전환 전 시스템 출력, 외부 오라클) | Value (정규화 전문 일치) | VALID provenance |
| 검증자의 include 변경 시험 | SHELL-01 | 4 include × 4문서 | 0 | 아니요 | Behavioral | 유효 |
| 라이브 비교 (curl) | SHELL-01, SHELL-03 | 4 URL + 13경로 | 0 | 아니요 — 기준 커밋 원본 제목·본문과 비교 | Value | VALID provenance |

**Disabled tests on requirements:** 0
**Circular patterns detected:** 0
**Insufficient assertions:** 0 (점검 4번의 탐지 범위 한계는 Anti-Patterns의 WR-01로 기록)

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `scripts/check-site.sh` | 40 | `XXX` (debt-marker grep 적중) | ℹ️ Info | `mktemp -d ".../rp-check.XXXXXX"`의 임시 이름 템플릿이지 부채 표시 주석이 아님. 차단 아님 |
| `scripts/check-site.sh` | 80-83 | 점검 4번이 raw 없이 쓴 `{{ … }}`를 못 잡음 (02-REVIEW WR-01) | ⚠️ Warning | 검증자가 재현(exit 0). 지금 출력에는 영향 없음(랜딩 `{{` 0건, 법적 본문 Liquid 0건). 성공 기준 3이 요구하는 「푸시 전 빌드 성공 확인」은 점검 1번이 하므로 SC3를 무너뜨리지 않음. 다만 `CLAUDE.md`의 raw 규칙 설명이 이 항목을 안전망처럼 적어 Phase 4(랜딩 JS 재작성)에서 잘못 믿을 위험이 있음 |
| `CLAUDE.md` | 81 | 「운영과 같은 출력은 `scripts/check-site.sh`가 만듭니다」 (WR-02) | ⚠️ Warning | 스크립트는 출력을 지우고, github-pages 기본 플러그인·테마도 돌리지 않으므로 문장이 과장됨. 그러나 지금 네 문서는 로컬 빌드와 라이브가 바이트 동일함을 검증자가 확인했으므로 SC3의 「실제 배포와 같은 빌드」(ROADMAP 괄호: Jekyll 3.10.0 고정 Gemfile)는 현재 사실임. 문서 정확성 경고로 남기고 차단하지 않음 |
| `.planning/research/*.md` | 여러 줄 | `python3 -m http.server` | ℹ️ Info | 전환 전 상태를 기록한 연구 문서. 운영자 안내 문서가 아니므로 SC3 범위 밖 |
| `.githooks/pre-push` | 6 | `PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"` | ℹ️ Info | 이 기기에서는 `/opt/homebrew/bin/bundle`이 Homebrew Ruby 4.0.9로 연결되어 훅이 동작함(시뮬레이션 통과). 다른 Ruby 배치에서의 동작은 확인하지 않음. 잘못된 Ruby를 잡으면 `check-site.sh`가 버전 확인에서 실패로 끝나 푸시가 막히는 쪽(fail-closed) |

### Human Verification Required

빌드 도구 성격의 단계지만 사람 항목을 N/A로 접지 않았습니다. 성공 기준 3이 운영자가 미리보기를 「띄우는」 경험을 직접 적고 있고(02-09 human-check), 나머지 둘은 사용자 결정(D-06 문구)과 흔적이 남지 않는 judgment-tier 금지 사항이라 만들어 낸 수동 단계가 아닙니다.

### 1. 로컬 미리보기 브라우저 확인 (02-09 Task 2)

**Test:** 루트 `CLAUDE.md`의 Local preview 명령대로 `bundle exec jekyll serve --livereload`를 띄우고 http://localhost:4000 의 `/`, `/privacy-policy/`, `/terms/`, `/data-deletion/`을 연다.
**Expected:** 네 페이지가 전환 전과 같은 모양으로 열리고, 헤더 메뉴(랜딩은 페이지 안 이동, 법적 페이지는 `/#story` 등)와 푸터 링크가 동작하며, 브라우저 콘솔에 오류가 없다.
**Why human:** 서버를 띄워 브라우저로 보는 경험은 grep으로 확인할 수 없다. 검증자는 서버를 띄우지 않았다(빌드 결과가 운영과 바이트 동일한 것까지는 확인).

### 2. ROADMAP 성공 기준 1 문구 결정 (D-06)

**Test:** 성공 기준 1의 「차이가 0」을 D-06 예외에 맞게 고칠지, override로 받아들일지 정한다.
**Expected:** 판정 문구와 실제 최종 출력이 어긋나지 않게 된다.
**Why human:** D-06이 문구 결정을 사용자 몫으로 남겼다. 검증자는 문구를 고치지 않았고 override도 대신 적지 않았다.

받아들이기로 하면 이 파일 frontmatter에 아래를 사람이 더합니다:

```yaml
overrides:
  - must_have: "로컬 Jekyll 3.10.0 빌드가 성공하고, _site/의 네 문서를 전환 전 HTML과 공백 정규화 diff로 비교하면 차이가 0이다"
    reason: "D-06: 전환 커밋 시점 diff 0(바이트 동일 ×4 커밋), 최종 상태는 「공통」 CSS 머리 주석 한 줄(×4문서)만 다르고 주석 제거 시 diff 0. 2026-11-15 사용자 승인 예외"
    accepted_by: "{name}"
    accepted_at: "{ISO timestamp}"
```

### 3. 푸시 승인·`--no-verify` 미사용 확인 (unverified-prohibition — human review recommended)

**Test:** 기준 커밋 푸시와 푸시 ①~④가 각각 사람이 그 SHA를 보고 승인한 뒤에만 일어났는지, 실행자가 `--no-verify`를 쓰지 않았는지 확인한다.
**Expected:** 승인한 SHA = 실제 푸시 SHA(`db505d71d3d2`, `d5a6679631d7`, `01f6bb8bbb13`, `e7e62f3f7990`, `9f715c795830`), `--no-verify` 미사용.
**Why human:** git 이력과 Pages 빌드 기록에는 승인 여부와 훅 생략 여부가 남지 않는다. 검증자의 비권위 판정은 「위반 흔적 없음」(모두 fast-forward, 모두 built·오류 없음, 푸시된 SHA 모두 지금 `check-site.sh`를 통과하는 계보).

### Gaps Summary

목표를 막는 결함은 없습니다. 공통 블록 네 가지는 저장소에 한 벌씩만 있고, 어느 하나를 바꿔도 네 문서가 모두 바뀝니다. 전환 커밋 네 개는 기준과 바이트까지 같은 출력을 냈고, 최종 출력은 승인된 주석 한 줄만 다릅니다. 라이브는 네 URL 200·같은 제목, 내부 파일 404이며, 지금 로컬 빌드는 라이브와 바이트가 같습니다.

`passed`가 아닌 이유는 사람 확인 세 건입니다. (1) 브라우저 미리보기, (2) 성공 기준 1 문구와 D-06 예외의 불일치 결정, (3) 흔적이 남지 않는 judgment-tier 금지 사항(푸시 승인, `--no-verify`).

차단하지 않는 경고 둘(WR-01, WR-02)은 미래 단계에서 문제가 됩니다. WR-01은 Phase 4에서 랜딩 JS를 다시 쓸 때 raw를 빠뜨린 `{{`가 조용히 사라지는 경로이고, WR-02는 운영 플러그인 차이를 로컬 점검이 덮는다고 믿게 하는 문장입니다. 둘 다 `02-REVIEW-DISPOSITION.md`에서 아직 `open`입니다. 다음 단계 전에 triage를 권합니다.

참고: 로컬 main은 origin/main보다 docs 커밋 6개 앞서 있습니다(안내받은 3~5개가 아니라 6개: `0fbd9b053305`·`06deaa61c0fa`·`4366716aaee9`·`ada7b5706e2c`·`ea0cfead038f`·`da31b74f5acc`). `.planning/` 밖의 diff는 0이라 사이트 출력에는 영향이 없습니다.

---

_Verified: 2026-11-16T07:13:37Z_
_Verifier: Claude (gsd-verifier)_
