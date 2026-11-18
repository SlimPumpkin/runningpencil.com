#!/usr/bin/env bash
# 푸시 전 점검. 운영(GitHub Pages)과 같은 Jekyll 3.10.0으로 빌드하고 여섯 가지를 확인한다.
#   1. 빌드가 성공한다
#   2. 빌드 결과에 내부 파일이 없다
#   3. 기존 URL 문서 4개가 있고 <title>이 기대값과 같다
#   4. 출력 HTML에 처리되지 않은 Liquid({%, {{)가 없다
#   5. 출력 HTML에 Tailwind Play CDN(cdn.tailwindcss.com, tailwind.config)이 없다
#   6. 랜딩 출력(index.html)에 출시 범위 밖 기능 이름(포인트·굿즈·코스북)이 없다
# 사용법: scripts/check-site.sh          작업 트리를 빌드해 점검한다
#         scripts/check-site.sh <커밋>   그 커밋의 추적 파일만 내보내 빌드해 점검한다 (pre-push 훅이 이렇게 부른다)
# macOS 기본 /bin/bash 3.2에서도 돌도록 연관 배열·mapfile을 쓰지 않는다.
set -u

# ── 기대값 (이후 단계에서 바뀌면 여기만 고친다) ──
JEKYLL_VERSION='jekyll 3.10.0'
# 법적 URL 3개의 제목은 Ground Rule로 고정한다. 랜딩 제목은 Phase 4에서 바뀔 수 있고, 바꾸는 단계가 이 값도 고친다.
EXPECTED_TITLES='index.html|러닝펜슬 - 달리고 걷는 길이 아트가 됩니다
privacy-policy/index.html|개인정보처리방침 - 러닝펜슬
terms/index.html|서비스 이용약관 - 러닝펜슬
data-deletion/index.html|데이터 삭제 안내 - 러닝펜슬'
# 빌드 결과에 있으면 안 되는 경로 (D-13). 원본 조각(_includes·_layouts)과 설정 파일도 포함한다.
FORBIDDEN='CLAUDE.md README.md Gemfile Gemfile.lock vendor .planning prepare scripts .githooks _includes _layouts _config.yml'

fail() { printf 'check-site: 실패 — %s\n' "$*" >&2; exit 1; }

# ── 도구 확인 ──
command -v git >/dev/null 2>&1 || fail 'git이 없습니다.'
TOP=$(git rev-parse --show-toplevel 2>/dev/null) || fail '저장소 안에서 실행하세요.'
command -v bundle >/dev/null 2>&1 || fail 'bundle 명령이 없습니다. Homebrew Ruby(brew install ruby)를 설치하고 PATH에 넣은 뒤 bundle install 하세요.'

# gem을 찾을 체크아웃: 지금 체크아웃에 .bundle/config가 없으면(새 worktree) 메인 체크아웃의 것을 쓴다
COMMON=$(git rev-parse --path-format=absolute --git-common-dir)
GEMROOT=$TOP
[ -f "$TOP/.bundle/config" ] || GEMROOT=$(dirname "$COMMON")
[ -f "$GEMROOT/Gemfile" ] || fail "Gemfile이 없습니다: $GEMROOT/Gemfile"
export BUNDLE_GEMFILE="$GEMROOT/Gemfile"

got=$(bundle exec jekyll -v 2>/dev/null) || fail "bundle exec jekyll 실행 실패. ruby=$(command -v ruby) bundle=$(command -v bundle) ($(bundle -v 2>&1 | head -n 1)). Homebrew Ruby가 PATH 앞에 있는지 확인하고 '$GEMROOT'에서 bundle install 하세요."
[ "$got" = "$JEKYLL_VERSION" ] || fail "Jekyll 버전이 다릅니다: '$got' (기대: '$JEKYLL_VERSION')"

