# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

`runningpencil.com` 도메인으로 서비스되는 GitHub Pages 정적 사이트입니다. 모바일 앱 RunningPencil(지도 위 GPS 아트 코스를 걷거나 달려 완주하면 코스 모양의 뱃지와 포인트를 모으고, 지역 코스북을 완성하고, 직접 그린 코스를 올리고, 포인트로 굿즈를 교환하는 앱)의 출시 전 티저 랜딩과 앱 스토어 심사용 법적 페이지로 구성되어 있습니다.

- 빌드 시스템 없음 (no `package.json`, no bundler, no linter, no tests).
- HTML 파일을 직접 편집하면 GitHub Pages가 그대로 서빙합니다.
- `CNAME` 파일이 GitHub Pages의 사용자 지정 도메인(`runningpencil.com`) 매핑을 담당합니다 — 도메인 변경 시 이 파일을 수정해야 합니다.
- 이 저장소는 GitHub 조직 `SlimPumpkin` 아래의 **프로젝트 사이트**입니다 (조직 사이트 슬롯은 `slimpumpkin.github.io`가 이미 사용). 커스텀 도메인이 연결되지 않으면 `slimpumpkin.github.io/<repo>/` 하위 경로로 서빙되므로, 모든 절대 경로(`/favicon/...`, `/terms/`)는 커스텀 도메인 연결을 전제로 합니다.

## Pages

| 경로 | 용도 |
|---|---|
| `index.html` | 티저 랜딩 — 헤더, 히어로(코스 지도 카드), HOW IT WORKS 4카드, 코스북(다크), 출시 안내, 푸터 |
| `privacy-policy/index.html` | 개인정보처리방침 (임시 게시본, `noindex`) |
| `terms/index.html` | 서비스 이용약관 (임시 게시본, `noindex`) |
| `data-deletion/index.html` | 계정·데이터 삭제 안내 (앱 스토어 심사용, `noindex`) |

네 페이지는 `<head>`(Tailwind config, 폰트, 파비콘, `.rp-grid` 스타일)와 헤더·푸터 마크업을 **복사해서 공유**합니다. 빌드 단계가 없어 공통 템플릿을 뽑을 수 없으니, 디자인 토큰·헤더·푸터를 바꿀 때는 네 파일을 모두 수정해야 합니다. 법적 페이지 3종은 같은 레이아웃(흰 카드 + 하드 섀도)에 본문 `<section>`만 다릅니다.

## Local preview

별도 빌드 단계가 없으므로 정적 서버로 띄워서 확인합니다 (Tailwind CDN과 Google Fonts가 `http(s)://`를 요구하므로 `file://`로 직접 열면 스타일이 깨집니다. 또한 `/favicon/...`, `/terms/` 같은 절대 경로는 저장소 루트를 서버 루트로 띄워야 동작합니다):

```bash
python3 -m http.server 8000
# → http://localhost:8000
```

## Architecture / styling notes

- **Tailwind는 CDN 런타임 모드**로 로드됩니다 (`https://cdn.tailwindcss.com`). 브라우저에서 JIT 컴파일하므로 빌드가 필요 없는 대신 프로덕션 권장 방식은 아닙니다. 클래스 추가는 즉시 반영되지만 `@apply`나 커스텀 디렉티브는 사용 불가입니다. 반응형 수치는 `pt-[clamp(56px,7vw,88px)]`처럼 arbitrary value로 씁니다.
- **디자인 토큰**은 각 HTML의 `<script id="tailwind-config">` 인라인 블록에 정의됩니다. 원본은 `prepare/desgin/teaser html/Main.dc.html` 목업(git 제외)입니다.
  - `paper #F7F6F2` 페이지 배경 · `ink #16181D` 텍스트/버튼/테두리 · `accent #FF5A1F` 포인트 컬러
  - `muted #4A4F59`, `muted-2 #5A5F6A` 보조 텍스트 · `line #E6E3DA` 구분선·격자 · `map #F2F0EA` 지도 카드 배경
  - 다크 섹션(`#coursebook`) 전용: `ink-2 #23262D`, `ink-line #3A3E47`, `ink-muted #C9CCD3`, `ink-muted-2 #9EA3AD`
  - `fontFamily.sans`: Noto Sans KR (본문) · `fontFamily.mono`: Space Mono (라벨, 숫자, 로고 워드마크)
  - `boxShadow.hard`: `8px 8px 0 #16181D` — 카드의 오프셋 하드 섀도
- **`.rp-grid` 커스텀 클래스**는 32px 격자 배경입니다. Tailwind config 밖에 있는 유일한 CSS이므로 새 커스텀 스타일은 같은 `<style>` 블록에 추가합니다.
- **다크 모드 없음.** 목업이 라이트 전용이고 `#coursebook` 섹션만 의도적으로 어두운 배경입니다.
- **로고·아이콘·지도 일러스트는 모두 인라인 SVG**입니다. 외부 이미지 의존이 없습니다. 헤더 로고 SVG는 `favicon/favicon.svg`와 동일한 도형이며 `clipPath` id만 `rp-clip-nav`로 다릅니다.
- **이메일 수집 폼 없음.** 정적 호스팅이라 서버 처리가 불가능해 의도적으로 뺐습니다. 연락처 이메일도 표시하지 않습니다 (법적 페이지 포함).

## Assets

- `favicon/`: `favicon.svg`(로고 SVG, 라운드 클립), `favicon.ico`(16/32/48), `favicon-96x96.png`, `apple-touch-icon.png`(180, 전면 불투명), `web-app-manifest-192x192.png`·`512x512.png`(전면 불투명, `purpose: maskable`), `site.webmanifest`.
- 원본은 `prepare/desgin/icon_favicon.png`(1024px, 라운드·투명)입니다. 전면 사각형 버전은 `favicon.svg`에서 `clipPath`를 제거해 렌더링했습니다. 재생성 시 PIL로 LANCZOS 리사이즈하면 됩니다.
- `prepare/`는 `.gitignore`로 제외된 로컬 전용 폴더입니다 (디자인 목업, 아이콘 원본).

## Content language

본문·`<html lang>` 모두 `ko`입니다.

## Deploy

`main` 브랜치에 푸시하면 GitHub Pages가 자동 배포합니다. 별도 CI/CD나 빌드 스텝이 없으므로 커밋이 곧 배포입니다 — 깨진 HTML이 바로 라이브에 올라가니 푸시 전 로컬 미리보기로 확인하는 것이 좋습니다.
