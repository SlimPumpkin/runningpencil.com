---
phase: quick-261126-rw9
verified: 2026-11-26T11:47:38Z
status: passed
score: 6/6 must-haves verified
covered_files:
  - .planning/STATE.md
  - .planning/phases/06-data-deletion-rewrite/06-06-PLAN.md
  - .planning/phases/06-data-deletion-rewrite/06-RESEARCH.md
  - .planning/quick/261126-rw9-06-06-plan-md-anon-row-fix-sha-d7dd8609b/261126-rw9-PLAN.md
  - .planning/quick/261126-rw9-06-06-plan-md-anon-row-fix-sha-d7dd8609b/261126-rw9-SUMMARY.md
covered_digest: "v4:sha256:d3063d4aeba91dc2e2d21dd5fbc861fabd2d14ff1cd9b5ca2b2a97bbda036ba9"
behavior_unverified: 0
overrides_applied: 0
---

# Quick 261126-rw9: 06-06 계획을 익명 행 정정에 맞춤 — 검증 보고서

**작업 목표:** `06-06-PLAN.md`를 익명 행 정정(`ANON_ROW_FIX_SHA`, 정정 커밋 `d7dd8609bcb9`)에 맞춰 고친다. 요청 (1)~(5). 연구 선택지 (가)(나)(다)와 다른 계획은 고치지 않고, 사용자 결정 D-33 ①은 대신 정하지 않는다.
**검증 시각:** 2026-11-26T11:47:38Z
**상태:** passed
**재검증:** 아니오 (처음 검증. 이전 VERIFICATION.md 없음)
**기준:** 작업 전 커밋 `ff7d9273fe41`, 실행 커밋 `a88afe93e562`, 정정 커밋 `d7dd8609bcb9`, 재기준 커밋 `aeb6f4461157`

SUMMARY의 주장은 근거로 쓰지 않았습니다. 아래 근거는 모두 이 검증에서 직접 돌린 명령의 결과입니다. 계획자가 만든 `261126-rw9-verify.sh`도 한 번 돌렸지만(exit 0, `RESULT pass t3`, FAIL 줄 0) 판정은 독립 명령으로 했습니다.

## 목표 달성

### 관찰 가능한 사실 (Observable Truths)

| # | 사실 | 상태 | 근거 |
|---|------|------|------|
| 1 | 06-06-PLAN.md가 데이터 목록을 `ANON_ROW_FIX_SHA`에서 읽는다. 옛 표식 이름은 0번이고 새 표식은 20·67·84·87·93·120·123·124·154행에 있다 (요청 (1)) | VERIFIED | `grep -c -F 'REBASE_SHA'` = 0. `grep -n -F 'ANON_ROW_FIX_SHA' \| cut -d: -f1` = `20 67 84 87 93 120 123 124 154` (낱말로는 13번: 67·123행 세 번씩). `06-EVIDENCE.md` 721행에 줄 머리부터 `ANON_ROW_FIX_SHA=d7dd8609bcb9`가 한 줄만 있음. 06-06-PLAN.md에 해시 글자(`d7dd8609`, `aeb6f446`)는 0번 |
| 2 | Task 2 precondition의 확인 문구 여섯이 정정 목록에 정확히 한 번씩 있고, 새 문구는 정정 전 목록에 없다 (요청 (3)) | VERIFIED | 123행에서 낫표 문구를 직접 뽑으니 여섯 개. `git show d7dd8609bcb9:…/DATA-INVENTORY.md`에서 `grep -c -F`가 여섯 모두 1(낱말 수로도 1). `git show aeb6f4461157:…`에서는 앞의 넷이 1, 뒤의 둘(「익명 호출을 받고, 불리면 그 uid가 든 호출 횟수 제한 기록」, 「이 기록은 만료 시각과 TTL 정책으로만 지워짐」)이 0. 06-06 실행자의 절차를 그대로 흉내 냄: 표식 줄에서 12자리를 뽑아 `git show`(exit 0) 한 뒤 여섯 문구 모두 FOUND |
| 3 | Task 2가 보일 익명 사실이 정정한 구간 A 익명 행과 같고, 정정 전 두 문장은 없다 (요청 (2), D-26) | VERIFIED | 아래 「124행 대조」 표. 「서버 문서를 쓰는 곳이 없음」 0번, 「남는 uid는」 0번, 「서버 문서」 0번 |
| 4 | Task 2·3 options 블록, (나) 문장, `D33_C7_SENTENCE` 기준은 글자 그대로이고 바뀐 줄은 열 줄뿐이다. D-33 ①은 아무도 정하지 않았다 | VERIFIED | 기준 커밋과 `diff`: 바뀐 줄은 `20 67 84 87 93 98 120 123,124 154`뿐, 줄 수 248 = 248. 두 options 블록(131–152행, 188–204행)을 뽑은 SHA-256이 기준과 같음(`8f922c0d…b40c`). 138·155·156행은 기준과 같음. front matter는 YAML로 읽힘(truths 5개, 첫 truth에 새 표식). `06-EVIDENCE.md`에 줄 머리 `D33_C7=` 없음. 더한 줄에 `D33_C7=` 0번 |
| 5 | 06-RESEARCH.md C-7 머리 바로 아래에 메모 한 줄과 빈 줄 하나가 있고 원래 줄은 그대로다 (요청 (4)) | VERIFIED | `git diff --numstat ff7d9273fe41 HEAD` = 더한 줄 2·지운 줄 0. 덩어리는 `@@ -306,6 +306,8 @@` 하나. C-7 블록을 기준과 `diff`하니 `1a2,3`(메모 줄과 빈 줄)뿐이고 선택지 (가)(나)(다) 세 줄은 같음. 메모는 309행 |
| 6 | STATE.md Blockers에서 06-06 계획 수정을 요구하던 줄이 없고 그 밖은 그대로다 (요청 (5)) | VERIFIED | 작업 트리 대 기준 `git diff --numstat` = 더한 줄 0·지운 줄 1. 지운 줄은 `- [Phase 06] 06-06을 실행하기 전에 06-06-PLAN.md Task 2를 고쳐야 함:`으로 시작하는 한 줄. 그 머리 문구는 지금 0번. 앞 줄(293행)은 그대로. STATE.md가 미커밋인 것은 계획대로임 |

