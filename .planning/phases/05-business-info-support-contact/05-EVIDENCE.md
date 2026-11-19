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

## (보류 1) 05-05 시험 실행

실제 사업자 값을 받기 전에, Task 3이 실제 값으로 돌릴 파이프라인을 가짜 값으로 끝까지 돌렸습니다. 저장소 사이트 파일과 인덱스는 건드리지 않았습니다.

- 시험 값 `$W/yml/biz-fake.yml`은 05-02 가짜 값 `$W/yml/all.yml`에서 `support_email`·`phone`만 `""`로 바꾼 것입니다(사업자 값 네 개만 가짜로 채움).
- 시험 객체는 `mkobj HEAD _data/company.yml=$W/yml/biz-fake.yml`로 만들었고 어떤 ref에도 붙이지 않았습니다(`git for-each-ref --contains` 빈 출력). 푸시하지 않습니다.
- `c3`은 HEAD(사이트 트리 = M3) 빌드, `dry`는 시험 객체 빌드입니다. 네 문서마다 `footblock` 줄 범위를 뺀 나머지가 `cmp`로 같고, 출력 파일 목록도 같습니다.
- 선택지 빌드 `dryo1`·`dryo2`·`dryo3`은 `$W/dry/src`를 복사해 `_includes/footer.html`의 구분 기호 토큰 `&nbsp;· ` 세 곳을 각각 ` · `(선택지 1), 그대로(선택지 2), ` ·&nbsp;`(선택지 3)로 바꾼 것입니다. 바꾼 뒤 옛 토큰 0곳·새 토큰 3곳, 선택지 2의 템플릿과 출력은 `dry`와 바이트가 같습니다. 포트 4506~4508로 띄워 `p5-foot.mjs … --shot "$W/cap/dryo<n>"`을 돌렸고, 캡처는 `$W/cap/dryo<n>/<엔진>-<폭>.png`입니다.
- 세 선택지 모두 375px sepLead가 1이고 1280px은 0입니다. 가짜 상호(줄 폭보다 긴 항목, `NOTE … longItem`)가 상자 안에서 줄을 바꾸는 모양이라 세 선택지가 같게 나왔습니다. 실제 값에서의 위치는 Task 3 측정과 캡처로 봅니다(기록만, 실패 아님).

HOLD1_DRY_OBJ=f7e64b9e2d4d

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

HOLD1_DRY_RUN=OK

```
OK site-clean 05-05-t1 bf00e3e05173
```

## (보류 1) 05-05 값 후보

사유: Task 4 fix-values — 사용자가 주소 공개 범위를 줄이기로 함(값은 다음 실행 Task 2에서 다시 받음).

사용자가 대화로 준 사업자 값 네 개(상호·대표자·사업자등록번호·주소)를 작업 트리 `_data/company.yml`의 네 칸에만 넣었습니다. `support_email`·`phone`은 빈 값 그대로입니다. 값과 푸터 글은 이 기록에 적지 않습니다(D-02). 건수와 판정 줄만 남깁니다.

- 값 넣은 뒤 `ruby -ryaml`로 읽어 네 값이 받은 글자와 같고(키마다 OK, 화면에 값을 찍지 않음) `support_email`·`phone`이 빈 문자열임을 확인했습니다.
- 값 누출 점검(05-01): 새로 공개되는 값 3건, 기준 커밋에 이미 있던 값 1건(누출 대상 아님). `.planning/`에서 `git grep` 종료 코드 1(0건), `BASE_SHA..HEAD` 커밋 메시지 0건.
- 후보 `C4_CAND`는 `_data/company.yml` 하나만 스테이징해 `git commit-tree … -p HEAD -m candidate`로 만들고 곧바로 `git restore --staged`로 인덱스를 비웠습니다. 로컬 스크래치 ref `refs/p5-scratch/c4-cand`에만 붙였고 어떤 브랜치에도 없습니다(`git branch -a --contains` 빈 출력). 푸시하지 않습니다.
- `c3`은 HEAD(사이트 트리 = M3) 빌드, `c4`는 후보 빌드입니다(`$W/c4/TREE` = 후보 트리). 출력 파일 목록이 같고, 네 문서 밖의 출력 파일은 바이트가 같으며, 네 문서는 `footblock` 줄 범위를 뺀 나머지가 `cmp`로 같습니다(푸터 블록 5줄 → 7줄).
- 선택지 빌드 `d10o1`·`d10o2`·`d10o3`은 `$W/c4/src`를 복사해 `_includes/footer.html`의 구분 기호 토큰 `&nbsp;· ` 세 곳을 각각 ` · `(선택지 1), 그대로(선택지 2), ` ·&nbsp;`(선택지 3)로 바꾼 것입니다. 선택지 1·3은 옛 토큰 0곳·새 토큰 3곳, 선택지 2의 템플릿과 출력은 `c4`와 바이트가 같습니다. 포트 4506~4508로 띄워 `p5-foot.mjs … --shot "$W/cap/d10o<n>"`을 돌렸고 서버는 모두 내렸습니다. 캡처는 `$W/cap/d10o<n>/<엔진>-<폭>.png`입니다.
- 실제 값에서는 375px에서도 첫 줄 세 항목이 한 줄에 들어가 줄이 바뀌지 않습니다. 그래서 세 선택지 모두 두 엔진·두 폭에서 sepLead가 0이고, 세 선택지의 p5-foot 출력은 줄마다 같으며(`cmp`), 같은 엔진·폭의 캡처 PNG도 세 선택지가 바이트까지 같습니다. 선택지는 첫 줄이 바뀌는 더 좁은 화면이나 값이 바뀔 때만 모양이 갈립니다(기록만, 실패 아님).

