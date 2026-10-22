---
name: principle-sequence-verifiable-units
description: "Apply when work spans many steps or commits that need checkable intermediate states. Split it into units that each end at a passing check, and order the delivery so the sequence replays."
---

# Sequence Verifiable Units

Order work as small units, each ending in a state that can be checked, and advance only when the current unit is green. The same discipline runs at two altitudes, execution and delivery.

**Why:** A break caught at the unit that caused it is cheap to localize. A break caught after a batch is buried under further work built on a broken base. Sequenced units a reviewer can replay turn "trust me" into "watch it go red, then green."

**Pattern:**
- **Pick the smallest unit that ends in a check,** such as an edit plus its test, or one independently revertable commit. When no check exists, unit 1 builds the smallest one and pins current behavior.
- **Verify each change before starting the next** in a sweep, migration, or run of similar edits. Each unit is a before/after bracket: known-good state, one change, run the check. Rebase onto clean trunk first so every check measures against the real baseline.
- **Stack commits and PRs in the order that proves the work.** The canonical shape is the failing test first, then the fix on top. The red-first commit counts as passing when its check is the failing run itself: the test fails for the stated reason, and the run is recorded in the commit message. Every other commit, and every phase boundary, is green. Other story orders are a subtraction before the reshape, a baseline capture before the treatment, and the scaffold before the feature. Each commit lands on its own.

**Test:** Every unit ends at a passing check (for a red-first commit, the recorded failing run) recorded before the next unit starts, every phase boundary is a green commit, and the final stack reads as the problem then the proof.

Complements **principle-prove-it-works**, which keeps each check real, and **principle-build-the-lever**, which makes the per-unit check cheap.
