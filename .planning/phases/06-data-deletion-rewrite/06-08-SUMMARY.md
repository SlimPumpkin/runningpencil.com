---
phase: 06-data-deletion-rewrite
plan: 08
subsystem: docs
tags: [data-deletion, store-developer-name, value-preview, scratch-object, leak-check, tracer]
status: complete

# Dependency graph
requires:
  - phase: 06-data-deletion-rewrite
    provides: "06-07의 승인한 원고(DRAFT_APPROVED=b681410f94c5, DRAFT_BLOB)와 스크래치 ref `refs/p6-scratch/draft`"
  - phase: 06-data-deletion-rewrite
    provides: "06-01의 스크래치 도구(lib.sh의 mkobj·build·vals·doc), 기준 빌드 `$W/base/`, 값 누출 점검 규칙, BASE_SHA=89f659a5fdca"
provides:
  - "작업 트리 `_data/company.yml`의 커밋하지 않은 두 줄: 머리 주석 한 줄과 새 키 `store_developer_name` 줄(값 있음). 06-09가 값 커밋 S1의 재료로 쓴다"
  - "스크래치 ref `refs/p6-scratch/s2v` → 재작성 미리보기 S2V_CAND=4505d77840d0 (부모는 값 커밋 미리보기 c5f98e86da21). 브랜치·태그가 아니라 푸시되지 않음"
  - "06-EVIDENCE.md 구간 `## 06-08 시험 실행`(DRY_RUN=OK), `## 06-08 값 미리보기`(S2V_CAND, APPSTORE_NAME=same, DEV_RECEIVED=OK, 답이 나온 과정, 열린 항목)"
  - "D-33 ④(스토어 개발자 이름 값)가 닫혔다는 표식 DEV_RECEIVED=OK (06-09 precondition)"
affects: [06-09, 06-10, 06-11, 06-12, phase-9, phase-10]

# Actuals (#2632)
actuals:
  tokens: 2095     # chars/4 over 실현된 diff (06-EVIDENCE.md에 더한 110줄 8379자. SUMMARY 제외. `_data/company.yml`의 두 줄은 커밋하지 않아 세지 않음)
  tasks: 3
  commits: 2       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY를 쓸 때). 둘 다 Task 2 대기 중 오케스트레이터가 넣은 일시 중지 기록 커밋(docs(pause))이다. 이 계획의 task 커밋은 없다(계획이 「계획 끝 문서 커밋 하나」로 정함). 이 SUMMARY와 06-EVIDENCE.md의 문서 커밋, STATE·ROADMAP 커밋은 그 뒤
plan_head_before: da81ae5480429ec5305ccc9a090261bbf09002c1
plan_head_after: b2644ec30ad340a73f5ed03eba65b2015b524d6c

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "사실값을 받기 전에 같은 파이프라인을 실행 때 만든 무작위 가짜 값으로 끝까지 돌린다. 가짜 값은 스크래치 파일에만 두어 계획·기록·기준 커밋에 없게 하고, 값 누출 점검이 건너뛰지 않음(emitted=1)과 값이 든 파일을 실제로 잡음(양성 시험 객체)을 먼저 보인다"
    - "커밋하지 않은 값은 작업 트리 한 파일에만 두고, 판정은 `mkobj`로 만든 ref 없는 미리보기 객체와 스크래치 ref로 한다. 값이 든 줄 수는 값 파일로 세고(`grep -c -F -f`) 화면에는 건수만 찍는다"
    - "바이트 비교는 `diff -r` 대신 파일마다 `cmp`로 한다(다른 줄이 화면에 찍히면 값이 나온다)"

key-files:
  created:
    - .planning/phases/06-data-deletion-rewrite/06-08-SUMMARY.md
  modified:
    - .planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md

