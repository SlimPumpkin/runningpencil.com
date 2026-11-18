---
phase: 04-landing-content-fix
reviewed: 2026-11-18T14:16:11Z
depth: standard
files_reviewed: 3
files_reviewed_list:
  - .claude/CLAUDE.md
  - index.html
  - scripts/check-site.sh
findings:
  critical: 0
  warning: 1
  info: 2
  total: 3
  necessity: 0
status: issues_found
---

# Phase 4: Code Review Report (세 번째 검토 수정 뒤 네 번째 검토)

**Reviewed:** 2026-11-18T14:16:11Z
**Depth:** standard
**Files Reviewed:** 3
**Status:** issues_found

## Summary

이번 검토는 세 번째 검토 보고서 커밋 `721b735` 뒤의 변경(`721b735..HEAD`)을 봅니다. 대상 파일에 닿는 커밋은 `215fa7e`(WR-02, `index.html:287`), `3289fc3`(IN-10, `index.html:286`), `8cc86fd`(WR-03, `scripts/check-site.sh:97-107`), `a6a8aa5`(IN-09, `.claude/CLAUDE.md:216-217` 재생성)입니다. 이 파일은 `721b735`에 커밋된 세 번째 검토 보고서를 덮어씁니다. 그 보고서의 처리 결정은 `04-REVIEW-DISPOSITION.md`에 남아 있습니다. finding ID는 그 기록(WR-01~WR-03, IN-01~IN-10)과 겹치지 않게 WR-04, IN-11부터 매깁니다.

**읽은 범위:** `scripts/check-site.sh`(110줄)는 전체를 읽었습니다. `.claude/CLAUDE.md`는 변경 구간(`:213-218`)과 「이번 마일스톤 방침」 구간을 봤습니다. `index.html`(622줄)은 전체를 읽지 않았습니다. `721b735..HEAD` diff, `<head>`(`:1-28`), 「세 가지 이유」 「코스 그리기」 목업(`:270-300`), 「달려 보기」 머리(`:375-382`), 스크립트 상수(`:470-482`), 그리고 거리·시간 값 grep(`7\.8|km|분 ·|KM`)만 봤습니다. 이번 변경이 숫자 두 줄뿐이라 범위를 그렇게 잡았습니다.

확인한 것은 아래와 같습니다.

