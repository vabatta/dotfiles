---
name: simple-english
description: "Writes or rewrites technical text to the rules of ASD-STE100 Simplified Technical English so it is clear and unambiguous for a non-native reader. Use when rewriting existing text for plain, unambiguous English or STE compliance, on runbooks, procedures, error messages, release notes, incident reports, and API guides. Also use on STE, Simplified Technical English, or ASD-STE100, or for docs that translate well. Not for general tone or document structure."
---

# Simple English: Write Like an Aerospace Manual

Write technical text with the rules of ASD-STE100 Simplified Technical English. The rules exist so that a tired reader who is not a native English speaker cannot misread an instruction.

Write for that tired reader. Each sentence must survive one read.

## Procedure

When asked to write or rewrite technical text:

1. **Select the mode** (pragmatic or strict, below).
2. **Classify each passage** as procedural or descriptive. Every other rule depends on this.
3. **Fix the vocabulary before drafting.** In strict mode, use `make sure that` for the check/verify/confirm/ensure concept — the dictionary rejects all four as verbs. In pragmatic mode, pick one and keep it. Pick ONE noun for config/settings (all are valid technical nouns — pick one and keep it). Use no other word for these concepts in the whole document.
4. **Apply the rules** from the catalog below.
5. **Do the self-check** before delivery. This step is not optional.
6. **Keep code, identifiers, commands, and quoted errors exact** (see Untouchables).

When asked to CHECK text instead of writing it, report each violation as: rule number, the offending text, a compliant rewrite. Cite only rule numbers that exist in this file. Do not cite rule numbers from memory: the numbering is unintuitive and models invent it (tested — an agent without this file cited "Rule 3.1: short sentences"; the real Rule 3.1 is about verb forms).

## Two Modes

| Mode | When | Rules applied |
|---|---|---|
| **Pragmatic** (default) | Docs, READMEs, error messages — the user wants clear text | All structural rules. Domain words stay ("idempotent", "webhook"). |
| **Strict** | The user names STE, ASD-STE100, or compliance | Structural rules + the vocabulary guidance in this file. |

## Step 1: Classify the Text

| | Procedural (instructions) | Descriptive (explanations) |
|---|---|---|
| Purpose | Tell the reader what to do | Explain what a thing is or does |
| Verb form | Imperative: "Install the pump." | Simple present/past/future |
| Sentence limit | **20 words** (Rule 5.1) | **25 words** (Rule 6.3) |
| Unit rule | One instruction per sentence (5.2) | One topic per paragraph (6.5), max six sentences per paragraph (6.6) |

Do not mix the two in one passage. A "Getting started" section is procedural. An "Architecture" section is descriptive. A note inside a procedure is descriptive (25-word limit, no imperative).

## THE RULE CATALOG

53 rules in 9 sections, paraphrased from ASD-STE100 Issue 9 with software examples.

### Section 1 — Words (Rules 1.1-1.14)

| Rule | Instruction |
|---|---|
| 1.1 | Use only approved words, technical nouns, or technical verbs. |
| 1.2 | Use an approved word only as its listed part of speech. |
| 1.3 | Use an approved word only with its approved meaning. |
| 1.4 | Use only the approved forms of verbs and adjectives. |
| 1.5 | You can use domain words as technical nouns ("webhook", "commit", "endpoint"). |
| 1.6 | Use an unapproved word only when it is a technical noun or part of one. |
| 1.7 | Do not use technical nouns as verbs. |
| 1.8 | Use the technical nouns of your project or industry. |
| 1.9 | When you pick a technical noun, pick a short and clear one. |
| 1.10 | No regional, slang, or jargon words as technical nouns. |
| 1.11 | One item, one name. Do not call it "config" here and "settings" there. |
| 1.12 | You can use domain verbs as technical verbs ("deploy", "compile", "merge"). |
| 1.13 | Do not use technical verbs as nouns. |
| 1.14 | Use American English spelling. |

In pragmatic mode, rules 1.5, 1.8, and 1.12 do the heavy lifting: domain vocabulary is legal. The ones agents break are 1.7, 1.11, and 1.13.

**Before:** You can webhook the event, then do a deploy.
**After:** Send the event to the webhook. Then deploy the service.

