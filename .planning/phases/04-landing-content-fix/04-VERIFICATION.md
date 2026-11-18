---
phase: 04-landing-content-fix
verified: 2026-11-18T13:32:19Z
status: human_needed
score: 74/74 must-haves verified
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
  - ".planning/phases/04-landing-content-fix/04-REVIEW-DISPOSITION.md"
  - ".planning/phases/04-landing-content-fix/04-REVIEW.md"
  - ".planning/phases/04-landing-content-fix/04-UAT.md"
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
covered_digest: "v4:sha256:1973a52663061a2c6caddae66fe317055fc41d89322321a26ff717fd23e4e73b"
behavior_unverified: 0
overrides_applied: 1
overrides:
  - must_have: "Claude가 세 장을 직접 열어 항목별로 검토해 모두 OK다: 하단 탭 없음, Dev 표시 없음, 개인 정보 없음, 지도가 보이는 장의 NAVER 로고가 잘리거나 가려지지 않음 (04-09 truth 3)"
    reason: "③ 완주 결과 캡처는 앱의 뱃지 창이 NAVER 로고 오른쪽을 덮은 원본 장면이고(ORIG_REVIEW badge logo FAIL), run·badge의 상태 표시줄 차이 두 건도 원래 판정이 FAIL이었다. 사용자가 NAVER 지도 SDK 가이드 문장과 위험을 들은 뒤 세 건을 사용자 예외로 허용했다. 로고 조건은 「우리가 원본보다 더 자르거나 덮지 않는다」로 바뀌었다. 근거는 04-CONTEXT.md D-18·D-20의 「캡처 검토 뒤 사용자 결정 (2026-11-18, 04-09 Task 3)」과 04-EVIDENCE.md의 CAPTURE_WAIVERS=3이다. 이 override 항목은 검증자가 그 기록을 옮겨 적은 것이고, 사용자가 이 파일에서 새로 승인한 것이 아니다 (04-UAT.md 7번에서 사용자가 문구를 확인, pass)"
    accepted_by: "사용자 (프로젝트 소유자). 04-CONTEXT.md D-18·D-20 추가 결정에 기록됨"
    accepted_at: "2026-11-18"
re_verification:
  previous_status: human_needed
  previous_score: 66/74
  previous_verified: 2026-11-18T08:27:59Z
  gaps_closed: []
  human_items_resolved:
    - "이전 human_verification 8건은 04-UAT.md에서 모두 pass (total 8, passed 8, issues 0). 이전 UNCERTAIN 8건(과정 사실)은 UAT 6번, override 문구는 UAT 7번, 금지 항목 53건은 UAT 8번에서 정리됨"
  gaps_remaining: []
  regressions: []
  note: "이전 보고서에 gaps: 구간이 없어 초기 모드로 전체를 다시 확인했다. 이전 검증 뒤 코드 리뷰 수정 커밋 11개가 index.html·scripts/check-site.sh·CLAUDE.md·.claude/CLAUDE.md를 바꿨고, 이 커밋들은 아직 원격 main에 없다 (HEAD가 origin/main보다 33커밋 앞섬). 그래서 HEAD는 로컬 운영 동일 빌드로, 라이브는 origin/main(9cc1490) 빌드와 대조해 따로 확인했다"
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
**Verified:** 2026-11-18T13:32:19Z
**Status:** human_needed
**Re-verification:** 예. 이전 보고서(2026-11-18T08:27:59Z, human_needed, 66/74)에 `gaps:`가 없어 초기 모드로 전부 다시 확인했습니다

## 결론

단계 목표는 HEAD와 라이브 양쪽에서 이루어졌습니다. 이번 검증에서 성공 기준 세 개를 직접 다시 돌렸습니다.

- **두 개의 트리가 있습니다.** 이전 검증 뒤 코드 리뷰 수정 커밋 11개가 사이트 파일을 바꿨습니다 (코스 이름 「댕댕런」→「강아지런」, 거리 8.3→7.84 km, 점검 6번 항목을 낱말 단위로 셈). 이 커밋은 **아직 푸시되지 않았습니다.** 라이브는 `9cc1490`(origin/main)을 서빙합니다.
- **HEAD:** 운영과 같은 production·`--safe` 빌드에서 SC1 0곳, `check-site.sh` 통과, `p4-behave` `PASS behave`(6개 문맥), `p4-shots` `PASS shots`(두 엔진 × 375·1280)가 나왔습니다. 새로 찍은 화면도 직접 열어 보았습니다.
- **라이브:** `/`가 origin/main 빌드와 바이트가 같고, 세 낱말 0, 4 URL 200·기대 제목, WebP 6개 200·`image/webp`·저장소와 바이트 같음, 내부 파일 3개 404입니다.
- 이전 보고서의 사람 확인 8건은 `04-UAT.md`에서 모두 pass로 끝났습니다. 그 UAT는 라이브(수정 전 트리)에서 했습니다. 수정 커밋은 UAT가 본 화면(뱃지 색, `#screens` 구간, 메타·OG)을 건드리지 않았으므로 결과가 HEAD에도 그대로 이어집니다 (`git diff 9506236 HEAD -- index.html`에서 `screens`·`rp-shot`·`images/app`·`NAVER` 줄 변경 0).

