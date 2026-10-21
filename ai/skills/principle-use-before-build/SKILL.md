---
name: principle-use-before-build
description: "Apply when about to write a helper, wrapper, or custom implementation, and when a task names an SDK, module, or stack. Check the standard library, installed packages, and existing project APIs first."
---

# Use Before Build

Before writing new code, look for code that already solves the problem. The standard library, an installed dependency, and an existing project API are part of the system.

**Why:** Every custom implementation creates ownership, and a wrapper creates a second interface to keep aligned. An existing dependency already carries tested behavior, edge-case handling, documentation, and upgrade history.

**Pattern:**
- **State the stack before writing.** Name the existing capability the change will use: a standard library function, an installed package, or a project API. A stack the task names, or `Constraints` in the repo's `AGENTS.md` names, is binding. Use it and add no alternative.
- Search package manifests, lockfiles, imports, the standard library, and existing call sites before proposing a new dependency or implementation.
- Inspect the installed version's public API, types, documentation, and source when usage is unclear. Delegate the search when the dependency is large, and inspect the evidence directly.
- Follow the project's existing integration pattern, use the public API, and preserve the dependency's intended data flow.
- Write the smallest probe or test that proves the dependency handles the real case before building on it. An inline command counts as the probe.
- Add an adapter only at a real boundary, per **principle-minimize-reader-load**.
- When the installed version cannot support the requirement, record the missing capability and choose between an upgrade, a narrower integration, or a new implementation.
- Write a small, clear implementation when the alternative is a large dependency used for one trivial operation.

**Test:** The change uses the stated stack or an existing capability proven against the real case, or records why none fits. The manifest and lockfile diff is empty (a project with none passes this clause), or each added entry is justified in the plan or the final report.

Minimize the shape of the change per **principle-laziness-protocol**, and build a reusable tool when custom work is justified per **principle-build-the-lever**.
