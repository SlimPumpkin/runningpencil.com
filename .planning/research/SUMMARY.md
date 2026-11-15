# Project Research Summary

**Project:** 러닝펜슬 웹사이트 (runningpencil.com) — 1단계: 티저 유지 + 심사 대응
**Domain:** 빌드 없는 GitHub Pages 정적 사이트를 소셜 로그인 6곳(카카오·네이버·Google·Apple·Facebook·LINE)과 스토어 2곳(App Store·Google Play) 심사용 공식 웹사이트로 정비 (한국어 기본 + 영문판, 한국 법령 대응)
**Researched:** 2026-11-14
**Confidence:** MEDIUM

> 상세 근거는 `STACK.md`·`FEATURES.md`·`ARCHITECTURE.md`·`PITFALLS.md`에 있습니다. 이 문서는 네 파일을 합쳐 로드맵 결정에 필요한 결론과 충돌 지점만 정리합니다. REQ-ID 후보(`SITE`·`PRIV`·`DEL`·`SUP`·`BIZ`·`LOC`·`TERM`·`I18N`·`SUBMIT`)는 FEATURES.md를 따릅니다.

## Executive Summary

> **U12 결정 (2026-11-14):** 슬림펌킨 업무 메일은 Google Workspace로 확정됐고, 이 구간에 나오는 ImprovMX 안은 채택하지 않았습니다. 현재 절차는 `.planning/baseline/USER-TASKS.md`를 따릅니다. 아래 본문은 조사 당시의 기록입니다.

이 프로젝트는 새 제품이 아니라 **심사 증빙용 정적 사이트**입니다. 심사자가 보는 것은 다섯 가지로 좁혀집니다. ① 앱을 설명하는 홈페이지(로그인 페이지만 있으면 안 됨) ② 같은 도메인의 공개 HTML 개인정보처리방침 ③ 앱 없이 웹에서 시작할 수 있는 삭제 요청 경로 ④ 실제로 연락되는 연락처 ⑤ 사이트·처리방침 내용과 앱 실제 동작의 일치. 나머지는 대부분 콘솔에 입력하는 값입니다. 여기에 한국 법령(개인정보 보호법 제30조의 처리방침 기재사항, 위치정보법 제12·19조의 위치기반서비스 이용약관 공개)이 웹사이트에 직접 의무를 더합니다.

권장 접근은 다음과 같습니다. **GitHub Pages에 이미 들어 있는 Jekyll(3.10.0)의 `_layouts`/`_includes`/`_data`로 공통 블록과 사업자 정보를 한 곳에 모으고**(운영 쪽 새 의존성 0, `main` 푸시 = 배포 유지), 법적 페이지의 Tailwind Play CDN은 **손으로 쓴 일반 CSS**로 바꿉니다(쓰는 유틸리티가 약 45개뿐). 한국어 URL(`/privacy-policy/`·`/terms/`·`/data-deletion/`)은 고정하고 `/support/`를 새로 두며, 영문은 `/en/` 아래에 병렬로 추가합니다. DNS는 가비아에 그대로 두고 Search Console은 **도메인 속성 + DNS TXT**, 지원 메일은 **ImprovMX 무료**(MX 2개 + SPF 1개)로 전달합니다. 순서는 "구조 리팩터(출력 동일) → 정적 CSS → 사실값 슬롯 → 지원 페이지 → 한국어 본문 재작성 → 위치약관 → 영문판 → 제출 체크리스트"입니다.

가장 큰 위험은 기술이 아니라 **내용 불일치와 외부 결정 대기**입니다. 현재 사이트·처리방침·약관·삭제 안내에 앱 범위 밖인 **포인트·굿즈·배송지·코스북**이 적혀 있습니다. 처리방침에는 보호책임자·위탁·국외 이전·자동 수집 장치가 없고, 삭제 안내에는 웹 요청 경로가 없습니다. 또 사업자 정보·지원 이메일·영문 서비스명·전화번호 공개 여부·위치정보법 분류는 모두 사용자나 법률 판단이 줘야 하는 값입니다. 이를 **render-if-present 사실값 슬롯**과 **이메일 게이트**(수신 확인 전에는 주소를 공개·등록하지 않음)로 구조 작업과 분리합니다. 처리방침은 앱 저장소에서 만든 **데이터 목록**을 단일 원본으로 씁니다.

## Key Findings

### Recommended Stack

> **U12 결정 (2026-11-14):** 슬림펌킨 업무 메일은 Google Workspace로 확정됐고, 이 구간에 나오는 ImprovMX 안은 채택하지 않았습니다. 현재 절차는 `.planning/baseline/USER-TASKS.md`를 따릅니다. 아래 본문은 조사 당시의 기록입니다.

운영 배포 경로는 바꾸지 않습니다. 저장소는 이미 배포 때 Jekyll을 거치므로(`_config.yml`), 레이아웃·include는 플러그인 허용 목록과 무관한 코어 기능으로 바로 쓸 수 있습니다. 현재 HTML 4개에 `{{`·`{%`가 없고, 빈 front matter를 붙여 빌드한 결과가 원본과 바이트 단위로 같음을 직접 확인했습니다(HIGH). 대가는 로컬 미리보기가 `python3 -m http.server`에서 `bundle exec jekyll serve --livereload`로 바뀌는 것 하나입니다.

