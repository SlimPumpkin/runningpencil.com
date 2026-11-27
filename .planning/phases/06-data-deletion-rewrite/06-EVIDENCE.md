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

## 06-03 중간 보고 ⑥ (2026-11-26)

앱 작업 ⑥(위치정보 확인자료 기록)이 끝났다는 보고와, Task 3이 받는 답 가운데 일부를 사용자에게 받아 적었다. Task 3의 보고로는 닫지 않았다. 요청서 ③(운영자 삭제 도구)과 관리도구가 아직 없고, 보고도 ⑥의 세 파기 경로 가운데 운영자 「위치 기록만」은 도구가 없어 확인하지 못했다고 적었기 때문이다. 그래서 이 구간에도 Task 3이 쓰는 표식을 적지 않았다. 앞 구간 「관문 상태」의 남은 항목은 이 구간으로 고쳐 읽는다.

MID6_SEEN=e54b8bdd1a83

### 받은 것

사용자가 2026-11-26에 보낸 네 줄을 옮겼다.

- 앱 커밋 `e54b8bdd1a83`. 기능 커밋은 `ffc1a2437824`·`b0213047e939`·`6776c186eeb2`, 문서는 `docs/location-use-records.md`다.
- U2 결론: 위치기반서비스사업(위치정보법 제9조 신고). 법령 원문 조사 결과이고 법률 확인을 거치지 않았다.
- ⑥ 파기 답: 요청서의 파기 사실을 따른다(conform). 앱 기록 삭제와 탈퇴 두 경로는 dev에서 실제로 확인했다. 운영자 「위치 기록만」은 도구가 없어 확인하지 못했고, 같은 트리거가 덮는다.
- 보존 기간: 184일(어느 날 저장해도 달력 6개월 이상)에 자동 삭제 지연(보통 하루 안)이 더해진다.

받지 않은 것: U2가 법률 확인 전 초안이므로 Task 3은 초안으로 진행할지 기다릴지를 사용자 답으로 받는다. 이번 네 줄에는 그 답이 없다.

### 이 세션이 읽은 것 (탐침)

`git -C "$APP"`의 `rev-parse`·`log`·`merge-base`·`cat-file`·`show`·`grep`·`diff`·`ls-tree`·`status`만 썼고 앱 저장소에 쓰지 않았다. dev 프로젝트는 `gcloud firestore fields ttls list`(조회)만 불렀다. 탐침일 뿐이고 판정은 06-04가 한다.

```
mid6 head e54b8bdd1a83 origin-main=same clean=yes
mid6 ancestor 3afb20858257 yes
mid6 ancestor d6c1a12a35e9 yes
mid6 commits ffc1a2437824,b0213047e939,6776c186eeb2 in-head=3/3 in-origin=3/3
mid6 probe e54b8bdd1a83 runs-delete-callers=1 deletion-files-changed=35 rate-limits-in-deletion=6 visibility-in-deletion=4
mid6 path docs/location-use-records.md present
mid6 path functions/src/running_pencil/location_use_records/location_use_record.ts present
mid6 path functions/src/running_pencil/location_use_records/on_run_written.ts present
mid6 record collection=location_use_records doc-id=runId fields=8 retention-days=184
mid6 dev-ttl location_use_records.expireAt=ACTIVE rate_limits.expireAt=ACTIVE date=2026-11-26
mid6 operator-tool none
```

- 앱 로컬 `main`과 원격 추적 가지가 모두 `e54b8bdd1a83`이다. 앞 구간 ①의 세 커밋도 이 커밋의 조상이라 이제 원격에 있다. 기준 앱 커밋 `3afb20858257`부터의 차이(`functions lib firestore.rules storage.rules config`): `129 files changed, 5797 insertions(+), 688 deletions(-)`.
- 무엇: 확인자료는 달리기 기록 `runs/{runId}` 1건마다 1건이고 완주·미완주를 가리지 않는다. 필드는 여덟 개다(`uid`, `runId`, `runStartedAt`, `runEndedAt`, `recordedAt`, `collectionMethod`, `purpose`, `expireAt`. `location_use_record.ts:50-67`). 경로·좌표·코스 제목·이메일·이름은 넣지 않는다. 제공 기록은 없다(문서는 남에게 사용자 위치를 넘기는 경로가 없다고 적는다).
- 어디: Firestore `location_use_records/{runId}`(문서 ID가 runId). 규칙 `firestore.rules:364-366`이 클라이언트의 읽기·쓰기를 본인 것까지 모두 막는다. 쓰는 함수는 2세대 Firestore 트리거 `onRunWritten`(`on_run_written.ts:278-279`, `runs/{runId}`, `retry: true`)이다.
- 얼마: `LOCATION_USE_RECORD_RETENTION_DAYS = 184`(`location_use_record.ts:31`), `expireAt`은 서버 기록 시각에 184일을 더한 값이다. 지우는 것은 Firestore TTL 정책이고 만료 뒤 삭제까지 지연이 있다(문서: 보통 24시간 안). dev에는 이 정책이 `ACTIVE`다(2026-11-26 조회). prod는 앱 문서 `docs/kit-fork.md` 사람 작업 13번이다.
- 파기 (a) 앱 기록 삭제: `runs` 문서가 지워지면 `onRunWritten`의 삭제 처리가 그 runId의 확인자료를 지운다(`on_run_written.ts:212`). 생성 처리는 트랜잭션 안에서 `runs` 문서가 아직 있을 때만 쓰므로(132-155행) 기록 직후 삭제가 먼저 처리돼도 확인자료가 남지 않는다.
- 파기 (b) 회원탈퇴: `cleanupUserData`가 `runs`를 지우면 (a)의 트리거가 기록마다 지우고, 그와 따로 `location_use_records where uid == uid`를 직접 지운다(`cleanup_user_data.ts:124-136`). 실패하면 error 로그(step `location_use_records`)와 「(partial)」 info 로그가 남는다.
- 파기 (c) 운영자 도구 「위치 기록만」: 도구가 없다. `functions/src`에 운영자 삭제 함수로 보이는 것이 없고, 앱 문서도 「트리거가 덮음 · 미검증」으로 적는다.
- 앱 문서 `docs/location-use-records.md`(101줄)가 무엇·어디·얼마·파기 경로·dev 실제 확인을 적는다. dev 확인 기록은 run 생성 뒤 3초 안에 확인자료 생김, (a) 삭제 뒤 3초 안에 없어짐, 생성 직후 삭제 3회에 고아 0, (b) 계정 삭제 뒤 7초 안에 run·확인자료·run 없는 확인자료가 모두 없어짐이다.
- 임시 개요 4항(ko, `termsDetailPlaceholder`)에 「위치 이용 기록(확인자료)은 6개월 보관한 뒤 삭제하며, 탈퇴하거나 기록을 지우면 바로 삭제합니다.」가 더해졌다.
- 앱 todo: `completed/2026-11-21-location-confirmation-records.md`. `pending/`에 새로 `2026-11-26-location-terms-consent-step.md`, `2026-11-26-location-info-manager-designation.md`, `2026-11-26-location-records-view-and-notice.md`, `2026-11-26-operator-location-access-log.md`가 있다.
- 확인하지 않은 것: dev 배포와 실제 확인 결과(건수·시간·로그)는 앱 문서에 적힌 그대로다. 시험 코드는 읽지 않았다.

### 뒤 계획이 맞춰야 할 것

- 06-04 Task 1의 ⑥ 확인은 세 경로(회원탈퇴와 운영자 도구 「계정 전체」, 운영자 도구 「위치 기록만」, 앱 기록 삭제)를 모두 코드에서 읽어야 통과한다. 운영자 도구가 없는 지금은 (c)를 코드로 읽을 수 없다. ③이 들어온 뒤에 Task 3 보고를 받는다.
- 보존 기간은 「184일」이 코드 값이고 사용자 결정은 「6개월」이다(결정 목록 U2, 2026-11-26). 삭제 안내·처리방침·위치약관에 어느 쪽으로 적을지와 TTL 삭제 지연을 어떻게 적을지는 06-06 대조표와 06-07 원고에서 정한다. 탈퇴하거나 기록을 지우면 바로 지우므로, 이 기간은 「남는 데이터」가 아니라 이용 중인 사용자의 보관 기간이다.
- 데이터 목록에 새 행이 필요하다(06-04 재기준 구간 C의 확인자료 행): `location_use_records/{runId}`, 필드 여덟 개, 서버 전용, 184일과 TTL, 세 파기 경로. Functions 로그 행에는 `location_use_record_written`·`cleanup_user_data_done`의 필드(uid·동작·건수)가 더해진다.
- prod 전제가 넷이 됐다: 익명 계정 자동 정리(D-26), `rate_limits`의 `expireAt` TTL 정책, App Engine 기본 서비스 계정의 `roles/datastore.user`, `location_use_records`의 `expireAt` TTL 정책(이 구간. 켜지 않으면 확인자료가 기한 없이 남는다). 앱 쪽 목록은 `docs/kit-fork.md`의 「처음 설정」 6번과 사람 작업 13번이다.
- 탈퇴와 기록 삭제의 파기는 트리거가 한다. `onRunWritten`은 `retry: true`로 다시 시도하고, `cleanupUserData`는 실패하면 로그만 남긴다(앞 구간 ①의 실패 경로 메모와 같다).
- Phase 7·8이 읽을 것: 확인자료는 처리방침의 개인위치정보 항목과 위치약관의 「확인자료 보유 근거·기간」에 들어간다. 앱의 대기 todo 넷(위치약관 동의 단계, 위치정보관리책임자 지정, 열람·고지 기록, 운영자 열람 기록)은 위치약관(Phase 8) 문장의 전제다.

### 관문 상태

06-03 Task 3은 그대로 대기다. 중간 확인이 끝난 것은 ①·②·⑤·⑥이다. 남은 것은 앱 작업 ③(운영자 삭제 도구)과 관리도구, 그리고 Task 3이 사용자 답으로만 받는 것 가운데 U2 초안으로 진행할지다. ⑥ 파기 답은 두 경로에 대해 받았고, 운영자 도구 경로는 ③이 들어온 뒤 다시 받는다.

## 06-03 관문 조건 (2026-11-26 사용자 결정)

06-03 Task 3의 보고 조건을 사용자가 좁혔다. 앞의 중간 보고 구간들이 적은 「①②③⑤⑥과 관리도구가 모두 들어간 앱 커밋」과 「남은 것: … 관리도구」는 이 구간으로 고쳐 읽는다.

- 결정: Task 3은 앱 작업 ①②③⑤⑥이 들어간 앱 커밋으로 보고한다. ③은 서버 함수까지이고 운영자가 명령으로 부른다. 관리 화면(운영 본부 웹)은 조건에서 뺀다. 2026-11-21 결정(관리도구까지 다 만든 뒤 보고)을 대체한다(`.planning/notes/2026-11-21-admin-tool-design.md`).
- 이유: 앱 쪽이 운영 본부 웹 전체를 지인 배포 뒤로 미뤘다. 조건을 그대로 두면 Phase 6이 지인 배포 뒤까지 열리지 않는다.
- 요청서 ③은 그대로다. 「실행 방법(명령이나 함수 이름)을 앱 문서나 코드 주석에서 읽을 수 있다」는 서버 함수와 명령으로 채워진다.
- 사용자가 알린 것: ③은 지금 앱에서 작업 중이다.

### 이 세션이 읽은 것 (탐침)

앱 저장소를 읽기만 했다(`git`의 `rev-parse`·`status`·`log`·`worktree list`, 파일 읽기). 앱 끝 커밋은 `e54b8bdd1a83` 그대로다.

- 앱 `ROADMAP.md`의 Phase 07.2는 「데스크탑 웹 코스 에디터」다. Goal이 「관리도구 웹의 나머지(현황 · 요청 처리)도 범위 밖(지인 배포 뒤)」이라고 적는다. ③을 만드는 단계가 아니다.
- 앱 `.planning/notes/admin-ops-hub-direction.md`(2026-11-21)는 운영 본부 웹 전체를 지인 배포 뒤로 두고, 삭제 기능(요청서 ①②③⑤⑥)의 순서를 열린 질문으로 남겼다. 같은 메모가 「관리도구까지 만든 뒤 사이트 06-03 보고」와 「출시 전에는 ③을 명령으로, 화면은 나중에」가 어긋난다고 적는다.
- 앱 작업 트리에 커밋 전 폴더 `.planning/quick/261126-jux-operator-delete-tool/`이 있다(계획 전 문서 두 개). 코드가 아니고 커밋 전이라 바뀔 수 있다. 그 문서가 적은 방향은 다음과 같다.
  - callable `operatorDeleteUserData`(관리자 claim 확인)와 운영자 명령 `node infra/operator/delete_user_data.mjs <dev|prod> <uid> <account|records> [--apply]`. 기본은 지울 개수만 보이는 dry-run이다.
  - 범위 id는 `account`와 `records`다. 「위치 기록만」이라는 공개 이름과 안내 문장은 사이트가 정할 것으로 남겼다.
  - `account`는 탈퇴와 같은 단계를 도구가 직접 돈다(Auth는 단건 `deleteUser(uid)`, `deleteUidRateLimitDocs` 호출, runs·뱃지·공개하지 않은 코스·확인자료). `records`는 runs 전부와 뱃지 전부, 확인자료를 지운다.
  - 실행 흔적은 Cloud Logging 한 줄(운영자 uid, 대상 uid, 범위, 단계별 건수)이고 Firestore 문서는 만들지 않는다. 제공자 연결 해제는 넣지 않는다.

### 뒤 계획이 맞춰야 할 것

- 범위 이름 「위치 기록만」을 무엇으로 바꿀지는 ③을 막지 않는다(앱이 중립 id를 쓴다). 06-05 절차서, 06-06 대조표, 06-07 원고 전에 사용자가 정한다.
- 06-04 Task 1의 ③ 확인 문장(「계정 전체」와 「위치 기록만」 두 범위)은 앱의 범위 id와 짝지어 읽게 고친다.
- ③이 남기는 실행 로그(운영자 uid와 지운 사용자의 uid)는 탈퇴 뒤에도 Cloud Logging에 남는 데이터다. 06-04 재기준의 구간 G(Functions 로그의 uid)에서 다룬다.
- 관리 화면이 만드는 데이터(운영 기록, 인정 필드)는 이번 재기준에 들어가지 않는다. 그 기능이 나갈 때 데이터 목록·삭제 안내·처리방침·약관을 함께 고친다.

### 관문 상태

06-03 Task 3은 그대로 대기다. 남은 것은 앱 작업 ③ 하나와 Task 3 보고다. 보고에는 앱 커밋, 항목 ①②③⑤⑥의 경로, ③ 실행 방법이 적힌 곳, U2 초안으로 진행할지에 대한 답, 세 파기 경로(운영자 도구 포함)에 대한 ⑥ 파기 답이 들어간다.

## 06-03 중간 보고 ③ (2026-11-26)

앱 작업 ③(운영자 삭제 도구)이 끝났다는 앱 쪽 보고를 받아 적었다. 이것으로 요청서의 ①②③⑤⑥이 모두 앱 커밋에 들어왔다. Task 3은 사용자 답(기준 앱 커밋, U2 초안으로 진행할지, 세 경로에 대한 ⑥ 파기 답)을 받은 뒤 닫으므로 이 구간에도 Task 3이 쓰는 표식을 적지 않았다.

MID3_SEEN=92e986c3bb29

### 보고받은 것

앱 쪽 보고(2026-11-26, 앱 quick 261126-jux)를 옮겼다.

- 범위 이름 짝: `records`는 사이트의 「위치 기록만」이고 기록과 뱃지를 지운다. `account`는 「계정 전체」다.
- `functions/src/running_pencil/operator/operator_delete_user_data.ts`: callable `operatorDeleteUserData`. 머리 주석에 범위, 호출 조건, 실패 규칙, 감사 로그가 있다. 「계정 전체」가 단건 `deleteUser`와 `deleteUidRateLimitDocs(db, uid)`를 부르는 곳은 `applyAccountScope`다. admin claim을 본 뒤 운영자 Auth 계정을 다시 읽어 비활성, claim 회수, 토큰 폐기를 거부한다.
- `functions/src/running_pencil/operator/account_deletion_steps.ts`: Kit 탈퇴 단계를 따른 것(Storage `users/{uid}/`, 단건 `getAuth().deleteUser(uid)`, `identity_index`와 `users/{uid}`).
- `functions/src/running_pencil/user_data_cleanup.ts`: RunningPencil 정리 공유 helper `deleteRunningPencilUserData`(runs 문서 단위 삭제, `location_use_records where uid` 삭제, 뱃지, 공개하지 않은 코스).
- `functions/src/running_pencil/cleanup_user_data.ts`: 탈퇴 정리 트리거. 삭제 사실의 근거 코드가 이 파일에서 위 helper로 옮겨 갔다(트리거는 helper를 부르고 로그만 남긴다).
- `infra/operator/delete_user_data.mjs`: 운영자 명령. 기본은 dry-run이고 `--apply` 때 uid를 다시 입력받는다. 종료 코드 0은 모든 단계가 끝났을 때만이다.
- `docs/operator-delete-tool.md`: 범위, 서버 함수, 실행 방법, 1회 준비, 1시간 뒤 재확인, 제공자 연결 해제 답장 문장. 제공자 연결 해제는 도구가 하지 않는다.
- `docs/location-use-records.md`: 파기 경로 (c)(운영자 「위치 기록만」)의 방법과 dev 결과. 세 경로 (a) 앱 기록 삭제, (b) 탈퇴와 운영자 「계정 전체」, (c) 운영자 「위치 기록만」이 모두 코드와 dev 실측으로 읽힌다는 보고다.
- 커밋: 시작 기준 `e54b8bdd1a83`, 작업 `335bf2f98da7`부터 `bba9bde6664f`, 리뷰 수정 일곱(`34c9863eee7d`·`173803a57eb5`·`f8de5018ef5f`·`065ec3ce6919`·`23d9b3d4ea47`·`c019ed09bd3b`·`8ad7a66baa0b`), 검증 뒤 후속 셋(`bc3ec9299964`·`cd9c54ce85c4`·`4b2e847e873e`), dev 확인 기록 `590105935208`.

### 이 세션이 읽은 것 (탐침)

`git -C "$APP"`의 `rev-parse`·`log`·`rev-list`·`merge-base`·`cat-file`·`show`·`grep`·`diff`·`status`만 썼고 앱 저장소에 쓰지 않았다(fetch도 하지 않았다). 탐침일 뿐이고 판정은 06-04가 한다.

```
mid3 head 92e986c3bb29 origin-main=e54b8bdd1a83 pushed=no clean=yes
mid3 commits reported=13 in-head=13/13 in-origin=0/13 since-e54b8bdd1a83=20
mid3 probe 92e986c3bb29 runs-delete-callers=1 deletion-files-changed=35 rate-limits-in-deletion=6 visibility-in-deletion=2
mid3 path functions/src/running_pencil/operator/operator_delete_user_data.ts present
mid3 path functions/src/running_pencil/operator/account_deletion_steps.ts present
mid3 path functions/src/running_pencil/user_data_cleanup.ts present
mid3 path functions/src/running_pencil/cleanup_user_data.ts present
mid3 path infra/operator/delete_user_data.mjs present
mid3 path docs/operator-delete-tool.md present
mid3 path docs/location-use-records.md present
mid3 callable operatorDeleteUserData app-check=enforced timeout-sec=300 admin-claim=checked
```

