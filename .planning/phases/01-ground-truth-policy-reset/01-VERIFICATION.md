---
phase: 01-ground-truth-policy-reset
verified: 2026-11-15T19:00:46Z
status: passed
score: 60/60 must-haves verified
covered_files: [".claude/CLAUDE.md", ".gitignore", ".planning/PROJECT.md", ".planning/REQUIREMENTS.md", ".planning/ROADMAP.md", ".planning/STATE.md", ".planning/baseline/DATA-INVENTORY.md", ".planning/baseline/DECISIONS.md", ".planning/baseline/NAMES.md", ".planning/baseline/URLS.md", ".planning/baseline/USER-TASKS.md", ".planning/codebase/ARCHITECTURE.md", ".planning/codebase/CONCERNS.md", ".planning/codebase/CONVENTIONS.md", ".planning/codebase/STACK.md", ".planning/codebase/STRUCTURE.md", ".planning/codebase/TESTING.md", ".planning/phases/01-ground-truth-policy-reset/01-01-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-01-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-02-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-02-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-03-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-03-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-04-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-04-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-05-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-05-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-06-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-06-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-07-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-07-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-08-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-08-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-09-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-09-SUMMARY.md", ".planning/phases/01-ground-truth-policy-reset/01-10-PLAN.md", ".planning/phases/01-ground-truth-policy-reset/01-10-SUMMARY.md", ".planning/research/STACK.md", ".planning/research/SUMMARY.md", "CLAUDE.md"]
covered_digest: "v4:sha256:fd65ad95ee50a00b6e45ee8477abf6415f471eb57ecd97c12800126b55b60690"
behavior_unverified: 0
overrides_applied: 0
re_verification:
  previous_status: human_needed
  previous_score: 48/49
  gaps_closed:
    - "G-01-2 (UAT Test 2): ROADMAP External Gates 표·Phase 5·Phase 10 External gates·STATE Blockers가 가비아 DNS 2차 방문(DKIM)을 Phase 10만 막는 작업으로 적는다 (01-09, 0232a75·31f3b52)"
    - "G-01-8 (UAT Test 8): 데이터 목록 머리에 「수탁자」 열의 분류 출처(PRIV-03, Phase 7 성공 기준 2)가 있고 Meta (Facebook SDK) 행에 Phase 7 미정 단서가 있다 (01-10, 24ba63b)"
  gaps_remaining: []
  regressions: []
  note: "이전 보고서(2026-11-15T15:31:18Z)에는 gaps가 없어서 첫 검증 방식으로 must-have 60개 전부를 다시 확인했다. 위 두 gap은 이전 VERIFICATION이 아니라 01-UAT.md에서 나왔고, gap closure 계획 01-09·01-10이 닫았다. 이전 검증 뒤 단계 디렉터리 밖에서 바뀐 파일은 ROADMAP.md, STATE.md, DATA-INVENTORY.md 세 개다"
decision_coverage:
  honored: 21
  total: 21
  not_honored: []
