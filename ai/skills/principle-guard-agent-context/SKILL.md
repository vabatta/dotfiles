---
name: principle-guard-agent-context
description: "Apply when context is filling up, on outputs or files over about 200 lines, repeated reads, or fan-out planning. Reduce bulk with a script or route it to subagents, and keep summaries in the main thread, not raw payloads."
---

# Guard Agent Context

Make every token that enters the context window earn its place.

**Why:** The window is finite and non-renewable within a session. Overflow degrades reasoning, creates compression artifacts, and halts progress.

**Pattern:**
- Treat any output, file, or document over about 200 lines or 10 KB as bulk, and never print it in full.
- Reduce bulk in place first with a script, grep, or jq that prints only what matters. Route it to a subagent only when the reduction needs judgment, and keep the summary in the main thread.
- Read selectively, only what the current task needs.
- Keep frequently used content inline, since a separate file costs a read each time.
- Size phases and cap scope by limiting files per phase and setting turn budgets.

**Test:** No tool output over 200 lines was printed in full, and each bulk payload appears only as a summary plus an artifact path in the session scratchpad.

For one big payload, use a script or a single worker. For several independent slices, use **delegate**.
