# Feature Research

**Domain:** 한국 모바일 앱(러닝펜슬, 운영사 슬림펌킨)의 공식 웹사이트 — 소셜 로그인 6곳·스토어 2곳의 심사와 한국 법령이 웹사이트에 요구하는 항목
**Researched:** 2026-11-14
**Confidence:** MEDIUM (제공자·스토어 요건은 공식 문서 원문으로 확인함. 법령 조문은 국가법령정보센터 현행본으로 확인함. 다만 법령을 이 서비스에 어떻게 적용하는지는 해석의 영역이라 법률 확인이 필요함)

---

## 0. 읽는 법

**출처 등급** (표마다 `출처` 열에 적음)

| 표기 | 뜻 |
|---|---|
| **[공식]** | 제공자·스토어의 공식 문서를 이번 조사에서 직접 열어 확인함 |
| **[법령]** | 국가법령정보센터(law.go.kr) 현행 조문을 직접 열어 확인함 |
| **[공식-포럼]** | 제공자가 운영하는 개발자 포럼의 운영자 FAQ (예: 카카오 데브톡 FAQ) |
| **[2차]** | 개발자 포럼 사례 글이나 언론 보도. 경향은 보여 주지만 공식 기준은 아님 |
| **[미확인]** | 근거를 찾지 못했거나, 앱 코드의 임시 문구 같은 간접 근거만 있음 |

**seam confidence tier**: GSD `classify-confidence`로 받은 등급은 `webfetch` = LOW, 교차 확인한 `websearch` = MEDIUM입니다. 공식 문서를 직접 열었더라도 이 등급을 임의로 올리지 않았습니다. 그래서 문서 전체의 신뢰도는 출처 등급과 seam 등급을 함께 보고 MEDIUM으로 잡았습니다.

**REQ-ID 접두어 제안**: `SITE`(홈페이지·도메인) · `PRIV`(처리방침) · `DEL`(데이터 삭제) · `SUP`(지원·연락) · `BIZ`(사업자 표시) · `LOC`(위치정보) · `TERM`(이용약관) · `I18N`(영문판) · `SUBMIT`(콘솔 제출 체크리스트)

**복잡도**: LOW = 문구·링크 수정 수준 · MEDIUM = 새 페이지나 앱 데이터 흐름 확인이 필요 · HIGH = 외부 결정(법률·사용자 정보)에 막히거나 여러 페이지에 걸침

---

## 1. 핵심 결론

1. **모든 제공자·스토어가 공통으로 보는 것은 다섯 가지뿐입니다.** ① 앱을 설명하는 홈페이지(로그인 페이지만 있으면 안 됨) ② 같은 도메인에서 공개 URL로 열리는 개인정보처리방침 ③ 앱 없이 웹에서 시작할 수 있는 데이터 삭제 경로 ④ 실제로 연락되는 연락처 ⑤ 처리방침에 적은 내용과 앱의 실제 동작이 일치할 것. 나머지는 대부분 콘솔에 입력하는 값입니다.
2. **현재 사이트의 가장 큰 위험은 "사이트 내용과 앱이 다르다"는 점입니다 (제거 여부는 §11 U10 사용자 결정).** 랜딩 메타 설명, 처리방침, 이용약관, 삭제 안내에 **포인트·굿즈 교환·배송지**가 있습니다. 하지만 앱 저장소의 REQUIREMENTS.md는 "현금·포인트 리워드"를 Out of Scope로 둡니다. Google 검증("홈페이지가 앱을 정확히 나타내야 함"), 카카오 동의항목 심사("처리방침과 신청 항목 일치"), 네이버 사전 검수("제공 정보 활용처 확인")가 모두 이 불일치를 문제 삼을 수 있습니다.
3. **위치정보법은 이용약관 공개 의무를 지우고, 웹사이트가 가장 자연스러운 공개 수단입니다 [법령].** 위치기반서비스사업자는 「이용약관」을 "인터넷 홈페이지에 게시하는 등"의 방법으로 공개해야 합니다(위치정보법 제12조①). 시행령 제13조 2호는 **인터넷 홈페이지 또는** 앱의 첫 화면이나 첫 화면과 연결된 화면을 허용하므로 홈페이지 게시가 유일한 방법은 아닙니다. 다만 앱 안 공개와 함께 홈페이지에도 두는 것을 권장합니다. 공개할 때는 글자 크기·색상 등으로 쉽게 확인할 수 있게 표시해야 합니다(시행령 제13조). 약관에는 상호·주소·**전화번호** 등 연락처를 적어야 합니다(제19조①1). 신고 의무는 소상공인·1인 창조기업이면 사업 개시 후 1개월까지 유예됩니다(제9조의2). 따라서 출시 전 사이트에 「위치기반서비스 이용약관」 페이지를 미리 두는 편이 맞습니다. 다만 이 앱이 '위치정보사업(제5조, 법인 등록)'인지 '위치기반서비스사업(제9조, 신고)'인지는 법률 확인이 필요합니다.
4. **App Store Support URL은 연락처를 요구합니다 [공식].** App Store Connect 도움말 원문은 "This URL must lead to actual contact information (legal address, email address, telephone number), as may be required by local law"입니다. 개인정보 보호법 제30조①6(보호책임자 "전화번호 등 연락처")과 위치정보법 제19조①1("전화번호 그 밖의 연락처")도 전화번호를 예로 듭니다. 지금 계획은 "이메일만 공개"이므로 **전화번호 공개 여부는 사용자·법률 결정 항목**입니다.
5. **PROJECT.md의 가정 중 몇 가지는 공식 문서와 다릅니다** (§2). 특히 Facebook 기본 권한(email, public_profile)은 App Review가 필요 없습니다. Google 브랜드 검증은 non-sensitive scope만 쓰면 선택 사항이며, 동의 화면에 앱 이름·로고를 띄우려면 필요합니다. 네이버 사전 검수 가이드는 처리방침을 요구 항목으로 적지 않습니다. LINE의 처리방침 URL은 인증 제공자(certified provider)일 때만 필수입니다.

---

## 2. PROJECT.md 가정 정정

로드맵이 잘못된 전제에 막히지 않도록, 이번에 공식 문서로 확인한 결과를 먼저 적습니다.

| PROJECT.md의 가정·표현 | 확인한 사실 | 출처 |
|---|---|---|
| 6개 제공자 모두 "프로덕션 심사"가 있다 | **Facebook**: email·public_profile은 "without submitting for review"로 요청할 수 있습니다. Live 모드 전환에는 Terms of Service URL·App Icon·Category·Contact Email이 필요합니다. 신규 consumer 앱은 두 권한이 Advanced Access로 "automatically approved"되지만 수동으로 전환해야 합니다. 같은 문서에 "Business Verification is required to get Advanced Access"라는 문장도 있어 **두 문장이 충돌합니다 → 콘솔에서 확인해야 함**. **LINE**: 조사한 문서에는 채널을 Developing에서 Published로 바꾸는 절차만 있고, 별도 심사가 있는지는 **문서에 나오지 않습니다**. 이메일 권한은 신청(약관 동의 + 스크린샷)이 필요합니다. | [공식] Meta Login overview · Basic settings · Access levels / LINE getting started |
| Google OAuth 브랜드 검증이 필수다 | non-sensitive scope(openid·email·profile)만 쓰면 앱 검증은 "not mandatory"입니다. 다만 동의 화면에 **앱 이름과 로고**를 띄우려면 브랜드 검증이 필요합니다. 검증하지 않으면 도메인만 보입니다. 홈페이지·처리방침·약관 링크는 "required for all external production apps"로 적혀 있습니다(이 구절은 2차 요약이라 콘솔에서 재확인 필요). | [공식] Google Cloud 13463073 · 15549049 |
| 네이버 검수는 처리방침 URL을 본다 | 네이버 공식 사전 검수 가이드의 항목은 ① 서비스 콘텐츠(서비스 URL 접속·콘텐츠 운영 여부) ② 로그인 적용 형태(**별도 비밀번호 요구 금지**) ③ 제공 정보 활용처 ④ 로고·앱 이름입니다. 처리방침은 항목에 없습니다. 다만 2.1의 "업종별 법적 요건 준수 여부"를 근거로 요청받을 수는 있습니다. | [공식] 네이버 사전 검수 가이드 |
| 카카오 비즈앱 심사가 사업자-서비스 관계를 본다 | 비즈앱 전환은 사업자등록번호 등록(또는 개인 개발자 본인인증)과 앱 아이콘이 요건입니다. **비즈니스 정보 심사**는 "입력된 사업자 정보가 실제 유효한지" 비교합니다. "회사 및 서비스를 확인할 수 있는 소개 페이지가 없거나 앱마켓 앱정보가 없을 경우 앱 권한 신청이 제한"됩니다. 사이트에 사업자 정보가 없어 반려됐다는 사례는 2차 출처에만 있습니다. | [공식] 카카오 앱 설정 문서 · [공식-포럼] 비즈니스 정보 심사 FAQ · [2차] 데브톡 151805·149204 |
| Apple은 Android·웹 흐름에 도메인 요건이 있을 수 있다 | 앱은 Android에서 Firebase Auth `signInWithProvider`로 Apple 로그인을 합니다(`auth_repository.dart`). 따라서 Services ID의 Return URL은 Firebase 핸들러 도메인이 되고, `runningpencil.com`은 필요하지 않을 가능성이 높습니다. 도메인 검증 파일이 아직 요구되는지는 공식 문서로 확정하지 못했습니다 → **[미확인]**. 대신 한국 개발자는 새 Services ID를 등록할 때 server-to-server notification endpoint가 필수입니다(앱·Functions 쪽 일). | [공식] Apple account deletion 안내 · 앱 코드 |
| 소셜 6곳 + 익명 로그인 | 앱 코드의 `AccountProvider`에 **Email/Password**가 있고 `createUserWithEmailAndPassword` 호출도 있습니다. 처리방침 수집 항목과 네이버 "별도 비밀번호 금지" 규칙에 영향이 있으므로 **UI에서 실제로 노출되는지 사용자 확인이 필요**합니다. | 앱 코드 `lib/core/auth/provider_id.dart`, `auth_repository.dart` |
| 삭제 안내: "30일 이내 모든 데이터 파기" | 탈퇴 요청 시 바로 삭제를 실행합니다. 지우는 것은 Storage `users/{uid}/`, Auth 계정, `users/{uid}`, `identity_index`, `fcmTokens`, 그리고 Auth 삭제 트리거로 `runs`(GPS 기록 전부)와 `badges`입니다. 다만 `fcmTokens` 삭제가 실패하면 30일 TTL로 정리하고, `runs`·`badges` 일부 실패는 로그로만 남기므로 **"30일 이내"라는 상한 표현은 유지해도 됩니다**("즉시"를 약속하지 말 것). 진짜 빈 곳은 **남는 데이터가 빠져 있다는 점(공개 코스는 작성자 식별자 `creatorId`만 남은 채 유지)** 과 **삭제 항목 목록이 틀렸다는 점(포인트·굿즈)** 입니다. 비공개 코스를 어떻게 처리하는지는 코드에서 확인하지 못함. | 앱 코드 `functions/src/auth/delete_user_account.ts`, `functions/src/running_pencil/cleanup_user_data.ts` |

