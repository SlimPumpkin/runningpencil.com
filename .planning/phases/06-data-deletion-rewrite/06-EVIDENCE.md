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

## 06-03 중간 보고 ⑤ (2026-11-26)

06-03 Task 3의 보고가 아니다. 앱 작업 ⑤(기록 삭제 화면) 하나가 먼저 끝났다는 앱 쪽 중간 보고를 받아 적었다. Task 3 보고는 ①②③⑤⑥과 관리도구가 모두 들어간 앱 커밋으로 한 번에 받는다(사용자 결정 2026-11-21, `.planning/notes/2026-11-21-admin-tool-design.md`). 그래서 이 구간에는 Task 3이 쓰는 표식(앱 작업 커밋, 항목별 경로, U2 진행 답, ⑥ 파기 답, 보고 완료)을 적지 않았고, 06-04는 이 구간의 해시를 기준으로 쓰지 않는다. 아래 사실이 참인지는 그때 06-04가 보고받은 커밋의 코드로 다시 정한다.

MID5_SEEN=787e0c5ebffc

### 보고받은 것

앱 쪽 보고(2026-11-26, 앱 quick 261126-dcc)를 옮겼다. 이 세션이 확인한 것은 다음 절에 따로 적었다.

- 앱 저장소 원격 `main`이 `787e0c5ebffc`다.
- 개념이 「기록 삭제」에서 뱃지 중심·코스 단위 삭제로 바뀌었다(앱 사용자 결정).
  - 코스 하나를 지우면 그 코스 뱃지(`users/{uid}/badges/{courseId}`, 있으면)와 그 코스의 내 `runs` 전부(완주·미완주 모두)를 함께 지운다.
  - 「모두 삭제」는 내 뱃지 전부와 내 `runs` 전부다(지워진 코스, 미완주만 있는 코스, 기록 없이 뱃지만 있는 경우 포함).
  - 뱃지만 남기거나 기록만 남기는 갈래는 없다. 요청서 ⑤를 낼 때의 두 선택지(뱃지를 남긴다, 기록이 0이면 지운다)는 둘 다 쓰지 않는다.
  - 코스 삭제(「이미 받은 뱃지는 남아요」)와 다른 이유: 코스 삭제는 만든 사람이 하는 일이고, 이 삭제는 달린 본인이 고르는 일이다.
- 메뉴 경로(한국어 글자 그대로):
  - 코스 상세 ⋮ → 「뱃지 삭제」(그 코스 뱃지가 있을 때) / 「기록 삭제」(뱃지가 없을 때)
  - 설정 → 「데이터 관리」 → 「뱃지와 기록 모두 삭제」
  - 확인 창은 지울 개수를 숫자로 보이고 「되돌릴 수 없어요」를 담는다. 게스트에게는 둘 다 보이지 않는다(게스트는 기록이 없음).
- ARB 키: `recordDelete*` 11개, `settingsDataSection`, `settingsDeleteAllRecords*` 4개 (ko·en·ja).
- 코드 위치: 규칙 주석은 `lib/features/runs/domain/record_deletion_targets.dart` 머리, 삭제 호출은 `lib/features/runs/application/record_deleter.dart`다. 문서마다 `RunRepository.delete`와 `BadgeRepository.delete`를 부르고 batch·쿼리 삭제는 쓰지 않는다(⑥의 서버 트리거가 문서를 한 건씩 받는 모양).
- 커밋: `0b21ae8e0519`(코스 상세 ⋮), `4ff2a47d83d1`(설정), `5b650ce4af9a`(같은 runId로 기기에 남은 원시 GPS 로그도 함께 지움. 그대로 두면 다음 [시작] 때 지운 기록이 다시 저장되던 경로), `564f76eb06d0`, `131a79baf76f`.
- 확인: Android·iPhone 실기기에서 확인했다. 미완주 기록을 새로 만들어 「기록 삭제」로 지운 뒤 dev Firestore에서 그 코스의 `runs` 0건을 조회했고, 건수(runs 48, 완주 28, badges 15)가 앱 표시와 같았다.
- ⑥(위치정보 확인자료)은 아직 구현 전이다.
- 사이트에 맞춰 달라는 것: 운영자 도구 「위치 기록만」(요청서 ③, D-14)도 같은 규칙을 따라 `runs`를 지우면 그 코스 뱃지를 함께 지운다. 그 이름과 안내 문구가 뱃지 삭제를 담도록 다시 본다. D-11 ②는 이제 참이지만 D-10의 경로 안내는 위 메뉴 이름으로 맞춘다.

