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

## 04-03 문구 커밋

메타 설명·OG 설명에서 포인트·굿즈·코스북 부분만 지우고(D-02), 「세 가지 이유」 3단계 설명 글과 캡션에서 실루엣·「채울 뱃지」 표현을 지운(D-03~D-05) 문구 커밋입니다. `index.html` 네 줄(13·18·234·245행)만 바꾸고, 빈 뱃지 그림은 04-04 몫이라 그대로 둡니다(D-22). 후보 커밋을 `$W/c1`에 운영과 같은 production·`--safe` 빌드로 만들고 `python3 -m http.server`(포트 4203)로 띄워 판정했습니다. 기준 출력은 `$W/base`(BASE_SHA)입니다. 스크래치는 04-02가 만든 것을 그대로 썼습니다(다시 만들지 않음).

CAND1=109741862593

```
check-site: 통과 (커밋 109741862593, jekyll 3.10.0)
HUNKS 10c10 15c15 278c278 289c289
OK words index=0
OK legal same 3
OK files same
```

후보 동작 판정 (`$W/c1`, 포트 4203):

```
OK chromium 1280 no-preference pin=1 badges=7 stickers=6 empty=5
OK chromium 375 no-preference pin=1 badges=7 stickers=6 empty=5
OK chromium 1280 reduce pin=0 badges=7 stickers=6 empty=5
OK webkit 1280 no-preference pin=1 badges=7 stickers=6 empty=5
OK webkit 375 no-preference pin=1 badges=7 stickers=6 empty=5
OK webkit 1280 reduce pin=0 badges=7 stickers=6 empty=5
PASS behave
```

판정을 통과한 같은 인덱스를 커밋했습니다. 커밋 트리는 후보 트리(`$W/c1/TREE`)와 같습니다. 헤더·푸터 include, 레이아웃, 법적 3종, 점검 스크립트는 바뀌지 않았습니다(D-15). 푸시는 빈 뱃지 커밋과 함께 04-05에서 합니다(D-22).

C1_SHA=abdeb52284d6
OK commit files=index.html numstat=4/4
C1_OK=OK

## 04-04 빈 뱃지 커밋

「세 가지 이유」 3단계 뱃지 줄의 빈 뱃지 세 개(고양이 `t-graphite`, 번개 `t-yellow`, 왕관 `t-red`)와 패널 장식 스티커의 빈 뱃지 두 개(4번째 고양이 `t-yellow`, 6번째 왕관 `t-red`)를 받은 뱃지 색으로 바꾸고, 쓰는 곳이 없어진 빈 뱃지 색 규칙 한 줄을 지운(D-06, RESEARCH Open Q1) 빈 뱃지 커밋입니다. `index.html` 여섯 줄(51행 삭제, 241~243·260·262행의 색 토큰)만 바꾸고 뱃지 줄 7개·스티커 6개의 길이·순서·크기·코스 모양·위치는 그대로 둡니다. 후보 커밋을 `$W/c2`에 운영과 같은 production·`--safe` 빌드로 만들고 `python3 -m http.server`(포트 4204)로 띄워 판정했습니다. 비교 기준은 문구 커밋 후보 출력 `$W/c1`입니다. 스크래치는 04-02가 만든 것을 그대로 썼습니다(다시 만들지 않음, 설치 없음).

CAND2=21274178093f

```
check-site: 통과 (커밋 21274178093f, jekyll 3.10.0)
HUNKS 82d81 285,287c284,286 304c303 306c305
OK empty=0
OK hex no-new
OK legal same 3
OK files same
```

후보 동작 판정 (`$W/c2`, 포트 4204). 첫 실행은 chromium 375 기본 문맥 하나에서 jsDelivr 글꼴 파일 요청이 CORS 헤더 없이 막힌 콘솔 오류 2줄로 통과하지 못했습니다. 바뀐 줄과 무관한 외부 CDN 응답이라 같은 후보·같은 서버로 다시 실행했고, 아래가 그 출력 전체입니다(첫 실행 출력은 스크래치 `$W/behave-c2-try1.txt`).

```
OK chromium 1280 no-preference pin=1 badges=7 stickers=6 empty=0
OK chromium 375 no-preference pin=1 badges=7 stickers=6 empty=0
OK chromium 1280 reduce pin=0 badges=7 stickers=6 empty=0
OK webkit 1280 no-preference pin=1 badges=7 stickers=6 empty=0
OK webkit 375 no-preference pin=1 badges=7 stickers=6 empty=0
OK webkit 1280 reduce pin=0 badges=7 stickers=6 empty=0
PASS behave
```

3단계 화면 캡처 (`$W/pw/p4-step3.mjs`, 움직임 줄이기 문맥에서 단계 버튼 「3 뱃지」를 누른 뒤 `#story .rp-stage` 요소 캡처, `$W/cap/c2/<엔진>-<폭>-step3.png`). 네 장을 직접 열어 보았습니다.

```
OK step3 4
REVIEW step3 chromium 1280 OK 뱃지 줄 7개 모두 컬러(노랑·빨강·크라프트·모눈·흑연·노랑·빨강), 회색 없음, 캡션 「보관함 · 받은 뱃지 7」, 스티커 6장 회색 없음(고양이 노랑, 왕관 빨강)
REVIEW step3 chromium 375 OK 뱃지 줄 7개 모두 컬러(일곱째 왕관은 기존대로 둘째 줄로 넘어감), 회색 없음, 캡션 같음, 보이는 스티커 1~4 빨강·크라프트·모눈·노랑으로 서로 다름
REVIEW step3 webkit 1280 OK chromium 1280과 같은 배치·색, 회색 없음, 캡션 같음
REVIEW step3 webkit 375 OK chromium 375와 같은 배치·색, 회색 없음, 보이는 스티커 넷 서로 다름
```

판정을 통과한 같은 인덱스를 커밋했습니다. 커밋 트리는 후보 트리(`$W/c2/TREE`)와 같고, 커밋은 `index.html` 하나·5줄 더함·6줄 지움입니다. 문구 커밋(C1_SHA)과 이 커밋 사이에는 `.planning/`만 바꾼 docs 커밋만 있습니다. 푸시는 문구 커밋과 함께 04-05에서 합니다(D-22).

C2_SHA=f8d66a6469cf
OK commit files=index.html numstat=5/6
C2_OK=OK

## 04-05 첫 푸시 후보

문구 커밋(C1_SHA)과 빈 뱃지 커밋(C2_SHA)을 함께 내보내는 첫 사이트 푸시의 후보입니다(D-21, D-22). 후보는 그때의 로컬 main 끝(HEAD)이고, 이전 원격은 `git fetch -q origin main` 뒤의 `origin/main`입니다. 이전 원격은 BASE_LIVE와 같고 후보의 조상입니다(다른 곳의 푸시 없음).

```
OK prev = BASE_LIVE 0bfe5b210c3c, ancestor of candidate
OK unpublished commits=18
OK site files 1
index.html
OK site commits = C2 C1
f8d66a6469cf
abdeb52284d6
OK site tree = C2
```

커밋별 판정 요약 (04-03·04-04 구간):

```
C1 HUNKS 10c10 15c15 278c278 289c289 PASS behave
C2 HUNKS 82d81 285,287c284,286 304c303 306c305 PASS behave
```

검토 항목(막는 검사 아님): 범위 diff의 더해진 줄에서 로컬 경로 꼴(macOS 홈 폴더, 임시 폴더)과 토큰 꼴을 찾은 결과입니다(검색 꼴은 04-05-PLAN Task 1 action 2번 (e)). 걸린 줄은 모두 누출 검사 규칙이 검색 꼴을 글로 적은 줄이고, 실제 경로나 토큰은 없습니다. 모두 `.planning/phases/04-landing-content-fix/` 아래의 계획·요약 문서입니다. 줄 내용은 승인 단계에서 사용자에게 보여 줍니다.

```
REVIEW hits=23
04-01-PLAN.md:203
04-01-SUMMARY.md:98
04-02-PLAN.md:229
04-02-SUMMARY.md:138
04-03-PLAN.md:178
04-03-SUMMARY.md:143
04-04-PLAN.md:189
04-04-SUMMARY.md:155
04-05-PLAN.md:119
04-05-PLAN.md:231
04-06-PLAN.md:178
04-07-PLAN.md:139
04-07-PLAN.md:143
04-08-PLAN.md:93
04-08-PLAN.md:198
04-09-PLAN.md:189
04-09-PLAN.md:227
04-10-PLAN.md:255
04-11-PLAN.md:165
04-11-PLAN.md:291
04-12-PLAN.md:189
04-12-PLAN.md:193
04-13-PLAN.md:204
```

실제 푸시 경로(`printf 'refs/heads/main <후보> refs/heads/main <이전 원격>\n' | .githooks/pre-push`):

```
check-site: 통과 (커밋 073d33e0e50a, jekyll 3.10.0)
```

