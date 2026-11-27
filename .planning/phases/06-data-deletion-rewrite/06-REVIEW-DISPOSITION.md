---
phase: 06
review: 06-REVIEW.md
titles: json
findings:
  - id: WR-01
    severity: warning
    disposition: open
    title: "점검 8번 본문 추출이 종료 줄을 못 찾으면 푸터까지 읽어 거짓 통과함 (fail-open)"
  - id: WR-02
    severity: warning
    disposition: open
    title: "점검 8번 mailto 검사는 `#request` 요청 경로(D-20)가 아니라 본문 아무 곳의 mailto로 통과함"
  - id: WR-03
    severity: warning
    disposition: open
    title: "콘솔·스토어에 등록하는 고정 앵커가 있는지 점검하지 않음"
  - id: WR-04
    severity: warning
    disposition: open
    title: "`support_email`이 비면 본문 참조가 어긋남 (「2~4번」·외톨이 ①·숨은 이메일을 가리키는 무조건 문장)"
open: 4
total: 4
recorded: 2026-11-27T04:54:06.526Z
---

# Phase 06: Code Review Disposition

| Finding | Severity | Disposition | Source |
|---------|----------|-------------|--------|
| WR-01 | warning | open | - |
| WR-02 | warning | open | - |
| WR-03 | warning | open | - |
| WR-04 | warning | open | - |

Dispositions: `open` (recorded, not yet triaged), `fixed`, `skipped`, `deferred`.
Set `deferred` by hand and put the reason in the Source cell; both are preserved. A `|` in the reason is kept as prose and escaped on the next run.
Re-running the gate keeps every row it can. A row the current review no longer reports is kept and its Source cell flagged, so a finding does not leave this record silently. ONE exception: when a finding id is REUSED by a different finding, the earlier decision cannot keep a row — the id is taken — and it is dropped. A RECORDED decision (anything but `open`) is named on the console when that happens; a row still at `open` is replaced silently, because `open` records no decision to lose.