### 이 세션이 읽은 것 (탐침)

`git -C "$APP"`의 `rev-parse`·`log`·`merge-base`·`cat-file`·`show`·`grep`·`diff`·`ls-tree`만 썼고 앱 저장소에 쓰지 않았다. 탐침일 뿐이고 판정이 아니다.

```
mid5 head 787e0c5ebffc origin-main=same clean=yes
mid5 ancestor 3afb20858257 yes
mid5 ancestor bfabc3a45d5d yes
mid5 commits 0b21ae8e0519,4ff2a47d83d1,5b650ce4af9a,564f76eb06d0,131a79baf76f in-head=5/5
mid5 path lib/features/runs/domain/record_deletion_targets.dart present
mid5 path lib/features/runs/application/record_deleter.dart present
mid5 probe 787e0c5ebffc runs-delete-callers=1 deletion-files-changed=32 rate-limits-in-deletion=6 visibility-in-deletion=0
mid5 arb ko recordDelete=11 settingsDataSection=1 settingsDeleteAllRecords=4
mid5 arb en recordDelete=11 settingsDataSection=1 settingsDeleteAllRecords=4
mid5 arb ja recordDelete=11 settingsDataSection=1 settingsDeleteAllRecords=4
```

- `mid5 probe` 줄은 `$W/lib.sh`의 `appcheck`(06-01 사양)를 그 커밋에 돌린 값이다. 06-03 요청 때(`APP_PRE`)는 호출 0, 바뀐 파일 13, `rate_limits` 0이었다. 호출 1곳은 `record_deleter.dart:47`이고, 같은 파일 49행이 `BadgeRepository.delete(uid:, courseId:)`를 부른다.
- 기준 앱 커밋 `3afb20858257`부터의 차이(`functions lib firestore.rules storage.rules config`): `121 files changed, 4227 insertions(+), 635 deletions(-)`.
- 한국어 문구(`lib/l10n/app_ko.arb`): `recordDeleteBadgeMenu` 「뱃지 삭제」, `recordDeleteRecordsMenu` 「기록 삭제」, `settingsDataSection` 「데이터 관리」, `settingsDeleteAllRecords` 「뱃지와 기록 모두 삭제」. 확인 창 본문 네 개(`recordDeleteBadgeBody`·`recordDeleteBadgeOnlyBody`·`recordDeleteRecordsBody`·`settingsDeleteAllRecordsBody`)가 모두 「되돌릴 수 없어요.」로 끝나고, 개수를 받는 세 개는 `{count}`나 `{badgeCount}`·`{runCount}`를 쓴다.
- 메뉴 키를 쓰는 화면 파일: `lib/features/courses/presentation/_widgets/course_delete_menu_button.dart`, `lib/features/settings/presentation/app_settings_sections.dart`.
- 규칙 주석(`record_deletion_targets.dart` 머리)이 보고의 삭제 규칙과 같고, 「운영자 삭제 도구 「위치 기록만」(사이트 요청 ③ · 사이트 D-14)도 이 규칙을 따른다」고 적는다.
- `record_deleter.dart`는 지운 run과 같은 runId의 원시 로그(`active_run.jsonl`)가 기기에 남아 있으면 함께 지운다.
- 앱 todo(`.planning/todos/`): `completed/2026-11-21-run-record-delete-screen.md`가 있다. `pending/`에 `2026-11-21-withdrawal-delete-private-courses-keep-public.md`(①)와 `2026-11-21-location-confirmation-records.md`(⑥)가 남아 있다.
- 읽지 않은 것: 화면 코드가 뱃지 유무로 두 메뉴를 가르는 조건과 게스트에게 숨기는 조건, 확인 창이 센 개수와 지우는 목록의 일치, ②·③의 상태. 실기기 확인과 Firestore 건수는 보고받은 그대로다.

### 뒤 계획이 맞춰야 할 것

앱 작업 전에 쓴 계획과 결정이 지금 사실과 다른 곳이다. 이 커밋에서는 계획과 CONTEXT를 고치지 않았다. Task 3 보고가 들어와 06-04로 넘어가기 전에 고친다.