**Core technologies:**
- **GitHub Pages 내장 Jekyll 3.10.0 / Liquid 4.0.4 (브랜치 배포)**: head·「공통」 CSS·헤더·푸터·사업자 정보·언어 전환을 한 곳에서 관리합니다. `main` 푸시 = 배포, CI 없음, 빌드 결과물 커밋 없음을 모두 지키는 유일한 방법입니다.
- **손으로 쓴 일반 CSS (`.rp-legal-*`/`.rp-doc`, 토큰은 CSS 변수)**: Tailwind Play CDN(v3.4.17)을 대체합니다. 빌드 도구가 0개이고 랜딩과 방식이 같아집니다. **Preflight 초기화 규칙을 법적 페이지 범위에 직접 옮겨야 합니다**(border 3값, `text-sm`의 line-height 포함).
- **로컬 Gemfile: `jekyll = 3.10.0` + `webrick`·`csv`·`base64`·`bigdecimal`·`logger`·`kramdown-parser-gfm`**: 로컬 Ruby 4.0.9에서는 `github-pages` gem을 설치할 수 없습니다(`commonmarker`가 Ruby < 4.0 요구). 버전을 고정하지 않으면 Jekyll 3.9.0으로 조용히 후퇴합니다 (직접 재현, HIGH).
- **가비아 DNS 유지 + ImprovMX 무료**: Cloudflare Email Routing은 네임서버를 옮겨야 해서 심사 기간 중 위험이 큽니다. 업무 메일이 Google Workspace로 확인되면 보조 도메인 방식을 검토합니다(unverified).
- **필수 설정**: `_config.yml`에 `url: "https://runningpencil.com"`을 둡니다(없으면 `hreflang`이 상대 경로가 됨). `exclude`에는 `Gemfile`·`Gemfile.lock`·`vendor/`·`.planning/`·`prepare/`를 명시합니다. 사용자 지정 `exclude`가 기본 제외 목록을 **덮어써서** Gemfile·vendor가 공개되는 것을 실험으로 확인했습니다.
- **쓰지 않을 것**: `jekyll-polyglot`(허용 목록 밖), JS 언어 자동 리디렉션, 레이아웃 이름 `default`/`page`/`home`, 전역 `permalink`, `.nojekyll`, 와일드카드 DNS, SPF 레코드 2개

### Expected Features

**Must have (table stakes — 빠지면 반려 또는 법령 위반):**
- **SITE-02 랜딩 문구 정정**: 메타·OG의 "포인트·기념 굿즈", "코스북"을 정리합니다(U10 결정 후). 모든 제공자 심사 신청보다 먼저 끝내야 합니다.
- **SITE-05 Search Console 도메인 소유권**: Google Authorized domains의 선행 조건입니다 (사용자 작업).
- **SITE-07 법적 URL 고정**: 기존 3개 + `/support/` + 위치약관 경로. GitHub Pages에는 서버 리디렉트가 없습니다.
- **SUP-01·02 `/support/` + 지원 이메일**: App Store Support URL(필수), Play 삭제 경로, Meta 삭제 요청 연락처, 보호책임자 연락처, Apple 1.2 UGC 공개 연락처의 공통 전제입니다.
- **PRIV-01~15 처리방침 재작성**: 제공자별 수신 항목, 기록 중 GPS(화면이 꺼져도 기록 중이면 수집), Firebase 각 서비스, 처리 위탁(Firebase/GCP·NCP), 국외 이전(제28조의8② 5개 항목), 안전성 조치, 보호책임자·연락처, 자동 수집 장치, 14세 미만 정책을 넣고 굿즈·배송지는 뺍니다. 로그인 제공자는 **수탁자로 쓰지 않습니다**(카카오 반려 사례).
- **DEL-01~07 삭제 안내 재작성**: 앱 없이 이메일로 요청하는 경로를 눈에 띄게 둡니다. 스토어 표기 그대로의 앱·개발자 이름, 삭제/보존 데이터 구분(공개 코스는 `creatorId`만 남은 채 유지), 실제 메뉴명 「회원탈퇴」, 소요 시간·완료 통지를 적습니다.
- **TERM-01·02 약관 재작성**: Meta Live 모드에 필수입니다. 포인트·굿즈 조항을 지우고, 코스 공개·탈퇴 후 공개 코스 유지·신고 조항을 넣습니다.
- **BIZ-01·02 사업자 표시**: 푸터에 상호·대표자·사업자등록번호·주소·연락처를 둡니다. 카카오 비즈니스 정보 심사가 대조하므로 사업자등록증과 글자까지 같아야 합니다.
- **LOC-01~04 위치기반서비스 이용약관 페이지**: 위치정보법 제12조①·제19조①. 법률 확인과 병행합니다.
- **SUBMIT-01 콘솔 입력 체크리스트**: 이름 표 + URL 등록 대장

**Should have (심사 왕복을 줄임):**
- **I18N-01 영문판** (`/en/…`, 국문 우선 조항): 공식 문서에서 영어를 요구하는 문장은 찾지 못했습니다. PROJECT.md 결정상 이번 마일스톤 Active입니다.
- **PRIV-16 제공자별 수신 항목 표**: 카카오 필수/선택 일치, 네이버 활용처, Google user data 공개를 한 표로 해결합니다.
- **DEL-08 제공자별 앵커**(`#facebook` 등): Meta Data Deletion Instructions URL용
- **SUP-04 지원 페이지 FAQ**, **SUP-05 SPF/DKIM + Apple Private Email Relay 발신 도메인 등록**
- **SITE-09 `noindex`·「임시 게시본」 문구 제거**: 「임시」 문구 제거는 사실상 필수입니다(Apple 2.1(a) 위반 소지, Pitfall 1).

**Defer (v2+):**
- SITE-08 랜딩에 실제 앱 스크린샷: 네이버·카카오가 소개 자료를 요청하면 앞당깁니다 (사이트 밖의 「서비스 소개 자료」 준비는 지금 필요).
- PRIV-17 처리방침 이전 버전 보관: 첫 개정 때
- Apple `/.well-known/` 도메인 검증 파일: `runningpencil.com`을 Services ID에 등록할 때만 (Jekyll `include:` 필요)
- 통신판매업 표시: 판매·유료 기능을 실제 도입할 때만
- 영문 랜딩(`/en/`), 실데이터 구간: 다음 마일스톤

**Anti-features:** 웹 로그인 폼, PDF/Notion 처리방침, `robots.txt` 차단, 자리표시 사실값("추후 기재"), 외부 폼 서비스(Google Forms 등 — 위탁·국외 이전 증가), 이메일만으로 삭제 받기(앱 안 탈퇴 대체 금지), 언어별로 다른 내용, JS로 이메일 조립·난독화.

### Architecture Approach

