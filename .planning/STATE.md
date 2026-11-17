---
gsd_state_version: "1.0"
current_phase: 04
current_phase_name: 홈페이지 서비스 소개 정정 (Landing Content Fix)
status: executing
stopped_at: Completed 04-05-PLAN.md
last_updated: "2026-11-17T05:46:54.556Z"
last_activity: 2026-11-17
last_activity_desc: Phase 04 execution started
state_head: 9bc1c2078945bdd98f760fc04f195bceb481d686
progress:
  total_phases: 10
  completed_phases: 3
  total_plans: 42
  completed_plans: 34
  percent: 30
---

# Project State

## Project Reference

See: .planning/PROJECT.md (updated 2026-11-17)

**Core value:** 소셜 로그인 제공자와 스토어 심사자가 이 사이트만 보고 서비스·운영 주체·개인정보 처리·연락과 삭제 방법을 확인할 수 있어, 심사가 웹사이트 때문에 반려되지 않는다
**Current focus:** Phase 04 — 홈페이지 서비스 소개 정정 (Landing Content Fix)

## Current Position

Phase: 04 (홈페이지 서비스 소개 정정 (Landing Content Fix)) — EXECUTING
Plan: 6 of 13
Status: Ready to execute
Last activity: 2026-11-17 — Phase 04 execution started

Progress: [███░░░░░░░] 30%

## Performance Metrics

**Velocity:**
- Total plans completed: 29
- Average duration: -
- Total execution time: 0 hours

**By Phase:**

| Phase | Plans | Total | Avg/Plan |
|-------|-------|-------|----------|
| 01 | 10 | - | - |
| 02 | 10 | - | - |
| 03 | 9 | - | - |

**Recent Trend:**
- Last 5 plans: -
- Trend: -

*Updated after each plan completion*
**Per-Plan Metrics:**

| Plan | Duration | Tasks | Files |
|------|----------|-------|-------|
| Phase 01 P01 | 5 min | 2 tasks | 5 files |
| Phase 01 P02 | 6 min | 2 tasks | 1 files |
| Phase 01 P03 | 13 min | 2 tasks | 1 files |
| Phase 01 P04 | 8 min | 2 tasks | 1 files |
| Phase 01 P06 | 4 min | 3 tasks | 5 files |
| Phase 01 P05 | 10 min | 2 tasks | 1 files |
| Phase 01 P07 | 3 min | 3 tasks | 6 files |
| Phase 01 P08 | 9min | 2 tasks | 1 files |
| Phase 01 P09 | 5min | 2 tasks | 2 files |
| Phase 01 P10 | 5 min | 1 tasks | 1 files |
| Phase 02 P01 | 8 min | 2 tasks | 7 files |
| Phase 02 P02 | 46 min | 3 tasks | 2 files |
| Phase 02 P03 | 21min | 3 tasks | 2 files |
| Phase 02 P04 | 7min | 3 tasks | 9 files |
| Phase 02 P05 | 15min | 3 tasks | 2 files |
| Phase 02 P06 | 4min | 2 tasks | 2 files |
| Phase 02 P07 | 10min | 3 tasks | 2 files |
| Phase 02 P08 | 8min | 3 tasks | 5 files |
| Phase 02 P09 | 8min | 3 tasks | 7 files |
| Phase 02 P10 | 28min | 3 tasks | 2 files |
| Phase 03 P01 | 19min | 3 tasks | 1 files |
| Phase 03 P02 | 11min | 2 tasks | 2 files |
| Phase 03 P03 | 5 min | 2 tasks | 4 files |
| Phase 03 P04 | 4min | 2 tasks | 3 files |
| Phase 03 P05 | 4min | 3 tasks | 2 files |
| Phase 03 P06 | 6min | 3 tasks | 2 files |
| Phase 03 P07 | 6min | 2 tasks | 8 files |
| Phase 03 P08 | 4min | 2 tasks | 4 files |
| Phase 03 P09 | 7min | 3 tasks | 1 files |
| Phase 04 P01 | 1 min | 2 tasks | 4 files |
| Phase 04 P02 | 11 min | 3 tasks | 2 files |
| Phase 04 P03 | 3 min | 2 tasks | 2 files |
| Phase 04 P04 | 7 min | 2 tasks | 2 files |
| Phase 04 P05 | 3 min | 3 tasks | 1 files |

