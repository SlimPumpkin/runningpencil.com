# Phase 6 검증 기록

공개 저장소 규칙 (Phase 5 D-02·D-18):
- 사업자 값, 지원 이메일 주소, 스토어 개발자 이름 값을 이 기록에 적지 않는다. 키 이름(`site.data.company.<키>`)과 이름 표(`.planning/baseline/NAMES.md`) 행 이름으로만 가리킨다.
- 기록에는 행의 있음/없음, 건수, 사용자 대조 결과만 적는다.
- 스크래치는 `$W`, 앱 저장소는 `$APP`, 해시는 12자리로 적는다. 로컬 홈 경로, 임시 폴더의 실제 경로, IP, 토큰, 계정 이메일을 적지 않는다.

표식 줄 규칙: 표식은 줄 머리부터 `이름=값` 한 줄로 적는다. 보류·중단한 시도의 표식은 머리에 `HOLD<n>_`을 붙이고 구간 머리를 `## (보류 <n>) 06-NN …`으로 바꾼다.

## 06-01 기준

BASE_SHA=89f659a5fdca
BASE_LIVE=e0f233169329
APP_BASE=a5db31953e1e

```
OK scratch beside-repo
check-site: 통과 (커밋 89f659a5fdca, jekyll 3.10.0)
OK HTTP / 200 title=러닝펜슬 - 달리고 걷는 길이 아트가 됩니다
OK HTTP /privacy-policy/ 200 title=개인정보처리방침 - 러닝펜슬
OK HTTP /terms/ 200 title=서비스 이용약관 - 러닝펜슬
OK HTTP /data-deletion/ 200 title=데이터 삭제 안내 - 러닝펜슬
OK HTTP /support/ 200 title=고객 지원 - 러닝펜슬
OK base deletion robots=1 temp=1 u10=7 docmailto=0 filemailto=1 ids=0
appcheck a5db31953e1e runs-delete-callers=0 deletion-files-changed=13 rate-limits-in-deletion=0 visibility-in-deletion=0
OK site-clean 06-01-t1 89f659a5fdca
```

- U10 낱말 7의 내역: 포인트 2, 굿즈·코스북·배송지·전자상거래·수령인 각 1 (계획 때 센 값과 같다).
- 본문 블록 mailto 0, 파일 전체 mailto 1: 파일 전체의 1은 공유 푸터의 이메일 행이다. 뒤 가드는 파일 전체가 아니라 본문 블록(`doc`)을 본다 (RESEARCH Pitfall 1).
- 앱 HEAD가 계획 때(`21d5c86c1d65`)와 다르다. 받은 그대로 적었다. `deletion-files-changed=13`은 모두 `lib/features/settings/presentation/` 아래 파일이고, 두 삭제 함수 파일·규칙 파일·`functions/src/index.ts`·`lib/features/runs`는 바뀌지 않았다. 탐침일 뿐이고 판정은 06-04가 코드를 읽어 정한다.

## 06-01 도구

Task 2 답: install (브라우저 내려받기 포함, Phase 6 동안 같은 고정 버전·같은 경로 재설치 포함), 2026-11-20

PW_VERSION=1.59.1
PW_BROWSERS=chromium-1217,chromium_headless_shell-1217,webkit-2272

- 설치: Phase 5 스크래치 `pw/package.json`·`pnpm-lock.yaml`을 `$W/pw`에 복사해 `pnpm --dir "$W/pw" install --frozen-lockfile`. 설치된 버전은 playwright 1.59.1, pngjs 7.0.0이다. 세 브라우저 리비전이 캐시에 있어 내려받지 않았다.
- 도구: `$W/pw/p6-deletion.mjs` (scratch_contract 사양). 양성 시험 원고: `$W/fix/data-deletion.html` (가짜 주소 하나, 실제 값 없음, 커밋·ref 없음).
- 음성 대조: 기준 빌드 `$W/base`(포트 4601)에서 종료 코드 1. 검색 제외 meta와 h1이 다르고 앵커 여덟이 모두 없다.
- 양성 대조: `mkobj <BASE_SHA> data-deletion/index.html=<원고>`로 만든 ref 없는 시험 객체를 check-site로 점검하고 `$W/fix`로 빌드해 띄운 뒤(포트 4602) 돌렸다. 종료 코드 0. 앵커 서른두 줄은 모두 `ok`였고 `ok-end`는 이 원고에서 나오지 않았다(마지막 조항 뒤에 조항 둘과 푸터가 있어 모든 구간이 맨 위까지 올라온다).
- 선택 인자 확인: 같은 시험 빌드에 `cb=test --shot "$W/cap/fix"`로 다시 돌려 종료 코드 0, `PASS deletion`, OK 서른여섯 줄, 캡처 네 장(`<엔진>-<폭>.png`).
- 주의: `build fix`가 `$W/fix`를 통째로 지우고 다시 만들어 원고 `$W/fix/data-deletion.html`도 지워졌다. 빌드한 시험 객체의 `data-deletion/index.html` blob에서 같은 바이트로 되살렸고(blob 해시 같음), 사본을 `$W/fixture-data-deletion.html`에 두었다. `fix`로 다시 빌드하면 사본에서 되살린다.

