#!/usr/bin/env bash
# vault-lock.sh — 단일 작성자 보장용 협조적 락 (mkdir 원자 락 + TTL 하트비트)
# 규약 문서: Rules/락-파일-규약.md
#
# 두 가지로 쓸 수 있다:
#   1) 소스(함수):  source scripts/vault-lock.sh ; lock_acquire "<agent>" "<session>" "<op>" "<note>"
#   2) CLI(서브커맨드):  bash scripts/vault-lock.sh acquire "<agent>" "<session>" "<op>" "<note>"
#                        bash scripts/vault-lock.sh heartbeat|release|status
# 종료코드: acquire 성공 0 / 실패(다른 에이전트 활성) 1

# 볼트 루트 = 이 스크립트의 상위(scripts/의 부모). cwd와 무관하게 락 위치 고정.
_VL_SELF="${BASH_SOURCE[0]:-$0}"
VAULT_DIR="${VAULT_DIR:-$(cd "$(dirname "$_VL_SELF")/.." && pwd)}"
LOCK_DIR="$VAULT_DIR/.vault.lock"
LOCK_TTL="${LOCK_TTL:-900}"            # stale 판정(초)
LOCK_RETRIES="${LOCK_RETRIES:-5}"     # 활성 락일 때 재시도 횟수
LOCK_RETRY_WAIT="${LOCK_RETRY_WAIT:-10}"

_vl_now() { date +%s; }
_vl_iso() { date "+%Y-%m-%dT%H:%M:%S+09:00"; }

lock_acquire() {  # agent session op note
  local agent="${1:-unknown}" session="${2:-}" op="${3:-edit}" note="${4:-}"
  local i hb now who
  for ((i=1; i<=LOCK_RETRIES; i++)); do
    if mkdir "$LOCK_DIR" 2>/dev/null; then
      now=$(_vl_now)
      cat > "$LOCK_DIR/owner" <<EOF
agent: $agent
session: $session
op: $op
pid: $$
host: $(hostname)
acquired_at: $(_vl_iso)
heartbeat_at: $(_vl_iso)
heartbeat_epoch: $now
ttl_seconds: $LOCK_TTL
note: "$note"
EOF
      echo "🔓 락 획득: $agent / $op"
      return 0
    fi
    # 잠김 — stale 여부 확인
    hb=$(grep -m1 '^heartbeat_epoch:' "$LOCK_DIR/owner" 2>/dev/null | awk '{print $2}')
    now=$(_vl_now)
    who=$(grep -m1 '^agent:' "$LOCK_DIR/owner" 2>/dev/null | cut -d' ' -f2-)
    if [ -n "$hb" ] && [ $((now - hb)) -gt "$LOCK_TTL" ]; then
      echo "⚠️ stale 락 회수 (보유자: ${who:-unknown}, $((now-hb))s 무응답)" >&2
      rm -rf "$LOCK_DIR"
      continue
    fi
    echo "🔒 잠김 (보유자: ${who:-unknown}) — 재시도 $i/$LOCK_RETRIES (${LOCK_RETRY_WAIT}s)" >&2
    sleep "$LOCK_RETRY_WAIT"
  done
  echo "❌ 락 획득 실패: 다른 에이전트가 활성. 작업 중단." >&2
  return 1
}

lock_heartbeat() {
  [ -f "$LOCK_DIR/owner" ] || { echo "ℹ️ 보유 중인 락 없음" >&2; return 1; }
  local now; now=$(_vl_now)
  sed -i.bak -E "s/^heartbeat_at:.*/heartbeat_at: $(_vl_iso)/; s/^heartbeat_epoch:.*/heartbeat_epoch: $now/" "$LOCK_DIR/owner"
  rm -f "$LOCK_DIR/owner.bak"
}

lock_release() { rm -rf "$LOCK_DIR"; echo "🔓 락 해제"; }

lock_status() {
  if [ -d "$LOCK_DIR" ]; then echo "🔒 잠김:"; cat "$LOCK_DIR/owner"; else echo "🔓 해제됨"; fi
}

# ── CLI 디스패처: 직접 실행될 때만 동작(소스되면 함수만 정의) ──
if [ "${BASH_SOURCE[0]:-$0}" = "$0" ]; then
  cmd="${1:-status}"; shift 2>/dev/null || true
  case "$cmd" in
    acquire)   lock_acquire "$@" ;;
    heartbeat) lock_heartbeat ;;
    release)   lock_release ;;
    status)    lock_status ;;
    *) echo "usage: vault-lock.sh {acquire <agent> <session> <op> <note>|heartbeat|release|status}" >&2; exit 2 ;;
  esac
fi
