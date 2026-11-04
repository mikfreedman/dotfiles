# Git workflow: trunk-based development

This repo uses trunk-based development. `main` is the only branch.

- Commit directly to `main`. Don't create feature branches, topic branches, or worktrees,
  even when other guidance says to branch before committing. This rule overrides that guidance.
- If you're on any other branch, switch to `main` before committing. Fast-forward any
  existing commits onto it first (`git merge --ff-only <branch>`), then delete the branch.
- Keep commits small and focused, one logical change each, so `main` always works.
- Don't open pull requests. Push to `origin main` only when asked.

# Software choices: favor open source

When adding or replacing an app, tool, or package, prefer open-source software where
reasonable.

- Pick an open-source option when it covers what's needed about as well as a closed one
  (as with Ice over Bartender, or Sol over Raycast).
- A closed-source option is fine when no open-source option fits well, but say which
  open-source options you considered and why they fell short.
- Don't swap out existing closed-source software just for this. Raise it as a suggestion
  instead.
