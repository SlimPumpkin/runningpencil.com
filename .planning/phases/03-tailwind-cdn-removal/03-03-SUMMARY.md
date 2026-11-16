---
phase: 03-tailwind-cdn-removal
plan: 03
subsystem: ui
tags: [legal-pages, markup, tailwind-cdn, pixel-diff, body-contract]

# Dependency graph
requires:
  - phase: 03-tailwind-cdn-removal
    provides: "03-01: BASE_SHA=8b65fdb59232, 판정 도구(lib.sh·judge.sh·pw), 기준 캡처 $W/cap/base1 / 03-02: legal.css(.rp-doc 본문 규칙), 커밋 ① C1_SHA=7cd2b6128884, C1_PIXEL=OK·C1_PREVIEW3=OK"
provides:
  - "사이트 커밋 ② C2_SHA=31327b684f43: 세 법적 문서 본문의 클래스 0개(16·27·9 → 0·0·0), 끝 안내 p → 클래스 없는 footer. Tailwind script·설정은 레이아웃에 아직 남음"
  - "커밋 ② 빌드가 base1과 PNG 42장·txt 18건 차이 0, hover·focus 24장 유효, 링크 계산값·높이 18행 일치 (C2_PIXEL=OK)"
  - "커밋 ②의 세 문서가 본문 작성 규칙 D-01~D-04를 지키고 noindex·「임시 게시본」·「포인트」 줄 수가 기준과 같음 (C2_CONTRACT=OK)"
affects: [03-04, 03-05, 03-06, 06, 07, 08, 09]

# Actuals (#2632)
actuals:
  tokens: 5400     # chars/4: 세 문서 diff + 03-EVIDENCE.md 추가분 (SUMMARY 제외)
  tasks: 2
  commits: 1       # 측정값: git rev-list --count plan_head_before..HEAD (사이트 커밋 ②). 기록은 아래 docs 커밋 하나로 들어간다
plan_head_before: a4858a769d4272194101d3373b1ac39433e16dd7
plan_head_after: 31327b684f434537eb42e2687c2e89d467ec2140

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "법적 문서 본문은 클래스 없는 HTML. 조항은 section(첫 자식 h2), 끝 안내는 본문 최상위 마지막의 footer(안에 p 없이 글을 바로 넣음)"
    - "본문 모양은 레이아웃의 div.rp-doc 범위 규칙(legal.css)이 모두 정한다. 본문 파일에는 텍스트와 허용 요소만 쓴다"

key-files:
  created:
    - .planning/phases/03-tailwind-cdn-removal/03-03-SUMMARY.md
  modified:
    - privacy-policy/index.html
    - terms/index.html
    - data-deletion/index.html
    - .planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md

key-decisions:
  - "커밋 ②는 문서별로 나누지 않고 세 문서를 한 커밋으로 했다 (치환 여섯 종이 세 문서에 같음, 계획의 Claude's Discretion)"
  - "치환은 perl 한 번에 여섯 패턴으로 했다. 링크는 href를 그대로 두고 class 속성만 지웠고, 끝 안내는 여는 p와 그 뒤 첫 </p>를 footer로 바꿔 안쪽 글·줄바꿈·들여쓰기를 바이트 그대로 두었다"
  - "판정이 처음 후보에서 통과해 legal.css 고침 커밋(CSS_FIX_SHA)이 없다. 03-04의 ③ 미리보기 출처는 계속 c1(C1_SHA)이다"

patterns-established:
  - "verify 명령은 zsh가 아니라 bash로 돌린다. zsh는 \"$C:scripts/…\"의 :s를 변수 수식어로 읽어 경로를 깨뜨린다"

requirements-completed: [SHELL-04]

