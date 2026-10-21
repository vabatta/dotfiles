# Teaching workspace

The multi-session mode of **teach**. Treat `.agent/teaching/` as a teaching workspace.

## Files

- `.agent/teaching/MISSION.md` records the reason the user is interested. It grounds every lesson. If it is unclear, ask why before the first lesson. When no one answers, infer it from the repo and record that as an assumption.
- `.agent/teaching/reference/*.html` holds compressed learnings, cheat sheets, algorithms, syntax, and glossaries. They are rarely revisited, so capture the essence.
- `.agent/teaching/RESOURCES.md` lists trusted resources to ground teaching. Do not trust parametric knowledge before this is populated. On the first lesson, create the missing files and populate it from the repo and its docs.
- `.agent/teaching/learning-records/*.md` records what the user learned, like ADRs, the non-obvious insights. Number them `0001-<slug>.md`. They compute the zone of proximal development.
- `.agent/teaching/lessons/*.html` holds lessons, one self-contained HTML page teaching one tightly scoped thing tied to the mission. This is the primary unit.
- `.agent/teaching/assets/*` holds reusable components. Read this before authoring and never inline a reusable thing.
- `.agent/teaching/NOTES.md` records the user's teaching preferences.

## Principles

- Knowledge, skills, and wisdom are different. Teach knowledge first, then practice the skill in a tight feedback loop, and delegate wisdom to a community.
- Fluency strength is not storage strength. Build storage with desirable difficulty, retrieval practice, spacing, and interleaving.
- Keep each lesson in the zone of proximal development, difficult enough to be engaging and no more.
- Quizzes and retrieval practice apply here only. Quizzes give every answer the same number of words and characters, so formatting gives no clues.
