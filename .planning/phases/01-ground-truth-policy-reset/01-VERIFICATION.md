---
phase: 01-ground-truth-policy-reset
verified: 2026-11-15T15:31:18Z
status: human_needed
score: 48/49 must-haves verified
covered_files: [".claude/CLAUDE.md", ".gitignore", ".planning/PROJECT.md", ".planning/baseline/DATA-INVENTORY.md", ".planning/baseline/DECISIONS.md", ".planning/baseline/NAMES.md", ".planning/baseline/URLS.md", ".planning/baseline/USER-TASKS.md", ".planning/codebase/ARCHITECTURE.md", ".planning/codebase/CONCERNS.md", ".planning/codebase/CONVENTIONS.md", ".planning/codebase/STACK.md", ".planning/codebase/STRUCTURE.md", ".planning/codebase/TESTING.md", ".planning/phases/01-ground-truth-policy-reset/01-01-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-01-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-02-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-02-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-03-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-03-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-04-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-04-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-05-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-05-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-06-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-06-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-07-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-07-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-08-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-08-SUMMARY.md", ".planning/research/STACK.md", ".planning/research/SUMMARY.md", "CLAUDE.md"]
covered_digest: "v4:sha256:1f3946dd3850b541c1d7a3ef157c692e03b13c402121c0b25324e3e52513795b"
behavior_unverified: 0
overrides_applied: 0
re_verification:
  previous_status: human_needed
  previous_score: 48/49
  gaps_closed: []
  gaps_remaining: []
  regressions: []
  note: "이전 보고서(2026-11-15T08:25:32Z)에는 gaps가 없어 첫 검증 방식으로 전체를 다시 확인했다. 그 뒤 코드 리뷰 수정 커밋 3회분(eb1e83d..ae4668b)이 CLAUDE.md 두 사본, .planning/codebase/*.md, PROJECT.md를 바꿨다. 기준 문서 5개, ROADMAP, STATE는 바뀌지 않았다"
decision_coverage:
  honored: 21
  total: 21
  not_honored: []
human_verification:
  - test: "URL 대장(.planning/baseline/URLS.md)의 「등록할 콘솔 필드(범주)」 열을 제공자·스토어별로 훑어본다 (01-01 human-check)"
    expected: "URL마다 등록할 곳이 범주 수준으로 적혀 있고, 확인되지 않은 필드명을 확정된 것처럼 적은 칸이 없다"
    why_human: "콘솔 필드 범주가 맞는지는 사람의 판단이 필요하다 (VALIDATION Manual-Only, BASE-02)"
  - test: "절차서(.planning/baseline/USER-TASKS.md)의 작업마다 「막는 단계」를 .planning/ROADMAP.md의 External Gates 표와 대조한다 (01-02 human-check). 특히 작업 6(DKIM, 가비아 DNS 2차 방문)의 막는 단계를 본다: 절차서는 「Phase 10 Apple 릴레이, D-11」로 적고 이메일 게이트는 DKIM을 기다리지 않는다고 하지만, ROADMAP External Gates 표의 가비아 DNS 행은 1차·2차 방문(DKIM 포함)을 묶어 Phase 5를 막는다고 적는다"
    expected: "작업 0~12의 막는 단계가 ROADMAP의 게이트와 어긋나지 않는다 (DNS·메일은 Phase 5, 화면 캡처는 Phase 4, DKIM은 Phase 10의 릴레이 답장 전제)"
    why_human: "단계 의존 관계는 ROADMAP 해석이 필요하다 (VALIDATION Manual-Only, BASE-04). DKIM이 Phase 5 완료를 막는지는 사용자가 정할 해석이다"
  - test: "결정 목록(.planning/baseline/DECISIONS.md) 「한눈에 보기」의 막는 단계 칸을 .planning/ROADMAP.md의 External Gates 표와 대조하고, U2·U3·U7의 「기본 동작」 문구를 읽는다 (01-04 human-check)"
    expected: "항목마다 막는 단계가 ROADMAP의 게이트와 어긋나지 않는다. 법률 판단 항목의 기본 동작이 결론이 아니라 임시 방침으로 읽히고 사용자가 받아들일 수 있는 문구다"
    why_human: "단계 의존 관계는 ROADMAP 해석이 필요하고 (VALIDATION Manual-Only, BASE-04), 법률 판단 항목에서 무엇이 보수적인 쪽인지는 계획자의 해석이라 사용자가 확인해야 한다"
  - test: "데이터 목록 「CLI 조회 기록」 표의 결과와, 조회에 성공한 리전·TTL·백업·버킷 칸을 사용자가 Firebase·GCP 콘솔에서 아는 값과 견주어 본다 (01-08 human-check). 함께 확인: 01-08 실행이 조회(list) 명령만 썼고 dev 설정·데이터가 바뀌지 않았는지, 특히 SUMMARY가 적은 대로 `firebase ext:list`의 확장 API 확인 단계가 API를 새로 켜지 않았는지. 이 확인으로 dev 프로젝트의 API 사용 설정과 리소스가 조회 전과 같은지, 판정 불가로 둔 01-08 금지 사항 세 개(설정·데이터 변경 금지, 다른 자격 증명 사용 금지, 문서·객체 내용 조회 금지)가 지켜졌는지도 사용자가 판정한다"
    expected: "조회한 값이 dev 프로젝트의 실제 설정과 같고, 건너뛰거나 실패한 조회의 칸은 「CLI 미확인」으로 남아 있다. 문서에 버킷 이름이나 계정 정보가 없다"
    why_human: "dev 프로젝트의 실제 설정은 사용자의 자격 증명으로만 볼 수 있다 (VALIDATION Manual-Only, BASE-03). 「읽기 전용으로만 조회함」은 SUMMARY 서술 말고 저장소에 남은 증거가 없다"
  - test: "이름 표(.planning/baseline/NAMES.md)의 상호·대표자·사업자등록번호·주소·영문 법인명·스토어 개발자 이름·전화번호 칸을 눈으로 본다 (VALIDATION Manual-Only, BASE-01)"
    expected: "칸이 비어 있거나 사용자가 준 값뿐이다 (검증 시점 관찰: 일곱 칸 모두 「(빈칸)」 표기)"
    why_human: "「추측하지 않음」은 패턴으로 다 잡을 수 없다 (VALIDATION Manual-Only)"
  - test: "01-01 판단 등급 금지 사항 3개(사업자 값 추측 금지, 공개 전 사업자 값 커밋 금지, 콘솔 필드를 확정 필드명처럼 적지 않음)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다"
    expected: "각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다"
    why_human: "unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없고 interactive 모드에서는 사람이 항목마다 해소한다 (ADR-550 D4)"
  - test: "01-02 판단 등급 금지 사항 2개(발급 값 추정 기재 금지, 기존 DNS 레코드 삭제·수정 안내 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다"
    expected: "각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다"
    why_human: "unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없고 interactive 모드에서는 사람이 항목마다 해소한다 (ADR-550 D4)"
  - test: "01-03 판단 등급 금지 사항 3개(미확인 값을 확인된 것처럼 적지 않음, 법적 성격 단정 금지, 실제 사용자 데이터 값 옮기지 않음)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다"
    expected: "각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다"
    why_human: "unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없고 interactive 모드에서는 사람이 항목마다 해소한다 (ADR-550 D4)"
  - test: "01-04 판단 등급 금지 사항 3개(법률 항목 기본 동작을 결론처럼 적지 않음, U12 말고 「결정됨」 금지, U11 기본값 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다"
    expected: "각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다"
    why_human: "unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없고 interactive 모드에서는 사람이 항목마다 해소한다 (ADR-550 D4)"
  - test: "01-05 판단 등급 금지 사항 3개(비공개 코스 삭제·공개 코스만 남음으로 적지 않음, 즉시 전부 삭제로 읽히게 적지 않음, 선택지만 있는 값 추측 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다"
    expected: "각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다"
    why_human: "unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없고 interactive 모드에서는 사람이 항목마다 해소한다 (ADR-550 D4)"
  - test: "01-06 판단 등급 금지 사항 3개(옛 규칙 문장 인용 금지, 코드 설명을 미래 상태로 고쳐 쓰지 않음, 방침을 지금 코드에 반영하라는 뜻으로 읽히지 않음·지원 주소 문자열 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다"
    expected: "각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다"
    why_human: "unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없고 interactive 모드에서는 사람이 항목마다 해소한다 (ADR-550 D4)"
  - test: "01-07 판단 등급 금지 사항 3개(D-21 밖 ROADMAP 내용 변경 금지, 연구 본문 수정·삭제 금지, 연구 캐시 커밋 금지)를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다"
    expected: "각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다"
    why_human: "unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없고 interactive 모드에서는 사람이 항목마다 해소한다 (ADR-550 D4)"
  - test: "01-08 판단 등급 금지 사항 1개(조회하지 못한 칸을 추정값으로 채우지 않음 (나머지 세 개는 위 01-08 항목에서 다룸))를 본문 「금지 사항 (judgment-tier)」 표의 검증자 판정과 근거로 읽는다"
    expected: "각 항목이 지켜졌다는 검증자 판정에 동의한다. 동의하지 않는 항목은 gap으로 되돌린다"
    why_human: "unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없고 interactive 모드에서는 사람이 항목마다 해소한다 (ADR-550 D4)"
