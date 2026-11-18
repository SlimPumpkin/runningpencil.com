# Phase 5: 사업자 정보와 지원 연락 경로 (Business Info & Support Contact) - Context

**Gathered:** 2026-11-19
**Status:** Ready for planning

<domain>
## Phase Boundary

이 단계가 만드는 것:

- 사실값 슬롯 `_data/company.yml` 한 파일. 상호, 대표자, 사업자등록번호, 주소, 지원 이메일, 전화번호를 담고, 값이 없는 항목은 화면에 그리지 않습니다(render-if-present).
- 모든 페이지가 함께 쓰는 푸터(`_includes/footer.html`)의 사업자 정보 행과 지원 이메일 행.
- 한국어 지원 페이지 `/support/` (`support/index.html`, 법적 레이아웃).
- 헤더와 푸터의 「고객 지원」 링크.
- 이메일 게이트 확인: 외부 4곳 수신 시험 기록을 확인한 뒤에만 지원 이메일을 `_data`에 넣습니다.
- 사용자가 하는 DNS·Search Console 작업(USER-TASKS 작업 0~5, 7)이 끝났는지 확인하는 단계. SITE-03이 여기에 속합니다.

이 단계에 넣지 않는 것:

- 영문 지원 페이지 `/en/support/`와 영문 사업자 표기: Phase 9.
- 처리방침·약관·삭제 안내 본문 재작성: Phase 6~8. 이 문서들이 `_data` 값을 참조하는 일도 그 단계에서 합니다.
- DKIM(작업 6, 2차 방문): Phase 10의 Apple 릴레이 답장(SUP-05)에 필요하지만 이 단계 완료를 막지 않습니다.
- 콘솔 등록(App Store Support URL 등): Phase 10. 등록은 게이트 뒤에만 합니다.
- 앱 쪽 변경(설정의 지원 링크, 코스 신고 버튼): 앱 저장소의 일입니다. 아래 Deferred에 적었습니다.

</domain>

<decisions>
## Implementation Decisions

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
  - **정정 (2026-11-19, plan-phase에서 사용자 확인):** 같은 날 연구 시점에는 권한 있는 네임서버(`ns1.gabia.co.kr`)에 MX `1 smtp.google.com.`, SPF 1줄, `google-site-verification` TXT 1줄이 있었고 DKIM은 0줄이었습니다. 사용자는 **작업 3까지 끝냈다**고 확인했습니다(도메인 인증, Gmail 켜기, `support` 주소 만들기). 작업 4(외부 4곳 수신 시험)부터는 아직입니다. TXT가 1줄인 것은 **Workspace 인증 값과 Search Console 인증 값이 같았기 때문**입니다(사용자 확인). Search Console 도메인 속성의 「확인됨」 상태(작업 7)와 작업 5는 실행 단계에서 사용자 보고로 확인합니다. D-06의 「변경 전」 `dig` 기록은 이 항목 위의 0건 확인을 쓰고, 「변경 후」는 실행 시점의 권한 있는 네임서버 결과로 남깁니다.
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
  - **정정 (2026-11-19, plan-phase에서 사용자 확인):** 판정은 `!= blank`가 아니라 **`.size > 0`**으로 합니다. 로컬 Jekyll 3.10.0 / Liquid 4.0.4 빌드에서 `x != blank`는 값이 빈 문자열이든 null이든 키가 없든 늘 참이었습니다(`05-RESEARCH.md` Pattern 1·Pitfall 1). `.size > 0`은 빈 문자열, null, 키 없음, 파일 없음이 모두 거짓입니다. 이 결정의 의도(값이 없는 항목은 행째 숨김, 구분 기호가 매달리지 않음)는 그대로입니다. `.planning/research/ARCHITECTURE.md` Pattern 1의 예시는 D-21 문서 갱신 때 함께 고칩니다.
- **D-09:** 운영 안내 문장과 저작권 문장은 **고치지 않습니다**(사용자 결정). 상호는 사업자 정보 줄에서 등록증 표기대로 보여 줍니다. 법적 문서의 `(이하 "회사")` 주체 표기도 바꾸지 않습니다.
- **D-10:** 주소는 **사업자등록증 표기 전체**를 그대로 씁니다. 성공 기준 3을 그대로 지키므로 ROADMAP 문구는 고치지 않습니다.
  - **Reversibility:** one-way — 푸시하는 순간 모든 페이지에 공개되고, 검색 캐시와 웹 아카이브에 남아 되돌릴 수 없습니다.
  - 값 커밋을 푸시하기 전에 로컬 빌드의 푸터 글을 사용자에게 보여 주고 승인을 받습니다. 그 글은 `.planning/`에 남기지 않습니다.
