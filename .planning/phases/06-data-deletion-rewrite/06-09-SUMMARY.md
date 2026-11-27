---
phase: 06-data-deletion-rewrite
plan: 09
subsystem: site
tags: [data-deletion, store-developer-name, commit-tree, fast-forward, push, live-check, tracer]
status: complete

# Dependency graph
requires:
  - phase: 06-data-deletion-rewrite
    provides: "06-07의 승인한 원고(DRAFT_APPROVED, DRAFT_BLOB, DRAFT_CAND)와 06-08의 작업 트리 `_data/company.yml` 값 두 줄(DEV_RECEIVED=OK)"
  - phase: 06-data-deletion-rewrite
    provides: "06-01의 스크래치 도구(lib.sh의 build·serve·vals·doc·pages_wait·live, pw/p6-deletion.mjs), 기준 빌드 `$W/base/`"
provides:
  - "main과 원격 main의 값 커밋 S1 `0c48a1175175`(`_data/company.yml`: 키 `store_developer_name`과 머리 주석 한 줄, 사이트 출력 불변)"
  - "main과 원격 main의 재작성 커밋 S2 `e9d9443692b4`(`data-deletion/index.html`: 승인한 원고 blob 그대로, 검색 제외·임시 표시 없음, 앵커 여덟 개). 라이브 배포 완료"
  - "06-EVIDENCE.md 구간 `## 06-09 후보`·`## 06-09 승인`(pending에서 옮김)과 `## 06-09 라이브`(PUSH1_SHA, LIVE_PUSH1=OK)"
affects: [06-10, 06-11, 06-12, phase-7, phase-8, phase-9, phase-10]

# Actuals (#2632)
actuals:
  tokens: 7661     # chars/4 over 실현된 diff (S1·S2의 바뀐 줄 19913자 + 06-EVIDENCE.md에 더한 126줄 10732자. SUMMARY 제외)
  tasks: 3
  commits: 2       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY를 쓸 때). S1·S2 둘(fast-forward로 들어옴). 이 SUMMARY와 06-EVIDENCE.md의 문서 커밋, STATE·ROADMAP 커밋은 그 뒤
plan_head_before: e8448ec3d7a7bd4172ec0a269f10a560c022b5ce
plan_head_after: e9d9443692b4453526d4e11ebfa4910ef519d0ce

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "승인 전 사이트 커밋은 `git commit-tree`로 만든 브랜치 밖 객체로 두고 스크래치 ref로 붙잡는다. 승인한 SHA를 `git merge --ff-only`로 main에 올린 뒤 그 SHA 하나만 `git push origin \"${FULL}:refs/heads/main\"`으로 푸시한다. 승인·커밋·푸시가 같은 SHA를 가리킨다"
    - "fast-forward 전 기록은 저장소 밖 pending 파일에 EVIDENCE와 같은 꼴로 쓰고, fast-forward 뒤 한 번만 EVIDENCE 끝에 붙인다. 그래서 task별 기록 커밋이 HEAD를 움직여 승인한 후보를 막는 일이 생기지 않는다"

key-files:
  created:
    - .planning/phases/06-data-deletion-rewrite/06-09-SUMMARY.md
  modified:
    - _data/company.yml
    - data-deletion/index.html
    - .planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md

