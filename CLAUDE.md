# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 이번 마일스톤 방침 (2026-11 결정)

이번 마일스톤(티저 유지 + 심사 대응)에서 정한 방침입니다. 표의 방침은 「적용 단계」가 오기 전에는 사이트 코드에 반영하지 않습니다. 이 구간 아래의 설명은 지금 코드의 실제 모습입니다. 이 구간은 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`에 같은 내용으로 둡니다.

| 방침 | 적용 단계 | 현재 상태 (2026-11 기준) | 이유 | 출처 |
|---|---|---|---|---|
| 영문 서비스명 RunningPencil | Phase 9 영문판(`/en/`), 콘솔·스토어의 영어 표시명 | 결정됨. 현재 사이트 본문에는 한국어 이름만 있습니다 | 영문판과 콘솔·스토어에서 같은 이름을 써야 합니다. 이전 방침을 뒤집음 | `.planning/baseline/NAMES.md`, `.planning/PROJECT.md` Key Decisions |
| 지원 이메일 공개 | Phase 5 이메일 게이트(외부 4곳 수신 시험 통과) 뒤. 푸터, `/support/`, 법적 문서 | 결정됨. 주소의 정본은 이름 표(`.planning/baseline/NAMES.md`)입니다. 사이트(HTML·`_data`)에는 아직 없고 `.planning/` 문서에만 있습니다. 저장소가 공개라 `.planning/` 문서의 주소는 GitHub에서 누구나 볼 수 있습니다 | Google Play 웹 삭제 요청, App Store Support URL, 처리방침의 보호책임자 연락처에 연락 수단이 필요합니다. 이전 방침을 뒤집음 | `.planning/PROJECT.md` Key Decisions, `.planning/baseline/USER-TASKS.md` |
| 사업자 정보 표시 (상호·대표자·사업자등록번호·주소) | Phase 5 (푸터와 `_data` 슬롯), Phase 8·9 | 결정됨. 값은 사용자가 주기 전이라 어디에도 없습니다. 값이 없는 항목은 행을 숨깁니다 (render-if-present) | 카카오 비즈앱 심사가 사업자와 서비스의 관계를 확인합니다 | `.planning/PROJECT.md` Key Decisions, `.planning/baseline/NAMES.md` |
| 한국어 + 영어 제공 | Phase 9 (`/en/` 아래 영문판) | 결정됨. 현재 페이지는 모두 한국어(`lang="ko"`)입니다 | Google·Facebook·Apple·LINE 심사자가 읽을 수 있어야 합니다. 이전 방침을 뒤집음 | `.planning/PROJECT.md` Key Decisions, `.planning/baseline/URLS.md` |
| Jekyll 빌드 전환 | Phase 2 (공유 셸 `_layouts`·`_includes`), Phase 3 (Tailwind CDN을 정적 CSS로) | Phase 3까지 적용됨. 공통 블록(head 링크·「공통」 CSS·헤더·푸터)은 `_includes`와 `_layouts/legal.html`에 한 벌만 있고, 법적 페이지는 외부 스크립트 없이 정적 CSS(`_includes/css/legal.css`)로 그립니다. 로컬은 운영과 같은 Jekyll 3.10.0(`Gemfile`)으로 빌드합니다 | 페이지가 늘수록 복사한 공통 블록이 어긋날 위험이 커집니다. 이전 방침을 뒤집음 | `.planning/PROJECT.md` Key Decisions, `.planning/ROADMAP.md` Phase 2·3 |
| 포인트·굿즈·코스북 제거 | Phase 4 (랜딩), Phase 6·7·8 (법적 문서) | 결정됨 (U10). 랜딩은 Phase 4에서 제거됨, 법적 문서 본문에는 남아 있음 | 출시 시점 앱에 없는 기능입니다. 심사는 사이트와 앱이 일치하는지 봅니다 | `.planning/PROJECT.md` Key Decisions |
| 법적 페이지 `noindex` 해제와 「임시 게시본」 문구 삭제 | Phase 6 (삭제 안내), Phase 7 (처리방침), Phase 8 (이용약관). 각 문서를 다시 쓰는 커밋에서 | 결정됨 (U14). 현재 세 문서에 `noindex`와 「임시 게시본」 표시가 있습니다 | 미완성 사이트로 보이면 심사에서 반려될 수 있습니다 | `.planning/PROJECT.md` Key Decisions, `.planning/ROADMAP.md` Phase 6·7·8 Notes |

### 작업 규칙

모든 단계에 적용하는 규칙입니다. GSD 밖에서 연 세션과 다른 도구도 지킵니다.

- `main` 푸시가 곧 배포입니다 (CI 없음). 모든 단계는 그대로 라이브에 올라가도 되는 상태로 끝냅니다.
- 기존 URL `/privacy-policy/`, `/terms/`, `/data-deletion/`은 경로를 바꾸지 않고 리디렉션도 걸지 않습니다. 배포할 때마다 세 URL이 200과 같은 문서 제목을 돌려주는지 확인합니다.
- 리팩터, 시각 변경, 내용 변경을 한 단계나 한 커밋에 섞지 않습니다.
- Phase 2 이후에는 푸시 전에 로컬 Jekyll 3.10.0 빌드가 성공하는지 확인합니다.
- 사용자가 줄 사실값(사업자 정보, 지원 이메일, 보호책임자)은 추측해서 채우지 않습니다. 값이 없으면 행·문단을 숨깁니다 (render-if-present). 단, 빠지면 안 되는 조항이 있는 페이지는 값이 올 때까지 커밋을 보류합니다 (예: 처리방침의 보호책임자, 위치기반서비스 이용약관의 사업자 상호·주소·연락처).
- 「추후 기재」 같은 자리표시 값을 쓰지 않습니다.
- JS 언어 자동 리디렉션, `robots.txt` 차단, `.nojekyll`, Jekyll i18n 플러그인을 쓰지 않습니다.
- 방침이나 구조를 바꾸는 단계는 그 단계 안에서 `CLAUDE.md`도 함께 고칩니다. 이 방침 구간은 루트 `CLAUDE.md`와 `.claude/CLAUDE.md` 두 사본을 같은 커밋에서 똑같이 고칩니다. `.claude/CLAUDE.md`의 GSD 생성 구간 가운데 `project`·`stack`·`conventions`·`architecture` 구간은 직접 고치지 않고, 원본(`.planning/PROJECT.md`, `.planning/codebase/STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md`)을 고친 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 다시 만듭니다. `skills`·`workflow`·`profile` 구간은 도구가 관리하므로 고치지 않습니다.
- 법적 본문에는 데이터 목록(`.planning/baseline/DATA-INVENTORY.md`)에 있는 사실만 씁니다. 이 규칙의 출처는 `.planning/ROADMAP.md`의 Phase 6·7 성공 기준과 `.planning/PROJECT.md`의 Constraints(Legal drafts)입니다.

마지막 규칙(데이터 목록)을 뺀 나머지 규칙의 원본은 `.planning/ROADMAP.md`의 Ground Rules입니다. 기준 문서는 `.planning/baseline/`에 있습니다 (이름 표 `NAMES.md`, URL 대장 `URLS.md`, 데이터 목록 `DATA-INVENTORY.md`, 결정 목록 `DECISIONS.md`, 사용자 작업 절차서 `USER-TASKS.md`).

## Repository purpose

`runningpencil.com` 도메인으로 서비스되는 GitHub Pages 정적 사이트입니다. 모바일 앱 러닝펜슬(지도 위 GPS 아트 코스를 걷거나 달려 완주하면 코스 모양 뱃지를 모으고, 직접 그린 코스를 공개할 수 있는 앱)의 출시 전 티저 랜딩과 앱 스토어 심사용 법적 페이지로 구성되어 있습니다.

- 빌드는 GitHub Pages 내장 Jekyll(운영 3.10.0)이 배포할 때 `_layouts`·`_includes`로 페이지를 조립하는 것입니다. 로컬도 `Gemfile`로 Jekyll 3.10.0을 고정합니다 (Homebrew Ruby 4.x, gem은 저장소 안 `vendor/bundle`). `package.json`·번들러·린터·테스트는 없고, 푸시 전 점검은 `scripts/check-site.sh`입니다.
- front matter가 없는 파일은 Jekyll이 그대로 복사하고, front matter가 있는 파일(지금 네 페이지 모두)은 Liquid를 거쳐 나갑니다.
- `_config.yml`은 Jekyll 설정입니다. 사이트 정식 주소 `url`과 사이트에 올리지 않을 파일 목록 `exclude`를 둡니다. 사용자 `exclude`가 Jekyll 기본 제외 목록을 덮어쓰므로, 사이트에 올리지 않을 파일은 모두 적어야 합니다 (마크다운 문서, `Gemfile`·`Gemfile.lock`, `vendor/`, `prepare/`, `scripts/`, `.githooks/`). 점(`.`)이나 밑줄(`_`)로 시작하는 항목은 원래 출력되지 않습니다. 마크다운 문서나 새 루트 파일·폴더를 추가하면 `exclude`도 확인합니다.
- `CNAME` 파일이 GitHub Pages의 사용자 지정 도메인(`runningpencil.com`) 매핑을 담당합니다 — 도메인 변경 시 이 파일을 수정해야 합니다.
- 이 저장소는 GitHub 조직 `SlimPumpkin` 아래의 **프로젝트 사이트**입니다 (조직 사이트 슬롯은 `slimpumpkin.github.io`가 이미 사용). 커스텀 도메인이 연결되지 않으면 `slimpumpkin.github.io/<repo>/` 하위 경로로 서빙되므로, 모든 절대 경로(`/favicon/...`, `/terms/`)는 커스텀 도메인 연결을 전제로 합니다.

## Pages

| 경로 | 용도 |
|---|---|
| `index.html` | 티저 랜딩 — 헤더, 히어로(쿼터뷰 지도 그림), 세 가지 이유(`#story`), 달려 보기(`#demo`), 출시 안내(`#get`), 푸터 |
| `privacy-policy/index.html` | 개인정보처리방침 (현재 임시 게시본·`noindex`, 2026-11 기준. Phase 7 재작성 커밋에서 둘 다 지움, U14) |
| `terms/index.html` | 서비스 이용약관 (현재 임시 게시본·`noindex`, 2026-11 기준. Phase 8 재작성 커밋에서 둘 다 지움, U14) |
| `data-deletion/index.html` | 계정·데이터 삭제 안내 (앱 스토어 심사용. 현재 임시 게시본·`noindex`, 2026-11 기준. Phase 6 재작성 커밋에서 둘 다 지움, U14) |

