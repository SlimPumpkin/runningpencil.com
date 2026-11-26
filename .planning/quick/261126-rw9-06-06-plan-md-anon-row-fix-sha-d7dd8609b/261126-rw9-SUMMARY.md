---
phase: quick-261126-rw9
plan: 01
subsystem: planning-docs
tags: [phase-06, data-deletion, anon-row-fix, plan-fix, DEL-03]
status: complete
requires:
  - "06-EVIDENCE.md 「익명 행 정정 (재기준 커밋 뒤)」의 표식 ANON_ROW_FIX_SHA (정정 커밋 d7dd8609bcb9)"
provides:
  - "익명 행 정정에 맞춘 06-06-PLAN.md (읽는 시점 ANON_ROW_FIX_SHA, 정정한 익명 사실, rate_limits 확인 문구 둘)"
  - "06-RESEARCH.md C-7 머리의 정정 메모 한 줄"
  - "STATE.md Blockers의 06-06 계획 수정 줄 닫힘 (미커밋)"
affects:
  - ".planning/phases/06-data-deletion-rewrite/06-06-PLAN.md 실행 (Task 1 읽는 시점, Task 2 precondition과 action)"
tech-stack:
  added: []
  patterns: []
key-files:
  created:
    - .planning/quick/261126-rw9-06-06-plan-md-anon-row-fix-sha-d7dd8609b/261126-rw9-SUMMARY.md
  modified:
    - .planning/phases/06-data-deletion-rewrite/06-06-PLAN.md
    - .planning/phases/06-data-deletion-rewrite/06-RESEARCH.md
    - .planning/STATE.md
decisions:
  - "06-06은 데이터 목록을 재기준 커밋이 아니라 익명 행 정정 커밋(표식 ANON_ROW_FIX_SHA)에서 읽는다"
  - "06-06 Task 2 precondition의 확인 문구를 넷에서 여섯으로 늘려 정정 전 목록에서는 멈추게 했다"
metrics:
  duration: "약 12분 (시작 시각을 따로 재지 않은 어림값)"
  completed: 2026-11-26
  tasks: 3
  files: 3
actuals:
  tokens: 29200      # 고친 세 파일 전체 글자 수 / 4 (116802자). 기준 대비 차이만 세면 14653자 / 4 = 3663
  tasks: 3
  commits: 1         # 측정: git rev-list --count ff7d9273fe41..HEAD
plan_head_before: ff7d9273fe412dc2e31f38d922c0f3c839932740
plan_head_after: a88afe93e562be8ce86b6f6b7b2e6c49f3279255
---

# Phase quick-261126-rw9 Plan 01: 06-06 계획을 익명 행 정정에 맞춤 Summary

06-06-PLAN.md가 데이터 목록을 익명 행 정정 커밋(표식 `ANON_ROW_FIX_SHA`)에서 읽고, Task 2가 사용자에게 정정한 구간 A 익명 행의 사실(익명 호출이 만드는 uid `rate_limits` 기록 포함)을 보이도록 교체표 R1–R12를 글자 그대로 적용했습니다.

## 결과

| 항목 | 값 |
|---|---|
| 커밋 | `a88afe9` (`a88afe93e562be8ce86b6f6b7b2e6c49f3279255`) `docs(06): 06-06 계획을 익명 행 정정에 맞춤` |
| 커밋에 든 파일 | `.planning/phases/06-data-deletion-rewrite/06-06-PLAN.md`, `.planning/phases/06-data-deletion-rewrite/06-RESEARCH.md` (둘뿐) |
| 사이트 점검 | `check-site: 통과 (작업 트리, jekyll 3.10.0)` |
| 검증 | `RESULT pass pre`, `RESULT pass t1`, `RESULT pass t2`, `RESULT pass t3` (FAIL 줄 0) |
| 쓴 트레일러 | `Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>` (세션 attribution 지시와 오케스트레이터가 준 값이 같음. `Claude-Session:` 줄은 지시가 없어 만들지 않음) |
| 미커밋 | `.planning/STATE.md` (지운 줄 1·더한 줄 0), quick 폴더 (`261126-rw9-PLAN.md`, `261126-rw9-verify.sh`, 이 SUMMARY) |
| 푸시 | 하지 않음 |

