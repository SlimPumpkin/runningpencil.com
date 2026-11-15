# Requirements: 러닝펜슬 웹사이트 (runningpencil.com)

**Defined:** 2026-11-14
**Core Value:** 소셜 로그인 제공자와 스토어 심사자가 이 사이트만 보고 러닝펜슬이 어떤 서비스인지, 누가 운영하는지, 어떤 개인정보를 어떻게 처리하는지, 어떻게 연락하고 데이터를 지울 수 있는지 확인할 수 있어야 하고, 그래서 심사가 웹사이트 때문에 반려되지 않아야 합니다.

> 근거와 출처: `.planning/research/` (SUMMARY·FEATURES·STACK·ARCHITECTURE·PITFALLS). 사용자·법률 결정 번호(U1~U14)는 SUMMARY.md의 「Consolidated Open Decisions」를 따릅니다.

## v1 Requirements

이번 마일스톤(1단계: 티저 유지 + 심사 대응)의 범위입니다. 각 항목은 로드맵의 한 단계에 대응합니다.

### 기준 문서와 방침 (BASE)

- [x] **BASE-01**: 운영자는 이름 표 하나로 한글·영문 서비스명(러닝펜슬 / RunningPencil), 사업자등록증 그대로의 상호와 영문 법인명을 확인하고, 사이트·콘솔에서 같은 값을 쓸 수 있다
- [x] **BASE-02**: 운영자는 URL 등록 대장 하나로 사이트의 모든 공개 URL(apex·https·끝 슬래시 형식)과 각 URL을 등록할 콘솔 필드를 확인할 수 있다
- [ ] **BASE-03**: 운영자는 앱 저장소를 근거로 만든 데이터 목록 하나로 처리하는 개인정보의 항목·출처·목적·저장 위치(리전)·수탁자·국외 이전·보유 기간·삭제 방식을 확인할 수 있고, 처리방침·삭제 안내·약관이 모두 이 목록에서 나온다
- [x] **BASE-04**: 운영자는 사이트가 결정할 수 없는 사용자·법률 결정 목록(위치정보법 분류 U2, 소상공인 해당 U3, Email/Password 노출 U5, 탈퇴 후 코스 처리 U6, 14세 미만 정책 U7, 네이버 지도 고지 U8, Meta 비즈니스 인증 U9, 사업자 값 U11, 메일 서비스 U12, Google 브랜드 검증 U13)을 받아, 무엇이 어느 작업을 막는지 알 수 있다
- [x] **BASE-05**: 다음 작업 세션이 이번 결정을 되돌리지 않도록, `CLAUDE.md`가 바뀐 방침(지원 이메일 공개, 사업자 정보 표시, 영문명 RunningPencil, 한국어+영어, Jekyll 빌드, 앱에 없는 포인트·굿즈·코스북 제거)을 설명한다

### 공유 셸과 스타일 (SHELL)

- [ ] **SHELL-01**: 운영자는 head 링크·「공통」 CSS·헤더·푸터를 한 곳에서 고치면 모든 페이지에 반영되게 할 수 있다 (GitHub Pages 내장 Jekyll `_layouts`/`_includes`/`_data`). 전환 직후 기존 페이지의 출력은 바뀌지 않는다
- [ ] **SHELL-02**: 운영자는 로컬에서 실제 배포와 같은 Jekyll 3.10.0 빌드로 사이트를 미리 보고, 푸시 전에 빌드가 성공하는지 확인할 수 있다
- [ ] **SHELL-03**: 방문자는 라이브 사이트에서 내부 파일(`CLAUDE.md`, `README.md`, `Gemfile`·`Gemfile.lock`, `vendor/`, `.planning/`, `prepare/`)을 열 수 없다 (404)
- [ ] **SHELL-04**: 방문자는 외부 스크립트(Tailwind Play CDN) 없이 정적 CSS만으로 법적 페이지를 보고, 모양은 전환 전과 같다 (375·768·1280px)

### 홈페이지와 도메인 (SITE)

