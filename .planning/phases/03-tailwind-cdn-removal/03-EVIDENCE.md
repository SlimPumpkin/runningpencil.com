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

## 03-04 커밋 ③

C3_SHA=c49e12a50394

- 기록 시각: 2026-11-16. 사이트 커밋 ③(D-20): `_layouts/legal.html`에서 Tailwind Play CDN `<script>` 한 줄과 `tailwind-config` 설정 블록(15줄)만 지웠습니다(16줄 삭제, 더한 줄 없음). theme-color meta 다음 줄이 0열 head-links include, 그다음 줄이 `<style>`입니다(RESEARCH 488-494행 모양). 법적 페이지는 이제 「공통」 CSS와 `legal.css`만으로 그려집니다.
- 절차: 레이아웃만 스테이징해 브랜치에 붙지 않는 후보 커밋(`4cd7d8955092`)을 만들고, 그 후보로 check-site·빌드(`$W/c3`)·HTML 소스 Tailwind 0건·랜딩 동일·파일 목록 동일·캡처(`$W/cap/c3`, 4105)·`--no-cdn` 판정을 모두 통과시킨 뒤 같은 인덱스를 커밋했습니다. 커밋 ③의 트리는 `$W/c3/TREE`와 같습니다. CDN이 없는 캡처라 찍기 전 CDN 리디렉션 확인은 하지 않았습니다(scratch_contract).
- `diff -r "$W/c2/site" "$W/c3/site"`는 세 법적 문서에서 지운 16줄씩(script·설정 블록)만 나왔고 더해진 줄은 0이었습니다(① 미리보기 `c1p`와 같은 변경).
- D-18 HTML 소스: `grep -rlF -e cdn.tailwindcss.com -e tailwind.config --include=*.html`이 `$W/c3/site`에서 0개 파일, 대조로 기준 `$W/base/site`에서 3개 파일(`/privacy-policy/index.html /terms/index.html /data-deletion/index.html`)을 찾았습니다. D-18 네트워크는 아래 `report.mjs --no-cdn`의 `PASS 18 rows`(18행 모두 Tailwind 요청 0건·HTML에 CDN 없음)가 확인합니다.
- check-site는 후보와 커밋 ③ 모두 통과했습니다(아직 4항목 판). 아래 첫 줄은 커밋 뒤 커밋 ③ 시점의 스크립트로 커밋 ③을 다시 돌린 결과이고, 후보로 돌린 결과는 `check-site: 통과 (커밋 4cd7d8955092, jekyll 3.10.0)`였습니다.

```
check-site: 통과 (커밋 c49e12a50394, jekyll 3.10.0)
OK site tailwind=0
OK base tailwind=3
OK landing index.html same
OK file list same
```

`judge.sh c3 --no-cdn` (base1 대비):

```
COUNT base1 png=42 state=24 txt=18
COUNT c3 png=42 state=24 txt=18
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
STATES c3 ok=24 vacuous=0
PASS 18 rows
JUDGE c3 OK
```

C3_PIXEL=OK

## 03-04 check-site 5번 항목

CHECK5_SHA=69f46942bec6

