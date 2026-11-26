#!/usr/bin/env bash
# 261126-rw9 검증. 06-06-PLAN.md·06-RESEARCH.md·STATE.md를 익명 행 정정(ANON_ROW_FIX_SHA)에 맞춘 결과를 본다.
# 쓰는 법 (작업 디렉터리 = 저장소 루트): bash <이 파일> pre|t1|t2|t3
#   pre  편집 전 조건 (세 파일이 기준 커밋과 같음, 스테이징 없음, 표식이 정정 커밋을 가리킴)
#   t1   06-06-PLAN.md (교체표 그대로인지, 토큰, 문구 왕복, options 블록, front matter)
#   t2   06-RESEARCH.md 메모 한 줄과 STATE.md Blockers 줄 닫힘 (편집 뒤 계속 참)
#   t3   실행자 끝에서만 참: 커밋 범위, 메시지, 미커밋 경로, STATE 차이 (오케스트레이터가 STATE를 고치거나 커밋하면 거짓이 됨)
# 읽기 전용이다. 파일을 고치지 않는다. 실패가 하나라도 있으면 종료 코드 1.
set -u

BASE=ff7d9273fe41          # 계획 시점 HEAD (편집 전 기준)
FIX=d7dd8609bcb9           # 익명 행 정정 커밋 (ANON_ROW_FIX_SHA)
OLD=aeb6f4461157           # 재기준 커밋 (정정 전 목록)
P=.planning/phases/06-data-deletion-rewrite/06-06-PLAN.md
R=.planning/phases/06-data-deletion-rewrite/06-RESEARCH.md
S=.planning/STATE.md
E=.planning/phases/06-data-deletion-rewrite/06-EVIDENCE.md
INV=.planning/baseline/DATA-INVENTORY.md
QD=.planning/quick/261126-rw9-06-06-plan-md-anon-row-fix-sha-d7dd8609b/
Q="${QD}261126-rw9-PLAN.md"
GSD="${HOME}/.claude/gsd-core/bin/gsd-tools.cjs"
BLOCKER_PREFIX='- [Phase 06] 06-06을 실행하기 전에 06-06-PLAN.md Task 2를 고쳐야 함:'

fails=0
ok()  { printf 'OK %s\n' "$*"; }
bad() { printf 'FAIL %s\n' "$*"; fails=$((fails + 1)); }
# eq <이름> <얻은 값> <바라는 값>
eq()  { if [ "$2" = "$3" ]; then ok "$1 (${2})"; else bad "$1 got=[${2}] want=[${3}]"; fi; }
# cnt <글자> <파일> : grep -c -F 결과. 파일이 없으면 error:2
cnt() { if [ -f "$2" ]; then grep -c -F -- "$1" "$2"; else printf 'error:2\n'; fi; }

[ -f "$P" ] || { printf 'FAIL 저장소 루트에서 실행해야 함 (%s 없음)\n' "$P"; exit 1; }

run_pre() {
    # 세 파일이 기준 커밋과 같아야 줄 번호가 맞다
    if git diff --quiet "$BASE" -- "$P" "$R" "$S"; then ok 'pre: 세 파일이 기준 커밋과 같음'; else bad 'pre: 세 파일 가운데 기준 커밋과 다른 것이 있음'; fi
    if git diff --cached --quiet; then ok 'pre: 스테이징 없음'; else bad 'pre: 스테이징된 것이 있음'; fi
    if git merge-base --is-ancestor "$BASE" HEAD; then ok 'pre: 기준 커밋이 HEAD의 조상'; else bad 'pre: 기준 커밋이 HEAD의 조상이 아님'; fi
    local h
    h=$(sed -nE 's/^ANON_ROW_FIX_SHA=([0-9a-f]{12})$/\1/p' "$E" | head -n 1)
    eq 'pre: 06-EVIDENCE.md 표식 ANON_ROW_FIX_SHA' "$h" "$FIX"
    eq 'pre: 06-06-PLAN.md 줄 수' "$(wc -l < "$P" | tr -d ' ')" '248'
}