---

## 3. Feature Landscape

### 3.1 Table Stakes (빠지면 심사 반려 또는 법령 위반)

#### A. 홈페이지·도메인 (`SITE`)

| ID 후보 | Feature | 왜 필요한가 (요건) | 복잡도 | 출처 |
|---|---|---|---|---|
| SITE-01 | 홈페이지가 앱 기능을 설명하고, 로그인 페이지만으로 이루어지지 않음 | Google: "accurately represent and identify your app or brand", "can not be only a login page". 네이버 4.1: 서비스 URL에서 콘텐츠를 확인할 수 없으면 서비스 소개 자료를 요청함. 카카오: 회사·서비스 소개 페이지가 없으면 권한 신청이 제한됨 | LOW (현재 랜딩이 충족) | [공식] Google 13464321 · 네이버 검수 가이드 · [공식-포럼] 카카오 FAQ |
| SITE-02 | **홈페이지 문구를 앱의 실제 범위에 맞춤** — 메타 설명과 OG의 "포인트·기념 굿즈", 그리고 아직 앱에 없는 "코스북" 표현 정리 (§11 U10 결정 후) | Google: 처리방침과 실제 사용이 일치해야 하고 홈페이지가 앱을 "accurately" 나타내야 함. 앱 REQUIREMENTS는 포인트 리워드를 Out of Scope로 둠 | LOW | [공식] Google 13464321 · 앱 `.planning/REQUIREMENTS.md` |
| SITE-03 | 홈페이지에서 처리방침으로 링크하고, 그 URL이 Google 동의 화면에 넣는 URL과 **같음** | Google: "must link to your privacy policy, and that link must match the one on the OAuth consent screen" | LOW (푸터 링크 있음) | [공식] Google 13464321 |
| SITE-04 | 처리방침·약관·삭제 안내·지원 페이지를 모두 `runningpencil.com` 한 도메인에 둠 | Google: 처리방침은 "hosted within the domain that hosts your homepage" | LOW | [공식] Google 13464321 |
| SITE-05 | Google Search Console에서 `runningpencil.com` 소유권 확인 | Google: Authorized domains의 모든 도메인을 Search Console로 확인해야 함. 홈페이지는 "verified domain you own"에 있어야 함 | LOW (사용자 작업, DNS TXT) | [공식] Google 13464321 · 15549049 |
| SITE-06 | 법적 페이지가 **공개·크롤러 접근 가능·지역 차단 없음·PDF 아님·편집 불가**인 HTML URL로 열림 | Meta: "active, publicly available, easily accessible (including by our crawlers), and non-geoblocked URL", "Broken privacy policy links are considered violations". Play: 공개·non-geofenced URL, PDF 불가, 편집 불가 | LOW (GitHub Pages 정적 HTML이라 충족. `robots.txt`로 막지 않으면 됨) | [공식] Meta Privacy Policy Expectations · Play 10144311 |
| SITE-07 | **법적 페이지 URL을 고정** (`/privacy-policy/`, `/terms/`, `/data-deletion/`, `/support/`, 위치약관 경로) | 제출한 URL이 깨지면 Meta는 위반으로 집행하고 Play는 "functional" 요건 위반. GitHub Pages는 서버 리다이렉트가 없음 | LOW | [공식] Meta · Play 13327111 |

#### B. 개인정보처리방침 내용 (`PRIV`)

법정 기재사항(개인정보 보호법 제30조①, 시행령 제31조①)과 제공자·스토어 요건을 한 표에 모았습니다. 「해당 시」는 법 조문의 "해당되는 경우에만 정한다"입니다.

| ID 후보 | 기재 항목 | 근거 | 복잡도 | 출처 |
|---|---|---|---|---|
| PRIV-01 | 처리 목적 | PIPA 제30조①1 · Apple 5.1.1(i) "all uses of that data" · Meta "clear purpose" | MEDIUM | [법령] · [공식] |
| PRIV-02 | **처리하는 개인정보 항목** — 로그인 제공자 6곳(+Email/Password·익명)별로 실제 받는 항목, 기록 중 GPS 궤적(화면이 꺼지거나 다른 앱으로 넘어가도 기록 중이면 수집), 코스·기록·뱃지, 프로필 사진(Storage), 푸시 토큰(FCM), 분석·크래시 정보 | 시행령 제31조①1 · Apple 5.1.1(i) "what data… how it collects" · Play "types of personal and sensitive user data" · 카카오 "신청한 모든 항목 명시" · Google "how your app accesses, uses, stores, and/or shares Google user data" | HIGH (앱 저장소에서 항목별로 확인해야 함) | [법령] · [공식] |
| PRIV-03 | 처리 및 보유 기간 | PIPA 제30조①2 · Play "data retention and deletion policy" · Apple 5.1.1(i) | MEDIUM | [법령] · [공식] |
| PRIV-04 | 파기 절차·방법, 그리고 법령상 보존하는 경우의 근거와 항목 | PIPA 제30조①3의2 | LOW | [법령] |
| PRIV-05 | 제3자 제공 (해당 시) | PIPA 제30조①3 · Play "parties with whom such data is shared" | MEDIUM | [법령] · [공식] |
| PRIV-06 | 처리 위탁: 수탁자와 위탁 업무 (해당 시) — Google(Firebase·GCP), 네이버클라우드(NCP 지오코딩·검색) 등 | PIPA 제30조①4 · Apple 5.1.1(i) "analytics tools… third-party SDKs… will provide the same or equal protection" 확인 문구 | MEDIUM | [법령] · [공식] |
| PRIV-07 | **국외 이전**: 이전 근거와 ① 항목 ② 국가·시기·방법 ③ 이전받는 자 명칭·연락처 ④ 이용 목적·보유 기간 ⑤ 거부 방법·절차·효과 | 시행령 제31조①2 → PIPA 제28조의8②. 계약 이행을 위한 위탁·보관이면 처리방침 공개로 별도 동의를 갈음할 수 있음(제28조의8①3가) | HIGH (Firebase Auth·Analytics·Crashlytics·FCM이 어느 나라에서 처리되는지 확인 필요) | [법령] |
| PRIV-08 | 안전성 확보 조치 | 시행령 제31조①3 · Play "secure data handling procedures" | LOW | [법령] · [공식] |
| PRIV-09 | 정보주체·법정대리인의 권리·의무와 행사 방법, **동의 철회와 삭제 요청 방법** (이메일 또는 폼) | PIPA 제30조①5 · Apple 5.1.1(i) "how a user can revoke consent and/or request deletion" · Meta "may be an email or a contact form, which should be up to date and valid" | LOW | [법령] · [공식] |
| PRIV-10 | **개인정보 보호책임자**의 성명(또는 담당 부서)과 전화번호 등 연락처. 소상공인이라 지정하지 않으면 대표자가 보호책임자임 | PIPA 제30조①6 · 제31조①② · 시행령 제32조①(소상공인이면 지정하지 않을 수 있음) · Play "privacy point of contact or a mechanism to submit inquiries" | MEDIUM (사용자 정보 필요) | [법령] · [공식] |
| PRIV-11 | 자동 수집 장치의 설치·운영과 거부 방법 (해당 시) — 앱의 Firebase Analytics 등 | PIPA 제30조①7 | LOW | [법령] |
| PRIV-12 | 처리방침 문서 제목에 "개인정보처리방침/Privacy Policy" 명시, 운영 주체(슬림펌킨)와 앱 이름 명시 | Play "clear labeling as a privacy policy", 스토어 등록 주체 이름이 처리방침에 나와야 함 · Meta "clearly marked", "your own privacy policy" | LOW (현재 충족, 주체명 유지) | [공식] |
| PRIV-13 | 홈페이지에 **지속적으로 게재** | 시행령 제31조② | LOW | [법령] |
| PRIV-14 | 앱의 실제 범위에 없는 항목(굿즈 배송지, 포인트) 제거 (U10 결정 전제) | 처리방침과 실제 처리가 달라서는 안 됨(Google). 카카오는 신청 항목 기준으로 일치 여부를 봄 | LOW | [공식] · [2차] 데브톡 151330 |
| PRIV-15 | 만 14세 미만 아동 정책 (가입 제한 또는 법정대리인 동의) | PIPA 제22조의2 · 위치정보법 제25조. 정책을 정해야 처리방침에 쓸 수 있음 | MEDIUM (사용자 결정) | [법령] |

