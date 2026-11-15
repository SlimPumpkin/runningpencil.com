---
phase: 01-ground-truth-policy-reset
verified: 2026-11-15T08:25:32Z
status: human_needed
score: 48/49 must-haves verified
covered_files: [".claude/CLAUDE.md", ".gitignore", ".planning/PROJECT.md", ".planning/baseline/DATA-INVENTORY.md", ".planning/baseline/DECISIONS.md", ".planning/baseline/NAMES.md", ".planning/baseline/URLS.md", ".planning/baseline/USER-TASKS.md", ".planning/codebase/CONCERNS.md", ".planning/codebase/CONVENTIONS.md", ".planning/codebase/TESTING.md", ".planning/phases/01-ground-truth-policy-reset/01-01-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-01-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-02-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-02-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-03-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-03-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-04-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-04-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-05-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-05-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-06-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-06-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-07-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-07-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-08-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-08-SUMMARY.md", ".planning/research/STACK.md", ".planning/research/SUMMARY.md", "CLAUDE.md"]
covered_digest: "v4:sha256:630cce6a27ad438f80b4c188f07ece95c29fef67d7e05f17b8daf2f5191d1191"
behavior_unverified: 0
overrides_applied: 0
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
  - test: "데이터 목록 「CLI 조회 기록」 표의 결과와, 조회에 성공한 리전·TTL·백업·버킷 칸을 사용자가 Firebase·GCP 콘솔에서 아는 값과 견주어 본다 (01-08 human-check). 함께 확인: 01-08 실행이 조회(list) 명령만 썼고 dev 설정·데이터가 바뀌지 않았는지, 특히 SUMMARY가 적은 대로 `firebase ext:list`의 확장 API 확인 단계가 API를 새로 켜지 않았는지"
    expected: "조회한 값이 dev 프로젝트의 실제 설정과 같고, 건너뛰거나 실패한 조회의 칸은 「CLI 미확인」으로 남아 있다. 문서에 버킷 이름이나 계정 정보가 없다. dev 프로젝트의 API 사용 설정과 리소스가 조회 전과 같다. 판정 불가로 둔 01-08 금지 사항 세 개(설정·데이터 변경 금지, 다른 자격 증명 사용 금지, 문서·객체 내용 조회 금지)가 지켜졌음을 사용자가 확인한다"
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
**Verified:** 2026-11-15T08:25:32Z
**Status:** human_needed
**Re-verification:** 아니요 — 첫 검증 (이전 VERIFICATION.md 없음)

## 결론 요약

ROADMAP 성공 기준 다섯 개는 모두 저장소의 실제 파일로 확인했습니다. 기준 문서 다섯 개(`NAMES.md`, `URLS.md`, `DATA-INVENTORY.md`, `DECISIONS.md`, `USER-TASKS.md`)가 있고, 내용이 비어 있지 않으며, 서로를 경로로 가리킵니다. 두 `CLAUDE.md`에는 방침 일곱 행이 글자까지 같은 구간으로 들어 있고, 옛 규칙 문장은 0줄입니다. 차단 사항(blocker)은 없습니다.

