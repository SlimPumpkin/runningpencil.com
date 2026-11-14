# Phase 1: 기준표와 방침 정비 (Ground Truth & Policy Reset) - Discussion Log

> **감사 기록(audit trail) 전용.** 계획·연구·실행 에이전트의 입력으로 쓰지 않는다.
> 결정은 CONTEXT.md에 있고, 이 기록은 검토한 대안을 남긴다.

**Date:** 2026-11-14
**Phase:** 01-ground-truth-policy-reset
**Areas discussed:** CLAUDE.md 서술 방식, 데이터 목록 근거와 깊이, 결정·작업 목록과 메일, 이름 표·URL 고정값

---

## CLAUDE.md 서술 방식

| Option | Description | Selected |
|--------|-------------|----------|
| 현재 상태 + 방침 구간 | 코드 설명은 현재 상태 그대로, 맨 앞에 「이번 마일스톤 방침」 구간(적용 단계·상태) | ✓ |
| 목표 상태로 다시 쓰기 | 마일스톤이 끝난 뒤의 모습으로 재작성 | |
| 옛 문장만 교체 | 옛 규칙 문장만 새 방침 문장으로 바꿈 | |

| Option | Description | Selected |
|--------|-------------|----------|
| 방침 + 한 줄 이유 + 출처 경로 | 옛 규칙 문장은 인용하지 않고 「이전 방침을 뒤집음」으로만 | ✓ |
| 방침만 | 이유는 PROJECT.md에 맡김 | |
| 자세한 근거까지 | 조문·원문 링크까지 CLAUDE.md에 | |

| Option | Description | Selected |
|--------|-------------|----------|
| 작업 규칙도 포함 | ROADMAP Ground Rules를 줄여 옮기고 원본 경로 표기 | ✓ |
| 방침 6가지만 | 작업 규칙은 ROADMAP에만 | |

**User's choice:** 모두 권장안
**Notes:** 정찰 결과 `.claude/CLAUDE.md`는 `.planning/codebase/*.md`에서 생성되고, 원본 맵에도 옛 규칙이 있다. 그래서 세 곳을 모두 고치는 것을 묻지 않고 고정했다(CONTEXT D-04).

---

## 데이터 목록 근거와 깊이

| Option | Description | Selected |
|--------|-------------|----------|
| 코드 + dev 읽기 전용 CLI | gcloud·firebase의 describe·list만, 변경·배포 금지 | ✓ |
| 코드·문서만 | 코드에 없는 리전은 「미확인」 | |
| 코드 + CLI + 콘솔 값 직접 제공 | 콘솔 전용 값은 사용자가 이번 단계에서 제공 | |

| Option | Description | Selected |
|--------|-------------|----------|
| 필드 단위 + 범주 묶음 | 필드별 행에 범주 태그 | ✓ |
| 컬렉션·서비스 단위 | 컬렉션 하나가 한 행 | |
| 범주 단위 | 처리방침 문장 단위 | |

| Option | Description | Selected |
|--------|-------------|----------|
| dev 값 + prod 일치 조건 | 「근거: dev」 표시, 결정 목록에 「prod 리전」 새 항목 | ✓ |
| prod 생길 때까지 미확인 | 리전 칸을 미확인으로 | |
| dev 값을 확정값으로 | dev와 prod를 구분하지 않음 | |

| Option | Description | Selected |
|--------|-------------|----------|
| 앱 커밋 고정 + 법적 문서 단계 전 재확인 | 기준 커밋 이후 diff만 Phase 6·7·8 착수 때 재확인 | ✓ |
| 한 번 만들고 끝 | | |
| 출시 범위 문서 기준 | 미구현 기능 포함 | |

**User's choice:** 모두 권장안
**Notes:** 사전 조사 결과는 세 가지다. 처리방침 작성지침(2026.4)도 항목 개별 나열이 원칙이다. Analytics 보존 기간은 GA 콘솔 설정값이다. Crashlytics 보존 기간은 확인하지 못해 연구자에게 넘겼다.

---

## 결정·작업 목록과 메일

| Option | Description | Selected |
|--------|-------------|----------|
| Google Workspace | `runningpencil.com`을 Workspace에 붙임, `support@`로 답장 가능 | ✓ |
| Workspace 아님 → ImprovMX | 받기만, 답장은 업무 메일에서 | |
| 아직 모름 — 두 갈래로 | DNS 표 두 벌 | |

| Option | Description | Selected |
|--------|-------------|----------|
| 지원 주소로 답장 | `runningpencil.com` DKIM, Apple 발신처 `runningpencil.com` | ✓ |
| 업무 메일 주소로 답장 | `slimpumpkin.com`에서 답장 | |

| Option | Description | Selected |
|--------|-------------|----------|
| 권장안 + 미결정 시 기본값 | 항목마다 권장안·기본 동작·결정 주체·막는 단계·마감 | ✓ |
| 권장안만, 기본값 없음 | 결정 없으면 단계 정지 | |
| 목록만 | | |

| Option | Description | Selected |
|--------|-------------|----------|
| 따라 하면 되는 절차서 | 순서·레코드 표·`dig` 전후·확인 방법·넘길 것 | ✓ |
| 표와 체크리스트만 | | |

**User's choice:** Google Workspace, 나머지는 권장안
**Notes:** 사전 조사에 따르면 Workspace의 사용자 별칭 도메인은 추가 비용이 없다. 보조 도메인은 그 도메인에 만드는 사용자 계정마다 과금된다. 구체적 절차는 연구자가 확인한다.

---

## 이름 표·URL 고정값

| Option | Description | Selected |
|--------|-------------|----------|
| /location-terms/ | 기존 kebab-case 디렉터리 규칙과 같은 깊이 | ✓ |
| /terms/location/ | 약관 아래 2단 경로 | |
| /location-based-service-terms/ | 정식 명칭 그대로, 김 | |

| Option | Description | Selected |
|--------|-------------|----------|
| 이름 표는 빈칸, 값은 Phase 5 `_data`로 | 공개 저장소 git 이력에 값이 미리 남지 않음 | ✓ |
| 받는 대로 이름 표에 기입 | | |
| 로컬 전용 파일에 보관 | `.gitignore`된 파일 | |

| Option | Description | Selected |
|--------|-------------|----------|
| support@runningpencil.com | 가장 흔한 형태 | ✓ |
| help@runningpencil.com | | |
| contact@runningpencil.com | | |

| Option | Description | Selected |
|--------|-------------|----------|
| 서비스명 그대로 | 앱 표시명 = 러닝펜슬 / RunningPencil, 부제는 따로 | ✓ |
| 부제 포함 이름일 수 있음 | 결정 목록에 항목 추가 | |

**User's choice:** 모두 권장안
**Notes:** `gh repo view` 결과 저장소는 PUBLIC이다. 위치약관 URL은 업계 관례가 정해져 있지 않다(Google `/terms/location`, 식신 `location.html`).

---

## Claude's Discretion

- 기준 문서의 파일 구성·위치, 이름 표·URL 대장의 형식(마크다운 또는 YAML)
- 결정 목록의 항목별 권장안·기본 동작 문구(CONTEXT D-12 규칙 안에서)
- 데이터 목록의 범주 태그 이름·행 순서
- ROADMAP·STATE·PROJECT의 ImprovMX 전제 문장을 고치는 시점(PROJECT.md Key Decisions의 U12 기록은 이 단계에서 함)

## Deferred Ideas

- 없음(영문 위치약관은 v2 LOC-06으로 이미 정해져 있고, 콘솔 필드명은 Phase 10의 몫)
