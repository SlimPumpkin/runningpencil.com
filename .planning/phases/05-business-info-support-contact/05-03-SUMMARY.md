---
phase: 05-business-info-support-contact
plan: 03
subsystem: ui
tags: [footer, render-if-present, jekyll, liquid, css, playwright, inline-block]
status: complete

# Dependency graph
requires:
  - phase: 05-business-info-support-contact
    provides: "05-01의 BASE_SHA=2db88d9a199f·기준 빌드 $W/base·도구 $W/pw/p5-foot.mjs, 05-02의 PROTO_DATA_BLOB·PROTO_FOOTER_BLOB·가짜 값 $W/yml/all.yml"
provides:
  - "M1 bc934fb9555e: 빈 사실값 슬롯 `_data/company.yml`(키 여섯 개 모두 \"\")과 `_includes/footer.html` render-if-present 템플릿(`.size > 0`, 구분 기호 `&nbsp;· `). 기준과 출력 바이트 동일"
  - "M2 b7e2dcd0de13: 「공통」 CSS 두 줄 `.rp-foot-legal span { display: inline-block; }`·`.rp-foot-legal a { color: #FAFAF7; text-decoration: underline; }`. 출력 차이는 네 문서 `<style>` 안 두 줄뿐"
  - "05-EVIDENCE.md 표식 M1_SHA·M1_SAME=OK·M2_SHA·M2_HUNKS=OK·FOOT_LAYOUT=OK, 구간 `## 05-03 M1`·`## 05-03 M2`·`## (보류 1) 05-03 화면`·`## 05-03 화면`"
  - "고친 스크래치 도구 $W/pw/p5-foot.mjs: 줄보다 긴 항목 하나의 상자 안 줄바꿈을 `NOTE … longItem` 정보 줄로 돌리는 예외 (OK/FAIL 줄 모양 불변)"
affects: [05-04, 05-05, 05-06, 05-08, 05-11, 05-12]

# Actuals (#2632)
actuals:
  tokens: 5623     # chars/4 over 계획 동안 더한 줄(22491자: M1·M2 사이트 파일 2280자, 05-EVIDENCE.md 세 구간, 계획 문서 보정). 이 SUMMARY 제외
  tasks: 3
  commits: 4       # 측정값: git rev-list --count plan_head_before..HEAD (M1, M2, 보류 기록, 판정 보정 문서 커밋). 이 SUMMARY와 STATE 커밋은 뒤에 더해진다
plan_head_before: 6ae52ea4eb18f61a60c59aa9b25f0c823379c52b
plan_head_after: 3bfc1cbe11282be34b1e1bf5bebdfb3a6fc7ac15

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "사실값 슬롯 `_data/company.yml`과 푸터 템플릿의 존재 판정은 `site.data.company.<키>.size > 0` 하나이고 출력은 `| escape`"
    - "리팩터(M1 슬롯·템플릿, 출력 불변)와 시각(M2 CSS 두 줄)을 다른 커밋으로 나눠, 값 커밋(M4)의 출력 차이가 값 줄뿐이게 한다"
    - "푸터 항목은 `inline-block` span이라 항목 단위로 줄을 바꾸고, 줄보다 긴 항목 하나만 자기 상자 안에서 줄을 바꾼다 (p5-foot.mjs `NOTE … longItem`)"

key-files:
  created:
    - _data/company.yml
    - .planning/phases/05-business-info-support-contact/05-03-SUMMARY.md
  modified:
    - _includes/footer.html
    - _includes/css/common.css
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md
    - .planning/phases/05-business-info-support-contact/05-01-PLAN.md
    - .planning/phases/05-business-info-support-contact/05-03-PLAN.md
    - .planning/phases/05-business-info-support-contact/05-VALIDATION.md