key-decisions:
  - "06-08: 스토어 개발자 이름 값(D-33 ④, D-18)을 받아 작업 트리 `_data/company.yml`의 새 키 `store_developer_name` 한 줄에만 넣었다(DEV_RECEIVED=OK). App Store 개발자(판매자) 표기는 Google Play와 같다(APPSTORE_NAME=same). 값은 커밋하지 않았고 이 계획의 기록·SUMMARY·커밋 메시지에 적지 않았다. 커밋은 06-09에서 사용자 승인 뒤에만 한다"
  - "06-08: 답이 나온 과정 — 사용자가 Play Console 계정 세부정보 화면(개발자 이름 칸)과 Apple Developer 「멤버십 세부 사항」 화면을 보였고 그 시점에는 두 이름이 달랐다. 사용자가 Google Play 개발자 이름을 영문 표기로 바꾸기로 정해 Play Console에서 바꾼 뒤 바뀐 화면을 보였고, 오케스트레이터가 화면에서 읽은 값과 same을 사용자가 「예」로 확인했다. 실행자는 값을 고르거나 고치지 않았고 화면을 보지 않았다(값과 과정을 오케스트레이터가 전한 글로 받음)"
  - "06-08: 받은 값의 미리보기 판정 — 값 커밋 미리보기의 출력은 기준 빌드와 바이트까지 같고, 재작성 미리보기는 `data-deletion/index.html` 하나만 다르며 본문 블록에서 값이 든 줄이 하나다(소개 문단). 두 미리보기 객체 모두 check-site 통과. 값 누출 점검은 `vals filled=1 emitted=0 excluded=1`이라 06-01 규칙대로 건너뛰었다(leak=skip)"
  - "06-08: 열린 항목(Phase 10 스토어 표시 확인) — App Store에 표시되는 판매자 이름이 Apple 쪽 법인 이름과 같다는 것은 확인하지 않았다(오케스트레이터의 기억이고 APPSTORE_NAME=same은 이 전제 위의 답). 두 스토어의 공개 등록정보에 실제로 표시되는 이름도 이 계획에서 보지 않았다"

patterns-established:
  - "값이 기준 커밋의 추적 파일에 이미 있는 글자열이면 `vals`가 excluded로 세고 패턴 파일 점검 (a)(b)(c)를 건너뛴다. 그때는 새로 쓴 글(구간, SUMMARY, 메시지)에서 값이 든 줄 수를 실행자가 따로 센다"

requirements-completed: []  # 계획 frontmatter는 [DEL-02, BIZ-05]. 이 계획은 값을 작업 트리에 두고 미리보기로 판정했을 뿐 사이트에 넣지 않았다(값 커밋·재작성 커밋은 06-09). requirements.ready-ids도 둘 다 blocked로 돌려준다(06-09~06-12가 같은 ID를 가짐). 06-01~06-07·06-13 SUMMARY와 같은 처리

coverage:
  - id: D1
    description: "값을 받기 전 가짜 개발자 이름으로 같은 파이프라인을 끝까지 돌림: 값 커밋·재작성 미리보기 객체 둘 check-site 통과, 값 커밋 출력은 기준과 같음, 재작성 출력은 한 파일만 다르고 소개 문단에 가짜 이름 1, 값 누출 점검 음성(emitted=1, .planning 0, 메시지 0)과 양성(값이 든 시험 객체에서 tree=1 diff=1)"
    requirement: "BIZ-05"
    verification:
      - kind: other
        ref: "06-08-PLAN.md Task 1 <verify> <automated> (bash 임시 파일, exit 0. 첫 실행자가 두 번, 이어 하기 실행자가 값 미리보기 기록 앞뒤로 두 번)"
        status: pass
    human_judgment: false
  - id: D2
    description: "스토어 개발자 이름 값을 대화로 받아 작업 트리 `_data/company.yml`의 `store_developer_name` 한 줄에만 넣음. App Store 표기는 같음(APPSTORE_NAME=same). 답이 나온 과정과 확인하지 못한 것을 값 없이 기록"
    requirement: "DEL-02"
    verification:
      - kind: other
        ref: "$W/p608-t3.sh: OK yml value-in-worktree uncommitted (numstat 2 0, 다른 사이트 파일 변경 0, 스테이징 0), OK yml shape (값 칸을 가린 파일이 Task 1의 devfake.yml과 바이트까지 같음, 키 7, 따옴표·앞뒤 공백)"
        status: pass
    human_judgment: true
    rationale: "값이 스토어에 표시되는 개발자 이름과 같은지는 사용자만 확인할 수 있다(06-VALIDATION Manual 「스토어 개발자 이름 값이 스토어 표시와 같음」). 값은 오케스트레이터가 화면에서 읽어 사용자가 「예」로 확인한 것이고, 실행자는 화면을 보지 않았다. App Store 판매자 이름과 Apple 법인 이름이 같다는 전제는 확인되지 않았다. 06-09가 값과 소개 문단을 보이고 승인을 받는다"
  - id: D3
    description: "받은 값으로 만든 미리보기 객체 판정: 두 객체 check-site 통과, 값 커밋 미리보기 출력은 기준 빌드와 바이트까지 같음, 재작성 미리보기는 `data-deletion/index.html`만 다르고 본문 블록에 값이 든 줄 1, 스크래치 ref `refs/p6-scratch/s2v`"
    requirement: "DEL-02"
    verification:
      - kind: other
        ref: "06-08-PLAN.md Task 3 <verify> <automated> (bash 임시 파일, exit 0. 기록 뒤 두 번)"
        status: pass
    human_judgment: false
  - id: D4
    description: "값이 커밋되지 않았고 이 계획이 새로 쓴 기록·SUMMARY·커밋 메시지에 없음. 이 계획 동안 사이트 파일을 고친 커밋 없음"
    verification:
      - kind: other
        ref: "Task 3 verify(`git branch -a --contains <S2V_CAND>` 빈 출력), 계획 <verification> `git log <OPS_SHA>..HEAD -- . ':(exclude).planning'` 빈 출력, 문서 커밋의 파일 둘(`git show --name-only`), 새로 쓴 글에서 값이 든 줄 0(값 파일로 셈)"
        status: pass
    human_judgment: true
    rationale: "계획 prohibition 둘의 판정 방식이 judgment다. `vals`가 excluded=1이라 06-01 규칙대로 패턴 파일 점검 (a)(b)(c)가 돌지 않았다. 실행자가 센 것은 새로 쓴 글(값 미리보기 구간, SUMMARY, 커밋 메시지)에 한정된다. 값의 글자열 자체는 기준 커밋의 추적 파일에 이미 있어 글자열 grep으로는 이 금지를 잴 수 없다"

