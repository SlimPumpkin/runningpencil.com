---
phase: "5"
slug: "business-info-support-contact"
# status lifecycle: draft (seeded by plan-phase) → validated (set by validate-phase §6)
# audit-milestone §5.5 distinguishes NOT-VALIDATED (draft) from PARTIAL (validated + nyquist_compliant: false) (#2117)
status: draft
nyquist_compliant: false
wave_0_complete: false
created: "2026-11-19"
---

# Phase 5 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.
> 근거: `05-RESEARCH.md` 「Validation Architecture」. 이 저장소에는 테스트 러너가 없으므로 셸·CLI 명령과 스크래치 Playwright로 검증합니다. 스크래치 도구(`$TMPDIR/rp-p5/`)는 커밋하지 않습니다.
> **D-02:** 사업자 값(상호·대표자·사업자등록번호·주소)은 이 파일을 포함한 `.planning/` 어디에도 적지 않습니다. 판정 기록에는 「행이 있다/없다」, 건수, 사용자 대조 결과만 남깁니다. 지원 주소는 명령에 직접 적지 않고 `.planning/baseline/NAMES.md`에서 읽습니다.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | `scripts/check-site.sh`(빌드 + 6항목, 이 단계에서 7번 가드 추가) + 스크래치 `lib.sh`(`build`/`build_src`/`serve`/`stop`, Phase 4 계약) + Playwright 1.59.1 스크래치 스크립트(Chromium·WebKit, pnpm, 커밋 안 함) |
| **Config file** | `scripts/check-site.sh` 맨 위 `EXPECTED_TITLES`, `.githooks/pre-push`. Wave 0에서 `$TMPDIR/rp-p5/lib.sh`, `pw/p5-foot.mjs`, `pw/p5-support.mjs`를 만듭니다 |
| **Quick run command** | `scripts/check-site.sh <후보 SHA>` |
| **Full suite command** | `scripts/check-site.sh <후보>` + `build <이름> <후보>` + `diff -r`/`cmp` + `node "$W/pw/<스크립트>.mjs"` (두 엔진 × 375/1280) + 훅 경로 `printf 'refs/heads/main %s refs/heads/main %s\n' <후보> <원격> \| .githooks/pre-push` |
| **Estimated runtime** | check-site 약 2초, 전체 약 60초 |

---

## Sampling Rate

- **사이트 커밋마다:** 후보 SHA로 `scripts/check-site.sh` + 그 커밋의 출력 판정(바이트 동일 또는 의도한 줄만). 보류 묶음 중간 커밋은 「7번 항목만 실패」가 기대값입니다
- **기준:** 어떤 변경보다 먼저 실행 시작 커밋을 빌드해 기준 출력을 만듭니다
- **푸시마다:** 훅 경로 점검 → `checkpoint:decision`(SHA별 승인) → 푸시 → 라이브 확인(네 URL 200·제목, 라이브 바이트 = 후보 빌드)
- **Before `/gsd-verify-work`:** 아래 표 전부 + 두 엔진 × 375/1280 캡처를 사용자에게 보임 (값은 `.planning`에 남기지 않음)
- **Max feedback latency:** 60초

---

## Per-Task Verification Map

계획자가 PLAN.md를 만든 뒤 채웁니다. 요구사항별 판정 기준은 아래와 같습니다 (`05-RESEARCH.md` 「Phase Requirements → Test Map」).

