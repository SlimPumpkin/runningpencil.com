# 이름 표 (Names)

**작성일:** 2026-11-15
**기준:** BASE-01 — 서비스명·운영사 표기·도메인·지원 이메일·사업자 값 항목의 정본
**읽는 곳:** Phase 5 `_data`(사업자 정보·지원 이메일), Phase 9 영문판(`/en/`), Phase 10 콘솔·스토어 제출 체크리스트

> 이 저장소(`SlimPumpkin/runningpencil.com`)는 **PUBLIC**입니다. `.planning/`은 사이트에 배포되지 않지만 GitHub에서 누구나 보고, 한 번 커밋한 값은 지워도 이력과 포크에 남습니다. 그래서 사업자 값 칸은 `(빈칸)`으로 두고 값이 들어갈 곳만 적습니다. 실제 값은 사용자가 공개하기로 정한 뒤 Phase 5에서 사이트에 공개하는 커밋에 처음 들어갑니다 (D-18). 다른 문서에서 찾거나 유추해 채우지 않습니다.

| 항목 | 값 | 지금 채우는가 | 들어갈 곳 | 근거 |
|---|---|---|---|---|
| 한글 서비스명 | 러닝펜슬 | 예 | 사이트 전체, 스토어·로그인 동의 화면의 한국어 표시명 | D-18, D-20. 앱의 한국어 앱 이름도 같다 (앱 `lib/l10n/app_ko.arb:4`의 `appTitle`) |
| 영문 서비스명 | RunningPencil | 예 | 영문판(`/en/`), 스토어·로그인 동의 화면의 영어 표시명 | D-18, D-20, `.planning/PROJECT.md` Key Decisions. 앱의 영어 앱 이름도 같다 (앱 `lib/l10n/app_en.arb:4`의 `appTitle`) |
| 운영사 표기(현행) | 슬림펌킨 | 예 | 저작권 표기, 푸터 운영 안내 문장, 법적 페이지의 `(이하 "회사")` 주체 | D-18 |
| 도메인 | `runningpencil.com` | 예 | 사이트 주소, 콘솔의 도메인 칸 (`.planning/baseline/URLS.md`) | D-18 |
| 지원 이메일 | `support@runningpencil.com` | 예 (게이트 2026-11-19 뒤 사이트에 공개) | `_data/company.yml`의 `support_email` (이메일 게이트 뒤) | D-19 |
| 사업자등록증 그대로의 상호 | (빈칸) | 아니요 | `_data/company.yml`의 `trade_name` | D-18, U11 |
| 대표자 | (빈칸) | 아니요 | `_data/company.yml`의 `representative` | D-18, U11 |
| 사업자등록번호 | (빈칸) | 아니요 | `_data/company.yml`의 `biz_reg_no` | D-18, U11 |
| 주소 | (빈칸) | 아니요 | `_data/company.yml`의 `address` | D-18, U11 |
| 영문 법인명 | (빈칸) | 아니요 | `_data/company.yml`에 Phase 9에서 키를 더함, Phase 9 영문판 | D-18, U11 |
| 스토어 개발자 이름 | (빈칸) | 아니요 | Phase 6 삭제 안내 (DEL-02) | D-18 |
| 전화번호 | (빈칸, 이번에는 공개하지 않음) | 아니요 | `_data/company.yml`의 `phone` (칸만, U1) | U1, BIZ-03 |

- 「들어갈 곳」은 Phase 5에서 정했습니다: 파일 `_data/company.yml`, 키는 위 표. 값은 이 표에 적지 않고 사이트 파일에만 둡니다.
- 지원 이메일 주소의 정본은 이 표입니다. 이메일 게이트(2026-11-19)를 지나 `_data/company.yml`의 `support_email`에 들어갔습니다. 주소를 바꾸면 게이트를 다시 거칩니다 (D-19).

## 표시명 규칙

- 스토어와 로그인 동의 화면의 앱 표시명은 서비스명 그대로입니다. 한국어는 「러닝펜슬」, 영어는 「RunningPencil」입니다 (D-20).
- 부제·부가 문구는 이름에 넣지 않고 스토어의 부제 칸에 따로 둡니다.
- 삭제 안내에 스토어에 표시된 앱 이름을 적는 요건(DEL-02)은 이 값을 씁니다.

## 앱 쪽 표시명과 일치 확인

Phase 10에서 스토어 등록명·동의 화면 이름과 대조할 때 아래 앱 저장소(`~/dv/woody/running_pencil`) 위치를 봅니다.

| 대상 | 앱 위치 | 이 표의 값과의 관계 |
|---|---|---|
| 한국어 앱 이름 | `lib/l10n/app_ko.arb:4`의 `appTitle` | 한글 서비스명과 같아야 함 |
| 영어 앱 이름 | `lib/l10n/app_en.arb:4`의 `appTitle` | 영문 서비스명과 같아야 함 |
| dev 빌드 표시명 | `RunningPencil Dev` (앱 `docs/kit-fork.md`) | 개발용이라 스토어·동의 화면에는 쓰지 않음 |
| 일본어 앱 이름 | `lib/l10n/app_ja.arb:4`의 `appTitle` | 참고만. 사이트는 일본어판을 내지 않음 (REQUIREMENTS Out of Scope) |

---
*Names baseline for: 러닝펜슬 웹사이트 심사 대응 (BASE-01)*
*Written: 2026-11-15*
