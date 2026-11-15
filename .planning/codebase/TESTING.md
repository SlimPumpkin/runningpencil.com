---
last_mapped_commit: c4cb26d754e9e666c957e31fa7e559f918b425bb
last_mapped_at: 2026-11-14
---
# Testing Patterns

**Analysis Date:** 2026-11-14

## Test Framework

**Runner:**
- 없음. 자동화 테스트가 하나도 없다 (`package.json`, test runner, CI, linter, HTML validator 모두 없음).
- Config: Not applicable

**Assertion Library:**
- Not applicable

**Run Commands (실제 검증 방법 = 로컬 미리보기):**
```bash
python3 -m http.server 8000     # 저장소 루트에서 실행 → http://localhost:8000
# Watch mode: 없음 — 파일 저장 후 브라우저 새로 고침
# Coverage: 없음
```
- 반드시 저장소 루트를 서버 루트로 띄운다. `/favicon/...`, `/terms/`, `/#story` 같은 절대 경로라서 `file://`로 열면 깨진다.
- 글꼴(Pretendard, jsDelivr)과 법적 페이지의 Tailwind CDN 때문에 인터넷 연결이 필요하다.

## Test File Organization

**Location:** Not applicable (테스트 파일 없음)

**Naming:** Not applicable

**Structure:**
```
검증 대상
├── index.html                   # 랜딩: 스크롤 연동, 달려 보기, 반응형
├── privacy-policy/index.html    # 법적 페이지 (Tailwind CDN)
├── terms/index.html
├── data-deletion/index.html
└── favicon/ + site.webmanifest  # 아이콘 경로
```

## Test Structure

**수동 점검 목록 (커밋 = 배포이므로 `main` 푸시 전에 확인):**

1. **링크**
   - 랜딩 헤더·푸터: `#top`, `#story`, `#demo`, `#get` 이동.
   - 법적 페이지 헤더·푸터: `/`, `/#story`, `/#demo`, `/#get`, 약관 링크 3개 (`/privacy-policy/`, `/terms/`, `/data-deletion/`).
   - `/#demo`로 처음 열었을 때 그 구간 머리에 바로 서는지 (글꼴 늦게 와도 다시 맞춤), 새로 고침·뒤로 가기 때는 브라우저 자리를 유지하는지.
2. **「세 가지 이유」(`#story`)**
   - 기본: `<html>`에 `rp-pin`이 붙고 스크롤로 1·2·3단계가 넘어가는지, 단계 버튼(`data-go`)이 해당 위치로 부드럽게 스크롤하는지.
   - 창 높이 820/720/620px 이하에서 폰 그림이 `zoom`으로 줄어 잘리지 않는지.
3. **움직임 줄이기 (reduced-motion)**
   - DevTools → Rendering → `prefers-reduced-motion: reduce` 에뮬레이션.
   - `rp-pin`이 붙지 않고 단계 버튼으로만 넘어가는지, 히어로 SVG(`rp-hero-art`)가 멈추는지, 그리는 중 카드(`rp-sketch`)가 6.6초 장면에 서 있는지.
   - 창 높이 2400px 초과일 때도 `rp-pin`이 붙지 않는지.
4. **「달려 보기」(`#demo`)**
   - 버튼 → 7초 동안 점이 코스 선(`rp-c-dog`)을 따라가고 %·km·시간이 오르는지, 끝나면 뱃지(`rp-demo-done`에 `is-on`)와 「다시 달리기」 라벨·아이콘이 나오는지, 다시 누르면 처음부터 도는지.
5. **860px breakpoint**
   - 860px 위/아래에서 헤더 `.rp-nav`가 숨겨지고 `@media (max-width: 860px)` 블록 레이아웃이 맞는지. 375px 폭(모바일)에서 가로 스크롤이 생기지 않는지.
6. **네 페이지 공유 블록 일치**
   - `<head>` 글꼴·파비콘 링크, `<style>` 「공통」 묶음, 헤더·푸터 마크업이 네 파일에서 같은지 (링크 주소만 달라야 함). 아래 diff 명령으로 확인.
7. **콘텐츠 규칙**
   - 서비스 이름이 이름 표(`.planning/baseline/NAMES.md`)와 같은지 (한국어 페이지는 러닝펜슬, Phase 9 영문판은 `RunningPencil`). 이메일 게이트(Phase 5) 전에는 HTML·`_data`에 이메일 주소가 없는지. 다시 쓰지 않은 법적 페이지에 `noindex`와 「임시 게시본」 표시가 그대로 있는지 (Phase 6·7·8의 재작성 커밋에서 지운다, U14).
