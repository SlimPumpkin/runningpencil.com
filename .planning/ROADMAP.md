# Roadmap: 러닝펜슬 웹사이트

## Overview

이번 마일스톤(1단계: 티저 유지 + 심사 대응)은 빌드 없는 GitHub Pages 정적 사이트를 소셜 로그인 제공자 6곳(카카오·네이버·Google·Apple·Facebook·LINE)과 스토어 2곳(App Store·Google Play)의 심사자가 확인할 수 있는 공식 웹사이트로 정비합니다. 순서는 「기준 → 리팩터(refactor) → 시각 → 내용 → 번역 → 제출」입니다. 먼저 이름 표·URL 대장·데이터 목록·결정 목록으로 기준을 세우고 `CLAUDE.md` 방침을 바꿉니다(Phase 1). 그다음 출력이 바뀌지 않는 Jekyll 공유 셸(shared shell) 전환(Phase 2)과 모양이 바뀌지 않는 정적 CSS 전환(Phase 3)으로 구조를 다집니다. 이어 홈페이지 소개를 앱의 실제 범위로 고치고(Phase 4), 사업자 정보를 표시하고 실제로 받히는 지원 이메일을 열어 이메일 게이트(email gate)를 통과합니다(Phase 5). 그 위에서 한국어 법적 문서를 데이터 목록 기준으로 문서별로 다시 쓰고(Phase 6~8), 국문이 확정된 뒤 영문판을 붙이고(Phase 9), 콘솔별 제출 체크리스트와 전체 URL 점검으로 마칩니다(Phase 10). 사용자·법률 값이 늦게 와도 구조 작업은 먼저 배포할 수 있도록, 값이 필요한 지점을 각 단계의 `External gates`에 적었습니다.

## Ground Rules

모든 단계에 적용합니다.

- `main` 푸시가 곧 배포입니다(CI 없음). 모든 단계는 그대로 라이브에 올라가도 되는 상태로 끝납니다.
- 기존 URL `/privacy-policy/`, `/terms/`, `/data-deletion/`은 경로를 바꾸지 않고 리디렉션(redirect)도 걸지 않습니다. 배포할 때마다 세 URL이 200과 같은 문서 제목을 돌려주는지 확인합니다. 마일스톤 전체 URL 확인은 Phase 10에서 합니다.
- 리팩터·시각 변경·내용 변경을 한 단계나 한 커밋에 섞지 않습니다.
- Phase 2 이후에는 푸시 전에 로컬 Jekyll 3.10.0 빌드가 성공하는지 확인합니다.
- 사용자가 줄 사실값(사업자 정보, 지원 이메일, 보호책임자)은 추측해서 채우지 않습니다. 값이 없으면 render-if-present로 행·문단을 숨깁니다. 빠지면 안 되는 조항이 있는 페이지는 값이 올 때까지 커밋을 보류합니다.
- 「추후 기재」 같은 자리표시 값, JS 언어 자동 리디렉션, `robots.txt` 차단, `.nojekyll`, Jekyll i18n 플러그인은 쓰지 않습니다.
- 방침이나 구조를 바꾸는 단계는 그 단계 안에서 `CLAUDE.md`도 함께 고칩니다.

## Phases

**Phase Numbering:**
- Integer phases (1, 2, 3): Planned milestone work
- Decimal phases (2.1, 2.2): Urgent insertions (marked with INSERTED)

Decimal phases appear between their surrounding integers in numeric order.

- [x] **Phase 1: 기준표와 방침 정비 (Ground Truth & Policy Reset)** - 이름 표·URL 대장·데이터 목록·결정 목록을 만들고 `CLAUDE.md` 방침을 바꾼다 (completed 2026-11-15)
- [x] **Phase 2: Jekyll 공유 셸 도입 (Shared Shell Refactor)** - 공통 블록을 한 곳으로 모으되 사이트 출력은 그대로 둔다 (completed 2026-11-16)
- [x] **Phase 3: 법적 페이지 정적 스타일 전환 (Tailwind CDN Removal)** - Tailwind Play CDN을 정적 CSS로 바꾸되 모양은 그대로 둔다 (completed 2026-11-17)
- [x] **Phase 4: 홈페이지 서비스 소개 정정 (Landing Content Fix)** - 앱에 없는 기능 설명을 빼고 실제 앱 화면을 보여 준다 (completed 2026-11-19)
- [x] **Phase 5: 사업자 정보와 지원 연락 경로 (Business Info & Support Contact)** - 푸터 사업자 정보, `/support/`, 실제로 받히는 지원 이메일(이메일 게이트) (completed 2026-11-20)
- [ ] **Phase 6: 데이터 삭제 안내 재작성 (Data Deletion Rewrite)** - 앱 없이 웹에서 삭제를 요청하는 경로와 삭제·보존 데이터 안내
- [ ] **Phase 7: 개인정보처리방침 재작성 (Privacy Policy Rewrite)** - 데이터 목록 기준의 처리방침(위탁·국외 이전·보호책임자·제공자별 수신 항목)
- [ ] **Phase 8: 이용약관과 위치기반서비스 이용약관 (Terms & Location Terms)** - 약관 재작성, 위치약관 신설, 법적 페이지 정식 게시
- [ ] **Phase 9: 영문판 (English Versions)** - `/en/` 홈페이지와 영문 법적 문서·지원 페이지, 언어 전환
- [ ] **Phase 10: 제출 준비와 최종 점검 (Submission Readiness)** - 콘솔별 제출 체크리스트와 전체 URL 점검

## Phase Details

### Phase 1: 기준표와 방침 정비 (Ground Truth & Policy Reset)
**Goal**: 운영자와 이후 모든 단계가 같은 기준(이름 표·URL 대장·데이터 목록·결정 목록)을 쓰고, `CLAUDE.md`가 이번 마일스톤의 방침을 설명해 다음 작업 세션이 결정을 되돌리지 않는다
**Depends on**: Nothing (first phase)
**Requirements**: BASE-01, BASE-02, BASE-03, BASE-04, BASE-05
**Success Criteria** (what must be TRUE):
  1. 운영자는 이름 표 하나에서 한글·영문 서비스명(러닝펜슬 / RunningPencil), 사업자등록증 그대로의 상호, 영문 법인명을 확인한다. 사용자가 아직 주지 않은 값은 빈칸이고, 추측해서 채운 값은 없다
  2. 운영자는 URL 대장 하나에서 사이트의 모든 공개 URL(홈, 기존 3개, `/support/`, 위치약관, `/en/` 5개)을 `https://runningpencil.com/…/` 형식(apex·https·끝 슬래시)으로 보고, URL마다 등록할 콘솔 필드를 확인한다
  3. 운영자는 데이터 목록에서 개인정보 항목마다 출처·목적·저장 위치(리전)·수탁자·국외 이전·보유 기간·삭제 방식을 앱 저장소의 파일 근거와 함께 확인하고, 확인하지 못한 칸은 「미확인」으로 표시돼 있다
  4. 운영자는 결정 목록(U2·U3·U5~U9·U11~U13)과 사용자가 할 외부 작업 목록(가비아 DNS 레코드 표, 메일 수신 시험 절차, 사업자 값, 앱 화면 캡처)을 받아, 항목마다 어느 단계를 막는지 안다
  5. `CLAUDE.md`가 지원 이메일 공개, 사업자 정보 표시, 영문명 RunningPencil, 한국어+영어, Jekyll 빌드 전환, 포인트·굿즈·코스북 제거를 현재 방침으로 설명하고, 「연락처 미표시」「RunningPencil 쓰지 않음」「ko 전용」 같은 옛 규칙 문장이 남아 있지 않다
