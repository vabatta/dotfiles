# Glossary format

## Structure

```md
# {Context Name}

{One or two sentence description of what this context is and why it exists.}

## Language

**Order**:
{A one or two sentence description of the term}
_Avoid_: Purchase, transaction

**Invoice**:
A request for payment sent to a customer after delivery.
_Avoid_: Bill, payment request
```

## Rules

- Be opinionated. When multiple words exist for the same concept, pick the best one and list the others under `_Avoid_`.
- Keep definitions tight. One or two sentences max. Define what it IS, not what it does.
- Only include terms specific to this project's context. General programming concepts do not belong even if the project uses them extensively.
- Group terms under subheadings when natural clusters emerge. If all terms belong to a single cohesive area, a flat list is fine.

## Single vs multi-context repos

In a multi-context repo, `docs/glossary-map.md` lists the contexts, where they live, and how they relate:

```md
# Glossary Map

## Contexts

- [Ordering](./glossary/ordering.md): receives and tracks customer orders
- [Billing](./glossary/billing.md): generates invoices and processes payments

## Relationships

- **Ordering → Billing**: Shared types for `CustomerId` and `Money`
```

If `docs/glossary-map.md` exists, read it to find contexts. If only `docs/glossary.md` exists, single context.
