---
name: delegate
description: "Briefs independent workers with an owned output and a proof requirement, then verifies their artifacts. Use when work can be split into independent, non-competing slices and run in parallel. Trigger on subagents, parallelize, fan out, or run these independently. Not for debating a question or reviewing a change."
---

# Delegate

Delegate only when it reduces risk or buys independent coverage.

## When to use

Use it for genuine independent seams, independent coverage, or isolated verification. Do not parallelize shared writes. Parallel fan-out is not a default: a deterministic lever beats fan-out, so if one script can do the work, run it instead. See **principle-build-the-lever**.

## Steps

1. State the done predicate and the artifact or report required.
2. Partition the work.
3. Give every worker a complete brief, an owned output location, and a proof requirement.
4. Run workers through the host's delegation capability. When the host cannot delegate, run the slices one after another. Sequential still means one written brief per slice, one owned output per writer, and a review pass kept apart from the writing pass (a separate agent or model where possible, otherwise a labelled self-review). Done when every slice has a brief and an output.
5. Read the actual outputs. Do not aggregate self-reported success.
6. Report coverage, evidenced issues, gaps, and worker failures in the reply. Save briefs and longer reports under `.agent/runs/delegate/`.

## Briefs

A worker starts with empty context and does not inherit the host's loaded skills, so the brief stands alone. Carry the goal, the done predicate, the owned output location, the proof requirement, and every rule the worker must follow. Inline each stated limit as a number or rule. Split the size budget across writer slices as net-added-line caps, where a share may be zero, and require each writer to report its net added lines against its share. Read-only workers get no share. Name a skill the host already loaded only as a pointer, and inline the rule itself with attribution, as **architect** does for its runners. The brief passes when a worker with no skill tool can follow it.

## Isolation

Each writer gets its own file, branch, or directory. See **principle-separate-before-serializing-shared-state**.

## Roles

A worker is a writer or a read-only participant. A writer gets an isolated output location and owns a deliverable. A read-only participant — reviewer, lens, or judge — gets no write scope and returns a report.

Give every worker the policy role for its work (`exploration`, `implementation`, `judgment`, or `prose`), naming the role and never a model, per **setup-ai**.

When a caller asks for diverse coverage — "diverse", "vary the models", "use different models", "independent" — resolve that role through a diversity pool: take distinct entries from the role's list and give each worker a different one. Default to the session model for every role; never vary the model unless the caller asked for diversity or the policy pins a pool. When the pool has fewer entries than workers, reuse from the start, and say so in the report. When the host cannot spawn the models the pool names, report that diversity was not achieved.

## Verification

Inspect the artifact, not the summary. Treat an agent's report as a pointer, not as proof. Prefer a separate reviewer for verification. See **principle-prove-it-works**.

## Research mode

To delegate reading legwork to one worker (no partition or budget share), run a background agent in the `exploration` role that investigates against primary sources, official docs, source code, specs, and first-party APIs, and follows every claim back to the source that owns it. Run **why** for the claims. If notes are saved, save them under `.agent/`.

Keep the main thread lean, per **principle-guard-agent-context**.