**Plans**: 10/10 plans complete

Plans:
- [x] 01-09-PLAN.md
- [x] 01-10-PLAN.md

**Wave 1**
- [x] 01-01-PLAN.md — 이름 표와 URL 대장, 영문 서비스명 방침 한 줄을 CLAUDE.md까지 통과 (tracer)

**Wave 2** *(blocked on Wave 1 completion)*
- [x] 01-02-PLAN.md — 사용자 작업 절차서 (가비아 DNS·Workspace·수신 시험, 작업 0~12)
- [x] 01-03-PLAN.md — 데이터 목록 1부 (머리, 계정·프로필, 제공자별 수신 항목, 위치·기록·코스·뱃지, 외부 요청)
- [x] 01-04-PLAN.md — 결정 목록 (열린 결정 11개, 결정된 메일 서비스, 조사에서 새로 나온 항목 N1~N7)
- [x] 01-06-PLAN.md — CLAUDE.md 방침 표 일곱 행과 작업 규칙, 옛 규칙 문장 0줄

**Wave 3** *(blocked on Wave 2 completion)*
- [x] 01-05-PLAN.md — 데이터 목록 2부 (SDK·서버 보조, 탈퇴 처리, 리전·보존 기간, 확인할 것)
- [x] 01-07-PLAN.md — 계획 문서 정합 (ROADMAP·STATE·PROJECT에 메일 결정·DNS 두 번 방문·위치약관 경로 반영, 연구 문서 메모)

**Wave 4** *(blocked on Wave 3 completion)*
- [x] 01-08-PLAN.md — dev 프로젝트 읽기 전용 CLI 조회 (사용자 재로그인 뒤, 건너뛸 수 있음)

**UI hint**: no
**External gates**: 없음. Claude만으로 끝낼 수 있습니다. 앱 저장소(`~/dv/woody/running_pencil`)는 읽기만 합니다.
**Research flag**: 예. 데이터 목록을 만들려면 Firebase Functions·Firestore·Storage의 리전, OSRM VM 리전, Analytics·Crashlytics 보존 기간, Facebook SDK 자동 이벤트 전송, 비공개 코스의 탈퇴 처리, Email/Password 가입 경로(U5의 근거)를 확인해야 합니다.
**Notes**: 산출물은 `.planning/` 아래 기준 문서와 `CLAUDE.md`뿐입니다. 둘 다 배포 제외 대상이라 라이브 사이트는 바뀌지 않습니다. 가비아 DNS 레코드 표를 이 단계에서 넘기므로, 사용자는 이 단계가 끝나면 Phase 5의 DNS·메일 작업을 Phase 2~4와 병행해 시작할 수 있습니다.

### Phase 2: Jekyll 공유 셸 도입 (Shared Shell Refactor)
**Goal**: 운영자가 head 링크·「공통」 CSS·헤더·푸터를 한 곳에서 고치면 모든 페이지에 반영되고, 이 전환으로 방문자가 보는 사이트 출력은 바뀌지 않는다
**Depends on**: Phase 1
**Requirements**: SHELL-01, SHELL-02, SHELL-03
**Success Criteria** (what must be TRUE):
  1. 로컬 Jekyll 3.10.0 빌드가 성공하고, `_site/`의 네 문서(`/`, `/privacy-policy/`, `/terms/`, `/data-deletion/`)를 전환 전 HTML과 공백 정규화 diff로 비교하면 전환 커밋(법적 3종, 랜딩) 시점에는 차이가 0이다. 단계를 마친 뒤의 출력은 전환 전과 「공통」 CSS 머리 주석 한 줄만 다르고(D-06에서 승인한 예외), 주석을 지운 뒤 비교하면 차이가 0이다
  2. 공통 블록(head 링크, 「공통」 CSS, 헤더, 푸터)이 `_includes`/`_layouts`에 한 벌만 있고, 그중 하나를 시험 삼아 바꾸면 네 문서의 빌드 결과가 모두 바뀐다
  3. 운영자는 `CLAUDE.md`에 적힌 명령(Jekyll 3.10.0을 고정한 Gemfile)으로 실제 배포와 같은 빌드의 로컬 미리보기를 띄우고, 푸시 전에 빌드 성공을 확인한다. `python3 -m http.server` 안내는 남아 있지 않다
  4. 라이브에서 `/CLAUDE.md`, `/README.md`, `/Gemfile`, `/Gemfile.lock`, `vendor/`·`.planning/`·`prepare/` 아래 파일이 404이고, 기존 네 URL은 200과 전환 전과 같은 `<title>`을 돌려준다
**Plans**: 10/10 plans complete

Plans:
**Wave 1**
- [x] 02-01-PLAN.md — Jekyll 3.10.0 고정(Gemfile)·`_config.yml` url·exclude·`.gitignore`, 지금 사이트 빌드 출력 불변 증명, `check-site.sh`·pre-push 훅 (tracer, 푸시 없음)

**Wave 2** *(blocked on Wave 1 completion)*
- [x] 02-02-PLAN.md — 라이브 확인 도구를 현재 라이브에 통과, 첫 공개 방식 결정 checkpoint(base-first / together / hold)

**Wave 3** *(blocked on Wave 2 completion)*
- [x] 02-03-PLAN.md — 푸시 ① 빌드 설정: 후보 검증 → 승인 checkpoint → 승인된 SHA만 푸시 → 라이브 확인

**Wave 4** *(blocked on Wave 3 completion)*
- [x] 02-04-PLAN.md — 법적 3종을 `legal` 레이아웃과 include로 전환 (커밋 3개, 커밋마다 diff 0)

**Wave 5** *(blocked on Wave 4 completion)*
- [x] 02-05-PLAN.md — 푸시 ② 법적 3종

**Wave 6** *(blocked on Wave 5 completion)*
- [x] 02-06-PLAN.md — 랜딩을 include 네 곳으로 전환, 성공 기준 2 확인(한 벌 grep, include 임시 시험)

**Wave 7** *(blocked on Wave 6 completion)*
- [x] 02-07-PLAN.md — 푸시 ③ 랜딩

**Wave 8** *(blocked on Wave 7 completion)*
- [x] 02-08-PLAN.md — 「공통」 CSS 머리 주석 별도 커밋(D-06), 원본 맵 STACK·CONVENTIONS·ARCHITECTURE 갱신

**Wave 9** *(blocked on Wave 8 completion)*
- [x] 02-09-PLAN.md — 두 CLAUDE.md 한 커밋(방침 행 + 재생성), README·TESTING·STRUCTURE·CONCERNS 갱신

**Wave 10** *(blocked on Wave 9 completion)*
- [x] 02-10-PLAN.md — 푸시 ④ 주석·문서, 주석 제거 라이브 비교, 성공 기준 1~4 판정표
**UI hint**: no
**External gates**: 없음.
**Research flag**: 아니요. STACK 연구에서 Jekyll 3.10.0 빌드·서빙, `exclude` 덮어쓰기, 빈 front matter의 바이트 동일 출력을 로컬 실험으로 확인했습니다.
**Notes**: 법적 문서 3종과 랜딩은 별도 커밋으로 전환합니다. Tailwind `<script>`와 설정은 legal 레이아웃의 `<head>` 한 곳으로 옮기기만 하고, 제거는 Phase 3에서 합니다. `_config.yml`에 `url: "https://runningpencil.com"`을 두고 `exclude`를 보강합니다(사용자 지정 `exclude`는 기본 목록을 덮어씀). 레이아웃 이름 `default`·`page`·`home`, 전역 `permalink`, `.nojekyll`은 쓰지 않습니다. 앞으로 인라인 JS에 `{{`·`{%`가 들어가면 `{% raw %}`로 감쌉니다.

