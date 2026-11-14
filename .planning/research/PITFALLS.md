# Pitfalls Research

**Domain:** 한국 모바일 앱(러닝펜슬)의 공식 웹사이트를 소셜 로그인 6곳(카카오·네이버·Google·Apple·Facebook·LINE) 프로덕션 심사와 App Store·Google Play 등록에 맞추는 일. GitHub Pages 정적 사이트(빌드 없음, `main` 푸시 = 배포)에서 진행합니다.
**Researched:** 2026-11-14
**Confidence:** MEDIUM. 공식 원문을 직접 확인한 항목이 핵심 반려 사유의 절반 이상입니다. 카카오는 공식 데브톡의 운영진 답변, LINE·GitHub Pages 세부는 2차 출처에 기댑니다. 위치정보법 적용 범위는 법률 판단이 필요합니다.

## 출처 표기 규칙

각 주장 끝에 출처 등급을 붙였습니다. `classify-confidence` seam은 `websearch` 단독 LOW, 교차 확인된 `websearch` MEDIUM, `webfetch`는 교차 확인해도 LOW를 돌려줬습니다. 그래서 아래 등급은 seam의 tier와 별개로 「출처의 종류」를 나타냅니다.

- **[공식]**: 제공자·스토어의 공식 문서나 법령 원문을 이번 조사에서 직접 열어(WebFetch 또는 curl) 해당 문장을 확인했습니다. 대부분은 한 번 열어 본 것이고 다른 출처로 교차 확인하지는 않았습니다(seam 기준 LOW~MEDIUM). 법령은 nepla.ai 미러를 한 번 열람한 것입니다.
- **[공식·요약]**: 공식 문서이지만 원문을 열지 못하고 검색 결과의 요약·인용으로만 확인했습니다(seam 기준 LOW). 원문을 다시 확인해야 합니다.
- **[커뮤니티]**: 공식 포럼의 운영진 답변, 개발자 포럼, 2차 블로그에서 나온 내용입니다. LOW이므로 단정하지 말고 근거로만 씁니다.
- **[확인 필요]**: 출처로 확인하지 못했거나 기억에 의존한 내용입니다. 괄호 안에 어디서 확인할지 적었습니다.

---

## Critical Pitfalls

1·2·3·5·7번은 이 저장소의 현재 파일에서 직접 확인한 문제입니다. 4·6번은 현재 파일에서 출발하지만 앞으로의 변경이나 법률 판단에 달린 위험이고, 8~12번은 이번 작업 중에 생기기 쉬운 문제입니다.

### Pitfall 1: 「임시 게시본」·「출시 준비 중」 문구가 심사에서 미완성 사이트로 읽힘

**What goes wrong:**
현재 법적 페이지 3종 본문 끝에 「본 방침은 임시 게시본이며…」가 있습니다(`privacy-policy/index.html:141`, `terms/index.html:167`, `data-deletion/index.html:118`). 랜딩은 「출시 준비 중」, 「지금은 연필을 깎고 있어요」로 끝납니다(`index.html`의 `#get`). 심사자는 이 문구를 「완성되지 않은 서비스·사이트」라는 신호로 받아들입니다.
- Apple 2.1(a): "fully functional URLs included; placeholder text, empty websites, and other temporary content should be scrubbed before submission" [공식]
- 네이버 사전 검수 FAQ 4.1: 서비스 URL이 "아직 개발이 진행 중인 상태라 서비스 콘텐츠가 완전하지 않을 때"는 반려하고 서비스 소개 자료를 요구합니다 [공식]
- 카카오 비즈니스 정보 심사: "개발 중"인 서비스는 기획서, 디자인 시안, 화면 흐름 캡처·영상을 첨부하라고 안내합니다 (데브톡 운영진 FAQ) [커뮤니티]

**Why it happens:**
티저 사이트를 그대로 둔 채 법적 URL만 콘솔에 넣습니다. 법적 페이지의 「임시」 표시는 법률 검토 전이라 붙여 둔 것인데, 심사자에게는 「이 방침은 효력이 없다」로 읽힙니다.

**How to avoid:**
- 법적 본문을 다시 쓸 때 「임시 게시본」 문구를 없앱니다. 법률 검토 전이라는 사정은 내부 기록(`.planning/`)에만 남기고, 게시본에는 시행일과 변경 이력만 둡니다.
- 랜딩은 티저를 유지하되 크롤러와 심사자가 읽을 수 있는 「서비스 소개」 텍스트를 HTML에 둡니다. 무엇을 하는 앱인지, 지원 플랫폼, 로그인 방식, 운영사를 SVG가 아닌 텍스트로 씁니다. 「출시 준비 중」은 사실이므로 지우지 않아도 되지만, 서비스 설명보다 앞세우지 않습니다.
- 카카오·네이버용 「서비스 소개 자료」(앱 화면 캡처와 로그인 흐름, 개인정보는 마스킹)를 사이트와 별도로 준비합니다. 사이트만으로는 출시 전 앱의 심사를 통과할 수 없습니다.

**Warning signs:**
- `grep -rn "임시 게시본" --include=*.html .` 결과가 1건 이상입니다.
- 랜딩의 텍스트만 추출했을 때 앱 기능 설명이 없습니다(현재는 「지도에 점을 찍어 코스를 그리고…」가 있어 일부 충족).
- 네이버 검수 결과가 「서비스 소개 자료 첨부 요청」으로 옵니다.

**Phase to address:** 법적 본문, 제출 체크리스트(서비스 소개 자료 준비)

---

### Pitfall 2: 데이터 삭제 안내가 「앱 안에서만」 삭제하도록 안내함

**What goes wrong:**
`data-deletion/index.html:97`은 「앱 내 설정 → 계정 삭제」 경로만 안내합니다. 앱을 지운 사용자는 삭제를 요청할 방법이 없습니다.
- Google Play: 웹 리소스는 앱을 다시 설치하지 않고 삭제를 요청할 수 있어야 합니다. 경로는 삭제 링크, 고객 지원 이메일, 요청 폼 중 하나면 되고 "prominently featured and easily discoverable"이어야 합니다. 페이지는 "reference the app or developer name (that is, as it appears on your store listing in Google Play)"해야 합니다. Data safety에 수집한다고 적은 데이터는 모두 삭제 대상입니다 [공식]
- Meta: "Data Deletion Instructions URL" 또는 "Data Deletion Callback URL" 중 하나를 지정해야 합니다. 처리방침에는 "how to request deletion of their data"가 있어야 합니다 [공식]. 지침 페이지에 무엇을 써야 하는지는 공식 문서에 별도 기준이 없습니다 [확인 필요: App Dashboard의 도움말·Data Use Checkup 안내]
- Apple 5.1.1(v): 앱 안에서 계정 삭제를 제공해야 합니다("offer account deletion within the app"). 웹 페이지는 앱 안 경로를 보완할 뿐입니다. 처리방침은 "describe how a user can revoke consent and/or request deletion"해야 합니다 [공식]

**Why it happens:**
웹페이지를 앱 기능의 설명서로 쓰기 때문입니다. 또 「연락처 미표시」 방침(`CLAUDE.md`) 탓에 웹에서 요청할 경로가 처음부터 없었습니다.

**How to avoid:**
- 삭제 페이지 맨 위에 앱 이름과 개발자 이름을 둡니다. 스토어 표기와 글자까지 같게 하고, 한글과 영문 법인명을 함께 적습니다.
- 경로 두 가지를 같은 무게로 보여 줍니다: ① 앱 안에서 삭제, ② 앱 없이 지원 이메일로 요청. ②에는 메일 제목 예시, 본인 확인에 필요한 최소 정보(로그인한 제공자, 닉네임)와 받지 않을 정보(비밀번호 등), 처리 기한을 적습니다.
- 삭제되는 데이터, 보존되는 데이터, 보존 사유, 보존 기간을 따로 나눠 씁니다(Pitfall 5의 데이터 목록과 맞춤).
- Facebook 로그인 사용자를 위해 「Facebook 설정에서 앱 연결 해제 + 우리에게 삭제 요청」을 한 구간으로 둡니다. 이 구간이 있는 페이지 URL을 Meta 콘솔의 Data Deletion Instructions URL로 등록합니다.

