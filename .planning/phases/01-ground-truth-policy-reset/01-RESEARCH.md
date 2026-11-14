# Phase 1: 기준표와 방침 정비 (Ground Truth & Policy Reset) - Research

**Researched:** 2026-11-14
**Domain:** 문서 전용 단계 — 앱 저장소 근거의 개인정보 데이터 목록, DNS·메일(Google Workspace) 절차서, 이름 표·URL 대장, `CLAUDE.md` 방침 갱신
**Confidence:** MEDIUM (앱 저장소 근거는 HIGH, 콘솔·리전 실측과 외부 서비스 절차는 MEDIUM~LOW)

**기준 앱 커밋:** `3afb20858257f024bf9a06d857198f593a1d351d` (2026-11-13, 앱 저장소 `~/dv/woody/running_pencil` HEAD. 작업 트리에 아이콘·스플래시 등 커밋 안 된 변경이 있으나 이 조사가 읽은 파일과는 겹치지 않음) [VERIFIED: `git log -1`]

> 표기: `[VERIFIED: 경로:행]`은 이 세션에서 파일을 열어 확인하고 값을 그대로 옮긴 것, `[CITED: URL]`은 공식 문서를 WebFetch로 한 번 읽은 것(요약 모델을 거쳤으므로 절차서에 옮길 때 원문을 다시 연다), `[ASSUMED]`는 확인하지 못한 학습 지식이다. 「미확인」은 데이터 목록에 그대로 옮길 칸 표시다.
> 이 저장소는 PUBLIC이다(D-18). 이 문서에는 IP 주소, 프로젝트 번호, 앱 ID, 계정 이메일, DNS 인증 토큰 값, 라우터 호스트 이름을 적지 않았다. 기준 문서도 같은 규칙을 따른다(아래 Security Domain).

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions

### CLAUDE.md 서술 방식 (BASE-05)
- **D-01:** 코드 설명 구간은 지금 코드의 실제 모습을 그대로 둔다(Tailwind CDN, `python3 -m http.server`, 복사된 공통 블록 등). 대신 문서 맨 앞에 「이번 마일스톤 방침」 구간을 새로 둔다.
  - 방침마다 적용 단계와 현재 상태를 표로 적는다. 예: 「Jekyll 빌드 — Phase 2에서 적용, 그전까지는 `http.server`」, 「지원 이메일 공개 — 이메일 게이트(Phase 5) 뒤, 그전에는 주소를 사이트에 넣지 않음」.
  - 로컬 미리보기 안내 같은 현재 상태 설명에는 언제까지 유효한지 표시한다.
  - 지금 사실이지만 규칙처럼 쓰인 문장은 「현재 X, Phase N에서 바뀜」 형태의 날짜 붙은 상태 문장으로 고친다. 예: `CLAUDE.md:58`(연락처 이메일 미표시), `:69`(`ko` 전용), `:71`(RunningPencil 쓰지 않음), `.planning/codebase/CONVENTIONS.md:146`(`noindex` 유지). 「현재 상태는 그대로 둔다」를 핑계로 남겨 두면 성공 기준 5를 통과하지 못한다.
  - 방침 표에는 성공 기준 5의 6가지와 함께 U14(법적 페이지 `noindex` 해제와 「임시 게시본」 문구 삭제, 적용 Phase 6·7·8)도 넣는다.
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
  - 이 컴퓨터에는 gcloud·firebase CLI가 설치돼 있고, 둘 다 `@slimpumpkin.com` 계정으로 로그인돼 있다(2026-11-14 확인).
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
  - ImprovMX를 전제한 문장은 **이 단계(Phase 1) 안에서** Workspace 결정에 맞게 고친다(D-21). — **Reversibility:** costly — DNS MX를 다른 메일 서비스로 바꾸면 이메일 게이트(외부 4곳 수신 시험)를 다시 거쳐야 한다.
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
- **D-21:** 이번 논의의 결정(U12 Workspace, `support@runningpencil.com`, 지원 주소로 답장, `/location-terms/`)을 이 단계 안에서 계획 문서에도 반영한다.
  - 고칠 곳 1: `.planning/ROADMAP.md`. External Gates 표의 U12 행과 「가비아 DNS 레코드」 행, Phase 5 External gates의 ImprovMX MX·SPF 문장과 「U12 결과」 문장, Phase 8 Notes의 「후보 `/location-terms/`」를 확정값으로.
  - 고칠 곳 2: `.planning/STATE.md` Blockers/Concerns의 ImprovMX 문장과 U12 항목.
  - 고칠 곳 3: `.planning/PROJECT.md` Key Decisions(U12 결과 추가).
  - 이유: Phase 5의 discuss 단계는 최근 CONTEXT 3개만 읽는다. ROADMAP·STATE가 ImprovMX를 말하면 이 결정이 뒤집힌다.
  - 방법: GSD 규칙 15에 따라 `gsd_run query`의 roadmap·state 핸들러가 있으면 그것을 쓴다. 핸들러가 없는 본문 문장은 계획자가 안전한 수정 방법을 정한다.

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

### Deferred Ideas (OUT OF SCOPE)
None — 논의는 단계 범위 안에서 진행됐다. 아래는 다른 단계의 몫으로 기록만 해 둔다.
- 영문 위치약관 `/en/location-terms/` — v2 LOC-06. URL 대장에 예약으로만 적는다.
- 콘솔의 정확한 필드명 — Phase 10 연구.
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| BASE-01 | 이름 표 하나로 한글·영문 서비스명, 사업자등록증 그대로의 상호와 영문 법인명을 확인 | 「이름 표」 절: 채울 값 4개와 비울 항목 7개, Phase 5 `_data` 키 대응, 앱 쪽 표시명 근거(`docs/kit-fork.md`) |
| BASE-02 | URL 대장 하나로 모든 공개 URL과 등록할 콘솔 필드를 확인 | 「URL 대장」 절: 11행 + v2 예약 1행, 콘솔 필드 범주(ARCHITECTURE 연구 표 재사용), 현재 라이브 상태 |
| BASE-03 | 앱 저장소 근거의 데이터 목록(항목·출처·목적·리전·수탁자·국외 이전·보유·삭제) | 「데이터 목록 근거」 절: 필드 단위 근거표 A~H, 리전·보존 기간 확인 결과, 「미확인」 목록과 CLI 명령 |
| BASE-04 | 결정 목록(U2·U3·U5~U9·U11~U13)과 무엇이 어느 작업을 막는지 | 「결정 목록 근거」 절: 항목별 코드 근거·막는 단계, 「사용자 작업 절차서 근거」 절: DNS 현황, Workspace 절차 |
| BASE-05 | `CLAUDE.md`가 바뀐 방침을 설명 | 「CLAUDE.md 갱신 근거」 절: 옛 문장 위치 전수 목록, 생성기 동작, 검사 범위와 정규식 |
</phase_requirements>

## Summary

이 단계는 코드가 아니라 문서를 만든다. 계획에 필요한 사실은 네 덩어리다. 첫째, 앱 저장소가 실제로 저장·전송하는 개인정보(데이터 목록의 행). 둘째, 가비아 DNS의 현재 상태와 Google Workspace 별칭 도메인 절차(사용자 작업 절차서). 셋째, 결정 목록 항목마다의 코드 근거. 넷째, `CLAUDE.md` 세 곳에 남은 옛 규칙 문장의 위치와 `.claude/CLAUDE.md` 생성기 동작. 이 넷을 이 문서에 파일·행 근거와 함께 모았으므로, 계획자는 앱 저장소를 다시 탐색하지 않고 작업을 나눌 수 있다.

조사에서 기존 연구(`.planning/research/`)와 CONTEXT의 전제를 고쳐야 하는 사실이 여섯 가지 나왔다.

1. **gcloud·firebase CLI 로그인이 만료됐다.** 두 CLI 모두 재인증을 요구해 dev 프로젝트를 조회하지 못했다. D-06의 CLI 근거는 사용자가 다시 로그인한 뒤에만 얻을 수 있다. 그전까지 리전 근거는 코드와 앱 문서뿐이다.
2. **탈퇴해도 비공개 코스가 지워지지 않는다.** 탈퇴 함수 둘 다 `courses`를 건드리지 않는다. 앱의 결정 D-28과 코드 주석은 「공개 코스」만 말하지만, 실제로는 비공개 코스(경로·출발점·지역 포함)도 남는다. U6의 「비공개 코스 처리」가 실제 문제다.
3. **Email/Password 가입이 UI에 드러나 있다.** 로그인 화면에 「이메일로 계속」 버튼과 회원가입 링크가 조건 없이 그려지고, dev Firebase에서 이메일 로그인 수단이 켜져 있다(U5의 근거).
4. **Firebase Authentication은 미국 데이터센터에서만 운영된다.** Firestore·Functions를 서울 리전에 두어도 계정 식별자·이메일은 국외로 간다. 처리방침의 국외 이전 항목은 dev·prod 리전과 무관하게 필요하다.
5. **가비아 DNS에 기존 레코드가 두 개 더 있다.** 앱의 경로 라우터용 하위 도메인 A 레코드와 `_github-pages-challenge-SlimPumpkin` TXT가 이미 있다. 기존 연구는 「A 4개와 `www` CNAME뿐」이라고 적었다. DNS 절차서는 이 두 레코드를 보존 대상으로 적어야 하고, GitHub Pages 인증 TXT 「추가」 작업은 「이미 있음 — 인증 상태만 확인」으로 바뀐다.
6. **Workspace DKIM은 Gmail을 켠 뒤 24~72시간을 기다려야 키를 만들 수 있다.** DNS 작업을 「한 번에」 끝낼 수 없고 두 번 방문해야 한다(1차: 도메인 인증·MX·SPF·Search Console, 2차: DKIM).

**Primary recommendation:** 기준 문서는 `.planning/baseline/` 아래 문서별 파일 5개로 두고, 사용자 작업 절차서를 가장 먼저 완성한다. 데이터 목록은 이 문서의 근거표 A~H를 행으로 옮기되, CLI로만 알 수 있는 칸은 「미확인(코드·문서 근거만)」으로 두고 사용자 재로그인 뒤에 채우는 작업을 따로 둔다. `CLAUDE.md`는 원본 맵(`CONVENTIONS.md`·`TESTING.md`) → 생성본 → 루트 순서로 고치고, 범위를 정한 정규식 검사로 성공 기준 5를 확인한다.

## Architectural Responsibility Map

이 단계는 웹 계층이 아니라 문서와 외부 설정을 다룬다. 계층을 「누가 소유하고 어디에 사는가」로 바꿔 적는다.

| Capability | Primary Tier | Secondary Tier | Rationale |
|------------|-------------|----------------|-----------|
| 이름 표·URL 대장·데이터 목록·결정 목록·사용자 작업 절차서 | 저장소 문서 (`.planning/baseline/`) | — | 배포 제외 대상이고 이후 단계의 입력이다. 사이트 HTML·`_data`에 넣지 않는다 |
| 방침 설명 | 저장소 문서 (루트 `CLAUDE.md`, `.claude/CLAUDE.md`) | 생성 원본 (`.planning/codebase/*.md`, `PROJECT.md`) | 생성본은 원본에서 다시 만들어지므로 원본이 1차 소유자다 |
| 개인정보 사실 | 앱 저장소 (읽기 전용) | dev Firebase·GCP (읽기 전용 CLI) | 사실의 출처는 앱이다. 이 저장소는 사본과 근거 경로만 갖는다 |
| DNS·메일·도메인 인증 | 외부 서비스 (가비아, Google Workspace, Search Console, GitHub 조직 설정) | 저장소 문서 (절차서) | 사용자가 한다. Claude는 절차와 확인 명령만 쓴다 |
| 사업자 사실값 | 사용자 | Phase 5 `_data` | 이 단계는 항목 이름과 들어갈 곳만 정한다 (D-18) |
| 계획 문서 정합 (ImprovMX → Workspace) | 저장소 문서 (`ROADMAP.md`, `STATE.md`, `PROJECT.md`) | — | D-21. 이후 단계의 discuss가 이 문서를 읽는다 |
| 라이브 사이트 (HTML, `_config.yml`, `favicon/`) | — | — | 이 단계는 손대지 않는다 |

## Project Constraints (from CLAUDE.md)

세 파일(사용자 전역 `~/.claude/CLAUDE.md`, 루트 `CLAUDE.md`, `.claude/CLAUDE.md`)에서 이 단계에 해당하는 지시만 뽑았다. 「이 단계가 바꿈」으로 표시한 줄은 제약이 아니라 이 단계의 수정 대상이다.

| 지시 | 출처 | 이 단계에서의 지위 |
|------|------|--------------------|
| 한국어로 쓰고 기술 용어는 영어 병기, 추측하지 말고 모르면 모른다고 씀 | 전역 | 적용 — 기준 문서 전체, 「미확인」 표기의 근거 |
| 민감 데이터(API 키·비밀번호·PII)를 하드코딩하지 않음 | 전역 | 적용 — 공개 저장소의 기준 문서에 비밀·식별자·사업자 값을 적지 않음(D-18) |
| Conventional Commits, prefix 영어·제목 한국어 | 전역, `.claude/CLAUDE.md` Commit Messages | 적용 — 예: `docs(01): 데이터 목록 작성` |
| 커밋 전 린터 실행 | 전역 | 이 저장소에는 린터가 없음. 문서 단계이므로 아래 검증 명령으로 대신함 |
| 새 마크다운 문서를 추가하면 `_config.yml`의 `exclude`에 적음 | 루트 `CLAUDE.md:11` | 적용 — 단, `.planning/`이 이미 `exclude`에 있어 그 아래 문서는 추가 등록이 필요 없음 [VERIFIED: `_config.yml:9-13`] |
| `main` 푸시가 곧 배포 | 루트 `CLAUDE.md:75` | 적용 — 이 단계는 커밋까지만 하고 푸시는 사용자 확인 뒤(CONTEXT) |
| 파일 수정은 GSD 명령을 통해 시작 | `.claude/CLAUDE.md` GSD Workflow Enforcement | 적용 — `/gsd-execute-phase` |
| 사용자 제공 사실값은 추측해서 채우지 않음 | `.claude/CLAUDE.md` Constraints | 적용 — 이름 표 빈칸, 결정 목록 U11 |
| 법적 본문은 앱 코드에서 확인한 사실에만 근거 | `.claude/CLAUDE.md` Constraints | 적용 — 데이터 목록이 그 근거 |
| 한국어 기본 + 영문판, 영문 서비스명 일치 | `.claude/CLAUDE.md` Constraints | 적용 — 이름 표 |
| 앱 설명 문장의 「뱃지와 포인트를 모으고, 지역 코스북을 완성하고 … 포인트로 굿즈를 교환」 | 루트 `CLAUDE.md:7` | **이 단계가 바꿈** (D-05) |
| 「연락처 이메일도 표시하지 않습니다 (법적 페이지 포함)」 | 루트 `CLAUDE.md:58` | **이 단계가 바꿈** (D-01) |
| 「본문·`<html lang>` 모두 `ko`」 | 루트 `CLAUDE.md:69` | **이 단계가 바꿈** (D-01) |
| 「영문 `RunningPencil`은 쓰지 않고」 | 루트 `CLAUDE.md:71` | **이 단계가 바꿈** (D-01) |
| 「서비스 이름은 한글 러닝펜슬만 … `RunningPencil`은 쓰지 않는다」「연락처 이메일·이메일 수집 폼을 넣지 않는다」「`noindex`를 유지한다」 | `.claude/CLAUDE.md:165,167,168` (원본 `CONVENTIONS.md:143,145,146`) | **이 단계가 바꿈** (D-04) |
| 「빌드 시스템 없음」, `python3 -m http.server`, Tailwind CDN | 루트 `CLAUDE.md:9,37,44` 등 | 현재 상태 설명 — D-01에 따라 두되 유효 기간 표시 |

## Standard Stack

새 패키지를 설치하지 않는다. 쓰는 도구는 이미 이 컴퓨터에 있다.

### Core
| 도구 | 버전 | 용도 | 근거 |
|------|------|------|------|
| `grep -E` / `sed` (BSD) | macOS 기본 | 옛 문장 검사, 근거 행 번호 확인 | `.planning/codebase/TESTING.md:105`가 BSD·zsh 주의점을 이미 적어 둠 [VERIFIED: `TESTING.md:105`] |
| `dig` | `/usr/bin/dig` | DNS 변경 전후 기록 | 이 세션에서 실행 확인 |
| `git` (앱 저장소 읽기) | — | 기준 커밋, `git diff <기준>..HEAD` 재확인 | D-09 |
| GSD 도구 (`gsd-tools.cjs`) | 설치됨 | `state` 핸들러, `generate-claude-md`, `commit` | 아래 「CLAUDE.md 갱신 근거」 |

### Supporting
| 도구 | 버전 | 용도 | 상태 |
|------|------|------|------|
| `gcloud` | 591.0.0 | dev 리전·TTL·백업·버킷 읽기 조회 | 설치됨, **자격 증명 만료** (아래 Environment Availability) |
| `firebase` CLI | 15.29.0 | 확장·함수 목록 조회 | 설치됨, **자격 증명 만료** |
| `curl` | — | 라이브 URL 상태 코드 확인 | 사용 가능 |

