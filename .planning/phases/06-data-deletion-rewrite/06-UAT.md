---
status: complete
phase: 06-data-deletion-rewrite
source: [06-VERIFICATION.md]
started: 2026-11-27T05:12:59Z
updated: 2026-11-27T07:43:40.670Z
---

## Current Test

[testing complete]

## Tests

### 1. 실기기 휴대폰(375px 안팎)에서 https://runningpencil.com/data-deletion/ 을 처음 연다
expected: 첫 화면에서 「삭제 요청 방법」 조항을 찾을 수 있고, 조금만 내리면 「② 앱 없이 지원 이메일로 요청하기」와 mailto 링크, 「메일에 적을 내용」 목록이 나온다. 이것이 성공 기준 1의 「문서 첫 화면에서 찾는다」와 DEL-01의 「눈에 띄게」를 충족하는지 사람이 판단한다
result: pass

### 2. Google Play와 App Store의 공개 등록정보(스토어 페이지)에 보이는 개발자·판매자 이름을 라이브 삭제 안내 소개 문단의 개발자 이름과 대조한다
expected: 두 스토어의 공개 표시와 소개 문단의 이름이 글자까지 같다 (성공 기준 1, DEL-02)
result: pass
note: "두 스토어 모두 앱을 아직 등록하지 않아 공개 등록정보가 없다(2026-11-27 확인: Google Play details·개발자 페이지 404, iTunes lookup·검색 0건). 사용자 지시로 콘솔 등록값과 대조했다: Google Play Console 개발자 계정의 「개발자 이름」(조직 계정)과 Apple Developer 멤버십의 「법인명」(조직 계정. Apple 문서 developer.apple.com/programs/enroll: 조직 이름이 App Store 판매자 이름으로 표시됨)이 라이브 /data-deletion/ 소개 문단과 `store_developer_name` 값과 글자까지 같다. 값은 D-02에 따라 이 파일에 적지 않는다. App Store Connect는 이용약관 동의 창이 떠 있어 들어가지 않았다(동의는 사용자 몫). 출시 뒤 공개 페이지 재확인은 Phase 10 체크리스트에서. 판정 기록: 사용자가 「양 스토어 콘솔에 들어가서 확인해보자」로 대조를 맡겼고, Claude가 대조 결과로 pass를 기록한 뒤 사용자에게 알렸으며 사용자는 이의 없이 다음 테스트로 넘어갔다. 이 pass는 expected가 적은 공개 등록정보가 아니라 콘솔 등록값에 근거한다."

### 3. 개발자 이름 값 「.planning·기록에 없음」 truth 넷(06-08 #3, 06-09 #6, 06-11 #4, 06-12 #2)과 06-VALIDATION.md 「D-02·D-18」 행을 어떻게 읽을지 정한다
expected: 사용자가 (가) 기준 이전부터 추적 파일에 있던 글자이고 값을 받기 전에 쓴 대조 낱말이라 받아들인다(아래 override 제안), 또는 (나) 06-EVIDENCE.md:1261의 해당 낱말을 지우는 문서 커밋을 낸다 가운데 하나를 고른다
result: pass
note: "사용자가 (가)를 골랐다(Claude가 (가)를 권함: 해당 줄은 값을 받기 전 grep 집계 낱말이고, 같은 글자는 기준 커밋 전부터 추적 파일에 있던 글자라 지워도 가려지는 것이 없다). 06-VERIFICATION.md frontmatter에 보고서가 제안한 override를 더했다(2026-11-27T07:38:51Z). score·overrides_applied는 검증자가 다시 셀 때 반영된다"

