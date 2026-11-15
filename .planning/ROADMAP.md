# Roadmap: 러닝펜슬 웹사이트

## Overview

이번 마일스톤(1단계: 티저 유지 + 심사 대응)은 빌드 없는 GitHub Pages 정적 사이트를 소셜 로그인 제공자 6곳(카카오·네이버·Google·Apple·Facebook·LINE)과 스토어 2곳(App Store·Google Play)의 심사자가 확인할 수 있는 공식 웹사이트로 정비합니다. 순서는 「기준 → 리팩터(refactor) → 시각 → 내용 → 번역 → 제출」입니다. 먼저 이름 표·URL 대장·데이터 목록·결정 목록으로 기준을 세우고 `CLAUDE.md` 방침을 바꿉니다(Phase 1). 그다음 출력이 바뀌지 않는 Jekyll 공유 셸(shared shell) 전환(Phase 2)과 모양이 바뀌지 않는 정적 CSS 전환(Phase 3)으로 구조를 다집니다. 이어 홈페이지 소개를 앱의 실제 범위로 고치고(Phase 4), 사업자 정보를 표시하고 실제로 받히는 지원 이메일을 열어 이메일 게이트(email gate)를 통과합니다(Phase 5). 그 위에서 한국어 법적 문서를 데이터 목록 기준으로 문서별로 다시 쓰고(Phase 6~8), 국문이 확정된 뒤 영문판을 붙이고(Phase 9), 콘솔별 제출 체크리스트와 전체 URL 점검으로 마칩니다(Phase 10). 사용자·법률 값이 늦게 와도 구조 작업은 먼저 배포할 수 있도록, 값이 필요한 지점을 각 단계의 `External gates`에 적었습니다.

## Ground Rules

모든 단계에 적용합니다.

- `main` 푸시가 곧 배포입니다(CI 없음). 모든 단계는 그대로 라이브에 올라가도 되는 상태로 끝납니다.
- 기존 URL `/privacy-policy/`, `/terms/`, `/data-deletion/`은 경로를 바꾸지 않고 리디렉션(redirect)도 걸지 않습니다. 배포할 때마다 세 URL이 200과 같은 문서 제목을 돌려주는지 확인합니다. 마일스톤 전체 URL 확인은 Phase 10에서 합니다.
- 리팩터·시각 변경·내용 변경을 한 단계나 한 커밋에 섞지 않습니다.
- Phase 2 이후에는 푸시 전에 로컬 Jekyll 3.10.0 빌드가 성공하는지 확인합니다.
- 사용자가 줄 사실값(사업자 정보, 지원 이메일, 보호책임자)은 추측해서 채우지 않습니다. 값이 없으면 render-if-present로 행·문단을 숨깁니다. 빠지면 안 되는 조항이 있는 페이지는 값이 올 때까지 커밋을 보류합니다.
- 「추후 기재」 같은 자리표시 값, JS 언어 자동 리디렉션, `robots.txt` 차단, `.nojekyll`, Jekyll i18n 플러그인은 쓰지 않습니다.
- 방침이나 구조를 바꾸는 단계는 그 단계 안에서 `CLAUDE.md`도 함께 고칩니다.

## Phases

**Phase Numbering:**
- Integer phases (1, 2, 3): Planned milestone work
- Decimal phases (2.1, 2.2): Urgent insertions (marked with INSERTED)

Decimal phases appear between their surrounding integers in numeric order.

- [ ] **Phase 1: 기준표와 방침 정비 (Ground Truth & Policy Reset)** - 이름 표·URL 대장·데이터 목록·결정 목록을 만들고 `CLAUDE.md` 방침을 바꾼다
- [ ] **Phase 2: Jekyll 공유 셸 도입 (Shared Shell Refactor)** - 공통 블록을 한 곳으로 모으되 사이트 출력은 그대로 둔다
- [ ] **Phase 3: 법적 페이지 정적 스타일 전환 (Tailwind CDN Removal)** - Tailwind Play CDN을 정적 CSS로 바꾸되 모양은 그대로 둔다
- [ ] **Phase 4: 홈페이지 서비스 소개 정정 (Landing Content Fix)** - 앱에 없는 기능 설명을 빼고 실제 앱 화면을 보여 준다
- [ ] **Phase 5: 사업자 정보와 지원 연락 경로 (Business Info & Support Contact)** - 푸터 사업자 정보, `/support/`, 실제로 받히는 지원 이메일(이메일 게이트)
- [ ] **Phase 6: 데이터 삭제 안내 재작성 (Data Deletion Rewrite)** - 앱 없이 웹에서 삭제를 요청하는 경로와 삭제·보존 데이터 안내
- [ ] **Phase 7: 개인정보처리방침 재작성 (Privacy Policy Rewrite)** - 데이터 목록 기준의 처리방침(위탁·국외 이전·보호책임자·제공자별 수신 항목)
- [ ] **Phase 8: 이용약관과 위치기반서비스 이용약관 (Terms & Location Terms)** - 약관 재작성, 위치약관 신설, 법적 페이지 정식 게시
- [ ] **Phase 9: 영문판 (English Versions)** - `/en/` 홈페이지와 영문 법적 문서·지원 페이지, 언어 전환
- [ ] **Phase 10: 제출 준비와 최종 점검 (Submission Readiness)** - 콘솔별 제출 체크리스트와 전체 URL 점검

