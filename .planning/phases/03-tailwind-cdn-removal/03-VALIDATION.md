---
phase: "3"
slug: "tailwind-cdn-removal"
# status lifecycle: draft (seeded by plan-phase) → validated (set by validate-phase §6)
# audit-milestone §5.5 distinguishes NOT-VALIDATED (draft) from PARTIAL (validated + nyquist_compliant: false) (#2117)
status: validated
nyquist_compliant: true
wave_0_complete: true
created: "2026-11-16"
validated: "2026-11-16"
---

# Phase 3 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.
> 출처: `03-RESEARCH.md` §Validation Architecture. 이 저장소에는 테스트 프레임워크가 없어 셸·CLI 명령과 스크래치 Playwright 스크립트로 검증합니다. 「영구」는 저장소에 커밋되어 이후 단계에서도 도는 것(`scripts/check-site.sh`), 「일회용」은 Phase 3에서 스크래치(저장소 밖 `$TMPDIR/rp-p3`)로 돌리고 결과만 검증 문서에 남기는 것입니다(CONTEXT Claude's Discretion: 비교 도구는 커밋하지 않음).

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | 스크래치 Node 스크립트 + Playwright 1.59.1(Chromium·WebKit) + pngjs 7.0.0 (커밋하지 않음) + `scripts/check-site.sh`(저장소) |
| **Config file** | 없음 — Wave 0에서 `$TMPDIR/rp-p3/pw/`에 `capture.mjs`·`diff.mjs`·`states.mjs`·`report.mjs`·`sample.mjs`를 만듭니다 (원문은 RESEARCH §Validation Architecture) |
| **Quick run command** | `scripts/check-site.sh <커밋>` (빌드·내부 파일·제목·Liquid, ③ 이후 Tailwind 0건) |
| **Full suite command** | 커밋별 한 줄: `build cN <커밋> && serve cN <포트> && node capture.mjs … && node diff.mjs base1 cN && node states.mjs cN && node report.mjs base1 cN [--no-cdn]` |
| **Estimated runtime** | ~2초 (quick), ~3분 (full, 커밋 하나당 PNG 42장 + txt 18건) |

---

## Sampling Rate

- **After every 사이트 커밋 (D-20 ①②③ 각각):** `scripts/check-site.sh <커밋>` + 그 커밋의 `diff.mjs`(0픽셀, 텍스트 동일)·`states.mjs`(hover/focus 캡처가 실제로 찍힘)·`report.mjs`(링크 계산값·transition 3종·키보드 focus·높이·가로 밀림). ③은 `report.mjs … --no-cdn`
- **기준 캡처 (D-16):** 어떤 변경보다 먼저, 실행 시작 커밋을 두 번 찍어 `diff.mjs base1 base2` → `PASS 0 diffs`. 0이 아니면 D-13대로 멈추고 사용자에게 알림
- **시험 본문 (D-19):** ③ 사본에만 넣은 `sample/index.html`로 `sample.mjs` → `PASS` + 두 변형(기본·머리 행 줄바꿈 금지) × 3폭 × 2엔진 캡처를 03-05 Task 2의 별도 `checkpoint:decision`에서 사용자 승인(사이트 푸시 승인은 03-06 Task 2에서 따로 받음)
- **Every push:** pre-push 훅(자동) → `checkpoint:decision`(푸시 승인, 그 푸시 한 번에만) → 푸시 → 라이브 확인(D-22: 배포 완료 확인 뒤 HTTP 200·제목·Tailwind 0건, 라이브 2엔진 × 3폭 × 3문서 캡처가 기준과 0픽셀)
- **Before `/gsd-verify-work`:** 사이트 푸시 라이브 확인과 문서 푸시 HTTP 확인이 모두 통과
- **Max feedback latency:** 로컬 quick ~2초, 커밋별 full ~3분. 라이브 확인은 배포 완료와 캐시(`max-age=600`) 우회(`?cb=<커밋>`)를 거쳐 몇 분

---

## Per-Task Verification Map

요구사항·성공 기준 단위 지도입니다. Task ID는 `<계획>-T<번호>` 꼴입니다(체크포인트 task는 자동 명령이 없어 뺐습니다: 03-01-T2 설치 승인, 03-05-T2 시험 본문 승인, 03-06-T2 사이트 푸시 승인, 03-09-T2 문서 푸시 승인). `$W`는 `$(cd "${TMPDIR:-/tmp}" && pwd -P)/rp-p3`, `judge.sh <이름>`은 base1 대비 PNG 42장·txt 18건 개수 확인 + `diff.mjs`(`PASS 0 diffs`) + `states.mjs`(`ok=24 vacuous=0`) + `report.mjs`(`PASS 18 rows`)를 한 번에 돌리는 스크래치 판정 도구입니다(03-01-PLAN.md scratch_contract). 커밋별 check-site는 그 커밋 안의 스크립트(`git show <커밋>:scripts/check-site.sh`)로 돌려, 5번 항목이 생긴 뒤에도 ①·②의 판정이 그대로 재현되게 합니다.

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| 03-01-T1 | 03-01 | 1 | D-16 기준 기록 (SC1 전환 전 상태) | T-03-02, T-03-03 | 기준 커밋과 원격 main의 사이트 트리 동일, 기록에 로컬 경로 없음 | 기록 + 빌드 + HTTP | EVIDENCE `BASE_SHA`·`BASE_LIVE`·`TW_CDN_VERSION=3.4.17`·`OK HTTP` 4줄(법적 3줄 `tailwind=1`); `$W/base/TREE` == 기준 트리 | ❌ W0 (스크래치) | ✅ green |
| 03-01-T3 | 03-01 | 1 | SHELL-04 / SC2 기준 자기 차이 (D-13·D-14·D-15) | T-03-01, T-03-04 | 고정 버전 도구를 스크래치에만 설치 | 픽셀 비교(일회용) | `"$W/judge.sh" base2` → `JUDGE base2 OK`; 한 픽셀 바꾼 사본 `judge.sh neg` → `JUDGE neg FAIL` | ❌ W0 | ✅ green |
| 03-02-T1 | 03-02 | 2 | SHELL-04 / SC2·SC3 커밋 ① (D-20 ①), 랜딩 불변 | T-03-05, T-03-06 | `.rp-doc` 범위 선택자, common.css·index.html 불변 | 픽셀·텍스트 + check-site + 바이트 비교 | 커밋 ① 안의 check-site로 ① 통과; `"$W/judge.sh" c1` → `JUDGE c1 OK`; `cmp "$W/base/site/index.html" "$W/c1/site/index.html"` | ❌ W0 | ✅ green |
| 03-02-T2 | 03-02 | 2 | SHELL-04 / SC2 ③ 미리보기 (RESEARCH Pitfall 1) | T-03-07 | — | 픽셀 비교(일회용) | `"$W/judge.sh" c1p --no-cdn` → `JUDGE c1p OK` | ❌ W0 | ✅ green |
| 03-03-T1 | 03-03 | 3 | SHELL-04 / SC2·SC3 커밋 ② (D-17, D-20 ②) | T-03-08 | 문장 변경 0 | 픽셀·텍스트 + 원본 텍스트 diff | `"$W/judge.sh" c2` → `JUDGE c2 OK`; 커밋 ① 대비 태그 지운 원본 diff 0줄; 본문 `class=` 0 0 0 | ❌ W0 | ✅ green |
| 03-03-T2 | 03-03 | 3 | SHELL-04 / SC4 실제 문서 쪽 (D-01~D-04), Deferred 보존 | T-03-09 | noindex·「임시 게시본」·「포인트」 줄 수 보존 | 정적 확인 | 커밋 ② 본문의 section→h2, footer 마지막, 허용 요소, `C2_CONTRACT=OK` | ✅ (git show) | ✅ green |
| 03-04-T1 | 03-04 | 4 | SHELL-04 / SC1·SC2·SC3 커밋 ③ (D-18, D-20 ③) | T-03-10, T-03-12 | 외부 실행 스크립트 0건 | grep + 픽셀 + 네트워크 | `grep -rlF -e cdn.tailwindcss.com -e tailwind.config --include='*.html' "$W/c3/site"` → 빈 출력; `"$W/judge.sh" c3 --no-cdn` → `JUDGE c3 OK` | ❌ W0 | ✅ green |
| 03-04-T2 | 03-04 | 4 | SHELL-04 / SC1 재유입 차단 | T-03-11 | pre-push가 Tailwind 재유입을 거부 | check-site 음성 대조 | 점검 커밋 안의 스크립트로 커밋 ② → 실패(`Tailwind Play CDN이 출력에 남아 있습니다`), 점검 커밋 → 통과; `/bin/bash -n` | ✅ (구현 대상) | ✅ green |
| 03-05-T1 | 03-05 | 5 | SHELL-04 / SC4 시험 본문 (D-19, D-06~D-12) | T-03-13, T-03-14 | 시험 본문 미커밋, 375px 페이지 가로 밀림 없음 | 계산된 스타일 + 캡처 | `node sample.mjs http://127.0.0.1:<포트>/sample/ "$W/cap/sample"` → `PASS`(기본·nowrap 두 변형, 종료 코드 0) | ❌ W0 (시험 본문은 스크래치에만) | ✅ green |
| 03-05-T3 | 03-05 | 5 | SHELL-04 / SC4 승인과 표 줄바꿈 선택 | T-03-15 | — | 기록 분기 + 픽셀 비교 | `TABLE_WRAP=plain|nowrap`; nowrap이면 `"$W/judge.sh" nw --no-cdn` → `JUDGE nw OK` | ❌ W0 | ✅ green |
| 03-06-T1 | 03-06 | 6 | Ground Rule 푸시 범위 (D-21 ①) | T-03-16, T-03-19 | 승인받은 SHA만, 사이트 파일 6개 | 훅 경로 | 후보를 `.githooks/pre-push`로 → `check-site: 통과`; 후보 사이트 트리 == 마지막 판정 커밋 | ✅ | ✅ green |
| 03-06-T3 | 03-06 | 6 | SHELL-04 / SC1·SC2·SC3 라이브 (D-22) | T-03-17, T-03-18 | 배포 완료 확인, 라이브 Tailwind 0건 | HTTP + 픽셀 비교 | Pages 빌드 기록(커밋·created_at·built) 대조; `OK HTTP … tailwind=0 new=1` 3줄; `"$W/judge.sh" live --no-cdn` → `JUDGE live OK` | ❌ W0 | ✅ green |
| 03-07-T1 | 03-07 | 7 | 문서 (D-24, D-25) | T-03-20, T-03-21 | — | grep + 생성기 사본 | STACK·CONVENTIONS·ARCHITECTURE의 Tailwind 흔적 0줄, CONVENTIONS 「법적 본문 작성 규칙」; 생성기 사본에서 세 블록 밖 동일 | ✅ | ✅ green |
| 03-07-T2 | 03-07 | 7 | 문서 (D-24) | T-03-20 | — | grep | CONCERNS·STRUCTURE·TESTING·INTEGRATIONS의 Tailwind 흔적 0줄, TESTING 「다섯 가지」 | ✅ | ✅ green |
| 03-08-T1 | 03-08 | 8 | 문서 (D-24, D-25) | T-03-22, T-03-24 | 생성 구간 손 편집 없음 | 재생성 바이트 비교 | 두 CLAUDE.md 방침 구간 동일·「Phase 3까지 적용됨」; `generate-claude-md --output` 사본과 `cmp` | ✅ | ✅ green |
| 03-08-T2 | 03-08 | 8 | 문서 전체 훑기 (D-24) | T-03-23 | 로컬 경로 0줄 | grep | 열 개 문서의 Tailwind 흔적·옛 항목 수·로컬 경로 0줄, README 「Tailwind 없음」 | ✅ | ✅ green |
| 03-09-T1 | 03-09 | 9 | 문서 푸시 범위 (D-21 ②) | T-03-25 | 승인받은 SHA만, 문서 셋뿐 | 훅 경로 | 범위의 `.planning/` 밖 파일 = `.claude/CLAUDE.md CLAUDE.md README.md`; 훅 통과 | ✅ | ✅ green |
| 03-09-T3 | 03-09 | 9 | Ground Rule (URL·제목) + SC1 최종 + 판정표 | T-03-26, T-03-27, T-03-28 | `/CLAUDE.md`·`/README.md` 404 | HTTP + 기록 | Pages 빌드 기록 대조; 라이브 세 법적 URL 200·제목·Tailwind 0; `PHASE3_SC=OK` | ✅ | ✅ green |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [x] `$TMPDIR/rp-p3/pw/` — `npm install playwright@1.59.1 pngjs@7.0.0` (+ Chromium·WebKit 브라우저). 설치 전 `checkpoint:decision` 03-01-T2 (RESEARCH Package Legitimacy Audit: 패키지 점검이 최신판을 「too new」로 표시). 설치·스크립트·기준 캡처는 03-01-T3. (실제로는 사용자 지시로 npm 대신 pnpm 10.33.2로 같은 고정 버전을 설치함. EVIDENCE `PW_VERSION=1.59.1`·`PNGJS_VERSION=7.0.0`·`PW_BROWSERS`)
- [x] `capture.mjs`, `diff.mjs`, `states.mjs`, `report.mjs` — RESEARCH §Validation Architecture 원문 그대로. `sample.mjs`는 원문에 종료 코드와 `th`·`dt`·375px 넓은 표 넘침·사이트 바닥글 테두리 확인을 더한 판 (03-01-T3)
- [x] 기준 빌드·서빙 함수(`build`·`serve`·`stop`, `$W/lib.sh`) — RESEARCH §빌드·서빙 블록에 저장소 경로를 `git rev-parse --show-toplevel`로 잡고 TREE 기록과 서빙 바이트 확인을 더한 판 (03-01-T1)
- [x] 판정 도구 `$W/judge.sh` — 개수 고정(PNG 42·txt 18·hover/focus 24)과 diff·states·report를 한 번에 판정 (03-01-T3)
- [x] 시험 본문 `sample/index.html`(front matter `layout: legal`) — 최종 트리 사본의 원본 폴더에만 넣어 빌드, 커밋하지 않음 (03-05-T1)
- [x] 결과(기준 SHA, CDN 리디렉션 버전, 판정 출력)를 남길 검증 문서 `03-EVIDENCE.md` (03-01-T1에서 만듦)

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| 시험 본문(표·목록·주석)이 카드 디자인에 맞게 보임 | SHELL-04 / SC4 (D-19) | 「디자인에 맞음」은 사용자 판단 (계산된 스타일은 `sample.mjs`가 자동 확인) | 두 변형(기본·`th { white-space: nowrap }`) × 3폭 × 2엔진 캡처 12장을 03-05 Task 2의 `checkpoint:decision`에서 보여 주고 승인 받음. 375px 표 머리 행 줄바꿈(`plain`·`nowrap`)도 함께 고름. 이 승인은 사이트 푸시 승인이 아님(푸시는 03-06 Task 2) |
| 사이트·문서 푸시 승인 | Ground Rule (main 푸시 = 배포) | 되돌리기 비용이 큰 라이브 배포 (D-21) | 푸시마다 `checkpoint:decision`, 승인은 그 푸시 한 번에만 |

---

## Validation Sign-Off

- [x] All tasks have `<automated>` verify or Wave 0 dependencies
- [x] Sampling continuity: no 3 consecutive tasks without automated verify
- [x] Wave 0 covers all MISSING references
- [x] No watch-mode flags (`jekyll serve --livereload` 금지, `python3 -m http.server`로 `_site` 서빙)
- [x] Feedback latency < 200s (커밋별 full)
- [x] `nyquist_compliant: true` set in frontmatter

**Approval:** validated 2026-11-16. 영구 명령과 계획 verify를 다시 돌린 결과는 다음과 같다.
- 커밋 안의 check-site로 기준 `8b65fdb59232`, ① `7cd2b6128884`, ② `31327b684f43`, ③ `c49e12a50394` 모두 통과
- 작업 트리 check-site(5항목)로 점검 커밋 `69f46942bec6`, nowrap `fb6bdfa40b70`, 사이트 푸시 `2ebeca06ca51`, 문서 푸시 `3f148e83d849`, HEAD 모두 통과
- 음성 대조: 점검 커밋의 스크립트로 ②를 점검하면 `Tailwind Play CDN이 출력에 남아 있습니다`로 실패 (재유입 차단)
- `bash -n scripts/check-site.sh` 통과, `core.hooksPath=.githooks`, `scripts/check-site.sh`·`.githooks/pre-push` 모두 100755
- 계획 9개의 `<automated>` verify 31개를 HEAD에서 다시 돌려 모두 rc=0 (스크래치 판정 도구가 남아 있어 judge 행도 재판정됨)

일회용 행은 EVIDENCE 표식으로 뒷받침된다: `BASE_SELFDIFF=OK`, `JUDGE_NEG=OK`, `JUDGE base2/c1/c1p/c2/c3/nw/live OK`, `JUDGE neg FAIL`, `C1_PIXEL`·`C1_PREVIEW3`·`C2_PIXEL`·`C3_PIXEL`·`NOWRAP_PIXEL=OK`, `C2_CONTRACT=OK`, `CHECK5=OK`, `SAMPLE=OK`, `SC4_DECISION=approved`, `TABLE_WRAP=nowrap`, `LIVE_SITE=OK`, `DOCS_STALE=OK`, `LIVE_DOCS=OK`, `PHASE3_SC=OK`. 03-09 문서 푸시 뒤 `/CLAUDE.md`·`/README.md`의 CDN 일시 503은 사용자 결정으로 404 판정했다 (EVIDENCE `## 03-09 503 판정과 사용자 결정`).

## Validation Audit 2026-11-16

| Metric | Count |
|---|---|
| Gaps found | 0 |
| Resolved | 0 |
| Escalated | 0 |
