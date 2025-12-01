---
description: Commit changes, document progress, and wrap up the session cleanly
---

# Tidy

You're wrapping up a work session. Commit what's ready, document what happened, note where things stand.

**This is the end-of-session command.** It commits, updates the worklog, and leaves good breadcrumbs.

## Prerequisites

**Check for worklog first.** If `.claude/worklog.md` doesn't exist, STOP and tell the user to run `/recap` first. Don't proceed without a worklog.

## Specs to Follow

- `.claude/files-spec.md` - Which files to commit vs skip (READ THIS for file handling rules)
- `.claude/worklog-spec.md` - Worklog format and command flow
- `.claude/tone-spec.md` - Writing style for commits and worklog entries

## Steps

1. **Understand the state**
   - `git status` to see what's changed
   - `git diff` to understand the actual changes
   - `git log -10 --oneline` to learn the commit style
   - Read `.claude/worklog.md` and all specs listed above
   - If no worklog exists, bail with "Run /recap first"

2. **Group changes logically**
   - Related files go together (e.g., package.json + lockfile)
   - Config/tooling changes separate from feature code
   - Each commit should be one coherent "thing"

3. **Skip working cruft**
   - Apply file handling rules from `files-spec.md`
   - When in doubt, ask

4. **Propose a commit plan**
   - List each commit with its files and draft message
   - Explicitly list files being skipped and why
   - Match the repo's commit style
   - Keep messages concise

5. **Execute after approval**
   - Stage and commit each group sequentially
   - Stop if something looks wrong

6. **Update the worklog**

   **Ask the user:**
   - "What's next?" (for the Next field)
   - "Anything to add to Goals & Ideas?" (optional)
   - "How are we leaving things - clean, WIP, or broken?"

   **Create/update today's session entry:**
   - Check if there's already an entry for today (may exist from `/polish`)
   - If yes: flesh it out with full details, preserve any **Cleanup** sub-entry
   - If no: create new entry at the top of Session Log
   - Include: Working on, Did, State, Next
   - If things are broken/WIP, be detailed about what and why
   - Update Goals & Ideas section if user provided input

   **Ensure `.claude/worklog.md` is in `.gitignore`**

7. **Summarize**
   - What was committed
   - What was skipped
   - State we're leaving things in
   - What's queued for next time