---

# Phase 1: 기준표와 방침 정비 (Ground Truth & Policy Reset) 검증 보고서

**Phase Goal:** 운영자와 이후 모든 단계가 같은 기준(이름 표·URL 대장·데이터 목록·결정 목록)을 쓰고, `CLAUDE.md`가 이번 마일스톤의 방침을 설명해 다음 작업 세션이 결정을 되돌리지 않는다
**Verified:** 2026-11-15T15:31:18Z
**Status:** human_needed
**Re-verification:** 예. 이전 보고서(2026-11-15T08:25:32Z, `human_needed`, 48/49)에 gaps가 없어서 첫 검증 방식으로 전체를 다시 확인했습니다. 이전 보고서 뒤에 코드 리뷰 수정 커밋 3회분이 들어왔기 때문입니다.

## 결론 요약

ROADMAP 성공 기준 다섯 개를 저장소의 실제 파일로 다시 확인했고, 모두 성립합니다.

- 기준 문서 다섯 개(`NAMES.md`, `URLS.md`, `DATA-INVENTORY.md`, `DECISIONS.md`, `USER-TASKS.md`)가 있고, 내용이 구체적이며, 서로를 경로로 가리킵니다.
- 두 `CLAUDE.md`에는 방침 일곱 행이 같은 구간으로 들어 있습니다. 두 구간의 `diff` 결과는 0입니다.
- 옛 규칙 문장은 0줄입니다.
- 차단 사항(blocker)은 없습니다.

**이전 검증 뒤 바뀐 것** (`git diff --stat 4ccd4c1..HEAD`):
- 바뀐 파일은 `CLAUDE.md`, `.claude/CLAUDE.md`, `.planning/codebase/` 문서 6개, `.planning/PROJECT.md`입니다.
- 기준 문서 5개, `ROADMAP.md`, `STATE.md`는 바뀌지 않았습니다.
- 바뀐 파일에 걸린 truth는 모두 새로 확인했습니다. 이전 보고서가 열린 경고로 적었던 WR-01~03은 디스크에서 고쳐진 것을 확인했습니다.