PUSH1_CANDIDATE=073d33e0e50a
PUSH1_PREV=0bfe5b210c3c

## 04-05 첫 푸시 라이브 확인

승인: Task 2 `checkpoint:decision`(blocking-human)에서 사용자가 `PUSH1_CANDIDATE=073d33e0e50a`를 이름으로 적은 질문에 **push**로 답했습니다. 이 승인은 이 SHA의 푸시 한 번에만 썼습니다.

푸시 전 확인: 스크래치(`$W/lib.sh`, playwright, `p4-behave.mjs`, `$W/base`, `$W/c2`)가 모두 있고 `$W/base/TREE`·`$W/c2/TREE`가 BASE_SHA·C2_SHA의 트리와 같아 다시 만든 것이 없습니다. `git fetch -q origin main` 뒤 `origin/main`은 PUSH1_PREV(`0bfe5b210c3c`), 로컬 HEAD는 PUSH1_CANDIDATE 그대로였습니다.

푸시는 `git push origin <PUSH1_CANDIDATE 전체 해시>:refs/heads/main`으로 훅을 켠 채 했습니다. 첫 시도는 셸(zsh)이 변수 바로 뒤의 `:r`을 변수 수식자로 읽어 refspec이 깨졌고, git이 원격에 닿기 전에 거부해 아무것도 나가지 않았습니다(원격 그대로 확인). 변수를 중괄호로 감싸 같은 SHA로 다시 푸시했습니다.

```
check-site: 통과 (커밋 073d33e0e50a, jekyll 3.10.0)
0bfe5b2..073d33e  -> main
```

PUSH1_SHA=073d33e0e50a

배포 완료 (`gh api repos/<slug>/pages/builds/latest`, 20초 간격):

```
OK 빌드 073d33e0e50a built 2026-11-17T05:43:06Z
```

라이브 HTTP·바이트 (`https://runningpencil.com<경로>?cb=073d33e0e50a`, 사본 `$W/live1/`). 법적 세 문서의 세 낱말 줄 수는 `$W/c2/site/<경로>/index.html`과 같고(바뀌지 않음, Phase 6~8 몫), 법적 세 문서도 로컬 빌드와 바이트가 같습니다.

```
OK HTTP / 200 title=러닝펜슬 - 달리고 걷는 길이 아트가 됩니다 words=0 badge7=1 empty=0
OK live index bytes = c2
OK HTTP /privacy-policy/ 200 title=개인정보처리방침 - 러닝펜슬 words=6
OK HTTP /terms/ 200 title=서비스 이용약관 - 러닝펜슬 words=6
OK HTTP /data-deletion/ 200 title=데이터 삭제 안내 - 러닝펜슬 words=3
```

라이브 동작 (`node "$W/pw/p4-behave.mjs" https://runningpencil.com '?cb=073d33e0e50a'`, 출력 전체):

```
OK chromium 1280 no-preference pin=1 badges=7 stickers=6 empty=0
OK chromium 375 no-preference pin=1 badges=7 stickers=6 empty=0
OK chromium 1280 reduce pin=0 badges=7 stickers=6 empty=0
OK webkit 1280 no-preference pin=1 badges=7 stickers=6 empty=0
OK webkit 375 no-preference pin=1 badges=7 stickers=6 empty=0
OK webkit 1280 reduce pin=0 badges=7 stickers=6 empty=0
PASS behave
```

LIVE_PUSH1=OK

## 04-06 check-site 6번 항목

첫 푸시의 라이브 확인(`LIVE_PUSH1=OK`)이 통과한 뒤, 푸시 전 점검 `scripts/check-site.sh`에 6번 항목 「랜딩에 출시 범위 밖 기능 이름 없음」을 별도 build 커밋으로 더했습니다(RESEARCH 「check-site.sh에 SC1 점검을 넣을지」 위험 1 (a)). 빌드 출력 `index.html` 한 파일에서 포인트·굿즈·코스북을 찾으면 실패하고, 법적 문서는 보지 않습니다(Phase 6~8 몫). 커밋은 `scripts/check-site.sh` 하나만 담습니다. `.githooks/pre-push`는 고치지 않았습니다. 후보 커밋(`commit-tree`)으로 점검한 뒤 같은 인덱스를 커밋했고, 커밋 트리는 후보 트리(`$W/ck6/TREE`)와 같습니다. 스크래치는 04-02가 만든 것을 그대로 썼습니다(다시 만들지 않음, 설치 없음).

CHECK6_CAND=bf010105a13b
CHECK6_SHA=a02573fe173f

새 스크립트로 후보·문구 커밋 점검 (작업 트리의 새 스크립트):

```
check-site: 통과 (커밋 bf010105a13b, jekyll 3.10.0)
check-site: 통과 (커밋 abdeb52284d6, jekyll 3.10.0)
```

음성 대조 (같은 새 스크립트로 기준 커밋 점검, 종료 코드 1):

```
check-site.sh 0e75e8b88fd2
check-site: 랜딩에 출시 범위 밖 기능 이름이 있습니다: /index.html 2줄 (포인트·굿즈·코스북, U10)
check-site: 실패 — 1건 (커밋 0e75e8b88fd2)
```

출력 불변(`build ck6 <후보>` 뒤 `diff -r "$W/c2/site" "$W/ck6/site"` 빈 출력)과 훅 경로(`git fetch -q origin main` 뒤 `printf 'refs/heads/main <후보> refs/heads/main <origin/main>\n' | .githooks/pre-push`, 이전 원격은 PUSH1_SHA `073d33e0e50a`):

```
OK site output unchanged by check6
check-site: 통과 (커밋 bf010105a13b, jekyll 3.10.0)
OK pre-push unchanged
```

CHECK6=OK

원본 맵 네 개(`CONVENTIONS.md`·`TESTING.md`·`ARCHITECTURE.md`·`STACK.md`)의 다섯 곳에서 점검 항목을 여섯으로 고친 문서 커밋입니다. 커밋은 네 맵만 담고, 커밋 전 작업 트리 점검(`check-site: 통과 (작업 트리, jekyll 3.10.0)`)이 통과했습니다. `.claude/CLAUDE.md` 재생성은 04-07 몫입니다.

DOCS_CHECK6_SHA=f8fa9fb1d48c

## 04-07 CLAUDE.md와 README

DOCS_CLAUDE1_SHA=4b9288d285af

- 기록 시각: 2026-11-17. 첫 푸시의 라이브 확인(`LIVE_PUSH1=OK`, PUSH1_SHA `073d33e0e50a`) 뒤에 만든 문서 커밋이고, 루트 `CLAUDE.md`와 `.claude/CLAUDE.md` 두 파일만 담습니다(D-23). 두 사본의 「이번 마일스톤 방침」 구간은 글자까지 같고, 「포인트·굿즈·코스북 제거」 행의 현재 상태 칸만 「결정됨 (U10). 랜딩은 Phase 4에서 제거됨, 법적 문서 본문에는 남아 있음」으로 바꿨습니다. 다른 행과 적용 단계·이유·출처 칸은 그대로입니다.
- 루트 `CLAUDE.md` Deploy 문단: pre-push 점검 항목 나열 끝에 「랜딩 출력에 포인트·굿즈·코스북이 없음」을 더했습니다. 다른 문장은 그대로입니다.
- 생성기 시험: 방침 행을 고친 뒤 `.claude/CLAUDE.md` 사본을 임시 폴더에 두고 `generate-claude-md --output <임시 사본>`을 돌렸습니다. 방침 구간·project·skills·workflow·profile은 저장소 파일과 같고 stack·conventions·architecture 세 블록의 네 줄(04-06 원본 맵의 점검 6번 항목)만 바뀌었습니다. 그래서 저장소에서 `--output`·`--auto` 없이 같은 명령을 돌렸고, 결과는 시험 사본과 바이트가 같습니다. 커밋 전 `scripts/check-site.sh` 통과(`check-site: 통과 (작업 트리, jekyll 3.10.0)`).

OK generator blocks only
OK regenerated

DOCS_README1_SHA=5b00b906d609

- `README.md` 코드 블록과 `.planning/codebase/STRUCTURE.md` 디렉터리 그림의 `check-site.sh` 주석 끝에 「·랜딩 기능 이름」을 더했습니다(주석 시작 열 그대로). 커밋은 두 파일만 담고, 커밋 전 `scripts/check-site.sh` 통과(`check-site: 통과 (작업 트리, jekyll 3.10.0)`).
- 문서 훑기: 대상은 `CLAUDE.md`, `.claude/CLAUDE.md`, `README.md`와 `.planning/codebase/*.md` 일곱 개(ARCHITECTURE·CONCERNS·CONVENTIONS·INTEGRATIONS·STACK·STRUCTURE·TESTING), 모두 열 개입니다(계획 본문은 원본 맵을 여덟 개로 적었으나 실제 파일은 일곱 개이고 합계 열 개는 같음). 다섯 항목짜리 옛 나열·옛 항목 수 문장(Task 2 verify 첫 grep 정규식), 옛 방침 현재 상태 칸 문구, 로컬 경로(사용자 홈 폴더 꼴과 macOS 임시 폴더 꼴, Task 2 verify 셋째 grep)를 셌고 모두 0줄이라 고침 커밋을 더하지 않았습니다.

