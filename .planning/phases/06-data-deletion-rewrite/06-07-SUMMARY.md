---
phase: 06-data-deletion-rewrite
plan: 07
subsystem: docs
tags: [data-deletion, legal-draft, scratch-object, render-if-present, user-approval, public-anchors]
status: complete

# Dependency graph
requires:
  - phase: 06-data-deletion-rewrite
    provides: "06-13의 대조표 확정본(RETAINED_ROWS=7, DELETED_ITEMS=8, 고정 줄 아홉)과 데이터 목록 문서 커밋 INV_DEC_SHA=a789cf9679ba"
  - phase: 06-data-deletion-rewrite
    provides: "06-06의 사용자 답 표식(D33_C7=ga, D33_C8=proposal, PUBLIC_COURSE_PERIOD, D39_PATH=none, APPCHECK_ROW=out, AUTHLOG_ROW=phase7, DEVICE_SENTENCE=out, INSTALL_SENTENCE=out)"
  - phase: 06-data-deletion-rewrite
    provides: "06-05의 운영 절차서 작업 13(OPS_SHA=0cc0e1767353)과 06-04의 화면 사실·재기준 목록, 06-01의 스크래치 도구(lib.sh, p6-deletion.mjs)"
provides:
  - "스크래치 원고 `$W/draft/data-deletion.html`과 승인한 원고 blob DRAFT_BLOB=b681410f94c5b44600fe0fddd531b4d963371f2b (DRAFT_APPROVED=b681410f94c5)"
  - "승인한 시험 객체 DRAFT_CAND=608db1ab928f와 스크래치 ref `refs/p6-scratch/draft` (브랜치·태그가 아니라 푸시되지 않음)"
  - "06-EVIDENCE.md 구간 `## 06-07 원고`(판정 줄), `## 06-07 변형`(가짜 값 변형 다섯, 승인 자료), `## 06-07 승인`(답과 답이 나온 과정, 열린 항목 셋)"
  - "공개 앵커 여덟 개의 확정: #request, #location, #google, #apple, #facebook, #kakao, #naver, #line"
affects: [06-08, 06-09, 06-10, 06-11, phase-7, phase-8, phase-9, phase-10]

# Actuals (#2632)
actuals:
  tokens: 3275     # chars/4 over 실현된 diff (06-EVIDENCE.md에 더한 154줄 13099자. SUMMARY 제외. 원고는 저장소 밖 스크래치에 있어 세지 않음)
  tasks: 3
  commits: 0       # 측정값: git rev-list --count plan_head_before..HEAD (SUMMARY를 쓸 때). 계획이 커밋을 「계획 끝 문서 커밋 하나」로 정해 이 SUMMARY와 06-EVIDENCE.md가 그 첫 커밋이다. STATE·ROADMAP 커밋은 그 뒤. 사이트 파일은 고치지 않았다
plan_head_before: 9cd5f6a5f0b471174117a1934e689328194a090a
plan_head_after: 9cd5f6a5f0b471174117a1934e689328194a090a

# Tech tracking
tech-stack:
  added: []
  patterns:
    - "승인 전 원고는 저장소 작업 트리에 두지 않는다. 스크래치 파일과 ref 없는 시험 객체(mkobj)로 check-site·빌드·본문 판정·화면 판정을 하고, 승인 대상은 blob 해시와 `refs/p6-scratch/*` ref로 고정한다"
    - "사실값이 들어가는 문단은 가짜 값 yml 변형 빌드(값 있음, 한 키씩 비움, 모두 비움, 이스케이프)로 render-if-present와 이스케이프를 센다. 실제 값은 쓰지 않는다"
    - "결정 checkpoint의 답은 표식 줄과 「답이 나온 과정」으로 함께 남긴다. 권고가 있었으면 누가 권했는지, 사용자가 물은 것인지 아닌지를 적는다"

key-files:
  created:
    - .planning/phases/06-data-deletion-rewrite/06-07-SUMMARY.md
  modified:
    - .planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md

