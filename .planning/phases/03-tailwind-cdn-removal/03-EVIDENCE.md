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
- hover·focus 캡처는 처리방침·이용약관 두 문서에서 나옵니다(삭제 안내 본문에는 링크가 없음). 2엔진 × 3폭 × 2문서 × 2상태 = 24장이고, `base2`에서 모두 기본 캡처와 793~852픽셀 달랐습니다.

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

## 03-02 커밋 ①

C1_SHA=7cd2b6128884

- 기록 시각: 2026-11-16. 사이트 커밋 ①(D-20): `_includes/css/legal.css`를 새로 만들고 `_layouts/legal.html`의 「법적 페이지 전용」 묶음을 그리로 옮겨 `<style>` 안에서 include했습니다. 카드 껍데기 클래스는 `rp-legal-wrap`·`rp-legal-card`·`rp-legal-eyebrow`·`rp-legal-title`·`rp-legal-updated`·`rp-doc`으로 바꿨습니다. Tailwind script·설정·본문 클래스는 그대로 남겼습니다.
- 절차: 두 파일만 스테이징해 브랜치에 붙지 않는 후보 커밋(`51be8d327393`)을 만들고, 그 후보로 check-site·CDN 확인·빌드(`$W/c1`)·출력 표식·랜딩 동일·파일 목록 동일·캡처(`$W/cap/c1`, 4102)·판정을 모두 통과시킨 뒤 같은 인덱스를 커밋했습니다. 커밋 ①의 트리는 `$W/c1/TREE`와 같습니다.
- check-site는 후보와 커밋 ① 모두 통과했습니다. 아래 첫 줄은 커밋 뒤 커밋 ①로 다시 돌린 결과이고, 후보로 돌린 결과는 `check-site: 통과 (커밋 51be8d327393, jekyll 3.10.0)`였습니다.

```
check-site: 통과 (커밋 7cd2b6128884, jekyll 3.10.0)
CDN location: /3.4.17
OK marker c1 rp-legal-card tailwind-script
OK landing index.html same
OK file list same
```

`judge.sh c1` (base1 대비):

```
COUNT base1 png=42 state=24 txt=18
COUNT c1 png=42 state=24 txt=18
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
STATES c1 ok=24 vacuous=0
PASS 18 rows
JUDGE c1 OK
```

C1_PIXEL=OK

## 03-02 ③ 미리보기

- 기록 시각: 2026-11-16. Preflight 대체 규칙을 ②·③보다 먼저 확인했습니다(RESEARCH Pitfall 1). 출처는 마지막 사이트 커밋의 빌드입니다(`CSS_FIX_SHA`가 없어 `c1`, 커밋 ①). `$W/c1/site`를 `$W/c1p/site`로 복사하고 `$W/c1/TREE`를 `$W/c1p/TREE`로 옮겼습니다.
- 사본의 법적 세 문서만 두 가지를 고쳤습니다. (a) Tailwind script 한 줄과 `tailwind-config` 설정 블록 삭제(앞 줄바꿈·들여쓰기 포함). (b) 끝 안내의 여는 태그 `<p class="border-t …">`를 `<footer>`로, 그 뒤 첫 `</p>`를 `</footer>`로 치환(커밋 ②와 같은 치환). 세 문서 모두 여는 태그·글·닫는 태그가 각각 다른 줄이라 더해진 줄은 `<footer>`·`</footer>` 줄뿐입니다. 인라인된 `<style>` 블록은 출처와 바이트가 같습니다.
- 사본을 4103에 띄워 `$W/cap/c1p`를 찍고 `judge.sh c1p --no-cdn`으로 판정했습니다. `--no-cdn`은 report 행마다 Tailwind 요청 0건·HTML에 CDN 주소 없음까지 확인합니다. CDN이 없는 캡처라 찍기 전 CDN 리디렉션 확인은 하지 않았습니다(scratch_contract).

```
OK preview c1p tailwind=0 footer-swap=3 other-added=0
OK preview source c1 7cd2b6128884
```

`judge.sh c1p --no-cdn` (base1 대비):

```
COUNT base1 png=42 state=24 txt=18
COUNT c1p png=42 state=24 txt=18
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
STATES c1p ok=24 vacuous=0
PASS 18 rows
JUDGE c1p OK
```

C1_PREVIEW3=OK

## 03-03 커밋 ②

C2_SHA=31327b684f43

