---
name: principle-build-the-lever
description: "Apply when the same mechanical edit repeats across five or more sites. Build a codemod, script, or generator instead of editing by hand, so a reviewer can rerun it."
---

# Build the Lever

When the work is not trivial, build the tool that does it instead of doing it by hand.

**Why:** Throughput: a codemod, generator, or script does the work the same way every time and reruns for free. Confidence: the tool is one artifact a reviewer can read and rerun, while hand-done changes can only be re-verified by redoing them.

**Pattern:**
- Skip the lever only when the edit is obvious and touches fewer than 5 sites. Five or more sites, or any non-obvious edit, earns a lever.
- First apply **principle-use-before-build** to the lever itself, since the language, installed dependencies, or project tooling may already provide it.
- Do the first unit by hand to learn the recipe, then build the tool. Prove it by rerunning it on that unit and diffing against the hand-done version.
- Make the lever safe to rerun. Commit it when the work outlives the session.
- Pick the form that fits: a codemod or script for edits, a generator for repetitive files, a dump-to-sqlite query for analysis, a rerunnable check for verification.
- Run a lever that covers every unit in one pass directly. When work does fan out, brief the delegates per **delegate**.
- Build the smallest script that does or proves the job, per **principle-laziness-protocol**. The bar is triviality, not repetition, so a one-off still earns a lever when the lever is what makes the work checkable.

**Test:** The diff contains the lever and a rerun that reproduces the hand-done unit. A grep for the old pattern across the target scope shows zero remaining matches, or each match is listed as an exception.

Script the verification itself per **principle-prove-it-works**.
