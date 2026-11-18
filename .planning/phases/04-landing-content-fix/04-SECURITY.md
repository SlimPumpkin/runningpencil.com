---
phase: "04"
slug: "landing-content-fix"
status: verified
# threats_open = count of OPEN threats at or above workflow.security_block_on severity (the blocking gate)
threats_open: 0
asvs_level: 1
created: "2026-11-18"
---

# Phase 04 — Security

> Per-phase security contract: threat register, accepted risks, and audit trail.
> 근거: 계획 04-01~04-13의 `<threat_model>`(계획 단계에 작성). 이 단계에서 한 일은 아래와 같다.
> - 랜딩 문구와 빈 뱃지 커밋, 「실제 앱 화면」 구간(앱 캡처 WebP 6개)을 넣었다.
> - check-site 6번 항목을 더하고 문서를 갱신했다.
> - 푸시는 네 번 했다: 사이트 `073d33e0e50a`, 문서·점검 `6e46bdcb24e0`, 스크린샷 `95062367dc69`, 문서 `9cc14903adbd`.
>
> 검증은 ASVS L1(grep 수준)로 했다. 증거는 네 가지다.
> - 저장소 명령을 다시 돌린 결과: 푸시한 SHA 네 개와 HEAD의 `check-site.sh`, 계획 verify 38개 중 37개 rc=0. 나머지 하나(04-11 T3-1)는 04-12의 계획된 문서 커밋에 대체된 시점 조건이며 `04-VALIDATION.md` 주에 적었다.
> - `04-EVIDENCE.md` 표식
> - GitHub Pages 빌드 기록 (계획 verify의 읽기 전용 조회)
> - 라이브 재확인: 내부 문서 404, WebP 6개 `image/webp`
>
> SUMMARY의 `## Threat Flags`는 모두 「None」이다. 공급망 위협 T-04-SC는 계획마다 같은 행이 있어 한 행으로 합쳤다.

---

## Trust Boundaries

| Boundary | Description | Data Crossing |
|----------|-------------|---------------|
| 로컬 문서 → 공개 저장소 | `USER-TASKS.md`·`ROADMAP.md`·`REQUIREMENTS.md`·`04-EVIDENCE.md`는 공개 저장소에 커밋된다(사이트에는 exclude로 나가지 않음) | 기록·지침 문서 |
| 기준 문장 → 검증자 | 검증자는 Goal과 요구사항 문장을 먼저 읽고 판정한다 | 판정 기준 문장 |
| npm 레지스트리 → 로컬 스크래치 | 검증 도구 패키지와 브라우저 바이너리를 내려받는다. 저장소와 사이트에는 들어가지 않는다 | 실행 코드(로컬 전용) |
| 랜딩 HTML → 심사자·크롤러·공유 미리보기 | 메타·OG·본문이 서비스 범위를 설명한다. 틀리면 「사이트와 앱 불일치」로 반려될 수 있다 | 공개 서비스 설명 |
| 랜딩 그림 → 심사자 | 그림이 앱에 없는 「못 받은 뱃지」를 보여 주면 사이트와 앱이 어긋난다 | 공개 그림 |
| 로컬 커밋 → pre-push 점검 | CI가 없어 푸시 전 로컬 판정이 유일한 자동 관문이다 | 푸시 대상 커밋 |
| 로컬 main → 원격 main (GitHub Pages 배포) | 푸시가 곧 라이브 배포다. 마지막 관문은 pre-push 훅과 사람의 승인이다 | 사이트 출력 전체 |
| GitHub Pages 운영 빌드 → 공개 사이트 | 운영 빌드가 로컬과 같은 출력을 내는지는 라이브 바이트 비교로 확인한다 | 공개 HTML·이미지 |
| 원본 맵 → `.claude/CLAUDE.md` 생성 구간 → 모든 작업 세션 | 원본 맵이 이후 모든 세션의 지침으로 다시 생성된다 | 작업 지시 문장 |
| 저장소 문서 → 공개 사이트 | `_config.yml` exclude와 check-site 2번 항목이 내부 문서를 사이트에서 뺀다 | 내부 문서 |
| 사용자 기기 캡처 → 공개 사이트·공개 저장소 | 캡처 속 정보는 커밋·배포되면 git 이력과 웹 보관소에 남아 지울 수 없다 | 앱 화면 이미지(개인 정보 가능) |
| 이미지 파일 메타데이터 → 공개 | PNG의 기기·시각·색 프로필 정보가 그대로 실리면 공개된다 | EXIF·XMP·ICC |
| 네이버 지도 화면 → 홍보 페이지 | 제3자 지도 화면을 쓰는 데 약관상 해석 여지가 있다 (RESEARCH Q1) | 제3자 지도 화면 |
| GitHub Pages → 브라우저 (이미지) | 이미지의 `content-type`과 캐시가 표시를 좌우한다 | WebP 6개 |
| 검증 기록 → 단계 검증 | 판정표가 `/gsd-verify-work`의 근거가 된다 | 판정 기록 |

