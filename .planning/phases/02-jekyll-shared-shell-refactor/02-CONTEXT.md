# Phase 2: Jekyll 공유 셸 도입 (Shared Shell Refactor) - Context

**Gathered:** 2026-11-15
**Status:** Ready for planning

<domain>
## Phase Boundary

head 링크·「공통」 CSS·헤더·푸터를 GitHub Pages 내장 Jekyll의 `_includes`/`_layouts`에 한 벌만 둡니다. 운영자가 그중 한 곳을 고치면 네 페이지(`/`, `/privacy-policy/`, `/terms/`, `/data-deletion/`)에 모두 반영됩니다. 로컬에서는 운영과 같은 Jekyll 3.10.0으로 빌드하고 미리 봅니다. 푸시 전에는 빌드 성공과 내부 파일 미공개를 확인합니다.

이 단계는 순수 리팩터입니다. 방문자가 받는 HTML은 바뀌지 않습니다(공백 정규화 diff 0). 다음은 이 단계에서 하지 않습니다.
- Tailwind 제거와 정적 CSS 전환 (Phase 3)
- 내용 변경: 포인트·굿즈 문구, `noindex`, 「임시 게시본」 (Phase 4·6·7·8)
- `_data`에 사업자 값 넣기 (Phase 5)
- 새 페이지(`/support/`, `/location-terms/`, `/en/…`) (Phase 5·8·9)

요구사항: SHELL-01, SHELL-02, SHELL-03.

</domain>

<decisions>
## Implementation Decisions

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
- **D-07:** 공백 정규화는 각 줄의 앞뒤 공백과 빈 줄만 지웁니다. 줄 안의 공백 차이는 차이로 셉니다. 인라인 요소 사이 공백처럼 화면에 보이는 차이를 놓치지 않기 위해서입니다.
- **D-08:** 비교 범위는 두 가지입니다.
  - 네 문서의 내용 diff
  - `_site/` 전체 파일 목록을 전환 전 목록과 비교. 새로 공개되는 파일과 사라지는 파일이 모두 0이어야 합니다. Gemfile, include 조각, 스크립트, `.githooks/` 같은 노출을 푸시 전에 잡기 위해서입니다.
- **D-09:** 비교 기준(baseline)은 Phase 2 실행을 시작할 때의 커밋입니다.
  - 그 커밋의 원본 HTML 4개를 기준으로 씁니다. 지금은 빌드 없이 그대로 서빙되므로 라이브와 같습니다.
  - 그 커밋을 로컬 Jekyll로 빌드한 `_site/` 파일 목록도 기준으로 씁니다.
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

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### 단계 범위와 규칙
- `.planning/ROADMAP.md` §Phase 2: 목표, 성공 기준 1~4, Notes(레이아웃 이름, `url`, `exclude`, Tailwind 이동, `{% raw %}`)
- `.planning/ROADMAP.md` §Ground Rules: `main` 푸시=배포, 기존 3 URL 고정, 커밋 분리, Phase 2 이후 푸시 전 Jekyll 빌드 확인
- `.planning/REQUIREMENTS.md`: SHELL-01, SHELL-02, SHELL-03
- `CLAUDE.md`(루트)와 `.claude/CLAUDE.md`: 「이번 마일스톤 방침」 표, 작업 규칙, Local preview 구간(교체 대상)
- `.planning/phases/01-ground-truth-policy-reset/01-CONTEXT.md` D-04: 「`CLAUDE.md`를 고친다」가 뜻하는 세 곳과 재생성 방법