run_t1() {
    eq 't1: REBASE_SHA 줄 수 [HEAD=9 EXPECT==0]' "$(cnt 'REBASE_SHA' "$P")" '0'
    eq 't1: ANON_ROW_FIX_SHA가 있는 줄 [HEAD=absent]' "$(grep -n -F 'ANON_ROW_FIX_SHA' "$P" | cut -d: -f1 | tr '\n' ' ')" '20 67 84 87 93 120 123 124 154 '
    eq 't1: 옛 문구 「서버 문서를 쓰는 곳이 없음」 [HEAD=1 EXPECT==0]' "$(cnt '서버 문서를 쓰는 곳이 없음' "$P")" '0'
    eq 't1: 옛 문구 「남는 uid는」 [HEAD=1 EXPECT==0]' "$(cnt '남는 uid는' "$P")" '0'
    eq 't1: 98행 rate_limits [HEAD=0 EXPECT==1]' "$(sed -n '98p' "$P" | grep -c -F 'rate_limits')" '1'
    local h
    h=$(sed -nE 's/^ANON_ROW_FIX_SHA=([0-9a-f]{12})$/\1/p' "$E" | head -n 1)
    # 줄 단위 비교, 교체표 왕복, 124행 앞뒤 보존, options 블록, precondition 문구 왕복
    python3 -I - "$BASE" "$P" "$Q" "$INV" "$OLD" "$h" <<'PY' || fails=$((fails + 1))
import subprocess, sys
base, P, Q, INV, OLD, H = sys.argv[1:7]
bad = 0
def ok(m): print('OK t1:', m)
def no(m):
    global bad
    bad += 1
    print('FAIL t1:', m)
def show(rev, path):
    r = subprocess.run(['git', 'show', rev + ':' + path], capture_output=True)
    return r.stdout.decode('utf-8') if r.returncode == 0 else None

cur = open(P, encoding='utf-8').read().split('\n')
old = show(base, P).split('\n')
changed = [i + 1 for i in range(max(len(cur), len(old))) if i >= len(cur) or i >= len(old) or cur[i] != old[i]]
want = [20, 67, 84, 87, 93, 98, 120, 123, 124, 154]
(ok if len(cur) == len(old) else no)('줄 수가 기준과 같음 (%d / %d)' % (len(cur), len(old)))
(ok if changed == want else no)('바뀐 줄 = %s' % changed)

# 교체표 (옛 줄/새 줄/넣을 줄) 파싱: 라벨 줄, ```text, 내용 한 줄, ```
q = open(Q, encoding='utf-8').read().split('\n')
blocks = {'옛 줄:': [], '새 줄:': [], '넣을 줄:': [], '지울 줄 머리:': []}
i = 0
while i < len(q):
    if q[i] in blocks and i + 3 < len(q) and q[i + 1] == '```text' and q[i + 3] == '```':
        blocks[q[i]].append(q[i + 2])
        i += 4
        continue
    i += 1
(ok if (len(blocks['옛 줄:']), len(blocks['새 줄:'])) == (10, 10) else no)('교체표 옛/새 줄 수 %d/%d' % (len(blocks['옛 줄:']), len(blocks['새 줄:'])))
for k, (o, n) in enumerate(zip(blocks['옛 줄:'], blocks['새 줄:']), 1):
    co, cn, cb = cur.count(o), cur.count(n), old.count(o)
    if (cb, co, cn) == (1, 0, 1):
        ok('R%d 옛 줄 기준에 1·지금 0, 새 줄 지금 1' % k)
    else:
        no('R%d 옛 줄 기준=%d 지금=%d, 새 줄 지금=%d' % (k, cb, co, cn))

# 124행: 바뀐 곳 말고는 글자 그대로
act = [s for s in cur if '<action>' in s and 'OK anon facts in inventory' in s]
act0 = [s for s in old if '<action>' in s and 'OK anon facts in inventory' in s]
if len(act) != 1 or len(act0) != 1:
    no('124행 action 줄을 하나로 찾지 못함')
else:
    a, a0 = act[0], act0[0]
    need = ['precondition의 여섯 문구', '`users/{uid}` 문서를 쓰는 곳은 찾지 못함', '`lookupSignInMethods`', '`sendPasswordResetMail`',
            '(`rate_limits`)', '이 기록은 만료 시각과 TTL 정책으로만 지워짐', 'Analytics·Crashlytics·로그에 붙은 uid는 각 행의 기간을 따름']
    miss = [x for x in need if x not in a]
    (ok if not miss else no)('124행 새 사실 %s' % ('모두 있음' if not miss else '빠짐 ' + repr(miss)))
    m = '**어긋남 하나를 함께 보인다:**'
    (ok if m in a and a[a.index(m):] == a0[a0.index(m):] else no)('124행 어긋남 문단부터 끝까지 글자 그대로')
    p = '먼저 precondition의 '
    (ok if a[:a.index(p)] == a0[:a0.index(p)] else no)('124행 머리 글자 그대로')

# options 블록 (Task 2·3) 글자 그대로
def opts(ls):
    out, f = [], False
    for s in ls:
        if '<options>' in s: f = True
        if f: out.append(s)
        if '</options>' in s: f = False
    return out
o1, o0 = opts(cur), opts(old)
(ok if o1 == o0 and len(o0) > 30 else no)('options 블록 %d줄 글자 그대로' % len(o1))

# precondition 문구 왕복: 표식이 가리키는 커밋의 목록에 각 문구가 정확히 1번
pre = [s for s in cur if '<precondition>' in s and 'DATA-INVENTORY.md' in s]
if len(pre) != 1:
    no('Task 2 precondition 줄을 하나로 찾지 못함')
else:
    s, ph = pre[0], []
    while '「' in s:
        x = s.index('「')
        y = s.index('」', x)
        ph.append(s[x + 1:y])
        s = s[y + 1:]
    (ok if len(ph) == 6 else no)('precondition 확인 문구 %d개 [HEAD=4 EXPECT==6]' % len(ph))
    inv_fix, inv_old = show(H, INV), show(OLD, INV)
    if H != 'd7dd8609bcb9' or inv_fix is None or inv_old is None:
        no('표식 %r 또는 목록을 읽지 못함' % H)
    else:
        for t in ph:
            c1, c0 = inv_fix.count(t), inv_old.count(t)
            (ok if c1 == 1 else no)('문구 %r 정정 목록=%d 재기준 목록=%d' % (t, c1, c0))
        (ok if any(inv_old.count(t) == 0 for t in ph) else no)('정정 전 목록에 없는 문구가 하나 이상 (정정 목록을 가려냄)')
        legacy = ['prod에서는 켠다 (결정 목록 N3, Phase 6 D-26)', '만든 지 30일이 지난 익명 계정', '자동 정리가 Auth 삭제 트리거', 'MVP 동안 자동 정리를 끈 채 둔다고 적음']
        (ok if all(t in ph for t in legacy) else no)('기존 네 문구 유지')
sys.exit(1 if bad else 0)
PY
    # front matter와 구조가 그대로 읽힘
    if [ -f "$GSD" ]; then
        node "$GSD" query frontmatter.get "$P" plan 2>/dev/null | grep -q -F '"plan": "06"' && ok 't1: front matter plan=06' || bad 't1: front matter plan을 읽지 못함'
        node "$GSD" query frontmatter.get "$P" must_haves 2>/dev/null | grep -q -F 'ANON_ROW_FIX_SHA' && ok 't1: must_haves truth가 YAML로 읽히고 새 표식을 담음' || bad 't1: must_haves를 읽지 못하거나 새 표식이 없음'
        node "$GSD" query frontmatter.validate "$P" --schema plan 2>/dev/null | grep -q -F '"valid": true' && ok 't1: frontmatter.validate valid' || bad 't1: frontmatter.validate 실패'
        node "$GSD" query verify.plan-structure "$P" 2>/dev/null | grep -q -F '"task_count": 3' && ok 't1: plan-structure task 3개' || bad 't1: plan-structure 실패'
    else
        bad "t1: gsd-tools 없음 (${GSD})"
    fi
}

