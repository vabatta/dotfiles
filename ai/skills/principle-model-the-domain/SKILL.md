---
name: principle-model-the-domain
description: "Apply when conditionals or booleans encode domain rules. Replace the branch ladder with a datatype that models the domain."
---

# Model the Domain

Encode the real domain in a data structure instead of scattering it across conditionals.

**Why:** Scattered booleans, repeated shape assumptions, and branching spread across files are accidental complexity. A structure that matches the domain makes invalid states unrepresentable and deletes branches. This skill owns the encode-the-domain call, including when to make invalid states unrepresentable. Choosing it at write time is cheap, while recovering it later reads as a refactor and gets deferred.

**Pattern:** Reach for the structure that fits.
- A state machine for scattered booleans, phases, or lifecycle checks.
- A typed object or model for loose parameters or repeated shape assumptions.
- A map, registry, lookup table, or discriminated union for branching spread across files.
- A reducer or command/event model for ad hoc state mutations.
- A module organized around one body of domain knowledge, not a sequence such as load, validate, transform, and save. Execution order is not ownership.
- A small module boundary that gathers repeated behavior, ownership, or invariants.
- A queue, cache, index, graph or tree, or normalized collection where the access pattern calls for it.
- Otherwise, work out what the code must never allow and how the data gets read, then find the structure that encodes exactly that.

In a dynamic language, a closed table plus a raising lookup counts as unrepresentable. For a new module with no branching yet, choose the structure per **principle-foundational-thinking**.

Keep boring code when the current shape is clear, local, and unlikely to grow. An abstraction earns its place by removing branches, duplicated rules, invalid states, or lifecycle risk.

**Test:** No chain of two or more branches on one discriminator (grep `elif` and `else if`) and no boolean pair with illegal combinations encodes the domain rule, and phase-named modules do not repeat the same rule across steps.

For the typed-language mechanics that express it, see **principle-type-system-discipline**.
