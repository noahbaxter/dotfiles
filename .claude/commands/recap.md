---
description: Get back up to speed on a repo you haven't touched in a while
---

# Recap

You're jumping back into a repo cold and need to figure out where you left off.

## Steps

1. **Gather context**
   - `git log -15 --oneline` for recent commits
   - `git log main..HEAD --oneline` (or master) to see branch-specific work
   - `git status` and `git diff --stat` for uncommitted work
   - Read `.claude/worklog.md` if it exists
   - Read `~/.claude/worklog.md` and filter for entries mentioning this repo

2. **Synthesize a recap**
   Present this clearly and concisely:
   - **Project context**: What is this repo/what does it do (brief, from README or memory)
   - **What you were working on**: The feature/bug/goal based on recent commits and worklog
   - **Where you left off**: Last commit, any uncommitted changes, mid-task state
   - **What's next**: From worklog "next" notes or inferred from context
   - **Bigger picture**: What this work is in service of, eventual goals

3. **Worklog maintenance**

   **If no `.claude/worklog.md` exists:**
   - Create it with an initial entry based on what you inferred
   - Check if `.claude/worklog.md` is in `.gitignore` - if not, add it
   - Tell the user you created it

   **If worklog exists but seems stale** (last entry doesn't match recent commits):
   - Note the gap and offer to update it

   **Ensure gitignore is set up:**
   - The repo worklog should NEVER be committed
   - Add `.claude/worklog.md` to `.gitignore` if not already there
   - Do NOT ignore `.claude/commands/` (those may be symlinked and intentionally tracked elsewhere)

4. **Keep it casual**
   - Don't be formal or verbose
   - Write like you're leaving notes for yourself
   - "You were fixing the crossfade clicks" not "The previous development session focused on addressing audio artifacts in the crossfade implementation"

## Worklog format

Use this format for new entries:

```markdown
## YYYY-MM-DD
- Working on: [current feature/task]
- Did: [what was accomplished]
- Next: [immediate next steps]
- Eventually: [longer term goals if relevant]
```

Keep entries terse. This isn't documentation, it's breadcrumbs.
