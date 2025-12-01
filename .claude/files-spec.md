# Files Specification

Shared rules for how `/recap`, `/polish`, and `/tidy` handle files. All commands reference this spec.

## Categories

### Working Cruft (never commit, usually skip reviewing)

Files that exist to help during development but don't belong in the repo:

- `.env` files, local config, secrets
- Scratch files, temp files, personal notes
- Reference code pulled in just to look at (usually obvious from name/location)
- Build artifacts, compiled output, cache directories
- Lockfiles (review if intentionally updated, otherwise skip)

### Binary/Non-Code Files

- Images, fonts, PDFs, videos - don't try to read these
- Note if they seem orphaned or unnecessary based on how they're referenced elsewhere
- If an image isn't imported/used anywhere, flag it

### Long-Untracked Files

- Use `ls -la` to check modified times
- If a file has been sitting untracked for several days without being staged, it's probably not meant to be committed
- Either flag for deletion or ask user about intent

### Markdown Files (Special Handling)

Claude tends to generate .md files during debugging/development that pile up and become useless.

**Review and possibly commit:**
- README files that were intentionally edited
- Documentation that's part of the actual project
- Changelogs, contributing guides, etc.

**Flag for deletion/consolidation:**
- Debug notes, working docs, "how this works" files created during a task
- Files like `notes.md`, `debug.md`, `plan.md`, `TODO.md`
- If it was only useful during implementation, it's probably cruft now

**When in doubt:** Ask the user. "Is `implementation-notes.md` meant to be kept or was it just working notes?"

## By Command

### /recap
- Reads files to understand context
- Doesn't skip anything when gathering info - reads whatever helps

### /polish
- **Analyze**: All modified + new files (staged and unstaged)
- **Skip**: Working cruft, binaries, long-untracked files
- **Flag**: Generated .md files for potential deletion
- **Report**: Tell user what was skipped and why

### /tidy
- **Commit**: Code changes, intentional config changes, real documentation
- **Skip**: Working cruft, scratch files, generated debug docs
- **Report**: List what's being skipped and why
- **Ask**: When in doubt about a file, ask before skipping
