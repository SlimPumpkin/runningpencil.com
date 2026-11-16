# Phase 3: 법적 페이지 정적 스타일 전환 (Tailwind CDN Removal) - Context

**Gathered:** 2026-11-16
**Status:** Ready for planning

<domain>
## Phase Boundary

법적 문서 3종(`/privacy-policy/`, `/terms/`, `/data-deletion/`)에서 Tailwind Play CDN(`<script src="https://cdn.tailwindcss.com">`)과 `<script id="tailwind-config">`를 걷어 냅니다. 대신 직접 쓴 정적 CSS로 전환 전과 **픽셀 단위로 같은** 모양을 냅니다. 본문은 클래스 없는 마크업으로 바꾸고, 이후 단계(Phase 6~9)가 텍스트만 쓰면 되도록 본문 작성 규칙과 새 요소(표·번호 목록·하위 제목·중첩 목록·정의 목록·주석)의 모양을 이 단계에서 정합니다.

- 요구사항: SHELL-04
- 문장은 하나도 바꾸지 않습니다(성공 기준 3). 「포인트·굿즈·코스북」 문장, 「임시 게시본」 문단, `noindex`는 그대로 둡니다. 이것들은 Phase 4·6·7·8의 몫입니다.
- 랜딩(`index.html`)의 출력은 바뀌지 않습니다.

</domain>

<decisions>
## Implementation Decisions

### 이전에 정해진 것 (다시 논의하지 않음)
출처: `.planning/ROADMAP.md` Phase 3 Notes·Ground Rules, `.planning/research/STACK.md` (a), Phase 2 CONTEXT D-13·D-16~D-19, Phase 1 CONTEXT D-04.
- CSS는 직접 씁니다. Tailwind CLI, 빌드 도구, 생성 CSS 커밋은 쓰지 않습니다.
- CSS를 외부 `.css` 파일로 빼지 않습니다. `<style>` 안에 Jekyll include로 인라인합니다.
- 토큰(`ink #2B2B2B`, `accent #7C580D`, `muted #4A463F`, `muted-2 #57534C`, `line #E4E0D6`)은 CSS 변수로 한 번만 정의합니다. Preflight는 필요한 규칙만 법적 페이지 범위로 옮깁니다.
- 푸시할 때마다 `checkpoint:decision`으로 승인을 받습니다. 승인은 그 푸시 한 번에만 씁니다. 푸시 뒤 라이브를 확인하고, 문제가 있으면 먼저 `git revert`로 되돌립니다. force push와 히스토리 수정은 하지 않습니다(Phase 2 D-16~D-18).
  - `checkpoint:human-verify`는 이 프로젝트 설정(`workflow.human_verify_mode: "end-of-phase"`)에서 단계 끝으로 밀립니다. 그래서 푸시 전에 받아야 하는 승인은 `checkpoint:decision`으로 둡니다.
- `CLAUDE.md`는 Phase 1 D-04의 방법으로 고칩니다. 방침 구간은 루트와 `.claude/CLAUDE.md` 두 사본을 같은 커밋에서 똑같이 고칩니다. GSD 생성 구간은 원본 맵을 고친 뒤 `generate-claude-md`로 다시 만듭니다.
- 기존 3개 URL의 경로와 `<title>`은 바꾸지 않습니다(Ground Rule, `scripts/check-site.sh`가 확인).
- **연구 문서의 엇갈림 정리:** `.planning/research/STACK.md` (a)는 본문에 `.rp-legal-body` 같은 의미 클래스를 붙이자고 했습니다. `.planning/research/ARCHITECTURE.md` Pattern 5는 클래스 없는 본문을 제안했습니다. 이 단계는 ROADMAP 목표와 성공 기준 4를 따라 **본문은 클래스 없이** 씁니다. 레이아웃이 그리는 껍데기(카드, 카드 머리, 감싸는 `div`)에는 `rp-` 클래스를 써도 됩니다. `.planning/research/SUMMARY.md`의 「사실값이 모였다면 Phase 5와 합쳐도 됨」 메모는 쓰지 않습니다. 시각 변경과 내용 변경을 섞지 않는다는 Ground Rule 때문입니다.