key-decisions:
  - "06-07: 사용자가 `/data-deletion/` 원고 글, 남는 데이터 표(일곱 행), 공개 앵커 여덟 개(#request, #location, #google, #apple, #facebook, #kakao, #naver, #line)를 approve로 승인했다(2026-11-27 한국 시각). 승인한 원고는 blob b681410f94c5(DRAFT_APPROVED)이고 시험 객체 608db1ab928f가 `refs/p6-scratch/draft`에 붙어 있다. 다른 조항에는 id가 없다. 이 승인은 푸시 승인이 아니고, 승인한 원고는 `updated` 한 줄 말고는 바뀌지 않는다"
  - "06-07: 답이 나온 과정 — 오케스트레이터가 checkpoint 자료 전체를 한 메시지로 보이면서 자기 의견이라고 밝힌 권고(approve, 답이 뒤집힐 조건과 낮은 확신 두 곳 포함)를 사용자가 묻지 않았는데 덧붙였고, 사용자는 그 메시지를 본 뒤 approve 한 낱말로 답했다. 실행자는 고르거나 권하지 않았다. 이 기록을 적은 실행자는 답과 과정을 오케스트레이터가 전한 글로 받았다"
  - "06-07: 승인과 함께 열린 항목 셋을 Phase 7에서 다시 본다(사용자 결정이 아니고 원고는 그대로다): 「검수 대기」 낱말, Google·Apple·Facebook 받는 항목의 회원번호(데이터 목록 구간 B가 먼저, PRIV-10이 같은 표를 씀), 카카오·네이버 연결 해제 안내에 공식 도움말 링크가 없음"
  - "06-07: 위치정보법에 기대는 문장(철회, 파기, 확인자료)은 법률 확인 전 초안으로 승인됐다(D-36, U2 초안 진행). 남는 데이터 표의 두 행(로그 「최대 30일」, 지운 프로필 사진의 보관 사본 「삭제 뒤 최대 7일」)은 prod 사실이 아니라 prod가 넘지 않겠다는 약속이다(06-13)"

patterns-established:
  - "원고의 조건부 문단: 지원 이메일 값이 있어야 뜻이 서는 문단(메일 요청 경로, 메일 요청의 처리 기한, 「메일로는 두 요청만」, 위치정보 철회 3번, 문의처 이메일)은 모두 같은 `support_email` 조건으로 감싼다"
  - "소개 문단은 `section` 밖 최상위 `p` 하나로 두고 개발자 이름 값이 있을 때만 그린다(허용 요소 목록과 `legal.css`는 그대로)"

requirements-completed: []  # 계획 frontmatter는 [DEL-01, DEL-02, DEL-03, DEL-04, DEL-05, DEL-06, DEL-07, BIZ-05]. 이 계획은 원고를 스크래치에 쓰고 승인받았을 뿐 사이트에 넣지 않았다(재작성 커밋은 06-09). requirements.ready-ids도 여덟 개 모두 blocked로 돌려준다(06-08~06-12가 같은 ID를 가짐). 06-01~06-13 SUMMARY와 같은 처리

coverage:
  - id: D1
    description: "스크래치 원고를 ref 없는 시험 객체로 끝까지 판정: check-site 통과, 기준 빌드와의 차이 파일 하나, 본문 판정 일곱 줄(구조·규칙·사실·낱말·동의 설정 문장·기간 문구 9/9·값), 두 엔진 × 두 폭 화면과 앵커 서른두 줄 PASS"
    requirement: "DEL-03"
    verification:
      - kind: other
        ref: "06-07-PLAN.md Task 1 <verify> <automated> (bash 임시 파일, exit 0. 앞 실행자가 두 번, 이어 하기 실행자가 승인 기록 앞뒤로 한 번씩)"
        status: pass
      - kind: automated_ui
        ref: "$W/pw/p6-deletion.mjs http://127.0.0.1:4603 --shot $W/cap/draft (Chromium·WebKit × 375·1280, PASS deletion. 캡처 넷)"
        status: pass
    human_judgment: true
    rationale: "verify는 행 수, 고정 낱말, 고정 문구의 있음·없음만 센다. 문장이 데이터 목록·대조표·운영 절차서의 사실만 쓰는지(계획 prohibition 넷의 판정 방식이 judgment)와 글자 단위 표현은 사람이 읽어야 한다. 사용자가 Task 3에서 글 전체와 대조를 보고 approve로 답했다. 위치정보 조항은 법률 확인 전 초안이다"
  - id: D2
    description: "가짜 값 변형 빌드 다섯(nophone, nodev, noemail, empty, escape)에서 값이 없는 항목이 문단째 숨고 값은 이스케이프되어 나옴, 가짜 값 빌드와 yml에 실제 도메인 주소 0건"
    requirement: "BIZ-05"
    verification:
      - kind: other
        ref: "06-07-PLAN.md Task 2 <verify> <automated> (bash 임시 파일, exit 0. 앞 실행자가 두 번, 이어 하기 실행자가 승인 기록 앞뒤로 한 번씩)"
        status: pass
    human_judgment: false
  - id: D3
    description: "원고 글·남는 데이터 표·공개 앵커 여덟 개에 대한 사용자 승인 기록: DRAFT_APPROVED=b681410f94c5, 답이 나온 과정, 열린 항목 셋"
    requirement: "DEL-07"
    verification:
      - kind: other
        ref: "계획 <verification> 2번: refs/p6-scratch/draft의 앞 12자리 = DRAFT_CAND, 그 객체의 data-deletion/index.html blob = DRAFT_BLOB = 스크래치 원고의 git hash-object. DRAFT_APPROVED가 줄 머리부터 한 번이고 DRAFT_BLOB 앞 12자리와 같음"
        status: pass
    human_judgment: true
    rationale: "기록이 사용자의 실제 답과 같은지는 사용자만 확인할 수 있다. 이 실행자는 답(approve)과 과정을 오케스트레이터가 전한 글로 받았고 사용자와 직접 주고받지 않았다. 앵커 이름과 보존 고지는 costly로 표시된 결정이고(계획 Task 3 reversibility), 묻지 않은 권고가 붙은 자료를 본 뒤 나온 답이라는 점도 사용자가 읽고 확인할 만하다"
  - id: D4
    description: "이 계획 동안 사이트 파일을 고친 커밋 없음, 원고는 어떤 브랜치에도 없음, 기록에 경로·토큰 꼴과 홈 경로 0건, 값 누출 점검 건너뜀(새 값 없음)"
    verification:
      - kind: other
        ref: "계획 <verification> 3번: `git log 9cd5f6a5f0b4..HEAD -- . ':(exclude).planning'` 빈 출력, `OK site-clean 06-07-t1`·`t2`·`t3` 줄, `git branch -a --contains 608db1ab928f` 빈 출력, 06-EVIDENCE.md의 LPX grep 0건(종료 코드 1)·홈 경로 0건, vals filled=0 emitted=0, check-site 통과(작업 트리)"
        status: pass
    human_judgment: false

