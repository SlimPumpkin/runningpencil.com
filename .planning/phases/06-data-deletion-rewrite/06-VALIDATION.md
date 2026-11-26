---
phase: "6"
slug: "data-deletion-rewrite"
# status lifecycle: draft (seeded by plan-phase) → validated (set by validate-phase §6)
# audit-milestone §5.5 distinguishes NOT-VALIDATED (draft) from PARTIAL (validated + nyquist_compliant: false) (#2117)
status: draft
nyquist_compliant: false
wave_0_complete: false
created: "2026-11-20"
---

# Phase 6 — Validation Strategy

> Per-phase validation contract for feedback sampling during execution.
> 근거: `06-RESEARCH.md` 「Validation Architecture」. 이 저장소에는 테스트 러너가 없으므로 셸·CLI 명령과 스크래치 Playwright로 검증합니다. 스크래치 도구(`$W`, 저장소 옆 `<저장소 폴더 이름>-p6-scratch`, 임시 폴더 밖)는 커밋하지 않고 단계 검증 뒤에 지웁니다.
> **D-02(Phase 5)·D-18:** 사업자 값, 지원 이메일 주소, 스토어 개발자 이름 값은 이 파일을 포함한 `.planning/` 어디에도, 커밋 메시지에도 적지 않습니다. 판정 기록에는 「있다/없다」, 건수, 사용자 대조 결과만 남깁니다. 값은 `_data/company.yml` 키 이름으로만 가리킵니다.

---

## Test Infrastructure

| Property | Value |
|----------|-------|
| **Framework** | `scripts/check-site.sh`(빌드 + 7항목, 이 단계 끝에 삭제 안내 가드를 별도 build 커밋으로 추가) + 스크래치 `lib.sh`(Phase 5 함수 재사용, `doc` 추가) + Playwright 1.59.1 스크래치 스크립트 `p6-deletion.mjs`(Chromium·WebKit × 375×812·1280×800, pnpm, 커밋 안 함) |
| **Config file** | `scripts/check-site.sh`의 `EXPECTED_TITLES`(바꾸지 않음), `.githooks/pre-push`. Wave 0에서 `$W/lib.sh`, `$W/pw/p6-deletion.mjs`, `$W/yml/*`(가짜 값 변형)를 만듭니다 |
| **Quick run command** | `scripts/check-site.sh <후보 SHA>` |
| **Full suite command** | `scripts/check-site.sh <후보>` + `build <이름> <후보>` + 출력 grep 묶음(`06-RESEARCH.md` Code Examples) + `diff -r` 회귀 비교 + `node "$W/pw/p6-deletion.mjs" <로컬 URL>` (두 엔진 × 375/1280) + 변형 빌드 |
| **Estimated runtime** | check-site 약 2초, 전체 약 60초 |

---

## Sampling Rate

- **사이트 커밋마다:** 후보 SHA로 `scripts/check-site.sh` + 그 커밋의 출력 판정(값 커밋은 다른 문서 바이트 동일, 재작성 커밋은 `data-deletion/index.html`만 다름)
- **기준:** 어떤 변경보다 먼저 실행 시작 커밋을 빌드해 기준 출력을 만듭니다
- **푸시마다:** 훅 경로 점검 → `checkpoint:decision`(SHA별 승인) → 푸시 → 배포 대기 → 라이브 확인(`/`, 법적 3종, `/support/` 200·제목·바이트 = 후보 빌드)
- **Before `/gsd-verify-work`:** 아래 표 전부 + 두 엔진 × 375/1280 캡처를 사용자에게 보이고 문장·대조표 승인
- **Max feedback latency:** 60초

---

## Requirement → Verification Map

2026-11-26: `06-CONTEXT.md` 「앱 작업 뒤 결정」(D-34~D-44)에 맞춰 D-37~D-41 다섯 행과 Manual-Only 두 행을 더했습니다. 기존 행과 상태 칸은 그대로입니다.