key-decisions:
  - "split 판정 보정 (2026-11-19 사용자 결정): 여러 줄에 걸친 span은 언제나 split이고, 상자가 하나인 span은 줄바꿈 없는 폭이 p 줄 폭 + 1px보다 길 때만 상자 안 줄바꿈을 허용해 `NOTE … longItem` 정보 줄로 남긴다. 시험 값 all.yml은 그대로 두고 도구·05-01 사양·05-03 Task 3·05-VALIDATION을 함께 고쳤다"
  - "보류 규칙 예외 (사용자 승인): 05-01 「다음 실행은 Task 1부터」를 이번 재개에 적용하지 않고 Task 3만 다시 했다. M1이 이미 `main`에 있어 Task 1 전제(`_data` 없음)가 참이 아니고 이력 수정은 금지다"
  - "M1·M2 표식은 `HOLD1_` 머리 없이 그대로 둔다 (사용자 결정). M1·M2 커밋과 보류 1 구간은 고치지 않았다"
  - "D-07(05-CONTEXT.md)은 한 줄에 들어가는 항목에는 그대로 지켜지고, 줄보다 긴 항목 하나는 자기 상자 안에서 줄을 바꾼다(사용자 승인한 예외). 가로 넘침은 어느 경우에도 없다"
  - "BIZ-01·BIZ-02는 완료 처리하지 않았다. `requirements.ready-ids`가 둘 다 blocked(뒤 계획이 같은 ID를 선언)였고, 값은 05-05~05-06에서 들어간다"

patterns-established:
  - "p5-foot.mjs 출력의 `NOTE` 줄은 실패가 아니며 `OK`/`FAIL`/`PASS foot`/`FAIL foot` 줄과 종료 코드를 바꾸지 않는다. 뒤 계획은 마지막 줄 `PASS foot`만 보므로 영향이 없다"

requirements-completed: []

coverage:
  - id: D1
    description: "M1(빈 슬롯 + 푸터 템플릿)이 원형 blob과 같고, 그 빌드가 기준과 `diff -r` 빈 출력이다 (D-03 커밋 ①)"
    requirement: "BIZ-02"
    verification:
      - kind: other
        ref: "05-03-PLAN.md Task 1 <automated> verify (재개 뒤 다시 실행, exit 0) + acceptance 다섯 명령"
        status: pass
    human_judgment: false
  - id: D2
    description: "M2 CSS 두 줄의 출력 차이가 index.html `57a58,59`, 법적 3종 `47a48,49`뿐이고 hex 색 집합이 그대로다"
    verification:
      - kind: other
        ref: "05-03-PLAN.md Task 2 <automated> verify (exit 0) + acceptance 세 명령"
        status: pass
    human_judgment: false
  - id: D3
    description: "M2 + 가짜 값에서 Chromium·WebKit × 375·1280 × 네 문서 16줄 통과(PASS foot, 375px는 긴 상호 longItem NOTE), M1 + 가짜 값은 badLink와 375px 여러 줄 split으로 실패 (D-07, D-08)"
    requirement: "BIZ-01"
    verification:
      - kind: automated_ui
        ref: "05-03-PLAN.md Task 3 <automated> verify (보정 뒤, exit 0); $W/pw/p5-foot.mjs; 캡처 $W/cap/c2f/*.png"
        status: pass
    human_judgment: false
  - id: D4
    description: "실제 사업자 값이 들어온 푸터가 사업자등록증과 같은 표기이고 보기에 괜찮은지"
    requirement: "BIZ-01"
    verification: []
    human_judgment: true
    rationale: "값은 아직 없고(05-05에서 받음), 표기 대조와 구분 기호 모양은 05-05 D-10 checkpoint에서 사용자가 판단한다"

# Metrics
duration: 20min
completed: 2026-11-19
---

# Phase 5 Plan 03: 사업자 정보 슬롯·푸터 템플릿(M1)과 푸터 CSS(M2) Summary

**빈 사실값 슬롯 `_data/company.yml`과 `.size > 0` render-if-present 푸터 템플릿(M1, 출력 바이트 불변), 항목 단위 `inline-block` 줄바꿈과 `#FAFAF7` 밑줄 링크 CSS 두 줄(M2)을 `main`에 넣고, 가짜 값으로 두 엔진·두 폭 푸터 배치를 판정했다**

## Performance

- **Duration:** 약 20분 (첫 시도 11:34~11:42 KST, 재개 11:48~11:55 KST)
- **Started:** 2026-11-19T02:34:25Z
- **Completed:** 2026-11-19T02:55:00Z
- **Tasks:** 3 (Task 1·2는 첫 시도, Task 3은 보류 1 뒤 재개에서)
- **Files modified:** 사이트 3개(`_data/company.yml`, `_includes/footer.html`, `_includes/css/common.css`), 계획 문서 4개

