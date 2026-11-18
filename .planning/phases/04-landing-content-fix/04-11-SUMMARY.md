---
phase: 04-landing-content-fix
plan: 11
subsystem: content
tags: [site-06, screenshots, webp, push, live-check, github-pages]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "04-10: 판정한 후보 CAND3=56fd3bb79160(어떤 ref에도 없음), 스크래치 $W/pw/p4-shots.mjs·$W/c3 빌드·$W/cap/c3/ 구간 화면. 04-09: WebP 여섯 개와 IMG sha256 줄. 04-02: 스크래치 계약(lib.sh, pw, p4-behave.mjs, 배포 완료 확인·라이브 요청 규칙)"
provides:
  - "원격 main과 로컬 main에 스크린샷 구간 커밋 C3=95062367dc69 (index.html + images/app/ WebP 여섯 개, 부모 61bd06a7f90f, 사이트 트리 = CAND3)"
  - "라이브 https://runningpencil.com/ 의 「실제 앱 화면」 구간(#screens), 「출시 준비 중」 딱지, 캡처 세 장과 캡션, 「지도 © NAVER Corp.」"
  - "04-EVIDENCE.md `## 04-11 스크린샷 푸시 후보`(C3_SHA, PUSH3_CANDIDATE, PUSH3_PREV)와 `## 04-11 스크린샷 푸시 라이브 확인`(PUSH3_SHA, OK local main has C3 (ff), OK 빌드, OK HTTP 4줄, OK live index bytes = c3, OK IMG 6줄, PASS shots, PASS behave, LIVE_PUSH3=OK)"
affects: [04-12, 04-13]

# Actuals (#2632)
actuals:
  tokens: 3914     # chars/4 over C3의 index.html diff(6018자) + 04-EVIDENCE.md 더한 줄(9636자, 04-11 두 구간). WebP 바이너리와 SUMMARY 제외
  tasks: 3         # tracer 1, checkpoint:decision 1, auto 1
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). C3 하나(fast-forward). SUMMARY·EVIDENCE docs 커밋과 STATE·ROADMAP 커밋은 이 뒤
plan_head_before: 61bd06a7f90f49d9fd732dc85e00011b10da1468
plan_head_after: 95062367dc69d382af7c5027b193b90e117175d1

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "캡처를 담은 사이트 커밋은 임시 인덱스(GIT_INDEX_FILE) + git commit-tree로 브랜치 밖 객체로 만들고, 사용자 승인 뒤 `<sha>:refs/heads/main`으로 푸시한 다음에만 로컬 main에 fast-forward로 들인다"

key-files:
  created:
    - images/app/screen-draw-564.webp
    - images/app/screen-draw-846.webp
    - images/app/screen-run-564.webp
    - images/app/screen-run-846.webp
    - images/app/screen-badge-564.webp
    - images/app/screen-badge-846.webp
    - .planning/phases/04-landing-content-fix/04-11-SUMMARY.md
  modified:
    - index.html
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md

key-decisions:
  - "04-11: 사용자가 PUSH3_CANDIDATE=95062367dc69를 이름으로 적은 질문에 push로 답했고, 그 SHA 하나만 훅을 켠 채 한 번 푸시했다(6e46bdc..9506236). 로컬 main은 푸시 성공 뒤 HEAD가 아직 C3의 부모라 fast-forward로 들였다"
  - "04-11: Chromium 375 끝 캡처(*-375-end.png)에 badge가 보이지 않는 것은 Playwright 요소 캡처가 Chromium에서만 scrollLeft를 477에서 170으로 옮기는 부작용이다(사이트 결함 아님). 캡처 전에 잰 `end-gap=20` 줄로 판정하고 p4-shots.mjs는 고치지 않았다. 04-10 REVIEW 줄은 고치지 않고 EVIDENCE 04-11 구간의 정정 줄로 남겼다"

patterns-established:
  - "푸시 계획의 라이브 판정은 로컬 후보 판정과 같은 스크립트·같은 숫자(credit-gap, arrow, end-gap, hash top)로 대조한다"

requirements-completed: [SITE-06]  # PLAN requirements를 그대로 옮김. REQUIREMENTS.md 체크는 requirements.ready-ids가 SITE-06을 blocked로 내어(04-12·04-13도 선언) Pending으로 둠