- 작업 트리에서 `scripts/check-site.sh`를 돌렸고 통과했습니다 (`check-site: 통과 (작업 트리, jekyll 3.10.0)`).
- **WR-02 수정 (`104분 · 67분 · 31분`):** 앱 저장소(`~/dv/woody/running_pencil`, HEAD `3afb2085`, 읽기만 함)의 `packages/geo/lib/course_pace.dart:36-46` `estimateMinutes`(`(m * 60 / (속도 * 1000)).round()`, half-up, 최소 1분)와 속도 상수(`:13` 4.5, `:18` 7.0, `:29` 15.0)를 직접 읽었습니다. 같은 식으로 7,700~7,900 m를 1 m씩 계산하면 `7.8 km`·104·67·31분이 함께 나오는 범위는 7,763~7,837 m(75개)입니다. 수정 보고서와 같습니다.
- **IN-10 수정 (`7.8 km`):** `lib/shared/format/course_display_format.dart`의 `formatCourseDistance`가 코스 거리를 10 m 단위로 반올림한 뒤 km 소수 한 자리로 표기하는 것을 직접 확인했습니다. `:286`은 맞게 고쳐졌습니다. 다만 같은 근거로 보면 「달려 보기」의 코스 딱지 `:379`도 코스 거리 표기입니다 (WR-04).
- **WR-03 수정:** 지금 값 `체크|엔드`, 그리고 수정 보고서가 시험한 `''`·`'체크|'`·`'체크('`·`'체크['`는 모두 맞게 처리됩니다. macOS `/usr/bin/grep`(BSD grep 2.6.0-FreeBSD)으로 정규식 메타문자 몇 가지를 더 넣어 보았고, 일부는 오류 없이 점검을 무력화합니다 (IN-11). pre-push 훅의 PATH(`/opt/homebrew/bin:/usr/local/bin:…`)에서도 grep은 `/usr/bin/grep`입니다.
- **IN-09 수정:** `.claude/CLAUDE.md:215-218`의 순서(meta → `{% include head-links.html %}` → `rp-pin` 스크립트 → `<style>`)가 `index.html:9-27`, 원본 `.planning/codebase/CONVENTIONS.md:118-123`과 같습니다. 재생성 diff는 두 줄의 자리 바꿈뿐입니다.
- 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`의 「이번 마일스톤 방침」 구간을 `diff`로 비교했고 같습니다.
- 커밋 구분: 네 커밋이 finding 하나씩만 담고, `index.html` 두 커밋은 내용 변경만 담습니다. 「리팩터·시각·내용 변경을 섞지 않는다」 규칙을 지킵니다.

Critical은 없습니다. Warning 1건과 Info 2건이 있습니다. necessity finding은 없습니다. 점검 6번의 형식 확인은 사람이 값을 고칠 때 생기는 실제 위험을 막으므로 necessity 대상이 아닙니다.

## Narrative Findings (AI reviewer)

## Warnings

### WR-04: 「달려 보기」 코스 딱지가 같은 강아지런 코스를 `7.84 km`로 표기해, `7.8 km`로 고친 「코스 그리기」 목업과 같은 페이지 안에서 다름

**File:** `index.html:379` (관련 `index.html:286`, `index.html:479`)
**Issue:** IN-10 수정(`3289fc3`)과 수정 보고서는 `7.84 km`가 **달리기 결과 화면의 측정 거리**(앱 `formatRunDistance`, 소수 두 자리)라고 정했습니다. 코스 자체는 앱이 `formatCourseDistance`(소수 한 자리)로 `7.8 km`라고 표기한다고도 정했습니다.

`:379`의 「달려 보기」 딱지는 달리기 결과가 아니라 **코스를 가리키는 칩**입니다. 강아지 코스 아이콘, 코스 이름 「강아지런」, 거리로 되어 있고, 「달리기 시작」을 누르기 전에 보입니다. 앱에서 코스 이름과 코스 거리를 함께 보여 주는 곳은 모두 소수 한 자리 `formatCourseDistance`를 씁니다. 앱 저장소 `3afb2085`에서 직접 확인한 곳은 세 군데입니다.
- 코스 목록 카드: `lib/features/courses/presentation/_widgets/course_list_card.dart:122-136`. `course.title` 아래에 `formatCourseDistance(l10n, distance)`를 둡니다.
- 대표 코스 카드: `lib/features/profile/presentation/_widgets/featured_course_card.dart:67-70`. `course.title`과 `formatCourseDistance(l10n, course.distanceMeters)`를 함께 씁니다.
- 코스 상세: `lib/features/courses/presentation/_widgets/course_detail_panel.dart:178`.

그래서 지금 랜딩은 같은 코스를 `:286`에서는 `7.8 km`로, `:379`에서는 `7.84 km`로 보여 줍니다. IN-04·IN-06·WR-02·IN-10을 고친 이유는 심사자가 사이트와 앱이 같은지 본다는 것이었고, 이 줄에도 그대로 해당합니다.

세 번째 검토의 IN-10 Fix는 「`:379`는 그대로 둔다」고 적었고, 수정은 그 안내를 따랐습니다. 하지만 그 안내는 `7.84 km`가 달리기 거리라는 사실을 확인하기 전에 쓴 것입니다. 수정 보고서가 그 사실을 확인했으니, 이 줄도 코스 거리 표기로 다시 봐야 했습니다.

같은 이유로 `:479`의 주석 `var KM = 7.84;   // 강아지런 거리`도 지금은 뜻이 모호합니다. 이 값은 결과 화면 목업(`:353`)과 「달려 보기」 애니메이션 최종값(`#rp-demo-dist`, `:558`)에 쓰는 **달리기 측정 거리**입니다. 앱이 보여 주는 코스 거리는 `7.8 km`입니다.
**Fix:** `:379`의 딱지 거리만 내용 변경 커밋으로 앱 코스 표기에 맞춥니다. 이 줄의 예전 값 `8.3 km`도 원래 소수 한 자리 코스 표기였습니다. `KM` 값, `:353` 결과 화면, `#rp-demo-dist` 애니메이션은 달리기 거리이므로 그대로 둡니다.
```html
<!-- index.html:379 — 코스 칩은 앱 formatCourseDistance(소수 한 자리) 표기 -->
...</svg>강아지런<span style="font-weight: 500">7.8 km</span></p>
```
주석은 코드 정리이므로 별도 커밋으로 고칩니다.
```js
var KM = 7.84;                   // 강아지런을 한 번 달린 측정 거리 (앱의 코스 표기는 7.8 km)
```
`:379` 딱지를 일부러 달리기 거리로 두기로 한 것이라면, 그 결정을 `04-REVIEW-DISPOSITION.md`에 `skipped`로 남깁니다.

## Info

### IN-11: `U10_ALLOW_PREFIX` 형식 확인이 막을 값을 나열하는 방식이라, `.`·`.*`·`^`·`$` 같은 메타문자는 오류 없이 점검 6번을 무력화함

**File:** `scripts/check-site.sh:97-99`
**Issue:** WR-03 수정은 `case "|${U10_ALLOW_PREFIX}|" in *'||'*|*'('*|*')'*)`로 빈 값·빈 항목·괄호만 막습니다. 나머지 정규식 오류는 grep 종료 코드 2로 잡습니다. 하지만 정규식 문법으로는 맞고 뜻만 바뀌는 메타문자는 종료 코드 0으로 지나갑니다. 시험 줄은 `<p>포인트 굿즈 코스북 체크포인트</p>`(기대값 3곳)이고, `/usr/bin/grep`(BSD grep 2.6.0)으로 돌렸습니다. `.`는 `LC_ALL=C`와 `ko_KR.UTF-8`에서 결과가 같았습니다.

