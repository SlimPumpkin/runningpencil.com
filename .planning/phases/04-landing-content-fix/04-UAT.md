---
status: testing
phase: 04-landing-content-fix
source: [04-VERIFICATION.md]
started: 2026-11-18T08:37:58Z
updated: 2026-11-18T08:37:58Z
---

## Current Test

number: 1
name: 스크래치 `$W/cap/c2/`의 `chromium-1280-step3.png`, `chromium-375-step3.png`, `webkit-1280-step3.png`, `webkit-375-step3.png`를 열어 본다 (단계 끝 UAT). 스크래치가 지워졌으면 라이브 https://runningpencil.com/ 「세 가지 이유」 3단계를 1280·375px에서 본다
expected: |
  뱃지 줄 일곱 개가 모두 컬러이고 회색 뱃지가 없다. 캡션이 「보관함 · 받은 뱃지 7」이다. 패널 스티커에 회색이 없고 색 배치가 어색하지 않다
awaiting: user response

## Tests

### 1. 스크래치 `$W/cap/c2/`의 `chromium-1280-step3.png`, `chromium-375-step3.png`, `webkit-1280-step3.png`, `webkit-375-step3.png`를 열어 본다 (단계 끝 UAT). 스크래치가 지워졌으면 라이브 https://runningpencil.com/ 「세 가지 이유」 3단계를 1280·375px에서 본다
expected: 뱃지 줄 일곱 개가 모두 컬러이고 회색 뱃지가 없다. 캡션이 「보관함 · 받은 뱃지 7」이다. 패널 스티커에 회색이 없고 색 배치가 어색하지 않다
result: [pending]

### 2. 스크래치 `$W/cap/c3/`의 `chromium-1280-screens.png`, `webkit-375-screens.png`, `webkit-375-end.png`, `chromium-1280-seam.png`를 열어 본다 (단계 끝 UAT). 스크래치가 지워졌으면 라이브 「실제 앱 화면」 구간을 1280·375px에서 본다. 주의: ③ 완주 결과는 사용자 예외(D-20)라 원본에서 이미 앱의 뱃지 창이 NAVER 로고를 덮고 있다. ③은 「테두리·둥근 모서리가 로고를 원본보다 더 깎지 않았는가」만 본다
expected: 제목 옆 「출시 준비 중」 딱지, 폰 테두리 속 캡처 세 장과 캡션, 오른쪽 아래 「지도 © NAVER Corp.」가 보인다. NAVER 로고가 깎이지 않았고, 375px에서는 다음 장이 조금 보이며, 구간 아래 둥근 모서리 사이로 노랑이 들어간다
result: [pending]

### 3. 실기기 iPhone Safari에서 https://runningpencil.com/ 의 「실제 앱 화면」 구간을 연다 (단계 끝 UAT). 주의: ③ 완주 결과의 NAVER 로고는 사용자 예외(D-20)라 원본에서 앱의 뱃지 창에 덮여 있다. ①·②만 로고가 온전해야 한다
expected: 제목 옆 「출시 준비 중」 딱지, 폰 테두리 속 캡처 세 장과 캡션, 「지도 © NAVER Corp.」가 보인다. 손가락으로 세 장을 가로로 밀 수 있고 페이지 전체는 옆으로 밀리지 않는다. 캡처 속 NAVER 로고가 온전하고, 개인 정보·하단 탭·Dev 표시가 보이지 않는다
result: [pending]

### 4. VoiceOver(iOS·macOS) 같은 화면 낭독기로 「실제 앱 화면」 구간과 가로 띠를 읽는다
expected: 제목 「실제 앱 화면」, 띠 이름 「러닝펜슬 앱 화면 3장」, 목록 항목 3개, 각 이미지의 대체 글과 캡션을 차례로 읽는다. 띠에 키보드 포커스가 가고 → 키로 밀린다
result: [pending]

### 5. (선택) 카카오톡·Slack 같은 공유 미리보기에 https://runningpencil.com/ 을 붙여 본다
expected: 미리보기 설명이 새 og:description 「GPS 아트 코스를 완주하고 코스 모양의 뱃지를 모으세요. 나만의 코스를 그려 올릴 수도 있어요.」이다. 옛 설명(포인트·굿즈·코스북)이 보이면 각 서비스의 캐시 갱신 도구로 다시 긁는다
result: [pending]

### 6. 04-EVIDENCE.md에 기록만 있고 다시 만들 수 없는 과정 사실 8건. 사용자가 직접 확인할 수 있는 것: (1) Playwright 1.59.1 설치를 checkpoint에서 승인함(04-02), (3) PUSH1 073d33e0e50a 승인(04-05), (4) PUSH2 6e46bdcb24e0 승인(04-08), (6) 캡처 세 장을 시험 계정·시험 경로로 찍어 넘김(04-09), (7) PUSH3 95062367dc69를 캡처·구간 화면을 보고 승인(04-11), (8) PUSH4 9cc14903adbd 승인(04-13). 에이전트가 한 일이라 사용자가 기억할 수 없는 것: (2) p4-behave 음성 대조 FAIL behave(04-02), (5) 합성 Display P3 파이프라인 시험(04-09). 이 둘은 기록을 받아들일지만 정한다
expected: 여섯 건은 기억과 대화 기록대로였다고 확인하고, 두 건은 EVIDENCE 기록을 받아들인다. git으로 볼 수 있는 부분(각 푸시 범위의 파일, 커밋 순서, 원격 main에 merge 커밋 0개, CAND3가 어떤 ref에도 없음)은 검증자가 이미 확인했다
result: [pending]

### 7. frontmatter `overrides:`의 04-09 truth 3 항목(③ 로고 덮임과 상태 표시줄 차이를 사용자 예외로 통과)을 읽는다
expected: 04-CONTEXT D-18·D-20의 2026-11-18 결정과 같은 뜻이면 그대로 둔다. 아니면 항목을 지우고, 그 truth를 FAILED로 다시 판정받는다
result: [pending]

### 8. 아래 「금지 항목」 표의 비권위 판정 53건(judgment 등급, 모두 unverified-prohibition — human review recommended)을 훑는다
expected: 판정에 동의하거나, 동의하지 않는 항목을 gap으로 돌린다. 「확인 불가 (기록 근거)」 묶음은 6번 항목과 함께 정한다
result: [pending]

## Summary

total: 8
passed: 0
issues: 0
pending: 8
skipped: 0
blocked: 0

## Gaps
