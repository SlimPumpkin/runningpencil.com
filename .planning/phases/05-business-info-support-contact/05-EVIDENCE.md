# Phase 5 검증 기록

Phase 5(사업자 정보와 지원 연락 경로)의 계획 05-01~05-15가 남기는 판정 기록입니다. 각 계획의 verify는 이 파일의 표식 줄과 구간을 읽어 다시 판정합니다.

**기록 규칙 (D-02, 공개 저장소)**

- 사업자 값(상호·대표자·사업자등록번호·주소)과 지원 주소를 이 파일에 적지 않습니다.
- 값 대신 행 있음/없음, 건수, 사용자 대조 결과만 적습니다.
- 스크래치 경로는 `$W/…`, 보류 worktree는 `$HOLD_WT`로 적고, 커밋 해시는 12자리로 적습니다. 로컬 홈 경로, 임시 폴더의 실제 경로, IP 주소, 토큰, DNS 인증 값, 계정 이메일을 적지 않습니다.

**표식 줄 규칙**

- 표식 줄은 줄 머리부터 `이름=값`으로 씁니다 (앞에 공백·목록 기호 없음).
- 구간 머리는 `## <계획> <이름>`입니다. 보류한 시도는 구간 머리를 `## (보류 <n>) <계획> …`으로 바꾸고 그 시도의 표식 줄 머리에 `HOLD<n>_`을 붙입니다.

## 05-01 기준

사이트 파일을 고치기 전 HEAD를 기준으로 삼았습니다. 기준과 그때의 원격 main은 `.planning/` 밖 트리가 같습니다(기준이 지금 라이브와 같은 사이트). 스크래치 `$W`는 메인 체크아웃 바로 옆 `<저장소 폴더 이름>-p5-scratch`이고 저장소 작업 트리 밖입니다. 기준 출력은 `$W/base`에 운영과 같은 production·`--safe` 빌드로 만들고 `python3 -m http.server`(포트 4501)로 띄워 확인했습니다. 기준 출력에서 「공통」 CSS의 `.rp-foot-legal` 줄은 `index.html` 57행, 법적 3종 47행이라, 그 뒤에 두 줄을 더하면 diff 머리가 계획 때 잰 `57a58,59`·`47a48,49`가 됩니다.

BASE_SHA=2db88d9a199f
BASE_LIVE=84a5d9114ef3

```
OK scratch beside-repo
check-site: 통과 (커밋 2db88d9a199f, jekyll 3.10.0)
OK HTTP / 200 title=러닝펜슬 - 달리고 걷는 길이 아트가 됩니다
OK HTTP /privacy-policy/ 200 title=개인정보처리방침 - 러닝펜슬
OK HTTP /terms/ 200 title=서비스 이용약관 - 러닝펜슬
OK HTTP /data-deletion/ 200 title=데이터 삭제 안내 - 러닝펜슬
OK base support=absent mailto=0 phone=0 supportlinks=0
OK base foot-legal-css-line index=57 legal=47 47 47
OK site-clean 05-01-t1 2db88d9a199f
```

## 05-01 도구

사용자 결정(Task 2, blocking-human): **install — 브라우저 내려받기 포함**. 범위는 `playwright@1.59.1`·`pngjs@7.0.0`(lockfile의 `playwright-core@1.59.1`·`fsevents@2.3.2` 포함)을 pnpm으로 스크래치 `$W/pw`에만 설치하는 것이고, Phase 5 동안 같은 고정 버전·같은 경로의 재설치와, 캐시에 리비전이 없을 때만 `pnpm --dir "$W/pw" exec playwright install chromium webkit`로 브라우저를 받는 것을 포함합니다.

설치는 Phase 4 스크래치(`rp-p4/pw`)의 `package.json`·`pnpm-lock.yaml`을 `$W/pw`로 복사해 `pnpm --dir "$W/pw" install --frozen-lockfile`(pnpm 10.33.2)로 했습니다. 브라우저 캐시에 두 리비전이 이미 있어 새로 받지 않았습니다. 기준 출력(`$W/base`, 포트 4501)에서 `p5-foot.mjs`는 16줄 모두 통과했고, `p5-support.mjs`는 지원 페이지가 없는 기준에서 `/support/` 404로 실패했습니다(음성 대조).

`p5-foot.mjs`의 split 판정은 `getClientRects()` 상자 수 대신 상자들이 놓인 줄 수(위 끝이 반 줄 넘게 다르면 다른 줄)를 셉니다. Chromium은 상자 없는 inline `span` 안에 링크가 있으면 같은 줄에서도 상자를 조각마다 따로 내서, 상자 수로 세면 끊기지 않은 항목도 split으로 잡혔습니다. 기준 판정 전에 스크래치 시험 페이지(커밋 안 함, 시험 뒤 지움)로 split·badLink·sepLead 측정과 `p5-support.mjs`의 200 경로(`ids=contact,report,faq`, 375 `hdr=0 ftr=1`, 1280 `hdr=1 ftr=1`, `anchor=ok`, `?cb=` 쿼리)가 도는 것을 확인했습니다.

