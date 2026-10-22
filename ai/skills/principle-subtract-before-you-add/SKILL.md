---
name: principle-subtract-before-you-add
description: "Apply when about to make a large addition or refactor. Delete dead code, redundant validators, and stubs first, then build on the smaller base."
---

# Subtract Before You Add

Remove complexity first, then build.

**Why:** Adding to a complex system compounds complexity. Removing first cuts the surface area, reveals the essential structure, and usually makes the next design obvious.

**Pattern:**
- Sequence removal before construction, and leave the design slightly simpler behind the same or a smaller surface. Remove legacy duplicates and one-caller wrappers along with dead code.
- Reach the minimum before investing in polish.
- Build for observed usage, with validators, parsers, and guards only as far as the spec demands. Out-of-spec features such as persistence, retry-on-startup, and schema migration each drag guards behind them.
- Remove redundant instructions and excessive templates from prompts.
- Delete a reference with no novel content instead of leaving a stub.

**Test:** The first unit (commit, or step within one commit) only deletes or simplifies, and the additions come in a later unit. Net added lines for the whole change are at or below the lines removed. A pure addition names the dead code, wrapper, or stub the first unit removed, or states that none exists.