- 06-04 Task 1의 `RUN_DELETE_MENU=<arb 키>`는 키 하나를 가정한다. 실제 메뉴 문구는 셋이고 진입 경로는 둘이다(코스 상세 ⋮의 「뱃지 삭제」 또는 「기록 삭제」, 설정 「데이터 관리」의 「뱃지와 기록 모두 삭제」).
- 06-04 Task 1의 `RUN_DELETE_BADGES=<keep|delete>`는 delete 쪽이지만 단위가 기록이 아니라 코스다. 기록 하나만 골라 지우는 갈래는 없다. 06-04 재기준 문장 「앱의 기록 삭제 화면(메뉴 …)에서 본인이 지울 수 있음. 지울 때 뱃지는 …대로」(구간 C 기록 두 행)와 뱃지 행의 삭제 칸이 이 단위를 따라야 한다.
- 데이터 목록 구간 C의 기기 안 원시 GPS 로그 행(「정상 종료면 저장 직후 삭제. 비정상 종료 때 남는 기간은 미확인」)은 `5b650ce4af9a`로 사실이 하나 늘었다(기록을 지울 때 같은 runId의 남은 로그도 지움). 06-04 재기준에서 이 행을 다시 본다.
- CONTEXT D-10: 일부 삭제 안내의 「기록」 경로는 위 메뉴 이름으로 쓴다. D-11 ②(「앱에서 기록을 지우면 저장된 GPS 궤적이 파기됩니다」)는 뱃지도 함께 지워진다는 사실과 코스 단위라는 사실을 담아야 한다.
- CONTEXT D-14와 요청서 ③: 요청서는 이미 「뱃지 처리는 ⑤와 같게」라고 적었으므로 요청 사실은 그대로다. 달라지는 것은 범위 이름 「위치 기록만」과 D-11 ③(「위치 기록 일괄 삭제를 요청할 수 있습니다. 계정은 유지됩니다.」)의 안내 문장이다. 메일로 위치 기록 삭제를 요청한 사용자는 뱃지도 모두 잃는다. 이름과 문장은 사용자가 정한다(06-05 절차서, 06-06 대조표, 06-07 원고가 이 이름을 쓴다).
- ⑥: `record_deleter.dart`가 문서를 한 건씩 지우는 모양은 ⑥의 서버 트리거를 기다리는 것이다. 앱 기록 삭제 때 확인자료가 파기된다는 사실은 ⑥이 들어온 뒤에만 참이다.

### 관문 상태

06-03 Task 3은 그대로 대기다. 남은 것은 앱 작업 ①②③⑥과 관리도구, 그리고 Task 3이 사용자 답으로만 받는 두 가지(U2가 법률 확인 전 초안일 때 진행할지, ⑥이 요청서의 파기 사실을 따르는지)다. U2 결론 자체는 결정 목록(`.planning/baseline/DECISIONS.md` U2)에 2026-11-21과 2026-11-26 날짜로 적혀 있다.

## 06-03 중간 보고 ② (2026-11-26)

사용자가 ②는 kit 저장소에 구현해 두었다고 알려 와서 kit 저장소와 앱 저장소를 읽었다. 앞 구간과 같이 Task 3의 보고가 아니고 Task 3이 쓰는 표식을 적지 않았다. 앞 구간의 「②·③의 상태는 읽지 않음」과 「관문 상태」의 남은 항목은 이 구간으로 고쳐 읽는다.

MID2_SEEN=787e0c5ebffc

### 이 세션이 읽은 것 (탐침)

kit 저장소(스타터 킷 개발 저장소)는 `$KIT`로 적는다. `git -C "$KIT"`와 `git -C "$APP"`의 `rev-parse`·`log`·`merge-base`·`show`·`grep`만 썼고 두 저장소에 쓰지 않았다. dev 프로젝트는 `gcloud firestore fields ttls list`(조회)만 불렀다. 탐침일 뿐이고 판정은 06-04가 한다.

```
mid2 kit 3bcbfcd0d96f origin-master=same version=1.0.0-rc.16
mid2 app 787e0c5ebffc kit-merge=57dab41a5f06 in-head=yes version=1.0.0-rc.16
mid2 same functions/src/shared/rate_limit.ts
mid2 same functions/src/auth/delete_user_account.ts
mid2 same docs/guide.md
mid2 same CHANGELOG.md
mid2 uid-prefixes=4 delete-call=functions/src/auth/delete_user_account.ts:404
mid2 window-sec uid=60,600 hash=60,600 max=600
mid2 dev-ttl rate_limits.expireAt=ACTIVE other-policies=0 date=2026-11-26
```

