---
phase: 02
review: 02-REVIEW.md
titles: json
findings:
  - id: WR-01
    severity: warning
    disposition: open
    title: "점검 4번이 Liquid에 조용히 먹힌 내용을 잡지 못합니다. 문서는 이 항목을 raw 규칙의 안전망처럼 설명합니다"
  - id: WR-02
    severity: warning
    disposition: open
    title: "문서는 「운영과 같은 출력은 check-site.sh가 만든다」고 하지만, 출력은 남지 않고 운영 플러그인 세트도 돌지 않습니다"
  - id: IN-01
    severity: info
    disposition: open
    title: "점검 2번은 금지 목록 방식이라 `exclude`에 빠진 새 일반 파일을 잡지 못합니다"
  - id: IN-02
    severity: info
    disposition: open
    title: "`git archive | tar` 파이프라인이 실패해도 종료 코드가 0이 되어, 엉뚱한 오류로 끝납니다"
  - id: IN-03
    severity: info
    disposition: open
    title: "레이아웃이 front matter 값을 이스케이프하지 않고 `<title>`과 속성값에 넣습니다"
  - id: IN-04
    severity: info
    disposition: open
    title: "누출 파일 목록을 따옴표 없이 펼칩니다"
  - id: IN-05
    severity: info
    disposition: open
    title: "Phantom requirement — `.gitignore`의 `.jekyll-cache/`는 Jekyll 3.10.0에서 생기지 않습니다"
  - id: IN-06
    severity: info
    disposition: open
    title: "(pre-existing / out of phase scope) 법적 본문·랜딩 문구의 옛 기능 서술과 Tailwind CDN"
open: 8
total: 8
recorded: 2026-11-16T07:06:08.968Z
---

# Phase 02: Code Review Disposition

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