OK stale oldlist=0 oldpolicy=0 localpath=0

DOCS1_STALE=OK

## 04-08 문서 푸시 후보

SITE-01 갈래의 문서와 점검 스크립트를 내보내는 문서 푸시의 후보입니다(Phase 3 D-21 원칙: 라이브 확인 뒤 문서 푸시, D-22). 후보는 그때의 로컬 main 끝(HEAD)이고, 이전 원격은 `git fetch -q origin main` 뒤의 `origin/main`입니다. 이전 원격은 PUSH1_SHA와 같고(첫 푸시 뒤 되돌리기 푸시 없음) 후보의 조상입니다(다른 곳의 푸시 없음).

```
OK prev = PUSH1_SHA 073d33e0e50a, ancestor of candidate
OK unpublished commits=12
OK docs files 4
.claude/CLAUDE.md
CLAUDE.md
README.md
scripts/check-site.sh
OK in range CHECK6_SHA a02573fe173f, DOCS_CLAUDE1_SHA 4b9288d285af, DOCS_README1_SHA 5b00b906d609 (DOCS_CHECK6_SHA f8fa9fb1d48c도 범위 안)
```

`.planning/` 밖을 바꾼 커밋은 셋입니다(`git log -- . ':(exclude).planning'`): 점검 6번 항목 `a02573fe173f`, 두 CLAUDE.md `4b9288d285af`, README `5b00b906d609`. 모두 첫 푸시(PUSH1_SHA) 뒤의 커밋이고 이전 원격에는 없습니다.

사이트 출력 불변: 스크래치(`$W/lib.sh`, playwright, `p4-behave.mjs`, `$W/base`)는 모두 있었고 `$W/base/TREE`는 BASE_SHA의 트리와 같아 다시 만들지 않았습니다. 비교 기준 c2는 계획대로 조건과 상관없이 C2_SHA로 새로 빌드했습니다. 그다음 `build p2 <후보>` 뒤 `diff -r "$W/c2/site" "$W/p2/site"`가 빈 출력입니다.

```
REGEN c2 build from f8d66a6469cf
regen OK c2 tree words=0
OK site output unchanged
```

검토 항목(막는 검사 아님): 범위 diff(`.planning/` 포함)의 더해진 줄에서 로컬 경로 꼴(macOS 홈 폴더, 임시 폴더)과 토큰 꼴을 찾은 결과입니다(검색 꼴은 04-08-PLAN Task 1 action 2번 (e)). 걸린 줄이 없습니다. 같은 검사를 첫 푸시 범위에 돌리면 04-05 기록과 같은 23줄이 나와 검사 자체가 동작함을 확인했습니다.

```
REVIEW hits=0
```

실제 푸시 경로(`printf 'refs/heads/main <후보> refs/heads/main <이전 원격>\n' | .githooks/pre-push`, 작업 트리의 6항목 스크립트):

```
check-site: 통과 (커밋 6e46bdcb24e0, jekyll 3.10.0)
```

PUSH2_CANDIDATE=6e46bdcb24e0
PUSH2_PREV=073d33e0e50a

## 04-08 문서 푸시 라이브 확인

승인: Task 2 `checkpoint:decision`(blocking-human)에서 사용자가 `PUSH2_CANDIDATE=6e46bdcb24e0`를 이름으로 적은 질문에 **push**로 답했습니다. 이 승인은 이 SHA의 푸시 한 번에만 썼습니다.

푸시 전 확인: 스크래치(`$W/lib.sh`, playwright, `p4-behave.mjs`, `$W/base`, `$W/c2`의 네 문서)가 모두 있고 `$W/base/TREE`·`$W/c2/TREE`가 BASE_SHA·C2_SHA의 트리와 같아(c2 출력의 세 낱말 0) 다시 만든 것이 없습니다. `git fetch -q origin main` 뒤 `origin/main`은 PUSH2_PREV(`073d33e0e50a`)였습니다.

푸시는 `git push origin "${SHA}:refs/heads/main"`(SHA는 PUSH2_CANDIDATE의 전체 해시)으로 훅을 켠 채 한 번 했습니다. 훅은 이 푸시부터 6항목 점검으로 푸시할 SHA를 점검했습니다.

```
check-site: 통과 (커밋 6e46bdcb24e0, jekyll 3.10.0)
073d33e..6e46bdc  -> main
```

PUSH2_SHA=6e46bdcb24e0

배포 완료 (`gh api repos/<slug>/pages/builds/latest`, 20초 간격):

```
OK 빌드 6e46bdcb24e0 built 2026-11-17T07:27:26Z
```

라이브 HTTP·바이트 (`https://runningpencil.com<경로>?cb=6e46bdcb24e0`, 사본 `$W/live2/`). 기대 제목은 `$W/c2/site/`의 같은 문서 제목이고, 법적 세 문서도 `$W/c2/site/<경로>/index.html`과 바이트가 같습니다(이 푸시는 사이트 출력을 바꾸지 않음).

```
OK HTTP / 200 title=러닝펜슬 - 달리고 걷는 길이 아트가 됩니다
OK HTTP /privacy-policy/ 200 title=개인정보처리방침 - 러닝펜슬
OK HTTP /terms/ 200 title=서비스 이용약관 - 러닝펜슬
OK HTTP /data-deletion/ 200 title=데이터 삭제 안내 - 러닝펜슬
OK live index bytes = c2
```

내부 파일 (`?cb=6e46bdcb24e0`, 첫 요청에서 모두 404, 5xx 재시도 없음):

```
OK 404 /CLAUDE.md
OK 404 /README.md
OK 404 /scripts/check-site.sh
```

LIVE_PUSH2=OK

## (보류 1) 04-09 이미지 파이프라인 시험

캡처 없이 합성 Display P3 이미지로 변환부터 빌드·서빙·두 엔진 표시까지 스크래치에서만 확인했습니다. 저장소와 라이브에는 아무것도 들어가지 않았습니다 (D-21).

스크래치 확인: `$W/lib.sh`, `$W/pw/node_modules/playwright`, `$W/pw/p4-behave.mjs`, `$W/base/site`가 모두 있어 다시 만든 것이 없습니다. 이 계획에서 `$W/img.sh`(`make_webp`, 홈 경로 없음)와 `$W/pw/p4-pipe.mjs`를 새로 썼습니다.

합성 시험 이미지 `$W/img/test/src.png`: 저장소의 `favicon/web-app-manifest-512x512.png`를 폭 1179로 키우고 `F2B134`로 2556 높이까지 채운 뒤 Display P3로 바꿨습니다 (1179×2556, 알파 없음).

```
  profile: Display P3
```

`make_webp "$W/img/test/src.png" test "$W/img/test/out"` (sRGB 변환 확인 → 564·846 축소 → q80 WebP, 둘 다 상한 안이라 q75 재시도 없음):

```
IMG test 564 5036 564x1222 q=80 sha256=6f8fff1fca6ffe5bb90d4900907d0d37829543aea1110685c533246919c942f0
IMG test 846 8038 846x1834 q=80 sha256=ac1d72e663886f58c763934a0049b6c06d86a6ff5910f99279e23a7f79e4b840
```

두 파일 모두 `webpinfo`에서 청크가 `VP8` 하나, `No error detected.`이고 EXIF·XMP·ICCP 청크가 없습니다. 음성 대조로 폭 512인 PNG를 넣으면 `make_webp`가 「원본 폭 512 < 846」으로 1을 내고 파일을 만들지 않았습니다.

OK webp chunks clean

시험 빌드 `$W/pipe/`: `git archive HEAD`(ea4b1165a663)를 풀고 스크래치 원본에만 `images/app/screen-test-{564,846}.webp`와 front matter 없는 `p4-pipe-test.html`(`<img id="t">`, srcset 564w·846w, `sizes="282px"`, width·height 846×1834)을 넣어 `build_src pipe`로 빌드했습니다. 출력의 두 WebP는 `make_webp` 결과와 `cmp`로 바이트가 같고(Jekyll이 그대로 복사), 출력에서 `*.md`·`.*`·`_*` 검색은 빈 출력입니다. `_config.yml`의 exclude에 `images/`가 없어 그대로 나갑니다.

OK pipe build copied

`serve pipe 4205` 뒤 `node "$W/pw/p4-pipe.mjs" http://127.0.0.1:4205` (창 400×900, 콘솔 오류·pageerror 없음). `natural`은 브라우저가 srcset의 폭 설명자로 나눈 고유 크기(846/3, 564/2)라 두 파일 모두 282×611로 나옵니다. 고른 파일 이름은 기록만 합니다:

