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