### Jekyll 설계와 함정 (연구)
- `.planning/research/STACK.md` §(b) 공통 블록 단일화: 권장 파일 배치, 바이트 동일 출력 실험, 레이아웃 이름 주의
- `.planning/research/STACK.md`: 로컬 미리보기 레시피(Gemfile 예시, `exclude`·`.gitignore` 추가 항목, `url` 설정 이유)
- `.planning/research/STACK.md` §What NOT to Use, §Version Compatibility: Ruby 4와 `github-pages` gem 충돌, `exclude` 덮어쓰기로 Gemfile·vendor가 공개되는 현상
- `.planning/research/PITFALLS.md` Pitfall 11 (296~319행): front matter의 Liquid 처리, `python3 -m http.server` 미리보기 착시, `.nojekyll` 함정, 경고 신호(`{% include` 잔여)
- `.planning/research/PITFALLS.md` 101~116행: 기존 URL 경로 변경·리디렉션 위험
- `.planning/baseline/URLS.md`: URL 대장(기존 URL `/`, `/privacy-policy/`, `/terms/`, `/data-deletion/`)

### 고칠 문서 (D-12, D-19)
- `README.md`: `python3 -m http.server` 안내
- `.planning/codebase/STACK.md`, `CONVENTIONS.md`, `ARCHITECTURE.md`, `STRUCTURE.md`, `TESTING.md`, `CONCERNS.md`: 빌드 없음, 복사 공유, `http.server` 서술
- `_config.yml`: 현재 `exclude`와 그 이유를 적은 주석(CNAME 기본 제외 설명)

### 외부 문서
- https://pages.github.com/versions.json: 운영 Jekyll 3.10.0, Liquid 4.0.4, Ruby 3.3.4, 허용 플러그인
- https://jekyllrb.com/docs/layouts/, https://jekyllrb.com/docs/front-matter: 레이아웃 겹쳐 쓰기, `page` 변수
- https://jekyllrb.com/docs/troubleshooting/: `vendor/` exclude와 기본 제외 목록
- https://bundler.io/man/bundle-config.1.html: `--local path` 설정은 `.bundle/config`에 저장됨
- https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/about-jekyll-build-errors-for-github-pages-sites: 운영 빌드 오류 확인

</canonical_refs>

<code_context>
## Existing Code Insights

### 공유 블록 위치 (2026-11-15, HEAD `1c4be1a` 기준)
- **head 링크** (preconnect부터 manifest까지 8줄, 네 파일 동일): `index.html:18-25`, 법적 3종 `:13-20`
- **「공통」 CSS** (머리 주석 포함, 네 파일 동일): `index.html:31-58`, 법적 3종 `:37-64`. 바로 뒤에 랜딩은 `/* ── 랜딩 전용 ── */`(`index.html:60`), 법적 페이지는 `/* ── 법적 페이지 전용 ── … */`(`:66-69`)가 같은 `<style>` 안에 이어집니다.
- **헤더**: `index.html:184-197`, 법적 3종 `:74-87`. 다른 곳은 `rp-brand`의 `href`와 메뉴 링크 3개뿐입니다.
- **푸터** (네 파일 완전 동일): `index.html:470-493`, `privacy-policy/index.html:148-171`, `terms/index.html:174-197`, `data-deletion/index.html:125-148`
- **법적 `<head>`**: 세 파일의 1~90행은 `<title>`·`description` 두 줄 말고는 같습니다. Tailwind script는 `:12`, tailwind-config는 `:21-35`에 있습니다.
- **법적 카드 틀**: `<main class="rp-grid">`(`:89`)부터 `<div class="mt-10 space-y-8 leading-[1.7] text-muted">`(`:95`)까지와 닫는 태그들은 세 파일이 같습니다. 다른 것은 eyebrow·h1 텍스트와 「임시 게시본」 문단의 주어뿐입니다.
- **현재 값**:

  | 페이지 | `<title>` | h1 | eyebrow |
  |---|---|---|---|
  | 개인정보처리방침 | 「개인정보처리방침 - 러닝펜슬」 | 개인정보처리방침 | PRIVACY POLICY |
  | 이용약관 | 「서비스 이용약관 - 러닝펜슬」 | 서비스 이용약관 | TERMS OF SERVICE |
  | 데이터 삭제 안내 | 「데이터 삭제 안내 - 러닝펜슬」 | 사용자 데이터 삭제 안내 | DATA DELETION |

  updated는 세 문서 모두 「2026년 10월 31일」입니다.

