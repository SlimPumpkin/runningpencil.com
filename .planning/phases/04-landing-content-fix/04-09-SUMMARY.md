---
phase: 04-landing-content-fix
plan: 09
subsystem: content
tags: [site-06, screenshots, webp, image-pipeline, capture-review, tracer]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "04-08: LIVE_PUSH2=OK (SITE-01 갈래 완료). 04-01: 작업 10 캡처 조건 갱신. 04-02: 스크래치 계약(lib.sh, pw)"
provides:
  - "스크래치 $W/img/out/screen-{draw,run,badge}-{564,846}.webp 여섯 개 (sRGB, 메타데이터 청크 없음, 846w 모두 846x1837, sha256은 EVIDENCE IMG 줄)"
  - "04-EVIDENCE.md `## 04-09 이미지 파이프라인 시험`(PIPE_TRACE=OK)과 `## 04-09 캡처 검토와 변환`(CAPTURES_RECEIVED=3, REVIEW 27줄, ORIG_REVIEW 3줄, CAPTURE_WAIVERS=3, WAIVER 3줄, LOGO 3줄, ALT 3줄, IMG 6줄, CAPTURE_REVIEW=OK, IMG_OK=OK)"
  - "04-CONTEXT.md D-18·D-20의 「캡처 검토 뒤 사용자 결정 (2026-11-18, 04-09 Task 3)」: 04-10 화면 검토 기준(③은 원본보다 더 깎지 않는지만 판정)"
  - "스크래치 $W/img.sh(make_webp). 04-10이 그대로 씀"
affects: [04-10, 04-11]

# Actuals (#2632)
actuals:
  tokens: 3407     # chars/4 over 이 계획이 더한 줄 (04-EVIDENCE.md 두 구간 + 04-CONTEXT.md 덧붙임, SUMMARY 제외)
  tasks: 3         # tracer 1, checkpoint:human-action 1, auto 1
  commits: 2       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점: 856a0b6 Task 1, 51089b5 CONTEXT). SUMMARY·EVIDENCE docs 커밋과 STATE 커밋은 이 뒤
plan_head_before: 61b9e7d1a17c42d43f07490cc6e5b92fe7591583
plan_head_after: 51089b5e5489ff4c06731499722fe4d2e565cd06

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "사용자 예외 기록 꼴: 원래 판정은 `ORIG_REVIEW …` 줄로 남기고, 바로 다음 줄에 집계되는 `REVIEW <이름> <항목> OK 사용자 예외(D-nn, 날짜): <관찰>, 그대로 사용`을 쓴다. 예외 수는 `CAPTURE_WAIVERS=<n>`, 내용은 `WAIVER …` 줄"

key-files:
  created:
    - .planning/phases/04-landing-content-fix/04-09-SUMMARY.md
  modified:
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md
    - .planning/phases/04-landing-content-fix/04-CONTEXT.md

key-decisions:
  - "04-09: 캡처 검토에서 badge logo가 FAIL(원본에서 앱의 뱃지 창이 NAVER 로고를 덮음), run·badge status가 판단 필요(상태 표시줄 아이콘·색 차이)였다. 사용자가 SDK 가이드 문장과 위험을 들은 뒤 세 장을 그대로 쓰기로 했다(2026-11-18). 세 항목만 사용자 예외로 허용(CAPTURE_WAIVERS=3)하고 다시 찍지 않음"
  - "04-09: ③ 로고 예외는 「우리가 원본보다 더 자르거나 덮지 않는다」로 D-20 진행 조건 첫째를 계속 지킨다. 04-10 화면 검토는 ③에 한해 테두리·둥근 모서리가 로고 쪽을 원본보다 더 깎지 않는지만 판정하고, ①·②는 원래대로 로고가 온전해야 한다"
  - "04-09: 캡처 세 장을 make_webp로 WebP 여섯 개로 바꿈. 모두 q80, 상한 안, 846w 846x1837로 같음. 파일은 스크래치에만 있고 저장소에는 들어가지 않음"

patterns-established:
  - "사용자 예외는 원래 판정을 지우지 않는다(`ORIG_` 줄). verify가 읽는 줄 머리(`REVIEW`)와 겹치지 않게 접두사로 나눈다"

requirements-completed: [SITE-06]

