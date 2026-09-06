#!/usr/bin/env bash

set -eu

directory="${1:-dist}"
[ -d "$directory" ] || {
  printf 'tmux-drudwyn: release directory not found: %s\n' "$directory" >&2
  exit 1
}

temporary="$(mktemp -d)"
trap 'rm -rf "$temporary"' EXIT

for target in \
  x86_64-unknown-linux-gnu \
  aarch64-unknown-linux-gnu \
  x86_64-apple-darwin \
  aarch64-apple-darwin
do
  archive="$directory/tmux-drudwyn-${target}.tar.gz"
  [ -f "$archive" ] || {
    printf 'tmux-drudwyn: release archive is missing: %s\n' "${archive##*/}" >&2
    exit 1
  }
  tar -tzf "$archive" > "$temporary/$target.list"
  grep -Fxq 'tmux-drudwyn/tmux-drudwyn' "$temporary/$target.list" || {
    printf 'tmux-drudwyn: binary is missing from %s\n' "${archive##*/}" >&2
    exit 1
  }
  grep -Fxq 'tmux-drudwyn/PRIVACY.md' "$temporary/$target.list" || {
    printf 'tmux-drudwyn: privacy manifest is missing from %s\n' "${archive##*/}" >&2
    exit 1
  }
done

[ "$(find "$directory" -maxdepth 1 -name '*.tar.gz' | wc -l)" -eq 4 ] || {
  printf 'tmux-drudwyn: release bundle must contain exactly four archives\n' >&2
  exit 1
}
(
  cd "$directory"
  sha256sum *.tar.gz | sort -k2 > SHA256SUMS
  sha256sum --check SHA256SUMS
)