| Requirement | Behavior | Test Type | Automated Command (요지) | File Exists |
|-------------|----------|-----------|--------------------------|-------------|
| DEL-01 / SC1 | 본문에 `mailto:` 경로와 「메일에 적을 내용」 목록 | grep (본문 블록) | `doc` 출력에서 `href="mailto:'` ≥1, 요청 조항 안 `li` 수 = 계획 값 | ❌ W0 |
| DEL-01 / SC1 | 첫 화면에서 요청 방법을 찾음 | Playwright | 1280×800에서 요청 조항 `h2`와 본문 첫 `mailto` 링크의 top < innerHeight, 375×812에서 요청 조항 `h2`가 첫 화면 안 | ❌ W0 |
| DEL-02 / SC1 | 앱 이름·스토어 개발자 이름 | grep (값 파일) | 본문 「러닝펜슬」 ≥1, 값 파일로 개발자 이름 ≥1 (개수만 기록) | ❌ W0 |
| DEL-03 / SC2 | 지워지는·남는 데이터, 이유·기간 | grep + 사용자 대조 | 지워지는 목록 `li` 수, 남는 데이터 표 행 수 = 재기준 대조표 행 수, 각 행 3칸. 목록 일치는 사람이 대조표와 한 줄씩 비교 | ❌ W0 |
| DEL-03 / SC2 | U10 낱말 없음 | grep | 포인트·굿즈·배송지·코스북·전자상거래 → 0 (가드 build 커밋 뒤에는 check-site가 지킴) | ❌ W0 |
| DEL-04 / SC3 | 「회원탈퇴」 경로가 지원 페이지 FAQ와 같음 | grep | 「설정 → 내 계정 → 회원탈퇴」 두 문서 모두 ≥1 | ❌ W0 |
| DEL-05 / SC2 | 처리 상한·완료 알림 | grep | 사용자가 정한 상한 문구 1개, 「답장」 ≥1 | ❌ W0 |
| DEL-06 / SC3 | 철회 시 개인위치정보·확인자료 파기 | grep | 위치정보 조항에 「개인위치정보」와 「확인자료」 ≥1 | ❌ W0 |
| DEL-03 / D-39 | 탈퇴 때 지워지는 코스의 낱말 | grep (본문 블록) | 「공개하지 않은 코스」 ≥1, 「비공개 코스」 0 | ❌ W0 |
| DEL-03 / D-40 | 해시 호출 횟수 제한 기록의 기간 | grep | 남는 데이터 표의 그 행 기간 칸에 「7일」 1개 | ❌ W0 |
| DEL-03 / D-37 | 앱 안 일부 삭제의 메뉴 이름 | grep + 앱 대조 | 「뱃지 삭제」·「기록 삭제」·「데이터 관리」·「뱃지와 기록 모두 삭제」 각 ≥1, 재기준에서 읽은 한국어 문구와 글자가 같음 | ❌ W0 |
| DEL-06 / D-38 | 메일 요청의 이름과 뱃지 사실 | grep | 위치정보 조항에 「뱃지와 기록 모두 삭제」 ≥1, 「위치 기록만」·「위치 기록 일괄 삭제」 0 | ❌ W0 |
| DEL-06 / D-41 | 확인자료 보존 기간 표기 | grep | 기간을 적는다면 「6개월」, 「184일」 0 | ❌ W0 |
| DEL-07 / SC4 | 여섯 제공자 앵커가 해당 섹션으로 바로 이동 | grep + Playwright | `section id` 집합 = 기대 집합(각 1회). `/data-deletion/#<id>`로 열어 `section` 위 끝 0±2px(문서 끝 섹션은 스크롤 한계 예외), 첫 자식 `h2`에 제공자 이름 | ❌ W0 |
| DEL-07 | 위치정보 조항 앵커도 같음 | Playwright | 위와 같음 | ❌ W0 |
| BIZ-05 / SC5 | 사실값을 `_data`에서만 읽음 | git + grep | 원본 `data-deletion/index.html`에 값 0, `site.data.company.` 참조 ≥2. 값 커밋의 `git diff --name-only` = `_data/company.yml` 하나 | ❌ W0 |
| BIZ-05 / SC5 | 선택 항목 render-if-present | 변형 빌드 | `phone` 빈 값 → 본문 전화 0, 값 있음 → 계획 값. 개발자 이름 키 빈 값 → 계획이 정한 동작 | ❌ W0 |
| U14 | `noindex`·임시 게시본 없음 | grep | `name="robots"` 0, 「임시 게시본」 0 | ❌ W0 |
| 본문 규칙 D-04·D-07 | 허용 요소만, 클래스 없음, figure 속성 | grep | 허용 밖 요소 0, `class=` 0(본문 블록), 모든 `<figure`에 `tabindex="0"`·`aria-label` | ❌ W0 |
| 레이아웃 | 375px 가로 넘침 없음, 콘솔 오류 없음 | Playwright | `scrollWidth == innerWidth`, console error 0 | ❌ W0 |
| 회귀 | 다른 문서 출력 그대로 | 바이트 비교 | 재작성 커밋: `diff -r` 차이가 `data-deletion/index.html` 하나. 값 커밋: 차이 0 | ❌ W0 |
| 매 푸시 | 라이브 | curl | `/`, 법적 3종, `/support/` 200·제목·바이트 동일 | ✅ Phase 5 `lib.sh` |
| D-02·D-18 | 개발자 이름 값이 `.planning`·커밋 메시지에 없음 | grep 개수 | `git grep -l -F -f <값 파일> -- .planning` 빈 출력, 단계 커밋 메시지 매치 0 | ❌ W0 |
| 가드 build 커밋 | 보강 항목이 나쁜 커밋을 막음 | 양성·음성 대조 | 시험 객체 (a) 본문 mailto 없음 (b) U10 낱말 (c) `noindex` 남음 → 각각 실패, 실제 후보는 통과 | ❌ W0 |