#### C. 데이터 삭제 안내 (`DEL`)

| ID 후보 | Feature | 근거 | 복잡도 | 출처 |
|---|---|---|---|---|
| DEL-01 | **앱 없이 웹에서 삭제를 요청하는 경로**를 눈에 띄게 둠 (지원 이메일로 충분) | Play: "customer service email or a form… are acceptable", 재설치를 요구하지 말 것, "prominently featured" | LOW (이메일 확정 후) | [공식] Play 13327111 |
| DEL-02 | 스토어에 표시되는 **앱 이름 또는 개발자 이름**을 페이지에 적음 | Play: "reference the app or developer name as it appears on your Google Play store listing" | LOW | [공식] Play 13327111 |
| DEL-03 | **삭제되는 데이터와 남는 데이터·보존 기간**을 정확히 적음 — 공개 코스는 남고(작성자 식별자만 연결), 처리 기한은 "30일 이내" 같은 상한으로 표현 | Play: 보존 관행을 "clearly inform". Apple: "what information will and won't be retained", 소요 시간 안내 | MEDIUM (비공개 코스·Analytics·Crashlytics·백업 보존 확인) | [공식] Play · Apple account deletion |
| DEL-04 | 앱 안 삭제 경로를 **실제 메뉴 이름**으로 적음 (현재 "설정 → 계정 삭제"인데 앱 문자열은 「회원탈퇴」) | Apple 5.1.1(v): 앱 안에서 삭제를 시작할 수 있어야 함. 안내와 앱이 다르면 심사자가 경로를 못 찾음 | LOW | [공식] Apple · 앱 `app_ko.arb` `settingsWithdrawalLabel` |
| DEL-05 | 소요 시간과 완료 통지 방법 | Apple: "how long it will take… provide a confirmation". Play: "tell users what to expect" | LOW | [공식] |
| DEL-06 | Facebook **User Data Deletion** 필드에 넣을 수 있는 URL (Instructions URL 방식) | Meta Basic settings: "links to explicit instructions… This URL may be the relevant section in the application's Privacy Policy". Callback 방식과 Instructions URL 방식 중 하나면 됨 | LOW | [공식] Meta Basic settings · Data deletion callback |
| DEL-07 | 위치정보 동의 철회 시 개인위치정보와 확인자료를 파기한다는 안내 | 위치정보법 제24조④ · 제23조 | LOW | [법령] |

#### D. 지원·연락 (`SUP`)

| ID 후보 | Feature | 근거 | 복잡도 | 출처 |
|---|---|---|---|---|
| SUP-01 | `/support/` 페이지 — App Store **Support URL**용. 맨 위에 앱 이름, 그리고 실제 연락처 | ASC: Support URL은 "Required", "must lead to actual contact information (legal address, email address, telephone number), as may be required by local law". Apple 1.5: "easy way to contact you" | MEDIUM | [공식] ASC Platform version information · App Review Guidelines 1.5 |
| SUP-02 | 지원 이메일 공개 (도메인 주소 → 메일 라우팅) | Play 삭제 요청 경로, Meta 삭제 요청 연락처("email address for those requests"), PIPA 보호책임자 연락처, Apple 1.2 UGC "Published contact information" (공개 코스가 UGC) | LOW (사용자가 DNS·라우팅 설정) | [공식] Play · Meta Login overview · Apple 1.2 · [법령] |
| SUP-03 | 공개 코스 신고 방법 안내 (지원 이메일로 신고 가능) | Apple 1.2: UGC 앱은 "mechanism to report offensive content and timely responses"와 공개 연락처가 필요함. 앱 쪽 신고 기능은 앱 P2-09로 미뤄져 있어 웹 연락처가 최소 보완책임 | LOW | [공식] Apple 1.2 |

#### E. 사업자 표시 (`BIZ`)

| ID 후보 | Feature | 근거 | 복잡도 | 출처 |
|---|---|---|---|---|
| BIZ-01 | 사업자 정보(상호·대표자·사업자등록번호·주소·연락처)를 **최소 한 곳** 이상에 표시. 푸터를 권장함 | **법적 의무 여부**: 전자상거래법 제10조의 표시 의무는 "전자상거래를 하는 사이버몰의 운영자"에게 있습니다. 판매가 없는 티저 사이트·무료 앱은 해당하지 않는 것으로 보입니다(법률 확인 필요). **심사 관행**: 카카오 심사팀이 사이트에서 사업자 정보를 확인하지 못해 반려하고 약관·처리방침·푸터 중 한 곳 이상에 표기하도록 안내한 사례가 있습니다. **다른 법령 경로**: 위치정보법 제19조①1은 약관에 상호·주소·전화번호를 요구하고, Apple Support URL은 legal address를 예로 듭니다 | MEDIUM (값은 사용자가 줌) | [법령] 전자상거래법 제10조 · 위치정보법 제19조 · [2차] 데브톡 151805·149204 · [공식] ASC |
| BIZ-02 | 콘솔에 입력하는 회사명·앱 이름과 사이트의 표기를 일치시킴 (카카오 "회사명", Play 개발자 이름, Meta·Google 앱 이름) | 카카오: 기본 정보는 "실제 서비스와 동일하게 입력". Play: 스토어 등록 주체가 처리방침에 나와야 함 | LOW | [공식] 카카오 앱 설정 · Play 10144311 |

#### F. 위치정보 (`LOC`) — 법률 확인을 전제로 함

| ID 후보 | Feature | 근거 | 복잡도 | 출처 |
|---|---|---|---|---|
| LOC-01 | 「위치기반서비스 이용약관」 페이지를 홈페이지에 게시하고, 푸터에서 눈에 띄게 링크 (권장 공개 수단) | 위치정보법 제12조①: 위치기반서비스사업자(제9조 신고자 **및 제9조의2로 신고 없이 사업하는 소상공인등 포함**)는 이용약관을 "인터넷 홈페이지에 게시하는 등"의 방법으로 공개해야 함. 시행령 제13조 2호: 인터넷 홈페이지 **또는** 앱 첫 화면·연결 화면으로 공개할 수 있음. 공개할 때는 "글자 크기, 색상 등을 활용하여 이용약관을 쉽게 확인할 수 있도록 표시". 앱 안 공개만으로도 법 문언은 충족할 수 있지만, 심사자·이용자가 앱 없이 볼 수 있도록 홈페이지 게시를 권장 | MEDIUM | [법령] |
| LOC-02 | 약관 필수 명시 사항(제19조①): ① 사업자 상호·주소·전화번호 등 연락처 ② 개인위치정보주체·법정대리인의 권리와 행사 방법 ③ 위치기반서비스 내용 ④ 위치정보 이용·제공사실 확인자료의 보유 근거·기간 ④의2 개인위치정보의 보유 목적·기간 ⑤ 시행령 사항 | 위치정보법 제19조① | MEDIUM | [법령] |
| LOC-03 | 이용자 권리 안내: 동의 전부·일부 철회, 수집·이용 **일시 중지 요구**, 확인자료 열람·고지·정정 요구 | 위치정보법 제24조①~③ | LOW | [법령] |
| LOC-04 | 약관 변경 시 변경 이유와 내용을 지체 없이 공개 (변경 이력 섹션) | 위치정보법 제12조① 후단 | LOW | [법령] |
| LOC-05 | (분기) 앱이 '개인위치정보 대상 위치정보사업자'(제5조 **등록**, **법인 요건**)로 분류되면 제18조① 항목(수집사실 확인자료 보유 근거·기간 등)이 추가됨 | 위치정보법 제5조·제18조. 기기 GPS를 직접 받는 앱이 어느 쪽인지 조문만으로는 정해지지 않음 | HIGH (법률 판단) | [법령] · 분류는 **[미확인]** |

#### G. 이용약관 (`TERM`)

| ID 후보 | Feature | 근거 | 복잡도 | 출처 |
|---|---|---|---|---|
| TERM-01 | 이용약관 URL 제공 | Meta: Terms of Service URL은 "required to switch your app to Live mode". Google: 브랜딩 페이지의 약관 링크(외부 프로덕션 앱). LINE·카카오·네이버·Apple·Play는 필수 아님 | LOW (있음) | [공식] Meta Basic settings · Google 15549049 |
| TERM-02 | 앱의 실제 범위로 다시 씀: 포인트·굿즈 조항(제8조)과 정의 삭제, 코스 공개·공개 후 수정 불가·탈퇴 후 공개 코스가 남는다는 점, 사용자 콘텐츠 신고 | 처리방침·삭제 안내와 내용이 맞아야 함. 공개 코스 유지는 앱 결정 D-28 | MEDIUM | 앱 코드 · 앱 `app_ko.arb` 임시 약관 |
| TERM-03 | 지도·경로 데이터 출처와 제3자 지도 SDK 이용 고지 (OSM ODbL, 네이버 지도 SDK) | OSM 출처 표기는 이미 푸터에 있음. "네이버 지도 SDK 이용 정보가 네이버클라우드에 제공(네이버 지도 이용약관 §7⑤)"이라는 문구는 앱 임시 문자열에만 있음 → 네이버 지도 이용약관 원문 확인 필요 | LOW | 앱 `app_ko.arb` · **[미확인]** |

