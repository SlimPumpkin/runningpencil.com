---
phase: 06-data-deletion-rewrite
plan: 10
subsystem: tooling
tags: [check-site, pre-push, guard, data-deletion, u10, noindex, tracer]
status: complete

# Dependency graph
requires:
  - phase: 06-data-deletion-rewrite
    provides: "06-09의 라이브 재작성 커밋 S2 `e9d9443692b4`(PUSH1_SHA, LIVE_PUSH1=OK)"
  - phase: 06-data-deletion-rewrite
    provides: "06-01의 스크래치 도구(lib.sh의 mkobj·vals·doc), 기준 커밋 BASE_SHA `89f659a5fdca`"
provides:
  - "main의 build 커밋 B1 `45f1958c1b5f`(`scripts/check-site.sh` 하나): 점검 6번을 랜딩·삭제 안내 출력 둘 다로 넓히고 배송지·전자상거래 추가, 새 8번 항목(삭제 안내 본문 블록의 mailto 요청 경로·개발자 이름 소개 문단, 문서의 검색 제외·임시 표시 없음)"
  - "06-EVIDENCE.md 구간 `## 06-10 가드`(B1_SHA, NEG8_* · NEG6_WORD, GUARD8=OK)와 `## 06-10 훅`(HOOK8=OK)"
affects: [06-11, 06-12, phase-7, phase-8, phase-9]

# Actuals (#2632)
actuals:
  tokens: 2276     # chars/4 over 실현된 diff (check-site.sh 바뀐 줄 4824자 + 06-EVIDENCE.md에 더한 줄 4281자. SUMMARY 제외)
  tasks: 2
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY를 쓸 때). B1 하나. 이 SUMMARY와 06-EVIDENCE.md의 문서 커밋, STATE·ROADMAP 커밋은 그 뒤
plan_head_before: 3ce3be6d391500c818ace6b3ffec75ec6d96ed6a
plan_head_after: 45f1958c1b5f412a07a16d7bebd7670ba5a82039

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "공유 푸터에 같은 요소(mailto)가 있는 문서의 가드는 파일 전체가 아니라 레이아웃 본문 블록(`<div class=\"rp-doc\">`부터 16칸 들여쓴 `</div>` 앞까지)을 잘라 그 안만 본다. 문서 단위 속성(검색 제외 meta, 임시 표시)은 파일 전체를 본다"
    - "가드 후보는 같은 인덱스로 `commit-tree` 객체를 만들어 그 사본 스크립트로 양성(라이브 커밋)·기준(옛 문서)·음성 시험 객체(항목마다 하나)를 판정하고, 모두 「종료 코드 1, 1건」일 때만 같은 인덱스를 커밋한다"

key-files:
  created:
    - .planning/phases/06-data-deletion-rewrite/06-10-SUMMARY.md
  modified:
    - scripts/check-site.sh
    - .planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md

key-decisions:
  - "06-10: 점검 8번은 본문 블록에 mailto 링크가 하나 이상 있는지만 본다. 그 링크가 요청 조항(`#request`) 안에 있는지는 06-09 화면 판정(reqmailto=1)이 봤다. 개발자 이름 소개 문단은 고정 앞부분 「러닝펜슬(개발자 」로 찾으므로 원고 문구를 바꾸는 단계는 이 항목도 함께 고친다"
  - "06-10: 6번 문제 문구에서 「랜딩에」를 빼고 파일 이름(`/${f}`)으로 어느 출력인지 밝힌다. 6번은 이제 두 출력을 보기 때문이다. 8번은 본문 블록을 자르는 awk의 실패도 문제로 센다(계획에 없던 보강, grep 오류를 실패로 세는 것과 같은 이유)"

patterns-established:
  - "check-site 문제 문구에는 임시 빌드 경로(`$DEST`) 대신 사이트 경로(`/data-deletion/`)를 쓴다. 기록에 붙여도 로컬 경로 점검에 걸리지 않는다"

