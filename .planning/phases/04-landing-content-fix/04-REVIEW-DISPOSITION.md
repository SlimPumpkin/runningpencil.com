---
phase: 04
review: 04-REVIEW.md
titles: json
findings:
  - id: WR-01
    severity: warning
    disposition: fixed
    title: "`.claude/CLAUDE.md`의 `index.html` 줄 번호가 이번 단계의 줄 이동을 반영하지 않음"
  - id: IN-01
    severity: info
    disposition: fixed
    title: "점검 6번 항목의 `포인트`가 「체크포인트」 같은 다른 낱말에도 걸림 (오탐)"
  - id: IN-02
    severity: info
    disposition: fixed
    title: "점검 스크립트의 랜딩 제목 주석이 Phase 4 완료 뒤에도 「Phase 4에서 바뀔 수 있다」고 함"
  - id: IN-03
    severity: info
    disposition: fixed
    title: "넓은 화면에서 `.rp-shots`의 `tabindex=\"0\"`이 기능 없는 탭 멈춤 자리가 됨"
  - id: IN-04
    severity: info
    disposition: fixed
    title: "같은 강아지 모양 코스가 랜딩 목업에서는 「댕댕런」, 실제 캡처에서는 「강아지런」"
  - id: IN-05
    severity: info
    disposition: skipped
    title: "`screen-badge-*.webp` 캡처에서 NAVER 로고가 앱의 뱃지 창에 일부 가려짐"
open: 0
total: 6
recorded: 2026-11-18T09:00:10.376Z
---

# Phase 04: Code Review Disposition

| Finding | Severity | Disposition | Source |
|---------|----------|-------------|--------|
| WR-01 | warning | fixed | 04-REVIEW-FIX.md |
| IN-01 | info | fixed | 04-REVIEW-FIX.md |
| IN-02 | info | fixed | 04-REVIEW-FIX.md |
| IN-03 | info | fixed | 04-REVIEW-FIX.md |
| IN-04 | info | fixed | 04-REVIEW-FIX.md |
| IN-05 | info | skipped | 04-REVIEW-FIX.md |

Dispositions: `open` (recorded, not yet triaged), `fixed`, `skipped`, `deferred`.
Set `deferred` by hand and put the reason in the Source cell; both are preserved. A `|` in the reason is kept as prose and escaped on the next run.
Re-running the gate keeps every row it can. A row the current review no longer reports is kept and its Source cell flagged, so a finding does not leave this record silently. ONE exception: when a finding id is REUSED by a different finding, the earlier decision cannot keep a row — the id is taken — and it is dropped. A RECORDED decision (anything but `open`) is named on the console when that happens; a row still at `open` is replaced silently, because `open` records no decision to lose.
