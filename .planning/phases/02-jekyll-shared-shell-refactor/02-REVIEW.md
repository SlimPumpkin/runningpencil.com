---
phase: 02-jekyll-shared-shell-refactor
reviewed: 2026-11-16T07:04:28Z
depth: standard
files_reviewed: 17
files_reviewed_list:
  - _config.yml
  - _includes/css/common.css
  - _includes/footer.html
  - _includes/head-links.html
  - _includes/header.html
  - _layouts/legal.html
  - .claude/CLAUDE.md
  - .githooks/pre-push
  - .gitignore
  - CLAUDE.md
  - data-deletion/index.html
  - Gemfile
  - index.html
  - privacy-policy/index.html
  - README.md
  - scripts/check-site.sh
  - terms/index.html
findings:
  critical: 0
  warning: 2
  info: 6
  total: 8
  necessity: 1
status: issues_found
---

# Phase 2: Code Review Report

**Reviewed:** 2026-11-16T07:04:28Z
**Depth:** standard
**Files Reviewed:** 17
**Status:** issues_found

## Summary

검토 범위는 `1c4be1a..HEAD`(`ada7b57`)에서 바뀐 파일 18개입니다. 이 가운데 잠금 파일 `Gemfile.lock`은 범위 규칙에 따라 빼고 17개를 읽었습니다. 다만 `Gemfile.lock`의 플랫폼 목록과 `CHECKSUMS` 블록이 문서 설명과 맞는지는 확인했습니다.

**출력이 같은지 직접 확인했습니다.** `git archive HEAD`를 스크래치에 풀고 운영과 같은 옵션(`JEKYLL_ENV=production`, `--safe`, Jekyll 3.10.0)으로 빌드했습니다. 그 결과를 기준선 `1c4be1a`의 원본 HTML 네 개와 `diff` 했습니다. 네 페이지 모두 승인된 D-06 줄(「공통」 CSS 머리 주석 2번째 줄) 하나만 다르고 나머지는 바이트까지 같습니다. 따라서 include·레이아웃 연결, `{%- if/endif %}` 공백 처리, `{{ content | rstrip }}`, 헤더 `home=true` 분기는 모두 맞게 동작합니다. 빌드 출력 파일은 페이지 4개와 `favicon/` 7개, 모두 11개입니다. 내부 파일은 없습니다.

그 밖에 확인한 것:
- `layout: none`: Jekyll 3.10.0이 특별히 처리하므로(`document.rb:169`, `convertible.rb:252`) 경고 없이 레이아웃 없이 나갑니다.
- 셸: `scripts/check-site.sh HEAD`가 macOS `/bin/bash` 3.2.57에서 통과합니다.
- 실행 비트: `.githooks/pre-push`와 `scripts/check-site.sh` 모두 git에 `100755`로 들어가 있습니다.
- 정책 구간: 두 `CLAUDE.md`의 정책 구간은 같은 내용입니다.
- 줄 번호: `.claude/CLAUDE.md`가 가리키는 `index.html`·`_layouts/legal.html` 줄 번호 약 40곳이 실제와 맞습니다.
- 공개 저장소 노출: 사이트 파일에서 이메일, 로컬 홈 경로, 토큰을 찾지 못했습니다.

남은 문제는 페이지 출력이 아니라 **점검 장치가 실제로 지켜 주는 범위**에 있습니다.
- WR-01: 점검 4번(Liquid 잔여)은 Liquid가 조용히 먹어 버린 내용을 잡지 못합니다. 실험으로 확인했습니다.
- WR-02: 문서는 check-site.sh가 「운영과 같은 출력」을 만든다고 하지만, 그 출력은 점검이 끝나면 바로 지워집니다. 운영의 github-pages 기본 플러그인 세트도 로컬에서는 돌지 않습니다.

Critical 항목은 없습니다.

## Warnings

### WR-01: 점검 4번이 Liquid에 조용히 먹힌 내용을 잡지 못합니다. 문서는 이 항목을 raw 규칙의 안전망처럼 설명합니다

