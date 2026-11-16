---
status: complete
phase: 03-tailwind-cdn-removal
source: [03-VERIFICATION.md]
started: 2026-11-16T19:04:37Z
updated: 2026-11-16T19:50:18.123Z
---

## Current Test

[testing complete]

## Tests

### 1. 실제 Safari(macOS)와 iOS Safari에서 세 법적 문서(/privacy-policy/, /terms/, /data-deletion/)를 열어 카드·여백·줄 간격·글자색·링크 밑줄을 본다
expected: Playwright WebKit 캡처와 같은 모양이다. 판정은 Playwright Chromium·WebKit으로만 했다
result: pass

### 2. 375·768·1280px 밖의 폭(예: 320, 414, 1024, 1440px)과 고배율 화면(DPR 2·3)에서 세 법적 문서를 본다
expected: 카드가 깨지지 않고 페이지 가로 스크롤이 없다
result: pass
source: automated
note: "사용자 요청으로 Claude가 대신 확인함. 라이브 runningpencil.com(사이트 파일은 HEAD와 같음)을 Playwright 1.59.1 Chromium·WebKit(headless)으로 폭 320·360·414·1024·1440 × deviceScaleFactor 1·2·3 × 문서 3종 = 90건 측정. 90건 모두 200, documentElement·body scrollWidth = 화면 폭, scrollTo(500,0) 뒤 scrollX 0, 카드가 화면 안([24,296]@320 … [344,1096]@1440), figure 밖 요소 중 화면·카드를 넘는 것 0. 캡처 5조합을 눈으로 확인함. 실기기 고배율 화면은 보지 않았고 deviceScaleFactor 에뮬레이션으로 갈음함"

### 3. 화면 낭독기(VoiceOver 등)로 법적 문서와 시험용 표 감싸개 figure(aria-label)를 읽는다
expected: 표가 표로 읽히고 figure의 aria-label이 발화된다
result: pass
source: automated
note: "사용자 요청으로 Claude가 대신 확인함. 시험 본문($W/fixtures/sample.html)을 HEAD 트리에 스크래치로만 넣어 production·--safe 빌드(style 블록이 라이브와 같음). (1) 실제 macOS Safari 창의 접근성 트리(VoiceOver가 읽는 AX 트리, Orca computer-use로 읽음): figure 2개가 각각 이름 '처리 위탁 현황 (시험)'·'시험 항목과 값 (시험)'인 그룹이고, 그 안에 '표'가 있고 행 4·3개와 셀 5·2개씩이 있음. (2) Chromium CDP 전체 AX 트리: figure 역할에 같은 이름, focusable, 표 역할은 table(LayoutTable 아님), columnheader 5·2, cell 15·4. (3) 두 엔진 모두 table의 계산된 display가 table. (4) 라이브 처리방침·삭제 안내의 main은 article·heading·list 구조로 나옴(현재 라이브 문서에는 표가 없음). VoiceOver의 실제 음성과 iOS VoiceOver는 듣거나 보지 않음"

### 4. 넓은 표가 있는 본문(Phase 7 처리 위탁 표 또는 시험 본문)에서 표를 오른쪽 끝까지 민다
expected: 더 밀 수 없는 쪽의 그림자가 사라진다 (D-08)
result: pass
source: automated
note: "사용자 요청으로 Claude가 대신 확인함. 라이브 문서에는 아직 표가 없어 Test 3과 같은 시험 본문 빌드(HEAD + $W/fixtures/sample.html, 스크래치)를 씀. Playwright Chromium·WebKit, 375px·DPR 2. 넓은 표 figure(넘침 184·185px)를 scrollLeft 처음·중간·끝으로 옮기고 표 글자만 투명하게 한 figure 캡처에서 가장자리 4px 띠의 평균 어두움을 가운데 띠와 비교: 처음 왼쪽 0.4~0.5 / 오른쪽 15.0~15.6, 중간 양쪽 13.9~15.6, 끝 왼쪽 13.9~15.6 / 오른쪽 0.5(가운데 0.5와 같음). 넘치지 않는 좁은 표는 양쪽 0.7로 그림자 없음. 두 엔진 8건 모두 기대와 같음. 글자 있는 캡처로도 눈으로 확인함. 실기기 터치 스와이프는 하지 않음(scrollLeft를 코드로 옮김)"

