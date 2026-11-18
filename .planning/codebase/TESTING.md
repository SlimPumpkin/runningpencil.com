---
last_mapped_commit: c4cb26d754e9e666c957e31fa7e559f918b425bb
last_mapped_at: 2026-11-14
---
# Testing Patterns

**Analysis Date:** 2026-11-14

## Test Framework

**Runner:**
- 자동 점검 하나: `scripts/check-site.sh`. 운영과 같은 Jekyll 3.10.0으로 빌드해 여섯 가지를 본다. 빌드 성공, `_site`에 내부 파일이 없음, 기존 URL 문서 4개(`index.html`, `privacy-policy/index.html`, `terms/index.html`, `data-deletion/index.html`)의 `<title>`이 기대값과 같음, 처리되지 않은 Liquid(`{%`, `{{`)가 없음, 출력 HTML에 Tailwind Play CDN 없음, 랜딩 출력(`index.html`)에 포인트·굿즈·코스북 없음(U10).
- `.githooks/pre-push` 훅이 `main` 푸시마다 이 스크립트를 돌린다 (훅 켜기: `git config core.hooksPath .githooks`, 클론마다 한 번). 실패하면 푸시가 멈춘다.
- 그 밖의 테스트 러너, CI, HTML validator는 없다 (`package.json` 없음). 전역 규칙의 「커밋 전 린터 실행」은 이 스크립트로 갈음한다.
- Config: 기대 제목과 금지 경로는 `scripts/check-site.sh` 맨 위 한 곳에 있다

**Assertion Library:**
- Not applicable

**Run Commands (자동 점검 + 로컬 미리보기):**
```bash
scripts/check-site.sh                     # 작업 트리를 빌드해 점검한다
scripts/check-site.sh <커밋>              # 그 커밋의 추적 파일만 내보내 빌드해 점검한다 (pre-push 훅이 이렇게 부른다)
bundle exec jekyll serve --livereload     # 미리보기 → http://localhost:4000 (저장하면 브라우저가 새로 고침)
# Coverage: 없음
```
- 미리보기 응답에는 livereload 스크립트가 끼므로 운영 출력과 같지 않다. 운영 출력과 비교할 때는 점검 스크립트의 빌드를 쓴다.
- `/favicon/...`, `/terms/`, `/#story` 같은 절대 경로라서 `file://`로 열면 깨진다.
- 글꼴(Pretendard, jsDelivr) 때문에 인터넷 연결이 필요하다. 오프라인이면 대체 글꼴로 보인다.

## Test File Organization

**Location:** Not applicable (테스트 파일 없음)

**Naming:** Not applicable

