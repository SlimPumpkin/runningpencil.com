# Phase 06 — UI Review

**Audited:** 2026-11-27
**Baseline:** abstract 6-pillar standards + 프로젝트 「법적 본문 작성 규칙」 D-01~D-12 (UI-SPEC.md 없음)
**Screenshots:** not captured (라이브 URL은 응답했으나 Playwright 브라우저가 설치되어 있지 않아 캡처 실패 — 코드 전용 감사)
**Interaction captures:** off (workflow.ui_interaction_capture is false)

대상: `data-deletion/index.html` (`_layouts/legal.html` + `_includes/css/legal.css`로 렌더링), `_data/company.yml`의 `store_developer_name` 슬롯.

---

## Pillar Scores

| Pillar | Score | Key Finding |
|--------|-------|-------------|
| 1. Copywriting | 3/4 | 구체적이고 정직한 문장이지만, 제공자 섹션 여섯이 거의 같은 문단 세 개를 되풀이하고 「2~4번」 같은 번호 참조가 조건부 목록에 묶여 있다 |
| 2. Visuals | 2/4 | 목차·바로가기 없이 긴 한 장 문서. 섹션 15개가 모두 같은 무게라 핵심(요청 방법)이 시각적으로 두드러지지 않는다 |
| 3. Color | 4/4 | 토큰 5개만 `var(--rp-…)`로 사용, 본문에 hex·클래스·`style` 없음 |
| 4. Typography | 3/4 | h2 20 / h3 17 / 본문 / 표 14 / aside 14 위계는 규칙대로. 다만 h3 「①」「②」 블록 사이 간격이 본문 문단 간격(12px)과 같아 묶음 구분이 약하다 |
| 5. Spacing | 3/4 | D-02 간격 체계 준수. h3 앞 추가 여백 없음, 앵커 이동 시 `scroll-margin` 없음 |
| 6. Experience Design | 2/4 | 앵커 8개 고정·조건부 렌더링은 견고하나, 「첫 화면에서 지원 이메일 경로」 성공 기준이 레이아웃상 보장되지 않고(①앱 경로 뒤에 ②), 모바일에서 앵커 내비게이션 수단이 없다 |

**Overall: 17/24**

---

## Top 3 Priority Fixes

1. **(WARNING) 지원 이메일 경로가 첫 화면에 있다는 보장이 없음** — 앱이 없는 사용자(Google Play 웹 삭제 심사의 핵심 대상)는 제목 → 소개 문단 → h2 → h3 ① → 앱 경로 문단 2개를 지나야 ②에 도달한다. 375px 폭 카드(안쪽 28px)에서는 ② 제목이 첫 812px 화면 밖일 가능성이 크다(캡처 미확인, 코드상 추정) — 소개 문단 바로 뒤 또는 `#request` 첫 문단에 「앱 없이도 지원 이메일(값)로 요청할 수 있습니다」 한 줄과 `mailto:` 링크를 두거나, ①·② 순서를 바꾼다. 라이브에서 375×812 캡처로 확인 필요.
2. **(WARNING) 목차 없는 긴 문서** — `#location`, `#facebook` 같은 앵커는 콘솔이 직접 여는 용도로만 쓸 수 있고, 일반 사용자는 15개 섹션을 끝까지 스크롤해야 자기 제공자 섹션을 찾는다 — 소개 문단 뒤에 허용 요소(`ul`/`li`/`a`)만으로 짧은 바로가기 목록(요청 방법·남는 데이터·위치정보·제공자 6개)을 둔다. 새 요소·클래스가 필요 없어 D-04 안에서 가능하다.
3. **(WARNING) 제공자 섹션 6개의 반복 문단과 링크 불일치** — 각 섹션 2·3번째 문단이 제공자 이름만 바뀐 같은 문장이고, `#kakao`·`#naver`만 외부 안내 링크가 없어 다른 넷과 행동 경로가 다르다 — 공통 문장(「계정과 데이터 삭제는 …」)을 각 섹션 한 줄 링크로 줄이고, 카카오·네이버도 공식 연결 해제 안내 URL이 확인되면 같은 모양의 링크로 맞춘다(확인 안 되면 현재 문구 유지).

---

## Detailed Findings

### Pillar 1: Copywriting (3/4)
- 강점: 메뉴 경로를 실제 화면 낱말로 적음(`설정 → 내 계정 → 회원탈퇴`, 「뱃지와 기록 모두 삭제」), 남는 데이터마다 이유·기간 명시, 「추후 기재」 같은 자리표시 없음, 생략된 값은 render-if-present.
- WARNING: `#location` 끝 문단 「위치정보 동의를 철회하면(2~4번)」은 `ol` 3번 항목이 `support_email` 조건부(`{%- if site.data.company.support_email.size > 0 %}`)라, 값이 비면 항목이 3개로 줄어 「2~4번」이 존재하지 않는 번호를 가리킨다. 지금 값이 있어 라이브는 맞지만 문장이 데이터에 묶여 있다.
- WARNING: `#request` ① 둘째 문단 「회원탈퇴는 다시 로그인한 뒤 5분 안에 진행해야 합니다」 — 왜 다시 로그인해야 하는지 설명이 없어 사용자가 오류로 오해할 수 있다.
- 사소: `aside` 「※ 둘러보기에서는 …」 — 「둘러보기」가 문서 다른 곳에 정의되지 않은 앱 용어.
- 사소: 표 1열 「요청 횟수 제한 기록 가운데 IP·이메일의 해시로 만든 것」은 데이터 이름으로는 길어 열 폭을 차지한다.
- 제공자 섹션 6개 × 같은 2문단 반복(위 Fix 3).

