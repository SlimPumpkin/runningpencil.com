---
phase: 04-landing-content-fix
fixed_at: 2026-11-18T08:58:50Z
review_path: .planning/phases/04-landing-content-fix/04-REVIEW.md
iteration: 1
findings_in_scope: 6
fixed: 5
skipped: 1
status: partial
---

# Phase 4: Code Review Fix Report

**Fixed at:** 2026-11-18T08:58:50Z
**Source review:** .planning/phases/04-landing-content-fix/04-REVIEW.md
**Iteration:** 1

**Summary:**
- Findings in scope: 6 (fix_scope: all)
- Fixed: 5 (WR-01, IN-01, IN-02, IN-03, IN-04)
- Skipped: 1 (IN-05: 사용자 예외로 이미 기록된 위험)

**작업 위치:** `workflow.use_worktrees=false`라서 worktree 없이 메인 체크아웃(`main`)에서 고치고 커밋했습니다. 아래 확인 명령은 모두 메인 체크아웃에서 돌렸습니다. push는 하지 않았습니다. 커밋은 `gsd_run query commit` 대신 `git commit`으로 했습니다. 오케스트레이터가 지정한 두 줄(Co-Authored-By, Claude-Session)을 메시지 끝에 붙이려고 그렇게 했습니다. 5건을 고쳤고 커밋은 6개입니다. IN-04가 내용 커밋과 문서 커밋 두 개라서 하나가 많습니다.

**적용 순서:** 오케스트레이터 지시대로 IN-01 → IN-02 → IN-03 → IN-04 → WR-01 순서입니다. WR-01은 IN-04의 이름 변경 뒤에 줄 번호를 확정하려고 마지막에 했습니다 (IN-04는 줄 수를 바꾸지 않았습니다).

## Fixed Issues

### IN-01: 점검 6번 항목의 `포인트`가 「체크포인트」 같은 다른 낱말에도 걸림 (오탐)

**Files modified:** `scripts/check-site.sh`
**Commit:** f46c3ca
**Applied fix:** 줄 단위 `grep -c`를 낱말 단위 계산으로 바꿨습니다: `grep -o -E '(체크|엔드)?포인트|굿즈|코스북' | grep -v -x -E '체크포인트|엔드포인트' | wc -l`. REVIEW.md가 예로 든 줄 단위 `grep -v` 필터는 쓰지 않았습니다 (한 줄에 「체크포인트」와 맨 「포인트」가 같이 있으면 그 줄 전체가 빠집니다). 허용 낱말을 더할 때 접두어 묶음과 허용 목록 두 곳에 함께 더한다는 주석을 남겼습니다. 변수 이름(`u10`)과 종료 코드 흐름은 그대로입니다. 메시지의 단위만 「줄」에서 「곳」으로 바꿨습니다. 이제 세는 대상이 줄이 아니라 낱말이라서, 「줄」로 두면 틀린 단위가 됩니다.
**확인:**
- 스크래치 HTML로 시험: 맨 「포인트」만 있음 → 1, 「체크포인트」만 있음 → 0, 둘이 한 줄에 같이 있음 → 1, 「엔드포인트, 굿즈, 코스북」 → 2, 아무것도 없음 → 0. `LC_ALL=C`와 `LC_ALL=en_US.UTF-8`에서 결과가 같았습니다.
- `bash -n scripts/check-site.sh` 통과, `scripts/check-site.sh` → `check-site: 통과 (작업 트리, jekyll 3.10.0)`.

### IN-02: 점검 스크립트의 랜딩 제목 주석이 Phase 4 완료 뒤에도 「Phase 4에서 바뀔 수 있다」고 함

**Files modified:** `scripts/check-site.sh`
**Commit:** 86a5704
**Applied fix:** 16행 주석을 「법적 URL 3개의 제목은 Ground Rule로 고정한다. 랜딩 제목을 바꾸는 단계가 이 값도 고친다.」로 바꿔 단계 번호를 뺐습니다. IN-01과 같은 파일이지만 따로 커밋했습니다.
**확인:** `bash -n` 통과, `scripts/check-site.sh` → 통과.

### IN-03: 넓은 화면에서 `.rp-shots`의 `tabindex="0"`이 기능 없는 탭 멈춤 자리가 됨

**Files modified:** `.planning/codebase/CONVENTIONS.md`, `.claude/CLAUDE.md` (재생성)
**Commit:** 7527e78
**Applied fix:** 문서로 처리했습니다. `CONVENTIONS.md`의 「실제 앱 화면」 띠 설명 줄 끝에 「넓은 화면(860px 초과)에서는 밀 것이 없어도 띠가 탭 멈춤 자리로 하나 남는다. 「실제 앱 화면」 구간은 스크립트를 쓰지 않는 방침이라 그대로 둔다.」를 더했습니다. 그 뒤 `generate-claude-md`로 `.claude/CLAUDE.md`를 다시 만들었습니다. JS로 `tabindex`를 붙였다 떼는 방법은 쓰지 않았습니다. 이 구간은 스크립트를 쓰지 않는다는 결정과 어긋나기 때문입니다. `index.html`은 바꾸지 않았습니다.
**확인:** 고치기 전에 재생성을 한 번 돌려 `git diff`가 비는 것(멱등)을 확인했습니다. 고친 뒤 `git diff -U0 .claude/CLAUDE.md`를 보니 161행 한 줄만 바뀌었습니다.

### IN-04: 같은 강아지 모양 코스가 랜딩 목업에서는 「댕댕런」, 실제 캡처에서는 「강아지런」