HOLD1_VALUES_RECEIVED=OK

HOLD1_C4_CAND=4d5e90c0402b

```
vals filled=4 emitted=3 excluded=1
leak .planning=0 messages=0
OK c4 worktree only-yml=cand index=clean
check-site: 통과 (커밋 4d5e90c0402b, jekyll 3.10.0)
OK c4 diff footer-only 4
OK c4 labels trade=1 rep=1 bizno=1 addr=1 email=0 phone=0 docs=4
OK d10 opt1 pass
OK d10 opt2 pass
OK d10 opt3 pass
OK d10 captures=12
```

p5-foot 출력(세 선택지가 줄마다 같아 한 번만 붙임. 선택지마다 종료 코드 0, 마지막 줄 `PASS foot`, 값 0건):

```
OK chromium 375 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 375 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 375 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 375 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 375 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 375 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 375 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 375 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
PASS foot
```

Task 4(D-10 승인)의 답이 fix-values여서 이 시도를 보류로 끝냈습니다. 작업 트리 `_data/company.yml`을 `git restore --source=HEAD --staged --worktree`로 HEAD와 같게 되돌렸고, 스크래치 ref `refs/p5-scratch/c4-cand`를 `git update-ref -d`로 지웠습니다. 후보 객체(`HOLD1_C4_CAND`)는 어떤 ref에도 붙지 않은 로컬 객체로만 남고 푸시하지 않습니다. SUMMARY는 만들지 않았고, 다음 실행은 05-05 Task 1부터 다시 합니다.

```
OK site-clean 05-05-hold 63ae5850a662
```

## 05-05 시험 실행

시도 2입니다. 시도 1은 Task 4에서 보류로 끝났고(구간 `## (보류 1) 05-05 …`, `HOLD1_` 표식), 05-01 「보류·중단과 다시 실행」대로 Task 1부터 다시 했습니다. 시작 전 05-01 「스크래치 재확인」(가)~(마)가 모두 그대로여서 다시 만든 것은 없습니다.

실제 사업자 값을 다루기 전에, Task 3이 실제 값으로 돌릴 파이프라인을 가짜 값으로 끝까지 돌렸습니다. 저장소 사이트 파일과 인덱스는 건드리지 않았습니다.

- 시험 값 `$W/yml/biz-fake.yml`은 05-02 가짜 값 `$W/yml/all.yml`에서 `support_email`·`phone`만 `""`로 바꾼 것입니다(사업자 값 네 개만 가짜로 채움). 다시 만든 파일이 시도 1의 파일과 바이트가 같았습니다.
- 시험 객체는 `mkobj HEAD _data/company.yml=$W/yml/biz-fake.yml`로 만들었고 어떤 ref에도 붙이지 않았습니다(`git for-each-ref --contains` 빈 출력). 푸시하지 않습니다.
- `c3`은 HEAD(사이트 트리 = M3) 빌드, `dry`는 시험 객체 빌드입니다. 출력 파일 목록이 같고, 네 문서 밖의 출력 파일은 바이트가 같으며, 네 문서마다 `footblock` 줄 범위를 뺀 나머지가 `cmp`로 같습니다.
- 선택지 빌드 `dryo1`·`dryo2`·`dryo3`은 `$W/dry/src`를 복사해 `_includes/footer.html`의 구분 기호 토큰 `&nbsp;· ` 세 곳을 각각 ` · `(선택지 1), 그대로(선택지 2), ` ·&nbsp;`(선택지 3)로 바꾼 것입니다. 선택지 1·3은 바꾼 뒤 옛 토큰 0곳, 선택지 2의 템플릿과 출력은 `dry`와 같습니다. 포트 4506~4508로 띄워 `p5-foot.mjs … --shot "$W/cap/dryo<n>"`을 돌렸고 서버는 모두 내렸습니다. 캡처는 `$W/cap/dryo<n>/<엔진>-<폭>.png`입니다.
- 세 선택지의 p5-foot 출력은 줄마다 같고, 시도 1의 출력과도 바이트가 같습니다. 가짜 상호가 줄 폭보다 길어(`NOTE … longItem`) 375px sepLead가 1, 1280px은 0입니다(기록만, 실패 아님).