### 3.2 Differentiators (필수는 아니지만 심사 왕복을 줄임)

| ID 후보 | Feature | 효과 | 복잡도 | 출처·근거 |
|---|---|---|---|---|
| I18N-01 | 처리방침·약관·삭제 안내·지원 페이지의 **영문판** (`/en/...`, `hreflang`, "한국어본이 우선한다" 조항) | Google·Meta·LINE 심사자가 직접 읽을 수 있음. 공식 문서에서 영어를 요구하는 문장은 **찾지 못함** → 필수가 아니라 권장. ASC의 Support/Marketing URL은 지역별로 넣을 수 있음("can be localized") | MEDIUM (본문 확정 후 번역) | [공식] ASC (localizable) · 영어 요구 문장은 **[미확인]** |
| DEL-08 | 삭제 안내에 **제공자별 앵커 섹션** (`#facebook`, `#apple`, `#google` …): 예) "Facebook 설정에서 앱을 제거해도 러닝펜슬 데이터는 지워지지 않으니 앱의 회원탈퇴나 지원 이메일을 이용하세요" | Meta는 사용자가 Facebook 설정에서 앱을 제거한 뒤 이 URL로 들어오는 흐름을 전제함. 콘솔마다 정확한 앵커를 넣으면 심사자가 바로 확인함 | LOW | [공식] Meta Basic settings |
| PRIV-16 | 소셜 제공자별 **수신 항목 표** (제공자 · 받는 항목 · 필수/선택 · 용도) | 카카오(필수/선택 일치 확인), 네이버(활용처 확인), Google(Google user data 사용 공개)을 한 표로 해결 | MEDIUM | [공식] 카카오 prerequisite · 네이버 2.3 · Google 13464321 |
| PRIV-17 | 처리방침 **시행일과 이전 버전 보관** (`/privacy-policy/2026-11-xx/`) | 변경 이력을 남기면 심사·민원 대응이 쉬움. 2026.4 개정 작성지침도 변경 안내 방식을 다룸(보도 기준) | LOW | [2차] 뉴시스 2026-04-24 |
| SUP-04 | 지원 페이지에 짧은 FAQ: "누가 운영하나요(슬림펌킨)", "위치는 언제 수집하나요(기록 중만, 화면 꺼져도 기록 중이면)", "계정을 지우려면", "공개 코스 신고" | 심사자가 묻는 질문을 미리 답함. Apple 1.5의 "easy way to contact you" | LOW | [공식] Apple 1.5 |
| SITE-08 | 랜딩에 **실제 앱 화면**(스크린샷)과 "출시 예정" 표시 | 네이버 4.1: 출시 전이거나 콘텐츠가 완전하지 않으면 서비스 소개 자료를 요청함. 카카오: 앱마켓 정보가 없으면 소개 페이지로 확인함 | MEDIUM (디자인 범위와 충돌 가능) | [공식] 네이버 4.1 · [공식-포럼] 카카오 FAQ |
| SITE-09 | 법적 페이지의 `noindex` 해제와 "임시 게시본" 문구 삭제 | 심사자·크롤러에게 확정본으로 보임. `noindex`는 크롤링을 막지 않아 필수는 아님 | LOW | 판단 근거: Meta 크롤러 요건 |
| SUP-05 | 지원 메일 도메인의 **SPF/DKIM** 설정과 Apple Private Email Relay에 발신 도메인 등록 | Apple로 로그인한 사용자는 `privaterelay` 주소를 쓸 수 있음. 발신 도메인을 등록하지 않으면 그 주소로 보낸 답장이 반송됨(Apple: SPF 필수, 미등록 시 bounce) | LOW (사용자 DNS 작업) | [공식] Apple Account Help (검색 결과로 확인) |
| SUBMIT-01 | 제공자·스토어별 **콘솔 입력값 체크리스트 문서** (URL·앱 이름·로고·설명 문구·담당 이메일) | 한 곳에서 값을 맞추면 이름·URL 불일치 반려를 막음 | LOW | §4 |

### 3.3 Anti-Features (일부러 만들지 않을 것)

| Anti-Feature | 왜 하고 싶어지나 | 왜 문제인가 | 대신 할 것 |
|---|---|---|---|
| 웹 로그인 폼, 또는 로그인만 있는 홈페이지 | "소셜 로그인 심사니까 웹에도 로그인을" | Google: 홈페이지가 "only a login page"이면 안 됨. 웹 로그인은 이번 범위 밖으로 결정됨 | 앱 설명 랜딩 유지 |
| 처리방침을 PDF·이미지·Notion·Google Docs 링크로 제공 | 작성이 빠름 | Play: PDF 불가, 편집 불가. Google: 홈페이지와 같은 도메인이어야 함 | 같은 도메인의 정적 HTML |
| `robots.txt` Disallow, 지역 차단, 로그인 벽 | 초안을 숨기고 싶음 | Meta 크롤러 접근 불가 = 깨진 링크 = 집행 대상 | 공개하되 확정본만 게시 |
| "임시 게시본이며 갱신될 수 있습니다", "(연락처 — 배포 전 기입)" 같은 자리 표시 문구 | 법률 검토 전이라 | 심사자가 미완성으로 판단함. 처리방침은 "up to date and valid"여야 함(Meta) | 시행일을 적은 확정본 + 변경 이력 |
| 카카오·네이버·Google 같은 **로그인 제공자를 수탁자로 기재** | 데이터를 주고받으니 위탁처럼 보임 | 카카오 동의항목 심사에서 반려 사유가 된 사례가 있음(카카오 로그인만 쓰면 위수탁 관계가 아님) | "수집 출처(제공받는 경로)"로 기재 |
| "~를 수집할 수 있습니다"처럼 넓게 쓰는 항목 나열 | 나중에 기능이 늘어도 고치지 않으려고 | 카카오는 신청 항목·필수/선택이 처리방침과 일치하는지 보고, 네이버는 쓰지 않는 항목을 반려함 | 실제 요청하는 scope만, 필수/선택 구분해서 |
| 데이터 삭제를 **이메일로만** 받는 것 (앱 안 탈퇴를 대신하게 함) | 구현이 쉬움 | Apple: 규제 산업이 아니면 삭제에 이메일·전화를 요구하면 안 됨. 웹 이메일 경로는 Play용 **보조 경로**일 뿐임 | 앱 안 「회원탈퇴」 + 웹 이메일 요청 병행 |
| 외부 폼 서비스(Google Forms, Typeform)로 삭제 요청 받기 | 정적 사이트에서도 폼이 생김 | 개인정보가 제3자에게 가서 위탁·국외 이전 기재가 늘어남. 이메일로도 Play 요건 충족 | 지원 이메일 + 본인 확인 정보 안내 |
| 언어별로 내용이 다른 처리방침, 제공자마다 다른 URL | 콘솔마다 따로 쓰다 보면 생김 | Google: 홈페이지와 동의 화면 링크가 같아야 함. 내용이 갈리면 불일치 반려 | 언어별 정본 1개씩, 영문은 번역본 + 국문 우선 조항 |
| 굿즈·포인트·출시 일정 같은 **약속 문구** | 티저 마케팅 | 앱 범위와 다르고, 판매를 암시하면 전자상거래법 표시·통신판매업 논점이 생김 | 앱에 있는 기능만 소개 |
| 주민등록번호나 개인 휴대전화 같은 과도한 신원 정보 표시 | "사업자 정보 전부 표시" | 법령 요구 범위를 넘고 대표 개인정보가 노출됨 | 상호·대표자·사업자등록번호·사업장 주소·업무용 연락처만 |
| 법적 페이지 경로 변경·이름 바꾸기 | 사이트 구조 정리 | GitHub Pages는 서버 리다이렉트가 없음. 이미 제출한 URL이 깨짐 | 경로 고정. 바꿔야 하면 옛 경로에 meta refresh |

---

## 4. 제공자·스토어별 체크리스트 (SUBMIT 그룹의 원본)

표기: **필수**(빠지면 반려·Live 불가) · **조건부** · **권장**. "웹" 열은 이 저장소가 만드는 산출물이고, "콘솔" 열은 사용자가 입력하는 값입니다.

### 4.1 카카오 (비즈 앱 전환 → 비즈니스 정보 심사 → 개인정보 동의항목 심사)

| 등급 | 항목 | 웹 | 콘솔 | 출처 |
|---|---|---|---|---|
| 필수 | 비즈 앱 전환: 사업자등록번호 등록(또는 개인 개발자 본인인증 + 카카오비즈니스 통합 서비스 약관 동의), 앱 아이콘 등록, 오너만 가능 | — | 비즈니스 정보 | [공식] 앱 설정 |
| 필수 | 앱 이름·회사명·카테고리를 "실제 서비스와 동일하게" 입력 | 사이트 표기와 일치(BIZ-02) | 기본 정보 | [공식] 앱 설정 |
| 필수 | 비즈니스 정보 심사: 사업자등록증 사본(개인정보 가림). 회사·서비스 소개 페이지 또는 앱마켓 앱정보가 있어야 함 | 홈페이지(SITE-01), 사업자 표시(BIZ-01) | 심사 신청 | [공식-포럼] FAQ 132272 |
| 필수 | 동의항목 심사 자료: ① 가입 링크 또는 App Store URL(출시 전이면 기획서·디자인 시안으로 대체) ② **수집 목적과 신청한 모든 항목을 적은 처리방침 URL** ③ 가입→로그인→탈퇴 전체 동선 캡처(개인정보 없이, 20MB 이하 파일 1개) | 처리방침(PRIV-02, PRIV-16) | 심사 신청 | [공식] 카카오 로그인 설정하기 |
| 필수 | 동의 화면의 필수/선택 설정 = 처리방침의 필수/선택 = 가입 화면 | 처리방침 표 | 동의항목 | [공식] · [2차] 데브톡 151330 |
| 조건부 | **개인정보 국외 이전 정보** 입력(이전 국가, 법인명, 연락처). 입력하면 동의 화면에 필수 "[개인정보 국외 이전 동의]"가 추가됨 → 처리방침 국외 이전 섹션과 같은 값이어야 함 | PRIV-07 | 동의항목 | [공식] 카카오 로그인 설정하기 |
| 권장 | 카카오를 수탁자로 쓰지 않음 | PRIV-06 | — | [2차] 데브톡 148755 |
| 참고 | 심사 기간은 영업일 3~5일 | — | — | [공식] |
| 참고 | 앱 대표 도메인·Web 플랫폼 사이트 도메인은 JS SDK·웹 로그인용. 앱은 네이티브 SDK를 쓰므로 필수는 아닐 가능성이 높음 | — | 플랫폼 | [공식] 앱 설정 (해석) |