### Alternatives Considered
| 기본 | 대안 | 대안이 맞는 때 |
|------|------|----------------|
| 마크다운 표 (이름 표·URL 대장) | YAML 파일 | Phase 5에서 `_data/company.yml`로 그대로 복사하고 싶을 때. 다만 이름 표는 값 칸이 대부분 비어 있고 「들어갈 곳」「출처」 같은 설명 열이 필요해 표가 읽기 쉽다. 표의 첫 열에 `_data` 키 이름을 적으면 옮기기 쉬움은 같다 |
| `generate-claude-md`로 생성본 재생성 | 원본과 생성본을 같은 줄 단위로 손수 고침 | 재생성이 예상 밖 줄을 바꿀 때 (아래 Pitfall 4) |

**Installation:** 없음.

## Package Legitimacy Audit

이 단계는 외부 패키지를 설치하지 않는다. 감사 대상이 없다.

**Packages removed due to [SLOP] verdict:** 없음
**Packages flagged as suspicious [SUS]:** 없음

## Architecture Patterns

### System Architecture Diagram

```
앱 저장소 (읽기 전용, 기준 커밋 3afb2085)
  ├─ firestore.rules / storage.rules ─────┐
  ├─ functions/src/** (탈퇴·프록시·메일) ──┤
  ├─ lib/** (위치·분석·로그인 UI) ─────────┼──► [데이터 목록]  ──► Phase 6 삭제 안내
  ├─ android/ios 매니페스트 ───────────────┤     (필드 단위 행,      Phase 7 처리방침
  └─ docs/·infra/ (리전·설정 기록) ────────┘      근거 경로, 미확인)   Phase 8 약관·위치약관
                                                     │
dev Firebase·GCP ──(읽기 전용 CLI, 재로그인 필요)────┘
공식 문서 (Firebase privacy, GA, Meta SDK) ──────────┘

데이터 목록의 틈·코드 근거 ──► [결정 목록] ──► 각 단계의 External gates
ROADMAP External Gates 표 ───┘   (질문·근거·권장안·기본 동작·막는 단계)

dig 현재 DNS ─────────────┐
Workspace 공식 문서 ───────┼──► [사용자 작업 절차서] ──► 사용자 (가비아·Workspace·Search Console)
가비아 화면 (사용자 확인) ─┘                                  │
                                                             ▼
                                              이메일 게이트 (Phase 5) ──► Phase 6·7 커밋

PROJECT.md Key Decisions ─┐
REQUIREMENTS / D-15~D-20 ─┼──► [이름 표] ──► Phase 5 _data, Phase 9 영문판, Phase 10 콘솔
                          └──► [URL 대장] ──► Phase 8 푸터, Phase 9 hreflang, Phase 10 점검

CONVENTIONS.md / TESTING.md (원본) ──► generate-claude-md ──► .claude/CLAUDE.md (생성본)
PROJECT.md Constraints ──────────────┘                         + 마커 밖 「이번 마일스톤 방침」
루트 CLAUDE.md (사람이 쓴 정본) ──► 직접 수정 ──► 정규식 검사 (성공 기준 5)
```

### Recommended Project Structure

```
.planning/
├── baseline/                    # 이 단계의 산출물 (배포 제외: _config.yml exclude의 .planning/)
│   ├── NAMES.md                 # 이름 표 (BASE-01)
│   ├── URLS.md                  # URL 대장 (BASE-02)
│   ├── DATA-INVENTORY.md        # 데이터 목록 (BASE-03)
│   ├── DECISIONS.md             # 결정 목록 (BASE-04)
│   └── USER-TASKS.md            # 사용자 작업 절차서 (BASE-04)
├── codebase/CONVENTIONS.md      # 옛 규칙 문장 수정 (생성 원본)
├── codebase/TESTING.md          # 금지 표기 검사 수정
├── ROADMAP.md / STATE.md / PROJECT.md   # D-21 정합
CLAUDE.md                        # 방침 구간 + 옛 문장 수정
.claude/CLAUDE.md                # 방침 구간(마커 밖) + 재생성
```

파일을 나누는 이유: 성공 기준이 「이름 표 하나」「URL 대장 하나」를 요구하고, 다섯 문서의 수명이 다르다. 데이터 목록은 Phase 6·7·8 착수 때마다 고치고(D-09), 절차서는 사용자가 따라 하며 체크하고, 결정 목록은 결정이 날 때마다 고친다. 한 파일로 묶으면 커밋이 서로 얽힌다. 절차서를 결정 목록과 분리하는 이유는 독자가 다르기 때문이다(절차서는 사용자가 가비아 화면 옆에 띄워 두고 본다).

### Pattern 1: 근거 붙은 행 (Evidence-cited Row)
**What:** 데이터 목록의 모든 행은 「근거」 열에 앱 저장소 상대 경로와 행 번호를 갖는다. 근거가 코드가 아니면 종류를 적는다(「근거: dev 설정 기록(문서)」「근거: dev CLI」「근거: 공식 문서」).
**When to use:** 데이터 목록 전 행.
**Example:**
```markdown
| 항목 | 범주 | 출처 | 목적 | 저장 위치(리전) | 수탁자 | 국외 이전 | 보유 기간 | 삭제 방식 | 근거 |
| `runs.path` (GPS 궤적, 인코딩 문자열 ≤ 100,000자) | 위치 기록 | 기기 GPS(기록 중) | 완주 판정·내 기록 표시 | Firestore `asia-northeast3` (근거: dev 설정 기록, CLI 미확인) | Google(Firebase) | 미확인(prod 리전에 따름) | 탈퇴 또는 본인 삭제까지 | 탈퇴 시 `cleanupUserData`가 삭제 | `firestore.rules:231-257`, `functions/src/running_pencil/cleanup_user_data.ts:42-56` |
```

### Pattern 2: 「미확인」과 확인 방법을 한 쌍으로
**What:** 확인하지 못한 칸은 「미확인」이라고만 쓰지 않고, 누가 어디서 확인하는지를 같은 행이나 문서 끝 「확인할 것」 표에 적는다.
**When to use:** 콘솔 전용 값(Analytics 보존 기간, 백업 정책), CLI 조회가 필요한 값(리전, TTL 정책), 앱 밖 SDK 동작.
**Example:**
```markdown
| 미확인 칸 | 확인하는 사람 | 확인 방법 | 막는 단계 |
| Analytics 사용자·이벤트 데이터 보존 기간 | 사용자 | Google Analytics > 관리 > 데이터 설정 > 데이터 보관 | Phase 6(절대 표현), Phase 7 |
```

### Pattern 3: 날짜 붙은 상태 문장 (Dated Status Sentence)
**What:** 지금은 사실이지만 규칙처럼 읽히는 문장을 「현재 X (2026-11 기준). Phase N에서 Y로 바뀜」으로 고친다. 옛 규칙의 문구는 인용하지 않는다(D-02).
**When to use:** 루트 `CLAUDE.md:58,69,71`, `CONVENTIONS.md:142-146`, `TESTING.md:65,119-121`, `CONCERNS.md:56`.
**Example:**
```markdown
- 현재 페이지는 모두 `<html lang="ko">`다 (2026-11 기준). Phase 9에서 `/en/` 아래 영문판(`lang="en"`)이 생긴다.
- 현재 사이트에는 연락처 이메일이 없다 (2026-11 기준). 이메일 게이트(Phase 5)가 열리면 지원 이메일을 푸터와 법적 문서에 넣는다. 그전에는 주소를 HTML·`_data`에 넣지 않는다.
```

### Pattern 4: 원본 먼저, 생성본 나중 (Source-first Regeneration)
**What:** `.claude/CLAUDE.md`의 마커 블록은 원본에서 다시 만들어진다. 원본을 고친 뒤 생성본을 맞춘다. 마커 밖에 둔 글은 재생성 때 보존된다.
**When to use:** BASE-05 전체. 자세한 동작은 아래 「CLAUDE.md 갱신 근거」.

### Anti-Patterns to Avoid
- **생성본만 고침:** `.claude/CLAUDE.md`만 고치면 다음 `generate-claude-md` 실행이 `CONVENTIONS.md`의 옛 문장을 되살린다(D-04).
- **옛 규칙을 인용하며 부정:** 「더 이상 『RunningPencil은 쓰지 않는다』가 아니다」라고 쓰면 정규식 검사에 걸리고, 다음 세션이 인용문을 규칙으로 읽을 수 있다(D-02).
- **dev 값을 확정값처럼 적음:** 리전 행에 「근거: dev」가 빠지면 Phase 7이 prod 확인 없이 국외 이전 항목을 쓴다(D-08).
- **비밀·식별자를 근거로 옮김:** 앱 저장소의 `infra/router/RUNBOOK.md`에는 고정 IP, 프로젝트 번호, 관리자 계정, 라우터 호스트 이름이 있다. 근거는 경로와 행 번호로만 가리키고 값은 옮기지 않는다.
- **서비스 발급 값을 기억으로 적음:** Workspace 인증 TXT, Search Console TXT, DKIM 공개키는 「콘솔에서 복사」로만 적는다(D-13).

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| `STATE.md` Blockers 항목 수정 | 본문을 정규식으로 치환 | `gsd-tools state resolve-blocker` / `add-blocker`를 먼저 시도, 안 맞으면 `Edit` | 하위 명령 목록만 확인했다. 두 핸들러가 이 `STATE.md`의 Blockers 구간(소제목 아래 목록, 한 항목 안에 여러 게이트가 섞인 문장)을 어떻게 다루는지는 실행해 보지 않았다 [ASSUMED]. D-21이 고칠 문장은 열린 채로 남는 항목 안의 일부(「ImprovMX MX 2개 + SPF 1개」)라 항목을 닫고 다시 여는 방식이 맞지 않을 수 있다. 그 경우 `Edit`로 문장을 고치고 `gsd-tools state validate`로 확인한다. 사용 가능한 하위 명령: `load, complete-phase, json, get, update, patch, begin-phase, advance-plan, record-metric, update-progress, add-decision, add-blocker, resolve-blocker, record-session, signal-waiting, signal-resume, planned-phase, validate, sync, prune, rebuild, milestone-switch, add-roadmap-evolution` [VERIFIED: `gsd-tools state bogus` 출력] |
| `.claude/CLAUDE.md` 블록 다시 만들기 | 블록 전체를 손으로 다시 씀 | `gsd-tools generate-claude-md` | 블록별 요약 규칙이 있다(아래). 단, 결과 diff를 확인한다 |
| DNS 값 확인 | 가비아 화면 캡처만 믿음 | `dig +short` 변경 전후 기록 | 전파 여부는 외부에서 본 결과로만 확인된다 |
| 리전 확인 | 코드 주석에서 추정 | `gcloud … describe`(읽기 전용) | 주석은 dev를 설명할 뿐이고 실제 배포 값이 아니다 |
| 커밋 | `git commit` 직접 | `gsd-tools query commit` | `commit_docs: true` 흐름과 맞춘다 |

`ROADMAP.md` 본문 문장(External Gates 표의 행, Phase 5 External gates 문장, Phase 8 Notes)을 고치는 핸들러는 없다. `roadmap` 하위 명령은 `analyze, milestone-scope, get-phase, update-plan-progress, annotate-dependencies, validate, upgrade`뿐이다 [VERIFIED: `gsd-tools roadmap` 출력]. 이 문장들은 `Edit`로 고치고, 고친 뒤 `gsd-tools roadmap validate`로 구조가 깨지지 않았는지 확인한다.

**Key insight:** 이 단계의 실패는 「틀린 값을 그럴듯하게 적는 것」이다. 값을 만드는 도구가 있으면 그 도구의 출력을 붙이고, 없으면 「미확인」으로 둔다.

## Runtime State Inventory

이 단계는 방침 문장을 바꾸는 문자열 교체를 포함하므로 저장소 밖에 옛 문장이 남는 곳을 확인했다.

| Category | Items Found | Action Required |
|----------|-------------|------------------|
| Stored data | 없음 — 이 저장소에는 데이터베이스가 없다. Claude 자동 메모리(`~/.claude/projects/…/memory`)도 이 프로젝트에는 없다 [VERIFIED: `ls` 결과 없음] | 없음 |
| Live service config | (1) 가비아 DNS: A 4개, `www` CNAME, 라우터용 하위 도메인 A 1개, `_github-pages-challenge-SlimPumpkin` TXT 1개 [VERIFIED: `dig`, 2026-11-14]. (2) dev용 소셜 로그인 앱 콘솔에 기존 URL 3개가 등록돼 있을 수 있다(PROJECT.md Context). 둘 다 이 단계에서 바꾸지 않는다 | 절차서에 「보존할 기존 레코드」로 기록 |
| OS-registered state | 없음 | 없음 |
| Secrets/env vars | 없음 — 이 저장소에는 환경변수·비밀이 없다 | 없음 |
| Build artifacts | (1) `.claude/CLAUDE.md` — 생성본, 원본을 고친 뒤 다시 만든다. (2) `.planning/research/.cache/` — 이 조사에서 GSD `research-store`가 만든 요약 캐시(추적 안 됨) | (1) 재생성 또는 같은 줄 수정. (2) 커밋하지 않는다. 계획자가 `.gitignore` 등록 여부를 정한다 |

라이브 확인: `https://runningpencil.com/CLAUDE.md`, `/.claude/CLAUDE.md`, `/.planning/PROJECT.md`, `/.planning/ROADMAP.md`는 모두 404다 [VERIFIED: `curl`, 2026-11-14. `/.claude/CLAUDE.md`는 첫 두 번 503이 났고 헤더까지 받은 세 번째 응답이 404였다]. 따라서 `.planning/baseline/`과 `.claude/CLAUDE.md`는 사이트에 올라가지 않는다. 다만 GitHub 저장소 화면에서는 누구나 본다.

## 데이터 목록 근거 (BASE-03)

아래 표들은 데이터 목록의 행 후보다. 경로는 모두 앱 저장소(`~/dv/woody/running_pencil`) 기준 상대 경로다. 계획자는 이 표를 D-07의 열 구성으로 옮기는 작업을 만들면 된다.

### A. 계정·프로필 (Firebase Auth + Firestore `users/{uid}` + `identity_index`)

| 항목 | 값·형태 | 쓰는 주체 | 근거 |
|------|---------|-----------|------|
| Firebase Auth 사용자 레코드 | uid, 이메일, 표시 이름, 사진 URL, 연결된 제공자 | Firebase Auth, Functions(`createUser`·`updateUser`) | `functions/src/auth/identity_index.ts:64-92` (재로그인 때 `email`·`displayName`·`photoURL` 갱신 정책 `"truth-of-source"`) |
| `users/{uid}.termsAccepted` | 맵, 키 `['version', 'service', 'privacy', 'marketing', 'acceptedAt']` | 클라이언트 | [VERIFIED: `firestore.rules:54-64`] |
| `users/{uid}.signUpProviderId` | 문자열(가입 수단, 한 번만 기록) | 클라이언트·Functions | [VERIFIED: `firestore.rules:82-90`] |
| `users/{uid}.customPhotoUrl` | null 또는 Firebase Storage 다운로드 URL(≤ 2048자) | 클라이언트 | [VERIFIED: `firestore.rules:104-110`] |
| `users/{uid}.linkedProviders[]` | `{providerId, providerUserId}` 배열 | Functions(Admin) | [VERIFIED: `functions/src/auth/identity_index.ts:1106-1124`] |
| `users/{uid}.providerLinkedAt` | 맵 `{[provider]: 시각}` | Functions(Admin) | 위와 같음 |
| `users/{uid}.email`, `emailVerified` | 계정 대표 이메일 사본, bool | Functions(Admin) | [VERIFIED: `functions/src/auth/mirror_account_email.ts:71-75`], `identity_index.ts:1118-1121` |
| `identity_index/{provider}:{providerUserId}` | 필드 `firebaseUid`, `provider`, `providerUserId`, `linkedAt`, `lastSeenAt` | Functions(Admin), 클라이언트 접근 차단 | [VERIFIED: `functions/src/auth/identity_index.ts:1095-1101`, `firestore.rules:290-292`] |
| `users/{uid}/…` Storage 객체 | 프로필 사진, 이미지 형식, 5MB 이하, 본인만 읽기 | 클라이언트(정식 사용자) | [VERIFIED: `storage.rules:12-19`] |

클라이언트가 쓸 수 있는 `users/{uid}` 키는 `['termsAccepted', 'signUpProviderId', 'customPhotoUrl']` 셋뿐이다 [VERIFIED: `firestore.rules:48-50`].

`termsAccepted.marketing`은 bool이다. 앱 문자열에 「마케팅 정보 수신」 동의 항목이 있다 [VERIFIED: `lib/l10n/app_ko.arb:192`]. 마케팅 푸시를 실제로 보내는 기능이 있는지는 확인하지 못했다(「미확인」 — 배포된 푸시 함수는 `sendTestPush`뿐이다, `functions/src/index.ts:82`).

### B. 로그인 제공자별 수신 항목 (PRIV-10의 원본)

