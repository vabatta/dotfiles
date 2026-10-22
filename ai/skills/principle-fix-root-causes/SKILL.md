---
name: principle-fix-root-causes
description: "Apply when choosing the fix for a failure whose cause is known or suspected, with a guard or workaround on the table. Fix at the root cause and sweep the same pattern everywhere. Not for locating an unknown cause."
---

# Fix Root Causes

Trace every problem to its root cause and fix it there.

**Why:** Symptom fixes accumulate. Each workaround makes the system harder to reason about while the real bug remains. Root-cause fixes are slower upfront and reduce total debugging time.

**Pattern:**
- Reproduce first, since a fix that cannot be reproduced cannot be verified.
- Ask why until the root cause is reached. A nil-check guard that silences a crash is a symptom fix.
- Fix the code when a workaround needs a paragraph-long comment to justify it.
- Grep the repo's source and tests for the failing call or expression and fix every instance.
- Instrument when stuck: add logging and read the actual error.
- For failures after restart, suspect stale persistent state first (config files, caches, lock files, serialized state), since code does not change between runs. If clearing a state file restores behavior, fix the state validation.

**Test:** The reproduction passes, the pattern grep finds no unfixed instance, and the diff adds no guard whose only job is to silence the symptom.

For the end-to-end loop, use **diagnosing-bugs**.
