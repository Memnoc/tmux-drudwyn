# Update agenda

## Next update

- [ ] Add a guided workflow to recover unfinished work from an old branch.
  - Identify commits still missing from the base branch, including after a squash merge.
  - Show the proposed commits and destination base for review.
  - Create a fresh worktree from the configured base and cherry-pick the selected commits.
  - Guide conflict resolution and hand off validation and PR creation to the workspace agent.
  - After integration, offer cleanup of the old worktree and branch, accounting for branches still checked out elsewhere.

Acceptance scenario: `chore/drudwyn-rename` contains five branding commits added
after the rename was squash-merged. Recover those commits onto current `main`
without replaying the merged rename or losing the later license and worktree-base
changes. Preserve the source branch until the recovered work is integrated and
cleanup is explicitly confirmed.