## Phase Details

### Phase 1: 기준표와 방침 정비 (Ground Truth & Policy Reset)
**Goal**: 운영자와 이후 모든 단계가 같은 기준(이름 표·URL 대장·데이터 목록·결정 목록)을 쓰고, `CLAUDE.md`가 이번 마일스톤의 방침을 설명해 다음 작업 세션이 결정을 되돌리지 않는다
**Depends on**: Nothing (first phase)
**Requirements**: BASE-01, BASE-02, BASE-03, BASE-04, BASE-05
**Success Criteria** (what must be TRUE):
  1. 운영자는 이름 표 하나에서 한글·영문 서비스명(러닝펜슬 / RunningPencil), 사업자등록증 그대로의 상호, 영문 법인명을 확인한다. 사용자가 아직 주지 않은 값은 빈칸이고, 추측해서 채운 값은 없다
  2. 운영자는 URL 대장 하나에서 사이트의 모든 공개 URL(홈, 기존 3개, `/support/`, 위치약관, `/en/` 5개)을 `https://runningpencil.com/…/` 형식(apex·https·끝 슬래시)으로 보고, URL마다 등록할 콘솔 필드를 확인한다
  3. 운영자는 데이터 목록에서 개인정보 항목마다 출처·목적·저장 위치(리전)·수탁자·국외 이전·보유 기간·삭제 방식을 앱 저장소의 파일 근거와 함께 확인하고, 확인하지 못한 칸은 「미확인」으로 표시돼 있다
  4. 운영자는 결정 목록(U2·U3·U5~U9·U11~U13)과 사용자가 할 외부 작업 목록(가비아 DNS 레코드 표, 메일 수신 시험 절차, 사업자 값, 앱 화면 캡처)을 받아, 항목마다 어느 단계를 막는지 안다
  5. `CLAUDE.md`가 지원 이메일 공개, 사업자 정보 표시, 영문명 RunningPencil, 한국어+영어, Jekyll 빌드 전환, 포인트·굿즈·코스북 제거를 현재 방침으로 설명하고, 「연락처 미표시」「RunningPencil 쓰지 않음」「ko 전용」 같은 옛 규칙 문장이 남아 있지 않다
**Plans**: 1/8 plans executed

Plans:
**Wave 1**
- [x] 01-01-PLAN.md — 이름 표와 URL 대장, 영문 서비스명 방침 한 줄을 CLAUDE.md까지 통과 (tracer)

**Wave 2** *(blocked on Wave 1 completion)*
- [ ] 01-02-PLAN.md — 사용자 작업 절차서 (가비아 DNS·Workspace·수신 시험, 작업 0~12)
- [ ] 01-03-PLAN.md — 데이터 목록 1부 (머리, 계정·프로필, 제공자별 수신 항목, 위치·기록·코스·뱃지, 외부 요청)
- [ ] 01-04-PLAN.md — 결정 목록 (열린 결정 11개, 결정된 메일 서비스, 조사에서 새로 나온 항목 N1~N7)
- [ ] 01-06-PLAN.md — CLAUDE.md 방침 표 일곱 행과 작업 규칙, 옛 규칙 문장 0줄

**Wave 3** *(blocked on Wave 2 completion)*
- [ ] 01-05-PLAN.md — 데이터 목록 2부 (SDK·서버 보조, 탈퇴 처리, 리전·보존 기간, 확인할 것)
- [ ] 01-07-PLAN.md — 계획 문서 정합 (ROADMAP·STATE·PROJECT에 메일 결정·DNS 두 번 방문·위치약관 경로 반영, 연구 문서 메모)

**Wave 4** *(blocked on Wave 3 completion)*
- [ ] 01-08-PLAN.md — dev 프로젝트 읽기 전용 CLI 조회 (사용자 재로그인 뒤, 건너뛸 수 있음)

**UI hint**: no
**External gates**: 없음. Claude만으로 끝낼 수 있습니다. 앱 저장소(`~/dv/woody/running_pencil`)는 읽기만 합니다.
**Research flag**: 예. 데이터 목록을 만들려면 Firebase Functions·Firestore·Storage의 리전, OSRM VM 리전, Analytics·Crashlytics 보존 기간, Facebook SDK 자동 이벤트 전송, 비공개 코스의 탈퇴 처리, Email/Password 가입 경로(U5의 근거)를 확인해야 합니다.
**Notes**: 산출물은 `.planning/` 아래 기준 문서와 `CLAUDE.md`뿐입니다. 둘 다 배포 제외 대상이라 라이브 사이트는 바뀌지 않습니다. 가비아 DNS 레코드 표를 이 단계에서 넘기므로, 사용자는 이 단계가 끝나면 Phase 5의 DNS·메일 작업을 Phase 2~4와 병행해 시작할 수 있습니다.

