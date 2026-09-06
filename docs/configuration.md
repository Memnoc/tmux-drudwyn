# Configuration

[Documentation](README.md) · [Project home](../README.md)

Defaults work without configuration. You can set overrides before loading the plugin.

### Common options

| Option                       | Default | Purpose                                    |
| ---------------------------- | ------- | ------------------------------------------ |
| `@agent-watch-agent`         | `codex` | Agent started for new worktrees            |
| `@agent-watch-base-branch`   | `main`  | Branch used to validate finished work      |
| `@agent-watch-branch-prefix` | `work/` | Prefix for generated branches              |
| `@agent-watch-theme`         | `moon`  | `rose-pine`, `moon`, or `dawn`             |
| `@agent-watch-icon-mode`     | `safe`  | Use `nerd` for Nerd Font icons             |
| `@agent-watch-redact-labels` | `off`   | Hide workspace labels while screen sharing |
| `@agent-watch-sidebar`       | `off`   | Enable the legacy sidebar                  |

Example:

```tmux
set -g @agent-watch-agent claude
set -g @agent-watch-base-branch trunk
set -g @agent-watch-branch-prefix quick-win/
set -g @agent-watch-theme rose-pine
```

<details>
<summary>Keys, refresh intervals, and advanced options</summary>

| Option                                | Default | Purpose                                                                |
| ------------------------------------- | ------- | ---------------------------------------------------------------------- |
| `@agent-watch-interval`               | `2`     | Agent scan interval in seconds                                         |
| `@agent-watch-git-interval`           | `10`    | Git refresh interval in seconds                                        |
| `@agent-watch-next-key`               | `a`     | Jump-to-attention key                                                  |
| `@agent-watch-sidebar-key`            | `Space` | Sidebar toggle key                                                     |
| `@agent-watch-restart-key`            | `A`     | Sidebar restart key                                                    |
| `@agent-watch-worktree-key`           | `W`     | Worktree creation key                                                  |
| `@agent-watch-finish-key`             | `X`     | Worktree finish key                                                    |
| `@agent-watch-cockpit-key`            | `P`     | Cockpit key                                                            |
| `@agent-watch-navigator-key`          | `w`     | Navigator key                                                          |
| `@agent-watch-native-navigator-key`   | `C-w`   | Native tmux tree key                                                   |
| `@agent-watch-session-key`            | `s`     | Session navigator key                                                  |
| `@agent-watch-native-session-key`     | `S`     | Native tmux session tree key                                           |
| `@agent-watch-help-key`               | `H`     | Help key                                                               |
| `@agent-watch-v2`                     | `on`    | Rust implementation; `off` selects the content-reading legacy fallback |
| `@agent-watch-hud`                    | `on`    | Lifecycle HUD                                                          |
| `@agent-watch-status`                 | `off`   | Legacy status display                                                  |
| `@agent-watch-sidebar-width`          | `3`     | Collapsed sidebar width                                                |
| `@agent-watch-sidebar-expanded-width` | `38`    | Expanded sidebar width                                                 |

Lifecycle colors and symbols use `@agent-watch-{working,needs-input,done,failed}-color`
and `@agent-watch-{working,needs-input,done,failed}-symbol`.

</details>

## Apply changes

Place options in `~/.tmux.conf` before the plugin is loaded, then run this from a terminal inside tmux:

```sh
tmux source-file ~/.tmux.conf
```

The legacy mode reads pane scrollback. See the [version boundary](privacy.md#version-boundary) before enabling it.
