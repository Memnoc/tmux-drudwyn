#!/usr/bin/env bash

set -u
source "$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)/lib.sh"

current_pid="$(tmux show-option -gqv @drudwyn_watcher_pid 2>/dev/null || true)"
if [ "${1:-}" = --restart ] && [ -n "$current_pid" ]; then
  # A PID can have been reused; stop only this plugin's watcher process.
  case "$(ps -p "$current_pid" -o args= 2>/dev/null || true)" in
    *"$PLUGIN_DIR/scripts/start-watcher.sh"*) kill -TERM "$current_pid" 2>/dev/null || true ;;
  esac
  tmux set-option -gu @drudwyn_watcher_pid
  current_pid=''
fi
if [ -n "$current_pid" ] && kill -0 "$current_pid" 2>/dev/null; then
  exit 0
fi

(
  trap 'exit 0' TERM INT
  while tmux list-sessions >/dev/null 2>&1; do
    if [ "$(tmux_option @drudwyn-v2 on)" = on ]; then
      "$PLUGIN_DIR/scripts/v2.sh" scan
    else
      "$PLUGIN_DIR/scripts/scan.sh"
    fi
    sleep "$(tmux_option @drudwyn-interval 2)"
  done
) >/dev/null 2>&1 &

tmux set-option -gq @drudwyn_watcher_pid "$!"
