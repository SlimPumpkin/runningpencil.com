---
status: diagnosed
phase: 01-ground-truth-policy-reset
source: [01-VERIFICATION.md]
started: 2026-11-15T08:27:17Z
updated: 2026-11-15T19:10:38Z
---

## Current Test

[testing complete]

## Tests

### 1. URL 대장(.planning/baseline/URLS.md)의 「등록할 콘솔 필드(범주)」 열을 제공자·스토어별로 훑어본다 (01-01 human-check)
expected: URL마다 등록할 곳이 범주 수준으로 적혀 있고, 확인되지 않은 필드명을 확정된 것처럼 적은 칸이 없다
result: pass

### 2. 절차서(.planning/baseline/USER-TASKS.md)의 작업마다 「막는 단계」를 .planning/ROADMAP.md의 External Gates 표와 대조한다 (01-02 human-check). 특히 작업 6(DKIM, 가비아 DNS 2차 방문)의 막는 단계를 본다: 절차서는 「Phase 10 Apple 릴레이, D-11」로 적고 이메일 게이트는 DKIM을 기다리지 않는다고 하지만, ROADMAP External Gates 표의 가비아 DNS 행은 1차·2차 방문(DKIM 포함)을 묶어 Phase 5를 막는다고 적는다
expected: 작업 0~12의 막는 단계가 ROADMAP의 게이트와 어긋나지 않는다 (DNS·메일은 Phase 5, 화면 캡처는 Phase 4, DKIM은 Phase 10의 릴레이 답장 전제)
result: issue
reported: "이건 봐도 내가 잘 모르겠다 → 대조 설명 뒤 선택: 「Phase 10만 막음」. 절차서(USER-TASKS.md:23 작업 6 = Phase 10 Apple 릴레이)가 맞고, ROADMAP External Gates 표(ROADMAP.md:221)의 가비아 DNS 행이 1차·2차(DKIM) 방문을 묶어 Phase 5를 막는다고 적은 것이 어긋남. 표의 행을 1차(Phase 5)와 2차 DKIM(Phase 10)으로 나눈다"
severity: minor

### 3. 결정 목록(.planning/baseline/DECISIONS.md) 「한눈에 보기」의 막는 단계 칸을 .planning/ROADMAP.md의 External Gates 표와 대조하고, U2·U3·U7의 「기본 동작」 문구를 읽는다 (01-04 human-check)
expected: 항목마다 막는 단계가 ROADMAP의 게이트와 어긋나지 않는다. 법률 판단 항목의 기본 동작이 결론이 아니라 임시 방침으로 읽히고 사용자가 받아들일 수 있는 문구다
result: pass

### 4. 데이터 목록 「CLI 조회 기록」 표의 결과와, 조회에 성공한 리전·TTL·백업·버킷 칸을 사용자가 Firebase·GCP 콘솔에서 아는 값과 견주어 본다 (01-08 human-check). 함께 확인: 01-08 실행이 조회(list) 명령만 썼고 dev 설정·데이터가 바뀌지 않았는지, 특히 SUMMARY가 적은 대로 `firebase ext:list`의 확장 API 확인 단계가 API를 새로 켜지 않았는지
expected: 조회한 값이 dev 프로젝트의 실제 설정과 같고, 건너뛰거나 실패한 조회의 칸은 「CLI 미확인」으로 남아 있다. 문서에 버킷 이름이나 계정 정보가 없다. dev 프로젝트의 API 사용 설정과 리소스가 조회 전과 같다. 판정 불가로 둔 01-08 금지 사항 세 개(설정·데이터 변경 금지, 다른 자격 증명 사용 금지, 문서·객체 내용 조회 금지)가 지켜졌음을 사용자가 확인한다
result: pass
note: "사용자 위임으로 Claude가 읽기 전용 대조 (2026-11-15). 조회 값 8건 모두 현재 dev 설정과 같음. 「CLI 미확인」 잔여 0, 문서 식별자 0건. 확장 API는 01-08 이전(2026-10-26)부터 켜져 있었음. 01-08 시간대 Admin Activity 감사 로그 0건, Cloud Monitoring의 Firestore 문서 읽기·쓰기·삭제와 Storage 요청 0건(대조군: 직전 2주 매일 기록됨). 「다른 자격 증명 사용 금지」만 직접 증거 없음(로그인 계정 1개라는 정황), 변경·데이터 읽기가 없어 잔여 영향 없음으로 보고 사용자가 pass"