- 앱 로컬 `main` 끝은 `92e986c3bb29`이고 `e54b8bdd1a83` 뒤로 커밋이 20개다. 원격 추적 가지 `origin/main`은 `e54b8bdd1a83` 그대로라 ③의 커밋은 로컬에만 있다. 기준 앱 커밋 `3afb20858257`부터의 차이(`functions lib firestore.rules storage.rules config`): `133 files changed, 8509 insertions(+), 707 deletions(-)`.
- `mid3 probe`의 `visibility-in-deletion`이 4에서 2로 줄었다. 삭제 코드가 `cleanup_user_data.ts`에서 `user_data_cleanup.ts`로 옮겨 갔기 때문이다. 06-01 사양의 `appcheck`는 두 삭제 파일만 세므로, 이 두 값은 더는 삭제 사실을 대표하지 않는다.
- `operator_delete_user_data.ts`(앱 `92e986c3bb29`): 812-813행이 `onCall`(`enforceAppCheck: true`, `timeoutSeconds: 300`), 299행이 `request.auth.token.admin !== true` 거부다. `applyAccountScope`(609행부터)가 `deleteAuthUserOnce`(627행), `deleteIdentityIndexAndUserDoc`(637행), `fcmTokens` `recursiveDelete`(644행), `deleteUidRateLimitDocs(db, uid)`(653행), `deleteRunningPencilUserData`(656행)를 차례로 부른다. `applyRecordsScope`(750행부터)는 `deleteRunningPencilUserData`(755행)를 부른다.
- `account_deletion_steps.ts`: 85-90행이 Storage `users/${uid}/` 아래를 지우고, 115-123행이 단건 `getAuth().deleteUser(uid)`를 부르며 `auth/user-not-found`는 `already_gone`으로 돌려준다. bulk 삭제 호출은 없다.
- `user_data_cleanup.ts`: `deleteRunningPencilUserData`(173행부터)가 `runs where userId == uid`(184-186행, `select()`로 ref만), `courses where creatorId == uid`에서 `visibility !== "public"`인 것(201-206행, `select("visibility")`), `location_use_records where uid == uid`(215-217행), `users/{uid}/badges` `recursiveDelete`(227행)를 지운다.
- `cleanup_user_data.ts`: 1세대 Auth 삭제 트리거(55-58행)가 60행에서 같은 helper를 부르고 로그만 남긴다.
- `docs/operator-delete-tool.md`(163줄)가 범위 표, 검사 순서 ①~⑥과 거부 사유, 응답과 실패 규칙, 감사 로그 네 종류(Cloud Logging만. 운영자 uid, 대상 uid, 범위, 건수), 실행 방법과 종료 코드, 1회 준비(운영자 계정, admin claim, App Check 디버그 토큰), 1시간 뒤 재확인, 서버가 하지 않는 것, dev 실제 확인 기록 (a)~(h)를 적는다.
- `docs/location-use-records.md` 53행의 (c) 줄이 「PASS(2026-11-26, quick 261126-jux)」로 바뀌었다.
- 확인하지 않은 것: dev 배포와 실제 확인 결과는 앱 문서에 적힌 그대로다. 시험 코드와 명령 스크립트 본문 전체는 읽지 않았다.

### 뒤 계획이 맞춰야 할 것

- 06-04가 읽을 근거 경로가 늘었다: 위 일곱 파일과 `functions/src/index.ts`. 탈퇴 때 지워지는 것의 근거는 `cleanup_user_data.ts`가 아니라 `user_data_cleanup.ts`다. 앞 구간 ①·⑥이 적은 `cleanup_user_data.ts` 행 번호는 `d6c1a12a35e9`와 `e54b8bdd1a83` 기준이라 지금과 다르다.
- 06-05 절차서(USER-TASKS 작업 13)는 도구 실행을 앱 문서 `docs/operator-delete-tool.md`로 가리키고, 본인 확인과 답장만 다룬다. 앱 문서의 답장 문장(「로그인에 쓴 서비스 … 의 연결은 각 서비스 안내에 따라 직접 해제해 주세요.」)과 사이트의 D-32 문장을 맞춘다.
- 앱 문서는 `records` 뒤에도 계정이 남아 기기에 남은 원시 로그나 오프라인 캐시가 기록을 다시 올릴 수 있다고 적는다(그래서 1시간 뒤 재확인을 둔다). 메일로 받은 위치 기록 삭제 요청을 「지체 없이」 처리한다는 문장(D-12)과 절차서가 이 재확인을 담아야 하는지 06-05·06-07에서 본다.
- 운영자 실행 로그(운영자 uid, 지운 사용자의 uid, 범위, 건수)는 삭제 뒤에도 Cloud Logging에 남는다. 06-04 재기준의 구간 G와 Functions 로그 행에서 다룬다.
- prod 전제가 다섯이 됐다: 앞 구간의 넷에 운영자 전용 계정, admin claim, App Check 디버그 토큰 준비가 더해졌다(앱 문서 「1회 준비」, `docs/kit-fork.md` 사람 작업 14번). 준비가 없으면 메일 삭제 요청을 처리할 수 없다.
- 앱 설계 문서 `docs/superpowers/specs/2026-11-21-admin-tool-design.md` 머리말의 「사이트 06-03 보고 순서」는 아직 2026-11-21 결정(관리도구까지 다 만든 뒤 보고)으로 적혀 있다. 앱 쪽에서 고칠 곳이다.

### 관문 상태

요청서의 앱 작업 ①②③⑤⑥이 모두 앱 로컬 커밋 `92e986c3bb29`에 있다. Task 3을 닫는 데 남은 것은 사용자 답 셋이다: 기준으로 삼을 앱 커밋, U2가 법률 확인 전 초안일 때 진행할지, 세 파기 경로 모두에 대한 ⑥ 파기 답.

## 06-03 앱 작업 보고

사용자가 Task 3(`checkpoint:human-action`, blocking-human)에 답했다 (2026-11-26). 요청서의 앱 작업 ①②③⑤⑥이 앱 커밋에 들어왔고 U2 결론을 받았다. 아래 값은 받은 그대로다. 항목마다 요청서의 사실이 참인지는 06-04 Task 1이 이 커밋의 앱 코드를 읽어 정한다. 이 계획은 앱 저장소에 쓰지 않았다.

APP_WORK_HEAD=92e986c3bb29
APP_ITEM_1=functions/src/running_pencil/user_data_cleanup.ts,functions/src/running_pencil/cleanup_user_data.ts
APP_ITEM_2=functions/src/auth/delete_user_account.ts,functions/src/shared/rate_limit.ts,docs/guide.md
APP_ITEM_3=functions/src/running_pencil/operator/operator_delete_user_data.ts,functions/src/running_pencil/operator/account_deletion_steps.ts,infra/operator/delete_user_data.mjs,docs/operator-delete-tool.md
APP_ITEM_5=lib/features/runs/domain/record_deletion_targets.dart,lib/features/runs/application/record_deleter.dart,lib/features/courses/presentation/_widgets/course_delete_menu_button.dart,lib/features/settings/presentation/app_settings_sections.dart,lib/l10n/app_ko.arb
APP_ITEM_6=functions/src/running_pencil/location_use_records/on_run_written.ts,functions/src/running_pencil/location_use_records/location_use_record.ts,docs/location-use-records.md,firestore.rules
U2_RESULT=위치기반서비스사업(위치정보법 제9조 신고 대상). 사용자가 법령 원문 조사로 정했고 법률 확인을 거치지 않았다
U2_STATUS=draft
U2_PROCEED=user-accepted-draft
DEL06_REPORT=conform
APP_WORK=reported

- 기준 앱 커밋: 사용자가 `92e986c3bb29`를 골랐다(앱 로컬 `main`의 끝. 물음에 대한 답). 받은 때 이 커밋은 앱 로컬에만 있었고 앱의 원격 추적 가지는 `e54b8bdd1a83`이었다. 06-04는 로컬 앱 저장소 `$APP`에서 읽는다.
- 항목별 경로의 출처: ①③⑤⑥은 사용자가 넘긴 앱 쪽 보고(위 중간 보고 구간 ①·③·⑤·⑥)가 준 파일과 그 보고가 가리킨 문서다. ②는 사용자가 「kit 저장소에 구현해 두었다」고 알려 와 이 세션이 앱 커밋에서 찾은 파일이다(앱이 킷 v1.0.0-rc.16을 받은 것. 위 중간 보고 ②).
  - ①은 두 파일을 함께 적었다. 삭제 코드는 `user_data_cleanup.ts`에 있고 탈퇴 정리 트리거 `cleanup_user_data.ts`가 그것을 부른다(③ 작업에서 옮겨 갔다).
  - ⑤에는 메뉴가 붙은 화면 파일 둘과 한국어 문구 파일을 더했다(06-04가 메뉴 이름을 읽을 곳).
  - ⑥에는 확인자료 컬렉션을 막는 규칙 파일을 더했다.
- ③ 운영자 도구의 실행 방법이 적힌 곳: `docs/operator-delete-tool.md`의 「실행 방법」(명령 `node infra/operator/delete_user_data.mjs <dev|prod> <uid> <account|records> [--apply]`, 서버 함수 `operatorDeleteUserData`). 범위 id `account`가 요청서의 「계정 전체」, `records`가 「위치 기록만」이다(같은 문서 「범위 두 가지」).
- U2: 결론과 확인한 사람은 위 표식 한 줄이다(결정 목록 U2, 2026-11-21과 2026-11-26). 법률 확인을 거치지 않은 초안이라 진행할지를 물었고, 사용자가 초안으로 진행(draft-proceed)을 골랐다. 실행자가 대신 고르지 않았다.
- ⑥ 파기 답: 세 경로(앱 기록 삭제, 회원탈퇴와 운영자 「계정 전체」, 운영자 「위치 기록만」) 모두에 대해 사용자가 conform을 골랐다. 앞서 운영자 도구가 없을 때 받은 답은 두 경로에 대한 것이었고(위 중간 보고 ⑥), 이 답은 ③이 들어온 뒤 다시 받은 것이다.
- ⑦은 요청에 들지 않았다(`INSTALL_ID=keep-out`). `APP_ITEM_7`은 적지 않는다.
- 보고 조건은 「①②③⑤⑥이 들어간 앱 커밋, ③은 서버 함수와 명령」이다(위 「06-03 관문 조건」). 관리 화면은 이 보고에 들지 않는다.
- 비밀, 토큰, 계정 값은 받지도 적지도 않았다.

받은 경로가 그 커밋에 있는지만 이 세션이 읽기 전용으로 봤다(판정이 아니다. 06-04 Task 1이 다시 한다).

```
t3 head 92e986c3bb29 descends 3afb20858257
t3 paths items=5 files=18 exists=18/18 in-diff-since-3afb20858257=18/18
```

## 06-04 앱 사실

기준 앱 커밋 `AW`(`APP_WORK_HEAD`)의 코드와 앱 문서를 `git -C "$APP"`의 `rev-parse`·`rev-list`·`cat-file`·`merge-base`·`diff`·`show`·`grep`만으로 읽었다. 앱 저장소에 쓰지 않았고 fetch도 하지 않았다. 앱 작업 트리와 앱 HEAD에서는 사실을 읽지 않았다. 앱 HEAD는 해시와 `AW..HEAD` 차이의 파일 이름만 읽어 기준 뒤 이동을 쟀다(재계획 보충 규칙 2번 예외 (가)). 행 번호는 모두 `AW` 기준이다.

APP_HEAD=92e986c3bb29
RATE_EXPIRY=window-end-ttl
RECDEL_UNIT=course
RECDEL_BADGES=with-runs
APP_FACTS=OK

```
OK app head descends 3afb2085
OK app drift d52d13a74f9b commits=10 evidence-paths=0
OK app item 1 path-in-diff files=2
OK app item 2 path-in-diff files=3
OK app item 3 path-in-diff files=4
OK app item 5 path-in-diff files=5
OK app item 6 path-in-diff files=4
OK app item 1 fact nonpublic-deleted public-kept records-keeps-courses
SRC item1 functions/src/running_pencil/user_data_cleanup.ts:173-177, functions/src/running_pencil/user_data_cleanup.ts:198-208, functions/src/running_pencil/cleanup_user_data.ts:60-64, functions/src/running_pencil/operator/operator_delete_user_data.ts:656-660, functions/src/running_pencil/operator/operator_delete_user_data.ts:755-759
OK app item 2 fact uid-docs-deleted expire=window-end ttl=policy
SRC item2 functions/src/shared/rate_limit.ts:25-30, functions/src/shared/rate_limit.ts:66-75, functions/src/shared/rate_limit.ts:103-105, functions/src/shared/rate_limit.ts:185, functions/src/shared/rate_limit.ts:265, functions/src/auth/delete_user_account.ts:403-404, functions/src/running_pencil/operator/operator_delete_user_data.ts:650-654, docs/guide.md:4091-4096, docs/guide.md:4126-4128
OK app item 3 fact operator-tool scopes=account,records admin-claim app-check dry-run-default no-provider-disconnect
SRC item3 functions/src/running_pencil/operator/operator_delete_user_data.ts:812-813, functions/src/running_pencil/operator/operator_delete_user_data.ts:299, functions/src/running_pencil/operator/operator_delete_user_data.ts:82-83, infra/operator/delete_user_data.mjs:6-7, infra/operator/delete_user_data.mjs:512-524, docs/operator-delete-tool.md:9-12, docs/operator-delete-tool.md:74-80, docs/operator-delete-tool.md:132
OK app item 3 log cloud-logging-only
SRC item3-log functions/src/running_pencil/operator/operator_delete_user_data.ts:44-46, functions/src/running_pencil/operator/operator_delete_user_data.ts:183-187, functions/src/running_pencil/operator/operator_delete_user_data.ts:784-789, functions/src/running_pencil/operator/operator_delete_user_data.ts:852-859, functions/src/running_pencil/operator/operator_delete_user_data.ts:878-888, docs/operator-delete-tool.md:60-69
OK app item 5 fact course-unit badges-with-runs raw-log-removed
SRC item5 lib/features/runs/domain/record_deletion_targets.dart:3-6, lib/features/runs/application/record_deleter.dart:47, lib/features/runs/application/record_deleter.dart:49, lib/features/runs/application/record_deleter.dart:65-71
OK app item 6 fact location-evidence destroyed-on-withdrawal paths=a,b,c retention-days=184
SRC item6 functions/src/running_pencil/location_use_records/location_use_record.ts:21, functions/src/running_pencil/location_use_records/location_use_record.ts:31, functions/src/running_pencil/location_use_records/location_use_record.ts:50-67, firestore.rules:364-366, functions/src/running_pencil/location_use_records/on_run_written.ts:209-212, functions/src/running_pencil/location_use_records/on_run_written.ts:279-280, functions/src/running_pencil/user_data_cleanup.ts:213-220, functions/src/running_pencil/cleanup_user_data.ts:60-64, functions/src/running_pencil/operator/operator_delete_user_data.ts:656-660, functions/src/running_pencil/operator/operator_delete_user_data.ts:755-759, docs/location-use-records.md:47-53
OK app cleanup-log event=cleanup_user_data_failed
SRC cleanup-log functions/src/running_pencil/cleanup_user_data.ts:66-76, functions/src/running_pencil/cleanup_user_data.ts:103-143
APP_DIFF lines=6058
OK site-clean 06-04-t1 1bc5e4a04315
```

- 앱 HEAD 이동: 앱 로컬 `main` 끝은 `d52d13a74f9b`이고 `AW`는 그 조상이다. `AW` 뒤 커밋 10개가 바꾼 파일은 14개이고 모두 앱의 `.planning/`과 `.claude/` 아래 문서다. 삭제 관련 경로(항목별 경로 열여덟 개, `functions`, `lib/features/runs`·`settings`·`courses`, `lib/l10n/app_ko.arb`, `firestore.rules`, `storage.rules`, `infra/operator`, 앱 문서 넷)는 0개다. 기준은 `AW` 그대로다(D-36).
- ①: `deleteRunningPencilUserData`가 `shouldDeletePrivateCourses`가 참일 때만 `courses where creatorId == uid`를 읽어 `visibility !== "public"`인 문서를 지운다(값이 `private`인 것, `pending`인 것, 값이 없는 것이 모두 해당). 탈퇴 정리 트리거 `cleanupUserData`와 운영자 함수 `applyAccountScope`는 참으로, `applyRecordsScope`는 거짓으로 부른다. `functions/src/index.ts:87`·`96`·`99`가 `cleanupUserData`·`onRunWritten`·`operatorDeleteUserData`를 내보낸다.
- ②: 접두사 넷(`lookupSignInMethods:`·`sendTestPush:`·`sendVerificationMail:`·`sendPasswordResetMail:`)에 uid를 붙인 문서를 `deleteUidRateLimitDocs`가 batch 하나로 지운다. 부르는 곳은 탈퇴 함수 Step 5와 `applyAccountScope`다. 새 창을 여는 두 곳(`rate_limit.ts:185`·`265`)이 모두 `expireAt`을 `computeExpireAt`(창 시작 초 + 창 길이)로 쓴다. 창 길이 상수는 여섯이고 값은 60이나 600이다(`lookup_sign_in_methods.ts:57`, `send_test_push.ts:65`, `send_verification_mail.ts:55`, `send_password_reset_mail.ts:72`·`79`·`83`). `rate_limit.ts`에는 일수가 없다. 지우는 것은 Firestore TTL 정책이고 앱 문서가 「만료 뒤 보통 24시간 안」, 「보장된 상한이 아님」, 「TTL 정책을 켜지 않은 프로젝트에서는 기한 없이 남음」을 적는다. 탈퇴 함수의 Step 5가 실패하면 탈퇴는 그대로 끝나고 로그 `delete_user_rate_limits_orphan`만 남는다.
- ③: `operatorDeleteUserData`는 `onCall`(`enforceAppCheck: true`, `timeoutSeconds: 300`)이고 `request.auth.token.admin !== true`면 거부한다. 범위 id는 `account`와 `records` 둘이다. 명령은 먼저 dry-run으로 부르고, `--apply`일 때만 uid를 한 번 더 입력받아 같으면 `dryRun: false`로 다시 부른다. 앱 문서 「서버가 하지 않는 것」이 로그인 제공자 연결 해제를 하지 않는다고 적는다. 로그 이벤트는 넷(`operator_delete_user_data_dry_run`·`_done`·`_failed`·`_rejected`)이고 필드는 운영자 uid, 대상 uid, 범위, dry-run 여부, 건수, 단계 결과 토큰이다(거부 로그에는 대상 uid가 없다). `functions/src/running_pencil/operator/` 아래 코드에는 Firestore 문서를 만들거나 고치는 호출(`set`·`add`·`create`·`update`)이 없다.
- ⑤: 규칙 주석이 코스 단위(그 코스 뱃지와 그 코스의 내 기록 전부, 완주·미완주 모두)와 「모두 삭제」(내 뱃지 전부와 내 기록 전부)를 적고, 뱃지만 남기거나 기록만 남기는 갈래가 없다고 적는다. `RecordDeleter.deleteTargets`가 기록마다 `RunRepository.delete`, 뱃지마다 `BadgeRepository.delete`를 부르고, 기기에 남은 원시 로그(`active_run.jsonl`)의 runId가 지운 기록 안에 있으면 그 로그를 지운다.
- ⑥: 확인자료는 `location_use_records/{runId}`이고 필드는 여덟 개(`uid`, `runId`, `runStartedAt`, `runEndedAt`, `recordedAt`, `collectionMethod`, `purpose`, `expireAt`)다. 경로·좌표가 없다. `LOCATION_USE_RECORD_RETENTION_DAYS = 184`. 규칙이 클라이언트 읽기·쓰기를 모두 막는다. 파기 (a) `onRunWritten`(`runs/{runId}`, `retry: true`)의 삭제 처리가 지워진 기록의 확인자료를 지운다. (b) 탈퇴 정리 트리거와 `applyAccountScope`가 `deleteRunningPencilUserData`로 `location_use_records where uid == uid`를 지운다. (c) `applyRecordsScope`가 같은 함수로 같은 쿼리를 지운다. 세 경로 모두 기록 문서도 문서 단위로 지우므로 (a)의 트리거가 함께 돈다.
- 탈퇴 정리 실패 로그: `cleanupUserData`는 단계(`runs`·`courses`·`location_use_records`·`badges`)가 실패해도 throw하지 않고 error 로그 `cleanup_user_data_failed`(uid, 단계, 오류 코드나 실패 건수)를 남긴다.
- `appcheck`는 돌리지 않았다(재계획 보충 규칙 3번). `$W/app-diff.txt`는 데이터 목록 「근거로 삼은 경로」 71개와 항목별 경로 18개를 합친 83개 경로의 `3afb2085..AW` 차이이고, 그 가운데 바뀐 파일은 27개다.
- 앱 쪽 dev 실측(건수·시간)은 다시 재지 않았다. 앱 문서에 적힌 그대로다.