*Per-task 번호(`6-NN-MM`)는 계획이 확정되면 각 PLAN.md의 `<verify>`가 이 표의 행을 가리킵니다.*

*Status: ⬜ pending · ✅ green · ❌ red · ⚠️ flaky*

---

## Wave 0 Requirements

- [ ] `$W/lib.sh` — Phase 5 `lib.sh` 복사, `W` 식만 `-p6-scratch`, 값 파일 생성 함수에 개발자 이름 키 포함, `doc`(본문 블록 추출) 함수 추가
- [ ] `$W/pw/p6-deletion.mjs` — 제목·h1·robots 없음·앵커 집합·앵커 위치·첫 화면 판정·overflow·console
- [ ] `$W/yml/` — `phone` 빈 값/값, 개발자 이름 키 빈 값/값 변형 (가짜 값만, 실제 값 금지)
- [ ] Playwright 재사용 확인: 버전 = `1.59.1` (새 버전 설치 금지, 연구의 package-legitimacy 판정)

---

## Manual-Only Verifications

| Behavior | Requirement | Why Manual | Test Instructions |
|----------|-------------|------------|-------------------|
| 남는 데이터 표가 재기준 데이터 목록과 일치 | DEL-03 | 사실 대조는 사람이 판단 | 재기준한 `DATA-INVENTORY.md` G·E 행과 표 행을 한 줄씩 대조해 사용자 승인 |
| 법령 기한·문구(처리 상한, 「지체 없이」, 확인자료) | DEL-05, DEL-06 | 법률 판단 | 연구 C-1·C-6 선택지에 대한 사용자 결정 기록 확인 |
| 스토어 개발자 이름 값이 스토어 표시와 같음 | DEL-02 | 값은 저장소 밖 콘솔에 있음 | 값 커밋 직전 사용자 대조 |
| 문장 승인 | 전체 | 심사 제출물 | 두 엔진 × 375/1280 캡처를 보이고 승인 |
| prod 전제 다섯 가지가 한곳에 적힘 (D-42) | DEL-03, DEL-06 | 설정은 저장소 밖 prod 프로젝트에 있고 prod는 아직 없음 | 운영 절차서(또는 재기준 문서)의 목록을 앱 문서 `docs/kit-fork.md`와 대조해 사용자 확인 |
| 운영자 절차가 앱 도구 문서와 맞음 (D-43) | DEL-05, DEL-06 | 도구는 앱 저장소에 있음 | 절차서의 범위 이름·재확인·답장 문장을 앱 문서 `docs/operator-delete-tool.md`(기준 앱 커밋)와 대조 |

---

## Validation Sign-Off

- [ ] All tasks have `<automated>` verify or Wave 0 dependencies
- [ ] Sampling continuity: no 3 consecutive tasks without automated verify
- [ ] Wave 0 covers all MISSING references
- [ ] No watch-mode flags
- [ ] Feedback latency < 60s
- [ ] `nyquist_compliant: true` set in frontmatter

**Approval:** pending
