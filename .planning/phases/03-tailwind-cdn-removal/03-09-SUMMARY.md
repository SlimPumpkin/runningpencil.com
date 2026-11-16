---
phase: 03-tailwind-cdn-removal
plan: 09
subsystem: infra
tags: [deploy, github-pages, pre-push, live-check, success-criteria, user-approval]

# Dependency graph
requires:
  - phase: 03-tailwind-cdn-removal
    provides: "03-06: 사이트 푸시와 라이브 확인(SITE_PUSH_SHA=2ebeca06ca51, LIVE_SITE=OK, JUDGE live OK) / 03-07·03-08: 원본 맵 일곱 개, 두 CLAUDE.md, README 문서 커밋(DOCS_CLAUDE_SHA, DOCS_README_SHA, DOCS_STALE=OK)"
provides:
  - "문서 푸시(D-21 ②): 사용자가 승인한 DOCS_PUSH_CANDIDATE=3f148e83d849 하나를 pre-push 훅 통과 뒤 원격 main에 푸시. 원격 main 2ebeca06ca51 → 3f148e83d849"
  - "문서 푸시 라이브 확인(D-22): Pages 빌드 built·오류 없음, 세 법적 URL과 / 200·기대 제목, 법적 HTML Tailwind 0건, /CLAUDE.md·/README.md 404 (첫 읽기의 일시 503은 사용자 결정으로 판정). LIVE_DOCS=OK"
  - "Phase 3 성공 기준 1~4 판정표(기준 문구는 ROADMAP 그대로, 근거 표식, 판정 범위 밖 목록). PHASE3_SC=OK"
affects: [03-verify, 04, 06, 07, 08, 09]

# Actuals (#2632)
actuals:
  tokens: 3800     # chars/4: 03-EVIDENCE.md 추가분(03-09 세 구간 재구성과 판정표) (SUMMARY 제외)
  tasks: 3
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD. 사이트·문서 코드 변경 없음(앞 계획 커밋을 푸시만 함). 기록은 아래 docs 커밋으로 들어간다
plan_head_before: 3f148e83d849102cbac4e50c6ae06782f14081e7
plan_head_after: 3f148e83d849102cbac4e50c6ae06782f14081e7

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "문서 경로의 404 확인은 원 서버(`server: GitHub.com`)가 404로 답하고 200이 0번이면 OK로 본다. 한 번 읽기의 CDN 가장자리 일시 503은 실패가 아니며 짧은 간격으로 다시 읽는다(사용자 결정, 03-09)"
    - "라이브 확인 실패 기록은 지우지 않고 별도 구간으로 옮기고, 판정을 바꾼 사람의 결정과 재측정을 함께 적는다"

key-files:
  created:
    - .planning/phases/03-tailwind-cdn-removal/03-09-SUMMARY.md
  modified:
    - .planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md

key-decisions:
  - "사용자가 Task 2에서 「push」로 답해 DOCS_PUSH_CANDIDATE=3f148e83d849 한 번의 문서 푸시를 승인했다. 승인은 그 푸시 한 번에만 썼다"
  - "문서 푸시 뒤 /CLAUDE.md·/README.md의 첫 읽기 503(Varnish 가장자리, Unicorn! 페이지)은 GitHub Pages CDN 가장자리의 일시 오류로 판정했다(사용자 결정 other: 404로 판정, 이어 가기). 원 서버는 언제나 404, 200은 0번, 재측정은 404였고 어떤 커밋에도 없던 대조 경로도 같은 503을 받았다. 되돌리기 푸시와 추가 배포는 하지 않았다. 계획의 404 문자 규칙과 D-23 되돌리기 규칙에서 벗어나는 사용자 승인 예외다"
  - "첫 실행자가 로컬에서만 만든 되돌림 커밋 641d7bfb7718·0e94067c885c는 푸시하지 않고 오케스트레이터가 git reset --keep 3f148e83d849로 제거했다. 로컬 main = 원격 main = 3f148e83d849"
  - "Phase 3 성공 기준 1~4 모두 충족(PHASE3_SC=OK). 실제 Safari·iOS Safari, 다른 폭, 고배율, 화면 낭독기, D-08 끝까지 민 뒤 그림자 소멸, D-07 실제 Safari 표 감싸개 Tab 도달은 판정 범위 밖으로 표 아래에 적고 단계 끝 사람 확인으로 넘긴다"

