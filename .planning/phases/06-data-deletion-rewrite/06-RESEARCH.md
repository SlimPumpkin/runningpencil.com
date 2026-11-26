# Phase 6: 데이터 삭제 안내 재작성 (Data Deletion Rewrite) - Research

**Researched:** 2026-11-20
**Domain:** 정적 법적 문서(Jekyll 3.10.0, `legal` 레이아웃) 재작성 + 앱 사실 대조 + Google Play·Meta 삭제 안내 요건 + 개인정보 보호법·위치정보법 처리 기한
**Confidence:** MEDIUM (사이트 구조·앱 코드 사실은 HIGH, 법령 해석과 prod 값은 LOW)

> 이 저장소는 **PUBLIC**입니다. 이 문서에는 사업자 값, 지원 이메일 주소, 스토어 개발자 이름 값을 적지 않았습니다. 모두 `_data/company.yml`의 키 이름이나 `.planning/baseline/NAMES.md`의 행 이름으로만 가리킵니다.
> 앱 코드 인용은 앱 저장소(`~/dv/woody/running_pencil`) HEAD `21d5c86c` 기준입니다. 기준 커밋 `3afb2085` 이후 바뀐 파일은 `.claude/` 설정 문서뿐이라 행 번호는 기준 커밋과 같습니다. **D-05 앱 작업이 들어오면 아래 행 번호와 결론을 모두 다시 확인해야 합니다.**
>
> **2026-11-26 메모 (앱 작업 뒤).** D-05 앱 작업 ①②③⑤⑥이 앱 커밋 `92e986c3bb29`에 들어왔습니다. 아래 본문은 2026-11-20의 조사 그대로이고 고치지 않았습니다. 앱 코드에 기댄 결론과 행 번호는 그 뒤로 달라졌으니, `06-CONTEXT.md` 「앱 작업 뒤 결정」(D-34~D-44)과 `06-EVIDENCE.md`의 「06-03 중간 보고」 다섯 구간·「06-03 앱 작업 보고」를 먼저 따릅니다. 이 문서의 `<user_constraints>`는 2026-11-20의 CONTEXT 사본이라 D-34~D-44와 그날의 덧붙임이 없습니다.
>
> 달라진 결론:
> - C-2, 연구 항목 4, Pitfall 4 (기록 삭제 화면 없음, 뱃지 삭제 화면 없음): 앱에 뱃지·기록 삭제가 생겼습니다. 코스 단위이고 뱃지와 기록을 함께 지웁니다 (D-37).
> - C-6, 연구 항목 6 (확인자료를 기록하는 곳 없음): 확인자료 기록과 철회 때의 파기가 생겼습니다. 표기는 「6개월」입니다 (D-41).
> - C-8과 「데이터 목록 G·E 대조」의 해시 `rate_limits` 「최대 N일」: 만료 시각과 TTL 정책이 생겼고 표기는 「7일 안」입니다 (D-40). C-8의 나머지 prod 값은 그대로 미결입니다.
> - 「데이터 목록 G·E 대조」 구간 G의 「D-05 ①·②」 줄: 예상대로 들어왔습니다. 낱말은 「비공개 코스」가 아니라 「공개하지 않은 코스」입니다 (D-39). 「지워지는 데이터」 범주 목록 초안도 같은 낱말로 읽습니다.
> - 운영자 삭제 도구: 생겼습니다. 범위는 계정 전체 삭제와 「뱃지와 기록 모두 삭제」이고, 제공자 연결은 끊지 않습니다 (D-38, D-43).
> - Open Questions의 installation ID: 사용자가 남는 데이터 표에서 빼기로 했습니다 (`06-EVIDENCE.md` `INSTALL_ID=keep-out`).
> - U2 (연구 항목 10, C-6): 원문 조사로 「위치기반서비스사업(신고 대상)」이고, 법률 확인 전 초안으로 진행합니다 (D-36).
>
> 그대로인 것: 사이트 구조와 Liquid 패턴, 본문 골격과 앵커, Google Play·Meta 요건, 법령 원문(연구 항목 7~11), 제공자 도움말, C-1·C-3·C-4·C-5에 대한 결정(D-29·D-30·D-32), 검증 방식. C-7(익명 계정 문장)은 여전히 미결입니다(D-33의 1).

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions

#### 이전에 정해진 것 (다시 논의하지 않음)
- 페이지 제목 「데이터 삭제 안내 - 러닝펜슬」과 경로 `/data-deletion/`은 고정입니다. 리디렉션은 걸지 않습니다. `scripts/check-site.sh`의 `EXPECTED_TITLES`가 이를 지킵니다.
- 재작성 커밋에서 front matter의 `noindex: true`와 본문 끝 「임시 게시본」 `<footer>`를 함께 지웁니다(U14). 포인트·굿즈·배송지·코스북·전자상거래 기록 문장도 모두 지웁니다(U10).
- 법적 본문 작성 규칙 D-01~D-12(`.planning/codebase/CONVENTIONS.md` 「법적 본문 작성 규칙」)를 따릅니다.
  - 클래스 없는 허용 요소만 씁니다.
  - 조항마다 `<section>` 하나를 두고 첫 자식은 `<h2>`입니다.
  - 표는 `<figure tabindex="0" aria-label="…">`로 감쌉니다.
  - 앵커 `id`는 `section`에 둡니다(Phase 5 D-13).
- 사실값은 `site.data.company.<키>`로 읽고, 판정은 `.size > 0`으로 합니다. 출력에는 `| escape`를 붙이고, 값 바로 뒤에 조사를 붙이지 않습니다. 값이 없는 선택 항목(전화 등)은 자리표시 없이 숨깁니다(render-if-present).
- 이메일 게이트는 2026-11-19에 열렸습니다. 지원 이메일은 `support_email` 키에 있고 푸터·`/support/`에 이미 라이브입니다.
- 사업자 값과 개발자 이름 값은 `.planning/` 문서와 커밋 메시지에 적지 않습니다(저장소 PUBLIC, Phase 5 D-02).
- 푸시는 SHA마다 사용자 승인을 받고, 푸시 뒤 라이브를 확인합니다. 리팩터·시각·내용 변경은 커밋을 나눕니다.
- 지원 페이지 FAQ는 앱 경로를 「설정 → 내 계정 → 회원탈퇴」로 적고 `/data-deletion/`으로 링크합니다. 이 단계의 앱 경로 문장은 FAQ와 같은 경로를 씁니다(Phase 5 D-16 참고, DEL-04).

#### 탈퇴 뒤 남는 데이터 (U6)
- **D-01:** 탈퇴한 사용자의 **공개 코스는 남깁니다**(U6-가 결정). 삭제 안내의 「남는 데이터」에 공개 코스와 남는 이유를 밝힙니다.
  - 지금 코드와 앱 결정(「공개 코스 자산, `creatorId`만 남음」)이 이와 같습니다.
  - 탈퇴 뒤 앱 화면에서 만든 사람이 어떻게 보이는지는 연구 단계가 앱 코드로 확인하고, 확인된 대로만 씁니다.
  - **Reversibility:** costly — 이 문장이 Google Play·Meta 심사에 제출되는 보존 고지가 되고, 약관(Phase 8)도 같은 사실을 따릅니다.
- **D-02:** 탈퇴한 사용자의 **비공개 코스는 앱을 고쳐 탈퇴 때 지웁니다**(U6-나 결정, 결정 목록 권장안).
  - 삭제 안내에는 고친 뒤의 동작(비공개 코스 삭제)을 씁니다.
  - 고치기 전 코드는 비공개 코스를 남기므로, **D-05의 앱 작업과 데이터 목록 재기준이 끝나기 전에는 Phase 6 커밋을 만들지 않습니다.**
- **D-03:** 요청 횟수 기록 `rate_limits` 가운데 **uid가 문서 ID에 들어간 문서는 탈퇴 때 함께 지우도록 앱을 고칩니다.** D-02와 같은 앱 작업으로 묶습니다.
  - uid가 아닌 해시(IP·이메일 SHA-256 앞 32자)로 된 문서는 탈퇴로 찾을 수 없습니다. 이 문서의 보존 기간(예: prod TTL)은 앱 작업에서 정하고, 정해진 값을 「남는 데이터」 표에 씁니다.
  - 정해지지 않으면 연구·계획 단계가 사용자에게 다시 묻습니다.
- **D-04:** 본문 모양은 아래와 같습니다.
  - 「지워지는 데이터」는 범주 목록(`ul`)입니다. 예: 계정 정보, 프로필 사진, 기록과 GPS 경로, 뱃지, 비공개 코스, 알림 토큰.
  - 「남는 데이터」는 표 하나입니다(열: 데이터 | 남는 이유 | 기간). 표는 `figure tabindex="0" aria-label`로 감쌉니다.
  - 「남는 데이터」 표에 들어갈 후보는 데이터 목록 G·E·H 기준으로 다음과 같습니다. 앱 작업 뒤 재기준 결과로 확정합니다.
    - 공개 코스
    - Analytics에 붙은 uid: 「최대 14개월」(D-24)
    - Crashlytics: 90일
    - Cloud Functions 로그: 30일
    - Firebase Authentication 백업 제거: 삭제 뒤 180일 안
    - Storage 소프트 삭제: 7일
    - 해시 `rate_limits`: D-03의 값
  - **위 후보는 전부가 아닙니다.** 재기준한 목록 G 전체와 E의 행을 하나씩 대조해 빠짐없이 「지워짐」이나 「남음」으로 나눕니다(성공 기준 2가 목록과의 일치를 요구). 대조 대상 예: `mail` 문서(dev 미사용, 확장 TTL 1일), 연결 끊기를 건너뛴 제공자 쪽 앱 연결, FCM·Remote Config installation ID(삭제 API 호출 뒤 180일), 기기 안 설정(서버 삭제 대상 아님).
  - 기간 값 가운데 7일·30일 같은 dev CLI 값은 prod 값이 아닙니다. prod 프로젝트는 아직 없습니다(결정 목록 P1). 연구 단계는 prod 값이 정해지지 않은 항목을 표에 어떻게 적을지(예: 상한 표현) 제안합니다.

#### 앱 저장소 작업 묶음 (Phase 6 커밋의 전제)
- **D-05:** 아래는 앱 저장소(`~/dv/woody/running_pencil`)의 일입니다. 사용자가 하거나 앱 쪽 GSD로 진행합니다. 이 저장소의 계획은 이 작업을 **블로킹 사용자 체크포인트**로 둡니다.
  1. 탈퇴 때 비공개 코스 삭제 (D-02)
  2. 탈퇴 때 uid가 든 `rate_limits` 문서 삭제, 해시 문서의 보존 기간 결정 (D-03)
  3. 운영자용 삭제 도구 (D-07): uid를 받아 탈퇴와 같은 단계를 도는 관리자 스크립트나 함수입니다. 범위는 「계정 전체」와 「위치 기록만」(D-14) 두 가지입니다.
  4. prod 익명 계정 자동 정리 켜기 (D-26): prod 프로젝트를 만들 때 하는 설정이라 Phase 6 커밋을 막지는 않습니다. 결정은 이번에 기록합니다.
- **D-06:** 1~3이 앱에 들어오면 데이터 목록의 재확인 규칙을 돌립니다.
  - 앱 저장소에서 `git diff 3afb2085..HEAD -- <근거 경로>`를 돌리고, `config/dev.json`은 직접 다시 엽니다.
  - 구간 A·C·F·G와 기준 앱 커밋을 새 HEAD로 고칩니다.
  - 결정 목록(`.planning/baseline/DECISIONS.md`)의 U6-가·U6-나·N3를 「결정됨」으로 고칩니다.
  - 본문은 고친 목록으로 씁니다.
  - 2026-11-20 확인 결과 기준 커밋 이후 앱 HEAD의 변경은 `.claude/` 설정 문서뿐입니다. 삭제 관련 경로(`firestore.rules`, `storage.rules`, `delete_user_account.ts`, `cleanup_user_data.ts`, `app_ko.arb`, `lib/features/settings`, `course_repository.dart`, `functions/src/index.ts`)는 바뀌지 않았습니다. 미커밋 변경도 아이콘·스플래시 이미지뿐입니다.

#### 이메일 삭제 요청 (DEL-01, DEL-05)
- **D-07:** 메일 요청은 운영자용 삭제 도구(D-05의 3)로 처리합니다.
  - 앱의 `deleteUserAccount`는 본인의 5분 안 재로그인 토큰을 요구해서 운영자가 대신 부를 수 없습니다.
  - Firebase 콘솔에서 Auth 사용자만 지우면 트리거가 기록·뱃지만 지우고, `users/{uid}`·`identity_index`·Storage·알림 토큰이 남습니다.
  - 운영자가 요청을 처리하는 절차(도구 실행, 확인 메일 양식, 답장 양식)는 운영 문서로 남깁니다. 위치는 `.planning/baseline/USER-TASKS.md`의 새 작업이나 앱 저장소 문서입니다(계획자 재량).
- **D-08:** 본인 확인은 **계정 이메일로 확인 메일을 보내 답장을 받는** 방식입니다.
  - 요청 메일에는 로그인 방식(카카오·네이버·Google·Apple·Facebook·LINE)과 계정 이메일을 적게 합니다.
  - 운영자는 그 계정에 등록된 이메일로 확인 메일을 보내고, 답장이 오면 지웁니다.
  - 요청을 보낸 주소가 계정 이메일과 같으면 확인 단계를 줄일 수 있습니다. 문장 표현은 재량입니다.
  - 메일에 적을 항목은 **앱 화면에 실제로 보이는 것만** 고릅니다(Phase 5 D-15와 같은 원칙). 예를 들어 「내 계정」 화면에 로그인 방식과 계정 이메일이 보이는지 연구 단계가 앱 코드로 확인합니다.
  - **알려진 제약 ① Apple 가리기 주소:** Apple 「이메일 가리기」 주소로 보내는 확인 메일은 Apple 발신 도메인 등록과 릴레이 시험(Phase 10, SUP-05)이 끝나야 도착합니다.
  - **알려진 제약 ② 이메일 없는 계정:** 데이터 목록 B에서 제공자별 이메일 항목의 필수·선택은 「미확인」입니다. 사용자가 이메일 제공에 동의하지 않으면 계정 이메일이 없어 확인 메일을 받을 수 없습니다. 이런 계정이 생길 수 있는지는 연구 항목 15가 확인합니다.
  - 두 제약의 대체 확인 방법은 연구·계획 단계가 제안하고 **커밋 전에 사용자가 정합니다**(D-25). 문서가 지킬 수 없는 절차를 약속하지 않게 합니다.
  - **Reversibility:** costly — 공개한 요청 절차는 심사 제출물이고, 바꾸면 운영 문서와 도구도 함께 바뀝니다.
- **D-09:** 처리 상한은 **「30일 안」**입니다(사용자 선택. 제시한 권장안은 「요청일부터 10일 안」). 완료는 요청 메일에 답장으로 알립니다.
  - 지원 페이지의 「영업일 기준 3일 안에 답장」 약속과 어긋나지 않게 씁니다. 3일은 첫 답장, 30일은 삭제 완료입니다.
  - **확인 조건:** 연구 단계는 두 가지를 원문으로 확인합니다.
    - 개인정보 보호법과 같은 법 시행령의 삭제 요구 처리 기한(10일로 알려져 있으나 미확인, 연구 항목 9)
    - 위치정보법의 「지체 없이」(연구 항목 10): 계정 삭제 요청에도 기록의 GPS 궤적이 들어 있으므로, 계정 삭제의 30일 상한이 이 조항과 부딪히는지 봅니다.
  - 둘 중 하나라도 30일과 어긋나면 **커밋 전에 사용자에게 다시 묻습니다.** 그때까지 이 결정을 그대로 쓰지 않습니다.
- **D-10:** 메일은 **계정 전체 삭제만** 받습니다. 예외는 위치 기록 일괄 삭제(D-14)입니다.
  - 일부만 지우려는 사용자에게는 앱 안에서 직접 지우는 방법(기록·코스·프로필 사진)을 안내합니다.
  - 메뉴 이름은 연구 단계가 앱 코드로 확인합니다.
  - Google Play의 「해당하면 일부 삭제 안내」를 이것으로 채웁니다.

