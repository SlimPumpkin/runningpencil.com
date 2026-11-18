# Phase 5: 사업자 정보와 지원 연락 경로 (Business Info & Support Contact) - Research

**Researched:** 2026-11-19
**Domain:** Jekyll 3.10.0 / Liquid 4.0.4 사실값 슬롯(render-if-present), 공유 푸터·헤더, 법적 레이아웃 지원 페이지, git 보류 커밋 운용(이메일 게이트), DNS·메일 게이트 검증
**Confidence:** HIGH (핵심 Liquid 동작·바이트 동일·좁은 화면 줄바꿈은 이번 세션에 실제 빌드·브라우저로 확인)

<user_constraints>
## User Constraints (from CONTEXT.md)

아래 「Locked Decisions」는 `05-CONTEXT.md` 31~142행(「### 이전에 정해진 것」부터 D-21까지), 「Claude's Discretion」은 144~152행, 「Deferred Ideas」는 227~231행을 그대로 옮긴 것입니다 (`<decisions>` 블록 28~154행, `<deferred>` 블록 224~233행 안).

### Locked Decisions

### 이전에 정해진 것 (다시 논의하지 않음)
- 지원 주소의 정본은 이름 표(`.planning/baseline/NAMES.md`)이고, 메일은 Google Workspace 사용자 별칭 도메인(user alias domain)으로 받습니다. 답장도 지원 주소에서 보냅니다(U12, `.planning/baseline/DECISIONS.md`).
- 이메일 게이트: 외부 4곳(Gmail, 네이버, iCloud, Outlook)의 수신 시험을 통과하기 전에는 주소를 HTML과 `_data`에 넣지 않습니다(D-19, ROADMAP Phase 5 External gates).
- 값이 없는 항목은 행이나 문단을 통째로 숨깁니다. 「추후 기재」 같은 자리표시는 쓰지 않습니다. 전화번호는 칸만 만들고 값은 넣지 않습니다(U1, BIZ-03).
- 법적 본문 작성 규칙 D-01~D-12(`.planning/codebase/CONVENTIONS.md` 「법적 본문 작성 규칙」)를 따르고, `legal` 레이아웃을 씁니다.
- 푸시는 SHA마다 사용자 승인을 받습니다. 푸시 뒤에는 라이브에서 확인하고, 문제가 생기면 revert부터 합니다(Phase 2 D-18, Phase 3 D-21~D-23). 리팩터, 시각 변경, 내용 변경은 커밋을 나눕니다.

### 진행 상태와 사업자 값 받기
- **D-01:** 2026-11-19 기준 상태입니다.
  - 지원 메일 작업(USER-TASKS 작업 0~4)은 **아직 시작하지 않았습니다.** 확인 결과 `dig +short A runningpencil.com`은 GitHub Pages IP 4개를 돌려주고, MX와 TXT는 0건입니다.
  - DNS 반영 대기(MX 최대 72시간)가 있어 게이트는 적어도 며칠 뒤에 열립니다.
  - 사업자 값(작업 9)은 사용자가 **준비했습니다.**
- **D-02:** 사업자 값은 `.planning/` 아래 어떤 파일에도 적지 않습니다. CONTEXT, PLAN, SUMMARY, VERIFICATION, UAT, 커밋 메시지가 모두 여기에 해당합니다. 저장소가 PUBLIC이기 때문입니다(D-18).
  - 실행 단계에서 **값 커밋 직전에 대화로 받고**, 사이트 커밋의 `_data/company.yml`에만 넣습니다.
  - 검증 기록에는 값을 붙이지 않습니다. 「행이 있다/없다」, 건수, 사용자 대조 결과만 남깁니다.

### 배포 순서와 게이트
- **D-03:** **푸터 사업자 정보는 게이트를 기다리지 않고 먼저 배포합니다.** 카카오 비즈앱의 비즈니스 정보 심사가 이메일과 상관없이 사업자와 서비스의 관계를 보기 때문입니다.
  - 커밋 ①: 빈 `_data/company.yml` 슬롯과 푸터 템플릿. 값이 없으므로 네 문서의 출력은 바이트까지 그대로입니다(리팩터).
  - 커밋 ②: 사업자 값을 넣습니다(내용 변경).
  - 그다음 승인을 받아 푸시합니다.
- **D-04:** **`/support/` 페이지, 헤더·푸터 링크, 지원 이메일 값은 로컬 커밋까지만 하고, 게이트가 열린 뒤 한 번에 푸시합니다.**
  - 연락처가 없는 지원 페이지가 라이브에 오르는 순간을 만들지 않습니다.
  - 링크 커밋이 지원 페이지 커밋보다 먼저 라이브에 올라가면 안 됩니다(404).
  - 템플릿은 그래도 연락처·신고 구간을 이메일 값 조건으로 감쌉니다. 방어용입니다.
  - 이메일 값 하나가 푸터의 이메일 행과 `/support/` 연락처를 함께 엽니다.
  - **보류 커밋은 게이트 전에 푸시되는 어떤 커밋의 조상도 되면 안 됩니다.** 게이트를 기다리는 며칠 동안 D-03의 사업자 정보 푸시와 D-21의 문서 커밋이 `main`에 쌓입니다. SHA를 푸시하면 그 조상 커밋이 모두 함께 올라가므로, 지원 페이지·링크 커밋이 `main` 중간에 끼어 있으면 평범한 문서 푸시가 연락처 없는 `/support/`를 라이브에 올립니다. 막는 방법은 계획자 재량입니다. 예: 로컬 브랜치에 두기, 게이트 직전에 `main` 끝에 쌓기, 링크를 이메일 값 조건으로 감싸기.
  - **Reversibility:** costly — 푸시한 주소는 검색 캐시와 아카이브에 남고, 주소를 바꾸면 게이트를 다시 거쳐야 합니다.
- **D-05:** 게이트 확인 절차입니다.
  - 사용자가 작업 4의 「수신 시험 기록 양식」 표를 넘깁니다. 보낸 사람 주소는 넘기지 않습니다.
  - Claude가 네 행이 모두 「받은편지함 도착」인지 확인합니다. 확인한 뒤에만 이메일 값 커밋을 만듭니다.
  - 성공 기준 1의 「앞선 배포에 주소가 없음」은 사이트 파일(`.planning/` 제외)의 git 이력으로 확인합니다. 예: 게이트 커밋 이전 이력에 `git log -S` 0건.
  - `.planning/` 문서에는 주소가 이미 있습니다. 하지만 `_config.yml`의 `exclude`로 사이트에서 빠지므로 「배포」에 해당하지 않습니다.
- **D-06:** 단계 완료 조건입니다.
  - 게이트가 열림.
  - 사업자 값과 이메일 값이 라이브에 있음.
  - Search Console 도메인 속성이 「확인됨」 상태(SITE-03, 작업 7).
  - 변경 전후 `dig`에 MX, SPF(1개), Search Console TXT가 기록됨.
  - DNS를 바꾼 뒤에도 `https://runningpencil.com/`이 200.
  - 지원 주소로 보내기 설정(작업 5)이 끝남. USER-TASKS 표가 이 작업을 Phase 5를 막는 작업으로 두고, U12가 「답장은 지원 주소에서」로 정했기 때문입니다.
  - DKIM(작업 6)은 완료를 막지 않습니다.

### 푸터 사업자 정보 표기
- **D-07:** 위치는 `.rp-foot-legal` 안이고 순서는 아래와 같습니다(「줄 묶음」, 사용자 선택).
  ```
  러닝펜슬은 슬림펌킨이 운영하는 서비스입니다.
  상호 OOO · 대표자 OOO · 사업자등록번호 000-00-00000
  주소 OO시 OO구 OO로 00
  이메일 support@…        ← 게이트 뒤에만
  © 2026 슬림펌킨. All rights reserved.
  경로 데이터 © OpenStreetMap contributors
  ```
  - 라벨은 「상호」「대표자」「사업자등록번호」「주소」「이메일」이고, 사업자등록증 항목명을 따릅니다. 이메일은 `mailto:` 링크입니다.
  - 좁은 화면에서는 항목 단위로 줄이 바뀌게 합니다. 예를 들어 「사업자등록번호 000-…」가 중간에서 끊기지 않게 합니다.
- **D-08:** 값이 없는 항목은 그 항목만 빠집니다.
  - 첫 줄 세 항목이 모두 없으면 그 줄 자체가 없습니다.
  - 남은 항목 사이에 구분 기호 `·`가 끝이나 앞에 매달리지 않게 합니다.
  - Liquid에서는 빈 문자열이 참이므로 `!= blank`로 비교합니다(`.planning/research/ARCHITECTURE.md` Pattern 1).
- **D-09:** 운영 안내 문장과 저작권 문장은 **고치지 않습니다**(사용자 결정). 상호는 사업자 정보 줄에서 등록증 표기대로 보여 줍니다. 법적 문서의 `(이하 "회사")` 주체 표기도 바꾸지 않습니다.
- **D-10:** 주소는 **사업자등록증 표기 전체**를 그대로 씁니다. 성공 기준 3을 그대로 지키므로 ROADMAP 문구는 고치지 않습니다.
  - **Reversibility:** one-way — 푸시하는 순간 모든 페이지에 공개되고, 검색 캐시와 웹 아카이브에 남아 되돌릴 수 없습니다.
  - 값 커밋을 푸시하기 전에 로컬 빌드의 푸터 글을 사용자에게 보여 주고 승인을 받습니다. 그 글은 `.planning/`에 남기지 않습니다.
- **D-11:** 푸터는 랜딩을 포함한 모든 페이지가 함께 씁니다. 그래서 랜딩 출력도 바뀌고, 이는 의도한 변경입니다. 페이지 제목(check-site 3번 항목)은 바뀌지 않습니다.

### /support/ 페이지
- **D-12:** 파일은 `support/index.html`이고 `layout: legal`을 씁니다.
  - front matter는 `title: "고객 지원"`, `heading: "러닝펜슬 고객 지원"`, `eyebrow: "SUPPORT"`, `description`(반드시 채움, Phase 2 02-04 결정), `updated`(페이지 커밋 날짜)입니다.
  - `<title>`은 「고객 지원 - 러닝펜슬」이 됩니다.
  - **`noindex`와 「임시 게시본」 끝 안내(`<footer>`)는 두지 않습니다.** 법적 초안이 아니고, 게이트 뒤에 완성된 상태로만 올라가기 때문입니다.
- **D-13:** 구간 순서와 앵커를 고정합니다. 각 구간은 `<section id="…">`이고 첫 자식은 `<h2>`입니다.
  1. `#contact` 문의하기
  2. `#report` 공개 코스 신고
  3. `#faq` 자주 묻는 질문
  - **Reversibility:** costly — 앱이 이 앵커로 바로 열 예정이고(Deferred 참고), 나중에 콘솔에 등록할 수도 있습니다. 이름을 바꾸면 앱 배포가 필요합니다.
  - D-04의 허용 요소 목록은 요소만 정합니다. `section`의 `id` 속성은 Phase 6 DEL-08의 `#facebook` 앵커와 같은 방식입니다. 계획자가 판단해 필요하면 `.planning/codebase/CONVENTIONS.md`와 `_includes/css/legal.css` 맨 위 주석에 「앵커 `id`는 `section`에 둔다」 한 줄을 더합니다.
- **D-14:** 「문의하기」(`#contact`)
  - 지원 이메일을 `mailto:` 링크로 둡니다.
  - 응답 안내는 **「영업일 기준 3일 안에 답장」**입니다. 운영자가 지키는 약속이고, 문장 표현은 재량입니다.
  - 전화번호 행은 render-if-present입니다. 지금은 값이 없어 보이지 않습니다.
- **D-15:** 「공개 코스 신고」(`#report`)
  - **메일에 적을 내용만** 안내합니다. 응답 기한은 문의와 같고, 따로 약속하지 않습니다.
  - 처리 방식(비공개·삭제 등)의 약속과 「앱 안 신고 기능이 없다」는 문장은 쓰지 않습니다.
  - 적을 내용(코스 이름, 신고 이유, 화면 캡처 등)은 **앱의 공개 코스 화면에 실제로 보이는 정보만** 고릅니다. 만든 사람 표시 같은 항목은 앱 코드(`~/dv/woody/running_pencil`)에서 화면에 보이는지 확인한 뒤에 넣습니다.
- **D-16:** 「자주 묻는 질문」(`#faq`)은 `dl`로 씁니다. 질문은 `dt`, 답은 `dd`입니다(D-12 모양). 질문은 SUP-04의 네 개입니다.
  - **운영 주체:** `_data`의 상호 값을 Liquid로 참조합니다. 손으로 다시 쓰지 않습니다.
  - **위치를 수집하는 시점:** `.planning/baseline/DATA-INVENTORY.md`의 사실만 씁니다.
    - 서버에 저장하는 위치는 기록 중의 궤적뿐입니다.
    - 화면이 꺼져도 기록 중이면 위치를 받습니다. Android는 포그라운드 서비스 알림이 뜹니다.
    - 코스를 그리거나 기록을 시작하기 전 화면에서는 현재 위치를 읽지만 저장하지 않습니다.
    - 위치 권한은 「앱 사용 중」뿐입니다.
    - SUP-04의 「기록 중에만 수집」 문구와 「읽지만 저장하지 않음」 사실이 어긋나지 않게 계획 단계에서 문장을 맞춥니다.
  - **계정 삭제 방법:** 앱의 「회원탈퇴」 메뉴와 `/data-deletion/` 링크까지만 씁니다.
    - 삭제·보존 범위와 웹 삭제 요청은 적지 않습니다. U6·N3가 열려 있고, DEL은 Phase 6의 일입니다.
    - 링크 대상은 Phase 6 전까지 임시 게시본입니다. 이 상태를 받아들이고, FAQ 문장은 Phase 6 내용과 부딪히지 않을 만큼만 씁니다.
    - 메뉴 이름은 `.planning/baseline/DATA-INVENTORY.md` 근거로 「회원탈퇴」입니다. 메뉴까지 가는 경로를 적으려면 앱 코드로 확인합니다.
  - **공개 코스 신고:** 짧게 답하고 `#report` 구간으로 안내합니다.
- **D-17:** 본문은 Phase 3 규칙을 따릅니다. 클래스 없는 허용 요소만 쓰고, 간격 클래스나 `style`은 쓰지 않습니다. `_data` 값은 본문 안에서도 `{{ site.data.company.… }}`로 참조하고 문자열로 다시 쓰지 않습니다.

### 지원 링크
- **D-18:** 헤더 메뉴(`_includes/header.html`) 끝에 「고객 지원」(`/support/`)을 더합니다.
  - `home=true`(랜딩)일 때도 `/support/` 절대 경로입니다.
  - 860px 이하에서 메뉴 전체가 숨겨지는 규칙(`_includes/css/common.css`)은 그대로 둡니다. 폰에서는 푸터 링크로 갑니다.
- **D-19:** 푸터 nav 끝에 「고객 지원」을 더하고, nav의 `aria-label`을 「약관 및 정책」에서 **「약관 및 지원」**으로 바꿉니다.
  - Phase 8의 위치기반서비스 이용약관 링크는 「데이터 삭제 안내」와 「고객 지원」 사이에 들어갑니다.
- **D-20:** 링크 이름은 헤더와 푸터 모두 「고객 지원」입니다. 페이지 제목과 같습니다.

### 이 단계 안에서 고칠 문서 (Ground Rule)
- **D-21:** 방침이나 구조가 바뀌므로 이 단계 안에서 아래 문서를 고칩니다.
  - **두 `CLAUDE.md`:** 방침 표의 「지원 이메일 공개」「사업자 정보 표시」 행 현재 상태, Pages 표(`/support/`), 헤더·푸터 설명, `_data/company.yml` 설명, 「현재 사이트에는 지원 이메일이 없습니다」 문장. 방침 구간은 두 사본을 같은 커밋에서 고칩니다. `.claude/CLAUDE.md`의 GSD 블록은 원본 맵(`.planning/codebase/STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md`, `.planning/PROJECT.md`)을 고친 뒤 재생성합니다.
  - **`.planning/baseline/NAMES.md`:** 「들어갈 곳」에 확정한 키 이름을 적습니다. 값은 적지 않습니다.
  - **시점:** 사업자 정보 쪽 문서는 첫 푸시의 라이브 확인 뒤에, 지원 이메일·`/support/` 쪽 문서는 게이트 푸시의 라이브 확인 뒤에 고칩니다(Phase 4 D-23과 같은 방식).
  - **`.planning/STATE.md`:** Blockers의 「로컬 `main`이 `origin/main`보다 앞섬」 줄은 낡은 내용입니다. 2026-11-19 확인 결과 `main` = `origin/main` = `7876c5b`이고, 리뷰 수정(「강아지런」 등)도 원격에 있습니다. 상태 갱신 때 정리합니다.

### Claude's Discretion
- `_data/company.yml`의 키 이름과 구조. 파일 머리 주석에 render-if-present와 이메일 게이트 규칙을 적습니다. 영문 법인명 키를 지금 빈 값으로 둘지, Phase 9에 더할지도 재량입니다. Phase 5의 한국어 페이지에는 영문 법인명을 표시하지 않습니다.
- Liquid 구현(공백 제어, 구분 기호를 매달리지 않게 잇는 방법). include 공백 규칙(include 태그는 0열에 혼자, `{%-`는 `if`/`endif`에만)을 지킵니다.
- 좁은 화면 줄바꿈을 구현하는 방법. 푸터 CSS는 「공통」(`_includes/css/common.css`)에 있어 랜딩에도 영향이 갑니다. 새 hex 색을 늘리지 않습니다.
- 전화번호 칸의 라벨(예: 「전화」)과 위치(예: 이메일 줄 옆).
- 지원 페이지 `description`, 구간 안내 문장, FAQ 답 문장의 표현. 사실은 DATA-INVENTORY 범위 안에서만 씁니다.
- `scripts/check-site.sh` 보강. 예: `EXPECTED_TITLES`에 `support/index.html|고객 지원 - 러닝펜슬`을 더함. 지원 페이지는 게이트 푸시 때 들어오므로, 그 커밋 시점의 스크립트 기준으로 점검이 깨지지 않게 순서를 짭니다.
- 화면 확인 방식. 이전 단계처럼 Playwright, Chromium·WebKit, 375px·넓은 폭을 쓰고, 스크래치 경로에 pnpm을 씁니다.
- 위 순서 제약(D-03, D-04) 안에서 커밋을 나누는 세부 단위.

### Deferred Ideas (OUT OF SCOPE)

- **앱 설정의 「고객 지원」 행** (앱 저장소): 「앱 정보」 묶음에 `https://runningpencil.com/support/`(필요하면 `#contact`)를 `url_launcher` 외부 브라우저로 여는 행을 더합니다. 사이트의 `/support/`가 게이트 뒤에 라이브가 되므로, 앱 링크도 그 뒤에 켭니다.
- **앱 코스 화면의 「신고」 버튼** (앱 저장소): 코스 ID를 미리 넣은 메일 작성 화면을 엽니다. App Store 1.2의 신고 수단을 더 확실하게 채웁니다. 결정 목록 N7, 앱 P2-09와 이어집니다.
- **영문 `/en/support/`와 영문 사업자 표기**: Phase 9.
- **App Store Connect Support URL 등록**: Phase 10. 게이트 뒤에만 합니다.
- **DKIM과 Apple 릴레이 답장**: 작업 6, Phase 10(SUP-05).
</user_constraints>

> **[결정과 어긋나는 검증 결과 — 계획자가 반드시 반영]**
> D-08의 「Liquid에서는 빈 문자열이 참이므로 `!= blank`로 비교합니다(`.planning/research/ARCHITECTURE.md` Pattern 1)」는 **로컬 Jekyll 3.10.0 / Liquid 4.0.4 빌드(저장소 `Gemfile`)에서 동작하지 않습니다.** `x != blank`는 값이 `""`이든 null이든 키가 없든 **항상 참**입니다. 그대로 쓰면 값이 없는 행이 빈 채로 그려져 render-if-present(BIZ-02, U1)가 깨집니다.
> 이번 세션 스크래치 빌드(`bundle exec jekyll build --safe`, 저장소 `Gemfile`) 출력 그대로:
> ```
> empty_str: truthy=T ne_blank=T eq_blank=F ne_empty=F size=0
> null_key: truthy=F ne_blank=T eq_blank=F ne_empty=T size=0
> missing: truthy=F ne_blank=T eq_blank=F ne_empty=T size=0
> nofile: T truthy=F          ← site.data.nofile.x != blank 도 참
> ```
> 원인: vendored `liquid-4.0.4/lib/liquid/expression.rb:20` `'blank'.freeze => MethodLiteral.new(:blank?, '').freeze,`, `condition.rb:12` `'!='.freeze => ->(cond, left, right) { !cond.send(:equal_variables, left, right) },`, `condition.rb:90-106`의 `equal_variables`는 `if right.respond_to?(left.method_name) … else return nil end`(반대쪽도 같음). 값에 `blank?`가 없으면 `nil`이 되고 `!=`가 뒤집어 참이 됩니다. 같은 세션에서 `"".respond_to?(:blank?)` → `false`, `nil.respond_to?(:blank?)` → `false`, `Liquid::VERSION` → `4.0.4` [VERIFIED: vendored gem 읽음, 실행]. `!= empty`도 null·키 없음에서 참이라 쓸 수 없습니다.
> **운영 빌드와의 관계:** 운영(GitHub Pages)은 이 저장소의 `Gemfile.lock`이 아니라 자체 github-pages gem 세트로 빌드하므로, 이 시험을 운영에서 직접 돌린 것은 아닙니다. 다만 `.size > 0`은 `blank?` 메서드 유무와 상관없이 동작하므로 운영 gem 세트가 어떻든 결과가 같습니다. 운영 쪽 증거는 첫 푸시(M1~M4) 뒤 라이브 바이트 비교(라이브 HTML = 로컬 후보 빌드)로 얻습니다.
> **대신 `.size > 0`을 씁니다.** `""`·null·키 없음·파일 없음·`false`가 모두 거짓이고 값이 있으면 참입니다(아래 「Liquid 존재 판정 비교」). D-08의 의도(빈 값은 그리지 않음)는 그대로이고 비교 방법만 바뀝니다. `.planning/research/ARCHITECTURE.md` Pattern 1의 예시도 같은 이유로 틀렸으므로, 이 단계의 문서 갱신(D-21)에서 함께 고치는 것을 권합니다. [VERIFIED: 스크래치 빌드 출력, 이번 세션]

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| BIZ-01 | 방문자는 모든 페이지 푸터에서 사업자등록증과 같은 표기의 상호·대표자·사업자등록번호·주소와 지원 이메일을 본다 | 푸터 템플릿(코드 예시 1, 실제 빌드로 확인), 좁은 화면 항목 단위 줄바꿈 CSS(Pattern 3, 375px 두 엔진 측정), 값 커밋은 대화로 받은 값만(D-02, D-10) |
| BIZ-02 | `_data` 한 곳만 고쳐 반영, 값이 없는 항목은 자리표시 없이 표시되지 않음 | `_data/company.yml` 슬롯 + `.size > 0` 판정(위 경고, Pattern 1), 빈 슬롯일 때 네 문서 바이트 동일 확인 |
| BIZ-03 | 전화번호를 넣으면 바로 나타남 (이번에는 칸만) | `phone` 키와 푸터·`#contact`의 render-if-present 행. 스크래치에서 `phone`만 채운 변형이 「전화 …」 한 행만 그리는 것을 확인 |
| SUP-01 | `/support/` 맨 위에서 앱 이름, 지원 이메일과 응답 안내 | `layout: legal` + `heading: "러닝펜슬 고객 지원"`(D-12), `#contact` 구간(코드 예시 3) |
| SUP-02 | 외부 4곳 수신 확인 전에는 주소 비공개 | 보류 커밋 운용(Pattern 4), check-site 7번 항목(가드), `git log -S` 확인(Validation) |
| SUP-03 | 공개 코스 신고 방법(지원 이메일) | `#report`의 적을 내용은 앱 코스 화면에 실제로 보이는 정보만 (앱 코드 확인 결과, 「앱 코드 확인」 절) |
| SUP-04 | FAQ: 운영 주체, 위치 수집 시점, 계정 삭제 방법, 공개 코스 신고 | `dl` FAQ와 DATA-INVENTORY 근거 문장안(「FAQ 문장안」 절), 「회원탈퇴」 경로 앱 코드 확인, `dd + dt` 간격 빈칸(Pitfall 5) |
| SITE-03 | Search Console 도메인 속성 확인됨 | 사용자 작업 7. 권한 있는 네임서버 기준 `google-site-verification` TXT가 이미 1줄 있음(「환경 확인」). 「확인됨」 여부는 사용자 보고로만 판정 |
</phase_requirements>

## Summary

이 단계의 기술 작업은 작지만, 틀리면 되돌릴 수 없는 공개(주소·대표자 이름·자택일 수 있는 주소)가 걸려 있어 순서와 판정이 핵심입니다. 세 가지가 계획을 바꿉니다.

첫째, D-08이 정한 `!= blank` 비교는 로컬 Jekyll 3.10.0 / Liquid 4.0.4 빌드에서 항상 참이라 render-if-present가 깨집니다. `.size > 0`으로 판정하면 빈 문자열·null·키 없음·파일 없음이 모두 거짓이 되고, 이 판정으로 쓴 푸터 템플릿과 빈 `_data/company.yml`을 넣어도 네 문서(`/`, 법적 3종)의 빌드 출력은 **기준 커밋과 바이트까지 같습니다**(`diff -r` 빈 출력, 이번 세션 확인). 다만 「공통」 CSS(`_includes/css/common.css`)는 네 페이지 `<style>`에 인라인되므로, 줄바꿈·링크 색 규칙을 같은 커밋에 넣으면 바이트 동일이 깨집니다. 그래서 D-03의 커밋 ①(슬롯+템플릿, 바이트 동일)과 커밋 ②(값) 사이에 CSS 두 줄만 더하는 시각 커밋을 따로 둡니다. 이 연구는 `main`에 쌓는 네 커밋을 M1(= D-03 커밋 ①)·M2(CSS)·M3(check-site 가드)·M4(= D-03 커밋 ②, 값)로 부릅니다(출력 차이는 네 문서 모두 `<style>` 안 두 줄 추가뿐, 확인함).

둘째, 375px에서 실제로 그려 보니 계획에 없던 결함 두 가지가 보였습니다. 푸터의 `mailto:` 링크는 규칙이 없어 기본 파란색으로 어두운 바탕(`#2B2B2B`) 위에 그려집니다. 또 줄이 바뀔 때 구분 기호 `·`가 첫 줄 끝에 매달립니다. 각 항목을 `display: inline-block`으로 묶으면 항목 중간에서 끊기지 않는 것은 Chromium·WebKit 모두 확인했습니다.

셋째, D-04의 「보류 커밋이 먼저 푸시되는 커밋의 조상이 되면 안 됨」은 이름 붙은 로컬 브랜치(별도 worktree)에 보류 묶음을 두고, 게이트 때 `main` 끝으로 cherry-pick하는 방식이 가장 단순합니다. 여기에 「`/support/`가 출력에 있으면 `mailto:`가 있어야 함, `/support/` 링크가 있으면 그 페이지가 있어야 함」을 `scripts/check-site.sh` 7번 항목으로 **먼저** `main`에 넣으면, 실수로 보류 커밋이 섞여도 pre-push 훅이 푸시를 막습니다. 또 DNS는 CONTEXT D-01(오늘 아침 MX·TXT 0건) 뒤로 바뀌었습니다. 권한 있는 네임서버(`ns1.gabia.co.kr`) 기준 MX `1 smtp.google.com.`, SPF 1줄, `google-site-verification` 1줄이 이미 있습니다(DKIM 0). 사용자가 작업 2를 시작한 것으로 보이며, 이 결과가 D-06의 「변경 후」 기록 출발점이 됩니다.

**Primary recommendation:** `main`에 M1 빈 슬롯+템플릿(바이트 동일, D-03 커밋 ①) → M2 「공통」 CSS 두 줄(시각) → M3 check-site 7번 가드(build) → M4 사업자 값(내용, 사용자 승인, D-03 커밋 ②) 순으로 쌓아 푸시하고, `/support/`·링크·`EXPECTED_TITLES`는 이름 붙은 보류 브랜치에서 만들어 게이트 때 cherry-pick + 이메일 커밋 한 번으로 푸시합니다. 모든 존재 판정은 `!= blank`가 아니라 `.size > 0`으로 씁니다.

## Architectural Responsibility Map

| Capability | Primary Tier | Secondary Tier | Rationale |
|------------|-------------|----------------|-----------|
| 사실값 보관(상호·대표자·번호·주소·이메일·전화) | Build (`_data/company.yml`) | — | 서버가 없으므로 값은 빌드 때 HTML에 박힘. 한 파일만 고침(BIZ-02) |
| 값 존재 판정·행 숨김 | Build (Liquid 템플릿) | — | JS로 주입·숨김 금지(ARCHITECTURE Anti-Pattern 4). 심사 봇이 JS 없이 봄 |
| 푸터 사업자·이메일 행 | Build (`_includes/footer.html`) | Browser/CSS (`common.css` 줄바꿈·링크 색) | 공유 include 한 곳 → 네 페이지 |
| 지원 페이지 본문 | Build (`support/index.html` + `_layouts/legal.html`) | Browser/CSS (`legal.css`) | 법적 레이아웃 재사용(D-12) |
| 헤더·푸터 「고객 지원」 링크 | Build (`_includes/header.html`, `footer.html`) | — | 게이트 전 404 링크 금지(D-04) |
| 이메일 게이트·배포 순서 | Git/배포 절차 (보류 브랜치, pre-push 훅) | Build 점검(`scripts/check-site.sh`) | `main` 푸시 = 배포. 조상 관계로만 막을 수 있음 |
| 메일 수신·DNS·Search Console | 외부(사용자: 가비아, Google Workspace, Search Console) | Claude: `dig`·기록 확인 | 사이트 코드 밖 |

## Standard Stack

새 라이브러리·패키지를 저장소에 들이지 않습니다. 이 단계의 스택은 이미 있는 것뿐입니다.

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Jekyll | 3.10.0 | 빌드(`_data`, include, layout) | GitHub Pages 운영 버전과 같음. `bundle exec jekyll -v` → `jekyll 3.10.0` [VERIFIED: 이번 세션 실행] |
| Liquid | 4.0.4 | 템플릿 판정·출력 | Jekyll 3.10.0이 쓰는 버전. `Liquid::VERSION` → `4.0.4` [VERIFIED: 이번 세션 실행] |
| `scripts/check-site.sh` | 저장소 현재본(6항목) | 푸시 전 점검, pre-push 훅 | `.githooks/pre-push`가 `main` 푸시마다 호출. `git config core.hooksPath` → `.githooks` [VERIFIED: 이번 세션 실행] |

### Supporting (저장소 밖 스크래치, 커밋 안 함)
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| playwright `[WARNING: flagged as suspicious — verify before using.]` | 1.59.1 (고정) | 375px·넓은 폭, Chromium·WebKit 화면 측정·캡처 | 푸터 줄바꿈, 지원 페이지 확인. Phase 3·4에서 승인된 같은 고정 버전·같은 방식(pnpm, 스크래치). 설치 상태는 `$TMPDIR/rp-p4/pw/package.json`에서 확인 [VERIFIED: 파일 읽음]. SUS 판정은 최신 릴리스 날짜 때문이며, 새로 설치하거나 버전을 바꿀 때만 checkpoint |
| pngjs | 7.0.0 | 캡처 픽셀 비교(Phase 3·4 도구) | 픽셀 동일 판정이 필요할 때만 |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| `x.size > 0` | `x and x != empty` | 한 값에는 맞지만 `and`·`or`를 섞으면 Liquid가 **오른쪽부터** 묶어 틀림(아래 Pitfall 2). 여러 값을 `or`로 잇는 줄 판정에 못 씀 |
| `x.size > 0` | `assign v = x \| strip` 뒤 `v != empty` | 공백만 있는 값까지 거르지만 `assign` 태그 줄의 공백 처리가 필요해 include 공백 규칙(`{%-`는 if/endif에만)과 부딪힘 |
| Liquid 텍스트 구분 기호 ` · ` | CSS 생성 구분 기호(`span + span::before`) | Liquid가 단순해지지만 복사·텍스트 추출에 구분 기호가 빠지고, 줄 시작에 `·`가 매달림 |

**Installation:** 없음. Playwright가 스크래치에서 사라졌으면 Phase 4와 같은 고정 버전·경로로만 다시 설치합니다 (`pnpm --dir "$W/pw" install --frozen-lockfile`, 사용자 승인 checkpoint).

## Package Legitimacy Audit

이 단계는 저장소에 패키지를 설치하지 않습니다. 화면 확인용 스크래치 도구만 Phase 3·4에서 승인된 고정 버전을 다시 씁니다.

| Package | Registry | Age | Downloads | Source Repo | Verdict | Disposition |
|---------|----------|-----|-----------|-------------|---------|-------------|
| playwright (1.59.1 고정) | npm | 최신 릴리스 2026-11-13 | 약 1.77억/주 | github.com/microsoft/playwright | [SUS] (사유 `too-new` — 최신 릴리스 날짜 기준. 고정 버전 1.59.1은 Phase 3·4에서 이미 승인·사용) | 고정 버전 재사용만 허용. 새로 설치·버전 변경이 필요하면 `checkpoint:human-verify` |
| pngjs (7.0.0 고정) | npm | 2023-02 | 약 1.1억/주 | github.com/pngjs/pngjs | [OK] | Approved |

`npm view playwright@1.59.1 version` → `1.59.1`, `npm view pngjs@7.0.0 version` → `7.0.0`, 두 패키지 모두 `postinstall` 없음 (gsd-tools package-legitimacy·`npm view` 실행 결과, 이번 세션). 두 이름은 공식 문서·Context7이 아니라 이전 단계 스크래치에서 왔고 playwright는 SUS 판정이므로, 둘 다 `[VERIFIED: npm registry]` 등급이 아닙니다 [ASSUMED 등급, 레지스트리 존재만 확인].

**Packages removed due to [SLOP] verdict:** 없음
**Packages flagged as suspicious [SUS]:** playwright — 이미 설치된 1.59.1 고정본을 쓰는 한 추가 조치 없음. 재설치·업그레이드 때만 checkpoint.

## Architecture Patterns

### System Architecture Diagram

```
 사용자(대화) ── 사업자 값 ──▶ _data/company.yml ◀── 지원 이메일(게이트 통과 뒤에만)
                                   │  (Liquid .size > 0 판정)
                    ┌──────────────┼───────────────────────────┐
                    ▼              ▼                           ▼
      _includes/footer.html   support/index.html(보류)   (Phase 6~8: 법적 문서)
       상호·대표자·번호 줄       #contact·#report ← email 조건
       주소 줄 / 이메일·전화 줄    #faq (상호 참조)
                    │              │
       _includes/header.html ──「고객 지원」 링크(보류) ──┘
                    │
                    ▼
     Jekyll 3.10.0 빌드 ──▶ _site (/, /privacy-policy/, /terms/, /data-deletion/, [/support/])
                    │
     scripts/check-site.sh (1~6 + 7: /support/ ⇒ mailto, 링크 ⇒ 페이지)
                    │  pre-push 훅 (main 푸시마다, 작업 트리의 스크립트로 푸시 SHA 점검)
                    ▼
     git push <승인 SHA>:refs/heads/main ──▶ GitHub Pages 배포 ──▶ 라이브 확인
                    ▲
   보류 브랜치 p5-support-hold (별도 worktree) ── 게이트 때 cherry-pick ──┘

 외부: 가비아 DNS(MX·SPF·TXT) → Google Workspace 수신 → 외부 4곳 수신 시험 기록 → Claude 확인 → 게이트 열림
```

### Recommended Project Structure (이 단계가 더하는 것)
```
_data/
└── company.yml          # 사실값 슬롯 (새 파일, `_`로 시작하므로 출력·exclude와 무관)
support/
└── index.html           # /support/ (layout: legal) — 보류 브랜치에서 만들고 게이트 때 main으로
_includes/
├── footer.html          # 사업자 줄·주소 줄·이메일/전화 줄, nav 끝 「고객 지원」, aria-label
├── header.html          # nav 끝 「고객 지원」
└── css/common.css       # .rp-foot-legal span / a 두 규칙
scripts/check-site.sh    # 7번 가드(먼저 main), EXPECTED_TITLES에 support 줄(보류 묶음)
```

### Pattern 1: 사실값 슬롯 판정은 `.size > 0`

**What:** 값마다 `site.data.company.<키>.size > 0`으로 판정합니다. 줄 하나에 여러 항목이 있으면 `or`로만 잇습니다.
**When to use:** 푸터, `/support/`, 이후 Phase 6~8의 모든 `_data` 참조.
**Liquid 존재 판정 비교 (이번 세션 실행 결과 그대로):**
```
empty_str: and_ne_empty=F size_gt0=F strip_ne_empty=F direct=F
null_key: and_ne_empty=F size_gt0=F strip_ne_empty=F direct=F
space_only: and_ne_empty=T size_gt0=T strip_ne_empty=F direct=T
filled: and_ne_empty=T size_gt0=T strip_ne_empty=T direct=T
missing: and_ne_empty=F size_gt0=F strip_ne_empty=F direct=F
zero: and_ne_empty=T size_gt0=T strip_ne_empty=T direct=T
false_val: and_ne_empty=F size_gt0=F strip_ne_empty=T direct=F
nofile: F
```
[VERIFIED: 스크래치 빌드, 이번 세션]
- 공백만 있는 값(`" "`)은 `.size > 0`에서 참입니다. 따옴표 안에 공백만 넣지 않는다는 규칙을 `company.yml` 머리 주석에 적습니다.
- 따옴표 없는 숫자는 정수가 되어 `.size`가 바이트 수(8)를 돌려주므로 참이 되고, 앞자리 `0`이 사라질 수 있습니다. **모든 값은 큰따옴표로 감쌉니다**(머리 주석에 적음). 이번 세션의 `phone: 0212345678`(따옴표 없음)은 문자열로 남았지만 YAML 1.1의 8진수 해석 때문에 값에 따라 달라질 수 있습니다 [ASSUMED: 8진수로 읽히는 다른 숫자 꼴은 시험하지 않음].

### Pattern 2: 출력 불변 커밋 M1(D-03 커밋 ①)은 템플릿과 슬롯만

**What:** M1에는 `_data/company.yml`(모든 값 `""`)과 `_includes/footer.html` 템플릿만 넣습니다. CSS는 넣지 않습니다.
**확인 결과:** 기준(HEAD `6267524`의 `git archive`)과 M1 사본을 `JEKYLL_ENV=production bundle exec jekyll build --safe`로 빌드하면 네 문서 `cmp` 동일, `diff -r` 빈 출력입니다. 값이 모두 null(`trade_name:`)인 경우와 `_data` 폴더가 아예 없는 경우도 `diff -r` 빈 출력입니다 [VERIFIED: 스크래치 빌드, 이번 세션].
**CSS 커밋의 출력 차이:** 「공통」에 두 줄을 더하면 차이는 정확히 `<style>` 안 두 줄 추가입니다 — `index.html` `57a58,59`, 법적 3종 `47a48,49` [VERIFIED: 스크래치 빌드 diff, 이번 세션]. 값이 없으므로 화면은 그대로입니다(`span`·`a`가 아직 없음).

### Pattern 3: 좁은 화면 항목 단위 줄바꿈

**What:** 첫 줄 세 항목을 각각 `<span>`으로 감싸고, 「공통」에 `.rp-foot-legal span { display: inline-block; }`을 둡니다. 주소는 줄 하나(`<p>`)라 감싸지 않습니다(길어서 자연 줄바꿈이 필요).
**확인 결과 (375px, 가짜 값, 긴 상호와 긴 주소):** Chromium·WebKit 모두 `scrollWidth 375`(가로 넘침 없음), 사업자 줄 2줄, 각 `span`이 한 상자(중간 끊김 없음) [VERIFIED: Playwright 1.59.1, 이번 세션]. `white-space: nowrap`도 같은 결과였지만, 항목 하나가 줄보다 길 때 `nowrap`은 잘리고(`body { overflow-x: clip }`) `inline-block`은 상자 안에서 줄을 바꾸므로 `inline-block`을 권합니다.
**측정 주의:** `inline-block` 상자는 안에서 줄이 바뀌어도 `getClientRects().length`가 1입니다. 판정은 `span` 높이가 한 줄 높이(13px × 1.6 ≈ 20.8px) 이하인지로 합니다.
**구분 기호 위치:** 구분 기호를 ` · `(양쪽 일반 공백)로 두면 두 엔진 모두 `·`가 **첫 줄 끝**에 남았습니다(「… · 대표자 OOO ·」 다음 줄 「사업자등록번호 …」). 선택지:
  1. 그대로 둠: 줄 끝 `·`. 흔한 모양이지만 D-08의 「매달리지 않게」를 화면 줄바꿈까지 넓혀 읽으면 어긋남.
  2. `&nbsp;· `: 줄 끝 `·`로 **고정**(앞쪽 매달림은 생기지 않음).
  3. ` ·&nbsp;` 또는 구분 기호를 다음 `span` 안에 둠: 줄 시작 `·`.
  4. 860px 이하에서 항목을 한 줄에 하나씩 세우고 구분 기호를 숨김: CSS 생성 구분 기호(`span + span::before`)가 필요하고 「줄 묶음」(D-07) 모양이 좁은 화면에서 바뀜.
  어느 쪽이 D-07·D-08 의도에 맞는지는 사용자 확인 사항입니다(UI-SPEC 또는 D-10 승인 때 375px 캡처로 결정). 연구자 추천은 2번입니다(Liquid 한 글자 차이, 결과가 엔진마다 같음).

### Pattern 4: 보류 브랜치 + 게이트 때 cherry-pick (D-04)

**What:** `/support/`를 만들거나 그쪽으로 링크하거나 주소를 담는 커밋(「보류 묶음」)만 이름 붙은 로컬 브랜치 `p5-support-hold`에 두고, 게이트가 열리면 `main` 끝으로 cherry-pick한 뒤 이메일 커밋을 더해 한 번에 푸시합니다.
**왜 이 방식인가 (판별 조건):**
- pre-push 훅은 **푸시하는 체크아웃의 작업 트리에 있는** `scripts/check-site.sh`로 **푸시하는 SHA**를 점검합니다 (`.githooks/pre-push`: `"$TOP/scripts/check-site.sh" "$local_sha"`, `TOP=$(git rev-parse --show-toplevel)`) [VERIFIED: `.githooks/pre-push` 읽음]. 그래서 `EXPECTED_TITLES`에 `support/index.html|고객 지원 - 러닝펜슬`을 더하는 커밋은 보류 묶음과 함께 움직여야 합니다. `main`에 먼저 들어가면 게이트 전 모든 푸시가 3번 항목 「문서가 없습니다: /support/index.html」로 막힙니다 (3번 항목은 `[ ! -f "$DEST/$path" ]`면 실패) [VERIFIED: `scripts/check-site.sh` 3번 항목 읽음].
- 선례: Phase 4의 되돌리기 절차는 「force push, 이력 수정(rebase·reset·commit --amend, 로컬 포함), --no-verify는 쓰지 않는다」고 적었습니다 [VERIFIED: `04-05-PLAN.md:85`, 그 계획의 `<rollback_procedure>` 안]. 프로젝트 전체 규칙은 아니지만 같은 결을 따라, 보류 묶음을 `main` 위로 옮길 때 rebase 대신 **cherry-pick**을 씁니다. cherry-pick은 `main`에 새 커밋을 더할 뿐 기존 이력을 고치지 않아, 승인·라이브 확인 기록의 SHA가 그대로 남습니다.
- Phase 4처럼 `git commit-tree`로 만든 이름 없는 객체로 며칠 기다리면 `git gc`가 지울 수 있습니다(도달 불가 객체 기본 보존 2주) [ASSUMED: git 기본값 `gc.pruneExpire=2.weeks.ago`, 이번 세션에 문서 확인 안 함. 이 저장소는 값 미설정]. 게이트가 언제 열릴지 모르므로 **이름 붙은 ref**가 필요합니다.
- GSD 문서 커밋(`gsd-tools query commit`)은 체크아웃된 브랜치에 들어갑니다. 메인 체크아웃에서 보류 브랜치를 checkout하면 그동안의 SUMMARY·STATE 커밋이 보류 브랜치에 섞입니다. 그래서 보류 브랜치는 **별도 worktree**에서만 고칩니다. `scripts/check-site.sh`는 새 worktree를 지원합니다(`.bundle/config`가 없으면 메인 체크아웃의 Gemfile 사용) [VERIFIED: check-site.sh 「gem을 찾을 체크아웃」 블록 읽음].
- 「링크를 이메일 값 조건으로 감싸기」만으로는 D-04를 못 지킵니다. 링크는 숨어도 `/support/` 페이지 자체가 연락처 없이 라이브에 올라갑니다.
- `updated`(최종 업데이트)는 공개되는 날짜여야 하므로 게이트 커밋에서 그날 날짜로 씁니다(D-12의 「페이지 커밋 날짜」를 게이트 커밋 날짜로 읽음, 아래 Open Question 2).

**절차 (권장):**
1. (`main`) M1~M4를 쌓아 푸시하고 라이브 확인. 그중 M3이 check-site 7번 가드입니다.
2. (`main` 끝에서) `git worktree add -b p5-support-hold <저장소 밖 경로> main`. 경로는 macOS 임시 폴더 정리를 피해 오래 남는 곳에 둡니다(작업 트리가 지워져도 커밋은 ref로 남고 `git worktree prune` 뒤 다시 만들 수 있음).
3. (보류 worktree) 커밋을 쌓습니다: H1 `support/index.html`(연락처·신고 구간은 이메일 조건) → H2 `scripts/check-site.sh` `EXPECTED_TITLES` 줄 → H3 헤더·푸터 링크와 `aria-label`. 이 브랜치는 **푸시하지 않습니다**(upstream 없음 확인: `git rev-parse --abbrev-ref p5-support-hold@{upstream}`이 실패해야 함).
4. 게이트 전 매번 확인: `git merge-base --is-ancestor p5-support-hold origin/main`이 거짓, `git branch -r --contains p5-support-hold`가 빈 출력.
5. (게이트 확인 뒤, 메인 체크아웃) `git cherry-pick $(git merge-base main p5-support-hold)..p5-support-hold` → 이메일 커밋 G(`_data/company.yml`의 `support_email`, `support/index.html`의 `updated`) → 후보 점검 → 승인 → `git push origin <SHA>:refs/heads/main`.
6. cherry-pick 뒤 사이트 출력이 보류 브랜치와 같은지 확인: `. "$W/lib.sh"; build hold p5-support-hold; build pick <G의 부모>; diff -r "$W/hold/site" "$W/pick/site"`가 빈 출력이면, 보류 브랜치에서 한 판정이 그대로 유효합니다. `git diff … -- . ':(exclude).planning'`로 비교하면 기다리는 동안 `main`에서 고친 두 `CLAUDE.md`(D-21) 같은 출력 밖 파일까지 잡혀 거짓 실패가 나므로 빌드 출력으로 비교합니다. M4 뒤에 보류 브랜치를 만들고 그사이 `main`에 사이트 파일 커밋이 없었다면 두 출력은 같아야 하고, 다르면 원인을 보고 멈춥니다.
7. 라이브 확인 뒤 `git worktree remove`, `git branch -D p5-support-hold`.

**대안 (fallback):** 보류 커밋을 미리 만들지 않고, 지원 페이지 초안을 스크래치 사본에서만 빌드·캡처해 사용자 확인을 받은 뒤 게이트 때 `main`에서 바로 커밋합니다. 조상 관계 위험은 0이지만 초안 파일이 임시 폴더 정리로 사라질 수 있습니다.

### Anti-Patterns to Avoid
- **`!= blank` / `!= empty`로 존재 판정:** 위 경고. `.size > 0`을 씁니다.
- **`and`와 `or`를 한 조건에 섞기:** Liquid는 괄호가 없고 오른쪽부터 묶습니다(Pitfall 2).
- **값 뒤에 조사를 붙이기:** 「{{ 상호 }}이/가」는 받침에 따라 틀립니다. 「운영 주체는 {{ … }}입니다」, 「이메일: …」처럼 조사가 필요 없는 문장으로 씁니다 (「입니다」는 받침과 상관없이 맞음).
- **front matter에 Liquid:** front matter는 Liquid를 거치지 않습니다. `description`에 `{{ site.data… }}`를 쓰면 글자 그대로 나가고 check-site 4번 항목에 걸립니다 [ASSUMED: Jekyll이 front matter 값을 렌더하지 않는다는 일반 동작, 이번 세션 미시험].
- **사업자 값을 `.planning/`·커밋 메시지·EVIDENCE에 적기:** D-02. 검증 기록은 「행 있음/없음」, 개수만.
- **보류 브랜치를 메인 체크아웃에서 checkout:** GSD 문서 커밋이 보류 브랜치에 섞입니다.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| 푸시 직전 출력 점검 | 별도 확인 스크립트 | `scripts/check-site.sh`에 7번 항목 추가 | 훅이 이미 부름. 점검이 한 곳에 모임 |
| 출력 불변 판정 | 눈 비교, 공백 정규화 | Phase 2·4 `lib.sh`의 `build <이름> <커밋>` + `diff -r` / `cmp` | 커밋 트리 그대로 `git archive`로 빌드. 기록된 `TREE`로 재현 가능 |
| 이메일 스팸 방지 | JS 조립·난독화 | 평문 `mailto:` | ARCHITECTURE Anti-Pattern 4: 심사 봇·JS 없는 환경에서 연락처가 안 보임 |
| 게이트 전 주소 미공개 확인 | 수동 검색 | `git log -S"$ADDR" … -- . ':(exclude).planning'` | 이력 전체를 한 번에 확인 |
| 값 누출 확인(`.planning`) | 눈으로 확인 | `_data/company.yml`에서 값을 뽑아 `git diff --cached -- .planning \| grep -c -F -f <스크래치 값 파일>` | 값을 화면·기록에 찍지 않고 개수만 얻음 |

**Key insight:** 이 단계의 실패는 대부분 「되돌릴 수 없는 공개」입니다. 사람의 주의보다 훅(`check-site` 7번)과 조상 관계 확인(`merge-base --is-ancestor`)처럼 기계가 막는 장치를 먼저 둡니다.

## 앱 코드 확인 (앱 저장소 `~/dv/woody/running_pencil`, 기준 `3afb2085`, `git show`로만 읽음)

앱 작업 트리에는 고친 파일이 있으므로(`git status` M·D 여러 개) 모두 `git show 3afb2085:<경로>`로 읽었습니다.

### 공개 코스 화면에 보이는 정보 (`#report` 근거, D-15)
- 코스 상세 아래 패널: 지역 라벨 `CourseRegionLabel(region: course.region)` [VERIFIED: `3afb2085:lib/features/courses/presentation/_widgets/course_detail_panel.dart:145`], 길찾기 버튼(`:149-152`), 코스 제목 `Text(course.title, ...)` 「40자 전체 — 줄 제한·말줄임 없음」 (`:156-157`), 뱃지 `BadgeView`(`:162`), 거리 `formatCourseDistance(l10n, distance)`(`:177-179`), 예상 시간 `CourseEstimateLine`(`:182`), 상태 표시 `CourseStatusMarks`(`:185`).
- 상세 화면 AppBar 제목은 코스 이름 1줄 말줄임: `title: title == null ? null : Text(title, maxLines: 1, overflow: TextOverflow.ellipsis)` [VERIFIED: `3afb2085:lib/features/courses/presentation/course_detail_screen.dart:100-103`].
- **만든 사람 표시는 화면에 없습니다.** 상세 화면은 `creatorId`를 내 코스 판정(`canDelete`, `isMine`)에만 씁니다 (`course_detail_screen.dart:93`, `:193`). 목록 카드 주석도 「만든 사람 식별자는 읽지 않고 `isMine` 만 쓴다(T-05-15)」입니다 (`course_list_card.dart` 머리 주석). ko 문자열에 「만든 사람」은 지워진 코스 안내 「만든 사람이 지운 코스예요」(`lib/l10n/app_ko.arb:298`)뿐입니다. 공유·신고 문자열은 없습니다 [VERIFIED: `git show 3afb2085:lib/l10n/app_ko.arb | grep`].
- 따라서 신고 메일에 적을 내용: **코스 이름, (보이면) 코스 이름 위의 지역 표시, 신고 이유, (있으면) 코스 화면 캡처.** 코스 ID·만든 사람은 사용자가 볼 수 없으므로 넣지 않습니다. 코스 이름이 겹칠 수 있으므로 캡처를 권하는 문장이 실용적입니다.

### 「회원탈퇴」까지 가는 경로 (FAQ 근거, D-16)
- 홈 화면 오른쪽 위 톱니 아이콘(툴팁 `settingsTitle` = 「설정」) → 설정 [VERIFIED: `3afb2085:lib/features/home/presentation/home_screen.dart:91-96`].
- 설정 맨 위 계정 행(제목 `settingsAccountSection` = 「내 계정」) → 계정 정보 화면 [VERIFIED: `3afb2085:lib/features/settings/presentation/settings_screen.dart:160-190`, `:188` `context.push(AppRoutes.account)`, `app_ko.arb:244`]. 계정 화면 AppBar 제목도 「내 계정」 (`account_screen.dart:95`).
- 계정 화면 맨 아래 「Danger zone」 묶음의 「회원탈퇴」 [VERIFIED: `account_screen.dart:175-177` `const DangerZoneSection()`, `danger_zone_section.dart:78` `l10n.settingsWithdrawalLabel`, `app_ko.arb:349` `"settingsWithdrawalLabel": "회원탈퇴"`].
- 주의 1: 묶음 제목은 ko 문자열에서도 영어 그대로 「Danger zone」입니다 (`app_ko.arb:347` `"settingsDangerZoneSection": "Danger zone"`). FAQ에는 묶음 이름을 쓰지 않고 「맨 아래」로 안내합니다.
- 주의 2: 계정 행은 **로그인한 사용자에게만** 있습니다. 게스트는 맨 위에 다른 행(「게스트로 이용 중 / 로그인 · 가입」)이 있습니다 (`settings_screen.dart:40-49` 주석 「정식 · 게스트가 같은 목록을 쓴다 — 맨 위 행 …」, `_GuestRow` `:192-`). FAQ 문장은 「로그인한 상태에서」로 시작합니다.
- 주의 3: 프로필 머리에서 계정 화면으로 바로 가는 길도 있습니다(`profile_header.dart:48` `context.push(AppRoutes.account)`). FAQ는 한 경로(설정)만 적어도 충분합니다.
- 주의 4: 현재 라이브 `/data-deletion/` 본문은 「설정 → 계정 삭제」라고 적혀 있어 앱과 다릅니다 [VERIFIED: `data-deletion/index.html:12` 읽음]. FAQ가 이 페이지로 링크하면 Phase 6 전까지 두 페이지 문구가 어긋납니다(Open Question 1).

## FAQ 문장안 (DATA-INVENTORY 범위 안, 계획 단계에서 다듬음)

근거: `.planning/baseline/DATA-INVENTORY.md:190-197` 「위치를 읽는 세 시점」 표와 그 아래 글머리 [VERIFIED: 읽음]. 원문 인용:
> | 에디터 (editor) | 코스를 그릴 때 지도 카메라와 내 위치 점. 10m 간격 | 저장하지 않음 |
> | 시작 전 (preStart) | 기록을 시작하기 전 위치 워밍업 | 저장하지 않음 |
> | 기록 중 (recording) | Android는 포그라운드 서비스 알림을 띄우고 받음. iOS는 화면이 꺼져도 받음 | 이 궤적만 `runs/{runId}.path`로 저장 |
> - 위치 권한은 「앱 사용 중」뿐입니다. … 「항상 허용」 권한은 요청하지 않습니다.
> - 서버에 저장되는 위치는 기록 중의 궤적(`runs/{runId}.path`)뿐입니다. 코스를 그리거나 시작 전 화면에서는 기기가 현재 위치를 읽지만 저장하지 않습니다.

**어긋남 정리:** SUP-04의 「기록 중에만 수집」을 맨 문장으로 쓰면, 에디터·시작 전 화면에서 위치를 **읽는** 사실과 부딪힐 수 있습니다(「수집」을 넓게 읽는 심사자). 그래서 첫 문장을 「저장」으로 묶고 읽기를 바로 밝힙니다. 「서버로 보내지 않는다」는 데이터 목록에 없는 주장이므로 쓰지 않습니다.

- **Q. 위치 정보는 언제 수집하나요?**
  A(안): 「위치는 기록 중에만 수집해 저장합니다. 기록을 시작한 때부터 끝낼 때까지 걷거나 달린 경로를 저장하며, 기록 중에는 화면이 꺼져 있어도 위치를 받습니다. Android에서는 이때 기록 중임을 알리는 알림이 표시됩니다. 코스를 그리거나 기록을 시작하기 전 화면에서는 지도에 현재 위치를 보여 주려고 위치를 읽지만 저장하지 않습니다. 위치 권한은 「앱 사용 중」만 요청합니다.」
  - 「화면이 꺼져도 기록 중이면 받음」을 Android까지 일반화한 것은 D-16(사용자 결정)을 따른 것입니다. 데이터 목록 표는 Android에 대해 「포그라운드 서비스 알림을 띄우고 받음」만 적었습니다.
- **Q. 러닝펜슬은 누가 운영하나요?** A(안): 「러닝펜슬의 운영 주체는 {{ site.data.company.trade_name | escape }}입니다. 대표자, 사업자등록번호, 주소는 이 페이지 아래쪽에서 볼 수 있습니다.」 — `dt`/`dd` 한 쌍을 `trade_name.size > 0` 조건으로 감쌉니다(빈 값 자리표시 금지).
- **Q. 계정은 어떻게 삭제하나요?** A(안): 「로그인한 상태에서 앱의 「설정」 → 「내 계정」 화면 맨 아래에 있는 「회원탈퇴」에서 계정을 삭제할 수 있습니다. 자세한 내용은 [데이터 삭제 안내](/data-deletion/)를 확인해 주세요.」 (삭제·보존 범위, 웹 요청은 쓰지 않음 — D-16)
- **Q. 다른 사람이 공개한 코스를 신고하려면?** A(안): 「지원 이메일로 알려 주세요. 메일에 적을 내용은 [공개 코스 신고](#report)에 있습니다.」

## Common Pitfalls

### Pitfall 1: `!= blank`가 항상 참
**What goes wrong:** 값이 없는 「상호 」「대표자 」 행이 빈 채로 라이브에 오름(자리표시 금지 위반, 카카오 심사 감점 요인).
**Why it happens:** Liquid 4.0.4의 `blank`는 `blank?` 메서드에 기대는데 Jekyll에는 ActiveSupport가 없음.
**How to avoid:** `.size > 0`. M1의 바이트 동일 판정이 이 실수를 바로 잡습니다(`!= blank`로 쓰면 빈 슬롯에서도 행이 생겨 diff가 남).
**Warning signs:** 빈 슬롯 빌드의 푸터에 「상호」 글자가 보임.

### Pitfall 2: Liquid `and`/`or`는 오른쪽부터 묶임
**What goes wrong:** `{% if a and a != empty or b and b != empty %}`가 뜻과 다르게 판정됨.
**Evidence:** `{% if false and true or true %}` → `F` (왼쪽부터라면 `T`) [VERIFIED: 스크래치 빌드, 이번 세션].
**How to avoid:** 줄 판정은 항목마다 비교 하나(`x.size > 0`)를 `or`로만 잇습니다.

### Pitfall 3: 「공통」 CSS를 M1에 섞음
**What goes wrong:** M1의 바이트 동일 판정이 실패하고, 리팩터와 시각 변경이 한 커밋에 섞임(Ground Rule).
**How to avoid:** CSS 두 줄은 별도 커밋. 그 커밋의 판정은 「diff가 `<style>` 안 두 줄 추가뿐」(`57a58,59` / `47a48,49`) + 화면 동일.

### Pitfall 4: 푸터 `mailto:` 링크가 기본 파란색
**What goes wrong:** `.rp-foot-legal`에는 `a` 규칙이 없어 이메일 링크가 브라우저 기본 파란색·보라색(방문 후)으로 `#2B2B2B` 위에 그려짐. 375px 캡처에서 두 엔진 모두 확인 [VERIFIED: Playwright 캡처, 이번 세션].
**How to avoid:** `.rp-foot-legal a { color: #FAFAF7; text-decoration: underline; }`(이미 `.rp-foot-nav a`가 쓰는 색, 새 hex 아님) 또는 `color: inherit; text-decoration: underline;`. 링크를 주변 글자와 색만으로 구분하지 않도록 밑줄을 둡니다. 대비: `#B5B0A7`/`#2B2B2B` ≈ 6.6:1, `#FAFAF7`/`#2B2B2B` ≈ 13:1 [ASSUMED: 손 계산, 도구 측정 아님].
**Warning signs:** 게이트 전에는 링크가 없어 안 보임 → CSS를 M2에 미리 넣고, 게이트 후보 캡처에서 다시 봄.

### Pitfall 5: FAQ `dl`의 질문·답 쌍 사이 간격이 0
**What goes wrong:** `legal.css`에는 `.rp-doc :where(… dl, dd …) { margin: 0; }`과 `.rp-doc dt { font-weight: 700; … }`만 있고 `dd + dt` 간격 규칙이 없어, 한 `dl` 안의 네 쌍이 붙어 보임 [VERIFIED: `_includes/css/legal.css:16`, `:28` 읽음]. 지금 법적 3종에는 `<dl>`이 없어 드러나지 않았습니다(`grep -c '<dl'` 세 파일 모두 0).
**How to avoid:** (권장) `legal.css`에 `.rp-doc dd + dt { margin-top: 12px; }`(값은 UI-SPEC에서) 한 줄을 별도 시각 커밋으로. 법적 3종 화면은 그대로(`dl` 없음)이고 `<style>` 바이트만 바뀝니다. 대안은 FAQ 항목마다 `<dl>`을 하나씩 두는 것(`section > * + *` 12px가 적용됨, CSS 변경 없음).

### Pitfall 6: `legal.css` 맨 위 주석을 고치면 법적 3종 출력이 바뀜
**What goes wrong:** D-13이 제안한 「앵커 `id`는 `section`에 둔다」 한 줄을 `legal.css` 머리 주석에 더하면, 그 주석은 `<style>` 안에 인라인되므로 법적 3종 출력 바이트가 바뀝니다(Phase 2 D-06의 머리 주석 예외와 같은 종류) [VERIFIED: `legal.css:1-4`가 주석이고 `_layouts/legal.html:18`에서 include됨].
**How to avoid:** 바이트 동일을 판정하는 커밋(M1)과 섞지 않습니다. `.planning/codebase/CONVENTIONS.md`만 고치거나, 주석 변경을 별도 커밋으로 둡니다.

### Pitfall 7: `EXPECTED_TITLES`를 먼저 `main`에 넣음
**What goes wrong:** 게이트 전 모든 푸시가 check-site 3번 항목에서 막힘(pre-push 훅은 작업 트리 스크립트로 점검).
**How to avoid:** 그 줄은 보류 묶음(H2)에만. 반대로 7번 가드는 조건부(`/support/`가 있을 때만)라 먼저 `main`에 넣어도 됩니다.

### Pitfall 8: 보류 묶음의 중간 커밋은 check-site에 실패함 (정상)
**What goes wrong:** H1~H3 커밋을 하나씩 `scripts/check-site.sh <SHA>`로 점검하면 7번 가드에서 실패(이메일이 아직 없어 `mailto:` 없음).
**How to avoid:** 이것이 가드가 동작한다는 **음성 대조**입니다. 보류 묶음 중간 커밋은 「7번 항목만 실패」를 기대값으로 기록하고, 통과는 게이트 커밋 G에서만 기대합니다.

### Pitfall 9: zsh에서 `dig +short $q`가 빈 출력
**What goes wrong:** zsh는 `$q`를 단어로 나누지 않아 `dig`가 아무것도 묻지 않음. 이번 세션에서 실제로 재현했습니다(세 질의 모두 빈 출력). `USER-TASKS.md`가 이미 `${=q}`로 경고함 [VERIFIED: USER-TASKS.md 「변경 전후 dig 명령」 읽음, 이번 세션 재현].
**How to avoid:** 질의를 직접 쓰거나 `${=q}`.

### Pitfall 10: 로컬 리졸버의 부정 캐시
**What goes wrong:** 같은 시각에 기본 리졸버(`168.126.63.1`)는 TXT 0줄, 권한 있는 네임서버 `ns1.gabia.co.kr`과 `1.1.1.1`은 2줄을 돌려줌 [VERIFIED: 이번 세션 `dig` 비교]. 「아직 반영 안 됨」으로 잘못 판단할 수 있음.
**How to avoid:** 증거는 `dig +short @ns1.gabia.co.kr …`(권한 있는 서버)와 공개 리졸버 하나를 함께 기록. 토큰 값은 기록하지 않고 종류(`v=spf1`, `google-site-verification`)와 줄 수만 적습니다.

### Pitfall 11: 한국어 조사와 Liquid 값
**What goes wrong:** 「{{ 상호 }}가」처럼 조사를 붙이면 받침에 따라 틀림. 이메일 뒤 「로/으로」도 같음.
**How to avoid:** 「운영 주체는 … 입니다」, 「아래 지원 이메일로 보내 주세요」 + 주소를 따로 둠.

## Code Examples

### 1. 푸터 템플릿 (이번 세션 빌드로 확인한 그대로, `_includes/footer.html`의 운영 안내 `<p>` 다음)
```liquid
                <p>러닝펜슬은 슬림펌킨이 운영하는 서비스입니다.</p>
                {%- if site.data.company.trade_name.size > 0 or site.data.company.representative.size > 0 or site.data.company.biz_reg_no.size > 0 %}
                <p class="rp-foot-biz">
{%- if site.data.company.trade_name.size > 0 %}<span>상호 {{ site.data.company.trade_name | escape }}</span>{% endif %}
{%- if site.data.company.representative.size > 0 %}{% if site.data.company.trade_name.size > 0 %} · {% endif %}<span>대표자 {{ site.data.company.representative | escape }}</span>{% endif %}
{%- if site.data.company.biz_reg_no.size > 0 %}{% if site.data.company.trade_name.size > 0 or site.data.company.representative.size > 0 %} · {% endif %}<span>사업자등록번호 {{ site.data.company.biz_reg_no | escape }}</span>{% endif %}</p>
                {%- endif %}
                {%- if site.data.company.address.size > 0 %}
                <p>주소 {{ site.data.company.address | escape }}</p>
                {%- endif %}
                {%- if site.data.company.support_email.size > 0 or site.data.company.phone.size > 0 %}
                <p>
{%- if site.data.company.support_email.size > 0 %}<span>이메일 <a href="mailto:{{ site.data.company.support_email | escape }}">{{ site.data.company.support_email | escape }}</a></span>{% endif %}
{%- if site.data.company.phone.size > 0 %}{% if site.data.company.support_email.size > 0 %} · {% endif %}<span>전화 {{ site.data.company.phone | escape }}</span>{% endif %}</p>
                {%- endif %}
                <p>© 2026 슬림펌킨. All rights reserved.</p>
```
// Source: 이번 세션 스크래치 빌드 [VERIFIED]
- 확인한 출력(가짜 값): 모두 채움 → `<p class="rp-foot-biz"><span>상호 가상상호</span> · <span>대표자 가상대표</span> · <span>사업자등록번호 000-00-00000</span></p>` / 주소 줄 / 이메일 줄. 대표자만 → `<span>대표자 가상대표</span>` 하나(구분 기호 없음). 상호+번호 → `상호 … · 사업자등록번호 …`(가운데 하나). 전화만 → `<p><span>전화 02-000-0000</span></p>`. `A&B <x>` → `A&amp;B &lt;x&gt;`(escape 동작).
- `class="rp-foot-biz"`는 아래 CSS가 쓰지 않으므로 빼도 됩니다(거짓 분기 안이라 빈 슬롯 바이트 동일 판정과 무관).
- `{%-`는 `if`/`endif`에만 쓰였고, 0열의 `{%- if` 줄은 앞 줄바꿈을 지워 `<p>` 안을 한 줄로 만듭니다(include 공백 규칙 준수).
- Pattern 3 선택지 2(`&nbsp;· `)를 고르면 위 ` · ` 세 곳을 바꿉니다.

### 2. `_data/company.yml` (M1, 모든 값 빈 문자열)
```yaml
# 사실값 슬롯. 사이트의 사업자 정보·연락처는 이 파일 한 곳에서만 고친다 (BIZ-02).
# - 값이 없으면 "" 로 둔다. 빈 값은 화면에 그리지 않는다 (render-if-present). 「추후 기재」 같은 자리표시는 쓰지 않는다.
# - 값은 모두 큰따옴표로 감싼다 (따옴표 없는 숫자는 앞자리 0이 사라질 수 있다). 공백만 넣지 않는다.
# - 템플릿은 `site.data.company.<키>.size > 0` 으로 판정한다. `!= blank` 는 로컬 Jekyll 3.10.0(Liquid 4.0.4) 빌드에서 항상 참이어서 쓰지 않는다.
# - support_email 은 이메일 게이트(외부 4곳 수신 시험 통과)를 Claude가 확인한 뒤에만 채운다 (D-19, Phase 5 D-05).
# - 사업자등록증 표기 그대로 쓴다. 이 값은 .planning/ 문서·커밋 메시지에 적지 않는다 (저장소 PUBLIC, D-02).
trade_name: ""        # 상호
representative: ""    # 대표자
biz_reg_no: ""        # 사업자등록번호
address: ""           # 주소 (사업자등록증 표기 전체, D-10)
support_email: ""     # 지원 이메일 (게이트 뒤)
phone: ""             # 전화번호 (칸만, U1·BIZ-03)
```
// 키 이름은 재량(Claude's Discretion). 위 이름으로 이번 세션 빌드를 확인했습니다. 영문 법인명 키는 Phase 9에서 더하는 것을 권합니다(지금 쓰는 곳이 없음).

### 3. `support/index.html` 골격 (보류 묶음 H1, 이번 세션 미빌드 — 계획 단계에서 빌드로 확인)
```html
---
layout: legal
title: "고객 지원"
description: "러닝펜슬 문의 방법, 공개 코스 신고 방법, 자주 묻는 질문을 안내합니다."
eyebrow: "SUPPORT"
heading: "러닝펜슬 고객 지원"
updated: "2026년 11월 OO일"
---
{%- if site.data.company.support_email.size > 0 %}
                    <section id="contact">
                        <h2>문의하기</h2>
                        <p>러닝펜슬을 이용하다 궁금한 점이나 문제가 생기면 아래 지원 이메일로 보내 주세요. 영업일 기준 3일 안에 답장합니다.</p>
                        <p><a href="mailto:{{ site.data.company.support_email | escape }}">{{ site.data.company.support_email | escape }}</a></p>
{%- if site.data.company.phone.size > 0 %}
                        <p>전화 {{ site.data.company.phone | escape }}</p>
{%- endif %}
                    </section>

                    <section id="report">
                        <h2>공개 코스 신고</h2>
                        <p>다른 사람이 공개한 코스에 문제가 있으면 위 지원 이메일로 알려 주세요. 메일에 아래 내용을 적어 주세요.</p>
                        <ul>
                            <li>코스 이름</li>
                            <li>코스 이름 위에 보이는 지역 (보일 때)</li>
                            <li>신고하는 이유</li>
                            <li>코스 화면 캡처 (있으면)</li>
                        </ul>
                    </section>
{%- endif %}

                    <section id="faq">
                        <h2>자주 묻는 질문</h2>
                        <dl>
                            …(「FAQ 문장안」 절의 dt/dd 네 쌍. 운영 주체 쌍은 trade_name.size > 0 조건)…
                        </dl>
                    </section>
```
// `updated`는 게이트 커밋 G에서 그날 날짜로. `noindex`·「임시 게시본」 `<footer>` 없음(D-12). 들여쓰기는 법적 3종 본문과 같은 20칸. `section`의 `id` 세 개는 D-13 고정 [ASSUMED: 골격 전체는 이번 세션에 빌드하지 않음 — 첫 계획 task에서 빌드·check-site로 확인].

### 4. 헤더·푸터 링크 (보류 묶음 H3)
```html
<!-- _includes/header.html nav 끝 (home 여부와 상관없이 절대 경로, D-18) -->
                <a href="/support/">고객 지원</a>
<!-- _includes/footer.html -->
                <nav class="rp-foot-nav" aria-label="약관 및 지원">
                    …기존 세 링크…
                    <a href="/support/">고객 지원</a>
                </nav>
```

### 5. 「공통」 CSS 두 줄 (M2, `@media (max-width: 860px)` 줄 바로 앞)
```css
        .rp-foot-legal span { display: inline-block; }
        .rp-foot-legal a { color: #FAFAF7; text-decoration: underline; }
```
// 이번 세션 빌드로 출력 차이(두 줄 추가)와 375px 줄바꿈 확인 [VERIFIED]. 링크 색 값은 UI-SPEC에서 확정.

### 6. check-site 7번 가드 (M3, `main`에 먼저. 설계안 — 이번 세션 미실행)
```bash
# ── 7. 지원 페이지와 연락처 (이메일 게이트, Phase 5 D-04) ──
# /support/가 출력에 있으면 mailto 연락처가 있어야 한다. /support/로 가는 링크가 있으면 그 페이지가 있어야 한다.
# 게이트 전에는 /support/가 없으므로 이 항목은 그냥 지나간다. 보류 커밋이 main에 섞이면 여기서 푸시가 멈춘다.
if [ -f "$DEST/support/index.html" ]; then
    grep -qF 'href="mailto:' "$DEST/support/index.html" \
        || problem '지원 페이지에 연락처(mailto)가 없습니다: 이메일 게이트 전의 /support/는 배포하지 않습니다 (D-04)'
fi
sup_links=$(grep -rlF 'href="/support/' --include='*.html' "$DEST" 2>/dev/null)
if [ -n "$sup_links" ] && [ ! -f "$DEST/support/index.html" ]; then
    problem "지원 페이지 없이 /support/ 링크가 있습니다: ${sup_links//$DEST/}"
fi
```
// 6번 항목처럼 grep 종료 코드 2 이상을 오류로 다루는 처리를 더할지 계획에서 정합니다. 스크립트 머리 주석 「여섯 가지」와 이를 옮겨 적은 문서(CLAUDE.md 두 벌, CONVENTIONS·STACK·ARCHITECTURE의 점검 항목 수)도 함께 고칩니다(Phase 4 06에서 같은 일을 함) [ASSUMED: 설계안, 계획 첫 task에서 양성(기준 커밋 통과)·음성(이메일 없는 지원 페이지 사본 실패) 대조로 확인].

### 7. 게이트 전후 주소 확인 (주소 문자열을 명령에 적지 않음)
```bash
ADDR=$(grep -oE '[A-Za-z0-9._%+-]+@runningpencil\.com' .planning/baseline/NAMES.md | head -n 1)
# 게이트 전: 원격 main의 이력 어디에도(.planning 밖) 주소가 없다 → 빈 출력
git log -S"$ADDR" --format=%h --abbrev=12 origin/main -- . ':(exclude).planning'
# 게이트 푸시 뒤: 주소를 처음 더한 커밋은 게이트 커밋 G 하나
git log -S"$ADDR" --reverse --format=%h --abbrev=12 origin/main -- . ':(exclude).planning' | head -n 1
```
// 이번 세션 기준 `git log -S"$ADDR" -- . ':(exclude).planning'`은 빈 출력, `.planning` 포함 전체는 11개 커밋 [VERIFIED: 이번 세션 실행]. `README.md`·`CLAUDE.md`는 사이트에서 빠지지만 이 확인은 `.planning` 밖 전부를 보므로 더 엄격합니다. D-21 문서 갱신 때 `CLAUDE.md`에 주소를 적지 않고 `_data/company.yml`의 키로 가리킵니다.

### 8. 사업자 값 누출 확인 (값을 화면·기록에 찍지 않음)
```bash
# 스크래치(저장소 밖)에 값 목록을 만들고, .planning 변경분·커밋 메시지에서 개수만 센다
ruby -ryaml -e 'c = YAML.load_file("_data/company.yml"); %w[trade_name representative biz_reg_no address].each { |k| v = c[k].to_s.strip; puts v unless v.empty? }' > "$W/vals"
git diff --cached -- .planning | grep -c -F -f "$W/vals"      # 0이어야 함
git log -1 --format=%B | grep -c -F -f "$W/vals"               # 0이어야 함
rm -f "$W/vals"
```
// `support_email`은 뺍니다(주소는 이미 `NAMES.md`에 있음, 설계상 허용). 값이 짧으면(예: 세 글자 이름) 다른 낱말과 겹쳐 0이 아닐 수 있으니, 0이 아니면 걸린 줄의 `파일:행`만 보고 사람이 판단합니다 [ASSUMED: 설계안].

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| ARCHITECTURE Pattern 1 `!= blank` | `.size > 0` | 이번 연구(2026-11-19) | 이후 Phase 6~9의 `_data` 참조도 같은 판정을 씀 |
| Phase 4 후보 객체(`commit-tree`, ref 없음)로 승인 대기 | 이름 붙은 보류 브랜치 + 별도 worktree | 이번 단계 | 대기가 며칠 이상이라 gc·체크아웃 혼선 위험을 없앰 |

**Deprecated/outdated:**
- CONTEXT D-01의 「MX와 TXT는 0건」: 오늘 이후 바뀜(「환경 확인」).

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | 도달 불가 git 객체는 기본 2주 뒤 gc로 지워질 수 있음 | Pattern 4 | 낮음 — 어차피 이름 붙은 ref를 쓰라는 권고라 결론이 바뀌지 않음 |
| A2 | front matter 값은 Liquid로 렌더되지 않음 | Anti-Patterns | 낮음 — 지원 페이지 front matter에 Liquid를 쓰지 않으면 무관 |
| A3 | 대비 6.6:1·13:1 (손 계산) | Pitfall 4 | 낮음 — 기존 푸터 색이고 UI 감사에서 측정 가능 |
| A4 | check-site 7번 가드 설계안이 의도대로 동작 | Code Example 6 | 중간 — 계획 첫 task의 양성·음성 대조로 확인해야 함 |
| A5 | 지원 페이지 골격이 그대로 빌드됨 | Code Example 3 | 중간 — 빌드·check-site·화면으로 확인 |
| A6 | 값 누출 확인의 짧은 값 오탐 | Code Example 8 | 낮음 — 0이 아니면 사람이 확인 |
| A7 | 따옴표 없는 다른 숫자 꼴의 YAML 해석 | Pattern 1 | 낮음 — 「모두 큰따옴표」 규칙으로 피함 |

## Open Questions

1. **FAQ의 `/data-deletion/` 링크와 현재 삭제 안내의 「설정 → 계정 삭제」 불일치**
   - What we know: 앱은 「설정 → 내 계정 → 회원탈퇴」, 현재 라이브 삭제 안내는 「설정 → 계정 삭제」(임시 게시본, Phase 6에서 재작성).
   - What's unclear: 게이트가 Phase 6보다 먼저 열리면 며칠간 두 페이지 문구가 어긋남.
   - Recommendation: FAQ는 앱 코드대로 쓰고, 불일치를 Phase 6 입력으로 기록. 또는 게이트 커밋과 같은 푸시에 Phase 6을 맞추는 것은 범위가 커지므로 권하지 않음. 사용자 확인 사항.
2. **`updated` 날짜 기준**
   - What we know: D-12는 「페이지 커밋 날짜」. 보류 브랜치의 H1은 게이트보다 며칠 이를 수 있음.
   - Recommendation: 게이트 커밋 G에서 공개 날짜로 씀(라이브에 처음 오르는 날과 같게). 사용자 확인 사항.
3. **푸터 구분 기호의 줄바꿈 위치** — Pattern 3 선택지 1~4 중 선택(UI-SPEC 또는 D-10 승인 때).
4. **FAQ `dl` 간격** — `.rp-doc dd + dt` 규칙 추가(시각 커밋) 또는 항목마다 `dl` 하나. 값(12px 등)은 UI-SPEC.
5. **DNS 진행 상태** — 권한 있는 네임서버에 MX·SPF·`google-site-verification` 1줄이 이미 있음. Workspace 인증 TXT와 Search Console TXT는 같은 접두어라 1줄이 어느 쪽인지 알 수 없음(USER-TASKS 기대: 1~2줄). Workspace를 다른 방법으로 인증했는지 사용자 확인이 필요. D-06의 「변경 전」 기록은 CONTEXT D-01(오늘 아침 0건)을 쓰고, 「변경 후」를 지금 값으로 기록.

## Environment Availability

| Dependency | Required By | Available | Version | Fallback |
|------------|------------|-----------|---------|----------|
| Homebrew Ruby + Bundler | 로컬 빌드, check-site | ✓ | ruby 4.0.9, bundler 4.0.23 | — |
| Jekyll (vendor/bundle) | 빌드 | ✓ | 3.10.0 | — |
| Liquid | 템플릿 | ✓ | 4.0.4 | — |
| pre-push 훅 | 푸시 점검 | ✓ | `core.hooksPath=.githooks` | — |
| Node / pnpm | Playwright 스크래치 | ✓ | node v24.14.0, pnpm 있음 | — |
| Playwright 스크래치 | 화면 측정 | ✓ (Phase 4 스크래치 `$TMPDIR/rp-p4/pw`, 1.59.1) | 1.59.1 | 사라지면 같은 고정 버전 재설치(승인) |
| `dig` | DNS 증거 | ✓ `/usr/bin/dig` | — | — |
| 앱 저장소 | 사실 확인 | ✓ (작업 트리는 고침 있음, `git show 3afb2085:`로만 읽음) | `3afb2085` | — |

**현재 DNS (2026-11-19, 권한 있는 네임서버 `ns1.gabia.co.kr` 기준)** [VERIFIED: 이번 세션 `dig`]:
- A: GitHub Pages 4개 그대로 / `www` CNAME `slimpumpkin.github.io.` 그대로 / `_github-pages-challenge-SlimPumpkin` TXT 1줄 그대로.
- MX: `1 smtp.google.com.` (공개 리졸버 `8.8.8.8`도 같음).
- `runningpencil.com` TXT: 2줄 — 종류 `v=spf1` 1줄, `google-site-verification` 1줄. SPF 개수 1.
- DKIM(`google._domainkey`): 0줄 (작업 6 전, 단계 완료를 막지 않음).
- `https://runningpencil.com/` → `HTTP/2 200`, `/support/` → 404(아직 없음).
- 라우터 A 레코드는 공개 저장소 규칙상 호스트 이름을 모르므로 확인하지 않음(no observation).

**Missing dependencies with no fallback:** 없음 (사이트 작업 기준). 게이트는 사용자 작업 3~5·7 완료가 필요.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | 없음(테스트 러너 없음). `scripts/check-site.sh`(빌드+6항목, 이 단계에서 7항목) + 스크래치 `lib.sh`(`build`/`build_src`/`serve`/`stop`, Phase 4 계약) + Playwright 1.59.1 스크래치 스크립트 |
| Config file | `scripts/check-site.sh` 맨 위 `EXPECTED_TITLES`, `.githooks/pre-push` |
| Quick run command | `scripts/check-site.sh <후보 SHA>` |
| Full suite command | `scripts/check-site.sh <후보>` + `. "$W/lib.sh"; build <이름> <후보>` + `diff -r`/`cmp` + `node "$W/pw/<스크립트>.mjs"` (두 엔진 × 375/1280) + 훅 경로 `printf 'refs/heads/main %s refs/heads/main %s\n' <후보> <원격> \| .githooks/pre-push` |

### Phase Requirements → Test Map
| Req ID / SC | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| BIZ-02 (M1) | 빈 슬롯+템플릿이 네 문서 출력을 바꾸지 않음 | 바이트 비교 | `build base <BASE>; build c1 <CAND>; diff -r "$W/base/site" "$W/c1/site"` 빈 출력 | ❌ Wave 0 (`$W=$TMPDIR/rp-p5`, `lib.sh` 복사) |
| BIZ-02 | 빈 값·null·키 없음은 행 없음, 부분 값은 그 항목만 | 스크래치 변형 빌드 | 스크래치 사본에서 `_data/company.yml`만 바꿔 `build_src`, 푸터 블록 추출 후 행·구분 기호 수 확인(이번 세션 v.sh와 같은 꼴) | ❌ Wave 0 |
| M2 (CSS) | 출력 차이가 `<style>` 안 두 줄뿐 | diff 행 머리 | `diff "$W/c1/site/$f" "$W/c2/site/$f" \| grep -E '^[0-9]'` → `57a58,59`(랜딩)·`47a48,49`(법적 3종) | ❌ Wave 0 |
| BIZ-01 / SC3 | 값 커밋 뒤 네 문서 푸터에 행이 있음, 값은 기록하지 않음 | grep 개수 | 푸터 블록에서 `<span>상호`·`<span>대표자`·`<span>사업자등록번호`·`<p>주소` 각 1개 × 4문서 | ❌ |
| BIZ-01 (D-07) | 375px에서 항목 중간 끊김 없음, 가로 넘침 없음, 링크 색 | Playwright | `span` 높이 ≤ 한 줄, `scrollWidth == 375`, `getComputedStyle(a).color`가 정한 색 (Chromium·WebKit) | ❌ Wave 0 |
| BIZ-03 / SC4 | `phone`만 채우면 푸터·`#contact`에 「전화」 행, 비우면 어디에도 없음 | 스크래치 변형 | 출력 전체 `grep -c '전화'` → 빈 값 0(기준 출력도 0, 이번 세션 확인) | ❌ |
| SC4 | `_data` 한 파일만 고쳐 반영 | git diff | 값 커밋 `git diff --name-only <부모> <커밋>` = `_data/company.yml` 하나 | — |
| SUP-02 / SC1 | 게이트 전 주소 비공개, 게이트 커밋이 처음 | git | Code Example 7 (주소는 NAMES.md에서 읽음) | — |
| SUP-02 / SC1 | 수신 시험 네 행 모두 받은편지함 | manual | 사용자가 넘긴 표를 Claude가 확인, 「4/4 도착」만 기록(시각·주소 미기록) | manual-only (외부 메일) |
| D-04 | 보류 묶음이 게이트 전 원격의 조상이 아님 | git | `! git merge-base --is-ancestor p5-support-hold origin/main` && `test -z "$(git branch -r --contains p5-support-hold)"` | — |
| D-04 가드 | 연락처 없는 `/support/`·페이지 없는 링크를 훅이 막음 | 양성·음성 대조 | 기준 커밋 `check-site` 통과 / 보류 H1 커밋 `check-site`가 7번 항목으로 실패 | ❌ Wave 0 |
| SUP-01 / SC5 | `/support/` h1에 「러닝펜슬」, 제목 「고객 지원 - 러닝펜슬」, 이메일·응답 안내 | check-site 3번 + grep | `EXPECTED_TITLES` 줄, `grep -c '러닝펜슬 고객 지원'`, `#contact` 안 `mailto:` 1개 | ❌ |
| SUP-03 / SC5 | `#report`에 적을 내용 목록 | grep | `id="report"` 구간 `li` 개수와 「만든 사람」 0 | ❌ |
| SUP-04 / SC5 | FAQ 네 쌍, 운영 주체가 `_data` 값 | grep + 비교 | `dt` 4개, 운영 주체 `dd` 안 상호 문자열이 푸터 상호와 같은지(값은 화면에만, 기록은 같음/다름) | ❌ |
| SC5 | 헤더·푸터에서 `/support/`로 갈 수 있음 | grep + Playwright | 네 문서 모두 `href="/support/"` 2개(헤더+푸터), 1280px 헤더 링크 보임·375px 푸터 링크 보임 | ❌ |
| D-13 | 앵커 순서 `contact` → `report` → `faq` | grep 순서 | `grep -o 'section id="[a-z]*"'` 출력이 정확히 세 줄 그 순서 | ❌ |
| SC2 / SITE-03 | MX·SPF 1개·Search Console TXT, HTTPS 200, Search Console 확인됨 | dig + curl + manual | `dig +short @ns1.gabia.co.kr runningpencil.com MX`, TXT의 `v=spf1` 개수 1·`google-site-verification` ≥1, `curl -sI https://runningpencil.com/ \| head -1` → `HTTP/2 200`. 「확인됨」은 사용자 보고(작업 7) | 반 manual |
| D-06 | 작업 5(보내기 설정) 끝남 | manual | 사용자 한 줄 보고(작업 5 「Claude에게 넘길 것」) | manual-only |
| 매 푸시 | 기존 세 URL 200·제목, 라이브 바이트 | curl | Phase 4와 같은 라이브 확인(`?cb=<SHA>`), 라이브 `/`가 후보 빌드와 같은지 | — |
| D-02 | 사업자 값이 `.planning`·커밋 메시지에 없음 | grep 개수 | Code Example 8 | — |

### Sampling Rate
- **Per task commit:** 후보 SHA로 `scripts/check-site.sh` (보류 묶음 중간 커밋은 「7번 항목만 실패」가 기대값) + 해당 커밋의 출력 판정(바이트 동일 / 의도한 줄만)
- **Per push:** 훅 경로 점검 + 라이브 확인(네 URL 200·제목, 라이브 바이트 = 후보 빌드)
- **Phase gate:** 위 표 전부 + 두 엔진 × 375/1280 캡처를 사용자에게 보임(값은 `.planning`에 남기지 않음)

### Wave 0 Gaps
- [ ] `$TMPDIR/rp-p5/lib.sh` — Phase 4 `lib.sh`를 복사해 `W`만 바꿈 (절대 경로 금지 규칙 유지)
- [ ] `$W/pw/p5-foot.mjs` — 푸터 측정(항목 높이, `scrollWidth`, 링크 색), `p5-support.mjs` — 지원 페이지 구조(앵커 순서, `dt` 수, 헤더/푸터 링크)
- [ ] check-site 7번 가드 양성·음성 대조 기록
- [ ] Playwright는 Phase 4 스크래치 재사용(없으면 고정 버전 재설치 checkpoint)

## Security Domain

### Applicable ASVS Categories

| ASVS Category | Applies | Standard Control |
|---------------|---------|-----------------|
| V2 Authentication | no | 사이트에 로그인 없음 |
| V3 Session Management | no | — |
| V4 Access Control | no | 정적 사이트 |
| V5 Validation/Encoding | yes | `_data` 값 출력에 Liquid `escape` (이번 세션 `A&B <x>` → `A&amp;B &lt;x&gt;` 확인). `mailto:` href에도 `escape` |
| V6 Cryptography | no | — |
| V8 Data Protection / Privacy | yes | 사업자 값(대표자 이름·주소)은 공개 결정된 값만, 대화로 받아 사이트 커밋에만(D-02), 푸시 전 사용자 승인(D-10). 주소는 게이트 뒤에만 |
| V14 Configuration | yes | 비밀값 없음. pre-push 훅 켜짐 확인, `--no-verify` 금지 |

### Known Threat Patterns for 정적 사이트 + 공개 저장소

| Pattern | STRIDE | Standard Mitigation |
|---------|--------|---------------------|
| 수신 확인 전 주소 공개(메일 유실, 심사 연락 실패) | Information Disclosure / Denial | 이메일 게이트, 보류 브랜치, check-site 7번, `git log -S` 확인 |
| 사업자 값이 `.planning`·커밋 메시지·EVIDENCE로 새어 이력에 영구 보존 | Information Disclosure | D-02, Code Example 8 개수 확인, 값은 대화로만 |
| 승인과 다른 SHA 배포 | Tampering | SHA 이름으로 승인, `<SHA>:refs/heads/main`만 푸시, 원격 그대로인지 확인(Phase 4 T-04-10) |
| `_data` 값의 HTML 문자로 마크업 깨짐 | Tampering | `escape` 필터 |
| 연락처 없는 지원 페이지·404 링크 노출 | Repudiation(심사 반려) | check-site 7번 가드 |
| 주소 수집 봇 스팸 | — (수용) | 평문 `mailto:` 유지(ARCHITECTURE Anti-Pattern 4). 스팸 필터는 Workspace 쪽 |

## Project Constraints (from CLAUDE.md)

- `main` 푸시 = 배포. 모든 단계는 라이브에 올라가도 되는 상태로 끝냄. 푸시는 SHA마다 사용자 승인.
- 기존 URL `/privacy-policy/`, `/terms/`, `/data-deletion/` 경로·리디렉션 불변, 배포마다 200·제목 확인.
- 리팩터·시각 변경·내용 변경을 한 커밋에 섞지 않음.
- 푸시 전 로컬 Jekyll 3.10.0 빌드 성공(`scripts/check-site.sh`).
- 사용자 사실값을 추측해 채우지 않음, 값 없으면 행·문단 숨김(render-if-present), 「추후 기재」 금지.
- JS 언어 자동 리디렉션·`robots.txt` 차단·`.nojekyll`·i18n 플러그인 금지.
- 방침·구조를 바꾸면 같은 단계에서 두 `CLAUDE.md`(방침 구간은 같은 커밋), `.claude/CLAUDE.md` GSD 구간은 원본 맵 수정 후 `generate-claude-md`로 재생성.
- 법적 본문은 DATA-INVENTORY의 사실만.
- 법적 본문 작성 규칙 D-01~D-12: HTML 원본, `section`+`h2`, 허용 요소만·클래스 없음, `figure` 표 규칙.
- include 공백 규칙: include 태그 0열, include 파일 끝 줄바꿈 없음, `{%-`는 `if`/`endif`에만. (이번 세션 수정본도 끝 줄바꿈 없음 확인)
- raw 규칙: 인라인 JS·CSS에 `{{`·`{%`가 생기면 `{% raw %}`.
- 이메일 수집 폼 없음. 지원 이메일은 게이트 전 HTML·`_data`에 넣지 않음.
- 새 루트 파일·폴더는 `_config.yml` `exclude` 확인 (`support/`는 출력 대상이라 넣지 않음, `_data/`는 `_`로 시작해 해당 없음).
- 색: 새 hex를 늘리지 않음. 노랑 `#F2B134`를 밝은 바탕 글자색으로 쓰지 않음. 다크 모드 없음. 클릭 대상 44px, `:focus-visible` 유지.
- 커밋: Conventional Commits, prefix 영어·제목 한국어. 커밋 전 「린터」는 `scripts/check-site.sh`.
- 전역: 한국어 응답·주석, 민감 데이터 하드코딩 금지, 대규모 리팩터 전 확인.

## Sources

### Primary (HIGH confidence)
- 이번 세션 로컬 스크래치 빌드(저장소 `Gemfile`의 Jekyll 3.10.0, Liquid 4.0.4, `--safe`, `JEKYLL_ENV=production`)와 vendored `liquid-4.0.4/lib/liquid/condition.rb`·`expression.rb`: `blank`/`empty`/`size` 판정, `and`/`or` 순서, 빈 슬롯 바이트 동일, CSS 커밋 diff 범위, 푸터 변형 출력
- 이번 세션 Playwright 1.59.1(Chromium·WebKit, 375px) 측정과 캡처
- 저장소 파일: `_includes/footer.html`, `_includes/header.html`, `_includes/css/common.css`, `_includes/css/legal.css`, `_layouts/legal.html`, `scripts/check-site.sh`, `.githooks/pre-push`, `_config.yml`, `data-deletion/index.html`
- 기준 문서: `.planning/baseline/NAMES.md`, `URLS.md`, `DATA-INVENTORY.md:186-198, 250-262`, `DECISIONS.md`(U6·U11·U12·N3·N7 행), `USER-TASKS.md` 작업 4·5·7·dig 절
- 앱 저장소 `3afb2085`: `course_detail_panel.dart`, `course_detail_screen.dart`, `course_list_card.dart`, `settings_screen.dart`, `account_screen.dart`, `danger_zone_section.dart`, `home_screen.dart`, `app_ko.arb`
- `dig`(권한 있는 `ns1.gabia.co.kr`, `8.8.8.8`, `1.1.1.1`), `curl`
- gsd-tools package-legitimacy, npm registry

### Secondary (MEDIUM confidence)
- Phase 2·4 EVIDENCE·PLAN의 검증 절차(`lib.sh`, 후보 절차, 라이브 확인)

### Tertiary (LOW confidence)
- git gc 기본 보존 기간(학습 지식)

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH — 새 의존성 없음, 버전을 실행으로 확인
- Architecture: HIGH — 템플릿·바이트 동일·줄바꿈을 실제 빌드·브라우저로 확인. 보류 브랜치 절차는 git 동작에 기댄 설계(MEDIUM-HIGH)
- Pitfalls: HIGH — 대부분 이번 세션 재현

**Research date:** 2026-11-19
**Valid until:** 2026-12-19 (Jekyll·Liquid 버전은 GitHub Pages가 바꾸지 않는 한 고정. DNS 상태는 사용자 작업에 따라 수시로 바뀜)
