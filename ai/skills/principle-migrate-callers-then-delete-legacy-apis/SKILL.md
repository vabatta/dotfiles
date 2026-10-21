---
name: principle-migrate-callers-then-delete-legacy-apis
description: "Apply when replacing an existing internal API that still has callers. Migrate every caller and delete the old API in the same change."
---

# Migrate Callers Then Delete Legacy APIs

Once a new API is the right design, migrate its callers and remove the old API in the same change.

**Why:** Keeping both APIs creates dual-path complexity and makes the codebase append-only. Compatibility layers meant to be temporary become permanent architecture.

**Pattern:**
- Apply when no external users depend on backward compatibility and the project can absorb coordinated breaking changes.
- Inventory the callers, migrate them, and delete the old API immediately.
- Keep a temporary adapter only as an exception, time-boxed and named for removal.
- Update tests to assert the new contract, and delete tests that only protect pre-refactor implementation details.

**Test:** `git grep` for the old symbol and its string name across code, tests, docs, and config in the working tree finds zero references, and the old symbol no longer exists. A surviving adapter or deprecated shim means the change is incomplete.