coverage:
  - id: D1
    description: "합성 Display P3 이미지로 이미지 파이프라인(sRGB 변환 → 564·846 축소 → WebP → 청크 확인 → Jekyll 복사 → 두 엔진 × 배율 2·3 표시)을 스크래치에서 끝까지 확인"
    requirement: "SITE-06"
    verification:
      - kind: automated_ui
        ref: "04-09-PLAN.md Task 1 <automated> (재실행 exit 0, PASS pipe, OK pipe 4줄)"
        status: pass
    human_judgment: false
  - id: D2
    description: "캡처 세 장을 Claude가 직접 열어 아홉 항목씩 검토(27줄 OK·N/A, 그중 3줄은 사용자 예외)"
    requirement: "SITE-06"
    verification:
      - kind: other
        ref: "04-09-PLAN.md Task 3 첫 번째 <automated> (exit 0, REVIEW OK·N/A 27줄, FAIL 줄 없음)"
        status: pass
    human_judgment: true
    rationale: "이미지 내용(출시 범위 밖 기능·개인 정보·로고) 판단은 자동화할 수 없고, 세 항목은 사용자 예외로 통과했다. 최종 판단은 04-11 푸시 승인 때 사용자가 검토 줄과 구간 화면을 직접 보고 한다"
  - id: D3
    description: "WebP 여섯 개(메타데이터 청크 없음, 564w ≤ 100KB, 846w ≤ 180KB, 846w 크기 동일, sha256 기록)와 기록 누출 없음"
    requirement: "SITE-06"
    verification:
      - kind: other
        ref: "04-09-PLAN.md Task 3 <automated> 두 명령 (둘 다 exit 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 32min
completed: 2026-11-18
---

# Phase 4 Plan 09: 앱 화면 캡처 검토와 WebP 변환 Summary

**사용자 iPhone 캡처 세 장(코스 그리기·따라 달리기·완주 뱃지 창, 1260×2736 sRGB)을 직접 검토해 27항목을 판정했다. badge의 NAVER 로고 가림 1건과 상태 표시줄 차이 2건은 사용자 예외로 기록했다. 세 장은 메타데이터 없는 sRGB WebP 여섯 개(846w 846x1837, 최대 144KB)로 바꿔 스크래치에 두었다.**

## Performance

- **Duration:** 약 32분 (이번 시도. 앞 시도는 보류 1로 끝남)
- **Started:** 2026-11-18T05:04:49Z
- **Completed:** 2026-11-18T05:37Z
- **Tasks:** 3 (tracer 1, checkpoint:human-action 1, auto 1)
- **Files modified:** 3 (EVIDENCE, CONTEXT, 이 SUMMARY)

## Accomplishments

- 캡처 없이 합성 Display P3 이미지로 이미지 파이프라인을 끝까지 다시 확인했다. Chromium·WebKit × 배율 2·3에서 `PASS pipe`가 나왔고, 저장소와 라이브는 그대로다 (Task 1, `PIPE_TRACE=OK`).
- 사용자가 캡처 세 장을 넘겼고, 시험 계정·시험 경로로 찍었다고 확인했다. 세 장 모두 같은 크기(1260×2736)다 (Task 2, `CAPTURES_RECEIVED=3`).
- 세 장을 Read 도구로 직접 다시 열어 앞 실행의 검토 27줄과 LOGO·ALT 초안을 확인했다. 모든 OK·N/A 줄에 동의했다. 걸린 세 항목은 사용자 결정대로 `ORIG_` 원래 판정과 사용자 예외 판정으로 나눠 적었다 (`CAPTURE_WAIVERS=3`).
- `make_webp`로 WebP 여섯 개를 만들었다. 모두 q80이고 크기 상한 안이며, VP8 청크 하나에 EXIF·XMP·ICCP가 없다. sha256은 EVIDENCE `IMG` 줄에 있다 (`CAPTURE_REVIEW=OK`, `IMG_OK=OK`).
- 04-10이 읽는 `04-CONTEXT.md` D-18·D-20에 사용자 예외 결정, 04-10 로고 판정 기준, 남는 위험, 후속 항목을 날짜와 함께 덧붙였다.

## Task Commits

1. **Task 1: 합성 Display P3 이미지로 이미지 파이프라인 끝까지 확인 (tracer, 두 번째 시도)** — `856a0b6` (docs)
2. **Task 2: 사용자 캡처 세 장 받기** — 커밋 없음 (저장소 변경 없음. 캡처는 스크래치 사본만 씀)
3. **Task 3: 캡처 검토와 변환** — CONTEXT 결정 기록 `51089b5` (docs). EVIDENCE 구간 `## 04-09 캡처 검토와 변환`은 계획 `<output>`대로 이 SUMMARY와 같은 docs 커밋에 들어간다

**Plan metadata:** 이 SUMMARY와 EVIDENCE를 담은 docs 커밋, 그 뒤 STATE·ROADMAP 커밋

