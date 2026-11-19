---
phase: 05-business-info-support-contact
reviewed: 2026-11-19T19:29:22Z
depth: standard
files_reviewed: 9
files_reviewed_list:
  - _data/company.yml
  - _includes/css/common.css
  - _includes/footer.html
  - _includes/header.html
  - .claude/CLAUDE.md
  - CLAUDE.md
  - README.md
  - scripts/check-site.sh
  - support/index.html
findings:
  critical: 0
  warning: 3
  info: 4
  total: 7
  necessity: 1
status: issues_found
---

# Phase 5: Code Review Report

**Reviewed:** 2026-11-19T19:29:22Z
**Depth:** standard
**Files Reviewed:** 9
**Status:** issues_found

## Summary

`7876c5b..HEAD`(HEAD `e70517d`)에서 대상 9개 파일에 닿은 커밋 13개를 봤습니다. 아홉 파일을 모두 처음부터 끝까지 읽었고, 기준 커밋 대비 diff도 아홉 파일 모두 따로 읽었습니다 (`.claude/CLAUDE.md`는 루트 `CLAUDE.md`와 겹치지 않는 추가 줄을 따로 읽음). 참고로 `_layouts/legal.html`, `_config.yml`, `.githooks/pre-push`, `.planning/baseline/DATA-INVENTORY.md`, `05-CONTEXT.md`, `05-RESEARCH.md`, `05-UI-REVIEW.md`를 함께 읽었습니다. necessity 기준은 GSD 참조 문서 `necessity-review.md`를 읽고 적용했습니다.

### 확인한 것

1. **점검 실행.** 작업 트리에서 `scripts/check-site.sh`를 돌렸고 통과했습니다.
2. **변형 빌드 두 가지.** 두 경우 모두 `HEAD`를 임시 폴더로 내보내 운영과 같은 `--safe` production 빌드를 돌렸습니다.
   - **(가) `support_email`을 `""`로 비움.** 게이트가 원래 노린 상황입니다. 지원 페이지 출력에 `mailto:`가 0개였고 앵커는 `#faq` 하나만 남았습니다. 따라서 7번 점검은 이 경우 정상적으로 실패합니다.
   - **(나) `support/index.html`에서 `<section id="contact">`만 지움.** 빌드는 성공했고 지원 페이지 출력에 `mailto:`가 1개 남았습니다. 그 1개는 푸터의 것이고, 7번 점검은 이 경우를 통과시킵니다 (WR-01).
3. **Liquid 판정과 공백.** 출력의 푸터 사업자 줄은 `<p><span>…</span>&nbsp;· <span>…</span>&nbsp;· <span>…</span></p>` 모양입니다. 앞뒤 공백이나 남는 구분 기호가 없습니다.
   - 빈 문자열이 행째 숨는 것은 변형 빌드 (가)로 직접 확인했습니다. null, 키 없음, 파일 없음에서도 `.size > 0`이 거짓이라는 것은 이번에 따로 돌려 보지 않았고, `05-CONTEXT.md:90`(정정 항목, `05-RESEARCH.md` Pattern 1·Pitfall 1의 시험 결과)을 근거로 둡니다.
   - `_data` 출력은 모두 `| escape`를 거칩니다.
4. **문서 대조.** `CLAUDE.md`와 `.claude/CLAUDE.md`의 「이번 마일스톤 방침」 구간을 diff로 비교했습니다. 차이는 `.claude/CLAUDE.md`에만 있는 GSD 생성 구간 시작 표시 한 줄뿐이고, 방침 본문은 같습니다.
   - `.claude/CLAUDE.md`가 인용한 줄 번호는 실제와 맞습니다 (`_layouts/legal.html:14·16·18·23·40`, `_includes/header.html:5`, `_includes/footer.html:7`).
   - 세 문서(`CLAUDE.md`, `.claude/CLAUDE.md`, `README.md`)에 `support_email`·`representative`·`biz_reg_no`·`address` 값은 글자로 들어 있지 않습니다.
   - `trade_name` 값은 `CLAUDE.md`(1곳)와 `.claude/CLAUDE.md`(2곳)에 글자로 있습니다. 둘 다 기준 커밋 `7876c5b`에 이미 같은 수로 있던 것(운영 회사 이름 설명)이라 Phase 5가 새로 넣은 것이 아니고, 이 보고서는 다루지 않습니다.