| 제공자 | 앱이 요청하는 범위 | 서버·앱이 읽는 항목 | 근거 |
|--------|-------------------|---------------------|------|
| 카카오 | OIDC (`serviceTerms: ['openid']`) | ID 토큰의 `sub`, `email`, `email_verified`, `nickname`, `picture` | `lib/features/auth/data/kakao_sdk_client.dart:103`, `functions/src/auth/kakao_custom_token.ts:130-144` |
| 네이버 | 프로필 API(`/v1/nid/me`) | `id`, `email`, `nickname`, `profile_image` | `functions/src/auth/naver_profile_to_custom_token.ts:249-264` |
| LINE | `['openid', 'profile', 'email']` | ID 토큰의 `sub`, `name`, `picture`, `email` | `lib/features/auth/data/line_sdk_client.dart:184`, `functions/src/auth/line_custom_token.ts:135-144` |
| Facebook | `['email', 'public_profile']` | Firebase Auth가 받는 이메일·이름·사진 | `lib/features/auth/data/auth_repository.dart:3954` |
| Apple | `email`, `name` | Firebase Auth가 받는 이메일(가리기 주소 가능)·이름 | `lib/features/auth/data/auth_repository.dart:658-660` |
| Google | `GoogleSignIn.authenticate()` (범위 인자 없음) | Firebase Auth가 받는 이메일·이름·사진 — 정확한 기본 범위는 [ASSUMED] | `lib/features/auth/data/auth_repository.dart:477` |
| 익명 | — | uid만. 코스·기록·뱃지 쓰기는 막힘 | `firestore.rules:41-45`, `:322`, `:351` |
| Email/Password | 이메일, 비밀번호(Firebase Auth가 보관) | 아래 U5 참고 | `lib/features/auth/data/auth_repository.dart:305`, `:368` |

활성 제공자 설정(dev): `"enabledAuthProviders": "google,apple,facebook,kakao,naver,line"` [VERIFIED: `config/dev.json:18`].

각 제공자의 「필수/선택」 구분은 앱 코드가 아니라 제공자 콘솔의 동의항목 설정이 정한다. 데이터 목록에는 「미확인(콘솔 설정)」으로 두고 Phase 7·10에서 콘솔 화면으로 확인한다.

### C. 위치·기록·코스·뱃지

| 항목 | 값·형태 | 근거 |
|------|---------|------|
| `runs/{runId}` | 키 `['userId', 'courseId', 'path', 'courseTitle', 'policyVersion', 'startedAt', 'endedAt', 'durationSeconds', 'distanceMeters', 'startCheckpointIndex', 'direction', 'movingSeconds', 'isCompleted', 'checkpointHitRatio', 'region']`. `path`가 GPS 궤적(≤ 100,000자). 본인만 읽기·삭제, 수정 없음 | [VERIFIED: `firestore.rules:231-257`, `:347-353`] |
| `courses/{courseId}` | 키 `['creatorId', 'title', 'polyline', 'waypoints', 'sketchPolyline', 'distanceMeters', 'startPoint', 'bounds', 'badgeTemplateId', 'createdAt', 'updatedAt', 'visibility', 'badgeRotationDegrees', 'region']`, 공개 전환 때 `publishedAt` 추가. 만들 때는 `visibility == 'private'`만, 공개는 한 방향 | [VERIFIED: `firestore.rules:192-200`, `:319-333`] |
| `users/{uid}/badges/{courseId}` | 키 `['runId', 'earnedAt', 'title', 'polyline', 'badgeTemplateId', 'badgeRotationDegrees', 'region']` (코스 모양 사본 포함) | [VERIFIED: `firestore.rules:269-281`, `:426-434`] |
| `region` (courses·runs·badges 공통, 선택) | 키 `['kind', 'emdCode', 'sido', 'sigungu', 'emd', 'sidoLabel', 'sigunguLabel', 'dataVersion']` — 법정동 단위 지역 | [VERIFIED: `firestore.rules:138-152`] |
| 기기 안 원시 GPS 로그 | `{앱 전용 폴더}/runs/active_run.jsonl` 파일 하나. 정상 종료면 저장 직후 삭제. 서버로 보내지 않음 | [VERIFIED: `lib/features/runs/application/run_log_store.dart:20`, `:56-57`] |

**위치를 읽는 시점은 세 가지다** [VERIFIED: `lib/core/location/location_platform.dart:107-190`].
- 에디터(editor): 지도 카메라와 내 위치 점 용도, 10m 간격. 저장하지 않는다.
- 시작 전(preStart): 워밍업 용도. 저장하지 않는다.
- 기록 중(recording): Android는 포그라운드 서비스 알림을 띄우고, iOS는 `allowBackgroundLocationUpdates: isRecording`으로 화면이 꺼져도 받는다. 이 궤적만 `runs.path`로 저장된다.

권한은 「앱 사용 중」뿐이다. Android는 `ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`, `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_LOCATION` [VERIFIED: `android/app/src/main/AndroidManifest.xml:4-8`], iOS는 `NSLocationWhenInUseUsageDescription`과 `UIBackgroundModes`의 `location` [VERIFIED: `ios/Runner/Info.plist:104-105`, `:137-142`].

이 사실은 SUP-04의 FAQ 문장(「위치를 수집하는 시점 — 기록 중에만」)에 영향을 준다. 정확한 표현은 「서버에 저장되는 위치는 기록 중의 궤적뿐이고, 코스를 그리거나 시작 전 화면에서는 기기가 현재 위치를 읽지만 저장하지 않는다」이다. 데이터 목록에 세 시점을 구분해 적는다.

### D. 외부로 나가는 요청 (저장하지 않는 처리)

| 처리 | 보내는 값 | 받는 곳 | 로그에 남는 것 | 근거 |
|------|-----------|---------|----------------|------|
| 경로 스냅 `snapRoute` | 지도에서 찍은 웨이포인트 좌표 2~50개(GPS 위치가 아님), 반경 | Functions → GCP VM의 자체 OSRM 라우터 | Functions: uid, 점 개수, 반경, 결과 코드, 소요 시간. 좌표 없음. 라우터 접속 기록: 좌표는 `[coords]`로 가림, 접속 IP는 앞부분만(IPv4 /16) — 접속 IP는 사용자 기기가 아니라 Functions의 IP다 | `functions/src/running_pencil/snap_route.ts:1-22`, `:516-542`, `infra/router/Caddyfile:24-41` |
| 장소 검색 `searchPlaces` | 검색어(≤ 50자), 지도 중심 좌표 | Functions → NCP Geocoding·Reverse Geocoding, NAVER API HUB 지역검색 | uid, 검색어 길이, 결과 코드. 검색어·좌표 없음. 결과를 저장하지 않음 | `functions/src/running_pencil/search_places.ts:1-33`, `:722-796`, `functions/src/shared/ncp_maps_params.ts`, `naver_api_hub_params.ts` |
| 지역 판정 `resolveRegion` | 좌표 1개(코스 출발점) | Functions 내부(법정동 경계 데이터, 외부 호출 없음) | uid, hit 여부, 소요 시간 | `functions/src/running_pencil/region/resolve_region.ts:1-28` |
| 네이버 지도 SDK | 지도 타일 요청, 클라이언트 ID. 그 밖에 SDK가 보내는 항목은 「미확인」 | 네이버클라우드 | — | `pubspec.yaml`(`flutter_naver_map`, 로컬 패키지), `lib/l10n/app_ko.arb:197`(앱 임시 처리방침이 「네이버 지도 SDK 이용 정보가 네이버클라우드에 제공」이라고 적음) |
| 소셜 연결 끊기 | 제공자별 토큰·회원번호 | 카카오·네이버·Facebook·LINE API | — | `functions/src/index.ts:67-76` |

Cloud Functions 로그(Cloud Logging)에는 uid가 남는다. 보존 기간은 「미확인」이다(기본 로그 버킷 30일로 알려져 있으나 [ASSUMED], CLI로 확인).

### E. 기기·알림·분석·크래시 (SDK가 다루는 항목)

| 항목 | 값·형태 | 근거 |
|------|---------|------|
| `users/{uid}/fcmTokens/{token}` | 키 `['token', 'platform', 'locale', 'updatedAt', 'expireAt']`, `platform in ['android', 'ios']`, `locale in ['ko', 'en', 'ja']`. 앱은 `expireAt`을 지금 + 30일로 쓰고 규칙 상한은 60일 | [VERIFIED: `firestore.rules:405-417`, `lib/features/notifications/domain/fcm_token.dart:17`] |
| Firebase Analytics | 사용자 ID로 uid를 붙임(`setUserId`). 사용자 속성 `guest_mode`(익명 여부). 앱이 직접 보내는 이벤트는 `onboarding_completed`와 개발용 `dev_tools_test_event` 둘, 그리고 화면 조회(`FirebaseAnalyticsObserver`). SDK가 스스로 모으는 기본 이벤트·기기 정보는 「미확인」. 수집을 끄는 스위치는 앱에 없음 | `lib/core/router/auth_guard.dart:593`, `lib/core/analytics/analytics_service.dart:53-57`, `lib/features/onboarding/presentation/onboarding_screen.dart:166`, `lib/features/demo/presentation/demo_screen.dart:978`, `lib/core/analytics/analytics_observer.dart:56-60`. `logEvent(` 호출처는 이 둘뿐이고, `setAnalyticsCollectionEnabled`·`setConsent` 호출과 매니페스트·plist의 수집 끄기 설정(`firebase_analytics_collection_*` 등)은 0건 [VERIFIED: 자르지 않은 grep, `lib`·`android/app/src`·`ios/Runner`] |
| Firebase Crashlytics | 사용자 식별자로 uid를 붙임, 사용자 정의 키 `flavor`, 오류·스택. 수집을 끄는 스위치 없음 | `lib/core/router/auth_guard.dart:594`, `lib/core/bootstrap.dart:134-155`. `setCrashlyticsCollectionEnabled` 호출 0건 [VERIFIED: grep] |
| App Check | 기기 증명 토큰 | `functions/src/index.ts:36`(`enforceAppCheck: true`), `lib/core/bootstrap.dart:120` 부근 |
| Remote Config | 로그인 수단 켜고 끄기 키 `auth_provider_{id}_enabled` | `lib/core/auth/provider_id.dart:64-65` |
| 기기 안 설정 | 언어·테마·온보딩 여부·알림 설정·FCM 토큰 키 등(`SharedPreferences`). 서버로 보내지 않음 | `lib/core/providers/locale_provider.dart`, `lib/features/notifications/application/notification_settings_notifier.dart:29` |
| Facebook SDK 자동 이벤트 | 아래 「Facebook SDK」 참고 | `android/app/src/main/AndroidManifest.xml:50-57`, `ios/Runner/Info.plist:79-84` |

### F. 서버 보조 컬렉션 (클라이언트 접근 차단)

| 항목 | 값·형태 | 근거 |
|------|---------|------|
| `rate_limits/{docId}` | `{count, windowStart}`. 문서 ID에 uid 또는 해시가 들어감. IP와 이메일은 원문이 아니라 SHA-256 앞 32자(salt 없음) | [VERIFIED: `functions/src/shared/rate_limit.ts:5`, `functions/src/shared/client_ip_hash.ts:11-28`, `functions/src/email/email_hash.ts:22-27`] |
| `mail/{id}` | `{to: [email], message}` — 수신 주소와 인증 링크. 확장 TTL 설정은 1일 | [VERIFIED: `functions/src/email/send_verification_mail.ts:190`, `extensions/firestore-send-email.env:6-8`(`MAIL_COLLECTION=mail`, `TTL_EXPIRE_TYPE=day`, `TTL_EXPIRE_VALUE=1`)] |

`mail` 컬렉션과 SMTP 발송 서비스는 메일 발송 모드가 `kit`일 때만 쓰인다. dev는 `"emailDelivery": ""`이고 빈 값은 Firebase Auth 기본 메일로 동작한다 [VERIFIED: `config/dev.json:19`, `lib/core/config/app_config.dart:232-239`]. prod에서 `kit`을 쓰면 SMTP 발송 서비스가 수탁자로 추가된다. 데이터 목록에는 「현재 미사용(dev 기준). prod 설정에 따름」으로 적고 결정 목록의 「prod 리전」 항목 옆에 함께 확인할 것으로 둔다. `rate_limits` 문서의 삭제 정책(TTL)은 「미확인」이다.

### G. 탈퇴 때 지워지는 것과 남는 것 (DEL-03의 원본)

| 데이터 | 탈퇴 시 처리 | 근거 |
|--------|--------------|------|
| Storage `users/{uid}/` 아래 객체 전부 | 삭제. 실패하면 탈퇴를 중단하고 다시 시도할 수 있음 | [VERIFIED: `functions/src/auth/delete_user_account.ts:211-215`, `:134-141`] |
| Firebase Auth 계정 | 삭제 | `delete_user_account.ts:279` |
| `identity_index` 중 `firebaseUid == uid` | 삭제 | `delete_user_account.ts:313-334` |
| `users/{uid}` 문서 | 삭제 | 위와 같음 |
| `users/{uid}/fcmTokens/*` | 삭제. 실패하면 TTL이 30일 안에 지움 | `delete_user_account.ts:361-380` |
| `runs` 중 `userId == uid` | 삭제(Auth 삭제 트리거) | [VERIFIED: `functions/src/running_pencil/cleanup_user_data.ts:17-21`, `:42-56`] |
| `users/{uid}/badges/*` | 삭제(Auth 삭제 트리거) | `cleanup_user_data.ts:64-69` |
| **`courses` 중 `creatorId == uid` (공개·비공개 모두)** | **삭제하지 않음** | 아래 U6 |
| `rate_limits` 중 uid가 들어간 문서 | 삭제하지 않음(「미확인」 — TTL 정책 확인 필요) | `delete_user_account.ts`에 해당 단계 없음 |
| Analytics·Crashlytics에 붙은 uid | 앱이 삭제 API를 부르지 않음. 각 서비스의 보존 기간에 따름 | 탈퇴 함수 두 개에 해당 호출 없음 |
| 제공자 쪽 앱 연결 | 탈퇴 전에 서비스별로 연결을 끊는 단계가 있음(건너뛸 수 있음) | `lib/l10n/app_ko.arb:364`, `:377` |

앱 안 메뉴 이름은 「회원탈퇴」다 [VERIFIED: `lib/l10n/app_ko.arb:349`, `"settingsWithdrawalLabel": "회원탈퇴"`]. 탈퇴는 5분 안에 다시 로그인한 토큰을 요구한다(`delete_user_account.ts:171-191`).

탈퇴는 호출 즉시 실행된다. 다만 Google 문서는 Firebase Authentication 데이터가 삭제 요청 뒤 라이브·백업 시스템에서 180일 안에 제거된다고 적는다 [CITED: firebase.google.com/support/privacy]. 삭제 안내의 「30일 이내」 같은 상한 표현은 「서비스에서의 삭제」와 「백업에서의 완전 제거」를 나눠 써야 한다(Phase 6 연구에서 확정).

### H. 리전·보존 기간 확인 결과

| 대상 | 값 | 근거 종류 | 근거 |
|------|----|-----------|------|
| Cloud Functions 리전 | `asia-northeast3` | 코드 | [VERIFIED: `functions/src/shared/region.ts:2`, `export const REGION = "asia-northeast3" as const;`] |
| Firestore 위치 | `asia-northeast3` | dev 설정 기록(문서)과 코드 주석. **CLI 미확인** | `docs/kit-fork.md:411`, `functions/src/running_pencil/region/on_course_written.ts:23` |
| Storage 기본 버킷 위치 | 「미확인」 | — | 저장소에 기록 없음. 버킷 이름만 `firebase_options_dev.dart:57`에 있음 |
| OSRM 라우터 VM zone | `asia-northeast3-a` | 배포 스크립트 기본값과 운영 문서. **CLI 미확인** | `infra/router/deploy.sh:43`, `infra/router/RUNBOOK.md:68` |
| Trigger Email 확장 | 확장의 처리 함수가 `us-central1`로 적혀 있음. dev에서 설치됐는지는 「미확인」 | 문서 | `docs/guide.md:2188` |
| Firebase Authentication 처리 위치 | 미국 데이터센터에서만 운영 | 공식 문서 | [CITED: firebase.google.com/support/privacy — "The Firebase Authentication service is run only from US data centers."] |
| Analytics·Crashlytics·FCM·Remote Config·App Check 처리 위치 | Google이 시설을 둔 곳 어디서나 처리될 수 있음(위치 선택 불가로 읽힘) | 공식 문서 | [CITED: 같은 페이지] |
| Crashlytics 보존 기간 | 크래시 트레이스와 식별자 90일 | 공식 문서 | [CITED: 같은 페이지] |
| Firebase Auth 보존 | 로그 IP는 몇 주, 그 밖은 삭제 요청까지. 삭제 뒤 180일 안에 라이브·백업에서 제거 | 공식 문서 | [CITED: 같은 페이지] |
| FCM·Remote Config | Firebase installation ID를 삭제 API 호출까지 보관, 이후 180일 안에 제거 | 공식 문서 | [CITED: 같은 페이지] |
| App Check | 토큰 TTL 최대 7일, 재전송 방지 토큰 최대 30일 | 공식 문서 | [CITED: 같은 페이지] |
| Google Analytics 보존 기간 | 「미확인」. 선택지는 2개월 또는 14개월이고 콘솔 설정값이다. 연령·성별·관심사는 항상 2개월 | 공식 문서(선택지만) | [CITED: support.google.com/analytics/answer/7667196]. 기본값은 이 페이지에 없다([ASSUMED]: 2개월) |
| Firestore 백업·PITR, Storage 소프트 삭제, Cloud Logging 보존 | 「미확인」 | — | CLI 조회 필요 |
| 익명 계정 자동 정리 | dev에서 꺼져 있음(MVP 내내 끔) | dev 설정 기록(문서) | `docs/kit-fork.md:445`, `:460` |

