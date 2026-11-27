---
phase: 06-data-deletion-rewrite
reviewed: 2026-11-27T04:52:31Z
depth: standard
files_reviewed: 6
files_reviewed_list:
  - _data/company.yml
  - .claude/CLAUDE.md
  - CLAUDE.md
  - data-deletion/index.html
  - README.md
  - scripts/check-site.sh
findings:
  critical: 0
  warning: 4
  info: 0
  total: 4
  necessity: 0
status: issues_found
---

# Phase 6: Code Review Report

**Reviewed:** 2026-11-27T04:52:31Z
**Depth:** standard
**Files Reviewed:** 6
**Status:** issues_found

## Summary

리뷰 범위는 `diff_base` 이후 Phase 6 변경 파일 6개입니다. 삭제 안내 재작성(`data-deletion/index.html`), 푸시 전 점검 8번 추가와 6번 확장(`scripts/check-site.sh`), 사실값 슬롯 키 추가(`_data/company.yml`), 문서 갱신(`CLAUDE.md`, `.claude/CLAUDE.md`, `README.md`)이 들어 있습니다.

직접 확인한 내용:

- 현재 작업 트리로 `scripts/check-site.sh`를 돌리면 통과합니다 (Jekyll 3.10.0).
- 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`의 방침 구간은 서로 같습니다.
- 임시 사본에서 `generate-claude-md`를 다시 돌린 결과가 커밋된 `.claude/CLAUDE.md`와 바이트 단위로 같습니다. GSD 생성 구간을 손으로 고친 흔적은 없습니다.
- `_data/company.yml`의 키는 모두 큰따옴표로 감싼 문자열입니다. 값이 있는 키에는 HTML·Liquid 특수 문자(`< > & " ' { } %`)와 앞뒤 공백이 없습니다. `phone`만 빈 값(`""`)입니다. 템플릿 출력은 모두 `| escape`를 거칩니다.
- 소개 `<p>`는 `section` 밖 최상위 요소입니다. 그래도 `.rp-doc > * + *`(32px 간격)와 `.rp-doc` 본문 글씨 규칙을 받으므로 화면이 깨지지 않습니다.

주요 우려:

1. 점검 8번의 본문 블록 추출(awk)은 종료 줄을 못 찾으면 실패하지 않고 파일 끝까지 읽습니다. 이때 공유 푸터의 mailto 때문에 거짓 통과합니다. 주석이 막겠다고 적은 바로 그 경우입니다.
2. 점검 8번의 mailto 검사는 본문 어디든 mailto가 하나만 있으면 통과합니다. 그래서 `#request`의 요청 경로(D-20)가 사라져도 「문의처」 링크 하나로 통과합니다.
3. 콘솔에 등록하는 앵커(`#facebook` 등)가 있는지는 어떤 점검도 확인하지 않습니다.
4. `support_email`이 비면 페이지 안의 참조가 어긋납니다. 「2~4번」 문구가 남고, ①만 남은 제목과 지원 이메일을 가리키는 무조건 문장이 생깁니다. 지금은 점검 8번이 이 상태의 푸시를 막지만, 빌드 결과 자체는 어긋납니다.

Critical에 해당하는 보안 결함이나 데이터 손실 경로는 찾지 못했습니다.

## Narrative Findings (AI reviewer)

## Warnings

### WR-01: 점검 8번 본문 추출이 종료 줄을 못 찾으면 푸터까지 읽어 거짓 통과함 (fail-open)

**File:** `scripts/check-site.sh:140`
**Issue:**
awk 프로그램은 16칸 들여쓴 `</div>` 한 줄(`^                <\/div>$`)을 만나야 멈춥니다. 이 줄을 못 만나면 파일 끝까지 출력하고 종료 코드 0을 돌려줍니다. 줄을 못 만나는 경우는 다음과 같습니다.

- `_layouts/legal.html:32`의 들여쓰기가 바뀐 경우
- `</div>` 뒤에 공백이나 CR이 붙은 경우
- 레이아웃 구조를 바꾼 경우

그러면 `dd_body`에 공유 푸터(`_includes/footer.html`의 `mailto:` 링크)가 들어가고, 142행의 mailto 검사가 본문에 링크가 없어도 통과합니다. 134행 주석은 「파일 전체를 보면 푸터 때문에 거짓 통과한다」를 막으려고 본문만 본다고 적었습니다. 그런데 추출이 실패하면 조용히 「파일 전체」 모드로 돌아갑니다.