5. **FAQ 사실 근거.** 근거가 확인된 문장은 세 가지입니다.
   - 위치: 기록 중에만 저장, 화면이 꺼져도 수신, Android 알림, 그리기·시작 전 화면은 읽기만 함, 권한은 「앱 사용 중」만. 근거는 `DATA-INVENTORY.md` 「위치를 읽는 세 시점」 표와 그 아래 항목입니다.
   - 삭제 경로 「설정 → 내 계정 → 회원탈퇴」와 「맨 아래」. 근거는 `05-RESEARCH.md:370-372`와 `DATA-INVENTORY.md:258`입니다.
   - 응답 약속 「영업일 기준 3일」. 근거는 `05-CONTEXT.md:111`입니다.
6. **이미 다룬 항목.** `05-UI-REVIEW.md`가 이미 다룬 세 항목은 여기서 다시 올리지 않았습니다.
   - 푸터 이메일 링크의 44px 미만 터치 대상
   - 헤더·푸터 「고객 지원」의 `aria-current` 없음
   - `#report`의 「위 지원 이메일」 모호함

### 핵심 우려

- 이메일 게이트를 지키는 7번 점검이 지원 페이지 본문과 공유 푸터를 구분하지 못합니다 (WR-01). 그래서 「지원 페이지에 연락처가 있다」는 확인이 본문에 대해서는 실제로 이뤄지지 않습니다.
- 앱·콘솔이 쓰는 앵커 `#contact`·`#report`·`#faq`는 이름을 고정한다는 계약입니다. 하지만 이 계약을 기계로 지키는 장치가 없습니다.

## Narrative Findings (AI reviewer)

## Warnings

### WR-01: 7번 점검의 `mailto:` 확인이 공유 푸터에 걸려, 지원 페이지 본문의 연락처·앵커가 빠져도 통과한다

**File:** `scripts/check-site.sh:119-122` (관련: `_includes/footer.html:30-34`, `support/index.html:9-29`)
**Issue:** 7번 점검은 `$DEST/support/index.html` 파일 전체에서 `href="mailto:`를 찾습니다. 그런데 Phase 5에서 공유 푸터(`_includes/footer.html:32`)가 모든 페이지에 같은 `mailto:` 링크를 넣습니다. 그래서 지원 페이지 본문에 연락처가 있는지는 이 점검으로 알 수 없습니다.
- **실증:** 변형 빌드 (나)는 `<section id="contact">`를 지운 빌드입니다. 출력의 `mailto:`는 푸터에 1개 남았고, 7번 점검은 이 빌드를 통과시킵니다.
- **게이트 시나리오는 지켜짐:** (가)처럼 `support_email`을 비우면 푸터의 `mailto:`도 함께 사라집니다. 그래서 게이트가 노린 「이메일 없는 `/support/` 배포」는 이 점검이 막습니다.
- **막지 못하는 것:** 본문 구간을 잘못 지우거나, 조건을 다른 키로 바꾸거나, 앵커 이름을 바꾸는 회귀는 점검을 통과합니다.
- **앵커 계약:** `CLAUDE.md` Pages 표는 `#contact`·`#report`·`#faq`를 「앱·콘솔이 씀, 이름 고정」으로 둡니다. 이 계약을 확인하는 점검은 없습니다.

출력은 문서 제목만 맞으면 정상처럼 보입니다. 그래서 심사자가 보는 Support URL에서 문의 수단이 사라져도 푸시가 막히지 않습니다.

