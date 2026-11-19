---
phase: 05-business-info-support-contact
verified: 2026-11-19T19:44:59Z
status: passed
score: 68/75 must-haves verified
covered_files:
  - ".claude/CLAUDE.md"
  - ".githooks/pre-push"
  - ".planning/baseline/NAMES.md"
  - ".planning/codebase/ARCHITECTURE.md"
  - ".planning/codebase/CONCERNS.md"
  - ".planning/codebase/CONVENTIONS.md"
  - ".planning/codebase/STACK.md"
  - ".planning/codebase/STRUCTURE.md"
  - ".planning/codebase/TESTING.md"
  - ".planning/phases/05-business-info-support-contact/05-01-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-01-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-02-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-02-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-03-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-03-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-04-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-04-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-05-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-05-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-06-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-06-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-07-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-07-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-08-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-08-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-09-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-09-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-10-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-10-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-11-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-11-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-12-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-12-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-13-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-13-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-14-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-14-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-15-PLAN.md"
  - ".planning/phases/05-business-info-support-contact/05-15-SUMMARY.md"
  - ".planning/phases/05-business-info-support-contact/05-CONTEXT.md"
  - ".planning/phases/05-business-info-support-contact/05-EVIDENCE.md"
  - ".planning/phases/05-business-info-support-contact/05-REVIEW-DISPOSITION.md"
  - ".planning/phases/05-business-info-support-contact/05-REVIEW.md"
  - ".planning/phases/05-business-info-support-contact/05-SECURITY.md"
  - ".planning/phases/05-business-info-support-contact/05-UI-REVIEW.md"
  - ".planning/phases/05-business-info-support-contact/05-VALIDATION.md"
  - "CLAUDE.md"
  - "README.md"
  - "_data/company.yml"
  - "_includes/css/common.css"
  - "_includes/footer.html"
  - "_includes/header.html"
  - "_layouts/legal.html"
  - "scripts/check-site.sh"
  - "support/index.html"
covered_digest: "v4:sha256:4702eb7e46fcf0397bea1826ac95b2139ecb7ebc246321e07c2f8ce27640caeb"
behavior_unverified: 0
overrides_applied: 0
deferred:
  - truth: "BIZ-02 나머지: 운영자가 `_data` 한 곳만 고치면 삭제 안내·처리방침·위치약관에도 사업자 정보·연락처가 반영된다"
    addressed_in: "Phase 6, Phase 7, Phase 8 (문서 자체). 단 `_data` 출처 조건은 어느 뒤 단계의 성공 기준에도 없음 (human_verification 9번에서 결정 요청)"
    evidence: "Phase 6 SC1 「지원 이메일로 계정·데이터 삭제를 요청하는 방법」, Phase 7 SC4 「개인정보 보호책임자와 연락처」, Phase 8 SC2 「위치약관이 … 사업자 상호·주소·연락처 … 를 담고」"
  - truth: "BIZ-03 나머지: 전화번호를 넣으면 보호책임자·위치약관에도 바로 나타난다"
    addressed_in: "Phase 7, Phase 8 (문서 자체). 전화 칸 연결 조건은 뒤 단계 성공 기준에 없음 (human_verification 9번)"
    evidence: "Phase 7 SC4 「개인정보 보호책임자와 연락처」, Phase 8 SC2 「사업자 상호·주소·연락처」"
  - truth: "지원 FAQ의 계정 삭제 경로(「설정 → 내 계정 → 회원탈퇴」)와 라이브 `/data-deletion/`(임시 게시본, 「설정 → 계정 삭제」)가 서로 다르다 (경고, Phase 5 공백 아님)"
    addressed_in: "Phase 6"
    evidence: "Phase 6 SC3 「앱 안 삭제 경로가 실제 메뉴 이름 「회원탈퇴」로 안내되고」(DEL-04). 05-CONTEXT.md D-16 참고가 이 차이를 Phase 6 입력으로 넘김"
human_verification:
  - test: "[insufficient_spec, 05-05 truth 5 / SC3 일부 / BIZ-01] 라이브 https://runningpencil.com/ 푸터의 상호·대표자·사업자등록번호·주소 네 줄을 사업자등록증 원본과 글자 단위로 대조한다 (띄어쓰기·괄호·「주식회사」 위치 포함)"
    expected: "네 값이 사업자등록증과 글자까지 같다. 다르면 `_data/company.yml` 한 파일만 고쳐 다시 푸시한다"
    why_human: "backstop 등급 truth다. 원본 증서는 사용자에게만 있고 값을 `.planning`에 남길 수 없어(D-02) 검증자가 직접 대조할 수 없다. 기록 근거는 05-05 checkpoint의 `USER_MATCH=OK`·`D10_APPROVED=OK`(사용자 보고)뿐이다"
  - test: "[insufficient_spec, 05-09 truth 4·05-14 truth 3 / SC2 일부 / SITE-03] Search Console에서 `runningpencil.com` 도메인 속성을 연다"
    expected: "속성 유형이 도메인 속성이고 소유권 상태가 「확인됨」이다"
    why_human: "backstop 등급 truth다. 검증자가 직접 본 것은 권한 있는 네임서버의 `google-site-verification` TXT 1줄까지다. 「확인됨」 표시는 사용자 계정 안에서만 보인다 (기록 근거 `SC_VERIFIED=OK`, `SC_DATE=2026-11-19`, 사용자 보고)"
  - test: "[insufficient_spec, 05-10 truth 2 / SC1 전제 / SUP-02] Gmail·네이버·iCloud·Outlook 계정 가운데 하나 이상(가능하면 iCloud·Outlook)에서 지원 주소로 시험 메일을 한 통 더 보낸다"
    expected: "운영자 업무 메일 받은편지함에 도착한다. 참고: 기록된 4/4는 1차 시험에서 iCloud·Outlook 두 통이 스팸함에 들어간 뒤, 운영자 Gmail에 「받는 사람이 지원 주소 → 스팸함으로 보내지 않음」 필터(저장소 밖 운영 설정)를 만들고 다시 보낸 결과다. 이 필터가 지워지면 같은 분류가 되돌아올 수 있고, 필터 때문에 실제 스팸도 받은편지함에 들어온다"
    why_human: "backstop 등급 truth다. 외부 메일 계정과 받은편지함은 저장소·라이브 HTML 밖이다. 검증자가 본 것은 MX가 Google 하나뿐이라는 DNS 사실까지다 (기록 근거 `RECEIVE_TEST=4/4`, 사용자가 넘긴 표)"
  - test: "[insufficient_spec, 05-14 truth 1] Gmail 작성 화면에서 From으로 지원 주소를 골라 외부 계정으로 한 통 보낸다"
    expected: "From 목록에 지원 주소가 있고, 받은 쪽에서 보낸 사람이 지원 주소로 보인다"
    why_human: "backstop 등급 truth다. 보내기 설정은 Google Workspace·Gmail 화면 안에만 있다 (기록 근거 `TASK5=OK`, 사용자 보고)"
  - test: "실기기 iPhone Safari에서 https://runningpencil.com/ 과 https://runningpencil.com/support/ 를 연다. 푸터 사업자 줄, 이메일 링크, 지원 페이지의 이메일 링크를 눌러 본다 (05-01·05-15 계획이 단계 끝 사람 확인으로 넘김)"
    expected: "푸터 항목이 중간에서 끊기지 않고(긴 항목 하나는 자기 상자 안에서만 줄을 바꿈) 가로로 밀리지 않는다. 지원 페이지 맨 위에 「러닝펜슬 고객 지원」, 그 아래 문의하기 → 공개 코스 신고 → 자주 묻는 질문 순서다. 이메일 링크를 누르면 메일 앱이 지원 주소로 열린다. 푸터 「고객 지원」 링크로 지원 페이지가 열린다"
    why_human: "Playwright WebKit 에뮬레이션(검증자가 라이브에서 다시 돌려 PASS)은 실기기 Safari의 글꼴 렌더링·mailto 처리·터치를 대신하지 못한다"
  - test: "VoiceOver(iOS 또는 macOS)로 https://runningpencil.com/support/ 와 아무 페이지의 푸터를 읽는다 (05-01·05-15 계획이 단계 끝 사람 확인으로 넘김)"
    expected: "h1 「러닝펜슬 고객 지원」, h2 세 개, FAQ의 질문(dt)·답(dd) 네 쌍이 차례로 읽힌다. 푸터 내비게이션 이름이 「약관 및 지원」이고 링크 네 개(개인정보처리방침·이용약관·데이터 삭제 안내·고객 지원)가 읽힌다. 사업자 항목이 「·」 구분과 함께 자연스럽게 읽힌다"
    why_human: "낭독 순서와 의미 전달은 실제 보조 기술로만 확인할 수 있다"
  - test: "05-EVIDENCE.md에 기록만 있는 과정 사실을 확인한다: (1) Playwright 1.59.1을 pnpm으로 스크래치에 설치하는 것을 checkpoint에서 승인함(05-01), (2) 05-05 D-10 checkpoint에서 로컬 빌드 푸터 글과 구분 기호 선택지 2(`&nbsp;· `)를 승인함, (3) 첫 푸시 `57e56b07f2ab`, 게이트 푸시 `2bd47891b837`, 문서 푸시 `e0f233169329`를 각각 SHA를 보고 승인함(05-06·05-12·05-15)"
    expected: "세 건 모두 기억·대화 기록대로였다고 확인한다. git·Pages로 볼 수 있는 부분(Phase 5 동안 Pages가 빌드한 커밋이 정확히 이 세 SHA이고 서로 조상 관계라 force push 흔적이 없음, 각 푸시의 사이트 파일 범위)은 검증자가 이미 확인했다"
    why_human: "사람의 승인은 저장소와 라이브에 흔적이 남지 않는다"
  - test: "아래 「금지 항목」 표의 비권위 판정 40건(judgment 등급, 모두 unverified-prohibition — human review recommended)을 훑는다"
    expected: "판정에 동의하거나, 동의하지 않는 항목을 gap으로 돌린다. 「기록 근거」로 표시한 항목은 7번 과정 사실과 함께 정한다"
    why_human: "judgment 등급의 금지 항목은 자동 판정이 권위를 갖지 않는다 (ADR-550 D4)"
  - test: "[결정 요청] BIZ-02·BIZ-03의 추적을 정한다. 두 요구사항의 문구는 삭제 안내·처리방침·보호책임자·위치약관까지 포함하지만, REQUIREMENTS.md 추적 표와 ROADMAP은 두 ID를 Phase 5에만 걸었다. Phase 6~8의 Requirements 줄에도 성공 기준에도 「`_data` 한 곳에서 읽음」이나 「전화 칸 연결」 조건이 없다"
    expected: "다음 가운데 하나를 고른다: (a) BIZ-02·BIZ-03을 Phase 6·7·8의 Requirements 줄에 더하고 각 단계 성공 기준에 「사업자 값·연락처는 `_data/company.yml`에서 읽고, 값이 없으면 그리지 않는다」 조건을 넣는다, (b) 요구사항을 「Phase 5 범위(푸터·지원 페이지)」와 「법적 문서 범위」로 나눈다, (c) 문구를 Phase 5 범위로 줄인다. 그 전까지 REQUIREMENTS.md의 BIZ-02·BIZ-03 체크는 하지 않는다"
    why_human: "요구사항 범위와 추적은 개발자가 정할 일이다. 검증자가 뒤 단계로 미루면(Step 9b) `_data` 출처 조건이 어느 단계에서도 검증되지 않은 채 남는다"
