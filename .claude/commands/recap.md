---
description: Get back up to speed on a repo you haven't touched in a while
---

# Recap

You're jumping back into a repo cold. Answer: What am I doing? What was I doing? What should I do next?

## Steps

1. **Gather context**
   - `git log --oneline -30` for recent commits
   - `git log main..HEAD --oneline` (or master) to see branch-specific work
   - `git status` and `git diff --stat` for uncommitted work
   - Read `.claude/worklog.md` if it exists

2. **If no worklog exists, create one**

   Create `.claude/worklog.md`:
   ```markdown
   # Worklog

   ## Ideas
   [Brainstorming, possibilities, things to decide on later]

   ## Backlog
   [Deferred tasks - things mentioned but not done yet]

   ## Last Session
   [What was happening, state of things, what's next]
   ```

   Backfill Last Session from git history if there's useful context.

   Add `.claude/worklog.md` to `.gitignore` if not already there.

3. **Synthesize the recap**

   Present concisely:
   - **What you were doing**: Current focus based on recent commits + worklog
   - **State**: Clean, WIP, or broken? Uncommitted changes?
   - **Ideas**: Anything in the Ideas section worth noting
   - **Backlog**: Pending deferred tasks (high priority first)
   - **What's next**: Based on Last Session, backlog, or recent momentum

4. **Keep it brief**
   - Write like you're talking to yourself
   - "You were fixing auth, left it broken at token refresh" not "The previous session encountered authentication implementation issues"
   - Just the facts needed to continue
