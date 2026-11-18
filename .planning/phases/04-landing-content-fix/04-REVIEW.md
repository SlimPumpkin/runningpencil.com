---
phase: 04-landing-content-fix
reviewed: 2026-11-18T09:17:09Z
depth: standard
files_reviewed: 4
files_reviewed_list:
  - .claude/CLAUDE.md
  - CLAUDE.md
  - index.html
  - scripts/check-site.sh
findings:
  critical: 0
  warning: 0
  info: 3
  total: 3
  necessity: 1
status: issues_found
---

# Phase 4: Code Review Report (재검토, re-review)

**Reviewed:** 2026-11-18T09:17:09Z
**Depth:** standard
**Files Reviewed:** 4
**Status:** issues_found

## Summary

이번 검토는 첫 리뷰(`f371d82`) 뒤에 들어간 수정 커밋 6개(`f371d82..HEAD`: `f46c3ca`, `86a5704`, `7527e78`, `270b880`, `b3eb0db`, `8d3d2d9`)를 standard 깊이로 다시 본 것입니다. 대상 파일 4개는 전체를 읽었습니다.

finding ID는 첫 리뷰의 WR-01, IN-01~IN-05 뒤를 이어 IN-06부터 매깁니다. `04-REVIEW-DISPOSITION.md`는 같은 ID를 다른 finding에 다시 쓰면 앞서 기록한 처리 결정을 지웁니다. 그래서 번호를 1부터 다시 시작하지 않았습니다.

확인한 것:

- 작업 트리에서 `scripts/check-site.sh`를 돌렸고 통과했습니다 (`check-site: 통과 (작업 트리, jekyll 3.10.0)`).
- **WR-01 (줄 번호):** `.claude/CLAUDE.md`가 적은 `index.html` 줄 번호를 HEAD에서 하나씩 열어 보았습니다. 22-25, 21, 27, 29-126, 31, 65-83, 109, 130-463, 132-162, 134, 164, 216, 292/293/307/323/358, 462, 464-619, 466-467, 482, 495-500, 503-512, 515-518, 521-541, 532-534, 543-551, 562-567, 569-580, 587-590, 594-596, 597-606, 605, 612-617입니다. 모두 맞습니다. 원본 `.planning/codebase/ARCHITECTURE.md`와 `CONVENTIONS.md:30`에도 같은 번호가 있으므로, 생성 구간을 손으로 고친 것이 아니라 원본에서 다시 만든 것과 맞습니다. 다른 파일을 가리키는 번호(`_layouts/legal.html:14/16/18/23/40`, `_includes/css/legal.css:5/9`, `_includes/header.html:5`, `_includes/footer.html:7`)도 맞습니다.
- **IN-01 (점검 6번):** macOS `/usr/bin/grep`(BSD grep 2.6.0)으로 새 파이프라인을 시험했습니다. 시험 줄은 `체크포인트 와 포인트`, `엔드포인트`, `굿즈 코스북`, `포인트포인트`, `체크포인트체크포인트`, `API 엔드 포인트`, `체크포인트`입니다. `LC_ALL=C`, `en_US.UTF-8`, `ko_KR.UTF-8`에서 모두 6곳을 셌고, 이것이 기대값입니다. 허용 낱말은 빠지고, 같은 줄에 있는 맨 「포인트」와 띄어 쓴 「엔드 포인트」는 잡힙니다. `index.html`이 없으면 이 항목은 0으로 통과하지만, 3번 항목이 「문서가 없습니다」로 막으므로 빈틈은 아닙니다.
- **IN-02:** `scripts/check-site.sh:16`의 주석에서 단계 번호가 빠졌습니다.
- **IN-03:** 동작은 바뀌지 않았고, `.claude/CLAUDE.md:161`과 원본 `CONVENTIONS.md`에 문서로만 남겼습니다. 첫 리뷰가 고치는 방법으로 이 길도 제시했으므로 결함으로 다시 올리지 않습니다.
- **IN-04 (코스 이름):** 출력 원본(`.planning`, `vendor`, `_site`, `prepare` 제외)에 「댕댕런」이 남아 있지 않습니다. `index.html`의 9곳(마크업 7곳과 스크립트 주석 2곳)과 루트 `CLAUDE.md`의 2곳이 「강아지런」으로 바뀌었습니다. 줄 수는 그대로라 WR-01에서 고친 번호가 다시 밀리지 않았습니다. 커밋은 내용 변경(`270b880`, `index.html`만)과 문서 변경(`b3eb0db`)으로 나뉘어 있어 「섞지 않는다」 규칙을 지킵니다.
- 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`의 「이번 마일스톤 방침」 구간은 지금도 같습니다.
- 랜딩 인라인 스크립트(`index.html:464-619`)는 이번 수정에서 주석 두 줄만 바뀌었습니다. id·속성 계약은 그대로입니다.

Critical과 Warning은 없습니다. 남은 것은 Info 3건입니다. IN-06은 코스 이름을 앱과 맞추면서 목업의 거리(8.3 km)가 실제 앱 화면이라고 소개한 캡처의 숫자와 같은 페이지에서 나란히 보이게 된 점입니다. IN-07은 점검 6번 항목의 허용 목록이 지금 아무것도 걸러 내지 않는다는 점이고, IN-08은 줄 번호를 절대값으로 적는 방식이 다시 어긋날 것이라는 점입니다.

## Narrative Findings (AI reviewer)

## Info

### IN-06: 코스 이름을 「강아지런」으로 맞춘 뒤, 목업의 8.3 km가 같은 페이지 캡처의 숫자와 다름 (확인되지 않음)

**File:** `index.html:286` (목업 「코스 그리기」 `8.3 km`), `index.html:353` (목업 결과 `8.30 km`), `index.html:379` (「달려 보기」 알약 `강아지런 8.3 km`), `index.html:479` (`var KM = 8.3`), 캡처 `index.html:419`·`:427`
**Issue:** IN-04를 고치기 전에는 「댕댕런 8.3 km」가 지어낸 예시 코스여서 숫자가 앱과 맞을 필요가 없었습니다. 이제 이름이 앱의 실제 코스 이름 「강아지런」과 같아졌으므로, 8.3 km는 실제 코스에 대한 주장으로 읽힙니다. 같은 페이지의 「실제 앱 화면」 캡처 세 장은 같은 강아지 모양 코스(경복궁 서쪽 출발)를 보여 주는데, 숫자가 서로 다릅니다.

| 위치 | 화면 | 거리 |
|---|---|---|
| 목업 1단계 (`index.html:286`) | 코스 그리기 | 8.3 km |
| 캡처 `screen-draw-*.webp` | 코스 그리기 (화면에 코스 이름 없음, 오른쪽 위 썸네일이 강아지 모양) | 6.5 km |
| 캡처 `screen-run-*.webp` | 따라 달리기 | 16%에서 1.34 km, 역산하면 약 8.4 km |
| 목업 3단계 (`index.html:353`) | 강아지런 결과 | 8.30 km |
| 캡처 `screen-badge-*.webp` | 강아지런 결과 | 7.84 km |

달리기 캡처를 역산한 값(약 8.4 km)은 8.3 km와 맞습니다. 결과 화면의 거리는 실제로 걸은 GPS 거리라서 코스 길이와 다를 수 있습니다. 그래서 목업이 틀렸다고 증명되지는 않습니다. 다만 같은 「코스 그리기」 화면이 목업에서는 8.3 km, 바로 아래 실제 캡처에서는 6.5 km로 보입니다. 이 사이트의 목표는 심사자가 사이트와 앱이 같다고 확인하는 것이고, IN-04도 그 이유로 고쳤습니다. 그런데 이 수정으로 숫자 비교가 더 쉬워졌습니다. 앱 편집기의 6.5 km가 다른 방식(예: 경로 탐색 전 직선 거리)으로 잰 값인지는 저장소에서 확인할 수 없습니다.
**Fix:** 앱에서 강아지런 코스의 길이를 확인합니다. 8.3 km가 맞으면 그대로 둡니다. 다르면 다음 내용 변경 단계에서 `index.html:286`, `:353`, `:379`의 표시값과 `KM` 상수(`:479`)를 함께 고칩니다. 목업의 시간·페이스 값(`:351`의 `1:06:12`, `1:03:38`, `7'40"/km`, 스크립트의 `460`·`390` 초/km)도 거리에서 나온 값이니 같이 다시 계산합니다. 내용 변경이므로 시각 변경·리팩터 커밋과 섞지 않습니다.