---

# Phase 5: 사업자 정보와 지원 연락 경로 (Business Info & Support Contact) 검증 보고서

**Phase Goal:** 심사자와 사용자가 모든 페이지에서 누가 러닝펜슬을 운영하는지 확인하고, `/support/`에서 실제로 받히는 지원 이메일로 연락할 수 있다. 이 단계가 끝나면 이메일 게이트가 열린다
**Verified:** 2026-11-19T19:44:59Z
**Status:** human_needed
**Re-verification:** 아니요. 이 단계의 첫 검증 보고서입니다 (이전 `05-VERIFICATION.md` 없음)

## 결론

코드와 라이브에서 직접 볼 수 있는 부분은 모두 목표대로입니다. 막는 공백(BLOCKER)은 없습니다.

- **라이브 = 원격 main 빌드.** 원격 main(`e0f233169329`)을 운영과 같은 production·`--safe` Jekyll 3.10.0으로 다시 빌드했습니다. 라이브 다섯 URL(`/`, `/privacy-policy/`, `/terms/`, `/data-deletion/`, `/support/`)은 모두 200·기대 제목이고, 캐시를 우회해 받은 응답이 이 빌드와 바이트가 같습니다.
- **사업자 정보.** 라이브 다섯 문서 푸터마다 「상호」「대표자」「사업자등록번호」 `<span>` 하나씩, 「주소」 줄 하나, 이메일 `mailto:` 줄 하나가 있습니다. 「전화」는 다섯 문서 어디에도 없습니다. 값은 `_data/company.yml` 한 곳에만 있고 템플릿은 `site.data.company.<키>.size > 0`으로 판정합니다.
- **이메일 게이트.** GitHub Pages 빌드 목록에서 Phase 5 동안 배포된 커밋은 `57e56b07f2ab`·`2bd47891b837`·`e0f233169329` 셋입니다.
  - 게이트 푸시보다 앞선 배포 커밋 18개(첫 푸시 포함)의 사이트 파일에 지원 주소가 0건입니다.
  - 지원 주소를 처음 더한 사이트 커밋은 G(`4ea25de`)이고, 게이트 기록 커밋 `9e3b9be`(`GATE_OPEN=OK`)가 G의 조상입니다.
- **지원 페이지.** 검증자가 Playwright를 다시 돌려 라이브에서 `PASS support`, `PASS foot`을 얻었습니다 (Chromium·WebKit × 375·1280).
  - 앵커는 `contact` → `report` → `faq` 순서이고, `mailto` 1개, FAQ `dl`·`dt` 각 4개입니다.
  - 네 문서에서 `/support/` 링크는 헤더·푸터 두 곳입니다.
- **DNS.** 권한 있는 네임서버와 공개 리졸버 모두에서 MX는 Google 하나, SPF는 1줄, `google-site-verification` TXT는 1줄입니다. A 레코드 4개와 `www` CNAME이 그대로이고 `/`·`/support/`가 HTTPS 200입니다.

상태가 `human_needed`인 이유는 세 가지입니다.

1. backstop 등급 truth 다섯 개가 사용자 보고로만 기록돼 있습니다. 사업자등록증 일치, Search Console 「확인됨」, 외부 4곳 수신, 보내기 설정이 그렇습니다. 그래서 `insufficient_spec`으로 판정을 보류했습니다.
2. 계획이 실기기 Safari와 화면 낭독기 확인을 단계 끝 사람 확인으로 넘겼습니다.
3. BIZ-02·BIZ-03의 추적에 개발자 결정이 필요합니다.

## Goal Achievement

### ROADMAP 성공 기준 (계약, `roadmap.get-phase 5`로 새로 읽음)

