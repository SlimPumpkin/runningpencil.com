---
phase: 04-landing-content-fix
verified: 2026-11-18T14:22:29Z
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
covered_digest: "v4:sha256:eec4167258bf7c714342c3b84ba7e1cfe17371d9f82addcdc708f2b8e6de4c11"
behavior_unverified: 0
overrides_applied: 1
overrides:
  - must_have: "Claude가 세 장을 직접 열어 항목별로 검토해 모두 OK다: 하단 탭 없음, Dev 표시 없음, 개인 정보 없음, 지도가 보이는 장의 NAVER 로고가 잘리거나 가려지지 않음 (04-09 truth 3)"
    reason: "③ 완주 결과 캡처는 앱의 뱃지 창이 NAVER 로고 오른쪽을 덮은 원본 장면이고(ORIG_REVIEW badge logo FAIL), run·badge의 상태 표시줄 차이 두 건도 원래 판정이 FAIL이었다. 사용자가 NAVER 지도 SDK 가이드 문장과 위험을 들은 뒤 세 건을 사용자 예외로 허용했다. 로고 조건은 「우리가 원본보다 더 자르거나 덮지 않는다」로 바뀌었다. 근거는 04-CONTEXT.md D-18·D-20의 「캡처 검토 뒤 사용자 결정 (2026-11-18, 04-09 Task 3)」과 04-EVIDENCE.md의 CAPTURE_WAIVERS=3이다. 이 override 항목은 검증자가 그 기록을 옮겨 적은 것이고, 사용자가 이 파일에서 새로 승인한 것이 아니다 (04-UAT.md 7번에서 사용자가 문구를 확인, pass)"
    accepted_by: "사용자 (프로젝트 소유자). 04-CONTEXT.md D-18·D-20 추가 결정에 기록됨"
    accepted_at: "2026-11-18"
re_verification:
  previous_status: human_needed
  previous_score: 74/74
  previous_verified: 2026-11-18T13:32:19Z
  gaps_closed: []
  human_items_resolved:
    - "이전 human_verification 8건은 04-UAT.md에서 모두 pass (total 8, passed 8, issues 0). 그 UAT는 라이브(origin/main 9cc1490)에서 했고, 9cc1490..HEAD의 index.html 변경은 UAT가 본 화면(#screens 구간, 3단계 뱃지 색, meta·OG)에 닿지 않는다"
  gaps_remaining: []
  regressions: []
  note: "이전 보고서에 gaps: 구간이 없어 초기 모드로 74개 truth를 모두 다시 봤다. 이전 검증 뒤 수정 커밋 4개(215fa7e WR-02, 8cc86fd WR-03, a6a8aa5 IN-09, 3289fc3 IN-10)가 index.html 두 줄, scripts/check-site.sh 6번 항목, CONVENTIONS.md와 .claude/CLAUDE.md의 <head> 순서 두 줄을 바꿨다. 이 커밋들이 닿는 truth(SC1~SC3, check-site 음성 대조, .claude/CLAUDE.md 재생성 일치)는 이번에 직접 다시 돌렸다. HEAD는 origin/main(9cc1490)보다 42커밋 앞서 있고 아직 푸시되지 않았다"
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
**Verified:** 2026-11-18T14:22:29Z
**Status:** human_needed
**Re-verification:** 예. 이전 보고서(2026-11-18T13:32:19Z, human_needed, 74/74)에 `gaps:`가 없어 초기 모드로 74개 truth를 모두 다시 봤습니다

## 결론

단계 목표는 HEAD와 라이브 양쪽에서 이루어졌습니다. 막는 공백(BLOCKER)은 없습니다.

- **이번에 바뀐 것.** 이전 검증 뒤 수정 커밋 4개가 들어왔습니다.
  - `215fa7e`(WR-02)·`3289fc3`(IN-10): `index.html` 286·287행의 「코스 그리기」 목업 숫자를 `7.8 km`, `104분 · 67분 · 31분`으로 바꿈
  - `8cc86fd`(WR-03): `scripts/check-site.sh` 6번 항목에 형식 확인과 grep 오류 처리를 더함
  - `a6a8aa5`(IN-09): `CONVENTIONS.md`와 다시 생성한 `.claude/CLAUDE.md`의 `<head>` 순서 두 줄을 바꿈
- **HEAD에서 직접 다시 돌린 것.**
  - 운영과 같은 production·`--safe` 빌드에서 SC1 0곳
  - `check-site.sh`: 작업 트리와 `abdeb52`는 통과, BASE는 「5곳」으로 exit 1
  - `p4-behave`: `PASS behave`(6개 문맥)
  - `p4-shots`: `PASS shots`(두 엔진 × 375·1280)
  - `.claude/CLAUDE.md` 재생성 결과와 바이트가 같음 (음성 대조 포함)
