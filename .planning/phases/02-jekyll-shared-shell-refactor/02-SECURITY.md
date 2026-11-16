---
phase: "02"
slug: "jekyll-shared-shell-refactor"
status: verified
# threats_open = count of OPEN threats at or above workflow.security_block_on severity (the blocking gate)
threats_open: 0
asvs_level: 1
created: "2026-11-16"
---

# Phase 02 — Security

> Per-phase security contract: threat register, accepted risks, and audit trail.
> 근거: 계획 02-01~02-10의 `<threat_model>`(계획 단계에 작성). 이 단계는 사이트 출력을 바꾸지 않는 Jekyll 공유 셸 리팩터와 푸시 다섯 번(기준 커밋 + 푸시 ①~④)이다. 검증은 ASVS L1(grep 수준)으로 했고, 증거는 저장소 명령을 다시 돌린 결과, `02-EVIDENCE.md` 표식, GitHub Pages 빌드 기록(읽기 전용 조회)이다. SUMMARY에는 `## Threat Flags` 항목이 없다.

---

## Trust Boundaries

| Boundary | Description | Data Crossing |
|----------|-------------|---------------|
| 로컬 main → 원격 main (GitHub Pages 배포) | 푸시가 곧 라이브 배포다. CI가 없어 마지막 관문은 pre-push 훅과 사람의 승인이다 | 사이트 출력 전체 |
| 저장소 → GitHub Pages 빌드 → 공개 사이트 | 추적 파일 가운데 `exclude`와 점·밑줄 규칙을 빠져나간 것은 모두 누구나 받을 수 있는 URL이 된다 | 내부 문서(`CLAUDE.md`, `.planning/`, `Gemfile`, 스크립트) |
| 로컬 Jekyll(Ruby 4.0.9) ↔ 운영 Jekyll(Ruby 3.3.4, github-pages 232) | 같은 템플릿이 다른 환경에서 처리된다. 차이는 라이브 비교로만 잡힌다 | 네 문서의 HTML |
| Liquid 처리 → 공개 HTML (법적 3종, 랜딩 인라인 스크립트) | front matter가 빠지거나 문법이 틀리면 include 원문이나 빈 페이지가 공개된다 | include 원문, 인라인 JS·CSS |
| front matter 값 → HTML 속성·본문 | 값은 escape 없이 그대로 출력된다. 값은 운영자가 쓴다 | title·description 문자열 |
| GitHub Pages 배포 → Fastly CDN → 확인 도구 | CDN은 옛 응답(200과 404)을 캐시한다. 바이트가 같은 리팩터는 옛 캐시로도 통과처럼 보인다 | 라이브 확인 판정 |
| 로컬 이력·문서 커밋 → 공개 GitHub 저장소 | 첫 푸시로 `.planning/`·`.claude/`가 처음 공개됐다. 공개된 이력은 되돌릴 수 없다 | 기준 문서, SUMMARY, EVIDENCE, 두 CLAUDE.md |
| 원본 맵 → `.claude/CLAUDE.md`(생성) → 이후 에이전트 | 원본 맵이 틀리면 재생성으로 퍼져 다음 단계의 작업 지시가 틀린다 | 작업 지시 문장 |
| 시험용 worktree → 메인 체크아웃 | 임시 시험이 메인 작업 트리나 저장소 이력을 바꾸면 안 된다 | 시험용 주입 파일 |
| rubygems.org → 로컬 `vendor/bundle` | 로컬 빌드에만 쓰는 gem을 내려받는다. 운영은 GitHub의 고정 gem 세트를 쓴다 | gem 패키지 |

---

## Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation | Status |
|-----------|----------|-----------|----------|-------------|------------|--------|
| T-02-01 | Information Disclosure | `_config.yml` exclude | high | mitigate | `exclude` 열 항목. `check-site.sh` 2번 항목. `compare.sh` 파일 목록 동일(OK 5). 라이브 내부 파일 13경로 404(푸시 ①~④) | closed |
| T-02-02 | Tampering | `Gemfile`·`Gemfile.lock` | medium | mitigate | `DEPENDENCIES` 정확히 7개, `CHECKSUMS` 구간 있음 | closed |
| T-02-03 | Tampering | `.githooks/pre-push` | high | mitigate | `core.hooksPath`=`.githooks`, 두 파일 100755. 훅 실제 stdin 경로 시험 통과(푸시 후보 4회 모두 `check-site: 통과`) | closed |
| T-02-04 | Denial of Service | 스크립트의 임시 폴더 삭제 | medium | mitigate | `check-site.sh`와 스크래치 스크립트의 `rm -rf`·`worktree remove`가 모두 `${VAR:?}` 가드 꼴 (가드 없는 줄 0) | closed |
| T-02-05 | Information Disclosure | `.nojekyll` 추가 | high | mitigate | `check-site.sh`에 `.nojekyll` 검사. inject 경우 e가 rc=1로 잡힘 | closed |
| T-02-06 | Information Disclosure | 첫 공개되는 `.planning/`·`.claude/` 이력 | high | mitigate | 02-02 Task 1이 끝 트리와 이력에 누출·호스트 이름·로컬 경로 검사를 돌렸고(기록: 걸린 수와 `파일:행`만), Task 2(blocking-human)에서 사람이 줄 내용을 보고 `base-first`를 골랐다. 누출 1줄은 공개 커뮤니티 URL의 숫자 ID, 로컬 경로 줄은 사람이 검토 뒤 공개를 승인 | closed |
| T-02-07 | Repudiation | 라이브 확인 판정 (옛 캐시, 손으로 쓴 기록) | high | mitigate | `live-check.sh`가 `Last-Modified ≥ created_at`·404 age로 신선도 판정. 다섯 푸시 모두 Pages 빌드 기록에 built·오류 없음(02-10 Task 3 verify 4, bash 재실행 rc=0). 푸시 ④는 `lm=`이 빌드 `created_at` 이후(verify 2 rc=0) | closed |
| T-02-08 | Tampering | 승인 없는 배포 (02-02) | high | mitigate | `HISTORY_DECISION=base-first`(사람 결정) 뒤 `BASE_PUSH_SHA` 하나만 푸시, `LIVE_BASE_PUSH=OK` | closed |
| T-02-09 | Denial of Service | 라이브 사이트 깨진 배포 (02-02) | medium | mitigate | `<rollback_procedure>`(범위 전체 revert, 되돌리기 푸시는 별도 blocking-human 승인) 문서화. 실제 FAIL 없음(`LIVE_BASE_PUSH=OK`) | closed |
| T-02-10 | Information Disclosure | 라이브 `/Gemfile`·`/scripts/`·`/.githooks/`·`/.planning/` | high | mitigate | 로컬 1차 관문(check-site 2번, 훅) + 푸시 ① 라이브 `OK 404` 13줄, FAIL 0 | closed |
| T-02-11 | Tampering | 승인과 다른 커밋 배포 (푸시 ①) | high | mitigate | `PUSH1_SHA` = `PUSH1_CANDIDATE` = `d5a6679631d7`, 원격 main의 조상 | closed |
| T-02-12 | Denial of Service | 라이브 사이트 깨진 배포 (푸시 ①) | medium | mitigate | `<rollback_procedure>` 문서화(`HISTORY_DECISION`으로 대상 결정). 실제 FAIL 없음(`LIVE_PUSH1=OK`) | closed |
| T-02-13 | Information Disclosure | 법적 페이지 include 원문 노출 | high | mitigate | check-site 4번(처리되지 않은 Liquid)·1번(빌드 실패). inject 경우 c·d가 rc=1로 잡힘 | closed |
| T-02-14 | Tampering | 법적 문서 글자 (심사 콘솔 등록 URL) | high | mitigate | 전환 커밋마다 `compare.sh` D-07 diff 0 (`CMP_LEGAL=OK`), 최종 `--no-comments` OK 5 | closed |
| T-02-15 | Tampering | front matter 값이 HTML 속성을 깨뜨림 | low | mitigate | 세 `description` 값에 큰따옴표·역슬래시 0건, compare diff 0 | closed |
| T-02-16 | Denial of Service | 값이 빠진 페이지 (Phase 5 이후 `/support/` 등) | low | mitigate | title만 있는 시험 페이지로 noindex·updated·heading 생략 분기 확인 (`FALSY_LAYOUT=OK`) | closed |
| T-02-17 | Tampering | 운영 빌드가 레이아웃을 다르게 처리함 | high | mitigate | 푸시 ② 라이브 `OK 문서` 4줄(신선한 본문 D-07 비교 = 기준), FAIL 0, Pages 빌드 기록 대조 | closed |
| T-02-18 | Information Disclosure | 라이브 `/_includes/`·`/_layouts/` 원본 | medium | mitigate | 밑줄 규칙 + check-site 2번. 라이브 `/_includes/footer.html`·`/_layouts/legal.html` 404 (푸시 ②~④, 최종 상태 직접 재확인) | closed |
| T-02-19 | Tampering | 승인과 다른 커밋 배포 (푸시 ②) | high | mitigate | `PUSH2_SHA` = `PUSH2_CANDIDATE` = `01f6bb8bbb13`, 원격 main의 조상 | closed |
| T-02-20 | Tampering | 랜딩 스크립트·id 계약 | high | mitigate | 전환 커밋 `compare.sh` diff 0 (`CMP_LANDING=OK`) | closed |
| T-02-21 | Information Disclosure | 랜딩 include 원문 노출 (front matter 누락) | high | mitigate | check-site 4번. inject 경우 f가 rc=1로 잡힘 (`INJECT_F=OK`) | closed |
| T-02-22 | Tampering | 임시 시험 흔적이 저장소에 남음 | low | mitigate | probe·inject는 저장소 밖 detached worktree에서만. 지금 `git worktree list` 1줄(메인만), 메인 작업 트리에 시험 흔적 없음 | closed |
| T-02-23 | Tampering | 운영 빌드가 랜딩을 다르게 처리함 | high | mitigate | 푸시 ③ 라이브 `OK 문서` 4줄, FAIL 0, Pages 빌드 기록 대조 | closed |
| T-02-24 | Tampering | 승인과 다른 커밋 배포 (푸시 ③) | high | mitigate | `PUSH3_SHA` = `PUSH3_CANDIDATE` = `e7e62f3f7990`, 원격 main의 조상 | closed |
| T-02-25 | Information Disclosure | 라이브 내부 파일 (푸시 ③) | medium | mitigate | 푸시 ③ 라이브 `OK 404` 13줄, FAIL 0 | closed |
| T-02-26 | Tampering | 주석 수정 커밋이 다른 출력을 바꿈 (02-08) | medium | mitigate | 주석 제거 비교 diff 0 (`CMP_FINAL_NOCOMMENT=OK`), 주석 그대로 비교는 머리 주석 줄만 (`CMP_COMMENT_ONLY=OK`) | closed |
| T-02-27 | Tampering | 원본 맵의 잘못된 행 번호·구조 서술 | low | mitigate | 02-08·02-09 verify의 행 참조 범위 검사. `STRUCTURE.md`·`CONCERNS.md` 재실행 결과 파일 길이 초과 참조 0 | closed |
| T-02-28 | Information Disclosure | 출력 주석의 include 경로 노출 | low | accept | 수용 위험 AR-02-01 참고 | closed |
| T-02-29 | Tampering | `.claude/CLAUDE.md` 재생성 | medium | mitigate | `generate-claude-md --output <사본>` 결과가 커밋본과 `cmp` 동일(재실행 확인). 방침 구간 두 사본 내용 동일 | closed |
| T-02-30 | Information Disclosure | 문서에 계정·IP·토큰이 섞임 | high | mitigate | 두 CLAUDE.md에 이메일·IP·토큰·홈 경로 정규식 0건(재실행). SUMMARY·EVIDENCE 누출 검사 0건(02-10 verification) | closed |
| T-02-31 | Repudiation | 문서의 명령이 실제로 안 돎 | low | mitigate | `bundle check` 통과, `scripts/check-site.sh HEAD` 통과. 브라우저 미리보기는 end-of-phase human-check(02-09 Task 2) | closed |
| T-02-32 | Tampering | 주석 커밋이 다른 출력을 바꿈 (푸시 ④) | medium | mitigate | 02-10 Task 1 비교 두 가지 + 라이브 `live-check.sh post 9f715c795830 --no-comments` 통과 (`LIVE_PUSH4=OK`) | closed |
| T-02-33 | Information Disclosure | 공개되는 문서 커밋 (푸시 ④) | medium | mitigate | 02-10 Task 1 검사: 누출 0·0, 호스트 이름 0·0, 로컬 경로 끝 트리 1줄(이미 공개된 줄)·이력 0. Task 2(blocking-human)에서 사람이 줄 내용을 보고 `push` 승인 | closed |
| T-02-34 | Repudiation | 성공 기준 판정 근거 누락, 손으로 쓴 라이브 기록 | low | mitigate | 근거 표식 19개 모두 있음, Pages 빌드 기록으로 다섯 푸시 대조(verify 4), 최종 상태 라이브 직접 재확인(verify 3) | closed |
| T-02-35 | Tampering | 승인과 다른 커밋 배포 (푸시 ④) | high | mitigate | `PUSH4_SHA` = `PUSH4_CANDIDATE` = `9f715c795830`, 원격 main의 조상. 사용자 승인 SHA와 같음 | closed |
| T-02-SC | Tampering | npm/pip/cargo installs (계획 10개 공통) | high | mitigate | npm·pip·cargo 매니페스트 없음(`package.json`·`requirements.txt`·`pyproject.toml`·`Cargo.toml` 0개). gem은 사용자가 정한 7개로 고정(T-02-02) | closed |

