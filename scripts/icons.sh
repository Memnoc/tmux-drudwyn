#!/usr/bin/env bash
# Shared icon policy, also embedded in the Rust binary for standalone installs.
set -eu
mode="$(tmux show-option -gqv @drudwyn-icon-mode 2>/dev/null || true)"
choice="$(tmux show-option -gqv @drudwyn-agent-icon 2>/dev/null || true)"
mode="${mode:-auto}"
choice="${choice:-auto}"

font_present() {
  command -v fc-list >/dev/null 2>&1 || return 1
  [ -n "$(fc-list "$1" -f '%{family}\n' 2>/dev/null)" ]
}

case "$mode" in
  nerd) ;;
  auto)
    # Fontconfig describes this host, not the terminal at the other end of SSH.
    if [ -z "${SSH_CONNECTION:-}${SSH_TTY:-}" ] &&
      font_present ':charset=f06a9 e725 f0054'; then
      mode=nerd
    else
      mode=safe
    fi
    ;;
  *) mode=safe ;;
esac

agent=A
if [ "$mode" = nerd ]; then
  agent='󰚩'
  case "$choice" in
    auto)
      if [ -z "${SSH_CONNECTION:-}${SSH_TTY:-}" ] &&
        font_present 'Drudwyn Symbols:charset=f0000'; then
        agent='󰀀'
      fi
      ;;
    hound) agent='󰀀' ;;
    bot) ;;
    *) agent="$choice" ;; # Preserve the existing custom-glyph override.
  esac
fi
printf '%s\n%s\n' "$mode" "$agent"