| # | Truth | Status | Evidence (이번 실행) |
|---|-------|--------|----------|
| SC1 | 외부 4곳 수신 시험 기록이 있고, 이 기록보다 앞선 어떤 배포에도 지원 이메일 주소가 나오지 않는다 | ✓ VERIFIED | 기록 `RECEIVE_TEST=4/4`·`GATE_OPEN=OK`가 `05-EVIDENCE.md`에 있음 (기록이 있다는 사실은 이 SC의 문구). `gh api …/pages/builds`의 배포 커밋 20개 가운데 `2bd47891b837` 앞의 18개(Phase 5 첫 푸시 `57e56b07f2ab` 포함)는 `git grep -F <주소> <커밋> -- . ':!.planning'`이 모두 0건. 주소를 처음 더한 사이트 커밋은 `4ea25de`(G, `_data/company.yml` 한 파일, numstat 1 1). 게이트 기록 커밋 `9e3b9be`(18:18 KST)가 G(18:34 KST)의 조상. 실제 도착 여부는 human 3번 |
| SC2 | dig에 MX·SPF(한 개)·Search Console TXT, Search Console 도메인 속성 「확인됨」, DNS 변경 뒤 HTTPS | ? UNCERTAIN | 직접 관찰: `dig @ns1.gabia.co.kr`과 `@1.1.1.1` 모두 `A=4 MX=1 mx_google=1 spf=1 gsv=1 dkim=0`, `www` CNAME `slimpumpkin.github.io.`. `curl -sI` `/`·`/support/` → `HTTP/2 200`. 「확인됨」 표시는 사용자 계정 안에서만 보임 → human 2번. 점수에 넣지 않음 |
| SC3 | 모든 페이지 푸터에 사업자등록증과 같은 표기의 상호·대표자·사업자등록번호·주소와 지원 이메일, 값이 없는 항목은 행 자체가 없음 | ? UNCERTAIN | 직접 관찰: 라이브 다섯 문서 푸터마다 라벨 넷과 `이메일 <a href="mailto:` 1개, 「전화」 0. 모든 값을 비운 스크래치 빌드에서 다섯 문서 모두 사업자 `span`·주소 줄·`mailto`·「전화」 0, 빈 `<p></p>` 0, 「추후 기재」 0. 「사업자등록증과 같은 표기」는 사용자만 대조 가능 → human 1번. 점수에 넣지 않음 |
| SC4 | `_data` 파일 하나만 고치면(전화 포함) 푸터와 지원 페이지에 바로 반영되고, 전화는 지금 어디에도 안 보임 | ✓ VERIFIED | 값 커밋 M4 `57e56b0`과 G `4ea25de`가 각각 `_data/company.yml` 한 파일. 스크래치 빌드에서 `phone`만 가짜 값으로 채우면 네 문서 푸터에 「전화」 1, 지원 페이지 2(푸터 + `#contact`). 원래 값에서는 라이브 다섯 문서 「전화」 0 |
| SC5 | `/support/` 맨 위에 「러닝펜슬」, 그 아래 이메일·응답 안내·신고 방법·FAQ(운영 주체, 위치 수집 시점, 계정 삭제, 공개 코스 신고), 헤더·푸터에서 지원 페이지로 감 | ✓ VERIFIED | 라이브 `/support/`: `<h1 class="rp-legal-title">러닝펜슬 고객 지원</h1>`, `#contact`에 `mailto:` 1개와 「영업일 기준 3일 안에 답장합니다」, `#report`에 적을 내용 네 가지, `#faq`의 dt 네 개(운영 주체·위치·계정 삭제·신고). 검증자 Playwright 재실행 `PASS support`(1280에서 `hdr=1 ftr=1`, 375에서 `hdr=0 ftr=1`은 860px 이하 헤더 nav 숨김 설계대로) |

### PLAN must-have truths

계획 15개의 truth는 71개입니다. 대부분은 특정 커밋이나 푸시에 대한 사실이라 뒤 커밋이 바꾸지 못합니다. 이런 truth는 git으로 다시 확인했습니다(「git」). 지금 상태에 대한 truth는 이번에 다시 돌렸습니다(「이번 실행」). 기록으로만 남은 판정은 「기록」으로 적었습니다.

