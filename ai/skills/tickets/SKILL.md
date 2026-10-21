---
name: tickets
description: "Manages GitHub Projects tickets and board state, including creating issues from a plan, statuses, dependencies, sub-issues, milestones, issue templates, and closing with evidence. Use when creating, moving, or closing tickets or working the board, backlog, or milestones. Trigger on file these as issues, move this ticket, update the board, what is blocked, milestone, or close this issue. Not for writing the requirements themselves."
---

# Ticket Management — GitHub Projects

## The `.ghproject` config file

Every repo (or package directory) keeps a `.ghproject` file that caches project
and field IDs so you don't re-fetch them on every operation. Find the nearest
one by walking up from the relevant package dir; fall back to repo root. If
several projects fit, take the one whose `repo` matches `git remote` and say
which you took.

The file is for agents, not INI parsers (bare keys and inline comments). Read a
value with awk, for example the `Backlog` option ID:

```bash
awk -F' *= *' '/^\[field:Status\]/{f=1;next} /^\[/{f=0} f&&$1=="Backlog"{sub(/ *#.*/,"",$2);print $2}' .ghproject
```

### Format

```ini
[project]
repo = owner/repo
number = 3
owner = org-or-user
id = PVT_...

[labels]
core
domain-1
blocked
...

[field:Status]
id = PVTSSF_...
Ideas = abc123       # Raw sketch, needs brainstorming
Backlog = def456     # Scoped and ready for work
In progress = ghi789
Done = jkl012
```

Only `SingleSelectField` types get `[field:...]` sections. Comments after `#`
describe what each status means for this project — read them to understand
the workflow before moving tickets. Each project defines its own statuses and
meanings; don't assume a universal set.

### Bootstrapping

If `.ghproject` is missing, build it:

1. `gh project list --owner OWNER --format json` → pick the project
2. `gh project view NUMBER --owner OWNER --format json` → get the project ID
3. `gh project field-list NUMBER --owner OWNER --format json` → get field/option IDs
4. `gh label list` → get available labels

Write the file with inline comments describing each status. If the user hasn't
described them, infer each meaning from its name and mark it `# inferred`.
Creating fields or statuses on a shared board is a one-way door, so ask first.

If any field or option lookup fails at runtime, silently re-fetch and update
the file. Done when `.ghproject` parses with the awk line above.

When `gh` is missing, unauthenticated, or offline, or no project or remote exists,
write each ticket to `.agent/tickets/<slug>.md` with front matter `title`, `labels`,
`milestone`, `parent`, `status`, `blocked-by` (slugs), then the body, and say that they
await filing. In file mode the slug stands in for the issue number, and moving or
closing a ticket sets `status:` and appends a `Closing comment` with the commit and the
check command and result.

## Issue relationships

Use GitHub's built-in relationship features to track how issues relate to each
other. Never write "Depends on: #X" in issue bodies or Technical notes — use
the API instead, so relationships are queryable and visible in the project
board.

### Dependencies (blocked by / blocking)

Use when one issue cannot proceed until another is resolved. Create
dependencies in the "blocked by" direction (this issue waits on another).
The reverse "blocking" direction is derived automatically and is read-only.
Up to 50 issues per relationship type.

Before advancing a ticket to a new status, query its dependencies. If any
blocker is still open, warn the user — this prevents wasted work.

See `references/github-api.md` → "Dependencies" for the exact endpoints and
`gh` commands.

### Sub-issues (parent / child)

Use when a large feature needs to be broken into smaller tasks. Sub-issues
form a hierarchy (up to 8 levels deep, 100 children per parent). Sub-issues
automatically inherit the parent's Project and Milestone.

Projects can enable "Parent issue" and "Sub-issue progress" fields to
visualize hierarchy and track completion directly on the board.

See `references/github-api.md` → "Sub-issues" for the exact endpoints.

## Moving tickets between statuses

When changing a ticket's status:

1. Read the `.ghproject` comments to understand what the target status means.
2. Query the ticket's dependencies via the blocked_by endpoint. If any
   blocker is still open, warn the user.
3. After the move, re-read the item's Status to confirm it took effect, then
   suggest what logically comes next based on the status comments. Keep it
   short: one sentence naming the action or skill to run.

## Issue templates

Two templates live in `.github/ISSUE_TEMPLATE/` — read `references/templates.md`
for the full field structure. The raw YAML files are in
`assets/ISSUE_TEMPLATE/` and can be copied directly into a repo.

- **Idea**: lightweight sketch (What / Why / Open questions). Use when an idea
  hasn't been brainstormed or scoped yet.
- **Feature**: issue body (Context / Approach / Edge cases / Technical
  notes). Use for scoped work ready to enter the pipeline.

The full requirements artifact is owned by **to-spec**. An issue template only records what the tracker needs, so do not re-author the spec here. Fit a spec into the Feature template: summary under Context, the chosen design under Approach, open edge cases under Edge cases, and a link to the spec file in Technical notes.

If `.github/ISSUE_TEMPLATE/` is missing, copy `assets/ISSUE_TEMPLATE/*` into it and add a `config.yml` with `blank_issues_enabled: false`.

When an idea gets brainstormed into a real feature, rewrite its body from idea
format to feature format — the structured fields make downstream work smoother.

Blank issues are disabled, so always use one of these templates.

## Conventions

**Milestones for epics** — use milestones to group related issues into
epics or phases. Never use labels for this; labels serve a different purpose.

**Labels are semantic and flat** — no `prefix:value` patterns like
`area:frontend`. Use categories like Area, Feature, and Workflow. Don't
duplicate information already captured by board fields (e.g., don't create a
"status:done" label when the board has a Done column).

**Titles describe capabilities, not implementations** — write titles as natural
language descriptions of what the user gets. "Pause and resume individual
activities" is clear to anyone; "Implement wf.pause_activity()" belongs in
Technical notes.

**Create missing labels** with `gh label create` and carry on. **Ask the user
only** before creating fields or statuses on a shared board, or when the target
issue is ambiguous.

## API reference

For every GitHub API operation this skill needs — issues, projects,
dependencies, sub-issues, issue types, labels, and milestones — read
`references/github-api.md`. It covers `gh` CLI commands and REST endpoints
with step-by-step examples and gotchas.

## Creating issues from a plan

1. Create one parent issue for the plan, then one issue per unit, each added
   as a sub-issue of the parent and to the project, in the Backlog status.
2. Write each unit's body into the Feature template (Context, Approach).
3. Add `blocked by` edges for the unit ordering, and put the whole plan in one
   milestone.
4. Done when every unit has an issue number (a slug in file mode), its edges, and a
   status, and they are reported back. Without `gh`, use the `.agent/tickets/` fallback.

## Slicing

Decomposition and the slice ordering are owned by **plan-work**. Record its units as above. Each issue declares its blocking edges, and work starts on the frontier, where every blocker is done. For a wide refactor's expand-contract order, follow the sequence **plan-work** produces. For a legacy retirement the units are ordered issues that land in one change, so one PR closes them all, per **principle-migrate-callers-then-delete-legacy-apis**.

## Closing

1. Move the item to Done on the board.
2. `gh issue close NUMBER --reason completed`, with a comment linking the
   commit or PR and quoting the test evidence (command and result).
3. Done when `gh issue view NUMBER --json state` reads `CLOSED` and the comment
   is present.