```
OK pipe chromium dpr=2 screen-test-564.webp natural=282x611
OK pipe chromium dpr=3 screen-test-846.webp natural=282x611
OK pipe webkit dpr=2 screen-test-564.webp natural=282x611
OK pipe webkit dpr=3 screen-test-846.webp natural=282x611
PASS pipe
```

`stop pipe` 뒤 포트 4205가 비었습니다.

`git status --porcelain -- images p4-pipe-test.html`가 빈 출력입니다 (시험 파일은 스크래치에만 있음).

OK repo untouched

HOLD1_PIPE_TRACE=OK

보류 사유: 캡처 대기 (Task 2에서 사용자가 hold로 답함. 다음 실행은 04-09 Task 1부터 다시 합니다)

## 04-09 이미지 파이프라인 시험

두 번째 시도입니다. 앞 시도는 「(보류 1) 04-09 이미지 파이프라인 시험」 구간에 그대로 둡니다. 이번 시도는 캡처 없이 합성 Display P3 이미지로 변환부터 빌드·서빙·두 엔진 표시까지 스크래치에서만 다시 확인했습니다. 저장소와 라이브에는 아무것도 들어가지 않았습니다 (D-21).

스크래치 확인: `$W/lib.sh`, `$W/pw/node_modules/playwright`, `$W/pw/p4-behave.mjs`, `$W/base/site`가 모두 있어 다시 만든 것이 없습니다. `$W/img.sh`(`make_webp`)와 `$W/pw/p4-pipe.mjs`는 앞 시도에서 쓴 것이 남아 있어, 이 계획 context의 사양(sRGB 변환·프로필 확인, 564·846 축소, q80/q75, 크기 상한, `webpinfo` 확인, `IMG` 줄, 임시 폴더 삭제, 홈 경로 없음)과 맞는지 다시 읽고 그대로 썼습니다. 판정은 모두 새로 했습니다.

합성 시험 이미지 `$W/img/test/src.png`(폴더를 지우고 새로 만듦): 저장소의 `favicon/web-app-manifest-512x512.png`를 폭 1179로 키우고 `F2B134`로 2556 높이까지 채운 뒤 Display P3로 바꿨습니다 (1179×2556, 알파 없음).

```
  profile: Display P3
```

`make_webp "$W/img/test/src.png" test "$W/img/test/out"` (sRGB 변환 확인 → 564·846 축소 → q80 WebP, 둘 다 상한 안이라 q75 재시도 없음). 같은 입력이라 앞 시도와 바이트·해시가 같습니다:

```
IMG test 564 5036 564x1222 q=80 sha256=6f8fff1fca6ffe5bb90d4900907d0d37829543aea1110685c533246919c942f0
IMG test 846 8038 846x1834 q=80 sha256=ac1d72e663886f58c763934a0049b6c06d86a6ff5910f99279e23a7f79e4b840
```

두 파일 모두 `webpinfo`에서 청크가 `VP8` 하나, `No error detected.`이고 EXIF·XMP·ICCP 청크가 없습니다. 음성 대조로 폭 512인 PNG를 넣으면 `make_webp`가 「원본 폭 512 < 846」으로 1을 내고 출력 폴더를 만들지 않았습니다.

OK webp chunks clean

시험 빌드 `$W/pipe/`(지우고 새로 만듦): `git archive HEAD`(61b9e7d1a17c)를 풀고 스크래치 원본에만 `images/app/screen-test-{564,846}.webp`와 front matter 없는 `p4-pipe-test.html`(`<img id="t">`, `src`는 564w, srcset 564w·846w, `sizes="282px"`, width·height 846×1834, `alt="test"`)을 넣어 `build_src pipe`로 빌드했습니다. 출력의 두 WebP는 `make_webp` 결과와 `cmp`로 바이트가 같고(Jekyll이 그대로 복사), 출력에서 `*.md`·`.*`·`_*` 검색은 빈 출력입니다. `_config.yml`의 exclude에 `images/`가 없어 그대로 나갑니다.

OK pipe build copied

`serve pipe 4205` 뒤 `node "$W/pw/p4-pipe.mjs" http://127.0.0.1:4205` (창 400×900, 콘솔 오류·pageerror 없음). `natural`은 브라우저가 srcset의 폭 설명자로 나눈 고유 크기(846/3, 564/2)라 두 파일 모두 282×611로 나옵니다. 고른 파일 이름은 기록만 합니다:

```
OK pipe chromium dpr=2 screen-test-564.webp natural=282x611
OK pipe chromium dpr=3 screen-test-846.webp natural=282x611
OK pipe webkit dpr=2 screen-test-564.webp natural=282x611
OK pipe webkit dpr=3 screen-test-846.webp natural=282x611
PASS pipe
```

`stop pipe` 뒤 포트 4205가 비었습니다.

`git status --porcelain -- images p4-pipe-test.html`가 빈 출력입니다 (시험 파일은 스크래치에만 있음).

OK repo untouched

PIPE_TRACE=OK

## 04-09 캡처 검토와 변환

Task 2에서 사용자가 캡처 세 장을 넘겼고, 시험 계정과 시험 경로로 찍었다고 확인했습니다. 세 파일은 모두 PNG이고, 장 순서대로 스크래치 사본 `$W/captures/{draw,run,badge}.png`로만 씁니다. 원래 위치는 적지 않습니다. `git ls-files -- '*.png'`는 `favicon/` 밖 파일을 내지 않습니다.

CAPTURES_RECEIVED=3

기계 확인 (`sips -g pixelWidth -g pixelHeight -g profile`). 세 장 모두 같은 크기이고 폭이 846 이상입니다:

```
draw  pixelWidth: 1260  pixelHeight: 2736  profile: sRGB IEC61966-2.1
run   pixelWidth: 1260  pixelHeight: 2736  profile: sRGB IEC61966-2.1
badge pixelWidth: 1260  pixelHeight: 2736  profile: sRGB IEC61966-2.1
```

OK device 3 same 1260x2736

세 장을 Read 도구로 직접 열어 항목별로 판정했습니다. 앞 실행이 먼저 검토했고, 이번 실행이 세 장을 다시 열어 모든 줄에 동의했습니다. 걸린 항목은 셋입니다. badge `logo`는 FAIL이었고, run `status`와 badge `status`는 판단이 필요했습니다. 사용자가 2026-11-18에 오케스트레이터에게서 NAVER 지도 SDK 가이드 문장(`04-RESEARCH.md` Q3)과 위험을 듣고 다시 확인한 뒤, 세 장을 그대로 쓰기로 했습니다. 그래서 세 항목은 원래 판정을 `ORIG_` 줄로 남기고, 바로 다음 줄에 사용자 예외 판정을 적습니다. 결정 내용은 `04-CONTEXT.md` D-18·D-20의 「캡처 검토 뒤 사용자 결정 (2026-11-18, 04-09 Task 3)」에 있습니다.

```
REVIEW draw device OK 세 장 모두 1260x2736, 폭 846 이상
REVIEW draw tabs OK 아래는 되돌리기·닫기·완료 편집 막대이고 하단 탭 없음
REVIEW draw scope OK 포인트·굿즈·코스북 화면과 문구 없음
REVIEW draw dev OK 제목은 「코스 그리기」, Dev 표시 없음
REVIEW draw pii OK 실명·이메일·전화번호·프로필 사진·계정 이름 없음. 위치는 사용자의 시험 경로 확인에 근거함
REVIEW draw search OK 검색 아이콘만 있고 장소 검색 결과 목록 없음
REVIEW draw logo OK 지도 왼쪽 아래 NAVER 로고가 온전히 보임
REVIEW draw content OK 지도 위 번호 점들이 선으로 이어진 에디터, 위에 거리와 예상 시간
REVIEW draw status OK 상태 표시줄 보임(시계·무음 표시·Wi-Fi·배터리)
REVIEW run device OK 세 장 모두 1260x2736
REVIEW run tabs OK 아래는 진행 정보와 종료 버튼이고 하단 탭 없음
REVIEW run scope OK 포인트·굿즈·코스북 화면과 문구 없음
REVIEW run dev OK Dev 표시 없음
REVIEW run pii OK 실명·이메일·전화번호·프로필 사진·계정 이름 없음. 위치는 사용자의 시험 경로 확인에 근거함
REVIEW run search N/A draw만 해당
REVIEW run logo OK 지도 왼쪽 아래 NAVER 로고가 온전히 보임
REVIEW run content OK 진행률·움직인 시간·거리·평균 페이스가 보임
ORIG_REVIEW run status FAIL 판단 필요: 시계 옆 아이콘이 위치 화살표라 draw·badge의 무음 표시와 다름
REVIEW run status OK 사용자 예외(D-18, 2026-11-18): 시계 옆 아이콘이 위치 화살표라 draw·badge의 무음 표시와 다름, 그대로 사용
REVIEW badge device OK 세 장 모두 1260x2736
REVIEW badge tabs OK 아래는 결과 수치와 닫기 버튼이고 하단 탭 없음
REVIEW badge scope OK 포인트·굿즈·코스북 화면과 문구 없음
REVIEW badge dev OK Dev 표시 없음
REVIEW badge pii OK 실명·이메일·전화번호·프로필 사진·계정 이름 없음. 화면 제목과 창 문구는 코스 이름
REVIEW badge search N/A draw만 해당
ORIG_REVIEW badge logo FAIL 뱃지 창이 NAVER 로고 오른쪽을 덮고 로고가 어두운 막 아래에 있음(앞 세 글자만 보임)
REVIEW badge logo OK 사용자 예외(D-20, 2026-11-18): 원본에서 앱의 뱃지 창이 NAVER 로고 오른쪽을 덮고 로고가 어두운 막 아래에 있음(앞 세 글자만 보임), 우리가 더 자르거나 덮지 않고 그대로 사용
REVIEW badge content OK 완주 결과(총 시간·움직인 시간·거리·평균 페이스) 위에 뱃지를 받았다는 창
ORIG_REVIEW badge status FAIL 판단 필요: 상태 표시줄이 어두운 막 아래라 다른 두 장과 색이 다름
REVIEW badge status OK 사용자 예외(D-18, 2026-11-18): 상태 표시줄이 어두운 막 아래라 다른 두 장과 색이 다름, 그대로 사용
```