익명 계정 자동 정리가 꺼져 있으므로 익명 Auth 계정과 그 계정의 `users/{uid}.termsAccepted`는 기한 없이 남는다. `firestore.rules:41-42` 주석(「익명 계정은 30일 뒤 Auth만 지워져」)은 자동 정리를 켠 경우의 설명이고 dev 설정과 다르다. 익명 사용자에게 탈퇴 메뉴가 보이는지는 확인하지 못했다(「미확인」). 처리방침의 보유 기간 항목에 영향을 주므로 결정 목록에 넘긴다(아래 N3).

prod·stg는 아직 없다. `lib/core/firebase/firebase_options_prod.dart`와 `_stg.dart`는 `UnsupportedError`를 던지는 placeholder이고 [VERIFIED: 두 파일 `:2`, `:12`], `.firebaserc`에는 `default`와 `dev` 둘 다 `running-pencil-dev`만 있다 [VERIFIED: `.firebaserc`].

### Facebook SDK 자동 이벤트 (Research flag)

- Meta 공식 문서는 Android SDK가 통합되면 자동 이벤트 로깅이 기본으로 켜지고, 수집되는 핵심 이벤트가 App Install, App Launch, Purchase 셋이라고 적는다 [CITED: developers.facebook.com/docs/app-events/getting-started-app-events-android].
- 끄는 방법은 `AndroidManifest.xml`의 `<application>` 안에 `com.facebook.sdk.AutoLogAppEventsEnabled`를 `false`로 두는 것이고, 광고 ID 수집은 `com.facebook.sdk.AdvertiserIDCollectionEnabled`로 끈다 [CITED: 같은 페이지].
- 앱 저장소에는 이 설정이 없다. Facebook 관련 `meta-data`는 `com.facebook.sdk.ApplicationId`와 `com.facebook.sdk.ClientToken` 둘뿐이고 [VERIFIED: `android/app/src/main/AndroidManifest.xml:50-57`], `AutoLogAppEvents`·`AdvertiserIDCollection`·`AutoInitEnabled`·`FacebookAutoLog` 문자열은 `android/app/src`, `ios/Runner`, `lib`, `packages` 어디에도 없다 [VERIFIED: grep 0건].
- 확인하지 못한 것: `flutter_facebook_auth` 플러그인이 병합하는 매니페스트에 이 설정이 있는지, iOS 기본 동작, 실제 전송 여부. 데이터 목록에는 「자동 이벤트 전송 가능성 있음 — 앱에서 끄는 설정 없음(확인), 실제 전송 여부 미확인」으로 적는다.
- 처리방침에 Meta로의 전송을 적을지, 앱에서 끌지는 앱 쪽 결정이다(아래 N1).

### 데이터 목록에 「확인할 것」으로 넘길 항목

| 미확인 칸 | 확인하는 사람 | 확인 방법 | 영향 |
|-----------|---------------|-----------|------|
| Firestore 위치, PITR, 백업 일정 | Claude(사용자 재로그인 뒤) | 아래 Code Examples의 `gcloud firestore …` | 저장 위치, 삭제 상한 |
| Firestore TTL 정책(`fcmTokens.expireAt`, `mail`, `rate_limits`) | Claude(재로그인 뒤) | `gcloud firestore fields ttls list` | 보유 기간 |
| Storage 버킷 위치, 소프트 삭제 기간 | Claude(재로그인 뒤) | `gcloud storage buckets list` | 저장 위치, 삭제 상한 |
| 라우터 VM zone | Claude(재로그인 뒤) | `gcloud compute instances list` | 저장 위치 |
| 배포된 함수 리전, Trigger Email 확장 설치 여부 | Claude(재로그인 뒤) | `gcloud functions list`, `firebase ext:list` | 수탁자, 국외 이전 |
| Cloud Logging 보존 기간 | Claude(재로그인 뒤) | `gcloud logging buckets list` | 보유 기간 |
| Analytics 데이터 보관 설정 | 사용자 | Google Analytics > 관리 > 데이터 설정 > 데이터 보관 | Phase 6 절대 표현, Phase 7 |
| 제공자별 동의항목 필수/선택 | 사용자 | 카카오·네이버·LINE·Meta·Google 콘솔 | PRIV-10 |
| 네이버 지도 SDK가 보내는 항목 | 사용자·약관 확인(U8) | 네이버 지도 이용약관, SDK 문서 | TERM-02, 처리방침 |
| Facebook SDK 실제 전송 | 사용자(앱) | Meta Events Manager, 병합 매니페스트 | 처리방침 |
| 마케팅 푸시 발송 여부 | 사용자(앱) | 앱 계획 | 처리 목적 |
| 익명 사용자의 탈퇴 경로 | 사용자(앱) | 앱 화면 | 보유 기간 |

## 결정 목록 근거 (BASE-04)

막는 단계는 `ROADMAP.md` External Gates 표를 따랐다(D-14) [VERIFIED: `.planning/ROADMAP.md:201-216`].

| # | 질문 | 이 조사가 찾은 근거 | 막는 단계 | 결정 주체 |
|---|------|--------------------|-----------|-----------|
| U2 | 위치정보법 분류(신고 vs 등록) | 앱은 기기 GPS를 직접 받아 `runs.path`로 저장한다(근거표 C). 분류는 법률 판단 | Phase 8 위치약관 범위, ACPT-02 | 법률 확인 |
| U3 | 소상공인·1인 창조기업 해당 여부 | 코드 근거 없음(사업자 사실) | Phase 7 보호책임자 | 법률 확인 |
| U5 | Email/Password 가입 노출 여부 | 아래 「U5 근거」 | Phase 7 | 사용자(앱) |
| U6 | 탈퇴 후 공개 코스 유지, 비공개 코스 처리 | 아래 「U6 근거」 | Phase 6, 8 | 사용자(앱) |
| U7 | 만 14세 미만 가입 정책 | 앱에 나이 확인 단계는 찾지 못했다(약관 동의 키는 `service`·`privacy`·`marketing`뿐, `firestore.rules:54-64`). 나이 입력 화면 유무는 「미확인」 | Phase 7, 8 | 사용자·법률 확인 |
| U8 | 네이버 지도 이용약관 고지 의무 | 앱 임시 문구가 「네이버 지도 SDK 이용 정보가 네이버클라우드에 제공됩니다(네이버 지도 이용약관 §7⑤)」라고 적는다 [VERIFIED: `lib/l10n/app_ko.arb:197`]. 약관 원문은 확인하지 않음 | Phase 8 | 사용자·약관 확인 |
| U9 | Meta 비즈니스 인증 필요 여부 | 앱이 요청하는 권한은 `['email', 'public_profile']`뿐(근거표 B) | Phase 10 | 사용자(콘솔 확인) |
| U11 | 사업자 값과 영문 법인명 | 코드 근거 없음. 사실값이라 기본값 없음(D-12) | Phase 5, 8, 9 | 사용자 |
| U12 | 지원 주소와 메일 서비스 | **결정됨** — Google Workspace, `support@runningpencil.com`, 지원 주소로 답장(D-10·D-11·D-19). `slimpumpkin.com`의 MX가 Google 값이고 SPF가 `include:_spf.google.com`임을 `dig`로 확인 [VERIFIED: `dig`, 2026-11-14] | Phase 5 | 사용자 |
| U13 | Google 브랜드 검증 신청 여부 | 코드 근거 없음 | Phase 10 | 사용자 |
| 신규 | prod(그리고 stg)를 dev와 같은 리전으로 만드는지 | prod·stg는 placeholder(근거표 H). Functions 리전은 코드 상수라 따라가지만 Firestore·Storage 위치는 프로젝트를 만들 때 고른다 | Phase 7 커밋 전 | 사용자(앱) |

### U5 근거 — Email/Password가 화면에 드러나 있다

- 로그인 화면이 「이메일로 계속」 버튼(`EmailAuthCta`)과 회원가입 링크(`AppRoutes.signup`)를 조건 없이 그린다 [VERIFIED: `lib/features/auth/presentation/login_screen.dart:207`, `:224`].
- 저장소가 `signInWithEmailAndPassword`와 `createUserWithEmailAndPassword`를 부른다 [VERIFIED: `lib/features/auth/data/auth_repository.dart:305`, `:368`].
- dev Firebase 설정 기록에 「로그인 수단 (이메일 · 익명) — 기본대로 (이메일·익명 켜짐)」이 있다 [VERIFIED: `docs/kit-fork.md:412`].
- `enabledAuthProviders`는 소셜 6개만 고르는 설정이고 `email`은 이 목록에 없다(`lib/core/config/app_config.dart:314`). 이 설정으로는 이메일 로그인을 끌 수 없다.
- 앱의 `.planning/PROJECT.md`와 `REQUIREMENTS.md`에는 이메일 로그인을 감춘다는 결정이 없다 [VERIFIED: grep 0건].

권장안 문구의 재료: 지금 코드대로면 처리방침에 「이메일·비밀번호(Firebase Authentication이 보관)」와 인증 메일 발송을 적어야 하고, 네이버 검수의 「별도 비밀번호 요구 금지」 항목과 부딪칠 수 있다. 기본 동작(D-12)은 「코드에 있는 대로 적는다」가 보수적인 쪽이다.

### U6 근거 — 비공개 코스도 탈퇴 뒤에 남는다

- 앱의 결정: 「**courses 는 남김**(공개 자산, `creatorId` 만 남음)」 [VERIFIED: 앱 `.planning/phases/02-foundation-kit-fork/02-CONTEXT.md:66`]. SUMMARY가 「D-28」이라고 부른 근거가 이 줄이다(CONTEXT canonical_refs의 미해결 항목 해소).
- 정리 함수 주석: 「남기는 것: 공개 코스 자산(D-28 — `creatorId` 만 남는다)」 [VERIFIED: `functions/src/running_pencil/cleanup_user_data.ts:20`].
- 실제 코드: `cleanupUserData`는 `runs`와 `users/{uid}/badges`만 지운다. `functions/src` 전체에서 `courses`를 다루는 코드는 지역 채움 트리거(`region/on_course_written.ts`)뿐이고 삭제는 없다 [VERIFIED: grep]. 앱 쪽에서도 탈퇴는 `deleteUserAccount` 호출 하나뿐이고(`lib/features/settings/data/settings_repository.dart:104`), 그 파일에는 코스·기록·뱃지를 다루는 코드가 없다. `lib` 전체에서 `creatorId`로 코스를 찾는 쿼리는 「내 코스 목록」 하나(`lib/features/courses/data/course_repository.dart:105`)이고 삭제는 코스 한 건씩 지우는 메뉴(`course_repository.dart:327`)뿐이다 [VERIFIED: grep `creatorId`·`deleteUserAccount`, 자르지 않음].
- 따라서 탈퇴 뒤에는 공개 코스뿐 아니라 **비공개 코스도 남는다.** 비공개 코스에는 경로(`polyline`, `waypoints`, `sketchPolyline`), 출발점(`startPoint`), 지역(`region`), `creatorId`가 있다. 보안 규칙상 비공개 코스는 만든 사람만 읽을 수 있으므로(`firestore.rules:320-321`) 탈퇴 뒤에는 어떤 사용자도 읽지 못하고 관리자 권한으로만 보이는 고아 데이터가 된다.
- 사용자가 탈퇴 전에 코스를 직접 지울 수는 있다(`lib/features/courses/data/course_repository.dart:327`, 규칙 `firestore.rules:332`).

결정 목록의 U6는 두 질문으로 나눈다. (가) 공개 코스를 탈퇴 뒤에도 남기는 방침을 그대로 갈지. (나) 비공개 코스를 탈퇴 때 지우도록 앱을 고칠지, 고치지 않는다면 삭제 안내에 「비공개 코스도 남는다」고 적을지. 기본 동작(D-12)은 「코드대로 적는다 — 공개·비공개 코스가 모두 남는다고 안내한다」이다. 앱이 고쳐지면 D-09의 재확인 규칙으로 목록을 고친다.

### 조사에서 새로 나온 확인 항목

D-12는 결정 목록의 대상을 정해 두었다. 아래는 그 목록에 없지만 처리방침·삭제 안내의 문장을 바꾸는 사실이다. 계획자는 결정 목록 끝에 「조사에서 새로 나온 항목」 구간으로 넣고, 대상 목록을 넓힐지는 사용자에게 확인한다(아래 Open Questions 1).

| # | 사실 | 근거 | 영향 |
|---|------|------|------|
| N1 | Facebook SDK 자동 이벤트를 끄는 설정이 앱에 없다 | 위 「Facebook SDK 자동 이벤트」 | Phase 7: Meta로의 전송을 적을지, 앱에서 끌지 |
| N2 | Firebase Authentication은 미국에서만 운영된다 | 근거표 H | Phase 7: 국외 이전은 prod 리전과 무관하게 필요. 결정이 아니라 사실 |
| N3 | 익명 계정 자동 정리가 꺼져 있어 익명 계정과 약관 동의 기록이 기한 없이 남는다 | 근거표 H | Phase 7: 익명 사용자의 보유 기간·삭제 방법 |
| N4 | 마케팅 수신 동의를 받지만 마케팅 발송 기능은 확인되지 않았다 | 근거표 A | Phase 7: 처리 목적에 마케팅을 넣을지 |
| N5 | Analytics·Crashlytics에 uid를 붙이고 수집을 끄는 스위치가 앱에 없다 | 근거표 E | Phase 7 PRIV-08의 「거부 방법」 문장 |
| N6 | 메일 발송 모드가 `kit`이면 SMTP 발송 서비스가 수탁자로 추가된다 | 근거표 F | Phase 7: prod 설정 확인(「prod 리전」 항목과 함께) |
| N7 | 앱 안에 공개 코스 신고·차단 기능이 없다(범위 밖) | 앱 `.planning/PROJECT.md:56` | Phase 5 SUP-03·Phase 8 TERM-01: 신고 경로는 지원 이메일뿐이라고 적는다. 앱 심사(사용자 생성 콘텐츠 요건)는 앱 쪽 일 |

## 사용자 작업 절차서 근거 (BASE-04, D-13)

### 현재 DNS (2026-11-14 `dig`)

| 호스트 | 유형 | 현재 값 | 비고 |
|--------|------|---------|------|
| `@` | NS | 가비아 네임서버 3개 | 유지 |
| `@` | A ×4 | GitHub Pages `185.199.108.153`~`185.199.111.153` | 유지 |
| `@` | AAAA, MX, TXT, CAA | 없음 | MX·TXT를 새로 추가 |
| `www` | CNAME | `slimpumpkin.github.io` | 유지 |
| 앱 경로 라우터용 하위 도메인 | A | 있음(값과 호스트 이름은 이 문서에 적지 않음) | **유지. 기존 연구에 없던 레코드.** 호스트 이름은 앱 저장소 `infra/router/RUNBOOK.md:70`에 있다 |
| `_github-pages-challenge-SlimPumpkin` | TXT | 있음(값 생략) | **이미 있음.** 기존 연구는 「추가 권장」으로 적었다 |
| `_dmarc`, `google._domainkey` | TXT | 없음 | DKIM은 2차 방문 때 추가 |

[VERIFIED: `dig +short`, 2026-11-14]. `.planning/research/STACK.md:199`의 「MX 없음. TXT 없음. … `www` CNAME」은 루트 호스트만 본 결과라 하위 도메인 레코드 둘을 놓쳤다.

절차서에 미치는 영향 세 가지.
1. 「보존할 기존 레코드」는 A 4개, `www` CNAME에 더해 라우터용 A 1개, `_github-pages-challenge-SlimPumpkin` TXT 1개다. 절차서 첫 단계에 「가비아 DNS 관리 화면의 현재 레코드 전체를 캡처해 둔다」를 넣는다. 캡처는 저장소에 커밋하지 않는다.
2. GitHub Pages 인증 TXT는 「추가」가 아니라 「GitHub 조직 설정 > Pages에서 `runningpencil.com`이 인증됨으로 보이는지 확인」으로 바꾼다. 인증 상태 자체는 이 조사에서 확인하지 못했다.
3. D-13의 「기존 A 4개와 `www` CNAME은 그대로 둔다」는 문장에 위 두 레코드를 더한다. 공개 저장소이므로 절차서에는 라우터 호스트 이름을 적지 않고 「앱 라우터용 A 레코드(가비아 화면에서 확인)」라고만 적는다.

업무 메일 도메인 `slimpumpkin.com`의 현재 상태: MX는 Google 레거시 값 5개(`aspmx.l.google.com` 계열), SPF는 `v=spf1 include:_spf.google.com ~all`, DMARC는 `v=DMARC1; p=none;` [VERIFIED: `dig`, 2026-11-14]. Workspace 사용이 DNS로 확인된다.

### Google Workspace: 사용자 별칭 도메인

