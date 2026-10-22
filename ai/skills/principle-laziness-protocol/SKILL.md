---
name: principle-laziness-protocol
description: "Apply before writing code that adds lines, when tempted to add a layer, abstraction, or config knob, when a smaller change would solve the problem, and when a task states a size cap. Set a line budget, prefer deleting code, and audit the diff against it."
---

# Laziness Protocol

Get the most result with the least code and complexity.

**Why:** Writing code is cheap for an agent, which makes over-engineering easy. Counter it by borrowing a human maintainer's fatigue. "Smallest" only constrains when it has a number.

## Budget

Before writing, put a number in the plan or first message: net added lines (added minus deleted, in source files, excluding tests, generated files, and lockfiles).

- A limit the user or task states is the budget, and it is binding. Otherwise estimate the lines the change needs.
- A budget belongs to one task. Do not save it to the repo. Pass it into the done predicate of a plan and into every worker brief.
- On a breach, cut the change or report it with the numbers. Do not reword the limit to fit. When the work passes its own estimate by half, stop and reconsider the design.

## Pattern

- **Minimize the diff.** Make the smallest change that solves the problem. Fewer lines beat elegant boilerplate.
- **Delete first.** Look for removals before additions, per **principle-subtract-before-you-add**.
- **Consolidate decisions.** Put each choice behind one source of truth and pass the result as a simple flag.
- **Question the threading.** When a task passes a new signal through types, schemas, or pipelines, look for a more direct path first.
- **Stay flat.** Wrappers, layers, and state are owned by **principle-minimize-reader-load**.

## Audit

Record the starting commit with `git rev-parse HEAD` before the first edit. Before declaring done, run [diff-budget.sh](scripts/diff-budget.sh) from this skill's base directory, which the host reports when it loads the skill.

```sh
bash <skill base>/scripts/diff-budget.sh --budget <n> --base <starting commit>
```

It counts source files only. Tests, docs, prose, `.agent/`, generated files, and lockfiles are not counted. It prints net added lines, new source files, and changed manifests, and exits 1 over budget. Then list each new file, layer, and config knob with the requirement it traces to, and remove any with none.

**Test:** The script exits 0, every added line, layer, and config knob traces to a requirement, and no smaller diff passes the same check.
