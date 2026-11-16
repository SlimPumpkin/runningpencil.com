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
- **Max feedback latency:** 로컬 10초. 라이브 기록을 확인하는 verify는 여기에 GitHub Pages 빌드 기록 조회 한 번(`gh api`, 1초 안팎)을 더한다. 02-10 Task 3의 최종 상태 라이브 재확인은 HTTP 요청 17개(5xx·연결 오류는 curl이 두 번까지 재시도)로 보통 몇 초다. 배포 완료와 CDN 신선도(`Last-Modified` ≥ 빌드 `created_at`)를 기다리는 `live-check.sh`는 최대 15분이라 각 task의 action에서만 돈다 (아래 다시 돌리기 규칙)
- **다시 돌리기 규칙:** 모든 자동 verify 명령은 뒤 계획을 실행한 뒤나 단계 끝 검증에서 다시 돌려도 같은 판정을 낸다. 라이브 문서 요청(`live-check.sh pre`/`post`)과 원격 main의 최신 값 비교는 그 시점에만 참인 확인이다. 그래서 action에서만 돌리고, 첫 줄에 실행 명령을 적은 출력 전체를 EVIDENCE 해당 구간에 붙인다. 자동 verify 명령은 그 기록(`live-check: 통과`, `OK 빌드` 줄, `OK 문서` 4줄, `OK 404` 13줄, `OK 테마`, `FAIL` 없음), 표식 줄, 기록해 둔 해시(`HISTORY_PREV`, `PUSHn_PREV`, `PUSHn_SHA`)의 조상 관계를 읽는다. 기록은 실행자가 붙인 것이므로, 라이브 판정(성공 기준 4, SHELL-03)은 실행자가 쓸 수 없는 외부 근거로 두 번 다시 확인한다. (1) 각 라이브 기록 verify(02-02 T1·T3, 02-03·02-05·02-07·02-10 T3)는 기록 검사가 통과한 뒤 GitHub Pages 빌드 기록(`gh api "repos/$SLUG/pages/builds?per_page=100"`, 읽기 전용, `SLUG`는 `git remote get-url origin`에서 얻음)을 한 번 조회한다. 기록의 `OK 빌드` 줄과 같은 커밋·같은 `created_at`이고 built·오류 없음인 빌드가 있어야 하고, `OK 문서` 줄의 `lm=`이 모두 그 `created_at` 이후여야 한다. 빌드 기록은 지워지지 않으므로 다시 돌려도 판정이 같다. `pusher`는 꺼내지 않는다. (2) 02-10 Task 3 verify가 최종 상태의 시간에 매이지 않는 성질(네 URL 200과 기준 원본 제목, 내부 파일 열세 경로 404)을 라이브에서 직접 확인하고, 모든 푸시의 빌드 기록을 한 번에 다시 확인한다. 이 라이브 요청은 `PUSH4_SHA` 표식이 원격 main의 조상일 때만 보내므로, 푸시 ④ 전에는 내부 파일 URL을 요청하지 않는다 (RESEARCH Pitfall 2). 쿼리 문자열 캐시 우회는 쓰지 않는다. 후보 검증(tracer)은 `origin/main`의 지금 값 대신 기록한 `PUSHn_PREV`를 쓰고 네트워크를 쓰지 않는다. 02-01·02-04의 HEAD 기준 확인은 그 task가 만든 커밋 기준으로 바꿨다

---

## Per-Task Verification Map