key-decisions:
  - "06-09: 첫 사이트 푸시(삭제 안내 재작성) 승인 — 사용자가 Task 2에서 push를 골랐다(PUSH1_APPROVED=e9d9443692b4, PUSH1_CANDIDATE와 같음). 오케스트레이터가 대화에서만 실제 값의 소개 문단(태그를 지운 글), SHA, 나갈 커밋 서른셋, `.planning` 밖 파일 둘, Task 1 판정 요약, 캡처 경로를 보였고, 자기 의견이라고 밝힌 조건부 권고(푸시하되 Google Play 공개 스토어 페이지가 아직 옛 개발자 이름을 보이면 보류)를 냈다. 사용자는 「push (권고, 조건부)」를 골랐고, 공개 스토어 페이지를 확인했다고 따로 말하지는 않았다"
  - "06-09: 열린 항목(Phase 10) — Google Play·App Store 공개 등록정보에 표시되는 개발자 이름과 사이트 값의 대조는 이 계획에서 확인되지 않았다. App Store 판매자 이름이 Apple 법인 이름과 같다는 전제도 확인되지 않은 채 남아 있다"
  - "06-09: 요구사항 처리 — DEL-04·DEL-05·DEL-06은 남은 계획(06-10~06-12) 어디에도 없고 내용이 라이브에 올라가 이 계획에서 닫는다. DEL-01·DEL-02·DEL-03·DEL-07·BIZ-05는 06-10·06-11·06-12가 같은 ID를 가지므로 열어 둔다"

patterns-established:
  - "라이브 확인 실패 시 되돌리기 푸시도 따로 승인받는다(`<rollback_procedure>`). 이번에는 실패가 없어 쓰지 않았다"

requirements-completed: [DEL-04, DEL-05, DEL-06]  # 계획 frontmatter는 [DEL-01..DEL-07, BIZ-05]. 나머지는 06-10·06-11·06-12가 같은 ID를 가져 그 계획들이 닫는다

coverage:
  - id: D1
    description: "S1·S2 후보를 commit-tree로 만들어 check-site 두 번 통과, S1 출력은 기준과 바이트 동일, S2는 삭제 안내 한 파일만 다름, 승인 원고 blob 그대로, 본문 규칙·값 건수·FAQ 경로·두 엔진 화면·푸시 범위·로컬 경로·실제 훅 경로 통과"
    requirement: "DEL-01"
    verification:
      - kind: other
        ref: "06-09-PLAN.md Task 1 <verify> <automated> (bash 임시 파일, fast-forward 뒤 다시 돌려 exit 0)"
        status: pass
    human_judgment: false
  - id: D2
    description: "실제 값으로 그린 소개 문단과 SHA를 사용자에게 보이고 push 승인을 받음"
    requirement: "DEL-02"
    verification:
      - kind: other
        ref: "06-EVIDENCE.md `## 06-09 승인` (OK nocommit 06-09-t2, 답: push, PUSH1_APPROVED)"
        status: pass
    human_judgment: true
    rationale: "개발자 이름이 스토어 공개 표시와 같은지는 사람만 볼 수 있다. 사용자는 조건부 권고를 보고 push를 골랐으나 공개 스토어 페이지를 확인했다고 말하지 않았다. 공개 표시 대조는 Phase 10으로 남는다"
  - id: D3
    description: "승인한 SHA로 fast-forward해 그 SHA만 훅을 거쳐 푸시, Pages 배포 built, 라이브 다섯 문서 200·제목·S2 빌드와 바이트 동일, 라이브 삭제 안내 두 엔진 × 두 폭 판정과 앵커 서른두 줄 ok"
    requirement: "DEL-07"
    verification:
      - kind: other
        ref: "06-09-PLAN.md Task 3 <verify> <automated> 두 명령 (bash 임시 파일, exit 0)"
        status: pass
    human_judgment: false
  - id: D4
    description: "푸시 범위의 메시지와 기록에 개발자 이름 값이 없음, 이 계획이 새로 쓴 기록 줄에서 값 0, 로컬 경로·토큰 꼴 0"
    verification:
      - kind: other
        ref: "Task 1 `leak=skip(no new values)`·`NOTE range messages-with-value=0`·`OK localpaths 0`, 문서 커밋 전 EVIDENCE에 더한 줄의 값 건수 0, LPX·홈 경로 0"
        status: pass
    human_judgment: true
    rationale: "값이 기준 커밋의 추적 파일에 이미 있는 글자열이라 `vals`가 excluded로 세어 06-01 규칙대로 패턴 점검이 건너뛰어졌다. 실행자가 센 것은 새로 쓴 글에 한정된다(06-08과 같음)"

