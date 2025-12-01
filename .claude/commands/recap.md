---
description: Get back up to speed on a repo you haven't touched in a while
---

# Recap

You're jumping back into a repo cold and need to figure out where you left off.

**This is the start-of-session command.** It syncs the worklog and gives you context.

**This is the ONLY command that can create a worklog.** Both `/polish` and `/tidy` require a worklog to exist - they'll bail and tell the user to run `/recap` first if it's missing.

## Specs to Follow

- `.claude/worklog-spec.md` - Worklog format, structure, and command flow
- `.claude/tone-spec.md` - Writing style (casual, direct, no fluff)

## Steps

1. **Gather context**
   - `git log --oneline -50` for recent commits
   - `git log main..HEAD --oneline` (or master) to see branch-specific work
   - `git status` and `git diff --stat` for uncommitted work
   - Read `.claude/worklog.md` if it exists
   - Read the specs listed above

2. **Update the worklog FIRST** (before synthesizing recap)

   **If no worklog exists:**
   - Create `.claude/worklog.md` with the structure from the spec
   - Backfill the Session Log from commit history (group by date)
   - Leave Goals & Ideas empty or prompt user for initial goals
   - Ensure it's in `.gitignore`
   - Tell the user you bootstrapped it

   **If worklog exists but Session Log is stale** (commits after last entry):
   - Add entries for commits since last session entry
   - Keep it minimal for backfilled entries (just date + Did)

   **If there's uncommitted work:**
   - Note it in today's entry or create a WIP entry

3. **Synthesize the recap** (from the now-updated worklog)

   Present clearly and concisely:
   - **Goals**: What are we ultimately trying to do? (from Goals & Ideas section)
   - **Recent work**: What happened in the last few sessions?
   - **Current state**: Clean, WIP, or broken? Any uncommitted changes?
   - **What's next**: Follow the interpolation rules from the spec

4. **Keep it casual**
   - Write like you're talking to yourself
   - "You were fixing the auth bug, left it broken" not "The previous session encountered issues with authentication"
