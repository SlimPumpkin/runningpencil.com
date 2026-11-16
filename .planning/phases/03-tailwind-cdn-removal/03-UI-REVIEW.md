# Phase 03 — UI Review

**Audited:** 2026-11-16
**Baseline:** abstract 6-pillar standards (UI-SPEC.md 없음) + CLAUDE.md 디자인 규칙 + 03-CONTEXT.md 결정
**Screenshots:** not captured (코드 감사만 함. 전환 전 기준과의 픽셀 동일성은 03-EVIDENCE.md에서 이미 증명됨)
**Interaction captures:** off (workflow.ui_interaction_capture is false)

범위: 법적 페이지 3종(`/privacy-policy/`, `/terms/`, `/data-deletion/`)의 현재 시각 품질. 법적 본문 내용(포인트·굿즈 문구, 「임시 게시본」, `noindex`)은 Phase 6~8 몫이라 채점하지 않았다. 이 단계 목표가 "전환 전과 똑같이 보이기"였으므로 아래 지적은 대부분 **전환 전부터 있던 모양**이며 회귀(regression)는 찾지 못했다.

---

## Pillar Scores

| Pillar | Score | Key Finding |
|--------|-------|-------------|
| 1. Copywriting | 3/4 | 셸 문구(eyebrow·제목·「최종 업데이트」)는 구체적. eyebrow만 영어 대문자(`DATA DELETION`)라 한국어 문서에서 어색함 |
| 2. Visuals | 3/4 | 카드·eyebrow·900 제목으로 초점 분명. 860px 이하에서 헤더 메뉴가 사라지고 대체 탐색이 없음 |
| 3. Color | 4/4 | 토큰 5개만 `var()`로 사용, 노랑 글자 없음, 보조 글자 대비 충분 |
| 4. Typography | 3/4 | 크기 6단계(42/20/17/16/14/13), 굵기 3단계(900/700/600) — 문서용으로 허용 범위지만 13px·14px 두 보조 크기가 겹침 |
| 5. Spacing | 3/4 | 32/12/4px 리듬은 일관. 375px에서 바깥 24px + 카드 28px로 본문 폭이 약 268px까지 좁아짐 |
| 6. Experience Design | 3/4 | 포커스 링·표 스크롤 감싸개 규칙 있음. 긴 문서에 목차·조항 앵커 없음, 링크 transition에 reduced-motion 처리 없음 |

**Overall: 19/24**

---

## Top 3 Priority Fixes

1. **WARNING — 좁은 화면의 본문 폭 손실** — 375px에서 `.rp-legal-wrap` 좌우 24px + `.rp-legal-card` 28px + 테두리 1.5px로 본문이 화면의 약 71%만 씀. 긴 처방침 조항이 한 줄 13~15자로 끊겨 읽기 피로가 큼 — 768px 미만에서 `.rp-legal-wrap` 좌우를 16px, 카드 안쪽을 20~24px로 줄이는 안을 별도 시각 변경 단계에서 검토(이번 단계는 동일성 유지가 목표였으므로 회귀 아님).
2. **WARNING — 860px 이하에서 헤더 탐색이 사라짐** — `common.css`의 `@media (max-width: 860px) { .rp-nav { display: none; } }` 때문에 모바일 법적 페이지에는 로고 링크와 푸터 링크만 남음. 심사자가 다른 법적 문서로 이동하려면 맨 아래까지 스크롤해야 함 — 법적 레이아웃에 다른 문서 2개로 가는 짧은 링크 줄을 두거나, 푸터 링크로 충분하다고 결정해 기록.
3. **WARNING — 긴 문서에 조항 앵커·목차 없음** — 처리방침·약관은 조항이 많은데 `h2`에 `id`가 없어 심사 회신에서 "제N조" 위치를 링크로 줄 수 없음 — Phase 7·8 재작성 때 `section`/`h2`에 안정적인 `id`를 두는 규칙을 법적 본문 작성 규칙에 더하는 것을 권장(D-01 kramdown 자동 id 금지와 충돌하지 않게 손으로 단 id).

추가 권장(Minor):
4. eyebrow `DATA DELETION` 등 영어 대문자 라벨은 한국어판에서 의미 전달이 약함. Phase 9 영문판 도입 때 언어별 eyebrow를 정할 것.
5. `.rp-doc a`의 150ms transition은 `prefers-reduced-motion`에서 끄지 않음(영향은 작음, 랜딩은 reduced-motion 처리를 함).
6. 인쇄 스타일 없음. `html` 바탕 노랑·모눈종이가 인쇄에서는 빠지지만 헤더·푸터는 그대로 인쇄됨. 심사자가 PDF로 저장하는 경우를 위해 `@media print`에서 `.rp-head`/`.rp-foot` 숨김 검토.
7. 13px(`.rp-legal-updated`)과 14px(`aside`·`footer`·표·eyebrow) 보조 크기가 둘이라 위계가 흐림. 하나로 합치는 것을 다음 시각 단계에서 검토.

