---
name: blast-radius
description: "Finds what a change could break elsewhere beyond the diff and proves the one safety fact by running real code. Use when asked what a change could break, for the blast radius of a change, or for a small diff not yet trusted. Trigger on blast radius or what could this break."
---

# Blast radius

Find what a change breaks somewhere else, before it ships. Use for "blast radius of X", "what could this break", or a small diff not yet trusted.

Use **how** and **why** alongside it.

Listing the callers is not the job. The agent can grep those in a second. The job is the breakage grep won't show.

## Prove the writeup

A blast-radius writeup that sounds right is worthless, since it reads as convincing whether or not it is true. Find the one or two facts the whole thing depends on and prove them by running code. Words are where the work starts, not what ships.

### How sure the claim is

For each fact the change's safety depends on, get it as far down this list as is cheap, and say where it stopped.

1. Asserted. Worthless on its own.
2. Pointed at the line. A real `file:line`, or the library's own source.
3. Shown the bad case cannot happen. The failure walked step by step does not reach.
4. Ran it. A script or test that calls the real code and fails loud if the claim is wrong.
5. Reproduced in the running app.

Say so for any safety fact that stops short of step 4, and write it up as unproven. Step 4 is usually one small script that imports the same library the app ships and calls the exact function in doubt.

## Steps

1. Read the change. The diff, the symbols it adds, changes, and deletes, and what it now does differently, including the part the diff doesn't spell out. Use **why** to pull the PR and commits, or `git log` and `git diff` when there is no PR or no `gh`. Done when you can state in one sentence what now behaves differently.
2. Find the one fact it's safe because of. Most changes that look scary are safe because of a single fact, like "this call only drops already-dead cache entries and does nothing else". Find that fact. If it holds, most of the scary cases die at once. Spend the time here, not on a long list of maybes. Done when the fact is one sentence.
3. Look where grep stops. Read the source of the library in use, and check its pinned version and any local patch. Work out when things run: async scheduling, unmount and teardown, framework lifecycle differences. Follow what a symbol search misses: the JSON an API returns, a DB column, a wire format, another language reading the same bytes, a feature flag, code three hops downstream.
4. Be honest about each risk. Give it a real chance of happening and a real cost if it does. Keep the risks you confirmed; list the ones you checked and cleared separately. Separate fact from inference, as **why** does. Cite a real `file:line`, a search that finds nothing is still an answer, and never make up a caller or an API.
5. Prove the one fact. Write a script or test that runs the real code under `.agent/runs/blast-radius/`, outside the change and its size budget, run it, and paste what happened. Ship it as a test only if the reviewer wants it. If it cannot be proven cheaply, mark it unproven. Don't round up.
6. For a change touching more than 10 files or more than 10 callers, fan the question out via **delegate** and ask for diverse coverage. Different models catch different real bugs. Otherwise skip this step.

## What to hand back

- **What it does.** What changed, including the part that isn't obvious.
- **The one fact it's safe because of.** State it, say which step reached it, and show the proof. If it was not proven, write unproven.
- **Risks.** Only the real ones. Each names how it breaks, the `file:line`, how likely and how bad, and how to check. Paste the proof for the ones that matter.
- **Cleared.** What was checked and why it is fine.
- **Before you merge.** The cheapest test or repro that catches the real bug, including the script you wrote.

Write it through **unslop**, cite real code, and strip anything private before it goes anywhere public. Private means secrets, usernames in paths, and internal hostnames. Public means any PR, issue, or shared channel.

Done when the one safety fact has its ladder level stated and, at level 4 or higher, the script output is pasted.

**Reply:** the writeup above, with the one safety fact either proven or marked unproven.

## PR body

When the change is presented for review, shape the pull-request body with the template in [pr-body.md](references/pr-body.md): Summary, Evidence with the ladder level and script output, and Merge danger with Door and Blast radius.
