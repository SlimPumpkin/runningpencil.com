---
status: testing
phase: 01-ground-truth-policy-reset
source: [01-VERIFICATION.md]
started: 2026-11-15T08:27:17Z
updated: 2026-11-15T08:27:17Z
---

## Current Test

number: 1
name: URL 대장(.planning/baseline/URLS.md)의 「등록할 콘솔 필드(범주)」 열을 제공자·스토어별로 훑어본다 (01-01 human-check)
expected: |
  URL마다 등록할 곳이 범주 수준으로 적혀 있고, 확인되지 않은 필드명을 확정된 것처럼 적은 칸이 없다
awaiting: user response

## Tests

### 1. URL 대장(.planning/baseline/URLS.md)의 「등록할 콘솔 필드(범주)」 열을 제공자·스토어별로 훑어본다 (01-01 human-check)
expected: URL마다 등록할 곳이 범주 수준으로 적혀 있고, 확인되지 않은 필드명을 확정된 것처럼 적은 칸이 없다
result: [pending]

### 2. 절차서(.planning/baseline/USER-TASKS.md)의 작업마다 「막는 단계」를 .planning/ROADMAP.md의 External Gates 표와 대조한다 (01-02 human-check). 특히 작업 6(DKIM, 가비아 DNS 2차 방문)의 막는 단계를 본다: 절차서는 「Phase 10 Apple 릴레이, D-11」로 적고 이메일 게이트는 DKIM을 기다리지 않는다고 하지만, ROADMAP External Gates 표의 가비아 DNS 행은 1차·2차 방문(DKIM 포함)을 묶어 Phase 5를 막는다고 적는다
expected: 작업 0~12의 막는 단계가 ROADMAP의 게이트와 어긋나지 않는다 (DNS·메일은 Phase 5, 화면 캡처는 Phase 4, DKIM은 Phase 10의 릴레이 답장 전제)
result: [pending]

### 3. 결정 목록(.planning/baseline/DECISIONS.md) 「한눈에 보기」의 막는 단계 칸을 .planning/ROADMAP.md의 External Gates 표와 대조하고, U2·U3·U7의 「기본 동작」 문구를 읽는다 (01-04 human-check)
expected: 항목마다 막는 단계가 ROADMAP의 게이트와 어긋나지 않는다. 법률 판단 항목의 기본 동작이 결론이 아니라 임시 방침으로 읽히고 사용자가 받아들일 수 있는 문구다
result: [pending]

### 4. 데이터 목록 「CLI 조회 기록」 표의 결과와, 조회에 성공한 리전·TTL·백업·버킷 칸을 사용자가 Firebase·GCP 콘솔에서 아는 값과 견주어 본다 (01-08 human-check). 함께 확인: 01-08 실행이 조회(list) 명령만 썼고 dev 설정·데이터가 바뀌지 않았는지, 특히 SUMMARY가 적은 대로 `firebase ext:list`의 확장 API 확인 단계가 API를 새로 켜지 않았는지
expected: 조회한 값이 dev 프로젝트의 실제 설정과 같고, 건너뛰거나 실패한 조회의 칸은 「CLI 미확인」으로 남아 있다. 문서에 버킷 이름이나 계정 정보가 없다. dev 프로젝트의 API 사용 설정과 리소스가 조회 전과 같다. 판정 불가로 둔 01-08 금지 사항 세 개(설정·데이터 변경 금지, 다른 자격 증명 사용 금지, 문서·객체 내용 조회 금지)가 지켜졌음을 사용자가 확인한다
result: [pending]

### 5. 이름 표(.planning/baseline/NAMES.md)의 상호·대표자·사업자등록번호·주소·영문 법인명·스토어 개발자 이름·전화번호 칸을 눈으로 본다 (VALIDATION Manual-Only, BASE-01)
expected: 칸이 비어 있거나 사용자가 준 값뿐이다 (검증 시점 관찰: 일곱 칸 모두 「(빈칸)」 표기)
result: [pending]

### 6. 01-01 판단 등급 금지 사항 3개(사업자 값 추측 금지, 공개 전 사업자 값 커밋 금지, 콘솔 필드를 확정 필드명처럼 적지 않음)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: [pending]

### 7. 01-02 판단 등급 금지 사항 2개(발급 값 추정 기재 금지, 기존 DNS 레코드 삭제·수정 안내 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: [pending]

### 8. 01-03 판단 등급 금지 사항 3개(미확인 값을 확인된 것처럼 적지 않음, 법적 성격 단정 금지, 실제 사용자 데이터 값 옮기지 않음)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: [pending]

### 9. 01-04 판단 등급 금지 사항 3개(법률 항목 기본 동작을 결론처럼 적지 않음, U12 말고 「결정됨」 금지, U11 기본값 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: [pending]

### 10. 01-05 판단 등급 금지 사항 3개(비공개 코스 삭제·공개 코스만 남음으로 적지 않음, 즉시 전부 삭제로 읽히게 적지 않음, 선택지만 있는 값 추측 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: [pending]

### 11. 01-06 판단 등급 금지 사항 3개(옛 규칙 문장 인용 금지, 코드 설명을 미래 상태로 고쳐 쓰지 않음, 방침을 지금 코드에 반영하라는 뜻으로 읽히지 않음·지원 주소 문자열 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: [pending]

### 12. 01-07 판단 등급 금지 사항 3개(D-21 밖 ROADMAP 내용 변경 금지, 연구 본문 수정·삭제 금지, 연구 캐시 커밋 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: [pending]

### 13. 01-08 판단 등급 금지 사항 1개(조회하지 못한 칸을 추정값으로 채우지 않음 (나머지 세 개는 위 01-08 항목에서 다룸))를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다
expected: 각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다
result: [pending]

## Summary

total: 13
passed: 0
issues: 0
pending: 13
skipped: 0
blocked: 0

## Gaps