# Metrics
duration: 2h 14m (사용자 대기 포함)
completed: 2026-11-27
---

# Phase 6 Plan 08: 스토어 개발자 이름 값 받기와 값 미리보기 Summary

**가짜 개발자 이름으로 값 커밋·재작성·값 누출 점검 파이프라인을 먼저 끝까지 돌린 뒤, 사용자에게 받은 스토어 개발자 이름 값을 작업 트리 `_data/company.yml` 한 줄에만 넣고 미리보기 객체로 판정했다(값 커밋 출력은 기준과 바이트 동일, 재작성 출력은 삭제 안내 한 파일만 다르고 소개 문단에 값 1). 값은 커밋하지 않았다**

## Performance

- **Duration:** 2h 14m (사용자 대기 포함). Task 1 약 5분, Task 2의 사용자 대기(일시 중지 포함) 약 2시간 4분, Task 3과 계획 끝 검증 약 5분
- **Started:** 2026-11-26T23:46:29Z (한국 시각 2026-11-27 08:46)
- **Task 1 끝:** 2026-11-26T23:51:25Z
- **Task 3 시작:** 2026-11-27T01:55:59Z (한국 시각 10:55)
- **Completed:** 2026-11-27T02:00Z (한국 시각 11:00. 값 미리보기 기록과 계획 끝 검증이 끝난 시각. SUMMARY 작성과 커밋은 그 뒤)
- **Tasks:** 3 (tracer 하나, blocking-human 사람 작업 checkpoint 하나, auto 하나)
- **Files modified:** 1 (`06-EVIDENCE.md`, 110줄 더함) + 이 SUMMARY. 커밋한 사이트 파일은 0. 작업 트리 `_data/company.yml`에 커밋하지 않은 두 줄
- **실행자 세션:** 둘. 첫 세션이 Task 1을 하고 Task 2에서 멈췄다. 둘째 세션(이 SUMMARY를 쓴 세션)이 Task 3과 마무리를 했다. Task 1의 내용은 첫 세션이 `06-EVIDENCE.md`에 적은 기록에서 옮겼고, 둘째 세션은 Task 1을 다시 돌리지 않았다(`$W/p608-t1.sh`를 다시 돌리면 가짜 값과 시험 객체 해시가 바뀐다)

## Accomplishments

