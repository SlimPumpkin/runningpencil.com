# Phase 3: 법적 페이지 정적 스타일 전환 (Tailwind CDN Removal) - Research

**Researched:** 2026-11-16
**Domain:** 정적 CSS 이식 (Tailwind v3.4.17 Play CDN → 손으로 쓴 CSS), Jekyll include, Playwright 픽셀 비교
**Confidence:** HIGH (핵심 주장은 모두 이 세션의 실측으로 확인. 웹 출처는 보조)

<user_constraints>
## User Constraints (from CONTEXT.md)

아래는 `03-CONTEXT.md`의 `<decisions>`와 `<deferred>`를 그대로 옮긴 것입니다.

### Locked Decisions

#### 이전에 정해진 것 (다시 논의하지 않음)
출처: `.planning/ROADMAP.md` Phase 3 Notes·Ground Rules, `.planning/research/STACK.md` (a), Phase 2 CONTEXT D-13·D-16~D-19, Phase 1 CONTEXT D-04.
- CSS는 직접 씁니다. Tailwind CLI, 빌드 도구, 생성 CSS 커밋은 쓰지 않습니다.
- CSS를 외부 `.css` 파일로 빼지 않습니다. `<style>` 안에 Jekyll include로 인라인합니다.
- 토큰(`ink #2B2B2B`, `accent #7C580D`, `muted #4A463F`, `muted-2 #57534C`, `line #E4E0D6`)은 CSS 변수로 한 번만 정의합니다. Preflight는 필요한 규칙만 법적 페이지 범위로 옮깁니다.
- 푸시할 때마다 `checkpoint:decision`으로 승인을 받습니다. 승인은 그 푸시 한 번에만 씁니다. 푸시 뒤 라이브를 확인하고, 문제가 있으면 먼저 `git revert`로 되돌립니다. force push와 히스토리 수정은 하지 않습니다(Phase 2 D-16~D-18).
  - `checkpoint:human-verify`는 이 프로젝트 설정(`workflow.human_verify_mode: "end-of-phase"`)에서 단계 끝으로 밀립니다. 그래서 푸시 전에 받아야 하는 승인은 `checkpoint:decision`으로 둡니다.
- `CLAUDE.md`는 Phase 1 D-04의 방법으로 고칩니다. 방침 구간은 루트와 `.claude/CLAUDE.md` 두 사본을 같은 커밋에서 똑같이 고칩니다. GSD 생성 구간은 원본 맵을 고친 뒤 `generate-claude-md`로 다시 만듭니다.
- 기존 3개 URL의 경로와 `<title>`은 바꾸지 않습니다(Ground Rule, `scripts/check-site.sh`가 확인).
- **연구 문서의 엇갈림 정리:** `.planning/research/STACK.md` (a)는 본문에 `.rp-legal-body` 같은 의미 클래스를 붙이자고 했습니다. `.planning/research/ARCHITECTURE.md` Pattern 5는 클래스 없는 본문을 제안했습니다. 이 단계는 ROADMAP 목표와 성공 기준 4를 따라 **본문은 클래스 없이** 씁니다. 레이아웃이 그리는 껍데기(카드, 카드 머리, 감싸는 `div`)에는 `rp-` 클래스를 써도 됩니다. `.planning/research/SUMMARY.md`의 「사실값이 모였다면 Phase 5와 합쳐도 됨」 메모는 쓰지 않습니다. 시각 변경과 내용 변경을 섞지 않는다는 Ground Rule 때문입니다.

#### 본문 작성 규칙 (Phase 6~9가 따를 계약)
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

#### 새 요소의 모양 (성공 기준 4)
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
  - 확정한 것은 화면에 보이는 「가. 나. 다.」 모양입니다. `hangul` 키워드는 수단입니다. 연구에서 이 키워드가 Chromium과 WebKit 둘 다에서 가. 나. 다.로 그려지는지(마침표 포함) 확인합니다. 안 되면 다른 방법(예: `@counter-style`)을 찾고, 그것도 안 되면 사용자에게 다시 묻습니다.
- **D-11:** `<h3>`는 17px, 굵기 700, `ink`입니다. h2(20px/700/`ink`)와 같은 색·굵기에서 크기만 한 단계 줄인 모양입니다.
- **D-12:** `<dl>`은 용어(`dt`)를 굵은 `ink`로 한 줄에 두고, 뜻(`dd`)을 그 아래 본문 글씨로 씁니다. `dd`는 들여쓰지 않습니다. 화면 폭과 관계없이 같은 모양입니다.

#### 「같은 모양」 판정 (성공 기준 1~3)
- **D-13:** 성공 기준 2는 **픽셀 차이 0**으로 판정합니다. 허용 오차를 두지 않습니다.
  - 대상: 세 문서 × 375·768·1280px × 페이지 전체. 헤더·푸터를 포함한 full page입니다. Preflight를 빼면 헤더·푸터의 초기화도 함께 빠지므로 카드만 비교하면 안 됩니다.
  - 차이가 있으면 실패로 보고, 요소별 계산된 스타일(computed style)을 비교해 원인을 찾아 고칩니다.
  - 기준 페이지를 두 번 찍어 자기 차이가 0인지 먼저 확인합니다. 0이 아니면(렌더링 잡음) 임의로 허용 오차를 정하지 말고 사용자에게 알린 뒤 판정 방법을 다시 정합니다.
  - 참고: Phase 2 UAT(Chromium, 1280·390px)에서 8쌍 중 7쌍이 0픽셀이었습니다. 랜딩 1280만 12픽셀이 달랐고, 같은 기준 페이지를 다시 찍어도 99픽셀이 달라졌습니다. 원인은 기록되지 않았습니다. WebKit과 768px는 확인한 적이 없습니다.
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

#### 배포 단위
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

### Deferred Ideas (OUT OF SCOPE)
None. 논의는 단계 범위 안에서 진행됐습니다. 다른 단계의 몫은 아래와 같습니다.
- 「포인트·굿즈·코스북」 문장 삭제: Phase 4(랜딩), Phase 6·7·8(법적 문서)
- `noindex`와 「임시 게시본」 표시 제거: Phase 6·7·8 (U14). 이 단계에서는 「임시 게시본」 문단의 요소만 `<footer>`로 바꿉니다
- 영문판에서 중첩 번호 a. b. c.가 실제로 나오는지 확인: Phase 9(이 단계는 CSS 규칙만 미리 둠)
- Pretendard `integrity`·CSP 도입(`CONCERNS.md`): 이번 논의에서 다루지 않음
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| SHELL-04 | 방문자는 외부 스크립트(Tailwind Play CDN) 없이 정적 CSS만으로 법적 페이지를 보고, 모양은 전환 전과 같다 (375·768·1280px) [VERIFIED: .planning/REQUIREMENTS.md:25] | 이 세션에서 아래 「검증된 legal.css」로 커밋 ①②③ 각각을 스크래치에서 재현해, 2엔진 × 3폭 × 3문서 전체 페이지 18장 + 본문 링크가 있는 2문서(처리방침·약관)의 hover·focus 24장 = PNG 42장, 본문 텍스트 18건이 기준과 **픽셀 차이 0·텍스트 차이 0**임을 확인함. ③ 출력 HTML·네트워크 요청에 Tailwind 0건. 랜딩 `index.html` 출력은 바이트 동일 |
</phase_requirements>

## Summary

**이 단계는 실측으로 이미 성립이 확인된 기계적 변환입니다.** 이 세션에서 현재 HEAD(`a55649b8ec65`)를 기준으로, 아래 「Code Examples」의 `_includes/css/legal.css` 원안을 넣은 커밋 ①(정적 CSS 추가 + 껍데기 클래스 교체), ②(본문 클래스 제거, 「임시 게시본」 `p` → `footer`), ③(Tailwind script·config 제거) 세 벌을 스크래치에 만들고 Jekyll 3.10.0으로 빌드해 Playwright 1.59.1(Chromium 147, WebKit 빌드 2272)로 찍었습니다. 세 벌 모두 기준과 **PNG 42장 모두 0픽셀 차이**(전체 페이지 18장 + 처리방침·약관 링크 hover·focus 24장. 삭제 안내에는 본문 링크가 없음), 본문 텍스트 18건 모두 같았습니다. 기준을 두 번 찍은 자기 차이도 0이었습니다(Phase 2 랜딩에서 본 잡음은 법적 페이지에서 나오지 않음). 일부러 규칙 하나씩 뺀 절제 시험(ablation)에서는 하네스가 높이 차이를 바로 잡았습니다. 그러니 비교 방법이 둔감해서 0이 나온 것은 아닙니다.

Tailwind CDN이 실제로 만든 CSS를 그대로 뽑아 보니(아래 「CDN이 만든 CSS 원문」), 법적 페이지에서 **픽셀에 영향을 주는 Preflight 규칙은 세 가지뿐**입니다. ① `html { line-height: 1.5 }`(날짜 줄과 eyebrow 줄 상자를 정함, 빼면 페이지가 8~9px 짧아짐), ② `h1`·`h2`·`p`·`ul`의 `margin: 0`과 `ul`의 `padding: 0`·`list-style: none`(빼면 13~51px 길어짐), ③ `*` 테두리 3값 중 `border-style: solid`(카드와 끝 안내 줄에 `border` 단축 속성을 쓰면 자동으로 대체됨). `svg { display: block }`은 헤더·푸터 로고가 grid 항목이라 이미 블록이 되므로 영향이 없습니다(절제 시험으로 확인). 헤더·푸터는 `common.css`가 이미 Preflight 없이 그리도록 짜여 있어 그대로 같습니다.

과도기 커밋 ①②의 캐스케이드도 확인했습니다. CDN은 `<style>`을 `<head>`의 **마지막 자식**으로 붙입니다. 레이아웃 `<style>`보다 뒤라서 **명시도가 같으면 Tailwind가 이깁니다.** 그래서 정적 규칙은 모두 `.rp-doc …`처럼 클래스를 포함한 선택자(0,1,1 이상)로 써서 Preflight 요소 선택자(0,0,1)를 이기게 해야 합니다. 같은 이유로 `html { line-height }`처럼 명시도가 같은 규칙과 `.space-y-*`(0,3,0)에 가려지는 간격 규칙은 ①에서 틀려도 드러나지 않습니다. 이런 규칙은 ②와 ③에서야 검증됩니다. 이 순서는 D-20 설계와 맞습니다.

연구 위임 항목의 답은 다음과 같습니다. **D-10:** `list-style-type: hangul`은 두 엔진 모두 「가. 나. 다.」(마침표 포함)로 그립니다. `@counter-style` 대체는 필요 없습니다. **D-08:** `background-attachment: local` 스크롤 그림자는 두 엔진 모두 넘침 없음 → 그림자 없음, 처음 → 오른쪽만, 끝 → 왼쪽만으로 동작합니다(가장자리 픽셀 표본 확인). **D-07:** Chromium은 넘치는 스크롤 상자를 자동으로 Tab 순서에 넣지만 WebKit은 넣지 않습니다. 그래서 `tabindex="0"`이 필요합니다. 감싸는 요소는 `figure`를 권합니다.

**Primary recommendation:** 아래 「검증된 legal.css」를 `_includes/css/legal.css`로 두고 커밋 ①에서 껍데기 클래스까지 바꿉니다. ②·③은 기계적으로 진행합니다. 커밋마다 스크래치 `capture.mjs`/`diff.mjs`로 0픽셀을 확인하고, check-site 5번 항목(Tailwind 없음)은 ③ 이후에 더합니다.

## Architectural Responsibility Map