human_verification:
  - test: "URL 대장의 「등록할 콘솔 필드(범주)」 열을 제공자·스토어별로 훑어본다 (01-01 human-check. 2026-11-15 UAT Test 1에서 pass로 기록됨)"
    expected: "URL마다 등록할 곳이 범주 수준으로 적혀 있고, 확인되지 않은 필드명을 확정된 것처럼 적은 칸이 없다"
    why_human: "콘솔 필드 범주가 맞는지는 사람의 판단이 필요하다 (VALIDATION Manual-Only, BASE-02)"
  - test: "절차서의 작업마다 「막는 단계」를 `.planning/ROADMAP.md`의 External Gates 표와 대조한다 (01-02 human-check. UAT Test 2에서 issue로 기록된 뒤 01-09가 고쳤다. 아래 01-09 항목과 같은 확인이다)"
    expected: "작업 0~12의 막는 단계가 ROADMAP의 게이트와 어긋나지 않는다 (DNS·메일은 Phase 5, 화면 캡처는 Phase 4, DKIM은 Phase 10의 릴레이 답장 전제)"
    why_human: "단계 의존 관계는 ROADMAP 해석이 필요하다 (VALIDATION Manual-Only, BASE-04)"
  - test: "「한눈에 보기」의 막는 단계 칸을 `.planning/ROADMAP.md`의 External Gates 표와 대조하고, U2·U3·U7의 「기본 동작」 문구를 읽는다 (01-04 human-check. UAT Test 3에서 pass로 기록됨. 01-09가 External Gates 표의 가비아 행을 나눴지만 결정 목록 행은 그대로다)"
    expected: "항목마다 막는 단계가 ROADMAP의 게이트와 어긋나지 않는다. 법률 판단 항목의 기본 동작이 결론이 아니라 임시 방침으로 읽히고 사용자가 받아들일 수 있는 문구다"
    why_human: "단계 의존 관계는 ROADMAP 해석이 필요하고 (VALIDATION Manual-Only, BASE-04), 법률 판단 항목에서 무엇이 보수적인 쪽인지는 계획자의 해석이라 사용자가 확인해야 한다"
  - test: "「CLI 조회 기록」 표의 결과와, 조회에 성공한 리전·TTL·백업·버킷 칸을 사용자가 Firebase·GCP 콘솔에서 아는 값과 견주어 본다 (01-08 human-check. UAT Test 4에서 pass로 기록됨)"
    expected: "조회한 값이 dev 프로젝트의 실제 설정과 같고, 건너뛰거나 실패한 조회의 칸은 「CLI 미확인」으로 남아 있다. 문서에 버킷 이름이나 계정 정보가 없다"
    why_human: "dev 프로젝트의 실제 설정은 사용자의 자격 증명으로만 볼 수 있다 (VALIDATION Manual-Only, BASE-03)"
  - test: "이름 표(.planning/baseline/NAMES.md)의 상호·대표자·사업자등록번호·주소 칸마다 출처(사용자 제공/빈칸)를 눈으로 확인한다 (VALIDATION Manual-Only, BASE-01. UAT Test 5에서 pass로 기록됨)"
    expected: "이름 표의 상호·대표자·주소·사업자등록번호 칸이 비어 있거나 사용자가 준 값뿐이다 (검증 시점 관찰: 사업자 값 일곱 칸 모두 「(빈칸)」)"
    why_human: "「추측하지 않음」은 패턴으로 다 잡을 수 없다 (VALIDATION Manual-Only)"
  - test: "절차서(`.planning/baseline/USER-TASKS.md`) 「한눈에 보기」의 작업 0~12 막는 단계를 ROADMAP External Gates 표, Phase 5·Phase 10 External gates, STATE Blockers와 견주어 어긋나는 곳이 없는지 본다. 특히 작업 6(DKIM)이 세 문서 모두에서 Phase 10만 막고, 2차 방문의 작업 시점은 Phase 5 무렵으로 남았는지 본다 (01-09 human-check, UAT Test 2 재확인)"
    expected: "절차서 작업 0~12의 막는 단계가 ROADMAP 표, Phase 5·10 External gates, STATE Blockers와 어긋나지 않는다. 작업 6(DKIM)은 세 문서 모두에서 Phase 10만 막고, 2차 방문의 작업 시점은 Phase 5 무렵이다 (01-09 human-check는 <expected>를 따로 두지 않아 <human-check> 본문의 확인 기준을 옮김)"
    why_human: "세 문서의 문장 뜻이 같은지는 사람이 읽고 판단해야 한다 (01-09-SUMMARY coverage D4). 검증자 대조 결과: 어긋난 곳 없음"
  - test: "데이터 목록 머리의 새 줄과 구간 E Meta (Facebook SDK) 행을 읽는다 (01-10 human-check, UAT Test 8 재확인, VALIDATION Manual-Only 5행)"
    expected: "Meta가 수탁자로 정해진 것처럼 읽히지 않고, 머리의 새 줄이 「읽는 법」의 수탁자 정의(법적 성격은 여기서 정하지 않음)와 함께 읽어도 어긋나지 않는다 (01-10 human-check는 <expected>를 따로 두지 않아 <human-check> 본문의 확인 기준을 옮김)"
    why_human: "문장이 단정으로 읽히는지는 사람이 읽어 판단해야 한다. 이 확인으로 01-03 금지 사항 ②(법적 성격 단정 금지, UAT Test 8 issue)도 다시 해소한다"
  - test: "01-09 판단 등급 금지 사항 1개(G-01-2의 네 곳 밖을 고치지 않음, task 커밋에 진행 기록·begin-phase 줄을 섞거나 그 줄을 지우거나 숨기지 않음)를 본문 「금지 사항」 표의 검증자 판정과 근거로 읽는다"
    expected: "검증자 판정(지켜짐)에 동의한다. 동의하지 않으면 gap으로 되돌린다"
    why_human: "unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없고 interactive 모드에서는 사람이 항목마다 해소한다 (ADR-550 D4)"
  - test: "01-10 판단 등급 금지 사항 2개(열 이름·열 정의·BASE-03·Phase 1 성공 기준 3·다른 행을 바꾸지 않음, 새 문장이 Meta나 다른 받는 곳을 수탁자·제3자 제공으로 단정하지 않음)를 본문 「금지 사항」 표의 검증자 판정과 근거로 읽는다"
    expected: "검증자 판정(지켜짐)에 동의한다. 동의하지 않으면 gap으로 되돌린다"
    why_human: "unverified-prohibition — human review recommended. 판단 등급 금지 사항의 검증자 판정은 권위가 없고 interactive 모드에서는 사람이 항목마다 해소한다 (ADR-550 D4)"
---

# Phase 1: 기준표와 방침 정비 (Ground Truth & Policy Reset) 검증 보고서

**Phase Goal:** 운영자와 이후 모든 단계가 같은 기준(이름 표·URL 대장·데이터 목록·결정 목록)을 쓰고, `CLAUDE.md`가 이번 마일스톤의 방침을 설명해 다음 작업 세션이 결정을 되돌리지 않는다
**Verified:** 2026-11-15T19:00:46Z
**Status:** human_needed
**Re-verification:** 예. 이전 보고서(2026-11-15T15:31:18Z, `human_needed`, 48/49)에는 gaps가 없어서, 첫 검증 방식으로 must-have 60개를 모두 새로 확인했습니다. 그 뒤 UAT에서 gap 두 개(G-01-2, G-01-8)가 나왔고, gap closure 계획 01-09·01-10이 그것을 닫았습니다.

## 결론 요약

- ROADMAP 성공 기준 5개와 계획 truth 55개, 모두 60개가 저장소 파일에서 성립합니다.
- UAT gap 두 개는 디스크에서 닫혔습니다.
  - **G-01-2:** ROADMAP External Gates 표의 가비아 행이 1차(→ Phase 5)와 2차 DKIM(→ Phase 10)으로 나뉘었습니다. Phase 5·Phase 10 External gates와 STATE Blockers도 같은 내용으로 바뀌었고, 절차서 작업 6과 일치합니다.
  - **G-01-8:** 데이터 목록 머리에 「수탁자」 열 분류의 출처 한 줄이 생겼고, Meta (Facebook SDK) 행의 수탁자 칸에 Phase 7 미정 단서가 붙었습니다.
- 계획 열 개의 `<automated>` 검사 125개를 저장소 루트에서 다시 돌렸습니다. 119개가 exit 0, 6개가 exit 1입니다. 실패 6개는 모두 이름 붙은 커밋이 일부러 대체했거나 바꾼 결과입니다. 나머지 부분만 따로 돌리면 통과합니다 (아래 Behavioral Spot-Checks).
- 차단 사항(blocker)은 없습니다.
- 상태가 `passed`가 아닌 이유는 사람 확인 항목 9건 때문입니다: 계획의 `<human-check>` 6건, VALIDATION Manual-Only 1건, 새 판단 등급 금지 사항 3개를 묶은 2건. 이 가운데 네 건(1·3·4·5번)은 2026-11-15 UAT에서 이미 pass로 기록돼 있어 빠르게 확인할 수 있습니다.