상태가 `passed`가 아닌 이유는 사람 확인 항목이 남아 있기 때문입니다. 계획 네 개가 넘긴 human-check, VALIDATION의 Manual-Only 항목, 판단 등급 금지 사항 24개가 여기에 속합니다. 또 01-08의 「읽기 전용 조회만 했음」은 SUMMARY 서술 말고는 증거가 없어 UNCERTAIN으로 두었습니다.

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| SC1 | 운영자는 이름 표 하나에서 한글·영문 서비스명(러닝펜슬 / RunningPencil), 사업자등록증 그대로의 상호, 영문 법인명을 확인한다. 사용자가 아직 주지 않은 값은 빈칸이고, 추측해서 채운 값은 없다 | ✓ VERIFIED | `.planning/baseline/NAMES.md` 표 12행. 한글 서비스명 러닝펜슬, 영문 서비스명 RunningPencil이 있다. 「사업자등록증 그대로의 상호」·「영문 법인명」 등 일곱 행의 값 칸은 모두 `(빈칸)`이다. 사업자등록번호 꼴 숫자는 0건이다. 앱 기준 커밋 `3afb2085`의 `lib/l10n/app_ko.arb:4`·`app_en.arb:4` `appTitle`이 각각 러닝펜슬·RunningPencil이어서 표의 값과 같다 |
| SC2 | 운영자는 URL 대장 하나에서 모든 공개 URL(홈, 기존 3개, `/support/`, 위치약관, `/en/` 5개)을 apex·https·끝 슬래시 형식으로 보고, URL마다 등록할 콘솔 필드를 확인한다 | ✓ VERIFIED | `.planning/baseline/URLS.md`에 주소 행이 12줄 있다 (KO 6, EN 5, v2 예약 `/en/location-terms/` 1). 문서 안의 http 문자열은 모두 `https://runningpencil.com/…/` 꼴이다. 콘솔 칸이 빈 행은 없다. 기존 세 주소에는 「경로 고정(리디렉션 금지)」이 적혀 있다. 필드 범주가 맞는지는 사람이 확인한다 (human_verification 1) |
| SC3 | 운영자는 데이터 목록에서 개인정보 항목마다 출처·목적·저장 위치(리전)·수탁자·국외 이전·보유 기간·삭제 방식을 앱 저장소의 파일 근거와 함께 확인하고, 확인하지 못한 칸은 「미확인」으로 표시돼 있다 | ✓ VERIFIED | `DATA-INVENTORY.md`에 구간 A~H, 「확인할 것」, 「CLI 조회 기록」이 있다. 본표 A·C·D·E·F는 열 열 개짜리 데이터 행 32줄이고 빈 칸은 0개다 (구간 C의 열 수가 다른 4줄은 「위치를 읽는 세 시점」 보조 표). 「미확인」이 든 줄은 45줄이다. 근거 경로는 모두 앱 기준 커밋에 있다 (01-03·05·08 경로 검사 통과). 「courses는 공개·비공개 모두 삭제하지 않음」을 앱 `functions/src/running_pencil/cleanup_user_data.ts`(runs와 badges만 지움)에서 직접 대조했다. dev CLI 값의 정확성은 사람이 확인한다 (human_verification 4) |
| SC4 | 운영자는 결정 목록(U2·U3·U5~U9·U11~U13)과 사용자가 할 외부 작업 목록(가비아 DNS 레코드 표, 메일 수신 시험 절차, 사업자 값, 앱 화면 캡처)을 받아, 항목마다 어느 단계를 막는지 안다 | ✓ VERIFIED | `DECISIONS.md` 「한눈에 보기」에 U2, U3, U5, U6-가, U6-나, U7, U8, U9, U11, U12, U13, P1 열두 행이 있고 행마다 막는 단계·마감 단계가 적혀 있다. 이 막는 단계를 ROADMAP External Gates 표와 대조했고 어긋난 행은 없다. U12는 표에서 지워졌고 「이미 결정된 항목」에 있다. `USER-TASKS.md` 「한눈에 보기」에는 작업 0~12와 막는 단계가 있다. DNS 레코드 표는 작업 2·6, 외부 4곳 수신 시험은 작업 4와 기록 양식, 사업자 값은 작업 9, 화면 캡처는 작업 10에 있다. 작업 6의 막는 단계 해석은 사람이 확인한다 (human_verification 2) |
| SC5 | `CLAUDE.md`가 지원 이메일 공개, 사업자 정보 표시, 영문명 RunningPencil, 한국어+영어, Jekyll 빌드 전환, 포인트·굿즈·코스북 제거를 현재 방침으로 설명하고, 옛 규칙 문장이 남아 있지 않다 | ✓ VERIFIED | 두 `CLAUDE.md`의 「이번 마일스톤 방침 (2026-11 결정)」 표에 일곱 행(위 여섯 + `noindex` 해제)이 있다. 두 파일에서 뽑은 구간을 `diff`로 비교했고 차이는 0이다. 다섯 방침 파일(`CLAUDE.md`, `.claude/CLAUDE.md`, `CONVENTIONS.md`, `TESTING.md`, `CONCERNS.md`)에서 옛 규칙 문장 꼴은 0줄이다. 계획의 검사 명령과, 검증자가 따로 넓힌 정규식 둘 다로 확인했다. `generate-claude-md`로 다시 생성한 사본이 저장소 파일과 `cmp`로 같다. 방침 구간은 GSD 마커 위에 있어 재생성 뒤에도 남는다 |

### Plan must_haves (계획별)

