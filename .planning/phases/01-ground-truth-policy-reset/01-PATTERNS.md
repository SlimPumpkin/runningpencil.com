# Phase 1: 기준표와 방침 정비 (Ground Truth & Policy Reset) - Pattern Map

**Mapped:** 2026-11-14
**Files analyzed:** 13 (새 문서 5, 수정 8)
**Analogs found:** 11 / 13 (새 문서 2개는 형식 유사물이 없어 `01-RESEARCH.md`의 패턴을 씀)

> 이 단계의 산출물은 실행 코드가 아니라 문서다. 그래서 「유사물(analog)」은 같은 일을 하는 코드가 아니라 **같은 모양의 표·머리말·문장 형식을 가진 기존 문서**다.
> 유사물은 두 가지로 나눠 적었다. **모양 출처**(표의 열, 머리말, 문체)와 **내용 출처**(행에 들어갈 사실). 모양 출처로 적은 기존 연구 문서의 내용은 대부분 이번 결정으로 낡았으므로 내용까지 베끼면 안 된다. 해당하는 곳에 「모양만」이라고 표시했다.
> 이 저장소는 PUBLIC이다(D-18). 아래 발췌에서 IP 주소·토큰 값은 `…`로 가렸다. 앱 저장소 파일은 유사물로 쓰지 않았다. 모든 유사물 경로는 `git ls-files`에 나오는 추적 파일이다.

## File Classification

역할·데이터 흐름은 GSD의 고정 값에 가장 가까운 것을 고르고, 괄호 안에 문서의 실제 종류를 적었다.

| New/Modified File | Role | Data Flow | Closest Analog | Match Quality |
|-------------------|------|-----------|----------------|---------------|
| `.planning/baseline/NAMES.md` (신규) | config (이름 표) | transform | 없음 — 머리말만 `.planning/research/STACK.md:1-9` | no-analog (머리말만 role-match) |
| `.planning/baseline/URLS.md` (신규) | config (URL 대장) | transform | `.planning/research/ARCHITECTURE.md:249-260` | role-match (모양만) |
| `.planning/baseline/DATA-INVENTORY.md` (신규) | model (데이터 목록) | transform | 없음 — 근거 표기만 `.planning/codebase/CONCERNS.md:13-17` | no-analog (근거 표기만 partial) |
| `.planning/baseline/DECISIONS.md` (신규) | config (결정 목록) | event-driven (게이트) | `.planning/research/SUMMARY.md:232-249` + `.planning/ROADMAP.md:197-218` | role-match (모양만) |
| `.planning/baseline/USER-TASKS.md` (신규) | utility (절차서) | batch (사람이 순서대로 실행) | `.planning/research/STACK.md:213-226` + `.planning/codebase/TESTING.md:103-130` | role-match (모양만) |
| `CLAUDE.md` (수정) | config (방침, 사람이 쓴 정본) | transform | 자기 자신 (`CLAUDE.md:15-22`, `:32-39`, `:41-58`, `:67-71`) | exact |
| `.claude/CLAUDE.md` (수정, 생성본) | config (방침, 생성본) | transform (원본 → 생성) | 자기 자신 (`.claude/CLAUDE.md:1-21`, `:162-169`) | exact |
| `.planning/codebase/CONVENTIONS.md` (수정, 생성 원본) | config | transform | 자기 자신 (`:140-147`) | exact |
| `.planning/codebase/TESTING.md` (수정) | test (수동 점검 목록) | batch | 자기 자신 (`:64-65`, `:103-123`) | exact |
| `.planning/codebase/CONCERNS.md` (수정) | config | transform | 자기 자신 (`:55-59`, `:122-124`) | exact |
| `.planning/ROADMAP.md` (수정, D-21) | config (계획 문서) | event-driven (게이트) | 자기 자신 (`:111-117`, `:164`, `:201-218`) | exact |
| `.planning/STATE.md` (수정, D-21) | store (GSD 상태) | event-driven | 자기 자신 (`:72-85`) | exact |
| `.planning/PROJECT.md` (수정, D-21) | config | transform | 자기 자신 (`:96-115`) | exact |

**고치지 않는 파일** (앞의 세 행은 단계 경계라 작업에 넣지 않는다. 마지막 행은 「유지 가능」이라는 RESEARCH 판단이고, 최종 판단은 계획자가 D-01 기준으로 한다)

| 파일 | 이유 |
|------|------|
| `_config.yml` | `exclude`에 `.planning/`이 이미 있다(`_config.yml:9-13`). `.planning/baseline/` 아래 문서는 추가 등록이 필요 없다. 이 단계는 라이브 사이트 파일을 바꾸지 않는다 |
| `index.html`, `privacy-policy/`, `terms/`, `data-deletion/`의 HTML, `favicon/`, `CNAME` | CONTEXT 「Phase Boundary」 — 라이브 사이트는 바꾸지 않는다 |
| 앱 저장소 `~/dv/woody/running_pencil` | 읽기 전용 |
| `README.md`, `.planning/codebase/{STACK,STRUCTURE,ARCHITECTURE,INTEGRATIONS}.md` | RESEARCH 판단: 유지 가능. 현재 상태 설명이라 D-01에 따라 그대로 둘 수 있다(`01-RESEARCH.md:720-728`, `01-CONTEXT.md:153-154`). 방침으로 읽히는 문장이 있으면 고친다. `STACK.md`·`ARCHITECTURE.md`의 목록·표 줄을 고치면 생성본에도 반영된다 |

**계획자가 정할 것 (이 문서는 결정하지 않음)**

- `.planning/research/STACK.md`를 고칠지. D-10은 「ImprovMX를 전제한 문장은 이 단계 안에서 Workspace 결정에 맞게 고친다(D-21)」고 하지만, D-21이 꼽은 「고칠 곳」은 `ROADMAP.md`·`STATE.md`·`PROJECT.md` 셋이다. `research/STACK.md:20`, `:197-211`, `:239-240`, `:258-262`에 ImprovMX 기본안이 남아 있다. RESEARCH의 검증 명령(1043행)도 `ROADMAP.md`와 `STATE.md`만 검사한다.
- `.planning/research/.cache/`(추적 안 됨)를 `.gitignore`에 넣을지(RESEARCH Open Questions 5). 넣는다면 `.gitignore`의 기존 형식(구획마다 `# 한국어 설명` 한 줄 + 경로)을 따른다.

## Pattern Assignments

### `.planning/baseline/NAMES.md` (config — 이름 표, transform)