### Phase 3: 법적 페이지 정적 스타일 전환 (Tailwind CDN Removal)
**Goal**: 방문자가 외부 스크립트(Tailwind Play CDN) 없이 정적 CSS만으로 법적 문서 3종을 전환 전과 같은 모양으로 보고, 이후 단계는 클래스 없는 본문 마크업에 텍스트만 쓰면 된다
**Depends on**: Phase 2
**Requirements**: SHELL-04
**Success Criteria** (what must be TRUE):
  1. 세 법적 문서의 HTML 소스와 브라우저 네트워크 요청 어디에도 `cdn.tailwindcss.com`이 없다
  2. 375·768·1280px에서 전환 전·후 캡처를 비교하면 줄 간격·테두리·여백·글자색·카드 모양이 같다
  3. 세 문서 본문에서 뽑은 텍스트가 전환 전과 같다(문장 변경 0)
  4. 클래스 없는 시험용 표·목록·주석을 본문에 넣어 보면 별도 클래스 없이 카드 디자인에 맞게 보인다(이후 처리 위탁 표·FAQ·영문판이 같은 규칙을 씀)
**Plans**: 9/9 plans complete

Plans:
**Wave 1**
- [x] 03-01-PLAN.md — 기준 커밋·CDN 버전 기록과 기준 빌드(tracer), Playwright 설치 승인 checkpoint, 판정 도구와 기준 캡처 두 벌(자기 차이 0)

**Wave 2** *(blocked on Wave 1 completion)*
- [x] 03-02-PLAN.md — 사이트 커밋 ① `_includes/css/legal.css`와 `rp-legal-*` 껍데기 (Tailwind 유지, 픽셀 0), ③ 미리보기

**Wave 3** *(blocked on Wave 2 completion)*
- [x] 03-03-PLAN.md — 사이트 커밋 ② 본문 클래스 제거·끝 안내 `footer` (픽셀·텍스트 0), 본문 작성 규칙 확인

**Wave 4** *(blocked on Wave 3 completion)*
- [x] 03-04-PLAN.md — 사이트 커밋 ③ Tailwind script·설정 제거 (픽셀 0, Tailwind 0건), check-site 5번 항목 별도 커밋

**Wave 5** *(blocked on Wave 4 completion)*
- [x] 03-05-PLAN.md — 클래스 없는 시험 본문 자동 확인과 캡처, 승인·표 줄바꿈 선택 checkpoint, (nowrap이면) 별도 CSS 커밋

**Wave 6** *(blocked on Wave 5 completion)*
- [x] 03-06-PLAN.md — 사이트 푸시: 후보 검증 → 승인 checkpoint → 승인된 SHA만 푸시 → 배포 확인·HTTP·라이브 픽셀 0

**Wave 7** *(blocked on Wave 6 completion)*
- [x] 03-07-PLAN.md — 원본 맵 일곱 개 갱신 (정적 CSS, 법적 본문 작성 규칙)

**Wave 8** *(blocked on Wave 7 completion)*
- [x] 03-08-PLAN.md — 두 CLAUDE.md 한 커밋(방침 행 + 재생성), README, 문서 전체 Tailwind 흔적 훑기

**Wave 9** *(blocked on Wave 8 completion)*
- [x] 03-09-PLAN.md — 문서 푸시: 후보 검증 → 승인 checkpoint → 푸시·HTTP 확인, Phase 3 성공 기준 판정표
**UI hint**: no
**External gates**: 없음.
**Research flag**: 아니요. 쓰고 있는 유틸리티 클래스 목록(약 45개)과 Tailwind 3.4.17 Preflight 원문을 확인했고, 변환은 기계적입니다.
**Notes**: 요구사항이 하나뿐이지만 Phase 2에 합치지 않습니다. Phase 2는 출력이 같아야 하는 리팩터이고 이 단계는 모양이 같아야 하는 시각 변경이라, 섞으면 회귀가 생겼을 때 원인을 좁힐 수 없기 때문입니다. Preflight 중 필요한 규칙(border 3값, `text-sm` line-height 등)을 법적 문서 범위로 옮기고, 토큰(`ink`·`accent`·`muted`·`muted-2`·`line`)은 CSS 변수로 한 번만 정의합니다.

### Phase 4: 홈페이지 서비스 소개 정정 (Landing Content Fix)
**Goal**: 심사자가 홈페이지만 보고 출시 시점 앱이 실제로 하는 일을 정확히 알 수 있다. 앱에 없는 기능 설명이 사라지고, 실제 앱 화면과 출시 전임을 알리는 표시(현재 「출시 준비 중」)가 보인다
**Depends on**: Phase 2 (Phase 3과는 독립)
**Requirements**: SITE-01, SITE-06
**Success Criteria** (what must be TRUE):
  1. 홈페이지 본문, `<meta name="description">`, OG 제목·설명 어디에도 「포인트」「굿즈」「코스북」이 없다(빌드 결과 검색 0건)
  2. 홈페이지에 실제 앱 화면 스크린샷과 출시 전임을 알리는 표시(현재 「출시 준비 중」)가 함께 보이고(375·1280px), 스크린샷에는 출시 범위 밖 기능이 나오지 않는다
  3. 기존 동작(스크롤에 고정되는 세 가지 이유, 7초 달려 보기, 움직임 줄이기 대응)이 그대로 동작하고 브라우저 콘솔 오류가 없다
**Plans**: 13/13 plans complete

Plans:
**Wave 1**
- [x] 04-01-PLAN.md — 첫 문서 커밋: 기준 문장 세 곳의 출시 전 표시(D-08)와 캡처 절차서 작업 10 갱신(D-16~D-20) (tracer)

**Wave 2** *(blocked on Wave 1 completion)*
- [x] 04-02-PLAN.md — 기준 커밋·운영 동일 빌드(tracer), Playwright 설치 승인 checkpoint, p4-behave 기준 PASS와 음성 대조

**Wave 3** *(blocked on Wave 2 completion)*
- [x] 04-03-PLAN.md — 문구 커밋: 메타·OG·「세 가지 이유」 3단계 글·캡션 (SITE-01, D-02~D-05)

**Wave 4** *(blocked on Wave 3 completion)*
- [x] 04-04-PLAN.md — 빈 뱃지 컬러 커밋: 빈 뱃지 다섯 개 색, 빈 뱃지 규칙 삭제 (D-06)

**Wave 5** *(blocked on Wave 4 completion)*
- [x] 04-05-PLAN.md — 첫 사이트 푸시: 후보 검증 → 승인 checkpoint → 푸시·배포·라이브 바이트·동작 확인

**Wave 6** *(blocked on Wave 5 completion)*
- [x] 04-06-PLAN.md — check-site 6번 항목(랜딩 출시 범위 밖 기능 이름) build 커밋과 음성 대조, 원본 맵 항목 수

**Wave 7** *(blocked on Wave 6 completion)*
- [x] 04-07-PLAN.md — 두 CLAUDE.md 방침 행(D-23)·Deploy 문단·재생성, README·STRUCTURE 점검 주석

**Wave 8** *(blocked on Wave 7 completion)*
- [x] 04-08-PLAN.md — 문서 푸시: 후보 검증 → 승인 checkpoint → 푸시·404 확인 (SITE-01 갈래 끝)

**Wave 9** *(blocked on Wave 8 completion)*
- [x] 04-09-PLAN.md — 이미지 파이프라인 시험(tracer), 앱 화면 캡처 받기 checkpoint, 캡처 검토·WebP 변환