# ── 빌드할 원본 준비 ──
WORK=$(mktemp -d "${TMPDIR:-/tmp}/rp-check.XXXXXX") || fail '임시 폴더를 만들 수 없습니다.'
trap 'rm -rf "${WORK:?}"' EXIT
# macOS의 /var/folders는 /private/var의 심볼릭 링크다. --safe 빌드는 실제 경로가 원본 밖이면 include를 거부하므로 실제 경로로 바꾼다.
WORK=$(cd "$WORK" && pwd -P) || fail '임시 폴더 경로 확인 실패'
if [ $# -ge 1 ]; then
    rev=$(git rev-parse --verify --quiet "$1^{commit}") || fail "커밋을 찾을 수 없습니다: $1"
    mkdir "$WORK/src" && git archive --format=tar "$rev" | tar -x -C "$WORK/src" || fail 'git archive 실패'
    SRC="$WORK/src"; label="커밋 ${rev:0:12}"
else
    SRC="$TOP"; label='작업 트리'
fi
DEST="$WORK/site"

# ── 1. 빌드 ──
if ! JEKYLL_ENV=production bundle exec jekyll build --safe -s "$SRC" -d "$DEST" > "$WORK/build.log" 2>&1; then
    grep -v '^[[:space:]]*from ' "$WORK/build.log" | tail -n 15 >&2
    fail "Jekyll 빌드 실패 ($label)"
fi

errors=0
problem() { printf 'check-site: %s\n' "$*" >&2; errors=$((errors + 1)); }

# ── 2. 내부 파일 ──
for p in $FORBIDDEN; do
    [ -e "$DEST/$p" ] && problem "내부 파일이 출력에 있습니다: /$p"
done
leaked=$(cd "$DEST" && find . \( -name '*.md' -o -name '.*' -o -name '_*' \) ! -name . -print)
[ -n "$leaked" ] && problem "공개되면 안 되는 파일: $(printf '%s ' $leaked)"
[ -e "$SRC/.nojekyll" ] && problem '.nojekyll이 있습니다: GitHub Pages가 Jekyll을 건너뛰어 include 원문과 내부 문서(CLAUDE.md 등)가 그대로 공개됩니다. Ground Rule이 .nojekyll을 금지합니다.'

# ── 3. 기존 URL 문서와 제목 ──
while IFS='|' read -r path want; do
    [ -n "$path" ] || continue
    if [ ! -f "$DEST/$path" ]; then problem "문서가 없습니다: /$path"; continue; fi
    have=$(sed -n 's:.*<title>\(.*\)</title>.*:\1:p' "$DEST/$path" | head -n 1)
    [ "$have" = "$want" ] || problem "제목이 다릅니다: /$path → '$have' (기대: '$want')"
done <<TITLES
$EXPECTED_TITLES
TITLES

# ── 4. 처리되지 않은 Liquid ──
# {% raw %}로 일부러 내보내는 {{ 가 생기면 이 검사가 걸린다. 그때는 예외 규칙을 여기에 더한다.
raw=$(grep -rlF -e '{%' -e '{{' --include='*.html' "$DEST" 2>/dev/null)
[ -n "$raw" ] && problem "Liquid가 처리되지 않은 출력: ${raw//$DEST/}"

# ── 5. Tailwind Play CDN 없음 ──
# 법적 페이지는 정적 CSS(_includes/css/legal.css)로 그린다. 런타임 스크립트가 다시 들어오면 막는다.
tw=$(grep -rlF -e 'cdn.tailwindcss.com' -e 'tailwind.config' --include='*.html' "$DEST" 2>/dev/null)
[ -n "$tw" ] && problem "Tailwind Play CDN이 출력에 남아 있습니다: ${tw//$DEST/}"

# ── 6. 랜딩에 출시 범위 밖 기능 이름 없음 ──
# 이번 마일스톤의 출시 앱에 없는 기능 이름(U10, SITE-01)이 랜딩에 다시 들어오면 막는다.
# 법적 문서 본문에는 Phase 6~8 전까지 남아 있으므로 랜딩 출력 하나만 본다. 코스북이 앱에 들어오면 이 항목을 고친다.
# 줄 단위가 아니라 낱말 단위로 센다. 「체크포인트」처럼 기능 이름이 아닌 낱말은 빼되, 같은 줄의 맨 「포인트」는 그대로 잡는다.
# 허용 낱말이 더 생기면 앞쪽 접두어 묶음 (체크|엔드)와 뒤쪽 허용 목록 '체크포인트|엔드포인트'에 함께 더한다.
u10=$(grep -o -E '(체크|엔드)?포인트|굿즈|코스북' "$DEST/index.html" 2>/dev/null | grep -v -x -E '체크포인트|엔드포인트' | wc -l | tr -d ' ')
[ "${u10:-0}" -eq 0 ] || problem "랜딩에 출시 범위 밖 기능 이름이 있습니다: /index.html ${u10}곳 (포인트·굿즈·코스북, U10)"

[ "$errors" -eq 0 ] || fail "${errors}건 (${label})"
printf 'check-site: 통과 (%s, %s)\n' "$label" "$got"
