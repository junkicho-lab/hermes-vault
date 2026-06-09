# 🗂️ hermes-vault

![Obsidian](https://img.shields.io/badge/Obsidian-483699?logo=obsidian&logoColor=white)
![Claude Code](https://img.shields.io/badge/Claude%20Code-D97757?logo=anthropic&logoColor=white)
![Pattern](https://img.shields.io/badge/pattern-LLM%20Wiki-2563EB)
![Visibility](https://img.shields.io/badge/visibility-private-6e7681)
![Made with Markdown](https://img.shields.io/badge/made%20with-Markdown-000000?logo=markdown&logoColor=white)

> 외부 정보를 **모으지 않고**, 내 원칙으로 **변환**하는 옵시디언 + 클로드 코드 기반 지식관리(PKM) 볼트.

안드레 카파시의 **LLM Wiki 패턴**(옵시디언=IDE · LLM=프로그래머 · 위키=코드베이스)을 1인 지식관리에 맞게 변형한 **Hermes식 멀티 에이전트 위키**다. 핵심은 하나 — *문제는 정보의 양이 아니라 나만의 필터가 없는 것*. 입구에 필터를 세워 **통과한 것만** 위키에 남긴다.

> **운영 철칙**
> - 캡처할 땐 거르지 않는다 — 판단은 `ingest`로 미룬다.
> - 에이전트는 **충실·중립 재서술만** — 반성·의심·평가는 내 여백(`## 내 생각 / 질문`)에. (대필 차단)
> - 한 번에 한 에이전트만 쓴다 — 락으로 단일 작성자 보장.

## 📁 구조

| 폴더 | 역할 |
|------|------|
| `inbox/` | **Raw** — 외부 날것 정보 (캡처, 판단은 미룸) |
| `staging/` | 작업 중 임시 산출물 |
| `canonical/` | **Wiki** — 중립 재서술된 원자 노트 |
| `output-template/` | 노트 작성 형식 원본 |
| `Rules/` | 운영 문서(프로세스·충돌 정리·락 규약) |
| `scripts/` | `vault-lock.sh` 단일 작성자 락 |

## ⚡ 사용 (슬래시 커맨드)

```
/ingest <파일>   # Raw → 필터 통과분만 원자 노트로 정제
/query  <질문>   # canonical 큐레이션 (읽기 전용)
/lint  [--fix]   # 미정제·끊긴 링크·형식 점검
```

## 📚 문서

- **[Rules/README.md](Rules/README.md)** — 메타 자산 전체 지도
- **[CLAUDE.md](CLAUDE.md)** — 룰북(필터·영역·작성규칙)
- **[HERMES.md](HERMES.md)** — Hermes 에이전트 진입 계약
- **[패턴 스킬](.claude/skills/hermes-multi-agent-wiki/SKILL.md)** — 다른 볼트 이식용 키트
- **[자료 추가 프로세스](Rules/자료-추가-프로세스.md)** · **[락 파일 규약](Rules/락-파일-규약.md)**

## 🧭 영역(Area)

`전략-인사이트` · `콘텐츠-아이디어` · `방법론-노하우` · `학습-이론`
— 외부 자료는 ingest 시 이 중 하나로 분류되어 누적된다.

---

<sub>위치가 아니라 시스템이 자유다. 시스템 위에 내 원칙이 박혀 있으면 어디서든 작동한다.</sub>
