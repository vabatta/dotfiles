---
name: domain-modeling
description: "Builds and sharpens a project's domain model by challenging terms, probing concrete scenarios, and writing a glossary and ADRs as decisions settle. Use when naming or defining a term, or when writing an ADR for a settled decision. Merely reading a glossary for vocabulary is not this skill, and neither is interviewing the user."
---

# Domain Modeling

Actively build and sharpen the project's domain model during design. This is the *active* discipline: challenging terms, inventing edge-case scenarios, and writing the glossary and decisions down the moment they crystallise. Reading `docs/glossary.md` for vocabulary is a one-line habit any skill can do. This skill is for changing the model, and a conflict found while reading hands over to it.

## File structure

Most repos have a single context:

```
/
├── docs/
│   ├── glossary.md
│   ├── glossary-map.md        # only when the repo has multiple contexts
│   └── adr/
│       ├── 0001-event-sourced-orders.md
│       └── 0002-postgres-for-write-model.md
└── src/
```

When the repo has multiple contexts, `docs/glossary-map.md` indexes them and each context keeps its own glossary under `docs/glossary/<context>.md`.

Create files lazily, when there is something to write: `docs/glossary.md` with the first resolved term, `docs/adr/` with the first ADR.

## During the session

### Challenge against the glossary

When the user uses a term that conflicts with the existing language in `docs/glossary.md`, call it out immediately. "Your glossary defines 'cancellation' as X, but you seem to mean Y. Which is it?"

### Sharpen fuzzy language

When the user uses vague or overloaded terms, propose a precise canonical term. "You're saying 'account': do you mean the Customer or the User? Those are different things."

### Discuss concrete scenarios

When domain relationships are being discussed, stress-test them with specific scenarios. Invent scenarios that probe edge cases and force the user to be precise about the boundaries between concepts.

### Cross-reference with code

When the user states how something works, check whether the code agrees. If you find a contradiction, surface it: "Your code cancels entire Orders, but you just said partial cancellation is possible. Which is right?"

### Update the glossary inline

When a term is resolved, update `docs/glossary.md` (or `docs/glossary/<context>.md` in a multi-context repo) right there, one term at a time. Use the format in [GLOSSARY-FORMAT.md](references/GLOSSARY-FORMAT.md).

`docs/glossary.md` holds glossary entries only. Specs belong to **to-spec**, and decisions belong in ADRs.

### Write ADRs sparingly

Write an ADR only when all three are true:

1. Hard to reverse, the cost of changing your mind later is meaningful.
2. Surprising without context, a future reader will wonder why it is this way.
3. The result of a real trade-off, there were genuine alternatives and one was picked for specific reasons.

When any of the three is missing, record nothing. Write a qualifying ADR straight away and mention it in one line, so the user can delete it. Use the format in [ADR-FORMAT.md](references/ADR-FORMAT.md), which also holds the numbering and what qualifies.

Done when each term resolved in the session is in the glossary and each decision that passed the three tests has an ADR, or none qualified.