**Structure:**
```
검증 대상
├── index.html                   # 랜딩: 스크롤 연동, 달려 보기, 반응형
├── privacy-policy/index.html    # 법적 페이지 (정적 CSS)
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
6. **공통 블록 한 벌 확인**
   - `<head>` 글꼴·파비콘 링크, `<style>` 「공통」 묶음, 헤더·푸터 마크업이 include에 한 벌만 있고 페이지 파일에 복사본이 다시 생기지 않았는지. 아래 `git grep` 명령으로 확인.
7. **콘텐츠 규칙**
   - 서비스 이름이 이름 표(`.planning/baseline/NAMES.md`)와 같은지 (한국어 페이지는 러닝펜슬, Phase 9 영문판은 `RunningPencil`). 이메일 게이트(Phase 5) 전에는 HTML·`_data`에 이메일 주소가 없는지. 다시 쓰지 않은 법적 페이지에 `noindex`와 「임시 게시본」 표시가 그대로 있는지 (Phase 6·7·8의 재작성 커밋에서 지운다, U14).
8. **브라우저 콘솔**에 오류가 없는지, 파비콘·`site.webmanifest`가 404 없이 뜨는지.
9. **`CLAUDE.md` 두 사본의 방침 구간 일치**
   - 루트 `CLAUDE.md`와 `.claude/CLAUDE.md`의 「이번 마일스톤 방침」 구간(「작업 규칙」 포함)이 같은지. 아래 diff 명령으로 확인. 방침 구간을 고친 단계는 이 확인을 통과해야 끝난다.

**Patterns:**
- Setup: `bundle exec jekyll serve --livereload`로 미리보기 띄우기 → Chrome DevTools 기기 모드로 폭·높이 바꾸기.
- Teardown: 없음.
- Assertion: 눈으로 확인.

## Mocking

**Framework:** Not applicable

**Patterns:** 없음. 외부 의존(CDN 글꼴)은 실제 네트워크로 받는다.

**What to Mock:** Not applicable

**What NOT to Mock:** Not applicable

## Fixtures and Factories

**Test Data:** 없음. 데모 값은 `index.html` 스크립트 안의 상수(`KM = 7.84`, 7000ms)와 SVG 경로에 박혀 있다.

**Location:** Not applicable

## Coverage

**Requirements:** None enforced

**View Coverage:** Not applicable

## Test Types

**Unit Tests:** 없음.

**Integration Tests:** 없음.

**E2E Tests:** Not used. 도입한다면 위 점검 목록 1~6을 Playwright 같은 도구로 옮기는 것이 가장 효과가 크다 (특히 reduced-motion 에뮬레이션, 860px 뷰포트, 링크 크롤링). Jekyll 빌드 결과(`_site`)를 대상으로 돌릴 수 있다. 저장소에 `package.json`은 없으므로 도입 전에 확인을 받는다.

## Common Patterns

아래 명령은 macOS(BSD `sed`/`grep`, zsh)에서 실제로 돌려 확인했다 (2026-11-14. 「공통 블록 한 벌 확인」 명령은 2026-11-15). BSD `sed`·`grep`의 기본 정규식(BRE)은 `\|`를 지원하지 않으므로 `-E`(ERE)와 `|`를 쓰고, zsh가 `*.html`을 glob으로 펼치지 않도록 따옴표로 감싼다.

**공통 블록 한 벌 확인 (점검 목록 6):**
```bash
git grep -lF '<footer class="rp-foot">' -- '*.html'        # 푸터 마크업. 출력이 _includes/footer.html 하나여야 한다
git grep -lF '<header class="rp-head">' -- '*.html'        # 헤더 마크업. 출력이 _includes/header.html 하나여야 한다
git grep -lF 'rel="manifest"' -- '*.html'                  # head 링크. 출력이 _includes/head-links.html 하나여야 한다
git grep -lF '/* ── 공통' -- '*.html' '*.css'              # 「공통」 머리 주석. 출력이 _includes/css/common.css 하나여야 한다
```
- 경로를 `*.html`·`*.css`로 좁혀 이 문서처럼 문자열을 인용한 `.planning/` 문서가 걸리지 않게 한다. 두 파일 이상이 나오면 공통 블록이 페이지에 복사된 것이다.

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
- `generate-claude-md`는 `.planning/codebase/STACK.md`·`CONVENTIONS.md`·`ARCHITECTURE.md`에서 `## `·`### ` 머리줄, 맨 위 단계의 `- ` 목록, 표만 `.claude/CLAUDE.md`로 옮긴다. 굵은 소제목 줄(`**…:**`), 들여 쓴 하위 목록, 번호 목록, 코드 블록 안의 내용은 버린다. 그래서 이 세 원본을 고치거나 `gsd-map-codebase`로 다시 만든 뒤에는 소제목을 `### ` 머리줄이나 줄 안(`- **이름:** …`)에 넣고, 번호 목록은 `- ` 목록으로, 예시는 줄 안 코드로 바꾼다. 다시 생성한 `.claude/CLAUDE.md`에 빈 머리줄이나 콜론으로 끝나는 줄이 없는지 확인한다.

**이메일 주소 미노출 확인 (이메일 게이트 전, Phase 5까지 유효):**
```bash
grep -rnE "@[a-z0-9.-]+\.(com|kr)" --include='*.html' . | grep -v prepare/
# 출력이 없으면 통과. 이메일 게이트(Phase 5)가 열린 뒤에는 지원 이메일 주소만 나와야 한다
```

**내부 링크 점검 (`bundle exec jekyll serve` 실행 중):**
```bash
for p in / /privacy-policy/ /terms/ /data-deletion/ /favicon/favicon.svg /favicon/site.webmanifest; do
  printf '%s %s\n' "$(curl -s -o /dev/null -w '%{http_code}' http://localhost:4000$p)" "$p"
done
```

---

*Testing analysis: 2026-11-14*