- 기록 시각: 2026-11-16. 커밋 ③ 뒤의 별도 커밋으로 `scripts/check-site.sh`에 5번 항목 「Tailwind Play CDN 없음」을 더했습니다(RESEARCH 533-538행 원안 그대로). 머리 주석은 「다섯 가지를 확인한다」와 5번 줄을 더했고, 4번 항목(Liquid)의 번호는 그대로입니다. bash 3.2 문법 확인(`/bin/bash -n`) 통과, 연관 배열·mapfile 없음.
- 절차: 점검 스크립트만 스테이징해 후보 커밋(`96b8e62a651b`)을 만들고 아래 (a)~(e)를 통과시킨 뒤 같은 인덱스를 커밋했습니다. 점검 커밋의 트리는 `$W/ck5/TREE`와 같습니다.
- (a) 새 스크립트로 후보 점검: 통과. 아래 첫 줄은 커밋 뒤 점검 커밋 시점의 스크립트로 점검 커밋을 다시 돌린 결과이고, 후보로 돌린 결과는 `check-site: 통과 (커밋 96b8e62a651b, jekyll 3.10.0)`였습니다.
- (b) 음성 대조: 같은 새 스크립트로 커밋 ②(아직 CDN이 있음)를 점검하면 Tailwind 메시지와 세 법적 문서 경로를 내고 1로 끝납니다(아래 「음성 대조 (b)」 블록, 첫 줄은 실행한 명령).
- (c) 사이트 출력 불변: `build ck5 <후보>` 뒤 `diff -r "$W/c3/site" "$W/ck5/site"`가 빈 출력입니다(`scripts/`는 exclude).
- (d) 훅 경로: `git fetch -q origin main` 뒤 `refs/heads/main <후보> refs/heads/main <origin/main>` 한 줄을 `.githooks/pre-push`에 넣어 돌렸고 통과했습니다(훅은 작업 트리의 새 스크립트를 부름).
- (e) `.githooks/pre-push`는 `BASE_SHA`와 같습니다(고치지 않음).

```
check-site: 통과 (커밋 69f46942bec6, jekyll 3.10.0)
check-site: 통과 (커밋 96b8e62a651b, jekyll 3.10.0)
```

음성 대조 (b):

```
check-site.sh 31327b684f43
check-site: Tailwind Play CDN이 출력에 남아 있습니다: /privacy-policy/index.html
/terms/index.html
/data-deletion/index.html
check-site: 실패 — 1건 (커밋 31327b684f43)
exit=1
```

훅 경로 (d):

```
check-site: 통과 (커밋 96b8e62a651b, jekyll 3.10.0)
OK site output unchanged by check5
OK pre-push unchanged
```

CHECK5=OK

## 03-05 시험 본문

- 기록 시각: 2026-11-16. 클래스 없는 시험 본문 `$W/fixtures/sample.html`을 최종 트리(HEAD `50bbda231725`)에 스크래치로만 넣어 빌드했습니다. 두 변형의 빌드 트리는 같습니다(`$W/sample/TREE` = `$W/samplenw/TREE` = HEAD 트리).
- 시험 본문 구성(요소 목록만): front matter `layout: legal`, `title`, `description`, `eyebrow: "SAMPLE"`, `updated`, `noindex: true`. 본문은 클래스 속성 없이 D-04 허용 요소만 씁니다.
  1. `section`: `h2` + `p` + 넓은 표(`figure tabindex="0" aria-label`, 5열, `thead` 머리 행 「수탁자·위탁 업무·처리 항목·보유 기간·국외 이전」, `tbody` 3행) + `aside`. 본문의 첫 `figure`입니다.
  2. `section`: `h2` + 좁은 표(2열, 같은 figure 속성).
  3. `section`: `h2` + `h3` + `ol`(3항목, 첫 항목 안 `ol` 2항목) + `h3` + `ul`(3항목, 첫 항목 안 `ul` 2항목, `strong` 한 곳, `a href="/terms/"` 한 곳).
  4. `section`: `h2` + `dl`(`dt`·`dd` 두 쌍).
  5. 본문 끝 `footer` 한 문장(`.rp-doc`의 바로 아래 자식).
- 넓은 표는 앞 두 열에만 긴 어절을 두어 375px에서 넘치게 했고, 나머지 열의 칸 글은 머리 행 전체보다 짧게 두어 기본 변형에서 머리 행이 접히는 모습이 캡처에 드러나게 했습니다.
- 빌드 방법: context의 시험 본문 빌드 방법(`git archive` HEAD → `src`, `cp "$W/fixtures/sample.html" "$W/<이름>/src/sample/index.html"`, `build`와 같은 jekyll 명령, `TREE` 기록). 줄바꿈 금지 변형은 빌드 전에 `$W/samplenw/src/_includes/css/legal.css`의 `.rp-doc th` 줄에만 `white-space: nowrap;`을 더했습니다. 두 빌드의 `legal.css` 차이는 아래 한 줄입니다.