**Analog:** 표 형식의 유사물이 없다. 머리말 형식만 연구 문서에서 가져온다. 행 내용은 `01-RESEARCH.md:643-656`의 표를 그대로 쓴다(열: 항목 | 값 | 지금 채우는가 | 들어갈 곳 | 근거).

**머리말 형식** (`.planning/research/STACK.md:1-9` — 제목, 굵은 메타 줄, `>` 안내 문단):
```markdown
# Stack Research

**Domain:** 빌드 없는 GitHub Pages 정적 사이트를 … 정비 (한국어 기본 + 영문판)
**Researched:** 2026-11-14
**Confidence:** MEDIUM (…)

> 이 문서는 기존 스택(`.planning/codebase/STACK.md`)을 다시 조사하지 않습니다. 이번 마일스톤에서 **더하거나 바꿀 것**만 다룹니다.
```
다섯 기준 문서는 이 꼴에 맞춰 머리에 「작성일」「무엇의 기준인가(BASE-0N)」「누가 읽는가(어느 Phase의 입력)」를 굵은 메타 줄로 두고, 주의 사항(공개 저장소, 값 칸을 비우는 이유)을 `>` 문단으로 둔다.

**맺음 줄 형식** (`.planning/research/STACK.md:305-307`):
```markdown
---
*Stack research for: GitHub Pages 정적 사이트의 심사 대응 정비 (러닝펜슬)*
*Researched: 2026-11-14*
```

**행 내용 출처:** `01-RESEARCH.md:643-656`. 지켜야 할 것:
- 지금 채우는 값은 4개뿐이다(러닝펜슬, RunningPencil, 슬림펌킨, `runningpencil.com`). 지원 이메일 `support@runningpencil.com`은 `.planning/` 문서에만 적는다(D-19).
- 사업자 값 7행(상호·대표자·사업자등록번호·주소·영문 법인명·스토어 개발자 이름·전화번호)은 값 칸을 비운다(D-18). 「들어갈 곳」은 「`_data/company.yml` (Phase 5에서 확정)」으로 적고 키 이름을 고정하지 않는다(`01-RESEARCH.md:658`).
- 「앱 쪽 표시명과 일치 확인」 참고 행을 둔다(`01-RESEARCH.md:660`).
- 표를 고른 이유는 `01-RESEARCH.md:209`(Alternatives Considered)에 있다.

---

### `.planning/baseline/URLS.md` (config — URL 대장, transform)

**Analog:** `.planning/research/ARCHITECTURE.md:249-260` — **모양만.** 이 표는 「필드 범주 → URL」 방향이고 「출처」 열이 대부분 「미확인」이다. 대장은 방향을 뒤집어 「URL → 콘솔 필드 범주」로 쓴다.

**표 형식** (`.planning/research/ARCHITECTURE.md:253-256`):
```markdown
| 필드 범주 | 사이트 URL | 해당 콘솔 | 출처 |
|-----------|-----------|-----------|------|
| 홈페이지 / 앱 웹사이트 | `https://runningpencil.com/` | Google OAuth 브랜딩, Google Play(웹사이트), App Store(Marketing URL, 선택), 카카오·네이버 사이트 도메인/서비스 URL | Google OAuth: 공식 문서(LOW, 단일 확인). 나머지 미확인 |
| 개인정보처리방침 URL | `https://runningpencil.com/privacy-policy/` (KO, 홈페이지 링크와 동일해야 함) | Google OAuth, Google Play, App Store, Facebook, LINE, 카카오·네이버(요구 시) | … |
```

**「도메인만 등록하는 칸」 행 형식** (`.planning/research/ARCHITECTURE.md:260`):
```markdown
| 승인된 도메인 / 앱 도메인 | `runningpencil.com` | Google OAuth Authorized domains, Facebook App Domains, 카카오 Web 플랫폼 사이트 도메인 | … |
```

**URL 표기 규칙의 기존 문장** (`.planning/research/ARCHITECTURE.md:245-246`):
```markdown
- 기존 세 URL에는 리디렉션을 걸지 않습니다. …
- 모든 콘솔 URL은 `https://runningpencil.com/…/` (apex, 끝 슬래시 포함) 형식으로 통일합니다.
```

**행 내용 출처:** `01-RESEARCH.md:664-677` (11행 + v2 예약 1행, 열: URL | 언어 | 현재 상태 | 만드는 단계 | 등록할 콘솔 필드(범주)). 지켜야 할 것:
- 머리에 「범주 수준, 정확한 필드명은 Phase 10」이라고 적는다(D-17, `01-RESEARCH.md:679`).
- 기존 3개 URL에 「경로 고정, 리디렉션 금지」 표시를 둔다(`01-RESEARCH.md:681`, `.planning/ROADMAP.md:12`).
- `/location-terms/`는 확정값이다(D-15). `/en/location-terms/`는 v2 예약 행으로만 둔다.
- 완료 검사는 `01-RESEARCH.md:916-924`의 형식 검사를 그대로 쓴다. 이 검사는 문서 안의 모든 `http…` 문자열을 잡으므로, 대장에는 `https://runningpencil.com/…/` 형식이 아닌 URL(외부 문서 링크 등)을 넣지 않는다. D-16의 설명용 표기 `https://runningpencil.com/…/`를 대장 머리말에 그대로 옮겨도 `…` 때문에 이 검사에 걸리므로, 형식 설명은 「apex·https·끝 슬래시」처럼 글로 적는다.

---

### `.planning/baseline/DATA-INVENTORY.md` (model — 데이터 목록, transform)

**Analog:** 필드 단위 목록의 유사물이 이 저장소에 없다. 근거를 「경로:행」으로 다는 표기만 `.planning/codebase/CONCERNS.md`에서 가져온다. 표의 열과 행 예시는 `01-RESEARCH.md:273-289`(Pattern 1·2)를 쓴다.

**근거 표기 형식** (`.planning/codebase/CONCERNS.md:13-17` — 경로는 백틱, 행 번호는 `:` 뒤, 여러 개는 쉼표):
```markdown
**공유 블록의 수동 복제 (4개 파일):**
- Issue: … 현재 「공통」 CSS는 일치함 (`index.html:31-59` == `terms/index.html:37-65`), …
- Files: `index.html`, `terms/index.html`, `privacy-policy/index.html`, `data-deletion/index.html`
- Impact: …
```

**행 형식** (`01-RESEARCH.md:278-279` — 열 10개, D-07의 열 + 범주 태그):
```markdown
| 항목 | 범주 | 출처 | 목적 | 저장 위치(리전) | 수탁자 | 국외 이전 | 보유 기간 | 삭제 방식 | 근거 |
| `runs.path` (GPS 궤적, …) | 위치 기록 | 기기 GPS(기록 중) | … | Firestore `asia-northeast3` (근거: dev 설정 기록, CLI 미확인) | Google(Firebase) | 미확인(prod 리전에 따름) | … | … | `firestore.rules:231-257`, `functions/src/running_pencil/cleanup_user_data.ts:42-56` |
```