- **라이브에서 다시 확인한 것.** 라이브 `/`는 origin/main(`9cc1490`) 빌드와 바이트가 같습니다. 세 낱말 0개, 4 URL 200·기대 제목, 내부 파일 3개 404입니다.
- **아직 푸시되지 않았습니다.** HEAD는 origin/main보다 42커밋 앞서 있습니다 (merge 0). 그래서 라이브 목업은 아직 옛 값(「댕댕런」, 8.3 km)을 보여 주고, 같은 페이지의 앱 캡처 ③은 「강아지런」·7.84 km를 보여 줍니다. 단계 목표(앱에 없는 기능 설명 제거, 실제 화면과 출시 전 표시)를 깨지는 않으므로 경고로 둡니다 (아래 경고 1번).
- **새 리뷰 finding.** 네 번째 리뷰의 open finding 세 건(WR-04, IN-11, IN-12)은 성공 기준이나 plan truth에 닿지 않아 경고·정보로 둡니다.
  - WR-04는 이번에 직접 재현했습니다. `index.html:379`의 「달려 보기」 코스 칩은 `7.84 km`이고, `:286`의 「코스 그리기」 목업은 `7.8 km`입니다.

상태는 `human_needed`입니다. 계획의 `<human-check>` 세 개와 이전 사람 확인 항목을 절차대로 다시 적었기 때문입니다. 8건은 이전 보고서와 글자까지 같고, `04-UAT.md`에 모두 pass로 있습니다.

## Goal Achievement

### ROADMAP 성공 기준 (계약, `roadmap.get-phase 4`로 새로 읽음)

| # | Truth | Status | Evidence (이번 실행) |
|---|-------|--------|----------|
| SC1 | 홈페이지 본문, `<meta name="description">`, OG 제목·설명 어디에도 「포인트」「굿즈」「코스북」이 없다 (빌드 결과 검색 0건) | ✓ VERIFIED | HEAD production·`--safe` 빌드 `$W/v3head/site/index.html`에서 `grep -c -E '포인트\|굿즈\|코스북'` = 0. meta description·og:description이 04-03 지정 문장과 같음. title·og:title은 그대로. 라이브 `/`(캐시 우회)도 0이고 origin/main 빌드와 `cmp` 같음. `scripts/check-site.sh` 작업 트리 통과 |
| SC2 | 실제 앱 화면 스크린샷과 출시 전 표시(「출시 준비 중」)가 함께 보이고(375·1280px), 스크린샷에 출시 범위 밖 기능이 없다 | ✓ VERIFIED | HEAD 빌드를 loopback 127.0.0.1:4212에 띄워 `p4-shots.mjs` 실행: `PASS shots`(chromium·webkit × 1280·375, imgs=3, credit-gap 38.4/28, strip arrow 0→276, end-gap 20, webkit hash top 0.5). 새 캡처 `webkit-1280-screens.png`·`webkit-375-screens.png`를 직접 봄: 제목 「실제 앱 화면」, 「출시 준비 중」 딱지, 세 장(코스 그리기·따라 달리기·완주하고 뱃지 받기), 「지도 © NAVER Corp.」. 캡처 속에 포인트·굿즈·코스북·하단 탭·Dev 표시 없음. ③ 로고 덮임은 사용자 예외(override). 빌드 출력의 WebP 6개가 저장소와 바이트 같음 |
| SC3 | 기존 동작(고정되는 세 가지 이유, 7초 달려 보기, 움직임 줄이기 대응)이 그대로 동작하고 콘솔 오류가 없다 | ✓ VERIFIED | 같은 HEAD 빌드에서 `p4-behave.mjs` 실행: chromium·webkit × (1280, 375, 1280 reduce) 6개 문맥 `OK … badges=7 stickers=6 empty=0`, `PASS behave`. 판정 범위: 단계 전환, stage 고정, 7초 데모, reduce에서 `rp-pin` 없음, console error·pageerror 0, 가로 밀림 없음. 스크립트가 찾는 `byId`·`querySelector` 대상이 라이브 트리(`9cc1490`)와 같음. 이번 수정 커밋은 목업 `<span>` 글 두 줄만 바꿈 |

### PLAN must-have truths

71개 truth를 HEAD 기준으로 다시 봤습니다.

- 대부분은 특정 커밋·푸시에 대한 사실이라 이후 커밋이 바꾸지 못합니다. 그런 것은 「기록」 또는 「git」으로 표시했습니다.
- 지금 상태에 대한 truth는 이번에 다시 돌렸고 「이번 실행」으로 표시했습니다.
- 사람 승인·촬영 조건 같은 과정 사실 8건은 `04-UAT.md` 6번에서 사용자가 확인했습니다.