PW_VERSION=1.59.1
PW_BROWSERS=chromium-1217 webkit-2272 chromium_headless_shell-1217

`node "$W/pw/p5-foot.mjs" http://127.0.0.1:4501` (종료 코드 0):

```
OK chromium 375 / rows=3 spans=0 seps=0 links=0 sepLead=0
OK chromium 375 /privacy-policy/ rows=3 spans=0 seps=0 links=0 sepLead=0
OK chromium 375 /terms/ rows=3 spans=0 seps=0 links=0 sepLead=0
OK chromium 375 /data-deletion/ rows=3 spans=0 seps=0 links=0 sepLead=0
OK chromium 1280 / rows=3 spans=0 seps=0 links=0 sepLead=0
OK chromium 1280 /privacy-policy/ rows=3 spans=0 seps=0 links=0 sepLead=0
OK chromium 1280 /terms/ rows=3 spans=0 seps=0 links=0 sepLead=0
OK chromium 1280 /data-deletion/ rows=3 spans=0 seps=0 links=0 sepLead=0
OK webkit 375 / rows=3 spans=0 seps=0 links=0 sepLead=0
OK webkit 375 /privacy-policy/ rows=3 spans=0 seps=0 links=0 sepLead=0
OK webkit 375 /terms/ rows=3 spans=0 seps=0 links=0 sepLead=0
OK webkit 375 /data-deletion/ rows=3 spans=0 seps=0 links=0 sepLead=0
OK webkit 1280 / rows=3 spans=0 seps=0 links=0 sepLead=0
OK webkit 1280 /privacy-policy/ rows=3 spans=0 seps=0 links=0 sepLead=0
OK webkit 1280 /terms/ rows=3 spans=0 seps=0 links=0 sepLead=0
OK webkit 1280 /data-deletion/ rows=3 spans=0 seps=0 links=0 sepLead=0
PASS foot
```

`node "$W/pw/p5-support.mjs" http://127.0.0.1:4501` (종료 코드 4, 실패 4건):

```
FAIL chromium 375 /support/ 404
OK chromium 375 / supportlinks=0
OK chromium 375 /privacy-policy/ supportlinks=0
OK chromium 375 /terms/ supportlinks=0
OK chromium 375 /data-deletion/ supportlinks=0
FAIL chromium 1280 /support/ 404
OK chromium 1280 / supportlinks=0
OK chromium 1280 /privacy-policy/ supportlinks=0
OK chromium 1280 /terms/ supportlinks=0
OK chromium 1280 /data-deletion/ supportlinks=0
FAIL webkit 375 /support/ 404
OK webkit 375 / supportlinks=0
OK webkit 375 /privacy-policy/ supportlinks=0
OK webkit 375 /terms/ supportlinks=0
OK webkit 375 /data-deletion/ supportlinks=0
FAIL webkit 1280 /support/ 404
OK webkit 1280 / supportlinks=0
OK webkit 1280 /privacy-policy/ supportlinks=0
OK webkit 1280 /terms/ supportlinks=0
OK webkit 1280 /data-deletion/ supportlinks=0
FAIL support
```

TOOLS_BASE=OK

```
OK site-clean 05-01-t3 2db88d9a199f
```

## 05-02 원형

기준 커밋(`BASE_SHA`)에 원형 세 파일(`_data/company.yml` 빈 슬롯, `_includes/footer.html` 사업자·주소·이메일/전화 줄, `support/index.html` 지원 페이지)을 얹은 시험용 커밋 객체를 `mkobj`로 만들었습니다. 이 객체는 어떤 ref에도 붙이지 않았고 푸시하지 않습니다. 저장소 사이트 파일은 고치지 않았습니다.

- 슬롯은 RESEARCH Code Example 2 그대로입니다(키 여섯 개, 모든 값 `""`).
- 푸터는 저장소 파일 19행(운영 안내) 다음에 RESEARCH Code Example 1의 블록을 넣고, 구분 기호 세 곳을 `&nbsp;· `(줄 끝 고정)로 바꾸고 사업자 줄 `<p>`의 클래스 속성을 뺀 것입니다. 파일 끝 줄바꿈은 없습니다.
- 지원 페이지는 front matter 다섯 줄(`layout`·`title`·`description`·`eyebrow`·`heading`)뿐이고 날짜·검색 제외 키와 「임시 게시본」 끝 안내는 없습니다. `#contact`·`#report`는 `support_email` 조건 안에, 운영 주체 FAQ는 `trade_name` 조건 안에, 신고 FAQ는 `support_email` 조건 안에 있습니다.
- 빈 값 빌드에서 네 문서는 기준과 바이트가 같고, 출력 파일은 기준에 `support/index.html` 하나만 더해졌습니다. 지원 페이지는 `#faq` 구간과 `dl` 두 개만 그립니다.

PROTO_OBJ=68b96890f7f8
PROTO_DATA_BLOB=7989606c0d747bcaeb23eb7108aac27760515096
PROTO_FOOTER_BLOB=c64c74a6581c832e0c9fce31cc2caae33f117c0e
PROTO_SUPPORT_BLOB=3c561223f005c7ccb3d2d742c66e8398162884f5