DRY_OBJ=24ef2f9f92d9

```
check-site: 통과 (커밋 24ef2f9f92d9, jekyll 3.10.0)
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
OK site-clean 05-05-t1 00e23904e0d2
```

## 05-05 값 후보

시도 2입니다. 사용자가 대화로 준 사업자 값 네 개(상호·대표자·사업자등록번호·주소, 등록증 표기 전체)를 작업 트리 `_data/company.yml`의 네 칸에만 넣었습니다. `support_email`·`phone`은 빈 값 그대로입니다. 값과 푸터 글은 이 기록에 적지 않습니다(D-02). 건수와 판정 줄만 남깁니다.

- 값을 넣은 뒤 `ruby -ryaml`로 읽어 네 값이 비어 있지 않고 `support_email`·`phone`이 빈 문자열임을 확인했습니다(화면에 값을 찍지 않음). 넣은 파일의 blob이 시도 1 후보(`HOLD1_C4_CAND`)의 `_data/company.yml` blob과 같습니다(`git hash-object` 대조, 일치 1건).
- 값 누출 점검(05-01): 새로 공개되는 값 3건, 기준 커밋에 이미 있던 값 1건(누출 대상 아님). `.planning/`에서 `git grep` 종료 코드 1(0건), `BASE_SHA..HEAD` 커밋 메시지 0건.
- 후보 `C4_CAND`는 `_data/company.yml` 하나만 스테이징해 `git commit-tree … -p HEAD -m candidate`로 만들고 같은 명령 묶음 안에서 `git restore --staged`로 인덱스를 비웠습니다. 로컬 스크래치 ref `refs/p5-scratch/c4-cand`에만 붙였고 어떤 브랜치에도 없습니다(`git branch -a --contains` 빈 출력). 푸시하지 않습니다.
- `c3`은 HEAD(사이트 트리 = M3) 빌드, `c4`는 후보 빌드입니다(`$W/c4/TREE` = 후보 트리). 출력 파일 목록이 같고, 네 문서 밖의 출력 파일은 바이트가 같으며, 네 문서는 `footblock` 줄 범위를 뺀 나머지가 `cmp`로 같습니다(푸터 블록 5줄 → 7줄).
- 선택지 빌드 `d10o1`·`d10o2`·`d10o3`은 `$W/c4/src`를 복사해 `_includes/footer.html`의 구분 기호 토큰 `&nbsp;· ` 세 곳을 각각 ` · `(선택지 1), 그대로(선택지 2), ` ·&nbsp;`(선택지 3)로 바꾼 것입니다. 선택지 1·3은 옛 토큰 0곳, 선택지 2의 템플릿과 출력은 `c4`와 같습니다. 포트 4506~4508로 띄워 `p5-foot.mjs … --shot "$W/cap/d10o<n>"`을 돌렸고 서버는 모두 내렸습니다. 캡처는 `$W/cap/d10o<n>/<엔진>-<폭>.png`입니다.
- 실제 값에서는 375px에서도 첫 줄 세 항목이 한 줄에 들어가 줄이 바뀌지 않습니다. 그래서 세 선택지 모두 두 엔진·두 폭에서 sepLead가 0이고, 세 선택지의 p5-foot 출력은 줄마다 같으며, 시도 1의 세 출력(시작 전에 `$W/h1keep/`에 따로 둠)과도 바이트가 같습니다.
- 캡처: 같은 엔진·폭에서 세 선택지의 캡처는 chromium 375·1280과 webkit 1280이 바이트까지 같습니다. webkit 375는 선택지 2의 첫 캡처만 56줄(4171픽셀)이 달랐습니다. 선택지 1·2를 다시 찍은 캡처(`$W/capchk/d10o<n>/`)에서는 선택지 2가 선택지 1·3과 픽셀까지 같고 첫 캡처와 달라서, 선택지 차이가 아니라 webkit 캡처가 한 번 흔들린 것으로 봅니다(p5-foot 측정은 세 선택지 모두 같음). 기록만, 실패 아님.

VALUES_RECEIVED=OK

C4_CAND=fef24cd83cfb

```
vals filled=4 emitted=3 excluded=1
leak .planning=0 messages=0
OK c4 worktree only-yml=cand index=clean
check-site: 통과 (커밋 fef24cd83cfb, jekyll 3.10.0)
OK c4 diff footer-only 4
OK c4 labels trade=1 rep=1 bizno=1 addr=1 email=0 phone=0 docs=4
OK d10 opt1 pass
OK d10 opt2 pass
OK d10 opt3 pass
OK d10 captures=12
```

