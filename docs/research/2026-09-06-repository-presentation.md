# Repository presentation comparison

Date: 2026-09-06

This records the repository before the documentation restructure on `docs/readme-hero`.
Descriptions of missing guides and index entries refer to that earlier state.

Scope: Headroom's public README, documentation navigation, and contributor/security entry points compared with the current tmux-drudwyn checkout. This is a presentation review, not a code or security audit. Recommendations below are judgments about this smaller project's needs.

## Findings

Headroom's README gives readers a compact navigation row, a short explanation, a numbered install/use/check sequence, and links into dedicated documentation. Its root also exposes contribution and security documents. These are useful patterns to adapt; its extensive integrations and infrastructure do not imply a need to expand this plugin's code layout. [Source: Headroom repository](https://github.com/headroomlabs-ai/headroom).

The Headroom documentation groups entry points around getting started, configuration, integrations, architecture, and help. Installation and troubleshooting are separate destinations. A Markdown index can offer the same clear routes here without running a documentation website. [Source: Headroom documentation](https://docs.headroomlabs.ai/docs).

The local [README](../../README.md) already has the requested hero and linked index, but also contains full hook configurations, extensive shortcut details, advanced and legacy options, session persistence, and release instructions. The docs directory contains privacy, design decisions, release preflight, and research material, but no general user-facing index. The [ADR index](../adr/README.md) currently lists only ADR 0001 although ADRs 0002–0004 exist.

## Recommended order

1. **Make the README a complete first-use path.** Keep the hero, concise purpose, installation steps, one real interface preview, and the essential shortcuts. End installation with an explicit reload instruction and an observable success check: open the cockpit, then locate a workspace. State prerequisites and explain tmux's prefix notation. Move detailed reference material behind links. Preserve existing section anchors or leave short linked sections so previously shared links remain useful. Evidence: the current [installation section](../../README.md#install) names a reload and cockpit shortcut but leaves the reload command implicit.

2. **Add a small documentation hub.** Create `docs/README.md` with routes for installation/update, daily use, agent integrations, configuration, troubleshooting, privacy, and contributing. Move the existing long material into a few task-oriented guides; link architecture/research as maintainer background. Add `Docs` to the hero navigation. This consolidates existing material rather than requiring new infrastructure. Evidence: current [README](../../README.md) and [docs directory](../).

3. **Explain updating alongside installing.** Clearly distinguish released binary installation from building a freshly pulled checkout. Link this guide from both the quickstart and troubleshooting. Include missing binary/PATH, absent TPM install, no exact agent state, shortcut collisions, and session save prerequisites. The bundled [installer](../../install.sh), [release workflow](../../.github/workflows/release.yml), and current README's source-build alternative provide the underlying paths; the guide should verify commands against those implementations.

4. **Give the product one concrete demonstration.** Use a short recording or sequence of actual screenshots showing “agent needs input → jump to workspace → review.” Existing [navigator imagery](../images/navigator-cockpit-surfaces.png) can be reused. Put the detailed status anatomy, responsive layout, and lifecycle diagrams in the usage guide. This is a recommendation to reduce repeated visual explanation, not a claim that more artwork is needed.

5. **Add lightweight contributor entry points.** A `CONTRIBUTING.md` should show setup, relevant checks, the Rust/shell/integration layout, and how to report a reproducible bug. Add small bug-report and PR templates if contributions warrant them. Link the existing [test runner](../../tests/run.sh) and [release preflight](../preflight-checklist.md). Headroom provides explicit development setup, coding standards, and PR workflow; this plugin needs a much shorter version. [Source: Headroom contributing guide](https://github.com/headroomlabs-ai/headroom/blob/main/CONTRIBUTING.md).

6. **Make project status and reporting easy to find.** Link GitHub Releases from the top navigation or a version badge, using the existing release process. A concise `SECURITY.md` can distinguish private vulnerability reporting from public bugs and link the existing [privacy explanation](../privacy.md). Establish a real reporting channel before publishing one; do not copy another project's contact address or response promises. Headroom's security document provides a reporting route and scope. [Source: Headroom security policy](https://github.com/headroomlabs-ai/headroom/blob/main/SECURITY.md).

## Boundaries

Start with recommendations 1–3; they address the largest navigation and onboarding gaps. Keep the existing `src/`, `scripts/`, `integrations/`, and `tests/` structure. A docs website, elaborate contribution gates, extra social badges, or a separate machine-readable documentation index would add maintenance before delivering a clear benefit at this scale. No application changes, new dependencies, or runtime tests are required for this research record.