### Phase 2: Jekyll 공유 셸 도입 (Shared Shell Refactor)
**Goal**: 운영자가 head 링크·「공통」 CSS·헤더·푸터를 한 곳에서 고치면 모든 페이지에 반영되고, 이 전환으로 방문자가 보는 사이트 출력은 바뀌지 않는다
**Depends on**: Phase 1
**Requirements**: SHELL-01, SHELL-02, SHELL-03
**Success Criteria** (what must be TRUE):
  1. 로컬 Jekyll 3.10.0 빌드가 성공하고, `_site/`의 네 문서(`/`, `/privacy-policy/`, `/terms/`, `/data-deletion/`)를 전환 전 HTML과 공백 정규화 diff로 비교하면 차이가 0이다
  2. 공통 블록(head 링크, 「공통」 CSS, 헤더, 푸터)이 `_includes`/`_layouts`에 한 벌만 있고, 그중 하나를 시험 삼아 바꾸면 네 문서의 빌드 결과가 모두 바뀐다
  3. 운영자는 `CLAUDE.md`에 적힌 명령(Jekyll 3.10.0을 고정한 Gemfile)으로 실제 배포와 같은 빌드의 로컬 미리보기를 띄우고, 푸시 전에 빌드 성공을 확인한다. `python3 -m http.server` 안내는 남아 있지 않다
  4. 라이브에서 `/CLAUDE.md`, `/README.md`, `/Gemfile`, `/Gemfile.lock`, `vendor/`·`.planning/`·`prepare/` 아래 파일이 404이고, 기존 네 URL은 200과 전환 전과 같은 `<title>`을 돌려준다
**Plans**: TBD
**UI hint**: no
**External gates**: 없음.
**Research flag**: 아니요. STACK 연구에서 Jekyll 3.10.0 빌드·서빙, `exclude` 덮어쓰기, 빈 front matter의 바이트 동일 출력을 로컬 실험으로 확인했습니다.
**Notes**: 법적 문서 3종과 랜딩은 별도 커밋으로 전환합니다. Tailwind `<script>`와 설정은 legal 레이아웃의 `<head>` 한 곳으로 옮기기만 하고, 제거는 Phase 3에서 합니다. `_config.yml`에 `url: "https://runningpencil.com"`을 두고 `exclude`를 보강합니다(사용자 지정 `exclude`는 기본 목록을 덮어씀). 레이아웃 이름 `default`·`page`·`home`, 전역 `permalink`, `.nojekyll`은 쓰지 않습니다. 앞으로 인라인 JS에 `{{`·`{%`가 들어가면 `{% raw %}`로 감쌉니다.

### Phase 3: 법적 페이지 정적 스타일 전환 (Tailwind CDN Removal)
**Goal**: 방문자가 외부 스크립트(Tailwind Play CDN) 없이 정적 CSS만으로 법적 문서 3종을 전환 전과 같은 모양으로 보고, 이후 단계는 클래스 없는 본문 마크업에 텍스트만 쓰면 된다
**Depends on**: Phase 2
**Requirements**: SHELL-04
**Success Criteria** (what must be TRUE):
  1. 세 법적 문서의 HTML 소스와 브라우저 네트워크 요청 어디에도 `cdn.tailwindcss.com`이 없다
  2. 375·768·1280px에서 전환 전·후 캡처를 비교하면 줄 간격·테두리·여백·글자색·카드 모양이 같다
  3. 세 문서 본문에서 뽑은 텍스트가 전환 전과 같다(문장 변경 0)
  4. 클래스 없는 시험용 표·목록·주석을 본문에 넣어 보면 별도 클래스 없이 카드 디자인에 맞게 보인다(이후 처리 위탁 표·FAQ·영문판이 같은 규칙을 씀)
**Plans**: TBD
**UI hint**: no
**External gates**: 없음.
**Research flag**: 아니요. 쓰고 있는 유틸리티 클래스 목록(약 45개)과 Tailwind 3.4.17 Preflight 원문을 확인했고, 변환은 기계적입니다.
**Notes**: 요구사항이 하나뿐이지만 Phase 2에 합치지 않습니다. Phase 2는 출력이 같아야 하는 리팩터이고 이 단계는 모양이 같아야 하는 시각 변경이라, 섞으면 회귀가 생겼을 때 원인을 좁힐 수 없기 때문입니다. Preflight 중 필요한 규칙(border 3값, `text-sm` line-height 등)을 법적 문서 범위로 옮기고, 토큰(`ink`·`accent`·`muted`·`muted-2`·`line`)은 CSS 변수로 한 번만 정의합니다.