```
38c38
<         .rp-doc th { font-weight: 700; color: var(--rp-ink); }
---
>         .rp-doc th { font-weight: 700; color: var(--rp-ink); white-space: nowrap; }
```

기본 변형 (sample):

```
serve sample 4107; cd "$W/pw" && node sample.mjs http://127.0.0.1:4107/sample/ "$W/cap/sample"
chromium 375 {"sw":375,"vw":375,"tableFont":"14px","tdBorder":"rgb(228, 224, 214) 1px solid","tableOuter":"0px","th":"700 rgb(43, 43, 43)","h3":"17px 700 rgb(43, 43, 43)","ol":"decimal","olol":"hangul","ulul":"circle","nestedPad":"20px","dd":"0px","dt":"700 rgb(43, 43, 43)","aside":"14px rgb(87, 83, 76) 0px","footer":"1px rgb(228, 224, 214) 16px 14px 20px","siteFooterBorder":"0px 40px","figOverflow":true,"figDisplay":"table"}
chromium 768 {"sw":768,"vw":768,"tableFont":"14px","tdBorder":"rgb(228, 224, 214) 1px solid","tableOuter":"0px","th":"700 rgb(43, 43, 43)","h3":"17px 700 rgb(43, 43, 43)","ol":"decimal","olol":"hangul","ulul":"circle","nestedPad":"20px","dd":"0px","dt":"700 rgb(43, 43, 43)","aside":"14px rgb(87, 83, 76) 0px","footer":"1px rgb(228, 224, 214) 16px 14px 20px","siteFooterBorder":"0px 40px","figOverflow":false,"figDisplay":"table"}
chromium 1280 {"sw":1280,"vw":1280,"tableFont":"14px","tdBorder":"rgb(228, 224, 214) 1px solid","tableOuter":"0px","th":"700 rgb(43, 43, 43)","h3":"17px 700 rgb(43, 43, 43)","ol":"decimal","olol":"hangul","ulul":"circle","nestedPad":"20px","dd":"0px","dt":"700 rgb(43, 43, 43)","aside":"14px rgb(87, 83, 76) 0px","footer":"1px rgb(228, 224, 214) 16px 14px 20px","siteFooterBorder":"0px 64px","figOverflow":false,"figDisplay":"table"}
webkit 375 {"sw":375,"vw":375,"tableFont":"14px","tdBorder":"rgb(228, 224, 214) 1px solid","tableOuter":"0px","th":"700 rgb(43, 43, 43)","h3":"17px 700 rgb(43, 43, 43)","ol":"decimal","olol":"hangul","ulul":"circle","nestedPad":"20px","dd":"0px","dt":"700 rgb(43, 43, 43)","aside":"14px rgb(87, 83, 76) 0px","footer":"1px rgb(228, 224, 214) 16px 14px 20px","siteFooterBorder":"0px 40px","figOverflow":true,"figDisplay":"table"}
webkit 768 {"sw":768,"vw":768,"tableFont":"14px","tdBorder":"rgb(228, 224, 214) 1px solid","tableOuter":"0px","th":"700 rgb(43, 43, 43)","h3":"17px 700 rgb(43, 43, 43)","ol":"decimal","olol":"hangul","ulul":"circle","nestedPad":"20px","dd":"0px","dt":"700 rgb(43, 43, 43)","aside":"14px rgb(87, 83, 76) 0px","footer":"1px rgb(228, 224, 214) 16px 14px 20px","siteFooterBorder":"0px 40px","figOverflow":false,"figDisplay":"table"}
webkit 1280 {"sw":1280,"vw":1280,"tableFont":"14px","tdBorder":"rgb(228, 224, 214) 1px solid","tableOuter":"0px","th":"700 rgb(43, 43, 43)","h3":"17px 700 rgb(43, 43, 43)","ol":"decimal","olol":"hangul","ulul":"circle","nestedPad":"20px","dd":"0px","dt":"700 rgb(43, 43, 43)","aside":"14px rgb(87, 83, 76) 0px","footer":"1px rgb(228, 224, 214) 16px 14px 20px","siteFooterBorder":"0px 64px","figOverflow":false,"figDisplay":"table"}
PASS
exit=0
```