#### 위치정보 동의 철회 (DEL-06)
- **D-11:** 철회 경로는 네 가지를 모두 안내합니다.
  1. 기기 설정에서 위치 권한을 끄면 수집이 멈춥니다.
  2. 앱에서 기록을 지우면 저장된 GPS 궤적이 파기됩니다.
  3. 지원 이메일로 위치 기록 일괄 삭제를 요청할 수 있습니다. 계정은 유지됩니다.
  4. 회원탈퇴를 하면 모두 파기됩니다.
  - 앱에는 위치정보 동의만 끄는 스위치가 없습니다. 약관 동의 기록의 키도 `service`·`privacy`·`marketing`뿐입니다.
  - 서버에 저장되는 개인위치정보는 `runs/{runId}.path`뿐입니다(데이터 목록 C).
- **D-12:** 메일로 온 위치 기록 삭제 요청은 **본인 확인 뒤 「지체 없이」** 처리한다고 씁니다. 숫자 상한은 두지 않고, 완료는 답장으로 알립니다. 본인 확인 방식은 D-08과 같습니다.
- **D-13:** 「위치정보 동의 철회」는 **별도 조항(`section`)**으로 두고 고정 앵커를 답니다. 이름 제안은 `#location`이고, 계획 단계에서 확정합니다.
  - Phase 7 처리방침과 Phase 8 위치약관이 이 앵커로 링크합니다.
  - **Reversibility:** costly — 다른 문서와 앱이 링크하기 시작하면 이름을 바꿀 때 모두 고쳐야 합니다.
- **D-14:** 운영자 도구의 「위치 기록만」 범위는 그 uid의 `runs` 문서를 지웁니다.
  - 뱃지(`users/{uid}/badges`)는 `runId`를 참조하지만, 뱃지가 담은 경로는 코스 모양 사본이라 GPS 궤적이 아닙니다.
  - 기록을 지울 때 뱃지를 어떻게 할지는 연구 단계가 앱의 기록 삭제 동작을 확인한 뒤 앱의 동작에 맞춥니다.
- **D-15:** 「확인자료」(위치정보 수집·이용·제공사실 확인자료)는 데이터 목록에 행이 없고 U2도 열려 있습니다. DEL-06 문장은 성공 기준대로 「개인위치정보와 확인자료가 파기된다」를 담습니다. 다만 그 문장이 목록과 어긋나지 않게 연구 단계가 확인합니다(연구 항목 6). 법 문구는 「초안·법률 확인 필요」 범위입니다.

#### 문서 구성과 제공자 섹션 (DEL-01, DEL-02, DEL-04, DEL-07)
- **D-16:** 첫 화면 구성은 아래와 같습니다.
  - 맨 위 **소개 한 문단**에 앱 이름 「러닝펜슬」과 **스토어 개발자 이름**을 적습니다. 예: 「러닝펜슬(개발자 ○○○) 앱의 계정과 데이터 삭제 안내」.
  - 바로 아래 **「삭제 요청 방법」** 조항에 두 경로를 나란히 둡니다.
    - ① 앱에서: 「설정 → 내 계정 → 회원탈퇴」. 5분 안 재로그인과 제공자 연결 끊기 단계를 짧게 안내합니다.
    - ② 앱 없이: 지원 이메일. `mailto:` 링크와 메일에 적을 내용(D-08)을 둡니다.
  - 그 뒤의 조항 순서는 계획자 재량입니다. 예: 처리 기간과 완료 알림, 지워지는 데이터, 남는 데이터, 일부만 지우기, 위치정보 동의 철회, 제공자별 안내, 문의처.
- **D-17:** h1(front matter `heading`)은 **「러닝펜슬 계정·데이터 삭제 안내」**로 바꿉니다. `title`은 그대로이고, `eyebrow`는 `DATA DELETION`을 유지합니다.
  - `description`은 새 내용에 맞게 고칩니다(재량).
  - `updated`는 재작성 커밋 날짜입니다.
- **D-18:** 스토어 개발자 이름은 **`_data/company.yml`에 새 키**로 둡니다. 키 이름은 계획자 재량입니다(예: `store_developer_name`).
  - 값은 사용자가 준비했습니다(2026-11-20 「준비됨」). **값 커밋 직전에 대화로만 받습니다.**
  - DEL-02 필수 항목이라 값이 없으면 숨기지 않고 커밋을 보류합니다. 같은 키를 Phase 9 영문판과 Phase 10 체크리스트가 씁니다.
  - **Reversibility:** costly — 템플릿과 이후 영문판이 이 키 이름을 참조합니다.
- **D-19:** 제공자 섹션 여섯 개는 각각 `<section id="facebook">`처럼 둡니다. 각 섹션에는 세 가지가 들어갑니다.
  1. 그 제공자로 로그인할 때 러닝펜슬이 받는 항목(데이터 목록 B)
  2. 삭제 요청 방법 한두 줄(공통 「삭제 요청 방법」 조항으로 링크)
  3. 제공자 쪽에서 앱 연결을 해제하는 방법
  - 앵커로 들어온 심사자가 그 섹션만 읽어도 이해할 수 있어야 합니다.
  - 앱 탈퇴의 연결 끊기 단계는 카카오·네이버·Facebook·LINE에만 있습니다. 그래서 `#google`·`#apple` 문장은 이 넷과 달라야 하고, 그 내용은 연구 단계가 앱 코드로 확인합니다(연구 항목 5).
  - **Reversibility:** costly — 앵커 여섯 개는 Facebook Data Deletion Instructions URL 같은 콘솔 칸에 등록됩니다(`.planning/baseline/URLS.md`). 이름은 ROADMAP 성공 기준 4가 고정합니다.
- **D-20:** 사업자 정보와 연락처(BIZ-05)는 본문에서 모두 `site.data.company.<키>`로 읽습니다. 지원 이메일, 상호·주소 등 운영 주체, 전화(값이 있을 때만)가 여기에 해당합니다.
  - 지원 이메일은 D-16 ②의 필수 요소입니다. 지원 페이지처럼 이메일 값 조건으로 감쌀지, 값이 없으면 점검이 실패하게 할지는 계획자 재량입니다. 어느 쪽이든 경로가 빠진 삭제 안내가 라이브에 오르지 않아야 합니다.
  - 본문 안 배치(예: 끝 「문의처」 조항)는 재량입니다.

#### 커밋 전 게이트 (2026-11-20 확인)
- **D-21:** 이메일 게이트: 열림(2026-11-19). 막지 않습니다.
- **D-22:** U6-가·나: 결정됨(D-01, D-02). 다만 D-02·D-03 때문에 커밋은 D-05 1~3과 D-06 재기준을 기다립니다.
- **D-23:** 스토어 개발자 이름: 준비됨. 값은 커밋 직전에 받습니다(D-18).
- **D-24:** Analytics 데이터 보관 설정: 아직 확인하지 않았습니다.
  - 「남는 데이터」 표에는 **「최대 14개월」**로 씁니다. 표준 속성 선택지가 2개월과 14개월뿐이라 설정값과 상관없이 참인 상한입니다.
  - 연구 단계는 Firebase에 연결된 GA4 속성의 선택지가 정말 둘뿐인지 공식 문서로 확인합니다.
  - ROADMAP Notes의 「모든 개인정보」 같은 절대 표현은 쓰지 않습니다.
- **D-25:** 이 단계의 사이트 커밋을 막는 것은 아래 여섯 가지입니다.
  1. D-05 1~3 (앱 작업)
  2. D-06 (데이터 목록 재기준)
  3. D-18의 개발자 이름 값 (커밋 직전 대화로 받음)
  4. D-09의 법령 확인 결과 (30일과 어긋나면 사용자에게 다시 물음)
  5. D-08의 두 제약(Apple 가리기 주소, 이메일 없는 계정)에 대한 대체 확인 방법 (사용자 결정)
  6. D-26의 익명 계정 문장 근거 (목록에 사실이 없으면 사용자에게 다시 물음)
- **D-26:** 익명(둘러보기) 계정(N3)은 **prod에서 Firebase 익명 계정 자동 정리를 켭니다.**
  - 삭제 안내에 「둘러보기 계정은 N일 뒤 자동 삭제」를 쓰는 것은 **재기준한 데이터 목록에 그 사실(켜는 결정, 기간, 자동 정리 뒤 남는 것)이 있을 때만**입니다. 없으면 커밋 전에 사용자에게 다시 묻습니다.
  - 자동 정리는 Auth 계정을 지웁니다. 하지만 D-07에 적은 대로 Auth 삭제 트리거는 기록·뱃지만 지우므로, 익명 계정의 `users/{uid}`(약관 동의 기록)가 함께 지워지는지는 확인되지 않았습니다. 연구 항목 12가 확인합니다. 남는다면 앱 작업(D-05)에 정리 단계를 더할지 사용자에게 묻습니다.
  - 기간과 켜는 조건(요금제·Identity Platform 필요 여부 등)도 연구 단계가 공식 문서로 확인합니다.
  - dev에서는 지금 꺼져 있고, prod는 아직 없습니다. 「prod를 만들 때 켬」을 결정 목록에 적고, 실제로 켰는지는 Phase 10 또는 prod 생성 시점의 확인 항목으로 넘깁니다.

#### 이 단계 안에서 고칠 문서 (Ground Rule)
- **D-27:** 방침이나 구조가 바뀌므로 이 단계 안에서 아래 문서를 고칩니다. 사이트 커밋과 문서 커밋은 나눕니다.
  - **두 `CLAUDE.md`:**
    - 방침 표의 「포인트·굿즈·코스북 제거」 행과 「법적 페이지 `noindex` 해제」 행의 현재 상태(삭제 안내 반영)
    - Pages 표의 `data-deletion/index.html` 행(임시 게시본·`noindex` 문구 삭제)
    - `_data/company.yml` 키 목록(새 개발자 이름 키)
    - 방침 구간은 두 사본을 같은 커밋에서 고칩니다. `.claude/CLAUDE.md`의 GSD 블록은 원본 맵을 고친 뒤 재생성합니다. 원본 맵은 `.planning/codebase/CONVENTIONS.md` 「사실값 슬롯」 키 목록과 Content & Naming Rules의 `noindex` 문장, 그리고 `ARCHITECTURE.md`·`STACK.md`의 `noindex`·Entry Points 문장입니다.
  - **`.planning/baseline/NAMES.md`:** 「스토어 개발자 이름」 행의 「들어갈 곳」에 새 키 이름을 적습니다. 값은 적지 않습니다.
  - **`.planning/baseline/DECISIONS.md`:** U6-가·U6-나·N3를 결정됨으로 바꿉니다(D-06).
  - **`.planning/baseline/DATA-INVENTORY.md`:** 재기준(D-06). Analytics 행 기간은 「최대 14개월(설정 미확인)」로 적습니다.
  - **`.planning/baseline/USER-TASKS.md` 또는 앱 저장소 문서:** 운영자 삭제 요청 처리 절차(D-07).

### Claude's Discretion
- 조항 제목과 문장 표현, 「지워지는 데이터」 범주 이름, `description` 문구. 사실은 재기준한 데이터 목록 범위 안에서만 씁니다.
- D-16 뒤 조항 순서, 공통 조항에 앵커를 더 달지 여부와 이름. 단, 한 번 공개한 앵커는 바꾸기 어렵습니다.
- 제공자 섹션의 순서. 제공자 쪽 연결 해제를 메뉴 경로로 쓸지, 각 제공자의 공식 도움말 링크로 쓸지도 재량입니다. 메뉴 경로는 자주 바뀌므로 공식 도움말 링크를 우선 검토합니다.
- 기간 표현 방식. 「서비스에서의 삭제」와 「백업·외부 서비스 기록에서의 제거」를 나눠 씁니다(데이터 목록 G 맺음 문장).
- 지원 이메일 조건 감싸기와 점검 방식(D-20).
- `scripts/check-site.sh` 보강. 예: 6번 항목(포인트·굿즈·코스북)을 삭제 안내 출력에도 적용합니다. Phase 4처럼 별도 build 커밋으로, 재작성 커밋의 라이브 확인 뒤에 넣는 순서를 지킵니다.
- 화면 확인 방식. 이전 단계처럼 Playwright, Chromium·WebKit, 375px·넓은 폭을 쓰고, 스크래치 경로에 pnpm을 씁니다. 앵커 여섯 개와 `#location`이 해당 섹션으로 바로 열리는지 확인합니다.
- 커밋 세부 단위. 내용 변경 커밋에 구조·시각 변경을 섞지 않습니다.

### Deferred Ideas (OUT OF SCOPE)
- **앱 탈퇴 대화상자 문구** (앱 저장소): 「이 계정과 모든 데이터는 영구 삭제됩니다」(`lib/l10n/app_ko.arb`의 `withdrawalDialogBodyLine1`)를 실제 동작(공개 코스는 남음)에 맞게 고칩니다. 심사는 사이트와 앱이 일치하는지 봅니다.
- **앱 임시 약관 개요의 「보관·삭제」 문구** (앱 저장소): 비공개 코스 삭제(D-02)가 들어가면 함께 맞춥니다.
- **D-05 앱 작업 묶음** (앱 저장소): 비공개 코스 삭제, `rate_limits` 정리, 운영자 삭제 도구, prod 익명 계정 자동 정리. Phase 6 커밋의 전제이고, 4번은 prod 생성 시점의 일입니다.
- **영문 `/en/data-deletion/`**: Phase 9. 같은 앵커 이름을 씁니다.
- **콘솔 등록**: Google Play 계정 삭제 URL, Facebook Data Deletion Instructions URL(`#facebook`) 등록은 Phase 10입니다.
- **Apple 릴레이 답장**: Apple 가리기 주소로 확인 메일·답장을 보내는 것은 Phase 10(SUP-05, DKIM)입니다. D-08의 제약을 그때 해소합니다.
- **처리방침·위치약관의 철회·파기 조항**: Phase 7·8이 이 문서의 `#location` 조항과 문장을 맞춥니다.
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| DEL-01 | 앱 없이 지원 이메일로 삭제 요청 방법을 눈에 띄게 찾음 (Google Play) | Google Play 원문 「prominently featured and easily discoverable」, 「without sending the user back to the app」(§요건 체크리스트). `support/index.html`의 `mailto` + `| escape` 패턴(§현재 상태). 첫 화면 판정 방법(§Validation). 본인 확인 대체 방법은 차단 체크포인트 C-4·C-5 |
| DEL-02 | 스토어 앱 이름·개발자 이름 표시 | Google Play 원문 「reference the app or developer name (… as it appears on your store listing)」. 새 키 `store_developer_name` 권장(§새 키 이름) |
| DEL-03 | 삭제되는 데이터·남는 데이터, 이유·기간 | §데이터 목록 G·E 대조표. Crashlytics·Analytics·Auth 공식 보존 문장. 기간 상한 표현안. 의존 행(D-05·prod 값) 표시 |
| DEL-04 | 앱 안 경로를 「회원탈퇴」로 안내 | 연구 항목 1: `settingsWithdrawalLabel` 「회원탈퇴」(app_ko.arb:349), 「내 계정」 화면 맨 아래 Danger zone |
| DEL-05 | 처리 상한과 완료 알림 방법 | 시행령 제43조③ 「10일 이내」 원문 → D-09 30일과 어긋남 → 차단 체크포인트 C-1 |
| DEL-06 | 위치정보 동의 철회 시 개인위치정보·확인자료 파기 안내 | 위치정보법 제24조④·제23조①·제16조② 원문. 앱에 확인자료 저장소 없음(연구 항목 6). 앱에 기록 삭제 화면 없음 → 차단 체크포인트 C-2·C-6 |
| DEL-07 | 제공자별 섹션 6개 앵커 | 앱 표시 순서 `kSocialProviderOrder`(google·apple·facebook·kakao·naver·line). 여섯 제공자 모두 앱 탈퇴 중 연결 해제 단계가 있음 → 차단 체크포인트 C-3. 공식 도움말 링크(§제공자별 해제) |
| BIZ-05 | 사업자 정보·연락처는 `_data`에서만 읽음, 선택 항목은 render-if-present | `support/index.html`·`_includes/footer.html`의 `.size > 0` + `| escape` 패턴, Phase 5 `variant` 빌드 검증 방식 재사용 |
</phase_requirements>

## Project Constraints (from CLAUDE.md)

루트 `CLAUDE.md`·`.claude/CLAUDE.md`에서 이 단계에 걸리는 지시입니다. 계획은 이것을 잠긴 결정과 같은 무게로 지킵니다.

