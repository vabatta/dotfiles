---
name: gherkin
description: "Writes production-quality Gherkin `.feature` files. Use when asked to write, review, fix, or generate Gherkin scenarios, Cucumber feature files, BDD specifications, or Given/When/Then acceptance criteria, or to convert requirements or user stories into Gherkin. Trigger on BDD, behaviour-driven, behavior-driven, scenario outline, or executable specification."
---

# Gherkin Feature File Authoring

Write `.feature` files using the Gherkin language (the syntax understood by Cucumber and compatible BDD frameworks). The output must read as **living documentation** — plain-English specifications that any stakeholder (product owner, developer, tester) can understand without technical knowledge.

## Before Writing Anything

1. One or two scenarios in a familiar shape: skip the references and go to the rules below. Otherwise read `references/gherkin-syntax.md` for the keyword reference and structural rules, before writing any keyword. Its samples are upstream Cucumber text in first person, so write third person per section 17.
2. For a whole feature, read `references/best-practices.md` for style rules, anti-patterns, and the BRIEF principles, before drafting scenarios.
3. Apply every rule below. Put the file where the repo keeps its features, else `features/<slug>.feature`.

**Review or fix mode.** For an existing `.feature` file, check it against the Output Checklist and list each violation with the quoted step. Then apply the fixes in place. Done when the file passes every item.

## Core Principles (Non-Negotiable)

### 1. Natural Language Only — Zero Technical Leakage

Feature files are **business documents**, not test scripts. Every word must come from the problem domain.

**Forbidden in steps:**
- UI elements: buttons, fields, links, dropdowns, modals, forms, pages, URLs, CSS selectors
- API/tech terms: endpoint, payload, request, response, status code, JSON, REST, database, query, SQL, HTTP
- Programmatic actions: click, type, enter, submit, navigate, scroll, invoke, call, assert
- Infrastructure: server, cache, queue, microservice, container, deployment, pipeline

**Instead, describe _what happens_ in business terms:**

```gherkin
# WRONG — imperative, UI-coupled
When I click the "Login" button
And I enter "alice" in the "username" field
And I enter "secret" in the "password" field
Then I should see the "Dashboard" page

# RIGHT — declarative, behaviour-focused
When Alice logs in with valid credentials
Then she sees her personal dashboard
```

```gherkin
# WRONG — technical leakage
Given a POST request to "/api/orders" with JSON body
Then the response status code should be 201

# RIGHT — domain language
Given Alice places an order for 2 items
Then the order is confirmed
```

### 2. Declarative Over Imperative

Describe **what** the system does, not **how** a user operates the interface. Imagine it is 1922 and there are no computers — the scenario should still make sense.

Each step should express a single business-meaningful action or assertion, not a sequence of keystrokes or clicks.

### 3. One Scenario = One Behaviour

Each scenario tests exactly **one** business rule or acceptance criterion. It should fail for exactly **one** reason. When a scenario tests multiple outcomes, split into separate scenarios.

### 4. The Given/When/Then Contract

| Keyword | Purpose | Tense | Rule |
|---------|---------|-------|------|
| `Given` | Establish preconditions — the world _before_ the action | Past / present state | No user interaction here |
| `When`  | The single action or event under test | Present — the thing that happens | Exactly one `When` block per scenario |
| `Then`  | Observable outcomes — what the user/system _sees_ | Future expectation | Only **observable** outputs, never database internals |

Use `And` / `But` for continuation. Never repeat the parent keyword (`Given … Given`); use `And` instead.

### 5. Scenario Length

Aim for **3–5 steps** per scenario. When a scenario exceeds 5 steps, the scenario likely tests more than one behaviour or contains incidental detail. Push complexity into `Background` or higher-level step abstractions.

### 6. Feature File Structure

Every `.feature` file follows this skeleton:

```
@optional_tag
Feature: <Short business capability name>
  <1–3 line plain-English description of the business value or rule>

  Background:             # Optional — shared preconditions
    Given <common setup>

  Rule: <Business rule>   # Optional — groups related scenarios under a rule
    <1–3 line plain-English description of the business rule>

    Scenario: <Descriptive name of the specific behaviour>
      Given <precondition>
      When <action>
      Then <outcome>
```

**Description blocks** (the free-form text lines between a keyword's title and the next keyword) are the most underused part of Gherkin. They are ignored at runtime but included in reports and serve as standing documentation. Both `Feature:` and `Rule:` support them. Use the Feature description to state the scope, purpose, and domain boundaries the reader needs before encountering scenarios — keep it to 1–3 lines of plain prose. Use Rule descriptions to clarify the business constraint when the title alone isn't sufficient: edge cases it covers, why the constraint exists, or how it interacts with other rules in the feature.

### 7. Naming Conventions

- **Feature title**: a noun phrase describing the capability (e.g., `Feature: Account Withdrawal`)
- **Scenario title**: describes the specific behaviour being illustrated, not the test (e.g., `Scenario: Overdraft is declined when balance is insufficient`)
- **Rule title**: states the business rule in plain language (e.g., `Rule: Withdrawals cannot exceed the available balance`)
- Avoid generic names like `Scenario: Test login` or `Scenario: Happy path`.

### 8. Scenario Outlines

Use `Scenario Outline` with an `Examples` table when the **same behaviour** applies across multiple data sets. Parameters use `< >` delimiters:

```gherkin
Scenario Outline: Shipping cost depends on order total
  Given a cart with a total of <total>
  When the customer proceeds to checkout
  Then the shipping cost is <shipping>

  Examples:
    | total   | shipping |
    | £25.00  | £5.99    |
    | £50.00  | £2.99    |
    | £100.00 | £0.00    |
```

Do **not** use outlines to test fundamentally different behaviours — write separate scenarios instead.

### 9. Background

Use `Background` only for `Given` steps shared by **every** scenario in the feature (or rule). Keep it short (≤ 4 lines). If the background has scrolled off screen, the reader has lost context.

Use vivid, memorable names in backgrounds (e.g., `Given a customer named "Thrifty Thelma"`) rather than abstract placeholders (`"User A"`).

### 10. Tags

Place tags above `Feature`, `Rule`, or `Scenario` lines. See **section 14** for full guidance on using tags for both execution filtering and cross-cutting documentation indexing.

### 11. Data Tables and Doc Strings

Use a **Data Table** when a step needs structured multi-field input:

```gherkin
Given the following users exist:
  | name  | role    |
  | Alice | admin   |
  | Bob   | viewer  |
```

Use a **Doc String** (triple-quoted block) for free-form text content:

```gherkin
Given a blog post with the body:
  """
  Welcome to our new site.
  We are glad to have you.
  """
```

### 12. Comments

Use `#` comments sparingly — only to explain _why_ a scenario exists if the title and steps are not self-evident. Never use comments to explain _how_ — that belongs in step definitions.

### 13. Self-Contained Features — Bounded Context Thinking

Each feature file must be a **standalone specification** that can be read and fully understood without consulting any other feature file. A reader should never need to chase cross-references to grasp the behaviour.

**Domain concepts that constrain the feature's behaviour belong inside that feature file, expressed as `Rule:` blocks in the feature's own ubiquitous language.** If scoping, permissions, tenancy, or any other cross-cutting domain concept affects how a feature behaves, state those constraints as rules within the feature — do not extract them into a separate shared feature file that other features depend on.

This follows the DDD bounded-context principle: the same domain term may carry different rules in different features, and that divergence is intentional. Each feature owns its own definition of the concepts it uses.

**Where reuse happens:** at the **step definition** level (shared automation code behind declarative steps), never at the Gherkin level. Feature files are documentation; they tolerate restating a concept in each context. Step definitions are code; they should not duplicate logic.

**Use `Rule:` with its own `Background`** to group scenarios under a business constraint. Each `Rule:` can carry its own `Background` to set up the context that only applies to scenarios under that rule, keeping everything self-contained without bloating a top-level `Background`.

### 14. Tags as a Cross-Cutting Index

Tags serve two purposes: **execution filtering** (selecting which scenarios to run) and **documentation indexing** (finding all scenarios related to a cross-cutting concept across the entire suite).

When a domain concept spans multiple feature files, apply a shared tag to each relevant `Feature`, `Rule`, or `Scenario`. This creates a queryable index without coupling the files to each other. Tags are inherited: a tag on a `Feature` applies to all its scenarios; a tag on a `Rule` applies to all scenarios in that rule.

Never use tags to encode test data, implementation details, or as a substitute for writing proper rules and scenarios.

### 15. When to Split a Feature File

A feature file should be readable in one sitting. When it grows beyond what a reader can hold in their head, split it. Signals that a file is doing too much: the `Background` has scrolled off screen, scenarios under different `Rule:` blocks share nothing in common, or the file covers multiple distinct capabilities rather than one. Split along `Rule:` boundaries — each resulting file should still be a self-contained specification of a coherent capability. Use `Rule:`-level `Background` sections to keep each split file's context lean and local.

### 16. Negative Scenarios and Boundaries

Positive scenarios alone do not fully specify a feature. Business rules are often best revealed by what the system **refuses, rejects, or prevents**. Write negative scenarios as first-class specifications — they document the boundaries of acceptable behaviour and are where the most critical business rules often live.

A negative scenario follows the same Given/When/Then structure. The `Then` step describes the observable refusal or error outcome, not the internal reason. Use `But` when a negative assertion follows a positive one within the same scenario.

When the source defines no limit or rejection (a discount above 100 percent, say), do not invent the behaviour. List it as an open question for the requester and leave the scenario out.

When a rule has a threshold or limit, consider boundary scenarios that test the values at, just below, and just above the boundary. These expose off-by-one and comparison-operator ambiguities that prose specifications frequently leave unclear.

### 17. Actors and Perspective

Write steps in **third-person perspective**, naming the actor explicitly. Third-person is generic and can expressively name any user or system component, whereas first-person ("I") forces assumptions about who the speaker is and becomes confusing when multiple roles are involved.

When a feature involves multiple actors (one role configures something, another consumes it), establish each actor in `Given` steps and refer to them by name or role throughout. The `When` step should make clear which actor performs the action. Do not mix first-person and third-person within a scenario. When personas recur across scenarios, define them in `Background` using vivid, memorable names.

## Output Checklist

Before delivering any `.feature` file, verify every item. Done when all pass. Grep the steps for the forbidden words in section 1 and judge the rest yourself, unless a domain term legitimately uses one (a leave request):

- [ ] Every step uses domain language; zero UI/tech/API terms leak through
- [ ] Every scenario has exactly one `When` block
- [ ] Scenarios are 3–5 steps long
- [ ] `Background` contains only universally shared `Given` steps
- [ ] Scenario titles describe the behaviour, not the test mechanism
- [ ] `Scenario Outline` parameters are meaningful domain values
- [ ] `And`/`But` are used instead of repeating `Given`/`When`/`Then`
- [ ] No scenario tests more than one business rule
- [ ] `Then` steps assert only observable outputs (never database/internal state)
- [ ] The file would make sense to a non-technical stakeholder reading it cold
- [ ] The feature is self-contained — no other feature file is needed to understand it
- [ ] Domain concepts that constrain behaviour are stated as `Rule:` blocks, not deferred to other files
- [ ] The feature description states scope and purpose in plain prose
- [ ] Negative and boundary scenarios are included where business rules define limits or rejections
- [ ] Actors are named in third-person; no mixed first/third-person within a scenario
