# Phase 2: Jekyll 공유 셸 도입 (Shared Shell Refactor) - Discussion Log

> **감사 기록 전용(Audit trail only).** 계획·조사·실행 에이전트의 입력으로 쓰지 않습니다.
> 결정은 CONTEXT.md에 있고, 이 기록은 검토한 대안을 남겨 둡니다.

**Date:** 2026-11-15
**Phase:** 02-jekyll-shared-shell-refactor
**Areas discussed:** 법적 레이아웃 깊이, diff 0 기준과 낡은 주석, 로컬 빌드·확인 도구, 배포 순서와 라이브 확인

---

## 법적 레이아웃 깊이

### 법적 페이지 3종 전환 방식

| Option | Description | Selected |
|--------|-------------|----------|
| 레이아웃 + front matter (Recommended) | legal 레이아웃이 html·head·헤더·모눈종이 main·푸터를 그리고, 페이지에는 front matter와 본문만 남김. Phase 5~9의 새 페이지 5쪽이 파일 하나씩만 더하면 됨 | ✓ |
| include만 끼워 넣기 | 페이지 파일이 전체를 갖고 공통 자리만 include. 변경은 가장 작지만 main·Tailwind 설정·카드 틀은 계속 복사됨 | |

**User's choice:** 레이아웃 + front matter

### 법적 카드 머리 위치

| Option | Description | Selected |
|--------|-------------|----------|
| 레이아웃이 front matter로 그림 (Recommended) | eyebrow·heading·updated를 front matter로 받음. heading이 없으면 title을 쓰고, updated가 없으면 날짜 줄을 숨김 | ✓ |
| 페이지 본문에 그대로 | 레이아웃은 카드 틀까지만 그리고, 머리 HTML은 페이지마다 둠 | |

**User's choice:** 레이아웃이 front matter로 그림

### 랜딩 전환 방식

| Option | Description | Selected |
|--------|-------------|----------|
| include만 끼워 넣기 (Recommended) | index.html에 랜딩 CSS·SVG·스크립트를 그대로 두고, 공통 네 자리만 include | ✓ |
| 랜딩도 레이아웃 사용 | base 레이아웃을 공유하고, 랜딩 전용 CSS·OG·스크립트는 _includes로 옮김 | |

**User's choice:** include만 끼워 넣기

---

## diff 0 기준과 낡은 주석

### 틀린 말이 되는 출력 주석

| Option | Description | Selected |
|--------|-------------|----------|
| 커밋 분리 (Recommended) | 전환 커밋은 주석까지 그대로(엄격 diff 0). 주석은 바로 뒤 별도 커밋에서 고치고, 주석을 지운 뒤 diff 0으로 확인 | ✓ |
| 주석 변경을 예외로 허용 | 전환 커밋에서 주석도 고치고, 주석을 지운 뒤 비교 | |
| 출력은 그대로, 소스에만 안내 | 출력 주석은 두고 Liquid 주석으로 올바른 안내를 더함 | |

**User's choice:** 커밋 분리

### 공백 정규화 범위

| Option | Description | Selected |
|--------|-------------|----------|
| 줄 앞뒤 공백·빈 줄만 무시 (Recommended) | 줄 안의 공백 차이는 잡아냄 | ✓ |
| 모든 공백 무시 | include 경계를 맞추기는 쉽지만 태그 사이 공백 변화를 못 잡음 | |

**User's choice:** 줄 앞뒤 공백·빈 줄만 무시

### 비교 범위

| Option | Description | Selected |
|--------|-------------|----------|
| 네 문서 내용 + 전체 파일 목록 (Recommended) | 새로 공개되는 파일을 푸시 전에 로컬에서 잡음 | ✓ |
| 네 문서만 | 성공 기준 1 문구 그대로. 노출은 라이브 확인에서만 잡음 | |

**User's choice:** 네 문서 내용 + 전체 파일 목록

---

## 로컬 빌드·확인 도구

### gem 설치 위치

