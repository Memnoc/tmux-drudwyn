# Agent integrations

[Documentation](README.md) · [Project home](../README.md)

Automatic terminal classification works without setup. Optional hooks provide
exact lifecycle transitions and take precedence over observation.

| Agent              | Integration                                  | Without it           |
| ------------------ | -------------------------------------------- | -------------------- |
| Codex CLI 0.151.0+ | Lifecycle hooks in `~/.codex/config.toml`    | Terminal observation |
| Claude Code        | Lifecycle hooks in `~/.claude/settings.json` | Terminal observation |
| OpenCode           | Local event plugin                           | Terminal observation |

<details>
<summary>Codex CLI hooks</summary>

Replace `/path/to` with the plugin checkout:

```toml
[hooks]
userPromptSubmit = [{ type = "command", command = "/path/to/tmux-drudwyn/scripts/codex-hook.sh userPromptSubmit" }]
permissionRequest = [{ type = "command", command = "/path/to/tmux-drudwyn/scripts/codex-hook.sh permissionRequest" }]
stop = [{ type = "command", command = "/path/to/tmux-drudwyn/scripts/codex-hook.sh stop" }]
interrupt = [{ type = "command", command = "/path/to/tmux-drudwyn/scripts/codex-hook.sh interrupt" }]
```

Review and trust the commands when Codex prompts you.

</details>

<details>
<summary>Claude Code hooks</summary>

Hooks keep the display current by refreshing it after relevant tmux events.

Add this inside the `hooks` object in `~/.claude/settings.json`, replacing
`/path/to` with the plugin checkout:

```json
{
  "UserPromptSubmit": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "/path/to/tmux-drudwyn/scripts/claude-hook.sh UserPromptSubmit"
        }
      ]
    }
  ],
  "PermissionRequest": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "/path/to/tmux-drudwyn/scripts/claude-hook.sh PermissionRequest"
        }
      ]
    }
  ],
  "Stop": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "/path/to/tmux-drudwyn/scripts/claude-hook.sh Stop"
        }
      ]
    }
  ],
  "StopFailure": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "/path/to/tmux-drudwyn/scripts/claude-hook.sh StopFailure"
        }
      ]
    }
  ]
}
```

</details>

<details>
<summary>OpenCode plugin</summary>
Optional. Relays OpenCode lifecycle events for immediate, exact status updates. Without it, terminal observation still works.

```sh
mkdir -p ~/.config/opencode/plugins
cp /path/to/tmux-drudwyn/integrations/opencode-drudwyn.js \
  ~/.config/opencode/plugins/tmux-drudwyn.js
```

Replace `/path/to` inside the copied file with the plugin checkout.

</details>

Hooks ignore event payload content and use the inherited `TMUX_PANE` to update
the correct window. See [Privacy and local data flow](privacy.md) for the
full data boundary.
