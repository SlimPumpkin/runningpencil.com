# Phase 3 검증 기록 (Evidence)

이 문서는 Phase 3(법적 페이지 정적 스타일 전환)의 판정 기록입니다. `03-CONTEXT.md`의 D-13~D-18이 말하는 기준 커밋, CDN 버전, 캡처 판정 결과를 계획마다 구간 하나씩 더해 적습니다.

- 표식 줄은 줄 머리부터 `이름=값` 꼴로 씁니다(예: `BASE_SHA=…`). 뒤 계획의 명령이 `sed`로 읽으므로 표식 줄의 모양을 바꾸지 않습니다.
- 저장소 밖 스크래치 폴더는 `$W`로 적습니다(`$TMPDIR` 아래 `rp-p3`의 실제 경로). 실제 경로, 홈 경로, 설치 경로, IP 주소는 적지 않습니다.
- 저장소가 공개라 커밋 해시는 12자리로만 적습니다.

## 03-01 기준

BASE_SHA=8b65fdb59232
BASE_LIVE=9f715c795830
TW_CDN_VERSION=3.4.17

- 기록 시각: 2026-11-16 (Phase 3 첫 사이트 변경 전, D-16)
- `BASE_SHA`는 Phase 3 실행을 시작할 때의 HEAD, `BASE_LIVE`는 그때의 원격 main입니다. `BASE_LIVE`는 `BASE_SHA`의 조상이고 두 커밋은 `.planning/` 밖에서 트리가 같습니다(기준이 지금 라이브와 같은 사이트).
- 기준 출력: `BASE_SHA`를 `git archive`로 `$W/base/src`에 내보내 `JEKYLL_ENV=production bundle exec jekyll build --safe`로 `$W/base/site`에 빌드하고, `python3 -m http.server 4101 --bind 127.0.0.1`로 띄웠습니다(`--livereload` 없음). `$W/base/TREE`는 `BASE_SHA`의 트리와 같습니다.
- `tailwind=1`은 그 문서 HTML에 `cdn.tailwindcss.com`과 `tailwind-config`가 각각 한 번 있다는 뜻입니다(성공 기준 1의 전환 전 상태).

```
check-site: 통과 (커밋 8b65fdb59232, jekyll 3.10.0)
CDN location: /3.4.17
OK HTTP /privacy-policy/ 200 title=개인정보처리방침 - 러닝펜슬 tailwind=1
OK HTTP /terms/ 200 title=서비스 이용약관 - 러닝펜슬 tailwind=1
OK HTTP /data-deletion/ 200 title=데이터 삭제 안내 - 러닝펜슬 tailwind=1
OK HTTP / 200 title=러닝펜슬 - 달리고 걷는 길이 아트가 됩니다
```

## 03-01 도구와 기준 캡처

PW_VERSION=1.59.1
PNGJS_VERSION=7.0.0
PW_BROWSERS=chromium-1217 chromium_headless_shell-1217 webkit-2272
BASE_SELFDIFF=OK
JUDGE_NEG=OK

- 기록 시각: 2026-11-16. 설치는 사용자 승인(Task 2, install) 범위 안에서 했습니다.
- 설치: `$W/pw`에 `playwright@1.59.1`, `pngjs@7.0.0`을 고정 버전으로 설치했습니다. 패키지 관리자는 사용자 지시로 npm 대신 pnpm 10.33.2를 썼습니다(`pnpm --dir "$W/pw" add --save-exact …`). 저장소와 사이트에는 아무것도 설치하지 않았습니다.
- 브라우저: `pnpm --dir "$W/pw" exec playwright install --dry-run`이 가리킨 리비전(chromium-1217, chromium_headless_shell-1217, webkit-2272, ffmpeg-1011)이 캐시에 모두 있어 새로 내려받지 않았습니다.
- 스크립트: `capture.mjs`·`diff.mjs`·`states.mjs`·`report.mjs`는 `03-RESEARCH.md` 원문을 그대로 옮겼습니다. `sample.mjs`는 원문에 다섯 가지(실패 시 종료 코드 1, `th`·`dt` 확인, 375px 넓은 표 넘침 확인, 사이트 바닥글 테두리 0 확인)를 더했습니다.
- 판정 도구: `$W/judge.sh <이름> [--no-cdn]`이 `$W/cap/base1`과 비교합니다. 개수(PNG 42·hover·focus 24·txt 18·`report.json`) → `diff.mjs` → `states.mjs` → `report.mjs`를 모두 돌리고 마지막 줄에 `JUDGE <이름> OK|FAIL`을 찍습니다.
- 기준 캡처: `BASE_SHA` 빌드(`$W/base`)를 4101에 띄워 `$W/cap/base1`, `$W/cap/base2`를 차례로 찍었습니다(Chromium·WebKit × 375·768·1280 × 세 문서, deviceScaleFactor 1). 찍기 직전 CDN 리디렉션은 아래와 같았습니다.
- hover·focus 캡처는 처리방침·이용약관 두 문서에서 나옵니다(삭제 안내 본문에는 링크가 없음). 2엔진 × 3폭 × 2문서 × 2상태 = 24장이고, 모두 기본 캡처와 793~853픽셀 달랐습니다.

