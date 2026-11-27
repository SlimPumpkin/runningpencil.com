# 러닝펜슬 웹사이트 (runningpencil.com)

## What This Is

모바일 앱 러닝펜슬(지도 위 GPS 아트 코스를 걷거나 달려 완주하면 코스 모양 뱃지를 모으고, 직접 그린 코스를 공개할 수 있는 앱)의 공식 웹사이트입니다. GitHub Pages 정적 사이트이고, 운영사는 슬림펌킨입니다. 서비스가 오픈할 때까지는 티저 랜딩을 유지하면서, 소셜 로그인 제공자 6곳(카카오·네이버·Google·Apple·Facebook·LINE)의 비즈앱 등록과 프로덕션 심사, 양 스토어 등록에 필요한 홈페이지·개인정보처리방침·이용약관·데이터 삭제 안내·지원 URL을 제공합니다. 오픈 후에는 앱스토어 뱃지, 평점, 인기 코스, 명예의 전당, 사용자 리뷰 같은 실데이터를 보여 주는 데스크톱용 웹사이트로 키울 예정입니다. 이 확장은 다음 마일스톤에서 합니다.

## Core Value

소셜 로그인 제공자와 스토어 심사자가 이 사이트만 보고 러닝펜슬이 어떤 서비스인지, 누가 운영하는지, 어떤 개인정보를 어떻게 처리하는지, 어떻게 연락하고 데이터를 지울 수 있는지 확인할 수 있어야 합니다. 그래서 심사가 웹사이트 때문에 반려되지 않아야 합니다.

## Requirements

### Validated

<!-- 기존 코드에서 추론. .planning/codebase/ 분석 기준 (2026-11-14, c4cb26d). -->