**Warning signs:**
- 페이지에 `mailto:` 링크나 이메일 텍스트가 없습니다.
- 앱 이름과 개발자 이름이 Play Console 스토어 등록정보의 문자열과 다릅니다.
- 앱을 지운 테스트 기기로 이 페이지만 보고 삭제를 요청해 볼 수 없습니다.

**Phase to address:** 데이터 삭제, 지원·연락

---

### Pitfall 3: 서비스 이름·운영사 이름이 동의 화면·스토어·홈페이지마다 다름

**What goes wrong:**
사이트 HTML에는 「러닝펜슬」과 「슬림펌킨」만 있습니다. `CLAUDE.md`는 「영문 `RunningPencil`은 쓰지 않고」라고 명시합니다. 그런데 Google 동의 화면, Play 개발자 이름, App Store 판매자 이름(법인 영문명)에는 영문이 들어갈 가능성이 큽니다.
- Google 브랜드 검증: 동의 화면의 앱 이름은 검증 제출 내용과 일치해야 하고("your application name on the OAuth consent screen match that on your verification submission"), 이름 불일치는 흔한 실패 사유로 나와 있습니다 [공식]. 「동의 화면의 앱 이름이 홈페이지의 앱 이름과 다르다」는 판정은 Google 포럼 글의 제목에 인용된 문구로 확인했습니다 [커뮤니티]
- Play 삭제 페이지는 앱 이름이나 개발자 이름을 "as it appears on your store listing"대로 적어야 합니다 [공식]. Play 처리방침도 스토어 등록정보에 표시된 주체(개발자·회사)를 적거나 앱 이름을 적어야 합니다 [공식·요약]
- 네이버 사전 검수 2.4는 애플리케이션 이름과 로고를 검사합니다. 이름이 「로그인」 같은 비정상 이름이거나 로고가 없으면 반려합니다 [공식]
- 2026년 중반에도 이름과 홈페이지가 맞는데 이름 불일치 판정이 반복된다는 개발자 포럼 글이 여러 건 있습니다 [커뮤니티]. 문자열을 정확히 맞춰 두는 것이 유일한 예방책입니다.

**Why it happens:**
제공자 콘솔 6곳과 스토어 2곳을 서로 다른 시점에 다른 사람이 채웁니다. 한글 사이트에 영문 동의 화면 이름을 맞출 생각을 하지 못합니다.

**How to avoid:**
- 영문판을 쓰기 전에 「이름 표」를 하나 확정합니다: 서비스명(한글·영문), 운영사 상호(사업자등록증 그대로, 「주식회사」 위치 포함), 운영사 영문명(Apple 판매자 이름·Play 개발자 이름과 같게), 로고 파일. 8개 콘솔과 사이트는 이 표의 문자열을 복사해서만 씁니다.
- 동의 화면에 영문 이름을 쓰는 제공자가 있다면, 그 콘솔에 등록하는 홈페이지 URL의 보이는 텍스트(SVG나 `alt`가 아님)에 같은 영문 이름을 둡니다. 예: 헤더나 소개 문단에 「러닝펜슬 (RunningPencil)」.
- 결정 후 `CLAUDE.md`의 「RunningPencil 쓰지 않음」 규칙을 바꿉니다(Pitfall 7).

**Warning signs:**
- 각 콘솔 화면을 캡처해 이름 표와 비교하면 다른 문자열이 있습니다(띄어쓰기, 대소문자, 「(주)」 유무 포함).
- `grep -c "RunningPencil"` 결과가 콘솔에 등록한 홈페이지에서 0인데, 동의 화면 이름은 영문입니다.

**Phase to address:** 심사 요건 확정·제출 체크리스트(이름 표는 맨 앞), 영문판(i18n)

---

### Pitfall 4: 이미 등록한 URL을 바꿈 (영문판 추가·공통 블록 리팩터 중)

**What goes wrong:**
dev용 소셜 로그인 앱은 이미 등록돼 있습니다(`PROJECT.md`). `/privacy-policy/`, `/terms/`, `/data-deletion/`은 콘솔과 앱 바이너리 안의 링크에 들어갔을 수 있습니다. 영문판을 넣으면서 `/ko/privacy-policy/`로 옮기거나, Jekyll로 바꾸면서 `permalink`가 바뀌면 기존 URL이 404가 됩니다. Meta 쪽에는 "unable to successfully load the page as it led to an invalid page" 반려 사례가 있습니다 [커뮤니티].
GitHub Pages에는 사용자가 경로별로 설정할 수 있는 서버 리디렉트(301)가 없습니다(`www` → apex처럼 GitHub가 자동으로 하는 리디렉트는 있음). `jekyll-redirect-from` 플러그인은 meta refresh HTML을 만드는 것으로 알고 있습니다 [확인 필요: 플러그인 README]. 심사 크롤러가 meta refresh를 따라가는지도 확인하지 못했습니다 [확인 필요: 각 제공자의 URL 검사 동작].

**Why it happens:**
「언어별 폴더가 깔끔하다」는 구조 취향 때문에, 또는 Jekyll 도입 시 출력 경로를 따로 확인하지 않아서 생깁니다.

**How to avoid:**
- 현재 한국어 URL 3개는 고정합니다. 영문판은 `/en/privacy-policy/`처럼 새 경로에 추가만 합니다. 새 페이지(`/support/`, 위치기반서비스 약관)도 처음 정한 경로를 영구로 봅니다.
- 표준 형태를 하나로 정합니다: `https://runningpencil.com/…/`(apex, https, 끝 슬래시). 모든 콘솔에 그 문자열만 넣습니다.
- 「URL 등록 대장」(어느 콘솔의 어느 칸에 어느 URL을 넣었는지)을 `.planning/`에 두고, 경로를 바꾸는 커밋 전에 대장을 확인합니다.

**Warning signs:**
- 리팩터 후 `curl -sI https://runningpencil.com/privacy-policy/`가 200이 아닙니다.
- `_site/` 산출물 경로가 리팩터 전 파일 경로와 다릅니다.

**Phase to address:** 공통 블록 단일화(shared-layout refactor), 영문판(i18n)

---

### Pitfall 5: 처리방침이 앱의 실제 동작과 맞지 않음 (없는 걸 적고, 있는 걸 빠뜨림)

**What goes wrong:**
현재 `privacy-policy/index.html`에서 앱 저장소로 사실 여부를 확인해야 할 항목입니다.
- **적었지만 사실인지 확인해야 할 것:** 굿즈 교환 정보(수령인·연락처·배송지), 배송업체 위탁, 「전자상거래 거래 기록」 보존, 「삭제 요청 시 30일 이내 모든 개인정보 파기」, 「기기 식별자」. 앱 범위에 굿즈 배송이 없다면 수집하지 않는 정보를 적은 셈입니다. 그러면 Play Data safety, App Store 개인정보 라벨, 카카오·네이버 동의항목과도 어긋납니다.
- **빠졌을 가능성이 큰 것:**
  - 개인정보 보호책임자의 성명 또는 부서와 연락처 (개인정보 보호법 제30조 제1항 기재사항. 제31조상 지정하지 않으면 사업주·대표자가 책임자) [공식]
  - 처리 위탁: Firebase/Google, NCP, GCP VM (제26조 제2항: 위탁 업무와 수탁자를 공개) [공식]
  - 국외 이전 (제28조의8): 이전 항목, 국가, 시기·방법, 받는 자의 이름과 연락처, 이용 목적과 보유 기간, 거부 방법과 거부 시 효과 [공식]
  - 자동 수집 장치의 설치·운영과 거부 방법 (제30조): Analytics, Crashlytics, FCM 토큰, App Check, Remote Config [공식]