- **가짜 값 시험 실행 (Task 1, tracer):** 실행 때 `/dev/urandom`으로 만든 가짜 개발자 이름 한 줄을 스크래치 `$W/yml/devfake.val`에만 두고, 실제 값으로 돌릴 파이프라인을 끝까지 돌렸다. 가짜 값은 화면·기록·계획·커밋 메시지에 없다.
  - `$W/yml/devfake.yml`은 `HEAD:_data/company.yml`에 두 줄을 더한 것이다(머리 주석 한 줄은 맨 위 주석 묶음 끝, 키 줄은 `phone` 줄 다음).
  - 판정 줄(모두 기대값): 두 미리보기 객체의 `check-site: 통과`, `OK s1f same`, `OK s2f only=data-deletion/index.html dev=1`.
  - 값 누출 점검이 건너뛰지 않음: `vals filled=1 emitted=1 excluded=0`, `leak .planning=0 messages=0`.
  - 값 누출 점검이 값을 실제로 잡음: 기록 파일 끝에 가짜 이름 한 줄을 붙인 사본을 HEAD에 얹은 시험 객체에서 `leak-probe hit tree=1 diff=1` (T-06-22).
  - 시험 객체 셋은 어떤 ref에도 없다. `DRY_RUN=OK`, `OK site-clean 06-08-t1 da81ae548042`.
- **값 받기 (Task 2, blocking-human checkpoint):** 사용자가 Google Play 개발자 이름을 줬고 App Store 표기는 같다고 확인했다. 답이 나온 과정은 아래 「Decisions Made」에 있다. 답을 받기 전에는 `_data/company.yml`을 고치지 않았다.
- **값 미리보기 (Task 3):** 받은 값을 작업 트리 `_data/company.yml`에 Task 1과 같은 자리·같은 글자의 두 줄로 넣고(값 칸만 다름, `git diff --numstat` `2 0`), 미리보기 객체 둘로 판정했다.
  - 값 커밋 미리보기 `c5f98e86da21`: check-site 통과, 빌드 출력이 기준 빌드(`$W/base/`)와 바이트까지 같다(`OK s1v same`). 새 키는 삭제 안내 원고만 쓰므로 값 커밋만으로는 사이트 출력이 바뀌지 않는다.
  - 재작성 미리보기 `4505d77840d0`(`S2V_CAND`): check-site 통과, 기준과 다른 파일은 `data-deletion/index.html` 하나, 본문 블록에서 값이 든 줄은 1(`OK s2v only=data-deletion/index.html dev=1`). Task 1이 걱정한 경우(값이 본문의 다른 줄에도 들어 `dev`가 1보다 커짐)는 생기지 않았다.
  - 가짜 값 재작성 미리보기(`$W/s2f/`)와는 한 파일의 한 줄만 다르다(`OK s2v vs s2f only=data-deletion/index.html lines=1`).
  - `refs/p6-scratch/s2v`를 재작성 미리보기에 붙였다. 두 객체는 어떤 브랜치에도 없다.
  - 값 누출 점검: `vals filled=1 emitted=0 excluded=1` → `leak=skip(no new values)`.
  - `OK site-clean 06-08-t3 b2644ec30ad3`. 첫 실행에서 모두 통과했고 판정을 고친 것이 없다.

## Task Commits

1. **Task 1: 가짜 개발자 이름으로 파이프라인 시험 실행 (tracer)** — 커밋 없음. 기록은 계획 끝 문서 커밋에 들어간다. verify exit 0을 두 번 확인한 뒤(tracer 관문) Task 2에서 멈췄다.
2. **Task 2: 스토어 개발자 이름 값 받기** — 커밋 없음(checkpoint). 대기 중 오케스트레이터가 일시 중지 기록 커밋 둘(`docs(pause)`, 인계 파일 둘만 담음)을 넣었다. 이 계획의 커밋이 아니다.
3. **Task 3: 값을 작업 트리에만 넣고 미리보기 판정** — 커밋 없음. 값은 커밋하지 않는 것이 계획의 금지 사항이고 기록은 문서 커밋에 들어간다.

**Plan metadata:** 계획 output이 「SUMMARY와 `06-EVIDENCE.md`는 같은 문서 커밋」으로 정했다. 그 문서 커밋은 `21ead38189b1`이고, 이 줄의 해시와 Self-Check, STATE·ROADMAP 진행표는 그 뒤 docs 커밋으로 들어간다(06-07과 같은 순서). 푸시하지 않는다. 이 문서 커밋들은 06-09의 첫 푸시에 함께 나간다.

## Files Created/Modified