| Capability | Primary Tier | Secondary Tier | Rationale |
|------------|-------------|----------------|-----------|
| 법적 문서 스타일(토큰·초기화·본문 요소 모양) | CDN / Static (빌드 시점 Jekyll include로 `<style>`에 인라인) | Browser (렌더) | 런타임 JS(Tailwind JIT)를 없애고 빌드 시점에 확정된 정적 CSS로 옮기는 것이 이 단계의 본질 |
| 카드 껍데기(감싸는 div·article·eyebrow·h1·날짜) | Static (`_layouts/legal.html` + `rp-legal-*` 클래스) | — | 레이아웃이 그리는 부분이라 클래스를 써도 됨(CONTEXT) |
| 본문 마크업(클래스 없음) | Static (페이지 파일) | — | Phase 6~9 작성자는 텍스트·요소만 씀 |
| 넓은 표 가로 스크롤·그림자 | Browser (CSS `overflow-x`, `background-attachment: local`) | — | JS 금지(D-08). CSS만으로 두 엔진에서 동작 확인 |
| 키보드로 표 스크롤 | Browser (`tabindex="0"` 포커스 + 화살표 키) | Static (작성 규칙) | WebKit은 스크롤 상자를 자동 포커스하지 않음 → 마크업 속성으로 해결 |
| 푸시 전 회귀 차단 | 로컬 도구 (`scripts/check-site.sh`, pre-push) | — | CI 없음. `main` 푸시 = 배포 |
| 픽셀·텍스트 동일성 판정 | 로컬 스크래치 도구 (Playwright) | — | 커밋하지 않음(CONTEXT Discretion) |

## Project Constraints (from CLAUDE.md)

- `main` 푸시 = 배포(CI 없음). 모든 커밋은 그대로 라이브에 올라가도 되는 상태로 끝냅니다.
- `/privacy-policy/`, `/terms/`, `/data-deletion/` 경로와 `<title>`은 바꾸지 않습니다. 리디렉션도 걸지 않습니다. 배포할 때마다 200과 제목을 확인합니다.
- 리팩터, 시각 변경, 내용 변경을 한 단계·한 커밋에 섞지 않습니다. 이 단계는 시각(전환) 단계이고 문장은 0자도 바꾸지 않습니다.
- 푸시 전 로컬 Jekyll 3.10.0 빌드 성공(`scripts/check-site.sh`)을 확인합니다.
- 사용자가 줄 사실값을 추측해서 채우지 않습니다. 「추후 기재」 같은 자리표시 값도 쓰지 않습니다(이 단계와 직접 관계는 없음).
- JS 언어 자동 리디렉션, `robots.txt` 차단, `.nojekyll`, Jekyll i18n 플러그인은 금지합니다.
- 방침이나 구조를 바꾸는 단계는 같은 단계 안에서 `CLAUDE.md`도 고칩니다. 방침 구간은 루트와 `.claude/CLAUDE.md` 두 사본을 같은 커밋에서 똑같이 고칩니다. `.claude/CLAUDE.md`의 project·stack·conventions·architecture 구간은 원본(`.planning/codebase/*.md`, `PROJECT.md`)을 고친 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 다시 만듭니다. skills·workflow·profile 구간은 손대지 않습니다.
- 코드 규칙: 직접 만든 클래스는 `rp-` 접두사 + kebab-case. CSS 규칙은 한 줄에 하나, 공백 4칸 들여쓰기(인라인 `<style>` 안은 8칸). 구획 머리 주석은 `/* ── 이름 ── */`. 주석은 한국어 평서문입니다.
- include 공백 규칙: include 태그는 0열에 혼자 둡니다. include 파일은 끝 줄바꿈 없이 씁니다. `{%-`는 `if`/`endif`에만 씁니다.
- raw 규칙: 인라인 CSS에 이중 중괄호·중괄호-퍼센트를 쓰지 않습니다(CSS 주석 포함). `check-site.sh` 4번 항목이 출력에서 잡습니다.
- 노랑 `#F2B134`는 밝은 바탕 위 글자·선에 쓰지 않습니다. 접근성 기본값은 `:focus-visible` 3px `#1E5AA8`(「공통」)입니다.
- 새 마크다운 문서나 루트 파일·폴더를 추가하면 `_config.yml` `exclude`도 확인합니다(`_includes/` 아래 새 파일은 밑줄 폴더라 대상이 아님).
- 커밋은 Conventional Commits 형식이고, prefix는 영어, 제목은 한국어로 씁니다. 「린터 실행」은 `scripts/check-site.sh`로 갈음합니다.
- GSD 워크플로 밖에서 저장소를 직접 고치지 않습니다.

## Standard Stack

### Core (사이트 — 새 의존성 없음)
| 구성 | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| 손으로 쓴 CSS (`_includes/css/legal.css`) | — | Tailwind Play CDN 대체 | 결정 사항(빌드 도구 금지). 이 세션에서 픽셀 0으로 검증 |
| Jekyll | 3.10.0 (`Gemfile` 고정, 이 세션 `bundle exec jekyll -v` → `jekyll 3.10.0`) | include로 `<style>`에 인라인 | 운영 GitHub Pages와 같은 버전 [VERIFIED: 이 세션 빌드 4회 성공] |
| CSS 기능: `:where()`, 커스텀 속성, `list-style-type: hangul`, `background-attachment: local`, `text-underline-offset`/`text-decoration-thickness` | — | 본문 범위 초기화, 토큰, 중첩 목록, 스크롤 그림자, 링크 밑줄 | 두 엔진에서 실측 확인 |

**사이트에 설치하는 패키지는 없습니다.** 이 단계는 오히려 외부 스크립트 하나(`https://cdn.tailwindcss.com`)를 없앱니다.

### Supporting (검증 도구 — 스크래치 전용, 커밋하지 않음)
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| `playwright` | **1.59.1 고정** | Chromium·WebKit 전체 페이지 캡처, hover/focus, 계산된 스타일, 네트워크 요청 | 커밋 ①②③ 각각, 라이브 확인(D-22), 시험 본문(D-19) |
| `pngjs` [ASSUMED: 훈련 지식으로 고른 이름, seam 판정 OK] | 7.0.0 | PNG 디코딩 → 허용 오차 0 픽셀 비교 | `diff.mjs` |
| `python3 -m http.server` | Python 3.9.6 내장 | 빌드한 `_site`를 livereload 없이 서빙 | 기준·커밋별 출력 서빙 |

`playwright@1.59.1`을 고르는 이유는 이 Mac에 이미 받아 둔 브라우저(`~/Library/Caches/ms-playwright/chromium-1217`, `webkit-2272`)와 리비전이 맞기 때문입니다. 1.59.1의 `npx playwright install --dry-run`이 두 경로를 그대로 가리키는 것을 확인했습니다. 그래서 브라우저를 새로 내려받을 필요가 없습니다. 최신 1.65.1은 `chromium-1255`·`webkit-2388`을 요구하고, 이 둘은 설치돼 있지 않습니다. [VERIFIED: 이 세션 `npx playwright install --dry-run` 출력]

**Installation (스크래치, 저장소 밖):**
```bash
W="${TMPDIR:-/tmp}/rp-p3"; mkdir -p "$W/pw" && cd "$W/pw" && npm init -y >/dev/null
npm install playwright@1.59.1 pngjs@7.0.0
npx playwright install --dry-run | grep 'Install location'   # chromium-1217, webkit-2272 이 이미 있으면 다운로드 불필요
# 캐시가 지워졌다면: npx playwright install chromium webkit
```

## Package Legitimacy Audit

| Package | Registry | Age | Downloads | Source Repo | Verdict | Disposition |
|---------|----------|-----|-----------|-------------|---------|-------------|
| playwright | npm | 1.59.1 게시 2026-04-01 (seam이 본 최신판은 2026-11-13 게시) | ~173M/주 | github.com/microsoft/playwright | **[SUS]** (사유: `too-new`, 최신판 기준) | Flagged — 계획자는 설치 전 `checkpoint:human-verify`를 둠. 이 프로젝트에서 `human-verify`는 단계 끝으로 밀리므로(`human_verify_mode: end-of-phase`) 설치 전에 받아야 하면 `checkpoint:decision`으로 둠. 완화: 7개월 된 1.59.1로 고정, postinstall 없음(`npm view` 확인), 스크래치 전용, 커밋하지 않음 |
| pngjs | npm | 7.0.0 게시 2023-02-20 | ~107M/주 | github.com/pngjs/pngjs | [OK] | Approved (스크래치 전용) |

**Packages removed due to [SLOP] verdict:** none
**Packages flagged as suspicious [SUS]:** `playwright` (`too-new` 사유는 최신 게시판 기준이고, 고정하는 1.59.1에는 해당하지 않음). Phase 2에서 Playwright MCP로 이미 쓴 도구입니다. [VERIFIED: gsd-tools package-legitimacy check]

`pixelmatch`도 [OK]였지만 쓰지 않습니다. 허용 오차 0 판정에는 단순 채널 비교(`diff.mjs`)면 충분합니다.

## Architecture Patterns

### System Architecture Diagram

```
  페이지 파일 (front matter + 클래스 없는 <section>…<footer>)
        │  layout: legal
        ▼
  _layouts/legal.html ──include──▶ head-links.html (글꼴·파비콘)
        │            ──include──▶ <style> = css/common.css (「공통」, 랜딩과 공유)
        │                                 + css/legal.css  (토큰 :root, Preflight 대체, .rp-legal-* 껍데기, .rp-doc 본문 규칙)
        │            ──include──▶ header.html / footer.html (.rp-* 클래스, Preflight 불필요)
        ▼
  Jekyll 3.10.0 빌드 (로컬: check-site.sh / 운영: GitHub Pages)
        │
        ▼
  _site/<doc>/index.html  ── 정적 HTML (외부 스크립트 0, 외부 CSS는 Pretendard만)
        │
        ├──▶ 브라우저: <style> 하나로 그림 (런타임 JIT 없음)
        │        └─ 넓은 표: figure[tabindex=0] → overflow-x:auto → local/scroll 배경 그림자
        │
        └──▶ 검증(스크래치): http.server → Playwright(Chromium·WebKit × 375·768·1280)
                 → PNG·innerText·computed style·network → diff(기준 캡처, 허용 오차 0)
```

### Recommended Project Structure
```
_includes/
├── css/common.css     # 「공통」 — 이 단계에서 고치지 않음 (랜딩 출력 불변)
├── css/legal.css      # 새 파일 — 「법적 페이지 전용」 (기존 레이아웃 34~37행 묶음을 옮겨 옴)
├── head-links.html
├── header.html
└── footer.html
_layouts/
└── legal.html         # script(14행)·tailwind-config(16~30행) 제거, 껍데기 클래스 → rp-legal-*, <style>에 legal.css include
privacy-policy/index.html, terms/index.html, data-deletion/index.html   # 본문 클래스 제거, 끝 안내 p → footer
scripts/check-site.sh  # (권장) 5번 항목 「Tailwind Play CDN 없음」
```
[VERIFIED: _layouts/legal.html:14 `<script src="https://cdn.tailwindcss.com"></script>`, :16-30 `<script id="tailwind-config">`, :34-37 「법적 페이지 전용」 묶음]

### Pattern 1: 범위 선택자로 Preflight 이기기 (과도기 ①② 안전)
**What:** 본문 규칙은 모두 `.rp-doc` 아래 선택자(명시도 0,1,1 이상)로 씁니다. 초기화(margin 0)는 `.rp-doc :where(...)`(0,1,0)로 두고 간격 규칙보다 **앞에** 둡니다.
**When to use:** 이 단계의 모든 본문 규칙
**Why:** CDN `<style>`은 `<head>`의 마지막 자식으로 붙습니다. 즉 레이아웃 `<style>`보다 뒤이고, 같은 명시도면 CDN(Preflight)이 이깁니다. 측정한 `<head>` 순서는 `… LINK, SCRIPT#tailwind-config, STYLE(3184자, 레이아웃), STYLE(7582자, CDN)`였고, Chromium과 WebKit이 같았습니다. [VERIFIED: 이 세션 Playwright로 `document.head.children` 덤프]
- 요소 선택자만 쓴 규칙(`h2 {}`, `ul {}`)은 ①②에서 Preflight `h1,h2,… {font-size:inherit}`에 집니다.
- `.space-y-8 > :not([hidden]) ~ :not([hidden])`은 명시도 0,3,0이라 ①에서는 정적 간격 규칙을 가립니다. 그래서 간격 값이 맞는지는 ②에서 드러납니다.
- `html { line-height: 1.5 }`는 Preflight `:host,html {…}`와 명시도가 같고 Preflight가 뒤에 오므로 ①②에서 가려집니다. 이 값이 맞는지는 ③에서 드러납니다(절제 시험: 빼면 8~9px 차이).