coverage:
  - id: D1
    description: "사이트 커밋 ②: 세 법적 문서 본문의 클래스 0개, 끝 안내 footer 1개씩, 태그를 지운 원본 텍스트·front matter가 ② 직전과 같음. 커밋은 세 문서만 바꿈"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-03-PLAN.md Task 1 <verify> 첫 명령 (bash, exit 0)"
        status: pass
      - kind: other
        ref: "scripts/check-site.sh 31327b684f43 (커밋 ② 시점 스크립트) → check-site: 통과"
        status: pass
    human_judgment: false
  - id: D2
    description: "커밋 ② 빌드가 base1과 PNG 42장·txt 18건(article.innerText) 차이 0, hover·focus 24장 유효, 링크 계산값·높이 18행 일치. 랜딩 index.html 바이트 동일, _site 파일 목록 동일"
    requirement: "SHELL-04"
    verification:
      - kind: automated_ui
        ref: "\"$W/judge.sh\" c2 → JUDGE c2 OK (PASS 0 diffs, STATES c2 ok=24 vacuous=0, PASS 18 rows)"
        status: pass
      - kind: other
        ref: "03-03-PLAN.md Task 1 <verify> 두 번째 명령 (bash, exit 0)"
        status: pass
    human_judgment: false
  - id: D3
    description: "커밋 ②의 세 문서가 D-01(HTML 원본)·D-02(section 첫 자식 h2)·D-03(최상위 마지막 footer, 안에 p 없음)·D-04(허용 요소만)를 지키고 noindex·「임시 게시본」·「포인트」 줄 수가 기준과 같음"
    requirement: "SHELL-04"
    verification:
      - kind: other
        ref: "03-03-PLAN.md Task 2 <verify> 명령 (bash, exit 0)"
        status: pass
    human_judgment: false

# Metrics
duration: 5min
completed: 2026-11-16
status: complete
---

# Phase 3 Plan 03: 법적 문서 본문 클래스 제거와 커밋 ② Summary

**세 법적 문서 본문에서 Tailwind 클래스를 모두 지우고(16·27·9 → 0·0·0) 끝 안내 `p`를 클래스 없는 `footer`로 바꾼 사이트 커밋 ② `31327b684f43`가, Tailwind가 아직 있는 상태에서 base1과 픽셀·텍스트 차이 0이었다. 문장은 한 글자도 바뀌지 않았다**

## Performance

- **Duration:** 5 min
- **Started:** 2026-11-16T16:02:19Z
- **Completed:** 2026-11-16T16:07:30Z
- **Tasks:** 2 (Task 1 tracer, Task 2 auto)
- **Files modified:** 3 사이트 파일 (`privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`) + 기록 `03-EVIDENCE.md`

## Accomplishments

- 치환 여섯 종(RESEARCH 518-526행)을 세 문서에 적용: `section`·`h2`·`ul`·`a`·`strong`의 클래스 제거, 끝 안내 `<p class="border-t …">…</p>`를 `<footer>…</footer>`로. 바뀐 줄 수는 문서마다 클래스 수 + 1(닫는 태그)로 정확히 17·28·10줄씩, 더하거나 지운 줄은 없음
- 후보 전 정적 확인: 본문 `class=` 0·0·0, 태그를 지운 원본 텍스트 diff 빈 출력(3문서), `<footer>`·`</footer>` 1개씩, front matter 동일
- 후보 커밋(`a19fc87eb16e`)으로 check-site 통과, CDN `/3.4.17`, 출력 표식(`space-y-3` 없음, `<footer>`·Tailwind script 있음), 랜딩 `index.html` 바이트 동일, `_site` 파일 목록 동일, `JUDGE c2 OK`를 모두 확인한 뒤 같은 인덱스를 커밋. 커밋 ②의 트리는 `$W/c2/TREE`와 같다
- `.space-y-*`가 가리던 legal.css 정적 간격 규칙(32·12·4px)이 ②에서 처음 실제 값을 냈고 기준과 같았다 (RESEARCH Pattern 1)
- 본문 작성 규칙 확인: 세 문서 모두 `index.html` 원본(D-01), `section` 다음 줄이 모두 `h2`(D-02), 최상위 자식은 `section`들 뒤 `footer` 하나·안에 `p` 없음(D-03), 요소 집합 `a footer h2 li p section strong ul` 안(D-04). `noindex: true` 1, 「임시 게시본」 1, 「포인트」 줄 4·6·2가 `BASE_SHA`와 같음