| 확인 사항 | 결과 | 출처 |
|-----------|------|------|
| 비용 | 사용자 별칭 도메인은 「No extra cost per user or group」, 최대 20개. 보조 도메인은 사용자 계정마다 과금(별칭은 제외) | [CITED: knowledge.workspace.google.com/admin/domains/add-a-user-alias-domain-or-secondary-domain] |
| 추가 경로 | 관리 콘솔 > Account > Domains > Manage domains > 「Add a domain」 > 도메인 이름과 유형 선택 > 「Add domain & start verification」 | [CITED: 같은 페이지] |
| 주소가 생기는 방식 | 「Each user gets an email address at both your primary domain and the user alias domain.」「Each mailing group also gets an email address at the user alias domain.」 | [CITED: 같은 페이지] |
| Gmail 켜기 | 인증 뒤 Manage Domains에서 새 도메인의 「Activate Gmail」을 누르고 안내를 따른다. 48~72시간 안에 시험 메일이 오지 않으면 도메인 인증과 MX를 확인 | [CITED: 같은 페이지] |
| MX 값 | 호스트 `@`(또는 빈칸), 우선순위 `1`, 값 `smtp.google.com`. 등록기관이 원하면 끝에 마침표. 다른 MX는 지운다. 2023년 이전의 `aspmx` 값도 계속 지원. 반영 최대 72시간 | [CITED: knowledge.workspace.google.com/admin/domains/set-up-mx-records-for-google-workspace] |
| SPF 값 | `v=spf1 include:_spf.google.com ~all`, 호스트 `@`. 반영 최대 48시간 | [CITED: knowledge.workspace.google.com/admin/security/set-up-spf] |
| DKIM | Apps > Google Workspace > Gmail > 「Authenticate email」 > 「Selected domain」에서 도메인 선택 > 「Generate New Record」. 유형 TXT, 호스트 `google._domainkey`. 도메인마다 따로 만든다(「You must get a unique DKIM key from the Admin Console for each domain」). **Gmail을 켠 뒤 24~72시간이 지나야 키를 받을 수 있다.** DNS에 넣은 뒤 「Start authentication」, 적용 최대 48시간. 확인은 다른 Gmail·Workspace 사용자에게 보낸 메일 헤더의 `DKIM=pass` | [CITED: knowledge.workspace.google.com/admin/security/set-up-dkim] |
| 별칭 주소로 보내기 | Gmail > 설정 > Accounts(and Import) > 「Send mail as」에 주소 추가, 「Treat as an alias」 체크, 확인 절차. 보낼 때 From에서 고른다 | [CITED: 별칭 도메인 페이지] |
| 사용자 이메일 별칭 | 관리 콘솔 > Directory > Users > 사용자 > 「Add Alternate Emails」. 사용자당 30개, 추가 비용 없음, 최대 24시간. 「User alias domains don't show in the Domain menu.」「Only one user can use an email alias.」 | [CITED: knowledge.workspace.google.com/admin/users/add-or-delete-an-alternate-email-address-email-alias] |

**별칭 도메인의 부수 효과:** `runningpencil.com`을 사용자 별칭 도메인으로 붙이면 슬림펌킨의 모든 사용자와 그룹이 `<이름>@runningpencil.com` 주소를 함께 받는다. 문서가 「User alias domains don't show in the Domain menu」라고 적으므로 `support@runningpencil.com`만 따로 만들 수는 없고 `support@slimpumpkin.com`이 있어야 그 짝으로 생기는 것으로 읽힌다 [ASSUMED: 별칭 페이지 문장에서 추론, 화면에서 확인하지 않음]. 절차서에는 모든 사용자가 `@runningpencil.com` 주소를 받는다는 점(문서 명시)을 적고, 단독 생성 가능 여부는 사용자가 화면에서 확인하는 단계로 둔다.

**`support@`를 무엇으로 만들지 (D-10의 확인 요청):**

| 방식 | 받기 | 보내기 | 주의 |
|------|------|--------|------|
| 사용자 이메일 별칭 (운영자 계정에 `support` 별칭 추가) — **1순위** | 운영자 받은편지함으로 온다. 외부 발신을 따로 허용할 필요가 없다 [ASSUMED] | Gmail 「Send mail as」에 `support@runningpencil.com` 추가 | 사용자 별칭이 별칭 도메인에도 생기는지는 문서가 「each user gets an email address」라고만 적어 별칭까지 포함하는지 분명하지 않다 [ASSUMED]. 수신 시험으로 확인한다 |
| Google 그룹 (`support@slimpumpkin.com`) — 2순위 | 그룹이 별칭 도메인 주소를 받는 것은 문서에 명시 | 그룹 주소로 보내려면 「Send mail as」 확인 메일을 받을 수 있어야 한다 | 그룹은 기본 설정에서 조직 밖 발신자의 메일을 받지 않을 수 있다 [ASSUMED]. 「웹의 모든 사용자」 게시 허용을 켜야 외부 4곳 시험을 통과한다 |

계획자는 절차서에 1순위를 본문으로 쓰고, 수신 시험이 실패하면 2순위로 넘어가는 분기를 둔다. `[ASSUMED]` 두 건은 사용자가 화면에서 확인하는 단계로 풀어 쓴다.

**DNS 방문이 두 번이다.** DKIM 키는 Gmail을 켠 뒤 24~72시간이 지나야 받을 수 있으므로 절차는 아래 순서가 된다.

| 순서 | 어디서 | 무엇을 | 값 |
|------|--------|--------|----|
| 0 | 가비아 | 현재 레코드 전체 캡처, `dig` 변경 전 기록 | — |
| 1 | Workspace 관리 콘솔 | 사용자 별칭 도메인 추가, 인증 시작 | 인증 TXT는 「콘솔에서 복사」 |
| 2 | 가비아 (1차 방문) | 인증 TXT, MX, SPF, Search Console TXT 추가 | 인증 TXT·Search Console TXT는 「콘솔에서 복사」. MX·SPF는 콘솔 안내값을 복사하되 위 표의 기대값과 같은지 대조 |
| 3 | Workspace 관리 콘솔 | 도메인 인증 완료, 「Activate Gmail」 | — |
| 4 | Workspace 관리 콘솔 | `support` 별칭(또는 그룹) 만들기 | — |
| 5 | 외부 4곳 | Gmail·네이버·iCloud·Outlook에서 `support@runningpencil.com`으로 시험 메일, 도착 기록 | 이메일 게이트(Phase 5 성공 기준 1) |
| 6 | Gmail | 「Send mail as」에 `support@runningpencil.com` 추가 | — |
| 7 | Workspace 관리 콘솔 (3단계에서 24~72시간 뒤) | DKIM 키 생성 | 공개키는 「콘솔에서 복사」 |
| 8 | 가비아 (2차 방문) | `google._domainkey` TXT 추가 | — |
| 9 | Workspace 관리 콘솔 | 「Start authentication」, 다른 Gmail 사용자에게 보낸 메일 헤더에서 `DKIM=pass` 확인 | SUP-05(Phase 10)의 전제 |
| 10 | Search Console | 도메인 속성 소유권 확인 | SITE-03 |

이메일 게이트는 5단계에서 열린다. DKIM(7~9단계)을 기다리지 않아도 된다. DKIM은 지원 주소로 답장하는 것(D-11)과 Apple 릴레이(Phase 10)에 필요하다.

Workspace 도메인 인증 TXT와 Search Console TXT는 둘 다 `google-site-verification=…` 꼴이고 루트 호스트의 서로 다른 TXT 레코드로 함께 둘 수 있다. 두 값이 같은지 다른지는 콘솔이 정한다. 각각 콘솔에서 복사한다. SPF TXT는 하나만 둔다(ROADMAP Phase 5 성공 기준 2).

DMARC(`_dmarc` TXT)는 D-13의 목록에 없다. `slimpumpkin.com`에는 `p=none`으로 있다. `runningpencil.com`에도 넣을지는 계획자가 「선택 항목」으로 적을 수 있다. 필요성은 확인하지 않았다 [ASSUMED].

### 가비아 DNS 입력 화면

- 경로: MY가비아 > 서비스 관리 > DNS관리툴 > 설정 > 「+레코드 추가」 [CITED: 가비아 FAQ, WebSearch 발췌. 원문 페이지는 직접 열지 못함].
- MX 값은 마침표로 끝나야 한다는 안내가 가비아 FAQ에 있다 [CITED: 같은 발췌]. Google 문서도 등록기관이 원하면 `smtp.google.com.`처럼 쓰라고 한다.
- 루트 호스트를 `@`로 쓰는지 빈칸으로 두는지는 확인하지 못했다. 절차서에는 「호스트 칸에 `@`를 넣는다. 오류가 나면 가비아 화면의 안내를 따른다」고 쓰고, 사용자가 화면에서 확인하게 둔다.
- TXT 값의 길이 제한(2048비트 DKIM 키)은 확인하지 못했다. Google 문서는 호스트가 2048비트를 지원하지 않으면 1024비트를 고르라고 한다 [CITED: DKIM 페이지]. 절차서의 8단계에 「저장이 거부되면 1024비트로 다시 생성」 분기를 둔다.

### 변경 전후 `dig` 기대 결과

| 명령 | 변경 전(2026-11-14 확인) | 변경 후 기대 |
|------|--------------------------|--------------|
| `dig +short runningpencil.com A` | GitHub Pages 4개 | 그대로 |
| `dig +short www.runningpencil.com CNAME` | `slimpumpkin.github.io.` | 그대로 |
| `dig +short <라우터 호스트> A` | 있음 | 그대로 |
| `dig +short _github-pages-challenge-SlimPumpkin.runningpencil.com TXT` | 있음 | 그대로 |
| `dig +short runningpencil.com MX` | 없음 | `1 smtp.google.com.` |
| `dig +short runningpencil.com TXT` | 없음 | SPF 1개 + `google-site-verification=…` 1~2개 |
| `dig +short google._domainkey.runningpencil.com TXT` | 없음 | `v=DKIM1; k=rsa; p=…` (2차 방문 뒤) |

끝난 뒤 사이트가 HTTPS로 열리는지도 확인한다(`curl -sI https://runningpencil.com/ | head -1`).

## 이름 표 근거 (BASE-01)

| 항목 | 값 | 지금 채우는가 | 들어갈 곳 | 근거 |
|------|----|---------------|-----------|------|
| 한글 서비스명 | 러닝펜슬 | 예 | 사이트 전체, 스토어·동의 화면 한국어 표시명 | D-18, D-20. 앱의 한국어 앱 이름도 같다 [VERIFIED: 앱 `lib/l10n/app_ko.arb:4`, `"appTitle": "러닝펜슬"`] |
| 영문 서비스명 | RunningPencil | 예 | `/en/…`, 스토어·동의 화면 영어 표시명 | D-18, D-20, `PROJECT.md:107`. 앱의 영어 앱 이름도 같다 [VERIFIED: 앱 `lib/l10n/app_en.arb:4`, `"appTitle": "RunningPencil"`] |
| 운영사 표기(현행) | 슬림펌킨 | 예 | 저작권 표기, 푸터 운영 안내 | D-18 |
| 도메인 | `runningpencil.com` | 예 | — | D-18 |
| 지원 이메일 | `support@runningpencil.com` | `.planning/` 문서에만 | Phase 5 `_data` (이메일 게이트 뒤) | D-19 |
| 사업자등록증 그대로의 상호 | (빈칸) | 아니요 | Phase 5 `_data` | D-18, U11 |
| 대표자 | (빈칸) | 아니요 | Phase 5 `_data` | D-18, U11 |
| 사업자등록번호 | (빈칸) | 아니요 | Phase 5 `_data` | D-18, U11 |
| 주소 | (빈칸) | 아니요 | Phase 5 `_data` | D-18, U11 |
| 영문 법인명 | (빈칸) | 아니요 | Phase 5 `_data`, Phase 9 | D-18, U11 |
| 스토어 개발자 이름 | (빈칸) | 아니요 | Phase 6 삭제 안내(DEL-02) | D-18 |
| 전화번호 | (빈칸, 이번에는 공개하지 않음) | 아니요 | Phase 5 `_data` (칸만) | U1, BIZ-03 |

Phase 5의 데이터 파일 경로와 키는 아직 없다. 기존 연구의 스케치는 `_data/company.yml`에 `biz_name_ko`, `ceo_ko`, `biz_no`, `address_ko`, `support_email`을 썼다 [CITED: `.planning/research/ARCHITECTURE.md:143-148`, `:196`]. 이 이름들은 실행한 적 없는 스케치이므로 이름 표의 「들어갈 곳」 열에는 「`_data/company.yml` (Phase 5에서 확정)」이라고 적고 키 이름을 고정하지 않는다.

주의: 앱의 dev 빌드 표시 이름은 `RunningPencil Dev`(처음 입력값은 `Running Pencil Dev`였고 나중에 고침)이고, 번들 식별자의 조직 부분은 `com.runningpencil`이다 [VERIFIED: 앱 `docs/kit-fork.md:404-405`]. 앱에는 일본어 앱 이름(`ランニングペンシル`, `lib/l10n/app_ja.arb:4`)도 있다. 사이트는 일본어판을 내지 않으므로(REQUIREMENTS Out of Scope) 이름 표에는 참고 행으로만 둔다. 스토어 등록명은 이름 표의 값(「러닝펜슬」/「RunningPencil」)과 같아야 한다(Pitfall 3). 이름 표에 「앱 쪽 표시명과 일치 확인: 앱 `lib/l10n/app_*.arb`의 `appTitle`」 행을 두면 Phase 10에서 대조할 수 있다.

## URL 대장 근거 (BASE-02)

| URL | 언어 | 현재 상태 | 만드는 단계 | 등록할 콘솔 필드(범주, D-17) |
|-----|------|-----------|-------------|------------------------------|
| `https://runningpencil.com/` | ko | 라이브 | 기존 | Google OAuth 동의 화면 — 홈페이지 / Google Play — 웹사이트 / App Store Connect — Marketing URL(선택) / 카카오·네이버 — 서비스 URL·사이트 도메인 |
| `https://runningpencil.com/privacy-policy/` | ko | 라이브(200 확인) | 기존, Phase 7 재작성 | Google OAuth 동의 화면 — 개인정보처리방침 링크(**이 문자열 그대로**) / Google Play·App Store Connect — 개인정보처리방침 URL / Facebook·LINE — 개인정보처리방침 URL / 카카오·네이버(요구 시) |
| `https://runningpencil.com/terms/` | ko | 라이브 | 기존, Phase 8 재작성 | Google OAuth 동의 화면 — 서비스 약관 링크 / Facebook·LINE — 약관 URL / 카카오(요구 시) |
| `https://runningpencil.com/data-deletion/` | ko | 라이브 | 기존, Phase 6 재작성 | Google Play — 계정 삭제 URL / Facebook — Data Deletion Instructions URL(`#facebook`) |
| `https://runningpencil.com/support/` | ko | 없음 | Phase 5 | App Store Connect — Support URL |
| `https://runningpencil.com/location-terms/` | ko | 없음 | Phase 8 | (콘솔 등록 없음. 홈페이지 푸터 링크, LOC-01) |
| `https://runningpencil.com/en/` | en | 없음 | Phase 9 | 영어 심사용 홈페이지(콘솔별 확정은 Phase 10) |
| `https://runningpencil.com/en/privacy-policy/` | en | 없음 | Phase 9 | Facebook·LINE·App Store 등 영어 URL을 받는 칸(Phase 10 확정) |
| `https://runningpencil.com/en/terms/` | en | 없음 | Phase 9 | 위와 같음 |
| `https://runningpencil.com/en/data-deletion/` | en | 없음 | Phase 9 | Facebook — Data Deletion Instructions URL 후보(Phase 10 확정) |
| `https://runningpencil.com/en/support/` | en | 없음 | Phase 9 | App Store Connect — Support URL(영어 현지화) 후보 |
| `https://runningpencil.com/en/location-terms/` | en | 예약(v2 LOC-06) | — | — |

콘솔 필드 범주는 `.planning/research/ARCHITECTURE.md:249-262`의 표를 다시 쓴 것이다 [CITED]. 그 표의 「출처」 열이 대부분 「미확인」이므로 대장에도 「범주 수준, 정확한 필드명은 Phase 10」이라고 머리에 적는다(D-17).

대장에 함께 둘 열: 「도메인만 등록하는 칸」(`runningpencil.com` — Google OAuth Authorized domains, Facebook App Domains, 카카오 Web 플랫폼 사이트 도메인) 한 행. 그리고 기존 3개 URL에 「경로 고정, 리디렉션 금지」 표시(ROADMAP Ground Rules).

## CLAUDE.md 갱신 근거 (BASE-05)

### 옛 규칙 문장 위치 (전수)

**루트 `CLAUDE.md`** [VERIFIED: 이 세션에서 `cat -n`으로 전체 확인]

| 행 | 지금 문장의 내용 | 처리 |
|----|------------------|------|
| 7 | 앱 설명에 포인트·코스북·굿즈 | D-05: PROJECT.md `What This Is`의 설명으로 교체 |
| 9 | 「빌드 시스템 없음」 | D-01: 현재 상태, 「Phase 2까지」 표시 |
| 20~22 | 「임시 게시본, `noindex`」 | D-01: 현재 상태, U14 표시(Phase 6·7·8에서 해제) |
| 24 | 「빌드 단계가 없어 공통 템플릿을 뽑을 수 없으니」 | 현재 상태, 「Phase 2에서 바뀜」 |
| 34~38 | `python3 -m http.server` | 현재 상태, 「Phase 2까지 유효」 |
| 44 | Tailwind CDN | 현재 상태, 「Phase 3까지」 |
| 58 | 연락처 이메일을 표시하지 않음 | D-01: 날짜 붙은 상태 문장 |
| 69 | 본문·`lang` 모두 `ko` | D-01: 날짜 붙은 상태 문장 |
| 71 | 영문명을 쓰지 않음 | D-01: 날짜 붙은 상태 문장 + 이름 표 경로 |