- `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` - 구간 `## 06-08 시험 실행`(`DRY_RUN=OK`, 판정 줄, Task 3이 알아야 할 것), `## 06-08 값 미리보기`(`S2V_CAND`, `APPSTORE_NAME`, `DEV_RECEIVED`, 답이 나온 과정, 열린 항목, 판정 줄, 계획 끝 점검)
- `.planning/phases/06-data-deletion-rewrite/06-08-SUMMARY.md` - 이 문서
- 커밋하지 않고 작업 트리에 남긴 것: `_data/company.yml`의 두 줄(머리 주석 한 줄, `store_developer_name` 키 줄). 06-09가 쓴다
- 저장소 밖(커밋되지 않음): 스크래치 `$W/yml/devfake.val`·`devfake.yml`, `$W/draft/approved.html`, 빌드 `$W/s1f/`·`$W/s2f/`·`$W/s1v/`·`$W/s2v/`, 판정 도구 `$W/p608-t1.sh`·`p608-t3.sh`와 그 로그, 스크래치 ref `refs/p6-scratch/s2v`. 단계 검증 뒤 사용자가 지울 때까지 그대로 둔다

## Decisions Made

### 사용자 답 (Task 2)

- **Google Play 개발자 이름:** 받았다. 값은 이 문서에 적지 않는다(D-18, Phase 5 D-02). 작업 트리 `_data/company.yml`의 `store_developer_name` 줄에만 있다.
- **App Store 개발자(판매자) 표기:** Google Play와 같다(`APPSTORE_NAME=same`). 계획 assumptions 첫 줄이 정한 「다르면 Google Play 표기를 쓰고 차이를 Phase 10으로 넘김」 갈래는 쓰지 않았다.
- **답이 나온 과정** (오케스트레이터가 전한 그대로. 값은 빼고 과정만 적는다. 자세한 글은 `06-EVIDENCE.md` `## 06-08 값 미리보기`):
  1. 사용자가 먼저 Play Console 계정 세부정보 화면(개발자 이름 칸)을 보였다.
  2. 이어 Apple Developer 「멤버십 세부 사항」 화면을 보였다. 그 시점에는 두 이름이 달랐다.
  3. 사용자가 Google Play 개발자 이름을 영문 표기로 바꾸기로 정했고, Play Console에서 바꾼 뒤 바뀐 화면을 보였다.
  4. 오케스트레이터가 바뀐 화면에서 값을 읽고 App Store 쪽을 `same`으로 읽어, 두 가지가 맞는지 사용자에게 물었다. 사용자는 「예」로 답했다.
- **읽는 법:** 값과 `same`은 오케스트레이터가 화면에서 읽은 것을 사용자가 「예」로 확인한 것이다. 사용자가 글자로 써 준 값이 아니다. 이 SUMMARY를 쓴 실행자는 값과 과정을 오케스트레이터가 전한 글로 받았고, 사용자와 직접 주고받지 않았으며 화면도 보지 않았다. 실행자는 값을 고르거나 고치지 않았다.
- **이 답이 아닌 것:** 값의 커밋 승인도 푸시 승인도 아니다. 06-09가 값과 소개 문단을 보이고 그 SHA로 따로 묻는다.

### 실행자가 정한 것 (새 사실 없음)

- 값 칸 말고는 Task 1의 `devfake.yml`과 글자가 같게 두 줄을 넣었다(머리 주석 문장과 키 줄 끝 주석은 계획 Task 1 action 1번의 글자).
- 스크래치 ref는 판정이 모두 통과한 뒤에만 붙였다.

## 열린 항목 (이 계획이 닫지 않은 것)