네 페이지가 함께 쓰는 공통 블록 네 가지는 각각 한 파일에 한 벌씩 있습니다. 공통 블록을 바꿀 때는 그 파일 한 곳만 고칩니다.

- `_includes/head-links.html` — `<head>`의 글꼴 링크와 파비콘·매니페스트 링크
- `_includes/css/common.css` — `<style>` 맨 위의 「공통」 묶음 (바탕색, 글꼴, `.rp-wrap`, 헤더 `.rp-head`·`.rp-brand`·`.rp-nav`, 푸터 `.rp-foot-*` 스타일)
- `_includes/header.html` — 헤더 마크업. `home=true`를 주면 랜딩 링크(`#top`·`#story`·`#demo`·`#get`)를, 없으면 법적 페이지 링크(`/`·`/#story`·`/#demo`·`/#get`)를 냅니다
- `_includes/footer.html` — 푸터 마크업

랜딩(`index.html`)은 레이아웃 없이(`layout: none`) 이 include 네 곳을 직접 씁니다. 헤더는 `{% include header.html home=true %}`로 부릅니다.

법적 페이지 3종은 `_layouts/legal.html` 하나가 전체(모눈종이 바탕 + 흰 카드)를 그립니다. 레이아웃의 `<style>` 안에는 「공통」(`_includes/css/common.css`) 다음에 「법적 페이지 전용」(`_includes/css/legal.css`)이 include로 들어옵니다. 페이지 파일에는 front matter와 카드 본문(조항 `<section>`들과 끝 안내 `<footer>`)만 있습니다. front matter 키는 `layout`, `title`, `description`, `eyebrow`, `heading`(h1이 `title`과 다를 때만), `updated`, `noindex`입니다. `noindex`와 「임시 게시본」 끝 안내(`<footer>`)는 페이지마다 두고, 각 문서를 다시 쓰는 단계에서 지웁니다 (U14).

