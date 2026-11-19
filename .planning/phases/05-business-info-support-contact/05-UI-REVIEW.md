# Phase 5 — UI Review

**Audited:** 2026-11-20
**Baseline:** 추상 6-pillar 기준 (이 단계에는 UI-SPEC.md 없음). 잠긴 결정은 `05-CONTEXT.md` D-07·D-08·D-13~D-16, 법적 본문 작성 규칙 D-01~D-12
**Screenshots:** not captured — 로컬 dev 서버 없음, 라이브(`https://runningpencil.com/support/`) 캡처는 Playwright 실행 실패(데스크톱·모바일 둘 다). 코드 기반 감사
**Interaction captures:** off (workflow.ui_interaction_capture is false)

감사 대상은 Phase 5가 바꾼 부분만입니다: 공유 푸터의 사업자 줄·주소 줄·이메일 행(`_includes/footer.html:19-32`), 「공통」 CSS `.rp-foot-legal span`·`.rp-foot-legal a`(`_includes/css/common.css:30-31`), 헤더·푸터 「고객 지원」 링크(`_includes/header.html:12`, `_includes/footer.html:16`), 새 `/support/` 페이지(`support/index.html`).

---

## Pillar Scores

| Pillar | Score | Key Finding |
|--------|-------|-------------|
| 1. Copywriting | 3/4 | 라벨·응답 약속(D-14)·신고 항목(D-15)이 결정대로. 단 FAQ의 계정 삭제 경로가 링크된 `/data-deletion/` 본문과 다르고, `#report`의 「위 지원 이메일」은 앵커로 바로 열면 가리킬 대상이 안 보임 |
| 2. Visuals | 3/4 | 법적 카드 틀 재사용으로 위계 일관. FAQ 질문·답 쌍 사이 간격(12px)이 쌍 안 문단 간격과 같아 쌍 경계가 약함 |
| 3. Color | 3/4 | 새 hex 없음, 푸터 보조 글자 `#B5B0A7`/흑연 대비 약 6.9:1 통과. 푸터 링크는 hover·focus 외 상태 변화가 없고 색이 토큰 밖 하드코딩 |
| 4. Typography | 3/4 | 푸터 13px 단일 크기, 지원 페이지는 기존 h2 20/700·dt 700 재사용. eyebrow 「SUPPORT」만 한국어 전용 사이트에서 영어 |
| 5. Spacing | 3/4 | `&nbsp;· `와 `span inline-block`으로 항목 단위 줄바꿈(D-07) 충족. 푸터 법적 블록 6줄이 `gap: 6px`으로 촘촘하고 주소 줄만 `span`이 없어 구조가 다름 |
| 6. Experience Design | 3/4 | render-if-present가 행·구간·FAQ 쌍 단위로 일관(D-08). 860px 이하에서 헤더 메뉴가 숨어 「고객 지원」은 푸터에서만 닿고, 푸터 이메일 링크는 터치 대상 44px 미만 |

**Overall: 18/24**

---

## Top 3 Priority Fixes

1. **FAQ 계정 삭제 경로와 `/data-deletion/` 본문 불일치** (WARNING) — FAQ는 「설정 → 내 계정 → 회원탈퇴」라 쓰고 바로 `/data-deletion/`으로 보내는데, 그 페이지(임시 게시본)는 다른 경로를 적고 있어 심사자·사용자가 링크를 따라가면 서로 다른 안내를 봄 (`05-CONTEXT.md` D-16 참고에서 이미 인지, Phase 6으로 미룸) — Phase 6 재작성에서 반드시 앱 코드 경로로 맞추고, 그 전까지는 라이브에 모순이 있다는 사실을 Phase 6 성공 기준에 명시한다.
2. **좁은 화면에서 「고객 지원」 진입점이 푸터뿐** (WARNING) — `common.css:32`의 `@media (max-width: 860px) { .rp-nav { display: none; } }` 때문에 모바일 사용자는 페이지 끝까지 내려야 지원 링크를 찾음. 심사자 다수가 모바일로 확인함 — 좁은 화면에서도 헤더 오른쪽에 「고객 지원」 하나만 남기는 규칙을 「공통」에 더한다 (시각 변경 커밋으로 분리).
3. **`#report`의 「위 지원 이메일」이 앵커 직행 시 모호** (WARNING) — D-13대로 앱이 `/support/#report`로 바로 열면 문의 구간의 주소가 화면 위로 밀려 안 보임 (`support/index.html:20`) — `#report` 첫 문단에 `mailto:` 링크를 한 번 더 넣는다 (`site.data.company.support_email` 참조, 내용 변경 커밋).

---

## Detailed Findings

### Pillar 1: Copywriting (3/4)
- PASS: 푸터 라벨 「상호」「대표자」「사업자등록번호」「주소」「이메일」이 D-07 그대로. 운영 안내·저작권 문장 불변(D-09).
- PASS: 「영업일 기준 3일 안에 답장합니다」(D-14), 신고 항목 4개는 앱 화면에 보이는 정보만(D-15). 처리 약속·「앱 안 신고 없음」 문구 없음.
- WARNING: FAQ 삭제 경로와 링크 대상 본문 불일치(Fix 1).
- WARNING: 「위 지원 이메일」(`support/index.html:20`)·FAQ 마지막 답 「지원 이메일로 알려 주세요」(`:48`)가 주소를 링크 없이 말로만 가리킴(Fix 3).
- 참고: FAQ 운영 주체 답 `{{ trade_name }}입니다`(`:31`)는 「값 바로 뒤에 조사를 붙이지 않는다」 규칙과 긴장. 서술격 조사 「입니다」는 받침과 무관해 실제 문제는 없지만, 규칙 문구와 어긋나므로 CONVENTIONS에 예외로 적거나 「운영 주체: 값」 형태로 바꾼다.