- **제공자별 반려 사유:**
  - 카카오: 처리방침에 카카오를 수탁자로 적으면 반려될 수 있습니다. 카카오는 위수탁 관계가 아니라는 입장입니다 [커뮤니티: 데브톡 운영진 답변]
  - 네이버: 이용자 식별자 외의 정보(이름·이메일 등)를 받으면 실제 활용처를 증빙해야 합니다. 「단순히 통계 목적」은 인정하지 않고 반려합니다 [공식]
  - Apple 5.1.1(i): 분석 도구와 SDK 등 데이터를 공유하는 제3자가 같은 수준으로 보호한다는 점을 확인하고, 보유·삭제 정책을 설명해야 합니다 [공식]
  - Google: 처리방침에 Google 사용자 데이터를 어떻게 "accesses, uses, stores, or shares"하는지 있어야 합니다 [공식]

**Why it happens:**
앱 코드를 보지 않고 템플릿이나 기획 문서(굿즈·포인트 교환 구상)로 처리방침을 씁니다. Firebase SDK가 자동으로 수집하는 항목은 개발자 눈에 잘 보이지 않습니다.

**How to avoid:**
- 처리방침을 쓰기 전에 앱 저장소(`~/dv/woody/running_pencil`)에서 「데이터 목록」 하나를 만듭니다. 칸은 항목, 수집 시점, 출처(사용자 입력, 소셜 제공자, SDK 자동), 목적, 저장 위치(서비스와 리전), 수탁자, 국외 이전 여부, 보유 기간, 삭제 방법입니다. 한국어 처리방침, 영문 처리방침, Play Data safety, App Store 개인정보 라벨, 카카오·네이버·LINE 동의항목 신청서를 모두 이 표에서 만듭니다.
- 앱 저장소에서 확인할 것:
  - Cloud Functions 리전. 기본값이 `us-central1`이라는 기억은 있지만 확인하지 못했습니다 [확인 필요: Firebase Functions 문서, `firebase.json`·함수 코드의 region 설정]. 검색어와 좌표가 Functions를 거치므로 리전에 따라 국외 이전이 될 수 있습니다.
  - Firestore·Storage 위치, OSRM VM 리전(GPS 궤적이 전송됨)
  - Analytics·Crashlytics의 데이터 보존 기간 [확인 필요: Firebase 콘솔 설정과 Firebase 개인정보 문서]
  - `flutter_facebook_auth`가 포함하는 Facebook SDK가 앱 이벤트를 자동 전송하는지 [확인 필요: Meta SDK 문서의 `AutoLogAppEventsEnabled` 항목]
- 「30일 이내 모두 파기」처럼 절대적인 문장은 백업과 서드파티 보존 기간을 확인한 뒤에만 씁니다.
- 소셜 제공자 6곳은 「제공받는 항목」으로만 적고 수탁자·제3자 제공 목록에는 넣지 않습니다(카카오 반려 사례).

**Warning signs:**
- 처리방침에 있는 항목이 데이터 목록에 없거나, 그 반대입니다.
- 처리방침에 「책임자」, 「국외」, 「위탁」이라는 단어가 없습니다(현재 `grep -c 책임자` = 0, `CONCERNS.md`).
- Play Console Data safety 초안과 처리방침의 수집 항목 수가 다릅니다.

**Phase to address:** 법적 본문 (데이터 목록 작성이 첫 작업)

---

### Pitfall 6: 위치정보법 의무를 처리방침 한 단락으로 끝냈다고 착각함

**What goes wrong:**
앱은 기록 중에 GPS 궤적을 받아 계정과 함께 저장합니다(화면이 꺼져도 계속 받음). 개인위치정보를 다룰 가능성이 큰 구조입니다. 그런데 현재 사이트에는 처리방침 3항 「위치정보의 처리」 한 단락뿐입니다.
- 제9조 제1항: 개인위치정보를 대상으로 하는 위치기반서비스사업은 방송미디어통신위원회에 신고해야 합니다. 신고하지 않으면 제40조에 따라 3년 이하 징역 또는 3천만원 이하 벌금이고, 제42조 양벌규정도 있습니다 [공식: 법령 원문, 현행 2025.10.01]
- 제9조의2: 소상공인과 1인 창조기업은 신고 없이 시작할 수 있지만, 1개월이 지나 계속하려면 사업 개시일부터 1개월 이내에 신고해야 합니다 [공식]
- 제5조: 개인위치정보를 대상으로 하는 위치정보사업은 등록 대상입니다. 앱이 단말 GPS를 직접 받는 것이 「위치정보사업」에도 해당하는지는 법률 판단이 필요합니다 [확인 필요: 방송미디어통신위원회 위치정보 담당, 법률 자문]
- 제19조 제1항: 위치기반서비스사업자는 아래 사항을 이용약관에 명시한 뒤 동의를 받아야 합니다 [공식]
  - 상호, 주소, 전화번호 등 연락처
  - 개인위치정보주체와 법정대리인의 권리와 행사 방법
  - 서비스 내용
  - 이용·제공사실 확인자료의 보유 근거와 기간
  - 개인위치정보의 보유 목적과 기간
- 제16조 제2항은 확인자료를 자동으로 기록·보존하라고 요구합니다(앱·백엔드 쪽 일). 제25조는 14세 미만이면 법정대리인 동의를 요구합니다 [공식]

**Why it happens:**
「위치 = 개인정보」로만 보고 개인정보 보호법 틀 안에서 끝냅니다. 신고는 사이트 밖의 일이라 웹 작업 목록에서 빠집니다.

**How to avoid:**
- 「위치기반서비스 이용약관」 페이지를 별도 URL로 만들고, 위 목록을 체크리스트로 씁니다. 약관 게시만으로 신고나 앱 안의 동의를 대신할 수 없다는 점을 마일스톤 인수 항목에 적습니다.
- **연락처 충돌:** 제19조는 「전화번호 등 연락처」를 적으라고 합니다. 이메일만 공개하기로 한 결정(`PROJECT.md`)과 부딪힐 수 있으니, 사업자 정보를 받을 때 전화번호 공개 여부도 함께 묻습니다.
- 신고 여부, 위치정보사업 등록 대상인지, 소상공인 특례를 적용받는지는 사이트에서 결정하지 않습니다. 사용자 확인 항목으로 올립니다.

**Warning signs:**
- 사이트에 「위치기반서비스」라는 단어가 없습니다.
- 약관에 확인자료 보유 기간이 비어 있거나 「필요한 기간」처럼 막연합니다.

**Phase to address:** 법적 본문(위치), 사업자 표시(전화번호 결정)

---

### Pitfall 7: `CLAUDE.md` 규칙이 이번 결정과 반대라서 다음 세션이 되돌림

**What goes wrong:**
`CLAUDE.md`에는 지금도 다음 규칙이 있습니다.
- 「이메일 수집 폼 없음. … 연락처 이메일도 표시하지 않습니다 (법적 페이지 포함)」
- 「영문 `RunningPencil`은 쓰지 않고」
- 「본문·`<html lang>` 모두 `ko`」
- 「빌드 시스템 없음」

이번 마일스톤은 이 네 가지를 모두 뒤집습니다(`PROJECT.md` Key Decisions). 규칙을 늦게 고치면 이후 AI 세션이나 기여자가 「규칙 위반」으로 보고 지원 이메일, 영문 이름, 영문판을 지우거나 고칠 수 있습니다.

**Why it happens:**
문서 갱신을 마지막 「정비」 단계로 미룹니다(`PROJECT.md` Active의 마지막 항목).

**How to avoid:**
- 규칙을 뒤집는 첫 커밋에서 `CLAUDE.md`의 해당 문장도 함께 고칩니다. 마일스톤 첫 단계에서 바뀐 방침 4개를 먼저 반영해도 됩니다.
- 새 마크다운 문서를 추가하면 `_config.yml`의 `exclude`에도 적는다는 기존 규칙을 지킵니다.