```
check-site: 통과 (커밋 68b96890f7f8, jekyll 3.10.0)
OK proto same=4 extra=support/index.html
OK proto support title=고객 지원 - 러닝펜슬 h1=러닝펜슬 고객 지원 ids=faq dl=2 robots=0 updated=0
OK proto source elements=a dd dl dt h2 li p section strong ul attrs=<a href= <section id=
```

PROTO_EMPTY=OK

```
OK site-clean 05-02-t1 3056bc8b20f1
```

## 05-02 행렬

원형 객체(`PROTO_OBJ`)에 `_data/company.yml`만 바꿔 열한 경우를 빌드했습니다(`variant v-<경우>`, 파일 없음은 `variant v-nofile … -`). 시험 값은 모두 가짜 값이고(지원 주소 자리는 `example.invalid` 도메인), 값 파일은 스크래치 `$W/yml/`에만 있습니다. 판정 줄은 스크래치 `$W/matrix.sh <경우>`가 찍은 그대로이고 값 내용은 찍지 않습니다. 열한 경우 모두 계획 때 정한 기대 줄과 같았습니다.

- 값이 없는 네 경우(빈 문자열·null·키 없음·파일 없음)는 네 문서가 기준과 바이트까지 같고, 지원 페이지는 `#faq`와 `dl` 두 개만 그립니다 (BIZ-02).
- 부분 값에서 구분 기호 수는 「있는 항목 수 − 1」입니다 (`trade-bizno` sep=1, `rep`·`trade`·`phone`·`email` sep=0, `all` sep=3) (D-08).
- 「전화」는 전화번호가 있는 경우(`all`·`phone`)에만 생기고, 다섯 문서 푸터가 모두 같습니다(footsame=5) (BIZ-03).
- `#contact`·`#report`는 이메일 값이 있을 때(`all`·`email`)만 생기고 순서는 contact → report → faq입니다. FAQ `dl` 수는 2 + (상호 있음) + (이메일 있음)입니다 (SUP-01·SUP-03·SUP-04).
- `A&B <x>`는 다섯 문서 푸터와 FAQ 여섯 곳에서 모두 이스케이프되어 나오고 날 글자는 0곳입니다 (T-05-05).

```
OK matrix empty same=4 ids=faq dl=2
OK matrix null same=4 ids=faq dl=2
OK matrix nokeys same=4 ids=faq dl=2
OK matrix nofile same=4 ids=faq dl=2
OK matrix all p=6 span=5 sep=3 mailto=1 phone=1 ids=contact,report,faq dl=4 supmailto=2 supphone=2 footsame=5
OK matrix rep p=4 span=1 sep=0 mailto=0 phone=0 ids=faq dl=2 supmailto=0 supphone=0 footsame=5
OK matrix trade-bizno p=4 span=2 sep=1 mailto=0 phone=0 ids=faq dl=3 supmailto=0 supphone=0 footsame=5
OK matrix phone p=4 span=1 sep=0 mailto=0 phone=1 ids=faq dl=2 supmailto=0 supphone=1 footsame=5
OK matrix email p=4 span=1 sep=0 mailto=1 phone=0 ids=contact,report,faq dl=3 supmailto=2 supphone=0 footsame=5
OK matrix trade p=4 span=1 sep=0 mailto=0 phone=0 ids=faq dl=3 supmailto=0 supphone=0 footsame=5
OK matrix escape p=4 span=1 sep=0 mailto=0 phone=0 ids=faq dl=3 supmailto=0 supphone=0 footsame=5 esc=6 raw=0
OK matrix all order=contact<report<faq
```

PROTO_MATRIX=OK

```
OK site-clean 05-02-t2 3056bc8b20f1
```

## 05-03 M1

05-02 원형의 두 blob(`PROTO_DATA_BLOB`, `PROTO_FOOTER_BLOB`)을 `git cat-file blob`으로 그대로 꺼내 `_data/company.yml`, `_includes/footer.html`에 두고 이 두 파일만 스테이징했습니다. 브랜치에 붙지 않는 후보(`commit-tree`)로 점검·빌드한 뒤 같은 인덱스를 커밋했습니다(D-03 커밋 ①). 커밋 트리는 후보 빌드 `$W/c1/TREE`와 같습니다.

- 기준 빌드(`$W/base/site`)와 M1 빌드(`$W/c1/site`)의 `diff -r`이 빈 출력입니다. 네 문서가 바이트까지 같고 출력 파일 목록도 같습니다 (BIZ-02, T-05-06).
- 슬롯의 값은 모두 `""`이고, 푸터는 `.size > 0`으로만 판정합니다.

```
check-site: 통과 (커밋 c6fcd907cabe, jekyll 3.10.0)
OK c1 diff-r empty
```

M1_SHA=bc934fb9555e
M1_SAME=OK

## 05-03 M2

