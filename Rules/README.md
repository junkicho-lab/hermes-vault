# Rules — 볼트 운영 메타 자산 인덱스

이 볼트는 **Hermes식 멀티 에이전트 위키 패턴**으로 운영된다. 외부 정보를 모으는 게 아니라 *내 원칙으로 변환*하는 시스템이다. 이 폴더는 그 운영 규칙·형식·도구를 모아 둔 곳이며, 아래가 전체 지도다.

## 핵심 문서

| 자산 | 위치 | 역할 |
|------|------|------|
| 🧠 **패턴 스킬** | [../.claude/skills/hermes-multi-agent-wiki/SKILL.md](../.claude/skills/hermes-multi-agent-wiki/SKILL.md) | 패턴 전체를 종합한 재사용 스킬(다른 볼트 이식용) |
| 📕 **볼트 룰북** | [../CLAUDE.md](../CLAUDE.md) | 폴더구조·필터기준·영역분류·작성규칙의 실제 기준 |
| 🤖 **Hermes 진입 계약** | [../HERMES.md](../HERMES.md) | Hermes 에이전트가 이 볼트를 로컬로 운영할 때 읽는 계약 |
| 📄 **노트 템플릿** | [../output-template/외부자료-원자노트-템플릿.md](../output-template/외부자료-원자노트-템플릿.md) | canonical 작성 형식 원본([내 노트 기준]) |
| 📥 **자료 추가 프로세스** | [자료-추가-프로세스.md](자료-추가-프로세스.md) | 캡처→ingest→활용 실전 절차(이 폴더에 자료 넣는 법) |
| 🔧 **동기화 충돌 정리 점검** | [동기화-충돌-정리-점검.md](동기화-충돌-정리-점검.md) | 중복본·충돌 사본 진단·정리 체크리스트 |
| 🔒 **락 파일 규약** | [락-파일-규약.md](락-파일-규약.md) | 다중 에이전트 동시 쓰기 방지(단일 작성자 보장) |

## 슬래시 커맨드 (`.claude/commands/`)

| 명령 | 위치 | 역할 |
|------|------|------|
| `/ingest` | [../.claude/commands/ingest.md](../.claude/commands/ingest.md) | Raw(inbox) → 필터 → canonical 원자 노트 정제 |
| `/query` | [../.claude/commands/query.md](../.claude/commands/query.md) | canonical 큐레이션 (읽기 전용) |
| `/lint` | [../.claude/commands/lint.md](../.claude/commands/lint.md) | 볼트 건강 진단 (`--fix` 안전 수정) |

## 폴더 구조

| 폴더 | 역할 |
|------|------|
| `inbox/` | **Raw** — 외부 날것 정보 (캡처, 판단은 미룸) |
| `staging/` | 작업 중 임시 산출물 |
| `canonical/` | **Wiki** — 정제된 원자 노트 |
| `output-template/` | 작성 형식 원본 |
| `Rules/` | 운영 메타 자산 (이 폴더) |

## 운영 한 줄 요약

> 외부 자료를 `inbox`에 캡처 → `/ingest`로 **필터 통과분만** 중립 재서술된 원자 노트로 → `/query`로 활용 → 주기적으로 `/lint`.
> 에이전트는 **충실·중립 재서술만**, 반성·의심·평가는 각 노트의 `## 내 생각 / 질문` 여백에 **내가** 채운다(대필 차단).

## 4개 영역(Area)

`전략-인사이트` · `콘텐츠-아이디어` · `방법론-노하우` · `학습-이론` — 분류 기준과 결정 트리는 [룰북](../CLAUDE.md)과 [스킬](../.claude/skills/hermes-multi-agent-wiki/SKILL.md) 참조.

---

### 새 자료를 넣는 법
1. 외부 자료를 `inbox/`에 MD로 던진다(가공·판단 없이). frontmatter 양식은 [룰북](../CLAUDE.md) 또는 [[inbox-캡처-규칙|inbox 캡처 규칙]] 참조.
2. `/ingest <파일>` 실행 → 필터 판정 후 통과분만 `canonical/`에 정제·영역 배정.
3. 필요할 때 `/query <질문>`, 정비는 `/lint`.
