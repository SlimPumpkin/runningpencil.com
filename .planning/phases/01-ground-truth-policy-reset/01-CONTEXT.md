# Phase 1: 기준표와 방침 정비 (Ground Truth & Policy Reset) - Context

**Gathered:** 2026-11-14
**Status:** Ready for planning

<domain>
## Phase Boundary

이번 마일스톤의 나머지 단계가 모두 입력으로 쓰는 기준 문서 4종과 사용자 작업 목록을 `.planning/` 아래에 만들고, `CLAUDE.md`가 이번 마일스톤 방침을 설명하도록 고친다.

- 산출물
  1. 이름 표 (BASE-01)
  2. URL 대장 (BASE-02)
  3. 데이터 목록 (BASE-03)
  4. 결정 목록 + 사용자 작업 목록 (BASE-04)
  5. `CLAUDE.md` 방침 갱신 (BASE-05)
- 라이브 사이트(HTML·`_config.yml`·`favicon/`)는 바꾸지 않는다. 산출물은 모두 배포 제외 대상이다.
- 앱 저장소 `~/dv/woody/running_pencil`은 읽기만 한다. 파일 수정, 커밋, 배포는 하지 않는다.
- 사업자 값 기입, DNS 변경, 사이트 문구 수정은 이 단계 범위가 아니다. 이 단계는 그 작업들의 기준과 절차만 넘긴다.

</domain>

<decisions>
## Implementation Decisions

### CLAUDE.md 서술 방식 (BASE-05)
- **D-01:** 코드 설명 구간은 지금 코드의 실제 모습을 그대로 둔다(Tailwind CDN, `python3 -m http.server`, 복사된 공통 블록 등). 대신 문서 맨 앞에 「이번 마일스톤 방침」 구간을 새로 둔다.
  - 방침마다 적용 단계와 현재 상태를 표로 적는다. 예: 「Jekyll 빌드 — Phase 2에서 적용, 그전까지는 `http.server`」, 「지원 이메일 공개 — 이메일 게이트(Phase 5) 뒤, 그전에는 주소를 사이트에 넣지 않음」.
  - 로컬 미리보기 안내 같은 현재 상태 설명에는 언제까지 유효한지 표시한다.
- **D-02:** 방침마다 한 줄 이유와 출처 경로(예: `.planning/PROJECT.md` Key Decisions)를 단다.
  - 옛 규칙 문장은 인용하지 않는다. 「이전 방침을 뒤집음」이라고만 적는다.
  - 이유: 성공 기준 5의 grep 검사(옛 문장이 남아 있지 않음)와 충돌하지 않게 하고, 다음 세션이 「연락처를 감추는 편이 안전해 보인다」며 되돌리지 못하게 막는다.
- **D-03:** 새 방침 6가지에 더해 ROADMAP Ground Rules의 작업 규칙도 줄여서 옮기고 원본 경로를 적는다.
  - 옮길 규칙: 사실값을 추측하지 않고 값이 없으면 항목을 숨김(render-if-present), 「추후 기재」 같은 자리표시 금지, 기존 3개 URL 경로 고정·리디렉션 금지, 리팩터·시각·내용 커밋 분리, 법적 본문은 데이터 목록 기준, JS 언어 자동 리디렉션·`robots.txt` 차단·`.nojekyll`·Jekyll i18n 플러그인 금지.
  - GSD 밖에서 열린 세션과 다른 도구도 이 규칙을 지키게 하려는 것이다.
- **D-04 (조사로 고정):** 이 단계에서 「`CLAUDE.md`를 고친다」는 아래 세 곳을 모두 뜻한다.
  - 저장소가 추적하는 두 파일: 루트 `CLAUDE.md`, `.claude/CLAUDE.md`
  - `.claude/CLAUDE.md`를 만드는 원본: `GSD:*-start source:` 표식이 가리키는 `.planning/PROJECT.md`와 `.planning/codebase/*.md`. `config.json`의 `claude_md_path`가 `./.claude/CLAUDE.md`이다.
  - 원본 맵에도 옛 규칙이 남아 있다. 예: `.planning/codebase/CONVENTIONS.md:143-146`의 「RunningPencil 쓰지 않음」「연락처 이메일을 넣지 않음」「noindex 유지」, `.planning/codebase/TESTING.md:65,121`의 RunningPencil·이메일 금지 검사.
  - 원본을 고치지 않고 생성 파일만 고치면 다음에 다시 생성할 때 옛 문장이 돌아온다. 원본을 먼저 고치고 다시 생성하는 구체적 방법은 계획자가 정한다.