### Section 2 — Multi-word nouns (Rules 2.1-2.2)

| Rule | Instruction |
|---|---|
| 2.1 | Write multi-word nouns of three words or fewer. |
| 2.2 | When a technical noun needs more than three words, write it in full once, then give a short form or hyphenate the units. |

Break long noun chains with prepositions (of, on, in, for):

**Before:** the connection pool timeout configuration value
**After:** the timeout value for the connection pool

### Section 3 — Verbs (Rules 3.1-3.7)

| Rule | Instruction |
|---|---|
| 3.1 | Use only the verb forms that the dictionary gives. |
| 3.2 | Use only: infinitive, imperative, simple present, simple past, simple future, past participle as adjective. |
| 3.3 | Use the past participle only as an adjective ("the cached response"). |
| 3.4 | No auxiliary verbs for complex constructions. No present perfect, no "is to be installed". |
| 3.5 | Use an "-ing" form only as a technical noun or inside one ("logging", "the mounting bracket") — never as a verb. |
| 3.6 | Active voice. In descriptive text, passive is legal only when the agent is unknown. |
| 3.7 | Describe an action with a verb, not a noun ("compress the file", not "perform compression of the file"). |

**Approved modals: can, will, must. Banned: should, would, may, might, could.**
The standard rejects "could" even for possibility: write "an explosion can occur", never "could occur". For "should": a requirement becomes "must"; a suggestion is stated as fact or deleted. This matters double for agent instructions — models read "should" as optional.

**Before:** The migration has completed and the table is being rebuilt.
**After:** The migration is complete. The database rebuilds the table.

**Before:** The flag can be set in the config file, making restarts unnecessary.
**After:** You can set the flag in the config file. Then a restart is not necessary.

**Before:** The temperature must be adjusted.
**After:** Adjust the temperature.

### Section 4 — Sentences (Rules 4.1-4.5)

| Rule | Instruction |
|---|---|
| 4.1 | Write short and clear sentences. |
| 4.2 | Do not omit words or use contractions to shorten sentences. Keep articles, keep "that". |
| 4.3 | Use a vertical list for complex text. |
| 4.4 | Use connecting words between sentences on related topics ("Then", "As a result"). |
| 4.5 | Put an article (the, a, an) or a demonstrative adjective (this, these) before nouns where applicable. |

Rule 4.2 is the anti-terseness rule. STE is short sentences with complete grammar, not telegraph style:

**Wrong shortening:** Ensure file exists before running.
**STE:** Make sure that the file exists before you run the command.

### Section 5 — Procedural writing (Rules 5.1-5.5)

| Rule | Instruction |
|---|---|
| 5.1 | Maximum 20 words per sentence. Warnings and cautions included. |
| 5.2 | One instruction per sentence, unless two actions happen at the same time. |
| 5.3 | Write instructions in the imperative: "Run the migration." |
| 5.4 | Put a required condition before the command, divided by a comma: "If the build fails, read the log." |
| 5.5 | Notes give information, never instructions. Notes get the 25-word limit. |

**Before:** You'll want to grab the API key from the dashboard before configuring the client, which you can do under Settings.
**After:** Get the API key from the dashboard, under Settings. Then configure the client with this key.

### Section 6 — Descriptive writing (Rules 6.1-6.6)

| Rule | Instruction |
|---|---|
| 6.1 | Give information gradually: one new fact per sentence. |
| 6.2 | Use key words and phrases to give the text a logical structure. |
| 6.3 | Maximum 25 words per sentence. |
| 6.4 | Group related information in paragraphs. |
| 6.5 | One topic per paragraph. |
| 6.6 | Maximum six sentences per paragraph. |

No imperative in descriptive text. Descriptions explain; procedures instruct.

### Section 7 — Safety instructions (Rules 7.1-7.3)

| Rule | Instruction |
|---|---|
| 7.1 | Use a word that shows the risk level ("WARNING" = injury, "CAUTION" = damage). |
| 7.2 | Start with a clear command or condition. |
| 7.3 | Then give the risk or the possible result. |

Never bury the instruction after the explanation. The pattern transfers directly to destructive CLI flags, irreversible migrations, and dangerous API options.