- 앱은 2026-11-26에 킷 v1.0.0-rc.16을 받았다(`57dab41a5f06` 「킷 v1.0.0-rc.16 반영」). 위 네 파일은 kit 끝 커밋과 앱 커밋에서 blob이 같다. 그래서 아래 행 번호는 앱 커밋 `787e0c5ebffc` 기준이다.
- uid가 든 문서: `functions/src/shared/rate_limit.ts:25-30`의 `UID_RATE_LIMIT_DOC_PREFIXES`가 접두사 넷(`lookupSignInMethods:`·`sendTestPush:`·`sendVerificationMail:`·`sendPasswordResetMail:`)을 두고, 같은 파일 66행 `deleteUidRateLimitDocs`가 접두사마다 uid를 붙인 문서를 batch 하나로 지운다. 회원탈퇴 `deleteUserAccount`는 Step 5(`functions/src/auth/delete_user_account.ts:404`)에서 이 함수를 부른다. counter 문서 ID를 만드는 곳은 네 함수 파일뿐이고(`lookup_sign_in_methods.ts`·`send_test_push.ts`·`send_verification_mail.ts`·`send_password_reset_mail.ts`) uid 축은 모두 `buildUidRateLimitDocId`를 거친다.
- Step 5가 실패해도 탈퇴는 `ok: true`로 끝나고 로그 `delete_user_rate_limits_orphan`만 남는다. 그때 남은 uid 문서와 탈퇴 뒤 다시 생긴 uid 문서는 아래 만료 시각과 TTL 정책이 지운다(같은 파일 머리 주석 116-118행, 159-161행).
- 해시 문서(IP·이메일 SHA-256 앞 32자): 탈퇴로 지우지 않는다. 모든 counter가 새 창을 열 때 만료 시각 `expireAt`(창이 끝나는 시각)을 쓴다(`rate_limit.ts:103` `computeExpireAt`). 창 길이는 함수 파일의 `*_WINDOW_SEC`이고 60초나 600초다. 해시 축은 `lookupSignInMethodsIp:`(60초), 비밀번호 재설정 메일의 IP(60초)와 이메일(600초), 인증 메일의 이메일(600초)이다.
- 지우는 것은 Firestore TTL 정책이다. 코드에는 일수가 없다. 앱 문서 `docs/guide.md` 「호출 횟수 제한 기록 정리」(4091행부터)가 켜는 순서(functions 재배포, `expireAt` TTL 정책 켜기, 옛 기록 한 번 지우기)와 한계를 적는다: 「실제 삭제는 만료 뒤 보통 24시간 안에 일어난다」, 「보장된 상한이 아니므로, 삭제 안내에 적을 보존 기간은 여유를 두고 정한다」, 「TTL 정책을 켜지 않은 프로젝트에서는 기록이 기한 없이 남는다」. `CHANGELOG.md`의 1.0.0-rc.16 절에도 같은 사용자 조치가 있다.
- dev 프로젝트: `rate_limits`의 `expireAt` TTL 정책이 `ACTIVE`다(2026-11-26 조회). dev의 TTL 정책은 이 하나뿐이다. 데이터 목록은 2026-11-15 조회 값(「TTL 정책 없음」)이라 지금과 다르다.
- 앱 커밋에서 `deleteUidRateLimitDocs`를 부르는 곳은 탈퇴 함수 하나뿐이다. 운영자 도구(③)가 부르는 곳은 아직 없고, Auth 삭제 트리거 `cleanup_user_data.ts`에도 이 단계가 없다.
- 확인하지 않은 것: dev에 새 functions가 배포됐는지, 만료 시각 없는 옛 기록을 지웠는지(guide 1·3단계).

### 뒤 계획이 맞춰야 할 것