**「확인할 것」 표 형식** (`01-RESEARCH.md:287-288`):
```markdown
| 미확인 칸 | 확인하는 사람 | 확인 방법 | 막는 단계 |
| Analytics 사용자·이벤트 데이터 보존 기간 | 사용자 | Google Analytics > 관리 > 데이터 설정 > 데이터 보관 | Phase 6(절대 표현), Phase 7 |
```

**행 내용 출처:** `01-RESEARCH.md`의 근거표 A~H(343-471행), Facebook SDK(473-479행), 「확인할 것」(481-496행). 지켜야 할 것:
- 머리에 기준 앱 커밋, 재확인 명령(`git diff <기준>..HEAD -- <경로들>`), 근거로 삼은 경로 목록을 둔다(D-09, `01-RESEARCH.md:829-833`).
- 리전 행마다 「근거: dev」 또는 근거 종류(「dev 설정 기록(문서)」「dev CLI」「공식 문서」)를 적는다(D-08, `01-RESEARCH.md:274`).
- 빈 칸을 두지 않는다. 모르는 칸은 「미확인」이고, 누가 어떻게 확인하는지를 「확인할 것」 표에 짝지어 적는다.
- `courses` 행은 `visibility`로 나누지 않는다. 탈퇴 때 공개·비공개 모두 지워지지 않는다(`01-RESEARCH.md:441`, `:799-803`).
- 위치를 읽는 세 시점(에디터·시작 전·기록 중)을 구분해 적는다(`01-RESEARCH.md:388-395`).
- 근거는 경로와 행 번호로만 가리킨다. IP, 프로젝트 번호, 앱 ID, 계정 이메일, 라우터 호스트 이름은 옮기지 않는다.
- 완료 검사는 `01-RESEARCH.md:1036-1039`.

---

### `.planning/baseline/DECISIONS.md` (config — 결정 목록, event-driven)

**Analog:** `.planning/research/SUMMARY.md:232-249`(질문·근거 문장) + `.planning/ROADMAP.md:197-218`(누가·막는 단계) — **모양만.**
SUMMARY 표의 「막는 것」 열은 옛 8단계 번호와 옛 요구사항 ID를 쓴다(D-14). 단계 번호는 반드시 ROADMAP External Gates 표에서 가져온다.

**질문·근거 표 형식** (`.planning/research/SUMMARY.md:234-241` — 번호, 굵은 질문, 근거):
```markdown
| # | 결정 | 근거·충돌 | 막는 것 |
|---|---|---|---|
| U2 | **위치정보법 분류**: 제9조 신고(위치기반서비스사업) vs 제5조 등록(위치정보사업, 법인 요건) | 기기 GPS를 직접 받는 앱의 분류는 조문만으로 정해지지 않음. 미신고 시 형사처벌(제40조) | … |
| U5 | Email/Password 가입을 UI에 노출하는지 | 처리방침 항목, 네이버 별도 비밀번호 금지 | … |
```

**누가·막는 단계 형식** (`.planning/ROADMAP.md:201-203`, `:209-212` — 이 열 값이 정본):
```markdown
| 게이트 | 누가 | 막는 단계 |
|--------|------|-----------|
| U2 위치정보법 분류(신고 vs 등록) | 법률 확인 | Phase 8 위치약관 범위, ACPT-02 |
| U3 소상공인·1인 창조기업 해당 여부 | 법률 확인 | Phase 7 보호책임자 |
| U5 Email/Password 가입 노출 여부 | 사용자(앱) | Phase 7 |
| U6 탈퇴 후 공개 코스 유지, 비공개 코스 처리 | 사용자(앱) | Phase 6, 8 |
```

**「결정됨」 기록 형식** (`.planning/ROADMAP.md:218` — U12를 이 꼴로 적는다):
```markdown
이미 결정된 항목: U1(전화번호는 이번에 공개하지 않고 칸만 마련), U4(영문 서비스명 RunningPencil), U10(포인트·굿즈·코스북 제거), U14(법적 문서 `noindex` 해제, `/en/` 홈페이지 포함).
```

**행 내용 출처:** `01-RESEARCH.md:498-548`. 지켜야 할 것:
- 항목마다 D-12의 일곱 가지를 적는다: 질문, 근거, 권장안, 정하지 않았을 때의 기본 동작, 결정 주체, 막는 단계, 마감 단계. 표 한 줄에 다 넣으면 읽기 어려우므로 요약 표(번호·질문·결정 주체·막는 단계·마감) 아래에 항목별 소제목으로 근거·권장안·기본 동작을 푼다. 이 「표 + 항목별 풀이」 구성의 실제 예는 `01-RESEARCH.md:500-534`다(요약 표 다음에 `### U5 근거`, `### U6 근거`). `SUMMARY.md`에는 표만 있고 항목별 풀이는 없다.
- 대상: U2, U3, U5, U6, U7, U8, U9, U11, U13, 신규 「prod 리전」. U12는 「결정됨」(D-10·D-11·D-19).
- U6은 두 질문으로 나눈다(`01-RESEARCH.md:534`).
- 기본 동작 규칙: 법률 판단(U2·U3·U7)은 보수적인 쪽 + 「초안·법률 확인 필요」, 사실값(U11)은 기본값 없이 render-if-present.
- 끝에 「조사에서 새로 나온 항목」 구간을 둔다(N1·N3·N4·N5·N6·N7, `01-RESEARCH.md:538-548`, `:972-975`). N2는 결정이 아니라 사실이므로 데이터 목록에만 적는다.
- 완료 검사는 `01-RESEARCH.md:1040-1041`.

---

### `.planning/baseline/USER-TASKS.md` (utility — 사용자 작업 절차서, batch)

**Analog:** `.planning/research/STACK.md:213-226`(DNS 레코드 표) + `.planning/codebase/TESTING.md:103-130`(명령 블록과 풀이) — **모양만.**
`research/STACK.md`의 레코드 값은 ImprovMX 기준이고(`:203-207`) 이미 있는 레코드 두 개를 놓쳤다(`01-RESEARCH.md:945-946`). 값은 베끼지 않는다.

