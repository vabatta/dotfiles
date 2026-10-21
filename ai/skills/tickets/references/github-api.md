# GitHub API Reference

Two calling conventions: `gh` CLI commands (preferred) and `gh api` REST
calls (for operations the CLI doesn't wrap). GraphQL is needed only to update
single-select field options (section 4).

All `gh api` calls need the version header:
`-H "X-GitHub-Api-Version: 2026-03-10"`

## Table of contents

1. Issues
2. Dependencies
3. Sub-issues
4. Projects
5. Issue types
6. Labels
7. Milestones

---

## 1. Issues

All via `gh` CLI. The CLI uses issue **numbers** (not database IDs).

### Create

```bash
gh issue create --repo OWNER/REPO \
  --title "Title here" \
  --body "Body here" \
  --label "frontend" \
  --milestone "v1.0" \
  --assignee "username"
```

To create from a template: `--template "Feature"` (matches the template
name in `.github/ISSUE_TEMPLATE/`).

### Read

```bash
gh issue view NUMBER --repo OWNER/REPO --json id,title,body,state,labels,milestone,assignees
```

**`--json` fields:** `assignees`, `author`, `body`, `closed`, `closedAt`,
`comments`, `createdAt`, `id`, `isPinned`, `labels`, `milestone`, `number`,
`projectItems`, `state`, `stateReason`, `title`, `updatedAt`, `url`.

**Warning:** `id` from `gh issue view --json id` is the **node ID** (a
string like `I_kwDOOakz...`), not the database ID. See the ID cheat sheet
at the bottom.

### Update

```bash
gh issue edit NUMBER --repo OWNER/REPO \
  --title "New title" \
  --body "New body" \
  --add-label "backend" \
  --remove-label "frontend" \
  --milestone "v2.0"
```

### Close / reopen

```bash
gh issue close NUMBER --repo OWNER/REPO --reason "completed"
gh issue reopen NUMBER --repo OWNER/REPO
```

Close reasons: `completed`, `not planned`, `duplicate`.

---

## 2. Dependencies

REST only — no `gh` CLI commands exist for dependencies.

Dependencies track "blocked by" / "blocking" relationships between issues.
Use these instead of writing "Depends on" in issue bodies.

**Limit:** 50 issues per relationship type per issue.

**Critical:** The REST API uses the issue's **database ID** (integer), not
the issue number. Always fetch it first:

```bash
gh api /repos/OWNER/REPO/issues/NUMBER --jq '.id'
```

### List what blocks an issue

```bash
gh api /repos/OWNER/REPO/issues/NUMBER/dependencies/blocked_by \
  -H "X-GitHub-Api-Version: 2026-03-10"
```

Returns an array of issue objects that block this issue.

### List what an issue blocks

```bash
gh api /repos/OWNER/REPO/issues/NUMBER/dependencies/blocking \
  -H "X-GitHub-Api-Version: 2026-03-10"
```

Returns an array of issue objects that this issue blocks.

### Add a "blocked by" dependency

```bash
BLOCKER_DB_ID=$(gh api /repos/OWNER/REPO/issues/BLOCKER_NUMBER --jq '.id')

gh api --method POST \
  /repos/OWNER/REPO/issues/BLOCKED_NUMBER/dependencies/blocked_by \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -F "issue_id=$BLOCKER_DB_ID"
```

### Remove a "blocked by" dependency

```bash
BLOCKER_DB_ID=$(gh api /repos/OWNER/REPO/issues/BLOCKER_NUMBER --jq '.id')

gh api --method DELETE \
  /repos/OWNER/REPO/issues/BLOCKED_NUMBER/dependencies/blocked_by/$BLOCKER_DB_ID \
  -H "X-GitHub-Api-Version: 2026-03-10"
```

### Check dependencies before moving a ticket

```bash
BLOCKERS=$(gh api /repos/OWNER/REPO/issues/NUMBER/dependencies/blocked_by \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  --jq '[.[] | select(.state == "open")] | length')

if [ "$BLOCKERS" -gt 0 ]; then
  echo "WARNING: $BLOCKERS open blockers remain"
  gh api /repos/OWNER/REPO/issues/NUMBER/dependencies/blocked_by \
    -H "X-GitHub-Api-Version: 2026-03-10" \
    --jq '.[] | select(.state == "open") | "#\(.number) \(.title)"'
fi
```

---

## 3. Sub-issues

REST only — no `gh` CLI commands exist for sub-issues.

Sub-issues create parent/child hierarchies. Up to 100 children per parent,
8 levels of nesting. Children inherit the parent's Project and Milestone.

Like dependencies, the REST API uses **database IDs** for write operations.

### List sub-issues of a parent

```bash
gh api /repos/OWNER/REPO/issues/PARENT_NUMBER/sub_issues \
  -H "X-GitHub-Api-Version: 2026-03-10"
```

### Get the parent of an issue

```bash
gh api /repos/OWNER/REPO/issues/CHILD_NUMBER/parent \
  -H "X-GitHub-Api-Version: 2026-03-10"
```

Returns the parent issue object, or 404 if none.

### Add a sub-issue

```bash
CHILD_DB_ID=$(gh api /repos/OWNER/REPO/issues/CHILD_NUMBER --jq '.id')

gh api --method POST \
  /repos/OWNER/REPO/issues/PARENT_NUMBER/sub_issues \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -F "sub_issue_id=$CHILD_DB_ID"
```

### Remove a sub-issue

```bash
CHILD_DB_ID=$(gh api /repos/OWNER/REPO/issues/CHILD_NUMBER --jq '.id')

gh api --method DELETE \
  /repos/OWNER/REPO/issues/PARENT_NUMBER/sub_issue \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -F "sub_issue_id=$CHILD_DB_ID"
```

Note: the DELETE path is `/sub_issue` (singular), while POST uses
`/sub_issues` (plural).

### Reprioritize a sub-issue

```bash
CHILD_DB_ID=$(gh api /repos/OWNER/REPO/issues/CHILD_NUMBER --jq '.id')
AFTER_DB_ID=$(gh api /repos/OWNER/REPO/issues/AFTER_NUMBER --jq '.id')

gh api --method PATCH \
  /repos/OWNER/REPO/issues/PARENT_NUMBER/sub_issues/priority \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -F "sub_issue_id=$CHILD_DB_ID" \
  -F "after_id=$AFTER_DB_ID"
```

Specify exactly one of `after_id` or `before_id` (not both). Omit both to
move to the top of the list.

---

## 4. Projects

Primarily `gh` CLI. REST fallback for bulk reads.

### List projects

```bash
gh project list --owner OWNER
```

### View a project

```bash
gh project view PROJECT_NUMBER --owner OWNER --format json
```

### List fields and their options

```bash
gh project field-list PROJECT_NUMBER --owner OWNER --format json
```

For single-select fields (like Status), the response includes each option's
`id` and `name`. These option IDs go into the `.ghproject` file.

### List project items

```bash
gh project item-list PROJECT_NUMBER --owner OWNER --format json --limit 100
```

### Add an issue to a project

**Items must be added to the project before any field can be set.**

```bash
ITEM_ID=$(gh project item-add PROJECT_NUMBER \
  --owner OWNER \
  --url "https://github.com/OWNER/REPO/issues/NUMBER" \
  --format json --jq '.id')
```

Save `ITEM_ID` — you need it for all subsequent field updates. This is a
project-item ID, different from the issue number or database ID.

### Set a single-select field (e.g. Status, Priority, Size)

```bash
gh project item-edit \
  --project-id PROJECT_ID \
  --id ITEM_ID \
  --field-id FIELD_ID \
  --single-select-option-id OPTION_ID
```

Get `PROJECT_ID`, `FIELD_ID`, and `OPTION_ID` from the `.ghproject` file.

### Set other field types

```bash
# Text
gh project item-edit --project-id PID --id ITEM --field-id FID --text "value"

# Number
gh project item-edit --project-id PID --id ITEM --field-id FID --number 42

# Date
gh project item-edit --project-id PID --id ITEM --field-id FID --date 2026-06-01

# Iteration
gh project item-edit --project-id PID --id ITEM --field-id FID --iteration-id OPT_ID

# Clear any field
gh project item-edit --project-id PID --id ITEM --field-id FID --clear
```

### Remove an item from a project

```bash
gh project item-delete PROJECT_NUMBER --owner OWNER --id ITEM_ID
```

### Create a field

```bash
gh project field-create PROJECT_NUMBER --owner OWNER \
  --name "Status" \
  --data-type SINGLE_SELECT \
  --single-select-options "Todo,In Progress,Done"
```

Data types: `TEXT`, `SINGLE_SELECT`, `DATE`, `NUMBER`.

### Delete a field

```bash
gh project field-delete --id FIELD_ID
```

### Update field options (DANGER — GraphQL required)

This is the **one operation** that requires GraphQL. No REST or CLI
equivalent exists. The mutation replaces **all** options atomically — if you
omit an existing option, it gets deleted and every item using that option
silently loses its value.

Step 1 — fetch current options to preserve them:

```bash
gh project field-list PROJECT_NUMBER --owner OWNER --format json
```

Step 2 — include every existing option alongside your changes:

```bash
FIELD_NODE_ID="PVTSSF_..."  # from field-list output

gh api graphql -f query="
  mutation {
    updateProjectV2Field(input: {
      fieldId: \"$FIELD_NODE_ID\"
      singleSelectOptions: [
        { name: \"Existing\", color: GRAY, description: \"Keep this\" },
        { name: \"New\", color: GREEN, description: \"Added\" }
      ]
    }) {
      projectV2Field { ... on ProjectV2SingleSelectField { name } }
    }
  }"
```

Every option needs `name` (string), `color` (enum), and `description`
(string). Include the `id` field on existing options to preserve their
identity; omit `id` for new options.

### Projects REST API (alternative for bulk reads)

The REST endpoints use integer field IDs (not the `PVTSSF_` strings from
the CLI/GraphQL).

```bash
# List items
gh api /orgs/OWNER/projectsV2/PROJECT_NUMBER/items \
  -H "X-GitHub-Api-Version: 2026-03-10"

# List fields
gh api /orgs/OWNER/projectsV2/PROJECT_NUMBER/fields \
  -H "X-GitHub-Api-Version: 2026-03-10"

# Update item fields (uses integer field IDs from /fields)
gh api --method PATCH \
  /orgs/OWNER/projectsV2/PROJECT_NUMBER/items/ITEM_ID \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  --input - <<EOF
{
  "fields": [
    { "id": FIELD_ID_INT, "value": "OPTION_ID_STRING" }
  ]
}
EOF
```

For user-owned projects, replace `/orgs/OWNER/` with `/users/USERNAME/`.

---

## 5. Issue types

REST only — no `gh` CLI commands exist for issue types.

Issue types (Task, Bug, Feature, etc.) are organization-level.

### List issue types

```bash
gh api /orgs/ORG/issue-types \
  -H "X-GitHub-Api-Version: 2026-03-10"
```

### Create an issue type

```bash
gh api --method POST /orgs/ORG/issue-types \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -f name="Epic" \
  -f description="Multi-week tracking of work" \
  -F is_enabled=true \
  -f color="green"
```

### Update an issue type

```bash
gh api --method PUT /orgs/ORG/issue-types/TYPE_ID \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -f name="Epic" \
  -f description="Updated description" \
  -F is_enabled=true \
  -f color="blue"
```

### Delete an issue type

```bash
gh api --method DELETE /orgs/ORG/issue-types/TYPE_ID \
  -H "X-GitHub-Api-Version: 2026-03-10"
```

### Set an issue's type

```bash
gh api --method PATCH /repos/OWNER/REPO/issues/NUMBER \
  -H "X-GitHub-Api-Version: 2026-03-10" \
  -f type="Feature"
```

The `type` value matches the issue type name (e.g. `"Task"`, `"Bug"`,
`"Feature"`). Set to empty string to clear.

---

## 6. Labels

All via `gh` CLI.

### List labels

```bash
gh label list --repo OWNER/REPO
```

### Create a label

```bash
gh label create "area-frontend" \
  --repo OWNER/REPO \
  --color "0075ca" \
  --description "Frontend work"
```

### Edit a label

```bash
gh label edit "old-name" \
  --repo OWNER/REPO \
  --name "new-name" \
  --color "0075ca" \
  --description "Updated"
```

### Delete a label

```bash
gh label delete "stale" --repo OWNER/REPO --yes
```

### Add / remove labels on an issue

```bash
gh issue edit NUMBER --repo OWNER/REPO \
  --add-label "area-frontend" \
  --remove-label "area-backend"
```

---

## 7. Milestones

CRUD via REST. Assignment via `gh` CLI.

### List milestones

```bash
gh api /repos/OWNER/REPO/milestones \
  --jq '.[] | {number, title, state, due_on}'
```

### Create a milestone

```bash
gh api --method POST /repos/OWNER/REPO/milestones \
  -f title="v2.0" \
  -f description="Second release" \
  -f due_on="2026-06-01T00:00:00Z"
```

### Update a milestone

```bash
gh api --method PATCH /repos/OWNER/REPO/milestones/MILESTONE_NUMBER \
  -f title="v2.1" \
  -f description="Updated"
```

### Delete a milestone

```bash
gh api --method DELETE /repos/OWNER/REPO/milestones/MILESTONE_NUMBER
```

### Assign a milestone to an issue

```bash
gh issue edit NUMBER --repo OWNER/REPO --milestone "v2.0"
```

To clear: `--milestone ""`.

---

## ID cheat sheet

Different APIs need different identifiers for the same issue. Getting them
mixed up is the #1 source of silent failures.

| ID type | Looks like | How to get it | Used by |
|---------|-----------|---------------|---------|
| Issue number | `42` | URL, `gh issue list` | `gh issue` commands, URLs, REST paths |
| Database ID | `4409157457` | `gh api /repos/O/R/issues/42 --jq '.id'` | Dependencies, sub-issues (REST write ops) |
| Project item ID | `PVTI_lADO...` | `gh project item-add ... --jq '.id'` | `gh project item-edit`, `item-delete` |
| Field ID (CLI) | `PVTSSF_lADO...` | `gh project field-list`, `.ghproject` file | `gh project item-edit --field-id` |
| Field ID (REST) | `263507592` | `gh api .../projectsV2/N/fields` | REST `PATCH .../items/ID` |
| Option ID | `f75ad846` | `gh project field-list`, `.ghproject` file | `--single-select-option-id` |

**Common mistake:** `gh issue view --json id` returns the **node ID** (a
string like `I_kwDOOakz...`), not the database ID. For database IDs,
always use `gh api /repos/OWNER/REPO/issues/NUMBER --jq '.id'`.
