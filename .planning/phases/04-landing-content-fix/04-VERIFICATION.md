---
phase: 04-landing-content-fix
verified: 2026-11-18T08:27:59Z
status: human_needed
score: 66/74 must-haves verified
covered_files:
  - ".claude/CLAUDE.md"
  - ".planning/baseline/USER-TASKS.md"
  - ".planning/codebase/ARCHITECTURE.md"
  - ".planning/codebase/CONVENTIONS.md"
  - ".planning/codebase/INTEGRATIONS.md"
  - ".planning/codebase/STACK.md"
  - ".planning/codebase/STRUCTURE.md"
  - ".planning/codebase/TESTING.md"
  - ".planning/phases/04-landing-content-fix/04-01-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-01-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-02-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-02-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-03-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-03-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-04-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-04-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-05-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-05-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-06-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-06-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-07-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-07-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-08-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-08-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-09-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-09-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-10-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-10-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-11-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-11-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-12-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-12-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-13-PLAN.md"
  - ".planning/phases/04-landing-content-fix/04-13-SUMMARY.md"
  - ".planning/phases/04-landing-content-fix/04-CONTEXT.md"
  - ".planning/phases/04-landing-content-fix/04-EVIDENCE.md"
  - "CLAUDE.md"
  - "README.md"
  - "images/app/screen-badge-564.webp"
  - "images/app/screen-badge-846.webp"
  - "images/app/screen-draw-564.webp"
  - "images/app/screen-draw-846.webp"
  - "images/app/screen-run-564.webp"
  - "images/app/screen-run-846.webp"
  - "index.html"
  - "scripts/check-site.sh"
covered_digest: "v4:sha256:94199abadb3e78199e8fa03c3973cadf0c47470e353291a1262c01ebd82d46da"
behavior_unverified: 0
overrides_applied: 1
overrides:
  - must_have: "Claude가 세 장을 직접 열어 항목별로 검토해 모두 OK다: 하단 탭 없음, Dev 표시 없음, 개인 정보 없음, 지도가 보이는 장의 NAVER 로고가 잘리거나 가려지지 않음 (04-09 truth 3)"
    reason: "③ 완주 결과 캡처는 앱의 뱃지 창이 NAVER 로고 오른쪽을 덮은 원본 장면이고(ORIG_REVIEW badge logo FAIL), run·badge의 상태 표시줄 차이 두 건도 원래 판정이 FAIL이었다. 사용자가 NAVER 지도 SDK 가이드 문장과 위험을 들은 뒤 세 건을 사용자 예외로 허용했다. 로고 조건은 「우리가 원본보다 더 자르거나 덮지 않는다」로 바뀌었다. 근거는 04-CONTEXT.md D-18·D-20의 「캡처 검토 뒤 사용자 결정 (2026-11-18, 04-09 Task 3)」과 04-EVIDENCE.md의 CAPTURE_WAIVERS=3이다. 이 override 항목은 검증자가 그 기록을 옮겨 적은 것이고, 사용자가 이 파일에서 새로 승인한 것이 아니다 (human_verification 7번에서 확인 요청)"
    accepted_by: "사용자 (프로젝트 소유자). 04-CONTEXT.md D-18·D-20 추가 결정에 기록됨"
    accepted_at: "2026-11-18"
