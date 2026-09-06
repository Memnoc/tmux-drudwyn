# Configuration

[Documentation](README.md) · [Project home](../README.md)

Defaults work without configuration. You can set overrides before loading the plugin.

### Common options

| Option                       | Default | Purpose                                    |
| ---------------------------- | ------- | ------------------------------------------ |
| `@drudwyn-agent`         | `codex` | Agent started for new worktrees            |
| `@drudwyn-base-branch`   | `main`  | Base for new tasks and finished-work validation      |
| `@drudwyn-branch-prefix` | `work/` | Prefix for generated branches              |
| `@drudwyn-theme`         | `moon`  | `rose-pine`, `moon`, or `dawn`             |
| `@drudwyn-icon-mode`     | `auto`  | Prefer Nerd Fonts when detected; `nerd` forces them, `safe` uses ASCII |
| `@drudwyn-agent-icon`    | `auto`  | Prefer the installed hound, else bot; `hound` forces it, `bot` opts out |
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

## Icons and font fallback

The status bar, workspace navigator, and cockpit details share the same icon
settings. With no overrides, local Fontconfig detection prefers Nerd Font
symbols and the hound at `U+F0000` from **Drudwyn Symbols**. If that font is
missing, agent icons use the Nerd Font bot. If the Nerd Font glyphs are missing
or detection is unavailable, agent icons use `A` and the status bar uses ASCII
labels for Git and overflow.

Install a Nerd Font and select it in your terminal. Install
[`DrudwynSymbols-Regular.ttf`](../assets/brand/DrudwynSymbols-Regular.ttf) alongside
it, then restart the terminal. On Linux:

```sh
mkdir -p ~/.local/share/fonts/Drudwyn
cp assets/brand/DrudwynSymbols-Regular.ttf ~/.local/share/fonts/Drudwyn/
fc-cache -f ~/.local/share/fonts/Drudwyn
```

On macOS, open the TTF in Font Book and install it. Fonts belong on the computer
running the terminal, not just on an SSH server. The binary installer does not
install fonts for you; the TTF ships in the checkout and release archive.

Detection uses `fc-list` to check the required glyph coverage and hound family.
It establishes local font availability, not which font the terminal actually
uses. Detected SSH environments (`SSH_CONNECTION` or `SSH_TTY`) disable automatic
font assumptions. Without Fontconfig, auto mode uses ASCII. A long-running tmux
server can also have stale SSH environment values; multiple attached clients
share the global icon settings. Set overrides for the terminal you use:

```tmux
# Default: prefer the hound and Nerd Fonts, with detection-based fallback.
set -g @drudwyn-icon-mode auto
set -g @drudwyn-agent-icon auto

# To opt out of the hound while keeping detected Nerd Font symbols:
# set -g @drudwyn-agent-icon bot

# With fonts verified on a remote client or a system without Fontconfig:
# set -g @drudwyn-icon-mode nerd
# set -g @drudwyn-agent-icon hound

# If your terminal shows missing-glyph boxes:
# set -g @drudwyn-icon-mode safe
```

Explicit `nerd` and `hound` bypass detection; safe mode always wins over the
agent selection. Existing custom glyph values remain supported. Setting
`@drudwyn-agent-icon bot` is now the way to restore the bot; unsetting it restores
automatic hound preference. If fallback selects the wrong font, map `U+F0000`
to **Drudwyn Symbols** in your terminal. Reload tmux configuration and reopen
existing navigator/cockpit popups to apply icon changes.

## Upgrading existing options

The plugin imports old `@agent-watch-*` settings into `@drudwyn-*` when loaded,
including Nerd Font mode and custom symbols. Explicit new settings take precedence.
See [the upgrade guide](upgrading-to-drudwyn.md).

## Apply changes

Place options in `~/.tmux.conf` before the plugin is loaded, then run this from a terminal inside tmux:

```sh
tmux source-file ~/.tmux.conf
```

The legacy mode reads pane scrollback. See the [version boundary](privacy.md#version-boundary) before enabling it.