- 06-04 Task 1의 ② 표식 `RATE_HASH_APP`은 값으로 일수나 none을 받는다. 앱이 정한 것은 일수가 아니라 「창 끝 시각에 만료, TTL 정책이 지움(보통 24시간 안, 상한 보장 없음)」이다. 「남는 데이터」 표에 적을 일수(`RATE_HASH_LIMIT_DAYS`)는 CONTEXT D-33 3번대로 사용자가 정한다.
- 그 문장은 TTL 정책을 켠 프로젝트에서만 참이다. prod 프로젝트는 아직 없으므로(결정 목록 P1) prod를 만들 때 guide의 세 단계를 하는 것이 전제다(D-26 익명 계정 자동 정리와 같은 종류의 prod 설정).
- 06-04 재기준에서 고칠 데이터 목록 행: 구간 F `rate_limits/{docId}` 행(필드에 `expireAt`, 보유 기간, 삭제 방식), 구간 G 「`rate_limits` 중 uid가 들어간 문서」 행, 구간 H 「Firestore TTL 정책」 행과 dev CLI 조회 날짜.
- 운영자 도구(③)의 「계정 전체」는 `deleteUidRateLimitDocs`를 불러야 요청서 ③의 「uid `rate_limits`」가 참이 된다(탈퇴 함수 머리 주석 149-150행이 그렇게 적는다).

### 관문 상태

06-03 Task 3은 그대로 대기다. 중간 확인이 끝난 것은 ②와 ⑤다. 남은 것은 앱 작업 ①③⑥과 관리도구, 그리고 Task 3이 사용자 답으로만 받는 두 가지(U2가 법률 확인 전 초안일 때 진행할지, ⑥이 요청서의 파기 사실을 따르는지)다.

## 06-03 중간 보고 ① (2026-11-26)

앱 작업 ①(탈퇴 때 비공개 코스 삭제)이 끝났다는 앱 쪽 중간 보고를 받아 적었다. 앞 두 구간과 같이 Task 3의 보고가 아니고 Task 3이 쓰는 표식을 적지 않았다. 앞 구간 「관문 상태」의 남은 항목은 이 구간으로 고쳐 읽는다.

MID1_SEEN=d6c1a12a35e9

### 보고받은 것

앱 쪽 보고(2026-11-26, 앱 quick 261126-g7m)를 옮겼다. 보고가 말하는 「D-28 개정」은 앱 저장소의 결정 번호이고 이 저장소 CONTEXT의 D-28(기록 삭제 화면)과 다른 것이다.

- 규칙: 탈퇴하면 기록(`runs`), 뱃지(`users/{uid}/badges`), 공개하지 않은 코스를 지운다. 공개하지 않은 코스는 비공개(`private`), 앞으로 생길 검수 대기(`pending`), `visibility` 값이 없는 코스다. 공개한 코스만 남고, 남은 코스에는 작성자 식별자(`creatorId`)만 연결된다. 이전에는 코스를 공개·비공개 구분 없이 모두 남겼다.
- 이유: 처음 결정은 모든 코스가 공개이던 때 내린 것이다. 비공개 저장이 생긴 뒤로는 탈퇴한 사람의 비공개 코스(그리다 만 코스, 집 주변 경로일 수 있음)가 아무에게도 보이지 않는 채로 남게 됐다.
- 구현: `functions/src/running_pencil/cleanup_user_data.ts`(Auth 삭제 트리거 `cleanupUserData`). 커밋 `3709f93b80c2`(함수), `5054fcc43099`(시험), `a91592ff2694`(앱 개인정보 임시 개요 문구). `courses where creatorId == uid`로 조회한 뒤 `visibility === "public"`인 코스만 남긴다. 일부가 실패해도 탈퇴는 끝나고 서버 로그에 「(partial)」이 남는다. 로그에는 uid와 개수만 들어간다.
- dev 확인(2026-11-26): `cleanupUserData`를 dev에 배포하고 일회용 계정으로 실제 탈퇴했다. 기록 1, 뱃지 1, 공개하지 않은 코스 3건(비공개·검수 대기·`visibility` 없음)이 지워지고 공개 코스는 남았다. dev에 남아 있던 탈퇴자 비공개 코스는 0건이었다.
- 함께 찾아 고친 문제: 이 함수는 1세대 함수라 App Engine 기본 서비스 계정으로 실행된다. 조직 정책 때문에 그 계정의 권한이 0개였고, dev에서는 그때까지 탈퇴 정리가 한 번도 성공하지 않았다(남은 로그 30회가 모두 `PERMISSION_DENIED`). dev는 그 계정에 `roles/datastore.user`를 줘서 고쳤다. prod를 만들 때도 같은 권한을 줘야 하고, 명령은 앱 저장소 `docs/kit-fork.md` 「처음 설정」 6번에 있다. 운영자 도구 「계정 전체」도 이 트리거를 쓰므로 같은 전제가 걸린다.
- 앱 안 임시 개요 4항 「보관·삭제」(ko): 「탈퇴하면 기록·뱃지·공개하지 않은 코스를 삭제합니다. 공개한 코스는 남고 작성자 식별자만 연결됩니다.」 en·ja도 같은 뜻으로 바꿨다. 임시 개요이고 확정 문언은 사이트 처리방침에 맞춘다.
- 사이트에 확인해 달라는 곳: 삭제 안내(지워지는 항목에 「공개하지 않은 코스」, 공개한 코스는 남음), 데이터 목록의 `courses` 행(「공개 코스만 남김(작성자 식별자 연결), 비공개·검수 대기는 삭제」), 처리방침(Phase 7)의 보관·삭제 절, 관리도구의 운영자 「계정 전체」(같은 트리거, prod 권한 전제).
- 남은 공백: 탈퇴한 사람의 공개 코스는 아무도 고치거나 지울 수 없다(규칙상 만든 사람만 가능). 신고가 오면 운영자가 관리도구에서 지우는 경로가 필요하다. 지금 앱은 코스를 만든 사람을 화면에 보이지 않는다. 나중에 창작자 프로필(`publicProfiles/{uid}`, 닉네임)이 생기면 탈퇴 때 그 정보도 지우고 「탈퇴한 사용자」로 표시할 예정이다.
- 배포 상태: dev는 배포와 실제 확인을 마쳤고, prod는 아직 없다.

