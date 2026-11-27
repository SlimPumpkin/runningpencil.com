# runningpencil.com

러닝펜슬 티저 사이트. GitHub Pages 정적 호스팅. 배포할 때 GitHub Pages 내장 Jekyll(3.10.0)이 `_layouts`·`_includes`로 페이지를 조립한다.

```bash
bundle config set --local path vendor/bundle   # 처음 한 번: gem을 저장소 안에 둔다
bundle install                                 # gem 설치 (Jekyll 3.10.0)
bundle exec jekyll serve --livereload          # 미리보기 → http://localhost:4000
git config core.hooksPath .githooks            # 클론마다 한 번: pre-push 점검 훅 켜기
scripts/check-site.sh                          # 푸시 전 점검 (빌드·내부 파일·제목·Liquid 잔여·Tailwind 없음·랜딩·삭제 안내 기능 이름·지원 페이지 연락처·삭제 안내 본문(요청 경로·검색 제외 없음))
```