## 한 일

### Task 1 (tracer): 06-06-PLAN.md에 R1–R10 적용

- 편집 전 `verify.sh pre`가 exit 0 (세 파일이 기준 커밋 `ff7d9273fe41`과 같음, 스테이징 없음, 표식이 `d7dd8609bcb9`를 가리킴).
- 옛 재기준 표식 이름은 파일에 0번, 새 표식 `ANON_ROW_FIX_SHA`는 20·67·84·87·93·120·123·124·154행 아홉 줄에 있습니다.
- 바뀐 줄은 20·67·84·87·93·98·120·123·124·154행 열 줄뿐이고 줄 수는 그대로입니다.
- Task 2 precondition의 확인 문구는 여섯이고 모두 정정 목록에 1번씩 있습니다. 새 문구 둘은 정정 전 목록에 0번이라 정정 전 목록에서는 precondition이 멈춥니다.
- Task 2·3 options 블록 39줄, 124행의 어긋남 문단 이하, (나) 문장과 `D33_C7_SENTENCE` 기준은 글자 그대로입니다.
- tracer 확인: R10까지 고친 뒤 `verify.sh t1`을 한 번 돌려 통과를 보고 Task 2로 넘어갔습니다 (t1은 뒤의 t3 안에서 다시 돌았습니다). 이 task에서는 스테이징도 커밋도 하지 않았습니다.

### Task 2: 06-RESEARCH.md R11, STATE.md R12

- 06-RESEARCH.md: C-7 머리 바로 아래에 정정 메모 한 줄과 빈 줄 하나를 넣었습니다. 기준 대비 차이는 더한 줄 2·지운 줄 0, 덩어리는 `@@ -308,0 +309,2 @@` 하나입니다. 선택지 (가)(나)(다) 세 줄과 그 밖의 줄은 그대로입니다.
- STATE.md: `### Blockers/Concerns`의 「Phase 5 후속:」 묶음 맨 끝 줄(06-06 계획 수정을 요구하던 줄) 하나만 지웠습니다. 그 밖의 줄은 고치지 않았고 커밋하지 않았습니다.

### Task 3: 점검, 커밋, 범위 확인

- `scripts/check-site.sh` 통과 뒤 두 단계 파일만 이름으로 스테이징해 저장소 밖 임시 메시지 파일로 `git commit -F`했습니다. 임시 파일은 지웠습니다.
- 커밋 뒤 `verify.sh t3` 통과: HEAD 커밋 파일 둘, 기준 뒤 커밋된 파일 둘, 제목 `docs(06): `, 끝 트레일러, 메시지와 더한 줄에 이메일 꼴·홈 경로 없음, 미커밋 경로는 STATE.md와 quick 폴더뿐, 사이트 파일 변경 없음.

## Deviations from Plan

### 절차상 어긋남 (결과는 교체표와 글자 단위로 같음)

**1. R9(124행) Edit의 old_string·new_string을 줄 전체가 아니라 바뀌는 구간으로 줌**
- **Found during:** Task 1
- **내용:** 계획은 old_string을 「옛 줄」 한 줄 전체로 주라고 했습니다. R9에서는 그 줄 가운데 바뀌는 구간(「먼저 precondition의 …」부터 「**어긋남 하나를 함께 보인다:**」까지)을 교체표에서 그대로 복사해 주었습니다. 줄 머리와 어긋남 문단 이하는 Edit가 건드리지 않았습니다.
- **확인:** `verify.sh t1`의 `R9 옛 줄 기준에 1·지금 0, 새 줄 지금 1`, `124행 어긋남 문단부터 끝까지 글자 그대로`, `124행 머리 글자 그대로`가 모두 OK입니다. 결과 줄은 교체표의 새 줄과 글자 단위로 같습니다.
- **Commit:** a88afe9