## 06-04 화면 사실

삭제 안내 원고와 운영 절차서가 쓸 앱 화면 사실을 `AW`에서 키와 식으로 다시 찾았다. 연구가 적은 `3afb2085` 시점 행 번호는 쓰지 않았다. 근거 줄은 모두 `AW` 기준 `경로:행`이다. 앱 저장소는 읽기만 했다.

LOC_CONSENT_CONTROL=none-found
ANON_WRITE=none-found
COURSE_CREATOR=hidden
SCREEN_FACTS=OK

```
OK withdrawal label 회원탈퇴
OK account screen labels 내 계정,표시 이름,이메일,가입일,가입 수단,연결된 계정
OK account screen fields email-dash withdrawal-bottom
SRC account lib/l10n/app_ko.arb:244, lib/l10n/app_ko.arb:85-86, lib/l10n/app_ko.arb:89-91, lib/l10n/app_ko.arb:349, lib/features/settings/presentation/account_screen.dart:66, lib/features/settings/presentation/account_screen.dart:97, lib/features/settings/presentation/account_screen.dart:111, lib/features/settings/presentation/account_screen.dart:125, lib/features/settings/presentation/account_screen.dart:139, lib/features/settings/presentation/account_screen.dart:158, lib/features/settings/presentation/account_screen.dart:175, lib/features/settings/presentation/account_screen.dart:201, lib/features/settings/presentation/_widgets/danger_zone_section.dart:79
SRC account-photo lib/l10n/app_ko.arb:87, lib/features/settings/presentation/account_screen.dart:107, lib/features/settings/presentation/_widgets/profile_photo_tile.dart:203
OK menu courseDetailMore 더보기
OK menu courseDetailDelete 코스 삭제
OK menu recordDeleteBadgeMenu 뱃지 삭제
OK menu recordDeleteRecordsMenu 기록 삭제
OK menu settingsDataSection 데이터 관리
OK menu settingsDeleteAllRecords 뱃지와 기록 모두 삭제
OK menu settingsProfilePhotoRemove 올린 사진 삭제
SRC menu lib/l10n/app_ko.arb:302-303, lib/l10n/app_ko.arb:608-609, lib/l10n/app_ko.arb:619-620, lib/l10n/app_ko.arb:391, lib/features/courses/presentation/_widgets/course_delete_menu_button.dart:83, lib/features/courses/presentation/_widgets/course_delete_menu_button.dart:93-97, lib/features/courses/presentation/_widgets/course_delete_menu_button.dart:101-107, lib/features/settings/presentation/app_settings_sections.dart:32-36, lib/features/runs/presentation/delete_all_records_setting_row.dart:30, lib/features/settings/presentation/_widgets/profile_photo_sheet.dart:95
SRC menu-course-keep lib/l10n/app_ko.arb:305
LOC_CONSENT_DIFF files=23 hits=540
OK location consent control none-found terms-keys=version,service,privacy,marketing,acceptedAt
SRC loc-consent firestore.rules:56
SRC course-mine lib/l10n/app_ko.arb:287, lib/features/courses/presentation/_widgets/course_status_marks.dart:95, lib/features/courses/presentation/course_detail_screen.dart:216
SRC guest-label lib/l10n/app_ko.arb:245
OK dev.json 18-19 same
OK site-clean 06-04-t2 1bc5e4a04315
```

- 회원탈퇴: `settingsWithdrawalLabel`이 「회원탈퇴」다. 경로 「설정 → 내 계정 → 회원탈퇴」는 그대로다.
- 「내 계정」 화면: 화면 제목이 `settingsAccountSection`이고, 목록의 첫 행이 프로필 사진(`ProfilePhotoTile`, 라벨 `authAccountPhotoUrl` 「프로필 사진」)이다. 그 아래로 표시 이름, 이메일, 가입일, 가입 수단, 연결된 계정 행이 있다. 이메일 값은 `user?.email ?? '-'`라 없으면 「-」로 보인다. 목록의 마지막 항목이 `DangerZoneSection`이고 그 안의 행이 `settingsWithdrawalLabel`을 쓴다. 구간 머리 글자는 `settingsDangerZoneSection` 「Danger zone」(`lib/l10n/app_ko.arb:347`)이다.
- 메뉴: 코스 상세 ⋮(tooltip 「더보기」)의 「코스 삭제」는 `canDeleteCourse`(내 코스)일 때만 보인다. 그 코스의 내 기록·뱃지 삭제 대상(`recordTargets`)이 있으면 그 코스 뱃지가 있을 때 「뱃지 삭제」, 없을 때 「기록 삭제」 한 항목이 보인다(남의 코스에서도). 설정의 「데이터 관리」 묶음은 `if (!isAnonymous)`로 게스트에게 숨기고, 그 묶음의 행이 「뱃지와 기록 모두 삭제」다. 「올린 사진 삭제」는 프로필 사진 시트의 항목이다. `courseDeleteConfirmBody`는 코스 삭제가 이미 받은 뱃지를 남긴다고 적는다(코스 삭제와 기록 삭제는 다른 일, D-37).
- 위치정보 동의 설정: (가) 규칙의 `t.keys().hasOnly(` 줄은 하나이고 키는 다섯 개 그대로다. (나) `3afb2085`부터 바뀐 약관·설정·온보딩·문구 파일은 23개다. 그 파일들과 ⑥ 경로의 더해진 줄 가운데 낱말(location, consent, 동의, 철회, 위치)에 걸린 줄은 540이다: ⑥ 서버 코드와 앱 문서 521, 규칙의 `location_use_records` 차단 블록 3, 온보딩 약관 동의 묶음 15, 한국어 문구 1(임시 개요 `termsDetailPlaceholder`). 온보딩에 더해진 필수 확인 행은 만 14세 확인(`signupAgeConfirmation`) 하나뿐이고(`lib/features/onboarding/presentation/app_terms_confirmations.dart:22-25`), 나머지 온보딩 줄은 「행 위치」 같은 낱말이 걸린 것이다. (다) `lib`·`android/app/src`·`ios/Runner`에서 위치정보 동의·철회 이름을 찾은 결과는 일치 없음(종료 코드 1)이다. 위치정보 동의를 끄거나 철회하는 화면 요소는 없다.
- 익명 쓰기: `3afb2085..AW`에서 규칙 파일의 변화는 `location_use_records` 차단 블록(13줄)뿐이고 `users/{userId}` 규칙은 그대로다(행 번호만 13 밀림). 새로 내보낸 함수는 `onRunWritten`과 `operatorDeleteUserData` 둘이고 둘 다 `users` 문서를 쓰지 않는다(지우거나 읽기만 한다). `lib`에 더해진 줄에는 Firestore 쓰기 호출이 없다. 익명 사용자에게 열린 새 `users` 쓰기는 찾지 못했다.
- 만든 사람 표시: `lib/features`·`lib/core`·`lib/shared`에 `creatorName`·`creatorNickname`·`publicProfiles` 같은 이름이 없다(일치 없음). 코스 화면은 `creatorId`를 내 코스인지 판정하는 데만 쓰고(`isMine`), 본인 코스에 「내 코스」(`courseMine`) 표시를 붙인다.
- `config/dev.json`: 두 키가 18·19행에 있고 값이 데이터 목록과 같다. 다른 줄은 읽지 않았고 값은 적지 않았다.

## 06-04 재기준

REBASE_SHA=aeb6f4461157

```
REBASE_CITES checked=56 fixed=27
check-site: 통과 (작업 트리, jekyll 3.10.0)
vals filled=0 emitted=0 excluded=0 leak=skip(no new values)
OK site-clean 06-04-t3 aeb6f4461157
```

- 커밋은 `.planning/baseline/DATA-INVENTORY.md`와 `.planning/baseline/DECISIONS.md` 둘만 담는다. 기준 앱 커밋 줄은 `92e986c3` (2026-11-26)이다.
- 인용 재확인: 데이터 목록 전체에서 `3afb2085..AW` 차이에 든 파일을 가리키는 서로 다른 `경로:행` 인용이 56개였다. 옛 커밋의 그 행 글자를 `AW`에서 그대로 찾아 27개는 행 번호가 같았고 22개는 옮겨 갔다. 글자가 달라졌거나 두 곳에 있어 손으로 다시 본 것이 일곱이고 그 가운데 다섯을 고쳤다(고친 것은 모두 27): `docs/guide.md`의 확장 함수 권한 명령(같은 ⑦ 절의 것), `lookup_sign_in_methods.ts`의 문서 ID 만드는 곳, `cleanup_user_data.ts`의 세 인용. 뒤의 셋은 삭제 코드가 옮겨 간 `user_data_cleanup.ts`(`deleteRunningPencilUserData`)로 옮기고 트리거 `cleanup_user_data.ts`는 호출 근거(60-64행)로만 두었다(D-44). `rate_limit.ts:4-6`과 `app_ko.arb:197`은 글자는 바뀌었지만 같은 행에 같은 사실이 있어 번호를 그대로 두었다.
- 근거 경로 목록에 열아홉 경로를 더했다(항목별 경로 가운데 목록에 없던 열둘과 화면 사실의 근거 일곱).
- 계획이 적지 않았지만 같은 사실에 맞춰 함께 고친 칸: 구간 C `region` 행의 삭제 방식 괄호(공개한 코스의 `region`만 남음), 구간 E 표 아래 Analytics 보존 문장, 구간 H 표 아래 Analytics 메모. 구간 E `fcmTokens` 행은 보유 기간 칸의 조회 날짜만 고쳤고, 같은 행 삭제 방식 칸과 구간 G `fcmTokens` 행의 2026-11-15 조회 표기는 그대로 두었다.
- 「확인할 것」 표와 「CLI 조회 기록」은 인용 행 번호 말고는 고치지 않았다(「확인할 것」의 추적 항목은 06-11이 더한다).
- 적지 않은 것: 익명 계정 문장을 삭제 안내에 쓸지(D-33 ①), prod 값이 없는 기간의 표기(D-33 ②), 개발자 이름(D-33 ④), 공개 코스의 기간·삭제 경로 약속(D-39). 앱 프로젝트 ID와 앱 문서의 명령 줄도 옮기지 않았다.
- 결정 목록: 한눈에 보기 U2 상태 「초안으로 진행」, U6-나 상태 「앱 반영됨」. 두 풀이 절에 같은 뜻의 줄을 하나씩 더했다. U2·U6-나 풀이의 「근거」 문단은 결정 전 사실이라 그대로 두었다.
- 구간 D 로그 행의 더한 문장은 계획의 글자와 조금 다르다: 「확인자료 기록」 뒤에 로그 이름과 필드(`location_use_record_written`, uid·동작)를 넣었고 「D-44」를 「Phase 6 D-44」로 적었다. verify가 찾는 「운영자 삭제 도구의 실행 기록」은 그대로이고, 06-05~06-13 계획에는 원래 글자를 찾는 곳이 없다.

### 익명 행 정정 (재기준 커밋 뒤)

ANON_ROW_FIX_SHA=d7dd8609bcb9

재기준 커밋(`REBASE_SHA`)의 구간 A 익명 행에 계획의 문장 「확인한 경로 안에서 앱이 익명 계정의 서버 문서를 쓰는 곳은 없어(앱 코드), Auth 레코드 밖에 남는 것은 Analytics·Crashlytics·Cloud Functions 로그에 붙은 uid이고 각 행의 기간을 따름」을 글자 그대로 적었는데, 계획 끝 점검에서 `AW`의 코드가 이 문장을 뒷받침하지 않는 것을 찾았다. 별도 문서 커밋으로 그 구절만 고쳤다. `REBASE_SHA`와 그 커밋은 그대로다(이력 수정 없음).

```
anon-callable lookupSignInMethods anonymous=accepted uid-doc=lookupSignInMethods:<uid> window-sec=60
anon-callable sendPasswordResetMail anonymous=accepted uid-doc=sendPasswordResetMail:<uid> window-sec=60
anon-callable sendTestPush anonymous=rejected
anon-callable sendVerificationMail anonymous=rejected
check-site: 통과 (작업 트리, jekyll 3.10.0)
OK site-clean 06-04-anonfix d7dd8609bcb9
```

- 근거(`AW`): `functions/src/auth/lookup_sign_in_methods.ts:62-63`(익명 사용자도 `request.auth` 조건을 만족), `:121-127`(uid 축 문서 ID). `functions/src/email/send_password_reset_mail.ts:29-31`(익명 허용, `isAnonymousCaller`로 거르지 않음), `:130-137`(uid 축 문서 ID). `functions/src/messaging/send_test_push.ts:312-316`과 `functions/src/email/send_verification_mail.ts:99-103`은 익명 호출을 호출 횟수 제한 기록을 만들기 전에 거절한다.
- 고친 문장: 익명 계정의 `users/{uid}` 문서를 쓰는 곳은 찾지 못했다. 서버 함수 둘은 익명 호출을 받고 그 uid가 든 `rate_limits` 기록을 만든다. 익명 사용자는 회원탈퇴에 갈 수 없어 이 기록은 만료 시각과 TTL 정책으로만 지워진다. 「Auth 레코드 밖에 남는 것은 …」처럼 남는 것을 모두 센 표현은 쓰지 않았다. verify와 06-06 precondition이 찾는 문구(「자동 정리가 Auth 삭제 트리거」, 「MVP 동안 자동 정리를 끈 채 둔다고 적음」 등)는 그대로다.
- `ANON_WRITE=none-found`는 정의대로(`3afb2085..AW` 차이에서 익명에게 열린 새 `users` 쓰기) 그대로 참이다. 다만 이 표식은 `users` 문서만 본 것이고 「익명 계정의 서버 문서가 없다」는 뜻이 아니다. uid 축 호출 횟수 제한 기록은 `3afb2085`에도 있던 것이다(`lookupSignInMethods`).
- 06-06 Task 2는 `REBASE_SHA`의 목록을 읽고, 그 계획의 action 글자가 사용자에게 「확인한 경로 안에서 앱이 익명 계정의 서버 문서를 쓰는 곳이 없음」과 「남는 uid는 Analytics·Crashlytics·로그 행의 기간을 따름」을 보이도록 적혀 있다. 06-06을 실행하기 전에 그 계획을 고쳐야 한다(이 계획은 06-06 계획 파일을 고치지 않았다).

## 06-05 절차서

운영자 삭제 요청 처리 절차를 `.planning/baseline/USER-TASKS.md`의 `## 작업 13 — 삭제 요청 처리 (운영자)`에 썼다. 도구 사실은 기준 앱 커밋 `AW`(`APP_HEAD`)의 앱 문서 `docs/operator-delete-tool.md`에서 `git -C "$APP" show`로 읽기만 했다(앱 저장소에 쓰지 않음, fetch 없음). 스크래치 재확인 네 항목(`$W/lib.sh` 함수 열둘, Playwright `1.59.1`, `$W/pw/p6-deletion.mjs`, `$W/base/TREE`와 `$W/base/site/index.html`)은 모두 있어 다시 만든 것이 없다(`REGEN` 줄 없음).

### Task 1 기본 경로 (tracer)

```
OK site-clean 06-05-t1 b60d1324544f
```

- 한눈에 보기 표에 작업 13 행을 더하고, 작업 12와 「변경 전후 dig 명령」 사이에 작업 13 절을 썼다. 절 구조는 작업 9와 같다(막는 단계, 순서, 레코드 표, 변경 전후 dig, 끝났는지 확인, Claude에게 넘길 것).
- 기본 경로 여덟 단계: 접수(영업일 기준 3일 안 첫 답장) → 요청 종류(범위 `account`·`records`) → 계정 이메일 확인 메일·답장 → uid 찾기 → dry-run → `--apply`와 uid 재입력, 종료 코드 0 확인 → 1시간 뒤 같은 명령으로 재확인 → 완료 답장. 상한은 「요청을 받은 날부터 10일 안」이고 기산점은 받은 날이다.
- 앱 문서와 맞춘 것: 종료 코드 0은 dry-run이 끝났을 때도 나오므로(앱 문서 「실행 방법」 종료 코드 표) 완료 판정은 `--apply` 실행의 종료 코드로, 1시간 뒤 재확인은 종료 코드가 아니라 「0이어야 하는 키」의 개수로 한다고 적었다. 종료 코드 1은 다시 실행, 그 밖의 코드는 앱 문서의 표를 따른다.
- 옮겨 적지 않은 것: 앱 문서의 명령 줄, 앱 프로젝트 ID, 지원 이메일 주소, uid. prod 전제는 데이터 목록 「### prod 전제 (Phase 6 D-42)」를 가리키는 한 줄만 두었다.
- tracer 관문: Task 1 verify를 두 번 돌려 두 번 모두 exit 0이었다(자동 확인만 있는 verify, `human_verify_mode` end-of-phase). Task 1은 커밋하지 않았다. 절차서는 Task 2에서 한 문서 커밋으로 남긴다(계획 objective).

### Task 2 보충 단계와 문서 커밋

OPS_FAILLOG=included
OPS_SHA=0cc0e1767353

- `OPS_FAILLOG=included`의 이유: 삭제 안내는 회원탈퇴 때 개인위치정보와 확인자료를 지체 없이 파기한다고 쓴다(DEL-06, D-41). 탈퇴 정리는 Auth 계정 삭제 뒤에 도는 트리거라 일부가 실패하면 `cleanup_user_data_failed` 로그만 남고 다시 돌지 않는다. 운영자 도구의 범위 `account`는 Auth가 이미 없는 uid도 남은 데이터를 직접 지우므로(앱 문서 「범위 두 가지」) 그 공백을 메울 수 있는 유일한 수단이다. 그래서 절차서 12번에 영업일마다 실패 로그를 보고 다시 지우는 일을 넣었다(D-43의 계획자 재량, 06-05-PLAN context).

```
check-site: 통과 (작업 트리, jekyll 3.10.0)
vals filled=0 emitted=0 excluded=0 leak=skip(no new values)
OK localpaths 0
OK site-clean 06-05-t2 0cc0e1767353
```

- 커밋은 `.planning/baseline/USER-TASKS.md` 하나만 담는다(78줄 더함, 지운 줄 없음). Task 1의 기본 경로와 Task 2의 보충 단계가 이 한 커밋에 함께 들어 있다.
- 더한 단계: 9번 대체 본인 확인(이메일 없는 계정과 Apple 「이메일 가리기」 주소 계정. 「내 계정」 값 대조와 운영자 추가 질문 두 단계가 모두 맞을 때만 지움), 10번 「뱃지와 기록 모두 삭제」 요청(범위 `records`, 「지체 없이」, 숫자 상한 없음), 11번 그 밖의 일부 삭제(앱 메뉴 안내), 12번 탈퇴 정리 실패 재처리, 13번 제공자 쪽 연결 답장 문장, 14번 Meta 사용자 데이터 삭제 요청 확인. 절 끝에 양식 셋(확인 메일, 계정 삭제 완료 답장, 「뱃지와 기록 모두 삭제」 완료 답장)을 칸 이름만으로 두었다.
- 메뉴 문구는 `HEAD`의 데이터 목록(재기준 `REBASE_SHA`와 익명 행 정정 `ANON_ROW_FIX_SHA` 뒤) 구간 C·A 삭제 방식 칸의 글자다: 「코스 삭제」, 「뱃지 삭제」, 「기록 삭제」, 「데이터 관리」, 「뱃지와 기록 모두 삭제」, 「올린 사진 삭제」. 「내 계정」 화면 항목 이름은 구간 A 표 아래 글머리의 글자다.
- 제공자 연결 답장 문장은 앱 문서 「서버가 하지 않는 것」의 문장과 같고(가운뎃점 둘레의 띄어쓰기만 사이트 표기), 고정 구절 「안내에 따라 직접 해제해 주세요」가 13번과 양식에 있다.
- 작업 13 절 안 점검(줄 수): 이메일 주소 꼴 0, `@` 글자 0, 옛 범위 이름 0, 옛 상한(30일) 0, 앱 문서의 명령 줄·앱 프로젝트 ID 0. 양식에는 실제 값이 없고 〈 〉 칸 이름만 있다.
- 계획 글자에 더한 것 (SUMMARY Deviations에 같은 내용):
  - 6번에 「권한 문제로 실패하면 다시 돌려도 낫지 않는다」와 「준비」 줄을 가리키는 문장(앱 문서 「서버 함수」의 권한 계열 안내). 가리키는 곳은 아래 「권한 실패 문장 정정」에서 고쳤다.
  - 9번에 「이 저장소는 공개이므로 질문 종류는 알려져 있다고 보고, 답을 본인만 알 수 있는 값으로 고른다」와 「계정이 하나로 좁혀지지 않으면 지우지 않고 더 묻는다」(T-06-13).
  - 12번에 「같은 실패가 탈퇴마다 이어지면 준비 줄이 가리키는 목록의 3번을 확인한다」(T-06-45).
  - 14번에 「식별자만 보고 지우지 않는다」(앱 범위 사용자 ID로 uid를 찾는 방법이 없음, RESEARCH A12).