### 4.2 네이버 (네이버 로그인 사전 검수)

| 등급 | 항목 | 웹 | 콘솔 | 출처 |
|---|---|---|---|---|
| 필수 | 2.1 서비스 콘텐츠: 등록한 **서비스 URL에 접속할 수 있고 콘텐츠가 운영 중**일 것. 아니면 서비스 소개 자료(양식 자유)를 첨부 | 홈페이지(SITE-01, SITE-08) | 서비스 URL = `https://runningpencil.com` | [공식] 검수 가이드 2.1·4.1 |
| 필수 | 2.2 적용 형태: 네이버 로그인으로 가입할 때 **서비스 고유 비밀번호를 요구하지 않음**. 로그인 버튼부터 가입 완료까지 전 과정 캡처(또는 화면 기획서) | — (앱) | 검수 상태 탭 첨부 | [공식] 2.2·3.2 |
| 필수 | 2.3 제공 정보 활용처: 이용자 식별자 외 항목(이메일·이름 등)을 고르면 그 항목이 쓰이는 화면을 캡처. **통계 목적은 인정되지 않음** | 처리방침 항목이 실제 요청 항목과 일치 | API 설정 | [공식] 2.3 |
| 필수 | 2.4 로고·앱 이름: 서비스 브랜드를 대표할 것. 네이버를 연상시키거나 '로그인' 같은 이름이면 반려 | 사이트 브랜드와 일치 | API 설정 | [공식] 2.4 |
| 주의 | 4.3: **같은 서비스 URL로 이미 승인된 앱이 있으면** 새 앱 대신 그 앱을 쓰라고 안내함 → dev·stg·prod 앱의 서비스 URL 등록 방식을 미리 정할 것 | — | 앱별 서비스 URL | [공식] 4.3 |
| 참고 | 결과는 영업일 2~3일 안에 이메일로 옴 | — | — | [공식] |
| 권장 | 처리방침 URL을 준비해 둠 (가이드에는 없지만 2.1 "업종별 법적 요건"으로 요청받을 수 있음) | PRIV 전체 | — | 해석 |

### 4.3 Google (OAuth 동의 화면 / Branding)

| 등급 | 항목 | 웹 | 콘솔 | 출처 |
|---|---|---|---|---|
| 필수 | Authorized domains의 모든 도메인을 Search Console로 소유권 확인 | — | Search Console (SITE-05) | [공식] 13464321 |
| 필수 | Application home page: 확인된 도메인 위, 앱 설명, 로그인 페이지만이면 안 됨, 처리방침 링크(동의 화면과 같은 URL) | SITE-01·03 | Branding | [공식] 13464321 · 15549049 |
| 필수 | Privacy policy: 홈페이지와 같은 도메인, 홈페이지에서 링크, **Google user data의 접근·사용·저장·공유 방식** 공개, 실제 관행과 일치 | PRIV-02·16 | Branding | [공식] 13464321 |
| 필수(외부 프로덕션 앱) | Terms of service 링크 | TERM-01 | Branding | [공식] 15549049 (2차 요약, 재확인) |
| 조건부 | **브랜드 검증**: 동의 화면에 앱 이름·로고를 띄우려면 필요. non-sensitive scope만 쓰면 앱 검증 자체는 선택 | — | Verification Center | [공식] 13463073 |
| 필수 | App name은 Google 제품명과 헷갈리지 않을 것. 로고는 앱을 나타낼 것(1MB 이하, 120×120 권장). User support email은 실제로 확인하는 주소(본인 Google 계정이나 관리하는 Google 그룹) | 사이트 브랜드와 일치 | Branding | [공식] 15549049 |
| 필수 | 프로젝트 연락처(Developer contact)를 최신으로 유지. 알림에 대응하지 않으면 API 접근을 잃을 수 있음 | — | Branding | [공식] 13464321 |

### 4.4 Apple (Sign in with Apple + App Store)

| 등급 | 항목 | 웹 | 콘솔 | 출처 |
|---|---|---|---|---|
| 필수 | **Privacy Policy URL** (iOS 앱 필수) + 앱 안 링크 | PRIV 전체 | App Store Connect App Information | [공식] ASC App information · 5.1.1(i) |
| 필수 | 5.1.1(i) 처리방침 내용: 수집 데이터·수집 방법·모든 용도 / 데이터를 공유받는 제3자(분석 도구·SDK 포함)가 **같은 수준으로 보호한다는 확인** / 보존·삭제 정책 / 동의 철회와 삭제 요청 방법 | PRIV-01·02·06·09 | — | [공식] Guidelines 5.1.1(i) |
| 필수 | **Support URL** (필수, 지역별 설정 가능): 실제 연락처로 이어질 것 — 원문 "legal address, email address, telephone number" 예시 + "as may be required by local law" | SUP-01 | Platform version information | [공식] ASC · Guidelines 1.5 |
| 권장 | Marketing URL (선택) = `https://runningpencil.com/` | 랜딩 | Platform version information | [공식] ASC |
| 필수 | 5.1.1(v) 계정 삭제는 **앱 안에서 시작**. 웹사이트 링크는 웹에서 마무리해야 할 때만, 그 페이지로 바로 가는 링크로. 소요 시간·남는 정보 안내 | DEL-03·05 (보조) | — (앱) | [공식] Offering account deletion |
| 필수 | 1.2 UGC(공개 코스): 신고 수단, 차단, **공개 연락처** | SUP-02·03 | — (앱 + 웹) | [공식] Guidelines 1.2 |
| 조건부 | Private Email Relay: 앱이나 지원 메일이 relay 주소로 메일을 보내면 발신 도메인·주소를 Email Sources에 등록하고 SPF 설정 | SUP-05 | Certificates, Identifiers & Profiles | [공식] Account Help |
| 조건부 | Services ID 도메인·Return URL: Firebase 핸들러를 쓰면 `runningpencil.com`은 필요 없을 가능성이 높음. 만약 이 도메인을 등록하고 검증 파일이 필요해지면, 파일은 `/.well-known/` 아래에 둬야 하고 Jekyll은 점(.)으로 시작하는 폴더를 기본으로 빼므로 `_config.yml`에 `include`가 필요함 | 조건부 | Services ID | Apple 문서 [공식] · 검증 파일 요건 **[미확인]** · Jekyll 동작은 일반 지식 |
| 필수(앱) | 한국 개발자: 새 Services ID 등록 시 server-to-server notification endpoint 제공. Sign in with Apple 토큰은 REST API로 revoke | — (Functions) | Services ID | [공식] Offering account deletion |

### 4.5 Facebook (Meta) — Facebook Login, Live 모드

| 등급 | 항목 | 웹 | 콘솔 | 출처 |
|---|---|---|---|---|
| 필수 | **Privacy Policy URL**: 공개·크롤러 접근 가능·지역 차단 없음, "privacy policy"로 명확히 표시, 본인 정책일 것, 수집 정보·용도·목적·**삭제 요청 방법(이메일이나 폼)** 포함 | PRIV 전체, SITE-06 | Basic settings | [공식] Privacy Policy Expectations |
| 필수 | **Terms of Service URL** — Live 모드 전환에 필요 | TERM-01 | Basic settings | [공식] Basic settings |
| 필수 | App Icon, Category, Contact Email — Live 모드 전환에 필요 | 아이콘은 사이트와 같은 로고 | Basic settings | [공식] Basic settings |
| 필수 | **User Data Deletion**: Instructions URL 또는 Callback URL 중 하나. 처리방침의 해당 섹션이어도 됨 | DEL-06, DEL-08 | Basic settings | [공식] Basic settings · Data deletion callback |
| 참고 | email·public_profile은 App Review 없이 요청 가능 | — | — | [공식] Login overview |
| 확인 필요 | Advanced Access: 신규 consumer 앱은 두 권한을 자동 승인하지만 수동 전환이 필요. 같은 문서의 "Business Verification is required to get Advanced Access"와 충돌함 → 콘솔에서 확인 | — | App Review → Permissions | [공식] Access levels |
| 참고 | App Domains는 "Graph API request for verification"에 쓰임. 앱은 네이티브 SDK라 필수 여부가 문서에 없음 | — | Basic settings | [공식] Basic settings |
| 유지 | 연 1회 **Data Use Checkup** — 기한을 놓치면 기능 접근을 잃음 | 처리방침을 최신으로 유지 | Alerts | [2차] (검색 결과의 Meta 문서 요약) |

### 4.6 LINE (LINE Login 채널 공개)