줄바꿈 금지 변형 (samplenw):

```
serve samplenw 4108; cd "$W/pw" && node sample.mjs http://127.0.0.1:4108/sample/ "$W/cap/samplenw"
chromium 375 {"sw":375,"vw":375,"tableFont":"14px","tdBorder":"rgb(228, 224, 214) 1px solid","tableOuter":"0px","th":"700 rgb(43, 43, 43)","h3":"17px 700 rgb(43, 43, 43)","ol":"decimal","olol":"hangul","ulul":"circle","nestedPad":"20px","dd":"0px","dt":"700 rgb(43, 43, 43)","aside":"14px rgb(87, 83, 76) 0px","footer":"1px rgb(228, 224, 214) 16px 14px 20px","siteFooterBorder":"0px 40px","figOverflow":true,"figDisplay":"table"}
chromium 768 {"sw":768,"vw":768,"tableFont":"14px","tdBorder":"rgb(228, 224, 214) 1px solid","tableOuter":"0px","th":"700 rgb(43, 43, 43)","h3":"17px 700 rgb(43, 43, 43)","ol":"decimal","olol":"hangul","ulul":"circle","nestedPad":"20px","dd":"0px","dt":"700 rgb(43, 43, 43)","aside":"14px rgb(87, 83, 76) 0px","footer":"1px rgb(228, 224, 214) 16px 14px 20px","siteFooterBorder":"0px 40px","figOverflow":false,"figDisplay":"table"}
chromium 1280 {"sw":1280,"vw":1280,"tableFont":"14px","tdBorder":"rgb(228, 224, 214) 1px solid","tableOuter":"0px","th":"700 rgb(43, 43, 43)","h3":"17px 700 rgb(43, 43, 43)","ol":"decimal","olol":"hangul","ulul":"circle","nestedPad":"20px","dd":"0px","dt":"700 rgb(43, 43, 43)","aside":"14px rgb(87, 83, 76) 0px","footer":"1px rgb(228, 224, 214) 16px 14px 20px","siteFooterBorder":"0px 64px","figOverflow":false,"figDisplay":"table"}
webkit 375 {"sw":375,"vw":375,"tableFont":"14px","tdBorder":"rgb(228, 224, 214) 1px solid","tableOuter":"0px","th":"700 rgb(43, 43, 43)","h3":"17px 700 rgb(43, 43, 43)","ol":"decimal","olol":"hangul","ulul":"circle","nestedPad":"20px","dd":"0px","dt":"700 rgb(43, 43, 43)","aside":"14px rgb(87, 83, 76) 0px","footer":"1px rgb(228, 224, 214) 16px 14px 20px","siteFooterBorder":"0px 40px","figOverflow":true,"figDisplay":"table"}
webkit 768 {"sw":768,"vw":768,"tableFont":"14px","tdBorder":"rgb(228, 224, 214) 1px solid","tableOuter":"0px","th":"700 rgb(43, 43, 43)","h3":"17px 700 rgb(43, 43, 43)","ol":"decimal","olol":"hangul","ulul":"circle","nestedPad":"20px","dd":"0px","dt":"700 rgb(43, 43, 43)","aside":"14px rgb(87, 83, 76) 0px","footer":"1px rgb(228, 224, 214) 16px 14px 20px","siteFooterBorder":"0px 40px","figOverflow":false,"figDisplay":"table"}
webkit 1280 {"sw":1280,"vw":1280,"tableFont":"14px","tdBorder":"rgb(228, 224, 214) 1px solid","tableOuter":"0px","th":"700 rgb(43, 43, 43)","h3":"17px 700 rgb(43, 43, 43)","ol":"decimal","olol":"hangul","ulul":"circle","nestedPad":"20px","dd":"0px","dt":"700 rgb(43, 43, 43)","aside":"14px rgb(87, 83, 76) 0px","footer":"1px rgb(228, 224, 214) 16px 14px 20px","siteFooterBorder":"0px 64px","figOverflow":false,"figDisplay":"table"}
PASS
exit=0
```