| # | Plan | Truth (요약) | Status | Evidence |
|---|------|--------------|--------|----------|
| 1 | 04-01 | ROADMAP Goal·SC2, SITE-06이 「출시 전임을 알리는 표시(현재 「출시 준비 중」)」 | ✓ VERIFIED | 이번 실행: ROADMAP 새 표현 2줄, REQUIREMENTS 1줄 |
| 2 | 04-01 | Phase 9 SC2 문구는 그대로 | ✓ VERIFIED | 이번 실행: Phase 9 구간 「출시 예정」 1줄 |
| 3 | 04-01 | `roadmap validate` 경고 없음 | ✓ VERIFIED | 이번 실행 `{"warnings": []}` |
| 4 | 04-01 | USER-TASKS 작업 10이 D-16~D-20 조건 안내 | ✓ VERIFIED | 이번 실행: 작업 10 절에 iPhone·하단 탭·NAVER 로고·검색 결과 목록 줄 있음 |
| 5 | 04-01 | 첫 문서 커밋 하나에 세 파일만 | ✓ VERIFIED | git: `760d0e9` 세 파일 |
| 6 | 04-02 | BASE_SHA와 BASE_LIVE의 `.planning/` 밖 트리가 같음 | ✓ VERIFIED | 기록 (커밋 고정 사실) |
| 7 | 04-02 | 기준 빌드 4 URL 200·기대 제목 | ✓ VERIFIED | 기록 |
| 8 | 04-02 | 기준 줄 수 index 2, 법적 6/6/3 | ✓ VERIFIED | 이번 실행: HEAD 빌드 법적 3종 6/6/3이고 `$W/base`와 `cmp` 같음 |
| 9 | 04-02 | Playwright를 승인 뒤에만 스크래치에 설치 | ✓ VERIFIED | 04-UAT.md 6번 (1) pass |
| 10 | 04-02 | 기준 출력 p4-behave PASS | ✓ VERIFIED | 기록 BEHAVE_BASE=OK. 같은 판정이 HEAD에서도 PASS (이번 실행) |
| 11 | 04-02 | 계약을 깬 사본에 FAIL behave·pageerror | ✓ VERIFIED | 04-UAT.md 6번 (2) 기록 수용 pass |
| 12 | 04-03 | 문구 커밋 뒤 세 낱말 0줄 | ✓ VERIFIED | 이번 실행: `scripts/check-site.sh abdeb52` 통과 (새 6번 항목 코드로) |
| 13 | 04-03 | meta·og 설명이 지정 문장, title·og:title 그대로 | ✓ VERIFIED | 이번 실행: HEAD 빌드 8~15행 |
| 14 | 04-03 | 3단계 글·캡션 「보관함 · 받은 뱃지 7」, 실루엣 없음 | ✓ VERIFIED | 이전 확인. 이후 커밋이 이 줄을 건드리지 않음 (`git diff 9cc1490 HEAD` 해당 줄 0) |
| 15 | 04-03 | 출력 diff `10c10 15c15 278c278 289c289` | ✓ VERIFIED | 기록 (커밋 고정) |
| 16 | 04-03 | 문구 후보 p4-behave PASS | ✓ VERIFIED | 기록 C1_OK |
| 17 | 04-03 | 문구 커밋 `index.html` 4/4줄만 | ✓ VERIFIED | git: `abdeb52` numstat 4 4 |
| 18 | 04-04 | 뱃지 줄 7개 모두 받은 색 | ✓ VERIFIED | 이번 실행: HEAD p4-behave `badges=7 empty=0`. UAT 1번 pass |
| 19 | 04-04 | 스티커 6개 받은 색 | ✓ VERIFIED | 이번 실행: `stickers=6` |
| 20 | 04-04 | `t-empty`·회색 hex 0, 새 hex 없음 | ✓ VERIFIED | 이전 확인. 이후 수정 커밋이 더한 줄은 글뿐이고 hex 0 |
| 21 | 04-04 | 출력 diff 머리 `82d81 285,287c284,286 304c303 306c305` | ✓ VERIFIED | 기록 (커밋 고정) |
| 22 | 04-04 | p4-behave PASS, `badges=7 stickers=6 empty=0` | ✓ VERIFIED | 이번 실행: 6개 문맥 모두 그 값 |
| 23 | 04-04 | 빈 뱃지 커밋 +5/−6, 같은 푸시 | ✓ VERIFIED | git: `f8d66a6` numstat 5 6 |
| 24 | 04-05 | 첫 푸시는 승인 뒤, 사이트 파일 index.html 하나, 커밋 C1·C2 | ✓ VERIFIED | 범위는 git, 승인은 04-UAT.md 6번 (3) |
| 25 | 04-05 | 후보가 pre-push 경로 통과 | ✓ VERIFIED | 기록. `.githooks` BASE→HEAD 변경 0 |
| 26 | 04-05 | 배포 뒤 4 URL 200·기대 제목 | ✓ VERIFIED | 기록 LIVE_PUSH1=OK. 지금 라이브도 같음 (이번 실행) |
| 27 | 04-05 | 라이브 `/`가 C2 빌드와 바이트 같음 | ✓ VERIFIED | 기록 (당시 사실) |
| 28 | 04-05 | 라이브 p4-behave PASS | ✓ VERIFIED | 기록 |
| 29 | 04-05 | 이 푸시에 구간·6번 항목·D-23 문서 없음 | ✓ VERIFIED | 기록 (커밋 범위 고정) |
| 30 | 04-06 | check-site 6번 항목이 랜딩 출력만 검색 | ✓ VERIFIED | 이번 실행: 새 코드도 `"$DEST/index.html"` 하나만 봄 |
| 31 | 04-06 | 점검·문구 커밋 통과, 기준은 실패 | ✓ VERIFIED | 이번 실행: 작업 트리·`abdeb52` 통과, `0e75e8b88fd2`는 「/index.html 5곳」 exit 1 (WR-03 수정 뒤 코드로 재확인). 04-06 당시 메시지 「2줄」은 기록 |
| 32 | 04-06 | 점검 커밋은 check-site 하나, 출력 같음, pre-push 그대로 | ✓ VERIFIED | git: `a02573f` numstat `8 1 scripts/check-site.sh` |
| 33 | 04-06 | 점검 커밋이 첫 푸시 뒤 | ✓ VERIFIED | git 조상 관계 |
| 34 | 04-06 | 원본 맵 4개가 점검 항목을 여섯으로 | ✓ VERIFIED | 이번 실행: CONVENTIONS 「점검 항목은 여섯이다」 1, TESTING·ARCHITECTURE·STACK에 6번 항목 |
| 35 | 04-07 | 두 CLAUDE.md D-23 행 갱신, 방침 구간 같음 | ✓ VERIFIED | 이번 실행: D-23 문장 각 1. 두 방침 구간 diff는 `.claude` 쪽 끝 GSD 생성 표식 줄뿐 |
| 36 | 04-07 | 갱신이 LIVE_PUSH1 뒤 | ✓ VERIFIED | git 조상 관계 |
| 37 | 04-07 | Deploy 문단에 「랜딩 출력에 포인트·굿즈·코스북이 없음」 | ✓ VERIFIED | 이번 실행: 루트 CLAUDE.md |
| 38 | 04-07 | `.claude/CLAUDE.md` 생성 구간이 재생성 결과와 바이트 같음 | ✓ VERIFIED | 이번 실행: HEAD를 `git archive`로 스크래치에 꺼내 `generate-claude-md`, `cmp` 같음. 음성 대조: 같은 스크래치에 `e550ecf`의 CONVENTIONS를 넣고 다시 만들면 `<head>` 순서 두 줄이 달라짐 (생성기가 실제로 반영함) |
| 39 | 04-07 | README·STRUCTURE 점검 주석에 6번 항목 | ✓ VERIFIED | 이번 실행: 「랜딩 기능 이름」 각 1 |
| 40 | 04-08 | 문서 푸시는 승인 뒤, 범위 파일 넷 | ✓ VERIFIED | 범위는 git, 승인은 04-UAT.md 6번 (4) |
| 41 | 04-08 | 문서 커밋이 모두 PUSH1 뒤 | ✓ VERIFIED | git 조상 관계 |
| 42 | 04-08 | 문서 푸시가 출력을 바꾸지 않음 | ✓ VERIFIED | 기록 |
| 43 | 04-08 | 4 URL 200, 내부 파일 3개 404 | ✓ VERIFIED | 이번 실행: `/CLAUDE.md`·`/README.md`·`/scripts/check-site.sh` 404 |
| 44 | 04-09 | 합성 P3 이미지 파이프라인 시험 | ✓ VERIFIED | 04-UAT.md 6번 (5) 기록 수용 |
| 45 | 04-09 | 사용자가 시험 계정·경로로 찍은 세 장을 넘김 | ✓ VERIFIED | 04-UAT.md 6번 (6) |
| 46 | 04-09 | 세 장의 항목별 검토 OK (로고 온전 포함) | PASSED (override) | ③ 로고 덮임·상태 표시줄 차이는 사용자 예외 (04-CONTEXT D-18·D-20). override 문구는 04-UAT.md 7번 pass |
| 47 | 04-09 | WebP 6개 sRGB·메타데이터 없음·크기 상한·sha256 | ✓ VERIFIED | 이번 실행: 저장소 WebP 6개 sha256이 EVIDENCE `IMG` 줄과 모두 같음. sRGB·메타데이터는 기록 (파일 불변) |
| 48 | 04-09 | 캡처 원본·경로가 저장소에 없음 | ✓ VERIFIED | 이번 실행: `favicon/` 밖 추적 PNG 0, EVIDENCE에 `/Users/`·`/private/var` 0 |
| 49 | 04-10 | `#demo`와 `#get` 사이 `#screens`, 딱지·세 장·캡션 | ✓ VERIFIED | 이번 실행: HEAD p4-shots·캡처 |
| 50 | 04-10 | 폰 테두리 값, `.rp-phone` 재사용 없음 | ✓ VERIFIED | 이번 실행: `class="rp-phone"` 1줄. 구간 줄은 9506236 이후 변경 0 |
| 51 | 04-10 | 1280 한 줄, 375 scroll-snap·→키·끝 여백·가로 밀림 없음 | ✓ VERIFIED | 이번 실행: 두 엔진 `OK strip … arrow=0->276 end-gap=20` |
| 52 | 04-10 | 「지도 © NAVER Corp.」가 가려지지 않음, 제휴 오인 문구 없음 | ✓ VERIFIED | 이번 실행: credit-gap 38.4/28, p4-shots (f) 통과 |
| 53 | 04-10 | 같은 도메인 이미지, srcset 등 속성, sha256 같음 | ✓ VERIFIED | 이번 실행: 출력 `/images/app/screen-*` 6경로, `src=564,564,564`, 저장소와 바이트 같음 |
| 54 | 04-10 | CAND3 범위·지운 줄 하나 | ✓ VERIFIED | 기록 (커밋 고정) |
| 55 | 04-10 | 후보 p4-shots·p4-behave 통과 | ✓ VERIFIED | 기록 SHOTS_OK. HEAD에서도 PASS |
| 56 | 04-10 | CAND3가 어떤 ref에도 없음 | ✓ VERIFIED | 이번 실행: `git cat-file -t 56fd3bb79160` = commit, `git for-each-ref --contains` 빈 출력 |
| 57 | 04-11 | C3 부모·트리·범위 | ✓ VERIFIED | git: `9506236` WebP 6개 + `index.html` |
| 58 | 04-11 | 승인 전 ref에 없었고 푸시 뒤 main에 들임, 이력 수정 없음 | ✓ VERIFIED | git: merge 0. 승인은 04-UAT.md 6번 (7) |
| 59 | 04-11 | 배포 뒤 4 URL 200, 라이브 `/`가 C3 빌드와 바이트 같음 | ✓ VERIFIED | 기록 + 이전 검증의 `9506236` 빌드 = origin/main 빌드. 이번 실행: 라이브 `/` = origin/main 빌드 `cmp` 같음 |
| 60 | 04-11 | 라이브 WebP 6개 200·`image/webp`·바이트 같음 | ✓ VERIFIED | 기록 + 이전 검증 6개 확인. 이번 실행은 `screen-badge-846.webp` 하나만 200·`image/webp` 확인 |
| 61 | 04-11 | 라이브 p4-shots PASS | ✓ VERIFIED | 기록 (LIVE_PUSH3, 04-13 SC2). 라이브 = origin/main이고 HEAD에서도 PASS |
| 62 | 04-11 | 라이브 p4-behave PASS | ✓ VERIFIED | 기록. HEAD에서도 PASS |
| 63 | 04-12 | CONVENTIONS·ARCHITECTURE·STACK이 구간·WebP 예외·도구를 적음 | ✓ VERIFIED | 이번 실행: `images/app` CONVENTIONS 2·ARCHITECTURE 3·STACK 1 |
| 64 | 04-12 | STRUCTURE에 `images/app/`, INTEGRATIONS에 NAVER 지도 출처 | ✓ VERIFIED | 이번 실행: STRUCTURE 1, INTEGRATIONS `NAVER` 1 |
| 65 | 04-12 | 루트 CLAUDE.md Pages 표·SVG 예외·지도 출처·Assets | ✓ VERIFIED | 이번 실행: 루트 CLAUDE.md `images/app` 2, 해당 문단 있음 |
| 66 | 04-12 | `.claude/CLAUDE.md` 재생성과 바이트 같음, 방침 구간 같음 | ✓ VERIFIED | #38과 같은 확인 (이번 실행) |
| 67 | 04-12 | 옛 문장 없음 | ✓ VERIFIED | 이번 실행: 「외부 이미지가 없」「모든 그림은 SVG」「실제 지도를 쓰게 되면」이 CLAUDE.md·.claude/CLAUDE.md·README·원본 맵 전체에서 0 |
| 68 | 04-13 | D-24 문서 푸시는 승인 뒤, 범위 파일 둘 | ✓ VERIFIED | 범위는 git, 승인은 04-UAT.md 6번 (8) |
| 69 | 04-13 | 문서 푸시가 출력을 바꾸지 않음 | ✓ VERIFIED | 이전 검증 `9506236` 빌드 = origin/main 빌드 (`diff -r` 빈 출력) |
| 70 | 04-13 | 4 URL 200·기대 제목, `/CLAUDE.md` 404 | ✓ VERIFIED | 이번 실행 |
| 71 | 04-13 | 단계 끝 판정표 SC1~SC3 OK | ✓ VERIFIED | EVIDENCE 968~970행 `SC[123] OK`, 1003행 `PHASE4_SC=OK` |

