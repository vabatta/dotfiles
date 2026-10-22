# Issue Templates Reference

These templates live in `.github/ISSUE_TEMPLATE/`. The raw YAML files are
bundled in `assets/ISSUE_TEMPLATE/` and can be copied directly into a repo.

## Idea (`idea.yml`)

For raw sketches that haven't been brainstormed or scoped yet.

| Field              | Required | Purpose                                        |
|-------------------|----------|------------------------------------------------|
| **What**           | yes      | The capability or problem. One paragraph is fine. |
| **Why**            | no       | Who benefits, what it unblocks, why it matters.  |
| **Open questions** | no       | Things to figure out during brainstorming.       |

## Feature (`feature.yml`)

For scoped work ready to enter the pipeline.

| Field               | Required | Purpose                                              |
|---------------------|----------|------------------------------------------------------|
| **Context**          | yes      | Who hits this problem, what they can't do today, why it matters. |
| **Approach**         | yes      | How we're solving it — key design decisions, not implementation code. |
| **Edge cases**       | no       | Things the spec writer and implementer need to consider. |
| **Technical notes**  | no       | Key files, error codes, schema changes. Use GitHub issue relationships for dependencies instead of listing them here. |

## Idea → Feature conversion

When an idea is brainstormed into a real feature, rewrite the issue body:

1. Move **What** content into **Context**, expanding with the brainstorming findings
2. Write **Approach** from the decisions made during brainstorming
3. Move **Open questions** that were answered into **Edge cases** or **Technical notes**