- 캡처 12장(경로는 `$W/cap/sample/`, `$W/cap/samplenw/`): `chromium-375.png`, `chromium-768.png`, `chromium-1280.png`, `webkit-375.png`, `webkit-768.png`, `webkit-1280.png` (변형마다 6장).
- 두 변형의 캡처를 `cmp`로 비교하면 375px 두 장(chromium·webkit)만 다르고 768·1280px 네 장은 바이트가 같습니다. 768px 이상에서는 머리 행이 원래 한 줄이라 줄바꿈 금지가 모양을 바꾸지 않습니다. 기본 변형 375px에서는 「처리 항목」이 두 줄로 접히고, 줄바꿈 금지 변형에서는 한 줄입니다(캡처를 눈으로 확인).
- 캡처 눈 확인(실행자): 글꼴 적용, 375px 넓은 표 오른쪽 가장자리 옅은 그림자, 가. 나. 표지의 마침표, 링크 밑줄이 보입니다. 사용자 승인은 다음 구간에서 받습니다.
- 저장소 밖 확인: `git status --porcelain -- sample`과 `git ls-files -- sample`이 모두 빈 출력입니다.

OK sample not in repo

SAMPLE=OK

## 03-05 시험 본문 승인

- 기록 시각: 2026-11-16. 사용자가 시험 본문 캡처(두 엔진 × 세 폭, 기본과 머리 행 줄바꿈 금지 두 변형)를 보고 `checkpoint:decision`에서 선택지 「nowrap — 승인, 머리 행은 한 줄 (th 줄바꿈 금지)」을 골랐습니다. 이 답은 새 요소 모양(성공 기준 4) 승인과 표 머리 행 줄바꿈 정책 선택이고, 사이트 푸시 승인은 아닙니다(푸시는 03-06에서 따로 승인받음).
- 사용자 답: nowrap

SC4_DECISION=approved
TABLE_WRAP=nowrap

## 03-05 표 머리 행 줄바꿈

NOWRAP_SHA=fb6bdfa40b70

- 기록 시각: 2026-11-16. 사용자 선택(`TABLE_WRAP=nowrap`)대로 `_includes/css/legal.css`의 `.rp-doc th` 한 줄에만 `white-space: nowrap;`을 더한 별도 사이트 커밋입니다(D-19, D-20). 다른 줄과 파일 끝 줄바꿈 없음은 그대로입니다.
- 절차: `legal.css`만 스테이징해 브랜치에 붙지 않는 후보 커밋(`d51648b1fff0`)을 만들고, 그 후보로 아래 (a)~(e)를 모두 통과시킨 뒤 같은 인덱스를 커밋했습니다. 커밋의 트리는 `$W/nw/TREE`와 같습니다. CDN이 없는 캡처라 찍기 전 CDN 리디렉션 확인은 하지 않았습니다(scratch_contract).
- (a) check-site(5항목 판): 후보와 커밋 모두 통과. 아래 첫 줄이 후보, 둘째 줄이 커밋 뒤 커밋을 다시 돌린 결과입니다.
- (b) `build nw <후보>` 성공.
- (c) 랜딩 `index.html`이 기준(`$W/base/site`)과 바이트가 같고 파일 목록도 같습니다. `diff "$W/c3/site/terms/index.html" "$W/nw/site/terms/index.html"`은 아래 CSS 한 줄만 다릅니다(`diff -r "$W/c3/site" "$W/nw/site"`도 세 법적 문서에서 같은 한 줄씩만 다름).
- (d) `serve nw 4106`, `$W/pw`에서 `node capture.mjs http://127.0.0.1:4106 "$W/cap/nw"`(`done 18`), `stop nw`, `"$W/judge.sh" nw --no-cdn`이 아래 출력으로 `JUDGE nw OK`입니다. 세 문서에는 표가 없어 기준과 픽셀 0입니다.
- (e) 시험 본문을 후보로 다시 빌드(`$W/samplec`, 같은 `$W/fixtures/sample.html`, 4107)해 `sample.mjs`가 여섯 조합 모두 MISMATCH 없이 `PASS`, 종료 코드 0입니다. 캡처 6장(`$W/cap/samplec/`)은 Task 1의 줄바꿈 금지 변형 캡처(`$W/cap/samplenw/`)와 `cmp`로 바이트가 모두 같습니다. 사용자가 승인한 모양이 그대로 들어갔습니다.