- `main` 푸시 = 배포(CI 없음). 모든 커밋은 그대로 라이브에 올라가도 되는 상태여야 합니다.
- `/privacy-policy/`, `/terms/`, `/data-deletion/` 경로 고정·리디렉션 금지. 배포마다 세 URL 200·같은 제목 확인.
- 리팩터·시각 변경·내용 변경을 한 단계·한 커밋에 섞지 않습니다.
- 푸시 전 로컬 Jekyll 3.10.0 빌드 성공(`scripts/check-site.sh`). pre-push 훅 `.githooks/pre-push`가 자동 실행합니다.
- 사용자 사실값은 추측하지 않습니다. 값이 없으면 숨기되, 빠지면 안 되는 조항이 있는 페이지는 커밋을 보류합니다. 「추후 기재」 같은 자리표시 금지.
- JS 언어 자동 리디렉션, `robots.txt` 차단, `.nojekyll`, Jekyll i18n 플러그인 금지.
- 방침·구조를 바꾸는 단계는 그 단계 안에서 두 `CLAUDE.md`를 같은 커밋으로 고칩니다. `.claude/CLAUDE.md`의 `project`·`stack`·`conventions`·`architecture` 구간은 원본(`.planning/PROJECT.md`, `.planning/codebase/*.md`)을 고친 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 재생성합니다. `skills`·`workflow`·`profile` 구간은 고치지 않습니다.
- 법적 본문에는 데이터 목록(`.planning/baseline/DATA-INVENTORY.md`)에 있는 사실만 씁니다.
- 법적 본문 작성 규칙 D-01~D-12: HTML 원본(Markdown 금지), `section` + 첫 자식 `h2`, 허용 요소(`section h2 h3 p ul ol li dl dt dd table thead tbody tr th td figure strong a aside footer`)만 클래스 없이, 표는 `<figure tabindex="0" aria-label="…">`, `<table>`에 `display: block` 금지, 간격 클래스·`style` 금지.
- `_data/company.yml`: 판정은 `.size > 0`만(`blank`·`empty` 금지), 여러 값은 `or`로만, 출력은 `| escape`, 값 바로 뒤 조사 금지, 값은 큰따옴표·빈 값은 `""`, 값은 `.planning/`·커밋 메시지에 적지 않음.
- include 공백 규칙: include 태그는 0열에 혼자, `{%-`는 `if`/`endif`에만.
- raw 규칙: 출력에 이중 중괄호·중괄호-퍼센트가 남으면 check-site 4번이 잡습니다.
- 커밋 메시지: Conventional Commits, prefix 영어, 제목·본문 한국어. 마지막 줄 attribution은 계획이 정한 형식(Phase 5 계획은 `Co-Authored-By` 한 줄)을 따릅니다.
- 사용자 메모리: 설치 명령은 npm/npx 대신 pnpm(`pnpm --dir … add --save-exact`, `pnpm exec`). zsh에서 refspec은 `"${SHA}:refs/…"`처럼 중괄호로 씁니다.

## Summary

`/data-deletion/`은 `legal` 레이아웃의 법적 3종 가운데 하나라, 구조 작업은 front matter 네 줄(`heading`·`description`·`updated` 수정, `noindex` 삭제)과 본문 HTML 교체뿐입니다. 새 CSS·새 include·새 빌드 도구는 필요 없습니다. `support/index.html`이 이미 같은 레이아웃에서 `_data/company.yml` 값을 `.size > 0`으로 감싸 `mailto:`와 `| escape`로 내보내고 `section id`로 앵커를 다는 패턴을 갖고 있어 그대로 따르면 됩니다. 새 사실값 키는 스토어 개발자 이름 하나(`store_developer_name` 권장)입니다.

어려운 부분은 문장에 들어갈 **사실**입니다. 앱 코드를 다시 확인한 결과, CONTEXT가 기대한 것과 다른 사실이 여럿 나왔습니다. ① 앱에는 **기록(달린 기록)을 지우는 화면이 없습니다.** `RunRepository.delete`를 부르는 곳이 없고, 사용자가 앱에서 지울 수 있는 것은 「코스 삭제」와 「올린 사진 삭제」뿐입니다(D-10·D-11 ②·D-14의 전제와 어긋남). ② 앱 탈퇴의 제공자 연결 해제 단계는 카카오·네이버·Facebook·LINE만이 아니라 **Google·Apple에도 있습니다**(D-19 전제와 어긋남, 데이터 목록 D·G 행 누락). ③ 익명(게스트) 사용자는 「회원탈퇴」 메뉴에 갈 수 없고, 앱 코드는 익명 사용자의 `users/{uid}` 문서를 만들지 않습니다(약관 동의는 기기 안에만 저장). 데이터 목록 A 익명 행과 다릅니다. ④ 카카오·네이버·LINE 로그인은 이메일 없이도 계정이 만들어지고, 「내 계정」 화면은 이메일이 없으면 「-」로 보입니다. D-05 앱 작업 1~3은 **아직 들어오지 않았습니다**(앱 HEAD `21d5c86c`, 기준 이후 변경은 `.claude/` 문서뿐).

법령은 원문으로 확인했습니다. 개인정보 보호법 시행령 제43조③은 삭제 요구를 **「받은 날부터 10일 이내에」** 조치하고 결과를 알리도록 정합니다. D-09의 「30일 안」과 어긋나므로 D-09의 확인 조건에 따라 **커밋 전에 사용자에게 다시 물어야 합니다.** 위치정보법 제24조④는 동의 철회 때 「지체없이」 개인위치정보와 확인자료를 파기하도록 하고, 제23조①은 목적을 달성하면 「즉시」 파기하도록 합니다. Meta 공식 페이지에서는 Instructions URL의 내용 기준을 찾지 못했습니다(「삭제 요청 방법을 처리방침에 알릴 것」과 「요청 시 신속히 삭제」만 확인). Google Play 원문은 앱·개발자 이름, 눈에 띄는 요청 경로, 앱 재설치 없이 요청, 보존 고지를 요구합니다.

**Primary recommendation:** 사이트 작업은 「`_data/company.yml` 키 추가 → 본문 재작성 → 라이브 확인 → 문서 → check-site 보강」 순서로 작게 나누되, 그 앞에 **차단 체크포인트 C-1~C-8(아래)을 사용자 결정으로 닫고 D-05 앱 작업과 D-06 재기준(이번 연구에서 찾은 목록 오류 정정 포함)을 끝낸 뒤에만** 사이트 커밋을 만듭니다.

## Architectural Responsibility Map

| Capability | Primary Tier | Secondary Tier | Rationale |
|------------|-------------|----------------|-----------|
| 삭제 안내 본문(조항·표·앵커) | CDN / Static (GitHub Pages가 서빙하는 Jekyll 빌드 결과) | — | 서버 처리 없음. 빌드 시 Liquid로 조립 |
| 사업자·연락처·개발자 이름 값 | Static 데이터 (`_data/company.yml`) | 빌드 시 Liquid | 한 곳에서만 고침(BIZ-05) |
| 삭제 요청 접수 | 외부 서비스 (지원 메일함, Google Workspace) | 사람(운영자) | 폼·서버 없음. `mailto:`만 |
| 본인 확인·실제 삭제 | API / Backend (앱 저장소의 운영자 도구, Firebase Admin) | 사람(운영자) | 사이트 범위 밖. D-05 ③ |
| 앱 안 회원탈퇴 | 모바일 앱 + Cloud Functions | — | 사이트는 경로만 안내 |
| 제공자 쪽 연결 해제 | 각 제공자 계정 설정 | 앱(탈퇴 중 해제 시도) | 사이트는 공식 도움말로 안내 |
| 푸시 전 점검 | 로컬 도구 (`scripts/check-site.sh`, pre-push 훅) | — | CI 없음 |

## ⚠ 커밋 전 사용자 결정이 필요한 것 (차단 체크포인트)

계획자는 아래 항목마다 `checkpoint:decision`(blocking)을 둡니다. 연구는 선택지만 냅니다. 결정하지 않았습니다.

### C-1. 처리 상한 「30일 안」이 시행령 「10일 이내」와 어긋남 (D-09 재질문 조건 발동)
- **사실:** 개인정보 보호법 시행령 제43조③ 「개인정보처리자는 제1항과 제2항에 따른 개인정보 정정ㆍ삭제 요구를 받은 날부터 10일 이내에 법 제36조 제2항 에 따라 해당 개인정보의 정정ㆍ삭제 등의 조치를 한 경우에는 그 조치를 한 사실을 … 보호위원회가 정하여 고시하는 개인정보 정정ㆍ삭제 결과 통지서로 해당 정보주체에게 알려야 한다.」 `[CITED: law.go.kr 개인정보 보호법 시행령(대통령령 제36804호, 2026. 11. 10. 시행) 제43조③]`. 법 제36조② 「지체 없이 … 정정ㆍ삭제 등 필요한 조치를 한 후 그 결과를 정보주체에게 알려야 한다」 `[CITED: law.go.kr 개인정보 보호법(법률 제21445호, 2026. 9. 11. 시행) 제36조②]`. 처리정지(제44조②)도 10일입니다.
- **위치정보:** 위치정보법 제24조④ 「동의의 전부 또는 일부를 철회한 경우에는 지체없이 수집된 개인위치정보 및 위치정보 수집ㆍ이용ㆍ제공사실 확인자료 … 를 파기하여야 한다」, 제23조① 「수집, 이용 또는 제공목적을 달성한 때에는 … 확인자료 외의 개인위치정보는 즉시 파기하여야 한다」 `[CITED: law.go.kr 위치정보의 보호 및 이용 등에 관한 법률(2025. 10. 1. 시행) 제23조①·제24조④]`. 계정 삭제 요청에는 `runs/{runId}.path`(GPS 궤적)가 들어 있습니다. 「30일 안」이 「지체없이·즉시」를 충족하는지는 법률 판단이라 연구가 결론 내리지 않습니다.
- **선택지:**
  - (가) 「요청을 받은 날부터 10일 안」으로 바꾼다 (논의 단계의 권장안과 같음. 시행령 숫자와 맞음).
  - (나) 「지체 없이, 늦어도 요청을 받은 날부터 10일 안」 (위치정보법 문구와 시행령 숫자를 함께 반영).
  - (다) 「30일 안」 유지 + 법률 확인을 받은 뒤 커밋 (법률 확인 전에는 커밋하지 않음).
- **함께 정할 것:** 기한의 기산점(「요청을 받은 날」인가 「본인 확인이 끝난 날」인가). 시행령은 「요구를 받은 날부터」로 셉니다. 본인 확인 답장을 기다리는 시간을 기한에서 빼는 근거는 원문에서 찾지 못했습니다 `[ASSUMED]`. 또 결과 통지를 「보호위원회가 정하여 고시하는 … 결과 통지서」로 해야 하는지, 답장 메일로 충분한지도 법률 확인 범위입니다.

### C-2. 앱에 기록을 지우는 화면이 없음 (D-10, D-11 ②, D-14의 전제와 어긋남)
- **사실:** `RunRepository.delete(String id)`가 있지만(`lib/features/runs/data/run_repository.dart:153-157`) 이 함수를 부르는 화면 코드가 `lib/` 아래 어디에도 없습니다. 확인 범위: `lib/` 전체에서 `runRepositoryProvider`·`RunRepository` 사용처 grep(완료 기록 쓰기·조회·존재 확인만 나옴), `.delete(` 호출 grep(`runs`·`badges` 관련은 저장소 파일 안 정의뿐), `app_ko.arb`에서 「기록 … 삭제/지우」 문구 grep(임시 약관 개요 한 곳뿐). 뱃지도 같습니다(`BadgeRepository.delete`는 정의만 있음). `[VERIFIED: 앱 grep, 이번 세션]` 규칙(`firestore.rules:350`)은 본인 기록 삭제를 허용하지만 앱 화면이 없습니다. 데이터 목록 C의 「본인이 기록을 지울 수 있음」은 규칙 기준이라 화면 기준으로는 맞지 않습니다.
- **앱에서 실제로 지울 수 있는 것:** 코스(코스 상세 ⋮ 「더보기」 → 「코스 삭제」, `app_ko.arb:302-306`, 본인 코스만, 공개 코스도 지울 수 있음 「목록에서 모두에게 사라져요. 이미 받은 뱃지는 남아요.」), 직접 올린 프로필 사진(「올린 사진 삭제」, `app_ko.arb:391`).
- **선택지:**
  - (가) 앱에 기록 삭제 화면을 더한다(D-05 묶음에 추가). 그 뒤 D-11 ②를 그대로 쓴다.
  - (나) 사이트 문장에서 「앱에서 기록을 지운다」를 빼고, 일부 삭제(D-10)는 「코스 삭제·올린 사진 삭제는 앱에서, 기록은 지원 이메일로(위치 기록 일괄 삭제, D-14)」로 쓴다.
  - (다) 메일 접수 범위를 「계정 전체」·「위치 기록만」에 「기록 한 건」을 더한다(운영 부담 증가).
- **D-14 뱃지 처리 참고:** `lib/features/badges`·`lib/features/profile` 두 폴더를 grep한 범위에서, 뱃지 표시 코드가 `runId`를 쓰는 곳은 완주 직후 「저장 중」 표시(`badge_earned_dialog.dart:88-160`)뿐이었습니다. 그래서 기록이 없어도 뱃지는 그려질 것으로 보입니다 `[grep 범위 한정, 다른 화면은 미확인]`. 코스를 지워도 뱃지가 남는 앱 동작(`courseDeleteConfirmBody`)과 같은 방향은 「위치 기록만 지우고 뱃지는 남김」입니다. 결정은 사용자 몫입니다.

### C-3. Google·Apple도 탈퇴 중 연결 해제 단계가 있음 (D-19 전제와 어긋남, 데이터 목록 D·G 정정 필요)
- **사실:** 탈퇴 진행 화면의 연결 해제 단계 목록 `kDisconnectSteps`(`lib/features/settings/data/disconnect/disconnect_steps.dart:36-49`)에 카카오·Facebook(서버 함수), Google, Apple, 네이버, LINE 여섯이 모두 있습니다. Google은 `GoogleSignIn.disconnect()`로 앱 승인을 취소하고(`google_disconnect_step.dart:49-71`), Apple은 재인증 뒤 iOS `revokeTokenWithAuthorizationCode`, Android `revokeAccessToken`으로 토큰을 폐기합니다(`apple_disconnect_step.dart:57-77`). 두 파일 모두 기준 커밋 `3afb2085`에도 있습니다(`git cat-file -e` 확인). 모든 행은 건너뛸 수 있고, 건너뛰면 「{provider} 계정 설정에서 이 앱의 연결을 직접 해제해 주세요.」가 나옵니다(`app_ko.arb:372`). `[VERIFIED: 앱 코드 읽음]`
- **주의:** Apple Android 경로는 코드 주석 스스로 「A4 `[ASSUMED]`: Android 재인증 결과에 access token 이 non-null 인지는 … UAT 에서 실측한다」고 적습니다(`apple_disconnect_step.dart:17-19`). 사이트가 「Apple 연결이 반드시 해제된다」고 약속하면 안 됩니다.
- **데이터 목록 오류:** 구간 D 「소셜 연결 끊기 (카카오·네이버·Facebook·LINE)」와 구간 G 「제공자 쪽 앱 연결 (카카오·네이버·Facebook·LINE)」 행, 「근거로 삼은 경로」 목록(`lib/features/settings/data/disconnect/*` 없음)이 빠져 있습니다. 재기준(D-06)에서 고칩니다.
- **선택지 (`#google`·`#apple` 문장):**
  - (가) 여섯 섹션을 같은 틀로 쓴다: 「앱에서 회원탈퇴하면 탈퇴 전에 이 제공자의 앱 연결 해제를 시도합니다(건너뛸 수 있음). 건너뛰었거나 메일로 삭제를 요청했다면 아래 안내대로 직접 해제하세요.」
  - (나) Google·Apple만 「해제를 시도」, 나머지는 「해제」로 차이를 둔다(근거 약함, 권하지 않음).
- **메일 요청과 연결 해제:** 운영자가 서버에서 사용자 도움 없이 끊을 수 있는 함수는 카카오(어드민 키)와 Facebook(앱 토큰)뿐입니다(`functions/src/index.ts:67-76` 주석). 네이버·LINE은 재로그인 토큰, Google·Apple은 사용자 기기 로그인이 필요합니다. 운영자 도구(D-05 ③)의 범위가 정해지지 않았으므로, 메일 경로 문장은 「제공자 쪽 연결은 각 제공자 안내에 따라 직접 해제하세요」로 쓰는 것이 도구 범위와 상관없이 참입니다.

