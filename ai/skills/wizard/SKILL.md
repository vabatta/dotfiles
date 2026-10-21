---
name: wizard
description: "Generates an interactive bash wizard that walks a human through steps only they can perform. Use when provisioning infrastructure, setting up credentials or CI secrets, walking a third-party dashboard, or running a one-off migration or cutover. Do not use it for steps the agent can perform itself."
---

# Wizard

A wizard is a bash script that walks a human step by step through a manual procedure. It opens URLs, gives exact click and copy instructions, captures values, writes them to `.env` or GitHub secrets, and shows stage N of M. Add `pause` or `confirm` where a stage needs a gate.

It is ephemeral by default. Author it at `.agent/wizards/<slug>.sh`, delete it when done, and commit it into the repo's scripts directory only when the procedure should be repeatable.

The user experience is solved by `scripts/template.sh`. It provides stage progress, confirmation gates, cross-platform URL opening, hidden secret entry, idempotent `.env` upserts, and `gh secret` and `gh variable` writes. Your job is to scope the procedure and author the stages below the `STAGES` marker. Do not hand-edit the library above that marker.

## Process

1. Scope. Read the repository, including `.env*`, the README, docker-compose, and `.github/workflows/*`. Every `secrets.*` or `vars.*` is a value the wizard must produce. With no CI, the scoped value table is the source of truth. For a migration, map current to target and name the irreversible acts. Show the ordered stages and the values they produce, then confirm, or record the plan as an assumption when no one answers. Done when every stage is named and every value has a source, a destination, and whether it is secret or public.
2. Map each stage's journey. Give the exact URL, path, or value. Never invent a UI. Read the docs when unsure, and when they are unreachable print the step as unverified in the wizard and flag it in the handoff. Done when every stage has a URL, path, or value, or an unverified mark.
3. Author. Copy `scripts/template.sh` and write one `stage` per step in dependency order. Use the helpers `banner`, `stage`, `say`, `step`, `note`, `warn`, `open_url`, `ask`, `ask_secret`, `write_env`, `set_secret`, `set_var`, `pause`, `confirm`, and `finish`. Set `TOTAL_STAGES` before the first `stage`, and keep one focused task per stage. `write_env` warns when the target file is not gitignored, so add `.env` to `.gitignore` first. Done when each scoped stage has a `stage` block.
4. Verify. Run `bash -n` and `shellcheck` (without it, `nix run nixpkgs#shellcheck`), and `chmod +x`. Do not run it end to end, since it waits on browsers and input. Instead trace statically that every captured value lands where it was scoped and that every secret name matches a CI `secrets.*` when CI exists. Done when `bash -n` and `shellcheck` pass and the trace finds no unplaced value.

For the up-front scoping of a plan in general, use **plan-work**.
