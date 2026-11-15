# 데이터 목록 (Data Inventory)

**작성일:** 2026-11-15
**기준:** BASE-03 — 앱 러닝펜슬이 모으고 저장하고 내보내는 개인정보 항목의 필드 단위 목록
**읽는 곳:** Phase 6 삭제 안내, Phase 7 처리방침, Phase 8 약관과 위치약관
**기준 앱 커밋:** 앱 저장소 `running_pencil`의 `3afb2085` (2026-11-13)

> 이 저장소(`SlimPumpkin/runningpencil.com`)는 **PUBLIC**입니다. `.planning/`은 사이트에 배포되지 않지만 GitHub에서 누구나 봅니다. 그래서 이 목록에는 필드 이름, 컬렉션 이름, 경로와 행 번호만 적고 식별자·비밀·호스트 이름·실제 사용자 데이터 값(uid, 이메일, 좌표, 토큰)은 적지 않습니다 (D-18).
>
> 리전과 설정 값은 dev 프로젝트 기준입니다. prod·stg 프로젝트는 아직 없습니다 (D-08). dev에서 확인한 값은 prod 값이 아니며, 그런 칸에는 「근거: dev」를 붙였습니다.
>
> 이 목록은 데이터가 어디서 와서 어디에 저장되고 어디로 가는지의 사실만 적습니다. 수탁, 제3자 제공, 국외 이전의 법적 구분은 Phase 7에서 합니다.
>
> 법률 검토 전 초안입니다.

## 재확인 규칙

앱은 계속 바뀝니다. 이 목록의 행 번호는 모두 기준 앱 커밋 `3afb2085` 기준입니다 (D-09).

1. Phase 6, 7, 8을 시작할 때마다 앱 저장소에서 아래 명령을 돌립니다. 경로 자리에는 「근거로 삼은 경로」 목록의 경로를 모두 넣습니다.

   ```bash
   git -C "$HOME/dv/woody/running_pencil" diff 3afb2085..HEAD -- <근거로 삼은 경로>
   ```

2. 바뀐 파일이 있으면 그 파일을 근거로 삼은 행만 다시 확인해 고칩니다.
3. 고친 뒤 이 머리의 기준 앱 커밋을 그때의 앱 HEAD로 올리고, 행 번호도 새 커밋 기준으로 고칩니다.
4. `config/dev.json`은 앱 저장소가 추적하지 않는 로컬 설정 파일이라 `git diff`에 나오지 않습니다. 재확인 때마다 파일을 직접 다시 엽니다. 이 목록은 그 파일에서 `enabledAuthProviders`와 `emailDelivery` 두 키만 인용합니다.

## 근거로 삼은 경로

앱 저장소 기준 경로입니다. 표의 근거 칸과 본문 문장에서 근거로 쓴 경로를 모두 적습니다.

- `firestore.rules`
- `storage.rules`
- `functions/src/auth/identity_index.ts`
- `functions/src/auth/mirror_account_email.ts`
- `functions/src/auth/delete_user_account.ts`
- `functions/src/auth/kakao_custom_token.ts`
- `functions/src/auth/naver_profile_to_custom_token.ts`
- `functions/src/auth/line_custom_token.ts`
- `functions/src/index.ts`
- `functions/src/shared/region.ts`
- `lib/features/auth/data/auth_repository.dart`
- `lib/features/auth/data/kakao_sdk_client.dart`
- `lib/features/auth/data/line_sdk_client.dart`
- `lib/l10n/app_ko.arb`
- `docs/kit-fork.md`
- `config/dev.json`

## 읽는 법

**본표의 열 열 개** (구간 A, C, D)

- 항목: 필드 하나, 또는 한 덩어리로 다루는 필드 묶음입니다. Firestore 필드는 `컬렉션/{문서}.필드` 꼴로 적습니다.
- 범주: 아래 범주 태그 가운데 하나입니다. 처리방침은 범주로 묶어 쓰고, 이 열로 어느 필드에서 나왔는지 거슬러 올라갑니다.
- 출처: 값이 어디서 오는지입니다 (사용자 입력, 로그인 제공자 응답, 기기 GPS, 서버 기록 등).
- 목적: 앱이 그 값을 쓰는 곳입니다.
- 저장 위치(리전): 값이 저장되는 서비스와 리전입니다. 저장하지 않고 처리만 하면 처리 위치를 적습니다.
- 수탁자: 값을 저장하거나 처리하는 외부 회사입니다. 법적 성격(수탁인지 제3자 제공인지)은 여기서 정하지 않습니다.
- 국외 이전: 값이 국외에 저장되거나 처리되는지에 대한 사실입니다.
- 보유 기간: 값이 남아 있는 기간입니다.
- 삭제 방식: 탈퇴나 본인 삭제 때 값이 어떻게 지워지는지입니다.
- 근거: 앱 저장소의 파일 경로와 행 번호입니다.