- **D-11:** 푸터는 랜딩을 포함한 모든 페이지가 함께 씁니다. 그래서 랜딩 출력도 바뀌고, 이는 의도한 변경입니다. 페이지 제목(check-site 3번 항목)은 바뀌지 않습니다.

### /support/ 페이지
- **D-12:** 파일은 `support/index.html`이고 `layout: legal`을 씁니다.
  - front matter는 `title: "고객 지원"`, `heading: "러닝펜슬 고객 지원"`, `eyebrow: "SUPPORT"`, `description`(반드시 채움, Phase 2 02-04 결정), `updated`(페이지 커밋 날짜)입니다.
  - `<title>`은 「고객 지원 - 러닝펜슬」이 됩니다.
  - **보충 (2026-11-19, plan-phase):** 지원 페이지는 보류 브랜치에서 먼저 만들고 게이트 때 `main`에 올리므로, `updated`는 **게이트 커밋 날짜**(라이브에 처음 오르는 날)로 씁니다.
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
  - **보충 (2026-11-19, plan-phase에서 사용자 결정):** 질문·답 **한 쌍마다 `<dl>` 하나**를 둡니다. `legal.css`에는 `dd + dt` 간격 규칙이 없어 한 `dl`에 네 쌍을 넣으면 붙어 보이기 때문입니다. 쌍 사이 간격은 기존 `section > * + *` 12px가 줍니다. CSS를 바꾸지 않으므로 법적 3종 출력도 바뀌지 않습니다.
  - **참고 (Phase 6 입력):** 현재 `/data-deletion/`(임시 게시본)은 「설정 → 계정 삭제」라고 적었고, 앱 코드의 실제 경로는 「설정 → 내 계정 → 회원탈퇴」입니다(`05-RESEARCH.md` 앱 코드 확인). FAQ는 앱 코드대로 쓰고, 두 페이지 문구의 차이는 Phase 6 재작성에서 맞춥니다.
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

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### 단계 범위와 요구사항
- `.planning/ROADMAP.md` — Ground Rules, Phase 5 Goal·Success Criteria 1~5·External gates(이메일 게이트, 가비아 DNS 두 번 방문, 사용자 작업·결정)
- `.planning/REQUIREMENTS.md` — BIZ-01~03, SUP-01~04, SITE-03 원문 (SUP-05는 Phase 10)

### 기준 문서 (Phase 1)
- `.planning/baseline/NAMES.md` — 지원 주소 정본, 사업자 값 항목 일곱 개(값은 빈칸, 공개 규칙 D-18), `_data/company.yml` 들어갈 곳
- `.planning/baseline/DECISIONS.md` — U11(사업자 값), U12(메일 결정), N7(앱 안 신고 기능 없음 → 지원 페이지 신고 경로)
- `.planning/baseline/USER-TASKS.md` — 작업 0~5·7(DNS·메일·Search Console), 작업 4 수신 시험 기록 양식, 작업 9 사업자 값 준비, 변경 전후 `dig` 명령, 보존할 기존 레코드
- `.planning/baseline/URLS.md` — `/support/` 행(App Store Connect Support URL, Phase 5)
- `.planning/baseline/DATA-INVENTORY.md` — 위치 수집 시점 표와 「서버 저장은 기록 중 궤적뿐」(FAQ 근거), 「회원탈퇴」 메뉴 이름, 탈퇴 뒤 남는 데이터(FAQ에 쓰지 않는 범위)

### 연구
- `.planning/research/ARCHITECTURE.md` — Pattern 1 사실값 슬롯(render-if-present, `!= blank`), Pattern 2 이메일 게이트(본문 문장 규칙), 3·4단계 빌드 순서
- `.planning/research/FEATURES.md` — SUP-01~04·BIZ-01 근거(App Store Support URL 「actual contact information」, Apple 1.2 UGC, 카카오 비즈니스 정보 심사)

### 코드 규칙
- `.planning/codebase/CONVENTIONS.md` — 「법적 본문 작성 규칙」(D-01~D-12), CSS 클래스·include 규칙, 색 토큰
- `.planning/codebase/ARCHITECTURE.md` — include 네 개와 `legal` 레이아웃 구조, Liquid·raw 규칙
- `CLAUDE.md`, `.claude/CLAUDE.md` — 방침 표, 작업 규칙, 두 사본 동시 수정 규칙과 GSD 블록 재생성 절차

