# Writing skills in this folder

Rules for authoring and editing the `SKILL.md` files here. Follow these;
`check-skills` fails the build otherwise.

## Frontmatter

Required fields are `name` and `description`. Add no other key. Hosts also read
`license`, `compatibility`, and `metadata`, and ignore the rest.

- `name` is 1 to 64 characters, lowercase letters, digits, and single hyphens, matching
  the directory name. No leading or trailing hyphen and no double hyphen.
- `description` is 1 to 1024 characters, a single unbroken line of prose.

## Descriptions

The description is the only always-loaded content. It is how the agent chooses a skill
from dozens, so it carries the whole routing decision. Write it as one line with two
parts.

1. What the skill does, in the third person. Start with a verb. "Runs an acceptance pass
   on a diff." Never first or second person, so no "I can help you" and no "You can use
   this to".
2. When to use it, with the concrete triggers a user would say. "Use when asked to
   review, check, or accept a change."

Then the local rules:

- No colon and no semicolon anywhere in the description. The checker rejects both, since
  the line is injected into a tool description where they confuse parsing.
- No ` #`, which YAML reads as a comment.
- Never name another skill in the description. Each description stands alone. If two
  triggers collide, sharpen this skill's own trigger or fix the boundary between the
  skills, do not route in prose.
- Front-load the leading term that triggers it. One trigger per branch, and do not repeat
  identity the body already carries.
- Stay under the 1024 limit, but do not pad. A vague description is worse than a short
  precise one.

## Body

- Keep `SKILL.md` under 500 lines. Push detail into `references/` and point at it.
- Keep references one level deep from `SKILL.md`; never reference a file that only
  another reference reaches.
- Name files by content, use forward slashes, and give each reference a one-line pointer
  from `SKILL.md` saying what it is and when to read it.
- Use third-person instructions in the imperative for the agent. Every step ends on a
  completion criterion, so done and not-done are checkable.
- Route to other skills by their full name in bold, for example **delegate**. Do not
  restate another skill's contract; point at it.
- A skill that fans out to workers or reviewers points at **delegate** for the
  sequential fallback and does not restate it. A step that would ask the human names a
  default to use when no one answers (see **principle-never-block-on-the-human**).
- Prefer one strong leading word over a restatement, and prompt the positive rather than
  listing prohibitions.

## Artifact layout

Skills that write files pick a home by audience, not by skill. Three homes exist.

- Durable knowledge a reviewer needs after the run, committed under `docs/`:
  `docs/glossary.md`, `docs/glossary-map.md` and `docs/glossary/<context>.md` when a
  repo has multiple contexts, `docs/adr/NNNN-<slug>.md`, `docs/specs/<slug>.md`,
  `docs/decisions/<slug>.tsv` when a trail is promoted.
- The agents' own knowledge base and working state, under `.agent/`. Whether a repo
  commits it is the repo's choice, so no skill depends on either:
  `.agent/decisions/<slug>.tsv`, `.agent/runs/<skill>/`, `.agent/handoffs/<slug>.md`,
  `.agent/questionnaires/<slug>.md`, `.agent/tickets/<slug>.md` (the fallback without `gh`), `.agent/teaching/`, `.agent/prototypes/<slug>/`,
  `.agent/wizards/<slug>.sh`.
- Work tracking lives in the issue tracker.

Promotion is one move. An artifact under `.agent/` that earns durability moves to
`docs/`, for example `.agent/decisions/<slug>.tsv` to `docs/decisions/<slug>.tsv`.
Do not invent a fourth location.

A skill's own `references/`, `scripts/`, and `assets/` ship with the skill. They are
not project artifacts and never go under `docs/` or `.agent/`.

A skill names only the artifacts it owns. To point at another skill's files, name
that skill; never repeat its paths. The owner skill is the single source for its
own layout.
