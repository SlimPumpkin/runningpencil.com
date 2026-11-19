# Phase 6: 데이터 삭제 안내 재작성 - Pattern Map

**Mapped:** 2026-11-20
**Files analyzed:** 13 (사이트 3, 점검 스크립트 1, 문서 8, 스크래치 도구 1묶음)
**Analogs found:** 13 / 13 (표 `figure` 감싸개만 CSS 규칙만 있고 본문 사용례 없음)

> 저장소는 PUBLIC입니다. 이 문서에는 사업자 값·지원 이메일·스토어 개발자 이름 값을 적지 않고 `_data/company.yml` 키 이름으로만 가리킵니다.

## File Classification

| 새로 만들거나 고칠 파일 | Role | Data Flow | Closest Analog | Match Quality |
|---|---|---|---|---|
| `data-deletion/index.html` (본문 전부 교체, front matter 수정) | page (legal layout) | build-time transform (`_data` → Liquid) | `support/index.html` | exact |
| `_data/company.yml` (새 키 `store_developer_name` 권장) | config (사실값 슬롯) | static data | 같은 파일 7-12행 | exact |
| `scripts/check-site.sh` (별도 build 커밋: 6번 범위 확장·삭제 안내 가드) | utility (점검) | batch / file-I/O | 같은 파일 94-128행 (6번·7번) | exact |
| `CLAUDE.md`, `.claude/CLAUDE.md` (방침 행·Pages 표·키 목록) | config/doc | — | Phase 5 `05-07-PLAN.md` | exact |
| `.planning/codebase/CONVENTIONS.md`·`ARCHITECTURE.md`·`STACK.md` (GSD 원본 맵) | doc | 생성기 입력 | `05-07-PLAN.md` | exact |
| `.planning/baseline/NAMES.md` | doc | — | 같은 파일 21행 | exact |
| `.planning/baseline/DECISIONS.md` (U6-가·U6-나·N3 결정됨) | doc | — | 같은 파일 20-21행, 90-110행, 181행 | exact |
| `.planning/baseline/DATA-INVENTORY.md` (재기준) | doc | — | 같은 파일 구간 E·G·H | exact |
| `.planning/baseline/USER-TASKS.md` (새 작업: 운영자 삭제 요청 처리 절차) | doc (runbook) | — | 같은 파일 `## 작업 9` (263-290행) | role-match |
| 저장소 밖 스크래치 `$W/lib.sh`, `$W/pw/p6-deletion.mjs`, `$W/yml/*` | test tooling (커밋 안 함) | batch | Phase 5 `05-01-PLAN.md` `<scratch_contract>` (91행~) | exact |

## Pattern Assignments

### `data-deletion/index.html` (page, build-time transform)

**Analog:** `support/index.html` (같은 `layout: legal`, `_data` 조건부 렌더, `section id` 앵커)

**Front matter 패턴** (`support/index.html:1-8`):
```yaml
---
layout: legal
title: "고객 지원"
description: "..."
eyebrow: "SUPPORT"
heading: "러닝펜슬 고객 지원"
updated: "2026년 11월 19일"
---
```
현재 `data-deletion/index.html:1-9`에서 바꿀 것: `title`은 「데이터 삭제 안내」 그대로(`scripts/check-site.sh` `EXPECTED_TITLES`), `heading` → 「러닝펜슬 계정·데이터 삭제 안내」(D-17), `updated`는 재작성 커밋 날짜, **`noindex: true` 줄 삭제**(U14), `description`에는 큰따옴표·`<`·`&`를 쓰지 않음(`_layouts/legal.html:9`가 escape 없이 넣음).

**조건부 section + mailto 패턴** (`support/index.html:9-17`):
```liquid
{%- if site.data.company.support_email.size > 0 %}
                    <section id="contact">
                        <h2>문의하기</h2>
                        <p>...</p>
                        <p><a href="mailto:{{ site.data.company.support_email | escape }}">{{ site.data.company.support_email | escape }}</a></p>
{%- if site.data.company.phone.size > 0 %}
                        <p>전화 {{ site.data.company.phone | escape }}</p>
{%- endif %}
                    </section>
{%- endif %}
```
- `{%-`는 `if`/`endif`에만, 0열. `section`은 공백 20칸, 자식 24칸.
- `#request`(삭제 요청 방법)·문의처 조항이 이 모양을 그대로 씀.