**점수:** 6/6 사실 확인 (동작 미검증 0)

### 124행 대조 (사실 3)

새 사실 구절을 정정 커밋 목록 189행(구간 A 「익명 계정 (uid)」)과 구절 단위로 맞췄습니다.

| 124행의 구절 | 목록 189행의 글자 | 판정 |
|---|---|---|
| 확인한 경로 안에서 앱이 익명 계정의 `users/{uid}` 문서를 쓰는 곳은 찾지 못함(앱 코드) | 같은 글자 | 일치 |
| 서버 함수 둘(가입 수단 조회 `lookupSignInMethods`, 비밀번호 재설정 메일 `sendPasswordResetMail`)은 익명 호출을 받고 불리면 그 uid가 든 호출 횟수 제한 기록(`rate_limits`)을 만듦(앱 코드) | 같은 글자 (목록은 「받고,」에 쉼표가 있음) | 일치. 「(앱 코드)」는 출처 표기이고, 목록 근거 칸에 두 함수의 파일이 있음 |
| 익명 사용자는 회원탈퇴에 갈 수 없어 이 기록은 만료 시각과 TTL 정책으로만 지워짐(데이터 목록 구간 F) | 같은 글자, 「(구간 F)」 | 일치 |
| Analytics·Crashlytics·로그에 붙은 uid는 각 행의 기간을 따름 | 「Analytics·Crashlytics·Cloud Functions 로그에 붙은 uid는 각 행의 기간을 따름」 | 일치 (「로그」는 고치기 전 줄의 줄임말 그대로) |

- 목록 행에 없는 사실을 더한 곳은 없습니다. 제한 창 길이(60초)나 파일:행 인용은 124행에 없습니다.
- 남는 것을 모두 센 표현(「Auth 레코드 밖에 남는 것은 …」 꼴)은 없습니다.
- 새 구절은 사실 나열뿐이고 (가)(나)(다) 가운데 어느 쪽을 권하는 말이 없습니다. 「실행자는 어느 쪽도 권하지 않는다」 문단부터 끝까지는 기준과 같습니다.

### 필요한 산출물 (Required Artifacts)

`verify.artifacts`(계획 front matter 기준): 4/4 통과, exit 0.