**법적 본문 작성 규칙** — 법적 문서(처리방침·약관·삭제 안내, 이후 지원 페이지와 영문판)의 본문을 쓸 때 지킵니다.

- 원본은 HTML입니다. Markdown(kramdown)으로 바꾸지 않습니다. kramdown은 곧은 따옴표를 굽은 따옴표로 바꾸고 제목에 자동 `id`를 붙입니다 (D-01).
- 조항마다 `<section>` 하나를 두고 첫 자식은 `<h2>`입니다. 간격은 CSS가 주므로 본문에 간격 클래스나 `style`을 쓰지 않습니다 (D-02).
- 문서 끝 안내는 `<footer>`, 조항 안 보충 설명(예: 표 아래 「※ …」)은 `<aside>`로 씁니다 (D-03).
- 본문에 쓸 수 있는 요소는 `section` `h2` `h3` `p` `ul` `ol` `li` `dl` `dt` `dd` `table` `thead` `tbody` `tr` `th` `td` `figure` `strong` `a` `aside` `footer`가 전부이고, 모두 클래스 없이 씁니다 (D-04).
- 표는 모두 `<figure tabindex="0" aria-label="표 이름">`으로 감쌉니다. 표가 본문 폭보다 넓으면 figure 안에서만 가로로 스크롤합니다. `<table>`에 `display: block`을 주지 않습니다 (D-07).
- 목록에 없는 요소가 필요하면 `_includes/css/legal.css`(규칙과 맨 위 주석), 이 규칙, 원본 맵 `.planning/codebase/CONVENTIONS.md`를 같은 단계에서 함께 고칩니다.
- 요소별 모양(링크·표·목록 번호·중첩 목록·`h3`·`dl`, D-05~D-12)은 `.planning/codebase/CONVENTIONS.md`의 「법적 본문 작성 규칙」 절에 있습니다.