**범주 태그 열 개**

- 계정
- 프로필
- 위치 기록
- 코스
- 뱃지
- 외부 요청
- 기기
- 알림
- 분석·크래시
- 서버 보조

**근거 표기**

- 근거 칸의 앱 저장소 경로는 백틱으로 감싼 저장소 기준 전체 경로이고, 행 번호를 `:` 뒤에 붙입니다 (예: `firestore.rules:54-64`). 파일 전체가 근거이면 경로만 적습니다.
- 근거가 코드가 아니면 종류를 글로 적습니다: 「dev 설정 기록(문서)」(앱 저장소의 운영 문서에 적힌 dev 프로젝트 설정), 「공식 문서: 도메인/경로」, 「미확인」.
- 「근거: 코드」는 값이 코드에 상수로 박혀 있다는 뜻입니다 (예: Cloud Functions 리전 `functions/src/shared/region.ts:2`).
- 「근거: dev」는 dev 프로젝트(설정 파일, 운영 문서)에서 확인한 값이라는 뜻입니다. prod 값이 아닙니다.

**「미확인」과 「CLI 미확인」**

- 「미확인」: 이번에 확인하지 못한 칸입니다. 빈 칸이 아니라 글자 「미확인」으로 적습니다. 일부만 확인된 칸은 확인된 부분과 미확인 부분을 함께 적습니다.
- 「CLI 미확인」: dev 프로젝트를 읽기 전용 CLI(`gcloud`, `firebase`)로 조회해야 알 수 있는 값입니다. 사용자가 CLI에 다시 로그인하면 01-08 계획이 채웁니다.

## A. 계정·프로필