### 5. 실제 Safari·iOS Safari에서 Tab 키로 표 감싸개 figure(tabindex=0)에 닿는지 확인한다
expected: figure에 포커스가 가고 키보드로 가로 스크롤된다 (D-07)
result: pass
source: automated
note: "사용자 요청으로 Claude가 대신 확인함. 실제 macOS Safari(사용자 기본 설정 그대로)에서 Orca computer-use로 키를 보냄. 시험 본문 빌드의 스크래치 복사본(sample-kb: 카드 max-width 375px로 좁혀 넓은 표가 177px 넘치게 하고, 포커스 요소와 scrollLeft를 문서 제목에 적는 관찰 스크립트만 더함). Tab 1번 → figure '처리 위탁 현황 (시험)'(머리말 링크는 Safari 기본 설정대로 건너뜀), Tab 2번 → figure '시험 항목과 값 (시험)'. Shift+Tab으로 첫 표에 돌아가 → 15번에 scrollLeft 0→172/177(부드러운 스크롤 도중 값), ← 3번에 136. 캡처에서 포커스 테두리(파란 3px)와 양쪽 그림자를 눈으로 확인함. 실기기 iOS Safari(하드웨어 키보드)는 확인하지 않음"

### 6. 코드 리뷰 WR-01(rem 단위를 px로 옮김)을 판단한다: 브라우저 기본 글꼴 크기를 16px이 아닌 값(예: 20px)으로 바꾸고 법적 문서를 본다
expected: 사람이 받아들일지 정한다. 전환 전(Tailwind rem)은 글자·간격이 함께 커졌고, 지금(px)은 그대로다
result: pass

### 7. 저장소로 증명할 수 없는 사람 승인 사실을 확인한다: Playwright 1.59.1·pngjs 7.0.0 설치 승인(03-01), 시험 본문 승인 SC4_DECISION=approved와 TABLE_WRAP=nowrap 선택(03-05), 사이트 푸시 SHA 2ebeca06ca51 승인(03-06), 문서 푸시 SHA 3f148e83d849 승인(03-09), 두 푸시에서 --no-verify를 쓰지 않음
expected: 모두 실제로 사람이 승인했고 EVIDENCE 기록과 같다
result: pass

### 8. 「금지 사항(Prohibitions)」 표(03-VERIFICATION.md)의 judgment 등급 33건에 대한 검증자 판정(비권위)을 확인하고 각 항목을 해소한다
expected: 각 항목이 지켜졌다고 사람이 확인한다
result: pass
source: automated
note: "사용자 요청으로 Claude가 표 28행(33건)의 근거를 다시 실행함(스크래치 recheck.sh). 27행 OK, '--no-verify' 1행은 저장소로 증명할 수 없어 Test 7의 사람 확인(pass)으로 갈음. 다시 실행한 근거: judge.sh base2·c1·c1p·c2·c3·nw를 저장 캡처로 재계산해 모두 OK. 라이브 3문서는 Pretendard 밖 stylesheet 0, script 0, tailwind 0, BASE 빌드와 main 글자 동일 3/3, noindex·임시 게시본 3/3. /sample/ 404, 도구·시험 본문의 ls-files와 이력 0. common.css는 BASE와 같음. legal.css 선택자 35개 중 범위 밖 0(html·body·main만 있음), hex는 토큰과 기존 값뿐. C2·CK5·NW 커밋은 각각 정해진 파일만 바꿈. origin/main=3f148e8, 9f715c7→2ebeca0→3f148e8 fast-forward, reflog는 모두 update by push, merge 0. 사이트 푸시 범위에 CLAUDE.md·README 0. PROJECT.md 변경 0. 추가 줄에 이메일·로컬 경로 0. generate-claude-md 재생성 결과가 바이트 동일. 두 방침 구간 동일. 바뀐 방침 행은 Jekyll 1행. ROADMAP 성공 기준 변경 0. 첫 실행의 FAIL 2건(6번 선택자 분리, 26번 구간 추출)은 확인 스크립트 버그였고 고쳐 다시 확인함"

## Summary

total: 8
passed: 8
issues: 0
pending: 0
skipped: 0
blocked: 0

## Gaps
