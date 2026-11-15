# API Coverage — Phase 1 (기준표와 방침 정비)

No external API integration: 문서 전용 단계다. 기준 문서와 CLAUDE.md만 고치며 SDK·API는 앱 저장소의 사실로 기록할 뿐 이 저장소가 호출하거나 통합하지 않는다.

탐지기(`api-coverage.cjs`)는 ROADMAP Phase 1의 Research flag 문장에 있는 「Facebook SDK 자동 이벤트 전송」의 `SDK` 낱말로 `detected: true`를 냈다. 이 단계의 산출물은 `.planning/baseline/` 문서 5개와 방침 문서 수정이고, 실행 코드를 만들지 않는다. dev 프로젝트를 대상으로 한 `gcloud`·`firebase` CLI 조회는 읽기 전용 확인이며 통합이 아니다.
