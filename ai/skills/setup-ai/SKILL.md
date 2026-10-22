---
name: setup-ai
description: "Explains and updates which model each role uses in the shared AI workflow. Use when changing the model policy or asking how model selection works."
---

# Setup AI

The active policy is owned by the runtime at
`$XDG_CONFIG_HOME/ai/model-policy.json`, or at `~/.config/ai/model-policy.json`
when `XDG_CONFIG_HOME` is unset. Nix does not manage that file. The checked-in
`templates/model-policy.json` is only the bootstrap shape used when no runtime
policy exists.

The policy has a `default` and four role preferences:

- `exploration` for finding things out.
- `implementation` for building or changing code.
- `judgment` for reviewing, judging, or deciding.
- `prose` for text.

The default is the session model:
every role follows the conversation unless the policy pins it. Role values come
in four forms:

- `inherit`, keep the current conversation's model.
- `"<model>"`, pin the role to one model. Write the full host model id,
  `<provider-id>/<model-id>`, so the value also names the provider block that
  serves it: `isoquant/glm-5.3-flash` pins the `isoquant` provider. A bare
  model id is ambiguous when two provider blocks serve the same model. Model
  ids can contain slashes; the provider prefix is matched against the host's
  configured provider ids.
- `["<model>", "<model>", ...]`, a diversity pool, used per
  **delegate**. Entries must be distinct models, not the same model through two
  providers; two ids that differ only in the provider prefix do not buy
  diversity.
- `{ "model": "<model>", "provider": {...}, "headers": {...} }`, a pinned
  object. `model` is required; `provider` carries host routing options and
  `headers` extra request headers, both passed through verbatim. For an
  OpenRouter block, `provider` follows the OpenRouter routing contract:
  `order: ["z.ai"]` with `"allow_fallbacks": false` pins the upstream
  provider; `zdr` and `data_collection` pin on data policy. The object is
  host-specific: the pin is inert when the named block is not a router with
  that vocabulary. It is still valid policy; the host just has nothing to
  apply it to.

A pinned object may appear anywhere a model string can, including inside a
diversity pool. The provider and headers vocabulary is the host's contract,
not the validator's: `scripts/verify_policy.py` is the only validator and
enforces shape only, and the host rejects what it does not understand.

## Resolution

`resolve_policy.py` resolves the effective policy in a lookup order:

1. `.ai/model-policy.json` at the project root, found via `git rev-parse
   --show-toplevel`. This file is committed repo state: it is shared with the
   team, reviewed like the repo's `AGENTS.md`, and not managed by Nix. Use it
   when a project needs a different model mix than the personal default.
2. The runtime policy at `$XDG_CONFIG_HOME/ai/model-policy.json`, or
   `~/.config/ai/model-policy.json` when `XDG_CONFIG_HOME` is unset. Personal
   and runtime-owned, not managed by Nix.
3. This skill's `templates/model-policy.json` bootstrap, so resolution works on
   a fresh machine before the runtime policy exists.

The resolved file is validated by `verify_policy.py`; resolution fails loudly
on an invalid or missing file rather than degrading. `--role <name>` prints the
role's first model id (the pinned object's `model`, or the first pool entry's),
dropping `provider` and `headers`. `--source` prints the file the policy
resolved from. `--policy <path>` resolves one file directly.

The three modes are just values, not schema. Session mode is every role set to
`inherit`. Catalog mode pins each role to the host's model slug. Auto mode sets a
role to the host's own auto-routing alias.

When changing a preference:

1. Find the model ids the active host accepts, from its config or model list
   command. Done when each requested id is confirmed. For an id that cannot be
   confirmed, keep that role at `inherit` and tell the user which exact id to
   supply (see **principle-never-block-on-the-human**).
2. Pick the target: the runtime policy for a personal change, or
   `.ai/model-policy.json` for a project change. Copy the current effective file,
   or `templates/model-policy.json` when none exists, and edit the copy.
3. Generate and validate from this skill directory (never `python3 -I`, the
   scripts import a sibling module):

   ```sh
   cd <skill dir>
   python3 scripts/generate_policy.py --template <edited.json> [--output <target>]
   python3 scripts/verify_policy.py [<target>]
   python3 scripts/resolve_policy.py --source
   python3 scripts/resolve_policy.py --role <role>
   ```

   `--output` defaults to the runtime policy; `verify_policy.py` takes the same
   default. Run the last command once per changed role. Done when
   `verify_policy.py` prints `valid AI model policy`.
4. Confirm the effective policy: `--source` names the file just written, and
   each changed role prints the requested model. Done when both match. A
   different source means a higher-priority file overrides the edit; edit that
   file instead.

The generator creates the parent directory and writes stable, sorted JSON. Do
not copy model identifiers from a different client without checking that the
active host accepts them. A harness that cannot spawn more than one model
degrades to the session model for every role, per **delegate**.