| 등급 | 항목 | 웹 | 콘솔 | 출처 |
|---|---|---|---|---|
| 조건부 | Privacy policy URL — **인증 제공자(certified provider)일 때만 필수**. 그 밖에는 선택이지만 넣는 것을 권장 | PRIV 전체 | Basic settings | [공식] Getting started |
| 권장 | Terms of use URL (선택) | TERM-01 | Basic settings | [공식] Getting started |
| 필수 | 채널 이름에 "LINE"이나 비슷한 문자열을 넣지 않음 | — | Basic settings | [공식] Getting started |
| 필수 | **이메일 권한 신청**: 약관 동의 + 이메일을 수집하고 무엇에 쓰는지 설명하는 **화면 스크린샷** 업로드. 그 화면이 앱 화면이어야 하는지 웹 화면이어도 되는지는 **문서에 나오지 않음** (앱의 로그인·동의 화면이 가장 자연스러움) | 처리방침의 LINE 항목과 일치 | Basic settings → OpenID Connect → Apply | [공식] Integrate LINE Login |
| 주의 | Developing → Published 전환은 **되돌릴 수 없음**. Published 전 별도 심사가 있는지는 문서에 나오지 않음 | — | 채널 상태 | [공식] Getting started |
| 참고 | 앱이 요청하는 scope는 `openid`, `profile`, `email` | 처리방침 항목 | — | 앱 `line_sdk_client.dart` |

### 4.7 Google Play

| 등급 | 항목 | 웹 | 콘솔 | 출처 |
|---|---|---|---|---|
| 필수 | Privacy policy 링크(Play Console + 앱 안). 내용: 개발자 정보와 개인정보 문의처 / 수집·이용·공유하는 데이터 유형과 공유 대상 / 안전한 처리 절차 / 보존·삭제 정책 / "privacy policy" 제목 / 스토어 등록 주체(또는 앱) 이름. 공개·non-geofenced URL, PDF 불가, 편집 불가 | PRIV 전체 | App content | [공식] User Data policy 10144311 |
| 필수 | Data safety 양식의 **계정 삭제 URL**: 동작하는 링크 / 스토어의 앱·개발자 이름 언급 / 삭제 요청 경로를 눈에 띄게 / 이메일·폼 허용 / 재설치 요구 금지 / 보존 관행 안내 / 처리 기간 안내 | DEL-01~05 | Data safety | [공식] 13327111 |
| 필수 | 계정 삭제 요청 시 그 계정과 연결된 사용자 데이터도 삭제. 보안·사기 방지·법령 때문에 남기는 데이터는 처리방침 등에 명시 | DEL-03 | — | [공식] 13327111 |

### 4.8 App Store (스토어 메타데이터 URL)

§4.4의 Privacy Policy URL·Support URL·Marketing URL과 같습니다. App Store Connect에는 계정 삭제 URL 입력란이 없고, 삭제는 앱 안 기능으로 심사합니다.

---

## 5. 한국 법령 — 웹사이트에 미치는 영향 (법률 확인 필요)

| 법령 (현행 시행일) | 웹사이트에 생기는 의무 | 확인 상태 |
|---|---|---|
| **개인정보 보호법** (시행 2026.9.11, 법률 제21445호) 제30조① | 처리방침 필수 기재 1~8호 (§3.1 B 표) | [법령] |
| 같은 법 **시행령** (시행 2026.11.10) 제31조 | ①1 처리 항목, ①2 국외 이전 근거와 제28조의8② 사항, ①3 안전성 확보 조치, ①4 국외에서 직접 수집하면 처리 국가. ② **인터넷 홈페이지에 지속적으로 게재** | [법령] |
| 같은 법 제31조, 시행령 제32조① | 보호책임자 지정. 소상공인은 지정하지 않을 수 있고, 그 경우 **사업주·대표자가 보호책임자**(제31조②) → 처리방침에 대표자를 보호책임자로 적을 수 있음 | [법령] · 소상공인 해당 여부는 사용자 확인 |
| 같은 법 제28조의8 | 국외 이전 시 별도 동의, 또는 계약 이행을 위한 위탁·보관이면 처리방침에 ②각호 공개로 갈음 | [법령] · Firebase 처리 지역은 앱 쪽 확인 |
| 개인정보위 「개인정보 처리방침 작성지침」 | **2026년 4월 24일 개정 발표**(보도 기준): 수탁자 유형별 기재 허용, 생성형 AI 부록, 온디바이스 기준, 행태정보 작성 예시, 간이형 처리방침 가이드라인 정비 | [2차] 뉴시스·바이라인네트워크 — **원문은 개인정보위 누리집·개인정보 포털에서 받아 대조해야 함** |
| **위치정보법** (시행 2025.10.1, 법률 제21066호. 소관 방송미디어통신위원회) 제9조·제9조의2 | 개인위치정보 대상 위치기반서비스사업은 신고. **소상공인·1인 창조기업은 신고 없이 시작할 수 있고, 1개월이 지나서도 계속하려면 개시일부터 1개월 안에 신고** | [법령] |
| 같은 법 제12조, 시행령 제13조 (시행 2026.2.10) | 위치기반서비스사업자(제9조의2 사업자 포함)는 이용약관을 공개해야 함. 방법은 **인터넷 홈페이지 또는 앱 첫 화면·연결 화면**. 글자 크기·색상 등으로 쉽게 확인할 수 있게 표시. 변경 시 이유와 내용을 공개 | [법령] |
| 같은 법 제19조① | 약관 명시 사항(§3.1 F LOC-02) | [법령] |
| 같은 법 제5조·제18조 | 개인위치정보 대상 위치정보사업은 **등록**(법인일 것 등). 앱이 이 분류에 해당하면 약관 항목이 달라짐 | 조문은 [법령], **이 앱의 분류는 [미확인]** |
| **전자상거래법** (시행 2026.7.21) 제10조 | 사업자 신원 표시 의무는 "전자상거래를 하는 사이버몰의 운영자"에게 있음. 판매가 없으면 해당하지 않는 것으로 보임. 굿즈 판매나 유료화를 하면 통신판매업 신고(제12조)와 표시(제13조) 논점이 생김 | [법령] · 적용 여부는 해석 |

---

## 6. 현재 임시 게시본의 빈 곳

### 6.1 `privacy-policy/index.html`

| # | 빈 곳 | 관련 요건 |
|---|---|---|
| P1 | 처리 항목이 "이메일, 닉네임, 프로필 이미지"로 뭉뚱그려져 있음. 제공자 6곳별 항목, Email/Password 가입(있다면), 익명 로그인, 푸시 토큰(FCM), Analytics·Crashlytics 수집 항목이 없음 | PRIV-02, 카카오·네이버·Google |
| P2 | **굿즈 교환 정보(수령인·연락처·배송지)** 와 굿즈 배송 위탁이 있음 — 앱 범위 밖 | PRIV-14 |
| P3 | 위치정보: "걷기·달리기를 시작한 동안에만"은 맞지만, 화면이 꺼지거나 다른 앱으로 넘어가도 기록 중이면 계속 수집한다는 점이 빠짐. 저장 형태(간소화한 경로)와 보유 기간이 없음 | PRIV-02·03, Apple 5.1.5 |
| P4 | 보유 기간이 "탈퇴 후 30일 이내 파기 + 전자상거래 기록"으로 되어 있음 — "30일 이내" 상한은 실제 처리(즉시 실행, 일부 잔여는 30일 TTL)와 어긋나지 않지만, 통신판매가 아니면 전자상거래 기록 보존 근거가 맞지 않음. 공개 코스가 남는다는 점이 없음 | PRIV-03, DEL-03 |
| P5 | 파기 절차·방법이 없음 | PRIV-04 (제30조①3의2) |
| P6 | 처리 위탁(Google Firebase·GCP, 네이버클라우드)이 없음. 제3자 SDK의 동등 보호 확인 문구가 없음 | PRIV-06, Apple 5.1.1(i) |
| P7 | 국외 이전 섹션이 없음 | PRIV-07 (시행령 제31조①2) |
| P8 | 안전성 확보 조치가 없음 | PRIV-08 |
| P9 | **개인정보 보호책임자와 연락처가 없음.** 문의처가 아예 없음 | PRIV-10, Play, Meta |
| P10 | 자동 수집 장치(Analytics 등)와 거부 방법이 없음 | PRIV-11 |
| P11 | 권리 행사 방법이 "요청할 수 있습니다"로만 되어 있고 **요청 경로(이메일)가 없음** | PRIV-09, Meta, Apple |
| P12 | Google user data 처리(받는 항목·용도·저장·공유)가 따로 드러나지 않음 | Google 브랜드 검증 |
| P13 | 14세 미만 정책, 처리방침 변경 고지·시행일·이전 버전이 없음 | PRIV-15, PRIV-17 |
| P14 | 위치정보법상 권리(일시 중지 요구, 확인자료 열람)가 없음 (위치약관에 둘 수도 있음) | LOC-03 |
| P15 | "임시 게시본" 문구와 `noindex` | 안티 피처, SITE-09 |

### 6.2 `terms/index.html`

| # | 빈 곳 | 관련 요건 |
|---|---|---|
| T1 | 제2조 정의와 제4조, 제8조에 **포인트·굿즈 교환**이 있음 — 앱 범위 밖. 제4조의 "지역 코스북"도 앱 MVP에 없음(P2-05) | TERM-02 |
| T2 | 사업자 정보(상호·대표자·주소·연락처)와 고객 문의처가 없음 | BIZ-01, LOC-02 |
| T3 | 위치기반서비스 조항이 없음 (별도 약관을 둘지 결정 필요) | LOC-01·02 |
| T4 | 코스 공개(공개 후 수정 불가, 탈퇴 후에도 공개 코스 유지)와 사용자 콘텐츠 신고·조치 조항이 없음 | TERM-02, Apple 1.2 |
| T5 | 14세 미만 가입 정책이 없음 | PRIV-15 |
| T6 | 지도·경로 데이터 출처(OSM ODbL, 네이버 지도) 고지가 없음 | TERM-03 |
| T7 | "임시 게시본" 문구 | 안티 피처 |

