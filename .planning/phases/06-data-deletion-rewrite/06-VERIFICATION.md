---
phase: 06-data-deletion-rewrite
verified: 2026-11-27T05:06:00Z
status: human_needed
score: 53/72 must-haves verified (로드맵 성공 기준 4/5, 계획 truth 49/67, FAILED 0, UNCERTAIN 19)
covered_files:
  - ".claude/CLAUDE.md"
  - ".planning/phases/06-data-deletion-rewrite/06-01-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-01-SUMMARY.md"
  - ".planning/phases/06-data-deletion-rewrite/06-02-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-02-SUMMARY.md"
  - ".planning/phases/06-data-deletion-rewrite/06-03-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-03-SUMMARY.md"
  - ".planning/phases/06-data-deletion-rewrite/06-04-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-04-SUMMARY.md"
  - ".planning/phases/06-data-deletion-rewrite/06-05-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-05-SUMMARY.md"
  - ".planning/phases/06-data-deletion-rewrite/06-06-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-06-SUMMARY.md"
  - ".planning/phases/06-data-deletion-rewrite/06-07-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-07-SUMMARY.md"
  - ".planning/phases/06-data-deletion-rewrite/06-08-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-08-SUMMARY.md"
  - ".planning/phases/06-data-deletion-rewrite/06-09-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-09-SUMMARY.md"
  - ".planning/phases/06-data-deletion-rewrite/06-10-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-10-SUMMARY.md"
  - ".planning/phases/06-data-deletion-rewrite/06-11-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-11-SUMMARY.md"
  - ".planning/phases/06-data-deletion-rewrite/06-12-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-12-SUMMARY.md"
  - ".planning/phases/06-data-deletion-rewrite/06-13-PLAN.md"
  - ".planning/phases/06-data-deletion-rewrite/06-13-SUMMARY.md"
  - "CLAUDE.md"
  - "README.md"
  - "_data/company.yml"
  - "data-deletion/index.html"
  - "scripts/check-site.sh"
covered_digest: "v4:sha256:2273718629bcd5beea23b5e3fdd269a6997c8a553d2e5e0bcc423e553e27b47c"
behavior_unverified: 0
overrides_applied: 0
decision_coverage:
  honored: 41
  total: 41
  not_honored: []
human_verification:
  - test: "실기기 휴대폰(375px 안팎)에서 https://runningpencil.com/data-deletion/ 을 처음 연다"
    expected: "첫 화면에서 「삭제 요청 방법」 조항을 찾을 수 있고, 조금만 내리면 「② 앱 없이 지원 이메일로 요청하기」와 mailto 링크, 「메일에 적을 내용」 목록이 나온다. 이것이 성공 기준 1의 「문서 첫 화면에서 찾는다」와 DEL-01의 「눈에 띄게」를 충족하는지 사람이 판단한다"
    why_human: "검증자는 브라우저를 띄우지 않았다(Playwright 패키지가 없고 새로 설치하려면 승인이 필요하다). 실행자 도구 기록은 1280에서 mailto가 첫 화면 안(mailfirst=ok)이고, 375에서는 요청 조항 h2만 판정했다(mailfirst=na). 첫 화면 판단은 시각 판단이다"
  - test: "Google Play와 App Store의 공개 등록정보(스토어 페이지)에 보이는 개발자·판매자 이름을 라이브 삭제 안내 소개 문단의 개발자 이름과 대조한다"
    expected: "두 스토어의 공개 표시와 소개 문단의 이름이 글자까지 같다 (성공 기준 1, DEL-02)"
    why_human: "값은 저장소 밖 콘솔·스토어에 있다. 06-08·06-09 기록은 Play Console 계정 화면과 Apple Developer 멤버십 화면만 봤고 공개 등록정보는 보지 않았다고 적는다. App Store 판매자 이름이 Apple 법인 이름과 같다는 전제도 확인되지 않았다 (06-08 SUMMARY 열린 항목 1·2)"
  - test: "개발자 이름 값 「.planning·기록에 없음」 truth 넷(06-08 #3, 06-09 #6, 06-11 #4, 06-12 #2)과 06-VALIDATION.md 「D-02·D-18」 행을 어떻게 읽을지 정한다"
    expected: "사용자가 (가) 기준 이전부터 추적 파일에 있던 글자이고 값을 받기 전에 쓴 대조 낱말이라 받아들인다(아래 override 제안), 또는 (나) 06-EVIDENCE.md:1261의 해당 낱말을 지우는 문서 커밋을 낸다 가운데 하나를 고른다"
    why_human: "기준 커밋(89f659a5fdca) 이후 .planning에 더해진 줄 가운데 개발자 이름 값과 같은 글자가 든 줄은 1줄이다(06-EVIDENCE.md:1261, 커밋 21ead38). 그 줄은 「## 06-08 시험 실행」 구간(값을 받기 전 Task 1)에 있다. 같은 글자는 기준 커밋 전부터 추적 파일 여러 곳에 있었다(vals excluded=1). 그래서 실행자의 누출 점검은 실제 값에 대해 돌지 않았다(leak=skip). 커밋 메시지와 .planning 밖 문서에 새로 더한 줄은 0이다. truth 문장을 글자 그대로 읽을지, 「새로 받은 값을 적지 않음」으로 읽을지는 판단이다 (06-08 SUMMARY 열린 항목 3이 단계 검증에 넘긴 질문)"
  - test: "앱 저장소의 기준 앱 커밋 AW(92e986c3bb29)에서 06-04가 적은 앱 사실을 읽기 전용으로 확인하거나, 기록(06-EVIDENCE.md 「06-04 앱 사실」·「06-04 화면 사실」)을 그대로 받아들일지 정한다"
    expected: "탈퇴·운영자 도구가 공개하지 않은 코스를 지우고 공개한 코스를 남김, uid rate_limits 삭제와 TTL, 운영자 도구 범위 account·records와 dry-run 기본, 코스 단위 기록 삭제, 확인자료 1기록 1건·184일·지체 없는 파기, 메뉴 문구 일곱이 AW 코드와 같다 (06-01 #3, 06-04 #1·#2·#3)"
    why_human: "이 저장소에는 앱 코드가 없다. 검증자는 앱 저장소를 읽지 않았고, 이 truth들은 실행자 기록(OK app item 11줄, APP_FACTS=OK)으로만 뒷받침된다"
  - test: "사람 결정과 승인 이력이 기록대로인지 확인한다: Playwright 설치 승인(06-01 #4), p6-deletion 도구 음성·양성 대조(06-01 #5), installation ID 선택(06-03 #2), 익명 문장 (가)와 D-33 ②·D-39 결정(06-06 #3·#4), 원고·캡처 승인(06-07 #9), 가짜 값 시험 실행(06-08 #1·#2), 푸시 전 소개 문단 대조·SHA 승인과 커밋 없음(06-09 #3·#4)"
    expected: "각 결정·승인을 사용자가 직접 했고 기록의 표식(INSTALL_ID, D33_C7, D33_C8 등, DRAFT_APPROVED, PUSH1_APPROVED, PUSH2_APPROVED)과 같다"
    why_human: "과거 대화와 스크래치 도구 실행은 저장소에 증거가 없다. 저장소에서 확인한 것은 표식이 있다는 것, 승인한 SHA와 푸시한 SHA·origin/main이 같다는 것, 이력이 선형이라는 것뿐이다"
  - test: "아래 prohibitions_flagged의 판단 단계 금지 사항 33건을 항목마다 확인해 해결(resolved)로 둘지 정한다"
    expected: "항목마다 검증자의 비권위 판정과 근거를 보고 사람이 받아들이거나 되돌린다"
    why_human: "모든 금지 사항이 verification: judgment 단계다. 판단 단계 금지 사항은 사람이 항목마다 확인해야 하며 조용히 통과로 셀 수 없다"