### 이전 단계 결정
- `.planning/phases/03-tailwind-cdn-removal/03-CONTEXT.md` — 본문 요소 모양 D-01~D-12, 푸시·라이브 확인·revert 절차 D-20~D-23
- `.planning/phases/04-landing-content-fix/04-CONTEXT.md` — D-15(헤더 메뉴는 Phase 5에서 지원 링크로 다시 봄), D-23(문서 갱신은 라이브 확인 뒤)

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `_layouts/legal.html`: `eyebrow`, `heading`(없으면 `title`), `updated`·`noindex`(값이 있을 때만)를 front matter로 받습니다. `/support/`는 이 레이아웃을 그대로 씁니다. `description`·`eyebrow`는 render-if-present가 아니라 반드시 채워야 합니다.
- `_includes/css/legal.css`: `.rp-doc dt`(굵은 `ink`), `dd` 들여쓰기 없음, `section > * + *` 12px. FAQ `dl`이 새 CSS 없이 그려집니다.
- `_includes/footer.html`: `.rp-foot-legal` 안에 `<p>` 세 개(운영 안내, 저작권, OSM)가 있습니다. 사업자 행과 이메일 행은 운영 안내 다음에 `<p>`로 더합니다.
- `_includes/header.html`: `include.home`으로 랜딩/법적 링크 형태를 나눕니다. 「고객 지원」은 두 경우 모두 `/support/`입니다.

### Established Patterns
- 공통 블록은 include 한 곳만 고치면 모든 페이지에 반영됩니다. 푸터·헤더를 고치면 랜딩과 법적 3종 출력이 함께 바뀝니다.
- `_data/`처럼 `_`로 시작하는 폴더는 사이트에 출력되지 않아 `_config.yml`의 `exclude`에 적을 필요가 없습니다. 새 마크다운 문서나 루트 파일을 더하면 `exclude`를 확인합니다.
- 푸시 전 점검은 `scripts/check-site.sh`의 여섯 항목이고, `.githooks/pre-push`가 부릅니다. 제목 기대값은 스크립트 맨 위의 `EXPECTED_TITLES`에 있습니다.
- 출력 불변 리팩터 커밋은 기준 커밋과 네 문서의 바이트를 비교해 판정합니다(Phase 2 방식). D-03의 커밋 ①에 그대로 씁니다.

### Integration Points
- `index.html`(랜딩)은 `{% include footer.html %}`와 `{% include header.html home=true %}`를 직접 부르므로, 푸터·헤더 변경이 랜딩에도 들어갑니다.
- 앱 저장소 `~/dv/woody/running_pencil`(기준 `3afb2085`)의 `lib/features/settings/presentation/_widgets/app_info_section.dart`는 `url_launcher`의 `LaunchMode.externalApplication`으로 외부 URL을 엽니다. 앱이 `/support/#contact`·`#report`로 링크할 자리입니다(Deferred, 앱 저장소의 일).

</code_context>

<specifics>
## Specific Ideas

- 사용자가 「신고·문의는 여기서 만든 것을 앱 안에서 웹페이지로 불러 쓸 수 있지 않나?」라고 물었습니다. 답은 다음과 같습니다.
  - 앱 설정에서 `/support/`를 외부 브라우저로 열면 문구를 사이트 한 곳에서 관리할 수 있습니다. WebView 대신 외부 브라우저로 열면 `mailto:` 링크도 그대로 동작합니다.
  - 그래서 사이트는 앱이 구간으로 바로 열 수 있도록 고정 앵커(`#contact`, `#report`, `#faq`)를 둡니다(D-13).
  - 한계도 함께 기록합니다. 정적 사이트라 페이지가 신고를 직접 받지 못하고 결국 지원 이메일로 넘어갑니다. 또 Apple 1.2의 신고 수단을 웹 링크만으로 채운다고 장담할 수 없습니다. 원문은 형태를 정하지 않지만, 포럼 사례에서는 콘텐츠마다 앱 안 신고를 요구했다고 합니다(확인되지 않음).
- 카드 머리 모양 (사용자 선택):
  ```
  SUPPORT                ← eyebrow
  러닝펜슬 고객 지원     ← h1
  최종 업데이트: 2026년 11월 OO일
  ```

</specifics>

<deferred>
## Deferred Ideas

- **앱 설정의 「고객 지원」 행** (앱 저장소): 「앱 정보」 묶음에 `https://runningpencil.com/support/`(필요하면 `#contact`)를 `url_launcher` 외부 브라우저로 여는 행을 더합니다. 사이트의 `/support/`가 게이트 뒤에 라이브가 되므로, 앱 링크도 그 뒤에 켭니다.
- **앱 코스 화면의 「신고」 버튼** (앱 저장소): 코스 ID를 미리 넣은 메일 작성 화면을 엽니다. App Store 1.2의 신고 수단을 더 확실하게 채웁니다. 결정 목록 N7, 앱 P2-09와 이어집니다.
- **영문 `/en/support/`와 영문 사업자 표기**: Phase 9.
- **App Store Connect Support URL 등록**: Phase 10. 게이트 뒤에만 합니다.
- **DKIM과 Apple 릴레이 답장**: 작업 6, Phase 10(SUP-05).

</deferred>

---

*Phase: 05-business-info-support-contact*
*Context gathered: 2026-11-19*