- ✓ 티저 랜딩: 헤더, 히어로(임시 쿼터뷰 지도 그림), 스크롤에 고정되는 「세 가지 이유」(`#story`), 7초 「달려 보기」 데모(`#demo`), 출시 안내(`#get`), 푸터 — existing
- ✓ 법적 페이지 3종의 임시 게시본: 개인정보처리방침·이용약관·데이터 삭제 안내 (`noindex`, 모눈종이 바탕 + 흰 카드 레이아웃) — existing
- ✓ 커스텀 도메인 `runningpencil.com`(`CNAME`)과 GitHub Pages 자동 배포(`main` 푸시 = 배포) — existing
- ✓ 파비콘 세트, `site.webmanifest`, 랜딩 Open Graph 메타 — existing
- ✓ 접근성 기본: `prefers-reduced-motion` 존중, `:focus-visible`, `aria-pressed` 동기화, 장식 SVG `aria-hidden` — existing
- ✓ 홈 푸터에서 법적 페이지 3종으로 링크되고 OSM 출처를 표기 — existing
- ✓ 기준 문서: 이름 표·URL 대장·데이터 목록·결정 목록·사용자 작업 절차서(`.planning/baseline/`) — Phase 1 (BASE-01~04)
- ✓ 바뀐 방침(연락처 공개·사업자 정보·영문판·빌드 방식)을 `CLAUDE.md`에 반영 — Phase 1 (BASE-05)
- ✓ 공통 블록(head 링크·「공통」 CSS·헤더·푸터)을 `_includes` 네 개와 `_layouts/legal.html`에서 한 벌로 관리하고, 전환 전과 출력이 같음 — Phase 2 (SHELL-01)
- ✓ 운영과 같은 Jekyll 3.10.0 로컬 미리보기(`Gemfile`)와 푸시 전 점검(`scripts/check-site.sh`, pre-push 훅) — Phase 2 (SHELL-02)
- ✓ 라이브에서 내부 파일(`CLAUDE.md`·`README.md`·`Gemfile`·`.planning/` 등)이 404 — Phase 2 (SHELL-03)
- ✓ 법적 페이지 3종을 Tailwind Play CDN 없이 정적 CSS(`_includes/css/legal.css`)로 그리고, 모양(375·768·1280px 픽셀)과 본문 텍스트가 전환 전과 같음. 이후 법적 본문은 클래스 없는 허용 요소만으로 씀 — Phase 3 (SHELL-04)
- ✓ 홈페이지 본문·메타 설명·OG에서 포인트·굿즈·코스북을 지움(빌드 결과 0건). `scripts/check-site.sh` 6번 항목이 푸시마다 랜딩 출력을 확인함 — Phase 4 (SITE-01)
- ✓ 홈페이지 「실제 앱 화면」 구간(`#screens`)에 iPhone 앱 화면 캡처 세 장(`images/app/` WebP)과 「출시 준비 중」 딱지를 보여 줌. 기존 동작(고정되는 세 가지 이유, 7초 달려 보기, 움직임 줄이기)은 그대로 — Phase 4 (SITE-06)
- ✓ 모든 페이지 푸터에 사업자등록증과 같은 표기의 상호·대표자·사업자등록번호·주소와 지원 이메일을 보여 줌. 값은 `_data/company.yml` 한 곳에만 있고 값이 없는 항목은 그리지 않음(전화는 칸만, 넣으면 푸터·지원 페이지에 바로 나옴) — Phase 5 (BIZ-01~03)
- ✓ `/support/` 고객 지원 페이지(문의·공개 코스 신고·FAQ, 앵커 `#contact`·`#report`·`#faq`)와 헤더·푸터의 「고객 지원」 링크 — Phase 5 (SUP-01·SUP-03·SUP-04)
- ✓ 지원 이메일 공개: 외부 4곳 수신 시험(이메일 게이트, 2026-11-19)이 통과한 뒤에만 주소가 사이트에 들어갔고, `scripts/check-site.sh` 7번 항목이 지원 페이지 연락처를 지킴 — Phase 5 (SUP-02)
- ✓ Search Console 도메인 속성 소유권 확인, 가비아 DNS에 Google MX·SPF·Search Console TXT — Phase 5 (SITE-03)
- ✓ `/data-deletion/` 재작성: 앱 없이 지원 이메일로 삭제를 요청하는 방법(메일에 적을 내용 포함), 스토어 개발자 이름 소개 문단, 지워지는 데이터와 남는 데이터 표(이유·기간), 「요청을 받은 날부터 10일 안」 상한과 답장 알림, 앱 안 경로 「회원탈퇴」, 위치정보 동의 철회 시 개인위치정보·확인자료 파기, 제공자 앵커 여섯(`#google`·`#apple`·`#facebook`·`#kakao`·`#naver`·`#line`). 검색 제외·임시 표시를 지웠고 사업자 정보·연락처는 `_data/company.yml`에서 읽음. `scripts/check-site.sh` 6·8번이 푸시마다 지킴 — Phase 6 (DEL-01~07, BIZ-05)

### Active

<!-- 이번 마일스톤(1단계: 티저 유지 + 심사 대응). 출시 전까지는 모두 가설입니다. -->

**심사 요건 확정**
- [ ] 6개 제공자(카카오·네이버·Google·Apple·Facebook·LINE)와 App Store·Google Play가 요구하는 웹사이트 쪽 항목을 공식 문서 기준 체크리스트로 확정한다
- [ ] 제공자·스토어별로 콘솔에 넣을 URL, 도메인 인증 절차, 설명 문구를 제출 체크리스트로 정리한다

**법적 본문**
- [ ] 개인정보처리방침을 앱의 실제 동작 기준으로 다시 쓴다. 넣을 것: 소셜 6곳에서 받는 항목, 기록 중 GPS 궤적(백그라운드 포함), Firebase 서비스(Auth·Firestore·Storage·Functions·Analytics·Crashlytics·FCM·App Check·Remote Config), 네이버 지도·검색 API, 자체 경로 라우터, 처리 위탁·국외 이전 여부, 개인정보 보호책임자와 연락처
- [ ] 이용약관을 앱의 실제 동작과 사업자 정보 기준으로 다시 쓴다
- [ ] 「위치기반서비스 이용약관」 페이지를 게시한다 (위치정보법 제12조①). 신고·등록 대상 여부는 법률 확인으로 범위를 조정한다
- [ ] 사이트·법적 문서에서 출시 시점 앱에 없는 기능(포인트·굿즈·배송지·코스북)을 제거한다 (랜딩은 Phase 4, 삭제 안내는 Phase 6에서 끝남. 처리방침·약관 본문은 Phase 7·8)
- [ ] 처리방침·약관·삭제 안내·지원 페이지의 영문판을 제공한다

