# Configuration

[Documentation](README.md) · [Project home](../README.md)

Defaults work without configuration. You can set overrides before loading the plugin.

### Common options

| Option                       | Default | Purpose                                    |
| ---------------------------- | ------- | ------------------------------------------ |
| `@drudwyn-agent`         | `codex` | Agent started for new worktrees            |
| `@drudwyn-base-branch`   | `main`  | Branch used to validate finished work      |
| `@drudwyn-branch-prefix` | `work/` | Prefix for generated branches              |
| `@drudwyn-theme`         | `moon`  | `rose-pine`, `moon`, or `dawn`             |
| `@drudwyn-icon-mode`     | `safe`  | Use `nerd` for Nerd Font icons             |
| `@drudwyn-redact-labels` | `off`   | Hide workspace labels while screen sharing |
| `@drudwyn-sidebar`       | `off`   | Enable the legacy sidebar                  |

Example:

```tmux
set -g @drudwyn-agent claude
set -g @drudwyn-base-branch trunk
set -g @drudwyn-branch-prefix quick-win/
set -g @drudwyn-theme rose-pine
```

<details>
<summary>Keys, refresh intervals, and advanced options</summary>

| Option                                | Default | Purpose                                                                |
| ------------------------------------- | ------- | ---------------------------------------------------------------------- |
| `@drudwyn-interval`               | `2`     | Agent scan interval in seconds                                         |
| `@drudwyn-git-interval`           | `10`    | Git refresh interval in seconds                                        |
| `@drudwyn-next-key`               | `a`     | Jump-to-attention key                                                  |
| `@drudwyn-sidebar-key`            | `Space` | Sidebar toggle key                                                     |
| `@drudwyn-restart-key`            | `A`     | Sidebar restart key                                                    |
| `@drudwyn-worktree-key`           | `W`     | Worktree creation key                                                  |
| `@drudwyn-finish-key`             | `X`     | Worktree finish key                                                    |
| `@drudwyn-cockpit-key`            | `P`     | Cockpit key                                                            |
| `@drudwyn-navigator-key`          | `w`     | Navigator key                                                          |
| `@drudwyn-native-navigator-key`   | `C-w`   | Native tmux tree key                                                   |
| `@drudwyn-session-key`            | `s`     | Session navigator key                                                  |
| `@drudwyn-native-session-key`     | `S`     | Native tmux session tree key                                           |
| `@drudwyn-help-key`               | `H`     | Help key                                                               |
| `@drudwyn-v2`                     | `on`    | Rust implementation; `off` selects the content-reading legacy fallback |
| `@drudwyn-hud`                    | `on`    | Lifecycle HUD                                                          |
| `@drudwyn-status`                 | `off`   | Legacy status display                                                  |
| `@drudwyn-sidebar-width`          | `3`     | Collapsed sidebar width                                                |
| `@drudwyn-sidebar-expanded-width` | `38`    | Expanded sidebar width                                                 |

Lifecycle colors and symbols use `@drudwyn-{working,needs-input,done,failed}-color`
and `@drudwyn-{working,needs-input,done,failed}-symbol`.

</details>

## Upgrading existing options

To replace the status bar's bot with the optional hound font glyph, see
[the font installation and preview instructions](../assets/brand/README.md#optional-status-bar-glyph).
`@drudwyn-agent-icon` overrides the agent icon in Nerd Font mode only; unset it
to restore the default bot. Other Nerd Font symbols are unaffected.

The plugin imports old `@agent-watch-*` settings into `@drudwyn-*` when loaded,
including Nerd Font mode and custom symbols. Explicit new settings take precedence.
See [the upgrade guide](upgrading-to-drudwyn.md).

## Apply changes

Place options in `~/.tmux.conf` before the plugin is loaded, then run this from a terminal inside tmux:

```sh
tmux source-file ~/.tmux.conf
```

The legacy mode reads pane scrollback. See the [version boundary](privacy.md#version-boundary) before enabling it.