**Wave 10** *(blocked on Wave 9 completion)*
- [x] 04-10-PLAN.md — 스크린샷 구간 후보 판정: 「실제 앱 화면」 구간·이미지·CSS, p4-shots 두 엔진 × 375·1280, 후보는 브랜치 밖 객체로만 두고 작업 트리 되돌림 (SITE-06)

**Wave 11** *(blocked on Wave 10 completion)*
- [x] 04-11-PLAN.md — 스크린샷 푸시: 스크린샷 구간 커밋을 브랜치 밖에서 만듦 → 캡처·화면 검토 승인 checkpoint → 푸시 뒤 fast-forward·이미지·구간 라이브 확인

**Wave 12** *(blocked on Wave 11 completion)*
- [x] 04-12-PLAN.md — D-24 문서: 원본 맵 다섯 개와 두 CLAUDE.md(앱 화면 캡처 예외, 지도 출처, images/app/)

**Wave 13** *(blocked on Wave 12 completion)*
- [x] 04-13-PLAN.md — D-24 문서 푸시와 Phase 4 성공 기준 1~3 라이브 판정표
**UI hint**: yes
**External gates**: 사용자가 실제 앱 화면 캡처를 줍니다. 출시 범위의 기능만 보이는 화면이어야 합니다. 문구 정정(SITE-01)은 캡처와 상관없이 별도 커밋으로 먼저 배포할 수 있습니다. U10(포인트·굿즈·코스북 제거)은 이미 결정됐습니다.
**Research flag**: 아니요.

### Phase 5: 사업자 정보와 지원 연락 경로 (Business Info & Support Contact)
**Goal**: 심사자와 사용자가 모든 페이지에서 누가 러닝펜슬을 운영하는지 확인하고, `/support/`에서 실제로 받히는 지원 이메일로 연락할 수 있다. 이 단계가 끝나면 이메일 게이트가 열린다
**Depends on**: Phase 3 (지원 페이지가 정적 CSS 법적 레이아웃을 씀), Phase 1 (DNS 레코드 표·결정 목록)
**Requirements**: BIZ-01, BIZ-02, BIZ-03, SUP-01, SUP-02, SUP-03, SUP-04, SITE-03
**Success Criteria** (what must be TRUE):
  1. Gmail·네이버·iCloud·Outlook에서 지원 이메일로 보낸 시험 메일이 슬림펌킨 업무 메일에 도착했다는 시험 기록이 있고, 이 기록보다 앞선 어떤 배포에도 지원 이메일 주소가 나오지 않는다
  2. `dig` 결과에 지원 메일의 MX와 SPF(한 개), Search Console TXT가 보이고, Search Console이 `runningpencil.com` 도메인 속성을 확인됨으로 표시하며, DNS 변경 뒤에도 사이트가 HTTPS로 열린다
  3. 모든 페이지 푸터에 사업자등록증과 같은 표기의 상호·대표자·사업자등록번호·주소와 지원 이메일이 보이고, 값이 없는 항목은 자리표시 없이 행 자체가 없다
  4. 운영자가 `_data` 파일 하나만 고치면(전화번호를 넣는 경우 포함) 푸터와 지원 페이지에 바로 반영되고, 전화번호는 지금 값이 없어 어디에도 보이지 않는다
  5. `/support/` 맨 위에 「러닝펜슬」이 있고, 그 아래에서 지원 이메일과 응답 안내, 공개 코스 신고 방법, FAQ(운영 주체, 위치를 수집하는 시점, 계정 삭제 방법, 공개 코스 신고)를 찾을 수 있으며, 헤더·푸터에서 지원 페이지로 갈 수 있다
**Plans**: 15/15 plans complete

Plans:
**Wave 1**
- [x] 05-01-PLAN.md — 기준 커밋·운영 동일 빌드·검증 기록과 공통 규칙(tracer), Playwright 재설치 승인 checkpoint, p5-foot·p5-support 도구 기준 판정

**Wave 2** *(blocked on Wave 1 completion)*
- [x] 05-02-PLAN.md — 스크래치 설계 시험: 원형 슬롯·푸터·지원 페이지 빈 값 바이트 동일(tracer, A5)과 가짜 값 열한 경우 행렬

**Wave 3** *(blocked on Wave 2 completion)*
- [x] 05-03-PLAN.md — M1 빈 슬롯·푸터 템플릿(출력 불변, D-03 ①), M2 「공통」 CSS 두 줄(시각), 두 엔진 화면과 음성 대조

**Wave 4** *(blocked on Wave 3 completion)*
- [x] 05-04-PLAN.md — M3 check-site 7번 가드(지원 페이지 연락처·링크, A4)와 시험 객체 양성·음성 대조, 실제 pre-push 훅 거부 확인

**Wave 5** *(blocked on Wave 4 completion)*
- [x] 05-05-PLAN.md — 가짜 값 후보·캡처 파이프라인 시험(tracer), 사업자 값 받기 checkpoint, 실제 값 후보 판정·구분 기호 선택지 캡처, D-10 one-way 승인 checkpoint

**Wave 6** *(blocked on Wave 5 completion)*
- [x] 05-06-PLAN.md — 값 커밋 M4(필요하면 구분 기호 커밋 S), 첫 푸시 후보 → SHA 승인 → 푸시·라이브 확인 (D-03 ②)

**Wave 7** *(blocked on Wave 6 completion)*
- [x] 05-07-PLAN.md — 사업자 정보 쪽 문서(D-21): 원본 맵·이름 표·연구 Pattern 1, 두 CLAUDE.md·재생성, README·STATE

**Wave 8** *(blocked on Wave 7 completion)*
- [x] 05-08-PLAN.md — 보류 브랜치 p5-support-hold(별도 worktree): H1 지원 페이지, H2 기대 제목, H3 헤더·푸터 링크, 모두 「7번만 실패」

**Wave 9** *(blocked on Wave 8 completion)*
- [x] 05-09-PLAN.md — DNS 변경 전후 dig·HTTPS 기록, 작업 7 Search Console 확인 보고 checkpoint (SITE-03, 아직이면 05-14로 넘겨 이메일 게이트를 막지 않음)

**Wave 10** *(blocked on Wave 9 completion)*
- [x] 05-10-PLAN.md — 게이트 사전 점검(시험 cherry-pick), 작업 4 수신 시험 표 checkpoint, 4/4 확인 기록(이메일 게이트)

**Wave 11** *(blocked on Wave 10 completion)*
- [x] 05-11-PLAN.md — 보류 묶음 cherry-pick·게이트 날짜 G0·이메일 G를 한 번에, G 출력·화면·주소 이력 판정

**Wave 12** *(blocked on Wave 11 completion)*
- [x] 05-12-PLAN.md — 게이트 푸시: 후보 → SHA 승인 → 푸시·다섯 URL·두 엔진 라이브 확인

**Wave 13** *(blocked on Wave 12 completion)*
- [x] 05-13-PLAN.md — 지원 쪽 문서(D-21)·앵커 규칙·두 CLAUDE.md, 보류 worktree 정리(브랜치 ref는 로컬에 남김)

**Wave 14** *(blocked on Wave 13 completion)*
- [x] 05-14-PLAN.md — 마지막 DNS·HTTPS 재확인(tracer), 작업 5 보내기 설정 보고 checkpoint(05-09에서 넘어온 작업 7 포함, SITE03 닫기), D-06 단계 완료 표

**Wave 15** *(blocked on Wave 14 completion)*
- [x] 05-15-PLAN.md — 마지막 문서 푸시와 성공 기준 1~5 라이브 재판정

**Cross-cutting constraints:** <!-- gsd:generated -->
- 사람이 그 SHA를 보고 승인한 뒤에만 그 SHA 하나가 원격 main에 나갔다

