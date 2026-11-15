---
gsd_state_version: "1.0"
current_phase: 01
current_phase_name: 기준표와 방침 정비 (Ground Truth & Policy Reset)
status: verifying
stopped_at: Completed 01-08-PLAN.md
last_updated: "2026-11-15T07:48:15.255Z"
last_activity: 2026-11-14
last_activity_desc: Phase 01 execution started
state_head: d700b1f7c83b6e1295bcef8f21a6ac998c626680
progress:
  total_phases: 10
  completed_phases: 0
  total_plans: 8
  completed_plans: 8
  percent: 0
---

# Project State

## Project Reference

See: .planning/PROJECT.md (updated 2026-11-14)

**Core value:** 소셜 로그인 제공자와 스토어 심사자가 이 사이트만 보고 서비스·운영 주체·개인정보 처리·연락과 삭제 방법을 확인할 수 있어, 심사가 웹사이트 때문에 반려되지 않는다
**Current focus:** Phase 01 — 기준표와 방침 정비 (Ground Truth & Policy Reset)

## Current Position

Phase: 01 (기준표와 방침 정비 (Ground Truth & Policy Reset)) — EXECUTING
Plan: 8 of 8
Status: Phase complete — ready for verification
Last activity: 2026-11-14 — Phase 01 execution started

Progress: [░░░░░░░░░░] 0%

## Performance Metrics

**Velocity:**
- Total plans completed: 0
- Average duration: -
- Total execution time: 0 hours

**By Phase:**

| Phase | Plans | Total | Avg/Plan |
|-------|-------|-------|----------|
| - | - | - | - |

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

### Pending Todos

None yet.

### Blockers/Concerns

사용자 외부 작업(단계를 막음):
- 가비아 DNS 레코드 추가(1차 방문: Google Workspace 도메인 인증 TXT·MX·SPF 1개, Search Console TXT. 2차 방문: DKIM. 기존 레코드는 보존, 절차는 `.planning/baseline/USER-TASKS.md`)와 메일 수신 시험 → Phase 5 (이메일 게이트, Phase 6·7 커밋의 전제)
- Apple Developer에 지원 메일 발신 도메인 등록, 릴레이 답장 시험 → Phase 10
- 실제 앱 화면 캡처(출시 범위 기능만) → Phase 4

사용자·법률 결정(Phase 1에서 결정 목록으로 넘김):
- U11 사업자 값과 영문 법인명 → Phase 5·8·9 (U12는 결정됨: Google Workspace 사용자 별칭 도메인, 지원 주소에서 답장. `.planning/baseline/DECISIONS.md`)
- U3 소상공인 해당, U5 Email/Password 노출 → Phase 7 / U6 탈퇴 후 코스 처리 → Phase 6·8
- U7 14세 미만 정책 → Phase 7·8 / U2 위치정보법 분류, U8 네이버 지도 고지 → Phase 8
- U9 Meta 비즈니스 인증, U13 Google 브랜드 검증 → Phase 10

연구 필요(계획 단계에서 확인): Phase 1 데이터 목록(리전·보존 기간·SDK 자동 수집), Phase 7 처리방침 작성지침 원문, Phase 8 위치정보법 분류(법률 확인 필수), Phase 10 콘솔별 필드명

## Deferred Items

Items acknowledged and deferred at milestone close, most recent first:

| Category | Item | Status | Deferred At | Milestone |
|----------|------|--------|-------------|-----------|
| *(none)* | | | | |

## Session Continuity

Last session: 2026-11-15T07:48:15.241Z
Stopped at: Completed 01-08-PLAN.md
Resume file: None
