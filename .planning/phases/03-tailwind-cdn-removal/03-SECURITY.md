---
phase: "03"
slug: "tailwind-cdn-removal"
status: verified
# threats_open = count of OPEN threats at or above workflow.security_block_on severity (the blocking gate)
threats_open: 0
asvs_level: 1
created: "2026-11-16"
---

# Phase 03 — Security

> Per-phase security contract: threat register, accepted risks, and audit trail.
> 근거: 계획 03-01~03-09의 `<threat_model>`(계획 단계에 작성). 이 단계는 법적 페이지 3종을 Tailwind Play CDN에서 정적 CSS(`_includes/css/legal.css`)로 바꾸는 사이트 커밋 ①②③과 점검 커밋, nowrap 커밋, 그리고 푸시 두 번(사이트 푸시 `2ebeca06ca51`, 문서 푸시 `3f148e83d849`)이다. 검증은 ASVS L1(grep 수준)로 했다. 증거는 세 가지다: 저장소 명령을 다시 돌린 결과(커밋별 `check-site.sh`, 음성 대조, 계획 verify 31개 rc=0), `03-EVIDENCE.md` 표식, GitHub Pages 빌드 기록(계획 verify의 읽기 전용 조회). SUMMARY에는 `## Threat Flags` 항목이 없다. 공급망 위협 T-03-SC는 계획마다 같은 행이 있어 한 행으로 합쳤다.

---

## Trust Boundaries

| Boundary | Description | Data Crossing |
|----------|-------------|---------------|
| 서드파티 CDN 스크립트 → 심사자 브라우저 | 지금까지 법적 페이지는 버전이 고정되지 않은 외부 JS(실행 권한)를 동기로 불러 렌더했다 | 실행 코드, 페이지 전체 렌더 |
| `cdn.tailwindcss.com` → 기준 캡처 | 버전이 고정되지 않은 CDN이 기준 화면을 만든다. 그 버전이 기준의 일부다 | 기준 PNG·텍스트 |
| npm 레지스트리 → 로컬 스크래치 | 검증 도구 패키지와 브라우저 바이너리를 내려받는다. 저장소와 사이트에는 들어가지 않는다 | 실행 코드(로컬 전용) |
| 저장소 `_includes/` → 빌드 출력 | 새 include 파일이 빌드 때 인라인된다. 원본 조각 자체가 사이트에 공개되면 안 된다 | CSS 원본 |
| 레이아웃 CSS → 사이트 공통 머리말·바닥글 | 법적 페이지 CSS가 공통 블록에 새면 헤더·푸터·랜딩 모양이 바뀐다 | 공개 HTML 모양 |
| 저장소 본문 → 심사자가 보는 법적 문서 | 마크업만 바꾸는 커밋이 문장을 바꾸면 법적 고지 내용이 바뀐다 | 법적 문장 |
| 스크래치 시험 본문 → 저장소 | 시험 본문은 사실처럼 보이는 법적 문장이 될 수 있어 사이트에 나가면 안 된다 | 시험용 법적 문장 |
| 새 요소 CSS → 이후 단계 문서 | 이 단계에서 정한 표·목록 모양을 Phase 5~9 문서가 그대로 쓴다 | 본문 작성 규칙 |
| 로컬 커밋 → pre-push 점검 | CI가 없어 훅이 마지막 자동 관문이다 | 푸시 대상 커밋 |
| 로컬 main → 원격 main (GitHub Pages 배포) | 푸시가 곧 라이브 배포다. 마지막 관문은 pre-push 훅과 사람의 승인이다 | 사이트 출력 전체 |
| GitHub Pages 운영 빌드 → 공개 사이트 | 새 include 파일이 생긴 뒤 운영 빌드가 로컬과 같은 출력을 내는지는 사이트 푸시에서 처음 확인된다 | 법적 3종 HTML |
| 로컬 기록·문서 → 공개 저장소 | `03-EVIDENCE.md`, 원본 맵, `CLAUDE.md`·`README.md`는 공개 저장소에 커밋된다(사이트에는 exclude로 나가지 않음) | 기록·지침 문서 |
| 원본 맵 → `.claude/CLAUDE.md` 생성 블록 → 모든 작업 세션 | 생성기가 원본을 그대로 옮기므로 틀린 사실이 이후 모든 세션의 지침이 된다 | 작업 지시 문장 |