**UI hint**: yes
**External gates**:
- 이메일 게이트: 외부 주소 4곳(Gmail·네이버·iCloud·Outlook)의 수신 시험이 통과하기 전에는 지원 이메일을 `_data`에 넣지 않습니다. 그 전에 배포하는 `/support/`는 연락처 구간 전체를 조건부로 감쌉니다(빈 「문의:」 문장 금지). App Store Support URL 같은 콘솔 등록도 게이트가 열린 뒤에 합니다.
- 사용자 DNS 작업(가비아): 두 번 방문합니다. 1차 방문에서 Google Workspace 도메인 인증 TXT, MX 1개, SPF 1개, Search Console TXT를 추가하고, Gmail을 켠 뒤 24~72시간이 지나면 2차 방문에서 `runningpencil.com`의 DKIM 레코드를 추가합니다(D-11). 2차 방문(DKIM)은 Phase 5 완료를 막지 않습니다. 이메일 게이트는 DKIM을 기다리지 않고, DKIM은 Phase 10 Apple 릴레이 답장(SUP-05)의 전제입니다. 작업 시점은 그대로 Phase 5 무렵입니다. 기존 A 레코드 4개, `www` CNAME, 앱 경로 라우터용 A 레코드, `_github-pages-challenge-SlimPumpkin` TXT는 그대로 두고 지우는 레코드는 없습니다. GitHub Pages 인증 TXT는 이미 있으므로 조직 설정에서 인증 상태만 확인합니다. SPF는 하나만 둡니다. 변경 전후 `dig` 결과를 기록합니다. 절차는 `.planning/baseline/USER-TASKS.md`에 있고, Phase 1이 끝나면 바로 시작할 수 있습니다.
- 사용자 작업: Google Workspace에 `runningpencil.com`을 사용자 별칭 도메인(user alias domain)으로 추가하고 지원 주소를 만드는 일, 지원 주소로 보내기 설정, Search Console 소유권 확인.
- 사용자 결정: U11(사업자등록증 그대로의 사업자 값, 자택 주소 공개 부담). U12는 결정됐습니다(Google Workspace, 지원 주소에서 답장. `.planning/baseline/DECISIONS.md`).
- 슬롯·푸터 행·지원 페이지 골격 같은 구조는 값 없이도 먼저 배포할 수 있습니다. 단계 완료는 게이트가 열리고 값이 들어간 뒤입니다.
**Research flag**: 아니요. 사실값 슬롯과 이메일 게이트 패턴은 ARCHITECTURE 연구에 구체적으로 나와 있고, Google Workspace 사용자 별칭 도메인 절차는 Phase 1 연구에서 확인해 `.planning/baseline/USER-TASKS.md`에 적었습니다.

### Phase 6: 데이터 삭제 안내 재작성 (Data Deletion Rewrite)
**Goal**: 앱이 없는 사용자도 `/data-deletion/`에서 계정·데이터 삭제를 요청하는 방법과 무엇이 지워지고 무엇이 남는지 알 수 있고, Google Play 계정 삭제와 Facebook 데이터 삭제 안내 요건을 이 문서 하나로 충족한다
**Depends on**: Phase 5 (이메일 게이트·사실값 슬롯)
**Requirements**: DEL-01, DEL-02, DEL-03, DEL-04, DEL-05, DEL-06, DEL-07, BIZ-05
**Success Criteria** (what must be TRUE):
  1. 앱을 설치하지 않은 사용자가 문서 첫 화면에서 지원 이메일로 계정·데이터 삭제를 요청하는 방법(메일에 적을 내용 포함)을 찾고, 문서에 스토어에 표시되는 앱 이름과 개발자 이름이 있다
  2. 사용자는 삭제되는 데이터와 남는 데이터(공개 코스 등), 남는 이유와 기간, 삭제에 걸리는 시간의 상한과 완료를 알려 주는 방법을 읽는다. 각 항목은 Phase 1 데이터 목록과 일치하고, 포인트·굿즈·배송지·전자상거래 기록은 없다
  3. 앱 안 삭제 경로가 실제 메뉴 이름 「회원탈퇴」로 안내되고, 위치정보 동의를 철회하면 개인위치정보와 확인자료가 파기된다는 안내가 있다
  4. `/data-deletion/#facebook`, `#google`, `#apple`, `#kakao`, `#naver`, `#line`이 각각 해당 제공자 섹션으로 바로 이동한다
  5. 삭제 안내의 사업자 정보와 연락처(지원 이메일 포함)는 `_data/company.yml`에서 읽고 본문에 값을 직접 쓰지 않아, 그 파일만 고치면 반영된다. 값이 없는 선택 항목(전화 등)은 자리표시 없이 표시되지 않는다
**Plans**: 5/13 plans executed

Plans:
**Wave 1**
- [x] 06-01-PLAN.md — 기준 커밋·운영 동일 빌드·앱 상태 탐침과 공통 규칙(tracer), Playwright 재설치 승인 checkpoint, p6-deletion 도구 음성·양성 대조

**Wave 2** *(blocked on Wave 1 completion)*
- [x] 06-02-PLAN.md — 데이터 목록의 기준 시점 오류 정정(연결 해제 여섯 제공자, 기록 삭제 화면, 익명 약관 기록)과 결정 목록·ROADMAP 게이트 기록

**Wave 3** *(blocked on Wave 2 completion)*
- [x] 06-03-PLAN.md — 앱 작업 게이트: 요청서(tracer), installation ID 결정, D-05 앱 작업과 U2 결론 blocking 사용자 작업

**Wave 4** *(blocked on Wave 3 completion)*
- [x] 06-04-PLAN.md — 앱 작업 사실을 기준 앱 커밋의 코드로 확인(tracer), 앱 화면 사실 재확인, 데이터 목록 재기준(D-06: 확인자료·운영자 도구·코스 단위 기록 삭제, prod 전제 다섯 목록 D-42)과 결정 목록 U2 「초안으로 진행」

**Wave 5** *(blocked on Wave 4 completion)*
- [x] 06-05-PLAN.md — 운영자 삭제 요청 처리 절차(작업 13: 도구 실행은 앱 문서, 개수 확인 → 실제 삭제 → 1시간 뒤 재확인, 10일 상한, 대체 본인 확인, 「뱃지와 기록 모두 삭제」, 탈퇴 정리 실패 재처리)

**Wave 6** *(blocked on Wave 5 completion)*
- [ ] 06-06-PLAN.md — 지워짐/남음 대조표(tracer), 익명 계정 문장(D-33 ①), prod 값 없는 기간과 공개 코스 행·삭제 경로 약속(D-33 ②, D-39), 표 범위

**Wave 7** *(blocked on Wave 6 completion)*
- [ ] 06-13-PLAN.md — 대조표 확정, 기간 문구(PERIOD)와 이용 중 보관 기간(INUSE 「6개월」) 고정, 데이터 목록 반영과 prod 전제 덧붙임(tracer)을 원고보다 먼저 문서 커밋(D-33, D-41, D-42)

**Wave 8** *(blocked on Wave 7 completion)*
- [ ] 06-07-PLAN.md — 원고를 시험 객체로 끝까지 판정(tracer, D-37~D-41 낱말 판정 포함), 가짜 값 변형, 글·표·앵커 승인

**Wave 9** *(blocked on Wave 8 completion)*
- [ ] 06-08-PLAN.md — 가짜 값 시험 실행(tracer), 스토어 개발자 이름 값 받기(D-33 ④), 실제 값 미리보기