**Warning signs:**
- `grep -n "표시하지 않습니다\|쓰지 않고" CLAUDE.md`가 사이트 현실과 다른 문장을 찾아냅니다.

**Phase to address:** 사이트 정비. 실제로는 마일스톤 첫 단계에 함께 처리합니다.

---

### Pitfall 8: 공개한 지원 이메일이 실제로 받거나 답하지 못함

**What goes wrong:**
도메인 주소를 메일 라우팅으로 업무 메일에 전달하는 구성(`PROJECT.md`)은 조용히 깨지기 쉽습니다.
- MX·TXT를 바꾸다가 기존 레코드(GitHub Pages의 A/AAAA, Search Console TXT)를 덮어씁니다.
- SPF 레코드를 두 개 만들어 SPF가 `permerror`가 됩니다. RFC 7208은 SPF 레코드를 하나만 허용한다고 기억하지만 원문은 확인하지 못했습니다 [확인 필요: RFC 7208 4.5절].
- 전달된 메일이 받는 쪽 스팸함으로 갑니다.
- 받는 것만 되고 `support@runningpencil.com`으로 보낼 수 없어, 답장이 업무 주소로 나갑니다.
- **Apple 비공개 릴레이**: Apple로 로그인하면서 이메일을 가린 사용자에게는 등록되지 않은 도메인의 메일이 전달되지 않습니다. Apple Developer의 "Sign in with Apple for Email Communication"에 보내는 도메인이나 주소를 등록하고 SPF 또는 DKIM을 통과해야 합니다 [공식·요약: Apple Account Help. 반송 동작 자체는 커뮤니티 출처].
- Apple 1.5는 "accurate and up-to-date contact information"을 요구합니다 [공식]. 한국 법령상 열람 요구는 시행령이 정한 기간 안에 처리해야 하는데, 기간은 확인하지 못했습니다 [확인 필요: 개인정보 보호법 시행령 제41조]. 메일이 유실되면 그 기한을 넘깁니다.

**Why it happens:**
DNS 설정은 사용자가 따로 하고, 사이트 작업은 주소 문자열만 넣고 끝냅니다. 받는 경로만 시험하고 보내는 경로는 시험하지 않습니다.

**How to avoid:**
- 사이트에 주소를 공개하기 전에 확인합니다: Gmail, 네이버 메일, iCloud, Outlook에서 각각 보내기 → 도착(받은편지함인지) → 업무 메일에서 답장 → 원래 발신자의 받은편지함에 도착.
- Apple 비공개 릴레이 주소(`…@privaterelay.appleid.com`)로 보내기를 시험합니다. 실패하면 Apple Developer에 보내는 주소를 등록합니다.
- DNS를 바꾸기 전과 후의 전체 레코드를 기록해 둡니다. `dig runningpencil.com MX TXT A AAAA`로 비교합니다.
- 메일 라우팅을 하려고 네임서버를 옮기는 경우(예: Cloudflare Email Routing은 Cloudflare DNS가 필요한 것으로 알고 있음 [확인 필요: Cloudflare 문서]), GitHub Pages 레코드를 「DNS only」로 둡니다. 프록시를 켜면 GitHub의 HTTPS 인증서 발급이 막힌다는 사례가 많습니다 [커뮤니티]. 특정 업체는 정하지 않았으니 이 내용은 예시로만 봅니다.
- 이메일을 JS나 이미지로 숨기지 않습니다. Play 심사자와 크롤러가 텍스트로 볼 수 있어야 합니다. 스팸은 받는 쪽 필터로 처리합니다.

**Warning signs:**
- 시험 메일이 5분 안에 오지 않거나 스팸함에 있습니다.
- `dig TXT runningpencil.com`에 `v=spf1`이 두 줄 나옵니다.
- GitHub Pages 설정에서 「Enforce HTTPS」가 회색으로 바뀌었습니다.

**Phase to address:** 지원·연락. DNS 작업은 도메인 인증과 같은 시점에 함께 계획합니다.

---

### Pitfall 9: 사업자 정보 오타·약칭, 그리고 페이지마다 다른 값

**What goes wrong:**
카카오 비즈니스 정보 심사는 「운영 서비스와 디벨로퍼스 앱이 일치하는지」를 봅니다. 서비스 화면의 사업자 정보가 「비즈 앱 및 사업자등록증과 동일한 정보여야」 한다는 운영진 답변이 있습니다 [커뮤니티: 데브톡]. 푸터에 그대로 보일 수 없으면 이용약관 URL로 사업자와 서비스의 관계를 증빙하라는 안내도 있습니다 [커뮤니티: 데브톡 FAQ]. 푸터에 사업자등록번호가 반드시 있어야 하는지는 공식 출처로 확인하지 못했습니다 [확인 필요: 카카오디벨로퍼스 운영정책 원문].
현재 헤더·푸터는 4개 파일에 복사돼 있습니다(`CONCERNS.md`). 페이지가 늘수록(영문판, 지원 페이지, 위치 약관) 한 곳만 고쳐 값이 갈라질 위험이 커집니다.

**Why it happens:**
「슬림펌킨」처럼 줄여 쓴 이름을 쓰거나 사업자번호를 손으로 옮깁니다. 공통 블록 단일화보다 사업자 정보를 먼저 넣습니다.

**How to avoid:**
- 공통 블록 단일화를 사업자 정보 추가보다 먼저 합니다. 푸터는 한 파일에만 있어야 합니다.
- 값은 사업자등록증 원문에서 복사합니다. 상호 표기(「주식회사 슬림펌킨」, 「(주)슬림펌킨」, 「슬림펌킨」)는 카카오 비즈 앱에 등록한 값과 같게 맞춥니다. 법적 페이지의 `(이하 "회사")` 주체도 같은 문자열로 씁니다.
- 통신판매업 신고번호는 신고한 경우에만 적습니다. 지어 넣지 않습니다 [확인 필요: 인앱 결제나 굿즈 판매가 있으면 통신판매업 신고 대상인지].
- 대표자 자택이 사업장 주소이면 공개 부담이 있다는 점을 사용자에게 알립니다. 다만 카카오 대조 때문에 사업자등록증과 다른 주소는 쓸 수 없습니다.

**Warning signs:**
- `grep -rho "사업자등록번호[^<]*" --include=*.html . | sort -u`가 두 줄 이상입니다.
- 사업자번호 형식이 `NNN-NN-NNNNN`이 아니거나, 국세청 사업자 상태 조회 결과와 다릅니다.

**Phase to address:** 공통 블록 단일화 → 사업자 표시 (이 순서로)

---

### Pitfall 10: Google 도메인 소유권·OAuth 브랜드 설정의 함정

**What goes wrong:**
- **브랜드 검증이 필요한 조건:** External이고 Published인 앱이 동의 화면에 로고나 표시 이름을 보이려 할 때입니다. 민감·제한 범위 검증과는 다른 절차입니다 [공식]. 기본 로그인만 쓰면 검증 없이 출시할 수 있을 수 있으나, 그때 동의 화면이 어떻게 보이는지는 확인이 필요합니다 [확인 필요: Google Cloud Console 브랜딩 화면 안내].
- **홈페이지·처리방침 요건:**
  - 홈페이지는 로그인 없이 공개돼 있고 앱과의 관련성이 분명해야 합니다. Play 스토어 등록정보나 Facebook 페이지는 홈페이지로 인정하지 않습니다 [공식]
  - 처리방침은 홈페이지와 같은 도메인에 있어야 하고, Google 사용자 데이터 처리를 밝혀야 합니다 [공식]
  - 동의 화면과 자격 증명에 연결된 모든 도메인은 Search Console에서 소유권을 확인받아야 하며, 확인한 계정이 프로젝트에 연결돼 있어야 합니다 [공식]