- **D-05:** `CLAUDE.md:7`의 앱 설명 문장은 PROJECT.md의 설명으로 맞춘다. 포인트·굿즈·코스북은 빼고(U10), 출시 범위에 있는 기능(코스 완주 뱃지, 직접 그린 코스 공개 등)은 앱 근거를 확인한 뒤 남긴다.

### 데이터 목록 근거와 깊이 (BASE-03)
- **D-06:** 근거는 두 가지다.
  - 앱 저장소의 코드와 설정 파일
  - dev 프로젝트(`running-pencil-dev`)를 대상으로 한 읽기 전용 CLI 조회. 예: `gcloud firestore databases list/describe`, `gcloud storage buckets describe`, `gcloud compute instances list`, `firebase` CLI의 list·get 계열.
  - 설정을 바꾸거나 배포하거나 리소스를 만들고 지우는 명령은 쓰지 않는다.
  - 이 컴퓨터에는 gcloud·firebase CLI가 설치돼 있고 로그인돼 있다.
  - Analytics 보존 기간처럼 콘솔에만 있는 값은 「미확인」으로 두고 사용자 확인 항목으로 넘긴다.
- **D-07:** 행은 필드 단위로 쓴다. Firestore 필드, Storage 경로, SDK가 자동으로 모으는 항목을 한 행씩 적는다.
  - 각 행에 범주 태그(프로필·위치 기록·코스·뱃지·기기·분석/크래시 등)를 단다.
  - 처리방침은 범주로 묶어 쓰되, 어느 필드에서 나왔는지 거슬러 올라갈 수 있게 한다.
  - 근거: 개인정보위 「처리방침 작성지침」(2026.4 개정 보도)도 항목을 하나씩 나열하는 것이 원칙이다. 유형별 기재는 특별한 사정이 있을 때만 예외로 허용한다.
  - 열은 성공 기준 3을 따른다: 항목, 출처, 목적, 저장 위치(리전), 수탁자, 국외 이전, 보유 기간, 삭제 방식, 근거 파일 경로.
- **D-08:** prod Firebase 프로젝트는 아직 없다. `lib/core/firebase/firebase_options_prod.dart`는 placeholder이고 `.firebaserc`에는 dev만 있다.
  - 리전 같은 값은 dev에서 확인한 값을 적고, 행마다 「근거: dev」를 표시한다.
  - 결정 목록에 새 항목을 넣는다: 「prod(그리고 stg)를 dev와 같은 리전으로 만든다. 다르면 처리방침의 국외 이전·저장 위치 항목이 바뀐다」.
  - 이 항목은 Phase 7 처리방침 커밋 전에 확인하는 것으로 둔다.
- **D-09:** 목록 머리에 기준 앱 커밋을 적는다(작성 시점 HEAD, 논의 시점 `3afb2085`, 2026-11-13).
  - Phase 6·7·8을 시작할 때 그 커밋 이후의 앱 변경분(`git diff <기준 커밋>..HEAD`)만 보고 목록을 고친다.
  - 이 재확인 규칙을 목록 안에도 적는다.

### 결정 목록과 사용자 작업 목록 (BASE-04)
- **D-10 (U12 결정됨):** 슬림펌킨 업무 메일은 **Google Workspace**이다.
  - 지원 메일은 연구 기본안이던 ImprovMX 대신 `runningpencil.com`을 Workspace에 붙여서 받는다.
  - 사용자 별칭 도메인(user alias domain)은 공식 문서상 추가 비용이 없어 1순위로 검토한다. 보조 도메인(secondary domain)은 그 도메인에 만드는 사용자 계정마다 과금된다.
  - 실제 방식과 절차는 연구자가 Google 공식 문서로 확인한다. 확인할 것: `support@`를 그룹으로 둘지 별칭으로 둘지, 「다른 주소로 보내기(send as)」, 별칭 도메인에도 DKIM을 걸 수 있는지.
  - `.planning/research/STACK.md`는 Workspace 경로를 unverified로 적었다.
  - PROJECT.md·ROADMAP·STATE에 남은 ImprovMX 전제 문장(예: ROADMAP Phase 5 External gates)은 이 결정에 맞춰 고쳐야 한다. — **Reversibility:** costly — DNS MX를 다른 메일 서비스로 바꾸면 이메일 게이트(외부 4곳 수신 시험)를 다시 거쳐야 한다.