coverage:
  - id: D1
    description: "승인받은 SHA 95062367dc69만 원격 main에 푸시했고(훅 통과, force·--no-verify 없음), 푸시 성공 뒤에만 로컬 main에 fast-forward로 들였다. 범위의 사이트 커밋은 C3 하나, .planning/ 밖 파일은 일곱 개"
    requirement: "SITE-06"
    verification:
      - kind: automated
        ref: "04-11-PLAN.md Task 1 <automated> 재실행 exit 0, Task 3 첫 <automated> exit 0"
        status: pass
    human_judgment: false
  - id: D2
    description: "Pages 빌드가 C3로 built·오류 없음, 네 URL 200·기대 제목, 라이브 `/`가 로컬 C3 빌드와 바이트 같음, WebP 여섯 개 200·image/webp·바이트 같음"
    requirement: "SITE-06"
    verification:
      - kind: automated
        ref: "04-11-PLAN.md Task 3 두 번째 <automated> exit 0 (gh api pages/builds 대조 n=1)"
        status: pass
    human_judgment: false
  - id: D3
    description: "라이브에서 「실제 앱 화면」 구간이 Chromium·WebKit × 1280·375로 판정 (a)~(l) 통과(PASS shots), 기존 동작 PASS behave(성공 기준 2·3)"
    requirement: "SITE-06"
    verification:
      - kind: automated_ui
        ref: "04-EVIDENCE.md `## 04-11 스크린샷 푸시 라이브 확인` PASS shots, PASS behave, hash-only PASS shots"
        status: pass
    human_judgment: false
  - id: D4
    description: "실기기 iPhone Safari에서 구간의 터치 가로 밀기, 캡처 속 내용(NAVER 로고 온전, 개인 정보·하단 탭·Dev 없음)"
    requirement: "SITE-06"
    verification:
      - kind: other
        ref: "04-11-PLAN.md Task 3 <human-check> (단계 끝 UAT)"
        status: pending
    human_judgment: true
    rationale: "실기기 Safari의 터치 스크롤과 화면 속 내용은 Playwright 에뮬레이션으로 확인할 수 없다"

# Metrics
duration: 21min
completed: 2026-11-18
---

# Phase 4 Plan 11: 스크린샷 구간 푸시와 라이브 확인 Summary

**사용자가 승인한 스크린샷 구간 커밋 `95062367dc69` 하나를 원격 main에 푸시했고, 라이브 `/`가 로컬 빌드와 바이트가 같으며 WebP 여섯 개가 `image/webp`로 나가고, 두 엔진 × 두 폭 구간 판정과 기존 동작 판정이 모두 통과했다 (`LIVE_PUSH3=OK`).**

04-10에서 판정한 후보 `CAND3`와 사이트 트리가 같은 커밋 C3를 HEAD 위에 브랜치 밖 객체로 만들어 실제 pre-push 훅을 통과시킨 뒤(Task 1), 사용자가 캡처 검토 목록과 구간 화면을 보고 그 SHA를 승인했다(Task 2). Task 3은 푸시 직전 원격·로컬·ref 상태를 다시 확인하고 그 SHA만 푸시했다.

## Performance

- **Duration:** 약 21분 (Task 2 승인 대기 포함)
- **Started:** 2026-11-18T06:23Z
- **Completed:** 2026-11-18T06:44Z
- **Tasks:** 3 (tracer 1, checkpoint:decision 1, auto 1)
- **Files modified:** 사이트 7 (`index.html`과 WebP 여섯 개, 모두 C3 안), 기록 2 (`04-EVIDENCE.md`, 이 SUMMARY)

## Accomplishments

- 푸시 전 다시 확인: 스크래치가 모두 있어 다시 만든 것이 없고, `origin/main`은 `PUSH3_PREV=6e46bdcb24e0` 그대로, HEAD는 C3의 부모 그대로, C3는 어떤 ref에도 없었다
- `git push origin "${C3}:refs/heads/main"` 한 번, 훅 `check-site: 통과 (커밋 95062367dc69)`, `6e46bdc..9506236 -> main`
- 로컬 main은 푸시 성공 뒤 `git merge --ff-only`로 C3를 들였다 (`OK local main has C3 (ff)`). 고치지 않은 `.planning/` 파일은 그대로
- Pages 빌드 `OK 빌드 95062367dc69 built 2026-11-18T06:41:14Z` (두 번째 읽기)
- 네 URL 200·기대 제목, 라이브 `/`와 법적 세 문서가 로컬 C3 빌드와 바이트 같음
- WebP 여섯 개 `200 image/webp`·저장소와 바이트 같음 (RESEARCH A10 확인)
- 라이브 `PASS shots`(숫자가 04-10 후보 판정과 모두 같음), 새 문맥 해시 정착 chromium -0.4·webkit 0.5px, `PASS behave` 6문맥

## Task Commits

1. **Task 1: C3를 브랜치 밖 객체로 만들고 실제 푸시 경로로 통과** - 커밋 없음 (계획 규칙: C3는 승인 전 어떤 ref에도 두지 않음, EVIDENCE는 계획 끝 docs 커밋)
2. **Task 2: 사용자 승인 (push)** - 커밋 없음
3. **Task 3: 승인받은 SHA 푸시, 로컬 main에 fast-forward, 라이브 확인** - `9506236` (feat: C3 자체가 fast-forward로 main에 들어옴)