막는 공백은 없습니다. 상태는 `human_needed`입니다. 계획의 `<human-check>`와 이전 사람 확인 8건을 절차대로 다시 적었기 때문이고, 그 8건은 `04-UAT.md`에 모두 pass로 있습니다 (아래 「Human Verification Required」). 다만 **푸시 전에 볼 경고가 하나 있습니다** (WR-02, 아래 「경고」 1번). 지금 HEAD를 그대로 푸시하면 「코스 그리기」 목업에 7.84 km와 8.3 km 기준 예상 시간(111분·71분·33분)이 함께 나갑니다.

## Goal Achievement

### ROADMAP 성공 기준 (계약)

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| SC1 | 홈페이지 본문, `<meta name="description">`, OG 제목·설명 어디에도 「포인트」「굿즈」「코스북」이 없다 (빌드 결과 검색 0건) | ✓ VERIFIED | HEAD production·`--safe` 빌드 `$W/v2head/site/index.html`: `grep -c -E '포인트\|굿즈\|코스북'` = 0. 라이브 `/`(캐시 우회)도 0이고 origin/main 빌드와 `cmp` 같음. meta description·og:description은 04-03 지정 문장, title·og:title은 그대로. `scripts/check-site.sh`(작업 트리) 통과 |
| SC2 | 실제 앱 화면 스크린샷과 출시 전 표시(「출시 준비 중」)가 함께 보이고(375·1280px), 스크린샷에 출시 범위 밖 기능이 없다 | ✓ VERIFIED | HEAD 빌드를 loopback(127.0.0.1:4211)에 띄워 `p4-shots.mjs` 실행: `PASS shots`(chromium·webkit × 1280·375, imgs=3, credit-gap 38.4/28, strip arrow 0→276, end-gap 20). 새 캡처 `webkit-1280-screens.png`·`webkit-375-screens.png`를 직접 봄: 제목 「실제 앱 화면」, 「출시 준비 중」 딱지, 세 장과 캡션, 「지도 © NAVER Corp.」. 캡처 속에 포인트·굿즈·코스북·하단 탭·Dev 표시 없음. ③의 로고 덮임은 사용자 예외(override). 라이브는 같은 구간(9506236 이후 구간 줄 변경 0)이고 WebP 6개 바이트 같음 |
| SC3 | 기존 동작(고정되는 세 가지 이유, 7초 달려 보기, 움직임 줄이기 대응)이 그대로 동작하고 콘솔 오류가 없다 | ✓ VERIFIED | HEAD 빌드에서 `p4-behave.mjs` 실행: chromium·webkit × (1280, 375, 1280 reduce) 6개 문맥 OK, `PASS behave`. 판정 내용은 0.5·0.85 지점 `is-s1`·`is-s2`와 stage 고정, 3.5초 20~80%, 7.7초 `100 %`·「다시 달리기」·완료 표시, reduce에서 `rp-pin` 없음·`aria-pressed`·히어로 `animationsPaused`, console error·pageerror 0, `scrollWidth <= innerWidth`. HEAD의 인라인 스크립트는 BASE 대비 `KM` 값(8.3→7.84)과 주석 한 줄만 다르고, 스크립트가 찾는 id·선택자는 BASE와 같음 |

### PLAN must-have truths

이전 보고서의 71개 truth를 HEAD 기준으로 다시 봤습니다. 대부분은 특정 커밋·푸시에 대한 사실이라 이후 커밋이 바꾸지 못합니다. 지금 상태에 대한 truth는 다시 돌렸습니다. 이전에 UNCERTAIN이었던 8건(사람 승인·촬영 조건 같은 과정 사실)은 `04-UAT.md` 6번에서 사용자가 확인했습니다.