**Files modified:** `index.html` (내용 커밋), `CLAUDE.md`·`.planning/codebase/INTEGRATIONS.md` (docs 커밋)
**Commit:** 270b880 (index.html), b3eb0db (문서)
**Applied fix:** 사용자 결정에 따라 「강아지런」으로 통일했습니다. `index.html`의 9곳을 바꿨습니다: 히어로 aria-label, 목업 제목, 목업 뱃지 문구, 「달려 보기」 칩·지도 aria-label·완료 문구, 스케치 aria-label, 스크립트 주석 2곳. 이름 말고는 바꾸지 않았습니다 (`KM = 8.3`, 시간, 그림 그대로). 문서 커밋은 따로 했습니다. 바꾼 곳은 루트 `CLAUDE.md` 2곳(달려 보기 설명, 푸터 설명. 둘 다 「이번 마일스톤 방침」 구간 밖)과 `INTEGRATIONS.md` 1곳입니다. `.planning/phases/` 아래 과거 기록은 그대로 두었습니다.
**확인:**
- `diff <(git show HEAD:index.html | sed 's/댕댕런/강아지런/g') index.html` → 같음. 이름 말고 바뀐 곳이 없고, 줄 수도 622로 그대로입니다.
- `scripts/check-site.sh` → 통과 (index.html 커밋 전).
- `git grep -n 댕댕런 -- ':!.planning/phases'` → 결과 없음 (exit 1).

### WR-01: `.claude/CLAUDE.md`의 `index.html` 줄 번호가 이번 단계의 줄 이동을 반영하지 않음

**Files modified:** `.planning/codebase/ARCHITECTURE.md`, `.planning/codebase/CONVENTIONS.md`, `.claude/CLAUDE.md` (재생성), `.planning/phases/04-landing-content-fix/deferred-items.md`
**Commit:** 8d3d2d9
**Applied fix:** 일정한 값을 더하지 않았습니다. 기준 커밋(`0bfe5b2`)에서 각 번호가 가리키던 내용을 확인한 뒤, 현재 HEAD에서 `grep -n`으로 같은 내용을 하나씩 다시 찾았습니다. 바꾼 번호는 다음과 같습니다.
- Component 표: 헤더 153→164, 푸터 426→462, 「랜딩 전용」 CSS 29-115→29-126, SVG `<defs>` 121-151→132-162, 스크립트 428-583→464-619
- Layers: 마크업 119-427→130-463, 스크립트 428-583→464-619
- Data Flow: CSS rp-pin 66-84→65-83, scroll 551-554→587-590, paintStory 485-505→521-541, setProperty 496-498→532-534, `--q*` 사용처 281-347→292-358, setStep 467-476→503-512, goStep 507-515→543-551, syncLive 479-482→515-518, startRun 533-544→569-580, setRun 526-531→562-567, hash 558-560→594-596, settle 561-570→597-606, rp-ready `:569`→`:605`, reduced-motion 576-581→612-617
- State 446→482, rp-c-dog path 123→134, 사용처 281,282,296,312,347→292,293,307,323,358, `#story` 205→216, `'use strict'` 430-431→466-467, `@media (max-width: 860px)` 100→109, moveTo 459-464→495-500, decodeURIComponent 560→596
- 바뀌지 않은 번호 (확인함): 21, 22-25, 24, 27, 29, 31
- CONVENTIONS.md: 「약 428행」→「약 464행」

같은 커밋에서 `deferred-items.md`의 첫 두 항목(ARCHITECTURE 행 번호, CONVENTIONS 「약 428행」)을 `status: resolved`로 바꿨습니다. CONCERNS·TESTING 항목은 `open`으로 두었습니다. CONCERNS.md·STRUCTURE.md·TESTING.md는 건드리지 않았습니다.
**확인:**
- 범위 끝 줄도 확인했습니다 (500·512·518·541·551·567·580·617은 `}`, 590은 `}, { passive: true });`, 463은 빈 줄, 126은 미디어 블록의 `}`, 162는 `</svg>`).
- `diff <(git show HEAD:.claude/CLAUDE.md | sed -E 's/[0-9]+/N/g') <(sed -E 's/[0-9]+/N/g' .claude/CLAUDE.md)` → 같음. 재생성 결과에서 숫자 말고는 바뀐 것이 없습니다. ARCHITECTURE.md도 같은 방법으로 확인했습니다. 바뀐 hunk는 132행부터라서 「이번 마일스톤 방침」 구간과 skills·workflow·profile 구간에는 변경이 없습니다.
- `scripts/check-site.sh HEAD` → `check-site: 통과 (커밋 8d3d2d9f49f7, jekyll 3.10.0)`.

## Skipped Issues

### IN-05: `screen-badge-*.webp` 캡처에서 NAVER 로고가 앱의 뱃지 창에 일부 가려짐

**File:** `images/app/screen-badge-564.webp`, `images/app/screen-badge-846.webp` (사용처 `index.html:427` 부근)
**Reason:** 오케스트레이터 지시로 고치지 않았습니다. 사용자 예외로 이미 기록된 위험이고, 근거는 세 곳에 있습니다: `04-CONTEXT.md` D-20(캡처 검토 뒤 사용자 결정), `04-SECURITY.md` AR-04-02, `04-EVIDENCE.md`의 `WAIVER badge logo`. 세 문서 모두에 해당 기록이 있는지 grep으로 확인했습니다.
**Original issue:** 뱃지 캡처의 지도 왼쪽 아래 NAVER 로고가 앱의 반투명 덮개와 뱃지 창에 걸려 「NAV」까지만 보입니다. 지도 SDK 이용 조건이 로고 전체 노출을 요구하면 이 캡처가 그 기준에 못 미칠 수 있습니다 (확인되지 않은 판단).

---

_Fixed: 2026-11-18T08:58:50Z_
_Fixer: Claude (gsd-code-fixer)_
_Iteration: 1_