### 이 세션이 읽은 것 (탐침)

`git -C "$APP"`의 `rev-parse`·`log`·`merge-base`·`cat-file`·`show`·`grep`·`diff`·`ls-tree`·`status`만 썼고 앱 저장소에 쓰지 않았다(fetch도 하지 않았다). 탐침일 뿐이고 판정은 06-04가 한다.

```
mid1 head d6c1a12a35e9 origin-main=787e0c5ebffc pushed=no clean=yes
mid1 commits 3709f93b80c2,5054fcc43099,a91592ff2694 in-head=3/3 in-origin=0/3
mid1 probe d6c1a12a35e9 runs-delete-callers=1 deletion-files-changed=33 rate-limits-in-deletion=6 visibility-in-deletion=4
mid1 arb termsDetailPlaceholder ko=1 en=1 ja=1
```

- 앱 로컬 `main` 끝은 `d6c1a12a35e9`이고, 원격 추적 가지 `origin/main`은 아직 `787e0c5ebffc`다. 보고된 세 커밋은 로컬에만 있다. Task 3 보고에 쓸 커밋은 그때 다시 받는다.
- `mid1 probe` 줄은 `$W/lib.sh`의 `appcheck`(06-01 사양)를 돌린 값이다. `visibility-in-deletion`이 0에서 4로 바뀌었다. 기준 앱 커밋 `3afb20858257`부터의 차이(`functions lib firestore.rules storage.rules config`): `123 files changed, 4543 insertions(+), 687 deletions(-)`.
- `cleanup_user_data.ts`(앱 `d6c1a12a35e9`): 76-79행이 `runs where userId == uid`를, 92-98행이 `courses where creatorId == uid`를 조회해 `visibility !== "public"`인 문서만 삭제 대상으로 넣는다. 138-140행이 `users/{uid}/badges`를 `recursiveDelete`로 지운다. 머리 주석 45-52행이 지우는 것과 남기는 것을 보고와 같게 적는다.
- 실패 처리(같은 파일 58-66행, 101-133행, 154-169행): 코스 조회나 일부 삭제가 실패해도 throw하지 않는다. error 로그(`cleanup_user_data_failed`, step `runs`·`courses`·`badges`)와 끝의 info 로그(「user data cleaned (partial)」)만 남고, 자동으로 다시 돌지는 않는다. 로그 필드는 uid와 개수다.
- 이 함수는 1세대 Auth 삭제 트리거다(68-71행). 머리 주석 39-41행은 `deleteUser(uid)` 단건 삭제와 콘솔 삭제가 이 이벤트를 내고, Admin bulk 삭제(`deleteUsers`)는 내지 않는다고 적는다.
- 공개 범위 값: `firestore.rules`의 규칙은 `private`와 `public`을 쓴다. `pending`은 다음 마일스톤에 검수 요청으로 바뀐다는 주석(317행)에만 나온다.
- `docs/kit-fork.md` 「처음 설정」(425행부터) 6번이 증상(30회 모두 실패), 원인(1세대 함수 실행 계정의 프로젝트 역할 0개), dev 조치(`roles/datastore.user`, 2026-11-26)를 적는다.
- 임시 개요 문구는 `lib/l10n/app_{ko,en,ja}.arb`의 `termsDetailPlaceholder` 4항에 있고 ko 글자가 보고와 같다.
- 앱 todo: `completed/2026-11-21-withdrawal-delete-private-courses-keep-public.md`. `pending/`에는 `2026-11-21-location-confirmation-records.md`(⑥)가 남아 있다.
- `lib`에서 `creatorName`·`creatorNickname`·`publicProfiles`를 찾으면 일치가 없다(만든 사람 표시가 없다는 보고와 어긋나지 않는다. 화면 코드는 읽지 않았다).
- 확인하지 않은 것: dev 배포 여부, 실제 탈퇴 결과와 건수, dev 서비스 계정의 역할, 남은 로그 30회. 보고받은 그대로다.