「공통」 CSS(`_includes/css/common.css`)의 `.rp-foot-legal` 줄 바로 다음에 한 줄 규칙 두 개(`.rp-foot-legal span { display: inline-block; }`, `.rp-foot-legal a { color: #FAFAF7; text-decoration: underline; }`)를 넣고 이 파일만 시각 커밋으로 남겼습니다. `#FAFAF7`은 푸터 메뉴 링크가 이미 쓰는 색이라 hex 색 집합은 그대로이고, 파일 끝 줄바꿈 없음도 그대로입니다. 커밋 트리는 후보 빌드 `$W/c2/TREE`와 같습니다.

- M1 빌드(`$W/c1/site`)와 M2 빌드(`$W/c2/site`)의 차이는 네 문서 모두 `<style>` 안 두 줄 추가뿐이고, 출력 파일 목록은 같습니다. 값이 비어 있어 화면에 보이는 것은 바뀌지 않습니다.

```
check-site: 통과 (커밋 881c211e2a91, jekyll 3.10.0)
HUNKS index=57a58,59 legal=47a48,49 47a48,49 47a48,49
OK c2 files same
```

M2_SHA=b7e2dcd0de13
M2_HUNKS=OK

## (보류 1) 05-03 화면

사유: M2 + 가짜 값(`$W/yml/all.yml`) 측정이 375px 여덟 줄에서 `split`으로 실패해 `FOOT_LAYOUT=OK`를 적지 않고 멈췄습니다. 실패의 원인은 CSS가 아니라 시험 값과 판정 기준이 서로 맞지 않는 데 있습니다. 05-02가 사양대로 만든 `all.yml`의 가짜 상호(40자가 넘음)는 「상호 …」 항목 하나만으로 375px 줄 폭(335px)보다 깁니다(줄바꿈 없는 폭 417px). `inline-block` 상자는 이럴 때 상자 안에서 줄을 바꾸므로(RESEARCH Pattern 3이 `nowrap` 대신 고른 이유) 높이가 두 줄(42px)이 되고, `p5-foot.mjs`의 `split` 판정(한 줄 높이의 1.5배 초과)에 걸립니다. 가로 넘침을 만들지 않고서는 어떤 CSS로도 이 판정을 통과할 수 없습니다. 이 계획 안에서 CSS를 고치는 커밋, 시험 값 교체, 판정 완화는 하지 않았고 M1·M2도 고치지 않았습니다(이력 수정 금지). 시험 값, `split` 판정, must-have 3 가운데 무엇을 고칠지는 계획을 다시 세울 때 정합니다.

c2f: M2 + 가짜 값(`all.yml`). 375px 여덟 줄이 `split span0`(가짜 상호 항목)으로 실패, 1280px 여덟 줄은 통과(sepLead=0). 캡처 네 장은 `$W/cap/c2f/`에 있습니다.

```
FAIL chromium 375 / split span0 lines=1 h=42 lh=21
FAIL chromium 375 /privacy-policy/ split span0 lines=1 h=42 lh=21
FAIL chromium 375 /terms/ split span0 lines=1 h=42 lh=21
FAIL chromium 375 /data-deletion/ split span0 lines=1 h=42 lh=21
OK chromium 1280 / rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 1280 /privacy-policy/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 1280 /terms/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 1280 /data-deletion/ rows=6 spans=5 seps=3 links=1 sepLead=0
FAIL webkit 375 / split span0 lines=1 h=42 lh=21
FAIL webkit 375 /privacy-policy/ split span0 lines=1 h=42 lh=21
FAIL webkit 375 /terms/ split span0 lines=1 h=42 lh=21
FAIL webkit 375 /data-deletion/ split span0 lines=1 h=42 lh=21
OK webkit 1280 / rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 1280 /privacy-policy/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 1280 /terms/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 1280 /data-deletion/ rows=6 spans=5 seps=3 links=1 sepLead=0
FAIL foot
```

원인 측정: 같은 `c2f` 빌드를 다시 띄워(다시 빌드하지 않음) 375px `/`에서 항목마다 잠깐 `white-space: nowrap`으로 잰 폭(natural)과 그 `p`의 `clientWidth`(line)를 비교했습니다(스크래치 `$W/pw/p503-diag.mjs`, 글 내용은 찍지 않음). 넘치는 항목은 span0 하나뿐이고, 가로 넘침은 없으며 링크 색·밑줄은 기대값입니다.

```
DIAG chromium 375 span0 natural=417 line=335 h=42 fits=0
DIAG chromium 375 span1 natural=82 line=335 h=21 fits=1
DIAG chromium 375 span2 natural=171 line=335 h=21 fits=1
DIAG chromium 375 span3 natural=160 line=335 h=21 fits=1
DIAG chromium 375 span4 natural=122 line=335 h=21 fits=1
DIAG chromium 375 scrollWidth=375 innerWidth=375
DIAG chromium 375 link color=rgb(250, 250, 247) deco=underline
DIAG webkit 375 span0 natural=417 line=335 h=42 fits=0
DIAG webkit 375 span1 natural=82 line=335 h=21 fits=1
DIAG webkit 375 span2 natural=171 line=335 h=21 fits=1
DIAG webkit 375 span3 natural=160 line=335 h=21 fits=1
DIAG webkit 375 span4 natural=122 line=335 h=21 fits=1
DIAG webkit 375 scrollWidth=375 innerWidth=375
DIAG webkit 375 link color=rgb(250, 250, 247) deco=underline
```