## Files Created/Modified

- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md`: `## 04-09 캡처 검토와 변환` 구간. 표식, 기계 확인, REVIEW·ORIG_REVIEW·WAIVER·LOGO·ALT·IMG 줄을 담았다
- `.planning/phases/04-landing-content-fix/04-CONTEXT.md`: D-18·D-20 아래에 「캡처 검토 뒤 사용자 결정 (2026-11-18, 04-09 Task 3)」을 덧붙였다
- `.planning/phases/04-landing-content-fix/04-09-SUMMARY.md`: 이 문서
- 스크래치(커밋 안 함): `$W/img/out/screen-{draw,run,badge}-{564,846}.webp`. 확인용 축소본 `$W/view/`는 지웠다

## Decisions Made

- **사용자 예외 세 항목 (2026-11-18 사용자 결정):** 검토에서 FAIL 하나(badge `logo`: 원본에서 앱의 뱃지 창이 NAVER 로고 오른쪽을 덮고 있어 앞 세 글자만 보임)와 판단 필요 둘(run `status`: 시계 옆 아이콘이 위치 화살표, badge `status`: 상태 표시줄이 어두운 막 아래)이 나왔다. 오케스트레이터가 NAVER 지도 SDK 가이드 문장(「…네이버 로고가 앱의 UI 요소에 가려지지 않도록 해야 합니다」, RESEARCH Q3)과 위험을 알렸다. 사용자는 다시 확인한 뒤 「세 장으로 WebP를 만든다. ③의 로고 가림(D-20)과 상태 표시줄 차이(D-18)는 사용자 예외로 기록하고, 앱에서 고치면 ③만 바꿀 후속 항목으로 남긴다」를 골랐다. retake·crop-all·stop 가운데 어느 것도 아니므로 `## (폐기 n)` 구간과 `RETAKE`·`HOLD` 머리는 만들지 않았다.
- **계획 규칙에 대한 예외:** 사용자는 계획 prohibition 2(「NAVER 로고를 … 덮는 캡처를 쓰지 않는다. 문제가 있으면 다시 찍기가 먼저다」)와 truth 3(「모두 OK다: … NAVER 로고가 잘리거나 가려지지 않음」)을 위 세 항목에 한해 예외로 허용했다. 나머지 24항목은 그대로 OK·N/A다.
- **위협 모델:** T-04-23(네이버 지도 화면 사용)의 「로고를 자르거나 덮지 않음을 `logo` 항목으로 확인」 완화는 badge에 한해 면제됐다. 사용자가 남는 위험을 받아들였다. 앱 자체가 SDK 가이드에 걸릴 수 있는 장면을 공개 웹페이지에 싣게 된다는 위험이다. 출처 표기와 제휴 오인 문구 금지(04-10)는 그대로 지킨다.
- **ALT 초안 확인:** 세 줄 모두 화면에 보이는 것만 담았고 지명·개인 정보가 없다. ALT badge의 「강아지 모양 코스 뱃지」는 뱃지 그림의 모양을 묘사한 말이다. 화면 제목과 창 문구에 있는 코스 이름 자체는 옮기지 않았으므로 코스 이름 금지 규칙에 걸리지 않는다고 판단해 그대로 두었다. ALT 문구는 고친 것이 없다.

## Deviations from Plan

### 사용자 지시에 따른 편차

**1. [사용자 결정] Task 3 action 7번 checkpoint의 답이 계획 선택지(retake·crop-all·stop) 밖이었다**
- **Found during:** Task 3 (검토에서 FAIL 1·판단 필요 2)
- **Issue:** 계획은 FAIL이 있으면 변환하지 않고, 답에 따라 폐기 구간을 만들게 되어 있다
- **Fix:** 사용자 결정과 오케스트레이터 재개 지시를 따랐다. 폐기·보류 처리 없이 `ORIG_REVIEW` 3줄, 집계되는 사용자 예외 `REVIEW` 3줄, `CAPTURE_WAIVERS=3`, `WAIVER` 3줄을 적고 변환까지 했다. 예외 판정 줄의 근거 글에는 `FAIL`을 쓰지 않았다
- **Files modified:** `.planning/phases/04-landing-content-fix/04-EVIDENCE.md`
- **Verification:** Task 3 verify 두 명령을 고치지 않고 돌려 둘 다 exit 0. `REVIEW` OK·N/A 27줄, `^REVIEW .* FAIL` 0줄
- **Committed in:** SUMMARY와 같은 docs 커밋