run_t2() {
    eq 't2: 06-RESEARCH.md numstat (더함/지움) [HEAD=absent EXPECT==2 0]' "$(git diff --numstat "$BASE" -- "$R" | cut -f1,2 | tr '\t' ' ')" '2 0'
    eq 't2: 06-RESEARCH.md 덩어리 머리' "$(git diff -U0 "$BASE" -- "$R" | grep '^@@' | cut -d' ' -f1-4 | tr '\n' ' ')" '@@ -308,0 +309,2 @@ '
    python3 -I - "$BASE" "$R" "$Q" <<'PY' || fails=$((fails + 1))
import subprocess, sys
base, R, Q = sys.argv[1:4]
bad = 0
def ok(m): print('OK t2:', m)
def no(m):
    global bad
    bad += 1
    print('FAIL t2:', m)
cur = open(R, encoding='utf-8').read().split('\n')
old = subprocess.run(['git', 'show', base + ':' + R], capture_output=True).stdout.decode('utf-8').split('\n')
H = '### C-7. 익명(둘러보기) 계정 문장 (D-26)'
if cur.count(H) != 1:
    no('C-7 머리를 하나로 찾지 못함')
    sys.exit(1)
i = cur.index(H)
memo = cur[i + 1]
q = open(Q, encoding='utf-8').read().split('\n')
ins = [q[k + 2] for k in range(len(q) - 3) if q[k] == '넣을 줄:' and q[k + 1] == '```text' and q[k + 3] == '```']
(ok if len(ins) == 1 and memo == ins[0] else no)('C-7 머리 바로 아래 줄이 교체표의 메모와 같음')
need = ['> **2026-11-26 메모 (익명 행 정정 뒤).**', 'ANON_ROW_FIX_SHA', 'rate_limits', 'lookupSignInMethods', 'sendPasswordResetMail', '(가)·(나)·(다)는 그대로']
miss = [x for x in need if x not in memo]
(ok if not miss else no)('메모 내용 %s' % ('모두 있음' if not miss else '빠짐 ' + repr(miss)))
(ok if cur[i + 2] == '' and cur[i + 3].startswith('- **사실 (앱 코드):**') else no)('메모 뒤 빈 줄, 그 뒤 「사실 (앱 코드)」 글머리')
j = old.index(H)
ch = [s for s in old[j:j + 8] if s.startswith('  - (가)') or s.startswith('  - (나)') or s.startswith('  - (다)')]
(ok if len(ch) == 3 and all(cur.count(s) == 1 for s in ch) else no)('C-7 선택지 (가)(나)(다) 세 줄 글자 그대로')
sys.exit(1 if bad else 0)
PY
    eq 't2: STATE.md 닫은 Blockers 줄 [HEAD=1 EXPECT==0]' "$(cnt '06-06을 실행하기 전에 06-06-PLAN.md Task 2를 고쳐야 함' "$S")" '0'
}

