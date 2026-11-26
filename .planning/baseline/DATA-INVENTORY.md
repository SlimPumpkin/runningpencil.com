# 데이터 목록 (Data Inventory)

**작성일:** 2026-11-15
**기준:** BASE-03 — 앱 러닝펜슬이 모으고 저장하고 내보내는 개인정보 항목의 필드 단위 목록
**읽는 곳:** Phase 6 삭제 안내, Phase 7 처리방침, Phase 8 약관과 위치약관
**기준 앱 커밋:** 앱 저장소 `running_pencil`의 `92e986c3` (2026-11-26)

> 이 저장소(`SlimPumpkin/runningpencil.com`)는 **PUBLIC**입니다. `.planning/`은 사이트에 배포되지 않지만 GitHub에서 누구나 봅니다. 그래서 이 목록에는 필드 이름, 컬렉션 이름, 경로와 행 번호만 적고 식별자·비밀·호스트 이름·실제 사용자 데이터 값(uid, 이메일, 좌표, 토큰)은 적지 않습니다 (D-18).
>
> 리전과 설정 값은 dev 프로젝트 기준입니다. prod·stg 프로젝트는 아직 없습니다 (D-08). dev에서 확인한 값은 prod 값이 아니며, 그런 칸에는 「근거: dev」를 붙였습니다.
>
> 이 목록은 데이터가 어디서 와서 어디에 저장되고 어디로 가는지의 사실만 적습니다. 수탁, 제3자 제공, 국외 이전의 법적 구분은 Phase 7에서 합니다.
>
> 본표의 「수탁자」 열에서 Google Firebase·GCP와 네이버클라우드를 수탁자로, 로그인 제공자를 수탁자가 아닌 곳으로 둔 것은 이 목록의 판단이 아니라 `.planning/REQUIREMENTS.md`의 PRIV-03과 `.planning/ROADMAP.md`의 Phase 7 성공 기준 2를 옮긴 것입니다. 그 밖의 받는 곳(예: 구간 E의 Meta (Facebook SDK))이 수탁인지 제3자 제공인지는 정하지 않았고 Phase 7에서 정합니다.
>
> 법률 검토 전 초안입니다.

## 재확인 규칙

앱은 계속 바뀝니다. 이 목록의 행 번호는 모두 기준 앱 커밋 `92e986c3` 기준입니다 (D-09).

1. Phase 6, 7, 8을 시작할 때마다 앱 저장소에서 아래 명령을 돌립니다. 경로 자리에는 「근거로 삼은 경로」 목록의 경로를 모두 넣습니다.

   ```bash
   git -C "$HOME/dv/woody/running_pencil" diff 92e986c3..HEAD -- <근거로 삼은 경로>
   ```

2. 바뀐 파일이 있으면 그 파일을 근거로 삼은 행만 다시 확인해 고칩니다.
3. 고친 뒤 이 머리의 기준 앱 커밋을 그때의 앱 HEAD로 올리고, 행 번호도 새 커밋 기준으로 고칩니다.
4. `config/dev.json`은 앱 저장소가 추적하지 않는 로컬 설정 파일이라 `git diff`에 나오지 않습니다. 재확인 때마다 파일을 직접 다시 엽니다. 이 목록은 그 파일에서 `enabledAuthProviders`와 `emailDelivery` 두 키만 인용합니다.

2026-11-20 정정 (Phase 6 연구): 기준 커밋 `3afb2085` 시점에 이미 있던 오류(구간 D·G 연결 해제 대상, 구간 C 기록 삭제, 구간 A·H 익명 약관 기록)를 고쳤다. 기준 앱 커밋은 그대로이고, D-05 앱 작업 뒤 재기준은 따로 한다.

재기준 (Phase 6, D-06·D-36): D-05 앱 작업 뒤 앱 커밋 `92e986c3`로 올렸다. 법적 문구는 초안이다 (결정 목록 U2)

- 새 기준은 사용자가 고른 앱 작업 커밋이고(Phase 6 D-36) 재기준한 날의 앱 HEAD가 아니다. 그 뒤 앱 HEAD에 더해진 커밋은 앱의 계획 문서만 바꿨고 근거 경로는 그대로다 (2026-11-26 확인, 06-EVIDENCE 「06-04 앱 사실」).
- 행 번호는 `3afb2085`부터 바뀐 파일의 인용만 다시 찾아 고쳤다. 바뀌지 않은 파일의 행 번호는 그대로다.

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
- `infra/router/RUNBOOK.md`
- `docs/guide.md`
- `lib/core/firebase/firebase_options_prod.dart`
- `lib/core/firebase/firebase_options_stg.dart`
- `lib/features/settings/data/disconnect/disconnect_steps.dart`
- `lib/features/settings/data/disconnect/disconnect_step.dart`
- `lib/features/settings/data/disconnect/server_disconnect_step.dart`
- `lib/features/settings/data/disconnect/google_disconnect_step.dart`
- `lib/features/settings/data/disconnect/apple_disconnect_step.dart`
- `lib/features/settings/data/disconnect/naver_disconnect_step.dart`
- `lib/features/settings/data/disconnect/line_disconnect_step.dart`
- `lib/features/settings/presentation/withdrawal_disconnect_notifier.dart`
- `lib/features/runs/data/run_repository.dart`
- `functions/src/running_pencil/user_data_cleanup.ts`
- `functions/src/running_pencil/operator/operator_delete_user_data.ts`
- `functions/src/running_pencil/operator/account_deletion_steps.ts`
- `infra/operator/delete_user_data.mjs`
- `docs/operator-delete-tool.md`
- `functions/src/running_pencil/location_use_records/on_run_written.ts`
- `functions/src/running_pencil/location_use_records/location_use_record.ts`
- `docs/location-use-records.md`
- `lib/features/runs/domain/record_deletion_targets.dart`
- `lib/features/runs/application/record_deleter.dart`
- `lib/features/courses/presentation/_widgets/course_delete_menu_button.dart`
- `lib/features/settings/presentation/app_settings_sections.dart`
- `lib/features/runs/presentation/delete_all_records_setting_row.dart`
- `lib/features/settings/presentation/account_screen.dart`
- `lib/features/settings/presentation/_widgets/danger_zone_section.dart`
- `lib/features/settings/presentation/_widgets/profile_photo_tile.dart`
- `lib/features/settings/presentation/_widgets/profile_photo_sheet.dart`
- `lib/features/courses/presentation/_widgets/course_status_marks.dart`
- `lib/features/courses/presentation/course_detail_screen.dart`

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
- 「근거: dev CLI, YYYY-MM-DD 조회」는 dev 프로젝트를 읽기 전용 CLI(`gcloud`, `firebase`)로 그날 조회한 값이라는 뜻입니다. prod 값이 아닙니다. 구간 H의 근거 종류 칸에는 「dev CLI」로, 근거 칸에는 「dev CLI: 명령 이름 (YYYY-MM-DD)」로 적습니다.

**「미확인」과 「CLI 미확인」**

- 「미확인」: 이번에 확인하지 못한 칸입니다. 빈 칸이 아니라 글자 「미확인」으로 적습니다. 일부만 확인된 칸은 확인된 부분과 미확인 부분을 함께 적습니다.
- 「CLI 미확인」: dev 프로젝트를 읽기 전용 CLI(`gcloud`, `firebase`)로 조회해야 알 수 있는 값입니다. 01-08 계획이 2026-11-15에 조회해 이 표기가 붙어 있던 칸을 모두 채웠습니다 (「CLI 조회 기록」).

## A. 계정·프로필