**2. [사용자 결정] 계획 범위 밖 파일 `04-CONTEXT.md`를 고쳤다**
- **Found during:** Task 3
- **Issue:** 계획 `files_modified`는 `04-EVIDENCE.md` 하나다. 그런데 04-10은 CONTEXT D-18·D-20을 읽고, 04-10 Task 2 action 3번 (ii)는 모든 장에서 로고가 「온전히 보이며」를 요구한다. ③은 이 조건을 원본부터 지킬 수 없다
- **Fix:** D-18·D-20 아래에 날짜를 단 사용자 결정을 덧붙였다. ③은 테두리·둥근 모서리가 로고 쪽을 원본보다 더 깎지 않는지만 판정한다고 적고, 04-10 (ii)의 「온전히 보이며」를 ③에 한해 그 기준으로 읽는다고 밝혔다. 남는 위험과 후속도 적었다
- **Files modified:** `.planning/phases/04-landing-content-fix/04-CONTEXT.md`
- **Verification:** `git diff --name-only 61b9e7d HEAD -- . ':(exclude).planning'` 빈 출력 (사이트 파일 변경 없음)
- **Committed in:** `51089b5`

---

**Total deviations:** 2 (모두 사용자 결정에 따름, 자동 수정 없음)
**Impact on plan:** 다시 찍기 없이 SITE-06 갈래가 04-10으로 넘어간다. badge 로고 가림은 공개되는 남는 위험으로 남고, 사용자가 받아들였다.

## Issues Encountered

- 없음. 스크래치 도구(`lib.sh`, `img.sh`, `pw`, 캡처 사본)가 모두 남아 있어 다시 만든 것이 없다.

## User Setup Required

None - 외부 서비스 설정 없음.

## Next Phase Readiness

04-10(스크린샷 구간)이 쓸 것은 모두 준비됐다: WebP 여섯 개(`$W/img/out/`), `IMG` 846 줄의 크기 846x1837, `ALT` 세 줄, `LOGO` 세 줄. 04-10과 04-11이 알아야 할 것:

- **04-10 Task 2 action 3번 (ii)의 로고 판정:** ①·②는 원래대로 로고가 온전히 보여야 한다. ③은 CONTEXT D-20 2026-11-18 결정에 따라 「테두리·그림 둥근 모서리가 로고 쪽을 원본보다 더 깎지 않는가」만 판정한다(이 결정이 계획 문구보다 우선한다). ③ 로고는 원본에서 이미 앞 세 글자만 보인다.
- **ALT run의 큰따옴표:** `12'00"/km`의 `"`는 `alt` 속성 안에서 `&quot;`로 적어야 한다.
- **04-11의 검토 줄 표시와 retake:** 04-11 Task 2는 04-09의 `REVIEW` 줄 27개를 그대로 보여 준다. 사용자 예외 판정이 바로 보이게 `ORIG_REVIEW` 3줄과 `WAIVER` 3줄도 함께 보여 주는 것이 좋다. 04-11 `<retake_procedure>`가 폐기 표시를 붙이는 표식 목록에는 `CAPTURE_WAIVERS=`가 없다. retake가 나면 이 표식에도 `RETAKE<n>_`을 붙여야 다음 시도와 섞이지 않는다.
- **후속 (STATE Blockers/Concerns에도 기록):** 앱에서 NAVER 로고 위치(`logoAlign`·`logoMargin`)나 뱃지 창 위치를 고치면 ③만 다시 찍어 교체한다. 이 단계를 막는 항목은 아니다.
- SITE-06은 04-10~04-13도 선언하므로 이 계획에서 완료로 표시하지 않는다(shared-ID gate).

## Self-Check: PASSED

- FOUND: `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` (구간 `## 04-09 캡처 검토와 변환`)
- FOUND: `$W/img/out/` WebP 여섯 개 (Task 3 verify에서 sha256 대조)
- FOUND: 커밋 `856a0b6`, `51089b5` (HEAD의 조상)
- Task 1 verify exit 0, Task 3 verify 두 명령 exit 0 (고치지 않고 실행)
- 계획 `<verification>`: 사이트 파일 변경 없음(`git diff --name-only 61b9e7d HEAD -- . ':(exclude).planning'` 빈 출력). 기록 누출 검사(홈 경로 문자열, 임시 폴더의 실제 경로, 사용자 폴더 경로, 캡처 원래 위치)는 EVIDENCE·SUMMARY·CONTEXT 모두 0줄. 코스 이름·지도 지명도 기록과 커밋 메시지에 없다
- `scripts/check-site.sh` 통과 (작업 트리, jekyll 3.10.0)

---
*Phase: 04-landing-content-fix*
*Completed: 2026-11-18*
