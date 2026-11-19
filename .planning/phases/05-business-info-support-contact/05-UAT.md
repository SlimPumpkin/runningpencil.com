---
status: complete
phase: 05-business-info-support-contact
source: [05-VERIFICATION.md]
started: 2026-11-19T19:52:59Z
updated: 2026-11-19T20:06:29.906Z
---

## Current Test

[testing complete]

## Tests

### 1. [insufficient_spec, 05-05 truth 5 / SC3 일부 / BIZ-01] 라이브 https://runningpencil.com/ 푸터의 상호·대표자·사업자등록번호·주소 네 줄을 사업자등록증 원본과 글자 단위로 대조한다 (띄어쓰기·괄호·「주식회사」 위치 포함)
expected: 네 값이 사업자등록증과 글자까지 같다. 다르면 `_data/company.yml` 한 파일만 고쳐 다시 푸시한다
result: pass

### 2. [insufficient_spec, 05-09 truth 4·05-14 truth 3 / SC2 일부 / SITE-03] Search Console에서 `runningpencil.com` 도메인 속성을 연다
expected: 속성 유형이 도메인 속성이고 소유권 상태가 「확인됨」이다
result: pass

### 3. [insufficient_spec, 05-10 truth 2 / SC1 전제 / SUP-02] Gmail·네이버·iCloud·Outlook 계정 가운데 하나 이상(가능하면 iCloud·Outlook)에서 지원 주소로 시험 메일을 한 통 더 보낸다
expected: 운영자 업무 메일 받은편지함에 도착한다. 참고: 기록된 4/4는 1차 시험에서 iCloud·Outlook 두 통이 스팸함에 들어간 뒤, 운영자 Gmail에 「받는 사람이 지원 주소 → 스팸함으로 보내지 않음」 필터(저장소 밖 운영 설정)를 만들고 다시 보낸 결과다. 이 필터가 지워지면 같은 분류가 되돌아올 수 있고, 필터 때문에 실제 스팸도 받은편지함에 들어온다
result: pass

### 4. [insufficient_spec, 05-14 truth 1] Gmail 작성 화면에서 From으로 지원 주소를 골라 외부 계정으로 한 통 보낸다
expected: From 목록에 지원 주소가 있고, 받은 쪽에서 보낸 사람이 지원 주소로 보인다
result: pass

### 5. 실기기 iPhone Safari에서 https://runningpencil.com/ 과 https://runningpencil.com/support/ 를 연다. 푸터 사업자 줄, 이메일 링크, 지원 페이지의 이메일 링크를 눌러 본다 (05-01·05-15 계획이 단계 끝 사람 확인으로 넘김)
expected: 푸터 항목이 중간에서 끊기지 않고(긴 항목 하나는 자기 상자 안에서만 줄을 바꿈) 가로로 밀리지 않는다. 지원 페이지 맨 위에 「러닝펜슬 고객 지원」, 그 아래 문의하기 → 공개 코스 신고 → 자주 묻는 질문 순서다. 이메일 링크를 누르면 메일 앱이 지원 주소로 열린다. 푸터 「고객 지원」 링크로 지원 페이지가 열린다
result: pass

### 6. VoiceOver(iOS 또는 macOS)로 https://runningpencil.com/support/ 와 아무 페이지의 푸터를 읽는다 (05-01·05-15 계획이 단계 끝 사람 확인으로 넘김)
expected: h1 「러닝펜슬 고객 지원」, h2 세 개, FAQ의 질문(dt)·답(dd) 네 쌍이 차례로 읽힌다. 푸터 내비게이션 이름이 「약관 및 지원」이고 링크 네 개(개인정보처리방침·이용약관·데이터 삭제 안내·고객 지원)가 읽힌다. 사업자 항목이 「·」 구분과 함께 자연스럽게 읽힌다
result: pass

### 7. 05-EVIDENCE.md에 기록만 있는 과정 사실을 확인한다: (1) Playwright 1.59.1을 pnpm으로 스크래치에 설치하는 것을 checkpoint에서 승인함(05-01), (2) 05-05 D-10 checkpoint에서 로컬 빌드 푸터 글과 구분 기호 선택지 2(`&nbsp;· `)를 승인함, (3) 첫 푸시 `57e56b07f2ab`, 게이트 푸시 `2bd47891b837`, 문서 푸시 `e0f233169329`를 각각 SHA를 보고 승인함(05-06·05-12·05-15)
expected: 세 건 모두 기억·대화 기록대로였다고 확인한다. git·Pages로 볼 수 있는 부분(Phase 5 동안 Pages가 빌드한 커밋이 정확히 이 세 SHA이고 서로 조상 관계라 force push 흔적이 없음, 각 푸시의 사이트 파일 범위)은 검증자가 이미 확인했다
result: pass

### 8. 아래 「금지 항목」 표의 비권위 판정 40건(judgment 등급, 모두 unverified-prohibition — human review recommended)을 훑는다
expected: 판정에 동의하거나, 동의하지 않는 항목을 gap으로 돌린다. 「기록 근거」로 표시한 항목은 7번 과정 사실과 함께 정한다
result: pass

### 9. [결정 요청] BIZ-02·BIZ-03의 추적을 정한다. 두 요구사항의 문구는 삭제 안내·처리방침·보호책임자·위치약관까지 포함하지만, REQUIREMENTS.md 추적 표와 ROADMAP은 두 ID를 Phase 5에만 걸었다. Phase 6~8의 Requirements 줄에도 성공 기준에도 「`_data` 한 곳에서 읽음」이나 「전화 칸 연결」 조건이 없다
expected: 다음 가운데 하나를 고른다: (a) BIZ-02·BIZ-03을 Phase 6·7·8의 Requirements 줄에 더하고 각 단계 성공 기준에 「사업자 값·연락처는 `_data/company.yml`에서 읽고, 값이 없으면 그리지 않는다」 조건을 넣는다, (b) 요구사항을 「Phase 5 범위(푸터·지원 페이지)」와 「법적 문서 범위」로 나눈다, (c) 문구를 Phase 5 범위로 줄인다. 그 전까지 REQUIREMENTS.md의 BIZ-02·BIZ-03 체크는 하지 않는다
result: pass
decision: "b — 요구사항을 Phase 5 범위(푸터·지원 페이지)와 법적 문서 범위로 나눈다"

## Summary

total: 9
passed: 9
issues: 0
pending: 0
skipped: 0
blocked: 0

## Gaps
