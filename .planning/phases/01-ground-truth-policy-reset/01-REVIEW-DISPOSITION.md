---
phase: 01
review: 01-REVIEW.md
titles: json
findings:
  - id: WR-01
    severity: warning
    disposition: open
    title: "「작업 규칙」에서 「빠지면 안 되는 조항은 값이 올 때까지 커밋 보류」 단서가 빠짐"
  - id: WR-02
    severity: warning
    disposition: open
    title: "「원본은 Ground Rules」라고 밝혔지만 규칙 목록이 원본과 다름"
  - id: WR-03
    severity: warning
    disposition: open
    title: "두 파일에 복사한 방침 구간의 일치를 이번 단계에서 한 번만 확인했고 반복 확인 절차가 없음"
  - id: IN-01
    severity: info
    disposition: open
    title: "`.claude/CLAUDE.md`의 `.gitignore` 요약이 이번 단계 변경을 반영하지 않음"
  - id: IN-02
    severity: info
    disposition: open
    title: "「연락은 공개 지원 이메일로만 받는다」가 현재 상태와 맞지 않음"
  - id: IN-03
    severity: info
    disposition: open
    title: "두 문서의 앱 설명이 서로 다름"
  - id: IN-04
    severity: info
    disposition: open
    title: "생성 구간의 줄 번호 하나와 명명 예시 파일이 실제와 다름 (이번 diff 밖, 원래 있던 문제)"
  - id: IN-05
    severity: info
    disposition: open
    title: "「주소는 `.planning/` 문서에만 있다」 문장은 사이트 기준으로만 맞음"
open: 8
total: 8
recorded: 2026-11-15T08:14:39.296Z
---

# Phase 01: Code Review Disposition

| Finding | Severity | Disposition | Source |
|---------|----------|-------------|--------|
| WR-01 | warning | open | - |
| WR-02 | warning | open | - |
| WR-03 | warning | open | - |
| IN-01 | info | open | - |
| IN-02 | info | open | - |
| IN-03 | info | open | - |
| IN-04 | info | open | - |
| IN-05 | info | open | - |

Dispositions: `open` (recorded, not yet triaged), `fixed`, `skipped`, `deferred`.
Set `deferred` by hand and put the reason in the Source cell; both are preserved. A `|` in the reason is kept as prose and escaped on the next run.
Re-running the gate keeps every row it can. A row the current review no longer reports is kept and its Source cell flagged, so a finding does not leave this record silently. ONE exception: when a finding id is REUSED by a different finding, the earlier decision cannot keep a row — the id is taken — and it is dropped. A RECORDED decision (anything but `open`) is named on the console when that happens; a row still at `open` is replaced silently, because `open` records no decision to lose.