p5-foot 출력(세 선택지가 줄마다 같아 한 번만 붙임. 선택지마다 종료 코드 0, 마지막 줄 `PASS foot`, 값 0건):

```
OK chromium 375 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 375 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 375 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 375 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 375 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 375 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 375 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 375 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
PASS foot
```

## 05-05 승인

Task 4(D-10 one-way, blocking-human)의 답은 **approve-opt2**입니다. 사용자가 사업자등록증과 푸터 표기를 대조했고(글자까지 같음), 구분 기호는 선택지 2(`&nbsp;· `, 지금 템플릿 그대로)로 정했습니다. 템플릿을 바꾸는 커밋은 없습니다. 값과 푸터 글은 적지 않습니다(D-02).

- 이 승인은 시도 1의 후보(`HOLD1_C4_CAND`)를 빌드한 푸터 글과 캡처 열두 장을 보고 대화에서 준 것이고, 오케스트레이터가 시도 2에 전달했습니다. 시도 2의 후보는 그 후보와 바이트가 같은 것으로 확인한 뒤에만 이 답을 적용했습니다. (a) 후보의 `_data/company.yml` blob이 시도 1 후보의 blob과 같음, (b) 두 후보의 `.planning/` 밖 트리가 같음(`git diff --quiet` 종료 코드 0), (c) Task 3 verify 종료 코드 0이고 세 선택지의 p5-foot 출력이 시도 1과 바이트가 같음(모두 `PASS foot`, sepLead 0).
- 승인은 05-06의 값 커밋과 첫 푸시로 넘어가는 것까지입니다. 푸시 자체는 05-06에서 그 SHA로 따로 승인받습니다.
- 작업 트리 `_data/company.yml`은 고친 채(스테이징 안 함) 남깁니다. 05-06 Task 1이 이 값으로 M4를 만듭니다.

```
OK d10 same-as-reviewed blob=1 site-tree=1 foot=3
```

D10_APPROVED=OK
SEPARATOR=opt2
USER_MATCH=OK
D10_DATE=2026-11-19

## 05-06 값 커밋과 푸시 후보

첫 실행입니다(`M3_SHA..HEAD`에 `_includes/footer.html`·`_data/company.yml`을 바꾼 커밋이 없음). 시작 전 05-01 「스크래치 재확인」(가)~(마)가 그대로였고, `$W/c4/TREE`가 `C4_CAND` 트리와 같고 `$W/d10o1`~`$W/d10o3`이 있어 다시 만든 것은 없습니다. 작업 트리 `_data/company.yml`은 `C4_CAND`의 파일과 같았습니다(되살리지 않음). 값과 푸터 글은 적지 않습니다(D-02).

- 선택지 2(`SEPARATOR=opt2`)라 구분 기호 토큰 커밋 S는 없습니다.
- M4: `_data/company.yml` 하나만 스테이징해 브랜치에 붙지 않는 후보(`commit-tree`)를 만들고, 후보로 `scripts/check-site.sh`를 통과한 뒤 `build m4 <후보>`의 네 문서가 승인한 선택지 빌드 `$W/d10o2/site`와 `cmp`로 같음을 보았습니다(출력 전체 `diff -rq`도 0줄). 같은 인덱스를 커밋했고 커밋 트리가 `$W/m4/TREE`와 같습니다.
- 원격 main을 새로 받아 본 값이 `BASE_LIVE`이고 후보의 조상입니다. 범위의 사이트 커밋은 M1·M2·M3·M4 넷이고, `.planning/` 밖에서 바뀐 파일은 네 개입니다.
- 보류 브랜치 `p5-support-hold`는 아직 없습니다. 후보 트리에 `support/`가 없고 `_includes`에 `/support/` 링크가 없으며 `support_email`·`phone`이 빈 값입니다.
- 값 누출: 새로 공개되는 값 3건, 기준 커밋에 이미 있던 값 1건. 범위의 `.planning` diff와 커밋 메시지에서 0건, `.planning/` 전체 `git grep` 종료 코드 1(0건), `BASE_SHA..HEAD` 커밋 메시지 0건.
- 실제 푸시 경로: 훅을 돌릴 때 작업 트리의 `scripts/check-site.sh`·`.githooks/pre-push`가 후보와 같았고, 표준 입력만 준 `.githooks/pre-push`가 후보를 통과시켰습니다. 아무것도 푸시하지 않았습니다.

S_SHA=none
M4_SHA=57e56b07f2ab
PUSH1_CANDIDATE=57e56b07f2ab
PUSH1_PREV=84a5d9114ef3