| 산출물 | 기대 | 상태 | 비고 |
|---|---|---|---|
| `.planning/phases/06-data-deletion-rewrite/06-06-PLAN.md` | 정정에 맞춘 06-06 계획, `ANON_ROW_FIX_SHA` 포함 | VERIFIED | 열 줄 변경, 커밋 `a88afe9`에 있음 |
| `.planning/phases/06-data-deletion-rewrite/06-RESEARCH.md` | C-7 머리의 정정 메모 한 줄 | VERIFIED | 「2026-11-26 메모 (익명 행 정정 뒤)」 1번, 커밋 `a88afe9`에 있음 |
| `.planning/STATE.md` | 닫힌 Blockers 줄을 지운 상태 | VERIFIED | 미커밋 (오케스트레이터가 커밋) |
| `…/261126-rw9-verify.sh` | 읽기 전용 검증 스크립트 | VERIFIED | 돌린 뒤에도 `git status`가 같음 |

### 핵심 연결 (Key Links)

| From | To | Via | 상태 | 비고 |
|---|---|---|---|---|
| `06-06-PLAN.md` | `06-EVIDENCE.md` | 표식 줄 `ANON_ROW_FIX_SHA=<12자리>`를 풀어 `git show` | WIRED (직접 확인) | 도구 `verify.key-links`는 「Pattern "^ANON_ROW_FIX_SHA=" not found」(exit 1)를 냈습니다. 도구가 `^`를 여러 줄 모드 없이 맞춰서 생긴 결과입니다(같은 정규식이 여러 줄 모드에서는 참, 아니면 거짓임을 node로 확인). 표식은 721행 줄 머리에 있고, 흉내 낸 precondition이 `d7dd8609bcb9`를 풀어 여섯 문구를 모두 찾았습니다 |
| `06-06-PLAN.md` | `.planning/baseline/DATA-INVENTORY.md` | precondition 확인 문구 여섯 | WIRED | 도구 통과. 정정 목록에 각 1번 |
| `06-RESEARCH.md` | `06-EVIDENCE.md` | C-7 메모가 표식을 가리킴 | WIRED | 도구 통과 |

`d7dd8609bcb9`는 `aeb6f4461157`의 자손이고 HEAD의 조상입니다. 작업 트리의 데이터 목록은 정정 커밋과 같습니다.

### 데이터 흐름 (Level 4)

해당 없음. 화면에 값을 그리는 코드가 아니라 계획 문서 수정입니다.

### 동작 확인 (Behavioral Spot-Checks)

| 동작 | 명령 | 결과 | 상태 |
|---|---|---|---|
| 06-06 Task 2 precondition이 정정 목록에서 통과 | 표식에서 12자리를 뽑아 `git show` 뒤 여섯 문구 `grep -F` | exit 0, 여섯 모두 FOUND | PASS |
| 같은 precondition이 정정 전 목록에서는 멈춤 | `aeb6f4461157`의 목록에서 새 문구 둘 `grep -c -F` | 둘 다 0 | PASS |
| 06-06-PLAN.md front matter가 읽힘 | `ruby -ryaml`로 front matter 읽기 | truths 5개 | PASS |
| 계획자 스크립트 | `bash …/261126-rw9-verify.sh t3` | exit 0, `RESULT pass t3`, FAIL 0 | PASS (보조 근거) |

### Probe 실행

해당 없음. 이 작업이 선언한 probe가 없습니다.

`scripts/check-site.sh`는 이 검증에서 다시 돌리지 않았습니다. `git diff --name-only ff7d9273fe41 HEAD -- . ':(exclude).planning'`이 비어 있고 작업 트리에도 `.planning/` 밖 변경이 없으며, `_config.yml`의 `exclude`에 `.planning/`이 있어 사이트 출력이 바뀔 수 없습니다.

### 범위 (Scope)

| 확인 | 결과 |
|---|---|
| `git diff --name-only ff7d9273fe41 HEAD` | `06-06-PLAN.md`, `06-RESEARCH.md` 두 줄뿐 |
| 커밋 수 | 기준 뒤 1개 (`a88afe9`, 제목 `docs(06): 06-06 계획을 익명 행 정정에 맞춤`) |
| 미커밋 경로 | `.planning/STATE.md` 수정, quick 폴더(미추적)뿐 |
| 다른 계획·기준 문서·사이트 파일 | 변경 없음 |
| 푸시 | 하지 않음. `git branch -r --contains a88afe9`가 비어 있고 `main`이 `origin/main`보다 13커밋 앞 |
| 더한 줄의 이메일 꼴·홈 경로·해시 글자 | 0 |

### 요구사항 (Requirements)