4계층 구조입니다. **사실값 계층**(`_data/company.yml`·`legal.yml`·`i18n.yml`/`nav.yml`)이 유일한 출처입니다. **공유 셸**(`head`·`common.css`·`header`·`footer`·`lang-switch` include)과 **레이아웃**(`base` → `legal`)이 이를 읽어 **페이지**(KO 랜딩, KO 문서 4~5종, EN 문서 4종)를 그립니다. 사이트 밖에는 DNS·메일 포워더·콘솔 8곳이 있고, 사이트가 책임지는 것은 URL 안정성과 내용 요건뿐입니다.

**Major components / patterns:**
1. **사실값 슬롯 (render-if-present)**: 값이 있을 때만 행을 그립니다. Liquid에서는 `""`도 참이므로 `!= blank`로 비교합니다. 구조 작업과 값 수집을 분리해 각자 배포할 수 있습니다.
2. **이메일 게이트**: 외부 주소에서 보낸 테스트 메일이 업무 메일에 도착한 뒤에만 `company.yml`에 적습니다. 이 값 하나가 푸터·`/support/`·삭제 안내·처리방침 보호책임자 4곳을 동시에 엽니다. 법적으로 빠지면 안 되는 조항이 있는 페이지는 게이트가 열릴 때까지 커밋을 보류합니다.
3. **문서 키로 언어판 짝짓기**: front matter `lang` + `ref`/`doc_key`로 짝을 찾아, 짝이 있을 때만 언어 전환 링크·`hreflang`을 만듭니다. 영문판은 `source_updated`로 번역 뒤처짐을 검사합니다.
4. **출력 보존 리팩터**: include 도입 단계는 `_site/` 산출물과 기존 HTML을 diff해 차이가 0일 때만 푸시합니다. 리팩터와 내용 변경을 한 커밋에 섞지 않습니다.
5. **시맨틱 본문 + 정적 CSS**: 본문은 클래스 없는 `h2`·`p`·`ul`·`table`을 `.rp-doc` 아래에 둡니다. 마크업 규칙은 Tailwind 제거 단계에서 한 번만 바꾸고, 이후 단계는 텍스트만 씁니다.

**Forward-compat:** `base` 레이아웃은 범용 셸로 유지하고, 「출시 예정」 문구는 랜딩 `#get`에만 둡니다. `/en/`을 법적 문서 전용으로 가정하지 않고, 배포 방식(Actions)도 바꾸지 않습니다.

### Critical Pitfalls

1. **사이트·처리방침이 앱 실제 동작과 다름 (Pitfall 5, FEATURES §1-2)**: 굿즈·포인트·배송지는 있고 보호책임자·위탁·국외 이전·자동 수집은 없습니다. → 처리방침보다 먼저 앱 저장소에서 **데이터 목록**(항목·출처·목적·저장 위치/리전·수탁자·국외 이전·보유 기간)을 만들고, 처리방침·Data safety·개인정보 라벨·동의항목을 모두 여기서 파생합니다.
2. **「임시 게시본」·미완성 표시 (Pitfall 1)**: Apple 2.1(a)와 네이버 4.1이 미완성 사이트로 반려합니다. → 재작성 때 문구를 지우고 시행일·변경 이력으로 대체합니다. 출시 전 앱이므로 카카오·네이버용 서비스 소개 자료(화면 캡처)를 사이트와 별도로 준비합니다.
3. **웹 삭제 경로 없음 + 공개 이메일이 실제로 안 받힘 (Pitfall 2·8)**: Play 반려로 바로 이어집니다. → 이메일 게이트를 두고, Gmail·네이버·iCloud·Outlook·Apple 릴레이로 왕복 시험을 합니다. DNS 변경 전후 `dig` 결과를 기록하고 SPF는 하나로 합칩니다.
4. **이름 불일치와 등록 URL 변경 (Pitfall 3·4·12)**: Google 브랜드 검증은 동의 화면 이름·홈페이지 이름·처리방침 링크 문자열이 같은지 봅니다. → 맨 앞에 **이름 표**(한글·영문 서비스명, 사업자등록증 그대로의 상호·영문 법인명)와 **URL 등록 대장**(apex·https·끝 슬래시)을 만들고, 한국어 URL은 절대 옮기지 않습니다.
5. **Jekyll 전환 함정과 `CLAUDE.md` 역행 (Pitfall 7·11)**: `exclude` 덮어쓰기로 내부 파일이 공개될 수 있습니다. `python3 -m http.server` 미리보기는 거짓 결과를 보여 주고, `.nojekyll`을 쓰면 `CLAUDE.md`가 노출됩니다. `CLAUDE.md`의 「연락처 미표시·RunningPencil 금지·ko 전용·빌드 없음」 규칙은 이번 결정과 정반대라 다음 세션이 되돌릴 수 있습니다. → 규칙을 뒤집는 **첫 커밋에서** `CLAUDE.md`를 함께 고치고, 라이브에서 `/CLAUDE.md`가 404인지 확인합니다.

추가로 **위치정보법을 처리방침 한 단락으로 끝냈다고 착각**하는 위험이 있습니다(Pitfall 6). 약관 게시만으로는 신고(제9조, 미신고 시 형사처벌)나 앱 안 동의를 대신할 수 없으므로, 신고 여부는 마일스톤 인수 항목으로 올립니다.

## 연구 간 충돌과 PROJECT.md 가정 정정

로드맵·요구사항 단계에서 한쪽을 조용히 고르지 말고 아래를 그대로 반영해야 합니다.

### PROJECT.md 가정과 공식 문서가 다른 곳