prohibitions_flagged:
  - plan: "06-01"
    statement: "기준 기록 전에 사이트 파일을 고치지 않는다"
    llm_verdict: "지켜짐 (비권위)"
    evidence: "BASE_SHA=89f659a5fdca 뒤 첫 사이트 파일 변경은 S1(0c48a11). BASE와 BASE_LIVE의 .planning 밖 트리 차이 0"
  - plan: "06-01"
    statement: "승인 전 패키지 설치 금지, pnpm 사용"
    llm_verdict: "확인 불가 (기록만 있음)"
    evidence: "스크래치 설치라 저장소에 흔적이 없다. 저장소에 package.json·lockfile 추가 없음"
  - plan: "06-01"
    statement: "앱 저장소에 쓰지 않는다"
    llm_verdict: "확인 불가"
    evidence: "앱 저장소를 읽지 않았다"
  - plan: "06-02"
    statement: "기준 앱 커밋 줄이나 앱 작업 뒤에만 참인 사실을 적지 않는다"
    llm_verdict: "지켜짐 (비권위, 기록 기준)"
    evidence: "데이터 목록 32행 「기준 앱 커밋은 그대로이고 D-05 앱 작업 뒤 재기준은 따로 한다」. 재기준은 06-04 커밋 aeb6f446"
  - plan: "06-02"
    statement: "익명 계정 서버 기록이 「없다」고 단정하지 않는다"
    llm_verdict: "지켜짐"
    evidence: "데이터 목록 195행 「…쓰는 곳을 찾지 못했다」. 삭제 안내 aside는 「기록·코스·뱃지를 서버에 저장하지 않습니다」로 범위를 좁힘"
  - plan: "06-03"
    statement: "「끝났다」는 말만으로 앱 작업 완료로 기록하지 않는다"
    llm_verdict: "지켜짐 (비권위, 기록 기준)"
    evidence: "APP_WORK_HEAD=92e986c3bb29와 경로가 기록되고 06-04가 따로 확인 기록을 남김"
  - plan: "06-03"
    statement: "열린 선택지를 계획자·실행자가 대신 고르지 않는다"
    llm_verdict: "확인 불가 (기록만 있음)"
    evidence: "INSTALL_ID=keep-out, DEL06_REPORT=conform 표식과 「사용자가 고름」 서술"
  - plan: "06-04"
    statement: "앱 저장소에 쓰지 않는다"
    llm_verdict: "확인 불가"
    evidence: "앱 저장소를 읽지 않았다"
  - plan: "06-04"
    statement: "AW에서 확인하지 못한 앱 동작을 데이터 목록에 적지 않는다"
    llm_verdict: "부분 확인 (비권위)"
    evidence: "데이터 목록 행마다 앱 경로·행 번호나 「미확인」·「공식 문서」·「Phase 6 D-NN」 출처가 붙어 있음. 앱 코드와의 대조는 하지 않음"
  - plan: "06-04"
    statement: "기준 앱 커밋을 앱 HEAD로 올리거나 정하지 않은 값을 적지 않는다"
    llm_verdict: "지켜짐 (비권위)"
    evidence: "데이터 목록 6행 기준 앱 커밋 92e986c3 = APP_WORK_HEAD. 06-13 커밋 a789cf96은 이 줄을 바꾸지 않음"
  - plan: "06-04"
    statement: "목록·기록·커밋 메시지에 사업자 값·지원 주소·개발자 이름 값·프로젝트 ID·홈 경로를 적지 않는다"
    llm_verdict: "판단 필요"
    evidence: "기준 이후 .planning에 더한 줄: 대표자·사업자등록번호·주소·지원 주소 0줄. trade_name 값과 같은 글자 4줄(기준 커밋 전부터 추적 파일에 있던 글자). 개발자 이름과 같은 글자 1줄(위 human_verification 3번). 커밋 메시지 0. 홈 경로 꼴 1줄은 홈 경로를 잡는 grep 패턴 문자열(.planning/quick/261126-rw9…)"
  - plan: "06-05"
    statement: "절차서에 지원 주소·사업자 값·개발자 이름·uid·프로젝트 ID·명령 줄을 옮겨 적지 않는다"
    llm_verdict: "지켜짐 (비권위)"
    evidence: "USER-TASKS.md 「작업 13」 구간에서 지원 주소 0, 개발자 이름 0. 같은 파일의 지원 주소 9줄은 Phase 1 커밋 388eb9f가 넣은 것"
  - plan: "06-05"
    statement: "운영자가 지킬 수 없는 처리를 적지 않는다"
    llm_verdict: "지켜짐 (비권위)"
    evidence: "범위는 account·records뿐(「위치 기록만」 0), 연결 해제는 「안내에 따라 직접 해제해 주세요」, 작업 13에 옛 30일 상한 0"
  - plan: "06-06"
    statement: "열린 선택지를 계획자·실행자가 고르지 않는다"
    llm_verdict: "확인 불가 (기록만 있음)"
    evidence: "D33_C7·D33_C8·PUBLIC_COURSE_PERIOD 등 표식 8개와 「실행자는 권하지 않았다」 서술"
  - plan: "06-06"
    statement: "dev 값을 prod 사실처럼 적지 않는다"
    llm_verdict: "지켜짐"
    evidence: "데이터 목록 G 구간이 7일·30일을 「근거: dev CLI」와 「prod 설정이 이 값 이하여야 함 (Phase 6 D-33 ②)」으로 적음. 삭제 안내는 「삭제 뒤 최대 7일」·「최대 30일」 상한으로만 씀"
  - plan: "06-06"
    statement: "이미 정한 것을 다시 묻지 않는다"
    llm_verdict: "확인 불가 (기록만 있음)"
    evidence: "기록 서술만 있음"
  - plan: "06-07"
    statement: "데이터 목록에 없는 사실을 원고에 쓰지 않는다"
    llm_verdict: "지켜짐 (비권위)"
    evidence: "기간 문구 7개, 「6개월」, 메뉴 문구 7개, 10일·지체 없이, 제공자 수신 항목이 데이터 목록 G·C·B 구간 글자와 같다. 「영업일 기준 3일」은 지원 페이지 기존 약속·D-29·작업 13과 같다"
  - plan: "06-07"
    statement: "승인 전에 원고를 작업 트리·main에 넣지 않는다"
    llm_verdict: "지켜짐"
    evidence: "BASE와 S2 사이에 data-deletion/index.html을 바꾼 커밋 0. 원고 승인 기록 커밋 0255b12가 S2의 조상"
  - plan: "06-07"
    statement: "제공자 연결 해제나 삭제 완료를 보장하는 표현을 쓰지 않는다"
    llm_verdict: "지켜짐"
    evidence: "「보장·완전히·영구」 0. 제공자 섹션 여섯이 모두 「시도하며, 이 단계는 건너뛸 수 있습니다」"
  - plan: "06-07"
    statement: "값 없는 사실값 자리에 자리표시를 넣지 않는다"
    llm_verdict: "지켜짐"
    evidence: "검증자 변형 빌드 B(개발자 이름·지원 주소·상호·주소 빈 값)에서 소개 문단·②·문의처 0, 자리표시 낱말 0"
  - plan: "06-08"
    statement: "개발자 이름 값을 .planning·커밋 메시지·기록에 적지 않는다"
    llm_verdict: "판단 필요"
    evidence: "커밋 메시지 0. .planning에 더한 줄 1줄(06-EVIDENCE.md:1261, 값을 받기 전 구간의 대조 낱말). human_verification 3번"
  - plan: "06-08"
    statement: "06-08에서 값을 커밋하지 않는다"
    llm_verdict: "지켜짐"
    evidence: "06-08 문서 커밋 21ead38은 _data/company.yml을 바꾸지 않음. 값 커밋 S1(0c48a11)은 06-09"
  - plan: "06-09"
    statement: "승인받지 않은 SHA 푸시, --no-verify, force push, 이력 수정 금지"
    llm_verdict: "지켜짐 (비권위)"
    evidence: "PUSH1_APPROVED=PUSH1_SHA=e9d9443692b4, PUSH2_APPROVED=PUSH2_SHA=ae760273bf46=원격 main. e9d9443이 ae76027의 조상(선형). --no-verify 사용 여부는 기록만 있음"
  - plan: "06-09"
    statement: "커밋 메시지에 개발자 이름·사업자 값·지원 주소를 적지 않는다"
    llm_verdict: "지켜짐"
    evidence: "기준 이후 커밋 메시지에서 값 일곱 키 모두 0"
  - plan: "06-09"
    statement: "라이브 실패 시 원인부터 고치지 않고 먼저 되돌린다"
    llm_verdict: "해당 없음 (지켜짐)"
    evidence: "LIVE_PUSH1=OK, LIVE_PUSH2=OK. 검증자 재확인에서도 라이브 5개 URL이 200이고 HEAD 빌드와 바이트 동일"
  - plan: "06-10"
    statement: "시험 객체를 ref에 붙이거나 푸시하지 않는다"
    llm_verdict: "지켜짐 (비권위)"
    evidence: "남은 스크래치 ref는 refs/p6-scratch/{draft,push1,s2v} 셋(06-07·06-08·06-09 것). refs/heads·refs/tags 밖이라 푸시되지 않음"
  - plan: "06-10"
    statement: "삭제 안내 가드를 파일 전체 grep으로 쓰지 않는다"
    llm_verdict: "지켜짐"
    evidence: "check-site 8번이 .rp-doc 본문 블록만 본다. 검증자 음성 시험: 본문 mailto를 지운 사본에서 파일 전체 mailto=1(푸터)인데 8번은 실패"
  - plan: "06-11"
    statement: ".claude/CLAUDE.md 생성 구간을 손으로 고치지 않는다"
    llm_verdict: "지켜짐 (비권위, 리뷰 기록 기준)"
    evidence: "06-REVIEW.md가 임시 사본 재생성 결과와 바이트 동일이라고 적음. 검증자는 재생성을 다시 돌리지 않음"
  - plan: "06-11"
    statement: "문서에 개발자 이름 값을 적지 않는다"
    llm_verdict: "판단 필요"
    evidence: "기준 이후 .planning 밖 문서에 더한 줄 0. 두 CLAUDE.md에는 같은 글자가 기준 커밋 전부터 1곳씩 있음. human_verification 3번"
  - plan: "06-12"
    statement: "승인받지 않은 SHA 푸시, --no-verify, force push, 이력 수정 금지"
    llm_verdict: "지켜짐 (비권위)"
    evidence: "PUSH2_APPROVED=PUSH2_SHA=원격 main ae760273bf46. 그 뒤 로컬 커밋은 .planning만 바꾸고 푸시되지 않음"
  - plan: "06-13"
    statement: "정하지 않은 값이나 목록·공식 문서에 없는 사실을 적지 않는다"
    llm_verdict: "지켜짐 (비권위, 기록 기준)"
    evidence: "추가 문구마다 「Phase 6 D-33 ②」(18곳), D-39, D-40, D-24, 공식 문서 출처가 붙음"
  - plan: "06-13"
    statement: "기준 앱 커밋 줄·재확인 해시·앱 동작 문장·prod 전제 다섯 줄을 바꾸지 않는다"
    llm_verdict: "부분 확인 (비권위)"
    evidence: "a789cf96이 기준 앱 커밋 줄을 바꾸지 않음(바뀐 줄 0). 재확인 해시·prod 전제 다섯 줄은 줄 단위로 대조하지 않음"
  - plan: "06-13"
    statement: "데이터 목록·기록·커밋 메시지에 사업자 값·지원 주소·개발자 이름을 적지 않는다"
    llm_verdict: "지켜짐 (데이터 목록 기준)"
    evidence: "a789cf96은 데이터 목록 하나만 바꿈. 데이터 목록에 더한 줄에서 사업자 값·지원 주소·개발자 이름 0"