### Phase 4: 홈페이지 서비스 소개 정정 (Landing Content Fix)
**Goal**: 심사자가 홈페이지만 보고 출시 시점 앱이 실제로 하는 일을 정확히 알 수 있다. 앱에 없는 기능 설명이 사라지고, 실제 앱 화면과 「출시 예정」 표시가 보인다
**Depends on**: Phase 2 (Phase 3과는 독립)
**Requirements**: SITE-01, SITE-06
**Success Criteria** (what must be TRUE):
  1. 홈페이지 본문, `<meta name="description">`, OG 제목·설명 어디에도 「포인트」「굿즈」「코스북」이 없다(빌드 결과 검색 0건)
  2. 홈페이지에 실제 앱 화면 스크린샷과 「출시 예정」 표시가 함께 보이고(375·1280px), 스크린샷에는 출시 범위 밖 기능이 나오지 않는다
  3. 기존 동작(스크롤에 고정되는 세 가지 이유, 7초 달려 보기, 움직임 줄이기 대응)이 그대로 동작하고 브라우저 콘솔 오류가 없다
**Plans**: TBD
**UI hint**: yes
**External gates**: 사용자가 실제 앱 화면 캡처를 줍니다. 출시 범위의 기능만 보이는 화면이어야 합니다. 문구 정정(SITE-01)은 캡처와 상관없이 별도 커밋으로 먼저 배포할 수 있습니다. U10(포인트·굿즈·코스북 제거)은 이미 결정됐습니다.
**Research flag**: 아니요.

### Phase 5: 사업자 정보와 지원 연락 경로 (Business Info & Support Contact)
**Goal**: 심사자와 사용자가 모든 페이지에서 누가 러닝펜슬을 운영하는지 확인하고, `/support/`에서 실제로 받히는 지원 이메일로 연락할 수 있다. 이 단계가 끝나면 이메일 게이트가 열린다
**Depends on**: Phase 3 (지원 페이지가 정적 CSS 법적 레이아웃을 씀), Phase 1 (DNS 레코드 표·결정 목록)
**Requirements**: BIZ-01, BIZ-02, BIZ-03, SUP-01, SUP-02, SUP-03, SUP-04, SITE-03
**Success Criteria** (what must be TRUE):
  1. Gmail·네이버·iCloud·Outlook에서 지원 이메일로 보낸 시험 메일이 슬림펌킨 업무 메일에 도착했다는 시험 기록이 있고, 이 기록보다 앞선 어떤 배포에도 지원 이메일 주소가 나오지 않는다
  2. `dig` 결과에 지원 메일의 MX와 SPF(한 개), Search Console TXT가 보이고, Search Console이 `runningpencil.com` 도메인 속성을 확인됨으로 표시하며, DNS 변경 뒤에도 사이트가 HTTPS로 열린다
  3. 모든 페이지 푸터에 사업자등록증과 같은 표기의 상호·대표자·사업자등록번호·주소와 지원 이메일이 보이고, 값이 없는 항목은 자리표시 없이 행 자체가 없다
  4. 운영자가 `_data` 파일 하나만 고치면(전화번호를 넣는 경우 포함) 푸터와 지원 페이지에 바로 반영되고, 전화번호는 지금 값이 없어 어디에도 보이지 않는다
  5. `/support/` 맨 위에 「러닝펜슬」이 있고, 그 아래에서 지원 이메일과 응답 안내, 공개 코스 신고 방법, FAQ(운영 주체, 위치를 수집하는 시점, 계정 삭제 방법, 공개 코스 신고)를 찾을 수 있으며, 헤더·푸터에서 지원 페이지로 갈 수 있다
**Plans**: TBD
**UI hint**: yes
**External gates**:
- 이메일 게이트: 외부 주소 4곳(Gmail·네이버·iCloud·Outlook)의 수신 시험이 통과하기 전에는 지원 이메일을 `_data`에 넣지 않습니다. 그 전에 배포하는 `/support/`는 연락처 구간 전체를 조건부로 감쌉니다(빈 「문의:」 문장 금지). App Store Support URL 같은 콘솔 등록도 게이트가 열린 뒤에 합니다.
- 사용자 DNS 작업(가비아): Search Console TXT와 ImprovMX MX 2개 + SPF 1개를 한 번에 추가합니다. 같은 작업에서 `_github-pages-challenge-SlimPumpkin` TXT(도메인 탈취 방지, 요구사항 밖 권장 항목)도 넣고, U12 결과 `support@` 주소로 답장을 보내기로 하면 그 발신 서비스의 DKIM 레코드도 함께 넣습니다. 기존 A 레코드와 `www` CNAME은 그대로 두고, SPF는 하나로 합칩니다. 변경 전후 `dig` 결과를 기록합니다. Phase 1이 끝나면 바로 시작할 수 있습니다.
- 사용자 작업: ImprovMX 설정, Search Console 소유권 확인.
- 사용자 결정: U11(사업자등록증 그대로의 사업자 값, 자택 주소 공개 부담), U12(지원 주소와 업무 메일 서비스 종류, `support@`로 답장할지).
- 슬롯·푸터 행·지원 페이지 골격 같은 구조는 값 없이도 먼저 배포할 수 있습니다. 단계 완료는 게이트가 열리고 값이 들어간 뒤입니다.
**Research flag**: 아니요. 사실값 슬롯과 이메일 게이트 패턴은 ARCHITECTURE 연구에 구체적으로 나와 있습니다. 다만 U12 결과 업무 메일이 Google Workspace이면 보조 도메인 방식을 확인합니다.