음성 대조 (기준 `$W/base`):

```
FAIL chromium 375 deletion h1 mismatch
FAIL chromium 375 deletion robots=1
FAIL chromium 375 deletion ids=none missing=request,location,google,apple,facebook,kakao,naver,line extra=- dup=-
FAIL chromium 375 deletion first=missing
FAIL chromium 375 anchor request missing
FAIL chromium 375 anchor location missing
FAIL chromium 375 anchor google missing
FAIL chromium 375 anchor apple missing
FAIL chromium 375 anchor facebook missing
FAIL chromium 375 anchor kakao missing
FAIL chromium 375 anchor naver missing
FAIL chromium 375 anchor line missing
FAIL chromium 1280 deletion h1 mismatch
FAIL chromium 1280 deletion robots=1
FAIL chromium 1280 deletion ids=none missing=request,location,google,apple,facebook,kakao,naver,line extra=- dup=-
FAIL chromium 1280 deletion first=missing
FAIL chromium 1280 deletion mailfirst=missing
FAIL chromium 1280 anchor request missing
FAIL chromium 1280 anchor location missing
FAIL chromium 1280 anchor google missing
FAIL chromium 1280 anchor apple missing
FAIL chromium 1280 anchor facebook missing
FAIL chromium 1280 anchor kakao missing
FAIL chromium 1280 anchor naver missing
FAIL chromium 1280 anchor line missing
FAIL webkit 375 deletion h1 mismatch
FAIL webkit 375 deletion robots=1
FAIL webkit 375 deletion ids=none missing=request,location,google,apple,facebook,kakao,naver,line extra=- dup=-
FAIL webkit 375 deletion first=missing
FAIL webkit 375 anchor request missing
FAIL webkit 375 anchor location missing
FAIL webkit 375 anchor google missing
FAIL webkit 375 anchor apple missing
FAIL webkit 375 anchor facebook missing
FAIL webkit 375 anchor kakao missing
FAIL webkit 375 anchor naver missing
FAIL webkit 375 anchor line missing
FAIL webkit 1280 deletion h1 mismatch
FAIL webkit 1280 deletion robots=1
FAIL webkit 1280 deletion ids=none missing=request,location,google,apple,facebook,kakao,naver,line extra=- dup=-
FAIL webkit 1280 deletion first=missing
FAIL webkit 1280 deletion mailfirst=missing
FAIL webkit 1280 anchor request missing
FAIL webkit 1280 anchor location missing
FAIL webkit 1280 anchor google missing
FAIL webkit 1280 anchor apple missing
FAIL webkit 1280 anchor facebook missing
FAIL webkit 1280 anchor kakao missing
FAIL webkit 1280 anchor naver missing
FAIL webkit 1280 anchor line missing
FAIL deletion
```

양성 대조 (ref 없는 시험 객체, `$W/fix`):

```
check-site: 통과 (커밋 c52dc2f9efb5, jekyll 3.10.0)
OK chromium 375 deletion title=ok h1=ok robots=0 ids=request,location,google,apple,facebook,kakao,naver,line reqmailto=1 mailto=1 first=ok mailfirst=na figures=1/1
OK chromium 375 anchor request ok
OK chromium 375 anchor location ok
OK chromium 375 anchor google ok
OK chromium 375 anchor apple ok
OK chromium 375 anchor facebook ok
OK chromium 375 anchor kakao ok
OK chromium 375 anchor naver ok
OK chromium 375 anchor line ok
OK chromium 1280 deletion title=ok h1=ok robots=0 ids=request,location,google,apple,facebook,kakao,naver,line reqmailto=1 mailto=1 first=ok mailfirst=ok figures=1/1
OK chromium 1280 anchor request ok
OK chromium 1280 anchor location ok
OK chromium 1280 anchor google ok
OK chromium 1280 anchor apple ok
OK chromium 1280 anchor facebook ok
OK chromium 1280 anchor kakao ok
OK chromium 1280 anchor naver ok
OK chromium 1280 anchor line ok
OK webkit 375 deletion title=ok h1=ok robots=0 ids=request,location,google,apple,facebook,kakao,naver,line reqmailto=1 mailto=1 first=ok mailfirst=na figures=1/1
OK webkit 375 anchor request ok
OK webkit 375 anchor location ok
OK webkit 375 anchor google ok
OK webkit 375 anchor apple ok
OK webkit 375 anchor facebook ok
OK webkit 375 anchor kakao ok
OK webkit 375 anchor naver ok
OK webkit 375 anchor line ok
OK webkit 1280 deletion title=ok h1=ok robots=0 ids=request,location,google,apple,facebook,kakao,naver,line reqmailto=1 mailto=1 first=ok mailfirst=ok figures=1/1
OK webkit 1280 anchor request ok
OK webkit 1280 anchor location ok
OK webkit 1280 anchor google ok
OK webkit 1280 anchor apple ok
OK webkit 1280 anchor facebook ok
OK webkit 1280 anchor kakao ok
OK webkit 1280 anchor naver ok
OK webkit 1280 anchor line ok
PASS deletion
```