*Status: open · closed · open — below high threshold (non-blocking)*
*Severity: critical > high > medium > low — only open threats at or above workflow.security_block_on count toward threats_open*
*Disposition: mitigate (implementation required) · accept (documented risk) · transfer (third-party)*

---

## Accepted Risks Log

| Risk ID | Threat Ref | Rationale | Accepted By | Date |
|---------|------------|-----------|-------------|------|
| AR-02-01 | T-02-28 | 「공통」 머리 주석이 `_includes/css/common.css` 경로를 공개 HTML에 보인다. 이 경로는 공개 저장소에 이미 있는 이름이고 비밀이 아니다. 밑줄 규칙으로 URL로 열 수 없다 (라이브 `/_includes/footer.html` 404 확인). 주석 한 줄 차이는 D-06에서 사용자가 승인한 예외다 | 계획 02-08 threat model (D-06 사용자 결정) | 2026-11-16 |

*Accepted risks do not resurface in future audit runs.*

---

## Security Audit Trail

| Audit Date | Threats Total | Closed | Open | Run By |
|------------|---------------|--------|------|--------|
| 2026-11-16 | 36 | 36 | 0 | secure-phase 오케스트레이터 (ASVS L1, auditor 생략: threats_open 0 + 계획 시점 register + L1) |

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
| Threats found | 36 |
| Closed | 36 |
| Open | 0 |