상태가 `passed`가 아닌 이유는 사람 확인 항목 13건이 남아 있기 때문입니다 (`01-UAT.md`에서 13건 모두 pending). 또 01-08의 「읽기 전용 조회만 했음」은 SUMMARY 서술 말고는 증거가 없어서 UNCERTAIN으로 두었습니다.

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| SC1 | 운영자는 이름 표 하나에서 한글·영문 서비스명(러닝펜슬 / RunningPencil), 사업자등록증 그대로의 상호, 영문 법인명을 확인한다. 사용자가 아직 주지 않은 값은 빈칸이고, 추측해서 채운 값은 없다 | ✓ VERIFIED | `.planning/baseline/NAMES.md` 표는 12행입니다. 한글 서비스명 러닝펜슬, 영문 서비스명 RunningPencil이 있습니다. 사업자 값 일곱 행(상호·대표자·사업자등록번호·주소·영문 법인명·스토어 개발자 이름·전화번호)의 값 칸은 모두 `(빈칸)`입니다. 앱 기준 커밋 `3afb2085`의 `lib/l10n/app_ko.arb:4`·`app_en.arb:4` `appTitle`이 각각 「러닝펜슬」·「RunningPencil」이라 표의 값과 같습니다 (`git show`로 직접 확인) |
| SC2 | 운영자는 URL 대장 하나에서 모든 공개 URL(홈, 기존 3개, `/support/`, 위치약관, `/en/` 5개)을 apex·https·끝 슬래시 형식으로 보고, URL마다 등록할 콘솔 필드를 확인한다 | ✓ VERIFIED | `.planning/baseline/URLS.md`에 주소 행이 12줄 있습니다 (KO 6, EN 5, v2 예약 `/en/location-terms/` 1). 모두 `https://runningpencil.com/…/` 꼴이고, 콘솔 칸이 빈 행은 없습니다. 기존 세 주소에는 「경로 고정(리디렉션 금지)」이 적혀 있습니다. 필드 범주가 맞는지는 사람이 확인합니다 (Human 1) |
| SC3 | 운영자는 데이터 목록에서 개인정보 항목마다 출처·목적·저장 위치(리전)·수탁자·국외 이전·보유 기간·삭제 방식을 앱 저장소의 파일 근거와 함께 확인하고, 확인하지 못한 칸은 「미확인」으로 표시돼 있다 | ✓ VERIFIED | `DATA-INVENTORY.md`에는 다음이 있습니다: 머리(기준 커밋 `3afb2085`, 재확인 규칙), 구간 A~H, 「확인할 것」, 「CLI 조회 기록」. 01-03·01-05·01-08의 구조 검사와 근거 경로 검사(기준 커밋에 경로가 있는지)가 통과합니다. 구간 G의 「`courses`는 공개·비공개 모두 삭제하지 않음」은 앱 코드와 직접 대조했습니다: `functions/src/running_pencil/cleanup_user_data.ts`는 runs와 badges만 지우고, `delete_user_account.ts`는 `users`·`identity_index`·`fcmTokens`만 다룹니다. dev CLI 값이 정확한지는 사람이 확인합니다 (Human 4) |
| SC4 | 운영자는 결정 목록(U2·U3·U5~U9·U11~U13)과 사용자가 할 외부 작업 목록(가비아 DNS 레코드 표, 메일 수신 시험 절차, 사업자 값, 앱 화면 캡처)을 받아, 항목마다 어느 단계를 막는지 안다 | ✓ VERIFIED | `DECISIONS.md` 「한눈에 보기」에 열두 행(U2·U3·U5·U6-가·U6-나·U7·U8·U9·U11·U12·U13·P1)이 있습니다. 행마다 막는 단계를 ROADMAP External Gates 표(215~235행)와 한 줄씩 대조했고, 어긋난 행은 없습니다. P1은 ROADMAP에 행이 없는데, 근거(D-08)가 문서에 적혀 있습니다. `USER-TASKS.md` 「한눈에 보기」에는 작업 0~12와 각 작업의 막는 단계가 있습니다: DNS 레코드 표는 작업 2·6, 외부 4곳 수신 시험은 작업 4와 기록 양식, 사업자 값은 작업 9, 화면 캡처는 작업 10입니다. 작업 6(DKIM)의 막는 단계를 어떻게 읽을지는 사람이 확인합니다 (Human 2) |
| SC5 | `CLAUDE.md`가 지원 이메일 공개, 사업자 정보 표시, 영문명 RunningPencil, 한국어+영어, Jekyll 빌드 전환, 포인트·굿즈·코스북 제거를 현재 방침으로 설명하고, 옛 규칙 문장이 남아 있지 않다 | ✓ VERIFIED | 리뷰 수정 뒤의 디스크 내용으로 다시 확인했습니다. 두 `CLAUDE.md`의 「이번 마일스톤 방침 (2026-11 결정)」 표는 표 줄 8개(머리 + 구분 + 일곱 행)입니다. `TESTING.md`의 점검 목록 9 비교 명령은 rc=0이고, 따로 뽑은 두 구간도 `diff` 결과가 같습니다. 옛 규칙 꼴 9종(01-06 verify 13)은 다섯 방침 파일에서 0줄입니다. 검증자가 넓힌 정규식(「연락처 미표시」「RunningPencil 쓰지 않음」「ko 전용」 등)으로도 찾았는데, 걸린 줄은 현행 Ground Rule인 「Jekyll i18n 플러그인을 쓰지 않습니다」 한 줄뿐입니다. `generate-claude-md`로 다시 만든 사본은 저장소 파일과 `cmp`로 같습니다 |

### Plan must_haves (계획별)