---

## Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation | Status |
|-----------|----------|-----------|----------|-------------|------------|--------|
| T-04-01 | Information Disclosure | `USER-TASKS.md` 작업 10 (공개 저장소) | medium | mitigate | 절차서에 캡처·콘솔 값·출시 시기를 적지 않음. `USER-TASKS.md`에 로컬 경로 0줄. 추적 이미지는 `favicon/`·`images/app/*.webp`뿐이고 캡처 원본(PNG·HEIC·JPEG) 0개 | closed |
| T-04-02 | Repudiation | 기준 문장을 구현에 맞춰 고침 | low | mitigate | 근거 D-08, 바꾼 곳은 Phase 4의 세 줄. 04-01 verify 2개 재실행 rc=0 (Phase 4 줄의 「출시 예정」 0, Phase 9 줄 유지) | closed |
| T-04-03 | Tampering | 스크래치 `playwright` 설치 ([SUS] too-new) | high | mitigate | 04-02 Task 2 blocking-human 승인 뒤에만 1.59.1 고정 pnpm 설치. EVIDENCE `PW_VERSION=1.59.1`·`PW_BROWSERS`. 저장소 추적 도구 파일(`p4-*.mjs`·`lib.sh`·`package.json`·lock·`node_modules`) 0개. 04-02 verify 재실행 rc=0 | closed |
| T-04-04 | Information Disclosure | `04-EVIDENCE.md` (공개 저장소) | medium | mitigate | 스크래치 경로는 `$W`, 해시는 12자리로 적음. EVIDENCE·SUMMARY 13개·VALIDATION에 실제 홈 경로·임시 폴더 경로 0건(재확인) | closed |
| T-04-05 | Repudiation | 기준 출력의 출처 | medium | mitigate | `BASE_SHA=0e75e8b88fd2`, `BASE_LIVE=0bfe5b210c3c` 기록. 음성 대조 `BEHAVE_NEG=OK`. 04-02 Task 1 verify(사이트 트리·`$W/base/TREE`) 재실행 rc=0 | closed |
| T-04-06 | Spoofing | 랜딩 문구가 출시 앱에 없는 기능을 약속함 (심사자 오인) | medium | mitigate | HEAD `index.html`에 포인트·굿즈·코스북·실루엣·「채울 뱃지」 0줄. 라이브 `/` 세 낱말 0(04-13 `SC1 OK live / words=0`). 04-03 verify 재실행 rc=0 | closed |
| T-04-07 | Denial of Service | 랜딩 스크립트 계약 깨짐 (null 확인 없는 id 참조) | medium | mitigate | 후보에서 두 엔진 × 세 문맥 `PASS behave`일 때만 커밋(`C1_OK=OK`). 라이브 `PASS behave`(04-13 `SC3 OK`) | closed |
| T-04-08 | Denial of Service | 랜딩 스크립트 계약(`data-step`·뱃지 개수) 깨짐 | medium | mitigate | `C2_OK=OK`(`badges=7 stickers=6`, `PASS behave`). 04-04 verify 재실행 rc=0 | closed |
| T-04-09 | Tampering | 디자인 토큰 바깥 색이 섞임 | low | mitigate | 커밋 전후 hex 비교 `OK hex no-new` (EVIDENCE 2곳). 04-04 Task 1 verify 재실행 rc=0 | closed |
| T-04-10 | Tampering | 승인과 다른 커밋 배포 (첫 사이트 푸시) | high | mitigate | `PUSH1_SHA == PUSH1_CANDIDATE == 073d33e0e50a`, 원격 조상 관계. 04-05 verify 재실행 rc=0 | closed |
| T-04-11 | Denial of Service | 깨진 랜딩 배포 (심사 콘솔에 등록된 홈페이지) | high | mitigate | `LIVE_PUSH1=OK`(HTTP·제목·바이트 비교·`p4-behave.mjs`). 되돌리기는 필요 없었다 | closed |
| T-04-12 | Repudiation | 라이브 확인 기록 위조·옛 빌드 판정 | medium | mitigate | 04-05·04-08·04-11·04-13 verify가 기록의 `OK 빌드` 줄을 Pages 빌드 기록(커밋·created_at·built·오류 없음)과 대조, 재실행 rc=0. 라이브 요청은 `?cb=` 사용 | closed |
| T-04-13 | Information Disclosure | 처음 공개되는 기록 문서의 로컬 경로 | low | mitigate | 푸시 후보마다 범위의 더해진 줄에서 로컬 경로·토큰 꼴을 찾아 승인 단계에서 보여 줌(04-13 `REVIEW hits=0`). 기록 문서 실제 경로 0건(재확인) | closed |
| T-04-14 | Tampering | 이후 단계의 출시 범위 밖 기능 이름 재유입 | medium | mitigate | check-site 6번 항목(`CHECK6=OK`), 기준 커밋 음성 대조 기록. 04-06 verify 재실행 rc=0. 푸시한 네 SHA와 HEAD의 check-site 통과 | closed |
| T-04-15 | Denial of Service | 점검 스크립트 문법 오류로 모든 푸시가 막힘 | medium | mitigate | `bash -n scripts/check-site.sh` 통과, `core.hooksPath=.githooks`, 훅·스크립트 100755. 실제 훅 경로 통과(04-13 Task 1) | closed |
| T-04-16 | Tampering | `.claude/CLAUDE.md` 생성 구간 손 편집 (04-07) | medium | mitigate | 04-07 verify(저장소 파일과 재생성 사본 바이트 동일) 재실행 rc=0 | closed |
| T-04-17 | Repudiation | 방침 구간 두 사본의 어긋남 (04-07) | low | mitigate | 두 사본을 같은 커밋에서 고침. HEAD에서 두 사본의 방침 구간 글자 동일(재확인) | closed |
| T-04-18 | Tampering | 승인과 다른 커밋 배포 (문서·점검 푸시) | high | mitigate | `PUSH2_SHA == PUSH2_CANDIDATE == 6e46bdcb24e0`, 원격 조상 관계. 04-08 verify 재실행 rc=0 | closed |
| T-04-19 | Information Disclosure | 내부 문서(`CLAUDE.md`·`README.md`·점검 스크립트)가 사이트로 공개됨 | medium | mitigate | check-site 2번 항목 통과. 라이브 `/CLAUDE.md`·`/README.md`·`/.claude/CLAUDE.md`·`/scripts/check-site.sh` 모두 404(재확인) | closed |
| T-04-20 | Information Disclosure | 캡처 속 개인 정보(실명·계정 주소·집 근처 위치) | high | mitigate | 시험 계정·시험 경로로 촬영. 04-09 Claude 검토 27항목 `CAPTURE_REVIEW=OK`(사용자 예외 `CAPTURE_WAIVERS=3`은 로고 가림 1건·상태 표시줄 2건으로 개인 정보 아님). 04-11에서 사용자가 검토 줄과 화면을 보고 승인 | closed |
| T-04-21 | Information Disclosure | EXIF·XMP·ICC 메타데이터 | medium | mitigate | 저장소 WebP 6개 모두 `webpinfo`에서 EXIF·XMP·ICCP 청크 0(재확인) | closed |
| T-04-22 | Information Disclosure | 캡처 원본과 그 위치(로컬 경로) | medium | mitigate | 원본은 스크래치 사본으로만 씀. 추적 PNG·HEIC 원본 0개, 기록의 로컬 경로 0건(재확인). 04-09 Task 3 verify 재실행 rc=0 | closed |
| T-04-23 | Repudiation | 네이버 지도 화면 사용의 약관 위험 | medium | mitigate | 출처 표기(구간 아래 「지도 © NAVER Corp.」)와 제휴 오인 문구 금지(제휴·공식 0)는 지킴. 로고는 ①·②가 온전하다. ③ 완주 결과는 원본에서 앱의 뱃지 창이 로고 오른쪽을 덮고 있어 `logo` 검토 항목이 FAIL이었고, 사용자 예외(D-20, 2026-11-18)로 그대로 쓴다. 웹페이지가 원본보다 더 자르거나 덮지 않는 조건은 지킴(EVIDENCE `WAIVER badge logo`, 04-10 구간 화면 검토). 남는 위험은 아래 Accepted Risks Log의 AR-04-01(약관 해석)과 AR-04-02(③ 로고 가림) | closed |
| T-04-24 | Repudiation | 지도 출처 줄이 `#get`에 가려져 표기하지 않은 것처럼 보임 | medium | mitigate | 라이브 `p4-shots.mjs` (e) 두 엔진 × 두 폭 통과(04-13 판정표 `PASS shots`) | closed |
| T-04-25 | Denial of Service | 새 구간이 랜딩 스크립트 계약을 깸 | medium | mitigate | 새 이름 `rp-shots*`·`screens`는 스크립트 계약 이름과 겹치지 않음. 04-10 Task 2 verify(스크립트 블록 바이트 동일·`PASS behave`) 재실행 rc=0. 라이브 `PASS behave` | closed |
| T-04-26 | Spoofing | 네이버와 제휴한 것처럼 보이는 문구 | medium | mitigate | HEAD `#screens` 구간에 「제휴」「공식」 0, 출처는 저작권 귀속 꼴 「지도 © NAVER Corp.」(재확인). `p4-shots.mjs` (f) 통과 | closed |
| T-04-27 | Tampering | 외부 출처 이미지·스크립트 유입 (ASVS V14) | low | mitigate | HEAD `#screens` 구간에 `http(s)://`·`<script` 0(재확인). 이미지는 같은 도메인 `/images/app/`뿐 | closed |
| T-04-28 | Tampering | 승인과 다른 커밋, 판정하지 않은 사이트 커밋 배포 (스크린샷 푸시) | high | mitigate | `PUSH3_SHA == PUSH3_CANDIDATE == 95062367dc69`, 원격 조상 관계. C3 사이트 트리 == 판정 후보 `CAND3`(04-11 Task 1). 04-11 Task 1·3-2 verify 재실행 rc=0 | closed |
| T-04-29 | Information Disclosure | 개인 정보·출시 범위 밖 화면이 담긴 캡처의 영구 공개 | high | mitigate | 승인 전에는 캡처 커밋이 어떤 브랜치에도 없었음(04-10·04-11 Task 1). 사용자가 검토 줄 전체와 구간 화면·WebP를 보고 승인한 뒤에만 푸시(`LIVE_PUSH3=OK`) | closed |
| T-04-30 | Denial of Service | 이미지가 잘못된 형식으로 서빙되어 안 보임 (A10) | medium | mitigate | 라이브 WebP 6개 모두 200·`content-type: image/webp`(재확인). 04-11 `OK IMG … image/webp same` 6줄 | closed |
| T-04-31 | Tampering | `.claude/CLAUDE.md` 생성 구간 손 편집 (04-12) | medium | mitigate | 04-12 Task 3 verify(재생성 사본 바이트 동일) 재실행 rc=0 | closed |
| T-04-32 | Repudiation | 문서와 사이트의 어긋남(옛 「외부 이미지 없음」 규칙) | low | mitigate | `DOCS2_STALE=OK`(문서 열 개 옛 문장 0줄). 두 사본 방침 구간 글자 동일. 문서는 `9cc14903adbd`로 라이브와 맞춤 | closed |
| T-04-33 | Tampering | 승인과 다른 커밋 배포 (D-24 문서 푸시) | high | mitigate | 사용자가 SHA `9cc14903adbd`를 보고 push로 답함. `PUSH4_SHA == PUSH4_CANDIDATE == origin/main == 9cc14903adbd`(원격이 승인 SHA와 정확히 같음, 뒤 로컬 커밋은 나가지 않음). 04-13 verify 재실행 rc=0 | closed |
| T-04-34 | Repudiation | 판정표를 앞 기록 복사로 채움 | medium | mitigate | 04-13 Task 3이 라이브에서 세 낱말·`p4-shots.mjs`·`p4-behave.mjs`를 다시 돌려 출력을 붙임. verify가 저장한 라이브 `/`를 다시 검사하고 Pages 빌드 기록(`built 2026-11-18T07:57:50Z`)과 대조, 재실행 rc=0 | closed |
| T-04-SC | Tampering | npm/pip/cargo installs (계획 13개 공통) | high | mitigate | 설치는 04-02에서 한 번, 승인 뒤 정확한 고정 버전으로 스크래치에만. 사이트 의존성 추가 0(`Gemfile`·`Gemfile.lock`은 `BASE_SHA` 이후 변경 없음, 저장소에 JS 패키지 파일 0개). 다른 계획은 설치하지 않음 | closed |

