# Phase 02 — UI Review

**Audited:** 2026-11-16
**Baseline:** abstract 6-pillar standards (UI-SPEC 없음) + CLAUDE.md 「Visual language」 제약
**Screenshots:** not captured (localhost 3000/5173/8080/4000에 dev server 없음 — code-only audit). 대신 UAT test 1의 픽셀 비교(기준 커밋 db505d7 대비 8쌍 중 7쌍 동일, 1쌍 렌더 노이즈 범위)를 회귀 판단 근거로 씀
**Interaction captures:** off (workflow.ui_interaction_capture is false)

> **범위 주의:** Phase 2는 출력 보존 리팩터(output-preserving refactor)입니다. 아래 모든 발견은 **이 단계의 회귀가 아니라 사이트에 원래 있던 성질**입니다. 점수는 현재 사이트의 상태를 매긴 것이고, 발견은 후속 단계(Phase 3 정적 CSS 전환, Phase 4 랜딩 문구, Phase 6·7·8 법적 문서) 백로그 입력으로 씁니다. 이번 마일스톤은 리디자인이 아니므로 시각 체계 변경 제안은 최소화했습니다.

---

## Pillar Scores

| Pillar | Score | Key Finding |
|--------|-------|-------------|
| 1. Copywriting | 2/4 | 출시 앱에 없는 포인트·굿즈·코스북 문구가 랜딩 meta와 법적 문서에 남음, 알림 채널 없는 「여기서 가장 먼저 알려 드릴게요」 약속 |
| 2. Visuals | 3/4 | 히어로 초점·SVG `aria-label` 양호. 860px 이하에서 헤더 nav가 대체 수단 없이 사라짐 |
| 3. Color | 3/4 | 브랜드 노랑/흑연 체계는 일관. 랜딩에 hex 60종 하드코딩, 일부는 토큰 표에 없음 |
| 4. Typography | 2/4 | 랜딩 고정 font-size 20종 이상 + weight 4종(500/600/700/800), 10.5px·11px 보조 글자 |
| 5. Spacing | 3/4 | `clamp()` 유동 수치·`.rp-wrap` 패딩 일관. 인라인 style에 산재한 값으로 스케일 부재 |
| 6. Experience Design | 3/4 | reduced-motion·focus-visible·44px 타깃·aria-pressed 양호. 핵심 id null 체크 없음, Tailwind CDN 실패 시 법적 페이지 붕괴 |

**Overall: 16/24**

---

## Top 3 Priority Fixes

1. **[WARNING] 출시 앱에 없는 기능 문구(포인트·굿즈·코스북)** — 심사자가 사이트와 앱 불일치로 반려할 수 있음 — `index.html:13`·`:18`(meta description·og:description), `privacy-policy/index.html:15-16`, `data-deletion/index.html:20,22,28`에서 제거 (U10, Phase 4·6·7 계획대로; meta 두 줄은 Phase 4 범위에 명시적으로 포함할 것)
2. **[WARNING] 법적 페이지가 Tailwind Play CDN 런타임에 의존** — CDN 지연·차단 시 카드·제목·목록 스타일이 통째로 사라져 심사 화면이 깨짐(`_layouts/legal.html` `<script src="https://cdn.tailwindcss.com">`) — Phase 3에서 정적 CSS로 교체, 그때 `text-xl` 20회·`font-bold` 21회 등 사용 클래스를 그대로 고정 값으로 옮김
3. **[WARNING] 「여기서 가장 먼저 알려 드릴게요」(`index.html:405`)가 알림 수단 없이 약속함** — 이메일 폼이 의도적으로 없으므로 방문자가 할 행동이 없음 — Phase 4 문구 재작성 때 「출시되면 이 페이지와 스토어에서 확인할 수 있어요」처럼 실제 채널과 맞추거나, Phase 5 지원 이메일 공개 후 연결

추가 WARNING (백로그):
4. 860px 이하에서 `.rp-nav { display: none; }`(`_includes/css/common.css` 끝 줄) — 모바일 헤더에 메뉴 대체가 없음. 법적 페이지에서 랜딩 구간(`/#story` 등)으로 가는 길이 로고 하나뿐. 리디자인 범위 밖이면 최소한 푸터에 홈 링크 또는 구간 링크 추가 검토
5. 보조 글자 10.5px/11px/11.5px(`index.html:276,297,322-324,340-343`) — 폰 목업 안 장식적 UI라 허용 범위이나, 확대 없이 읽기 어려움. 실제 정보가 아니라는 점을 유지(`role="img"` 그룹 안)하면 충분
6. 랜딩 스크립트가 `story`·`rp-run-*`·`rp-demo-*` id에 null 체크 없이 의존 — 하나라도 빠지면 스크롤 단계·데모 전체가 멈춤. Phase 4 랜딩 마크업 수정 때 회귀 위험이 큼 → Phase 4 체크리스트에 id 계약 확인 추가

---

## Detailed Findings

### Pillar 1: Copywriting (2/4)
- BLOCKER급은 아니지만 심사 직결: 포인트·굿즈·코스북 문구 — `index.html:13,18`, `privacy-policy/index.html:15-16`, `data-deletion/index.html:20,22,28`. 기존 결정(U10)으로 Phase 4·6·7에서 제거 예정.
- 「임시 게시본」 문구 — `data-deletion/index.html:32` 등 3종. U14로 각 재작성 커밋에서 제거 예정.
- `index.html:405` 알림 약속에 대응 채널 없음 (위 Fix 3).
- 양호: CTA가 구체적(「달리기 시작」 `index.html:369`, 「출시 안내 보기」 `:386`), 일반 라벨(Submit/OK/Click here) 0건, 단계 버튼「1 그리기 / 2 달리기 / 3 뱃지」 명확.