**Score:** 74/74 truths verified (ROADMAP 3 + PLAN 71. VERIFIED 73 + PASSED (override) 1. FAILED 0. UNCERTAIN 0. 동작 미검증 0)

동작에 달린 truth(SC3의 고정·7초 데모·움직임 줄이기, 띠의 키보드 밀기)는 모두 이번에 HEAD 빌드에서 판정 스크립트를 직접 돌려 확인했습니다. 그래서 `behavior_unverified`는 0입니다.

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `index.html` | 정정된 메타·OG·3단계 글, 컬러 뱃지, `#screens` 구간 | ✓ VERIFIED | HEAD 빌드에 반영, 판정 스크립트 통과. 라이브는 origin/main 트리이고 그 트리도 목표 충족 |
| `images/app/screen-{draw,run,badge}-{564,846}.webp` | 앱 화면 캡처 6개 | ✓ VERIFIED | `srcset`에 연결, sha256 = EVIDENCE `IMG` 줄 |
| `scripts/check-site.sh` | 6번 항목 | ✓ VERIFIED | HEAD 통과, BASE 실패(「5곳」, exit 1), `abdeb52` 통과. pre-push 훅이 부름 |
| `CLAUDE.md`, `.claude/CLAUDE.md` | D-23 행, D-24 문서, `<head>` 순서(IN-09) | ✓ VERIFIED | 방침 구간 같음, 생성 구간 재생성과 바이트 같음. `<head>` 설명(include → `rp-pin` 스크립트 → `<style>`)이 `index.html` 21·22·26행 순서와 같음 |
| `.planning/baseline/USER-TASKS.md` | 작업 10 | ✓ VERIFIED | `verify.artifacts` 통과 |
| `04-EVIDENCE.md` | 판정 기록과 표식 | ✓ VERIFIED | `verify.artifacts` 13개 계획 모두 exit 0 (이번 실행) |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `index.html` `srcset` | `images/app/*.webp` | 같은 도메인 경로 | ✓ WIRED | 이번 실행 p4-shots `src=564,564,564`. 04-11 `verify.key-links` exit 0 |
| `.rp-shots-sec` | `.rp-get` 음수 margin | CSS 맞물림 | ✓ WIRED | credit-gap 양수 |
| `.githooks/pre-push` | `scripts/check-site.sh` | 훅 | ✓ WIRED | 04-05·04-06·04-08 `verify.key-links` exit 0 |
| `.planning/codebase/CONVENTIONS.md` | `.claude/CLAUDE.md` | generate-claude-md | ✓ WIRED | 재생성과 바이트 같음, 음성 대조로 생성기가 반영함을 확인 |
| `04-EVIDENCE.md` | `index.html` / ROADMAP (04-02·04-09·04-10·04-13) | `^BASE_SHA=` 등 줄머리 앵커 | ✓ WIRED (수동) | `verify.key-links`가 이 네 개를 exit 1로 냅니다. 도구가 줄머리 앵커를 여러 줄 모드 없이 대조해서 생기는 거짓 음성입니다. 이번에 `grep -n -E`로 다시 확인했고, 25행(`BASE_SHA`)·578·580·582행(`IMG … 846`)·615행(`CAND3`)·968~970행(`SC[123] OK`)에서 줄머리부터 있습니다. 나머지 9개 계획 링크는 도구 exit 0 |

