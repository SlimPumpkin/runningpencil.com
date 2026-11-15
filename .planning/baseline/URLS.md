# URL 대장 (URL Ledger)

**작성일:** 2026-11-15
**기준:** BASE-02 — 사이트의 공개 URL과 URL마다 등록할 콘솔 필드(범주)의 정본
**읽는 곳:** Phase 8 푸터 링크, Phase 9 `hreflang`, Phase 10 콘솔 제출 체크리스트와 URL 점검

> - 모든 주소는 apex 호스트(`www` 없음), https 스킴, 끝 슬래시를 붙인 형식으로 씁니다. 콘솔에도 이 표의 문자열을 그대로 넣습니다 (D-16).
> - 「등록할 콘솔 필드(범주)」 열은 **범주 수준**입니다. 콘솔마다 실제 필드명은 이 표에 확정된 것처럼 적지 않았고, 정확한 필드명은 Phase 10 연구에서 확정합니다 (D-17).
> - 이미 라이브인 세 주소(개인정보처리방침, 이용약관, 데이터 삭제 안내)는 경로를 바꾸지 않고 리디렉션도 걸지 않습니다 (출처: `.planning/ROADMAP.md` Ground Rules).
> - 이 대장에는 이 저장소가 서빙하는 주소만 넣습니다. 외부 문서 링크는 넣지 않습니다.

| URL | 언어 | 현재 상태 | 만드는 단계 | 등록할 콘솔 필드(범주) |
|---|---|---|---|---|
| `https://runningpencil.com/` | ko | 라이브 | 기존 | Google OAuth 동의 화면 — 홈페이지 / Google Play — 웹사이트 / App Store Connect — Marketing URL(선택) / 카카오·네이버 — 서비스 URL·사이트 도메인 |
| `https://runningpencil.com/privacy-policy/` | ko | 라이브, 경로 고정(리디렉션 금지) | 기존, Phase 7 재작성 | Google OAuth 동의 화면 — 개인정보처리방침 링크(이 문자열 그대로 등록) / Google Play·App Store Connect — 개인정보처리방침 URL / Facebook·LINE — 개인정보처리방침 URL / 카카오·네이버 — 개인정보처리방침(요구 시) |
| `https://runningpencil.com/terms/` | ko | 라이브, 경로 고정(리디렉션 금지) | 기존, Phase 8 재작성 | Google OAuth 동의 화면 — 서비스 약관 링크 / Facebook·LINE — 이용약관 URL / 카카오 — 이용약관(요구 시) |
| `https://runningpencil.com/data-deletion/` | ko | 라이브, 경로 고정(리디렉션 금지) | 기존, Phase 6 재작성 | Google Play — 계정 삭제 URL / Facebook — Data Deletion Instructions URL(앵커 `#facebook`) |
| `https://runningpencil.com/support/` | ko | 없음 | Phase 5 | App Store Connect — Support URL |
| `https://runningpencil.com/location-terms/` | ko | 없음 (경로 확정, D-15) | Phase 8 | 콘솔 등록 없음. 홈페이지 푸터에서 링크한다 (LOC-01) |
| `https://runningpencil.com/en/` | en | 없음 | Phase 9 | 영어 심사용 홈페이지 (콘솔별 칸은 Phase 10에서 확정) |
| `https://runningpencil.com/en/privacy-policy/` | en | 없음 | Phase 9 | Facebook·LINE·App Store Connect 등 영어 개인정보처리방침 URL을 받는 칸 (Phase 10에서 확정) |
| `https://runningpencil.com/en/terms/` | en | 없음 | Phase 9 | Facebook·LINE 등 영어 이용약관 URL을 받는 칸 (Phase 10에서 확정) |
| `https://runningpencil.com/en/data-deletion/` | en | 없음 | Phase 9 | Facebook — Data Deletion Instructions URL 후보 (Phase 10에서 확정) |
| `https://runningpencil.com/en/support/` | en | 없음 | Phase 9 | App Store Connect — Support URL(영어 현지화) 후보 (Phase 10에서 확정) |
| `https://runningpencil.com/en/location-terms/` | en | 예약 (v2 LOC-06) | 이번 마일스톤에서는 만들지 않음 | 이번 마일스톤에서는 등록할 곳 없음. 영문 위치약관을 낼 때 정한다 |

## 도메인만 등록하는 칸

주소가 아니라 도메인만 받는 칸입니다. 스킴과 슬래시를 붙이지 않습니다.

| 값 | 등록할 곳(범주) |
|---|---|
| `runningpencil.com` | Google OAuth — 승인된 도메인(Authorized domains) / Facebook — 앱 도메인(App Domains) / 카카오 — Web 플랫폼 사이트 도메인 |

---
*URL ledger for: 러닝펜슬 웹사이트 심사 대응 (BASE-02)*
*Written: 2026-11-15*