### Phase 6: 데이터 삭제 안내 재작성 (Data Deletion Rewrite)
**Goal**: 앱이 없는 사용자도 `/data-deletion/`에서 계정·데이터 삭제를 요청하는 방법과 무엇이 지워지고 무엇이 남는지 알 수 있고, Google Play 계정 삭제와 Facebook 데이터 삭제 안내 요건을 이 문서 하나로 충족한다
**Depends on**: Phase 5 (이메일 게이트·사실값 슬롯)
**Requirements**: DEL-01, DEL-02, DEL-03, DEL-04, DEL-05, DEL-06, DEL-07
**Success Criteria** (what must be TRUE):
  1. 앱을 설치하지 않은 사용자가 문서 첫 화면에서 지원 이메일로 계정·데이터 삭제를 요청하는 방법(메일에 적을 내용 포함)을 찾고, 문서에 스토어에 표시되는 앱 이름과 개발자 이름이 있다
  2. 사용자는 삭제되는 데이터와 남는 데이터(공개 코스 등), 남는 이유와 기간, 삭제에 걸리는 시간의 상한과 완료를 알려 주는 방법을 읽는다. 각 항목은 Phase 1 데이터 목록과 일치하고, 포인트·굿즈·배송지·전자상거래 기록은 없다
  3. 앱 안 삭제 경로가 실제 메뉴 이름 「회원탈퇴」로 안내되고, 위치정보 동의를 철회하면 개인위치정보와 확인자료가 파기된다는 안내가 있다
  4. `/data-deletion/#facebook`, `#google`, `#apple`, `#kakao`, `#naver`, `#line`이 각각 해당 제공자 섹션으로 바로 이동한다
**Plans**: TBD
**UI hint**: no
**External gates**: 이메일 게이트(Phase 5)가 열린 뒤에 커밋합니다. 웹 삭제 요청 경로가 이메일에 달려 있어, 경로가 빠진 삭제 안내를 라이브에 올리지 않기 위해서입니다. U6(탈퇴 후 공개 코스 유지, 비공개 코스 처리)이 결정돼야 합니다.
**Research flag**: 부분. Meta Data Deletion Instructions의 내용 기준을 확인합니다. 나머지 사실은 Phase 1 데이터 목록을 씁니다.
**Notes**: 이 문서의 「임시 게시본」 표시와 `noindex`는 재작성 커밋에서 함께 지웁니다(세 문서 전체 확인은 Phase 8). 「30일 이내」 같은 상한 표현은 쓸 수 있습니다. 「모든 개인정보」 같은 절대 표현은 Analytics·Crashlytics 보존 기간을 확인한 뒤에만 씁니다.

### Phase 7: 개인정보처리방침 재작성 (Privacy Policy Rewrite)
**Goal**: 사용자와 심사자가 처리방침 하나로 러닝펜슬이 어떤 개인정보를 어디서 받아 무엇에 쓰고, 누구에게 맡기고, 언제 지우는지, 그리고 권리를 어떻게 행사하는지 확인할 수 있으며, 그 내용이 앱의 실제 동작(데이터 목록)과 일치한다
**Depends on**: Phase 6 (삭제 방법 문장 일치), Phase 5 (이메일 게이트·보호책임자 값)
**Requirements**: PRIV-01, PRIV-02, PRIV-03, PRIV-04, PRIV-05, PRIV-06, PRIV-07, PRIV-08, PRIV-09, PRIV-10, PRIV-11
**Success Criteria** (what must be TRUE):
  1. 처리 항목(로그인 제공자별 수신 항목, 기록 중 GPS 궤적, 코스·기록·뱃지, 프로필 사진, 푸시 토큰, 분석·크래시 정보)과 목적·보유 기간·파기 절차가 데이터 목록과 항목 단위로 일치하고, 굿즈·배송지·포인트는 없다
  2. 처리 위탁 표에 수탁자와 업무(Google Firebase·GCP, 네이버클라우드 등)가 있고 로그인 제공자는 수탁자로 적혀 있지 않으며, 국외 이전 항목은 근거와 다섯 가지 사항(항목, 국가·시기·방법, 이전받는 자와 연락처, 목적·보유 기간, 거부 방법·효과)을 모두 채운다
  3. 로그인 제공자별 수신 항목 표(제공자, 받는 항목, 필수/선택, 용도)가 있어 카카오 동의항목·네이버 활용처·Google user data 사용 공개를 한 곳에서 대조할 수 있다
  4. 사용자는 처리방침에서 열람·정정·삭제·처리정지 요구와 동의 철회·삭제 요청 방법(앱 안 「회원탈퇴」, 지원 이메일), 개인정보 보호책임자와 연락처, 자동 수집 장치(Firebase Analytics·Crashlytics 등)와 거부 방법, 만 14세 미만 정책, 안전성 확보 조치를 찾는다
  5. 처리방침에 시행일과 변경 이력이 있고, 개정할 때 이전 버전을 고정 URL에 남기는 방식이 정해져 `CLAUDE.md`에 적혀 있다