# Metrics
duration: 약 20분 (Task 1 시작부터 라이브 확인까지, 사용자 대기 포함)
completed: 2026-11-27
---

# Phase 6 Plan 09: 값 커밋·삭제 안내 재작성 커밋의 승인과 첫 사이트 푸시 Summary

**`git commit-tree`로 만든 값 커밋 S1(`0c48a1175175`)과 재작성 커밋 S2(`e9d9443692b4`)를 끝까지 판정하고, 사용자가 승인한 S2를 `main`에 fast-forward해 그 SHA 하나만 훅을 거쳐 푸시했다. Pages 배포가 끝난 뒤 라이브 다섯 문서가 200·기대 제목·로컬 S2 빌드와 바이트 동일이고, `/data-deletion/`의 앵커 여덟 개가 Chromium·WebKit × 375·1280에서 해당 조항으로 바로 열린다**

## Performance

- **Duration:** 약 20분(사용자 대기 포함)
- **Started:** 2026-11-27T02:23:36Z (한국 시각 11:23, Task 1)
- **Task 3 시작:** 2026-11-27T02:38:45Z (이어 하기 실행, Task 2 답 기록)
- **푸시:** 2026-11-27T02:41Z 무렵, Pages 빌드 `created_at` 2026-11-27T02:41:22Z
- **Completed:** 2026-11-27T02:43Z (라이브 확인과 Task 3 verify가 끝난 시각. SUMMARY 작성과 커밋은 그 뒤)
- **Tasks:** 3 (tracer 하나, blocking-human 결정 checkpoint 하나, auto 하나)
- **Files modified:** 사이트 2(`_data/company.yml` 2줄 더함, `data-deletion/index.html` 182줄 더하고 17줄 뺌) + `06-EVIDENCE.md`(126줄 더함) + 이 SUMMARY
- **실행자 세션:** 둘. 첫 세션이 Task 1을 하고 Task 2에서 멈췄다. 둘째 세션(이 SUMMARY를 쓴 세션)이 Task 2 답 기록, Task 3, 마무리를 했다. Task 1은 다시 돌리지 않았다(다시 돌리면 `commit-tree`가 새 해시를 낸다)

## Accomplishments

- **후보 판정 (Task 1, tracer):** 임시 인덱스로 S1(작업 트리 `_data/company.yml` blob, 부모 HEAD)과 S2(승인 원고 blob, 부모 S1)를 만들었다. `updated:`가 이미 오늘이라 S2의 삭제 안내 blob은 승인 원고 그대로다.
  - check-site 두 번 통과, `OK s1 same`, `OK s2 only=data-deletion/index.html`.
  - `OK s2 rules class=0 style=0 extra-elements=0 u10=0 robots=0 temp=0 absolute=0 thirtyday=0`, `OK s2 values mailto=2 reqmailto=1 dev=1`, `OK faqpath both`.
  - 로컬 두 엔진 화면 `PASS deletion`(앵커 서른두 줄 ok). 캡처 `$W/cap/s2/<엔진>-<폭>.png`.
  - `OK scope push1 = _data/company.yml data-deletion/index.html`, `leak=skip(no new values)`, `OK localpaths 0`, `OK hook files = s2`, `OK hook s2 pass`.
  - 스크래치 ref `refs/p6-scratch/push1` → S2. `OK nocommit 06-09-t1 head=e8448ec3d7a7`.