### 5. 이름 표(.planning/baseline/NAMES.md)의 상호·대표자·사업자등록번호·주소·영문 법인명·스토어 개발자 이름·전화번호 칸을 눈으로 본다 (VALIDATION Manual-Only, BASE-01)
expected: 칸이 비어 있거나 사용자가 준 값뿐이다 (검증 시점 관찰: 일곱 칸 모두 「(빈칸)」 표기)
result: pass

### 6. 01-01 판단 등급 금지 사항 3개(사업자 값 추측 금지, 공개 전 사업자 값 커밋 금지, 콘솔 필드를 확정 필드명처럼 적지 않음)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: pass
note: "사용자 위임으로 Claude가 독립 확인. ① NAMES.md 사업자 일곱 칸 모두 (빈칸). ② 저장소 전체 이력(모든 브랜치) 추가 줄을 사업자등록번호·전화번호·도로명 주소 꼴로 스캔, 실제 값 0건(오탐 5줄: 예시 000-00-00000, 타임스탬프, 기사 URL 번호). ③ Test 1 판단과 같음"

### 7. 01-02 판단 등급 금지 사항 2개(발급 값 추정 기재 금지, 기존 DNS 레코드 삭제·수정 안내 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: pass
note: "사용자 위임으로 Claude가 독립 확인. ① 발급 값 세 종류의 값 칸은 모두 「콘솔에서 복사」, 저장소 전체 이력에 사이트 인증 값·DKIM 키 꼴 0건(오탐 1줄은 문서 URL). 직접 적힌 MX·SPF는 Google 고정 안내값. ② 보존 표 처리 칸 모두 「그대로 둡니다」. 2026-11-15 공개 DNS 조회 결과가 문서의 보존 목록·변경 전 상태와 같음(MX·루트 TXT 없음 → SPF는 합치기 아닌 신규 추가). 라우터 A 레코드는 호스트 미기재라 조회 안 함"

### 8. 01-03 판단 등급 금지 사항 3개(미확인 값을 확인된 것처럼 적지 않음, 법적 성격 단정 금지, 실제 사용자 데이터 값 옮기지 않음)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: issue
reported: "issue(열 이름 바꾸기로 기록) — Claude 확인: ①·③은 지켜짐. ②는 단정 문장 0건이고 머리 문단 단서가 있으나, DATA-INVENTORY.md 구간 A·C~F 본표의 열 이름이 법률 용어(「수탁자」, 「국외 이전」)라서 Meta(Facebook SDK)·네이버클라우드 등이 「수탁자」로 분류된 것처럼 읽힘. Phase 7이 이 표를 정본으로 읽을 때 위탁/제3자 제공 구분이 그대로 옮겨질 위험. 열 이름을 중립어(예: 「받는 곳(처리 주체)」, 「국외 저장·전송」)로 바꾼다 [범위 조정 2026-11-15, 사용자 선택 「Meta 행만 고침」: 열 이름은 REQUIREMENTS BASE-03·ROADMAP Phase 1 성공 기준 3의 문구이고, Google Firebase·GCP·네이버클라우드의 수탁자 분류는 PRIV-03·Phase 7 성공 기준 2가 이미 정함. 열 이름은 유지하고 PRIV-03에 없는 Meta(Facebook SDK) 행에 단서를 넣고 열 기준 주석을 더한다]"
severity: minor

### 9. 01-04 판단 등급 금지 사항 3개(법률 항목 기본 동작을 결론처럼 적지 않음, U12 말고 「결정됨」 금지, U11 기본값 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: pass
note: "사용자 위임으로 Claude가 독립 확인. ① U2·U3·U7 기본 동작 원문 세 문장 모두 작업 방침이고 「초안·법률 확인 필요」 표시, 권장안은 「법률 확인을 받습니다」. ② 「결정됨·결정 완료·확정」은 U12 두 곳에만, 상태 칸 나머지 11개는 「열림」. ③ U11 기본 동작은 「기본값 없음」, 값 0개"