---

# Phase 6: 데이터 삭제 안내 재작성 (Data Deletion Rewrite) Verification Report

**Phase Goal:** 앱이 없는 사용자도 `/data-deletion/`에서 계정·데이터 삭제를 요청하는 방법과 무엇이 지워지고 무엇이 남는지 알 수 있고, Google Play 계정 삭제와 Facebook 데이터 삭제 안내 요건을 이 문서 하나로 충족한다
**Verified:** 2026-11-27T05:06:00Z
**Status:** human_needed
**Re-verification:** No — initial verification

## 요약

코드와 라이브 사이트로 확인한 결과, 목표는 이루어져 있습니다. 로드맵 성공 기준 2~5는 검증자 자신의 프로세스에서 확인했습니다. 방법은 HEAD를 운영과 같은 production·`--safe` 빌드로 만들기, 사실값 변형 빌드 두 개, 라이브 다섯 URL 바이트 비교입니다. 성공 기준 1은 내용과 위치는 맞지만 두 가지가 사람 확인으로 남습니다. 하나는 휴대폰 첫 화면에서 요청 방법이 충분히 눈에 띄는지이고, 다른 하나는 스토어 공개 표시와 개발자 이름이 같은지입니다. FAILED truth는 없습니다. 판단 단계 금지 사항 33건과, 개발자 이름 값 관련 truth 넷을 어떻게 읽을지는 사람 확인으로 남깁니다.

## Goal Achievement