### Pillar 2: Visuals (3/4)
- 히어로 노랑 블록 + 큰 제목(`clamp(40px, 6.3vw, 92px)`) + 「출시 준비 중」 회전 스탬프(`index.html:162`)로 초점 분명.
- 의미 있는 SVG에 `role="img"` + 한국어 `aria-label`(`index.html:171,265,373,410`), 장식 아이콘은 `aria-hidden`. 아이콘 전용 버튼 없음.
- 감점: 모바일 헤더 nav 숨김 후 대체 없음(Fix 4). 법적 페이지 헤더는 `/#story` 등 랜딩 링크를 쓰므로 모바일 법적 페이지 방문자는 로고 외 이동 수단이 푸터 약관 링크뿐.

### Pillar 3: Color (3/4)
- 주색 사용: `#2B2B2B` 43회, `#FFFFFF` 28, `#FAFAF7` 25, `#F2B134` 17 — 60(밝은 바탕)/30(흑연 글자·푸터)/10(노랑 블록) 분배가 의도대로 지켜짐. 노랑을 밝은 바탕 위 글자로 쓴 곳 없음, 링크 밑줄은 `#7C580D`(`index.html:386`). 단, 「출시 전에 먼저」 `#F2B134` 글자(`index.html:365`)는 어두운 `#2E4A3B` 위라 대비 문제 없음.
- 감점: 랜딩에 고유 hex 약 60종. 대부분 폰 목업·지도 그림 안(`#1A237E`, `#E53935`, `#2E7D32`, `#1E88E5` 등 앱 화면 재현)이지만 CLAUDE.md 토큰 표 밖의 값이 텍스트에도 쓰임(`#4E4539` 10회, `#33302B`, `#3A3A3A` 9회). Phase 3 정적 CSS 전환 때 랜딩까지 토큰화할지는 범위 결정 필요(이번 마일스톤에선 비권장).
- 법적 페이지는 토큰(`text-ink/accent/muted/muted-2`, `border-line`)만 사용 — 양호.

### Pillar 4: Typography (2/4)
- 랜딩 고정 크기: 10.5, 11, 11.5, 12, 13, 14, 15, 16, 17, 18, 19, 20, 26px + `clamp()` 8종 → 사실상 20단계 이상. weight 500/600/700/800 4종(800 14회, 700 10회).
- 공통 CSS: 13/15/16/22px, weight 600/800. 법적 페이지: `text-sm`, `text-xl`, `text-[13px]`, `text-[clamp(30px,6.5vw,42px)]`, `font-bold/semibold/black`.
- 폰 목업 내부의 작은 크기는 앱 화면 재현이라 일부 정당하지만, 마케팅 영역(`index.html:365,403,418` 등 14·15px)과 섞여 스케일이 없음. 리디자인 범위 밖이므로 점수만 반영하고, 향후 영문판(Phase 9)에서 줄바꿈·크기 재검토 권장.
- 양호: `word-break: keep-all`(공통 CSS), 큰 제목 음수 자간 일관.

### Pillar 5: Spacing (3/4)
- 공통: `.rp-wrap` 패딩 `clamp(20px, 5vw, 64px)`, 섹션 패딩 `clamp(...)`로 일관. 860px 단일 breakpoint 규칙 준수.
- 감점: 간격 값이 인라인 `style`에 흩어져(3/4/6/8/9/10/12/14/24/28px 등) 공유 스케일이 없음. 법적 페이지는 Tailwind 4px 스케일(`mt-3`, `mt-3.5`, `mt-10`, `space-y-8`, `p-7 md:p-12`) + arbitrary 값 — Phase 3 변환 시 이 값들을 그대로 옮겨야 픽셀 동일 유지.

### Pillar 6: Experience Design (3/4)
- 양호: `prefers-reduced-motion` CSS·JS 이중 대응, `:focus-visible` 3px `#1E5AA8`, 클릭 대상 `min-height: 44px`(`.rp-brand`, `.rp-foot-nav a`, `index.html:386`), 단계 버튼 `aria-pressed` 동기화, JS 없을 때 `--q*` 초기값으로 정지 장면 표시(`index.html:205`), 법적 페이지 바닥글 하단 고정(flex 1 0 auto).
- 감점: (a) 스크립트 id 계약에 null 체크 없음 — 부분 실패가 전체 중단으로 번짐(Fix 6). (b) 법적 페이지 스타일 전체가 외부 CDN 런타임 JIT 의존(Fix 2). (c) 폼·로딩·오류 상태는 해당 없음(정적 사이트, 의도적).
- 이번 단계 고유 리스크 점검: include 공백 규칙·Liquid 잔여는 `scripts/check-site.sh`가 막고, UAT 픽셀 비교로 회귀 없음 확인 — 리팩터 자체는 UX에 영향 없음.

---

## Files Audited
- `/Users/woody/dv/woody/runningpencil.com/index.html`
- `/Users/woody/dv/woody/runningpencil.com/_layouts/legal.html`
- `/Users/woody/dv/woody/runningpencil.com/_includes/css/common.css`
- `/Users/woody/dv/woody/runningpencil.com/_includes/header.html`
- `/Users/woody/dv/woody/runningpencil.com/_includes/footer.html`
- `/Users/woody/dv/woody/runningpencil.com/_includes/head-links.html`
- `/Users/woody/dv/woody/runningpencil.com/privacy-policy/index.html`
- `/Users/woody/dv/woody/runningpencil.com/terms/index.html`
- `/Users/woody/dv/woody/runningpencil.com/data-deletion/index.html`
- Phase 02 CONTEXT·SUMMARY 10종(범위 확인용)