patterns-established:
  - "단계 마지막 계획은 라이브 최종 상태에서 ROADMAP 성공 기준 문구를 그대로 옮긴 판정표(기준·판정·근거)를 쓰고, 범위 밖 항목을 숨기지 않는다"

requirements-completed: [SHELL-04]

coverage:
  - id: D1
    description: "승인받은 문서 푸시 SHA 하나만 pre-push 훅(check-site 5항목)을 거쳐 원격 main에 푸시됨. 범위의 .planning/ 밖 파일은 CLAUDE.md·.claude/CLAUDE.md·README.md 셋, 문서 커밋은 사이트 라이브 확인 뒤"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-09-PLAN.md Task 1 <verify> (bash, exit 0, 첫 실행자)"
        status: pass
      - kind: other
        ref: "git push origin 3f148e83…:refs/heads/main → 훅 줄 check-site: 통과 (커밋 3f148e83d849, jekyll 3.10.0), 원격 main 2ebeca0..3f148e8"
        status: pass
    human_judgment: false
  - id: D2
    description: "Pages 빌드가 문서 푸시 커밋으로 built·오류 없음, 세 법적 URL과 / 200·기대 제목, 법적 HTML Tailwind 0건, /CLAUDE.md·/README.md 404(재확인 12번 모두 원 서버 404, 503 0, 200 0)"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-09-PLAN.md Task 3 <verify> 1번 (bash, exit 0: DOCS_PUSH_SHA = 후보, origin/main 조상, LIVE_DOCS=OK, PHASE3_SC=OK, OK HTTP 세 줄, OK 404 두 줄, FAIL 없음, 판정표 근거·범위 밖, ROADMAP §Phase 3 문구 불변)"
        status: pass
      - kind: other
        ref: "03-09-PLAN.md Task 3 <verify> 2번 (gh api pages/builds 대조: commit·created_at 2026-11-16T18:10:08Z·built·오류 없음 1건, 라이브 세 법적 URL 200·제목·Tailwind 0)"
        status: pass
    human_judgment: false
  - id: D3
    description: "첫 읽기 503을 일시 오류로 보고 404 확인을 통과로 받아들인 판정"
    requirement: "SHELL-04"
    verification:
      - kind: manual_procedural
        ref: "03-09 Task 3 checkpoint:decision (gate=blocking-human) → 사용자 답 other (404로 판정, 이어 가기; 되돌림 커밋은 reset --keep로 제거)"
        status: pass
    human_judgment: true
    rationale: "계획 규칙에서 벗어나는 예외는 사람이 승인하는 결정이다. 승인은 이미 받았고 EVIDENCE 「03-09 503 판정과 사용자 결정」에 있다"
  - id: D4
    description: "Phase 3 성공 기준 1~4 판정표(근거 표식, 판정 범위 밖 목록)"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-09-PLAN.md Task 3 <verify> 1번의 판정표 grep(JUDGE live OK, SC4_DECISION=approved, BASE_SELFDIFF=OK, Safari, D-08, D-07)"
        status: pass
    human_judgment: true
    rationale: "판정 범위 밖 항목(실제 Safari·iOS Safari, 다른 폭, 고배율, 화면 낭독기, D-08·D-07 동적 동작)은 단계 끝 검증에서 사람이 확인한다"

# Metrics
duration: 7min
completed: 2026-11-16
status: complete
---

# Phase 3 Plan 09: 문서 푸시와 Phase 3 성공 기준 판정 Summary

**승인받은 문서 커밋 3f148e83d849를 pre-push 훅을 거쳐 원격 main에 푸시했다. 라이브의 세 법적 페이지가 200·같은 제목·Tailwind 0건이고 내부 문서 두 경로가 404임을 확인했다. 첫 읽기의 CDN 일시 503은 사용자 결정으로 판정했다. Phase 3 성공 기준 1~4를 근거 표식과 범위 밖 목록이 있는 판정표로 충족 판정했다(PHASE3_SC=OK)**

## Performance