### Observable Truths — 로드맵 성공 기준 (계약)

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| SC1 | 앱이 없는 사용자가 첫 화면에서 지원 이메일 삭제 요청 방법(메일에 적을 내용 포함)을 찾고, 스토어 앱 이름·개발자 이름이 있다 | ? UNCERTAIN | 내용: 본문 첫 요소가 소개 문단 「러닝펜슬(개발자 …)」(`store_developer_name` 값이 있을 때만)이고, 바로 다음이 `#request`다(① 앱 경로, ② 지원 이메일 mailto, 「메일에 적을 내용」 4항목, 본인 확인 문장). 출력 본문에 개발자 이름 1회, 본문 mailto 2개. 미확인: 375 폭 첫 화면에 mailto가 들어오는지(실행자 도구도 375는 h2만 판정), 스토어 공개 표시와 이름이 같은지(기록상 콘솔 화면만 대조) → human_verification 1·2 |
| SC2 | 지워지는·남는 데이터, 남는 이유·기간, 상한과 완료 알림을 읽고, 각 항목이 데이터 목록과 일치하며 포인트·굿즈·배송지·전자상거래가 없다 | ✓ VERIFIED | 「지워지는 데이터」 `li` 8개 = `DELETED_ITEMS=8`, 「남는 데이터」 표 7행 = `RETAINED_ROWS=7`(3열, `figure tabindex="0" aria-label`). 기간 칸 7개가 `PERIOD` 줄·데이터 목록 G 구간과 같은 글자. 상한 「요청을 받은 날부터 10일 안」, 답장 알림, 「지체 없이」, 첫 답장 「영업일 기준 3일」. 출력에서 U10 낱말 0, 「30일 이내」·「모든 개인정보」·「완전히」 0 |
| SC3 | 앱 안 경로가 「회원탈퇴」로 안내되고, 위치정보 동의 철회 시 개인위치정보·확인자료 파기 안내가 있다 | ✓ VERIFIED | `<strong>설정 → 내 계정 → 회원탈퇴</strong>`(데이터 목록 「앱 안 메뉴 이름은 회원탈퇴」). `#location`에 철회 경로 넷(이메일 항목은 값이 있을 때만), 「위치정보 동의를 철회하면(2~4번) 해당 개인위치정보와 위치정보 수집·이용·제공사실 확인자료를 지체 없이 파기합니다」, 「6개월」 보관, 「앱에는 위치정보 동의만 따로 끄는 설정이 없습니다」 |
| SC4 | `#facebook`·`#google`·`#apple`·`#kakao`·`#naver`·`#line`이 해당 섹션으로 바로 이동 | ✓ VERIFIED | 라이브 출력 전체에서 id가 각 1개(`request location google apple facebook kakao naver line` 순서), 모두 `<section id>`이고 첫 자식이 제공자 이름이 든 `h2`다. 페이지에 스크립트 0개, `position: sticky/fixed` 헤더 0개라 브라우저 기본 조각 이동을 막는 것이 없다. 라이브 바이트가 HEAD 빌드와 같다 |
| SC5 | 사업자 정보·연락처를 `_data/company.yml`에서 읽고 본문에 값을 쓰지 않으며, 값 없는 선택 항목은 표시하지 않는다 | ✓ VERIFIED | 원본 `data-deletion/index.html`에 사실값 글자 0, 모든 출력이 `site.data.company.<키>.size > 0`과 `| escape`를 거친다. `phone` 빈 값 → 전화 행 0. 변형 A(전화·개발자 이름에 `<b>&` 같은 특수 문자) → 각 1회, 이스케이프됨, 날 태그 0. 변형 B(개발자 이름·지원 주소·상호·주소 빈 값) → 소개 문단·②·문의처·본문 mailto 0, 자리표시 0 |

**로드맵 점수:** 4/5 VERIFIED, 1 UNCERTAIN

### Observable Truths — 계획 must_haves (추가 세부)

분류 기준: 검증자 프로세스에서 다시 확인한 것과 git 이력으로 증명되는 것은 VERIFIED. 실행자 기록(`06-EVIDENCE.md`)으로만 뒷받침되는 앱 저장소 사실·사람 결정·스크래치 도구 실행은 UNCERTAIN(사람 확인)입니다.