**사업자 표시**
- [ ] 처리방침·위치약관의 사업자 정보와 연락처도 `_data/company.yml` 한 곳에서 읽는다 (BIZ-06·BIZ-07, Phase 7·8. 삭제 안내 BIZ-05는 Phase 6에서 끝남)

**외부 인수 (사용자 확인)**
- [ ] 6개 제공자의 프로덕션 심사·비즈앱 전환이 통과됐음을 사용자가 확인한다. 사이트만으로는 검증할 수 없으므로 단계별 성공 기준에는 넣지 않고 마일스톤 인수 항목으로만 둔다

### Out of Scope

- 오픈 후 실데이터 사이트(스토어 뱃지·평점·인기 코스·명예의 전당·사용자 리뷰) — 다음 마일스톤. 연동 범위는 「로그인 없는 공개 데이터 보기」로 확정됨 (2026-11-14)
- 웹 소셜 로그인, 내 기록 보기, 웹에서 코스 그리기·올리기, 코스 공유 상세 페이지 — 연동 범위를 공개 데이터 보기로 한정하기로 결정
- 히어로 쿼터뷰 그림의 애니메이션 교체 — 이번 범위에서 제외
- 일본어판 — 한국어와 영어만 제공. 필요해지면 추가
- App Store·Google Play 심사 통과 자체 — 앱을 제출하는 출시 시점의 일이고 앱 저장소 범위. 이번에는 웹사이트 쪽 요건(Support URL·삭제 안내·처리방침)만 다룸
- 이메일 수집 폼과 서버 처리 — 정적 호스팅이라 불가. 연락은 공개 이메일로만 받음
- 법률 자문 확정 — 이번 결과물은 앱 동작에 근거한 초안이고, 법률 검토는 출시 전에 따로 받음

## Context

- **현재 사이트**: GitHub Pages 내장 Jekyll(3.10.0)이 배포할 때 조립하는 정적 4페이지(`index.html`, `privacy-policy/`, `terms/`, `data-deletion/`). 공통 블록은 `_includes` 네 개(head 링크·「공통」 CSS·헤더·푸터)에 한 벌씩 있고, 법적 3종의 틀은 `_layouts/legal.html` 하나입니다 (Phase 2, 2026-11-16). 랜딩은 순수 CSS와 인라인 JS이고, 법적 페이지는 외부 스크립트 없이 정적 CSS(`_includes/css/legal.css`, 레이아웃에 인라인)로 그립니다 (Phase 3, 2026-11-17). 랜딩 소개 문구에서 출시 범위 밖 기능을 지웠고, 「달려 보기」와 「출시 안내」 사이에 「실제 앱 화면」 구간(앱 화면 캡처 WebP 세 장, 「출시 준비 중」 딱지, 「지도 © NAVER Corp.」)을 더했습니다. 그림은 인라인 SVG이고 예외는 `images/app/` 캡처뿐입니다 (Phase 4, 2026-11-19). 모든 페이지 푸터에 사업자 정보와 지원 이메일이 있고 값은 `_data/company.yml` 한 곳에서 나옵니다. 다섯 번째 페이지 `/support/`(고객 지원)가 생겼습니다 (Phase 5, 2026-11-19). `/data-deletion/`은 데이터 목록 기준으로 다시 썼고 검색 제외·임시 표시가 없습니다. 처리방침·약관에는 아직 둘 다 있습니다 (Phase 6, 2026-11-27). 상세는 `.planning/codebase/`(ARCHITECTURE·STACK·CONCERNS 등) 참고.
- **앱 저장소**: `~/dv/woody/running_pencil` (Flutter + Firebase). 개인정보처리방침의 근거는 여기서 가져옵니다.
  - 소셜 로그인: `kakao_flutter_sdk_user`, `naver_login_flutter`, `google_sign_in`, Apple(`flutter_web_auth_2`/Firebase Auth), `flutter_facebook_auth`, `flutter_line_sdk`, 그리고 익명 로그인(둘러보기만)
  - Firebase: Auth·Firestore·Storage·Functions·Analytics·Crashlytics·Messaging·App Check·Remote Config
  - 위치: `geolocator`로 기록 중(시작~종료) GPS를 받으며, 다른 앱으로 넘어가거나 화면이 꺼져도 계속 받습니다. 권한은 「앱 사용 중에만 허용」이고 백그라운드 위치 권한(Always)은 없습니다
  - 지도·검색: 네이버 지도 SDK, NCP 지오코딩·지역검색(Functions 경유, 결과는 저장하지 않음). 경로 스냅은 GCP VM의 자체 OSRM 라우터
  - 앱 PROJECT.md는 「스토어 출시·비즈앱 등록·github.io 페이지」를 앱 MVP의 범위 밖으로 둡니다. 따라서 심사 통과는 앱 쪽 진행에도 달려 있습니다