| Plan | Truths | Status | Evidence |
|------|--------|--------|----------|
| 01-01 | 6 | ✓ 6/6 VERIFIED | 이름 표 다섯 값과 일곱 `(빈칸)` 행이 있다. URL 대장 11+1행이 있다. `/location-terms/`는 확정값이고 `/en/location-terms/`는 「예약」이다. 영문명 금지 문장은 0줄이다. CONVENTIONS→`.claude/CLAUDE.md`→루트 `CLAUDE.md`가 모두 이름 표 경로를 가리킨다. 마커 위 구간은 재생성 뒤에도 남는다. 18개 검사 명령이 모두 exit 0이다 |
| 01-02 | 5 | ✓ 5/5 VERIFIED | DNS 1차(인증 TXT, MX, SPF 1개, Search Console TXT)와 2차(DKIM) 방문 절차가 있다. 서비스가 발급하는 값은 「콘솔에서 복사」로 적혀 있다. 보존할 기존 레코드 표가 있고 「지우는 레코드는 없습니다」라고 적혀 있다. 외부 4곳 수신 시험과 작업 9~12가 있다. 11개 명령이 exit 0이다 |
| 01-03 | 6 | ✓ 6/6 VERIFIED | 머리에 기준 커밋 `3afb2085`, 재확인 명령, 근거 경로 목록이 있다. B 구간 여덟 행의 필수·선택 칸은 「미확인」이다. 「위치를 읽는 세 시점」 표가 있다. 근거 경로가 기준 커밋에 있다. 「CLI로만 알 수 있는 값은 CLI 미확인」 truth는 01-08이 그 칸을 모두 「근거: dev CLI, 2026-11-15 조회」 값으로 바꿔 대체(superseded)했다. 근거 표기가 붙지 않은 리전 칸은 없다 |
| 01-04 | 6 | ✓ 6/6 VERIFIED | 「한눈에 보기」 12행이 있다. 「결정됨」은 U12뿐이다. U6은 가·나로 나뉘어 있다. 마지막 구간은 「조사에서 새로 나온 항목」 N1~N7이다. 11개 명령이 exit 0이다 |
| 01-05 | 5 | ✓ 5/5 VERIFIED | 구간 G에 코스가 공개·비공개 모두 삭제되지 않는다고 적혀 있다 (코드 대조 완료). 메뉴 이름 「회원탈퇴」(`app_ko.arb:349`)와 180일 상한이 있다. H는 데이터 행 20줄이고(01-05의 18행에서 01-08이 PITR·백업 행 등을 나눔) 행마다 근거 종류가 있다. 「확인할 것」에 담당·방법·막는 단계가 짝지어 있다 |
| 01-06 | 5 | ✓ 5/5 VERIFIED | 방침 일곱 행과 「작업 규칙」 여섯 항목이 있고 원본 경로(`.planning/ROADMAP.md` Ground Rules)가 적혀 있다. 옛 규칙 꼴 9종은 0줄이다. 상태 문장에 「2026-11 기준」이 붙어 있다. 재생성 뒤에도 파일이 같다. 지원 주소 문자열은 두 `CLAUDE.md`에 0건이다 |
| 01-07 | 7 | ✓ 7/7 VERIFIED | ROADMAP·STATE에 채택하지 않은 메일 서비스 이름이 0건이다. External Gates 표에 U12 행이 없다. Phase 8 Notes는 `/location-terms/`를 확정값으로 적는다. 연구 문서 두 개는 단계 시작 대비 삭제 줄이 0이다 (추가 8줄·16줄). `.planning/research/.cache/`는 `.gitignore`에 있고 추적되는 파일이 0개다 |
| 01-08 | 4 | ⚠️ 3/4 VERIFIED, 1 UNCERTAIN | 「CLI 조회 기록」은 8행이고 모두 「조회함」이다. 조회 값 칸에는 「근거: dev CLI」와 조회일이 붙어 있다. 프로젝트 번호·버킷·VM 이름·IP·계정 이메일은 0건이다 (누출 정규식으로 확인). **UNCERTAIN:** 「읽기 전용 명령만 썼고 dev 설정과 데이터가 바뀌지 않았다」는 SUMMARY 서술 말고 저장소에 증거가 없다 → human_verification 4 |

**Score:** 48/49 truths verified (SC 5 + 계획 truth 44. UNCERTAIN 1, PRESENT_BEHAVIOR_UNVERIFIED 0)

### 금지 사항 (judgment-tier, 비권위적 LLM 판정 — unverified-prohibition, human review recommended)

24개 모두 `verification: judgment`입니다. 아래 판정은 검증자의 비권위적 판정이고, 사용자가 항목마다 확인합니다 (Human Verification 4번과 6~13번).

