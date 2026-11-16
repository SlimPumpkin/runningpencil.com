---
last_mapped_commit: c4cb26d754e9e666c957e31fa7e559f918b425bb
last_mapped_at: 2026-11-14
---
# Codebase Concerns

**Analysis Date:** 2026-11-14

범위: 저장소 전체 (`prepare/`, `.planning/` 제외). GitHub Pages 내장 Jekyll로 빌드하는 정적 사이트이며 `main` 푸시가 곧 배포입니다. 테스트 러너·린터는 없고, 푸시 전 점검 `scripts/check-site.sh`가 있습니다.

## Tech Debt

**공유 블록의 수동 복제 (해소됨):**
- Issue: 해소됨. 공통 블록 네 가지(`<head>` 글꼴·파비콘 링크, 「공통」 CSS, 헤더, 푸터)가 `_includes/` 한 벌(`head-links.html`, `css/common.css`, `header.html`, `footer.html`)에서 나오고, 법적 3종은 `_layouts/legal.html`로 그린다. 전환 전후 출력이 같다는 확인은 Phase 2 검증 기록(`.planning/phases/02-jekyll-shared-shell-refactor/02-EVIDENCE.md`)에 있다.
- Files: `_includes/head-links.html`, `_includes/css/common.css`, `_includes/header.html`, `_includes/footer.html`, `_layouts/legal.html`
- Impact: 공통 블록을 고칠 곳이 한 곳뿐이다. 페이지에 복사본이 다시 생기는지는 `TESTING.md`의 「공통 블록 한 벌 확인」 명령으로 본다.
- Fix approach: 해결: Phase 2

**법적 페이지의 Tailwind CDN 런타임 모드:**
- Issue: `<script src="https://cdn.tailwindcss.com">`로 브라우저에서 JIT 컴파일. Tailwind 공식 문서가 프로덕션 비권장으로 명시하는 방식.
- Files: `_layouts/legal.html:14` (법적 3종 공통. 토큰은 같은 파일의 `<script id="tailwind-config">`, `_layouts/legal.html:16-30`)
- Impact: 첫 렌더 전 스크립트 다운로드·컴파일로 FOUC/지연, 콘솔 경고, CDN 장애 시 본문 스타일 전부 상실. 토큰 정의는 레이아웃 한 곳에 있다.
- Fix approach: Tailwind CLI로 한 번 빌드한 정적 CSS를 커밋하거나, 본문 스타일이 적으므로 「법적 페이지 전용」 일반 CSS로 옮김 (랜딩과 동일 방식).

**임시 히어로 그림:**
- Issue: 히어로의 쿼터뷰 지도 SVG는 애니메이션으로 교체할 자리의 임시 그림 (`CLAUDE.md` 기재).
- Files: `index.html:171` (`#rp-hero-art`)
- Impact: 교체 시 `id="rp-hero-art"`를 스크립트가 참조하므로 함께 수정 필요.
- Fix approach: 교체 작업 시 `id` 유지 또는 `index.html:428~` 스크립트 동시 수정.

## Known Bugs

검증 가능한 기능 버그는 발견되지 않음. 관련 리스크:

**법적 페이지 최종 업데이트 날짜 고정:**
- Symptoms: 세 페이지 모두 "최종 업데이트: 2026년 10월 31일" 하드코딩.
- Files: 값은 각 페이지 front matter의 `updated` (`terms/index.html:6`, `privacy-policy/index.html:6`, `data-deletion/index.html:7`), 출력 줄은 `_layouts/legal.html:50`
- Trigger: 본문을 고치고 날짜를 갱신하지 않을 때 (자동 갱신 장치 없음).
- Workaround: 본문 수정 시 수동 갱신.

## Security Considerations

**서드파티 CDN에 SRI 없음:**
- Risk: jsDelivr(Pretendard CSS)와 `cdn.tailwindcss.com`(실행 스크립트)을 `integrity` 속성 없이 로드. 특히 Tailwind는 버전 고정 없는 JS라 CDN 측 변경이 그대로 페이지에서 실행됨.
- Files: Pretendard 링크 `_includes/head-links.html:2` (`index.html:21`, `_layouts/legal.html:15`에서 include), Tailwind `_layouts/legal.html:14`
- Current mitigation: Pretendard는 `@v1.3.9`로 버전 고정. 폼·쿠키·사용자 입력이 없어 영향 범위는 제한적.
- Recommendations: Pretendard에 `integrity` 추가 또는 self-host, Tailwind 런타임은 정적 CSS로 대체 (위 Tech Debt). CSP `<meta>` 도입 검토.

