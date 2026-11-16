---
status: testing
phase: 03-tailwind-cdn-removal
source: [03-VERIFICATION.md]
started: 2026-11-16T19:04:37Z
updated: 2026-11-16T19:04:37Z
---

## Current Test

number: 1
name: 실제 Safari(macOS)와 iOS Safari에서 세 법적 문서(/privacy-policy/, /terms/, /data-deletion/)를 열어 카드·여백·줄 간격·글자색·링크 밑줄을 본다
expected: |
  Playwright WebKit 캡처와 같은 모양이다. 판정은 Playwright Chromium·WebKit으로만 했다
awaiting: user response

## Tests

### 1. 실제 Safari(macOS)와 iOS Safari에서 세 법적 문서(/privacy-policy/, /terms/, /data-deletion/)를 열어 카드·여백·줄 간격·글자색·링크 밑줄을 본다
expected: Playwright WebKit 캡처와 같은 모양이다. 판정은 Playwright Chromium·WebKit으로만 했다
result: [pending]

### 2. 375·768·1280px 밖의 폭(예: 320, 414, 1024, 1440px)과 고배율 화면(DPR 2·3)에서 세 법적 문서를 본다
expected: 카드가 깨지지 않고 페이지 가로 스크롤이 없다
result: [pending]

### 3. 화면 낭독기(VoiceOver 등)로 법적 문서와 시험용 표 감싸개 figure(aria-label)를 읽는다
expected: 표가 표로 읽히고 figure의 aria-label이 발화된다
result: [pending]

### 4. 넓은 표가 있는 본문(Phase 7 처리 위탁 표 또는 시험 본문)에서 표를 오른쪽 끝까지 민다
expected: 더 밀 수 없는 쪽의 그림자가 사라진다 (D-08)
result: [pending]

### 5. 실제 Safari·iOS Safari에서 Tab 키로 표 감싸개 figure(tabindex=0)에 닿는지 확인한다
expected: figure에 포커스가 가고 키보드로 가로 스크롤된다 (D-07)
result: [pending]

### 6. 코드 리뷰 WR-01(rem 단위를 px로 옮김)을 판단한다: 브라우저 기본 글꼴 크기를 16px이 아닌 값(예: 20px)으로 바꾸고 법적 문서를 본다
expected: 사람이 받아들일지 정한다. 전환 전(Tailwind rem)은 글자·간격이 함께 커졌고, 지금(px)은 그대로다
result: [pending]

### 7. 저장소로 증명할 수 없는 사람 승인 사실을 확인한다: Playwright 1.59.1·pngjs 7.0.0 설치 승인(03-01), 시험 본문 승인 SC4_DECISION=approved와 TABLE_WRAP=nowrap 선택(03-05), 사이트 푸시 SHA 2ebeca06ca51 승인(03-06), 문서 푸시 SHA 3f148e83d849 승인(03-09), 두 푸시에서 --no-verify를 쓰지 않음
expected: 모두 실제로 사람이 승인했고 EVIDENCE 기록과 같다
result: [pending]

### 8. 「금지 사항(Prohibitions)」 표(03-VERIFICATION.md)의 judgment 등급 33건에 대한 검증자 판정(비권위)을 확인하고 각 항목을 해소한다
expected: 각 항목이 지켜졌다고 사람이 확인한다
result: [pending]

## Summary

total: 8
passed: 0
issues: 0
pending: 8
skipped: 0
blocked: 0

## Gaps