**DNS 레코드 표 형식** (`.planning/research/STACK.md:215-223` — 열: 호스트 | 유형 | 값 | 목적 | 비고. IP는 가림):
```markdown
| 호스트 | 유형 | 값 | 목적 | 비고 |
|--------|------|----|------|------|
| `@` | A ×4 | … | GitHub Pages | 이미 있음 |
| `www` | CNAME | `slimpumpkin.github.io` | `www` → 루트 자동 리디렉션 | 이미 있음 |
| `@` | TXT | `v=spf1 include:… ~all` | SPF | **`v=spf1` 레코드는 하나만.** 서비스가 둘 이상이면 `include:`를 한 레코드에 합칩니다 |
| `@` | TXT | `google-site-verification=…` | Search Console 도메인 속성 | 인증 뒤에도 지우지 않음. SPF와 별개의 TXT로 공존 가능 |
```
D-13의 열 이름은 「호스트·유형·값·용도」다. 서비스가 발급하는 값의 「값」 칸에는 「콘솔에서 복사」라고만 적는다.

**명령 블록 형식** (`.planning/codebase/TESTING.md:105`, `:119-123` — 굵은 제목, `bash` 펜스, 기대 결과를 주석으로, zsh·BSD 주의는 블록 위 문단에):
````markdown
아래 명령은 macOS(BSD `sed`/`grep`, zsh)에서 실제로 돌려 확인했다 (2026-11-14). …

**금지 표기 확인 (영문 서비스명, 이메일 주소):**
```bash
grep -rnE "…" --include='*.html' . | grep -v prepare/
# 출력이 없으면 통과
```
````
(이 블록의 `grep` 내용 자체는 이 단계가 고치는 대상이다. 여기서는 「제목 + 명령 + 기대 결과 주석」의 꼴만 가져온다.)

**순서 표 형식과 내용 출처:**
- 0~10단계 순서 표: `01-RESEARCH.md:600-612` (열: 순서 | 어디서 | 무엇을 | 값). DNS 방문은 두 번이다(1차: 인증 TXT·MX·SPF·Search Console TXT, 2차: DKIM). 한 표로 뭉치지 않는다(`01-RESEARCH.md:817-821`).
- 「보존할 기존 레코드」 표: `01-RESEARCH.md:554-562`. 지우는 레코드는 없다고 명시한다. 라우터용 A 레코드는 호스트 이름을 적지 않고 「앱 경로 라우터용 A 레코드 1개(가비아 화면에서 확인)」로 적는다(`01-RESEARCH.md:989`).
- 변경 전후 `dig` 기대 결과 표: `01-RESEARCH.md:629-637`, 명령 블록: `01-RESEARCH.md:874-881`(`${=q}` zsh 표기 포함).
- Workspace 값과 화면 경로: `01-RESEARCH.md:575-585`. 절차서에 옮길 때 원문을 다시 연다(`01-RESEARCH.md:1114`).
- `support@` 1순위(사용자 이메일 별칭)와 2순위(그룹) 분기: `01-RESEARCH.md:589-596`. `[ASSUMED]` 항목은 「사용자가 화면에서 확인」 단계로 풀어 쓴다.
- 가비아 입력 화면의 미확인 사항(루트 호스트 표기, DKIM 2048비트): `01-RESEARCH.md:620-625`.
- D-13의 나머지 작업: 외부 4곳 수신 시험과 기록 방법, 사업자 값(U11) 준비, 앱 화면 캡처(Phase 4), GitHub Pages 도메인 인증 상태 확인(`01-RESEARCH.md:995-998`), CLI 재로그인(`01-RESEARCH.md:977-980`).
- 작업마다 D-13의 다섯 가지를 적는다: 순서, 레코드 표, 전후 `dig`와 기대 결과, 끝났는지 확인하는 방법, 끝나면 Claude에게 넘길 것.
- 완료 검사는 `01-RESEARCH.md:1042`.

---

### `CLAUDE.md` (config — 사람이 쓴 정본)

**Analog:** 자기 자신. 문체는 **합니다체 문단 + 굵은 머리말로 시작하는 목록**이다. 마커(`<!-- GSD:… -->`)가 없는 파일이라 생성기가 건드리지 않는다. `Edit`로 직접 고친다.

**구간 순서** (현재): `# CLAUDE.md` → 안내 한 줄(3행) → `## Repository purpose` → `## Pages` → `## Local preview` → `## Architecture / styling notes` → `## Assets` → `## Content language` → `## Deploy`.
새 「이번 마일스톤 방침」 구간은 문서 맨 앞, 즉 3행의 안내 문장 다음과 `## Repository purpose` 앞에 둔다(D-01).

