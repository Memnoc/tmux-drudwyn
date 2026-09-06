#!/usr/bin/env bash

set -u
source "$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)/lib.sh"

current_pid="$(tmux show-option -gqv @drudwyn_watcher_pid 2>/dev/null || true)"
if [ -n "$current_pid" ] && kill -0 "$current_pid" 2>/dev/null; then
  exit 0
fi

interval="$(tmux_option @drudwyn-interval 2)"
(
  trap 'exit 0' TERM INT
  while tmux list-sessions >/dev/null 2>&1; do
    if [ "$(tmux_option @drudwyn-v2 on)" = on ]; then
      "$PLUGIN_DIR/scripts/v2.sh" scan
    else
      "$PLUGIN_DIR/scripts/scan.sh"
    fi
    sleep "$interval"
  done
) >/dev/null 2>&1 &

tmux set-option -gq @drudwyn_watcher_pid "$!"