# Metrics
duration: 1h 8m (사용자 대기 포함)
completed: 2026-11-26
---

# Phase 6 Plan 07: 삭제 안내 원고 판정과 원고·표·앵커 승인 Summary

**`/data-deletion/` 원고를 저장소 밖 스크래치와 ref 없는 시험 객체로 끝까지 판정하고(check-site, 본문 판정 일곱 줄, 두 엔진 × 두 폭 PASS, 가짜 값 변형 다섯), 사용자가 원고 글·남는 데이터 표 일곱 행·공개 앵커 여덟 개를 approve로 승인해 원고 blob `b681410f94c5`를 재작성 커밋(06-09)의 재료로 고정했다**

## Performance

- **Duration:** 1h 8m (사용자 대기 포함. Task 3 checkpoint의 답을 기다린 시간이 들어 있다)
- **Started:** 2026-11-26T22:09:06Z (한국 시각 2026-11-27 07:09)
- **Completed:** 2026-11-26T23:17Z (한국 시각 2026-11-27 08:17. 승인 기록과 계획 끝 검증이 끝난 시각. SUMMARY 작성과 커밋은 그 뒤)
- **Tasks:** 3 (tracer 하나, auto 하나, blocking-human 결정 checkpoint 하나)
- **Files modified:** 1 (`06-EVIDENCE.md`, 154줄 더함) + 이 SUMMARY. 사이트 파일은 0
- **실행자 세션:** 둘. 첫 세션이 Task 1·2와 Task 3 질문 자료를, 둘째 세션(이 SUMMARY를 쓴 세션)이 Task 3 답 기록과 마무리를 했다. Task 1·2의 내용은 첫 세션이 `06-EVIDENCE.md`에 적은 기록에서 옮겼고, 둘째 세션은 원고·빌드·캡처를 다시 만들지 않았다

## Accomplishments