**Wave 10** *(blocked on Wave 9 completion)*
- [ ] 06-09-PLAN.md — 값 커밋 S1·재작성 커밋 S2 후보 판정(tracer), 값·SHA 승인, fast-forward·푸시·라이브 확인

**Wave 11** *(blocked on Wave 10 completion)*
- [ ] 06-10-PLAN.md — check-site 6번 확장·8번 삭제 안내 가드 build 커밋과 양성·음성 대조, 훅 경로

**Wave 12** *(blocked on Wave 11 completion)*
- [ ] 06-11-PLAN.md — 원본 맵·두 CLAUDE.md(재생성)·이름 표·데이터 목록 「확인할 것」·README 문서 커밋

**Wave 13** *(blocked on Wave 12 completion)*
- [ ] 06-12-PLAN.md — 가드·문서 푸시 후보 판정(tracer), SHA 승인, 푸시·라이브 출력 불변 확인
**UI hint**: no
**External gates**: 이메일 게이트(Phase 5)가 열린 뒤에 커밋합니다. 웹 삭제 요청 경로가 이메일에 달려 있어, 경로가 빠진 삭제 안내를 라이브에 올리지 않기 위해서입니다. U6(탈퇴 후 공개 코스 유지, 비공개 코스 처리)이 결정돼야 합니다. D-05 앱 작업 묶음과 U2 결론(D-31)이 들어와 데이터 목록을 재기준(D-06)한 뒤에 커밋합니다.
**Research flag**: 부분. Meta Data Deletion Instructions의 내용 기준을 확인합니다. 나머지 사실은 Phase 1 데이터 목록을 씁니다.
**Notes**: 이 문서의 「임시 게시본」 표시와 `noindex`는 재작성 커밋에서 함께 지웁니다(세 문서 전체 확인은 Phase 8). 「30일 이내」 같은 상한 표현은 쓸 수 있습니다. 「모든 개인정보」 같은 절대 표현은 Analytics·Crashlytics 보존 기간을 확인한 뒤에만 씁니다.

### Phase 7: 개인정보처리방침 재작성 (Privacy Policy Rewrite)
**Goal**: 사용자와 심사자가 처리방침 하나로 러닝펜슬이 어떤 개인정보를 어디서 받아 무엇에 쓰고, 누구에게 맡기고, 언제 지우는지, 그리고 권리를 어떻게 행사하는지 확인할 수 있으며, 그 내용이 앱의 실제 동작(데이터 목록)과 일치한다
**Depends on**: Phase 6 (삭제 방법 문장 일치), Phase 5 (이메일 게이트·보호책임자 값)
**Requirements**: PRIV-01, PRIV-02, PRIV-03, PRIV-04, PRIV-05, PRIV-06, PRIV-07, PRIV-08, PRIV-09, PRIV-10, PRIV-11, BIZ-06
**Success Criteria** (what must be TRUE):
  1. 처리 항목(로그인 제공자별 수신 항목, 기록 중 GPS 궤적, 코스·기록·뱃지, 프로필 사진, 푸시 토큰, 분석·크래시 정보)과 목적·보유 기간·파기 절차가 데이터 목록과 항목 단위로 일치하고, 굿즈·배송지·포인트는 없다
  2. 처리 위탁 표에 수탁자와 업무(Google Firebase·GCP, 네이버클라우드 등)가 있고 로그인 제공자는 수탁자로 적혀 있지 않으며, 국외 이전 항목은 근거와 다섯 가지 사항(항목, 국가·시기·방법, 이전받는 자와 연락처, 목적·보유 기간, 거부 방법·효과)을 모두 채운다
  3. 로그인 제공자별 수신 항목 표(제공자, 받는 항목, 필수/선택, 용도)가 있어 카카오 동의항목·네이버 활용처·Google user data 사용 공개를 한 곳에서 대조할 수 있다
  4. 사용자는 처리방침에서 열람·정정·삭제·처리정지 요구와 동의 철회·삭제 요청 방법(앱 안 「회원탈퇴」, 지원 이메일), 개인정보 보호책임자와 연락처, 자동 수집 장치(Firebase Analytics·Crashlytics 등)와 거부 방법, 만 14세 미만 정책, 안전성 확보 조치를 찾는다
  5. 처리방침에 시행일과 변경 이력이 있고, 개정할 때 이전 버전을 고정 URL에 남기는 방식이 정해져 `CLAUDE.md`에 적혀 있다
  6. 처리방침의 사업자 정보와 보호책임자 연락처는 `_data/company.yml`에서 읽고 본문에 값을 직접 쓰지 않는다. 전화번호를 `_data`에 넣으면 보호책임자 연락처에 바로 나타나고, 비어 있으면 그 줄이 표시되지 않는다
**Plans**: TBD
**UI hint**: no
**External gates**: 이메일 게이트와 보호책임자 값이 들어온 뒤에 커밋합니다(조항이 통째로 빠진 처리방침을 라이브에 올리지 않음). U3(소상공인 해당 여부, 해당하면 대표자가 보호책임자), U5(Email/Password 가입 노출 여부), U7(14세 미만 정책) 결정이 필요합니다.
**Research flag**: 예. 개인정보위 「처리방침 작성지침」 2026.4 개정 원문 대조, 국외 이전 기재 형식, 열람 처리 기한(시행령 제41조)을 확인합니다.
**Notes**: URL `/privacy-policy/`는 그대로 둡니다. 「임시 게시본」 표시와 `noindex`는 이 커밋에서 지웁니다. 위치기반서비스 이용약관으로 가는 링크는 그 페이지가 생기는 Phase 8에서 넣습니다.

### Phase 8: 이용약관과 위치기반서비스 이용약관 (Terms & Location Terms)
**Goal**: 이용약관이 출시 시점 앱의 실제 범위를 다루고 위치기반서비스 이용약관이 홈페이지에 공개되어, 심사자가 홈페이지 푸터에서 미완성 표시 없는 법적 문서 다섯 곳으로 모두 이동할 수 있다
**Depends on**: Phase 7 (처리방침과 상호 참조), Phase 5 (사업자 값)
**Requirements**: TERM-01, TERM-02, TERM-03, LOC-01, LOC-02, LOC-03, LOC-04, SITE-02, SITE-05, BIZ-07
**Success Criteria** (what must be TRUE):
  1. 이용약관에 포인트·굿즈 조항이 없고, 코스 공개와 공개 후 수정 불가, 탈퇴 후 공개 코스 유지, 사용자 콘텐츠 신고, 지도·경로 데이터 출처(OpenStreetMap)와 네이버 지도 SDK 이용 고지 조항이 있다
  2. 위치약관이 위치정보법 제19조①의 필수 사항(사업자 상호·주소·연락처, 권리와 행사 방법, 서비스 내용, 확인자료 보유 근거·기간, 개인위치정보 보유 목적·기간)을 담고, 사용자는 여기서 동의 철회, 수집·이용 일시 중지 요구, 확인자료 열람·고지·정정 요구 방법을 찾는다
  3. 이용약관과 위치약관에 각각 시행일과 변경 이력이 있고, 이용약관과 처리방침에서 위치약관으로 링크된다
  4. 홈페이지 푸터에서 처리방침(URL 대장에 적힌 Google 동의 화면 등록 URL과 같은 주소), 이용약관, 데이터 삭제 안내, 지원, 위치기반서비스 이용약관(눈에 띄는 링크)으로 이동할 수 있고, 다섯 곳 모두 `runningpencil.com` 안에 있다
  5. 처리방침·이용약관·데이터 삭제 안내 어디에도 「임시 게시본」 같은 미완성 표시와 `noindex`가 없고, `robots.txt`가 이 경로들을 막지 않는다
  6. 위치약관의 사업자 상호·주소·연락처는 `_data/company.yml`에서 읽고 본문에 값을 직접 쓰지 않는다. 전화번호를 `_data`에 넣으면 연락처에 바로 나타나고, 비어 있으면 그 줄이 표시되지 않는다
