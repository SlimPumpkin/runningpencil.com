---
phase: 05-business-info-support-contact
plan: 08
subsystem: site
tags: [support, hold-branch, worktree, check-site, header, footer, email-gate]
status: complete

# Dependency graph
requires:
  - phase: 05-business-info-support-contact
    provides: "05-02의 PROTO_SUPPORT_BLOB(지원 페이지 원형), 05-04의 check-site 7번 가드, 05-06의 PUSH1_SHA=57e56b07f2ab(라이브 M4), 05-07 문서 커밋 뒤 main 끝 32afecdddd20"
provides:
  - "로컬 브랜치 p5-support-hold (upstream 없음, 푸시 안 함, origin/main의 조상 아님)와 보류 worktree $HOLD_WT(저장소 옆 <저장소 폴더 이름>-p5-hold)"
  - "H1 48f332e57e8b: support/index.html (blob = PROTO_SUPPORT_BLOB)"
  - "H2 0d49bcabfd23: scripts/check-site.sh EXPECTED_TITLES 끝 줄 support/index.html|고객 지원 - 러닝펜슬, 3번 머리 주석"
  - "H3 5100b37ade83: 헤더 메뉴 끝·푸터 nav 끝 「고객 지원」(/support/) 링크, 푸터 nav aria-label 「약관 및 지원」"
  - "05-EVIDENCE.md `## 05-08 보류 묶음`: HOLD_BASE, H1_SHA, H2_SHA, H3_SHA, HOLD_ONLY7=OK, HOLD_UI=OK와 판정 줄"
  - "스크래치(커밋 안 함): $W/yml/hold-email.yml(실제 사업자 값 + 가짜 이메일), 빌드 $W/h1·h1f·h3·h3f, 도구 출력 $W/p508-*.out, verify 사본 $W/v508-t1~3.sh"
affects: [05-09, 05-10, 05-11, 05-12, 05-13]

# Actuals (#2632)
actuals:
  tokens: 2467     # chars/4: support/index.html 2498자 + H2 diff 224자 + H3 diff 226자 + EVIDENCE 추가분 6920자. SUMMARY 제외
  tasks: 3
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD (main 기준, SUMMARY 작성 시점). 사이트 커밋 H1·H2·H3는 설계상 main이 아니라 p5-support-hold에만 있고(아래), EVIDENCE와 이 SUMMARY는 뒤 docs 커밋으로 main에 들어간다
plan_head_before: 32afecdddd20aa7026962d6eace00bdaf5572b9d
plan_head_after: 32afecdddd20aa7026962d6eace00bdaf5572b9d
hold_branch_commits:   # main 밖 보류 브랜치 커밋 (git log --format=%h 32afecdddd20..p5-support-hold)
  - 48f332e57e8b
  - 0d49bcabfd23
  - 5100b37ade83

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "보류 묶음: 메인 체크아웃 cwd는 그대로 두고 git -C \"$HOLD_WT\" add/commit만 보류 worktree에서 하고, 판정·빌드·기록은 메인 체크아웃에서 해시로 한다"
    - "보류 커밋 판정: 그 커밋의 check-site 사본으로 그 커밋을 점검해 rc=1, `실패 — 1건`, 유일한 문제가 7번 연락처 문구(only7)"

key-files:
  created:
    - .planning/phases/05-business-info-support-contact/05-08-SUMMARY.md
    - support/index.html (p5-support-hold에만, H1)
  modified:
    - .planning/phases/05-business-info-support-contact/05-EVIDENCE.md
    - scripts/check-site.sh (p5-support-hold에만, H2)
    - _includes/header.html (p5-support-hold에만, H3)
    - _includes/footer.html (p5-support-hold에만, H3)

key-decisions:
  - "가짜 이메일 yml은 H1의 _data/company.yml에서 support_email 줄의 빈 값만 example.invalid 가짜 주소로 바꿨다. 그 줄에는 끝 주석이 있어 줄 전체 일치가 아니라 줄 머리 `support_email: \"\"`를 바꿨고, 다른 줄이 그대로인지 diff로 확인했다. H1f·H3f가 같은 파일을 쓴다"
  - "요구사항 SUP-01·SUP-02·SUP-03·SUP-04는 완료 처리하지 않았다. 지원 페이지·링크는 보류 브랜치에만 있고 게이트(05-11·05-12) 전에는 사이트에 들어가지 않는다(05-02 선례와 같음)"