- [ ] **SITE-01**: 심사자는 홈페이지의 소개 문구·메타 설명·OG에서 출시 시점 앱에 없는 기능(포인트·기념 굿즈·코스북)을 보지 않는다
- [ ] **SITE-02**: 심사자는 홈페이지 푸터에서 처리방침(Google 동의 화면에 등록하는 URL과 같은 문자열)·이용약관·데이터 삭제 안내·지원·위치기반서비스 이용약관으로 이동할 수 있고, 모두 `runningpencil.com` 한 도메인 안에 있다
- [ ] **SITE-03**: Google은 Search Console에서 `runningpencil.com`의 도메인 소유권(도메인 속성, DNS TXT)을 확인된 상태로 본다 (가비아 DNS 작업은 사용자가 함)
- [ ] **SITE-04**: 콘솔에 이미 등록된 기존 URL(`/privacy-policy/`, `/terms/`, `/data-deletion/`)과 새 URL(`/support/`, 위치약관, `/en/…`)이 모두 200으로 열리고, 이번 마일스톤 동안 경로가 바뀌지 않는다
- [ ] **SITE-05**: 심사자는 법적 페이지에서 「임시 게시본」 같은 미완성 표시를 보지 않고, 법적 페이지는 검색에 노출된다 (`noindex` 해제, `robots.txt`로 막지 않음)
- [ ] **SITE-06**: 심사자는 홈페이지에서 실제 앱 화면(스크린샷)과 「출시 예정」 표시를 보고, 출시 전이어도 서비스 내용을 확인할 수 있다

### 사업자 정보와 연락처 (BIZ)

- [ ] **BIZ-01**: 방문자는 모든 페이지 푸터에서 사업자등록증과 같은 표기의 상호·대표자·사업자등록번호·주소와 지원 이메일을 본다
- [ ] **BIZ-02**: 운영자는 사업자 정보와 연락처를 한 곳(`_data`)만 고쳐 푸터·지원 페이지·삭제 안내·처리방침·위치약관에 반영하고, 값이 없는 항목은 「추후 기재」 같은 자리표시 없이 아예 표시되지 않는다
- [ ] **BIZ-03**: 운영자가 전화번호를 넣으면 푸터·지원 페이지·보호책임자·위치약관에 바로 나타난다 (이번에는 값 없이 칸만 마련, U1)

### 지원 (SUP)

- [ ] **SUP-01**: 방문자는 `/support/` 맨 위에서 앱 이름(러닝펜슬)을 보고, 지원 이메일과 응답 안내를 찾을 수 있다 (App Store Support URL)
- [ ] **SUP-02**: 외부 주소(Gmail·네이버·iCloud·Outlook)에서 지원 이메일(`runningpencil.com` 도메인 주소)로 보낸 메일이 슬림펌킨 업무 메일에 도착하고, 이를 확인하기 전에는 주소가 사이트에 공개되지 않는다 (메일 라우팅·DNS는 사용자가 함)
- [ ] **SUP-03**: 방문자는 지원 페이지에서 공개 코스를 신고하는 방법(지원 이메일)을 안다
- [ ] **SUP-04**: 방문자는 지원 페이지 FAQ에서 운영 주체, 위치를 수집하는 시점(기록 중에만, 화면이 꺼져도 기록 중이면 수집), 계정 삭제 방법, 공개 코스 신고에 대한 답을 본다
- [ ] **SUP-05**: Apple로 로그인한 사용자(Private Email Relay 주소)에게 보낸 지원 답장이 반송되지 않는다 (지원 메일 도메인 SPF/DKIM, Apple 발신 도메인 등록)

### 데이터 삭제 안내 (DEL)

- [ ] **DEL-01**: 사용자는 앱을 설치하지 않고도 삭제 안내 페이지에서 지원 이메일로 계정·데이터 삭제를 요청하는 방법을 눈에 띄게 찾는다 (Google Play)
- [ ] **DEL-02**: 심사자는 삭제 안내 페이지에서 스토어에 표시되는 앱 이름과 개발자 이름을 본다
- [ ] **DEL-03**: 사용자는 삭제되는 데이터와 남는 데이터(공개 코스 등), 남는 이유와 기간을 안다
- [ ] **DEL-04**: 사용자는 앱 안 삭제 경로를 실제 메뉴 이름(「회원탈퇴」)으로 안내받는다
- [ ] **DEL-05**: 사용자는 삭제에 걸리는 시간(상한)과 완료를 알려 주는 방법을 안다
- [ ] **DEL-06**: 사용자는 위치정보 동의를 철회하면 개인위치정보와 확인자료가 파기된다는 안내를 본다
- [ ] **DEL-07**: 삭제 안내에 제공자별 섹션(`#facebook`, `#google`, `#apple`, `#kakao`, `#naver`, `#line`)이 있어, Facebook Data Deletion Instructions URL 같은 콘솔 필드가 해당 섹션으로 바로 연결된다