**Plans**: TBD
**UI hint**: no
**External gates**: 사업자 값(U11)이 들어와야 합니다. U2(위치정보법 분류)는 위치약관의 범위만 정합니다. 위치기반서비스사업 신고 기준으로 쓰고, 위치정보사업 등록 대상으로 나오면 v2의 LOC-05로 보강합니다. 그 밖에 U6(탈퇴 후 코스), U7(14세 미만), U8(네이버 지도 고지 의무) 결정이 필요합니다. 신고·등록을 실제로 할지는 사이트가 정하지 않고 마일스톤 인수 항목 ACPT-02로 둡니다.
**Research flag**: 예. 위치약관은 위치정보사업(등록)과 위치기반서비스사업(신고)의 분류, 확인자료 보존 기간, 국내 러닝 앱 위치약관 목차를 비교해야 하고 법률 확인이 필수입니다. 이용약관은 네이버 지도 이용약관 §7⑤ 원문을 확인합니다.
**Notes**: 위치약관 경로는 `/location-terms/`로 확정했습니다(Phase 1 URL 대장 `.planning/baseline/URLS.md`, D-15). 이용약관 재작성과 위치약관 신설은 문서별로 따로 커밋합니다. 이 단계에서 이용약관의 「임시 게시본」·`noindex`를 지우면 기존 법적 문서 3종이 모두 정식 게시본이 됩니다.

### Phase 9: 영문판 (English Versions)
**Goal**: 영어 사용자와 해외 제공자 심사자가 `/en/` 아래에서 RunningPencil이 무엇인지와 처리방침·약관·삭제 안내·지원 내용을 국문과 같은 내용으로 읽고, 언어판 사이를 링크로 오간다
**Depends on**: Phase 8 (국문 법적 문서 확정, 두 번 번역하지 않음), Phase 4 (국문 홈페이지 확정)
**Requirements**: I18N-01, I18N-02, I18N-03, I18N-04
**Success Criteria** (what must be TRUE):
  1. `/en/privacy-policy/`, `/en/terms/`, `/en/data-deletion/`, `/en/support/`가 국문판과 같은 조항·표·제공자 앵커를 영어로 보여 주고, 서비스명은 RunningPencil, `<html lang="en">`이다
  2. `/en/`에서 영어 사용자가 RunningPencil이 무엇을 하는 앱인지(지도 위 GPS 아트 코스를 걷거나 달려 완주하면 코스 모양 뱃지를 모음) 확인하고, 출시 예정 표시와 영문 법적 문서 링크를 본다
  3. 짝이 있는 문서마다 보이는 언어 전환 링크가 있고, 각 문서의 `<head>`에 자기 참조를 포함한 전체 URL `hreflang`이 있으며, 어떤 페이지도 브라우저 언어에 따라 자동으로 이동시키지 않는다
  4. 영문 문서마다 「한국어판이 우선한다」는 문구와 국문판 시행일이 보이고, 국문판이 영문판의 `source_updated`보다 나중에 바뀌면 로컬 검사가 이를 알린다
**Plans**: TBD
**UI hint**: yes
**External gates**: 영문 법인명(이름 표, U11)이 있어야 영문 푸터와 영문 문서의 주체 표기를 채울 수 있습니다. 영문 서비스명은 RunningPencil로 결정됐습니다.
**Research flag**: 아니요. 구조(`doc_key` 짝짓기, `lang-switch` include)는 확정됐고, 남은 것은 번역 품질입니다.
**Notes**: 언어 전환 include(짝이 없으면 아무것도 그리지 않음)를 먼저 배포한 뒤 삭제 안내 → 처리방침 → 약관 → 지원 → 홈 순서로 한 장씩 올립니다. 위치약관 영문판은 v2(LOC-06)입니다.

### Phase 10: 제출 준비와 최종 점검 (Submission Readiness)
**Goal**: 운영자가 체크리스트만 따라 제공자 6곳과 스토어 2곳 콘솔에 같은 이름·URL·문구를 한 번에 제출할 수 있고, 제출하는 시점에 URL 대장의 모든 주소가 라이브에서 열린다
**Depends on**: Phase 9, Phase 5 (지원 메일)
**Requirements**: SUBMIT-01, SUBMIT-02, SUBMIT-03, SITE-04, SUP-05
**Success Criteria** (what must be TRUE):
  1. 운영자는 카카오·네이버·Google·Apple·Facebook·LINE·App Store·Google Play 콘솔별 체크리스트에서 필드마다 넣을 URL(언어판 포함)·이름·로고·설명 문구·담당 이메일·도메인 인증 절차를 보고, 필수 사실값과 이메일 게이트가 충족됐는지 항목별로 확인한다
  2. 운영자는 카카오·네이버가 출시 전 서비스에 요청하는 서비스 소개 자료의 목록(화면 캡처 등)을 받는다
  3. URL 대장의 모든 URL(홈, 기존 3개, `/support/`, 위치약관, `/en/` 5개)이 라이브에서 200으로 열리고, 기존 3개 경로가 마일스톤 시작 때와 같다는 확인 기록이 있다
  4. 운영자는 배포 후 URL 전체를 확인하는 절차와 「심사 중 푸시 자제」 같은 운영 규칙을 `CLAUDE.md`에서 찾아 따를 수 있다
  5. Apple로 로그인한 사용자의 릴레이(Private Email Relay) 주소로 보낸 지원 답장이 반송되지 않았다는 시험 기록이 있다. 답장을 보내는 도메인의 SPF·DKIM이 `dig`로 확인되고, 그 도메인과 주소가 Apple Developer에 발신처로 등록돼 있다
**Plans**: TBD
**UI hint**: no
**External gates**: U9(Meta Advanced Access에 비즈니스 인증이 필요한지)와 U13(Google 브랜드 검증 신청 여부) 결정이 체크리스트 내용을 정합니다. 릴레이 답장 시험에는 사용자 작업이 필요합니다. Apple Developer에 발신 도메인과 지원 주소를 등록하고, Apple 계정으로 「이메일 가리기」 로그인을 해서 릴레이 주소를 만듭니다. 답장 발신 도메인 `runningpencil.com`의 DKIM(`.planning/baseline/USER-TASKS.md` 작업 6, 가비아 DNS 2차 방문)도 이 단계의 게이트입니다. 작업 시점은 Phase 5 무렵이지만, 릴레이 답장 시험 전에는 끝나 있어야 합니다(D-11). 실제 제출과 심사 통과는 이 단계의 성공 기준이 아닙니다(아래 Milestone Acceptance).
**Research flag**: 예. 콘솔별 실제 필드명과 언어 요건(카카오·네이버·LINE·Meta·App Store), Meta Data Deletion Instructions 기준, Meta Advanced Access와 비즈니스 인증의 관계, Google 브랜드 검증을 생략할 때 동의 화면이 어떻게 보이는지 확인합니다.
**Notes**: `CLAUDE.md` 최종 갱신(공통 블록 방식, `{% raw %}` 규칙, 언어판 규칙, 로컬 미리보기, 운영 규칙)을 이 단계에서 마무리합니다. SUP-05(Apple 릴레이 답장)는 Apple 콘솔 설정과 함께 확인하는 항목이라 Phase 5가 아니라 이 단계에 둡니다. 연구 SUMMARY도 이 확인을 마지막 단계에 두었습니다.

## External Gates

