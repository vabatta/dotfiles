---
name: accept-change
description: "Gives a merge verdict on a diff, PR, or change by running adversarial review, breakage analysis, and comment cleanup together and returning one prioritized accept or reject. Use when asked is it safe to merge, sign off, accept, ship it, or LGTM, or for a full pre-merge check. A verdict, not a bug hunt on its own."
---

# Accept change

**Goal: decide whether a change is safe to accept against a stated goal. Act as the acceptance reviewer, not the author. Inspect the actual artifact, never the reviewer's self-report.**

## Constraints

- Review the diff, PR, or change as written. Open it. Do not trust a summary of it.
- Apply only findings that affect the stated goal and carry evidence. A finding with no artifact behind it is not a finding.
- Report first, fix only on request. After a reject the author fixes the Act on items and the pass reruns on the new diff.
- Give one-way-door changes more scrutiny than reversible ones.

## Acceptance rubric

State the rubric before reviewing. The change passes when every item holds:

- It does what the goal says, verified by running or reading the real result.
- It does not break behavior or callers the author did not account for.
- It stays within every stated limit (size budget, shape rules, stack), measured with the audit owned by **principle-laziness-protocol**. A breach is an Act on finding. With no stated limit, run the audit without `--budget`, report the net, and mark the item held (no limit stated).
- It leaves no comment or suppression that the code already says.
- Its failure modes are named, not hidden.

## Run

Run these as real invocations in report-only mode, with no edits. Each does its own digging. Do not redo their work by hand. When the diff is unchanged since an earlier **blast-radius** or audit run, reuse that output and say so. When the host cannot delegate, or the diff is small, run the reviewers one after another in-line per **delegate**.

1. **adversarial-review** for adversarial findings on the change.
2. **blast-radius** for what the change could break elsewhere, proved by running real code.
3. **no-comments** for comment and suppression cleanup, scoped to comments the diff adds or leaves stale.
4. **principle-prove-it-works** to verify the result against the actual artifact.

## Classify

Classify every finding with the taxonomy owned by **adversarial-review**: Act on, Consider, Noted, or Dismissed.

## Spec axis

Review the change against what it was meant to do. A handover or notes file is a claim to verify against the artifact, not a spec source. The fixed point is the plan's base commit, else the merge-base with the default branch. Diff with `git diff <fixed-point>` so uncommitted work is included, and confirm the diff is non-empty before reviewing. Find the spec source in order: the plan's done predicate or the ticket text, an issue reference in the commits, a path the user passed, a spec under `docs/specs/`. When the issue is unreachable, use the commit text and label it as such. If none exists, report no spec available and skip this axis. Report missing or partial requirements, scope creep, and implemented-but-wrong, quoting the spec line.

## Standards axis

Check the change against the repo's documented standards, such as `CODING_STANDARDS.md` or `CONTRIBUTING.md`, and against the baseline in [smell-baseline.md](references/smell-baseline.md). The documented standard overrides the baseline, and every smell is a judgement call, labelled a possible instance rather than a hard violation. Skip anything a tool already enforces.

Report the two axes separately. Do not rerank across them, since a change can pass one and fail the other.

## Return

Return the verdict first. Any Act on finding on either axis or any failed rubric item gives reject, otherwise accept. Then the rubric result, the classified findings, and the one thing most likely to bite.

Done when the diff was non-empty, every rubric item shows held or failed with evidence, every finding carries a class, and the verdict is stated.

Judge reader load per **principle-minimize-reader-load**.
