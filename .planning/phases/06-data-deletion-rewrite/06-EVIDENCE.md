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

## 06-03 앱 작업 요청

앱 작업 전 탐침이다. `$APP`의 지금 `HEAD`를 `git -C "$APP"`의 `rev-parse`·`grep`·`diff`·`show`만으로 읽었다. 탐침일 뿐이고, 항목마다 참인지는 재기준(06-04)이 앱 코드를 읽어 정한다.

APP_PRE=bfabc3a45d5d

```
appcheck bfabc3a45d5d runs-delete-callers=0 deletion-files-changed=13 rate-limits-in-deletion=0 visibility-in-deletion=0
```

기준 앱 커밋 `3afb20858257`부터 `APP_PRE`까지 `functions lib firestore.rules storage.rules config`의 차이(`git -C "$APP" diff --stat` 마지막 줄):

```
44 files changed, 1003 insertions(+), 282 deletions(-)
```

### 요청서

앱 작업(D-05)이 끝났다고 판정하는 기준이다. 각 행의 사실은 재기준(06-04)이 보고받은 앱 커밋의 코드(또는 앱 저장소 문서)에서 확인할 수 있는 문장으로 적었다. 구현 방식은 앱 쪽 재량이고, 이 표는 결과 사실만 정한다.

| 항목 | 참이어야 할 사실 | 결정 근거 |
|---|---|---|
| ① | 회원탈퇴와 운영자 도구(③ 「계정 전체」) 모두 그 사용자의 비공개 코스(`courses` 가운데 `creatorId == uid`이고 비공개인 문서)를 지우고, 공개 코스는 남긴다. | D-01, D-02 |
| ② | 탈퇴 때 문서 ID에 uid가 든 `rate_limits` 문서를 지운다. uid가 아닌 해시(IP·이메일 SHA-256 앞부분) 문서의 보존 기간(만료 필드나 정리 방식과 그 일수)이 코드나 앱 문서에 정해져 있다. | D-03 |
| ③ | 운영자 삭제 도구가 있다. 운영자가 uid를 넣어 실행하고, 범위는 「계정 전체」(탈퇴와 같은 단계: Storage, Auth, `users/{uid}`, `identity_index`, `fcmTokens`, `runs`, 뱃지, 비공개 코스, uid `rate_limits`)와 「위치 기록만」(그 uid의 `runs`. 뱃지 처리는 ⑤와 같게) 두 가지다. 실행 방법(명령이나 함수 이름)을 앱 문서나 코드 주석에서 읽을 수 있다. 제공자 서버 연결 해제를 포함할지는 앱 쪽 재량이다(사이트 문장은 D-32대로 어느 쪽이든 참). | D-07, D-14, D-32 |
| ⑤ | 앱에 기록을 지우는 화면이 있고 `RunRepository.delete`(또는 같은 일을 하는 저장소 함수)를 부른다. 메뉴 이름과, 기록을 지울 때 뱃지를 어떻게 하는지가 코드에 정해져 있다. | D-28, D-14 |
| ⑥ | U2 결론에 맞춰 위치정보 수집·이용·제공사실 확인자료를 기록한다. 무엇을, 어디에, 얼마 동안 두는지가 코드나 앱 문서에 있다. 동의 철회에 해당하는 세 경로에서 파기가 이렇게 된다: 회원탈퇴(운영자 도구 「계정 전체」 포함)와 운영자 도구 「위치 기록만」은 그 사용자의 개인위치정보(`runs` 경로)와 확인자료를 지체 없이 파기하고, 앱의 기록 삭제(⑤)는 그 기록의 경로와 그 기록에 해당하는 확인자료를 지체 없이 파기한다(일부 철회는 그 부분으로 한정. 위치정보법 제24조④, 연구 항목 10: 단서 없음). 이와 다르게 만들면(예: 탈퇴 뒤에도 확인자료를 일정 기간 보존) 삭제 안내의 철회 문장(DEL-06)이 참이 아니게 되므로 사이트 커밋이 열리지 않는다(Task 3 `DEL06_REPORT`, 06-04 Task 1이 코드로 확인). | D-31(D-15 대체), DEL-06, ROADMAP 성공 기준 3 |
| ⑦ | (조건부. Task 2에서 `app-delete`를 고를 때만 요청에 들어간다) 회원탈퇴와 운영자 도구 「계정 전체」가 그 기기의 Firebase installation ID 삭제를 부른다. | 연구 Open Question 3, Task 2 |

- 참고(이 관문을 막지 않음): D-05 ④ prod 익명 계정 자동 정리는 prod 프로젝트를 만들 때 켠다(D-26).

### U2 결론 요청

- U2 결론 한 줄을 함께 받는다: 위치기반서비스사업 신고 / 위치정보사업 등록 / 그 밖의 결론 가운데 무엇인지, 누가 확인했는지, 법률 확인을 거쳤는지(D-31). ⑥의 기록 모양은 이 결론에 따른다.

```
OK site-clean 06-03-t1 bb662e651d2e
```

## 06-03 결정

Remote Config·FCM이 쓰는 Firebase installation ID를 삭제 안내에서 어떻게 다룰지, 앱 작업을 시작하기 전에 사용자가 골랐다 (Task 2, `checkpoint:decision`, blocking-human).

INSTALL_ID=keep-out

- 고른 것: (가) keep-out. installation ID를 기기 단위 식별자로 보고 남는 데이터 표(D-04)에서 뺀다.
- 고른 과정: 사용자가 오케스트레이터에 권고를 물었고, 오케스트레이터는 keep-out을 권하며 이유를 댔다. 사용자가 그 말을 들은 뒤 keep-out을 직접 골랐다. 실행자는 고르지 않았다. 권고 이유는 두 가지였다. 첫째, app-delete를 골라도 메일 요청과 운영자 도구 경로에는 사용자 기기가 없어 삭제 호출의 상한이 서지 않으므로 설명 문장은 어느 쪽이든 필요하다. 둘째, keep-out이면 계정에 묶인 사실은 「탈퇴 때 `fcmTokens`를 지운다」(요청서 ③) 하나로 일관된다.
- 근거 사실 (공식 문서): installation ID는 삭제 API를 부를 때까지 남고, 부른 뒤 180일 안에 제거된다. 앱은 지금 삭제 API를 부르지 않는다 (데이터 목록 구간 E의 Remote Config 행, 구간 H의 installation ID 행).
- 앱 작업 범위: 조건부 항목 ⑦은 이번 앱 작업 요청에 들어가지 않는다. 사용자가 앱 저장소에서 할 작업은 ①②③⑤⑥ 다섯 가지다. 요청서 표의 ⑦ 행은 Task 1 기록이라 지우지 않지만 요청이 아니다 (app-delete를 골랐을 때만 요청에 들어가는 행이다). 06-04는 ⑦을 확인하지 않는다.
- 뒤 단계로 넘기는 것: 표 밖 설명 문장을 넣을지는 06-06 Task 3 물음 (f)에서, 그 문장은 06-07 원고 승인에서 정한다. 「앱을 지우면 함께 지워진다」는 OS 동작은 확인되지 않은 가정이라 쓰지 않는다.