- 절차서에 적지 않은 것 (열린 항목. SUMMARY 「열린 항목」에는 이 셋에 더해 익명 계정이 보낸 메일 요청과 추가 질문 「최근 기록 날짜」의 확인 방법이 있다):
  - 이메일 없는 계정의 uid를 콘솔에서 찾는 구체적인 방법. 계획·D-30·연구 C-4·앱 문서 어디에도 없어 「서버 기록과 대조」까지만 적었다.
  - 본인 확인 답장이 10일 안에 오지 않을 때의 처리. D-29는 기산점만 정했고 그 경우를 따로 약속하지 않는다. 절차서는 「답장을 받기 전에는 지우지 않는다」와 「기산점은 바꾸지 않는다」만 적는다. 결과 통지 서식과 함께 법률 확인 범위다(RESEARCH A2).
  - Meta 목록의 요청을 식별자만으로 처리하는 방법(RESEARCH A12, 「미확인」).

### 권한 실패 문장 정정 (절차서 커밋 뒤)

OPS_FIX_SHA=c331f758992f

절차서 커밋(`OPS_SHA`)의 6번 한 줄 「권한 문제로 실패하면 다시 돌려도 낫지 않습니다. 위 「준비」가 가리키는 목록을 확인합니다.」가 가리키는 곳이 앱 문서와 맞지 않아, 계획 끝 점검에서 그 줄만 고친 문서 커밋을 더했다. `OPS_SHA`와 그 커밋은 그대로다(이력 수정 없음).

```
check-site: 통과 (작업 트리, jekyll 3.10.0)
OK site-clean 06-05-fix c331f758992f
```

- 근거(`AW`의 `docs/operator-delete-tool.md` 「서버 함수」 절): 명령은 오류 지문이 권한 계열이면 「서버 함수 실행 계정의 권한을 확인하세요」를 내고, 권한 문제는 다시 실행해도 낫지 않는다고 적는다. 그 사례는 운영자 함수 실행 계정의 권한이다. 데이터 목록 prod 전제 목록의 3번은 탈퇴 정리 함수의 실행 계정, 5번은 운영자 로그인 계정·claim·디버그 토큰이라 원인이 그 목록에 없을 수 있다.
- 고친 문장: 「명령이 「서버 함수 실행 계정의 권한을 확인하세요」라고 안내하면 다시 돌려도 낫지 않습니다. 앱 문서 「서버 함수」 절의 권한 안내를 따릅니다.」
- 커밋은 `.planning/baseline/USER-TASKS.md` 하나, 한 줄 바꿈(1 더함, 1 지움)이다. 12번이 탈퇴 정리 실패를 prod 전제 3번으로 가리키는 문장은 그대로다(그쪽은 탈퇴 정리 함수의 권한이라 맞다). Task 1 verify는 정정 뒤에도 exit 0이고, Task 2 verify는 `OPS_SHA`의 내용을 읽으므로 그대로 exit 0이다.
- 뒤 계획(06-06~06-13)이 이 계획에서 읽는 것은 표식 `OPS_SHA`, 구간 머리 `## 06-05 절차서`, 작업 13의 사실(기한, 요청 이름, 제공자 연결 문장)이다. 계획 글자를 그대로 찾는 곳은 없다(계획 파일 여덟 개를 검색해 확인).

## 06-06 대조표

재기준한 데이터 목록(`ANON_ROW_FIX_SHA`의 `.planning/baseline/DATA-INVENTORY.md`)의 대상 행을 한 줄씩 「지워짐」·「남음」·「표 밖」·「결정 필요」로 나눴다(D-04, ROADMAP 성공 기준 2). 목록은 `git show`로 그 커밋의 내용만 읽었고 작업 트리의 목록은 읽지 않았다. 이 구간은 저장소 파일 가운데 이 기록만 고친다.

TABLE_SOURCE_ROWS=33
TABLE_ROWS=33

행 이름은 구간 글자와 그 구간 표에서의 행 순서다(예: G10은 구간 G 표의 열째 행). 「—」는 해당 없음이다.

| 목록 구간·행 | 분류 | 사이트 쪽 자리 | 남는 이유 | 기간 | 의존 |
|---|---|---|---|---|---|
| G1 Storage `users/{uid}/` 아래 객체 전부 | 지워짐 | 지워지는 데이터: 직접 올린 프로필 사진 | — | — | 지운 객체의 소프트 삭제 사본은 H17 행이 나른다 (Task 3 (a)) |
| G2 Firebase Auth 계정 | 지워짐 | 지워지는 데이터: 계정 정보 | — | — | 백업에서 제거되는 기간은 H9 행이 나른다 |
| G3 `identity_index` 중 `firebaseUid == uid` | 지워짐 | 지워지는 데이터: 계정 정보 | — | — | 없음 |
| G4 `users/{uid}` 문서 (`termsAccepted`, 연결된 제공자, 이메일 사본 등) | 지워짐 | 지워지는 데이터: 계정 정보 | — | — | 없음 |
| G5 `users/{uid}/fcmTokens/*` | 지워짐 | 지워지는 데이터: 알림 토큰 | — | — | 삭제가 실패한 경우의 TTL은 H4 행 (Task 3 (a)) |
| G6 `runs` 중 `userId == uid` | 지워짐 | 지워지는 데이터: 기록과 GPS 경로 | — | — | prod 전제 3번 |
| G7 `location_use_records` 중 `uid == uid` (위치정보 확인자료) | 지워짐 | 지워지는 데이터: 위치정보 확인자료 | — | — | 남는 데이터 표에 넣지 않는다 (D-41). 이용 중 보관 「6개월」은 위치정보 조항 문장 후보다 (구간 C 확인자료 행의 사이트 표기). prod 전제 3번·4번 |
| G8 `users/{uid}/badges/*` | 지워짐 | 지워지는 데이터: 뱃지 | — | — | prod 전제 3번 |
| G9 `courses` 중 `creatorId == uid`이고 공개하지 않은 코스 | 지워짐 | 지워지는 데이터: 공개하지 않은 코스 | — | — | D-39. prod 전제 3번 |
| G10 `courses` 중 `creatorId == uid`이고 공개한 코스 | 남음 | 남는 데이터 표: 공개 코스 | 다른 사용자가 계속 볼 수 있는 공개 코스. 만든 사람의 이름·사진을 표시하지 않음 | Task 3 (b)에서 정한다 | D-01. `COURSE_CREATOR=hidden`. 삭제 경로를 약속할지도 Task 3 (b) (D-39) |
| G11 `rate_limits` 중 uid가 들어간 문서 | 지워짐 | 지워지는 데이터: uid가 든 호출 횟수 제한 기록 | — | — | 삭제가 실패하면 만료 시각과 TTL 정책 (prod 전제 2번) |
| G12 `rate_limits` 중 IP·이메일 해시로 된 문서 | 남음 | 남는 데이터 표: 해시 호출 횟수 제한 기록 | 탈퇴로 찾을 수 없다 (문서 ID가 IP·이메일 해시). 쓰임은 요청 횟수 제한(남용 방지) | 7일 안 | D-40 (사용자 결정). prod 전제 2번 |
| G13 `mail` 중 그 사용자 주소가 든 문서 | 결정 필요 | Task 3 (a) | 탈퇴 단계에 없다. dev에서는 쓰지 않는다 | 정해지지 않음 | Task 3 (a). 목록의 「확장 TTL 설정 1일」은 설정 파일 값이고 dev에는 확장도 TTL 정책도 없다. prod 메일 발송 모드에 달렸다 |
| G14 Analytics·Crashlytics에 붙은 uid | 남음 | 남는 데이터 표: Analytics (이 행은 Analytics 몫을 나르고 Crashlytics 몫은 H11 행이 나른다) | 앱이 삭제 API를 부르지 않는다. 서비스의 보존 기간에 따른다 | 최대 14개월 | D-24. 설정값 미확인. 확인되지 않은 전제(RESEARCH A7): GA4 속성이 360이 아니고 BigQuery 내보내기를 켜지 않음. 06-11이 「확인할 것」으로 넘긴다 |
| G15 Cloud Functions 로그의 uid | 결정 필요 | Task 3 (a) | 앱이 지우지 않는다. 로그 보존 기간에 따른다. 탈퇴 정리 실패 로그와 운영자 삭제 도구의 실행 기록도 같은 보존 기간이다 | 정해지지 않음 | Task 3 (a). 목록 값 30일은 dev 값(dev CLI)이고 prod 값이 아니다. 보존 값 행은 H18 |
| G16 제공자 쪽 앱 연결 (여섯 제공자) | 표 밖 | 제공자 섹션과 요청 방법 조항 | — | — | D-32 |
| G17 운영자 삭제 도구 (메일 요청) | 표 밖 | 요청 방법 조항과 운영 절차서(작업 13) | — | — | 데이터가 아니라 처리 방법이다. 실행 기록은 G15 행에 든다 |
| C7 기기 안 원시 GPS 로그 `active_run.jsonl` | 표 밖 | 위치정보 조항 문장 후보: 앱에서 기록을 지우면 함께 지움 | — | — | 기기 안에만 있다. 비정상 종료 때 남는 기간은 목록에 「미확인」이다 |
| E4 App Check 기기 증명 토큰 | 결정 필요 | Task 3 (c) | 앱이 저장하지 않는다. uid와 묶이는지는 목록에 없다 | 정해지지 않음 | Task 3 (c). 공식 문서 값은 토큰 최대 7일, 재전송 방지 토큰 최대 30일이다 |
| E5 Remote Config 가져오기 (Firebase installation ID) | 결정 필요 | Task 3 (f) | 앱이 삭제 API를 부르지 않는다 | 남는 데이터 표에 넣지 않는다 (`INSTALL_ID=keep-out`) | Task 3 (f)는 표 밖 설명 문장을 넣을지만 정한다 |
| E6 기기 안 설정 (`SharedPreferences`) | 결정 필요 | Task 3 (e) | 탈퇴 때 서버에서 지우는 대상이 아니다 (기기 안) | — | Task 3 (e)는 그 문장을 넣을지 정한다. 「앱을 지우면 함께 지워진다」는 확인되지 않아 쓰지 않는다 |
| E7 Facebook SDK 자동 이벤트 | 표 밖 | 이 문서에 쓰지 않는다 (Phase 7) | — | — | 실제 전송 여부 미확인 (결정 목록 N1) |
| H4 Firestore TTL 정책 (`fcmTokens.expireAt`, `mail`, `rate_limits`, `location_use_records`) | 결정 필요 | Task 3 (a) | 보존 설정 행이다. `fcmTokens.expireAt`과 `mail`의 TTL 정책이 dev에 없다 | 정해지지 않음 | Task 3 (a): `fcmTokens` TTL(G5의 실패 경로)과 `mail`(G13). `rate_limits`·`location_use_records`의 TTL은 prod 전제 2번·4번으로 정해져 있다 |
| H9 Firebase Authentication 보존 | 남음 | 남는 데이터 표: Firebase Authentication 백업 | 삭제 요청 뒤 라이브·백업 시스템에서 제거될 때까지 남는다 (공식 문서) | 삭제 뒤 180일 안 | 같은 행의 「로그의 IP는 몇 주」를 표에 넣을지는 Task 3 (d) |
| H11 Crashlytics 보존 기간 | 남음 | 남는 데이터 표: Crashlytics (G14 행의 Crashlytics 몫) | 앱이 삭제 API를 부르지 않는다. 서비스의 보존 기간에 따른다 | 90일이 지나면 지우기 시작 | 공식 문서는 지우기 시작하는 시점만 준다 (RESEARCH Pitfall 2) |
| H12 FCM·Remote Config의 installation ID | 표 밖 | E5 행과 같은 데이터 | — | — | `INSTALL_ID=keep-out`. 설명 문장 여부는 E5 행 (Task 3 (f)) |
| H13 App Check 토큰 | 표 밖 | E4 행과 같은 데이터 (보존 값) | — | — | 표에 넣을지는 E4 행 (Task 3 (c)) |
| H14 Google Analytics 보존 기간 | 표 밖 | G14 행과 같은 데이터 (보존 값) | — | — | 기간 「최대 14개월」은 G14 행에 적었다 |
| H15 Firestore PITR | 결정 필요 | Task 3 (a) | 켜면 지운 문서가 복구 기간 동안 복구할 수 있는 상태로 남는다 (RESEARCH 「구간 H」) | 정해지지 않음 | Task 3 (a). dev는 꺼짐(dev CLI)이고 prod 값은 없다 |
| H16 Firestore 백업 일정 | 결정 필요 | Task 3 (a) | 두면 백업 보존 기간만큼 백업에 남는다 (RESEARCH 「구간 H」) | 정해지지 않음 | Task 3 (a). dev는 없음(dev CLI)이고 prod 값은 없다 |
| H17 Storage 소프트 삭제 기간 | 결정 필요 | Task 3 (a) | 지운 프로필 사진(G1)의 소프트 삭제 사본 | 정해지지 않음 | Task 3 (a). 목록 값 7일은 dev 값(dev CLI)이고 prod 값이 아니다 |
| H18 Cloud Logging 보존 기간 | 표 밖 | G15 행과 같은 데이터 (보존 값) | — | — | 기간은 G15 행과 함께 Task 3 (a)에서 정한다 |
| H19 익명 계정 자동 정리 | 결정 필요 | Task 2 | 익명(둘러보기) 계정: Auth 레코드, 익명 호출이 만든 uid `rate_limits` 기록, Analytics·Crashlytics·로그에 붙은 uid | 정해지지 않음 | Task 2 (D-33 ①, D-26). 켜면 「만든 지 30일이 지난 뒤 언제든」이라 상한이 없다 (공식 문서) |

- 목록 행 수 33의 셈: 구간 G 표 전체 17행, 구간 E 표 7행 가운데 G에 같은 데이터가 없는 4행(App Check, Remote Config, 기기 안 설정, Facebook SDK. `fcmTokens`·Analytics·Crashlytics 세 행은 G5·G14에 있다), 구간 H 표 19행 가운데 계획이 든 보존 기간 11행(리전·처리 위치 8행은 대상이 아니다), 구간 C의 기기 안 원시 GPS 로그 1행. 마지막 한 행은 계획 Task 1의 1번 셈(G·E·H)에는 없고 2번 「표 밖」 목록이 짚은 행이라 양쪽에 함께 셌다(G·E·H만 세면 32).
- 분류 수: 지워짐 10, 남음 5, 결정 필요 10, 표 밖 8.
- 한 행에 한 분류: 한 행에 두 사실이 있으면 주된 쪽으로 나누고 다른 쪽은 「의존」 칸에 적었다(H9의 로그 IP, H4의 정해진 TTL 둘).
- 같은 데이터가 두 행에 있을 때: 구간 G·E의 데이터 행과 구간 H의 보존 값 행이 같은 데이터를 적으면, 사이트 남는 데이터 표의 한 행이 될 쪽 하나만 「남음」이나 「결정 필요」로 두고 다른 쪽은 「표 밖」으로 두어 짝 행을 적었다(H12·H13·H14·H18). G14는 두 서비스가 한 행에 있어 Analytics 몫은 G14가, Crashlytics 몫은 H11이 나른다. 그래서 「남음」 5행이 사이트 표의 5행(공개 코스, 해시 호출 횟수 제한 기록, Analytics, Crashlytics, Firebase Authentication 백업)과 하나씩 맞는다. 06-13의 `RETAINED_ROWS`(「남음」 행 수)와 06-07의 표 본문 행 수가 같은 수를 쓰기 때문이다.
- 지워지는 데이터 범주 여덟: 계정 정보(G2·G3·G4), 직접 올린 프로필 사진(G1), 기록과 GPS 경로(G6), 뱃지(G8), 공개하지 않은 코스(G9), 알림 토큰(G5), uid가 든 호출 횟수 제한 기록(G11), 위치정보 확인자료(G7). 범주 이름은 계획의 이름이고 원고의 낱말은 06-07에서 정한다.
- 질문 묶음: Task 2는 H19. Task 3 (a)는 G13, G15(보존 값 H18), H4, H15, H16, H17. (b)는 G10의 기간과 삭제 경로 약속. (c)는 E4(보존 값 H13). (d)는 H9의 로그 IP. (e)는 E6. (f)는 E5(같은 데이터 H12).
- 06-13이 볼 것: (d)에서 로그의 IP를 표에 넣기로 하면 H9 한 행이 사이트 표의 두 행(백업, 로그의 IP)이 되어 「남음」 행 수와 사이트 표 행 수가 하나 어긋난다. 그 밖의 갈래에서는 두 수가 같다.
- 「결정 필요」 행의 기간 칸은 비워 두었다. 목록의 7일(Storage 소프트 삭제)과 30일(Cloud Logging)은 dev CLI 값이라 「의존」 칸에 dev 값이라고만 적었다. 연구의 상한 약속 제안 값은 이 표에 적지 않았다(Task 3 (a)가 제안이라고 밝혀 보인다).
- Crashlytics의 사이트 표기는 「90일이 지나면 지우기 시작」이다. 목록 구간 E·H의 Crashlytics 행은 지금 「90일 (공식 문서)」이고, 06-13이 이 표기를 목록에 옮긴다.
- 운영자 삭제 도구 행(G17)을 「표 밖」으로 둔 것은 계획의 가정이다(데이터가 아니라 처리 방법).
- 스크래치 재확인(06-01 `<scratch_contract>`): `$W/lib.sh` 함수 열둘, Playwright `1.59.1`, `$W/pw/p6-deletion.mjs`, `$W/base/TREE`와 `$W/base/site/index.html`이 모두 있다. 다시 만든 것이 없다(`REGEN` 줄 없음). 이 계획은 스크래치를 쓰지 않는다.
- 앱 HEAD 이동(파일 이름만 읽음, 사실의 근거로 쓰지 않음): 앱 로컬 `main` 끝은 `a298289b50fa`이고 `AW`(`92e986c3bb29`)가 그 조상이다. `AW` 뒤 커밋은 26개이고 06-04가 잰 삭제 관련 경로(항목별 경로, `functions`, `lib/features/runs`·`settings`·`courses`, `lib/l10n/app_ko.arb`, `firestore.rules`, `storage.rules`, `infra/operator`, 앱 문서 넷)는 0개다. 바뀐 파일 이름에는 앱의 `.planning/`·`.claude/` 문서 말고 `tools/course-editor/` 아래 12개와 `config/course-editor.dev.example.json`·`config/course-editor.prod.example.json`이 있다. 내용은 읽지 않았다. 이 기록의 앱 사실은 모두 `AW` 기준 그대로다(D-36).
- tracer 관문: Task 1 verify를 bash 임시 파일로 두 번 돌려 두 번 모두 exit 0이었다(자동 확인만 있는 verify, `human_verify_mode` end-of-phase). Task 1은 커밋하지 않았다. 이 계획의 커밋은 계획 끝 문서 커밋 하나다(계획 context).