human_verification:
  - test: "스크래치 `$W/cap/c2/`의 `chromium-1280-step3.png`, `chromium-375-step3.png`, `webkit-1280-step3.png`, `webkit-375-step3.png`를 열어 본다 (단계 끝 UAT). 스크래치가 지워졌으면 라이브 https://runningpencil.com/ 「세 가지 이유」 3단계를 1280·375px에서 본다"
    expected: "뱃지 줄 일곱 개가 모두 컬러이고 회색 뱃지가 없다. 캡션이 「보관함 · 받은 뱃지 7」이다. 패널 스티커에 회색이 없고 색 배치가 어색하지 않다"
    why_human: "색 배치가 보기 좋은지는 grep이나 DOM 개수로 판정할 수 없다 (출처: 04-04-PLAN.md <human-check>)"
  - test: "스크래치 `$W/cap/c3/`의 `chromium-1280-screens.png`, `webkit-375-screens.png`, `webkit-375-end.png`, `chromium-1280-seam.png`를 열어 본다 (단계 끝 UAT). 스크래치가 지워졌으면 라이브 「실제 앱 화면」 구간을 1280·375px에서 본다. 주의: ③ 완주 결과는 사용자 예외(D-20)라 원본에서 이미 앱의 뱃지 창이 NAVER 로고를 덮고 있다. ③은 「테두리·둥근 모서리가 로고를 원본보다 더 깎지 않았는가」만 본다"
    expected: "제목 옆 「출시 준비 중」 딱지, 폰 테두리 속 캡처 세 장과 캡션, 오른쪽 아래 「지도 © NAVER Corp.」가 보인다. NAVER 로고가 깎이지 않았고, 375px에서는 다음 장이 조금 보이며, 구간 아래 둥근 모서리 사이로 노랑이 들어간다"
    why_human: "로고가 온전한지, 맞물림 모양이 자연스러운지는 이미지 내용과 디자인 판단이라 숫자로만 판정할 수 없다 (출처: 04-10-PLAN.md <human-check>)"
  - test: "실기기 iPhone Safari에서 https://runningpencil.com/ 의 「실제 앱 화면」 구간을 연다 (단계 끝 UAT). 주의: ③ 완주 결과의 NAVER 로고는 사용자 예외(D-20)라 원본에서 앱의 뱃지 창에 덮여 있다. ①·②만 로고가 온전해야 한다"
    expected: "제목 옆 「출시 준비 중」 딱지, 폰 테두리 속 캡처 세 장과 캡션, 「지도 © NAVER Corp.」가 보인다. 손가락으로 세 장을 가로로 밀 수 있고 페이지 전체는 옆으로 밀리지 않는다. 캡처 속 NAVER 로고가 온전하고, 개인 정보·하단 탭·Dev 표시가 보이지 않는다"
    why_human: "실기기 Safari의 터치 스크롤과 화면 속 내용은 Playwright 에뮬레이션으로 확인할 수 없다 (출처: 04-11-PLAN.md <human-check>)"
  - test: "VoiceOver(iOS·macOS) 같은 화면 낭독기로 「실제 앱 화면」 구간과 가로 띠를 읽는다"
    expected: "제목 「실제 앱 화면」, 띠 이름 「러닝펜슬 앱 화면 3장」, 목록 항목 3개, 각 이미지의 대체 글과 캡션을 차례로 읽는다. 띠에 키보드 포커스가 가고 → 키로 밀린다"
    why_human: "낭독 순서와 목록 의미 전달은 실제 보조 기술로만 확인할 수 있다 (출처: 04-13-SUMMARY.md 단계 끝 사람 확인)"
  - test: "(선택) 카카오톡·Slack 같은 공유 미리보기에 https://runningpencil.com/ 을 붙여 본다"
    expected: "미리보기 설명이 새 og:description 「GPS 아트 코스를 완주하고 코스 모양의 뱃지를 모으세요. 나만의 코스를 그려 올릴 수도 있어요.」이다. 옛 설명(포인트·굿즈·코스북)이 보이면 각 서비스의 캐시 갱신 도구로 다시 긁는다"
    why_human: "외부 서비스의 OG 캐시는 저장소와 라이브 HTML 밖에 있다 (출처: 04-13-SUMMARY.md A12)"
  - test: "04-EVIDENCE.md에 기록만 있고 다시 만들 수 없는 과정 사실 8건. 사용자가 직접 확인할 수 있는 것: (1) Playwright 1.59.1 설치를 checkpoint에서 승인함(04-02), (3) PUSH1 073d33e0e50a 승인(04-05), (4) PUSH2 6e46bdcb24e0 승인(04-08), (6) 캡처 세 장을 시험 계정·시험 경로로 찍어 넘김(04-09), (7) PUSH3 95062367dc69를 캡처·구간 화면을 보고 승인(04-11), (8) PUSH4 9cc14903adbd 승인(04-13). 에이전트가 한 일이라 사용자가 기억할 수 없는 것: (2) p4-behave 음성 대조 FAIL behave(04-02), (5) 합성 Display P3 파이프라인 시험(04-09). 이 둘은 기록을 받아들일지만 정한다"
    expected: "여섯 건은 기억과 대화 기록대로였다고 확인하고, 두 건은 EVIDENCE 기록을 받아들인다. git으로 볼 수 있는 부분(각 푸시 범위의 파일, 커밋 순서, 원격 main에 merge 커밋 0개, CAND3가 어떤 ref에도 없음)은 검증자가 이미 확인했다"
    why_human: "사람의 승인과 촬영 조건은 저장소와 라이브에 흔적이 남지 않는다 (출처: 검증자 판정 UNCERTAIN 8건)"
  - test: "frontmatter `overrides:`의 04-09 truth 3 항목(③ 로고 덮임과 상태 표시줄 차이를 사용자 예외로 통과)을 읽는다"
    expected: "04-CONTEXT D-18·D-20의 2026-11-18 결정과 같은 뜻이면 그대로 둔다. 아니면 항목을 지우고, 그 truth를 FAILED로 다시 판정받는다"
    why_human: "override는 검증자가 기록을 옮겨 적은 것이라, 사용자가 이 파일의 문구를 직접 확인해야 한다"
  - test: "아래 「금지 항목」 표의 비권위 판정 53건(judgment 등급, 모두 unverified-prohibition — human review recommended)을 훑는다"
    expected: "판정에 동의하거나, 동의하지 않는 항목을 gap으로 돌린다. 「확인 불가 (기록 근거)」 묶음은 6번 항목과 함께 정한다"
    why_human: "judgment 등급의 금지 항목은 자동 판정이 권위를 갖지 않는다 (ADR-550 D4)"
---

# Phase 4: 홈페이지 서비스 소개 정정 (Landing Content Fix) 검증 보고서

**Phase Goal:** 심사자가 홈페이지만 보고 출시 시점 앱이 실제로 하는 일을 정확히 알 수 있다. 앱에 없는 기능 설명이 사라지고, 실제 앱 화면과 출시 전임을 알리는 표시(현재 「출시 준비 중」)가 보인다
**Verified:** 2026-11-18T08:27:59Z
**Status:** human_needed
**Re-verification:** 아니요. 첫 검증입니다 (이전 VERIFICATION.md 없음)

## 결론

단계 목표는 코드와 라이브에서 이루어졌습니다. ROADMAP 성공 기준 세 개를 검증자가 직접 다시 돌렸고 모두 통과했습니다.

- 성공 기준 1: 운영과 같은 빌드(production·`--safe`)와 라이브 `/`에서 세 낱말이 0줄입니다.
- 성공 기준 2: 라이브에서 `p4-shots.mjs`를 Chromium·WebKit × 375·1280으로 돌려 `PASS shots`가 나왔습니다. 캡처한 화면도 직접 열어 보았습니다.
- 성공 기준 3: 라이브에서 `p4-behave.mjs`를 두 엔진으로 돌려 `PASS behave`가 나왔습니다. 콘솔 오류와 pageerror를 잡는 판정입니다.

자동 판정에서 실패한 must-have는 없습니다. 상태가 `passed`가 아닌 이유는 두 가지입니다.

- 단계 계획에 사람 확인 항목이 세 개 있습니다 (색 배치, 구간 화면, 실기기 Safari). 화면 낭독기 항목도 사람이 봐야 합니다.
- 과정 사실 8건(사람 승인 등)은 기록에만 근거가 있어 다시 확인할 수 없습니다.

캡처 검토 한 건(③ 완주 결과의 NAVER 로고가 앱의 뱃지 창에 덮임)은 원래 판정이 FAIL이었습니다. 사용자 예외 결정으로 PASSED (override)가 되었고, 남는 위험은 아래 「경고」에 적었습니다.

## Goal Achievement

