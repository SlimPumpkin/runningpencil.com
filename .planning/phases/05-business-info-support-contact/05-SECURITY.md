---
phase: "05"
slug: "business-info-support-contact"
status: verified
# threats_open = count of OPEN threats at or above workflow.security_block_on severity (the blocking gate)
threats_open: 0
asvs_level: 1
created: "2026-11-20"
---

# Phase 05 — Security

> Per-phase security contract: threat register, accepted risks, and audit trail.
> 근거: 계획 05-01~05-15의 `<threat_model>`(계획 단계에 작성, 47행·고유 ID 33개). 이 단계에서 한 일은 아래와 같다.
> - 사실값 슬롯 `_data/company.yml`과 푸터의 사업자 줄·주소 줄·이메일 행(값이 있을 때만 그림, 출력은 모두 `| escape`), 「공통」 CSS 두 줄, check-site 7번 항목(지원 페이지 연락처와 `/support/` 링크)을 더했다.
> - 지원 페이지 `/support/`, 3번 항목 기대 제목, 헤더·푸터 「고객 지원」 링크는 보류 브랜치에서 만들었다. 이메일 게이트(외부 4곳 수신 시험 4/4)를 통과한 뒤 `main`에 cherry-pick했고, 지원 이메일은 G 커밋 `4ea25de8d80e` 하나로 넣었다.
> - 푸시는 세 번 했다: 사업자 값 `57e56b07f2ab`, 게이트 `2bd47891b837`, 문서 `e0f233169329`.
>
> 검증은 ASVS L1(grep 수준)로 했다. 감사 시점은 HEAD `fd812832a8e3`, origin/main `e0f233169329`다. HEAD는 원격보다 문서 커밋 3개 앞서 있고, 그 3개에 `.planning/` 밖 변경은 없다. 증거는 네 가지다.
> - 저장소 명령을 다시 돌린 결과:
>   - HEAD의 `check-site.sh`로 HEAD·`2bd47891b837`·`e0f233169329`가 통과했다.
>   - `57e56b07f2ab`와 기준 `2db88d9a199f`는 그 커밋 자신의 스크립트로 통과했다. HEAD 스크립트로 돌리면 3번 항목(`/support/` 기대 제목)에서 실패하는데, 게이트 뒤 기대값이 바뀐 것이라 정상이다.
>   - 음성 객체 네 개는 모두 7번 항목으로 실패했다. 훅 경로(표준 입력만 줌)는 HEAD rc=0, 음성 두 개 rc=1이다.
>   - `bash -n` 통과, `core.hooksPath=.githooks`, 훅과 스크립트는 git 모드 100755다.
>   - 기준과 M1의 빌드 `diff -r`은 0줄이다.
>   - `05-VALIDATION.md` 기준으로 계획 verify 39개가 HEAD `95cbc2747126`에서 rc=0이었다.
> - 이력과 값 점검. 값은 화면에 찍지 않고 변수로만 셌다.
>   - 이 단계에서 새로 공개된 사업자 값 셋(대표자·사업자등록번호·주소)을 `2db88d9a199f..HEAD` 전체 경로에서 `git log -S`로 찾으면 M4 `57e56b07f2ab` 하나만 나온다.
>   - 같은 값이 HEAD의 `.planning/`·CLAUDE.md 두 사본·README와 커밋 메시지에서는 0건이다. 상호는 기준 커밋에 이미 있던 값이라 누출 대상이 아니다.
>   - 사이트 파일에 지원 주소를 처음 더한 커밋은 G이고, 게이트 기록 커밋 `9e3b9be2d0cc`가 G의 조상이다.
> - `05-EVIDENCE.md` 표식(`LIVE_PUSH1..3=OK`, `GATE_OPEN=OK`, `PHASE5_SC=OK` 등). 사용자 승인(SHA별 푸시, 설치), 수신 시험 4/4, 등록증 대조, Search Console 「확인됨」, 작업 5는 사용자 보고를 확인한 기록이다. 감사에서 다시 볼 수 없어 기록으로 판정했다.
> - 라이브 재확인(2026-11-20):
>   - 다섯 URL이 200이고 기대 제목을 돌려주며, `e0f233169329` 로컬 빌드와 바이트가 같다.
>   - 다섯 문서 푸터마다 사업자 라벨 넷과 `mailto:` 행이 하나씩 있고 「전화」는 0이다. `/support/` 링크는 문서마다 두 개다.
>   - `/`는 HTTP/2 200이고, DNS는 A 4줄·MX 1줄이다.
>
> SUMMARY 15개에는 `## Threat Flags` 구간이 없다. 계획 여러 개에 같은 행이 있는 것은 공급망 위협 T-05-SC 하나뿐이라 한 행으로 합쳤다. 다른 ID는 계획 하나에만 나온다. 고유 ID 33개의 위험도는 high 20, medium 11, low 2다.

