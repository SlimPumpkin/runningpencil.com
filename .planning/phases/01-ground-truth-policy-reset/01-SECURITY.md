---
phase: "01"
slug: "ground-truth-policy-reset"
status: verified
# threats_open = count of OPEN threats at or above workflow.security_block_on severity (the blocking gate)
threats_open: 0
asvs_level: 1
created: "2026-11-15"
---

# Phase 01 — Security

> Per-phase security contract: threat register, accepted risks, and audit trail.
> 근거: 계획 01-01~01-08의 `<threat_model>`(계획 단계에 작성). 이 단계의 산출물은 문서뿐이고 라이브 사이트 파일은 바뀌지 않았다. 검증은 ASVS L1(grep 수준)으로 했다.

---

## Trust Boundaries

| Boundary | Description | Data Crossing |
|----------|-------------|---------------|
| 작업 세션 → 공개 GitHub 저장소 | `main` 커밋은 곧 공개된다. `.planning/`도 저장소에 있다 | 기준 문서·방침 문장·SUMMARY (식별자·비밀이 섞이면 공개 누출) |
| 앱 저장소 `running_pencil` → 기준 문서 | 앱 코드는 근거로 읽기만 하고, 문서에는 경로와 행 번호만 옮긴다 | 파일 경로, 행 번호, 설정 키 두 개 |
| 작업 셸 → dev Firebase·GCP 프로젝트 (01-08) | 사용자의 자격 증명으로 실제 프로젝트에 조회 명령을 보낸다. 읽기 전용이어야 한다 | 리전·TTL·백업·보존 같은 설정 메타데이터 |
| CLI 출력 → 공개 저장소의 문서 (01-08) | CLI 기본 출력에는 프로젝트 번호, 버킷 이름, 외부 IP, 계정이 섞여 있다 | 값만 옮기고 이름·번호·주소는 옮기지 않음 |
| 사용자의 자격 증명 → 작업 세션 | 재로그인은 사용자만 한다. 다른 자격 증명으로 돌아가지 않는다 | CLI 로그인 상태 |
| 생성기 `generate-claude-md` → `.claude/CLAUDE.md` | 생성 원본(CONVENTIONS.md, PROJECT.md)에서 블록을 다시 만든다 | 방침 문장 |
| 절차서 → 사용자의 외부 콘솔 작업 (가비아 DNS, Workspace) | 절차서는 안내만 하고 실제 변경은 사용자가 한다 | MX·SPF·DKIM 값, 보존할 기존 레코드 |

---

## Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation | Status |
|-----------|----------|-----------|----------|-------------|------------|--------|
| T-01-01 | Information Disclosure | `NAMES.md`, `URLS.md`, 두 `CLAUDE.md` | high | mitigate | 누출 정규식·하위 도메인 허용 목록 검사 0건 (기준 문서, 두 CLAUDE.md, 단계 SUMMARY 전체) | closed |
| T-01-02 | Information Disclosure | `NAMES.md` 사업자 값 칸 | high | mitigate | `(빈칸` 표기 8개, 사업자등록번호 꼴 0건 | closed |
| T-01-03 | Tampering | `.claude/CLAUDE.md` 재생성 (01-01) | medium | mitigate | 저장소 밖 사본에 `generate-claude-md --output`을 돌린 결과가 저장소 파일과 `cmp` 동일 | closed |
| T-01-04 | Tampering | 라이브 사이트 파일 | high | mitigate | `git diff --quiet dcc2002 -- '*.html' _config.yml favicon/ CNAME` (`favicon/app-icon-*.png` 제외) exit 0 | closed |
| T-01-05 | Information Disclosure | `USER-TASKS.md` 값 칸과 `dig` 예시 | high | mitigate | 누출 정규식·하위 도메인 허용 목록 검사 0건 | closed |
| T-01-06 | Denial of Service | 절차서의 MX·SPF·DKIM 값 | high | mitigate | `smtp.google.com` 고정값과 「콘솔 안내값과 대조」 문구가 절차서에 있음 | closed |
| T-01-07 | Spoofing | `_github-pages-challenge-SlimPumpkin` TXT | medium | mitigate | 「보존할 기존 레코드」 표와 「지우는 레코드는 없습니다」 문장이 절차서에 있음 | closed |
| T-01-08 | Denial of Service | SPF 레코드 중복 | medium | mitigate | SPF TXT를 하나만 둔다는 문장과 `v=spf1` 기대 결과가 절차서에 있음 | closed |
| T-01-09 | Information Disclosure | `DATA-INVENTORY.md` 근거 칸과 구간 D | high | mitigate | 누출 정규식·하위 도메인 허용 목록 검사 0건 | closed |
| T-01-10 | Tampering | 리전·보유 기간 칸 | medium | mitigate | `asia-northeast3`을 적은 칸 가운데 「근거: dev」·「근거: 코드」가 없는 칸 0개. 근거 경로 62개가 모두 기준 커밋 `3afb2085`에 있음 | closed |
| T-01-11 | Tampering | 앱 저장소 `running_pencil` | medium | mitigate | 기준 커밋 `3afb2085`가 앱 HEAD의 조상 (이력을 되감지 않음). 이 단계는 앱 저장소에 쓰지 않았음 | closed |
| T-01-12 | Information Disclosure | `DECISIONS.md`의 U11 풀이와 U12 기록 | high | mitigate | 누출 정규식 0건, 사업자등록번호 꼴 0건 | closed |
| T-01-13 | Tampering | 결정 목록의 「상태」 칸과 법률 판단 항목 | medium | mitigate | 「결정됨」 행은 U12 하나. U2·U3·U7 구간의 「기본 동작」 줄에 「초안·법률 확인 필요」 표시가 있음 | closed |
| T-01-14 | Repudiation | 「막는 단계」 칸 | medium | mitigate | 01-04 SUMMARY에 막는 단계를 행별로 대조한 기록이 있음. 사람 확인은 VALIDATION Manual-Only 행으로 남음 | closed |
| T-01-15 | Information Disclosure | 구간 H(버킷, VM)와 근거 칸 | high | mitigate | 버킷 이름·프로젝트 번호·서비스 계정 꼴 0건, 누출 정규식 0건 | closed |
| T-01-16 | Tampering | 구간 G의 코스 행과 삭제 상한 문장 | high | mitigate | 「공개·비공개 모두」, 「삭제하지 않음」, 백업 상한 「180일」이 데이터 목록에 있음 | closed |
| T-01-17 | Tampering | 보유 기간 칸 (추측한 기본값) | medium | mitigate | 「확인할 것」 표가 있고, 01-08이 dev CLI로 확인한 칸에만 「확인함」이 붙음 | closed |
| T-01-18 | Information Disclosure | 방침 표의 지원 이메일 행, 사업자 정보 행 | high | mitigate | 두 CLAUDE.md에 지원 주소 문자열과 사업자 값 0건, 누출 정규식 0건 | closed |
| T-01-19 | Tampering | `.claude/CLAUDE.md` 재생성 (01-06) | medium | mitigate | 재생성 사본 `cmp` 동일 | closed |
| T-01-20 | Tampering | 방침 표와 상태 문장 | high | mitigate | 두 CLAUDE.md의 방침 표에 「적용 단계」·「현재 상태」 열이 있음 | closed |
| T-01-21 | Tampering | 옛 규칙 문장의 잔존 | high | mitigate | 「성공 기준 5 검사 (옛 문장 0건)」 아홉 정규식이 다섯 파일에서 0건 | closed |
| T-01-22 | Information Disclosure | ROADMAP·STATE·PROJECT에 더한 문장, 01-07 SUMMARY | high | mitigate | 누출 정규식 0건 (ROADMAP, STATE, PROJECT, REQUIREMENTS, 단계 SUMMARY 전체) | closed |
| T-01-23 | Tampering | ROADMAP·STATE의 범위 밖 내용과 진행 기록 | high | mitigate | `roadmap validate`, `state validate` 모두 exit 0 | closed |
| T-01-24 | Tampering | `.claude/CLAUDE.md` (PROJECT.md가 생성 원본) | medium | mitigate | 재생성 사본 `cmp` 동일 | closed |
| T-01-25 | Tampering | `research/STACK.md`, `research/SUMMARY.md` 본문 | medium | mitigate | 단계 시작 커밋 이후 두 파일의 삭제 줄 0 | closed |
| T-01-26 | Information Disclosure | `.planning/research/.cache/` | low | mitigate | `.gitignore`로 무시되고 추적 파일 0개 | closed |
| T-01-27 | Tampering | dev 프로젝트 (`gcloud`, `firebase` 명령) | high | mitigate | 「CLI 조회 기록」 여덟 행이 모두 list 계열 명령이고 허용 목록 밖 명령 0건. 01-08 SUMMARY에 명령 이름과 결과만 있음 | closed |
| T-01-28 | Information Disclosure | CLI 출력에서 문서·SUMMARY로 옮긴 값 | high | mitigate | 데이터 목록과 01-08 SUMMARY에서 버킷 이름·프로젝트 번호·서비스 계정·IP·계정 이메일 꼴 0건. 01-08 이후 커밋된 줄 전체에도 0건 | closed |
| T-01-29 | Elevation of Privilege | 자격 증명 (만료된 CLI 로그인) | medium | mitigate | 01-08 Task 1의 human-action checkpoint에서 사용자가 직접 재로그인함. 다른 자격 증명을 쓰지 않았다는 기록이 01-08 SUMMARY에 있음 | closed |
| T-01-30 | Information Disclosure | Firestore 문서·Storage 객체 내용 | high | mitigate | 「CLI 조회 기록」에 문서·객체 내용을 읽는 명령 0건 (설정 메타데이터를 보는 list 명령만) | closed |
| T-01-SC | Tampering | npm/pip/cargo installs (계획 8개 공통) | high | mitigate | 저장소에 패키지 매니페스트 0개, 단계 시작 이후 추가된 매니페스트 0개 | closed |

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
| 2026-11-15 | 31 | 31 | 0 | secure-phase (L1 grep 수준, 계획 단계 register. threats_open 0 + ASVS L1이라 auditor 생략) |

---

## Sign-Off

- [x] All threats have a disposition (mitigate / accept / transfer)
- [x] Accepted risks documented in Accepted Risks Log
- [x] `threats_open: 0` confirmed
- [x] `status: verified` set in frontmatter

**Approval:** verified 2026-11-15