## Accumulated Context

### Decisions

Decisions are logged in PROJECT.md Key Decisions table.
Recent decisions affecting current work:

- [Roadmap]: 10단계, 순서는 기준 → 리팩터(Phase 2, 출력 diff 0) → 시각(Phase 3, 모양 동일) → 내용(Phase 4~8) → 영문(Phase 9) → 제출(Phase 10)
- [Roadmap]: 한국어 법적 문서는 문서별 단계로 나눔(삭제 안내 → 처리방침 → 약관·위치약관). 영문판은 국문 확정 뒤에 함
- [Roadmap]: DNS·메일·Search Console은 Phase 5에 묶고, 이메일 게이트(외부 수신 시험)가 열려야 Phase 5가 끝남. 사용자 작업은 Phase 1 직후 시작 가능. Apple 릴레이 답장(SUP-05)은 Phase 10
- [Roadmap]: ACPT-01·02(제공자 통과, 위치정보법 신고·등록)는 마일스톤 인수 항목. 어느 단계의 성공 기준에도 넣지 않음
- [Phase 01]: 방침 구간은 .claude/CLAUDE.md의 GSD:project-start 마커 위에 둔다. 재생성 시험에서 구간이 남고 바뀐 줄은 conventions 블록 서비스 이름 줄 하나뿐임을 확인 (01-01)
- [Phase 01]: URL 대장의 콘솔 등록 없는 행(/location-terms/, /en/location-terms/)도 콘솔 칸을 비우지 않고 사실을 글로 적는다 (01-01)
- [Phase 01]: 절차서의 지원 주소 1순위는 운영자 계정의 사용자 이메일 별칭 support, 외부 4곳 수신 시험이 실패하면 별칭을 지운 뒤 Google 그룹으로 넘어간다 (01-02)
- [Phase 01]: DMARC(_dmarc TXT)는 절차서 작업 6의 선택 항목으로만 두고 정책 값은 적지 않았다 (01-02)
- [Phase 01]: 라우터용 A 레코드는 호스트 이름 없이 적고 dig 확인은 사용자가 호스트 이름을 직접 넣는 별도 명령으로 분리했다 (01-02)
- [Phase 01]: Storage 행의 국외 이전 칸은 값 어휘의 「dev는 서울 리전」 대신 「dev 버킷 위치도 미확인, CLI 미확인」으로 적음 (Storage 버킷 위치는 확인되지 않음) (01-03)
- [Phase 01]: 익명 계정 행의 삭제 방식은 「미확인」 (익명 사용자에게 탈퇴 메뉴가 보이는지 확인하지 못함, 결정 목록 N3) (01-03)
- [Phase 01]: users/{uid} 문서 필드의 보유 기간은 「탈퇴까지」 (클라이언트 삭제 금지, firestore.rules:395), 사진 URL·Storage 사진만 「탈퇴 또는 본인 삭제까지」 (01-03)
- [Phase 01]: 네이버 프로필 근거는 RESEARCH의 249-264행 대신 기준 커밋에서 다시 찾은 37행(API 주소)과 260-265행(반환 필드) (01-03)
- [Phase 01]: P1(prod 리전)은 ROADMAP External Gates 표에 행이 없어 막는 단계·마감 단계를 D-08(Phase 7 처리방침 커밋 전)에서 가져왔다 (01-04)
- [Phase 01]: 결정 목록 N 표의 「다루는 곳」은 데이터 목록 구간 글자로 적었다. N1·N5는 E, N6은 F와 P1, N2는 H — 01-05가 더할 구간 (01-04)
- [Phase 01]: U12 기록에는 업무 메일 도메인 이름과 채택하지 않은 메일 전달 서비스 이름을 적지 않았다 (01-04)
- [Phase 01]: CONVENTIONS.md의 이메일 항목을 폼 금지 규칙(유지)과 지원 이메일 상태 문장(이메일 게이트 Phase 5)으로 나눠 Content & Naming Rules를 일곱 항목으로 만듦 (01-06)
- [Phase 01]: .claude/CLAUDE.md는 생성기 사본 시험에서 conventions 블록의 Content & Naming Rules 목록 줄만 바뀜을 확인한 뒤 --auto 없이 재생성함. 블록 안 손 수정 없음 (01-06)
- [Phase 01]: 구간 G를 13행으로 씀: mail 문서와 Cloud Functions 로그의 uid를 더해 탈퇴 뒤 남는 데이터를 빠짐없이 보임 (01-05)
- [Phase 01]: 구간 H를 18행으로 씀: Firestore TTL과 배포된 함수 리전 행을 더해 「확인할 것」 CLI 행과 맞춤 (01-05)
- [Phase 01]: 기기 안 설정 행에 SharedPreferences 키를 모두 적음. 익명 사용자의 약관 동의 사본(terms.accepted_value)이 기기 안에 있음 (01-05)
- [Phase 01]: mail 컬렉션에는 인증 메일과 비밀번호 재설정 메일이 함께 쓰임 (send_password_reset_mail.ts:310) (01-05)
- [Phase 1]: U12 결정. 지원 메일은 Google Workspace 사용자 별칭 도메인으로 받고 지원 주소에서 답장함. 가비아 DNS는 두 번 방문(1차 도메인 인증·MX·SPF·Search Console, 2차 DKIM). 위치약관 경로는 `/location-terms/`로 확정
- [Phase 01]: ROADMAP·STATE·PROJECT 본문 문장은 핸들러 없이 Edit로 고치고 roadmap validate·state validate로 구조를 확인함 (01-07)
- [Phase 01]: 연구 문서(research/STACK.md·SUMMARY.md)는 본문을 고치지 않고 구간 머리에 U12 결정 메모 한 줄만 더함. 연구 캐시는 .gitignore로 뺌 (01-07)
- [Phase 01]: 01-08: dev CLI 읽기 전용 조회 여덟 건이 모두 조회함이라 데이터 목록의 「CLI 미확인」 칸을 「근거: dev CLI, 2026-11-15 조회」로 채웠다. dev 값이므로 결정 목록 「prod 리전」(P1)은 열어 둔다
- [Phase 01]: G-01-2: 가비아 DNS 2차 방문(DKIM, 절차서 작업 6)은 Phase 10(Apple 릴레이 답장, SUP-05)만 막고 작업 시점은 Phase 5 무렵으로 둠. ROADMAP External Gates 표를 절차서에 맞춤 (D-14) (01-09)
- [Phase 01]: G-01-8: 데이터 목록 「수탁자」 열 이름은 유지하고, 머리에 분류 출처(PRIV-03, Phase 7 성공 기준 2)를 밝히며 Meta (Facebook SDK)의 수탁·제3자 제공 구분은 Phase 7로 넘김
- [Phase 02]: 기준 커밋 BASE_SHA=db505d71d3d2 (Phase 2 첫 사이트 커밋 전 HEAD) (02-01)
- [Phase 02]: check-site.sh 2번 항목에 빌드 원본의 .nojekyll 검사를 더함. 운영만 Jekyll을 건너뛰어 내부 문서가 공개되는 경우는 로컬 빌드로 못 잡기 때문 (02-01)
- [Phase 02]: use_worktrees=true인 채로 실행했으나 precondition(메인 체크아웃)이 충족되어 진행. 설정 파일은 고치지 않음 (02-01)
- [Phase 02]: 02-02: 첫 공개 방식 base-first (사용자 결정). 기준 커밋 db505d71d3d2만 원격 main에 푸시, 빌드 설정 커밋 7773b163f3de·7f13a622878b와 기록 커밋은 미공개. 푸시 ①은 02-03에서 따로 승인
- [Phase 02]: 02-02: 새 배포가 바이트가 같은 파일의 Last-Modified도 올림을 관찰(RESEARCH A2 성립, 1회). Last-Modified 기준 신선도 판정 유지
- [Phase 02]: 푸시 ① 승인(사용자, blocking-human): d5a6679631d7만 원격 main에 푸시 (db505d71d3d2 → d5a6679631d7). 승인은 이 푸시 한 번에만 씀
- [Phase 02]: Last-Modified 기준 신선도 판정 유지: 바이트가 같은 문서도 새 배포 시각으로 last-modified가 올라감을 두 번째 배포에서도 관찰 (RESEARCH A2)
- [Phase 02]: 02-04: 법적 3종을 legal 레이아웃과 include 네 개(header·footer·head-links·css/common.css)로 전환. 커밋 세 개(6994b6f27976, c13cf8a17b84, 8cf18dd40673) 모두 기준 db505d71d3d2와 네 문서 바이트 동일, _site 파일 목록 동일. 푸시 안 함 (푸시 ② 후보)
- [Phase 02]: 02-04: legal 레이아웃의 description·eyebrow는 render-if-present 대상이 아님(값이 없으면 빈 문자열). 레이아웃을 쓰는 새 페이지는 두 값을 채워야 함
- [Phase 02]: 푸시 ② 승인 (사용자 결정, Task 2 blocking-human checkpoint): 01f6bb8bbb13 하나만 원격 main에 푸시. 승인은 이 푸시 한 번에만 썼다
- [Phase 02]: 운영 빌드(github-pages)와 로컬 Jekyll 3.10.0의 레이아웃·include 처리 차이는 푸시 ② 배포에서 드러나지 않았다. 랜딩 전환(02-06)도 같은 절차로 진행한다
- [Phase 02]: 02-06: 랜딩을 layout: none과 include 네 줄로 전환. 전환 커밋 762734f26068이 기준 db505d71d3d2와 네 문서 바이트 동일, _site 파일 목록 동일. 푸시 안 함 (D-15 세 번째 푸시 후보)
- [Phase 02]: 02-06: include 하나를 바꾸면 네 문서가 모두 바뀜을 시험용 worktree에서 확인 (4×4, 커밋 안 함). 레이아웃 변경은 법적 세 문서만 바꾸는 것이 의도한 동작 (D-03)
- [Phase 02]: [02-07] 푸시 ③ 승인 (사용자 결정): e7e62f3f7990 하나만 원격 main에 푸시. 승인은 이 푸시 한 번에만 썼다
- [Phase 02]: [02-07] 운영 빌드가 랜딩의 인라인 스크립트·SVG를 Liquid로 처리해도 출력이 기준 원본과 같았다 (live-check 통과, 네 페이지 공통 블록 한 벌이 라이브에 있음)
- [Phase 02]: 02-08: 「공통」 CSS 머리 주석 수정 커밋 b11e43b49c0a. 주석 제거 비교에서 네 문서가 기준 db505d71d3d2와 같고, 주석 그대로 비교에서는 머리 주석 한 줄만 다름 (사용자 승인 예외, ROADMAP 성공 기준 1 문구는 고치지 않음)
- [Phase 02]: 02-08: 원본 맵 STACK·CONVENTIONS·ARCHITECTURE를 지금 구조(include 네 개, _layouts/legal.html, bundle exec jekyll serve --livereload, scripts/check-site.sh)로 고침. .claude/CLAUDE.md 재생성은 02-09에서 함. 푸시 안 함
- [Phase 02]: 02-09: 두 CLAUDE.md 문서 커밋 8fd222b50994. 생성기 사본 시험에서 바뀐 블록은 stack·conventions·architecture뿐이고 방침 구간·project·workflow는 그대로여서 저장소에서 --auto 없이 재생성함. 푸시 안 함
- [Phase 02]: 02-09: TESTING의 공통 블록 한 벌 확인 git grep은 경로를 '*.html'·'*.css'로 좁힘 (문자열을 인용한 .planning 문서 제외). README·TESTING·STRUCTURE 4da23cee314e, CONCERNS 2079ea4e0b25, 성공 기준 3 grep 0건
- [Phase 02]: 푸시 ④는 승인된 9f715c795830 하나만 원격 main에 푸시했고 live-check --no-comments가 통과했다 (LIVE_PUSH4=OK)
- [Phase 02]: Phase 2 성공 기준 1~4 충족 판정. 기준 1의 「공통」 머리 주석 한 줄 차이는 D-06 승인 예외로 판정표에 명시, ROADMAP 문구는 미수정
- [Phase 02]: PROJECT.md 72행 부근 현재 사이트 설명과 115행 부근 Key Decisions 행은 단계 전환 갱신에서 고치고 그때 .claude/CLAUDE.md를 재생성 → 2026-11-16 전환에서 고침. 재생성 결과는 바이트 동일(project 구간이 Context·Key Decisions를 담지 않음)
- [Phase 02]: UAT 3/3 통과 (2026-11-16). ROADMAP 성공 기준 1 문구를 D-06 예외에 맞게 고침(override 대신, 5cca635). 로컬 미리보기는 Playwright로 전환 전 db505d7과 픽셀 비교해 자동 통과
- [Phase 02]: Playwright MCP가 저장소 안 `.playwright-mcp/`에 로그를 쓰면 `jekyll serve --livereload`가 새로 고침을 끝없이 반복함. 자동 화면 확인 때는 livereload.js를 막거나 `--livereload` 없이 띄움 (도구 간섭, 사이트 결함 아님)
- [Phase 03]: [03-01] 기준 BASE_SHA=8b65fdb59232 (라이브 9f715c795830과 같은 사이트), Tailwind CDN 3.4.17. 기준 캡처 base1·base2 자기 차이 0 (BASE_SELFDIFF=OK), 한 픽셀 음성 대조 FAIL (JUDGE_NEG=OK)
- [Phase 03]: [03-01] 검증 도구는 사용자 지시로 npm 대신 pnpm 10.33.2로 스크래치 $W/pw에 설치 (playwright 1.59.1, pngjs 7.0.0 고정, 브라우저는 캐시 재사용)
- [Phase 03]: legal.css는 RESEARCH 원안 그대로에 그림자 색·흰 덮개 주석 한 줄만 더했고, 껍데기 클래스 교체(rp-legal-*·rp-doc)는 커밋 ①에서 했다. ①(Preflight 있음)과 ③ 미리보기(Preflight 없음) 모두 base1과 픽셀 0 (03-02)
- [Phase 03]: ③ 미리보기에서 Preflight 대체 규칙(html line-height 1.5, .rp-doc :where() margin 초기화, 제목 margin 단축)이 맞음을 확인해 legal.css 고침 커밋(CSS_FIX_SHA) 없이 03-03(②)로 넘어간다 (03-02)
- [Phase 03]: 커밋 ②는 세 법적 문서를 한 커밋으로 했고, 끝 안내 footer 안에는 p를 두지 않고 글을 바로 넣었다 (03-03)
- [Phase 03]: 판정이 처음 후보에서 통과해 legal.css 고침 커밋이 없다. 03-04의 ③ 미리보기 출처는 계속 c1(C1_SHA)이다 (03-03)
- [Phase 03]: 커밋 ③ 판정이 첫 후보에서 통과해 CSS_FIX_SHA 없음. Preflight 없이 legal.css만으로 기준과 픽셀 0 (03-04)
- [Phase 03]: check-site 5번 항목(Tailwind Play CDN 없음)은 ③ 뒤 별도 build 커밋. ①·② 점검은 그 커밋 시점 스크립트로 (03-04)
- [Phase 03]: 사용자가 시험 본문 모양을 승인하고 표 머리 행 정책으로 nowrap을 골랐다(D-19). legal.css .rp-doc th 한 줄을 별도 사이트 커밋 fb6bdfa40b70으로 넣었고 기준과 픽셀 0, 시험 본문 PASS (03-05)
- [Phase 03]: 사용자가 사이트 푸시를 승인(push, SHA 2ebeca06ca51)해 그 SHA 하나만 pre-push 훅 통과 뒤 원격 main에 푸시. 라이브 빌드·HTTP·화면(JUDGE live OK) 모두 OK라 되돌리기 없음 (03-06)
- [Phase 03]: 03-07: 법적 본문 작성 규칙(D-01~D-12, figure tabindex="0" aria-label 감싸개, nowrap 머리 행)은 .planning/codebase/CONVENTIONS.md 「법적 본문 작성 규칙」 절에 두고, 생성기가 일반 문단을 버리므로 목록 항목으로만 쓴다
- [Phase 03]: 03-07: 범위 없는 선택자 금지는 본문 요소 규칙에만 적용한다. legal.css의 body·main·.rp-grid 레이아웃 규칙은 법적 페이지에서만 불리므로 허용
- [Phase 03]: 03-08: 루트 CLAUDE.md의 법적 본문 작성 규칙은 D-01~D-04·D-07과 세 곳 동시 수정 규칙만 적고, 요소별 모양(D-05~D-12)은 원본 맵 CONVENTIONS 「법적 본문 작성 규칙」 절을 가리킨다
- [Phase 03]: 03-08: 두 CLAUDE.md 문서 커밋 19dbbe78627c(방침 행 「Phase 3까지 적용됨」, 생성기 사본 시험에서 stack·conventions·architecture만 바뀌어 --auto 없이 재생성), README 커밋 629c2dfad614. 열 개 문서 Tailwind 흔적 0줄(DOCS_STALE=OK). 푸시 안 함
- [Phase 03]: 03-09: 사용자가 문서 푸시를 승인(push, SHA 3f148e83d849)해 그 SHA 하나만 pre-push 훅 통과 뒤 원격 main에 푸시. 빌드 built, 세 법적 URL과 / 200·제목·Tailwind 0 (LIVE_DOCS=OK)
- [Phase 03]: 03-09: /CLAUDE.md·/README.md 첫 읽기의 503(CDN 가장자리 일시 오류, 대조 경로도 같음)은 사용자 결정 other로 404 판정(원 서버 늘 404, 200은 0). 되돌리기 푸시 없음. 푸시하지 않은 되돌림 커밋 641d7bfb7718·0e94067c885c는 reset --keep로 제거. 계획 404 문자 규칙·D-23의 사용자 승인 예외
- [Phase 03]: 03-09: Phase 3 성공 기준 1~4 충족(PHASE3_SC=OK). 실제 Safari·iOS Safari, 다른 폭, 고배율, 화면 낭독기, D-08 끝까지 민 뒤 그림자 소멸, D-07 실제 Safari Tab 도달은 범위 밖으로 단계 끝 사람 확인에 넘김
- [Phase 03]: UAT 8/8 통과 (2026-11-17). 1·6·7번은 사용자가, 2·3·4·5·8번은 사용자 요청으로 Claude가 확인: 다른 폭·DPR 90건(Playwright, DPR은 에뮬레이션), 실제 macOS Safari AX 트리와 Chromium AX 트리(VoiceOver 음성·iOS 미확인), 시험 본문 표 그림자 픽셀 측정(scrollLeft를 코드로 이동), 실제 macOS Safari Tab·화살표 키(iOS Safari 미확인), 금지 사항 표 근거 재실행(27행 OK, --no-verify는 7번으로 갈음)
- [Phase 03]: 코드 리뷰 WR-01(rem→px)은 UAT 6번에서 사용자가 px 고정을 받아들임. REVIEW-DISPOSITION을 deferred로 바꾸고 PROJECT.md Key Decisions에 기록
- [Phase 03]: 스크래치 `$W/pw`의 Playwright 패키지 파일이 macOS 임시 폴더 정리로 지워져 있었음. 03-01 승인 범위(같은 경로·같은 고정 버전)대로 `pnpm --dir "$W/pw" install --frozen-lockfile --force`로 재설치함 (UAT 중). 스크래치 도구는 오래 두면 사라질 수 있음
- [Phase 04]: 04-01: 기준 문장 세 곳(ROADMAP Phase 4 Goal·성공 기준 2, SITE-06)의 출시 전 표시를 「출시 전임을 알리는 표시(현재 「출시 준비 중」)」로 고침. Phase 9 문구는 유지 (D-08)
- [Phase 04]: 04-01: USER-TASKS 작업 10을 iPhone 한 기기·화면 세 장·하단 탭 없음·NAVER 로고 유지·검색 결과 목록 없음 조건으로 고침 (D-16~D-20)
- [Phase 04]: 04-02: Playwright 1.59.1 설치 승인(install, 브라우저 포함) — pnpm 고정, 스크래치 $W/pw만, Phase 4 동안 같은 버전·경로 재설치 포함. 브라우저는 캐시 리비전이 맞아 받지 않음
- [Phase 04]: 04-02: 기준 BASE_SHA=0e75e8b88fd2(라이브 0bfe5b210c3c와 같은 사이트). p4-behave.mjs가 기준 PASS, rp-run-btn 깬 사본 FAIL+pageerror — 이후 사이트 커밋 후보마다 이 도구로 판정
- [Phase 04]: 04-03: 문구 커밋(abdeb52284d6)은 index.html 네 줄만 담고 빈 뱃지 그림은 04-04 커밋으로 남김 (D-22). 푸시는 04-05
- [Phase 04]: 04-04: 빈 뱃지 다섯 개를 받은 뱃지 색(줄 흑연·노랑·빨강, 스티커 고양이 노랑·왕관 빨강)으로 바꾸고 .rp-badge.t-empty 규칙을 지운 커밋 f8d66a6469cf를 남김. 푸시는 04-05에서 문구 커밋과 함께 (D-06, D-22)
- [Phase 04]: 04-05: 승인받은 073d33e0e50a 하나만 원격 main에 푸시했고, Pages built 뒤 라이브 /가 빈 뱃지 커밋 빌드와 바이트가 같고 두 엔진 PASS behave라 되돌림 없이 LIVE_PUSH1=OK