### 개인정보처리방침 (PRIV)

- [ ] **PRIV-01**: 처리방침이 데이터 목록(BASE-03)과 같은 처리 항목을 적는다: 로그인 제공자별 수신 항목, 기록 중 GPS 궤적, 코스·기록·뱃지, 프로필 사진, 푸시 토큰, 분석·크래시 정보. 굿즈·배송지·포인트는 없다
- [ ] **PRIV-02**: 처리방침이 처리 목적, 보유 기간, 파기 절차·방법(법령상 보존하는 경우의 근거와 항목 포함)을 적는다
- [ ] **PRIV-03**: 처리방침이 처리 위탁의 수탁자와 업무(Google Firebase·GCP, 네이버클라우드 등)를 적고, 로그인 제공자는 수탁자로 적지 않는다
- [ ] **PRIV-04**: 처리방침이 국외 이전의 근거와 다섯 가지 사항(항목, 국가·시기·방법, 이전받는 자와 연락처, 목적·보유 기간, 거부 방법·효과)을 적는다
- [ ] **PRIV-05**: 처리방침이 안전성 확보 조치를 적는다
- [ ] **PRIV-06**: 사용자는 처리방침에서 열람·정정·삭제·처리정지 요구와 동의 철회·삭제 요청 방법(앱 안 「회원탈퇴」, 지원 이메일)을 안다
- [ ] **PRIV-07**: 사용자는 처리방침에서 개인정보 보호책임자(성명 또는 담당 부서)와 연락처를 본다
- [ ] **PRIV-08**: 처리방침이 자동 수집 장치(Firebase Analytics·Crashlytics 등)의 운영과 거부 방법을 적는다
- [ ] **PRIV-09**: 처리방침이 만 14세 미만 아동 정책(가입 제한 또는 법정대리인 동의)을 적는다 (U7 결정 반영)
- [ ] **PRIV-10**: 처리방침에 로그인 제공자별 수신 항목 표(제공자, 받는 항목, 필수/선택, 용도)가 있어, 카카오 동의항목·네이버 활용처·Google user data 사용 공개를 한 곳에서 확인할 수 있다
- [ ] **PRIV-11**: 처리방침에 시행일과 변경 이력이 있고, 개정하면 이전 버전이 고정 URL에 보관된다

### 이용약관 (TERM)

- [ ] **TERM-01**: 이용약관이 앱의 실제 범위를 다룬다: 포인트·굿즈 조항 삭제, 코스 공개와 공개 후 수정 불가, 탈퇴 후 공개 코스 유지, 사용자 콘텐츠 신고
- [ ] **TERM-02**: 이용약관이 지도·경로 데이터 출처(OpenStreetMap)와 제3자 지도 SDK 이용(네이버 지도) 고지를 담는다 (U8 확인 반영)
- [ ] **TERM-03**: 이용약관에 시행일과 변경 이력이 있다

### 위치기반서비스 이용약관 (LOC)

- [ ] **LOC-01**: 방문자는 홈페이지 푸터에서 눈에 띄는 링크로 「위치기반서비스 이용약관」 페이지를 연다
- [ ] **LOC-02**: 위치약관이 위치정보법 제19조①의 필수 사항(사업자 상호·주소·연락처, 권리와 행사 방법, 서비스 내용, 확인자료 보유 근거·기간, 개인위치정보 보유 목적·기간)을 담는다
- [ ] **LOC-03**: 사용자는 위치약관에서 동의 철회, 수집·이용 일시 중지 요구, 확인자료 열람·고지·정정 요구 방법을 안다
- [ ] **LOC-04**: 위치약관에 시행일과 변경 이력이 있다

### 영문판 (I18N)

- [ ] **I18N-01**: 영어 사용자는 `/en/privacy-policy/`, `/en/terms/`, `/en/data-deletion/`, `/en/support/`에서 국문과 같은 내용을 영어로 읽는다 (서비스명 RunningPencil)
- [ ] **I18N-02**: 영어 사용자는 `/en/` 영문 홈페이지에서 RunningPencil이 무엇을 하는 앱인지 확인한다
- [ ] **I18N-03**: 방문자는 짝이 있는 문서마다 언어 전환 링크로 다른 언어판으로 이동하고, 각 페이지는 자기 참조를 포함한 `hreflang`(전체 URL)을 갖는다. 언어 자동 리디렉션은 없다
- [ ] **I18N-04**: 영문판은 「한국어판이 우선한다」는 문구와 국문판 시행일을 표시하고, 국문이 바뀌었는데 영문이 뒤처지면 운영자가 알 수 있다

