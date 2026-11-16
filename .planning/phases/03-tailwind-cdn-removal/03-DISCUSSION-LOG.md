# Phase 3: 법적 페이지 정적 스타일 전환 (Tailwind CDN Removal) - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md — this log preserves the alternatives considered.

**Date:** 2026-11-16
**Phase:** 03-법적 페이지 정적 스타일 전환 (Tailwind CDN Removal)
**Areas discussed:** 본문 작성 규칙, 새 요소의 모양, 「같은 모양」 기준, 배포 단위

설정 `workflow.research_before_questions: true`에 따라 항목마다 짧은 웹 검색 결과(2~3줄)를 먼저 보여 주고 질문했습니다.

---

## 본문 작성 규칙

| Option | Description | Selected |
|--------|-------------|----------|
| HTML 유지 (추천) | 지금처럼 index.html에 클래스 없는 h2·p·ul·table. 기계 변환이라 문장이 바뀔 위험 없음 | ✓ |
| Markdown으로 전환 | index.md + kramdown. 쓰기는 편하지만 smart_quotes·자동 id 설정 필요, 표 감싸기 어려움 | |

**User's choice:** HTML 유지

| Option | Description | Selected |
|--------|-------------|----------|
| `<section>` 유지 (추천) | 지금 구조에서 클래스만 지움. 간격은 section(32px)과 section 안(12px)에 걸음 | ✓ |
| 평평하게 나열 | section 없이 h2·p·ul 나열, 두 번째 h2부터 위 32px | |

**User's choice:** `<section>` 유지

| Option | Description | Selected |
|--------|-------------|----------|
| 끝은 footer, 중간은 aside (추천) | 문서 끝 안내는 `<footer>`(구분선 + 작은 회색 글씨), 조항 안 보충 설명은 `<aside>`(선 없음) | ✓ |
| aside 하나로 통일 | 어디서든 `<aside>`, 지금 「임시 게시본」 모양 | |

**User's choice:** 끝은 footer, 중간은 aside

| Option (multiSelect) | Description | Selected |
|--------|-------------|----------|
| `<ol>` 번호 목록 | 약관의 호, 절차 단계 | ✓ |
| `<h3>` 하위 제목 | 처리방침 항목 아래 작은 묶음 | ✓ |
| 중첩 목록 | 목록 안의 목록 | ✓ |
| `<dl>` 정의 목록 | 약관 「정의」 조항 | ✓ |

**User's choice:** 네 가지 모두. 표(table)는 성공 기준 4에 이미 들어 있어 목록에서 뺌

---

## 새 요소의 모양

| Option | Description | Selected |
|--------|-------------|----------|
| 가로줄만 (추천) | 바깥 테두리·바탕 없이 가로줄(#E4E0D6), 머리 행 굵은 ink | ✓ |
| 전체 칸 테두리 | 모든 칸 선 + 머리 행 #FAFAF7 바탕 | |
| 머리 행 바탕 + 가로줄 | 세로선 없이 머리 행 바탕만 | |

**User's choice:** 가로줄만

| Option | Description | Selected |
|--------|-------------|----------|
| 표만 가로 스크롤 (추천) | 표를 감싼 상자 안에서만 가로 스크롤, 페이지는 밀리지 않음 | ✓ |
| 칸을 세로로 쌓기 | 860px 이하에서 카드형, 칸마다 data-label 필요 | |
| 폭에 맞춰 줄바꿈 | 칸 안 줄바꿈, 긴 단어·URL은 넘칠 수 있음 | |

**User's choice:** 표만 가로 스크롤

| Option | Description | Selected |
|--------|-------------|----------|
| 1. 2. 3. 숫자 (추천) | 브라우저 기본 decimal, ①은 본문 글에 직접 | ✓ |
| ①②③ 원문자 | CSS 번호 양식 정의 | |
| 번호는 글에 직접 | ol은 들여쓰기만 | |

**User's choice:** 1. 2. 3. 숫자

| Option | Description | Selected |
|--------|-------------|----------|
| 용어 아래에 뜻 (추천) | dt 굵게 한 줄, dd 아래 본문 글씨, 들여쓰기 없음 | ✓ |
| 용어 옆에 뜻 (2단) | 넓은 화면 2열, 좁은 화면 위아래 | |

**User's choice:** 용어 아래에 뜻

「더 이야기하기」를 골라 네 질문을 더 받음.

| Option | Description | Selected |
|--------|-------------|----------|
| 17px 굵게 진한 글씨 (추천) | h2와 같은 색·굵기, 크기만 줄임 | ✓ |
| 본문 크기 굵게 | 16px 굵게 | |
| 금색 작은 제목 | 15px 굵게 accent | |

**User's choice:** h3 = 17px 굵게 ink

| Option | Description | Selected |
|--------|-------------|----------|
| ○ 그리고 가. 나. (추천) | ul 안 ul ○, ol 안 ol 가. 나. 다., 영문판 a. b. c. | ✓ |
| ○ 그리고 a. b. | 한국어·영문 같은 기호 | |
| – 대시와 1) 2) | 별도 CSS 양식 필요 | |