- **Firebase가 자동으로 넣는 도메인:** Firebase 프로젝트는 `<project>.firebaseapp.com`을 승인 도메인에 넣습니다. 이 도메인은 DNS 소유권을 증명할 수 없어 검증이 막힌 사례가 있습니다 [커뮤니티].
- **사라지는 인증:** Search Console을 HTML 파일이나 meta 태그로 인증하면, 리팩터 중 「참조되지 않는 파일」 정리나 `<head>` 공통화에서 지워져 인증이 풀릴 수 있습니다 [확인 필요: Search Console의 재확인 동작].
- 2026년에도 「홈페이지가 앱 목적을 설명하지 않음」, 「이름 불일치」 판정이 반복되고 Trust & Safety 메일이 오지 않는다는 포럼 글이 많습니다 [커뮤니티].

**Why it happens:**
Search Console을 가장 쉬운 방법(파일 업로드)으로 인증합니다. Firebase 기본 설정을 그대로 둡니다. 페이지가 확정되기 전에 검증을 신청합니다.

**How to avoid:**
- Search Console은 DNS TXT로 「도메인 속성」을 인증합니다(방식 선택은 권장이며 Google 요건은 아님). 파일 방식을 써야 한다면 그 파일을 `CLAUDE.md`에 「지우지 말 것」으로 적습니다.
- 동의 화면의 홈페이지, 처리방침, 약관 URL은 홈페이지 푸터의 링크와 글자까지 같게 합니다(끝 슬래시 포함).
- 브랜드 검증은 법적 본문과 이름 표가 확정되고 「임시」 문구를 없앤 뒤에 한 번만 신청합니다.
- 기본 로그인만 쓴다면 검증 신청 자체가 필요한지 먼저 판단합니다(로고 표시가 필요할 때만).

**Warning signs:**
- Search Console 「소유권 확인」 화면의 방법이 「HTML 파일」이거나 「HTML 태그」입니다.
- 승인 도메인 목록에 소유권을 확인할 수 없는 도메인이 있습니다.

**Phase to address:** 도메인 인증, 제출 체크리스트

---

### Pitfall 11: Jekyll로 공통 블록을 뽑다가 생기는 GitHub Pages 함정

**What goes wrong:**
- **front matter를 붙이면 그 파일 전체가 Liquid 처리됩니다** [확인 필요: Jekyll 문서 Front Matter 절]. 인라인 JS, CSS, SVG에 `{{`나 `{%`가 있으면 내용이 사라지거나 빌드가 깨집니다. 현재 HTML 4개는 front matter가 없어 그대로 복사되고 있고, `{{`·`{%`는 0건입니다(2026-11-14 `grep`). 지금은 위험이 없지만, 앞으로 인라인 스크립트에 템플릿 문법을 쓰면 생깁니다.
- **로컬 미리보기가 거짓말을 합니다.** `python3 -m http.server`(`CLAUDE.md`의 미리보기 방법)는 include를 풀지 않습니다. 로컬과 라이브 결과가 달라집니다.
- **`.nojekyll` 함정:** 점으로 시작하는 폴더(`.well-known`)를 살리려고 `.nojekyll`을 넣으면 Jekyll이 꺼지면서 `_config.yml`의 `exclude`도 무시되는 것으로 봅니다 [확인 필요: GitHub Pages 문서의 `.nojekyll` 설명. Jekyll 처리 자체를 건너뛰므로 `exclude`가 적용될 단계가 없음]. 그러면 `CLAUDE.md`, `README.md`가 사이트에 공개됩니다. 현재 `_config.yml` 주석이 바로 이 노출을 막으려고 둔 설정입니다. 점 폴더는 `include: [".well-known"]`로 살리는 것이 안전합니다 [커뮤니티].
- `_`로 시작하는 파일과 폴더는 출력되지 않습니다 [확인 필요: Jekyll 문서]. `exclude`를 직접 적으면 기본 제외 목록이 사라집니다(현재 `_config.yml` 주석이 `CNAME`에 대해 같은 내용을 적어 둠).
- 빌드가 실패하면 새 내용이 배포되지 않습니다. 실패 알림을 놓치면 「고쳤는데 라이브는 그대로」가 됩니다 [확인 필요: GitHub Pages 빌드 실패 시 이전 배포가 남는 동작].

**Why it happens:**
「빌드 없음」에서 「Jekyll 사용」으로 바뀌는 걸 작은 변경으로 봅니다.

**How to avoid:**
- 방식을 정할 때 「로컬에서 라이브와 같은 결과를 보는 방법」을 함께 정합니다(`bundle exec jekyll serve` + `github-pages` gem, 또는 GitHub Actions 빌드 산출물 확인).
- 리팩터 전후로 모든 공개 URL의 HTTP 상태와 본문 해시를 비교합니다(Pitfall 4).
- 인라인 스크립트가 있는 `index.html`은 Liquid를 피하도록 `{% raw %}`로 감싸거나 include 범위를 head·헤더·푸터로만 제한합니다.
- `.nojekyll`은 쓰지 않습니다.

**Warning signs:**
- 라이브에서 `https://runningpencil.com/CLAUDE.md`가 200을 돌려줍니다.
- 라이브 HTML에 `{% include` 문자열이 그대로 보입니다(Liquid 미처리).
- GitHub의 Pages 빌드 실패 메일이나 Actions 실패가 있습니다.

**Phase to address:** 공통 블록 단일화(shared-layout refactor)

---

### Pitfall 12: 한국어판과 영문판의 내용이 갈라지고, 콘솔마다 다른 언어판을 등록함

**What goes wrong:**
- 한국어 처리방침만 고치고 영문판은 옛 내용이 남습니다. 날짜, 항목, 수탁자 목록이 달라집니다.
- Google, Meta, LINE 심사자는 영문을 읽을 가능성이 큽니다. 그런데 Google은 홈페이지에 처리방침 링크를 두고 "this link should match the link you added on your OAuth consent screen configuration"이라고 요구합니다 [공식: support.google.com/cloud/answer/13464321]. 동의 화면에 `/en/privacy-policy/`를 넣으면 홈페이지에서도 그 URL로 가는 링크가 보여야 합니다.
- 두 판이 충돌할 때 어느 쪽이 우선인지 정하지 않습니다.

**Why it happens:**
번역을 일회성 작업으로 봅니다. 페이지 쌍을 묶는 장치가 없습니다.

**How to avoid:**
- 한국어 본문이 확정된 뒤에 번역합니다. 두 판의 조항 번호와 구조를 1:1로 맞추고, 시행일과 최종 수정일을 같게 둡니다.
- 영문판에 「국문과 영문이 다르면 국문이 우선」 조항을 둡니다.
- 각 페이지에 상대 언어판 링크를 두고 `lang="en"`, `hreflang`을 설정합니다. 랜딩 푸터에는 한국어와 영문 법적 링크를 모두 둡니다(Google 링크 일치용).
- 「URL 등록 대장」에 콘솔마다 등록한 언어판을 적습니다. 카카오·네이버는 한국어, Google·Meta·LINE·Apple은 영문을 권장합니다.

**Warning signs:**
- 한국어 처리방침의 `<h2>` 수와 영문판 `<h2>` 수가 다릅니다.
- 두 판의 「최종 업데이트」 날짜가 다릅니다.

**Phase to address:** 영문판(i18n). 법적 본문 확정 후에 진행합니다.

---

## Technical Debt Patterns