Claude가 하지 않고 사용자나 법률 확인이 주는 값·작업입니다. 해당 단계는 구조를 먼저 배포할 수 있지만, 아래 값이 들어오기 전에는 완료할 수 없습니다.

| 게이트 | 누가 | 막는 단계 |
|--------|------|-----------|
| 가비아 DNS 레코드 1차 방문(Google Workspace 도메인 인증 TXT·MX·SPF, Search Console TXT. 기존 레코드는 보존) | 사용자 | Phase 5 |
| 가비아 DNS 레코드 2차 방문(`runningpencil.com` DKIM, 절차서 작업 6. 작업 시점은 Phase 5 무렵) | 사용자 | Phase 10 (Apple 릴레이 답장, SUP-05) |
| 이메일 게이트(외부 주소 4곳 수신 시험 통과) | 사용자 시험 → Claude가 기록 확인 후 `_data`에 기입 | Phase 5 완료, Phase 6·7 커밋, 콘솔 등록 |
| Apple 발신 도메인·주소 등록, 릴레이 답장 시험 | 사용자 | Phase 10 |
| 앱 화면 캡처(출시 범위 기능만) | 사용자 | Phase 4 |
| U11 사업자 값(상호·대표자·사업자등록번호·주소, 영문 법인명) | 사용자 | Phase 5, 8, 9 |
| U2 위치정보법 분류(신고 vs 등록). 2026-11-21 원문 조사로 위치기반서비스사업(신고)으로 결정 | 원문 조사·사용자 | Phase 6 커밋(D-31), Phase 8 위치약관 범위, ACPT-02 |
| U3 소상공인 해당 여부 (보호책임자 면제는 소상공인만) | 사용자(사실값 대조) | Phase 7 보호책임자 |
| U5 Email/Password 가입 노출 여부 | 사용자(앱) | Phase 7 |
| U6 탈퇴 후 공개 코스 유지, 비공개 코스 처리 | 사용자(앱) | Phase 6, 8 |
| Phase 6 앱 작업 묶음 (D-05 ①②③⑤⑥: 비공개 코스 삭제, uid rate_limits 삭제와 해시 문서 보존 기간, 운영자 삭제 도구, 기록 삭제 화면, 위치정보 확인자료 기록) | 사용자(앱) | Phase 6 커밋 |
| U7 만 14세 미만 가입 정책. 2026-11-21 결정: 가입 차단, 「만 14세 이상」 체크로 확인 (앱 반영 대기) | 사용자 | Phase 7, 8 |
| U8 네이버 지도 이용약관 고지 의무 | 사용자·약관 확인 | Phase 8 |
| U9 Meta 비즈니스 인증 필요 여부 | 사용자(콘솔 확인) | Phase 10 |
| U13 Google 브랜드 검증 신청 여부 | 사용자 | Phase 10 |

이미 결정된 항목: U1(전화번호는 이번에 공개하지 않고 칸만 마련), U4(영문 서비스명 RunningPencil), U10(포인트·굿즈·코스북 제거), U12(Google Workspace 사용자 별칭 도메인으로 지원 주소를 받고 그 주소에서 답장), U14(법적 문서 `noindex` 해제, `/en/` 홈페이지 포함).

## Milestone Acceptance

외부 결과라 사이트만으로 검증할 수 없습니다. 어느 단계에도 배정하지 않고, 단계의 성공 기준으로도 쓰지 않습니다. 마일스톤을 마칠 때 사용자가 확인합니다.

- ACPT-01: 제공자 6곳의 통과를 사용자가 확인합니다. 카카오는 비즈앱 전환과 동의항목 심사, 네이버는 로그인 검수, Google은 OAuth 동의 화면 게시(브랜드 검증은 U13에 따름), Apple은 Sign in with Apple 프로덕션 구성, Facebook은 Live 전환(필요하면 비즈니스 인증, U9), LINE은 채널 공개(Published)입니다.
- ACPT-02: 위치정보법상 신고 또는 등록이 필요한지(U2)와 그 처리 여부를 사용자가 확인합니다.

## Progress

**Execution Order:**
Phases execute in numeric order: 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9 → 10

- Phase 3과 Phase 4는 둘 다 Phase 2에만 기대므로 순서를 바꿔도 됩니다.
- Phase 5는 Phase 4에 기대지 않습니다. Phase 4가 앱 화면 캡처를 기다리는 동안 Phase 5를 먼저 진행해도 됩니다.
- Phase 5의 사용자 DNS·메일 작업은 Phase 1이 끝나면 바로 시작해 Phase 2~4와 병행하는 것이 좋습니다. 이메일 게이트가 Phase 6·7의 임계 경로(critical path)입니다.

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. 기준표와 방침 정비 (Ground Truth & Policy Reset) | 10/10 | Complete    | 2026-11-15 |
| 2. Jekyll 공유 셸 도입 (Shared Shell Refactor) | 10/10 | Complete    | 2026-11-16 |
| 3. 법적 페이지 정적 스타일 전환 (Tailwind CDN Removal) | 9/9 | Complete    | 2026-11-17 |
| 4. 홈페이지 서비스 소개 정정 (Landing Content Fix) | 13/13 | Complete    | 2026-11-19 |
| 5. 사업자 정보와 지원 연락 경로 (Business Info & Support Contact) | 15/15 | Complete    | 2026-11-20 |
| 6. 데이터 삭제 안내 재작성 (Data Deletion Rewrite) | 5/13 | In Progress | - |
| 7. 개인정보처리방침 재작성 (Privacy Policy Rewrite) | 0/TBD | Not started | - |
| 8. 이용약관과 위치기반서비스 이용약관 (Terms & Location Terms) | 0/TBD | Not started | - |
| 9. 영문판 (English Versions) | 0/TBD | Not started | - |
| 10. 제출 준비와 최종 점검 (Submission Readiness) | 0/TBD | Not started | - |

## Backlog

### Phase 999.1: 웹 호스팅을 GitHub Pages에서 Firebase Hosting으로 이전 (BACKLOG)

**Goal:** [Captured for future planning] 다음 마일스톤(실데이터 웹사이트)을 시작할 때 `runningpencil.com`의 호스팅을 Firebase Hosting으로 옮긴다
**Requirements:** TBD
**Plans:** 0 plans
**Notes (2026-11-15 논의):**
- 이유: 앱이 Flutter + Firebase라 같은 콘솔·결제에서 관리할 수 있다. 배포할 때 CDN 캐시를 비우고, preview channel·콘솔 롤백·헤더·리디렉션·rewrite를 쓸 수 있다. GitHub Pages는 이것들을 할 수 없다(Phase 2 연구에서 CDN 캐시를 통제할 수 없음을 확인)
- 다음 마일스톤에 필요한 것: 실데이터 페이지(rewrite로 Functions/Cloud Run 연결), 코스 공유 링크와 Universal Links/App Links 파일(`/.well-known/`). Firebase Dynamic Links는 2025년에 종료됨
- 위험: 도메인이 같아 심사 콘솔에 등록한 URL은 그대로 유효하다. DNS 전환 때 SSL 인증서 발급을 기다리는 동안 오류가 날 수 있어 TTL을 미리 낮춘다. 메일(MX)은 영향 없음
- 같이 정할 것: Firebase/GCP 프로젝트를 슬림펌킨 Google Workspace 조직 아래에 둘지, 앱 prod 프로젝트에 둘지 별도 프로젝트로 둘지, 빌드·배포 경로(GitHub Actions에서 Jekyll 빌드 뒤 `firebase deploy`)
- 이번 마일스톤에서는 하지 않는다 (Constraints: GitHub Pages 정적 호스팅)

Plans:
- [ ] TBD (promote with /gsd-review-backlog when ready)
