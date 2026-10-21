---
name: principle-boundary-discipline
description: "Apply when external data enters the system, such as the CLI, config, network, or an external API. Validate and handle errors there, and trust internal types so business logic stays pure."
---

# Boundary Discipline

Place validation, type narrowing, and error handling at system boundaries. Trust internal code. Keep business logic in pure functions and the shell thin and mechanical.

**Why:** Scattered validation is noisy, redundant, and gives a false sense of safety. Validate once at the boundary. Keeping logic out of framework wiring lets it be tested without the framework.

**Pattern:**
- **At boundaries** (CLI args, config files, external APIs, network protocols): validate, parse raw data into domain types, return one error type with messages written for the caller, not exception reprs, handle defensively.
- **Inside the system:** typed data and error propagation. Trust the types.
- **Across the boundary:** expose domain concepts and keep transport, storage, framework, and wire types behind it. Put a rule every entry point shares, such as a 0..100 range, in the domain type, and a rule one entry point needs, such as a CLI default, at that edge.
- **Logic:** put it in pure functions with no framework dependencies, and have the shell call them.
- **Interior callers:** migrate callers a new domain type breaks, per **principle-migrate-callers-then-delete-legacy-apis**.

**Test:** Grep the interior modules for `isinstance`, `except`, `raise`, and range or `None` checks on raw input. Every hit sits in a parse function or the shell, and a hit on an already-parsed value is deleted. Each piece of logic is a pure function the shell calls.

For the typed-language mechanics that express the boundary, see **principle-type-system-discipline**.