### 10. 01-05 판단 등급 금지 사항 3개(비공개 코스 삭제·공개 코스만 남음으로 적지 않음, 즉시 전부 삭제로 읽히게 적지 않음, 선택지만 있는 값 추측 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: pass
note: "사용자 위임으로 Claude가 독립 확인. ① 앱 3afb2085(=현재 HEAD) 탈퇴 코드 직접 대조: cleanup_user_data.ts는 runs·badges, delete_user_account.ts는 Storage·Auth·identity_index·users·fcmTokens만 삭제, functions/src에 courses 삭제 코드 0건 → 문서의 「공개·비공개 모두 삭제하지 않음」과 일치. ② 구간 G에 남는 것 6행과 서비스 삭제/백업 제거 구분 단서 있음. ③ Analytics 보존 기간은 G·H 모두 「미확인」"

### 11. 01-06 판단 등급 금지 사항 3개(옛 규칙 문장 인용 금지, 코드 설명을 미래 상태로 고쳐 쓰지 않음, 방침을 지금 코드에 반영하라는 뜻으로 읽히지 않음·지원 주소 문자열 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: pass
note: "사용자 위임으로 Claude가 독립 확인. ① 단계 시작 전(dcc2002) CLAUDE.md에서 뽑은 옛 규칙 문장과 넓힌 꼴이 다섯 방침 파일에서 0줄, 「이전 방침을 뒤집음」 표기만 있음(PROJECT.md:107 인용 1줄은 계획상 범위 밖·단계 이전 줄). ② CLAUDE.md의 현재 상태 설명이 실제 파일과 일치(Jekyll 파일 없음, Tailwind는 법적 3종만, noindex·임시 게시본 3, 영문명 0, lang=ko 4/4, 랜딩에 포인트·굿즈·코스북 잔존). ③ 미적용 단서 문장 있음, 다섯 파일 support@ 0건, dcc2002 이후 사이트 파일 변경 0"

### 12. 01-07 판단 등급 금지 사항 3개(D-21 밖 ROADMAP 내용 변경 금지, 연구 본문 수정·삭제 금지, 연구 캐시 커밋 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: pass
note: "사용자 위임으로 Claude가 독립 확인. ① 01-07의 ROADMAP 변경은 8aef43c 하나, 보호 대상(목표·성공 기준·요구사항·순서·다른 게이트 막는 단계) 0줄 변경. D-21 이름 목록 밖 네 곳(Phase 5 사용자 작업·Research flag, Phase 10 DKIM 문장, 이미 결정된 항목)은 U12 결정 반영이며 01-07-PLAN.md:152에 계획됨. 가비아 행의 「2차 방문: DKIM」 추가가 G-01-2의 출처. ② research/STACK.md +8/-0, SUMMARY.md +16/-0. ③ research/.cache 추적 0, 전체 이력 등장 0, .gitignore 11행"

### 13. 01-08 판단 등급 금지 사항 1개(조회하지 못한 칸을 추정값으로 채우지 않음 (나머지 세 개는 위 01-08 항목에서 다룸))를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: pass
note: "사용자 위임으로 Claude가 독립 확인. 조회 8건 모두 성공해 미조회 칸 없음. 「근거: dev CLI」 37줄의 값 종류가 모두 8건 조회 범위 안이고 Test 4 재조회 값과 같음. prod 칸은 모두 「미확인 (prod 리전에 따름)」, 문서 근거 값은 「dev 설정 기록(문서)」로 구분"

### 14. 절차서(`.planning/baseline/USER-TASKS.md`) 「한눈에 보기」의 작업 0~12 막는 단계를 ROADMAP External Gates 표, Phase 5·Phase 10 External gates, STATE Blockers와 견주어 어긋나는 곳이 없는지 본다. 특히 작업 6(DKIM)이 세 문서 모두에서 Phase 10만 막고, 2차 방문의 작업 시점은 Phase 5 무렵으로 남았는지 본다 (01-09 human-check, UAT Test 2 재확인)
expected: 절차서 작업 0~12의 막는 단계가 ROADMAP 표, Phase 5·10 External gates, STATE Blockers와 어긋나지 않는다. 작업 6(DKIM)은 세 문서 모두에서 Phase 10만 막고, 2차 방문의 작업 시점은 Phase 5 무렵이다
result: [pending]

### 15. 데이터 목록 머리의 새 줄과 구간 E Meta (Facebook SDK) 행을 읽는다 (01-10 human-check, UAT Test 8 재확인, VALIDATION Manual-Only 5행)
expected: Meta가 수탁자로 정해진 것처럼 읽히지 않고, 머리의 새 줄이 「읽는 법」의 수탁자 정의(법적 성격은 여기서 정하지 않음)와 함께 읽어도 어긋나지 않는다
result: [pending]