| 항목 | 범주 | 출처 | 목적 | 저장 위치(리전) | 수탁자 | 국외 이전 | 보유 기간 | 삭제 방식 | 근거 |
|---|---|---|---|---|---|---|---|---|---|
| Firebase Auth 사용자 레코드 (uid, 이메일, 표시 이름, 사진 URL, 연결된 제공자) | 계정 | 로그인 제공자 응답. 재로그인 때 이메일·표시 이름·사진 URL을 제공자 값으로 갱신 | 로그인과 계정 식별 | Firebase Authentication, 미국 (공식 문서) | Google (Firebase·GCP) | 있음. 미국 (Firebase Authentication은 미국 데이터센터에서만 운영, 공식 문서) | 삭제 요청까지. 삭제 뒤 180일 안에 라이브·백업에서 제거 (공식 문서) | 탈퇴 시 `deleteUserAccount`가 Auth 계정을 삭제 | `functions/src/auth/identity_index.ts:64-92`, `functions/src/auth/delete_user_account.ts:279`, 공식 문서: firebase.google.com/support/privacy |
| `users/{uid}.termsAccepted` (맵: `version`, `service`, `privacy`, `marketing`, `acceptedAt`) | 계정 | 가입 때 약관 동의 화면 (사용자 입력) | 이용약관·처리방침 동의 기록, 마케팅 정보 수신 동의 여부 | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴까지 (본인이 지울 수 없음) | 탈퇴 시 `deleteUserAccount`가 `users/{uid}` 문서를 삭제 | `firestore.rules:54-64`, `firestore.rules:395`, `functions/src/auth/delete_user_account.ts:313-334` |
| `users/{uid}.signUpProviderId` (가입 수단 문자열, 한 번만 기록) | 계정 | 가입 때 앱 또는 Functions가 기록 | 가입 수단 기록 | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴까지 (변경·삭제 불가) | 탈퇴 시 `deleteUserAccount`가 `users/{uid}` 문서를 삭제 | `firestore.rules:82-90`, `functions/src/auth/identity_index.ts:1117`, `functions/src/auth/delete_user_account.ts:313-334` |
| `users/{uid}.customPhotoUrl` (null 또는 Firebase Storage 다운로드 URL, 2048자 이하) | 프로필 | 사용자가 올린 프로필 사진의 주소 | 직접 고른 프로필 사진 표시 | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴 또는 본인 삭제까지 | 본인이 null로 지울 수 있음. 탈퇴 시 `deleteUserAccount`가 `users/{uid}` 문서를 삭제 | `firestore.rules:104-110`, `functions/src/auth/delete_user_account.ts:313-334` |
| `users/{uid}.linkedProviders[]` (`providerId`, `providerUserId` 배열) | 계정 | 로그인 제공자 응답의 회원번호 (Functions가 기록) | 한 계정에 여러 로그인 수단 연결 | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴까지 | 탈퇴 시 `deleteUserAccount`가 `users/{uid}` 문서를 삭제 | `functions/src/auth/identity_index.ts:1106-1124`, `functions/src/auth/delete_user_account.ts:313-334` |
| `users/{uid}.providerLinkedAt` (제공자별 연결 시각 맵) | 계정 | 서버 시각 (Functions가 기록) | 로그인 수단 연결 시각 기록 | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴까지 | 탈퇴 시 `deleteUserAccount`가 `users/{uid}` 문서를 삭제 | `functions/src/auth/identity_index.ts:1113`, `functions/src/auth/delete_user_account.ts:313-334` |
| `users/{uid}.email`, `users/{uid}.emailVerified` (계정 대표 이메일 사본, 인증 여부) | 계정 | Firebase Auth 레코드와 로그인 토큰에서 복사 (Functions가 기록) | 계정 이메일 표시와 확인 | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴까지 | 탈퇴 시 `deleteUserAccount`가 `users/{uid}` 문서를 삭제 | `functions/src/auth/mirror_account_email.ts:71-75`, `functions/src/auth/identity_index.ts:1118-1121`, `functions/src/auth/delete_user_account.ts:313-334` |
| `identity_index/{provider}:{providerUserId}` (필드 `firebaseUid`, `provider`, `providerUserId`, `linkedAt`, `lastSeenAt`) | 계정 | 로그인 제공자 회원번호와 서버 시각 (Functions가 기록, 클라이언트 접근 차단) | 제공자 계정과 앱 계정을 잇는 색인 | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴까지 | 탈퇴 시 `deleteUserAccount`가 `firebaseUid`가 같은 문서를 모두 삭제 | `functions/src/auth/identity_index.ts:1095-1101`, `firestore.rules:290-292`, `functions/src/auth/delete_user_account.ts:313-334` |
| Storage `users/{uid}/` 아래 프로필 사진 (이미지 형식, 5MB 이하, 본인만 읽기) | 프로필 | 사용자가 고른 사진 (정식 사용자만 올림) | 직접 고른 프로필 사진 | Storage 기본 버킷, 위치 미확인 (CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev 버킷 위치도 미확인, CLI 미확인. 결정 목록 「prod 리전」) | 탈퇴 또는 본인 삭제까지 | 탈퇴 시 `deleteUserAccount`가 `users/{uid}/` 아래 객체를 모두 삭제. 실패하면 탈퇴를 멈추고 다시 시도할 수 있음 | `storage.rules:12-19`, `functions/src/auth/delete_user_account.ts:211-215`, `functions/src/auth/delete_user_account.ts:134-141` |
| Email/Password 계정의 이메일·비밀번호 (Firebase Authentication이 보관) | 계정 | 사용자 입력 | 이메일 로그인. 가입 화면 노출 여부는 결정 목록 U5 | Firebase Authentication, 미국 (공식 문서) | Google (Firebase·GCP) | 있음. 미국 (Firebase Authentication은 미국 데이터센터에서만 운영, 공식 문서) | 삭제 요청까지. 삭제 뒤 180일 안에 라이브·백업에서 제거 (공식 문서) | 탈퇴 시 `deleteUserAccount`가 Auth 계정을 삭제 | `lib/features/auth/data/auth_repository.dart:305`, `lib/features/auth/data/auth_repository.dart:368`, `functions/src/auth/delete_user_account.ts:279` |
| 익명 계정 (uid와 그 계정의 `termsAccepted`) | 계정 | 익명 로그인 (uid만 받음) | 가입 전 둘러보기. 코스·기록·뱃지 쓰기는 막힘 | Firebase Authentication, 미국 (공식 문서). `termsAccepted`는 Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | Auth 레코드는 있음. 미국 (공식 문서). `termsAccepted`는 미확인 (prod 리전에 따름. 결정 목록 「prod 리전」) | 기한 없음. 익명 계정 자동 정리가 dev에서 꺼져 있음 (근거: dev 설정 기록(문서)) | 미확인 (익명 사용자에게 탈퇴 메뉴가 보이는지 확인하지 못함. 결정 목록 N3) | `docs/kit-fork.md:445`, `firestore.rules:41-45`, `firestore.rules:322`, `firestore.rules:351`, `firestore.rules:428` |