- **현재 처리방침의 빈 곳**: 개인정보 보호책임자와 연락처 없음, Firebase(Google) 처리 위탁과 국외 이전 언급 없음, 푸시 토큰·분석·크래시 수집 언급 없음. 반대로 굿즈 교환(배송지) 항목은 들어 있는데, 앱의 실제 범위와 맞는지 확인해야 합니다.
- **심사 진행 상황**: dev용 소셜 로그인 앱은 등록돼 있습니다. 비즈앱 전환과 프로덕션 심사는 아직입니다. 신청 날짜는 정하지 않았습니다(앱 일정에 따라 유동적).
- **질문 단계 조사 결과 (2026-11-14)**
  - 확인됨, Google OAuth 검증: 홈페이지가 앱을 설명해야 하고 로그인 폼만 있는 페이지는 인정되지 않습니다. 처리방침은 홈페이지와 같은 도메인에 있어야 하며 홈페이지에서 링크해야 합니다. 홈페이지·처리방침·약관 도메인은 Search Console에서 소유권을 확인받아야 합니다 ([출처](https://support.google.com/cloud/answer/13464321))
  - 확인됨, Google Play 계정 삭제: 앱을 다시 설치하지 않고 웹에서 삭제를 요청할 수 있어야 합니다. 링크·고객 지원 이메일·폼 중 하나면 되고, 페이지는 스토어에 표시된 앱 이름이나 개발자 이름을 언급해야 합니다 ([출처](https://support.google.com/googleplay/android-developer/answer/13327111))
  - 2차 출처만 있음, App Store 1.5: Support URL 페이지에 연락 방법이 있어야 합니다 (공식 원문 재확인 필요)
  - 조사 필요: 카카오 비즈앱·네이버 로그인 검수의 웹사이트 요건(공식 출처를 찾지 못함), LINE 채널 공개 요건, Apple(Android·웹 흐름의 도메인 요건), 위치정보법상 약관 게시와 신고 의무

## Constraints

- **Hosting**: GitHub Pages 정적 호스팅이고 `main` 푸시가 곧 배포입니다 — 서버 처리·폼·DB가 없으므로, 깨진 HTML이 바로 라이브에 올라가지 않게 푸시 전 로컬 확인이 필요합니다
- **Domain**: `/favicon/...`, `/terms/` 같은 절대 경로는 커스텀 도메인 연결이 전제입니다 — 프로젝트 사이트라 도메인이 풀리면 하위 경로로 서빙되어 깨집니다
- **Same-domain legal URLs**: 처리방침·약관·삭제 안내·지원 페이지는 모두 `runningpencil.com` 아래에 둡니다 — Google 검증이 홈페이지와 같은 도메인을 요구합니다
- **User-supplied facts**: 사업자 정보(대표자·사업자등록번호·주소), 지원 메일 주소, 메일 라우팅·DNS, Search Console 인증은 사용자가 주거나 직접 합니다 — 추측해서 채우지 않습니다
- **Legal drafts**: 법적 본문은 앱 코드에서 확인한 사실에만 근거해 씁니다 — 법률 검토 전 초안이며, 확인 안 된 항목은 표시해 둡니다
- **Language**: 한국어가 기본이고 영문판을 병행합니다 — 영문 서비스명은 스토어 등록명·동의 화면과 일치해야 합니다
- **Visual language**: 기존 디자인(연필 노랑 `#F2B134`, 흑연 `#2B2B2B`, Pretendard, 모눈종이 법적 페이지)을 유지합니다 — 이번 범위는 심사 대응이지 리디자인이 아닙니다

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| 이번 마일스톤은 1단계(티저 유지 + 심사 대응)만 | 오픈 후 실데이터 사이트는 앱 출시에 달려 있음 | — Pending |
| 오픈 후 웹 연동은 「로그인 없는 공개 데이터 보기」로 한정 | 웹 로그인·편집 없이 평점·인기 코스·명예의 전당·리뷰만 보여 줌 (다음 마일스톤 전제) | — Pending |
| 소셜 로그인 6곳 모두 대응 (Facebook·LINE 포함) | 앱 코드와 앱의 결정 D-15가 6개를 켬 | — Pending |
| 전용 지원 이메일 공개 — 기존 「연락처 미표시」 방침을 뒤집음 | Google Play 웹 삭제 요청, App Store 1.5, 처리방침의 보호책임자 연락처에 연락 수단이 필요함 | ✓ Phase 5 (이메일 게이트 2026-11-19 통과 뒤 푸터·`/support/`에 공개). 삭제 안내는 Phase 6, 처리방침·약관은 Phase 7·8 |
| 지원 메일은 Google Workspace 사용자 별칭 도메인으로 받고 지원 주소에서 답장 (U12 결정, 2026-11-14) | 슬림펌킨 업무 메일이 Google Workspace라 제3자 전달 서비스 없이 `runningpencil.com` 주소를 받고 그 주소로 답장할 수 있음. 답장 도메인에 DKIM을 걸어 Phase 10의 Apple 릴레이 답장에 씀 | ✓ Phase 5 (수신 4/4, 보내기 설정 확인. UAT 2026-11-20). DKIM은 Phase 10 |
| 푸터에 사업자 정보 전부 표시 | 카카오 비즈앱 심사의 사업자-서비스 관계 확인, 국내 서비스 관행 | ✓ Phase 5 (사업자등록증 대조 UAT 2026-11-20). 영문 표기는 Phase 9 |
| 한국어 + 영어 제공 — 기존 `ko` 전용 방침을 뒤집음 | Google·Facebook·Apple·LINE 심사자가 읽을 수 있어야 함 | — Pending |
| 영문 서비스명은 `RunningPencil` — 기존 「RunningPencil 쓰지 않음」 방침을 뒤집음 | 영문판과 Google·Meta·LINE·스토어 콘솔에서 같은 이름을 써야 함 (요구사항 단계에서 결정) | — Pending |
| 출시 시점 앱에 없는 포인트·굿즈·배송지·코스북을 사이트·법적 문서·`CLAUDE.md`에서 제거 | 앱 REQUIREMENTS는 포인트 리워드를 Out of Scope, 코스북을 나중 단계로 둠. 심사는 사이트와 앱이 일치하는지 봄 (U10) | ◐ 랜딩은 Phase 4, 삭제 안내는 Phase 6에서 제거(check-site 6번이 두 출력을 지킴). 처리방침·약관 본문은 Phase 7·8 |
| 랜딩 앱 화면 캡처 ③ 완주 결과는 앱의 뱃지 창이 NAVER 로고를 덮은 원본 그대로 쓰고, run·badge의 상태 표시줄 차이도 받아들임. 우리 쪽에서 로고를 원본보다 더 자르거나 덮지 않는 조건은 유지 (Phase 4 D-18·D-20, 2026-11-18 사용자 예외) | 출시 범위 화면을 지금 앱에서 그대로 보여 주는 것이 우선. NAVER 지도 SDK 가이드의 위험은 사용자가 듣고 받아들임 | ✓ Phase 4. 앱에서 로고나 뱃지 창 위치를 고치면 ③만 다시 찍어 교체 |
| 출시 전 표시는 「출시 준비 중」을 그대로 쓰고 출시 시기는 적지 않음 (Phase 4 D-08·D-09) | 앱 일정이 유동적이라 지난 날짜가 남으면 방치된 사이트처럼 보임 | ✓ Phase 4 |
| 전화번호는 이번에 공개하지 않고 칸만 마련 | App Store Support URL 원문과 PIPA·위치정보법이 「전화번호 등 연락처」를 예로 듦. 법률 확인이나 심사에서 요구하면 값만 넣어 바로 표시 (U1) | ✓ Phase 5 칸 마련(`phone` 빈 값, 넣으면 푸터·지원 페이지에 바로 표시). 처리방침·위치약관 연결은 BIZ-06·BIZ-07 |
| 법적 페이지 `noindex` 해제, 「임시 게시본」 문구 삭제 | Apple 2.1(a)·네이버 4.1이 미완성 사이트로 반려할 소지 | ◐ 삭제 안내는 Phase 6 재작성 커밋에서 지움(check-site 8번이 지킴). 처리방침·약관은 Phase 7·8 |
| `/support/` 지원 페이지 신설 | App Store Support URL용 전용 페이지가 심사자에게 가장 분명함 | ✓ Phase 5 |
| 법적 본문은 앱 실제 동작 기준 초안, 법률 검토는 출시 전에 따로 | 현재 임시 게시본은 앱 실제 범위와 맞지 않음 | — Pending |
| 위치기반서비스 이용약관 페이지를 기본으로 포함, 범위만 법률 확인으로 조정. 경로는 `/location-terms/`로 확정 (D-15) | 조사 결과 위치정보법 제12조①이 이용약관 공개 의무를 둠. 신고(제9조)인지 등록(제5조)인지는 법률 확인 필요 (U2) | — Pending |
| Tailwind Play CDN 제거와 공통 블록 단일화 — 「빌드 없음」 방침이 바뀔 수 있음 | 심사 대상 페이지의 안정성, 페이지가 늘수록(영문판·지원) 복사 드리프트 위험이 커짐. 방식(Jekyll include 등)은 단계에서 결정 | ✓ 공통 블록 단일화는 Phase 2(Jekyll `_includes`·`_layouts`, 출력 불변, 2026-11-16), Tailwind CDN 제거는 Phase 3(정적 `legal.css`, 기준과 픽셀·텍스트 동일, 2026-11-17) |
| 로컬 빌드는 `Gemfile`로 Jekyll 3.10.0만 고정하고(github-pages gem은 로컬 Ruby 4.x에 설치되지 않음) `main` 푸시마다 pre-push 훅이 `scripts/check-site.sh`를 돌림 (Phase 2) | CI가 없어 푸시가 곧 배포. 운영과 같은 버전으로 빌드해 깨진 출력·내부 파일 공개를 푸시 전에 잡음 | ✓ Phase 2 |
| 「공통」 CSS 머리 주석 한 줄은 출력 불변의 승인된 예외 (D-06). ROADMAP 성공 기준 1 문구도 이 예외에 맞게 고침 (UAT, 2026-11-16) | 「네 파일에 복사해 쓴다」는 옛 주석이 남으면 운영자가 잘못 고침. 전환 커밋 시점은 diff 0, 최종 상태는 주석을 지우면 diff 0 | ✓ Phase 2 |
| 법적 본문은 클래스 없는 허용 요소만으로 쓰고, 표는 모두 `<figure tabindex="0" aria-label="…">`로 감싸며 표 머리 행은 줄바꿈하지 않음(nowrap, D-19). 규칙 원본은 `.planning/codebase/CONVENTIONS.md` 「법적 본문 작성 규칙」 (Phase 3) | Phase 6~9의 처리방침·약관·삭제 안내·지원 페이지·영문판이 새 CSS 없이 텍스트만 쓰면 되게 함 (Phase 3 성공 기준 4, 사용자가 시험 본문 승인) | ✓ Phase 3 |
| 법적 페이지 CSS의 글자 크기·간격은 px 고정을 유지 (코드 리뷰 WR-01, UAT 2026-11-17에서 사용자가 받아들임) | 기본 글꼴 16px에서 전환 전(Tailwind rem)과 픽셀이 같음. 브라우저 기본 글꼴 크기를 바꾼 사용자에게 제목·간격이 함께 커지지 않는 차이는 감수 | ✓ Phase 3 |
| 완료 = 6개 제공자 프로덕션 심사 통과를 사용자가 확인. 스토어는 웹사이트 요건까지 | 심사 통과는 외부 이벤트라 단계별 성공 기준에서 빼고 인수 항목으로 둠 | — Pending |
| BIZ-02·BIZ-03은 Phase 5가 만든 범위(푸터·지원 페이지)로 줄이고, 법적 문서 범위는 BIZ-05(삭제 안내, Phase 6)·BIZ-06(처리방침·보호책임자, Phase 7)·BIZ-07(위치약관, Phase 8)로 나눠 각 단계 성공 기준에 넣음 (Phase 5 UAT 9번 결정 (b), 2026-11-20) | 한 ID를 여러 단계에 걸면 첫 단계가 끝날 때 체크돼 버림. 나누지 않으면 뒤 단계에 「`_data`에서 읽음」 검증 기준이 없어 법적 문서에 값을 직접 적는 실수를 잡지 못함 | ✓ REQUIREMENTS·ROADMAP 반영 (`99021d5`) |
| 데이터 목록의 「수탁자」 열은 PRIV-03 분류(Google Firebase·GCP, 네이버클라우드는 수탁자, 로그인 제공자는 아님)만 옮기고, 그 밖의 받는 곳(Meta (Facebook SDK) 등)의 수탁·제3자 제공 구분은 Phase 7에서 정함 (G-01-8, 2026-11-15) | 데이터 목록은 사실만 적고 법적 구분은 처리방침 단계에서 함. 열 이름은 BASE-03 문구라 유지 | ✓ Phase 1 데이터 목록에 반영 |
| 출시는 무료. 유료 구독은 출시 뒤 반응을 보고 도입 (2026-11-25 사용자 결정) | 출시 시점 앱에 결제 기능이 없음. 이번 마일스톤의 약관·처리방침은 무료 서비스 기준으로 쓰고, 도입할 때 요금·결제·환불 조항과 통신판매업 표시를 더함 (v2 TERM-04, BIZ-04) | — Pending |
| 삭제 안내 소개 문단의 개발자 이름은 `_data/company.yml`의 `store_developer_name` 한 곳에서 읽고, 값은 `.planning`·커밋 메시지에 적지 않음 (Phase 6 D-18·D-02) | Google Play 계정 삭제 정책이 스토어에 표시된 앱 이름이나 개발자 이름을 요구함. 저장소가 공개라 값은 키 이름으로만 가리킴 | ✓ Phase 6. UAT(2026-11-27)에서 Play Console 「개발자 이름」과 Apple Developer 「법인명」(조직 계정은 이 이름이 App Store 판매자 이름으로 나감, Apple 문서)이 값과 같음을 확인. 두 스토어 공개 페이지는 앱 등록 전이라 Phase 10·출시 때 다시 봄 |
| 남는 데이터의 기간은 prod 사실이 아니라 상한 약속으로 씀(「삭제 뒤 최대 7일」, 「최대 30일」 등, Phase 6 D-33 ② proposal). 공개 코스는 「서비스를 운영하는 동안」 남고 탈퇴한 사람의 공개 코스를 지우는 경로는 약속하지 않음(D-39) | prod 프로젝트가 아직 없어 값을 잴 수 없음. 약속이 참이 되려면 prod 전제(데이터 목록 「prod 전제 (Phase 6 D-42)」 다섯과 추가 전제 다섯)를 지켜야 함 | ✓ Phase 6. prod를 만들 때 전제를 확인 |
| 위치정보 확인자료는 6개월 보관, 동의 철회·탈퇴 때 지체 없이 파기 (2026-11-26 사용자 결정, 법률 확인 전 초안) | 고시 제6조⑤의 하한과 위치정보법 제24조④. 앱은 184일 TTL과 세 파기 경로로 구현함 | ✓ Phase 6 (앱 기준 커밋 `92e986c3`에서 확인, UAT 4번) |

## Evolution

This document evolves at phase transitions and milestone boundaries.

**After each phase transition** (via `/gsd-transition`):
1. Requirements invalidated? → Move to Out of Scope with reason
2. Requirements validated? → Move to Validated with phase reference
3. New requirements emerged? → Add to Active
4. Decisions to log? → Add to Key Decisions
5. "What This Is" still accurate? → Update if drifted

**After each milestone** (via `/gsd-complete-milestone`):
1. Full review of all sections
2. Core Value check — still the right priority?
3. Audit Out of Scope — reasons still valid?
4. Update Context with current state

---
*Last updated: 2026-11-27 after Phase 6 (데이터 삭제 안내 재작성, UAT 6/6 통과)*
