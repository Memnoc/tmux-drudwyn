#!/usr/bin/env bash

set -eu

repository="${TMUX_DRUDWYN_REPOSITORY:-Memnoc/tmux-drudwyn}"
version="${TMUX_DRUDWYN_VERSION:-latest}"
if [ "$version" = latest ]; then
  release_path='releases/latest/download'
else
  release_path="releases/download/$version"
fi
base_url="${TMUX_DRUDWYN_BASE_URL:-https://github.com/$repository/$release_path}"
install_dir="${TMUX_DRUDWYN_INSTALL_DIR:-$HOME/.local/bin}"

case "$(uname -s)-$(uname -m)" in
  Linux-x86_64) target='x86_64-unknown-linux-gnu' ;;
  Linux-aarch64|Linux-arm64) target='aarch64-unknown-linux-gnu' ;;
  Darwin-x86_64) target='x86_64-apple-darwin' ;;
  Darwin-arm64|Darwin-aarch64) target='aarch64-apple-darwin' ;;
  *)
    printf 'tmux-drudwyn: unsupported platform: %s %s\n' "$(uname -s)" "$(uname -m)" >&2
    exit 1
    ;;
esac

archive="tmux-drudwyn-${target}.tar.gz"
temporary="$(mktemp -d)"
trap 'rm -rf "$temporary"' EXIT

curl --fail --location --silent --show-error "$base_url/$archive" -o "$temporary/$archive"
curl --fail --location --silent --show-error "$base_url/SHA256SUMS" -o "$temporary/SHA256SUMS"
expected="$(awk -v file="$archive" '
  {
    name = $2
    sub(/^\*/, "", name)
    sub(/^\.\//, "", name)
    if (name == file) { print $1; exit }
  }
' "$temporary/SHA256SUMS")"
[ -n "$expected" ] || {
  printf 'tmux-drudwyn: checksum is missing for %s\n' "$archive" >&2
  exit 1
}
if command -v sha256sum >/dev/null 2>&1; then
  actual="$(sha256sum "$temporary/$archive" | awk '{print $1}')"
else
  actual="$(shasum -a 256 "$temporary/$archive" | awk '{print $1}')"
fi
[ "$actual" = "$expected" ] || {
  printf 'tmux-drudwyn: checksum verification failed for %s\n' "$archive" >&2
  exit 1
}

tar -xzf "$temporary/$archive" -C "$temporary"
candidate="$temporary/tmux-drudwyn/tmux-drudwyn"
[ -x "$candidate" ] || {
  printf 'tmux-drudwyn: release archive does not contain the binary\n' >&2
  exit 1
}
mkdir -p "$install_dir"
install -m 0755 "$candidate" "$install_dir/tmux-drudwyn"
printf 'Installed tmux-drudwyn to %s\n' "$install_dir/tmux-drudwyn"
