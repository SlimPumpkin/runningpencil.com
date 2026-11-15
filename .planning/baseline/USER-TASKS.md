# 사용자 작업 절차서 (User Tasks)

**작성일:** 2026-11-15
**기준:** BASE-04 — 사용자가 직접 하는 DNS·메일·콘솔 작업의 절차와 각 작업이 막는 단계
**읽는 사람:** 사용자 (가비아·Google Workspace·Search Console 화면 옆에 띄워 두고 따라 합니다)

> 이 저장소(`SlimPumpkin/runningpencil.com`)는 **PUBLIC**입니다. 콘솔에서 받은 값(도메인 인증 TXT, Search Console TXT, DKIM 공개키)과 화면 캡처를 이 파일에 붙이지 마세요. 한 번 커밋한 값은 지워도 이력과 포크에 남습니다 (D-18). Claude에게 결과를 넘길 때도 토큰과 키 값은 넘기지 않고, 「들어갔다/확인됨」 같은 상태와 값을 가린 `dig` 결과만 넘깁니다.
>
> 이 문서는 사용자가 하는 일을 적습니다. Claude는 DNS와 콘솔을 바꾸지 않습니다. 이 문서는 레코드 **추가**만 안내하며, 기존 레코드를 지우거나 고치라는 단계는 없습니다.

지원 메일은 `runningpencil.com`을 슬림펌킨의 Google Workspace에 **사용자 별칭 도메인**(User alias domain)으로 붙여 받습니다. 지원 주소는 `support@runningpencil.com`이고, 답장도 이 주소에서 보냅니다 (D-10, D-11, D-19). 주소 표기는 이름 표(`.planning/baseline/NAMES.md`)를 따릅니다.

## 한눈에 보기

| 작업 | 누가 | 막는 단계 | 언제 시작 | 대기 시간 |
|---|---|---|---|---|
| 작업 0 — 변경 전 기록 | 사용자 | Phase 5 | 지금 | 없음 |
| 작업 1 — Workspace에 사용자 별칭 도메인 추가 | 사용자 | Phase 5 | 작업 0 뒤 | 없음 |
| 작업 2 — 가비아 DNS 1차 방문 | 사용자 | Phase 5 | 작업 1 직후 (인증 TXT를 받은 뒤) | MX 최대 72시간, SPF 최대 48시간 |
| 작업 3 — 도메인 인증 완료·Gmail 켜기·`support` 주소 만들기 | 사용자 | Phase 5 | 작업 2의 레코드가 반영된 뒤 | 별칭 반영 최대 24시간 |
| 작업 4 — 외부 4곳 수신 시험 | 사용자 시험 → Claude가 기록 확인 | Phase 5 이메일 게이트, Phase 6·7 커밋의 전제 | 작업 3 뒤 | Gmail 켠 뒤 48~72시간 안에 도착하지 않으면 점검 |
| 작업 5 — 지원 주소로 보내기 설정 | 사용자 | Phase 5, Phase 10 | 작업 4 통과 뒤 | 확인 메일 도착까지 |
| 작업 6 — DKIM과 가비아 DNS 2차 방문 | 사용자 | Phase 10 Apple 릴레이, D-11 | 작업 3에서 Gmail을 켠 뒤 24~72시간 | 적용 최대 48시간 |
| 작업 7 — Search Console 도메인 속성 확인 | 사용자 | Phase 5 SITE-03 | 작업 2의 TXT가 반영된 뒤 | TXT 반영까지 |
| 작업 8 — GitHub Pages 도메인 인증 상태 확인 | 사용자 | 권장 (막는 단계 없음) | 언제든 | 없음 |
| 작업 9 — 사업자 값 준비 | 사용자 | Phase 5·8·9 | 지금 | 없음 |
| 작업 10 — 앱 화면 캡처 | 사용자 | Phase 4 | 지금 | 없음 |
| 작업 11 — CLI 재로그인 | 사용자 | Phase 1 계획 01-08 | 지금 | 없음 |
| 작업 12 — 콘솔에서만 보이는 값 확인 | 사용자 | Phase 6·7 | 지금 | 없음 |

DNS·메일 작업(작업 0~7)은 Phase 2~4와 병행해 지금 시작할 수 있습니다. 이메일 게이트는 작업 4에서 열리며, DKIM(작업 6)을 기다리지 않아도 됩니다.

## 보존할 기존 레코드

`runningpencil.com`의 가비아 DNS에는 이미 아래 레코드가 있습니다 (2026-11-14 `dig` 확인). 모두 그대로 둡니다.

