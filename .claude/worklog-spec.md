# Worklog Specification

This defines how the `.claude/worklog.md` file should be structured, maintained, and used. All session commands (`/recap`, `/polish`, `/tidy`) follow this spec.

## Command Flow

The intended workflow:

```
/recap (START)
    ↓
  work
    ↓
/polish (MIDDLE - optional, repeatable)
    ↓
/tidy (END)
```

### /recap - Session Start
- **Can create worklog**: Yes - this is the ONLY command that bootstraps
- **Reads**: worklog, git history, uncommitted changes
- **Writes**: Creates worklog if missing, backfills from commits, syncs state
- **Purpose**: Get context, know where you left off

### /polish - Mid-Session Cleanup
- **Requires worklog**: Yes - bail if missing, tell user to run `/recap` first
- **Reads**: worklog, all changed files
- **Writes**: Adds cleanup sub-entry if changes were made
- **Purpose**: Review code quality before committing

### /tidy - Session End
- **Requires worklog**: Yes - bail if missing, tell user to run `/recap` first
- **Reads**: worklog, git status, changed files
- **Writes**: Creates/updates full session entry, commits code
- **Purpose**: Commit work, document what happened, note next steps

### Session Entry Handling

If multiple commands touch the same day:
- `/recap` may create a minimal entry or update existing
- `/polish` adds a **Cleanup** sub-entry to today's entry (creates minimal entry if none exists)
- `/tidy` fleshes out today's entry with full details (merges with existing if present)

The entry grows throughout the day as commands run.

## File Structure

```markdown
# Worklog

## Goals & Ideas
[Long-term goals, ideas, things to eventually do - not tied to specific sessions]

---

## Session Log
[Reverse chronological - newest at top, oldest at bottom]
```

## Goals & Ideas Section

This lives at the TOP of the worklog, before the session log. It tracks:

- **Overarching goals**: What you're ultimately trying to achieve
- **Ideas**: Things you want to try but haven't prioritized yet
- **Eventually**: Features, refactors, or experiments for "someday"
- **Open questions**: Things you're unsure about

Format is flexible - bullets, sub-sections, whatever works. This section gets *updated* not *appended to* - it's a living document, not a log.

Example:
```markdown
## Goals & Ideas

**Main goal**: Get the app production-ready

Ideas:
- Try using SQLite instead of JSON files
- Add dark mode support
- Maybe extract the CLI into its own package?

Open questions:
- Should auth be session-based or token-based?
- Is it worth adding tests before the refactor?
```

## Session Log Section

Reverse chronological order - newest entries at the TOP of this section.

### Entry Format

```markdown
### YYYY-MM-DD

**Working on**: [current focus]

**Did**:
- [what was accomplished]
- [can include commits, but also attempts, research, debugging]

**Tried/Blocked** (optional):
- [things that didn't work and why]
- [blockers or open issues]

**State**: [clean | WIP | broken] - how are we leaving things?

**Next**: [immediate next steps for next session]
```

### Entry Types

**Full session entry** (most common):
- Use when ending a session via `/tidy`
- Include all fields that are relevant

**Quick checkpoint**:
- Use when `/recap` auto-updates from commits
- Can be minimal: just date + Did

**WIP/Broken state**:
- When leaving things mid-task or broken, be explicit
- Note what's broken, what you were trying, how to resume
- This is the most valuable context for future you

## Style Guide

- **Terse**: Breadcrumbs, not documentation
- **Casual**: "Fixed the auth bug" not "Resolved authentication issue"
- **Honest**: Note what's broken, what you tried that failed
- **Context-rich**: Include the *why* when it's not obvious
- **No fluff**: Skip entries that say nothing useful

## Interpolating "What's Next"

When determining what to work on next, check in order:

1. **State = broken/WIP**: Fix or continue what's in progress
2. **Explicit "Next" items**: From the most recent session entry
3. **Goals & Ideas**: Reference the top section for direction
4. **Recent momentum**: What theme have recent sessions followed?

## Maintenance Rules

1. **Gitignore**: `.claude/worklog.md` must be in `.gitignore` - never commit it
2. **One worklog per repo**: Keep it in `.claude/worklog.md`
3. **Don't over-document**: If nothing meaningful happened, skip the entry
4. **Update Goals section**: When priorities shift, update it - don't let it go stale
5. **Prune old entries**: After ~20-30 entries, consider archiving old ones (or don't, up to you)

## Related Specs

- `files-spec.md` - Which files to review, skip, or commit
- `tone-spec.md` - Writing style and communication guidelines
