---
name: technical-writing
description: "Applies a four-layer technical-writing standard covering Diátaxis structure, Google developer style sentences, STE instruction rules, and Global English syntax. Use when creating or structuring a doc, readme, RFC, PR description, or commit message."
---

# Technical writing

The goal is writing a tired engineer understands on the first read. Four layers get you there, one question each: what kind of document is this, how do sentences address the reader, how much does each sentence carry, and can any sentence be read two ways. Apply all four.

Two rules sit above the layers:

- **When a rule makes a sentence worse, fix the sentence another way or leave it alone.** The rules serve the reader. A sentence that follows every rule and sounds like a machine wrote it has failed.
- **The codebase is the word list.** Write the real symbol, file, flag, or command name, not a synonym or a description of it.

Word choice, filler, invented jargon, active voice, rhythm, and specificity belong to **unslop**. Simplified Technical English belongs to **simple-english**.

## Pick the mode first (Diátaxis)

One document, one mode. Two questions pick it: does the content inform action (doing) or understanding (thinking), and does it serve learning or work?

- Action + learning: **tutorial**.
- Action + work: **how-to**.
- Understanding + work: **reference**.
- Understanding + learning: **explanation**.

Use the compass on a whole document or on one sentence. Reach for it whenever you feel unsure what you are writing. Gut feel is often wrong here.

**Tutorial: learning by doing.** You are the teacher. The learner's success is your job, not theirs. Open by saying what the learner will build, not what they will "learn". Every step produces a visible result, early and often. Tell them what they should see: the expected output, the prompt change, the log line. Cut explanation to one clause and a link. Teaching pauses break the lesson. Stay concrete. Write as "we", in commands: "First, do x. Now, do y."

**How-to: steps to a goal.** Solve a problem a person has, not an operation the machine can perform. Assume competence. Skip teaching. Action only: no digressions, no background, no completeness for its own sake. Link those instead. Allow forks and judgment: "If you want x, do y." Name the guide by the task: "How to calibrate the radar array", not "Radar array calibration".

**Reference: facts for lookup.** Describe. Only describe. No instruction, no persuasion, no opinion. Be dry, complete, and sure: state facts, options, limits, and errors with no hedging. Mirror the structure of the thing described, so code and docs can be navigated together. Put material where readers expect it. Generate from code where possible, so it stays true.

**Explanation: understanding and why.** One bounded topic, readable away from the product. Each title should tolerate an implicit "About..." in front. Anchor on a real why question. Give context: design decisions, history, constraints, alternatives. Opinion is allowed here and nowhere else.

Don't mix modes: no reference tables inside a tutorial, no tutorial hand-holding inside reference, no arguing inside a how-to. Split and link instead. A README is one file, so give each mode its own heading section (a how-to quick start, then a short explanation) and link out to separate files for anything longer.

Source: diataxis.fr, fetched 2026-07-18.

## Write sentences to the reader (Google developer style)

- Talk to the reader as "you", in the present tense. "Will" only for things that genuinely happen later.
- Write instructions as commands: "Click Submit." State facts plainly. Never "should be done".
- Put the condition before the instruction: "To delete the document, click Delete." The reader skips what does not apply.
- Put the common case first. Exceptions after.
- Sound like a knowledgeable friend. No buzzwords, no figurative language, no "please" in instructions, and never "simply", "easy", or "quickly" in a procedure. If it were simple, the reader would not be here.
- Don't pre-announce ("we will soon support...") and don't start consecutive sentences with the same phrase.
- Read the awkward sentence aloud. If it stays awkward, rewrite it.
- Link with words that say where the link goes: the page title or a short description. Never "click here". Prefer a sentence of context on the page over a link off it.
- Headings carry the point, not just the topic ("Pick the mode first", not "Modes"). Sentence case. A task heading is a bare verb phrase ("Create an instance"). A concept heading is a noun phrase. One h1 per page, no skipped levels.
- Numbered lists for sequences, bullets for everything else. Introduce a list with a complete sentence. Keep items parallel.
- Code goes in code font. UI elements go in bold. Use serial commas. Drop "etc." and say up front that a list is partial.

Source: developers.google.com/style, fetched 2026-07-18.