1. **App Store 판매자 이름과 Apple 법인 이름.** App Store에 표시되는 판매자 이름이 Apple 쪽 법인(legal entity) 이름과 같다는 것은 확인한 사실이 아니라 오케스트레이터의 기억이다. `APPSTORE_NAME=same`은 이 전제 위의 답이다. Phase 10 스토어 표시 확인에서 본다.
2. **공개 등록정보의 실제 표시.** 과정에 나온 화면은 Play Console 계정 세부정보와 Apple Developer 멤버십 화면이다. 두 스토어의 공개 등록정보에 실제로 표시되는 이름은 이 계획에서 보지 않았다. `06-VALIDATION.md` Manual 「스토어 개발자 이름 값이 스토어 표시와 같음」(값 커밋 직전 사용자 대조)은 06-09의 승인에서 본다.
3. **`06-VALIDATION.md` 「D-02·D-18」 행의 판정 식.** 그 행은 값 파일로 `.planning`을 grep해 빈 출력이기를 기대한다. 받은 값은 `vals`가 excluded로 센 값이라(기준 커밋의 추적 파일에 이미 있는 글자열) 그 식은 기준 커밋에서도 빈 출력이 아니다(실행자가 파일 수만 세어 확인했다). 단계 검증에서 이 행을 어떻게 읽을지 정해야 한다. 상태 칸은 고치지 않았다.
4. 06-06·06-07·06-13이 연 항목은 그대로 열려 있다(이 계획이 다루지 않았다).

## Deviations from Plan

### Auto-fixed Issues

**1. [계획 우선] 실행자 규약의 task별 커밋 대신 계획의 커밋 구조를 따름**
- **Found during:** Task 1, Task 3
- **Issue:** 실행자 규약은 task마다 커밋하게 하지만, 계획은 값을 이 계획에서 커밋하지 않게 하고(prohibition) SUMMARY와 `06-EVIDENCE.md`를 계획 끝 문서 커밋 하나로 넣게 한다. 06-01 규칙은 `gsd-tools query commit`도 쓰지 않게 한다.
- **Fix:** Task 1·2·3은 커밋하지 않았다. 문서 커밋은 메시지 파일로 `git commit -F`했다. 06-05~06-07·06-13과 같은 처리다.
- **Verification:** `git rev-list --count da81ae548042..HEAD`가 SUMMARY를 쓸 때 2이고 둘 다 오케스트레이터의 `docs(pause)` 커밋이다.

**2. [값이 화면에 찍힘을 막음] 바이트 비교를 `diff -r` 대신 파일별 `cmp`로 함**
- **Found during:** Task 1 (첫 실행자), Task 3
- **Issue:** 계획 Task 1 action 3번은 `diff -r`가 빈 출력인지를 본다. 재작성 미리보기 비교에서는 `diff -r`가 다른 줄을 찍어 값(가짜 값, 실제 값)이 화면과 로그에 나온다.
- **Fix:** 두 site 폴더의 파일을 `cmp -s`로 하나씩 견줘 다른 파일의 이름만 셌다. 판정은 같다(한쪽에만 있는 파일도 다른 것으로 센다).
- **Verification:** `OK s1f same`, `OK s2f only=…`, `OK s1v same`, `OK s2v only=…` 줄. 이어 하기 지시도 같은 방법을 정했다.

**3. [계획에 없는 판정 줄] 구간 둘에 더한 줄**
- **Found during:** Task 1, Task 3
- **Issue:** 계획이 적으라고 한 줄만으로는 precondition, 스크래치 재확인, yml 줄 모양, 미리보기 객체의 모양(부모·바뀐 파일·blob), 객체가 ref·브랜치에 없음을 기록으로 남길 수 없다.
- **Fix:** Task 1에 `OK precondition …`, `OK scratch recheck …`, `OK devfake …` 둘, `OK dry objects unreferenced …`, `OK yml unchanged …`, `NOTE s2f …` 줄들(첫 실행자), Task 3에 `OK precondition …`, `OK yml shape …`, `OK preview shape …`, `OK s2v vs s2f …`, `OK preview objects …`를 더 적었다. 모두 건수와 해시뿐이다.
- **Verification:** 두 verify가 구간 안에서 정확한 줄(`grep -qx`)과 `^FAIL` 없음만 보므로 더한 줄은 판정에 걸리지 않는다. 둘 다 exit 0.

**4. [계획 문구보다 넓게 적음] `## 06-08 값 미리보기`에 답이 나온 과정과 열린 항목도 적음**
- **Found during:** Task 3 (이어 하기 실행)
- **Issue:** 계획 Task 2는 답(값)을 기록에 옮기지 않고 App Store 표기가 같은지만 `APPSTORE_NAME=`으로 적게 한다. 이어 하기 지시는 답이 나온 과정을 값 없이 적고, 확인하지 못한 것을 Phase 10 열린 항목으로 남기라고 했다.
- **Fix:** 값은 적지 않았다. 과정 네 단계, 읽는 법, 확인하지 못한 것 둘을 구간과 이 SUMMARY에 적었다. 06-06·06-07의 답 기록과 같은 꼴이다.
- **Verification:** 새로 쓴 구간·SUMMARY·커밋 메시지에서 값이 든 줄 0(값 파일로 셈). 표식 `S2V_CAND`·`APPSTORE_NAME`·`DEV_RECEIVED`는 줄 머리부터 각 한 번.

