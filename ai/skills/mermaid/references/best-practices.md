# Mermaid Best Practices, CLEAR Principles, and Anti-Patterns

> Sources: mermaid.js.org/intro/syntax-reference.html, mermaid.js.org/syntax/, github.com/mermaid-js/mermaid, "The Official Guide to Mermaid.js" (Packt, 2021), collected community practices (retrieved May 2026)

## Table of Contents

1. [The CLEAR Principles](#the-clear-principles)
2. [Diagram Type Selection](#diagram-type-selection)
3. [Anti-Patterns to Avoid](#anti-patterns-to-avoid)
4. [Diagram Scoping and Decomposition](#diagram-scoping-and-decomposition)
5. [Markdown Integration and Documentation Context](#markdown-integration-and-documentation-context)
6. [Quality Checklist](#quality-checklist)

---

## The CLEAR Principles

Six principles for excellent Mermaid diagrams, forming the acronym CLEAR.

### C — Communicative Labels

Every visible label — node text, edge annotation, participant name — must communicate meaning to the reader. Diagrams exist to transfer understanding, not to encode logic.

Anti-pattern: single-letter node IDs (`A`, `B`, `C`) or opaque abbreviations (`svc1`, `proc`, `hdlr`) used as visible labels. These force the reader to build a mental lookup table, defeating the purpose of a diagram.

```mermaid
%% BAD — the reader has no idea what A, B, C are
flowchart LR
  A --> B --> C

%% GOOD — the reader understands instantly
flowchart LR
  ingest[Ingest Event] --> enrich[Enrich Data] --> store[Store Record]
```

### L — Lean

A diagram should contain the **minimum elements** needed to communicate its idea. Every node, edge, and label earns its place by contributing to understanding. Strip incidental detail.

Anti-pattern: a flowchart that shows every validation step, every error handler, every logging call, and every retry path. The reader cannot find the main flow in the noise.

Ask: "If I removed this element, would the reader lose the core message?" If not, remove it.

### E — Exact Type

Use the diagram type that precisely fits the communication goal. Misusing a type (e.g., a flowchart for time-ordered message exchange) forces the reader to mentally translate between the diagram's visual grammar and the actual concept.

Anti-pattern: using a flowchart to show request/response exchanges between services when a sequence diagram would show the temporal ordering natively.

### A — Accessible Direction

Layout direction should match the reader's mental model. Left-to-right for processes and pipelines (time flows right). Top-to-bottom for hierarchies and decision trees (specificity flows down). The choice is not aesthetic — it is semantic.

Anti-pattern: a `RL` (right-to-left) flowchart for a process that naturally flows forward in time, forcing the reader to trace it against their reading direction.

### R — Restrained Styling

Use visual styling (colours, classes, thick lines) only when it carries **semantic information** — green for success states, red for error paths, dashed lines for optional flows. Gratuitous colour turns a diagram into a colouring book.

Anti-pattern: applying unique colours to every node "to make it pretty". The reader now wonders what the colour differences mean, adding cognitive load instead of reducing it.

Rule of thumb: if you cannot write a legend for your colour scheme in one sentence, you are using too many colours.

---

## Diagram Type Selection

Choosing the wrong diagram type is the most common high-level mistake. Use this decision guide:

### "I want to show steps, decisions, and branching logic"
→ **Flowchart** (`flowchart`). The workhorse. Good for processes, algorithms, decision trees, and any directed flow.

### "I want to show messages between systems or people over time"
→ **Sequence Diagram** (`sequenceDiagram`). The temporal dimension (top-to-bottom = time passing) is the key differentiator from flowcharts. If the order of messages matters, this is the type.

### "I want to show object structure, inheritance, or composition"
→ **Class Diagram** (`classDiagram`). Shows static structure — types, relationships, methods. Not for runtime behaviour.

### "I want to show how something changes state over its lifetime"
→ **State Diagram** (`stateDiagram-v2`). Models a single entity's lifecycle as states and transitions. If you're saying "when X happens, the thing moves from state A to state B", this is the type.

### "I want to show how database tables relate"
→ **ER Diagram** (`erDiagram`). Entities, attributes, cardinality, keys. The standard for data modelling.

### "I want to show a project schedule"
→ **Gantt Chart** (`gantt`). Tasks on a timeline with dependencies, milestones, and critical paths.

### "I want to show proportions or a breakdown"
→ **Pie Chart** (`pie`). Simple proportional breakdown. Keep to ≤ 6 slices.

### "I want to brainstorm or show a concept hierarchy"
→ **Mindmap** (`mindmap`). Radial hierarchy from a central idea. Good for brainstorming, taxonomy, or topic decomposition.

### "I want to show system context at the C4 level"
→ **C4 Diagram** (`C4Context`, `C4Container`, `C4Component`). Simon Brown's C4 model for software architecture at increasing levels of detail.

### "I want to show git branching strategy"
→ **GitGraph** (`gitGraph`). Branches, commits, merges, tags, cherry-picks.

---

## Anti-Patterns to Avoid

### 1. The Alphabet Soup Diagram

Nodes labelled `A`, `B`, `C`, `D` with no descriptive text. The diagram is meaningless without a separate legend or explanation.

Fix: use descriptive IDs and labels. IDs can be short (`req`, `val`, `proc`) as long as the label brackets contain meaningful text.

### 2. The Kitchen Sink

A single diagram trying to show everything: the data model, the runtime flow, the deployment topology, the error handling, and the monitoring setup.

Fix: one diagram, one concern. Split into multiple diagrams, each with a clear title explaining what aspect it covers.

### 3. The Spaghetti Diagram

So many crossing edges that the reader cannot trace any single path. This usually happens when the direction is wrong (a `TD` diagram that should be `LR`) or when there are too many nodes for a single diagram.

Fix: change direction, reduce node count, split the diagram, or use subgraphs to group related nodes and reduce cross-cutting edges.

### 4. The Unlabelled Edge

Arrows connecting nodes without any indication of what the relationship means. The reader can see that A connects to B but has no idea why.

Fix: add edge labels. Keep them to 1–4 words. If the connection is truly self-evident from the node names, a label can be omitted — but this is rarer than people think.

### 5. The Decorative Diagram

Every node has a unique colour, every edge has a different line style, but none of the visual variation maps to any semantic distinction. The reader wastes time trying to decode a non-existent colour scheme.

Fix: style only when the styling conveys meaning. Define a small palette (2–4 `classDef` entries) and document what each means in a `%%` comment.

### 6. The Giant Sequence Diagram

A sequence diagram with 15 participants and 80 messages. The reader must scroll horizontally and vertically to find anything. By the time they reach message 40, they've forgotten what participants 1–5 were doing.

Fix: decompose into multiple sequence diagrams. Show the high-level interaction in one, then zoom into each subsystem's internal sequence in separate diagrams.

### 7. The Wrong Diagram Type

A flowchart used to show time-ordered message exchanges. A class diagram used to show runtime interactions. A state diagram used to show a process flow between multiple systems.

Fix: consult the [Diagram Type Selection](#diagram-type-selection) guide. If you find yourself bending a diagram type to fit your concept, you're using the wrong type.

### 8. The Stateless State Diagram

A state diagram where the "states" are actually actions: `Validate`, `Process`, `Send`. These are events or transitions, not states. States describe **conditions**: `Pending`, `Validated`, `Processing`, `Sent`.

Fix: rename states to noun phrases that describe the entity's condition at rest. Transitions carry the action verbs.

### 9. The Orphan Diagram

A diagram dropped into a markdown document with no surrounding context — no title, no introductory sentence, no explanation of what it shows or why the reader should care.

Fix: always introduce a diagram with a heading or sentence that frames what the reader is about to see. The diagram reinforces the prose; it doesn't replace it.

### 10. The Copy-Paste ER Diagram

An ER diagram auto-generated from a database schema with every table, every column, every junction table. It's technically accurate and completely unreadable.

Fix: curate. Show the entities and relationships relevant to the current discussion. Omit audit columns, internal IDs, and junction tables unless they are the point.

### 11. Subgraph Abuse

Using subgraphs for visual grouping with no semantic purpose, or nesting three or more levels deep until the diagram resembles a Russian doll.

Fix: subgraphs should represent meaningful boundaries — service boundaries, deployment zones, team ownership. Limit nesting to two levels.

### 12. Missing Direction

A flowchart with no explicit direction keyword, relying on the default `TD`. This is fine if top-to-bottom is genuinely correct, but often the omission signals the author didn't think about layout.

Fix: always declare direction explicitly. It takes four characters and removes ambiguity.

---

## Diagram Scoping and Decomposition

### One Diagram, One Audience Question

A well-scoped diagram answers **one question** for its audience:
- "How does an order flow through our system?" → flowchart
- "What messages are exchanged during authentication?" → sequence diagram
- "What states can a shipment be in?" → state diagram
- "How do our domain entities relate?" → ER diagram

If you cannot state the question in one sentence, the diagram needs splitting.

### The Zoom Metaphor

Think of diagrams as zoom levels on a map:
- **Context level**: the system and its external actors (C4 Context or simple flowchart)
- **Container level**: the major components within the system (C4 Container or subgraph flowchart)
- **Component level**: the internals of one container (class diagram, detailed flowchart, or sequence diagram)

Each level gets its own diagram. A context-level diagram that also shows class-level detail is trying to be a satellite photo and a street map at the same time.

### When to Split

Split a diagram when:
- It has more than ~15 nodes (flowchart) or ~8 participants (sequence)
- The reader has to trace crossing arrows to follow a single path
- Subgraphs nest more than 2 levels deep
- The diagram covers more than one lifecycle, service boundary, or decision domain
- It takes more than 30 seconds to find the main flow

### Cross-Referencing Between Diagrams

When a set of diagrams covers the same system at different zoom levels, tie them together with consistent naming. If the context diagram has a node called "Order Service", the detailed flowchart of that service should be titled "Order Service — Internal Flow". Use `%%` comments to reference related diagrams by name.

---

## Markdown Integration and Documentation Context

### Placement Rules

1. **Introduce before showing.** Write 1–2 sentences explaining what the diagram illustrates and why, then place the diagram immediately after.
2. **Keep diagrams near their prose.** Don't collect diagrams in an appendix — they lose context. Each diagram should be within scrolling distance of the text that references it.
3. **Use headings.** Give each diagram a heading (`### Authentication Flow`) so readers can navigate to it from a table of contents.
4. **One diagram per heading section.** If a section needs two diagrams, they should answer different questions and each deserves its own sub-heading.

### Fenced Code Block Format

Always use triple-backtick fencing with the `mermaid` language identifier. Do not use `~~~` fencing — it is less widely supported.

### Platform Considerations

Mermaid renders natively in GitHub, GitLab, Notion, Obsidian, and many documentation platforms. Be aware of platform-specific limitations:
- **GitHub**: renders diagrams in markdown preview but not in diffs. New diagram types (those marked 🔥 in Mermaid docs) may not render yet.
- **GitLab**: supports most diagram types; check version compatibility.
- **Obsidian**: renders locally via the built-in Mermaid plugin.
- **Docusaurus / MkDocs / VitePress**: require Mermaid plugins; check which version they bundle.

When targeting a specific platform, test that the diagram type you chose renders correctly there before committing.

---

## Quality Checklist

When reviewing or writing a Mermaid diagram, verify:

1. **Communicative labels** — every visible label is meaningful; no cryptic IDs or bare abbreviations.
2. **Correct diagram type** — the diagram type matches the concept (flow → flowchart, time-ordered messages → sequence, lifecycle → state, data model → ER).
3. **One concern** — the diagram answers one question; it is not overloaded.
4. **Lean content** — every element earns its place; incidental detail is stripped.
5. **Explicit direction** — flowcharts have a declared direction (`TD`, `LR`, etc.).
6. **Labelled edges** — non-obvious connections are annotated with 1–4 word labels.
7. **Meaningful subgraphs** — subgraph titles describe boundaries, ≤ 2 levels of nesting.
8. **Semantic styling** — colours and line styles carry meaning, not just decoration; ≤ 4 custom classes.
9. **No parser pitfalls** — `end` is escaped, special characters are quoted, `o`/`x` edge-starters are handled.
10. **Sequence diagram discipline** — participants declared in order, correct arrow types, control flow blocks used properly.
11. **State diagram discipline** — `[*]` for start/end, noun-phrase state names, action verbs on transitions.
12. **ER diagram discipline** — verb-phrase labels, correct cardinality, `--` vs `..` used intentionally.
13. **Prose context** — the diagram is introduced by text explaining what it shows and why.
14. **Appropriate scope** — the diagram is not a kitchen sink; large systems are decomposed into multiple diagrams at different zoom levels.
15. **Platform tested** — the diagram renders correctly on the target platform.