| Plan | Truths | Status | Evidence |
|------|--------|--------|----------|
| 01-01 | 6 | ✓ 6/6 VERIFIED | 이름 표와 URL 대장 내용은 위 SC1·SC2와 같습니다. 이 계획의 verify 18개 가운데 17개가 exit 0입니다. 실패한 1개(`01-01` verify 8)는 범위 가드입니다: 「`.claude/CLAUDE.md`의 conventions 밖 블록이 단계 시작 커밋 `dcc2002`와 같다」를 검사합니다. 리뷰 수정 커밋 `24e31f2`(IN-01, STACK), `fd6504f`(IN-03, PROJECT), `270dcb6`(IN-04), `1dc2f1a`(WR-06, ARCHITECTURE)가 원본을 일부러 고치고 같은 커밋에서 다시 생성했기 때문에 실패합니다. truth 6(재생성 뒤에도 방침 구간이 남고 두 사본이 같다)은 재생성 `cmp`와 구간 `diff`로 성립합니다 |
| 01-02 | 5 | ✓ 5/5 VERIFIED | verify 11/11 exit 0. 이전 검증 뒤 `USER-TASKS.md`는 바뀌지 않았습니다. 확인한 내용: 보존 레코드 표가 있고 「지우는 레코드는 없습니다」라고 적혀 있습니다. 발급 값 칸은 「콘솔에서 복사」입니다 |
| 01-03 | 6 | ✓ 6/6 VERIFIED | verify 14/15 exit 0. 실패한 verify 10은 「`CLI 미확인` 5줄 이상」 조건 때문인데, 01-08이 그 칸을 dev CLI 값으로 채워서 대체(superseded)된 것입니다. 같은 명령의 항목 검사 부분만 따로 돌리면 `miss=[]`입니다 |
| 01-04 | 6 | ✓ 6/6 VERIFIED | verify 11/11 exit 0. 「결정됨」은 U12뿐입니다 (`grep`으로 26·38행만 나옵니다) |
| 01-05 | 5 | ✓ 5/5 VERIFIED | verify 12/13 exit 0. 실패한 verify 9는 01-03 verify 10과 같은 이유로 대체된 것입니다. 구조 검사 부분은 `rows=12 bad=`로 통과합니다 |
| 01-06 | 5 | ✓ 5/5 VERIFIED | verify 16/18 exit 0. 실패한 2개는 범위 가드입니다. verify 5는 「STACK·STRUCTURE·ARCHITECTURE·INTEGRATIONS가 `dcc2002`와 같다」를 보는데, STACK(`24e31f2`), STRUCTURE(`270dcb6`), ARCHITECTURE(`270dcb6`·`1dc2f1a`)가 리뷰 수정으로 바뀌었습니다. 같은 명령의 라이브 사이트 부분(`*.html`·`_config.yml`·`favicon/`·`CNAME`·`README.md`)은 따로 돌리면 바뀐 것이 없습니다. verify 10은 01-01 verify 8과 같은 가드이고, 뒷부분(CONVENTIONS 목록 7줄이 `.claude/CLAUDE.md`에 그대로 있음)만 따로 돌리면 `lines=7 bad=`로 통과합니다. 다섯 truth(일곱 행, 작업 규칙, 옛 문장 0줄, 상태 문장, 재생성 불변)는 모두 디스크에서 성립합니다 |
| 01-07 | 7 | ✓ 7/7 VERIFIED | verify 18/18 exit 0. truth 4에는 대체 표시가 붙습니다: 「`PROJECT.md`의 What This Is·Core Value·Constraints는 바뀌지 않아 재생성 결과가 그대로다」 가운데 「What This Is는 바뀌지 않음」은 글자 그대로는 더 이상 맞지 않습니다. 리뷰 수정 `fd6504f`(IN-03)가 앱 설명 한 줄에 「직접 그린 코스를 공개할 수 있는」을 더해 루트 `CLAUDE.md`와 맞췄고, 같은 커밋에서 `.claude/CLAUDE.md`를 다시 생성했기 때문입니다. 01-07 자신의 diff 범위(verify 15, `(01-07)` 커밋만 봄)와 「재생성 결과가 파일과 같다」(`cmp`)는 지금도 성립합니다. 01-07이 지켜야 할 범위는 지켰으므로 VERIFIED로 둡니다. 이 변경은 의도한 수정이고 gap이 아닙니다 |
| 01-08 | 4 | ⚠️ 3/4 VERIFIED, 1 UNCERTAIN | verify 7/7 exit 0. 「CLI 조회 기록」은 8행이고 모두 「조회함」입니다. 프로젝트 번호·버킷·VM 이름·IP·계정 이메일은 0건입니다. **UNCERTAIN:** 「읽기 전용 명령만 썼고 dev 설정과 데이터가 바뀌지 않았다」의 근거는 `01-08-SUMMARY.md:88`·`:156`의 서술뿐이고, 저장소에 다른 증거가 없습니다 → Human 4 |

**Score:** 48/49 truths verified (SC 5 + 계획 truth 44. UNCERTAIN 1, PRESENT_BEHAVIOR_UNVERIFIED 0)

### 금지 사항 (judgment-tier, 비권위적 LLM 판정 — unverified-prohibition, human review recommended)

24개 모두 `verification: judgment`입니다. 아래 판정은 검증자의 비권위적 판정이고, 사용자가 항목마다 확인합니다 (Human 4, 6~13).