| # | Plan | Truth (요약) | Status | Evidence |
|---|------|--------------|--------|----------|
| 1 | 05-01 | EVIDENCE 머리 규칙, `BASE_SHA`·`BASE_LIVE`, 두 커밋의 `.planning` 밖 트리가 같음 | ✓ VERIFIED | 이번 실행: 머리에 D-02·표식 줄 규칙. `git diff 2db88d9a199f 84a5d9114ef3 -- . ':!.planning'` 0줄 |
| 2 | 05-01 | 기준 빌드 4 URL 200·기대 제목, `/support/`·`mailto:`·「전화」·`/support/` 링크 0 | ✓ VERIFIED | 이번 실행: BASE 재빌드 문서 4개, `support/` 없음, mailto 0, 전화 0, 지원 링크 0. HTTP 200은 기록 |
| 3 | 05-01 | Playwright 1.59.1을 승인 뒤에만 pnpm으로 스크래치에 설치 | ✓ VERIFIED | git·파일: 스크래치 `pw/package.json` `"playwright": "1.59.1"`, `pnpm-lock.yaml` 있음, 저장소 추적 파일에 `.mjs`·`pw/` 0. 승인 자체는 human 7번 (1) |
| 4 | 05-01 | 기준에서 p5-foot `PASS foot`, p5-support `FAIL support`(음성 대조) | ✓ VERIFIED | 기록: EVIDENCE 71~86행 `/support/ 404` FAIL 네 줄. 같은 도구가 지금 라이브에서 PASS (이번 실행) |
| 5 | 05-02 | 빈 값 원형을 얹은 빌드가 네 문서 기준과 바이트 같고 `support/index.html`만 더해짐 | ✓ VERIFIED | 기록 `PROTO_EMPTY=OK`. 이번 실행: 같은 원형 blob인 M1 빌드가 BASE와 `diff -r` 빈 출력 |
| 6 | 05-02 | 빈 문자열·null·키 없음·파일 없음 네 경우 바이트 같음, 구분 기호 = 있는 항목 수 − 1 | ✓ VERIFIED | 기록 `PROTO_MATRIX=OK`. 이번 실행: 템플릿의 구분 기호가 앞 항목 존재 조건(`or`)에 묶여 있음, 라이브 `seps=2`(항목 셋) |
| 7 | 05-02 | 전화만 넣으면 「전화」 행 하나, 비우면 0 | ✓ VERIFIED | 이번 실행: 전화 가짜 값 빌드 네 문서 1, 빈 값 빌드 0 |
| 8 | 05-02 | 원형은 이메일이 없으면 `#faq`만, 있으면 contact→report→faq, FAQ `dl` = 2 + 상호 + 이메일 | ✓ VERIFIED | 이번 실행: 모두 빈 값 빌드 `#faq`만·`dl` 2. 원래 값(상호·이메일 있음) 라이브 `dl` 4 |
| 9 | 05-02 | `&`·`<`·`>`가 푸터·FAQ에서 이스케이프 | ✓ VERIFIED | 이번 실행: 푸터·지원 페이지의 값 출력이 모두 `| escape` (11곳). 기록 PROTO_MATRIX의 이스케이프 경우 |
| — | 05-02 (key link, 점수 밖) | `PROTO_SUPPORT_BLOB`이 05-08 H1 blob과 같음 | ✓ WIRED | git: `48f332e:support/index.html`과 cherry-pick된 `ebb6b1a:support/index.html` 모두 `3c561223f005…`로 표식 값과 같음 |
| 11 | 05-03 | M1은 두 파일만, 빌드가 기준과 `diff -r` 빈 출력 | ✓ VERIFIED | git: `bc934fb` = `_data/company.yml`·`_includes/footer.html`, 값 0개. 이번 실행: BASE·M1 빌드 `diff -r` 빈 출력 |
| 12 | 05-03 | M2는 `common.css` 두 줄, 출력 차이는 `57a58,59`·`47a48,49`뿐, 새 hex 없음 | ✓ VERIFIED | 이번 실행: M1→M2 diff가 index `57a58,59`, 법적 3종 `47a48,49`, 각 2줄. 더한 색 `#FAFAF7`은 기존 바탕색 |
| 13 | 05-03 | 가짜 값 M2 빌드 두 엔진 × 375·1280 끊김·넘침 없음, 링크 `#FAFAF7` 밑줄. M1은 링크 색으로 실패 | ✓ VERIFIED | 기록 `FOOT_LAYOUT=OK`, 음성 대조 FAIL 줄(EVIDENCE 258행 `badLink`). 이번 실행: 같은 판정을 실제 값 라이브에서 `PASS foot` (20줄) |
| 14 | 05-04 | check-site 7번 항목(지원 페이지 mailto, 링크→페이지, grep 오류는 실패) | ✓ VERIFIED | 이번 실행: `scripts/check-site.sh` 7번 구획 코드 확인, 작업 트리·`e0f2331` 통과 |
| 15 | 05-04 | 기준·M2·M3 통과, 음성 객체는 7번 하나만으로 실패, 양성 통과 | ✓ VERIFIED | 기록 `GUARD7=OK`. 이번 실행 음성 대조: H1 `48f332e`·H3 `5100b37`이 「지원 페이지에 연락처(mailto)가 없습니다」 하나로 「실패 — 1건」 |
| 16 | 05-04 | 실제 pre-push가 M3 통과·음성 거부 | ✓ VERIFIED | 기록 `HOOK7=OK`. `.githooks/pre-push`는 BASE→원격 main 변경 0 |
| 17 | 05-04 | M3는 `check-site.sh` 하나, 출력·훅 불변 | ✓ VERIFIED | git: `da94075` 한 파일 |
| 18 | 05-05 | 사업자 값은 사용자가 준 것만, 후보 `C4_CAND`에만, 이메일·전화 빈 값 | ✓ VERIFIED | git: `fef24cd83cfb`는 `refs/p5-scratch/c4-cand`에만 있음(원격 ref 0). 그 커밋과 M4의 `support_email`·`phone` 빈 값. 「사용자가 준 것만」은 human 1번 |
| 19 | 05-05 | 후보 빌드 일곱 항목 통과, 차이는 푸터 블록뿐, 라벨 넷·이메일/전화 행 없음 | ✓ VERIFIED | 기록. 이번 실행: M4(`57e56b0`)가 바꾼 파일이 `_data/company.yml` 하나(차이가 푸터 값 출력에만 생기는 구조) |
| 20 | 05-05 | 구분 기호 선택지 세 개 × 두 엔진 × 두 폭 캡처 12장 | ✓ VERIFIED | 이번 실행: 스크래치 `cap/d10o1~3`의 PNG 12장. 판정 통과는 기록 |
| 21 | 05-05 | 사용자가 D-10에서 대조·승인, 푸터 글은 `.planning`에 없음 | ✓ VERIFIED | 기록 `D10_APPROVED=OK`·`SEPARATOR=opt2`. 이번 실행: 대표자·사업자등록번호·주소 값이 `.planning`·CLAUDE.md·README·커밋 메시지 0건. 승인은 human 7번 (2) |
| 22 | 05-05 | (backstop) 푸터 사업자 표기 = 사업자등록증 | ⚠️ insufficient_spec | 사용자 보고 `USER_MATCH=OK`뿐 → human 1번 |
| 23 | 05-05 | `.planning`·커밋 메시지에 새 사업자 값 없음 | ✓ VERIFIED | 이번 실행: 위 21번과 같은 검사 0건. 상호는 Phase 5 전 공개 값이라 대상에서 뺌(기록 `excluded=1`과 같은 기준) |
| 24 | 05-06 | M4는 `_data/company.yml` 하나, 출력이 승인 선택지 빌드와 같음, 선택지 2라 S 커밋 없음 | ✓ VERIFIED | git: `57e56b0` 한 파일, `SEPARATOR=opt2`이고 템플릿이 `&nbsp;· `(선택지 2) |
| 25 | 05-06 | 첫 푸시 범위는 M1·M2·M3·M4, 사이트 파일 넷, `support/`·지원 링크·주소 없음 | ✓ VERIFIED | git: BASE..`57e56b0` 사이트 커밋 네 개. `57e56b0` 트리에 `support/` 0, `href="/support/`는 `check-site.sh`의 검사 문자열 하나뿐(출력 아님), 주소 0 |
| 26 | 05-06 | 승인 뒤 그 SHA 하나만 원격에, 범위에 값 없음 | ✓ VERIFIED | git·Pages: 빌드 목록의 다음 배포가 `57e56b07f2ab`(= `PUSH1_SHA`). 승인은 human 7번 (3) |
| 27 | 05-06 | 라이브 4 URL 200·바이트 같음, 사업자 행 있고 이메일·전화 없음 | ✓ VERIFIED | 기록 `LIVE_PUSH1=OK` (지금 라이브는 G 상태라 다시 볼 수 없음) |
| 28 | 05-06 | 라이브 p5-foot PASS | ✓ VERIFIED | 기록. 지금 라이브에서도 `PASS foot` (이번 실행) |
| 29 | 05-06 | 같은 커밋 재빌드 바이트 같음 | ✓ VERIFIED | 이번 실행: `e0f2331` 재빌드가 라이브와 다섯 문서 `cmp` 같음 |
| 30 | 05-07 | 원본 맵이 슬롯·푸터 줄·`.size > 0`·7번 항목을 지금 코드대로 적음, LIVE_PUSH1 뒤 커밋 | ✓ VERIFIED | 이번 실행: CONVENTIONS 「점검 항목은 일곱이다」 1줄. git: 05-07 문서 커밋이 `57e56b0` 뒤 |
| 31 | 05-07 | NAMES.md 「들어갈 곳」이 키 이름, 사업자 값 없음 | ✓ VERIFIED | 이번 실행: 16~22행이 `trade_name`…`phone` 키, 값 칸 「(빈칸)」 |
| 32 | 05-07 | 연구 문서 Pattern 1이 `.size > 0` | ✓ VERIFIED | 이번 실행: `.planning/research/ARCHITECTURE.md`의 `!= blank` 0, `.size > 0` 6 |
| 33 | 05-07 | 두 CLAUDE.md 방침 구간이 같고 「사업자 정보 표시」가 「Phase 5에서 적용됨」, 생성 구간은 재생성과 같음 | ✓ VERIFIED | 이번 실행: 두 방침 구간 `diff` 빈 출력. 저장소 밖 사본에서 `generate-claude-md`를 돌린 결과가 `.claude/CLAUDE.md`와 `cmp` 같음 |
| 34 | 05-07 | 열두 문서에 옛 문장·로컬 경로·사업자 값 없음 | ✓ VERIFIED | 기록 `DOCS1_STALE=OK`. 이번 실행: 값 0건 |
| 35 | 05-08 | 보류 세 커밋은 로컬 `p5-support-hold`에만, upstream·원격 없음, origin/main 조상 아님 | ✓ VERIFIED | 이번 실행: `git branch -vv`에 upstream 없음, `git branch -r --contains` 0, `merge-base --is-ancestor` 아님 |
| 36 | 05-08 | H1 blob = 원형, 세 커밋 모두 7번 하나만 실패 | ✓ VERIFIED | git: blob 같음. 이번 실행: H1·H3 「실패 — 1건」(7번). H2는 기록 `HOLD_ONLY7=OK` |
| 37 | 05-08 | H2 스크립트로 M4 점검 시 3번 「문서가 없습니다」로 실패 | ✓ VERIFIED | 이번 실행: 지금 스크립트(H2 줄 포함)로 `57e56b0` 점검 → 「문서가 없습니다: /support/index.html」, 「실패 — 1건」 |
| 38 | 05-08 | H3 가짜 이메일 빌드에서 링크 두 곳, contact→report→faq, mailto 1, dl·dt 4, 링크 보임, `#report` 앵커 | ✓ VERIFIED | 기록 `HOLD_UI=OK`. 같은 조건을 실제 값 라이브에서 `PASS support` (이번 실행) |
| 39 | 05-08 | 실제 값(이메일 빈 값) H1·H3 빌드는 `#faq`만, `dl` 3 | ✓ VERIFIED | 이번 실행: H3 `5100b37`을 빌드하면 지원 페이지가 `section id="faq"` 하나, `dl` 3, `mailto` 0. H1은 기록 |
| 40 | 05-09 | 「변경 전」은 CONTEXT D-01 관찰, 「변경 후」는 실행 시 직접 질의, 값 없이 개수만 | ✓ VERIFIED | 기록 `DNS_BEFORE`·`DNS_AFTER=OK`. 이번 실행: EVIDENCE에 TXT 토큰 꼴 0, IP는 공개 리졸버 `1.1.1.1`과 loopback뿐 |
| 41 | 05-09 | MX Google 하나, SPF 1줄, gsv ≥1, 기존 A 4·www·challenge 그대로 | ✓ VERIFIED | 이번 실행 dig: `A=4 MX=1 mx_google=1 spf=1 gsv=1`, `www` → `slimpumpkin.github.io.`. challenge TXT는 기록 `ghchallenge=1` |
| 42 | 05-09 | DNS 변경 뒤 HTTPS 200 | ✓ VERIFIED | 이번 실행 `HTTP/2 200` |
| 43 | 05-09 | (backstop) Search Console 「확인됨」이면 `SITE03=OK` | ⚠️ insufficient_spec | 사용자 보고 `SC_VERIFIED=OK`뿐 → human 2번 |
| — | 05-09 | 작업 7이 아직이면 `SC_PENDING=OK`만 남김 | N/A | 그 갈래가 일어나지 않음(`SC_PENDING` 0줄, 05-09에서 `SC_VERIFIED`). 점수에서 뺌 |
| 44 | 05-10 | 게이트 사전 점검 통과(원격 = 첫 푸시, 보류 세 커밋, H3 7번만, 시험 cherry-pick 같은 출력) | ✓ VERIFIED | 기록 `GATE_PREFLIGHT=OK`. 이번 실행: 시험 cherry-pick을 담은 ref 없음(`for-each-ref`는 `c4-cand` 하나), worktree는 메인 하나 |
| 45 | 05-10 | (backstop) 네 곳 시험 메일 모두 받은편지함 | ⚠️ insufficient_spec | 사용자 표 `RECEIVE_TEST=4/4`(필터 뒤 재시험) → human 3번 |
| 46 | 05-10 | 게이트 기록이 이메일 커밋보다 먼저 main에 | ✓ VERIFIED | git: `9e3b9be`가 `4ea25de`의 조상 |
| 47 | 05-10 | 기록에 보낸 사람 주소·본문·시각 없음 | ✓ VERIFIED | 이번 실행: EVIDENCE의 이메일 주소 꼴 0개 |
| 48 | 05-11 | H1~H3 cherry-pick(`git cherry` 모두 `-`), 출력이 H3 빌드와 같음 | ✓ VERIFIED | git: `ebb6b1a`·`00db937`·`0700159`. 기록 `PICK_SAME=OK`, `OK cherry all-in-main 3` |
| 49 | 05-11 | G0(`updated` 한 줄), G(`support_email` 한 줄), G에서 일곱 항목 통과 | ✓ VERIFIED | git: `3ee7700` numstat 1 0(`support/index.html`), `4ea25de` 1 1. 이번 실행: G와 같은 사이트 트리인 `e0f2331` check-site 통과 |
| 50 | 05-11 | G 빌드 다섯 문서 이메일 행, 「전화」 0, 지원 페이지 구조, 링크 두 곳 | ✓ VERIFIED | 이번 실행: 라이브(= G 출력) 다섯 문서 모두 그대로 |
| 51 | 05-11 | 주소가 첫 푸시 사이트 이력에 없고 처음 더한 커밋이 G, G는 게이트 기록 자손 | ✓ VERIFIED | 이번 실행: SC1 근거와 같음 |
| 52 | 05-11 | 두 엔진 × 375·1280 구조·링크·앵커·링크 색 통과 | ✓ VERIFIED | 이번 실행: 라이브 `PASS support`·`PASS foot` |
| 53 | 05-12 | 게이트 푸시 범위는 H1′·H2′·H3′·G0·G, 출력 = G 빌드, 주소 첫 커밋 G | ✓ VERIFIED | git: `57e56b0..2bd4789` 사이트 커밋 다섯(그 밖은 `.planning`과 05-07 문서 커밋 둘) |
| 54 | 05-12 | 승인 뒤 그 SHA 하나만 원격에 | ✓ VERIFIED | Pages: 다음 배포가 `2bd47891b837`. 승인은 human 7번 (3) |
| 55 | 05-12 | 라이브 다섯 URL 200·제목·바이트 같음, 이메일 행 | ✓ VERIFIED | 기록 `LIVE_PUSH2=OK`. 지금 라이브(사이트 출력 같음)에서 이번 실행으로 같은 결과 |
| 56 | 05-12 | 라이브 두 엔진 지원 페이지 구조·헤더·푸터·앵커·링크 색 | ✓ VERIFIED | 이번 실행 `PASS support`·`PASS foot` |
| 57 | 05-12 | 푸시 뒤 원격 이력에서 주소 첫 사이트 커밋 = G | ✓ VERIFIED | 이번 실행: `git log origin/main --reverse -S<주소> -- . ':!.planning'` 첫 줄 `4ea25de` |
| 58 | 05-13 | 원본 맵·이름 표가 지원 페이지·링크·이메일 공개·다섯 문서를 적음, LIVE_PUSH2 뒤 커밋 | ✓ VERIFIED | 기록 `DOCS_MAPS2_SHA`. git: 05-13 커밋이 `2bd4789` 뒤 |
| 59 | 05-13 | CONVENTIONS 앵커 규칙, `legal.css` 그대로 | ✓ VERIFIED | 이번 실행: 앵커 규칙 1줄, `legal.css` Phase 5 커밋 0 |
| 60 | 05-13 | 두 CLAUDE.md 같음, 「지원 이메일 공개」 적용됨, Pages 표 지원 행, 주소 없음, 생성 구간 같음 | ✓ VERIFIED | 이번 실행: 방침 구간 같음, 지원 행 1, 「Phase 5에서 적용됨」, 주소 0(두 CLAUDE.md·README·원본 맵), 재생성 `cmp` 같음 |
| 61 | 05-13 | 보류 worktree는 cherry 확인 뒤 지움, 브랜치 ref는 로컬에 남김 | ✓ VERIFIED | 이번 실행: `git worktree list`는 메인 하나, `p5-support-hold` 로컬에 있음(upstream·원격 없음) |
| 62 | 05-13 | 문서 열 개에 옛 문장·경로·값 없음 | ✓ VERIFIED | 기록 `DOCS2_STALE=OK`. 이번 실행: 주소 0, 사업자 값 0 |
| 63 | 05-14 | (backstop) 보내기 설정(작업 5) 끝남 | ⚠️ insufficient_spec | 사용자 보고 `TASK5=OK`뿐 → human 4번 |
| 64 | 05-14 | D-06 완료 표 일곱 행 충족 | ✓ VERIFIED | 기록: 표와 `PHASE5_RECORD=OK`, 각 근거 표식이 EVIDENCE에 있음(표식 존재는 이번 실행 grep). 외부 행의 실제 상태는 human 1~4번 |
| 65 | 05-14 | (backstop) Search Console 「확인됨」이 완료 표 전에 `SITE03=OK`로 기록 | ⚠️ insufficient_spec | 표식 순서(1011행 < 1367행)는 확인. 상태 자체는 human 2번 |
| 66 | 05-14 | 마지막 DNS 재확인: MX·SPF·gsv·A 4, `/`·`/support/` HTTPS 200 | ✓ VERIFIED | 이번 실행 dig·curl 같은 결과 |
| 67 | 05-14 | STATE 막는 항목이 DKIM(Phase 10)만 남김 | ✓ VERIFIED | 이번 실행: STATE 「사용자 외부 작업」이 DKIM과 Apple 발신 도메인(둘 다 Phase 10)뿐 |
| 68 | 05-15 | 문서 푸시 후보 출력 = G, 값 없음, 훅 통과 | ✓ VERIFIED | 이번 실행: `git diff 4ea25de e0f2331 -- <사이트 경로>` 0줄, check-site `e0f2331` 통과 |
| 69 | 05-15 | 승인 뒤 그 SHA 하나만 원격에 | ✓ VERIFIED | Pages: 마지막 배포 `e0f233169329` = 원격 main. 승인은 human 7번 (3) |
| 70 | 05-15 | 라이브에서 SC1~SC5 재판정 모두 OK | ✓ VERIFIED | 기록 `PHASE5_SC=OK`. 이번 실행으로 SC1·SC4·SC5는 다시 확인. SC2·SC3의 사람 쪽 부분은 위 표대로 보류 |
| 71 | 05-15 | 라이브 다섯 문서 200·제목·G 빌드와 바이트 같음 | ✓ VERIFIED | 이번 실행: 다섯 URL `200 same` |