| 항목 | 범주 | 출처 | 목적 | 저장 위치(리전) | 수탁자 | 국외 이전 | 보유 기간 | 삭제 방식 | 근거 |
|---|---|---|---|---|---|---|---|---|---|
| Firebase Auth 사용자 레코드 (uid, 이메일, 표시 이름, 사진 URL, 연결된 제공자) | 계정 | 로그인 제공자 응답. 재로그인 때 이메일·표시 이름·사진 URL을 제공자 값으로 갱신 | 로그인과 계정 식별 | Firebase Authentication, 미국 (공식 문서) | Google (Firebase·GCP) | 있음. 미국 (Firebase Authentication은 미국 데이터센터에서만 운영, 공식 문서) | 삭제 요청까지. 삭제 뒤 180일 안에 라이브·백업에서 제거 (공식 문서) | 탈퇴 시 `deleteUserAccount`가 Auth 계정을 삭제 | `functions/src/auth/identity_index.ts:64-92`, `functions/src/auth/delete_user_account.ts:291`, 공식 문서: firebase.google.com/support/privacy |
| `users/{uid}.termsAccepted` (맵: `version`, `service`, `privacy`, `marketing`, `acceptedAt`) | 계정 | 가입 때 약관 동의 화면 (사용자 입력) | 이용약관·처리방침 동의 기록, 마케팅 정보 수신 동의 여부 | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴까지 (본인이 지울 수 없음) | 탈퇴 시 `deleteUserAccount`가 `users/{uid}` 문서를 삭제 | `firestore.rules:54-64`, `firestore.rules:408`, `functions/src/auth/delete_user_account.ts:325-346` |
| `users/{uid}.signUpProviderId` (가입 수단 문자열, 한 번만 기록) | 계정 | 가입 때 앱 또는 Functions가 기록 | 가입 수단 기록 | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴까지 (변경·삭제 불가) | 탈퇴 시 `deleteUserAccount`가 `users/{uid}` 문서를 삭제 | `firestore.rules:82-90`, `functions/src/auth/identity_index.ts:1117`, `functions/src/auth/delete_user_account.ts:325-346` |
| `users/{uid}.customPhotoUrl` (null 또는 Firebase Storage 다운로드 URL, 2048자 이하) | 프로필 | 사용자가 올린 프로필 사진의 주소 | 직접 고른 프로필 사진 표시 | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴 또는 본인 삭제까지 | 본인이 null로 지울 수 있음. 앱 「내 계정」 → 프로필 사진 → 「올린 사진 삭제」(`settingsProfilePhotoRemove`)로 본인이 지울 수 있음. 탈퇴 시 `deleteUserAccount`가 `users/{uid}` 문서를 삭제 | `firestore.rules:104-110`, `functions/src/auth/delete_user_account.ts:325-346`, `lib/l10n/app_ko.arb:391`, `lib/features/settings/presentation/_widgets/profile_photo_sheet.dart:95` |
| `users/{uid}.linkedProviders[]` (`providerId`, `providerUserId` 배열) | 계정 | 로그인 제공자 응답의 회원번호 (Functions가 기록) | 한 계정에 여러 로그인 수단 연결 | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴까지 | 탈퇴 시 `deleteUserAccount`가 `users/{uid}` 문서를 삭제 | `functions/src/auth/identity_index.ts:1106-1124`, `functions/src/auth/delete_user_account.ts:325-346` |
| `users/{uid}.providerLinkedAt` (제공자별 연결 시각 맵) | 계정 | 서버 시각 (Functions가 기록) | 로그인 수단 연결 시각 기록 | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴까지 | 탈퇴 시 `deleteUserAccount`가 `users/{uid}` 문서를 삭제 | `functions/src/auth/identity_index.ts:1113`, `functions/src/auth/delete_user_account.ts:325-346` |
| `users/{uid}.email`, `users/{uid}.emailVerified` (계정 대표 이메일 사본, 인증 여부) | 계정 | Firebase Auth 레코드와 로그인 토큰에서 복사 (Functions가 기록) | 계정 이메일 표시와 확인 | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴까지 | 탈퇴 시 `deleteUserAccount`가 `users/{uid}` 문서를 삭제 | `functions/src/auth/mirror_account_email.ts:71-75`, `functions/src/auth/identity_index.ts:1118-1121`, `functions/src/auth/delete_user_account.ts:325-346` |
| `identity_index/{provider}:{providerUserId}` (필드 `firebaseUid`, `provider`, `providerUserId`, `linkedAt`, `lastSeenAt`) | 계정 | 로그인 제공자 회원번호와 서버 시각 (Functions가 기록, 클라이언트 접근 차단) | 제공자 계정과 앱 계정을 잇는 색인 | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴까지 | 탈퇴 시 `deleteUserAccount`가 `firebaseUid`가 같은 문서를 모두 삭제 | `functions/src/auth/identity_index.ts:1095-1101`, `firestore.rules:290-292`, `functions/src/auth/delete_user_account.ts:325-346` |
| Storage `users/{uid}/` 아래 프로필 사진 (이미지 형식, 5MB 이하, 본인만 읽기) | 프로필 | 사용자가 고른 사진 (정식 사용자만 올림) | 직접 고른 프로필 사진 | Storage 기본 버킷 `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev CLI, 2026-11-15 조회. 결정 목록 「prod 리전」) | 탈퇴 또는 본인 삭제까지. 지운 객체는 소프트 삭제로 7일 보관 (근거: dev CLI, 2026-11-15 조회) | 탈퇴 시 `deleteUserAccount`가 `users/{uid}/` 아래 객체를 모두 삭제. 실패하면 탈퇴를 멈추고 다시 시도할 수 있음 | `storage.rules:12-19`, `functions/src/auth/delete_user_account.ts:223-227`, `functions/src/auth/delete_user_account.ts:138-145` |
| Email/Password 계정의 이메일·비밀번호 (Firebase Authentication이 보관) | 계정 | 사용자 입력 | 이메일 로그인. 가입 화면 노출 여부는 결정 목록 U5 | Firebase Authentication, 미국 (공식 문서) | Google (Firebase·GCP) | 있음. 미국 (Firebase Authentication은 미국 데이터센터에서만 운영, 공식 문서) | 삭제 요청까지. 삭제 뒤 180일 안에 라이브·백업에서 제거 (공식 문서) | 탈퇴 시 `deleteUserAccount`가 Auth 계정을 삭제 | `lib/features/auth/data/auth_repository.dart:305`, `lib/features/auth/data/auth_repository.dart:368`, `functions/src/auth/delete_user_account.ts:291` |
| 익명 계정 (uid) | 계정 | 익명 로그인 (uid만 받음) | 가입 전 둘러보기. 코스·기록·뱃지 쓰기는 막힘 | Firebase Authentication, 미국 (공식 문서) | Google (Firebase·GCP) | Auth 레코드는 있음. 미국 (공식 문서) | 기한 없음. 익명 계정 자동 정리가 dev에서 꺼져 있음 (근거: dev 설정 기록(문서)) | 탈퇴 메뉴에 갈 수 없음(익명 사용자는 「내 계정」에서 설정으로 되돌려짐, `lib/core/router/auth_guard.dart:265-269`). 자동 정리는 dev에서 꺼져 있음. 자동 정리는 Auth 레코드를 지움 (공식 문서). 자동 정리가 Auth 삭제 트리거 `cleanupUserData`를 부르는지는 미확인 (공식 문서에 없음. 트리거 머리 주석은 Admin 일괄 삭제가 이벤트를 내지 않는다고 적음). 확인한 경로 안에서 앱이 익명 계정의 서버 문서를 쓰는 곳은 없어(앱 코드), Auth 레코드 밖에 남는 것은 Analytics·Crashlytics·Cloud Functions 로그에 붙은 uid이고 각 행의 기간을 따름. 앱 문서 `docs/kit-fork.md` 「익명 자동 정리」 절은 MVP 동안 자동 정리를 끈 채 둔다고 적음 (앱 쪽 결정) | `docs/kit-fork.md:509`, `functions/src/running_pencil/cleanup_user_data.ts:12-15`, 공식 문서: firebase.google.com/docs/auth/web/anonymous-auth, `firestore.rules:41-45`, `firestore.rules:322`, `firestore.rules:351`, `firestore.rules:441`, `lib/core/router/auth_guard.dart:265-269`, `lib/features/terms/presentation/terms_notifier.dart:19-24`, `firestore.rules:390-394` |

- 클라이언트가 쓸 수 있는 `users/{uid}` 키는 `termsAccepted`, `signUpProviderId`, `customPhotoUrl` 세 개뿐입니다. 나머지 필드는 Functions(Admin SDK)만 씁니다 (`firestore.rules:48-50`).
- `termsAccepted.marketing`으로 마케팅 정보 수신 동의를 받습니다 (`lib/l10n/app_ko.arb:192`). 마케팅 푸시를 실제로 보내는 기능은 확인하지 못했습니다 (「미확인」. 배포된 푸시 함수는 시험용 `sendTestPush`뿐입니다, `functions/src/index.ts:82`). 결정 목록 N4로 넘깁니다.
- 익명 계정 행: 익명 사용자의 약관 동의는 기기 안 `SharedPreferences`에만 저장한다(`lib/features/terms/presentation/terms_notifier.dart:19-24`). 확인한 경로(익명 로그인, 약관 미러, 가입 기록, 프로필 사진, `mirrorAccountEmail`) 안에서는 앱이 익명 계정의 `users/{uid}`를 쓰는 곳을 찾지 못했다. 규칙은 익명의 생성을 허용하므로(`firestore.rules:390-394`) 「쓸 수 있다」와 「앱이 쓴다」를 구분한다. `firestore.rules:41-42` 주석의 30일 삭제는 자동 정리를 켠 경우의 설명이다.
- 「내 계정」 화면 (설정 → 내 계정)에 보이는 항목: 프로필 사진, 표시 이름, 이메일, 가입일, 가입 수단, 연결된 계정. 이메일이 없으면 「-」로 보임. 회원탈퇴는 이 화면 맨 아래 「Danger zone」에 있음 (`lib/features/settings/presentation/account_screen.dart:66`, `lib/features/settings/presentation/account_screen.dart:97`, `lib/features/settings/presentation/account_screen.dart:107`, `lib/features/settings/presentation/account_screen.dart:111`, `lib/features/settings/presentation/account_screen.dart:125`, `lib/features/settings/presentation/account_screen.dart:139`, `lib/features/settings/presentation/account_screen.dart:158`, `lib/features/settings/presentation/account_screen.dart:175`, `lib/features/settings/presentation/account_screen.dart:201`, `lib/features/settings/presentation/_widgets/profile_photo_tile.dart:203`, `lib/features/settings/presentation/_widgets/danger_zone_section.dart:79`, `lib/l10n/app_ko.arb:85-87`, `lib/l10n/app_ko.arb:89-91`, `lib/l10n/app_ko.arb:244`, `lib/l10n/app_ko.arb:347`, `lib/l10n/app_ko.arb:349`, 앱 `92e986c3`). 삭제 요청 메일에 적을 내용과 메일 요청의 대체 본인 확인(Phase 6 D-08·D-30)의 근거

## B. 로그인 제공자별 수신 항목

| 제공자 | 앱이 요청하는 범위 | 서버·앱이 읽는 항목 | 필수/선택 | 근거 |
|---|---|---|---|---|
| 카카오 | OIDC (`serviceTerms`에 `openid`) | ID 토큰의 `sub`, `email`, `email_verified`, `nickname`, `picture` | 미확인 (제공자 콘솔의 동의항목 설정) | `lib/features/auth/data/kakao_sdk_client.dart:103`, `functions/src/auth/kakao_custom_token.ts:130-144` |
| 네이버 | 프로필 API (`/v1/nid/me`) | `id`, `email`, `nickname`, `profile_image` | 미확인 (제공자 콘솔의 동의항목 설정) | `functions/src/auth/naver_profile_to_custom_token.ts:37`, `functions/src/auth/naver_profile_to_custom_token.ts:260-265` |
| LINE | `openid`, `profile`, `email` | ID 토큰의 `sub`, `name`, `picture`, `email` | 미확인 (제공자 콘솔의 동의항목 설정) | `lib/features/auth/data/line_sdk_client.dart:184`, `functions/src/auth/line_custom_token.ts:135-144` |
| Facebook | `email`, `public_profile` | Firebase Auth가 받는 이메일·이름·사진 | 미확인 (제공자 콘솔의 동의항목 설정) | `lib/features/auth/data/auth_repository.dart:3954` |
| Apple | `email`, `name` | Firebase Auth가 받는 이메일(가리기 주소일 수 있음)·이름 | 미확인 (제공자 콘솔의 동의항목 설정) | `lib/features/auth/data/auth_repository.dart:658-660` |
| Google | `GoogleSignIn.authenticate()` 호출. 범위 인자 없음. 기본 범위 미확인 | Firebase Auth가 받는 이메일·이름·사진 | 미확인 (제공자 콘솔의 동의항목 설정) | `lib/features/auth/data/auth_repository.dart:477` |
| 익명 | 요청 없음 | uid만. 코스·기록·뱃지 쓰기는 막힘 | 해당 없음 | `firestore.rules:41-45`, `firestore.rules:322`, `firestore.rules:351`, `firestore.rules:441` |
| Email/Password | 이메일, 비밀번호 (Firebase Authentication이 보관) | 이메일, 비밀번호. 노출 여부는 결정 목록 U5 | 해당 없음 | `lib/features/auth/data/auth_repository.dart:305`, `lib/features/auth/data/auth_repository.dart:368` |

- dev에서 켜진 로그인 제공자는 소셜 여섯 개(Google, Apple, Facebook, 카카오, 네이버, LINE)입니다. 설정 키 `enabledAuthProviders`의 값이 `google,apple,facebook,kakao,naver,line`입니다 (`config/dev.json:18`, 근거: dev). 익명과 Email/Password는 이 키에 없습니다.
- 소셜 제공자의 필수/선택 구분은 앱 코드가 아니라 각 제공자 콘솔의 동의항목 설정이 정합니다. Phase 7·10에서 콘솔 화면으로 확인합니다.
- 이 표는 Phase 7 처리방침의 PRIV-10(로그인 제공자별 수신 항목)의 원본입니다.

## C. 위치·기록·코스·뱃지

| 항목 | 범주 | 출처 | 목적 | 저장 위치(리전) | 수탁자 | 국외 이전 | 보유 기간 | 삭제 방식 | 근거 |
|---|---|---|---|---|---|---|---|---|---|
| `runs/{runId}.path` (GPS 궤적, 인코딩 문자열 100,000자 이하) | 위치 기록 | 기기 GPS (기록 중) | 달린 기록의 경로 보관과 표시 | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴 또는 본인 삭제까지 | 앱에서 본인이 코스 단위로 지울 수 있음 (그 코스의 내 기록 전부와 그 코스 뱃지를 함께 지움. 코스 상세 ⋮ 「뱃지 삭제」(`recordDeleteBadgeMenu`, 그 코스 뱃지가 있을 때)·「기록 삭제」(`recordDeleteRecordsMenu`, 없을 때), 설정 → 「데이터 관리」(`settingsDataSection`) → 「뱃지와 기록 모두 삭제」(`settingsDeleteAllRecords`). 게스트에게는 보이지 않음). 탈퇴와 운영자 도구 두 범위(`account`·`records`)에서 삭제. 기록 문서가 지워지면 그 기록의 확인자료를 지체 없이 파기 (`onRunWritten`) | `firestore.rules:236`, `firestore.rules:347-353`, `functions/src/running_pencil/user_data_cleanup.ts:180-189`, `functions/src/running_pencil/cleanup_user_data.ts:60-64`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:656-660`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:755-759`, `lib/features/runs/domain/record_deletion_targets.dart:3-6`, `lib/features/runs/application/record_deleter.dart:47`, `lib/features/runs/data/run_repository.dart:153-157`, `lib/features/courses/presentation/_widgets/course_delete_menu_button.dart:101-107`, `lib/features/settings/presentation/app_settings_sections.dart:32-36`, `lib/features/runs/presentation/delete_all_records_setting_row.dart:30`, `lib/l10n/app_ko.arb:608-609`, `lib/l10n/app_ko.arb:619-620`, `functions/src/running_pencil/location_use_records/on_run_written.ts:209-212` |
| `location_use_records/{runId}` (위치정보 수집·이용·제공사실 확인자료. 필드 `uid`, `runId`, `runStartedAt`, `runEndedAt`, `recordedAt`, `collectionMethod`, `purpose`, `expireAt`. 경로·좌표 없음) | 위치 기록 | 기록이 저장될 때 서버 함수 `onRunWritten`이 만듦 (클라이언트 읽기·쓰기 차단) | 위치정보 수집·이용·제공사실 확인자료 보관 (위치정보법, 결정 목록 U2 초안) | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 이용 중에는 184일 (`LOCATION_USE_RECORD_RETENTION_DAYS`) 뒤 TTL 정책이 지움 (지연 보통 하루 안). 사이트 문서 표기 「6개월」 (Phase 6 D-41) | 앱 기록 삭제(그 기록의 확인자료), 회원탈퇴와 운영자 도구 계정 전체 삭제, 운영자 도구 「뱃지와 기록 모두 삭제」 때 해당 확인자료를 지체 없이 파기 (Phase 6 D-41) | `functions/src/running_pencil/location_use_records/location_use_record.ts:21`, `functions/src/running_pencil/location_use_records/location_use_record.ts:31`, `functions/src/running_pencil/location_use_records/location_use_record.ts:50-67`, `firestore.rules:364-366`, `functions/src/running_pencil/location_use_records/on_run_written.ts:209-212`, `functions/src/running_pencil/location_use_records/on_run_written.ts:279-280`, `functions/src/running_pencil/user_data_cleanup.ts:213-220`, `functions/src/running_pencil/cleanup_user_data.ts:60-64`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:656-660`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:755-759`, `docs/location-use-records.md:36-53` |
| `runs/{runId}`의 나머지 필드 (`userId`, `courseId`, `courseTitle`, `policyVersion`, `startedAt`, `endedAt`, `durationSeconds`, `distanceMeters`, `startCheckpointIndex`, `direction`, `movingSeconds`, `isCompleted`, `checkpointHitRatio`) | 위치 기록 | 기록 중 기기가 계산한 값 (시각은 기기 시각) | 달린 기록(시간, 거리, 완주 여부) 보관과 표시 | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴 또는 본인 삭제까지 | 앱에서 본인이 코스 단위로 지울 수 있음 (그 코스의 내 기록 전부와 그 코스 뱃지를 함께 지움. 코스 상세 ⋮ 「뱃지 삭제」(`recordDeleteBadgeMenu`, 그 코스 뱃지가 있을 때)·「기록 삭제」(`recordDeleteRecordsMenu`, 없을 때), 설정 → 「데이터 관리」(`settingsDataSection`) → 「뱃지와 기록 모두 삭제」(`settingsDeleteAllRecords`). 게스트에게는 보이지 않음). 탈퇴와 운영자 도구 두 범위(`account`·`records`)에서 삭제 | `firestore.rules:231-257`, `firestore.rules:347-353`, `functions/src/running_pencil/user_data_cleanup.ts:180-189`, `functions/src/running_pencil/cleanup_user_data.ts:60-64`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:656-660`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:755-759`, `lib/features/runs/domain/record_deletion_targets.dart:3-6`, `lib/features/runs/application/record_deleter.dart:47`, `lib/features/runs/data/run_repository.dart:153-157`, `lib/features/courses/presentation/_widgets/course_delete_menu_button.dart:101-107`, `lib/features/settings/presentation/app_settings_sections.dart:32-36`, `lib/features/runs/presentation/delete_all_records_setting_row.dart:30`, `lib/l10n/app_ko.arb:608-609`, `lib/l10n/app_ko.arb:619-620` |
| `courses/{courseId}` (`creatorId`, `title`, `polyline`, `waypoints`, `sketchPolyline`, `distanceMeters`, `startPoint`, `bounds`, `badgeTemplateId`, `createdAt`, `updatedAt`, `visibility`, `badgeRotationDegrees`, 공개 전환 때 `publishedAt`) | 코스 | 사용자가 지도에 그린 코스 (찍은 웨이포인트와 맞춘 경로) | 코스 저장. 공개로 바꾸면 다른 사용자에게 보임 (공개 전환은 한 방향). 앱 코스 화면은 만든 사람의 이름·사진을 표시하지 않음 (본인 코스에만 「내 코스」 표시) | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 공개한 코스는 기한 없음 (탈퇴 뒤에도 남고 만든 사람의 식별자 `creatorId`만 연결). 공개하지 않은 코스는 탈퇴 또는 본인 삭제까지 | 탈퇴(운영자 도구 계정 전체 삭제 포함) 때 공개하지 않은 코스(비공개·검수 대기·공개 범위 값 없음)를 삭제하고 공개한 코스는 남김. 본인은 코스 상세 ⋮(「더보기」) → 「코스 삭제」(`courseDetailDelete`)로 자기 코스를 지울 수 있음 (이미 받은 다른 사람의 뱃지는 남음). 탈퇴한 사람의 공개 코스는 규칙상 아무도 고치거나 지울 수 없음 (Phase 6 D-39). 결정 목록 U6-가·U6-나 | `firestore.rules:192-200`, `firestore.rules:319-333`, `functions/src/running_pencil/user_data_cleanup.ts:198-208`, `functions/src/running_pencil/cleanup_user_data.ts:60-64`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:656-660`, `lib/features/courses/data/course_repository.dart:327`, `lib/features/courses/presentation/_widgets/course_delete_menu_button.dart:83`, `lib/features/courses/presentation/_widgets/course_delete_menu_button.dart:93-97`, `lib/features/courses/presentation/_widgets/course_status_marks.dart:95`, `lib/features/courses/presentation/course_detail_screen.dart:216`, `lib/l10n/app_ko.arb:287`, `lib/l10n/app_ko.arb:302-303`, `lib/l10n/app_ko.arb:305` |
| `users/{uid}/badges/{courseId}` (`runId`, `earnedAt`, `title`, 코스 모양 사본 `polyline`, `badgeTemplateId`, `badgeRotationDegrees`) | 뱃지 | 코스를 완주했을 때 앱이 기록 | 완주 뱃지 보관과 표시 (코스가 지워져도 뱃지를 그림) | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 탈퇴 또는 본인 삭제까지 | 앱에서 본인이 기록과 함께 코스 단위로 지울 수 있음 (위 `runs` 행의 메뉴). 탈퇴와 운영자 도구 두 범위에서 삭제. 만든 사람의 코스 삭제는 다른 사람이 받은 뱃지를 남김 (Phase 6 D-37) | `firestore.rules:269-281`, `firestore.rules:439-447`, `functions/src/running_pencil/user_data_cleanup.ts:224-232`, `functions/src/running_pencil/cleanup_user_data.ts:60-64`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:656-660`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:755-759`, `lib/features/runs/domain/record_deletion_targets.dart:3-6`, `lib/features/runs/application/record_deleter.dart:49`, `lib/l10n/app_ko.arb:305` |
| `region` (courses·runs·badges 공통 선택 필드, 법정동 단위 지역: `kind`, `emdCode`, `sido`, `sigungu`, `emd`, `sidoLabel`, `sigunguLabel`, `dataVersion`) | 위치 기록 | 코스 출발점 좌표로 서버가 판정한 법정동 (`resolveRegion`, `onCourseWritten`) | 코스·기록·뱃지를 지역으로 묶어 보여 줌 | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 담긴 문서를 따름 (공개한 코스는 기한 없음, 공개하지 않은 코스·기록·뱃지는 탈퇴 또는 본인 삭제까지) | 담긴 문서를 따름 (공개한 코스의 `region`은 탈퇴 뒤에도 남음. 공개하지 않은 코스·기록·뱃지의 `region`은 문서와 함께 삭제) | `firestore.rules:138-152`, `functions/src/running_pencil/region/resolve_region.ts:1-28`, `functions/src/running_pencil/region/on_course_written.ts:1-17` |
| 기기 안 원시 GPS 로그 `active_run.jsonl` (앱 전용 폴더의 `runs/` 아래 파일 하나) | 위치 기록 | 기기 GPS (기록 중) | 기록 중인 세션의 원시 위치를 기록 저장 전까지 보관 | 기기 안에만 저장 (서버로 보내지 않음) | 없음 (기기 안) | 해당 없음 (기기 안) | 정상 종료면 저장 직후 삭제. 비정상 종료 때 남는 기간은 미확인 | 정상 종료면 기록 저장 직후 앱이 지움. 앱에서 기록을 지우면 같은 기록의 기기 안 원시 로그도 지움 | `lib/features/runs/application/run_log_store.dart:20`, `lib/features/runs/application/run_log_store.dart:56-57`, `lib/features/runs/application/record_deleter.dart:65-71` |