---

## Trust Boundaries

| Boundary | Description | Data Crossing |
|----------|-------------|---------------|
| npm 레지스트리 → 로컬 스크래치 | 검증 도구 패키지와 브라우저 바이너리를 내려받는다. 저장소와 사이트에는 들어가지 않는다 (05-01) | 실행 코드(로컬 전용) |
| 기록·문서 → 공개 저장소 | `05-EVIDENCE.md`·SUMMARY·CLAUDE.md 두 사본·원본 맵·이름 표가 공개 저장소에 커밋된다. 사이트에는 exclude로 나가지 않는다 (05-01·05-05·05-07·05-13) | 판정 기록, 작업 지침(사업자 값과 주소가 섞이면 안 됨) |
| `_data/company.yml` 값 → 출력 HTML | 운영자가 넣은 값이 푸터·지원 페이지 마크업과 `mailto:` href·링크 글에 박힌다 (05-02·05-11) | 사업자 정보, 지원 주소(공개 대상) |
| 스크래치 → 저장소 객체 DB | 시험용 커밋 객체가 로컬 객체 DB에 생기지만 어떤 ref에도 붙지 않는다 (05-02) | 가짜 시험 값 |
| 저장소 → 모든 페이지 출력 | 푸터와 「공통」 CSS는 랜딩을 포함한 모든 페이지에 들어간다 (05-03) | 공유 마크업·CSS |
| 사용자 대화 → 작업 트리 `_data/company.yml` | 공개하기로 정한 사업자 값이 저장소 파일에 처음 들어온다 (05-05) | 사업자 정보 |
| 작업 트리·로컬 이력 → 공개 저장소 이력 | 커밋한 값은 지워도 이력과 포크에 남는다. 첫 푸시가 Phase 5 계획·기록과 사업자 값 커밋을 처음 공개한다 (05-05·05-06) | 사업자 정보, 기록 문서 |
| 로컬 main → 원격 main (GitHub Pages 배포) | 푸시가 곧 라이브 배포다. 마지막 관문은 pre-push 훅과 사람의 SHA 승인이다 (05-04·05-06·05-11·05-12·05-15) | 사이트 출력 전체, 지원 페이지·주소 |
| 보류 브랜치 → 원격 | 보류 커밋은 게이트 전 어떤 푸시의 조상도 되면 안 된다 (05-08) | 연락처 없는 `/support/` |
| 보류 worktree ↔ 메인 체크아웃 | 문서 커밋이 보류 브랜치에 섞이면 게이트 때 함께 움직인다 (05-08) | 사이트 파일·문서 커밋 |
| 보류 worktree 삭제 | worktree를 지워도 브랜치 ref가 원본 커밋을 붙잡는다. ref는 푸시하지 않는 로컬 이름으로만 남는다 (05-13) | 보류 커밋 |
| DNS 조회 결과 → 공개 기록 | 인증 토큰·SPF 본문·IP가 공개 저장소로 갈 수 있다 (05-09·05-14) | DNS 레코드 값 |
| 사용자 보고·수신 시험 표 → 공개 기록 | 계정 정보, 개인 주소, 시각이 공개 저장소로 갈 수 있다 (05-09·05-10·05-14) | 계정·메일 주소·시각 |
| 게이트 판정 → 이메일 공개 | 잘못 열면 받지 못하는 주소가 심사 연락처로 공개된다 (05-10) | 지원 주소 |

---

## Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation | Status |
|-----------|----------|-----------|----------|-------------|------------|--------|
| T-05-01 | Tampering | 스크래치 `playwright` 재설치 ([SUS] too-new) | high | mitigate | 05-01 Task 2 blocking-human 승인(「install — 브라우저 내려받기 포함」) 뒤에만 `playwright@1.59.1`·`pngjs@7.0.0`을 lockfile 고정으로 스크래치에만 설치함(`PW_VERSION=1.59.1`·`PW_BROWSERS`, 승인은 기록). 저장소 추적 도구 파일(`*.mjs`·`package.json`·lock·`node_modules`·`lib.sh`) 0개(재확인) | closed |
| T-05-02 | Information Disclosure | `05-EVIDENCE.md` (공개 저장소) | medium | mitigate | EVIDENCE 머리에 D-02와 경로 규칙이 있음(스크래치는 `$W`, 해시 12자리). 이 단계 기록 파일 전체에서 실제 홈 경로 0건, EVIDENCE에서 임시 폴더 실제 경로 0건(재확인) | closed |
| T-05-03 | Repudiation | 기준 출력의 출처 | medium | mitigate | `BASE_SHA=2db88d9a199f`·`BASE_LIVE=84a5d9114ef3` 기록. 두 커밋의 `.planning/` 밖 트리가 같고 `BASE_LIVE`가 첫 푸시의 조상임. 기준 커밋은 그 커밋의 check-site로 통과(재확인) | closed |
| T-05-04 | Information Disclosure | 시험 값이 저장소·푸시로 새어 나감 | medium | mitigate | 시험 값은 가짜 값이고(지원 주소 자리는 `example.invalid`) 값 파일은 스크래치에만 있음. 시험 객체 `68b96890f7f8`·`a208f0d5823d`·`bcdb59d63667`·`432a214f884d`·`24ef2f9f92d9`·`f7e64b9e2d4d`는 어떤 ref에도 없고, 원격 ref는 `refs/heads/main` 하나뿐(재확인) | closed |
| T-05-05 | Tampering | `_data` 값의 HTML 문자로 마크업이 깨짐 | medium | mitigate | `_includes/footer.html`·`support/index.html`의 `site.data` 출력 11곳 모두 `escape` 필터를 거침, 필터 없는 출력 0(재확인). 05-02 escape 경우가 `esc=6 raw=0`(`PROTO_MATRIX=OK`) | closed |
| T-05-06 | Tampering | M1이 출력을 바꾸는 리팩터가 됨 (빈 행·자리표시 노출) | high | mitigate | 기준 `2db88d9a199f`와 M1 `bc934fb9555e`의 production·`--safe` 빌드 `diff -r` 0줄(재확인, `M1_SAME=OK`). 템플릿 판정식은 `.size > 0`만 쓰고 `!=`·`==`·blank·empty 비교 0줄(재확인) | closed |
| T-05-07 | Denial of Service | 푸터 링크가 어두운 바탕에서 기본 파란색으로 읽히지 않음 | low | mitigate | `_includes/css/common.css:29`의 `.rp-foot-legal a { color: #FAFAF7; text-decoration: underline; }`(재확인). 두 엔진 측정 `FOOT_LAYOUT=OK`, 음성 대조(CSS 없는 빌드)에서 `badLink` 16곳, 라이브 `PASS foot`(05-06·05-12 기록) | closed |
| T-05-08 | Repudiation | 연락처 없는 `/support/`나 페이지 없는 링크가 라이브에 오름 (심사 반려) | high | mitigate | `scripts/check-site.sh` 7번 항목: 지원 페이지에 `href="mailto:` 필수, 페이지 없는 `href="/support/`는 실패. HEAD 스크립트로 음성 객체 `bcdb59d63667`(연락처 없음)·`432a214f884d`(페이지 없는 링크)·H1 `48f332e57e8b`·G0 `3ee770068923`가 모두 실패. 훅 경로에서 두 음성 객체 rc=1, HEAD rc=0(재확인). `432a214f884d`는 HEAD 스크립트로는 3번 항목까지 2건이다(기록 당시 M3 스크립트로는 1건). `GUARD7=OK`·`HOOK7=OK` | closed |
| T-05-09 | Tampering | grep 오류가 「못 찾음」으로 읽혀 가드가 조용히 통과 | medium | mitigate | 7번 항목이 `sup_rc`가 1보다 크면 「점검 7번 grep이 실패했습니다」로 셈(재확인, 6번 항목과 같은 방식). `bash -n` 통과 | closed |
| T-05-10 | Information Disclosure | 사업자 값이 `.planning/`·커밋 메시지·기록으로 새어 이력에 영구 보존 | high | mitigate | 새로 공개된 값 셋을 `2db88d9a199f..HEAD` 전체 경로에서 `git log -S`로 찾으면 M4 `57e56b07f2ab`(`_data/company.yml`) 하나만 나옴. 사업자등록번호 숫자만 꼴은 0. HEAD의 `.planning/`·CLAUDE.md 두 사본·README와 커밋 메시지 0건(재확인). 기록은 건수만 적음(`vals filled=4 emitted=3 excluded=1`) | closed |
| T-05-11 | Tampering | 등록증과 다른 표기가 되돌릴 수 없게 공개됨 | high | mitigate | 승인 전에는 브랜치에 붙지 않는 후보로만 빌드함. 사용자 대조 `USER_MATCH=OK`·`D10_APPROVED=OK`는 사용자 보고 기록. 승인 기록 커밋 `4530b9ac4a8f`가 M4의 조상이고, 두 시도의 후보와 M4의 `_data/company.yml` blob이 같으며, HEAD 값 넷이 M4와 같음(재확인). 시도 2 후보를 붙든 로컬 ref `refs/p5-scratch/c4-cand`가 남아 있지만 원격에는 없고 blob이 공개된 M4와 같음 | closed |
| T-05-12 | Tampering | 승인과 다른 커밋 배포 (첫 푸시) | high | mitigate | `PUSH1_SHA == PUSH1_CANDIDATE == 57e56b07f2ab`, `PUSH1_PREV=84a5d9114ef3`. 원격 추적 ref의 reflog가 `84a5d9114ef3` → `57e56b07f2ab`로 한 번 바뀜(재확인). SHA 승인은 기록 | closed |
| T-05-13 | Denial of Service | 깨진 푸터가 모든 페이지에 배포 | high | mitigate | `LIVE_PUSH1=OK`: 네 URL 200·제목·바이트, 라벨 수, 두 엔진 `PASS foot`, Pages 빌드 `built 2026-11-19T04:38:08Z`. 되돌리기는 필요 없었음. 지금 라이브 다섯 문서도 200이고 바이트가 같음(재확인) | closed |
| T-05-14 | Information Disclosure | 보류 묶음이나 지원 이메일이 첫 푸시에 섞임 (D-04) | high | mitigate | `57e56b07f2ab` 트리에 `support/`가 없고, `_includes`에 `/support/` 링크 0, `support_email`·`phone`은 빈 값(재확인). 보류 브랜치는 원격 main의 조상이 아님. 7번 항목이 백스톱 | closed |
| T-05-15 | Information Disclosure | 문서에 사업자 값·지원 주소를 적음 | high | mitigate | 문서는 키 이름으로만 가리킴. 새 사업자 값 셋은 `.planning/`·CLAUDE.md 두 사본·README에 0건(재확인, `DOCS1_STALE=OK`). 지원 주소는 CLAUDE.md 두 사본·README·`.planning/codebase/`·이 단계 폴더에 0건(재확인). 이름 표 `NAMES.md`는 설계상 정본이라 Phase 1부터 주소가 있다. 기준 문서 폴더(`.planning/baseline/`)·Phase 1 문서·연구 문서에 있는 주소도 이 단계 전부터 있던 것이다. 이 단계 범위에서 주소가 든 줄이 더해진 문서는 이름 표의 한 줄뿐(재확인) | closed |
| T-05-16 | Information Disclosure | 보류 브랜치가 푸시되거나 upstream이 걸림 (연락처 없는 `/support/` 공개) | high | mitigate | `p5-support-hold`가 origin/main의 조상이 아니고, `git branch -r --contains`가 빈 출력이며, upstream이 없음. 원격 ref는 `refs/heads/main`뿐(재확인). 훅 7번 항목이 백스톱(T-05-08) | closed |
| T-05-17 | Tampering | SUMMARY·STATE 문서 커밋이 보류 브랜치에 섞임 | medium | mitigate | `32afecdddd20..p5-support-hold`는 커밋 3개이고, 파일은 각각 `support/index.html` / `scripts/check-site.sh` / `_includes/footer.html`·`_includes/header.html`뿐(재확인) | closed |
| T-05-18 | Information Disclosure | DNS 인증 토큰·IP가 EVIDENCE에 기록됨 | medium | mitigate | EVIDENCE에 `google-site-verification=` 값과 SPF 본문 0. IP 꼴은 로컬 미리보기 루프백 주소(`127.0.0.1`, 7곳)와 공개 리졸버 판정 한 줄(`OK dns 1.1.1.1 …`, 계획 verify가 허용)뿐이고, 사이트 A 레코드 등 우리 DNS 값은 0(재확인). 개수와 종류만 기록 | closed |
| T-05-19 | Denial of Service | DNS 변경으로 사이트 HTTPS가 깨짐 | high | mitigate | 05-09·05-14가 A 4·www CNAME·challenge 1·HTTPS 200을 확인(`DNS_AFTER=OK`·`DNS_FINAL=OK`). 지금도 `/` HTTP/2 200, A 4줄·MX 1줄(재확인). Claude는 DNS를 고치지 않음 | closed |
| T-05-20 | Information Disclosure | 수신 시험 표의 개인 주소·시각이 기록됨 | medium | mitigate | 게이트 구간에는 「4/4 도착」과 서비스 이름만 있음. 그 구간에 메일 주소·시각 꼴 0(재확인) | closed |
| T-05-21 | Repudiation | 수신 확인 없이 게이트가 열림 (메일 유실, 심사 연락 실패) | high | mitigate | `RECEIVE_TEST=4/4`일 때만 `GATE_OPEN=OK`(사용자가 넘긴 표를 확인한 기록). 1차 시험 2/4 때는 열지 않았고, 필터를 만든 뒤 재시험함. 게이트 기록 커밋 `9e3b9be2d0cc`가 G `4ea25de8d80e`의 조상(재확인) | closed |
| T-05-22 | Information Disclosure | 게이트 기록보다 앞선 커밋에 주소가 들어감 (SC1 위반) | high | mitigate | 사이트 파일(`.planning/` 제외)에서 주소를 처음 더한 커밋이 G(`git log -S` 한 줄, `_data/company.yml` 한 줄 변경). `57e56b07f2ab` 사이트 이력에는 0건이고, 게이트 기록 커밋이 G의 조상(재확인). `ADDR_FIRST=4ea25de8d80e` | closed |
| T-05-23 | Tampering | `mailto:` 출력에 이스케이프 안 된 값 | low | mitigate | `mailto:` href와 링크 글 모두 `escape` 필터를 거침(`_includes/footer.html:32`, `support/index.html:13`, 재확인). 주소 값은 정본 이름 표에 있는 값과 같음(재확인) | closed |
| T-05-24 | Tampering | 승인과 다른 커밋 배포 (게이트 푸시) | high | mitigate | `PUSH2_SHA == PUSH2_CANDIDATE == 2bd47891b837`, `PUSH2_PREV=57e56b07f2ab`, reflog가 한 번 바뀜. 범위의 사이트 커밋은 H1′·H2′·H3′·G0·G 다섯(재확인) | closed |
| T-05-25 | Denial of Service | 깨진 지원 페이지·404 링크 배포 (심사 반려) | high | mitigate | `LIVE_PUSH2=OK`: 다섯 URL 200·제목·바이트, 두 엔진 `PASS support`·`PASS foot`, Pages 빌드 `built 2026-11-19T09:58:19Z`. 지금도 다섯 URL 200·바이트가 같고 문서마다 `/support/` 링크 2개(재확인). 훅 3번·7번 항목이 백스톱 | closed |
| T-05-26 | Repudiation | 보류 커밋이 main에 다 들어가기 전에 worktree를 지우거나 원본 커밋이 gc로 사라짐 | medium | mitigate | `git cherry main p5-support-hold` 세 줄이 모두 `-`. worktree 목록에는 메인 체크아웃 하나만 있고 브랜치 ref는 남음(재확인). `HOLD_WT_REMOVED=OK` | closed |
| T-05-27 | Information Disclosure | CLAUDE.md·원본 맵에 지원 주소·사업자 값을 적음 | medium | mitigate | 두 CLAUDE.md·README·`.planning/codebase/`에 지원 주소 0, 새 사업자 값 0(재확인). `DOCS2_STALE=OK` | closed |
| T-05-28 | Information Disclosure | 작업 5 보고의 계정 주소·DNS 토큰이 기록됨 | medium | mitigate | 05-14 구간에 메일 주소·토큰·IP 꼴 0(재확인). 보고는 정해진 한 줄만 받았고, DNS는 개수만 적음 | closed |
| T-05-29 | Tampering | 승인과 다른 커밋 배포, 또는 출력을 바꾸는 커밋이 섞임 (문서 푸시) | high | mitigate | `PUSH3_SHA == PUSH3_CANDIDATE == e0f233169329`, reflog가 한 번 바뀜. 범위의 `.planning/` 밖 변경은 CLAUDE.md 두 사본뿐이고 사이트 파일이 G와 같음(재확인). 라이브 바이트 = G 빌드(`LIVE_PUSH3=OK`) | closed |
| T-05-30 | Information Disclosure | 첫 푸시 범위의 기록 문서에 사업자 값 | high | mitigate | T-05-10의 이력 점검이 이 범위를 덮음: `.planning/` 이력에 새 값 0(재확인). 05-06 `leak range .planning=0 messages=0` | closed |
| T-05-31 | Information Disclosure | 주소가 게이트 기록 전 배포에 있음 | high | mitigate | 원격 main 사이트 이력에서 주소가 처음 나오는 커밋은 G이고, 첫 푸시 사이트 이력에는 0건. 게이트 기록 커밋은 G의 조상(재확인). `OK live addr first=G`, `OK sc1` | closed |
| T-05-32 | Information Disclosure | 마지막 기록에 사업자 값 | high | mitigate | 같은 이력 점검(`2db88d9a199f..HEAD`, 원격보다 앞선 문서 커밋 3개 포함)에서 새 값 0(재확인). 05-15 `leak range .planning=0 messages=0` | closed |
| T-05-SC | Tampering | npm/pip/cargo installs (계획 15개 공통) | high | mitigate | 설치는 05-01에서 한 번만, 승인 뒤 고정 버전으로 스크래치에만 함. 다른 14개 계획은 설치하지 않음. 사이트 의존성 추가 0: `Gemfile`·`Gemfile.lock`은 `2db88d9a199f` 이후 변경이 없고, 저장소에 JS 패키지 파일 0개(재확인) | closed |

