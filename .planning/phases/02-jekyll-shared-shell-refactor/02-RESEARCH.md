# Phase 2: Jekyll 공유 셸 도입 (Shared Shell Refactor) - Research

**Researched:** 2026-11-15
**Domain:** GitHub Pages 내장 Jekyll 3.10.0(Liquid 4.0.4)의 `_layouts`/`_includes`, 로컬 Bundler 빌드, git pre-push 훅, GitHub Pages 배포·CDN 확인
**Confidence:** HIGH (핵심 주장은 저장소 밖 스크래치에서 실제 HTML 4개로 전환·빌드·비교해 확인. 운영 빌드와의 동등성만 MEDIUM, 라이브 비교로 확정)

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions

### 이전에 정해진 것 (다시 논의하지 않음)
출처: `.planning/ROADMAP.md` Phase 2 Notes, `.planning/research/STACK.md`, Phase 1 D-04.
- Gemfile은 `jekyll = 3.10.0`을 직접 고정하고, Ruby 4에서 빠진 표준 라이브러리 gem(`csv`, `base64`, `bigdecimal`, `logger`, `webrick`)과 `kramdown-parser-gfm`을 더합니다. 로컬 Homebrew Ruby 4.0.9를 씁니다. `github-pages` gem은 Ruby 4에 설치되지 않습니다(STACK 연구에서 직접 확인).
- 레이아웃 이름에 `default`·`page`·`home`을 쓰지 않습니다(GitHub Pages 기본 플러그인 `jekyll-default-layout` 회피). 전역 `permalink`, `.nojekyll`, 플러그인도 쓰지 않습니다.
- `_config.yml`에 `url: "https://runningpencil.com"`을 두고 `exclude`를 보강합니다. 사용자 지정 `exclude`는 Jekyll 기본 제외 목록(Gemfile·vendor 등)을 덮어쓰므로 모두 명시해야 합니다.
- Tailwind `<script src>`와 `<script id="tailwind-config">`는 legal 레이아웃의 `<head>`로 옮기기만 합니다. 제거는 Phase 3에서 합니다.
- CSS는 외부 파일로 빼지 않습니다. `<style>` 안에서 include로 인라인합니다.
- 법적 문서 3종과 랜딩은 커밋을 나눕니다.
- front matter를 붙인 파일은 전체가 Liquid로 처리됩니다. 현재 네 HTML에 `{{`·`{%`는 0건입니다(2026-11-15 재확인). 앞으로 인라인 JS·CSS에 이 문자열이 생기면 `{% raw %}`로 감쌉니다. 이 규칙을 `CLAUDE.md`에 적습니다.

### 법적 페이지 구성 (SHELL-01)
- **D-01:** 법적 3종은 `legal` 레이아웃과 front matter로 전환합니다.
  - 레이아웃이 그리는 것: `<!DOCTYPE html>`부터 `</html>`까지 전체. `<head>`(메타, Tailwind script, head 링크, tailwind-config, `<style>`), 헤더, `<main class="rp-grid">`와 카드 틀, 푸터를 포함합니다.
  - 페이지 파일에 남는 것: front matter, 카드 본문(현재 `<div class="mt-10 space-y-8 …">` 안의 `<section>`들), 맨 끝 「임시 게시본」 문단.
  - front matter 키: `layout: legal`, `title`, `description`, `noindex`, `eyebrow`, `heading`, `updated`
  - `title`로 `<title>{{ title }} - 러닝펜슬</title>`을 만듭니다. 출력 문자열은 지금과 같아야 합니다.
  - `noindex: true`일 때만 `<meta name="robots" content="noindex" />`를 출력합니다.
  - `noindex`와 「임시 게시본」 문단은 페이지마다 둡니다. Phase 6·7·8에서 문서별로 지우기 때문입니다(U14). 지울 때는 front matter 한 줄과 본문 문단 하나만 고치면 됩니다. 문단의 주어도 문서마다 다릅니다(본 방침/본 약관/본 안내).
- **D-02:** 카드 머리는 레이아웃이 front matter로 그립니다. 머리는 영문 라벨 `<span>`, h1, 「최종 업데이트」 `<p>`입니다.
  - `heading`이 없으면 `title`을 h1로 씁니다.
  - 삭제 안내는 둘이 다릅니다. `title`은 「데이터 삭제 안내」이고 `heading`은 「사용자 데이터 삭제 안내」입니다(코드 확인).
  - `updated`가 없으면 날짜 `<p>` 줄을 출력하지 않습니다(render-if-present). Phase 5 `/support/`처럼 날짜가 필요 없는 페이지에 대비한 것입니다.
  - 값은 지금 HTML 그대로 옮깁니다. 예: `updated: 2026년 10월 31일`, `eyebrow: TERMS OF SERVICE`
- **D-03:** 랜딩(`index.html`)은 레이아웃을 쓰지 않고 include만 끼워 넣습니다.
  - Liquid로 처리되도록 front matter(빈 것 또는 최소)를 붙입니다.
  - include로 바꾸는 곳은 네 군데뿐입니다: head 링크, 「공통」 CSS, 헤더, 푸터.
  - 랜딩 전용 CSS(「랜딩 전용」 묶음), 숨은 SVG `<defs>`, pre-paint 스크립트, 끝 인라인 스크립트, OG 메타는 `index.html`에 그대로 둡니다.
  - 「공통」 CSS와 「랜딩 전용」 CSS는 지금처럼 같은 `<style>` 태그 안에서 이어져야 합니다.
- **D-04:** 헤더는 include 하나로 두고 링크 주소만 페이지에 따라 바꿉니다.
  - 랜딩: `#top`, `#story`, `#demo`, `#get`
  - 법적 페이지: `/`, `/#story`, `/#demo`, `/#get`
  - 나머지 마크업은 같습니다. 푸터는 네 파일이 완전히 같으므로 변형 없이 씁니다.

### 출력 동일성 검증 (성공 기준 1·2)
- **D-05:** 전환 커밋(법적 3종, 랜딩)은 출력 주석까지 그대로 둡니다. 엄격한 diff 0입니다.
- **D-06:** 「공통」 CSS 머리 주석은 전환 커밋 바로 뒤의 **별도 커밋**에서 새 구조에 맞게 고칩니다.
  - 현재 주석(`index.html:31-32`, 법적 페이지 `:37-38`): 「네 페이지가 이 묶음을 똑같이 복사해 쓴다. 고칠 때는 네 파일을 함께 고친다.」
  - 새 문구 예: 「`_includes/…` 한 곳에서 고친다」
  - 이 커밋은 HTML·CSS 주석을 지운 뒤 diff 0인지로 확인합니다.
  - 사실과 어긋나지 않는 다른 출력 주석(`<!-- Header -->`, `/* ── 랜딩 전용 ── */` 등)은 그대로 둡니다.
  - **성공 기준 1과의 관계:** 성공 기준 1(공백 정규화 diff 0)은 전환 커밋 시점에 판정합니다. 법적 3종 전환 커밋과 랜딩 전환 커밋의 해시와 diff 결과를 검증 문서에 적습니다. 단계를 마친 뒤의 최종 출력은 전환 전과 이 「공통」 CSS 머리 주석 한 곳만 다릅니다. 이 차이는 사용자가 승인한 예외입니다(2026-11-15 논의). 검증자는 최종 상태를 「주석을 지운 뒤 diff 0」으로 확인합니다. ROADMAP 성공 기준 1의 문구는 아직 예외 없이 「차이가 0」이라고 적혀 있습니다. 문구를 고칠지는 사용자가 정합니다.
- **D-07:** 공백 정규화는 각 줄의 앞뒤 공백과 빈 줄만 지웁니다. 줄 안의 공백 차이는 차이로 셉니다. 인라인 요소 사이 공백처럼 화면에 보이는 차이를 놓치지 않기 위해서입니다.
- **D-08:** 비교 범위는 두 가지입니다.
  - 네 문서의 내용 diff
  - `_site/` 전체 파일 목록을 전환 전 목록과 비교. 새로 공개되는 파일과 사라지는 파일이 모두 0이어야 합니다. Gemfile, include 조각, 스크립트, `.githooks/` 같은 노출을 푸시 전에 잡기 위해서입니다.
- **D-09:** 비교 기준(baseline)은 Phase 2 실행을 시작할 때의 커밋입니다.
  - 그 커밋의 원본 HTML 4개를 기준으로 씁니다. 지금은 빌드 없이 그대로 서빙되므로 라이브와 같습니다.
  - 그 커밋을 로컬 Jekyll로 빌드한 `_site/` 파일 목록도 기준으로 씁니다.
  - 기준 파일 목록은 작업 트리에서 빌드하지 않습니다. 기준 커밋의 추적 파일만 깨끗하게 내보낸 사본(`git archive` 등)에서 빌드합니다. 그래야 GitHub Pages가 보는 것과 같아집니다.
    - 이유 1: 작업 트리에는 gitignore된 `prepare/`가 있는데, 현재 `exclude`에 없어서 함께 빌드됩니다. 그러면 ① 푸시 뒤 이 파일들이 「사라진 파일」로 잡혀 거짓 실패가 납니다.
    - 이유 2: 기준 커밋에는 Gemfile이 없습니다. 빌드할 때 Gemfile은 사본 밖에서 넣습니다(예: `BUNDLE_GEMFILE` 지정). 같은 방법으로 빌드 결과에 Gemfile이 섞이지 않게 합니다.
  - 기준 커밋 해시를 검증 문서에 적습니다.
- **D-10:** 성공 기준 2는 커밋하지 않는 임시 시험으로 확인합니다. include 하나를 임시로 바꿔 빌드하고, 네 문서의 결과가 모두 바뀌는지 본 뒤 되돌립니다.

### 로컬 빌드와 푸시 전 점검 (SHELL-02·03)
- **D-11:** gem은 저장소 안에 설치합니다(`bundle config set --local path vendor/bundle`).
  - `.gitignore`에 더할 것: `_site/`, `.jekyll-cache/`, `vendor/`, `.bundle/`
  - `Gemfile`과 `Gemfile.lock`은 커밋합니다.
  - `_config.yml` `exclude`에 둘 것: 기존 `CNAME`, `CLAUDE.md`, `README.md`, `.planning/`에 더해 `Gemfile`, `Gemfile.lock`, `vendor/`, `prepare/`, 점검 스크립트 경로, `.githooks/`