- **원고와 끝까지 판정 (Task 1, tracer):** 원고를 스크래치 `$W/draft/data-deletion.html`에만 쓰고 HEAD에 얹은 ref 없는 시험 객체 `608db1ab928f`(`DRAFT_CAND`)로 판정했다. 원고 글은 이 문서와 검증 기록에 옮기지 않았다(06-09 커밋에 들어간다).
  - 사실의 출처는 `INV_DEC_SHA`의 데이터 목록, 06-13 대조표 확정본과 고정 줄 아홉, 운영 절차서 작업 13, 지원 페이지 FAQ의 경로 문자열이다. 대조표는 다시 나누지 않았다.
  - 조항 순서: 소개 문단(개발자 이름 값이 있을 때만) → `#request` → 처리 기간과 완료 알림 → 지워지는 데이터(여덟 항목) → 남는 데이터(표 일곱 행) → 일부만 지우기 → `#location` → 제공자 여섯(`#google`·`#apple`·`#facebook`·`#kakao`·`#naver`·`#line`) → 문의처. id는 여덟 개뿐이다.
  - front matter: `title`·`eyebrow` 그대로, `heading`은 D-17 글자, 새 `description`, `updated`. 검색 제외 키와 끝 안내 `footer`가 없다(U14).
  - 판정 줄(모두 기대값): `check-site: 통과 (커밋 608db1ab928f, …)`, `OK diff draftreal only=data-deletion/index.html`, `OK draft structure … figures=1/1 tables=1 retained=7 deleted=8`, `OK draft rules class=0 style=0 extra-elements=0 u10=0 robots=0 temp=0 absolute=0 thirtyday=0`, `OK draft facts faqpath=1 tenday=1 promptly=2 locinfo=2 evidence=3 evdestroy=1 reply=3 disconnect-links=4 reqphrase=1`, `OK draft words nonpublic=1 oldprivate=0 oldscope=0 menus=6 allrec-location=2 sixmonth-location=1 code184=0`, `OK draft locconsent inventory=1 draft=1`, `OK draft periods 9/9`, `OK draft values mailto=2 reqmailto=1 reqli=4 phone=1 dev=1 escaped=ok source-values=0 data-refs=21`.
  - 화면: 가짜 값 빌드를 Chromium·WebKit × 375·1280으로 열어 문맥 네 줄과 앵커 서른두 줄이 모두 `ok`(`ok-end` 없음), 마지막 줄 `PASS deletion`. 1280에서는 첫 화면에 요청 조항 제목과 첫 mailto가, 375에서는 요청 조항 제목이 보인다.
  - 첫 판정이 모두 통과한 뒤 문장을 두 번 다듬어 판정을 다시 했다(`#location` 2번 항목과 확인자료 보관 문장, 공개 코스 행의 남는 이유). 기록의 줄은 마지막 후보의 출력이다.
- **가짜 값 변형과 승인 자료 (Task 2):** `full.yml`(일곱 키 모두 가짜 값)에서 한 곳씩 바꾼 yml 다섯으로 `DRAFT_CAND`를 변형 빌드했다.

| 변형 | 줄 | 뜻 |
|---|---|---|
| nophone | `intro=1 mailto=2 reqmailto=1 phone=0 contact=1 ids=8` | 전화 문단만 숨음 |
| nodev | `intro=0 mailto=2 reqmailto=1 phone=1 contact=1 ids=8` | 소개 문단만 숨음 |
| noemail | `intro=1 mailto=0 reqmailto=0 phone=1 contact=1 ids=8` | 메일 경로 다섯 곳이 숨음 |
| empty | `intro=0 mailto=0 reqmailto=0 phone=0 contact=0 ids=8` | 문의처 조항 전체가 숨음 |
| escape | `esc=1 raw=0` | 값이 이스케이프되어 한 번 나옴 (T-06-18) |

  - 앵커 여덟 개는 어느 변형에서도 그대로다. 가짜 yml과 `d-full` 빌드에 실제 도메인 주소는 0건이다(`OK variant fake-only yml=0 d-full=0`, T-06-21). 캡처 `OK captures draft=4`.
  - 승인 자료: `$W/draft/preview.txt`(가짜 값 빌드의 본문을 태그를 지운 글로 바꾼 것)와 캡처 `$W/cap/draft/{chromium,webkit}-{375,1280}.png`.
  - 승인 대상 고정: `DRAFT_BLOB=b681410f94c5b44600fe0fddd531b4d963371f2b`, `refs/p6-scratch/draft` → `DRAFT_CAND`. 그 뒤로 원고를 고치지 않았다.
- **승인 (Task 3, blocking-human 결정 checkpoint):** 사용자가 `approve`로 답했다. `06-EVIDENCE.md` 구간 `## 06-07 승인`에 `DRAFT_APPROVED=b681410f94c5`와 답이 나온 과정, 열린 항목 셋을 적었다. 공개 앵커 여덟 개(`#request`, `#location`, 제공자 여섯)가 이 승인으로 정해졌다.

## Task Commits

1. **Task 1: 원고를 스크래치에 쓰고 시험 객체로 끝까지 판정 (tracer)** — 커밋 없음. 원고는 저장소 밖에 있고 기록은 계획 끝 문서 커밋에 들어간다. `OK site-clean 06-07-t1 9cd5f6a5f0b4`. verify exit 0을 두 번 확인한 뒤(tracer 관문) Task 2로 넘어갔다.
2. **Task 2: 가짜 값 변형, 캡처, 승인 글, 승인 대상 고정** — 커밋 없음(같은 규칙). `OK site-clean 06-07-t2 9cd5f6a5f0b4`.
3. **Task 3: 원고 글·표·앵커 승인** — 커밋 없음(checkpoint). 답 `approve`. `OK site-clean 06-07-t3 9cd5f6a5f0b4`.