| Req / 기준 | Behavior | Test Type | Automated Command | File Exists | Status |
|------------|----------|-----------|-------------------|-------------|--------|
| BIZ-02 (M1) | 빈 슬롯 + 템플릿이 네 문서 출력을 바꾸지 않음 | 바이트 비교 | `build base <BASE>; build c1 <CAND>; diff -r "$W/base/site" "$W/c1/site"` → 빈 출력 | ❌ W0 | ⬜ pending |
| BIZ-02 | 빈 값·null·키 없음은 행 없음, 부분 값은 그 항목만, 구분 기호가 매달리지 않음 | 스크래치 변형 빌드 | 스크래치 사본에서 `_data/company.yml`만 바꿔 `build_src`, 푸터 블록의 행·구분 기호 수 확인 | ❌ W0 | ⬜ pending |
| M2 (CSS) | 출력 차이가 `<style>` 안 추가 줄뿐 | diff 행 머리 | `diff "$W/c1/site/$f" "$W/c2/site/$f" \| grep -E '^[0-9]'` → 기대 행 머리만 | ❌ W0 | ⬜ pending |
| BIZ-01 / SC3 | 값 커밋 뒤 네 문서 푸터에 사업자 행이 있음 (값은 기록하지 않음) | grep 개수 | 푸터 블록에서 상호·대표자·사업자등록번호·주소 라벨 각 1개 × 4문서 | ❌ | ⬜ pending |
| BIZ-01 (D-07) | 375px에서 항목 중간 끊김 없음, 가로 넘침 없음, 푸터 링크 색 | Playwright | `span` 높이 ≤ 한 줄, `scrollWidth == 375`, `getComputedStyle(a).color` 기대값 (Chromium·WebKit) | ❌ W0 | ⬜ pending |
| BIZ-03 / SC4 | `phone`만 채우면 푸터·`#contact`에 전화 행, 비우면 어디에도 없음 | 스크래치 변형 | 출력 전체 `grep -c '전화'` → 빈 값 0 | ❌ | ⬜ pending |
| SC4 | `_data` 한 파일만 고쳐 반영 | git diff | 값 커밋 `git diff --name-only <부모> <커밋>` = `_data/company.yml` 하나 | — | ⬜ pending |
| SUP-02 / SC1 | 게이트 전 주소 비공개, 게이트 커밋이 처음 | git | RESEARCH Code Example 7 (주소는 NAMES.md에서 읽음, 사이트 파일만 `git log -S`) | — | ⬜ pending |
| SUP-02 / SC1 | 수신 시험 네 행 모두 받은편지함 | manual | 사용자가 넘긴 표를 Claude가 확인, 「4/4 도착」만 기록 | manual-only | ⬜ pending |
| D-04 | 보류 묶음이 게이트 전 원격의 조상이 아님 | git | `! git merge-base --is-ancestor p5-support-hold origin/main` && `test -z "$(git branch -r --contains p5-support-hold)"` | — | ⬜ pending |
| D-04 가드 | 연락처 없는 `/support/`·페이지 없는 링크를 훅이 막음 | 양성·음성 대조 | 기준 커밋 `check-site` 통과 / 보류 H1 커밋 `check-site`가 7번 항목으로 실패 | ❌ W0 | ⬜ pending |
| SUP-01 / SC5 | `/support/` h1에 「러닝펜슬」, 제목 「고객 지원 - 러닝펜슬」, 이메일·응답 안내 | check-site 3번 + grep | `EXPECTED_TITLES` 줄, `grep -c '러닝펜슬 고객 지원'`, `#contact` 안 `mailto:` 1개 | ❌ | ⬜ pending |
| SUP-03 / SC5 | `#report`에 적을 내용 목록 (앱 화면에 보이는 정보만) | grep | `id="report"` 구간 `li` 개수, 「만든 사람」 0 | ❌ | ⬜ pending |
| SUP-04 / SC5 | FAQ 네 쌍, 운영 주체가 `_data` 값 | grep + 비교 | `dt` 4개, 운영 주체 `dd` 안 상호가 푸터 상호와 같은지 (기록은 같음/다름) | ❌ | ⬜ pending |
| SC5 | 헤더·푸터에서 `/support/`로 갈 수 있음 | grep + Playwright | 네 문서(+지원 페이지) 모두 `href="/support/"` 2개, 1280px 헤더 링크 보임·375px 푸터 링크 보임 | ❌ | ⬜ pending |
| D-13 | 앵커 순서 `contact` → `report` → `faq` | grep 순서 | `grep -o 'section id="[a-z]*"'` 출력이 정확히 세 줄 그 순서 | ❌ | ⬜ pending |
| SC2 / SITE-03 | MX·SPF 1개·Search Console TXT, HTTPS 200, Search Console 확인됨 | dig + curl + manual | `dig +short @ns1.gabia.co.kr runningpencil.com MX`, TXT의 `v=spf1` 1개·`google-site-verification` ≥1, `curl -sI https://runningpencil.com/` → 200. 「확인됨」은 사용자 보고(작업 7) | 반 manual | ⬜ pending |
| D-06 | 작업 5(보내기 설정) 끝남 | manual | 사용자 한 줄 보고 | manual-only | ⬜ pending |
| 매 푸시 | 기존 세 URL 200·제목, 라이브 바이트 | curl | Phase 4와 같은 라이브 확인(`?cb=<SHA>`), 라이브 `/`가 후보 빌드와 같은지 | — | ⬜ pending |
| D-02 | 사업자 값이 `.planning`·커밋 메시지에 없음 | grep 개수 | RESEARCH Code Example 8 | — | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `$TMPDIR/rp-p5/lib.sh` — Phase 4 `lib.sh`를 복사해 `W`만 바꿈 (절대 경로 금지 규칙 유지)
- [ ] `$W/pw/p5-foot.mjs` — 푸터 측정(항목 높이, `scrollWidth`, 링크 색)
- [ ] `$W/pw/p5-support.mjs` — 지원 페이지 구조(앵커 순서, `dt` 수, 헤더/푸터 링크)
- [ ] check-site 7번 가드 양성·음성 대조 기록
- [ ] Playwright는 Phase 4 스크래치 재사용 (없으면 고정 버전 재설치 checkpoint)

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| 외부 4곳(Gmail·네이버·iCloud·Outlook) 수신 시험 | SUP-02 / SC1 | 외부 메일 계정이 필요함 | 사용자가 USER-TASKS 작업 4 「수신 시험 기록 양식」 표를 넘기고, Claude가 네 행 모두 「받은편지함 도착」인지 확인. 보낸 사람 주소·시각은 기록하지 않음 |
| Search Console 도메인 속성 「확인됨」 | SITE-03 / SC2 | Search Console 화면은 사용자 계정 안에 있음 | 사용자가 작업 7 결과를 한 줄로 보고 |
| 지원 주소로 보내기 설정 | D-06 | Google Workspace 관리 화면 | 사용자가 작업 5 결과를 한 줄로 보고 |
| 사업자 값 표기가 사업자등록증과 같음 | BIZ-01 / SC3 (D-10) | 값을 `.planning`에 남길 수 없고 원본은 사용자에게 있음 | 값 커밋 푸시 전에 로컬 빌드 푸터 글을 사용자에게 보여 주고 승인을 받음 (그 글은 `.planning`에 남기지 않음) |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 60s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