```
check-site: 통과 (커밋 9209624d9ec7, jekyll 3.10.0)
OK m4 = approved opt2
OK origin = base-live
OK site files 4
OK hold absent
OK cand no-support
vals filled=4 emitted=3 excluded=1
leak range .planning=0 messages=0
OK hook files = push1-cand
OK hook push1-cand pass
check-site: 통과 (커밋 57e56b07f2ab, jekyll 3.10.0)
OK site-clean 05-06-t1 57e56b07f2ab
```

범위의 사이트 커밋(새 것부터):

```
57e56b07f2ab feat: 모든 페이지 푸터에 사업자 정보 표시 (상호·대표자·사업자등록번호·주소)
da940757106e build: 점검 7번 항목 추가 (지원 페이지 연락처와 /support/ 링크, 이메일 게이트)
b7e2dcd0de13 style: 푸터 사업자 줄을 항목 단위로 줄바꿈하고 푸터 링크 색을 정함
bc934fb9555e refactor: 사업자 정보 사실값 슬롯과 푸터 행 템플릿 추가 (값 없음, 출력 불변)
```

## 05-06 첫 푸시 라이브 확인

사용자가 Task 2에서 `push 57e56b07f2ab`로 답했습니다(이 푸시 한 번에만 씀). 푸시 전에 05-01 「스크래치 재확인」(가)~(마)가 그대로였고 `$W/m4/TREE`가 `PUSH1_CANDIDATE` 트리와 같아 다시 만든 것은 없습니다. 원격 main을 새로 받아 본 값이 `PUSH1_PREV`와 같았고, 훅이 부르는 작업 트리 `scripts/check-site.sh`·`.githooks/pre-push`가 후보와 같았습니다. `git push origin "${FULL}:refs/heads/main"`(전체 해시) 한 번으로 내보냈고 훅이 통과했습니다. `--no-verify`·force push는 쓰지 않았습니다.

PUSH1_SHA=57e56b07f2ab

```
OK origin unchanged = push1-prev
OK hook files = push1-cand
check-site: 통과 (커밋 57e56b07f2ab, jekyll 3.10.0)
   84a5d91..57e56b0  57e56b07f2ab5b33d767185ee676069c96213cab -> main
```

배포 완료(`pages_wait`, Pages 빌드 기록 `builds/latest`가 이 커밋·built·오류 없음):

```
OK 빌드 57e56b07f2ab built 2026-11-19T04:38:08Z
```

라이브 네 문서(`live live1 <PUSH1_SHA> "$W/m4/site"`, `?cb=<PUSH1_SHA>`)가 200·기대 제목이고 로컬 M4 빌드와 바이트가 같습니다. 라벨 수는 `$W/live1/` 네 문서의 `footblock`에서 셌습니다(값은 찍지 않음). D-11대로 랜딩 출력도 공유 푸터 때문에 바뀌었고 제목은 그대로입니다.

```
OK HTTP / 200 title=러닝펜슬 - 달리고 걷는 길이 아트가 됩니다 bytes=same
OK HTTP /privacy-policy/ 200 title=개인정보처리방침 - 러닝펜슬 bytes=same
OK HTTP /terms/ 200 title=서비스 이용약관 - 러닝펜슬 bytes=same
OK HTTP /data-deletion/ 200 title=데이터 삭제 안내 - 러닝펜슬 bytes=same
OK live labels trade=1 rep=1 bizno=1 addr=1 email=0 phone=0 docs=4
```

두 엔진 화면(`node "$W/pw/p5-foot.mjs" https://runningpencil.com '?cb=57e56b07f2ab'`, 종료 코드 0):

```
OK chromium 375 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 375 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 375 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 375 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK chromium 1280 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 375 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 375 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 375 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 375 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 / rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 /privacy-policy/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 /terms/ rows=5 spans=3 seps=2 links=0 sepLead=0
OK webkit 1280 /data-deletion/ rows=5 spans=3 seps=2 links=0 sepLead=0
PASS foot
```

이미 공개된 사업자 값·주소는 되돌려도 검색 캐시와 아카이브에 남습니다(D-10 one-way). 되돌리기는 필요 없었습니다.

LIVE_PUSH1=OK

## 05-07 사업자 정보 문서

첫 푸시의 라이브 확인(`LIVE_PUSH1=OK`) 뒤에 사업자 정보 쪽 문서를 고쳤습니다(D-21 시점). 지원 이메일·`/support/` 쪽 문서는 고치지 않았습니다(05-13). 문서 커밋은 푸시하지 않았고 게이트 푸시(05-12)가 함께 싣습니다.