**Score:** 68/75 truths verified (behavior-unverified 0).

- 분모 75는 SC 5개와 계획 truth 71개에서 일어나지 않은 갈래 1개(N/A)를 뺀 수입니다.
- 분자에서 빠진 7개는 둘로 나뉩니다.
  - backstop 보류(`insufficient_spec`) 5개: 계획 truth 22·43·45·63·65번
  - 사람만 볼 수 있는 부분이 든 성공 기준 2개: SC2·SC3

### 계획 산출물과 연결

`verify.artifacts`는 계획 15개 모두 `all_passed`(exit 0)입니다.

`verify.key-links`는 7개 계획(05-01·02·05·09·10·14·15)에서 `Pattern not found`를 냈습니다. 이 일곱 패턴은 모두 `^…$` 앵커가 붙은 표식 줄 패턴입니다. `grep -cE`로 `05-EVIDENCE.md`를 직접 찾으면 일곱 모두 1줄씩 있습니다. 도구가 여러 줄 모드 없이 맞춘 오탐으로 보고 WIRED로 판정했습니다.

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `_data/company.yml` | 사실값 슬롯 6키 | ✓ VERIFIED | 값 있는 키 다섯, `phone` 빈 값. 값 규칙 주석 있음 |
| `_includes/footer.html` | 사업자 줄·주소 줄·이메일/전화 줄 render-if-present, 「고객 지원」 링크, nav 「약관 및 지원」 | ✓ VERIFIED | `.size > 0` 판정과 `| escape` 출력. 랜딩·레이아웃 두 곳이 include |
| `_includes/css/common.css` | `.rp-foot-legal span`·`a` 두 줄 | ✓ VERIFIED | 28·29행 |
| `_includes/header.html` | 「고객 지원」 링크 | ✓ VERIFIED | `home` 두 경우 모두 `/support/` |
| `support/index.html` | 지원 페이지, `updated` 포함 | ✓ VERIFIED | `layout: legal`, heading 「러닝펜슬 고객 지원」, 연락처·신고·FAQ 조건부 |
| `scripts/check-site.sh` | 7번 항목, 3번 지원 페이지 제목 | ✓ VERIFIED | 이번 실행 양성·음성 대조 |
| `.planning/codebase/CONVENTIONS.md` | 일곱 항목 문장, 앵커 규칙 | ✓ VERIFIED | 각 1줄 |
| `.planning/baseline/NAMES.md` | 키 이름(값 없음) | ✓ VERIFIED | 사업자 행 「(빈칸)」 |
| `CLAUDE.md` | Pages 표 지원 행, 방침 행 | ✓ VERIFIED | 위 60번 |
| `05-EVIDENCE.md` | 판정 기록 | ✓ VERIFIED | 표식 30여 개, 사업자 값·주소·홈 경로 0 |