### 본문 작성 규칙 (Phase 6~9가 따를 계약)
- **D-01:** 본문 원본은 HTML로 유지합니다. 파일은 지금처럼 `privacy-policy/index.html` 등이고, Markdown(kramdown)으로 바꾸지 않습니다.
  - 이유: kramdown 기본 설정은 `"회사"`를 굽은 따옴표로 바꿔 성공 기준 3을 깹니다. 제목마다 자동 `id`도 붙습니다. 표를 감싸는 요소(D-07)도 넣기 어렵습니다.
- **D-02:** 조항마다 `<section>` 하나를 두고, 첫 자식은 `<h2>`입니다. 간격은 지금 값을 그대로 씁니다.
  - 본문 최상위 자식 사이 32px: `section`끼리, 그리고 마지막 `footer` 앞
  - `section` 안 자식 사이 12px
  - 목록 항목(`li`) 사이 4px
- **D-03:** 주석은 두 요소로 씁니다. 둘 다 클래스가 없습니다.
  - **문서 끝 안내 `<footer>`:** 지금 「임시 게시본」 문단의 모양 그대로입니다. 위에 1px 실선(`line`), 위 안쪽 여백 16px, 글씨 14px에 줄 높이 20px, 색 `muted-2`.
  - **조항 안 보충 설명 `<aside>`:** 구분선 없이 작은 회색 글씨(14px, `muted-2`)입니다. 예: 표 아래 「※ …」.
  - 지금의 `<p class="border-t border-line pt-4 text-sm text-muted-2">` 세 개(문서마다 하나)는 이 단계에서 `<footer>`로 바꿉니다. 문장은 바꾸지 않습니다. `footer` 안에 `<p>`를 둘지는 Claude's Discretion이고, 추출한 텍스트가 같아야 합니다.
- **D-04:** 본문에서 쓸 수 있는 요소는 아래가 전부입니다. 모두 클래스 없이 씁니다.
  - 구조와 제목: `section`, `h2`, `h3`
  - 글과 목록: `p`, `ul`, `ol`, `li`, `dl`·`dt`·`dd`
  - 표: `table`(`thead`·`tbody`·`tr`·`th`·`td`)과 표를 감싸는 요소(D-07)
  - 인라인: `strong`, `a`
  - 주석: `aside`, `footer`

  이 목록에 없는 요소가 필요해지면, 그 단계에서 CSS를 더하고 이 목록과 규칙 기록(D-25)을 함께 고칩니다.
- **D-05:** 클래스 없는 `strong`과 `a`는 지금 붙어 있는 클래스의 값을 기본 모양으로 받습니다. 지금 본문의 `strong` 1개와 링크 3개는 모두 같은 클래스를 쓰므로, 클래스를 지워도 잃는 정보가 없습니다.
  - `strong`: 600, `ink`
  - `a`: 600, `ink`, 밑줄 2px `accent`, `underline-offset` 4px. hover 때 글자색 `accent`, `transition-colors` 150ms

### 새 요소의 모양 (성공 기준 4)
- **D-06:** 표는 **가로줄만** 씁니다.
  - 바깥 테두리와 바탕색은 없습니다. 행 사이는 1px 실선(`line`)으로 나눕니다.
  - 머리 행(`th`)은 굵은 `ink`입니다. 표 안 글씨는 **14px**입니다.
  - 정렬은 왼쪽·위로 둡니다. 칸 여백, 줄 간격, 머리 행 아래 선의 굵기는 Claude's Discretion입니다.
- **D-07:** 표가 본문 폭보다 넓으면 **표를 감싼 요소 안에서만 가로로 스크롤**합니다. 375px에서 페이지 자체는 가로로 밀리면 안 됩니다.
  - 감싸는 요소도 클래스 없이 씁니다(예: `<figure>` 또는 `<div>`). 어떤 요소로 할지는 계획 단계에서 정하고 D-25 규칙 기록에 적습니다.
  - `<table>`에 `display: block`을 주지 않습니다. 일부 화면 낭독기가 표로 인식하지 못하기 때문입니다.
  - 키보드로 스크롤할 수 있게 할 방법(`tabindex="0"`, `role="region"`과 이름)과 그 작성 부담은 연구에서 확인합니다.
