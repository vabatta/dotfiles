---
name: principle-foundational-thinking
description: "Apply when choosing the core data structures of a new module. Get the data shape right first so downstream code becomes obvious."
---

# Foundational Thinking

Get the core data structures right before writing logic.

**Why:** A structural decision protects option value and a code-level decision protects simplicity. A data-structure change late is a rewrite, and early it is often a one-line diff.

**Pattern:**
- Define the core types first.
- Trace every access pattern through them and list each as one line (path to type and field) in the commit message or PR.
- Choose structures that match the dominant paths, meaning the ones the feature runs most often.
- **Scaffold first.** Land what every later phase benefits from before features: CI, linting, test infrastructure, and shared types. Scaffold only what the next feature needs checked, and one runnable check is enough.
- **DRY the structure, not every line.** Types and data models should converge, and three similar statements beat a premature abstraction.

**Test:** The core types and scaffold exist and pass a check before any feature code, the access-path list is in the commit message or PR, and the feature commit changes no lines of the type definitions.

For choosing a structure that encodes domain rules, see **principle-model-the-domain**. For a module interface, use **architect**.