- 기록 시각: 2026-11-16. 사이트 커밋 ②(D-20): 세 법적 문서 본문에서 치환 여섯 종으로 클래스를 모두 지웠습니다(`section`·`h2`·`ul`·`a`·`strong`의 클래스 제거, 끝 안내 `p`를 `footer`로). `footer` 안에는 `<p>`를 두지 않고 원래 글·줄바꿈·들여쓰기를 그대로 두었습니다. 문장·front matter·`noindex`·「임시 게시본」·「포인트」 문장은 그대로입니다. Tailwind script·설정은 아직 레이아웃에 남아 있습니다.
- 절차: 세 문서만 스테이징해 브랜치에 붙지 않는 후보 커밋(`a19fc87eb16e`)을 만들고, 그 후보로 check-site·CDN 확인·빌드(`$W/c2`)·출력 표식·랜딩 동일·파일 목록 동일·캡처(`$W/cap/c2`, 4104)·판정을 모두 통과시킨 뒤 같은 인덱스를 커밋했습니다. 커밋 ②의 트리는 `$W/c2/TREE`와 같습니다.
- 문장 비교 기준은 ② 직전 HEAD(`a4858a769d42`, 마지막 사이트 커밋 ① 뒤)의 원본입니다. `OK source text same 3`은 문서마다 태그를 지운 원본 텍스트의 diff가 빈 출력이라는 뜻이고, 렌더 텍스트(`article.innerText` 18건) 동일은 아래 `judge.sh c2`의 `PASS 0 diffs`가 확인합니다(D-17).
- check-site는 후보와 커밋 ② 모두 통과했습니다. 아래 첫 줄은 커밋 뒤 커밋 ② 시점의 스크립트로 커밋 ②를 다시 돌린 결과이고, 후보로 돌린 결과는 `check-site: 통과 (커밋 a19fc87eb16e, jekyll 3.10.0)`였습니다.

```
OK body class=0 0 0
OK source text same 3
OK footer 1 1 1
OK front matter same 3
check-site: 통과 (커밋 31327b684f43, jekyll 3.10.0)
CDN location: /3.4.17
OK marker c2 no-space-y-3 footer tailwind-script
OK landing index.html same
OK file list same
```

`judge.sh c2` (base1 대비):

```
COUNT base1 png=42 state=24 txt=18
COUNT c2 png=42 state=24 txt=18
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
STATES c2 ok=24 vacuous=0
PASS 18 rows
JUDGE c2 OK
```

C2_PIXEL=OK

## 03-03 본문 작성 규칙 확인

- 기록 시각: 2026-11-16. 아래 확인은 모두 커밋 ②(`C2_SHA`)의 내용(`git show`)으로 돌렸습니다. 이 확인에서 저장소 파일은 고치지 않았습니다.
- D-01: `git ls-tree -r --name-only <C2_SHA> -- privacy-policy terms data-deletion`이 세 `index.html`뿐입니다(Markdown 원본 없음).
- D-02 `h2-first`: 본문에서 `<section>` 줄의 바로 다음 줄이 모두 `<h2>`로 시작합니다(어긋난 수 0).
- D-03 `footer-last`: 본문의 마지막 비어 있지 않은 줄이 `</footer>`이고, 최상위(들여쓰기 20칸) 자식은 `section` 여러 개 다음 `footer` 하나입니다. `footer` 안에 `<p`가 없습니다.
- D-04 `elements`: 본문 요소 이름 집합이 허용 목록(`section h2 h3 p ul ol li dl dt dd table thead tbody tr th td figure strong a aside footer`)의 부분 집합입니다(목록 밖 0개).
- 단계 경계: front matter의 `noindex: true` 1줄, 「임시 게시본」 1줄, 「포인트」가 나오는 줄 수가 기준 커밋(`BASE_SHA`)과 같습니다(Phase 4·6·7·8 몫은 그대로).

```
OK contract privacy-policy sections=6 h2-first=ok footer-last=ok elements=a,footer,h2,li,p,section,ul noindex=1 draft=1 point=4
OK contract terms sections=11 h2-first=ok footer-last=ok elements=a,footer,h2,li,p,section,ul noindex=1 draft=1 point=6
OK contract data-deletion sections=3 h2-first=ok footer-last=ok elements=footer,h2,li,p,section,strong,ul noindex=1 draft=1 point=2
```

C2_CONTRACT=OK
