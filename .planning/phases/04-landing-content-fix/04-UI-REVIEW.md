# Phase 4 — UI Review

**Audited:** 2026-11-18
**Baseline:** 추상 6-pillar 기준 (이 단계에는 UI-SPEC.md 없음). 잠긴 결정은 `04-CONTEXT.md` D-01~D-07
**Screenshots:** not captured — 로컬 dev 서버 없음, 라이브(`https://runningpencil.com/#screens`) 캡처는 Playwright 브라우저 바이너리가 설치되어 있지 않아 실패. 코드 기반 감사
**Interaction captures:** off (workflow.ui_interaction_capture is false)

감사 대상은 Phase 4가 바꾼 부분만입니다: 메타·OG 설명(`index.html:12-18`), 「세 가지 이유」 3단계 글·캡션·뱃지 색(`index.html:242-256`, `.rp-stickers`), 새 「실제 앱 화면」 구간(`index.html:93-100`, `:115-116`, `:410-432`)과 `#get` 맞물림(`:102`).

---

## Pillar Scores

| Pillar | Score | Key Finding |
|--------|-------|-------------|
| 1. Copywriting | 3/4 | D-02·D-04·D-05 문구가 그대로 반영됨. 다만 「출시 준비 중」이 한 페이지에 4번 반복 |
| 2. Visuals | 3/4 | 폰 테두리·딱지로 위계는 분명하나, 「출시 준비 중」 딱지 인라인 스타일이 히어로와 복제됨 |
| 3. Color | 3/4 | 빈 뱃지 회색 제거, 새 hex 없음(D-06). 단 폰 테두리 `#1F1B13`은 문서화된 팔레트 밖 색 |
| 4. Typography | 3/4 | 기존 크기 체계 재사용. 캡션(16px/700)과 같은 구간 출처 표기(14px/500)·3단계 캡션(14px/600) 사이 규칙이 제각각 |
| 5. Spacing | 3/4 | `clamp()` 유동 여백·`.rp-wrap` 정렬 일관. 좁은 화면에서 띠 아래 64px 패딩 때문에 지도 출처가 캡처에서 멀리 떨어짐 |
| 6. Experience Design | 3/4 | `scroll-snap` 띠에 `tabindex`·`role`·`aria-label`·`alt` 충실. 좁은 화면에서 넘길 수 있다는 단서가 잘린 다음 카드뿐 |

**Overall: 18/24**

---

## Top 3 Priority Fixes

1. **좁은 화면에서 지도 출처가 캡처와 떨어져 보임** (WARNING) — 860px 이하에서 `.rp-shots`의 `padding-bottom: 64px` 뒤, 구간 `gap`까지 더해진 위치에 `지도 © NAVER Corp.`가 오른쪽 정렬로 놓여 어느 그림의 출처인지 약해짐 — 그림자용 여백을 줄이거나(예: 40px) 좁은 화면에서 `.rp-shots-credit`에 음수 위 margin을 주어 띠 바로 아래로 붙인다.
2. **「출시 준비 중」 4회 반복** (WARNING) — 히어로 딱지(`:173`), 앱 화면 딱지(`:415`), `#get` 알약(`:439`), `#get` 카드(`:454`)에 같은 말이 연속해 심사자에게 "미완성" 인상을 강화함(Core Value와 충돌 가능) — 앱 화면 딱지는 구간 성격을 말하는 「출시 전 화면」처럼 다른 문구로 바꾸거나, 히어로·`#get` 중 하나를 줄인다 (문구 변경은 별도 커밋).
3. **딱지 인라인 스타일 복제** (WARNING) — `:173`과 `:415`의 `<span style="...rotate(-3deg)">`가 글자 하나 다르지 않게 복사되어 한쪽만 고치면 어긋남 — 「랜딩 전용」에 `.rp-tag` 같은 클래스 하나로 옮긴다 (리팩터 커밋으로 분리).

---

## Detailed Findings

### Pillar 1: Copywriting (3/4)
- PASS: 메타 설명(`:13`)과 OG 설명(`:17-18`)에서 포인트·굿즈·코스북만 빠짐 (D-02). 3단계 본문(`:245`)과 캡션 「보관함 · 받은 뱃지 7」(`:256`)이 D-04·D-05 글자 그대로.
- PASS: 캡션 「코스 그리기」「따라 달리기」「완주하고 뱃지 받기」(`:420,424,428`)는 「세 가지 이유」 1~3단계 용어와 맞물림. `alt`는 화면에 보이는 수치만 서술(규칙 준수).
- WARNING: 「출시 준비 중」 4회 반복(위 Fix 2).
- 참고: `:396` 「보관함에 차곡차곡 쌓여요」와 `:245` 「보관함에 모여요」가 같은 뜻을 두 번 말함. 치명적이지 않음.

