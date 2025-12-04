---
description: Pre-commit review - is this code ready to commit?
---

# Review

Code works but isn't ready to commit. Review and clean up before committing.

## What You're Checking

### 1. Code Reduction
- Can large blocks be reduced in scope or line count?
- Is there duplication with existing code elsewhere in the codebase?
- Are there unnecessarily verbose patterns that could be simplified?
- Dead code, unused imports, console.logs, debug artifacts?

### 2. Architecture
- Are files getting too large (300-500+ lines)? Should they be split?
- Does the structure make sense, or should things be reorganized?
- Should this become its own module/folder?
- Are utils/helpers properly extracted?

### 3. Test Coverage
- Did we add tests for the changes?
- Should we? Is this complex enough to warrant tests?
- Is it even possible to test this properly?
- Flag if tests are missing for non-trivial logic

### 4. Captured Tasks
- Did we discover future work while implementing?
- Are there TODOs that should go in the backlog instead of code comments?
- Ideas that came up worth capturing?

### 5. Code Quality
- Messy logic that needs rewriting?
- Non-deterministic code that should be rethought?
- Unclear variable names, magic numbers?
- Overly clever code that's hard to follow?

## Steps

1. **Gather the changes**
   - `git status` to see modified/staged/untracked
   - `git diff` and `git diff --cached` to see what changed
   - Note files being skipped: .env, lockfiles, build artifacts, etc.

2. **Read and analyze each changed file**
   - Read the FULL file, not just the diff (need context)
   - For new files, review the whole thing
   - Note specific issues with line numbers

3. **Present findings by category**

   Use continuous numbering across all categories.

   ### Reduce (line count, duplication, simplification)
   ```
   1. **api.ts:45-90** - This validation block duplicates what's in utils/validate.ts
   2. **handler.ts:120-150** - Verbose error handling, could be 10 lines not 30
   ```

   ### Restructure (architecture, file organization)
   ```
   3. **services.ts** - 600 lines, split into: auth.ts (50-200), api.ts (210-400), helpers.ts (410-600)
   4. **components/** - These 5 components share logic, extract to hooks/useForm.ts
   ```

   ### Tests (coverage gaps)
   ```
   5. **payment.ts:89-120** - Payment retry logic has no tests, should have them
   6. **auth.ts** - Token refresh is complex, needs test coverage
   ```

   ### Capture (tasks/ideas to track)
   ```
   7. **TODO on line 45** - "handle edge case" - add to backlog or fix now?
   8. Noticed during review: error messages aren't consistent, future cleanup task?
   ```

   ### Quality (needs rewriting or rethinking)
   ```
   9. **utils.ts:30-50** - This caching logic has race conditions
   10. **parser.ts:80** - Non-deterministic based on object key order
   ```

   **Summary:** X reduce, Y restructure, Z tests, W capture, V quality issues

4. **Get direction**
   - User picks what to address: "fix 1 3 5" or "all" or "skip"
   - For restructuring, confirm before major changes

5. **Execute approved changes**
   - Work through in order
   - Show changes as you make them

6. **Update worklog if tasks were captured**
   - Add discovered tasks to Backlog section
   - Add ideas to Ideas section