| From | To | Via | Status |
|------|----|-----|--------|
| `_includes/footer.html` | `_data/company.yml` | `site.data.company.<키>.size > 0`, `| escape` | ✓ WIRED (이번 실행: 값 변형 빌드 세 가지로 출력이 따라 바뀜) |
| `_includes/css/common.css` | `_includes/footer.html` | `.rp-foot-legal span/a` | ✓ WIRED (라이브 `PASS foot`, 링크 색 판정) |
| `_data/company.yml` (`support_email`) | `support/index.html` | `#contact`·`#report`·신고 FAQ 쌍 조건 | ✓ WIRED (빈 값 빌드에서 셋이 함께 사라짐) |
| `_includes/header.html`·`footer.html` | `support/index.html` | `href="/support/"` | ✓ WIRED (라이브 다섯 문서 2곳, 페이지 200) |
| `.githooks/pre-push` | `scripts/check-site.sh` | main 푸시마다 SHA 점검 | ✓ WIRED (훅 파일 불변, 기록 `HOOK7=OK`) |
| `scripts/check-site.sh` (H2 줄) | `support/index.html` | `EXPECTED_TITLES` | ✓ WIRED (라이브 제목 「고객 지원 - 러닝펜슬」) |
| `05-EVIDENCE.md` 표식 일곱 개 | 각 대상 | `^…=…$` | ✓ WIRED (도구 오탐, 직접 grep 각 1줄) |
| `.planning/codebase/CONVENTIONS.md` | `.claude/CLAUDE.md` | `generate-claude-md` | ✓ WIRED (재생성 `cmp` 같음) |

### Data-Flow Trace (Level 4)

| Artifact | Data Variable | Source | Produces Real Data | Status |
|----------|---------------|--------|--------------------|--------|
| 모든 페이지 푸터 | `site.data.company.*` | `_data/company.yml` (빌드 시 Liquid) | 예. 라이브 다섯 문서에 값 다섯이 나옴(건수만 셈) | ✓ FLOWING |
| `/support/` `#contact`·FAQ 운영 주체 | `support_email`, `trade_name` | 같은 파일 | 예. 라이브 mailto 1, 운영 주체 dd 1 | ✓ FLOWING |
| 「전화」 행 | `phone` | 같은 파일(빈 값) | 의도대로 그리지 않음. 가짜 값 빌드에서 흐름 확인 | ✓ FLOWING (render-if-present) |

### Deferred Items

뒤 단계가 다루는 항목입니다. Phase 5 상태 판정에는 넣지 않았습니다.

| # | Item | Addressed In | Evidence |
|---|------|-------------|----------|
| 1 | BIZ-02 나머지: 삭제 안내·처리방침·위치약관도 `_data` 한 곳에서 사업자 정보·연락처를 읽음 | Phase 6·7·8 (문서 자체) | Phase 6 SC1, Phase 7 SC4, Phase 8 SC2. 단 「`_data`에서 읽음」 조건은 어느 성공 기준에도 없음 → human 9번 |
| 2 | BIZ-03 나머지: 전화번호가 보호책임자·위치약관에도 바로 나타남 | Phase 7·8 (문서 자체) | Phase 7 SC4, Phase 8 SC2. 전화 칸 연결 조건은 성공 기준에 없음 → human 9번 |
| 3 | 지원 FAQ 삭제 경로와 라이브 `/data-deletion/`(임시 게시본)의 불일치 (경고) | Phase 6 | Phase 6 SC3 「앱 안 삭제 경로가 실제 메뉴 이름 「회원탈퇴」로 안내」(DEL-04), 05-CONTEXT D-16 참고 |

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| 사이트 점검 일곱 항목 | `scripts/check-site.sh` (작업 트리), `scripts/check-site.sh origin/main` | 둘 다 「통과 (… jekyll 3.10.0)」 | ✓ PASS |
| 게이트 가드 음성 대조 | `scripts/check-site.sh 48f332e`, `… 5100b37` | 7번 연락처 문구 하나, 「실패 — 1건」 | ✓ PASS (기대한 실패) |
| 기대 제목 줄이 게이트 전 main에 못 들어감 | `scripts/check-site.sh 57e56b0` | 「문서가 없습니다: /support/index.html」, 「실패 — 1건」 | ✓ PASS (기대한 실패) |
| 라이브 = 원격 main 빌드 | production·`--safe` 빌드 + `curl …?cb=` + `cmp` | 다섯 문서 200·제목·`same` | ✓ PASS |
| 푸터 줄 나뉨·넘침·링크 색 | `node p5-foot.mjs https://runningpencil.com ?cb=…` (스크래치 도구) | 20줄 OK, `PASS foot` | ✓ PASS |
| 지원 페이지 구조·링크·앵커 | `node p5-support.mjs https://runningpencil.com ?cb=…` | 20줄 OK, `PASS support`, exit 0 | ✓ PASS |
| render-if-present 행렬 | 스크래치 사본에서 `phone`만 채움 / 모든 값 비움 → 빌드 | 전화 행 1↔0, 사업자 행 있음↔없음, 빈 `<p>` 0 | ✓ PASS |
| 주소 이력 | `gh api …/pages/builds` + 배포 커밋마다 `git grep -F` | 게이트 푸시 전 배포 18개 모두 0 | ✓ PASS |
| DNS·HTTPS | `dig @ns1.gabia.co.kr`, `dig @1.1.1.1`, `curl -sI` | MX 1(Google), SPF 1, gsv 1, A 4, 200 | ✓ PASS |
| 커밋 해시 | `verify.commits` (12개) | `all_valid: true` | ✓ PASS |

### Probe Execution

해당 없음. `scripts/**/tests/probe-*.sh`가 없고 계획 어디에도 probe 선언이 없습니다. 이 단계의 점검 도구는 `scripts/check-site.sh`이고, 위 Spot-Checks에서 직접 돌렸습니다.

### Requirements Coverage