### ROADMAP 성공 기준 (계약)

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| SC1 | 홈페이지 본문, `<meta name="description">`, OG 제목·설명 어디에도 「포인트」「굿즈」「코스북」이 없다 (빌드 결과 검색 0건) | ✓ VERIFIED | 검증자가 HEAD를 production·`--safe`로 빌드: `_site/index.html`에서 `grep -c -E '포인트\|굿즈\|코스북'` = 0. 라이브 `/`(`?cb=` 우회)도 0이고 로컬 빌드와 `cmp` 바이트가 같음. 원본 `index.html`도 0줄. meta description·og:description은 새 문장이고 title·og:title은 그대로임. 보이는 글을 모두 뽑아 읽었고 출시 범위 밖 기능(랭킹·명예의 전당·리뷰·결제 등) 설명이 없음 |
| SC2 | 실제 앱 화면 스크린샷과 출시 전 표시(「출시 준비 중」)가 함께 보이고(375·1280px), 스크린샷에 출시 범위 밖 기능이 없다 | ✓ VERIFIED | `index.html` 411~431행 `#screens`: 제목 「실제 앱 화면」과 「출시 준비 중」 딱지, `/images/app/screen-{draw,run,badge}-{564,846}.webp` 세 장, 캡션, 「지도 © NAVER Corp.」. 검증자가 라이브에서 `p4-shots.mjs`를 돌린 결과: `PASS shots`(chromium·webkit × 1280·375, imgs=3, credit-gap 38.4/28, end-gap=20). 캡처한 화면 `webkit-1280-screens.png`·`webkit-375-screens.png`를 직접 열어 보았음: 딱지·세 장·캡션·출처가 보이고, 캡처 속에 포인트·굿즈·코스북·하단 탭·Dev 표시가 없음. ③의 로고 덮임은 사용자 예외(override) |
| SC3 | 기존 동작(고정되는 세 가지 이유, 7초 달려 보기, 움직임 줄이기 대응)이 그대로 동작하고 콘솔 오류가 없다 | ✓ VERIFIED | 검증자가 라이브에서 `p4-behave.mjs`를 돌린 결과: chromium·webkit × (1280, 375, 1280 reduce) 6개 문맥 모두 OK, `PASS behave`. 판정 내용: 0.5·0.85 지점의 패널 `is-s1`·`is-s2`와 stage 고정, 3.5초 지점 20~80%, 7.7초에 `100 %`·「다시 달리기」·완료 표시, reduce에서 `rp-pin` 없음·`aria-pressed`·히어로 `animationsPaused`, `console` error와 `pageerror` 0, `scrollWidth <= innerWidth`. 인라인 `<script>` 블록은 BASE_SHA와 HEAD가 글자까지 같음 |

### PLAN must-have truths

