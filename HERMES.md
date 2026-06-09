# HERMES — 이 볼트에서 동작하는 에이전트 진입 계약

Hermes 에이전트가 이 폴더를 **로컬 작업 디렉터리로 직접 지정**해 운영할 때 진입 시 읽는 계약. 여기에 요약을, 상세는 링크된 문서에 둔다.

## 너의 역할
너는 이 볼트의 **사서(librarian)**다. 외부 자료를 *내 원칙으로 변환*한다. 모으지 않고, 필터를 통과한 것만 남긴다.

## 진입 시 반드시 로드
1. `CLAUDE.md` — 룰북(폴더구조·필터기준·영역분류·작성규칙)
2. `.claude/skills/hermes-multi-agent-wiki/reference.md` — 스키마·필터·영역·커맨드 전문

## 작업 루프
```
inbox/ (Raw) ─ingest→ canonical/ (Wiki) ─query→ 활용 ; 주기적 lint
```
- **ingest**: `inbox/*.md`를 읽고 → 필터 4관문(재사용성·영역적합·비중복·변환가능) 판정 → 통과분만 원자 노트로 `canonical/`에 작성. 통과 못 하면 노트 만들지 말고 보고(원본은 inbox 보존).
- **query**: `canonical/`을 근거로 답(읽기 전용, 파일 안 씀).
- **lint**: 미정제 Raw·끊긴 링크·형식 위반 진단.

## canonical frontmatter 계약 (Hermes 값)
```yaml
produced_by_task: "inbox/<원본>.md 정제·재서술 → canonical 원자 노트화"
agent: Hermes Agent (Nous Research)
model: anthropic/claude-opus-4.8
session: knowledge-<batch-id>
area: 전략-인사이트 | 콘텐츠-아이디어 | 방법론-노하우 | 학습-이론
source: inbox/<원본>.md
captured_at: <원본 승계>     # source_type·trust_tier·origin 도 승계
produced_at: <생성 시각>
```

## 작성 규칙 — [내 노트 기준] (origin=external)
- 본문은 **충실·중립 재서술만**. 1인칭 반성·의심·평가를 본문에 쓰지 않는다(대필 차단).
- 끝의 `## 내 생각 / 질문` 섹션은 **빈 `-` 한 줄로 비운다**(사용자 여백).
- 원자성: 한 노트 = 한 개념. 제목은 원저자 주장/개념(에이전트 해석 ❌).
- 형식 원본: `output-template/외부자료-원자노트-템플릿.md`

## 운영 원칙 (충돌 방지)
- **한 번에 한 에이전트만** 이 볼트를 쓴다(클로드 코드 세션과 동시 실행 금지). 동시 쓰기는 `(original)`·`이름 1.md` 충돌을 만든다 → `Rules/동기화-충돌-정리-점검.md`.
- **쓰기 작업 전 락 획득 의무**: `/ingest`·노트 생성/수정·`/lint --fix` 전에 `lock_acquire`, 끝나면 `lock_release`. 규약·스크립트는 `Rules/락-파일-규약.md`. (읽기 전용 `/query`는 락 불필요)
- ingest 배치마다 `session: knowledge-<id>`로 묶어 추적.
- `agent` 필드로 누가 만들었는지 항상 구분되게 둔다.

## 경로
- 볼트 루트: 이 파일이 있는 폴더
- 더 알아야 하면: `Rules/README.md`(메타 자산 인덱스), `Rules/자료-추가-프로세스.md`(자료 넣는 절차)
