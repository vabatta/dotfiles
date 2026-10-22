---
name: prototype
description: "Builds a throwaway prototype to answer one question, logic, UI, or feasibility, and captures the answer. Use to sanity-check whether a state model feels right, to explore what a UI should look like, or to prove a proof of concept or spike works, not for scoring finished candidates. Trigger on prototype, mock it up, proof of concept, POC, or spike."
---

# Prototype

A prototype is throwaway code that answers a question. The question decides the shape.

## Pick a branch

- Does this logic or state model feel right? Build a **logic prototype**. See [LOGIC.md](references/LOGIC.md).
- What should this look like? Build a **UI prototype**. See [UI.md](references/UI.md).
- Can we even do this? Does this approach, library, API, or integration work at all? Build a **feasibility prototype**. See [FEASIBILITY.md](references/FEASIBILITY.md).

The wrong branch wastes the whole prototype. If the branch is ambiguous and the user is unreachable, choose from the surrounding code: a backend means logic, a page or component means UI, a viability question means feasibility. State the assumption at the top.

## Rules for all branches

1. Throwaway from day one and clearly marked. A logic or feasibility prototype lives in `.agent/prototypes/<slug>/`; a UI prototype has to run in its real context, so scaffold it in the app following existing routing.
2. Trivial to run, one task-runner command or a double-click HTML file.
3. No persistence by default. If persistence is the question, use a scratch file named to be wiped.
4. Skip polish, tests, and abstractions. A feasibility prototype may pull real dependencies, but it still skips tests and refactoring.
5. Surface the full relevant state after every action or variant switch.
6. Capture when done. Done when all of these hold:
   - The verdict (yes, no, conditional, or pending human) and the constraints found are written in `.agent/prototypes/<slug>/VERDICT.md`.
   - The prototype is kept on a throwaway branch off main.
   - A context pointer is on the issue, only if one exists.
   - Nothing is folded into real code. The prototype is evidence, not the implementation.

This is evidence you feel or measure, not scored candidates. For two to three architectural candidates compared against a rubric, use **arena**. For the principle behind exploring the design space, see **principle-exhaust-the-design-space**. It is not a test, so do not substitute it for **tdd**.