| # | Plan | Truth (요약) | Status | Evidence |
|---|------|--------------|--------|----------|
| 1 | 04-01 | ROADMAP Goal·SC2와 REQUIREMENTS SITE-06이 「출시 전임을 알리는 표시(현재 「출시 준비 중」)」로 적힘 | ✓ VERIFIED | `roadmap.get-phase 4`와 REQUIREMENTS 34행 문구 확인 |
| 2 | 04-01 | Phase 9 SC2의 출시 표시 문구는 그대로 | ✓ VERIFIED | ROADMAP Phase 9 SC2가 원래 문구 「출시 예정 표시」를 유지 |
| 3 | 04-01 | `roadmap validate` 경고 없음 | ✓ VERIFIED | 검증자 실행 `{"warnings": []}` |
| 4 | 04-01 | USER-TASKS 작업 10이 D-16~D-20 조건을 안내 | ✓ VERIFIED | 작업 10에 iPhone 한 기기, ①②③ 세 장, 하단 탭 없음, NAVER 로고 유지, 검색 결과 목록 없음, 포인트·굿즈·코스북·Dev·개인 정보 없음이 있음. 「둘러보기」 예시 없음 |
| 5 | 04-01 | 첫 문서 커밋 하나에 세 파일만 | ✓ VERIFIED | `760d0e9`가 ROADMAP·REQUIREMENTS·USER-TASKS 3파일만 담음 |
| 6 | 04-02 | BASE_SHA와 BASE_LIVE의 `.planning/` 밖 트리가 같음 | ✓ VERIFIED | `git diff --name-only 0e75e8b88fd2 0bfe5b210c3c -- . ':!.planning'` 0줄 |
| 7 | 04-02 | 기준 빌드에서 4 URL 200·기대 제목 | ✓ VERIFIED | 검증자가 BASE 커밋을 빌드했고 `check-site.sh 0e75e8b88fd2`의 제목 항목은 통과(실패는 6번 항목 하나뿐) |
| 8 | 04-02 | 기준 낱말 수 index 2, 처리방침 6, 약관 6, 삭제 안내 3 | ✓ VERIFIED | `check-site.sh 0e75e8b88fd2` → 「/index.html 2줄」. HEAD 빌드의 법적 3종이 6/6/3이고 BASE와 바이트가 같음 |
| 9 | 04-02 | Playwright를 승인 뒤에만 pnpm으로 스크래치에 설치 | ? UNCERTAIN | 스크래치에 `pnpm-lock.yaml`·Playwright 1.59.1이 있고 저장소에는 없음. 승인 순서는 04-EVIDENCE 기록에만 근거 → 사람 확인 |
| 10 | 04-02 | 기준 출력에서 p4-behave 두 엔진 PASS | ✓ VERIFIED | 기록(BEHAVE_BASE=OK). 같은 판정을 지금 라이브(기준 위에 문구·뱃지·구간만 더함)에서 다시 돌려 PASS |
| 11 | 04-02 | 계약을 깬 사본에 FAIL behave·pageerror (음성 대조) | ? UNCERTAIN | 기록(BEHAVE_NEG=OK)에만 근거. 스크립트에 `pageerror`·`console` error 수집과 `FAIL behave` 경로가 있는 것은 직접 확인 |
| 12 | 04-03 | 문구 커밋 뒤 `_site/index.html`에 세 낱말 0줄 | ✓ VERIFIED | `check-site.sh abdeb52284d6` 통과(6번 항목 포함) |
| 13 | 04-03 | meta description·og:description이 지정 문장이고 title·og:title은 그대로 | ✓ VERIFIED | `index.html` 11~18행 |
| 14 | 04-03 | 3단계 글·캡션 「보관함 · 받은 뱃지 7」, 실루엣·「채울 뱃지」 없음 | ✓ VERIFIED | 245·256행. grep 0건 |
| 15 | 04-03 | 출력 diff가 `10c10 15c15 278c278 289c289`뿐이고 법적 3종은 같음 | ✓ VERIFIED | BASE와 C1을 다시 빌드해 diff, 행 머리가 정확히 같음. 법적 3종은 BASE→HEAD 바이트 같음 |
| 16 | 04-03 | 문구 후보에서 p4-behave PASS | ✓ VERIFIED | 기록(C1_OK). 이 변경을 포함한 라이브에서 검증자 실행도 PASS |
| 17 | 04-03 | 문구 커밋은 `index.html` 4/4줄만 | ✓ VERIFIED | `abdeb52` numstat `4 4 index.html` |
| 18 | 04-04 | 뱃지 줄 7개 모두 받은 색, 뒤 셋 graphite·yellow·red, 이웃끼리 다른 색 | ✓ VERIFIED | 248~254행: yellow·red·kraft·graph·graphite·yellow·red |
| 19 | 04-04 | 스티커 6개 모두 받은 색, 4번째 yellow·6번째 red, 1~4 서로 다른 색 | ✓ VERIFIED | 268~273행: red·kraft·graph·yellow·graphite·red |
| 20 | 04-04 | `.rp-badge.t-empty`와 회색 hex 0줄, 새 hex 없음 | ✓ VERIFIED | `t-empty`·`#EEEEEE`·`#DCDCDC`·`#BDBDBD` grep 0. BASE→HEAD로 더한 줄에 BASE에 없던 hex 0개 |
| 21 | 04-04 | 출력 diff 머리 `82d81 285,287c284,286 304c303 306c305`, 법적 3종 같음 | ✓ VERIFIED | C1→C2 다시 빌드해 diff, 정확히 같음 |
| 22 | 04-04 | p4-behave PASS, `badges=7 stickers=6 empty=0` | ✓ VERIFIED | 검증자의 라이브 실행에서 6개 문맥 모두 그 값 |
| 23 | 04-04 | 빈 뱃지 커밋은 `index.html` +5/−6이고 같은 푸시로 나감 | ✓ VERIFIED | `f8d66a6` numstat `5 6`. `0bfe5b2..073d33e` 범위에 abdeb52·f8d66a6 둘 |
| 24 | 04-05 | 첫 푸시는 승인 뒤, 범위의 사이트 파일은 `index.html` 하나이고 커밋은 C1·C2 둘 | ? UNCERTAIN | 범위·커밋은 git으로 확인(✓). 승인 사실은 기록에만 근거 → 사람 확인 |
| 25 | 04-05 | 후보가 pre-push 경로를 통과했고 사이트 트리가 C2와 같음 | ✓ VERIFIED | `check-site.sh 073d33e0e50a` 통과. C2와 사이트 트리 diff 0. 훅 12행이 check-site를 부르고 `core.hooksPath=.githooks` |
| 26 | 04-05 | 배포 뒤 4 URL 200·기대 제목 | ✓ VERIFIED | 당시 기록 LIVE_PUSH1=OK. 지금 라이브에서도 4 URL 200·기대 제목 |
| 27 | 04-05 | 라이브 `/`가 C2 빌드와 바이트 같음, 세 낱말 0 | ✓ VERIFIED | 당시는 기록. 지금 라이브 `/`는 HEAD 빌드와 바이트가 같고 세 낱말 0 |
| 28 | 04-05 | 라이브 p4-behave PASS | ✓ VERIFIED | 검증자 라이브 실행 PASS |
| 29 | 04-05 | 이 푸시에 구간·6번 항목·D-23 문서가 없음 | ✓ VERIFIED | `0bfe5b2..073d33e`의 `.planning/` 밖 변경은 `index.html` 하나 |
| 30 | 04-06 | check-site 6번 항목이 랜딩 출력만 검색 | ✓ VERIFIED | `scripts/check-site.sh`의 `u10=$(grep -c ... "$DEST/index.html")` |
| 31 | 04-06 | 점검 커밋과 문구 커밋은 통과, 기준은 「/index.html 2줄」로 실패 | ✓ VERIFIED | 검증자 실행: BASE 실패 메시지가 정확히 같음, abdeb52 통과, HEAD 통과 |
| 32 | 04-06 | 점검 커밋은 check-site 하나만 담고 출력이 같으며 pre-push는 그대로 | ✓ VERIFIED | `a02573f` numstat `8 1`. C2와 a02573f 빌드를 `diff -r` 했고 같음. `.githooks`는 BASE→HEAD 변경 0 |
| 33 | 04-06 | 점검 커밋이 첫 푸시 뒤에 만들어짐 | ✓ VERIFIED | `073d33e`가 `a02573f`의 조상 |
| 34 | 04-06 | 원본 맵 4개가 점검 항목을 여섯으로 적음 | ✓ VERIFIED | CONVENTIONS 50행 「점검 항목은 여섯이다」. TESTING·ARCHITECTURE·STACK도 여섯 항목을 나열 |
| 35 | 04-07 | 두 CLAUDE.md의 D-23 행이 갱신되고 방침 구간이 글자까지 같음 | ✓ VERIFIED | 두 파일에 해당 문구 각 1줄. 방침 구간을 추출해 비교했고 같음 |
| 36 | 04-07 | 갱신이 LIVE_PUSH1 뒤 | ✓ VERIFIED | `073d33e`가 `4b9288d`의 조상 |
| 37 | 04-07 | Deploy 문단에 「랜딩 출력에 포인트·굿즈·코스북이 없음」 | ✓ VERIFIED | 루트 CLAUDE.md Deploy 문단 |
| 38 | 04-07 | `.claude/CLAUDE.md` 생성 구간이 재생성 결과와 바이트 같음 | ✓ VERIFIED | 스크래치 사본(`git archive HEAD`)에서 `generate-claude-md`를 돌린 결과와 `cmp` 같음. 작업 트리는 건드리지 않음 |
| 39 | 04-07 | README·STRUCTURE 점검 주석에 6번 항목이 있고 옛 나열·로컬 경로 없음 | ✓ VERIFIED | README 10행, STRUCTURE 33행에 「랜딩 기능 이름」. 옛 문장 grep 0 |
| 40 | 04-08 | 문서 푸시는 승인 뒤, `.planning/` 밖 파일 넷 | ? UNCERTAIN | 범위 파일 넷(`.claude/CLAUDE.md`·`CLAUDE.md`·`README.md`·`scripts/check-site.sh`)은 git으로 확인. 승인은 기록에만 근거 |
| 41 | 04-08 | 문서 커밋이 모두 PUSH1 뒤 | ✓ VERIFIED | 조상 관계 확인 |
| 42 | 04-08 | 문서 푸시가 출력을 바꾸지 않음 | ✓ VERIFIED | C2와 6e46bdc 빌드를 `diff -r` 했고 같음 |
| 43 | 04-08 | 4 URL 200, `/CLAUDE.md`·`/README.md`·`/scripts/check-site.sh` 404 | ✓ VERIFIED | 검증자 라이브 확인 |
| 44 | 04-09 | 합성 P3 이미지로 파이프라인을 미리 시험 (스크래치만) | ? UNCERTAIN | 기록(PIPE_TRACE=OK)에만 근거. 최종 산출물이 메타데이터 없는 WebP이고 두 엔진에서 그려지는 것은 직접 확인 |
| 45 | 04-09 | 사용자가 작업 10대로 찍은 세 장을 넘기고 시험 계정·경로라고 확인 | ? UNCERTAIN | 기록(CAPTURES_RECEIVED=3)에만 근거 |
| 46 | 04-09 | 세 장의 항목별 검토가 모두 OK (로고 온전 포함) | PASSED (override) | ORIG_REVIEW FAIL 3건(badge logo, run·badge status)이 사용자 예외로 OK가 됨. 근거 04-CONTEXT D-18·D-20 추가 결정. 검증자가 본 1280 화면에서도 ③의 로고가 뱃지 창에 덮여 있음. 우리 테두리가 더 깎지는 않음 |
| 47 | 04-09 | WebP 6개가 sRGB·메타데이터 없음·크기 상한 안·sha256 기록 | ✓ VERIFIED | 저장소 6파일 sha256이 EVIDENCE `IMG` 줄과 모두 같음. `webpinfo`에서 EXIF·XMP·ICCP 0. 564w 최대 81,804B(≤100KB), 846w 최대 143,790B(≤180KB) |
| 48 | 04-09 | 캡처 원본과 경로가 저장소·기록에 없음 | ✓ VERIFIED | `git ls-files '*.png'`가 `favicon/` 밖 0. 단계 문서에 실제 로컬 절대 경로 0 |
| 49 | 04-10 | `#demo`와 `#get` 사이 `#screens`, 딱지·세 장·캡션, 주의 문구·출시 시기 없음 | ✓ VERIFIED | 373·411·436행 순서. 날짜·「달라질 수 있어요」 문구 grep 0 |
| 50 | 04-10 | 폰 테두리 `#1F1B13`·46px·9px·그림자, `.rp-phone`을 다시 쓰지 않음 | ✓ VERIFIED | 97행 `.rp-shot-frame` |
| 51 | 04-10 | 1280에서 한 줄, 375에서 scroll-snap 띠·Tab/→·끝 여백·가로 밀림 없음, 스크립트 없음 | ✓ VERIFIED | 94·115·116행. 라이브 `OK strip ... arrow=0->276 end-gap=20` 두 엔진. 인라인 스크립트는 BASE와 같음 |
| 52 | 04-10 | 구간 아래 「지도 © NAVER Corp.」가 `#get`에 가리지 않음, `z-index: 1`·둥근 모서리, 제휴 오인 문구 없음 | ✓ VERIFIED | 93·100·431행. 라이브 credit-gap 38.4/28. 「제휴·공식·네이버와 함께」 grep 0 |
| 53 | 04-10 | 같은 도메인 이미지, srcset·sizes·width/height·lazy·async·alt, sha256 같음 | ✓ VERIFIED | 419·423·427행. 라이브 6파일 200 `image/webp`, 해시 같음 |
| 54 | 04-10 | CAND3는 index.html과 WebP 6개만 바꾸고, 지운 줄은 `.rp-get` 주석 하나, 스크립트·헤더·법적 3종 그대로 | ✓ VERIFIED | `git diff 273022c..56fd3bb` 결과: 38+/1−, 지운 줄은 주석 한 줄. `_includes`·`_layouts`·법적 3종 변경 0 |
| 55 | 04-10 | 후보에서 p4-shots·p4-behave 통과 | ✓ VERIFIED | 기록(SHOTS_OK). 사이트 트리가 같은 C3 라이브에서 검증자 실행도 PASS |
| 56 | 04-10 | CAND3가 어떤 ref에도 없음 | ✓ VERIFIED | `git cat-file -t 56fd3bb79160` = commit, `git for-each-ref --contains` 빈 출력 |
| 57 | 04-11 | C3는 그때 HEAD를 부모로 하고 사이트 트리가 CAND3와 같으며, 사이트 파일은 index.html과 WebP 6개 | ✓ VERIFIED | `9506236` parent `61bd06a`. CAND3와 사이트 트리 diff 0. 범위 파일 7개 |
| 58 | 04-11 | 승인 전에는 ref에 없었고, 푸시 성공 뒤 로컬 main에 들임, 이력 수정 없음 | ? UNCERTAIN | 지금 main 이력이 선형이고 `6e46bdc`→`9506236` 조상 관계가 맞음. 승인 시점은 기록에만 근거 |
| 59 | 04-11 | 배포 뒤 4 URL 200, 라이브 `/`가 C3 빌드와 바이트 같음 | ✓ VERIFIED | C3와 HEAD 빌드 출력이 같고, 라이브 `/`가 HEAD 빌드와 바이트 같음 |
| 60 | 04-11 | 라이브 WebP 6개 200·`image/webp`·바이트 같음 | ✓ VERIFIED | 검증자 curl 결과 |
| 61 | 04-11 | 라이브 p4-shots PASS | ✓ VERIFIED | 검증자 실행 |
| 62 | 04-11 | 라이브 p4-behave PASS | ✓ VERIFIED | 검증자 실행 |
| 63 | 04-12 | CONVENTIONS·ARCHITECTURE·STACK이 구간·WebP 예외·도구를 적음 | ✓ VERIFIED | `images/app/` 각 2·3·1회, STACK에 `sips`·`cwebp`·`webpinfo` |
| 64 | 04-12 | STRUCTURE에 `images/app/`, INTEGRATIONS에 NAVER 지도 출처(구간 아래, 공유 푸터 아님) | ✓ VERIFIED | INTEGRATIONS 18행 |
| 65 | 04-12 | 루트 CLAUDE.md Pages 표·SVG 예외·지도 출처·Assets `images/app/` | ✓ VERIFIED | 루트 CLAUDE.md 해당 문단 |
| 66 | 04-12 | `.claude/CLAUDE.md` 재생성과 바이트 같음, 방침 구간 같음 | ✓ VERIFIED | #38과 같은 방법으로 확인 |
| 67 | 04-12 | 옛 문장(외부 이미지 없음·SVG뿐·실제 지도를 쓰게 되면) 없음 | ✓ VERIFIED | 문서 전체 grep 0 |
| 68 | 04-13 | D-24 문서 푸시는 승인 뒤, 범위 파일 둘, PUSH3 뒤 | ? UNCERTAIN | 범위 파일(두 CLAUDE.md)과 조상 관계는 git으로 확인. 승인은 기록에만 근거 |
| 69 | 04-13 | 문서 푸시가 출력을 바꾸지 않음 | ✓ VERIFIED | C3와 9cc1490 빌드를 `diff -r` 했고 같음 |
| 70 | 04-13 | 4 URL 200·기대 제목, `/CLAUDE.md` 404 | ✓ VERIFIED | 검증자 라이브 확인 |
| 71 | 04-13 | 단계 끝 판정표 SC1~SC3이 라이브 재확인으로 OK | ✓ VERIFIED | EVIDENCE 963~1003행 표. 검증자가 같은 판정을 라이브에서 다시 돌려 출력이 같음 |