### Pillar 2: Visuals (3/4)
- PASS: 제목(최대 60px/800) + 회전 딱지 → 폰 세 장 → 캡션 순서로 초점이 분명. 장식 SVG는 `aria-hidden`, 뱃지 줄 의미는 캡션 텍스트가 전달.
- PASS: 뱃지 줄 7개(`:248-254`)가 모두 컬러가 되어 "못 받은 뱃지" 오해 요소 제거 (D-06). 줄 길이·배치 유지.
- WARNING: 딱지 스타일 복제(Fix 3).
- WARNING: 폰 테두리 `.rp-shot-frame`(radius 46px, padding 9px)은 「세 가지 이유」 `.rp-phone`과 별도 모양이라 같은 페이지에 폰 목업 두 종이 있음. CONVENTIONS에 의도로 기록되어 있으나 시각적으로 테두리 두께·모서리가 다르면 일관성이 떨어짐 — 스크린샷 없이 확인 불가, 육안 대조 권장.

### Pillar 3: Color (3/4)
- PASS: `.rp-badge.t-empty` 규칙 삭제, 대체 색은 기존 다섯 토큰(`t-yellow`·`t-red`·`t-kraft`·`t-graph`·`t-graphite`) 안에서만 선택.
- PASS: 구간 바탕 `#FAFAF7`, 글자 `#2B2B2B`, 출처 `#57534C` — 모두 문서화된 값. 노랑을 글자에 쓰지 않음.
- WARNING: `.rp-shot-frame` 바탕 `#1F1B13`과 그림자 `rgba(31, 27, 19, .28)`(`:97`)은 CLAUDE.md 색 표에 없는 흑연 변형. 기존 히어로 등에서 쓰던 값이라면 색 표에 올리고, 아니면 `#2B2B2B`로 맞춘다.
- 참고: 뱃지 줄 7개에 5색이라 노랑·빨강이 두 번씩 나옴. 3단계 줄에서 빨강(하트·왕관)이 양 끝 쪽에 몰리지 않는지 육안 확인 권장.

### Pillar 4: Typography (3/4)
- 사용 크기(변경 범위): 60px 계열 제목 clamp, 13~15px 딱지, 16px 캡션, 14px 출처·3단계 캡션. 굵기: 800(제목·딱지), 700(캡션), 600(3단계 캡션), 500(출처).
- WARNING: 한 구간 안에서 굵기 4종(800/700/600/500). 출처 500과 3단계 캡션 600은 같은 "보조 14px" 역할인데 굵기가 다름 — 보조 글자는 600 하나로 통일 권장.
- PASS: 새 글꼴·새 크기 단위 없음, 제목은 기존 `h2` 인라인 값과 동일.

### Pillar 5: Spacing (3/4)
- PASS: 구간 세로 여백 `clamp(56px, 7vw, 104px)`, 띠 gap `clamp(20px, 3vw, 40px)`, 좁은 화면 음수 margin이 `.rp-wrap` 여백 식과 같아 가장자리 정렬 일치.
- PASS: `#get` 음수 margin-top과 `#screens` 둥근 모서리가 같은 `clamp(28px, 4vw, 56px)`를 공유해 맞물림이 어긋나지 않음 (`:93`, `:102`).
- WARNING: 좁은 화면 `padding-bottom: 64px`(그림자 공간)로 출처 표기가 멀어짐(Fix 1).
- 참고: 캡션 gap 14px은 4/8 배수 체계 밖 값. 경미.

### Pillar 6: Experience Design (3/4)
- PASS: `role="list"` + `tabindex="0"` + `aria-label`, `:focus-visible` outline-offset -3px로 띠 안쪽에 포커스 링(`:95`). `loading="lazy"`·`decoding="async"`, `width`/`height`로 CLS 방지, `sizes`가 실제 렌더 폭(282px·242px)과 일치.
- PASS: 스크립트 없이 동작하므로 기존 JS 계약(id·data 속성)을 건드리지 않음.
- WARNING: 860px 이하에서 넘길 수 있다는 단서는 `min(72vw, 260px)` 카드가 잘려 보이는 것뿐. 375px에서 카드 260px + 여백이면 두 번째 카드가 약 60px만 보임 — 데스크톱 트랙패드·마우스 사용자(좁은 창)에게는 가로 스크롤이 발견되기 어려움. 점 표시나 카드 폭을 64vw 정도로 줄여 다음 카드를 더 보이게 하는 것을 고려.
- 참고: 캡처 확대 보기 없음. 티저 범위에서 필수는 아님.
- Registry audit: shadcn 미사용, 해당 없음.

---

## Files Audited
- `index.html` (12-18, 93-102, 104-120, 173, 236-262, 396, 410-456행)
- `.planning/phases/04-landing-content-fix/04-CONTEXT.md`
- `.planning/phases/04-landing-content-fix/04-03-SUMMARY.md`, `04-04-SUMMARY.md`, `04-10-SUMMARY.md` (및 나머지 계획·요약 목록)