**Plans**: TBD
**UI hint**: no
**External gates**: 이메일 게이트와 보호책임자 값이 들어온 뒤에 커밋합니다(조항이 통째로 빠진 처리방침을 라이브에 올리지 않음). U3(소상공인 해당 여부, 해당하면 대표자가 보호책임자), U5(Email/Password 가입 노출 여부), U7(14세 미만 정책) 결정이 필요합니다.
**Research flag**: 예. 개인정보위 「처리방침 작성지침」 2026.4 개정 원문 대조, 국외 이전 기재 형식, 열람 처리 기한(시행령 제41조)을 확인합니다.
**Notes**: URL `/privacy-policy/`는 그대로 둡니다. 「임시 게시본」 표시와 `noindex`는 이 커밋에서 지웁니다. 위치기반서비스 이용약관으로 가는 링크는 그 페이지가 생기는 Phase 8에서 넣습니다.

### Phase 8: 이용약관과 위치기반서비스 이용약관 (Terms & Location Terms)
**Goal**: 이용약관이 출시 시점 앱의 실제 범위를 다루고 위치기반서비스 이용약관이 홈페이지에 공개되어, 심사자가 홈페이지 푸터에서 미완성 표시 없는 법적 문서 다섯 곳으로 모두 이동할 수 있다
**Depends on**: Phase 7 (처리방침과 상호 참조), Phase 5 (사업자 값)
**Requirements**: TERM-01, TERM-02, TERM-03, LOC-01, LOC-02, LOC-03, LOC-04, SITE-02, SITE-05
**Success Criteria** (what must be TRUE):
  1. 이용약관에 포인트·굿즈 조항이 없고, 코스 공개와 공개 후 수정 불가, 탈퇴 후 공개 코스 유지, 사용자 콘텐츠 신고, 지도·경로 데이터 출처(OpenStreetMap)와 네이버 지도 SDK 이용 고지 조항이 있다
  2. 위치약관이 위치정보법 제19조①의 필수 사항(사업자 상호·주소·연락처, 권리와 행사 방법, 서비스 내용, 확인자료 보유 근거·기간, 개인위치정보 보유 목적·기간)을 담고, 사용자는 여기서 동의 철회, 수집·이용 일시 중지 요구, 확인자료 열람·고지·정정 요구 방법을 찾는다
  3. 이용약관과 위치약관에 각각 시행일과 변경 이력이 있고, 이용약관과 처리방침에서 위치약관으로 링크된다
  4. 홈페이지 푸터에서 처리방침(URL 대장에 적힌 Google 동의 화면 등록 URL과 같은 주소), 이용약관, 데이터 삭제 안내, 지원, 위치기반서비스 이용약관(눈에 띄는 링크)으로 이동할 수 있고, 다섯 곳 모두 `runningpencil.com` 안에 있다
  5. 처리방침·이용약관·데이터 삭제 안내 어디에도 「임시 게시본」 같은 미완성 표시와 `noindex`가 없고, `robots.txt`가 이 경로들을 막지 않는다
**Plans**: TBD
**UI hint**: no
**External gates**: 사업자 값(U11)이 들어와야 합니다. U2(위치정보법 분류)는 위치약관의 범위만 정합니다. 위치기반서비스사업 신고 기준으로 쓰고, 위치정보사업 등록 대상으로 나오면 v2의 LOC-05로 보강합니다. 그 밖에 U6(탈퇴 후 코스), U7(14세 미만), U8(네이버 지도 고지 의무) 결정이 필요합니다. 신고·등록을 실제로 할지는 사이트가 정하지 않고 마일스톤 인수 항목 ACPT-02로 둡니다.
**Research flag**: 예. 위치약관은 위치정보사업(등록)과 위치기반서비스사업(신고)의 분류, 확인자료 보존 기간, 국내 러닝 앱 위치약관 목차를 비교해야 하고 법률 확인이 필수입니다. 이용약관은 네이버 지도 이용약관 §7⑤ 원문을 확인합니다.
**Notes**: 위치약관 경로는 Phase 1 URL 대장을 따릅니다(후보 `/location-terms/`). 이용약관 재작성과 위치약관 신설은 문서별로 따로 커밋합니다. 이 단계에서 이용약관의 「임시 게시본」·`noindex`를 지우면 기존 법적 문서 3종이 모두 정식 게시본이 됩니다.