**운영 주체 값 문장 패턴** (`support/index.html:33-38`):
```liquid
{%- if site.data.company.trade_name.size > 0 %}
                        <dl>
                            <dt>러닝펜슬은 누가 운영하나요?</dt>
                            <dd>러닝펜슬의 운영 주체는 {{ site.data.company.trade_name | escape }}입니다. ...</dd>
                        </dl>
{%- endif %}
```
- 값 바로 뒤에 조사를 붙이지 않음(「…입니다」처럼 서술어로 끝냄). 개발자 이름 구절도 같은 방식: `{{ site.data.company.store_developer_name | escape }}`, 판정은 `.size > 0`만, 여러 키는 `or`로만.

**앱 경로 문장 정합** (`support/index.html:44-45`): FAQ의 「설정 → 내 계정 → 회원탈퇴」 문장과 `<strong>` 경로 표기를 삭제 안내 앱 경로 문장에 그대로 맞춤(현재 `data-deletion/index.html:12`의 「설정 → 계정 삭제」는 틀린 경로).

**표 패턴** (`figure` 감싸개): 본문 사용례는 아직 없음(`privacy-policy`·`terms`에 `figure` 없음). 규칙 출처는 `_includes/css/legal.css:3-4`(허용 요소·감싸개 주석), `:35`(스크롤 그림자). `#retained` 「남는 데이터」 표는 다음 꼴로 처음 씀:
```html
                        <figure tabindex="0" aria-label="탈퇴 뒤 남는 데이터">
                            <table>
                                <thead>
                                    <tr><th>데이터</th><th>남는 이유</th><th>기간</th></tr>
                                </thead>
                                <tbody>
                                    <tr><td>...</td><td>...</td><td>...</td></tr>
                                </tbody>
                            </table>
                        </figure>
```
- 표 칸에 바탕색·클래스 금지, `<table>`에 `display:block` 금지. 검증에서 모든 `<figure`에 `tabindex="0"`·`aria-label` 있는지 grep(CONVENTIONS 「법적 본문 작성 규칙」).

**본문 골격**: `06-RESEARCH.md` 517-532행(앵커 `#request` `#timeline` `#deleted` `#retained` `#partial` `#location` `#google` `#apple` `#facebook` `#kakao` `#naver` `#line`, 제공자 순서는 앱 `kSocialProviderOrder`). 끝 「임시 게시본」 `<footer>` 삭제(지원 페이지처럼 끝 안내 없음 가능).

---

### `_data/company.yml` (config, static data)

**Analog:** 같은 파일 머리 주석 1-6행과 키 줄 7-12행 (값은 여기 적지 않음):
```yaml
support_email: "<값>"     # 지원 이메일 (게이트 뒤)
phone: ""             # 전화번호 (칸만, U1·BIZ-03)
```
- 새 줄: `store_developer_name: ""   # 스토어 개발자 이름 (Google Play·App Store 등록 표기 그대로, DEL-02)` — 큰따옴표, 빈 값 `""`, 공백만 금지.
- 값은 커밋 직전 대화로만 받음(D-18). `.planning/`·커밋 메시지에 값 금지. 받는 흐름의 계획 모양은 Phase 5 `05-05-PLAN.md`(가짜 값 tracer → 작업 트리에만 쓰기 → `commit-tree` 후보 판정 → 사용자 승인)와 `05-06-PLAN.md`(값 커밋 → pre-push 경로 → SHA 승인 → 푸시 → `pages_wait`·`live` 라이브 확인).

---

### `scripts/check-site.sh` (utility, batch) — 별도 build 커밋, 재작성 라이브 확인 뒤

**Analog:** 같은 파일 6번(94-113행)·7번(115-128행). 계획 모양은 `05-04-PLAN.md`(후보를 기준·대상에서 통과, 음성 시험 객체(`mkobj`)에서 새 항목 하나만으로 실패, 그 뒤 pre-push 훅 경로 확인).

**머리 목록 패턴** (2-9행): 항목을 더하거나 범위를 넓히면 「일곱 가지」 숫자와 목록 줄을 함께 고침. CLAUDE.md 두 사본·STACK.md·CONVENTIONS.md의 점검 항목 설명도 같은 단계 문서 커밋에서.

