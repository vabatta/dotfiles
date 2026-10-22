# Spec format

A spec is a behavior contract. Keep it free of file paths and implementation detail. Put `Status: ready` under the title once it is settled.

## Sections

1. Problem statement, from the user's point of view.
2. Solution, from the user's point of view.
3. User stories, long and numbered, `As a <actor>, I want a <feature>, so that <benefit>`.
4. Requirements, the testable unit. Write each as `### Requirement: <name>` with an RFC-2119 statement (SHALL, MUST, SHOULD, MAY), followed by `#### Scenario: <name>` in bulleted WHEN, THEN, AND form.
5. Implementation decisions, covering modules, interfaces, API, schema, and architecture. No file paths and no code, except decision-dense shapes such as a state machine, reducer, schema, or type signature. A seam may name a public symbol and its signature.
6. Testing decisions, covering what makes a good test (external behavior only), the modules, and any prior art.
7. Out of scope.
8. Further notes.

## Deltas for brownfield changes

When a change edits existing behavior, express it as a delta rather than rewriting the whole spec:

- `## ADDED Requirements`
- `## MODIFIED Requirements`, which replaces the target
- `## REMOVED Requirements`, which deletes it

Merging the deltas into the living spec is the record of truth. A requirement with its scenarios is the unit that can be tested, and each scenario maps directly to an acceptance test.