**표 형식** (`CLAUDE.md:17-22` — 구분선은 `|---|---|`, 경로는 백틱, 상태는 괄호):
```markdown
| 경로 | 용도 |
|---|---|
| `index.html` | 티저 랜딩 — 헤더, 히어로(쿼터뷰 지도 그림), 세 가지 이유(`#story`), 달려 보기(`#demo`), 출시 안내(`#get`), 푸터 |
| `privacy-policy/index.html` | 개인정보처리방침 (임시 게시본, `noindex`) |
```

**굵은 머리말 목록 형식** (`CLAUDE.md:55`, `:58`):
```markdown
- **다크 모드 없음.** 달려 보기 구간과 푸터만 의도적으로 어두운 바탕입니다.
- **이메일 수집 폼 없음.** 정적 호스팅이라 서버 처리가 불가능해 의도적으로 뺐습니다. 연락처 이메일도 표시하지 않습니다 (법적 페이지 포함).
```

**고칠 줄 (현재 문장):**
| 행 | 현재 | 처리 |
|----|------|------|
| 7 | `…모바일 앱 러닝펜슬(지도 위 GPS 아트 코스를 걷거나 달려 완주하면 코스 모양의 뱃지와 포인트를 모으고, 지역 코스북을 완성하고, 직접 그린 코스를 올리고, 포인트로 굿즈를 교환하는 앱)의 출시 전 티저 랜딩과…` | D-05. 맞출 문장은 `.planning/PROJECT.md:5`의 괄호 설명. 남길 기능의 근거는 `01-RESEARCH.md:730-742` |
| 9 | `- 빌드 시스템 없음 (no `package.json`, no bundler, no linter, no tests).` | 현재 상태 + 「Phase 2까지」 |
| 20-22 | `(임시 게시본, `noindex`)` | 현재 상태 + U14(Phase 6·7·8에서 해제) |
| 24 | `빌드 단계가 없어 공통 템플릿을 뽑을 수 없으니, …` | 현재 상태 + 「Phase 2에서 바뀜」 |
| 34-38 | `python3 -m http.server 8000` 안내 | 현재 상태 + 「Phase 2까지 유효」 |
| 44 | Tailwind CDN 런타임 모드 | 현재 상태 + 「Phase 3까지」 |
| 58 | 위 발췌의 둘째 문장 | 날짜 붙은 상태 문장. 「이메일 수집 폼 없음」은 유지 |
| 69 | `본문·`<html lang>` 모두 `ko`입니다.` | 날짜 붙은 상태 문장 |
| 71 | `…영문 `RunningPencil`은 쓰지 않고, `runningpencil.com`은 도메인 표기로만 남깁니다.` | 날짜 붙은 상태 문장 + `.planning/baseline/NAMES.md` 경로 |

전수 목록은 `01-RESEARCH.md:687-699`.

**방침 표의 형식 출처:** `01-CONTEXT.md:202-212`의 미리보기(열: 방침 | 적용 | 상태) + D-02의 「이유」「출처 경로」 열. 항목은 성공 기준 5의 여섯 가지 + U14로 일곱 개다. 그 아래에 D-03의 작업 규칙을 줄여 옮기고 원본 경로(`.planning/ROADMAP.md` Ground Rules, `:7-17`)를 적는다.

**옮길 작업 규칙의 원문** (`.planning/ROADMAP.md:12-13`, `:15-16`):
```markdown
- 기존 URL `/privacy-policy/`, `/terms/`, `/data-deletion/`은 경로를 바꾸지 않고 리디렉션(redirect)도 걸지 않습니다. …
- 리팩터·시각 변경·내용 변경을 한 단계나 한 커밋에 섞지 않습니다.
- 사용자가 줄 사실값(사업자 정보, 지원 이메일, 보호책임자)은 추측해서 채우지 않습니다. 값이 없으면 render-if-present로 행·문단을 숨깁니다. …
- 「추후 기재」 같은 자리표시 값, JS 언어 자동 리디렉션, `robots.txt` 차단, `.nojekyll`, Jekyll i18n 플러그인은 쓰지 않습니다.
```

**주의 — 방침 표의 문구를 `.planning/PROJECT.md:103`, `:106`, `:107`에서 베끼지 않는다.** 그 세 행은 「기존 「…」 방침을 뒤집음」 꼴로 옛 규칙을 이름으로 부른다. D-02는 옛 문장을 인용하지 말고 「이전 방침을 뒤집음」이라고만 적으라고 하고, 107행의 문구는 성공 기준 5의 정규식(`01-RESEARCH.md:889`)에 걸린다. 방침 표의 문장은 `01-CONTEXT.md:204-212`와 `01-RESEARCH.md:296-297`의 예시를 따른다.

---

### `.claude/CLAUDE.md` (config — 생성본)

**Analog:** 자기 자신. 마커 블록은 원본에서 다시 만들어지고, 마커 밖 글은 재생성에 남는다(`01-RESEARCH.md:758-774`).

**파일 머리** (`.claude/CLAUDE.md:1-5` — 「이번 마일스톤 방침」 구간은 이 첫 마커 **위**에 둔다):
```markdown
<!-- GSD:project-start source:PROJECT.md -->

## Project

**러닝펜슬 웹사이트 (runningpencil.com)**
```

**블록 경계 형식** (`.claude/CLAUDE.md:21-25`):
```markdown
<!-- GSD:project-end -->

<!-- GSD:stack-start source:codebase/STACK.md -->

## Technology Stack
```

**고칠 줄** (`.claude/CLAUDE.md:164-168`, conventions 블록 안 — `CONVENTIONS.md:142-146`의 사본):
```markdown
- `<html lang="ko">`, 본문은 한국어.
- 서비스 이름은 한글 **러닝펜슬**만 쓴다 (제목, meta, 매니페스트, 워드마크, 본문). 영문 `RunningPencil`은 쓰지 않는다. `runningpencil.com`은 도메인 표기에만 쓴다.
- 운영 회사는 **슬림펌킨**: 저작권 표기, 푸터 운영 안내 문장, 법적 페이지의 `(이하 "회사")` 주체.
- 연락처 이메일·이메일 수집 폼을 넣지 않는다.
- 법적 페이지 3종은 `<meta name="robots" content="noindex">`를 유지한다.
```
이 줄들은 이 파일에서 직접 고치지 않는다. 원본을 고친 뒤 `gsd-tools generate-claude-md`(`--auto` 없이)로 다시 만든다. 블록별로 옮겨지는 줄의 규칙은 `01-RESEARCH.md:750-756`.

**방침 구간의 내용:** 루트 `CLAUDE.md`의 방침 표와 같아야 한다(두 파일이 함께 컨텍스트에 실린다, `01-RESEARCH.md:764`). 이 파일의 제목 깊이는 `## Project`, `## Technology Stack`처럼 `##`가 최상위다.

**재생성 뒤 확인:** `git diff .claude/CLAUDE.md`에서 바뀐 줄이 conventions 블록의 해당 줄과 마커 밖 구간뿐이어야 한다(`01-RESEARCH.md:805-809`).

---

### `.planning/codebase/CONVENTIONS.md` (config — 생성 원본)

**Analog:** 자기 자신. 문체는 **한다체 목록 항목**이다. conventions 블록은 제목·목록·표 줄만 옮기고 문단은 버리므로(`01-RESEARCH.md:754`, `:765`), 고친 문장은 반드시 `- `로 시작하는 목록 항목이어야 생성본에 실린다.

**머리말과 맺음 줄** (`.planning/codebase/CONVENTIONS.md:1-7`, `:156-158` — 그대로 둔다):
```markdown
---
last_mapped_commit: c4cb26d754e9e666c957e31fa7e559f918b425bb
last_mapped_at: 2026-11-14
---
# Coding Conventions

**Analysis Date:** 2026-11-14
```
```markdown
---

*Convention analysis: 2026-11-14*
```

**고칠 구간** (`.planning/codebase/CONVENTIONS.md:140-147`):
```markdown
## Content & Naming Rules

- `<html lang="ko">`, 본문은 한국어.
- 서비스 이름은 한글 **러닝펜슬**만 쓴다 (제목, meta, 매니페스트, 워드마크, 본문). 영문 `RunningPencil`은 쓰지 않는다. `runningpencil.com`은 도메인 표기에만 쓴다.
- 운영 회사는 **슬림펌킨**: 저작권 표기, 푸터 운영 안내 문장, 법적 페이지의 `(이하 "회사")` 주체.
- 연락처 이메일·이메일 수집 폼을 넣지 않는다.
- 법적 페이지 3종은 `<meta name="robots" content="noindex">`를 유지한다.
- 새 마크다운 문서를 추가하면 `_config.yml`의 `exclude`에 적는다.
```
142·143·145·146행을 고친다. 처리 방침은 `01-RESEARCH.md:703-709`: 145행은 「이메일 수집 폼 금지」(유지)와 「연락처 이메일」(상태 문장)으로 나눈다. 144·147행은 그대로다. 153행의 옛 커밋 메시지 예시는 이력의 사실이라 건드리지 않는다(`01-RESEARCH.md:899`).