**Fix:** 확인 범위를 카드 본문(`<div class="rp-doc">`부터 `</article>`까지)으로 좁히고, 같은 범위에서 앵커 세 개도 함께 확인합니다.
```bash
if [ -f "$DEST/support/index.html" ]; then
    # 공유 푸터에도 mailto가 있으므로 카드 본문만 본다
    sup_body=$(sed -n '/<div class="rp-doc">/,/<\/article>/p' "$DEST/support/index.html")
    printf '%s\n' "$sup_body" | grep -qF 'href="mailto:' \
        || problem '지원 페이지 본문에 연락처(mailto)가 없습니다 (D-04)'
    for a in contact report faq; do
        printf '%s\n' "$sup_body" | grep -qF "id=\"$a\"" \
            || problem "지원 페이지에 앵커 #$a가 없습니다 (앱·콘솔이 쓰는 이름, D-13)"
    done
fi
```
이 조각은 세 빌드 출력에서 시험했습니다. 실제 빌드는 통과하고, 변형 (나)는 「mailto 없음·#contact 없음」으로, 변형 (가)는 「mailto 없음·#contact·#report 없음」으로 실패합니다.

`CLAUDE.md`와 `.claude/CLAUDE.md`의 점검 설명(「지원 페이지가 있으면 연락처(mailto)가 있고」)도 「본문에 연락처와 앵커 세 개가 있고」로 맞춥니다. `.claude/CLAUDE.md`는 원본 `.planning/codebase/*.md`를 고친 뒤 다시 생성합니다.

### WR-02: 어두운 푸터에서 포커스 테두리 대비가 약 2.1:1로, 새 이메일 링크와 「고객 지원」 링크에도 그대로 적용된다

**File:** `_includes/css/common.css:6` (관련: `_includes/css/common.css:16`, `:29`, `_includes/footer.html:16`, `:32`)
**Issue:** 「공통」은 모든 요소의 포커스를 `:focus-visible { outline: 3px solid #1E5AA8; }` 하나로 그립니다.
- **대비 계산:** 푸터 바탕은 `#2B2B2B`입니다. `#1E5AA8`의 상대 휘도는 약 0.104, `#2B2B2B`는 약 0.024이므로 대비는 약 2.08:1입니다. WCAG 1.4.11(비텍스트 대비, AA)이 포커스 표시에 요구하는 3:1에 못 미칩니다.
- **물려받은 부분:** 이 규칙은 Phase 2부터 있던 것이라 기존 푸터 약관 링크 3개도 같은 문제를 갖고 있었습니다.
- **Phase 5가 넓힌 부분:** Phase 5는 어두운 바탕 위에 키보드 포커스 대상을 두 개 더했습니다. 하나는 푸터 nav의 「고객 지원」(`footer.html:16`)이고, 다른 하나는 사업자 줄 아래의 이메일 링크(`footer.html:32`, `.rp-foot-legal a`)입니다. 이메일 링크는 hover·focus 때 따로 바뀌는 모양도 없어서, 테두리 말고는 포커스가 어디 있는지 알 단서가 없습니다.
- **UI 감사와의 관계:** `05-UI-REVIEW.md`는 이 링크의 터치 대상 크기만 다뤘고 포커스 대비는 다루지 않았습니다.

**Fix:** 어두운 푸터 안에서만 테두리 색을 이미 쓰는 연필 노랑으로 바꿉니다. `#F2B134`와 `#2B2B2B`의 대비는 약 7.5:1이고, 새 hex가 늘지 않습니다.
```css
        .rp-foot :focus-visible { outline-color: #F2B134; }
```
시각 변경이므로 다른 변경과 섞지 않고 커밋 하나로 둡니다.

### WR-03: Already-defended-elsewhere — 7번 점검의 「링크는 있는데 페이지가 없음」 분기는 3번 점검이 이미 잡는다