재현은 두 가지로 했습니다. 본문에 mailto가 없고 푸터에만 mailto가 있는 HTML을 두 벌 만들었습니다. 한 벌은 `</div>`를 12칸으로 들여썼고, 다른 한 벌은 줄 끝에 CR을 붙였습니다. 두 벌 모두 추출 결과에서 `href="mailto:`가 1건 잡혔습니다. 141행의 `dd_rc` 검사는 awk의 종료 코드만 보므로 이 경우를 못 잡습니다.

**Fix:** 종료 줄을 봤는지 기록하고, 못 봤으면 0이 아닌 코드로 끝내서 141행이 실패로 세게 합니다.
```bash
dd_body=$(awk '/<div class="rp-doc">/{f=1;next} f && /^[[:space:]]*<\/div>[[:space:]]*\r?$/{done=1;exit} f{print} END{if(!f||!done) exit 3}' "$dd"); dd_rc=$?
[ "$dd_rc" -eq 0 ] || problem "점검 8번 본문 블록을 찾지 못했습니다 (종료 코드 ${dd_rc}): /data-deletion/"
```
(`.rp-doc` 본문에는 `div`를 쓰지 않으므로, 들여쓰기를 느슨하게 맞춰도 본문 중간에서 끊기지 않습니다. D-04 허용 요소에 `div`가 없습니다.)

### WR-02: 점검 8번 mailto 검사는 `#request` 요청 경로(D-20)가 아니라 본문 아무 곳의 mailto로 통과함

**File:** `scripts/check-site.sh:142-145`, `data-deletion/index.html:21`, `data-deletion/index.html:192`
**Issue:**
지금 빌드의 본문 블록에는 `href="mailto:`가 2건 있습니다. 하나는 `#request`의 ② 블록(21행)이고, 다른 하나는 「문의처」 섹션(192행)입니다. 파일 전체로 세면 푸터를 더해 3건입니다.

검사는 `grep -qF 'href="mailto:'` 하나로 1건 이상이면 통과합니다. 그래서 누가 `#request` 안의 ② 블록(18–31행)을 지우거나 조건을 잘못 바꿔도, 「문의처」의 mailto가 남아 있으면 푸시가 그대로 나갑니다. 오류 메시지와 D-20이 지키려는 것은 「앱 없이 지원 이메일로 삭제를 요청하는 경로」입니다. 그런데 검사는 「연락처가 어딘가에 있다」만 확인합니다. Google Play 웹 삭제 요청 URL 심사의 핵심 요건을 이 점검이 실제로는 보증하지 못합니다.

**Fix:** 본문 전체가 아니라 `<section id="request">`부터 첫 `</section>`까지만 잘라서 mailto를 찾습니다.
```bash
dd_req=$(printf '%s\n' "$dd_body" | awk '/<section id="request">/{f=1} f{print} f && /<\/section>/{exit}')
printf '%s\n' "$dd_req" | grep -qF 'href="mailto:'; dd_rc=$?
if [ "$dd_rc" -gt 1 ]; then problem "점검 8번 grep이 실패했습니다 (종료 코드 ${dd_rc})"
elif [ "$dd_rc" -eq 1 ]; then problem '삭제 안내 #request에 지원 이메일 경로(mailto)가 없습니다: /data-deletion/ (D-20)'
fi
```

### WR-03: 콘솔·스토어에 등록하는 고정 앵커가 있는지 점검하지 않음

**File:** `scripts/check-site.sh:133-158`, `data-deletion/index.html:13`, `data-deletion/index.html:125`, `data-deletion/index.html:140-175`
**Issue:**
`CLAUDE.md`(Pages 표)는 `#request`·`#location`·`#google`·`#apple`·`#facebook`·`#kakao`·`#naver`·`#line`을 「콘솔·이후 문서가 씀, 이름 고정」으로 정했습니다. 그중 `#facebook`은 Facebook Data Deletion Instructions URL로 콘솔에 등록됩니다. 본문 안에서도 `href="#request"` 7곳(132·143·150·157·164·171·178행)이 이 앵커를 가리킵니다.

그런데 점검 8번은 mailto, 소개 문단, noindex, 임시 표시만 봅니다. 섹션 `id`를 바꾸거나 지워도 빌드와 모든 점검이 통과합니다. 그러면 콘솔에 등록한 URL은 페이지 맨 위로 열립니다. 심사자가 해당 제공자 안내를 찾지 못해 반려될 수 있고, 이 결함은 조용히 배포됩니다. 같은 페이지에 대한 게이트를 이번 단계에서 새로 만들었으므로, 이 불변식도 함께 잠그는 것이 맞습니다.

