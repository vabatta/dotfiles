# Logic prototype

Use when the question is "does this logic or state model feel right?". The artifact is a single self-contained HTML file a non-developer can open. When no human audience exists, a one-command script that prints the state after each scenario replaces the page.

## Shape

1. State the question in a visible intro.
2. Isolate the logic in a portable pure module, a reducer, state machine, pure function set, or stateful class. Pick by the question, keep it DOM-free and easy to lift into real code later.
3. Build the page: the title and question, a readable panel of the current state, free-play buttons, and tabbed guided walkthroughs over the awkward cases.

## Rules

- No tests, no real database, no generalisation.
- Do not blur logic and page.
- No framework, bundler, or server.
- Run the pure module once before handing it over. Hand the file to a non-developer and capture the answer. When no human is reachable, record the verdict as pending human with the scenario output attached.

## Capture

Write the verdict and keep the prototype per the capture rule in SKILL.md. The decision, not the code, carries into the real language.