- **D-12:** 미리보기 명령은 `bundle exec jekyll serve --livereload`(http://localhost:4000)입니다.
  - `python3 -m http.server` 안내는 모두 지웁니다(성공 기준 3). 대상: `CLAUDE.md`(루트), `.claude/CLAUDE.md`(원본 맵을 고친 뒤 다시 생성), `README.md`, `.planning/codebase/*`
  - 연구 문서의 「`jekyll build` 뒤 `python3 -m http.server -d _site`」 변형도 안내하지 않습니다.
- **D-13:** 푸시 전 점검 스크립트 **하나만** 저장소에 커밋하고 `exclude`에 등록합니다. 점검 항목은 넷입니다.
  1. `bundle exec jekyll build`가 성공하는지
  2. `_site/`에 내부 파일이 없는지: `CLAUDE.md`, `README.md`, `Gemfile`, `Gemfile.lock`, `vendor/`, `.planning/`, `prepare/`, 스크립트 자신, `.githooks/`, `_includes`·`_layouts` 원본 조각
  3. 기존 URL 문서 4개(`index.html`, `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`)가 있고 `<title>`이 기대값과 같은지
     - 기대값은 스크립트 맨 위 한 곳에 모읍니다. 이 스크립트는 이후 단계에서도 계속 돌기 때문입니다.
     - Ground Rule이 제목을 고정하는 대상은 법적 URL 3개뿐입니다. 랜딩 제목은 Phase 4에서 바뀔 수 있으므로, 바뀌면 그 단계가 기대값을 고친다고 주석에 적습니다.
  4. 출력에 Liquid가 처리되지 않은 문자열(`{%`, `{{`)이 남지 않았는지

  diff 0 비교(D-05~D-09)는 Phase 2에서만 쓰는 일회용입니다. 스크래치에서 돌리고, 결과만 검증 문서에 남깁니다.
- **D-14:** 점검 스크립트는 git pre-push 훅으로 자동 실행합니다.
  - 훅 파일은 `.githooks/pre-push`이고, `git config core.hooksPath .githooks`로 켭니다. 이 설정은 저장소를 클론한 컴퓨터마다 한 번 해야 하므로 `CLAUDE.md`에 적습니다.
  - 점검이 실패하면 푸시가 멈춥니다. 급하면 `--no-verify`로 건너뜁니다.
  - Ruby·bundle이 없으면 이유를 알 수 있는 메시지로 실패합니다.
  - 전역 규칙의 「커밋 전 린터 실행」은 이 저장소에서는 이 점검 스크립트(빌드 성공)로 갈음합니다. `.planning/codebase/CONVENTIONS.md`·`TESTING.md` 원본에도 반영합니다.

### 배포 순서와 라이브 확인 (성공 기준 4)
- **D-15:** 푸시를 네 번에 나눕니다. 각 푸시 뒤 라이브 확인이 통과해야 다음으로 넘어갑니다. — **Reversibility:** costly — 푸시는 곧 라이브 배포입니다. 되돌리려면 revert 커밋과 재배포가 필요하고, 그동안 심사 콘솔에 등록된 URL이 깨진 채 보입니다.
  1. 빌드 설정: `Gemfile`, `Gemfile.lock`, `_config.yml`(`url`·`exclude`), `.gitignore`, 점검 스크립트, `.githooks/pre-push`. 출력은 바뀌지 않습니다. 라이브에서 `/Gemfile`이 404인지 이때 처음 확인합니다.
  2. 법적 3종 전환
  3. 랜딩 전환
  4. 「공통」 주석 수정 커밋, 그리고 `CLAUDE.md`·`README.md`·원본 맵 문서 커밋. 두 커밋을 한 푸시에 올려도 됩니다.
- **D-16:** 푸시는 Claude가 하되 매번 승인을 받습니다.
  - 계획에는 푸시 직전마다 사람 확인 단계(checkpoint)를 넣습니다. 그 단계에서 로컬 검증 결과(빌드, diff, 파일 목록, 점검 스크립트)를 보여 주고, 승인을 받으면 푸시한 뒤 라이브를 확인합니다.
  - 승인은 푸시마다 따로 받습니다. 앞 푸시의 승인이 다음 푸시로 이어지지 않습니다.
  - **checkpoint 종류는 `checkpoint:decision`으로 합니다.** 이 프로젝트의 `.planning/config.json`은 `workflow.human_verify_mode: "end-of-phase"`입니다. 이 모드에서는 계획자가 만든 `checkpoint:human-verify`가 단계 끝으로 미뤄집니다. `checkpoint:decision`과 `checkpoint:human-action`은 미뤄지지 않습니다(`~/.claude/gsd-core/references/checkpoints.md`, `planner-human-verify-mode.md`). 푸시는 작업 자체를 막는 결정이므로 `checkpoint:decision`으로 단계 중간에 멈춰야 합니다.
- **D-17:** 라이브 확인은 GitHub Pages 배포가 끝났는지 먼저 확인한 뒤 합니다. 배포 완료는 커밋 체크나 Actions의 「pages build and deployment」로 봅니다(`gh` 사용 가능). 확인 항목은 셋입니다.
  - curl로 네 URL이 200이고 `<title>`이 전환 전과 같은지
  - 내부 파일이 404인지: `/CLAUDE.md`, `/README.md`, `/Gemfile`, `/Gemfile.lock`, `.planning/` 아래 실제 파일 경로(예: `/.planning/ROADMAP.md`), 점검 스크립트 경로, `/_config.yml`
  - 네 문서의 라이브 HTML을 D-07과 같은 정규화로 기준과 비교해 diff가 0인지. 네 번째 푸시 뒤에는 주석을 지운 뒤 비교합니다.

  운영 빌드(Ruby 3.3.4와 기본 플러그인)와 로컬 빌드(Ruby 4.0.9)의 차이를 잡는 유일한 방법이 이 라이브 비교입니다. CDN 캐시(비공식으로 약 10분)를 고려해, 캐시를 우회하는 쿼리 문자열을 붙이거나 기다렸다가 비교합니다.
- **D-18:** 라이브에서 문제가 보이면 고치기 전에 먼저 되돌립니다. 문제의 예: 문서가 열리지 않음, 제목이 바뀜, `{% include`가 그대로 보임, 내부 파일이 열림, diff가 0이 아님.
  - 순서: `git revert <커밋>` → 승인 → 푸시로 전환 전 상태를 복구하고, 원인 수정은 그다음 커밋에서 합니다.
  - force push와 히스토리 수정은 하지 않습니다.

### 문서 갱신 (Ground Rule: 구조를 바꾸는 단계는 `CLAUDE.md`도 함께 고침)
- **D-19:** 아래 내용을 이 단계 안의 문서 커밋(D-15의 네 번째 푸시)에서 고칩니다. 방법은 Phase 1 D-04를 따릅니다.
  - 루트 `CLAUDE.md`
  - `.claude/CLAUDE.md`의 방침 구간. 루트와 같은 커밋에서 똑같이 고칩니다.
  - `.planning/codebase/` 원본: `STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md`. `http.server`나 「복사해서 공유」를 언급하는 `STRUCTURE.md`·`TESTING.md`·`CONCERNS.md`도 포함합니다. 원본을 고친 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 `.claude/CLAUDE.md`를 다시 만듭니다.
  - `README.md`

  바꿀 내용:
  - 방침 표 「Jekyll 빌드 전환」 행의 현재 상태: Phase 2 적용됨, Phase 3(Tailwind) 남음
  - 「공통 블록을 네 파일에 복사」 설명을 include·레이아웃 설명으로 교체
  - 미리보기·빌드 명령, `core.hooksPath` 설정, `{% raw %}` 규칙
  - 「Phase 2까지 유효」라고 표시해 둔 문장 정리

### Claude's Discretion
- include 파일 이름과 나누는 단위. 예: `_includes/head-links.html`, `_includes/css/common.css`, `_includes/header.html`, `_includes/footer.html`. 법적 전용 CSS와 tailwind-config를 레이아웃에 바로 둘지, include로 뺄지도 포함합니다.
- 헤더 링크 변형을 나누는 방식(include 매개변수, `page.url` 판정 등)
- 점검 스크립트의 언어와 경로. bash 또는 Python 표준 라이브러리이고, `exclude` 등록은 필수입니다.
- 일회용 diff 비교 스크립트의 형태
- `{%-`·`-%}` 공백 제어를 쓸지. D-07 정규화가 줄 앞뒤 공백과 빈 줄을 흡수하므로 필수는 아닙니다.
- 랜딩 front matter의 내용(빈 것 또는 최소 키)
- 성공 기준 2의 임시 시험 방법(D-10 안에서)

### Deferred Ideas (OUT OF SCOPE)
None. 논의는 단계 범위 안에서 진행됐습니다. 다른 단계의 몫은 아래와 같습니다.
- `_data/company.yml`(사업자 값, 지원 이메일): Phase 5
- `_data/i18n.yml`, `lang`·`ref`로 짝 묶기, `hreflang`: Phase 9
- legal 레이아웃을 `/support/`·`/location-terms/`에 그대로 쓸지: Phase 5·8에서 정함. 이번 레이아웃은 `updated`를 생략할 수 있게만 만듭니다(D-02).
- Tailwind 제거와 정적 CSS: Phase 3
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| SHELL-01 | 운영자는 head 링크·「공통」 CSS·헤더·푸터를 한 곳에서 고치면 모든 페이지에 반영되게 할 수 있다. 전환 직후 기존 페이지의 출력은 바뀌지 않는다 | Pattern 1(공백 규칙), Pattern 2(legal 레이아웃), Pattern 3(랜딩), Pattern 4(헤더 변형). 스크래치 전환으로 네 문서 바이트 동일, include 4개 각각 4/4 반영을 확인 |
| SHELL-02 | 운영자는 로컬에서 실제 배포와 같은 Jekyll 3.10.0 빌드로 사이트를 미리 보고, 푸시 전에 빌드가 성공하는지 확인할 수 있다 | Standard Stack(Gemfile), Code Examples의 `scripts/check-site.sh`와 `.githooks/pre-push`(성공·실패 경로, 짧은 PATH, worktree 시험 완료), Pitfall 4·5·6·7 |
| SHELL-03 | 방문자는 라이브 사이트에서 내부 파일을 열 수 없다 (404) | Pattern 5(`exclude` 목록과 점 파일 규칙), check-site 2번 항목, 라이브 확인 절차(Pitfall 1·2·3, Code Examples 「라이브 확인」) |
</phase_requirements>

## Project Constraints (from CLAUDE.md)

루트 `CLAUDE.md`와 `.claude/CLAUDE.md`의 작업 규칙 중 이 단계에 걸리는 것입니다. 계획은 이 규칙을 잠긴 결정과 같은 무게로 지킵니다.

- `main` 푸시가 곧 배포입니다(CI 없음). 모든 단계는 그대로 라이브에 올라가도 되는 상태로 끝냅니다.
- `/privacy-policy/`, `/terms/`, `/data-deletion/`은 경로를 바꾸지 않고 리디렉션도 걸지 않습니다. 배포할 때마다 세 URL이 200과 같은 문서 제목을 돌려주는지 확인합니다.
- 리팩터, 시각 변경, 내용 변경을 한 단계나 한 커밋에 섞지 않습니다.
- Phase 2 이후에는 푸시 전에 로컬 Jekyll 3.10.0 빌드가 성공하는지 확인합니다.
- JS 언어 자동 리디렉션, `robots.txt` 차단, `.nojekyll`, Jekyll i18n 플러그인을 쓰지 않습니다.
- 방침이나 구조를 바꾸는 단계는 그 단계 안에서 `CLAUDE.md`도 함께 고칩니다. 방침 구간은 루트와 `.claude/CLAUDE.md` 두 사본을 같은 커밋에서 똑같이 고칩니다. `.claude/CLAUDE.md`의 `project`·`stack`·`conventions`·`architecture` 구간은 원본(`.planning/PROJECT.md`, `.planning/codebase/STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md`)을 고친 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 다시 만듭니다. `skills`·`workflow`·`profile` 구간은 고치지 않습니다.
- 사용자가 줄 사실값은 추측해서 채우지 않습니다(이 단계에는 해당 값이 없습니다).
- 마크다운 문서를 새로 추가하면 `_config.yml`의 `exclude`에도 적습니다.
- 코드 컨벤션(`.planning/codebase/CONVENTIONS.md`): 공백 4칸 들여쓰기, CSS 규칙 한 줄, 한국어 주석, 루트 기준 절대 경로(`relative_url`로 바꾸지 않음), 빈 `catch`에도 이유 주석.
- 전역 규칙(`~/.claude/CLAUDE.md`): 커밋 메시지는 Conventional Commits(prefix 영어, 제목·본문 한국어). 「커밋 전 린터 실행」은 이 저장소에서 `scripts/check-site.sh`로 갈음합니다(D-14). 공개 함수·스크립트에는 문서 주석을 답니다(스크립트 머리 주석). 비밀값은 하드코딩하지 않습니다(이 단계에는 비밀값이 없습니다).

## Summary

이 단계의 설계는 스크래치 실험으로 끝까지 검증했습니다. 저장소 HEAD(`75adbb9`)를 `git archive`로 내보낸 사본에서 CONTEXT D-01~D-04 구조(법적 `legal` 레이아웃 + include 4개, 랜딩은 빈 front matter + include 4곳)로 바꾸고 Jekyll 3.10.0(`--safe` 포함)으로 빌드했습니다. 그 결과 네 문서가 전환 전 원본과 **바이트 단위로 같았고**(`cmp`), `_site/` 파일 목록(11개)도 같았습니다. Gemfile·`scripts/`·`.githooks/`·`vendor/`·`prepare/`·`.bundle/`를 사본에 넣은 상태에서도 출력은 바뀌지 않았습니다. include 4개를 하나씩 바꾸면 네 문서가 모두 바뀌었습니다(성공 기준 2). [VERIFIED: 로컬 실험, Jekyll 3.10.0 / Liquid 4.0.4 / Ruby 4.0.9]

공백 동작은 규칙 하나로 정리됩니다. include 태그는 줄 맨 앞(0열)에 혼자 두고, include 파일에는 원본 줄을 들여쓰기째 그대로 담고, **파일 끝 줄바꿈을 두지 않으면** 바이트가 같습니다. 끝 줄바꿈이 있으면 include마다 빈 줄 하나가 더 생기고, 이 빈 줄은 D-07 정규화가 흡수합니다(이 경우도 실험으로 확인). 다만 `{%-`를 **내용을 내보내는 태그**(include, `{{ }}`)에 쓰면 앞줄과 붙어 버립니다. 이것은 D-07이 흡수하지 못하는 진짜 차이입니다. `{%-`는 아무것도 내보내지 않는 `if`/`endif` 같은 제어 태그에만 씁니다. [VERIFIED: 로컬 실험]

계획에 영향을 주는 새 사실이 다섯 가지 있습니다.
1. **GitHub Pages CDN은 쿼리 문자열로 캐시를 우회할 수 없습니다.** 매번 다른 `?v=`를 붙여도 맨 URL과 같은 `age`, 같은 `x-cache: HIT`가 왔습니다. 그래서 D-17의 「쿼리 문자열」 선택지는 쓸 수 없고 「기다렸다가 비교」만 남습니다. 응답의 `Last-Modified`가 Pages 빌드의 `updated_at`과 같았습니다. 그래서 「한 번의 요청으로 받은 응답의 `Last-Modified`가 빌드 `created_at` 이후인가」로 새 배포가 반영됐는지 판정할 수 있습니다. 404도 캐시되므로(`age: 694` 관찰) 404는 `age`를 보고 판정합니다. [VERIFIED: curl 실측. 같은 값은 빌드 한 번에서만 관찰]
2. **로컬 `main`이 `origin/main`보다 105커밋 앞서 있습니다.** 라이브는 `c4cb26d`에서 빌드됐습니다. 그래서 첫 푸시(D-15 ①)에는 Phase 1 전체(`.planning/**`, `.claude/CLAUDE.md`, `exclude`에 더한 `.planning/` 줄)가 처음으로 함께 올라갑니다. [VERIFIED: `git ls-remote`, `gh api …/pages/builds/latest`]
3. **운영에는 `jekyll-theme-primer`가 기본 테마로 걸려 있습니다.** 그래서 라이브에는 로컬 빌드에 없는 `/assets/css/style.css`(200)가 있습니다. 로컬 `_site` 파일 목록은 운영의 파일 목록과 같지 않습니다. 이 파일은 전환 전에도 있었고 이 단계에서 바뀌지 않습니다. 고치는 일은 이번 범위가 아닙니다. [VERIFIED: pages-gem v232 `configuration.rb`, curl]
4. **`--safe` 빌드는 심볼릭 링크 경로 아래의 원본을 거부합니다.** macOS `$TMPDIR`(`/var/folders/…`, 실제는 `/private/var/…`) 아래에 내보낸 사본을 빌드하면 include를 찾지 못해 실패합니다. 임시 폴더는 `pwd -P`로 실제 경로로 바꿔서 씁니다. [VERIFIED: 로컬 실험에서 실패 재현 후 수정 확인]
5. **macOS 기본 `/bin/bash`는 3.2입니다.** `"$errors건"`처럼 변수 바로 뒤에 한글이 오면 한글 바이트까지 변수 이름으로 읽어 `unbound variable`이 납니다. 반드시 `${errors}건`으로 씁니다. [VERIFIED: 로컬 실험에서 재현]

**Primary recommendation:** 아래 「Code Examples」의 레이아웃·include·점검 스크립트·훅·일회용 비교 스크립트를 그대로 쓰십시오. 모두 스크래치에서 성공 경로와 실패 경로를 확인했습니다. 라이브 확인은 `gh run watch`로 배포 완료를 기다린 뒤, URL마다 한 번의 요청으로 받은 응답의 `Last-Modified >= created_at`이 될 때까지 기다리고 나서 그 본문으로 합니다.

## Architectural Responsibility Map

| Capability | Primary Tier | Secondary Tier | Rationale |
|------------|-------------|----------------|-----------|
| 공통 블록 단일화 (head 링크·「공통」 CSS·헤더·푸터) | 빌드 시점 템플릿 (Jekyll `_includes`/`_layouts`) | — | 정적 호스팅이라 런타임 서버가 없습니다. 조립은 GitHub Pages의 Jekyll 빌드에서만 일어납니다 |
| 법적 페이지 카드 머리·`noindex` 조건 출력 | 빌드 시점 템플릿 (`_layouts/legal.html` + front matter) | — | 페이지별 값은 front matter, 틀은 레이아웃 한 곳에 둡니다 |
| 랜딩 동작(스크롤·데모 JS) | 브라우저 | — | 바뀌지 않습니다. Liquid를 거치지만 `{{`·`{%`가 없어 그대로 나갑니다 |
| 내부 파일 비공개 | 빌드 설정 (`_config.yml` `exclude` + Jekyll 점·밑줄 규칙) | 푸시 전 점검 (`scripts/check-site.sh`) | 서버 설정이 없으므로 배포 산출물에서 빼는 것만이 통제 수단입니다 |
| 로컬 미리보기·빌드 | 개발자 기기 (Ruby 4.0.9 + Bundler, `vendor/bundle`) | — | 운영과 같은 Jekyll 3.10.0을 로컬에 고정합니다 |
| 푸시 차단 | git 클라이언트 훅 (`.githooks/pre-push`) | — | CI가 없으므로 마지막 관문이 클라이언트 훅입니다 |
| 배포 완료·CDN 반영 확인 | GitHub API (`gh`) + CDN 응답 헤더 | — | 운영 빌드는 GitHub가 하므로 결과는 API와 라이브 응답으로만 볼 수 있습니다 |

## Standard Stack

### Core

| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| `jekyll` | `= 3.10.0` | 로컬 빌드·미리보기 | 운영 GitHub Pages가 쓰는 버전입니다 [VERIFIED: pages.github.com/versions.json `"jekyll": "3.10.0"`]. Gemfile에 직접 고정합니다(잠긴 결정) |
| `liquid` | 4.0.4 (jekyll 의존성으로 해결) | 템플릿 엔진 | 운영과 같습니다 [VERIFIED: versions.json `"liquid": "4.0.4"`, 스크래치 Gemfile.lock `liquid (4.0.4)`] |
| `webrick` | 1.9.2 (lock 해결값) | `jekyll serve`의 HTTP 서버 | Ruby 3.0+에서 기본 gem이 아님 [VERIFIED: STACK.md 실험, 스크래치 lock] |
| `csv`, `base64`, `bigdecimal`, `logger` | 3.3.7 / 0.3.0 / 4.1.3 / 1.7.0 | Jekyll 3.x가 require하는 옛 표준 라이브러리 | Ruby 4에서 기본 gem이 아님 [VERIFIED: STACK.md 실험, 스크래치 lock] |
| `kramdown-parser-gfm` | 1.1.0 | Jekyll 3.10 마크다운 의존성 | 잠긴 결정 [VERIFIED: 스크래치 lock] |

### Supporting (설치 안 함, 이미 있는 도구)

| Tool | Version | Purpose | When to Use |
|------|---------|---------|-------------|
| `gh` | 2.104.0 | Pages 빌드 완료 대기 | 각 푸시 뒤 라이브 확인 [VERIFIED: `gh --version`] |
| `git` | 2.56.1 | `archive`, `core.hooksPath`, `rev-parse --path-format=absolute` | 비교·점검·훅 [VERIFIED: `git --version`] |
| `/bin/bash` | 3.2.57 | 점검 스크립트·훅 실행 | `#!/usr/bin/env bash`가 이 버전을 잡습니다. Homebrew bash 없음 [VERIFIED: `bash --version`] |
| `python3` | 3.9.6 (macOS CLT) | 일회용 비교의 주석 제거 정규화, 라이브 날짜 비교 | 일회용 도구에만 씁니다 [VERIFIED: `python3 --version`] |

### Alternatives Considered

| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| 점검 스크립트 bash | Python 표준 라이브러리 | bash 권장. 하는 일이 거의 전부 CLI 조립(`bundle`, `git archive`, `find`, `grep`)이고 훅도 셸입니다. Ruby는 「Ruby가 없으면 알기 쉽게 실패」해야 하므로 스크립트 언어가 될 수 없습니다. Python 3.9.6도 돌지만 런타임이 하나 늘어납니다. 대가: bash 3.2 제약(Pitfall 5) |
| 헤더 변형 include 매개변수 | `page.url == "/"` 판정 | 매개변수 권장(Pattern 4) |
| 법적 전용 CSS·tailwind-config를 include로 분리 | 레이아웃에 직접 | 레이아웃에 직접 권장. 레이아웃 자체가 한 벌이고 Phase 3에서 tailwind-config를 지웁니다. include를 늘리면 공백 규칙을 지킬 곳만 늘어납니다 |
| 운영 동등성 확인을 라이브 비교로 | `ghcr.io/actions/jekyll-build-pages:v1.0.13` Docker 이미지로 로컬 운영 빌드 | 선택 사항. 운영 액션이 이 이미지와 `github-pages 232`를 씁니다 [VERIFIED: actions/jekyll-build-pages `action.yml`·`Gemfile`]. 이 기기에 Docker Desktop은 있지만 데몬이 꺼져 있었고, 이미지의 입력 계약(환경 변수)은 확인하지 않았습니다 [ASSUMED]. D-17은 라이브 비교를 유일한 수단으로 정했으므로 계획에 넣지 않아도 됩니다 |

**Installation (Gemfile 내용, 잠긴 결정 그대로):**
```ruby
source "https://rubygems.org"

# 운영(GitHub Pages)과 같은 Jekyll 버전을 직접 고정한다.
# github-pages gem은 로컬 Ruby 4.x에 설치되지 않는다.
gem "jekyll", "= 3.10.0"
gem "kramdown-parser-gfm"

# Ruby 3.4+/4.0에서 기본 gem이 아니게 된 표준 라이브러리 + jekyll serve용 서버
gem "webrick"
gem "csv"
gem "base64"
gem "bigdecimal"
gem "logger"
```
```bash
bundle config set --local path vendor/bundle   # .bundle/config에 BUNDLE_PATH: "vendor/bundle" 저장
bundle install
bundle exec jekyll -v                          # → jekyll 3.10.0
bundle exec jekyll serve --livereload          # → http://localhost:4000
```

**Version verification:** 2026-11-15 스크래치 `bundle install` 결과입니다. `jekyll (3.10.0)`, `liquid (4.0.4)`, `kramdown (2.5.2)`(운영 2.4.0과 다르지만 이 사이트는 마크다운을 렌더하지 않음), `jekyll-sass-converter (1.5.2)`(운영과 같음), `sass (3.7.4)`(설치할 때 EOL 안내 메시지가 나오지만 무해), `BUNDLED WITH 4.0.23`. Bundler 4가 만든 lock에는 `PLATFORMS` 11종과 `CHECKSUMS`(sha256)가 들어갑니다. [VERIFIED: 스크래치 Gemfile.lock]

## Package Legitimacy Audit

`gsd-tools query package-legitimacy check`는 `npm|pypi|crates`만 받아 rubygems는 확인하지 못했습니다(`Error: Usage: gsd-tools package-legitimacy check --ecosystem <npm|pypi|crates>`). 대신 rubygems.org 공개 API를 직접 조회했습니다. 이 gem들은 운영에 배포되지 않습니다. 로컬 빌드에만 씁니다.

| Package | Registry | Age (첫 배포) | Downloads (누적) | Source Repo | Verdict | Disposition |
|---------|----------|-----|-----------|-------------|---------|-------------|
| jekyll | rubygems | 2009-07-25 | 44,980,269 | github.com/jekyll/jekyll | seam 미지원 (수동 조회만) | 잠긴 결정의 gem. checkpoint 여부는 계획자 판단 |
| webrick | rubygems | 2011-12-28 | 493,903,193 | github.com/ruby/webrick | seam 미지원 (수동 조회만) | 잠긴 결정의 gem. checkpoint 여부는 계획자 판단 |
| csv | rubygems | 2017-05-11 | 225,837,268 | github.com/ruby/csv | seam 미지원 (수동 조회만) | 잠긴 결정의 gem. checkpoint 여부는 계획자 판단 |
| base64 | rubygems | 2020-09-18 | 568,987,059 | github.com/ruby/base64 | seam 미지원 (수동 조회만) | 잠긴 결정의 gem. checkpoint 여부는 계획자 판단 |
| bigdecimal | rubygems | 2012-02-07 | 550,368,299 | github.com/ruby/bigdecimal | seam 미지원 (수동 조회만) | 잠긴 결정의 gem. checkpoint 여부는 계획자 판단 |
| logger | rubygems | 2019-01-11 | 466,715,717 | github.com/ruby/logger | seam 미지원 (수동 조회만) | 잠긴 결정의 gem. checkpoint 여부는 계획자 판단 |
| kramdown-parser-gfm | rubygems | 2019-01-11 | 179,805,329 | github.com/kramdown/parser-gfm | seam 미지원 (수동 조회만) | 잠긴 결정의 gem. checkpoint 여부는 계획자 판단 |

**Packages removed due to [SLOP] verdict:** none
**Packages flagged as suspicious [SUS]:** none
gem 이름의 출처는 STACK 연구의 로컬 실험(Jekyll 3.10이 실제로 `csv` LoadError를 냄)과 Jekyll 3.10.0 gemspec 의존성(`csv (~> 3.0)`, `webrick (>= 1.0)`)입니다. gem 목록 자체는 CONTEXT의 잠긴 결정입니다. 이번 세션에 rubygems.org API로 존재·연혁·소스 저장소만 확인했습니다. legitimacy seam이 rubygems를 지원하지 않아 OK/SUS/SLOP 판정은 없습니다. 설치 전 사람 확인 단계를 넣을지는 계획자가 정합니다. 네이티브 확장(`bigdecimal`, `ffi`, `eventmachine`, `http_parser.rb`)은 설치 때 컴파일되며, 스크래치 설치는 문제없이 끝났습니다.

## Architecture Patterns

### System Architecture Diagram

```
 운영자 편집
   │  (_includes/*, _layouts/legal.html, 페이지 front matter + 본문)
   ▼
 로컬 미리보기 ── bundle exec jekyll serve --livereload ──▶ http://localhost:4000
   │                (livereload 스크립트는 응답 때만 끼움. _site 파일에는 없음)
   ▼
 git commit ──▶ git push origin main
                  │
                  ▼  .githooks/pre-push (core.hooksPath)
          ┌───────────────────────────────────────────────┐
          │ 표준 입력에서 remote ref == refs/heads/main 인 줄만 │
          │ scripts/check-site.sh <푸시할 SHA>             │
          │   git archive SHA → 임시 폴더(pwd -P)          │
          │   BUNDLE_GEMFILE=메인 체크아웃/Gemfile          │
          │   jekyll build --safe (JEKYLL_ENV=production)  │
          │   ① 빌드 ② 내부 파일 ③ 제목 4개 ④ Liquid 잔여   │
          └───────────────┬───────────────────────────────┘
               실패 → 푸시 중단 (급하면 --no-verify)
               통과 ▼
 GitHub (main) ──▶ pages-build-deployment 워크플로 (build → report-build-status → deploy)
                  │  github-pages 232 / Jekyll 3.10.0 / Ruby 3.3.4 / safe: true
                  │  기본 테마 jekyll-theme-primer → /assets/css/style.css 추가 생성
                  ▼
 Fastly CDN (cache-control: max-age=600, 쿼리 문자열 무시)
                  ▼
 방문자·심사자  ◀── 라이브 확인: gh run watch → (한 요청) Last-Modified ≥ created_at → 그 본문 비교
```

### Recommended Project Structure

```
_config.yml              # url + exclude (Pattern 5)
Gemfile, Gemfile.lock    # 커밋. exclude 대상
.gitignore               # + _site/ .jekyll-cache/ vendor/ .bundle/
.githooks/pre-push       # 모드 100755로 커밋
scripts/check-site.sh    # 모드 100755로 커밋. exclude: scripts/
_includes/
  head-links.html        # preconnect ~ manifest 8줄 (index.html:18-25 = 법적 :13-20)
  css/common.css         # 「공통」 CSS 28줄 (index.html:31-58 = 법적 :37-64)
  header.html            # 헤더 14줄 (법적 :74-87, 링크만 include.home으로 분기)
  footer.html            # 푸터 24줄 (index.html:470-493 = 법적 각 파일 같은 구간)
_layouts/
  legal.html             # 법적 3종 전체 틀 (default/page/home/post 이름 금지)
index.html               # front matter + include 4곳
privacy-policy/index.html, terms/index.html, data-deletion/index.html   # front matter + 카드 본문
```

블록 경계는 이번 세션에 읽은 원본으로 확인했습니다.
- head 링크 시작·끝: `index.html:18` `    <link rel="preconnect" href="https://cdn.jsdelivr.net" crossorigin />`, `index.html:25` `    <link rel="manifest" href="/favicon/site.webmanifest" />`. `privacy-policy/index.html:13-20`도 같은 여덟 줄입니다. [VERIFIED: index.html:18-25, privacy-policy/index.html:13-20]
- 「공통」 CSS 시작·끝: `index.html:31` `        /* ── 공통: 바탕 · 머리말 · 바닥글 ──`, `index.html:58` `        @media (max-width: 860px) { .rp-nav { display: none; } }`, 그다음 빈 줄과 `index.html:60` `        /* ── 랜딩 전용 ── */`. 법적은 `terms/index.html:37`~`:64`, 그다음 빈 줄과 `:66` `        /* ── 법적 페이지 전용 ── 모눈종이 바탕. 글이 짧아도 바닥글이 화면 아래에 붙는다 */`. [VERIFIED: index.html:29-32,57-60, terms/index.html:35-38,63-70]
- 헤더: `terms/index.html:74` `    <!-- Header -->` ~ `:87` `    </header>`. `index.html:184-197`도 같은 구간이고, 다른 것은 `:187` `href="#top"`, `:192-194` `href="#story"`·`href="#demo"`·`href="#get"`뿐입니다(법적은 `:77` `href="/"`, `:82-84` `href="/#story"`·`href="/#demo"`·`href="/#get"`). [VERIFIED: index.html:182-197, terms/index.html:72-96]
- 푸터: `index.html:470` `    <!-- Footer -->` ~ `:493` `    </footer>`. 스크래치 전환에서 이 24줄 하나로 법적 3종까지 바이트가 같았으므로, 네 파일의 푸터가 같다는 것을 확인한 셈입니다. [VERIFIED: index.html:466-496 + 로컬 실험]

### Pattern 1: include 공백 규칙 (실측)

**What:** Liquid 4.0.4의 include는 태그 자리를 파일 내용으로 **글자 그대로** 바꿉니다. 들여쓰기를 따로 맞춰 주지 않습니다.
**실측 결과** (스크래치, 태그를 4칸 들여쓴 자리에 둔 경우):

| 상황 | 출력 | D-07로 흡수? |
|---|---|---|
| include 파일 끝에 줄바꿈 있음 | 첫 줄은 태그 앞 들여쓰기(4칸)를 받고, 둘째 줄부터는 파일 안의 들여쓰기 그대로. 파일 끝 `\n` + 태그 뒤 `\n` → **빈 줄 1개 추가** | 예 |
| include 파일 끝에 줄바꿈 없음 | 파일 내용이 정확히 그 자리에 들어감 | 차이 없음 |
| `{%- include x -%}` | `{%-`가 앞줄의 줄바꿈과 들여쓰기를 먹어 **앞줄과 첫 줄이 붙음**(`<c>line1`) | **아니요** (줄 내용이 바뀜) |
| 레이아웃에 `{{ content }}` + 줄바꿈 | 페이지 본문 끝 `\n` + 레이아웃 `\n` → 빈 줄 1개 추가 | 예 |
| 레이아웃에 `{{ content \| rstrip }}` + 줄바꿈 | 정확히 일치 | 차이 없음 |
| front matter `---\n---\n` 제거 | 앞에 빈 줄이 남지 않음 (`<a>\n` 그대로) | 차이 없음 |

[VERIFIED: 로컬 실험 `ws/` (od -c 출력 확인)]

**권장 규칙 (스크래치에서 네 문서 바이트 동일을 낸 조합):**
1. include 태그는 줄 맨 앞(0열)에 혼자 둡니다: `{% include header.html %}`
2. include 파일에는 원본 줄을 **원래 들여쓰기째** 담습니다(예: `    <!-- Header -->`로 시작).
3. include 파일은 **끝 줄바꿈 없이** 저장합니다. 에디터가 끝 줄바꿈을 붙여도 빈 줄 하나가 생길 뿐이고 D-07에서는 차이가 0입니다. 다만 바이트 동일(`cmp`)은 깨집니다.
4. `{%-`·`-%}`는 내용을 내보내지 않는 제어 태그(`if`·`endif`)에만 씁니다. 패턴은 Pattern 2의 `noindex`·`updated` 조건문과 같습니다.
5. 레이아웃 본문 자리에는 `{{ content | rstrip }}`를 씁니다.

### Pattern 2: legal 레이아웃 (스크래치에서 바이트 동일 확인)

**What:** `terms/index.html` 1~95행을 바탕으로 페이지별 값만 Liquid로 바꾸고, 본문 뒤의 닫는 태그와 푸터를 붙입니다. 아래는 스크래치에서 실제로 쓴 파일입니다. 긴 줄(tailwind-config 안쪽, 「법적 페이지 전용」 CSS)은 원본 그대로 옮깁니다.

```liquid
<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{{ page.title }} - 러닝펜슬</title>
    <meta name="description" content="{{ page.description }}" />
    {%- if page.noindex %}
    <meta name="robots" content="noindex" />
    {%- endif %}
    <meta name="theme-color" content="#F2B134" />
    <script src="https://cdn.tailwindcss.com"></script>
{% include head-links.html %}
    <script id="tailwind-config">
        … (terms/index.html:22-34 그대로) …
    </script>
    <style>
{% include css/common.css %}

        /* ── 법적 페이지 전용 ── 모눈종이 바탕. 글이 짧아도 바닥글이 화면 아래에 붙는다 */
        body { min-height: 100vh; display: flex; flex-direction: column; }
        main { flex: 1 0 auto; }
        .rp-grid { … (terms/index.html:69 그대로) … }
    </style>
</head>

<body>
{% include header.html %}

    <main class="rp-grid">
        <div class="mx-auto max-w-[800px] px-6 py-[clamp(48px,6vw,80px)]">
            <article class="rounded-[28px] border-[1.5px] border-line bg-white p-7 md:p-12">
                <span class="text-sm font-bold tracking-[0.04em] text-accent">{{ page.eyebrow }}</span>
                <h1 class="mt-3.5 text-[clamp(30px,6.5vw,42px)] font-black leading-[1.25] tracking-[-1px]">{{ page.heading | default: page.title }}</h1>
                {%- if page.updated %}
                <p class="mt-3 text-[13px] text-muted-2">최종 업데이트: {{ page.updated }}</p>
                {%- endif %}
                <div class="mt-10 space-y-8 leading-[1.7] text-muted">
{{ content | rstrip }}
                </div>
            </article>
        </div>
    </main>

{% include footer.html %}
</body>

</html>
```

- 레이아웃 안에서는 페이지 값을 `page.`로 읽습니다. CONTEXT D-01의 `{{ title }}`은 `{{ page.title }}`로 씁니다. [VERIFIED: 로컬 실험]
- **값이 없을 때(falsy) 분기도 확인했습니다.** `noindex`·`updated`·`heading`이 없는 시험 페이지에서는 robots 줄과 날짜 줄이 빠졌고, h1은 `title`이 됐습니다. 빈 줄이나 붙은 줄은 생기지 않았습니다. Phase 5 `/support/`와 Phase 6~8의 `noindex` 삭제가 이 동작에 기댑니다. [VERIFIED: 로컬 실험 `zz-falsy`]
- 정의되지 않은 변수는 오류 없이 빈 문자열이 됩니다(`{{ page.nope }}` → ``). front matter 키 이름을 잘못 쓰면 조용히 빈 값이 나옵니다. 제목은 check-site 3번이 잡고, 나머지는 diff가 잡습니다. `strict_variables`는 켜지 않습니다. 켜면 `heading`·`updated` 생략이 오류가 됩니다. [VERIFIED: 로컬 실험 `err3`]

페이지 파일(예: terms). 본문은 원본 96행부터 「임시 게시본」 문단의 `</p>`까지이며 들여쓰기를 그대로 둡니다. 값은 원본에서 그대로 옮깁니다.

```yaml
---
layout: legal
title: "서비스 이용약관"
description: "러닝펜슬 서비스 이용약관. 서비스 이용 조건, 코스·뱃지·포인트에 관한 규정, 이용자의 의무와 안전 책임을 안내합니다."
eyebrow: "TERMS OF SERVICE"
updated: "2026년 10월 31일"
noindex: true
---
                    <section class="space-y-3">
…
                    <p class="border-t border-line pt-4 text-sm text-muted-2">
                        본 약관은 임시 게시본이며, 정식 서비스 출시 시 갱신될 수 있습니다.
                    </p>
```

원본 값(그대로 옮길 것):
- terms: `<title>서비스 이용약관 - 러닝펜슬</title>`, `content="러닝펜슬 서비스 이용약관. 서비스 이용 조건, 코스·뱃지·포인트에 관한 규정, 이용자의 의무와 안전 책임을 안내합니다."`, `TERMS OF SERVICE`, h1 `서비스 이용약관`, `최종 업데이트: 2026년 10월 31일`. 본문은 `:96`부터 `:168` `                    </p>`까지이고, `:169` `                </div>`부터는 레이아웃의 몫입니다. [VERIFIED: terms/index.html:8-9, 92-96, 164-175]
- privacy-policy: `<title>개인정보처리방침 - 러닝펜슬</title>`, `content="러닝펜슬 개인정보처리방침. 수집 항목, 이용 목적, 위치정보 처리, 보유 기간, 사용자 권리를 안내합니다."`, `PRIVACY POLICY`, h1 `개인정보처리방침`, `최종 업데이트: 2026년 10월 31일` [VERIFIED: privacy-policy/index.html:8-9, 92-94]
- data-deletion: `<title>데이터 삭제 안내 - 러닝펜슬</title>`, `content="러닝펜슬 계정 및 사용자 데이터 삭제 방법과 삭제되는 데이터 항목을 안내합니다."`, `DATA DELETION`, h1 `사용자 데이터 삭제 안내`(→ `heading` 키 필요), `최종 업데이트: 2026년 10월 31일` [VERIFIED: data-deletion/index.html:8-9, 92-94]
- 세 description에는 `"`와 `\`가 없습니다. 그래서 YAML 큰따옴표로 감싸도 안전하고, HTML 속성에 그대로 넣어도 됩니다. 값에 `: `가 생길 수 있으니 큰따옴표로 감싸는 쪽을 권장합니다.

### Pattern 3: 랜딩 (레이아웃 없이 include 4곳)

```
---
layout: none
---
<!DOCTYPE html>
… (index.html:1-17 그대로) …
{% include head-links.html %}
    <script>            ← pre-paint 스크립트 그대로
…
    <style>
{% include css/common.css %}

        /* ── 랜딩 전용 ── */
…
{% include header.html home=true %}
…
{% include footer.html %}

    <script>            ← 끝 인라인 스크립트 그대로
```

- 빈 front matter(`---`/`---`)와 `layout: none` 모두 바이트 동일을 확인했습니다. [VERIFIED: 로컬 실험]
- **`layout: none` 권장 (재량 사항).** Jekyll 3.10은 `layout: none`을 「레이아웃 없음」으로 처리합니다(`convertible.rb:251-252` `def no_layout?` / `data["layout"] == "none"`). 운영의 `jekyll-default-layout`은 `layout` 키가 이미 있으면 건드리지 않습니다. 고정된 v0.1.5는 원래 마크다운만 대상이지만, 이 한 줄이 있으면 운영 테마(primer)의 `home` 레이아웃이 붙을 여지가 아예 없어집니다. [VERIFIED: Jekyll 3.10.0 gem 소스, jekyll-default-layout v0.1.5 소스]
- 랜딩 전체가 Liquid를 거칩니다. CSS의 `{ }`와 JS 객체 리터럴 `{ step: 0 }` 같은 홑중괄호는 안전합니다. 문제가 되는 것은 `{{`와 `{%`뿐이고, 둘 다 0건입니다. [VERIFIED: grep + 로컬 빌드 바이트 동일]

### Pattern 4: 헤더 링크 변형 → include 매개변수 권장

```liquid
            <a class="rp-brand" href="{% if include.home %}#top{% else %}/{% endif %}" aria-label="러닝펜슬 홈">
…
                <a href="{% unless include.home %}/{% endunless %}#story">즐기는 법</a>
                <a href="{% unless include.home %}/{% endunless %}#demo">달려 보기</a>
                <a href="{% unless include.home %}/{% endunless %}#get">출시 안내</a>
```
- 랜딩은 `{% include header.html home=true %}`, 법적 레이아웃은 `{% include header.html %}`입니다. 따옴표 없는 `true`는 Liquid 불리언 리터럴로 처리됩니다. 랜딩 출력이 바이트 동일이었으므로 확인된 것입니다. [VERIFIED: 로컬 실험]
- **`page.url` 판정 대신 매개변수를 고르는 이유:** Phase 9에 `/en/` 랜딩이 생기면 `page.url` 방식은 랜딩 URL 목록(`/`, `/en/`)을 include 안에서 알아야 합니다. 매개변수 방식은 부르는 쪽 한 줄로 끝납니다. Phase 5 `/support/`처럼 legal 레이아웃을 쓰는 새 페이지는 자동으로 `/` 변형이 됩니다. 두 방식 모두 출력은 같습니다.
- 태그가 한 줄 안에 있으므로 공백 문제가 없습니다.

### Pattern 5: `_config.yml` `exclude` 최종안

```yaml
url: "https://runningpencil.com"
exclude:
  - CNAME
  - CLAUDE.md
  - README.md
  - .planning/
  - Gemfile
  - Gemfile.lock
  - vendor/
  - prepare/
  - scripts/
  - .githooks/
```
- **현재 값**(이 목록에 더함): `_config.yml:9-13` `exclude:` / `  - CNAME` / `  - CLAUDE.md` / `  - README.md` / `  - .planning/` [VERIFIED: _config.yml:1-14]. 1~8행의 머리 주석(CNAME 설명)은 남기고, Gemfile·vendor 같은 기본 제외 목록이 덮어써진다는 설명을 한 줄 더합니다.
- **사용자 지정 `exclude`는 점·밑줄 규칙을 바꾸지 않습니다.** Jekyll 3.10의 `EntryFilter#filter`는 `special?(e) || backup?(e) || excluded?(e)`로 거릅니다. `special?`은 첫 글자가 `"."`, `"_"`, `"#"`, `"~"`인지만 봅니다. 이 판정은 `exclude`와 상관없고, `include`에 있을 때만 풀립니다. [VERIFIED: jekyll-3.10.0 `lib/jekyll/entry_filter.rb:6-8,32-51`] 그래서 `.claude/`, `.gsd/`, `.bundle/`, `.gitignore`, `_site/`, `_includes/`, `_layouts/`는 목록에 없어도 출력되지 않습니다. 기준 빌드(`exclude`에 `.claude` 없음)에서 `.claude/CLAUDE.md`가 출력되지 않은 것으로 확인했습니다. [VERIFIED: 로컬 실험 base_site 파일 목록]
- `.planning/`·`.githooks/`는 같은 이유로 중복이지만 남깁니다(D-11, 그리고 나중에 누가 `include:`를 쓰더라도 막히게).
- Jekyll 기본값은 `"exclude" => %w(Gemfile Gemfile.lock node_modules vendor/bundle/ vendor/cache/ vendor/gems/ vendor/ruby/)`이고, 사용자 값이 이것을 통째로 바꿉니다. [VERIFIED: jekyll-3.10.0 `lib/jekyll/configuration.rb:21-24`] 운영 `github-pages`는 사용자 `exclude`가 Jekyll 기본값과 같을 때만 `CNAME`을 더합니다(`exclude_cname`). 그래서 운영의 실효 `exclude`도 이 목록 그대로입니다. [VERIFIED: pages-gem v232 `configuration.rb:104,159-163` `return unless config["exclude"].eql? Jekyll::Configuration::DEFAULTS["exclude"]`]
- 일치 방식: `File.fnmatch?` 또는 **앞부분 일치**(`start_with?`)입니다. 그래서 `Gemfile`은 `Gemfile.lock`까지, `scripts/`는 `scripts`로 시작하는 루트 항목까지 뺍니다. [VERIFIED: entry_filter.rb:92-124]
- 이 목록으로 Gemfile·lock·`scripts/`·`.githooks/`·`vendor/bundle`(Liquid 문법 오류 파일까지 넣음)·`prepare/`·`.bundle/`을 사본에 넣고 빌드했을 때, `_site` 파일 목록이 기준 11개와 같았습니다. [VERIFIED: 로컬 실험]

### Anti-Patterns to Avoid
- **`{%- include … -%}`로 공백 정리:** 앞뒤 줄이 붙어 D-07에서도 차이가 납니다(Pattern 1 표).
- **include 태그를 들여쓴 자리에 두고 include 파일에도 들여쓰기:** 첫 줄 들여쓰기가 두 번 들어갑니다. D-07은 흡수하지만 바이트 동일은 깨집니다. 0열 규칙 하나로 통일합니다.
- **레이아웃 이름 `default`·`home`·`page`·`post`:** 운영 기본 테마 primer 0.6.0에 이 네 레이아웃이 있습니다(`_layouts/default.html`, `home.html`, `page.html`, `post.html`). 같은 이름을 쓰면 테마와 얽힙니다. [VERIFIED: `gh api repos/pages-themes/primer/git/trees/v0.6.0`]
- **`relative_url`/`absolute_url`로 경로 바꾸기:** 출력이 바뀝니다(CONTEXT 제약).
- **`_site`를 `jekyll serve`가 띄운 상태에서 비교·점검:** 점검은 항상 별도 임시 대상 폴더에 `jekyll build`로 합니다(Pitfall 8).

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| 공통 블록 조립 | sed/Python으로 마커 사이를 찍어 넣는 빌드 스크립트 | Jekyll `{% include %}` / 레이아웃 | 운영이 이미 Jekyll을 거칩니다. 생성물 커밋은 실행을 잊는 순간 깨집니다(STACK 연구) |
| 「커밋의 추적 파일만」 얻기 | `rsync --exclude` 목록 관리 | `git archive <sha> \| tar -x` | GitHub Pages가 보는 것과 정확히 같습니다. gitignore된 `prepare/`·`vendor/`가 자동으로 빠집니다 |
| 배포 완료 대기 | `curl` 반복으로 내용 변화 감지 | `gh run list --workflow pages-build-deployment -c <sha>` → `gh run watch <id> --exit-status` | 리팩터라 내용이 같으므로 내용 변화로는 새 배포를 알아볼 수 없습니다 |
| CDN 반영 판정 | 쿼리 문자열 캐시 우회 | 한 번의 요청으로 받은 응답의 `Last-Modified >= builds/latest.created_at` | 쿼리 문자열은 캐시 키에서 무시됩니다(Pitfall 1) |
| Ruby 버전 관리 | rbenv/mise 도입 | Homebrew Ruby 4.0.9 + `jekyll = 3.10.0` 고정 | 잠긴 결정 |

**Key insight:** 이 단계의 위험은 「코드가 틀림」보다 「확인이 틀림」입니다. 바이트가 같은 리팩터는 라이브가 옛 캐시를 보여 줘도 통과처럼 보입니다. 모든 확인은 「무엇이 새 것인지」를 먼저 증명한 다음에 합니다(SHA 지정 빌드, `Last-Modified`).

## Runtime State Inventory

리팩터 단계이므로 「저장소 파일을 모두 고친 뒤에도 바뀌지 않은 채 남는 런타임 상태」를 다섯 갈래로 확인했습니다.

| Category | Items Found | Action Required |
|----------|-------------|------------------|
| Stored data | 없음. DB·폼·저장소가 없는 정적 사이트입니다. 사이트 JS도 영속 저장을 쓰지 않습니다(`.planning/codebase/ARCHITECTURE.md` State Management: 「영속 저장 없음」) | 없음 |
| Live service config | (1) GitHub Pages 설정: `build_type: legacy`, `source: {branch: main, path: /}`, `cname: runningpencil.com`, `https_enforced: true` [VERIFIED: `gh api repos/SlimPumpkin/runningpencil.com/pages`]. 이 단계는 바꾸지 않습니다. (2) Fastly CDN에 남은 옛 배포 객체: 200은 `max-age=600`, 404는 수명 미상(`age: 694` 관찰). 이번 연구에서 조회한 내부 파일 경로의 404도 캐시돼 있을 수 있습니다 | 코드 수정 없음. 라이브 확인 절차가 캐시를 감안합니다(Pitfall 1·2) |
| OS-registered state | 없음(launchd·cron 등 없음). 다만 `core.hooksPath`는 클론마다 `.git/config`에 따로 저장되는 로컬 설정이라 커밋되지 않습니다. 현재 이 저장소에는 설정돼 있지 않습니다 [VERIFIED: `git config core.hooksPath` 출력 없음] | 계획의 작업으로 `git config core.hooksPath .githooks` 실행 + `CLAUDE.md`에 클론마다 한 번 하라고 기록(D-14) |
| Secrets/env vars | 없음. `.env`가 없습니다. `gh` 인증은 사용자 기기의 기존 로그인을 씁니다. 스크립트는 토큰을 읽거나 저장하지 않습니다 | 없음 |
| Build artifacts / installed packages | `vendor/bundle/`(gem), `.bundle/config`(`BUNDLE_PATH: "vendor/bundle"`), `_site/`(로컬 빌드 결과). 모두 gitignore 대상이라 새 worktree나 새 클론에는 없습니다. Jekyll 3.10은 `.jekyll-cache/`를 만들지 않습니다(관찰) | 메인 체크아웃에서 `bundle install`. worktree는 check-site의 대체 경로로 메인 체크아웃 gem을 씀(Wave 0 주의) |

## Common Pitfalls

### Pitfall 1: 라이브 비교가 옛 캐시를 보고 통과함
**What goes wrong:** 출력이 바이트 단위로 같은 리팩터라서, CDN이 배포 전 HTML을 줘도 diff 0이 나옵니다.
**Why it happens:** GitHub Pages(Fastly)는 `cache-control: max-age=600`이고, 쿼리 문자열을 캐시 키에서 무시합니다. 실측에서 서로 다른 `?v=<난수>` 세 번 모두 맨 URL과 같은 `age`(19/22~23/26), `x-cache: HIT`이었습니다. [VERIFIED: curl 실측 2026-11-15]
**How to avoid:** (1) `gh run watch`로 배포 성공 확인. (2) `gh api repos/SlimPumpkin/runningpencil.com/pages/builds/latest`의 `commit == 푸시한 SHA`, `status == "built"` 확인, **`created_at`** 기록. (3) URL마다 **한 번의 요청**(`curl -s -D <헤더> -o <본문>`)으로 헤더와 본문을 함께 받고, 그 응답의 `Last-Modified >= created_at`일 때만 그 본문을 비교에 씁니다. 아니면 기다렸다가 다시 받습니다(최대 약 10분). 헤더와 본문을 따로 요청하면 안 됩니다. 실측에서 요청마다 `x-served-by` 캐시 노드가 바뀌었으므로, 새 헤더와 옛 본문이 짝지어질 수 있습니다. 기준을 `updated_at` 대신 `created_at`(푸시 뒤, 새 파일 생성 전)으로 잡으면 1초 차이로 영원히 STALE에 걸리는 일이 없습니다. 현재 라이브는 `last-modified: Sat, 14 Nov 2026 16:41:25 GMT`이고 `builds/latest.updated_at`은 `2026-11-14T16:41:25Z`로 같았습니다. 같은 빌드의 `created_at`은 `2026-11-14T16:40:54Z`였습니다. ETag `"6af88f35-408f"`는 `hex(배포 시각)-hex(바이트 크기)` 꼴이었습니다(0x408f = 16527 = terms 크기). 이 관찰은 빌드 한 번에서만 했습니다. [VERIFIED: curl + gh api, 1회 관찰]
**Warning signs:** `Last-Modified`가 푸시 전 시각 그대로인데 diff 0.
**배포가 캐시를 지우는지(purge)는 확인하지 못했습니다** [ASSUMED]. 지운다고 가정하지 않습니다.

### Pitfall 2: 캐시된 404가 새로 노출된 내부 파일을 가림
**What goes wrong:** 404 응답도 캐시됩니다. 실측한 `/Gemfile` 404는 `x-cache: HIT`, `age: 694`였고 `cache-control` 헤더가 없었습니다. 그래서 404의 캐시 수명은 알 수 없고, 600초보다 길 수 있습니다 [VERIFIED: curl 실측 / 수명은 ASSUMED]. 배포 전에 조회해 캐시된 404는, 배포 뒤 실제로 노출된 파일을 가릴 수 있습니다. **이번 연구 세션도 `/CLAUDE.md`, `/README.md`, `/_config.yml`, `/.claude/CLAUDE.md`, `/.planning/ROADMAP.md`, `/CNAME`, `/Gemfile`을 조회했습니다.** 이 경로들의 404는 지금 CDN에 캐시돼 있을 수 있습니다.
**How to avoid:** 푸시 전에는 내부 파일 URL을 조회하지 않습니다. 배포 뒤에는 **응답의 `age`가 「배포(`created_at`) 뒤 지난 초」보다 작은 404만** 통과로 칩니다. `age`가 더 크면 배포 전 캐시이므로 기다렸다가 다시 조회합니다. 내부 파일 노출의 1차 관문은 로컬 check-site 2번 항목이고, 라이브 404는 2차 확인입니다.
**덤:** 실측 중 `/Gemfile`에 일시적인 **503**이 두 번 나왔다가 404로 돌아왔습니다. 5xx는 재시도 대상으로 보고, 통과나 실패로 판정하지 않습니다. [VERIFIED: curl 실측]

### Pitfall 3: 첫 푸시에 Phase 1 커밋 105개가 함께 올라감
**What goes wrong:** `origin/main`은 `c4cb26d`이고 로컬 `main`은 105커밋 앞서 있습니다. 첫 푸시(D-15 ①)가 Phase 1 산출물 전부와 Phase 2 빌드 설정을 한꺼번에 배포합니다. `c4cb26d..HEAD`에서 `.planning` 밖의 변경은 `.claude/CLAUDE.md`(+432), `.gitignore`(+3), `CLAUDE.md`(56줄), `_config.yml`(+1, `.planning/`)입니다. [VERIFIED: `git ls-remote origin main`, `git diff --stat c4cb26d HEAD -- . ':!.planning'`]
**Why it matters:** 지금 라이브에서 `/.planning/…`와 `/.claude/…`가 404인 것은 `exclude` 덕분이 아니라 그 파일이 원격에 없기 때문입니다. `exclude`와 점 규칙이 실제로 시험되는 것은 첫 푸시 때가 처음입니다.
**How to avoid:** 푸시 ①의 checkpoint에서 「105개 Phase 1 커밋이 함께 나간다」를 승인 내용에 명시합니다. 라이브 404 목록에 `/.claude/CLAUDE.md`를 더합니다. 지금의 라이브 HTML 4개는 HEAD 원본과 바이트가 같습니다(`cmp`). 그래서 기준(D-09)과 라이브 기준은 같은 것입니다. [VERIFIED: curl | cmp]

### Pitfall 4: `--safe` 빌드가 macOS 임시 폴더에서 include를 못 찾음
**What goes wrong:** `mktemp -d`는 `$TMPDIR=/var/folders/…` 아래에 폴더를 만듭니다. `/var`는 `/private/var`의 심볼릭 링크입니다. `--safe`(운영과 같은 설정)로 빌드하면 include의 실제 경로가 원본 「밖」으로 판정됩니다. 그래서 `Could not locate the included file 'head-links.html' … and is not a symlink as those are not allowed in safe mode.`로 실패합니다.
**How to avoid:** `WORK=$(cd "$WORK" && pwd -P)`. 이번 실험에서 실패를 재현한 뒤 이 한 줄로 고쳐지는 것을 확인했습니다. `--safe` 없는 빌드는 이 검사를 하지 않아 그냥 통과합니다. 그래서 문제가 숨습니다. [VERIFIED: 로컬 실험]

### Pitfall 5: bash 3.2 함정
**What goes wrong:** `"$errors건"` → `errors�: unbound variable`(`set -u`). 한글 첫 바이트를 변수 이름에 붙여 읽습니다.
**How to avoid:** 한글이나 다른 글자가 바로 붙는 변수는 모두 `${var}`로 씁니다. 다음 검사로 확인합니다: `LC_ALL=C grep -nE '\$[A-Za-z_][A-Za-z_0-9]*[^ -~]' scripts/check-site.sh .githooks/pre-push`가 0건이어야 합니다. 연관 배열, `mapfile`, `${x,,}`, `|&`를 쓰지 않습니다. 문법 검사는 `/bin/bash -n`. [VERIFIED: 로컬 실험에서 재현·수정]

### Pitfall 6: 훅이 조용히 안 돎
**What goes wrong:** (a) 실행 권한 없이 커밋된 훅은 git이 `hint: The '.githooks/pre-push' hook was ignored because it's not set as executable.`만 내고 **푸시를 그대로 진행**합니다(실측). (b) 새 클론이나 다른 컴퓨터에서 `core.hooksPath`를 설정하지 않으면 훅이 없는 것과 같습니다. (c) 현재 이 저장소에는 `core.hooksPath`가 설정돼 있지 않습니다.
**How to avoid:** `git add` 전에 `chmod +x`, 그리고 `git ls-files -s .githooks/pre-push scripts/check-site.sh`가 `100755`인지 확인합니다. `git config core.hooksPath .githooks`를 계획의 작업으로 실행하고 `CLAUDE.md`에 적습니다(D-14). worktree는 `.git/config`를 공유하므로 한 번 설정하면 모든 worktree에 적용됩니다. 상대 경로 `.githooks`는 각 worktree 루트를 기준으로 풀립니다. [VERIFIED: 로컬 실험, git-config(1) core.hooksPath]

### Pitfall 7: GUI git 클라이언트나 짧은 PATH에서 시스템 Ruby 2.6을 잡음
**What goes wrong:** `PATH=/usr/bin:/bin:…`에서는 `bundle`이 `/usr/bin/bundle`(Bundler 1.17.2, Ruby 2.6.10)로 풀립니다. `bundle exec`가 긴 traceback을 내며 실패합니다. [VERIFIED: `env -i PATH=/usr/bin:/bin … bundle -v` → `Bundler version 1.17.2`]
**How to avoid:** 훅 머리에서 `PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"`. 점검 스크립트는 `bundle exec jekyll -v`가 정확히 `jekyll 3.10.0`인지 확인하고, 아니면 `ruby`·`bundle` 경로와 버전을 담은 메시지로 실패합니다. 짧은 PATH로 훅을 거친 푸시는 통과했고, 스크립트를 직접 돌리면 안내 메시지와 함께 실패했습니다. [VERIFIED: 로컬 실험]

### Pitfall 8: `jekyll serve` 결과를 운영 출력으로 착각
**What goes wrong:** `serve --livereload`는 응답할 때 `<head>`에 livereload `<script>`를 끼웁니다(디스크의 `_site`에는 쓰지 않음). 또 development 환경에서 `url`을 `http://localhost:4000`으로 바꿉니다. 그래서 브라우저 「소스 보기」나 `curl localhost:4000`은 운영과 다릅니다. [VERIFIED: jekyll-3.10.0 `commands/serve/servlet.rb:45-83,159-176`, `commands/serve.rb:90-91`]
**How to avoid:** 비교와 점검은 별도 임시 대상 폴더에 `JEKYLL_ENV=production bundle exec jekyll build --safe`로 만든 파일로만 합니다.

### Pitfall 9: 훅의 표준 입력을 하위 명령이 먹음
**What goes wrong:** pre-push 훅은 표준 입력으로 `<local-ref> SP <local-object-name> SP <remote-ref> SP <remote-object-name> LF` 줄들을 받습니다. `while read` 루프 안에서 부른 명령이 표준 입력을 읽으면 나머지 줄이 사라집니다. [CITED: githooks(5) pre-push]
**How to avoid:** `"$TOP/scripts/check-site.sh" "$local_sha" < /dev/null`. 삭제 푸시(`local_sha`가 전부 0)와 `main`이 아닌 ref는 건너뜁니다. 훅은 작업 트리 루트에서 실행됩니다(githooks(5) DESCRIPTION).

### Pitfall 10: check-site 4번 항목과 `{% raw %}`의 충돌
**What goes wrong:** 앞으로 인라인 JS를 `{% raw %}`로 감싸 `{{`를 일부러 내보내면, 출력에 `{{`가 남아 4번 항목이 실패합니다(실험 `err3`에서 raw 출력에 `{{ name }}`·`{% x %}`가 그대로 남음). [VERIFIED: 로컬 실험]
**How to avoid:** 지금은 0건이라 문제가 없습니다. 스크립트 4번 항목 위에 「raw로 일부러 내보내는 경우가 생기면 예외 규칙을 더한다」는 주석을 둡니다. `CLAUDE.md`의 `{% raw %}` 규칙 옆에도 이 관계를 한 줄 적습니다.

### Pitfall 11: 변수로 만든 경로를 `rm -rf`
**What goes wrong:** `rm -rf "$WORK"`는 `WORK`가 비면 위험합니다. Claude Code의 안전 검사도 이 꼴을 막습니다(이번 세션에서 실제로 막힘).
**How to avoid:** `rm -rf "${WORK:?}"`처럼 비었을 때 멈추는 꼴로만 씁니다. 스크립트 정리는 `trap '…' EXIT` 한 곳에서 합니다.

### Pitfall 12: 운영에만 있는 테마 파일
**What goes wrong:** 운영 `github-pages`의 DEFAULTS에 `"theme" => "jekyll-theme-primer"`가 있습니다. `_config.yml`에 `theme`이 없으면 primer가 적용되고, 테마의 `assets/css/style.scss`가 `/assets/css/style.css`(76,559바이트, 200)로 나갑니다. 로컬 빌드에는 이 파일이 없습니다. [VERIFIED: pages-gem v232 `configuration.rb:14-31`, curl]
**How to avoid:** 고치지 않습니다(`theme: null`을 넣으면 라이브 파일이 하나 사라져 「출력 불변」을 어깁니다). 검증 문서에 「D-08 파일 목록 비교는 로컬 대 로컬이며, 운영에는 테마 파일이 하나 더 있다」고 적습니다. 라이브 확인에서는 `/assets/css/style.css`가 푸시 전후 모두 200인지만 봅니다. 없애려면 별도 단계에서 사용자가 정합니다(Open Questions).

## Code Examples

### `scripts/check-site.sh` (스크래치 git 저장소에서 성공·실패 4종·짧은 PATH·worktree 시험 완료)

```bash
#!/usr/bin/env bash
# 푸시 전 점검. 운영(GitHub Pages)과 같은 Jekyll 3.10.0으로 빌드하고 네 가지를 확인한다.
#   1. 빌드가 성공한다
#   2. 빌드 결과에 내부 파일이 없다
#   3. 기존 URL 문서 4개가 있고 <title>이 기대값과 같다
#   4. 출력 HTML에 처리되지 않은 Liquid({%, {{)가 없다
# 사용법: scripts/check-site.sh          작업 트리를 빌드해 점검한다
#         scripts/check-site.sh <커밋>   그 커밋의 추적 파일만 내보내 빌드해 점검한다 (pre-push 훅이 이렇게 부른다)
# macOS 기본 /bin/bash 3.2에서도 돌도록 연관 배열·mapfile을 쓰지 않는다.
set -u

# ── 기대값 (이후 단계에서 바뀌면 여기만 고친다) ──
JEKYLL_VERSION='jekyll 3.10.0'
# 법적 URL 3개의 제목은 Ground Rule로 고정한다. 랜딩 제목은 Phase 4에서 바뀔 수 있고, 바꾸는 단계가 이 값도 고친다.
EXPECTED_TITLES='index.html|러닝펜슬 - 달리고 걷는 길이 아트가 됩니다
privacy-policy/index.html|개인정보처리방침 - 러닝펜슬
terms/index.html|서비스 이용약관 - 러닝펜슬
data-deletion/index.html|데이터 삭제 안내 - 러닝펜슬'
# 빌드 결과에 있으면 안 되는 경로 (D-13). 원본 조각(_includes·_layouts)과 설정 파일도 포함한다.
FORBIDDEN='CLAUDE.md README.md Gemfile Gemfile.lock vendor .planning prepare scripts .githooks _includes _layouts _config.yml'

fail() { printf 'check-site: 실패 — %s\n' "$*" >&2; exit 1; }

# ── 도구 확인 ──
command -v git >/dev/null 2>&1 || fail 'git이 없습니다.'
TOP=$(git rev-parse --show-toplevel 2>/dev/null) || fail '저장소 안에서 실행하세요.'
command -v bundle >/dev/null 2>&1 || fail 'bundle 명령이 없습니다. Homebrew Ruby(brew install ruby)를 설치하고 PATH에 넣은 뒤 bundle install 하세요.'

# gem을 찾을 체크아웃: 지금 체크아웃에 .bundle/config가 없으면(새 worktree) 메인 체크아웃의 것을 쓴다
COMMON=$(git rev-parse --path-format=absolute --git-common-dir)
GEMROOT=$TOP
[ -f "$TOP/.bundle/config" ] || GEMROOT=$(dirname "$COMMON")
[ -f "$GEMROOT/Gemfile" ] || fail "Gemfile이 없습니다: $GEMROOT/Gemfile"
export BUNDLE_GEMFILE="$GEMROOT/Gemfile"

got=$(bundle exec jekyll -v 2>/dev/null) || fail "bundle exec jekyll 실행 실패. ruby=$(command -v ruby) bundle=$(command -v bundle) ($(bundle -v 2>&1 | head -n 1)). Homebrew Ruby가 PATH 앞에 있는지 확인하고 '$GEMROOT'에서 bundle install 하세요."
[ "$got" = "$JEKYLL_VERSION" ] || fail "Jekyll 버전이 다릅니다: '$got' (기대: '$JEKYLL_VERSION')"

# ── 빌드할 원본 준비 ──
WORK=$(mktemp -d "${TMPDIR:-/tmp}/rp-check.XXXXXX") || fail '임시 폴더를 만들 수 없습니다.'
trap 'rm -rf "${WORK:?}"' EXIT
# macOS의 /var/folders는 /private/var의 심볼릭 링크다. --safe 빌드는 실제 경로가 원본 밖이면 include를 거부하므로 실제 경로로 바꾼다.
WORK=$(cd "$WORK" && pwd -P) || fail '임시 폴더 경로 확인 실패'
if [ $# -ge 1 ]; then
    rev=$(git rev-parse --verify --quiet "$1^{commit}") || fail "커밋을 찾을 수 없습니다: $1"
    mkdir "$WORK/src" && git archive --format=tar "$rev" | tar -x -C "$WORK/src" || fail 'git archive 실패'
    SRC="$WORK/src"; label="커밋 ${rev:0:12}"
else
    SRC="$TOP"; label='작업 트리'
fi
DEST="$WORK/site"

# ── 1. 빌드 ──
if ! JEKYLL_ENV=production bundle exec jekyll build --safe -s "$SRC" -d "$DEST" > "$WORK/build.log" 2>&1; then
    grep -v '^[[:space:]]*from ' "$WORK/build.log" | tail -n 15 >&2
    fail "Jekyll 빌드 실패 ($label)"
fi

errors=0
problem() { printf 'check-site: %s\n' "$*" >&2; errors=$((errors + 1)); }

# ── 2. 내부 파일 ──
for p in $FORBIDDEN; do
    [ -e "$DEST/$p" ] && problem "내부 파일이 출력에 있습니다: /$p"
done
leaked=$(cd "$DEST" && find . \( -name '*.md' -o -name '.*' -o -name '_*' \) ! -name . -print)
[ -n "$leaked" ] && problem "공개되면 안 되는 파일: $(printf '%s ' $leaked)"

# ── 3. 기존 URL 문서와 제목 ──
while IFS='|' read -r path want; do
    [ -n "$path" ] || continue
    if [ ! -f "$DEST/$path" ]; then problem "문서가 없습니다: /$path"; continue; fi
    have=$(sed -n 's:.*<title>\(.*\)</title>.*:\1:p' "$DEST/$path" | head -n 1)
    [ "$have" = "$want" ] || problem "제목이 다릅니다: /$path → '$have' (기대: '$want')"
done <<TITLES
$EXPECTED_TITLES
TITLES

# ── 4. 처리되지 않은 Liquid ──
# {% raw %}로 일부러 내보내는 {{ 가 생기면 이 검사가 걸린다. 그때는 예외 규칙을 여기에 더한다.
raw=$(grep -rlF -e '{%' -e '{{' --include='*.html' "$DEST" 2>/dev/null)
[ -n "$raw" ] && problem "Liquid가 처리되지 않은 출력: ${raw//$DEST/}"

[ "$errors" -eq 0 ] || fail "${errors}건 (${label})"
printf 'check-site: 통과 (%s, %s)\n' "$label" "$got"
```

제목 기대값 출처: `index.html:8` `    <title>러닝펜슬 - 달리고 걷는 길이 아트가 됩니다</title>`, `privacy-policy/index.html:8` `    <title>개인정보처리방침 - 러닝펜슬</title>`, `terms/index.html:8` `    <title>서비스 이용약관 - 러닝펜슬</title>`, `data-deletion/index.html:8` `    <title>데이터 삭제 안내 - 러닝펜슬</title>`. [VERIFIED: 각 파일 Read]

**실패 주입 결과** (스크래치 git 저장소 + bare 원격, `git push origin main`): 각 경우 모두 푸시가 rc=1로 막혔습니다. [VERIFIED: 로컬 실험]

| 주입 | 메시지 |
|---|---|
| `{% include footer.html` 닫는 괄호 삭제 | `check-site: 실패 — Jekyll 빌드 실패 (커밋 dc8766ae14ec)` |
| `exclude`에서 `Gemfile` 두 줄 삭제 | `내부 파일이 출력에 있습니다: /Gemfile`, `/Gemfile.lock` |
| terms `title`을 「이용약관」으로 | `제목이 다릅니다: /terms/index.html → '이용약관 - 러닝펜슬' (기대: '서비스 이용약관 - 러닝펜슬')` |
| `index.html` front matter 삭제 | `Liquid가 처리되지 않은 출력: /index.html` |

추가로 확인한 것: `main`이 아닌 브랜치 푸시는 점검을 건너뜀. linked worktree(`vendor/`·`.bundle/` 없음)에서 푸시하면 메인 체크아웃의 gem으로 통과. 짧은 PATH에서도 훅의 PATH 보강으로 통과.

### `.githooks/pre-push`

```bash
#!/usr/bin/env bash
# main으로 가는 푸시마다 scripts/check-site.sh로 그 커밋을 점검한다. 실패하면 푸시를 멈춘다.
# 켜기(클론마다 한 번): git config core.hooksPath .githooks   급할 때 건너뛰기: git push --no-verify
set -u
# GUI git 클라이언트는 PATH가 짧아 macOS 시스템 Ruby 2.6을 먼저 잡는다. Homebrew 경로를 앞에 둔다.
PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
TOP=$(git rev-parse --show-toplevel) || exit 1
status=0
while read -r local_ref local_sha remote_ref remote_sha; do
    [ "$remote_ref" = 'refs/heads/main' ] || continue      # 배포는 main에서만 일어난다
    case "$local_sha" in *[!0]*) ;; *) continue ;; esac    # 브랜치 삭제 푸시는 건너뛴다
    "$TOP/scripts/check-site.sh" "$local_sha" < /dev/null || status=1   # 훅의 표준 입력을 점검 스크립트가 먹지 않게 막는다
done
exit $status
```

설치(계획의 작업으로):
```bash
chmod +x scripts/check-site.sh .githooks/pre-push
git add scripts/check-site.sh .githooks/pre-push
git ls-files -s scripts/check-site.sh .githooks/pre-push   # 둘 다 100755
git config core.hooksPath .githooks                         # 로컬 설정. 커밋되지 않음
```

### 일회용 기준 비교 (D-05~D-09, 스크래치에서 성공·실패 경로 확인)

전제: Gemfile을 만들고 `bundle install`까지 끝난 작업 트리여야 합니다. 기준 커밋에는 Gemfile이 없으므로 `BUNDLE_GEMFILE`로 작업 트리의 것을 씁니다. 상대 경로로 저장된 `BUNDLE_PATH: "vendor/bundle"`은 Gemfile이 있는 폴더를 기준으로 풀립니다. 다른 폴더에서 실행해도 같은 gem을 찾는 것을 확인했습니다. [VERIFIED: 로컬 실험 `rs/`]

```bash
#!/usr/bin/env bash
# Phase 2 일회용 비교 (D-05~D-09). 기준 커밋과 후보 커밋을 각각 깨끗하게 내보내 빌드하고
#   (1) 네 문서의 D-07 정규화 diff, (2) _site 파일 목록 diff를 낸다. 저장소 파일은 건드리지 않는다.
# 사용: compare.sh <기준 커밋> <후보 커밋> [--no-comments]
set -u
BASE=$1; CAND=$2; MODE=${3:-}
REPO=$(git rev-parse --show-toplevel) || exit 1
export BUNDLE_GEMFILE="$REPO/Gemfile"            # 기준 커밋에는 Gemfile이 없으므로 사본 밖(작업 트리)의 것을 쓴다
export LC_ALL=C                                   # 정규화가 ASCII 공백만 다루도록 고정
WORK=$(mktemp -d "${TMPDIR:-/tmp}/rp-cmp.XXXXXX") && WORK=$(cd "$WORK" && pwd -P) || exit 1
trap 'rm -rf "${WORK:?}"' EXIT
norm() { sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' "$1" | grep -v '^$'; }   # D-07
build() {  # $1=커밋 $2=이름 → $WORK/$2-src, $WORK/$2-site, $WORK/$2-files.txt
    mkdir "$WORK/$2-src" && git -C "$REPO" archive "$1" | tar -x -C "$WORK/$2-src" || return 1
    JEKYLL_ENV=production bundle exec jekyll build --safe -q -s "$WORK/$2-src" -d "$WORK/$2-site" || return 1
    (cd "$WORK/$2-site" && find . -type f | sort) > "$WORK/$2-files.txt"
}
build "$BASE" base || { echo "기준 빌드 실패"; exit 1; }
build "$CAND" cand || { echo "후보 빌드 실패"; exit 1; }
status=0
for f in index.html privacy-policy/index.html terms/index.html data-deletion/index.html; do
    # 기준은 그 커밋의 원본 HTML(D-09). front matter가 없으니 빌드 결과와 바이트가 같다.
    if [ "$MODE" = "--no-comments" ]; then
        a=$(python3 "$(dirname "$0")/norm_nocomment.py" "$WORK/base-src/$f"); b=$(python3 "$(dirname "$0")/norm_nocomment.py" "$WORK/cand-site/$f")
    else
        a=$(norm "$WORK/base-src/$f"); b=$(norm "$WORK/cand-site/$f")
    fi
    if [ "$a" = "$b" ]; then
        cmp -s "$WORK/base-src/$f" "$WORK/cand-site/$f" && s='바이트 동일' || s='정규화 동일'
        echo "OK   $f ($s)"
    else
        echo "DIFF $f"; diff <(printf '%s\n' "$a") <(printf '%s\n' "$b") | head -n 20; status=1
    fi
done
if diff "$WORK/base-files.txt" "$WORK/cand-files.txt"; then echo "OK   _site 파일 목록 동일 ($(wc -l < "$WORK/cand-files.txt" | tr -d ' ')개)"; else echo "DIFF _site 파일 목록"; status=1; fi
echo "기준 $(git -C "$REPO" rev-parse --short=12 "$BASE") / 후보 $(git -C "$REPO" rev-parse --short=12 "$CAND")"
exit $status
```

D-06 주석 수정 커밋용 정규화 `norm_nocomment.py`(같은 폴더, Python 3.9 표준 라이브러리):
```python
# D-06 확인용: HTML 주석과 CSS 블록 주석을 지운 뒤 D-07 정규화(줄 앞뒤 공백·빈 줄 제거)를 한다.
import re, sys
text = open(sys.argv[1], encoding="utf-8").read()
text = re.sub(r"<!--.*?-->", "", text, flags=re.S)
text = re.sub(r"/\*.*?\*/", "", text, flags=re.S)
for line in text.split("\n"):
    line = line.strip(" \t\r\f\v")  # str.strip()의 기본값은 유니코드 공백(NBSP 등)까지 지우므로 ASCII만 명시
    if line:
        print(line)
```

실험 결과 [VERIFIED: 로컬 실험 `repo2/`]:
- 기준(원본 HEAD 사본) 대 빌드 설정 커밋: 네 문서 「바이트 동일」, 파일 목록 11개 동일.
- 기준 대 전환 커밋: 네 문서 「바이트 동일」, 파일 목록 11개 동일.
- 실패 주입: 푸터 문장에 공백 하나 추가 → 네 문서 모두 `DIFF`(줄 안 공백을 차이로 셈, D-07 의도대로). 헤더 include 끝에 줄바꿈 추가 → 보고되지 않음(빈 줄 흡수). `exclude`에서 Gemfile 삭제 → `> ./Gemfile`, `> ./Gemfile.lock`, `DIFF _site 파일 목록`.
- 「공통」 주석 문구를 바꾼 빌드: D-07 diff는 문서마다 2줄, `norm_nocomment.py` 뒤에는 0줄.
- 기준 HEAD(`75adbb9`)의 `_site` 파일 목록 11개: `data-deletion/index.html`, `favicon/apple-touch-icon.png`, `favicon/favicon-96x96.png`, `favicon/favicon.ico`, `favicon/favicon.svg`, `favicon/site.webmanifest`, `favicon/web-app-manifest-192x192.png`, `favicon/web-app-manifest-512x512.png`, `index.html`, `privacy-policy/index.html`, `terms/index.html`. 실행할 때의 기준 커밋으로 다시 만들어야 합니다(D-09).

사용 순서(계획에 반영):
1. Phase 2 첫 커밋 전에 `BASE_SHA=$(git rev-parse HEAD)`를 기록합니다(D-09). 스크래치 폴더는 저장소 밖에 둡니다.
2. 빌드 설정 커밋 뒤: `compare.sh $BASE_SHA HEAD` → 「바이트 동일」, 파일 목록 동일(Gemfile 등이 새지 않음을 증명).
3. 법적 3종 전환 커밋 뒤: `compare.sh $BASE_SHA HEAD`.
4. 랜딩 전환 커밋 뒤: `compare.sh $BASE_SHA HEAD`.
5. 주석 수정 커밋 뒤: `compare.sh $BASE_SHA HEAD --no-comments`(그리고 `--no-comments` 없이 돌리면 「공통」 주석 줄만 다름을 확인).
6. 성공 기준 2(D-10): 작업 트리에서 include 하나에 `<!-- probe -->`를 임시로 붙이고 `jekyll build` → 네 문서 모두 직전 빌드와 `cmp` 다름 → `git checkout -- _includes/…`로 되돌림. include 4개 각각 4/4가 바뀌는 것을 스크래치에서 확인했습니다.

### 라이브 확인 (각 푸시 뒤, D-17)

```bash
SHA=$(git rev-parse HEAD)                       # 방금 푸시한 커밋
API=repos/SlimPumpkin/runningpencil.com/pages/builds/latest
# 1) 배포 워크플로 실행이 생길 때까지 찾은 뒤 끝날 때까지 기다린다
RUN=''
for i in 1 2 3 4 5 6 7 8 9 10 11 12; do
    RUN=$(gh run list --workflow pages-build-deployment -c "$SHA" --json databaseId --jq '.[0].databaseId // empty')
    [ -n "$RUN" ] && break; sleep 10
done
gh run watch "$RUN" --exit-status --compact     # 작업 build → report-build-status → deploy
# 2) Pages 빌드 기록 확인: commit == $SHA, status == "built", error == null
gh api "$API" --jq '{status, commit, created_at, updated_at, error: .error.message}'
CREATED=$(gh api "$API" --jq .created_at)
# 3) URL마다 한 번의 요청으로 헤더+본문을 받고, 그 응답이 새 배포일 때만(Last-Modified >= CREATED) 본문을 쓴다
fetch_fresh() {  # $1=URL $2=CREATED $3=저장 접두어 → $3.hdr, $3.body. 0=새 배포 200, 1=옛 캐시, 3=200 아님
    curl -s -D "$3.hdr" -o "$3.body" "$1" || return 2
    code=$(head -n 1 "$3.hdr" | awk '{print $2}')
    [ "$code" = "200" ] || { echo "HTTP $code"; return 3; }
    lm=$(tr -d '\r' < "$3.hdr" | grep -i '^last-modified:' | cut -d' ' -f2-)
    python3 -c 'import sys, email.utils as eu, datetime as dt
lm = eu.parsedate_to_datetime(sys.argv[1])
th = dt.datetime.strptime(sys.argv[2], "%Y-%m-%dT%H:%M:%SZ").replace(tzinfo=dt.timezone.utc)
sys.exit(0 if lm >= th else 1)' "$lm" "$2"
}
# 4) fetch_fresh가 0인 응답의 $3.body로: <title> 비교 + D-07 diff(4번째 푸시 뒤에는 norm_nocomment.py)
#    1이면 1~2분 뒤 다시(최대 약 10분), 5xx면 재시도
# 5) 404 목록: GET 응답의 age < (지금 - CREATED)초 일 때만 통과. 5xx는 재시도.
#    /CLAUDE.md /README.md /Gemfile /Gemfile.lock /_config.yml /.planning/ROADMAP.md /.claude/CLAUDE.md
#    /scripts/check-site.sh /.githooks/pre-push /_includes/footer.html /_layouts/legal.html /prepare/ /vendor/
# 6) /assets/css/style.css 는 푸시 전후 모두 200(운영 테마 파일, Pitfall 12)
```
- `gh run list -c <sha>`는 일치하는 실행만 돌려줍니다(없는 SHA → `0`). 워크플로 이름은 `pages-build-deployment`, 작업 이름은 `build`·`report-build-status`·`deploy`입니다. [VERIFIED: gh 실측]
- Pages 빌드 API 응답 필드는 `url, status, error{message}, pusher, commit, duration, created_at, updated_at`입니다. `status`의 enum은 문서에 없습니다 [CITED: docs.github.com/en/rest/pages/pages]. 관찰한 값은 `built` 하나뿐입니다. `building`·`errored` 같은 값은 [ASSUMED]입니다.
- `fetch_fresh`는 현재 라이브의 `/terms/`를 `created_at=2026-11-14T16:40:54Z` 기준으로 새 배포(rc=0)로 판정했고, 저장한 본문은 저장소 `terms/index.html`과 `cmp` 동일이었습니다. 미래 시각 기준으로는 rc=1이었습니다. [VERIFIED: 로컬 실행]
- `vendor/`·`prepare/`는 gitignore 대상이라 원격에 없으므로, 라이브 404는 당연히 나옵니다. 의미 있는 확인은 로컬 check-site 2번입니다. 검증 문서에 그렇게 적습니다.
- **도구 환경 주의:** 실행 환경에 따라 전경(foreground) `sleep` 반복이 막힐 수 있습니다. 그 경우 대기는 `gh run watch`(내부 대기)에 맡기고, CDN 대기는 백그라운드 실행이나 몇 분 뒤 재확인으로 나눕니다.

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| `github-pages` gem으로 로컬 재현 | `jekyll = 3.10.0` 직접 고정 + 표준 라이브러리 gem | Ruby 4.0(로컬) | `github-pages 232`가 Ruby 4에 설치되지 않음(STACK 연구) |
| Jekyll 4의 `.jekyll-cache/` | Jekyll 3.10은 이 폴더를 만들지 않음 | — | 빌드 뒤 원본 폴더에 새 파일이 생기지 않았습니다(관찰). D-11대로 `.gitignore`에는 넣되 무해합니다 [VERIFIED: 로컬 실험 `ls -a`] |
| jekyll-default-layout `main` 브랜치(`html_pages` opt-in이 생김) | 운영은 v0.1.5 고정(마크다운만) | — | 저장소 `main`의 코드는 운영 동작의 근거가 아닙니다. v0.1.5 `should_set_layout?`는 `markdown?(document) && !layout_specified?(document)`입니다 [VERIFIED: v0.1.5 generator.rb:24-25, versions.json `"jekyll-default-layout": "0.1.5"`] |

**운영 기본 플러그인이 네 HTML에 미치는 영향 (고정 버전 소스 기준):** `jekyll-optional-front-matter` 0.3.2, `jekyll-readme-index` 0.3.0, `jekyll-titles-from-headings` 0.5.3, `jekyll-relative-links` 0.6.1, `jekyll-default-layout` 0.1.5는 모두 마크다운 문서나 마크다운 정적 파일만 대상으로 합니다. `site.static_files`도 이미 `exclude`를 거친 목록입니다. readme-index는 `README`가 있는 폴더에 index가 없을 때만 동작합니다(루트에는 `index.html`이 있고 `README.md`는 제외됨). 그래서 `.html` 네 문서의 출력은 바뀌지 않습니다. [VERIFIED: 각 플러그인 태그 소스의 generator.rb] 남는 차이(`jekyll-github-metadata`의 `site.github`, Ruby 3.3.4 대 4.0.9, kramdown 2.4.0 대 2.5.2)는 이 템플릿이 쓰지 않는 부분입니다. 확정은 D-17 라이브 비교가 합니다. [ASSUMED → 라이브 비교로 확인]

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | GitHub Pages 배포가 Fastly 캐시를 즉시 지우는지는 모름. 지우지 않는다고 보고 최대 10분을 기다림 | Pitfall 1·2 | 지운다면 기다림이 불필요할 뿐 결과는 같음 |
| A2 | 새 배포 파일의 `Last-Modified`가 빌드 `created_at` 이후가 된다 (`Last-Modified == updated_at`을 한 번만 관찰) | Pitfall 1, 라이브 확인 | 성립하지 않으면 판정이 계속 옛 캐시로 나옴 → ETag 앞부분(배포 시각 hex)이 바뀌었는지로 판정을 바꿈 |
| A7 | 404 응답의 CDN 캐시 수명 (`cache-control` 없음, `age: 694` 관찰) | Pitfall 2 | `age` 비교 규칙을 쓰므로 수명을 몰라도 판정은 안전. 오래 캐시되면 기다림만 길어짐 |
| A3 | Pages 빌드 `status` 값 `building`·`errored` 등 (관찰한 것은 `built`뿐) | 라이브 확인 | 판정은 `gh run watch --exit-status`가 하므로 영향 작음 |
| A4 | 운영 빌드(Ruby 3.3.4, github-pages 232, primer 테마, github-metadata)가 네 HTML을 로컬과 같게 만든다 | State of the Art | 다르면 라이브 diff가 0이 아님 → D-18대로 revert. 첫 시험은 푸시 ②(법적 3종) |
| A5 | `ghcr.io/actions/jekyll-build-pages:v1.0.13` 이미지를 로컬 Docker로 돌려 운영 빌드를 재현할 수 있다 (입력 계약 미확인) | Alternatives | 선택 사항이라 계획에 영향 없음 |
| A6 | GUI git 클라이언트의 PATH가 `/usr/bin:/bin:…` 꼴이다 (일반 지식, 짧은 PATH 시뮬레이션만 함) | Pitfall 7 | 훅의 PATH 보강이 무해하므로 영향 작음 |

## Open Questions

1. **첫 푸시에 Phase 1 커밋 105개가 함께 나가는 것을 승인할지**
   - What we know: `origin/main = c4cb26d`, 로컬 105커밋 앞섬. `.planning` 밖 변경은 `.claude/CLAUDE.md`, `.gitignore`, `CLAUDE.md`, `_config.yml`이고, 모두 출력되지 않는 파일입니다(점 폴더이거나 exclude 대상).
   - What's unclear: 사용자가 Phase 1 산출물을 따로 먼저 푸시하고 싶은지.
   - Recommendation: 푸시 ① checkpoint의 승인 문구에 이 사실을 넣습니다. 따로 원하면 Phase 2 시작 전에 Phase 1만 푸시하는 checkpoint를 하나 더 둡니다(출력 불변. 라이브 확인 절차는 같음).
2. **운영 primer 테마 파일 `/assets/css/style.css`를 그대로 둘지**
   - What we know: 지금도 라이브에 있고, 이 단계는 바꾸지 않습니다.
   - Recommendation: 이번에는 손대지 않고 검증 문서에 기록만 합니다. 없애려면 `theme: null`을 넣는 별도 결정이 필요합니다(라이브 파일이 하나 사라지는 변경).
3. **ROADMAP 성공 기준 1의 문구(예외 없는 「차이가 0」)** — CONTEXT D-06대로 사용자가 정합니다. 연구로 바뀌는 것은 없습니다.
4. **include 파일 끝 줄바꿈을 금지할지** — 권장은 「끝 줄바꿈 없음」(바이트 동일)입니다. 에디터가 다시 붙여도 D-07에서는 0입니다. 바이트 동일을 계속 지키고 싶으면 `.editorconfig`(`insert_final_newline = false`, `[_includes/**]`)를 둘 수 있지만, 새 파일이 늘어나고 `exclude`도 고쳐야 합니다(점 파일이라 실제로는 출력되지 않음). 이번에는 넣지 않는 것을 권장합니다.

## Environment Availability

| Dependency | Required By | Available | Version | Fallback |
|------------|------------|-----------|---------|----------|
| Ruby (Homebrew) | 로컬 빌드 | ✓ | 4.0.9 (`/opt/homebrew/bin/ruby`) | — |
| Bundler | gem 설치·실행 | ✓ | 4.0.23 | — |
| rubygems.org 접근 | `bundle install` | ✓ | — (스크래치 설치 성공) | — |
| 시스템 Ruby | (쓰면 안 됨) | ✓ (함정) | 2.6.10 / Bundler 1.17.2 (`/usr/bin`) | 훅 PATH 보강 |
| git | archive·훅 | ✓ | 2.56.1 (`--path-format=absolute`는 2.31+) | — |
| gh (인증됨) | 배포 대기 | ✓ | 2.104.0, 저장소 `SlimPumpkin/runningpencil.com` 공개, Pages `build_type: legacy`, `source: main /` | 웹 UI의 Actions 탭 |
| bash | 스크립트·훅 | ✓ | 3.2.57 (`/bin/bash`, Homebrew bash 없음) | — |
| python3 | 일회용 비교·날짜 비교 | ✓ | 3.9.6 | — |
| curl | 라이브 확인 | ✓ | 시스템 | — |
| Docker | (선택) 운영 이미지 재현 | 설치됨, 데몬 꺼짐 | 클라이언트 29.9.3 | 라이브 비교(D-17) |

**Missing dependencies with no fallback:** 없음.
**Missing dependencies with fallback:** Docker 데몬(선택 사항).

## Validation Architecture

이 저장소에는 테스트 프레임워크가 없습니다. 검증은 셸·CLI 명령으로 합니다. 「영구」는 저장소에 커밋되어 이후 단계에서도 도는 것, 「일회용」은 Phase 2에서 스크래치로 한 번 돌리고 결과만 검증 문서에 남기는 것입니다.

### Test Framework

| Property | Value |
|----------|-------|
| Framework | 없음. bash 스크립트 + `jekyll build` 종료 코드 + `diff`/`cmp`/`grep` + `curl`/`gh` |
| Config file | 없음 — Wave 0에서 `scripts/check-site.sh`, `.githooks/pre-push` 생성 |
| Quick run command | `scripts/check-site.sh` (작업 트리, 약 1~2초) |
| Full suite command | `scripts/check-site.sh HEAD && <스크래치>/compare.sh "$BASE_SHA" HEAD` |

### Phase Requirements → Test Map

| Req / SC | Behavior | Test Type | Automated Command | 위치·수명 |
|--------|----------|-----------|-------------------|-------------|
| SHELL-02 / SC1 | Jekyll 3.10.0 빌드 성공 | smoke | `bundle exec jekyll -v` = `jekyll 3.10.0`; `scripts/check-site.sh HEAD` 종료 코드 0 | 로컬·영구 |
| SHELL-01 / SC1 | 네 문서 D-07 diff 0 (전환 커밋 시점) | 비교 | `compare.sh "$BASE_SHA" <법적 전환 SHA>`, `compare.sh "$BASE_SHA" <랜딩 전환 SHA>` → 네 줄 `OK` | 로컬·일회용 |
| SHELL-01·03 / SC1 (D-08) | `_site` 파일 목록 불변 | 비교 | 같은 `compare.sh` 출력의 `OK _site 파일 목록 동일 (11개)` | 로컬·일회용 |
| SHELL-01 / SC1 (D-06) | 최종 상태는 주석 제거 뒤 diff 0 | 비교 | `compare.sh "$BASE_SHA" HEAD --no-comments` | 로컬·일회용 |
| SHELL-01 / SC2 | 공통 블록이 한 벌만 있음 | grep | `git grep -lF '<footer class="rp-foot">' -- '*.html'` → `_includes/footer.html`만; `git grep -lF 'rel="manifest"' -- '*.html'` → `_includes/head-links.html`만; `git grep -lF '<header class="rp-head">' -- '*.html'` → `_includes/header.html`만; `git grep -lF '/* ── 공통' -- '*.html' '*.css'` → `_includes/css/common.css`만 | 로컬·일회용(검증 때) |
| SHELL-01 / SC2 | include 하나를 바꾸면 네 문서가 모두 바뀜 | 임시 시험 | include마다 `<!-- probe -->` 추가 → `jekyll build -d <tmp>` → 직전 빌드와 `cmp`로 4/4 다름 → `git checkout -- _includes/` | 로컬·일회용(D-10) |
| SHELL-02 / SC3 | 안내 명령 교체 | grep | `grep -n 'python3 -m http.server' CLAUDE.md .claude/CLAUDE.md README.md .planning/codebase/*.md` → 0건; `grep -c 'bundle exec jekyll serve --livereload' CLAUDE.md` ≥ 1; `grep -c 'core.hooksPath' CLAUDE.md` ≥ 1; `grep -c 'raw' CLAUDE.md` ≥ 1 | 로컬·일회용 |
| SHELL-02 / SC3 | 훅이 실제로 켜짐 | 설정 | `git config core.hooksPath` = `.githooks`; `git ls-files -s .githooks/pre-push scripts/check-site.sh` → `100755` 두 줄 | 로컬·일회용 |
| SHELL-02 | 점검 스크립트가 실패를 잡음 | 실패 주입 | 스크래치 사본에서 4종 주입(Code Examples 표)으로 각각 rc≠0 | 로컬·일회용 (선택: 실행 단계에서 한 번 재현) |
| SHELL-02 | bash 3.2 안전 | 정적 | `/bin/bash -n scripts/check-site.sh .githooks/pre-push`; `LC_ALL=C grep -nE '\$[A-Za-z_][A-Za-z_0-9]*[^ -~]' scripts/check-site.sh .githooks/pre-push` → 0건 | 로컬·일회용 |
| SHELL-03 / SC4 | `_site`에 내부 파일 없음 | 자동 | `scripts/check-site.sh <sha>`의 2번 항목 (pre-push 훅) | 로컬·영구 |
| SHELL-03 / SC4 | 라이브 내부 파일 404 | 라이브 | `curl -s -o /dev/null -w '%{http_code}' https://runningpencil.com/<경로>` = 404, 그리고 그 응답의 `age` < (지금 − `created_at`)초 (5xx는 재시도). 목록은 Code Examples 「라이브 확인」 5) | 라이브·푸시마다 |
| SC4 / Ground Rule | 네 URL 200, 제목 불변 | 라이브 | `gh run watch --exit-status` → `fresh` → `curl -s URL` 본문의 `<title>`이 check-site 기대값과 같음 | 라이브·푸시마다 |
| SC4 (D-17) | 라이브 HTML D-07 diff 0 | 라이브 | fresh 확인 뒤 `diff <(norm 라이브본문) <(norm 기준원본)`; 푸시 ④ 뒤에는 `norm_nocomment.py` | 라이브·푸시마다 (Phase 2) |

### Sampling Rate
- **커밋마다:** `scripts/check-site.sh` (작업 트리)
- **전환 커밋마다:** `compare.sh "$BASE_SHA" HEAD`
- **푸시마다:** pre-push 훅(자동) → checkpoint:decision → 푸시 → 라이브 확인 3종
- **Phase gate:** 네 푸시의 라이브 확인이 모두 통과하고, 최종 `compare.sh … --no-comments`가 0이어야 `/gsd-verify-work`로 갑니다.

### Wave 0 Gaps
- [ ] `Gemfile`, `Gemfile.lock`, `bundle config set --local path vendor/bundle`, `bundle install`
- [ ] `scripts/check-site.sh` (100755), `.githooks/pre-push` (100755), `git config core.hooksPath .githooks`
- [ ] 스크래치(저장소 밖)에 `compare.sh`, `norm_nocomment.py` 생성, `BASE_SHA` 기록
- [ ] `_config.yml`의 `url`과 `exclude`, `.gitignore` 4줄
- [ ] **worktree 주의(`use_worktrees: true`):** `bundle install`(→ `vendor/bundle`, `.bundle/config`)은 **메인 체크아웃**에서 합니다. `check-site.sh`는 `.bundle/config`가 없는 worktree에서 메인 체크아웃의 Gemfile로 넘어가지만, `compare.sh`에는 그런 대체 경로가 없습니다(`$REPO/Gemfile` 고정). 그래서 `compare.sh`·라이브 확인·푸시는 메인 체크아웃에서 돌립니다

## Security Domain

`security_enforcement: true`, ASVS 레벨 1. 정적 사이트라 인증·세션·입력 처리가 없습니다. 이 단계의 보안 쟁점은 **정보 노출**(내부 파일 공개)과 **공급망**(로컬 gem)입니다.

### Applicable ASVS Categories

| ASVS Category | Applies | Standard Control |
|---------------|---------|-----------------|
| V2 Authentication | no | — |
| V3 Session Management | no | — |
| V4 Access Control | no (공개 사이트) | — |
| V5 Input Validation | no (폼·서버 처리 없음. front matter 값은 운영자가 씀) | front matter 값에 `"`가 없는지 육안 확인 (HTML 속성 깨짐 방지) |
| V6 Cryptography | no | — |
| V14 Configuration (정보 노출, 빌드 구성) | **yes** | `_config.yml` `exclude` + Jekyll 점·밑줄 규칙 + `check-site.sh` 2번 + 라이브 404 확인 |
| V10/V14 공급망 (의존성) | yes (로컬만) | `Gemfile.lock` 커밋(Bundler 4의 `CHECKSUMS` sha256 포함). 운영은 GitHub의 고정 gem 세트라 이 lock의 영향을 받지 않음 |

### Known Threat Patterns for 이 스택

| Pattern | STRIDE | Standard Mitigation |
|---------|--------|---------------------|
| 사용자 `exclude`가 기본 목록을 덮어써 Gemfile·vendor·스크립트 공개 | Information Disclosure | Pattern 5 목록 + check-site 2번(실패 주입으로 확인) + 라이브 404 |
| front matter 누락으로 `{% include %}` 원문 공개 | Information Disclosure (구조 노출, 깨진 화면) | check-site 4번(실패 주입으로 확인) |
| 캐시된 404로 노출을 놓침 | Repudiation/검증 실패 | Pitfall 2 (404 응답의 `age`가 배포 뒤 경과 시간보다 작을 때만 통과) |
| `--no-verify` 남용 | Tampering(절차 우회) | 계획의 checkpoint:decision에서 로컬 검증 결과를 보여 줌(D-16) |
| 훅이 저장소의 스크립트를 실행 | Elevation (낮음, 자기 저장소) | `core.hooksPath`는 사용자가 직접 켬. 외부 PR을 받지 않는 저장소 |
| `rm -rf "$VAR"` 사고 | Tampering/가용성 | `"${VAR:?}"` 가드 (Pitfall 11) |
| `.nojekyll` 추가 시 exclude 무력화 | Information Disclosure | Ground Rule로 금지. 로컬 Jekyll은 `.nojekyll`을 신경 쓰지 않고 평소처럼 빌드하므로, check-site의 기존 4개 항목은 이것을 잡지 못합니다(운영만 Jekyll을 건너뛰어 `{% include %}` 원문과 `CLAUDE.md`가 공개됨) [ASSUMED: GitHub Pages의 `.nojekyll` 동작은 이번 세션에 문서로 확인하지 않음]. 계획 검증에 `test ! -e .nojekyll`을 넣고, check-site 2번에 `[ ! -e "$SRC/.nojekyll" ]` 한 줄을 더하는 것을 권장합니다 |

## Sources

### Primary (HIGH confidence)
- 로컬 실험 (2026-11-15, Ruby 4.0.9 / Bundler 4.0.23 / Jekyll 3.10.0 / Liquid 4.0.4, 저장소 밖 스크래치): 공백 미세 실험, 실제 HTML 4개 전환·빌드·`cmp`(일반·`--safe`), 파일 목록 비교, include 4개 프로브, falsy 분기, `layout: none`, 오류 종료 코드, `{% raw %}` 출력, `BUNDLE_GEMFILE` 상대 경로, 점검 스크립트·훅의 성공·실패·PATH·worktree 시험, 기준 비교 스크립트 성공·실패 시험, 심볼릭 링크 `$TMPDIR` 재현
- Jekyll 3.10.0 gem 소스: `lib/jekyll/configuration.rb:20-25`, `lib/jekyll/entry_filter.rb:6-124`, `lib/jekyll/convertible.rb:251-252`, `lib/jekyll/renderer.rb:147-180`, `lib/jekyll/commands/serve/servlet.rb`, `lib/jekyll/commands/serve.rb:90-91`
- github/pages-gem v232 `lib/github-pages/configuration.rb`(DEFAULTS `theme`, `exclude_cname`, OVERRIDES `safe`), `lib/github-pages/plugins.rb`(DEFAULT_PLUGINS)
- 고정 버전 플러그인 소스: jekyll-default-layout v0.1.5, jekyll-optional-front-matter v0.3.2, jekyll-readme-index v0.3.0, jekyll-titles-from-headings v0.5.3, jekyll-relative-links v0.6.1
- https://pages.github.com/versions.json (jekyll 3.10.0, liquid 4.0.4, ruby 3.3.4, github-pages 232, jekyll-theme-primer 0.6.0, kramdown 2.4.0)
- actions/jekyll-build-pages `action.yml`(`docker://ghcr.io/actions/jekyll-build-pages:v1.0.13`), `Gemfile`(`github-pages = 232`)
- pages-themes/primer v0.6.0 트리 (`_layouts/default|home|page|post.html`, `_includes/head-custom*.html`, `assets/css/style.scss`)
- `gh api` 실측: `repos/SlimPumpkin/runningpencil.com`(public), `/pages`(legacy, main /), `/pages/builds/latest`, `gh run list/view` (읽기 전용)
- curl 실측: 라이브 상태 코드, `cache-control`, `age`, `x-cache`, `last-modified`, ETag, 쿼리 문자열 무시, 일시 503
- git 매뉴얼(로컬): githooks(5) pre-push, git-config(1) core.hooksPath
- rubygems.org API (gem 연혁·다운로드·소스)

### Secondary (MEDIUM confidence)
- `.planning/research/STACK.md`, `PITFALLS.md` — 이전 연구(이번에 재확인한 부분은 위 Primary로 승격)

### Tertiary (LOW confidence)
- https://docs.github.com/en/rest/pages/pages — Pages 빌드 응답 필드(status enum 미기재). 공식 문서이지만 WebFetch 요약을 거쳤고 `classify-confidence --provider webfetch`가 LOW를 돌려줌. 필드 이름은 `gh api` 실측으로 따로 확인함
- 배포 시 CDN purge 여부, GUI 클라이언트 PATH 형태 — 일반 지식 (Assumptions Log A1, A6)

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH — 스크래치 설치와 lock으로 확인. 운영 버전은 versions.json
- Architecture (레이아웃·include·공백): HIGH — 실제 HTML 4개로 바이트 동일 실측
- 점검 스크립트·훅: HIGH — 성공·실패 4종·환경 변형까지 실측
- 운영 동등성: MEDIUM — 고정 버전 소스 분석. 확정은 라이브 비교(D-17)
- 라이브 확인 절차: MEDIUM-HIGH — 캐시 동작(쿼리 무시, 404 캐시)은 실측. `Last-Modified`=`updated_at`은 1회 관찰이라 기준을 `created_at`으로 둠

**Research date:** 2026-11-15
**Valid until:** 2026-12-15 (GitHub Pages 버전 표나 `actions/jekyll-build-pages` 이미지가 바뀌면 다시 확인)
