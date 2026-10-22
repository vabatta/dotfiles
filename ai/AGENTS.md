# Global agent principles

These rules apply in every session:
- Before writing code, state the stack: the standard library, dependency, or
  project API you will use, and any the task names. Check them before you write
  new code (load principle-use-before-build).
- Before writing code, state the budget in net added lines: the task's limit,
  else your estimate. Make the smallest change
  that solves the problem, delete code when you can, and hold the change to the
  budget (load principle-laziness-protocol).
- Verify the work against the real artifact. Run it. Read the actual value.
  Inspect the diff and audit it against the budget, the shape, and the stack.
  Then declare done (load principle-prove-it-works).
- On execution work, decide and proceed. The human course-corrects after the
  fact. Go to the human first for product direction, one-way doors, and
  questions that shape the work (load principle-never-block-on-the-human).