### C-4. 이메일 없는 계정이 생길 수 있음 (D-08 제약 ②)
- **사실:** 카카오 토큰 함수는 `email`을 선택 claim으로 받습니다(「비즈 앱 + 카카오계정(이메일) 필수 동의 시 포함. 일반 앱 또는 사용자 미동의 시 undefined」, `functions/src/auth/kakao_custom_token.ts:127-129`). 네이버(`naver_profile_to_custom_token.ts:322-348`, 「`if (naverEmail)`」)와 LINE(`line_custom_token.ts:144-146`, 184)도 이메일이 없으면 설정하지 않고 로그인을 계속합니다. 「내 계정」 화면은 이메일이 없으면 「-」를 보입니다(`account_screen.dart:63-65`). `[VERIFIED: 앱 코드 읽음]` 콘솔에서 이메일을 필수 동의로 했는지는 「미확인」(데이터 목록 B, 작업 12의 2번)입니다. Facebook 계정에 이메일이 없을 수 있다는 점은 `[ASSUMED]`입니다.
- **「내 계정」 화면에 보이는 것** (본인 확인 대체에 쓸 수 있는 후보): 프로필 사진, 표시 이름, 이메일, 가입일, 가입 수단, 연결된 계정(`account_screen.dart:102-162`, 라벨 `app_ko.arb:85-91` 「표시 이름」「이메일」「가입일」「가입 수단」「연결된 계정」). 앱의 공개 코스 화면은 만든 사람을 보이지 않으므로(연구 항목 3) 표시 이름·가입일은 다른 사용자에게 공개되지 않는 값입니다.
- **선택지:**
  - (가) 이메일 없는 계정은 「내 계정」에 보이는 값(로그인 방식, 표시 이름, 가입일)을 메일에 적게 하고 서버 기록과 대조해 확인한다(오삭제 위험을 사용자가 받아들일지).
  - (나) 이메일 없는 계정은 앱 안 「회원탈퇴」만 안내한다(앱이 없는 사용자의 웹 경로가 비어 Google Play 요건과 부딪힐 수 있음).
  - (다) (가) + 확인을 위해 운영자가 한 번 더 질문하는 단계(예: 가입 수단과 최근 기록 날짜)를 둔다.

### C-5. Apple 「이메일 가리기」 주소 (D-08 제약 ①)
- **사실:** Apple 로그인은 `email`·`name` 범위를 요청하고 가리기 주소를 받을 수 있습니다(데이터 목록 B). 「내 계정」에는 그 가리기 주소가 그대로 보입니다(`account_screen.dart:117-127`). 운영자의 확인 메일은 Apple 발신 도메인 등록(Phase 10, SUP-05) 전에는 도착하지 않습니다.
- **선택지:**
  - (가) SUP-05(Apple 발신 도메인 등록과 릴레이 시험)를 Phase 6 커밋 전으로 당긴다.
  - (나) 등록 전까지 가리기 주소 사용자에게는 C-4의 대체 확인을 쓴다.
  - (다) 등록 전까지 가리기 주소 사용자에게는 앱 안 회원탈퇴를 안내한다(앱 없는 사용자 경로가 비는 문제는 C-4 (나)와 같음).

### C-6. 「확인자료」 문장 (D-15)
- **사실:** Firestore 규칙의 컬렉션은 `identity_index`, `mail`, `courses`, `runs`, `users`(아래 `fcmTokens`, `badges`)뿐이고(`firestore.rules:290, 299, 319, 347, 374, 405, 426`의 `match /`), 앱·함수·문서 어디에도 위치정보 수집·이용·제공사실 확인자료를 따로 기록하는 코드나 컬렉션이 없습니다(앱 저장소 전체에서 「확인자료」·위치 로그 관련 문자열 grep 0건). 위치정보법 제16조②는 「위치정보 수집ㆍ이용ㆍ제공사실 확인자료를 위치정보시스템에 자동으로 기록되고 보존되도록 하여야 한다」고 정합니다 `[CITED: law.go.kr 위치정보법 제16조②]`. 이 차이는 U2(사업 분류)와 Phase 8 위치약관 범위입니다.
- **선택지:**
  - (가) 법 문구대로 「위치정보 동의를 철회하면 개인위치정보와 위치정보 수집·이용·제공사실 확인자료를 지체 없이 파기합니다」라고 쓴다(따로 둔 확인자료가 없으면 지울 것도 없어 거짓은 아님. 다만 제16조② 의무와의 관계는 법률 확인 범위).
  - (나) 확인자료 기록을 앱에 만드는 일을 U2 결론과 함께 정하고, 그 뒤 문장을 쓴다(Phase 6 커밋이 늦어짐).

### C-7. 익명(둘러보기) 계정 문장 (D-26)
> **2026-11-26 메모 (익명 행 정정 뒤).** 아래 C-7 본문은 조사 그대로이고 고치지 않았습니다. 본문이 순수 익명 계정의 서버 데이터를 Auth 레코드(uid), Analytics·Crashlytics에 붙은 uid, 함수 로그로 본 결론은 `users/{uid}` 쓰기만 살핀 것입니다. 익명 호출을 받는 서버 함수 둘(`lookupSignInMethods`, `sendPasswordResetMail`)은 그 uid가 든 `rate_limits` 기록을 만들고, 익명 사용자는 회원탈퇴에 갈 수 없어 이 기록은 만료 시각과 TTL 정책으로만 지워집니다. 고친 사실은 데이터 목록 구간 A 익명 행에 있습니다(`06-EVIDENCE.md` 「익명 행 정정 (재기준 커밋 뒤)」의 `ANON_ROW_FIX_SHA`). 선택지 (가)·(나)·(다)는 그대로입니다.

- **사실 (앱 코드):** 익명 사용자는 설정 맨 위에 「게스트로 이용 중 / 로그인 · 가입」 행이 보이고(`settings_screen.dart:100`, 195-215) 「내 계정」 화면으로 가면 설정으로 되돌려집니다(`auth_guard.dart:265-269`). 그래서 **익명 사용자는 「회원탈퇴」에 갈 수 없습니다.** 익명 사용자의 약관 동의는 기기 안 `SharedPreferences`에만 저장되고(`terms_notifier.dart:19-24`), Firestore 미러는 익명에서 정식으로 바뀔 때(`auth_guard.dart:597-602`)와 정식 사용자의 재동의(`onboarding_screen.dart:133-138`)·가입 기록(`sign_up_method_recorder.dart`)에서만 일어납니다. 익명 로그인 경로(`onboarding_screen.dart:150-158`)와 `AuthRepository.signInAnonymously` 본문(`auth_repository.dart:2925-2941`, `_auth.signInAnonymously()`와 사용자 변환뿐)에는 Firestore 쓰기가 없습니다. `users/{uid}`에 쓰는 나머지 경로도 익명을 거릅니다: 클라이언트 키 세 개(`termsAccepted`·`signUpProviderId`·`customPhotoUrl`, `firestore.rules:48-50`) 가운데 약관 미러는 위 조건, 가입 수단은 가입 확정 때만(`auth_repository.dart:381, 562, 746, 926`), 프로필 사진은 익명이 갈 수 없는 「내 계정」 화면에만 있고, 서버 함수 `mirrorAccountEmail`은 익명 호출을 `failed-precondition`으로 거절합니다(`functions/src/auth/mirror_account_email.ts` Step 0). 기록·코스·뱃지·알림 토큰은 규칙이 익명 쓰기를 막습니다(`firestore.rules:41-45`의 `isRegular()`). 따라서 **확인 범위(위 경로) 안에서는 익명 계정의 `users/{uid}` 쓰기를 찾지 못했고**, 순수 익명 계정의 서버 데이터는 Auth 레코드(uid), Analytics·Crashlytics에 붙은 uid, 함수 로그로 보입니다. 데이터 목록 A·H의 「익명 계정과 그 계정의 `termsAccepted`(Firestore)」와 다르므로 **D-06 재기준에서 확정**합니다(앞으로 Custom Token 함수가 익명 호출자에 쓰는 경로가 생기면 다시 봄). 규칙은 익명의 `users/{uid}` 생성을 허용하므로(`firestore.rules:376-381`) 「쓸 수 있다」와 「앱이 쓴다」를 구분해 재기준에서 고칩니다.
- **사실 (공식 문서):** 「Any anonymous accounts created after enabling automatic clean-up might be automatically deleted any time after 30 days post-creation」, Identity Platform으로 업그레이드한 프로젝트만, 로그인 수단을 연결해 승격한 계정은 지우지 않음 `[CITED: firebase.google.com/docs/auth/web/anonymous-auth]`. **「30일 뒤 언제든」이라 상한이 없습니다.** 자동 정리가 Auth 삭제 트리거(`onDelete`)를 부르는지는 공식 페이지에 없습니다 `[ASSUMED: 미확인]`. 앱의 정리 트리거 주석은 「Admin bulk 삭제(`deleteUsers`)는 이벤트를 내지 않는다」고 적습니다(`cleanup_user_data.ts:12-13`).
- **선택지:**
  - (가) 이번 커밋에는 익명 자동 삭제 문장을 넣지 않고, 「둘러보기(로그인하지 않은 이용)에서는 기록·코스·뱃지를 서버에 저장하지 않는다」만 쓴다(재기준한 목록에 그 사실이 들어간 뒤).
  - (나) 「prod에서 자동 정리를 켬」이 재기준 목록에 들어가면 「만든 지 30일이 지난 둘러보기 계정은 자동으로 지워질 수 있다」처럼 상한 없는 표현으로 쓴다.
  - (다) 둘 다 쓰지 않고 Phase 7 처리방침에서 다룬다.

### C-8. prod 값이 없는 기간 (D-04, D-03)
- **사실:** Storage 소프트 삭제 7일, Cloud Logging 30일, TTL 정책 없음은 모두 dev 값입니다(데이터 목록 H). GCS 소프트 삭제는 「enabled by default … default retention duration of 7 days」, 「between 7 days and 90 days」로 바꿀 수 있고 0이면 꺼집니다 `[CITED: docs.cloud.google.com/storage/docs/soft-delete]`. Cloud Logging 기본 버킷 30일은 공식 문서로 다시 확인하지 못했습니다 `[ASSUMED]`. 해시 `rate_limits`의 보존 기간은 D-05 ②에서 정합니다(아직 없음).
- **함께 정할 prod 값:** Storage 소프트 삭제, Cloud Logging 보존, `fcmTokens` TTL, 해시 `rate_limits` TTL, **Firestore PITR 켜기 여부와 기간, Firestore 예약 백업 여부와 보존 기간**(§대조표 구간 H).
- **제안 (상한 약속 방식):** 표의 기간 칸에는 prod가 넘지 않겠다고 약속하는 상한을 적고, 같은 값을 prod 설정 확인 항목(Phase 10 또는 prod 생성 체크리스트)에 「문서 상한 이하로 설정」으로 등록합니다. 예: Storage 「삭제 뒤 최대 7일」 → prod 버킷 소프트 삭제를 7일(기본값)로 둠. 로그 「최대 30일」 → prod 기본 로그 버킷 보존을 30일 이하로 둠. 해시 `rate_limits` 「최대 N일」 → 앱 작업이 정한 TTL. 값이 정해지지 않은 행은 커밋을 보류합니다(D-03 「정해지지 않으면 다시 묻습니다」).

## 연구 항목 1~15 결과

| # | 사실 | 출처 | 영향 받는 결정 |
|---|---|---|---|
| 1 | 경로: 설정 화면 맨 위 「내 계정」 행(`settingsAccountSection` 「내 계정」, `app_ko.arb:244`) → 계정 화면(AppBar 제목도 「내 계정」, `account_screen.dart:95`) → 맨 아래 「Danger zone」 묶음의 「회원탈퇴」(`settingsWithdrawalLabel`, `app_ko.arb:349`; `danger_zone_section.dart:71-80`; 「항상 최하단 격리」 `account_screen.dart:176-177`). 탭하면 확인 창에서 「탈퇴」를 입력하게 하고(`app_ko.arb:355-357`), 연결된 제공자가 있으면 연결 해제 진행 화면으로 갑니다(`withdrawal_confirmation_dialog.dart:157-165`). 서버는 `auth_time` 300초(5분) 안의 새 로그인을 요구합니다(`delete_user_account.ts:171-191`, `assertFreshAuth`). 재로그인이 필요한 연결 해제 행의 로그인이 이 5분 조건을 겸합니다(`withdrawal_disconnect_notifier.dart:11-13`). 모든 행은 건너뛸 수 있습니다(같은 파일 14행 「D-12: 모든 행은 건너뛸 수 있다 — 탈퇴는 항상 끝난다」). | 앱 코드 `[VERIFIED]` | D-16 ①, DEL-04. FAQ 경로 「설정 → 내 계정 → 회원탈퇴」와 일치 |
| 2 | 「내 계정」에 보이는 것: 프로필 사진, 표시 이름, 이메일(없으면 「-」), 가입일, 가입 수단, 연결된 계정, (가능하면) 계정 연결, 로그아웃, Danger zone. 사용자 ID(uid)는 보이지 않음(`authAccountUid` 라벨은 있으나 이 화면에서 쓰지 않음). | `account_screen.dart:43-46`, 102-177; `app_ko.arb:85-91` `[VERIFIED]` | D-08 메일 항목: 「로그인 방식(가입 수단·연결된 계정에 보이는 이름)」「계정 이메일(내 계정 화면의 이메일)」. 대체 확인 후보: 표시 이름·가입일 (C-4) |
| 3 | 앱은 코스 화면에 만든 사람(이름·사진)을 보이지 않습니다. 본인 코스에만 「내 코스」 표시(`courseMine` 「내 코스」, `app_ko.arb:287`. 이 키의 arb 설명은 생성 파일 주석 기준 「Phase 5 CONTEXT D-03 — status mark on a course I created (no icon, no creator name shown)」, `lib/l10n/generated/app_localizations.dart:1423`). 코스 목록·상세의 `creatorId`는 「내 코스인가」 판정에만 쓰입니다(`course_list_provider.dart:50`, `course_detail_screen.dart:93`, 193). 그래서 탈퇴 뒤에도 다른 사용자에게 공개 코스는 탈퇴 전과 똑같이 보입니다. | 앱 grep·arb `[VERIFIED: grep + arb 읽음]` | D-01 문장: 「공개 코스에는 만든 사람의 이름이나 사진이 표시되지 않으며, 탈퇴 뒤에도 코스 내용(이름·경로·지역)은 다른 사용자에게 계속 보입니다」 |
| 4 | 코스 삭제: 코스 상세 ⋮(「더보기」) → 「코스 삭제」(본인 코스만, 공개 코스 포함, 뱃지는 남음). 프로필 사진: 「내 계정」 → 프로필 사진 → 「올린 사진 삭제」. **기록 삭제 화면 없음, 뱃지 삭제 화면 없음.** | `app_ko.arb:302-306`, 391; `course_delete_menu_button.dart:1-40`; `run_repository.dart:153-157`(호출처 없음) | **C-2**. D-10·D-11 ②·D-14 |
| 5 | Google·Apple 모두 탈퇴 중 연결 해제 단계가 있음. Apple Android는 코드가 `[ASSUMED]`로 표시. | `disconnect_steps.dart:36-49`, `google_disconnect_step.dart:49-71`, `apple_disconnect_step.dart:13-19`, 57-77 `[VERIFIED]` | **C-3**. D-19 |
| 6 | 확인자료를 따로 기록하는 저장소 없음. 기록 문서 `runs/{runId}`에 `startedAt`·`endedAt`·`userId`가 있을 뿐임(데이터 목록 C). | `firestore.rules` `match /` 목록, 앱 저장소 grep 0건 | **C-6**. D-15 |
| 7 | Meta 공식 페이지에서 확인한 것: 「all apps must inform users in their privacy policy how to request deletion of their data」, FAQ 「Developers need to specify either a data deletion callback instruction URL or a callback URL found in Basic Settings for your app.」, 사용자가 Facebook 설정에서 삭제를 요청하면 Meta가 개발자에게 알림을 보내고 「Every 21 days, you will receive an alert including the user identifiers you are required to delete」, 「we do require developers to promptly delete user data upon the request of a user」. Platform Terms 4.b(한국어판) 「사용자가 해당 데이터의 삭제를 요구하는 방법을 정확하고 명확하게 설명해야 합니다」, 3.d.i 「합당한 시일 내에 최대한 빠르게」·「관련 법규나 규정에 의해 … 유지하도록 요구되지 않는 한」. **Instructions URL 페이지에 들어가야 할 문장 기준은 공식 페이지에서 관찰하지 못했습니다**(없다는 뜻이 아님). | `[CITED: developers.facebook.com/documentation/development/create-an-app/app-dashboard/data-deletion-callback.md]`, `[CITED: developers.facebook.com/terms/dfc_platform_terms/]`, `[CITED: developers.facebook.com/docs/development/terms-and-policies/privacy-policy/]` | §요건 체크리스트. 운영자 절차(D-07)에 「Meta 앱 대시보드 고급 설정의 User Data Deletion Requests 확인(21일마다 알림, 파일 60일 보관)」을 더할 것 |
| 8 | Google Play 원문: 「provide a web link resource where users can request app account deletion and associated data deletion. You have the opportunity to show users if you delete other data too.」, 「The weblink must be functional …, relevant in scope (for example, the pathway to request account deletion should be prominently featured and easily discoverable on the page) and reference the app or developer name (that is, as it appears on your store listing in Google Play). The user must be able to request deletion of their account through the pathway. You can offer this in many ways, like … a customer service email …」, 「your web resource should give users a way to request that their data be deleted without sending the user back to the app and requiring them to re-download it」, 보존: 「you must clearly inform users about your data retention practices, for example, within your privacy policy.」, 기한: 「You should let users know what to expect and complete their requests within a reasonably quick period of time.」 | `[CITED: support.google.com/googleplay/android-developer/answer/13327111 (2026-11-20 원문 수신)]` | §요건 체크리스트. Play Console 입력 칸의 「삭제·보존 데이터 유형과 추가 보존 기간을 적을 것」 목록은 이번에 원문으로 보지 못함 `[ASSUMED]` |
| 9 | 시행령 제43조③ 「받은 날부터 10일 이내」, 법 제36조② 「지체 없이」, 법 제37조③(동의 철회) 「지체 없이 … 파기」. 시행령 제41조②: 요구 방법은 「서면, 전화, 전자우편, 인터넷 등 정보주체가 쉽게 활용할 수 있는 방법」, 「최소한 개인정보를 수집한 창구 또는 방법과 동일하게」, 「홈페이지에 … 방법과 절차를 공개」(제43조①이 준용). | `[CITED: law.go.kr]` (원문 HTML에서 조문 추출) | **C-1**. 「수집한 창구와 동일」: 수집은 앱에서 했으므로 앱 안 회원탈퇴 + 메일 두 경로가 이 조건을 충족하는 방향 |
| 10 | 위치정보법 제24조④ 원문에는 **단서가 없습니다**(괄호로 「동의의 일부를 철회하는 경우에는 철회하는 부분의 … 한정한다」만 있음). 제23조① 단서: 「다른 법률에 따라 보유하여야 하거나 대통령령으로 정하는 정당한 사유가 있는 경우」. 제16조② 확인자료 자동 기록·보존 의무. | `[CITED: law.go.kr 위치정보법(2025. 10. 1. 시행)]` | D-12(「지체 없이」 문구는 법과 같음), D-15·**C-6**, **C-1** |
| 11 | GA4 표준 속성의 사용자 수준·이벤트 수준 데이터 보관 선택지는 2개월과 14개월(26·38·50개월은 「360 only」). 보관 기간은 「User-ID」 등 사용자 식별자에 붙은 데이터에 적용. 페이지는 Firebase 연결 속성을 따로 말하지 않음. 「Large and XL properties are limited to 2 months」. | `[CITED: support.google.com/analytics/answer/7667196]` | D-24 「최대 14개월」은 표준 속성에서 참. **전제:** 속성이 360이 아니고 BigQuery 내보내기를 켜지 않았음(둘 다 미확인 `[ASSUMED]`, 작업 12에 추가 권장) |
| 12 | 자동 정리: Identity Platform 필요, 「30일 뒤 언제든」 삭제될 수 있음(상한 없음), 승격 계정 제외, 끄더라도 예약된 삭제는 유지. `onDelete` 트리거 여부는 문서에 없음. 확인 범위 안에서 익명 계정의 `users/{uid}` 쓰기를 찾지 못함(C-7). 요금제 조건은 이 페이지에서 확인 못 함 `[ASSUMED]`. | `[CITED: firebase.google.com/docs/auth/web/anonymous-auth]`, 앱 코드 | **C-7**. D-26 「남는다면 앱 작업에 정리 단계를 더할지」는 재기준(D-06)에서 익명 쓰기 경로가 없다고 확정되면 묻지 않아도 되고, 하나라도 나오면 사용자에게 묻습니다 |
| 13 | §제공자별 연결 해제 공식 도움말 참고 | — | D-19 ③ |
| 14 | 앱 HEAD `21d5c86c`(2026-11-19). `git diff --stat 3afb2085..HEAD`: `.claude/CLAUDE.md`, `.claude/rules/*.md` 네 파일뿐. 작업 트리 미커밋 변경: `.planning/config.json`, 스플래시·아이콘 이미지, `docs/brand/make_icon.py` 삭제, 추적 안 하는 문서·SVG. `config/dev.json`을 다시 열어 18행 `enabledAuthProviders` = `google,apple,facebook,kakao,naver,line`, 19행 `emailDelivery` = `""` 확인(데이터 목록과 같음). **D-05 1~3은 들어오지 않았습니다.** | 앱 저장소 git `[VERIFIED]` | D-05·D-06·D-25 ①② 그대로 차단 |
| 15 | 카카오·네이버·LINE은 이메일 없이 계정이 만들어지는 코드 경로가 있음. 콘솔 필수 여부 미확인. | 항목 C-4 참고 | **C-4** |