```
OK table06 source G=17 E=4 H=11 C=1 total=33
OK table06 rows=33 distinct-ids=33 columns=6
OK table06 classes deleted=10 retained=5 undecided=10 out=8
OK app drift a298289b50fa commits=26 evidence-paths=0
OK site-clean 06-06-t1 3c5456a72d2a
```

## 06-06 결정

익명(둘러보기) 계정 문장(D-33 ①, Task 2)을 묻기 전에, 데이터 목록 `ANON_ROW_FIX_SHA`의 내용에 D-26 사실 셋, 앱 문서 사실 하나, 익명 호출이 만드는 `rate_limits` 기록의 사실 둘이 있는지 여섯 고정 문구로 확인했다(각 1줄).

```
OK anon facts in inventory d7dd8609bcb9
```

- 확인한 문구: 「prod에서는 켠다 (결정 목록 N3, Phase 6 D-26)」, 「만든 지 30일이 지난 익명 계정」, 「자동 정리가 Auth 삭제 트리거」, 「MVP 동안 자동 정리를 끈 채 둔다고 적음」, 「익명 호출을 받고, 불리면 그 uid가 든 호출 횟수 제한 기록」, 「이 기록은 만료 시각과 TTL 정책으로만 지워짐」.
- 질문과 함께 보인 것: 재기준 목록의 익명 사실과 출처(구간 A 익명 행, 구간 F `rate_limits` 행, 구간 H 「익명 계정 자동 정리」 행과 아래 메모, prod 전제 1번), 사이트 D-26(prod에서 켬)과 앱 문서 `docs/kit-fork.md` 「익명 자동 정리」 절(MVP 동안 끔)의 어긋남, 연구 선택지 (가)·(나)·(다)와 보류, (나)를 고르면 prod 전제 1번이 삭제 안내 문장의 전제가 된다는 것, 앱 화면 낱말 「게스트로 이용 중」(`SRC guest-label`)과 D-26·연구의 「둘러보기」가 다르다는 것. 실행자는 어느 쪽도 권하지 않았다.
- 앱 문서에서 직접 읽어 함께 보인 것(`AW`, 데이터 목록에는 없는 문장): `docs/kit-fork.md:509`는 자동 정리를 켜 두면 그 사용자의 뱃지(`users/{uid}/badges`)도 잃는다고 적는다. 같은 커밋의 `firestore.rules:441`은 뱃지 생성을 정식 사용자에게만 허용한다(`isRegular()`). 두 문장을 출처와 함께 그대로 보였고 어느 쪽이 맞는지 판정하지 않았다. 같은 절의 「다시 확인할 때」는 stg·prod 프로젝트를 만들 때 자동 정리가 꺼져 있는지 보고 켜져 있으면 끈다고 적는다.
- 열린 항목: 위 「다시 확인할 때」 문장(앱 문서가 prod에서도 끄라고 적음)은 데이터 목록에 없다. 목록에는 「MVP 동안 자동 정리를 끈 채 둔다고 적음」까지만 있다. 06-13은 새 사실을 더하지 않으므로, 이 문장을 목록에 넣을지는 정해지지 않았다.
### Task 2 답 (D-33 ①, 사용자 결정)

D33_C7=ga

- 사용자가 2026-11-26에 `ga`로 답했다(선택지 넷을 모두 본 뒤 사용자가 고름. 실행자는 어느 것도 권하지 않았다). 삭제 안내에는 익명 계정의 자동 삭제 문장을 넣지 않고, 선택지 (가)의 문장 「둘러보기에서는 기록·코스·뱃지를 서버에 저장하지 않는다」만 쓴다.
- `ga`이므로 (나) 문장 표식 줄은 적지 않았다(계획 Task 2 수용 기준: `na`일 때만 적는다).
- 이 답으로 닫히지 않은 것: 사이트 D-26(prod에서 켬)과 앱 문서(MVP 동안 끔)의 어긋남은 그대로 열려 있고, 데이터 목록 prod 전제 1번도 그대로다. 둘러보기 계정 자체(Auth 레코드)의 보유 기간은 삭제 안내에 없다(선택지 (가)의 단점으로 보인 것).
- (가) 문장은 기록·코스·뱃지에 대한 문장이다. 익명 호출이 만든 uid `rate_limits` 기록과 Analytics·Crashlytics·로그에 붙은 uid가 있으므로 「서버에 아무것도 저장하지 않는다」로 넓혀 쓰지 않는다.
- 낱말: 사용자의 답은 `ga` 하나였고 선택지 문장의 낱말(「둘러보기」)을 바꾸겠다는 답은 없었다.

### Task 3 질문 (D-33 ②, D-39)

- 묻기 전에 읽은 것: `support/index.html`의 `#report` 구간(19~28행)은 「다른 사람이 공개한 코스에 문제가 있으면 위 지원 이메일로 알려 주세요. 메일에 아래 내용을 적어 주세요.」와 적을 내용 네 가지(코스 이름, 코스 이름 위에 보이는 지역, 신고하는 이유, 코스 화면 캡처)뿐이다. 신고한 코스를 지우겠다는 문장도 처리 기한도 없다. FAQ의 신고 쌍(49~50행)은 「지원 이메일로 알려 주세요. 메일에 적을 내용은 공개 코스 신고에 있습니다.」이고 역시 삭제를 약속하지 않는다.
- 질문과 함께 보인 것: 여섯 물음 (a)~(f)의 사실과 선택지, (a)의 행별 연구 제안(상한 약속 방식. 제안이라고 밝힘)과 그 값이 dev CLI 값·공식 문서 기본값에서 온 것이라는 점, PITR·예약 백업을 켜는 쪽이 `#location`의 「지체 없이 파기」 문장과 남는 데이터 표에 닿는다는 연결, (b)의 사실(코드에 기한 없음, 탈퇴한 사람의 공개 코스는 지금 아무도 고치거나 지울 수 없음, 운영자 도구에 코스를 지우는 범위 없음)과 위 `#report` 읽기 결과, 연구 초안 문구 「서비스를 운영하는 동안」, 위 대조표 구간의 앱 HEAD 이동 메모(풀이 없이 그대로), (d)를 표에 넣는 쪽으로 정하면 「남음」 행 수와 사이트 표 행 수가 하나 어긋난다는 열린 항목, 답 꼴과 `promise`·`hold`의 결과. 실행자는 어느 것도 고르거나 권하지 않았다.
- Task 3의 여섯 물음은 답을 받았다. 표식과 답이 나온 과정은 아래 「Task 3 답」에 있다.

### Task 3 답 (D-33 ②, D-39, 사용자 결정)

D33_C8=proposal
PUBLIC_COURSE_PERIOD=서비스를 운영하는 동안
D39_PATH=none
APPCHECK_ROW=out
AUTHLOG_ROW=phase7
DEVICE_SENTENCE=out
INSTALL_SENTENCE=out

- 답: 사용자가 2026-11-27(한국 시각. UTC로는 2026-11-26)에 선택지 `answer`로 여섯 물음에 답했다. 답 문자열은 `a=proposal / b=서비스를 운영하는 동안 / c=out / d=phase7 / e=out / f=out`이다. `promise`도 `hold`도 아니다.
- 답이 나온 과정 (네 단계):
  1. 사용자가 Task 3 checkpoint 전체를 보았다. 여섯 물음의 사실, (a)의 행별 연구 제안, (b)의 `#report` 읽기 결과와 앱 HEAD 이동 메모, (d)를 `official`로 정할 때 「남음」 행 수가 어긋난다는 열린 항목, 답하는 세 가지 방법이다.
  2. 사용자가 오케스트레이터에 권고안을 물었다(「권고안은?」).
  3. 오케스트레이터가 연구 제안과 구별되는 자기 의견이라고 밝히고 위 답 문자열을 권했다. 물음마다 이유 한 줄과 답이 뒤집힐 조건을 댔고, (d)가 가장 팽팽하고 (e)·(f)는 판단에 달린 물음이라고 했다. prod에서 인증 메일·비밀번호 재설정 메일을 `mail` 대기열로 보낼지를 사용자에게 물었고, 보내지 않거나 정하지 않았으면 `proposal`이 그대로 선다고 했다(켜기 전에 행을 더함). Phase 7로 넘기는 기록이 확인된 것은 (d)뿐이라 (c)·(e)·(f)를 처리방침에서 다루려면 따로 추적해야 한다는 것도 말했다.
  4. 사용자가 「권고안대로」라고 답해 그 문자열을 자기 답으로 삼았다.
- 이 답을 읽는 법: 사용자가 권고를 묻지 않고 낸 답이 아니다. 오케스트레이터나 실행자가 고른 것도 아니다. 사용자가 권고를 듣고 받아들인 답이다. 실행자는 어느 물음도 고르거나 권하지 않았다(계획 prohibition). 이 구간을 적은 실행자는 답과 위 과정을 이어 하기 지시(오케스트레이터가 전한 글)로 받았고 사용자와 직접 주고받지 않았다. 구간 `## 06-03 결정`의 `INSTALL_ID`도 사용자가 권고를 물은 뒤 고른 답이다.
- `mail` 물음: 사용자는 3번의 `mail` 물음에 따로 답하지 않았다. 그래서 (a)는 고친 데 없는 `proposal`이다. prod에서 메일을 `mail` 대기열로 보낼지는 정해지지 않았다.
- (a) `proposal`: 연구의 상한 약속 방식 그대로다. 표의 값은 prod 사실이 아니라 prod가 넘지 않겠다고 약속하는 상한과 「켜지 않음」 전제다. 행별 문구는 이 기록에 옮겨 적지 않는다. 유일한 출처는 `06-06-PLAN.md` Task 3 `<context>`의 (a) 줄이고, 06-13이 거기서 읽어 데이터 목록 해당 행과 「### prod 전제 (Phase 6 D-42)」 아래에 적는다. dev 값(7일, 30일)을 prod 사실로 적지 않는다.
- (b) 공개 코스 행의 기간 문구는 「서비스를 운영하는 동안」이다(연구 초안 문구와 같은 글자이고, 사용자가 답으로 정했다). 탈퇴한 사람의 공개 코스를 요청으로 지우는 경로나 기간은 약속하지 않는다(`D39_PATH=none`, D-39 「지킬 수 있는 것만」). 위 `#report` 읽기 결과대로 지원 페이지도 삭제를 약속하지 않는다.
- (c) `out`: App Check 토큰 행을 남는 데이터 표에 넣지 않는다. (d) `phase7`: Firebase Authentication 로그의 IP를 표에 넣지 않고 Phase 7 처리방침으로 넘긴다. (e) `out`: 기기 안 설정 문장을 넣지 않는다. (f) `out`: installation ID 설명 문장을 넣지 않는다(`INSTALL_ID=keep-out`은 그대로다).
- 대조표의 「결정 필요」 10행은 이 계획에서 풀지 않았다. 06-13이 위 표식과 `D33_C7`대로 분류만 바꾼다(행을 빼거나 더하지 않음).
- 닫힌 열린 항목: (d)가 `phase7`이므로 대조표 구간 「06-13이 볼 것」의 어긋남(로그의 IP를 표에 넣으면 「남음」 행 수와 사이트 표 행 수가 하나 다름)은 생기지 않는다. H9는 사이트 표의 한 행(백업)이다.
- 이 답으로 닫히지 않은 것:
  - (a)의 전제는 prod에서 지켜야 참이다. prod에서 Firestore PITR, 예약 백업, `mail` 대기열 발송을 켜려면 먼저 남는 데이터 표에 행을 더해야 한다. PITR이나 예약 백업을 켜면 삭제 안내 `#location`의 「지체 없이 파기」 문장(DEL-06)도 그 결정과 함께 다시 정해야 한다(계획 Task 3 context).
  - (c)·(e)·(f)를 Phase 7 처리방침에서 다룰지는 사용자가 정하지 않았다. 06-13 계획이 데이터 목록에 「Phase 7 처리방침에서 다룸」을 적는 것은 (d) `phase7` 하나다(`06-13-PLAN.md` Task 2 action 1번). (c) `out`은 「표에서 뺌」만 적히고, (e)·(f) `out`은 목록에 표시가 붙지 않는다(같은 action 1·2번).
  - Task 2에서 남은 것(D-26과 앱 문서의 어긋남, prod 전제 1번)은 그대로다.

이 계획 동안(`3c5456a72d2a` 뒤) 커밋은 아직 없고, 작업 트리의 사이트 파일은 HEAD와 같다. 스테이징한 것도 없다.

```
OK task3 markers 7/7 line-start once
OK site-clean 06-06-t3 3c5456a72d2a
```

## 06-13 대조표 확정

06-06 대조표의 「결정 필요」 10행을 06-06의 사용자 답 표식(`D33_C7`, `D33_C8`, `PUBLIC_COURSE_PERIOD`, `D39_PATH`, `APPCHECK_ROW`, `AUTHLOG_ROW`, `DEVICE_SENTENCE`, `INSTALL_SENTENCE`)대로 「남음」이나 「표 밖」으로 바꿨다. 행을 빼거나 더하지 않았다. 이 계획은 새로 정한 것이 없다. 값은 모두 06-04·06-06 표식, 재기준 데이터 목록, `06-06-PLAN.md` Task 3 `<context>`의 (a) 줄(`D33_C8=proposal`의 행별 문구의 유일한 출처)에서 가져왔다.

RETAINED_ROWS=7
DELETED_ITEMS=8

행 이름과 열은 06-06 대조표와 같다. 「—」는 해당 없음이다.

| 목록 구간·행 | 분류 | 사이트 쪽 자리 | 남는 이유 | 기간 | 의존 |
|---|---|---|---|---|---|
| G1 Storage `users/{uid}/` 아래 객체 전부 | 지워짐 | 지워지는 데이터: 직접 올린 프로필 사진 | — | — | 지운 객체의 소프트 삭제 사본은 H17 행이 나른다 (남음) |
| G2 Firebase Auth 계정 | 지워짐 | 지워지는 데이터: 계정 정보 | — | — | 백업에서 제거되는 기간은 H9 행이 나른다 |
| G3 `identity_index` 중 `firebaseUid == uid` | 지워짐 | 지워지는 데이터: 계정 정보 | — | — | 없음 |
| G4 `users/{uid}` 문서 (`termsAccepted`, 연결된 제공자, 이메일 사본 등) | 지워짐 | 지워지는 데이터: 계정 정보 | — | — | 없음 |
| G5 `users/{uid}/fcmTokens/*` | 지워짐 | 지워지는 데이터: 알림 토큰 | — | — | `D33_C8=proposal`: 「지워짐」으로 쓴다. 삭제가 실패한 경우는 `fcmTokens.expireAt` TTL에 맡기고 prod에서 그 TTL 정책을 켠다 (D-33 ② 추가 전제. 보존 설정 행은 H4) |
| G6 `runs` 중 `userId == uid` | 지워짐 | 지워지는 데이터: 기록과 GPS 경로 | — | — | prod 전제 3번 |
| G7 `location_use_records` 중 `uid == uid` (위치정보 확인자료) | 지워짐 | 지워지는 데이터: 위치정보 확인자료 | — | — | 남는 데이터 표에 넣지 않는다 (D-41). 이용 중 보관 「6개월」은 위치정보 조항이 쓴다 (아래 `INUSE` 줄). prod 전제 3번·4번 |
| G8 `users/{uid}/badges/*` | 지워짐 | 지워지는 데이터: 뱃지 | — | — | prod 전제 3번 |
| G9 `courses` 중 `creatorId == uid`이고 공개하지 않은 코스 | 지워짐 | 지워지는 데이터: 공개하지 않은 코스 | — | — | D-39. prod 전제 3번 |
| G10 `courses` 중 `creatorId == uid`이고 공개한 코스 | 남음 | 남는 데이터 표: 공개 코스 | 다른 사용자가 계속 볼 수 있는 공개 코스. 만든 사람의 이름·사진을 표시하지 않음 | 서비스를 운영하는 동안 | D-01, D-39 (`PUBLIC_COURSE_PERIOD`). `COURSE_CREATOR=hidden`. 탈퇴한 사람의 공개 코스를 요청으로 지우는 경로·기간은 약속하지 않는다 (`D39_PATH=none`) |
| G11 `rate_limits` 중 uid가 들어간 문서 | 지워짐 | 지워지는 데이터: uid가 든 호출 횟수 제한 기록 | — | — | 삭제가 실패하면 만료 시각과 TTL 정책 (prod 전제 2번) |
| G12 `rate_limits` 중 IP·이메일 해시로 된 문서 | 남음 | 남는 데이터 표: 해시 호출 횟수 제한 기록 | 탈퇴로 찾을 수 없다 (문서 ID가 IP·이메일 해시). 쓰임은 요청 횟수 제한(남용 방지) | 7일 안 | D-40 (사용자 결정). prod 전제 2번 |
| G13 `mail` 중 그 사용자 주소가 든 문서 | 표 밖 | 이 문서에 쓰지 않는다 (남는 데이터 표에서 뺌) | — | — | `D33_C8=proposal`: prod에서 `mail` 대기열 발송을 켜지 않음을 전제로 표에서 뺀다. 켜려면 표에 행을 먼저 더한다 (D-33 ② 추가 전제). prod에서 메일을 `mail` 대기열로 보낼지는 정해지지 않았다 (06-06 결정) |
| G14 Analytics·Crashlytics에 붙은 uid | 남음 | 남는 데이터 표: Analytics (이 행은 Analytics 몫을 나르고 Crashlytics 몫은 H11 행이 나른다) | 앱이 삭제 API를 부르지 않는다. 서비스의 보존 기간에 따른다 | 최대 14개월 | D-24. 설정값 미확인. 확인되지 않은 전제(RESEARCH A7): GA4 속성이 360이 아니고 BigQuery 내보내기를 켜지 않음. 06-11이 「확인할 것」으로 넘긴다 |
| G15 Cloud Functions 로그의 uid | 남음 | 남는 데이터 표: Cloud Functions 로그 | 앱이 지우지 않는다. 로그 보존 기간에 따른다. 탈퇴 정리 실패 로그와 운영자 삭제 도구의 실행 기록도 같은 보존 기간이다 | 최대 30일 | `D33_C8=proposal`의 상한 약속. prod 기본 로그 버킷 보존을 30일 이하로 둔다 (D-33 ② 추가 전제). 목록 값 30일은 dev 값이고 prod 사실이 아니다. 보존 값 행은 H18 |
| G16 제공자 쪽 앱 연결 (여섯 제공자) | 표 밖 | 제공자 섹션과 요청 방법 조항 | — | — | D-32 |
| G17 운영자 삭제 도구 (메일 요청) | 표 밖 | 요청 방법 조항과 운영 절차서(작업 13) | — | — | 데이터가 아니라 처리 방법이다. 실행 기록은 G15 행에 든다 |
| C7 기기 안 원시 GPS 로그 `active_run.jsonl` | 표 밖 | 위치정보 조항 문장 후보: 앱에서 기록을 지우면 함께 지움 | — | — | 기기 안에만 있다. 비정상 종료 때 남는 기간은 목록에 「미확인」이다 |
| E4 App Check 기기 증명 토큰 | 표 밖 | 이 문서에 쓰지 않는다 (남는 데이터 표에서 뺌) | — | — | `APPCHECK_ROW=out` (앱이 저장하지 않는다). Phase 7 처리방침에서 다룰지는 정해지지 않았다 (06-06 결정) |
| E5 Remote Config 가져오기 (Firebase installation ID) | 표 밖 | 이 문서에 쓰지 않는다 | — | — | `INSTALL_ID=keep-out`. 표 밖 설명 문장도 넣지 않는다 (`INSTALL_SENTENCE=out`) |
| E6 기기 안 설정 (`SharedPreferences`) | 표 밖 | 이 문서에 쓰지 않는다 | — | — | `DEVICE_SENTENCE=out` |
| E7 Facebook SDK 자동 이벤트 | 표 밖 | 이 문서에 쓰지 않는다 (Phase 7) | — | — | 실제 전송 여부 미확인 (결정 목록 N1) |
| H4 Firestore TTL 정책 (`fcmTokens.expireAt`, `mail`, `rate_limits`, `location_use_records`) | 표 밖 | G5·G13 행과 같은 데이터 (보존 설정) | — | — | `D33_C8=proposal`: `fcmTokens.expireAt` TTL은 prod에서 켠다 (G5). `mail`은 G13 행. `rate_limits`·`location_use_records`의 TTL은 prod 전제 2번·4번으로 정해져 있다 |
| H9 Firebase Authentication 보존 | 남음 | 남는 데이터 표: Firebase Authentication 백업 | 삭제 요청 뒤 라이브·백업 시스템에서 제거될 때까지 남는다 (공식 문서) | 삭제 뒤 180일 안 | 같은 행의 「로그의 IP는 몇 주」는 표에 넣지 않고 Phase 7 처리방침으로 넘긴다 (`AUTHLOG_ROW=phase7`) |
| H11 Crashlytics 보존 기간 | 남음 | 남는 데이터 표: Crashlytics (G14 행의 Crashlytics 몫) | 앱이 삭제 API를 부르지 않는다. 서비스의 보존 기간에 따른다 | 90일이 지나면 지우기 시작 | 공식 문서는 지우기 시작하는 시점만 준다 (RESEARCH Pitfall 2) |
| H12 FCM·Remote Config의 installation ID | 표 밖 | E5 행과 같은 데이터 | — | — | `INSTALL_ID=keep-out`, `INSTALL_SENTENCE=out` |
| H13 App Check 토큰 | 표 밖 | E4 행과 같은 데이터 (보존 값) | — | — | `APPCHECK_ROW=out` |
| H14 Google Analytics 보존 기간 | 표 밖 | G14 행과 같은 데이터 (보존 값) | — | — | 기간 「최대 14개월」은 G14 행에 적었다 |
| H15 Firestore PITR | 표 밖 | 이 문서에 쓰지 않는다 (남는 데이터 표에서 뺌) | — | — | `D33_C8=proposal`: prod에서 켜지 않음을 전제로 표에서 뺀다. 켜려면 표에 행을 먼저 더하고 `#location`의 「지체 없이 파기」 문장도 함께 다시 정한다 (D-33 ② 추가 전제, 06-06 결정) |
| H16 Firestore 백업 일정 | 표 밖 | 이 문서에 쓰지 않는다 (남는 데이터 표에서 뺌) | — | — | `D33_C8=proposal`: prod에서 예약 백업을 두지 않음을 전제로 표에서 뺀다. 두려면 표에 행을 먼저 더하고 `#location`의 「지체 없이 파기」 문장도 함께 다시 정한다 (D-33 ② 추가 전제, 06-06 결정) |
| H17 Storage 소프트 삭제 기간 | 남음 | 남는 데이터 표: 지운 프로필 사진의 소프트 삭제 사본 | 지운 프로필 사진(G1)의 소프트 삭제 사본 | 삭제 뒤 최대 7일 | `D33_C8=proposal`의 상한 약속. prod 버킷 소프트 삭제를 기본 7일로 둔다 (D-33 ② 추가 전제). 목록 값 7일은 dev 값이고 prod 사실이 아니다 |
| H18 Cloud Logging 보존 기간 | 표 밖 | G15 행과 같은 데이터 (보존 값) | — | — | 기간 「최대 30일」은 G15 행에 적었다 |
| H19 익명 계정 자동 정리 | 표 밖 | 표 밖 문장: 「둘러보기에서는 기록·코스·뱃지를 서버에 저장하지 않는다」 | — | — | `D33_C7=ga`. 자동 삭제 문장은 넣지 않는다. 「서버에 아무것도 저장하지 않는다」로 넓혀 쓰지 않는다 (06-06 결정). 문장의 근거는 목록 구간 A 익명 행과 구간 E `fcmTokens` 행 |