- **raw 규칙**: front matter가 붙은 파일은 전체가 Liquid를 거칩니다. 인라인 JS·CSS에 이중 중괄호나 중괄호-퍼센트가 생기면 그 부분을 `{% raw %}`…`{% endraw %}`로 감쌉니다. `scripts/check-site.sh`의 4번 항목은 출력에 남은 이런 문자열을 잡으므로, raw로 일부러 내보내는 경우가 생기면 그 항목에 예외를 더합니다.
- **include 공백 규칙**: include 태그는 0열에 혼자 두고, include 파일은 원본 들여쓰기 그대로 끝 줄바꿈 없이 씁니다. `{%-`는 `if`/`endif`에만 씁니다.

## Local preview

운영과 같은 Jekyll 3.10.0으로 빌드해 미리 봅니다. 저장소 루트에서 실행합니다:

```bash
bundle config set --local path vendor/bundle   # 처음 한 번. gem을 저장소 안 vendor/bundle에 둔다 (.bundle/config에 기록)
bundle install                                 # Gemfile.lock대로 gem 설치
bundle exec jekyll serve --livereload          # 미리보기 → http://localhost:4000
git config core.hooksPath .githooks            # 클론마다 한 번. pre-push 훅을 켠다
scripts/check-site.sh                          # 푸시 전 점검. 커밋을 인자로 주면 그 커밋만 내보내 점검한다
```

