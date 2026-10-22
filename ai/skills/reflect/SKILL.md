---
name: reflect
description: "Examines a completed session through independent lenses and routes the learnings into skills, checks, or structure. Use after a session ends, on retro, what did we learn, or improve the setup. Not for starting a skill from scratch."
---

# Reflect

Use after a non-trivial task, a user correction, or a reusable workflow has
emerged. Skip one-off work that is already covered: grep the skills for the rule
first, and when it exists the finding is a compliance gap, not a new rule.

1. Capture the current conversation or use the host-provided transcript. With
   neither, reconstruct the session from the diff, history, and user's account,
   label the source, and name what is missing. Done when the evidence is in hand.
2. Review it through three lenses, each returning findings with evidence,
   fanned out via **delegate**:
   - **Judgment** asks where the agent decided wrongly or the human corrected it.
   - **Tooling** asks where a missing, slow, or unwired tool or check cost time.
   - **Divergent** asks what a differently minded agent would have done instead.
3. Synthesize Accepted, Rejected, and Backlog findings. Accepted is the approval:
   no further human sign-off is needed, and an absent human changes nothing.
   Done when every finding sits in one bucket.
4. Build each Accepted mechanical check now per
   **principle-encode-lessons-in-structure**, wire it into the repo's check
   command, and run it red on the failing case, then green on the fix. Write
   what exceeds the budget to `.agent/handoffs/reflect-backlog.md`. Done when
   every check has a red and a green run or a backlog entry.
5. Apply the Accepted skill edits, routing them through **skill-creator** for
   structure and evals and **writing-for-agents** for wording. Done when every
   resulting artifact is inspected and verified.

The reviewers' findings are evidence, not authority.

## What to look for

Examine the session through these categories, each with its trigger:

- **Navigation**: information took long to find. Add a navigation pointer.
- **Automated checks**: a mistake was catchable, or the repo has no guardrail. Read the repo's own check command first, and treat an existing but unwired check as the finding.
- **Coding standards**: the review missed something. Classify it mechanical or a judgement call, and for mechanical fixes default to building the check over writing the rule.
- **Global AGENTS.md**: steering that belongs in a skill or a check.
- **Tool economy**: expensive or token-inefficient calls.
- **No-ops**: instructions that do not change behaviour.
- **Information access**: logs or read-only third-party access that was missing.

Order the candidates by severity. The implementation agent carries the most context pressure, so prefer a check over a rule it must read.

Reflect owns the end-of-session routing: each learning lands as a skill edit, a check, or a structural change.