---

**Total deviations:** 4 (계획 우선 하나, 비교 방법 하나, 판정 줄 추가 하나, 기록 범위 하나)
**Impact on plan:** 범위는 늘지 않았다. 판정 기준을 바꾼 것이 없고, 계획이 정한 판정 줄은 모두 계획의 글자 그대로 첫 실행에서 나왔다.

## Issues Encountered

- **값 누출 점검이 건너뛰어졌다(`excluded=1`).** 계획 assumptions 둘째 줄이 미리 정한 경우이고 06-01 규칙대로 `leak=skip(no new values)`로 적었다. 그래서 받은 값에 대해서는 패턴 파일 점검 (a)(b)(c)가 한 번도 돌지 않았다. Task 1이 가짜 값으로 보인 것은 점검 도구가 값을 잡는다는 것이지 받은 값이 기록에 없다는 것이 아니다. 실행자가 따로 센 범위는 새로 쓴 글(값 미리보기 구간, 이 SUMMARY, 커밋 메시지)이고 모두 0이다. 06-09·06-12의 같은 점검도 같은 규칙으로 건너뛰게 된다. 위 「열린 항목」 3번이 여기서 나왔다.
- **값을 파일에 넣는 방법.** 값은 `_data/company.yml`을 고치는 편집 도구 호출 한 번에 들어 있었다. 그 밖의 명령 출력, 로그(`$W/p608-t3.log`), 판정 도구 파일에는 값이 없다(도구는 값을 작업 트리 yml에서 읽고 임시 파일은 바로 지운다).
- **Task 1과 Task 3 사이에 HEAD가 움직였다.** `da81ae548042` → `b2644ec30ad3`. 사이의 두 커밋은 인계 파일 둘만 담아 사이트 출력이 같고, `OK s1v same`이 기준 빌드와의 바이트 비교로 다시 봤다. 깨끗함 기록 두 줄의 해시가 다른 것은 이 때문이다.
- **값이 든 로컬 객체.** 값이 든 `_data/company.yml` blob은 `refs/p6-scratch/s2v` 아래 로컬 객체로 있다(계획이 정한 스크래치 ref). 푸시되지 않는 이름이고, 단계 검증 뒤 스크래치와 함께 사용자가 지운다.

## 위협 표 대응

| Threat | 처분 | 한 일 |
|---|---|---|
| T-06-22 (개발자 이름 값이 `.planning`·메시지에 남음) | mitigate | Task 1이 무작위 가짜 값으로 점검이 건너뛰지 않음과 값이 든 `.planning` 시험 객체를 잡음을 먼저 보였다. 받은 값은 `vals`가 excluded로 세어 규칙대로 건너뛰었고, 새로 쓴 글에서 값이 든 줄은 실행자가 세어 0이다. 문서 커밋은 `.planning` 경로 둘만 `git add`했다. 기록에는 건수와 표식만 있다 |
| T-06-23 (승인하지 않은 값이 커밋됨) | mitigate | 이 계획은 값을 커밋하지 않았다. 미리보기 객체는 어떤 브랜치에도 없고(Task 3 verify) `_data/company.yml`은 스테이징하지 않았다. 커밋은 06-09 승인 뒤 |
| T-06-SC (패키지 설치) | mitigate | 아무것도 설치하지 않았다 |

새 위협 표면은 없다(커밋한 사이트 파일과 설정이 없다).

## Known Stubs

없음. 이 계획은 저장소에 코드나 페이지를 넣지 않았다. 자리표시 값을 쓰지 않았다.

## User Setup Required

None - 외부 서비스 설정이 필요하지 않다.

## 뒤 계획이 알아야 할 것

