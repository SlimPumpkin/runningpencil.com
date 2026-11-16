---
phase: "4"
slug: "landing-content-fix"
# status lifecycle: draft (seeded by plan-phase) → validated (set by validate-phase §6)
# audit-milestone §5.5 distinguishes NOT-VALIDATED (draft) from PARTIAL (validated + nyquist_compliant: false) (#2117)
status: draft
nyquist_compliant: false
wave_0_complete: false
created: "2026-11-17"
---

# Phase 4 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.
> 근거: `04-RESEARCH.md` 「Validation Architecture」. 이 저장소에는 테스트 러너가 없으므로 셸·CLI 명령과 스크래치 Playwright로 검증합니다. 스크래치 도구(`$TMPDIR/rp-p4/`)는 커밋하지 않고, 판정 출력만 `04-EVIDENCE.md`에 남깁니다.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | `scripts/check-site.sh`(저장소) + 스크래치 Node 스크립트 + Playwright 1.59.1(Chromium·WebKit, pnpm 설치, 커밋 안 함) |
| **Config file** | 없음. Wave 0에서 `$TMPDIR/rp-p4/lib.sh`(Phase 3의 `build`·`serve`)와 `pw/p4-behave.mjs`·`pw/p4-shots.mjs`를 만듭니다 |
| **Quick run command** | `scripts/check-site.sh <커밋>` |
| **Full suite command** | `build cN <커밋> && serve cN <포트> && node p4-behave.mjs http://127.0.0.1:<포트>` (스크린샷 커밋은 `p4-shots.mjs`를 더함) |
| **Estimated runtime** | check-site 약 2초, 전체 약 60초 |

---

## Sampling Rate

- **사이트 커밋마다:** `scripts/check-site.sh <커밋>` + grep 판정 + `p4-behave.mjs`(Chromium·WebKit)
- **스크린샷 커밋:** 위에 더해 `p4-shots.mjs`와 이미지 CLI 판정(`webpinfo`, `stat`, `sips`)
- **기준:** 어떤 변경보다 먼저 실행 시작 커밋을 빌드하고 `p4-behave.mjs`가 기준에서도 `PASS`인지 봅니다. 기준에서 실패하면 멈추고 알립니다
- **푸시마다:** pre-push 훅(자동) → `checkpoint:decision` → 푸시 → 라이브 배포 확인
- **Before `/gsd-verify-work`:** 문구 푸시와 문서 푸시의 라이브 확인 통과. 스크린샷 푸시는 캡처가 온 뒤 따로 확인
- **Max feedback latency:** 60초

---

## Per-Task Verification Map

계획자가 PLAN.md를 만든 뒤 채웁니다. 요구사항별 판정 기준은 아래와 같습니다 (`04-RESEARCH.md` 「Phase Requirements → Test Map」).

| Req / 기준 | Behavior | Test Type | Automated Command | File Exists | Status |
|------------|----------|-----------|-------------------|-------------|--------|
| SITE-01 / SC1 | `_site/index.html`에 포인트·굿즈·코스북 0줄 (법적 3종은 Phase 6~8 범위라 제외) | grep | `grep -c -E '포인트\|굿즈\|코스북' "$W/cN/site/index.html"` → `0` | ❌ W0 | ⬜ pending |
| SITE-01 / D-02 | 메타·OG 문장이 D-02와 같고 `<title>`·`og:title`은 그대로 | grep | `grep -cF '완주하면 그 모양 그대로 뱃지가 돼요. iOS · Android 앱 출시 준비 중.'` → 1, `grep -cF '나만의 코스를 그려 올릴 수도 있어요.'` → 1, check-site 3번 | ✅ | ⬜ pending |
| SITE-01 / D-04·D-05 | 3단계 글·캡션이 새 문장, 「채울 뱃지」「실루엣」 0줄 | grep | `grep -cF '받은 뱃지는 보관함에 모여요.'` → 1, `grep -cF '보관함 · 받은 뱃지 7'` → 1, `grep -c -E '채울 뱃지\|실루엣'` → 0 | ✅ | ⬜ pending |
| SITE-01 / D-06 | `t-empty` 요소 0개, 뱃지 줄 7개·스티커 6개 유지 | grep + DOM | `grep -c 'class="rp-badge t-empty"'` → 0; Playwright에서 개수 확인 | ✅ | ⬜ pending |
| 의도한 줄만 | 커밋 전후 `_site/index.html` diff가 기대 행 집합과 같고 법적 3종은 바이트 동일 | diff | RESEARCH 「`_site/index.html` 의도한 줄만 바뀜」 블록 | ❌ W0 | ⬜ pending |
| SITE-06 / SC2 | 375·1280px에서 새 구간 + 「출시 준비 중」 딱지 + 3장 + 출처 줄이 보임 | 캡처 + DOM | `p4-shots.mjs` (두 엔진 × 두 폭) | ❌ W0 | ⬜ pending |
| SITE-06 / D-14 | 페이지 가로 밀림 없음, 띠 키보드 밀기, 다음 장 엿보기 | DOM 숫자 | `scrollWidth <= innerWidth`, focus → ArrowRight → `scrollLeft` 증가 | ❌ W0 | ⬜ pending |
| SITE-06 / 이미지 | WebP에 EXIF·XMP·ICCP 없음, 크기 상한, 비율 = `width/height` 속성 | CLI | `webpinfo f.webp \| grep -c -E 'EXIF\|XMP\|ICCP'` → 0 | ❌ W0 | ⬜ pending |
| SC3 | 고정 스크롤·단계 전환, 7초 달려 보기, 움직임 줄이기, 콘솔 오류 0 (Chromium·WebKit) | 브라우저 | `node p4-behave.mjs <URL>` → `PASS behave` | ❌ W0 | ⬜ pending |
| Ground Rule | 4 URL 200·제목, 내부 파일 없음, Liquid 잔여 없음 | check-site + curl | `scripts/check-site.sh <커밋>`, 라이브 `curl` | ✅ | ⬜ pending |
| D-08 문서 | 기준 문장 세 곳에서 「출시 예정」이 바뀜 (Phase 9 줄은 남음) | grep + 도구 | REQUIREMENTS SITE-06 줄·ROADMAP Phase 4 Goal·SC2 줄에 「출시 예정」 0, `gsd-tools roadmap validate` | ✅ | ⬜ pending |

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `$TMPDIR/rp-p4/lib.sh` — Phase 3의 `build`·`serve` 함수 (`pwd -P`로 실제 경로 사용)
- [ ] `$TMPDIR/rp-p4/pw` — playwright 1.59.1 (+ 선택 pngjs 7.0.0) pnpm 설치. rp-p3 사본이 있으면 재사용
- [ ] `p4-behave.mjs` (SC3), `p4-shots.mjs` (스크린샷 커밋 때)
- [ ] `04-EVIDENCE.md` — 기준 SHA, 판정 출력, 라이브 확인 기록

*테스트 러너 설치는 하지 않습니다 (저장소 방침).*

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| 캡처에 출시 범위 밖 기능이 없음 (하단 탭·포인트·굿즈·코스북·Dev·장소 검색 결과 목록·개인정보) | SITE-06 / SC2 | 이미지 내용 판단은 자동화할 수 없음 | 375·1280px 캡처를 보고 항목별로 판정해 EVIDENCE에 기록 |
| 캡처 안 NAVER 로고가 온전히 보임 (폰 테두리 안쪽 반경에 깎이지 않음) | SITE-06 / D-20 | 로고 위치가 캡처마다 다름 | 375·1280px 캡처에서 장마다 로고 위치와 온전함 확인 |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 60s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