**User's choice:** ○ 그리고 가. 나.

| Option | Description | Selected |
|--------|-------------|----------|
| 14px로 작게 (추천) | 표 안 글씨 14px | ✓ |
| 본문과 같은 16px | | |

**User's choice:** 14px

| Option | Description | Selected |
|--------|-------------|----------|
| 가장자리 그림자 (추천) | 넘칠 때만, CSS만, 끝까지 밀면 사라짐 | ✓ |
| 신호 없음 | 브라우저 기본 스크롤바만 | |

**User's choice:** 가장자리 그림자

---

## 「같은 모양」 기준

| Option | Description | Selected |
|--------|-------------|----------|
| 픽셀 차이 0 (추천) | 한 픽셀이라도 다르면 실패, computed style로 원인 추적 | ✓ |
| 작은 오차 허용 | 예: 0.1% 이하 통과 | |
| 사람이 눈으로 비교 | 자동 비교는 참고 | |

**User's choice:** 픽셀 차이 0

| Option | Description | Selected |
|--------|-------------|----------|
| Chromium + WebKit (추천) | 두 엔진 각각 픽셀 0 | ✓ |
| Chromium만 | Phase 2 UAT와 같음 | |
| Chromium + WebKit + Firefox | 세 엔진 | |

**User's choice:** Chromium + WebKit

| Option | Description | Selected |
|--------|-------------|----------|
| hover·focus도 비교 (추천) | 본문 링크 hover·focus 상태 캡처, transition은 computed style | ✓ |
| 기본 상태만 | | |

**User's choice:** hover·focus도 비교

| Option | Description | Selected |
|--------|-------------|----------|
| 캡처를 보고 사용자가 승인 (추천) | 시험용 본문(커밋 안 함) 3폭 × 2엔진 캡처를 푸시 승인 전에 보여 줌 + 자동 스타일 확인 | ✓ |
| 자동 확인만 | 계산된 스타일·가로 스크롤 없음만 확인 | |

**User's choice:** 캡처를 보고 사용자가 승인

---

## 배포 단위

| Option | Description | Selected |
|--------|-------------|----------|
| 사이트 1회 + 문서 1회 (추천) | 사이트 전환 커밋을 한 번에 푸시, 라이브 확인 뒤 문서 푸시 | ✓ |
| 한 번에 푸시 | 사이트·문서 한 푸시 | |
| 사이트 단계마다 푸시 | ①②③ 각각 푸시 + 문서, 승인 네 번 | |

**User's choice:** 사이트 1회 + 문서 1회

| Option | Description | Selected |
|--------|-------------|----------|
| 3단계, 단계마다 픽셀 0 (추천) | ① CSS 추가(Tailwind 유지) → ② 본문 클래스 제거 → ③ Tailwind 제거 | ✓ |
| 커밋 하나 | 한 커밋에 모두 | |

**User's choice:** 3단계, 단계마다 픽셀 0

| Option | Description | Selected |
|--------|-------------|----------|
| HTTP + 라이브 화면 비교 (추천) | curl(200·제목·cdn 없음) + 라이브 Chromium·WebKit 캡처 픽셀 0, 네트워크 요청 확인 | ✓ |
| HTTP 확인만 | 화면 비교는 로컬에서만 | |

**User's choice:** HTTP + 라이브 화면 비교

| Option | Description | Selected |
|--------|-------------|----------|
| CLAUDE.md + CSS 머리 주석 (추천) | 두 CLAUDE.md(원본 맵 재생성) + 법적 CSS 맨 위 요소 목록 주석 | ✓ |
| CLAUDE.md에만 | | |

**User's choice:** CLAUDE.md + CSS 머리 주석

---

## Claude's Discretion

- 법적 CSS 위치(`_includes/css/legal.css` include 권장 또는 레이아웃에 직접)
- 선택자·클래스·토큰 변수 이름과 정의 범위(단, `common.css`에 넣지 않아 랜딩 출력 불변)
- Preflight 대체 규칙의 범위, 캡처에 안 잡히는 Preflight 규칙(`-webkit-tap-highlight-color`) 이전 여부
- 표 칸 여백·줄 간격·머리 행 아래 선, aside 줄 간격, 중첩 목록 위 간격, dt 굵기, h3 앞뒤 간격(기존 토큰 안에서)
- 표를 감싸는 요소(`figure`/`div`)와 키보드 스크롤 속성
- 비교 도구 형태·기준 서빙 방법·텍스트 추출 방법(스크래치, 커밋 안 함)
- `scripts/check-site.sh`에 Tailwind 문자열 검사 추가 여부(권장)
- ② 커밋을 문서별로 나눌지, 레이아웃 껍데기 클래스를 ①과 ③ 중 어디서 바꿀지

## Deferred Ideas

- 「포인트·굿즈·코스북」 문장 삭제 → Phase 4·6·7·8
- `noindex`·「임시 게시본」 제거 → Phase 6·7·8 (U14)
- 영문판 중첩 번호 a. b. c. 실제 확인 → Phase 9
- Pretendard `integrity`·CSP → 이번 논의에서 다루지 않음