- **승인 (Task 2, blocking-human):** 묻기 직전 `OK nocommit 06-09-t2 head=e8448ec3d7a7`. 사용자 답 push, `PUSH1_APPROVED=e9d9443692b4`. 답이 나온 과정은 「Decisions Made」에 있다.
- **푸시와 라이브 (Task 3):**
  - precondition (가) 첫 진입: HEAD가 S1의 부모, EVIDENCE가 HEAD와 같음, 스테이징 없음, 작업 트리 yml blob이 S1의 blob과 같음.
  - `git restore _data/company.yml` → `git merge --ff-only` → `OK ff main = s2`. pending을 EVIDENCE 끝에 한 번 붙이고 `OK pending moved`.
  - `git fetch` 뒤 `OK origin = push1-prev`(`0addc0105044`). `git push origin "${FULL}:refs/heads/main"`이 pre-push 훅(check-site 통과)을 거쳐 `0addc01..e9d9443`으로 나갔다. `PUSH1_SHA=e9d9443692b4`.
  - `pages_wait`: `OK 빌드 e9d9443692b4 built 2026-11-27T02:41:22Z`.
  - `live live1`: `/`, `/privacy-policy/`, `/terms/`, `/data-deletion/`, `/support/` 모두 `200 title=<기대 제목> bytes=same`.
  - 라이브 `p6-deletion.mjs ... '?cb=e9d9443692b4'`: 네 문맥 판정 줄 OK, 앵커 서른두 줄 모두 `ok`, `PASS deletion`. `LIVE_PUSH1=OK`.

## Task Commits

1. **Task 1: S1·S2 commit-tree 후보 판정 (tracer)** — 커밋 없음 (계획 지시. context 「Task 3 fast-forward 전 무커밋」)
2. **Task 2: 소개 문단 대조와 푸시 SHA 승인** — 커밋 없음 (계획 지시)
3. **Task 3: fast-forward·푸시·라이브 확인** — `0c48a1175175` (feat, S1 값 커밋), `e9d9443692b4` (feat, S2 재작성 커밋). 둘 다 Task 1이 만든 객체가 fast-forward로 들어온 것이다. 원격 main에 있다.

**Plan metadata:** 계획 output대로 이 SUMMARY와 `06-EVIDENCE.md`는 같은 문서 커밋으로 들어간다. STATE·ROADMAP·REQUIREMENTS는 그 뒤 별도 docs 커밋. 두 문서 커밋은 푸시하지 않는다(06-12에서 함께 나간다).

## Files Created/Modified

- `_data/company.yml` - 키 `store_developer_name`과 머리 주석 한 줄(S1). 값은 이 문서에 적지 않는다
- `data-deletion/index.html` - 재작성한 삭제 안내(S2). 검색 제외 meta와 임시 표시 없음, 앵커 `request` `location` `google` `apple` `facebook` `kakao` `naver` `line`
- `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` - `## 06-09 후보`, `## 06-09 승인`(pending에서 옮김), `## 06-09 라이브`
- `.planning/phases/06-data-deletion-rewrite/06-09-SUMMARY.md` - 이 문서
- 저장소 밖(커밋되지 않음): `$W/06-09-pending.md`(옮긴 뒤에도 단계 끝까지 남김), `$W/p609-pending-before-t3.md`(답을 적기 전 사본), 판정 도구 `$W/p609-t3a.sh`~`p609-t3d.sh`와 로그, 라이브 사본 `$W/live1/`, 스크래치 ref `refs/p6-scratch/push1`

## Decisions Made

### 사용자 답 (Task 2)

- **답:** push. 승인한 SHA `e9d9443692b4`는 `PUSH1_CANDIDATE`와 같다.
- **답이 나온 과정** (오케스트레이터가 전한 그대로, 값 없이):
  1. 오케스트레이터가 대화에서만 실제 값으로 그린 소개 문단의 태그를 지운 글, 승인할 SHA, 나갈 커밋 서른셋, `.planning` 밖 파일 둘, Task 1 판정 요약, 캡처 경로를 보였다.
  2. 이어 자기 의견이라고 밝힌 조건부 권고를 냈다: 푸시하되, Google Play 공개 스토어 페이지가 아직 옛 개발자 이름을 보이면 보류.
  3. 확신이 낮은 이유로 공개 스토어 표시를 확인하지 않았다는 것(Phase 10)과, App Store 판매자 이름이 Apple 법인 이름과 같다는 전제가 확인되지 않았다는 것을 들었다.
  4. 사용자는 선택지 「push (권고, 조건부)」를 골랐다.