| # | Plan | Truth (요약) | Status | Evidence (이번 검증) |
|---|------|--------------|--------|----------|
| 1 | 04-01 | ROADMAP Goal·SC2, SITE-06이 「출시 전임을 알리는 표시(현재 「출시 준비 중」)」 | ✓ VERIFIED | `roadmap.get-phase 4`, REQUIREMENTS 34행 |
| 2 | 04-01 | Phase 9 SC2 문구는 그대로 | ✓ VERIFIED | HEAD ROADMAP 292행이 원래 문구 「출시 예정 표시」 유지. `af99447..HEAD`에 ROADMAP 변경 커밋 없음 |
| 3 | 04-01 | `roadmap validate` 경고 없음 | ✓ VERIFIED | HEAD에서 다시 실행 `{"warnings": []}` |
| 4 | 04-01 | USER-TASKS 작업 10이 D-16~D-20 조건 안내 | ✓ VERIFIED | HEAD 작업 10에 iPhone·하단 탭·NAVER·검색 결과·Dev 조건 있음. `af99447..HEAD`에 USER-TASKS 변경 없음 |
| 5 | 04-01 | 첫 문서 커밋 하나에 세 파일만 | ✓ VERIFIED | `760d0e9` numstat: REQUIREMENTS·ROADMAP·USER-TASKS 3파일 |
| 6 | 04-02 | BASE_SHA와 BASE_LIVE의 `.planning/` 밖 트리가 같음 | ✓ VERIFIED | 이전 확인 (커밋 고정 사실) |
| 7 | 04-02 | 기준 빌드 4 URL 200·기대 제목 | ✓ VERIFIED | 이전 확인 |
| 8 | 04-02 | 기준 줄 수 index 2, 법적 6/6/3 | ✓ VERIFIED | `$W/base/site/index.html` 줄 수 2. HEAD 빌드 법적 3종 6/6/3이고 BASE와 바이트 같음 |
| 9 | 04-02 | Playwright를 승인 뒤에만 스크래치에 설치 | ✓ VERIFIED | 04-UAT.md 6번 (1) 사용자 확인 pass |
| 10 | 04-02 | 기준 출력 p4-behave PASS | ✓ VERIFIED | 기록 BEHAVE_BASE=OK. 같은 판정이 HEAD에서도 PASS |
| 11 | 04-02 | 계약을 깬 사본에 FAIL behave·pageerror | ✓ VERIFIED | 04-UAT.md 6번 (2) 기록 수용 pass. 스크립트에 `pageerror`·console error 수집과 `FAIL behave` 경로가 있음을 직접 확인 (91·92·105행) |
| 12 | 04-03 | 문구 커밋 뒤 세 낱말 0줄 | ✓ VERIFIED | `scripts/check-site.sh abdeb52` 통과 |
| 13 | 04-03 | meta·og 설명이 지정 문장, title·og:title 그대로 | ✓ VERIFIED | HEAD 빌드 8~15행 |
| 14 | 04-03 | 3단계 글·캡션 「보관함 · 받은 뱃지 7」, 실루엣 없음 | ✓ VERIFIED | 이전 확인. 수정 커밋은 이 줄을 건드리지 않음 |
| 15 | 04-03 | 출력 diff `10c10 15c15 278c278 289c289` | ✓ VERIFIED | 이전 확인 (커밋 고정) |
| 16 | 04-03 | 문구 후보 p4-behave PASS | ✓ VERIFIED | 기록 C1_OK |
| 17 | 04-03 | 문구 커밋 `index.html` 4/4줄만 | ✓ VERIFIED | `abdeb52` numstat `4 4 index.html` |
| 18 | 04-04 | 뱃지 줄 7개 모두 받은 색 | ✓ VERIFIED | HEAD p4-behave `badges=7 empty=0`. UAT 1번 pass |
| 19 | 04-04 | 스티커 6개 받은 색 | ✓ VERIFIED | HEAD p4-behave `stickers=6` |
| 20 | 04-04 | `t-empty`·회색 hex 0, 새 hex 없음 | ✓ VERIFIED | 이전 확인. 수정 커밋이 더한 줄에 새 hex 0 |
| 21 | 04-04 | 출력 diff 머리 `82d81 285,287c284,286 304c303 306c305` | ✓ VERIFIED | 이전 확인 (커밋 고정) |
| 22 | 04-04 | p4-behave PASS, `badges=7 stickers=6 empty=0` | ✓ VERIFIED | HEAD 6개 문맥 모두 그 값 |
| 23 | 04-04 | 빈 뱃지 커밋 +5/−6, 같은 푸시 | ✓ VERIFIED | `f8d66a6` numstat `5 6` |
| 24 | 04-05 | 첫 푸시는 승인 뒤, 사이트 파일 index.html 하나, 커밋 C1·C2 | ✓ VERIFIED | 범위는 git, 승인은 04-UAT.md 6번 (3) |
| 25 | 04-05 | 후보가 pre-push 경로 통과 | ✓ VERIFIED | 이전 확인. `.githooks` BASE→HEAD 변경 0 |
| 26 | 04-05 | 배포 뒤 4 URL 200·기대 제목 | ✓ VERIFIED | 기록 LIVE_PUSH1=OK, 지금 라이브도 같음 |
| 27 | 04-05 | 라이브 `/`가 C2 빌드와 바이트 같음 | ✓ VERIFIED | 당시 기록 (LIVE_PUSH1). 지금 라이브는 이후 푸시를 반영해 origin/main 빌드와 바이트 같음 |
| 28 | 04-05 | 라이브 p4-behave PASS | ✓ VERIFIED | 기록. HEAD에서도 PASS |
| 29 | 04-05 | 이 푸시에 구간·6번 항목·D-23 문서 없음 | ✓ VERIFIED | 이전 확인 (커밋 범위 고정) |
| 30 | 04-06 | check-site 6번 항목이 랜딩 출력만 검색 | ✓ VERIFIED | 지금 스크립트도 `"$DEST/index.html"` 하나만 봄 |
| 31 | 04-06 | 점검·문구 커밋 통과, 기준은 「/index.html 2줄」로 실패 | ✓ VERIFIED | `a02573f`의 스크립트로 BASE를 돌려 「/index.html 2줄」 exit 1. 지금 스크립트는 낱말 단위라 같은 BASE에서 「5곳」 exit 1 (IN-01 수정) |
| 32 | 04-06 | 점검 커밋은 check-site 하나, 출력 같음, pre-push 그대로 | ✓ VERIFIED | `a02573f` numstat `8 1 scripts/check-site.sh` |
| 33 | 04-06 | 점검 커밋이 첫 푸시 뒤 | ✓ VERIFIED | `073d33e`가 조상 |
| 34 | 04-06 | 원본 맵 4개가 점검 항목을 여섯으로 | ✓ VERIFIED | HEAD 재확인: CONVENTIONS 「점검 항목은 여섯이다」, TESTING·ARCHITECTURE·STACK에 6번 항목(랜딩 포인트·굿즈·코스북) 있음 |
| 35 | 04-07 | 두 CLAUDE.md D-23 행 갱신, 방침 구간 같음 | ✓ VERIFIED | HEAD에서 두 방침 구간 diff: 내용 같고 `.claude` 쪽 끝에 GSD 생성 표식 줄만 더 있음 |
| 36 | 04-07 | 갱신이 LIVE_PUSH1 뒤 | ✓ VERIFIED | 조상 관계 |
| 37 | 04-07 | Deploy 문단에 「랜딩 출력에 포인트·굿즈·코스북이 없음」 | ✓ VERIFIED | 루트 CLAUDE.md Deploy 문단 |
| 38 | 04-07 | `.claude/CLAUDE.md` 생성 구간이 재생성 결과와 바이트 같음 | ✓ VERIFIED | HEAD를 `git archive`로 스크래치에 꺼내 `generate-claude-md` 실행, `cmp` 같음 |
| 39 | 04-07 | README·STRUCTURE 점검 주석에 6번 항목 | ✓ VERIFIED | HEAD 재확인: README·STRUCTURE에 「랜딩 기능 이름」 각 1 |
| 40 | 04-08 | 문서 푸시는 승인 뒤, 범위 파일 넷 | ✓ VERIFIED | 범위는 git, 승인은 04-UAT.md 6번 (4) |
| 41 | 04-08 | 문서 커밋이 모두 PUSH1 뒤 | ✓ VERIFIED | 조상 관계 |
| 42 | 04-08 | 문서 푸시가 출력을 바꾸지 않음 | ✓ VERIFIED | 이전 확인 |
| 43 | 04-08 | 4 URL 200, 내부 파일 3개 404 | ✓ VERIFIED | 이번 라이브 확인: `/CLAUDE.md`·`/README.md`·`/scripts/check-site.sh` 404 |
| 44 | 04-09 | 합성 P3 이미지 파이프라인 시험 | ✓ VERIFIED | 04-UAT.md 6번 (5) 기록 수용 |
| 45 | 04-09 | 사용자가 시험 계정·경로로 찍은 세 장을 넘김 | ✓ VERIFIED | 04-UAT.md 6번 (6) |
| 46 | 04-09 | 세 장의 항목별 검토 OK (로고 온전 포함) | PASSED (override) | ③ 로고 덮임·상태 표시줄 차이는 사용자 예외 (04-CONTEXT D-18·D-20). override 문구는 04-UAT.md 7번 pass |
| 47 | 04-09 | WebP 6개 sRGB·메타데이터 없음·크기 상한·sha256 | ✓ VERIFIED | 이전 확인. 파일은 이후 바뀌지 않았고 라이브와 바이트 같음 |
| 48 | 04-09 | 캡처 원본·경로가 저장소에 없음 | ✓ VERIFIED | HEAD 재확인: `favicon/` 밖 PNG 0. 단계 문서·CLAUDE.md·README·원본 맵에 실제 로컬 절대 경로 0 (규칙 문장의 `/Users/` 언급만 있음) |
| 49 | 04-10 | `#demo`와 `#get` 사이 `#screens`, 딱지·세 장·캡션 | ✓ VERIFIED | HEAD p4-shots·캡처 |
| 50 | 04-10 | 폰 테두리 값, `.rp-phone` 재사용 없음 | ✓ VERIFIED | 이전 확인, 이후 구간 줄 변경 0 |
| 51 | 04-10 | 1280 한 줄, 375 scroll-snap·Tab/→·끝 여백·가로 밀림 없음 | ✓ VERIFIED | HEAD `OK strip ... arrow=0->276 end-gap=20` 두 엔진, `scrollWidth <= innerWidth` |
| 52 | 04-10 | 「지도 © NAVER Corp.」가 가려지지 않음, 제휴 오인 문구 없음 | ✓ VERIFIED | HEAD credit-gap 38.4/28 |
| 53 | 04-10 | 같은 도메인 이미지, srcset 등 속성, sha256 같음 | ✓ VERIFIED | 라이브 6파일 200·`image/webp`·바이트 같음 |
| 54 | 04-10 | CAND3 범위·지운 줄 하나 | ✓ VERIFIED | 이전 확인 (커밋 고정) |
| 55 | 04-10 | 후보 p4-shots·p4-behave 통과 | ✓ VERIFIED | 기록 SHOTS_OK. HEAD에서도 PASS |
| 56 | 04-10 | CAND3가 어떤 ref에도 없음 | ✓ VERIFIED | `git cat-file -t` commit, `for-each-ref --contains` 빈 출력 |
| 57 | 04-11 | C3 부모·트리·범위 | ✓ VERIFIED | `9506236` numstat: WebP 6개 + `index.html` 38/1 |
| 58 | 04-11 | 승인 전 ref에 없었고 푸시 뒤 main에 들임, 이력 수정 없음 | ✓ VERIFIED | merge 0, 조상 관계는 git. 승인은 04-UAT.md 6번 (7) |
| 59 | 04-11 | 배포 뒤 4 URL 200, 라이브 `/`가 C3 빌드와 바이트 같음 | ✓ VERIFIED | `9506236`을 새로 빌드(`$W/v2c3`)해 origin/main 빌드와 `diff -r` 같음. 라이브 `/`가 origin/main 빌드와 `cmp` 같음 |
| 60 | 04-11 | 라이브 WebP 6개 200·`image/webp`·바이트 같음 | ✓ VERIFIED | 이번 라이브 확인 |
| 61 | 04-11 | 라이브 p4-shots PASS | ✓ VERIFIED | 기록 + 이전 검증자 실행. HEAD에서도 PASS |
| 62 | 04-11 | 라이브 p4-behave PASS | ✓ VERIFIED | 기록 + 이전 검증자 실행. HEAD에서도 PASS |
| 63 | 04-12 | CONVENTIONS·ARCHITECTURE·STACK이 구간·WebP 예외·도구를 적음 | ✓ VERIFIED | HEAD 재확인: `images/app/` CONVENTIONS 2·ARCHITECTURE 3·STACK 1, STACK에 `sips`·`cwebp`·`webpinfo` |
| 64 | 04-12 | STRUCTURE에 `images/app/`, INTEGRATIONS에 NAVER 지도 출처 | ✓ VERIFIED | HEAD 재확인: STRUCTURE `images/app` 1, INTEGRATIONS `NAVER` 1 |
| 65 | 04-12 | 루트 CLAUDE.md Pages 표·SVG 예외·지도 출처·Assets | ✓ VERIFIED | 루트 CLAUDE.md 해당 문단 |
| 66 | 04-12 | `.claude/CLAUDE.md` 재생성과 바이트 같음, 방침 구간 같음 | ✓ VERIFIED | #38과 같은 확인 |
| 67 | 04-12 | 옛 문장 없음 | ✓ VERIFIED | HEAD에서 04-12 verify의 정규식 그대로 CLAUDE.md·.claude/CLAUDE.md·README·원본 맵 전체 0줄 |
| 68 | 04-13 | D-24 문서 푸시는 승인 뒤, 범위 파일 둘 | ✓ VERIFIED | 범위는 git, 승인은 04-UAT.md 6번 (8) |
| 69 | 04-13 | 문서 푸시가 출력을 바꾸지 않음 | ✓ VERIFIED | 새로 빌드한 `9506236` 출력 = origin/main(`9cc1490`) 출력 (`diff -r` 빈 출력) |
| 70 | 04-13 | 4 URL 200·기대 제목, `/CLAUDE.md` 404 | ✓ VERIFIED | 이번 라이브 확인 |
| 71 | 04-13 | 단계 끝 판정표 SC1~SC3 OK | ✓ VERIFIED | EVIDENCE 968~970행 `SC[123] OK` |