patterns-established:
  - "05-11은 `git cherry-pick 32afecdddd20..p5-support-hold`로 H1→H2→H3를 main 끝에 옮긴 뒤 이메일 커밋 G를 더한다. H1·H2·H3는 그때까지 이 브랜치에서 다시 고치지 않는다"

requirements-completed: []

coverage:
  - id: D1
    description: "보류 브랜치 p5-support-hold가 HOLD_BASE(main 끝)에서 별도 worktree로 만들어졌고, H1·H2·H3가 그 브랜치에만 있으며 upstream이 없고 원격 어떤 브랜치에도 없고 origin/main의 조상이 아니다. 메인 체크아웃은 main이고 사이트 파일이 그대로다"
    requirement: "SUP-02"
    verification:
      - kind: command
        ref: "05-08-PLAN.md Task 1·2·3 <verify> (모두 exit 0, Task 3 뒤 세 개 다시 실행)"
        status: pass
    human_judgment: false
  - id: D2
    description: "H1·H2·H3 모두 그 커밋의 check-site로 점검하면 rc=1, 실패 1건, 7번 연락처 문구만(only7). H2의 스크립트는 라이브 M4(PUSH1_SHA)를 3번 「문서가 없습니다: /support/index.html」로 막는다"
    requirement: "SUP-02"
    verification:
      - kind: command
        ref: "05-EVIDENCE.md `## 05-08 보류 묶음` OK h1/h2/h3 only7, OK h2-script on push1 fails item3"
        status: pass
    human_judgment: false
  - id: D3
    description: "가짜 이메일 빌드에서 두 엔진 × 375·1280 모두 #contact → #report → #faq, mailto 1, dl·dt 4, anchor=ok. H3에서 1280px은 hdr=1 ftr=1, 375px은 hdr=0 ftr=1, 네 문서 supportlinks=2, PASS foot. 실제 값 빌드는 #faq만, dl 3"
    requirement: "SUP-01, SUP-03, SUP-04"
    verification:
      - kind: command
        ref: "p5-support.mjs·p5-foot.mjs 출력 (EVIDENCE에 그대로)"
        status: pass
    human_judgment: false

# Metrics
duration: 10min
completed: 2026-11-19
---

# Phase 5 Plan 08: 보류 묶음 (지원 페이지·기대 제목·지원 링크) Summary

**로컬 전용 브랜치 `p5-support-hold`에 원형 지원 페이지(H1), check-site 기대 제목 줄(H2), 헤더·푸터 「고객 지원」 링크(H3)를 쌓았다. 세 커밋 모두 이메일 값이 없어 check-site 7번 하나로만 막히는 상태이고, 가짜 이메일을 넣은 빌드에서는 SC5 구조와 링크가 Chromium·WebKit 두 엔진에서 통과했다.**

## Performance

- **Duration:** 약 10분
- **Started:** 2026-11-19T05:15:43Z
- **Completed:** 2026-11-19T05:25Z
- **Tasks:** 3
- **Files modified:** 보류 브랜치 4개(`support/index.html`, `scripts/check-site.sh`, `_includes/header.html`, `_includes/footer.html`), main 2개(EVIDENCE, 이 SUMMARY)

## Accomplishments

- `main` 끝 `32afecdddd20`에서 보류 worktree `$HOLD_WT`와 브랜치 `p5-support-hold`를 만들었다. upstream이 없고 푸시하지 않았으며, 세 task마다 「origin/main의 조상 아님, 원격 브랜치에 없음, upstream 없음」을 다시 확인했다(`OK hold not-ancestor`).
- H1은 `PROTO_SUPPORT_BLOB`을 그대로 담았다(blob 일치 확인). 실제 값 빌드는 `#faq`만, `dl` 3개, `robots`·`최종 업데이트` 없음이다.
- H2의 스크립트로 라이브 M4를 점검하면 3번 항목에서 막힌다. 그래서 기대 제목 줄은 게이트 전 `main`에 넣을 수 없다(Pitfall 7).
- H3에서는 다섯 문서 모두 `/support/` 링크가 헤더·푸터 두 곳이고, 푸터 nav 이름 「약관 및 지원」이 다섯 문서에 있다. 375px에서는 헤더 메뉴가 숨으므로 푸터 링크로 간다.