**Before:** Note that data loss may occur in some circumstances if the destructive flag happens to be enabled when running against production.
**After:** CAUTION: Do not use the `--force` flag against production. The flag deletes rows that do not match the source.

### Section 8 — Punctuation and word count (Rules 8.1-8.7)

| Rule | Instruction |
|---|---|
| 8.1 | All standard punctuation is legal except the semicolon. Write two sentences instead. |
| 8.2 | Use hyphens to connect words that act as one unit. |
| 8.3 | Parentheses are legal for references, item numbers, abbreviations, plural forms, explanations, alternatives. |
| 8.4 | In a vertical list, the lead-in colon ends a sentence for word count. |
| 8.5 | Text inside parentheses counts as one word. |
| 8.6 | Count as one word each: numbers, numbers with units, abbreviations, alphanumeric identifiers, quoted text, titles, labels, proper nouns. |
| 8.7 | A hyphenated word counts as one word. |

Rule 8.6 matters for software text: `dbsync run --config dbsync.yaml` in backticks is quoted text and counts as one word. Long identifiers do not blow the sentence budget.

### Section 9 — Writing practices (Rules 9.1-9.4, GR-1 to GR-8)

| Rule | Instruction |
|---|---|
| 9.1 | When a word-for-word replacement does not work, restructure the sentence. |
| 9.2 | Use each approved word correctly: approved meaning, approved part of speech. |
| 9.3 | Do not build phrasal verbs ("go down" → "decrease", "set up" → "install" or "configure"). |
| 9.4 | Keep one consistent style and terminology through the whole document. |

General recommendations GR-1 to GR-8: keep the conjunction "that", be careful with "with", give pronouns clear referents, prefer "this + noun" over bare "this", avoid false friends, avoid Latin abbreviations, use inclusive language, and use the possessive apostrophe form only when you are sure it is correct (GR-8: if unsure, do not use it — non-native readers find it hard).

GR-6 for software docs: "e.g." → "for example", "i.e." → "that is", and delete "etc." — name the items or write "and more".

## VOCABULARY DISCIPLINE

Apply the core vocabulary discipline: **one word, one meaning, one part of speech.**

Known part-of-speech rulings, useful as patterns:

| Word | Ruling |
|---|---|
| test, check, work | Noun only. "Do a test", not "test the pump". "Check that X" becomes "make sure that X". |
| oil | Technical noun (TN) only. For the verb, the dictionary gives "lubricate": "Lubricate the linkage with oil." |
| help | Verb only. For the noun, the dictionary gives "aid": "with the aid of". |
| fall (noun) | Rejected. Use "decrease" for a reduction in value. Use FALL (verb) only for physical movement downward by gravity: "Make sure that the tools do not fall into the engine." |
| follow | "To come after" only, never "obey". Write "obey the instructions". |
| above, below | Physical positions only. For limits write "more than", "less than". |

### The modal ladder

| Source | STE writes |
|---|---|
| should (requirement) | must |
| should (recommendation) | Delete it, or state it as fact: "X is better because Y." |
| may / might / could (possibility) | can |
| may (permission) | can |
| would (hypothetical) | Restructure: "If X occurs, Y occurs." |

The AI-vocabulary and filler substitutions ("leverage" to "use", "in order to" to "to") belong to **unslop**. Load **unslop** for them and apply them in both modes.

### Consistency pass

Collapse synonym rotations to one term each (Rules 1.11, 9.4). The two lists below work differently.

**Technical nouns — not in the dictionary. Pick one and keep it consistent (both modes):**

- config / configuration / settings / options → pick one

**Dictionary rulings — the standard has already chosen. Use the approved word (strict mode); pick one and keep it consistent (pragmatic mode):**

