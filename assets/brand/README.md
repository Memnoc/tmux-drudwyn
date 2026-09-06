# Drudwyn static icon

The Drudwyn logo and white silhouette icon are **AI-generated artwork**, created
with OpenAI's image generation tools and refined through human-directed prompts.

`drudwyn-white.png` is a white seated-hound silhouette with an actual transparent
alpha channel, generated from `docs/images/brand/drudwyn-logo-v3.png` using
OpenAI's built-in image generation tool on 2026-09-06.

This is an initial raster asset. Fine edge speckling remains in the generated
cutouts; inspect at the intended display size before using it in a polished UI.
The existing full-colour README logo remains the primary mark.

The PNG and this note are included under `assets/brand/` in release archives.
The cockpit embeds the PNG in the binary and renders a small white silhouette
beside its title using Unicode half-block characters. This works without a
custom font or terminal image protocol. Windows smaller than 70 columns or 24
rows use the compact text header. The icon sits on a dark tile so it remains
visible with the light Dawn theme too.

Open it with `prefix + P`. The status bar and font settings are unchanged. The
binary-only installer includes the embedded icon but does not install the
standalone companion files.

Generation provenance is recorded here, not a guarantee of originality,
exclusive copyright, or trademark clearance. The repository licence applies
to the extent the project holds applicable rights.

## Optional status-bar glyph

`DrudwynSymbols-Regular.ttf` contains the hound at private-use codepoint
`U+F0000` in the **Drudwyn Symbols** family. This is a preview font derived from
the approved PNG, not a replacement for your existing Nerd Font. It is bundled
in release archives alongside the PNG. Private-use assignments are local to
the font; this is not an official Unicode or Nerd Fonts icon.

Install it using your OS font installer. On Linux, copy it into
`~/.local/share/fonts/Drudwyn/` and run `fc-cache -f`. Restart or reload your
terminal so it discovers the font. If font fallback does not select it, map
`U+F0000` to `Drudwyn Symbols` in your terminal's font settings.

With Nerd Font mode enabled, try the icon in the running tmux server:

```sh
tmux set-option -g @drudwyn-agent-icon "$(printf '\\U000f0000')"
tmux refresh-client -S
```

If it displays as a missing-glyph box, restore the default bot with
`tmux set-option -gu @drudwyn-agent-icon`. Safe icon mode always uses ASCII.
To keep the hound after restarting tmux, save the option and glyph in
`~/.tmux.conf` after confirming your terminal renders it correctly.

Rebuild the font with `python3 tooling/fonts/build-drudwyn-font.py` using
fonttools 4.64.0 and Pillow 12.3.0. The script reads the source PNG without
modifying it, traces its alpha mask, and fits the outline into a text cell.

## PNG generation prompt

Use case: background-extraction / logo-brand. Edit the supplied Drudwyn logo into a standalone app resource PNG: preserve the recognizable seated hound facing right with raised muzzle, floppy ear, curved tail, and simple haunch cutout. Remove the entire scalloped badge, rim, and interior background. Render ONLY the dog as a simplified solid pure white (#FFFFFF) silhouette with smooth crisp antialiased edges. All background and the ear/haunch negative spaces must be genuinely transparent alpha, never painted black or a checkerboard. No gradients, shadows, texture, lettering, border, other objects or ornaments. Center the hound in a square canvas with roughly 10% clear padding on top and bottom, retaining natural proportions. Design to remain legible at small icon sizes. Output one transparent PNG.