## Task Commits

사이트 커밋은 `p5-support-hold`에만 있다(`main`에 없음, 푸시 안 함).

1. **Task 1 (tracer): 보류 worktree·브랜치와 원형 지원 페이지** - `48f332e` (feat, p5-support-hold)
2. **Task 2: 점검 3번 기대 제목에 /support/** - `0d49bca` (build, p5-support-hold)
3. **Task 3: 헤더·푸터 고객 지원 링크** - `5100b37` (feat, p5-support-hold)

**Plan metadata:** 이 SUMMARY와 `05-EVIDENCE.md`는 `main`의 docs 커밋 하나로 들어간다.

## Files Created/Modified

- `support/index.html` (H1): `/support/` 고객 지원 페이지. 연락처·신고 구간은 `support_email` 값이 있을 때만 그린다.
- `scripts/check-site.sh` (H2): `EXPECTED_TITLES` 끝 줄과 3번 머리 주석. 실행 권한 그대로.
- `_includes/header.html`·`_includes/footer.html` (H3): 링크 한 줄씩과 푸터 `aria-label`. 두 파일 모두 끝 줄바꿈 없음.
- `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md`: 구간 `## 05-08 보류 묶음`.

## Decisions Made

- 가짜 이메일 yml(`$W/yml/hold-email.yml`)의 `support_email` 줄에는 끝 주석이 있다. 그래서 줄 전체가 아니라 줄 머리 `support_email: ""`만 바꿨고, 다른 줄이 그대로인지 diff로 확인했다. 실제 사업자 값이 들어 있어 스크래치에만 둔다.
- SUP-01~04는 완료 처리하지 않았다. 사이트에 들어가는 것은 게이트 뒤다.

## Deviations from Plan

None - plan executed exactly as written.

판정 절차상 덧붙인 것:
- 보류 커밋의 판정 스크립트(`/tmp/judge.sh`)는 context 「보류 묶음 판정 규칙」 그대로다. 7번 문구 확인은 `실패 —` 줄을 뺀 한 줄에 대해 했다.
- Task 3에서 실제 값 빌드 `$W/h3`의 지원 페이지도 셌다: `#faq`만, `dl` 3개. must_haves의 D-04 방어 조건을 H3에서도 확인했다. 기록 줄 형식은 계획에 없어 EVIDENCE 본문 문장으로만 적었다.

## Issues Encountered

- 가짜 이메일 yml을 처음 만들 때, 줄 전체 일치(`^support_email: ""$`)로 찾았더니 0줄이 나와 멈췄다. 끝 주석 때문이었다. 줄 머리 일치로 바꿔 한 줄만 바뀌는지 확인했다. 판정 기준을 바꾼 것은 아니다.

## Known Stubs

없음. 지원 페이지의 연락처·신고 구간은 `support_email`이 빈 값이면 그리지 않는다(render-if-present). 이것은 이메일 게이트(05-11) 설계이고 자리표시가 아니다.

## Next Phase Readiness

- 05-09·05-10 쪽 조상 점검은 `refs/heads/p5-support-hold`가 있으므로 「있음」 분기(`OK hold not-ancestor`)를 탄다.
- 05-11 게이트 때 `git cherry-pick 32afecdddd20..p5-support-hold`로 옮긴 뒤 이메일 커밋 G를 더한다.
- `$HOLD_WT`는 05-13이 지운다. ref는 남긴다.

## Self-Check: PASSED

- FOUND: `.planning/phases/05-business-info-support-contact/05-EVIDENCE.md` (구간 `## 05-08 보류 묶음`, 실제 경로 0건)
- FOUND on p5-support-hold (`git merge-base --is-ancestor <h> p5-support-hold`): `48f332e57e8b`, `0d49bcabfd23`, `5100b37ade83`. 설계상 `main`(HEAD)의 조상이 아니다.
- Task 1·2·3 `<verify>` 모두 exit 0. 계획 verify 줄을 그대로 뽑은 사본 `$W/v508-t1~3.sh`를 bash로 돌렸다.
- acceptance: `t3` 기록 해시의 헤더·푸터 지원 링크 0건, `t2` 기록 해시의 스크립트 기대 제목 줄 0건, H3 두 include 끝 줄바꿈 없음.
