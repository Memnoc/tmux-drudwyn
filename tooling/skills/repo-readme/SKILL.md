---
name: repo-readme
description: "Create or restructure a repository README using the Drudwyn presentation style: a compact branded opening, linked navigation, an executable quickstart, and focused documentation guides. Use for repository presentation or onboarding work, not ordinary prose edits."
---

# Repository README style

Use Drudwyn's readable GitHub layout as the default across the user's repositories.
Adapt the content to the product. The style is reusable; its hound logo, tmux
commands, palette, and mythology belong to Drudwyn.

## Establish what is true

Read the existing README, install/build entrypoints, package manifest, docs, and
repository guidance. Determine the display name, repository slug, supported
platforms, prerequisites, and shortest supported path to a successful first use.
Preserve working commands, important constraints, and user-authored configuration.
A README redesign does not authorize renaming a repository, changing runtime
settings, publishing a release, or inventing a reporting/contact channel.

## Build the opening

Use [the template](assets/README.template.md) as a starting point:

- Center a small existing logo (roughly 96–120 px wide) above the display name.
  Preserve its aspect ratio. Verify real alpha transparency if transparency is
  intended; a checkerboard printed into a PNG is not transparency.
- Use a clean display title, one short benefit-led tagline, and one explanatory
  sentence. Keep technical slugs in commands and links rather than the title.
- Show one existing hero or product overview image. Prefer a readable actual
  interface or simple diagram. Do not repeat it further down the README.
- Keep badges few and useful: supported platforms, license, or an actual release
  or check status. Do not add a “Built with <language>” badge. Never invent social
  proof, benchmark numbers, or passing status.
- Add one compact centered navigation row with working relative links or anchors:
  Install, Overview, Use, Docs, Releases, and relevant product-specific destinations.
  Omit destinations that do not exist. Around 5–7 links usually stays readable.

Use GitHub-supported Markdown and basic HTML (`p`, `h1`, `img`, `a`). Avoid custom
CSS, scripts, tables used solely for layout, or assumptions about a fixed theme.
Keep essential meaning in text and image alt text, not only in artwork.

## Give readers a complete first-use path

Keep the README focused on purpose, installation, an observable first success,
essential actions, and onward links. Aim for roughly 100–160 lines when that fits
without hiding necessary setup. This is a readability target, not a hard limit.

State prerequisites and where to run commands. Identify one recommended install
path; move alternatives to an installation guide. Explicitly distinguish a
published release from source pulled from a development branch when they can
contain different features. End the quickstart with what to open/run and what
the user should see. Explain unfamiliar shortcut notation once.

Move long configuration tables, integration snippets, maintenance steps, and
troubleshooting into focused Markdown guides indexed from `docs/README.md`.
Reuse and relocate existing material rather than dropping it. Fix moved relative
links; retain previously shared top-level anchors as concise link sections where
useful. Keep architecture and research under a maintainer/background section.

Add a concise contributor entry point when relevant, with setup, a directory map,
and actual validation commands. Do not add a docs website, elaborate contribution
gates, issue templates, or security policies solely to imitate a larger project.

## Verify and deliver

Check local links, anchors, image paths, fenced command syntax, and whitespace.
Validate new commands against repository behavior without running install or
mutation examples against the user's live setup just to test documentation.
Inspect the opening at README scale when a renderer is available. Prefer existing
relevant documentation checks over running unrelated application suites.

Respect the user's branch and commit/push instructions. Summarize what changed,
what was verified, and provide the GitHub preview link when pushed.
