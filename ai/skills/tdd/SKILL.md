---
name: tdd
description: "Drives a test-first loop that makes intended behaviour executable before production code changes. Use when asked for TDD, a failing test, or a regression test, or when a behaviour change has a cheap test target and deserves to be locked down first. Trigger on TDD, test-first, write a failing test, or add a regression test."
---

# Test-driven development

Make intended behaviour executable before changing production code, so the test is seen failing and then passing. The goal is a focused test that fails before the change and passes after it, at the cheapest seam that still exercises real behaviour.

TDD is a tool, not a rule. When the user wants code without tests, a spike, or a throwaway, write the code and say tests were skipped. Reach for this skill for bug fixes, regressions, and behaviour changes you want to lock down, especially when a cheap local test path exists.

Core principle: a test never seen failing proves nothing about the behaviour. See **principle-prove-it-works**.

## Workflow

1. **Understand the behaviour.** State the intended behaviour as a sentence a user would recognise, the current behaviour, the affected path, and the smallest observable reproduction. Reproduce the reported case first. If it does not fail, find the real failing input before writing the test.
2. **Choose the narrowest executable check.** Inspect the closest existing test harness for that codepath before building anything (**principle-use-before-build**). Pick the test type by the seam, not by habit. State the seam in one line: the public entry point the test calls, or the spec's seam when one exists. With no harness, use the language's standard-library runner in a new `tests/` file and say so. If no practical path is obvious, say why and stop rather than inventing a brittle one.
3. **Write the failing test first.** Encode intended behaviour, not the current implementation. Name it after the behaviour.
4. **Run the new test before changing production code.** Confirm it fails for the intended reason. If it passes, you are pinning existing behaviour, so switch to that section. If it fails for an unrelated reason, fix the test or reproduction first.
5. **Make the smallest production change that passes.** Preserve nearby contracts. Do not refactor beyond the behaviour under test (**principle-laziness-protocol**).
6. **Rerun the new test, then the suite.** Confirm the new test passes, then run the project's test command — the whole suite, not just your file. Name any failure you see, even one you did not cause. Done when the new test was seen red then green and the whole suite is green.
7. **Report the evidence.** The failing-before run and its failure, the passing-after run, and any nearby validation.

Work one behaviour at a time and do not advance past a red suite — each cycle ends at a checkable green state (**principle-sequence-verifiable-units**).

When the test target for a hard bug is unclear, use **diagnosing-bugs** to build a red-capable loop first.

## Choosing the test type

Pick the narrowest layer that still exercises real behaviour. Decide from the seam, not from a default:

- **Pure logic** in a function, module, or reducer → unit test. Fast, no boundaries.
- **Behaviour crossing a boundary** such as HTTP, a database, a queue, the filesystem, or a UI component → integration or component test at that boundary.
- **Only observable through the whole system** → end-to-end, used sparingly since it is slow and brittle.

Mock at system boundaries only, never the project's own classes. See [mocking.md](references/mocking.md). When the interface shape is itself in question, consult **architect** before writing the test.

## Behaviour, not implementation (BDD)

A test is a behavioural specification. Name it for the behaviour — "user can check out with a valid cart" — not the method, so it survives a refactor that changes no behaviour. A test that breaks when internals change was testing implementation.

Structure the test as **Given** the setup, **When** the action, **Then** the observable outcome. That is BDD at the test level and it reads as documentation. For executable BDD specifications in Gherkin or Cucumber, use the **gherkin** skill; this workflow still runs underneath, one scenario as one failing test first.

## If a failing test is impractical

Do not silently skip the regression step. Before fixing, explain why a failing test is impossible or not worth the cost, then choose the closest executable regression check: a targeted script, a manual reproduction command, browser automation, a snapshot comparison, a log assertion, or a focused integration check.

Prefer no new test over a bad test. A bad test mostly tests mocks, encodes current implementation details, depends on timing or global state, needs expensive infrastructure for a small fix, or would be deleted immediately after proving the fix.

## Guardrails

- Change or weaken an existing assertion only when the expected behaviour genuinely changed, and say why.
- Keep the test focused on one behaviour. Avoid fixture churn and unrelated coverage.
- If the bug is flaky, make the test deterministic and document the signal being locked down.
- A regression test is the encoded guard for the bug, so it belongs in the repo, not in a scratch file (**principle-encode-lessons-in-structure**). Fix the cause the test pins, not the symptom it exposed; a test that passes only because the symptom is hidden is a bug in the test (**principle-fix-root-causes**).

## Pin existing behaviour

Use this mode to add tests to code that already works. The tests pass at once, so red comes from a mutation instead.

1. Write the test with distinct data values, so a swapped argument or field changes the result.
2. For each test, apply one mutation that breaks the behaviour, run the test and see it red, then restore the code. Done when every test has been seen red once and the diff holds no mutation.
3. When the code has a known bug, either pin the current result in a test labelled as a known bug, or report it as a finding and leave it unpinned.

## Anti-patterns

- **Implementation-coupled** and **tautological** tests: see [tests.md](references/tests.md) for the tells.
- **Horizontal slicing**: all tests first, then implementation, so the tests verify imagined behaviour. Work vertical slices instead, one test, one implementation, repeat.