- 분류 수: 지워짐 10, 남음 7, 표 밖 16. 「결정 필요」는 0이다.
- 바뀐 10행: G15와 H17은 「남음」(상한 약속), G13·H4·H15·H16은 「표 밖」(`D33_C8=proposal`의 「켜지 않음」 전제와 `fcmTokens`를 「지워짐」으로 쓰는 제안), E4는 「표 밖」(`APPCHECK_ROW=out`), E5는 「표 밖」(`INSTALL_SENTENCE=out`), E6은 「표 밖」(`DEVICE_SENTENCE=out`), H19는 「표 밖」(`D33_C7=ga`, 표 밖 문장).
- 06-06에서 이미 나뉘어 있던 23행은 분류가 그대로다. 「Task 3에서 정한다」고 적었던 칸(G1·G5의 의존, G10의 기간과 의존, H9·H12·H13·H18의 의존)만 답으로 바꿔 적었다.
- 「남음」 7행은 사이트 남는 데이터 표의 7행과 하나씩 맞는다: 공개 코스(G10), 해시 호출 횟수 제한 기록(G12), Analytics(G14), Cloud Functions 로그(G15), Firebase Authentication 백업(H9), Crashlytics(H11), 지운 프로필 사진의 소프트 삭제 사본(H17). `AUTHLOG_ROW=phase7`이라 H9는 표의 한 행이다(06-06 「06-13이 볼 것」의 어긋남은 없다). 표 행의 이름은 원고(06-07)가 정한다.
- 지워지는 데이터 범주 여덟 (`DELETED_ITEMS`. 06-06과 같다): 계정 정보(G2·G3·G4), 직접 올린 프로필 사진(G1), 기록과 GPS 경로(G6), 뱃지(G8), 공개하지 않은 코스(G9), 알림 토큰(G5), uid가 든 호출 횟수 제한 기록(G11), 위치정보 확인자료(G7). 범주 이름은 계획의 이름이고 원고의 낱말은 06-07에서 정한다.
- 새 「남음」 두 행(G15, H17)의 남는 이유는 06-06 대조표의 글자 그대로다.
- 공개하지 않은 코스(G9)와 확인자료(G7)는 「지워짐」이다 (D-39, D-41).

### 고정 줄

원고(06-07)가 남는 데이터 표와 위치정보 조항에 그대로 쓸 글자다. 꼴은 `PERIOD <행 낱말>|<기간 문구>`, `REASON <행 낱말>|<이유 문구>`, `INUSE <행 낱말>|<문구>`이고, 행 낱말은 그 문구가 적힌 데이터 목록 표 행의 첫 칸에 있는 글자다. `PERIOD`는 「남음」 행마다 하나다.

```
PERIOD `courses` 중 `creatorId == uid`이고 공개한 코스|서비스를 운영하는 동안
PERIOD IP·이메일 해시로 된 문서|7일 안
PERIOD Analytics·Crashlytics에 붙은 uid|최대 14개월
PERIOD Crashlytics 보존 기간|90일이 지나면 지우기 시작
PERIOD Firebase Authentication 보존|삭제 뒤 180일 안
PERIOD Storage 소프트 삭제 기간|삭제 뒤 최대 7일
PERIOD Cloud Functions 로그의 uid|최대 30일
REASON courses/{courseId}|만든 사람의 이름·사진을 표시하지 않음
INUSE location_use_records/{runId}|6개월
```

- 대조표 행과의 대응: 공개 코스 G10, 해시 문서 G12, Analytics G14, Crashlytics H11, Firebase Authentication 백업 H9, 소프트 삭제 사본 H17, 로그 G15. `REASON` 줄의 행은 구간 C 코스 행이고 `INUSE` 줄의 행은 구간 C 확인자료 행이다.
- 문구의 출처: 「서비스를 운영하는 동안」은 `PUBLIC_COURSE_PERIOD`, 「7일 안」은 D-40, 「최대 14개월」은 D-24, 「90일이 지나면 지우기 시작」과 「삭제 뒤 180일 안」은 공식 문서 표현(06-06 대조표 H11·H9), 「삭제 뒤 최대 7일」과 「최대 30일」은 `D33_C8=proposal`의 상한 약속 문구, 「만든 사람의 이름·사진을 표시하지 않음」은 06-04가 목록에 적은 글자(`COURSE_CREATOR=hidden`), 「6개월」은 D-41이다.
- `D33_C7=ga`이므로 「익명 계정 자동 정리」의 `PERIOD` 줄은 없다(`na`일 때만 적는다).
- `APPCHECK_ROW=out`, `AUTHLOG_ROW=phase7`이므로 그 두 행의 `PERIOD` 줄도 없다.

### 목록 반영과 같은 줄 대조 (작업 트리)

데이터 목록 작업 트리에 아래를 덧붙였다. 원래 글자는 지우거나 바꾸지 않았고(글자 단위 차이에서 지워진 덩어리 0), dev 값 문장은 그대로다. 「행 끝」은 근거(인용) 칸이 아니라 그 행의 서술 칸 끝이다. 이 task에서는 커밋하지 않았다(목록은 Task 2에서 한 문서 커밋으로 남긴다).

- 공개 코스: 구간 G 「공개한 코스」 행 처리 칸 끝과 구간 C 코스 행 보유 기간 칸 끝에 「남는 기간: 서비스를 운영하는 동안 (Phase 6 D-01·D-39, 사용자 결정)」. 앞에 「삭제 안내에 적는」(구간 C는 「삭제 안내에 적는 공개한 코스의」)을 붙여 dev 사실 문장 「기한 없음」과 구별했다.
- Crashlytics: 구간 E `Firebase Crashlytics` 행 보유 기간 칸과 구간 H 「Crashlytics 보존 기간」 행 값 칸 끝에 「90일이 지나면 지우기 시작 (완료 시점은 공식 문서에 없음, Phase 6 D-33 ② 표기)」. 원래의 「90일」은 그대로다.
- 상한 약속(「삭제 안내 상한: <문구>. prod 설정이 이 값 이하여야 함 (Phase 6 D-33 ②, 사용자 결정)」): 「삭제 뒤 최대 7일」은 구간 H 「Storage 소프트 삭제 기간」 행과 구간 G Storage 객체 행, 「최대 30일」은 구간 H 「Cloud Logging 보존 기간」 행, 구간 G 로그 행, 구간 D 로그 행.
- 「켜지 않음」 전제(「prod에서 켜지 않음을 전제로 삭제 안내 표에서 뺌. 켜려면 삭제 안내 표에 행을 먼저 더함 (Phase 6 D-33 ②, 사용자 결정)」): 구간 H 「Firestore PITR」·「Firestore 백업 일정」 행, 구간 G `mail` 행, 구간 F `mail` 행, 구간 H 「Firestore TTL 정책」 행의 `mail` 몫. `mail` 쪽 세 곳은 문장 앞에 「`mail` 대기열 발송은」을 붙였다.
- `fcmTokens`: 계획에 고정 문장이 없는 갈래라 proposal의 글자(「`fcmTokens`는 「지워짐」으로 쓰고 prod에서 `expireAt` TTL을 켬」)대로 「삭제 안내에는 「지워짐」으로 씀. prod에서 `fcmTokens.expireAt` TTL 정책을 켬을 전제로 함 (Phase 6 D-33 ②, 사용자 결정)」을 구간 G `fcmTokens` 행, 구간 E `fcmTokens` 행, 구간 H 「Firestore TTL 정책」 행에 적었다.
- 06-04 재기준에 이미 있던 문구(「최대 14개월」, 「7일 안」, 「삭제 뒤 180일 안」, 「6개월」, 「만든 사람의 이름·사진을 표시하지 않음」)는 고친 데 없이 같은 줄 대조가 맞았다.
- 둘러보기 문장: `D33_C7=ga`라 구간 H 「익명 계정 자동 정리」 행에 삭제 안내 문장을 적지 않았다(`na`일 때만 적는다).

```
OK table rows = 33
OK table13 ids same-as-06-06 33/33
OK table13 classes deleted=10 retained=7 out=16 undecided=0
OK period `courses` 중 `creatorId == uid`이고 공개한 코스 in-inventory
OK period IP·이메일 해시로 된 문서 in-inventory
OK period Analytics·Crashlytics에 붙은 uid in-inventory
OK period Crashlytics 보존 기간 in-inventory
OK period Firebase Authentication 보존 in-inventory
OK period Storage 소프트 삭제 기간 in-inventory
OK period Cloud Functions 로그의 uid in-inventory
OK period courses/{courseId} in-inventory
OK period location_use_records/{runId} in-inventory
PERIOD_OK=9/9
OK site-clean 06-13-t1 5f4f8af3aed0
```

- tracer 관문: Task 1 verify를 bash 임시 파일로 두 번 돌려 두 번 모두 exit 0이었다(자동 확인만 있는 verify, `human_verify_mode` end-of-phase). Task 1은 커밋하지 않았다.

## 06-13 목록 반영

Task 1의 덧붙임에 표 범위 표시, 표 밖 문장의 근거 표시, 처리 기한 메모, prod 전제 덧붙임, 반영 메모를 더해 데이터 목록 하나만 담은 문서 커밋으로 남겼다. 푸시하지 않았다.

INV_DEC_SHA=a789cf9679ba

```
check-site: 통과 (작업 트리, jekyll 3.10.0)
vals filled=0 emitted=0 excluded=0 leak=skip(no new values)
OK inventory append-only removed-chunks=0 table-columns=same
OK commit files = .planning/baseline/DATA-INVENTORY.md
OK commit periods 9/9 a789cf9679ba
OK site-clean 06-13-t2 a789cf9679ba
```

- 커밋은 `.planning/baseline/DATA-INVENTORY.md` 하나만 담는다(줄 단위로 33줄 더함·20줄 지움: 표 행 20줄에 글을 덧붙였고 새 줄이 13줄이다. 글자 단위 차이에서 지워진 덩어리는 0이고 표 행의 칸 수도 그대로다). 재기준 커밋(`REBASE_SHA`)부터 이 커밋까지 사이트 파일을 고친 커밋은 없다.
- 기준 앱 커밋 줄, 재확인 규칙의 해시, 06-04가 적은 앱 동작 문장, prod 전제 번호 목록 다섯 줄은 그대로다.
- 표 범위 표시 (D-33 ②): 구간 E App Check 행 삭제 방식 칸 끝과 구간 H 「App Check 토큰」 행 값 칸 끝에 「앱이 저장하지 않아 삭제 안내 남는 데이터 표에서 뺌 (Phase 6 D-33 ②, 사용자 결정)」(`APPCHECK_ROW=out`). 구간 H 「Firebase Authentication 보존」 행 값 칸 끝에 「로그의 IP 행은 삭제 안내 표에서 빼고 Phase 7 처리방침에서 다룸 (Phase 6 D-33 ②, 사용자 결정)」(`AUTHLOG_ROW=phase7`).
- 표 밖 문장의 근거: `D33_C7=ga`라 구간 A 익명 행의 「코스·기록·뱃지 쓰기는 막힘」과 구간 E `fcmTokens` 행의 「익명 사용자는 쓸 수 없음」이 그대로 있는지 확인하고(각 1줄), 익명 행 삭제 방식 칸 끝에 두 구절을 짚은 뒤 「(삭제 안내 둘러보기 문장의 근거, Phase 6 D-33 ①)」을 더했다. `DEVICE_SENTENCE=out`, `INSTALL_SENTENCE=out`이라 구간 E 기기 안 설정 행과 Remote Config 행에는 표시를 더하지 않았다.
- 처리 기한: 구간 G 표 아래 메모의 「탈퇴는 호출 즉시 실행됩니다 …」 글머리 다음에 한 글머리를 더했다. 계정 삭제 요청은 「요청을 받은 날부터 10일 안」(D-29), 「뱃지와 기록 모두 삭제」 요청은 본인 확인 뒤 「지체 없이」(D-12·D-38)이고 `OPS_SHA` 절차서(작업 13)와 같은 기한이다.
- prod 전제 덧붙임: 「### prod 전제 (Phase 6 D-42)」 번호 목록 다섯 줄 아래에 문단 「D-33 ② 결정에 따른 추가 전제 (Phase 6 D-33 ②):」와 글머리 다섯을 더했다. Storage 기본 버킷 소프트 삭제를 기본값 7일로 둠, 기본 로그 버킷 보존 30일 이하, `fcmTokens`의 `expireAt` TTL 정책 켜기, Firestore PITR을 켜지 않고 예약 백업을 두지 않음, 인증 메일·비밀번호 재설정 메일을 `mail` 대기열로 보내지 않음. 모두 `D33_C8=proposal`의 글자(`06-06-PLAN.md` Task 3 `<context>`의 (a) 줄)에서 왔다. 덧붙일 것이 있으므로 덧붙임 없음 표식은 적지 않았다.
- 그 글머리에 함께 적은 06-06 기록의 문장 둘: PITR이나 예약 백업을 켜려면 `#location`의 「지체 없이 파기」 문장도 함께 다시 정한다, prod에서 메일을 `mail` 대기열로 보낼지는 정해지지 않았다(둘 다 `## 06-06 결정`의 「이 답으로 닫히지 않은 것」).
- 반영 메모: 「재확인 규칙」 절의 06-04 재기준 메모 아래에 「남는 데이터 결정 반영 (Phase 6 06-13, D-33): …」 한 줄을 더했다.
- 커밋 내용으로 다시 한 대조: `PERIOD`·`REASON`·`INUSE` 아홉 줄 모두 `INV_DEC_SHA`의 목록에서 행 낱말과 문구가 같은 줄에 있다.
- 값 누출 점검: 개발자 이름 키에 값이 없어 건너뛰었다(06-01 「값 누출 점검」의 기대값). 목록에 더한 줄에 주소 꼴 글자(`@`)는 0이다. 커밋 메시지에는 결정 번호와 문서 이름만 있다.
- 적지 않은 것 (이 계획은 새 결정을 만들지 않는다): App Check 토큰·기기 안 설정·installation ID를 Phase 7 처리방침에서 다룰지, 사이트 D-26과 앱 문서의 익명 자동 정리 어긋남, 앱 문서의 「stg·prod를 만들 때 자동 정리가 꺼져 있는지 보고 켜져 있으면 끈다」 문장. 셋 다 06-06이 열어 둔 그대로다. 연구의 PITR 보존 일수처럼 결정에 없는 값도 적지 않았다.

## 06-07 원고

`/data-deletion/` 원고를 스크래치 `$W/draft/data-deletion.html`에 쓰고, HEAD에 얹은 ref 없는 시험 객체로 check-site, 빌드, 본문 블록 판정, 두 엔진 화면까지 돌렸다. 저장소 작업 트리의 사이트 파일은 고치지 않았고 이 task에서는 커밋하지 않았다. 원고 글은 이 기록에 옮기지 않는다(원고는 06-09 커밋에 들어간다).

DRAFT_CAND=608db1ab928f