## 데이터 목록 G·E 대조 (지워짐 / 남음)

재기준(D-06) 전의 목록(기준 `3afb2085`)과 이번 연구 결과를 합친 초안입니다. 「의존」 칸이 있는 행은 D-05 앱 작업이나 prod 값이 정해져야 확정됩니다. 본문은 재기준한 목록으로 씁니다.

### 구간 G

| 목록 행 | 분류 | 남는 이유 / 기간 (사이트 문장 초안) | 의존 |
|---|---|---|---|
| Storage `users/{uid}/` 아래 객체 (프로필 사진) | 지워짐 (탈퇴 즉시) | 지운 파일은 복구용으로 「삭제 뒤 최대 7일」 보관된 뒤 사라짐 → 「남는 데이터」 표에 「프로필 사진 복구용 사본 | 실수로 지운 파일 복구를 위한 저장소 기본 기능 | 삭제 뒤 최대 7일」 | prod 버킷 소프트 삭제 값 (C-8) |
| Firebase Auth 계정 | 지워짐 (탈퇴 즉시) | Google 공식: 「data is removed from live and backup systems within 180 days」 → 표: 「로그인 계정 기록의 백업 | Google(Firebase)이 백업에서 지우는 데 걸리는 시간 | 삭제 뒤 180일 안」 | 없음 (공식 문서) |
| `identity_index` (`firebaseUid == uid`) | 지워짐 | — | 없음 |
| `users/{uid}` (약관 동의, 연결된 제공자, 이메일 사본 등) | 지워짐 | — | 없음 |
| `users/{uid}/fcmTokens/*` | 지워짐 (실패하면 TTL) | 실패 경로는 TTL 정책에 따름. dev에는 TTL 정책 없음 | prod TTL 정책 (설정하지 않으면 실패 시 남음). 본문에는 「지워짐」으로 쓰고, prod 체크리스트에 `fcmTokens.expireAt` TTL 켜기 추가 권장 |
| `runs` (`userId == uid`, GPS 궤적 포함) | 지워짐 (Auth 삭제 트리거) | — | 없음 |
| `users/{uid}/badges/*` | 지워짐 (Auth 삭제 트리거) | — | 없음 |
| `courses` 공개 | **남음** | 「다른 사용자가 계속 볼 수 있는 공개 코스이고, 만든 사람의 이름·사진은 표시되지 않음 | 서비스를 운영하는 동안」. 탈퇴 전에는 코스 상세 「코스 삭제」로 직접 지울 수 있음(앱이 공개 코스 삭제도 허용, `firestore.rules:332`) | 없음 (D-01). 「기간」 칸 문구는 사용자 확인 권장 |
| `courses` 비공개 | 지워짐 | — | **D-05 ①** (지금 코드는 남김) |
| `rate_limits` uid 문서 | 지워짐 | — | **D-05 ②** |
| `rate_limits` 해시 문서 (IP·이메일 SHA-256 앞부분) | **남음** | 「요청 횟수 제한 기록(IP·이메일을 알아볼 수 없게 바꾼 값) | 남용 방지 | 최대 N일」 | **D-05 ②의 TTL 값** (C-8) |
| `mail` (dev 미사용) | prod 발송 모드에 따름 | prod `emailDelivery`가 빈 값이면 해당 없음(표에서 뺌). `kit`이면 「인증·비밀번호 재설정 메일 대기열 | 최대 1일(확장 TTL)」 | P1·N6·U5 (prod 메일 모드, 이메일 가입 노출). 소셜 전용이면 행 없음 |
| Analytics에 붙은 uid | **남음** | 「앱 사용 통계(Google Analytics) | 서비스 개선 통계. 앱이 삭제 API를 부르지 않음 | 최대 14개월」 | 표준 속성·BigQuery 내보내기 없음 전제 (항목 11) |
| Crashlytics에 붙은 uid | **남음** | 「오류 보고(Crashlytics) | 앱 오류 추적 | 90일이 지나면 지우기 시작」 ※ 공식 문장은 「for 90 days before starting the process of removing it」이라 완료 시점이 없음. 「90일 뒤 삭제」로 쓰면 절대 표현이 됨 | 없음 |
| Cloud Functions 로그의 uid | **남음** | 「서버 작동 기록 | 오류 추적·운영 확인 | 최대 30일」 | prod 로그 버킷 보존 (C-8) |
| 제공자 쪽 앱 연결 | 앱 탈퇴: 여섯 제공자 모두 해제 시도(건너뛰기 가능). 메일 요청·건너뛰기: 사용자가 직접 해제 | 표가 아니라 제공자 섹션과 「삭제 요청 방법」에서 안내. 남는 곳은 러닝펜슬이 아니라 제공자 쪽 「연결된 앱」 목록 | C-3, 운영자 도구 범위 |

### 구간 E (G에 없는 행)

| 목록 행 | 분류 제안 | 근거 / 비고 |
|---|---|---|
| App Check 기기 증명 토큰 | 표에서 뺌 (계정 데이터 아님) 또는 「최대 30일」 행 | 「앱이 저장하지 않음」, 토큰 최대 7일·재전송 방지 최대 30일(공식). uid와 묶이는지는 목록에 없음. 계획자·사용자 선택 |
| Remote Config·FCM의 Firebase installation ID | 결정 필요 | 공식: 「retains Firebase installation IDs until the Firebase customer makes an API call to delete the ID. After the call, data is removed … within 180 days.」 앱은 삭제 API를 부르지 않음 → 지금은 **상한 없음**. 선택: (가) 기기 단위 식별자라 계정 데이터 표에서 빼고 「앱을 지우면 …」 문장으로만(재설치·삭제 동작은 `[ASSUMED]`), (나) 앱 작업에 탈퇴 때 installation 삭제 호출을 더하고 「삭제 뒤 180일 안」으로 씀 |
| 기기 안 설정 (`SharedPreferences`) | 「서버 삭제 대상 아님」 문장 | 목록 E: 「탈퇴 때 서버에서 지우는 대상이 아님」, 등록 토큰 키만 로그아웃 때 지움. 「앱을 삭제하면 함께 지워진다」는 OS 동작이라 `[ASSUMED]` |
| Facebook SDK 자동 이벤트 | 표에 넣지 않음 | 실제 전송 미확인(N1). Phase 7에서 다룸 |
| 기기 안 원시 GPS 로그 `active_run.jsonl` (구간 C) | `#location`에 한 줄 후보 | 정상 종료면 저장 직후 앱이 지움. 비정상 종료 때 남는 기간 미확인 → 「기록 중 기기 안에 잠시 두는 위치 파일은 기록을 저장하면 지운다」까지만 사실 |

### 구간 H (G·E에 없지만 「남는 데이터」 기간에 영향을 주는 보존 값)

| 목록 행 | dev 값 | prod | 표에 미치는 영향 |
|---|---|---|---|
| Firestore PITR | 꺼짐, 버전 보존 1시간 | 미정 | prod에서 PITR을 켜면 지운 문서(기록·GPS 경로 포함)가 최대 7일 동안 복구 가능한 상태로 남음 `[ASSUMED: PITR 보존 기간 7일은 공식 문서로 이번에 확인하지 않음]`. 켜면 「Firestore 복구용 기록 | 최대 N일」 행 추가, 끄면 행 없음 |
| Firestore 백업 일정 | 없음 | 미정 | prod에서 예약 백업을 두면 그 보존 기간만큼 백업에 남음. 두면 행 추가 |
| Firebase Authentication 로그의 IP | 공식: 「몇 주」(데이터 목록 H 「로그의 IP는 몇 주」) | Google 고정 | 숫자 상한이 없는 공식 표현. 표에 넣는다면 「Google이 몇 주 동안 보관」처럼 공식 표현 그대로 쓰거나 Phase 7 처리방침으로 넘김 |
| Storage 소프트 삭제 | 7일 | 미정(GCS 기본 7일, 7~90일·0) | G 대조표 Storage 행 |
| Cloud Logging 기본 버킷 | 30일 | 미정 | G 대조표 로그 행 |
| Firestore TTL (`fcmTokens.expireAt`, `mail`, `rate_limits`) | 정책 없음 | 미정 | G 대조표 해당 행 |

→ C-8의 상한 약속 목록에 **Firestore PITR·백업**을 더합니다. prod에서 켤지 정하지 않았다면, 이번 문서는 「켜지 않음」을 전제로 쓰고 prod 체크리스트에 「켜면 삭제 안내 표에 행을 더한 뒤 켬」을 넣는 방식을 권합니다(사용자 결정).

### 「지워지는 데이터」 범주 목록 초안 (`ul`)
계정 정보(로그인 계정, 연결된 로그인 수단, 약관 동의 기록, 계정 이메일 사본) · 직접 올린 프로필 사진 · 달린 기록과 GPS 경로 · 뱃지 · 비공개 코스(D-05 ① 뒤) · 알림을 받는 기기 토큰 · 요청 횟수 기록 가운데 계정에 연결된 것(D-05 ② 뒤).

## Google Play·Meta 요건 체크리스트

| # | 요건 (원문) | 출처 | 재작성 문서에서 충족하는 곳 |
|---|---|---|---|
| GP-1 | 「provide a web link resource where users can request app account deletion and associated data deletion」 | Google Play 13327111 | `#request` 조항 ② 메일 경로 |
| GP-2 | 「the pathway to request account deletion should be prominently featured and easily discoverable on the page」 | 같음 | 소개 문단 바로 아래 첫 조항, 첫 화면 안 (§Validation 「첫 화면」 판정) |
| GP-3 | 「reference the app or developer name (… as it appears on your store listing in Google Play)」 | 같음 | 소개 문단의 「러닝펜슬」 + `store_developer_name` 값 |
| GP-4 | 「The user must be able to request deletion of their account through the pathway」, 「a customer service email」 허용 | 같음 | `mailto:` 링크 + 메일에 적을 내용 |
| GP-5 | 「without sending the user back to the app and requiring them to re-download it」 | 같음 | 메일 경로는 앱 없이 끝남. 본인 확인 대체(C-4·C-5)가 「앱을 다시 설치하라」로 가지 않게 주의 |
| GP-6 | 「If the user needs to take additional steps … this must be clearly outlined」 | 같음 | 본인 확인 답장 단계, 앱 경로의 재로그인·연결 해제 단계를 짧게 적음 |
| GP-7 | 「you must clearly inform users about your data retention practices」 | 같음 | 「남는 데이터」 표 (Phase 7 처리방침에도 같은 사실) |
| GP-8 | 「You have the opportunity to show users if you delete other data too」 (일부 삭제는 선택) | 같음 | 「일부만 지우기」 조항(C-2 결과에 따라) |
| GP-9 | 「complete their requests within a reasonably quick period of time」 + 현지 법 확인 권고 | 같음 | 처리 기간 조항(C-1 결과) |
| GP-10 | 「the data deletion section should be highlighted and reasonably prominent (for example, through an anchor link)」 (처리방침을 쓸 때) | 같음 | 전용 페이지라 해당 없음. 앵커 `#request`는 유용 |
| M-1 | 「Developers need to specify either a data deletion callback instruction URL or a callback URL」 | Meta data-deletion-callback FAQ | Phase 10에 `/data-deletion/#facebook` 등록. 앱에는 콜백 함수가 없음(`functions/src/index.ts`에 없음) |
| M-2 | 「all apps must inform users in their privacy policy how to request deletion of their data」 | 같음 | Phase 7 처리방침이 이 문서로 링크 (이 단계 범위 밖, Phase 7 입력) |
| M-3 | Platform Terms 4.b 「사용자가 해당 데이터의 삭제를 요구하는 방법을 정확하고 명확하게 설명」, 「정보 삭제를 요청할 권리를 제공」 | dfc_platform_terms | `#facebook` 섹션 + `#request` |
| M-4 | 3.d.i 「삭제 요청을 받은 후 신속하게」·「합당한 시일 내에 최대한 빠르게」, 법령 보존 예외 | 같음 | 처리 기간 조항. 운영자 절차에 Meta 대시보드 삭제 요청 목록 처리 추가 |
| M-5 | 「Every 21 days, you will receive an alert including the user identifiers you are required to delete」 (파일 60일 보관) | data-deletion-callback FAQ | 사이트 문장 아님. D-07 운영 절차에 넣음(Facebook ASID → uid 조회 방법은 운영자 도구 범위, `[ASSUMED]`) |