### Pending Todos

None yet.

### Blockers/Concerns

사용자 외부 작업(단계를 막음):
- 가비아 DNS 1차 방문(Google Workspace 도메인 인증 TXT·MX·SPF 1개, Search Console TXT. 기존 레코드는 보존, 절차는 `.planning/baseline/USER-TASKS.md`)과 메일 수신 시험 → Phase 5 (이메일 게이트, Phase 6·7 커밋의 전제)
- 가비아 DNS 2차 방문(DKIM, 절차는 `.planning/baseline/USER-TASKS.md` 작업 6. 작업 시점은 Phase 5 무렵) → Phase 10 (Apple 릴레이 답장의 전제. 이메일 게이트는 DKIM을 기다리지 않음)
- Apple Developer에 지원 메일 발신 도메인 등록, 릴레이 답장 시험 → Phase 10
- 실제 앱 화면 캡처(출시 범위 기능만) → Phase 4

사용자·법률 결정(Phase 1에서 결정 목록으로 넘김):
- U11 사업자 값과 영문 법인명 → Phase 5·8·9 (U12는 결정됨: Google Workspace 사용자 별칭 도메인, 지원 주소에서 답장. `.planning/baseline/DECISIONS.md`)
- U3 소상공인 해당, U5 Email/Password 노출 → Phase 7 / U6 탈퇴 후 코스 처리 → Phase 6·8
- U7 14세 미만 정책 → Phase 7·8 / U2 위치정보법 분류, U8 네이버 지도 고지 → Phase 8
- U9 Meta 비즈니스 인증, U13 Google 브랜드 검증 → Phase 10

