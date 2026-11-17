# Phase 4 판정 기록 (Evidence)

Phase 4(홈페이지 서비스 소개 정정)의 계획 04-01~04-13이 남기는 판정 기록입니다. 각 계획의 verify는 이 파일의 표식 줄과 구간을 읽어 다시 판정합니다.

**기록 규칙**

- 저장소가 공개이므로 로컬 홈 경로, 임시 폴더의 실제 경로, IP 주소, 토큰, 계정 이메일, 요청 ID를 적지 않습니다.
- 스크래치 경로는 `$W/…`로 적습니다.
- 커밋 해시는 12자리로 적습니다.
- 사용자가 넘긴 캡처 원본의 경로는 적지 않습니다.
- 표식 줄은 줄 머리부터 `이름=값`으로 씁니다 (앞에 공백·목록 기호 없음).
- 구간 머리는 `## <계획> <이름>`입니다. 보류한 시도는 구간 머리를 `## (보류 <n>) <계획> …`으로 바꾸고 표식 줄 머리에 `HOLD<n>_`을 붙입니다.

## 04-01 첫 문서 커밋

ROADMAP Phase 4 Goal·성공 기준 2, REQUIREMENTS SITE-06의 출시 전 표시를 「출시 준비 중」 기준으로 고치고(D-08), USER-TASKS 작업 10을 이 단계 결정대로 고친(D-16~D-20, D-19) 커밋입니다. 이 커밋은 세 문서만 담고, 사이트 출력을 바꾸지 않습니다.

DOCS_BASE_SHA=760d0e93e9ce
OK roadmap validate warnings=0

## 04-02 기준

사이트 파일을 고치기 전 HEAD를 기준으로 삼았습니다. 기준과 그때의 원격 main은 `.planning/` 밖 트리가 같습니다(기준이 지금 라이브와 같은 사이트). 기준 출력은 `$W/base`에 운영과 같은 production·`--safe` 빌드로 만들고 `python3 -m http.server`(포트 4201)로 띄워 확인했습니다. 낱말 수의 SC1 판정 대상은 `index.html` 하나이고, 법적 3종은 Phase 6~8 몫입니다.

BASE_SHA=0e75e8b88fd2
BASE_LIVE=0bfe5b210c3c

```
check-site: 통과 (커밋 0e75e8b88fd2, jekyll 3.10.0)
OK HTTP / 200 title=러닝펜슬 - 달리고 걷는 길이 아트가 됩니다
OK HTTP /privacy-policy/ 200 title=개인정보처리방침 - 러닝펜슬
OK HTTP /terms/ 200 title=서비스 이용약관 - 러닝펜슬
OK HTTP /data-deletion/ 200 title=데이터 삭제 안내 - 러닝펜슬
OK words index=2 privacy-policy=6 terms=6 data-deletion=3
OK base empty-badges=5
OK base index = 90d8046
```

## 04-02 도구와 기준 동작

검증 도구 설치는 Task 2 `checkpoint:decision`(blocking-human)에서 사용자가 **install (브라우저 내려받기 포함)**으로 승인했습니다. 범위는 `playwright@1.59.1` 고정, pnpm, 스크래치 `$W/pw`에만 설치, Phase 4 동안 같은 고정 버전·같은 경로 재설치 포함입니다. Phase 3 스크래치의 `package.json`·`pnpm-lock.yaml`을 복사해 `pnpm --dir "$W/pw" install --frozen-lockfile`로 설치했습니다. 1.59.1이 요구하는 브라우저 리비전이 캐시에 이미 있어 브라우저는 새로 받지 않았습니다. 저장소에는 아무것도 설치하지 않았습니다.

`p4-behave.mjs`(`$W/pw`, CLI `node p4-behave.mjs <baseURL> [query]`)는 Chromium·WebKit × (1280×800 기본, 375×812 기본, 1280×800 움직임 줄이기)에서 구조(`[data-step]` 6, `[data-go]` 3, 뱃지 줄 7, 스티커 6), 가로 밀림, 콘솔 오류·`pageerror`, 고정 구간의 0.5·0.85 지점 단계(`is-s1`·`is-s2`)와 stage 위 끝, 7초 달려 보기(3.5초 진행률 20~80, 7.7초 완료 창·`100 %`·「다시 달리기」), 움직임 줄이기의 고정 없음·단계 버튼·히어로 정지를 봅니다. 빈 뱃지 수는 출력만 합니다.

PW_VERSION=1.59.1
PW_BROWSERS=chromium-1217 chromium_headless_shell-1217 webkit-2272

기준 판정 (`$W/base`, 포트 4201):

```
OK chromium 1280 no-preference pin=1 badges=7 stickers=6 empty=5
OK chromium 375 no-preference pin=1 badges=7 stickers=6 empty=5
OK chromium 1280 reduce pin=0 badges=7 stickers=6 empty=5
OK webkit 1280 no-preference pin=1 badges=7 stickers=6 empty=5
OK webkit 375 no-preference pin=1 badges=7 stickers=6 empty=5
OK webkit 1280 reduce pin=0 badges=7 stickers=6 empty=5
PASS behave
```

음성 대조 (`$W/neg`, 포트 4202):

```
neg: rp-run-btn id를 스크래치에서만 바꿈 (id="rp-run-btn" -> id="rp-run-btn-x", 저장소는 그대로)
FAIL chromium 1280 no-preference pageerror: Cannot read properties of null (reading 'addEventListener')
FAIL chromium 1280 no-preference story 0.5 panel=rp-panel is-s0 stageTop=0
FAIL chromium 1280 no-preference story 0.85 panel=rp-panel is-s0 stageTop=0
FAIL chromium 1280 no-preference error: locator.scrollIntoViewIfNeeded: Timeout 5000ms exceeded.
FAIL chromium 375 no-preference pageerror: Cannot read properties of null (reading 'addEventListener')
FAIL chromium 375 no-preference story 0.5 panel=rp-panel is-s0 stageTop=0
FAIL chromium 375 no-preference story 0.85 panel=rp-panel is-s0 stageTop=0
FAIL chromium 375 no-preference error: locator.scrollIntoViewIfNeeded: Timeout 5000ms exceeded.
FAIL chromium 1280 reduce pageerror: Cannot read properties of null (reading 'addEventListener')
FAIL chromium 1280 reduce 히어로 animationsPaused=false
FAIL webkit 1280 no-preference pageerror: null is not an object (evaluating 'runBtn.addEventListener')
FAIL webkit 1280 no-preference story 0.5 panel=rp-panel is-s0 stageTop=0
FAIL webkit 1280 no-preference story 0.85 panel=rp-panel is-s0 stageTop=0
FAIL webkit 1280 no-preference error: locator.scrollIntoViewIfNeeded: Timeout 5000ms exceeded.
FAIL webkit 375 no-preference pageerror: null is not an object (evaluating 'runBtn.addEventListener')
FAIL webkit 375 no-preference story 0.5 panel=rp-panel is-s0 stageTop=0
FAIL webkit 375 no-preference story 0.85 panel=rp-panel is-s0 stageTop=0
FAIL webkit 375 no-preference error: locator.scrollIntoViewIfNeeded: Timeout 5000ms exceeded.
FAIL webkit 1280 reduce pageerror: null is not an object (evaluating 'runBtn.addEventListener')
FAIL webkit 1280 reduce 히어로 animationsPaused=false
FAIL behave
```

BEHAVE_BASE=OK
BEHAVE_NEG=OK