**개인정보처리방침 필수 항목 누락 가능성:**
- Risk: `privacy-policy/index.html`의 항목은 1~6(수집 항목·이용 목적·위치정보·보유 기간·제3자 제공/위탁·사용자 권리)뿐이며 "개인정보 보호책임자"나 문의처가 없음 (`grep -c 책임자` = 0). 현재 사이트에는 지원 이메일이 없음 (2026-11 기준). 이메일 게이트(Phase 5) 뒤에 지원 이메일을 공개하고, 보호책임자와 연락처는 Phase 7 처리방침 재작성에서 넣기로 결정함 (`.planning/PROJECT.md` Key Decisions). 개인정보 보호법상 처리방침 기재 사항(보호책임자·고충 처리 부서 등)과 앱 스토어 심사 요건에 미달할 수 있음 — 법률 판단은 확인 필요.
- Files: `privacy-policy/index.html:10-49`, `data-deletion/index.html:11` ("삭제 방법"이 앱 내 경로만 안내하는지 확인 필요)
- Current mitigation: 세 페이지 모두 "임시 게시본" 명시 (`terms/index.html:80`, `privacy-policy/index.html:54`, `data-deletion/index.html:32`), `noindex` (각 파일 front matter `noindex: true` — `terms/index.html:7`, `privacy-policy/index.html:7`, `data-deletion/index.html:8`. 출력은 `_layouts/legal.html:10-12`).
- Recommendations: 정식 출시 전 법률 검토로 본문 확정, 연락 수단(최소 문의 채널) 결정.

## Performance Bottlenecks

**단일 대형 `index.html`:**
- Problem: 원본 72KB, 586줄에 랜딩 전용 CSS·인라인 SVG·스크립트가 모두 포함 (「공통」 CSS·head 링크·헤더·푸터는 include로 들어옴).
- Files: `index.html`
- Cause: 페이지 전용 CSS·스크립트를 외부 파일로 빼지 않고 인라인으로 둠, 외부 이미지 대신 인라인 SVG 사용.
- Improvement path: 현재 수준은 수용 가능. GitHub Pages가 gzip 제공. 크기가 더 늘면 SVG `<defs>` 재사용 확대.

**렌더 차단 외부 리소스:**
- Problem: 법적 페이지는 `<head>`의 동기 Tailwind 스크립트가 렌더를 막음.
- Files: `_layouts/legal.html:14` (법적 3종 공통)
- Improvement path: 정적 CSS 전환.

## Fragile Areas

**랜딩 스크립트의 id·클래스 결합:**
- Files: `index.html:428-573` (스크립트), `index.html:205` (`#story`), `index.html:250-252` (`data-go` 버튼)
- Why fragile: `byId('rp-run-dot')` 등 십수 개의 `id`, `data-step`/`data-go`, `is-on`/`is-s0~2` 클래스를 문자열로 찾음. `byId` 결과에 null 검사가 없어 한 요소만 지워도 스크립트 전체가 예외로 멈춤 (예: `story.querySelectorAll` — `index.html:436`).
- Safe modification: 마크업 이름 변경 시 스크립트에서 같은 문자열 검색 후 동시 수정, 로컬 미리보기(`bundle exec jekyll serve --livereload`)에서 콘솔 확인.
- Test coverage: 없음.

**스크롤 고정(`rp-pin`) 레이아웃:**
- Files: `index.html:24` (활성화 조건), `index.html:66-114` (`340vh`, sticky, `max-height` 단계별 `zoom`)
- Why fragile: 화면 높이별 `zoom` 단계 미디어 쿼리가 다수 겹쳐 있어 기기별 잘림이 생기기 쉬움. `zoom`은 비표준 역사가 있는 속성(Firefox는 최근 버전부터 지원).
- Safe modification: 다양한 창 높이(620/720/820px, 모바일)에서 수동 확인.

**절대 경로의 커스텀 도메인 의존:**
- Files: 모든 HTML의 `/favicon/...`, 법적 페이지 헤더 `/#story` 등 (`_includes/header.html:9-11`), `favicon/site.webmanifest`의 `"start_url": "/"`, `index.html:19-20` og URL, `CNAME`
- Why fragile: 프로젝트 사이트라 커스텀 도메인이 풀리면 `slimpumpkin.github.io/<repo>/`로 서빙되어 링크·파비콘·매니페스트가 전부 깨짐.
- Safe modification: `CNAME`과 GitHub Pages 도메인 설정을 함께 관리.

