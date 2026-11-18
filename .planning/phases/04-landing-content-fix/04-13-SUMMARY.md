---
phase: 04-landing-content-fix
plan: 13
subsystem: content
tags: [site-01, site-06, docs-push, live-check, github-pages, phase-gate]
status: complete

# Dependency graph
requires:
  - phase: 04-landing-content-fix
    provides: "04-12: D-24 문서 커밋 셋(DOCS_MAPS2_SHA fa90e3cb8cd1, DOCS_MAPS3_SHA 5c6451b2debf, DOCS_CLAUDE2_SHA 426174db1045)과 DOCS2_STALE=OK. 04-11: PUSH3_SHA=95062367dc69, LIVE_PUSH3=OK, 사용자 승인. 04-09: CAPTURE_REVIEW=OK. 04-02: 스크래치 계약(lib.sh, pw, p4-behave.mjs, 배포 완료 확인·라이브 요청 규칙). 04-10: p4-shots.mjs"
provides:
  - "원격 main = 9cc14903adbd (D-24 문서 커밋까지. 사이트 출력은 PUSH4_PREV 95062367dc69와 같음)"
  - "04-EVIDENCE.md `## 04-13 문서 푸시 후보`(PUSH4_CANDIDATE, PUSH4_PREV), `## 04-13 문서 푸시 라이브 확인`(PUSH4_SHA, OK 빌드, OK HTTP 4줄, OK 404 /CLAUDE.md, LIVE_PUSH4=OK), `## 04-13 Phase 4 성공 기준 판정`(SC1·SC2·SC3 OK, 라이브 PASS shots·PASS behave 출력 전체, PHASE4_SC=OK, 단계 끝 사람 확인 목록)"
affects: [phase-04-verify-work, 05]

# Actuals (#2632)
actuals:
  tokens: 1352     # chars/4 over 04-EVIDENCE.md에 더한 줄(04-13 세 구간, 5409자). SUMMARY 제외(04-11과 같은 척도). 사이트 코드 변경 없음
  tasks: 3         # tracer 1, checkpoint:decision 1, auto 1
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY 작성 시점). d6d6d56(Task 1 후보 기록) 하나. SUMMARY·EVIDENCE docs 커밋과 STATE·ROADMAP 커밋은 이 뒤
plan_head_before: 9cc14903adbdc1daa6a9396c6b935717dd556204
plan_head_after: d6d6d56d597d4e70c47337771314281f201c0ddc

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "문서 푸시도 사이트 푸시와 같은 절차: 후보 SHA를 실제 pre-push 경로로 통과 → 그 SHA를 이름으로 승인 → 원격이 그대로인지 다시 본 뒤 `<sha>:refs/heads/main` 한 번 → 배포 완료 → 라이브 재판정"

key-files:
  created:
    - .planning/phases/04-landing-content-fix/04-13-SUMMARY.md
  modified:
    - .planning/phases/04-landing-content-fix/04-EVIDENCE.md

key-decisions:
  - "04-13: 사용자가 PUSH4_CANDIDATE=9cc14903adbd를 이름으로 적은 질문에 push로 답했고, 그 SHA 하나만 훅을 켠 채 한 번 푸시했다(9506236..9cc1490). 로컬 HEAD의 Task 1 기록 커밋 d6d6d56은 싣지 않았다. 승인은 이 푸시로 다 썼다"
  - "04-13: Phase 4 성공 기준 1~3을 라이브에서 다시 돌려 모두 OK로 판정했다(PHASE4_SC=OK). 남은 것은 단계 끝 사람 확인 다섯 항목뿐이다"

patterns-established:
  - "단계 끝 판정표는 마지막 푸시 뒤 라이브에서 같은 판정 스크립트를 다시 돌린 출력으로만 채우고, 숫자를 판정한 후보 빌드 기록과 diff로 대조한다"

requirements-completed: [SITE-01, SITE-06]