**Plan metadata:** 이 SUMMARY와 EVIDENCE를 담은 docs 커밋, 그 뒤 STATE·ROADMAP 커밋. 둘 다 로컬에만 두고 04-13 문서 푸시 때 함께 나간다

## Files Created/Modified

- `index.html` - 「실제 앱 화면」 구간 마크업과 「랜딩 전용」 CSS (C3)
- `images/app/screen-{draw,run,badge}-{564,846}.webp` - 캡처 여섯 개 (C3)
- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` - `## 04-11 스크린샷 푸시 후보`, `## 04-11 스크린샷 푸시 라이브 확인`
- `.planning/phases/04-landing-content-fix/04-11-SUMMARY.md` - 이 요약

## Decisions Made

- HEAD가 C3의 부모 그대로라 merge 커밋 없이 fast-forward로 들였다
- 라이브 해시 정착 (k)도 04-10과 같은 까닭으로 `--hash-only` 새 문맥에서 한 번 더 쟀다 (판정 항목 추가 아님, 기록 보강)

## Deviations from Plan

### 기록 정정 (오케스트레이터 지시)

**1. [Rule 1 - Bug, 기록] 04-10 `REVIEW shots chromium 375` 줄의 end 화면 서술 정정**
- **Found during:** Task 2 승인 검토 (오케스트레이터), Task 3 라이브 캡처에서 같은 모양 재확인
- **Issue:** 04-10 검토 줄은 Chromium 375 끝 화면에서 badge가 온전히 보인다고 적었지만, `chromium-375-end.png`(후보·라이브 둘 다)는 run 장이 띠 가운데에 있고 badge가 보이지 않는다
- **Cause:** 오케스트레이터가 후보 빌드를 따로 재 본 결과, `scrollLeft = scrollWidth` 뒤 띠는 최댓값 477에 서고 badge 장이 x 95~355로 온전히 보이며 창 전체 캡처도 그 자리를 유지한다. Playwright의 요소 캡처(`locator('#screens').screenshot()`)만 Chromium에서 캡처 순간 scrollLeft를 170으로 옮긴다. → 키 세 번·가로 휠은 두 엔진 모두 477에 닿고, WebKit 요소 캡처는 옮기지 않는다
- **Fix:** 사이트 결함이 아니므로 사이트와 `p4-shots.mjs`는 고치지 않았다. 판정은 캡처 전에 잰 `OK strip chromium 375 arrow=0->276 end-gap=20` 줄로 한다. EVIDENCE 04-11 라이브 구간에 정정 문단과 `NOTE chromium 375 end image = element-screenshot artifact …` 줄을 적었다(스크래치 경로 없음). 04-10 검토 줄 자체는 고치지 않았다
- **Files modified:** `04-EVIDENCE.md`, 이 SUMMARY

---

**Total deviations:** 1 (기록 정정). **Impact on plan:** 판정 결과와 푸시한 사이트는 바뀌지 않았다.

## Issues Encountered

None. 되돌리기 절차는 쓰지 않았다(FAIL 없음). 누출 검사: `04-EVIDENCE.md`와 이 SUMMARY에 계획 verification의 누출 검사 대상(홈 폴더 변수 이름, macOS 임시 폴더·홈 폴더 경로, 캡처 원본 위치)이 없다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 단계 끝 사람 확인(UAT): 실기기 iPhone Safari에서 https://runningpencil.com/ 의 「실제 앱 화면」 구간을 연다. 딱지·세 장·캡션·「지도 © NAVER Corp.」가 보이고, 세 장을 손가락으로 가로로 밀 수 있으며 페이지 전체는 옆으로 밀리지 않고, NAVER 로고가 온전하고 개인 정보·하단 탭·Dev 표시가 없어야 한다
- 이 계획의 docs 커밋들은 로컬에만 있다. 04-13 문서 푸시가 따로 승인받아 함께 내보낸다
- SITE-06은 04-12·04-13도 선언해 REQUIREMENTS.md에서 Pending으로 둔다

---
*Phase: 04-landing-content-fix*
*Completed: 2026-11-18*

## Self-Check: PASSED

- FOUND: `images/app/` WebP 여섯 개, `index.html`의 `id="screens"` (HEAD = C3)
- FOUND: `9506236` (`git merge-base --is-ancestor` HEAD·origin/main 둘 다 참)
- FOUND: `04-EVIDENCE.md`의 `PUSH3_SHA=95062367dc69`, `LIVE_PUSH3=OK`
- Task 1 verify, Task 3 verify 두 명령 exit 0 (기록 고침 docs 커밋 뒤 마지막 HEAD에서 다시 실행)