**File:** `scripts/check-site.sh:117`, `:124-129`
**Category:** necessity
**Issue:** 지원 페이지가 없는 상태는 3번 점검이 이미 잡습니다. `EXPECTED_TITLES`에 `support/index.html`이 들어 있고(`:22`), 3번 점검은 그 파일이 없으면 「문서가 없습니다」로 셉니다(`:77`). 그래서 7번 점검의 일부가 정상 경로에서 하는 일이 없습니다.
- **`:127` 분기:** 「`/support/` 링크가 있는데 페이지가 없음」은 3번 점검이 이미 실패시킨 상태에서만 참이 됩니다. 결과는 같은 원인으로 오류 수만 하나 더 늘어나는 것입니다. 헤더(`header.html:12`)와 푸터(`footer.html:16`)의 링크는 조건 없이 늘 나가므로, 「링크만 있고 페이지 없음」을 3번과 따로 잡을 경우가 없습니다.
- **`:119` 조건은 필요합니다 (이 finding에서 뺌):** `problem()`은 수만 세고 멈추지 않으므로, 지원 페이지가 없을 때도 7번까지 내려옵니다. 그때 `:119`의 `-f`가 거짓이 되어 없는 파일에 grep을 돌리는 것을 막습니다. WR-01의 수정 조각도 이 조건을 그대로 씁니다.
- **`:117` 주석:** 「게이트 전에는 /support/ 문서도 그리로 가는 링크도 없으므로 이 항목은 그냥 지나간다」는 게이트 통과 뒤의 현재 상태와 맞지 않습니다.

이 판정은 저장소만 보고 증명할 수 있습니다. `:22`, `:77`과 헤더·푸터의 조건 없는 링크가 근거입니다. 지원 페이지가 없으면 3번이 이미 한 건을 세므로, `:127` 분기는 같은 원인으로 두 번째 건을 더할 뿐입니다.

**Fix:** 사람이 범위를 정할 일입니다.
- 지원 페이지 존재 확인은 3번 점검에 맡기고, `:124-129`의 링크 분기만 걷어냅니다. `:119`의 `if`는 남기고, 7번은 그 안에서 WR-01의 본문 확인을 합니다.
- 「보류 묶음이 `main`에 섞일 때 더 구체적인 메시지를 낸다」는 가치를 남기고 싶다면 분기는 그대로 둡니다. 그때는 `:117` 주석만 현재 상태(「지원 페이지는 3번 점검이 필수로 확인한다. 이 항목은 본문 연락처를 본다」)로 고칩니다.

## Info

### IN-01: 푸터의 운영 안내·저작권 문장이 운영사 이름을 하드코딩해 `trade_name` 슬롯과 따로 논다

**File:** `_includes/footer.html:20`, `:35` (관련: `support/index.html:36`, `_data/company.yml:7`)
**Issue:** 같은 푸터 안에서 운영사 이름의 출처가 둘로 갈립니다.
- `:20`의 운영 안내 문장과 `:35`의 저작권 줄은 운영사 이름을 문자열로 직접 씁니다.
- 바로 아래 사업자 줄(`:23`)과 지원 페이지 FAQ(`support/index.html:36`)는 같은 이름을 `site.data.company.trade_name`에서 읽습니다.

지금은 값이 같아 문제가 없습니다. 하지만 상호가 바뀌면(예: 법인 전환) `_data/company.yml`만 고치게 됩니다. `CLAUDE.md`가 「이 파일 한 곳에서만 고친다」고 하기 때문입니다. 그러면 한 푸터 안에 서로 다른 운영사 이름이 나란히 찍힙니다. 「운영 안내·저작권 문장은 그대로다」라는 방침(`CLAUDE.md` Content & Naming Rules)은 의도한 것이므로, 이 항목은 drift 위험만 기록합니다.
**Fix:** 두 문장을 그대로 둘 거라면 `_data/company.yml:7` 주석에 「상호를 바꾸면 `_includes/footer.html`의 운영 안내·저작권 문장도 함께 본다」를 적어 둡니다. 다음 내용 변경 단계에서는 두 문장도 `trade_name`을 쓰고 값이 없을 때 현재 문자열로 대체하는 방안을 검토합니다.

### IN-02: 지원 FAQ가 값 바로 뒤에 조사(「입니다」)를 붙여 규칙 문구와 어긋난다

**File:** `support/index.html:36`
**Issue:** `{{ site.data.company.trade_name | escape }}입니다`는 서술격 조사 「이다」의 활용형을 값 바로 뒤에 붙입니다.
- **규칙:** `CONVENTIONS.md`(`.claude/CLAUDE.md` 「사실값 슬롯」)는 「값 바로 뒤에 조사를 붙이지 않는다 (값에 따라 조사가 달라진다)」고 합니다.
- **실제 위험:** 「입니다」는 받침 유무와 상관없이 같은 꼴이라 지금 위험은 거의 없습니다. 다만 규칙이 예외 없이 쓰여 있어서, 다음 단계(Phase 6~8 법적 본문)에서 「은/는」「이/가」 같은 가변 조사를 붙여도 된다는 선례로 읽힐 수 있습니다.