**`.planning/codebase/CONVENTIONS.md`** (생성 원본) [VERIFIED: `CONVENTIONS.md:140-147` Read]

| 행 | 지금 문장 | 처리 |
|----|-----------|------|
| 142 | `- <html lang="ko">, 본문은 한국어.` | 날짜 붙은 상태 문장 |
| 143 | 서비스 이름은 한글만, 영문명은 쓰지 않음 | 이름 표를 가리키는 문장 |
| 145 | 연락처 이메일·이메일 수집 폼을 넣지 않음 | 이메일 수집 폼 금지는 유지(REQUIREMENTS Out of Scope), 연락처 이메일은 상태 문장으로 분리 |
| 146 | 법적 페이지 3종은 `noindex`를 유지 | 상태 문장(U14) |
| 58, 83, 87 | Tailwind CDN, `robots noindex` 순서 설명 | 현재 상태 — D-01에 따라 유지 가능 |

**`.planning/codebase/TESTING.md`** [VERIFIED: `TESTING.md:64-65`, `:119-123` Read]

| 행 | 지금 문장 | 처리 |
|----|-----------|------|
| 65 | 영문 표기·이메일 주소가 새로 들어가지 않았는지, `noindex` 유지 | 새 방침의 점검 항목으로 교체 |
| 119~122 | 「금지 표기 확인 (영문 서비스명, 이메일 주소)」와 `grep -rnE "RunningPencil\|@[a-z0-9.-]*\.(com\|kr)" --include='*.html' . \| grep -v prepare/` | 영문명을 금지 대상에서 빼고, 「이메일 게이트 전에는 HTML·`_data`에 이메일 주소 없음」 검사로 교체 |

**`.claude/CLAUDE.md`** (생성본): 164, 165, 167, 168행이 `CONVENTIONS.md` 142, 143, 145, 146행의 사본이다 [VERIFIED: grep]. 이 파일의 conventions 블록은 `CONVENTIONS.md`에서 다시 만들어진다.

**그 밖의 원본 맵(생성기에 들어가지 않지만 계획 입력으로 읽힘)**

| 파일:행 | 내용 | 판단 |
|---------|------|------|
| `CONCERNS.md:56` | 「프로젝트 방침상 연락처 이메일을 의도적으로 표시하지 않음 (`CLAUDE.md`)」 | 방침으로 읽힘 — 고친다 |
| `CONCERNS.md:58`, `:123`, `:128` | 「임시 게시본」·`noindex`·「이메일·폼 모두 없음 (… 의도적 결정)」 | 123행은 방침으로 읽힘 — 고친다. 나머지는 현재 상태 |
| `INTEGRATIONS.md:68`, `ARCHITECTURE.md:163` | 이메일 수집 폼 없음 | 유지(폼 금지는 그대로) |
| `STACK.md:12,25,59,70`, `STRUCTURE.md:15-19,66`, `ARCHITECTURE.md:118` | `lang="ko"`, `http.server`, `noindex` | 현재 상태 — D-01에 따라 유지 가능. `STACK.md`는 생성본의 stack 블록으로 들어간다 |
| `README.md:3,6` | 「빌드 없음」, `http.server` | 현재 상태 — Phase 2에서 고침 |

### 앱 설명 문장의 근거 (D-05)

루트 `CLAUDE.md:7`의 앱 설명을 고칠 때 남길 기능과 뺄 기능의 앱 근거다. 경로는 앱 저장소 기준이다.

| 기능 | 출시 범위 | 근거 |
|------|-----------|------|
| 지도 위 코스를 걷거나 달려 완주하면 코스 모양 뱃지를 모음 | 예 — 남긴다 | 앱 `.planning/PROJECT.md:5`(「다른 사람이 그 코스를 따라 걷거나 달려 완주하면 코스 모양 뱃지를 수집」), `firestore.rules:269-281`, `:426-434`(뱃지 문서) |
| 직접 그린 코스를 저장하고 공개 | 예 — 남긴다 | `firestore.rules:319-333`(만들 때는 비공개, 공개는 한 방향 전환), `lib/l10n/app_ko.arb:197`(「「공개하기」 를 누르면 다른 사용자에게 공개됩니다. 공개한 코스는 고칠 수 없습니다.」) |
| 코스 만들기·달리기·뱃지는 로그인 계정에 저장, 익명은 둘러보기만 | 예 — 필요하면 남긴다 | 앱 `.planning/PROJECT.md:29`, `:79` |
| 포인트 적립, 포인트로 굿즈 교환 | 아니요 — 뺀다 | 앱 `.planning/REQUIREMENTS.md:149`(Out of Scope 표: 「현금·포인트 리워드」). 굿즈·배송을 다루는 코드와 컬렉션은 `firestore.rules`에 없다 |
| 지역 코스북 | 아니요 — 뺀다 | 앱 `.planning/REQUIREMENTS.md:121`(「**P2-05**: AI 뱃지 생성, 코스북·세트 뱃지, 반복·누적 뱃지」), 앱 `.planning/PROJECT.md:58`(Out of Scope: 「반복·누적·코스북 뱃지, 랭킹·좋아요·커뮤니티, 속도 색칠, SNS 공유 — Phase 2·3」) |

맞출 문장은 이 저장소 `.planning/PROJECT.md:5`의 「모바일 앱 러닝펜슬(지도 위 GPS 아트 코스를 걷거나 달려 완주하면 코스 모양 뱃지를 모으는 앱)」이다. 「직접 그린 코스를 올리고」는 위 근거로 남길 수 있다.

참고로 앱은 「모더레이션·신고·차단·스팸 방어」를 범위 밖으로 둔다(앱 `.planning/PROJECT.md:56`). 사이트가 안내할 수 있는 신고 경로는 지원 이메일뿐이다(SUP-03, TERM-01). 앱 안 신고 기능이 없다는 사실은 결정 목록의 「조사에서 새로 나온 항목」에 N7로 넣는다.

### `.claude/CLAUDE.md` 생성기 동작

`gsd-tools generate-claude-md`가 만든다. 동작은 `~/.claude/gsd-core/bin/lib/profile-output.cjs`에서 확인했다 [VERIFIED: 같은 파일 `:244-275`, `:337-415`, `:1100-1165`].

| 블록 마커 | 원본 | 옮기는 규칙 |
|-----------|------|-------------|
| `GSD:project` | `.planning/PROJECT.md` | 첫 `# ` 제목, `## What This Is` 본문, `## Core Value` 본문, `## Constraints` 본문 |
| `GSD:stack` | `.planning/codebase/STACK.md` | 제목 줄, 표 줄(`|`), 목록 줄(`- `, `* `)만 |
| `GSD:conventions` | `.planning/codebase/CONVENTIONS.md` | `# ` 아닌 제목 줄, 목록 줄, 표 줄만. **문단은 버린다** |
| `GSD:architecture` | `.planning/codebase/ARCHITECTURE.md` | 제목, 목록, 표, 코드 펜스 줄만 |
| `GSD:skills`, `GSD:workflow`, `GSD:profile` | 스킬 폴더, GSD 기본값 | — |

- 마커가 있는 파일에서는 블록의 시작 마커부터 끝 마커까지만 바꾸고 그 앞뒤 글은 그대로 둔다(`updateSection`). **마커 밖에 쓴 글은 재생성해도 남는다.**
- `--auto`를 주면 손으로 고친 블록은 건너뛴다. 주지 않으면 블록을 원본 기준으로 덮어쓴다. `--force`는 마커 없는 파일도 덮어쓴다.
- 마커가 하나도 없는 파일은 손으로 쓴 파일로 보고 건드리지 않는다. 루트 `CLAUDE.md`가 이 경우다. `config.json`의 `claude_md_path`가 `./.claude/CLAUDE.md`이므로 생성 대상도 루트가 아니다 [VERIFIED: `.planning/config.json`].

**계획에 주는 결론**

1. 「이번 마일스톤 방침」 구간은 `.claude/CLAUDE.md`에서 첫 마커(`<!-- GSD:project-start …`) **위**에 둔다. 재생성이 지우지 않는다. 루트 `CLAUDE.md`에는 문서 맨 앞에 같은 구간을 둔다. 두 파일이 함께 컨텍스트에 실리므로 표 내용이 같아야 한다.
2. 옛 문장은 원본(`CONVENTIONS.md` 142~146행)에서 고친다. conventions 블록은 목록·표 줄만 옮기므로, 고친 문장을 목록 항목으로 쓰면 생성본에 그대로 실린다.
3. `PROJECT.md`의 `## Constraints`는 이미 새 방침과 맞는다(한국어+영문, 사실값 추측 금지). project 블록에는 옛 규칙이 없다 [VERIFIED: `.claude/CLAUDE.md:1-21`].
4. 재생성은 `--auto` 없이 돌리고 `git diff .claude/CLAUDE.md`로 바뀐 줄이 conventions 블록의 해당 줄과 마커 밖 구간뿐인지 확인한다. 예상 밖 줄이 바뀌면 되돌리고, 원본과 생성본의 같은 줄을 손으로 고친다(생성기 규칙이 「목록 줄을 그대로 옮김」이므로 결과가 같다).

**이 조사에서 생성기를 사본으로 시험했다** [VERIFIED: 2026-11-14, 저장소 밖 임시 폴더의 사본에 `generate-claude-md --output <사본>` 실행. 저장소 파일은 바뀌지 않음].
- 지금 원본으로 다시 만든 결과가 현재 `.claude/CLAUDE.md`와 바이트 단위로 같다(`cmp` 일치). 즉 원본 맵과 생성본이 지금 어긋나 있지 않고, 재생성은 원본에서 고친 줄만 바꾼다.
- 사본 맨 위(첫 마커 앞)에 시험용 구간을 넣고 다시 만들었더니 그 구간이 그대로 남고 나머지는 원본과 같았다. 마커 밖 방침 구간은 재생성에 지워지지 않는다.
- 실행 결과의 `sections_generated`는 `project, stack, conventions, architecture, workflow`, `sections_fallback`은 `skills`였다.

실행자가 같은 시험을 하려면 `--output`으로 저장소 밖 사본을 가리킨다. `--output` 없이 돌리면 `.claude/CLAUDE.md`를 바로 고친다.

### 성공 기준 5의 검사 범위

저장소 전체를 검사하면 0건이 될 수 없다. `ROADMAP.md:49`, `PROJECT.md:103-107`, `REQUIREMENTS.md`, CONTEXT, 연구 문서, 이 문서가 옛 규칙을 이름으로 부르기 때문이다. 검사 범위를 아래로 고정한다.

- **검사 대상 파일:** `CLAUDE.md`, `.claude/CLAUDE.md`, `.planning/codebase/CONVENTIONS.md`, `.planning/codebase/TESTING.md`, `.planning/codebase/CONCERNS.md`
- **검사 대상이 아닌 곳:** `.planning/ROADMAP.md`, `PROJECT.md`, `REQUIREMENTS.md`, `STATE.md`, `.planning/phases/`, `.planning/research/`, `.planning/baseline/`

검사 대상 파일에서 「포인트」「굿즈」「코스북」이라는 낱말 자체는 0건이 될 수 없다. 방침 표가 「포인트·굿즈·코스북 제거」를 적기 때문이다(D-01). 그래서 낱말이 아니라 옛 문장의 꼴을 검사한다(아래 Code Examples).

## Common Pitfalls

### Pitfall 1: CLI 자격 증명이 만료된 채로 리전 칸을 채움
**What goes wrong:** D-06은 CLI가 로그인돼 있다고 전제하지만 지금은 두 CLI 모두 재인증을 요구한다. 실행자가 코드 주석(`asia-northeast3`)을 「CLI로 확인」이라고 적으면 근거가 거짓이 된다.
**Why it happens:** Google 계정의 재인증 주기. 비대화형 실행에서는 프롬프트가 뜨지 않는다.
**How to avoid:** 계획 첫머리에 사용자 작업(`gcloud auth login`, `firebase login --reauth`)을 두고, 조회 작업은 그 뒤에 둔다. 사용자가 로그인하지 않으면 해당 칸은 「근거: dev 설정 기록(문서), CLI 미확인」으로 두고 단계를 끝낼 수 있다(성공 기준 3은 「미확인」 표시를 허용한다).
**Warning signs:** 명령 출력에 `Reauthentication failed` 또는 `Your credentials are no longer valid`.

### Pitfall 2: 공개 저장소에 식별자·비밀이 딸려 들어감
**What goes wrong:** 근거를 옮기다가 앱 `RUNBOOK.md`의 고정 IP, 프로젝트 번호, 관리자 계정, 라우터 호스트 이름이나 CLI 출력의 앱 ID·계정 이메일을 기준 문서에 붙인다. 한 번 커밋하면 이력과 포크에 남는다.
**Why it happens:** CLI 기본 출력과 운영 문서에는 식별자가 섞여 있다.
**How to avoid:** CLI는 `--format`으로 이름과 위치만 뽑는다. 근거는 경로와 행 번호로만 적는다. 커밋 전에 아래 Security 검사 명령을 돌린다.
**Warning signs:** 문서에 IPv4 주소, 12자리 숫자, `@slimpumpkin.com`, `1:숫자:android:` 꼴이 보임.

### Pitfall 3: 앱의 「공개 코스만 남는다」는 문장을 그대로 옮김
**What goes wrong:** 앱 주석과 D-28을 믿고 데이터 목록에 「탈퇴 시 비공개 코스 삭제」 또는 「공개 코스만 유지」라고 적는다. 삭제 안내와 처리방침이 실제 동작과 달라진다.
**Why it happens:** 주석은 의도를 적고 코드는 `courses`를 아예 건드리지 않는다.
**How to avoid:** 근거표 G의 행을 그대로 옮긴다. U6을 두 질문으로 나눈다.
**Warning signs:** 데이터 목록의 `courses` 행에 `visibility`별 삭제 구분이 있음.

### Pitfall 4: 생성본을 다시 만들다가 무관한 줄이 바뀜
**What goes wrong:** `generate-claude-md`가 stack·architecture·workflow 블록까지 다시 써서, 원본 맵이 생성 뒤에 손으로 고쳐졌거나 GSD 버전이 달라졌으면 예상 밖 diff가 생긴다. 방침과 무관한 변경이 같은 커밋에 섞인다. 2026-11-14 시험에서는 재생성 결과가 현재 파일과 같았으므로 지금은 이 위험이 없다. 이 단계에서 `STACK.md`·`ARCHITECTURE.md`·`PROJECT.md`의 목록·표 줄을 함께 고치면 그 줄도 생성본에 반영된다는 점만 기억한다(D-21로 `PROJECT.md` Key Decisions를 고치는 것은 project 블록에 들어가지 않는다 — 블록은 `What This Is`·`Core Value`·`Constraints`만 옮긴다).
**Why it happens:** 생성기는 블록 전체를 원본에서 다시 요약한다.
**How to avoid:** 재생성 뒤 `git diff --stat .claude/CLAUDE.md`와 diff 본문을 확인한다. 바뀐 줄이 conventions 블록의 4줄 안팎과 마커 밖 구간뿐이어야 한다. 아니면 되돌리고 같은 줄을 손으로 고친다.
**Warning signs:** diff에 stack·architecture 블록 줄이 보임, `GSD:profile` 블록이 바뀜.

### Pitfall 5: 방침 표가 「지금 해도 되는 일」로 읽힘
**What goes wrong:** 방침 표에 「지원 이메일 공개」만 적으면 다음 세션이 이메일 게이트 전에 주소를 HTML에 넣는다.
**Why it happens:** 방침(결정)과 적용 시점(단계)이 한 낱말로 뭉개진다.
**How to avoid:** D-01대로 방침마다 「적용 단계」와 「현재 상태」 열을 둔다. 지원 이메일 행에는 「주소는 `.planning/baseline/NAMES.md`에만 있고 HTML·`_data`에는 이메일 게이트 뒤에 넣는다」를 적는다.
**Warning signs:** 방침 표에 열이 둘뿐임.

### Pitfall 6: DNS를 「한 번에」 끝낸다고 적음
**What goes wrong:** 절차서가 DKIM까지 1차 방문에 넣으면 사용자가 키를 만들 수 없어 막힌다. 기존 ROADMAP Phase 5 문장(「한 번에 추가합니다」)이 이 전제다.
**Why it happens:** Workspace는 Gmail을 켠 뒤 24~72시간이 지나야 DKIM 키를 준다.
**How to avoid:** 절차서를 두 번 방문으로 쓰고, D-21로 ROADMAP 문장을 고칠 때 「한 번에」를 「1차(인증·MX·SPF·Search Console)와 2차(DKIM)」로 바꾼다.
**Warning signs:** 절차서의 레코드 표가 방문 구분 없이 한 표임.

### Pitfall 7: 기존 DNS 레코드를 지움
**What goes wrong:** Google 문서의 「Remove any other MX records」를 넓게 읽거나, 가비아 화면에서 낯선 레코드(라우터용 A, GitHub challenge TXT)를 정리한다. 앱의 경로 스냅이 멈추거나 GitHub Pages 도메인 인증이 풀린다.
**Why it happens:** 기존 연구가 두 레코드를 놓쳤고, 사용자는 왜 있는지 잊었을 수 있다.
**How to avoid:** 절차서 0단계의 캡처와 「보존할 기존 레코드」 표. 지우는 레코드는 없다고 명시한다(현재 MX가 없으므로 지울 MX도 없다).
**Warning signs:** 변경 후 `dig` 결과에서 기존 네 종류 중 하나가 사라짐.