## Goal Achievement

### Observable Truths (ROADMAP 성공 기준)

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| SC1 | 운영자는 이름 표 하나에서 한글·영문 서비스명(러닝펜슬 / RunningPencil), 사업자등록증 그대로의 상호, 영문 법인명을 확인한다. 사용자가 아직 주지 않은 값은 빈칸이고, 추측해서 채운 값은 없다 | ✓ VERIFIED | `NAMES.md` 11~14행에 한글 서비스명 러닝펜슬, 영문 서비스명 RunningPencil, 운영사 슬림펌킨, 도메인이 있습니다. 16~22행의 사업자 값 일곱 칸(상호·대표자·사업자등록번호·주소·영문 법인명·스토어 개발자 이름·전화번호)은 모두 `(빈칸)`입니다. 01-01 verify 18개 가운데 17개가 통과하고, 실패 1개는 범위 가드입니다 (아래 참고) |
| SC2 | 운영자는 URL 대장 하나에서 모든 공개 URL(홈, 기존 3개, `/support/`, 위치약관, `/en/` 5개)을 apex·https·끝 슬래시 형식으로 보고, URL마다 등록할 콘솔 필드를 확인한다 | ✓ VERIFIED | `URLS.md`의 서로 다른 주소는 12개입니다: KO 6개(`/`, `/privacy-policy/`, `/terms/`, `/data-deletion/`, `/support/`, `/location-terms/`), EN 5개, v2 예약 `/en/location-terms/` 1개. 모두 `https://runningpencil.com/…/` 꼴입니다. 콘솔 필드 범주가 맞는지는 사람이 확인합니다 (Human 1) |
| SC3 | 운영자는 데이터 목록에서 개인정보 항목마다 출처·목적·저장 위치(리전)·수탁자·국외 이전·보유 기간·삭제 방식을 앱 저장소의 파일 근거와 함께 확인하고, 확인하지 못한 칸은 「미확인」으로 표시돼 있다 | ✓ VERIFIED | 01-03·01-05·01-08·01-10의 구조·근거 경로 검사가 통과합니다. 「미확인」은 45곳에 있습니다. 「CLI 미확인」은 3곳 남았는데, 모두 설명 문장이고 표의 칸은 아닙니다 (01-08이 칸을 채움). 01-10 뒤 「수탁자」 열의 값을 모두 세었습니다: 본표 32행 가운데 Google (Firebase·GCP)만 적은 행 25개, Google (Firebase·GCP)에 SMTP 발송 서비스 단서가 붙은 구간 F 행 1개, 네이버클라우드 2행, 로그인 제공자 API 요청 행 1개는 「해당 없음」, 기기 안 2행은 「없음」, Meta 1행(Phase 7 미정 단서 있음)입니다. 새 머리 줄이 적은 내용(Google·네이버클라우드는 수탁자, 로그인 제공자는 아님)과 표가 같고, ROADMAP Phase 7 성공 기준 2의 문구와도 같습니다 |
| SC4 | 운영자는 결정 목록(U2·U3·U5~U9·U11~U13)과 사용자가 할 외부 작업 목록(가비아 DNS 레코드 표, 메일 수신 시험 절차, 사업자 값, 앱 화면 캡처)을 받아, 항목마다 어느 단계를 막는지 안다 | ✓ VERIFIED | 결정 목록 「한눈에 보기」 12행을 01-09 뒤의 14행 External Gates 표와 한 줄씩 대조했고, 어긋난 행은 없습니다 (P1은 표에 행이 없다는 사실과 근거 D-08이 문서에 적혀 있음). 절차서 작업 0~12도 표와 대조했습니다: 작업 2 = 1차 행 = Phase 5, 작업 6 = 2차 행 = Phase 10, 작업 4 = 이메일 게이트, 작업 9 = U11 = Phase 5·8·9, 작업 10 = Phase 4. 어긋난 곳은 없습니다. G-01-2로 생겼던 불일치는 ROADMAP 세 곳과 STATE 한 곳에서 모두 사라졌습니다. 저장소 전체에서 DKIM을 찾아 남은 곳(`STATE.md:99` 결정 기록, `PROJECT.md:104`, 연구 문서)을 확인했는데, DKIM을 Phase 5 완료 조건으로 적은 문장은 없습니다 |
| SC5 | `CLAUDE.md`가 지원 이메일 공개, 사업자 정보 표시, 영문명 RunningPencil, 한국어+영어, Jekyll 빌드 전환, 포인트·굿즈·코스북 제거를 현재 방침으로 설명하고, 옛 규칙 문장이 남아 있지 않다 | ✓ VERIFIED | 두 `CLAUDE.md`의 방침 구간은 3512자로 같고, `TESTING.md` 점검 목록 9의 비교 명령이 같다고 판정합니다. `^| `로 시작하는 표 줄은 8개입니다(머리 + 일곱 행. 구분 줄 `|---|`는 이 패턴에 걸리지 않음). 옛 규칙 꼴(「연락처 미표시」, 「RunningPencil 쓰지 않음」, 「ko 전용」 등)은 다섯 방침 파일에서 0줄입니다. 생성기로 다시 만든 사본은 저장소 파일과 `cmp`로 같습니다 (01-01 verify 7, 01-06 verify 9·16, 01-07 verify 10이 통과). 두 `CLAUDE.md`에는 DKIM 문장이 없어서 01-09가 고칠 곳도 없었습니다 |

### Plan must_haves (계획별)