**Fix:** 둘 중 하나를 고릅니다.
- 문장을 「운영 주체: {{ … }}」처럼 값으로 끝나게 바꿉니다.
- 규칙에 「형태가 바뀌지 않는 서술격 조사 『입니다』는 허용」 예외를 적습니다. 원본 `CONVENTIONS.md`를 고치고 `.claude/CLAUDE.md`를 다시 생성합니다.

### IN-03: 전화만 있고 이메일이 없으면 푸터에는 전화가 나오지만 `/support/`에는 나오지 않는다. 루트 `CLAUDE.md`의 이메일 행 설명도 실제 조건과 다르다

**File:** `_includes/footer.html:30-33`, `support/index.html:9`, `:14-16`, `CLAUDE.md` 「Architecture / styling notes」의 **푸터** 항목
**Issue:** 푸터와 지원 페이지가 전화 값을 다른 조건으로 그립니다.
- **푸터:** 연락처 행을 `support_email or phone`으로 엽니다(`:30`). 그래서 전화만 있어도 행이 나옵니다.
- **지원 페이지:** 전화 줄(`:14-16`)이 `support_email`로 감싼 `#contact` 구간(`:9`) 안에 있습니다. 그래서 전화만 있는 상태에서는 `/support/`에 연락처가 하나도 나오지 않습니다.
- **문서 불일치:** 루트 `CLAUDE.md`는 이 행을 「이메일 행(`_data/company.yml`의 `support_email` 값이 있을 때만, `mailto:` 링크)」로 설명합니다. 이는 `:30`의 실제 조건과 다릅니다. `.claude/CLAUDE.md` 구성 요소 표의 설명(「`phone` 값이 있으면 같은 줄에 전화」)은 맞습니다.

지금은 `phone`이 비어 있고(U1), 이메일이 없는 상태는 WR-01/7번 점검이 푸시를 막습니다. 그래서 실제로 드러나지는 않습니다.
**Fix:** 둘 중 하나를 고릅니다.
- 루트 `CLAUDE.md` 문장을 「연락처 행(`support_email`이나 `phone` 값이 있을 때. 이메일은 `mailto:` 링크)」으로 고칩니다.
- `phone`을 채우는 단계에서 지원 페이지의 전화 줄을 `#contact` 구간 조건 밖으로 꺼낼지 함께 정합니다.

### IN-04: `_data/company.yml`의 값 규칙(공백만 금지, 자리표시 금지)이 주석으로만 있고 점검이 없다

**File:** `_data/company.yml:2-4`, `scripts/check-site.sh` (해당 항목 없음)
**Issue:** 「공백만 넣지 않는다」와 「『추후 기재』 같은 자리표시는 쓰지 않는다」는 주석과 `CLAUDE.md`에만 있습니다.
- **공백만 넣을 때:** `.size > 0` 판정이 참이 되어 「상호  」처럼 라벨만 있는 행이 라이브에 나갑니다.
- **자리표시를 넣을 때:** 그 값이 모든 페이지 푸터에 그대로 찍힙니다.

빌드 결과는 정상이고 제목 점검도 통과합니다. 그래서 `main` 푸시가 곧 배포인 이 저장소에서 막을 장치가 없습니다.
**Fix:** `check-site.sh`에 원본 검사 한 줄을 더합니다. 예: `grep -n -E '^[a-z_]+: *"[[:space:]]+"' "$SRC/_data/company.yml"`과 `grep -n -E '^[a-z_]+:.*추후' "$SRC/_data/company.yml"`(주석 줄의 「추후 기재」 설명은 빼기 위해 키 줄만 봄)가 걸리면 `problem`으로 셉니다. 원본 검사이므로 값이 출력되지 않게 줄 번호와 키 이름만 메시지에 씁니다.

---

_Reviewed: 2026-11-19T19:29:22Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