| Plan | 금지 사항 (요지) | 검증자 판정 | 근거 |
|------|------------------|-------------|------|
| 01-01 | 사업자 사실값을 추측해 채우지 않는다 | 지켜짐 | 일곱 칸이 모두 `(빈칸)` |
| 01-01 | 공개 전 사업자 사실값을 어떤 커밋에도 넣지 않는다 | 지켜짐 | `git log -p dcc2002..HEAD`의 추가 줄 전체에 누출 정규식 전체(IP, 12자리 숫자, 계정 이메일, 앱 ID, 인증 토큰, API 키, DKIM 키)와 허용 목록 필터를 적용했다. 남은 줄 3줄은 모두 40자 커밋 해시 안의 숫자열이고, 해시를 가리면 0줄이다. 사업자등록번호 꼴은 0건이다 |
| 01-01 | 콘솔 필드를 확정된 필드명처럼 적지 않는다 | 지켜짐 (사람 확인 필요) | 머리 문단에 「범주 수준, Phase 10에서 확정」이 있다. EN 행에는 「Phase 10에서 확정」·「후보」가 적혀 있다 |
| 01-02 | 발급 값(인증 TXT·Search Console TXT·DKIM 키)을 추정으로 적지 않는다 | 지켜짐 | 값 칸이 「콘솔에서 복사」로 적혀 있다. `google-site-verification=` 값과 DKIM 키 꼴은 0건 |
| 01-02 | 기존 DNS 레코드를 지우거나 고치라고 안내하지 않는다 | 지켜짐 | 「보존할 기존 레코드」 표의 처리 칸이 모두 「그대로 둡니다」이고, 「지우는 레코드는 없습니다」라고 적혀 있다 |
| 01-03 | 확인하지 못한 값을 확인된 것처럼 적지 않는다 | 지켜짐 | 리전 칸마다 근거 종류가 붙어 있다. prod 관련 칸은 「미확인 (prod 리전에 따름)」이다 |
| 01-03 | 수탁·제3자 제공·국외 이전의 법적 성격을 단정하지 않는다 | 지켜짐 | 머리에 「법적 구분은 Phase 7에서」라고 적혀 있다. 국외 이전 칸에는 저장 위치 사실만 있다 |
| 01-03 | 실제 사용자 데이터 값(uid·이메일·좌표·토큰)을 옮기지 않는다 | 지켜짐 | 필드 이름과 형태만 있다. 누출 정규식 0건 |
| 01-04 | 법률 판단 항목(U2·U3·U7)의 기본 동작을 법적 결론처럼 적지 않는다 | 지켜짐 (사람 확인 필요) | 계획 검사(「초안·법률 확인 필요」 표시)가 통과했다. 문구를 받아들일지는 human_verification 3에서 본다 |
| 01-04 | 사용자가 정하지 않은 항목을 「결정됨」으로 적지 않는다 | 지켜짐 | 「결정됨」은 U12뿐이다. `01-CONTEXT.md` D-10(U12 결정됨)·D-11·D-19가 사용자 결정의 근거다 |
| 01-04 | U11에 기본값이나 추측값을 적지 않는다 | 지켜짐 | U11은 render-if-present로 숨긴다고만 적혀 있다 |
| 01-05 | 탈퇴 때 비공개 코스가 지워진다거나 공개 코스만 남는다고 적지 않는다 | 지켜짐 | 「삭제하지 않음 (공개·비공개 모두)」. 앱 `cleanup_user_data.ts`가 runs와 badges만 지우는 것을 확인했다 |
| 01-05 | 탈퇴하면 모든 데이터가 곧바로 지워진다고 읽히게 적지 않는다 | 지켜짐 | 구간 G에 탈퇴 뒤에도 남거나 서비스 보존 기간에 맡기는 행(코스, `rate_limits`, `mail`, Analytics·Crashlytics의 uid, 함수 로그)이 있다. 「서비스에서의 삭제」와 「백업에서의 제거(180일)」를 나눠 쓰라는 문장이 있다 |
| 01-05 | 선택지만 있는 값(Analytics 보존 등)에 기본값을 추측해 채우지 않는다 | 지켜짐 | Analytics 보존은 「미확인 (콘솔 설정값. 선택지는 2개월 또는 14개월)」 |
| 01-06 | 옛 규칙 문장을 인용하거나 부정문으로 되풀이하지 않는다 | 지켜짐 | 옛 문장 꼴 0줄. 뒤집은 방침에는 「이전 방침을 뒤집음」만 적혀 있다 |
| 01-06 | 코드 설명 구간을 미래 상태로 고쳐 쓰지 않는다 | 지켜짐 | Tailwind CDN, `python3 -m http.server`, 복사된 공통 블록 설명이 그대로 있다. 「Phase 2까지 유효」 같은 날짜 표시만 붙었다 |
| 01-06 | 방침을 지금 코드에 반영해도 된다고 읽히게 적지 않는다, 지원 주소 문자열을 두 `CLAUDE.md`에 적지 않는다 | 지켜짐 | 머리 문단에 「적용 단계가 오기 전에는 사이트 코드에 반영하지 않습니다」가 있다. 두 파일의 `support@` 문자열은 0건. HTML·`_config.yml`·매니페스트의 이메일 꼴도 0건 |
| 01-07 | D-21이 꼽지 않은 ROADMAP 내용을 바꾸지 않는다 | 지켜짐 (계획 검사 기준) | 01-07 verify 18개가 exit 0이다. 단계 목표와 성공 기준 문장은 그대로다 |
| 01-07 | 연구 문서 본문을 고치거나 지우지 않는다 | 지켜짐 | 두 파일 모두 단계 시작 대비 삭제 줄이 0이다 |
| 01-07 | `.planning/research/.cache/`의 내용을 커밋하지 않는다 | 지켜짐 | `git ls-files` 결과 0개 |
| 01-08 | dev 설정·데이터를 바꾸거나 리소스를 만들고 지우거나 배포하지 않는다 | 판정 불가 (UNCERTAIN) | SUMMARY 서술만 있다. human_verification 4 |
| 01-08 | 사용자가 재로그인하지 않았을 때 다른 자격 증명을 찾아 쓰지 않는다 | 판정 불가 (UNCERTAIN) | SUMMARY에 「Task 1 확인 명령이 재인증 오류 없이 끝남」이라고만 적혀 있다 |
| 01-08 | Firestore 문서·Storage 객체 내용을 조회하지 않는다 | 판정 불가 (UNCERTAIN) | SUMMARY의 명령 표에는 list 명령 8종만 있다. 저장소에는 증거가 없다 |
| 01-08 | 조회하지 못한 칸을 추정값으로 채우지 않는다 | 지켜짐 | 조회 8건이 모두 「조회함」이고 값 칸마다 「근거: dev CLI, 2026-11-15 조회」가 붙어 있다 |

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `.planning/baseline/NAMES.md` | 이름 표 (BASE-01) | ✓ VERIFIED | 12행 표, 표시명 규칙, 앱 쪽 표시명 대조 표. `verify.artifacts` 통과 |
| `.planning/baseline/URLS.md` | URL 대장 (BASE-02) | ✓ VERIFIED | 주소 12행, 도메인만 등록하는 칸 표 |
| `.planning/baseline/DATA-INVENTORY.md` | 데이터 목록 (BASE-03) | ✓ VERIFIED | 구간 A~H, 확인할 것, CLI 조회 기록. 근거 경로 62개가 기준 커밋에 있다 |
| `.planning/baseline/DECISIONS.md` | 결정 목록 (BASE-04) | ✓ VERIFIED | 한눈에 보기 12행, 항목별 풀이, N1~N7 |
| `.planning/baseline/USER-TASKS.md` | 사용자 작업 절차서 (BASE-04) | ✓ VERIFIED | 작업 0~12, 보존 레코드 표, dig 명령, 수신 시험 기록 양식 |
| `CLAUDE.md` | 방침 표 7행, 작업 규칙 (BASE-05) | ✓ VERIFIED | 3행 다음에 방침 구간이 있다 |
| `.claude/CLAUDE.md` | 마커 위 방침 구간, 재생성 블록 | ✓ VERIFIED | 재생성 결과와 `cmp`로 같다 |
| `.planning/codebase/CONVENTIONS.md` | 생성 원본의 상태 문장 | ✓ VERIFIED | 「2026-11 기준」 줄이 있고 이름 표 경로를 가리킨다 |
| `.planning/ROADMAP.md`, `STATE.md`, `PROJECT.md`, `research/STACK.md`, `research/SUMMARY.md` | U12·DNS·위치약관 정합 | ✓ VERIFIED | `verify.artifacts` 5/5 통과 |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `CONVENTIONS.md` | `NAMES.md` / `.claude/CLAUDE.md` | 서비스 이름 줄이 이름 표 경로를 가리키고 생성기가 옮김 | ✓ WIRED | `verify.key-links` 01-01 3/3 |
| `CLAUDE.md` | `.claude/CLAUDE.md` | 「이번 마일스톤 방침」 구간이 같음 | ✓ WIRED | 구간 `diff` 0 |
| `CLAUDE.md` | `.planning/ROADMAP.md` | 작업 규칙이 Ground Rules를 가리킴 | ✓ WIRED | 01-06 3/3 |
| `USER-TASKS.md` | `NAMES.md` | 지원 주소·사업자 항목 이름이 같음 | ✓ WIRED | 01-02 1/1 |
| `DATA-INVENTORY.md` | `DECISIONS.md` / `USER-TASKS.md` | 「prod 리전」, U6·N 항목, 작업 11·12 | ✓ WIRED | 01-03 1/1, 01-05 2/2, 01-08 1/1 |
| `DECISIONS.md` | `ROADMAP.md` / `USER-TASKS.md` | 막는 단계가 External Gates와 같음, U11·U12 작업 번호 | ✓ WIRED | 01-04 2/2. 막는 단계는 직접 대조해 어긋남이 없었다 |
| `ROADMAP.md`, `research/*.md` | `USER-TASKS.md` / `DECISIONS.md` | Phase 5 문장과 연구 메모가 정본을 가리킴 | ✓ WIRED | 01-07 4/4 |