run_t3() {
    local files want status_bad msg tail2
    want=$(printf '%s\n%s\n' "$P" "$R" | sort)
    files=$(git diff-tree --no-commit-id --name-only -r HEAD | sort)
    eq 't3: HEAD 커밋의 파일 [HEAD=absent]' "$(printf '%s' "$files" | tr '\n' ' ')" "$(printf '%s' "$want" | tr '\n' ' ')"
    files=$(git diff --name-only "$BASE" HEAD | grep -v -F "$QD" | sort)
    eq 't3: 기준 커밋 뒤 커밋된 파일 (quick 폴더 제외)' "$(printf '%s' "$files" | tr '\n' ' ')" "$(printf '%s' "$want" | tr '\n' ' ')"
    msg=$(git log -1 --format=%B)
    case "$(printf '%s\n' "$msg" | head -n 1)" in
        'docs(06): '*) ok 't3: 제목 docs(06):' ;;
        *) bad 't3: 제목이 docs(06): 로 시작하지 않음' ;;
    esac
    tail2=$(printf '%s\n' "$msg" | grep -v '^[[:space:]]*$' | tail -n 2)
    if printf '%s\n' "$tail2" | grep -q -E '^Co-Authored-By: Claude [^<>]+ <noreply@anthropic\.com>$'; then ok 't3: 끝 트레일러 (06-04 재계획 보충 규칙 5번 판정)'; else bad 't3: 끝 두 줄에 Co-Authored-By 트레일러 없음'; fi
    if printf '%s\n' "$msg" | grep -v -E '^Co-Authored-By: ' | grep -q -E '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'; then bad 't3: 커밋 메시지에 이메일 꼴'; else ok 't3: 커밋 메시지에 이메일 꼴 없음'; fi
    if git diff "$BASE" HEAD -- "$P" "$R" | grep '^+' | grep -q -E '/Users/|[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'; then bad 't3: 더한 줄에 홈 경로나 이메일 꼴'; else ok 't3: 더한 줄에 홈 경로·이메일 꼴 없음'; fi
    # 미커밋 경로: STATE.md 수정과 quick 폴더뿐
    status_bad=$(git status --porcelain --untracked-files=all | awk -v qd="$QD" '{ p = substr($0, 4) } p != ".planning/STATE.md" && index(p, qd) != 1')
    eq 't3: STATE.md·quick 폴더 밖 미커밋 경로' "$status_bad" ''
    eq 't3: STATE.md 미커밋 수정' "$(git status --porcelain -- "$S" | cut -c1-2)" ' M'
    eq 't3: STATE.md numstat (더함/지움)' "$(git diff --numstat "$BASE" -- "$S" | cut -f1,2 | tr '\t' ' ')" '0 1'
    # 지운 줄 자체가 「- [Phase 06] …」라 diff에서는 「-- …」로 보인다. 파일 머리 「--- a/…」만 뺀다
    eq 't3: STATE.md 지운 줄' "$(git diff -U0 "$BASE" -- "$S" | grep '^-' | grep -v -E '^--- (a/|/dev/null)' | cut -c2- | grep -c -F -- "$BLOCKER_PREFIX")" '1'
    eq 't3: 사이트 파일 변경 (quick·.planning 밖)' "$(git diff --name-only "$BASE" | grep -v '^\.planning/' | tr '\n' ' ')" ''
}

case "${1:-}" in
    pre) run_pre ;;
    t1)  run_t1 ;;
    t2)  run_t2 ;;
    t3)  run_t1; run_t2; run_t3 ;;
    *)   printf '쓰는 법: bash %s pre|t1|t2|t3\n' "$0"; exit 2 ;;
esac
if [ "$fails" -eq 0 ]; then printf 'RESULT pass %s\n' "$1"; exit 0; fi
printf 'RESULT fail %s (%d)\n' "$1" "$fails"
exit 1