### Data-Flow Trace (Level 4)

해당 없음. 정적 사이트이고 새 구간의 데이터는 정적 WebP와 마크업 글입니다. 이미지 로드는 p4-shots `imgs=3`(complete·naturalWidth>0)으로 확인했습니다.

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| 푸시 전 점검 (HEAD) | `scripts/check-site.sh` | `통과 (작업 트리, jekyll 3.10.0)` | ✓ PASS |
| 6번 항목 양성 (문구 커밋) | `scripts/check-site.sh abdeb52` | 통과 | ✓ PASS |
| 6번 항목 음성 대조 (BASE) | `scripts/check-site.sh 0e75e8b88fd2` | `/index.html 5곳`, exit 1 | ✓ PASS |
| 빌드 출력 세 낱말 | HEAD production `--safe` 빌드 후 `grep -c` | index 0, 법적 6/6/3 (Phase 6~8 범위, BASE와 바이트 같음) | ✓ PASS |
| SC3 동작 (HEAD) | `node p4-behave.mjs http://127.0.0.1:4212` | `PASS behave` (6 문맥) | ✓ PASS |
| SC2 구간 (HEAD) | `node p4-shots.mjs http://127.0.0.1:4212 $W/cap/v3head` | `PASS shots` (두 엔진 × 375·1280) | ✓ PASS |
| `.claude/CLAUDE.md` 재생성 | 스크래치에서 `generate-claude-md` 후 `cmp` | 같음. 옛 CONVENTIONS로는 두 줄 다름 | ✓ PASS |
| 라이브 = origin/main | `curl`(캐시 우회) + `cmp` | `/` 바이트 같음, 4 URL 200·기대 제목, 내부 파일 3개 404, WebP 200 `image/webp` | ✓ PASS |

