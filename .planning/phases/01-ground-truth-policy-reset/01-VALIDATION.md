---
phase: "01"
slug: "ground-truth-policy-reset"
# status lifecycle: draft (seeded by plan-phase) → validated (set by validate-phase §6)
# audit-milestone §5.5 distinguishes NOT-VALIDATED (draft) from PARTIAL (validated + nyquist_compliant: false) (#2117)
status: validated
nyquist_compliant: true
wave_0_complete: true
created: "2026-11-14"
---

# Phase 01 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.
> 근거: `01-RESEARCH.md`의 「Validation Architecture」 구간. 이 단계의 산출물은 문서(`.planning/baseline/*.md`, `CLAUDE.md`, `.claude/CLAUDE.md`, `.planning/codebase/*.md`)이므로 검증은 셸 명령(grep·awk·git·test)으로 한다.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | 없음 — 이 저장소에는 시험 프레임워크가 없다(`.planning/codebase/TESTING.md`). 문서 검사는 셸 명령으로 한다 |
| **Config file** | none |
| **Quick run command** | `01-RESEARCH.md` Code Examples의 「성공 기준 5 검사 (옛 문장 0건)」·「(새 방침이 적혀 있음)」 두 블록 + 「공개 저장소 누출 검사」 |
| **Full suite command** | 아래 Per-Task Verification Map의 명령 전부 |
| **Estimated runtime** | ~30 seconds (명령마다 30초 미만) |

---

## Sampling Rate

- **After every task commit:** 그 작업이 만든 문서의 검사 줄 + 「공개 저장소 누출 검사」
- **After every plan wave:** 아래 표의 명령 전부
- **Before `/gsd-verify-work`:** 표의 명령 전부 통과 + Manual-Only 항목 확인
- **Max feedback latency:** 30 seconds

---

## Per-Task Verification Map