**Score:** 74/74 truths verified (ROADMAP 3 + PLAN 71. VERIFIED 73 + PASSED (override) 1. FAILED 0. UNCERTAIN 0. 동작 미검증 0)

동작에 달린 truth(SC3의 고정·7초 데모·움직임 줄이기, 띠의 키보드 밀기)는 모두 HEAD 빌드에서 판정 스크립트를 직접 돌려 확인했습니다. 그래서 `behavior_unverified`는 0입니다.

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `index.html` | 정정된 메타·OG·3단계 글, 컬러 뱃지, `#screens` 구간 | ✓ VERIFIED | HEAD 빌드에 반영, 판정 스크립트 통과. 라이브는 수정 전 트리(9cc1490)이고 그 트리도 목표 충족 |
| `images/app/screen-{draw,run,badge}-{564,846}.webp` | 앱 화면 캡처 6개 | ✓ VERIFIED | `srcset`에 연결, 라이브 200·바이트 같음 |
| `scripts/check-site.sh` | 6번 항목 | ✓ VERIFIED | HEAD 통과, BASE 실패(「5곳」, exit 1), `abdeb52` 통과. pre-push 훅이 부름 |
| `CLAUDE.md`, `.claude/CLAUDE.md` | D-23 행, D-24 문서 | ✓ VERIFIED | 방침 구간 같음, 생성 구간 재생성과 바이트 같음 |
| `.planning/baseline/USER-TASKS.md` | 작업 10 | ✓ VERIFIED | `verify.artifacts` 통과 |
| `04-EVIDENCE.md` | 판정 기록과 표식 | ✓ VERIFIED | `verify.artifacts` 13개 계획 모두 exit 0 |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `index.html` `srcset` | `images/app/*.webp` | 같은 도메인 경로 | ✓ WIRED | HEAD p4-shots `src=564,564,564`, 라이브 200 |
| `.rp-shots-sec` | `.rp-get` 음수 margin | CSS 맞물림 | ✓ WIRED | credit-gap 양수 |
| `.githooks/pre-push` | `scripts/check-site.sh` | 훅 | ✓ WIRED | `.githooks` BASE→HEAD 변경 0 |
| `.planning/codebase/CONVENTIONS.md` | `.claude/CLAUDE.md` | generate-claude-md | ✓ WIRED | 재생성과 바이트 같음 |
| `04-EVIDENCE.md` | `index.html` / ROADMAP (04-02·04-09·04-10·04-13) | `^BASE_SHA=` 등 줄머리 앵커 | ✓ WIRED (수동) | `verify.key-links`가 이 네 개를 exit 1로 냄 (도구가 줄머리 앵커를 여러 줄 모드 없이 대조하는 거짓 음성). `grep -n -E`로 25·578~582·615·968~970행에서 줄머리부터 있음을 확인. 나머지 9개 계획 링크는 도구 exit 0 |

