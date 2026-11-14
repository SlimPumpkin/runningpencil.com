---
phase: "01"
slug: "ground-truth-policy-reset"
# status lifecycle: draft (seeded by plan-phase) → validated (set by validate-phase §6)
# audit-milestone §5.5 distinguishes NOT-VALIDATED (draft) from PARTIAL (validated + nyquist_compliant: false) (#2117)
status: draft
nyquist_compliant: false
wave_0_complete: false
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

> 계획자가 Task ID를 정한 뒤 실행자가 채운다. 아래는 요구사항 단위의 검사 원형이다 (`01-RESEARCH.md` 「Phase Requirements → Test Map」).

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| TBD | TBD | TBD | BASE-01 | — | N/A | 문서 검사 | `grep -cE '러닝펜슬\|RunningPencil\|슬림펌킨\|runningpencil\.com' .planning/baseline/NAMES.md` (4 이상) | ❌ W0 | ⬜ pending |
| TBD | TBD | TBD | BASE-01 | T-01-* (누출) | 사업자 사실값을 추측해 채우지 않음 | 문서 검사 | `grep -nE '[0-9]{3}-[0-9]{2}-[0-9]{5}' .planning/baseline/NAMES.md` (0건) | ❌ W0 | ⬜ pending |
| TBD | TBD | TBD | BASE-02 | — | N/A | 문서 검사 | `01-RESEARCH.md` 「URL 대장 형식 검사」 (11개 URL, `https://runningpencil.com/…/` 꼴) | ❌ W0 | ⬜ pending |
| TBD | TBD | TBD | BASE-03 | — | N/A | 문서 검사 | `grep -cE '3afb2085\|git diff' .planning/baseline/DATA-INVENTORY.md` (2 이상) | ❌ W0 | ⬜ pending |
| TBD | TBD | TBD | BASE-03 | — | N/A | 문서 검사 | 행마다 근거 경로 또는 「공식 문서」·「dev CLI」·「미확인」 (`01-RESEARCH.md` awk 명령, 0건) | ❌ W0 | ⬜ pending |
| TBD | TBD | TBD | BASE-03 | — | N/A | 문서 검사 | 목록에서 뽑은 근거 경로마다 `test -e ~/dv/woody/running_pencil/<경로>` | ❌ W0 | ⬜ pending |
| TBD | TBD | TBD | BASE-03 | — | N/A | 문서 검사 | `grep -c '미확인' .planning/baseline/DATA-INVENTORY.md` (1 이상) + 빈 칸 없음 (0건) | ❌ W0 | ⬜ pending |
| TBD | TBD | TBD | BASE-04 | — | N/A | 문서 검사 | `for u in U2 U3 U5 U6 U7 U8 U9 U11 U12 U13 'prod'; do grep -q "$u" .planning/baseline/DECISIONS.md \|\| echo "없음: $u"; done` (출력 없음) | ❌ W0 | ⬜ pending |
| TBD | TBD | TBD | BASE-04 | — | N/A | 문서 검사 | `for k in MX SPF DKIM 'Search Console' dig Gmail 네이버 iCloud Outlook 사업자 캡처; do grep -q "$k" .planning/baseline/USER-TASKS.md \|\| echo "없음: $k"; done` (출력 없음) | ❌ W0 | ⬜ pending |
| TBD | TBD | TBD | BASE-04 | — | N/A | 문서 검사 | `grep -n 'ImprovMX' .planning/ROADMAP.md .planning/STATE.md` (0건, 또는 「채택하지 않음」 문맥만) | ✅ | ⬜ pending |
| TBD | TBD | TBD | BASE-05 | — | N/A | 문서 검사 | 「성공 기준 5 검사 (옛 문장 0건)」 (출력 없음) | ✅ | ⬜ pending |
| TBD | TBD | TBD | BASE-05 | — | N/A | 문서 검사 | 「성공 기준 5 검사 (새 방침이 적혀 있음)」 (7항목 모두 두 파일에 있음) | ✅ | ⬜ pending |
| TBD | TBD | TBD | BASE-05 | — | N/A | 문서 검사 | `generate-claude-md` 실행 뒤 `git diff --exit-code .claude/CLAUDE.md` (차이 없음) | ✅ | ⬜ pending |
| TBD | TBD | TBD | 단계 전체 | — | 라이브 사이트 불변 | 범위 검사 | `git diff --name-only <단계 시작 커밋>..HEAD -- '*.html' _config.yml favicon/ CNAME` (0건) | ✅ | ⬜ pending |
| TBD | TBD | TBD | 단계 전체 | — | 앱 저장소 읽기 전용 | 범위 검사 | `git -C ~/dv/woody/running_pencil rev-parse HEAD`가 `3afb2085…` 그대로 + `status --short`가 시작 때와 같음 | ✅ | ⬜ pending |
| TBD | TBD | TBD | 단계 전체 | T-01-* (누출) | 공개 저장소에 비밀·식별자 없음 | 보안 검사 | `01-RESEARCH.md` 「공개 저장소 누출 검사」 (0건) | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `.planning/baseline/` 폴더와 다섯 문서(`NAMES.md`, `URLS.md`, `DATA-INVENTORY.md`, `DECISIONS.md`, `USER-TASKS.md`) — 검사 대상 자체가 아직 없다. 각 문서를 만드는 작업의 완료 조건으로 위 명령을 넣는다
- [ ] 옛 문장 검사의 수정 전 기록 — 조사 때 17줄이 걸렸다. 수정 직전에 한 번 더 돌려 출력을 남기고, 수정 뒤 0건과 짝을 맞춘다
- [ ] 새 방침 검사와 기준 문서 검사는 조사에서 실행해 보지 못했다(A10). 문서를 만든 작업에서 처음 돌릴 때 결과를 눈으로 대조한다
- [ ] 단계 시작 커밋 해시 기록 — 「라이브 사이트가 바뀌지 않음」 검사의 기준점

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| 이름 표의 상호·대표자·주소·사업자등록번호 칸이 비어 있거나 사용자가 준 값뿐이다 | BASE-01 | 「추측하지 않음」은 패턴으로 다 잡을 수 없다 | 칸마다 출처(사용자 제공/빈칸)를 눈으로 확인 |
| URL마다 등록할 콘솔 필드가 적혀 있다 | BASE-02 | 콘솔 필드 이름의 정확성은 사람 판단 | 표의 콘솔 필드 열을 제공자별로 대조 |
| 결정·작업 항목마다 막는 단계가 맞다 | BASE-04 | 단계 의존 관계는 ROADMAP 해석이 필요 | 항목의 「막는 단계」를 ROADMAP 단계 목록과 대조 |
| dev 프로젝트 리전 칸(CLI 조회) | BASE-03 | gcloud·firebase 자격 증명이 만료돼 사용자 재로그인이 필요 | 사용자가 `gcloud auth login`·`firebase login --reauth` 후 `01-RESEARCH.md` Code Examples의 읽기 전용 명령 실행. 안 되면 「CLI 미확인」으로 둔다 |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 30s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
