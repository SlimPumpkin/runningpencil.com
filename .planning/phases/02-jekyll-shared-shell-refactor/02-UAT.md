---
status: complete
phase: 02-jekyll-shared-shell-refactor
source: [02-VERIFICATION.md]
started: 2026-11-16T07:20:00Z
updated: 2026-11-16T08:16:39.729Z
---

## Current Test

[testing complete]

## Tests

### 1. 로컬 미리보기로 네 페이지 확인 (02-09 Task 2 human-check)
expected: `bundle exec jekyll serve --livereload` → http://localhost:4000 의 네 페이지가 전환 전과 같은 모양으로 열리고, 헤더 메뉴(랜딩은 같은 페이지 안 이동, 법적 페이지는 `/#story` 등)와 푸터 링크가 동작하며, 브라우저 콘솔에 오류가 없다
result: pass
source: automated
evidence: |
  2026-11-16 Playwright(Chromium) 자동 확인. 비교 기준은 전환 전 커밋 db505d7(`git archive`를 정적 서버 :4001로 띄움).
  - 명령: 저장소 루트에서 `bundle exec jekyll serve --livereload` → "Server running" http://127.0.0.1:4000, 네 URL 200
  - 모양: 1280×900·390×844, 움직임 줄이기 에뮬레이션, 전체 페이지 스크린숏 픽셀 비교. 8쌍 중 7쌍 0픽셀 차이.
    랜딩 1280은 12픽셀이 채널값 1만 다름. 같은 기준 페이지를 다시 찍어도 99픽셀(최대 18)이 달라지므로 렌더링 잡음 안. 페이지 높이·제목도 모두 같음
  - 링크: 네 페이지의 헤더·푸터 href가 기준과 같음. 28번 클릭 모두 기대 위치에 도착(랜딩 #top/#story/#demo/#get, 법적 → /, /#story, /#demo, /#get 대상 top≈0, 푸터 → 세 법적 페이지)
  - 콘솔: error·pageerror·요청 실패 0건. Tailwind CDN "should not be used in production" warning만 있음(전환 전부터 있었고, Phase 3에서 정리할 항목)
  - 참고(도구 간섭, 사이트 결함 아님): Playwright MCP가 저장소 안 `.playwright-mcp/`에 콘솔 로그를 쓰면 `jekyll serve` 감시가 이를 변경으로 보고 다시 빌드하고, livereload가 페이지를 새로 고쳐 반복됨. 픽셀 비교 때는 livereload.js만 빈 응답으로 막음

### 2. ROADMAP 성공 기준 1 문구 결정 (D-06)
expected: ROADMAP §Phase 2 성공 기준 1의 「차이가 0」을 D-06 예외(「공통」 CSS 머리 주석 한 줄 × 4문서)에 맞게 고치거나, 02-VERIFICATION.md frontmatter에 override를 사람이 적는다. 어느 쪽이든 판정 문구와 실제 최종 출력이 어긋나지 않게 된다
result: pass
decision: "ROADMAP 문구를 D-06 예외에 맞게 고치자"
evidence: "커밋 5cca635 — ROADMAP §Phase 2 성공 기준 1을 「전환 커밋(법적 3종, 랜딩) 시점에는 차이가 0 … 단계를 마친 뒤의 출력은 「공통」 CSS 머리 주석 한 줄만 다르고(D-06에서 승인한 예외), 주석을 지운 뒤 비교하면 차이가 0」으로 고침. override는 쓰지 않음"

### 3. 푸시 승인과 `--no-verify` 미사용 확인 (흔적이 남지 않는 금지 사항)
expected: 기준 커밋 푸시와 푸시 ①~④가 각각 사람이 승인 단계에서 본 SHA 그대로 나갔고(`02-EVIDENCE.md`의 `BASE_PUSH_SHA`, `PUSH1~4_SHA`), 실행자가 `git push --no-verify`를 쓰지 않았다. 검증자의 비권위 판정은 「위반 흔적 없음」(다섯 푸시 모두 fast-forward, Pages 빌드 built·오류 없음)
result: pass
evidence: "사용자 확인 — 다섯 푸시(db505d7, d5a6679, 01f6bb8, e7e62f3, 9f715c7) 모두 승인 뒤에 나갔고 --no-verify 미사용"

## Summary

total: 3
passed: 3
issues: 0
pending: 0
skipped: 0
blocked: 0

## Gaps