### 16. 01-09 판단 등급 금지 사항 1개(G-01-2의 네 곳 밖을 고치지 않음, task 커밋에 진행 기록·begin-phase 줄을 섞거나 그 줄을 지우거나 숨기지 않음)를 본문 「금지 사항」 표의 검증자 판정과 근거로 읽는다
expected: 검증자 판정(지켜짐)에 동의한다. 동의하지 않으면 gap으로 되돌린다
result: [pending]

### 17. 01-10 판단 등급 금지 사항 2개(열 이름·열 정의·BASE-03·Phase 1 성공 기준 3·다른 행을 바꾸지 않음, 새 문장이 Meta나 다른 받는 곳을 수탁자·제3자 제공으로 단정하지 않음)를 본문 「금지 사항」 표의 검증자 판정과 근거로 읽는다
expected: 검증자 판정(지켜짐)에 동의한다. 동의하지 않으면 gap으로 되돌린다
result: [pending]

## Summary

total: 17
passed: 11
issues: 2
pending: 4
skipped: 0
blocked: 0

## Gaps

- gap_id: G-01-2
  truth: "작업 0~12의 막는 단계가 ROADMAP의 게이트와 어긋나지 않는다 (DNS·메일은 Phase 5, 화면 캡처는 Phase 4, DKIM은 Phase 10의 릴레이 답장 전제)"
  status: failed
  reason: "User reported: 이건 봐도 내가 잘 모르겠다 → 대조 설명 뒤 선택: 「Phase 10만 막음」. 절차서(USER-TASKS.md:23 작업 6 = Phase 10 Apple 릴레이)가 맞고, ROADMAP External Gates 표(ROADMAP.md:221)의 가비아 DNS 행이 1차·2차(DKIM) 방문을 묶어 Phase 5를 막는다고 적은 것이 어긋남. 표의 행을 1차(Phase 5)와 2차 DKIM(Phase 10)으로 나눈다"
  severity: minor
  test: 2
  origin_hint: "Test 12 확인 중 발견: 01-07 커밋 8aef43c가 ROADMAP External Gates 가비아 행에 「2차 방문: DKIM」을 넣고 Phase 10 External gates에 「DKIM은 Phase 5의 가비아 DNS 2차 방문에서 이미 추가」를 적음"
  root_cause: "01-07(8aef43c)이 D-21에 따라 ROADMAP을 U12 결정에 맞추면서 가비아 DNS 1차·2차 방문을 한 행·한 항목으로 묶어 Phase 5 게이트에 넣었다. ROADMAP.md:134 「단계 완료는 게이트가 열리고 값이 들어간 뒤」 때문에 2차 방문(DKIM)까지 Phase 5 완료 조건으로 읽힌다. 01-02가 쓴 절차서(USER-TASKS.md:23·31)는 DKIM을 Phase 10 Apple 릴레이의 전제로 두어 두 문서가 어긋난다. Phase 5 성공 기준 1~5에는 DKIM이 없고 Phase 10 성공 기준 5에만 SPF·DKIM 확인이 있다. STATE.md Blockers도 같은 묶음을 옮겨 적었다. DECISIONS.md:9가 막는 단계의 정본을 ROADMAP으로 두므로 ROADMAP 쪽을 고친다"
  artifacts:
    - path: ".planning/ROADMAP.md"
      issue: "External Gates 표의 가비아 DNS 행(221행)이 2차 방문 DKIM까지 Phase 5를 막는다고 적음"
    - path: ".planning/ROADMAP.md"
      issue: "Phase 5 External gates의 가비아 DNS 항목(131행)이 2차 방문 DKIM을 Phase 5 게이트 안에 둠"
    - path: ".planning/ROADMAP.md"
      issue: "Phase 10 External gates(211행)가 DKIM을 「Phase 5의 2차 방문에서 이미 추가」로 적어 Phase 10의 게이트에서 빠짐"
    - path: ".planning/STATE.md"
      issue: "Blockers/Concerns의 가비아 DNS 항목(109행)이 2차 방문 DKIM을 Phase 5를 막는 작업으로 묶음"
  missing:
    - "External Gates 표의 가비아 행을 1차 방문(→ Phase 5)과 2차 방문 DKIM(→ Phase 10)으로 나눈다"
    - "Phase 5 External gates의 가비아 항목에 2차 방문(DKIM)은 Phase 5 완료를 막지 않고 Phase 10 릴레이 답장의 전제라고 적는다 (작업 시점은 지금처럼 Phase 5 무렵)"
    - "Phase 10 External gates에 DKIM(USER-TASKS 작업 6)을 이 단계의 게이트로 적는다"
    - "STATE.md Blockers의 가비아 항목을 1차(→ Phase 5)와 2차 DKIM(→ Phase 10)으로 나눈다"
    - "USER-TASKS.md와 DECISIONS.md는 고치지 않는다 (이미 Phase 10으로 적혀 있음). 단계 목표·성공 기준·요구사항 배정·단계 순서도 바꾸지 않는다"
  debug_session: ""  # UAT 중 오케스트레이터가 직접 진단 (원인 커밋·행 확인), 별도 debug 세션 없음