**Score:** 66/74 truths verified (ROADMAP 3개 + PLAN 71개. VERIFIED 65 + PASSED (override) 1. UNCERTAIN 8. FAILED 0. 동작 미검증(present, behavior-unverified) 0)

동작에 달린 truth(SC3 고정·7초 데모·움직임 줄이기, 띠의 키보드 밀기)는 모두 검증자가 라이브에서 직접 돌린 판정 스크립트로 확인했습니다. 그래서 `behavior_unverified`는 0입니다.

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `index.html` | 정정된 메타·OG·3단계 글, 컬러 뱃지, `#screens` 구간과 CSS | ✓ VERIFIED | 원본에 있고, 빌드에 반영되며 라이브와 바이트가 같음 |
| `images/app/screen-{draw,run,badge}-{564,846}.webp` | 앱 화면 캡처 WebP 6개 | ✓ VERIFIED | git이 추적함. `_site/images/app/`에 복사되고 라이브에서 200·`image/webp`. `srcset`에 연결됨 |
| `scripts/check-site.sh` | 6번 항목 | ✓ VERIFIED | 음성 대조 실패, 양성 통과. pre-push 훅이 부름 |
| `CLAUDE.md`, `.claude/CLAUDE.md` | D-23 행, D-24 문서 | ✓ VERIFIED | 방침 구간이 같고, 생성 구간이 재생성 결과와 같음 |
| `.planning/baseline/USER-TASKS.md` | 작업 10 | ✓ VERIFIED | `## 작업 10 — 앱 화면 캡처`에 D-16~D-20 조건 |
| `04-EVIDENCE.md` | 판정 기록과 표식 | ✓ VERIFIED | `verify.artifacts` 13개 계획 모두 통과(exit 0) |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `index.html` `srcset` | `images/app/*.webp` | 같은 도메인 경로 | ✓ WIRED | 라이브 200·해시 같음 |
| `.rp-shots-sec` `z-index: 1`·둥근 모서리 | `.rp-get` 음수 `margin-top` | CSS 맞물림 | ✓ WIRED | 93·103행. 라이브 credit-gap 양수 |
| `.githooks/pre-push` | `scripts/check-site.sh` | 훅 12행 | ✓ WIRED | `core.hooksPath=.githooks` |
| `.planning/codebase/CONVENTIONS.md` | `.claude/CLAUDE.md` | generate-claude-md | ✓ WIRED | 재생성 결과와 바이트 같음 |
| `04-EVIDENCE.md` | `index.html` / ROADMAP (04-02·04-09·04-10·04-13) | `^BASE_SHA=`·`^IMG ... 846`·`^CAND3=`·`^SC[123] OK` | ✓ WIRED (수동) | `verify.key-links`는 이 네 개를 exit 1로 냈음. 줄머리 앵커(`^`)를 여러 줄 모드 없이 대조해서 생긴 도구 거짓 음성임. `grep -n`으로 25·515~585·615·968~970행에 줄머리부터 있는 것을 확인 |