| Plan | # | Truth (요지) | Status | Evidence |
|------|---|--------------|--------|----------|
| 06-01 | 1 | `06-EVIDENCE.md`에 공개 저장소 규칙, `BASE_SHA`·`BASE_LIVE`, 두 커밋의 `.planning` 밖 트리가 같음 | ✓ VERIFIED | 머리 규칙 있음, `BASE_SHA=89f659a5fdca`, `BASE_LIVE=e0f233169329`, `.planning` 밖 차이 0파일 |
| 06-01 | 2 | 기준 출력의 제목·검색 제외·임시 표시·U10·mailto·앵커 수 | ✓ VERIFIED | 검증자가 `bash scripts/check-site.sh 89f659a5fdca`를 실행: 기준 출력에 검색 제외·임시 표시가 있고, 본문 mailto 없음, U10 6곳(6번 정규식). 기록의 7은 6번 정규식에 없는 「수령인」 1을 더한 값(기준 원본에 1회). 원본 `section id` 0 |
| 06-01 | 3 | 앱 읽기만 함, `APP_BASE`·`runs-delete-callers=0` 기록 | ? UNCERTAIN | 표식은 있음(`APP_BASE` 1, `runs-delete-callers=0` 2). 앱 저장소 쪽은 확인 못 함 |
| 06-01 | 4 | Playwright 1.59.1은 승인 뒤에만 설치 | ? UNCERTAIN | 과정 기록만 있음 |
| 06-01 | 5 | `p6-deletion.mjs` 음성 FAIL·양성 PASS | ? UNCERTAIN | 기록(FAIL 줄·PASS 줄) 있음. 스크래치 도구가 남아 있지 않아 다시 돌리지 못함 |
| 06-02 | 1 | `OK fact F1`~`F6` 줄 | ✓ VERIFIED | 6줄 |
| 06-02 | 2 | 구간 D·G 연결 해제 여섯 제공자, `disconnect_steps.dart` 근거 | ✓ VERIFIED | 데이터 목록 3곳, G 구간 「제공자 쪽 앱 연결 (여섯 제공자)」 행 |
| 06-02 | 3 | 구간 C 기록 행·구간 A·H 익명 행 정정 | ✓ VERIFIED | 데이터 목록 195행 「찾지 못했다」. C 행은 이후 06-04 재기준으로 다시 고쳐짐 |
| 06-02 | 4 | 정정 커밋은 기준 앱 커밋 줄을 바꾸지 않음 | ✓ VERIFIED | 06-02 정정 커밋 `ea0a0d7`의 데이터 목록 diff에서 `**기준 앱 커밋:**` 줄 변경 0. 재기준은 06-04 `aeb6f446` |
| 06-02 | 5 | U6-가·U6-나·N3 결정, U2가 Phase 6을 막음, ROADMAP 앱 작업 묶음 행 | ✓ VERIFIED | DECISIONS.md 해당 낱말 있음. ROADMAP External Gates 422·426행 |
| 06-03 | 1 | 앱 작업 요청서 | ✓ VERIFIED | `## 06-03 앱 작업 요청` 구간 |
| 06-03 | 2 | installation ID를 사용자가 고름 | ? UNCERTAIN | `INSTALL_ID=keep-out` 표식 있음. 누가 골랐는지는 기록만 있음 |
| 06-03 | 3 | 앱 커밋 해시와 경로를 받기 전에 끝나지 않음 | ✓ VERIFIED | `APP_WORK_HEAD=92e986c3bb29`와 경로 기록 |
| 06-03 | 4 | ⑥ 보고 `DEL06_REPORT=conform` | ✓ VERIFIED | 표식 있음 |
| 06-04 | 1 | AW가 있고 경로 18개가 차이에 있음 | ? UNCERTAIN | 앱 저장소 사실 |
| 06-04 | 2 | 항목 ①②③⑤⑥ 앱 사실 | ? UNCERTAIN | `OK app item` 11줄, `APP_FACTS=OK`. 앱 코드는 확인 못 함 |
| 06-04 | 3 | 앱 화면 사실(라벨·메뉴 문구 7개 등) | ? UNCERTAIN | 앱 코드 사실. 사이트 문구는 데이터 목록 글자와 같음 |
| 06-04 | 4 | 데이터 목록 재기준(`REBASE_SHA`), U2 「초안으로 진행」, U6-나 「앱 반영됨」 | ✓ VERIFIED | 기준 앱 커밋 `92e986c3`, `### prod 전제 (Phase 6 D-42)`, 확인자료 184일·6개월 행, Analytics 「최대 14개월 (설정 미확인」, DECISIONS 두 낱말 |
| 06-04 | 5 | 정하지 않은 것을 적지 않음, 사이트 파일 안 고침 | ✓ VERIFIED | `aeb6f446`은 DATA-INVENTORY·DECISIONS 둘만 바꿈 |
| 06-05 | 1 | 작업 13과 한눈에 보기 행, 앱 문서 `docs/operator-delete-tool.md` 참조 | ✓ VERIFIED | 「작업 13」 2곳, 참조 1곳 |
| 06-05 | 2 | dry-run → `--apply` → 1시간 뒤 재확인, 10일·지체 없이·영업일 3일, 옛 30일 없음 | ✓ VERIFIED | 각 낱말 있음, 작업 13 구간 「30일」 0 |
| 06-05 | 3 | 요청 두 종류 = `account`·`records`, 옛 범위 이름 없음 | ✓ VERIFIED | 「위치 기록만」 0 |
| 06-05 | 4 | 본인 확인과 이메일 없는 계정·「이메일 가리기」 대체 확인 | ✓ VERIFIED | 「가리기」 2곳 |
| 06-05 | 5 | 탈퇴 정리 실패 로그 재처리, `OPS_FAILLOG=included` | ✓ VERIFIED | Cloud Logging 단계, 표식 있음 |
| 06-05 | 6 | 「안내에 따라 직접 해제해 주세요」, Meta 21일·60일 | ✓ VERIFIED | 3곳, 각 1곳 |
| 06-05 | 7 | prod 준비는 「### prod 전제 (Phase 6 D-42)」를 가리키는 한 줄 | ✓ VERIFIED | 1곳 |
| 06-06 | 1 | 대조표, 목록 행 수 = 대조표 행 수 | ✓ VERIFIED | `## 06-06 대조표` 구간 표 데이터 행을 검증자가 셈: 33행 = `TABLE_ROWS=33` (지워짐 10, 남음 5, 결정 필요 10, 표 밖 8) |
| 06-06 | 2 | 결정된 행이 사용자 결정 그대로 | ✓ VERIFIED | 사이트 표·데이터 목록에 「지워짐」(공개하지 않은 코스·확인자료), 「7일 안」, 「최대 14개월」, 「90일이 지나면 지우기 시작」, 「삭제 뒤 180일 안」, 공개 코스 「서비스를 운영하는 동안」 |
| 06-06 | 3 | 익명 문장을 사용자가 고름 (`OK anon facts in inventory`) | ? UNCERTAIN | 표식 `D33_C7=ga`와 `OK anon` 줄은 있음. 고른 과정은 기록만 있음 |
| 06-06 | 4 | D-33 ②·D-39·표 범위를 사용자가 정함 | ? UNCERTAIN | 표식 8개는 있음. 과정은 기록만 있음 |
| 06-06 | 5 | 이 계획은 `06-EVIDENCE.md`만 고침 | ✓ VERIFIED | `2a5b18f`는 EVIDENCE·SUMMARY 둘만 바꿈 |
| 06-07 | 1 | front matter, 검색 제외·임시 표시 없음 | ✓ VERIFIED | title·eyebrow 그대로, heading·description·updated 있음, 출력 noindex 0·임시 0 |
| 06-07 | 2 | 소개 문단 → `#request`(① 경로·5분·건너뛸 수 있음, ② mailto·4항목·본인 확인·직접 해제 문장) | ✓ VERIFIED | 원본 9~32행 |
| 06-07 | 3 | 10일 상한, 답장 알림, 지체 없이, 영업일 3일 | ✓ VERIFIED | 원본 38행 |
| 06-07 | 4 | 항목 수·행 수 = 확정본, 기간 칸 = `PERIOD`, 공개하지 않은 코스·확인자료 지워짐, 3열 표 | ✓ VERIFIED | 8 = 8, 7 = 7, 기간 7/7 |
| 06-07 | 5 | 일부만 지우기 메뉴 문구 | ✓ VERIFIED | 「코스 삭제」·「더보기」·「뱃지 삭제」·「기록 삭제」·「데이터 관리」·「뱃지와 기록 모두 삭제」·「올린 사진 삭제」가 데이터 목록에 있음 |
| 06-07 | 6 | `#location` 철회 경로 넷·파기 문장·6개월·설정 없음 | ✓ VERIFIED | 원본 125~138행, 「184」 0 |
| 06-07 | 7 | 제공자 섹션 여섯이 같은 틀, 보장 표현 없음 | ✓ VERIFIED | 순서 google→line, 섹션마다 받는 항목·`#request` 링크·직접 해제. 「보장」 0 |
| 06-07 | 8 | 사실값은 `site.data.company`, 가짜 값 변형 | ✓ VERIFIED | 검증자 변형 빌드 A·B (SC5) |
| 06-07 | 9 | 두 엔진 × 375·1280 첫 화면·앵커·넘침·콘솔 오류 없음, 사용자 승인 | ? UNCERTAIN | 실행자 Playwright 기록과 승인 표식만 있음 (human_verification 1·5) |
| 06-08 | 1 | 가짜 이름으로 값 커밋·재작성 미리보기 시험 | ? UNCERTAIN | 스크래치 기록만 있음 |
| 06-08 | 2 | 누출 점검 양성 시험 `leak-probe hit tree=1 diff=1` | ? UNCERTAIN | 기록만 있음. 실제 값에는 `excluded=1`로 점검을 건너뜀 |
| 06-08 | 3 | 값은 `store_developer_name` 한 줄에만 있고 `.planning`·메시지·기록에 없음 | ? UNCERTAIN | 메시지 0. `.planning`에 같은 글자가 든 줄 1개 추가(값을 받기 전 구간) → human_verification 3 |
| 06-08 | 4 | 실제 값 미리보기 통과, 값 커밋 안 함 | ✓ VERIFIED | 06-08 커밋 `21ead38`은 company.yml을 안 바꿈. S1 출력은 새 키만 더해 사이트 출력에 영향 없음 |
| 06-09 | 1 | S1은 company.yml만(키 줄+주석 한 줄), S2는 data-deletion만, S2 = 승인 원고 blob(+updated) | ✓ VERIFIED | S1 `0c48a11` 2줄 추가, S2 `e9d9443` 1파일, 원고 blob `b681410f…`와 S2 파일 diff 0 |
| 06-09 | 2 | S2 출력에 noindex·임시·U10 없음, 본문 mailto·앵커 여덟, 다른 문서 불변 | ✓ VERIFIED | 검증자 빌드: 0·0·0, 본문 mailto 2, id 8개 |
| 06-09 | 3 | 푸시 전 사용자 대조·SHA 승인, 승인 전 main 커밋 없음 | ? UNCERTAIN | `PUSH1_APPROVED=PUSH1_SHA` 표식만 있음 |
| 06-09 | 4 | Task 1~3에서 커밋을 만들지 않음 | ? UNCERTAIN | 과정 기록만 있음 |
| 06-09 | 5 | 라이브 5개 URL 200·제목·바이트 동일, 앵커 여덟 | ✓ VERIFIED | 검증자 재확인(현재 라이브 = HEAD 빌드, 바이트 동일) |
| 06-09 | 6 | 푸시 범위의 메시지·`.planning`에 개발자 이름 값 없음 | ? UNCERTAIN | 메시지 0. `.planning` 1줄(21ead38이 첫 푸시 범위에 들어감) → human_verification 3 |
| 06-09 | 7 | 막는 것이 모두 닫힌 뒤에만 후보를 만듦 | ✓ VERIFIED | `APP_WORK_HEAD`·`REBASE_SHA`·U2 「초안으로 진행」·`D33_*`·`DEV_RECEIVED`·`DEL06_REPORT` 표식이 모두 S2보다 앞선 커밋에 있음 |
| 06-10 | 1 | 6번이 랜딩·삭제 안내 둘 다 막음, 허용 낱말·grep 오류 처리 그대로 | ✓ VERIFIED | `for f in index.html data-deletion/index.html`, `u10_rc -gt 1` |
| 06-10 | 2 | 8번이 본문 블록에서 mailto·소개 문단, 문서에서 noindex·임시 없음, grep 오류 = 실패 | ✓ VERIFIED | 코드 읽음. 검증자 음성 시험(본문 mailto 제거 → 8번 실패, 파일 전체로는 거짓 통과) |
| 06-10 | 3 | 현재 통과·기준 실패·음성 다섯 각각 한 건 실패 | ✓ VERIFIED (음성 4/5는 기록 기준) | 검증자 실행: 현재 작업 트리 `check-site: 통과`, 기준 커밋 `89f659a5fdca`는 `실패 — 5건`(6번 1, 8번 4). 음성 다섯 가운데 본문 mailto 제거만 검증자가 재현했고, 나머지 넷(개발자 이름 빈 값, noindex, 임시 표시, U10)은 코드 경로 읽기와 실행자 기록 기준 |
| 06-10 | 4 | `.githooks/pre-push`가 B1 통과, 음성 거부 | ✓ VERIFIED | `core.hooksPath=.githooks`, 훅이 `check-site.sh "$local_sha"`를 부름. 거부 실행은 기록 기준 |
| 06-10 | 5 | B1은 check-site 하나만, S2 라이브 뒤 | ✓ VERIFIED | `45f1958` 1파일, S2의 자손 |
| 06-11 | 1 | 원본 맵이 현재 모습을 적음 | ✓ VERIFIED | CONVENTIONS·ARCHITECTURE·STACK에 `store_developer_name`, 점검 8번, 소개 문단 규칙 |
| 06-11 | 2 | 두 CLAUDE.md 방침 구간이 같음, 생성 구간 재생성 | ✓ VERIFIED | 방침 구간 diff 0(추출 경계 표식 제외). 재생성 동일은 06-REVIEW 기록 |
| 06-11 | 3 | 이름 표 「스토어 개발자 이름」 행, 데이터 목록 「확인할 것」 prod 행 | ✓ VERIFIED | NAMES.md 21행(값 칸 빈칸), DATA-INVENTORY 376행 |
| 06-11 | 4 | 문서와 기록에 개발자 이름 값·사업자 값·지원 주소·로컬 경로 없음 | ? UNCERTAIN | `.planning` 밖에 더한 줄 0. 두 CLAUDE.md에 같은 글자가 기준 전부터 있음 → human_verification 3 |
| 06-12 | 1 | 둘째 푸시 `.planning` 밖 변경 넷, 출력 = S2 | ✓ VERIFIED | e9d9443..ae76027 `.planning` 밖: check-site.sh, CLAUDE.md, .claude/CLAUDE.md, README.md. 현재 라이브 = HEAD 빌드 |
| 06-12 | 2 | 새 점검·훅 통과, 푸시 범위에 개발자 이름 값·로컬 경로 없음 | ? UNCERTAIN | 점검 통과는 확인. 값 문장은 human_verification 3 |
| 06-12 | 3 | 승인한 SHA 푸시, 라이브 200·제목·바이트, 앵커 | ✓ VERIFIED | `PUSH2_APPROVED=PUSH2_SHA=origin/main=ae760273bf46`, 검증자 라이브 재확인 |
| 06-13 | 1 | 대조표 확정, `RETAINED_ROWS`·`DELETED_ITEMS` | ✓ VERIFIED | `## 06-13 대조표 확정` 구간을 검증자가 셈: 33행(지워짐 10, 남음 7, 표 밖 16, 결정 필요 0). 남음 7 = `RETAINED_ROWS`, 지워짐 10행은 사이트의 8범주(`DELETED_ITEMS=8`)로 묶임 |
| 06-13 | 2 | `PERIOD`·`INUSE` 줄 | ✓ VERIFIED | `PERIOD` 7, `REASON` 1, `INUSE` 1 |
| 06-13 | 3 | `INV_DEC_SHA` 목록에 문구·출처·prod 전제 덧붙임, 원고·S2보다 앞섬 | ✓ VERIFIED | `a789cf96`, 「Phase 6 D-33 ②」 18곳, S2의 조상 |
| 06-13 | 4 | 새 결정 없음, 기준 앱 커밋 줄 그대로 | ✓ VERIFIED | `a789cf96`은 데이터 목록 하나만, 기준 줄 변경 0 |

**계획 truth 점수:** 49/67 VERIFIED, 18 UNCERTAIN, FAILED 0
**전체 점수:** 53/72 (FAILED 0, UNCERTAIN 19 → 모두 Human Verification으로)

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `data-deletion/index.html` | 재작성한 삭제 안내 (DEL-01~07) | ✓ VERIFIED | 198줄. 허용 요소만 사용, `class`·`style` 0, 앵커 여덟, 출력 = 라이브 |
| `_data/company.yml` | 키 `store_developer_name` | ✓ VERIFIED | 키 일곱, 개발자 이름 값 있음(길이만 확인), `phone` 빈 값 |
| `scripts/check-site.sh` | 6번 확장, `# ── 8. 삭제 안내` | ✓ VERIFIED | 작업 트리 통과, 본문 블록 추출이 푸터 앞에서 끊김(170줄, `rp-foot` 0) |
| `.planning/baseline/DATA-INVENTORY.md` | 재기준 목록, prod 전제 절, D-33 ② | ✓ VERIFIED | 기준 앱 커밋 92e986c3, 338행 prod 전제 |
| `.planning/baseline/USER-TASKS.md` | 작업 13 | ✓ VERIFIED | 364행 |
| `.planning/baseline/DECISIONS.md` | U6-가, 초안으로 진행 | ✓ VERIFIED | |
| `.planning/baseline/NAMES.md` | 스토어 개발자 이름 행 | ✓ VERIFIED | 값 칸 빈칸 |
| `.planning/codebase/CONVENTIONS.md`, `CLAUDE.md` | 키 목록·방침 갱신 | ✓ VERIFIED | |
| `06-EVIDENCE.md` | 판정 기록 | ✓ VERIFIED | `verify.artifacts` 13개 계획 모두 all_passed |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `data-deletion/index.html` | `_data/company.yml` | `site.data.company.*` + `.size > 0` + `escape` | ✓ WIRED | 변형 빌드로 데이터 흐름 확인 |
| `.githooks/pre-push` | `scripts/check-site.sh` | 푸시할 SHA 점검 | ✓ WIRED | `core.hooksPath=.githooks` |
| `scripts/check-site.sh` 8번 | `data-deletion/index.html` | 본문 mailto·소개 문단·noindex 없음 | ✓ WIRED | 음성 시험 실패 확인 |
| DATA-INVENTORY | data-deletion | 기간·메뉴·설정 문장 글자 | ✓ WIRED | 문구 대조 |
| USER-TASKS | data-deletion / DATA-INVENTORY | 10일 상한, prod 전제 참조 | ✓ WIRED | `verify.key-links` 통과 |
| 06-EVIDENCE 표식 6건 (`^BASE_SHA=`, `^APP_WORK_HEAD=`, `^APP_FACTS=OK$`, `^D33_C7=`, `^DRAFT_BLOB=`, `^\*\*기준 앱 커밋:\*\*`) | 각 대상 | 표식 줄 | ✓ WIRED | `verify.key-links`가 `^` 패턴을 파일 맨 앞으로만 읽어 실패로 냈지만(거짓 음성), 줄 단위 grep에서 각 1줄 확인 |

### Data-Flow Trace (Level 4)

| Artifact | Data Variable | Source | Produces Real Data | Status |
|----------|---------------|--------|--------------------|--------|
| 소개 문단 | `store_developer_name` | `_data/company.yml` | 예(출력 본문 1회) | ✓ FLOWING |
| `#request` ②, 문의처 | `support_email` | `_data/company.yml` | 예(본문 mailto 2) | ✓ FLOWING |
| 문의처 | `trade_name`, `address` | `_data/company.yml` | 예(각 1회) | ✓ FLOWING |
| 문의처 전화 | `phone` | `_data/company.yml` (빈 값) | 값 없음 → 행 숨김 (변형 A에서 그려짐) | ✓ FLOWING (render-if-present) |

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| 푸시 전 점검 | `bash scripts/check-site.sh` | `check-site: 통과 (작업 트리, jekyll 3.10.0)` | ✓ PASS |
| 기준 커밋은 거부 | `bash scripts/check-site.sh 89f659a5fdca` | `실패 — 5건` (U10 6곳, 본문 mailto 없음, 소개 문단 없음, noindex, 임시 표시) | ✓ PASS |
| 운영 동일 빌드 | `JEKYLL_ENV=production jekyll build --safe` (스크래치) | exit 0, 제목 일치, noindex 0, 임시 0, U10 0, id 8 | ✓ PASS |
| 라이브 = HEAD | `curl` 5개 URL + `cmp` | 5/5 200, 기대 제목, 바이트 동일 | ✓ PASS |
| render-if-present·escape | 변형 빌드 A·B (스크래치 사본의 `_data`만 바꿈) | A: 전화·이름 각 1회 이스케이프 / B: 숨김 | ✓ PASS |
| 8번 가드 음성 | 본문 mailto 제거 사본 | 파일 전체 mailto 1인데 본문 0 → 실패 | ✓ PASS |
| 첫 화면·앵커 위치 | Playwright | 패키지 없음(설치는 승인 필요) | ? SKIP → human |

### Probe Execution

해당 없음. 이 저장소에는 `scripts/*/tests/probe-*.sh`가 없고, 계획도 probe를 선언하지 않습니다.

### Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| DEL-01 | 06-01, 05, 07, 09, 10, 12 | 앱 없이 지원 이메일 삭제 요청 방법을 눈에 띄게 찾음 | ✓ SATISFIED (첫 화면 판단은 human 1) | `#request` ②, 본문 mailto, 8번 가드 |
| DEL-02 | 06-07, 08, 09, 10, 11 | 스토어 앱 이름·개발자 이름 | ? NEEDS HUMAN | 소개 문단 있음, 스토어 공개 표시 대조 미확인 (human 2) |
| DEL-03 | 06-02, 03, 04, 06, 07, 09, 10, 11, 13 | 지워지는·남는 데이터, 이유·기간 | ✓ SATISFIED | 8항목·7행, 데이터 목록과 글자 일치 |
| DEL-04 | 06-04, 07, 09 | 「회원탈퇴」 경로 | ✓ SATISFIED | `설정 → 내 계정 → 회원탈퇴` |
| DEL-05 | 06-03, 05, 07, 09, 13 | 상한과 완료 알림 | ✓ SATISFIED | 10일 안·답장·지체 없이·영업일 3일 |
| DEL-06 | 06-03, 04, 05, 07, 09, 13 | 철회 시 개인위치정보·확인자료 파기 | ✓ SATISFIED | `#location` 파기 문장 |
| DEL-07 | 06-01, 02, 07, 09, 12 | 제공자 섹션 앵커 | ✓ SATISFIED | id 여섯(+request·location) |
| BIZ-05 | 06-01, 07, 08, 09, 10, 11, 12 | 사실값을 `_data` 한 곳에서 읽음 | ✓ SATISFIED | 변형 빌드 A·B |

REQUIREMENTS.md가 Phase 6에 매핑한 ID는 위 여덟 개뿐이고, 모두 계획 frontmatter에 있습니다. ORPHANED 요구사항은 없습니다.

### Decision Coverage

All trackable CONTEXT.md decisions are honored by shipped artifacts.

`check.decision-coverage-verify` 결과: 41/41 반영, 미반영 0. 이 게이트는 상태 판정에 영향을 주지 않습니다.

### Test Quality Audit

| Test File | Linked Req | Active | Skipped | Circular | Assertion Level | Verdict |
|-----------|-----------|--------|---------|----------|-----------------|---------|
| (없음) | — | — | — | — | — | N/A |

이 저장소에는 테스트 러너와 테스트 파일이 없습니다(CLAUDE.md: no test runner). 요구사항을 지키는 자동 점검은 푸시 전 점검 `scripts/check-site.sh`(6·8번)이고, 실행자의 Playwright 도구 `p6-deletion.mjs`는 저장소 밖 스크래치에 있었습니다. 건너뛴 테스트·순환 테스트 패턴은 해당이 없습니다. 8번 점검의 기대값은 시스템 출력이 아니라 고정 문자열(`href="mailto:`, `러닝펜슬(개발자 `, `name="robots"`, `임시 게시본`)이라 순환이 아닙니다.

**Disabled tests on requirements:** 0
**Circular patterns detected:** 0
**Insufficient assertions:** 0 (8번 mailto 검사가 `#request`가 아닌 본문 전체를 보는 점은 WR-02 경고로 따로 적음)

### Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `scripts/check-site.sh` | 45 | `XXX` (mktemp 템플릿 `rp-check.XXXXXX`) | ℹ️ Info | 부채 표시가 아니라 mktemp 인자. 이 단계 이전부터 있던 줄이다. 부채 표시 게이트 대상 아님 |
| `scripts/check-site.sh` | 8번 awk | 종료 줄(16칸 `</div>`)을 못 찾으면 푸터까지 읽음 (06-REVIEW WR-01, open) | ⚠️ Warning | 레이아웃 들여쓰기가 바뀌면 거짓 통과할 수 있다. 현재 출력에서는 정상 동작 |
| `scripts/check-site.sh` | 8번 | mailto를 `#request`가 아니라 본문 어디서나 셈 (WR-02, open) | ⚠️ Warning | 요청 조항 mailto가 빠지고 문의처 mailto만 남아도 통과 |
| `scripts/check-site.sh` | — | 고정 앵커 여덟의 존재를 점검하지 않음 (WR-03, open) | ⚠️ Warning | 콘솔에 등록하는 `#facebook` 등이 빠져도 푸시가 막히지 않음 |
| `data-deletion/index.html` | 17, 136, 143… | `support_email`이 비면 「(2~4번)」·외톨이 ①·「지원 이메일로」 무조건 문장이 어긋남 (WR-04, open) | ⚠️ Warning | 현재 값이 있고 8번이 본문 mailto 없는 푸시를 막으므로 라이브에는 영향 없음 |
| `data-deletion/index.html` | 142, 149, 156 | Google·Apple·Facebook 받는 항목에 회원번호 없음 (06-07 열린 항목 2) | ⚠️ Warning | 데이터 목록 B 구간과는 같다. 목록 A 구간 `linkedProviders`와의 목록 내부 어긋남이고, Phase 7(PRIV-10)에서 다룬다 |
| `data-deletion/index.html` | 186 | 값 바로 뒤 「입니다」 | ℹ️ Info | 받침과 관계없는 서술격 표현이고, 지원 페이지(Phase 5)와 같은 꼴 |
| `.planning/…/06-VALIDATION.md` | 71 | 「D-02·D-18」 행 판정 식이 기준 커밋에서도 빈 출력이 아님 | ℹ️ Info | human_verification 3과 함께 정한다 |
| 로컬 ref `refs/p6-scratch/{draft,push1,s2v}` | — | 값이 든 로컬 객체 | ℹ️ Info | 푸시되지 않음. 06-12 SUMMARY 「후속 항목」대로 사용자가 지운다 |

TBD·FIXME·XXX 부채 표시(위 mktemp 제외)와 자리표시 문구는 이 단계가 바꾼 사이트 파일에 없습니다.

### Human Verification Required

1. **휴대폰 첫 화면에서 요청 방법 찾기 (SC1, DEL-01)**
   - **Test:** 실기기 휴대폰으로 `/data-deletion/`을 처음 연다.
   - **Expected:** 첫 화면에 「삭제 요청 방법」이 있고, 조금만 내리면 ② 지원 이메일 경로와 「메일에 적을 내용」이 나온다. 이것으로 「첫 화면에서 찾는다」를 충족하는지 판단한다.
   - **Why human:** 시각 판단이다. 375 폭에서 mailto 위치는 도구로도 판정하지 않았다.

2. **스토어 공개 표시와 개발자 이름 대조 (SC1, DEL-02)**
   - **Test:** Google Play·App Store 공개 등록정보의 개발자·판매자 이름을 소개 문단과 대조한다.
   - **Expected:** 글자까지 같다.
   - **Why human:** 저장소 밖 값이다. 기록상 콘솔 화면만 봤다.

3. **개발자 이름 값 truth 넷의 판정 (06-08 #3, 06-09 #6, 06-11 #4, 06-12 #2)**
   - **Test:** 아래 사실을 보고 (가) 받아들이기(override) 또는 (나) 해당 낱말을 지우는 문서 커밋 가운데 고른다.
   - **사실:** 기준 이후 `.planning`에 더한 줄 가운데 값과 같은 글자가 든 줄은 1줄(`06-EVIDENCE.md:1261`, `21ead38`)이다. 그 줄은 값을 받기 전 구간 「## 06-08 시험 실행」에 있는 대조 낱말이다. 같은 글자는 기준 커밋 전부터 추적 파일 여러 곳에 있었고, 그래서 실행자의 누출 점검은 실제 값에 대해 돌지 않았다. 커밋 메시지와 `.planning` 밖 문서에 새로 더한 줄은 0이다.
   - **Why human:** truth 문장을 글자 그대로 읽을지 「받은 값을 새로 적지 않음」으로 읽을지는 판단이다.
   - (가)를 고르면 이 파일 frontmatter에 다음을 더하고 다시 검증한다:
     ```yaml
     overrides:
       - must_have: "푸시 범위의 메시지와 .planning에 개발자 이름 값이 없다"
         reason: "기준 이후 더한 줄 가운데 같은 글자가 든 줄은 값을 받기 전에 쓴 대조 낱말 1줄뿐이고, 같은 글자는 기준 커밋 전부터 추적 파일에 공개돼 있었다. 받은 값을 새로 적은 줄은 없다"
         accepted_by: "{이름}"
         accepted_at: "{ISO 시각}"
     ```

4. **앱 저장소 사실 (06-01 #3, 06-04 #1·#2·#3)**
   - **Test:** 앱 저장소 AW(`92e986c3bb29`)에서 읽기 전용으로 확인하거나 기록을 받아들인다.
   - **Expected:** 기록의 앱 사실이 AW 코드와 같다.
   - **Why human:** 이 저장소에 앱 코드가 없다.

5. **사람 결정·승인 이력 (06-01 #4·#5, 06-03 #2, 06-06 #3·#4, 06-07 #9, 06-08 #1·#2, 06-09 #3·#4)**
   - **Test:** 결정과 승인을 사용자가 직접 했는지 기억과 기록으로 확인한다.
   - **Expected:** 표식과 같다.
   - **Why human:** 과거 대화와 스크래치 실행은 저장소에 증거가 없다.

6. **판단 단계 금지 사항 33건 (`prohibitions_flagged`)**
   - **Test:** 항목마다 검증자 판정(비권위)과 근거를 보고 해결로 둘지 정한다.
   - **Expected:** 「판단 필요」 셋(06-04 값 문장, 06-08 값 문장, 06-11 값 문장)은 3번과 함께 정하고, 「확인 불가」는 4·5번과 함께 정한다.
   - **Why human:** 판단 단계 금지 사항은 조용히 통과로 셀 수 없다.

### Gaps Summary

목표를 막는 빈틈(FAILED)은 없습니다. 라이브 `/data-deletion/`은 HEAD 빌드와 바이트까지 같습니다. 앱 없는 사용자의 지원 이메일 요청 경로, 지워지는·남는 데이터와 기간, 10일 상한과 답장 알림, 「회원탈퇴」, 위치정보 철회 시 파기, 제공자 앵커 여섯, `_data` 기반 render-if-present가 모두 코드와 출력에 있습니다.

`passed`가 아닌 이유는 사람 확인이 남았기 때문입니다.
- 성공 기준 1의 두 부분: 휴대폰 첫 화면 판단, 스토어 공개 표시 대조
- 개발자 이름 값 「없음」 truth 넷의 판정
- 앱 저장소 사실과 사람 결정 이력은 실행자 기록으로만 뒷받침됨
- 판단 단계 금지 사항 33건

점검 스크립트의 견고성 경고 4건(WR-01~04)은 open 상태입니다. 라이브 목표를 막지는 않지만, 앞으로의 푸시가 앵커나 요청 경로를 잃어도 막히지 않을 수 있으니 후속 처리를 권합니다.

---

_Verified: 2026-11-27T05:06:00Z_
_Verifier: Claude (gsd-verifier)_