| Plan | Truths | Status | Evidence |
|------|--------|--------|----------|
| 01-01 | 6 | ✓ 6/6 VERIFIED | 이름 표·URL 대장 내용은 SC1·SC2와 같습니다. verify 18개 가운데 17개가 exit 0입니다. verify 8은 범위 가드라 실패합니다(아래 참고). truth 6(재생성 뒤에도 방침 구간이 남고 두 사본이 같음)은 재생성 `cmp`와 구간 비교로 성립합니다 |
| 01-02 | 5 | ✓ 5/5 VERIFIED | verify 11/11 exit 0. `USER-TASKS.md`는 기준 커밋 `251ed7b` 이후 바뀌지 않았습니다 (01-09 verify 6) |
| 01-03 | 6 | ✓ 6/6 VERIFIED | verify 15개 가운데 14개가 exit 0입니다. verify 10은 「`CLI 미확인` 5줄 이상」 조건 때문에 실패합니다. 01-08이 그 칸을 dev CLI 값으로 채워 대체됐습니다. 같은 명령의 항목 검사 부분만 돌리면 `miss=[]`입니다 |
| 01-04 | 6 | ✓ 6/6 VERIFIED | verify 11/11 exit 0. `DECISIONS.md`도 `251ed7b` 이후 바뀌지 않았습니다 |
| 01-05 | 5 | ✓ 5/5 VERIFIED | verify 13개 가운데 12개가 exit 0입니다. verify 9는 01-03 verify 10과 같은 이유(「CLI 미확인」 8개 이상)로 대체됐습니다. 구조 부분은 `rows=12 bad=`이고, 「USER-TASKS」 참조와 「미확인」 12개 이상(45개) 조건도 통과합니다 |
| 01-06 | 5 | ✓ 5/5 VERIFIED | verify 18개 가운데 16개가 exit 0입니다. verify 5·10은 범위 가드라 실패합니다(아래 참고). 라이브 사이트 부분과 CONVENTIONS 목록 7줄 부분(`lines=7 bad=`)은 따로 돌리면 통과합니다 |
| 01-07 | 7 | ✓ 7/7 VERIFIED | verify 18개 가운데 17개가 exit 0입니다. verify 4는 External Gates 표 행 수 13을 요구하는데, 01-09(`0232a75`)가 가비아 행을 나눠 14가 됐습니다. 01-09 계획과 SUMMARY가 이 대체를 미리 적었습니다. 13을 14로 바꿔 돌리면 나머지 조건(U12 행 없음, 「이미 결정된 항목」에 U12, 가비아 행에 「2차 방문」)이 모두 통과합니다 (exit 0). truth 1(Phase 5가 1차·2차 방문을 말함)과 truth 3(STATE Blockers가 1차·2차 방문을 적음)은 01-09 뒤에도 글자 그대로 성립합니다. truth 4의 「What This Is는 바뀌지 않음」은 리뷰 수정 `fd6504f`(IN-03)가 앱 설명 한 줄을 의도적으로 고쳐서 글자 그대로는 맞지 않습니다. 01-07 verify 10은 지금도 exit 0입니다. 이 검사는 `(01-07)` 커밋의 PROJECT.md 변경만 재서, 모든 hunk가 Key Decisions 구간 안에 있고 추가·삭제가 4줄 이하인지 확인합니다. 또 재생성 결과가 `.claude/CLAUDE.md`와 같은지(`cmp`)도 봅니다. 01-07이 지킬 범위는 지켜졌으므로 VERIFIED로 둡니다. 이 truth를 「01-07이 바꾸지 않았다」로 좁혀 읽은 것은 검증자 판단입니다 |
| 01-08 | 4 | ✓ 4/4 VERIFIED (truth 3은 사람이 해소) | verify 7/7 exit 0. 「CLI 조회 기록」 8행이 모두 「조회함」입니다. truth 3(읽기 전용 명령만 썼고 dev 설정·데이터가 바뀌지 않음)은 저장소 코드로는 증명할 수 없습니다. 2026-11-15 UAT Test 4가 사람 확인으로 해소했고 그 기록이 `01-UAT.md:32`에 있습니다: 01-08 시간대 Admin Activity 감사 로그 0건, Firestore 문서 읽기·쓰기·삭제와 Storage 요청 0건, 확장 API는 01-08 이전부터 켜져 있음. 이전 보고서의 UNCERTAIN은 이 기록으로 VERIFIED가 됐습니다. 근거는 코드가 아니라 사람의 해소입니다 |
| 01-09 | 7 | ✓ 7/7 VERIFIED | verify 9/9 exit 0. 직접 확인한 것: `git diff 251ed7b..HEAD`에서 ROADMAP의 바뀐 줄은 가비아 표 행 2개, Phase 5 가비아 항목, Phase 10 External gates 줄, 그리고 진행 기록(Plans 수, Plans 목록, Progress 표)뿐입니다. task 커밋 `0232a75`는 ROADMAP.md만 담았고 +4/-3, `31f3b52`는 STATE.md만 담았고 +2/-1(Blockers 줄뿐)입니다. STATE의 front matter·Current Position·Performance·Decisions 변경은 추적 커밋에서 왔습니다. `USER-TASKS.md`, `DECISIONS.md`, `REQUIREMENTS.md`, 라이브 사이트 파일은 `251ed7b`와 같습니다 |
| 01-10 | 4 | ✓ 4/4 VERIFIED | verify 5/5 exit 0. task 커밋 `24ba63b`는 `DATA-INVENTORY.md`만 담았고 +3/-1이며, 지운 줄은 Meta 행 하나입니다. 본표 머리 줄 다섯 개, 「읽는 법」의 수탁자·국외 이전 정의, 표 행 수, REQUIREMENTS, ROADMAP Phase 1 성공 기준 3이 기준 커밋과 같습니다 |

**Score:** 60/60 truths verified (SC 5 + 계획 truth 55. PRESENT_BEHAVIOR_UNVERIFIED 0. 01-08 truth 3은 UAT Test 4의 사람 해소를 근거로 셈)

이 단계의 산출물은 문서뿐입니다. 상태 전이나 취소·정리 불변식 같은 behavior-dependent truth가 없어서 `behavior_unverified: 0`입니다.

### 금지 사항 (judgment-tier)

27개 모두 `verification: judgment`입니다. 이전 24개는 2026-11-15 UAT에서 사람이 항목마다 해소했습니다 (Test 4, 6~13). 01-03 ②만 issue였고, 01-10 뒤의 재확인은 Human 7에 넣었습니다. 새 3개(01-09 1개, 01-10 2개)는 검증자 판정이 권위가 없으므로 Human 8·9로 넘깁니다.