| Shortcut | Immediate Benefit | Long-term Cost | When Acceptable |
|----------|-------------------|----------------|-----------------|
| 공통 블록을 파일마다 복사 유지 | 빌드 없이 바로 편집 | 사업자 정보·링크·언어 전환이 페이지마다 갈라짐(Pitfall 9) | 페이지 4개까지만. 사업자 정보·영문판을 넣기 전에 끝내야 함 |
| 법적 페이지 Tailwind Play CDN 유지 | 클래스만 쓰면 바로 반영 | 버전 고정 없는 런타임 스크립트이고 Tailwind가 프로덕션 비권장으로 밝힘(`CONCERNS.md`). CDN 장애·변경 시 심사 대상 페이지 스타일 붕괴. 본문은 HTML에 있어 읽을 수는 있음 | 심사 제출 전까지만 |
| 「최종 업데이트」 날짜 하드코딩 | 단순함 | 본문을 고치고 날짜를 안 바꿈. 이전 판을 남기지 않으면 변경 이력을 증명할 수 없음 | 이전 판 보관(예: `/privacy-policy/2026-10-31/`)과 함께라면 허용 [확인 필요: 처리방침 작성지침의 변경 이력 공개 권고] |
| Search Console HTML 파일 인증 | DNS 접근 없이 바로 인증 | 정리 작업 중 삭제되면 인증이 풀림 | DNS 접근이 불가능할 때만. `CLAUDE.md`에 보호 표시 |
| `noindex`를 법적 페이지에 유지 | 임시본이 검색되지 않음 | 사용자가 검색으로 처리방침을 찾지 못함. 심사 크롤러에 미치는 영향은 확인하지 못함 [확인 필요] | 「임시」 문구를 없앨 때 함께 다시 결정. `robots.txt`로 막는 것은 하지 않음 |
| `main` 푸시 = 즉시 배포, CI·HTML 검증·링크 검사 없음(`CONCERNS.md` 「커밋 = 배포」) | 커밋 한 번으로 반영 | 심사가 열려 있는 동안 깨진 마크업, 404 링크, 빠진 푸터가 그대로 심사자에게 보임. 감지는 배포 후 수동 확인뿐 | 푸시 전 로컬 미리보기와 링크 검사(예: 저장소 루트에서 정적 서버 + `curl`로 URL 등록 대장 전체 200 확인)를 체크리스트로 강제할 때만. 제출 직전·심사 중에는 변경을 묶어 한 번에, 가능하면 심사 진행 중에는 푸시하지 않음. 필요하면 GitHub Actions로 HTML 검증·링크 검사 추가 (영역: 사이트 정비, 제출 체크리스트) |
| 데이터 목록 없이 처리방침부터 작성 | 빨리 초안이 나옴 | 처리방침·Data safety·개인정보 라벨·동의항목이 서로 어긋남(Pitfall 5) | 허용 안 함 |

## Integration Gotchas

| Integration | Common Mistake | Correct Approach |
|-------------|----------------|------------------|
| 카카오 비즈 앱 전환 | 출시 전 앱인데 사이트 URL만 내고 끝냄 | 화면 흐름 캡처·기획서를 첨부합니다. 캡처의 계정·개인정보는 마스킹하고, 반려 사유별 조치는 추가 정보란에 적습니다 [커뮤니티: 데브톡 FAQ] |
| 카카오 동의항목 | 필수/선택 설정이 실제 가입 화면과 다름. 처리방침에 카카오를 수탁자로 적음 | 동의항목 설정을 데이터 목록과 맞추고, 카카오는 「제공받는 곳」으로만 적습니다 [커뮤니티] |
| 네이버 로그인 사전 검수 | 같은 서비스 URL로 이미 **승인된** 앱이 있는데 새 앱으로 검수를 신청함. 현재 dev 앱은 검수 전이라 해당하지 않지만, 하나를 승인받은 뒤 다른 앱을 만들면 해당함 | 이 경우 기존 승인 앱을 쓰라는 안내가 옵니다. 이용자 식별자는 앱마다 다르므로 어느 앱을 운영용으로 승인받을지 처음에 정합니다 [공식: 검수 가이드 FAQ 4.3] |
| 네이버 로그인 사전 검수 | 이름·이메일 등 추가 정보를 「혹시 몰라」 선택함. 가입 중 별도 비밀번호를 요구함 | 실제 활용 화면이 없는 항목은 권한을 회수합니다. 별도 비밀번호를 요구하면 반려됩니다 [공식] |
| Google OAuth | 동의 화면 URL과 홈페이지 링크의 문자열이 다름(`http`/`https`, 끝 슬래시, `/en/`) | 「URL 등록 대장」의 문자열을 그대로 씁니다. 두 링크는 같아야 합니다 [공식: answer/13464321] |
| Google Search Console | URL 접두어 속성만 인증해 `www`나 하위 경로가 빠짐 | DNS TXT 도메인 속성으로 인증합니다(권장). 인증한 계정을 GCP 프로젝트에 연결합니다 [공식: 계정 연결 요건. Owner/Editor 표현은 공식·요약] |
| Meta(Facebook 로그인) | Data Deletion Instructions URL을 비워 두거나, 처리방침에 삭제 요청 방법이 없음 | 둘 다 채웁니다. 콜백 방식을 쓸 때만 HTTPS, JSON 응답, 상태 URL 요건이 붙습니다 [공식]. 연례 데이터 사용 점검 때 URL이 깨져 있으면 제한된다는 말이 있습니다 [확인 필요] |
| LINE 로그인 | 이메일 권한 신청 시 증빙 화면이 없음 | 이메일을 왜 수집하고 어디에 쓰는지 사용자에게 설명하는 화면의 캡처가 필요합니다. 처리방침 URL은 인증 provider일 때 필수라고 문서가 밝힙니다 [커뮤니티: LINE 문서의 검색 요약. 원문 재확인 필요] |
| LINE 로그인 | 채널을 「Developing」 상태로 둔 채 출시 | 공개 전에 「Published」로 바꿉니다 [커뮤니티]. 동의 화면의 provider 이름이 이름 표와 같은지 확인합니다 [확인 필요] |
| App Store Connect | Support URL이 처리방침이나 티저 랜딩을 가리킴 | 연락 방법이 맨 위에 보이는 `/support/`를 가리킵니다(1.5) [공식] |
| Google Play 계정 삭제 URL | 앱 안 경로만 안내하는 페이지를 등록 | 웹 요청 경로, 앱·개발자 이름, 삭제·보존 항목을 담습니다 [공식] |
| Apple 비공개 릴레이 | 지원 메일 답장이 사용자에게 도착하지 않음 | Apple Developer에 보내는 도메인을 등록하고 SPF/DKIM을 맞춥니다 [공식·요약] |
| GitHub Pages 사용자 지정 도메인 | DNS를 옮기거나 `CNAME` 파일을 지운 뒤 도메인이 풀림 | `slimpumpkin.github.io/<repo>/`로 서빙되면 절대 경로와 등록 URL이 모두 깨집니다(`CONCERNS.md`). DNS 작업 뒤 「Enforce HTTPS」와 `curl -sI`로 확인합니다. 인증서가 다시 발급되기까지 시간이 걸릴 수 있습니다 [공식·요약: GitHub 문제 해결 문서는 최대 1시간] |

## Performance Traps

정적 사이트이고 트래픽이 작아서, 규모 문제보다 심사 시점의 안정성 문제가 실질적입니다.

| Trap | Symptoms | Prevention | When It Breaks |
|------|----------|------------|----------------|
| 법적 페이지의 렌더 차단 Tailwind 런타임 | 느린 모바일 회선에서 흰 화면, 스타일이 늦게 입혀짐(FOUC), 콘솔 경고 | 정적 CSS로 바꿈 | CDN 지연·장애·버전 변경 시. 심사자 환경은 통제할 수 없음 |
| 심사 중 잦은 푸시 | 고친 내용이 라이브에 늦게 반영되거나 빌드가 큐에 쌓임 | 제출 직전에는 변경을 묶어 한 번에 배포 [확인 필요: GitHub Pages 빌드 한도] | 반려 대응으로 짧은 시간에 여러 번 수정할 때 |

## Security Mistakes

