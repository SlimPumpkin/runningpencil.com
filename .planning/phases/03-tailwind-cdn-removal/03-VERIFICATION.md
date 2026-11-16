---
phase: 03-tailwind-cdn-removal
verified: 2026-11-16T19:03:42Z
status: human_needed
score: 43/46 must-haves verified
covered_files:
  - ".claude/CLAUDE.md"
  - ".planning/codebase/ARCHITECTURE.md"
  - ".planning/codebase/CONCERNS.md"
  - ".planning/codebase/CONVENTIONS.md"
  - ".planning/codebase/INTEGRATIONS.md"
  - ".planning/codebase/STACK.md"
  - ".planning/codebase/STRUCTURE.md"
  - ".planning/codebase/TESTING.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-01-PLAN.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-01-SUMMARY.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-02-PLAN.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-02-SUMMARY.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-03-PLAN.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-03-SUMMARY.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-04-PLAN.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-04-SUMMARY.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-05-PLAN.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-05-SUMMARY.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-06-PLAN.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-06-SUMMARY.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-07-PLAN.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-07-SUMMARY.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-08-PLAN.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-08-SUMMARY.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-09-PLAN.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-09-SUMMARY.md"
  - ".planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md"
  - "CLAUDE.md"
  - "README.md"
  - "_includes/css/legal.css"
  - "_layouts/legal.html"
  - "data-deletion/index.html"
  - "privacy-policy/index.html"
  - "scripts/check-site.sh"
  - "terms/index.html"
covered_digest: "v4:sha256:5ac5224eb220a9c398b6bc8ce80cb5ebed84beee0f5c9e3e5d5be4e0f75cf858"
behavior_unverified: 0
overrides_applied: 0
human_verification:
  - test: "실제 Safari(macOS)와 iOS Safari에서 세 법적 문서(/privacy-policy/, /terms/, /data-deletion/)를 열어 카드·여백·줄 간격·글자색·링크 밑줄을 본다"
    expected: "Playwright WebKit 캡처와 같은 모양이다. 판정은 Playwright Chromium·WebKit으로만 했다"
    why_human: "자동 판정 범위 밖(EVIDENCE 「판정 범위 밖」). 실제 Safari 렌더링은 Playwright WebKit 빌드와 다를 수 있다"
  - test: "375·768·1280px 밖의 폭(예: 320, 414, 1024, 1440px)과 고배율 화면(DPR 2·3)에서 세 법적 문서를 본다"
    expected: "카드가 깨지지 않고 페이지 가로 스크롤이 없다"
    why_human: "캡처는 세 폭 × deviceScaleFactor 1로만 찍었다"
  - test: "화면 낭독기(VoiceOver 등)로 법적 문서와 시험용 표 감싸개 figure(aria-label)를 읽는다"
    expected: "표가 표로 읽히고 figure의 aria-label이 발화된다"
    why_human: "발화는 grep·캡처로 확인할 수 없다 (D-07)"
  - test: "넓은 표가 있는 본문(Phase 7 처리 위탁 표 또는 시험 본문)에서 표를 오른쪽 끝까지 민다"
    expected: "더 밀 수 없는 쪽의 그림자가 사라진다 (D-08)"
    why_human: "sample.mjs는 스크롤 위치 0의 넘침만 확인한다. 끝까지 민 뒤 상태는 자동 판정하지 않았다"
  - test: "실제 Safari·iOS Safari에서 Tab 키로 표 감싸개 figure(tabindex=0)에 닿는지 확인한다"
    expected: "figure에 포커스가 가고 키보드로 가로 스크롤된다 (D-07)"
    why_human: "Playwright WebKit 실측과 가정 A1만 근거다"
  - test: "코드 리뷰 WR-01(rem 단위를 px로 옮김)을 판단한다: 브라우저 기본 글꼴 크기를 16px이 아닌 값(예: 20px)으로 바꾸고 법적 문서를 본다"
    expected: "사람이 받아들일지 정한다. 전환 전(Tailwind rem)은 글자·간격이 함께 커졌고, 지금(px)은 그대로다"
    why_human: "성공 기준 2는 기본 설정 × 세 폭의 모양만 요구한다. 기본 글꼴 크기를 바꾼 사용자에게 '같은 모양'인지는 범위 해석과 접근성 판단이 필요하다. 03-REVIEW-DISPOSITION.md에서 WR-01은 아직 open"
  - test: "저장소로 증명할 수 없는 사람 승인 사실을 확인한다: Playwright 1.59.1·pngjs 7.0.0 설치 승인(03-01), 시험 본문 승인 SC4_DECISION=approved와 TABLE_WRAP=nowrap 선택(03-05), 사이트 푸시 SHA 2ebeca06ca51 승인(03-06), 문서 푸시 SHA 3f148e83d849 승인(03-09), 두 푸시에서 --no-verify를 쓰지 않음"
    expected: "모두 실제로 사람이 승인했고 EVIDENCE 기록과 같다"
    why_human: "git으로는 SHA·푸시 범위·훅 동작까지만 확인된다. 승인 행위 자체는 기록(03-EVIDENCE.md)으로만 남아 있다"
  - test: "아래 「금지 사항(Prohibitions)」 표의 judgment 등급 33건에 대한 검증자 판정(비권위)을 확인하고 각 항목을 해소한다"
    expected: "각 항목이 지켜졌다고 사람이 확인한다"
    why_human: "모든 금지 사항이 verification: judgment라 검증자 판정은 비권위다. 대화형 검증은 항목별로 사람이 해소해야 한다"