Task 1 (tracer). 원본 맵 다섯 개(STACK·CONVENTIONS·ARCHITECTURE·TESTING·STRUCTURE), 이름 표, 연구 문서 Pattern 1·2를 사실값 슬롯·푸터 사업자 줄·`.size > 0`·점검 7번 항목대로 고쳤습니다. 커밋 전에 `.claude/CLAUDE.md`를 저장소 밖 임시 사본으로 생성기에 돌려, 새 문장(일곱 항목 문장, 「사실값 슬롯」 머리줄과 목록, STACK의 슬롯 줄, ARCHITECTURE의 슬롯 행, `.rp-foot-legal span`)이 모두 생성 구간에 옮겨지고 바뀐 줄이 stack·conventions·architecture 블록 안에만 있음을 확인했습니다(원본 맵 → 생성기 → `.claude/CLAUDE.md` 사슬). 연구 문서는 계획이 적은 Pattern 1(140·145-148행) 말고 Pattern 2 본문 문장 규칙(157행)에도 blank 비교가 있어 같은 판정으로 고쳤습니다. 커밋 전 작업 트리 check-site 통과, 값 누출 점검 (c) 0건(`vals filled=4 emitted=3 excluded=1`), 추가 줄의 로컬 경로 0건.

DOCS_MAPS1_SHA=f39c726f6461

Task 2. 두 CLAUDE.md 방침 표의 「사업자 정보 표시」 행 현재 상태 칸만 「Phase 5에서 적용됨 …」으로 같은 글자로 고쳤고(「지원 이메일 공개」 행은 그대로), 루트 본문에 사실값 슬롯 글머리, 푸터 include 줄·푸터 설명의 사업자 줄·주소 줄, Deploy의 점검 7번 항목을 더했습니다. `.claude/CLAUDE.md`는 저장소 밖 임시 사본으로 생성기를 먼저 돌려, 바뀐 줄이 stack·conventions·architecture 블록뿐이고 방침 구간과 project·skills·workflow·profile 블록이 그대로임을 확인한 뒤 저장소에서 출력 지정·자동 옵션 없이 다시 만들었습니다. 다시 만든 파일을 임시 사본으로 한 번 더 돌린 결과와 바이트가 같고, 두 사본의 방침 구간이 같습니다. 커밋 전 작업 트리 check-site 통과, 값 누출 점검 (c) 0건(스테이징한 전체 diff 기준도 0건).

OK generator blocks only
OK regenerated
DOCS_CLAUDE1_SHA=a37b1245702b

Task 3. README 점검 주석 괄호 끝에 「·지원 페이지 연락처」를 더했고(주석 시작 열 그대로), STATE Blockers의 가비아 DNS 1차 방문 줄을 작업 0~3 완료·남은 작업(4·5·7)으로 고치고 해소된 Phase 4 리뷰 수정 줄을 지웠습니다(D-21). STATE 구조 점검(`state.validate`)은 오류·경고 없음. 커밋 전 작업 트리 check-site 통과, 값 누출 점검 (c) 0건.

DOCS_MISC1_SHA=6856f78d7f97

훑기. 대상 열두 개(`CLAUDE.md`, `.claude/CLAUDE.md`, `README.md`, `.planning/codebase/*.md` 일곱 개, `.planning/baseline/NAMES.md`, `.planning/research/ARCHITECTURE.md`)에서 옛 항목 수 문장, 옛 「사업자 정보 표시」 현재 상태 문장, 연구 문서의 blank 비교, 로컬 경로, 새로 공개되는 사업자 값(`vals filled=4 emitted=3 excluded=1`의 패턴 파일)을 셌습니다. 모두 0이라 더한 문서 커밋은 없습니다.

```
OK stale oldcount=0 oldpolicy=0 blank=0 localpath=0 leak=0
```

DOCS1_STALE=OK

```
OK site-clean 05-07-t3 6856f78d7f97
```

## 05-08 보류 묶음

이메일 게이트 전에 지원 페이지·기대 제목·헤더/푸터 링크를 완성해 두되 어떤 게이트 전 푸시의 조상도 되지 않게, `main` 끝(`HOLD_BASE`)에서 보류 worktree `$HOLD_WT`(저장소 옆 `<저장소 폴더 이름>-p5-hold`)와 로컬 브랜치 `p5-support-hold`를 만들었습니다. 보류 worktree에서는 사이트 파일 편집과 그 커밋(`git -C "$HOLD_WT" add`·`commit`)만 했고, 판정·빌드·기록은 메인 체크아웃 `main`에서 해시로 했습니다. 보류 브랜치는 푸시하지 않았고 upstream이 없습니다.