| Mistake | Risk | Prevention |
|---------|------|------------|
| 지원 주소 도메인에 DMARC·SPF 정책이 없음 | 공격자가 `support@runningpencil.com`을 사칭해 「계정 삭제 확인」 피싱을 보냄 | 라우팅 업체가 요구하는 SPF를 하나로 합치고 DMARC 레코드를 둡니다(처음에는 `p=none` 관찰부터) [확인 필요: 라우팅 업체 문서] |
| 삭제 요청 메일로 본인 확인을 과하게 받음 | 비밀번호나 신분증을 메일로 받으면 처리 부담과 유출 위험이 생김 | 페이지에 「비밀번호·신분증을 보내지 마세요」라고 쓰고, 로그인 제공자와 닉네임으로 대조합니다 |
| 서드파티 스크립트에 SRI·버전 고정 없음 | CDN 쪽 변경이 법적 페이지에서 그대로 실행됨 | Tailwind 런타임 제거. Pretendard는 버전 고정이 이미 돼 있고 `integrity` 추가를 검토합니다 |
| 미추적 파일·내부 문서가 공개됨 | `favicon/app-icon-*.png` 같은 미사용 파일, `.nojekyll` 실수 시 `CLAUDE.md` 노출 | `git add .` 대신 파일을 지정해 추가합니다. 라이브에서 `/CLAUDE.md`, `/README.md`가 404인지 확인합니다 |
| 사업자 주소·전화번호 공개 | 1인 사업자는 자택 주소와 개인 번호가 노출됨 | 법령·심사가 요구하는 범위를 사용자와 정하고, 사업장 주소와 전화번호를 따로 마련할지 결정합니다 |

## UX Pitfalls

| Pitfall | User Impact | Better Approach |
|---------|-------------|-----------------|
| 삭제 요청 방법이 처리방침 본문 깊숙이 있음 | 사용자와 Play 심사자가 경로를 찾지 못함(Play는 "prominently featured" 요구) | 삭제 페이지 첫 화면에 두 경로(앱·이메일)를 둡니다 |
| 지원 페이지가 FAQ만 있고 연락처는 맨 아래 | Apple 1.5의 "easy way to contact"를 충족하지 못한다고 볼 수 있음 | 앱 이름 → 연락 이메일 → 응답 기대 시간 → FAQ 순서로 둡니다 |
| 언어 전환 링크 없음 | 영문 심사자가 한국어 페이지에서 길을 잃음 | 헤더에 KO/EN 전환을 두고, 같은 문서의 상대 언어판으로 바로 연결합니다 |
| 「임시 게시본」 같은 효력 불명 문구 | 사용자가 약관의 효력을 신뢰하지 못함 | 시행일과 변경 이력으로 대체합니다 |

## "Looks Done But Isn't" Checklist

- [ ] **처리방침:** 보호책임자(성명 또는 부서, 연락처), 위탁, 국외 이전(제28조의8 항목 전부), 자동 수집 장치, 삭제 요청 방법이 모두 있는지. `grep`으로 「책임자」, 「국외」, 「위탁」, 「거부」를 확인합니다.
- [ ] **처리방침:** 굿즈·배송 항목이 앱 저장소에서 실제로 확인된 경우에만 남아 있는지.
- [ ] **데이터 삭제 페이지:** 앱 없이 요청하는 경로, 스토어 표기 그대로의 앱·개발자 이름, 삭제·보존 항목과 기간, Facebook 연결 해제 안내가 있는지.
- [ ] **지원 페이지:** 앱 이름이 맨 위에 있고, 이메일이 텍스트로 보이며(이미지·JS 아님), 4개 메일 서비스와 Apple 릴레이로 왕복 시험을 통과했는지.
- [ ] **이름 표:** 8개 콘솔의 앱·회사 이름과 로고가 사이트 문자열과 같은지(캡처로 대조).
- [ ] **URL:** 기존 3개 한국어 URL이 그대로 200을 돌려주고, 「URL 등록 대장」의 모든 URL이 `https`, apex, 끝 슬래시 형태로 200인지.
- [ ] **푸터:** 사업자 정보가 사업자등록증과 글자까지 같고, 모든 페이지에서 한 가지 값인지.
- [ ] **위치:** 위치기반서비스 약관에 제19조 제1항 항목이 모두 있고, 신고와 등록 여부를 사용자가 확인했는지.
- [ ] **영문판:** 조항 구조, 날짜, 수탁자 목록이 한국어판과 같고 국문 우선 조항이 있는지.
- [ ] **도메인:** Search Console이 DNS TXT 도메인 속성으로 인증돼 있는지. GitHub Pages가 「Enforce HTTPS」 켜짐 상태인지.
- [ ] **Jekyll:** 라이브에서 `/CLAUDE.md`, `/README.md`, `/.planning/`이 404이고, `{% include`가 HTML에 그대로 남지 않았는지.
- [ ] **배포:** 심사 제출 전 마지막 푸시 후 URL 등록 대장의 모든 URL을 라이브에서 다시 열어 봤는지, 심사 진행 중 푸시가 없었는지.
- [ ] **임시 문구:** `grep -rn "임시 게시본"` 결과가 0인지.
- [ ] **`CLAUDE.md`:** 연락처, 영문 이름, 언어, 빌드 방침이 현재 사이트와 같은지.

## Recovery Strategies

| Pitfall | Recovery Cost | Recovery Steps |
|---------|---------------|----------------|
| 등록된 URL을 바꿔 404 발생 | MEDIUM | 옛 경로에 같은 내용의 페이지를 다시 둡니다(리디렉트보다 원본 복구를 우선). 대장에 적힌 콘솔을 모두 고치고, 심사 중이면 재심사 요청 메모에 적습니다 |
| 이름 불일치로 Google 브랜드 검증 반려 | MEDIUM | 이름 표를 기준으로 동의 화면과 홈페이지 문자열을 맞추고 재제출합니다. 판정이 남으면 Verification Center의 이의 제기 기능을 씁니다 [커뮤니티: 판정이 남는 사례 다수] |
| 카카오·네이버 반려 | LOW | 반려 사유별 조치 위치와 내용을 추가 정보란이나 소명란에 적고 재검수를 신청합니다. 네이버는 2~3영업일 안에 결과가 나옵니다 [공식] |
| 메일 라우팅 장애로 문의 유실 | HIGH | 법정 처리 기한이 걸려 있습니다. DNS를 원상 복구하고 라우팅 업체 로그로 유실 기간을 파악합니다. 그 기간 사용자에게는 앱 공지 등으로 재요청을 안내합니다 |
| `CLAUDE.md`나 내부 문서가 사이트에 공개됨 | LOW | `.nojekyll`을 제거하거나 `exclude`를 복구해 다시 배포합니다. 검색엔진 캐시 제거를 요청합니다 |
| 처리방침에 사실과 다른 수집 항목이 게시됨 | MEDIUM | 데이터 목록 기준으로 고치고 변경 이력과 이전 판을 남깁니다. Data safety와 개인정보 라벨도 함께 고칩니다 |
| 사용자 지정 도메인 해제 | MEDIUM | `CNAME`과 Pages 설정을 복구하고 DNS를 확인합니다. 「Enforce HTTPS」가 회색이면 도메인을 지웠다가 다시 넣어 인증서 발급을 다시 시작합니다 [공식·요약: GitHub 문제 해결 문서] |

## Pitfall-to-Phase Mapping

로드맵이 아직 없으므로 영역 이름으로 연결합니다. 권장 순서는 표 아래에 있습니다.

