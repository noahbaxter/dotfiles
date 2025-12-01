---
description: Review changes for cleanup opportunities before committing
---

# Polish

You've done the work, it functions, now make sure it's not embarrassing before your team sees it. This is the cleanup pass.

**This is the mid-session command.** Sits between `/recap` (start) and `/tidy` (end). The goal: catch the stuff that makes AI-generated code look like unmaintainable slop.

## Prerequisites

**Check for worklog first.** If `.claude/worklog.md` doesn't exist, STOP and tell the user to run `/recap` first. Don't proceed without a worklog.

## Specs to Follow

- `.claude/files-spec.md` - Which files to analyze, skip, or flag (READ THIS for file handling rules)
- `.claude/worklog-spec.md` - Worklog format and command flow
- `.claude/tone-spec.md` - Writing style (casual, direct, no fluff)

## What You're Looking For

**Cruft to remove:**
- TODO/FIXME comments that are done or no longer relevant
- Commented-out code (delete it, git remembers)
- console.log, print statements, debug output
- Test scaffolding, mock data, dev-only helpers that don't belong in prod

**Duplication to consolidate:**
- Same logic appearing multiple places → extract to a util function in the SAME FILE unless it's truly reusable elsewhere
- Do NOT create new files or classes unless the file is 500+ lines and genuinely needs to be split
- If a file is massive and unwieldy, propose specific chunks to extract (e.g., "lines 200-350 are all validation logic, could be `validation.ts`") - but this is reorganization, NOT architectural redesign

**Readability issues:**
- Vague variable names (`d`, `x`, `temp`, `data2`)
- Functions doing 5 different things
- Convoluted conditionals that could be simplified
- Magic numbers/strings that should be named constants
- Useless comments that just restate the code (e.g., `// increment counter` above `counter++`)

**Obvious inefficiencies:**
- Doing the same work twice in a loop
- N+1 patterns (fetching in a loop when you could batch)
- Not micro-optimization - just "wait, why are we computing this 3 times?"

**NOT looking for:**
- Architectural rewrites or redesigns
- New features or capabilities
- Changes that alter behavior
- Comprehensive refactoring of code you didn't touch

## Steps

1. **Check prerequisites**
   - Read `.claude/worklog.md` - if it doesn't exist, bail with "Run /recap first"
   - Read all specs listed above

2. **Gather the changes**
   - `git status` to see modified/staged/untracked files
   - `git diff` and `git diff --cached` to see what changed
   - Apply file handling rules from `files-spec.md`
   - Tell the user what you're skipping and why: "Skipping: .env (local config), package-lock.json (lockfile), debug-notes.md (looks like working notes)"

3. **Read and analyze each file**
   - Read the FULL file, not just the diff
   - Focus only on sections that were changed (for new files, review the whole thing)
   - Note specific issues with exact line numbers

4. **Present suggestions by priority**

   Group into three tiers. **Numbering is continuous across all tiers** so user can say "do 1 4 6" without ambiguity.

   ### Small (< 1 min each)
   Quick deletions, renames, one-line fixes
   ```
   1. **file.ts:23** - Remove console.log
   2. **file.ts:67** - Rename `d` to `createdDate`
   3. **utils.ts:12** - Delete commented-out code block
   ```

   ### Medium (1-5 min each)
   Extract a function, simplify a conditional, add a constant
   ```
   4. **file.ts:45-52** - Extract duplicate validation to `validateEmail()` (same pattern at line 89)
   5. **api.ts:30-45** - Simplify nested if/else into early returns
   ```

   ### Large (5+ min, needs thought)
   Split a massive file, restructure a function, fix an inefficiency
   ```
   6. **handlers.ts** - 600 lines, consider splitting: auth logic (50-180), validation (200-350), response formatting (400-550)
   ```

   **Summary:**
   - X small, Y medium, Z large
   - If nothing found: "Looks clean, nothing to flag"

5. **Get approval**
   - Wait for user to respond with numbers: "do 1 2 5 6" or "all" or "skip"
   - If user skips something you think is critical (actual bug, will break prod, security issue), mention it once. If they still skip, drop it.

6. **Execute approved changes**
   - Work through the list in order
   - Show each change as you make it (brief diff or description)
   - Don't touch anything not approved

7. **Update the worklog**

   **Skip worklog update if:**
   - No issues were found, OR
   - User approved nothing (said "skip" or rejected all suggestions)

   **If changes were actually made:**
   - Check if there's a session entry for today
   - If no today entry: create a minimal one (just date + Working on: "cleanup pass")
   - Check if there's already a cleanup entry from a recent `/polish` run (same day)
   - If yes: append to existing cleanup entry
   - If no: add new cleanup sub-entry

   Format:
   ```markdown
   **Cleanup**:
   - [brief list of what was cleaned]
   - e.g., "removed 4 console.logs, extracted `validateEmail()`, renamed unclear vars in handlers.ts"
   ```

   Note: `/tidy` will flesh out today's session entry later, so keep the cleanup entry minimal.

## Tone

See `.claude/tone-spec.md` for full guidelines. Key points:
- Direct and specific (line numbers, actual names)
- No fluff, no praise, no hedging
- Casual but not sloppy