c2f-fit: 대조 시험. M2 트리에 `all.yml`에서 가짜 상호만 한 줄에 들어가는 길이(「가상시험상호 주식회사」)로 줄인 값(`$W/t3-fit.yml`, `$W/yml/` 밖)을 넣어 새 이름 `c2f-fit`, 포트 4520으로 빌드했습니다. 16줄 모두 통과했고 375px sepLead도 0입니다. 실패가 너무 긴 항목 하나에서만 나온다는 근거입니다.

```
OK chromium 375 / rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 375 /privacy-policy/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 375 /terms/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 375 /data-deletion/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 1280 / rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 1280 /privacy-policy/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 1280 /terms/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 1280 /data-deletion/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 375 / rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 375 /privacy-policy/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 375 /terms/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 375 /data-deletion/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 1280 / rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 1280 /privacy-policy/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 1280 /terms/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 1280 /data-deletion/ rows=6 spans=5 seps=3 links=1 sepLead=0
PASS foot
```

c1f: M1 + 가짜 값(`all.yml`), CSS 없음. 음성 대조(판정이 아니라 참고 기록). 링크가 기본 파란색(`rgb(0, 0, 238)`)이라 열여섯 곳 모두 `badLink`로 잡히고, `inline-block`이 없어 375px에서 상호·사업자등록번호 항목이 두 줄 상자로 나뉩니다.

```
FAIL chromium 375 / split span0 lines=2 h=36 lh=21
FAIL chromium 375 / split span2 lines=2 h=36 lh=21
FAIL chromium 375 / badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 375 /privacy-policy/ split span0 lines=2 h=36 lh=21
FAIL chromium 375 /privacy-policy/ split span2 lines=2 h=36 lh=21
FAIL chromium 375 /privacy-policy/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 375 /terms/ split span0 lines=2 h=36 lh=21
FAIL chromium 375 /terms/ split span2 lines=2 h=36 lh=21
FAIL chromium 375 /terms/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 375 /data-deletion/ split span0 lines=2 h=36 lh=21
FAIL chromium 375 /data-deletion/ split span2 lines=2 h=36 lh=21
FAIL chromium 375 /data-deletion/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 1280 / badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 1280 /privacy-policy/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 1280 /terms/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 1280 /data-deletion/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 375 / split span0 lines=2 h=36 lh=21
FAIL webkit 375 / split span2 lines=2 h=36 lh=21
FAIL webkit 375 / badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 375 /privacy-policy/ split span0 lines=2 h=36 lh=21
FAIL webkit 375 /privacy-policy/ split span2 lines=2 h=36 lh=21
FAIL webkit 375 /privacy-policy/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 375 /terms/ split span0 lines=2 h=36 lh=21
FAIL webkit 375 /terms/ split span2 lines=2 h=36 lh=21
FAIL webkit 375 /terms/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 375 /data-deletion/ split span0 lines=2 h=36 lh=21
FAIL webkit 375 /data-deletion/ split span2 lines=2 h=36 lh=21
FAIL webkit 375 /data-deletion/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 1280 / badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 1280 /privacy-policy/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 1280 /terms/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 1280 /data-deletion/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL foot
```

M1·M2 커밋과 그 표식(`M1_SHA`·`M1_SAME`·`M2_SHA`·`M2_HUNKS`)은 두 task verify를 다시 돌려 통과한 그대로 두었습니다. 보류 규칙은 「이번 시도의 표식에 `HOLD1_`을 붙이고 다음 실행은 Task 1부터」이지만, M1·M2는 이미 `main`에 있고 이력을 고칠 수 없어 Task 1을 처음부터 다시 할 수 없으므로 머리를 붙이지 않았습니다. 다시 세우는 계획에서 이 처리를 정합니다. 커밋은 푸시하지 않았습니다.

```
OK site-clean 05-03-t3 b7e2dcd0de13
```

## 05-03 화면

c1f: M1 + 가짜 값, CSS 없음 (음성 대조, 아래 두 번째 출력). c2f: M2 + 가짜 값(`$W/yml/all.yml`, 첫 번째 출력). 두 빌드는 다시 만들지 않고 보류 1 때의 것을 다시 띄웠습니다(`$W/c2f/TREE` = M2 트리, `$W/c1f/TREE` = M1 트리, 두 `YML` = `all.yml` 해시 앞 12자리).

사용자 결정 (2026-11-19, 보류 1 checkpoint 답):