**Fix:** 점검 8번 블록 안에 앵커 목록 검사를 더합니다 (bash 3.2 호환, 배열 없이).
```bash
for a in request location google apple facebook kakao naver line; do
    grep -qF "<section id=\"${a}\">" "$dd"; dd_rc=$?
    if [ "$dd_rc" -gt 1 ]; then problem "점검 8번 grep이 실패했습니다 (종료 코드 ${dd_rc})"
    elif [ "$dd_rc" -eq 1 ]; then problem "삭제 안내에 고정 앵커가 없습니다: /data-deletion/#${a}"
    fi
done
```

### WR-04: `support_email`이 비면 본문 참조가 어긋남 (「2~4번」·외톨이 ①·숨은 이메일을 가리키는 무조건 문장)

**File:** `data-deletion/index.html:15`, `data-deletion/index.html:36`, `data-deletion/index.html:131-136`, `data-deletion/index.html:143-179`
**Issue:**
이 페이지는 render-if-present 규칙에 따라 `support_email` 값이 없으면 ② 블록, 처리 기간 문단, 위치정보 철회 3번 항목을 숨깁니다. 그런데 이 값들을 가리키는 주변 문구는 조건 없이 남습니다. `support_email`만 `""`로 바꾸고 Jekyll 3.10.0으로 빌드해 확인했습니다.

- `#location`의 `<ol>`은 항목이 3개인데, 136행은 「위치정보 동의를 철회하면(2~4번)」이라고 4번 항목을 가리킵니다. 항목 번호와 법적 효과(지체 없이 파기)를 잇는 문장이라 의미가 틀어집니다.
- `#request`에 `<h3>① 앱에서 요청하기</h3>`(15행)만 남고 ②가 없습니다.
- 제공자 섹션 6곳(143·150·157·164·171·178행)은 「앱의 회원탈퇴나 지원 이메일로 요청할 수 있습니다」라고 쓰고, 144·151·158·165·172·179행은 「지원 이메일로 삭제를 요청했다면」이라고 씁니다. 두 문장 모두 조건 없이 나오므로, 페이지 어디에도 없는 지원 이메일을 안내하게 됩니다.

지금은 점검 8번(142–145행)이 본문 mailto 0건을 잡아 이 상태의 푸시를 막습니다. 빈 값으로 빌드한 출력에서 실제로 0건이 나왔습니다. 다만 `git push --no-verify`로 건너뛸 수 있고, 로컬 미리보기에서는 그대로 보입니다. 또 WR-02를 고치지 않으면 「문의처」 쪽 조건이 바뀌는 경우에도 게이트가 이 상태를 놓칠 수 있습니다. 조건 분기를 둔 이상 그 분기의 출력도 맞아야 합니다.

**Fix:** 번호에 기대지 않는 문구로 바꾸고, 지원 이메일을 가리키는 문장은 같은 조건으로 감쌉니다.
```html
<p>위 방법 가운데 기록을 지우거나 회원탈퇴를 하면(위치 권한 끄기 제외) 해당 개인위치정보와 위치정보 수집·이용·제공사실 확인자료를 지체 없이 파기합니다.</p>
```
```liquid
{%- if site.data.company.support_email.size > 0 %}
                        <p>계정과 데이터 삭제는 앱의 회원탈퇴나 지원 이메일로 요청할 수 있습니다. 방법은 <a href="#request">삭제 요청 방법</a>에 있습니다.</p>
{%- else %}
                        <p>계정과 데이터 삭제는 앱의 회원탈퇴로 요청할 수 있습니다. 방법은 <a href="#request">삭제 요청 방법</a>에 있습니다.</p>
{%- endif %}
```
①은 ②가 있을 때만 번호를 붙이거나, 번호 없는 제목(「앱에서 요청하기」)으로 둡니다. 다른 방법도 있습니다. 이 페이지는 `support_email` 없이는 게시하지 않는다는 방침(점검 8번)을 정본으로 삼고, 이 파일의 `support_email` 조건 분기를 모두 걷어 내는 것입니다. 그러면 분기와 문구가 어긋날 여지가 사라집니다. 두 방법 가운데 하나를 골라 `CLAUDE.md`의 render-if-present 예외로 적어 둡니다.

---

_Reviewed: 2026-11-27T04:52:31Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