## 제공자별 연결 해제 공식 도움말 (D-19 ③)

| 제공자 | 공식 페이지 | 확인한 경로 | 신뢰 |
|---|---|---|---|
| Google | https://support.google.com/accounts/answer/13533235?hl=ko 「Google 계정과 다른 개발자의 앱 간 연결 관리하기」 | `myaccount.google.com/linkedapps` → 앱 선택 → 「액세스 권한 삭제」 (「Google 계정 연결」 방식이면 「연결 삭제」) | `[CITED]` |
| Apple | https://support.apple.com/ko-kr/102571 「Apple로 로그인으로 앱 관리하기」 | iPhone 설정 → [사용자 이름] → 「Apple로 로그인」 → 앱 선택 → 삭제. 웹: account.apple.com → 로그인 및 보안 → Apple로 로그인 | `[CITED]` |
| Facebook | https://www.facebook.com/help/170585223002660 「Facebook에 추가한 앱 또는 게임 삭제하기」 (한국어) | 설정 및 개인정보 → 설정 → 「앱 및 웹사이트」 → 삭제 | `[CITED]` |
| LINE | https://help.line.me/line/smartphone?lang=ko&contentId=200001131 「'연동 중인 앱'은 무엇이며 연동 해제는 어떻게 하면 되나요?」 | 홈 → 설정 → 계정 → 「연동 중인 앱」 → 해제할 서비스 → 「연동 해제」 → 「확인」 (메인 기기 기준, 페이지 본문 수신) | `[CITED]` |
| 카카오 | **공식 도움말 미발견** (cs.kakao.com 도메인 한정 검색 결과에 「연결된 서비스」 해제 문서 없음) | 비공식 자료의 경로: 카카오톡 → 설정 → 카카오계정 → 연결된 서비스 관리 | `[ASSUMED]` |
| 네이버 | **공식 도움말 미발견** (help.naver.com 도메인 한정 검색 결과 0건) | 비공식 자료의 경로: 네이버 → 내정보 → 이력관리 → 연결된 서비스 관리 | `[ASSUMED]` |

- **대체안 (카카오·네이버):** URL을 추측해 쓰지 않습니다. (가) 「카카오계정(또는 네이버 ID) 설정의 연결된 서비스 관리에서 러닝펜슬 연결을 끊을 수 있습니다」처럼 메뉴 이름만 일반 표현으로 쓰고 링크는 두지 않음, (나) 사용자가 앱에서 실제 메뉴를 보고 경로를 확인해 주면 그 경로를 씀. 앱 문구 「{provider} 계정 설정에서 이 앱의 연결을 직접 해제해 주세요」(`app_ko.arb:372`)와 같은 수준의 표현이 안전합니다.

## 현재 `data-deletion/index.html`과 바뀌는 것

현재 파일(33행) `[VERIFIED: data-deletion/index.html:1-33]`:

```
---
layout: legal
title: "데이터 삭제 안내"
description: "러닝펜슬 계정 및 사용자 데이터 삭제 방법과 삭제되는 데이터 항목을 안내합니다."
eyebrow: "DATA DELETION"
heading: "사용자 데이터 삭제 안내"
updated: "2026년 10월 31일"
noindex: true
---
```
본문: 「설정 → 계정 삭제」(틀린 경로), 「30일 이내 … 모두 파기」(절대 표현), 「포인트, 코스북 진행 상황」, 「직접 창작하여 업로드한 코스」(삭제된다고 적음, D-01과 반대), 「굿즈 교환 시 입력한 수령인 정보와 배송지 주소」, 「전자상거래 거래 기록」, 끝 `<footer>` 「본 안내는 임시 게시본이며 …」.

| 항목 | 바꿀 것 |
|---|---|
| `title` | 그대로 「데이터 삭제 안내」 (`EXPECTED_TITLES` `data-deletion/index.html|데이터 삭제 안내 - 러닝펜슬`, `scripts/check-site.sh:21`) |
| `heading` | 「러닝펜슬 계정·데이터 삭제 안내」 (D-17) |
| `eyebrow` | 그대로 `DATA DELETION` |
| `description` | 새 내용 요약. 레이아웃이 `{{ page.description }}`를 **escape 없이** 속성에 넣으므로(`_layouts/legal.html:9`) 큰따옴표·`<`·`&`를 쓰지 않음 |
| `updated` | 재작성 커밋 날짜 (「2026년 11월 ○○일」 꼴) |
| `noindex` | 줄 삭제 (레이아웃은 값이 있을 때만 `robots` 출력, `_layouts/legal.html:10-12`) |
| 본문 | 전부 교체. 끝 「임시 게시본」 `<footer>` 삭제. 끝 안내가 필요 없으면 `<footer>`를 두지 않음 (지원 페이지처럼) |

### 재사용할 Liquid 패턴 (`support/index.html:9-17`, `_includes/footer.html:21-33`)
```liquid
{%- if site.data.company.support_email.size > 0 %}
                    <section id="request">
                        <h2>삭제 요청 방법</h2>
                        ...
                        <p><a href="mailto:{{ site.data.company.support_email | escape }}">{{ site.data.company.support_email | escape }}</a></p>
{%- if site.data.company.phone.size > 0 %}
                        <p>전화 {{ site.data.company.phone | escape }}</p>
{%- endif %}
                    </section>
{%- endif %}
```
- 본문 들여쓰기는 기존 파일과 같은 공백 20칸(`section`)·24칸(자식)입니다. `{%-`는 `if`/`endif`에만, 0열에 둡니다.
- 운영 주체 문장은 FAQ처럼 `{{ site.data.company.trade_name | escape }}`를 쓰고, 값 바로 뒤에 조사를 붙이지 않는 꼴(예: 「운영 주체: {{ … }}」 또는 문장 끝 서술어 분리)로 씁니다.
- `_data/company.yml` 현재 키(값은 적지 않음): `trade_name`, `representative`, `biz_reg_no`, `address`, `support_email`, `phone`(빈 값) `[VERIFIED: _data/company.yml:7-12 키 이름만 읽음]`.

### 새 키 이름 권장: `store_developer_name`
- 이유: NAMES.md 행 이름 「스토어 개발자 이름」과 1:1, Phase 9 영문판·Phase 10 체크리스트가 같은 키를 씀, 운영사 표기(`trade_name`)와 다른 값일 수 있음을 이름이 드러냄. 스토어 개발자 이름은 Play·App Store에서 언어별로 바뀌지 않는 한 값이므로 `_en` 접미사가 필요 없습니다 `[ASSUMED]`.
- 줄 모양: `store_developer_name: ""   # 스토어 개발자 이름 (Google Play·App Store 등록 표기 그대로, DEL-02)`. 값은 커밋 직전 대화로 받음(D-18).
- 렌더: 소개 문단 전체를 `{%- if site.data.company.store_developer_name.size > 0 %}`로 감싸면 값이 없을 때 앱 이름까지 사라지므로, **감싸지 않은 앱 이름 문장 + 개발자 이름 구절만 조건부** 또는 **감싸되 check-site 보강(아래)에서 값이 비면 실패**를 권장합니다. D-18은 「값이 없으면 커밋 보류」이므로 어느 쪽이든 커밋 시점에는 값이 있어야 합니다.

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Jekyll (GitHub Pages 내장) | 3.10.0 (로컬 `bundle exec jekyll -v` = `jekyll 3.10.0` 확인) | `legal` 레이아웃 조립, `_data` 읽기 | 운영과 같은 버전 고정(CLAUDE.md) |
| Liquid | 4.0.4 | `site.data.company.<키>.size > 0`, `| escape` | Phase 5에서 검증한 패턴 |
| `_includes/css/legal.css` | 저장소 | 본문 요소·표 감싸개 모양 | 새 CSS 필요 없음 |

### Supporting (검증용, 커밋하지 않음)
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| Playwright | 1.59.1 (Phase 5 스크래치에 설치됨, `node -p` 확인) | Chromium·WebKit 375·1280 화면 확인, 앵커 위치 | 재작성 커밋 후보 판정 |
| pngjs | 7.0.0 (Phase 5 스크래치) | 캡처 비교 | 필요할 때만 |

**새로 설치할 패키지 없음.** Phase 5 스크래치(`<저장소 폴더>-p5-scratch/pw/`)의 `node_modules`를 그대로 쓰거나, Phase 6 스크래치로 `package.json`·`pnpm-lock.yaml`만 복사해 `pnpm install --frozen-lockfile`로 같은 버전을 받습니다. 브라우저 바이너리는 `~/Library/Caches/ms-playwright`에 `chromium-1217`, `webkit-2272`가 있습니다.

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| `mailto:` 링크 | 문의 폼 | 정적 호스팅이라 서버 처리 불가, 프로젝트가 폼을 금지 |
| 제공자 공식 도움말 링크 | 메뉴 경로 직접 서술 | 메뉴 경로는 자주 바뀜. 카카오·네이버는 공식 링크가 없어 일반 표현 |

## Package Legitimacy Audit

| Package | Registry | Age | Downloads | Source Repo | Verdict | Disposition |
|---------|----------|-----|-----------|-------------|---------|-------------|
| playwright | npm | 최신 버전 2026-11-13 게시 | 약 1.8억/주 | github.com/microsoft/playwright | [SUS] (사유 `too-new`: 최신판이 7일 전 게시) | **새로 설치하지 않음.** Phase 5에서 승인한 1.59.1을 재사용. 다시 설치해야 하면 `--save-exact 1.59.1` 고정 + `checkpoint:human-verify` |
| pngjs | npm | 2023-02-20 | 약 1.1억/주 | github.com/pngjs/pngjs | [OK] | 재사용 |

**Packages removed due to [SLOP] verdict:** 없음
**Packages flagged as suspicious [SUS]:** playwright (최신판만 해당. 고정 버전 재사용이면 설치 없음)

## Architecture Patterns

### 정보 흐름 (요청부터 완료까지)

```
[스토어 심사자 / 사용자]
   │  Play Console 계정 삭제 URL, Meta Instructions URL(#facebook), 푸터 링크, /support/ FAQ
   ▼
/data-deletion/  ── (정적 HTML, _data/company.yml 값이 빌드 때 들어감)
   │
   ├─ ① 앱이 있음 ─▶ 앱: 설정 → 내 계정 → 회원탈퇴 ─▶ 연결 해제 단계(6개 제공자, 건너뛰기 가능)
   │                   └▶ deleteUserAccount(5분 안 로그인) ─▶ Storage → Auth → Firestore → fcmTokens
   │                        └▶ Auth 삭제 트리거 cleanupUserData ─▶ runs·badges
   │
   ├─ ② 앱 없음 ──▶ mailto: 지원 이메일 (로그인 방식 + 계정 이메일)
   │                   └▶ 운영자: 계정 이메일로 확인 메일 ─(답장)─▶ 운영자 도구(D-05 ③) ─▶ ①과 같은 삭제
   │                        └▶ 완료 답장 (상한: C-1 결정)
   │
   ├─ #location ─▶ 위치 권한 끄기(기기) / 위치 기록 일괄 삭제 메일(D-14) / 회원탈퇴
   │
   └─ #google … #line ─▶ 그 제공자로 받는 항목 · #request 링크 · 제공자 쪽 해제 공식 도움말
```

### 권장 본문 골격 (조항 순서는 재량, 앵커 이름은 권장)

```
소개 문단 (section 밖 첫 p? → 규칙상 본문 최상위 자식도 허용 요소면 됨. 권장: <section> 하나에 h2 없이 두지 말 것 — 규칙은 section 첫 자식 h2)
#request   삭제 요청 방법           (① 앱 ② 메일, 메일에 적을 내용, 본인 확인 한 줄)
#timeline  처리 기간과 완료 알림     (C-1 결정, 첫 답장 3일과 구분)
#deleted   지워지는 데이터          (ul)
#retained  남는 데이터              (figure > table: 데이터 | 남는 이유 | 기간)
#partial   일부만 지우기            (C-2 결정)
#location  위치정보 동의 철회        (D-11 네 경로, C-6 문장)
#google #apple #facebook #kakao #naver #line   제공자별 안내 (kSocialProviderOrder 순서)
#contact?  문의처                   (운영 주체·지원 이메일·전화(값 있을 때), _data에서)
```
- **소개 문단 위치:** 규칙은 「조항마다 `<section>` 하나, 첫 자식은 `h2`」입니다. 소개 문단을 `section` 밖 최상위 `<p>`로 둘 수 있는지 규칙(D-02·D-04)이 명시하지 않습니다. `.rp-doc > * + *` 간격 규칙(`legal.css:17`)은 최상위 `p`에도 적용되므로 모양은 깨지지 않습니다. 계획자가 (가) 최상위 `<p>` 한 개를 허용(CONVENTIONS에 한 줄 추가) 또는 (나) 첫 조항 `<section>`의 `h2` 아래 첫 `p`로 소개를 넣기 중 하나를 고릅니다. (가)는 규칙 문서 수정이 따르므로 내용 커밋과 같은 단계의 문서 커밋에서 고칩니다.
- **추가 앵커:** D-19 ②가 「공통 삭제 요청 방법 조항으로 링크」를 요구하므로 `#request`는 사실상 필요합니다. 다른 공통 조항 앵커(`#retained` 등)는 선택이고, 한 번 공개하면 바꾸기 어렵습니다(Phase 9 영문판도 같은 이름을 씀).
- **제공자 순서:** 앱의 `kSocialProviderOrder`(`lib/core/auth/provider_order.dart:17-24`: google, apple, facebook, kakao, naver, line)와 `enabledAuthProviders` 값 순서가 같습니다. 이 순서를 권장합니다.

### Anti-Patterns to Avoid
- **값을 본문에 글자로 씀:** 지원 이메일·상호·개발자 이름을 HTML에 직접 쓰면 BIZ-05 위반. 반드시 `site.data.company.*`.
- **절대 표현:** 「모든 데이터를 파기」, 「즉시 완전히 삭제」. Analytics·Crashlytics·백업이 남으므로 금지(ROADMAP Notes). 앱 탈퇴 대화상자의 「이 계정과 모든 데이터는 영구 삭제됩니다」를 옮기지 않음(CONTEXT specifics).
- **dev 값을 prod 사실처럼 씀:** 7일·30일을 근거 없이 단정. C-8 상한 약속 방식으로 씀.
- **허용 목록 밖 요소:** `div`, `span`, `br`, `em`, `code` 등. 쓰면 legal.css·CONVENTIONS·CLAUDE.md를 같은 단계에서 고쳐야 함.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| 삭제 요청 접수 | 폼, JS로 메일 만들기 | `mailto:` 링크 + 「메일에 적을 내용」 목록 | 정적 호스팅, 폼 금지 방침 |
| 값 존재 판정 | `!= blank`, `!= empty`, `and` 섞인 조건 | `.size > 0`, `or`만 | Liquid 4.0.4에서 blank 비교가 늘 참(Phase 5 확인) |
| 표 가로 넘침 | 새 CSS, `display: block` | 기존 `figure tabindex="0" aria-label` 감싸개 | legal.css가 이미 스크롤·그림자 처리 |
| 빌드·점검 | 새 스크립트 | `scripts/check-site.sh <CAND>`, Phase 5 `lib.sh` 함수(`build`·`variant`·`serve`·`live`·`pages_wait`·`vals`) | 운영과 같은 production·`--safe` 빌드 |
| 값 누출 점검 | 손 grep | Phase 5 `vals` 함수에 `store_developer_name` 추가한 판 | `.planning`·커밋 메시지 누출 검사 |