---

## Detailed Findings

### Pillar 1: Copywriting (3/4)
- 셸 문구: `_layouts/legal.html`의 `최종 업데이트: {{ page.updated }}`는 구체적이고 `updated`가 없으면 숨김(render-if-present) — 좋음.
- eyebrow가 영어 대문자(`data-deletion/index.html` front matter `eyebrow: "DATA DELETION"`). 한국어 페이지에서 장식 이상의 의미가 없음 — Minor.
- 제목 `<title>{{ page.title }} - 러닝펜슬</title>` 형식 일관. 일반 라벨(Submit/OK 등) 없음.
- 본문 내용은 범위 밖(Phase 6~8).

### Pillar 2: Visuals (3/4)
- 흰 카드(`border-radius: 28px`, `1.5px` 테두리) + 모눈종이 바탕 + eyebrow(accent) + 900 제목으로 초점이 분명.
- 아이콘만 있는 버튼 없음. 헤더·푸터 로고는 브랜드 텍스트와 함께 있음.
- `.rp-legal-eyebrow`가 `<span>`(인라인)이고 바로 뒤 `h1`의 `margin-top: 14px`로 간격을 냄 — 동작은 하지만 eyebrow 줄 높이에 의존. 문제는 아님.
- 860px 이하 헤더 메뉴 숨김(`_includes/css/common.css` 마지막 줄) — Top 2.

### Pillar 3: Color (4/4)
- `legal.css`의 색은 `:root` 토큰 5개를 `var()`로만 씀. 하드코딩 hex는 문서화된 예외(`#fff` 카드, `#F5F9FC`/`#D3E2EF` 모눈종이, 그림자 `rgb(43 43 43 / .16)` = ink 투명도)뿐.
- 노랑 `#F2B134`은 헤더 바탕·`html` 바탕에만, 글자색 사용 없음. 링크 밑줄·eyebrow는 `#7C580D`.
- 대비: `--rp-muted #4A463F`/흰 바탕 약 9:1, `--rp-muted-2 #57534C` 약 7.5:1, accent `#7C580D` 약 6.5:1 — 모두 AA 통과.
- 60/30/10: 모눈종이·흰 카드(바탕) / 흑연 글자 / 노랑 헤더·금색 강조 — 분배 적절.

### Pillar 4: Typography (3/4)
- 크기: 제목 `clamp(30px, 6.5vw, 42px)`, h2 20, h3 17, 본문 16(상속), 보조 14, 업데이트 13 → 6단계.
- 굵기: 900(제목), 700(eyebrow·h2·h3·th·dt), 600(strong·a) → 3단계. 법적 문서 성격상 허용.
- 본문 `line-height: 1.7`, `word-break: keep-all` — 한국어 장문 가독성에 좋음.
- 13px/14px 보조 크기 중복 — Minor 7.

### Pillar 5: Spacing (3/4)
- 블록 간격 32px → 섹션 내부 12px → `li` 4px, 표 칸 `10px 16px 10px 0` — 일관된 3단 리듬. 임의 값 없음.
- 카드 안쪽 28px → 768px 이상 48px. `.rp-legal-wrap` 위아래 `clamp(48px, 6vw, 80px)`.
- 375px에서 본문 폭 약 268px — Top 1.

### Pillar 6: Experience Design (3/4)
- 포커스: `:focus-visible { outline: 3px solid #1E5AA8 }` 공통 적용. 표 감싸개 규칙(`figure tabindex="0" aria-label`)과 CSS만의 스크롤 그림자가 준비되어 있음. 현재 세 문서에 `<figure>`는 0개라 실사용 검증은 Phase 7 몫.
- 법적 페이지에 스크립트가 없어 로딩·오류 상태 해당 없음.
- 링크 hover만 있고 visited 구분 없음(문서 내 링크가 적어 영향 작음).
- 목차·앵커 없음(Top 3), reduced-motion 미처리 transition(Minor 5), 인쇄 스타일 없음(Minor 6).

Registry audit: 해당 없음 (shadcn 미사용).

---

## Files Audited
- `_includes/css/legal.css`
- `_includes/css/common.css`
- `_layouts/legal.html`
- `privacy-policy/index.html`
- `terms/index.html`
- `data-deletion/index.html`
