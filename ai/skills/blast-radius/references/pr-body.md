# PR body

Shape a pull-request body in three sections. Keep it free of preamble and use the project's domain language.

## Summary

Pick the smallest view that makes the point: pseudocode for logic and algorithms, a call tree for runtime control flow, a component tree including state and module boundaries, a shallow file tree for responsibility and refactors, a Mermaid diagram for interaction or data flow, or a diff when the shape already exists. Show the whole block when the change is mostly new or when omitted context hides ownership order. Use several views, not all, each next to the text it supports.

## Evidence

State the ladder level reached for the one safety fact and paste the proof script output, per **blast-radius**. Then show before and after. Screenshots are the strongest when the change is visual. Execution-based evidence is next, test results or console output, including the exact test going from failing to passing.

## Merge danger

State the **Door**, one-way when it is destructive or hard to reverse, two-way when it can be walked back. State the **Blast radius** as a short impact description, such as a layout shift, a consumer breakage, or mobile responsiveness. Add ramifications only when they are non-obvious.

This is the write-up shape used when a change is presented for review. The proof itself still comes from **blast-radius** and **principle-prove-it-works**.