### Data-Flow Trace (Level 4)

해당 없음. 이 단계의 산출물은 문서뿐이고, 동적 데이터를 그리는 코드가 없습니다.

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| 계획 8개의 `<automated>` 검사 전체 | 111개 명령을 저장소 루트에서 `bash`로 하나씩 실행 (임시 파일은 scratchpad) | 109 exit 0, 2 exit 1 | ✓ PASS (2개는 superseded) |
| superseded 2건 | `01-03` verify 10, `01-05` verify 9 | 두 명령 모두 「CLI 미확인」이 5줄·8줄 이상이어야 통과한다. 지금은 3줄이다 (01-08이 그 칸을 dev CLI 값으로 채웠기 때문). 01-03 verify 10의 항목 검사 부분(`miss`)은 빈 값이고, 01-05 verify 9의 구조 검사 부분은 `rows=12 bad=`로 통과한다 | ℹ️ 의도된 대체 |
| 재생성 불변 | `generate-claude-md --output <임시 사본>` 후 `cmp` | 같음 | ✓ PASS |
| 라이브 사이트 불변 | `git diff --quiet dcc2002… -- '*.html' _config.yml favicon/ CNAME ':(exclude)favicon/app-icon-*.png'` | exit 0 | ✓ PASS |
| 앱 저장소 읽기 전용 | `git -C ~/dv/woody/running_pencil rev-parse HEAD` | `3afb2085` (기준 커밋 그대로) | ✓ PASS |
| 커밋 존재 | `verify.commits` (SUMMARY의 17개 해시) | 17/17 valid | ✓ PASS |
| 검증 실행이 저장소를 바꾸지 않음 | 실행 전후 `git status --porcelain`, 설정·`CLAUDE.md` 해시 비교 | 같음 | ✓ PASS |