### Pattern 2: 사이트 바닥글과 본문 `footer` 분리
**What:** 본문의 끝 안내는 `.rp-doc > footer`로만 잡습니다. 사이트 바닥글은 `<footer class="rp-foot">`이고 `.rp-doc` 밖에 있습니다. `a`, `p`, `aside`도 같은 방식으로 `.rp-doc` 아래로만 잡습니다.
**Why:** 맨 `footer {}` 선택자는 사이트 바닥글(`_includes/footer.html`)까지 칠합니다. 시험 본문에서 사이트 바닥글의 `border-top-width`가 0px로 유지되는 것을 확인했습니다. [VERIFIED: sample.mjs `siteFooterBorder: "0px 40px"`]

### Pattern 3: 넓은 표 감싸개 = `<figure tabindex="0" aria-label="…">`
**What:** 작성자는 아래처럼 씁니다(클래스 없음).
```html
<figure tabindex="0" aria-label="개인정보 처리 위탁 현황">
    <table>
        <thead><tr><th>수탁자</th><th>위탁 업무</th>…</tr></thead>
        <tbody><tr><td>…</td>…</tr></tbody>
    </table>
</figure>
```
**When to use:** 본문의 **모든** 표(좁은 표 포함). 폭이 넘칠지는 글자 수와 화면 폭에 달려 있어 작성자가 미리 알 수 없습니다.
**Why `figure` (not `div`):**
- `div`는 D-04 허용 요소가 아닙니다. 본문 범위의 맨 `div`를 선택자로 잡으면 앞으로 쓸 다른 용도와 부딪칩니다. `figure`는 본문에서 표 감싸개 말고 쓸 일이 없어 `.rp-doc figure` 한 줄로 안전하게 잡힙니다.
- `figure`는 암묵 role이 `figure`이고 `aria-label`로 이름을 받습니다. 그래서 `role="region"` 없이 속성 두 개로 끝납니다. Playwright `ariaSnapshot()`이 두 엔진 모두 `- figure "처리 위탁 현황": - table: …`으로 계산했습니다 [VERIFIED: 이 세션 focus3.mjs — Playwright의 role·이름 계산이고 실제 화면 낭독기 발화는 아님]. 화면 낭독기가 「figure, 처리 위탁 현황」처럼 읽는지는 [ASSUMED]입니다. Roselli 패턴(`div role="region" aria-labelledby tabindex="0"`)은 속성이 셋이고 `caption id`도 맞춰야 합니다. [CITED: adrianroselli.com/2020/11/under-engineered-responsive-tables.html]
**Why `tabindex="0"`:** 실측 결과(같은 시험 페이지, 넘치는 `div`·`figure` 두 개 + `tabindex` 붙인 것 하나 + 넘치지 않는 것 하나):
```
chromium Tab      l1* > d0* > f0* > d1* > l2* > BODY        (넘치는 스크롤 상자는 tabindex 없이도 Tab에 걸림)
webkit   Tab      d1* > BODY > d1* > BODY                    (tabindex="0"인 d1만 걸림, 링크는 건너뜀)
webkit   Alt+Tab  l1* > d1* > l2* > BODY                     (tabindex 없는 스크롤 상자 d0·f0은 끝내 안 걸림)
```
Tab으로 들어간 뒤 `ArrowRight`를 누르면 두 엔진 모두 감싸개가 가로로 스크롤됩니다(Chromium `scrollLeft` 36, WebKit 37). [VERIFIED: 이 세션 focus.mjs/focus2.mjs 실측]
- Chromium의 자동 포커스(「keyboard focusable scrollers」, Chrome 130부터)는 스크롤 상자 안에 포커스 가능한 자식(예: 표 안 링크)이 있으면 적용되지 않습니다. 따라서 Chromium에서도 `tabindex="0"`을 명시하는 편이 일관됩니다. 「Chrome 130부터」라는 버전은 검색 요약에서 본 것입니다 [CITED: developer.chrome.com/blog/keyboard-focusable-scrollers, 웹 검색 요약]. 「자식이 포커스 가능하면 적용 안 됨」은 실측으로 확인했습니다. 안에 링크가 있는 넘치는 `div`는 Chromium Tab 순서가 `l1 > inner(표 안 링크) > fig > l2`였고, 감싸개 자체에는 멈추지 않았습니다. 같은 페이지 WebKit `Alt+Tab`도 같은 순서였습니다 [VERIFIED: 이 세션 focus3.mjs].
- 실제 Safari도 Playwright WebKit과 같은지는 이 세션에서 확인하지 못했습니다. [ASSUMED] — Playwright WebKit은 macOS Safari의 기본값(Tab이 링크를 건너뜀)과 같게 동작했습니다.
- 대가: 넘치지 않는 표에도 Tab 정지점이 하나 생깁니다. 법적 문서의 표는 몇 개뿐이라 받아들일 만합니다.
- 포커스 테두리는 「공통」 `:focus-visible { outline: 3px solid #1E5AA8; outline-offset: 3px; }`이 그대로 그립니다.

### Pattern 4: CSS만으로 만드는 스크롤 그림자 (Lea Verou 기법)
**What:** 감싸개 배경을 네 겹으로 둡니다. 내용과 함께 움직이는 흰 덮개 두 겹(`local`)과 상자에 붙은 그림자 두 겹(`scroll`)입니다.
**실측 결과(가장자리 1px, 세로 중앙 픽셀):**
```
               narrow(넘침 없음)       wideStart(처음)          wideMid(가운데)          wideEnd(끝)
chromium  L 255,255,255 R 255,…  L 255,255,255 R 225,225,225  L 232 R 232  L 225,225,225 R 255,255,255
webkit    L (행 경계선)   R 255,…  L 255,255,255 R 225,225,225  L 232 R 232  L 225,225,225 R 255,255,255
```
넘치지 않으면 그림자가 없습니다. 처음에는 오른쪽만, 끝에서는 왼쪽만 보입니다. 두 엔진이 같습니다. (WebKit narrow의 왼쪽 값 228,224,214는 행 구분선 `#E4E0D6`이 세로 중앙에 걸린 것이고 그림자가 아닙니다. 캡처로 확인했습니다.) [VERIFIED: 이 세션 shadow.mjs]
**상호작용:**
- 덮개 색은 카드 바탕 `#fff`와 같아야 합니다. 카드 바탕을 바꾸면 덮개도 같이 바꿉니다.
- 그림자는 감싸개 **배경**이므로 표 칸에 바탕색을 주면 그림자가 가려집니다. D-06은 바탕색을 금지하므로 문제가 없습니다. 이 제약을 CSS 주석이나 규칙 기록에 남기기를 권합니다.
- 행 구분선과 글자는 그림자 위에 그려집니다. 의도대로입니다.
- iOS Safari 실기기 동작은 확인하지 못했습니다. [ASSUMED]

### Pattern 5: 중첩 목록 표지
`list-style-type: hangul`은 두 엔진 모두 「가. 나. 다.」(마침표 포함)로 그립니다. 같은 시험에서 `@counter-style rp-hangul { system: alphabetic; symbols: "가" … "하"; suffix: ". "; }`도 같은 모양이었지만 필요 없습니다. `lower-alpha`는 「a. b.」로 그립니다. 참고로 `korean-hangul-formal`은 「일, 이,」(쉼표)라 쓰면 안 됩니다. WebKit은 표지 뒤 공백이 Chromium보다 약간 넓은데, 이는 엔진 차이입니다. [VERIFIED: 이 세션 lists.html 2배율 캡처를 눈으로 확인]

### Anti-Patterns to Avoid
- **맨 요소 선택자(`footer {}`, `a {}`, `p {}`):** 사이트 머리말·바닥글에 새어 나갑니다. 또 ①②에서 Preflight에 집니다. → `.rp-doc` 범위로 씁니다.
- **토큰·초기화를 `common.css`에 넣기:** 랜딩 출력이 바뀝니다(결정 위반). → `legal.css`에 넣습니다. 이 세션 원안에서 랜딩 `index.html`이 ①②③ 모두 바이트 동일함을 확인했습니다.
- **`<table>`에 `display: block`:** 결정으로 금지돼 있습니다(D-07). → 감싸개에 `overflow-x: auto`를 줍니다.
- **간격 규칙을 margin 초기화보다 앞에 두거나 초기화 명시도를 높이기(`.rp-doc p { margin: 0 }`, 0,1,1):** 본문 최상위 `p`의 32px 간격(`.rp-doc > * + *`, 0,1,0)을 덮어씁니다. → 초기화는 `:where()`로 0,1,0에 맞추고 간격 규칙보다 앞에 둡니다.
- **`text-decoration` 단축 속성에 두께까지 몰아 쓰기:** WebKit의 단축 속성 지원이 불완전합니다 [ASSUMED]. → 긴 속성 네 개(`-line`·`-color`·`-thickness`·`text-underline-offset`)로 씁니다. 원안이 이 방식이고, WebKit에서 hover·기본 모두 0픽셀이었습니다.
- **기준 캡처 전에 아무 파일이나 고치기:** D-16 위반입니다. 기준은 실행 시작 커밋을 빌드한 출력으로 가장 먼저 찍습니다.

## CDN이 만든 CSS 원문 (2026-11-16, `/terms/`, 두 엔진 바이트 동일 — `cmp` 확인)

`cdn.tailwindcss.com`은 `302 → /3.4.17`이었습니다(`curl -I`). 주입 `<style>`(7582자)에서 픽셀과 관련된 부분을 그대로 옮깁니다. `--tw-*` 변수 블록은 뺐습니다. [VERIFIED: 이 세션 Playwright로 `document.querySelectorAll('style')[1].textContent` 덤프, `/* ! tailwindcss v3.4.17 | MIT License … */`]

