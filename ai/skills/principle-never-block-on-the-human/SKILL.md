---
name: principle-never-block-on-the-human
description: "Apply when tempted to ask whether to do something on reversible execution work. Proceed, present the result, and let the human course-correct after the fact. Reserve questions for one-way doors, product direction, and decisions that shape the work."
---

# Never Block on the Human

The human supervises asynchronously. Make reasonable decisions, proceed, and let the human course-correct after the fact.

**Why:** Every permission pause stalls the pipeline and makes the human the bottleneck. Code changes are reversible and reviewable, so a wrong decision usually costs less than blocking.

**Pattern:**
- **Proceed, then present.** Do the work, show the result, and explain why instead of asking whether to.
- **Ask only at one-way doors.** Irreversible actions (force-push, delete production data, send external messages) need confirmation first.
- **Leave direction to the human.** Product direction and decisions that shape the work are the human's. Settle them with **grill**, then proceed unblocked on the execution.
- **Ask when intent cannot be inferred.** Genuine ambiguity that context cannot resolve is a question that shapes the work.
- **No human present.** When no one can answer, write your recommended answer down as an assumption, continue, and list the assumptions in the result. At a one-way door, stop and report instead.
- **Rule of thumb.** A door is one-way when undoing it needs more than a revert or a rerun.

**Test:** No reversible action waited on a human answer, and every question asked was at a one-way door or a decision that shapes the work.
