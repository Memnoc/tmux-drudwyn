#!/usr/bin/env bash

# Import pre-Drudwyn settings without overriding an explicitly configured value.
# Keep old options available to an older checkout during a rolling upgrade.
set -eu

copy_options() {
  local old new value existing
  while read -r old _; do
    case "$old" in
      @agent-watch-*) new="@drudwyn-${old#@agent-watch-}" ;;
      @agent_watch_watcher_pid) continue ;;
      @agent_watch_*) new="@drudwyn_${old#@agent_watch_}" ;;
      *) continue ;;
    esac
    existing="$(tmux show-options "$@" "$new" 2>/dev/null || true)"
    [ -z "$existing" ] || continue
    value="$(tmux show-options -qv "$@" "$old")"
    tmux set-option "$@" "$new" "$value"
  done < <(tmux show-options "$@")
}

copy_options -g
while IFS= read -r session; do
  [ -n "$session" ] && copy_options -t "$session"
done < <(tmux list-sessions -F '#{session_id}' 2>/dev/null || true)
while IFS= read -r window; do
  [ -n "$window" ] && copy_options -w -t "$window"
done < <(tmux list-windows -a -F '#{window_id}' 2>/dev/null | sort -u || true)
while IFS= read -r pane; do
  [ -n "$pane" ] && copy_options -p -t "$pane"
done < <(tmux list-panes -a -F '#{pane_id}' 2>/dev/null || true)