- macOS 시스템 Ruby(2.6)가 아니라 Homebrew Ruby가 `PATH` 앞에 있어야 합니다 (`brew install ruby`).
- 미리보기 응답에는 livereload 스크립트가 끼므로 운영 출력과 바이트가 같지 않습니다. 운영과 같은 출력은 `scripts/check-site.sh`가 만듭니다.
- `/favicon/...`, `/terms/`, `/#story` 같은 절대 경로를 쓰므로 `file://`로 직접 열면 깨집니다. 글꼴은 CDN에서 받으므로 인터넷 연결도 필요합니다.

## Architecture / styling notes

- **랜딩(`index.html`)의 스타일**은 `<head>`의 `<style>` 한 블록(맨 위에 include로 들어오는 「공통」 묶음 + 「랜딩 전용」)과 각 요소의 인라인 `style`에 있습니다. 반응형 수치는 `clamp(28px, 4vw, 56px)`처럼 `vw`로 쓰고, 좁은 화면(860px 이하) 규칙은 `<style>` 끝의 `@media (max-width: 860px)` 블록에 모여 있습니다. 새 스타일은 「랜딩 전용」에 추가합니다.
- **법적 페이지 3종은 정적 CSS**로 그립니다 (2026-11 기준). CSS는 `_includes/css/legal.css` 한 곳에 있고, `_layouts/legal.html`의 `<style>` 안에서 「공통」 다음에 include로 인라인됩니다. 외부 `.css` 파일, 런타임 스크립트, 빌드 도구는 없습니다. Tailwind Play CDN은 Phase 3에서 제거했습니다. 법적 페이지에만 쓰는 새 스타일은 `_includes/css/legal.css`에 더합니다.
  - 토큰은 `:root`의 CSS 변수 다섯 개입니다 (법적 3종 공통): `--rp-ink #2B2B2B` 글자·제목 · `--rp-accent #7C580D` 작은 제목·링크 밑줄 · `--rp-muted #4A463F`, `--rp-muted-2 #57534C` 보조 글자 · `--rp-line #E4E0D6` 카드 테두리·구분선. 이 색은 `var(--rp-…)`로만 씁니다.
  - Preflight 대체는 `html`(line-height 1.5, tab-size 4, `-webkit-tap-highlight-color: transparent`)과 `.rp-doc` 범위 규칙만 씁니다. 본문 요소(h2·p·ul·table 등) 규칙은 모두 `.rp-doc` 아래 선택자로 쓰고, 범위 없는 요소 선택자로 쓰지 않습니다 (헤더·푸터로 샙니다). 토큰과 초기화 규칙을 「공통」(`_includes/css/common.css`)에 넣지 않습니다 (랜딩 출력이 바뀝니다).
  - 카드 껍데기는 레이아웃이 그리는 `.rp-legal-*` 클래스(`.rp-legal-wrap`·`.rp-legal-card`·`.rp-legal-eyebrow`·`.rp-legal-title`·`.rp-legal-updated`)이고, 본문은 `<div class="rp-doc">` 안에 들어갑니다. `.rp-grid`(32px 모눈종이 바탕)도 `_includes/css/legal.css`에 있습니다.
  - 카드 안쪽 여백은 28px이고 768px 이상(`@media (min-width: 768px)`)에서 48px입니다. 랜딩의 860px(`max-width`) 규칙과는 별개입니다.
  - 헤더·푸터는 「공통」 묶음의 `.rp-*` 클래스로 그립니다.