### Data-Flow Trace (Level 4)

해당 없음. 정적 사이트이고 새 구간의 데이터는 정적 WebP와 마크업 글입니다. 이미지 로드는 p4-shots `imgs=3`과 HTTP 200으로 확인했습니다.

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| 푸시 전 점검 (HEAD) | `scripts/check-site.sh` | `통과 (작업 트리, jekyll 3.10.0)` | ✓ PASS |
| 6번 항목 음성 대조 | `scripts/check-site.sh 0e75e8b88fd2` | `/index.html 5곳`, exit 1 | ✓ PASS |
| 04-06 원래 스크립트 음성 대조 | `bash <(git show a02573f:scripts/check-site.sh) 0e75e8b88fd2` | `/index.html 2줄`, exit 1 | ✓ PASS |
| 문구 커밋 양성 | `scripts/check-site.sh abdeb52` | 통과 | ✓ PASS |
| 빌드 출력 세 낱말 | HEAD production `--safe` 빌드 후 `grep -c` | index 0, 법적 6/6/3 (Phase 6~8 범위, BASE와 바이트 같음) | ✓ PASS |
| SC3 동작 (HEAD) | `node p4-behave.mjs http://127.0.0.1:4211` | `PASS behave` (6 문맥) | ✓ PASS |
| SC2 구간 (HEAD) | `node p4-shots.mjs http://127.0.0.1:4211 $W/cap/v2head` | `PASS shots` (두 엔진 × 375·1280) | ✓ PASS |
| 라이브 = origin/main | `curl` + `cmp` | `/` 바이트 같음, 4 URL 200·기대 제목, 내부 파일 3개 404, WebP 6개 같음 | ✓ PASS |