CAPTURE_WAIVERS=3

```
WAIVER badge logo D-20 원본에서 앱의 뱃지 창이 NAVER 로고를 덮은 장면을 그대로 씀. 우리가 더 자르거나 덮지 않는 조건은 지킴. 04-10은 badge에 대해 테두리·둥근 모서리가 로고 쪽을 원본보다 더 깎지 않는지만 판정함. 앱에서 로고나 뱃지 창 위치를 고치면 badge만 다시 찍어 교체함
WAIVER run status D-18 시계 옆 아이콘(위치 화살표)이 다른 두 장(무음 표시)과 다른 것을 허용함. 한 기기·같은 픽셀 크기 조건은 그대로임
WAIVER badge status D-18 상태 표시줄이 뱃지 창 뒤 어두운 막 아래에 있어 색이 다른 것을 허용함. 배터리 양 차이도 허용함
```

NAVER 로고 위치 (04-10의 구간 화면 검토가 이 위치를 봅니다. 원본 좌표):

```
LOGO draw 지도 영역 왼쪽 아래, 축척 막대 왼쪽 (원본 약 y 2340~2390)
LOGO run 지도 영역 왼쪽 아래, 축척 막대 왼쪽 (원본 약 y 1885~1930)
LOGO badge 지도 영역 왼쪽 아래, 원본에서 오른쪽이 앱의 뱃지 창에 덮임(앞 세 글자만 보임, 사용자 예외 D-20) (원본 약 y 1510~1550)
```

대체 글 초안 (04-10이 `alt`로 씁니다). 화면에 실제로 보이는 것만 담았고 지명·코스 이름·개인 정보는 넣지 않았습니다. run의 `12'00"/km`에는 큰따옴표가 있어 `alt` 속성에 넣을 때 `&quot;`로 적어야 합니다:

```
ALT draw: 러닝펜슬 앱 화면: 코스 그리기 에디터에서 지도 위 번호 점들이 출발점부터 끝점까지 선으로 이어져 있고, 위에 거리 6.5 km와 걷기·달리기·자전거 예상 시간이 보인다
ALT run: 러닝펜슬 앱 화면: 따라 달리기 중 지도 위 코스 선과 지나온 길, 아래에 진행률 16%와 움직인 시간 16:08, 거리 1.34 km, 평균 페이스 12'00"/km가 보인다
ALT badge: 러닝펜슬 앱 화면: 완주 결과 위에 강아지 모양 코스 뱃지를 받았다는 창이 떠 있다
```

변환: `. "$W/img.sh"` 뒤 `make_webp "$W/captures/<이름>.png" <이름> "$W/img/out"`을 draw·run·badge 순서로 돌렸습니다. 모두 q80으로 상한 안이라 q75 재시도가 없었습니다. 여섯 파일 모두 `webpinfo`에서 청크가 `VP8` 하나, `No error detected.`이고 EXIF·XMP·ICCP 청크가 없습니다. 세 장의 846w 크기는 모두 846x1837입니다.

```
IMG draw 564 81804 564x1224 q=80 sha256=d6c4a2311ae84a9b8870aff16b71cf557f209000554ea2b1f8764565ceb51ca4
IMG draw 846 143790 846x1837 q=80 sha256=4915c3fa29e733a9b36dc2d5131d0cf34ecfcda63c527b90b990408ac6435615
IMG run 564 46654 564x1224 q=80 sha256=180a563775116530db4e134675eb228936440e7a6c5d84a19c839d417412c0a0
IMG run 846 82008 846x1837 q=80 sha256=6996d2b092f17bdab6a9c306a911872fa6b91f14a12cf0f08103473fb307df52
IMG badge 564 27290 564x1224 q=80 sha256=e52ab7e3bafa3e1d2cfcf521667c2389e3cbed8611d6934a7d866a427dee8779
IMG badge 846 45950 846x1837 q=80 sha256=9fe688176edf90fbecd8f76f74f0cfa4baee1d1b163076c8611ce9ff783029a9
```

`git status --porcelain -- images`가 빈 출력입니다 (WebP는 스크래치 `$W/img/out/`에만 있음).

CAPTURE_REVIEW=OK
IMG_OK=OK

## 04-10 스크린샷 구간

「달려 보기」(`#demo`)와 「출시 안내」(`#get`) 사이에 「실제 앱 화면」 구간(`#screens`)을 넣은 후보입니다. 04-09에서 검토·변환한 WebP 여섯 개를 `images/app/`에 넣고, 제목 옆에 히어로와 같은 모양의 「출시 준비 중」 딱지, 흑연 폰 테두리 속 캡처 세 장과 캡션, 구간 아래 「지도 © NAVER Corp.」를 더했습니다(D-10~D-14, D-20). 캡처는 공개되면 지울 수 없으므로(D-19) 이 후보는 커밋하지 않고 브랜치에 붙지 않은 커밋 객체(`git commit-tree`)로만 판정합니다. main에는 04-11에서 사용자가 승인한 뒤에만 들어갑니다. 스크래치는 04-02·04-09가 만든 것을 그대로 썼고(다시 만들지 않음, 설치 없음), 구간 판정 스크립트 `$W/pw/p4-shots.mjs`만 이 계획에서 새로 썼습니다.

새 기준은 실행 시작 HEAD입니다. `build sbase` 뒤 포트 4206에서 기존 동작이 그대로 통과했고, 해시 정착 (k)의 기준값은 두 엔진 모두 ±2px 안입니다.

SHOTS_BASE=273022c3f176

```
OK chromium 1280 no-preference pin=1 badges=7 stickers=6 empty=0
OK chromium 375 no-preference pin=1 badges=7 stickers=6 empty=0
OK chromium 1280 reduce pin=0 badges=7 stickers=6 empty=0
OK webkit 1280 no-preference pin=1 badges=7 stickers=6 empty=0
OK webkit 375 no-preference pin=1 badges=7 stickers=6 empty=0
OK webkit 1280 reduce pin=0 badges=7 stickers=6 empty=0
PASS behave
OK hash chromium top=-0.3
OK hash webkit top=-0.4
PASS shots
```

이미지: `$W/img/out/`의 여섯 파일을 그대로 `images/app/`에 복사했고, sha256이 모두 04-09 `IMG` 줄과 같습니다. `img`의 `width`·`height`는 04-09 `IMG <이름> 846` 줄의 846x1837, `alt`는 04-09 `ALT` 줄의 글(run의 큰따옴표는 `&quot;`)입니다. `sizes`는 `(max-width: 860px) 242px, 282px`입니다.

후보는 `index.html`과 WebP 여섯 개만 스테이징해 `git commit-tree "$(git write-tree)" -p HEAD`로 만들었습니다(`index.html` 38줄 더함·1줄 지움, 지운 줄은 `.rp-get` 주석). 후보를 `$W/c3`에 운영과 같은 production·`--safe` 빌드로 만들고 포트 4207에서 판정했습니다.

CAND3=56fd3bb79160

```
check-site: 통과 (커밋 56fd3bb79160, jekyll 3.10.0)
```

구간 판정 `node "$W/pw/p4-shots.mjs" <포트 4207> "$W/cap/c3"` (Chromium·WebKit × 1280×800·375×812, deviceScaleFactor 1, 판정 (a)~(l)). 첫 실행에서 모두 통과해 CSS를 고치지 않았습니다. 375px 띠는 → 키 한 번에 276px 밀렸고, 끝까지 민 뒤 마지막 장 오른쪽 여백이 20px입니다(A8: 두 엔진 모두 끝 `padding`이 스크롤 범위에 들어감). `credit-gap`은 출처 줄 아래 끝과 `#get` 위 끝 사이 거리입니다:

