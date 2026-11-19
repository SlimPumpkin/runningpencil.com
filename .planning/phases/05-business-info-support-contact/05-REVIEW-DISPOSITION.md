---
phase: 05
review: 05-REVIEW.md
titles: json
findings:
  - id: WR-01
    severity: warning
    disposition: open
    title: "7번 점검의 `mailto:` 확인이 공유 푸터에 걸려, 지원 페이지 본문의 연락처·앵커가 빠져도 통과한다"
  - id: WR-02
    severity: warning
    disposition: open
    title: "어두운 푸터에서 포커스 테두리 대비가 약 2.1:1로, 새 이메일 링크와 「고객 지원」 링크에도 그대로 적용된다"
  - id: WR-03
    severity: warning
    disposition: open
    title: "Already-defended-elsewhere — 7번 점검의 「링크는 있는데 페이지가 없음」 분기는 3번 점검이 이미 잡는다"
  - id: IN-01
    severity: info
    disposition: open
    title: "푸터의 운영 안내·저작권 문장이 운영사 이름을 하드코딩해 `trade_name` 슬롯과 따로 논다"
  - id: IN-02
    severity: info
    disposition: open
    title: "지원 FAQ가 값 바로 뒤에 조사(「입니다」)를 붙여 규칙 문구와 어긋난다"
  - id: IN-03
    severity: info
    disposition: open
    title: "전화만 있고 이메일이 없으면 푸터에는 전화가 나오지만 `/support/`에는 나오지 않는다. 루트 `CLAUDE.md`의 이메일 행 설명도 실제 조건과 다르다"
  - id: IN-04
    severity: info
    disposition: open
    title: "`_data/company.yml`의 값 규칙(공백만 금지, 자리표시 금지)이 주석으로만 있고 점검이 없다"
open: 7
total: 7
recorded: 2026-11-19T19:34:29.518Z
---

# Phase 05: Code Review Disposition

| Finding | Severity | Disposition | Source |
|---------|----------|-------------|--------|
| WR-01 | warning | open | - |
| WR-02 | warning | open | - |
| WR-03 | warning | open | - |
| IN-01 | info | open | - |
| IN-02 | info | open | - |
| IN-03 | info | open | - |
| IN-04 | info | open | - |

Dispositions: `open` (recorded, not yet triaged), `fixed`, `skipped`, `deferred`.
Set `deferred` by hand and put the reason in the Source cell; both are preserved. A `|` in the reason is kept as prose and escaped on the next run.
Re-running the gate keeps every row it can. A row the current review no longer reports is kept and its Source cell flagged, so a finding does not leave this record silently. ONE exception: when a finding id is REUSED by a different finding, the earlier decision cannot keep a row — the id is taken — and it is dropped. A RECORDED decision (anything but `open`) is named on the console when that happens; a row still at `open` is replaced silently, because `open` records no decision to lose.