판정 스크립트는 저장소 밖 스크래치(`$TMPDIR/rp-p4/pw`)에 있는 단계의 정식 판정 도구입니다. Step 7b는 서버를 띄우지 말라고 하지만, 이 단계가 정한 판정 방법이 「빌드 출력을 loopback에 띄워 Playwright로 본다」라서 그대로 따랐습니다. 저장소와 라이브는 바꾸지 않았고, 서버(포트 4211)는 판정 뒤 끝냈습니다.

### Probe Execution

해당 없음. 저장소에 `scripts/*/tests/probe-*.sh`가 없고 계획에서 정한 probe도 없습니다.

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| SITE-01 | 04-02~08, 04-13 | 소개 문구·메타 설명·OG에서 출시 앱에 없는 기능(포인트·굿즈·코스북)이 보이지 않음 | ✓ SATISFIED | SC1 (HEAD·라이브). check-site 6번 항목이 다시 들어오는 것을 막음 |
| SITE-06 | 04-01, 04-02, 04-09~13 | 실제 앱 화면(스크린샷)과 출시 전 표시(현재 「출시 준비 중」) | ✓ SATISFIED | SC2 (HEAD 판정 + 캡처 확인). 디자인·실기기·낭독기 확인은 04-UAT.md 2~4번 pass |