```
OK hash chromium top=-0.4
OK shots chromium 1280 imgs=3 credit-gap=38.4 src=564,564,564
OK strip chromium 375 arrow=0->276 end-gap=20
OK shots chromium 375 imgs=3 credit-gap=28 src=564,564,564
OK hash webkit top=0.5
OK shots webkit 1280 imgs=3 credit-gap=38.4 src=564,564,564
OK strip webkit 375 arrow=0->276 end-gap=20
OK shots webkit 375 imgs=3 credit-gap=28 src=564,564,564
PASS shots
```

후보 동작 판정 (`$W/c3`, 포트 4207, 성공 기준 3). 문맥 여섯 줄 모두 `badges=7 stickers=6 empty=0`입니다:

```
OK chromium 1280 no-preference pin=1 badges=7 stickers=6 empty=0
OK chromium 375 no-preference pin=1 badges=7 stickers=6 empty=0
OK chromium 1280 reduce pin=0 badges=7 stickers=6 empty=0
OK webkit 1280 no-preference pin=1 badges=7 stickers=6 empty=0
OK webkit 375 no-preference pin=1 badges=7 stickers=6 empty=0
OK webkit 1280 reduce pin=0 badges=7 stickers=6 empty=0
PASS behave
```

의도한 줄만 바뀜 (부모 = HEAD = `SHOTS_BASE`, 인덱스 기준): `index.html`에서 지운 줄은 `.rp-get` 주석 한 줄이고, 두 `<script>` 블록은 바이트가 같고, 새 hex가 없습니다(`#FAFAF7`·`#1F1B13`·`#2B2B2B`·`#57534C`는 원래 있던 값). 법적 3종 출력은 `$W/sbase/site`와 같고, 출력 파일 목록은 기준 목록에 `images/app/` 여섯 파일을 더한 것과 같습니다. `_includes`·`_layouts`·법적 3종·`scripts`는 그대로입니다(D-15):

```
OK index deleted=1
OK script blocks same
OK hex no-new
OK legal same 3
OK files = sbase + 6 webp
OK includes untouched
```

구간 화면 검토: `$W/cap/c3/`의 `*-screens.png` 넷, `*-seam.png` 넷, `*-375-end.png` 둘을 Read 도구로 직접 열어 보았습니다. NAVER 로고는 draw·run에서 지도 왼쪽 아래(캡처 높이의 약 86%·69% 지점), badge에서 지도 왼쪽 아래(약 55% 지점)라 그림의 둥근 모서리(37px)에서 멀어 깎이지 않습니다. 그래서 그림 반경을 줄이지 않았습니다. badge 로고는 원본에서 앱의 뱃지 창이 오른쪽을 덮은 상태(사용자 예외 D-20)이고, 테두리·둥근 모서리가 원본보다 더 깎은 곳은 없습니다:

```
REVIEW shots chromium 1280 OK 세 장이 한 줄에 테두리 안 잘림 없이 보임, draw·run NAVER 로고 온전, badge 로고는 원본(D-20 예외)보다 더 깎이지 않음, 딱지는 제목 옆이고 캡션은 테두리 아래라 캡처 위 겹침 없음, 오른쪽 아래 출처 줄 보임, 구간 아래 둥근 모서리 사이로 노랑이 들어감(seam)
REVIEW shots webkit 1280 OK chromium 1280과 같은 배치, 로고·딱지·캡션·출처·맞물림 같음
REVIEW shots chromium 375 OK 첫 장 draw가 테두리 안 잘림 없이 보이고 다음 장이 오른쪽에 조금 보임, draw NAVER 로고 온전, 끝까지 민 화면(end)에서 badge가 온전히 보이고 오른쪽 여백이 남음, 출처 줄 보임, 노랑 맞물림 보임(seam)
REVIEW shots webkit 375 OK chromium 375와 같은 배치, end에서 badge 로고는 원본(D-20 예외)보다 더 깎이지 않음, 출처·맞물림 같음
```

후보 확정 (커밋하지 않음): 후보 트리는 판정한 빌드(`$W/c3/TREE`)와 같고, 부모는 `SHOTS_BASE`, 바뀐 파일은 WebP 여섯 개와 `index.html`이며, `git for-each-ref --contains`가 빈 출력입니다(어떤 브랜치·태그·원격 추적 ref에도 없음). `git commit`·`git branch`·`git tag`·`git update-ref`·`git merge`는 쓰지 않았습니다:

```
OK candidate tree = c3
OK candidate parent = SHOTS_BASE
OK candidate files 7
OK candidate on no ref
```

작업 트리와 인덱스 되돌림: `git restore --staged --worktree -- index.html`, `git restore --staged -- images`, `rm -rf images` 뒤 사이트 파일 변경·스테이징·추적되지 않은 파일이 없고 `images/`가 없습니다. 후보의 파일은 `CAND3` 객체와 스크래치(`$W/img/out/`, `$W/c3/src/`)에만 있습니다:

```
OK worktree restored
```

SHOTS_OK=OK

해시 정착 (k) 다시 재기: 위 구간 판정의 `OK hash` 줄은 같은 페이지에서 `/`를 판정한 뒤 `#get`으로 옮긴 것이라 문서를 새로 열지 않았습니다(이미지가 이미 받아진 상태). 그래서 `serve c3 4207` 뒤 `node "$W/pw/p4-shots.mjs" <포트 4207> "$W/cap/c3-hash" '' --hash-only`로 새 문맥에서 `/#get`을 바로 열어 다시 쟀습니다. 두 엔진 모두 ±2px 안이고 기준(chromium -0.3, webkit -0.4)과 같은 수준입니다. 판정 뒤 `stop c3`로 포트 4207을 비웠습니다:

```
OK hash chromium top=-0.4
OK hash webkit top=0.5
PASS shots
```

## 04-11 스크린샷 푸시 후보

04-10에서 판정한 후보(`CAND3`)와 사이트 트리가 같은 스크린샷 구간 커밋(C3)을 실행 시작 HEAD 위에 브랜치에 붙지 않은 커밋 객체로 만든 후보입니다(D-19, D-22). 캡처를 담은 커밋은 Task 2에서 사용자가 이 SHA를 승인하기 전에는 어떤 브랜치·태그에도 두지 않습니다.

스크래치 확인: `$W/lib.sh`, `$W/pw/node_modules/playwright`, `$W/pw/p4-behave.mjs`, `$W/base/site`, `$W/pw/p4-shots.mjs`, `$W/c3/site/index.html`, `$W/c3/src/images/app/`의 WebP 여섯 개, `$W/cap/c3/`의 구간 화면 열 장이 모두 있고 `$W/c3/TREE`가 `CAND3`의 트리와 같아 다시 만든 것이 없습니다.

이전 원격과 기준: `git fetch -q origin main` 뒤 `origin/main`은 `6e46bdcb24e0`(PUSH2_SHA, 그 뒤 다른 곳의 푸시 없음)이고 HEAD(`61bd06a7f90f`)의 조상입니다. HEAD의 사이트 트리는 `SHOTS_BASE`와 같습니다(04-10 뒤 사이트 커밋 없음).

```
OK prev 6e46bdcb24e0 ancestor of HEAD
OK base unchanged since SHOTS_BASE
```

커밋 객체: 임시 인덱스(`$W/c3/push.index`)에 HEAD 트리를 읽고 `CAND3`의 `index.html`·`images/`를 덮어 트리를 지은 뒤 `git commit-tree <트리> -p HEAD -F "$W/c3/msg"`로 만들었습니다. 임시 인덱스는 지웠습니다. 작업 트리와 실제 인덱스는 건드리지 않았고, `git commit`·`git branch`·`git tag`·`git update-ref`·`git merge`는 쓰지 않았습니다. 제목은 `feat(04-11): 랜딩에 실제 앱 화면 구간 추가 (캡처 세 장, 출시 준비 중 딱지, 지도 출처)`입니다.

```
OK site tree = CAND3
OK c3 files 7
OK c3 parent = HEAD
OK c3 on no ref
OK worktree untouched
```

푸시 범위 (`PUSH3_PREV..C3`): 공개되지 않은 커밋은 C3와 그 부모까지의 기록 문서 커밋입니다. 범위의 사이트 커밋은 C3 하나이고, `.planning/` 밖에서 바뀌는 파일은 WebP 여섯 개와 `index.html`입니다:

```
OK unpublished commits=16
OK site commits = C3
95062367dc69
OK site files 7
images/app/screen-badge-564.webp
images/app/screen-badge-846.webp
images/app/screen-draw-564.webp
images/app/screen-draw-846.webp
images/app/screen-run-564.webp
images/app/screen-run-846.webp
index.html
```

04-10 판정 요약:

```
CAND3 PASS shots PASS behave REVIEW shots 4 OK
```