### 4. 앱 저장소의 기준 앱 커밋 AW(92e986c3bb29)에서 06-04가 적은 앱 사실을 읽기 전용으로 확인하거나, 기록(06-EVIDENCE.md 「06-04 앱 사실」·「06-04 화면 사실」)을 그대로 받아들일지 정한다
expected: 탈퇴·운영자 도구가 공개하지 않은 코스를 지우고 공개한 코스를 남김, uid rate_limits 삭제와 TTL, 운영자 도구 범위 account·records와 dry-run 기본, 코스 단위 기록 삭제, 확인자료 1기록 1건·184일·지체 없는 파기, 메뉴 문구 일곱이 AW 코드와 같다 (06-01 #3, 06-04 #1·#2·#3)
result: pass
note: "사용자 요청으로 Claude가 앱 저장소를 읽기 전용(git cat-file·show·grep·diff만, checkout·fetch·쓰기 없음)으로 AW와 대조했다(2026-11-27). AW는 있고 3afb2085의 후손이다. ① user_data_cleanup.ts가 shouldDeletePrivateCourses일 때 creatorId==uid 코스 중 visibility가 public이 아닌 것을 지우고, cleanup_user_data.ts:60-64·운영자 account(656-660)는 true, records(755-759)는 false로 부른다. ② rate_limit.ts 접두사 넷·deleteUidRateLimitDocs·computeExpireAt(185·265), 탈퇴 Step 5(delete_user_account.ts:404)와 orphan 로그, guide.md의 TTL 「보통 24시간 안·보장된 상한 아님·정책 안 켜면 기한 없이 남음」. ③ onCall enforceAppCheck·timeoutSeconds 300, token.admin 거부, 범위 account·records, 명령 dry-run 기본·--apply 때 uid 재입력, operator 아래 쓰기 호출 0. ⑤ record_deletion_targets.dart 코스 단위 규칙과 「뱃지만·기록만 남기는 갈래 없음」, RecordDeleter가 기록·뱃지를 지우고 남은 원시 로그를 지움. ⑥ 확인자료 runs 1건당 1건·필드 여덟·RETENTION_DAYS 184·규칙 read/write false·파기 경로 (a)(b)(c). 메뉴 문구 일곱과 회원탈퇴·내 계정 라벨이 app_ko.arb와 같고, 「데이터 관리」는 !isAnonymous일 때만 보인다. 앱 HEAD는 AW 뒤로 나아갔지만(a7aa8ef9) 삭제 관련 경로(functions/src, lib/features/runs·settings·courses, app_ko.arb, firestore·storage rules, infra/operator, 앱 문서 셋)의 AW..HEAD 차이는 0이다. 곁가지(앱 저장소 일, 이 단계 범위 밖): 앱 docs/operator-delete-tool.md:11이 records의 「사이트 이름」을 「위치 기록만」으로 적지만 라이브 사이트는 같은 범위를 「뱃지와 기록 모두 삭제」로 부른다. 범위 내용은 같다. 판정 기록: 사용자가 「확인해 줘」로 대조를 맡겼고, Claude가 대조 결과로 pass를 기록한 뒤 사용자에게 알렸으며 사용자는 이의 없이 다음 테스트로 넘어갔다."

### 5. 사람 결정과 승인 이력이 기록대로인지 확인한다: Playwright 설치 승인(06-01 #4), p6-deletion 도구 음성·양성 대조(06-01 #5), installation ID 선택(06-03 #2), 익명 문장 (가)와 D-33 ②·D-39 결정(06-06 #3·#4), 원고·캡처 승인(06-07 #9), 가짜 값 시험 실행(06-08 #1·#2), 푸시 전 소개 문단 대조·SHA 승인과 커밋 없음(06-09 #3·#4)
expected: 각 결정·승인을 사용자가 직접 했고 기록의 표식(INSTALL_ID, D33_C7, D33_C8 등, DRAFT_APPROVED, PUSH1_APPROVED, PUSH2_APPROVED)과 같다
result: pass
note: "Claude가 06-EVIDENCE.md의 표식 아홉 묶음(PW_VERSION, INSTALL_ID, D33_C7, D33_C8·D39_PATH, DRAFT_APPROVED, DRY_RUN, PUSH1_APPROVED, PUSH2_APPROVED)과 기록된 답을 표로 보였고 사용자가 기억과 같다고 답했다. PUSH1·PUSH2 SHA가 origin/main에 있는 것은 git으로 확인했다"

### 6. 아래 prohibitions_flagged의 판단 단계 금지 사항 33건을 항목마다 확인해 해결(resolved)로 둘지 정한다
expected: 항목마다 검증자의 비권위 판정과 근거를 보고 사람이 받아들이거나 되돌린다
result: pass
note: "사용자가 33건 모두 해결(resolved)로 받아들였다. Claude가 묶음별로 보이고 모두 해결을 권함. A 지켜짐 22건(검증자 판정. 이 가운데 06-02·06-03·06-11·06-13의 첫 항목 넷은 검증자가 「기록 기준」으로 적었고 06-09의 --no-verify 미사용은 기록만 있다. 06-11 생성 구간 항목은 2026-11-27 generate-claude-md 재실행 차이 0으로 따로 뒷받침됨. 사용자에게 보인 요약은 A를 「검증자가 직접 확인」으로 적어 실제보다 강했고, 이 정정은 pass 뒤에 했다). B 판단 필요 3건(06-04·06-08·06-11 개발자 이름 값): 3번 (가)와 같은 사안, 06-04의 상호와 같은 글자 4줄(기준 커밋 전부터 추적 파일에 있던 글자)과 홈 경로 꼴 1줄(grep 패턴 문자열)도 같은 이유로 해결. C 확인 불가 6건: 설치 승인·열린 선택지 셋은 5번 결정 이력으로, 앱 저장소 쓰기 금지 둘은 2026-11-27 앱 작업 트리 깨끗·사이트 작업 ref 없음(커밋 귀속은 구분 불가, 기록 기준)으로, 「이미 정한 것 다시 안 물음」은 사용자 기억으로 받아들임. D 부분 확인 2건: 06-04 앱 동작은 4번 AW 대조로, 06-13은 a789cf9에서 기준 앱 커밋 줄과 prod 전제 번호 다섯 줄이 그대로이고 뒤에 추가 전제만 더한 것을 확인"

## Summary

total: 6
passed: 6
issues: 0
pending: 0
skipped: 0
blocked: 0

## Gaps