판정 스크립트는 저장소 밖 스크래치(`$TMPDIR/rp-p4/pw`)에 있는 이 단계의 정식 판정 도구입니다. Step 7b는 서버를 띄우지 말라고 하지만, 이 단계가 정한 판정 방법이 「빌드 출력을 loopback에 띄워 Playwright로 본다」라서 그대로 따랐습니다. 저장소와 라이브는 바꾸지 않았고, 서버(포트 4212)는 판정 뒤 끝냈습니다.

### Probe Execution

해당 없음. 저장소에 `scripts/*/tests/probe-*.sh`가 없고 계획에서 정한 probe도 없습니다.

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| SITE-01 | 04-02~08, 04-13 | 소개 문구·메타 설명·OG에서 출시 앱에 없는 기능(포인트·굿즈·코스북)이 보이지 않음 | ✓ SATISFIED | SC1 (HEAD·라이브). check-site 6번 항목이 다시 들어오는 것을 막음 |
| SITE-06 | 04-01, 04-02, 04-09~13 | 실제 앱 화면(스크린샷)과 출시 전 표시(현재 「출시 준비 중」) | ✓ SATISFIED | SC2 (HEAD 판정 + 캡처 직접 확인). 디자인·실기기·낭독기 확인은 04-UAT.md 2~4번 pass |