**Plan metadata:** 계획 output이 「SUMMARY와 `06-EVIDENCE.md`는 같은 문서 커밋」으로 정했다. 그 문서 커밋은 `0255b12b7814`이고, 이 줄의 해시와 Self-Check, STATE·ROADMAP 진행표는 그 뒤 docs 커밋으로 들어간다(06-01~06-13과 같은 순서). 푸시하지 않는다. 이 문서 커밋들은 06-09의 첫 푸시에 함께 나간다.

## Files Created/Modified

- `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md` - 구간 `## 06-07 원고`(`DRAFT_CAND`, 판정 줄), `## 06-07 변형`(`DRAFT_BLOB`, 변형 다섯 줄, Task 3 질문 자료), `## 06-07 승인`(`DRAFT_APPROVED`, 답이 나온 과정, 열린 항목)
- `.planning/phases/06-data-deletion-rewrite/06-07-SUMMARY.md` - 이 문서
- 저장소 밖(커밋되지 않음): 스크래치 `$W/draft/`(원고, 승인 글), `$W/yml/`(가짜 값 yml), `$W/draftreal/`·`$W/d-<변형>/`(빌드), `$W/cap/draft/`(캡처), 판정 도구 `$W/t1-build.sh`·`t1-judge.sh`·`t2-variants.sh`·`t2-preview.py`·`t2-fix.sh`, 스크래치 ref `refs/p6-scratch/draft`. 단계 검증 뒤 사용자가 지울 때까지 그대로 둔다

## Decisions Made

### 사용자 결정 (Task 3)

- **답:** `approve`. 원고 글, 남는 데이터 표, 공개 앵커 여덟 개를 승인하고 개발자 이름 값 받기(06-08)로 진행한다.
- **답이 나온 과정** (오케스트레이터가 전한 그대로. 자세한 글은 `06-EVIDENCE.md` `## 06-07 승인`):
  1. 오케스트레이터가 checkpoint 자료 전체를 한 메시지로 사용자에게 전했다: 승인 글 전체, 남는 데이터 표와 06-13 고정 줄·데이터 목록 행의 대조, `#location` 문장들과 목록 근거, 메뉴·요청 문구와 목록·운영 절차서 작업 13의 대조, 앵커 여덟 개, 판정 줄, 캡처 경로, 앞 실행자의 「볼 곳」 메모, 위치정보 조항이 법률 확인 전 초안이라는 것.
  2. 앞 실행자는 어느 선택지도 고르거나 권하지 않았다.
  3. 오케스트레이터가 같은 메시지에 자기 의견이라고 밝힌 권고 구간을 덧붙였다. 권한 답은 `approve`이고, 답이 뒤집힐 조건(회원번호를 첫 게시부터 맞추려면 `revise`, 위치정보 조항의 법률 확인을 먼저 받으려면 `hold`)과 확신이 낮은 두 곳(회원번호 항목, 카카오·네이버 문장)을 함께 밝혔다.
  4. 사용자는 이 세션에서 권고를 묻지 않았다. 오케스트레이터가 스스로 덧붙였다.
  5. 사용자가 그 메시지를 본 뒤 `approve` 한 낱말로 답했다.
- **읽는 법:** 사용자가 낸 답이고, 묻지 않은 권고가 붙은 자료를 본 뒤 낸 답이다. 실행자는 고르거나 권하지 않았다. 이 SUMMARY를 쓴 실행자는 답과 과정을 오케스트레이터가 전한 글로 받았고 사용자와 직접 주고받지 않았다.
- **이 승인이 아닌 것:** 푸시 승인이 아니다. 개발자 이름 값도 아직 받지 않았다(D-33 ④, 06-08 Task 2).

### 실행자가 고른 표기 (새 사실 없음. 승인 자료에 함께 보였다)

- **지원 이메일 조건의 범위:** 메일 요청 경로, 메일 요청의 처리 기한 문단, 「메일로는 두 요청만 받는다」 문단, `#location` 3번 항목, 문의처 이메일 문단을 모두 `support_email` 값이 있을 때만 그린다. 본문 mailto는 `#request`와 문의처 두 곳이다.
- **넣지 않은 선택 문장:** 계획이 「쓸 수 있다」고 한 기기 안 원시 위치 기록 문장은 넣지 않았다. 목록에 비정상 종료 때 남는 기간이 「미확인」이고 계정이 남는 삭제에서는 기기에 남은 기록이 다시 올라올 수 있다고 적혀 있어서다.
- **표 밖 문장:** `D33_C7=ga`라 표 아래 `aside`에 둘러보기 문장 하나만 두었다. 기기 안 설정 문장, installation ID 문장, 자동 삭제 문장은 없다(`DEVICE_SENTENCE=out`, `INSTALL_SENTENCE=out`).

