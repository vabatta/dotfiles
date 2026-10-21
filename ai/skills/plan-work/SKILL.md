---
name: plan-work
description: "Turns a request into ordered, independently landable units, each with a check and a baseline to measure against. Use for a routine multi-step effort, or when asked to plan, break down, or sequence work into tasks or slices. Trigger on plan this, break it down, decompose, or sequence the work."
---

# Plan work

**Goal: turn a request into ordered, independently landable units, each with a check, and a baseline to measure against. Write the plan to `.agent/runs/plan-work/<slug>.md` before the work starts.**

## Definition of done

State the done condition as a falsifiable predicate. If no test, command, or read can return true or false for it, it is not a done condition. Fold every limit the request states (size budget, shape rules, stack) into the predicate with its check, per **principle-laziness-protocol**. State the stack, and a net-added-lines budget (the request's, else an estimate). Done when a command can return true or false for the predicate.

## Harness and baseline

Build the verification harness and capture the baseline before touching the work. A unit with no before-and-after is not verifiable. With no harness, build the smallest one first from the standard library and say so. It is a test, so it does not count toward the budget. See **principle-prove-it-works**. Done when the baseline output is saved beside the plan.

## Decompose and sequence

Break the work into atomic units. Each unit lands on its own, and each ends in a state a reviewer can check without the next unit. Sequence riskiest-unknown-first, and among equals delete before adding. Write the unit list into the plan. A request that is one unit needs no decomposition, so the plan is the predicate, the baseline, and one check. Verify each unit with its own check when it lands, and run **accept-change** once on the combined change after the last unit lands.

Apply these as named references where their rules govern the shape:

- **principle-sequence-verifiable-units** for how units stack and land.
- **principle-foundational-thinking** for the core types and structures underneath.
- **principle-subtract-before-you-add** for what to remove before building.
- **principle-make-operations-idempotent** for steps that run amid crashes and retries.

## Fan out

Decide what fans out. Give each worker its own output through **delegate**. Once the units exist as GitHub issues, track them with **tickets**.

## One-way doors

Route one-way-door design decisions to **architect** before sequencing around them.

## Spec and human steps

Consume the settled requirements from a spec. If none exists, write one with **to-spec** before sequencing. For steps only a human can perform, use **wizard**.

## Return

Return the done predicate, the stack and budget, the baseline, the ordered units with a check per unit, and what fans out.

**Test:** the plan file states a falsifiable predicate, a saved baseline, units that each carry a check, and a fan-out verdict.