| Pitfall | Prevention Area | Verification |
|---------|-----------------|--------------|
| 3. 이름 불일치 | 심사 요건 확정·제출 체크리스트(이름 표) | 8개 콘솔 캡처와 사이트 문자열 대조 |
| 7. `CLAUDE.md` 규칙 충돌 | 사이트 정비(마일스톤 첫 단계에 선반영) | `CLAUDE.md`의 연락처·영문·언어·빌드 문장과 사이트 상태 대조 |
| 4. 등록 URL 변경 | 공통 블록 단일화, 영문판 | 리팩터 전후 URL별 HTTP 상태 비교, URL 등록 대장 |
| 11. Jekyll 함정 | 공통 블록 단일화 | 라이브에서 `/CLAUDE.md` 404, Liquid 잔여 문자열 없음, 로컬과 라이브 결과 일치 |
| 9. 사업자 정보 불일치 | 공통 블록 단일화 → 사업자 표시 | 사업자등록번호 문자열이 사이트 전체에서 한 가지인지, 국세청 조회 결과와 같은지 |
| 5. 처리방침-앱 불일치 | 법적 본문(데이터 목록 먼저) | 데이터 목록과 처리방침, Data safety, 개인정보 라벨, 동의항목을 표로 대조 |
| 6. 위치정보법 | 법적 본문(위치), 외부 인수(신고 여부) | 위치 약관에 제19조 제1항 항목이 다 있는지, 사용자 확인 기록 |
| 1. 임시·미완성 표시 | 법적 본문, 제출 체크리스트 | `grep "임시 게시본"` 0건, 서비스 소개 자료 준비 |
| 2. 웹 삭제 경로 없음 | 데이터 삭제, 지원·연락 | 앱 없이 페이지만 보고 삭제를 요청하는 시나리오 시험 |
| 8. 메일 수신·회신 실패 | 지원·연락(DNS는 도메인 인증과 함께 계획) | 4개 메일 서비스와 Apple 릴레이 왕복 시험, `dig` 비교 기록 |
| 10. Google 도메인·브랜드 | 도메인 인증, 제출 체크리스트 | Search Console 도메인 속성 인증, 동의 화면 URL과 홈페이지 링크의 문자열 일치 |
| `main` 푸시 = 배포(Technical Debt 표) | 사이트 정비, 제출 체크리스트 | 푸시 전 체크리스트 기록, 심사 기간 중 푸시 내역, 배포 후 URL 등록 대장 전체 200 확인 |
| 12. 국문·영문 불일치 | 영문판(법적 본문 확정 후) | 두 판의 조항 수와 날짜 비교, 콘솔별 등록 언어판 기록 |

**순서에 주는 영향:**
1. 이름 표, URL 등록 대장, 데이터 목록, `CLAUDE.md` 방침 갱신을 맨 앞에 둡니다. 뒤의 모든 단계가 이 세 표를 입력으로 씁니다.
2. 공통 블록 단일화(+ Tailwind 런타임 제거)는 사업자 정보, 영문판, 지원 페이지를 추가하기 전에 끝냅니다. 그래야 페이지가 늘어도 값이 갈라지지 않습니다.
3. 법적 본문(한국어, 위치 약관 포함)을 영문판보다 먼저 확정합니다.
4. 도메인 인증(DNS TXT)과 메일 라우팅 DNS 작업은 같은 시점에 한 번에 계획해 서로 덮어쓰지 않게 합니다. 사이트 작업과 병행할 수 있습니다.
5. 제출 체크리스트와 콘솔 입력은 마지막에 합니다. 브랜드 검증과 검수 신청은 「임시」 문구를 없애고 URL을 확정한 뒤에 합니다.

**단계별로 추가 조사가 필요한 곳:**
- 법적 본문: 위치정보사업 등록과 위치기반서비스사업 신고 대상 여부(법률 판단), 처리방침 작성지침 2025 원문의 필수·권장 구분, 시행령의 열람 처리 기한과 확인자료 보존 기간
- 데이터 삭제: Meta Data Deletion Instructions 페이지 내용 기준(공식 문서에 없음)
- 영문판·제출: LINE provider와 처리방침 URL 요건 원문, Google 기본 로그인 범위만 쓸 때 브랜드 검증이 필요한지

## Sources

**공식 (직접 열람)**
- Apple App Store Review Guidelines 1.5, 2.1(a), 4.8, 5.1.1(i)·(v): https://developer.apple.com/app-store/review/guidelines/
- Google Play, 계정 삭제 요건: https://support.google.com/googleplay/android-developer/answer/13327111
- Google, 브랜드 검증 제출: https://developers.google.com/identity/protocols/oauth2/production-readiness/brand-verification
- Google Cloud, App Identity & Branding(이름·로고 실패 사유): https://support.google.com/cloud/answer/13804963
- Google Cloud, 홈페이지·처리방침 링크 일치 요건: https://support.google.com/cloud/answer/13464321
- Meta, Data Deletion Request Callback: https://developers.facebook.com/docs/development/create-an-app/app-dashboard/data-deletion-callback
- 네이버 로그인 사전 검수 가이드: https://developers.naver.com/docs/login/verify/verify.md
- 네이버 로그인 개발가이드(사전 검수 요청 절): https://developers.naver.com/docs/login/devguide/devguide.md
- 위치정보의 보호 및 이용 등에 관한 법률(현행 2025.10.01) 제5·9·9의2·16·18·19·25·40·42조: https://www.nepla.ai/law/위치정보의%20보호%20및%20이용%20등에%20관한%20법률 (법령 원문 미러. 국가법령정보센터에서 재확인 권장)
- 개인정보 보호법 제26·28조의8·30·31·35조: https://www.nepla.ai/law/개인정보%20보호법 (같음)

**공식 문서, 검색 요약으로만 확인 ([공식·요약], 원문 재확인 필요)**
- Apple, Offering account deletion in your app: https://developer.apple.com/support/offering-account-deletion-in-your-app
- Apple, Configure private email relay service: https://developer.apple.com/help/account/configure-app-capabilities/configure-private-email-relay-service/
- Google Play, 사용자 데이터 정책(처리방침 주체·연락처): https://support.google.com/googleplay/android-developer/answer/10144311
- GitHub Docs, 사용자 지정 도메인 문제 해결(HTTPS 최대 1시간, 도메인 재등록): https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/troubleshooting-custom-domains-and-github-pages
- Google, OAuth 승인 도메인·Search Console 계정 연결(Owner/Editor 표현): https://developers.google.com/identity/protocols/oauth2/production-readiness/policy-compliance

**커뮤니티·2차 (LOW, 근거로만 사용)**
- 카카오 데브톡 「추가 기능 신청이 반려되었습니다. FAQ」(운영진): https://devtalk.kakao.com/t/faq/133989
- 카카오 데브톡 동의항목·비즈 앱 반려 사례: https://devtalk.kakao.com/t/topic/151330, https://devtalk.kakao.com/t/topic/151634
- Google 개발자 포럼 브랜드 검증 지연·이름 불일치 사례(2026): https://discuss.google.dev/t/oauth-branding-verification-stuck-app-name-doesnt-match-homepage-everything-confirmed-matching/381451
- Firebase 도메인 검증 사례: https://discuss.google.dev/t/oauth-verification-stuck-on-homepage-requirements-firebase-web-app-domain-not-recognized/333105
- Meta 처리방침 URL 「invalid page」 반려 사례: https://developers.secure.facebook.com/community/threads/978011013701521
- LINE Login 시작하기(이메일 권한 신청·처리방침 URL): https://developers.line.biz/en/docs/line-login/getting-started/
- Jekyll 점 폴더 제외 사례: https://github.community/t/unable-to-access-resources-in-folder-with-name-starting-with/10505
- Cloudflare 프록시와 GitHub Pages HTTPS: https://community.cloudflare.com/t/github-pages-keep-saying-it-cant-enforce-https/397570
- 개인정보 처리방침 작성지침 2025 개정 해설: https://www.daeryunlaw.com/newsletter/news/151

**저장소 내부 근거**
- `.planning/PROJECT.md`, `.planning/codebase/CONCERNS.md`, `CLAUDE.md`, `_config.yml`, `privacy-policy/index.html`, `data-deletion/index.html`, `index.html`(텍스트 추출)

---
*Pitfalls research for: 한국 모바일 앱 공식 웹사이트의 소셜 로그인·앱 스토어 심사 대응 (GitHub Pages 정적 사이트)*
*Researched: 2026-11-14*