```css
*,::after,::before{box-sizing:border-box;border-width:0;border-style:solid;border-color:#e5e7eb}
:host,html{line-height:1.5;-webkit-text-size-adjust:100%;-moz-tab-size:4;tab-size:4;font-family:ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";font-feature-settings:normal;font-variation-settings:normal;-webkit-tap-highlight-color:transparent}
body{margin:0;line-height:inherit}
h1,h2,h3,h4,h5,h6{font-size:inherit;font-weight:inherit}
a{color:inherit;text-decoration:inherit}
b,strong{font-weight:bolder}
table{text-indent:0;border-color:inherit;border-collapse:collapse}
blockquote,dd,dl,figure,h1,h2,h3,h4,h5,h6,hr,p,pre{margin:0}
menu,ol,ul{list-style:none;margin:0;padding:0}
audio,canvas,embed,iframe,img,object,svg,video{display:block;vertical-align:middle}
img,video{max-width:100%;height:auto}
[hidden]:where(:not([hidden=until-found])){display:none}
.mx-auto{margin-left:auto;margin-right:auto}.mt-10{margin-top:2.5rem}.mt-3{margin-top:0.75rem}.mt-3\.5{margin-top:0.875rem}.max-w-\[800px\]{max-width:800px}.list-disc{list-style-type:disc}
.space-y-1 > :not([hidden]) ~ :not([hidden]){--tw-space-y-reverse:0;margin-top:calc(0.25rem * calc(1 - var(--tw-space-y-reverse)));margin-bottom:calc(0.25rem * var(--tw-space-y-reverse))}
.space-y-3 > :not([hidden]) ~ :not([hidden]){…0.75rem…}
.space-y-8 > :not([hidden]) ~ :not([hidden]){…2rem…}
.rounded-\[28px\]{border-radius:28px}.border-\[1\.5px\]{border-width:1.5px}.border-t{border-top-width:1px}.border-line{--tw-border-opacity:1;border-color:rgb(228 224 214 / var(--tw-border-opacity, 1))}.bg-white{--tw-bg-opacity:1;background-color:rgb(255 255 255 / var(--tw-bg-opacity, 1))}
.p-7{padding:1.75rem}.px-6{padding-left:1.5rem;padding-right:1.5rem}.py-\[clamp\(48px\2c 6vw\2c 80px\)\]{padding-top:clamp(48px,6vw,80px);padding-bottom:clamp(48px,6vw,80px)}.pl-5{padding-left:1.25rem}.pt-4{padding-top:1rem}
.text-\[13px\]{font-size:13px}.text-\[clamp\(30px\2c 6\.5vw\2c 42px\)\]{font-size:clamp(30px,6.5vw,42px)}.text-sm{font-size:0.875rem;line-height:1.25rem}.text-xl{font-size:1.25rem;line-height:1.75rem}
.font-black{font-weight:900}.font-bold{font-weight:700}.font-semibold{font-weight:600}.leading-\[1\.25\]{line-height:1.25}.leading-\[1\.7\]{line-height:1.7}.tracking-\[-1px\]{letter-spacing:-1px}.tracking-\[0\.04em\]{letter-spacing:0.04em}
.text-accent{…rgb(124 88 13…)}.text-ink{…rgb(43 43 43…)}.text-muted{…rgb(74 70 63…)}.text-muted-2{…rgb(87 83 76…)}
.underline{-webkit-text-decoration-line:underline;text-decoration-line:underline}.decoration-accent{-webkit-text-decoration-color:#7C580D;text-decoration-color:#7C580D}.decoration-2{text-decoration-thickness:2px}.underline-offset-4{text-underline-offset:4px}
.transition-colors{transition-property:color, background-color, border-color, fill, stroke, -webkit-text-decoration-color;transition-property:color, background-color, border-color, text-decoration-color, fill, stroke;transition-property:color, background-color, border-color, text-decoration-color, fill, stroke, -webkit-text-decoration-color;transition-timing-function:cubic-bezier(0.4, 0, 0.2, 1);transition-duration:150ms}
.hover\:text-accent:hover{…rgb(124 88 13…)}
@media (min-width: 768px){.md\:p-12{padding:3rem}}
```
- 위 Preflight는 `unpkg.com/tailwindcss@3.4.17/src/css/preflight.css`(386행) 원문과 같습니다. `theme('borderColor.DEFAULT')`는 `#e5e7eb`, `fontFamily.sans`는 `ui-sans-serif…`로 풀렸습니다. 기본 테마 값 `sm: ['0.875rem', { lineHeight: '1.25rem' }]`, `xl: ['1.25rem', { lineHeight: '1.75rem' }]`, `md: '768px'`, `transitionProperty.colors`, `transitionDuration.DEFAULT: '150ms'`, `transitionTimingFunction.DEFAULT: 'cubic-bezier(0.4, 0, 0.2, 1)'`는 `tailwindcss@3.4.17` 패키지의 `stubs/config.full.js`와 같습니다. [VERIFIED: npm pack tailwindcss@3.4.17, config.full.js:303-330,815-822,934-965]
- 사용 중인 유틸리티 클래스는 **41개**입니다(+ `rp-grid`). 파일에서 직접 뽑았습니다. `text-ink`(24회) `font-bold`(21) `text-xl`(20) `space-y-3`(20) `space-y-1`(5) `pl-5`(5) `list-disc`(5) `text-sm`(4) `text-muted-2`(4) `font-semibold`(4) `border-line`(4) `underline-offset-4`·`underline`·`transition-colors`·`pt-4`·`hover:text-accent`·`decoration-accent`·`decoration-2`·`border-t`(각 3) 그리고 1회씩 `tracking-[0.04em]` `tracking-[-1px]` `text-muted` `text-accent` `text-[clamp(30px,6.5vw,42px)]` `text-[13px]` `space-y-8` `rounded-[28px]` `py-[clamp(48px,6vw,80px)]` `px-6` `p-7` `mx-auto` `mt-3.5` `mt-3` `mt-10` `md:p-12` `max-w-[800px]` `leading-[1.7]` `leading-[1.25]` `font-black` `border-[1.5px]` `bg-white`. [VERIFIED: grep -oh 'class="…"' _layouts/legal.html privacy-policy/index.html terms/index.html data-deletion/index.html]

### Preflight 규칙별 판정 (법적 페이지, 헤더·푸터 포함)

| Preflight 규칙 | 픽셀 영향 | 대체 방법 (원안) | 근거 |
|---|---|---|---|
| `html { line-height: 1.5 }` | **있음** — 날짜 `p`(13px×1.5)와 eyebrow 줄 상자(부모 article 1.5의 strut) | `html { line-height: 1.5; … }` (legal.css) | 절제: 빼면 페이지 높이 −8~−9px (양 엔진, 4건 모두) |
| `h1,h2,p,ul,… { margin: 0 }`, `ul { padding: 0 }` | **있음** | `.rp-doc :where(h2, h3, p, ul, ol, dl, dd, figure) { margin: 0; }`, `.rp-legal-title { margin: 14px 0 0 }`, `.rp-legal-updated { margin: 12px 0 0 }`, 목록 `padding-left: 20px` | 절제: 본문 초기화를 빼면 +13~+51px, 제목 margin 단축 대신 `margin-top`만 쓰면 +8~+16px |
| `h1-h6 { font-size/weight: inherit }` | 없음(값을 모두 명시) | `h1`·`h2`·`h3` 크기·굵기 명시 | ③ 0픽셀 |
| `a { color: inherit; text-decoration: inherit }` | 본문 링크는 없음(명시). 헤더·푸터 링크는 `common.css`가 이미 `color`·`text-decoration` 명시 | `.rp-doc a { … }` | ③ 0픽셀(기본·hover·focus) |
| `*` 테두리 3값 | 카드·끝 안내 선의 `border-style: solid`만 의미 있음 | `border: 1.5px solid var(--rp-line)`, `border-top: 1px solid var(--rp-line)` 단축 속성 | ③ 0픽셀 |
| `svg { display: block; vertical-align: middle }` | **없음** — 로고 SVG는 `.rp-brand-tile`(`display: grid`)의 grid 항목이라 이미 블록화 | 옮기지 않음 | 절제: v3에 `svg{display:block}`을 더해도 0픽셀 |
| `body { margin: 0; line-height: inherit }` | 없음(`common.css`가 `margin: 0`, line-height는 원래 상속) | — | ③ 0픽셀 |
| `b,strong { font-weight: bolder }` | 없음(600 명시) | `.rp-doc strong` | — |
| `-webkit-tap-highlight-color: transparent`, `tab-size: 4`, `font-feature/variation-settings: normal` | 캡처 영향 없음 | `html`에 옮김(같은 동작, Discretion 권고) | — |
| `table { text-indent: 0; border-collapse: collapse }` | 새 요소(표)용 | `.rp-doc table`에 포함 | — |
| 나머지(폼 요소, `hr`, `abbr`, `sub/sup`, `[hidden]` 등) | 법적 페이지에 해당 요소 없음 | 옮기지 않음 | — |

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| 가. 나. 다. 표지 | `::before` + `counter()` 직접 구성, `@counter-style` | `list-style-type: hangul` | 두 엔진에서 이미 마침표 포함으로 그려짐(실측) |
| 스크롤 그림자 | JS 스크롤 감시, IntersectionObserver | `background-attachment: local` + `scroll` 네 겹 | JS 금지(D-08), 두 엔진 실측 동작 |
| 키보드 스크롤 | JS 키 핸들러 | `tabindex="0"`(브라우저 기본 화살표 스크롤) | 두 엔진에서 화살표 스크롤 실측 |
| 픽셀 비교 | 눈 비교, 허용 오차 있는 도구 기본값 | `pngjs` 디코드 + 채널 비교(허용 오차 0) | D-13 |
| Tailwind 값 추정 | 기억이나 문서로 값 재구성 | CDN 주입 `<style>`을 그대로 덤프(위 원문) | 실제로 적용된 CSS가 정본 |

**Key insight:** 이 단계의 위험은 「값을 잘못 옮기는 것」보다 「과도기 캐스케이드가 실수를 가리는 것」입니다. 그래서 값은 CDN 덤프에서 옮기고, 커밋마다 따로 픽셀 0을 확인합니다.

## Runtime State Inventory

| Category | Items Found | Action Required |
|----------|-------------|------------------|
| Stored data | None. 서버·DB가 없는 정적 사이트 [VERIFIED: CLAUDE.md, 저장소 구조] | 없음 |
| Live service config | GitHub Pages 배포 설정(브랜치 `main`, `CNAME`)은 바뀌지 않습니다. 브라우저·CDN 캐시: GitHub Pages `cache-control: max-age=600` [VERIFIED: curl -I 이 세션]. Tailwind CDN 응답은 `max-age=14400`이지만 제거 뒤에는 요청되지 않음 | 라이브 확인 때 `?cb=<커밋>` 쿼리로 우회(D-22) |
| OS-registered state | `.githooks/pre-push`(`core.hooksPath`)는 `$TOP/scripts/check-site.sh`를 **작업 트리 판**으로 부르고 푸시하는 **끝 커밋 하나만** 빌드합니다 [VERIFIED: .githooks/pre-push:12] | 아래 Pitfall 4 참고 |
| Secrets/env vars | None | 없음 |
| Build artifacts | 로컬 `_site/`, `.jekyll-cache/`(gitignore). 스크래치 캡처 폴더 | `jekyll serve`로 본 뒤라면 다시 빌드. 스크래치는 커밋하지 않음 |

## Common Pitfalls

### Pitfall 1: 과도기 커밋에서 실수가 가려짐
**What goes wrong:** ①에서 0픽셀이 나왔는데 ③에서 깨집니다.
**Why it happens:** CDN `<style>`이 뒤에 오므로 명시도가 같거나 높은 Tailwind 규칙(`html` line-height, `.space-y-*` 0,3,0)이 정적 규칙을 가립니다.
**How to avoid:** 커밋마다 따로 판정합니다(D-20). 실행자는 ① 단계에서도 「③ 미리보기」(①의 출력 HTML에서 script·config 두 블록만 지운 사본)를 한 번 찍어 보면 문제를 일찍 찾을 수 있습니다(선택).
**Warning signs:** ③에서 `SIZE` 차이(페이지 높이 변화)가 납니다. 절제 시험에서 원인별 높이 변화는 line-height −8~9px, 본문 margin +13~51px, 제목 margin +8~16px였습니다.

### Pitfall 2: WebKit에서 focus 캡처가 비어 있음
**What goes wrong:** WebKit은 `Tab`이 링크를 건너뛰어 본문 링크에 포커스가 가지 않습니다. 그래도 「focus 캡처 0픽셀」은 통과합니다(둘 다 포커스 없음).
**How to avoid:** WebKit은 `Alt+Tab`으로 이동합니다. `tabReached && focusVisible`이 참인지 단정합니다. 또 `states.mjs`로 hover/focus 캡처가 기본 캡처와 **달라야** 함을 확인합니다. 이 세션 결과는 24장 모두 달랐습니다(793~852픽셀).

### Pitfall 3: `footer`·`a` 선택자가 사이트 바닥글을 칠함
**How to avoid:** `.rp-doc > footer`, `.rp-doc a`. 시험 본문 자동 확인에 `footer.rp-foot`의 `border-top-width: 0px`를 넣습니다.

