---
name: principle-encode-lessons-in-structure
description: "Apply when the same instruction is about to be written a second time, or a correction keeps recurring. Encode the rule as a lint, metadata flag, runtime check, or script instead of more text."
---

# Encode Lessons in Structure

Encode recurring fixes in mechanisms (tools, code, metadata, automation) instead of textual instructions.

**Why:** Textual instructions require the reader to notice, remember, and comply. Structural mechanisms enforce the rule without cooperation, and the instruction itself is the symptom of a missing one.

**Pattern:**
1. Grep docs and agent files for an existing version of the rule, then ask whether it can be a lint rule, a metadata flag, a runtime check, or a script.
2. If yes, encode it, run it against a known violation and watch it fail, wire it into something that already runs (CI, test suite, or hook, else name the cheapest host), then delete the instruction.
3. If it genuinely requires judgment, make the instruction more prominent and add an example of the failure mode.
4. Pick the strongest rung when several mechanisms work: an unrepresentable state that cannot compile, then a lint or banned API that fails CI, then a canonical helper, then a runtime check. Agents copy whatever the surrounding code does, so a weaker guard becomes the next template.
5. Apply the structural fix alone when one exists, and leave the symptom patch out.
6. When a human corrects you, decide one-off versus recurring. If recurring, encode it as a check or script now or file it, because a promise to remember does not persist.

**Test:** A lint, flag, check, or script ran red on a known violation and runs in CI, the test suite, or a hook. Grep finds no standalone prose statement of the rule in docs, agent files, or comments. The mechanism's own failure message may name it.

For routing the lessons of a finished session, use **reflect**.