### Data-Flow Trace (Level 4)

해당 없음. 정적 사이트이고, 새 구간의 데이터는 정적 WebP와 마크업 글입니다. 이미지가 실제로 불러와지는지는 라이브 `p4-shots`의 `imgs=3 src=564,564,564`와 HTTP 200으로 확인했습니다.

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| 푸시 전 점검 (HEAD) | `scripts/check-site.sh` | `통과 (작업 트리, jekyll 3.10.0)` | ✓ PASS |
| 6번 항목 음성 대조 | `scripts/check-site.sh 0e75e8b88fd2` | `/index.html 2줄` 실패, exit 1 | ✓ PASS |
| 빌드 출력 세 낱말 | production `--safe` 빌드 후 `grep -c` | index 0, 법적 6/6/3 (Phase 6~8 범위) | ✓ PASS |
| 라이브 = 로컬 | `curl` + `cmp` | `/` 바이트 같음, 4 URL 200·기대 제목, 내부 파일 3개 404 | ✓ PASS |
| 라이브 동작 (SC3) | `node p4-behave.mjs https://runningpencil.com ?cb=…` | `PASS behave` (6 문맥) | ✓ PASS |
| 라이브 구간 (SC2) | `node p4-shots.mjs https://runningpencil.com <cap> ?cb=…` | `PASS shots` (두 엔진 × 375·1280) | ✓ PASS |
| 커밋별 출력 diff | 7개 커밋을 `git archive`로 꺼내 빌드하고 `diff` | 04-03·04-04 diff 머리가 기록과 같음. 문서 푸시 3회는 출력 같음 | ✓ PASS |