| Plan | 금지 사항 (요지) | 판정 | 근거 |
|------|------------------|------|------|
| 01-01 | 사업자 값 추측 금지 · 공개 전 사업자 값 커밋 금지 · 콘솔 필드를 확정된 필드명처럼 적지 않음 | 지켜짐 (사람 해소: UAT Test 6 pass) | 일곱 칸이 `(빈칸)`입니다. 이번 검증에서도 바뀐 것이 없습니다 |
| 01-02 | 발급 값 추정 기재 금지 · 기존 DNS 레코드 삭제·수정 안내 금지 | 지켜짐 (사람 해소: UAT Test 7 pass) | `USER-TASKS.md`는 `251ed7b` 이후 바뀌지 않았습니다 |
| 01-03 | ① 미확인 값을 확인된 것처럼 적지 않음 · ③ 실제 사용자 데이터 값을 옮기지 않음 | 지켜짐 (사람 해소: UAT Test 8 ①·③) | 01-10은 단서만 더했고 값은 바꾸지 않았습니다 (+3/-1) |
| 01-03 | ② 수탁·제3자 제공·국외 이전의 법적 성격을 단정하지 않음 | 지켜짐 (검증자 판정, 사람 재확인 필요 → Human 7) | UAT Test 8 issue(G-01-8) 뒤 01-10이 머리에 분류 출처 줄을, Meta 행에 「수탁·제3자 제공 구분은 Phase 7에서 정함」을 넣었습니다. 남은 단서 없는 비 PRIV-03 받는 곳은 구간 F의 SMTP 발송 서비스 하나이고, 사용자가 「Meta 행만 고침」을 골랐으며 머리 줄의 「그 밖의 받는 곳 … Phase 7에서 정합니다」가 여기에도 걸립니다 (Info) |
| 01-04 | 법률 항목 기본 동작을 결론처럼 적지 않음 · U12 말고 「결정됨」 금지 · U11 기본값 금지 | 지켜짐 (사람 해소: UAT Test 9 pass) | `DECISIONS.md`는 바뀌지 않았습니다 |
| 01-05 | 비공개 코스 삭제·공개 코스만 남음으로 적지 않음 · 즉시 전부 삭제로 읽히게 적지 않음 · 선택지만 있는 값 추측 금지 | 지켜짐 (사람 해소: UAT Test 10 pass) | 01-10은 구간 G·H를 건드리지 않았습니다 (지운 줄은 Meta 행 하나) |
| 01-06 | 옛 규칙 문장 인용 금지 · 코드 설명을 미래 상태로 고쳐 쓰지 않음 · 방침을 지금 코드에 반영해도 된다고 읽히지 않음, 지원 주소 문자열 금지 | 지켜짐 (사람 해소: UAT Test 11 pass) | 두 `CLAUDE.md`는 이전 검증 뒤 바뀌지 않았습니다 |
| 01-07 | D-21 밖 ROADMAP 내용 변경 금지 · 연구 본문 수정·삭제 금지 · 연구 캐시 커밋 금지 | 지켜짐 (사람 해소: UAT Test 12 pass) | 01-07 범위의 판정입니다. 이후 ROADMAP 변경은 01-09가 G-01-2 범위에서 했습니다 |
| 01-08 | dev 설정·데이터 변경 금지 · 다른 자격 증명 사용 금지 · 문서·객체 내용 조회 금지 | 지켜짐 (사람 해소: UAT Test 4 pass) | 이전 보고서의 「판정 불가」를 사람이 해소했습니다. 「다른 자격 증명」만 직접 증거가 없고 정황(로그인 계정 1개)뿐이라는 점을 사용자가 알고 pass로 정했습니다 (`01-UAT.md:32`) |
| 01-08 | 조회하지 못한 칸을 추정값으로 채우지 않음 | 지켜짐 (사람 해소: UAT Test 13 pass) | 8건 모두 「조회함」입니다 |
| 01-09 | G-01-2의 네 곳 밖을 고치지 않음, task 커밋에 진행 기록·begin-phase 줄을 섞지 않고 그 줄을 지우거나 stash하지 않음 | 지켜짐 (검증자 판정 → Human 8) | `251ed7b..HEAD`의 ROADMAP·STATE 바뀐 줄을 모두 읽었습니다. task 커밋 두 개는 대상 줄만 담았습니다 (위 01-09 행). `USER-TASKS.md`·`DECISIONS.md`·`REQUIREMENTS.md`와 단계 목표·성공 기준·다른 게이트 행은 그대로입니다 (01-09 verify 1·5·6). 지금 작업 트리의 STATE.md는 깨끗합니다. 단계 시작 처리가 남긴 줄(front matter의 status·last_updated·state_head·total_plans, Current Position의 Plan·Status·Last activity)은 추적 커밋 `8f02671`(「계획 09 완료 상태 반영」, STATE.md +14/-12)에 들어 있습니다. `git stash list`는 비어 있습니다 |
| 01-10 | 열 이름·「읽는 법」 열 정의·BASE-03·Phase 1 성공 기준 3·다른 행(SMTP 문장 포함)을 바꾸지 않음 | 지켜짐 (검증자 판정 → Human 9) | 01-10 verify 3·4: 열 이름 줄 5개, 열 정의 2줄, 표 행 수, REQUIREMENTS, Phase 1 성공 기준 3이 같고, 지운 줄은 Meta 행 하나입니다 |
| 01-10 | 새 문장이 Meta나 다른 받는 곳을 수탁자·제3자 제공으로 단정하지 않음 | 지켜짐 (검증자 판정 → Human 9) | 새 머리 줄은 「수탁인지 제3자 제공인지는 정하지 않았고 Phase 7에서 정합니다」라고 적고, Google·네이버클라우드 분류는 PRIV-03·Phase 7 성공 기준 2에서 옮겼다고 출처를 댑니다. PRIV-03의 원문(「Google Firebase·GCP, 네이버클라우드 등」, 로그인 제공자는 수탁자로 적지 않음)과 같습니다 |

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `.planning/baseline/NAMES.md` | 이름 표 (BASE-01) | ✓ VERIFIED | `verify.artifacts` 01-01 2/2 |
| `.planning/baseline/URLS.md` | URL 대장 (BASE-02) | ✓ VERIFIED | 위와 같음. 주소 12개 |
| `.planning/baseline/DATA-INVENTORY.md` | 데이터 목록 (BASE-03) | ✓ VERIFIED | 01-03·05·08·10 모두 1/1. 01-10이 넣은 `PRIV-03` 문자열이 있음 |
| `.planning/baseline/DECISIONS.md` | 결정 목록 (BASE-04) | ✓ VERIFIED | 01-04 1/1 |
| `.planning/baseline/USER-TASKS.md` | 사용자 작업 절차서 (BASE-04) | ✓ VERIFIED | 01-02 1/1 |
| `CLAUDE.md`, `.claude/CLAUDE.md`, `.planning/codebase/CONVENTIONS.md` | 방침 표, 작업 규칙, 상태 문장 (BASE-05) | ✓ VERIFIED | 01-06 3/3 |
| `.planning/ROADMAP.md`, `STATE.md`, `PROJECT.md`, `research/STACK.md`, `research/SUMMARY.md` | U12·DNS·위치약관 정합 | ✓ VERIFIED | 01-07 5/5 |
| `.planning/ROADMAP.md`, `.planning/STATE.md` | 가비아 1차·2차 분리 (G-01-2) | ✓ VERIFIED | 01-09 2/2. 각각 「Phase 5 완료를 막지 않습니다」와 「가비아 DNS 2차 방문」 문자열이 있음 |