**6번 grep 패턴** (105-112행 핵심):
```bash
if [ -f "$DEST/index.html" ]; then
    u10_hits=$(grep -o -E "(${U10_ALLOW_PREFIX})?포인트|굿즈|코스북" "$DEST/index.html"); u10_rc=$?
    if [ "$u10_rc" -gt 1 ]; then
        problem "점검 6번 grep이 실패했습니다 (종료 코드 ${u10_rc}, U10_ALLOW_PREFIX='${U10_ALLOW_PREFIX}')"
    else
        u10=$(printf '%s\n' "$u10_hits" | grep -v -x -E "(${U10_ALLOW_PREFIX})포인트" | grep -c .)
        [ "${u10:-0}" -eq 0 ] || problem "랜딩에 출시 범위 밖 기능 이름이 있습니다: /index.html ${u10}곳 (포인트·굿즈·코스북, U10)"
    fi
fi
```
- 삭제 안내 확장은 파일 목록을 `index.html data-deletion/index.html`로 돌리는 꼴. 96행 주석 「법적 문서 본문에는 Phase 6~8 전까지 남아 있으므로」를 함께 고침. grep 종료 코드 2 이상은 실패로 셈(같은 규칙 유지). bash 3.2 호환(연관 배열·mapfile 금지, 12행).

**7번 존재 가드 패턴** (118-121행):
```bash
if [ -f "$DEST/support/index.html" ]; then
    grep -qF 'href="mailto:' "$DEST/support/index.html" \
        || problem '...'
fi
```
- **주의 (RESEARCH Pitfall 1):** 모든 페이지 푸터(`_includes/footer.html` 이메일 행)에 `mailto:`가 있으므로, 삭제 안내 가드는 파일 전체가 아니라 본문 블록(`<div class="rp-doc">`부터 그 닫는 `</div>`까지)만 잘라 검사. 가드 후보: 본문 `mailto` ≥1, `noindex` 없음, 「임시 게시본」 없음, 개발자 이름 키가 비면 실패(RESEARCH 456행 이후).
- 실패 보고는 `problem`(누적), 끝 `[ "$errors" -eq 0 ] || fail ...`(130행).

---

### 두 `CLAUDE.md` + GSD 원본 맵 (doc)

**Analog:** `05-07-PLAN.md` (원본 맵 → `node ~/.claude/gsd-core/bin/gsd-tools.cjs generate-claude-md` → `.claude/CLAUDE.md`로 이어지는지 tracer, 두 사본 방침 구간 같은 커밋, 옛 상태 잔여 훑기).
고칠 자리:
- 방침 표 「법적 페이지 `noindex` 해제」 행 현재 상태, 「포인트·굿즈·코스북 제거」 행(삭제 안내 반영), 「지원 이메일 공개」 행의 「법적 문서에는 Phase 6~8」 문장.
- Pages 표 `data-deletion/index.html` 행, `_data/company.yml` 키 목록(`store_developer_name`), Deploy·점검 항목 설명(check-site 확장 시).
- `.planning/codebase/CONVENTIONS.md:196` 사실값 슬롯 키 목록, Content & Naming Rules의 `noindex` 문장; `ARCHITECTURE.md:30`, `:126`(Entry Points `noindex`); `STACK.md:67`(법적 페이지 3종 `noindex`).
- 「소개 문단을 최상위 `<p>`로 허용」을 고르면(RESEARCH 529행 (가)) CONVENTIONS 「법적 본문 작성 규칙」·`legal.css` 머리 주석·CLAUDE.md 규칙을 같은 단계에서 고침.

### `.planning/baseline/NAMES.md` / `DECISIONS.md` / `DATA-INVENTORY.md`

- `NAMES.md:21` 「스토어 개발자 이름」 행: 「들어갈 곳」에 키 이름만 추가, 값 칸은 그대로 비움.
- `DECISIONS.md:20-21` 표의 상태 「열림」 → 「결정됨」, 상세 절 `### U6-가`(90행)·`### U6-나`(100행), `N3`(181행)에 결정 근거(D-01·D-02·D-26).
- `DATA-INVENTORY.md`: 구간 G·E·H 재기준, Analytics 기간 「최대 14개월(설정 미확인)」, Google·Apple 연결 해제 정정(RESEARCH C-3).