| Plan | 금지 사항 (요지) | 검증자 판정 | 근거 |
|------|------------------|-------------|------|
| 01-01 | 사업자 사실값을 추측해 채우지 않는다 | 지켜짐 | 일곱 칸 모두 `(빈칸)` |
| 01-01 | 공개 전 사업자 사실값을 어떤 커밋에도 넣지 않는다 | 지켜짐 | `git log -p dcc2002..HEAD`(리뷰 수정 커밋 포함)의 추가 줄 전체에 누출 정규식을 적용했습니다: IP, 12자리 숫자, 계정 이메일, 앱 ID, 인증 토큰, API 키, DKIM 키, 사업자등록번호 꼴. 허용 목록 값과 40자 커밋 해시를 가리면 남는 줄은 0줄입니다 |
| 01-01 | 콘솔 필드를 확정된 필드명처럼 적지 않는다 | 지켜짐 (사람 확인 필요) | 머리 문단에 「범주 수준 … Phase 10 연구에서 확정」이 있고, EN 행에는 「Phase 10에서 확정」·「후보」가 적혀 있습니다 |
| 01-02 | 발급 값을 추정으로 적지 않는다 | 지켜짐 | 값 칸은 「콘솔에서 복사」입니다. `google-site-verification=` 값과 DKIM 키 꼴은 0건입니다 |
| 01-02 | 기존 DNS 레코드를 지우거나 고치라고 안내하지 않는다 | 지켜짐 | 「보존할 기존 레코드」 표의 처리 칸이 모두 「그대로 둡니다」이고, 「지우는 레코드는 없습니다」라고 적혀 있습니다 |
| 01-03 | 확인하지 못한 값을 확인된 것처럼 적지 않는다 | 지켜짐 | 리전 칸마다 근거 종류가 붙어 있습니다. dev 값에는 「근거: dev CLI, 2026-11-15 조회」, prod 관련 칸에는 「미확인」이 적혀 있습니다 |
| 01-03 | 수탁·제3자 제공·국외 이전의 법적 성격을 단정하지 않는다 | 지켜짐 | 머리에 「법적 구분은 Phase 7에서 합니다」라고 적혀 있습니다 |
| 01-03 | 실제 사용자 데이터 값을 옮기지 않는다 | 지켜짐 | 필드 이름과 형태만 있습니다. 누출 정규식 0건 |
| 01-04 | 법률 판단 항목(U2·U3·U7)의 기본 동작을 법적 결론처럼 적지 않는다 | 지켜짐 (사람 확인 필요) | 머리 문단에 「법률 검토 전 초안」이 있고, 항목마다 「초안·법률 확인 필요」가 붙어 있습니다 |
| 01-04 | 사용자가 정하지 않은 항목을 「결정됨」으로 적지 않는다 | 지켜짐 | 「결정됨」은 U12뿐입니다 |
| 01-04 | U11에 기본값이나 추측값을 적지 않는다 | 지켜짐 | U11은 render-if-present로 숨긴다고만 적혀 있습니다 |
| 01-05 | 탈퇴 때 비공개 코스가 지워진다거나 공개 코스만 남는다고 적지 않는다 | 지켜짐 | 「삭제하지 않음 (공개·비공개 모두)」. 앱 코드와 대조했습니다 (SC3) |
| 01-05 | 탈퇴하면 모든 데이터가 곧바로 지워진다고 읽히게 적지 않는다 | 지켜짐 | 구간 G에 남는 행이 있습니다: 코스, `rate_limits`, `mail`, Analytics·Crashlytics의 uid, 함수 로그. 「서비스에서의 삭제」와 「백업에서의 제거(180일)」를 나눠 쓰라는 문장도 있습니다 |
| 01-05 | 선택지만 있는 값에 기본값을 추측해 채우지 않는다 | 지켜짐 | Analytics 보존 기간은 「미확인」으로 적혀 있습니다 |
| 01-06 | 옛 규칙 문장을 인용하거나 부정문으로 되풀이하지 않는다 | 지켜짐 | 옛 문장 꼴 0줄. 뒤집은 방침에는 「이전 방침을 뒤집음」만 적혀 있습니다 |
| 01-06 | 코드 설명 구간을 미래 상태로 고쳐 쓰지 않는다 | 지켜짐 | 리뷰 수정 뒤의 내용도 지금 코드를 설명합니다. 다시 쓴 architecture 블록(`.claude/CLAUDE.md:262~`)도 Tailwind CDN, 복사로 공유, 빌드 없음 같은 현재 상태를 적습니다 |
| 01-06 | 방침을 지금 코드에 반영해도 된다고 읽히게 적지 않는다, 지원 주소 문자열을 두 `CLAUDE.md`에 적지 않는다 | 지켜짐 | 머리 문단에 「적용 단계가 오기 전에는 사이트 코드에 반영하지 않습니다」가 있습니다. 두 파일의 `support@runningpencil` 문자열은 0건입니다. 라이브 사이트 파일은 `dcc2002` 이후 바뀌지 않았습니다 |
| 01-07 | D-21이 꼽지 않은 ROADMAP 내용을 바꾸지 않는다 | 지켜짐 (계획 검사 기준) | 01-07 verify 18/18 exit 0. 이전 검증 뒤 ROADMAP은 바뀌지 않았습니다 |
| 01-07 | 연구 문서 본문을 고치거나 지우지 않는다 | 지켜짐 | 두 파일 모두 단계 시작 대비 삭제 줄이 0이고, 이전 검증 뒤에도 바뀌지 않았습니다 |
| 01-07 | `.planning/research/.cache/`의 내용을 커밋하지 않는다 | 지켜짐 | `git ls-files` 결과 0개 |
| 01-08 | dev 설정·데이터를 바꾸지 않는다 | 판정 불가 (UNCERTAIN) | `01-08-SUMMARY.md:88`(설정 변경·생성·삭제·배포 명령을 쓰지 않음)과 `:156`(`ext:list` 출력에 API를 켰다는 줄 없음)의 서술뿐입니다. Human 4 |
| 01-08 | 다른 자격 증명을 찾아 쓰지 않는다 | 판정 불가 (UNCERTAIN) | `01-08-SUMMARY.md:88`의 「다른 자격 증명을 찾지 않았다」 서술뿐입니다. Human 4 |
| 01-08 | Firestore 문서·Storage 객체 내용을 조회하지 않는다 | 판정 불가 (UNCERTAIN) | 기록 표에는 list 명령 8종만 있습니다. 저장소에 다른 증거는 없습니다. Human 4 |
| 01-08 | 조회하지 못한 칸을 추정값으로 채우지 않는다 | 지켜짐 | 8건 모두 「조회함」이고, 값 칸마다 근거 표기가 붙어 있습니다 |

### Advisory (New Scope, Unevidenced)