**고친 문장의 꼴** (`01-RESEARCH.md:296-297` — 이 파일에서는 끝을 「…다」로 맞춘다):
```markdown
- 현재 페이지는 모두 `<html lang="ko">`다 (2026-11 기준). Phase 9에서 `/en/` 아래 영문판(`lang="en"`)이 생긴다.
- 현재 사이트에는 연락처 이메일이 없다 (2026-11 기준). 이메일 게이트(Phase 5)가 열리면 지원 이메일을 푸터와 법적 문서에 넣는다. 그전에는 주소를 HTML·`_data`에 넣지 않는다.
```

---

### `.planning/codebase/TESTING.md` (test — 수동 점검 목록)

**Analog:** 자기 자신.

**고칠 점검 항목** (`.planning/codebase/TESTING.md:64-65` — 번호 목록 + 굵은 제목 + 들여쓴 `- ` 항목):
```markdown
7. **콘텐츠 규칙**
   - `RunningPencil` 영문 표기·이메일 주소가 새로 들어가지 않았는지, 법적 페이지 `noindex` 유지.
```

**고칠 명령 블록** (`.planning/codebase/TESTING.md:119-123`):
````markdown
**금지 표기 확인 (영문 서비스명, 이메일 주소):**
```bash
grep -rnE "RunningPencil|@[a-z0-9.-]*\.(com|kr)" --include='*.html' . | grep -v prepare/
# 출력이 없으면 통과
```
````
처리 방침은 `01-RESEARCH.md:713-716`: 영문명을 금지 대상에서 빼고, 「이메일 게이트 전에는 HTML·`_data`에 이메일 주소 없음」 검사로 바꾼다. 제목 줄과 명령 줄 둘 다 성공 기준 5의 정규식(`01-RESEARCH.md:894`, `:896`)에 걸리므로 둘 다 바꿔야 한다.

**유지할 형식:** 명령 블록 위의 환경 주의 문단(`:105`), 블록 아래의 `- ` 풀이(`:116-117`), 「출력이 없으면 통과」 주석.

---

### `.planning/codebase/CONCERNS.md` (config — 우려 사항 맵)

**Analog:** 자기 자신. 생성본에 들어가지 않지만 계획 입력으로 읽힌다.

**항목 형식 1** (`.planning/codebase/CONCERNS.md:55-59` — 굵은 제목 + `Risk` / `Files` / `Current mitigation` / `Recommendations`). 고칠 곳은 56행의 한 문장이다:
```markdown
**개인정보처리방침 필수 항목 누락 가능성:**
- Risk: … 프로젝트 방침상 연락처 이메일을 의도적으로 표시하지 않음 (`CLAUDE.md`). …
- Files: `privacy-policy/index.html:97-136`, …
- Current mitigation: 세 페이지 모두 "임시 게시본" 명시 (…), `noindex` (각 파일 line 10).
- Recommendations: 정식 출시 전 법률 검토로 본문 확정, 연락 수단(최소 문의 채널) 결정.
```

**항목 형식 2** (`.planning/codebase/CONCERNS.md:122-124` — `Problem` / `Blocks`). 고칠 곳은 123행이다:
```markdown
**문의 채널:**
- Problem: 이메일·폼 모두 없음 (정적 호스팅·의도적 결정).
- Blocks: 법적 페이지의 권리 행사·삭제 요청 수단이 앱 밖에서는 제공되지 않음 (위 Security 참고).
```
판단 근거는 `01-RESEARCH.md:724-725`. 58행(「임시 게시본」·`noindex`)과 128행은 현재 상태 설명이라 둘 수 있다. 이 파일의 문체는 「…음/함」으로 끝나는 개조식이다.

---

### `.planning/ROADMAP.md` (config — 계획 문서, D-21)

**Analog:** 자기 자신. 문체는 합니다체다. `roadmap` 핸들러에는 본문 문장을 고치는 하위 명령이 없으므로 `Edit`로 고치고 `gsd-tools roadmap validate`로 구조를 확인한다(`01-RESEARCH.md:321`).

**고칠 줄 1 — Phase 5 External gates** (`.planning/ROADMAP.md:113-115`, 들여쓰기 없는 `- ` 목록):
```markdown
- 사용자 DNS 작업(가비아): Search Console TXT와 ImprovMX MX 2개 + SPF 1개를 한 번에 추가합니다. 같은 작업에서 `_github-pages-challenge-SlimPumpkin` TXT(도메인 탈취 방지, 요구사항 밖 권장 항목)도 넣고, U12 결과 `support@` 주소로 답장을 보내기로 하면 그 발신 서비스의 DKIM 레코드도 함께 넣습니다. 기존 A 레코드와 `www` CNAME은 그대로 두고, SPF는 하나로 합칩니다. 변경 전후 `dig` 결과를 기록합니다. Phase 1이 끝나면 바로 시작할 수 있습니다.
- 사용자 작업: ImprovMX 설정, Search Console 소유권 확인.
- 사용자 결정: U11(사업자등록증 그대로의 사업자 값, 자택 주소 공개 부담), U12(지원 주소와 업무 메일 서비스 종류, `support@`로 답장할지).
```
바꿀 내용: ImprovMX → Workspace 사용자 별칭 도메인, 「한 번에」 → 1차·2차 방문(`01-RESEARCH.md:817-820`), GitHub Pages 인증 TXT는 「추가」가 아니라 「이미 있음 — 인증 상태 확인」, 보존할 기존 레코드에 두 개 추가(`01-RESEARCH.md:566-569`), U12는 결정됨. 117행의 Research flag 문장(「U12 결과 업무 메일이 Google Workspace이면 보조 도메인 방식을 확인합니다」)도 같은 전제이므로 함께 본다.

**고칠 줄 2 — Phase 8 Notes** (`.planning/ROADMAP.md:164`의 첫 문장):
```markdown
**Notes**: 위치약관 경로는 Phase 1 URL 대장을 따릅니다(후보 `/location-terms/`). …
```
「후보」를 확정값으로 바꾼다(D-15).