**Key insight:** 이 단계의 위험은 코드가 아니라 문장 속 사실입니다. 새 도구를 만들기보다 「목록에 있는 사실인가」를 grep과 사용자 대조로 확인하는 데 시간을 씁니다.

## Common Pitfalls

### Pitfall 1: 푸터의 mailto 때문에 점검이 거짓으로 통과
**What goes wrong:** `grep 'href="mailto:' _site/data-deletion/index.html`은 모든 페이지 푸터(`_includes/footer.html:32`)의 이메일 행 때문에 본문에 메일 경로가 없어도 통과합니다.
**How to avoid:** 본문 블록(`<div class="rp-doc">`부터 `</article>` 앞 `</div>`까지)만 잘라서 검사합니다. 지금 check-site 7번 항목(`/support/` mailto)도 같은 약점이 있습니다(지원 페이지 본문 `#contact`에도 있어 실제로는 문제없음).
**Warning signs:** 본문 `mailto` 수가 0인데 검사가 통과.

### Pitfall 2: 「Crashlytics 90일」을 삭제 완료 기한으로 씀
**What goes wrong:** 공식 문장은 「for 90 days before starting the process of removing it from live and backup systems」라 완료 시점이 없습니다. 「90일 뒤 삭제」는 사실보다 강합니다.
**How to avoid:** 「90일이 지나면 지우기 시작」 또는 「90일 동안 보관」.

### Pitfall 3: 익명 자동 정리를 「30일 뒤 삭제」로 씀
**What goes wrong:** 공식 문서는 「any time after 30 days」라 상한이 없습니다(C-7).

### Pitfall 4: 「앱에서 기록을 지울 수 있다」
**What goes wrong:** 그런 화면이 없습니다(C-2). 심사자가 앱과 대조하면 불일치.

### Pitfall 5: 제공자 섹션이 서로를 전제함
**What goes wrong:** `#kakao`로 들어온 심사자가 위 조항을 읽지 않으면 이해할 수 없는 문장. D-19는 「그 섹션만 읽어도」를 요구합니다.
**How to avoid:** 각 섹션에 받는 항목 + `#request` 링크 + 해제 안내 세 줄을 모두 둡니다. 받는 항목은 데이터 목록 B 그대로(예: 카카오 `sub`·`email`·`email_verified`·`nickname`·`picture` → 「회원번호, 이메일과 인증 여부, 닉네임, 프로필 사진(제공에 동의한 경우)」. 「동의한 경우」는 B의 필수/선택 「미확인」을 반영한 표현).

### Pitfall 6: `description`의 따옴표
**What goes wrong:** 레이아웃이 `{{ page.description }}`를 escape 없이 `content="…"`에 넣습니다(`_layouts/legal.html:9`). 큰따옴표가 들어가면 meta 속성이 깨집니다.

### Pitfall 7: 값 커밋 전에 값이 `.planning`이나 메시지에 들어감
**What goes wrong:** 개발자 이름 값이 PLAN·SUMMARY·EVIDENCE·커밋 메시지에 남으면 공개 저장소 이력에 영구히 남습니다(D-02).
**How to avoid:** Phase 5 `vals` 점검(값 파일을 만들어 `git grep -F -f`, 개수만 기록)을 `store_developer_name`까지 넓혀 씁니다. 운영사 표기와 같은 값이면 기준 커밋에 이미 공개된 값이라 「excluded」로 빠지는 Phase 5 규칙도 그대로 둡니다.

### Pitfall 8: U10 점검 6번을 재작성 전에 넓힘
**What goes wrong:** 지금 삭제 안내에는 「포인트」「코스북」「굿즈」가 있어, check-site 보강을 재작성보다 먼저 넣으면 훅이 모든 푸시를 막습니다.
**How to avoid:** CONTEXT 순서대로 재작성 라이브 확인 → 별도 build 커밋.

### Pitfall 9: 앵커 위치
**What goes wrong:** 헤더는 고정(sticky)이 아니라(`_includes/css/common.css:8` `.rp-head`에 `position` 없음) 앵커 위치 판정은 `section` 위 끝 0±2px로 충분합니다. 다만 문서 끝 섹션(예: `#line`)은 페이지 높이가 모자라면 맨 위까지 오지 못해 0±2px 판정이 실패할 수 있습니다.
**How to avoid:** 마지막 섹션은 「뷰포트 안에 보임 + 스크롤이 최대치」로 판정하거나, 제공자 섹션 뒤에 문의처 조항을 둡니다.

### Pitfall 10: 「설정 → 내 계정 → 회원탈퇴」 문자열 불일치
**What goes wrong:** 지원 FAQ(`support/index.html:45`)와 화살표·띄어쓰기가 다르면 두 문서가 달라 보입니다.
**How to avoid:** 같은 문자열을 grep으로 대조(`<strong>설정 → 내 계정 → 회원탈퇴</strong>`).

## Code Examples

### 본문 블록만 자르기 (점검 공용)
```bash
# 빌드 결과에서 .rp-doc 본문만 꺼낸다. 레이아웃은 <div class="rp-doc"> 다음 줄부터 본문, 본문 뒤 '                </div>' 한 줄로 닫는다 (_layouts/legal.html:33-35).
doc() { awk '/<div class="rp-doc">/{f=1;next} f && /^                <\/div>$/{exit} f' "$1"; }
D=$(doc "$W/c2/site/data-deletion/index.html")
printf '%s\n' "$D" | grep -c 'href="mailto:'            # 1 이상
printf '%s\n' "$D" | grep -c ' class='                  # 0
printf '%s\n' "$D" | grep -o '<section id="[a-z]*"' | sed 's/.*id="//; s/"//' | sort | tr '\n' ' '
# 기대: apple facebook google kakao line location naver request (+ 계획이 정한 추가 앵커)
```

### 허용 요소만 쓰였는지
```bash
printf '%s\n' "$D" | grep -o '<[a-z][a-z0-9]*' | tr -d '<' | sort -u \
 | grep -v -x -E 'section|h2|h3|p|ul|ol|li|dl|dt|dd|table|thead|tbody|tr|th|td|figure|strong|a|aside|footer'
# 출력 없음이 통과
```

### 표 감싸개 속성
```bash
f=$(printf '%s\n' "$D" | grep -c '<figure'); t=$(printf '%s\n' "$D" | grep -c '<table')
ok=$(printf '%s\n' "$D" | grep '<figure' | grep -c -E 'tabindex="0".*aria-label="[^"]+"')
[ "$f" -eq "$t" ] && [ "$f" -eq "$ok" ] && echo "OK figure=$f"
```

### U10·U14 낱말 없음 (본문과 head)
```bash
H="$W/c2/site/data-deletion/index.html"
grep -c 'name="robots"' "$H"                      # 0
grep -c '임시 게시본' "$H"                         # 0
grep -o -E '(체크|엔드)?포인트|굿즈|코스북|배송지|전자상거래|수령인' "$H" | grep -v -x -E '(체크|엔드)포인트' | grep -c .   # 0
```

### 앱 경로 문자열이 FAQ와 같음
```bash
S='<strong>설정 → 내 계정 → 회원탈퇴</strong>'
grep -c -F "$S" "$W/c2/site/support/index.html"; grep -c -F "$S" "$H"   # 둘 다 1 이상
```

### 개발자 이름·지원 이메일이 `_data`에서 옴 (값을 찍지 않음)
```bash
# 값 파일은 임시로 만들고 개수만 찍는다 (D-02)
V=$(mktemp); ruby -ryaml -e 'c=YAML.load_file(ARGV[0]); %w[store_developer_name support_email].each{|k| v=c[k].to_s.strip; puts v unless v.empty?}' "$W/c2/src/_data/company.yml" > "$V"
printf '%s\n' "$D" | grep -c -F -f "$V"           # 2 이상 (개발자 이름 1, 메일 링크·글 2)
git show "${CAND}:data-deletion/index.html" | grep -c -F -f "$V"   # 0 (원본에 값을 직접 쓰지 않음, BIZ-05)
rm -f "$V"
```

### 선택 항목 render-if-present (Phase 5 `variant` 재사용)
```bash
# phone 빈 값 / 값 있음 두 변형을 빌드해 본문의 「전화」 수를 센다
variant v-nophone "$CAND" "$W/yml/phone-empty.yml";  doc "$W/v-nophone/site/data-deletion/index.html" | grep -c '전화'   # 0
variant v-phone   "$CAND" "$W/yml/phone-set.yml";    doc "$W/v-phone/site/data-deletion/index.html"   | grep -c '전화'   # 계획이 정한 수
```

## 권장 커밋 순서

Ground Rule(리팩터·시각·내용 분리, 사이트 커밋 → 승인 → 푸시 → 라이브 확인 → 문서 커밋)과 D-25를 지키는 순서입니다.

1. **Wave 0 (사이트 변경 없음):** Phase 6 스크래치 `$W` 준비(Phase 5 `lib.sh`를 복사해 `W` 식만 `-p6-scratch`로, `vals`에 `store_developer_name` 추가), 기준 커밋 빌드·라이브 비교, `06-EVIDENCE.md` 머리. 스크래치 경로 식: `W="$(cd "$(git rev-parse --path-format=absolute --git-common-dir)/.." && pwd -P)-p6-scratch"`.
2. **차단 체크포인트 G-A (사용자):** D-05 ①②③ 앱 작업이 앱 저장소에 들어왔는지. 들어오기 전에는 이후 사이트 작업을 시작하지 않음(문서 초안은 가능).
3. **문서 커밋 D-06 재기준:** `DATA-INVENTORY.md`(기준 앱 커밋 갱신, A 익명 행, C 「본인이 기록을 지울 수 있음」을 화면 기준으로, D·G 연결 해제 행에 Google·Apple, 근거 경로에 `lib/features/settings/data/disconnect/*`, G 비공개 코스·`rate_limits`, Analytics 「최대 14개월(설정 미확인)」), `DECISIONS.md`(U6-가·U6-나·N3 결정됨). `.planning`만 바뀌므로 사이트 출력은 그대로입니다.
4. **차단 체크포인트 G-B (사용자 결정 묶음):** C-1~C-8. 결정 결과를 CONTEXT 보충이나 EVIDENCE에 기록(값 없이).
5. **사이트 커밋 S1 (content, 데이터):** `_data/company.yml`에 `store_developer_name` 키와 값(값은 이 직전 대화로 받음). 템플릿이 아직 참조하지 않으므로 **출력 바이트 동일**을 `diff -r`로 확인. 메시지에 값 금지.
6. **사이트 커밋 S2 (content, 본문):** `data-deletion/index.html` 재작성(front matter 4줄 + 본문). 후보 `CAND`로 check-site·빌드·grep·Playwright·사용자 화면 확인.
7. **푸시 승인(SHA별) → 푸시 → `pages_wait` → 라이브 확인:** 법적 3종 + `/` + `/support/` 200·제목, `data-deletion` 라이브 바이트 = 후보 빌드, 앵커 8개.
   - S1과 S2를 한 번에 푸시할지, S1을 먼저 푸시할지는 계획자 재량(S1만 라이브에 올라가도 출력이 같아 안전).
8. **문서 커밋 D1:** 두 `CLAUDE.md`(방침 표 U10·U14 행 현재 상태, Pages 표 `data-deletion` 행, `_data` 키 목록), `CONVENTIONS.md`(사실값 슬롯 키 목록, `noindex` 문장, 소개 문단 규칙을 정했다면 그것), `ARCHITECTURE.md`·`STACK.md`(`noindex`·Entry Points), `generate-claude-md` 재생성, `NAMES.md` 「스토어 개발자 이름」 행 「들어갈 곳」 = `_data/company.yml`의 `store_developer_name`, `USER-TASKS.md` 운영자 삭제 요청 절차(D-07, Meta 21일 알림 포함) — 절차서를 앱 저장소에 두기로 하면 여기서 빠짐.
9. **build 커밋 B1 (check-site 보강):** (a) 6번 항목 대상에 `data-deletion/index.html` 추가(낱말에 배송지·전자상거래 추가할지 계획자 판단), (b) 새 항목: `data-deletion/index.html`이 있으면 본문 블록에 `mailto:`가 있고 `name="robots"`·「임시 게시본」이 없음, (c) 선택: `$SRC/_data/company.yml`의 `store_developer_name`이 비면 실패. 양성·음성 대조(Phase 5 `mkobj`로 만든 시험 객체)로 판정. 푸시 승인 → 라이브 확인(출력 변화 없음).
10. **문서 커밋 D2:** check-site 항목 수·설명이 바뀌었으므로 두 `CLAUDE.md`의 Deploy 절·STACK/CONVENTIONS의 점검 항목 설명을 고치고 재생성.

## Environment Availability

| Dependency | Required By | Available | Version | Fallback |
|------------|------------|-----------|---------|----------|
| Homebrew Ruby + Bundler | 로컬 Jekyll 빌드 | ✓ | ruby 4.0.9 | — |
| Jekyll | `scripts/check-site.sh` | ✓ | 3.10.0 | — |
| Node.js | Playwright 스크립트 | ✓ | v24.14.0 | — |
| pnpm | 스크래치 설치 | ✓ | 10.33.2 | — |
| Playwright + 브라우저 | 화면 확인 | ✓ (Phase 5 스크래치) | 1.59.1, chromium-1217, webkit-2272 | 같은 버전 재설치(checkpoint) |
| gh CLI | `pages_wait` (Pages 빌드 대조) | ✓ | `/opt/homebrew/bin/gh` | 수동 확인 |
| 앱 저장소 | 재기준·사실 확인 | ✓ (읽기 전용) | HEAD `21d5c86c` | — |
| Phase 5 스크래치 | `lib.sh`·Playwright 재사용 | ✓ (`<저장소 폴더>-p5-scratch`, 함수 10개) | — | 05-01 사양으로 재생성 |

**Missing dependencies with no fallback:** 없음 (사이트 쪽). 앱 작업 D-05는 의존성이 아니라 사용자 게이트입니다.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | `scripts/check-site.sh`(빌드 + 7항목) + 스크래치 `lib.sh`(Phase 5 함수 재사용) + Playwright 1.59.1 스크래치 스크립트 `p6-deletion.mjs`(Chromium·WebKit × 375×812·1280×800) |
| Config file | `scripts/check-site.sh`의 `EXPECTED_TITLES`(바꾸지 않음), Wave 0에서 `$W/lib.sh`, `$W/pw/p6-deletion.mjs`, `$W/yml/*` |
| Quick run command | `scripts/check-site.sh "$CAND"` |
| Full suite command | `scripts/check-site.sh "$CAND"` + `build c2 "$CAND"` + 위 Code Examples grep 묶음 + `node "$W/pw/p6-deletion.mjs" http://127.0.0.1:<포트>` + 변형 빌드 |
| Estimated runtime | check-site 약 2초, 전체 약 60초 |