*Status: open · closed · open — below high threshold (non-blocking)*
*Severity: critical > high > medium > low — only open threats at or above workflow.security_block_on count toward threats_open*
*Disposition: mitigate (implementation required) · accept (documented risk) · transfer (third-party)*

---

## Accepted Risks Log

| Risk ID | Threat Ref | Rationale | Accepted By | Date |
|---------|------------|-----------|-------------|------|
| AR-04-01 | T-04-23 | 연구에서 캡처 사용을 직접 다룬 NAVER 약관 조항을 찾지 못했다. 다만 Maps 약관 제7조 ⑨⑪을 넓게 읽으면 걸릴 여지가 있다. 서면 문의는 하지 않았고, 네이버가 지정 표시를 요청하면 그 표시로 바꾼다. 진행 조건 가운데 출처 표기와 제휴 오인 문구 금지는 구현으로 지켰고, 로고 조건은 ③에서 AR-04-02의 예외가 있다 (`04-CONTEXT.md` D-20 「연구 뒤 사용자 결정」) | 사용자 (plan-phase 결정 「위험을 알고 진행」) | 2026-11-17 |
| AR-04-02 | T-04-23 | ③ 완주 결과 원본에서 앱의 뱃지 창이 지도 왼쪽 아래 NAVER 로고의 오른쪽을 덮는다(앞 세 글자만 보임). 웹페이지가 자르거나 덮은 것이 아니라 앱 화면 자체의 모습이다. NAVER 지도 SDK 가이드는 로고가 앱 UI 요소에 가려지지 않게 하라고 한다(`04-RESEARCH.md` Q3). 사용자는 이 문장과 위험을 들은 뒤 그대로 쓰기로 했다. 앱에서 로고나 뱃지 창 위치를 고치면 badge만 다시 찍어 바꾼다 (`04-CONTEXT.md` D-20 「캡처 검토 뒤 사용자 결정」, EVIDENCE `WAIVER badge logo`) | 사용자 (04-09 Task 3 캡처 검토 뒤 결정) | 2026-11-18 |