- **D-11:** 지원 메일 답장은 지원 주소 `support@runningpencil.com`에서 보낸다.
  - 그래서 가비아 DNS 표에 `runningpencil.com`의 DKIM 레코드를 넣는다.
  - Phase 10에서 Apple Private Email Relay에 발신처로 등록할 도메인은 `runningpencil.com`이다.
- **D-12:** 결정 목록은 항목마다 아래를 적는다: 질문, 근거, 권장안, 정하지 않았을 때 작업이 따를 기본 동작, 결정 주체(사용자 / 법률 확인), 막는 단계, 결정이 필요한 마감 단계.
  - 대상: U2, U3, U5, U6, U7, U8, U9, U11, U13, 그리고 새 항목 「prod 리전」. U12는 「결정됨」으로 기록한다.
  - 기본 동작을 정하는 규칙:
    - 법률 판단 항목(U2·U3·U7)은 보수적인 쪽을 기본으로 하고 「초안·법률 확인 필요」로 표시한다.
    - 사실값 항목(U11)에는 기본값이 없다. 값이 오기 전에는 render-if-present로 숨긴다.
    - 사실값을 추측하지 않는다는 원칙은 그대로다.
- **D-13:** 사용자 작업 목록은 「따라 하면 되는 절차서」로 쓴다.
  - 작업마다 적을 것: 순서, 레코드 표(호스트·유형·값·용도), 변경 전후 `dig` 명령과 기대 결과, 끝났는지 확인하는 방법, 끝나면 Claude에게 넘길 것.
  - 서비스가 발급하는 값(Workspace 도메인 인증 TXT, Search Console TXT, DKIM 공개키 등)은 「콘솔에서 복사」로 표시한다. 기억에 기대어 값을 적지 않는다.
  - 포함할 작업:
    - 가비아 DNS: Workspace 도메인 인증, MX, SPF 1개(하나로 합침), `runningpencil.com` DKIM, Search Console TXT, 권장 항목인 `_github-pages-challenge-SlimPumpkin` TXT. 기존 A 4개와 `www` CNAME은 그대로 둔다.
    - Workspace 관리 콘솔: 도메인 추가, `support@` 설정, 보내기 설정
    - 외부 4곳(Gmail·네이버·iCloud·Outlook) 수신 시험과 기록 방법
    - 사업자 값(U11) 준비
    - 앱 화면 캡처(출시 범위 기능만, Phase 4)
  - 사용자가 이 목록을 받으면 Phase 2~4와 병행해 작업을 시작한다.
- **D-14 (조사로 고정):** 어느 결정이 어느 단계를 막는지는 `.planning/ROADMAP.md`의 External Gates 표를 따른다.
  - `.planning/research/SUMMARY.md`의 U 표는 예전의 8단계 번호와 옛 요구사항 ID(PRIV-15, SITE-09 등)를 쓰므로 단계 번호의 근거로 쓰지 않는다.

### 이름 표와 URL 대장 (BASE-01·BASE-02)
- **D-15:** 위치기반서비스 이용약관 경로는 `https://runningpencil.com/location-terms/`로 고정한다.
  - 기존 규칙(페이지마다 kebab-case 영어 디렉터리 하나)과 깊이가 같다.
  - 영문판이 생기면(v2 LOC-06) `/en/location-terms/`가 된다. URL 대장에는 v2 예약으로 적는다. — **Reversibility:** one-way — 콘솔에 등록하고 법적 문서끼리 서로 링크하면, 마일스톤 Ground Rule(경로 변경·리디렉션 금지) 때문에 바꿀 수 없다.
- **D-16:** URL 대장의 모든 주소는 `https://runningpencil.com/…/` 형식(apex·https·끝 슬래시)으로 쓴다. 대상은 다음 11개다.
  - KO 6개: `/`, `/privacy-policy/`, `/terms/`, `/data-deletion/`, `/support/`, `/location-terms/`
  - EN 5개: `/en/`, `/en/privacy-policy/`, `/en/terms/`, `/en/data-deletion/`, `/en/support/`
  - Google 동의 화면에는 KO `/privacy-policy/`를 등록하는 것이 기본이다(SUMMARY 판정).