## 열린 항목 (승인과 함께 남긴 것. 사용자 결정이 아니고 원고는 그대로다)

오케스트레이터는 승인 자료를 보인 메시지에서, 답이 `approve` 한 낱말이면 아래 셋을 Phase 7에서 다시 볼 열린 항목으로 적겠다고 알렸고 사용자는 반대하지 않았다.

1. **「공개하지 않은 코스(비공개·검수 대기 등)」의 「검수 대기」.** 데이터 목록 구간 G의 공개하지 않은 코스 행에 같은 낱말이 있다. 06-CONTEXT D-39는 「앞으로 생길 검수 대기」라고 적는다.
2. **Google·Apple·Facebook 섹션의 받는 항목에 회원번호가 없다.** 데이터 목록 구간 B의 세 행은 이메일·이름·사진(Apple은 이메일·이름)만 적고, 구간 A `linkedProviders` 행은 「로그인 제공자 응답의 회원번호」를 기록한다고 적는다. 고치려면 구간 B가 먼저이고 Phase 7 처리방침(PRIV-10)이 같은 표를 쓴다. 앱이 이 세 제공자의 회원번호를 실제로 기록하는지는 이번에 코드에서 확인하지 않았다.
3. **카카오·네이버의 연결 해제 안내가 공식 도움말 링크 없이 문장뿐이다.** 두 서비스의 실제 메뉴 이름은 확인하지 못했다.

앞 실행자가 승인 자료와 함께 알린 것 가운데 그대로 남은 것(승인된 원고의 모양이다):

- `#location` 파기 문장의 「(2~4번)」은 지원 이메일 값이 없는 변형에서 철회 항목이 셋이 되어 번호가 어긋난다. 제공자 섹션과 「일부만 지우기」의 「지원 이메일」 낱말도 그 변형에서는 주소 없이 남는다. 라이브에는 값이 있고 06-10 가드가 본문 mailto를 지킨다.
- 둘러보기 문장의 낱말 「둘러보기」와 앱 화면 낱말 「게스트로 이용 중」이 다르다(06-06 기록).
- 375 폭에서 남는 데이터 표의 기간 칸이 오른쪽에서 잘려 보인다. 표가 `figure` 안에서 가로로 밀리는 모양이고(법적 본문 작성 규칙 D-07) 페이지 가로 넘침 판정은 통과했다.
- `draftreal`(저장소의 `_data/company.yml`로 빌드)에는 개발자 이름 키가 아직 없어 소개 문단이 0이다. 06-08이 값을 받기 전 상태다.

오케스트레이터가 전한 확인(이 실행자는 다시 확인하지 않았다): 원고의 외부 도움말 링크 넷(Google, Apple, Facebook, LINE)이 HTTP 200과 앱 연결 관리·해제에 관한 제목을 돌려줬다는 것, 원고의 기간 문구·「6개월」·동의 설정 문장·메뉴 문구·10일과 직접 해제 문장이 데이터 목록과 운영 절차서에 글자 그대로 있다는 것. 뒤쪽 가운데 기간 문구와 「6개월」, 동의 설정 문장은 Task 1 verify(`OK draft periods 9/9`, `OK draft locconsent`)가 따로 본다.

06-06·06-13이 연 항목(prod의 `mail` 대기열 발송, App Check 토큰·기기 안 설정·installation ID의 Phase 7 처리, D-26과 앱 문서의 익명 자동 정리 어긋남, prod 전제 번호 다섯과 D-33 ② 추가 전제 다섯)은 이 계획이 닫지 않았다.

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 2 - 조건 없는 문단이 주소 없이 남음] 「메일로는 두 요청만 받는다」 문단을 목록 아래에 두고 이메일 값 조건으로 감쌈**
- **Found during:** Task 1 (원고 2번 (f))
- **Issue:** 계획은 이 문단을 「일부만 지우기」 목록 앞에 조건 없이 적었다. 지원 이메일 값이 없으면 메일로 요청하라는 문장만 남고 주소가 없다(render-if-present).
- **Fix:** `#request` ②·처리 기간의 메일 문단·`#location` 3번과 같은 `support_email` 조건으로 감싸고 목록 아래에 두었다.
- **Files modified:** 스크래치 원고(저장소 밖)
- **Verification:** `OK variant noemail … mailto=0 reqmailto=0 …`. 승인 자료의 「함께 알린 것」 6번으로 사용자에게 보였다.
- **Committed in:** 해당 없음(원고는 06-09가 커밋한다)