계획 frontmatter에 선언된 ID는 BIZ-01·BIZ-02·BIZ-03·SUP-01·SUP-02·SUP-03·SUP-04·SITE-03 여덟 개입니다. REQUIREMENTS.md가 Phase 5에 건 ID와 같아 고아 요구사항은 없습니다. REQUIREMENTS.md는 Phase 5 동안 고쳐지지 않았습니다(체크 0). 05-09 SUMMARY가 「STATE·ROADMAP·REQUIREMENTS」 커밋이라 적었지만 SITE-03 체크는 없습니다.

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| BIZ-01 | 05-03·05·06·11·12·15 | 모든 페이지 푸터에 사업자등록증과 같은 표기의 상호·대표자·사업자등록번호·주소와 지원 이메일 | ✓ SATISFIED (등록증 일치는 ? NEEDS HUMAN) | 라이브 다섯 문서 라벨 넷 + 이메일 행. 등록증 대조는 human 1번 |
| BIZ-02 | 05-01·02·03·05·06·07·11·15 | `_data` 한 곳만 고쳐 푸터·지원 페이지·삭제 안내·처리방침·위치약관에 반영, 값 없으면 표시 안 함 | ◐ PARTIAL. Phase 5 범위는 SATISFIED, 나머지는 deferred | 푸터·지원 페이지는 `_data/company.yml` 하나에서 읽고, 빈 값이면 행·구간이 없음(이번 실행). 삭제 안내·처리방침·위치약관은 아직 `_data`를 읽지 않음(Phase 6~8). 체크하지 말 것. human 9번 |
| BIZ-03 | 05-02·06·11·15 | 전화번호를 넣으면 푸터·지원 페이지·보호책임자·위치약관에 바로 나타남 (지금은 칸만) | ◐ PARTIAL. Phase 5 범위는 SATISFIED, 나머지는 deferred | 가짜 전화 빌드에서 푸터·지원 페이지에 나타남, 지금은 0. 보호책임자·위치약관은 Phase 7·8. 체크하지 말 것. human 9번 |
| SUP-01 | 05-01·02·04·08·11·12·13·15 | `/support/` 맨 위 「러닝펜슬」, 지원 이메일과 응답 안내 | ✓ SATISFIED | 라이브 h1, `#contact` mailto·「영업일 기준 3일」 |
| SUP-02 | 05-04·08·10·11·12·13·14·15 | 외부 4곳 메일이 업무 메일에 도착하고, 확인 전에는 주소가 사이트에 없음 | ? NEEDS HUMAN (순서는 SATISFIED) | 「확인 전 미공개」는 배포 이력으로 직접 확인. 「도착」은 human 3번 |
| SUP-03 | 05-02·08·11·12·15 | 지원 페이지에서 공개 코스 신고 방법(지원 이메일) | ✓ SATISFIED | `#report` 구간과 FAQ 신고 쌍 |
| SUP-04 | 05-02·08·11·12·15 | FAQ: 운영 주체, 위치 수집 시점(기록 중에만, 화면이 꺼져도), 계정 삭제, 공개 코스 신고 | ✓ SATISFIED | dt 네 개. 위치 답은 DATA-INVENTORY 194·196행(기록 중에만 저장, 화면 꺼짐, Android 알림, 「앱 사용 중」 권한)과 맞음. 삭제 경로는 DATA-INVENTORY 258행 「회원탈퇴」와 맞음(라이브 `/data-deletion/`과의 차이는 deferred, Phase 6) |
| SITE-03 | 05-09·14·15 | Search Console 도메인 속성 확인됨 | ? NEEDS HUMAN | gsv TXT 1줄은 직접 관찰. 「확인됨」은 human 2번 |

### Anti-Patterns Found

Phase 5가 바꾼 사이트·점검 파일(`_data/company.yml`, `_includes/footer.html`, `_includes/header.html`, `_includes/css/common.css`, `support/index.html`, `scripts/check-site.sh`)을 훑었습니다.

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `scripts/check-site.sh` | 44 | `XXX` (`mktemp … rp-check.XXXXXX`) | ℹ️ Info | 부채 표시가 아니라 mktemp 템플릿입니다. 막는 항목 아님 |
| `_data/company.yml` | 2 | 「추후 기재」 | ℹ️ Info | 「쓰지 않는다」는 규칙 주석 안의 낱말입니다. 출력 0 |
| `scripts/check-site.sh` | 7번 구획 | REVIEW WR-01: `mailto:` 확인이 공유 푸터에도 걸림 | ⚠️ Warning | 이메일 값이 있으면 지원 페이지 본문의 연락처 구간이 빠져도 7번이 통과합니다. 게이트 전 상황(값 없음)에서는 푸터에도 mailto가 없어 가드가 그대로 섭니다. 리뷰 처분 open |
| `_includes/css/common.css` | 포커스 | REVIEW WR-02: 어두운 푸터의 포커스 테두리 대비 약 2.1:1 | ⚠️ Warning | 새 이메일·「고객 지원」 링크에도 해당. 리뷰 처분 open |
| `scripts/check-site.sh` | 7번 | REVIEW WR-03: 「링크는 있는데 페이지 없음」 분기는 3번이 이미 잡음 | ℹ️ Info | 중복 방어. open |
| `support/index.html` | `#report`·FAQ | UI-REVIEW: `#report`로 바로 열면 「위 지원 이메일」이 화면 밖 | ⚠️ Warning | 앱이 `/support/#report`로 열 때 주소가 바로 안 보임 |
| `_includes/css/common.css` | 860px 규칙 | UI-REVIEW: 좁은 화면에서 헤더 nav가 숨어 「고객 지원」은 푸터에서만 닿음 | ⚠️ Warning | SC5 「헤더·푸터에서 갈 수 있다」는 1280에서 헤더, 모든 폭에서 푸터로 충족. 모바일 심사자 동선은 길어짐 |
| `support/index.html` | FAQ 계정 삭제 | 라이브 `/data-deletion/`(임시 게시본)과 삭제 경로가 다름 | ⚠️ Warning | deferred, Phase 6 DEL-04 |
| (리뷰) | — | REVIEW IN-01~IN-04 (운영사 이름 하드코딩, 조사 규칙 문구, 전화만 있을 때 지원 페이지 조건, 값 규칙 점검 없음) | ℹ️ Info | 처분 open |
| (Phase 1 커밋) | — | 지원 주소가 Phase 1 `.planning` 문서와 커밋 메시지 하나(`c25c8ab`)에 있음 | ℹ️ Info | 이름 표가 주소의 정본이라 Phase 1부터 공개 저장소에 있었습니다. 사이트 출력(점으로 시작하는 `.planning`은 출력 안 됨)에는 G 전까지 없었습니다. Phase 5 금지 항목 범위 밖 |

TBD·FIXME·XXX 부채 표시(🛑)는 0건입니다(위 `XXX`는 mktemp 템플릿).

### 금지 항목 (judgment 등급, 비권위 판정)

계획 15개의 금지 항목 40건입니다. 모두 judgment 등급이고, 모두 unverified-prohibition — human review recommended입니다 (human 8번). 판정 근거는 「git」(이번 실행), 「기록」(EVIDENCE), 「확인 불가」입니다. 관찰된 위반은 없습니다.