### Pitfall 4: check-site 5번 항목을 ③보다 먼저 넣음
**What goes wrong:** ①·② 커밋은 아직 CDN이 있으므로, 새 판 스크립트로 `scripts/check-site.sh <①>`을 돌리면 실패합니다.
**How to avoid:** 5번 항목은 ③과 같은 커밋이나 ③ 뒤 커밋에 넣습니다. pre-push 훅은 끝 커밋만 점검하므로 ①②③+스크립트를 한 번에 푸시해도 훅은 통과합니다. 다만 실행자가 커밋별로 손으로 점검할 때는 그 커밋 시점의 스크립트로 돌립니다(`git show <커밋>:scripts/check-site.sh`를 임시 파일로 꺼내 실행하거나, 스크립트 변경 전 판 사용).

### Pitfall 5: 텍스트 추출 방식 차이
**What goes wrong:** `<p>` → `<footer>`로 바꾸면 원문 앞뒤 공백이 그대로라 `textContent`가 미세하게 달라질 수 있습니다.
**How to avoid:** `article.innerText`(렌더 기준)로 비교합니다. 이 세션에서 ② 변환 뒤 18건 모두 바이트 동일했습니다. `footer` 안에 `<p>`를 두지 않고 글을 바로 넣어도 같습니다. 원안은 `<p>` 없이 직접 넣는 방식입니다.

### Pitfall 6: 기준을 `jekyll serve --livereload`로 찍음
**Why:** livereload 스크립트가 응답에 끼고, Playwright MCP 로그가 새로 고침을 반복시킵니다(STATE 메모).
**How to avoid:** 운영과 같은 production·`--safe` 빌드를 스크래치 폴더에 만들고 `python3 -m http.server`로 띄웁니다. `check-site.sh`는 끝나면 임시 출력(`trap rm -rf`)을 지우므로 캡처용 빌드는 따로 만들어야 합니다(아래 명령).

### Pitfall 7: 표 칸 글이 좁은 화면에서 지나치게 접힘
**What:** `body { word-break: keep-all }`(common.css) 때문에 375px에서 넓은 표의 칸 글이 어절 단위로 여러 줄 접히고, 머리 행도 「처리 / 항목」처럼 접힙니다(시험 본문 캡처에서 확인). 페이지 자체는 밀리지 않습니다(`scrollWidth` 375).
**How to avoid:** D-06 Discretion입니다. 머리 행만 `white-space: nowrap`을 주면 머리 행은 한 줄을 유지하고 넘치는 부분은 감싸개 스크롤로 갑니다. 사용자 승인 캡처(D-19)에서 고르게 합니다.

## Code Examples