### 위치를 읽는 세 시점

| 시점 | 용도 | 저장 여부 | 근거 |
|---|---|---|---|
| 에디터 (editor) | 코스를 그릴 때 지도 카메라와 내 위치 점. 10m 간격 | 저장하지 않음 | `lib/core/location/location_platform.dart:107-190` |
| 시작 전 (preStart) | 기록을 시작하기 전 위치 워밍업 | 저장하지 않음 | `lib/core/location/location_platform.dart:107-190` |
| 기록 중 (recording) | Android는 포그라운드 서비스 알림을 띄우고 받음. iOS는 화면이 꺼져도 받음 | 이 궤적만 `runs/{runId}.path`로 저장 | `lib/core/location/location_platform.dart:107-190` |

- 위치 권한은 「앱 사용 중」뿐입니다. Android는 정밀·대략 위치와 위치용 포그라운드 서비스 권한만 선언하고 (`android/app/src/main/AndroidManifest.xml:4-8`), iOS는 「앱 사용 중」 위치 문구와 백그라운드 모드 `location`만 둡니다 (`ios/Runner/Info.plist:104-105`, `ios/Runner/Info.plist:137-142`). 「항상 허용」 권한은 요청하지 않습니다.
- 앱에는 위치정보 동의만 따로 끄는 설정이 없음. 약관 동의 기록(`termsAccepted`)의 키는 `version`·`service`·`privacy`·`marketing`·`acceptedAt`뿐이고, `3afb2085`부터 바뀐 약관·설정·온보딩·문구 코드에도 위치정보 동의를 끄거나 철회하는 화면 요소가 없음 (`firestore.rules:56`, 앱 `92e986c3`). 삭제 안내 `#location`(Phase 6 D-11)의 근거
- 서버에 저장되는 위치는 기록 중의 궤적(`runs/{runId}.path`)뿐입니다. 코스를 그리거나 시작 전 화면에서는 기기가 현재 위치를 읽지만 저장하지 않습니다. Phase 5 SUP-04의 FAQ 문장이 이 사실을 따릅니다.
- 탈퇴 정리(`deleteRunningPencilUserData`)는 기록, 뱃지, 공개하지 않은 코스, 확인자료를 지우고 공개한 코스는 남긴다. 탈퇴 정리는 Auth 계정 삭제 뒤에 도는 트리거이고 일부가 실패하면 `cleanup_user_data_failed` 로그만 남고 자동으로 다시 돌지 않는다 (결정 목록 U6-가·U6-나). 근거: `functions/src/running_pencil/user_data_cleanup.ts:10-22`, `functions/src/running_pencil/user_data_cleanup.ts:173-246`, `functions/src/running_pencil/cleanup_user_data.ts:55-64`, `functions/src/running_pencil/cleanup_user_data.ts:66-143`

