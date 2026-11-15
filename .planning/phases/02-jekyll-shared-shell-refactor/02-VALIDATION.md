---
phase: "2"
slug: "jekyll-shared-shell-refactor"
# status lifecycle: draft (seeded by plan-phase) → validated (set by validate-phase §6)
# audit-milestone §5.5 distinguishes NOT-VALIDATED (draft) from PARTIAL (validated + nyquist_compliant: false) (#2117)
status: draft
nyquist_compliant: false
wave_0_complete: false
created: "2026-11-15"
---

# Phase 2 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.
> 출처: `02-RESEARCH.md` §Validation Architecture. 이 저장소에는 테스트 프레임워크가 없어 셸·CLI 명령으로 검증합니다. 「영구」는 저장소에 커밋되어 이후 단계에서도 도는 것, 「일회용」은 Phase 2에서 스크래치(저장소 밖)로 한 번 돌리고 결과만 검증 문서에 남기는 것입니다.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | 없음. bash 스크립트 + `jekyll build` 종료 코드 + `diff`/`cmp`/`grep` + `curl`/`gh` |
| **Config file** | 없음 — Wave 0에서 `scripts/check-site.sh`, `.githooks/pre-push` 생성 |
| **Quick run command** | `scripts/check-site.sh` (작업 트리) |
| **Full suite command** | `scripts/check-site.sh HEAD && <스크래치>/compare.sh "$BASE_SHA" HEAD` |
| **Estimated runtime** | ~2초 (quick), ~10초 (full, 기준 빌드 포함) |

---

## Sampling Rate

- **After every task commit:** `scripts/check-site.sh` (작업 트리)
- **After every 전환 커밋 (법적 3종, 랜딩):** `compare.sh "$BASE_SHA" HEAD` → 네 문서 `OK` + `_site` 파일 목록 동일
- **Every push:** pre-push 훅(자동) → `checkpoint:decision`(푸시 승인) → 푸시 → 라이브 확인 3종(배포 완료 확인 뒤 200·제목, 내부 파일 404, 라이브 HTML 정규화 diff 0)
- **Before `/gsd-verify-work`:** 네 푸시의 라이브 확인이 모두 통과하고, 최종 `compare.sh "$BASE_SHA" HEAD --no-comments`가 0
- **Max feedback latency:** 로컬 10초. 라이브 확인은 GitHub Pages 배포 완료와 CDN 신선도(`Last-Modified` ≥ 빌드 `created_at`)를 기다리므로 별도

---

## Per-Task Verification Map

요구사항·성공 기준 단위 지도입니다. Task ID 열은 계획(PLAN.md)이 확정되면 채웁니다.

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| — | — | — | SHELL-02 / SC1 | — | N/A | smoke | `bundle exec jekyll -v` = `jekyll 3.10.0`; `scripts/check-site.sh HEAD` 종료 코드 0 | ❌ W0 | ⬜ pending |
| — | — | — | SHELL-01 / SC1 | — | N/A | 비교(일회용) | `compare.sh "$BASE_SHA" <법적 전환 SHA>`, `compare.sh "$BASE_SHA" <랜딩 전환 SHA>` → 네 줄 `OK` | ❌ W0 | ⬜ pending |
| — | — | — | SHELL-01·03 / SC1 (D-08) | — | 새로 공개되는 파일 0 | 비교(일회용) | 같은 `compare.sh` 출력의 `OK _site 파일 목록 동일` | ❌ W0 | ⬜ pending |
| — | — | — | SHELL-01 / SC1 (D-06) | — | N/A | 비교(일회용) | `compare.sh "$BASE_SHA" HEAD --no-comments` | ❌ W0 | ⬜ pending |
| — | — | — | SHELL-01 / SC2 | — | N/A | grep | `git grep -lF '<footer class="rp-foot">' -- '*.html'` → `_includes/footer.html`만; head 링크·헤더·「공통」 CSS도 같은 방식으로 한 파일만 | ✅ | ⬜ pending |
| — | — | — | SHELL-01 / SC2 (D-10) | — | N/A | 임시 시험 | include마다 `<!-- probe -->` 추가 → `jekyll build -d <tmp>` → 직전 빌드와 `cmp`로 4/4 다름 → `git checkout -- _includes/` | ✅ | ⬜ pending |
| — | — | — | SHELL-02 / SC3 | — | N/A | grep | `grep -n 'python3 -m http.server' CLAUDE.md .claude/CLAUDE.md README.md .planning/codebase/*.md` → 0건; `bundle exec jekyll serve --livereload`, `core.hooksPath`, `{% raw %}` 규칙이 `CLAUDE.md`에 있음 | ✅ | ⬜ pending |
| — | — | — | SHELL-02 / SC3 | — | 훅이 조용히 안 도는 일 없음 | 설정 | `git config core.hooksPath` = `.githooks`; `git ls-files -s .githooks/pre-push scripts/check-site.sh` → `100755` 두 줄 | ❌ W0 | ⬜ pending |
| — | — | — | SHELL-02 | — | N/A | 정적 | `/bin/bash -n scripts/check-site.sh .githooks/pre-push` (bash 3.2 안전) | ❌ W0 | ⬜ pending |
| — | — | — | SHELL-03 / SC4 | — | 내부 파일 미공개 | 자동(영구) | `scripts/check-site.sh <sha>`의 2번 항목 (pre-push 훅) | ❌ W0 | ⬜ pending |
| — | — | — | SHELL-03 / SC4 | — | 내부 파일 미공개 | 라이브 | `curl -s -o /dev/null -w '%{http_code}'` = 404, 그리고 그 응답의 `age` < (지금 − 빌드 `created_at`)초. 5xx는 재시도 | ✅ | ⬜ pending |
| — | — | — | SC4 / Ground Rule | — | N/A | 라이브 | 배포 완료(`gh`) → 응답 `Last-Modified` ≥ 빌드 `created_at` → 네 URL 200, `<title>`이 check-site 기대값과 같음 | ✅ | ⬜ pending |
| — | — | — | SC4 (D-17) | — | N/A | 라이브 | 신선한 응답 본문으로 `diff <(norm 라이브) <(norm 기준 원본)` = 0; 푸시 ④ 뒤에는 주석 제거 정규화 | ✅ | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `Gemfile`, `Gemfile.lock`, `bundle config set --local path vendor/bundle`, `bundle install` (메인 체크아웃에서)
- [ ] `scripts/check-site.sh` (100755), `.githooks/pre-push` (100755), `git config core.hooksPath .githooks`
- [ ] 스크래치(저장소 밖)에 `compare.sh`, `norm_nocomment.py` 생성, `BASE_SHA` 기록
- [ ] `_config.yml`의 `url`과 `exclude`, `.gitignore` 4줄(`_site/`, `.jekyll-cache/`, `vendor/`, `.bundle/`)
- [ ] worktree 주의(`use_worktrees: true`): `compare.sh`·라이브 확인·푸시는 메인 체크아웃에서 돌립니다

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| 푸시 승인 (D-16) | SHELL-01·02·03 | `main` 푸시가 곧 배포라 푸시마다 사람이 승인해야 합니다 (`checkpoint:decision`) | 로컬 검증 결과(빌드, diff, 파일 목록, 점검 스크립트)를 보고 승인 또는 보류를 고릅니다 |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 10s (로컬)
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