| `U10_ALLOW_PREFIX` | 첫 grep 종료 코드 | 센 수 | 왜 |
|---|---|---|---|
| `체크\|엔드` (지금 값) | 0 | 3 | 정상 |
| `.` 또는 `체크\|.` | 0 | 2 | 맨 「포인트」 앞 한 글자(공백 등)가 `(.)?`에 붙어 잡히고, 빼는 쪽 `(.)포인트`가 그것을 허용 낱말로 뺌 |
| `^` 또는 `$` | 0 | 2 | 맨 「포인트」를 빼 버림 |
| `.*` | 0 | **0, 통과** | 줄 앞부분 전체가 붙어 잡히고 모두 빠짐 |
| `체크\|[^가]` | 0 | 2 | `.`와 같음 |

`:97` 주석은 「비우거나 빈 항목·괄호를 넣으면 점검이 무력해지므로 막는다」고만 적어서 틀린 말은 아닙니다. 하지만 수정 보고서의 「어느 경우도 조용히 통과하지 않습니다」는 시험한 값에만 맞습니다. 이 값을 이렇게 고칠 사람은 드물어서 Info로 둡니다.
**Fix:** 막을 값을 나열하지 않고, 허용할 모양만 받습니다. 구두점과 공백이 없는 낱말을 `|`로 이은 값입니다. 아래 두 줄은 `/bin/bash` 3.2에서 `LC_ALL=C`와 `ko_KR.UTF-8` 모두로 시험했습니다. 지금 값만 통과하고, 아래 값은 모두 막힙니다: `''`·`'체크|'`·`'|체크'`·`'체크('`·`.`·`.*`·`^`·`$`·`'체크|[^가]'`·`'체크\'`·`'체크{'`·`?`·`'체크 '`·`'체크-'`.
```bash
# 허용 낱말 앞부분은 구두점·공백 없는 낱말을 |로 이은 것만 받는다. 그 밖의 값은 정규식 뜻이 바뀌어 점검이 무력해진다.
case "|${U10_ALLOW_PREFIX}|" in *'||'*) fail "U10_ALLOW_PREFIX 형식이 잘못되었습니다: '${U10_ALLOW_PREFIX}'" ;; esac
case "${U10_ALLOW_PREFIX//|/}" in *[[:punct:][:space:]]*) fail "U10_ALLOW_PREFIX 형식이 잘못되었습니다: '${U10_ALLOW_PREFIX}'" ;; esac
```
`:97` 주석도 이 규칙에 맞게 고칩니다. 종료 코드 2 처리(`:101-103`)는 그대로 둡니다.

### IN-12: 랜딩 출력이 없을 때 점검 6번이 `U10_ALLOW_PREFIX`를 원인처럼 보이는 메시지로 실패를 한 번 더 셈

**File:** `scripts/check-site.sh:101-103`
**Issue:** WR-03 수정 전에는 `2>/dev/null`이 있어서, `$DEST/index.html`이 없으면 점검 6번이 조용히 0을 냈습니다. 그래서 3번 항목의 「문서가 없습니다: /index.html」 하나만 남았습니다. 수정 뒤에는 같은 상황에서 grep이 종료 코드 2를 냅니다. `/usr/bin/grep -o -E 'x' /nonexistent/index.html`로 확인했고, 결과는 `grep: /nonexistent/index.html: No such file or directory`와 종료 코드 2입니다. 그러면 6번 항목이 `점검 6번 grep이 실패했습니다 (종료 코드 2, U10_ALLOW_PREFIX='체크|엔드')`를 더 냅니다. 실패하는 것 자체는 맞습니다. 하지만 원인 하나가 두 건으로 세어지고, 메시지는 허용 접두어 값이 문제인 것처럼 읽힙니다. 세 번째 검토가 「`index.html`이 없는 경우는 3번 항목이 막는다」고 적은 뜻과도 달라졌습니다. 실패는 그대로 나므로 Info로 둡니다.
**Fix:** 파일이 없으면 6번을 건너뛰고 3번의 메시지에 맡깁니다.
```bash
# 랜딩 출력이 없으면 3번 항목이 「문서가 없습니다」로 이미 셌다
if [ -f "$DEST/index.html" ]; then
    u10_hits=$(grep -o -E "(${U10_ALLOW_PREFIX})?포인트|굿즈|코스북" "$DEST/index.html"); u10_rc=$?
    # … 지금의 if/else 그대로
fi
```

---

_Reviewed: 2026-11-18T14:16:11Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