### Key Link Verification

`verify.key-links`의 계획별 결과는 01-01 3/3, 01-02 1/1, 01-03 1/1, 01-04 2/2, 01-05 2/2, 01-06 3/3, 01-07 4/4, 01-08 1/1, 01-09 3/3, 01-10 2/2입니다. 모두 WIRED입니다.

| From | To | Via | Status |
|------|----|-----|--------|
| `ROADMAP.md` Phase 10 External gates | `USER-TASKS.md` 작업 6 | DKIM 문장이 절차서 작업 6을 가리킴 (01-09) | ✓ WIRED |
| `ROADMAP.md` External Gates 2차 행 | `USER-TASKS.md` 「한눈에 보기」 작업 6 | 둘 다 Phase 10 (01-09 verify 4로 칸 값을 직접 비교) | ✓ WIRED |
| `STATE.md` Blockers 2차 줄 | `USER-TASKS.md` 작업 6 | 「작업 6」 참조 (01-09) | ✓ WIRED |
| `DATA-INVENTORY.md` 머리 | `REQUIREMENTS.md` PRIV-03, `ROADMAP.md` Phase 7 성공 기준 2 | 분류 출처 (01-10). 가리킨 문구가 실제로 그 내용을 말하는지도 확인함 | ✓ WIRED |
| `DECISIONS.md` | `ROADMAP.md` External Gates | 막는 단계가 같음 (14행 표와 직접 대조) | ✓ WIRED |
| `CLAUDE.md` | `.claude/CLAUDE.md` | 방침 구간이 같음 | ✓ WIRED |
| `CONVENTIONS.md` | `NAMES.md` / `.claude/CLAUDE.md` | 이름 표 경로, 생성기 옮김 | ✓ WIRED |

### Data-Flow Trace (Level 4)

해당 없음. 산출물이 문서뿐이고 동적 데이터를 그리는 코드가 없습니다.

### Behavioral Spot-Checks

| Behavior | Command | Result | Status |
|----------|---------|--------|--------|
| 계획 열 개의 `<automated>` 검사 전체 | 125개 명령을 저장소 루트에서 `bash`로 하나씩 실행 (TMPDIR은 scratchpad) | 119개 exit 0, 6개 exit 1 | ✓ PASS (6개는 아래 설명) |
| 대체(superseded) 2건: 01-03 verify 10, 01-05 verify 9 | 「CLI 미확인」 개수 조건 | 01-08이 칸을 채워 실패합니다. 나머지 부분만 돌리면 통과합니다 (`miss=[]`, `rows=12 bad=`, 미확인 45) | ℹ️ 의도된 대체 |
| 대체 1건: 01-07 verify 4 | External Gates 표 행 수 13 | `rows=14`로 실패합니다. 01-09(`0232a75`)가 행을 나눈 결과이고, 01-09 계획과 SUMMARY에 미리 적혀 있습니다. 13을 14로 바꾸면 exit 0입니다 | ℹ️ 의도된 대체 (G-01-2) |
| 범위 가드 3건: 01-01 verify 8, 01-06 verify 5·10 | 「`.claude/CLAUDE.md`의 conventions 밖 블록과 codebase 문서 세 개가 `dcc2002`와 같음」 | 리뷰 수정 커밋 `24e31f2`·`fd6504f`·`270dcb6`·`1dc2f1a` 등이 일부러 고쳐서 실패합니다. 이번 gap closure 커밋은 이 파일들을 건드리지 않았습니다. 라이브 사이트 + INTEGRATIONS 부분은 rc=0이고, CONVENTIONS 목록 부분은 `lines=7 bad=`입니다 | ℹ️ 의도된 리뷰 수정 (must-have 아님, 이전 검증과 같음) |
| 방침 구간 일치 | `TESTING.md` 점검 목록 9의 비교 명령 | 같음 (3512자) | ✓ PASS |
| 커밋 존재 | `verify.commits` (SUMMARY 열 개에서 백틱으로 적은 해시 24개, 01-09·01-10 추적 커밋 포함) | 23개 valid. invalid 1개 `3afb2085`는 앱 저장소의 기준 커밋이고, `git -C ~/dv/woody/running_pencil cat-file -t`로 commit임을 확인했습니다 (앱 HEAD도 `3afb2085`). 01-06 SUMMARY의 `191c190`·`195c193`은 백틱이 없는 `diff` 줄 범위라 해시로 세지 않았습니다 | ✓ PASS |
| 검증 실행이 저장소를 바꾸지 않음 | 실행 전후 `git status --porcelain` 비교 | 같음 (`.planning/config.json` 수정, `.planning/state.json` 미추적은 검증 전부터 있던 상태) | ✓ PASS |

