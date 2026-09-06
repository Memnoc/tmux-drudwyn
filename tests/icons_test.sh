#!/usr/bin/env bash
set -eu
ROOT="$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
cat > "$TMP_DIR/tmux" <<'MOCK'
#!/usr/bin/env bash
case "$*" in
  *@drudwyn-icon-mode*) printf '%s' "${TEST_MODE:-}" ;;
  *@drudwyn-agent-icon*) printf '%s' "${TEST_CHOICE:-}" ;;
esac
MOCK
cat > "$TMP_DIR/fc-list" <<'MOCK'
#!/usr/bin/env bash
[ "${TEST_FONTS:-}" != unavailable ] || exit 127
case "$1" in
  ':charset=f06a9 e725 f0054')
    case "${TEST_FONTS:-}" in both|nerd) printf 'Nerd Font\n';; esac ;;
  'Drudwyn Symbols:charset=f0000')
    case "${TEST_FONTS:-}" in both|hound) printf 'Drudwyn Symbols\n';; esac ;;
esac
MOCK
chmod +x "$TMP_DIR/tmux" "$TMP_DIR/fc-list"
export PATH="$TMP_DIR:$PATH"
unset SSH_CONNECTION SSH_TTY
export TEST_MODE='' TEST_CHOICE='' TEST_FONTS=both
check() {
  local actual
  actual="$(bash "$ROOT/scripts/icons.sh")"
  [ "$actual" = "$(printf '%s\n%s' "$1" "$2")" ] || {
    printf 'not ok: expected %s/%s; got %s\n' "$1" "$2" "$actual"; exit 1;
  }
}
check nerd '󰀀'
TEST_FONTS=nerd; check nerd '󰚩'
TEST_FONTS=hound; check safe A
TEST_FONTS=none; check safe A
TEST_FONTS=unavailable; check safe A
TEST_MODE=nerd; check nerd '󰚩'
TEST_CHOICE=hound; check nerd '󰀀'
TEST_FONTS=both; TEST_CHOICE=bot; check nerd '󰚩'
TEST_CHOICE='*'; check nerd '*'
TEST_MODE=safe; TEST_CHOICE=hound; check safe A
TEST_MODE=auto; TEST_CHOICE=auto; export SSH_CONNECTION=remote
check safe A
TEST_MODE=nerd; check nerd '󰚩'
TEST_CHOICE=hound; check nerd '󰀀'
printf 'ok: automatic fonts, missing requirements, remote sessions, and explicit icon overrides\n'