coverage:
  - id: D1
    description: "승인받은 SHA 9cc14903adbd만 원격 main에 푸시했다(훅 통과, force·--no-verify 없음). 범위의 .planning/ 밖 파일은 두 CLAUDE.md뿐이고 사이트 출력은 이전 원격과 같다"
    requirement: "SITE-01"
    verification:
      - kind: automated
        ref: "04-13-PLAN.md Task 1 <automated> exit 0 (앞 실행기), Task 3 첫 <automated> exit 0 (PUSH4_SHA = PUSH4_CANDIDATE, origin/main 조상)"
        status: pass
    human_judgment: false
  - id: D2
    description: "Pages 빌드가 9cc14903adbd로 built·오류 없음, 네 URL 200·기대 제목·로컬 빌드와 바이트 같음, /CLAUDE.md 404"
    requirement: "SITE-01"
    verification:
      - kind: automated
        ref: "04-13-PLAN.md Task 3 두 번째 <automated> exit 0 (gh api pages/builds 대조 n=1)"
        status: pass
    human_judgment: false
  - id: D3
    description: "Phase 4 성공 기준 판정표: SC1 라이브 / 세 낱말 0줄, SC2 라이브 PASS shots(두 엔진 × 375·1280) + CAPTURE_REVIEW=OK + 04-11 사용자 승인, SC3 라이브 PASS behave(두 엔진)"
    requirement: "SITE-06"
    verification:
      - kind: automated_ui
        ref: "04-EVIDENCE.md `## 04-13 Phase 4 성공 기준 판정` SC1·SC2·SC3 OK, PASS shots, PASS behave, PHASE4_SC=OK"
        status: pass
    human_judgment: false
  - id: D4
    description: "단계 끝 사람 확인: 04-04 3단계 색 배치, 04-10 구간 화면(로고·맞물림), 04-11 실기기 iPhone Safari, 화면 낭독기 읽기, 옛 OG 캐시(A12, 선택)"
    requirement: "SITE-06"
    verification:
      - kind: other
        ref: "04-04·04-10·04-11 PLAN의 <human-check> (단계 끝 UAT)"
        status: pending
    human_judgment: true
    rationale: "실기기 Safari, 화면 낭독기, 시각적 색 배치, 외부 공유 미리보기 캐시는 Playwright 판정으로 확인할 수 없다"

# Metrics
duration: 10min
completed: 2026-11-18
---

# Phase 4 Plan 13: D-24 문서 푸시와 Phase 4 성공 기준 라이브 판정 Summary

**사용자가 승인한 문서 푸시 SHA `9cc14903adbd` 하나를 원격 main에 푸시했다. 배포는 오류 없이 built이고 사이트 출력은 그대로다. 라이브에서 Phase 4 성공 기준 1~3을 다시 돌려 모두 OK다 (`LIVE_PUSH4=OK`, `PHASE4_SC=OK`).**

Task 1(앞 실행기)은 후보를 실제 pre-push 경로로 통과시키고, `.planning/` 밖 범위가 두 CLAUDE.md뿐이며 이전 원격과 후보의 빌드가 `diff -r` 빈 출력임을 확인했다. Task 2에서 사용자가 그 SHA를 승인했다. Task 3은 푸시 직전에 스크래치와 원격이 그대로인지 다시 보고 그 SHA만 푸시한 뒤, 배포 완료·라이브 HTTP·성공 기준을 라이브에서 다시 판정했다.

## Performance

- **Duration:** Task 3 이어받기 약 10분 (2026-11-18T07:56Z ~ 08:06Z). Task 1·2는 앞 실행기와 승인 대기 몫이다
- **Tasks:** 3 (tracer 1, checkpoint:decision 1, auto 1)
- **Files modified:** 기록 2 (`04-EVIDENCE.md`, 이 SUMMARY). 사이트 파일은 바꾸지 않았다

## Accomplishments

- 푸시 전 다시 확인: 스크래치(`lib.sh`, playwright, `p4-behave.mjs`, `p4-shots.mjs`, 기준·c3·p4prev 빌드)가 모두 있어 다시 만든 것이 없다. `origin/main`은 `PUSH4_PREV=95062367dc69` 그대로, 사이트 파일에 고친 것·스테이징한 것이 없다
- `git push origin "${C4}:refs/heads/main"` 한 번, 훅 `check-site: 통과 (커밋 9cc14903adbd)`, `9506236..9cc1490 -> main`
- Pages 빌드 `OK 빌드 9cc14903adbd built 2026-11-18T07:57:50Z` (세 번째 읽기)
- 네 URL 200·기대 제목, 네 문서 모두 로컬 후보 빌드와 바이트 같음, `/CLAUDE.md`·`/.claude/CLAUDE.md` 404

