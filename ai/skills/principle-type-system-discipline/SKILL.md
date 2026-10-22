---
name: principle-type-system-discipline
description: "Apply when declaring types or signatures in statically typed code. Brand primitives, derive shapes from their schema, and exhaust every variant."
---

# Type System Discipline

Use the type checker as a proof assistant to eliminate mismatched primitives and unhandled variants at compile time.

**Why:** Types are the cheapest enforcement. A case they let through becomes a runtime failure the compiler could have stopped, and every handler they force is a chance to forget one. Prefer defining errors and special cases out of existence over proliferating handlers.

**Pattern:**
- Make illegal states unrepresentable per **principle-model-the-domain**, using the mechanics below.
- **Build types as constructions.** Build the type up from the values wanted instead of carving them out of a looser type with checks. A non-empty list is a head plus a rest, and a valid time range is a start plus a duration. Choose the shape that cannot build the illegal value and expose the interface callers need on top.
- **Brand semantic primitives.** `UserId` and `OrderId` are strings underneath but not interchangeable. Use newtypes in Rust, opaque types in Swift, value classes in Kotlin, phantom types in Haskell, branded intersections in TypeScript. Validate once at creation and trust the type downstream.
- Parse external data into the typed model per **principle-boundary-discipline**.
- **Prove facts to the compiler.** When it cannot establish a fact, validate, narrow, or refine the model instead of casting or asserting.
- **Exhaust matches on sum types.** Use the idiom the language provides so adding a variant fails compilation: a `never`-typed binding in TypeScript, an unannotated `match` in Rust, `-Wincomplete-patterns` in Haskell, sealed-class exhaustiveness in Kotlin, `assert_never` under a Python type checker. In untyped code, key a table by the enum and test that its keys equal the members.
- **Derive types from authoritative schemas** such as protocol buffers, OpenAPI, GraphQL, database migrations, or design-token files, instead of hand-rolling a parallel type. To make drift fail a check, see **principle-encode-lessons-in-structure**.
- **Strengthen a type only where partiality appears.** A runtime assertion, null check, or "this should never happen" throw marks a type that is too weak, so push that check into the type and stop. Prefer total functions: `sum` takes the plain list because an empty list gives 0, while `head` demands the non-empty one. Extra precision beyond that costs reuse and buys no safety.

**Test:** Run the project's type checker and read its exit code, or state the Test unverified. In the signatures this change adds or edits, no two arguments share a primitive type while meaning different things, no `any` or `as` survives without a validating boundary, adding a variant makes the checker flag every site needing a case, and no type duplicates a shape another file owns.