## Accomplishments

- M1 `bc934fb9555e`: 원형 blob 그대로의 빈 슬롯과 푸터 템플릿. 기준 빌드와 `diff -r` 빈 출력(네 문서 바이트 동일)
- M2 `b7e2dcd0de13`: 「공통」 CSS 두 줄. 출력 차이는 `<style>` 안 두 줄(`57a58,59` / `47a48,49` × 3)뿐, 새 hex 색 없음
- 푸터 배치 판정 `FOOT_LAYOUT=OK`: M2 + 가짜 값은 16줄 통과(1280px sepLead=0, 375px sepLead=1 기록), M1 + 가짜 값은 `badLink` 32곳 중 16곳·375px `split lines=2`로 실패(음성 대조)
- `p5-foot.mjs` split 판정을 사용자 결정대로 보정하고, 기준 빌드에서 회귀 없음(16줄 `rows=3 spans=0 … sepLead=0`, `PASS foot`, 05-01 Task 3 verify 두 명령 exit 0)

## Task Commits

1. **Task 1: 원형 슬롯·푸터 M1** - `bc934fb` (refactor)
2. **Task 2: 「공통」 CSS 두 줄 M2** - `b7e2dcd` (style)
3. **(보류 1 기록)** - `e8b8364` (docs(05): 긴 가짜 상호가 375px 줄보다 길어 split 실패)
4. **(판정 보정, 사용자 결정)** - `3bfc1cb` (docs(05): 05-01 도구 사양·05-03 Task 3·05-VALIDATION)
5. **Task 3: 두 엔진·두 폭 측정** - 기록 전용, 이 SUMMARY와 같은 docs(05-03) 커밋

**Plan metadata:** 이 SUMMARY 커밋과 STATE/ROADMAP 커밋 (docs(05-03))

## Files Created/Modified

- `_data/company.yml` - 사실값 슬롯(상호·대표자·사업자등록번호·주소·지원 이메일·전화, 모두 빈 값, 머리 주석에 규칙)
- `_includes/footer.html` - 사업자 줄 span 세 개, 주소 줄, 이메일/전화 줄의 render-if-present 템플릿
- `_includes/css/common.css` - `.rp-foot-legal span`·`.rp-foot-legal a` 두 규칙
- `05-EVIDENCE.md` - `## 05-03 M1`, `## 05-03 M2`, `## (보류 1) 05-03 화면`, `## 05-03 화면`
- `05-01-PLAN.md` - `<scratch_contract>` `p5-foot.mjs` 사양 (a)에 줄보다 긴 항목 예외와 `NOTE` 줄
- `05-03-PLAN.md` - must-have 3, 가정, Task 3 action·acceptance·fails_when, verify 절 하나 추가(c1f 375px `split … lines=[2-9]`)
- `05-VALIDATION.md` - BIZ-01 (D-07) 행에 같은 예외
- 스크래치(커밋 안 함): `$W/pw/p5-foot.mjs`(보정), 백업 `$W/pw/p5-foot.mjs.pre503t3`, 출력 `$W/t3r-{base,c2f,c1f}.out`

## Decisions Made

- **split 판정 보정 (사용자 결정, 보류 1 checkpoint 답 1):** 항목 하나의 줄바꿈 없는 폭이 줄 폭보다 길 때만 그 항목이 자기 상자 안에서 줄을 바꾸는 것을 허용한다. 여러 줄 split, overflow, 링크 색 판정은 그대로다. 시험 값 `all.yml`은 바꾸지 않았다. 측정: span0 natural=417 line=335 (두 엔진, 네 문서 모두 같음)
- **M1·M2 표식 그대로 (답 2):** `HOLD1_` 머리를 붙이지 않았다
- **보류 규칙 예외 (답 3, 사용자 승인):** Task 3만 다시 했다. Task 1·2는 다시 하지 않았다(이력 수정 금지, M1이 이미 있어 Task 1 전제가 참이 아님)
- **D-07 충족 범위:** 한 줄에 들어가는 항목은 중간에서 끊기지 않는다. 줄보다 긴 항목 하나는 자기 상자 안에서 줄을 바꾼다(사용자 승인한 예외). 가로 넘침은 없다
- 도구의 줄 세기: 05-01 편차대로 상자 수가 아니라 상자들이 놓인 줄 수로 세는 방식을 그대로 두고, 예외는 그 줄 수가 1이고 `getClientRects().length === 1`일 때만 적용했다. 05-01 사양 문구도 이 실제 동작에 맞춰 적었다