- **읽는 법:** 사용자가 공개 스토어 페이지를 확인했다고 따로 말하지는 않았다. 그래서 이 답은 공개 표시와 대조했다는 기록이 아니다. 실행자는 사용자와 직접 주고받지 않았고 답을 오케스트레이터가 전한 글로 받았다.

### 실행자가 정한 것

- 요구사항: DEL-04·DEL-05·DEL-06만 닫는다. `requirements.ready-ids`는 계획의 ID를 모두 ready로 돌려줬지만, DEL-01·DEL-02·DEL-03·DEL-07·BIZ-05는 06-10·06-11·06-12의 frontmatter에도 있어 그 계획들이 닫게 둔다.

## 열린 항목 (이 계획이 닫지 않은 것)

1. **스토어 공개 표시 대조 (Phase 10).** Google Play·App Store 공개 등록정보의 개발자 이름과 사이트 값의 대조는 이 계획에서 확인되지 않았다. `06-VALIDATION.md` Manual 「스토어 개발자 이름 값이 스토어 표시와 같음」은 사용자가 조건부 권고를 보고 push를 고른 것으로만 남는다.
2. **App Store 판매자 이름 = Apple 법인 이름 전제.** 06-08에서 이어진 미확인 전제다.
3. **실기기 확인.** 계획 assumptions 첫 줄대로 라이브 판정은 두 엔진 × 두 폭 도구로 했고 실기기 확인은 단계 끝 사람 확인으로 넘긴다.
4. 06-06·06-07·06-08·06-13이 연 항목은 그대로다(`06-VALIDATION.md` 「D-02·D-18」 행의 식 포함).

## Deviations from Plan

### Auto-fixed Issues

**1. [계획 문구보다 넓게 적음] 라이브 구간에 계획 밖 줄 둘을 더함**
- **Found during:** Task 3
- **Issue:** 계획이 적으라고 한 줄만으로는 Task 3 첫 진입 확인과 훅이 실제로 통과했다는 것을 기록에 남길 수 없다.
- **Fix:** `OK precondition t3 entry=first head=e8448ec3d7a7`과 푸시 출력의 `check-site: 통과 (커밋 e9d9443692b4, jekyll 3.10.0)` 줄을 더 적었다. 해시와 건수뿐이다.
- **Verification:** Task 3 verify는 정확한 줄과 `^FAIL` 없음만 보므로 걸리지 않는다. 두 명령 exit 0.

**2. [판정 같음] `OK pending moved` 비교에서 구간 끝 빈 줄을 무시함**
- **Found during:** Task 3 1-1번
- **Issue:** EVIDENCE에 붙인 뒤 라이브 구간을 열면 승인 구간 끝에 빈 줄이 하나 생긴다.
- **Fix:** 라이브 구간을 열기 전에 두 구간을 견줬고, 견줄 때 끝 빈 줄을 무시했다. 줄 내용은 pending과 같다(`cat`으로 그대로 붙임).
- **Verification:** `OK pending moved`.

---

**Total deviations:** 2 (기록 줄 추가 하나, 비교 방법 하나)
**Impact on plan:** 범위와 판정 기준은 바뀌지 않았다. 계획의 판정 줄은 모두 계획의 글자 그대로 첫 실행에서 나왔다. `--no-verify`·force push·이력 수정은 쓰지 않았고 되돌리기는 필요 없었다.

## Issues Encountered