### Pitfall 8: 데이터 목록이 앱 변경을 따라가지 못함
**What goes wrong:** Phase 6·7·8을 시작할 때 목록을 다시 보지 않아 처리방침이 옛 앱 기준으로 쓰인다.
**Why it happens:** 앱은 계속 바뀐다(논의 시점 `3afb2085`가 지금도 HEAD이지만 작업 트리는 이미 바뀌어 있다).
**How to avoid:** D-09대로 목록 머리에 기준 커밋과 재확인 명령을 적는다. 재확인 범위를 좁히기 위해 「이 목록이 근거로 삼은 경로 목록」도 머리에 적는다(`git diff <기준>..HEAD -- <경로들>`).
**Warning signs:** 목록 머리에 커밋 해시가 없음.

## Code Examples

### dev 읽기 전용 조회 (사용자 재로그인 뒤 실행)

```bash
# 설정을 바꾸지 않는 조회만 한다. --format 으로 이름·위치만 뽑아 식별자를 싣지 않는다.
P=running-pencil-dev

# Firestore 위치·PITR
gcloud firestore databases list --project "$P" \
  --format="table(name.basename(),locationId,type,pointInTimeRecoveryEnablement,versionRetentionPeriod)"

# Firestore TTL 정책 (fcmTokens.expireAt, mail, rate_limits)
gcloud firestore fields ttls list --project "$P" --database='(default)' \
  --format="table(name.segment(-3),name.basename(),ttlConfig.state)"

# Firestore 백업 일정
gcloud firestore backups schedules list --project "$P" --database='(default)'

# Storage 버킷 위치·소프트 삭제 기간
gcloud storage buckets list --project "$P" \
  --format="table(name,location,location_type,soft_delete_policy.retentionDurationSeconds)"

# 라우터 VM zone (외부 IP 는 뽑지 않는다)
gcloud compute instances list --project "$P" --format="table(name,zone.basename(),status)"

# 배포된 함수 리전
gcloud functions list --project "$P" --format="table(name.basename(),name.segment(3),environment)"

# Cloud Logging 보존 기간
gcloud logging buckets list --project "$P" --format="table(name.basename(),name.segment(3),retentionDays)"

# Trigger Email 확장 설치 여부
firebase ext:list --project "$P"
```
이 명령들은 이 세션에서 자격 증명 만료로 실패했다. 문법은 실행으로 확인하지 못했다 [ASSUMED: `--format` 필드 이름]. 첫 실행에서 필드가 비면 `--format=json`으로 필드 이름을 확인한 뒤 고친다.

### DNS 변경 전후 기록

```bash
# 변경 전·후에 같은 명령을 돌려 결과를 절차서의 기록 칸에 붙인다 (토큰 값은 저장소에 커밋하지 않는다)
for q in "runningpencil.com A" "runningpencil.com MX" "runningpencil.com TXT" \
         "www.runningpencil.com CNAME" "google._domainkey.runningpencil.com TXT" \
         "_github-pages-challenge-SlimPumpkin.runningpencil.com TXT"; do
  echo "== $q"; dig +short ${=q}
done
```
`${=q}`는 zsh의 단어 분리 표기다. zsh는 `$q`를 자동으로 나누지 않아 `dig`가 빈 이름 오류를 낸다(이 세션에서 실제로 겪음).

### 성공 기준 5 검사 (옛 문장 0건)

```bash
# 검사 대상 파일만. 낱말이 아니라 옛 문장의 꼴을 본다. 출력이 없으면 통과.
F=(CLAUDE.md .claude/CLAUDE.md .planning/codebase/CONVENTIONS.md .planning/codebase/TESTING.md .planning/codebase/CONCERNS.md)
grep -nE 'RunningPencil`?[은는을]? ?(영문 표기)?.{0,12}쓰지 않' "${F[@]}"
grep -nE '연락처 이메일.{0,24}(표시하지 않|넣지 않)' "${F[@]}"
grep -nE '(본문|lang).{0,20}모두 `ko`' "${F[@]}"
grep -nE 'noindex.{0,12}유지' "${F[@]}"
grep -nE '포인트를 모으고|굿즈를 교환|코스북을 완성' "${F[@]}"
grep -nE '금지 표기 확인 \(영문 서비스명' "${F[@]}"
grep -nE '본문은 한국어\.$|한글 \*\*러닝펜슬\*\*만' "${F[@]}"
grep -nE 'grep -rnE "RunningPencil\|' "${F[@]}"
grep -nE '이메일·폼 모두 없음' "${F[@]}"
```
이 아홉 줄을 지금 상태에서 실행해 확인했다 [VERIFIED: 2026-11-14 실행]. 잡히는 줄은 17개다: `CLAUDE.md:7`, `:58`, `:69`, `:71`, `.claude/CLAUDE.md:164`, `:165`, `:167`, `:168`, `CONVENTIONS.md:142`, `:143`, `:145`, `:146`, `TESTING.md:65`, `:119`, `:121`, `CONCERNS.md:56`, `:123`. 이 가운데 `.claude/CLAUDE.md:165`와 `CONVENTIONS.md:143`은 두 정규식에 함께 걸린다. 계획의 완료 조건은 「수정 전에는 이 줄들이 걸리고, 수정 뒤에는 아홉 줄 모두 출력이 없다」이다. `CONVENTIONS.md:153`의 옛 커밋 메시지 예시(`feat: RunningPencil 티저 사이트 초기 구성`)는 이력의 사실이므로 검사 대상이 아니고, 위 정규식에도 걸리지 않는다.

### 성공 기준 5 검사 (새 방침이 적혀 있음)

```bash
# 두 파일 모두에 방침 구간과 일곱 항목이 있는지. 각 줄이 1건 이상이어야 통과.
for f in CLAUDE.md .claude/CLAUDE.md; do
  echo "== $f"
  grep -c '이번 마일스톤 방침' "$f"
  for k in '지원 이메일' '사업자 정보' 'RunningPencil' '한국어.{0,6}영어' 'Jekyll' '포인트.{0,4}굿즈.{0,4}코스북' 'noindex'; do
    printf '%s: ' "$k"; grep -cE "$k" "$f"
  done
done
```

### URL 대장 형식 검사

```bash
# 대장의 모든 URL 이 apex·https·끝 슬래시인지. 출력이 없으면 통과.
# (정규식은 맞는 예 2개·틀린 예 3개로 실행해 확인했다: 끝 슬래시 없음, http, www 를 잡는다)
grep -oE 'https?://[^ |`)]+' .planning/baseline/URLS.md | grep -vE '^https://runningpencil\.com/([a-z-]+/)*$'
# 필수 11개가 다 있는지
for p in "" privacy-policy/ terms/ data-deletion/ support/ location-terms/ en/ en/privacy-policy/ en/terms/ en/data-deletion/ en/support/; do
  grep -qF "https://runningpencil.com/$p" .planning/baseline/URLS.md || echo "없음: /$p"
done
```

### 공개 저장소 누출 검사

```bash
# 기준 문서와 방침 문서에 식별자·비밀이 없는지. 출력이 없으면 통과.
grep -rnE '([0-9]{1,3}\.){3}[0-9]{1,3}|[0-9]{12}|[A-Za-z0-9._-]+@slimpumpkin\.com|1:[0-9]+:(android|ios):|google-site-verification=[A-Za-z0-9_-]{20,}|AIza[0-9A-Za-z_-]{20,}' \
  .planning/baseline/ CLAUDE.md .claude/CLAUDE.md | grep -vE '185\.199\.1(08|09|10|11)\.153|support@slimpumpkin\.com'