**File:** `scripts/check-site.sh:80-83` (문서: `CLAUDE.md:65`, `.claude/CLAUDE.md:365`)
**Issue:** 이번 단계부터 `index.html`에 front matter(`layout: none`)가 붙었습니다. 그래서 랜딩 파일 전체, 곧 약 150줄의 인라인 JS와 CSS가 모두 Liquid를 거칩니다. 점검 4번은 출력에 `{%`·`{{`가 **남아 있는지만** 봅니다. 그런데 raw로 감싸지 않은 `{{ … }}`는 남지 않고 빈 문자열이 됩니다. 스크래치 사본에서 직접 확인했습니다. `index.html`의 `var KM = 8.3;` 뒤에 `var tpl = "{{name}}";`를 넣고 빌드했습니다.
- 빌드는 오류도 경고도 없이 성공했습니다.
- 출력은 `var KM = 8.3; var tpl = "";`가 됐습니다.
- `grep -F -e '{{' -e '{%'` 결과는 0건이라 점검 4번은 통과합니다.

닫히지 않은 `{% comment %}`처럼 문법 오류가 나는 경우만 점검 1번(빌드 실패)에 걸립니다. 그래서 점검 4번은 다음처럼 반대로 동작합니다.
- raw를 **바르게** 쓴 출력에서는 걸립니다. 스크립트 주석(81행)도 이 경우에 예외를 더하라고 적어 둡니다.
- 실제로 페이지를 깨뜨리는 「raw를 빠뜨린」 경우는 통과시킵니다.

이 항목이 실제로 잡는 것은 front matter가 빠져 include 태그가 원문 그대로 나간 경우 정도입니다. 그런데도 `CLAUDE.md:65`와 `.claude/CLAUDE.md:365`는 raw 규칙의 안전망으로 설명하고 있어, 이후 단계가 이 점검을 믿고 넘어갈 위험이 있습니다. Phase 4에서 랜딩 JS를 다시 쓸 때 객체 리터럴이 중첩되거나(`{{`) 템플릿 문자열을 쓰면 이 경로를 그대로 탑니다.
**Fix:** 출력이 아니라 **원본**을 검사하는 항목을 더합니다. front matter가 붙은 파일에서 허용 목록 밖의 Liquid 표식이 보이면 실패로 처리합니다. 예시는 bash 3.2에서도 돕니다.
```bash
# ── 5. 원본의 Liquid 표식 (허용 목록 밖이면 실패) ──
# 랜딩은 include 네 줄만 허용한다. 새 태그를 쓰게 되면 이 목록에 더한다.
bad=$(grep -n -E '\{\{|\{%' "$SRC/index.html" \
      | grep -v -E '^[0-9]+:\{% include (head-links\.html|css/common\.css|header\.html home=true|footer\.html) %\}$')
[ -n "$bad" ] && problem "index.html에 허용되지 않은 Liquid 표식: $bad"
```
- 법적 페이지 본문(`privacy-policy/`·`terms/`·`data-deletion/index.html`의 front matter 아래)에는 Liquid 표식이 아예 없어야 한다는 규칙을 같은 방식으로 더할 수 있습니다.
- `CLAUDE.md:65`와 `.claude/CLAUDE.md:365`의 설명은 「4번은 남은 표식만 잡고, 먹힌 표식은 5번이 잡는다」로 고칩니다. 원본은 `.planning/codebase/ARCHITECTURE.md`를 고친 뒤 다시 생성합니다.
- `strict_variables: true`는 쓰지 않는 편이 낫습니다. 지금 템플릿은 값이 없는 `page.heading`·`page.noindex`·`page.updated`·`include.home`에 기대고 있어서 빌드가 깨질 수 있습니다.

### WR-02: 문서는 「운영과 같은 출력은 check-site.sh가 만든다」고 하지만, 출력은 남지 않고 운영 플러그인 세트도 돌지 않습니다

**File:** `CLAUDE.md:81`, `.claude/CLAUDE.md:69` (관련 코드: `scripts/check-site.sh:41`, `:54`)
**Issue:** 문서에는 두 문장이 있습니다.
- `CLAUDE.md:81`: 「운영과 같은 출력은 `scripts/check-site.sh`가 만듭니다」
- `.claude/CLAUDE.md:69`: 「운영 출력과 비교하거나 푸시 전에 점검할 때는 `scripts/check-site.sh`… 를 쓴다」

