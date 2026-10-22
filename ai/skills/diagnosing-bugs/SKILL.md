---
name: diagnosing-bugs
description: "Runs a diagnosis loop for hard bugs and performance regressions that builds a red-capable feedback loop before hypothesising, then fixes at the root. Use when the user says diagnose or debug this, or reports something broken, throwing, failing, or slow, not for a failure whose cause is already known."
---

# Diagnosing bugs

The practicing companion to **principle-fix-root-causes**. That skill states the rule; this one runs the loop. Skip a phase only with a stated justification, and read the project glossary and any area ADRs, owned by **domain-modeling**, when exploring. Skip them when none exist.

Redact first. Replace every secret with `<REDACTED>` in commands, output, and artifacts. Build loops against environment variables so credentials stay out of files. Quote only the signal-bearing lines. If redaction leaves too little to reason about, say so and ask.

## Phase 1: Build a feedback loop

This is the skill. Build a tight pass or fail signal that goes red on this bug. Spend disproportionate effort here. Be aggressive, be creative, refuse to give up.

Construction ladder, best first:

1. A failing test at any seam.
2. A curl or HTTP script.
3. A CLI invocation with a snapshot diff.
4. A headless browser asserting DOM, console, or network.
5. A replay of a captured trace.
6. A throwaway harness with mocked dependencies.
7. A property or fuzz loop.
8. A bisection harness for `git bisect run`.
9. A differential loop, old versus new.
10. A human-in-the-loop bash script, the last resort. Use `scripts/hitl-loop.template.sh`.

Tighten the loop as a product. Faster? Sharper, asserting the exact symptom rather than "did not crash"? More deterministic, with pinned time, seeded RNG, isolated filesystem, and frozen network? A 30-second flaky loop is barely better than no loop. For non-deterministic bugs the goal is a higher reproduction rate, not a clean repro. Loop many times, parallelise, stress, and narrow the timing window.

If a loop cannot be built, stop. List what you tried and ask for one of reproducing-environment access, a redacted captured artifact such as a HAR, log, core, or recording, or permission for temporary instrumentation. Do not hypothesise without a loop. When no one answers, end with that list as the report.

Completion criterion, red-capable. One named command already run once, that drives the real bug path, asserts the user's exact symptom, is deterministic, under 10 seconds, and agent-runnable. No red-capable command, no Phase 2.

## Phase 2: Reproduce and minimise

Run the loop. Confirm it is the user's failure mode, not a nearby one. Capture the exact symptom. Then minimise by cutting one element at a time to the smallest scenario that still goes red. Done when every remaining element is load-bearing.

## Phase 3: Hypothesise

First run a one-commit-log probe, `git log -1 -- <suspect path>` or `git log -S<symbol>`, and use **why** only when that commit explains the failure. Write three to five ranked, falsifiable hypotheses before testing any. Format: if X is the cause, then changing Y makes the bug disappear, and changing Z makes it worse. No prediction means it is a vibe, discard it. Show the ranked list to the user before testing. It is a cheap checkpoint, so post the list and continue.

## Phase 4: Instrument

Every probe maps to a prediction, and each change touches one variable. Prefer a debugger or REPL, then targeted logs at distinguishing boundaries. Never log everything and grep. Tag every debug log with a unique prefix such as `[DEBUG-a4f2]` so cleanup is one grep. For a performance regression, logs are usually wrong. Establish a baseline with a timing harness, profiler, or query plan, then bisect. Measure first, fix second.

## Phase 5: Fix and regression test

Run the loop per **tdd**, at the correct seam: the one that exercises the real bug pattern as it appears at the call site. Promote the Phase 1 test to the regression test when it sits there. A shallow seam gives false confidence. If no correct seam exists, that itself is the finding, because the architecture prevents lock-down. Then re-run the original un-minimised Phase 1 loop.

## Phase 6: Cleanup

Confirm the original repro no longer reproduces, the regression test passes or the missing seam is documented, every `[DEBUG-...]` tag is removed, and throwaway prototypes are deleted or marked. State the winning hypothesis in the commit or PR message. Run **accept-change** on the fix and regression test before declaring done. For a fix under about 20 changed lines, run **blast-radius** instead.