### Probe Execution

해당 없음. `scripts/` 디렉터리가 없고, 계획에 선언된 probe도 없습니다.

## Requirements Coverage

| Requirement | Source Plan | Description | Status | Evidence |
|-------------|-------------|-------------|--------|----------|
| BASE-01 | 01-01 | 이름 표 하나로 한글·영문 서비스명, 상호, 영문 법인명 확인 | ✓ SATISFIED | SC1 |
| BASE-02 | 01-01 | URL 대장 하나로 공개 URL과 콘솔 필드 확인 | ✓ SATISFIED | SC2 (필드 범주가 맞는지는 Human 1) |
| BASE-03 | 01-03, 01-05, 01-08, 01-10 | 앱 저장소 근거의 데이터 목록. 법적 문서가 이 목록에서 나옴 | ✓ SATISFIED | SC3. 「법적 문서가 이 목록에서 나온다」는 Phase 6~8에서 이루어지고, 지금은 `CLAUDE.md` 작업 규칙과 ROADMAP Phase 6·7 성공 기준이 강제합니다 |
| BASE-04 | 01-02, 01-04, 01-07, 01-09 | 사용자·법률 결정 목록과 막는 단계 | ✓ SATISFIED | SC4 (G-01-2 해소 뒤) |
| BASE-05 | 01-01, 01-06 | `CLAUDE.md`가 바뀐 방침을 설명 | ✓ SATISFIED | SC5 |

REQUIREMENTS.md 추적 표에서 Phase 1에 배정된 행은 157~161행의 BASE-01~05 다섯 개뿐이고, 다섯 개 모두 계획 frontmatter의 `requirements`에 있습니다. ORPHANED 요구사항은 없습니다.

## Decision Coverage

`check.decision-coverage-verify`(CONTEXT 경로 지정) 결과: 21/21 honored, not_honored 없음. 「All trackable CONTEXT.md decisions are honored by shipped artifacts.」

## Anti-Patterns Found

| File | Line | Pattern | Severity | Impact |
|------|------|---------|----------|--------|
| `.planning/ROADMAP.md` | 86, 101, 115, 130, 149, 165, 181, 196, 212, 260~268 | `TBD` (`**Plans**: TBD`, Progress 표 `0/TBD`) | ℹ️ Info | 이 단계(`dcc2002..HEAD`)가 더한 TBD 줄은 0줄입니다. 로드맵 작성 커밋 `ee6acbc`부터 있던 아직 계획하지 않은 Phase 2~10의 계획 수 자리이고, 각 단계의 plan-phase가 채웁니다 (Phase 1의 두 자리는 이미 채워짐). 미완성 작업을 뜻하는 debt marker가 아니어서 blocker로 보지 않았습니다. 글자 그대로 debt marker로 읽더라도 각 TBD는 뒤 단계(Phase 2~10)의 계획 자리라 Step 9b에 따라 그 단계로 넘어가므로 상태는 같습니다. 단계 디렉터리 밖의 covered 파일 20개 전체를 `TBD|FIXME|XXX`로 찾았을 때 ROADMAP 말고는 걸린 곳이 없습니다. 이 단계가 더한 줄을 TODO·placeholder 꼴까지 넓혀 찾았을 때 걸린 줄은 「「추후 기재」 같은 자리표시 값을 쓰지 않습니다」라는 규칙 문장(두 `CLAUDE.md`) 두 줄뿐입니다 |
| `.planning/ROADMAP.md` | 54~55 | Phase 1 Plans 목록에서 `01-09`·`01-10` 줄이 Wave 1 위에 설명 없이 들어감 | ℹ️ Info | 진행 기록 도구가 쓴 줄입니다. 내용이 틀린 것은 아니고, `roadmap validate` 경고는 없습니다 (01-09 verify 5) |
| `.planning/baseline/DATA-INVENTORY.md` | 구간 F `mail/{id}` 행 | PRIV-03에 없는 받는 곳(SMTP 발송 서비스)인데 행 단위 Phase 7 단서가 없음 | ℹ️ Info | 사용자가 「Meta 행만 고침」을 골랐고 (01-10 계획의 가정), 머리의 새 줄이 「그 밖의 받는 곳」 전체를 Phase 7로 넘기므로 단정으로 읽히지 않습니다 |

### Advisory (New Scope, Unevidenced)

없음. 결정적 증거 없이 남은 새 범위 발견은 없습니다. 위 Info 세 건은 관찰만 적은 것이고 차단 사항이 아닙니다.

### Test Quality Audit

해당 없음. 이 단계에는 테스트 파일이 없습니다. 검사는 계획의 `<automated>` 셸 명령이고, 위 Behavioral Spot-Checks에 결과를 적었습니다.

## Human Verification Required

9건입니다. 출처는 계획의 `<human-check>` 6건(01-01·01-02·01-04·01-08·01-09·01-10), VALIDATION Manual-Only 1건, 새 판단 등급 금지 사항 3개를 묶은 2건입니다. 1·3·4·5번은 2026-11-15 UAT에서 pass로 기록돼 있고 그 뒤 해당 문서는 바뀌지 않았습니다. 그래도 계획이 넘긴 확인이라 목록에 그대로 둡니다 (기록된 판정을 이유로 빼지 않는 규칙). 2번과 6번은 같은 확인입니다 (01-09가 01-02의 확인을 다시 한 것).

### 1. URL 대장 콘솔 필드 범주 (01-01) — UAT Test 1 pass 기록됨
**Test:** URL 대장의 「등록할 콘솔 필드(범주)」 열을 제공자·스토어별로 훑어봅니다.
**Expected:** URL마다 등록할 곳이 범주 수준으로 적혀 있고, 확인되지 않은 필드명을 확정된 것처럼 적은 칸이 없다
**Why human:** 콘솔 필드 범주가 맞는지는 사람의 판단이 필요합니다.

