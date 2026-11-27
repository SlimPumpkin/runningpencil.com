#!/usr/bin/env bash
# 푸시 전 점검. 운영(GitHub Pages)과 같은 Jekyll 3.10.0으로 빌드하고 여덟 가지를 확인한다.
#   1. 빌드가 성공한다
#   2. 빌드 결과에 내부 파일이 없다
#   3. 기존 URL 문서 4개와 지원 페이지(/support/)가 있고 <title>이 기대값과 같다
#   4. 출력 HTML에 처리되지 않은 Liquid({%, {{)가 없다
#   5. 출력 HTML에 Tailwind Play CDN(cdn.tailwindcss.com, tailwind.config)이 없다
#   6. 랜딩·삭제 안내 출력(index.html, data-deletion/index.html)에 출시 범위 밖 기능 이름(포인트·굿즈·코스북·배송지·전자상거래)이 없다
#   7. 지원 페이지(/support/)가 있으면 연락처(mailto)가 있고, /support/ 링크가 있으면 그 페이지가 있다 (이메일 게이트)
#   8. 삭제 안내(/data-deletion/)가 있으면 본문에 요청 경로(mailto)와 개발자 이름 소개 문단이 있고, 검색 제외와 임시 표시가 없다
# 사용법: scripts/check-site.sh          작업 트리를 빌드해 점검한다
#         scripts/check-site.sh <커밋>   그 커밋의 추적 파일만 내보내 빌드해 점검한다 (pre-push 훅이 이렇게 부른다)
# macOS 기본 /bin/bash 3.2에서도 돌도록 연관 배열·mapfile을 쓰지 않는다.
set -u

# ── 기대값 (이후 단계에서 바뀌면 여기만 고친다) ──
JEKYLL_VERSION='jekyll 3.10.0'
# 법적 URL 3개의 제목은 Ground Rule로 고정한다. 랜딩 제목을 바꾸는 단계가 이 값도 고친다.
EXPECTED_TITLES='index.html|러닝펜슬 - 달리고 걷는 길이 아트가 됩니다
privacy-policy/index.html|개인정보처리방침 - 러닝펜슬
terms/index.html|서비스 이용약관 - 러닝펜슬
data-deletion/index.html|데이터 삭제 안내 - 러닝펜슬
support/index.html|고객 지원 - 러닝펜슬'
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

# ── 6. 랜딩·삭제 안내에 출시 범위 밖 기능 이름 없음 ──
# 이번 마일스톤의 출시 앱에 없는 기능 이름(U10, SITE-01)이 랜딩·삭제 안내에 다시 들어오면 막는다.
# 삭제 안내는 Phase 6에서 다시 써서 함께 본다. 처리방침·약관은 Phase 7·8이 다시 쓴 뒤 더한다. 코스북이 앱에 들어오면 이 항목을 고친다.
# 줄 단위가 아니라 낱말 단위로 센다. 「체크포인트」처럼 기능 이름이 아닌 낱말은 빼되, 같은 줄의 맨 「포인트」는 그대로 잡는다.
# 허용 낱말(「○○포인트」)의 앞부분은 U10_ALLOW_PREFIX 한 곳에만 둔다. 잡는 쪽과 빼는 쪽이 이 값을 함께 쓴다.
# 값은 구두점·공백 없는 낱말을 |로 이은 모양만 받는다. 비우거나 빈 항목(||, 앞뒤의 |)을 넣거나 . * ^ $ ( [ 같은 구두점이 들어가면
# 정규식 뜻이 바뀌어 점검이 무력해지므로 막는다. 예외를 모두 없애려면 이 항목의 grep 두 줄을 단순한 형태로 바꾼다.
U10_ALLOW_PREFIX='체크|엔드'
case "|${U10_ALLOW_PREFIX}|" in *'||'*) fail "U10_ALLOW_PREFIX 형식이 잘못되었습니다: '${U10_ALLOW_PREFIX}'" ;; esac
case "${U10_ALLOW_PREFIX//|/}" in *[[:punct:][:space:]]*) fail "U10_ALLOW_PREFIX 형식이 잘못되었습니다: '${U10_ALLOW_PREFIX}'" ;; esac
for f in index.html data-deletion/index.html; do
    # 출력이 없으면 3번 항목이 「문서가 없습니다」로 이미 셌으므로 그 파일은 건너뛴다.
    [ -f "$DEST/$f" ] || continue
    # grep 종료 코드 0은 찾음, 1은 못 찾음(정상), 2 이상은 오류다. 오류를 「못 찾음」으로 여기면 점검이 조용히 통과하므로 실패로 다룬다.
    u10_hits=$(grep -o -E "(${U10_ALLOW_PREFIX})?포인트|굿즈|코스북|배송지|전자상거래" "$DEST/$f"); u10_rc=$?
    if [ "$u10_rc" -gt 1 ]; then
        problem "점검 6번 grep이 실패했습니다 (종료 코드 ${u10_rc}, /${f}, U10_ALLOW_PREFIX='${U10_ALLOW_PREFIX}')"
    else
        u10=$(printf '%s\n' "$u10_hits" | grep -v -x -E "(${U10_ALLOW_PREFIX})포인트" | grep -c .)
        [ "${u10:-0}" -eq 0 ] || problem "출시 범위 밖 기능 이름이 있습니다: /${f} ${u10}곳 (포인트·굿즈·코스북·배송지·전자상거래, U10)"
    fi
