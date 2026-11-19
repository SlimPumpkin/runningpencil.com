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
