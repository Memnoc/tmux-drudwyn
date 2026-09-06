#!/usr/bin/env bash

set -eu

ROOT="$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)"
target="${1:-}"
binary="${2:-}"
output="${3:-$ROOT/dist}"

[ -n "$target" ] && [ -n "$binary" ] || {
  printf 'usage: %s TARGET BINARY [OUTPUT_DIRECTORY]\n' "$0" >&2
  exit 2
}
[ -x "$binary" ] || {
  printf 'tmux-drudwyn: release binary is missing or not executable: %s\n' "$binary" >&2
  exit 1
}

archive="tmux-drudwyn-${target}.tar.gz"
stage="$(mktemp -d)"
trap 'rm -rf "$stage"' EXIT
mkdir -p "$stage/tmux-drudwyn" "$output"
install -m 0755 "$binary" "$stage/tmux-drudwyn/tmux-drudwyn"
install -m 0644 "$ROOT/LICENSE" "$stage/tmux-drudwyn/LICENSE"
install -m 0644 "$ROOT/README.md" "$stage/tmux-drudwyn/README.md"
install -m 0644 "$ROOT/docs/privacy.md" "$stage/tmux-drudwyn/PRIVACY.md"
mkdir -p "$stage/tmux-drudwyn/assets/brand"
install -m 0644 "$ROOT/assets/brand/drudwyn-white.png" "$stage/tmux-drudwyn/assets/brand/"
install -m 0644 "$ROOT/assets/brand/README.md" "$stage/tmux-drudwyn/assets/brand/"
install -m 0644 "$ROOT/assets/brand/DrudwynSymbols-Regular.ttf" "$stage/tmux-drudwyn/assets/brand/"
tar -C "$stage" -czf "$output/$archive" tmux-drudwyn
printf '%s\n' "$output/$archive"