- 스크래치 재확인: `$W/lib.sh` 함수 열둘, Playwright 1.59.1, `$W/pw/p6-deletion.mjs`, `$W/base/TREE`가 `BASE_SHA`의 트리와 같고 `$W/base/site/index.html`이 있다. 다시 만든 것이 없어 `REGEN` 줄은 없다.
- precondition: 06-06·06-13 표식(`D33_C7`, `D33_C8`, `PUBLIC_COURSE_PERIOD`, `D39_PATH`, `APPCHECK_ROW`, `AUTHLOG_ROW`, `DEVICE_SENTENCE`, `INSTALL_SENTENCE`, `RECDEL_UNIT`, `RECDEL_BADGES`, `OPS_SHA`, `DEL06_REPORT`, `LOC_CONSENT_CONTROL`, `RETAINED_ROWS`, `DELETED_ITEMS`, `PERIOD_OK`, `INV_DEC_SHA`)이 모두 있고 `INV_DEC_SHA`가 HEAD의 조상이다.
- 원고가 읽은 사실의 출처: `INV_DEC_SHA`의 데이터 목록(구간 A 「「내 계정」 화면」 줄·`customPhotoUrl` 행·익명 행, 구간 B, 구간 C, 구간 G, 구간 E·F·H의 「남음」 행), 위 `## 06-13 대조표 확정`의 분류와 고정 줄 아홉, 운영 절차서 작업 13(`OPS_SHA`), 지원 페이지 FAQ의 경로 문자열. 대조표는 다시 나누지 않았다.
- front matter: `title`·`eyebrow`는 그대로, `heading`은 D-17의 글자, `description`은 새 요약(큰따옴표·꺾쇠·앰퍼샌드 없음), `updated`는 원고를 쓴 날(2026년 11월 27일. 06-09가 재작성 커밋 날짜로 바꾼다). 검색 제외 키와 끝 안내 `footer`는 없다(U14).
- 조항 순서: 소개 문단(`section` 밖 최상위 `p`, 개발자 이름 값이 있을 때만) → `#request` 삭제 요청 방법 → 처리 기간과 완료 알림 → 지워지는 데이터 → 남는 데이터 → 일부만 지우기 → `#location` 위치정보 동의 철회 → `#google`·`#apple`·`#facebook`·`#kakao`·`#naver`·`#line` → 문의처. id는 여덟 개뿐이다.
- 남는 데이터 표 일곱 행과 대조표 행: 공개한 코스(G10), 해시 호출 횟수 제한 기록(G12), Analytics(G14), Crashlytics(H11), Firebase Authentication(H9), 지운 프로필 사진의 보관 사본(H17), 서버 로그(G15). 기간 칸은 `PERIOD` 줄의 문구만 담는다. 공개 코스 행의 남는 이유에 `REASON` 줄의 글자가 있다. 지워지는 데이터 목록은 여덟 항목이다(06-13 범주 여덟과 하나씩).
- 표 밖 문장: `D33_C7=ga`라 표 아래 `aside`에 둘러보기 문장(기록·코스·뱃지를 서버에 저장하지 않는다) 하나만 두었다. `DEVICE_SENTENCE=out`, `INSTALL_SENTENCE=out`이라 기기 안 설정 문장과 installation ID 문장은 없다. 자동 삭제 문장도 없다.
- 넣지 않은 선택 문장: 계획이 「쓸 수 있다」고 한 기기 안 원시 위치 기록 문장(대조표 C7의 문장 후보)은 넣지 않았다. 목록에 비정상 종료 때 남는 기간이 「미확인」이고, 계정이 남는 삭제에서는 기기에 남은 기록이 다시 올라올 수 있다고 적혀 있어서다(구간 G 표 아래 메모). 넣을지는 승인 때 사용자가 본다.
- 이메일 값 조건: `#request`의 ② 전체, 처리 기간의 메일 요청 문단, 일부만 지우기의 「메일로는 두 요청만 받는다」 문단, `#location` 3번 항목, 문의처의 이메일 문단은 `support_email` 값이 있을 때만 그려진다. 본문 mailto는 `#request`와 문의처 두 곳이다.
- `draftreal`(저장소의 `_data/company.yml`로 빌드)에는 개발자 이름 키가 아직 없어 소개 문단이 0이다(06-08이 값을 받기 전 상태). 빌드 기록에 경고·오류는 없다. 승인 자료는 가짜 값 빌드 `d-full`에서만 만든다.
- 승인 때 사용자가 볼 것 (실행자가 정하지 않음): (1) 지워지는 데이터의 「공개하지 않은 코스(비공개·검수 대기 등)」에서 「검수 대기」는 D-39가 앞으로 생길 상태라고 적은 낱말이다. (2) 제공자 섹션의 받는 항목은 구간 B 행의 글자대로다. 구간 B의 Google·Apple·Facebook 행에는 회원번호가 없고 구간 A `linkedProviders` 행은 제공자 응답의 회원번호를 기록한다고 적는다. (3) `#location` 파기 문장의 「(2~4번)」은 이메일 값이 없는 변형에서 항목이 셋이 되어 번호가 어긋난다(계획 검사 info. 라이브에는 이메일 값이 있다). (4) 둘러보기 문장의 낱말 「둘러보기」와 앱 화면 낱말 「게스트로 이용 중」(`SRC guest-label`)이 다르다(06-06 기록).
- 판정 도구: `$W/t1-build.sh`(시험 객체, check-site, `draftreal`, 차이 파일, `d-full`), `$W/t1-judge.sh`(본문 블록 판정 일곱 줄). 값은 찍지 않는다.

```
check-site: 통과 (커밋 608db1ab928f, jekyll 3.10.0)
OK diff draftreal only=data-deletion/index.html
OK draft structure ids=request,location,google,apple,facebook,kakao,naver,line figures=1/1 tables=1 retained=7 deleted=8
OK draft rules class=0 style=0 extra-elements=0 u10=0 robots=0 temp=0 absolute=0 thirtyday=0
OK draft facts faqpath=1 tenday=1 promptly=2 locinfo=2 evidence=3 evdestroy=1 reply=3 disconnect-links=4 reqphrase=1
OK draft words nonpublic=1 oldprivate=0 oldscope=0 menus=6 allrec-location=2 sixmonth-location=1 code184=0
OK draft locconsent inventory=1 draft=1
OK draft periods 9/9
OK draft values mailto=2 reqmailto=1 reqli=4 phone=1 dev=1 escaped=ok source-values=0 data-refs=21
OK chromium 375 deletion title=ok h1=ok robots=0 ids=request,location,google,apple,facebook,kakao,naver,line reqmailto=1 mailto=2 first=ok mailfirst=na figures=1/1
OK chromium 375 anchor request ok
OK chromium 375 anchor location ok
OK chromium 375 anchor google ok
OK chromium 375 anchor apple ok
OK chromium 375 anchor facebook ok
OK chromium 375 anchor kakao ok
OK chromium 375 anchor naver ok
OK chromium 375 anchor line ok
OK chromium 1280 deletion title=ok h1=ok robots=0 ids=request,location,google,apple,facebook,kakao,naver,line reqmailto=1 mailto=2 first=ok mailfirst=ok figures=1/1
OK chromium 1280 anchor request ok
OK chromium 1280 anchor location ok
OK chromium 1280 anchor google ok
OK chromium 1280 anchor apple ok
OK chromium 1280 anchor facebook ok
OK chromium 1280 anchor kakao ok
OK chromium 1280 anchor naver ok
OK chromium 1280 anchor line ok
OK webkit 375 deletion title=ok h1=ok robots=0 ids=request,location,google,apple,facebook,kakao,naver,line reqmailto=1 mailto=2 first=ok mailfirst=na figures=1/1
OK webkit 375 anchor request ok
OK webkit 375 anchor location ok
OK webkit 375 anchor google ok
OK webkit 375 anchor apple ok
OK webkit 375 anchor facebook ok
OK webkit 375 anchor kakao ok
OK webkit 375 anchor naver ok
OK webkit 375 anchor line ok
OK webkit 1280 deletion title=ok h1=ok robots=0 ids=request,location,google,apple,facebook,kakao,naver,line reqmailto=1 mailto=2 first=ok mailfirst=ok figures=1/1
OK webkit 1280 anchor request ok
OK webkit 1280 anchor location ok
OK webkit 1280 anchor google ok
OK webkit 1280 anchor apple ok
OK webkit 1280 anchor facebook ok
OK webkit 1280 anchor kakao ok
OK webkit 1280 anchor naver ok
OK webkit 1280 anchor line ok
PASS deletion
OK site-clean 06-07-t1 9cd5f6a5f0b4
```

- 화면: `d-full`(가짜 값)을 포트 4603에 띄워 `p6-deletion.mjs`를 `--shot "$W/cap/draft"`로 돌렸다. 종료 코드 0, 앵커 서른두 줄은 모두 `ok`이고 `ok-end`는 없다. 캡처 네 장은 `$W/cap/draft/<엔진>-<폭>.png`다.
- 원고 후보 객체는 어떤 브랜치에도 없다(`git branch -a --contains`가 빈 출력).
- 고쳐 쓴 횟수: 첫 판정(시험 객체 `3ac83f555329`)이 모두 통과한 뒤 문장을 두 번 다듬어 3번부터 다시 했다. 첫 번째는 `#location` 2번 항목(코스 단위 메뉴와 「뱃지와 기록 모두 삭제」를 나눠 씀)과 확인자료 보관 문장(「서비스를 이용하는 동안에는」을 더함), 두 번째는 공개 코스 행의 남는 이유(목록 글자 「만든 사람의 식별자만 연결」에 맞춤)다. 위 줄은 마지막 후보 `DRAFT_CAND`의 출력이고, 앞 두 시험 객체는 ref 없이 남아 있다.
- tracer 관문: Task 1 verify를 bash 임시 파일로 두 번 돌려 두 번 모두 exit 0이었다(자동 확인만 있는 verify, `human_verify_mode` end-of-phase). Task 1은 커밋하지 않았다.

## 06-07 변형

`full.yml`(일곱 키 모두 가짜 값)에서 한 곳씩 바꾼 가짜 yml 다섯 개로 `DRAFT_CAND`를 변형 빌드해 본문 블록에서 셌다. 다섯 변형은 빌드만 했고 check-site는 돌리지 않았다(값이 가짜다). 빌드 실패는 없다. 실제 사업자 값·지원 주소·개발자 이름은 쓰지 않았다.

DRAFT_BLOB=b681410f94c5b44600fe0fddd531b4d963371f2b

```
OK variant nophone intro=1 mailto=2 reqmailto=1 phone=0 contact=1 ids=8
OK variant nodev intro=0 mailto=2 reqmailto=1 phone=1 contact=1 ids=8
OK variant noemail intro=1 mailto=0 reqmailto=0 phone=1 contact=1 ids=8
OK variant empty intro=0 mailto=0 reqmailto=0 phone=0 contact=0 ids=8
OK variant escape esc=1 raw=0
OK variant fake-only yml=0 d-full=0
OK captures draft=4
OK site-clean 06-07-t2 9cd5f6a5f0b4
```

- 변형: `nophone`(전화 빈 값), `nodev`(개발자 이름 빈 값), `noemail`(지원 이메일 빈 값), `empty`(일곱 키 모두 빈 값), `escape`(개발자 이름에 꺾쇠·앰퍼샌드·큰따옴표). 값이 없는 항목은 문단째 숨고(전화 문단, 소개 문단, 메일 경로 다섯 곳, 문의처 조항 전체), 앵커 여덟 개는 어느 변형에서도 그대로다. `escape`에서 값은 이스케이프되어 한 번 나오고 원문 태그는 0이다(T-06-18).
- `OK variant fake-only`: 가짜 yml 폴더 `$W/yml`과 `d-full` 빌드 출력에 실제 도메인 주소가 0건이다(grep 종료 코드 1을 확인. T-06-21).
- `noemail`에서는 `#location`의 철회 항목이 셋이라 파기 문장의 「(2~4번)」과 번호가 어긋난다(계획 검사 info 그대로. 라이브에는 이메일 값이 있고 06-10 가드가 본문 mailto를 지킨다). 승인 때 함께 보인다.
- 캡처: Task 1 5번의 네 장(`$W/cap/draft/chromium-375.png`, `chromium-1280.png`, `webkit-375.png`, `webkit-1280.png`)이 마지막 후보의 `d-full` 빌드로 다시 찍혀 있다.
- 승인 글: `$W/draft/preview.txt`. `d-full` 출력의 제목·설명·h1·업데이트 줄과 본문 블록을 태그를 지운 글로 바꾼 것이다(조항마다 `[#id]`나 `[id 없음]`, 링크는 `[글](주소)`, 표는 행마다 `|`로 나눔). 가짜 값만 들어 있다. 도구는 `$W/t2-variants.sh`, `$W/t2-preview.py`, `$W/t2-fix.sh`다.
- 승인 대상 고정: `DRAFT_BLOB`은 `$W/draft/data-deletion.html`의 blob이고 `<DRAFT_CAND>:data-deletion/index.html`과 같다. 스크래치 ref `refs/p6-scratch/draft`가 `DRAFT_CAND`를 가리킨다(브랜치·태그가 아니라 푸시되지 않는다). 이 뒤로 원고를 고치지 않았다.
- 값 누출 점검: `vals filled=0 emitted=0 excluded=0`이라 `leak=skip(no new values)`다(개발자 이름 키에 값이 아직 없다). 이 기록에 `_data/company.yml`의 값은 0건이고 로컬 경로·토큰 꼴도 0건이다.
- Task 2 verify를 bash 임시 파일로 두 번 돌려 두 번 모두 exit 0이었다. Task 2도 커밋하지 않았다(검증 기록과 SUMMARY는 계획 끝 문서 커밋에 함께 넣는다).

### Task 3 질문 (원고·표·앵커 승인)

Task 3은 사람이 답하는 결정 checkpoint다. 실행자는 아래 자료를 오케스트레이터에 넘기고 멈췄다. 승인 표식과 구간 `06-07 승인`은 사용자 답을 받은 뒤 이어 하는 실행자가 적는다.

- 넘긴 자료: `$W/draft/preview.txt`의 글 전체(조항별, 가짜 값), 캡처 네 장의 경로, 위 `## 06-07 원고`·`## 06-07 변형`의 판정 줄, 앵커 여덟 개(`#request`, `#location`, `#google`, `#apple`, `#facebook`, `#kakao`, `#naver`, `#line`)와 다른 조항(처리 기간과 완료 알림, 지워지는 데이터, 남는 데이터, 일부만 지우기, 문의처)에는 id가 없다는 것.
- 나란히 보인 대조 (원고 문장과 근거. 근거 글은 `INV_DEC_SHA`의 목록에서 다시 꺼냈다):
  - 남는 데이터 표 일곱 행 ↔ 06-13 확정본의 「남음」 일곱 행(G10·G12·G14·H11·H9·H17·G15), `PERIOD` 일곱 줄과 `REASON` 한 줄, 목록 구간 G 네 행과 구간 H 세 행의 남는 이유·기간
  - `#location` 파기 문장 ↔ 목록 구간 C 확인자료 행의 삭제 방식 칸(세 경로에서 지체 없이 파기), `DEL06_REPORT=conform`, 위 `## 06-04 앱 사실`의 ⑥ 코드 확인(`APP_FACTS=OK`)
  - `#location` 「6개월」 문장 ↔ `INUSE` 줄과 같은 행의 보유 기간 칸(코드 값은 목록에만)
  - `#location` 「앱에는 위치정보 동의만 따로 끄는 설정이 없습니다」 ↔ 목록 구간 C 표 아래 같은 줄(근거 `firestore.rules:56`, 앱 `92e986c3`)
  - 「일부만 지우기」와 `#location`의 메뉴 문구 여섯 ↔ 목록 구간 C `runs`·`courses` 행과 구간 A `customPhotoUrl` 행의 삭제 방식 칸, 위 `## 06-04 화면 사실`의 `OK menu` 일곱 줄
  - 「삭제 요청 방법」의 「내 계정」 화면 낱말 ↔ 목록 구간 A 「「내 계정」 화면」 줄
  - 요청 이름·처리 기한·첫 답장·본인 확인·제공자 연결 문장 ↔ 운영 절차서 작업 13의 1·2·3·8·9·10·13번과 목록 구간 G 표 아래 처리 기한 메모
  - `D33_C7=ga`라 둘러보기 문장은 06-06 선택지 (가) 문장에서 끝말만 높임말로 바꾼 것이다(`na`가 아니어서 글자 대조 표식은 없다).
- 함께 알린 것 (원고에서 계획 글과 다르거나 사용자가 정할 곳):
  1. 「공개하지 않은 코스(비공개·검수 대기 등)」의 「검수 대기」는 D-39가 앞으로 생길 상태라고 적은 낱말이다(계획이 준 꼴 그대로).
  2. 제공자 섹션의 받는 항목은 구간 B 행대로다. 구간 B의 Google·Apple·Facebook 행에는 회원번호가 없고 구간 A `linkedProviders` 행은 제공자 응답의 회원번호를 기록한다고 적는다.
  3. `#location` 파기 문장의 「(2~4번)」과 제공자 섹션·「일부만 지우기」의 「지원 이메일」 낱말은 이메일 값이 없는 변형에서 어긋나거나 주소 없이 남는다(라이브에는 값이 있다).
  4. 둘러보기 문장의 낱말 「둘러보기」와 앱 화면 낱말 「게스트로 이용 중」이 다르다.
  5. 계획이 「쓸 수 있다」고 한 기기 안 원시 위치 기록 문장은 넣지 않았다.
  6. 「일부만 지우기」에서 「메일로는 두 요청만 받는다」 문단을 목록 아래에 두고 이메일 값 조건으로 감쌌다(계획은 목록 앞 문단으로 적었고 조건을 적지 않았다). `#request`·처리 기간·`#location` 3번과 같은 조건이다.
  7. `#location` 1번의 「이미 저장된 기록은 그대로 남습니다」는 계획의 「파기를 약속하지 않음」을 문장으로 쓴 것이고, 확인자료 보관 문장의 「서비스를 이용하는 동안에는」은 목록의 「이용 중에는」을 풀어 쓴 것이다.
  8. 375 폭 캡처에서 남는 데이터 표의 기간 칸이 오른쪽에서 잘려 보인다. 표가 `figure` 안에서 가로로 밀리는 모양이고(법적 본문 작성 규칙 D-07) 페이지 가로 넘침 판정은 통과했다.
  9. 위치정보법에 기대는 문장(철회, 파기, 확인자료)은 법률 확인 전 초안이다(D-36, U2 초안 진행).
- 실행자는 approve·revise·hold 가운데 어느 것도 고르거나 권하지 않았다. 항목마다 사실과 답이 달라질 조건만 적어 넘겼다.

## 06-07 승인

Task 3(원고 글·남는 데이터 표·공개 앵커 여덟 개 승인, `checkpoint:decision`, gate `blocking-human`)의 답을 적는다. 승인 대상 blob과 ref는 Task 2가 이미 고정했고 이 구간에서 다시 고정하거나 바꾸지 않았다. 원고, 스크래치 산출물, 빌드도 다시 만들지 않았다.

DRAFT_APPROVED=b681410f94c5

- 답: `approve`. 사용자의 답 글 전체가 이 한 낱말이다(이어 하기 지시에 글자 그대로 실려 왔다). `revise`도 `hold`도 아니다. 이 구간은 2026-11-27(한국 시각)에 적었다.
- 승인한 것: 원고 글, 남는 데이터 표, 공개 앵커 여덟 개(`#request`, `#location`, `#google`, `#apple`, `#facebook`, `#kakao`, `#naver`, `#line`). 위 표식은 `## 06-07 변형`에 있는 원고 blob 표식의 앞 12자리다. 다른 조항에는 id가 없다.
- 이 승인이 아닌 것: 푸시 승인이 아니다(푸시는 06-09가 그 SHA로 따로 묻는다). 개발자 이름 값도 아직 받지 않았다(06-08). 승인한 원고는 `updated` 한 줄 말고는 바뀌지 않는다(계획 Task 3 context).
- 답이 나온 과정 (이어 하기 지시가 전한 그대로):
  1. 오케스트레이터가 checkpoint를 한 메시지로 사용자에게 전했다. `$W/draft/preview.txt`의 글 전체, 남는 데이터 표와 06-13 고정 줄·데이터 목록 행의 나란한 대조, `#location` 문장들과 목록 근거, 메뉴·요청 문구와 목록·운영 절차서 작업 13의 대조, 공개 앵커 여덟 개와 다른 조항에 id가 없다는 것, 판정 줄, 캡처 경로, 앞 실행자가 넘긴 「볼 곳」 메모(이어 하기 지시는 열한 가지라고 적었다. 위 「Task 3 질문」의 「함께 알린 것」은 아홉 줄이다), 위치정보 조항이 법률 확인 전 초안이라는 것(D-36)이다.
  2. 앞 실행자는 어느 선택지도 고르거나 권하지 않았다.
  3. 오케스트레이터가 같은 메시지에 따로 이름 붙인 권고 구간을 덧붙였다. 실행자나 연구의 의견이 아니라 오케스트레이터 자신의 의견이라고 밝혔고, 권한 답은 `approve`다. 답이 뒤집힐 조건을 함께 댔다: Google·Apple·Facebook 받는 항목의 회원번호를 첫 게시부터 맞추고 싶으면 `revise`, 위치정보 조항의 법률 확인을 먼저 받고 싶으면 `hold`. 회원번호 항목과 카카오·네이버 문장에 대해서는 확신이 낮다고 밝혔다.
  4. 사용자는 이 세션에서 권고를 묻지 않았다. 오케스트레이터가 스스로 덧붙인 것이다(06-06 Task 3에서는 사용자가 먼저 권고를 물었다. 그때와 다른 점이다).
  5. 사용자가 권고가 든 그 메시지를 본 뒤 `approve` 한 낱말로 답했다.