- **색**: 연필 노랑 `#F2B134`(헤더·히어로·출시 안내 바탕, `theme-color`) · 흑연 `#2B2B2B`(글자, 푸터 바탕) · 바탕 `#FAFAF7` · 진한 금색 `#7C580D`(작은 제목) · 칠판 초록 `#2E4A3B`(달려 보기 구간) · 모눈종이 `#F5F9FC`에 선 `#D3E2EF`. 노랑은 밝은 바탕 위 글자색으로 쓰기에는 대비가 낮으니 글자·밑줄에는 `#7C580D`를 씁니다.
- **글꼴은 Pretendard**(가변 글꼴)입니다. jsDelivr CDN의 다이나믹 서브셋 CSS(`orioncactus/pretendard@v1.3.9`)를 네 페이지가 `_includes/head-links.html`의 같은 `<link>`로 불러옵니다.
- **랜딩의 동작**은 `</body>` 앞의 인라인 스크립트 하나로 돌아갑니다 (라이브러리 없음).
  - 세 가지 이유(`#story`): `<head>`의 짧은 스크립트가 첫 그리기 전에 `<html>`에 `rp-pin`을 붙이면 구간이 화면에 고정되고(높이 340vh, `position: sticky`) 스크롤에 따라 1·2·3단계가 넘어갑니다. 움직임 줄이기 설정이거나 창 높이가 2400px을 넘으면 `rp-pin`을 붙이지 않고 단계 버튼으로만 넘깁니다. 진행도는 `#story`의 CSS 변수 `--q0`·`--q1`·`--q2`(0~1)로 그림에 전달됩니다.
  - 달려 보기(`#demo`): 버튼을 누르면 7초 동안 댕댕런 코스 선을 따라 달리고, 끝나면 뱃지를 보여 줍니다.
  - 다 열린 뒤에 `<html>`에 `rp-ready`가 붙으면서 페이지 안 이동이 부드러워집니다. `/#demo`처럼 구간이 붙은 주소로 처음 열 때는 바로 그 자리에 서야 해서 그 뒤부터 켭니다.
  - 스크립트는 `id`(`story`, `rp-panel`, `rp-run-*`, `rp-demo-*`, `rp-hero-art`, `rp-sketch`, `rp-c-dog`)와 `data-step`·`data-go` 속성으로 요소를 찾고, 상태는 클래스(`is-on`, `is-s0`~`is-s2`)로 바꿉니다. 이름을 바꾸면 스크립트도 함께 고쳐야 합니다.
- **디자인 원본**은 Claude 디자인 캔버스 「러닝펜슬 랜딩 페이지」입니다 (저장소 밖). 캔버스는 컨테이너 쿼리 단위(`cqw`)로 쓰여 있고, `index.html`은 그 티저 상태를 `vw`와 미디어 쿼리로 옮긴 것입니다. 출시 후 구간(평점, 인기 코스, 명예의 전당, 리뷰, 스토어 뱃지·QR)은 캔버스에만 있고 사이트에는 넣지 않았습니다. 캔버스 메모대로 히어로의 쿼터뷰 지도 그림은 애니메이션으로 바꿀 자리에 둔 임시 그림입니다. `prepare/desgin/teaser html/`의 목업은 이전 디자인입니다.
- **다크 모드 없음.** 달려 보기 구간과 푸터만 의도적으로 어두운 바탕입니다.
- **로고·아이콘·지도 그림은 모두 인라인 SVG**입니다. 외부 이미지 의존이 없습니다. 랜딩에서 여러 번 쓰는 도형(코스 선, 지도, 아이콘, 히어로 캐릭터)은 `<body>` 맨 위의 숨은 `<svg><defs>`에 모아 두고 `<use href="#…">`로 씁니다. 헤더·푸터의 로고는 법적 페이지에 `<defs>`가 없으므로 `<use>` 없이 `_includes/header.html`·`_includes/footer.html` 안에 그대로 넣습니다.
- **푸터**에는 약관 링크 3개, 운영 안내 문장, 저작권, 경로 데이터 출처 표기가 있습니다. 「경로 데이터 © OpenStreetMap contributors」는 랜딩에 그린 댕댕런 코스 선이 OpenStreetMap 기반 경로 데이터에서 나온 것이라 넣었습니다. 웹페이지에 실제 지도를 쓰게 되면 그 지도의 출처 표기를 더합니다.
- **이메일 수집 폼 없음.** 정적 호스팅이라 서버 처리가 불가능해 의도적으로 뺐고, 앞으로도 만들지 않습니다. 현재 사이트에는 지원 이메일이 없습니다 (2026-11 기준). 이메일 게이트(Phase 5)가 열리면 지원 이메일을 푸터·지원 페이지·법적 문서에 넣습니다. 그전에는 주소를 HTML·`_data`에 넣지 않습니다.