```
GitHub Pages의 공개 A 값(`185.199.108.153`~`111.153`)과 절차서가 새로 만들라고 안내하는 별칭 주소 `support@slimpumpkin.com`은 예외로 뺀다. 그 밖의 `@slimpumpkin.com` 주소(실제 계정)는 적지 않는다. 라우터 호스트 이름은 정규식으로 잡지 않으므로 사람이 확인한다. 이 문서(`01-RESEARCH.md`)에 같은 검사를 돌렸고 예외 두 종류 말고는 걸리는 줄이 없다 [VERIFIED: 2026-11-14 실행].

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Workspace MX 5개(`aspmx.l.google.com` 계열) | MX 1개 `smtp.google.com`, 우선순위 1 | 2023년 [CITED: Workspace MX 문서] | 새 도메인에는 1개만 넣는다. `slimpumpkin.com`의 레거시 값은 그대로 지원된다 |
| Workspace 도움말 `support.google.com/a/answer/…` | `knowledge.workspace.google.com/admin/…`로 301 이동 | 이 세션에서 리디렉션 확인 | 절차서의 링크는 새 주소로 적는다 |
| 지원 메일 = ImprovMX 전달(기존 연구 기본안) | Workspace 사용자 별칭 도메인 | 2026-11-14 결정(D-10) | ROADMAP·STATE·PROJECT의 ImprovMX 문장을 고친다(D-21) |
| 「DNS 레코드를 한 번에」 | 두 번 방문(DKIM은 24~72시간 뒤) | 이 조사 | ROADMAP Phase 5 문장 |

**Deprecated/outdated:**
- `.planning/research/STACK.md:199`의 「MX 없음. TXT 없음. … 부딪칠 기존 값이 하나도 없습니다」: 하위 도메인 레코드 둘이 있다.
- `.planning/research/STACK.md:223`의 `_github-pages-challenge-SlimPumpkin` 「권장」: 레코드가 이미 있다.
- `.planning/research/SUMMARY.md`의 「탈퇴 후 공개 코스 유지(D-28)」: 비공개 코스도 남는다.
- CONTEXT D-06의 「둘 다 로그인돼 있다(2026-11-14 확인)」: 같은 날 이 조사 시점에는 재인증이 필요했다.

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | 사용자 이메일 별칭(`support@slimpumpkin.com`)도 별칭 도메인 주소(`support@runningpencil.com`)를 자동으로 받는다 | 사용자 작업 절차서 근거 | 1순위 방식으로 지원 주소가 생기지 않는다. 수신 시험에서 드러나며 2순위(그룹)로 넘어가면 된다 |
| A2 | Google 그룹은 기본 설정에서 조직 밖 발신 메일을 받지 않을 수 있다 | 같은 절 | 그룹 방식에서 외부 4곳 시험이 실패한다. 게시 권한 설정 한 단계로 풀린다 |
| A3 | 사용자 별칭은 외부 메일을 별도 허용 없이 받는다 | 같은 절 | 수신 시험 실패. 시험으로 드러난다 |
| A4 | 「Selected domain」 목록에 사용자 별칭 도메인이 나온다(별칭 도메인에 DKIM을 걸 수 있다) | 같은 절 | D-11(지원 주소로 답장)과 Phase 10 Apple 릴레이가 막힌다. 그 경우 보조 도메인이나 다른 발신 방식을 다시 정해야 한다 |
| A5 | GA4 보존 기간의 기본값은 2개월이다 | 근거표 H | 데이터 목록에는 「미확인」으로 적으므로 영향 없음. 처리방침 초안의 예시 값으로 쓰면 안 된다 |
| A6 | Cloud Logging 기본 버킷 보존은 30일이다 | 근거표 D | 「미확인」으로 적으므로 영향 없음 |
| A7 | `google_sign_in`의 기본 범위는 `openid`·`email`·`profile`이다 | 근거표 B | 제공자별 수신 항목 표의 Google 행이 틀릴 수 있다. Phase 7에서 콘솔과 대조 |
| A8 | Jekyll은 점으로 시작하는 폴더(`.claude/`)를 사이트에 올리지 않는다 | Runtime State Inventory | 라이브 404를 `curl`로 확인했으므로 현재는 문제없음. Phase 2에서 `_config.yml`을 바꿀 때 다시 확인 |
| A9 | `gcloud … --format` 필드 이름(`locationId`, `soft_delete_policy.retentionDurationSeconds` 등) | Code Examples | 빈 열이 나온다. `--format=json`으로 확인하면 된다 |
| A10 | 「새 방침이 적혀 있음」 검사와 기준 문서 검사(이름 표·데이터 목록·결정 목록·절차서)의 명령은 대상 문서가 아직 없어 실행하지 못했다. 옛 문장 검사와 URL 형식 정규식만 실행해 확인했다 | Code Examples, Validation Architecture | 검사가 틀린 채로 통과·실패할 수 있다. 문서를 만든 작업에서 일부러 틀린 입력으로 한 번 실패시켜 본다 |
| A11 | 가비아 DNS관리툴에서 루트 호스트를 `@`로 넣는다 | 가비아 DNS 입력 화면 | 사용자가 입력에서 막힌다. 화면 안내로 풀린다 |
| A12 | `runningpencil.com`에 DMARC 레코드가 지금 꼭 필요하지는 않다 | 같은 절 | 일부 수신자가 지원 답장을 스팸으로 분류할 수 있다. Phase 10 릴레이 시험에서 드러난다 |
| A13 | `flutter_facebook_auth` 플러그인이 자동 이벤트를 끄는 설정을 병합하지 않는다 | Facebook SDK | 데이터 목록에 「실제 전송 여부 미확인」으로 적으므로 영향 없음 |
| A14 | 별칭 도메인에만 있는 주소(`support@runningpencil.com` 단독)는 만들 수 없다 | 사용자 작업 절차서 근거 | 만들 수 있다면 `support@slimpumpkin.com`을 만들 필요가 없다. 절차가 한 단계 줄 뿐 결과는 같다 |
| A15 | `gsd-tools state resolve-blocker`·`add-blocker`가 이 `STATE.md`의 Blockers 문장을 원하는 대로 고친다 | Don't Hand-Roll | 핸들러가 문장을 못 찾거나 구간 모양을 바꾼다. `Edit`로 고치고 `state validate`로 확인하면 된다 |

## Open Questions

1. **결정 목록의 대상을 넓힐지 (N1~N6)**
   - What we know: D-12는 대상을 U2·U3·U5~U9·U11·U13과 「prod 리전」으로 정했다. 조사에서 처리방침 문장을 바꾸는 사실 여섯 가지가 더 나왔다.
   - What's unclear: 사용자가 이 항목들을 결정 목록의 정식 항목으로 원하는지, 데이터 목록의 「확인할 것」 표로 충분한지.
   - Recommendation: 결정 목록 끝에 「조사에서 새로 나온 항목」 구간을 두고 N1·N3·N4·N5·N6을 넣는다. N2는 결정이 아니라 사실이므로 데이터 목록에만 적는다. 계획 확인 때 사용자에게 한 줄로 알린다.

2. **CLI 재로그인을 이 단계의 전제로 둘지**
   - What we know: 두 CLI 모두 만료됐고 재로그인은 사용자만 할 수 있다. 성공 기준 3은 「미확인」 표시를 허용한다.
   - What's unclear: 사용자가 지금 로그인해 줄 수 있는지.
   - Recommendation: 계획 맨 앞에 사용자 작업 하나(`gcloud auth login`, `firebase login --reauth`)를 두고, CLI 조회는 독립된 작업으로 떼어 낸다. 로그인이 안 되면 그 작업만 건너뛰고 해당 칸을 「CLI 미확인」으로 둔 채 단계를 끝낸다.

3. **데이터 목록을 공개 저장소에 필드 단위로 올려도 되는지**
   - What we know: D-07이 필드 단위를 정했고 D-18이 공개 저장소임을 알고 있다. 컬렉션·필드 이름은 비밀이 아니고(보안은 규칙이 맡는다) 처리방침이 범주 수준으로 공개할 내용이다.
   - What's unclear: 앱의 데이터 모델과 인프라 구성(리전, 프록시 구조)이 공개되는 것을 사용자가 의식하고 있는지.
   - Recommendation: 필드 단위로 쓰되 비밀·식별자·호스트 이름은 뺀다(Security Domain). 계획 확인 때 「데이터 목록이 GitHub에서 보인다」를 한 줄로 다시 알린다.

4. **라우터 호스트 이름을 절차서에 적을지**
   - What we know: 공개 DNS에 있는 이름이지만 앱 인프라의 진입점이다. 절차서는 사용자가 「지우면 안 되는 레코드」를 알아볼 수 있어야 한다.
   - Recommendation: 이름을 적지 않고 「앱 경로 라우터용 A 레코드 1개(가비아 화면에서 확인, 앱 저장소 `infra/router/RUNBOOK.md` 참고)」라고 적는다.

5. **`.planning/research/.cache/`의 처리**
   - What we know: GSD `research-store`가 이 조사 중에 만든 폴더이고 추적되지 않는다. 내용은 공식 문서 요약 두 건이다.
   - Recommendation: 커밋하지 않는다. `.gitignore`에 넣을지는 계획자가 정한다(이 단계는 `.gitignore`를 바꾸지 않아도 된다).

6. **GitHub Pages 도메인 인증 상태**
   - What we know: challenge TXT 레코드는 DNS에 있다.
   - What's unclear: GitHub 조직 설정에서 「Verified」로 보이는지.
   - Recommendation: 사용자 작업 절차서에 확인 단계 하나로 넣는다.

## Environment Availability

| Dependency | Required By | Available | Version | Fallback |
|------------|------------|-----------|---------|----------|
| 앱 저장소 `~/dv/woody/running_pencil` | 데이터 목록 근거 | ✓ | HEAD `3afb2085` | — |
| `gcloud` | dev 리전·TTL·백업 조회(D-06) | 설치됨, **자격 증명 만료** | 591.0.0 | 사용자 재로그인. 안 되면 「CLI 미확인」으로 표시 |
| `firebase` CLI | 확장·함수 목록 조회 | 설치됨, **자격 증명 만료** | 15.29.0 | 위와 같음 |
| `dig` | DNS 현황·절차서 | ✓ | macOS 기본 | — |
| `curl` | 라이브 URL 확인 | ✓ | — | — |
| `gh` | (필요 시) 저장소 공개 여부 확인 | ✓ | — | — |
| GSD 도구 | `state` 핸들러, `generate-claude-md`, 커밋 | ✓ | 설치됨 | — |
| WebFetch·WebSearch | 공식 문서 확인 | ✓ | — | — |

**Missing dependencies with no fallback:**
- 없음.

**Missing dependencies with fallback:**
- gcloud·firebase 자격 증명: 이 세션에서 `gcloud firestore databases list`(기본 설정과 `running-pencil` 설정 둘 다)와 `firebase firestore:databases:list`가 각각 `Reauthentication failed. cannot prompt during non-interactive execution`, `Your credentials are no longer valid. Please run firebase login --reauth`로 실패했다 [VERIFIED: 명령 출력]. 조회 결과는 「관측 없음」이다. 다른 자격 증명(서비스 계정 키 등)으로 돌아가지 않았다.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | 없음 — 이 저장소에는 시험 프레임워크가 없고(`TESTING.md:97-101`), 이 단계의 산출물은 문서다. 검증은 셸 명령(grep·curl·git)으로 한다 |
| Config file | 없음 |
| Quick run command | 위 Code Examples의 「성공 기준 5 검사」 두 블록 |
| Full suite command | 아래 표의 명령 전부(각 30초 미만) |

### Phase Requirements → Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| BASE-01 | 이름 표가 있고 채울 값 4개가 들어 있음 | 문서 검사 | `grep -cE '러닝펜슬\|RunningPencil\|슬림펌킨\|runningpencil\.com' .planning/baseline/NAMES.md` (4 이상) | ❌ Wave 0 |
| BASE-01 | 사업자 값 칸이 비어 있음(추측 값 없음) | 문서 검사 | `grep -nE '[0-9]{3}-[0-9]{2}-[0-9]{5}' .planning/baseline/NAMES.md` (0건 — 사업자등록번호 꼴 없음) + 사람 확인(상호·대표자·주소 칸) | ❌ Wave 0 |
| BASE-02 | 11개 URL이 모두 있고 형식이 맞음 | 문서 검사 | 위 「URL 대장 형식 검사」 | ❌ Wave 0 |
| BASE-02 | URL마다 콘솔 필드 칸이 있음 | 문서 검사 | 사람 확인(표의 열) | ❌ Wave 0 |
| BASE-03 | 기준 커밋과 재확인 규칙이 머리에 있음 | 문서 검사 | `grep -cE '3afb2085\|git diff' .planning/baseline/DATA-INVENTORY.md` (2 이상) | ❌ Wave 0 |
| BASE-03 | 행마다 근거 경로가 있음 | 문서 검사 | `awk -F'\|' 'NR>2 && NF>9 && $(NF-1) !~ /[a-z_\/]+\.(ts\|dart\|rules\|md\|xml\|plist\|json\|sh\|env)\|공식 문서\|dev CLI\|미확인/' .planning/baseline/DATA-INVENTORY.md` (0건) | ❌ Wave 0 |
| BASE-03 | 근거로 적은 경로가 앱 저장소에 실제로 있음 | 문서 검사 | 목록에서 경로를 뽑아 `test -e ~/dv/woody/running_pencil/<경로>` 반복 | ❌ Wave 0 |
| BASE-03 | 확인 못 한 칸이 「미확인」으로 표시됨 | 문서 검사 | `grep -c '미확인' .planning/baseline/DATA-INVENTORY.md` (1 이상) + 빈 칸 없음 `grep -nE '\|\s*\|' …` (0건) | ❌ Wave 0 |
| BASE-04 | 결정 목록에 대상 항목이 모두 있음 | 문서 검사 | `for u in U2 U3 U5 U6 U7 U8 U9 U11 U12 U13 'prod'; do grep -q "$u" .planning/baseline/DECISIONS.md \|\| echo "없음: $u"; done` | ❌ Wave 0 |
| BASE-04 | 항목마다 막는 단계가 적혀 있음 | 문서 검사 | 사람 확인 + `grep -c 'Phase [0-9]' .planning/baseline/DECISIONS.md` | ❌ Wave 0 |
| BASE-04 | 절차서에 DNS 표·수신 시험·사업자 값·화면 캡처가 있음 | 문서 검사 | `for k in 'MX' 'SPF' 'DKIM' 'Search Console' 'dig' 'Gmail' '네이버' 'iCloud' 'Outlook' '사업자' '캡처'; do grep -q "$k" .planning/baseline/USER-TASKS.md \|\| echo "없음: $k"; done` | ❌ Wave 0 |
| BASE-04 | 계획 문서에 ImprovMX 전제가 남지 않음(D-21) | 문서 검사 | `grep -n 'ImprovMX' .planning/ROADMAP.md .planning/STATE.md` (0건, 또는 「채택하지 않음」 문맥만) | ✅ (대상 파일 있음) |
| BASE-05 | 옛 문장 0건 | 문서 검사 | 위 「성공 기준 5 검사 (옛 문장 0건)」 | ✅ |
| BASE-05 | 새 방침 7항목이 두 파일에 있음 | 문서 검사 | 위 「성공 기준 5 검사 (새 방침이 적혀 있음)」 | ✅ |
| BASE-05 | 생성본이 원본과 어긋나지 않음 | 문서 검사 | `gsd-tools generate-claude-md` 실행 뒤 `git diff --exit-code .claude/CLAUDE.md` (차이 없음) | ✅ |
| 단계 전체 | 라이브 사이트가 바뀌지 않음 | 범위 검사 | `git diff --name-only <단계 시작 커밋>..HEAD -- '*.html' _config.yml favicon/ CNAME` (0건) | ✅ |
| 단계 전체 | 앱 저장소를 건드리지 않음 | 범위 검사 | `git -C ~/dv/woody/running_pencil status --short`가 단계 시작 때와 같음, HEAD가 `3afb2085` 그대로 | ✅ |
| 단계 전체 | 공개 저장소 누출 없음 | 보안 검사 | 위 「공개 저장소 누출 검사」 | ❌ Wave 0 |

### Sampling Rate
- **Per task commit:** 그 작업이 만든 문서의 검사 줄 + 「공개 저장소 누출 검사」
- **Per wave merge:** 표의 명령 전부
- **Phase gate:** 표의 명령 전부 통과 + 사람 확인 항목(이름 표 빈칸, 콘솔 필드 열, 막는 단계)

### Wave 0 Gaps
- [ ] `.planning/baseline/` 폴더와 다섯 문서 — 검사 대상 자체가 아직 없다. 각 문서를 만드는 작업의 완료 조건으로 위 명령을 넣는다
- [ ] 옛 문장 검사의 수정 전 기록 — 정규식 아홉 줄은 이 조사에서 실행해 17줄이 걸리는 것을 확인했다. 실행자는 수정 직전에 한 번 더 돌려 출력을 남기고, 수정 뒤 0건과 짝을 맞춘다
- [ ] 새 방침 검사와 기준 문서 검사는 실행해 보지 못했다(A10). 문서를 만든 작업에서 처음 돌릴 때 결과를 눈으로 대조한다
- [ ] 단계 시작 커밋 해시 기록 — 「라이브 사이트가 바뀌지 않음」 검사의 기준점

## Security Domain

`security_enforcement`가 켜져 있다(ASVS 레벨 1). 이 단계는 실행 코드를 만들지 않으므로 대부분의 범주가 해당하지 않는다. 실제 위험은 공개 저장소를 통한 정보 노출이다.

### Applicable ASVS Categories

| ASVS Category | Applies | Standard Control |
|---------------|---------|-----------------|
| V2 Authentication | 아니요 | 사이트에 인증이 없다. CLI 재로그인은 사용자가 직접 한다 |
| V3 Session Management | 아니요 | — |
| V4 Access Control | 부분 | 앱 저장소와 dev 프로젝트는 읽기만 한다(D-06). 변경·배포·생성·삭제 명령을 쓰지 않는다 |
| V5 Input Validation | 아니요 | 입력을 받는 코드가 없다 |
| V6 Cryptography | 아니요 | — |
| V8 Data Protection | 예 | 공개 저장소에 비밀·식별자·사업자 사실값을 커밋하지 않는다(D-18). 커밋 전 누출 검사 |
| V14 Configuration | 예 | `.planning/`이 `_config.yml` `exclude`에 있어 사이트에 올라가지 않는다(라이브 404 확인). DNS 변경은 사용자가 하고 전후 `dig`로 기록한다 |

### Known Threat Patterns for 공개 저장소의 문서 단계

| Pattern | STRIDE | Standard Mitigation |
|---------|--------|---------------------|
| 근거를 옮기다 비밀·식별자 커밋(IP, 프로젝트 번호, 앱 ID, 계정 이메일, DNS 인증 토큰, 라우터 호스트) | Information Disclosure | 근거는 경로와 행 번호로만. CLI는 `--format`으로 이름·위치만. 커밋 전 누출 검사 정규식 |
| 사업자 사실값(자택 주소 포함)을 이름 표에 미리 적음 | Information Disclosure | D-18: 값 칸을 비운다. 값은 Phase 5의 공개 커밋에 처음 들어간다 |
| 이메일 게이트 전에 지원 주소를 HTML·`_data`에 넣음 | Information Disclosure / 신뢰 손상 | D-19: 주소는 `.planning/` 문서에만. 방침 표에 적용 시점 명시(Pitfall 5) |
| DNS 절차서의 틀린 값으로 메일 유실·사이트 중단 | Denial of Service | 서비스 발급 값은 「콘솔에서 복사」. 고정 값(MX·SPF)은 공식 문서 인용 + 콘솔 안내값과 대조. 기존 레코드 보존 표. 전후 `dig` |
| 다른 사람이 도메인을 자기 GitHub Pages에 연결(도메인 탈취) | Spoofing | `_github-pages-challenge-SlimPumpkin` TXT 유지, 조직 설정에서 인증 상태 확인. 와일드카드 레코드를 만들지 않는다 |
| SPF 레코드가 둘이 되어 메일 인증 실패 | Denial of Service | SPF TXT는 하나만. 변경 후 `dig +short runningpencil.com TXT`에서 `v=spf1` 줄 수 확인 |
| 읽기 전용이어야 할 CLI로 설정을 바꿈 | Tampering | 허용 명령을 `list`·`describe`·`get` 계열로 한정해 계획에 명시. `deploy`, `set`, `create`, `delete`, `update` 금지 |
| 옛 방침 문장이 남아 다음 세션이 결정을 되돌림 | Tampering(방침) | 범위를 정한 정규식 검사, 원본 먼저 수정 |

데이터 목록의 필드 이름·컬렉션 이름·리전은 비밀이 아니다(보안은 Firestore·Storage 규칙이 맡는다). 다만 앱의 구조가 공개되는 점은 Open Questions 3으로 사용자에게 다시 알린다.

## Sources

### Primary (HIGH confidence)
- 앱 저장소 `~/dv/woody/running_pencil` (HEAD `3afb2085`, 읽기 전용): `firestore.rules`, `storage.rules`, `.firebaserc`, `firebase.json`, `functions/src/index.ts`, `functions/src/shared/{region,rate_limit,client_ip_hash}.ts`, `functions/src/auth/{delete_user_account,identity_index,mirror_account_email,kakao_custom_token,naver_profile_to_custom_token,line_custom_token}.ts`, `functions/src/running_pencil/{cleanup_user_data,snap_route,search_places}.ts`, `functions/src/running_pencil/region/{resolve_region,on_course_written}.ts`, `functions/src/email/{email_hash,send_verification_mail}.ts`, `extensions/firestore-send-email.env`, `lib/core/auth/provider_id.dart`, `lib/core/config/app_config.dart`, `lib/core/location/location_platform.dart`, `lib/core/bootstrap.dart`, `lib/core/router/auth_guard.dart`, `lib/features/auth/data/auth_repository.dart`, `lib/features/auth/presentation/login_screen.dart`, `lib/features/runs/application/run_log_store.dart`, `lib/features/notifications/domain/fcm_token.dart`, `lib/l10n/app_ko.arb`, `lib/core/firebase/firebase_options_{dev,stg,prod}.dart`, `android/app/src/main/AndroidManifest.xml`, `ios/Runner/Info.plist`, `config/dev.json`(키 이름과 비밀이 아닌 두 값만), `infra/router/{Caddyfile,deploy.sh,RUNBOOK.md}`, `docs/kit-fork.md`, `.planning/{PROJECT,REQUIREMENTS}.md`, `.planning/phases/02-foundation-kit-fork/02-CONTEXT.md`
- 이 저장소: `CLAUDE.md`, `.claude/CLAUDE.md`, `_config.yml`, `.planning/{ROADMAP,PROJECT,REQUIREMENTS,STATE}.md`, `.planning/codebase/*.md`, `.planning/research/{SUMMARY,STACK,ARCHITECTURE}.md`, `.planning/config.json`
- `dig` (2026-11-14): `runningpencil.com`과 `slimpumpkin.com`의 NS·A·MX·TXT·CNAME
- `curl` (2026-11-14): 라이브 `/CLAUDE.md`, `/.claude/CLAUDE.md`, `/.planning/…` 404, `/privacy-policy/` 200
- GSD 도구 원본 `~/.claude/gsd-core/bin/lib/profile-output.cjs`, `gsd-tools roadmap`·`state` 하위 명령 목록

### Secondary (MEDIUM confidence — 공식 문서를 WebFetch로 한 번 읽음)
- https://firebase.google.com/support/privacy (마지막 수정 2026-09-24) — 서비스별 보존 기간, 처리 위치, Authentication 미국 운영
- https://support.google.com/analytics/answer/7667196 — GA4 보존 기간 선택지와 적용 범위, 설정 위치
- https://knowledge.workspace.google.com/admin/domains/add-a-user-alias-domain-or-secondary-domain — 별칭 도메인 비용·주소 생성·Gmail 켜기·Send mail as
- https://knowledge.workspace.google.com/admin/domains/faq-for-multiple-domains — 별칭 도메인과 보조 도메인의 차이, 개수 제한
- https://knowledge.workspace.google.com/admin/domains/set-up-mx-records-for-google-workspace — MX 값
- https://knowledge.workspace.google.com/admin/security/set-up-spf — SPF 값
- https://knowledge.workspace.google.com/admin/security/set-up-dkim — DKIM 절차와 대기 시간
- https://knowledge.workspace.google.com/admin/users/add-or-delete-an-alternate-email-address-email-alias — 사용자 이메일 별칭
- https://developers.facebook.com/docs/app-events/getting-started-app-events-android — 자동 이벤트 기본값과 끄는 설정
- https://developers.facebook.com/docs/app-events/gdpr-compliance/ — 자동 로깅 끄기, `AutoInitEnabled`

GSD `classify-confidence`는 `webfetch` 제공자를 LOW로 분류한다. 위 문서들은 공식 원문이지만 요약 모델을 거쳐 읽었으므로, 절차서에 값을 옮길 때는 원문을 다시 연다.

### Tertiary (LOW confidence)
- 가비아 FAQ(WebSearch 발췌, 원문 페이지 미확인) — DNS관리툴 경로, MX 값 끝 마침표
- https://support.google.com/a/answer/2727156, https://support.google.com/mail/answer/22370 (WebSearch 발췌) — 그룹 별칭, 그룹 주소로 보내기

## Metadata

**Confidence breakdown:**
- 데이터 목록 근거(앱 코드): HIGH — 규칙 파일과 함수 원본을 열어 행 번호까지 확인했다
- 리전·보존 기간: MEDIUM~LOW — Functions 리전만 코드로 확정. Firestore·VM은 문서 근거, Storage·백업·TTL·로그는 미확인. CLI 자격 증명 만료
- Workspace 절차: MEDIUM — 공식 문서 인용. 별칭의 별칭 도메인 반영, 그룹 외부 수신, 별칭 도메인 DKIM은 가정
- 가비아 화면: LOW — 검색 발췌만
- `CLAUDE.md` 갱신: HIGH — 옛 문장 위치와 생성기 동작을 원본에서 확인했고, 옛 문장 검사 정규식을 현재 파일에 실행했으며, 생성기를 저장소 밖 사본으로 돌려 결과가 현재 파일과 같고 마커 밖 글이 남는 것을 확인했다
- 결정 목록 근거: HIGH(U5·U6·U12), 나머지는 코드 근거가 없는 사용자·법률 항목

**Research date:** 2026-11-14
**Valid until:** 앱 근거는 앱 HEAD가 `3afb2085`에서 움직일 때까지. DNS 현황은 사용자가 가비아를 바꾸기 전까지. 외부 문서(Workspace·Firebase)는 30일
