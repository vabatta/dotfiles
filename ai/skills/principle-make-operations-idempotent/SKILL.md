---
name: principle-make-operations-idempotent
description: "Apply when designing commands, lifecycle steps, or processing loops that run amid crashes, restarts, and retries. Converge to the same end state regardless of partial prior runs."
---

# Make Operations Idempotent

Design every state-mutating operation to converge to the correct state however many times it runs and wherever it starts.

**Why:** Commands, lifecycle operations, and processing loops run where crashes, restarts, and retries are normal. If partial state changes the next run's outcome, every restart becomes a debugging session.

**Pattern:**
- Start convergently: scan for existing state, clean stale artifacts, and resume live work.
- Clean up by content equivalence, not creation order.
- Where the operation uses locks, detect stale ones by checking whether the owner is still alive. Add no lock where atomic writes suffice.
- Where it spawns workers, respawn failed work cleanly and regenerate fresh input after each cycle.

**Test:** Run the operation twice in a row. Then crash it after each durable write or external effect (raise at the Nth write for each N) and rerun. Each run converges to the same end state. Any dependence on leftover state needs a reconciliation step at the start of the operation.

For human-run steps that must be rerunnable, use **wizard**.