**고칠 줄 3 — External Gates 표** (`.planning/ROADMAP.md:203`, `:208`):
```markdown
| 가비아 DNS 레코드(Search Console TXT, ImprovMX MX·SPF. 권장: GitHub Pages 인증 TXT, 필요하면 DKIM) | 사용자 | Phase 5 |
| U12 지원 주소와 업무 메일 서비스 | 사용자 | Phase 5 |
```
U12가 결정됐으므로 208행은 표에서 빼고 218행의 「이미 결정된 항목」 문장(위 DECISIONS 절의 발췌)에 같은 괄호 꼴로 넣는 것이 기존 형식과 맞다. 표의 열(게이트 | 누가 | 막는 단계)과 다른 행은 그대로 둔다.

완료 검사: `grep -n 'ImprovMX' .planning/ROADMAP.md .planning/STATE.md`가 0건 또는 「채택하지 않음」 문맥만(`01-RESEARCH.md:1043`).

---

### `.planning/STATE.md` (store — GSD 상태, D-21)

**Analog:** 자기 자신. 머리의 YAML front matter(1-17행)와 `## Current Position`·`## Session Continuity`는 GSD 도구가 관리하므로 손으로 고치지 않는다.

**고칠 구간** (`.planning/STATE.md:72-83` — 소제목 문장 + `- ` 목록, 한 항목 끝에 `→ Phase N`):
```markdown
### Blockers/Concerns

사용자 외부 작업(단계를 막음):
- 가비아 DNS 레코드 추가(Search Console TXT, ImprovMX MX 2개 + SPF 1개, `_github-pages-challenge-SlimPumpkin` TXT)와 메일 수신 시험 → Phase 5 (이메일 게이트, Phase 6·7 커밋의 전제)
- Apple Developer에 지원 메일 발신 도메인 등록, 릴레이 답장 시험 → Phase 10
- 실제 앱 화면 캡처(출시 범위 기능만) → Phase 4

사용자·법률 결정(Phase 1에서 결정 목록으로 넘김):
- U11 사업자 값과 영문 법인명 → Phase 5·8·9 / U12 지원 주소·메일 서비스 → Phase 5
```
75행은 열린 채로 남는 항목 안의 일부 문구만 바뀌고, 80행은 한 줄에 U11(열림)과 U12(결정됨)가 `/`로 묶여 있다. 그래서 `gsd-tools state resolve-blocker`·`add-blocker`가 맞지 않을 수 있다(`01-RESEARCH.md:315`, A15). 핸들러를 먼저 시도하고, 맞지 않으면 `Edit`로 고친 뒤 `gsd-tools state validate`로 확인한다.

**결정 기록 형식** (`.planning/STATE.md:58-65` — `[출처]: 내용` 꼴. `state add-decision` 핸들러 대상):
```markdown
- [Roadmap]: DNS·메일·Search Console은 Phase 5에 묶고, 이메일 게이트(외부 수신 시험)가 열려야 Phase 5가 끝남. …
```

---

### `.planning/PROJECT.md` (config — Key Decisions, D-21)

**Analog:** 자기 자신.

**표 형식** (`.planning/PROJECT.md:98-99`, `:104` — 열 3개, Outcome은 `— Pending`):
```markdown
| Decision | Rationale | Outcome |
|----------|-----------|---------|
| 지원 메일은 도메인 주소 → 메일 라우팅 → 슬림펌킨 업무 메일 | 별도 메일함 없이 도메인 주소를 공개 | — Pending |
```
104행이 U12의 자리다. 이 행을 Workspace 결정(사용자 별칭 도메인, `support@runningpencil.com`, 지원 주소로 답장)에 맞게 고치거나 그 아래에 새 행을 더한다. `/location-terms/` 확정(D-15)도 113행 근처에 반영할 수 있다.

**맺음 줄** (`.planning/PROJECT.md:134-135` — 고치면 날짜와 계기를 갱신):
```markdown
---
*Last updated: 2026-11-14 after requirements definition*
```

**주의:** Key Decisions는 생성본의 project 블록에 들어가지 않는다(블록은 `What This Is`·`Core Value`·`Constraints`만 옮긴다, `01-RESEARCH.md:752`, `:806`). 따라서 이 수정은 `.claude/CLAUDE.md`의 diff를 만들지 않아야 한다. `## What This Is`(5행)와 `## Constraints`는 건드리지 않는다.

## Shared Patterns

### 근거 붙은 행 + 「미확인」과 확인 방법의 짝
**Source:** `01-RESEARCH.md:273-289` (Pattern 1·2), 표기 형식은 `.planning/codebase/CONCERNS.md:13-17`
**Apply to:** `DATA-INVENTORY.md` 전 행, `DECISIONS.md`의 근거 칸, `NAMES.md`·`URLS.md`의 근거 열
- 근거는 `경로:행` 꼴로 적고, 코드가 아니면 종류를 적는다(「dev 설정 기록(문서)」「dev CLI」「공식 문서」).
- 모르는 칸은 비우지 않고 「미확인」이라고 쓰고, 누가 어디서 확인하는지를 짝지어 적는다.
- dev에서 확인한 값에는 「근거: dev」를 붙인다(D-08).

### 날짜 붙은 상태 문장
**Source:** `01-RESEARCH.md:291-298` (Pattern 3)
**Apply to:** `CLAUDE.md:9`, `:20-24`, `:34-38`, `:44`, `:58`, `:69`, `:71` / `CONVENTIONS.md:142-146` / `TESTING.md:65` / `CONCERNS.md:56`, `:123`
```markdown
- 현재 페이지는 모두 `<html lang="ko">`다 (2026-11 기준). Phase 9에서 `/en/` 아래 영문판(`lang="en"`)이 생긴다.
```
- 꼴: 「현재 X (2026-11 기준). Phase N에서 Y로 바뀜」.
- 옛 규칙 문장은 인용하지 않는다. 필요하면 「이전 방침을 뒤집음」이라고만 적는다(D-02).

### 파일마다 다른 문체
**Source:** 각 파일의 현재 본문
**Apply to:** 수정하는 여덟 파일 전부

| 파일 | 문체 |
|------|------|
| 루트 `CLAUDE.md`, `.planning/ROADMAP.md`, `.planning/PROJECT.md`, `.planning/research/*.md` | 합니다체 |
| `.planning/codebase/CONVENTIONS.md`, `TESTING.md` (그리고 그 사본인 `.claude/CLAUDE.md`의 블록) | 한다체 목록 |
| `.planning/codebase/CONCERNS.md`, `.planning/STATE.md`의 Blockers | 「…음/함」 개조식 |

새 기준 문서 다섯 개는 연구 문서와 같은 합니다체 또는 CONTEXT와 같은 한다체 가운데 하나로 통일한다(계획자가 정함). 공통 규칙: 화면 구간·문서 이름은 「」로 감싸고, 기술 용어는 영어를 병기하고(예: 별칭 도메인(user alias domain)), 식별자·경로는 백틱으로 감싼다.

