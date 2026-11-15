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
- `functions/src/running_pencil/cleanup_user_data.ts`
- `functions/src/running_pencil/snap_route.ts`
- `functions/src/running_pencil/search_places.ts`
- `functions/src/running_pencil/region/resolve_region.ts`
- `functions/src/running_pencil/region/on_course_written.ts`
- `functions/src/shared/ncp_maps_params.ts`
- `functions/src/shared/naver_api_hub_params.ts`
- `lib/core/location/location_platform.dart`
- `lib/features/runs/application/run_log_store.dart`
- `lib/features/courses/data/course_repository.dart`
- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/Info.plist`
- `infra/router/Caddyfile`
- `infra/router/deploy.sh`
- `pubspec.yaml`
- `lib/features/notifications/domain/fcm_token.dart`
- `lib/features/notifications/application/notification_settings_notifier.dart`
- `lib/core/router/auth_guard.dart`
- `lib/core/analytics/analytics_service.dart`
- `lib/core/analytics/analytics_observer.dart`
- `lib/features/onboarding/presentation/onboarding_screen.dart`
- `lib/features/demo/presentation/demo_screen.dart`
- `lib/core/bootstrap.dart`
- `lib/core/auth/provider_id.dart`
- `lib/core/auth/auth_strategies_registry.dart`
- `lib/core/providers/locale_provider.dart`
- `lib/core/providers/theme_provider.dart`
- `lib/features/onboarding/presentation/onboarding_notifier.dart`
- `functions/src/shared/rate_limit.ts`
- `functions/src/shared/client_ip_hash.ts`
- `functions/src/email/email_hash.ts`
- `functions/src/email/send_verification_mail.ts`
- `functions/src/email/send_password_reset_mail.ts`
- `extensions/firestore-send-email.env`
- `lib/core/config/app_config.dart`
- `lib/features/terms/presentation/terms_notifier.dart`
- `lib/core/location/location_service.dart`
- `lib/features/runs/application/run_notification_permission.dart`
- `lib/features/runs/application/tracking_mode_preference.dart`
- `lib/features/courses/application/directions_app_preference.dart`
- `lib/features/home/application/dismissed_announcement.dart`
- `functions/src/auth/lookup_sign_in_methods.ts`

## 읽는 법

**본표의 열 열 개** (구간 A, C, D, E, F)

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

## C. 위치·기록·코스·뱃지

| 항목 | 범주 | 출처 | 목적 | 저장 위치(리전) | 수탁자 | 국외 이전 | 보유 기간 | 삭제 방식 | 근거 |
|---|---|---|---|---|---|---|---|---|---|
| `runs/{runId}.path` (GPS 궤적, 인코딩 문자열 100,000자 이하) | 위치 기록 | 기기 GPS (기록 중) | 달린 기록의 경로 보관과 표시 | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴 또는 본인 삭제까지 | 탈퇴 시 `cleanupUserData`가 삭제. 본인이 기록을 지울 수 있음 | `firestore.rules:236`, `firestore.rules:347-353`, `functions/src/running_pencil/cleanup_user_data.ts:42-56` |
| `runs/{runId}`의 나머지 필드 (`userId`, `courseId`, `courseTitle`, `policyVersion`, `startedAt`, `endedAt`, `durationSeconds`, `distanceMeters`, `startCheckpointIndex`, `direction`, `movingSeconds`, `isCompleted`, `checkpointHitRatio`) | 위치 기록 | 기록 중 기기가 계산한 값 (시각은 기기 시각) | 달린 기록(시간, 거리, 완주 여부) 보관과 표시 | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴 또는 본인 삭제까지 | 탈퇴 시 `cleanupUserData`가 삭제. 본인이 기록을 지울 수 있음 | `firestore.rules:231-257`, `firestore.rules:347-353`, `functions/src/running_pencil/cleanup_user_data.ts:42-56` |
| `courses/{courseId}` (`creatorId`, `title`, `polyline`, `waypoints`, `sketchPolyline`, `distanceMeters`, `startPoint`, `bounds`, `badgeTemplateId`, `createdAt`, `updatedAt`, `visibility`, `badgeRotationDegrees`, 공개 전환 때 `publishedAt`) | 코스 | 사용자가 지도에 그린 코스 (찍은 웨이포인트와 맞춘 경로) | 코스 저장. 공개로 바꾸면 다른 사용자에게 보임 (공개 전환은 한 방향) | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 기한 없음. 탈퇴 뒤에도 남음 (공개·비공개 모두) | 탈퇴 시 삭제하지 않음 (공개·비공개 모두). 본인이 탈퇴 전에 코스를 하나씩 지울 수 있음. 결정 목록 U6 | `firestore.rules:192-200`, `firestore.rules:319-333`, `functions/src/running_pencil/cleanup_user_data.ts:17-21`, `lib/features/courses/data/course_repository.dart:327` |
| `users/{uid}/badges/{courseId}` (`runId`, `earnedAt`, `title`, 코스 모양 사본 `polyline`, `badgeTemplateId`, `badgeRotationDegrees`) | 뱃지 | 코스를 완주했을 때 앱이 기록 | 완주 뱃지 보관과 표시 (코스가 지워져도 뱃지를 그림) | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴 또는 본인 삭제까지 | 탈퇴 시 `cleanupUserData`가 삭제. 규칙상 본인 삭제 허용 (앱 화면의 삭제 메뉴는 미확인) | `firestore.rules:269-281`, `firestore.rules:426-434`, `functions/src/running_pencil/cleanup_user_data.ts:64-69` |
| `region` (courses·runs·badges 공통 선택 필드, 법정동 단위 지역: `kind`, `emdCode`, `sido`, `sigungu`, `emd`, `sidoLabel`, `sigunguLabel`, `dataVersion`) | 위치 기록 | 코스 출발점 좌표로 서버가 판정한 법정동 (`resolveRegion`, `onCourseWritten`) | 코스·기록·뱃지를 지역으로 묶어 보여 줌 | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 담긴 문서를 따름 (코스는 기한 없음, 기록·뱃지는 탈퇴 또는 본인 삭제까지) | 담긴 문서를 따름 (코스의 `region`은 탈퇴 시 삭제하지 않음, 기록·뱃지의 `region`은 탈퇴 시 `cleanupUserData`가 삭제) | `firestore.rules:138-152`, `functions/src/running_pencil/region/resolve_region.ts:1-28`, `functions/src/running_pencil/region/on_course_written.ts:1-17` |
| 기기 안 원시 GPS 로그 `active_run.jsonl` (앱 전용 폴더의 `runs/` 아래 파일 하나) | 위치 기록 | 기기 GPS (기록 중) | 기록 중인 세션의 원시 위치를 기록 저장 전까지 보관 | 기기 안에만 저장 (서버로 보내지 않음) | 없음 (기기 안) | 해당 없음 (기기 안) | 정상 종료면 저장 직후 삭제. 비정상 종료 때 남는 기간은 미확인 | 정상 종료면 기록 저장 직후 앱이 지움 | `lib/features/runs/application/run_log_store.dart:20`, `lib/features/runs/application/run_log_store.dart:56-57` |

### 위치를 읽는 세 시점

| 시점 | 용도 | 저장 여부 | 근거 |
|---|---|---|---|
| 에디터 (editor) | 코스를 그릴 때 지도 카메라와 내 위치 점. 10m 간격 | 저장하지 않음 | `lib/core/location/location_platform.dart:107-190` |
| 시작 전 (preStart) | 기록을 시작하기 전 위치 워밍업 | 저장하지 않음 | `lib/core/location/location_platform.dart:107-190` |
| 기록 중 (recording) | Android는 포그라운드 서비스 알림을 띄우고 받음. iOS는 화면이 꺼져도 받음 | 이 궤적만 `runs/{runId}.path`로 저장 | `lib/core/location/location_platform.dart:107-190` |

- 위치 권한은 「앱 사용 중」뿐입니다. Android는 정밀·대략 위치와 위치용 포그라운드 서비스 권한만 선언하고 (`android/app/src/main/AndroidManifest.xml:4-8`), iOS는 「앱 사용 중」 위치 문구와 백그라운드 모드 `location`만 둡니다 (`ios/Runner/Info.plist:104-105`, `ios/Runner/Info.plist:137-142`). 「항상 허용」 권한은 요청하지 않습니다.
- 서버에 저장되는 위치는 기록 중의 궤적(`runs/{runId}.path`)뿐입니다. 코스를 그리거나 시작 전 화면에서는 기기가 현재 위치를 읽지만 저장하지 않습니다. Phase 5 SUP-04의 FAQ 문장이 이 사실을 따릅니다.
- 코스 행은 공개 여부로 나누지 않습니다. 탈퇴 정리 함수는 기록과 뱃지만 지우고 코스는 공개·비공개 모두 건드리지 않습니다 (`functions/src/running_pencil/cleanup_user_data.ts:17-21`). 비공개 코스는 만든 사람만 읽을 수 있어 (`firestore.rules:320-321`) 탈퇴 뒤에는 관리자 권한으로만 보이는 데이터로 남습니다. 처리 방침은 결정 목록 U6에서 정합니다.

## D. 외부로 나가는 요청

| 항목 | 범주 | 출처 | 목적 | 저장 위치(리전) | 수탁자 | 국외 이전 | 보유 기간 | 삭제 방식 | 근거 |
|---|---|---|---|---|---|---|---|---|---|
| 경로 스냅 `snapRoute` (웨이포인트 좌표, 반경) | 외부 요청 | 지도에서 찍은 웨이포인트 좌표 2~50개 (GPS 위치가 아님) | 그린 코스를 걷는 길에 맞춤. Functions 로그에는 uid, 점 개수, 반경, 결과 코드, 소요 시간만 남음 (좌표 없음) | 저장하지 않음. 처리 위치 라우터 VM `asia-northeast3-a` (근거: dev 배포 스크립트 기본값, CLI 미확인). 요청은 Cloud Functions `asia-northeast3` (근거: 코드)를 거침 | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 요청 내용은 저장하지 않음. 라우터 접속 기록은 좌표를 가리고 접속 IP는 앞부분만 남김 (접속 IP는 사용자 기기가 아니라 Functions의 것). 접속 기록은 파일 크기 기준으로 돌려 지우며 기간은 미확인 | 해당 없음 (요청 내용을 저장하지 않음) | `functions/src/running_pencil/snap_route.ts:1-22`, `functions/src/running_pencil/snap_route.ts:535-542`, `infra/router/Caddyfile:24-41`, `infra/router/deploy.sh:43`, `functions/src/shared/region.ts:2` |
| 장소 검색 `searchPlaces` (검색어, 지도 중심 좌표) | 외부 요청 | 검색어(50자 이하)와 지도 중심 좌표 | 코스 에디터의 장소·주소 검색. Functions 로그에는 uid, 검색어 길이, 결과 건수와 코드만 남음 (검색어·좌표 없음). 결과를 저장하지 않음 | 저장하지 않음. 처리 위치 Cloud Functions `asia-northeast3` (근거: 코드). 네이버클라우드 쪽 저장 여부 미확인 | 네이버클라우드 (NCP Geocoding·Reverse Geocoding, NAVER API HUB 지역검색) | 미확인 (Functions는 prod 리전에 따름, 결정 목록 「prod 리전」. 네이버클라우드 처리 위치 미확인) | Functions는 저장하지 않음. 네이버클라우드 쪽 보유 기간 미확인 | 해당 없음 (Functions는 저장하지 않음). 네이버클라우드 쪽 삭제 방식 미확인 | `functions/src/running_pencil/search_places.ts:1-33`, `functions/src/running_pencil/search_places.ts:790-798`, `functions/src/shared/ncp_maps_params.ts`, `functions/src/shared/naver_api_hub_params.ts`, `functions/src/shared/region.ts:2` |
| 지역 판정 `resolveRegion` (좌표 1개) | 외부 요청 | 코스 출발점 좌표 1개 | 코스의 지역(법정동) 판정. 외부 호출 없음 (Functions 안의 경계 데이터로 판정). 로그에는 uid, 판정 성공 여부, 소요 시간만 남음 (좌표 없음) | 저장하지 않음. 처리 위치 Cloud Functions `asia-northeast3` (근거: 코드) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 저장하지 않음. 판정 결과는 코스의 `region`으로 저장 (구간 C) | 해당 없음 (저장하지 않음) | `functions/src/running_pencil/region/resolve_region.ts:1-28`, `functions/src/shared/region.ts:2` |
| 네이버 지도 SDK (`flutter_naver_map`) | 외부 요청 | 지도 타일 요청과 클라이언트 ID. 그 밖에 SDK가 보내는 항목은 미확인 | 지도 표시. 앱 임시 문구가 「네이버 지도 SDK 이용 정보가 네이버클라우드에 제공」된다고 적음. 고지 의무는 결정 목록 U8 | 미확인 (네이버클라우드 쪽 처리·저장 위치) | 네이버클라우드 | 미확인 | 미확인 | 미확인 | `pubspec.yaml:78-79`, `lib/l10n/app_ko.arb:197` |
| 소셜 연결 끊기 (카카오·네이버·Facebook·LINE) | 외부 요청 | 제공자별 토큰·회원번호 | 탈퇴하기 전에 서비스별로 제공자 쪽 앱 연결(권한) 해제. 건너뛸 수 있음 | 저장하지 않음. 처리 위치 Cloud Functions `asia-northeast3` (근거: 코드) | 해당 없음. 카카오·네이버·Facebook·LINE API에 직접 보내는 요청 | 미확인 (각 제공자 API 서버 위치 미확인) | 저장하지 않음. 제공자 쪽 처리는 각 제공자 정책에 따름 (미확인) | 해당 없음 (저장하지 않음) | `functions/src/index.ts:67-76`, `lib/l10n/app_ko.arb:364`, `lib/l10n/app_ko.arb:377`, `functions/src/shared/region.ts:2` |
| Cloud Functions 로그의 uid (Cloud Logging) | 외부 요청 | Functions가 호출마다 남기는 로그 | 오류 추적과 운영 확인. 로그에 uid, 결과 코드, 소요 시간이 남음. 이 목록이 확인한 함수(`snapRoute`, `searchPlaces`, `resolveRegion`, `deleteUserAccount`)의 로그에는 좌표·검색어가 없음. 그 밖의 함수 로그 항목은 미확인 | Cloud Logging, 위치와 보존 기간 미확인 (CLI 미확인) | Google (Firebase·GCP) | 미확인 (Cloud Logging 버킷 위치 미확인, CLI 미확인) | 미확인 (CLI 미확인) | 앱이 지우지 않음. 로그 보존 기간이 지나면 지워짐 (기간 미확인) | `functions/src/running_pencil/snap_route.ts:535-542`, `functions/src/running_pencil/search_places.ts:790-798`, `functions/src/running_pencil/region/resolve_region.ts:190`, `functions/src/auth/delete_user_account.ts:372-379` |

- 라우터 접속 기록의 가림 처리: 요청 경로의 좌표 구간을 가리고, 라우터 열쇠 헤더를 지우고, 접속 IP는 앞부분만 남깁니다 (`infra/router/Caddyfile:24-41`). 라우터의 호스트 이름과 고정 IP는 이 목록에 적지 않습니다.
- 소셜 연결 끊기의 요청은 Google이 아니라 각 제공자 API로 갑니다. 이 요청이 제3자 제공인지 같은 법적 구분은 Phase 7에서 합니다.

## E. 기기·알림·분석·크래시

| 항목 | 범주 | 출처 | 목적 | 저장 위치(리전) | 수탁자 | 국외 이전 | 보유 기간 | 삭제 방식 | 근거 |
|---|---|---|---|---|---|---|---|---|---|
| `users/{uid}/fcmTokens/{token}` (`token`, `platform`, `locale`, `updatedAt`, `expireAt`. `platform`은 android 또는 ios, `locale`은 ko·en·ja) | 알림 | 기기의 FCM 등록 토큰 (앱이 기록. 익명 사용자는 쓸 수 없음) | 푸시 알림을 보낼 기기 주소 | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인). 알림 발송을 맡는 FCM은 Google 시설 (위치 선택 불가, 공식 문서) | Google (Firebase·GCP) | 토큰 문서는 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」). FCM 발송은 있을 수 있음. Google이 시설을 둔 곳 어디서나 처리 (공식 문서) | 앱이 `expireAt`을 30일 뒤로 씀 (규칙 상한 60일). TTL 정책 적용 여부 CLI 미확인. FCM의 installation ID는 삭제 API 호출까지. 이후 180일 안에 제거 (공식 문서) | 탈퇴 시 삭제. 실패하면 TTL에 맡김. 알림 끄기·로그아웃 때 앱이 이 기기의 토큰 문서를 지움 | `firestore.rules:405-416`, `lib/features/notifications/domain/fcm_token.dart:17`, `functions/src/auth/delete_user_account.ts:369-380`, `lib/features/notifications/application/notification_settings_notifier.dart:29-33`, 공식 문서: firebase.google.com/support/privacy |
| Firebase Analytics (사용자 ID로 붙이는 uid, 사용자 속성 `guest_mode`(익명 여부), 앱이 직접 보내는 이벤트 `onboarding_completed`와 화면 조회, 개발용 화면의 시험 이벤트 `dev_tools_test_event`. SDK가 스스로 모으는 기본 이벤트와 기기 정보는 미확인) | 분석·크래시 | 앱 사용 중 SDK가 기록 | 앱 사용 분석. 수집을 끄는 스위치가 앱에 없음 (결정 목록 N5) | Google 시설 (위치 선택 불가, 공식 문서) | Google (Firebase·GCP) | 있을 수 있음. Google이 시설을 둔 곳 어디서나 처리 (공식 문서) | 미확인 (콘솔 설정값. 선택지는 2개월 또는 14개월, 공식 문서) | 앱이 삭제 API를 부르지 않음. 서비스의 보존 기간에 따름 | `lib/core/router/auth_guard.dart:592-593`, `lib/core/analytics/analytics_service.dart:53-56`, `lib/features/onboarding/presentation/onboarding_screen.dart:166`, `lib/features/demo/presentation/demo_screen.dart:978`, `lib/core/analytics/analytics_observer.dart:56-60`, 공식 문서: support.google.com/analytics/answer/7667196, 공식 문서: firebase.google.com/support/privacy |
| Firebase Crashlytics (사용자 식별자로 붙이는 uid, 사용자 정의 키 `flavor`, 오류와 스택) | 분석·크래시 | 앱에서 오류가 날 때 SDK가 기록 | 오류 추적. 수집을 끄는 스위치가 앱에 없음 (결정 목록 N5) | Google 시설 (위치 선택 불가, 공식 문서) | Google (Firebase·GCP) | 있을 수 있음. Google이 시설을 둔 곳 어디서나 처리 (공식 문서) | 90일 (공식 문서) | 앱이 삭제 API를 부르지 않음. 서비스의 보존 기간에 따름 | `lib/core/router/auth_guard.dart:594`, `lib/core/bootstrap.dart:134-155`, 공식 문서: firebase.google.com/support/privacy |
| App Check 기기 증명 토큰 (출시 빌드는 Android Play Integrity, iOS DeviceCheck) | 기기 | 기기의 증명 서비스가 발급하고 SDK가 붙여 보냄 | Cloud Functions 호출이 정식 앱에서 왔는지 확인 (남용 방지) | Google 시설 (위치 선택 불가, 공식 문서) | Google (Firebase·GCP) | 있을 수 있음. Google이 시설을 둔 곳 어디서나 처리 (공식 문서) | 토큰 최대 7일, 재전송 방지 토큰 최대 30일 (공식 문서) | 해당 없음 (앱이 저장하지 않음). 토큰은 유효 기간에 따름 (공식 문서) | `lib/core/bootstrap.dart:109-120`, `functions/src/index.ts:36`, `functions/src/auth/delete_user_account.ts:159`, 공식 문서: firebase.google.com/support/privacy |
| Remote Config 가져오기 (로그인 수단을 켜고 끄는 키 `auth_provider_{id}_enabled`, SDK가 쓰는 Firebase installation ID) | 기기 | 앱이 Remote Config 서버에서 값을 받음 | 로그인 수단을 켜고 끄기 (긴급 차단 스위치) | Google 시설 (위치 선택 불가, 공식 문서) | Google (Firebase·GCP) | 있을 수 있음. Google이 시설을 둔 곳 어디서나 처리 (공식 문서) | 삭제 API 호출까지. 이후 180일 안에 제거 (공식 문서) | 앱이 삭제 API를 부르지 않음. 서비스의 보존 기간에 따름 | `lib/core/auth/provider_id.dart:64-65`, `lib/core/auth/auth_strategies_registry.dart:138-141`, 공식 문서: firebase.google.com/support/privacy |
| 기기 안 설정 (`SharedPreferences`의 언어, 테마, 온보딩 본 버전, 알림 수신 설정, 이 기기에 등록한 FCM 토큰 키, 약관 동의 기록 사본, 권한을 물었는지 여부, 따라가기 모드, 길찾기 앱 선택, 닫은 공지 문구) | 기기 | 사용자 선택과 앱 상태 | 다음 실행 때 설정을 되살림. 약관 동의 사본은 익명 사용자의 동의 추적과 오프라인 대비 | 기기 안에만 저장 (서버로 보내지 않음) | 없음 (기기 안) | 해당 없음 (기기 안) | 기기 안에 남음. 등록 토큰 키는 로그아웃 때 앱이 지움. 그 밖의 키가 지워지는 시점은 미확인 | 탈퇴 때 서버에서 지우는 대상이 아님 (기기 안). 등록 토큰 키는 로그아웃 때 앱이 지움 | `lib/core/providers/locale_provider.dart:33`, `lib/core/providers/theme_provider.dart:22`, `lib/features/onboarding/presentation/onboarding_notifier.dart:45`, `lib/features/notifications/application/notification_settings_notifier.dart:27`, `lib/features/notifications/application/notification_settings_notifier.dart:29-37`, `lib/features/terms/presentation/terms_notifier.dart:19-27`, `lib/features/terms/presentation/terms_notifier.dart:39`, `lib/core/location/location_service.dart:21`, `lib/features/runs/application/run_notification_permission.dart:11`, `lib/features/runs/application/tracking_mode_preference.dart:13`, `lib/features/courses/application/directions_app_preference.dart:22`, `lib/features/home/application/dismissed_announcement.dart:19` |
| Facebook SDK 자동 이벤트 (자동 이벤트 전송 가능성 있음. 앱에서 끄는 설정 없음(확인), 실제 전송 여부 미확인) | 분석·크래시 | Facebook 로그인용 SDK가 앱 설치·실행 같은 이벤트를 자동으로 기록할 수 있음 (공식 문서) | 앱이 쓰는 곳 없음. Facebook 로그인 SDK의 기본 동작. 결정 목록 N1 | 미확인 (Meta 쪽 처리·저장 위치) | Meta (Facebook SDK). 실제 전송 여부 미확인 | 미확인 | 미확인 | 미확인 | `android/app/src/main/AndroidManifest.xml:50-57`, `ios/Runner/Info.plist:79-84`, 공식 문서: developers.facebook.com/docs/app-events/getting-started-app-events-android |

- Analytics와 Crashlytics에는 로그인할 때마다 uid를 붙입니다 (`lib/core/router/auth_guard.dart:592-594`). 수집을 끄거나 동의를 받는 호출(`setAnalyticsCollectionEnabled`, `setCrashlyticsCollectionEnabled`, `setConsent`)은 기준 커밋의 `lib`, `android/app/src`, `ios/Runner` 어디에도 없습니다. 처리방침의 거부 방법 문장은 결정 목록 N5에서 정합니다.
- 탈퇴 함수는 Analytics·Crashlytics의 데이터를 지우는 API를 부르지 않습니다. 탈퇴 뒤에도 이 두 서비스에 붙은 uid는 각 서비스의 보존 기간(Analytics는 미확인, Crashlytics는 90일)에 따라 남습니다.
- Facebook 관련 매니페스트 설정은 앱 ID와 클라이언트 토큰 둘뿐이고 자동 이벤트나 광고 ID 수집을 끄는 설정은 없습니다 (`android/app/src/main/AndroidManifest.xml:50-57`). Meta 문서는 Android SDK가 통합되면 자동 이벤트 기록이 기본으로 켜진다고 적습니다 (공식 문서: developers.facebook.com/docs/app-events/getting-started-app-events-android). `flutter_facebook_auth` 플러그인이 병합하는 매니페스트, iOS 기본 동작, 실제 전송 여부는 미확인입니다.
- 개발용 화면의 시험 이벤트 `dev_tools_test_event`가 출시 빌드에서 보이는지는 확인하지 못했습니다 (「미확인」).

## F. 서버 보조 컬렉션

| 항목 | 범주 | 출처 | 목적 | 저장 위치(리전) | 수탁자 | 국외 이전 | 보유 기간 | 삭제 방식 | 근거 |
|---|---|---|---|---|---|---|---|---|---|
| `rate_limits/{docId}` (`count`, `windowStart`. 문서 ID에 uid 또는 해시가 들어가고 IP와 이메일은 원문이 아니라 SHA-256 앞 32자) | 서버 보조 | Functions가 요청 횟수를 셈 (규칙에 허용 항목이 없어 클라이언트는 접근할 수 없음) | 요청 횟수 제한 (가입 수단 조회, 시험 푸시 같은 호출의 남용 방지) | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 미확인 (TTL 정책 CLI 미확인) | 탈퇴 시 삭제하지 않음. TTL 정책 미확인 | `functions/src/shared/rate_limit.ts:4-6`, `functions/src/shared/client_ip_hash.ts:11-28`, `functions/src/email/email_hash.ts:22-27`, `functions/src/auth/lookup_sign_in_methods.ts:117-127` |
| `mail/{id}` (`to` 수신 주소, `message` 인증·비밀번호 재설정 링크가 든 메일 본문) | 서버 보조 | Functions가 인증 메일·비밀번호 재설정 메일을 보낼 때 기록 (클라이언트 접근 차단) | 메일 발송 대기열 (Trigger Email 확장이 읽어 보냄). 현재 미사용 (dev 기준). prod 설정에 따름 | Firestore `asia-northeast3` (근거: dev 설정 기록(문서), CLI 미확인) | Google (Firebase·GCP). 메일 발송 모드가 `kit`이면 SMTP 발송 서비스가 더해짐 (결정 목록 N6, P1) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」). SMTP 발송 서비스 쪽은 미확인 | 확장 TTL 설정 1일 (근거: 설정 파일). TTL 적용 여부 CLI 미확인 | 탈퇴 단계에 없음. 확장 TTL에 맡김 (적용 여부 CLI 미확인) | `functions/src/email/send_verification_mail.ts:190`, `functions/src/email/send_password_reset_mail.ts:310`, `firestore.rules:299-301`, `extensions/firestore-send-email.env:6-8`, `lib/core/config/app_config.dart:232-239` |

- dev의 `emailDelivery`는 빈 값이고, 빈 값이면 Firebase Authentication 기본 메일로 동작합니다. 그래서 dev에서는 `mail` 컬렉션과 SMTP 발송 서비스를 쓰지 않습니다 (`config/dev.json:19`, `lib/core/config/app_config.dart:232-239`, 근거: dev). prod에서 `kit`을 쓰면 SMTP 발송 서비스가 수탁자로 더해집니다 (결정 목록 N6, P1).