8. **브라우저 콘솔**에 오류가 없는지, 파비콘·`site.webmanifest`가 404 없이 뜨는지.
9. **`CLAUDE.md` 두 사본의 방침 구간 일치**
   - 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`의 「이번 마일스톤 방침」 구간(「작업 규칙」 포함)이 같은지. 아래 diff 명령으로 확인. 방침 구간을 고친 단계는 이 확인을 통과해야 끝난다.

**Patterns:**
- Setup: 로컬 서버 띄우기 → Chrome DevTools 기기 모드로 폭·높이 바꾸기.
- Teardown: 없음.
- Assertion: 눈으로 확인.

## Mocking

**Framework:** Not applicable

**Patterns:** 없음. 외부 의존(CDN 글꼴, Tailwind CDN)은 실제 네트워크로 받는다.

**What to Mock:** Not applicable

**What NOT to Mock:** Not applicable

## Fixtures and Factories

**Test Data:** 없음. 데모 값은 `index.html` 스크립트 안의 상수(`KM = 8.3`, 7000ms)와 SVG 경로에 박혀 있다.

**Location:** Not applicable

## Coverage

**Requirements:** None enforced

**View Coverage:** Not applicable

## Test Types

**Unit Tests:** 없음.

**Integration Tests:** 없음.

**E2E Tests:** Not used. 도입한다면 위 점검 목록 1~6을 Playwright 같은 도구로 옮기는 것이 가장 효과가 크다 (특히 reduced-motion 에뮬레이션, 860px 뷰포트, 링크 크롤링). 단, 현재 저장소에는 빌드와 `package.json`이 없으므로 (2026-11 기준. Phase 2에서 Jekyll 빌드를 도입한다) 도입 전에 확인을 받는다.

## Common Patterns

아래 명령은 macOS(BSD `sed`/`grep`, zsh)에서 실제로 돌려 확인했다 (2026-11-14). BSD `sed`·`grep`의 기본 정규식(BRE)은 `\|`를 지원하지 않으므로 `-E`(ERE)와 `|`를 쓰고, zsh가 `*.html`을 glob으로 펼치지 않도록 따옴표로 감싼다.

**공유 블록 일치 확인 (수동 보조 명령):**
```bash
# 「공통」 CSS 묶음이 네 파일에서 같은지 비교 (현재 각 29줄, 모두 일치)
for f in privacy-policy terms data-deletion; do
  diff <(sed -nE '/── 공통/,/── (랜딩 전용|법적 페이지 전용)/p' index.html | sed '$d') \
       <(sed -nE '/── 공통/,/── (랜딩 전용|법적 페이지 전용)/p' "$f/index.html" | sed '$d') \
    && echo "$f: 공통 OK"
done
```
- 범위는 `/* ── 공통: … */` 주석부터 다음 구획 주석(`── 랜딩 전용` 또는 `── 법적 페이지 전용`) 바로 앞까지다. 구획 주석 문구를 바꾸면 이 명령도 고친다.
- `<head>` 링크와 헤더·푸터 마크업은 이 명령이 비교하지 않는다 (링크 주소가 페이지마다 달라서). 눈으로 확인한다.

**`CLAUDE.md` 방침 구간 일치 확인 (점검 목록 9):**
```bash
# 두 사본의 「이번 마일스톤 방침」 구간이 같은지 확인. 출력이 없으면 통과, FAIL이 나오면 머리 문구·마커부터 확인
# 서브셸 ( ) 안에서 돌리므로 터미널에 붙여 넣어도 exit가 창을 닫지 않는다
(
  a=$(sed -n '/^## 이번 마일스톤 방침/,/^## Repository purpose/p' CLAUDE.md | sed '$d')
  b=$(sed -n '/^## 이번 마일스톤 방침/,/^<!-- GSD:/p' .claude/CLAUDE.md | sed '$d')
  case "$a" in *'### 작업 규칙'*) ;; *) echo 'FAIL: 루트 CLAUDE.md에서 방침 구간을 찾지 못함'; exit 1 ;; esac
  case "$b" in *'### 작업 규칙'*) ;; *) echo 'FAIL: .claude/CLAUDE.md에서 방침 구간을 찾지 못함'; exit 1 ;; esac
  diff <(printf '%s\n' "$a") <(printf '%s\n' "$b")
)
```
- 범위는 루트 `CLAUDE.md`의 `## 이번 마일스톤 방침`부터 `## Repository purpose` 바로 앞까지, `.claude/CLAUDE.md`의 같은 머리부터 첫 `<!-- GSD:` 마커 바로 앞까지다.
- 두 구간이 비어 있거나 「### 작업 규칙」이 없으면 `FAIL`을 찍고 종료 코드 1로 끝난다. 그래서 두 파일의 머리 문구를 함께 바꿔도 점검이 빈 구간끼리 비교하고 조용히 통과하지 않는다. 머리 문구, 「### 작업 규칙」 소제목, 마커를 바꾸면 이 명령도 함께 고친다.
- `generate-claude-md`는 GSD 마커 밖을 건드리지 않으므로 두 사본을 맞춰 주지 않는다. 손으로 같이 고친 뒤 이 명령으로 확인한다.

**이메일 주소 미노출 확인 (이메일 게이트 전, Phase 5까지 유효):**
```bash
grep -rnE "@[a-z0-9.-]+\.(com|kr)" --include='*.html' . | grep -v prepare/
# 출력이 없으면 통과. 이메일 게이트(Phase 5)가 열린 뒤에는 지원 이메일 주소만 나와야 한다
```

**내부 링크 점검 (서버 실행 중):**
```bash
for p in / /privacy-policy/ /terms/ /data-deletion/ /favicon/favicon.svg /favicon/site.webmanifest; do
  printf '%s %s\n' "$(curl -s -o /dev/null -w '%{http_code}' http://localhost:8000$p)" "$p"
done
```

---

*Testing analysis: 2026-11-14*