검토 항목(막는 검사 아님): 범위 diff의 더해진 줄에서 로컬 경로 꼴(macOS 홈 폴더, 임시 폴더)과 토큰 꼴을 찾은 결과입니다(검색 꼴은 이 계획 Task 1 action 5번 (d)). 걸린 한 줄은 누출 검사 대상을 글로 적은 줄이고, 실제 경로나 토큰은 없습니다. 줄 내용은 승인 단계에서 사용자에게 보여 줍니다.

```
REVIEW hits=1
04-10-SUMMARY.md:157
```

실제 푸시 경로(`printf 'refs/heads/main <C3> refs/heads/main <이전 원격>\n' | .githooks/pre-push`):

```
check-site: 통과 (커밋 95062367dc69, jekyll 3.10.0)
```

C3_SHA=95062367dc69
PUSH3_CANDIDATE=95062367dc69
PUSH3_PREV=6e46bdcb24e0

## 04-11 스크린샷 푸시 라이브 확인

승인: Task 2 `checkpoint:decision`(blocking-human)에서 사용자가 `PUSH3_CANDIDATE=95062367dc69`를 이름으로 적은 질문에 **push**로 답했습니다. 이 승인은 이 SHA의 푸시 한 번에만 썼습니다.

푸시 전 확인 (`<scratch_regen>`과 action 1번): `$W/lib.sh`, playwright, `p4-behave.mjs`, `$W/base/site`, `p4-shots.mjs`, `$W/c3/site/index.html`, `$W/c3/src/images/app/`의 WebP 여섯 개, `$W/cap/c3/`의 구간 화면 열 장이 모두 있고 `$W/c3/TREE`가 `CAND3`의 트리와 같아 다시 만든 것이 없습니다(`$W/c3/site/images/app/` 여섯 파일의 sha256도 04-09 `IMG` 줄과 같음). `git fetch -q origin main` 뒤 `origin/main`은 PUSH3_PREV(`6e46bdcb24e0`)였고, 로컬 HEAD는 C3의 부모 그대로(그사이 커밋 없음), C3는 어떤 ref에도 없었고 작업 트리에 `images/`가 없었습니다.

```
OK prev = PUSH3_PREV
OK site unchanged since C3^
OK site tree = CAND3
OK c3 on no ref
```

푸시는 `git push origin "${C3}:refs/heads/main"`(C3는 PUSH3_CANDIDATE의 전체 해시)으로 훅을 켠 채 한 번 했습니다. `--no-verify`·force는 쓰지 않았습니다.

```
check-site: 통과 (커밋 95062367dc69, jekyll 3.10.0)
6e46bdc..9506236  -> main
```

PUSH3_SHA=95062367dc69

로컬 main에 들이기: 푸시가 성공한 뒤 HEAD가 아직 C3의 부모라 `git merge --ff-only <C3>`로 들였습니다. 작업 트리의 고치지 않은 `.planning/` 파일 두 개(STATE·EVIDENCE)는 그대로입니다. C3가 HEAD의 조상이고, `.planning/` 밖 트리가 C3와 같고, `git status --porcelain -- index.html images`가 빈 출력입니다.

```
OK local main has C3 (ff)
```

배포 완료 (`gh api repos/<slug>/pages/builds/latest`, 20초 간격, 두 번째 읽기에서 built):

```
OK 빌드 95062367dc69 built 2026-11-18T06:41:14Z
```

라이브 HTTP·바이트 (`https://runningpencil.com<경로>?cb=95062367dc69`, 사본 `$W/live3/`). 기대 제목은 `$W/c3/site/`의 같은 문서 제목(= `scripts/check-site.sh`의 기대 제목)이고, 법적 세 문서도 `$W/c3/site/<경로>/index.html`과 바이트가 같습니다:

```
OK HTTP / 200 title=러닝펜슬 - 달리고 걷는 길이 아트가 됩니다
OK HTTP /privacy-policy/ 200 title=개인정보처리방침 - 러닝펜슬
OK HTTP /terms/ 200 title=서비스 이용약관 - 러닝펜슬
OK HTTP /data-deletion/ 200 title=데이터 삭제 안내 - 러닝펜슬
OK live index bytes = c3
```

이미지 (`https://runningpencil.com/images/app/<파일>?cb=95062367dc69`, 사본 `$W/live3/`). 여섯 파일 모두 200이고 `content-type: image/webp`이며 저장소 파일과 `cmp`로 바이트가 같습니다(RESEARCH A10 확인):

```
OK IMG screen-badge-564.webp 200 image/webp same
OK IMG screen-badge-846.webp 200 image/webp same
OK IMG screen-draw-564.webp 200 image/webp same
OK IMG screen-draw-846.webp 200 image/webp same
OK IMG screen-run-564.webp 200 image/webp same
OK IMG screen-run-846.webp 200 image/webp same
```

라이브 구간 판정 `node "$W/pw/p4-shots.mjs" https://runningpencil.com "$W/cap/live3" '?cb=95062367dc69'` (Chromium·WebKit × 1280×800·375×812, 판정 (a)~(l)). 숫자가 04-10 후보 판정과 모두 같습니다:

```
OK hash chromium top=-0.4
OK shots chromium 1280 imgs=3 credit-gap=38.4 src=564,564,564
OK strip chromium 375 arrow=0->276 end-gap=20
OK shots chromium 375 imgs=3 credit-gap=28 src=564,564,564
OK hash webkit top=0.5
OK shots webkit 1280 imgs=3 credit-gap=38.4 src=564,564,564
OK strip webkit 375 arrow=0->276 end-gap=20
OK shots webkit 375 imgs=3 credit-gap=28 src=564,564,564
PASS shots
```

해시 정착 (k)는 04-10과 같은 까닭으로 새 문맥에서 `/#get`을 바로 열어 한 번 더 쟀습니다(`--hash-only`, 캡처 `$W/cap/live3-hash`). 두 엔진 모두 ±2px 안입니다:

```
OK hash chromium top=-0.4
OK hash webkit top=0.5
PASS shots
```

라이브 동작 판정 `node "$W/pw/p4-behave.mjs" https://runningpencil.com '?cb=95062367dc69'` (성공 기준 3):

```
OK chromium 1280 no-preference pin=1 badges=7 stickers=6 empty=0
OK chromium 375 no-preference pin=1 badges=7 stickers=6 empty=0
OK chromium 1280 reduce pin=0 badges=7 stickers=6 empty=0
OK webkit 1280 no-preference pin=1 badges=7 stickers=6 empty=0
OK webkit 375 no-preference pin=1 badges=7 stickers=6 empty=0
OK webkit 1280 reduce pin=0 badges=7 stickers=6 empty=0
PASS behave
```

라이브 구간 화면: `$W/cap/live3/`의 `chromium-1280-screens.png`, `webkit-375-end.png`, `chromium-375-end.png`를 Read 도구로 열어 보았습니다. 1280px에서 제목 옆 「출시 준비 중」 딱지, 폰 테두리 속 세 장과 캡션, 오른쪽 아래 「지도 © NAVER Corp.」, 구간 아래 둥근 모서리 사이 노랑이 보이고, draw·run의 NAVER 로고가 온전합니다. WebKit 375 끝 화면은 badge 장이 온전히 보이고 오른쪽 여백이 남습니다.

기록 정정 (04-10 `REVIEW shots chromium 375` 줄): 그 줄은 「끝까지 민 화면(end)에서 badge가 온전히 보임」이라고 적었지만, Chromium의 `*-375-end.png`(04-10 후보 캡처와 이번 라이브 캡처 둘 다)는 run 장이 띠 가운데에 있고 badge가 보이지 않습니다. 오케스트레이터가 승인 검토 중에 이를 찾아 후보 빌드를 따로 재 보았습니다(커밋하지 않은 확인): Chromium 375×812에서 `scrollLeft = scrollWidth` 뒤 1.5초에 띠는 scrollLeft 477(최댓값)이고 badge 장은 x 95~355로 온전히 보이며, 창 전체 캡처는 그 자리를 유지합니다. 그런데 Playwright의 요소 캡처(`locator('#screens').screenshot()`)가 Chromium에서만 캡처 순간 다시 배치하면서 scrollLeft를 170으로 옮깁니다. → 키 세 번과 가로 휠은 Chromium·WebKit 모두 477에 닿고, WebKit의 요소 캡처는 위치를 옮기지 않습니다. 그래서 사이트 결함이 아니라 Chromium 요소 캡처의 부작용이고, 캡처 전에 잰 `OK strip chromium 375 arrow=0->276 end-gap=20` 줄이 유효한 판정입니다. 판정 도구 `p4-shots.mjs`는 고치지 않았습니다(판정 기준을 이 자리에서 바꾸지 않음). 04-10 검토 줄 자체는 고치지 않고 이 줄로 정정합니다.

```
NOTE chromium 375 end image = element-screenshot artifact (scrollLeft 477 -> 170 at capture), judged by end-gap=20
```

LIVE_PUSH3=OK

## 04-12 문서 (D-24)