| Plan | 금지 내용 (요약) | 비권위 판정 | 근거 |
|------|------------------|-------------|------|
| 05-01 | 기준 기록 전에 사이트 파일 수정 | 위반 없음 | git: BASE 뒤 첫 사이트 커밋이 `bc934fb`, BASE·BASE_LIVE 사이트 트리 같음 |
| 05-01 | 승인 전 설치·다른 버전·npm 사용 | 위반 없음(기록) | 스크래치 `pnpm-lock.yaml`, 1.59.1. 승인 시점은 확인 불가 → human 7번 |
| 05-01 | 도구·스크래치를 저장소에 두거나 커밋 | 위반 없음 | git: 추적 파일에 `.mjs`·`pw/`·`node_modules` 0, 스크래치는 저장소 옆 폴더 |
| 05-02 | 사이트 파일 수정·커밋 | 위반 없음 | git: 05-02 시기 커밋은 `.planning`뿐(첫 사이트 커밋 `bc934fb`은 05-03) |
| 05-02 | 실제 값으로 시험 | 위반 없음(기록) | EVIDENCE가 가짜 값만 적음. 실제 값 사용 여부는 확인 불가 |
| 05-02 | 데이터 목록 밖 사실·처리 약속·화면 밖 신고 항목 | 위반 없음 | 지원 페이지 본문이 DATA-INVENTORY와 맞음, 처리 결과 약속 문장 0, 신고 항목 넷은 앱 화면 정보 |
| 05-03 | M1에 CSS, M2에 템플릿 섞기 | 위반 없음 | git: `bc934fb` 두 파일, `b7e2dcd` CSS 하나 |
| 05-03 | 05-03에서 값 커밋 | 위반 없음 | git: `bc934fb`의 값 있는 키 0 |
| 05-03 | 새 hex·노랑 글자색 | 위반 없음 | git: M2 두 줄, `#FAFAF7`(기존) |
| 05-04 | 시험 객체를 ref에 붙이거나 푸시 | 위반 없음 | git: `for-each-ref`에 `refs/p5-scratch/c4-cand`(05-05 것) 하나뿐 |
| 05-04 | M3에서 기대 제목에 지원 줄 추가 | 위반 없음 | git: `da94075` 스크립트에 `support/index.html|` 0 |
| 05-05 | 값 추측·정규화 | 확인 불가 | 원본 증서 없음 → human 1번 |
| 05-05 | 값을 `.planning`·메시지·STATE에 적거나 승인 전 브랜치 커밋 | 위반 없음 | git: 값 0건, 값 커밋 M4는 `D10_APPROVED` 기록 뒤(05-06) |
| 05-05 | 이메일·전화 값 넣기 | 위반 없음 | git: `C4_CAND`·M4의 두 값 빈 값 |
| 05-06 | 승인 없이·다른 SHA 푸시 | 위반 없음(기록) | Pages: 배포 SHA = `PUSH1_SHA`. 승인은 human 7번 |
| 05-06 | 원인 수정 먼저·force push·이력 수정·`--no-verify` | 위반 없음 | git: 배포 세 SHA가 직선 조상 관계, 되돌리기 없음(기록). `--no-verify` 여부는 기록 근거 |
| 05-06 | 지원 페이지·링크·이메일을 첫 푸시에 | 위반 없음 | git: `57e56b0` 트리에 `support/` 0, 출력 링크 0, 주소 0 |
| 05-07 | 값·주소를 CLAUDE.md·README·원본 맵·이름 표에 | 위반 없음 | git: 사업자 값 0. 주소는 이름 표에 있으나 Phase 1부터 정본 행(05-07이 더한 것 아님) |
| 05-07 | 생성 구간 손으로 수정 | 위반 없음 | 재생성 `cmp` 같음 |
| 05-07 | 지원 쪽 문서를 05-07에서 「적용됨」으로 | 위반 없음 | git: `a37b124`의 「지원 이메일 공개」 행에 「적용됨」 0 |
| 05-08 | 보류 브랜치 푸시·upstream·메인 checkout | 위반 없음 | git: 원격 0, upstream 없음. checkout 여부는 기록 근거 |
| 05-08 | 지원 페이지에 주소 직접·`updated` 미리 | 위반 없음 | git: H1 `@` 0, `updated:` 0. 주소는 지금도 `_data`에서만 |
| 05-08 | 데이터 목록 밖 사실·약속·화면 밖 신고 항목 | 위반 없음 | 05-02와 같은 판정(같은 blob) |
| 05-09 | 토큰·TXT 값·라우터 호스트·IP를 기록에 | 위반 없음 | EVIDENCE: TXT 토큰 꼴 0, IP는 `1.1.1.1`·loopback뿐 |
| 05-09 | 끝난 작업 다시 요청·Claude가 DNS/Search Console 변경 | 위반 없음(기록) | 확인 불가 부분은 human 7번 |
| 05-10 | 4/4 전에 주소를 `_data`·HTML에 | 위반 없음 | git: 주소 첫 사이트 커밋 G가 게이트 기록의 자손 |
| 05-10 | 보낸 사람 주소·본문·시각을 기록에 | 위반 없음 | EVIDENCE 이메일 주소 꼴 0 |
| 05-10 | 시험 cherry-pick을 남김 | 위반 없음 | git: 남은 ref·worktree 없음 |
| 05-11 | 주소를 명령·메시지·기록에 글자로 | 위반 없음(범위 안) | git: Phase 5 커밋 메시지·EVIDENCE에 주소 0 (Phase 1 `c25c8ab`는 범위 밖, Info) |
| 05-11 | rebase·reset·amend로 보류 묶음 이동 | 위반 없음 | git: 보류 원본 세 커밋이 그대로 있고 `git cherry` 모두 `-` |
| 05-11 | 게이트 기록보다 앞선 커밋에 주소 | 위반 없음 | SC1 근거 |
| 05-12 | 승인 없이·다른 SHA 푸시 | 위반 없음(기록) | Pages 배포 = `PUSH2_SHA`. 승인은 human 7번 |
| 05-12 | 지원 페이지와 링크를 나눠 푸시·force·이력 수정·`--no-verify` | 위반 없음 | Pages: 링크 없는 `57e56b0` 다음 배포가 페이지·링크를 함께 담은 `2bd4789`. 직선 이력 |
| 05-13 | 주소·값을 CLAUDE.md·README·원본 맵에 | 위반 없음 | 이번 실행 0건 |
| 05-13 | cherry 확인 전 worktree 삭제·보류 브랜치 upstream/푸시 | 위반 없음 | 기록 `OK cherry all-in-main 3` 뒤 `HOLD_WT_REMOVED`. 원격 0 |
| 05-13 | `legal.css` 수정 | 위반 없음 | git: Phase 5 커밋 0 |
| 05-14 | 개인 주소·계정 이메일·DNS 토큰을 기록에 | 위반 없음 | EVIDENCE 이메일 꼴 0, 토큰 꼴 0 |
| 05-14 | DKIM 때문에 완료를 막거나 끝났다고 추측 | 위반 없음 | 기록 `dkim=0`을 참고 행으로만 둠. 이번 실행 dig도 DKIM 0 |
| 05-15 | 승인 없이·다른 SHA 푸시 | 위반 없음(기록) | Pages 배포 = `PUSH3_SHA` = 원격 main. 승인은 human 7번 |
| 05-15 | 문서 푸시에 사이트 출력 변경 커밋 | 위반 없음 | git: G와 `e0f2331`의 사이트 경로 차이 0 |
| (합계) | 40건 | 관찰된 위반 0, 확인 불가 부분은 human 1·7번에 묶음 | — |

### Human Verification Required

frontmatter `human_verification`에 9건이 있습니다. 요약입니다.

1. **사업자등록증 대조** (insufficient_spec): 라이브 푸터 네 값과 증서를 글자 단위로 대조합니다.
2. **Search Console 「확인됨」** (insufficient_spec): 도메인 속성의 상태를 봅니다.
3. **외부 수신 재시험** (insufficient_spec): iCloud나 Outlook에서 한 통을 다시 보냅니다. 기록된 4/4는 운영자 Gmail 필터를 만든 뒤 얻은 결과입니다.
4. **보내기 설정** (insufficient_spec): Gmail From 목록과 받은 쪽 표시를 봅니다.
5. **실기기 iPhone Safari**: 푸터, `/support/`, mailto를 눌러 봅니다.
6. **VoiceOver**: `/support/`의 제목·구간·FAQ와 푸터 nav를 읽습니다.
7. **과정 사실**: Playwright 설치 승인, D-10 승인, 푸시 세 번의 승인을 확인합니다.
8. **금지 항목 40건**: 비권위 판정을 훑습니다.
9. **결정 요청**: BIZ-02·BIZ-03의 추적과 뒤 단계 성공 기준을 정합니다.

### Gaps Summary

목표를 막는 공백은 없습니다. 사이트 쪽 결과물은 코드·원격 main·라이브에서 모두 직접 확인했습니다.

- `_data` 슬롯, 푸터 사업자 줄과 이메일 행, `/support/`와 헤더·푸터 링크가 있습니다.
- 게이트 가드(check-site 7번과 pre-push)가 기대대로 막고 통과시킵니다.
- 게이트 순서(기록 → 주소 커밋 → 배포)가 맞습니다.
- DNS·HTTPS가 기대 상태입니다.

남은 것은 두 종류입니다.

- **외부 세계 사실 넷.** 등록증 일치, Search Console, 수신, 보내기 설정입니다. 저장소 밖이라 사용자 보고로만 기록돼 있어 판정을 보류했습니다.
- **요구사항 추적의 구멍.** BIZ-02·BIZ-03 문구의 법적 문서 부분이 이 구멍입니다. Phase 5 성공 기준(SC4)은 푸터와 지원 페이지만 요구하므로 Phase 5의 공백은 아닙니다. 하지만 뒤 단계 어디에도 「`_data`에서 읽음」 조건이 없어 개발자 결정이 필요합니다. 그때까지 REQUIREMENTS.md에서 BIZ-02·BIZ-03을 체크하지 마세요.
- 체크해도 되는 ID: SUP-01·SUP-03·SUP-04는 지금 체크해도 됩니다. BIZ-01은 사람 확인 1번 뒤, SUP-02는 3번 뒤, SITE-03은 2번 뒤에 체크합니다.

---

_Verified: 2026-11-19T19:44:59Z_
_Verifier: Claude (gsd-verifier)_