**Task 1 (tracer).** H1은 `git cat-file blob <PROTO_SUPPORT_BLOB>`를 그대로 `support/index.html`로 담은 커밋입니다(손으로 다시 쓰지 않음). H1을 그 커밋의 `scripts/check-site.sh`로 점검하면 종료 코드 1, `실패 — 1건`, 문제는 7번 연락처 문구 하나입니다(이메일 값이 없어서, Pitfall 8). 실제 값(이메일 빈 값)으로 빌드한 지원 페이지는 `#faq`만 그리고 `dl`이 셋입니다(운영 주체·위치·계정 삭제). 가짜 이메일 빌드(`variant h1f <H1_SHA> "$W/yml/hold-email.yml"`, H1의 `_data/company.yml`에서 `support_email` 줄 하나만 `example.invalid` 도메인 가짜 주소로 바꾼 스크래치 파일)는 두 엔진 × 두 폭에서 `#contact` → `#report` → `#faq`, 연락처 `mailto:` 1개, FAQ `dl`·`dt` 넷, `#report` 앵커가 맞습니다. 헤더·푸터 링크는 H3에서 더하므로 이때는 `hdr=0 ftr=0`, 네 문서 `supportlinks=0`입니다.

HOLD_BASE=32afecdddd20
H1_SHA=48f332e57e8b

```
OK hold worktree present
check-site: 지원 페이지에 연락처(mailto)가 없습니다: 이메일 게이트 전의 /support/는 배포하지 않습니다 (D-04)
check-site: 실패 — 1건 (커밋 48f332e57e8b)
OK h1 only7
OK h1 support ids=faq dl=3 robots=0 updated=0 title=고객 지원 - 러닝펜슬 h1=러닝펜슬 고객 지원
```

가짜 이메일 빌드 두 엔진 화면(`node "$W/pw/p5-support.mjs" http://127.0.0.1:4509`, 종료 코드 0):

```
OK chromium 375 support ids=contact,report,faq mailto=1 dl=4 dt=4 hdr=0 ftr=0 anchor=ok
OK chromium 375 / supportlinks=0
OK chromium 375 /privacy-policy/ supportlinks=0
OK chromium 375 /terms/ supportlinks=0
OK chromium 375 /data-deletion/ supportlinks=0
OK chromium 1280 support ids=contact,report,faq mailto=1 dl=4 dt=4 hdr=0 ftr=0 anchor=ok
OK chromium 1280 / supportlinks=0
OK chromium 1280 /privacy-policy/ supportlinks=0
OK chromium 1280 /terms/ supportlinks=0
OK chromium 1280 /data-deletion/ supportlinks=0
OK webkit 375 support ids=contact,report,faq mailto=1 dl=4 dt=4 hdr=0 ftr=0 anchor=ok
OK webkit 375 / supportlinks=0
OK webkit 375 /privacy-policy/ supportlinks=0
OK webkit 375 /terms/ supportlinks=0
OK webkit 375 /data-deletion/ supportlinks=0
OK webkit 1280 support ids=contact,report,faq mailto=1 dl=4 dt=4 hdr=0 ftr=0 anchor=ok
OK webkit 1280 / supportlinks=0
OK webkit 1280 /privacy-policy/ supportlinks=0
OK webkit 1280 /terms/ supportlinks=0
OK webkit 1280 /data-deletion/ supportlinks=0
PASS support
```

조상 점검(`git fetch` 뒤 원격 main은 `PUSH1_SHA` 그대로)과 task 끝 깨끗함 기록:

```
OK hold not-ancestor
OK site-clean 05-08-t1 32afecdddd20
```

**Task 2.** H2는 보류 worktree의 `scripts/check-site.sh`에서 `EXPECTED_TITLES` 마지막 줄 다음에 `support/index.html|고객 지원 - 러닝펜슬` 줄을 더하고 머리 주석 3번 줄을 「기존 URL 문서 4개와 지원 페이지(/support/)가 있고 …」로 바꾼 커밋입니다(다른 줄과 실행 권한은 그대로). H2를 그 스크립트로 점검하면 3번은 지원 페이지 제목이 맞아 통과하고 7번 하나만 실패합니다. 대조로 H2의 스크립트로 라이브 M4(`PUSH1_SHA`)를 점검하면 3번 「문서가 없습니다: /support/index.html」로 실패합니다. 그래서 이 줄은 게이트 전 `main`에 들어갈 수 없습니다(Pitfall 7). 메인 체크아웃의 스크립트에는 이 줄이 없습니다(깨끗함 기록의 해시가 `HOLD_BASE`와 같음).

H2_SHA=0d49bcabfd23

```
check-site: 지원 페이지에 연락처(mailto)가 없습니다: 이메일 게이트 전의 /support/는 배포하지 않습니다 (D-04)
check-site: 실패 — 1건 (커밋 0d49bcabfd23)
OK h2 only7
check-site: 문서가 없습니다: /support/index.html
check-site: 실패 — 1건 (커밋 57e56b07f2ab)
OK h2-script on push1 fails item3
OK hold not-ancestor
OK site-clean 05-08-t2 32afecdddd20
```