- **D-08:** 표가 넘칠 때만 더 밀 수 있는 쪽 가장자리에 옅은 그림자를 둡니다. CSS만으로 만들고 JS는 쓰지 않습니다. 끝까지 밀면 그림자가 사라지고, 넘치지 않으면 아무것도 보이지 않습니다.
  - 기법(예: `background-attachment: local` 스크롤 그림자)이 WebKit에서도 동작하는지 연구에서 확인합니다.
- **D-09:** `<ol>`은 1. 2. 3.(decimal)으로 표시합니다. 들여쓰기(20px)와 항목 간격(4px)은 `ul`과 같습니다. 약관의 항 번호(①)가 필요하면 본문 글에 직접 씁니다.
- **D-10:** 중첩 목록은 바깥 목록 안에서 20px을 한 번 더 들여씁니다.
  - `ul` 안의 `ul`은 ○(circle)입니다.
  - `ol` 안의 `ol`은 가. 나. 다.(`hangul`)입니다. 영문판(`lang="en"`)에서는 a. b. c.(`lower-alpha`)입니다. 이 언어 분기는 Phase 9 전이지만 이 단계 CSS에 미리 둡니다.
  - `ul` 안의 `ol`처럼 섞인 경우는 위 원칙 안에서 계획자가 정합니다.
  - `hangul` 번호 뒤에 마침표가 붙는지는 연구에서 Chromium과 WebKit 둘 다 확인합니다.
- **D-11:** `<h3>`는 17px, 굵기 700, `ink`입니다. h2(20px/700/`ink`)와 같은 색·굵기에서 크기만 한 단계 줄인 모양입니다.
- **D-12:** `<dl>`은 용어(`dt`)를 굵은 `ink`로 한 줄에 두고, 뜻(`dd`)을 그 아래 본문 글씨로 씁니다. `dd`는 들여쓰지 않습니다. 화면 폭과 관계없이 같은 모양입니다.

### 「같은 모양」 판정 (성공 기준 1~3)
- **D-13:** 성공 기준 2는 **픽셀 차이 0**으로 판정합니다. 허용 오차를 두지 않습니다.
  - 대상: 세 문서 × 375·768·1280px × 페이지 전체. 헤더·푸터를 포함한 full page입니다. Preflight를 빼면 헤더·푸터의 초기화도 함께 빠지므로 카드만 비교하면 안 됩니다.
  - 차이가 있으면 실패로 보고, 요소별 계산된 스타일(computed style)을 비교해 원인을 찾아 고칩니다.
  - 기준 페이지를 두 번 찍어 자기 차이가 0인지 먼저 확인합니다. 0이 아니면(렌더링 잡음) 임의로 허용 오차를 정하지 말고 사용자에게 알린 뒤 판정 방법을 다시 정합니다.
  - Phase 2 UAT에서 법적 페이지는 0이었습니다. 랜딩은 애니메이션 때문에 잡음이 있었습니다.
- **D-14:** 비교 엔진은 **Chromium과 WebKit**(Playwright)입니다. 기준 캡처도 엔진별로 따로 둡니다. 심사자, 특히 App Store 심사자는 Safari로 볼 가능성이 높기 때문입니다.
- **D-15:** 기본 상태에 더해 본문 링크의 **hover와 키보드 focus 상태**도 전·후로 찍어 비교합니다. 전환 애니메이션은 계산된 스타일(`transition-property`·`-duration`·`-timing-function`)로 비교합니다. 캡처는 애니메이션이 끝난 뒤에 합니다.
- **D-16:** 기준(전환 전) 캡처는 이렇게 만듭니다.
  - Phase 3 실행을 시작할 때의 커밋을 로컬 Jekyll 3.10.0으로 빌드하고, **어떤 변경보다 먼저** 찍습니다. 그 커밋 해시를 검증 문서에 적습니다.
  - Tailwind Play CDN은 버전이 고정돼 있지 않습니다. 찍을 때 리디렉션된 버전을 기록합니다. 2026-11-16 기준 `cdn.tailwindcss.com` → `302 /3.4.17`입니다.
  - 글꼴 로드(`document.fonts.ready`)와 Tailwind 스타일 주입이 끝난 뒤 찍습니다.
  - 미리보기는 `--livereload` 없이 띄웁니다. Playwright MCP 로그가 새로 고침을 반복시키기 때문입니다(STATE 메모).
  - 전·후 모두 같은 Mac에서 찍습니다.