### 제출 준비 (SUBMIT)

- [ ] **SUBMIT-01**: 운영자는 제공자 6곳(카카오·네이버·Google·Apple·Facebook·LINE)과 스토어 2곳(App Store·Google Play)의 콘솔별 입력값 체크리스트(필드·URL·언어판·이름·로고·설명 문구·담당 이메일·도메인 인증 절차)를 따라 제출할 수 있다
- [ ] **SUBMIT-02**: 운영자는 카카오·네이버가 출시 전 서비스에 요청하는 서비스 소개 자료의 목록을 받는다
- [ ] **SUBMIT-03**: 운영자는 배포 후 URL 대장의 모든 URL이 200으로 열리는지 확인하는 절차와, 심사 중 푸시 자제 같은 운영 규칙을 따른다

## 마일스톤 인수 항목 (사용자 확인)

외부 결과라 사이트만으로 검증할 수 없습니다. 로드맵의 단계별 성공 기준에는 넣지 않고, 마일스톤을 마칠 때 사용자가 확인합니다.

- [ ] **ACPT-01**: 제공자 6곳의 통과를 사용자가 확인한다. 제공자마다 통과의 뜻이 다릅니다.
  - 카카오: 비즈앱 전환과 동의항목 심사
  - 네이버: 로그인 검수
  - Google: OAuth 동의 화면 게시(브랜드 검증은 U13 결정에 따름)
  - Apple: Sign in with Apple 프로덕션 구성
  - Facebook: Live 전환(필요하면 비즈니스 인증, U9)
  - LINE: 채널 공개(Published)
- [ ] **ACPT-02**: 위치정보법상 신고 또는 등록이 필요한지(U2)와 그 처리 여부를 사용자가 확인한다

## v2 Requirements

다음으로 미룹니다. 현재 로드맵에는 들어가지 않습니다.

### 위치·법령 분기

- **LOC-05**: 위치정보사업(제5조 등록) 대상으로 분류되면 제18조① 항목(수집사실 확인자료 보유 근거·기간 등)을 위치약관에 추가
- **LOC-06**: 위치기반서비스 이용약관 영문판 (필요성이 확인되면)

### 도메인·판매

- **SITE-07**: Apple Services ID에 `runningpencil.com`을 등록하게 되면 `/.well-known/` 도메인 검증 파일 게시 (Jekyll `include:` 필요)
- **BIZ-04**: 유료 기능이나 판매를 도입하면 통신판매업 신고번호 표시

### 출시 후 사이트 (다음 마일스톤)

- **LIVE-01**: 앱스토어·Google Play 뱃지와 링크
- **LIVE-02**: 스토어 평점, 인기 코스, 명예의 전당, 사용자 리뷰를 실데이터로 표시 (로그인 없는 공개 데이터 보기)

## Out of Scope

| Feature | Reason |
|---------|--------|
| 웹 소셜 로그인, 내 기록 보기, 웹 코스 그리기·올리기, 코스 공유 상세 | 오픈 후 웹 연동 범위를 「로그인 없는 공개 데이터 보기」로 한정하기로 결정 |
| 히어로 쿼터뷰 그림의 애니메이션 교체 | 이번 범위에서 제외 |
| 일본어판 | 한국어와 영어만 제공 |
| App Store·Google Play 심사 통과 자체 | 앱을 제출하는 출시 시점의 일이고 앱 저장소 범위. 이번에는 웹사이트 쪽 요건만 다룸 |
| 전화번호 공개 | 이번에는 이메일만 공개하고 칸만 마련 (BIZ-03). 법률 확인이나 심사에서 요구하면 추가 |
| 이메일 수집 폼, 외부 폼 서비스(Google Forms 등) | 정적 호스팅이라 서버 처리 불가. 외부 폼은 처리 위탁과 국외 이전을 늘림 |
| 이메일만으로 삭제 받기 | 앱 안 「회원탈퇴」를 대체하면 안 됨 (Apple 5.1.1(v)). 웹 이메일은 보조 경로 |
| PDF·Notion 처리방침, `robots.txt` 차단 | 공개 HTML·크롤러 접근 요건 위반 (Meta·Play) |
| 언어 자동 리디렉션 (JS) | 심사 크롤러와 등록 URL을 흔듦 |
| 자리표시 사실값 (「추후 기재」 등) | 미완성 사이트로 반려될 수 있음. 값이 없으면 항목 자체를 숨김 |
| Cloudflare로 네임서버 이전 | 심사 기간에 DNS 전체를 옮기는 위험. 가비아 DNS 유지 |
| Jekyll i18n 플러그인 (`jekyll-polyglot` 등), `.nojekyll`, 전역 `permalink` | GitHub Pages 허용 목록 밖이거나 내부 파일 공개 위험 |
| Apple 웹 도메인 검증 파일 (이번 마일스톤) | Android Apple 로그인은 Firebase 핸들러 도메인을 쓰므로 `runningpencil.com`이 필요 없을 가능성이 높음 (SITE-07로 v2 보관) |
| 법률 자문 확정 | 이번 결과물은 앱 동작에 근거한 초안. 법률 검토는 출시 전에 따로 받음 |