요구사항·성공 기준 단위 지도입니다. Task ID는 `<계획>-T<번호>` 꼴입니다 (예: `02-04-T2` = `02-04-PLAN.md` Task 2). 계획은 10개이고 웨이브 1~10에 하나씩 순서대로 놓였습니다. 「File Exists」의 ❌ W0는 그 파일·도구를 만드는 task가 적힌 계획(주로 02-01, 02-02)에서 생긴다는 뜻입니다. 스크래치 도구(`compare.sh`, `norm_nocomment.py`, `inject.sh`, `live-check.sh`, `probe.sh`)는 저장소 밖 `$(cd "${TMPDIR:-/tmp}" && pwd -P)/rp-phase2`에 있고, 지워졌으면 만든 계획의 사양대로 다시 만듭니다.

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 02-01-T1 | 02-01 | 1 | SHELL-02 / SC1 | T-02-02 | 직접 의존성이 잠긴 gem 7개뿐 | smoke | `bundle exec jekyll -v` = `jekyll 3.10.0`; `Gemfile.lock`의 DEPENDENCIES 7개 | ❌ W0 (02-01-T1) | ⬜ pending |
| 02-01-T2 | 02-01 | 1 | SHELL-02 / SC1 | T-02-03 | N/A | smoke | `scripts/check-site.sh HEAD` → `check-site: 통과` | ❌ W0 (02-01-T2) | ⬜ pending |
| 02-04-T1, 02-04-T2, 02-04-T3, 02-06-T1 | 02-04, 02-06 | 4, 6 | SHELL-01 / SC1 | T-02-14, T-02-20 | 법적 문서·랜딩 글자 불변 | 비교(일회용) | `"$RP2/compare.sh" "$B" <각 전환 커밋>` → `OK` 5줄 (문서 4 + 파일 목록) | ❌ W0 (02-01-T1) | ⬜ pending |
| 02-01-T1, 02-01-T2, 02-04-T1~T3, 02-06-T1 | 02-01, 02-04, 02-06 | 1, 4, 6 | SHELL-01·03 / SC1 (D-08) | T-02-01 | 새로 공개되는 파일 0 | 비교(일회용) | 같은 `compare.sh` 출력의 `OK   _site 파일 목록 동일` | ❌ W0 (02-01-T1) | ⬜ pending |
| 02-08-T1, 02-10-T1 | 02-08, 02-10 | 8, 10 | SHELL-01 / SC1 (D-06) | T-02-26, T-02-32 | N/A | 비교(일회용) | `"$RP2/compare.sh" "$B" <커밋> --no-comments` → `OK` 5줄; 주석 그대로 비교는 「공통」 머리 주석 줄만 다름 | ❌ W0 (02-01-T1) | ⬜ pending |
| 02-04-T2 | 02-04 | 4 | SHELL-01 (D-02) | T-02-16 | N/A | 임시 시험 | title만 있는 시험 페이지를 `--safe` 빌드 → noindex 줄·날짜 줄 없음, h1 = title | ✅ | ⬜ pending |
| 02-06-T1, 02-10-T1 | 02-06, 02-10 | 6, 10 | SHELL-01 / SC2 | — | N/A | grep | `git grep -lF '<footer class="rp-foot">' -- '*.html'` = `_includes/footer.html`; 헤더·manifest·「공통」 머리 주석도 각자 include 하나 | ✅ | ⬜ pending |
| 02-06-T2 | 02-06 | 6 | SHELL-01 / SC2 (D-10) | T-02-22 | 메인 작업 트리 불변 | 임시 시험 | `"$RP2/probe.sh"` → include 네 개 모두 `4/4` (저장소 밖 시험용 worktree에서) | ❌ W0 (02-06-T2) | ⬜ pending |
| 02-08-T2, 02-09-T1, 02-09-T3, 02-10-T1 | 02-08, 02-09, 02-10 | 8, 9, 10 | SHELL-02 / SC3 | — | N/A | grep | `grep -n 'python3 -m http.server' CLAUDE.md .claude/CLAUDE.md README.md .planning/codebase/*.md` → 0건; `bundle exec jekyll serve --livereload`, `core.hooksPath`, `{% raw %}` 규칙이 `CLAUDE.md`에 있음 | ✅ | ⬜ pending |
| 02-09-T1 | 02-09 | 9 | SHELL-02 / SC3 | T-02-29 | 생성 구간 손 편집 없음 | 비교 | 두 CLAUDE.md 방침 구간 글자 동일; `generate-claude-md --output <사본>` 결과와 `cmp` 동일 | ✅ | ⬜ pending |
| 02-01-T2 | 02-01 | 1 | SHELL-02 / SC3 | T-02-03 | 훅이 조용히 안 도는 일 없음 | 설정 | `git config core.hooksPath` = `.githooks`; `git ls-files -s .githooks/pre-push scripts/check-site.sh` → `100755` 두 줄; 훅 실제 stdin 경로 시험 | ❌ W0 (02-01-T2) | ⬜ pending |
| 02-01-T2 | 02-01 | 1 | SHELL-02 | T-02-04 | N/A | 정적 | `/bin/bash -n scripts/check-site.sh`, `/bin/bash -n .githooks/pre-push`, 변수 뒤 비ASCII 글자 검사 0건 (bash 3.2 안전) | ❌ W0 (02-01-T2) | ⬜ pending |
| 02-01-T2, 02-06-T2 | 02-01, 02-06 | 1, 6 | SHELL-03 / SC4 | T-02-01, T-02-05, T-02-13, T-02-21 | 내부 파일·`.nojekyll`·Liquid 원문을 푸시 전에 막음 | 실패 주입 | `"$RP2/inject.sh"` → 경우 a~e(02-01), a~f(02-06) 모두 PASS. 경우 b는 02-01 사양에 front matter 분기가 있어 02-04 뒤에 다시 만들어도 같은 판정 | ❌ W0 (02-01-T2) | ⬜ pending |
| 02-03-T1, 02-05-T1, 02-07-T1, 02-10-T1 | 02-03, 02-05, 02-07, 02-10 | 3, 5, 7, 10 | SHELL-03 / SC4 | T-02-10 | 내부 파일 미공개 (1차 관문) | 자동(영구) | 후보 SHA와 기록한 `PUSHn_PREV`로 `.githooks/pre-push` 실제 stdin 경로 → `scripts/check-site.sh <sha>` 통과. `PUSHn_PREV`가 후보의 조상 (네트워크 없음, 다시 돌려도 같음) | ❌ W0 (02-01-T2) | ⬜ pending |
| 02-02-T3 (base-first일 때), 02-03-T3, 02-05-T3, 02-07-T3, 02-10-T3 | 02-02, 02-03, 02-05, 02-07, 02-10 | 2, 3, 5, 7, 10 | SHELL-03 / SC4 | T-02-07, T-02-10, T-02-18, T-02-25 | 내부 파일 미공개 (라이브) | 라이브 (action에서 실행, verify는 기록 + 빌드 기록 확인) | action: `"$RP2/live-check.sh" post <푸시 SHA>` — 404이고 응답 `age` < (지금 − 빌드 `created_at`)초, 5xx는 재시도. verify: EVIDENCE 푸시 구간의 `OK 404` 열세 줄, `live-check: 통과`, `FAIL` 없음, `LIVE_*=OK`, 그리고 `OK 빌드` 줄이 Pages 빌드 기록(`gh api …/pages/builds`, 같은 커밋·`created_at`, built, 오류 없음)과 맞음 | ❌ W0 (02-02-T1) | ⬜ pending |
| 02-02-T1, 02-03-T3, 02-05-T3, 02-07-T3, 02-10-T3 | 02-02, 02-03, 02-05, 02-07, 02-10 | 2, 3, 5, 7, 10 | SC4 / Ground Rule | T-02-07 | N/A | 라이브 (action에서 실행, verify는 기록 + 빌드 기록 확인) | action: 배포 완료(`gh run watch`) → 맨 URL 한 번 요청한 응답의 `Last-Modified` ≥ 빌드 `created_at` → 네 URL 200, `<title>`이 기준 원본과 같음 (`live-check.sh pre`/`post`). verify: EVIDENCE 구간의 `OK 문서` 네 줄, `OK 테마`, 실행 명령 줄, 그리고 문서 줄의 `lm=`이 모두 Pages 빌드 기록에서 확인한 `created_at` 이후임 (02-02-T1은 `HISTORY_PREV`의 빌드) | ❌ W0 (02-02-T1) | ⬜ pending |
| 02-10-T3 | 02-10 | 10 | SHELL-03 / SC4 (최종 상태) | T-02-34 | 내부 파일 미공개 (외부 근거로 재확인) | 라이브 (verify에서 직접 요청, 시간에 매이지 않는 성질) | `PUSH4_SHA`가 후보와 같고 원격 main의 조상일 때만: 네 URL `curl` → 200, `<title>`이 기준 원본과 같음; 열세 경로 → 404 (curl `--retry 2`). 그리고 Pages 빌드 기록 한 번 조회로 모든 푸시(base-first면 `BASE_PUSH_SHA` 포함)가 built·오류 없음 | ✅ | ⬜ pending |
| 02-03-T3, 02-05-T3, 02-07-T3, 02-10-T3 | 02-03, 02-05, 02-07, 02-10 | 3, 5, 7, 10 | SC4 (D-17) | T-02-17, T-02-23, T-02-32 | N/A | 라이브 (action에서 실행, verify는 기록 확인) | action: 신선한 응답 본문을 기준 원본과 D-07 정규화로 비교 = 0; 푸시 ④ 뒤에는 `--no-comments`. verify: 기록의 `OK 문서` 네 줄과 실행 명령 줄(02-10은 `--no-comments` 포함) | ❌ W0 (02-02-T1) | ⬜ pending |
| 02-10-T3 | 02-10 | 10 | SHELL-01·02·03 | T-02-34 | N/A | 기록 | `02-EVIDENCE.md`의 근거 표식 19개와 `## Phase 2 성공 기준 판정` 구간 | ✅ | ⬜ pending |