```
CDN location: /3.4.17
```

`judge.sh base2` (자기 차이, D-13):

```
COUNT base1 png=42 state=24 txt=18
COUNT base2 png=42 state=24 txt=18
PASS 0 diffs
state ok chromium-1280-privacy-policy-focus.png 846
state ok chromium-1280-privacy-policy-hover.png 849
state ok chromium-1280-terms-focus.png 846
state ok chromium-1280-terms-hover.png 847
state ok chromium-375-privacy-policy-focus.png 846
state ok chromium-375-privacy-policy-hover.png 809
state ok chromium-375-terms-focus.png 852
state ok chromium-375-terms-hover.png 820
state ok chromium-768-privacy-policy-focus.png 846
state ok chromium-768-privacy-policy-hover.png 849
state ok chromium-768-terms-focus.png 846
state ok chromium-768-terms-hover.png 793
state ok webkit-1280-privacy-policy-focus.png 846
state ok webkit-1280-privacy-policy-hover.png 842
state ok webkit-1280-terms-focus.png 846
state ok webkit-1280-terms-hover.png 837
state ok webkit-375-privacy-policy-focus.png 846
state ok webkit-375-privacy-policy-hover.png 798
state ok webkit-375-terms-focus.png 852
state ok webkit-375-terms-hover.png 816
state ok webkit-768-privacy-policy-focus.png 846
state ok webkit-768-privacy-policy-hover.png 842
state ok webkit-768-terms-focus.png 846
state ok webkit-768-terms-hover.png 802
STATES base2 ok=24 vacuous=0
PASS 18 rows
JUDGE base2 OK
```

`judge.sh neg` (음성 대조: `base2` 사본의 `chromium-375-terms.png` 첫 픽셀 빨강 채널을 242에서 243으로 바꿈. 확인 뒤 `$W/cap/neg`는 지웠습니다):

```
COUNT base1 png=42 state=24 txt=18
COUNT neg png=42 state=24 txt=18
DIFF chromium-375-terms.png 1 px, max 1
FAIL 1
state ok chromium-1280-privacy-policy-focus.png 846
state ok chromium-1280-privacy-policy-hover.png 849
state ok chromium-1280-terms-focus.png 846
state ok chromium-1280-terms-hover.png 847
state ok chromium-375-privacy-policy-focus.png 846
state ok chromium-375-privacy-policy-hover.png 809
state ok chromium-375-terms-focus.png 853
state ok chromium-375-terms-hover.png 821
state ok chromium-768-privacy-policy-focus.png 846
state ok chromium-768-privacy-policy-hover.png 849
state ok chromium-768-terms-focus.png 846
state ok chromium-768-terms-hover.png 793
state ok webkit-1280-privacy-policy-focus.png 846
state ok webkit-1280-privacy-policy-hover.png 842
state ok webkit-1280-terms-focus.png 846
state ok webkit-1280-terms-hover.png 837
state ok webkit-375-privacy-policy-focus.png 846
state ok webkit-375-privacy-policy-hover.png 798
state ok webkit-375-terms-focus.png 852
state ok webkit-375-terms-hover.png 816
state ok webkit-768-privacy-policy-focus.png 846
state ok webkit-768-privacy-policy-hover.png 842
state ok webkit-768-terms-focus.png 846
state ok webkit-768-terms-hover.png 802
STATES neg ok=24 vacuous=0
PASS 18 rows
JUDGE neg FAIL
```