**Task 3.** H3는 보류 worktree에서 `_includes/header.html` 메뉴 끝(`#get` 링크 다음, 16칸)에 `<a href="/support/">고객 지원</a>`을, `_includes/footer.html` nav 끝(`/data-deletion/` 링크 다음, 20칸)에 같은 링크를 더하고 푸터 nav의 `aria-label`을 「약관 및 지원」으로 바꾼 커밋입니다(D-18~D-20). 헤더 링크는 `home` 여부와 상관없이 절대 경로이고, 860px 이하 헤더 메뉴 숨김 규칙은 그대로입니다. 두 파일 모두 끝 줄바꿈이 없습니다. H3도 7번 하나만 실패합니다. 실제 값(이메일 빈 값) 빌드 `$W/h3`에서 다섯 문서 모두 `/support/` 링크가 헤더·푸터 두 곳이고 푸터 nav 이름이 다섯 문서에 있으며, 지원 페이지는 여전히 `#faq`만 그리고 `dl`이 셋입니다. 가짜 이메일 빌드(`variant h3f <H3_SHA> "$W/yml/hold-email.yml"`, 포트 4510)에서 1280px은 헤더·푸터 링크가 모두 보이고 375px은 헤더 메뉴가 숨어 푸터 링크만 보입니다. 푸터 측정은 가짜 이메일 줄까지 더해 `/support/`를 포함한 다섯 문서에서 통과했습니다.

H3_SHA=5100b37ade83

```
check-site: 지원 페이지에 연락처(mailto)가 없습니다: 이메일 게이트 전의 /support/는 배포하지 않습니다 (D-04)
check-site: 실패 — 1건 (커밋 5100b37ade83)
OK h3 only7
OK h3 supportlinks index=2 privacy-policy=2 terms=2 data-deletion=2 support=2
OK h3 footnav label=5
```

가짜 이메일 빌드 지원 페이지·링크(`node "$W/pw/p5-support.mjs" http://127.0.0.1:4510`, 종료 코드 0):

```
OK chromium 375 support ids=contact,report,faq mailto=1 dl=4 dt=4 hdr=0 ftr=1 anchor=ok
OK chromium 375 / supportlinks=2
OK chromium 375 /privacy-policy/ supportlinks=2
OK chromium 375 /terms/ supportlinks=2
OK chromium 375 /data-deletion/ supportlinks=2
OK chromium 1280 support ids=contact,report,faq mailto=1 dl=4 dt=4 hdr=1 ftr=1 anchor=ok
OK chromium 1280 / supportlinks=2
OK chromium 1280 /privacy-policy/ supportlinks=2
OK chromium 1280 /terms/ supportlinks=2
OK chromium 1280 /data-deletion/ supportlinks=2
OK webkit 375 support ids=contact,report,faq mailto=1 dl=4 dt=4 hdr=0 ftr=1 anchor=ok
OK webkit 375 / supportlinks=2
OK webkit 375 /privacy-policy/ supportlinks=2
OK webkit 375 /terms/ supportlinks=2
OK webkit 375 /data-deletion/ supportlinks=2
OK webkit 1280 support ids=contact,report,faq mailto=1 dl=4 dt=4 hdr=1 ftr=1 anchor=ok
OK webkit 1280 / supportlinks=2
OK webkit 1280 /privacy-policy/ supportlinks=2
OK webkit 1280 /terms/ supportlinks=2
OK webkit 1280 /data-deletion/ supportlinks=2
PASS support
```

가짜 이메일 빌드 푸터(`node "$W/pw/p5-foot.mjs" http://127.0.0.1:4510`, 종료 코드 0):

```
OK chromium 375 / rows=6 spans=4 seps=2 links=1 sepLead=0
OK chromium 375 /privacy-policy/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK chromium 375 /terms/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK chromium 375 /data-deletion/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK chromium 375 /support/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK chromium 1280 / rows=6 spans=4 seps=2 links=1 sepLead=0
OK chromium 1280 /privacy-policy/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK chromium 1280 /terms/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK chromium 1280 /data-deletion/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK chromium 1280 /support/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK webkit 375 / rows=6 spans=4 seps=2 links=1 sepLead=0
OK webkit 375 /privacy-policy/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK webkit 375 /terms/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK webkit 375 /data-deletion/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK webkit 375 /support/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK webkit 1280 / rows=6 spans=4 seps=2 links=1 sepLead=0
OK webkit 1280 /privacy-policy/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK webkit 1280 /terms/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK webkit 1280 /data-deletion/ rows=6 spans=4 seps=2 links=1 sepLead=0
OK webkit 1280 /support/ rows=6 spans=4 seps=2 links=1 sepLead=0
PASS foot
```

H1·H2·H3 모두 `only7`이고, 화면 판정(H1 `h1f`, H3 `h3f`)이 모두 통과했습니다.

HOLD_ONLY7=OK
HOLD_UI=OK

```
OK hold not-ancestor
OK site-clean 05-08-t3 32afecdddd20
```
