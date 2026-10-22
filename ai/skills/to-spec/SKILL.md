---
name: to-spec
description: "Synthesises the current conversation into a written spec and publishes it, without interviewing. Use when a discussion is settled and a durable requirements artifact is needed before planning. Trigger on write the spec, capture the requirements, or turn this into a spec."
---

# To spec

Turn the current conversation into a spec. Do not interview. Synthesise what has already been discussed, read from the repository. For the interview that would settle open decisions first, use **grill** or **grill-with-docs**.

## Process

1. Explore the repo. Use the project glossary and respect ADRs, both owned by **domain-modeling**. When neither exists, note that and continue. Done when the relevant glossary terms and ADRs are read or noted absent.
2. State the test seams, the public entry points a test calls. Prefer existing seams and the highest one available, and the ideal count is one. This is one check, not an interview. Record the seam in the spec as an assumption when no one answers. Done when the seams are written in the spec's testing decisions.
3. Write the spec to `docs/specs/<slug>.md` using the format in [spec-format.md](references/spec-format.md), or publish it through **tickets** when the project tracks specs in the issue tracker, and put `Status: ready` as the first line under the title. Write the file by default, and use an issue only when the project's AGENTS.md says specs live there. Done when the file or issue exists and carries the status line.

For the ordered units and baseline that follow, use **plan-work**. For the design sketch the spec must not contain, use **architect**.

## What the spec is

The spec is a behavior contract. It states what the system must do, not how. No file paths and no code snippets, except decision-dense shapes such as a state machine, reducer, schema, or type signature when the shape itself is the decision.