## Task Commits

1. **Task 1: 본문 클래스 제거와 footer 치환, 후보 판정 뒤 커밋 ② (tracer)** - `31327b6` (refactor)
2. **Task 2: 커밋 ②의 본문 작성 규칙과 단계 경계 확인** - 커밋 없음 (사이트 파일을 고치지 않음. 결과는 `03-EVIDENCE.md`에 기록해 docs 커밋에 넣음)

**Plan metadata:** docs 커밋 하나 (SUMMARY + EVIDENCE + STATE + ROADMAP)

## Files Created/Modified

- `privacy-policy/index.html` - 본문 클래스 16개 제거, 끝 안내 `footer`
- `terms/index.html` - 본문 클래스 27개 제거, 끝 안내 `footer`
- `data-deletion/index.html` - 본문 클래스 9개 제거, 끝 안내 `footer`
- `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md` - `## 03-03 커밋 ②`(`C2_SHA`, `C2_PIXEL=OK`), `## 03-03 본문 작성 규칙 확인`(`OK contract` 세 줄, `C2_CONTRACT=OK`) 구간
- 저장소 밖 `$W`(커밋 안 함): `c2/`, `cap/c2`, `judge-c2.out`

## Decisions Made

- ②는 세 문서를 한 커밋으로 했다(계획이 정한 대로). 끝 안내 `footer` 안에는 `<p>`를 두지 않았다(RESEARCH Pitfall 5). 렌더 텍스트 18건이 기준과 바이트가 같아 이 방식이 맞음을 확인했다
- check-site 기록: 후보(`a19fc87eb16e`)와 커밋 ② 둘 다 통과했다. EVIDENCE 코드 블록의 check-site 줄은 커밋 ② 시점 스크립트로 커밋 ②를 다시 돌린 결과이고, 후보 결과는 산문으로 적었다(03-02와 같은 방식)
- `OK contract` 줄의 요소 집합은 `key=value` 꼴을 지키려고 쉼표로 이어 적었다(`elements=a,footer,h2,…`)

## Deviations from Plan

None - plan executed exactly as written.

## Issues Encountered

- Bash 도구의 셸이 zsh라 `git show "$C:scripts/check-site.sh"`가 `:s` 수식어로 깨졌다. check-site 재실행과 계획의 verify 세 명령은 모두 `bash`로 다시 돌려 통과했다. 코드·기록에는 영향이 없다
- 판정은 처음 후보에서 바로 통과해 legal.css 고침 절차와 checkpoint가 필요 없었다

## User Setup Required

None - no external service configuration required.

## Next Phase Readiness

- 03-04(커밋 ③: 레이아웃에서 Tailwind script·설정 제거)를 바로 시작할 수 있다. `CSS_FIX_SHA`가 없으므로 ③ 미리보기 출처 규칙상 출처는 `c1`이다
- 푸시하지 않았다. 로컬 `main`은 원격보다 앞서 있고, 푸시는 03-06에서 사람 승인 뒤에 한다

## Self-Check: PASSED

- FOUND: `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`, `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md`
- FOUND: `31327b6` (HEAD의 조상), 트리 = `$W/c2/TREE`
- Task 1 verify 2/2, Task 2 verify 1/1 exit 0 (bash). acceptance: `terms` 본문 `class=` 0, `<footer>` 1, 원본 텍스트 diff 0줄, `JUDGE c2 OK`, 커밋 ②는 세 문서만
- 기록 누출 검사: EVIDENCE·SUMMARY에 홈 경로와 임시 폴더 실제 경로 없음 (docs 커밋 직전 grep으로 다시 확인)

---
*Phase: 03-tailwind-cdn-removal*
*Completed: 2026-11-16*
