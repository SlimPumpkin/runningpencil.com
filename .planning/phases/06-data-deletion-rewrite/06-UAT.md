---
status: testing
phase: 06-data-deletion-rewrite
source: [06-VERIFICATION.md]
started: 2026-11-27T05:12:59Z
updated: 2026-11-27T05:12:59Z
---

## Current Test

number: 1
name: 실기기 휴대폰(375px 안팎)에서 https://runningpencil.com/data-deletion/ 을 처음 연다
expected: |
  첫 화면에서 「삭제 요청 방법」 조항을 찾을 수 있고, 조금만 내리면 「② 앱 없이 지원 이메일로 요청하기」와 mailto 링크, 「메일에 적을 내용」 목록이 나온다. 이것이 성공 기준 1의 「문서 첫 화면에서 찾는다」와 DEL-01의 「눈에 띄게」를 충족하는지 사람이 판단한다
awaiting: user response

## Tests

### 1. 실기기 휴대폰(375px 안팎)에서 https://runningpencil.com/data-deletion/ 을 처음 연다
expected: 첫 화면에서 「삭제 요청 방법」 조항을 찾을 수 있고, 조금만 내리면 「② 앱 없이 지원 이메일로 요청하기」와 mailto 링크, 「메일에 적을 내용」 목록이 나온다. 이것이 성공 기준 1의 「문서 첫 화면에서 찾는다」와 DEL-01의 「눈에 띄게」를 충족하는지 사람이 판단한다
result: [pending]

### 2. Google Play와 App Store의 공개 등록정보(스토어 페이지)에 보이는 개발자·판매자 이름을 라이브 삭제 안내 소개 문단의 개발자 이름과 대조한다
expected: 두 스토어의 공개 표시와 소개 문단의 이름이 글자까지 같다 (성공 기준 1, DEL-02)
result: [pending]

### 3. 개발자 이름 값 「.planning·기록에 없음」 truth 넷(06-08 #3, 06-09 #6, 06-11 #4, 06-12 #2)과 06-VALIDATION.md 「D-02·D-18」 행을 어떻게 읽을지 정한다
expected: 사용자가 (가) 기준 이전부터 추적 파일에 있던 글자이고 값을 받기 전에 쓴 대조 낱말이라 받아들인다(아래 override 제안), 또는 (나) 06-EVIDENCE.md:1261의 해당 낱말을 지우는 문서 커밋을 낸다 가운데 하나를 고른다
result: [pending]

### 4. 앱 저장소의 기준 앱 커밋 AW(92e986c3bb29)에서 06-04가 적은 앱 사실을 읽기 전용으로 확인하거나, 기록(06-EVIDENCE.md 「06-04 앱 사실」·「06-04 화면 사실」)을 그대로 받아들일지 정한다
expected: 탈퇴·운영자 도구가 공개하지 않은 코스를 지우고 공개한 코스를 남김, uid rate_limits 삭제와 TTL, 운영자 도구 범위 account·records와 dry-run 기본, 코스 단위 기록 삭제, 확인자료 1기록 1건·184일·지체 없는 파기, 메뉴 문구 일곱이 AW 코드와 같다 (06-01 #3, 06-04 #1·#2·#3)
result: [pending]

### 5. 사람 결정과 승인 이력이 기록대로인지 확인한다: Playwright 설치 승인(06-01 #4), p6-deletion 도구 음성·양성 대조(06-01 #5), installation ID 선택(06-03 #2), 익명 문장 (가)와 D-33 ②·D-39 결정(06-06 #3·#4), 원고·캡처 승인(06-07 #9), 가짜 값 시험 실행(06-08 #1·#2), 푸시 전 소개 문단 대조·SHA 승인과 커밋 없음(06-09 #3·#4)
expected: 각 결정·승인을 사용자가 직접 했고 기록의 표식(INSTALL_ID, D33_C7, D33_C8 등, DRAFT_APPROVED, PUSH1_APPROVED, PUSH2_APPROVED)과 같다
result: [pending]

### 6. 아래 prohibitions_flagged의 판단 단계 금지 사항 33건을 항목마다 확인해 해결(resolved)로 둘지 정한다
expected: 항목마다 검증자의 비권위 판정과 근거를 보고 사람이 받아들이거나 되돌린다
result: [pending]

## Summary

total: 6
passed: 0
issues: 0
pending: 6
skipped: 0
blocked: 0

## Gaps