### Phase 9: 영문판 (English Versions)
**Goal**: 영어 사용자와 해외 제공자 심사자가 `/en/` 아래에서 RunningPencil이 무엇인지와 처리방침·약관·삭제 안내·지원 내용을 국문과 같은 내용으로 읽고, 언어판 사이를 링크로 오간다
**Depends on**: Phase 8 (국문 법적 문서 확정, 두 번 번역하지 않음), Phase 4 (국문 홈페이지 확정)
**Requirements**: I18N-01, I18N-02, I18N-03, I18N-04
**Success Criteria** (what must be TRUE):
  1. `/en/privacy-policy/`, `/en/terms/`, `/en/data-deletion/`, `/en/support/`가 국문판과 같은 조항·표·제공자 앵커를 영어로 보여 주고, 서비스명은 RunningPencil, `<html lang="en">`이다
  2. `/en/`에서 영어 사용자가 RunningPencil이 무엇을 하는 앱인지(지도 위 GPS 아트 코스를 걷거나 달려 완주하면 코스 모양 뱃지를 모음) 확인하고, 출시 예정 표시와 영문 법적 문서 링크를 본다
  3. 짝이 있는 문서마다 보이는 언어 전환 링크가 있고, 각 문서의 `<head>`에 자기 참조를 포함한 전체 URL `hreflang`이 있으며, 어떤 페이지도 브라우저 언어에 따라 자동으로 이동시키지 않는다
  4. 영문 문서마다 「한국어판이 우선한다」는 문구와 국문판 시행일이 보이고, 국문판이 영문판의 `source_updated`보다 나중에 바뀌면 로컬 검사가 이를 알린다
**Plans**: TBD
**UI hint**: yes
**External gates**: 영문 법인명(이름 표, U11)이 있어야 영문 푸터와 영문 문서의 주체 표기를 채울 수 있습니다. 영문 서비스명은 RunningPencil로 결정됐습니다.
**Research flag**: 아니요. 구조(`doc_key` 짝짓기, `lang-switch` include)는 확정됐고, 남은 것은 번역 품질입니다.
**Notes**: 언어 전환 include(짝이 없으면 아무것도 그리지 않음)를 먼저 배포한 뒤 삭제 안내 → 처리방침 → 약관 → 지원 → 홈 순서로 한 장씩 올립니다. 위치약관 영문판은 v2(LOC-06)입니다.

### Phase 10: 제출 준비와 최종 점검 (Submission Readiness)
**Goal**: 운영자가 체크리스트만 따라 제공자 6곳과 스토어 2곳 콘솔에 같은 이름·URL·문구를 한 번에 제출할 수 있고, 제출하는 시점에 URL 대장의 모든 주소가 라이브에서 열린다
**Depends on**: Phase 9, Phase 5 (지원 메일)
**Requirements**: SUBMIT-01, SUBMIT-02, SUBMIT-03, SITE-04, SUP-05
**Success Criteria** (what must be TRUE):
  1. 운영자는 카카오·네이버·Google·Apple·Facebook·LINE·App Store·Google Play 콘솔별 체크리스트에서 필드마다 넣을 URL(언어판 포함)·이름·로고·설명 문구·담당 이메일·도메인 인증 절차를 보고, 필수 사실값과 이메일 게이트가 충족됐는지 항목별로 확인한다
  2. 운영자는 카카오·네이버가 출시 전 서비스에 요청하는 서비스 소개 자료의 목록(화면 캡처 등)을 받는다
  3. URL 대장의 모든 URL(홈, 기존 3개, `/support/`, 위치약관, `/en/` 5개)이 라이브에서 200으로 열리고, 기존 3개 경로가 마일스톤 시작 때와 같다는 확인 기록이 있다
  4. 운영자는 배포 후 URL 전체를 확인하는 절차와 「심사 중 푸시 자제」 같은 운영 규칙을 `CLAUDE.md`에서 찾아 따를 수 있다
  5. Apple로 로그인한 사용자의 릴레이(Private Email Relay) 주소로 보낸 지원 답장이 반송되지 않았다는 시험 기록이 있다. 답장을 보내는 도메인의 SPF·DKIM이 `dig`로 확인되고, 그 도메인과 주소가 Apple Developer에 발신처로 등록돼 있다
**Plans**: TBD
**UI hint**: no
**External gates**: U9(Meta Advanced Access에 비즈니스 인증이 필요한지)와 U13(Google 브랜드 검증 신청 여부) 결정이 체크리스트 내용을 정합니다. 릴레이 답장 시험에는 사용자 작업이 필요합니다. Apple Developer에 발신 도메인·주소를 등록하고, 필요하면 답장 발신 도메인의 DKIM을 추가하고(U12), Apple 계정으로 「이메일 가리기」 로그인을 해서 릴레이 주소를 만듭니다. 실제 제출과 심사 통과는 이 단계의 성공 기준이 아닙니다(아래 Milestone Acceptance).
**Research flag**: 예. 콘솔별 실제 필드명과 언어 요건(카카오·네이버·LINE·Meta·App Store), Meta Data Deletion Instructions 기준, Meta Advanced Access와 비즈니스 인증의 관계, Google 브랜드 검증을 생략할 때 동의 화면이 어떻게 보이는지 확인합니다.
**Notes**: `CLAUDE.md` 최종 갱신(공통 블록 방식, `{% raw %}` 규칙, 언어판 규칙, 로컬 미리보기, 운영 규칙)을 이 단계에서 마무리합니다. SUP-05(Apple 릴레이 답장)는 Apple 콘솔 설정과 함께 확인하는 항목이라 Phase 5가 아니라 이 단계에 둡니다. 연구 SUMMARY도 이 확인을 마지막 단계에 두었습니다.