> 요구사항 단위의 검사 원형(`01-RESEARCH.md` 「Phase Requirements → Test Map」)에 Task ID를 채웠다. 2026-11-15 validate-phase에서 16개 명령을 모두 실행해 통과를 확인했다. BASE-03의 근거 칸 검사(5·6행)는 01-08 Task 2 verify와 같은 꼴(근거 종류 「dev CLI」·「dev 설정 기록」 포함, 경로는 기준 커밋 `3afb2085`에서 확인)로 돌렸다.

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 01-01-T1 | 01-01 | 1 | BASE-01 | — | N/A | 문서 검사 | `grep -cE '러닝펜슬\|RunningPencil\|슬림펌킨\|runningpencil\.com' .planning/baseline/NAMES.md` (4 이상) | ✅ | ✅ green |
| 01-01-T1 | 01-01 | 1 | BASE-01 | T-01-* (누출) | 사업자 사실값을 추측해 채우지 않음 | 문서 검사 | `grep -nE '[0-9]{3}-[0-9]{2}-[0-9]{5}' .planning/baseline/NAMES.md` (0건) | ✅ | ✅ green |
| 01-01-T2 | 01-01 | 1 | BASE-02 | — | N/A | 문서 검사 | `01-RESEARCH.md` 「URL 대장 형식 검사」 (11개 URL, `https://runningpencil.com/…/` 꼴) | ✅ | ✅ green |
| 01-03-T1·T2 | 01-03 | 2 | BASE-03 | — | N/A | 문서 검사 | `grep -cE '3afb2085\|git diff' .planning/baseline/DATA-INVENTORY.md` (2 이상) | ✅ | ✅ green |
| 01-03·05·08 | 01-03, 01-05, 01-08 | 2·3·4 | BASE-03 | — | N/A | 문서 검사 | 행마다 근거 경로 또는 「공식 문서」·「dev CLI」·「미확인」 (`01-RESEARCH.md` awk 명령, 0건) | ✅ | ✅ green |
| 01-03·05·08 | 01-03, 01-05, 01-08 | 2·3·4 | BASE-03 | — | N/A | 문서 검사 | 목록에서 뽑은 근거 경로마다 `test -e ~/dv/woody/running_pencil/<경로>` | ✅ | ✅ green |
| 01-05-T2·01-08-T2 | 01-05, 01-08 | 3·4 | BASE-03 | — | N/A | 문서 검사 | `grep -c '미확인' .planning/baseline/DATA-INVENTORY.md` (1 이상) + 빈 칸 없음 (0건) | ✅ | ✅ green |
| 01-04-T1·T2 | 01-04 | 2 | BASE-04 | — | N/A | 문서 검사 | `for u in U2 U3 U5 U6 U7 U8 U9 U11 U12 U13 'prod'; do grep -q "$u" .planning/baseline/DECISIONS.md \|\| echo "없음: $u"; done` (출력 없음) | ✅ | ✅ green |
| 01-02-T1·T2 | 01-02 | 2 | BASE-04 | — | N/A | 문서 검사 | `for k in MX SPF DKIM 'Search Console' dig Gmail 네이버 iCloud Outlook 사업자 캡처; do grep -q "$k" .planning/baseline/USER-TASKS.md \|\| echo "없음: $k"; done` (출력 없음) | ✅ | ✅ green |
| 01-07-T1·T2 | 01-07 | 3 | BASE-04 | — | N/A | 문서 검사 | `grep -n 'ImprovMX' .planning/ROADMAP.md .planning/STATE.md` (0건, 또는 「채택하지 않음」 문맥만) | ✅ | ✅ green |
| 01-06-T1~T3 | 01-01, 01-06 | 1·2 | BASE-05 | — | N/A | 문서 검사 | 「성공 기준 5 검사 (옛 문장 0건)」 (출력 없음) | ✅ | ✅ green |
| 01-06-T2·T3 | 01-06 | 2 | BASE-05 | — | N/A | 문서 검사 | 「성공 기준 5 검사 (새 방침이 적혀 있음)」 (7항목 모두 두 파일에 있음) | ✅ | ✅ green |
| 01-06-T2 | 01-06 | 2 | BASE-05 | — | N/A | 문서 검사 | `generate-claude-md` 실행 뒤 `git diff --exit-code .claude/CLAUDE.md` (차이 없음) | ✅ | ✅ green |
| 전체 | 01-01~01-08 | 1~4 | 단계 전체 | — | 라이브 사이트 불변 | 범위 검사 | `git diff --quiet dcc2002431960d7d51ddbc2acc102e8375125b91 -- '*.html' _config.yml favicon/ CNAME ':(exclude)favicon/app-icon-*.png'` (exit 0. 단계 시작 때 추적되지 않던 사용자 파일 `favicon/app-icon-*.png`는 뺀다 — 계획 gate와 같은 기준) | ✅ | ✅ green |
| 전체 | 01-01~01-08 | 1~4 | 단계 전체 | — | 앱 저장소 읽기 전용 | 범위 검사 | `git -C "$HOME/dv/woody/running_pencil" merge-base --is-ancestor 3afb20858257f024bf9a06d857198f593a1d351d HEAD` (exit 0. 사용자가 실행 도중 앱을 커밋해 HEAD가 앞으로 나아간 경우는 통과 — 계획 gate와 같은 기준) | ✅ | ✅ green |
| 전체 | 01-01~01-08 | 1~4 | 단계 전체 | T-01-* (누출) | 공개 저장소에 비밀·식별자 없음 | 보안 검사 | `01-RESEARCH.md` 「공개 저장소 누출 검사」 (0건) | ✅ | ✅ green |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [x] `.planning/baseline/` 폴더와 다섯 문서(`NAMES.md`, `URLS.md`, `DATA-INVENTORY.md`, `DECISIONS.md`, `USER-TASKS.md`) — 검사 대상 자체가 아직 없다. 각 문서를 만드는 작업의 완료 조건으로 위 명령을 넣는다
- [x] 옛 문장 검사의 수정 전 기록 — 조사 때 17줄이 걸렸다. 수정 직전에 한 번 더 돌려 출력을 남기고, 수정 뒤 0건과 짝을 맞춘다
- [x] 새 방침 검사와 기준 문서 검사는 조사에서 실행해 보지 못했다(A10). 문서를 만든 작업에서 처음 돌릴 때 결과를 눈으로 대조한다
- [x] 단계 시작 커밋 해시 기록 — 「라이브 사이트가 바뀌지 않음」 검사의 기준점은 `dcc2002431960d7d51ddbc2acc102e8375125b91` (계획 gate에 고정됨)

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| 이름 표의 상호·대표자·주소·사업자등록번호 칸이 비어 있거나 사용자가 준 값뿐이다 | BASE-01 | 「추측하지 않음」은 패턴으로 다 잡을 수 없다 | 칸마다 출처(사용자 제공/빈칸)를 눈으로 확인 |
| URL마다 등록할 콘솔 필드가 적혀 있다 | BASE-02 | 콘솔 필드 이름의 정확성은 사람 판단 | 표의 콘솔 필드 열을 제공자별로 대조 |
| 결정·작업 항목마다 막는 단계가 맞다 | BASE-04 | 단계 의존 관계는 ROADMAP 해석이 필요 | 항목의 「막는 단계」를 ROADMAP 단계 목록과 대조 |
| dev 프로젝트 리전·보존 칸(CLI 조회 값) | BASE-03 | dev 프로젝트의 실제 설정은 사용자의 자격 증명으로만 볼 수 있다 | 01-08에서 사용자 재로그인 뒤 읽기 전용 조회 8건을 마쳤다(「CLI 조회 기록」). 남은 일은 데이터 목록의 「근거: dev CLI」 값을 Firebase·GCP 콘솔에서 아는 값과 견주는 것 (01-08 human-check) |

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags
- [x] Feedback latency < 30s
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** validated 2026-11-15 (validate-phase: 16/16 자동 검사 통과, gap 0. Manual-Only 4행은 사람 확인으로 남음)

## Validation Audit 2026-11-15

| Metric | Count |
|---|---|
| Gaps found | 0 |
| Resolved | 0 |
| Escalated | 0 |