- **D-17 (조사로 고정):** URL 대장의 「등록할 콘솔 필드」 열은 범주 수준까지만 적는다. 예: 「Google OAuth 동의 화면 — 개인정보처리방침 링크」, 「App Store Connect — Support URL」. 콘솔의 정확한 필드명은 Phase 10 연구에서 확정한다.
- **D-18:** 이 저장소(`SlimPumpkin/runningpencil.com`)는 **PUBLIC**이라 `.planning/`에 커밋하면 GitHub에서 누구나 본다.
  - 이름 표에는 사업자 값(사업자등록증 그대로의 상호·대표자·사업자등록번호·주소·영문 법인명·스토어 개발자 이름)의 항목과 「값이 들어갈 곳(Phase 5 `_data` 파일 경로)」만 적고, 값 칸은 비운다.
  - 값은 Phase 5에서 사이트에 공개하는 커밋에 처음 들어간다. 사용자가 공개하기로 정하기 전에는 git 이력에 남지 않으므로, 자택 주소 공개 부담(U11)을 덜 수 있다.
  - 지금 채우는 값: 한글 서비스명 러닝펜슬, 영문 서비스명 RunningPencil, 현행 운영사 표기 슬림펌킨, 도메인. — **Reversibility:** one-way — 공개 저장소에 한 번 커밋한 값은 지워도 이력과 포크에 남는다. 지금처럼 비워 두는 결정은 되돌릴 수 있다.
- **D-19:** 지원 이메일 주소는 `support@runningpencil.com`이다.
  - 사용자 작업 절차서에 이 주소가 필요하므로 `.planning/` 문서에는 적는다.
  - 사이트(HTML·`_data`)에는 이메일 게이트가 열릴 때까지 넣지 않는다. — **Reversibility:** one-way — 콘솔과 법적 문서에 공개하고 나면 주소를 바꿀 때 제공자 6곳과 스토어 2곳에 다시 등록해야 한다.
- **D-20:** 스토어와 로그인 동의 화면의 앱 표시명은 서비스명 그대로다(한국어 「러닝펜슬」, 영어 「RunningPencil」).
  - 부제·부가 문구는 이름에 넣지 않고 스토어 부제 칸에 따로 둔다.
  - DEL-02(삭제 안내에 스토어 표시 앱 이름)는 이 값을 쓴다.

### Claude's Discretion
- 기준 문서의 파일 구성과 위치. 예: `.planning/baseline/` 아래에 문서별 파일을 둘지, 한 파일로 묶을지. 사용자 작업 목록을 결정 목록과 같은 파일에 둘지 따로 둘지도 포함한다. 조건은 두 가지다. 운영자가 「이름 표 하나」「URL 대장 하나」를 찾을 수 있어야 하고, 이 경로들이 `_config.yml`의 `exclude`(`.planning/`)로 배포에서 빠져야 한다.
- 이름 표·URL 대장의 형식(마크다운 표 또는 YAML). Phase 5의 `_data`로 옮기기 쉬운 쪽을 고른다.
- 결정 목록의 항목별 권장안과 기본 동작의 구체 문구(D-12 규칙 안에서).
- 데이터 목록의 범주 태그 이름과 행 순서.
- ROADMAP·STATE·PROJECT의 ImprovMX 전제 문장을 이 단계에서 고칠지, 해당 단계(Phase 5) 계획 때 고칠지. 단, PROJECT.md Key Decisions에는 U12 결과(Workspace, `support@runningpencil.com`, 지원 주소로 답장)를 이 단계에서 기록한다.

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

ROADMAP의 Phase 1에는 `Canonical refs:` 줄이 없다. 아래 목록은 요구사항, 연구 문서, 정찰한 파일로 만들었다.

### 단계 범위와 요구사항
- `.planning/ROADMAP.md` — Phase 1 Goal·Success Criteria·Notes, Ground Rules(CLAUDE.md로 옮길 작업 규칙), External Gates 표(결정·작업이 막는 단계의 기준, D-14)
- `.planning/REQUIREMENTS.md` — BASE-01~05, Out of Scope 표, v2 항목(LOC-06의 `/en/location-terms/` 예약)
- `.planning/PROJECT.md` — Key Decisions(방침 구간의 출처, U12 결과 기록 대상), Constraints, Context(앱 범위·로그인·위치 수집 사실)
- `.planning/STATE.md` — Blockers/Concerns(사용자 외부 작업, 결정 목록 대상)