## External Gates

Claude가 하지 않고 사용자나 법률 확인이 주는 값·작업입니다. 해당 단계는 구조를 먼저 배포할 수 있지만, 아래 값이 들어오기 전에는 완료할 수 없습니다.

| 게이트 | 누가 | 막는 단계 |
|--------|------|-----------|
| 가비아 DNS 레코드(Search Console TXT, ImprovMX MX·SPF. 권장: GitHub Pages 인증 TXT, 필요하면 DKIM) | 사용자 | Phase 5 |
| 이메일 게이트(외부 주소 4곳 수신 시험 통과) | 사용자 시험 → Claude가 기록 확인 후 `_data`에 기입 | Phase 5 완료, Phase 6·7 커밋, 콘솔 등록 |
| Apple 발신 도메인·주소 등록, 릴레이 답장 시험 | 사용자 | Phase 10 |
| 앱 화면 캡처(출시 범위 기능만) | 사용자 | Phase 4 |
| U11 사업자 값(상호·대표자·사업자등록번호·주소, 영문 법인명) | 사용자 | Phase 5, 8, 9 |
| U12 지원 주소와 업무 메일 서비스 | 사용자 | Phase 5 |
| U2 위치정보법 분류(신고 vs 등록) | 법률 확인 | Phase 8 위치약관 범위, ACPT-02 |
| U3 소상공인·1인 창조기업 해당 여부 | 법률 확인 | Phase 7 보호책임자 |
| U5 Email/Password 가입 노출 여부 | 사용자(앱) | Phase 7 |
| U6 탈퇴 후 공개 코스 유지, 비공개 코스 처리 | 사용자(앱) | Phase 6, 8 |
| U7 만 14세 미만 가입 정책 | 사용자·법률 확인 | Phase 7, 8 |
| U8 네이버 지도 이용약관 고지 의무 | 사용자·약관 확인 | Phase 8 |
| U9 Meta 비즈니스 인증 필요 여부 | 사용자(콘솔 확인) | Phase 10 |
| U13 Google 브랜드 검증 신청 여부 | 사용자 | Phase 10 |

이미 결정된 항목: U1(전화번호는 이번에 공개하지 않고 칸만 마련), U4(영문 서비스명 RunningPencil), U10(포인트·굿즈·코스북 제거), U14(법적 문서 `noindex` 해제, `/en/` 홈페이지 포함).

## Milestone Acceptance

외부 결과라 사이트만으로 검증할 수 없습니다. 어느 단계에도 배정하지 않고, 단계의 성공 기준으로도 쓰지 않습니다. 마일스톤을 마칠 때 사용자가 확인합니다.

- ACPT-01: 제공자 6곳의 통과를 사용자가 확인합니다. 카카오는 비즈앱 전환과 동의항목 심사, 네이버는 로그인 검수, Google은 OAuth 동의 화면 게시(브랜드 검증은 U13에 따름), Apple은 Sign in with Apple 프로덕션 구성, Facebook은 Live 전환(필요하면 비즈니스 인증, U9), LINE은 채널 공개(Published)입니다.
- ACPT-02: 위치정보법상 신고 또는 등록이 필요한지(U2)와 그 처리 여부를 사용자가 확인합니다.

## Progress

**Execution Order:**
Phases execute in numeric order: 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9 → 10

- Phase 3과 Phase 4는 둘 다 Phase 2에만 기대므로 순서를 바꿔도 됩니다.
- Phase 5는 Phase 4에 기대지 않습니다. Phase 4가 앱 화면 캡처를 기다리는 동안 Phase 5를 먼저 진행해도 됩니다.
- Phase 5의 사용자 DNS·메일 작업은 Phase 1이 끝나면 바로 시작해 Phase 2~4와 병행하는 것이 좋습니다. 이메일 게이트가 Phase 6·7의 임계 경로(critical path)입니다.

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. 기준표와 방침 정비 (Ground Truth & Policy Reset) | 1/8 | In Progress | - |
| 2. Jekyll 공유 셸 도입 (Shared Shell Refactor) | 0/TBD | Not started | - |
| 3. 법적 페이지 정적 스타일 전환 (Tailwind CDN Removal) | 0/TBD | Not started | - |
| 4. 홈페이지 서비스 소개 정정 (Landing Content Fix) | 0/TBD | Not started | - |
| 5. 사업자 정보와 지원 연락 경로 (Business Info & Support Contact) | 0/TBD | Not started | - |
| 6. 데이터 삭제 안내 재작성 (Data Deletion Rewrite) | 0/TBD | Not started | - |
| 7. 개인정보처리방침 재작성 (Privacy Policy Rewrite) | 0/TBD | Not started | - |
| 8. 이용약관과 위치기반서비스 이용약관 (Terms & Location Terms) | 0/TBD | Not started | - |
| 9. 영문판 (English Versions) | 0/TBD | Not started | - |
| 10. 제출 준비와 최종 점검 (Submission Readiness) | 0/TBD | Not started | - |