## D. 외부로 나가는 요청

| 항목 | 범주 | 출처 | 목적 | 저장 위치(리전) | 수탁자 | 국외 이전 | 보유 기간 | 삭제 방식 | 근거 |
|---|---|---|---|---|---|---|---|---|---|
| 경로 스냅 `snapRoute` (웨이포인트 좌표, 반경) | 외부 요청 | 지도에서 찍은 웨이포인트 좌표 2~50개 (GPS 위치가 아님) | 그린 코스를 걷는 길에 맞춤. Functions 로그에는 uid, 점 개수, 반경, 결과 코드, 소요 시간만 남음 (좌표 없음) | 저장하지 않음. 처리 위치 라우터 VM `asia-northeast3-a` (근거: dev CLI, 2026-11-15 조회). 요청은 Cloud Functions `asia-northeast3` (근거: 코드)를 거침 | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 요청 내용은 저장하지 않음. 라우터 접속 기록은 좌표를 가리고 접속 IP는 앞부분만 남김 (접속 IP는 사용자 기기가 아니라 Functions의 것). 접속 기록은 파일 크기 기준으로 돌려 지우며 기간은 미확인 | 해당 없음 (요청 내용을 저장하지 않음) | `functions/src/running_pencil/snap_route.ts:1-22`, `functions/src/running_pencil/snap_route.ts:535-542`, `infra/router/Caddyfile:24-41`, `infra/router/deploy.sh:43`, `functions/src/shared/region.ts:2` |
| 장소 검색 `searchPlaces` (검색어, 지도 중심 좌표) | 외부 요청 | 검색어(50자 이하)와 지도 중심 좌표 | 코스 에디터의 장소·주소 검색. Functions 로그에는 uid, 검색어 길이, 결과 건수와 코드만 남음 (검색어·좌표 없음). 결과를 저장하지 않음 | 저장하지 않음. 처리 위치 Cloud Functions `asia-northeast3` (근거: 코드). 네이버클라우드 쪽 저장 여부 미확인 | 네이버클라우드 (NCP Geocoding·Reverse Geocoding, NAVER API HUB 지역검색) | 미확인 (Functions는 prod 리전에 따름, 결정 목록 「prod 리전」. 네이버클라우드 처리 위치 미확인) | Functions는 저장하지 않음. 네이버클라우드 쪽 보유 기간 미확인 | 해당 없음 (Functions는 저장하지 않음). 네이버클라우드 쪽 삭제 방식 미확인 | `functions/src/running_pencil/search_places.ts:1-33`, `functions/src/running_pencil/search_places.ts:790-798`, `functions/src/shared/ncp_maps_params.ts`, `functions/src/shared/naver_api_hub_params.ts`, `functions/src/shared/region.ts:2` |
| 지역 판정 `resolveRegion` (좌표 1개) | 외부 요청 | 코스 출발점 좌표 1개 | 코스의 지역(법정동) 판정. 외부 호출 없음 (Functions 안의 경계 데이터로 판정). 로그에는 uid, 판정 성공 여부, 소요 시간만 남음 (좌표 없음) | 저장하지 않음. 처리 위치 Cloud Functions `asia-northeast3` (근거: 코드) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 저장하지 않음. 판정 결과는 코스의 `region`으로 저장 (구간 C) | 해당 없음 (저장하지 않음) | `functions/src/running_pencil/region/resolve_region.ts:1-28`, `functions/src/shared/region.ts:2` |
| 네이버 지도 SDK (`flutter_naver_map`) | 외부 요청 | 지도 타일 요청과 클라이언트 ID. 그 밖에 SDK가 보내는 항목은 미확인 | 지도 표시. 앱 임시 문구가 「네이버 지도 SDK 이용 정보가 네이버클라우드에 제공」된다고 적음. 고지 의무는 결정 목록 U8 | 미확인 (네이버클라우드 쪽 처리·저장 위치) | 네이버클라우드 | 미확인 | 미확인 | 미확인 | `pubspec.yaml:78-79`, `lib/l10n/app_ko.arb:197` |
| 소셜 연결 끊기 (여섯 제공자) | 외부 요청 | 제공자별 토큰·회원번호 | 탈퇴하기 전에 제공자마다 앱 연결(권한) 해제를 시도. 모든 단계는 건너뛸 수 있음. 방식: 카카오·Facebook은 서버 함수(`disconnectKakaoProvider`·`disconnectFacebookProvider`)가 사용자 로그인 없이 해제. 네이버·LINE은 앱에서 그 제공자로 다시 로그인한 뒤 서버 함수(`disconnectNaverProvider`·`disconnectLineProvider`)가 해제. Google은 다시 로그인한 뒤 앱이 Google 로그인 SDK로 이 앱의 승인을 취소(`GoogleSignIn.disconnect()`). Apple은 재인증 뒤 앱이 Firebase Auth의 폐기 API로 Apple 토큰을 폐기(iOS `revokeTokenWithAuthorizationCode`, Android `revokeAccessToken`). Apple Android 경로가 실제로 연결을 해제하는지는 앱 코드가 실측 전(`[ASSUMED]`)으로 표시해 미확인 | 저장하지 않음. 처리 위치: 카카오·Facebook·네이버·LINE은 Cloud Functions `asia-northeast3` (근거: 코드). Google·Apple은 앱(기기)에서 제공자 API 호출 (Apple은 Firebase Auth 폐기 API를 거침. 그 뒤 처리 위치는 미확인) | 해당 없음. 여섯 제공자(카카오·네이버·Google·Apple·Facebook·LINE) API로 보내는 요청 | 미확인 (각 제공자 API 서버 위치 미확인) | 저장하지 않음. 제공자 쪽 처리는 각 제공자 정책에 따름 (미확인) | 해당 없음 (저장하지 않음) | `lib/features/settings/data/disconnect/disconnect_steps.dart:35-48`, `lib/features/settings/data/disconnect/server_disconnect_step.dart:45-60`, `lib/features/settings/data/disconnect/naver_disconnect_step.dart:79-99`, `lib/features/settings/data/disconnect/line_disconnect_step.dart:75-98`, `lib/features/settings/data/disconnect/google_disconnect_step.dart:48-71`, `lib/features/settings/data/disconnect/apple_disconnect_step.dart:13-19`, `lib/features/settings/data/disconnect/apple_disconnect_step.dart:57-77`, `lib/features/settings/presentation/withdrawal_disconnect_notifier.dart:14`, `functions/src/index.ts:67-76`, `lib/l10n/app_ko.arb:364`, `lib/l10n/app_ko.arb:372`, `lib/l10n/app_ko.arb:377`, `functions/src/shared/region.ts:2` |
| Cloud Functions 로그의 uid (Cloud Logging) | 외부 요청 | Functions가 호출마다 남기는 로그 | 오류 추적과 운영 확인. 로그에 uid, 결과 코드, 소요 시간이 남음. 이 목록이 확인한 함수(`snapRoute`, `searchPlaces`, `resolveRegion`, `deleteUserAccount`)의 로그에는 좌표·검색어가 없음. 그 밖의 함수 로그 항목은 미확인. 이 로그에는 탈퇴 정리 실패(`cleanup_user_data_failed`, uid·단계·건수), 확인자료 기록(`location_use_record_written`, uid·동작), 운영자 삭제 도구의 실행 기록(운영자 uid, 지운 사용자의 uid, 범위, 건수. Firestore 문서는 만들지 않음, Phase 6 D-44)도 남음 | Cloud Logging 기본 로그 버킷, 위치 `global` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (기본 로그 버킷의 위치가 특정 리전이 아닌 `global`. 실제 저장 국가 미확인) | 30일 (기본 로그 버킷 보존 기간, 근거: dev CLI, 2026-11-15 조회) | 앱이 지우지 않음. 기본 로그 버킷 보존 기간(30일)이 지나면 지워짐 | `functions/src/running_pencil/snap_route.ts:535-542`, `functions/src/running_pencil/search_places.ts:790-798`, `functions/src/running_pencil/region/resolve_region.ts:190`, `functions/src/auth/delete_user_account.ts:384-391`, `functions/src/running_pencil/cleanup_user_data.ts:66-143`, `functions/src/running_pencil/location_use_records/on_run_written.ts:197-204`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:44-46`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:852-859`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:878-888`, `docs/operator-delete-tool.md:60-69` |

- 라우터 접속 기록의 가림 처리: 요청 경로의 좌표 구간을 가리고, 라우터 열쇠 헤더를 지우고, 접속 IP는 앞부분만 남깁니다 (`infra/router/Caddyfile:24-41`). 라우터의 호스트 이름과 고정 IP는 이 목록에 적지 않습니다.
- 소셜 연결 끊기의 요청은 Firebase에 저장하지 않고 각 제공자 API로 갑니다 (Google 행도 Firebase·GCP의 처리가 아니라 Google 계정에서 이 앱의 승인을 취소하는 요청입니다). 이 요청이 제3자 제공인지 같은 법적 구분은 Phase 7에서 합니다.

## E. 기기·알림·분석·크래시

| 항목 | 범주 | 출처 | 목적 | 저장 위치(리전) | 수탁자 | 국외 이전 | 보유 기간 | 삭제 방식 | 근거 |
|---|---|---|---|---|---|---|---|---|---|
| `users/{uid}/fcmTokens/{token}` (`token`, `platform`, `locale`, `updatedAt`, `expireAt`. `platform`은 android 또는 ios, `locale`은 ko·en·ja) | 알림 | 기기의 FCM 등록 토큰 (앱이 기록. 익명 사용자는 쓸 수 없음) | 푸시 알림을 보낼 기기 주소 | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회). 알림 발송을 맡는 FCM은 Google 시설 (위치 선택 불가, 공식 문서) | Google (Firebase·GCP) | 토큰 문서는 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」). FCM 발송은 있을 수 있음. Google이 시설을 둔 곳 어디서나 처리 (공식 문서) | 앱이 `expireAt`을 30일 뒤로 씀 (규칙 상한 60일). TTL 정책 없음 (근거: dev CLI, 2026-11-26 조회). FCM의 installation ID는 삭제 API 호출까지. 이후 180일 안에 제거 (공식 문서) | 탈퇴 시 삭제. 실패하면 TTL에 맡김 (dev에는 TTL 정책 없음, 근거: dev CLI, 2026-11-15 조회). 알림 끄기·로그아웃 때 앱이 이 기기의 토큰 문서를 지움 | `firestore.rules:418-429`, `lib/features/notifications/domain/fcm_token.dart:17`, `functions/src/auth/delete_user_account.ts:381-392`, `lib/features/notifications/application/notification_settings_notifier.dart:29-33`, 공식 문서: firebase.google.com/support/privacy |
| Firebase Analytics (사용자 ID로 붙이는 uid, 사용자 속성 `guest_mode`(익명 여부), 앱이 직접 보내는 이벤트 `onboarding_completed`와 화면 조회, 개발용 화면의 시험 이벤트 `dev_tools_test_event`. SDK가 스스로 모으는 기본 이벤트와 기기 정보는 미확인) | 분석·크래시 | 앱 사용 중 SDK가 기록 | 앱 사용 분석. 수집을 끄는 스위치가 앱에 없음 (결정 목록 N5) | Google 시설 (위치 선택 불가, 공식 문서) | Google (Firebase·GCP) | 있을 수 있음. Google이 시설을 둔 곳 어디서나 처리 (공식 문서) | 최대 14개월 (설정 미확인. 표준 속성의 선택지는 2개월과 14개월, 공식 문서) | 앱이 삭제 API를 부르지 않음. 서비스의 보존 기간에 따름 | `lib/core/router/auth_guard.dart:592-593`, `lib/core/analytics/analytics_service.dart:53-56`, `lib/features/onboarding/presentation/onboarding_screen.dart:198`, `lib/features/demo/presentation/demo_screen.dart:998`, `lib/core/analytics/analytics_observer.dart:56-60`, 공식 문서: support.google.com/analytics/answer/7667196, 공식 문서: firebase.google.com/support/privacy |
| Firebase Crashlytics (사용자 식별자로 붙이는 uid, 사용자 정의 키 `flavor`, 오류와 스택) | 분석·크래시 | 앱에서 오류가 날 때 SDK가 기록 | 오류 추적. 수집을 끄는 스위치가 앱에 없음 (결정 목록 N5) | Google 시설 (위치 선택 불가, 공식 문서) | Google (Firebase·GCP) | 있을 수 있음. Google이 시설을 둔 곳 어디서나 처리 (공식 문서) | 90일 (공식 문서) | 앱이 삭제 API를 부르지 않음. 서비스의 보존 기간에 따름 | `lib/core/router/auth_guard.dart:594`, `lib/core/bootstrap.dart:170-191`, 공식 문서: firebase.google.com/support/privacy |
| App Check 기기 증명 토큰 (출시 빌드는 Android Play Integrity, iOS DeviceCheck) | 기기 | 기기의 증명 서비스가 발급하고 SDK가 붙여 보냄 | Cloud Functions 호출이 정식 앱에서 왔는지 확인 (남용 방지) | Google 시설 (위치 선택 불가, 공식 문서) | Google (Firebase·GCP) | 있을 수 있음. Google이 시설을 둔 곳 어디서나 처리 (공식 문서) | 토큰 최대 7일, 재전송 방지 토큰 최대 30일 (공식 문서) | 해당 없음 (앱이 저장하지 않음). 토큰은 유효 기간에 따름 (공식 문서) | `lib/core/bootstrap.dart:145-156`, `functions/src/index.ts:36`, `functions/src/auth/delete_user_account.ts:171`, 공식 문서: firebase.google.com/support/privacy |
| Remote Config 가져오기 (로그인 수단을 켜고 끄는 키 `auth_provider_{id}_enabled`, SDK가 쓰는 Firebase installation ID) | 기기 | 앱이 Remote Config 서버에서 값을 받음 | 로그인 수단을 켜고 끄기 (긴급 차단 스위치) | Google 시설 (위치 선택 불가, 공식 문서) | Google (Firebase·GCP) | 있을 수 있음. Google이 시설을 둔 곳 어디서나 처리 (공식 문서) | 삭제 API 호출까지. 이후 180일 안에 제거 (공식 문서) | 앱이 삭제 API를 부르지 않음. 서비스의 보존 기간에 따름 | `lib/core/auth/provider_id.dart:64-65`, `lib/core/auth/auth_strategies_registry.dart:138-141`, 공식 문서: firebase.google.com/support/privacy |
| 기기 안 설정 (`SharedPreferences`의 언어, 테마, 온보딩 본 버전, 알림 수신 설정, 이 기기에 등록한 FCM 토큰 키, 약관 동의 기록 사본, 권한을 물었는지 여부, 따라가기 모드, 길찾기 앱 선택, 닫은 공지 문구) | 기기 | 사용자 선택과 앱 상태 | 다음 실행 때 설정을 되살림. 약관 동의 사본은 익명 사용자의 동의 추적과 오프라인 대비 | 기기 안에만 저장 (서버로 보내지 않음) | 없음 (기기 안) | 해당 없음 (기기 안) | 기기 안에 남음. 등록 토큰 키는 로그아웃 때 앱이 지움. 그 밖의 키가 지워지는 시점은 미확인 | 탈퇴 때 서버에서 지우는 대상이 아님 (기기 안). 등록 토큰 키는 로그아웃 때 앱이 지움 | `lib/core/providers/locale_provider.dart:33`, `lib/core/providers/theme_provider.dart:22`, `lib/features/onboarding/presentation/onboarding_notifier.dart:45`, `lib/features/notifications/application/notification_settings_notifier.dart:27`, `lib/features/notifications/application/notification_settings_notifier.dart:29-37`, `lib/features/terms/presentation/terms_notifier.dart:19-27`, `lib/features/terms/presentation/terms_notifier.dart:39`, `lib/core/location/location_service.dart:21`, `lib/features/runs/application/run_notification_permission.dart:11`, `lib/features/runs/application/tracking_mode_preference.dart:13`, `lib/features/courses/application/directions_app_preference.dart:22`, `lib/features/home/application/dismissed_announcement.dart:19` |
| Facebook SDK 자동 이벤트 (자동 이벤트 전송 가능성 있음. 앱에서 끄는 설정 없음(확인), 실제 전송 여부 미확인) | 분석·크래시 | Facebook 로그인용 SDK가 앱 설치·실행 같은 이벤트를 자동으로 기록할 수 있음 (공식 문서) | 앱이 쓰는 곳 없음. Facebook 로그인 SDK의 기본 동작. 결정 목록 N1 | 미확인 (Meta 쪽 처리·저장 위치) | Meta (Facebook SDK). 실제 전송 여부 미확인. 수탁·제3자 제공 구분은 Phase 7에서 정함 (PRIV-03에 없는 받는 곳) | 미확인 | 미확인 | 미확인 | `android/app/src/main/AndroidManifest.xml:50-57`, `ios/Runner/Info.plist:79-84`, 공식 문서: developers.facebook.com/docs/app-events/getting-started-app-events-android |

- Analytics와 Crashlytics에는 로그인할 때마다 uid를 붙입니다 (`lib/core/router/auth_guard.dart:592-594`). 수집을 끄거나 동의를 받는 호출(`setAnalyticsCollectionEnabled`, `setCrashlyticsCollectionEnabled`, `setConsent`)은 기준 커밋의 `lib`, `android/app/src`, `ios/Runner` 어디에도 없습니다. 처리방침의 거부 방법 문장은 결정 목록 N5에서 정합니다.
- 탈퇴 함수는 Analytics·Crashlytics의 데이터를 지우는 API를 부르지 않습니다. 탈퇴 뒤에도 이 두 서비스에 붙은 uid는 각 서비스의 보존 기간(Analytics는 최대 14개월(설정 미확인), Crashlytics는 90일)에 따라 남습니다.
- Facebook 관련 매니페스트 설정은 앱 ID와 클라이언트 토큰 둘뿐이고 자동 이벤트나 광고 ID 수집을 끄는 설정은 없습니다 (`android/app/src/main/AndroidManifest.xml:50-57`). Meta 문서는 Android SDK가 통합되면 자동 이벤트 기록이 기본으로 켜진다고 적습니다 (공식 문서: developers.facebook.com/docs/app-events/getting-started-app-events-android). `flutter_facebook_auth` 플러그인이 병합하는 매니페스트, iOS 기본 동작, 실제 전송 여부는 미확인입니다.
- 개발용 화면의 시험 이벤트 `dev_tools_test_event`가 출시 빌드에서 보이는지는 확인하지 못했습니다 (「미확인」).

## F. 서버 보조 컬렉션

| 항목 | 범주 | 출처 | 목적 | 저장 위치(리전) | 수탁자 | 국외 이전 | 보유 기간 | 삭제 방식 | 근거 |
|---|---|---|---|---|---|---|---|---|---|
| `rate_limits/{docId}` (`count`, `windowStart`, `expireAt`. 문서 ID에 uid 또는 해시가 들어가고 IP와 이메일은 원문이 아니라 SHA-256 앞 32자) | 서버 보조 | Functions가 요청 횟수를 셈 (규칙에 허용 항목이 없어 클라이언트는 접근할 수 없음) | 요청 횟수 제한 (가입 수단 조회, 시험 푸시 같은 호출의 남용 방지) | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」) | 모든 기록에 만료 시각(`expireAt`, 제한 창 60초나 600초가 끝나는 시각)을 쓰고 Firestore TTL 정책이 지움. 공식 문서상 보통 만료 뒤 24시간 안이고 상한은 보장되지 않음. 해시 문서의 삭제 안내 표기는 「7일 안」 (Phase 6 D-40, 사용자 결정). TTL 정책을 켠 프로젝트에서만 참 (dev는 켜짐, 근거: dev CLI, 2026-11-26 조회) | uid가 든 문서는 탈퇴와 운영자 도구 계정 전체 삭제 때 지움(`deleteUidRateLimitDocs`). 그 단계가 실패하면 같은 만료 시각과 TTL 정책으로 지워짐. IP·이메일 해시로 된 문서는 탈퇴로 찾을 수 없어 TTL 정책이 지움 | `functions/src/shared/rate_limit.ts:4-6`, `functions/src/shared/rate_limit.ts:25-30`, `functions/src/shared/rate_limit.ts:66-75`, `functions/src/shared/rate_limit.ts:103-105`, `functions/src/shared/rate_limit.ts:185`, `functions/src/shared/rate_limit.ts:265`, `functions/src/shared/client_ip_hash.ts:11-28`, `functions/src/email/email_hash.ts:22-27`, `functions/src/auth/lookup_sign_in_methods.ts:121-139`, `functions/src/auth/delete_user_account.ts:403-404`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:650-654`, `docs/guide.md:4091-4096`, `docs/guide.md:4126-4128`, 공식 문서: firebase.google.com/docs/firestore/ttl |
| `mail/{id}` (`to` 수신 주소, `message` 인증·비밀번호 재설정 링크가 든 메일 본문) | 서버 보조 | Functions가 인증 메일·비밀번호 재설정 메일을 보낼 때 기록 (클라이언트 접근 차단) | 메일 발송 대기열 (Trigger Email 확장이 읽어 보냄). 현재 미사용 (dev 기준). prod 설정에 따름 | Firestore `asia-northeast3` (근거: dev CLI, 2026-11-15 조회) | Google (Firebase·GCP). 메일 발송 모드가 `kit`이면 SMTP 발송 서비스가 더해짐 (결정 목록 N6, P1) | 미확인 (prod 리전에 따름. dev는 서울 리전, 근거: dev. 결정 목록 「prod 리전」). SMTP 발송 서비스 쪽은 미확인 | 확장 TTL 설정 1일 (근거: 설정 파일). dev에는 TTL 정책 없음, Trigger Email 확장 설치 안 됨 (근거: dev CLI, 2026-11-15 조회) | 탈퇴 단계에 없음. 확장 TTL에 맡김 (dev에는 확장 설치 안 됨·TTL 정책 없음, 근거: dev CLI, 2026-11-15 조회) | `functions/src/email/send_verification_mail.ts:195`, `functions/src/email/send_password_reset_mail.ts:315`, `firestore.rules:299-301`, `extensions/firestore-send-email.env:6-8`, `lib/core/config/app_config.dart:232-239` |