REQUIREMENTS.md에서 Phase 4에 걸린 ID는 SITE-01·SITE-06 둘뿐입니다 (29·34행 정의, 166·171행 Traceability). 13개 계획의 `requirements:`를 모두 뽑아 보니 SITE-01·SITE-06 말고 다른 ID를 선언한 계획은 없습니다 (SITE-01: 04-02~08·04-13, SITE-06: 04-01·04-02·04-09~13). 빠진(ORPHANED) 요구 사항은 없습니다.

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `scripts/check-site.sh` | 42 | `XXX` (`mktemp … rp-check.XXXXXX`) | ℹ️ Info | mktemp 템플릿이고 부채 표시가 아님 |
| `index.html` | 379 (관련 286, 479) | 같은 강아지런 코스를 「달려 보기」 칩은 `7.84 km`, 「코스 그리기」 목업은 `7.8 km`로 표기 (REVIEW WR-04, open) | ⚠️ Warning | 아래 경고 2번 |
| `scripts/check-site.sh` | 97~99 | `U10_ALLOW_PREFIX`에 `.*`·`^`·`$`·`.` 같은 메타문자를 넣으면 오류 없이 6번 항목이 약해지거나 통과 (REVIEW IN-11, open) | ℹ️ Info | 지금 값 `체크\|엔드`는 정상. 사람이 값을 잘못 고칠 때만 생김 |
| `scripts/check-site.sh` | 101~103 | 랜딩 출력이 없을 때 6번 항목이 grep 종료 코드 2로 실패를 한 번 더 셈 (REVIEW IN-12, open) | ℹ️ Info | 실패 자체는 맞게 남. 메시지만 오해 소지 |
| `index.html`·`CLAUDE.md`·`.claude/CLAUDE.md`·`CONVENTIONS.md` | — | TODO·FIXME·TBD·placeholder·「추후 기재」 | — | 0건 (`.claude/CLAUDE.md` 24행 「추후 기재」는 금지 규칙 문장) |
| `.planning/codebase/CONCERNS.md`·`TESTING.md` | 여러 줄 | 줄 수·검증 대상 목록이 구간 추가 전 값 (`deferred-items.md` open 2건) | ℹ️ Info | 문서 드리프트. 사이트 동작과 무관 |

### 경고 (WARNING)

1. **HEAD의 42커밋(대부분 문서 커밋, 사이트 파일을 바꾼 커밋 포함)이 아직 푸시되지 않았습니다.**
   - 라이브(origin/main `9cc1490`)의 목업은 아직 「댕댕런」, `8.3 km`, `111분·71분·33분`을 보여 줍니다. 같은 페이지의 앱 캡처 ③은 「강아지런」·`7.84 km`입니다.
   - `git diff 9cc1490 HEAD -- index.html`은 이 목업 글, 대체 글, `KM` 상수, 주석만 바꿉니다 (16/16줄). 구간·뱃지·메타 줄 변경은 0입니다.
   - 단계 목표를 깨지 않는 목업 숫자·이름 문제라서 gap이 아니라 경고로 둡니다. 푸시는 CLAUDE.md 「푸시 절차」대로 사용자 승인 뒤에 합니다.
2. **WR-04: 같은 페이지 안의 코스 거리 표기 불일치 (open).**
   - `index.html:379` 「달려 보기」 코스 칩은 `7.84 km`, `:286` 「코스 그리기」 목업은 `7.8 km`입니다. 이번에 grep으로 재현했습니다.
   - 리뷰는 칩을 앱의 코스 표기(`formatCourseDistance`, 소수 한 자리)에 맞춰 `7.8 km`로 고치자고 제안합니다. `KM`(측정 거리 7.84)과 결과 화면은 그대로 두자고 합니다.
   - 검증자는 값을 채우지 않았습니다. 푸시 전에 고칠지(fixed), 그대로 둘지(skipped)를 `04-REVIEW-DISPOSITION.md`에 정하면 됩니다.
3. **③ 캡처의 NAVER 로고 덮임 (사용자 예외).** 앱의 뱃지 창이 로고를 덮은 원본 장면입니다. 사용자가 위험을 알고 받아들였고(04-CONTEXT D-20), override 문구는 04-UAT.md 7번에서 확인됐습니다.
4. **`verify.key-links` 거짓 음성 4건.** 줄머리 앵커 패턴에서 생깁니다. 이번에 수동으로 모두 연결을 확인했습니다.