**2. [계획에 없는 판정 줄] `OK variant fake-only yml=0 d-full=0`**
- **Found during:** Task 2
- **Issue:** 계획 6번이 적으라고 한 줄은 변형 다섯 줄과 캡처 수 줄이다. 가짜 값만 썼다는 것(T-06-21)을 기록으로 남길 줄이 없었다.
- **Fix:** 가짜 yml 폴더와 `d-full` 빌드에 실제 도메인 주소가 0건임을 센 줄을 하나 더 적었다(grep 종료 코드 1 확인).
- **Verification:** Task 2 verify가 같은 사실을 따로 본다(exit 0). 더한 줄은 `OK variant <다섯 이름>` 판정에 걸리지 않는다.

**3. [계획 우선] 실행자 규약의 task별 커밋 대신 계획의 커밋 구조를 따름**
- **Found during:** Task 1
- **Issue:** 실행자 규약은 task마다 커밋하게 하지만, 계획은 원고를 승인 전에 저장소에 넣지 않게 하고(prohibition) SUMMARY와 `06-EVIDENCE.md`를 계획 끝 문서 커밋 하나로 넣게 한다. 06-01 규칙은 `gsd-tools query commit`도 쓰지 않게 한다.
- **Fix:** Task 1·2·3은 커밋하지 않았다. 문서 커밋은 메시지 파일로 `git commit -F`했다. 06-05·06-06·06-13과 같은 처리다.
- **Verification:** `git rev-list --count 9cd5f6a5f0b4..HEAD`가 SUMMARY를 쓸 때 0.

**4. [계획 문구보다 넓게 적음] `## 06-07 승인`에 답이 나온 과정과 열린 항목도 적음**
- **Found during:** Task 3 (이어 하기 실행)
- **Issue:** Task 3 수용 기준은 approve면 그 구간에 「답과 `DRAFT_APPROVED=…`만 적었다」고 한다(괄호 설명은 승인 대상 blob과 ref를 다시 고정하지 않는다는 뜻). 이어 하기 지시는 답이 나온 과정과 열린 항목 셋을 같은 구간에 사실대로 적으라고 했다.
- **Fix:** 새 표식은 `DRAFT_APPROVED` 하나뿐이고 blob·ref는 다시 고정하지 않았다. 그 밖에 답이 나온 과정, 열린 항목 셋, 오케스트레이터가 전한 확인, 깨끗함 기록 줄(`OK site-clean 06-07-t3`)을 적었다. 06-06 `## 06-06 결정`의 「Task 3 답」과 같은 꼴이다.
- **Verification:** `grep -c '^DRAFT_APPROVED='`가 1, `DRAFT_BLOB`·`DRAFT_CAND`도 줄 머리부터 각 1. 기록 뒤 Task 1·2 verify가 다시 exit 0.

---

**Total deviations:** 4 (Rule 2 하나, 판정 줄 추가 하나, 계획 우선 하나, 기록 범위 하나)
**Impact on plan:** 범위는 늘지 않았다. 1번은 원고의 모양을 바꾼 것이라 승인 자료에 따로 보였고 사용자가 승인한 원고에 들어 있다. 4번은 기록을 더한 것뿐이다.

## Issues Encountered

- 첫 판정이 모두 통과한 뒤에도 문장을 두 번 다듬어 판정을 3번부터 다시 했다(앞 두 시험 객체는 ref 없이 남아 있다). 판정 실패 때문이 아니라 목록 글자에 더 가깝게 맞춘 것이다.
- 이어 하기 지시는 앞 실행자의 「볼 곳」 메모를 열한 가지라고 적었고, 검증 기록의 「함께 알린 것」은 아홉 줄이다. 어느 쪽이 사용자에게 보인 수인지 이 실행자는 확인하지 못했다. 두 수를 그대로 기록에 적었다.

## 위협 표 대응

| Threat | 처분 | 한 일 |
|---|---|---|
| T-06-18 (`_data` 값의 HTML 주입) | mitigate | 원고의 모든 값 출력에 `\| escape`. escape 변형이 `esc=1 raw=0`. `description`에는 값과 특수문자가 없다 |
| T-06-19 (`mailto:` 헤더 주입) | accept | 값은 운영자 고정값이고 `\| escape`를 거친다 |
| T-06-20 (앱·운영과 다른 약속을 심사에 제출) | mitigate | 표 행 수와 고정 줄 아홉이 대조표·목록과 같음을 verify가 봤고(`retained=7 deleted=8`, `periods 9/9`), 사용자가 대조 자료를 보고 승인했다. 열린 항목 셋은 위에 남겼다 |
| T-06-21 (실제 값이 승인 자료·기록에 남음) | mitigate | 가짜 값만 썼다. `OK variant fake-only yml=0 d-full=0`, 값 누출 점검은 새 값이 없어 건너뜀(`vals filled=0 emitted=0 excluded=0`) |
| T-06-48 (메뉴·요청 이름이 앱·절차서와 다름) | mitigate | `OK draft words … menus=6 … oldprivate=0 oldscope=0 … code184=0`, Task 3에서 목록·절차서와 나란히 보임 |
| T-06-SC (패키지 설치) | mitigate | 아무것도 설치하지 않았다 |