## Assets

- `favicon/`: `favicon.svg`(둥근 노랑 타일 + 로고), `favicon.ico`(16/32/48), `favicon-96x96.png`(둥근 타일, 모서리 투명), `apple-touch-icon.png`(180, 전면 불투명), `web-app-manifest-192x192.png`·`512x512.png`(전면 불투명, `purpose: maskable`), `site.webmanifest`(`theme_color`·`background_color`는 `#F2B134`).
- 로고는 앱 아이콘과 같은 그림(핀 모양 연필)이고, 원본 SVG는 앱 저장소의 `docs/brand/icon-1024.svg`입니다. `apple-touch-icon`과 매니페스트 아이콘은 앱 아이콘(전면 노랑, 로고 높이 66%)을 그대로 줄인 것이고, `favicon.svg`·`favicon.ico`·`favicon-96x96.png`는 둥근 타일(512 기준 모서리 반경 116)에 로고를 높이 400으로 얹은 것입니다. 작게 보이는 `favicon.svg`·`favicon.ico`와 헤더·푸터의 로고는 깎은 면의 선 두 개를 뺀 작은 판입니다.
- 재생성 시에는 SVG를 목표 크기의 8배로 그린 뒤(`rsvg-convert` 등) 8×8 평균으로 줄이면 가장자리가 깔끔합니다.
- `prepare/`는 `.gitignore`로 제외된 로컬 전용 폴더입니다 (이전 디자인의 목업, 옛 아이콘 원본 등).

## Content language

현재 네 페이지는 본문이 한국어이고 `<html lang="ko">`입니다 (2026-11 기준). Phase 9에서 `/en/` 아래에 영문판(`lang="en"`)을 더해 한국어와 영어를 함께 제공합니다.

서비스(앱) 이름은 한국어 「러닝펜슬」, 영어 `RunningPencil`입니다. 정본은 이름 표(`.planning/baseline/NAMES.md`)입니다. 현재 사이트(제목·메타·매니페스트·워드마크·본문)에는 한국어 이름만 있고 (2026-11 기준), 영문 이름은 Phase 9 영문판(`/en/`)과 콘솔·스토어의 영어 표시명에 씁니다. 운영 회사 이름은 "슬림펌킨"이며, 저작권 표기, 푸터의 운영 안내 문장, 법적 페이지의 `(이하 "회사")` 주체에 씁니다. `runningpencil.com`은 도메인 표기입니다.

## Deploy

`main` 브랜치에 푸시하면 GitHub Pages가 자동 배포합니다. CI가 없으므로 `main` 푸시가 곧 배포입니다. `main`으로 푸시할 때 pre-push 훅(`.githooks/pre-push`)이 `scripts/check-site.sh <푸시할 커밋>`을 돌려 빌드 성공, 빌드 결과에 내부 파일이 없음, 기존 URL 문서 4개의 제목, 처리되지 않은 Liquid가 없음, 출력 HTML에 Tailwind Play CDN이 없음, 랜딩 출력에 포인트·굿즈·코스북이 없음을 확인합니다. 하나라도 실패하면 푸시가 멈춥니다. 훅은 `git config core.hooksPath .githooks`로 켜야 동작하고, 급하면 `git push --no-verify`로 건너뛸 수 있습니다.