```
check-site: 통과 (커밋 d51648b1fff0, jekyll 3.10.0)
check-site: 통과 (커밋 fb6bdfa40b70, jekyll 3.10.0)
OK landing index.html same
OK file list same
```

CSS 한 줄 diff (`$W/c3/site/terms/index.html` 대비 `$W/nw/site/terms/index.html`):

```
87c87
<         .rp-doc th { font-weight: 700; color: var(--rp-ink); }
---
>         .rp-doc th { font-weight: 700; color: var(--rp-ink); white-space: nowrap; }
```

`judge.sh nw --no-cdn` (base1 대비):

```
COUNT base1 png=42 state=24 txt=18
COUNT nw png=42 state=24 txt=18
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
STATES nw ok=24 vacuous=0
PASS 18 rows
JUDGE nw OK
```

시험 본문 (후보 빌드 samplec):

```
serve samplec 4107; cd "$W/pw" && node sample.mjs http://127.0.0.1:4107/sample/ "$W/cap/samplec"
PASS
exit=0
OK samplec captures same as samplenw (6/6)
```

NOWRAP_PIXEL=OK

## 03-06 사이트 푸시 후보

SITE_PUSH_CANDIDATE=2ebeca06ca51
SITE_PUSH_PREV=9f715c795830

- 기록 시각: 2026-11-16. D-21의 첫 푸시(사이트 푸시) 후보입니다. 메인 체크아웃에서 `git fetch -q origin main` 뒤 `PREV=origin/main`, `CAND=HEAD`로 두었습니다. 아직 푸시하지 않았고, 푸시는 사용자 승인(Task 2) 뒤에만 합니다.
- 1. 원격 확인: `PREV`(`9f715c795830`)가 `BASE_LIVE`와 같고 `CAND`(`2ebeca06ca51`)의 조상입니다. 다른 곳에서 푸시된 것은 없습니다.
- 2(a). 공개되지 않은 커밋 수 `git rev-list --count "$PREV..$CAND"`: 35.
- 2(b). `.planning/` 밖에서 바뀌는 파일은 정해진 여섯 개뿐입니다: `_includes/css/legal.css`, `_layouts/legal.html`, `data-deletion/index.html`, `privacy-policy/index.html`, `scripts/check-site.sh`, `terms/index.html`.
- 2(c). 범위 안의 사이트 커밋(`.planning/` 밖을 바꾼 커밋, 새 것부터)은 `fb6bdfa40b70`(NOWRAP_SHA), `69f46942bec6`(CHECK5_SHA), `c49e12a50394`(C3_SHA), `31327b684f43`(C2_SHA), `7cd2b6128884`(C1_SHA) 다섯 개이고, EVIDENCE 표식 집합과 같습니다. `CSS_FIX_SHA` 표식은 없습니다.
- 2(d). 마지막 판정 커밋 `LAST`는 `TABLE_WRAP=nowrap`이라 NOWRAP_SHA(`fb6bdfa40b70`)이고, `git diff --quiet "$LAST" "$CAND" -- . ':(exclude).planning'`가 0입니다(후보의 사이트 트리 = 마지막 판정 커밋).
- 2(e). 검토 항목(막는 검사 아님): 범위 diff(`git diff -U0 "$PREV" "$CAND"`)의 더해진 줄에서 로컬 경로 꼴 두 가지(사용자 홈 아래 절대 경로, macOS 임시 폴더의 실제 경로)와 GitHub 토큰 꼴 두 가지를 찾았습니다. 걸린 줄은 21줄이고 모두 `.planning/` 문서입니다. 줄 내용은 Task 2에서 사용자에게만 보여 줍니다. 이 푸시로 이 문서들이 처음 공개됩니다.
  - 실제 로컬 절대 경로 9줄(커밋 `2ae2410a08a5`가 더함): `.planning/phases/02-jekyll-shared-shell-refactor/02-UI-REVIEW.md:76`, `:77`, `:78`, `:79`, `:80`, `:81`, `:82`, `:83`, `:84`.
  - 검사 패턴 이름을 적은 계획·요약 문장 12줄(실제 경로·토큰 값 없음): `.planning/phases/03-tailwind-cdn-removal/03-01-PLAN.md:250`, `03-01-SUMMARY.md:164`, `03-02-PLAN.md:214`, `03-03-PLAN.md:187`, `03-04-PLAN.md:190`, `03-05-PLAN.md:210`, `03-06-PLAN.md:118`, `03-06-PLAN.md:230`, `03-08-PLAN.md:162`, `03-08-PLAN.md:166`, `03-09-PLAN.md:105`, `03-09-PLAN.md:213`. 토큰 꼴에 걸린 줄은 `03-06-PLAN.md:118`과 `03-09-PLAN.md:105` 두 줄뿐이고, 둘 다 패턴 이름만 적은 문장입니다.