**커밋 = 배포:**
- Files: 저장소 전체
- Why fragile: CI, HTML 검증, 링크 검사가 없어 깨진 마크업이 즉시 라이브 반영. pre-push 훅의 `scripts/check-site.sh`는 빌드 성공, 내부 파일 부재, 기존 URL 문서 4개의 제목, Liquid 잔여만 본다.
- Safe modification: 훅을 켜 두고(`git config core.hooksPath .githooks`) 푸시 전 로컬 미리보기로 화면 확인; 필요 시 GitHub Actions로 HTML validator/link checker 추가.

## Scaling Limits

**페이지 추가 비용:**
- Current capacity: 4페이지.
- Limit: 공통 블록은 include 한 벌이라 페이지 수에 비례한 불일치 위험은 없어졌다. 새 페이지는 `scripts/check-site.sh`의 기대 제목 목록(기존 URL 넷)에 자동으로 들어가지 않는다.
- Scaling path: Jekyll layout/include 도입은 해결: Phase 2. 새 법적·안내 페이지는 `layout: legal`과 front matter로 만든다.

## Dependencies at Risk

**`cdn.tailwindcss.com` (Play CDN):**
- Risk: 버전 미고정, 개발용 도구로 공지됨. Tailwind 메이저 업데이트 시 동작·설정 형식(`tailwind.config`) 변경 가능.
- Impact: 법적 페이지 3종 스타일 붕괴 — 앱 스토어 심사 링크 대상 페이지.
- Migration plan: 정적 CSS 커밋.

**Pretendard via jsDelivr (`orioncactus/pretendard@v1.3.9`):**
- Risk: CDN 장애·차단 시 시스템 글꼴 폴백.
- Impact: 시각적 저하만 (기능 영향 없음).
- Migration plan: 필요 시 self-host.

## Missing Critical Features

**출시 정보:**
- Problem: 스토어 링크·뱃지가 없음 (의도된 티저 상태, `CLAUDE.md`).
- Blocks: 출시 시 `#get` 구간 개편 필요.

**문의 채널:**
- Problem: 현재 문의 채널이 없음 (2026-11 기준). 이메일 수집 폼은 만들지 않기로 했고(정적 호스팅), 지원 이메일은 이메일 게이트(Phase 5) 뒤에 `/support/`와 푸터에 공개하기로 결정함.
- Blocks: 법적 페이지의 권리 행사·삭제 요청 수단이 앱 밖에서는 제공되지 않음 (위 Security 참고).

**법적 페이지 OG 메타 없음:**
- Problem: `index.html:15-20`에는 og 태그가 있으나 법적 페이지에는 `description`만 있음 (`_layouts/legal.html:9`, 값은 각 페이지 front matter — `terms/index.html:4`).
- Blocks: 공유 미리보기 품질 (`noindex` 페이지라 우선순위 낮음).

## Test Coverage Gaps

**전체:**
- What's not tested: 랜딩 스크립트(스크롤 단계, 7초 달리기 데모 `index.html:539`), 페이지 간 링크, HTML 유효성. 공통 블록은 include 한 벌이고(한 벌 확인은 `TESTING.md`의 `git grep` 명령), 빌드·제목·Liquid 잔여는 `scripts/check-site.sh`가 본다.
- Files: `index.html`, 법적 페이지 3종
- Risk: 회귀가 배포 후에야 발견됨.
- Priority: Medium

**접근성:**
- What's not tested: `:focus-visible` 스타일(`_includes/css/common.css:6`)과 `prefers-reduced-motion` 처리(`index.html:24`, `index.html:96`, 스크립트의 `reduced()`)는 있으나, 데모 완료·진행률 변화를 스크린 리더에 알리는 `aria-live`/`role="status"`가 없음 (grep 0건). 노랑 `#F2B134` 바탕 위 텍스트 대비는 수동 검증 필요.
- Files: `index.html` (`#demo`, `rp-demo-done`)
- Risk: 보조기기 사용자가 데모 결과를 인지하지 못함.
- Priority: Low

---

*Concerns audit: 2026-11-14*
