---
name: arena
description: "Builds competing candidate artifacts in isolation, scores them against a rubric, and synthesizes one result. Use when asked to implement or draft several versions and pick the best, not for one design to build or a feel test. Trigger on bake-off, score the options, or compare candidate implementations."
---

# Arena

Use an arena for a design or implementation choice with several credible
solutions. Do not use it for a mechanical change.

1. Define the artifact, its definition of done, and a three-to-six-point rubric.
   Done when all three are written.
2. Produce at least two structurally different candidates when the decision is
   architectural.
3. Fan the writers out per **delegate**, each with its own directory under
   `.agent/runs/arena/<slug>/candidate-N/`. Isolation comes from the separate directories (**principle-separate-before-serializing-shared-state**).
4. Read every candidate and score it against the rubric.
5. Select the base by rubric score. Break ties with the smallest, clearest
   public surface.
6. Graft only ideas that preserve one coherent design. Record rejected ideas.
7. Verify the synthesized artifact against the original definition of done.
8. Fold the verdict into real code, unless the caller asked only for the
   selected artifact. When the decision is hard to reverse,
   surprising, or a real trade-off, record it as an ADR via the
   **domain-modeling** skill, which owns the ADR format and location; the
   rejected ideas are exactly what an ADR should carry. Write the rejected ideas
   into the rationale or ADR before deleting the candidate directories, which
   stay working state.

Return the candidates considered, the rubric scores, the selection, the grafts,
the rejected ideas, and the verification result.

For a human-felt throwaway comparison rather than scored candidates, use **prototype**.