둘 다 사실과 다릅니다. 이유는 둘입니다.
1. **출력이 남지 않습니다.** `check-site.sh:41`의 `trap 'rm -rf "${WORK:?}"' EXIT`이 빌드 결과(`$WORK/site`)를 성공하든 실패하든 지웁니다. 결과를 남기는 옵션도 없습니다. 그래서 문서대로 「운영 출력과 비교」하려 해도 비교할 파일이 없습니다. 이번 단계의 diff 0 확인도 스크립트 밖에서 직접 빌드해서 했습니다(D-13 끝 문단).
2. **운영과 같은 빌드가 아닙니다.** 로컬은 맨 Jekyll 3.10.0(`Gemfile`)을 `--safe`로 돌립니다. `vendor/bundle`에는 github-pages gem도, 그 기본 플러그인도 없습니다. 운영 빌드(github-pages)는 다음 플러그인을 늘 켜 둡니다.
   - `jekyll-default-layout`, `jekyll-optional-front-matter`, `jekyll-readme-index`, `jekyll-titles-from-headings`, `jekyll-relative-links`, `jekyll-github-metadata`
   - 운영 기본 테마가 있다면 그것도 더해집니다. `.claude/CLAUDE.md`의 명명 규칙도 「운영 테마의 레이아웃과 충돌」을 전제로 합니다.

   그래서 로컬에서 통과해도 운영에서 달라질 수 있습니다. 예를 들어 이후 단계에서 `layout` 키 없이 front matter만 둔 새 페이지를 만들면, 로컬은 레이아웃 없이 내보내지만 운영은 `jekyll-default-layout`이 레이아웃을 입힐 수 있습니다.

지금 네 페이지는 라이브 확인(02-10)으로 맞다는 것이 확인됐으므로 현재 결함은 아닙니다. 문제는 이후 단계가 이 문장을 믿고 운영 확인을 건너뛸 수 있다는 점입니다.
**Fix:** 둘 중 하나를 고릅니다.
- (a) **문서를 사실대로 고칩니다.** 「check-site.sh는 운영과 같은 Jekyll 버전·`--safe`·production 환경으로 빌드하지만, github-pages 기본 플러그인과 테마는 돌리지 않는다. 빌드 결과는 점검 뒤 지운다. 운영과 다를 수 있는 변경(새 페이지, front matter 키)은 배포 뒤 라이브에서 확인한다」로 바꿉니다. `.claude/CLAUDE.md`는 원본 `.planning/codebase/STACK.md`를 고친 뒤 다시 생성합니다.
- (b) **결과를 남기는 옵션을 더합니다.** 예를 들어 `CHECK_SITE_KEEP=1`이면 trap에서 지우지 않고 경로를 알려 줍니다.
  ```bash
  if [ "${CHECK_SITE_KEEP:-}" = 1 ]; then trap 'printf "check-site: 출력 보존 → %s\n" "$DEST" >&2' EXIT
  else trap 'rm -rf "${WORK:?}"' EXIT; fi
  ```

## Info

### IN-01: 점검 2번은 금지 목록 방식이라 `exclude`에 빠진 새 일반 파일을 잡지 못합니다

**File:** `scripts/check-site.sh:19-20`, `:63-67`
**Issue:** 사용자 `exclude`(`_config.yml:13-23`)가 Jekyll 기본 제외 목록을 덮어씁니다. 그래서 루트에 새 파일을 추가하고 `exclude`에 적지 않으면 그 파일이 사이트에 공개됩니다. 점검 2번이 잡는 것은 미리 적어 둔 이름(`FORBIDDEN`)과 `*.md`·`.*`·`_*` 패턴뿐입니다. `package.json`, `Makefile`, `notes.txt`, `*.sh`, `*.yml` 같은 파일은 통과합니다. 금지 목록 방식은 D-13이 정한 대로이므로 결함으로 보지는 않습니다.
**Fix:** 출력 파일 목록을 기대 목록과 비교하는 항목을 고려합니다. 지금 출력은 11개입니다: 페이지 4개와 `favicon/` 7개. 새 페이지나 자산을 더하는 단계가 기대 목록도 같이 고치면, 금지 목록에 없는 누출도 잡힙니다.

### IN-02: `git archive | tar` 파이프라인이 실패해도 종료 코드가 0이 되어, 엉뚱한 오류로 끝납니다

**File:** `scripts/check-site.sh:46`
**Issue:** `pipefail`이 없으므로 파이프라인의 종료 코드는 `tar`의 것입니다. 스크래치에서 확인했습니다. `git archive`가 실패해 빈 입력이 들어와도 bsdtar는 0으로 끝납니다(`pipeline=0`, 파일 0개). 그러면 빈 원본이 그대로 빌드에 성공합니다. 이어서 점검 3번이 「문서가 없습니다」를 네 번 내고 실패합니다. 실패하는 쪽으로는 끝나므로 안전에는 문제가 없습니다. 다만 진짜 원인(아카이브 실패)이 가려집니다. 45행에서 커밋을 이미 검증하므로 일어날 일도 드뭅니다.
**Fix:** 아카이브를 먼저 파일로 만든 뒤 풀거나, 푼 뒤 `index.html`이 있는지 확인합니다.
```bash
git archive --format=tar -o "$WORK/src.tar" "$rev" || fail 'git archive 실패'
mkdir "$WORK/src" && tar -x -C "$WORK/src" -f "$WORK/src.tar" || fail 'tar 풀기 실패'
```