- split 판정 보정: 항목 하나의 줄바꿈 없는 폭이 줄 폭보다 길 때만 그 항목이 자기 상자 안에서 줄을 바꾸는 것을 허용합니다. 여러 줄에 걸친 상자의 split, overflow, 링크 색 판정은 그대로입니다. 시험 값 `all.yml`은 바꾸지 않았습니다. 스크래치 도구 `$W/pw/p5-foot.mjs`, 05-01 도구 사양 (a), 05-03 Task 3 문구, 05-VALIDATION BIZ-01 (D-07) 행을 함께 고쳤습니다(문서 커밋 3bfc1cbe1128).
- M1·M2 표식(`M1_SHA`·`M1_SAME`·`M2_SHA`·`M2_HUNKS`)은 `HOLD1_` 머리 없이 그대로 둡니다. M1·M2 커밋과 `## (보류 1) 05-03 화면` 구간은 고치지 않았습니다.
- 보류 규칙 예외(사용자 승인): 05-01 「다음 실행은 그 계획 Task 1부터 다시 한다」를 이번 재개에는 적용하지 않고 Task 3만 다시 했습니다. Task 1의 전제(`_data`가 저장소에 없음)는 M1 커밋으로 이미 참이 아니고, 이력 수정은 금지이기 때문입니다. 커밋은 푸시하지 않았습니다.

도구 회귀: 고친 `p5-foot.mjs`를 기준 빌드(`$W/base`, 포트 4501)에서 다시 돌린 결과입니다(다시 돌린 기준 판정이라 머리 `regen `을 붙임). 05-01 Task 3 verify 두 명령도 다시 돌려 exit 0이었습니다.

```
regen OK chromium 375 / rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK chromium 375 /privacy-policy/ rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK chromium 375 /terms/ rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK chromium 375 /data-deletion/ rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK chromium 1280 / rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK chromium 1280 /privacy-policy/ rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK chromium 1280 /terms/ rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK chromium 1280 /data-deletion/ rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK webkit 375 / rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK webkit 375 /privacy-policy/ rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK webkit 375 /terms/ rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK webkit 375 /data-deletion/ rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK webkit 1280 / rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK webkit 1280 /privacy-policy/ rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK webkit 1280 /terms/ rows=3 spans=0 seps=0 links=0 sepLead=0
regen OK webkit 1280 /data-deletion/ rows=3 spans=0 seps=0 links=0 sepLead=0
regen PASS foot
```

c2f: 16줄 모두 통과, 마지막 줄 `PASS foot`. 375px 여덟 줄 앞에 가짜 상호 항목(span0)의 `NOTE … longItem` 정보 줄이 있습니다(줄바꿈 없는 폭 417px > 줄 폭 335px, 상자 안 줄바꿈 허용, 실패 아님). 1280px에는 `NOTE` 줄이 없고 sepLead=0입니다. 375px sepLead는 1입니다(기록만 합니다. 구분 기호 모양은 05-05 D-10 checkpoint에서 사용자가 고릅니다). 캡처 네 장은 `$W/cap/c2f/`에 다시 찍었습니다.

```
NOTE chromium 375 / longItem span0 natural=417 line=335
OK chromium 375 / rows=6 spans=5 seps=3 links=1 sepLead=1
NOTE chromium 375 /privacy-policy/ longItem span0 natural=417 line=335
OK chromium 375 /privacy-policy/ rows=6 spans=5 seps=3 links=1 sepLead=1
NOTE chromium 375 /terms/ longItem span0 natural=417 line=335
OK chromium 375 /terms/ rows=6 spans=5 seps=3 links=1 sepLead=1
NOTE chromium 375 /data-deletion/ longItem span0 natural=417 line=335
OK chromium 375 /data-deletion/ rows=6 spans=5 seps=3 links=1 sepLead=1
OK chromium 1280 / rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 1280 /privacy-policy/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 1280 /terms/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK chromium 1280 /data-deletion/ rows=6 spans=5 seps=3 links=1 sepLead=0
NOTE webkit 375 / longItem span0 natural=417 line=335
OK webkit 375 / rows=6 spans=5 seps=3 links=1 sepLead=1
NOTE webkit 375 /privacy-policy/ longItem span0 natural=417 line=335
OK webkit 375 /privacy-policy/ rows=6 spans=5 seps=3 links=1 sepLead=1
NOTE webkit 375 /terms/ longItem span0 natural=417 line=335
OK webkit 375 /terms/ rows=6 spans=5 seps=3 links=1 sepLead=1
NOTE webkit 375 /data-deletion/ longItem span0 natural=417 line=335
OK webkit 375 /data-deletion/ rows=6 spans=5 seps=3 links=1 sepLead=1
OK webkit 1280 / rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 1280 /privacy-policy/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 1280 /terms/ rows=6 spans=5 seps=3 links=1 sepLead=0
OK webkit 1280 /data-deletion/ rows=6 spans=5 seps=3 links=1 sepLead=0
PASS foot
```

c1f: 종료 코드 1, 마지막 줄 `FAIL foot`. 열여섯 곳 모두 `badLink`(기본 파란색 `rgb(0, 0, 238)`)로 잡히고, 375px에서는 `inline-block`이 없는 보통 inline `span`이 두 줄에 걸쳐(`lines=2`) `split`으로 잡힙니다. 예외가 진짜 끊김을 삼키지 않는다는 근거입니다. `NOTE` 줄은 없습니다.