- 3. 실제 푸시 경로: `printf 'refs/heads/main %s refs/heads/main %s\n' "$CAND" "$PREV" | .githooks/pre-push`가 아래 줄로 통과하고 0으로 끝났습니다(작업 트리의 5항목 스크립트).

커밋별 판정 요약:

```
C1 JUDGE c1 OK
C1 preview JUDGE c1p OK
C2 JUDGE c2 OK
C3 JUDGE c3 OK (--no-cdn)
CHECK5 negative control FAIL on C2
TABLE_WRAP=nowrap
NOWRAP JUDGE nw OK
OK site files 6
OK site tree = LAST fb6bdfa40b70
check-site: 통과 (커밋 2ebeca06ca51, jekyll 3.10.0)
```

## 03-06 사이트 푸시 라이브 확인

SITE_PUSH_SHA=2ebeca06ca51

- 기록 시각: 2026-11-16. Task 2에서 사용자가 「push」로 답해 `SITE_PUSH_CANDIDATE`(`2ebeca06ca51`) 하나의 푸시를 승인했습니다. 푸시 직전에 `git fetch -q origin main`으로 원격 main이 `SITE_PUSH_PREV`(`9f715c795830`) 그대로인 것을 확인했습니다.
- 푸시: `git push origin "$(git rev-parse 2ebeca06ca51):refs/heads/main"`. pre-push 훅이 아래 줄로 통과했고 원격 main이 `9f715c795830`에서 `2ebeca06ca51`로 나아갔습니다. `--no-verify`와 force push는 쓰지 않았습니다.

```
check-site: 통과 (커밋 2ebeca06ca51, jekyll 3.10.0)
```

배포 완료 확인: `gh api "repos/$SLUG/pages/builds/latest"`를 20초 간격으로 읽어 `.commit`이 푸시한 전체 해시, `.status`가 `built`, `.error.message`가 비어 있을 때 아래 줄을 만들었습니다(세 번째 읽기에서 `building`→`built`).

OK 빌드 2ebeca06ca51 built 2026-11-16T17:21:05Z