### 6.3 `data-deletion/index.html`

| # | 빈 곳 | 관련 요건 |
|---|---|---|
| D1 | **웹 삭제 요청 경로가 없음** (앱 안 경로만 있음) — Google Play 반려 사유 | DEL-01 |
| D2 | 앱 안 경로가 "설정 → 계정 삭제"인데 앱 문자열은 「회원탈퇴」 | DEL-04 |
| D3 | 남는 데이터가 빠져 있음: 공개 코스 유지(작성자 식별자만 연결), 비공개 코스 처리, Analytics·Crashlytics 보존. "30일 이내" 상한 자체는 유지 가능 | DEL-03 |
| D4 | 삭제 항목에 포인트·굿즈 배송 정보가 있음 | PRIV-14 |
| D5 | 이메일로 요청할 때 보낼 정보(가입한 로그인 방식, 닉네임 등)와 본인 확인·처리 기간·완료 통지가 없음 | DEL-05 |
| D6 | Facebook·Apple 같은 제공자별 안내(연결 해제와 데이터 삭제의 차이)가 없음 | DEL-08 |
| D7 | 본문에 "러닝펜슬 앱", 푸터에 "슬림펌킨"이 있어 기본은 충족함. 남은 일은 최종 **스토어 등록명·개발자명과 글자까지 일치**시키는 것(영문 등록명을 쓰면 영문판에도) | DEL-02 |

### 6.4 `index.html` (랜딩)

| # | 빈 곳 | 관련 요건 |
|---|---|---|
| L1 | `<meta name="description">`(10행)과 `og:description`(15행)에 "포인트로 기념 굿즈", OG 설명에 "동네 코스북". 앱에서 코스북은 Phase 2·3(P2-05)이고 포인트 리워드는 Out of Scope | SITE-02 |
| L2 | 푸터에 지원 페이지·위치약관 링크와 사업자 정보가 없음 | SUP-01, LOC-01, BIZ-01 |

---

## 7. Feature Dependencies

```
[사용자 제공: 사업자 정보(상호·대표자·사업자등록번호·주소)]
    └──requires──> BIZ-01 푸터 ──> 카카오 비즈니스 정보 심사
    └──requires──> LOC-02 위치약관 연락처
    └──requires──> SUP-01 지원 페이지(legal address)
    └──requires──> PRIV-10 보호책임자(대표자일 수 있음)

[사용자 작업: 지원 메일 주소 + 메일 라우팅(MX/DNS)]
    └──requires──> SUP-02 연락처 공개
                       ├──> DEL-01 웹 삭제 요청 경로 ──> Google Play Data safety 제출
                       ├──> PRIV-09/10 권리 행사·보호책임자 연락처
                       ├──> Meta 처리방침 "deletion via email" 요건
                       └──> SUP-05 SPF/DKIM ──> Apple Private Email Relay 등록

[사용자 작업: Search Console DNS 확인]
    └──requires──> Google Authorized domains ──> Branding URL 입력 ──> 브랜드 검증

[앱 데이터 흐름 확인 (앱 저장소, 읽기 전용)]
    └──requires──> PRIV-02/06/07 (항목·수탁자·국외 이전)
                       └──requires──> PRIV 전체 재작성
                                          ├──> DEL-03 삭제·보존 항목
                                          ├──> TERM-02 약관 재작성
                                          └──> I18N-01 영문판 (번역은 국문 확정 후 마지막)

[법률 판단: 위치정보법 분류 (제5조 등록 vs 제9조 신고) + 14세 미만 정책 + 전화번호 공개]
    └──requires──> LOC-01/02 위치기반서비스 이용약관 페이지
    └──requires──> PRIV-15, SUP-01 연락처 형태

[영문 서비스명 결정]
    └──requires──> I18N-01, Google·Meta·LINE 앱 이름, Play 등록명 (서로 일치)

SITE-02 랜딩 문구 정정 ──must precede──> 모든 제공자 심사 신청
SITE-07 URL 고정 ──must precede──> 콘솔에 URL 입력 (SUBMIT-01)
PRIV-16 제공자별 항목 표 ──enhances──> 카카오 동의항목 심사, 네이버 2.3, Google 검증
DEL-08 제공자별 앵커 ──enhances──> Meta User Data Deletion URL
외부 폼 서비스 ──conflicts──> "위탁·국외 이전 최소화" (이메일 경로로 대체)
```

### Dependency Notes

- **메일 라우팅이 지원 페이지보다 먼저입니다.** 이메일을 공개했는데 받지 못하면 Meta("up to date and valid"), Play(삭제 요청 처리), Apple 1.5 요건을 모두 어깁니다. 라우팅이 동작하는지 테스트 메일로 확인한 뒤 공개합니다.
- **Search Console이 Google 브랜드 검증보다 먼저입니다.** 도메인 속성(DNS TXT)으로 확인하면 `www`와 하위 도메인까지 한 번에 덮습니다.
- **앱 데이터 흐름 확인이 처리방침보다 먼저입니다.** 국외 이전(Firebase Auth·Analytics·Crashlytics·FCM의 처리 지역), 네이버클라우드가 수탁자인지 여부, 비공개 코스의 탈퇴 처리는 앱 저장소나 각 서비스 약관에서 확인해야 하고 추측으로 채우면 안 됩니다.
- **국문 확정이 영문판보다 먼저입니다.** 번역을 먼저 하면 내용이 갈라집니다(안티 피처).
- **카카오 비즈니스 정보 심사는 스토어 등록 정보나 소개 페이지를 봅니다.** 출시 전이면 홈페이지가 유일한 근거이므로 SITE-01·02, BIZ-01이 먼저 끝나야 합니다. FAQ는 앱마켓 정보가 없을 때 테스트 앱 사용을 권하고, 출시 일정이 정해져 사전 신청이 필요하면 따로 문의하라고 합니다.
- **카카오 국외 이전 설정과 처리방침 국외 이전 섹션은 같은 값을 써야 합니다.** 둘을 같은 단계에서 확정합니다.

---

## 8. MVP Definition

### Launch With (v1 — 이번 마일스톤, 심사 신청 전에 끝낼 것)

- [ ] SITE-02 랜딩 메타의 포인트·굿즈·코스북 정리 (U10 결정 후) — 모든 심사의 "사이트 = 앱" 전제
- [ ] SITE-05 Search Console 확인 (사용자 작업) — Google 선행 조건
- [ ] SUP-01·02 지원 페이지 + 지원 이메일 — Apple Support URL, Play 삭제 경로, Meta, 보호책임자 연락처의 공통 전제
- [ ] PRIV-01~15 처리방침 재작성 — 6개 제공자와 2개 스토어 모두
- [ ] DEL-01~07 삭제 안내 재작성 — Play 반려의 직접 원인 제거, Meta Instructions URL
- [ ] TERM-01·02 약관 재작성 — Meta Live, Google 프로덕션
- [ ] BIZ-01·02 사업자 표시 — 카카오 비즈니스 정보 심사
- [ ] LOC-01~04 위치기반서비스 이용약관 페이지 — 법률 확인 결과에 따라 범위 조정. 출시 시점에 이미 필요할 가능성이 높아 미리 둠
- [ ] SITE-07 URL 고정과 SUBMIT-01 콘솔 입력 체크리스트

### Add After Validation (v1.x)

- [ ] I18N-01 영문판 — 국문 확정 뒤. Google·Meta 심사 전에 있으면 좋음 (PROJECT 결정상 이번 마일스톤 Active)
- [ ] DEL-08 제공자별 앵커, PRIV-16 제공자별 항목 표 — 첫 반려가 나오기 전에 넣으면 왕복이 줄어듦
- [ ] PRIV-17 처리방침 버전 보관 — 첫 개정 때
- [ ] SITE-09 `noindex`·임시 문구 제거 — 확정본 게시와 동시에

### Future Consideration (v2+)

- [ ] SITE-08 랜딩에 실제 앱 스크린샷 — 네이버·카카오가 서비스 소개 자료를 요청하면 앞당김
- [ ] Apple 도메인 검증 파일(`/.well-known/`) — `runningpencil.com`을 Services ID에 등록할 때만
- [ ] 통신판매업 표시 — 굿즈 판매나 유료 기능을 실제로 도입할 때만

---

## 9. Feature Prioritization Matrix

| Feature | User Value (심사 통과 기여) | Implementation Cost | Priority |
|---|---|---|---|
| SITE-02 랜딩 문구 정정 | HIGH | LOW | P1 |
| SITE-05 Search Console | HIGH | LOW | P1 |
| SUP-01·02 지원 페이지·이메일 | HIGH | LOW | P1 |
| DEL-01~07 삭제 안내 | HIGH | LOW~MEDIUM | P1 |
| PRIV-01~15 처리방침 | HIGH | HIGH | P1 |
| TERM-01·02 약관 | HIGH | MEDIUM | P1 |
| BIZ-01·02 사업자 표시 | HIGH (카카오) | LOW (값 받으면) | P1 |
| LOC-01~04 위치약관 | HIGH (법령) | MEDIUM | P1 (법률 확인 병행) |
| SUBMIT-01 콘솔 체크리스트 | MEDIUM | LOW | P1 |
| I18N-01 영문판 | MEDIUM | MEDIUM | P2 |
| PRIV-16 제공자별 항목 표 | MEDIUM | MEDIUM | P2 |
| DEL-08 제공자별 앵커 | MEDIUM | LOW | P2 |
| SUP-05 SPF/DKIM·Apple relay | MEDIUM | LOW | P2 |
| PRIV-17 버전 보관 | LOW | LOW | P3 |
| SITE-08 앱 스크린샷 | LOW~MEDIUM | MEDIUM | P3 |