| Source | Dictionary status | Use instead |
|---|---|---|
| check (verb) / verify / confirm / ensure | All rejected as verbs | `make sure that` (strict); pick one (pragmatic) |
| validate | Not in dictionary | Use as technical verb (Rule 1.12), or replace with `make sure that` |
| delete / drop (verb) / destroy | All rejected | `erase` (data), `remove` (physical); avoid `drop` and `destroy` |
| remove | Approved verb | Keep it |
| run / execute | Both rejected | `operate` for run, `do` for execute (strict); pick one (pragmatic) |
| invoke / launch | Not in dictionary | Use as technical verbs (Rule 1.12) |
| display (verb) / render / present (verb) | All rejected | `show` (approved verb) |
| issue | Not in dictionary | Use as technical noun, or replace with `problem` (approved) |
| failure | Rejected in general use; approved as TN for performance loss | Use only when it means a performance error: "a failure of the pump" |
| error | Approved noun | Keep it |
| problem | Approved noun | Keep it |

## Untouchables

These are technical names (Rules 1.5, 8.6). Leave them exact, even when they break vocabulary rules:

- Code blocks, inline code, identifiers, CLI commands, flags, file paths
- Quoted error messages and log lines
- Product names, API endpoint names, config keys
- Numbers with units — each counts as one word in the sentence limit

Facts are untouchable too. Rewrite the style, not the content. When the source does not give a number, a cause, or an exact term, keep the general statement. Do not invent specifics to look concrete.

## Beyond Documentation

Same rules, different targets. Full adaptations in `references/use-cases.md`:

- **Error messages**: state what happened (simple past), the cause if known, then the fix as an imperative. No "Oops", no "Please ensure", no apology filler.
- **Runbooks**: STE's home turf. Imperative steps, conditions first, warnings before the step.
- **Incident reports**: simple past only. "We have identified an issue that may have impacted" becomes "Between 14:02 and 14:31 UTC, 12% of requests failed."
- **Release notes**: breaking changes follow the warning pattern — command first, risk second.
- **Agent instructions (prompts, AGENTS.md)**: a system prompt is a procedure for a reader that cannot ask questions. One instruction per sentence, no "should", condition first. Document structure belongs to **writing-for-agents**.
- **Translation prep**: STE's original job. One meaning per word plus complete grammar removes most translation ambiguity.

## Self-Check Before Delivery

This step is not optional. Run these four checks on the draft:

1. Count words in the three longest sentences. Over the 20/25 limit → split them.
2. Search the draft for: `'ll`, `'re`, `'s` as a contraction (it's, that's; leave possessives to GR-8), `has been`, `have been`, `should`, `-ing` verbs after a comma, semicolons.
3. In procedural text, search for every `if` and `when`. Each one stands at the START of its sentence, before the command. Descriptive sentences may keep `when` after the verb. "Increase the timeout if the network is slow" → "If the network is slow, increase the timeout."
4. Search for the verbs not picked in Procedure step 3 (the check/verify/confirm set). Replace every hit with the chosen verb.

Fix each hit, then deliver. Done when the four checks return no hits. In strict mode, also run `references/checklist.md`.

## Full Example

**Before (real unedited AI output):**

> **Connection timeouts.** If dbsync hangs or fails with `dial tcp: i/o timeout`, check that the host running dbsync can reach the Postgres port (usually 5432) — this is often a security group or firewall rule blocking the connection. If you're connecting to a managed database (RDS, Cloud SQL, etc.), confirm the instance allows connections from dbsync's IP. You can also try increasing `source.connect_timeout_seconds` in your config, since a slow network path can trip the default timeout even when the connection eventually succeeds.

**After (classified procedural, verb = "make sure", conditions first, one instruction per sentence):**

> **Connection timeouts.** dbsync cannot reach the Postgres port (5432 by default). Then it stops with `dial tcp: i/o timeout`.
>
> 1. Make sure that the host that runs dbsync can reach the Postgres port. A firewall or security group usually blocks it.
> 2. If the database is managed (RDS, Cloud SQL), make sure that the instance accepts connections from the IP of dbsync.
> 3. If the network is slow, increase `source.connect_timeout_seconds` in the configuration.

What changed: 40-word sentences split under 20; "you're" expanded; "check/confirm" collapsed to "make sure that"; every condition moved before its command; "etc." removed; code and error strings untouched.

## References

- `references/checklist.md` — full verification pass with searchable patterns, for check mode and final audits
- `references/use-cases.md` — long-form adaptations: error messages, runbooks, incident reports, commits, UI copy, i18n

For the general AI-tell pass, see **unslop**.
