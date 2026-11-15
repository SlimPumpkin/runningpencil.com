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

### Active

<!-- 이번 마일스톤(1단계: 티저 유지 + 심사 대응). 출시 전까지는 모두 가설입니다. -->

**심사 요건 확정**
- [ ] 6개 제공자(카카오·네이버·Google·Apple·Facebook·LINE)와 App Store·Google Play가 요구하는 웹사이트 쪽 항목을 공식 문서 기준 체크리스트로 확정한다
- [ ] 제공자·스토어별로 콘솔에 넣을 URL, 도메인 인증 절차, 설명 문구를 제출 체크리스트로 정리한다

**지원·연락**
- [ ] `/support/` 지원 페이지: 앱 이름을 맨 위에 두고, 자주 묻는 질문과 지원 이메일을 담는다 (App Store Support URL 용도)
- [ ] 지원 이메일(도메인 주소 → 메일 라우팅으로 슬림펌킨 업무 메일에 전달)을 사이트에 공개한다. 메일 주소·라우팅·DNS 설정은 사용자가 한다

**데이터 삭제**
- [ ] 데이터 삭제 안내에 앱을 다시 설치하지 않고 웹에서 계정·데이터 삭제를 요청하는 경로(지원 이메일)를 넣는다 (Google Play 계정 삭제 정책)
- [ ] 데이터 삭제 안내가 Facebook 로그인의 데이터 삭제 안내 URL(Data Deletion Instructions) 요건도 충족한다

**법적 본문**
- [ ] 개인정보처리방침을 앱의 실제 동작 기준으로 다시 쓴다. 넣을 것: 소셜 6곳에서 받는 항목, 기록 중 GPS 궤적(백그라운드 포함), Firebase 서비스(Auth·Firestore·Storage·Functions·Analytics·Crashlytics·FCM·App Check·Remote Config), 네이버 지도·검색 API, 자체 경로 라우터, 처리 위탁·국외 이전 여부, 개인정보 보호책임자와 연락처
- [ ] 이용약관을 앱의 실제 동작과 사업자 정보 기준으로 다시 쓴다
- [ ] 「위치기반서비스 이용약관」 페이지를 게시한다 (위치정보법 제12조①). 신고·등록 대상 여부는 법률 확인으로 범위를 조정한다
- [ ] 사이트·법적 문서에서 출시 시점 앱에 없는 기능(포인트·굿즈·배송지·코스북)을 제거한다
- [ ] 처리방침·약관·삭제 안내·지원 페이지의 영문판을 제공한다

**사업자 표시·도메인**
- [ ] 모든 페이지 푸터에 사업자 정보(상호·대표자·사업자등록번호·주소·지원 이메일)를 표시한다. 값은 사용자가 준다
- [ ] Google Search Console에서 `runningpencil.com` 도메인 소유권을 확인받는다 (Google OAuth 브랜드 검증 전제)

**사이트 정비**
- [ ] 법적 페이지의 Tailwind Play CDN 런타임을 걷어 내고 정적 CSS로 바꾼다
- [ ] 여러 페이지에 복사된 공통 블록(head 링크·「공통」 CSS·헤더·푸터)을 한 곳에서 관리한다
- [ ] 바뀐 방침(연락처 공개·사업자 정보·영문판·빌드 방식)을 `CLAUDE.md`에 반영한다

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

- **현재 사이트**: 빌드 없는 정적 HTML 4페이지(`index.html`, `privacy-policy/`, `terms/`, `data-deletion/`). 공통 블록은 네 파일에 복사해 두었습니다. 랜딩은 순수 CSS와 인라인 JS, 법적 페이지는 Tailwind Play CDN을 씁니다. 상세는 `.planning/codebase/`(ARCHITECTURE·STACK·CONCERNS 등) 참고.
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
| 전용 지원 이메일 공개 — 기존 「연락처 미표시」 방침을 뒤집음 | Google Play 웹 삭제 요청, App Store 1.5, 처리방침의 보호책임자 연락처에 연락 수단이 필요함 | — Pending |
| 지원 메일은 Google Workspace 사용자 별칭 도메인으로 받고 지원 주소에서 답장 (U12 결정, 2026-11-14) | 슬림펌킨 업무 메일이 Google Workspace라 제3자 전달 서비스 없이 `runningpencil.com` 주소를 받고 그 주소로 답장할 수 있음. 답장 도메인에 DKIM을 걸어 Phase 10의 Apple 릴레이 답장에 씀 | — Pending |
| 푸터에 사업자 정보 전부 표시 | 카카오 비즈앱 심사의 사업자-서비스 관계 확인, 국내 서비스 관행 | — Pending |
| 한국어 + 영어 제공 — 기존 `ko` 전용 방침을 뒤집음 | Google·Facebook·Apple·LINE 심사자가 읽을 수 있어야 함 | — Pending |
| 영문 서비스명은 `RunningPencil` — 기존 「RunningPencil 쓰지 않음」 방침을 뒤집음 | 영문판과 Google·Meta·LINE·스토어 콘솔에서 같은 이름을 써야 함 (요구사항 단계에서 결정) | — Pending |
| 출시 시점 앱에 없는 포인트·굿즈·배송지·코스북을 사이트·법적 문서·`CLAUDE.md`에서 제거 | 앱 REQUIREMENTS는 포인트 리워드를 Out of Scope, 코스북을 나중 단계로 둠. 심사는 사이트와 앱이 일치하는지 봄 (U10) | — Pending |
| 전화번호는 이번에 공개하지 않고 칸만 마련 | App Store Support URL 원문과 PIPA·위치정보법이 「전화번호 등 연락처」를 예로 듦. 법률 확인이나 심사에서 요구하면 값만 넣어 바로 표시 (U1) | — Pending |
| 법적 페이지 `noindex` 해제, 「임시 게시본」 문구 삭제 | Apple 2.1(a)·네이버 4.1이 미완성 사이트로 반려할 소지 | — Pending |
| `/support/` 지원 페이지 신설 | App Store Support URL용 전용 페이지가 심사자에게 가장 분명함 | — Pending |
| 법적 본문은 앱 실제 동작 기준 초안, 법률 검토는 출시 전에 따로 | 현재 임시 게시본은 앱 실제 범위와 맞지 않음 | — Pending |
| 위치기반서비스 이용약관 페이지를 기본으로 포함, 범위만 법률 확인으로 조정. 경로는 `/location-terms/`로 확정 (D-15) | 조사 결과 위치정보법 제12조①이 이용약관 공개 의무를 둠. 신고(제9조)인지 등록(제5조)인지는 법률 확인 필요 (U2) | — Pending |
| Tailwind Play CDN 제거와 공통 블록 단일화 — 「빌드 없음」 방침이 바뀔 수 있음 | 심사 대상 페이지의 안정성, 페이지가 늘수록(영문판·지원) 복사 드리프트 위험이 커짐. 방식(Jekyll include 등)은 단계에서 결정 | — Pending |
| 완료 = 6개 제공자 프로덕션 심사 통과를 사용자가 확인. 스토어는 웹사이트 요건까지 | 심사 통과는 외부 이벤트라 단계별 성공 기준에서 빼고 인수 항목으로 둠 | — Pending |

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
*Last updated: 2026-11-14 after Phase 1 decisions (U12 Workspace, /location-terms/)*