### Pillar 2: Visuals (2/4)
- 섹션 구성: 소개 `p` 1 + `section` 15개(요청·기간·지워짐·남음·일부·위치·제공자 6·문의처). 모든 `h2`가 같은 20px/700이라 「삭제 요청 방법」이 가장 중요한 조항임을 보여 주는 시각 신호가 없다.
- 목차·바로가기 없음(Fix 2). 랜딩 헤더 메뉴는 이 문서의 구간으로 가는 수단이 아니다.
- 표 1개는 D-07대로 `<figure tabindex="0" aria-label="탈퇴 뒤 남는 데이터">`로 감쌌고 스크롤 그림자(D-08)를 받는다 — 규칙 준수.
- 메일 주소가 문단 하나(`<p><a href="mailto:…">`)로 따로 서 있어 ② 안에서는 시선이 잘 간다. 이 장점을 문서 머리로 끌어올리는 것이 Fix 1.

### Pillar 3: Color (4/4)
- 본문에 클래스·인라인 `style`·hex 0건. 색은 `legal.css`의 `--rp-ink`/`--rp-accent`/`--rp-muted`/`--rp-muted-2`/`--rp-line`만 사용.
- 링크는 ink 글자 + accent 2px 밑줄(D-05). 노랑 `#F2B134`를 밝은 바탕 글자에 쓰지 않음.
- 이번 단계는 CSS를 바꾸지 않았으므로 색 분포 회귀 없음.

### Pillar 4: Typography (3/4)
- 사용 크기: 제목 clamp(30–42px)/900, h2 20/700, h3 17/700, 본문(상속, line-height 1.7), 표 14, aside 14, updated 13. 법적 레이아웃 전체 규칙 그대로이고 새 크기 없음.
- WARNING: `h3` 「① 앱에서 요청하기」「② 앱 없이 지원 이메일로 요청하기」 앞 간격이 `section > * + *` 12px로 일반 문단 사이와 같다. ② 블록이 ① 끝 문단에 붙어 보여 두 경로가 대등한 선택지라는 구조가 약하다(D-11은 크기만 정하고 간격은 정하지 않음).
- `strong`은 메뉴 경로 1곳에만 써 과용 없음.

### Pillar 5: Spacing (3/4)
- 최상위 자식 사이 32px, section 안 12px, `li` 사이 4px(D-02) — 본문에 간격 클래스·`style` 없음.
- WARNING: h3 앞 추가 여백 없음(Pillar 4와 같은 원인). `legal.css`에 `.rp-doc section > h3:not(:first-child)` 같은 규칙을 더하면 해결되지만 법적 레이아웃 네 페이지 출력이 바뀌므로 별도 시각 변경 단계로 분리해야 한다.
- 사소: 앵커(`#request`, `#facebook` 등)로 열면 `section`이 화면 맨 위에 딱 붙는다. 헤더가 sticky가 아니라 가려지지는 않지만 `scroll-margin-top`이 없어 숨 쉴 틈이 없다.

### Pillar 6: Experience Design (2/4)
- 강점: 앵커 8개(`#request`·`#location`·제공자 6개)가 `section`에 고정, 내부 링크 `<a href="#request">` 7곳, 값이 없으면 문단·항목째 숨김(`.size > 0`), 문의처 섹션은 네 값 중 하나라도 있을 때만 렌더링, 표 키보드 스크롤(`tabindex="0"`).
- WARNING: 성공 기준 「앱이 없는 사용자도 문서 첫 화면에서 지원 이메일 경로를 찾는다」가 코드 구조상 보장되지 않음(Fix 1). 캡처 없이 판정할 수 없어 BLOCKER로 올리지 않았지만, 심사 핵심 요구라 우선 확인 대상.
- WARNING: `support_email` 값이 비면 ② 블록·처리 기간 문단·위치정보 3번 항목이 함께 사라지고 제공자 섹션의 「지원 이메일로 요청할 수 있습니다」 문장은 남는다(제공자 섹션 문단은 조건부가 아님). 값이 없는 상태에서는 존재하지 않는 경로를 안내하게 된다. 지금은 값이 있어 라이브 영향 없음.
- 사소: 외부 링크(Google·Apple·Facebook·LINE 안내)가 같은 탭에서 열려 문서를 떠나게 된다 — 법적 문서 관례상 허용 범위.
- 레지스트리 감사: `components.json` 없음 — 해당 없음.

---

## Files Audited
- `data-deletion/index.html`
- `_layouts/legal.html` (구조 참조)
- `_includes/css/legal.css`
- `_includes/css/common.css` (헤더 sticky 여부)
- `_data/company.yml` (키 이름만 참조, 값은 적지 않음)
- `.planning/phases/06-data-deletion-rewrite/06-CONTEXT.md`, `06-*-SUMMARY.md`
