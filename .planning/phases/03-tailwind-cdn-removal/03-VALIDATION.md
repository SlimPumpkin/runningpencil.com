---
phase: "3"
slug: "tailwind-cdn-removal"
# status lifecycle: draft (seeded by plan-phase) → validated (set by validate-phase §6)
# audit-milestone §5.5 distinguishes NOT-VALIDATED (draft) from PARTIAL (validated + nyquist_compliant: false) (#2117)
status: draft
nyquist_compliant: false
wave_0_complete: false
created: "2026-11-16"
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
- **시험 본문 (D-19):** ③ 사본에만 넣은 `sample/index.html`로 `sample.mjs` → `PASS` + 3폭 × 2엔진 캡처를 사이트 푸시 `checkpoint:decision`에서 사용자 승인
- **Every push:** pre-push 훅(자동) → `checkpoint:decision`(푸시 승인, 그 푸시 한 번에만) → 푸시 → 라이브 확인(D-22: 배포 완료 확인 뒤 HTTP 200·제목·Tailwind 0건, 라이브 2엔진 × 3폭 × 3문서 캡처가 기준과 0픽셀)
- **Before `/gsd-verify-work`:** 사이트 푸시 라이브 확인과 문서 푸시 HTTP 확인이 모두 통과
- **Max feedback latency:** 로컬 quick ~2초, 커밋별 full ~3분. 라이브 확인은 배포 완료와 캐시(`max-age=600`) 우회(`?cb=<커밋>`)를 거쳐 몇 분

---

## Per-Task Verification Map

요구사항·성공 기준 단위 지도입니다. Task ID는 계획을 만든 뒤 `<계획>-T<번호>` 꼴로 채웁니다.

| Task ID | Plan | Wave | Requirement | Threat Ref | Secure Behavior | Test Type | Automated Command | File Exists | Status |
|---------|------|------|-------------|------------|-----------------|-----------|-------------------|-------------|--------|
| TBD | TBD | TBD | SHELL-04 / SC1 (D-18) | — | 외부 스크립트(Tailwind Play CDN) 0건 | grep + 브라우저 | `grep -rlF -e cdn.tailwindcss.com -e tailwind.config --include='*.html' "$W/c3/site"` → 빈 출력; `node report.mjs base1 c3 --no-cdn` → `PASS 18 rows`; 라이브 curl 3문서 → 0 0 0; ③ 이후 `scripts/check-site.sh` Tailwind 항목 | ❌ W0 (스크래치) / check-site 항목은 구현 대상 | ⬜ pending |
| TBD | TBD | TBD | SHELL-04 / SC2 (D-13·D-14·D-15) | — | N/A | 픽셀 비교(일회용) | `node diff.mjs base1 cN` → `PASS 0 diffs` (PNG 42장); `node states.mjs cN` 실패 0; `node report.mjs base1 cN` → `PASS 18 rows` | ❌ W0 | ⬜ pending |
| TBD | TBD | TBD | SHELL-04 / SC3 (D-17) | — | N/A | 텍스트 비교(일회용) | `diff.mjs`의 `*.txt`(article.innerText 18건) 바이트 비교 → 차이 0 | ❌ W0 | ⬜ pending |
| TBD | TBD | TBD | SHELL-04 / SC4 (D-19) | — | N/A | 계산된 스타일 + 캡처 승인 | `node sample.mjs http://127.0.0.1:<포트>/sample/ "$W/cap/sample"` → `PASS` + 6장 캡처 사용자 승인 | ❌ W0 (시험 본문은 스크래치 사본에만) | ⬜ pending |
| TBD | TBD | TBD | 랜딩 불변 | — | N/A | 바이트 비교(일회용) | `cmp "$W/base/site/index.html" "$W/cN/site/index.html"`; `_site` 파일 목록 `diff` 0 | 명령만 | ⬜ pending |
| TBD | TBD | TBD | Ground Rule (URL·제목) | — | N/A | check-site + curl | `scripts/check-site.sh <커밋>`; 라이브 `curl -s -o /dev/null -w '%{http_code}'` 3 URL → 200 | ✅ | ⬜ pending |
| TBD | TBD | TBD | D-22 라이브 | — | N/A | 픽셀 비교(일회용) | `node capture.mjs https://runningpencil.com "$W/cap/live" "?cb=$SHA" && node diff.mjs "$W/cap/base1" "$W/cap/live"` → `PASS 0 diffs` | ❌ W0 | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `$TMPDIR/rp-p3/pw/` — `npm install playwright@1.59.1 pngjs@7.0.0` (+ Chromium·WebKit 브라우저). 설치 전 `checkpoint:decision` (RESEARCH Open Questions: 패키지 점검이 최신판을 「too new」로 표시)
- [ ] `capture.mjs`, `diff.mjs`, `states.mjs`, `report.mjs`, `sample.mjs` — RESEARCH §Validation Architecture 원문 그대로
- [ ] 기준 빌드·서빙 함수(`build`·`serve`) — RESEARCH §빌드·서빙 블록
- [ ] 시험 본문 `sample/index.html`(front matter `layout: legal`) — ③ 사본의 원본 폴더에만 넣어 빌드, 커밋하지 않음
- [ ] 결과(기준 SHA, CDN 리디렉션 버전, 판정 출력)를 남길 검증 문서

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| 시험 본문(표·목록·주석)이 카드 디자인에 맞게 보임 | SHELL-04 / SC4 (D-19) | 「디자인에 맞음」은 사용자 판단 (계산된 스타일은 `sample.mjs`가 자동 확인) | 3폭 × 2엔진 캡처 6장을 사이트 푸시 `checkpoint:decision`에서 보여 주고 승인 받음. 375px 표 줄바꿈(기본 vs `th { white-space: nowrap }`)도 함께 고름 |
| 사이트·문서 푸시 승인 | Ground Rule (main 푸시 = 배포) | 되돌리기 비용이 큰 라이브 배포 (D-21) | 푸시마다 `checkpoint:decision`, 승인은 그 푸시 한 번에만 |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags (`jekyll serve --livereload` 금지, `python3 -m http.server`로 `_site` 서빙)
- [ ] Feedback latency < 200s (커밋별 full)
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
