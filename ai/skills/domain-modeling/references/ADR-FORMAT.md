# ADR Format

ADRs use sequential numbering, `0001-slug.md`, `0002-slug.md`, and so on.

## Template

```md
# {Short title of the decision}

{1-3 sentences, what is the context, what did we decide, and why.}
```

That is it. An ADR can be a single paragraph. The value is in recording that a decision was made and why.

## Optional sections

Only include these when they add genuine value. Most ADRs will not need them.

- **Status** frontmatter (`proposed | accepted | deprecated | superseded by ADR-NNNN`) when decisions are revisited
- **Considered Options** only when the rejected alternatives are worth remembering
- **Consequences** only when non-obvious downstream effects need to be called out

## When to write an ADR

The three tests in SKILL.md must all hold before writing one. Qualifying decisions include architectural shape, integration patterns between contexts, technology choices that carry lock-in, boundary and scope decisions, deliberate deviations from the obvious path, constraints not visible in the code, and non-obvious rejected alternatives.
