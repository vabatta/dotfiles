---
name: no-comments
description: "Removes code comments, suppressions, and warning markers that restate code, keeps durable constraints, and encodes recurring ones as structure. Use when comments or suppressions need cleanup."
---

# No Comments

Review the requested files or the current diff. A comment earns its place when
the code cannot express the reason and the reason is stable enough to preserve.
Scope is code comments, docstrings, TODO and FIXME markers, and suppressions such
as `noqa` or `eslint-disable`. Warnings means warning comments and suppressed
linter or compiler warnings.

1. Identify comments, suppressions, and warnings in scope. Done when each is listed.
2. Remove comments that restate the code, narrate mechanics, or preserve a
   workaround that can be deleted.
3. Keep comments that explain an external constraint, a non-obvious invariant,
   or a deliberate tradeoff. A comment that flags a known defect is a TODO in
   disguise. Fix the defect and delete the comment, or keep it and report it.
4. For a real recurring constraint, offer a type, test, lint rule, or runtime
   check instead of a comment.
5. Verify that the resulting code still explains its behavior and that tests
   cover the encoded constraint. With no test setup, a runtime check or a
   one-off script run is the proof, and the report says which.

Done when every remaining comment names a constraint the code cannot express
and the verification ran.

For an independent reviewer, use **delegate**, and inspect its findings
yourself before applying them.

In the review flow, **accept-change** runs this as its comment-cleanup lens.

Removing restatements is **principle-minimize-reader-load** applied to prose.
