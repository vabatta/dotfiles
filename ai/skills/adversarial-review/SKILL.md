---
name: adversarial-review
description: "Runs independent reviewers against a design or change and classifies findings as act, consider, noted, or dismissed. Use when a change is contested, cross-cutting, or easy to get subtly wrong, and adversarial critique is wanted. It returns classified findings, never a merge verdict. Trigger on adversarial review, red team, poke holes, or find the flaws."
---

# Adversarial review

Use independent reviewers when the change is contested, cross-cutting, or easy
to get subtly wrong.

1. State the goal, constraints, and review rubric. Done when each is one line.
2. Fan the reviewers out per **delegate**, one read-only reviewer per rubric axis, three at most. Done when each axis has a report.
3. Read every finding and verify it per **principle-prove-it-works**. For a design with nothing to run, a finding needs a quoted line or reproduced output, else class it Consider.
4. Classify each finding.
   - Act on: evidenced and affects the stated goal.
   - Consider: plausible, evidence incomplete.
   - Noted: true but outside the goal.
   - Dismissed: disproved by a run or a quoted line.
5. Present the classified list. Fix Act on items only in your own change. For a plan, amend the plan. Done when every finding carries a class and the list is presented.

For the interview that settles open decisions before a change exists, use **grill**.