- **D-17:** 성공 기준 3은 세 문서의 본문에서 텍스트를 뽑아 전·후를 비교하고, 차이 0으로 판정합니다.
- **D-18:** 성공 기준 1은 두 곳에서 모두 `cdn.tailwindcss.com`이 0건인지 봅니다.
  - HTML 소스: `_site` 출력과 라이브 HTML. `tailwind.config` 스크립트도 없어야 합니다.
  - 브라우저 네트워크 요청
- **D-19:** 성공 기준 4는 **캡처를 보고 사용자가 승인**합니다.
  - 시험용 본문을 만듭니다. 넓은 표와 좁은 표, `ul`·`ol`·중첩 목록, `h3`, `dl`, `aside`, `footer`, `strong`, `a`를 넣습니다. 이 본문은 커밋하지 않는 스크래치입니다.
  - 3폭 × 2엔진으로 찍어 사이트 푸시 승인 전에 보여 줍니다. 같은 `checkpoint:decision`에서 함께 보여도 됩니다.
  - 자동 확인도 함께 합니다. 계산된 스타일이 결정한 값과 같은지(표 14px, 선 `#E4E0D6`, h3 17px 등) 보고, 375px에서 페이지가 가로로 밀리지 않는지(`scrollWidth`가 화면 폭 이하) 봅니다.