## Deviations from Plan

### 사용자 결정에 따른 변경 (보류 1 checkpoint)

**1. [checkpoint 결정] Task 3 split 판정 보정과 계획 문구 수정**
- **Found during:** Task 3 첫 시도 (375px 여덟 줄 `split span0 lines=1 h=42 lh=21`)
- **Issue:** 05-02 사양의 가짜 상호가 375px 줄 폭보다 길어, `inline-block` 상자가 안에서 줄을 바꾸고 높이 기준에 걸렸다. 가로 넘침 없이는 어떤 CSS로도 통과할 수 없는 판정이었다
- **Fix:** 사용자가 고른 대로 도구와 05-01 사양·05-03 Task 3·05-VALIDATION을 보정하고(문서 커밋 `3bfc1cb`, 단독), Task 3만 다시 측정했다
- **Files modified:** 05-01-PLAN.md, 05-03-PLAN.md, 05-VALIDATION.md, 스크래치 `$W/pw/p5-foot.mjs`
- **Verification:** 기준 회귀 16줄 OK + `PASS foot`, 05-01 Task 3 verify 두 명령 exit 0, 05-03 Task 1·2·3 verify exit 0
- **Committed in:** `3bfc1cb`

---

**Total deviations:** 1 (사용자 결정에 따른 판정 보정). Rule 1~3 자동 수정은 없다.
**Impact on plan:** 사이트 파일은 M1·M2 뒤로 바뀌지 않았다(깨끗함 기록 `OK site-clean 05-03-t3 3bfc1cbe1128`, 사이트 트리 = M2). 05-CONTEXT.md·05-RESEARCH.md는 고치지 않았다.

## Issues Encountered

- 375px sepLead가 c2f(긴 상호)에서 1, 05-02 보류 때의 짧은 상호 대조(c2f-fit)에서 0이었다. 판정 대상이 아니라 기록만 했고, 구분 기호 모양은 05-05 D-10 checkpoint에서 사용자가 고른다

## User Setup Required

None - 외부 서비스 설정이 필요 없다.

## Next Phase Readiness

- 05-04(M3 점검 스크립트)의 전제 `FOOT_LAYOUT=OK`, `M2_SHA`, `PROTO_SUPPORT_BLOB`이 모두 기록돼 있다
- 뒤 계획(05-05·05-06·05-08·05-11·05-12)이 `p5-foot.mjs`를 부르는 곳은 모두 마지막 줄 `PASS foot`만 보므로 `NOTE` 줄의 영향을 받지 않는다. 05-12의 `NOTE updated …`는 EVIDENCE의 다른 기록 줄이라 겹치지 않는다
- 커밋은 푸시하지 않았다(첫 푸시는 05-06)

## Self-Check: PASSED

- FOUND `_data/company.yml`, `_includes/footer.html`, `_includes/css/common.css`, `05-EVIDENCE.md`
- FOUND 커밋 `bc934fb9555e`, `b7e2dcd0de13`, `e8b8364`, `3bfc1cbe1128` (모두 HEAD의 조상)
- 05-03 Task 1·2·3 `<automated>` verify exit 0 (보정한 계획 파일에서 꺼내 bash로 실행)
- Task 1 acceptance: `.size > 0` 8줄, `&nbsp;· ` 3곳, `!= blank|!= empty` 0, 슬롯 값 모두 빈 값, 푸터 끝 줄바꿈 없음. Task 2 acceptance: 두 규칙 각 1, CSS 끝 줄바꿈 없음
- `<verification>`: `git log --format=%h 2db88d9a199f..b7e2dcd0de13 -- . ':(exclude).planning'` = `b7e2dcd`, `bc934fb` 두 줄. 05-EVIDENCE.md 누출 검사(홈 경로 문자열, 임시 폴더 실제 경로, 사용자 폴더 경로) 0건

---
*Phase: 05-business-info-support-contact*
*Completed: 2026-11-19*