### 원본 먼저, 생성본 나중
**Source:** `01-RESEARCH.md:300-302` (Pattern 4), `:746-774` (생성기 동작)
**Apply to:** `CONVENTIONS.md` → `.claude/CLAUDE.md` → 루트 `CLAUDE.md`
1. `CONVENTIONS.md`(와 `TESTING.md`·`CONCERNS.md`)를 먼저 고친다.
2. `.claude/CLAUDE.md`의 첫 마커 위에 방침 구간을 넣는다.
3. `gsd-tools generate-claude-md`를 `--auto` 없이 돌린다. 시험이 필요하면 `--output`으로 저장소 밖 사본을 가리킨다.
4. `git diff .claude/CLAUDE.md`로 바뀐 줄이 예상 범위인지 확인한다. 아니면 되돌리고 원본과 생성본의 같은 줄을 손으로 고친다.
5. 루트 `CLAUDE.md`를 `Edit`로 고친다. 방침 표는 두 파일에서 같아야 한다.

### 옛 문장 검사와 새 방침 검사
**Source:** `01-RESEARCH.md:884-912`
**Apply to:** BASE-05의 모든 작업의 완료 조건
- 검사 대상 파일은 다섯 개로 고정한다: `CLAUDE.md`, `.claude/CLAUDE.md`, `.planning/codebase/CONVENTIONS.md`, `TESTING.md`, `CONCERNS.md`(`01-RESEARCH.md:776-783`).
- 정규식 아홉 줄은 낱말이 아니라 옛 문장의 꼴을 본다. 수정 전에는 17줄이 걸리고(`01-RESEARCH.md:899`), 수정 뒤에는 0건이어야 한다.
- `.planning/ROADMAP.md`, `PROJECT.md`, `REQUIREMENTS.md`, `.planning/phases/`, `.planning/research/`, `.planning/baseline/`은 검사 대상이 아니다. 이 문서(`01-PATTERNS.md`)가 옛 문장을 발췌한 것도 그래서 검사에 걸리지 않는다.

### 공개 저장소 가림 규칙과 누출 검사
**Source:** `01-RESEARCH.md:793-797` (Pitfall 2), `:926-933` (검사 명령), `:1078-1089`
**Apply to:** `.planning/baseline/` 아래 다섯 문서, `CLAUDE.md`, `.claude/CLAUDE.md`
- 적지 않는 것: IP 주소, 프로젝트 번호, 앱 ID, 실제 계정 이메일, DNS 인증 토큰 값, DKIM 공개키, 라우터 호스트 이름, 사업자 사실값.
- 서비스가 발급하는 값은 「콘솔에서 복사」라고만 적는다(D-13). 기억에 기대어 값을 적지 않는다.
- 적어도 되는 것: `support@runningpencil.com`(`.planning/` 문서에만, D-19), 컬렉션·필드 이름, 리전 이름.
- 문서를 만든 작업마다 커밋 전에 `01-RESEARCH.md:930-931`의 검사를 돌린다. 라우터 호스트 이름은 정규식이 잡지 않으므로 사람이 확인한다.

### 읽기 전용 경계
**Source:** `01-CONTEXT.md:17-19`, D-06, `01-RESEARCH.md:1088`
**Apply to:** 모든 작업
- 앱 저장소는 읽기만 한다. dev 프로젝트 CLI는 `list`·`describe`·`get` 계열만 쓴다(`01-RESEARCH.md:839-869`). 자격 증명이 만료돼 있으므로 사용자 재로그인이 전제다(`01-RESEARCH.md:787-791`).
- 범위 검사: `01-RESEARCH.md:1047-1048`(라이브 사이트 파일과 앱 저장소가 바뀌지 않았는지).

### 커밋 메시지
**Source:** `git log` (최근 커밋), `.planning/codebase/CONVENTIONS.md:151-154`
**Apply to:** 모든 커밋
```text
docs(01): 1단계 연구 문서 작성 (데이터 목록 근거·DNS 절차·CLAUDE.md 갱신 근거)
docs(01): 1단계 CONTEXT 보강 (계획 문서 갱신 결정·근거 경로 정정)
docs(state): 1단계 논의 세션 기록
```
- Conventional Commits, prefix와 scope는 영어(`docs(01)`), 제목은 한국어.
- 커밋은 `gsd-tools query commit`으로 한다(`commit_docs: true`, `01-RESEARCH.md:319`).
- 문서마다 따로 커밋한다(다섯 기준 문서의 수명이 다르다, `01-RESEARCH.md:271`). 푸시는 사용자 확인 뒤에 한다.

## No Analog Found

형식이 같은 기존 문서가 없는 파일이다. 계획자는 `01-RESEARCH.md`의 패턴을 쓴다.

| File | Role | Data Flow | Reason |
|------|------|-----------|--------|
| `.planning/baseline/NAMES.md` | config (이름 표) | transform | 「항목 · 값 · 지금 채우는가 · 들어갈 곳 · 근거」 꼴의 사실값 표가 저장소에 없다. `01-RESEARCH.md:643-656`의 표를 그대로 쓴다 |
| `.planning/baseline/DATA-INVENTORY.md` | model (데이터 목록) | transform | 필드 단위 개인정보 목록이 저장소에 없다. 열과 행 예시는 `01-RESEARCH.md:273-289`, 행 내용은 근거표 A~H(`:343-471`) |

부분 유사물만 있는 파일(모양은 가져오되 내용은 `01-RESEARCH.md`에서): `URLS.md`, `DECISIONS.md`, `USER-TASKS.md`.

## Metadata

**Analog search scope:** 저장소의 추적 파일 전체 가운데 문서 — `CLAUDE.md`, `.claude/CLAUDE.md`, `_config.yml`, `.gitignore`, `.planning/{PROJECT,REQUIREMENTS,ROADMAP,STATE}.md`, `.planning/config.json`, `.planning/codebase/*.md`, `.planning/research/*.md`. 앱 저장소와 `.planning/research/.cache/`(추적 안 됨)는 유사물 후보에서 뺐다.
**Files scanned:** 14 (전체 또는 해당 구간을 읽음)
**Tracked-source gate:** 유사물로 이름을 적은 경로는 모두 `git ls-files`에 나온다. gitignore된 미러 경로는 없다.
**Line numbers:** 2026-11-14 작업 트리 기준(HEAD `455f535`). 실행자는 고치기 직전에 해당 줄을 다시 확인한다.
**Pattern extraction date:** 2026-11-14
