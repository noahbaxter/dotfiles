---
description: Analyze messy working changes and commit them in logical, atomic chunks that match your existing commit style
---

# Tidy Commit

You have working but messy changes that need to be committed properly.

## Steps

1. **Understand the state**
   - `git status` to see what's changed
   - `git diff` to understand the actual changes
   - `git log -10 --oneline` to learn the commit style (casing, format, verbosity)

2. **Group changes logically**
   - Related files go together (e.g., package.json + lockfile)
   - Config/tooling changes separate from feature code
   - Each commit should be one coherent "thing"

3. **Skip working cruft**
   - Do NOT commit .md files, docs, or notes unless explicitly requested
   - Ignore scratch files, temp configs, TODO lists, research dumps
   - Documentation should be intentional - if it looks like "working notes" leave it out
   - When in doubt, ask - don't just bundle random stuff into commits

4. **Propose a plan**
   - List each commit with its files and draft message
   - Explicitly list files being skipped and why
   - Match the tone and format from the repo's history
   - Keep messages concise - if it needs a paragraph, it's probably multiple commits

5. **Execute after approval**
   - Stage and commit each group sequentially
   - Stop if something looks wrong

6. **Update worklogs**
   After commits are done:
   - Ask the user: "What's next? (or skip)"
   - Append an entry to `.claude/worklog.md` (repo-local, create if needed)
   - Append a one-liner to `~/.claude/worklog.md` (global)
   - Make sure `.claude/worklog.md` is in `.gitignore`

## Worklog format

**Repo worklog (`.claude/worklog.md`):**
```markdown
## YYYY-MM-DD
- Committed: [summary of what was just committed]
- Next: [user's answer, or "unspecified"]
```

**Global worklog (`~/.claude/worklog.md`):**
```markdown
## YYYY-MM-DD
- **repo-name**: [one-liner summary of commits]
```

Keep it terse. Breadcrumbs, not documentation.
