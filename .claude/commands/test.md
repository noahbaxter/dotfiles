---
description: Create, review, and maintain tests
---

# Test

Help with tests - creating new ones, reviewing existing ones, or maintaining test artifacts.

## Modes

This command handles three things. Detect from context or ask:

1. **Create** - "make a test for X"
2. **Review** - "audit my tests"
3. **Maintain** - "update test references" or "regenerate fixtures"

---

## Mode 1: Create Tests

When asked to create tests for something specific.

### Steps

1. **Understand what to test**
   - Read the code being tested
   - Identify the key behaviors (not implementation details)
   - Note edge cases, error conditions, boundary values

2. **Find the testing setup**
   - What framework? (Jest, Vitest, pytest, Go testing, etc.)
   - Where do tests live? (`__tests__/`, `tests/`, `*_test.go`, etc.)
   - Any existing test utilities or helpers?

3. **Write focused tests**

   Principles:
   - Test BEHAVIOR, not implementation
   - One logical assertion per test (multiple `expect` calls are fine if they test one thing)
   - Tests should FAIL when the code is broken
   - Minimal setup - only what's needed for this test
   - No over-mocking - if you're mocking everything, you're testing nothing

4. **Show the tests, get approval**
   - Present the tests before writing
   - Explain what each test verifies
   - Ask if edge cases are missing

---

## Mode 2: Review Tests

Audit existing tests with a critical eye.

### What You're Looking For

**Useless tests** (delete or rewrite):
- Assertions that can never fail (`expect(true).toBe(true)`)
- Only checking `.toBeDefined()` or `.toBeTruthy()` on things that are always defined/truthy
- Mocking so much that you're testing your mocks
- Tests with no assertions at all
- Snapshot tests of things that change constantly

**Weak tests** (need strengthening):
- Only testing happy path, no error cases
- Overly broad assertions that pass even when code is wrong
- Missing `await` on async operations (test passes before work finishes)
- Try/catch that swallows errors and passes anyway

**Missing coverage** (gaps in testing):
- Complex logic with no tests
- Error handling paths untested
- Edge cases (null, empty, boundary values) not covered
- Critical paths (auth, payments, data integrity) undertested

**Flaky tests** (fix or delete):
- Timing-dependent tests that fail randomly
- Tests that break on unrelated refactors
- Tests that pass locally but fail in CI

### Steps

1. **Find tests**
   - Look for test directories and files
   - Check test runner config

2. **Review systematically**
   - Start with critical code paths
   - Note patterns - if one test is bad, similar ones probably are too

3. **Present findings with continuous numbering**

   ```
   ### Useless (delete or rewrite)
   1. **auth.test.ts:45** - Mocks return exactly what's expected, proves nothing
   2. **utils.test.ts:12-30** - All assertions are .toBeDefined()

   ### Weak (strengthen)
   3. **api.test.ts:67** - Only happy path, no error cases
   4. **validation.test.ts:23** - Catches error but doesn't check message

   ### Missing (add tests)
   5. **payment.ts:89-120** - Retry logic untested, will break silently
   6. **auth.ts:45-80** - Token refresh has no coverage

   ### Flaky (fix or delete)
   7. **integration.test.ts** - setTimeout-dependent, fails randomly
   ```

4. **Get direction and execute**
   - User picks what to address
   - Delete useless tests, strengthen weak ones, add missing ones

---

## Mode 3: Maintain Test Artifacts

Handle test fixtures, reference files, snapshots, and other test artifacts.

### Common Scenarios

**Reference files that validate output** (audio, images, data):
- These are "source of truth until intentionally changed"
- DON'T regenerate automatically when tests fail
- DO regenerate when explicitly asked after intentional changes

**Snapshots**:
- Update when intentional changes cause failures
- Investigate when unexpected failures occur

**Fixtures/mock data**:
- Update when data schema changes
- Keep minimal - only what tests need

### Steps

1. **Understand the artifact type**
   - What does this test artifact validate?
   - When should it change vs stay constant?

2. **Ask before regenerating**

   Critical question: "Did the code change intentionally or is this a regression?"

   - **Intentional change**: Regenerate references, update snapshots
   - **Regression**: Don't regenerate - the test caught a bug, fix the code

3. **Document the regeneration**
   - Note what was regenerated and why
   - Make it clear this was intentional, not papering over bugs

### Example: Audio DSP Reference Files

For audio processing tests with reference output files:

```
Test: process_audio_test.py
Reference: tests/refs/expected_output.wav

When DSP changes INTENTIONALLY:
1. Verify the new output sounds correct (manual check)
2. Run: python scripts/regenerate_audio_refs.py
3. Commit refs with message: "update audio refs for [what changed]"

When test fails UNEXPECTEDLY:
1. DON'T regenerate
2. Investigate what changed
3. Fix the regression
```

---

## Test Philosophy (from ~/.claude/CLAUDE.md)

- Tests catch real bugs, not inflate coverage numbers
- A test that can't fail is worse than no test
- Minimal and focused > comprehensive and brittle
- Don't mock so heavily you're testing your mocks
- Add tests after it works, for edge cases and regressions
