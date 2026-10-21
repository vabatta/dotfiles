---
name: how
description: "Traces a subsystem's call graph and data flow and returns a written trace, used as a step inside other skills or to answer where code lives. Use when explicitly asked to trace or map code. Trigger on trace this, map this, or where does this live. Not for teaching a learner."
---

# How

Build a working mental model from the repository. Do not infer behavior from
file names alone.

1. State the scope and the likely entry point.
2. Trace inputs, state, control flow, outputs, and side effects.
3. Read the definitions and callers needed to close the path.
4. Use independent explorers via **delegate** for genuinely separate seams
   when the host can delegate. Otherwise explore sequentially, per **delegate**. Explorers
   follow [explorer-prompt.md](references/explorer-prompt.md).
5. Explain the result with an overview, key concepts, flow, file map, and
   gotchas. With explorer findings in hand, the explainer follows
   [explainer-prompt.md](references/explainer-prompt.md). A solo agent skips
   the explorer format and writes the same sections directly. The answer
   opens with scope and entry point and has Overview, Key Concepts, How It
   Works, Where Things Live, and Gotchas. Done when each claim in How It Works
   and Gotchas names a file or symbol.

Reference concrete files and symbols. Distinguish observed behavior from
inference. Do not prescribe a change unless the user asks for one.