없음. 재검증에서 새로 찾은 범위 밖 우려 가운데 결정적 증거 없이 남은 항목은 없습니다. 리뷰 수정으로 생긴 가드 실패 3건은 커밋으로 원인이 확인돼 Anti-Patterns의 Info로 적었습니다.

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `.planning/baseline/NAMES.md` | 이름 표 (BASE-01) | ✓ VERIFIED | `verify.artifacts` 통과. 46줄 |
| `.planning/baseline/URLS.md` | URL 대장 (BASE-02) | ✓ VERIFIED | `verify.artifacts` 통과. 주소 12행 + 도메인 칸 표 |
| `.planning/baseline/DATA-INVENTORY.md` | 데이터 목록 (BASE-03) | ✓ VERIFIED | `verify.artifacts` 통과 (01-03·05·08). 330줄, 구간 A~H |
| `.planning/baseline/DECISIONS.md` | 결정 목록 (BASE-04) | ✓ VERIFIED | `verify.artifacts` 통과. 192줄, N1~N7 |
| `.planning/baseline/USER-TASKS.md` | 사용자 작업 절차서 (BASE-04) | ✓ VERIFIED | `verify.artifacts` 통과. 398줄, 작업 0~12 |
| `CLAUDE.md` | 방침 표 7행, 작업 규칙 (BASE-05) | ✓ VERIFIED | 01-06 artifacts 3/3 |
| `.claude/CLAUDE.md` | 마커 위 방침 구간, 재생성 블록 | ✓ VERIFIED | 재생성 결과와 `cmp`로 같음 |
| `.planning/codebase/CONVENTIONS.md` | 생성 원본의 상태 문장 | ✓ VERIFIED | Content & Naming Rules의 맨 위 목록 줄 7개가 `.claude/CLAUDE.md`에 글자 그대로 있음 (`lines=7 bad=`). 「2026-11 기준」 줄 개수 조건(3개 이상)은 01-06 verify 2가 통과 |
| `.planning/ROADMAP.md`, `STATE.md`, `PROJECT.md`, `research/STACK.md`, `research/SUMMARY.md` | U12·DNS·위치약관 정합 | ✓ VERIFIED | 01-07 artifacts 5/5 |

### Key Link Verification

`verify.key-links`의 계획별 결과: 01-01 3/3, 01-02 1/1, 01-03 1/1, 01-04 2/2, 01-05 2/2, 01-06 3/3, 01-07 4/4, 01-08 1/1. 모두 WIRED입니다.

| From | To | Via | Status |
|------|----|-----|--------|
| `CONVENTIONS.md` | `NAMES.md` / `.claude/CLAUDE.md` | 서비스 이름 줄이 이름 표 경로를 가리키고, 생성기가 그 줄을 옮김 | ✓ WIRED |
| `CLAUDE.md` | `.claude/CLAUDE.md` | 방침 구간이 같음 (TESTING 비교 명령 rc=0) | ✓ WIRED |
| `CLAUDE.md` | `.planning/ROADMAP.md` | 작업 규칙이 Ground Rules를 가리킴 | ✓ WIRED |
| `USER-TASKS.md` | `NAMES.md` | 지원 주소·사업자 항목 이름이 같음 | ✓ WIRED |
| `DATA-INVENTORY.md` | `DECISIONS.md` / `USER-TASKS.md` | prod 리전, U6·N 항목, 작업 11·12 | ✓ WIRED |
| `DECISIONS.md` | `ROADMAP.md` / `USER-TASKS.md` | 막는 단계가 External Gates와 같음 (직접 대조) | ✓ WIRED |
| `ROADMAP.md`, `research/*.md` | `USER-TASKS.md` / `DECISIONS.md` | Phase 5 문장과 연구 메모가 정본을 가리킴 | ✓ WIRED |

### Data-Flow Trace (Level 4)

해당 없음. 이 단계의 산출물은 문서뿐이고, 동적 데이터를 그리는 코드가 없습니다.

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| 계획 8개의 `<automated>` 검사 전체 | 111개 명령을 저장소 루트에서 `bash`로 하나씩 실행 (TMPDIR은 scratchpad) | 106개 exit 0, 5개 exit 1 | ✓ PASS (5개는 아래에 설명) |
| 대체(superseded) 2건 | `01-03` verify 10, `01-05` verify 9 | 「CLI 미확인」 개수 조건 때문에 실패합니다. 01-08이 그 칸을 채워서 대체된 것이고, 나머지 부분만 따로 돌리면 통과합니다 | ℹ️ 의도된 대체 |
| 범위 가드 3건 | `01-01` verify 8, `01-06` verify 5, `01-06` verify 10 | 「conventions 밖 블록과 codebase 문서 4개가 `dcc2002`와 같다」를 보는 계획 실행 중 가드입니다. 리뷰 수정 커밋 `24e31f2`·`fd6504f`·`270dcb6`·`1dc2f1a`가 일부러 고쳤기 때문에 실패합니다. 같은 명령의 라이브 사이트 부분과 CONVENTIONS 목록 부분은 따로 돌리면 통과합니다 | ℹ️ 의도된 리뷰 수정 (must-have 아님) |
| 재생성 불변 | `generate-claude-md --output <scratchpad 사본>` 후 `cmp` | 같음 | ✓ PASS |
| 방침 구간 일치 | `TESTING.md` 점검 목록 9의 비교 명령 | 출력 없음, rc=0 | ✓ PASS |
| 라이브 사이트 불변 | `git diff --quiet dcc2002… -- '*.html' _config.yml favicon/ CNAME ':(exclude)favicon/app-icon-*.png' README.md` | exit 0 | ✓ PASS |
| 앱 저장소 기준 커밋 | `git -C ~/dv/woody/running_pencil rev-parse --short HEAD` | `3afb2085` | ✓ PASS |
| 커밋 존재 | `verify.commits` (SUMMARY의 해시) | 실제 해시 32개가 모두 valid입니다. invalid 2개(`191c190`, `195c193`)는 01-06 SUMMARY에 붙은 `diff` 출력의 줄 범위라 해시가 아닙니다 | ✓ PASS |
| 검증 실행이 저장소를 바꾸지 않음 | 실행 전후 `git status --porcelain` 비교 | 같음 | ✓ PASS |

### Probe Execution

해당 없음. `scripts/` 디렉터리가 없고, 계획에 선언된 probe도 없습니다.

## Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| BASE-01 | 01-01 | 이름 표 하나로 한글·영문 서비스명, 상호, 영문 법인명 확인 | ✓ SATISFIED | SC1 |
| BASE-02 | 01-01 | URL 대장 하나로 공개 URL과 콘솔 필드 확인 | ✓ SATISFIED | SC2 (필드 범주가 맞는지는 사람이 확인) |
| BASE-03 | 01-03, 01-05, 01-08 | 앱 저장소 근거의 데이터 목록. 법적 문서가 이 목록에서 나온다 | ✓ SATISFIED | SC3. 「법적 문서가 이 목록에서 나온다」는 Phase 6~8에서 이루어집니다. 지금은 `CLAUDE.md` 작업 규칙과 ROADMAP Phase 6·7 성공 기준이 이를 강제합니다 |
| BASE-04 | 01-02, 01-04, 01-07 | 사용자·법률 결정 목록과 막는 단계 | ✓ SATISFIED | SC4 |
| BASE-05 | 01-01, 01-06 | `CLAUDE.md`가 바뀐 방침을 설명 | ✓ SATISFIED | SC5 |

REQUIREMENTS.md 추적 표에서 `| Phase 1 |`에 배정된 행은 157~161행의 BASE-01~05 다섯 개뿐이고 (`grep -nE '\| Phase 1 \|'`), 모두 계획 frontmatter에 있습니다. ORPHANED 요구사항은 없습니다.

## Decision Coverage

`check.decision-coverage-verify`(CONTEXT 경로 지정) 결과: 21/21 honored, not_honored 없음.

## Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `.planning/ROADMAP.md` | 83, 98, 112, 127, 146, 162, 178, 193, 209, 256-264 | `TBD` (`**Plans**: TBD`, Progress 표 `0/TBD`) | ℹ️ Info | 이 단계 diff(`dcc2002..HEAD`)에서 더한 줄은 0줄입니다. 아직 계획하지 않은 Phase 2~10의 계획 수 자리이고, 각 단계의 plan-phase가 채웁니다. 미완성 작업을 뜻하는 debt marker가 아니라서 blocker로 보지 않았습니다. orchestrator가 다르게 판단할 수 있습니다 |
| `.planning/PROJECT.md` | What This Is | 01-07 truth 4의 「바뀌지 않음」 구절이 리뷰 수정 `fd6504f`(IN-03)로 대체됨 | ℹ️ Info | 의도한 수정이고, 같은 커밋에서 다시 생성했습니다. 재생성 불변은 유지됩니다 |
| `.planning/codebase/STACK.md`, `STRUCTURE.md`, `ARCHITECTURE.md` | — | 계획 실행 중 범위 가드 3건이 리뷰 수정 뒤 실패 | ℹ️ Info | 실패의 원인은 리뷰 수정 커밋 `24e31f2`, `270dcb6`, `1dc2f1a`입니다. 어느 must-have에도 걸리지 않습니다. 가드 명령은 실행 시점의 안전장치라 그대로 둡니다 |

이전 보고서의 경고 WR-01~03은 디스크에서 해소된 것을 확인했습니다.
- **WR-01:** 두 사본의 작업 규칙에 「빠지면 안 되는 조항이 있는 페이지는 값이 올 때까지 커밋을 보류합니다」가 있습니다 (`CLAUDE.md:27`, `.claude/CLAUDE.md:23`).
- **WR-02:** 빠졌던 Ground Rules가 들어갔습니다: 세 URL의 200 확인, Jekyll 3.10.0, `CLAUDE.md`도 함께 고친다는 규칙.
- **WR-03:** `TESTING.md`에 비교 명령이 생겼습니다. 이 명령은 구간이 비어 있으면 FAIL로 끝납니다 (WR-04).
- **WR-06:** `.claude/CLAUDE.md:228`에 「JSDoc/TSDoc은 쓰지 않는다」가 돌아왔습니다.

## Human Verification Required

아래 13건은 다음에서 나온 항목입니다: 계획 네 개가 `end-of-phase`로 넘긴 human-check(01-01·01-02·01-04·01-08의 `<human-check>`, 4건), VALIDATION의 Manual-Only(1건), 판단 등급 금지 사항(8건). 목록은 이전 보고서, `01-UAT.md`(13건 모두 pending)와 같습니다. 문구는 4번만 바뀌었습니다: `expected`를 01-08 `<human-check>`의 원문으로 되돌렸고, 검증자가 덧붙였던 문장은 `test`(함께 판정할 것)로 옮겼습니다. 1~3번의 `expected`는 계획 원문과 같습니다.

### 1. URL 대장 콘솔 필드 범주 (01-01)
**Test:** URL 대장의 「등록할 콘솔 필드(범주)」 열을 제공자·스토어별로 훑어봅니다.
**Expected:** URL마다 등록할 곳이 범주 수준으로 적혀 있고, 확인되지 않은 필드명을 확정된 것처럼 적은 칸이 없습니다.
**Why human:** 콘솔 필드 범주가 맞는지는 사람의 판단이 필요합니다.

### 2. 절차서의 막는 단계 대조 (01-02)
**Test:** 작업 0~12의 「막는 단계」를 ROADMAP External Gates 표와 대조합니다. 어긋날 수 있는 점이 하나 있습니다.
- 절차서는 작업 6(DKIM, DNS 2차 방문)이 「Phase 10 Apple 릴레이」를 막는다고 적고, 「이메일 게이트는 DKIM을 기다리지 않는다」고 씁니다.
- ROADMAP External Gates 표 221행의 가비아 DNS 행은 1차·2차 방문(DKIM 포함)을 묶어서 Phase 5를 막는다고 적습니다.
- Phase 5의 성공 기준 다섯 개에는 DKIM이 없습니다.

**Expected:** 작업 0~12의 막는 단계가 ROADMAP의 게이트와 어긋나지 않습니다.
**Why human:** DKIM이 Phase 5 완료를 막는지는 사용자가 정할 해석입니다.

### 3. 결정 목록의 막는 단계와 법률 항목 문구 (01-04)
**Test:** 「한눈에 보기」의 막는 단계를 ROADMAP External Gates와 대조하고, U2·U3·U7의 「기본 동작」 문구를 읽습니다.
**Expected:** 막는 단계가 어긋나지 않습니다 (검증자 대조 결과: 모두 같음). 법률 판단 항목의 기본 동작이 결론이 아니라 임시 방침으로 읽힙니다.
**Why human:** 법률 판단 항목에서 무엇이 보수적인 쪽인지는 사용자가 확인해야 합니다.