- 이 답을 읽는 법: 사용자가 낸 답이다. 다만 권고 없이 낸 답이 아니라, 묻지 않은 권고(`approve`)가 붙은 자료를 본 뒤 낸 답이다. 실행자는 고르거나 권하지 않았다(06-01 「사이트 커밋을 막는 것」: 계획자와 실행자는 열린 선택지를 대신 고르지 않는다). 이 구간을 적은 실행자는 답과 위 과정을 이어 하기 지시(오케스트레이터가 전한 글)로 받았고 사용자와 직접 주고받지 않았다.
- 열린 항목 셋 (사용자 결정이 아니다. 원고는 그대로다): 오케스트레이터는 같은 메시지에서, 답이 `approve` 한 낱말이면 아래 셋을 Phase 7에서 다시 볼 열린 항목으로 적겠다고 알렸고 사용자는 반대하지 않았다.
  1. 지워지는 데이터의 「공개하지 않은 코스(비공개·검수 대기 등)」에서 「검수 대기」. 데이터 목록 구간 G의 공개하지 않은 코스 행에 같은 낱말이 있다. 06-CONTEXT D-39는 「앞으로 생길 검수 대기」라고 적는다.
  2. Google·Apple·Facebook 섹션의 받는 항목에 회원번호가 없다. 데이터 목록 구간 B의 세 행은 이메일·이름·사진(Apple은 이메일·이름)만 적고, 구간 A `linkedProviders` 행은 「로그인 제공자 응답의 회원번호」를 기록한다고 적는다. 고치려면 구간 B가 먼저이고 Phase 7 처리방침(PRIV-10)이 같은 표를 쓴다. 앱이 이 세 제공자의 회원번호를 실제로 기록하는지는 이번에 코드에서 확인하지 않았다.
  3. 카카오·네이버의 연결 해제 안내는 공식 도움말 링크 없이 문장뿐이다. 두 서비스의 실제 메뉴 이름은 확인하지 못했다.
- 오케스트레이터가 전한 확인 (이 실행자는 다시 확인하지 않았다): 자료를 보이기 전에 원고의 외부 도움말 링크 넷(Google, Apple, Facebook, LINE)이 HTTP 200과 앱 연결 관리·해제에 관한 제목을 돌려줬고, 원고의 기간 문구, 「6개월」, 위치정보 동의 설정 문장, 메뉴 문구, 10일·직접 해제 문장이 `DATA-INVENTORY.md`와 `USER-TASKS.md`에 글자 그대로 있다는 것.
- 이 실행자가 답을 적기 전에 다시 본 것: Task 1·2 verify를 bash 임시 파일로 돌려 둘 다 exit 0. `refs/p6-scratch/draft`가 원고 후보 객체를 가리키고, 그 객체의 `data-deletion/index.html` blob, `$W/draft/data-deletion.html`의 `git hash-object`, 원고 blob 표식이 모두 같다. 원고 후보 객체는 어떤 브랜치에도 없다. 열린 항목 1·2의 목록 글자(구간 G 행의 「검수 대기」, 구간 B 세 행, 구간 A `linkedProviders` 행)와 D-39의 글자는 직접 읽어 위와 같음을 봤다.
- 이 계획 동안(`9cd5f6a5f0b4` 뒤) 커밋은 아직 없고, 작업 트리의 사이트 파일과 `_data/company.yml`은 HEAD와 같다. 스테이징한 것도 없다.

```
OK site-clean 06-07-t3 9cd5f6a5f0b4
```

## 06-08 시험 실행

스토어 개발자 이름 값을 받기 전에, 실제 값으로 돌릴 파이프라인(값 커밋 미리보기 → 재작성 미리보기 → check-site → 빌드 → 소개 문단 → 값 누출 점검)을 가짜 이름으로 끝까지 돌렸다. 저장소 작업 트리의 사이트 파일과 `_data/company.yml`은 고치지 않았고 이 task에서는 커밋하지 않았다. 실제 값은 아직 받지 않았다.

DRY_RUN=OK

- 시작: 2026-11-26T23:46:29Z (한국 시각 2026-11-27 08:46). 계획 시작 때 HEAD는 `da81ae548042`다.
- 스크래치 재확인: `$W/lib.sh` 함수 열둘, Playwright 1.59.1, `$W/pw/p6-deletion.mjs`, `$W/base/TREE`가 `BASE_SHA`의 트리와 같고 `$W/base/site/index.html`이 있다. 다시 만든 것이 없어 `REGEN` 줄은 없다.
- precondition: `DRAFT_APPROVED`와 원고 blob 표식이 있고 `refs/p6-scratch/draft`의 `data-deletion/index.html` blob이 그 표식과 같다. 작업 트리의 사이트 파일에 고친 것도 스테이징한 것도 없다.
- 승인한 원고 사본: `git cat-file blob`으로 `$W/draft/approved.html`에 꺼냈고 `git hash-object`가 원고 blob 표식과 같다.
- 가짜 개발자 이름: 실행 때 `/dev/urandom`으로 만든 한 줄을 스크래치 `$W/yml/devfake.val`에만 두었다. 화면에 찍지 않았고 이 기록, 계획, 커밋 메시지에 옮기지 않았다. 다시 돌리면 새 값이 된다.
- `$W/yml/devfake.yml`: `HEAD:_data/company.yml`에 머리 주석 한 줄(맨 위 주석 묶음 끝)과 키 줄 `store_developer_name`(`phone` 줄 다음)을 더한 것이다. 원본과의 차이는 더한 두 줄뿐이고 지운 줄이 없다(Task 3의 `git diff --numstat` 기대 모양과 같다). 키는 일곱 개다.
- 시험 객체 셋(값 커밋 미리보기 `d38883cab529`, 재작성 미리보기 `d4e52c79a9e4`, 양성 시험 `b7d43df0f727`)은 어떤 ref에도 붙이지 않았다. 양성 시험 파일 `$W/yml/ev-probe.md`와 패턴 파일은 지웠다. `$W/yml/devfake.val`과 `devfake.yml`은 남겼다(Task 3과 verify가 다시 본다).
- 바이트 비교는 두 site 폴더의 파일을 `cmp`로 하나씩 견줘 다른 파일의 이름만 셌다(`diff -r`는 다른 줄을 찍어 가짜 이름이 화면에 나오므로 쓰지 않았다. 판정은 같다).
- 값 누출 점검: 음성은 작업 트리 `.planning`의 `git grep`(종료 코드 1, 빈 출력)과 `BASE_SHA..HEAD` 커밋 메시지(종료 코드 0, 일치 0)다. 양성은 이 기록 파일 끝에 가짜 이름 한 줄을 붙인 사본을 HEAD에 얹은 시험 객체에서 같은 패턴 파일로 `git grep`(종료 코드 0, 파일 1)과 `git diff`(종료 코드 0, 일치 줄 1)를 봤다.
- 작업 트리 `_data/company.yml`: 깨끗함 기록 식은 이 파일을 빼고 보므로 따로 `git diff --quiet HEAD -- _data/company.yml`로 봤다(`OK yml` 줄).
- 판정 도구: `$W/p608-t1.sh`(출력 `$W/p608-t1.log`). 값은 찍지 않고 건수와 판정 줄만 찍는다.

```
OK precondition draft-approved blob=ref site-files-unchanged staged=0
OK scratch recheck lib-functions=12 playwright=1.59.1 tool=present base-tree=same
OK devfake value lines=1 shape=ok (값은 스크래치에만 있다)
OK devfake yml added=2 deleted=0 keys=7 parsed-value=file-value
check-site: 통과 (커밋 d38883cab529, jekyll 3.10.0)
check-site: 통과 (커밋 d4e52c79a9e4, jekyll 3.10.0)
OK s1f same
OK s2f only=data-deletion/index.html dev=1
vals filled=1 emitted=1 excluded=0
leak .planning=0 messages=0
leak-probe hit tree=1 diff=1
OK dry objects unreferenced s1f=d38883cab529 s2f=d4e52c79a9e4 probe=b7d43df0f727
OK yml unchanged (작업 트리 = HEAD)
OK site-clean 06-08-t1 da81ae548042
```

Task 3이 알아야 할 것 (판정이 아니라 잰 값이다. 재작성 미리보기 `s2f`의 본문 블록에서 줄 수만 셌다):

```
NOTE s2f doc-lines-with trade_name=1
NOTE s2f doc-lines-with representative=0
NOTE s2f doc-lines-with biz_reg_no=0
NOTE s2f doc-lines-with address=1
NOTE s2f doc-lines-with support_email=2
NOTE s2f doc-lines-with phone=empty
NOTE s2f doc-lines-with 슬림펌킨=1 러닝펜슬=17 slimpumpkin(대소문자 무시)=0 runningpencil(대소문자 무시)=2
NOTE s2f doc-lines-with RunningPencil=0 SlimPumpkin=0 Slim=0 Pumpkin=0
NOTE s2f doc-lines-with trade_name-and-슬림펌킨 same-line=1
NOTE s2f trade_name-line is-intro=0
NOTE s2f file-lines-with devfake=1 (본문 블록 밖 포함 파일 전체)
```

- 읽는 법: Task 3의 `dev`는 본문 블록에서 받은 값이 든 줄을 센다(`grep -c -F`, 부분 일치). 본문 블록에는 소개 문단 말고도 상호 값이 든 줄이 하나 있고(그 줄에 「슬림펌킨」도 있다), 「러닝펜슬」이 든 줄이 열일곱이다. 받은 개발자 이름이 상호 값이나 서비스 이름과 같거나 그 줄의 글자에 들어 있는 낱말이면 `dev`가 1보다 크게 나온다. 무작위 가짜 이름에서는 생기지 않는 경우라 이 시험이 보지 못했다.
- 그 경우 Task 3 verify의 `OK s2v only=data-deletion/index.html dev=1` 줄을 낼 수 없다. 실행자는 판정을 고쳐 맞추지 않고 멈춰 계획의 결함으로 알린다(계획 assumptions 둘째 줄은 같은 경우의 `vals` 쪽, 곧 excluded와 점검 건너뜀만 정했다).
- tracer 관문: 이 구간을 적은 뒤 Task 1 verify를 bash 임시 파일로 두 번 돌려 둘 다 exit 0이었다. 이 기록 파일에 경로·토큰 꼴과 홈 경로는 0건이고(grep 종료 코드 1), 가짜 이름은 `.planning` 작업 트리 어디에도 없다.
- 이 구간을 적은 실행은 Task 2(값 받기, `checkpoint:human-action`, gate `blocking-human`)에서 멈췄다. 값은 받지 않았고 `_data/company.yml`은 HEAD 그대로다. 이 기록은 아직 커밋하지 않았다(계획 끝 문서 커밋에 SUMMARY와 함께 들어간다).

## 06-08 값 미리보기

Task 2에서 받은 스토어 개발자 이름 값을 작업 트리 `_data/company.yml`의 새 키 `store_developer_name` 한 줄에만 넣고, 그 값으로 만든 미리보기 객체 둘(값 커밋 미리보기, 재작성 미리보기)을 판정했다. 값은 커밋하지 않았고 스테이징하지도 않았다. 이 구간에는 값이 없다. 건수와 있음/없음만 적는다.

S2V_CAND=4505d77840d0
APPSTORE_NAME=same
DEV_RECEIVED=OK

- 실행: 이어 하기 실행자가 Task 3부터 했다. Task 1은 위 `## 06-08 시험 실행` 그대로이고 다시 돌리지 않았다(`$W/p608-t1.sh`도 다시 돌리지 않아 가짜 값과 시험 객체 해시가 그대로다). Task 3 시작은 2026-11-27T01:55:59Z(한국 시각 10:55)다. Task 1 끝(2026-11-26T23:51:25Z)부터 그때까지는 Task 2의 사용자 대기(일시 중지 포함)다.
- HEAD는 `b2644ec30ad3`이다. Task 1 때의 `da81ae548042` 위에 오케스트레이터의 일시 중지 기록 커밋 둘(`docs(pause)`)이 있고, 둘 다 `.planning` 아래 인계 파일 둘만 담는다. 사이트 출력이 같다는 것은 아래 `OK s1v same`(기준 빌드와 바이트 비교)이 다시 봤다.
- Task 2 답 (값은 적지 않는다):
  - Google Play 개발자 이름: 받았다. 한 줄이고 앞뒤 공백이 없다.
  - App Store 개발자(판매자) 표기가 Google Play와 같은지: `same`.
- 답이 나온 과정 (이어 하기 지시가 전한 그대로. 값은 빼고 과정만 적는다):
  1. 사용자가 먼저 Play Console 계정 세부정보 화면(개발자 이름 칸)을 보였다.
  2. 이어 Apple Developer 「멤버십 세부 사항」 화면을 보였다. 그 시점에는 두 이름이 달랐다.
  3. 사용자가 Google Play 개발자 이름을 영문 표기로 바꾸기로 정했고, Play Console에서 바꾼 뒤 바뀐 화면을 보였다.
  4. 오케스트레이터가 바뀐 화면에서 값을 읽고 App Store 쪽을 `same`으로 읽어, 두 가지가 맞는지 사용자에게 물었다. 사용자는 「예」로 답했다.
- 이 답을 읽는 법: 값과 `same`은 오케스트레이터가 화면에서 읽은 것을 사용자가 「예」로 확인한 것이다. 사용자가 글자로 써 준 값이 아니다. 이 구간을 적은 실행자는 값과 위 과정을 이어 하기 지시(오케스트레이터가 전한 글)로 받았고, 사용자와 직접 주고받지 않았으며 화면도 보지 않았다. 실행자는 값을 고르거나 고치지 않았다.
- 확인하지 못한 것 (열린 항목, Phase 10 스토어 표시 확인으로 넘긴다):
  - App Store에 표시되는 판매자 이름이 Apple 쪽 법인(legal entity) 이름과 같다는 것. 확인한 사실이 아니라 오케스트레이터의 기억이다. `APPSTORE_NAME=same`은 이 전제 위의 답이다.
  - 과정에 나온 화면은 Play Console 계정 세부정보와 Apple Developer 멤버십 화면이다. 두 스토어의 공개 등록정보에 실제로 표시되는 이름은 이 계획에서 보지 않았다(`06-VALIDATION.md` Manual 「스토어 개발자 이름 값이 스토어 표시와 같음」).
- 값 넣기 (action 1번): 작업 트리 `_data/company.yml`에 Task 1의 `$W/yml/devfake.yml`과 같은 자리에 같은 글자로 두 줄을 더했다(머리 주석 한 줄은 맨 위 주석 묶음 끝, 키 줄은 `phone` 줄 다음). 값 칸을 가린 두 파일이 바이트까지 같다. 값은 큰따옴표 안에 있고 앞뒤 공백이 없다. 키는 일곱 개다. 스테이징하지 않았다.
- 미리보기 객체 (action 2번): `mkobj`로 HEAD 위에 값 커밋 미리보기 `c5f98e86da21`, 그 위에 재작성 미리보기 `4505d77840d0`을 만들었다. 재작성 미리보기의 `data-deletion/index.html` blob은 승인한 원고 blob 표식과 같고(`$W/draft/approved.html`의 `git hash-object`), `_data/company.yml` blob은 작업 트리 파일과 같다. HEAD와 다른 파일은 그 둘뿐이다. 빌드는 `$W/s1v/`와 `$W/s2v/`에 있다.
- 바이트 비교는 Task 1처럼 두 site 폴더의 파일을 `cmp`로 하나씩 견줬다(`diff -r`는 다른 줄을 찍어 값이 화면에 나온다). 소개 문단 수는 작업 트리 yml에서 읽은 값을 임시 파일에 두고 본문 블록(`doc`)에서 `grep -c -F -f`로 센 뒤 임시 파일을 바로 지웠다.
- 계획에 없는 판정 줄 둘: `OK yml shape …`(더한 두 줄의 모양), `OK s2v vs s2f …`. 뒤 줄은 Task 1의 가짜 값 재작성 미리보기 빌드(`$W/s2f/`)와 견준 것이다. 다른 파일이 `data-deletion/index.html` 하나이고 그 파일에서 다른 줄이 한 줄이다. 줄 수만 셌다.
- 스크래치 ref (action 3번): 판정이 모두 통과한 뒤 `refs/p6-scratch/s2v`를 재작성 미리보기에 붙였다. 값 커밋 미리보기는 그 부모라 함께 남는다. 두 객체는 어떤 브랜치에도 없다(`git branch -a --contains` 빈 출력). 이 ref는 `refs/heads/`·`refs/tags/` 밖이라 푸시되지 않는다. 값이 든 blob은 이 ref 아래 로컬 객체로만 있다.
- 값 누출 점검 (action 4번): `vals`가 `excluded=1`을 냈다. 06-01 규칙대로 패턴 파일이 비므로 (a)(b)(c)를 건너뛰고 `leak=skip(no new values)`로 적는다(계획 assumptions 둘째 줄의 경우). 그래서 이 값에 대해서는 패턴 파일 점검이 돌지 않았다. 실행자가 따로 센 것은 아래 「계획 끝 점검」 줄에 있다.
- 판정 도구: `$W/p608-t3.sh`(출력 `$W/p608-t3.log`). 값은 도구 파일에 없고 작업 트리 yml에서만 읽는다. 한 번 돌렸고 첫 실행에서 모두 통과했다(다시 돌리면 `mkobj`가 새 해시를 내므로 다시 돌리지 않는다).
- 작업 트리: `_data/company.yml`에 커밋하지 않은 두 줄이 남아 있다(06-09가 쓴다). 깨끗함 기록 식은 이 파일을 빼고 본다. 이 계획의 문서 커밋은 `.planning` 경로 둘만 올린다.
- 계획 끝 점검 (이 구간을 적은 뒤에 했다):
  - Task 1과 Task 3의 verify를 bash 임시 파일로 돌려 둘 다 exit 0.
  - `git log <OPS_SHA>..HEAD -- . ':(exclude).planning'`가 빈 출력이다(종료 코드 0). 이 계획 동안 사이트 파일을 고친 커밋이 없다.
  - 이 기록 파일에 경로·토큰 꼴과 홈 경로는 0건이다(grep 종료 코드 1).
  - 이 구간에서 값이 든 줄은 0이다(작업 트리 yml에서 읽은 값 한 줄을 임시 패턴 파일로 셈, grep 종료 코드 1, 값은 찍지 않음). 가짜 이름은 `.planning` 작업 트리 어디에도 없다.
  - 표식 `S2V_CAND`, `APPSTORE_NAME`, `DEV_RECEIVED`는 줄 머리부터 각 한 번이다.
  - 작업 트리 `scripts/check-site.sh` 통과. 작업 트리에서 HEAD와 다른 사이트 파일은 `_data/company.yml` 하나(더한 두 줄)이고 스테이징한 것이 없다.

```
OK precondition dry-run=ok approved=blob base-tree=same other-site-files-unchanged staged=0
OK yml value-in-worktree uncommitted
OK yml shape added=2 deleted=0 keys=7 lines=devfake-shape quoted=1 trimmed=1 staged=0
check-site: 통과 (커밋 c5f98e86da21, jekyll 3.10.0)
check-site: 통과 (커밋 4505d77840d0, jekyll 3.10.0)
OK preview shape parents=HEAD+2 files=2 yml-blob=worktree draft-blob=approved
OK s1v same
OK s2v only=data-deletion/index.html dev=1
OK s2v vs s2f only=data-deletion/index.html lines=1
OK preview objects s1v=c5f98e86da21 s2v=4505d77840d0 ref=refs/p6-scratch/s2v branches=0
vals filled=1 emitted=0 excluded=1
leak=skip(no new values)
OK site-clean 06-08-t3 b2644ec30ad3
```
