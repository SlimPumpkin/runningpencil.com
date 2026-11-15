---
phase: 01
review: 01-REVIEW.md
titles: json
findings:
  - id: WR-07
    severity: warning
    disposition: open
    title: "`STACK.md`의 굵은 소제목과 하위 목록이 버려져 Technology Stack 구간에 주어 없는 줄이 남음"
  - id: WR-08
    severity: warning
    disposition: open
    title: "Conventions의 `<head>` 순서가 실제 네 페이지와 다름"
  - id: IN-09
    severity: info
    disposition: open
    title: "Data Flow의 `index.html` 줄 번호 다섯 개가 실제와 1~4줄 어긋남"
  - id: IN-10
    severity: info
    disposition: open
    title: "생성기는 본문에 들어간 마커 문자열도 구간의 시작으로 아는데, 이 위험이 어느 문서에도 없음"
  - id: IN-11
    severity: info
    disposition: open
    title: "Linting 줄의 「CLAUDE.md의 \"커밋 전 린터 실행\" 규칙」과 「`TESTING.md` 참고」가 저장소 안에서 찾을 수 없는 곳을 가리킴"
  - id: WR-06
    severity: warning
    disposition: fixed
    title: "생성기가 원본의 소제목 줄·코드 블록·번호 목록·하위 목록을 버려서 `.claude/CLAUDE.md`의 여러 구간이 뜻을 잃음"
  - id: IN-07
    severity: info
    disposition: fixed
    title: "생성 구간 규칙의 「마커의 `source:`가 가리키는 파일」과 「`generate-claude-md`로 다시 만듭니다」가 일부 구간에 맞지 않음"
  - id: IN-08
    severity: info
    disposition: fixed
    title: "Deploy 문단이 한 문단 안에서 「푸시」와 「커밋」을 배포 시점으로 번갈아 씀"
  - id: WR-04
    severity: warning
    disposition: fixed
    title: "두 사본 비교 명령이 방침 구간을 찾지 못해도 「통과」로 끝남 (WR-03 수정의 빈틈)"
  - id: WR-05
    severity: warning
    disposition: fixed
    title: "「`CLAUDE.md`도 함께 고친다」 규칙이 `.claude/CLAUDE.md` 생성 구간은 원본에서 고쳐야 한다는 점을 말하지 않음"
  - id: IN-01
    severity: info
    disposition: fixed
    title: "`.claude/CLAUDE.md`의 `.gitignore` 요약이 이번 단계 변경을 반영하지 않음"
  - id: IN-02
    severity: info
    disposition: fixed
    title: "「연락은 공개 지원 이메일로만 받는다」가 현재 상태와 맞지 않음"
  - id: IN-03
    severity: info
    disposition: fixed
    title: "두 문서의 앱 설명이 서로 다름"
  - id: IN-04
    severity: info
    disposition: fixed
    title: "생성 구간의 줄 번호 하나와 명명 예시 파일이 실제와 다름 (이번 diff 밖, 원래 있던 문제)"
  - id: IN-05
    severity: info
    disposition: fixed
    title: "「주소는 `.planning/` 문서에만 있다」 문장은 사이트 기준으로만 맞음"
  - id: IN-06
    severity: info
    disposition: fixed
    title: "「Deploy」 구간의 「Phase 2까지 유효」가 새 작업 규칙 「`main` 푸시가 곧 배포」와 다르게 읽힘"
  - id: WR-01
    severity: warning
    disposition: fixed
    title: "「작업 규칙」에서 「빠지면 안 되는 조항은 값이 올 때까지 커밋 보류」 단서가 빠짐"
  - id: WR-02
    severity: warning
    disposition: fixed
    title: "「원본은 Ground Rules」라고 밝혔지만 규칙 목록이 원본과 다름"
  - id: WR-03
    severity: warning
    disposition: fixed
    title: "두 파일에 복사한 방침 구간의 일치를 이번 단계에서 한 번만 확인했고 반복 확인 절차가 없음"
open: 5
total: 19
recorded: 2026-11-15T18:49:07.514Z
---

# Phase 01: Code Review Disposition

| Finding | Severity | Disposition | Source |
|---------|----------|-------------|--------|
| WR-07 | warning | open | - |
| WR-08 | warning | open | - |
| IN-09 | info | open | - |
| IN-10 | info | open | - |
| IN-11 | info | open | - |
| WR-06 | warning | fixed | 1dc2f1a — 01-REVIEW-FIX.md가 제목 끝 「(이번 diff 밖, 원래 있던 문제)」를 빼고 적어 자동 대조에서 빠짐. 재생성 사본 cmp 동일, `.claude/CLAUDE.md`에 JSDoc/TSDoc 예외 줄이 돌아온 것으로 수정 확인. 2026-11-15 재리뷰(01-REVIEW.md)도 고쳐진 것을 확인 (not in the current review) |
| IN-07 | info | fixed | 01-REVIEW-FIX.md (not in the current review) |
| IN-08 | info | fixed | 01-REVIEW-FIX.md (not in the current review) |
| WR-04 | warning | fixed | 01-REVIEW-FIX.md (not in the current review) |
| WR-05 | warning | fixed | 01-REVIEW-FIX.md (not in the current review) |
| IN-01 | info | fixed | 01-REVIEW-FIX.md (not in the current review) |
| IN-02 | info | fixed | 01-REVIEW-FIX.md (not in the current review) |
| IN-03 | info | fixed | 01-REVIEW-FIX.md (not in the current review) |
| IN-04 | info | fixed | 01-REVIEW-FIX.md (not in the current review) |
| IN-05 | info | fixed | 01-REVIEW-FIX.md (not in the current review) |
| IN-06 | info | fixed | 01-REVIEW-FIX.md (not in the current review) |
| WR-01 | warning | fixed | 01-REVIEW-FIX.md (not in the current review) |
| WR-02 | warning | fixed | 01-REVIEW-FIX.md (not in the current review) |
| WR-03 | warning | fixed | 01-REVIEW-FIX.md (not in the current review) |

Dispositions: `open` (recorded, not yet triaged), `fixed`, `skipped`, `deferred`.
Set `deferred` by hand and put the reason in the Source cell; both are preserved. A `|` in the reason is kept as prose and escaped on the next run.
Re-running the gate keeps every row it can. A row the current review no longer reports is kept and its Source cell flagged, so a finding does not leave this record silently. ONE exception: when a finding id is REUSED by a different finding, the earlier decision cannot keep a row — the id is taken — and it is dropped. A RECORDED decision (anything but `open`) is named on the console when that happens; a row still at `open` is replaced silently, because `open` records no decision to lose.