| PROJECT.md 가정 | 연구 결과 | 영향 |
|---|---|---|
| 6개 제공자 모두 「프로덕션 심사」가 있음 | **Facebook**: email·public_profile은 App Review 없이 요청할 수 있습니다. Live 전환에는 약관 URL·아이콘·카테고리·연락 이메일·데이터 삭제 URL이 필요합니다. 단 같은 Meta 문서에 "Business Verification is required to get Advanced Access" 문장이 있어 **충돌합니다 → 콘솔 확인(U9)**. **LINE**: 문서에는 Developing → Published 전환만 있고 별도 심사 여부는 나오지 않습니다(전환은 되돌릴 수 없음) | 「6곳 심사 통과」 인수 기준을 제공자별로 「심사/Live 전환/채널 공개」로 나눠 적어야 함 |
| Google OAuth 브랜드 검증이 필수 | non-sensitive scope(openid·email·profile)만 쓰면 앱 검증은 선택입니다. **동의 화면에 앱 이름·로고를 띄우려면** 브랜드 검증이 필요합니다(안 하면 도메인만 보임). 홈페이지·처리방침·약관 링크와 Search Console 확인은 여전히 필요합니다 | 브랜드 검증 신청 여부는 사용자 결정. 하더라도 「임시」 문구 제거·이름 표 확정 뒤 한 번만 |
| 네이버 검수가 처리방침 URL을 봄 | 공식 사전 검수 가이드 항목은 ① 서비스 URL 콘텐츠 ② 별도 비밀번호 요구 금지 ③ 제공 정보 활용처(통계 목적 불인정) ④ 로고·이름입니다. **처리방침은 항목에 없습니다**(2.1 「업종별 법적 요건」으로 요청받을 수는 있음) | 네이버 쪽 핵심은 홈페이지 콘텐츠와 요청 항목 최소화. 처리방침은 준비해 두는 정도 |
| LINE도 처리방침 URL이 필요 | 처리방침 URL은 **인증 제공자(certified provider)일 때만 필수**이고, 그 밖에는 선택(넣는 것 권장)입니다. 이메일 권한 신청에는 수집 목적을 설명하는 화면 스크린샷이 필요합니다 | LINE 대응은 웹보다 앱 화면 캡처가 핵심 |
| App Store 1.5 Support URL은 연락 방법(2차 출처) | ASC 공식 원문: "must lead to actual contact information (**legal address, email address, telephone number**), as may be required by local law". PIPA 제30조①6과 위치정보법 제19조①1도 「전화번호 등 연락처」를 예로 듭니다 | **「이메일만 공개」 결정과 충돌할 수 있음 → U1 전화번호 공개 여부를 사용자·법률 결정으로** |
| 위치기반서비스 이용약관은 의무 여부를 확인 후 결정 | 위치정보법 제12조①: 위치기반서비스사업자(제9조의2 신고 유예 소상공인 포함)는 이용약관을 **공개할 의무**가 있습니다. 시행령 제13조는 **홈페이지 또는 앱 첫 화면·연결 화면**을 허용하므로 홈페이지가 유일한 수단은 아닙니다. 약관에는 상호·주소·전화번호 등 연락처가 필수입니다(제19조①1). 남은 문제는 앱이 제9조 신고(위치기반서비스사업)인지 제5조 등록(위치정보사업, 법인 요건)인지입니다 | 「조건부 페이지」가 아니라 **기본 포함, 범위만 법률 확인으로 조정**하기를 권장 (FEATURES 권고) |
| 사이트가 설명하는 앱(포인트로 굿즈 교환, 코스북) | 앱 `.planning/REQUIREMENTS.md`는 현금·포인트 리워드를 Out of Scope로, 코스북·세트 뱃지를 P2-05(Phase 2·3)로 둡니다. 그런데 랜딩 메타·OG, 처리방침(배송지·전자상거래 기록), 약관 제2·4·8조, 삭제 안내에 남아 있습니다 | **U10 결정이 모든 본문 재작성과 랜딩 메타 수정을 막음.** `CLAUDE.md`·PROJECT.md의 앱 설명 문장도 함께 고쳐야 함 |
| 로그인 = 소셜 6곳 + 익명 | 앱 코드 `AccountProvider`에 **Email/Password**와 `createUserWithEmailAndPassword` 호출이 있습니다 | U5: UI 노출 여부에 따라 처리방침 항목과 네이버 「별도 비밀번호 금지」에 영향 |
| Apple은 Android·웹 흐름의 도메인 요건이 있을 수 있음 | Android Apple 로그인은 Firebase `signInWithProvider`를 쓰므로 Return URL은 Firebase 핸들러 도메인입니다. `runningpencil.com`은 필요 없을 가능성이 높습니다(검증 파일 요건은 미확인). 대신 한국 개발자는 새 Services ID에 **server-to-server notification endpoint가 필수**입니다(앱·Functions 쪽 일) | 웹 범위에서 빼고 앱 쪽 할 일로 넘김 |

### 연구 파일끼리 다른 곳 (이 문서의 판정)

> **U12 결정 (2026-11-14):** 슬림펌킨 업무 메일은 Google Workspace로 확정됐고, 이 구간에 나오는 ImprovMX 안은 채택하지 않았습니다. 현재 절차는 `.planning/baseline/USER-TASKS.md`를 따릅니다. 아래 본문은 조사 당시의 기록입니다.