- gap_id: G-01-8
  truth: "01-03 금지 사항: 데이터 목록이 수탁·제3자 제공·국외 이전의 법적 성격을 단정하지 않는다"
  status: failed
  reason: "User reported: issue(열 이름 바꾸기로 기록) — Claude 확인: ①·③은 지켜짐. ②는 단정 문장 0건이고 머리 문단 단서가 있으나, DATA-INVENTORY.md 구간 A·C~F 본표의 열 이름이 법률 용어(「수탁자」, 「국외 이전」)라서 Meta(Facebook SDK)·네이버클라우드 등이 「수탁자」로 분류된 것처럼 읽힘. Phase 7이 이 표를 정본으로 읽을 때 위탁/제3자 제공 구분이 그대로 옮겨질 위험. 열 이름을 중립어(예: 「받는 곳(처리 주체)」, 「국외 저장·전송」)로 바꾼다 [범위 조정 2026-11-15, 사용자 선택 「Meta 행만 고침」: 열 이름은 REQUIREMENTS BASE-03·ROADMAP Phase 1 성공 기준 3의 문구이고, Google Firebase·GCP·네이버클라우드의 수탁자 분류는 PRIV-03·Phase 7 성공 기준 2가 이미 정함. 열 이름은 유지하고 PRIV-03에 없는 Meta(Facebook SDK) 행에 단서를 넣고 열 기준 주석을 더한다]"
  severity: minor
  test: 8
  root_cause: "열 이름 「수탁자」·「국외 이전」은 BASE-03·ROADMAP Phase 1 성공 기준 3이 정한 것이고, Google Firebase·GCP와 네이버클라우드를 수탁자로, 로그인 제공자를 수탁자 아님으로 보는 기준도 PRIV-03·Phase 7 성공 기준 2가 이미 정했다. 그런데 01-03이 PRIV-03에 이름이 없는 Meta(Facebook SDK 자동 이벤트)를 같은 「수탁자」 칸에 단서 없이 넣었다. 머리 문단(12행)에 「법적 구분은 Phase 7」 단서는 있지만 「수탁자」 열이 어떤 기준을 따르는지는 문서에 없어, Meta가 수탁자로 정해진 것처럼 읽힌다"
  artifacts:
    - path: ".planning/baseline/DATA-INVENTORY.md"
      issue: "구간 E Facebook SDK 자동 이벤트 행(222행)의 수탁자 칸이 「Meta (Facebook SDK). 실제 전송 여부 미확인」으로, 수탁/제3자 제공 미정 단서가 없음"
    - path: ".planning/baseline/DATA-INVENTORY.md"
      issue: "머리 문단(12행 부근)에 「수탁자」 열의 기준(PRIV-03) 설명이 없음"
  missing:
    - "Meta 행의 수탁자 칸에 「수탁·제3자 제공 구분은 Phase 7에서 정함」 단서를 넣는다 (「실제 전송 여부 미확인」 표기는 유지)"
    - "머리 문단에 「수탁자」 열은 PRIV-03 기준(Google Firebase·GCP, 네이버클라우드는 수탁자, 로그인 제공자는 아님)이고 그 밖의 받는 곳의 구분은 Phase 7에서 한다는 한 줄을 더한다"
    - "열 이름과 REQUIREMENTS BASE-03·ROADMAP Phase 1 성공 기준 3의 문구는 바꾸지 않는다 (사용자 결정 2026-11-15)"
  debug_session: ""  # UAT 중 오케스트레이터가 직접 진단, 별도 debug 세션 없음
