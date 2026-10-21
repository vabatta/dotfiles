---
name: architect
description: "Designs a new module, interface, or data shape before code, sketching types and boundaries, running competing candidates, then implementing against the chosen sketch. Use when designing something new before writing code, not for a mechanical edit to an existing shape. Trigger on design the interface, sketch the types, or design this module first."
---

# Architect

Design before implementing. Sketch types, function signatures, class shapes, and module boundaries with `not implemented` bodies and pseudocode. Synthesize across independent candidate perspectives, then fill in code against the chosen sketch. If implementation proves the sketch wrong, throw it out and redesign.

## Start

Record one task-list entry per phase before starting when the host provides task
tracking. Otherwise keep the phase list in the working notes so autonomous runs
still show their position and do not silently skip phases.

- A: Ground
- B: Sketch
- C: Agree (if opted in)
- D: Implement
- E: Scrap (if triggered)

## Phase A: Ground the problem

Build a real mental model of every system the new code touches. Run the **how** skill over the relevant subsystems.

Before sketching new interfaces, apply **principle-use-before-build**. Inspect
the standard library, installed dependencies, and existing project APIs that
could already provide the capability.

Naming a file isn't grounding. Produce the traced model **how** prescribes. If the design redefines ownership or layering, also run the **why** skill on the existing shape so the rationale becomes a constraint, not a guess.

Skip Phase A only when the work is genuinely greenfield with no surrounding system to integrate.

## Phase B: Sketch

Run the **arena** workflow with the design-sketch task and the Phase A grounding artifacts. Pass `references/runner-prompt.md` as each runner's brief, per **delegate**. Each candidate produces a design package shaped per `references/rationale-template.md`: the caller's usage written first, then the type sketch, function signatures, module map, and prose rationale derived from it.

Design it twice, per **arena**. Whole-shape alternatives, not point fixes inside one shape.

Screen every candidate against [`references/design-red-flags.md`](references/design-red-flags.md) before synthesis. Reject or revise shallow modules, information leakage, temporal decomposition, and pass-through methods.

Hand arena this default rubric: interface depth, fit of the data structures, agreement with the caller's usage, and red-flag count. Add task-specific points up to six.

Compare viable candidates on interface depth. Prefer the design that hides more complexity behind a smaller, simpler public surface. A rich interface can keep call chains short by concentrating capability instead of scattering it across layers.

The arena workflow returns one synthesized design package. The synthesis decision populates the rationale's "Synthesis decision" section. Copy the package to its home (see Outputs) before arena deletes its candidate directories.
Done when one synthesized package exists at that home with a red-flag screen result.

## Phase C: Agree (opt-in)

Default: proceed directly to implementation with the synthesized design. No human checkpoint. When **plan-work** or **tdd** follows as the next step, stop after this phase and hand them the package. Done when the package is handed on or signed off.

Opt in to a checkpoint when the invoker explicitly asks to stop and show the
design before implementation. Then surface the synthesized design and pause for
sign-off.

The synthesis can ship as its own commit either way. That's the "scaffold first" mode of **principle-foundational-thinking**; subsequent commits read as filling in bodies against a stable contract. Planned and scoped breakage during fill-in is fine, per **principle-outcome-oriented-execution**. For adversarial pressure on the design before implementing, run the **adversarial-review** skill on the synthesized sketch.

If the human pushes back on the shape (in a checkpoint or after the fact), treat that as Phase A evidence. Re-ground and re-run Phase B before writing more code.

## Phase D: Implement against the sketch

Replace `not implemented` bodies with code, pseudocode with logic. The synthesized sketch is the contract.

Deviations from the sketch are signal worth surfacing, not friction to absorb silently. If a function needs a parameter the sketch didn't anticipate, ask whether the sketch was wrong, the requirement was missed, or the implementation is overreaching. Surface it; don't bolt it on. Record each deviation under "Open questions and risks" in the rationale and in the final report; an absent human does not block.

Done when every sketch signature is implemented or removed, the usage examples run, and each deviation is listed.

## Phase E: Scrap when the architecture is wrong

If implementation keeps producing friction the sketch can't absorb, throw the sketch out. Don't bolt fixes onto a wrong design, per **principle-redesign-from-first-principles** and **principle-fix-root-causes**.

The signal is a *pattern*, not single instances. Tells:

- The same shape of workaround appearing repeatedly across unrelated code.
- Multiple unrelated edge cases that all need special-case branches.
- Types that need escape hatches (`any`, casts, optional fields always set in practice) to compile.
- The "we need a lock" reflex when the sketch said the state wasn't shared.
- Callers having to know the abstraction's internal rules to use it.
- Two or more independent Phase D deviations of the same shape across the implementation. Surfacing deviations is Phase D's job; a repeated pattern of them is Phase E's trigger.

Use judgment. A few edge cases don't condemn an architecture. Some problems are legitimately complex; complexity in the data is not complexity in the design. The rewrite signal is repeated friction of the same shape, not single hard cases.

When you scrap:

1. Re-run the **how** skill over what's been built. The implementation lessons enter the new design as inputs, not vibes.
2. Redesign as if the new constraints had been day-one assumptions, per **principle-redesign-from-first-principles**.
3. Subtract before adding, per **principle-subtract-before-you-add**. The new sketch should be smaller than the old one before it grows.
4. Return to Phase B and re-run arena.

## Outputs

The caller's usage is written first and the type sketch derived from it. One file with new types and signatures for small changes; module map plus type definitions for larger work. The rationale ships alongside, shaped per `references/rationale-template.md`, including the usage sketch and the synthesis decision. Write both to `.agent/runs/architect/<slug>/` (ignore `.agent/` per the rule in the skills `AGENTS.md`). When the design is hard to reverse, also record it as an ADR via **domain-modeling**, which owns the ADR location. With no checkpoint, list the open questions in the final report.

## Vocabulary

Use the shared vocabulary for module design, not the words component, service, API, or boundary. See [deep-modules.md](references/deep-modules.md) for Module, Interface, Depth, Seam, Adapter, Leverage, and Locality plus the deletion test, and [deepening.md](references/deepening.md) for how dependencies decide the seam and the test strategy. A module earns its keep when deleting it makes the complexity reappear across its callers.

Concentrate validation at the system boundaries and keep business logic in pure functions, per **principle-boundary-discipline**.

Encode the domain in the types and keep illegal states unrepresentable, per **principle-model-the-domain** and **principle-type-system-discipline**.
