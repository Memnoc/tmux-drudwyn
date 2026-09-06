# Repository README standard

[Documentation](README.md) · [Contributing](../CONTRIBUTING.md)

The reusable standard lives in [the repo-readme skill](../tooling/skills/repo-readme/SKILL.md),
with a [starter template](../tooling/skills/repo-readme/assets/README.template.md).
It captures the Drudwyn layout for use across repositories:

1. Small logo, centered display name, benefit-led tagline, and one clear sentence.
2. One hero image, useful badges, and a compact row of navigation links.
3. A runnable quickstart ending in an observable first success.
4. Essential everyday actions, with detailed reference moved into focused guides.
5. A documentation index separating user tasks from maintainer background.

Use each product's own identity and supported workflows. The standard does not
require Drudwyn's logo, colors, tmux commands, or a “built with” badge.

## Use the skill in other repositories

Copy the versioned skill into your personal skills directory:

```sh
mkdir -p ~/.codex/skills
cp -R tooling/skills/repo-readme ~/.codex/skills/
```

Invoke `$repo-readme` when creating or restructuring another repository's README.
It is also discoverable for relevant README presentation work. To update an
installed copy, copy the skill directory again from this repository.