REQUIREMENTS.md에서 Phase 4에 걸린 ID는 SITE-01·SITE-06 둘뿐이고(166·171행), 둘 다 계획 frontmatter에 있습니다. 빠진(ORPHANED) 요구 사항은 없습니다.

### Decision Coverage

All trackable CONTEXT.md decisions are honored by shipped artifacts. (`check.decision-coverage-verify`: honored 24 / total 24, not_honored 없음)

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `scripts/check-site.sh` | 42 | `XXX` (`mktemp ... rp-check.XXXXXX`) | ℹ️ Info | mktemp 템플릿이고 부채 표시가 아님 |
| `index.html` | 286~287 | 거리 `7.84 km` 옆 예상 시간 `111분·71분·33분`이 8.3 km 기준 값 (REVIEW WR-02, open) | ⚠️ Warning | 아래 경고 1번 |
| `scripts/check-site.sh` | 96~100 | `U10_ALLOW_PREFIX`를 비우거나 `'체크\|'`처럼 틀리면 grep 오류가 숨겨져 0곳으로 통과 (REVIEW WR-03, open) | ⚠️ Warning | 아래 경고 2번 |
| `index.html`·`CLAUDE.md` | — | TODO·FIXME·TBD·placeholder·「추후 기재」 | — | 0건 (`CLAUDE.md` 28행의 「추후 기재」는 금지 규칙 문장) |
| `.planning/codebase/CONCERNS.md`·`TESTING.md` | 여러 줄 | 줄 수·검증 대상 목록이 구간 추가 전 값 (`deferred-items.md` open 2건) | ℹ️ Info | 문서 드리프트. 사이트 동작과 무관 |

### Test Quality Audit

| Test File | Linked Req | Active | Skipped | Circular | Assertion Level | Verdict |
|-----------|-----------|--------|---------|----------|-----------------|---------|
| `$W/pw/p4-behave.mjs` (스크래치) | SC3 | 6 문맥 | 0 | 아니요 | Behavioral (상태 클래스·좌표·텍스트·console/pageerror) | 충분. 음성 대조 기록 있음 |
| `$W/pw/p4-shots.mjs` (스크래치) | SC2, SITE-06 | 4 문맥 | 0 | 아니요 | Value + 캡처 | 충분. 화면 판단은 UAT로 보완 |
| `scripts/check-site.sh` 6번 | SC1, SITE-01 | 1 | 0 | 아니요 | Value (개수) | 충분. 다만 WR-03 설정 오류 시 fail-open |

**Disabled tests on requirements:** 0. **Circular patterns detected:** 0. **Insufficient assertions:** 0.

### 경고 (WARNING)

1. **WR-02: 「코스 그리기」 목업의 예상 시간이 옛 거리 기준 (푸시 전 결정 필요).**
   - `index.html:286`은 `7.84 km`인데 `:287`의 `111분 · 71분 · 33분`은 8.3 km를 시속 4.5·7·15 km로 나눈 값입니다.
   - 이 불일치는 **아직 푸시되지 않은 HEAD에만** 있습니다. 라이브는 8.3 km와 그 시간이 서로 맞습니다. 지금 HEAD를 푸시하면 이 불일치도 함께 나갑니다.
   - 걷기 값(104분 또는 105분)은 앱 화면에서 확인해야 하므로 검증자가 채우지 않았습니다. 앱이 이 화면에서 거리를 `7.8 km`처럼 소수 한 자리로 보여 주는지(REVIEW IN-10)도 같이 확인하면 좋습니다.
   - 단계 목표(앱에 없는 기능 설명 제거, 실제 화면과 출시 전 표시)를 깨지 않는 목업 숫자 문제라서 gap이 아니라 경고로 둡니다.
   - 같은 페이지의 앱 캡처 ③은 「강아지런」·`7.84 km`를 보여 주므로, 수정 커밋의 코스 이름과 거리 값은 앱과 맞습니다.
2. **WR-03: 점검 6번 항목의 설정 오류 fail-open.** 검증자도 BASE 빌드로 재현했습니다. `U10_ALLOW_PREFIX='체크|'`나 `''`이면 grep 오류가 `2>/dev/null`에 숨고 0곳으로 통과합니다. 지금 값(`'체크|엔드'`)은 정상 동작합니다 (BASE 5곳 실패, HEAD 통과).
3. **③ 캡처의 NAVER 로고 덮임 (사용자 예외).** 앱의 뱃지 창이 로고를 덮은 원본 장면입니다. 사용자가 위험을 알고 받아들였고(04-CONTEXT D-20), override 문구는 04-UAT.md 7번에서 확인됐습니다. 앱에서 위치를 고치면 ③만 다시 찍습니다.
4. **`verify.key-links` 거짓 음성 4건.** 줄머리 앵커 패턴에서 생깁니다. 수동으로 모두 연결을 확인했습니다.