새 위협 표면은 없다(사이트 파일과 설정을 고치지 않았다. 원고는 아직 저장소 밖이다).

## Known Stubs

없음. 이 계획은 저장소에 코드나 페이지를 넣지 않았다. 원고에는 자리표시 문구가 없고 값이 없는 항목은 문단째 숨는다(변형 다섯 줄).

## User Setup Required

None - 외부 서비스 설정이 필요하지 않다.

## 뒤 계획이 알아야 할 것

- **06-08 (개발자 이름 값 받기):** precondition의 `DRAFT_APPROVED`, `DRAFT_BLOB`, `refs/p6-scratch/draft`가 모두 있다. 승인한 원고는 `git cat-file blob <DRAFT_BLOB>`로 꺼낸다. 작업 트리의 사이트 파일과 `_data/company.yml`은 HEAD와 같다. 열린 checkpoint는 D-33 ④(스토어 개발자 이름 값) 하나다.
- **06-09 (값·재작성 커밋 후보, 푸시):** 승인한 blob에서 `updated` 한 줄만 바꾼다. 이 계획의 문서 커밋들은 푸시하지 않았고 그 첫 푸시에 함께 나간다. 푸시 승인은 그때 SHA로 따로 받는다.
- **06-10 (가드):** 원고 소개 문단의 앞부분은 「러닝펜슬(개발자 」 글자 그대로다. 본문 mailto는 두 곳(`#request`, 문의처)이다.
- **06-11 (기준 문서):** 소개 문단이 `section` 밖 최상위 `p`라는 것을 CONVENTIONS에 후속 글머리로 적는다(계획 assumptions). `legal.css`와 머리 주석은 고치지 않았다.
- **Phase 7:** 위 열린 항목 셋. 2번은 데이터 목록 구간 B와 PRIV-10에 닿는다.
- **Phase 7·8·9·10:** 앵커 여덟 개 이름은 이 승인으로 정해졌다. 콘솔(Facebook Data Deletion Instructions URL 등)과 뒤 문서가 이 이름으로 가리킨다.

## Next Phase Readiness

- 다음 실행 계획은 06-08이다. 06-08의 precondition 가운데 이 계획이 만드는 것은 모두 있다.
- 막는 것은 없다. 위치정보 조항은 법률 확인 전 초안으로 승인됐고(D-36), 열린 항목은 위에 있다.

## Self-Check: PASSED

문서 커밋 `0255b12b7814` 뒤에 확인했다.

- FOUND: `.planning/phases/06-data-deletion-rewrite/06-07-SUMMARY.md`
- FOUND: `.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md`
- FOUND: `0255b12b7814` (기록과 SUMMARY 문서 커밋, HEAD의 조상. 파일 둘만 담음)
- 커밋된 `06-EVIDENCE.md`에 `DRAFT_APPROVED=b681410f94c5`가 줄 머리부터 한 번 있고, `DRAFT_BLOB`·`DRAFT_CAND`도 줄 머리부터 각 한 번이다.
- 계획 `<verification>` 세 줄:
  1. Task 1·2 verify를 승인 기록을 적은 뒤 bash 임시 파일로 다시 돌려 둘 다 exit 0.
  2. `git rev-parse refs/p6-scratch/draft`의 앞 12자리가 `DRAFT_CAND`(`608db1ab928f`)이고 `git rev-parse "refs/p6-scratch/draft:data-deletion/index.html"`이 `DRAFT_BLOB`이다. 스크래치 원고의 `git hash-object`도 같다.
  3. `git log 9cd5f6a5f0b4..HEAD -- . ':(exclude).planning'`가 빈 출력이다(이 계획 동안 사이트 파일을 고친 커밋 없음). 원고 후보 객체는 어떤 브랜치에도 없다.
- 문서 커밋 전 작업 트리 `scripts/check-site.sh` 통과, 값 누출 점검은 `vals filled=0 emitted=0 excluded=0`이라 건너뜀, 두 파일과 커밋 메시지에 경로·토큰 꼴과 홈 경로 0건.
- `check evaluation-scope --plan 06-07 --commits-only`가 이 브랜치의 커밋 한 개(`0255b12b7814`)를 돌려줬다(종료 코드 0).
- `requirements.ready-ids`는 여덟 ID 모두 blocked라 요구사항을 닫지 않았다.
- 푸시하지 않았다.

---
*Phase: 06-data-deletion-rewrite*
*Completed: 2026-11-26*