---

# Phase 3: 법적 페이지 정적 스타일 전환 (Tailwind CDN Removal) 검증 보고서

**Phase Goal:** 방문자가 외부 스크립트(Tailwind Play CDN) 없이 정적 CSS만으로 법적 문서 3종을 전환 전과 같은 모양으로 보고, 이후 단계는 클래스 없는 본문 마크업에 텍스트만 쓰면 된다
**Verified:** 2026-11-16T19:03:42Z
**Status:** human_needed
**Re-verification:** 아니요 (첫 검증)

## 결론 요약

ROADMAP 성공 기준 1~4는 모두 코드와 라이브에서 확인됐다. 검증자가 직접 한 확인은 다음과 같다.

- `BASE_SHA`와 HEAD를 production·`--safe`로 다시 빌드해 비교했다.
- 그 빌드에 `scripts/check-site.sh`를 돌렸고, pre-push 훅에는 표준 입력을 흉내 내 넣어 실행했다.
- 라이브 HTTP를 요청해 응답 HTML이 로컬 HEAD 빌드와 바이트까지 같은지 봤다.
- 저장된 캡처 전부(base2·c1·c1p·c2·c3·nw·live)를 대상으로 `diff.mjs`·`states.mjs`·`report.mjs`를 다시 계산했다.
- CLAUDE.md 생성기를 스크래치 사본에서 돌려 결과를 비교했다.

상태가 `passed`가 아닌 이유는 세 가지이고, 모두 사람이 확인해야 한다. 판정 범위 밖 항목(실제 Safari 등)이 있고, 사람 승인 사실은 기록으로만 증명된다. 또 금지 사항이 모두 judgment 등급이다. 차단(blocker) 결함은 없다.

## Goal Achievement

### Observable Truths — ROADMAP 성공 기준 (계약)

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| SC1 | 세 법적 문서의 HTML 소스와 브라우저 네트워크 요청 어디에도 `cdn.tailwindcss.com`이 없다 | ✓ VERIFIED | HEAD 빌드에서 `cdn.tailwindcss.com\|tailwind.config` 0개 파일, 기준 빌드에서 3개 파일(대조). 법적 출력의 외부 리소스는 Pretendard `<link>`(기존)뿐이고 `<script>`는 0개다. 라이브 `/privacy-policy/` `/terms/` `/data-deletion/`은 200·기대 제목·tw=0이고, 세 응답 HTML이 로컬 HEAD 빌드와 바이트가 같다. 네트워크 요청은 저장된 nw·live `report.json`에서 18행 모두 `tailwindReqs` 0건이다. 기준 base1은 18행 모두 `cdn.tailwindcss.com/3.4.17` 요청이 있었다. 이 값은 `report.mjs --no-cdn`으로 다시 계산해 `PASS 18 rows`였다. `check-site.sh HEAD`는 통과했고, 같은 검사가 커밋 ②(31327b6)는 Tailwind 메시지와 함께 실패시킨다 |
| SC2 | 375·768·1280px에서 전환 전·후 캡처를 비교하면 줄 간격·테두리·여백·글자색·카드 모양이 같다 | ✓ VERIFIED (판정 범위 안) | 저장된 캡처를 다시 계산했다. `diff.mjs`(허용 오차 0)로 base1 대비 base2·c1·c1p·c2·c3·nw·live가 모두 `PASS 0 diffs`(PNG 42장·txt 18건)였다. `states.mjs`는 각 24/24 유효했다. `report.mjs`도 모두 `PASS 18 rows`로, 높이·링크 색·밑줄·transition 3종·키보드 focus가 같았다. 한 픽셀 음성 대조 `judge-neg.out`은 `JUDGE neg FAIL`이다. **출처 주의**: 캡처는 실행자가 찍은 것이다. 검증자의 새 캡처는 스크래치 Playwright 패키지 파일이 지워져 있어(`playwright/index.js` 없음) 돌리지 못했고, 패키지를 새로 설치하지 않았다. 대신 출처를 연결했다: `nw/TREE` = `fb6bdfa^{tree}`, nw 빌드 HTML 4개 = HEAD 빌드와 바이트 같음, 라이브 HTML = HEAD 빌드와 바이트 같음. 그래서 nw·live 캡처는 지금 배포된 출력의 캡처다 |
| SC3 | 세 문서 본문에서 뽑은 텍스트가 전환 전과 같다(문장 변경 0) | ✓ VERIFIED | 검증자가 직접 BASE 빌드와 HEAD 빌드의 `<article>` 태그를 지우고 공백을 정규화해 비교했다. 세 문서 모두 같았다(2583·5173·948바이트). 렌더 텍스트 txt 18건도 c2·c3·nw·live에서 base1과 같다(diff.mjs 재계산) |
| SC4 | 클래스 없는 시험용 표·목록·주석을 본문에 넣어 보면 별도 클래스 없이 카드 디자인에 맞게 보인다 | ✓ VERIFIED | `legal.css`의 본문 규칙은 모두 `.rp-doc` 범위다(D-02~D-12 규칙 확인). 시험 본문 빌드 `samplenw/src`의 `legal.css`·`legal.html`·`common.css`가 HEAD와 바이트가 같다. 시험 본문에는 클래스가 0개이고, `figure tabindex="0" aria-label` 둘, `aside`, `h3` 둘, 중첩 `ol`·`ul`, `dl`, `footer`가 있다. `samplenw.out`은 두 엔진 × 세 폭 PASS(표 14px, 행 선 `rgb(228,224,214) 1px`, `ol ol` hangul, `ul ul` circle, `figDisplay: table`, 375px figure 안에서만 넘침)다. 검증자가 chromium-375 캡처를 직접 보고 카드 디자인에 맞는 것을 확인했다. 사용자 승인 `SC4_DECISION=approved`는 사람 확인 항목으로 넘긴다 |