| Option | Description | Selected |
|--------|-------------|----------|
| 저장소 안 vendor/bundle (Recommended) | `bundle config set --local path vendor/bundle`. vendor/·.bundle/은 gitignore, vendor/는 exclude | ✓ |
| Homebrew Ruby 전역 gem | 설정은 없지만 다른 프로젝트와 gem 버전이 부딪힐 수 있음 | |

**User's choice:** 저장소 안 vendor/bundle

### 확인 스크립트를 저장소에 남길지

| Option | Description | Selected |
|--------|-------------|----------|
| 푸시 전 점검만 남김 (Recommended) | 빌드 성공, 내부 파일 미공개, 기존 URL 문서와 title을 확인. diff 비교는 일회용 | ✓ |
| 둘 다 남김 | 점검과 diff 비교 스크립트를 모두 커밋 | |
| 남기지 않음 | 명령만 CLAUDE.md에 적고 확인은 손으로 함 | |

**User's choice:** 푸시 전 점검만 남김

### 점검 자동 실행

| Option | Description | Selected |
|--------|-------------|----------|
| git pre-push 훅으로 자동 실행 (Recommended) | .githooks/pre-push + `core.hooksPath`. 실패하면 푸시 중단, `--no-verify`로 건너뜀 | ✓ |
| 수동 실행 | 설정은 필요 없지만, 잊으면 깨진 빌드가 배포됨 | |

**User's choice:** git pre-push 훅으로 자동 실행

---

## 배포 순서와 라이브 확인

### 푸시 시점

| Option | Description | Selected |
|--------|-------------|----------|
| 단계별로 나눠 푸시 (Recommended) | ① 빌드 설정 → ② 법적 3종 → ③ 랜딩 → ④ 주석·CLAUDE.md. 매번 라이브 확인 | ✓ |
| 단계 끝에 한 번 푸시 | 배포 횟수는 줄지만, 문제가 생기면 여러 커밋을 한꺼번에 살펴야 함 | |

**User's choice:** 단계별로 나눠 푸시

### 푸시 주체

| Option | Description | Selected |
|--------|-------------|----------|
| Claude가 매번 물어보고 푸시 (Recommended) | 푸시 직전 확인 단계에서 로컬 검증 결과를 보여 주고, 승인을 받으면 푸시. 승인은 푸시마다 받음 | ✓ |
| 사용자가 직접 푸시 | Claude는 커밋과 로컬 검증까지만 함 | |

**User's choice:** Claude가 매번 물어보고 푸시

### 라이브 문제 시 롤백

| Option | Description | Selected |
|--------|-------------|----------|
| 즉시 git revert 후 푸시 (Recommended) | 먼저 되돌리고 원인은 그다음에 수정. force push 없음 | ✓ |
| 고쳐서 다시 푸시 | 원인을 찾는 동안 라이브가 깨진 채 남음 | |

**User's choice:** 즉시 git revert 후 푸시

### 라이브 확인 깊이

| Option | Description | Selected |
|--------|-------------|----------|
| 상태·제목 + 라이브 HTML diff (Recommended) | 200·404·title에 더해 라이브 HTML을 기준과 정규화 비교. 로컬과 운영 Jekyll의 차이를 잡음 | ✓ |
| 상태·제목만 | 빠르지만 운영 빌드에서만 생기는 차이를 놓침 | |

**User's choice:** 상태·제목 + 라이브 HTML diff

---

## Claude's Discretion

- include 파일 이름과 나누는 단위, 헤더 링크 변형 방식
- 점검 스크립트의 언어와 경로(exclude 등록은 필수), 일회용 diff 스크립트의 형태
- `{%-` 공백 제어를 쓸지, 랜딩 front matter의 내용, 성공 기준 2의 임시 시험 방법
- 미리보기 명령은 `bundle exec jekyll serve --livereload`로 둠(사용자가 「다음 영역」을 고르며 동의)
- diff 비교 기준은 전환 직전 커밋의 원본 HTML로 둠(사용자가 「다음 영역」을 고르며 동의)

## Deferred Ideas

- `_data/company.yml`: Phase 5. `_data/i18n.yml`·hreflang: Phase 9
- legal 레이아웃을 `/support/`·`/location-terms/`에 쓸지: Phase 5·8