**되돌리기 절차 (D-18, 자동 verify가 아니라 FAIL 때만 도는 절차):** 02-02(base-first)는 푸시 범위 전체 `PREV..BASE_SHA`를 한 번에 revert한다. 02-03(푸시 ①)은 `HISTORY_DECISION`으로 대상을 정한다. base-first면 `HOOK_SHA`·`BUILD_CONFIG_SHA` 두 커밋만, together면 푸시 범위 전체 `PUSH1_PREV..PUSH1_SHA`를 한 번에 revert한다. together의 범위에는 Phase 1 이력이 들어 있어서, 두 커밋만 되돌려서는 Phase 1이 연 내부 파일이 닫히지 않기 때문이다. 어느 경우든 범위 안의 커밋을 골라 되돌리지 않는다(exclude에 `.planning/`을 더한 Phase 1 커밋만 되돌리면 `.planning/`이 공개됨). 되돌리기는 저장소 밖 worktree(`$RP2/rollback`)에서 하고, 메인 체크아웃의 점검 도구로 `scripts/check-site.sh <RB>`, `compare.sh`, 트리 동일(`git diff --quiet`, 범위 전체 revert는 `PREV`와 전체 동일, 02-03 base-first는 `.planning/` 밖에서 기준 커밋과 동일)을 확인한다. 02-05·02-07·02-10은 범위 안의 사이트 커밋이 전환 커밋뿐이라 기존 경로 선택 방식을 그대로 둔다. **되돌리기 푸시 승인 (D-16):** 다섯 계획 모두 FAIL이면 Task 3을 실패로 끝내고, 되돌리기 푸시는 그 자리에서 띄우는 `checkpoint:decision`(gate="blocking-human", options `rollback-push`/`other`)으로만 승인받는다. auto task 안에서 말로 승인을 묻지 않는다. 승인 뒤 메인 체크아웃에서 훅 점검을 거쳐 푸시한다. 02-04·02-06·02-08·02-09에는 푸시가 없다.

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `Gemfile`, `Gemfile.lock`, `bundle config set --local path vendor/bundle`, `bundle install` (메인 체크아웃에서)
- [ ] `scripts/check-site.sh` (100755), `.githooks/pre-push` (100755), `git config core.hooksPath .githooks`
- [ ] 스크래치(저장소 밖)에 `compare.sh`, `norm_nocomment.py` 생성, `BASE_SHA` 기록
- [ ] `_config.yml`의 `url`과 `exclude`, `.gitignore` 4줄(`_site/`, `.jekyll-cache/`, `vendor/`, `.bundle/`)
- [ ] **실행 전 사용자 설정:** `.planning/config.json`의 `workflow.use_worktrees`를 `false`로 바꿉니다 (지금 `true`). 모든 계획의 Task 1 precondition이 메인 체크아웃(`git rev-parse --path-format=absolute --git-dir`과 `--git-common-dir`이 같음)을 요구합니다. gem(`vendor/bundle`, `.bundle/config`)과 pre-push 훅이 메인 체크아웃에만 있기 때문입니다. `true`인 채로 실행하면 02-01 Task 1에서 멈춥니다. 계획은 설정 파일을 고치지 않습니다 (사용자 결정)
- [ ] worktree 주의: `compare.sh`·라이브 확인·푸시는 메인 체크아웃에서 돌립니다. 계획이 스스로 만드는 시험용 worktree(`$RP2/inject`, `$RP2/probe-wt`, 푸시 ① 되돌리기의 `$RP2/rollback`)는 저장소 밖에만 두고, 검증과 푸시는 메인 체크아웃의 점검 도구로 합니다

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
