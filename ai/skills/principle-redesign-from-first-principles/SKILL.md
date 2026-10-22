---
name: principle-redesign-from-first-principles
description: "Apply when adding a requirement to an existing design. Reshape it as if the requirement were foundational, instead of bolting it on."
---

# Redesign From First Principles

Integrate a change by redesigning as if the requirement had been there from the start.

**Why:** Bolting on preserves the old shape and leaves the new requirement as an exception. Redesigning keeps option value and removes the seams a bolt-on would hide.

**Pattern:**
- Read all affected files and understand the current design holistically.
- Ask what would be built from scratch with this requirement, and build that.
- Propagate the change through every reference: types, docs, examples, rationale sections. Grep for the old term and the old rule's wording, and note any behavior change the redesign introduces.
- Land a redesign that touches more than one module as units that each pass a check, per **principle-sequence-verifiable-units**. It may exceed the smallest diff, so state why against the budget.

**Test:** No new branch, fork, or "handled separately" comment exists solely for the new requirement, and grep finds no doc still describing the old rule. The result then reads as if the requirement was always present.
