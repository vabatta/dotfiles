---
name: recall
description: "Reconstructs recent work from the conversation, repository state, and history and returns one next move. Use when resuming work or the current state is unclear, or when handing off to a fresh session. Trigger on where were we, recall, what is the current state, or write a handoff."
---

# Recall

Use recall before resuming work when the current state is unclear.

1. Define the workspace, topic, and time window.
2. Read the current conversation and live repository state first. Read any named handover file and `.agent/handoffs/` as claims to verify, not as facts.
3. Search host-provided session history when available. Never invent a history
   path or read another workspace without permission.
4. Search Git history and configured external records for named work.
5. Verify branches, commits, files, and handover claims against live state.
6. Return a short capsule, thread statuses, problems, and one next move. Name the skill that runs the next move. List every wrong claim under problems and offer to rewrite a stale handover file.

Done when each thread has a verified status and exactly one next move is named.

If a history or integration source is unavailable, report the gap and continue
with the sources that exist.

## Handoff mode

When the next session is a fresh agent rather than you, write a portable handoff document instead of a spoken capsule. Run steps 2 to 5 first. Ignore `.agent/` first per the rule in the skills `AGENTS.md`, then save it to `.agent/handoffs/<slug>.md` with a short topic slug. Overwrite a same-named stale file only after listing its wrong claims under problems. Use these sections: verified state, next move, suggested skills (by name), references (paths, URLs, and any decision trail from **show-me-your-work**), and open questions. Do not duplicate content already in specs, plans, ADRs, issues, commits, or diffs, reference them by path or URL. Redact secrets and personal data. If the caller names the next session's focus, tailor the document to it.