- dev의 `emailDelivery`는 빈 값이고, 빈 값이면 Firebase Authentication 기본 메일로 동작합니다. 그래서 dev에서는 `mail` 컬렉션과 SMTP 발송 서비스를 쓰지 않습니다 (`config/dev.json:19`, `lib/core/config/app_config.dart:232-239`, 근거: dev). prod에서 `kit`을 쓰면 SMTP 발송 서비스가 수탁자로 더해집니다 (결정 목록 N6, P1).

## G. 탈퇴 때 지워지는 것과 남는 것

| 데이터 | 탈퇴 시 처리 | 근거 |
|---|---|---|
| Storage `users/{uid}/` 아래 객체 전부 | 삭제. 실패하면 탈퇴를 멈추고 다시 시도할 수 있음. 지운 객체는 소프트 삭제로 7일 보관 (근거: dev CLI, 2026-11-15 조회) | `functions/src/auth/delete_user_account.ts:223-227`, `functions/src/auth/delete_user_account.ts:138-145` |
| Firebase Auth 계정 | 삭제. 삭제 요청 뒤 180일 안에 라이브·백업 시스템에서 제거 (공식 문서) | `functions/src/auth/delete_user_account.ts:291`, 공식 문서: firebase.google.com/support/privacy |
| `identity_index` 중 `firebaseUid == uid` | 삭제 | `functions/src/auth/delete_user_account.ts:325-346` |
| `users/{uid}` 문서 (`termsAccepted`, 연결된 제공자, 이메일 사본 등) | 삭제 | `functions/src/auth/delete_user_account.ts:325-346` |
| `users/{uid}/fcmTokens/*` | 삭제. 실패하면 TTL에 맡김 (dev에는 TTL 정책 없음, 근거: dev CLI, 2026-11-15 조회) | `functions/src/auth/delete_user_account.ts:381-392`, `lib/features/notifications/domain/fcm_token.dart:17` |
| `runs` 중 `userId == uid` | 삭제 (탈퇴 정리 트리거 `cleanupUserData`와 운영자 도구 두 범위 `account`·`records`, `deleteRunningPencilUserData`) | `functions/src/running_pencil/user_data_cleanup.ts:180-189`, `functions/src/running_pencil/cleanup_user_data.ts:60-64`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:656-660`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:755-759` |
| `location_use_records` 중 `uid == uid` (위치정보 확인자료) | 삭제. 기록 문서 삭제 트리거(`onRunWritten`)와 정리 helper가 지체 없이 파기 (Phase 6 D-41) | `functions/src/running_pencil/location_use_records/on_run_written.ts:209-212`, `functions/src/running_pencil/user_data_cleanup.ts:213-220`, `functions/src/running_pencil/cleanup_user_data.ts:60-64`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:656-660`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:755-759` |
| `users/{uid}/badges/*` | 삭제 (탈퇴 정리 트리거 `cleanupUserData`와 운영자 도구 두 범위 `account`·`records`, `deleteRunningPencilUserData`) | `functions/src/running_pencil/user_data_cleanup.ts:224-232`, `functions/src/running_pencil/cleanup_user_data.ts:60-64`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:656-660`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:755-759` |
| `courses` 중 `creatorId == uid`이고 공개하지 않은 코스 (비공개·검수 대기·공개 범위 값 없음) | 삭제 (탈퇴 정리 트리거와 운영자 도구 계정 전체 삭제, `deleteRunningPencilUserData`) | `functions/src/running_pencil/user_data_cleanup.ts:198-208`, `functions/src/running_pencil/cleanup_user_data.ts:60-64`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:656-660` |
| `courses` 중 `creatorId == uid`이고 공개한 코스 | 남음. 만든 사람의 식별자(`creatorId`)만 연결 (결정 목록 U6-가) | `functions/src/running_pencil/user_data_cleanup.ts:10-22`, `functions/src/running_pencil/user_data_cleanup.ts:198-208` |
| `rate_limits` 중 uid가 들어간 문서 | 삭제 (`deleteUidRateLimitDocs`). 실패하면 만료 시각과 TTL 정책 | `functions/src/shared/rate_limit.ts:66-75`, `functions/src/auth/delete_user_account.ts:403-404`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:650-654` |
| `rate_limits` 중 IP·이메일 해시로 된 문서 | 탈퇴로 찾을 수 없음. 만료 시각과 TTL 정책이 지움. 삭제 안내 표기 「7일 안」 (Phase 6 D-40) | `functions/src/shared/rate_limit.ts:57-58`, `functions/src/shared/rate_limit.ts:103-105`, `docs/guide.md:4126-4128`, dev CLI: gcloud firestore fields ttls list (2026-11-26, 06-EVIDENCE 중간 보고 ②) |
| `mail` 중 그 사용자 주소가 든 문서 (dev에서는 쓰지 않음) | 삭제하지 않음. 확장 TTL 설정 1일에 맡김 (dev에는 확장 설치 안 됨·TTL 정책 없음, 근거: dev CLI, 2026-11-15 조회) | `functions/src/auth/delete_user_account.ts`, `extensions/firestore-send-email.env:6-8` (탈퇴 함수에 해당 단계 없음) |
| Analytics·Crashlytics에 붙은 uid | 앱이 삭제 API를 부르지 않음. 서비스의 보존 기간에 따름 (Analytics 최대 14개월 (설정 미확인. 표준 속성의 선택지는 2개월과 14개월, 공식 문서), Crashlytics 90일) | `functions/src/auth/delete_user_account.ts`, `functions/src/running_pencil/cleanup_user_data.ts` (해당 호출 없음) |
| Cloud Functions 로그의 uid | 앱이 지우지 않음. 로그 보존 기간에 따름 (dev 기본 로그 버킷 30일, 근거: dev CLI, 2026-11-15 조회). 운영자 삭제 도구의 실행 기록도 같은 보존 기간 | `functions/src/auth/delete_user_account.ts:384-391`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:878-888` |
| 제공자 쪽 앱 연결 (여섯 제공자) | 탈퇴 전에 여섯 제공자 모두 연결 해제 단계가 있음. 건너뛸 수 있음. 건너뛰면 사용자가 제공자 설정에서 직접 해제(앱 안내 문구). Apple Android 경로의 해제 여부는 미확인 (구간 D) | `lib/features/settings/data/disconnect/disconnect_steps.dart:35-48`, `lib/l10n/app_ko.arb:364`, `lib/l10n/app_ko.arb:372`, `lib/l10n/app_ko.arb:377` |
| 운영자 삭제 도구 (메일 요청) | 범위 `account`: 탈퇴와 같은 단계(Storage `users/{uid}/`, Auth 단건 삭제, `identity_index`, `users/{uid}`, `fcmTokens`, uid `rate_limits`, 기록, 뱃지, 공개하지 않은 코스, 확인자료)를 지우고 공개한 코스는 남김. 범위 `records`: 기록 전부, 뱃지 전부, 확인자료를 지우고 계정·`users/{uid}`·코스·Storage는 남김. `records`의 삭제 안내 이름은 「뱃지와 기록 모두 삭제」 (Phase 6 D-38). 기본은 지울 개수만 보이는 dry-run이고 `--apply` 때 uid를 다시 입력. 제공자 연결은 끊지 않음. 실행 기록은 Cloud Logging에만 (Phase 6 D-07·D-43) | `functions/src/running_pencil/operator/operator_delete_user_data.ts:609-667`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:750-765`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:812-813`, `functions/src/running_pencil/operator/operator_delete_user_data.ts:299`, `functions/src/running_pencil/operator/account_deletion_steps.ts:85-92`, `functions/src/running_pencil/operator/account_deletion_steps.ts:115-125`, `infra/operator/delete_user_data.mjs:6-7`, `infra/operator/delete_user_data.mjs:512-524`, `docs/operator-delete-tool.md:9-12`, `docs/operator-delete-tool.md:60-69`, `docs/operator-delete-tool.md:132` |

- 앱 안 메뉴 이름은 「회원탈퇴」입니다 (`lib/l10n/app_ko.arb:349`).
- 탈퇴는 5분 안에 다시 로그인한 토큰을 요구합니다 (`functions/src/auth/delete_user_account.ts:183-203`).
- 탈퇴는 호출 즉시 실행됩니다. 다만 Firebase Authentication 데이터는 삭제 요청 뒤 180일 안에 라이브·백업 시스템에서 제거되므로 (공식 문서: firebase.google.com/support/privacy), 삭제 안내의 상한 표현은 「서비스에서의 삭제」와 「백업에서의 제거」를 나눠 써야 합니다 (Phase 6 연구에서 확정). dev 프로젝트는 Firestore PITR이 꺼져 있고(버전 보존 기간 1시간) 백업 일정이 없으며, Storage 기본 버킷의 소프트 삭제 기간은 7일입니다 (근거: dev CLI, 2026-11-15 조회, 구간 H). prod 값은 아닙니다.
- 공개한 코스는 탈퇴 뒤에도 남고 공개하지 않은 코스는 탈퇴 때 지운다 (결정 목록 U6-가·U6-나). 사용자는 탈퇴 전에 자기 코스를 하나씩 지울 수도 있다 (`lib/features/courses/data/course_repository.dart:327`).
- 앱의 기록 삭제와 「뱃지와 기록 모두 삭제」는 계정을 남기므로 기기에 남은 원시 로그·오프라인 캐시가 기록을 다시 올릴 수 있다. 운영자 도구는 1시간 뒤 같은 명령으로 다시 확인한다 (`docs/operator-delete-tool.md` 「1시간 뒤 다시 확인」).

## H. 리전·보존 기간

| 대상 | 값 | 근거 종류 | 근거 |
|---|---|---|---|
| Cloud Functions 리전 (코드 상수) | `asia-northeast3` | 코드 | `functions/src/shared/region.ts:2`, dev CLI: gcloud functions list (2026-11-15) |
| 배포된 함수의 실제 리전 | `asia-northeast3` (배포된 함수 모두) | dev CLI | dev CLI: gcloud functions list (2026-11-15) |
| Firestore 위치 | `asia-northeast3` (기본 데이터베이스, Native 모드) | dev CLI | dev CLI: gcloud firestore databases list (2026-11-15), `docs/kit-fork.md:475`, `functions/src/running_pencil/region/on_course_written.ts:23` |
| Firestore TTL 정책 (`fcmTokens.expireAt`, `mail`, `rate_limits`, `location_use_records`) | `rate_limits.expireAt`·`location_use_records.expireAt` 켜짐(ACTIVE), `fcmTokens.expireAt`·`mail` 없음 (근거: dev CLI, 2026-11-26 조회, 06-EVIDENCE 중간 보고 ②·⑥) | dev CLI | dev CLI: gcloud firestore fields ttls list (2026-11-26) |
| Storage 기본 버킷 위치 | `asia-northeast3` (단일 리전) | dev CLI | dev CLI: gcloud storage buckets list (2026-11-15) |
| 라우터 VM zone | `asia-northeast3-a`. 조회 때 상태는 중지됨(TERMINATED) | dev CLI | dev CLI: gcloud compute instances list (2026-11-15), `infra/router/deploy.sh:43`, `infra/router/RUNBOOK.md:68` |
| Trigger Email 확장 설치 여부 | 설치 안 됨 (dev 프로젝트에 설치된 확장 없음). 킷 안내 문서는 확장의 처리 함수 리전을 `us-central1`로 적음 | dev CLI | dev CLI: firebase ext:list (2026-11-15), `docs/guide.md:2629` |
| Firebase Authentication 처리 위치 | 미국 데이터센터에서만 운영 | 공식 문서 | 공식 문서: firebase.google.com/support/privacy |
| Firebase Authentication 보존 | 로그의 IP는 몇 주, 그 밖은 삭제 요청까지. 삭제 뒤 180일 안에 라이브·백업에서 제거 | 공식 문서 | 공식 문서: firebase.google.com/support/privacy |
| Analytics·Crashlytics·FCM·Remote Config·App Check 처리 위치 | Google 시설 (위치 선택 불가). Google이 시설을 둔 곳 어디서나 처리될 수 있음 | 공식 문서 | 공식 문서: firebase.google.com/support/privacy |
| Crashlytics 보존 기간 | 크래시 트레이스와 식별자 90일 | 공식 문서 | 공식 문서: firebase.google.com/support/privacy |
| FCM·Remote Config의 installation ID | 삭제 API 호출까지. 이후 180일 안에 제거 | 공식 문서 | 공식 문서: firebase.google.com/support/privacy |
| App Check 토큰 | 토큰 최대 7일, 재전송 방지 토큰 최대 30일 | 공식 문서 | 공식 문서: firebase.google.com/support/privacy |
| Google Analytics 보존 기간 | 최대 14개월 (설정 미확인. 표준 속성의 선택지는 2개월과 14개월, 공식 문서) | 공식 문서 | 공식 문서: support.google.com/analytics/answer/7667196 |
| Firestore PITR | 꺼짐. 버전 보존 기간 1시간 | dev CLI | dev CLI: gcloud firestore databases list (2026-11-15) |
| Firestore 백업 일정 | 없음 | dev CLI | dev CLI: gcloud firestore backups schedules list (2026-11-15) |
| Storage 소프트 삭제 기간 | 7일 (기본 버킷) | dev CLI | dev CLI: gcloud storage buckets list (2026-11-15) |
| Cloud Logging 보존 기간 | 기본 로그 버킷 30일, 위치 `global` | dev CLI | dev CLI: gcloud logging buckets list (2026-11-15) |
| 익명 계정 자동 정리 | dev에서 꺼져 있음 (MVP 내내 끔). prod에서는 켠다 (결정 목록 N3, Phase 6 D-26). prod에서 실제로 켰는지는 미확인 (prod 없음, prod 생성 때 또는 Phase 10에서 확인). 켜면 만든 지 30일이 지난 익명 계정을 그 뒤 언제든 지울 수 있음. 상한 없음. Identity Platform으로 업그레이드한 프로젝트만, 로그인 수단을 연결해 승격한 계정은 지우지 않음 (공식 문서: firebase.google.com/docs/auth/web/anonymous-auth) | dev 설정 기록(문서), 결정, 공식 문서 | `docs/kit-fork.md:509`, `docs/kit-fork.md:524`, 공식 문서: firebase.google.com/docs/auth/web/anonymous-auth |

- prod와 stg 프로젝트는 아직 없고 두 설정 파일은 placeholder이므로, 이 표의 값은 모두 dev 기준입니다 (`lib/core/firebase/firebase_options_prod.dart:2`, `lib/core/firebase/firebase_options_stg.dart:2`, 결정 목록 P1).
- 익명 계정 자동 정리가 dev에서 꺼져 있어 익명 계정(Auth 레코드)은 기한 없이 남습니다. 확인한 경로 안에서 앱은 익명 계정의 약관 동의를 서버에 쓰지 않습니다(구간 A). prod에서는 켜기로 결정 (N3, D-26). 앱 문서는 MVP 동안 끈다고 적음. (`docs/kit-fork.md:509`, 결정 목록 N3)
- Google Analytics 보존 기간은 콘솔 설정값을 확인하지 못해 표준 속성 선택지의 큰 쪽(최대 14개월)으로 적었습니다 (Phase 6 D-24). Cloud Logging 보존 기간은 dev 프로젝트를 CLI로 조회한 값입니다 (2026-11-15).
- Firebase Authentication이 미국에서만 운영된다는 사실은 prod 리전과 상관없이 처리방침의 국외 이전 항목에 들어갑니다 (결정 목록 N2).

### prod 전제 (Phase 6 D-42)

삭제 안내의 문장은 prod 프로젝트에 아래 다섯 가지가 된 것을 전제로 참이다. prod는 아직 없다 (결정 목록 P1). 이 목록이 다섯 가지의 유일한 목록이고, 다른 문서는 이 절을 가리킨다.

1. 익명 계정 자동 정리 켜기 (Phase 6 D-26. 앱 `docs/kit-fork.md` 「익명 자동 정리」 절은 MVP 동안 끈다고 적음. 삭제 안내에 쓸지는 Phase 6 D-33 ①)
2. `rate_limits`의 `expireAt` TTL 정책 켜기 (Phase 6 D-40. 앱 `docs/kit-fork.md` 사람 작업 12, `docs/guide.md` 「호출 횟수 제한 기록 정리」)
3. 탈퇴 정리 함수의 실행 계정에 Firestore 권한 주기 (앱 `docs/kit-fork.md` 「처음 설정」 6. 없으면 탈퇴 때 기록·뱃지·코스·확인자료 정리가 통째로 실패)
4. `location_use_records`의 `expireAt` TTL 정책 켜기 (Phase 6 D-41. 앱 `docs/kit-fork.md` 사람 작업 13)
5. 운영자 전용 계정, 관리자 claim, App Check 디버그 토큰 준비 (앱 `docs/operator-delete-tool.md` 「1회 준비」, `docs/kit-fork.md` 사람 작업 14. 없으면 메일 삭제 요청을 처리할 수 없음)

## 확인할 것

이 표는 이 문서의 「미확인」과 「CLI 미확인」 칸을 누가 어떻게 채우는지 짝지은 것입니다. CLI 행은 사용자가 `.planning/baseline/USER-TASKS.md`의 작업 11(CLI 재로그인)을 마치면 01-08 계획이 읽기 전용 명령으로 채웁니다. 작업 11을 하지 않으면 그 칸은 「CLI 미확인」으로 남습니다. 사용자 행은 같은 절차서의 작업 12(콘솔에서만 보이는 값 확인)에서 확인합니다.

| 미확인 칸 | 확인하는 사람 | 확인 방법 | 막는 단계 |
|---|---|---|---|
| Firestore 위치, PITR, 백업 일정 | Claude (사용자 재로그인 뒤, 01-08 계획) | 확인함 (2026-11-15). `gcloud firestore databases list`, `gcloud firestore backups schedules list` | Phase 6, Phase 7 |
| Firestore TTL 정책 (`fcmTokens.expireAt`, `mail`, `rate_limits`) | Claude (사용자 재로그인 뒤, 01-08 계획) | 확인함 (2026-11-15). `gcloud firestore fields ttls list` | Phase 7 |
| Storage 버킷 위치, 소프트 삭제 기간 | Claude (사용자 재로그인 뒤, 01-08 계획) | 확인함 (2026-11-15). `gcloud storage buckets list` | Phase 6, Phase 7 |
| 라우터 VM zone | Claude (사용자 재로그인 뒤, 01-08 계획) | 확인함 (2026-11-15). `gcloud compute instances list` | Phase 7 |
| 배포된 함수 리전, Trigger Email 확장 설치 여부 | Claude (사용자 재로그인 뒤, 01-08 계획) | 확인함 (2026-11-15). `gcloud functions list`, `firebase ext:list` | Phase 7 |
| Cloud Logging 보존 기간 | Claude (사용자 재로그인 뒤, 01-08 계획) | 확인함 (2026-11-15). `gcloud logging buckets list` | Phase 7 |
| Analytics 데이터 보관 설정 | 사용자 (절차서 작업 12) | Google Analytics > 관리 > 데이터 설정 > 데이터 보관 | Phase 6, Phase 7 |
| 제공자별 동의항목 필수/선택 | 사용자 (절차서 작업 12) | 카카오·네이버·LINE·Meta·Google 콘솔의 로그인 동의항목 화면 | Phase 7, Phase 10 |
| 네이버 지도 SDK가 보내는 항목 | 사용자·약관 확인 (결정 목록 U8) | 네이버 지도 이용약관, SDK 문서 | Phase 7, Phase 8 |
| Facebook SDK 실제 전송 | 사용자 (절차서 작업 12, 결정 목록 N1) | Meta Events Manager, 병합된 매니페스트 | Phase 7 |
| 마케팅 푸시 발송 여부 | 사용자 (절차서 작업 12, 결정 목록 N4) | 앱 계획 | Phase 7 |
| 익명 사용자의 탈퇴 경로 | 사용자 (절차서 작업 12, 결정 목록 N3) | 확인함 (Phase 6 연구, 기준 커밋 코드): 익명 사용자는 회원탈퇴에 갈 수 없음 (`auth_guard.dart:265-269`) | Phase 6, Phase 7 |

## CLI 조회 기록

조회일은 2026-11-15이고 대상은 dev 프로젝트입니다. 사용자가 `.planning/baseline/USER-TASKS.md`의 작업 11(CLI 재로그인)을 마친 뒤, 01-08 계획이 읽기 전용 명령(list)만 썼습니다. 설정을 바꾸거나 리소스를 만들고 지우거나 배포하는 명령은 쓰지 않았고, Firestore 문서와 Storage 객체의 내용은 읽지 않았습니다. 출력에서는 위치·상태·기간 값만 옮겼고 버킷·VM·함수 이름, 프로젝트 번호, 계정은 옮기지 않았습니다. 조회한 값은 모두 dev 값이며 prod 값이 아닙니다 (결정 목록 「prod 리전」).

| 조회 | 결과 | 반영한 칸 |
|---|---|---|
| `gcloud firestore databases list` (Firestore 위치, PITR) | 조회함 | 구간 A·C·E·F 본표의 Firestore 저장 위치 칸 전부, 구간 H 「Firestore 위치」·「Firestore PITR」 행, 구간 G 맺음 문장 |
| `gcloud firestore fields ttls list` (TTL 정책) | 조회함 | 구간 E `fcmTokens` 행의 보유 기간·삭제 방식, 구간 F `rate_limits`·`mail` 행의 보유 기간·삭제 방식, 구간 G `fcmTokens`·`rate_limits`·`mail` 행, 구간 H 「Firestore TTL 정책」 행 |
| `gcloud firestore backups schedules list` (백업 일정) | 조회함 | 구간 H 「Firestore 백업 일정」 행, 구간 G 맺음 문장 |
| `gcloud storage buckets list` (버킷 위치, 소프트 삭제) | 조회함 | 구간 A Storage 행의 저장 위치·국외 이전·보유 기간, 구간 G Storage 행, 구간 H 「Storage 기본 버킷 위치」·「Storage 소프트 삭제 기간」 행 |
| `gcloud compute instances list` (라우터 VM zone) | 조회함 | 구간 D `snapRoute` 행의 저장 위치, 구간 H 「라우터 VM zone」 행 |
| `gcloud functions list` (함수 리전) | 조회함 | 구간 H 「Cloud Functions 리전 (코드 상수)」·「배포된 함수의 실제 리전」 행 |
| `gcloud logging buckets list` (로그 보존) | 조회함 | 구간 D Cloud Logging 행의 저장 위치·국외 이전·보유 기간·삭제 방식, 구간 G Cloud Functions 로그 행, 구간 H 「Cloud Logging 보존 기간」 행 |
| `firebase ext:list` (Trigger Email 확장) | 조회함 | 구간 F `mail` 행의 보유 기간·삭제 방식, 구간 G `mail` 행, 구간 H 「Trigger Email 확장 설치 여부」 행 |

- `gcloud firestore fields ttls list`는 계획의 출력 형식으로 돌렸을 때 아무 줄도 나오지 않았습니다. 출력 형식의 필드 이름을 고쳐 한 번, 기본 출력으로 한 번 더 돌렸고, 기본 출력이 「0건」이라 TTL 정책이 없다는 결과로 적었습니다.
- `firebase ext:list`는 실행할 때 확장 API가 켜져 있는지 확인하는 단계를 거칩니다. 출력에 API를 새로 켰다는 줄은 없었습니다.
- 「확인할 것」 표의 CLI 행 여섯 개는 모두 확인했습니다.

---
*Data inventory baseline for: 러닝펜슬 웹사이트 심사 대응 (BASE-03)*
*Written: 2026-11-15*
