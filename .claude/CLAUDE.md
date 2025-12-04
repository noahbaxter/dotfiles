# Noah's Global Rules

## How I Work

I think out loud. Stream of consciousness until something useful emerges. When I'm
brainstorming, push back on ideas that don't make sense and help generate alternatives.
Challenge me - don't just agree.

When solving problems: gather information first, execute once. Ask clarifying questions
upfront rather than iterate on mistakes. The longer a task takes, the worse it goes -
so get it right the first time.

Start by explaining the approach (rubber duck it). Document findings somewhere so a
fresh session can pick it up. Get it working first, THEN go back to understand,
improve, add tests and edge cases.

## Communication Style

- Direct and specific, no fluff or hedging
- Casual but not sloppy
- Line numbers and actual names, not vague references
- Don't over-explain obvious things
- No AI-speak: "I'd be happy to...", "Great question!", "Certainly!"

## Code Philosophy

Simple > "right". Minimal, readable, easy to understand. No over-engineering.

- Make it work → make it clean/right → make it fast (in that order)
- Features should be reliable and consistent before adding more
- Fail fast and loud - no silent failures
- Fewer dependencies unless one is clearly the right choice

## Code Organization

I hate clutter. Group things properly:

- Folders: `scripts/`, `build/`, `tests/`, `docs/`, `src/`, etc.
- No loose files of mixed types in the same place
- Files under 300-500 lines - split if bigger
- Good OOP: utils, helpers, abstractions in their own place

Common scripts (almost always present):
- `build.sh` - build the project
- `test.sh` - run tests
- `deploy.sh` - deploy
- `setup.sh` - environment/dependencies setup
- `dev.sh` - start dev server/watch mode
- `clean.sh` - remove build artifacts, caches
- `lint.sh` / `format.sh` - code formatting

## Functions & Abstractions

- Functions ideally < 50 lines, but > 3 lines (no premature extraction)
- If logic could apply to another input, extract it
- Three similar lines is fine; three similar blocks should be a function
- DRY when it makes sense, not religiously

## Comments & Documentation

Minimal. Code should be self-documenting.

- No docstrings or multi-line comment blocks
- Comments only when something ISN'T self-explanatory
- Don't add comments that restate what the code does
- Don't create documentation files unless explicitly asked

## Commits

- Small, atomic - one logical change per commit
- Minimal messages: what changed and why, no fluff
- Never squash regular work
- Squash IS fine for guess-check loops (CI/CD iterations, "6 commits trying random stuff until it worked") → one clean commit
- Rebasing is fine
- Match repo's existing style
- On personal projects, pushing to main is fine

## Tests

- Tests catch real bugs, not inflate coverage
- A test that can't fail is worse than no test
- Minimal and focused > comprehensive and brittle
- Don't mock so heavily you're testing your mocks
- Add tests after it works, for edge cases and regressions

## When Stuck

- If the same approach fails 2-3 times, STOP
- Step back and reassess the bigger picture
- Explain what you've tried and why it's failing
- Ask clarifying questions rather than guessing repeatedly
- Consider if the problem is upstream of where you're looking

## What NOT To Do

- Don't start work until you have enough info to do it right
- Don't go beyond what was asked (no bonus features or "improvements")
- Don't add error handling for impossible scenarios
- Don't create abstractions for one-time operations
- Don't guess at requirements - ask