HTTP 확인(D-22): 네 경로를 `https://runningpencil.com<경로>?cb=2ebeca06ca51`로 받았습니다. 법적 세 문서는 `cdn.tailwindcss.com`·`tailwind.config`가 있는 줄 수 0, `rp-legal-card` 있음(새 배포가 반영됨)을 함께 봤습니다. 기대 제목은 `scripts/check-site.sh` 15-18행 값입니다.

OK HTTP /privacy-policy/ 200 title=개인정보처리방침 - 러닝펜슬 tailwind=0 new=1
OK HTTP /terms/ 200 title=서비스 이용약관 - 러닝펜슬 tailwind=0 new=1
OK HTTP /data-deletion/ 200 title=데이터 삭제 안내 - 러닝펜슬 tailwind=0 new=1
OK HTTP / 200 title=러닝펜슬 - 달리고 걷는 길이 아트가 됩니다

화면 확인(D-22): `$W/pw`에서 `node capture.mjs https://runningpencil.com "$W/cap/live" "?cb=2ebeca06ca51"`(출력 끝 줄 `done 18`, 종료 0), 이어서 `"$W/judge.sh" live --no-cdn`의 출력 전체입니다. 라이브 세 문서가 Chromium·WebKit × 375·768·1280px에서 base1과 PNG 42장 픽셀 0, txt 18건 동일이고, 네트워크 요청과 HTML에 Tailwind가 없습니다. 운영 빌드(GitHub Pages)와 로컬 빌드의 출력 차이가 화면에 드러나지 않았습니다(RESEARCH A4 확인).

```
COUNT base1 png=42 state=24 txt=18
COUNT live png=42 state=24 txt=18
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
STATES live ok=24 vacuous=0
PASS 18 rows
JUDGE live OK
```

빌드·HTTP·화면 세 확인이 모두 OK라 되돌리기(D-23)는 하지 않았습니다.

LIVE_SITE=OK

## 03-07 원본 맵

DOCS_MAPS_SHA=c7b3b3471f30

- 기록 시각: 2026-11-16. 사이트 라이브 확인(`LIVE_SITE=OK`) 뒤에 쓴 문서 커밋입니다(D-21 ②). `.planning/codebase/`의 `STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md` 세 파일만 담았고, 저장소의 `CLAUDE.md`·`.claude/CLAUDE.md`·`README.md`·`.planning/PROJECT.md`는 바꾸지 않았습니다(03-08과 단계 전환 갱신 몫).
- 세 맵에서 Tailwind 흔적(script 주소·설정 이름) 줄 수 0, legal.css·`--rp-ink`·figure 감싸개 규칙·768px 예외·「점검 항목은 다섯」·「### 법적 본문 작성 규칙」이 모두 있습니다(Task 1 verify 첫 명령 exit 0).
- 생성기 시험: 임시 폴더에 `.claude/CLAUDE.md` 사본을 두고 `generate-claude-md --output <사본>`을 돌렸습니다. stack·conventions·architecture 세 블록 밖(방침 구간, project, skills, workflow, profile)은 저장소 파일과 같고, 사본에 `_includes/css/legal.css`와 `figure tabindex="0"`이 들어갔습니다(Task 1 verify 둘째 명령 exit 0). 수정 전 사본으로 먼저 돌렸을 때도 저장소 파일과 바이트가 같았습니다(기준 확인).

OK generator blocks only

DOCS_MAPS2_SHA=ec66a3ee9ac5

- 둘째 문서 커밋은 `.planning/codebase/`의 `CONCERNS.md`·`STRUCTURE.md`·`TESTING.md`·`INTEGRATIONS.md` 네 파일만 담았습니다. CONCERNS의 Tailwind 부채·렌더 차단 항목은 이 문서를 근거로 해소 표시했고, Pretendard `integrity`·CSP 권고는 남겼습니다(CONTEXT Deferred). 네 맵에서 Tailwind 흔적 줄 수 0, TESTING의 옛 「Tailwind CDN」 표현 0입니다(Task 2 verify exit 0).
