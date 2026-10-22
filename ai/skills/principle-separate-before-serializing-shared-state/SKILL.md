---
name: principle-separate-before-serializing-shared-state
description: "Apply when concurrent actors might write to the same file, branch, key, or state object. Eliminate the sharing first, and serialize structurally only when one shared writer is a real invariant."
---

# Separate Before Serializing Shared State

Eliminate shared mutable state between concurrent actors first, and serialize structurally only when sharing is real.

**Why:** Concurrent writes to shared state create race conditions that are intermittent, hard to reproduce, and expensive to debug. Instructions and conventions to "take turns" are not concurrency control.

**Pattern:**
1. Identify shared mutable state: files both read and write, branches both push to, APIs both define and consume.
2. Eliminate the shared write target by default. Give each actor its own owned file, key, branch, or state directory, and merge only at the read or reporting boundary. Two workers writing their own `lastX` field into one `state.json` is still shared mutation, while `indexer-state.json` plus `metrics-state.json` is not.
3. When one shared write target is a real invariant, serialize access structurally with lockfiles, sequential phases, a single-writer actor, or atomic compare-and-swap. Treat "we need a lock" as a design smell to check first.

**Test:** List every writer's write targets (path, key, or branch). No target appears under two writers, or the shared one is serialized by a named structure. Run two writers concurrently and their outputs merge at the read boundary without coordination.