requirements-completed: [DEL-01, DEL-02, DEL-03, BIZ-05]  # 계획 frontmatter 그대로. 네 ID 모두 06-11·06-12도 가지므로 REQUIREMENTS.md 완료 표시는 공유 ID 관문(requirements.ready-ids)대로 그 계획들이 끝난 뒤에 한다

coverage:
  - id: D1
    description: "B1 스크립트가 라이브 S2와 후보에서 통과, 기준 커밋(옛 삭제 안내)을 5건으로 거부, 음성 시험 객체 다섯(본문 mailto 없음, 개발자 이름 빈 값, 검색 제외 복귀, 임시 표시 복귀, U10 낱말)이 각각 한 항목 하나로만 실패. B1은 check-site.sh 하나만 담고 훅은 기준과 같음, 8번은 파일 전체 mailto grep을 쓰지 않음"
    requirement: "DEL-01"
    verification:
      - kind: other
        ref: "06-10-PLAN.md Task 1 <verify> <automated> 두 명령 ($W/p610-v1.sh, $W/p610-v2.sh, bash, exit 0)"
        status: pass
      - kind: other
        ref: "06-10-PLAN.md Task 1 <acceptance_criteria> 옛 항목 수 문장 0 ($W/p610-ac1.sh, 출력 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "실제 pre-push 훅에 표준 입력만 줘 B1은 통과, 본문 mailto 없는 삭제 안내와 검색 제외가 돌아온 삭제 안내는 거부. 원격 main은 이 계획 동안 PUSH1_SHA였음"
    requirement: "DEL-03"
    verification:
      - kind: other
        ref: "06-10-PLAN.md Task 2 <verify> <automated> ($W/p610-v3.sh, bash, exit 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 3min
completed: 2026-11-27
---

# Phase 6 Plan 10: 삭제 안내 가드 (check-site 6번 확장·8번 항목) Summary

