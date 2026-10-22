---
name: grill-with-docs
description: "Grills the user to sharpen a design while writing the ADRs and glossary the conversation implies. Use when a design conversation should leave a written record as it goes. Trigger on grill with docs. Not for a plain interview that needs no written record."
---

# Grill with docs

Run the **grill** skill and the **domain-modeling** skill together. Writing a glossary entry or an ADR records a settled answer, so it is not the action the grill waits to act on: write each one as its decision settles, never batched at the end. Mention each ADR written in the next round so the user can veto it. When the user is unreachable, write each glossary entry or ADR from the labeled assumption, mark the ADR `proposed`, and list it in the hand-off.

Done when the frontier is empty, the user has confirmed (or the assumptions are recorded), every settled term is in the glossary, and every decision that passes the ADR tests has its ADR.