- **06-09 (값·재작성 커밋 후보, 푸시):**
  - precondition의 `DEV_RECEIVED=OK`, `S2V_CAND`, `DRAFT_BLOB`, `DRAFT_APPROVED`가 줄 머리부터 있다.
  - 작업 트리 `_data/company.yml`에는 커밋하지 않은 두 줄이 있다(`git diff --numstat`이 `2 0`). 스테이징한 것은 없다. 이 파일을 되돌리거나 stash하지 않는다.
  - HEAD는 이 계획의 문서 커밋들만큼 앞으로 간다. `refs/p6-scratch/s2v`의 미리보기는 `b2644ec30ad3` 위에 만든 것이라 06-09의 후보와 부모가 다르다(06-09는 자기 후보를 새로 만든다).
  - 값 누출 점검은 같은 규칙으로 `leak=skip(no new values)`가 된다.
  - 소개 문단 수를 세는 식(`VV`, Task 3 action 2번)은 이 값에서 1을 낸다.
- **06-10 (가드):** 값은 이미 정해졌다. 가드의 양성·음성 대조에서 값을 화면에 찍지 않는다(값 파일로 센다).
- **06-11 (기준 문서):** `APPSTORE_NAME=same`이다. 계획 assumptions가 정한 「다르면 차이를 Phase 10 확인 항목으로 넘김」은 해당 없고, 대신 위 「열린 항목」 1·2번(확인하지 못한 전제)을 Phase 10 확인 항목으로 넘길지 그 계획이 본다. 이름 표의 값 칸은 계획대로 「(빈칸)」 그대로 둔다.
- **단계 검증:** 위 「열린 항목」 3번(`06-VALIDATION.md` 「D-02·D-18」 행의 식).
- **Phase 9·10:** 영문판과 콘솔·스토어 체크리스트도 같은 키 `store_developer_name`을 읽는다. Phase 10은 두 스토어의 공개 표시 이름을 값과 대조한다.

## Next Phase Readiness

- 다음 실행 계획은 06-09다. 06-09의 precondition 가운데 이 계획이 만드는 것(`DEV_RECEIVED=OK`, `S2V_CAND`)은 모두 있다.
- D-33 네 항목이 모두 사용자 답으로 닫혔다(①·②와 D-39는 06-06, ③ 해시 `rate_limits` 기간은 재계획 전 결정 D-40, ④는 이 계획).
- 막는 것은 없다. 열린 항목은 위에 있다.

## Self-Check: PASSED

문서 커밋 `21ead38189b1` 뒤에 확인했다.

- FOUND: `.planning/phases/06-data-deletion-rewrite/06-08-SUMMARY.md`
- FOUND: `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md`
- FOUND: `21ead38189b1` (기록과 SUMMARY 문서 커밋, HEAD의 조상. 파일 둘만 담고 삭제한 파일 없음. `_data/company.yml`은 들어 있지 않음)
- 커밋된 `06-EVIDENCE.md`에 `DRY_RUN`, `S2V_CAND`, `APPSTORE_NAME`, `DEV_RECEIVED`가 줄 머리부터 각 한 번 있다.
- 계획 `<verification>` 두 줄:
  1. Task 1·Task 3 verify를 문서 커밋 뒤 bash 임시 파일로 다시 돌려 둘 다 exit 0(커밋 전 두 번 포함 모두 exit 0).
  2. `git log <OPS_SHA>..HEAD -- . ':(exclude).planning'`가 빈 출력이다(종료 코드 0). 이 계획 동안 사이트 파일을 고친 커밋이 없다.
- `refs/p6-scratch/s2v`의 앞 12자리가 `S2V_CAND`(`4505d77840d0`)이고 그 객체는 어떤 브랜치에도 없다(Task 3 verify가 본다).
- 작업 트리 `_data/company.yml`은 문서 커밋 뒤에도 `git diff --numstat`이 `2 0`이고 스테이징한 것이 없다.
- 문서 커밋 전 작업 트리 `scripts/check-site.sh` 통과. 새로 쓴 글(값 미리보기 구간, 이 SUMMARY, 커밋 메시지)에서 받은 값이 든 줄 0, 가짜 이름이 든 줄 0, 경로·토큰 꼴과 홈 경로 0건.
- `check evaluation-scope --plan 06-08 --commits-only`가 이 브랜치의 커밋 한 개(`21ead38189b1`)를 돌려줬다(종료 코드 0).
- `requirements.ready-ids`는 DEL-02·BIZ-05 둘 다 blocked라 요구사항을 닫지 않았다.
- 푸시하지 않았다.

---
*Phase: 06-data-deletion-rewrite*
*Completed: 2026-11-27*