*Status: open · closed · open — below high threshold (non-blocking)*
*Severity: critical > high > medium > low — only open threats at or above workflow.security_block_on count toward threats_open*
*Disposition: mitigate (implementation required) · accept (documented risk) · transfer (third-party)*

---

## Accepted Risks Log

No accepted risks.

*Accepted risks do not resurface in future audit runs.*

---

## Security Audit Trail

| Audit Date | Threats Total | Closed | Open | Run By |
|------------|---------------|--------|------|--------|
| 2026-11-20 | 33 | 33 | 0 | gsd-security-auditor (ASVS L1, block_on high, HEAD `fd812832a8e3`, origin/main `e0f233169329`). 계획 시점 register 47행을 ID 33개로 합침. 재확인 항목: check-site(HEAD·푸시 SHA·음성 객체)와 훅 경로, 기준·M1 빌드 `diff -r`, 사업자 값 이력 `git log -S`, 주소 첫 커밋과 게이트 기록 조상 관계, 보류 브랜치 상태, 라이브 다섯 URL 바이트 비교 |

---

## Sign-Off

- [x] All threats have a disposition (mitigate / accept / transfer)
- [x] Accepted risks documented in Accepted Risks Log
- [x] `threats_open: 0` confirmed
- [x] `status: verified` set in frontmatter

**Approval:** verified 2026-11-20

## Security Audit 2026-11-20

| Metric | Count |
|---|---|
| Threats found | 33 |
| Closed | 33 |
| Open | 0 |