### Probe Execution

해당 없음. `scripts/` 디렉터리가 없고, 계획에 선언된 probe도 없습니다.

### Test Quality Audit

해당 없음. 이 저장소에는 시험 프레임워크가 없고, 이 단계의 검증은 문서 검사 셸 명령입니다. 요구사항에 연결된 시험 파일, 비활성 시험, 순환 시험은 0개입니다.

## Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| BASE-01 | 01-01 | 이름 표 하나로 한글·영문 서비스명, 상호, 영문 법인명 확인 | ✓ SATISFIED | SC1 |
| BASE-02 | 01-01 | URL 대장 하나로 공개 URL과 콘솔 필드 확인 | ✓ SATISFIED | SC2 (필드 범주 적절성은 사람 확인) |
| BASE-03 | 01-03, 01-05, 01-08 | 앱 저장소 근거의 데이터 목록. 처리방침·삭제 안내·약관이 이 목록에서 나온다 | ✓ SATISFIED | SC3. 「법적 문서가 이 목록에서 나온다」 부분은 Phase 6~8에서 이루어진다. 지금은 `CLAUDE.md` 작업 규칙(「법적 본문에는 데이터 목록에 있는 사실만 씁니다」)과 ROADMAP Phase 6·7 성공 기준이 이를 강제한다 |
| BASE-04 | 01-02, 01-04, 01-07 | 사용자·법률 결정 목록과 막는 단계 | ✓ SATISFIED | SC4 |
| BASE-05 | 01-01, 01-06 | `CLAUDE.md`가 바뀐 방침을 설명 | ✓ SATISFIED | SC5 |

REQUIREMENTS.md의 추적 표에서 `| Phase 1 |`로 배정된 ID는 BASE-01~05 다섯 개뿐이고, 모두 계획 frontmatter에 있습니다. ORPHANED 요구사항은 없습니다.

## Decision Coverage

All trackable CONTEXT.md decisions are honored by shipped artifacts. (21/21, `check.decision-coverage-verify`)

## Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `.planning/ROADMAP.md` | 83, 98, 112, 127, 146, 162, 178, 193, 209, 256-264 | `TBD` (`**Plans**: TBD`, Progress 표 `0/TBD`) | ℹ️ Info | 이 단계에서 더한 줄이 아닙니다 (`git diff dcc2002..HEAD`의 추가 줄 0건). 아직 계획하지 않은 Phase 2~10의 계획 칸이고, 각 단계의 plan-phase가 채웁니다. 이 단계의 미완성 표시가 아닙니다 |
| `CLAUDE.md:23`, `.claude/CLAUDE.md:19` | — | WR-01: 작업 규칙에서 「빠지면 안 되는 조항은 값이 올 때까지 커밋 보류」 단서가 빠짐 | ⚠️ Warning | 성공 기준 5는 충족합니다. 다만 ROADMAP을 읽지 않는 세션은 필수 조항(보호책임자, 위치약관 사업자 정보)을 숨긴 채 커밋할 수 있습니다. Phase 7·8 전에 고치기를 권합니다 (01-REVIEW.md) |
| `CLAUDE.md:19-30` | — | WR-02: 작업 규칙이 「원본은 Ground Rules」라고 밝히지만 목록이 원본과 다름 | ⚠️ Warning | 01-06 계획의 「여섯 규칙」 truth는 충족합니다. 다만 Ground Rules 가운데 빠진 규칙(배포마다 세 URL 확인, Jekyll 3.10.0 고정, 방침을 바꾸는 단계는 `CLAUDE.md`도 함께 수정)이 있습니다 |
| `CLAUDE.md:7`, `.claude/CLAUDE.md:3` | — | WR-03: 두 사본의 방침 구간을 반복해서 비교하는 절차가 없음 | ⚠️ Warning | 지금은 두 구간이 같습니다 (`diff` 0). Phase 2·3·5·9에서 상태 열을 고칠 때 두 사본이 어긋날 위험이 있습니다 |
| `.claude/CLAUDE.md` 외 | — | IN-01~IN-05 (01-REVIEW.md) | ℹ️ Info | 문구 정합 문제입니다. 목표 달성에는 영향이 없습니다 |

검증자가 직접 대조한 사실: 이 단계 커밋들(`dcc2002..HEAD`)의 추가 줄 전체에 누출 정규식 전체를 적용했습니다. 허용 목록 값(GitHub Pages 공개 A 레코드 등)을 빼면 3줄이 남고, 모두 40자 커밋 해시 안의 숫자열입니다. 해시를 가리면 0줄입니다.

## Human Verification Required

이 단계는 문서 단계이지만, 아래 항목은 계획자가 `end-of-phase`로 미룬 human-check, VALIDATION Manual-Only, 판단 등급 금지 사항입니다. 검증자가 만든 인위적인 단계는 없습니다.

### 1. URL 대장 콘솔 필드 범주 (01-01)

**Test:** URL 대장의 「등록할 콘솔 필드(범주)」 열을 제공자·스토어별로 훑어봅니다.
**Expected:** URL마다 등록할 곳이 범주 수준으로 적혀 있고, 확인되지 않은 필드명을 확정된 것처럼 적은 칸이 없습니다.
**Why human:** 콘솔 필드 범주가 맞는지는 사람의 판단이 필요합니다.

### 2. 절차서의 막는 단계 대조 (01-02)

**Test:** 작업 0~12의 「막는 단계」를 ROADMAP External Gates 표와 대조합니다. 검증자가 찾은 어긋날 수 있는 점이 하나 있습니다. 절차서는 작업 6(DKIM, DNS 2차 방문)을 「Phase 10 Apple 릴레이」를 막는 작업으로 적고 「이메일 게이트는 DKIM을 기다리지 않는다」고 씁니다. 그런데 ROADMAP External Gates 표의 가비아 DNS 행은 1차·2차 방문(DKIM 포함)을 묶어 Phase 5를 막는다고 적습니다. 검증자는 이 점을 해소하지 않았습니다.
**Expected:** 작업 0~12의 막는 단계가 ROADMAP의 게이트와 어긋나지 않습니다 (DNS·메일은 Phase 5, 화면 캡처는 Phase 4, DKIM은 Phase 10의 릴레이 답장 전제).
**Why human:** 단계 의존 관계를 정하려면 ROADMAP을 해석해야 합니다.

### 3. 결정 목록의 막는 단계와 법률 항목 문구 (01-04)

**Test:** 「한눈에 보기」의 막는 단계를 ROADMAP External Gates와 대조하고, U2·U3·U7의 「기본 동작」 문구를 읽습니다.
**Expected:** 막는 단계가 어긋나지 않습니다. 법률 판단 항목의 기본 동작은 결론이 아니라 임시 방침으로 읽히고, 사용자가 받아들일 수 있는 문구입니다.
**Why human:** 법률 판단 항목에서 무엇이 보수적인 쪽인지는 사용자가 확인해야 합니다. (검증자 대조 결과: 막는 단계 칸은 ROADMAP과 모두 같습니다.)

### 4. dev CLI 값과 조회 과정 (01-08)

**Test:** 「CLI 조회 기록」과 리전·TTL·백업·버킷 칸을 Firebase·GCP 콘솔의 값과 견주어 봅니다. 01-08이 list 명령만 썼는지, dev 설정·데이터가 바뀌지 않았는지, 다른 자격 증명을 쓰지 않았는지 확인합니다. SUMMARY에 따르면 `firebase ext:list`는 실행할 때 확장 API가 켜져 있는지 확인하는 단계를 거쳤습니다. 이 단계가 API를 새로 켜지 않았는지도 봅니다.
**Expected:** 값이 dev의 실제 설정과 같고, API 사용 설정과 리소스가 조회 전과 같습니다. 판정 불가로 둔 01-08 금지 사항 세 개(설정·데이터 변경 금지, 다른 자격 증명 사용 금지, 문서·객체 내용 조회 금지)도 이 확인으로 해소합니다.
**Why human:** dev 프로젝트는 사용자의 자격 증명으로만 볼 수 있습니다. 검증자는 지시에 따라 `gcloud`·`firebase`를 실행하지 않았습니다.

