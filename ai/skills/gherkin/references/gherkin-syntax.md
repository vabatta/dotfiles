# Gherkin Syntax Reference

> Source: https://cucumber.io/docs/gherkin/reference/ (retrieved May 2026)

This is the complete keyword and structural reference for the Gherkin language.

## Table of Contents

1. [File Structure](#file-structure)
2. [Primary Keywords](#primary-keywords)
3. [Steps Keywords](#steps-keywords)
4. [Secondary Keywords](#secondary-keywords)
5. [Step Arguments](#step-arguments)
6. [Spoken Languages](#spoken-languages)

---

## File Structure

- Gherkin documents are plain-text files with the `.feature` extension.
- Each file contains exactly **one** `Feature`.
- Most lines begin with a Gherkin keyword.
- Indentation uses spaces or tabs; the convention is **2 spaces**.
- Blank lines are ignored and used for readability.
- Comments start with `#` at the beginning of a line (after optional whitespace). Block comments are not supported.

---

## Primary Keywords

### `Feature`

The top-level keyword. It must be the first primary keyword in the file, followed by a `:` and a short title.

Free-form description lines may follow (ignored at runtime, available in reports). The description ends when the next keyword line begins (`Background`, `Rule`, `Scenario`, `Scenario Outline`).

A `Feature` groups related scenarios and provides high-level documentation of a business capability.

Tags may be placed on the line above `Feature` (e.g., `@billing`).

### `Rule` (Gherkin 6+)

An optional grouping keyword that represents **one business rule**. A `Rule` sits inside a `Feature` and contains one or more scenarios that illustrate that rule. Rules may have their own `Background`.

```gherkin
Feature: Highlander

  Rule: There can be only One

    Example: More than one alive
      Given there are 3 ninjas
      When 2 ninjas meet, they will fight
      Then one ninja dies
      And there is one ninja less alive

    Example: Only one alive
      Given there is only 1 ninja alive
      Then they will live forever
```

### `Example` (synonym: `Scenario`)

A concrete example that illustrates a business rule. Consists of a list of steps. `Scenario` and `Example` are interchangeable keywords — they mean the same thing.

Recommended length: **3–5 steps**. More than that indicates the scenario may cover multiple behaviours or contain incidental detail.

Every example follows the pattern:
1. Describe an initial context (`Given`)
2. Describe an event (`When`)
3. Describe an expected outcome (`Then`)

### `Background`

A set of `Given` steps that run **before each scenario** in the enclosing `Feature` or `Rule`. Used to factor out repeated preconditions.

Placement: before the first `Scenario`/`Example` at the same indentation level.

Only **one** `Background` per `Feature` or `Rule`.

`Background` is also supported at the `Rule` level (each rule can have its own background).

### `Scenario Outline` (synonym: `Scenario Template`)

Runs the same scenario multiple times with different data. Steps use `< >`-delimited parameters that reference column headers in the `Examples` table.

```gherkin
Scenario Outline: Eating cucumbers
  Given there are <start> cucumbers
  When I eat <eat> cucumbers
  Then I should have <left> cucumbers

  Examples:
    | start | eat | left |
    |    12 |   5 |    7 |
    |    20 |   5 |   15 |
```

The outline is never run directly — it is instantiated once per data row. Parameters may appear in step text, descriptions, Doc Strings, and Data Tables.

### `Examples` (synonym: `Scenarios`)

The data table section beneath a `Scenario Outline`. The first row is the header; subsequent rows are data. A `Scenario Outline` must have at least one `Examples` section and may have multiple.

---

## Steps Keywords

### `Given`

Establishes the **initial context** — the system's state before the action. Think of it as something that happened in the past. Use `Given` to set up known state (create objects, seed data, configure conditions).

Do **not** describe user interaction in `Given` steps.

### `When`

Describes the **event or action** under test. This is the thing that happens — a user action, a system event, or a trigger from another system.

Best practice: have exactly **one** `When` block (one or more `When`/`And` lines) per scenario.

### `Then`

Describes the **expected outcome**. Assertions about what the system should do or produce. Outcomes must be **observable** — something the user or external system can see (a message, a screen state, a notification), not an internal implementation detail (a database record, a cache entry).

### `And`, `But`

Continuation keywords. Use `And` or `But` in place of repeating `Given`, `When`, or `Then` to improve readability.

```gherkin
# Prefer this:
Given one thing
And another thing
But not a third thing

# Over this:
Given one thing
Given another thing
Given not a third thing
```

### `*` (Asterisk)

May replace any step keyword. Useful for list-like steps where `And` reads awkwardly:

```gherkin
Scenario: All done
  Given I am out shopping
  * I have eggs
  * I have milk
  * I have butter
  When I check my list
  Then I don't need anything
```

---

## Secondary Keywords

### Tags (`@`)

Placed on the line above `Feature`, `Rule`, `Scenario`, `Scenario Outline`, or `Examples`. Used for filtering, hooks, and cross-cutting categorisation.

```gherkin
@smoke @billing
Scenario: Successful payment
  ...
```

Tags are inherited: a tag on `Feature` applies to all scenarios within it; a tag on `Rule` applies to all scenarios in that rule.

### Comments (`#`)

Line comments only. Must start at the beginning of a line (after optional whitespace). No block comments.

```gherkin
# This is a valid comment
Feature: Something
```

### Doc Strings (`"""` or `` ``` ``)

Pass a block of free-form text to a step. Delimited by triple double-quotes or triple backticks on their own lines. Indentation is significant: lines are dedented relative to the opening delimiter.

An optional content-type annotation may follow the opening delimiter:

```gherkin
Given a document with body:
  """markdown
  # Heading
  Some paragraph text.
  """
```

### Data Tables (`|`)

Pipe-delimited tabular data passed to a step. The first row is typically a header.

```gherkin
Given the following users exist:
  | name  | email          | role   |
  | Alice | alice@test.com | admin  |
  | Bob   | bob@test.com   | viewer |
```

Escaping rules for table cells:
- Newline: `\n`
- Pipe: `\|`
- Backslash: `\\`

---

## Spoken Languages

Gherkin supports 70+ spoken languages. Specify with a `# language:` comment on the first line:

```gherkin
# language: fr
Fonctionnalité: Deviner le mot
  ...
```

If omitted, English (`en`) is the default. Use the language your domain experts speak — avoid translating between a spoken language and English.
