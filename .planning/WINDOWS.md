---
schema_version: 1
open_count: 1
waived_count: 0
fixed_count: 0
total_count: 1
last_updated: 2026-11-18T05:39:36.265Z
---

# Broken Windows Ledger

> Cross-phase defect register. With `workflow.windows_enforce` enabled, `/gsd-ship` blocks while `open_count > 0`.
> Waive with `gsd-tools windows waive <id> "<reason>"` (reason required).
> Mark fixed with `gsd-tools windows fixed <id>`.

| id | phase | kind | file | line | description | status | reason | recorded_at | resolved_at |
|----|-------|------|------|------|-------------|--------|--------|-------------|-------------|
| 1 | 04 | deviation | .planning/phases/04-landing-content-fix/04-EVIDENCE.md |  | 04-09 사용자 예외 3건: badge 로고 가림(D-20), run·badge 상태 표시줄 차이(D-18). 앱 수정 뒤 ③ 교체 | open |  | 2026-11-18T05:39:36.265Z |  |

````json
[
  {
    "id": 1,
    "kind": "deviation",
    "phase": "04",
    "file": ".planning/phases/04-landing-content-fix/04-EVIDENCE.md",
    "line": null,
    "description": "04-09 사용자 예외 3건: badge 로고 가림(D-20), run·badge 상태 표시줄 차이(D-18). 앱 수정 뒤 ③ 교체",
    "status": "open",
    "reason": "",
    "recorded_at": "2026-11-18T05:39:36.265Z",
    "resolved_at": null,
    "milestone": null
  }
]
````