*Accepted risks do not resurface in future audit runs.*

---

## Security Audit Trail

| Audit Date | Threats Total | Closed | Open | Run By |
|------------|---------------|--------|------|--------|
| 2026-11-18 | 35 | 35 | 0 | secure-phase 오케스트레이터 (ASVS L1, auditor 생략: threats_open 0 + 계획 시점 register + L1) |
| 2026-11-18 (재감사, HEAD `65c0c3970dae`) | 35 | 35 | 0 | secure-phase 오케스트레이터. 코드 리뷰 수정(IN-01~IN-08)이 닿은 위협만 다시 확인: T-04-06 세 낱말·실루엣·「채울 뱃지」 0, T-04-07·08·25 `PASS behave`(두 엔진 × 세 문맥), T-04-09 `c3` 대비 새 hex 0, T-04-14·15 check-site 통과·`bash -n`·훅 100755·기준 커밋 음성 대조(6번 항목 「/index.html 5곳」 실패), T-04-16·17·31 재생성 사본 바이트 동일·방침 구간 두 사본 동일, T-04-21 WebP 메타 0, T-04-33 `origin/main == 9cc14903adbd`(뒤 로컬 커밋은 나가지 않음) |
| 2026-11-18 (재감사, HEAD `8a6a4545eefc`) | 35 | 35 | 0 | secure-phase 오케스트레이터. 세 번째·네 번째 코드 리뷰 수정(WR-02~WR-04·IN-09~IN-12)이 바꾼 파일은 `index.html`(거리·시간 표기 8줄)·`scripts/check-site.sh`(6번 항목 형식 확인·건너뛰기)·`.claude/CLAUDE.md`(`<head>` 순서 1줄)뿐이라 닿는 위협만 다시 확인: T-04-06 HEAD 빌드 세 낱말·실루엣·「채울 뱃지」 0, T-04-07·08·25 `PASS behave`(두 엔진 × 세 문맥, `badges=7 stickers=6 empty=0`), T-04-09 `c3` 대비 새 hex 0, T-04-14·15 check-site HEAD 통과·`bash -n`·훅 100755·기준 커밋 음성 대조(「/index.html 5곳」 실패)·`U10_ALLOW_PREFIX` 형식 오류 사본 세 개 모두 실패, T-04-16·31 재생성 사본 바이트 동일(`REGEN_IDENTICAL=OK`), T-04-21 WebP 메타 0, T-04-26·27 `#screens`에 외부 URL·`<script`·「제휴」「공식」 0, T-04-33 `origin/main == 9cc14903adbd`(로컬 50커밋은 나가지 않음) |

---

## Sign-Off

- [x] All threats have a disposition (mitigate / accept / transfer)
- [x] Accepted risks documented in Accepted Risks Log
- [x] `threats_open: 0` confirmed
- [x] `status: verified` set in frontmatter

**Approval:** verified 2026-11-18

## Security Audit 2026-11-18

| Metric | Count |
|---|---|
| Threats found | 35 |
| Closed | 35 |
| Open | 0 |