### Observable Truths — PLAN must_haves

| # | Plan | Truth (요약) | Status | Evidence |
|---|------|--------------|--------|----------|
| 1 | 03-01 | `BASE_SHA`·`BASE_LIVE`를 기록했고, 둘은 `.planning/` 밖 트리가 같으며, 사이트 변경보다 먼저 기록했다 | ✓ VERIFIED | EVIDENCE:11-12. `git diff --quiet 9f715c795830 8b65fdb59232 -- . ':!.planning'`가 0이다. 기록 커밋 2ae417d는 첫 사이트 커밋 7cd2b61의 조상이다 |
| 2 | 03-01 | `TW_CDN_VERSION=3.4.17` | ✓ VERIFIED | EVIDENCE:13. base1 `report.json`의 요청 URL에 `https://cdn.tailwindcss.com/3.4.17`이 있다 |
| 3 | 03-01 | 기준 출력이 production·`--safe` 빌드이고, 200·제목이 맞으며, 세 법적 HTML에 Tailwind script가 하나씩 있다 | ✓ VERIFIED | 검증자의 BASE 재빌드에서 세 법적 출력에 CDN이 있다(3개 파일). base1 report 18행 모두 `cdnInHtml` true |
| 4 | 03-01 | base1·base2 자기 차이 0이고 hover·focus 24장이 기본 캡처와 다르다 | ✓ VERIFIED | `diff.mjs base1 base2`는 `PASS 0 diffs`, `states.mjs base2`는 24 ok(재계산) |
| 5 | 03-01 | 한 픽셀 바꾼 사본에 `JUDGE neg FAIL` | ✓ VERIFIED | 저장된 `judge-neg.out`의 마지막 줄이 `JUDGE neg FAIL`이다. diff.mjs 원문은 허용 오차 0인 픽셀 비교다 |
| 6 | 03-02 | legal.css가 0열 include로 인라인되고, 토큰 다섯 개는 `:root` 한 곳에만 있으며, common.css·index.html은 기준과 같다 | ✓ VERIFIED | `_layouts/legal.html:18` `{% include css/legal.css %}`(0열). `legal.css:5` `:root` 한 줄. `git diff --quiet BASE HEAD -- index.html _includes/css/common.css …`가 0이다 |
| 7 | 03-02 | 커밋 ①이 판정을 통과했다(픽셀 0, hover·focus, 링크·높이) | ✓ VERIFIED | 7cd2b61은 `legal.css`·`legal.html`만 바꾼다. c1 재계산 결과 diff 0·states 24·report PASS |
| 8 | 03-02 | 커밋 ① 빌드의 랜딩이 바이트가 같고 파일 목록이 같다 | ✓ VERIFIED | 7cd2b61은 index.html·common.css를 건드리지 않는다. HEAD 빌드 기준으로도 `cmp` 랜딩이 같고 파일 목록이 같다 |
| 9 | 03-02 | legal.css 맨 위 주석에 허용 요소 목록과 figure 감싸개 규칙이 있다 | ✓ VERIFIED | `legal.css:1-4` |
| 10 | 03-02 | `.rp-doc` 범위 본문 규칙이 D-02~D-12를 담는다 | ✓ VERIFIED | `legal.css:15-39`: 32/12/4px, footer·aside, strong·a, 표 14px 가로줄, figure overflow-x와 그림자, decimal·circle·hangul·lower-alpha, h3 17px/700, dt 700 |
| 11 | 03-02 | ③ 미리보기가 base1과 픽셀 0이다 | ✓ VERIFIED | c1p 재계산: diff 0·states 24·report PASS |
| 12 | 03-03 | 세 문서 본문에 class가 0개이고 끝 안내가 클래스 없는 `<footer>`다 | ✓ VERIFIED | 원본 `grep -c class=` 0/0/0. 출력의 `.rp-doc` 안도 class 0개. 세 문서의 마지막 자식이 `<footer>` |
| 13 | 03-03 | 커밋 ② 빌드가 픽셀 0이다 | ✓ VERIFIED | c2 재계산: diff 0·states 24·report PASS |
| 14 | 03-03 | 본문 텍스트가 같다(렌더·원본) | ✓ VERIFIED | SC3 참고 |
| 15 | 03-03 | HTML 원본, section의 첫 자식 h2, 허용 요소만, 마지막은 footer | ✓ VERIFIED | 태그 집계는 section·h2·p·ul·li·a·strong·footer뿐이다(허용 목록 안). section 수와 h2 수가 같다(6/6, 11/11, 3/3) |
| 16 | 03-03 | noindex·「임시 게시본」·포인트 문장·front matter는 그대로다 | ✓ VERIFIED | 세 문서의 front matter 블록이 BASE와 HEAD에서 diff 0이다(noindex 포함). footer 문장이 그대로이고 텍스트 비교가 같다(SC3) |
| 17 | 03-04 | 커밋 ③ 뒤 레이아웃에 Tailwind가 없고, 출력에 0건이다 | ✓ VERIFIED | `_layouts/legal.html`에 script 0개. HEAD 빌드 grep 0 |
| 18 | 03-04 | 커밋 ③ 판정(픽셀 0, `--no-cdn` PASS) | ✓ VERIFIED | c3 재계산: diff 0·states 24·`report.mjs base1 c3 --no-cdn` → `PASS 18 rows` |
| 19 | 03-04 | 커밋 ③ 빌드의 랜딩이 바이트가 같다 | ✓ VERIFIED | c49e12a는 `_layouts/legal.html`만 바꾼다. HEAD 빌드 랜딩 `cmp` 같음 |
| 20 | 03-04 | check-site 5번 항목이 있고, ③ 이후 통과·② 실패이며, 별도 커밋이다 | ✓ VERIFIED | `scripts/check-site.sh:86-89`. HEAD 통과(rc 0), 31327b6 실패(rc 1, Tailwind 메시지). 69f4694는 check-site.sh만 바꾸고 c49e12a 뒤에 있다 |
| 21 | 03-04 | pre-push가 그대로이고 훅 경로로 새 점검이 돈다 | ✓ VERIFIED | `.githooks`는 BASE 대비 diff 0. `core.hooksPath=.githooks`. 훅에 흉내 낸 stdin을 넣었더니 31327b6는 rc 1, HEAD는 rc 0 |
| 22 | 03-05 | 시험 본문 `sample.mjs` PASS(두 엔진 × 세 폭) | ✓ VERIFIED | SC4 참고(`samplenw.out` PASS, 빌드 CSS = HEAD) |
| 23 | 03-05 | 사용자가 시험 본문을 승인했고 `TABLE_WRAP`을 골랐으며, 푸시 후보보다 먼저 정했다 | ? UNCERTAIN | 기록(EVIDENCE:450-451)과 순서(fb6bdfa → 2ebeca0)는 확인된다. 승인 행위 자체는 사람 확인 항목이다 |
| 24 | 03-05 | nowrap 별도 커밋, 픽셀 0, 시험 본문 PASS | ✓ VERIFIED | fb6bdfa는 `legal.css`만 바꾼다(`.rp-doc th`에 `white-space: nowrap`). nw 재계산: diff 0·states 24·`report --no-cdn` PASS |
| 25 | 03-05 | 시험 본문을 커밋하지 않았다 | ✓ VERIFIED | `git ls-files`에 sample·playwright·pngjs·judge 0건 |
| 26 | 03-06 | 사이트 푸시는 사람 승인 뒤에만 했고, 범위는 여섯 파일뿐이다 | ? UNCERTAIN | 범위 `9f715c7..2ebeca0`의 `.planning/` 밖 파일은 정확히 여섯 개로 확인된다. 승인 행위는 사람 확인 항목이다 |
| 27 | 03-06 | 후보가 훅·5항목을 통과했고, 사이트 트리가 마지막 판정 커밋과 같다 | ✓ VERIFIED | `git diff --quiet fb6bdfa 2ebeca0 -- . ':!.planning'`가 0이다. 같은 사이트 트리(HEAD)로 훅 통과 |
| 28 | 03-06 | Pages 빌드 built, 라이브 200·제목, Tailwind 0, 껍데기 클래스 있음 | ✓ VERIFIED | `gh api …/pages/builds/latest` 결과 `built 3f148e83d849 err=none`(최신). 라이브 세 URL 200·기대 제목·tw=0·`rp-legal-card` 있음 |
| 29 | 03-06 | 라이브 캡처가 base1과 픽셀 0이고 Tailwind 0이다 | ✓ VERIFIED | live 재계산: diff 0·states 24·`report --no-cdn` PASS. 라이브 HTML = HEAD 빌드 바이트 같음 |
| 30 | 03-07 | 원본 맵 일곱 개에 지금 쓰는 것처럼 적힌 Tailwind 흔적이 없고 정적 CSS를 설명한다 | ✓ VERIFIED | `.planning/codebase/*.md`에서 `cdn.tailwindcss\|tailwind-config\|tailwind.config` 0줄. `_includes/css/legal.css` 설명이 있다 |
| 31 | 03-07 | CONVENTIONS에 법적 본문 작성 규칙 D-01~D-12와 D-25가 있다 | ✓ VERIFIED | CONVENTIONS 「법적 본문 작성 규칙」 절(D-01~D-12, `figure tabindex="0"`) |
| 32 | 03-07 | 점검 항목 「다섯」, 860/768 설명, TESTING 「다섯 가지」 | ✓ VERIFIED | CONVENTIONS:49, TESTING:12, CONVENTIONS 반응형 절 |
| 33 | 03-07 | 생성기 시험에서 블록 밖은 그대로이고 legal.css가 들어간다 | ✓ VERIFIED | 03-08 재생성 비교로 갈음(아래 #37) |
| 34 | 03-08 | 두 CLAUDE.md의 방침 구간이 글자까지 같고, Jekyll 행이 「Phase 3까지 적용됨」이며, 같은 커밋에서 고쳤다 | ✓ VERIFIED | 「이번 마일스톤 방침」~「마지막 규칙…」 구간 diff가 비어 있다(POLICY_IDENTICAL). 19dbbe7이 두 파일을 함께 바꾼다 |
| 35 | 03-08 | 루트 CLAUDE.md가 정적 CSS를 설명한다(위치·토큰·Preflight·껍데기·768px, Deploy 점검에 Tailwind 없음) | ✓ VERIFIED | 루트 CLAUDE.md Architecture·Deploy 절 |
| 36 | 03-08 | 루트 CLAUDE.md에 법적 본문 작성 규칙이 있다 | ✓ VERIFIED | 「법적 본문 작성 규칙」 목록, `figure tabindex="0"` 1건 |
| 37 | 03-08 | `.claude/CLAUDE.md`가 재생성 결과와 바이트가 같다 | ✓ VERIFIED | HEAD를 스크래치에 `git archive`로 풀고 `generate-claude-md`를 돌린 결과가 저장소 사본과 `cmp` 같다 |
| 38 | 03-08 | 문서 전체에 Tailwind 흔적이 없고 다섯 항목이며 README 주석에 Tailwind 없음이 있다 | ✓ VERIFIED | CLAUDE.md·.claude/CLAUDE.md·README.md·codebase grep 0줄. README:10 「Tailwind 없음」 |
| 39 | 03-09 | 문서 푸시 후보는 LIVE_SITE 뒤에 만들었고, 사람 승인 뒤 푸시했으며, 범위는 세 파일뿐이다 | ? UNCERTAIN | 범위 `2ebeca0..3f148e8`의 `.planning/` 밖 파일은 정확히 `.claude/CLAUDE.md`·`CLAUDE.md`·`README.md`다. 승인 행위는 사람 확인 항목이다 |
| 40 | 03-09 | 문서 푸시 뒤 built, 200·제목·Tailwind 0, `/CLAUDE.md`·`/README.md` 404 | ✓ VERIFIED | 최신 Pages 빌드 `built 3f148e83d849`. 검증자가 직접 요청한 결과 `/CLAUDE.md` 404, `/README.md` 404(「Page not found」)였다. 일시 503 건은 아래 참고 |
| 41 | 03-09 | EVIDENCE에 SC1~4 판정표가 있고 범위 밖 항목을 숨기지 않았다 | ✓ VERIFIED | EVIDENCE 「Phase 3 성공 기준 판정」 표와 「판정 범위 밖」 6항목, `PHASE3_SC=OK` |
| 42 | 03-09 | 단계를 마친 뒤 라이브 세 URL이 200·기대 제목·Tailwind 0이다 | ✓ VERIFIED | 검증 시점(2026-11-16) 직접 요청한 결과 |

**Score:** 43/46 truths verified (0 present-but-behavior-unverified, 3 UNCERTAIN: 사람 승인 사실)

> 참고 — 03-09의 일시 503: 문서 푸시 직후 `/CLAUDE.md`·`/README.md`가 CDN 가장자리 503을 돌려준 일이 있었다. 이 일은 사용자가 승인한 예외(D-23 되돌리기 규칙에서 벗어남)로 EVIDENCE 「03-09 503 판정과 사용자 결정」에 기록돼 있다. 검증 시점의 직접 요청은 두 경로 모두 404였으므로, truth #40은 문구 그대로 성립하고 override가 필요 없다.

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `_includes/css/legal.css` | 토큰 `:root`, Preflight 대체, `rp-legal-*`, `.rp-doc` 본문 규칙, 주석 | ✓ VERIFIED | 39줄. `verify.artifacts` 통과. 레이아웃에서 include됨(WIRED) |
| `_layouts/legal.html` | legal.css include, 껍데기 클래스, Tailwind 없음 | ✓ VERIFIED | script 0개, `rp-legal-card`·`rp-doc` 있음. 세 법적 문서가 `layout: legal`로 사용 |
| `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html` | 클래스 없는 본문, 끝 `<footer>` | ✓ VERIFIED | class 0, footer 1 |
| `scripts/check-site.sh` | 5번 항목 | ✓ VERIFIED | 실행 결과 확인(통과/음성 대조 실패) |
| `.planning/phases/03-tailwind-cdn-removal/03-EVIDENCE.md` | 표식(BASE_SHA … PHASE3_SC=OK) | ✓ VERIFIED | 모든 표식이 있다. 기록한 SHA 13개는 `verify.commits` all_valid |
| `.planning/codebase/{STACK,CONVENTIONS,ARCHITECTURE,TESTING}.md` | 정적 CSS 설명, 작성 규칙, 다섯 항목 | ✓ VERIFIED | `verify.artifacts` 4/4 |
| `CLAUDE.md`, `.claude/CLAUDE.md`, `README.md` | 방침 행, 작성 규칙, Tailwind 없음 | ✓ VERIFIED | `verify.artifacts` 3/3 |

`verify.artifacts`는 9개 계획 모두 exit 0이다(합계 19/19).

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `03-EVIDENCE.md` | `_layouts/legal.html` | `^BASE_SHA=[0-9a-f]{12}$` | ✓ WIRED (수동) | 도구는 0/1이다(줄 앵커 `^…$`를 여러 줄 모드로 처리하지 않는 도구 한계). `grep -nE`로 EVIDENCE:11에서 일치함을 확인했다 |
| `_layouts/legal.html` | `_includes/css/legal.css` | `^\{% include css/legal\.css %\}$` | ✓ WIRED (수동) | 도구 false negative(같은 원인). `_layouts/legal.html:18`에서 일치. 빌드 출력에 legal.css 규칙이 인라인됨 |
| `_includes/css/legal.css` | `_layouts/legal.html` | `class="rp-doc"` | ✓ WIRED | 도구 통과 |
| `terms/index.html` | `_includes/css/legal.css` | `^\s*<footer>$` | ✓ WIRED (수동) | 도구 false negative. `terms/index.html:79`에서 일치 |
| `.githooks/pre-push` | `scripts/check-site.sh` | `check-site\.sh` | ✓ WIRED | 도구 통과. 흉내 낸 stdin으로 훅을 실행해 동작까지 확인 |
| `.planning/codebase/CONVENTIONS.md` | `.claude/CLAUDE.md` | 생성기 | ✓ WIRED | 재생성 결과가 바이트 같음 |
| `CLAUDE.md` | `.claude/CLAUDE.md` | 방침 구간 | ✓ WIRED | 구간 diff 없음 |

### Data-Flow Trace (Level 4)

해당 없음(정적 사이트, 동적 데이터 없음). 대신 원본 → 빌드 → 라이브의 흐름을 확인했다. 원본 HEAD를 production·`--safe`로 빌드한 출력이 nw 캡처의 빌드, 라이브 응답과 바이트가 같다.

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| HEAD가 5항목 점검을 통과한다 | `scripts/check-site.sh HEAD` | `통과 (커밋 aea9a954106d, jekyll 3.10.0)` | ✓ PASS |
| 5번 항목이 Tailwind 재유입을 잡는다 | `scripts/check-site.sh 31327b684f43` | rc 1, 세 문서에 Tailwind 있음 | ✓ PASS (음성 대조) |
| pre-push 훅이 main 푸시를 막고/통과시킨다 | `echo "refs/heads/main <sha> refs/heads/main 0…0" \| .githooks/pre-push` | C2 rc 1, HEAD rc 0 | ✓ PASS |
| 랜딩·파일 목록 불변 | BASE·HEAD 빌드 `cmp`·`find` diff | LANDING_SAME, FILELIST_SAME | ✓ PASS |
| 본문 텍스트 불변 | `<article>` 태그를 지운 텍스트 비교 | 3/3 같음 | ✓ PASS |
| 라이브 = 로컬 빌드 | `curl` 응답 vs HEAD 빌드 `cmp` | 법적 3 + 랜딩 모두 같음 | ✓ PASS |
| 픽셀 0 재계산 | `node diff.mjs/states.mjs/report.mjs` (base1 vs 7벌) | 모두 PASS | ✓ PASS |
| 새 캡처 | `node capture.mjs` (HEAD 빌드) | `ERR_MODULE_NOT_FOUND`: 스크래치 패키지 파일 소실 | ? SKIP (설치하지 않음) |

### Probe Execution

해당 없음. `scripts/*/tests/probe-*.sh`가 없고 계획에도 probe 선언이 없다. 영구 점검 `scripts/check-site.sh`는 위에서 직접 실행했다.

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| SHELL-04 | 03-01 ~ 03-09 (모두) | 방문자는 외부 스크립트(Tailwind Play CDN) 없이 정적 CSS만으로 법적 페이지를 보고, 모양은 전환 전과 같다 (375·768·1280px) | ✓ SATISFIED | SC1·SC2·SC3 |

REQUIREMENTS.md에서 Phase 3에 묶인 ID는 SHELL-04 하나다. 고아 요구사항은 없다.

### 금지 사항(Prohibitions) — 모두 judgment 등급, 검증자 판정은 비권위

**unverified-prohibition — human review recommended** (33건). 아래 판정은 LLM 검증자의 비권위 판정이고, 항목마다 사람이 해소해야 한다. 표는 계획 간 같은 문구를 한 행으로 묶었다.

| Plan | 금지 사항 (요약) | 검증자 판정(비권위) | 근거 |
|------|------------------|----------------------|------|
| 03-01 | 기준 캡처 전에 사이트 파일 수정 | 지켜짐 | 2ae417d(기록)가 7cd2b61의 조상이다 |
| 03-01 | 자기 차이가 0이 아닐 때 허용 오차를 임의로 정함 | 지켜짐 | base2 diff 0, diff.mjs 허용 오차 0 |
| 03-01 | 검증 도구를 저장소에 둠·커밋 | 지켜짐 | `git ls-files` 0건 |
| 03-01 | 승인 전 설치·다른 버전 설치 | 버전은 지켜짐(1.59.1·7.0.0). 승인은 사람 확인 | `package.json` 고정 버전 |
| 03-02 | 토큰·초기화를 common.css에 넣음 | 지켜짐 | common.css가 BASE와 같다 |
| 03-02 | 범위 없는 본문 요소 선택자 | 지켜짐 | 범위 없는 것은 `html`·`body`·`main`(레이아웃 규칙, 문서화됨)뿐 |
| 03-02 | 표를 블록 상자로 | 지켜짐 | `display: block` 0, 시험 `figDisplay: table` |
| 03-02 | 외부 CSS·Tailwind CLI | 지켜짐 | include 인라인, 외부 css는 기존 Pretendard뿐 |
| 03-02 / 03-04 | 판정 실패 상태를 커밋 | 지켜짐 | c1·c2·c3·nw 모두 재계산 PASS |
| 03-03 | 문장 변경·Phase 4~8 몫 삭제 | 지켜짐 | 텍스트 같음, noindex·footer 문장 남음 |
| 03-03 | Markdown 전환 | 지켜짐 | `.html` 원본 유지 |
| 03-03 | 시각·내용 변경 섞음 | 지켜짐 | 31327b6은 세 문서 마크업만, 텍스트 같음 |
| 03-04 | 5번 항목을 ③ 앞이나 같은 커밋에 | 지켜짐 | 69f4694는 c49e12a 뒤, 단독 |
| 03-04 | 다른 외부 CSS·스크립트 들임 | 지켜짐 | 법적 출력 script 0 |
| 03-05 | 시험 본문 커밋·공개 | 지켜짐 | ls-files 0. 라이브 `/sample/` 요청 결과 404. 빌드 파일 목록이 BASE와 같다 |
| 03-05 | 승인 없는 새 모양·새 색 | 새 색 없음(토큰과 기존 hex·ink 투명도). 승인은 사람 확인 | legal.css |
| 03-05 | 줄바꿈 변경 섞음·픽셀 재확인 없이 커밋 | 지켜짐 | fb6bdfa 단독, nw PASS |
| 03-06 / 03-09 | 승인 없이·다른 SHA 푸시 | SHA·범위는 일치. 승인은 사람 확인 | 원격 main = 3f148e8 |
| 03-06 / 03-09 | force push·이력 수정 | 지켜짐(관찰 범위) | `git reflog show origin/main`이 모두 `update by push`이고, 9f715c7 → 2ebeca0 → 3f148e8가 조상 사슬(fast-forward)이다. 범위 안 merge 커밋 0. 로컬 되돌림 2개는 푸시 전에 `reset --keep`으로 제거 |
| 03-06 / 03-09 | `--no-verify` | 확인 불가 → 사람 확인 | 훅 동작은 확인했지만 실제 사용 여부는 기록뿐 |
| 03-06 | 문서 커밋을 사이트 푸시에 실음 | 지켜짐 | 사이트 푸시 범위에 CLAUDE.md·README 없음 |
| 03-07 | 실제와 다른 구조 기술 | 지켜짐(표본) | 검증자가 표본 줄 번호를 직접 확인: `legal.html:18`(legal.css include), `legal.css:5`(`:root` 토큰), `legal.css:9`(`.rp-grid`) |
| 03-07 | PROJECT.md 수정 | 지켜짐 | 단계 범위 git log 0건 |
| 03-07 / 03-08 | 이메일·사업자 값·로컬 경로 추가 | 지켜짐 | 추가된 줄에서 로컬 홈·임시 경로와 이메일 형태 0건 |
| 03-08 | 생성 구간 손 편집 | 지켜짐 | 재생성 결과와 바이트 같음 |
| 03-08 | 방침 구간을 한쪽만·다른 커밋에서 | 지켜짐 | 19dbbe7 두 파일, 구간 같음 |
| 03-08 | 다른 방침 행 변경 | 지켜짐 | `git diff -U0 BASE HEAD -- CLAUDE.md`에서 바뀐 표 행은 「Jekyll 빌드 전환」 한 줄(-1/+1)뿐이다 |
| 03-09 | 판정표에서 범위 밖 숨김·ROADMAP 문구 수정 | 지켜짐 | 판정표 6항목 공개, ROADMAP 성공 기준 문구가 그대로 |

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `scripts/check-site.sh` | 41 | `XXXXXX` | ℹ️ Info (오탐) | `mktemp` 템플릿이다. 부채 표식이 아니다 |
| `_includes/css/legal.css` | 전체 | rem → px (코드 리뷰 WR-01, open) | ⚠️ Warning | 기본 글꼴 크기를 바꾼 사용자에게서 전환 전과 달라진다. 성공 기준 문구(기본 설정 × 세 폭)는 충족한다. 사람 결정 항목 |
| `scripts/check-site.sh` | 86-89 | 5번 항목이 `@tailwindcss/browser`·`text/tailwindcss`(v4)를 못 잡음 (WR-02, open) | ⚠️ Warning | 재유입 차단 범위가 v3 Play CDN 주소로 한정된다. 현재 출력에는 영향 없음 |
| `scripts/check-site.sh` | 4·5번 | grep 오류가 일치 없음과 구분되지 않음 (IN-04, open) | ℹ️ Info | fail-open 가능성 |
| `_includes/css/legal.css` | 27 | `ol:lang(en)`은 현재 `lang="ko"` 고정이라 걸리지 않음 (IN-02) | ℹ️ Info | Phase 9 영문판 전까지는 효과 없음(의도된 선행 규칙) |

부채 표식(TBD·FIXME·XXX, 위 오탐 제외)은 0건이다. 차단(blocker) 안티패턴은 없다.

### Human Verification Required

1. **실제 Safari·iOS Safari 시각 확인**: 세 법적 문서가 Playwright WebKit 캡처와 같은 모양인지 본다.
2. **다른 폭·고배율**: 320·414·1024·1440px, DPR 2·3에서 카드가 깨지지 않고 가로 스크롤이 없는지 본다.
3. **화면 낭독기**: 표가 표로 읽히고 figure의 `aria-label`이 발화되는지 본다.
4. **D-08 스크롤 끝 그림자**: 넓은 표를 끝까지 밀면 그쪽 그림자가 사라지는지 본다.
5. **D-07 실제 Safari 키보드 도달**: Tab으로 표 감싸개 figure에 닿는지 본다.
6. **WR-01 판단**: 브라우저 기본 글꼴 크기를 바꿨을 때 px 고정을 받아들일지 정한다(받아들이면 리뷰 disposition을 `skipped`나 `deferred`로, 아니면 후속 수정).
7. **사람 승인 사실 확인**: 다음 항목이 EVIDENCE 기록대로인지 확인한다(truth #23·#26·#39).
   - Playwright 설치 승인
   - SC4 승인과 `TABLE_WRAP=nowrap` 선택
   - 사이트 푸시 2ebeca06ca51 승인
   - 문서 푸시 3f148e83d849 승인
   - `--no-verify`를 쓰지 않음
8. **금지 사항 표 해소**: 위 judgment 등급 금지 사항의 비권위 판정을 사람이 확인한다.

### Gaps Summary

차단 결함(gap)은 없다. 단계 목표의 두 축은 코드·빌드·라이브 수준에서 성립한다.

- 첫째 축: 외부 스크립트 없이 같은 모양이다. 법적 출력에서 Tailwind는 0이다. 기준 대비 픽셀 0을 다시 계산했고, 텍스트도 같다.
- 둘째 축: 이후 단계는 클래스 없는 본문에 글만 쓰면 된다. 본문의 class는 0개이고, `.rp-doc` 범위 규칙이 있으며, 시험 본문이 PASS다. 작성 규칙은 CONVENTIONS와 두 CLAUDE.md에 있다.

남은 것은 모두 사람 확인 항목이다. 판정 범위 밖 환경, 기록으로만 증명되는 사람 승인, judgment 등급 금지 사항이 그렇다. 열린 리뷰 경고 WR-01·WR-02는 목표 문구를 깨지 않지만 사람 결정이 필요하다.

검증자의 독립 확인에는 한계가 하나 있다. 시각 비교(SC2)는 실행자가 저장한 캡처를 검증자가 다시 계산한 것이다. 새 캡처는 스크래치 Playwright 파일이 지워져 있어 찍지 못했고, 승인 없이 패키지를 새로 설치하지 않았다. 다만 출처 연결(nw 트리 = fb6bdfa 트리, nw 빌드 = HEAD 빌드 = 라이브 HTML)로 그 캡처가 지금 배포된 출력이라는 것은 확인했다.

---

_Verified: 2026-11-16T19:03:42Z_
_Verifier: Claude (gsd-verifier)_