### 제약 (계획에 그대로 반영)
- **`<head>` 태그 순서가 랜딩과 법적 페이지에서 다릅니다.** 그래서 head를 통째로 include 하나로 합칠 수 없습니다. 공통으로 이어진 구간은 preconnect부터 manifest까지뿐입니다.
  - 법적: charset → viewport → title → description → **robots** → theme-color → **Tailwind script** → [head 링크] → **tailwind-config** → `<style>`
  - 랜딩: charset → viewport → title → description → theme-color → **OG 5줄** → [head 링크] → **pre-paint script** → `<style>`
- `<body>` 태그도 다릅니다. 랜딩은 `<body id="top">`, 법적 페이지는 `<body>`입니다.
- front matter가 없는 HTML은 Jekyll이 그대로 복사합니다. 그래서 한 커밋에서 일부 페이지만 전환해도 나머지는 깨지지 않습니다.
- 운영은 Ruby 3.3.4와 GitHub Pages 기본 플러그인(`jekyll-default-layout`, `jekyll-optional-front-matter` 등)으로 빌드하고, 로컬은 Ruby 4.0.9입니다. 차이는 D-17의 라이브 비교로 잡습니다.
- `.claude/`, `.gsd/` 같은 점 폴더는 Jekyll이 기본으로 출력하지 않습니다. 다만 사용자 지정 `exclude`가 기본 목록을 덮어쓰는 동작이 점 파일 규칙에도 미치는지는 파일 목록 비교(D-08)로 확인합니다.

### Established Patterns
- 들여쓰기는 공백 4칸입니다. CSS는 규칙 하나를 한 줄에 쓰고, 주석은 한국어로 씁니다(`.planning/codebase/CONVENTIONS.md`). include 파일도 원본의 들여쓰기를 그대로 유지해야 정규화 diff가 0이 됩니다.
- 모든 내부 경로는 루트 기준 절대 경로입니다(`/favicon/…`, `/#story`). 커스텀 도메인을 전제로 하므로 `relative_url`로 바꾸지 않습니다(바꾸면 출력이 달라짐).

### Integration Points
- 새로 생기는 것: `Gemfile`, `Gemfile.lock`, `_layouts/legal.html`, `_includes/…`, 점검 스크립트, `.githooks/pre-push`
- 고치는 것: `_config.yml`, `.gitignore`, `index.html`, `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`, `README.md`, `CLAUDE.md`, `.claude/CLAUDE.md`(재생성), `.planning/codebase/*.md`

</code_context>

<specifics>
## Specific Ideas

- 논의에서 고른 법적 페이지 front matter 모양(삭제 안내 예):
  ```
  ---
  layout: legal
  title: 데이터 삭제 안내          # <title>용
  eyebrow: DATA DELETION
  heading: 사용자 데이터 삭제 안내  # h1 (없으면 title)
  updated: 2026년 10월 31일
  noindex: true
  ---
  <section> …본문… </section>
  …
  <p class="border-t …">본 안내는 임시 게시본이며 …</p>
  ```
- 푸시 순서: ① 빌드 설정 → ② 법적 3종 → ③ 랜딩 → ④ 주석·문서. 푸시마다 승인을 받고, 라이브를 확인한 뒤 다음으로 넘어갑니다.

</specifics>

<deferred>
## Deferred Ideas

None. 논의는 단계 범위 안에서 진행됐습니다. 다른 단계의 몫은 아래와 같습니다.
- `_data/company.yml`(사업자 값, 지원 이메일): Phase 5
- `_data/i18n.yml`, `lang`·`ref`로 짝 묶기, `hreflang`: Phase 9
- legal 레이아웃을 `/support/`·`/location-terms/`에 그대로 쓸지: Phase 5·8에서 정함. 이번 레이아웃은 `updated`를 생략할 수 있게만 만듭니다(D-02).
- Tailwind 제거와 정적 CSS: Phase 3

</deferred>

---

*Phase: 02-jekyll-shared-shell-refactor*
*Context gathered: 2026-11-15*
