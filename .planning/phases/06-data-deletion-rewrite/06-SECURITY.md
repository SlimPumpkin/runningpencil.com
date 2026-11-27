---
phase: "06"
slug: "data-deletion-rewrite"
status: verified
# threats_open = count of OPEN threats at or above workflow.security_block_on severity (the blocking gate)
threats_open: 0
asvs_level: 1
created: "2026-11-27"
---

# Phase 06 — Security

> Per-phase security contract: threat register, accepted risks, and audit trail.
> 근거: 계획 06-01~06-13의 `<threat_model>`(계획 단계에 작성, 61행·고유 ID 49개, `T-06-SC`는 13개 계획 공통)과 06-05 SUMMARY의 Threat Flag 1건.
> 이 단계에서 한 일: 삭제 안내 `/data-deletion/`을 재작성했고(값 커밋 S1 `0c48a1175175`, 재작성 커밋 S2 `e9d9443692b4`), 점검 스크립트에 8번 항목(삭제 안내 요청 경로·개발자 이름 소개·검색 제외 없음)을 더했다(B1 `45f1958c1b5f`). 데이터 목록·결정 목록·운영 절차서(작업 13)·원본 맵·두 CLAUDE.md를 고쳤다. 푸시는 두 번 했다: 사이트 `e9d9443692b4`, 점검·문서 `ae760273bf46`.
>
> 검증은 ASVS L1(grep 수준)로 했다. gsd-security-auditor가 감사했고 감사 시점은 HEAD `d93fafe03572`, origin/main `ae760273bf46`다. HEAD가 원격보다 앞선 커밋 5개는 모두 `.planning/`만 고쳤다. 증거는 `06-EVIDENCE.md`(EV)의 판정 줄, 저장소 파일, 기준 앱 커밋 `92e986c3`의 코드(읽기만 함), 감사자의 재계수·음성 시험이다. 사실값(`_data/company.yml`)은 화면에 찍지 않고 변수로만 셌다. 스크래치 도구는 `$W`, 앱 저장소는 `$APP`로 적는다.

---

## Trust Boundaries

| Boundary | Description | Data Crossing |
|----------|-------------|---------------|
| 로컬 main → 원격 main (배포) | 마지막 관문은 pre-push 훅과 사람의 SHA 승인이다 | 사이트 출력 전체 (공개) |
| `_data/company.yml` 값 → 출력 HTML | 빌드 때 Liquid가 값을 넣는다. 이스케이프 없이 넣으면 HTML이 깨진다 | 사업자 정보·지원 이메일·개발자 이름 (공개 의도) |
| 앱 코드 → 공개 데이터 목록 → 심사 제출 문서 | 목록은 법적 본문의 유일한 근거이고 공개 저장소에 있으며, 기간 문구가 Google Play 보존 고지가 된다 | 앱 데이터 처리 사실 |
| 이 저장소 → 앱 저장소 | 앱 저장소는 읽기만 한다. 쓰기는 사용자 몫이다(D-05) | 코드 사실 (읽기) |
| 대화 → 작업 트리 → 공개 저장소 이력 | 값은 대화로만 오고 작업 트리 한 파일에만 들어간다. 커밋한 값은 되돌려도 이력에 남는다 | 개발자 이름 등 사실값 |
| 문서·기록 → 공개 저장소 | `06-EVIDENCE.md`, 운영 절차서, 원본 맵, CLAUDE.md가 모두 공개 저장소에 있다 | 판정 기록, 운영 절차 |
| 메일 요청자 → 운영자 → prod 데이터 | 누구나 지원 이메일로 삭제를 요청할 수 있다. 본인 확인과 관리자 claim이 남의 계정 삭제를 막는다 | 계정 식별 정보 |
| 데이터 목록 → prod 설정 | 목록의 삭제·보존 사실은 prod 설정 다섯 가지가 된 뒤에만 참이다 | 보존 기간 |
| npm 레지스트리 → 로컬 스크래치 | 검증 도구 패키지와 브라우저 바이너리를 내려받는다. 저장소와 사이트에는 들어가지 않는다 | 패키지 |

---

## Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation (계획) | Evidence | Status |
|-----------|----------|-----------|----------|-------------|-------------------|----------|--------|
| T-06-01 | Tampering | 스크래치 `playwright` 재설치 ([SUS] too-new) | high | mitigate | Task 2 `checkpoint:decision`(blocking-human)에서 그 자리의 `pnpm view` 결과를 보이고 승인받은 뒤에만 Phase 5 lockfile로 `--frozen-lockfile` 설치한다. Task 3 verify가 버전 1.59.1과 저장소에 도구 파일이 추적되지 않음을 확인한다 (06-01) | EV `## 06-01 도구`: 설치 결정(blocking-human)과 `PW_VERSION=1.59.1`. `$W/pw/pnpm-lock.yaml`이 1.59.1을 sha512 integrity로 고정, 설치본도 1.59.1. 저장소가 추적하는 도구 파일 0 | closed |
| T-06-02 | Information Disclosure | `06-EVIDENCE.md`·`$W/lib.sh` (공개 저장소, 홈 경로) | medium | mitigate | 머리 규칙에 공개 저장소 규칙을 적고 Task 1 verify·acceptance가 `$HOME` 문자열이 기록과 lib.sh에 없음을 확인한다. 도구는 본문 글을 찍지 않는다 (06-01) | EV 머리 규칙(3–6행). EV와 `$W/lib.sh`에 홈 경로 문자열 0 | closed |
| T-06-03 | Tampering | 앱 저장소 (`$APP`) | medium | mitigate | 읽기 명령만 쓴다(context 「앱 저장소는 읽기만 한다」). `appcheck`는 `git grep`·`git diff --name-only`·`git show`만 부른다 (06-01) | `$W/lib.sh` `appcheck()`는 `git -C "$APP"`의 읽기 명령만 씀(쓰기 0) | closed |
| T-06-04 | Repudiation | 기준 출력의 출처 | low | mitigate | 기준 커밋·원격·앱 HEAD를 해시로 기록하고 `$W/base/TREE`가 기준 트리와 같음을 verify가 확인한다 (06-01) | EV `BASE_SHA`·`BASE_LIVE`·`APP_BASE`. `$W/base/TREE` = `89f659a5fdca^{tree}` | closed |
| T-06-SC | Tampering | npm/pip/cargo installs | high | mitigate | package-legitimacy gate: RESEARCH 감사표의 [SUS] `playwright`는 Task 2 blocking-human checkpoint 승인 뒤에만 정확한 고정 버전으로 스크래치에만 pnpm 설치한다. 사이트 의존성은 추가하지 않는다 (06-01~06-13 전부) | BASE..HEAD에서 `Gemfile`·`Gemfile.lock` 변경 0, 추적되는 package manifest 0. 스크래치 설치는 `$W/pw` 한 번(2026-11-20)뿐 | closed |
| T-06-05 | Repudiation | 데이터 목록의 틀린 사실이 심사 제출 문서로 옮겨짐 | high | mitigate | Task 1이 여섯 사실을 기준 커밋에서 다시 확인하고 하나라도 다르면 멈춘다. 익명 계정은 「찾지 못함」으로만 적는다(prohibition) (06-02) | EV `## 06-02 사실 확인` `OK fact F1–F6`, `FACTS_BASE=OK`. 익명 계정은 DATA-INVENTORY에 「찾지 못했다」로만 | closed |
| T-06-06 | Tampering | 정정과 재기준이 섞여 앱 작업의 효과를 가림 | medium | mitigate | 기준 앱 커밋 줄을 고치지 않고(acceptance GUARD), 데이터 목록 커밋과 결정 목록 커밋을 나눈다 (06-02) | 정정 커밋 `ea0a0d7`(DATA-INVENTORY.md만, 기준 앱 커밋 줄 유지)과 `ef3e007`(DECISIONS.md·ROADMAP.md)이 나뉨 | closed |
| T-06-07 | Information Disclosure | 공개 저장소 문서에 앱 저장소 로컬 경로 | low | mitigate | 앱 경로는 `$APP`·저장소 상대 경로로만 적는다 (06-02) | Phase 6 추가 줄에 실제 로컬 경로 0(가드 정규식 문자열만 매치). DATA-INVENTORY는 `$APP`·저장소 상대 경로만 | closed |
| T-06-08 | Repudiation | 앱이 하지 않는 삭제를 사이트가 약속 (심사 반려·법적 위험) | high | mitigate | 요청서에 항목마다 코드로 확인할 사실을 적고, 06-04가 그 사실을 앱 코드에서 확인하기 전에는 원고를 쓰지 않는다(D-25) (06-03) | EV `### 요청서` 항목별 코드 확인 사실. 06-04 `APP_FACTS=OK`가 원고보다 먼저, 06-09 precondition `markers=12` | closed |
| T-06-09 | Spoofing | 「끝났다」는 말만으로 관문 통과 | medium | mitigate | 해시·경로를 받아 06-04가 읽기 전용으로 차이와 경로 존재를 확인한다(prohibition) (06-03) | EV `t3 head 92e986c3bb29 descends`, `t3 paths exists=18/18`, 06-04 `OK app head descends`·`path-in-diff` | closed |
| T-06-10 | Repudiation | 앱이 하지 않는 삭제·보존을 목록이 적음 | high | mitigate | Task 1이 항목마다 `AW`의 코드 사실을 확인하고 FAIL이면 멈춘다. Task 1 verify가 `records` 범위의 코스 보존과 확인자료 184일을 앱 커밋에서 다시 읽는다. 목록에는 확인한 사실만, 나머지는 「미확인」(prohibition) (06-04) | EV `## 06-04 앱 사실` `OK app item 1–6 fact`와 SRC 줄, `records-keeps-courses`, `retention-days=184` | closed |
| T-06-11 | Tampering | 행 번호가 바뀐 파일의 인용이 틀린 채 남음 | medium | mitigate | 바뀐 파일의 인용을 모두 다시 찾고 `REBASE_CITES` 줄을 verify가 본다. 탈퇴 정리 근거를 공유 정리 파일로 옮긴다(D-44) (06-04) | EV `REBASE_CITES checked=56 fixed=27` | closed |
| T-06-12 | Information Disclosure | 익명 사용자 데이터 처리가 목록과 다름 | medium | mitigate | 앱 작업 차이에서 익명 쓰기를 다시 찾고 찾으면 멈춘다(D-26). 앱 문서의 MVP 동안 끔 사실을 목록에 함께 적어 06-06 질문이 그 사실을 보인다 (06-04) | EV `ANON_WRITE=none-found`, `ANON_ROW_FIX_SHA=d7dd8609bcb9`. DATA-INVENTORY 익명 행에 「앱 문서는 MVP 동안 끈다고 적음」 | closed |
| T-06-40 | Repudiation | 삭제 안내 `#location`이 앱과 다른 동의 설정 사실을 적음 | medium | mitigate | Task 2 4번이 `AW`의 약관 동의 키와 변경 코드를 읽고, 그런 설정이 있거나 불분명하면 멈춘다. Task 3이 근거와 함께 목록 구간 C에 적고 06-07은 그 글자만 쓴다 (06-04) | EV `LOC_CONSENT_CONTROL=none-found`. DATA-INVENTORY와 삭제 안내 `#location`이 같은 문장 | closed |
| T-06-41 | Repudiation | prod 설정 다섯 가지 없이 삭제 안내의 삭제·보존 문장이 prod에서 거짓이 됨 | medium | mitigate | Task 3이 다섯 가지를 데이터 목록 「### prod 전제 (Phase 6 D-42)」 한곳에 적고 verify가 번호 줄 다섯을 본다. 06-11이 「확인할 것」에서 이 절을 가리키는 추적 항목을 더한다 (06-04) | DATA-INVENTORY 「### prod 전제 (Phase 6 D-42)」 번호 다섯 줄과 「확인할 것」 추적 행 | closed |
| T-06-42 | Repudiation | 법률 확인 전 U2 초안을 결정 목록이 「결정됨」으로 적어 위치정보 문장이 확정된 것처럼 보임 | medium | mitigate | Task 3 11번이 U2를 「초안으로 진행」으로 고치고 verify가 그 행을 본다(D-36) (06-04) | DECISIONS U2 상태 「초안으로 진행 … 법률 확인 필요」 | closed |
| T-06-43 | Tampering | 기준 앱 커밋 뒤 앱이 바뀌었는데 옛 사실로 목록을 씀 | medium | mitigate | Task 1 2번이 앱 HEAD 이동을 재어 삭제 관련 경로가 바뀌었으면 멈춰 사용자에게 넘긴다(기준은 D-36대로 `AW`) (06-04) | EV `OK app drift … commits=10 evidence-paths=0`(06-04), `commits=26 evidence-paths=0`(06-06) | closed |
| T-06-13 | Spoofing | 메일로 남의 계정 삭제 요청 (사칭) | high | mitigate | 계정 이메일 확인 메일·답장(D-08). 이메일 없는 계정·가리기 주소는 「내 계정」 값 대조와 운영자 추가 질문 두 단계가 모두 맞을 때만 지운다(D-30). 추가 질문 내용은 공개 사이트에 쓰지 않는다. 도구는 uid를 두 번 입력해야 지운다 (06-05) | USER-TASKS 작업 13: 확인 메일 답장 전 삭제 안 함, 대체 확인 두 단계 모두 맞을 때만 삭제, 질문 내용은 사이트에 없음(삭제 안내 0건). 운영 도구의 uid 재입력(`confirm_uid_mismatch`)과 admin claim을 기준 앱 커밋 `92e986c3`에서 확인 | closed |
| T-06-14 | Repudiation | 사이트가 약속한 10일 상한을 운영이 못 지킴 | medium | mitigate | 절차서가 받은 날 기산과 도구 실행·재확인·완료 답장 순서를 적고, 원고(06-07)가 이 절차와 같은 상한만 쓴다 (06-05) | USER-TASKS 「요청을 받은 날부터 10일 안」(기산점 고정), 삭제 안내가 같은 상한 | closed |
| T-06-15 | Information Disclosure | 절차서에 주소·uid·사용자 이메일·앱 프로젝트 ID | medium | mitigate | verify가 작업 13의 이메일 주소 꼴 0을 본다. 처리 기록은 메일함 스레드에만 두고 앱 문서의 명령 줄을 옮기지 않는다(prohibition) (06-05) | 작업 13 구간에 `@`·uid 꼴·명령 줄·프로젝트 ID 꼴 0, 기록 금지 문장 있음 | closed |
| T-06-44 | Repudiation | 일부 단계가 실패했는데 「삭제 완료」로 답함 | medium | mitigate | 종료 코드 0일 때만 완료 답장, 1이면 다시 실행, 1시간 뒤 같은 명령으로 0이어야 하는 키를 다시 본다(D-43, 앱 문서). Task 1 verify가 이 단계들의 낱말을 본다 (06-05) | USER-TASKS: `--apply` 종료 코드 0일 때만 진행, 1이면 재실행, 1시간 뒤 0이어야 하는 키 확인, 완료 조건 | closed |
| T-06-45 | Repudiation | 탈퇴 정리 트리거 실패로 개인위치정보·확인자료가 남아 삭제 안내의 「지체 없이 파기」가 거짓이 됨 | medium | mitigate | 절차서 (12)가 영업일마다 실패 로그를 보고 범위 `account`로 다시 지운다(`OPS_FAILLOG=included`). prod 권한 전제는 데이터 목록 prod 전제 3번 (06-05) | EV `OPS_FAILLOG=included`. USER-TASKS 영업일마다 `cleanup_user_data_failed` 확인 후 범위 `account`로 재삭제. prod 전제 3번 | closed |
| T-06-16 | Repudiation | 남는 데이터를 빠뜨리거나 기간을 사실보다 짧게 적음 (심사·법적 위험) | high | mitigate | 대조표 행 수가 목록 대상 행 수와 같음을 verify가 본다. prod 값이 없는 행은 사용자가 상한 약속으로 정하고 06-13이 prod 전제 절에 덧붙인다 (06-06) | EV `TABLE_SOURCE_ROWS=33`, `TABLE_ROWS=33`, `RETAINED_ROWS=7` = 삭제 안내 남는 데이터 표 7행. prod 값 없는 행은 prod 전제 상한 | closed |
| T-06-17 | Tampering | 계획자·실행자가 열린 선택지를 골라 사실 아닌 약속을 씀 | medium | mitigate | 두 질문 모두 blocking checkpoint이고 prohibition으로 대신 고르기를 막는다 (06-06) | EV `## 06-06 결정`에 blocking checkpoint 답(`D33_C7=ga`, `D33_C8=proposal` 등)과 「실행자는 고르거나 권하지 않았다」 | closed |
| T-06-46 | Repudiation | 탈퇴한 사람의 공개 코스에 대해 지킬 수 없는 삭제 경로나 기간을 약속함 | medium | mitigate | Task 3 (b)가 D-39 질문으로 묻고, 약속하는 답은 앱 경로가 생길 때까지 보류로 끝낸다(`D39_PATH=none`일 때만 진행). 지원 페이지 `#report` 문장도 함께 읽어 보인다 (06-06) | EV `D39_PATH=none`. 공개 코스 행에 삭제 경로·기한 약속 없음. `support/index.html`은 Phase 6에서 안 바뀜 | closed |
| T-06-47 | Repudiation | 익명 자동 정리 문장이 앱 문서(MVP 동안 끔)와 어긋난 채 공개됨 | medium | mitigate | Task 2가 어긋남을 선택지와 함께 보이고 precondition이 그 사실이 목록에 있을 때만 묻는다. (나)를 고르면 prod 전제 1번이 문장의 전제가 된다는 것도 보인다 (06-06) | EV `D33_C7=ga`. 삭제 안내에 aside 한 문장만, 「자동 정리」 0건 | closed |
| T-06-18 | Tampering | `_data` 값의 HTML 주입 (XSS) | medium | mitigate | 모든 출력에 ` (06-07) | 삭제 안내·푸터·지원 페이지의 `site.data.company.*` 출력 중 `\| escape` 빠진 것 0. EV `OK variant escape esc=1 raw=0` | closed |
| T-06-19 | Tampering | `mailto:` 값의 헤더 주입 | low | accept | 값은 운영자가 직접 넣는 고정값이고 ` (06-07) | mailto 출력(삭제 안내 2곳, 푸터 1곳)이 모두 `\| escape`. 감사 시점 `support_email` 값에 헤더 주입 문자 없음. 수용 로그 AR-06-01 | closed |
| T-06-20 | Repudiation | 앱·운영과 다른 약속을 심사에 제출 | high | mitigate | 원고는 재기준 목록·대조표·작업 13의 사실만 쓰고(prohibition), 표 행 수와 고정 줄 문구가 대조표·목록과 같음을 verify가 보며, 사용자가 행별 대조로 승인한다 (06-07) | EV `DRAFT_APPROVED=b681410f94c5`(approve). 배포 blob = HEAD blob = `refs/p6-scratch/draft` blob. 표 7행·지워지는 항목 8개가 기록과 같음 | closed |
| T-06-21 | Information Disclosure | 실제 값이 승인 자료·기록에 남음 | medium | mitigate | 이 계획은 가짜 값만 쓴다. Task 2 verify가 빌드에 실제 도메인 주소가 없음을 본다 (06-07) | EV `OK variant fake-only yml=0 d-full=0`. 스크래치 미리보기·변형 빌드에 실제 사업자·지원 값 0 | closed |
| T-06-48 | Repudiation | 원고의 메뉴·요청 이름이 앱 화면이나 운영 절차와 달라(옛 범위 이름, 옛 코스 낱말 등) 사용자가 따라 할 수 없거나 심사가 불일치를 봄 | medium | mitigate | Task 1 `OK draft words`가 메뉴 문구 여섯·「뱃지와 기록 모두 삭제」·「공개하지 않은 코스」·「6개월」의 있음과 옛 낱말·코드 값 일수의 없음을 세고, Task 3이 목록·절차서와 나란히 보여 승인받는다(D-37~D-41) (06-07) | EV `OK draft words … menus=6 oldscope=0 code184=0`. 삭제 안내에 메뉴 문구 여섯, 옛 범위 이름·「184」·「비공개 코스」 0 | closed |
| T-06-22 | Information Disclosure | 개발자 이름 값(개인 이름일 수 있음)이 `.planning`·메시지에 남음 | high | mitigate | `vals` 누출 점검 (a)(b)(c), 문서 커밋은 `.planning` 경로만 `git add`, 기록에는 건수만(prohibition). Task 1이 실행 때 스크래치에서 만든 무작위 가짜 값(계획·기록에 없어 `BASE_SHA`에도 없음)으로 점검이 건너뛰지 않음(`emitted=1`)과 값이 든 `.planning` 시험 객체를 실제로 잡음(`leak-probe hit tree=1 diff=1`)을 먼저 보인다 (06-08) | 가짜 값 시험에서 점검이 실제로 걸림(`leak-probe hit tree=1 diff=1`). 감사자 재계수: BASE..HEAD 메시지 0, Phase 6 추가 줄 1줄(값 받기 전, 기준 커밋에 이미 27개 추적 파일에 있던 문자열 = 공개된 GitHub 조직 이름). NAMES.md 값 칸 「(빈칸)」 | closed |
| T-06-23 | Tampering | 승인하지 않은 값이 커밋됨 | medium | mitigate | 이 계획은 커밋하지 않는다. 미리보기 객체는 브랜치에 없음을 verify가 본다. 커밋은 06-09 승인 뒤 (06-08) | 값 키가 처음 들어간 커밋은 `0c48a11`(PUSH1 승인 범위). 미리보기·시험 객체를 담은 브랜치 0, 원격 ref는 `refs/heads/main` 하나 | closed |
| T-06-24 | Information Disclosure | 개발자 이름 값이 메시지·`.planning`에 섞여 공개 | high | mitigate | Task 1의 범위 누출 점검(메시지·S2 트리의 `.planning`), 메시지 파일에 값을 쓰지 않음(prohibition), 로컬 경로·토큰 꼴 0 (06-09) | EV `NOTE range messages-with-value=0`, `OK localpaths 0`. 감사자 재계수는 T-06-22와 같음 | closed |
| T-06-25 | Tampering | 승인과 다른 SHA가 배포됨 | high | mitigate | 후보는 `commit-tree` 객체이고 승인 뒤 `--ff-only`로만 `main`에 올린다. 푸시 직전 원격이 `PUSH1_PREV`인지 확인하고 훅이 같은 SHA를 점검한다 (06-09) | S2 부모 = S1 `0c48a11`, S1 부모 = `e8448ec3d7a7`. merge 커밋 0(fast-forward). EV `OK origin = push1-prev`, 훅 통과. 승인 SHA = 푸시 SHA | closed |
| T-06-26 | Repudiation | 깨진 삭제 안내가 라이브에 남음 (심사 반려) | high | mitigate | 라이브 다섯 문서 바이트·앵커 판정, FAIL이면 `<rollback_procedure>`로 먼저 되돌린다 (06-09) | 06-09 `<rollback_procedure>`. EV `LIVE_PUSH1=OK`, `LIVE_PUSH2=OK`. 감사 시점 라이브: 5 URL 200·제목 일치, `/data-deletion/` robots 0·임시 표시 0·본문 mailto 2·소개 문단 1·앵커 8 | closed |
| T-06-27 | Denial of Service | 기존 법적 URL 제목·경로 변경 | medium | mitigate | check-site 3번 기대 제목과 라이브 다섯 문서 제목 비교(Ground Rule) (06-09) | `scripts/check-site.sh` 기대 제목(3번 항목). 라이브 제목 5개 일치, 경로 그대로 | closed |
| T-06-39 | Denial of Service | Task 1·2 사이 커밋(실행자의 task별 기록 커밋 등)으로 승인한 후보를 fast-forward할 수 없어 첫 사이트 푸시가 영영 막힘 | high | mitigate | context 「Task 3 fast-forward 전 무커밋」: Task 1·2는 추적 파일을 고치지 않고 기록을 `$W/06-09-pending.md`에 쓴다(커밋할 것이 없음). Task 1 끝·Task 2 묻기 전·Task 3 precondition에서 HEAD가 S1의 부모인지 보고, 아니면 승인·fast-forward 없이 보류 경로로 간다. Task 3 verify가 무커밋 두 줄과 first-parent 사슬로 다시 확인한다 (06-09) | EV `OK nocommit 06-09-t1/t2 head=e8448ec3d7a7`, S1 부모가 그 해시 | closed |
| T-06-28 | Repudiation | 요청 경로나 개발자 이름이 빠진 삭제 안내가 라이브에 오름 (Google Play 요건 위반) | high | mitigate | 8번 항목과 훅. Task 1·2가 음성 시험 객체로 실패를 증명한다 (06-10) | `scripts/check-site.sh` 8번 항목, `.githooks/pre-push`, `core.hooksPath=.githooks`. EV `NEG8_*` 넷 실패·`HOOK8=OK`. 감사자 음성 시험(본문 mailto 삭제·소개 문단 삭제·noindex 추가)도 각각 8번으로 실패 | closed |
| T-06-29 | Tampering | 푸터 mailto 때문에 가드가 거짓 통과 | medium | mitigate | 본문 블록만 본다. Task 1 둘째 verify가 파일 전체 grep 꼴이 없음을 본다(GUARD MUTATION) (06-10) | 8번 항목은 본문 블록(`dd_body`)만 봄. 감사자 시험: 푸터 mailto만 남기면 실패 | closed |
| T-06-30 | Tampering | grep 오류가 「못 찾음」으로 읽혀 가드가 조용히 통과 | medium | mitigate | `dd_rc` 2 이상을 문제로 센다(6·7번과 같은 방식) (06-10) | 8번 항목이 awk 비0 종료와 grep 종료 코드 ≥2를 problem으로 셈 | closed |
| T-06-31 | Tampering | 생성 구간 손 편집으로 원본과 어긋남 | medium | mitigate | 사본 시험 뒤 생성기로만 만들고 Task 2 둘째 verify가 재생성 사본과 바이트 같음을 본다 (06-11) | 감사자가 `generate-claude-md`로 스크래치 사본을 다시 만들어 `.claude/CLAUDE.md`와 바이트 동일. 두 CLAUDE.md 방침 구간 해시 동일 | closed |
| T-06-32 | Information Disclosure | 문서에 개발자 이름 값·로컬 경로 | high | mitigate | 문서 커밋마다 값 누출 점검, Task 3 verify가 `.planning`의 홈 경로 0을 본다. 이름 표 값 칸은 빈칸 유지 (06-11) | Phase 6 추가 줄에 홈 경로 0, NAMES.md 「(빈칸)」, 값 재계수는 T-06-22와 같음 | closed |
| T-06-33 | Repudiation | prod 설정이 삭제 안내 상한을 넘거나 prod 전제가 빠짐 | medium | mitigate | 데이터 목록 「확인할 것」에 「### prod 전제 (Phase 6 D-42)」 절을 가리키는 추적 행을 남긴다(prod 생성 때, Phase 10). 목록을 옮겨 적지 않아 두 곳이 어긋나지 않는다 (06-11) | DATA-INVENTORY 「확인할 것」 행이 prod 전제 절을 가리키고 다섯 줄을 옮겨 적지 않음 | closed |
| T-06-34 | Tampering | 문서·스크립트 푸시가 사이트 출력을 바꿈 | medium | mitigate | Task 1이 후보 빌드와 라이브 S2 빌드의 바이트 같음을, Task 3이 라이브 바이트를 본다 (06-12) | `e9d9443..ae76027`의 `.planning` 밖 변경은 두 CLAUDE.md·README.md·check-site.sh(모두 빌드 제외). EV `OK push2 same-as-s2`, 라이브 `bytes=same` | closed |
| T-06-35 | Information Disclosure | 문서 커밋에 값·로컬 경로가 섞여 공개 | high | mitigate | 기준부터 후보까지 전체 범위 누출 점검(메시지, `.planning`, 06-11이 고친 `CLAUDE.md`·`.claude/CLAUDE.md`·`README.md`)과 로컬 경로·토큰 꼴 0 (06-12) | EV `changed-lines-with-value=0`, `OK localpaths 0`. 감사자 재계수: 메시지 이메일 꼴은 attribution `noreply`뿐, 토큰 꼴 0, 대표자·사업자등록번호·주소 값 0, 지원 주소 Phase 6 추가 줄 0 | closed |
| T-06-36 | Repudiation | 삭제 안내가 데이터 목록에 없는 보존 기간을 약속함 (심사·법적 위험) | high | mitigate | 원고가 쓸 기간 문구를 `PERIOD`·`INUSE` 줄로 고정하고, Task 2 verify가 `INV_DEC_SHA` 목록에서 줄마다 같은 행에 있음을 다시 본다. 06-07은 `INV_DEC_SHA`가 있어야 시작하고 그 문구를 그대로 쓴다 (06-13) | EV `PERIOD_OK=9/9`. 감사자 재확인: 목록 9줄이 행 첫 칸과 같은 줄, 삭제 안내에 9개 문구 각 1회 | closed |
| T-06-37 | Tampering | 실행자가 결정에 없는 값을 목록에 적거나 prod 전제 다섯 줄을 고침 | medium | mitigate | 값은 06-04·06-06 표식에서만 가져오고 빈 표식이면 멈춘다(prohibition). 기준 앱 커밋 줄과 prod 전제 번호 목록이 재기준과 같은지 verify가 본다 (06-13) | 기준 앱 커밋 줄과 prod 전제 다섯 줄의 해시가 `aeb6f44`·`d7dd860`·`a789cf9`·HEAD에서 같음 | closed |
| T-06-38 | Information Disclosure | 공개 데이터 목록·커밋 메시지에 사업자 값·지원 주소 | low | mitigate | 06-01 「값 누출 점검」을 문서 커밋 직전에 돈다. 목록에는 키 이름과 결정 문구만 적는다 (06-13) | DATA-INVENTORY와 작업 13에 사업자 값·지원 주소 0, BASE..HEAD 메시지 0 | closed |
| F-06-05 | Information Disclosure | `.planning/baseline/USER-TASKS.md` 대체 본인 확인 질문 예시 (06-05 SUMMARY Threat Flag, 계획 위협 목록 밖) | low | — (미정) | 절차서 9번 단계: 질문 종류는 알려져 있다고 보고 답을 본인만 알 수 있는 값으로 고름, 「내 계정」 값 대조도 함께 맞아야 삭제. 사이트에는 질문 예시 0건 | 같은 예시가 `06-CONTEXT.md` D-30과 git 이력에도 있어 USER-TASKS에서만 빼도 공개 저장소에서 사라지지 않음. 사용자 수용 기록 없음 | open — below high threshold (non-blocking) |