### Phase 4 성공 기준 판정표 (라이브 재판정)

| 기준 | 판정 | 근거 |
|---|---|---|
| SC1 (SITE-01) | OK | 라이브 `/`의 포인트·굿즈·코스북 0줄. 법적 3종은 Phase 6~8 범위, 바뀌지 않음 |
| SC2 (SITE-06) | OK | 라이브 `p4-shots.mjs` Chromium·WebKit × 375·1280 `PASS shots`(숫자가 c3 판정과 diff 빈 출력), `CAPTURE_REVIEW=OK`, 04-11 사용자 승인 `95062367dc69` |
| SC3 | OK | 라이브 `p4-behave.mjs` Chromium·WebKit 6문맥 `PASS behave` |

### 단계 끝 사람 확인으로 넘기는 항목

- 04-04: 「세 가지 이유」 3단계 뱃지 화면의 색 배치
- 04-10: 「실제 앱 화면」 구간 화면(로고·구간 아래 둥근 모서리 맞물림)
- 04-11: 실기기 iPhone Safari에서 구간과 가로 띠
- 화면 낭독기로 구간·띠 읽기
- 공유 미리보기 서비스의 옛 OG 캐시 (A12, 선택)

## Task Commits

1. **Task 1: 문서 푸시 후보를 실제 푸시 경로로 확인 (tracer)** - `d6d6d56` (docs)
2. **Task 2: 문서 푸시 승인 (push)** - 커밋 없음 (결정만)
3. **Task 3: 승인받은 SHA 푸시, 라이브 확인, 성공 기준 판정** - 계획 output 규칙대로 이 SUMMARY와 같은 docs 커밋에 들어감

**Plan metadata:** SUMMARY+EVIDENCE docs 커밋, 그 뒤 STATE·ROADMAP·REQUIREMENTS 커밋. 둘 다 로컬에만 두고 다음 푸시(단계 전환 문서나 다음 단계) 때 함께 나간다. 이번 승인은 `9cc14903adbd` 푸시 한 번으로 다 썼다

## Files Created/Modified

- `.planning/phases/04-landing-content-fix/04-EVIDENCE.md` - `## 04-13 문서 푸시 라이브 확인`, `## 04-13 Phase 4 성공 기준 판정`
- `.planning/phases/04-landing-content-fix/04-13-SUMMARY.md` - 이 요약

## Decisions Made

- 로컬 HEAD는 이미 푸시한 SHA의 자손이라 로컬 main에 들일 것이 없었다 (04-11과 달리 fast-forward 단계 없음)
- 375 끝 화면은 이번 라이브 캡처를 직접 열어 보았다. WebKit은 badge 장이 온전히 보이고, Chromium은 04-11 NOTE의 요소 캡처 부작용과 같은 모습이라 `end-gap=20` 줄로 판정했다

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

None. 되돌리기 절차는 쓰지 않았다(FAIL 없음). 누출 검사: `04-EVIDENCE.md`와 이 SUMMARY에 계획 verification의 누출 검사 대상(홈 폴더 변수 값, macOS 임시 폴더·홈 폴더 경로, 캡처 원본 위치)이 없다.

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- Phase 4의 모든 계획이 끝났다. 다음은 `/gsd-verify-work 04`(단계 끝 사람 확인 다섯 항목 포함)
- 원격 main은 `9cc14903adbd`이고, 로컬 main은 그 뒤에 푸시하지 않은 docs 커밋(`d6d6d56`과 이 계획의 기록 커밋)이 있다. 이 커밋들은 다음 푸시 때 따로 승인받아 나간다

---
*Phase: 04-landing-content-fix*
*Completed: 2026-11-18*

## Self-Check: PASSED

- FOUND: `04-EVIDENCE.md`의 `PUSH4_SHA=9cc14903adbd`, `LIVE_PUSH4=OK`, `PHASE4_SC=OK`
- FOUND: `d6d6d56` (HEAD의 조상), `9cc14903adbd` (origin/main)
- Task 3 verify 두 명령 exit 0, 누출 검사 0줄