판정 스크립트(`p4-behave.mjs`·`p4-shots.mjs`)는 실행 때 만든 스크래치 도구이고 저장소에는 없습니다. 검증자가 내용을 읽었습니다. 콘솔 오류·pageerror 수집과 상태·좌표 단언이 있는 실제 판정이라 이 결과를 근거로 썼습니다.

### Probe Execution

해당 없음. 저장소에 `scripts/*/tests/probe-*.sh`가 없고, 계획에서 정한 probe도 없습니다.

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| SITE-01 | 04-02~08, 04-13 | 소개 문구·메타 설명·OG에서 출시 앱에 없는 기능(포인트·굿즈·코스북)이 보이지 않음 | ✓ SATISFIED | SC1. check-site 6번 항목이 다시 들어오는 것을 막음 |
| SITE-06 | 04-01, 04-02, 04-09~13 | 실제 앱 화면(스크린샷)과 출시 전 표시(현재 「출시 준비 중」) | ✓ SATISFIED (사람 확인 남음) | SC2. 실기기·화면 낭독기·디자인 판단은 human_verification |

REQUIREMENTS.md에서 Phase 4에 걸린 ID는 SITE-01·SITE-06 둘뿐이고, 둘 다 계획 frontmatter에 있습니다. 계획에 빠진(ORPHANED) 요구 사항은 없습니다.

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `scripts/check-site.sh` | 42 | `XXX` (`mktemp ... rp-check.XXXXXX`) | ℹ️ Info | 부채 표시 주석이 아니고 mktemp 템플릿임. Phase 1 커밋 `7f13a62` 때부터 있던 줄 |
| `index.html` | — | TODO·FIXME·placeholder·「추후 기재」 | — | 0건 |
| `.planning/codebase/ARCHITECTURE.md`·`CONVENTIONS.md`·`CONCERNS.md`·`TESTING.md` | 여러 줄 | `index.html:NNN` 행 번호와 줄 수가 구간 추가 전 값 (REVIEW WR-01, `deferred-items.md` 4건 open) | ⚠️ Warning | 문서 드리프트. 사이트 동작에는 영향 없음. 다음 원본 맵 갱신에서 고침 |

### 경고 (WARNING)

1. **③ 캡처의 NAVER 로고 덮임 (사용자 예외).**
   - 공개 웹페이지에 실은 ③ 완주 결과 캡처에서 앱의 뱃지 창이 NAVER 로고를 덮고 있습니다.
   - NAVER 지도 SDK 가이드는 「로고가 앱의 UI 요소에 가려지지 않도록」 하라고 요구합니다.
   - 사용자는 이 위험을 알고 받아들였습니다 (04-CONTEXT D-20 추가 결정). 우리 쪽에서 더 자르거나 덮지는 않았습니다.
   - 후속 조치: 앱에서 로고 위치나 뱃지 창 위치를 고치면 ③만 다시 찍어 바꿉니다. 이 결정은 검증자가 다시 승인할 수 없으므로 override 항목에 출처와 함께 옮겨 적었습니다.
2. **문서 행 번호 드리프트 (WR-01, deferred-items 4건).** 위 Anti-Patterns 표를 참고하세요.
3. **`verify.key-links` 도구 거짓 음성 4건.** 줄머리 앵커 패턴을 쓴 링크에서 생깁니다. 수동으로 확인했고 모두 연결돼 있습니다.

### 금지 항목 (prohibitions, judgment 등급, 비권위 판정)

13개 계획에 금지 항목이 53개 있고, 모두 `verification: judgment`입니다. 아래는 검증자(LLM)가 내린 **비권위 판정**입니다. 단계 끝에서 사람이 검토하기를 권합니다 (`unverified-prohibition — human review recommended`).

| 묶음 | 판정 | 근거 |
|------|------|------|
| 사이트 파일 범위 (04-01·04-02의 사이트 미수정, 04-03의 title·og:title·1·2단계 글·히어로·include·법적 3종 미수정, 04-10의 헤더 메뉴·공유 푸터 미수정) | 지켜짐 | `_includes`·`_layouts`·법적 3종·`.githooks` BASE→HEAD 변경 0. title·og:title 같음 |
| 스크립트 계약 (04-10 스크립트 추가·계약 이름 변경 금지) | 지켜짐 | 인라인 `<script>` 블록이 BASE와 같음. 구간 이름은 스크립트에 없음 |
| 색 (04-04·04-10 새 hex·새 뱃지 클래스·다크 모드 금지) | 지켜짐 | 새 hex 0. 뱃지 클래스는 기존 5개 안. `prefers-color-scheme` 없음 |
| 문구 (04-03 새 홍보 문장·출시 시기, 04-10 주의 문구·제휴 오인 문구) | 지켜짐 | 날짜·주의 문구·「제휴·공식·네이버와 함께」 grep 0. 바뀐 문장은 기능 설명을 고친 것뿐 |
| 커밋 나누기 (D-22: 문구·뱃지·점검·문서·구간 커밋 분리, 문구+뱃지는 같은 푸시) | 지켜짐 | 커밋별 numstat과 푸시 범위 4개를 git으로 확인 |
| 이력 수정·force·`--no-verify` 금지 | 지켜졌다고 봄 | `git rev-list --merges --count 0bfe5b2..origin/main` = 0. 로컬 `origin/main` reflog에 forced 갱신 0. 각 푸시 SHA가 다음 푸시의 조상이고, 지금 check-site를 통과. `--no-verify`를 쓰지 않았다는 것 자체는 기록 근거 |
| 승인 전 푸시 금지, 승인 전 설치 금지 | 확인 불가 (기록 근거) | human_verification 6번 항목 |
| 캡처 원본·경로·사용자 사실값 비공개 (04-09·04-12) | 지켜짐 | `favicon/` 밖 PNG 0. 단계 문서에 실제 로컬 절대 경로 0. 사이트 HTML에 이메일·사업자 값 없음 |
| 캡처 조건 (하단 탭·Dev·검색 목록·개인 정보·로고 자르기 금지, 한 장만 자르기 금지) | 지켜짐, 로고만 사용자 예외 | 검증자가 1280·375 화면을 직접 봄. 로고는 override |
| `.claude/CLAUDE.md` 생성 구간 손 편집 금지, `PROJECT.md` 미수정, 04-12의 방침 표 미수정 (04-07·04-12) | 지켜짐 | 생성 구간은 스크래치 재생성 결과와 바이트 같음. `git log 760d0e9^..HEAD -- .planning/PROJECT.md` 0건. `426174d`의 CLAUDE.md 변경은 Pages 표·본문이고 방침 표 행은 그대로 |
| bash 4 전용 문법 금지 (04-06) | 지켜짐 | `scripts/check-site.sh`에서 `mapfile`·`readarray`·`declare -A`는 11행 주석 「쓰지 않는다」에만 있음 |