---

## Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation | Status |
|-----------|----------|-----------|----------|-------------|------------|--------|
| T-03-01 | Tampering | 스크래치 `playwright` 설치 ([SUS] too-new) | high | mitigate | 03-01 Task 2 blocking-human 승인 뒤에만 1.59.1 고정으로 스크래치에 설치(사용자 지시로 pnpm 10.33.2). EVIDENCE `PW_VERSION=1.59.1`·`PNGJS_VERSION=7.0.0`·설치 승인 기록. 저장소 추적 도구 파일(`package.json`·lock·`node_modules`·`.mjs`) 0개 | closed |
| T-03-02 | Information Disclosure | `03-EVIDENCE.md` (공개 저장소) | medium | mitigate | 스크래치 경로는 `$W`, 해시는 12자리로 적음. EVIDENCE·SUMMARY에서 홈 경로·임시 폴더 실제 경로·`$HOME` 0건(재확인) | closed |
| T-03-03 | Repudiation | 기준 캡처의 출처 | medium | mitigate | `BASE_SHA=8b65fdb59232`, `BASE_LIVE=9f715c795830` 기록. 03-01 verify(기준과 원격 main의 사이트 트리 동일, `$W/base/TREE`) 재실행 rc=0. 기준 커밋을 그 커밋의 check-site로 다시 점검해 통과 | closed |
| T-03-04 | Tampering | CDN 버전이 단계 도중 바뀜 | medium | mitigate | `TW_CDN_VERSION=3.4.17` 기록과 캡처 직전 리디렉션 재확인 기록(EVIDENCE 5곳) | closed |
| T-03-05 | Information Disclosure | `_includes/css/legal.css` 원본 노출 | low | mitigate | `scripts/check-site.sh`의 `FORBIDDEN`에 `_includes` 포함. 커밋별 check-site 재실행(①②③·점검·nowrap·두 푸시·HEAD) 모두 통과 | closed |
| T-03-06 | Tampering | 범위 없는 선택자가 헤더·푸터·랜딩을 바꿈 | medium | mitigate | `legal.css`에 범위 없는 본문 요소 선택자 0줄(grep). `git diff BASE..HEAD -- _includes/css/common.css index.html` 0줄. 전체 페이지 픽셀 0(`C1_PIXEL=OK`, `JUDGE c1 OK`) | closed |
| T-03-07 | Tampering | 과도기 캐스케이드가 잘못된 값을 가림 | medium | mitigate | ③ 미리보기 `JUDGE c1p OK`, `C1_PREVIEW3=OK` (Tailwind 없이 같은 CSS 판정) | closed |
| T-03-08 | Tampering | 법적 문서 문장 (클래스 제거 중 변경) | high | mitigate | `JUDGE c2 OK`, `C2_PIXEL=OK`(렌더 텍스트 18건 기준과 동일), 03-03 verify(② 커밋과 부모의 원본 텍스트 동일 재계산) 재실행 rc=0 | closed |
| T-03-09 | Repudiation | 다음 단계 몫(noindex·임시 게시본·포인트 문장)의 조기 삭제 | medium | mitigate | 세 법적 문서 모두 `noindex: true`와 「임시 게시본」 유지(3/3, 3/3). 03-03 Task 2 verify 재실행 rc=0 | closed |
| T-03-10 | Tampering | `cdn.tailwindcss.com` 런타임 스크립트 (ASVS V14 서드파티 구성요소) | high | mitigate | 레이아웃·원본 HTML의 `cdn.tailwindcss.com`·`tailwind.config` 0건(git grep). `JUDGE c3 OK`(`--no-cdn`, 브라우저 요청 0), 라이브 `OK HTTP … tailwind=0` 세 줄, `JUDGE live OK`. 남는 외부 자원은 Pretendard CSS(실행 코드 아님, SRI는 계획에서 Deferred) | closed |
| T-03-11 | Tampering | 이후 단계의 Tailwind 재유입 | medium | mitigate | check-site 5번 항목(`CHECK5=OK`). 음성 대조 재실행: 점검 커밋의 스크립트로 ②를 점검하면 `Tailwind Play CDN이 출력에 남아 있습니다`로 실패. `core.hooksPath=.githooks`, 훅·스크립트 100755 | closed |
| T-03-12 | Denial of Service | Preflight 없이 깨진 법적 페이지 | medium | mitigate | 커밋 ③ 전체 페이지 2엔진 × 3폭 픽셀 0과 hover·focus(`JUDGE c3 OK`, `C3_PIXEL=OK`) | closed |
| T-03-13 | Information Disclosure | 시험 본문 `sample/index.html` 공개 | medium | mitigate | `git ls-files`에 `sample/` 0건. 03-05 verify 재실행 rc=0 | closed |
| T-03-14 | Denial of Service | 넓은 표가 375px 페이지를 가로로 밀어 본문을 읽기 어렵게 함 | medium | mitigate | `SAMPLE=OK`(375px `scrollWidth ≤ 375`, 넓은 표의 figure 안 넘침, 두 엔진) | closed |
| T-03-15 | Tampering | 줄바꿈 정책 변경이 기존 페이지 모양을 바꿈 | low | mitigate | nowrap 커밋 `fb6bdfa40b70`이 기준과 픽셀 0(`JUDGE nw OK`, `NOWRAP_PIXEL=OK`) | closed |
| T-03-16 | Tampering | 승인과 다른 커밋 배포 (사이트 푸시) | high | mitigate | `SITE_PUSH_SHA == SITE_PUSH_CANDIDATE == 2ebeca06ca51`, 원격 조상 관계. 03-06 verify 재실행 rc=0 | closed |
| T-03-17 | Denial of Service | 깨진 법적 페이지 배포 (심사 콘솔 URL) | high | mitigate | `LIVE_SITE=OK`(라이브 PNG 42장 기준과 픽셀 0, HTTP 200·제목·Tailwind 0). 되돌리기는 필요 없었다 | closed |
| T-03-18 | Repudiation | 라이브 확인 기록 위조·옛 빌드 판정 | medium | mitigate | 03-06·03-09 verify가 기록의 `OK 빌드` 줄을 Pages 빌드 기록(커밋·created_at·built·오류 없음)과 대조, 재실행 rc=0. 라이브 판정은 `?cb=` 쿼리 사용 | closed |
| T-03-19 | Information Disclosure | 처음 공개되는 기록 문서의 로컬 경로 | low | mitigate | 사이트 푸시 후보 범위의 검토 항목(로컬 경로·토큰 꼴) 결과를 EVIDENCE에 적고 승인 단계에서 보여 줌 | closed |
| T-03-20 | Information Disclosure | 원본 맵 (공개 저장소) | low | mitigate | `DOCS_STALE=OK`(열 개 문서 Tailwind 흔적·로컬 경로 0줄). 문서 푸시 후보 검토 항목 0줄 | closed |
| T-03-21 | Tampering | 생성 원본과 생성 블록의 불일치 | low | mitigate | 03-07 verify(생성기 사본에서 세 블록 밖 동일) 재실행 rc=0 | closed |
| T-03-22 | Tampering | `.claude/CLAUDE.md` 생성 구간 손 편집 | medium | mitigate | 03-08 verify(저장소 파일과 재생성 사본 바이트 동일) 재실행 rc=0 | closed |
| T-03-23 | Information Disclosure | 문서의 로컬 경로·사용자 사실값 | low | mitigate | `DOCS_STALE=OK`(로컬 경로 0줄). 지원 이메일·사업자 값 기재 없음 | closed |
| T-03-24 | Repudiation | 방침 구간 두 사본의 어긋남 | low | mitigate | 두 사본을 같은 커밋 `19dbbe78627c`에서 고침. 03-08 verify(구간 글자 동일) 재실행 rc=0 | closed |
| T-03-25 | Tampering | 승인과 다른 커밋 배포 (문서 푸시) | high | mitigate | `DOCS_PUSH_SHA == DOCS_PUSH_CANDIDATE == 3f148e83d849`, 원격 조상 관계. 사용자가 그 SHA를 보고 push로 답함. 03-09 verify 재실행 rc=0 | closed |
| T-03-26 | Information Disclosure | 문서 파일이 사이트로 공개됨 (`/CLAUDE.md`, `/README.md`) | medium | mitigate | 훅의 check-site 2번 항목(`FORBIDDEN`에 `CLAUDE.md`·`README.md`) 통과. 배포 뒤 두 경로는 200이 한 번도 없고 원 서버 응답은 모두 404(재확인 12/12 404). 첫 읽기의 CDN 가장자리 일시 503은 사용자 결정으로 404 판정(EVIDENCE `## 03-09 503 판정과 사용자 결정`) | closed |
| T-03-27 | Repudiation | 성공 기준 판정의 근거 부족·범위 숨김 | medium | mitigate | EVIDENCE `## Phase 3 성공 기준 판정` 표가 기준마다 근거 표식을 가리키고 범위 밖(실제 Safari·iOS, 다른 폭, D-08, D-07)을 적음. `PHASE3_SC=OK`. 03-09 verify 재실행 rc=0 | closed |
| T-03-28 | Denial of Service | 문서 푸시 뒤 라이브 이상 | low | mitigate | 배포 뒤 HTTP 확인 실행. 일시 503 FAIL에 계획대로 로컬 되돌리기(1~2번)를 하고 blocking-human 결정을 받음(사용자: 되돌리기 푸시 없이 404 판정, 로컬 되돌림 커밋은 푸시 없이 제거). 라이브 법적 3종 200·제목·Tailwind 0 | closed |
| T-03-SC | Tampering | npm/pip/cargo installs (계획 9개 공통) | high | mitigate | 설치는 03-01에서 한 번, 승인 뒤 정확한 고정 버전으로 스크래치에만. 사이트 의존성 추가 0(`Gemfile`·`Gemfile.lock`은 BASE 이후 변경 없음, 저장소에 JS 패키지 파일 0개). 03-02~03-09는 설치하지 않음 | closed |

*Status: open · closed · open — below high threshold (non-blocking)*
*Severity: critical > high > medium > low — only open threats at or above workflow.security_block_on count toward threats_open*
*Disposition: mitigate (implementation required) · accept (documented risk) · transfer (third-party)*

---

## Accepted Risks Log

| Risk ID | Threat Ref | Rationale | Accepted By | Date |
|---------|------------|-----------|-------------|------|

No accepted risks.

*Accepted risks do not resurface in future audit runs.*

---

## Security Audit Trail

| Audit Date | Threats Total | Closed | Open | Run By |
|------------|---------------|--------|------|--------|
| 2026-11-16 | 29 | 29 | 0 | secure-phase 오케스트레이터 (ASVS L1, auditor 생략: threats_open 0 + 계획 시점 register + L1) |

---

## Sign-Off

- [x] All threats have a disposition (mitigate / accept / transfer)
- [x] Accepted risks documented in Accepted Risks Log
- [x] `threats_open: 0` confirmed
- [x] `status: verified` set in frontmatter

**Approval:** verified 2026-11-16

## Security Audit 2026-11-16

| Metric | Count |
|---|---|
| Threats found | 29 |
| Closed | 29 |
| Open | 0 |