- **Duration:** 7 min (사용자 결정 뒤 이어받은 Task 3 4~6번부터. Task 1·2와 푸시·빌드 확인은 앞선 실행자와 사용자 승인 단계)
- **Started:** 2026-11-16T18:21:00Z
- **Completed:** 2026-11-16T18:28:00Z
- **Tasks:** 3 (Task 1 tracer, Task 2 승인, Task 3 푸시·라이브 확인·판정표)
- **Files modified:** 1 (`03-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- 원격 main이 `2ebeca06ca51`에서 `3f148e83d849`로 나아갔다(앞선 실행자, 사용자 승인 「push」). pre-push 훅이 `check-site: 통과 (커밋 3f148e83d849, jekyll 3.10.0)`로 통과했고 `--no-verify`·force push는 쓰지 않았다. Pages 빌드는 `OK 빌드 3f148e83d849 built 2026-11-16T18:10:08Z`이고 빌드 기록과 맞는다(Task 3 verify 2).
- HTTP 재확인(`?cb=3f148e83d849`): `/privacy-policy/`, `/terms/`, `/data-deletion/`, `/` 모두 200·기대 제목, 법적 세 문서 Tailwind 0줄. `/CLAUDE.md`·`/README.md`는 각각 6번 읽어 모두 원 서버 404, 503 0번, 200 0번 → `OK 404` 두 줄과 `LIVE_DOCS=OK`.
- EVIDENCE를 정직하게 재구성했다. 첫 실행자의 FAIL 두 줄, 503 분석, 첫 재측정, 로컬 되돌리기 결과는 새 구간 `## 03-09 503 판정과 사용자 결정`으로 옮겨(줄 머리에 FAIL을 두지 않는 목록 항목으로) 그대로 남겼다. 같은 구간에 오케스트레이터 재측정, 사용자 결정(`other`), 사용자 승인 예외라는 점, 이어받은 실행자의 재확인을 더했다.
- `## Phase 3 성공 기준 판정`: ROADMAP §Phase 3 성공 기준 1~4 문구를 그대로 옮긴 표(기준·판정·근거)와 판정 범위 밖 목록, `C2_CONTRACT=OK`·`DOCS_STALE=OK`, 두 푸시의 승인 기록을 적고 `PHASE3_SC=OK`를 더했다. ROADMAP은 고치지 않았다(verify 1의 기준 커밋 대조 diff가 빈 출력).

## Task Commits

1. **Task 1: 문서 푸시 후보 검증 (tracer)** - 커밋 없음 (의도됨. 기록은 EVIDENCE `## 03-09 문서 푸시 후보`, 아래 docs 커밋에 포함)
2. **Task 2: 문서 푸시 승인** - 커밋 없음 (사용자 답 push, SHA `3f148e83d849`)
3. **Task 3: 푸시·라이브 확인·판정표** - 커밋 없음 (원격 main을 `3f148e83d849`로 푸시. 기록은 EVIDENCE 세 구간, 아래 docs 커밋에 포함)

**Plan metadata:** docs 커밋 (SUMMARY + `03-EVIDENCE.md`). 이 커밋과 STATE·ROADMAP 추적 커밋은 푸시하지 않았다(다음 단계의 첫 푸시 때 함께 나감).

## Files Created/Modified

- `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md` - `## 03-09 문서 푸시 라이브 확인`(재확인 문장, `OK 404` 두 줄, `LIVE_DOCS=OK`), `## 03-09 503 판정과 사용자 결정`(새 구간), `## Phase 3 성공 기준 판정`(판정표, 범위 밖 목록, `PHASE3_SC=OK`)
- `.planning/phases/03-tailwind-cdn-removal/03-09-SUMMARY.md` - 이 문서

## Decisions Made

- 문서 푸시 승인(「push」, SHA `3f148e83d849`)은 그 푸시 한 번에만 썼다.
- 첫 읽기 503은 GitHub Pages CDN 가장자리의 일시 오류로 판정했다(사용자 결정 `other`). 판정 규칙: 원 서버 404이고 200이 0번이면 OK, 한 번 읽기의 일시 503은 실패가 아님, 200이 한 번이라도 나오거나 법적 URL이 어긋나면 실제 FAIL.
- Phase 3 성공 기준 1~4 모두 충족. 범위 밖 항목은 단계 끝 사람 확인으로 넘긴다.

## Deviations from Plan

### 사용자 승인 예외

**1. [사용자 결정 - 계획 규칙 예외] 첫 읽기 503을 FAIL 대신 일시 오류로 판정하고 되돌리기 푸시를 하지 않음**
- **Found during:** Task 3 (4번 HTTP 확인, 앞선 실행자)
- **Issue:** `/CLAUDE.md`·`/README.md`가 404 대신 503(Varnish 가장자리, 「Unicorn!」, `retry-after: 0`)을 간헐적으로 돌려줬다. 200은 한 번도 없었다. 앞선 실행자는 미리 정한 재측정 규칙을 채우지 못해 FAIL로 판정하고, `<rollback_procedure>` 1~2번을 로컬에서만 한 뒤 `checkpoint:decision`(blocking-human)을 띄웠다.
- **Fix:** 사용자가 `other`(404로 판정, 이어 가기)를 골랐다. 되돌리기 푸시와 추가 배포는 없다. 이어받은 실행자가 다시 읽어 12번 모두 원 서버 404를 확인했다.
- **Files modified:** `03-EVIDENCE.md`
- **Verification:** Task 3 verify 1·2 exit 0
- **Committed in:** 아래 docs 커밋

**2. [오케스트레이터 처리] 푸시하지 않은 되돌림 커밋 두 개를 reset --keep로 제거**
- **Found during:** 사용자 결정 반영
- **Issue:** 앞선 실행자가 만든 로컬 되돌림 커밋 `641d7bfb7718`·`0e94067c885c`는 결정 뒤 필요 없어졌다.
- **Fix:** 오케스트레이터가 `git reset --keep 3f148e83d849`로 지웠다(푸시하지 않고 제거됨). 이 실행자는 reset·revert를 하지 않았다. 로컬 main = 원격 main = `3f148e83d849`.
- **Files modified:** 없음 (작업 트리 변경은 보존됨)

**3. [기록] 버려진 되돌리기의 커밋 제목 모양**
- 계획 `<rollback_procedure>`는 `git revert --no-edit`(기본 제목 `Revert "…"`)를 적었지만, 앞선 실행자는 저장소의 Conventional Commits 규칙에 맞춰 `revert(03-09): …` 제목에 `This reverts commit …` 본문 줄을 남겼다. 두 커밋은 푸시하지 않고 제거됐으므로 이력에는 남지 않는다.

**4. [설계상] Task 1의 작업별 커밋 없음**
- tracer Task 1은 EVIDENCE만 고치며, 계획 `<output>`대로 EVIDENCE는 SUMMARY와 같은 docs 커밋에 넣는다.

---

**Total deviations:** 사용자 승인 예외 1, 오케스트레이터 처리 1, 기록 2
**Impact on plan:** 판정 규칙 하나를 사람이 바꿨고(503 처리), 근거와 원 기록은 EVIDENCE에 모두 남겼다. 사이트 출력과 원격 이력은 바뀌지 않았다.

## Issues Encountered

- GitHub Pages CDN 가장자리의 간헐적 503(위 예외 1). 어떤 커밋에도 없던 대조 경로도 같은 503을 받아 문서 커밋과 무관한 운영 환경 현상으로 기록했다. 쿼리 문자열로는 원 서버 응답을 강제하지 못했다(관찰).

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- Phase 3의 모든 계획이 끝났다. 원격 main `3f148e83d849`에 사이트와 문서가 모두 있다.
- 단계 끝 검증에서 사람이 확인할 것: 판정 범위 밖 항목(실제 Safari·iOS Safari, 다른 폭, 고배율, 화면 낭독기, D-08 끝까지 민 뒤 그림자 소멸, D-07 실제 Safari 표 감싸개 Tab 도달).
- 로컬 main에는 이 계획의 docs 커밋과 추적 커밋이 푸시되지 않은 채 남는다.

## 기록 누출 검사

`03-09-SUMMARY.md`와 `03-EVIDENCE.md`에서 계획 `<verification>`의 세 패턴(홈 변수 문자열, macOS 임시 폴더의 실제 경로 머리, 사용자 홈 아래 절대 경로 머리)을 찾아 모두 0건임을 확인했다.

## Self-Check: PASSED

- 파일: `03-09-SUMMARY.md`, `03-EVIDENCE.md` 있음
- 원격: `git merge-base --is-ancestor 3f148e83d849 origin/main` 참
- verify: Task 3 verify 1·2 모두 exit 0, `scripts/check-site.sh` 통과
- 표식: `LIVE_DOCS=OK`, `PHASE3_SC=OK`가 줄 전체로 있음

---
*Phase: 03-tailwind-cdn-removal*
*Completed: 2026-11-16*
