#!/usr/bin/env bash
set -eu
ROOT="$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)"
SOCKET="drudwyn-rename-$$"
cleanup() { tmux -L "$SOCKET" kill-server 2>/dev/null || true; }
trap cleanup EXIT
tmux -L "$SOCKET" -f /dev/null new-session -d -s rename
tmux -L "$SOCKET" set-option -g @agent-watch-icon-mode nerd
tmux -L "$SOCKET" set-option -g @agent-watch-theme moon
tmux -L "$SOCKET" set-option -g @drudwyn-theme dawn
tmux -L "$SOCKET" set-option -g @agent-watch-done-symbol '✓ ready'
tmux -L "$SOCKET" set-option -w -t rename:0 @agent_watch_state needs-input
tmux -L "$SOCKET" set-option -t rename @agent_watch_sidebar_pane %0
tmux -L "$SOCKET" set-option -p -t rename:0.0 @agent_watch_sidebar 1
tmux -L "$SOCKET" run-shell "bash '$ROOT/scripts/migrate-options.sh'"
[ "$(tmux -L "$SOCKET" show-option -gqv @drudwyn-icon-mode)" = nerd ]
[ "$(tmux -L "$SOCKET" show-option -gqv @drudwyn-theme)" = dawn ]
[ "$(tmux -L "$SOCKET" show-option -gqv @drudwyn-done-symbol)" = '✓ ready' ]
[ "$(tmux -L "$SOCKET" show-option -wqv -t rename:0 @drudwyn_state)" = needs-input ]
[ "$(tmux -L "$SOCKET" show-option -qv -t rename @drudwyn_sidebar_pane)" = %0 ]
[ "$(tmux -L "$SOCKET" show-option -pqv -t rename:0.0 @drudwyn_sidebar)" = 1 ]
tmux -L "$SOCKET" set-option -g @drudwyn-icon-mode safe
tmux -L "$SOCKET" run-shell "bash '$ROOT/scripts/migrate-options.sh'"
[ "$(tmux -L "$SOCKET" show-option -gqv @drudwyn-icon-mode)" = safe ]
printf 'ok: rename preserves Nerd Fonts, custom symbols, scoped state, and explicit new settings\n'