### 연구 (기준 문서의 내용 근거)
- `.planning/research/SUMMARY.md` — 「연구 간 충돌과 PROJECT.md 가정 정정」(KO 처리방침 URL, DNS TXT 도메인 속성 등의 판정), 「Consolidated Open Decisions」 U1~U14(설명·근거만 쓰고, 단계 번호는 옛 번호이므로 쓰지 않음)
- `.planning/research/STACK.md` — 현재 DNS 상태(`dig`, 2026-11-14: NS 가비아, A 4개, MX·TXT 없음, `www` CNAME), 메일 전달 선택지(Workspace 경로는 unverified), SPF 하나로 합치기, Search Console 도메인 속성
- `.planning/research/FEATURES.md` — 제공자·스토어별 웹사이트 요건(URL 대장의 콘솔 필드 범주 근거)
- `.planning/research/PITFALLS.md` — Pitfall 3·4·5·7(이름 불일치, URL 변경, 데이터 불일치, CLAUDE.md 역행)
- `.planning/research/ARCHITECTURE.md` — 사실값 슬롯(`_data`)과 이메일 게이트 패턴(이름 표가 가리킬 Phase 5 경로)

### 고칠 방침 문서 (BASE-05)
- `CLAUDE.md` — 루트, 사람이 쓴 정본. 옛 문장 위치: 7행(앱 설명), 9행(빌드 시스템 없음), 37행(`http.server`), 58행(연락처 이메일 미표시), 69행(`ko` 전용), 71행(RunningPencil 쓰지 않음)
- `.claude/CLAUDE.md` — GSD 생성본(`GSD:*-start source:` 표식). Content & Naming Rules 구간에 옛 규칙이 있다.
- `.planning/codebase/CONVENTIONS.md` — 142~146행 옛 규칙(생성 원본)
- `.planning/codebase/TESTING.md` — 65, 121행 RunningPencil·이메일 금지 검사
- `.planning/codebase/STACK.md`, `STRUCTURE.md`, `ARCHITECTURE.md`, `CONCERNS.md` — `noindex`·`http.server`·연락처 미표시 서술. 현재 상태 설명이면 D-01에 따라 두고, 방침으로 읽히는 문장이면 고친다.
- `README.md` — 「빌드 없음」과 `http.server`. Phase 2 전까지는 현재 상태로 맞으므로 D-01 기준으로 판단한다.
- `.planning/config.json` — `claude_md_path: ./.claude/CLAUDE.md`

### 앱 저장소 (데이터 목록 근거, 읽기 전용)
- `~/dv/woody/running_pencil/.planning/PROJECT.md`, `.planning/REQUIREMENTS.md` — 출시 범위(포인트 리워드 Out of Scope, 코스북 후순위), D-15(소셜 6개), 탈퇴 후 공개 코스 유지(D-28, U6)
- `~/dv/woody/running_pencil/.firebaserc`, `firebase.json` — dev 프로젝트만 있음(`running-pencil-dev`)
- `~/dv/woody/running_pencil/lib/core/firebase/firebase_options_{dev,stg,prod}.dart` — prod·stg는 placeholder(D-08)
- `~/dv/woody/running_pencil/functions/src/shared/region.ts` — Functions 리전 `asia-northeast3`(변경 불가 주석)
- `~/dv/woody/running_pencil/functions/src/` — `auth`, `email`, `messaging`, `places`, `running_pencil` 등 서버 처리
- `~/dv/woody/running_pencil/infra/router/deploy.sh` — OSRM 라우터 VM 기본 zone `asia-northeast3-a`(실제 값은 CLI로 확인)
- `~/dv/woody/running_pencil/firestore.rules`, `storage.rules`, `firestore.indexes.json` — 컬렉션·경로 구조
- `~/dv/woody/running_pencil/lib/core/auth/provider_id.dart` — 로그인 제공자 목록(Email/Password 포함 여부, U5)
- `~/dv/woody/running_pencil/docs/kit-fork.md`, `docs/setup.md` — 소셜 로그인·Firebase 설정 작업 목록