| 호스트 | 유형 | 용도 | 처리 |
|---|---|---|---|
| `@` | A ×4 (`185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`) | GitHub Pages가 사이트를 서빙 | 그대로 둡니다 |
| `www` | CNAME (`slimpumpkin.github.io`) | `www` 주소를 GitHub Pages로 연결 | 그대로 둡니다 |
| 앱 경로 라우터용 A 레코드 1개 (가비아 화면에서 확인, 앱 저장소 `infra/router/RUNBOOK.md` 참고) | A | 앱의 경로 스냅(자체 라우터) 진입점 | 그대로 둡니다 |
| `_github-pages-challenge-SlimPumpkin` | TXT | GitHub Pages 도메인 인증 | 그대로 둡니다 (새로 추가하지도 않습니다) |

지우는 레코드는 없습니다. 이유는 세 가지입니다.

- 현재 `runningpencil.com`에는 MX가 없어서 지울 MX도 없습니다. Google 문서의 「다른 MX 레코드는 지운다」는 이 도메인에 해당하지 않습니다.
- 라우터용 A 레코드를 지우면 앱의 경로 스냅이 멈춥니다. 가비아 화면에서 낯선 하위 도메인 레코드가 보여도 정리하지 마세요.
- `_github-pages-challenge-SlimPumpkin` TXT를 지우면 GitHub Pages 도메인 인증이 풀립니다.

## 작업 0 — 변경 전 기록

**막는 단계:** Phase 5 (이후 모든 DNS 작업의 되돌림 기준)

**순서:**
1. MY가비아 > 서비스 관리 > DNS관리툴에서 `runningpencil.com`의 레코드 화면을 엽니다.
2. 현재 레코드 전체를 화면 캡처합니다. 캡처는 **저장소 밖**(개인 PC나 개인 드라이브)에 보관하고 이 저장소에는 넣지 않습니다.
3. 아래 「변경 전후 dig 명령」을 터미널에서 돌려 결과를 저장소 밖 메모에 적어 둡니다.
4. 라우터용 A 레코드의 호스트 이름을 가비아 화면에서 확인하고, 같은 메모에 `dig +short <라우터 호스트> A` 결과도 적습니다.

**레코드 표:** 해당 없음 (추가·변경 없음, 「보존할 기존 레코드」 표와 캡처를 대조만 합니다)

**변경 전후 dig:** 「변경 전후 dig 명령」의 블록을 그대로 돌립니다. 변경 전 기대 결과는 다음과 같습니다.

| 명령 | 변경 전 기대 결과 |
|---|---|
| `dig +short runningpencil.com A` | GitHub Pages 4개 |
| `dig +short www.runningpencil.com CNAME` | `slimpumpkin.github.io.` |
| `dig +short <라우터 호스트> A` | 값 1개 있음 |
| `dig +short _github-pages-challenge-SlimPumpkin.runningpencil.com TXT` | 값 1개 있음 |
| `dig +short runningpencil.com MX` | 출력 없음 |
| `dig +short runningpencil.com TXT` | 출력 없음 |
| `dig +short google._domainkey.runningpencil.com TXT` | 출력 없음 |

**끝났는지 확인:** 캡처 파일이 저장소 밖에 있고, 메모에 위 일곱 명령의 결과가 있으며, 캡처의 레코드가 「보존할 기존 레코드」 표의 네 종류와 맞습니다.

**Claude에게 넘길 것:** 「작업 0 끝남」 한 줄과, 캡처에서 「보존할 기존 레코드」 표에 없는 레코드가 보였는지 여부. 캡처 파일과 TXT 값은 넘기지 않습니다.

## 작업 1 — Workspace에 사용자 별칭 도메인 추가

**막는 단계:** Phase 5

**순서:**
1. Google 관리 콘솔(Admin console)에 슬림펌킨 최고 관리자로 로그인합니다.
2. Account(계정) > Domains(도메인) > Manage domains(도메인 관리) > Add a domain(도메인 추가)를 누릅니다.
3. 도메인 이름에 `runningpencil.com`을 넣고, 유형은 **User alias domain(사용자 별칭 도메인)**을 고릅니다. **Secondary domain(보조 도메인)을 고르지 않습니다.** 보조 도메인은 그 도메인에 만드는 사용자 계정마다 과금되고, 사용자 별칭 도메인은 사용자·그룹당 추가 비용이 없습니다.
4. Add domain & start verification(도메인 추가 및 인증 시작)을 누릅니다.
5. 콘솔이 보여 주는 도메인 인증용 TXT 값을 확인합니다. 이 값은 작업 2에서 가비아에 넣습니다. 이 파일에는 적지 않습니다.