### Pillar 2: Visuals (3/4)
- PASS: eyebrow → h1 → 최종 업데이트 → 세 구간 h2로 초점이 분명. 이메일이 단독 문단·굵은 밑줄 링크(`.rp-doc a`, 600·accent 2px)라 문의 구간의 주인공이 됨.
- WARNING: FAQ는 쌍마다 `<dl>` 하나(D-16 보충)라 쌍 사이 12px = 구간 안 다른 문단 간격. `dt`(700·ink)만으로 질문이 구분되고 시각적 묶음 경계는 약함 — `.rp-doc dl + dl { margin-top: 20px; }` 정도로 쌍 간격만 키우는 것을 검토 (법적 3종에는 아직 `dl` 연속이 없으면 영향 없음, 확인 후).
- 참고: 지원 페이지가 법적 카드·모눈종이 틀을 그대로 써서 「법적 문서」처럼 보임. 의도(D-12)이며 수용 가능.

### Pillar 3: Color (3/4)
- PASS: 새 hex 0개. 푸터 보조 글자 `#B5B0A7`·구분선 `#4A4844`는 기존 값. 이메일 링크 `#FAFAF7`+밑줄로 주변 회색 글자와 색·모양 두 가지로 구분(색만 의존 아님).
- WARNING: `.rp-foot-legal a`(`common.css:31`)에 hover 규칙이 없음. 같은 푸터의 `.rp-foot-nav a:hover`는 밑줄로 반응하는데 이 링크는 이미 밑줄이라 상태 변화가 전혀 없음 — hover 때 `text-decoration-thickness: 2px` 등으로 변화를 준다.
- 참고: 랜딩은 hex를 바로 쓰는 방침이라 하드코딩 자체는 규칙 위반이 아님.

### Pillar 4: Typography (3/4)
- 변경 범위 크기: 푸터 13px(1.6), 지원 본문 기존 체계(h2 20/700, dt 700, 본문 1.7). 새 크기·굵기 없음.
- WARNING: eyebrow 「SUPPORT」(front matter `eyebrow`)는 한국어 전용 사이트(`lang="ko"`)에서 영어 대문자. 다른 법적 페이지 eyebrow와 같은 방식이면 일관성은 있으나, 화면 낭독기가 영어 철자로 읽음 — Phase 9 영문판 때 정리하거나 `lang="en"` 표시를 검토.
- 참고: 푸터 사업자 줄의 긴 사업자등록번호는 `inline-block` 덕에 중간에서 끊기지 않음(D-07).

### Pillar 5: Spacing (3/4)
- PASS: 구분 기호 `&nbsp;· `(`footer.html:23-24,30`)가 점을 앞 항목에 붙여 줄 머리에 `·`가 매달리지 않음(D-08). 값이 빠져도 기호가 남지 않는 조건식 확인.
- WARNING: `.rp-foot-legal`은 이제 최대 6줄인데 `gap: 6px`(`common.css:29`)이 하나뿐이라 운영 안내·사업자 정보·연락처·저작권이 한 덩어리로 보임 — 연락처 행 뒤(저작권 앞)에만 간격을 조금 더 주는 방안 검토.
- WARNING: 주소 줄(`footer.html:27`)만 `<span>` 없이 `<p>`에 바로 값이 들어가 다른 줄과 구조가 다름. 긴 주소는 낱말 단위(`keep-all`)로 접히므로 표시 문제는 작지만 「주소」 라벨이 줄 끝에 홀로 남을 수 있음 — 라벨과 값 앞부분을 `&nbsp;`로 붙인다.

### Pillar 6: Experience Design (3/4)
- PASS: render-if-present가 푸터 행(`.size > 0`), 지원 페이지 `#contact`·`#report` 구간, FAQ 쌍 단위로 일관. 이메일이 없으면 신고 FAQ 쌍도 함께 빠져 깨진 `#report` 링크가 생기지 않음.
- PASS: 앵커 `id`가 `section`에 있어(D-13) 앱 직행 시 h2부터 보임. 페이지에 스크립트 없음.
- WARNING: 모바일 헤더에 「고객 지원」 없음(Fix 2).
- WARNING: 푸터 이메일 링크는 13px 인라인 텍스트라 터치 대상이 44px에 한참 못 미침. 프로젝트 기본값(「클릭 대상 `min-height: 44px`」)과 어긋남 — `.rp-foot-legal a`에 `display: inline-block; padding-block` 등으로 대상을 키우거나, 지원 페이지 이메일을 주 경로로 두고 푸터는 보조로 수용한다.
- 참고: 헤더·푸터의 「고객 지원」 링크에 현재 페이지 표시(`aria-current="page"`)가 없음. 공유 include라 페이지 정보를 매개변수로 넘겨야 해서 비용 대비 낮은 우선순위.

---

## Files Audited
- `_includes/footer.html`
- `_includes/header.html`
- `_includes/css/common.css`
- `_includes/css/legal.css`
- `_layouts/legal.html`
- `support/index.html`
- `.planning/phases/05-business-info-support-contact/05-CONTEXT.md`