### Phase Requirements → Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| DEL-01 / SC1 | 본문에 `mailto:` 경로와 「메일에 적을 내용」 목록 | grep (본문 블록) | `doc … \| grep -c 'href="mailto:'` ≥1, `#request` 안 `li` 수 = 계획 값 | ❌ Wave 0 |
| DEL-01 / SC1 | 첫 화면에서 찾음 | Playwright | 1280×800에서 `#request` `h2`와 본문 첫 `mailto` 링크의 `getBoundingClientRect().top < innerHeight`, 375×812에서 `#request` `h2`가 첫 화면 안(메일 링크는 계획이 정한 기준, 예: 1.5 화면 안) | ❌ Wave 0 |
| DEL-02 / SC1 | 앱 이름·개발자 이름 | grep (값 파일) | 본문에 「러닝펜슬」 ≥1, `vals`식 값 파일로 개발자 이름 ≥1 (개수만 기록) | ❌ |
| DEL-03 / SC2 | 지워지는·남는 데이터, 이유·기간 | grep + 사용자 대조 | `#deleted` 안 `li` 수, `#retained` 표 행 수 = 재기준 목록 대조표의 행 수, 각 행 3칸. **목록 일치는 사람이 대조표와 한 줄씩 비교**(자동화 불가 부분) | ❌ |
| DEL-03 / SC2 | U10 낱말 없음 | grep | Code Examples 「U10·U14 낱말 없음」 → 0 | ❌ (B1 뒤에는 check-site가 지킴) |
| DEL-04 / SC3 | 「회원탈퇴」 경로가 FAQ와 같음 | grep | `grep -c -F '<strong>설정 → 내 계정 → 회원탈퇴</strong>'` 두 문서 모두 ≥1 | ❌ |
| DEL-05 / SC2 | 상한·완료 알림 | grep | C-1에서 정한 문구 문자열 1개, 「답장」 ≥1 | ❌ |
| DEL-06 / SC3 | 철회 시 개인위치정보·확인자료 파기 | grep | `#location` 구간에 「개인위치정보」와 「확인자료」(C-6 문구) ≥1 | ❌ |
| DEL-07 / SC4 | 여섯 앵커가 해당 섹션으로 바로 이동 | grep + Playwright | `section id` 목록이 기대 집합과 같음(각 1회). `/data-deletion/#<id>?cb=` 로 열어 `section` 위 끝 0±2px(마지막 섹션은 Pitfall 9 예외), 첫 자식 `h2` 글에 제공자 이름 | ❌ |
| DEL-07 | `#location`도 같음 | Playwright | 위와 같음 | ❌ |
| BIZ-05 / SC5 | `_data`에서만 읽음 | git + grep | 원본 `data-deletion/index.html`에 값 0, `site.data.company.` 참조 ≥2. 값 커밋 S1의 `git diff --name-only` = `_data/company.yml` 하나 | ❌ |
| BIZ-05 / SC5 | 선택 항목 render-if-present | 변형 빌드 | `phone` 빈 값 → 본문 「전화」 0, 값 있음 → 계획 값. `store_developer_name` 빈 값 → 계획이 정한 동작(숨김 + B1 뒤 check-site 실패) | ❌ |
| U14 | `noindex`·임시 게시본 없음 | grep | `name="robots"` 0, 「임시 게시본」 0 | ❌ |
| 규칙 D-04·D-07 | 허용 요소, 클래스 없음, figure 속성 | grep | Code Examples 세 묶음 | ❌ |
| 레이아웃 | 375px 가로 넘침 없음, 콘솔 오류 없음 | Playwright | `scrollWidth == innerWidth`(표는 figure 안에서만 스크롤), console error 0 | ❌ |
| 회귀 | 다른 문서 출력 그대로 | 바이트 비교 | `diff -r "$W/base/site" "$W/c2/site"` 차이가 `data-deletion/index.html` 하나 (S1은 차이 0) | ❌ |
| 매 푸시 | 라이브 | curl | `live <폴더> <cb> <비교 빌드>`: `/`, 법적 3종, `/support/` 200·제목·바이트 동일 | Phase 5 `lib.sh` ✅ |
| D-02 | 개발자 이름 값이 `.planning`·커밋 메시지에 없음 | grep 개수 | `vals` 확장판 → `git grep -l -F -f "$V" -- .planning` 빈 출력, `git log --format=%B <BASE>..HEAD \| grep -c -F -f "$V"` = 0 | ❌ |
| B1 가드 | 보강 항목이 나쁜 커밋을 막음 | 양성·음성 대조 | `mkobj`로 (a) 본문 mailto 없는 삭제 안내 (b) 포인트 낱말 든 삭제 안내 (c) `noindex` 남은 삭제 안내 시험 객체를 만들어 각각 실패, 실제 후보는 통과 | ❌ |

### Sampling Rate
- **사이트 커밋마다:** 후보 SHA로 `scripts/check-site.sh` + 그 커밋의 출력 판정(S1 바이트 동일, S2 의도한 파일만)
- **푸시마다:** 훅 경로 점검 → SHA별 승인 → 푸시 → `pages_wait` → `live`(`?cb=<SHA 12자리>`)
- **Phase gate:** 위 표 전부 + 두 엔진 × 375/1280 캡처를 사용자에게 보이고 문장·대조표 승인

### Wave 0 Gaps
- [ ] `$W/lib.sh` — Phase 5 `lib.sh` 복사, `W` 식만 `-p6-scratch`, `vals`에 `store_developer_name` 포함, `doc` 함수 추가
- [ ] `$W/pw/p6-deletion.mjs` — 제목·h1·robots 없음·앵커 집합·앵커 위치·첫 화면 판정·overflow·console
- [ ] `$W/yml/` — `phone` 빈 값/값, `store_developer_name` 빈 값/값 변형 (가짜 값만, 실제 값 금지)
- [ ] Playwright 재사용 확인 `node -p "require('$W/pw/node_modules/playwright/package.json').version"` = `1.59.1`

## Security Domain

### Applicable ASVS Categories

| ASVS Category | Applies | Standard Control |
|---------------|---------|-----------------|
| V2 Authentication | 간접 (삭제 요청자의 본인 확인) | D-08 계정 이메일 확인 메일 + 답장. 사이트는 절차만 안내 |
| V3 Session Management | no | 정적 사이트 |
| V4 Access Control | 간접 (남의 계정 삭제 방지) | 운영자 도구는 확인이 끝난 uid만 처리(앱 저장소 범위) |
| V5 Input Validation / Output Encoding | yes | 모든 `_data` 출력에 `| escape`. `description`은 escape되지 않으므로 특수문자 금지 |
| V6 Cryptography | no | — |
| V8 Data Protection | yes | 공개 저장소에 값·주소·개발자 이름을 남기지 않음(D-02) |

### Known Threat Patterns

| Pattern | STRIDE | Standard Mitigation |
|---------|--------|---------------------|
| 남의 계정 삭제를 메일로 요청(사칭) | Spoofing / Tampering | 계정 이메일로 확인 메일·답장(D-08). 이메일 없는 계정·Apple 가리기 주소는 C-4·C-5 결정 |
| `_data` 값에 HTML이 들어감 | Tampering (XSS) | `| escape` 필수, 리뷰 grep |
| `mailto:` 값에 헤더 주입 문자 | Tampering | 값은 운영자가 직접 넣는 고정값, `| escape` |
| 공개 저장소에 사업자·개발자 이름 값 누출 | Information Disclosure | `vals` 누출 점검, 메시지에 값 금지 |
| 사이트가 약속한 절차를 운영이 못 지킴 | Repudiation (심사·법적 위험) | 운영자 절차서(D-07)와 사이트 문장을 같은 단계에서 맞춤, C-1 기한 결정 |

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| 정보통신서비스 특례(구 제39조의7) 동의 철회 | 개인정보 보호법 제37조③ 「동의를 철회한 때에는 지체 없이 … 파기」 (2023. 3. 14. 신설) | 2023 개정 | 철회·파기 문장은 제37조 근거로 |
| Facebook 콜백만 | 콜백 또는 Instructions URL 중 하나 | (Meta FAQ, 날짜 미표시) | 콜백 없이 `#facebook` URL로 충족 |
| Google Play 계정 삭제 웹 링크 (2023-12 마감, 연장 2024-05-31) | 데이터 보안 양식의 삭제 질문 필수 | 2023~2024 | Play Console 등록은 Phase 10 |

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | 본인 확인 답장 대기 시간을 10일 기한에서 뺄 근거는 원문에서 찾지 못함 | C-1 | 기한 기산점을 잘못 적으면 법령 위반 표시 |
| A2 | 결과 통지는 답장 메일로 충분한지 | C-1 | 고시 서식 요구 시 운영 절차 수정 |
| A3 | Facebook 계정에 이메일이 없을 수 있음 | C-4 | 대체 확인 대상 범위 |
| A4 | 익명 자동 정리가 `onDelete` 트리거를 부르는지 | C-7 | 익명 계정 정리 범위 |
| A5 | 익명 자동 정리의 요금제 조건 | 항목 12 | prod 설정 시점 |
| A6 | Cloud Logging 기본 버킷 보존 30일(prod 기본값) | C-8 | 로그 행 기간 |
| A7 | GA4 속성이 360이 아니고 BigQuery 내보내기를 켜지 않음 | 항목 11 | 「최대 14개월」이 거짓이 됨 |
| A8 | 카카오·네이버 연결 해제 메뉴 경로(비공식 자료) | 제공자별 해제 | 안내 경로가 틀림 → 일반 표현 권장 |
| A9 | 앱을 지우면 기기 안 설정이 함께 지워짐(OS 동작) | 대조표 E | 기기 설정 문장 |
| A10 | 스토어 개발자 이름은 언어별로 다르지 않음 | 새 키 이름 | Phase 9 키 구조 |
| A11 | Play Console 입력 칸 안내의 「삭제·보존 데이터 유형과 추가 보존 기간」 목록 | 항목 8 | 요건 체크리스트 누락 |
| A12 | Facebook ASID로 uid를 찾는 방법(운영자 도구) | M-5 | Meta 삭제 요청 처리 불가 |
| A13 | Firestore PITR을 켜면 보존 기간이 7일 | 대조표 구간 H | prod에서 켤 때 표 행의 기간 |

## Open Questions (RESOLVED)

계획 단계(2026-11-20)에서 다섯 질문 모두 계획이 처리하는 자리를 정했다. 사용자 결정이 필요한 것은 blocking checkpoint로 두었고 계획자가 대신 고르지 않았다.

1. **D-05 앱 작업은 언제 들어오는가** — RESOLVED: `06-03-PLAN.md` Task 3(blocking `checkpoint:human-action`)이 앱 작업 해시·항목별 경로·U2 결론을 받을 때까지 단계를 멈추고, `06-04-PLAN.md` Task 1이 코드로 확인한다. 운영자 도구의 형태·범위는 앱 쪽 재량이고(06-03 Task 1 요청서 ③), 메일 경로의 연결 해제 문장은 D-32대로 도구 범위와 상관없이 참인 문장으로 쓴다.
   - What we know: 2026-11-20 앱 HEAD `21d5c86c`에 없음.
   - What's unclear: 일정, 운영자 도구의 형태(스크립트/함수)와 범위(제공자 연결 해제 포함 여부).
   - Recommendation: 계획 첫 체크포인트로 두고, 도구 범위가 정해지면 C-3 메일 경로 문장을 다시 봄.
2. **「남는 데이터」의 공개 코스 기간 표현** — RESOLVED: `06-06-PLAN.md` Task 3 물음 (b)(blocking `checkpoint:decision`)에서 사용자가 문구를 정하고(`PUBLIC_COURSE_PERIOD`), `06-13-PLAN.md`가 원고보다 먼저 데이터 목록 공개 코스 행에 적는다. 약관(Phase 8)은 같은 목록 사실을 따른다.
   - What we know: 코드상 기한 없음, 본인은 탈퇴 전 삭제 가능.
   - What's unclear: 「서비스를 운영하는 동안」 같은 표현을 사용자가 받아들이는지, 약관(Phase 8)과의 일치.
   - Recommendation: G-B 묶음에서 함께 확인.
3. **installation ID 행** (대조표 E): 계정 데이터로 볼지, 앱에서 삭제 호출을 더할지. — RESOLVED: `06-03-PLAN.md` Task 2(blocking `checkpoint:decision`, 앱 작업 전)에서 사용자가 keep-out 또는 app-delete를 고른다(`INSTALL_ID`). app-delete면 앱 작업 ⑦이 되고, keep-out이면 설명 문장 여부를 `06-06-PLAN.md` Task 3 물음 (f)에서 정한다.
4. **소개 문단을 `section` 밖에 둘지** (본문 골격): CONVENTIONS 수정 여부. — RESOLVED: `06-07-PLAN.md` assumptions가 (가) 최상위 `<p>` 하나로 정했고(D-16), `06-11-PLAN.md` Task 1·2가 CONVENTIONS와 두 CLAUDE.md 규칙에 한 줄을 더한다. `legal.css` 머리 주석은 출력 바이트 때문에 이 단계에서 고치지 않고 후속으로 넘긴다(06-07 assumptions에 이유).
5. **check-site B1에 개발자 이름 비어 있음 검사를 넣을지** (D-20 재량). — RESOLVED: 넣는다. `06-10-PLAN.md` Task 1이 점검 8번에 삭제 안내 본문의 「러닝펜슬(개발자 」 소개 문단 검사를 넣어, 개발자 이름 값이 비면(소개 문단이 숨으면) 푸시가 멈춘다(음성 시험 `neg8-dev`).

## Sources

### Primary (HIGH confidence — 이번 세션에 직접 읽음)
- 앱 저장소(`~/dv/woody/running_pencil`, HEAD `21d5c86c`): `functions/src/auth/delete_user_account.ts`(1-384), `functions/src/running_pencil/cleanup_user_data.ts`(1-93), `functions/src/index.ts`(1-94), `lib/features/settings/presentation/account_screen.dart`(1-332), `settings_screen.dart`(40-60, 160-240), `_widgets/danger_zone_section.dart`(1-80), `_widgets/withdrawal_confirmation_dialog.dart`(125-170), `withdrawal_disconnect_notifier.dart`(1-60), `data/disconnect/disconnect_steps.dart`(1-80), `google_disconnect_step.dart`(1-86), `apple_disconnect_step.dart`(1-87), `lib/l10n/app_ko.arb`(80-100, 243-271, 280-310, 340-400), `firestore.rules`(30-70, 356-400, `match /` 목록), `lib/features/terms/presentation/terms_notifier.dart`(1-80, 390-440), `lib/core/router/auth_guard.dart`(258-280, 575-615), `onboarding_screen.dart`(120-200), `functions/src/auth/kakao_custom_token.ts`(120-175), `lib/core/auth/provider_order.dart`(17-24), `config/dev.json`(18-19), git log·diff
- 이 저장소: `data-deletion/index.html`, `support/index.html`, `_layouts/legal.html`, `_includes/footer.html`, `_includes/css/legal.css`(1-38), `scripts/check-site.sh`, `_config.yml`, `_data/company.yml`(키 이름만), `.githooks/pre-push`, `.planning/baseline/*`, Phase 5 `05-CONTEXT.md`·`05-01-PLAN.md`·`05-VALIDATION.md`
- 국가법령정보센터 원문(조문 HTML 수신): 개인정보 보호법 제21조·제36조·제37조, 같은 법 시행령 제41조·제43조·제44조, 위치정보법 제9조·제16조·제23조·제24조

### Secondary (MEDIUM — 공식 문서, 웹 수신)
- https://support.google.com/googleplay/android-developer/answer/13327111 (원문 HTML 수신)
- https://developers.facebook.com/documentation/development/create-an-app/app-dashboard/data-deletion-callback.md (원문 수신)
- https://developers.facebook.com/terms/dfc_platform_terms/ (한국어판)
- https://developers.facebook.com/docs/development/terms-and-policies/privacy-policy/
- https://support.google.com/analytics/answer/7667196
- https://firebase.google.com/support/privacy
- https://firebase.google.com/docs/auth/web/anonymous-auth
- https://docs.cloud.google.com/storage/docs/soft-delete
- https://support.google.com/accounts/answer/13533235?hl=ko, https://support.apple.com/ko-kr/102571, https://www.facebook.com/help/170585223002660, https://help.line.me/line/smartphone?lang=ko&contentId=200001131

### Tertiary (LOW — 검색 결과 요약만)
- 카카오·네이버 연결 해제 경로 (비공식 블로그·포럼: extrememanual.net, devtalk.kakao.com) — 사이트 문장 근거로 쓰지 않음
- https://android-developers.googleblog.com/2023/04/giving-people-more-control-over-their-data.html (배경)

GSD `research-plan`·`research-store` 캐시 경로는 쓰지 않았습니다(검색 도구 설정이 모두 꺼져 있어 내장 WebSearch·WebFetch·curl로 직접 확인). `gsd-tools classify-confidence` 결과: `webfetch`·`websearch` = LOW, `context7` = MEDIUM. 이 문서의 「Secondary」는 도구 등급과 별개로 공식 도메인 원문이라는 뜻이며, 법적·심사 판단에는 사용자·법률 확인이 필요합니다.

## Metadata

**Confidence breakdown:**
- 사이트 구조·Liquid 패턴·검증 방식: HIGH — 저장소 파일과 Phase 5 검증 기록을 직접 읽음
- 앱 동작 사실(항목 1~6, 12, 14, 15): HIGH — 앱 코드 직접 읽음. 단 D-05 뒤 다시 확인 필요
- 법령 원문: HIGH(원문 수신) / 해석(30일 충족 여부, 통지서 형식): LOW — 법률 확인 필요
- Google Play·Meta 요건: MEDIUM — 공식 원문 일부 수신, Play Console 칸 안내와 Meta Instructions 기준은 관찰 못 함
- 제공자 해제 링크: Google·Apple·Facebook·LINE MEDIUM, 카카오·네이버 LOW(공식 도움말 미발견)
- prod 기간 값: LOW — prod 프로젝트 없음

**Research date:** 2026-11-20
**Valid until:** D-05 앱 작업이 들어오는 시점까지(앱 사실), 법령·공식 문서는 30일