- 클라이언트가 쓸 수 있는 `users/{uid}` 키는 `termsAccepted`, `signUpProviderId`, `customPhotoUrl` 세 개뿐입니다. 나머지 필드는 Functions(Admin SDK)만 씁니다 (`firestore.rules:48-50`).
- `termsAccepted.marketing`으로 마케팅 정보 수신 동의를 받습니다 (`lib/l10n/app_ko.arb:192`). 마케팅 푸시를 실제로 보내는 기능은 확인하지 못했습니다 (「미확인」. 배포된 푸시 함수는 시험용 `sendTestPush`뿐입니다, `functions/src/index.ts:82`). 결정 목록 N4로 넘깁니다.
- 익명 계정 행: `firestore.rules:41-42`의 주석은 익명 계정이 30일 뒤 지워진다고 적지만, 이는 자동 정리를 켠 경우의 설명입니다. dev에서는 자동 정리가 꺼져 있습니다 (`docs/kit-fork.md:445`, 근거: dev 설정 기록(문서)).

## B. 로그인 제공자별 수신 항목

| 제공자 | 앱이 요청하는 범위 | 서버·앱이 읽는 항목 | 필수/선택 | 근거 |
|---|---|---|---|---|
| 카카오 | OIDC (`serviceTerms`에 `openid`) | ID 토큰의 `sub`, `email`, `email_verified`, `nickname`, `picture` | 미확인 (제공자 콘솔의 동의항목 설정) | `lib/features/auth/data/kakao_sdk_client.dart:103`, `functions/src/auth/kakao_custom_token.ts:130-144` |
| 네이버 | 프로필 API (`/v1/nid/me`) | `id`, `email`, `nickname`, `profile_image` | 미확인 (제공자 콘솔의 동의항목 설정) | `functions/src/auth/naver_profile_to_custom_token.ts:37`, `functions/src/auth/naver_profile_to_custom_token.ts:260-265` |
| LINE | `openid`, `profile`, `email` | ID 토큰의 `sub`, `name`, `picture`, `email` | 미확인 (제공자 콘솔의 동의항목 설정) | `lib/features/auth/data/line_sdk_client.dart:184`, `functions/src/auth/line_custom_token.ts:135-144` |
| Facebook | `email`, `public_profile` | Firebase Auth가 받는 이메일·이름·사진 | 미확인 (제공자 콘솔의 동의항목 설정) | `lib/features/auth/data/auth_repository.dart:3954` |
| Apple | `email`, `name` | Firebase Auth가 받는 이메일(가리기 주소일 수 있음)·이름 | 미확인 (제공자 콘솔의 동의항목 설정) | `lib/features/auth/data/auth_repository.dart:658-660` |
| Google | `GoogleSignIn.authenticate()` 호출. 범위 인자 없음. 기본 범위 미확인 | Firebase Auth가 받는 이메일·이름·사진 | 미확인 (제공자 콘솔의 동의항목 설정) | `lib/features/auth/data/auth_repository.dart:477` |
| 익명 | 요청 없음 | uid만. 코스·기록·뱃지 쓰기는 막힘 | 해당 없음 | `firestore.rules:41-45`, `firestore.rules:322`, `firestore.rules:351`, `firestore.rules:428` |
| Email/Password | 이메일, 비밀번호 (Firebase Authentication이 보관) | 이메일, 비밀번호. 노출 여부는 결정 목록 U5 | 해당 없음 | `lib/features/auth/data/auth_repository.dart:305`, `lib/features/auth/data/auth_repository.dart:368` |

- dev에서 켜진 로그인 제공자는 소셜 여섯 개(Google, Apple, Facebook, 카카오, 네이버, LINE)입니다. 설정 키 `enabledAuthProviders`의 값이 `google,apple,facebook,kakao,naver,line`입니다 (`config/dev.json:18`, 근거: dev). 익명과 Email/Password는 이 키에 없습니다.
- 소셜 제공자의 필수/선택 구분은 앱 코드가 아니라 각 제공자 콘솔의 동의항목 설정이 정합니다. Phase 7·10에서 콘솔 화면으로 확인합니다.
- 이 표는 Phase 7 처리방침의 PRIV-10(로그인 제공자별 수신 항목)의 원본입니다.