### IN-03: 레이아웃이 front matter 값을 이스케이프하지 않고 `<title>`과 속성값에 넣습니다

**File:** `_layouts/legal.html:8-9`, `:47-48`
**Issue:** `{{ page.title }}`, `{{ page.description }}`, `{{ page.eyebrow }}`, `{{ page.heading | default: page.title }}`가 이스케이프 없이 나갑니다. 지금 값에는 `"`·`&`·`<`가 없어 출력이 맞습니다. 하지만 설명에 큰따옴표가 들어가면 `content="…"` 속성이 깨집니다. Phase 7·8에서 법적 문서를 다시 쓰면 `(이하 "회사")` 같은 표현이 설명에 들어갈 가능성이 있습니다. 값은 저장소 작성자만 넣으므로 보안 문제는 아닙니다.
**Fix:** 적어도 속성값에는 `| escape`를 붙입니다: `content="{{ page.description | escape }}"`. 지금 값에는 이스케이프할 문자가 없으므로 출력 바이트는 그대로입니다. 고칠 때 diff 0을 다시 확인합니다.

### IN-04: 누출 파일 목록을 따옴표 없이 펼칩니다

**File:** `scripts/check-site.sh:67`
**Issue:** `$(printf '%s ' $leaked)`는 따옴표가 없어 단어 분할과 글롭 확장이 일어납니다. 그래서 공백이 든 파일 이름은 쪼개져 보이고, `*`·`?`가 든 이름은 현재 디렉터리 기준으로 펼쳐질 수 있습니다. 실패 판정에는 영향이 없고 오류 메시지만 틀어집니다.
**Fix:** `problem "공개되면 안 되는 파일: $(printf '%s' "$leaked" | tr '\n' ' ')"`처럼 따옴표 안에서 줄바꿈만 바꿉니다.

### IN-05: Phantom requirement — `.gitignore`의 `.jekyll-cache/`는 Jekyll 3.10.0에서 생기지 않습니다

**File:** `.gitignore:15`
**Category:** necessity
**Issue:** `.jekyll-cache/`는 Jekyll 4.x의 캐시 폴더입니다. 설치된 `jekyll-3.10.0/lib` 전체에 `jekyll-cache`라는 문자열이 없습니다(`grep -rln` 0건). 운영도 로컬도 3.10.0으로 고정돼 있으므로(`Gemfile:5`, `scripts/check-site.sh:13`, `:37`) 이 폴더는 생기지 않습니다. 이 규칙이 막을 대상이 없습니다. 무해하지만, 주석(`.gitignore:13`)이 「Jekyll 로컬 빌드 산출물」이라고 설명해 3.10.0이 이 폴더를 만드는 것처럼 읽힙니다.
**Fix:** 줄을 지우거나, 주석에 「Jekyll 4로 올릴 때 대비」라고 이유를 적습니다. 지울지는 사람이 정합니다.

### IN-06: (pre-existing / out of phase scope) 법적 본문·랜딩 문구의 옛 기능 서술과 Tailwind CDN

**File:** `data-deletion/index.html:20-28`, `privacy-policy/index.html:14-15`, `terms/index.html:3`, `index.html:13-17`
**Issue:** 다음 내용은 모두 이번 단계에서 바뀌지 않았습니다(diff 0으로 확인).
- 포인트·굿즈·코스북 서술
- 「임시 게시본」 문단과 `noindex`
- 법적 페이지의 Tailwind Play CDN 런타임(`_layouts/legal.html:14`)

각각 Phase 4·6·7·8(U10·U14)과 Phase 3에서 처리하기로 정해져 있습니다. 리팩터와 내용 변경을 섞지 않는다는 규칙대로 이번 단계에서 손대지 않은 것이 맞습니다. 기록 목적으로만 남깁니다.
**Fix:** 해당 단계에서 처리합니다. 이번 단계에서 할 일은 없습니다.

---

_Reviewed: 2026-11-16T07:04:28Z_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