## Traceability

어느 단계가 어느 요구사항을 맡는지 적습니다. 로드맵을 만들 때 채웁니다.

| Requirement | Phase | Status |
|-------------|-------|--------|
| BASE-01 | Phase 1 | Complete |
| BASE-02 | Phase 1 | Complete |
| BASE-03 | Phase 1 | Pending |
| BASE-04 | Phase 1 | Complete |
| BASE-05 | Phase 1 | Complete |
| SHELL-01 | Phase 2 | Pending |
| SHELL-02 | Phase 2 | Pending |
| SHELL-03 | Phase 2 | Pending |
| SHELL-04 | Phase 3 | Pending |
| SITE-01 | Phase 4 | Pending |
| SITE-02 | Phase 8 | Pending |
| SITE-03 | Phase 5 | Pending |
| SITE-04 | Phase 10 | Pending |
| SITE-05 | Phase 8 | Pending |
| SITE-06 | Phase 4 | Pending |
| BIZ-01 | Phase 5 | Pending |
| BIZ-02 | Phase 5 | Pending |
| BIZ-03 | Phase 5 | Pending |
| SUP-01 | Phase 5 | Pending |
| SUP-02 | Phase 5 | Pending |
| SUP-03 | Phase 5 | Pending |
| SUP-04 | Phase 5 | Pending |
| SUP-05 | Phase 10 | Pending |
| DEL-01 | Phase 6 | Pending |
| DEL-02 | Phase 6 | Pending |
| DEL-03 | Phase 6 | Pending |
| DEL-04 | Phase 6 | Pending |
| DEL-05 | Phase 6 | Pending |
| DEL-06 | Phase 6 | Pending |
| DEL-07 | Phase 6 | Pending |
| PRIV-01 | Phase 7 | Pending |
| PRIV-02 | Phase 7 | Pending |
| PRIV-03 | Phase 7 | Pending |
| PRIV-04 | Phase 7 | Pending |
| PRIV-05 | Phase 7 | Pending |
| PRIV-06 | Phase 7 | Pending |
| PRIV-07 | Phase 7 | Pending |
| PRIV-08 | Phase 7 | Pending |
| PRIV-09 | Phase 7 | Pending |
| PRIV-10 | Phase 7 | Pending |
| PRIV-11 | Phase 7 | Pending |
| TERM-01 | Phase 8 | Pending |
| TERM-02 | Phase 8 | Pending |
| TERM-03 | Phase 8 | Pending |
| LOC-01 | Phase 8 | Pending |
| LOC-02 | Phase 8 | Pending |
| LOC-03 | Phase 8 | Pending |
| LOC-04 | Phase 8 | Pending |
| I18N-01 | Phase 9 | Pending |
| I18N-02 | Phase 9 | Pending |
| I18N-03 | Phase 9 | Pending |
| I18N-04 | Phase 9 | Pending |
| SUBMIT-01 | Phase 10 | Pending |
| SUBMIT-02 | Phase 10 | Pending |
| SUBMIT-03 | Phase 10 | Pending |

**Coverage:**
- v1 requirements: 55 total
- Mapped to phases: 55
- Unmapped: 0 ✓

---
*Requirements defined: 2026-11-14*
*Last updated: 2026-11-14 after roadmap creation*