### 배포 단위
- **D-20:** 사이트 커밋은 3단계로 나눕니다. **커밋 하나하나가 D-13 픽셀 0을 따로 통과해야 합니다.** 그래야 회귀가 어느 단계에서 생겼는지 바로 좁혀집니다.
  1. **정적 CSS 추가.** Tailwind script, config, 본문 클래스는 그대로 둡니다. 새 CSS가 같은 값을 겹쳐 주므로 모양은 그대로입니다.
  2. **본문 3종에서 클래스 제거.** 「임시 게시본」 `p`도 `footer`로 바꿉니다(D-03). Tailwind는 아직 남아 있습니다. 문서별 커밋으로 더 나눌지는 Claude's Discretion입니다.
  3. **레이아웃에서 Tailwind 제거.** `<script src>`와 `tailwind-config`를 지웁니다. Preflight를 대신하는 규칙이 맞는지가 이 커밋에서 드러납니다.

  레이아웃 카드 껍데기(감싸는 `div`, `article`, eyebrow `span`, `h1`, 날짜 `p`)의 Tailwind 클래스를 `rp-` 클래스로 바꾸는 일은 ① 또는 ③에서 합니다(Claude's Discretion).
- **D-21:** 푸시는 **두 번**입니다. — **Reversibility:** costly — 푸시는 곧 라이브 배포입니다. 되돌리려면 revert 커밋과 재배포가 필요하고, 그동안 심사 콘솔에 등록된 URL이 깨진 모양으로 보일 수 있습니다.
  1. **사이트 푸시:** D-20의 ①②③ 커밋(그리고 `scripts/check-site.sh`를 고쳤다면 그 커밋)
  2. **문서 푸시:** 라이브 확인(D-22)이 통과한 뒤 문서 커밋(D-24)을 올립니다. 사이트를 되돌리게 되더라도 문서가 사이트와 어긋나지 않습니다.
- **D-22:** 사이트 푸시 뒤의 라이브 확인입니다. GitHub Pages 배포 완료를 먼저 확인합니다(`gh`, 커밋 체크 또는 「pages build and deployment」). GitHub Pages는 `Cache-Control: max-age=600`이므로 캐시를 우회하는 쿼리를 붙이거나 기다렸다가 확인합니다. 확인 항목은 두 가지입니다.
  - **HTTP 확인:** curl로 세 URL이 200이고 `<title>`이 기대값인지, HTML에 `cdn.tailwindcss.com`과 `tailwind.config`가 없는지 봅니다.
  - **화면 확인:** Playwright Chromium·WebKit으로 라이브 세 문서를 3폭으로 찍습니다. 네트워크 요청에 Tailwind가 없는지 확인하고, 기준 캡처(D-16)와 비교해 픽셀 차이 0인지 봅니다. 운영 빌드(GitHub Pages)와 로컬 빌드의 차이는 이 비교에서만 잡힙니다.

  문서 푸시 뒤에는 사이트 출력이 바뀌지 않으므로 HTTP 확인(200·제목)으로 충분합니다.
- **D-23:** 라이브에서 문제가 보이면 고치기 전에 먼저 되돌립니다. 순서는 `git revert` → 승인 → 푸시이고, 원인 수정은 그다음 커밋에서 합니다(Phase 2 D-18).
- **D-24:** 바뀌는 사실이 많아 이 단계 안에서 문서도 고칩니다(Ground Rule). 대상은 아래이고, 문서 커밋에 담아 D-21의 두 번째 푸시로 올립니다.
  - **방침 구간(루트 `CLAUDE.md`와 `.claude/CLAUDE.md`, 같은 커밋에서 똑같이):** 「Jekyll 빌드 전환」 행의 현재 상태를 「Phase 3까지 적용됨」으로 고칩니다.
  - **루트 `CLAUDE.md`의 코드 설명:**
    - 「법적 페이지 3종은 Tailwind CDN 런타임 모드」 설명을 정적 CSS 설명으로 바꿉니다(CSS 위치, 토큰 CSS 변수, Preflight 대체).
    - 본문 작성 규칙을 더합니다(D-02~D-04, D-07의 감싸는 요소).
    - Local preview의 「법적 페이지의 Tailwind는 CDN에서 받으므로」 문구를 고칩니다.
    - 「860px가 유일한 폭 breakpoint」라는 설명은 법적 카드의 768px(`min-width`, 지금 `md:p-12`) 예외를 밝히도록 고칩니다.
  - **원본 맵:** `.planning/codebase/STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md`를 고칩니다. Tailwind를 언급하는 `CONCERNS.md`·`STRUCTURE.md`·`TESTING.md`·`INTEGRATIONS.md`도 고칩니다. 그 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 `.claude/CLAUDE.md`를 다시 만듭니다.
  - **`README.md`:** Tailwind를 언급하면 고칩니다.
  - **`.planning/PROJECT.md`:** Active 체크, 「현재 사이트」 설명, Key Decisions 행은 Phase 2처럼 단계 전환 갱신에서 고칩니다.
- **D-25:** 본문 작성 규칙(D-02~D-12)을 기록하는 곳은 두 군데입니다.
  - 두 `CLAUDE.md`. 원본 맵 `CONVENTIONS.md`·`ARCHITECTURE.md`를 거쳐 재생성합니다. GSD 밖에서 연 세션도 이 규칙을 지키게 하려는 것입니다.
  - 법적 페이지 CSS 맨 위 주석. 「본문에 쓸 수 있는 요소」 목록을 짧게 적어, CSS를 고치는 사람도 규칙을 보게 합니다. 이 주석은 사이트 커밋 ①에 들어갑니다.

### Claude's Discretion
- 법적 CSS의 위치. `_includes/css/legal.css`로 빼서 레이아웃 `<style>` 안에 include할 수도 있고, 레이아웃의 「법적 페이지 전용」 묶음에 바로 둘 수도 있습니다. include 쪽을 권합니다. Phase 5 `/support/`와 Phase 9 `/en/`이 재사용하기 쉽기 때문입니다.
- 선택자와 클래스 이름(예: 본문 범위 `.rp-doc`, 껍데기 `.rp-legal-*`), 토큰 변수 이름(예: `--rp-ink`), 변수를 정의할 범위. 단, **랜딩 출력이 바뀌지 않도록 토큰과 초기화 규칙은 `_includes/css/common.css`에 넣지 않습니다.**
- Preflight 대체 규칙을 어디까지 걸지(`body` 단위 또는 카드 단위). 판정은 D-13의 픽셀 0이 합니다.
- 화면 캡처에 드러나지 않는 Preflight 규칙(예: `-webkit-tap-highlight-color: transparent`)을 옮길지. 같은 동작을 위해 옮기기를 권합니다.
- 표 칸 여백, 표와 `aside`의 줄 간격, 머리 행 아래 선, 중첩 목록 위 간격, `dt` 굵기(600 또는 700), `h3` 앞뒤 간격. 새 요소에는 새 색을 만들지 않고 기존 토큰 안에서 고릅니다.
- 표를 감싸는 요소(`figure` 또는 `div`)와 키보드 스크롤 속성. 결정은 D-25 기록에 반영합니다.
- 비교 도구의 형태(Playwright MCP 또는 스크래치 스크립트), 기준 페이지를 서빙하는 방법(`--livereload` 금지), 텍스트 추출 방법. 비교 도구는 커밋하지 않습니다. Phase 2 D-13처럼 한 번 쓰고 결과만 검증 문서에 남깁니다.
- `scripts/check-site.sh`에 「출력 HTML에 `cdn.tailwindcss.com` 없음」 항목을 더할지. 더하기를 권합니다. 더하면 스크립트 머리 주석, `CLAUDE.md`의 점검 항목 수(「넷」), `.githooks/pre-push` 설명도 함께 고칩니다.
- D-20 ②를 문서별 커밋으로 나눌지, 레이아웃 껍데기 클래스를 ①과 ③ 중 어디서 바꿀지.

### 참고: 지금 쓰는 Tailwind 값 (계획자가 3.4.17 원문으로 다시 확인)
| 위치 | 클래스 | 값 |
|---|---|---|
| 감싸는 div | `mx-auto max-w-[800px] px-6 py-[clamp(48px,6vw,80px)]` | 가운데 정렬, 최대 800px, 좌우 24px, 위아래 clamp |
| 카드 `article` | `rounded-[28px] border-[1.5px] border-line bg-white p-7 md:p-12` | 반경 28px, 1.5px 실선 `line`, 흰 바탕, 안쪽 28px, 768px 이상에서 48px |
| eyebrow `span` | `text-sm font-bold tracking-[0.04em] text-accent` | 14px/20px, 700, 0.04em, `accent` |
| `h1` | `mt-3.5 text-[clamp(30px,6.5vw,42px)] font-black leading-[1.25] tracking-[-1px]` | 위 14px, clamp 크기, 900, 1.25, -1px |
| 날짜 `p` | `mt-3 text-[13px] text-muted-2` | 위 12px, 13px. 줄 높이는 Preflight `html { line-height: 1.5 }`를 물려받음 |
| 본문 틀 | `mt-10 space-y-8 leading-[1.7] text-muted` | 위 40px, 자식 사이 32px, 1.7, `muted` |
| `section` | `space-y-3` | 자식 사이 12px |
| `h2` | `text-xl font-bold text-ink` | 20px/28px, 700, `ink` |
| `ul` | `list-disc space-y-1 pl-5` | disc, 항목 사이 4px, 왼쪽 20px |
| `strong` | `font-semibold text-ink` | 600, `ink` |
| `a` | `font-semibold text-ink underline decoration-accent decoration-2 underline-offset-4 transition-colors hover:text-accent` | D-05 |
| 끝 안내 `p` | `border-t border-line pt-4 text-sm text-muted-2` | 위 1px 실선, 위 안쪽 16px, 14px/20px, `muted-2` |

Preflight에 기대고 있는 곳(연구 STACK (a)):
- `html { line-height: 1.5 }`(날짜 줄과 감싸는 요소가 물려받음)
- 요소의 `margin: 0`(`h1`·`h2`·`p`)과 목록 초기화(`ul`)
- `h1`~`h6`의 `font-size`·`font-weight: inherit`
- `a { color: inherit; text-decoration: inherit }`
- `*` 테두리 3값(border-width 0, style solid, color)

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### 단계 범위와 규칙
- `.planning/ROADMAP.md` §Phase 3 — 목표, 성공 기준 1~4, Notes(Preflight 규칙과 토큰 CSS 변수). 같은 문서의 §Ground Rules(커밋 분리, URL 고정, 로컬 빌드 확인, CLAUDE.md 동시 갱신)
- `.planning/REQUIREMENTS.md` — SHELL-04
- `CLAUDE.md`, `.claude/CLAUDE.md` — 방침 구간과 작업 규칙. 이 단계에서 고칠 대상(D-24)

### 연구 (방식과 함정)
- `.planning/research/STACK.md` §(a) Tailwind Play CDN → 정적 CSS — 쓰는 클래스 목록(약 45개), Preflight 함정, CSS 위치. 본문 클래스 방식은 이 CONTEXT의 「연구 문서의 엇갈림 정리」로 대체함
- `.planning/research/ARCHITECTURE.md` Pattern 5(시맨틱 본문)와 「2단계 — Tailwind Play CDN 제거」 — 클래스 없는 본문, 표·목록·주석 스타일을 처음에 정의
- `.planning/research/PITFALLS.md` — Tailwind Play CDN 유지의 위험(렌더 차단, 버전 미고정)
- 외부: `https://unpkg.com/tailwindcss@3.4.17/src/css/preflight.css` — Preflight 원문
- 외부: Tailwind v3.4.17 기본 테마(`fontSize`, `spacing`, `transitionProperty`) — 위 「참고」 표 값의 근거. `https://github.com/tailwindlabs/tailwindcss/blob/v3.4.17/stubs/config.full.js`

### 이전 단계 결정과 검증 방법
- `.planning/phases/02-jekyll-shared-shell-refactor/02-CONTEXT.md` — D-13(점검 스크립트), D-14(pre-push 훅), D-16(푸시 승인 `checkpoint:decision`), D-17(라이브 확인), D-18(revert 먼저), D-19(문서 갱신 범위)
- `.planning/phases/02-jekyll-shared-shell-refactor/02-UAT.md` — Playwright 전체 페이지 픽셀 비교 방법과 렌더링 잡음 관찰(법적 페이지 0픽셀)
- `.planning/STATE.md` — Playwright MCP와 `jekyll serve --livereload`의 간섭 메모
- `~/.claude/gsd-core/references/checkpoints.md`, `~/.claude/gsd-core/references/planner-human-verify-mode.md` — `checkpoint:decision`과 `human-verify`의 차이

### 코드
- `_layouts/legal.html` — Tailwind script(14행), `tailwind-config`(16~30행), 「법적 페이지 전용」 CSS(34~37행), 카드 껍데기 클래스(45~53행)
- `_includes/css/common.css` — 「공통」 CSS. 이 단계에서 고치지 않음(랜딩 출력 불변)
- `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html` — 클래스를 지울 본문
- `scripts/check-site.sh`, `.githooks/pre-push` — 푸시 전 점검
- `.planning/codebase/STACK.md`, `CONVENTIONS.md`, `ARCHITECTURE.md`, `CONCERNS.md`, `STRUCTURE.md`, `TESTING.md`, `INTEGRATIONS.md` — Tailwind 언급을 고칠 원본 맵

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `_includes/css/common.css`: 헤더·푸터는 이미 Tailwind 없이 `.rp-*` 클래스로 그립니다. 랜딩이 Preflight 없이 같은 헤더·푸터를 그리고 있으므로, 법적 페이지의 헤더·푸터도 Preflight 없이 같게 나올 가능성이 높습니다. 판정은 D-13이 합니다.
- `_layouts/legal.html` 「법적 페이지 전용」 묶음(`.rp-grid` 모눈종이 등): 새 정적 CSS를 둘 자리입니다.
- `scripts/check-site.sh`: production·`--safe` 빌드로 운영과 같은 출력을 만듭니다. 커밋 인자를 주면 그 커밋만 내보내 빌드합니다. 기준 빌드와 커밋별 빌드에 그대로 쓸 수 있습니다.

### Established Patterns
- 직접 만든 클래스에는 `rp-` 접두사와 kebab-case를 씁니다. CSS 규칙은 한 줄에 하나씩 쓰고, 공백 4칸으로 들여씁니다. 구획 머리 주석은 `/* ── 이름 ── */`입니다.
- include 공백 규칙: include 태그는 0열에 혼자 두고, include 파일은 끝 줄바꿈 없이 씁니다. `{%-`는 `if`/`endif`에만 씁니다.
- raw 규칙: 인라인 CSS·JS에 이중 중괄호나 중괄호-퍼센트가 생기면 `{% raw %}`로 감쌉니다. CSS 주석에 Liquid 문자열을 쓰지 않습니다.
- 대비: 노랑 `#F2B134`는 밝은 바탕 위 글자·선에 쓰지 않습니다. 링크 밑줄과 작은 제목에는 `#7C580D`(`accent`)를 씁니다.
- 접근성: `:focus-visible` 테두리 `3px solid #1E5AA8`(「공통」). 클릭 대상은 최소 44px입니다(헤더·푸터).

### Integration Points
- `_layouts/legal.html`의 `{{ content | rstrip }}`는 본문 틀 `<div class="mt-10 space-y-8 leading-[1.7] text-muted">` 안에 들어갑니다. 이 `div`가 클래스 없는 본문 규칙의 범위 기준이 됩니다.
- 법적 레이아웃의 front matter 키(`title`·`description`·`eyebrow`·`heading`·`updated`·`noindex`)는 바꾸지 않습니다.
- 반응형: 카드 안쪽 여백은 768px(`min-width`)에서 바뀝니다. 랜딩의 860px(`max-width`) 규칙과는 별개입니다.

</code_context>

<specifics>
## Specific Ideas

- 논의에서 고른 표 모양(가로줄만):
  ```
   항목        목적         보유 기간
  ───────────────────────────────────
   이메일      로그인        탈퇴까지
  ───────────────────────────────────
   위치 기록   완주 판정    탈퇴까지
  ───────────────────────────────────
  ```
- 주석 두 가지:
  ```
    …제11조 본문…
    <aside>※ 보충 설명</aside>          →  ※ 보충 설명 (작고 흐림, 선 없음)

  <footer>본 약관은 임시 게시본…</footer>
    →  ──────────────────
       본 약관은 임시 게시본…
  ```
- 중첩 목록:
  ```
  1. 개인정보를 파기합니다
     가. 전자 파일은 …
     나. 종이 문서는 …

  ● 계정 정보
     ○ 이메일 주소
     ○ 닉네임
  ```
- 본문 마크업 예(클래스 없음):
  ```html
  <section>
    <h2>1. 수집하는 개인정보 항목</h2>
    <p>슬림펌킨(이하 "회사")은 …</p>
    <ul>
      <li>계정 정보: …</li>
    </ul>
  </section>
  ```

</specifics>

<deferred>
## Deferred Ideas

None. 논의는 단계 범위 안에서 진행됐습니다. 다른 단계의 몫은 아래와 같습니다.
- 「포인트·굿즈·코스북」 문장 삭제: Phase 4(랜딩), Phase 6·7·8(법적 문서)
- `noindex`와 「임시 게시본」 표시 제거: Phase 6·7·8 (U14). 이 단계에서는 「임시 게시본」 문단의 요소만 `<footer>`로 바꿉니다
- 영문판에서 중첩 번호 a. b. c.가 실제로 나오는지 확인: Phase 9(이 단계는 CSS 규칙만 미리 둠)
- Pretendard `integrity`·CSP 도입(`CONCERNS.md`): 이번 논의에서 다루지 않음

</deferred>

---

*Phase: 03-tailwind-cdn-removal*
*Context gathered: 2026-11-16*
