---
name: principle-minimize-reader-load
description: "Apply when shaping or reviewing code with many indirections or hidden state, or when a task bans indirection or wrapping code. Collapse one-caller wrappers and shrink mutable scope."
---

# Minimize Reader Load

Minimize the work a reader must do to understand code, along two independent axes: layers to trace between a question and its answer, and hidden or mutable state to hold in mind.

**Why:** Code is read far more than it is written. LOC and cyclomatic complexity are proxies, and reader load is the thing that matters. A flat file with 50 globals can be as hard to reason about as a 6-layer adapter stack. This is the human analog of **principle-guard-agent-context**.

**Pattern:**
- **Collapse layers** that do not earn their keep, such as wrappers with one caller, adapters with no second implementation, and indirection for a future that never came. Inline them in code the change already touches, and name the rest in the final report. A wrapper is a function, class, or module whose body only forwards its arguments to one call.
- **Make adjacent layers change the abstraction.** Collapse a layer that repeats the same methods and arguments.
- **Compress interfaces.** Prefer boundaries that hide meaningful decisions over a broad interface that hides little.
- **Shrink state scope:** pure functions over mutations, locals over fields, fields over module state, module state over globals. Derive instead of sync.
- **Name the invariant at the boundary** so the reader learns it once.
- Before adding a layer or a piece of state, confirm it reduces reader load elsewhere by at least as much.

## Shape limits

A shape limit from the task, such as no indirection or no wrapping code, or from `Constraints` in the repo's `AGENTS.md`, is binding. Hold the change to it and report a breach, do not reword the limit.

**Test:** Count the callers of every new function, class, and module with grep. Each has two or more callers or sits at a named boundary (I/O, an external API, or a seam that needs translation, ownership, or policy). A new symbol with one caller and no boundary is inlined. Then grep for the definition and every assignment of each touched piece of state, and expect at most 3 hops from question to answer.