### 실행 지시에 따라 건너뛴 기본 절차

- task마다 커밋하지 않고 Task 3에서 커밋 하나만 했습니다 (계획의 커밋 규칙).
- `gsd-tools`의 상태·로드맵·요구사항·커밋 명령과 broken-windows 기록을 돌리지 않았습니다. STATE.md 기록과 문서 커밋은 오케스트레이터가 합니다.
- ROADMAP.md를 고치지 않았습니다 (quick 작업).

그 밖에는 계획대로 했습니다. 자동 수정(Rule 1–3)과 인증 관문은 없었습니다.

## 보고할 것

1. **연구 항목 12와 D-26 「정리 단계」 물음.** 연구 항목 12(06-RESEARCH 336행, 메모를 넣은 뒤로는 338행)는 재기준에서 익명 쓰기 경로가 하나라도 나오면 D-26 「남는다면 앱 작업에 정리 단계를 더할지」를 사용자에게 묻는다고 적었습니다. 정정한 목록에는 `users/{uid}` 쓰기는 없지만 익명 호출이 uid `rate_limits` 기록을 만드는 경로가 있습니다(만료 시각과 TTL 정책으로 지워짐). 이것이 그 물음을 부르는지는 이 작업이 정하지 않았습니다.
2. **06-06 선택지 (가)의 단점 칸.** 단점 칸은 둘러보기 계정의 Auth 레코드만 말합니다. 선택지는 고치지 않았습니다.
3. **R7(120행).** 토큰 말고 Task 2 read_first에 구간 F `rate_limits/{docId}` 행을 더했습니다 (R9의 새 사실이 「데이터 목록 구간 F」를 가리키므로).
4. **95행과 98행.** Task 1의 「지워짐」 목록(95행)의 「uid가 든 호출 횟수 제한 기록」은 탈퇴 경로 기준입니다. 익명 호출이 만든 기록은 98행으로 Task 2에 묶었습니다 (95행은 고치지 않음).
5. **R2(67행).** 표식만 바꾼 것이 아니라 두 문장을 더했습니다: `ANON_ROW_FIX_SHA`가 무엇인지(재기준 커밋 뒤에 구간 A 익명 행 하나만 고친 문서 커밋), 그리고 그 계획의 「재기준 목록」·「재기준한 데이터 목록」이 그 커밋의 내용을 뜻한다는 것. 그래서 「재기준 목록」이라고 적힌 다른 줄은 고치지 않아도 됐습니다.
6. **STATE.md에 남은 옛 문구.** 6행 `stopped_at:`과 307행 `Stopped at:`(Blockers 줄 하나를 지운 뒤로는 306행)에는 「06-06 전에 계획 수정 필요」가 아직 있습니다. 계획대로 고치지 않았습니다 (오케스트레이터가 STATE 기록을 함).

D-33 ①(ga·na·da)은 정하지도 권하지도 미리 채우지도 않았고, 06-06에 새 질문을 더하지 않았습니다.

## Known Stubs

없음. 계획 문서 두 개와 STATE.md 한 줄만 고쳤고 사이트 출력은 그대로입니다.

## Self-Check: PASSED

- FOUND: `.planning/phases/06-data-deletion-rewrite/06-06-PLAN.md` (새 표식 아홉 줄)
- FOUND: `.planning/phases/06-data-deletion-rewrite/06-RESEARCH.md` (C-7 메모 1번)
- FOUND: `.planning/STATE.md` (닫은 줄 0번, 미커밋)
- FOUND: 커밋 `a88afe9` (HEAD, 기준 `ff7d9273fe41`의 바로 다음 커밋)
- `verify.sh t3` 재실행: `RESULT pass t3`