### 뒤 계획이 맞춰야 할 것

- 요청서 ①은 「비공개인 문서」를 지운다고 적었고, 앱은 그보다 넓게 「공개(`public`)가 아닌 것 전부」를 지운다. 요청 사실은 참이다. 삭제 안내와 데이터 목록의 낱말은 「비공개 코스」가 아니라 앱 문구 「공개하지 않은 코스」(비공개·검수 대기·`visibility` 없음)를 따른다(CONTEXT D-04의 예시 「비공개 코스」, 06-04 재기준의 코스 행 문장).
- 데이터 목록 구간 C 표 아래 메모(「탈퇴 정리 함수는 기록과 뱃지만 지우고 코스는 공개·비공개 모두 건드리지 않습니다」, `cleanup_user_data.ts:17-21`)는 사실과 행 번호가 모두 달라졌다. 06-04 재기준에서 고친다.
- 탈퇴 때 기록·뱃지·공개하지 않은 코스를 지우는 것은 Auth 계정 삭제 뒤에 도는 트리거이고, 실패하면 로그만 남는다. 「지워진다」는 문장과 위치정보 철회의 「지체 없이 파기」(DEL-06)를 쓸 때 이 실패 경로를 운영 절차(06-05 절차서: 실패 로그를 보고 다시 지우는 일)가 받쳐야 하는지 06-04·06-05에서 본다.
- 운영자 도구(③) 「계정 전체」가 이 트리거에 기대려면 Auth 사용자를 단건 `deleteUser(uid)`로 지워야 한다(bulk 삭제는 이벤트가 없다).
- prod 전제가 셋으로 늘었다. 모두 prod 프로젝트를 만들 때 하는 설정이고, 하지 않으면 삭제 안내의 문장이 prod에서 참이 아니다: 익명 계정 자동 정리(D-26), `rate_limits`의 `expireAt` TTL 정책(앞 구간 ②), App Engine 기본 서비스 계정의 `roles/datastore.user`(이 구간. 없으면 탈퇴 정리가 통째로 실패한다). 06-04 재기준이나 06-05 절차서에서 한곳에 모아 적는다.
- 탈퇴한 사람의 공개 코스는 만든 사람이 없어 아무도 고치거나 지울 수 없다. 「남는 데이터」 표의 공개 코스 행(기간)과 `/support/#report`의 신고 처리 문장이 운영자 삭제 경로(관리도구)와 맞아야 한다.
- 06-04의 `COURSE_CREATOR` 표식(공개 코스에 만든 사람이 보이는지)은 보고대로면 보이지 않는 쪽이다. 06-04가 화면 코드로 정한다.
- 처리방침(Phase 7)의 보관·삭제 절은 재기준한 데이터 목록을 따라 같은 규칙으로 쓴다.

### 관문 상태

06-03 Task 3은 그대로 대기다. 중간 확인이 끝난 것은 ①·②·⑤다. 남은 것은 앱 작업 ③(운영자 삭제 도구)·⑥(위치정보 확인자료)과 관리도구, 그리고 Task 3이 사용자 답으로만 받는 두 가지(U2가 법률 확인 전 초안일 때 진행할지, ⑥이 요청서의 파기 사실을 따르는지)다. ①은 앱 로컬 커밋이고 원격에는 아직 없다.