### 2. 절차서의 막는 단계 대조 (01-02) — UAT Test 2 issue, 01-09로 고침
**Test:** 절차서의 작업마다 「막는 단계」를 ROADMAP External Gates 표와 대조합니다.
**Expected:** 작업 0~12의 막는 단계가 ROADMAP의 게이트와 어긋나지 않는다 (DNS·메일은 Phase 5, 화면 캡처는 Phase 4, DKIM은 Phase 10의 릴레이 답장 전제)
**Why human:** 단계 의존 관계는 ROADMAP 해석이 필요합니다. 검증자 대조 결과는 어긋남 없음입니다 (SC4).

### 3. 결정 목록의 막는 단계와 법률 항목 문구 (01-04) — UAT Test 3 pass 기록됨
**Test:** 「한눈에 보기」의 막는 단계를 External Gates 표와 대조하고, U2·U3·U7의 「기본 동작」을 읽습니다.
**Expected:** 항목마다 막는 단계가 ROADMAP의 게이트와 어긋나지 않는다. 법률 판단 항목의 기본 동작이 결론이 아니라 임시 방침으로 읽히고 사용자가 받아들일 수 있는 문구다
**Why human:** 법률 판단 항목에서 무엇이 보수적인 쪽인지는 사용자가 확인해야 합니다.

### 4. dev CLI 값 (01-08) — UAT Test 4 pass 기록됨
**Test:** 「CLI 조회 기록」과 리전·TTL·백업·버킷 칸을 Firebase·GCP 콘솔에서 아는 값과 견주어 봅니다.
**Expected:** 조회한 값이 dev 프로젝트의 실제 설정과 같고, 건너뛰거나 실패한 조회의 칸은 「CLI 미확인」으로 남아 있다. 문서에 버킷 이름이나 계정 정보가 없다
**Why human:** dev 프로젝트의 실제 설정은 사용자의 자격 증명으로만 볼 수 있습니다.

### 5. 이름 표 사업자 값 칸 (VALIDATION Manual-Only, BASE-01) — UAT Test 5 pass 기록됨
**Test:** 사업자 값 칸마다 출처(사용자 제공/빈칸)를 눈으로 확인합니다.
**Expected:** 칸이 비어 있거나 사용자가 준 값뿐입니다 (검증 시점: 일곱 칸 모두 `(빈칸)`).
**Why human:** 「추측하지 않음」은 패턴으로 다 잡을 수 없습니다.

### 6. 막는 단계 세 문서 대조 (01-09, UAT Test 2 재확인)
**Test:** 절차서 「한눈에 보기」의 작업 0~12를 ROADMAP External Gates 표, Phase 5·Phase 10 External gates, STATE Blockers와 견줍니다. 특히 작업 6(DKIM)이 세 문서 모두에서 Phase 10만 막고, 2차 방문의 작업 시점은 Phase 5 무렵으로 남았는지 봅니다.
**Expected:** 어긋나는 곳이 없습니다.
**Why human:** 세 문서의 문장 뜻이 같은지는 사람이 읽고 판단해야 합니다. 검증자 대조 결과는 어긋남 없음입니다.

### 7. Meta 행과 머리 줄 읽기 (01-10, UAT Test 8 재확인, VALIDATION Manual-Only 5행)
**Test:** 데이터 목록 머리의 새 줄과 구간 E의 Meta (Facebook SDK) 행을 읽습니다.
**Expected:** Meta가 수탁자로 정해진 것처럼 읽히지 않고, 머리의 새 줄이 「읽는 법」의 수탁자 정의(법적 성격은 여기서 정하지 않음)와 함께 읽어도 어긋나지 않습니다.
**Why human:** 단정으로 읽히는지는 사람이 판단합니다. 이 확인이 01-03 금지 사항 ②(UAT Test 8 issue)의 재해소를 겸합니다.

### 8. 01-09 판단 등급 금지 사항 (1개)
**Test:** 「금지 사항」 표의 01-09 행(G-01-2의 네 곳 밖을 고치지 않음, task 커밋에 진행 기록·begin-phase 줄을 섞지 않음)을 검증자 판정, 근거와 함께 읽습니다.
**Expected:** 검증자 판정(지켜짐)에 동의합니다. 동의하지 않으면 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended (ADR-550 D4).

### 9. 01-10 판단 등급 금지 사항 (2개)
**Test:** 「금지 사항」 표의 01-10 두 행(열 이름·정의·다른 행 불변, 새 문장이 수탁·제3자 제공을 단정하지 않음)을 검증자 판정, 근거와 함께 읽습니다.
**Expected:** 검증자 판정(지켜짐)에 동의합니다. 동의하지 않으면 gap으로 되돌립니다.
**Why human:** unverified-prohibition — human review recommended (ADR-550 D4).

## Gaps Summary

목표를 막는 gap은 없습니다.

- 기준 문서 다섯 개가 있고, 내용이 구체적이며, 서로와 `CLAUDE.md`·ROADMAP을 경로로 가리킵니다.
- UAT가 찾은 두 어긋남은 모두 닫혔습니다:
  - G-01-2: 막는 단계의 정본인 ROADMAP 표가 이제 절차서와 같은 말을 합니다.
  - G-01-8: 데이터 목록이 Meta의 분류를 Phase 7로 넘깁니다.
- 「다음 세션이 결정을 되돌리지 않는다」를 받치는 네 가지는 그대로 성립합니다:
  - 두 `CLAUDE.md`의 방침 구간이 같은 글자입니다.
  - 그 일치를 확인하는 명령이 `TESTING.md`에 있습니다.
  - 생성 원본에서 다시 만들어도 파일이 바뀌지 않습니다.
  - 옛 규칙 문장은 0줄입니다.

자동 검사 실패 6개는 모두 이름 붙은 커밋이 의도적으로 대체하거나 바꾼 결과이고, 나머지 부분은 통과합니다. 남은 것은 사람 확인 9건입니다.

---

_Verified: 2026-11-15T19:00:46Z_
_Verifier: Claude (gsd-verifier)_