### 검증된 `_includes/css/legal.css` 원안 (커밋 ①~③에서 0픽셀 확인)
끝 줄바꿈 없이 저장합니다(include 공백 규칙). `{{`·`{%`는 없습니다.
```css
        /* ── 법적 페이지 전용 ──
           법적 문서(_layouts/legal.html)만 이 묶음을 _includes/css/legal.css 에서 불러 쓴다. 랜딩은 쓰지 않는다.
           본문(.rp-doc 안)은 클래스 없이 쓴다. 쓸 수 있는 요소: section h2 h3 p ul ol li dl dt dd table thead tbody tr th td figure strong a aside footer.
           조항마다 section 하나, 첫 자식은 h2. 넓은 표는 figure tabindex="0" aria-label="표 이름" 으로 감싼다. 목록에 없는 요소가 필요하면 여기 CSS와 CLAUDE.md 규칙을 함께 고친다. */
        :root { --rp-ink: #2B2B2B; --rp-accent: #7C580D; --rp-muted: #4A463F; --rp-muted-2: #57534C; --rp-line: #E4E0D6; }
        html { line-height: 1.5; -moz-tab-size: 4; tab-size: 4; -webkit-tap-highlight-color: transparent; }
        body { min-height: 100vh; display: flex; flex-direction: column; }
        main { flex: 1 0 auto; }
        .rp-grid { background-color: #F5F9FC; background-image: linear-gradient(#D3E2EF 1px, transparent 1px), linear-gradient(90deg, #D3E2EF 1px, transparent 1px); background-size: 32px 32px; }
        .rp-legal-wrap { max-width: 800px; margin-left: auto; margin-right: auto; padding: clamp(48px, 6vw, 80px) 24px; }
        .rp-legal-card { border: 1.5px solid var(--rp-line); border-radius: 28px; background: #fff; padding: 28px; }
        .rp-legal-eyebrow { font-size: 14px; line-height: 20px; font-weight: 700; letter-spacing: 0.04em; color: var(--rp-accent); }
        .rp-legal-title { margin: 14px 0 0; font-size: clamp(30px, 6.5vw, 42px); font-weight: 900; line-height: 1.25; letter-spacing: -1px; }
        .rp-legal-updated { margin: 12px 0 0; font-size: 13px; color: var(--rp-muted-2); }
        .rp-doc { margin-top: 40px; line-height: 1.7; color: var(--rp-muted); }
        .rp-doc :where(h2, h3, p, ul, ol, dl, dd, figure) { margin: 0; }
        .rp-doc > * + * { margin-top: 32px; }
        .rp-doc section > * + * { margin-top: 12px; }
        .rp-doc h2 { font-size: 20px; line-height: 28px; font-weight: 700; color: var(--rp-ink); }
        .rp-doc h3 { font-size: 17px; line-height: 24px; font-weight: 700; color: var(--rp-ink); }
        .rp-doc :where(ul, ol) { padding-left: 20px; }
        .rp-doc ul { list-style-type: disc; }
        .rp-doc ol { list-style-type: decimal; }
        .rp-doc li + li, .rp-doc li > :where(ul, ol) { margin-top: 4px; }
        .rp-doc :where(ul, ol) ul { list-style-type: circle; }
        .rp-doc :where(ul, ol) ol { list-style-type: hangul; }
        .rp-doc :where(ul, ol) ol:lang(en) { list-style-type: lower-alpha; }
        .rp-doc dt { font-weight: 700; color: var(--rp-ink); }
        .rp-doc strong { font-weight: 600; color: var(--rp-ink); }
        .rp-doc a { font-weight: 600; color: var(--rp-ink); text-decoration-line: underline; text-decoration-color: var(--rp-accent); text-decoration-thickness: 2px; text-underline-offset: 4px; transition-property: color, background-color, border-color, text-decoration-color, fill, stroke, -webkit-text-decoration-color; transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1); transition-duration: 150ms; }
        .rp-doc a:hover { color: var(--rp-accent); }
        .rp-doc aside { font-size: 14px; line-height: 20px; color: var(--rp-muted-2); }
        .rp-doc > footer { padding-top: 16px; border-top: 1px solid var(--rp-line); font-size: 14px; line-height: 20px; color: var(--rp-muted-2); }
        .rp-doc figure { overflow-x: auto; background: linear-gradient(to right, #fff 30%, rgb(255 255 255 / 0)) left center / 40px 100% no-repeat local, linear-gradient(to left, #fff 30%, rgb(255 255 255 / 0)) right center / 40px 100% no-repeat local, radial-gradient(farthest-side at 0 50%, rgb(43 43 43 / 0.16), rgb(43 43 43 / 0)) left center / 12px 100% no-repeat scroll, radial-gradient(farthest-side at 100% 50%, rgb(43 43 43 / 0.16), rgb(43 43 43 / 0)) right center / 12px 100% no-repeat scroll; background-color: #fff; }
        .rp-doc table { width: 100%; border-collapse: collapse; text-indent: 0; font-size: 14px; line-height: 20px; }
        .rp-doc :where(th, td) { padding: 10px 16px 10px 0; text-align: left; vertical-align: top; border-bottom: 1px solid var(--rp-line); }
        .rp-doc th { font-weight: 700; color: var(--rp-ink); }
        @media (min-width: 768px) { .rp-legal-card { padding: 48px; } }
```
메모:
- `transition-property`는 CDN의 마지막 선언을 그대로 옮겼습니다. 계산된 값이 기준과 엔진별로 같습니다. Chromium은 `"…, stroke, -webkit-text-decoration-color"`, WebKit은 `"…, stroke, text-decoration-color"`로 나옵니다(WebKit은 별칭을 풀어 씀). 기준과 ③이 엔진마다 문자열까지 같습니다. [VERIFIED: capture.mjs report.json, base1 vs v3]
- 그림자 색 `rgb(43 43 43 / 0.16)`은 `ink`(#2B2B2B)에 투명도를 준 값입니다. hex 변수에는 투명도를 줄 수 없어 숫자로 썼습니다. 새 색이 아니라는 주석을 남기기를 권합니다. `#fff`는 카드 바탕과 같아야 합니다.
- 표 칸 여백(10px 16px 10px 0), `h3` 줄 높이 24px, `dt` 700, 중첩 목록 위 4px, 머리 행 아래 선(행 선과 같은 1px)은 Discretion 항목의 **제안값**입니다. 기존 페이지 픽셀에는 영향이 없고, D-19 캡처 승인 대상입니다.
- `ul` 안의 `ol`은 `:where(ul, ol) ol` 규칙에 걸려 가. 나. 다.로, `ol` 안의 `ul`은 ○로 나옵니다(D-10 「섞인 경우」 제안).

### `_layouts/legal.html` (커밋 ③ 뒤 모습, 스크래치 빌드에서 0픽셀)
```html
    <meta name="theme-color" content="#F2B134" />
{% include head-links.html %}
    <style>
{% include css/common.css %}

{% include css/legal.css %}
    </style>
</head>

<body>
{% include header.html %}

    <main class="rp-grid">
        <div class="rp-legal-wrap">
            <article class="rp-legal-card">
                <span class="rp-legal-eyebrow">{{ page.eyebrow }}</span>
                <h1 class="rp-legal-title">{{ page.heading | default: page.title }}</h1>
                {%- if page.updated %}
                <p class="rp-legal-updated">최종 업데이트: {{ page.updated }}</p>
                {%- endif %}
                <div class="rp-doc">
{{ content | rstrip }}
                </div>
            </article>
        </div>
    </main>
```
- 커밋 ①은 위 모습에서 14행 `<script src="https://cdn.tailwindcss.com"></script>`와 16~30행 `<script id="tailwind-config">…</script>`가 아직 남아 있는 상태입니다(이 세션의 v1). 원래 34~37행 「법적 페이지 전용」 묶음은 `legal.css`로 옮겼습니다.
- 껍데기 클래스는 ①에서 바꾸기를 권합니다. ①이 「Preflight가 있는 상태에서 정적 껍데기가 같은가」를, ③이 「Preflight 없이도 같은가」를 따로 검증하게 됩니다. 이 세션에서 그렇게 해서 ①②③ 모두 0이었습니다.

### 본문 변환 (커밋 ②, 문서 세 개 공통 치환 6종)
```
<section class="space-y-3">                     → <section>
<h2 class="text-xl font-bold text-ink">          → <h2>
<ul class="list-disc space-y-1 pl-5">            → <ul>
<a href="…" class="font-semibold text-ink underline decoration-accent decoration-2 underline-offset-4 transition-colors hover:text-accent">  → <a href="…">
<strong class="font-semibold text-ink">          → <strong>
<p class="border-t border-line pt-4 text-sm text-muted-2">…</p>  → <footer>…</footer>   (안쪽 글·줄바꿈 그대로)
```
변환 뒤 front matter 아래 본문에 `class=`가 0건이어야 합니다. 이 세션에서 돌려 본 명령입니다. 현재 저장소에서는 16·27·9건, ② 재현 사본에서는 0·0·0건이 나왔습니다.
```bash
for pg in privacy-policy terms data-deletion; do printf '%s ' $pg; awk 'n>=2; /^---$/{n++}' "$pg/index.html" | grep -c 'class='; done   # 모두 0 (grep -c 0은 종료 코드 1)
```

### check-site.sh 5번 항목 (③ 이후 커밋)
```bash
# ── 5. Tailwind Play CDN 없음 ──
# 법적 페이지는 정적 CSS(_includes/css/legal.css)로 그린다. 런타임 스크립트가 다시 들어오면 막는다.
tw=$(grep -rlF -e 'cdn.tailwindcss.com' -e 'tailwind.config' --include='*.html' "$DEST" 2>/dev/null)
[ -n "$tw" ] && problem "Tailwind Play CDN이 출력에 남아 있습니다: ${tw//$DEST/}"
```
같은 grep을 이 세션에서 돌려 보니 기준 출력에서는 `/privacy-policy/index.html /terms/index.html /data-deletion/index.html`이 걸렸고, ③ 출력에서는 0건이었습니다. [VERIFIED: 이 세션]
함께 고칠 곳(「넷」/「네 가지」/「4번 항목」 언급, 이 세션 grep):
- `scripts/check-site.sh:2` 「네 가지를 확인한다」와 `:3-6` 목록에 5번 줄을 더합니다. [VERIFIED: scripts/check-site.sh:2-6 Read]
- `README.md:10` `# 푸시 전 점검 (빌드·내부 파일·제목·Liquid 잔여)`에 Tailwind를 덧붙입니다.
- `CLAUDE.md:118` Deploy 문단의 확인 항목 나열(「…처리되지 않은 Liquid가 없음을 확인합니다」)
- `.planning/codebase/CONVENTIONS.md:49` 「점검 항목은 넷이다」, `.planning/codebase/TESTING.md:12` 「네 가지를 본다」 → 원본 맵 수정 뒤 `generate-claude-md`(`.claude/CLAUDE.md:150`에 반영)
- 「4번 항목」(Liquid)을 번호로 인용하는 곳(`CLAUDE.md:65`, `CONVENTIONS.md:154`, `ARCHITECTURE.md:131`, `.claude/CLAUDE.md:365`)은 새 항목을 **5번**으로 붙이면 고칠 필요가 없습니다.
- `.githooks/pre-push` 머리 주석(1~3행)에는 항목 수가 없습니다. 바꿀 필요는 없습니다.
- `CONCERNS.md:95`, `STRUCTURE.md:113`의 「넷」은 기존 URL 수라 이 변경과 관계없습니다.

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Tailwind Play CDN 런타임 JIT(버전 미고정, 렌더 차단 스크립트) | 빌드 시점 인라인 정적 CSS | 이 단계 | 외부 스크립트 실행 0, 「should not be used in production」 콘솔 경고 사라짐(Phase 2 UAT 기록) |
| 스크롤 상자 키보드 접근에 `tabindex` 필수 | Chromium 130+는 넘치는 스크롤 상자를 자동 포커스(자식 포커스 요소가 없을 때만). WebKit은 아직 아님(Playwright WebKit 실측) | Chrome 130 | 크로스 엔진 일관성 때문에 `tabindex="0"`은 여전히 필요 |
| `-webkit-text-decoration-*` 접두사 | 접두사 없는 긴 속성 | — | WebKit에서 접두사 없이 0픽셀 확인 |

**Deprecated/outdated:**
- `.planning/research/STACK.md` (a)의 본문 의미 클래스(`.rp-legal-body`) 안: CONTEXT에서 클래스 없는 본문으로 대체됐습니다.

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | 실제 macOS/iOS Safari도 Playwright WebKit처럼 넘치는 스크롤 상자를 자동 포커스하지 않고, `tabindex="0"`이면 Tab으로 닿는다 | Pattern 3 | 낮음 — 틀려도 `tabindex="0"`은 해가 없음 |
| A2 | iOS Safari 실기기에서도 `background-attachment: local` 스크롤 그림자가 데스크톱 WebKit처럼 동작한다 | Pattern 4 | 낮음 — 그림자는 장식이고, 스크롤 자체는 영향 없음 |
| A3 | WebKit의 `text-decoration` 단축 속성(두께 포함) 지원이 불완전하다 | Anti-Patterns | 없음 — 원안은 긴 속성을 써서 이 가정에 기대지 않음 |
| A4 | 운영 GitHub Pages 빌드가 로컬 Jekyll 3.10.0과 같은 바이트를 낸다(새 include 파일 포함) | Validation | 중간 — D-22 라이브 픽셀 비교가 잡음. Phase 2의 네 번 배포에서 차이 없었고, 이 세션에서도 현재 라이브와 로컬 기준이 2엔진 × 3폭 × 3문서 0픽셀이었음(새 파일 `legal.css`가 생긴 뒤의 운영 빌드는 아직 미확인) |
| A5 | `:where()`·`rgb(r g b / a)` 문법을 심사자 브라우저가 지원한다(Safari 14+, Chrome 88+ 수준) | Code Examples | 낮음 — 심사자는 최신 브라우저를 씀 |
| A6 | 화면 낭독기가 `figure tabindex="0" aria-label`을 「figure + 이름」으로 읽는다(Playwright 계산값만 확인) | Pattern 3 | 낮음 — 바뀌어도 `role="region"`을 더하는 작은 수정 |
| A7 | Chromium 자동 포커스 스크롤 상자가 Chrome 130부터라는 버전 정보(검색 요약 출처) | Pattern 3 | 없음 — 권고(`tabindex="0"` 명시)는 버전과 무관 |
| A8 | `pngjs`라는 패키지 이름은 훈련 지식에서 골랐다(seam 판정 OK, 스크래치 전용) | Standard Stack | 낮음 — 스크래치 도구 |

## Open Questions (RESOLVED)

1. **표 칸 접힘 정책 (D-06 Discretion)** — RESOLVED: 03-05 Task 2(`checkpoint:decision`)에서 두 변형 캡처를 보여 주고 사용자가 `plain`·`nowrap`을 고르며, 03-05 Task 3이 고른 값을 적용합니다(`TABLE_WRAP=plain|nowrap`)
   - What we know: 375px에서 `keep-all` 때문에 칸 글이 여러 줄로 접히고 머리 행도 접힙니다. 페이지는 밀리지 않습니다.
   - What's unclear: 머리 행 `nowrap`, 칸 최소 폭 같은 취향 문제가 남아 있습니다.
   - Recommendation: 원안(접힘 허용)과 `th { white-space: nowrap }` 변형을 D-19 캡처에 함께 보여 주고 사용자가 고르게 합니다.
2. **D-20 ②를 문서별로 나눌지** — RESOLVED: 나누지 않고 커밋 하나로 합니다(03-03-PLAN.md context 「이 계획에서 정한 것」)
   - What we know: 치환은 6종으로 같고 한 번에 해도 0픽셀입니다.
   - Recommendation: 커밋 하나로 합니다. 판정 실행(약 3분) 횟수를 줄입니다. 나누더라도 문서 하나만 바꾼 커밋은 나머지 두 문서가 그대로라 판정이 쉽습니다.
3. **표 감싸개 속성 강제** — RESOLVED: CSS로 강제하지 않습니다. 규칙 기록과 「첫 표가 들어가는 단계의 검증에서 `<figure`마다 `tabindex="0"`과 `aria-label`을 grep으로 확인」 문장은 03-07 Task 1 action 2(d)가 CONVENTIONS.md 「법적 본문 작성 규칙」에 적고, CSS 머리 주석은 03-02 Task 1 action 2가 씁니다
   - What we know: CSS는 `figure`에 속성이 없어도 스크롤을 줍니다(D-07의 「페이지가 밀리지 않음」을 우선).
   - Recommendation: 이 단계에서는 규칙 기록(D-25)과 CSS 주석으로만 둡니다. 첫 표가 들어가는 Phase 7 검증에 「`<figure`마다 `tabindex="0"`과 `aria-label`」 grep을 넣도록 메모합니다.

## Environment Availability

| Dependency | Required By | Available | Version | Fallback |
|------------|------------|-----------|---------|----------|
| Homebrew Ruby + Bundler | Jekyll 빌드 | ✓ | ruby 4.0.9, `/opt/homebrew/bin/bundle` | — |
| Jekyll | 빌드·check-site | ✓ | 3.10.0 (이 세션 빌드 성공) | — |
| Node.js / npm | Playwright 스크립트 | ✓ | v24.14.0 / 11.11.0 | — |
| Playwright 브라우저 캐시 | 캡처 | ✓ | chromium-1217 (Chromium 147.0.7727.15), webkit-2272 | `npx playwright install chromium webkit` (네트워크 필요) |
| `playwright` npm 패키지 | 캡처 | 저장소엔 없음(스크래치 설치) | 1.59.1 고정 | — |
| Python 3 | 정적 서버 | ✓ | 3.9.6 | `npx http-server` 등 |
| 인터넷(Pretendard CDN, 기준 캡처 때 Tailwind CDN) | 캡처 | ✓ | `cdn.tailwindcss.com` → 302 `/3.4.17` | 없음 — 기준 캡처는 온라인 필수 |
| `gh` | D-22 배포 완료 확인 | ✓ | 2.104.0 (`/opt/homebrew/bin/gh`) | GitHub 웹 Actions 화면 |
| Python `playwright` | — | ✗ | — | Node 판을 씀 |

**Missing dependencies with no fallback:** 없음
**Missing dependencies with fallback:** 없음(Playwright npm은 스크래치에 설치)

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | 스크래치 Node 스크립트 + Playwright 1.59.1 + pngjs 7.0.0 (커밋하지 않음) + `scripts/check-site.sh`(저장소) |
| Config file | 없음 — 아래 「Wave 0」 스크립트를 `$TMPDIR/rp-p3/pw/`에 만듭니다 |
| Quick run command | `scripts/check-site.sh <커밋>` (빌드·내부 파일·제목·Liquid, ③ 이후 Tailwind) |
| Full suite command | 아래 「빌드·서빙」 블록의 커밋별 한 줄 (빌드 → 서빙 → `capture.mjs` → `diff.mjs` + `states.mjs` + `report.mjs`), 약 3분 |

### 빌드·서빙 (기준·커밋별 공통)
`build`·`serve` 두 함수는 이 세션에서 `$TMPDIR` 아래에서 실제로 돌려 봤습니다(빌드 성공, 서빙 200).
```bash
W="${TMPDIR:-/tmp}/rp-p3"; mkdir -p "$W"; W=$(cd "$W" && pwd -P)   # macOS $TMPDIR는 심볼릭 링크 → 실제 경로로 (check-site.sh:42-43과 같은 이유: --safe 빌드의 include 거부)
REPO=$(git rev-parse --show-toplevel)   # 저장소 안에서 실행
build() {  # build <이름> <커밋>
  rm -rf "${W:?}/${1:?}" && mkdir -p "$W/$1/src" && git -C "$REPO" archive --format=tar "$2" | tar -x -C "$W/$1/src" \
  && ( cd "$W" && BUNDLE_GEMFILE="$REPO/Gemfile" JEKYLL_ENV=production bundle exec jekyll build --safe -s "$W/$1/src" -d "$W/$1/site" >/dev/null )
}
serve() {  # serve <이름> <포트> — 응답할 때까지 기다린다
  ( cd "$W/$1/site" && python3 -m http.server "$2" --bind 127.0.0.1 >/dev/null 2>&1 & )
  for i in $(seq 1 50); do curl -s -o /dev/null "http://127.0.0.1:$2/terms/" && return 0; sleep 0.2; done; return 1
}
# 기준(D-16): 실행 시작 커밋을 어떤 변경보다 먼저
BASE_SHA=$(git -C "$REPO" rev-parse HEAD); curl -sI https://cdn.tailwindcss.com | grep -i '^location'   # → /3.4.17 기록
build base "$BASE_SHA" && serve base 4101
cd "$W/pw" && node capture.mjs http://127.0.0.1:4101 "$W/cap/base1" && node capture.mjs http://127.0.0.1:4101 "$W/cap/base2" \
  && node diff.mjs "$W/cap/base1" "$W/cap/base2"     # 자기 차이 0 (아니면 D-13대로 멈추고 사용자에게 알림)
node states.mjs "$W/cap/base1"                        # hover/focus 캡처가 기본과 달라야 함
# 커밋별(①②: 아래 그대로, ③: report.mjs 끝에 --no-cdn)
build c1 <①커밋> && serve c1 4102 && node capture.mjs http://127.0.0.1:4102 "$W/cap/c1" \
  && node diff.mjs "$W/cap/base1" "$W/cap/c1" && node states.mjs "$W/cap/c1" && node report.mjs "$W/cap/base1" "$W/cap/c1"
# 끝나면: pkill -f 'http.server 41'
```

### Phase Requirements → Test Map
| Req / 기준 | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| SHELL-04 / SC1 (D-18) | `_site`·라이브 HTML에 `cdn.tailwindcss.com`·`tailwind.config` 0건, 네트워크 요청 0건 | grep + 브라우저 | `grep -rlF -e cdn.tailwindcss.com -e tailwind.config --include='*.html' "$W/c3/site"` → 빈 출력; `node report.mjs base1 c3 --no-cdn` → `PASS 18 rows`(`tailwindReqs` 0·`cdnInHtml:false`. 음성 대조로 기준에 `--no-cdn`을 걸면 18건 모두 FAIL); 라이브: `for p in privacy-policy terms data-deletion; do curl -s "https://runningpencil.com/$p/?cb=$SHA" \| grep -c -e cdn.tailwindcss.com -e tailwind.config; done` → 0 0 0; ③ 이후 `scripts/check-site.sh` 5번 | ❌ Wave 0 (스크래치) / check-site 5번은 구현 대상 |
| SHELL-04 / SC2 (D-13·D-14·D-15) | 2엔진 × 375·768·1280 × 3문서 전체 페이지 + 본문 링크 hover·focus가 0픽셀 | 픽셀 비교 | `node diff.mjs base1 cN` → `PASS 0 diffs` (PNG 42장); `node states.mjs cN` 실패 0; `node report.mjs base1 cN` → `PASS 18 rows`(링크 색·밑줄·`transition-*` 3종이 기준과 같음, `tabReached && focusVisible`, 페이지 높이 같음, 가로 밀림 없음) | ❌ Wave 0 |
| SHELL-04 / SC3 (D-17) | 세 문서 본문 텍스트 동일 | 텍스트 비교 | `diff.mjs`가 `*.txt`(article.innerText, 18건) 바이트 비교 → 차이 0 | ❌ Wave 0 |
| SHELL-04 / SC4 (D-19) | 클래스 없는 시험 본문이 카드 디자인에 맞음 | 계산된 스타일 + 캡처 승인 | `node sample.mjs http://127.0.0.1:<포트>/sample/ "$W/cap/sample"` → `PASS`(표 14px, 행 선 `rgb(228, 224, 214) 1px solid`, 바깥 테두리 0, h3 `17px 700 rgb(43, 43, 43)`, ol `decimal`, ol ol `hangul`, ul ul `circle`, 중첩 20px, dd 0px, table `display: table`, aside `14px rgb(87, 83, 76) 0px`, footer `1px rgb(228, 224, 214) 16px 14px 20px`, 375에서 `scrollWidth ≤ 375`) + 6장 캡처를 `checkpoint:decision`에서 사용자 승인 | ❌ Wave 0 (시험 본문 `sample/index.html`은 스크래치 사본에만) |
| 랜딩 불변 | `index.html` 출력 바이트 동일, `_site` 파일 목록 동일 | 바이트 비교 | `cmp "$W/base/site/index.html" "$W/cN/site/index.html"`; `diff <(cd base/site && find . -type f \| sort) <(cd cN/site && find . -type f \| sort)` | 명령만 |
| Ground Rule | 세 URL 200·제목 | check-site 3번 + curl | `scripts/check-site.sh <커밋>`; 라이브 `curl -s -o /dev/null -w '%{http_code}'` | ✅ |
| D-10 | 가. 나. 다. 마침표 | 캡처 확인 | 시험 본문 캡처(2배율 잘라 보기). 이 세션에서 두 엔진 확인 완료 | — |
| D-22 라이브 | 라이브 3문서 × 3폭 × 2엔진이 기준과 0픽셀 | 픽셀 비교 | `node capture.mjs https://runningpencil.com "$W/cap/live" "?cb=$SHA" && node diff.mjs "$W/cap/base1" "$W/cap/live"` | ❌ Wave 0 |

### Sampling Rate
- **Per task commit:** `scripts/check-site.sh <커밋>` + 그 커밋의 `capture.mjs`/`diff.mjs`/`states.mjs`(D-20: 커밋마다 0픽셀)
- **Per wave merge:** 위와 같음(사이트 커밋은 ①②③ 순서대로)
- **Phase gate:** ③ 판정 + 시험 본문 `sample.mjs` PASS + 사용자 캡처 승인 → 사이트 푸시 승인 → 라이브 HTTP·화면 확인 → 문서 푸시

### Wave 0 Gaps (스크래치에 만들 것, 커밋하지 않음)
- [ ] `$TMPDIR/rp-p3/pw/` — `npm install playwright@1.59.1 pngjs@7.0.0`
- [ ] `capture.mjs`, `diff.mjs`, `states.mjs`, `report.mjs`, `sample.mjs` — 아래 원문을 그대로 씁니다(이 세션에서 실행 확인)
- [ ] 시험 본문 `sample/index.html`(front matter `layout: legal`) — ③ 사본의 원본 폴더에만 넣어 빌드합니다
- [ ] 결과(기준 SHA, CDN 리디렉션 버전, 판정 출력)는 검증 문서에 남깁니다

#### capture.mjs
```js
// 사용법: node capture.mjs <baseURL> <outDir> [query]   예: query='?cb=<커밋>' (라이브 캐시 우회, D-22)
// 법적 3종 × 375·768·1280 × chromium·webkit 전체 페이지 캡처 + 본문 텍스트 + 네트워크 요청 + 링크 hover/focus 캡처
import { chromium, webkit } from 'playwright';
import fs from 'fs';
const [base, out, query = ''] = process.argv.slice(2);
fs.mkdirSync(out, { recursive: true });
const pages = ['privacy-policy', 'terms', 'data-deletion'];
const widths = [375, 768, 1280];
const report = {};
for (const [eng, bt] of [['chromium', chromium], ['webkit', webkit]]) {
  const browser = await bt.launch();
  for (const w of widths) for (const pg of pages) {
    const ctx = await browser.newContext({ viewport: { width: w, height: 900 }, deviceScaleFactor: 1, reducedMotion: 'reduce' });
    const p = await ctx.newPage();
    const reqs = [];
    p.on('request', r => reqs.push(r.url()));
    await p.goto(`${base}/${pg}/${query}`, { waitUntil: 'load' });
    await p.evaluate(() => document.fonts.ready);
    // Tailwind CDN이 있으면 주입 style이 생길 때까지 기다린다
    await p.waitForFunction(() => !window.tailwind || [...document.querySelectorAll('style')].some(s => s.textContent.includes('tailwindcss v3')));
    await p.waitForTimeout(300);
    const key = `${eng}-${w}-${pg}`;
    await p.screenshot({ path: `${out}/${key}.png`, fullPage: true });
    const info = await p.evaluate(() => {
      const art = document.querySelector('article');
      return {
        text: art.innerText,
        scrollWidth: document.documentElement.scrollWidth,
        height: document.documentElement.scrollHeight,
        cdnInHtml: document.documentElement.outerHTML.includes('cdn.tailwindcss.com'),
      };
    });
    fs.writeFileSync(`${out}/${key}.txt`, info.text);
    // 본문 첫 링크 hover / focus
    const link = p.locator('article a').first();
    if (await link.count()) {
      await link.hover();
      await p.waitForTimeout(400);
      const tr = await link.evaluate(a => { const c = getComputedStyle(a); return { color: c.color, tp: c.transitionProperty, td: c.transitionDuration, tf: c.transitionTimingFunction, deco: c.textDecorationLine + '|' + c.textDecorationColor + '|' + c.textDecorationThickness + '|' + c.textUnderlineOffset }; });
      await p.screenshot({ path: `${out}/${key}-hover.png`, fullPage: true });
      await p.mouse.move(0, 0);
      await p.waitForTimeout(400);
      // 키보드 focus: Tab을 눌러 본문 링크에 닿을 때까지
      let reached = false;
      for (let i = 0; i < 40; i++) {
        await p.keyboard.press(eng === 'webkit' ? 'Alt+Tab' : 'Tab');  // WebKit은 macOS 기본값처럼 Tab이 링크를 건너뛴다
        reached = await p.evaluate(() => document.activeElement && document.activeElement.closest('article') !== null && document.activeElement.tagName === 'A');
        if (reached) break;
      }
      await p.waitForTimeout(400);
      const fv = await p.evaluate(() => document.activeElement && document.activeElement.matches(':focus-visible'));
      await p.screenshot({ path: `${out}/${key}-focus.png`, fullPage: true });
      info.link = { ...tr, tabReached: reached, focusVisible: fv };
    }
    info.tailwindReqs = reqs.filter(u => u.includes('tailwindcss'));
    delete info.text;
    report[key] = info;
    await ctx.close();
  }
  await browser.close();
}
fs.writeFileSync(`${out}/report.json`, JSON.stringify(report, null, 1));
console.log('done', Object.keys(report).length);
```

#### diff.mjs
```js
// 사용법: node diff.mjs <dirA> <dirB>  — 같은 이름 PNG를 픽셀 단위로 비교 (허용 오차 0), txt는 바이트 비교
import fs from 'fs';
import { PNG } from 'pngjs';
const [a, b] = process.argv.slice(2);
let bad = 0;
for (const f of fs.readdirSync(a).sort()) {
  if (!fs.existsSync(`${b}/${f}`)) { console.log('MISSING', f); bad++; continue; }
  if (f.endsWith('.txt')) { const same = fs.readFileSync(`${a}/${f}`, 'utf8') === fs.readFileSync(`${b}/${f}`, 'utf8'); if (!same) { bad++; console.log('TEXT DIFF', f); } continue; }
  if (!f.endsWith('.png')) continue;
  const A = PNG.sync.read(fs.readFileSync(`${a}/${f}`)), B = PNG.sync.read(fs.readFileSync(`${b}/${f}`));
  if (A.width !== B.width || A.height !== B.height) { console.log('SIZE', f, A.width + 'x' + A.height, B.width + 'x' + B.height); bad++; continue; }
  let n = 0, mx = 0;
  for (let i = 0; i < A.data.length; i += 4) { let d = 0; for (let k = 0; k < 4; k++) d = Math.max(d, Math.abs(A.data[i + k] - B.data[i + k])); if (d) { n++; mx = Math.max(mx, d); } }
  if (n) { bad++; console.log('DIFF', f, n, 'px, max', mx); }
}
console.log(bad ? `FAIL ${bad}` : 'PASS 0 diffs');
process.exit(bad ? 1 : 0);
```

#### states.mjs
```js
// 기본 캡처와 hover/focus 캡처가 실제로 다른지(상태가 찍혔는지) 확인
import fs from 'fs'; import { PNG } from 'pngjs';
const d = process.argv[2]; let bad = 0;
for (const f of fs.readdirSync(d).filter(f => /-(hover|focus)\.png$/.test(f))) {
  const A = PNG.sync.read(fs.readFileSync(`${d}/${f.replace(/-(hover|focus)\.png$/, '.png')}`)), B = PNG.sync.read(fs.readFileSync(`${d}/${f}`));
  let n = 0; if (A.width === B.width && A.height === B.height) { for (let i = 0; i < A.data.length; i += 4) if (A.data[i] !== B.data[i] || A.data[i+1] !== B.data[i+1] || A.data[i+2] !== B.data[i+2]) n++; } else n = -1;
  if (n === 0) { bad++; console.log('VACUOUS', f); } else console.log('state ok', f, n);
}
process.exit(bad ? 1 : 0);
```

#### report.mjs
```js
// 사용법: node report.mjs <기준dir> <비교dir> [--no-cdn]
// D-15: 링크 계산값(색·밑줄·transition 3종)이 기준과 같고 키보드 focus가 실제로 찍혔는지, --no-cdn이면 SC1(HTML·요청에 Tailwind 0)까지 단정
import fs from 'fs';
const [a, b, flag] = process.argv.slice(2);
const A = JSON.parse(fs.readFileSync(`${a}/report.json`)), B = JSON.parse(fs.readFileSync(`${b}/report.json`));
let bad = 0; const no = (k, m) => { bad++; console.log('FAIL', k, m); };
for (const [k, vb] of Object.entries(B)) {
  const va = A[k]; if (!va) { no(k, 'missing in base'); continue; }
  if (va.height !== vb.height) no(k, `height ${va.height} != ${vb.height}`);
  if (vb.scrollWidth > +k.split('-')[1]) no(k, `page h-scroll ${vb.scrollWidth}`);
  if (!!va.link !== !!vb.link) no(k, 'link presence differs');
  if (vb.link) {
    for (const f of ['color', 'tp', 'td', 'tf', 'deco']) if (va.link[f] !== vb.link[f]) no(k, `${f}: ${va.link[f]} != ${vb.link[f]}`);
    if (!vb.link.tabReached || !vb.link.focusVisible) no(k, 'keyboard focus not reached/visible');
  }
  if (flag === '--no-cdn' && (vb.cdnInHtml || vb.tailwindReqs.length)) no(k, `tailwind still present: ${vb.cdnInHtml} ${vb.tailwindReqs.join(' ')}`);
}
console.log(bad ? `FAIL ${bad}` : `PASS ${Object.keys(B).length} rows`);
process.exit(bad ? 1 : 0);
```
이 세션 결과: ①·② `PASS 18 rows`, ③ `--no-cdn` `PASS 18 rows`.

#### sample.mjs
```js
// 시험 본문(성공 기준 4): 3폭 × 2엔진 캡처 + 계산된 스타일 자동 확인 + 375 가로 밀림 확인
import { chromium, webkit } from 'playwright';
import fs from 'fs';
const [url, out] = process.argv.slice(2);
fs.mkdirSync(out, { recursive: true });
let bad = 0;
const expect = (k, got, want) => { if (got !== want) { bad++; console.log('MISMATCH', k, JSON.stringify(got), '!=', JSON.stringify(want)); } };
for (const [eng, bt] of [['chromium', chromium], ['webkit', webkit]]) {
  const b = await bt.launch();
  for (const w of [375, 768, 1280]) {
    const p = await b.newPage({ viewport: { width: w, height: 900 }, deviceScaleFactor: 1 });
    await p.goto(url, { waitUntil: 'load' }); await p.evaluate(() => document.fonts.ready); await p.waitForTimeout(200);
    await p.screenshot({ path: `${out}/${eng}-${w}.png`, fullPage: true });
    const r = await p.evaluate(() => {
      const cs = (sel, prop) => getComputedStyle(document.querySelector(sel)).getPropertyValue(prop);
      const f = document.querySelector('.rp-doc figure');
      return {
        sw: document.documentElement.scrollWidth, vw: innerWidth,
        tableFont: cs('.rp-doc table', 'font-size'), tdBorder: cs('.rp-doc td', 'border-bottom-color') + ' ' + cs('.rp-doc td', 'border-bottom-width') + ' ' + cs('.rp-doc td', 'border-bottom-style'),
        tableOuter: cs('.rp-doc table', 'border-top-width'), th: cs('.rp-doc th', 'font-weight') + ' ' + cs('.rp-doc th', 'color'),
        h3: cs('.rp-doc h3', 'font-size') + ' ' + cs('.rp-doc h3', 'font-weight') + ' ' + cs('.rp-doc h3', 'color'),
        ol: cs('.rp-doc section > ol', 'list-style-type'), olol: cs('.rp-doc ol ol', 'list-style-type'), ulul: cs('.rp-doc ul ul', 'list-style-type'),
        nestedPad: cs('.rp-doc ol ol', 'padding-left'), dd: cs('.rp-doc dd', 'margin-left'), dt: cs('.rp-doc dt', 'font-weight') + ' ' + cs('.rp-doc dt', 'color'),
        aside: cs('.rp-doc aside', 'font-size') + ' ' + cs('.rp-doc aside', 'color') + ' ' + cs('.rp-doc aside', 'border-top-width'),
        footer: cs('.rp-doc > footer', 'border-top-width') + ' ' + cs('.rp-doc > footer', 'border-top-color') + ' ' + cs('.rp-doc > footer', 'padding-top') + ' ' + cs('.rp-doc > footer', 'font-size') + ' ' + cs('.rp-doc > footer', 'line-height'),
        siteFooterBorder: cs('footer.rp-foot', 'border-top-width') + ' ' + cs('footer.rp-foot', 'padding-top'),
        figOverflow: f.scrollWidth > f.clientWidth, figDisplay: cs('.rp-doc table', 'display'),
      };
    });
    console.log(eng, w, JSON.stringify(r));
    expect(`${eng}-${w} page no h-scroll`, r.sw <= r.vw, true);
    expect('table 14px', r.tableFont, '14px');
    expect('td line', r.tdBorder, 'rgb(228, 224, 214) 1px solid');
    expect('table outer', r.tableOuter, '0px');
    expect('h3', r.h3, '17px 700 rgb(43, 43, 43)');
    expect('ol', r.ol, 'decimal'); expect('ol ol', r.olol, 'hangul'); expect('ul ul', r.ulul, 'circle');
    expect('nested pad', r.nestedPad, '20px'); expect('dd', r.dd, '0px');
    expect('table display', r.figDisplay, 'table');
    expect('aside', r.aside, '14px rgb(87, 83, 76) 0px');
    expect('footer', r.footer, '1px rgb(228, 224, 214) 16px 14px 20px');
    await p.close();
  }
  await b.close();
}
console.log(bad ? `FAIL ${bad}` : 'PASS');
```
시험 본문은 이 세션에서 넓은 표(5열, `figure tabindex="0" aria-label`) + `aside`, 좁은 표, `h3` 두 개, `ol > li > ol`, `ul > li > ul`, `strong`, `a`, `dl`(dt·dd 두 쌍), 끝 `footer`로 구성했고, 6조합 모두 `PASS`였습니다. 375에서는 넓은 표만 넘쳤고(`figOverflow: true`), 768·1280에서는 넘치지 않았습니다.

### 이 세션의 실측 결과 요약 (계획 근거)
| 실험 | 결과 |
|---|---|
| 기준(a55649b) 자기 차이, PNG 42장 + txt 18건 | `PASS 0 diffs` (Chromium·WebKit 모두) |
| 커밋 ① 재현 (정적 CSS + 껍데기 클래스, CDN 유지) | `PASS 0 diffs` |
| 커밋 ② 재현 (본문 클래스 제거, p→footer) | `PASS 0 diffs` (텍스트 포함) |
| 커밋 ③ 재현 (CDN·config 제거) | `PASS 0 diffs`, `tailwindReqs` 0, `cdnInHtml` false, transition 계산값 엔진별 동일 |
| hover/focus 캡처 유효성 | 24장 모두 기본과 다름(793~852px). WebKit은 `Alt+Tab`으로 `tabReached && focusVisible` |
| 절제: `html` line-height 제거 | 8건 모두 `SIZE` 실패 (−8~−9px) |
| 절제: 본문 margin 초기화 제거 | 8건 모두 실패 (+13~+51px) |
| 절제: 제목 `margin` → `margin-top`만 | 8건 모두 실패 (+8~+16px) |
| 절제: `svg {display:block}` 추가 | `PASS 0 diffs` (영향 없음) |
| 랜딩 `index.html`, `_site` 파일 목록 | ①②③ 모두 바이트·목록 동일 |
| 라이브(`https://runningpencil.com`, `?cb=a55649b`) vs 로컬 기준 | `PASS 0 diffs` (PNG 42장 + txt 18건). D-22 라이브 화면 비교 방법이 그대로 동작함 |

## Security Domain

`security_enforcement: true`, ASVS L1.

### Applicable ASVS Categories

| ASVS Category | Applies | Standard Control |
|---------------|---------|-----------------|
| V2 Authentication | no | — (정적 사이트) |
| V3 Session Management | no | — |
| V4 Access Control | no | — |
| V5 Input Validation | no | 입력 없음(폼 없음) |
| V6 Cryptography | no | — |
| V10 Malicious Code / V14 Config (서드파티 구성요소) | **yes** | 이 단계가 버전 미고정 서드파티 스크립트(`cdn.tailwindcss.com`, 실행 권한 있음)를 없앰 → 공급망 위험 감소. 남는 외부 자원은 Pretendard CSS(실행 코드 아님, SRI는 Deferred) |

### Known Threat Patterns for 정적 HTML + 인라인 CSS

| Pattern | STRIDE | Standard Mitigation |
|---------|--------|---------------------|
| CDN 스크립트 변조·버전 변경(미고정 302) | Tampering | 이 단계에서 스크립트 자체를 제거. check-site 5번 항목으로 재유입 차단 |
| 검증 도구 공급망(`playwright` [SUS: too-new]) | Tampering | 7개월 된 1.59.1로 고정, postinstall 없음, 저장소 밖 스크래치, 커밋 안 함 |
| 내부 파일 공개(새 include) | Information Disclosure | `_includes/`는 밑줄 폴더라 출력되지 않음. check-site 2번 항목이 확인(③ 빌드에서 파일 목록 동일 확인) |

## Sources

### Primary (HIGH confidence — 이 세션 실측·원문)
- 로컬 실측: Jekyll 3.10.0 빌드 4종(기준·①·②·③) + Playwright 1.59.1 Chromium 147/WebKit 2272 캡처·비교·절제 시험·포커스·그림자·목록 표지 실험
- CDN 주입 CSS 덤프 (`tailwindcss v3.4.17`), `curl -I https://cdn.tailwindcss.com` → `location: /3.4.17`
- `https://unpkg.com/tailwindcss@3.4.17/src/css/preflight.css` (386행, 전문 확인)
- `npm pack tailwindcss@3.4.17` → `stubs/config.full.js` (fontSize, screens, transition*, borderColor)
- 저장소 파일: `_layouts/legal.html`(Read), `scripts/check-site.sh`(Read), `_includes/css/common.css`, `_includes/header.html`, `_includes/footer.html`, 법적 3종, `.githooks/pre-push`, `.planning/phases/02-…/02-UAT.md`, `03-CONTEXT.md`, `STATE.md`, `REQUIREMENTS.md`

### Secondary (MEDIUM/LOW — 웹, seam 등급 LOW)
- [Chrome: Keyboard focusable scrollers](https://developer.chrome.com/blog/keyboard-focusable-scrollers) — Chrome 130부터, 포커스 가능한 자식이 없을 때만
- [Adrian Roselli: Under-Engineered Responsive Tables](https://adrianroselli.com/2020/11/under-engineered-responsive-tables.html) — `div role="region" aria-labelledby tabindex="0"` 패턴
- [Adrian Roselli: Keyboard-Only Scrolling Areas](https://adrianroselli.com/2022/06/keyboard-only-scrolling-areas.html)

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH — 새 의존성이 없고, 도구 버전과 브라우저 리비전을 실측함
- Architecture: HIGH — 원안 CSS로 ①②③ 세 커밋을 재현해 0픽셀 확인
- Pitfalls: HIGH — 캐스케이드 순서, WebKit Tab 동작, 절제 시험을 모두 실측함. 실제 Safari·iOS는 [ASSUMED]

**Research date:** 2026-11-16
**Valid until:** Tailwind CDN 리디렉션이 `/3.4.17`인 동안. 기준 캡처 직전에 `curl -I`로 다시 확인합니다. 브라우저 동작 관찰은 30일 정도 유효합니다.