- 없음. 원격 main은 Task 1 이후 움직이지 않았고(`0addc0105044`), 훅·배포·라이브 확인이 모두 첫 시도에 통과했다.
- 값 누출 점검은 06-08과 같은 이유(`vals excluded=1`)로 건너뛰어졌다. 이 계획이 새로 쓴 EVIDENCE 줄에서 값이 든 줄은 실행자가 값 파일로 세어 0이다.
- 이미 공개된 개발자 이름 값은 앞으로 되돌려도 저장소 이력과 검색 캐시에 남는다(계획 `<rollback_procedure>` 6번).

## 위협 표 대응

| Threat | 처분 | 한 일 |
|---|---|---|
| T-06-24 (값이 메시지·`.planning`에 섞여 공개) | mitigate | 메시지 파일에 값 없음, `NOTE range messages-with-value=0`, `OK localpaths 0`, 새로 쓴 EVIDENCE 줄 값 0, LPX·홈 경로 0 |
| T-06-25 (승인과 다른 SHA 배포) | mitigate | 후보는 commit-tree 객체, `--ff-only`, 푸시 직전 `OK origin = push1-prev`, 훅이 같은 SHA 점검, `PUSH1_SHA = PUSH1_APPROVED = PUSH1_CANDIDATE` |
| T-06-26 (깨진 삭제 안내가 라이브에 남음) | mitigate | 라이브 다섯 문서 바이트 동일, 앵커 판정 PASS. 되돌리기 불필요 |
| T-06-27 (기존 법적 URL 제목·경로 변경) | mitigate | 라이브 다섯 문서 200·기대 제목 |
| T-06-39 (Task 1·2 사이 커밋으로 fast-forward 불가) | mitigate | 무커밋 두 줄의 해시가 S1의 부모, first-parent 사슬에 S2 |
| T-06-SC (패키지 설치) | mitigate | 설치 없음 |

새 위협 표면은 없다(정적 페이지 한 장의 내용 변경과 데이터 키 하나).

## Known Stubs

없음. 값이 없는 선택 항목(전화)은 render-if-present로 그려지지 않는다. 자리표시 값을 쓰지 않았다.

## User Setup Required

None - 외부 서비스 설정이 필요하지 않다.

## 뒤 계획이 알아야 할 것

- **06-10 (점검 스크립트 보강):** 원격 main은 `e9d9443692b4`다. 로컬 main은 그 위에 이 계획의 문서 커밋 둘을 더 가진다.
- **06-12 (둘째 푸시):** 06-01~06-09의 기록·문서 커밋 가운데 `e9d9443692b4` 뒤의 것은 아직 나가지 않았다. `<rollback_procedure>`의 비교 대상은 `$W/s2/site`다.
- **Phase 10:** 위 「열린 항목」 1·2번.

## Next Phase Readiness

- 다음 실행 계획은 06-10이다. 삭제 안내 재작성이 라이브에 있다.
- 막는 것은 없다.

## Self-Check: PASSED

문서 커밋 `ce2283e` 뒤에 확인했다.

- FOUND: `.planning/phases/06-data-deletion-rewrite/06-09-SUMMARY.md`, `06-EVIDENCE.md`, `_data/company.yml`, `data-deletion/index.html`
- FOUND: `0c48a1175175`(S1), `e9d9443692b4`(S2, 원격 main), `ce2283e`(문서 커밋, 파일 둘, 삭제한 파일 없음). 모두 HEAD의 조상
- 계획 `<verification>`: Task 1 verify와 Task 3 verify 두 명령을 문서 커밋 뒤 bash 임시 파일로 다시 돌려 모두 exit 0. `git log --format=%h 0addc0105044..e9d9443692b4 -- . ':(exclude).planning'`가 S2·S1 두 줄
- 새로 쓴 글(EVIDENCE에 더한 줄, 이 SUMMARY, 커밋 메시지)에서 값이 든 줄 0, 경로·토큰 꼴과 홈 경로 0건. 문서 커밋 전 작업 트리 `scripts/check-site.sh` 통과
- 문서 커밋은 푸시하지 않았다
