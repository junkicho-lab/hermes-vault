---
produced_by_task: "inbox/옵시디언-클로드-결합.md 충실 재서술 → 방법 원자 노트화 ([내 노트 기준])"
agent: Claude Code
model: anthropic/claude-opus-4.8
session: knowledge-옵시디언-클로드-결합
area: 방법론-노하우
aliases: ["inbox 캡처 규칙"]
source: inbox/옵시디언-클로드-결합.md
captured_at: 2026-06-09T10:40:00+09:00
source_type: video
trust_tier: 2
origin: external
produced_at: 2026-06-09T11:05:07+09:00
---
# Raw에는 가공 없이 날것으로 모으고, 판단은 ingest로 미룬다

화자는 Raw 폴더를 "날 것"의 자료를 두는 곳으로 설명한다. 외부에서 얻은 자료(예: 확장 프로그램으로 복사한 유튜브 영상 스크립트)를 가공하지 않고 MD 파일 형태로 Raw 폴더에 넣는다. 화자의 표현으로는 "로우에 다 몰아놓고" 두는 단계다. 이 단계에서는 그 자료가 자신에게 필요한지 따지지 않는다.

필요 여부의 판단은 캡처가 아니라 [[Raw-Wiki-인제스트-워크플로|ingest]] 단계에서 이뤄진다. 30분짜리 영상에 필요한 내용과 불필요한 내용이 섞여 있어도, ingest가 그중 필요한 부분만 뽑아 Wiki에 저장한다. 즉 캡처는 자료를 들이는 동작이고, 거르는 동작은 그 뒤에 분리되어 있다.

이 볼트에서 캡처 시 자료에 붙이는 메타데이터는 출처 식별용 꼬리표다. `source_type`(web/video/book 등), `source_key`(원본 URL), `captured_at`(시각), 그리고 자료의 신뢰 등급을 나타내는 `trust_tier`(1=직접경험, 2=외부·2차, 3=미검증)와 `origin`(external/internal)을 둔다. 정확한 필드 규약은 [[볼트 룰북]]에 정의되어 있다.

출처: 유튜브 영상 "옵시디언과 클로드 코드의 결합" 및 이 볼트의 [[볼트 룰북]].

---
## 내 생각 / 질문
- 
