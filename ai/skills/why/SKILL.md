---
name: why
description: "Searches history, ADRs, and sources for the motive behind a design choice, threshold, or past decision, separating facts from inference. Use when asked why did we choose X, why is it built this way, or what was the reasoning."
---

# Why

Use why when the motivation or history matters. Start with the code and Git
history. Search issues, documents, conversations, observability, error reports,
or analytics only when the host provides those sources.

1. State the target and the interpretation of the question.
2. Search source-control history, commits, tests, and code comments. With no PR or `gh`, use `git log` and `git diff` alone.
3. Search each available external source independently.
4. Record empty or unavailable sources as explicit gaps.
5. Cite every claim about intent. Label each claim with its tier from the epistemics reference (Direct, Supported, Inferred, Speculative, or Unknown). For
   defensive-looking code (null checks, retries, timeouts, rate limits, feature
   flags), search incident and postmortem history when available. Before
   returning, spot-check that each cited source says what the claim says and
   surface contradictions between sources.
6. Return evidence, confidence, and gaps. When the answer will guide
   implementation, add four lines: `Preserve:` what must stay true,
   `Change:` what the evidence allows to change, `Avoid:` what the history
   shows failed, `Risk:` what could break. Done when every intent claim
   carries a citation or a tier label (Unknown counts).

Never claim that an external source was searched when the host did not expose
it.

Read [epistemics.md](references/epistemics.md) before writing the answer, for
the confidence tiers and calibrated phrasing. Read
[code-archaeology.md](references/code-archaeology.md) for the git and `gh`
queries behind step 2.

When the missing knowledge lives with another person, use **to-questionnaire**.