```
FAIL chromium 375 / split span0 lines=2 h=36 lh=21
FAIL chromium 375 / split span2 lines=2 h=36 lh=21
FAIL chromium 375 / badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 375 /privacy-policy/ split span0 lines=2 h=36 lh=21
FAIL chromium 375 /privacy-policy/ split span2 lines=2 h=36 lh=21
FAIL chromium 375 /privacy-policy/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 375 /terms/ split span0 lines=2 h=36 lh=21
FAIL chromium 375 /terms/ split span2 lines=2 h=36 lh=21
FAIL chromium 375 /terms/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 375 /data-deletion/ split span0 lines=2 h=36 lh=21
FAIL chromium 375 /data-deletion/ split span2 lines=2 h=36 lh=21
FAIL chromium 375 /data-deletion/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 1280 / badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 1280 /privacy-policy/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 1280 /terms/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL chromium 1280 /data-deletion/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 375 / split span0 lines=2 h=36 lh=21
FAIL webkit 375 / split span2 lines=2 h=36 lh=21
FAIL webkit 375 / badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 375 /privacy-policy/ split span0 lines=2 h=36 lh=21
FAIL webkit 375 /privacy-policy/ split span2 lines=2 h=36 lh=21
FAIL webkit 375 /privacy-policy/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 375 /terms/ split span0 lines=2 h=36 lh=21
FAIL webkit 375 /terms/ split span2 lines=2 h=36 lh=21
FAIL webkit 375 /terms/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 375 /data-deletion/ split span0 lines=2 h=36 lh=21
FAIL webkit 375 /data-deletion/ split span2 lines=2 h=36 lh=21
FAIL webkit 375 /data-deletion/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 1280 / badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 1280 /privacy-policy/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 1280 /terms/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL webkit 1280 /data-deletion/ badLink a0 color=rgb(0, 0, 238) deco=underline
FAIL foot
```

FOOT_LAYOUT=OK

```
OK site-clean 05-03-t3 3bfc1cbe1128
```

## 05-04 가드

`scripts/check-site.sh`에 7번 항목(지원 페이지와 연락처, 이메일 게이트 D-04)을 더하고 이 파일만 build 커밋 M3로 남겼습니다. 출력에 `/support/` 문서가 있으면 그 문서에 `href="mailto:`가 있어야 하고, 출력 어디든 `href="/support/` 링크가 있으면 `/support/` 문서가 있어야 합니다. 링크 검색 grep의 종료 코드 2 이상은 실패로 셉니다(6번 항목과 같은 방식). 기대 제목 목록(`EXPECTED_TITLES`)과 `.githooks/pre-push`는 고치지 않았습니다(Pitfall 7).

브랜치에 붙지 않는 후보(`commit-tree`)의 스크립트 사본으로 판정한 뒤 같은 인덱스를 커밋했고, 커밋 트리는 후보 트리와 같습니다. 시험 객체 셋은 `mkobj`로 M2 위에 만들었고 어떤 ref에도 붙이지 않았습니다.

- 양성: 기준 커밋, M2, 후보가 통과합니다.
- `NEG7_PAGE`: M2 + 05-02 원형 지원 페이지(`$W/proto-support.html`, 이메일 값 없음). 7번의 연락처 문구 하나로 실패합니다.
- `NEG7_LINK`: M2 + 헤더 끝에 「고객 지원」 링크 한 줄을 더한 시험용 헤더(`$W/h3-header.html`), 지원 페이지 없음. 7번의 링크 문구 하나로 실패합니다.
- `POS7`: M2 + 원형 지원 페이지 + 이메일 가짜 값(`$W/yml/email.yml`) + 시험용 헤더. 통과합니다.

```
check-site: 통과 (커밋 2db88d9a199f, jekyll 3.10.0)
check-site: 통과 (커밋 b7e2dcd0de13, jekyll 3.10.0)
check-site: 통과 (커밋 a1fecbe43bc0, jekyll 3.10.0)
OK neg7-page rc=1 count=1 mailto-msg=1
OK neg7-link rc=1 count=1 link-msg=1
OK pos7 pass
```

음성 시험 출력(전체):

```
check-site: 지원 페이지에 연락처(mailto)가 없습니다: 이메일 게이트 전의 /support/는 배포하지 않습니다 (D-04)
check-site: 실패 — 1건 (커밋 bcdb59d63667)
check-site: 지원 페이지 없이 /support/ 링크가 있습니다: /index.html /privacy-policy/index.html /terms/index.html /data-deletion/index.html
check-site: 실패 — 1건 (커밋 432a214f884d)
```

M3_SHA=da940757106e
NEG7_PAGE=bcdb59d63667
NEG7_LINK=432a214f884d
POS7=a208f0d5823d
GUARD7=OK

```
OK site-clean 05-04-t1 da940757106e
```

## 05-04 훅

