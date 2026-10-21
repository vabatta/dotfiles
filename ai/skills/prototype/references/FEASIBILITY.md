# Feasibility prototype

Use when the question is "can we even do this?", a proof of concept, a spike, or a viability check on an approach, library, API, or integration. The answer is yes, no, or conditional, plus the constraints discovered.

## Shape

1. State the one question. "Can the vendor API return line items before payment?" "Does this library stream without buffering?"
2. Build the shortest path to a real answer. Unlike a design prototype, a feasibility prototype may pull real dependencies, a real server, a database, or real credentials. Exercise the real thing; do not stub the part whose feasibility is the question.
3. Keep it time-boxed and marked. Leave it in `.agent/prototypes/<slug>/`. No tests, no polish, no generalisation.
4. Surface the failure honestly. A prototype that "works" only because it skips the hard part has answered nothing.

## Capture

Write down the verdict, yes, no, or conditional, and the constraints found: limits, required setup, cost, or the blocker. Keep the prototype and the pointer per the capture rule in SKILL.md.