TOOLS_BASE=OK

```
OK site-clean 06-01-t3 89f659a5fdca
```

## 06-02 사실 확인

앱 기준 커밋 `3afb20858257`에서 `git -C "$APP"`의 `show`·`grep`·`ls-tree`만으로 다시 확인했다.

```
OK fact F1 disconnect six providers
OK fact F2 skippable
OK fact F3 apple-android unmeasured
OK fact F4 no run delete screen
OK fact F5 anon device-only terms
OK fact F6 anon rules-allow app-not-found
```

- F1: `kDisconnectSteps`는 기준 커밋에서 35-48행이다(연구 인용 36-49와 한 줄 차이, 내용은 같다). 카카오·Facebook은 `ServerDisconnectStep`(`disconnectKakaoProvider`·`disconnectFacebookProvider`), Google·Apple·네이버·LINE은 각 단계 파일이다. 네이버·LINE 단계는 다시 로그인한 뒤 서버 함수(`disconnectNaverProvider`·`disconnectLineProvider`)를 부른다. `lib/features/settings/data/disconnect/` 아래 파일은 일곱 개다.
- F2: `lib/l10n/app_ko.arb:372` `withdrawalDisconnectSkippedGuide`, `withdrawal_disconnect_notifier.dart:14` 「D-12: 모든 행은 건너뛸 수 있다 — 탈퇴는 항상 끝난다」.
- F3: `apple_disconnect_step.dart` 13-19행(Android 경로 설명과 17-19행 `[ASSUMED]` UAT 실측 주석).
- F4: `git grep -c`가 일치 없음(종료 코드 1), `run_repository.dart` 153-157행에 `delete` 정의만 있다.
- F5: `auth_guard.dart` 265-269행이 익명 사용자의 「내 계정」 진입을 설정으로 돌리고, `terms_notifier.dart` 19-24행이 익명 약관 동의를 기기 안(`SharedPreferences`)에 둔다고 적는다.
- F6: `mirror_account_email.ts` Step 0이 익명 호출을 `failed-precondition`으로 거절한다. `firestore.rules`의 `users/{userId}` create 허용은 기준 커밋에서 377-381행이다(연구 인용 376-381, 376행은 빈 줄). 데이터 목록에는 기준 커밋 행 번호로 적는다.

FACTS_BASE=OK

```
OK site-clean 06-02-t1 20c3bf0363ea
```

## 06-02 목록 정정

INV_FIX_SHA=ea0a0d7355d1

```
check-site: 통과 (작업 트리, jekyll 3.10.0)
vals filled=0 emitted=0 excluded=0 leak=skip(no new values)
OK site-clean 06-02-t2 ea0a0d7355d1
```

- 커밋은 `.planning/baseline/DATA-INVENTORY.md` 하나만 담는다. 기준 앱 커밋 줄(`3afb2085` (2026-11-13))은 그대로다.
- 기준 커밋 행 번호로 적었다: `disconnect_steps.dart:35-48`, `firestore.rules:377-381` (06-02 사실 확인의 F1·F6 메모).
- 네이버·LINE 연결 해제는 앱에서 다시 로그인한 뒤 서버 함수가 해제하므로 처리 위치에 Cloud Functions 리전을 적었다. 앱(기기)에서 제공자 API를 부르는 것은 Google·Apple 두 행이다.
- 같은 사실에 맞춰 함께 고친 칸: 구간 D 수탁자 칸(여섯 제공자)과 표 아래 메모, 구간 A 익명 행의 국외 이전 칸(`termsAccepted` 부분 삭제), 구간 C `region` 행의 보유 기간 괄호(기록은 탈퇴까지). 근거 경로 목록에 `withdrawal_disconnect_notifier.dart`와 `run_repository.dart`를 더했다.

## 06-02 결정 기록

DEC_SHA=ef3e0073b7b2

```
check-site: 통과 (작업 트리, jekyll 3.10.0)
OK site-clean 06-02-t3 ef3e0073b7b2
```

- 커밋은 `.planning/baseline/DECISIONS.md`와 `.planning/ROADMAP.md` 둘만 담는다. ROADMAP은 External Gates의 U2 행, 새 행 「Phase 6 앱 작업 묶음 (D-05 ①②③⑤⑥)」, Phase 6 `**External gates**:` 줄만 바꿨다(Plans 목록과 다른 단계는 그대로).
- 결정 목록: U6-가·U6-나 결정됨(D-01, D-02, D-22), N3 결정됨(D-26), U2 막는 단계에 Phase 6 커밋(D-31)과 마감 단계 「Phase 6 커밋 전」.
