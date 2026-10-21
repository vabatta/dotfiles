---
name: principle-prove-it-works
description: "Apply when a task is complete and before declaring it done. Verify against the real artifact (run the feature, read the actual value, inspect the diff), not a proxy, self-report, or 'it compiles.'"
---

# Prove It Works

Verify every task output by checking the real thing directly.

**Why:** Unverified work has unknown correctness. Indirect verification (file mtimes, output freshness, agent self-reports, cached screenshots) feels cheaper than direct observation, and acting on a wrong inference costs far more than checking the source.

**Pattern:**
- Build it, which is necessary but not sufficient.
- Run it and exercise the actual feature path. For integrations, test the full communication path end to end. When the changed code has no entry point, call it from a one-line script and read the returned value.
- Check state directly (is the process alive?) and read the actual value, not a cached or derived representation.
- When verification fails, suspect the observation method before the system.
- Inspect the output artifact of delegated work (git diff, file contents, runtime behavior), not the delegate's summary.
- Audit the change against every stated limit (budget, shape, stack) with the checks owned by **principle-laziness-protocol**, **principle-minimize-reader-load**, and **principle-use-before-build**.
- Script the check when possible. A deterministic script that reruns the same comparison beats a one-time eyeball, and its output is an artifact a reviewer can rerun.
- Keep the artifact visible to the human. For large or complex work whose trail must be auditable, use **show-me-your-work**.

**Test:** The real artifact was run and the actual value read, with the command and its output quoted in the report. "It compiles", a file timestamp, or a delegate's summary does not count.