### Human Verification Required

#### 1. 3단계 뱃지 색 배치 (04-04)
**Test:** 라이브 「세 가지 이유」 3단계를 1280·375px에서 본다 (스크래치 `$W/cap/c2/*-step3.png`가 남아 있으면 그것도 된다)
**Expected:** 뱃지 줄 일곱 개가 모두 컬러이고 회색 뱃지가 없다. 캡션이 「보관함 · 받은 뱃지 7」이다. 패널 스티커에 회색이 없고 색 배치가 어색하지 않다
**Why human:** 색 배치가 보기 좋은지는 grep이나 DOM 개수로 판정할 수 없다

#### 2. 「실제 앱 화면」 구간 화면 (04-10)
**Test:** 라이브 구간을 1280·375px에서 본다 (스크래치 `$W/cap/c3/`의 캡처도 된다). ③ 완주 결과는 사용자 예외(D-20)라 원본에서 이미 앱의 뱃지 창이 로고를 덮고 있으므로, 「원본보다 더 깎이지 않았는가」만 본다
**Expected:** 딱지·세 장·캡션·「지도 © NAVER Corp.」가 보인다. NAVER 로고가 깎이지 않았다(③은 원본보다 더 깎이지 않았다). 375px에서는 다음 장이 조금 보인다. 구간 아래 둥근 모서리 사이로 노랑이 들어간다
**Why human:** 로고가 온전한지와 맞물림 모양은 디자인 판단이다

#### 3. 실기기 iPhone Safari (04-11)
**Test:** 실기기 Safari에서 구간을 열고 손가락으로 띠를 민다. ③의 로고 덮임은 사용자 예외(D-20)이고 ①·②만 로고가 온전해야 한다
**Expected:** 세 장이 가로로 밀리고 페이지는 옆으로 밀리지 않는다. 로고가 온전하고 개인 정보·하단 탭·Dev 표시가 없다
**Why human:** 터치 스크롤은 에뮬레이션으로 확인할 수 없다

#### 4. 화면 낭독기
**Test:** VoiceOver로 구간과 띠를 읽는다
**Expected:** 제목, 띠 이름, 항목 3개, 대체 글, 캡션을 차례로 읽는다
**Why human:** 보조 기술에서 어떻게 읽히는지는 직접 들어 봐야 한다

#### 5. (선택) 옛 OG 캐시
**Test:** 공유 미리보기에 홈 URL을 붙여 본다
**Expected:** 새 og:description이 보인다
**Why human:** 외부 서비스의 캐시는 저장소 밖에 있다

#### 6. 기록에만 근거한 과정 사실 8건
**Test:** 사용자가 직접 겪은 여섯 건(Playwright 설치 승인, PUSH1~4 승인, 캡처를 시험 계정·경로로 찍음)을 확인한다. 에이전트가 한 두 건(p4-behave 음성 대조, 합성 파이프라인 시험)은 EVIDENCE 기록을 받아들일지만 정한다
**Expected:** 여섯 건은 기록대로였고, 두 건은 기록을 받아들인다
**Why human:** 사람의 승인과 촬영 조건은 저장소에 흔적이 남지 않는다

#### 7. override 문구 확인
**Test:** frontmatter `overrides:`의 04-09 truth 3 항목을 읽는다
**Expected:** 04-CONTEXT D-18·D-20의 2026-11-18 결정과 뜻이 같으면 그대로 둔다. 아니면 지우고, 그 truth를 FAILED로 다시 판정받는다
**Why human:** 검증자가 기록을 옮겨 적은 override라서 사용자가 문구를 직접 확인해야 한다

#### 8. 금지 항목 53건의 비권위 판정
**Test:** 위 「금지 항목」 표를 훑는다
**Expected:** 판정에 동의하거나, 동의하지 않는 항목을 gap으로 돌린다
**Why human:** judgment 등급의 금지 항목은 자동 판정이 권위를 갖지 않는다

### Gaps Summary

막는 공백(BLOCKER)은 없습니다.

- ROADMAP 성공 기준 1~3은 검증자가 운영과 같은 로컬 빌드와 라이브에서 직접 다시 돌려 모두 통과했습니다.
- 요구 사항 SITE-01·SITE-06은 충족했습니다.
- 사이트 커밋 4개는 각자 의도한 파일과 줄만 바꿨습니다. 문서 푸시 3회는 사이트 출력을 바꾸지 않았습니다.
- 법적 3종의 출력은 단계 시작부터 바이트가 같습니다. 법적 문서에 남은 세 낱말은 Phase 6~8 범위입니다.

남은 일은 사람 확인 8건(디자인·실기기·낭독기·OG 캐시·기록 확인·override 문구·금지 항목 53건 검토)뿐입니다. ③ 캡처의 NAVER 로고 덮임은 사용자가 받아들인 위험으로 경고에 적어 둡니다.

---

_Verified: 2026-11-18T08:27:59Z_
_Verifier: Claude (gsd-verifier)_