### 금지 항목 (prohibitions, judgment 등급)

이번에 13개 계획 frontmatter에서 `must_haves.prohibitions`를 다시 뽑았습니다. 금지 항목은 53개(3·4·4·4·4·3·3·3·4·9·5·4·3)이고 모두 `verification: judgment`, `status: resolved`입니다. test 등급은 없습니다.

아래는 검증자(LLM)의 **비권위 판정**입니다 (`unverified-prohibition — human review recommended`).

- 이전 보고서의 판정은 04-UAT.md 8번에서 pass로 기록됐습니다.
- 그 기록은 사용자 요청으로 에이전트가 HEAD `d800719` 기준으로 다시 확인한 것이라, 사람이 직접 판정한 것을 대신하지는 않습니다.
- 이번 검증은 그 뒤 수정 커밋이 금지 항목에 닿는지만 봤습니다.

| 묶음 | 이번 판정 | 근거 |
|------|-----------|------|
| 사이트 파일 범위 (`_includes`·`_layouts`·법적 3종·`.githooks`) | 지켜짐 | BASE→HEAD `git diff --stat` 빈 출력. 법적 3종 출력 BASE와 바이트 같음 |
| 스크립트 계약 (스크립트 추가·계약 이름 변경 금지) | 지켜짐 | `<script` 블록 수 BASE 2 / HEAD 2. 스크립트가 찾는 `byId`·`querySelector` 대상이 BASE와 같음. 바뀐 것은 `KM` 값과 주석 |
| title·og:title 그대로 | 지켜짐 | HEAD 빌드 8·13행 |
| 새 hex | 지켜짐 | `9cc1490..HEAD`에서 더한 줄에 새 hex 0 |
| 이력 수정·merge 금지 | 지켜짐 | `git rev-list --merges --count 0bfe5b2..HEAD` = 0 |
| `.claude/CLAUDE.md` 생성 구간 손 편집 금지 | 지켜짐 | 재생성 결과와 바이트 같음 |

### Human Verification Required

frontmatter `human_verification`에 8건을 다시 적었습니다. 이 단계 계획의 `<human-check>` 세 개(04-04 뱃지 색, 04-10 구간 화면, 04-11 실기기 Safari)와 이전 보고서의 사람 확인 항목입니다. 문구는 이전 보고서와 글자까지 같게 두었습니다. 그래야 execute-phase가 `04-UAT.md`에 합칠 때 기존 행과 맞고 새 행이 생기지 않습니다.

**8건 모두 이미 `04-UAT.md`에 결과가 있습니다** (status complete, passed 8, issues 0).

- `gsd-tools phase uat-passed 4 --uat-only`가 `passed: true`, blockers 0을 냈습니다.
- verify-work의 정규화 단계가 이 보고서를 `passed`로 바꿀 수 있는 상태입니다.
- 그 UAT는 라이브(수정 전 트리 `9cc1490`)에서 했습니다.
- 그 뒤 수정 커밋 11개는 UAT가 본 화면(3단계 뱃지 색, `#screens` 구간, meta·OG)을 바꾸지 않았습니다. 그래서 결과가 HEAD에도 이어진다고 판단합니다.

이번 수정 커밋이 바꾼 화면 글(코스 이름 「강아지런」, 거리 7.84 km)에 새 사람 확인 항목은 만들지 않았습니다. 같은 페이지의 앱 캡처 ③이 「강아지런」·`7.84 km`를 직접 보여 줍니다.

WR-02(걷기 예상 시간)는 사람이 확인해야 하는 사실값입니다. 하지만 단계 목표의 must-have가 아니라 리뷰 finding입니다. `04-REVIEW-DISPOSITION.md`에서 open으로 추적합니다.

### Gaps Summary

막는 공백(BLOCKER)은 없습니다.

- ROADMAP 성공 기준 1~3을 HEAD 운영 동일 빌드에서 직접 다시 돌려 모두 통과했습니다. 라이브(origin/main `9cc1490`)도 세 낱말 0, 4 URL 정상, 이미지 정상입니다.
- 요구 사항 SITE-01·SITE-06을 충족했습니다.
- 이전 UNCERTAIN 8건과 사람 확인 8건은 04-UAT.md에서 정리됐습니다. 상태가 `human_needed`인 것은 절차상 사람 확인 항목을 다시 적었기 때문이고, 그 항목들은 UAT에서 모두 pass입니다.

**남은 일 (gap 아님):**

- 코드 리뷰 수정 커밋 11개가 아직 푸시되지 않았습니다.
- 푸시하기 전에 WR-02(목업 예상 시간)를 고칠지 정해야 합니다. 걷기 값은 앱에서 확인한 값으로 씁니다.
- WR-03(점검 스크립트 fail-open)은 견고성 문제라 다음 점검 스크립트 수정 때 고치면 됩니다.

---

_Verified: 2026-11-18T13:32:19Z_
_Verifier: Claude (gsd-verifier)_