---

## 10. Competitor Feature Analysis

**N/A.** 이번 조사의 질문은 경쟁 서비스와의 비교가 아니라 심사·법령 요건 확인입니다. 다른 한국 러닝 앱의 처리방침·위치약관 구성을 근거 없이 적지 않았습니다. 필요하면 국내 러닝·걷기 앱 2~3곳의 「위치기반서비스 이용약관」 목차를 단계별 조사에서 비교할 수 있습니다(LOC 단계의 참고용).

---

## 11. 사용자·법률 결정이 필요한 항목

| # | 결정 | 왜 필요한가 | 막는 것 |
|---|---|---|---|
| U1 | **전화번호 공개 여부** | ASC Support URL 원문의 예시(legal address, email, telephone)와 "as may be required by local law" 단서, PIPA 제30조①6 "전화번호 등 연락처", 위치정보법 제19조①1 "전화번호 그 밖의 연락처". 이메일만으로 충분한지는 법률 확인이 필요함 | SUP-01, PRIV-10, LOC-02 |
| U2 | **위치정보법 분류** (위치기반서비스사업 신고 vs 개인위치정보사업 등록) | 등록은 법인 요건이 있음. 기기 GPS를 직접 받는 앱의 분류는 조문만으로 정해지지 않음 | LOC-01~05, 앱 동의 화면 |
| U3 | 소상공인·1인 창조기업 해당 여부 | 보호책임자 지정 면제(시행령 제32조①), 위치기반서비스 신고 1개월 유예(제9조의2) | PRIV-10, LOC |
| U4 | 영문 서비스명 | 영문판과 4개 콘솔(Google·Meta·LINE·Play) 이름이 일치해야 함. 기존 방침은 "RunningPencil 쓰지 않음" | I18N-01, SUBMIT-01 |
| U5 | Email/Password 가입을 UI에 노출하는지 | 처리방침 항목, 네이버 "별도 비밀번호 금지"(네이버 로그인 경로에서만 해당) | PRIV-02 |
| U6 | 탈퇴 후 공개 코스 유지(D-28)를 그대로 갈지, 비공개 코스를 어떻게 처리하는지 | Play·Apple은 남는 데이터를 명시하도록 요구함 | DEL-03, TERM-02 |
| U7 | 14세 미만 가입 정책 | PIPA 제22조의2, 위치정보법 제25조 | PRIV-15, 약관 |
| U8 | 네이버 지도 이용약관 §7⑤ 고지 의무 확인 | 앱 임시 문자열에만 근거가 있음 | TERM-03, PRIV-05 |
| U9 | Meta Advanced Access에 비즈니스 인증이 필요한지 | 공식 문서 안의 두 문장이 충돌함 | Facebook Live 일정 |
| U10 | **포인트·굿즈·코스북을 사이트·법적 문서에서 뺄지** | 사이트의 CLAUDE.md는 포인트로 굿즈를 교환하는 앱으로 설명하지만, 앱 `.planning/REQUIREMENTS.md`는 「Out of Scope」 표에 "현금·포인트 리워드"를 두고 코스북·세트 뱃지는 P2-05(Phase 2·3)로 미룸. 심사는 **지금 앱**과 사이트의 일치를 보므로, 출시 시점 앱에 없는 기능은 빼는 것을 권장. 향후 도입 시 처리방침(배송지)·통신판매업 논점이 다시 생김 | SITE-02, PRIV-14, TERM-02, DEL-03 |

---

## Sources

**제공자·스토어 (공식, 2026-11-14 접속)**
- Google — Brand verification 요건: https://support.google.com/cloud/answer/13464321
- Google — OAuth Branding 페이지 필드: https://support.google.com/cloud/answer/15549049
- Google — 검증이 필요한 경우: https://support.google.com/cloud/answer/13463073
- Google Play — 계정 삭제 요건: https://support.google.com/googleplay/android-developer/answer/13327111
- Google Play — User Data 정책(처리방침): https://support.google.com/googleplay/android-developer/answer/10144311
- Apple — App Review Guidelines (1.2, 1.5, 4.8, 5.1.1, 5.1.5): https://developer.apple.com/app-store/review/guidelines/
- Apple — 계정 삭제 안내: https://developer.apple.com/support/offering-account-deletion-in-your-app/
- Apple — ASC Platform version information (Support URL, Marketing URL): https://developer.apple.com/help/app-store-connect/reference/app-information/platform-version-information
- Apple — ASC App information (Privacy Policy URL): https://developer.apple.com/help/app-store-connect/reference/app-information/app-information
- Apple — Private email relay 설정 (검색 결과로 확인): https://developer.apple.com/help/account/capabilities/configure-private-email-relay-service
- Apple — Sign in with Apple 환경 구성: https://developer.apple.com/documentation/signinwithapple/configuring-your-environment-for-sign-in-with-apple
- 카카오 — 앱 설정(비즈 앱): https://developers.kakao.com/docs/ko/app-setting/app
- 카카오 — 카카오 로그인 설정하기(동의항목·심사·국외 이전): https://developers.kakao.com/docs/ko/kakaologin/prerequisite
- 카카오 데브톡 — 비즈니스 정보 심사 FAQ [공식-포럼]: https://devtalk.kakao.com/t/faq/132272
- 네이버 — 네이버 로그인 사전 검수 가이드: https://developers.naver.com/docs/login/verify/verify.md
- Meta — Basic settings: https://developers.facebook.com/docs/development/create-an-app/app-dashboard/basic-settings
- Meta — Data deletion callback: https://developers.facebook.com/docs/development/create-an-app/app-dashboard/data-deletion-callback
- Meta — Privacy Policy Expectations: https://developers.facebook.com/docs/development/terms-and-policies/privacy-policy/
- Meta — Facebook Login overview: https://developers.facebook.com/docs/facebook-login/overview
- Meta — Access levels: https://developers.facebook.com/docs/graph-api/overview/access-levels
- Meta — Data Use Checkup [2차, 검색 요약만]: https://developers.facebook.com/docs/resp-plat-initiatives/individual-processes/data-use-checkup
- LINE — Getting started with LINE Login: https://developers.line.biz/en/docs/line-login/getting-started/
- LINE — Integrating LINE Login (email permission): https://developers.line.biz/en/docs/line-login/integrate-line-login/

**법령 (국가법령정보센터 현행본, 2026-11-14 접속)**
- 개인정보 보호법 [시행 2026.9.11, 법률 제21445호] 제22조의2·제28조의8·제30조·제31조: https://www.law.go.kr/법령/개인정보보호법
- 개인정보 보호법 시행령 [시행 2026.11.10, 대통령령 제36804호] 제31조·제32조: https://www.law.go.kr/법령/개인정보보호법시행령
- 위치정보의 보호 및 이용 등에 관한 법률 [시행 2025.10.1, 법률 제21066호] 제2조·제5조·제9조·제9조의2·제12조·제16조·제18조·제19조·제23조·제24조·제25조: https://www.law.go.kr/법령/위치정보의보호및이용등에관한법률
- 위치정보법 시행령 [시행 2026.2.10, 대통령령 제36084호] 제13조: https://www.law.go.kr/법령/위치정보의보호및이용등에관한법률시행령
- 전자상거래 등에서의 소비자보호에 관한 법률 [시행 2026.7.21, 법률 제21312호] 제2조·제10조·제12조·제13조: https://www.law.go.kr/법령/전자상거래등에서의소비자보호에관한법률

**2차 출처 (공식 기준 아님)**
- 개인정보 처리방침 작성지침 2026년 4월 개정 보도: https://mobile.newsis.com/view/NISX20260424_0003604909 · https://byline.network/2026/04/24-580/
- 카카오 데브톡 사례: 사이트 사업자 정보 누락 반려 https://devtalk.kakao.com/t/topic/151805 · 사업자 정보 표기 위치 https://devtalk.kakao.com/t/topic/149204 · 카카오 수탁자 기재 반려 https://devtalk.kakao.com/t/topic/148755 · 필수/선택 불일치 반려 https://devtalk.kakao.com/t/topic/151330

**앱 저장소 (읽기 전용 확인, `/Users/woody/dv/woody/running_pencil`)**
- `.planning/REQUIREMENTS.md` (「Out of Scope」 표의 현금·포인트 리워드, P2-05 코스북·세트 뱃지와 P2-09 모더레이션·스토어 출시는 Phase 2·3으로 미룸)
- `functions/src/auth/delete_user_account.ts`, `functions/src/running_pencil/cleanup_user_data.ts` (탈퇴 시 삭제·보존 범위)
- `lib/core/auth/provider_id.dart`, `lib/features/auth/data/auth_repository.dart`, `lib/features/auth/data/line_sdk_client.dart` (로그인 방식·scope)
- `lib/l10n/app_ko.arb` (`settingsWithdrawalLabel` 「회원탈퇴」, 임시 약관·처리방침 문자열)

---
*Feature research for: 한국 모바일 앱 공식 웹사이트의 심사·법령 대응*
*Researched: 2026-11-14*