이전 보고서의 경고 WR-02(목업 예상 시간)와 WR-03(점검 fail-open)은 `215fa7e`·`8cc86fd`로 고쳐졌습니다. WR-03 수정 뒤에도 6번 항목은 BASE를 「5곳」으로 막고 HEAD를 통과시킵니다 (이번 실행).

### 금지 항목 (prohibitions, judgment 등급)

13개 계획 frontmatter에서 `must_haves.prohibitions`를 다시 뽑았습니다.

- 금지 항목은 53개입니다 (계획별 3·4·4·4·4·3·3·3·4·9·5·4·3).
- 모두 `verification: judgment`, `status: resolved`입니다. test 등급은 0개입니다.

아래는 검증자(LLM)의 **비권위 판정**입니다 (`unverified-prohibition — human review recommended`).

- 이전 판정은 04-UAT.md 8번에서 pass로 기록됐습니다.
- 그 기록은 사용자 요청으로 에이전트가 다시 확인한 것이라, 사람이 직접 판정한 것을 대신하지는 않습니다.
- 이번 검증은 그 뒤 수정 커밋 4개가 금지 항목에 닿는지만 봤습니다.

| 묶음 | 이번 판정 | 근거 |
|------|-----------|------|
| 사이트 파일 범위 (`_includes`·`_layouts`·법적 3종·`.githooks`) | 지켜짐 | `9cc1490..HEAD` diff는 `index.html`만 바꿈. 법적 3종 출력 BASE와 바이트 같음 |
| 스크립트 계약 (스크립트 추가·계약 이름 변경 금지) | 지켜짐 | `<script>` 블록 2개 그대로. 스크립트가 찾는 `byId`·`querySelector` 대상이 라이브 트리와 같음. 이번 수정 커밋은 스크립트 블록 밖 `<span>` 글 두 줄만 바꿈 |
| title·og:title 그대로 | 지켜짐 | HEAD 빌드 8·13행 |
| 새 hex | 지켜짐 | `e550ecf..HEAD`의 `index.html` 변경은 숫자 글뿐 |
| 이력 수정·merge 금지 | 지켜짐 | `git rev-list --merges --count origin/main..HEAD` = 0 |
| `.claude/CLAUDE.md` 생성 구간 손 편집 금지 | 지켜짐 | 재생성 결과와 바이트 같음 (IN-09는 원본 CONVENTIONS를 고친 뒤 재생성) |
| 사용자 사실값·출시 시기·자리표시 금지 | 지켜짐 | 수정 커밋에 이메일·사업자 정보·날짜 없음. 목업 숫자는 리뷰가 앱 저장소 코드에서 근거를 적음 |

### Human Verification Required

frontmatter `human_verification`에 8건을 다시 적었습니다.

- 출처는 이 단계 계획의 `<human-check>` 세 개(04-04 뱃지 색, 04-10 구간 화면, 04-11 실기기 Safari)와 이전 보고서의 사람 확인 항목입니다.
- 문구는 이전 보고서와 글자까지 같게 두었습니다. 그래야 `04-UAT.md`에 합칠 때 기존 행과 맞고 새 행이 생기지 않습니다.

**8건 모두 이미 `04-UAT.md`에 결과가 있습니다** (status complete, passed 8, issues 0).

- 그 UAT는 라이브(`9cc1490`)에서 했습니다.
- `git diff 9cc1490 HEAD -- index.html`에서 `screens`·`rp-shot`·`images/app`·`NAVER`·meta·OG·뱃지 색·「보관함」·「출시 준비 중」 줄의 변경은 0입니다. 그래서 결과가 HEAD에도 이어진다고 판단합니다.

이번 수정 커밋이 바꾼 목업 숫자(7.8 km, 104·67·31분)에는 새 사람 확인 항목을 만들지 않았습니다. 리뷰가 앱 저장소의 계산식으로 근거를 확인했고, 남은 표기 불일치(WR-04)는 `04-REVIEW-DISPOSITION.md`에서 open으로 추적합니다.

### Gaps Summary

막는 공백(BLOCKER)은 없습니다.

- ROADMAP 성공 기준 1~3을 HEAD 운영 동일 빌드에서 직접 다시 돌렸고 모두 통과했습니다.
- 라이브(origin/main `9cc1490`)도 세 낱말 0, 4 URL 정상, 이미지 정상입니다.
- 요구 사항 SITE-01·SITE-06을 충족했습니다.
- 상태가 `human_needed`인 것은 절차상 사람 확인 항목을 다시 적었기 때문입니다. 그 항목들은 UAT에서 모두 pass입니다.

**남은 일 (gap 아님):**

- HEAD의 42커밋이 아직 푸시되지 않았습니다 (리뷰 수정으로 사이트 파일을 바꾼 커밋 포함). 푸시는 사용자 승인 뒤에 합니다.
- 푸시하기 전에 WR-04(「달려 보기」 칩 `7.84 km`)를 고칠지 정합니다.
- IN-11·IN-12는 점검 스크립트 견고성 문제라 다음 점검 스크립트 수정 때 고치면 됩니다.

---

_Verified: 2026-11-18T14:22:29Z_
_Verifier: Claude (gsd-verifier)_