### 외부 문서 (이번 논의에서 확인)
- 개인정보위 「처리방침 작성지침」 2026.4 개정 보도 — 항목 개별 나열이 원칙: https://mobile.newsis.com/view/NISX20260424_0003604909 . 원문 대조는 Phase 7 연구에서 한다.
- Google Analytics 데이터 보존(콘솔 설정값): https://support.google.com/analytics/answer/7667196
- Google Workspace 별칭 도메인과 보조 도메인: https://support.google.com/a/answer/4399436 , https://knowledge.workspace.google.com/admin/domains/faq-for-multiple-domains

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `.planning/research/STACK.md`의 DNS 현황표와 레코드 표 형식: 가비아 DNS 절차서의 출발점. ImprovMX 행은 Workspace 값으로 바꾼다.
- `.planning/research/SUMMARY.md`의 U1~U14 표: 결정 목록의 질문·근거 문장을 재사용한다. 단계 번호와 요구사항 ID는 ROADMAP 기준으로 다시 매긴다.
- `.planning/codebase/TESTING.md:121`의 grep 검사: 성공 기준 5(옛 문장 0건)를 확인하는 명령의 출발점. 검사 대상 문자열은 새 방침에 맞게 바꾼다.

### Established Patterns
- 페이지마다 kebab-case 영어 디렉터리 하나에 `index.html` 하나를 둔다(pretty URL). URL 대장과 `/location-terms/`가 이 규칙을 따른다.
- `_config.yml`의 `exclude`에 `.planning/`가 이미 있다. 기준 문서를 `.planning/` 아래에 두면 배포되지 않는다. 다만 GitHub에서는 공개된다(D-18).
- 문서는 한국어 평서문으로 쓰고, 화면 구간 이름은 「」로 감싸며, 기술 용어는 영어를 병기한다(사용자 전역 지침).
- 커밋 메시지는 Conventional Commits 형식이다. prefix는 영어, 제목은 한국어. `main`에 푸시하면 곧 배포되므로 이 단계 산출물은 커밋까지만 하고 푸시는 사용자 확인 뒤에 한다.

### Integration Points
- 이름 표가 Phase 5 `_data`(사업자·연락처 슬롯)와 Phase 9 영문판의 출처가 된다.
- URL 대장이 Phase 8 푸터 링크, Phase 9 `hreflang`, Phase 10 콘솔 체크리스트·URL 점검의 출처가 된다.
- 데이터 목록이 Phase 6(삭제 안내)·7(처리방침)·8(약관·위치약관) 본문의 출처가 된다.
- 결정 목록과 사용자 작업 목록이 ROADMAP External Gates 표와 STATE Blockers를 구체화한다.

</code_context>

<specifics>
## Specific Ideas

- 방침 구간은 표 형식(방침 | 적용 | 상태)이 좋다. 논의에서 고른 미리보기는 다음과 같다.
  ```
  ## 이번 마일스톤 방침 (2026-11 결정)
  | 방침 | 적용 | 상태 |
  | 지원 이메일 공개 | Phase 5 이메일 게이트 후 | 결정됨, 주소 미공개 |
  | 영문명 RunningPencil | Phase 9 영문판 | 결정됨 |
  | Jekyll 빌드 | Phase 2 | 결정됨, 아직 http.server |
  ...
  ## Local preview
  python3 -m http.server 8000  ← Phase 2까지 유효
  ```
- URL 대장 미리보기(KO): `/`, `/privacy-policy/`, `/terms/`, `/location-terms/`(신설), `/data-deletion/`, `/support/`
- 사용자 작업 절차서를 받으면 사용자는 Phase 2~4와 병행해 가비아·Workspace 작업을 바로 시작한다. 이메일 게이트가 Phase 6·7의 임계 경로이므로 절차서를 가장 먼저 완성하는 편이 좋다.

</specifics>

<deferred>
## Deferred Ideas

None — 논의는 단계 범위 안에서 진행됐다. 아래는 다른 단계의 몫으로 기록만 해 둔다.
- 영문 위치약관 `/en/location-terms/` — v2 LOC-06. URL 대장에 예약으로만 적는다.
- 콘솔의 정확한 필드명 — Phase 10 연구.

</deferred>

---

*Phase: 01-ground-truth-policy-reset*
*Context gathered: 2026-11-14*
