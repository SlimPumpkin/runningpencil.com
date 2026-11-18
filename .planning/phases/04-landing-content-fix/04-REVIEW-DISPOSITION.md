---
phase: 04
review: 04-REVIEW.md
titles: json
findings:
  - id: WR-04
    severity: warning
    disposition: fixed
    title: "「달려 보기」 코스 딱지가 같은 강아지런 코스를 `7.84 km`로 표기해, `7.8 km`로 고친 「코스 그리기」 목업과 같은 페이지 안에서 다름"
  - id: IN-11
    severity: info
    disposition: fixed
    title: "`U10_ALLOW_PREFIX` 형식 확인이 막을 값을 나열하는 방식이라, `.`·`.*`·`^`·`$` 같은 메타문자는 오류 없이 점검 6번을 무력화함"
  - id: IN-12
    severity: info
    disposition: fixed
    title: "랜딩 출력이 없을 때 점검 6번이 `U10_ALLOW_PREFIX`를 원인처럼 보이는 메시지로 실패를 한 번 더 셈"
  - id: WR-02
    severity: warning
    disposition: fixed
    title: "「코스 그리기」 목업의 걷기·달리기·자전거 예상 시간이 옛 거리 8.3 km 기준으로 남음"
  - id: WR-03
    severity: warning
    disposition: fixed
    title: "`U10_ALLOW_PREFIX`를 비우거나 형식을 틀리면 점검 6번이 조용히 통과함 (fail-open)"
  - id: IN-09
    severity: info
    disposition: fixed
    title: "`.claude/CLAUDE.md`의 `<head>` 순서 설명이 같은 파일의 고정점 표, 그리고 실제 `index.html`과 반대임 (이번 범위 전부터 있던 것)"
  - id: IN-10
    severity: info
    disposition: fixed
    title: "「코스 그리기」 목업의 거리 표기 `7.84 km`가 앱 「코스 그리기」 화면의 소수 한 자리 표기와 다를 수 있음 (확인되지 않음)"
  - id: IN-06
    severity: info
    disposition: fixed
    title: "코스 이름을 「강아지런」으로 맞춘 뒤, 목업의 8.3 km가 같은 페이지 캡처의 숫자와 다름 (확인되지 않음)"
  - id: IN-07
    severity: info
    disposition: fixed
    title: "Generality without instantiation — 점검 6번 항목의 허용 목록 `체크포인트|엔드포인트`가 지금 랜딩에 없는 낱말만 거름"
  - id: IN-08
    severity: info
    disposition: fixed
    title: "줄 번호를 절대값으로 적는 방식이 남아 있어 다음 `index.html` 수정 때 다시 어긋남"
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
total: 16
recorded: 2026-11-18T14:58:30.086Z
---

# Phase 04: Code Review Disposition

| Finding | Severity | Disposition | Source |
|---------|----------|-------------|--------|
| WR-04 | warning | fixed | 04-REVIEW-FIX.md (not in the current review) |
| IN-11 | info | fixed | 04-REVIEW-FIX.md (not in the current review) |
| IN-12 | info | fixed | 04-REVIEW-FIX.md (not in the current review) |
| WR-02 | warning | fixed | 04-REVIEW-FIX.md (not in the current review) |
| WR-03 | warning | fixed | 04-REVIEW-FIX.md (not in the current review) |
| IN-09 | info | fixed | 04-REVIEW-FIX.md (not in the current review) |
| IN-10 | info | fixed | 04-REVIEW-FIX.md (not in the current review) |
| IN-06 | info | fixed | 04-REVIEW-FIX.md (not in the current review) |
| IN-07 | info | fixed | 04-REVIEW-FIX.md (not in the current review) |
| IN-08 | info | fixed | 04-REVIEW-FIX.md (not in the current review) |
| WR-01 | warning | fixed | 04-REVIEW-FIX.md (not in the current review) |
| IN-01 | info | fixed | 04-REVIEW-FIX.md (not in the current review) |
| IN-02 | info | fixed | 04-REVIEW-FIX.md (not in the current review) |
| IN-03 | info | fixed | 04-REVIEW-FIX.md (not in the current review) |
| IN-04 | info | fixed | 04-REVIEW-FIX.md (not in the current review) |
| IN-05 | info | skipped | 04-REVIEW-FIX.md (not in the current review) |

Dispositions: `open` (recorded, not yet triaged), `fixed`, `skipped`, `deferred`.
Set `deferred` by hand and put the reason in the Source cell; both are preserved. A `|` in the reason is kept as prose and escaped on the next run.
Re-running the gate keeps every row it can. A row the current review no longer reports is kept and its Source cell flagged, so a finding does not leave this record silently. ONE exception: when a finding id is REUSED by a different finding, the earlier decision cannot keep a row — the id is taken — and it is dropped. A RECORDED decision (anything but `open`) is named on the console when that happens; a row still at `open` is replaced silently, because `open` records no decision to lose.
