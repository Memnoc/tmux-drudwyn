# Upgrading to Drudwyn

[Documentation](README.md) · [Installation](installation.md)

The display name is **Drudwyn**, and the repository, binary, and Cargo package are
`tmux-drudwyn`. The GitHub repository was previously `Memnoc/tmux-agent-watch`.

## Names that changed

| Before | Now |
| --- | --- |
| `Memnoc/tmux-agent-watch` | `Memnoc/tmux-drudwyn` |
| `tmux-agent-watch.tmux` | `tmux-drudwyn.tmux` |
| `tmux-agent-watch` executable | `tmux-drudwyn` |
| `@agent-watch-*` configuration | `@drudwyn-*` |
| `AGENT_WATCH_*` environment variables | `DRUDWYN_*` |
| `TMUX_AGENT_WATCH_*` installer variables | `TMUX_DRUDWYN_*` |
| `integrations/opencode-agent-watch.js` | `integrations/opencode-drudwyn.js` |

The plugin imports existing configuration and live metadata when it loads.
**Nerd Font mode, themes, custom symbols, shortcuts, and other old options are
preserved.** Explicit new options take precedence. Update your configuration to
the new option names as you edit it; old imported values are not continually
synchronized with new ones.

## TPM installation

Change your plugin entry to:

```tmux
set -g @plugin 'memnoc/tmux-drudwyn'
```

Reload `~/.tmux.conf`, then press `prefix + I` to install the renamed checkout.
Build its binary and reload again:

```sh
cargo build --release --locked --manifest-path ~/.tmux/plugins/tmux-drudwyn/Cargo.toml
tmux source-file ~/.tmux.conf
```

Remove any explicit `run-shell` line that still loads the old checkout. Keep only
one active plugin installation. Update your agent hooks before removing the old
checkout, because hook commands may refer to it by absolute path.

## Manual checkout

Inside the existing checkout, update the remote:

```sh
git remote set-url origin git@github.com:Memnoc/tmux-drudwyn.git
git pull --ff-only
cargo build --release --locked
```

A local directory name is independent of the GitHub name. If you rename that
directory too, update every absolute path in your tmux configuration and agent
hook configuration. Load the new entrypoint:

```tmux
run-shell '~/tmux-drudwyn/tmux-drudwyn.tmux'
```

Replace old `@agent-watch-` option prefixes with `@drudwyn-`, keeping the values
unchanged, then reload `~/.tmux.conf`. Close and reopen existing popup interfaces.

## Agent hooks and automation

Update the checkout path in Codex and Claude hook commands. For OpenCode, copy
`integrations/opencode-drudwyn.js` to the local plugins directory as
`tmux-drudwyn.js`, set the checkout path inside it, and remove the older plugin
copy to avoid duplicate events. See [agent integrations](agents.md).

Update custom scripts to invoke `tmux-drudwyn` and use the new environment
variable names. If you installed a binary on PATH, install the new source build:

```sh
cargo install --locked --path .
```

Verify with `tmux-drudwyn --version` and check `prefix + P` and `prefix + w`.
The version number alone may not distinguish development commits.

## Published releases

Renaming GitHub does not rename assets attached to older releases. Existing
`tmux-agent-watch-*` archives retain their old names and old code. Until a release
with `tmux-drudwyn-*` archives is published, use the source-build instructions
above. This rename does not publish or replace release artifacts.