연구 필요(계획 단계에서 확인): Phase 7 처리방침 작성지침 원문, Phase 8 위치정보법 분류(법률 확인 필수), Phase 10 콘솔별 필드명

Phase 3에서 넘어온 것:
- [Phase 03] 코드 리뷰 WR-02 open: `scripts/check-site.sh` 5번 항목이 `@tailwindcss/browser` 스크립트와 `<style type="text/tailwindcss">`를 잡지 못함. 고칠지 사람이 정해야 함 (`03-REVIEW.md`). Info IN-01~06도 open이고, 그중 IN-01(`th` nowrap이 `tbody`의 행 머리에도 걸림)은 Phase 7 처리 위탁 표를 쓸 때 다시 봄
- [Phase 03] Phase 7에서 실제 처리 위탁 표가 들어오면 실기기 iOS Safari와 VoiceOver 음성으로 표 읽기·Tab 도달·스크롤 그림자를 다시 확인함 (Phase 3 UAT는 시험 본문, macOS Safari, 접근성 트리까지만 확인)

## Deferred Items

Items acknowledged and deferred at milestone close, most recent first:

| Category | Item | Status | Deferred At | Milestone |
|----------|------|--------|-------------|-----------|
| *(none)* | | | | |

## Session Continuity

Last session: 2026-11-17T05:46:54.291Z
Stopped at: Completed 04-05-PLAN.md
Resume file: None