### IN-07: Generality without instantiation — 점검 6번 항목의 허용 목록 `체크포인트|엔드포인트`가 지금 랜딩에 없는 낱말만 거름

**File:** `scripts/check-site.sh:95-97`
**Category:** necessity
**Issue:** 이 허용 목록은 첫 리뷰 IN-01의 제안대로 넣은 것이고, 처리 기록(`fixed`)을 뒤집으려는 지적이 아닙니다. 다만 지금 걸러 내는 대상이 없습니다. `/usr/bin/grep -c -E '체크포인트|엔드포인트' index.html`은 0이고, 랜딩 출력에도 두 낱말이 없습니다. 「엔드포인트」는 개발 용어라 티저 랜딩 문구에 나올 가능성도 낮습니다. 게다가 허용 낱말이 두 곳에 나뉘어 있습니다. 앞쪽 접두어 묶음 `(체크|엔드)`와 뒤쪽 `grep -v -x` 목록을 함께 고쳐야 하고, 주석(`:96`)이 그것을 사람에게 맡깁니다. 한쪽만 고치면 그 낱말은 계속 잡히거나 예외가 효과를 내지 못합니다. 두 경우 모두 막는 쪽(fail-closed)이라 라이브 사고로 이어지지는 않습니다. 하지만 원인을 찾기 어려운 오탐이 됩니다. 판단에 기댄 지적이므로 Info입니다.
**Fix:** 둘 중 하나를 고릅니다.
```bash
# (가) 실제로 허용할 낱말이 생길 때까지 단순한 형태로 되돌리고, 그때 예외를 더한다고 주석에 적는다
u10=$(grep -o -E '포인트|굿즈|코스북' "$DEST/index.html" 2>/dev/null | wc -l | tr -d ' ')

# (나) 허용 접두어를 변수 하나에 두어 두 목록이 어긋나지 않게 한다
U10_ALLOW_PREFIX='체크|엔드'
u10=$(grep -o -E "(${U10_ALLOW_PREFIX})?포인트|굿즈|코스북" "$DEST/index.html" 2>/dev/null \
    | grep -v -x -E "(${U10_ALLOW_PREFIX})포인트" | wc -l | tr -d ' ')
```

### IN-08: 줄 번호를 절대값으로 적는 방식이 남아 있어 다음 `index.html` 수정 때 다시 어긋남

**File:** `.claude/CLAUDE.md:132, 294-303, 322, 335, 341-359, 365, 371, 382, 405, 415-416` (원본 `.planning/codebase/ARCHITECTURE.md:24-33, 56, 69, 76-100, 107, 113, 129, 154, 168-169`, `CONVENTIONS.md:30`)
**Issue:** WR-01 수정으로 지금은 모든 번호가 HEAD와 맞습니다. 하지만 같은 구조가 그대로라서, 「랜딩 전용」 CSS나 `#screens` 앞쪽에 한 줄만 더해도 번호 약 40개가 서로 다른 폭으로 밀립니다. WR-01이 그렇게 생겼습니다. `scripts/check-site.sh`나 다른 장치가 이 번호를 검사하지 않으므로 다음 어긋남도 리뷰에서야 드러납니다. 첫 리뷰는 고정점으로 바꾸는 방법도 제시했지만, 이번 수정은 번호만 고쳤습니다.
**Fix:** `index.html`을 고치는 다음 단계에서 원본(`.planning/codebase/ARCHITECTURE.md`, `CONVENTIONS.md`)의 줄 번호를 고정점으로 바꿉니다. 고정점의 예는 `/* ── 랜딩 전용 ── */` 머리 주석, `<script>` 블록의 `// ── 연결 ──`, `{% include footer.html %}`, 함수 이름(`paintStory()`, `startRun()`)입니다. 그 뒤 `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md`로 다시 만듭니다. 번호를 남기려면 그 단계의 검증에 다음 확인을 더합니다: `grep -n -E '^    <script>|</style>|include (header|footer)|var state' index.html`의 결과가 문서의 번호와 같은지 봅니다.

---

_Reviewed: 2026-11-18T09:17:09Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