### `.planning/baseline/USER-TASKS.md` (새 작업 13 — 운영자 삭제 요청 처리)

**Analog:** `## 작업 9 — 사업자 값 준비` (263-290행) 절 구조:
```
## 작업 N — 제목
**막는 단계:** ...
**순서:**
1. ...
**레코드 표:** 해당 없음
**변경 전후 dig:** 해당 없음
**끝났는지 확인:** ...
**Claude에게 넘길 것:** ...
```
- 내용: 본인 확인(가입 이메일 일치), 도구 실행, 확인 메일·답장 양식, 처리 상한(C-1 결정 값). 주소·값은 글자로 적지 않고 `support_email` 키·이름 표로 가리킴.

### 스크래치 도구 (커밋 안 함)

**Analog:** `05-01-PLAN.md` `<scratch_contract>`(91행~)와 `05-EVIDENCE.md` 기록 꼴.
- `W` 식: Phase 5 식에서 접미사만 `-p6-scratch`(저장소 옆, 임시 폴더 밖, 단계 검증 뒤 사용자가 삭제).
- `lib.sh` 함수 재사용: `build_src`·`build`·`variant`·`serve`·`stop`·`mkobj`·`pages_wait`·`live`·`vals`(키 목록에 `store_developer_name` 추가). `footblock`과 같은 꼴로 `doc <파일>`(본문 `.rp-doc` 블록 추출) 추가.
- 사이트 커밋 후보 절차: `git add` 대상만 → `git diff --cached --name-only` 대조 → `CAND=$(git commit-tree "$(git write-tree)" -p HEAD -m candidate)` → `scripts/check-site.sh "$CAND"`.
- 라이브 요청은 `?cb=<커밋 12자리>`.
- `p6-deletion.mjs`: `p5-support.mjs` 꼴(Chromium·WebKit × 375·1280, `OK/FAIL <엔진> <폭> ...` 줄 출력) + 제목·h1·robots 없음·앵커 집합·overflow 판정(`06-VALIDATION.md:74-75`).

## Shared Patterns

### 사실값 렌더 (render-if-present)
**Source:** `support/index.html:9-17,33-38`, `_includes/footer.html` 이메일 행
**Apply to:** `data-deletion/index.html`의 모든 값 출력
- `site.data.company.<키>.size > 0`만, `or`만, 모든 출력 `| escape`, 값 뒤 조사 금지, 값을 HTML에 글자로 쓰지 않음.

### 법적 본문 규칙 (D-01~D-12)
**Source:** `_includes/css/legal.css:3-4`, `.planning/codebase/CONVENTIONS.md` 「법적 본문 작성 규칙」
**Apply to:** `data-deletion/index.html`
- 허용 요소만, 클래스 없음, `section` 첫 자식 `h2`, 앵커 `id`는 `section`에, 보충 설명 `aside`, 절대 표현(「모든 데이터」「즉시 완전히」) 금지, 데이터 목록에 있는 사실만.

### 커밋 분리·푸시 절차
**Source:** Phase 5 `05-04`(build 가드), `05-05`/`05-06`(값 승인·푸시), `05-07`(문서)
**Apply to:** 내용 커밋 / check-site build 커밋 / 문서 커밋을 각각 따로. `main` 푸시 = 배포, 푸시 뒤 `/privacy-policy/`·`/terms/`·`/data-deletion/`·`/support/` 200·제목 확인.

## No Analog Found

| File | Role | Data Flow | Reason |
|---|---|---|---|
| (부분) `data-deletion/index.html`의 `figure`>`table` | page 본문 | transform | 사이트에 표 사용례가 아직 없음. CSS 규칙(`legal.css:35`)과 CONVENTIONS D-06~D-08만 근거 |

## Metadata

**Analog search scope:** `support/`, `data-deletion/`, `privacy-policy/`, `terms/`, `_includes/`, `_data/`, `scripts/`, `.planning/baseline/`, `.planning/codebase/`, `.planning/phases/05-business-info-support-contact/`
**Files scanned:** 약 20
**Pattern extraction date:** 2026-11-20
