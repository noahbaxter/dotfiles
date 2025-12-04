---
description: Smart atomic commits with proper grouping
---

# Commit

Take a bunch of changes and create clean, atomic commits. Group logically, split when needed, write clear messages.

## Principles

- **Atomic commits**: One logical change per commit
- **Split within files**: If a file has changes for different purposes, stage them separately using `git add -p`
- **Why over what**: Commit messages explain WHY and WHAT broadly, not technical file lists
- **Don't touch working changes**: Long-untracked or long-modified files that are "just sitting there" - ask before including
- **Always ask first**: Propose the commit plan, wait for approval

## Steps

1. **Understand the changes**
   - `git status` for all modified/staged/untracked
   - `git diff` and `git diff --cached` for actual changes
   - `git log -10 --oneline` to learn the commit style
   - `ls -la` on suspicious files to check modification times

2. **Identify logical changes**

   Look at ALL changes and group by PURPOSE, not by file:
   - Feature work (the main thing you were doing)
   - Bug fixes (things you fixed along the way)
   - Refactoring (cleanup, renames, reorganization)
   - Config/tooling (build configs, dependencies, scripts)
   - Tests (new or updated tests)

   A single file might have changes belonging to multiple groups. That's fine - we'll split it.

3. **Flag working changes**

   Files that might be "working cruft" - don't commit without asking:
   - Untracked files sitting for days (check with `ls -la`)
   - .env files, local configs, scratch files
   - Debug notes, temporary scripts
   - Files with names like `test.js`, `temp.py`, `notes.md`

   Ask: "These look like working files, skip them? [list files]"

4. **Propose commit plan**

   For each commit, show:
   - **What**: Brief description of the logical change
   - **Why**: The purpose/reason (if not obvious)
   - **Files**: What's included (and what hunks if splitting)
   - **Message**: Draft commit message

   Example:
   ```
   Commit 1: Add user authentication
   - src/auth.ts (lines 1-50: new auth logic)
   - src/routes.ts (lines 23-45: auth middleware)
   - Message: "add user auth with JWT tokens"

   Commit 2: Fix validation bug
   - src/auth.ts (lines 60-75: fix only)
   - Message: "fix email validation regex missing TLD check"

   Commit 3: Update dependencies
   - package.json, package-lock.json
   - Message: "update express to 4.18 for security patch"

   Skipping:
   - .env.local (local config)
   - debug-notes.md (working notes)
   ```

   Wait for approval: "Look good? Or adjust?"

5. **Execute commits**

   For each approved commit:

   **If splitting within a file**, use `git add -p`:
   - Stage specific hunks interactively
   - Or use `git add -p <file>` and select y/n per hunk

   **If whole files**, use `git add <files>`:
   - Stage all changes in those files

   Then commit:
   ```bash
   git commit -m "message here"
   ```

   Show result after each commit.

6. **Update worklog**

   After committing, update `.claude/worklog.md`:
   - Update Last Session with what was done and current state
   - Ask: "What's next?" for the Next section
   - Ask: "Anything to add to Ideas or Backlog?"

## Commit Message Style

- Lowercase start is fine
- No period at end
- Focus on WHY and WHAT (broadly), not HOW
- One line if possible, two if needed
- Match existing repo style

**Good:**
- "add user authentication with JWT"
- "fix validation bug that allowed invalid emails"
- "update deps for security patches"

**Bad:**
- "Updated src/auth.ts, src/routes.ts, src/middleware.ts to add authentication" (file list)
- "Fix bug" (too vague)
- "Implemented comprehensive user authentication system with JWT token-based sessions" (overexplained)

## Handling Intra-File Splits

When one file has changes for multiple purposes:

1. Identify the hunks (contiguous change blocks)
2. Map each hunk to a logical commit
3. Use `git add -p <file>` to stage specific hunks
4. Commit, then stage next set of hunks

Example flow:
```bash
# Stage only auth-related hunks in auth.ts
git add -p src/auth.ts
# (select y for auth hunks, n for bug fix hunks)
git commit -m "add user auth"

# Now stage the bug fix hunks
git add -p src/auth.ts
# (select y for remaining hunks)
git commit -m "fix validation bug"
```
