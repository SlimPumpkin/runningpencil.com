---
last_mapped_commit: c4cb26d754e9e666c957e31fa7e559f918b425bb
last_mapped_at: 2026-11-14
---
# External Integrations

**Analysis Date:** 2026-11-14

## APIs & External Services

**CDN (런타임 의존):**
- jsDelivr - Pretendard 글꼴 CSS/웹폰트 제공 (네 HTML 공통)
  - URL: `https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable-dynamic-subset.min.css`
  - Auth: 없음

**데이터 출처 표기:**
- OpenStreetMap - 랜딩 댕댕런 코스 선의 경로 데이터 출처. API 호출 없음(인라인 SVG로 고정), 푸터에 「경로 데이터 © OpenStreetMap contributors」 표기

**분석·광고·지도 SDK:** Not detected

## Data Storage

**Databases:**
- 없음

**File Storage:**
- Local filesystem only (저장소 내 정적 자산, `favicon/`)

**Caching:**
- None (GitHub Pages 기본 CDN 캐싱만)

## Authentication & Identity

**Auth Provider:**
- 없음

## Monitoring & Observability

**Error Tracking:**
- None

**Logs:**
- 없음 (클라이언트 스크립트에 로깅 없음)

## CI/CD & Deployment

**Hosting:**
- GitHub Pages (조직 `SlimPumpkin` 프로젝트 사이트), 사용자 지정 도메인 `runningpencil.com` (`CNAME`)
- Jekyll이 배포 시 한 번 처리, `_config.yml`로 `CNAME`, `CLAUDE.md`, `README.md` 제외

**CI Pipeline:**
- None (`.github/` 없음). `main` 푸시 시 GitHub Pages 자동 배포

## Environment Configuration

**Required env vars:**
- 없음

**Secrets location:**
- 해당 없음

## Webhooks & Callbacks

**Incoming:**
- None (이메일 수집 폼 없음 — 정적 호스팅이라 의도적으로 제외)

**Outgoing:**
- None

---

*Integration audit: 2026-11-14*