실제 푸시 경로인 `.githooks/pre-push`에 표준 입력(`refs/heads/main <SHA> refs/heads/main <원격 main>`)만 주어 판정했습니다. 아무것도 푸시하지 않았습니다. 원격 main을 새로 받아 본 값이 `BASE_LIVE`와 같았고, 훅을 돌릴 때 작업 트리의 `scripts/check-site.sh`·`.githooks/pre-push`는 M3와 같았습니다. 훅은 M3를 통과시키고, 두 음성 시험 객체(`NEG7_PAGE`, `NEG7_LINK`)는 7번 항목의 해당 문구로 거부했습니다. 게이트 전 어떤 푸시든 연락처 없는 `/support/`나 페이지 없는 `/support/` 링크를 담으면 훅이 멈춥니다(`--no-verify`는 규칙으로 쓰지 않습니다).

```
OK origin = base-live
OK hook files = m3
OK hook m3 pass
OK hook neg7-page rejected
OK hook neg7-link rejected
```

훅 출력(M3, `NEG7_PAGE`, `NEG7_LINK` 차례):

```
check-site: 통과 (커밋 da940757106e, jekyll 3.10.0)
check-site: 지원 페이지에 연락처(mailto)가 없습니다: 이메일 게이트 전의 /support/는 배포하지 않습니다 (D-04)
check-site: 실패 — 1건 (커밋 bcdb59d63667)
check-site: 지원 페이지 없이 /support/ 링크가 있습니다: /index.html /privacy-policy/index.html /terms/index.html /data-deletion/index.html
check-site: 실패 — 1건 (커밋 432a214f884d)
```

HOOK7=OK

## 05-05 시험 실행

실제 사업자 값을 받기 전에, Task 3이 실제 값으로 돌릴 파이프라인을 가짜 값으로 끝까지 돌렸습니다. 저장소 사이트 파일과 인덱스는 건드리지 않았습니다.

- 시험 값 `$W/yml/biz-fake.yml`은 05-02 가짜 값 `$W/yml/all.yml`에서 `support_email`·`phone`만 `""`로 바꾼 것입니다(사업자 값 네 개만 가짜로 채움).
- 시험 객체는 `mkobj HEAD _data/company.yml=$W/yml/biz-fake.yml`로 만들었고 어떤 ref에도 붙이지 않았습니다(`git for-each-ref --contains` 빈 출력). 푸시하지 않습니다.
- `c3`은 HEAD(사이트 트리 = M3) 빌드, `dry`는 시험 객체 빌드입니다. 네 문서마다 `footblock` 줄 범위를 뺀 나머지가 `cmp`로 같고, 출력 파일 목록도 같습니다.
- 선택지 빌드 `dryo1`·`dryo2`·`dryo3`은 `$W/dry/src`를 복사해 `_includes/footer.html`의 구분 기호 토큰 `&nbsp;· ` 세 곳을 각각 ` · `(선택지 1), 그대로(선택지 2), ` ·&nbsp;`(선택지 3)로 바꾼 것입니다. 바꾼 뒤 옛 토큰 0곳·새 토큰 3곳, 선택지 2의 템플릿과 출력은 `dry`와 바이트가 같습니다. 포트 4506~4508로 띄워 `p5-foot.mjs … --shot "$W/cap/dryo<n>"`을 돌렸고, 캡처는 `$W/cap/dryo<n>/<엔진>-<폭>.png`입니다.
- 세 선택지 모두 375px sepLead가 1이고 1280px은 0입니다. 가짜 상호(줄 폭보다 긴 항목, `NOTE … longItem`)가 상자 안에서 줄을 바꾸는 모양이라 세 선택지가 같게 나왔습니다. 실제 값에서의 위치는 Task 3 측정과 캡처로 봅니다(기록만, 실패 아님).

DRY_OBJ=f7e64b9e2d4d

```
check-site: 통과 (커밋 f7e64b9e2d4d, jekyll 3.10.0)
OK dry diff footer-only 4
OK dry labels trade=1 rep=1 bizno=1 addr=1 email=0 phone=0 docs=4
OK dry opt1 pass
OK dry opt2 pass
OK dry opt3 pass
OK dry captures=12
```

p5-foot 출력(세 선택지가 줄마다 같아 한 번만 붙임. 선택지마다 종료 코드 0, 마지막 줄 `PASS foot`):

```
NOTE chromium 375 / longItem span0 natural=417 line=335
OK chromium 375 / rows=5 spans=3 seps=2 links=0 sepLead=1
NOTE chromium 375 /privacy-policy/ longItem span0 natural=417 line=335
OK chromium 375 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=1
NOTE chromium 375 /terms/ longItem span0 natural=417 line=335
OK chromium 375 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=1
NOTE chromium 375 /data-deletion/ longItem span0 natural=417 line=335
OK chromium 375 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=1
OK chromium 1280 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
NOTE webkit 375 / longItem span0 natural=417 line=335
OK webkit 375 / rows=5 spans=3 seps=2 links=0 sepLead=1
NOTE webkit 375 /privacy-policy/ longItem span0 natural=417 line=335
OK webkit 375 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=1
NOTE webkit 375 /terms/ longItem span0 natural=417 line=335
OK webkit 375 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=1
NOTE webkit 375 /data-deletion/ longItem span0 natural=417 line=335
OK webkit 375 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=1
OK webkit 1280 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
PASS foot
```

DRY_RUN=OK

```
OK site-clean 05-05-t1 bf00e3e05173
```