DOCS_MAPS2_SHA=fa90e3cb8cd1

- 기록 시각: 2026-11-18. 스크린샷 구간 푸시의 라이브 확인(`LIVE_PUSH3=OK`, PUSH3_SHA `95062367dc69`) 뒤에 만든 문서 커밋이고, 생성기 원본 맵 세 개(`.planning/codebase/CONVENTIONS.md`·`ARCHITECTURE.md`·`STACK.md`)만 담습니다.
- CONVENTIONS: SVG 항목 첫 문장을 「그림(로고·아이콘·지도 그림·코스 선)은 모두 인라인 SVG다」로 좁히고 마지막 문장을 「예외는 랜딩 「실제 앱 화면」 구간의 앱 화면 캡처뿐이고, `images/app/screen-{draw,run,badge}-{564,846}.webp`에 둔다」로 바꿨습니다. 같은 절에 이미지 규칙 항목(sRGB WebP, 메타데이터 없음, 564w·846w `srcset`·`sizes`, `src` 564w, `width`·`height` 846×1837, `loading="lazy"`·`decoding="async"`, `alt`는 보이는 것만, 원본 PNG 비커밋, 캡처 위 겹침 없음, NAVER 로고를 원본보다 더 자르거나 덮지 않음)을 더했습니다. 로고 문구는 04-09 사용자 예외(CONTEXT D-20 덧붙임)에 맞춰 「원본보다 더」로 적었습니다. Naming Patterns에 `rp-shots*` 클래스 여섯 개(스크립트가 쓰지 않음, `.rp-phone` 재사용 안 함)와 앵커 id `screens`를, 반응형 절에 좁은 화면 음수 margin + `scroll-snap` 띠와 `tabindex="0"`·`role="list"`·`aria-label`을 적었습니다.
- ARCHITECTURE: Component 표에 「실제 앱 화면 구간」 행, 랜딩 페이지 행에 `#screens`와 구간 순서(`#demo` → `#screens` → `#get`, `.rp-get` 음수 위 margin이 `#screens`의 둥근 아래 모서리 밑으로 들어감), 「랜딩 전용」 CSS 행에 「앱 화면 띠」, System Overview 로컬 정적 자산에 `images/app/`, Key Characteristics 인라인 SVG 항목에 캡처 WebP 예외를 적었습니다.
- STACK: Languages에 WebP 줄(SVG 줄은 그대로), Platform Requirements Development에 `sips`·`cwebp`·`webpinfo` 줄을 더했습니다.
- 생성기 사본 시험(커밋 전): `.claude/CLAUDE.md` 사본을 저장소 밖 임시 폴더에 두고 `generate-claude-md --output <임시 사본>`을 돌렸습니다. 바뀐 곳은 stack·conventions·architecture 세 블록뿐이고 방침 구간·project·skills·workflow·profile은 그대로입니다. 새 줄(WebP·재생성 도구, `rp-shots*` 클래스, `screens` 앵커, 띠 반응형, SVG 예외와 이미지 규칙, `images/app/` 자산, `#screens` 행, Key Characteristics 예외)이 모두 생성 구간에 들어갔습니다. 생성기는 conventions 블록의 「IDs and data attributes」 머리 뒤 빈 줄 하나도 지웠습니다(생성기 출력 그대로, 손 수정 없음). 저장소의 `.claude/CLAUDE.md`는 Task 3에서 다시 만듭니다. 커밋 전 `scripts/check-site.sh` 통과(`check-site: 통과 (작업 트리, jekyll 3.10.0)`).

OK generator dry-run images/app in conventions

DOCS_MAPS3_SHA=5c6451b2debf

- 생성기가 쓰지 않는 원본 맵 두 개(`STRUCTURE.md`·`INTEGRATIONS.md`)만 담은 문서 커밋입니다. STRUCTURE: 디렉터리 그림에 `favicon/` 줄과 같은 꼴로 `images/` → `app/` 줄, Directory Purposes에 `images/app/` 절(Purpose, Key files `screen-draw-*`·`screen-run-*`·`screen-badge-*.webp`, 원본 PNG 비커밋, `_config.yml` exclude에 넣지 않음), 섹션 앵커 목록에 `screens`를 더했습니다. 계획대로 랜딩 줄 수를 지금 값(586줄 → 622줄)으로 맞췄고, 같은 파일의 `index.html` 구획 행 번호(「랜딩 전용」 CSS, 860px `@media`, `<defs>`, 헤더·히어로·`#story`·`#demo`·`#get`·푸터, 동작 스크립트)도 04-11 구간 추가 뒤 값으로 맞추고 `:411` `#screens`를 더했습니다.
- INTEGRATIONS: 데이터 출처 표기 절에 NAVER 지도 항목(지도 API 호출 없음, 정적 WebP만, 캡처 안 로고 유지, 구간 바로 아래 「지도 © NAVER Corp.」, 공유 푸터에는 넣지 않음, 문구는 약관 지정 문구가 아닌 추정, 제휴 오인 문구 금지 NAVER API 이용약관 7.3 ⑦⑧)을 더했고, File Storage 줄에 `images/app/`을 더했습니다. 「분석·광고·지도 SDK」 줄은 사이트에 SDK가 없다는 뜻이라 그대로 두었습니다. 커밋 전 `scripts/check-site.sh` 통과(`check-site: 통과 (작업 트리, jekyll 3.10.0)`).

DOCS_CLAUDE2_SHA=426174db1045

- 루트 `CLAUDE.md`와 `.claude/CLAUDE.md` 두 파일만 담은 문서 커밋입니다. 방침 구간은 고치지 않았고, 두 사본의 「이번 마일스톤 방침」 구간은 글자까지 같습니다.
- 루트 `CLAUDE.md`: Pages 표 `index.html` 행의 구간 목록에서 달려 보기와 출시 안내 사이에 「실제 앱 화면(`#screens`)」을 넣었습니다. Architecture 인라인 SVG 문단은 첫 문장을 두고 그다음 문장을 「예외는 「실제 앱 화면」 구간의 앱 화면 캡처 WebP(`images/app/`)뿐입니다」로 바꿨습니다. 같은 절에 「실제 앱 화면」 구간 항목(`#demo`와 `#get` 사이, 「출시 준비 중」 딱지, `.rp-shot-frame` 흑연 폰 테두리와 `.rp-phone`을 다시 쓰지 않는 이유, 좁은 화면 `scroll-snap` 띠, `z-index: 1`과 둥근 아래 모서리 밑으로 들어가는 `.rp-get`)을 더했습니다. 푸터 문단 끝 문장은 「캡처 속 네이버 지도의 출처(「지도 © NAVER Corp.」)는 구간 바로 아래에 적고 공유 푸터에는 넣지 않는다」는 내용으로 바꿨습니다. Assets 절에 `images/app/` 항목(세 장의 이름, iPhone 한 기기, 564w·846w)과 재생성 방법(`sips --matchTo` sRGB → `sips --resampleWidth 564`·`846` → `cwebp -q 80 -m 6 -sharp_yuv` → `webpinfo` 메타데이터 청크 없음 확인, 원본 비커밋, 캡처 조건은 `.planning/baseline/USER-TASKS.md` 작업 10)을 더했습니다.
- 생성기 시험: 루트를 고친 뒤 `.claude/CLAUDE.md` 사본을 임시 폴더에 두고 `generate-claude-md --output <임시 사본>`을 돌렸습니다. 바뀐 곳은 Task 1 시험과 같은 stack·conventions·architecture 블록의 열 군데뿐이고, 방침 구간·project·skills·workflow·profile은 저장소 파일과 같았습니다. 그래서 저장소에서 `--output`·`--auto` 없이 같은 명령을 돌렸습니다(12줄 추가, 7줄 삭제, 생성 구간 손 수정 없음). 커밋 전 `scripts/check-site.sh` 통과(`check-site: 통과 (작업 트리, jekyll 3.10.0)`).

OK generator blocks only
OK regenerated

- 문서 훑기: 대상은 `CLAUDE.md`, `.claude/CLAUDE.md`, `README.md`와 `.planning/codebase/*.md` 일곱 개, 모두 열 개입니다. 옛 이미지·지도 문장(Task 3 verify 첫 grep 정규식)과 로컬 경로(사용자 홈 폴더 꼴과 macOS 임시 폴더 꼴)가 모두 0줄이라 고침 커밋을 더하지 않았습니다. 더 넓은 낱말로도 훑었고, 남은 한 줄 `CONCERNS.md`의 「외부 이미지 대신 인라인 SVG 사용」은 랜딩 파일 크기의 원인(그림을 인라인 SVG로 둠)을 적은 문장이라 옛 규칙 문장이 아니어서 그대로 두었습니다. 같은 절의 랜딩 크기·줄 수 숫자는 04-11 뒤 값과 다르지만 이 계획의 범위 밖이라 고치지 않았습니다(SUMMARY에 남김).

OK stale image=0 localpath=0

DOCS2_STALE=OK
