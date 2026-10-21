---
name: grill
description: "Interviews the user one question at a time to sharpen a plan, decision, or idea, working a design tree in rounds until every branch is settled. Use when asked to grill me, interview me, or quiz me on my own thinking before building."
---

# Grill

Interview the user relentlessly until you reach a shared understanding. Map this as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask now without guessing at answers you have not heard yet. Ask the whole frontier in one round: number each question and give your recommended answer. Keep a round to about five questions. Then wait for the user's answers before the next round; a question left unanswered stays on the frontier.

Format a round like so:

```
Q1 - <question title>: <question body, may include multiple choices>

Recommended: <your recommended answer>

---

Q2 - <question title>: <question body, may include multiple choices>

Recommended: <your recommended answer>
```

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a later round, not this one.

Finding facts is the agent's job, never the user's. Read a small fact yourself with one command and open the round with the facts found. For a large or slow lookup, fan a sub-agent out via the **delegate** skill; for questions about the codebase itself use **how** or **why**. Do not block on it: a running exploration is an unsettled prerequisite, so only the questions downstream of it wait for the sub-agent. Ask the rest of the frontier now. The decisions are the user's: put each to them and wait.

The session is done when the frontier is empty: every branch of the design tree visited, nothing left silently assumed. Do not act on it until the user confirms you have reached a shared understanding. When the user is unreachable, record each recommended answer as an assumption, label it so, and continue (per **principle-never-block-on-the-human**).

Where a branch turns on product or UX tradeoffs, weigh it with **principle-experience-first**.
