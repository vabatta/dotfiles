---
name: principle-outcome-oriented-execution
description: "Apply when executing a planned rewrite or restructure with phase boundaries. Converge on the verified target architecture and accept planned, reversible breakage inside a phase."
---

# Outcome-Oriented Execution

Optimize for the intended, verifiable end state over smooth intermediate states.

**Why:** Keeping every intermediate step fully stable creates temporary compatibility code that becomes long-lived debt.

**Pattern:**
- Prioritize end-state integrity over transitional stability.
- Declare where breakage is acceptable. A phase is a run of commits that opens its breakage at the first and closes it at the last, planned, scoped, and reversible. Every phase boundary is a green commit per **principle-sequence-verifiable-units**.
- Require the plan to list one smoke command per phase. If it lists none, add them before phase 1 starts.
- Keep high-signal checks on actively touched areas while migrating.
- Verify the target architecture at plan completion per **principle-prove-it-works**.
- Delete the old paths in the phase that replaces them, per **principle-migrate-callers-then-delete-legacy-apis**.

**Test:** Every phase's smoke command exited 0 at its boundary commit, the final verification ran against the target architecture, and no intermediate shim shipped as permanent.