## Make statements load one at a time (STE rules)

Apply these to instructions. **simple-english** adds the full 53-rule pass, word limits, and approved vocabulary beyond them.

- One instruction per sentence, in the imperative, 20 words at most. Descriptive sentences take 25.
- Put the condition before the command: "If the build fails, read the log."
- Use active voice, simple tenses, and no "-ing" verbs, "has been", or "should".
- Write two sentences instead of a semicolon.
- Keep articles and "that". Use no contractions.
- Use one word per concept across the document.

## Leave no sentence open to two readings (Global English)

- Keep words like "only" and "not" next to the word they change: "only fails on growth" and "fails only on growth" say different things.
- Break up long noun strings: "the proto import budget check script" becomes "the script that checks the proto-import budget".
- Make every "it", "they", and "this" point at one obvious thing. Repeat the noun when in doubt. Never use "this" or "which" to point at a whole clause.
- Don't drop verbs: "Phase 1 moves the converters and Phase 2 the runtime" leaves Phase 2 without one. Give it one.
- Keep the small words that show structure. "Ensure that the switch is off" keeps "that" because it makes the sentence parse one way. Never trade clarity for word count.
- Repeat the article in a series when it prevents a misread: "the client and the host", not "the client and host", when they are two things.
- Say which parts "and" or "or" joins when a sentence can group two ways. "Both...and", "either...or", and "if...then" are free disambiguators.
- Punctuation follows **simple-english** for semicolons and **unslop** for em dashes.
- Avoid parenthetical asides, per **unslop**. A parenthesis that stays holds a full grammatical unit. Never form plurals with "(s)".
- No slashes: write "a, b, or both" instead of "a/b" or "and/or".
- Name each thing once, per **simple-english**. A doc that says "the gate", "the ratchet", and "the budget check" for one thing teaches three things. Do not reword an unchanged sentence between edits.
- Skip idioms, colloquialisms, Latin abbreviations, and metaphors. A non-native reader, a translator, and an agent all parse plain constructions best.

Source: Kohl, The Global English Style Guide (SAS Press). Guideline text fetched from the Internet Archive and the SAS sample chapter, 2026-07-18.

## Voice and repo specifics

- Apply **unslop** to every doc this skill touches, as the last pass after the other layers. It owns the slop-pattern catalog and the voice rules. Keep opinion to explanation docs.
- PR descriptions and commit messages are writing too. Every layer except Diátaxis applies to them. For a PR description with a verification write-up, use the PR-body shape owned by **blast-radius**.
- Write real paths and real symbols. Make every count or tree claim true at the commit that lands it, and include the command that regenerates it.

## Worked example

Before:

> Configuration of the proto import ratchet budget script parameters is performed via budget.json. Note that it's important to remember that running with --write, which updates the committed budget to reflect the current count, should only be done when lowering it. If exceeded, CI fails.

After:

> `budget.mjs` reads the committed budget from `budget.json` and counts the files that import protos. If the count exceeds the budget, CI fails. Run `budget.mjs --write` only to lower the budget.

The fixes, by layer: "configuration is performed" becomes "`budget.mjs` reads", so someone does something (**unslop**). "Ratchet" goes away. The script's real filename does the naming (**unslop**). The five-noun string breaks up into plain clauses (Global English). The hedge "note that it's important to remember" is deleted (**unslop**). The failure condition moves ahead of the step it explains (STE). The buried "should only be done when lowering" becomes a command with "only" next to its verb (STE). "If exceeded" gets a subject: the count (Global English).

## Review checklist

Apply to any prose this skill covers. Done when every item passes. Item 1 applies to document sets and READMEs:

1. Is each file, or each README section, one Diátaxis mode, with links where modes meet?
2. Is every instruction written as a command, with its condition in front?
3. Does any sentence carry two instructions or two thoughts? Split it.
4. Does **unslop** find anything to cut or replace?
5. Is "only" next to the word it changes? Does every "it" point at one thing? Does every clause keep its verb?
6. Does each thing have exactly one name across the docs?
7. Does every name match the real symbol, file, flag, or command?
8. Are all symbols, paths, and counts real at this commit, with the commands that regenerate the counts?
