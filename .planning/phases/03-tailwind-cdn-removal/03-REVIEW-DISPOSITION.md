---
phase: 03
review: 03-REVIEW.md
titles: json
findings:
  - id: WR-01
    severity: warning
    disposition: open
    title: "rem 기반 유틸리티를 px로 옮겨, 브라우저 기본 글꼴 크기를 바꾼 사용자에게서 제목·간격 위계가 무너짐"
  - id: WR-02
    severity: warning
    disposition: open
    title: "5번 점검 항목이 `@tailwindcss/browser` 스크립트와 `text/tailwindcss` 스타일을 잡지 못함"
  - id: IN-01
    severity: info
    disposition: open
    title: "`th { white-space: nowrap }`가 머리 행뿐 아니라 `tbody`의 행 머리(`th scope=\"row\"`)에도 걸림"
  - id: IN-02
    severity: info
    disposition: open
    title: "`ol:lang(en)` 규칙은 레이아웃이 `lang=\"ko\"`로 고정되어 있어 지금 구조로는 걸릴 수 없음"
  - id: IN-03
    severity: info
    disposition: open
    title: "`:where()`를 쓴 셀렉터 목록은, `:where`를 모르는 브라우저에서 같은 규칙의 다른 셀렉터까지 함께 버려짐"
  - id: IN-04
    severity: info
    disposition: open
    title: "4·5번 점검의 grep 오류가 「일치 없음」과 구분되지 않아 통과로 처리됨 (fail-open)"
  - id: IN-05
    severity: info
    disposition: open
    title: "Cargo-culted pattern — Tailwind Preflight·`transition-colors`에서 옮긴, 효과 없는 선언"
  - id: IN-06
    severity: info
    disposition: open
    title: "`legal.css` 머리 주석의 「함께 고칠 곳」이 CLAUDE.md 규칙보다 좁음"
open: 8
total: 8
recorded: 2026-11-16T18:51:48.727Z
---

# Phase 03: Code Review Disposition

| Finding | Severity | Disposition | Source |
|---------|----------|-------------|--------|
| WR-01 | warning | open | - |
| WR-02 | warning | open | - |
| IN-01 | info | open | - |
| IN-02 | info | open | - |
| IN-03 | info | open | - |
| IN-04 | info | open | - |
| IN-05 | info | open | - |
| IN-06 | info | open | - |

Dispositions: `open` (recorded, not yet triaged), `fixed`, `skipped`, `deferred`.
Set `deferred` by hand and put the reason in the Source cell; both are preserved. A `|` in the reason is kept as prose and escaped on the next run.
Re-running the gate keeps every row it can. A row the current review no longer reports is kept and its Source cell flagged, so a finding does not leave this record silently. ONE exception: when a finding id is REUSED by a different finding, the earlier decision cannot keep a row — the id is taken — and it is dropped. A RECORDED decision (anything but `open`) is named on the console when that happens; a row still at `open` is replaced silently, because `open` records no decision to lose.