부수 효과: `runningpencil.com`을 사용자 별칭 도메인으로 붙이면 슬림펌킨의 **모든 사용자와 그룹**이 같은 이름의 `@runningpencil.com` 주소를 함께 받습니다 (공식 문서 명시). 예를 들어 운영자 계정이 받는 메일은 `@runningpencil.com` 쪽 주소로 와도 같은 받은편지함에 도착합니다.

**레코드 표:** 해당 없음 (콘솔 작업. 인증 TXT는 작업 2의 레코드 표에 있습니다)

**변경 전후 dig:** 해당 없음

**끝났는지 확인:** Manage domains 목록에 `runningpencil.com`이 User alias domain 유형으로 보이고, 상태가 인증 대기(또는 인증 진행 중)입니다.

**Claude에게 넘길 것:** 「작업 1 끝남, 유형 User alias domain」 한 줄. 인증 TXT 값은 넘기지 않습니다.

## 작업 2 — 가비아 DNS 1차 방문

**막는 단계:** Phase 5

**순서:**
1. Search Console(https://search.google.com/search-console)에서 속성 추가 > **도메인**(Domain) 유형으로 `runningpencil.com`을 넣고, 소유권 확인용 TXT 값을 받습니다. 확인 버튼은 아직 누르지 않습니다 (작업 7에서 누릅니다).
2. MY가비아 > 서비스 관리 > DNS관리툴 > `runningpencil.com` 설정 > 레코드 추가를 엽니다.
3. 아래 레코드 표의 네 행을 하나씩 추가합니다. 호스트 칸에는 `@`를 넣습니다. 오류가 나면 가비아 화면의 안내를 따릅니다 (빈칸을 요구할 수 있습니다).
4. **콘솔 안내값과 대조:** MX와 SPF는 Workspace 관리 콘솔(또는 Google 도움말)이 보여 주는 안내값과 아래 표의 값이 같은지 대조합니다. 콘솔에 보이는 값이 이 표와 다르면 **콘솔의 값을 따르고** Claude에게 다르다고 알려 주세요.
5. SPF 레코드(`v=spf1`로 시작하는 TXT)는 **하나만** 둡니다. 같은 호스트에 `v=spf1` TXT가 둘 이상이면 SPF가 실패합니다.
6. 저장합니다. 「보존할 기존 레코드」의 네 종류는 건드리지 않습니다.

**레코드 표:**

| 호스트 | 유형 | 값 | 용도 |
|---|---|---|---|
| `@` | TXT | 콘솔에서 복사 (Workspace 관리 콘솔, 작업 1) | Workspace 도메인 인증 |
| `@` | MX | 우선순위 `1`, 값 `smtp.google.com.` | Workspace로 메일 받기. 가비아는 MX 값 끝에 마침표를 요구합니다 (Google 문서도 등록기관이 원하면 `smtp.google.com` 끝에 마침표를 붙이라고 합니다). 반영 최대 72시간 |
| `@` | TXT | `v=spf1 include:_spf.google.com ~all` | SPF (한 개만). 반영 최대 48시간 |
| `@` | TXT | 콘솔에서 복사 (Search Console, 순서 1) | Search Console 도메인 속성 소유권 확인. 확인 뒤에도 지우지 않습니다 |

Workspace 인증 TXT와 Search Console TXT는 둘 다 `google-site-verification=…` 꼴이고, 루트 호스트에 서로 다른 TXT 레코드로 함께 둘 수 있습니다. 두 값이 같으면 한 개만 넣습니다. SPF TXT와도 함께 있을 수 있습니다.

**변경 전후 dig:** 반영 뒤 「변경 전후 dig 명령」을 다시 돌립니다.

| 명령 | 변경 전 | 변경 후 기대 |
|---|---|---|
| `dig +short runningpencil.com MX` | 출력 없음 | `1 smtp.google.com.` |
| `dig +short runningpencil.com TXT` | 출력 없음 | `v=spf1 include:_spf.google.com ~all` **한 줄**과 `google-site-verification=…` 1~2줄 |
| `dig +short runningpencil.com A` | GitHub Pages 4개 | 그대로 |
| `dig +short www.runningpencil.com CNAME` | `slimpumpkin.github.io.` | 그대로 |
| `dig +short <라우터 호스트> A` | 값 1개 있음 | 그대로 |
| `dig +short _github-pages-challenge-SlimPumpkin.runningpencil.com TXT` | 값 1개 있음 | 그대로 |

**끝났는지 확인:** MX가 `1 smtp.google.com.` 하나로 나오고, TXT 결과에 `v=spf1` 줄이 정확히 하나 있으며, 기존 네 종류의 결과가 작업 0의 메모와 같습니다.

**Claude에게 넘길 것:** 변경 후 `dig` 결과. `google-site-verification=` 뒤의 값은 `…`로 가려서 넘깁니다. 콘솔 안내값이 표와 달랐다면 어느 값이 달랐는지 알려 주세요.

## 작업 3 — 도메인 인증 완료·Gmail 켜기·`support` 주소 만들기

**막는 단계:** Phase 5

**순서:**
1. 관리 콘솔 Account > Domains > Manage domains에서 `runningpencil.com`의 인증을 마칩니다 (작업 2의 인증 TXT가 반영된 뒤 인증 버튼을 누릅니다).
2. 인증되면 같은 화면에서 `runningpencil.com`의 Activate Gmail(Gmail 활성화)을 누르고 화면의 안내를 따릅니다. **이 시각을 적어 둡니다** (작업 6은 이 시각부터 24~72시간 뒤에 할 수 있습니다).
3. `support` 주소를 만듭니다. **1순위: 사용자 이메일 별칭.** 관리 콘솔 Directory(디렉터리) > Users(사용자) > 운영자 계정 > Add Alternate Emails(대체 이메일 추가)에서 별칭 이름에 `support`를 넣습니다. 그러면 기본 도메인의 별칭 `support@slimpumpkin.com`이 생기고, 별칭 도메인의 짝 주소 `support@runningpencil.com`도 함께 받게 되는 것으로 보입니다. 반영에는 최대 24시간이 걸립니다.
4. 화면에서 두 가지를 확인합니다. (가) 별칭 추가 화면의 도메인 선택에 `runningpencil.com`이 따로 보이는지 (공식 문서는 「사용자 별칭 도메인은 도메인 메뉴에 나오지 않는다」고 적습니다). (나) `support@runningpencil.com`만 단독으로 만들 수 있는지. 확인한 결과를 Claude에게 넘깁니다.
5. 작업 4의 수신 시험으로 1순위가 동작하는지 확정합니다.

**2순위 분기 (작업 4가 실패하면):** 운영자 계정의 `support` 별칭(1순위)을 지운 뒤, 관리 콘솔(또는 groups.google.com)에서 Google 그룹 `support@slimpumpkin.com`을 만들고, 그룹 설정에서 조직 밖 발신자의 게시를 허용합니다 (「웹의 모든 사용자」가 게시할 수 있게). 운영자를 그룹 구성원으로 넣습니다. 그룹은 별칭 도메인 주소 `support@runningpencil.com`을 받는다고 공식 문서에 명시돼 있습니다. 그다음 작업 4를 다시 합니다. 한 주소는 한 곳에서만 쓸 수 있으므로, 그룹을 만들기 전에 1순위 별칭을 먼저 지웁니다.

**레코드 표:** 해당 없음 (콘솔 작업)

**변경 전후 dig:** 해당 없음 (작업 2의 결과가 그대로인지만 봅니다)

**끝났는지 확인:** Manage domains에서 `runningpencil.com`이 인증됨이고 Gmail이 활성화돼 있으며, 운영자 계정의 대체 이메일 목록(또는 그룹 목록)에 `support`가 있습니다.

**Claude에게 넘길 것:** Gmail을 켠 시각(날짜와 시각만), 1순위·2순위 가운데 무엇을 썼는지, 순서 4의 (가)·(나) 확인 결과. 운영자 개인 계정 주소는 넘기지 않습니다.

## 작업 4 — 외부 4곳 수신 시험

**막는 단계:** Phase 5 이메일 게이트 (Phase 5 완료, Phase 6·7 커밋, 콘솔 등록의 전제)

**순서:**
1. 외부 메일 서비스 네 곳 **Gmail, 네이버, iCloud, Outlook**의 개인 계정에서 각각 한 통씩 `support@runningpencil.com`으로 시험 메일을 보냅니다. 제목에 보낸 서비스 이름을 넣으면 구분이 쉽습니다 (예: 「수신 시험 — 네이버」).
2. 운영자 받은편지함에서 네 통이 도착했는지 봅니다. 받은편지함에 없으면 스팸함도 봅니다.
3. 아래 「수신 시험 기록 양식」 표를 저장소 밖 메모에 복사해 채웁니다. **보낸 사람의 개인 주소는 적지 않습니다.** 서비스 이름과 시각만 적습니다.
4. 통과 조건은 **네 통 모두 운영자 받은편지함에 도착**하는 것입니다. 한 통이라도 오지 않으면 작업 2의 MX와 작업 3의 별칭을 점검하고, 1순위 별칭이 원인이면 작업 3의 2순위 분기로 넘어간 뒤 다시 시험합니다. Gmail을 켠 뒤 48~72시간이 지나도 오지 않으면 도메인 인증과 MX를 확인합니다.

이 작업이 이메일 게이트입니다. 통과 전에는 지원 주소를 사이트의 HTML과 `_data`에 넣지 않습니다 (D-19). 통과 기록을 Claude가 확인한 뒤 Phase 5에서 처음 사이트에 들어갑니다.

**레코드 표:** 해당 없음

**변경 전후 dig:** 해당 없음 (실패하면 작업 2의 `dig +short runningpencil.com MX`를 다시 돌립니다)

**끝났는지 확인:** 기록 표의 네 행이 모두 채워져 있고, 「스팸함 여부」까지 포함해 네 통 모두 운영자 받은편지함에 도착했습니다.

**Claude에게 넘길 것:** 채운 「수신 시험 기록 양식」 표 (보낸 서비스, 보낸 시각, 도착 시각, 스팸함 여부, 비고). 보낸 사람 주소와 메일 본문은 넘기지 않습니다.

## 작업 5 — 지원 주소로 보내기 설정

**막는 단계:** Phase 5, Phase 10 (지원 주소로 답장, D-11)

**순서:**
1. 운영자 계정으로 Gmail을 열고 Settings(설정) > See all settings(모든 설정 보기) > Accounts(계정, 계정 및 가져오기) > Send mail as(다른 주소에서 메일 보내기)에서 다른 이메일 주소 추가를 누릅니다.
2. 주소에 `support@runningpencil.com`을 넣고 **Treat as an alias(별칭으로 처리)**를 켭니다.
3. 화면의 확인 절차를 마칩니다 (확인 메일이 오면 그 안의 링크나 코드를 씁니다).
4. 새 메일 작성 화면의 From(보낸사람)에서 `support@runningpencil.com`을 고를 수 있는지 봅니다.

**레코드 표:** 해당 없음

**변경 전후 dig:** 해당 없음

**끝났는지 확인:** Send mail as 목록에 `support@runningpencil.com`이 있고, 이 주소로 외부 계정(작업 4에서 쓴 계정 하나)에 보낸 답장의 보낸사람이 `support@runningpencil.com`으로 보입니다.

**Claude에게 넘길 것:** 「작업 5 끝남, From 선택 가능」 한 줄과, 외부 계정에서 본 보낸사람 표시가 지원 주소였는지 여부.

## 작업 6 — DKIM과 가비아 DNS 2차 방문

**막는 단계:** Phase 10 Apple 릴레이 답장의 전제, D-11 (지원 주소로 답장)

**순서:**
1. 작업 3에서 Gmail을 켠 뒤 **24~72시간**이 지났는지 확인합니다. 그 전에는 DKIM 키를 받을 수 없습니다.
2. 관리 콘솔 Apps(앱) > Google Workspace > Gmail > Authenticate email(이메일 인증)을 엽니다.
3. Selected domain(선택한 도메인)에서 `runningpencil.com`을 고릅니다. **도메인 목록에 `runningpencil.com`이 없으면 여기서 멈추고 Claude에게 알립니다** (별칭 도메인에 DKIM을 걸 수 있는지는 화면에서만 확인할 수 있습니다. 목록에 없으면 지원 주소로 답장하기와 Phase 10 Apple 릴레이 계획을 다시 정해야 합니다).
4. Generate New Record(새 레코드 생성)를 누릅니다. 기본 선택자(prefix)는 `google`이고, 키 길이는 기본값(2048비트)으로 둡니다.
5. 콘솔이 보여 주는 TXT 호스트와 값을 확인합니다. **콘솔 안내값과 대조:** 호스트가 아래 표의 `google._domainkey`와 같은지 봅니다. 콘솔에 보이는 값이 이 표와 다르면 **콘솔의 값을 따르고** Claude에게 다르다고 알려 주세요.
6. MY가비아 > 서비스 관리 > DNS관리툴 > `runningpencil.com` 설정 > 레코드 추가에서 아래 표의 레코드를 추가합니다. 값이 길어 **저장이 거부되면** 관리 콘솔로 돌아가 키 길이를 **1024**비트로 바꿔 Generate New Record로 다시 만든 뒤 그 값을 넣습니다.
7. 반영된 뒤 관리 콘솔의 같은 화면에서 Start authentication(인증 시작)을 누릅니다. 적용에는 최대 48시간이 걸립니다.
8. 지원 주소(`support@runningpencil.com`, 작업 5의 From)에서 다른 Gmail 주소로 메일을 보내고, 받은 쪽에서 원본 보기(Show original)로 헤더에 `DKIM=pass`가 있는지 봅니다.

**레코드 표:**

| 호스트 | 유형 | 값 | 용도 |
|---|---|---|---|
| `google._domainkey` | TXT | 콘솔에서 복사 (Workspace 관리 콘솔 Authenticate email) | `runningpencil.com` DKIM 서명 확인 (지원 주소로 답장, Apple 릴레이) |
| `_dmarc` | TXT | 선택 항목. 넣는다면 정책 값은 Claude와 정한 뒤 넣습니다 | DMARC. 이번 단계에 필요한지는 확인하지 않았습니다 |

**변경 전후 dig:**

| 명령 | 변경 전 | 변경 후 기대 |
|---|---|---|
| `dig +short google._domainkey.runningpencil.com TXT` | 출력 없음 | `v=DKIM1; k=rsa; p=…` (값은 콘솔이 만든 것과 같음) |
| `dig +short runningpencil.com TXT` | 작업 2 뒤 결과 | 그대로 (`v=spf1` 한 줄 유지) |
| `dig +short runningpencil.com MX` | `1 smtp.google.com.` | 그대로 |

**끝났는지 확인:** 관리 콘솔의 Authenticate email 화면에서 `runningpencil.com`이 인증 중(Authenticating email)으로 바뀌었고, 다른 Gmail 주소에서 본 헤더에 `DKIM=pass`가 있습니다.

**Claude에게 넘길 것:** 헤더 확인 결과(`DKIM=pass` 여부와 서명 도메인이 `runningpencil.com`인지), 키 길이(2048 또는 1024), 도메인 목록에 `runningpencil.com`이 있었는지. DKIM 공개키(`p=` 뒤의 값)와 메일 헤더 원문은 넘기지 않습니다.

## 작업 7 — Search Console 도메인 속성 확인

**막는 단계:** Phase 5 SITE-03 (Google OAuth 브랜드 검증의 전제)

**순서:**
1. 작업 2의 Search Console TXT가 반영됐는지 `dig +short runningpencil.com TXT`로 봅니다.
2. Search Console에서 작업 2의 순서 1에서 시작한 `runningpencil.com` 도메인 속성의 확인(Verify) 버튼을 누릅니다.
3. 실패하면 TXT 반영을 더 기다린 뒤 다시 누릅니다.

**레코드 표:** 해당 없음 (TXT는 작업 2에서 이미 넣었습니다)

**변경 전후 dig:** `dig +short runningpencil.com TXT`의 결과에 `google-site-verification=…` 줄이 있는지 봅니다 (작업 2의 변경 후 기대와 같음).

**끝났는지 확인:** Search Console의 속성 설정 > 소유권 확인 화면에서 `runningpencil.com` 도메인 속성이 확인됨(Verified)으로 보입니다.

**Claude에게 넘길 것:** 「작업 7 끝남, 도메인 속성 확인됨」 한 줄과 확인된 날짜. TXT 값은 넘기지 않습니다.

## 작업 8 — GitHub Pages 도메인 인증 상태 확인

**막는 단계:** 권장 (막는 단계 없음. 도메인 탈취 방지)

**순서:**
1. GitHub 조직 `SlimPumpkin`의 Settings(설정) > Pages를 엽니다 (조직 설정의 Verified domains 쪽).
2. `runningpencil.com`이 Verified(인증됨)로 보이는지 확인합니다.
3. `_github-pages-challenge-SlimPumpkin` TXT는 이미 DNS에 있으므로 **새로 추가하지 않습니다.** Verified가 아니면 화면이 보여 주는 안내를 Claude에게 알려 주세요 (값은 넘기지 않습니다).

**레코드 표:** 해당 없음 (challenge TXT는 「보존할 기존 레코드」에 있습니다)

**변경 전후 dig:** `dig +short _github-pages-challenge-SlimPumpkin.runningpencil.com TXT`가 값 1개를 돌려주는지 봅니다 (변경하지 않으므로 전후가 같아야 합니다).

**끝났는지 확인:** 조직 설정의 Pages 화면에 `runningpencil.com`이 Verified로 보입니다.

**Claude에게 넘길 것:** Verified 여부 한 줄. Verified가 아니면 화면에 보인 상태 문구.

## 작업 9 — 사업자 값 준비

**막는 단계:** Phase 5·8·9 (U11. 푸터 사업자 정보, 위치약관, 영문판)

**순서:**
1. 사업자등록증을 꺼내 아래 일곱 항목을 준비합니다. 항목 이름은 이름 표(`.planning/baseline/NAMES.md`)의 사업자 값 항목과 같습니다.
   - 사업자등록증 그대로의 상호
   - 대표자
   - 사업자등록번호
   - 주소
   - 영문 법인명
   - 스토어 개발자 이름
   - 전화번호
2. 값은 사업자등록증의 표기를 **글자 그대로** 옮깁니다 (띄어쓰기, 괄호, 「주식회사」 위치까지). 영문 법인명과 스토어 개발자 이름은 사업자등록증에 없으므로, 이미 스토어·콘솔에 등록한 표기가 있으면 그것을 씁니다.
3. 주소가 자택이면 사이트에 공개할지, 공개한다면 어디까지 적을지를 **사용자가 먼저 정합니다.** 이 값은 사이트 푸터에 공개되고 한 번 공개하면 되돌리기 어렵습니다.
4. 값은 **지금 이 저장소에 커밋하지 않습니다.** 이 파일과 이름 표에도 적지 않습니다 (D-18). Phase 5가 시작되면 Claude에게 넘기고, 사이트에 공개하는 커밋에 처음 들어갑니다.
5. 전화번호는 이번에 공개하지 않습니다 (U1). 칸만 마련하고, 법률 확인이나 심사에서 요구하면 그때 값을 넣습니다.

값이 오기 전에는 해당 푸터 행과 법적 페이지의 문단이 숨겨집니다 (render-if-present). 그래서 값이 늦어도 사이트 구조 작업은 먼저 진행되지만, Phase 5·8·9는 값이 들어와야 끝납니다.

**레코드 표:** 해당 없음

**변경 전후 dig:** 해당 없음

**끝났는지 확인:** 일곱 항목(전화번호는 비공개 결정 포함)이 저장소 밖 메모에 사업자등록증 표기 그대로 있고, 주소 공개 범위를 정했습니다.

**Claude에게 넘길 것:** Phase 5 시작 때 일곱 항목의 값과 주소 공개 범위 결정. 그 전에는 「준비됨」 한 줄만 넘기고 값은 넘기지 않습니다.

## 작업 10 — 앱 화면 캡처

**막는 단계:** Phase 4 (랜딩·지원 페이지의 앱 화면)

**순서:**
1. 출시 범위의 기능만 보이는 앱 화면을 캡처합니다 (예: 코스 둘러보기, 코스 기록 중, 완주 뱃지).
2. 다음 화면은 쓰지 않습니다.
   - 포인트, 굿즈, 코스북 화면 (출시 범위 밖, U10)
   - dev 빌드 표시가 보이는 화면 (앱 이름 뒤의 Dev, 예: `RunningPencil Dev`)
3. 개인 정보(실명, 계정 주소, 집 근처 위치 기록)가 화면에 보이지 않게 시험 계정과 시험 경로로 찍습니다.
4. 캡처 파일은 이 저장소에 직접 넣지 않고 Claude에게 넘깁니다. 사이트에 넣을 파일은 Phase 4에서 Claude가 정리해 커밋합니다.

**레코드 표:** 해당 없음

**변경 전후 dig:** 해당 없음

**끝났는지 확인:** 캡처마다 포인트·굿즈·코스북 화면과 Dev 표시가 없고, 개인 정보가 보이지 않습니다.

**Claude에게 넘길 것:** 캡처 파일과, 각 화면이 무엇인지 한 줄 설명 (예: 「코스 기록 중 — 진행률과 지도」).

## 작업 11 — CLI 재로그인

**막는 단계:** Phase 1 계획 01-08 (데이터 목록의 「CLI 미확인」 칸 채우기)

**순서:**
1. 터미널에서 아래 두 명령을 실행하고 브라우저에서 슬림펌킨 계정으로 로그인합니다.

   ```bash
   gcloud auth login
   firebase login --reauth
   ```

2. 로그인이 끝나면 Claude에게 알립니다.

목적은 dev 프로젝트의 리전, Firestore TTL 정책, 백업 일정, Storage 버킷 위치를 **읽기 전용으로** 조회해 데이터 목록(`.planning/baseline/DATA-INVENTORY.md`)의 「CLI 미확인」 칸을 채우는 것입니다. Claude는 `list`·`describe`·`get` 계열 명령만 쓰고, 설정을 바꾸거나 배포하거나 리소스를 만들고 지우는 명령은 쓰지 않습니다 (D-06).

이 작업을 하지 않아도 단계는 그대로 끝납니다. 그 경우 해당 칸은 「CLI 미확인」으로 남습니다.

**레코드 표:** 해당 없음

**변경 전후 dig:** 해당 없음

**끝났는지 확인:** `gcloud auth list`에 활성 계정이 보이고, `firebase projects:list`가 재인증 요청 없이 프로젝트 목록을 돌려줍니다.

**Claude에게 넘길 것:** 「작업 11 끝남」 한 줄. 계정 주소와 자격 증명 파일은 넘기지 않습니다.

## 작업 12 — 콘솔에서만 보이는 값 확인

**막는 단계:** Phase 6·7 (삭제 안내, 개인정보처리방침)

**순서:** 아래 값은 앱 코드에 없고 콘솔이나 앱 계획에만 있어서 Claude가 확인할 수 없습니다. 하나씩 확인합니다.
1. Google Analytics 데이터 보관 설정: Google Analytics > Admin(관리) > Data settings(데이터 설정) > Data retention(데이터 보관)에서 이벤트 데이터 보관 기간을 봅니다.
2. 제공자별 동의항목의 필수·선택: 카카오, 네이버, LINE, Meta, Google 콘솔에서 로그인 동의 화면에 어떤 항목을 필수·선택으로 받는지 봅니다.
3. Facebook SDK의 실제 전송 여부: Meta Events Manager에서 앱 이벤트가 실제로 들어오는지 봅니다.
4. 마케팅 푸시 발송 계획: 마케팅(광고성) 푸시를 보낼 계획이 있는지 정합니다.
5. 익명 사용자의 탈퇴 경로: 둘러보기(익명 로그인) 사용자가 앱에서 데이터를 지우는 방법이 있는지 앱 화면에서 봅니다.

**레코드 표:** 해당 없음

**변경 전후 dig:** 해당 없음

**끝났는지 확인:** 위 다섯 항목마다 「확인한 값」 또는 「정함/안 정함」이 저장소 밖 메모에 있습니다.

**Claude에게 넘길 것:** 다섯 항목의 확인 결과. 넘기면 데이터 목록(`.planning/baseline/DATA-INVENTORY.md`)의 「미확인」 칸에 반영됩니다. 콘솔의 앱 키, 계정 주소, 화면 캡처는 넘기지 않습니다.

## 변경 전후 dig 명령

작업 0(변경 전)과 작업 2·6(변경 후)에서 같은 명령을 돌려 결과를 저장소 밖 메모에 적습니다. 토큰 값은 저장소에 커밋하지 않습니다.

```bash
# 변경 전·후에 같은 명령을 돌려 결과를 메모에 붙인다 (토큰 값은 저장소에 커밋하지 않는다)
for q in "runningpencil.com A" "runningpencil.com MX" "runningpencil.com TXT" \
         "www.runningpencil.com CNAME" "google._domainkey.runningpencil.com TXT" \
         "_github-pages-challenge-SlimPumpkin.runningpencil.com TXT"; do
  echo "== $q"; dig +short ${=q}
done
```

`${=q}`는 zsh의 단어 분리 표기입니다. macOS 기본 셸인 zsh는 `$q`를 자동으로 나누지 않아서, 그냥 `$q`라고 쓰면 `dig`가 빈 이름 오류를 냅니다. bash에서 돌린다면 `${=q}` 대신 `$q`를 씁니다.

라우터용 A 레코드는 위 블록에 넣지 않았습니다 (공개 저장소라 호스트 이름을 적지 않습니다). 가비아 화면에서 본 호스트 이름을 직접 넣어 따로 확인합니다.

```bash
dig +short <라우터 호스트> A
# 변경 전후 모두 값 1개가 나와야 한다
```

모든 작업이 끝난 뒤 사이트가 HTTPS로 그대로 열리는지 확인합니다.

```bash
curl -sI https://runningpencil.com/ | head -1
# HTTP/2 200 이 나오면 통과
```

## 수신 시험 기록 양식

작업 4에서 이 표를 저장소 밖 메모에 복사해 채웁니다. 보낸 사람의 개인 주소는 적지 않습니다.

| 보낸 서비스 | 보낸 시각 | 도착 시각 | 스팸함 여부 | 비고 |
|---|---|---|---|---|
| Gmail | | | | |
| 네이버 | | | | |
| iCloud | | | | |
| Outlook | | | | |

---
*User tasks baseline for: 러닝펜슬 웹사이트 심사 대응 (BASE-04)*
*Written: 2026-11-15*