| 쟁점 | 파일별 입장 | 판정 |
|---|---|---|
| Google 동의 화면에 등록할 처리방침 언어판 | ARCHITECTURE: 홈페이지 푸터가 KO를 가리키므로 **KO URL 고정**. PITFALLS: Google·Meta·LINE·Apple은 **EN 권장**, 단 홈페이지에서도 그 URL 링크가 보여야 하므로 랜딩 푸터에 KO·EN 링크를 모두 둠 | **Google은 KO URL 등록이 기본**(링크 일치 요건이 확실한 쪽). EN을 쓰려면 랜딩 푸터에 EN 링크를 추가하는 것이 전제. Meta·LINE·Apple은 콘솔별로 확인한 뒤 제출 체크리스트에서 확정 |
| Search Console 인증 방법 | STACK: 도메인 속성 + DNS TXT만 권장(URL 접두어로 브랜드 검증이 통과하는지는 unverified). ARCHITECTURE: DNS TXT 또는 루트 HTML 파일 둘 다 가능 | **DNS TXT 도메인 속성.** HTML 파일·메타 태그는 `<head>` 리팩터 중 사라질 위험(Pitfall 10) |
| 로컬 미리보기 도구 | ARCHITECTURE: `github-pages` gem 또는 Docker. PITFALLS: `jekyll serve` + `github-pages` gem | **STACK의 직접 실험 결과 우선**: 로컬 Ruby 4.0.9에는 `github-pages` gem을 설치할 수 없음. `jekyll = 3.10.0`을 직접 고정한 Gemfile 사용 |
| 메일 전달 서비스 | STACK: ImprovMX 무료(가비아 DNS 유지). ARCHITECTURE·PITFALLS: 공급자 미정, Cloudflare는 예시로만 언급 | **ImprovMX 기본**, Workspace 사용이 확인되면 보조 도메인. Cloudflare는 네임서버 이전 때문에 이번에 배제 |
| 처리방침·삭제 안내의 「30일 이내」 표현 | FEATURES: 탈퇴 시 즉시 실행 + 잔여 `fcmTokens` 30일 TTL이므로 **상한 표현은 유지 가능**(「즉시」 약속 금지). PITFALLS: 백업·서드파티 보존을 확인한 뒤에만 절대적 문장 사용 | 「30일 이내」 상한은 유지하되 **「모든 개인정보」 같은 절대 표현은 Analytics·Crashlytics 보존 기간을 확인한 뒤에만** |
| 위치약관 페이지 | ARCHITECTURE: 6단계 **조건부**(의무가 확인될 때만). FEATURES: MVP 포함, 법률 확인으로 범위 조정 | **포함 쪽으로 계획**(공개 의무 자체는 조문상 명확). 페이지 위치·범위만 U2 결과에 따라 조정 |
| 위치약관 공개 수단 | PITFALLS: 별도 URL이 필수인 것처럼 서술. FEATURES: 시행령은 앱 첫 화면 공개도 허용 | 법 문언상 홈페이지가 유일한 수단은 아님. 그래도 심사자가 앱 없이 볼 수 있게 **홈페이지 게시 권장** |
| 법적 페이지 `noindex` | STACK·ARCHITECTURE: 심사 영향 작음, 별도 결정. FEATURES: SITE-09 권장(v1.x) | 「임시」 문구를 없앨 때 함께 결정. `robots.txt` 차단은 어느 경우든 금지 |
| 사업자 표시의 법적 근거 | FEATURES: 전자상거래법 제10조는 판매가 없는 사이트에 해당하지 않는 것으로 보임 → 근거는 카카오 심사 관행·위치정보법 제19조·ASC legal address | PROJECT.md 결정(푸터 전부 표시)은 유지하되, 근거를 「법적 의무」가 아니라 「심사 관행 + 위치약관·Support URL 요건」으로 바로잡음 |

## Implications for Roadmap

### Phase 1: 기준표와 방침 정비 (Ground Truth & Policy Reset)
**Rationale:** 이름 표·URL 등록 대장·데이터 목록은 뒤의 모든 단계가 입력으로 씁니다(PITFALLS 순서 1). `CLAUDE.md`가 이번 결정과 정반대라 먼저 고치지 않으면 이후 세션이 되돌립니다(Pitfall 7).
**Delivers:**
- `.planning/`의 이름 표(값은 빈칸 허용)
- URL 등록 대장(KO 3 + `/support/` + 위치약관 + `/en/…`, apex·https·끝 슬래시)
- 앱 저장소 기반 **데이터 목록**(항목·출처·목적·저장 위치/리전·수탁자·국외 이전·보유·삭제)
- 사용자·법률 결정 목록(아래 U1~U14) 전달
- `CLAUDE.md` 방침 문장 갱신(연락처 공개·영문명·`ko`+`en`·Jekyll 빌드)

**Addresses:** SUBMIT-01의 원본, PRIV-02/06/07의 선행 조사, SITE-07
**Avoids:** Pitfall 3·4·5·7
**Note:** 데이터 목록은 앱 저장소를 읽기만 하며, 핵심은 Functions·Firestore·Storage·OSRM VM 리전 확인입니다.

### Phase 2: Jekyll 공유 셸 도입 (출력 보존 리팩터)
**Rationale:** 사업자 정보·지원 페이지·영문판을 넣기 전에 공통 블록이 한 곳에 있어야 드리프트가 생기지 않습니다(Pitfall 9, ARCHITECTURE Scaling 1순위).
**Delivers:**
- Gemfile(jekyll 3.10.0 + 표준 라이브러리 gem)
- `_config.yml`(`url`, `exclude` 보강), `.gitignore`(`_site/` 등)
- `_layouts/base.html`·`legal.html`, `_includes/head`·`header`·`footer`·`common.css`
- 법적 3종 → 랜딩 순으로 include 전환. `_site/` 산출물 diff 0