*Status: open · closed · open — below high threshold (non-blocking)*
*Severity: critical > high > medium > low — only open threats at or above workflow.security_block_on count toward threats_open*
*Disposition: mitigate (implementation required) · accept (documented risk) · transfer (third-party)*

---

## Accepted Risks Log

| Risk ID | Threat Ref | Rationale | Accepted By | Date |
|---------|------------|-----------|-------------|------|
| AR-06-01 | T-06-19 | `mailto:` 값은 운영자가 `_data/company.yml`의 `support_email`에 직접 넣는 고정값이고 사용자 입력이 아니다. 출력은 모두 `\| escape`를 거치고, 감사 시점 값에 헤더 주입 문자(`?` `&` `%` CR LF)가 없다. 주소를 바꾸면 이메일 게이트를 다시 거친다 | 계획 06-07 threat model (disposition accept) | 2026-11-27 |

*Accepted risks do not resurface in future audit runs.*

F-06-05(질문 예시 공개)는 아직 수용 기록이 없다. 수용하면 AR-06-02로 적는다.

---

## Security Audit Trail

| Audit Date | Threats Total | Closed | Open | Run By |
|------------|---------------|--------|------|--------|
| 2026-11-27 | 50 (계획 49 + Flag 1) | 49 | 1 (low, non-blocking) | gsd-security-auditor (ASVS L1) |

참고(판정에 영향 없음):
- 점검 8번은 본문 블록 끝을 레이아웃의 들여쓴 `</div>`로 찾는다. 들여쓰기를 바꾼 시험에서도 실패했지만, 푸터 앞부분에 mailto가 없어서 생긴 결과이고 설계로 보장된 것은 아니다.
- 앱 저장소 HEAD는 기준 앱 커밋 뒤로 커밋 155개가 쌓였다. 삭제 관련 경로 가운데 바뀐 것은 `docs/kit-fork.md`(2줄 추가)와 규칙 테스트 1개다. 기준 고정(D-36) 범위 밖이므로, prod를 만들 때(Phase 10) 인용 행 번호를 다시 확인한다.

---

## Sign-Off

- [x] All threats have a disposition (mitigate / accept / transfer) — F-06-05는 계획 밖 Flag라 처리 방식이 미정(below threshold)
- [x] Accepted risks documented in Accepted Risks Log
- [x] `threats_open: 0` confirmed
- [x] `status: verified` set in frontmatter

**Approval:** verified 2026-11-27

## Security Audit 2026-11-27

| Metric | Count |
|---|---|
| Threats found | 50 |
| Closed | 49 |
| Open | 1 |
