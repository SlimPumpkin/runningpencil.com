# 러닝펜슬 관리도구 설계 (Admin Tool Design) — 앱 저장소로 옮김

이 설계 문서는 2026-11-21 앱 저장소 `running_pencil`의 `docs/superpowers/specs/2026-11-21-admin-tool-design.md`로 옮겼다. 정본은 그쪽이고, 이 저장소에는 사본을 두지 않는다(두 사본이 따로 바뀌지 않게).

이 저장소(사이트)와 맞닿는 부분만 요약한다. 자세한 내용은 정본을 본다.

- 관리도구 주소는 `admin.runningpencil.com`(Firebase Hosting, 가비아 DNS에 `admin` 레코드만 더함). `runningpencil.com` 본 사이트(GitHub Pages)와 메일(MX)은 영향 없다. 본 사이트의 Firebase Hosting 이전은 ROADMAP 백로그 Phase 999.1 그대로다.
- Phase 6 요청서 ③ 운영자 삭제 도구는 관리자 claim을 확인하는 서버 함수로 만들고, 관리 화면이 같은 함수를 부른다.
- 앱 안 신고·완주 인정 요청·숨김·차단은 Phase 6 앱 작업 다음, 출시 전 묶음이다. 그 기능이 나가는 시점에 `DATA-INVENTORY.md`, `/data-deletion/`, 처리방침, 이용약관, `/support/#report`(앵커 이름 유지)를 함께 고친다.
- 사용자 결정(2026-11-21): 앱 삭제 기능(①②③⑤⑥)과 관리도구를 다 만든 뒤 그 커밋으로 06-03 Task 3을 보고한다. 관리도구가 만드는 데이터(운영 기록, 인정 필드)는 06-04 재기준에 들어간다. 신고 기능은 그 보고 커밋 뒤로 둔다.
- 경로 열람 기록과 운영 기록의 보존은 U2 결론 뒤 확정한다.