### 4. dev CLI 값과 조회 과정 (01-08)
**Test:** 「CLI 조회 기록」과 리전·TTL·백업·버킷 칸을 Firebase·GCP 콘솔의 값과 견주어 봅니다. 다음도 함께 확인합니다:
- list 명령만 썼는지
- dev 설정·데이터가 바뀌지 않았는지
- 다른 자격 증명을 쓰지 않았는지
- `firebase ext:list`가 API를 새로 켜지 않았는지

**Expected:** 조회한 값이 dev 프로젝트의 실제 설정과 같고, 건너뛰거나 실패한 조회의 칸은 「CLI 미확인」으로 남아 있다. 문서에 버킷 이름이나 계정 정보가 없다. (01-08 `<human-check>`의 `<expected>` 원문)
**함께 판정할 것:** dev 프로젝트의 API 사용 설정과 리소스가 조회 전과 같은지, 판정 불가로 둔 01-08 금지 사항 세 개가 지켜졌는지.
**Why human:** dev 프로젝트는 사용자의 자격 증명으로만 볼 수 있습니다. 검증자는 `gcloud`·`firebase`를 실행하지 않았습니다.

### 5. 이름 표 사업자 값 칸 (VALIDATION Manual-Only, BASE-01)
**Test:** 일곱 사업자 값 칸을 눈으로 봅니다.
**Expected:** 칸이 비어 있거나 사용자가 준 값뿐입니다 (검증 시점: 일곱 칸 모두 `(빈칸)`).
**Why human:** 「추측하지 않음」은 패턴으로 다 잡을 수 없습니다.

### 6. 01-01 판단 등급 금지 사항 (3개)
**Test:** 「금지 사항 (judgment-tier)」 표의 01-01 행(사업자 값 추측 금지, 공개 전 사업자 값 커밋 금지, 콘솔 필드를 확정 필드명처럼 적지 않음)을 검증자 판정, 근거와 함께 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다 (ADR-550 D4).

### 7. 01-02 판단 등급 금지 사항 (2개)
**Test:** 「금지 사항 (judgment-tier)」 표의 01-02 행(발급 값 추정 기재 금지, 기존 DNS 레코드 삭제·수정 안내 금지)을 검증자 판정, 근거와 함께 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다 (ADR-550 D4).

### 8. 01-03 판단 등급 금지 사항 (3개)
**Test:** 「금지 사항 (judgment-tier)」 표의 01-03 행(미확인 값을 확인된 것처럼 적지 않음, 법적 성격 단정 금지, 실제 사용자 데이터 값 옮기지 않음)을 검증자 판정, 근거와 함께 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다 (ADR-550 D4).

### 9. 01-04 판단 등급 금지 사항 (3개)
**Test:** 「금지 사항 (judgment-tier)」 표의 01-04 행(법률 항목 기본 동작을 결론처럼 적지 않음, U12 말고 「결정됨」 금지, U11 기본값 금지)을 검증자 판정, 근거와 함께 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다 (ADR-550 D4).

### 10. 01-05 판단 등급 금지 사항 (3개)
**Test:** 「금지 사항 (judgment-tier)」 표의 01-05 행(비공개 코스 삭제·공개 코스만 남음으로 적지 않음, 즉시 전부 삭제로 읽히게 적지 않음, 선택지만 있는 값 추측 금지)을 검증자 판정, 근거와 함께 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다 (ADR-550 D4).

### 11. 01-06 판단 등급 금지 사항 (3개)
**Test:** 「금지 사항 (judgment-tier)」 표의 01-06 행(옛 규칙 문장 인용 금지, 코드 설명을 미래 상태로 고쳐 쓰지 않음, 방침을 지금 코드에 반영하라는 뜻으로 읽히지 않음·지원 주소 문자열 금지)을 검증자 판정, 근거와 함께 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다 (ADR-550 D4).

### 12. 01-07 판단 등급 금지 사항 (3개)
**Test:** 「금지 사항 (judgment-tier)」 표의 01-07 행(D-21 밖 ROADMAP 내용 변경 금지, 연구 본문 수정·삭제 금지, 연구 캐시 커밋 금지)을 검증자 판정, 근거와 함께 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다 (ADR-550 D4).

### 13. 01-08 판단 등급 금지 사항 (1개)
**Test:** 「금지 사항 (judgment-tier)」 표의 01-08 행(조회하지 못한 칸을 추정값으로 채우지 않음. 나머지 세 개는 4번에서 다룸)을 검증자 판정, 근거와 함께 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다 (ADR-550 D4).

## Gaps Summary

목표를 막는 gap은 없습니다. 기준 문서 다섯 개가 실제로 있고, 내용이 구체적이며, 서로와 `CLAUDE.md`·ROADMAP을 경로로 가리킵니다. 「다음 세션이 결정을 되돌리지 않는다」는 리뷰 수정 뒤에도 성립하고, 근거는 네 가지입니다.

- 방침 구간이 두 `CLAUDE.md`에 같은 글자로 있습니다.
- 그 일치를 반복해서 확인하는 명령이 `TESTING.md`에 있습니다.
- 생성 원본에서 다시 만들어도 파일이 바뀌지 않습니다.
- 옛 규칙 문장은 0줄입니다.

이전 검증과 다른 점은 세 가지이고, 모두 이름 붙은 커밋에서 나왔습니다.
1. 이전 보고서가 열린 경고로 적었던 WR-01~03이 해소됐습니다 (`eb1e83d`, `8a0c420`, `d127c7c`).
2. 계획 실행 중 범위 가드 3건이 리뷰 수정 커밋 때문에 실패합니다. Info로 분류했습니다.
3. 01-07 truth 4의 한 구절이 `fd6504f`로 대체됐습니다. VERIFIED로 두고 대체 사실을 적었습니다.

남은 것은 사람 확인 13건입니다.

---

_Verified: 2026-11-15T15:31:18Z_
_Verifier: Claude (gsd-verifier)_