done

# ── 7. 지원 페이지와 연락처 (이메일 게이트, Phase 5 D-04) ──
# 게이트 전에는 /support/ 문서도 그리로 가는 링크도 없으므로 이 항목은 그냥 지나간다.
# 보류 묶음의 커밋이 main에 섞이면(연락처 없는 지원 페이지, 페이지 없는 링크) 여기서 푸시가 멈춘다.
if [ -f "$DEST/support/index.html" ]; then
    grep -qF 'href="mailto:' "$DEST/support/index.html" \
        || problem '지원 페이지에 연락처(mailto)가 없습니다: 이메일 게이트 전의 /support/는 배포하지 않습니다 (D-04)'
fi
# 6번과 같은 이유로 grep 종료 코드 2 이상은 「못 찾음」이 아니라 실패로 센다.
sup_links=$(grep -rlF 'href="/support/' --include='*.html' "$DEST"); sup_rc=$?
if [ "$sup_rc" -gt 1 ]; then
    problem "점검 7번 grep이 실패했습니다 (종료 코드 ${sup_rc})"
elif [ -n "$sup_links" ] && [ ! -f "$DEST/support/index.html" ]; then
    problem "지원 페이지 없이 /support/ 링크가 있습니다: $(printf '%s ' ${sup_links//$DEST/})"
fi

# ── 8. 삭제 안내 본문 (요청 경로·개발자 이름, 검색 제외·임시 표시 없음, Phase 6) ──
# 공유 푸터에도 mailto가 있으므로 파일 전체가 아니라 본문 블록(.rp-doc, _layouts/legal.html)만 본다. 파일 전체를 보면 푸터 때문에 거짓 통과한다.
# 지원 이메일이나 개발자 이름 값을 지우면 요청 경로와 소개 문단이 함께 사라지므로 여기서 푸시가 멈춘다.
# 6·7번과 같은 이유로 grep 종료 코드 2 이상은 「못 찾음」이 아니라 실패로 센다.
dd="$DEST/data-deletion/index.html"
if [ -f "$dd" ]; then
    # 본문 블록: <div class="rp-doc"> 다음 줄부터 16칸 들여쓴 </div> 한 줄 앞까지
    dd_body=$(awk '/<div class="rp-doc">/{f=1;next} f && /^                <\/div>$/{exit} f' "$dd"); dd_rc=$?
    [ "$dd_rc" -eq 0 ] || problem "점검 8번 awk가 실패했습니다 (종료 코드 ${dd_rc})"
    printf '%s\n' "$dd_body" | grep -qF 'href="mailto:'; dd_rc=$?
    if [ "$dd_rc" -gt 1 ]; then problem "점검 8번 grep이 실패했습니다 (종료 코드 ${dd_rc})"
    elif [ "$dd_rc" -eq 1 ]; then problem '삭제 안내 본문에 지원 이메일 경로(mailto)가 없습니다: /data-deletion/ (D-20)'
    fi
    printf '%s\n' "$dd_body" | grep -qF '러닝펜슬(개발자 '; dd_rc=$?
    if [ "$dd_rc" -gt 1 ]; then problem "점검 8번 grep이 실패했습니다 (종료 코드 ${dd_rc})"
    elif [ "$dd_rc" -eq 1 ]; then problem '삭제 안내 본문에 개발자 이름 소개 문단이 없습니다: /data-deletion/ (D-18)'
    fi
    grep -qF 'name="robots"' "$dd"; dd_rc=$?
    if [ "$dd_rc" -gt 1 ]; then problem "점검 8번 grep이 실패했습니다 (종료 코드 ${dd_rc})"
    elif [ "$dd_rc" -eq 0 ]; then problem '삭제 안내에 검색 제외(noindex)가 남아 있습니다: /data-deletion/ (U14)'
    fi
    grep -qF '임시 게시본' "$dd"; dd_rc=$?
    if [ "$dd_rc" -gt 1 ]; then problem "점검 8번 grep이 실패했습니다 (종료 코드 ${dd_rc})"
    elif [ "$dd_rc" -eq 0 ]; then problem '삭제 안내에 임시 표시가 남아 있습니다: /data-deletion/ (U14)'
    fi
fi

[ "$errors" -eq 0 ] || fail "${errors}건 (${label})"
printf 'check-site: 통과 (%s, %s)\n' "$label" "$got"