**`scripts/check-site.sh`가 이제 삭제 안내 출력에서도 출시 범위 밖 기능 이름(포인트·굿즈·코스북·배송지·전자상거래)을 막고, 새 8번 항목으로 본문 블록의 mailto 요청 경로와 「러닝펜슬(개발자 」 소개 문단, 검색 제외·임시 표시 없음을 지켜 pre-push 훅이 그런 커밋의 푸시를 거부한다.**

## Performance

- **Duration:** 3 min (측정값. 시작 2026-11-27T03:26:56Z, SUMMARY 직전 03:29:47Z)
- **Started:** 2026-11-27T03:26:56Z
- **Completed:** 2026-11-27T03:29:47Z
- **Tasks:** 2
- **Files modified:** 2 (`scripts/check-site.sh`, `06-EVIDENCE.md`) + 이 SUMMARY

## Accomplishments

- 6번: `for f in index.html data-deletion/index.html` 반복, 정규식에 `|배송지|전자상거래`. 허용 낱말 규칙(`U10_ALLOW_PREFIX`)과 grep 종료 코드 2 이상 처리는 그대로
- 8번: `.rp-doc` 본문 블록을 awk로 잘라 그 안에서 `href="mailto:`와 「러닝펜슬(개발자 」를 찾고, 파일 전체에서 `name="robots"`와 「임시 게시본」이 없음을 본다. grep 2 이상·awk 실패는 문제로 센다
- 판정: 양성(PUSH1_SHA, 후보 K) 통과, 기준 거부 5건(6번 1건 + 8번 4건), 음성 다섯 각각 `실패 — 1건`
- 실제 훅: B1 통과, NEG8_MAIL·NEG8_ROBOTS 거부. 시험 객체는 어떤 ref에도 없음

## Task Commits

1. **Task 1: 6번 확장과 8번 항목을 더한 후보를 끝까지 판정하고 B1로 남김** - `45f1958` (build)
2. **Task 2: 실제 pre-push 훅 경로 확인** - 커밋 없음 (기록은 문서 커밋에 들어감, 계획 output 규칙)

**Plan metadata:** 이 SUMMARY와 `06-EVIDENCE.md`의 문서 커밋 (docs(06-10))

## Files Created/Modified

- `scripts/check-site.sh` - 머리 주석 「여덟 가지」와 6·8번 줄, 6번 블록 두 출력 반복, 새 8번 블록
- `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` - 구간 `## 06-10 가드`, `## 06-10 훅`
- `.planning/phases/06-data-deletion-rewrite/06-10-SUMMARY.md` - 이 문서

## Decisions Made

- 8번의 mailto 판정 범위는 본문 블록 전체다(요청 조항 안인지는 06-09 화면 판정이 봤다).
- 6번 문제 문구는 「출시 범위 밖 기능 이름이 있습니다: /<파일> <n>곳 (…)」로 바꿔 두 출력을 구분한다.
- 문제 문구에는 임시 빌드 경로가 아니라 사이트 경로를 쓴다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 2 - Missing Critical] 8번 본문 블록 추출(awk)의 실패도 문제로 셈**
- **Found during:** Task 1 (스크립트 수정)
- **Issue:** 계획은 grep 종료 코드만 실패로 세라고 했다. awk가 실패하면 본문이 빈 문자열이 되어 mailto·소개 문단 문제로는 잡히지만 원인이 가려진다
- **Fix:** `dd_rc`가 0이 아니면 「점검 8번 awk가 실패했습니다 (종료 코드 <n>)」를 문제로 센다
- **Files modified:** scripts/check-site.sh
- **Verification:** 양성 두 커밋 통과, 음성 다섯 각각 1건(awk 문구가 섞이지 않음)
- **Committed in:** 45f1958

**2. [Rule 1 - Bug] Task 2 실행 스크립트에서 스크래치 변수 누락**
- **Found during:** Task 2
- **Issue:** 첫 실행에서 `$W`를 정하지 않아 음성 두 줄이 시험 객체 해시를 읽지 못했고, 훅은 빈 해시를 받아 그냥 지나갔다(FAIL 두 줄)
- **Fix:** 스크립트에 06-01 식 그대로 `W`를 정하고 처음부터 다시 돌렸다. 기록에는 다시 돌린 결과만 적고 첫 실행 사실을 구간 머리말에 밝혔다
- **Files modified:** 스크래치 `$W/p610-t2.sh`만 (저장소 파일 아님)
- **Verification:** Task 2 verify exit 0
- **Committed in:** 해당 없음

---

**Total deviations:** 2 auto-fixed (1 missing critical, 1 bug)
**Impact on plan:** 둘 다 판정의 정확성을 위한 것. 범위 변화 없음

## Issues Encountered

- 기준 커밋의 U10 낱말은 6번 정규식으로 6곳이다. 06-01이 센 7곳 가운데 「수령인」은 계획의 6번 정규식에 없다(계획대로 두었다).

## User Setup Required

None - 외부 서비스 설정 없음.

## Next Phase Readiness

- 06-11(문서 갱신: `CLAUDE.md` 두 사본과 원본 맵의 check-site 항목 수·6번 범위·8번 설명)이 B1을 반영할 차례다. 지금 `CLAUDE.md`와 원본 맵은 아직 「일곱 가지」, 「랜딩 출력에 포인트·굿즈·코스북 없음」으로 적혀 있다
- B1은 로컬 `main`에만 있고 푸시는 06-12가 한다

## Self-Check: PASSED

- FOUND: `scripts/check-site.sh`(B1에서 `# ── 8. 삭제 안내 본문` 있음), `06-EVIDENCE.md`(`GUARD8=OK`, `HOOK8=OK`), 이 SUMMARY
- FOUND: B1 `45f1958c1b5f`가 HEAD의 조상, `PUSH1_SHA..B1`의 `.planning` 밖 커밋은 B1 하나
- 계획 `<verification>`: Task 1 verify 두 명령·Task 2 verify exit 0, 시험 객체 다섯이 어떤 ref에도 없음(`git branch -a --contains` 빈 출력, `for-each-ref --contains` 0)
- 작업 트리 `scripts/check-site.sh` 통과, `vals filled=1 emitted=0 excluded=1`(leak=skip), 기록의 로컬 경로·토큰 꼴 0, `$HOME` 0

---
*Phase: 06-data-deletion-rewrite*
*Completed: 2026-11-27*
