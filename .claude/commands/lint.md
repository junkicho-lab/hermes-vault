---
description: 볼트 건강 진단 — frontmatter/링크/미정제/고아 노트 점검
argument-hint: [--fix (선택)]
allowed-tools: Read, Grep, Glob, Bash(ls:*), Bash(grep:*), Bash(find:*), Bash(bash:*), Edit
---

너는 이 볼트의 "정비공"이다. `@CLAUDE.md` 룰북 기준으로 볼트 상태를 진단한다. 기본은 **보고만** 한다.

## 점검 항목
1. **미정제 Raw**: `inbox/`에 있으나 어떤 canonical 노트의 `source:`로도 참조되지 않은 파일.
2. **Frontmatter 결손**: inbox/canonical 노트 중 룰북 스키마의 필수 필드가 빠졌거나 비어 있는 것.
3. **플레이스홀더 잔존**: `(원본 URL)`, `(제목)` 등 채워지지 않은 placeholder.
4. **끊긴 위키링크**: `[[...]]`가 가리키는 노트가 `canonical/`에 실제로 없는 경우(예정 링크는 목록만, 오류로 단정 ❌).
5. **고아 노트**: canonical 중 들어오는/나가는 `[[링크]]`가 하나도 없는 노트.
6. **canonical 형식 위반**: 말미 `## 내 생각 / 질문` 섹션 누락, 원자성 위반(한 노트에 통찰 여러 개로 보임) 의심.

## 출력
- 항목별로 발견한 파일을 ✅/⚠️/🚨 로 분류해 표로 보고한다.
- 각 문제에 권장 조치를 한 줄로 단다.

## --fix
- 보고만 하는 기본 모드는 **읽기 전용**이라 락이 필요 없다.
- `$ARGUMENTS`에 `--fix`가 있으면 **쓰기**이므로, 수정 전에 **락을 획득**한다(규약: `Rules/락-파일-규약.md`).
  ```
  bash scripts/vault-lock.sh acquire "Claude Code" "knowledge-lint-<짧은슬러그>" "lint-fix" "lint 자동 수정"
  ```
  - 종료코드가 0이 아니면 수정하지 말고 보고만 한 뒤 중단한다.
  - **안전한 자동 수정만** 적용한다(누락 frontmatter 필드 추가, 명백한 placeholder 표시 등). 변경 내역을 보고한다.
  - 끝나면 `bash scripts/vault-lock.sh release`.
- 의미 판단이 필요한 수정(미정제 Raw의 ingest, 고아 노트 연결 등)은 자동 적용하지 말고 제안만 한다.