**Uses:** STACK (b)(b'). **Implements:** 공유 셸 계층, Pattern 4
**Avoids:** Pitfall 4·11 (라이브 `/CLAUDE.md` 404, Liquid 잔여 없음, 3개 URL이 200·같은 제목)

### Phase 3: Tailwind 제거와 시맨틱 본문 규칙
**Rationale:** 마크업 규칙을 한 번만 바꾸고 이후 단계는 텍스트만 쓰게 합니다. 리팩터와 시각 변경을 분리합니다.
**Delivers:**
- `legal.css`(토큰 CSS 변수, Preflight 해당 규칙을 `.rp-legal` 범위로, 표·목록 스타일 포함)
- 기존 3개 본문을 시맨틱 마크업으로 기계 변환(문장 불변), CDN `<script>` 삭제
- 375/768/1280px 전후 캡처 비교

**Avoids:** Preflight 누락에 따른 줄 간격·테두리 회귀, 렌더 차단 CDN
**Note:** 사실값이 이미 모였다면 문서별로 Phase 5와 합쳐도 됩니다(ARCHITECTURE 권고).

### Phase 4: 사실값 슬롯 · 푸터 사업자 정보 · `/support/` (KO)

> **U12 결정 (2026-11-14):** 슬림펌킨 업무 메일은 Google Workspace로 확정됐고, 이 구간에 나오는 ImprovMX 안은 채택하지 않았습니다. 현재 절차는 `.planning/baseline/USER-TASKS.md`를 따릅니다. 아래 본문은 조사 당시의 기록입니다.

**Rationale:** 값이 없어도 배포할 수 있는 구조를 먼저 두고, 값은 데이터 파일만 고치는 작은 커밋으로 채웁니다. 지원 페이지는 Apple·Play·Meta 요건의 공통 전제입니다.
**Delivers:**
- `_data/company.yml`(빈 값 허용, `!= blank` 렌더), `_data/legal.yml`(현재 날짜 2026-10-31 이관)
- 푸터 사업자 행
- `/support/`(앱 이름 → 연락처 → 응답 기대 → FAQ·신고 안내), 헤더/푸터에 지원 링크
- 이메일은 게이트 이후에만 기입

**Addresses:** BIZ-01·02, SUP-01·02·03·04, SITE-01(텍스트 서비스 소개 보강)
**Avoids:** Anti-pattern 2(자리표시 값), 3(수신 확인 전 공개), Pitfall 8·9
**External dependency:** 사용자 DNS 작업(ImprovMX MX/SPF, Search Console TXT, `_github-pages-challenge-SlimPumpkin` TXT)을 **한 번에 계획**해 서로 덮어쓰지 않게 합니다. 사이트 작업과 병행할 수 있습니다.

### Phase 5: 한국어 법적 본문 재작성 + 랜딩 문구 정정
**Rationale:** 심사 반려의 직접 원인 대부분이 여기 있습니다. U10 결정과 데이터 목록이 먼저 있어야 합니다.
**Delivers (문서별 독립 커밋):**
1. 데이터 삭제 안내(웹 이메일 경로, 앱·개발자명, 삭제/보존 구분, 「회원탈퇴」, 제공자별 앵커)
2. 개인정보처리방침(PRIV-01~16)
3. 이용약관(TERM-02·03)
4. 랜딩 메타·OG 정정(SITE-02)

각 커밋에서 `legal.yml` 날짜를 갱신하고, 「임시 게시본」 문구를 지우고, `noindex` 결정을 반영합니다.

**Addresses:** PRIV-*, DEL-*, TERM-*, SITE-02·09
**Avoids:** Pitfall 1·2·5, 카카오 수탁자 기재 반려, 네이버 통계 목적 반려
**Gate:** 삭제 안내·처리방침은 이메일 게이트가 열리고 보호책임자 값이 들어온 뒤 커밋합니다(조항이 통째로 빠진 처리방침을 라이브에 올리지 않음).

### Phase 6: 위치기반서비스 이용약관
**Rationale:** 공개 의무는 조문상 명확하지만, 분류(U2)와 전화번호(U1)가 범위를 정합니다. 다른 단계와 독립이라 병렬로 진행할 수 있습니다.
**Delivers:**
- `/location-terms/`(경로는 Phase 1 대장에서 확정)
- 제19조① 항목, 제24조 권리(일시 중지 요구·확인자료 열람), 변경 이력
- 푸터에서 눈에 띄는 링크, 이용약관·처리방침의 상호 참조

**Addresses:** LOC-01~04 (LOC-05는 분류 결과에 따라)
**Avoids:** Pitfall 6. 신고·등록 여부는 사이트가 결정하지 않고 인수 항목으로 둡니다.

### Phase 7: 영문판
**Rationale:** 국문을 확정한 뒤에 번역해야 두 번 번역하지 않습니다(Pitfall 12). 영문 서비스명(U4) 확정이 전제입니다.
**Delivers:**
- `_data/i18n.yml`, `lang-switch` include(짝이 없으면 아무것도 안 그림 → 단독 배포 가능)
- `/en/data-deletion/` → `/en/privacy-policy/` → `/en/terms/` → `/en/support/` 순서
- 레이아웃이 넣는 「한국어판 우선」 문구, `hreflang`(자기 참조 포함 전체 URL), `source_updated`
- 위치약관 영문판은 필요성을 확인한 뒤

**Addresses:** I18N-01
**Avoids:** Pitfall 12, JS 자동 리디렉션

### Phase 8: 제출 체크리스트와 최종 정리
**Rationale:** 콘솔 입력과 브랜드 검증·검수 신청은 「임시」 문구를 없애고 URL을 확정한 뒤에 한 번만 합니다(Pitfall 10).
**Delivers:**
- 제공자 6곳 + 스토어 2곳 콘솔별 체크리스트(FEATURES §4 기준: 필드·URL·언어판·이름·로고·필수 슬롯 충족·이메일 게이트 개방 여부)
- 카카오·네이버용 서비스 소개 자료 목록
- 배포 후 대장 전체 200 확인 절차, 「심사 중 푸시 자제」 운영 규칙
- `CLAUDE.md` 최종 갱신(공통 블록 방식, `{% raw %}` 규칙, `.well-known` 제약, 로컬 미리보기)

**Addresses:** SUBMIT-01, SUP-05 확인 항목
**Note:** 6개 제공자 통과 확인은 단계 성공 기준이 아니라 마일스톤 인수 항목입니다(PROJECT.md 결정 유지).

### Phase Ordering Rationale

- **값과 구조의 분리:** 사용자·법률 값(사업자 정보, 이메일, 영문명, U1~U14)은 늦게 도착합니다. 그래서 Phase 2~4의 구조 작업은 값 없이 배포할 수 있게 짜고, 값은 `_data/`만 고치는 작은 커밋으로 채웁니다.
- **리팩터 → 시각 → 내용:** Phase 2(diff 0) → 3(시각 동일) → 5(내용) 순서라 회귀 원인을 좁힐 수 있습니다. 커밋 = 배포 환경에서 가장 안전한 순서입니다.
- **국문 → 영문, 본문 → 제출:** 번역 중복과 콘솔 재제출을 피합니다.
- **병렬 가능:** Phase 6은 Phase 4 이후 독립입니다. 사용자 DNS 작업은 Phase 1~4와 병행합니다. Phase 1의 데이터 목록 조사는 Phase 2~3과 병행할 수 있습니다.

### Research Flags

Phases likely needing deeper research during planning:
- **Phase 1 (데이터 목록):** Firebase Functions·Firestore·Storage 리전, OSRM VM 리전, Analytics·Crashlytics 보존 기간, Facebook SDK 자동 이벤트 전송, 비공개 코스 탈퇴 처리. 앱 저장소와 각 서비스 문서로 확인합니다.
- **Phase 5 (처리방침):** 개인정보위 「처리방침 작성지침」 2026.4 개정 원문 대조(현재는 보도 기준), 국외 이전 기재 형식, 네이버 지도 이용약관 §7⑤ 원문, 열람 처리 기한(시행령 제41조)
- **Phase 6 (위치약관):** 위치정보사업(등록) vs 위치기반서비스사업(신고) 분류, 확인자료 보존 기간, 국내 러닝 앱 위치약관 목차 비교. 법률 확인이 필수입니다.
- **Phase 8 (제출):** 콘솔별 실제 필드명과 언어 요건(카카오·네이버·LINE·Meta·App Store), Meta Data Deletion Instructions 내용 기준, Meta Advanced Access에 비즈니스 인증이 필요한지, Google 브랜드 검증을 생략할 때 동의 화면 모습

Phases with standard patterns (skip research-phase):
- **Phase 2 (Jekyll 셸):** STACK에서 로컬 실험으로 빌드·서빙·`hreflang`·`exclude` 동작까지 확인했습니다.
- **Phase 3 (정적 CSS):** 클래스 목록과 Preflight 원문을 확인했고, 변환은 기계적입니다.
- **Phase 4 (슬롯·지원 페이지):** 패턴이 ARCHITECTURE에 구체적으로 나와 있습니다.
- **Phase 7 (영문판):** 구조는 확정됐고, 남은 것은 번역 품질과 U4입니다.

## Consolidated Open Decisions (사용자·법률 결정 목록)

> **U12 결정 (2026-11-14):** 슬림펌킨 업무 메일은 Google Workspace로 확정됐고, 이 구간에 나오는 ImprovMX 안은 채택하지 않았습니다. 현재 절차는 `.planning/baseline/USER-TASKS.md`를 따릅니다. 아래 본문은 조사 당시의 기록입니다.

| # | 결정 | 근거·충돌 | 막는 것 |
|---|---|---|---|
| U1 | **전화번호 공개 여부** (이메일만으로 충분한가) | ASC Support URL 원문 예시, PIPA 제30조①6, 위치정보법 제19조①1. 「이메일만 공개」 결정과 충돌할 수 있음 | SUP-01, PRIV-10, LOC-02 |
| U2 | **위치정보법 분류**: 제9조 신고(위치기반서비스사업) vs 제5조 등록(위치정보사업, 법인 요건) | 기기 GPS를 직접 받는 앱의 분류는 조문만으로 정해지지 않음. 미신고 시 형사처벌(제40조) | LOC-01~05, 앱 동의 화면 |
| U3 | 소상공인·1인 창조기업 해당 여부 | 보호책임자 지정 면제(→ 대표자가 책임자), 위치 신고 1개월 유예 | PRIV-10, LOC |
| U4 | **영문 서비스명**과 영문 법인명 | 영문판과 Google·Meta·LINE·Play·Apple 판매자명이 같아야 함. 기존 「RunningPencil 쓰지 않음」 규칙 변경 | I18N-01, SUBMIT-01, 이름 표 |
| U5 | Email/Password 가입을 UI에 노출하는지 | 처리방침 항목, 네이버 별도 비밀번호 금지 | PRIV-02 |
| U6 | 탈퇴 후 공개 코스 유지(D-28)를 그대로 갈지, 비공개 코스 처리 | Play·Apple은 남는 데이터를 명시하도록 요구 | DEL-03, TERM-02 |
| U7 | 14세 미만 가입 정책 (제한 또는 법정대리인 동의) | PIPA 제22조의2, 위치정보법 제25조 | PRIV-15, 약관, 위치약관 |
| U8 | 네이버 지도 이용약관 §7⑤ 고지 의무 | 앱 임시 문자열에만 근거가 있음 | TERM-03, PRIV-05 |
| U9 | Meta Advanced Access에 비즈니스 인증이 필요한지 | 같은 공식 문서 안의 두 문장이 충돌 → 콘솔 확인 | Facebook Live 일정 |
| U10 | **포인트·굿즈·코스북을 사이트·법적 문서·`CLAUDE.md`에서 뺄지** | 앱 REQUIREMENTS는 포인트 리워드를 Out of Scope, 코스북을 P2-05로 둠. 권장: 출시 시점 앱에 없는 기능은 제거 | SITE-02, PRIV-14, TERM-02, DEL-03 (사실상 Phase 5 전체) |
| U11 | 사업자 사실값(사업자등록증 그대로의 상호 표기·대표자·사업자등록번호·사업장 주소)과 자택 주소 공개 부담 | 카카오는 사업자등록증과 같은 값인지 대조함. 자택이 사업장이면 노출 부담 | BIZ-01, LOC-02, SUP-01, PRIV-10 |
| U12 | 지원 이메일 주소와 슬림펌킨 업무 메일 서비스 종류 (Workspace 여부) | ImprovMX vs Workspace 보조 도메인 선택, `support@`로 답장이 필요한지 | 이메일 게이트 → Phase 4·5 |
| U13 | Google 브랜드 검증 신청 여부 (동의 화면에 이름·로고 표시가 필요한가) | non-sensitive scope만 쓰면 선택 | Phase 8 일정 |
| U14 | 법적 페이지 `noindex` 해제 여부, 영문 랜딩(`/en/`) 필요 여부 | 심사 영향 미확인. Google 영어 심사자에게 한국어 랜딩으로 충분한지 | SITE-09, Phase 7 범위 |

## Confidence Assessment

> **U12 결정 (2026-11-14):** 슬림펌킨 업무 메일은 Google Workspace로 확정됐고, 이 구간에 나오는 ImprovMX 안은 채택하지 않았습니다. 현재 절차는 `.planning/baseline/USER-TASKS.md`를 따릅니다. 아래 본문은 조사 당시의 기록입니다.

| Area | Confidence | Notes |
|------|------------|-------|
| Stack | HIGH (설계) / MEDIUM (외부 서비스) | Jekyll 3.10 로컬 빌드·서빙·`hreflang`·`exclude` 덮어쓰기·바이트 동일 출력을 직접 실험으로 확인. DNS 현재 상태는 `dig`로 확인. ImprovMX·Search Console은 공식 문서 단일 확인. 가비아 자체 포워딩, Workspace 절차는 unverified |
| Features | MEDIUM | 제공자·스토어 요건은 공식 원문, 법령은 국가법령정보센터 현행본으로 확인. 다만 법령을 이 서비스에 적용하는 해석(위치정보법 분류, 전자상거래법 적용, 전화번호 필요성)은 법률 확인이 필요. 카카오 사업자 표시 반려는 2차 사례 |
| Architecture | MEDIUM-HIGH | 저장소 근거 주장은 HIGH. Liquid 스케치는 실행하지 않음(STACK에서 `where` 필터 짝짓기는 실행 확인). 빌드 실패 시 이전 배포가 남는지는 미확인 → 로컬 빌드로 대신 막음 |
| Pitfalls | MEDIUM | 1·2·3·5·7번은 현재 파일에서 직접 확인. Apple·Play·Google·네이버 근거는 공식. 카카오·LINE·Meta 반려 사례는 커뮤니티. 법령은 미러 열람(국가법령정보센터 재확인 권장 — FEATURES가 현행본으로 교차 확인함) |

**Overall confidence:** MEDIUM. 기술 경로는 확실하고, 불확실성은 법률 해석·콘솔 세부·사용자 값에 몰려 있습니다.

### Gaps to Address

- **법률 판단 (U1·U2·U3·U7):** 사이트가 결정하지 않습니다. Phase 1에서 결정 목록을 사용자에게 넘기고, Phase 5·6의 해당 조항은 결과에 따라 범위를 조정합니다. 법률 검토는 출시 전 별도로 받습니다(PROJECT.md Out of Scope 유지).
- **앱 데이터 흐름 세부:** 리전·보존 기간·SDK 자동 수집·비공개 코스 처리. Phase 1 데이터 목록에서 확인하고, 확인하지 못한 항목은 처리방침 초안에 표시합니다.
- **콘솔 필드명·언어 요건:** 지금은 범주 매핑만 있습니다. Phase 8에서 각 콘솔 화면으로 확정합니다.
- **Meta 내부 문서 충돌(U9), LINE 공개 전 심사 여부:** 콘솔에서 직접 확인합니다.
- **GitHub Pages 빌드 실패 시 동작, 심사 크롤러의 meta refresh 추종:** 미확인입니다. 로컬 빌드를 필수로 두고 URL을 옮기지 않는 것으로 피합니다.
- **메일 레코드와 Pages 레코드 공존:** STACK의 `dig` 결과상 루트에 CNAME이 없고 MX·TXT도 없어 원리상 충돌하지 않습니다. 설정한 뒤 사이트 접속과 「Enforce HTTPS」를 다시 확인합니다.
- **처리방침 작성지침 2026.4 개정 원문:** 보도 기준만 있습니다. Phase 5 착수 전에 개인정보위 누리집에서 대조합니다.

## Sources

### Primary (HIGH confidence)
- 로컬 실험 (2026-11-14, Ruby 4.0.9): Jekyll 3.10.0 build/serve, `github-pages` 의존성 충돌, `exclude` 덮어쓰기, `absolute_url`·`hreflang`, 빈 front matter 바이트 동일 출력 (STACK)
- `dig`/`whois` (2026-11-14): NS 가비아, A 4개, MX·TXT·AAAA·CAA 없음, `www` CNAME (STACK)
- 저장소 직접 확인: `_config.yml`, HTML 4종(Liquid 문법 0건, 「임시 게시본」 위치), `.planning/codebase/` (ARCHITECTURE·PITFALLS)
- 앱 저장소 읽기: `delete_user_account.ts`, `cleanup_user_data.ts`, `provider_id.dart`, `auth_repository.dart`, `line_sdk_client.dart`, `app_ko.arb`, `.planning/REQUIREMENTS.md` (FEATURES)

### Secondary (MEDIUM confidence — 공식 문서·법령 원문 단일 확인)

> **U12 결정 (2026-11-14):** 슬림펌킨 업무 메일은 Google Workspace로 확정됐고, 이 구간에 나오는 ImprovMX 안은 채택하지 않았습니다. 현재 절차는 `.planning/baseline/USER-TASKS.md`를 따릅니다. 아래 본문은 조사 당시의 기록입니다.

- Google: support.google.com/cloud/answer/13464321 · 15549049 · 13463073 · 13804963, brand-verification, Search Console 9008080, hreflang 문서
- Google Play: answer/13327111(계정 삭제) · 10144311(User Data)
- Apple: App Review Guidelines 1.2·1.5·2.1(a)·5.1.1(i)(v), ASC Platform version information(Support URL 원문), Offering account deletion
- Meta: Basic settings, Data deletion callback, Privacy Policy Expectations, Login overview, Access levels
- 카카오: 앱 설정, 카카오 로그인 설정하기 / 네이버: 로그인 사전 검수 가이드 / LINE: Getting started, Integrate LINE Login
- 법령(law.go.kr 현행본): 개인정보 보호법·시행령, 위치정보법·시행령, 전자상거래법
- GitHub Docs(커스텀 도메인·도메인 인증·Jekyll), pages.github.com/versions.json, Tailwind 3.4.17 Preflight 원문, ImprovMX·Cloudflare Email Routing 문서

### Tertiary (LOW confidence — 검증 필요)
- 카카오 데브톡 사례(사업자 정보 누락·수탁자 기재·필수/선택 불일치 반려, 비즈니스 정보 심사 FAQ)
- Google 개발자 포럼(이름 불일치·Firebase 도메인 검증 사례), Meta 커뮤니티(invalid page 반려)
- 처리방침 작성지침 2026.4 개정 보도(뉴시스·바이라인네트워크)
- Meta Data Use Checkup 요약, Apple Private Email Relay 반송 동작, Cloudflare 프록시와 Pages HTTPS 사례

---
*Research completed: 2026-11-14*
*Ready for roadmap: yes*
