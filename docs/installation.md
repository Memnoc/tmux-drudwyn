# Installation and updates

[Documentation](README.md) · [Project home](../README.md)

## Requirements

- Linux or macOS, with tmux supporting `display-popup`.
- Bash and Git available on your PATH.
- Codex, Claude Code, or OpenCode installed separately to run agent tasks.
- Rust and Cargo for a source build, or `curl`, `tar`, and `sha256sum`/`shasum` for the release installer.
- [TPM](https://github.com/tmux-plugins/tpm) if using the plugin-manager route.

Run commands below in a terminal inside a running tmux session. If your tmux
configuration is somewhere other than `~/.tmux.conf`, use that path when reloading.
The scripts must remain in their checkout after installation.

## Install with TPM

Follow the [README quickstart](../README.md#install). It builds the binary from
the same checkout as the scripts, so both contain the same changes.

## Install a checkout without TPM

Clone into a directory you intend to keep:

```sh
git clone https://github.com/Memnoc/tmux-agent-watch.git ~/tmux-agent-watch
cargo build --release --locked --manifest-path ~/tmux-agent-watch/Cargo.toml
```

Add this to `~/.tmux.conf`, after other plugins or themes that configure the status bar:

```tmux
run-shell '~/tmux-agent-watch/tmux-agent-watch.tmux'
```

Reload and open the cockpit:

```sh
tmux source-file ~/.tmux.conf
```

Press `prefix + P` (normally `Ctrl+b`, then `Shift+p`). The Workspace Cockpit
should open. Close it with `Esc`, then press `prefix + w` to find an existing
window. If either popup fails, see [troubleshooting](troubleshooting.md).

## Use a released binary

The bundled installer downloads the latest published release for Linux or macOS
on x86_64 or ARM64, verifies its checksum, and installs it to `~/.local/bin`:

```sh
~/.tmux/plugins/tmux-agent-watch/install.sh
```

Use your actual checkout path if you did not install with TPM. Ensure
`~/.local/bin` is on the PATH available to tmux. Check the installed binary with:

```sh
~/.local/bin/tmux-agent-watch --version
```

A published release can lag behind a pulled branch. Check the
[release notes](https://github.com/Memnoc/tmux-agent-watch/releases) and use scripts
from the matching release. For the features in a development checkout, build
from that checkout instead.

## Update a pulled checkout

Pull your intended branch if you have not already done so, then rebuild and reload.
For a TPM checkout:

```sh
cd ~/.tmux/plugins/tmux-agent-watch
git pull --ff-only
cargo build --release --locked
tmux source-file ~/.tmux.conf
```

For a manual checkout, change the first command to its directory. If you have
already pulled, start with the build command. TPM updates do not rebuild Rust.
Close and reopen any navigator or cockpit popup that was open before the update.

## Which binary runs?

The plugin launcher checks these locations in order:

1. `AGENT_WATCH_V2_BIN`, if explicitly set.
2. `target/release/tmux-agent-watch` inside the plugin checkout.
3. `tmux-agent-watch` on PATH.

A local release build therefore takes precedence over a downloaded binary.
Rebuild it after pulling scripts; replacing only the PATH binary will not update
that local build.

If you also want the command available in your shell, install from source with:

```sh
cargo install --locked --path ~/.tmux/plugins/tmux-agent-watch
```

Cargo normally installs to `~/.cargo/bin`. This does not replace an existing
`target/release` build in the checkout. See [missing or old binaries](troubleshooting.md#missing-or-old-binary)
if the shell and plugin appear to run different versions.