| 요구사항 | 출처 | 상태 | 근거 |
|---|---|---|---|
| DEL-03 | quick 계획 front matter | 뒷받침 (충족 아님) | DEL-03은 06-06과 뒤 계획이 충족합니다. 이 작업은 06-06이 정정한 사실 위에서 돌도록 계획을 고쳤을 뿐입니다 |

### Anti-Pattern

더한 줄 11개(06-06-PLAN.md 10, 06-RESEARCH.md 1. 빈 줄 제외)에서 `TBD|FIXME|XXX|TODO|HACK|PLACEHOLDER|추후 기재`를 찾았고 0건입니다.

### 사람 확인

없음.

## 관찰 (gap 아님)

1. **R2 (67행):** 토큰 교체에 더해 읽는 시점을 정의하는 두 문장이 들어갔습니다. 두 문장 모두 참입니다. `d7dd8609bcb9`는 `DATA-INVENTORY.md` 한 파일의 한 줄(189행, 구간 A 익명 행)만 고친 커밋이고 재기준 커밋의 자손입니다. 이 정의가 있어 「재기준 목록」이라고 적힌 다른 줄을 고치지 않아도 됩니다.
2. **R7 (120행):** read_first에 「구간 F `rate_limits/{docId}` 행」이 더해졌습니다. 그 행은 정정 목록 273행에 있고 머리 `## F. 서버 보조 컬렉션` 아래입니다. 틀린 말이 아닙니다.
3. **STATE.md에 남은 문구:** front matter `stopped_at:`(6행)과 `Stopped at:`(306행)에 「06-06 전에 계획 수정 필요」가 남아 있습니다. 요청 (5)의 범위(Blockers 줄) 밖이고 계획이 일부러 남겼습니다.
4. **123행의 `rate_limits`:** 새 확인 문구 둘에는 `rate_limits`라는 글자가 없습니다(목록의 글자가 「호출 횟수 제한 기록」이라서). `rate_limits`는 그 줄의 설명 문장에 있습니다. 두 문구는 정정 목록과 정정 전 목록을 가려냅니다(1 대 0).
5. **선택지 (가)의 단점 칸:** 둘러보기 계정의 Auth 레코드만 말합니다. 익명 호출이 만든 `rate_limits` 기록은 말하지 않습니다. 선택지를 고치지 말라는 요청대로 그대로이고, 사용자가 D-33 ①을 고를 때 알고 있으면 좋은 점입니다.
6. **「TTL 정책으로만」의 전제:** 이 문장은 prod에서 TTL 정책을 켰을 때만 참입니다(prod 전제 2번). 189행과 124행에는 그 전제가 없고, 120행 read_first가 가리키는 구간 F 행에 있습니다. 또 구간 F 행은 uid가 든 문서를 「운영자 도구 계정 전체 삭제」 때도 지운다고 적습니다. 운영자 도구를 익명 uid에 쓸 수 있는지는 이 검증에서 확인하지 않았습니다. 목록 189행의 글자 문제이고 이 작업의 범위 밖입니다.
7. **지난 기록의 옛 문구:** `06-EVIDENCE.md` 「익명 행 정정」 끝 글머리와 `06-04-SUMMARY.md` 「뒤 계획이 알아야 할 것」 첫 글머리는 「06-06을 실행하기 전에 계획을 고쳐야 한다」고 적혀 있습니다. 이미 커밋한 기록이라 계획이 고치지 않았습니다.
8. **다른 계획:** 06-05(88행)와 06-13(87·142·143행)은 `REBASE_SHA`를 그대로 씁니다. 두 목록은 189행만 다르므로 그 계획들이 보는 구절(prod 전제, 운영자 삭제 도구 행, 기준 앱 커밋 줄)은 같습니다. 06-13은 `OK anon facts in inventory <12자리>` 줄을 해시 값과 무관하게 봅니다.

## 요약

요청 다섯 가지가 모두 코드베이스에서 확인됐습니다. 06-06 실행자는 정정 목록에서 precondition을 통과하고 정정 전 목록에서는 멈춥니다. Task 2가 사용자에게 보일 익명 사실은 정정한 구간 A 익명 행과 구절 단위로 같고, 선택지와 D-33 ①은 손대지 않았습니다. gap과 사람 확인 항목은 없습니다.

---

_Verified: 2026-11-26T11:47:38Z_
_Verifier: Claude (gsd-verifier)_