### 5. 이름 표 사업자 값 칸 (VALIDATION Manual-Only, BASE-01)

**Test:** 일곱 사업자 값 칸을 눈으로 봅니다.
**Expected:** 칸이 비어 있거나 사용자가 준 값뿐입니다. 검증 시점에는 일곱 칸 모두 `(빈칸)`이었습니다.
**Why human:** 「추측하지 않음」은 패턴으로 다 잡을 수 없습니다.

### 6. 01-01 판단 등급 금지 사항 (3개)

**Test:** 「금지 사항 (judgment-tier)」 표의 01-01 행(사업자 값 추측 금지, 공개 전 사업자 값 커밋 금지, 콘솔 필드를 확정 필드명처럼 적지 않음)을 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다.

### 7. 01-02 판단 등급 금지 사항 (2개)

**Test:** 「금지 사항 (judgment-tier)」 표의 01-02 행(발급 값 추정 기재 금지, 기존 DNS 레코드 삭제·수정 안내 금지)을 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다.

### 8. 01-03 판단 등급 금지 사항 (3개)

**Test:** 「금지 사항 (judgment-tier)」 표의 01-03 행(미확인 값을 확인된 것처럼 적지 않음, 법적 성격 단정 금지, 실제 사용자 데이터 값 옮기지 않음)을 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다.

### 9. 01-04 판단 등급 금지 사항 (3개)

**Test:** 「금지 사항 (judgment-tier)」 표의 01-04 행(법률 항목 기본 동작을 결론처럼 적지 않음, U12 말고 「결정됨」 금지, U11 기본값 금지)을 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다.

### 10. 01-05 판단 등급 금지 사항 (3개)

**Test:** 「금지 사항 (judgment-tier)」 표의 01-05 행(비공개 코스 삭제·공개 코스만 남음으로 적지 않음, 즉시 전부 삭제로 읽히게 적지 않음, 선택지만 있는 값 추측 금지)을 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다.

### 11. 01-06 판단 등급 금지 사항 (3개)

**Test:** 「금지 사항 (judgment-tier)」 표의 01-06 행(옛 규칙 문장 인용 금지, 코드 설명을 미래 상태로 고쳐 쓰지 않음, 방침을 지금 코드에 반영하라는 뜻으로 읽히지 않음·지원 주소 문자열 금지)을 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다.

### 12. 01-07 판단 등급 금지 사항 (3개)

**Test:** 「금지 사항 (judgment-tier)」 표의 01-07 행(D-21 밖 ROADMAP 내용 변경 금지, 연구 본문 수정·삭제 금지, 연구 캐시 커밋 금지)을 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다.

### 13. 01-08 판단 등급 금지 사항 (1개)

**Test:** 「금지 사항 (judgment-tier)」 표의 01-08 행(조회하지 못한 칸을 추정값으로 채우지 않음 (나머지 세 개는 위 01-08 항목에서 다룸))을 읽습니다.
**Expected:** 각 항목의 검증자 판정에 동의합니다. 동의하지 않는 항목은 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없습니다.

## Gaps Summary

목표를 막는 gap은 없습니다. 기준 문서 다섯 개가 실제로 있고, 내용이 구체적이며(필드 단위, 근거 경로와 행 번호, 막는 단계), 서로와 `CLAUDE.md`·ROADMAP을 경로로 가리킵니다. 「다음 세션이 결정을 되돌리지 않는다」는 다음 세 가지로 뒷받침됩니다.

- 방침 구간이 두 `CLAUDE.md`에 같은 글자로 있습니다.
- 생성 원본(`CONVENTIONS.md`)에도 새 문장이 있어 재생성해도 옛 방침으로 돌아가지 않습니다.
- 옛 규칙 문장이 0줄입니다.

남은 것은 사람 확인 13건(계획 human-check 4, VALIDATION Manual-Only 1, 계획별 금지 사항 8)과 경고 3건(WR-01~03)입니다. 경고는 목표 달성을 막지 않습니다. 다만 WR-01(필수 조항 커밋 보류 단서)은 Phase 7·8 전에 고치는 것이 안전합니다.

---

_Verified: 2026-11-15T08:25:32Z_
_Verifier: Claude (gsd-verifier)_
